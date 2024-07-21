--!strict
--!native

--[[
	Visulie Player
	
	Play() --> plays the animation from the beginning
	Pause() --> stops the animation at the current time
	Resume() --> resumes the animation at the current time
	
	ForEachWithTag() --> updates all keyframes with the specified tag
	SetOrigin() --> translates all positioned objects relative to the new origin
	SetTime() --> sets the animation time and renders once
	
	all assets are instantiated the moment the animation is created
]]

--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RS = game:GetService("RunService")

--// Dependencies
local ease = require(script.ease)
local Signal = require(script.Signal)
local lerper = require(script.lerper)

--// Variables
export type animationData = {
	length: number,
	init: {
		[string]: { --> instance name
			class: string,
			parent: string?,
		},
	},
	vfx: {
		[string]: { --> instance name
			[string]: { --> property name
				[number]: propertyData,
			},
		},
	},
	emit: { --> for particle emitters only
		[string]: {
			[number]: emitData,
		},
	},
	sfx: { --> for sounds only
		[string]: {
			[number]: soundData,
		}, --> [soundName]: play time
	},
	events: {
		[number]: eventData,
	},
}
export type propertyData = { --> keyframe number
	time: number, --> time
	ease: string, --> easing function
	value: any, --> value
	tag: string?,
}
export type emitData = {
	time: number, --> time
	value: number, --> quantity
	tag: string?,
}
export type keyframeData = {
	time: number,
	value: any,
	tag: string?,
	[string]: any,
}
export type soundData = {
	time: number,
	value: "Play" | "Pause" | "Resume" | "Stop",
}
export type eventData = { --> event name
	time: number,
	list: {
		[number]: {
			name: string,
			param: string?,
		},
	},
}
export type keyframeItem = {
	time: number,
	[string]: any,
}

local instance_values: { [string]: true } = {
	["Attachment0"] = true,
	["Attachment1"] = true,
	["Adornee"] = true,
	["Part0"] = true,
	["Part1"] = true,
	["PrimaryPart"] = true,
}
local relative_values: { [string]: true } = {
	["CFrame"] = true,
	["WorldPivot"] = true,
}

local function fastFind(sorted: { keyframeItem }, t: number): number
	-->> binary search for keyframe data, where [current <= t < next]
	local low, high = 1, #sorted
	while low <= high do
		local mid = (low + high) // 2
		if sorted[mid].time <= t then
			low = mid + 1
		else
			high = mid - 1
		end
	end
	return low - 1
end

local Visulie = {}
Visulie.__index = Visulie
function Visulie.new(animinstance: string, OverrideContainer: Instance?)
	local depthRecord: { [number]: { string } } = {}
	local liveObjects: { [string]: any } = {}

	local data: animationData = require(ReplicatedStorage.Animations[animinstance])
	for instanceName, objectInit in data.init do
		-->> creating live objects
		local NewObject = Instance.new(objectInit.class)
		NewObject.Name = instanceName
		liveObjects[instanceName] = NewObject

		-->> animation update order depth search
		local depth = 1
		local parent = liveObjects.parent
		while parent do
			depth += 1
			parent = data.init[parent].parent
		end
		if not depthRecord[depth] then
			depthRecord[depth] = {}
		end
		table.insert(depthRecord[depth], instanceName)
	end

	-->> creating order
	local order = {}
	for _, list in depthRecord do
		for _, instanceName in list do
			table.insert(order, instanceName)
		end
	end

	-->> retrieving tags
	local taggedKeyframes: { [string]: { keyframeData } } = {}
	for objectName, objectAnims in data.vfx do
		for propertyName, propertyKeyframes in objectAnims do
			for _, propertyData in propertyKeyframes do
				if not propertyData.tag then
					continue
				end
				if not taggedKeyframes[propertyData.tag] then
					taggedKeyframes[propertyData.tag] = {}
				end
				table.insert(taggedKeyframes[propertyData.tag], propertyData)
			end
		end
	end
	for _, objectEmissions in data.emit do
		for _, emitKeyframe in objectEmissions do
			if not emitKeyframe.tag then
				continue
			end
			if not taggedKeyframes[emitKeyframe.tag] then
				taggedKeyframes[emitKeyframe.tag] = {}
			end
			table.insert(taggedKeyframes[emitKeyframe.tag], emitKeyframe)
		end
	end

	local NewAnimation = setmetatable({
		_ObjectContainer = OverrideContainer or workspace,

		_TaggedKeyframes = taggedKeyframes,
		_Data = data,
		_Elapsed = 0,
		_PreviousTime = 0,
		_LiveObjects = liveObjects,
		_Runner = nil :: RBXScriptConnection?,
		_EventListeners = {} :: { [string]: Signal.Signal },
		_UpdateOrder = order,

		Completed = Signal.new(),

		_Origin = CFrame.new(0, 0, 0),
		Framerate = -1,
		PlackbackSpeed = 1,
		Loops = false,
	}, Visulie)
;
	(NewAnimation :: Visulie):_Reset()

	return NewAnimation
end

-->> (player)
function Visulie._LoadInstances(self: Visulie)
	if self._Runner then
		return
	end
	for instanceName, objectInit in self._Data.init do
		self._LiveObjects[instanceName].Parent = objectInit.parent and self._LiveObjects[objectInit.parent]
			or self._ObjectContainer
	end
end
function Visulie._Apply(self: Visulie, instanceName: string, propertyName: string, value: any)
	local ModifyObject = self._LiveObjects[instanceName]
	if ModifyObject:IsA("PVInstance") and relative_values[propertyName] then --> world space transformation special case
		local relative = self._Origin
		local parent = self._Data.init[instanceName].parent
		if parent and self._LiveObjects[parent]:IsA("PVInstance") then
			relative = self._LiveObjects[parent]:GetPivot()
		end
		self._LiveObjects[instanceName]:PivotTo(relative:ToWorldSpace(value))
	elseif instance_values[propertyName] then --> instance value special case
		ModifyObject[propertyName] = value and self._LiveObjects[value]
	else
		ModifyObject[propertyName] = value
	end
end
function Visulie._Reset(self: Visulie)
	-- for instanceName, instanceAnimations in self._Data.vfx do
	-- 	for propertyName, propertyKeyframes in instanceAnimations do
	-- 		self._LiveObjects[instanceName].Parent = nil
	-- 		self:_Apply(instanceName, propertyName, propertyKeyframes[1].value)
	-- 	end
	-- end

	if self._Runner then
		self._Runner:Disconnect()
		self._Runner = nil
	end

	self._Elapsed = 0
	self._PreviousTime = -math.huge
end
function Visulie.Play(self: Visulie, destroyOnCompletion: boolean?)
	self:_Reset()
	self:_LoadInstances()
	self:_StartPlaying(destroyOnCompletion)
end
function Visulie._StartPlaying(self: Visulie, destroyOnCompletion: boolean?)
	-- if self._Runner then
	-- 	self._Runner:Disconnect()
	-- end

	self._Runner = RS.Heartbeat:Connect(function(dt: number)
		self._Elapsed += dt * self.PlackbackSpeed

		-->> framerate buffer
		if self.Framerate ~= -1 then
			if self._Elapsed < self._PreviousTime + self.PlackbackSpeed / self.Framerate then
				return
			end
		end

		-->> end of animation
		if self._Elapsed > self._Data.length then
			print("ended")
			-->> rendering the last frame
			self._Elapsed = self._Data.length
			self:_Render()
			-- ;
			-- (self._Runner :: RBXScriptConnection):Disconnect()
			if self.Loops then --> looping
				local surplus = self._Elapsed - self._Data.length
				self:_Reset()
				self._Elapsed += surplus --> subtracting by the anim length accounts for lag
				self:Resume()
			else
				if destroyOnCompletion then
					self:Destroy()
				else
					self:_Reset()
				end
			end
			self.Completed:Fire()

			return
		end

		self:_Render()

		self._PreviousTime = self._Elapsed
	end)
end
function Visulie._Render(self: Visulie)
	-->> animation values
	for _, instanceName in self._UpdateOrder do
		if not self._Data.vfx[instanceName] then
			continue
		end
		for propertyName, propertyAnimData in self._Data.vfx[instanceName] do
			local propertyIndex = fastFind(propertyAnimData, self._Elapsed)

			-->> setting up values
			local currentValue
			local nextValue
			local alpha
			local easingFunc
			if propertyIndex == 0 then --> start
				currentValue = propertyAnimData[1].value
				nextValue = propertyAnimData[1].value
				alpha = self._Elapsed / propertyAnimData[1].time
				easingFunc = propertyAnimData[1].ease
			elseif propertyIndex == #propertyAnimData then --> end
				currentValue = propertyAnimData[propertyIndex].value
				nextValue = currentValue
				alpha = 1
				easingFunc = propertyAnimData[propertyIndex].ease
			else
				currentValue = propertyAnimData[propertyIndex].value
				nextValue = propertyAnimData[propertyIndex + 1].value
				alpha = (self._Elapsed - propertyAnimData[propertyIndex].time)
					/ (propertyAnimData[propertyIndex + 1].time - propertyAnimData[propertyIndex].time)
				easingFunc = propertyAnimData[propertyIndex + 1].ease
			end

			self:_Apply(
				instanceName,
				propertyName,
				lerper[typeof(currentValue)](currentValue, nextValue, ease[easingFunc](alpha))
			)
		end
	end

	-->> particle emit
	for particleName, emitData in self._Data.emit do
		local emitKeyframe = emitData[fastFind(emitData, self._Elapsed)]
		if emitKeyframe and emitKeyframe.time >= self._PreviousTime and emitKeyframe.time < self._Elapsed then
			self._LiveObjects[particleName]:Emit(emitKeyframe.value)
		end
	end

	-->> sounds
	for soundName, soundData in self._Data.sfx do
		local soundKeyframe = soundData[fastFind(soundData, self._Elapsed)]
		if soundKeyframe and soundKeyframe.time >= self._PreviousTime and soundKeyframe.time < self._Elapsed then
			self._LiveObjects[soundName][soundKeyframe.value](self._LiveObjects[soundName])
		end
	end

	-->> events
	local eventGroup = self._Data.events[fastFind(self._Data.events, self._Elapsed)]
	if eventGroup and eventGroup.time >= self._PreviousTime and eventGroup.time < self._Elapsed then
		for _, eventData in eventGroup.list do
			if self._EventListeners[eventData.name] then
				self._EventListeners[eventData.name]:Fire(eventData.param)
			end
		end
	end
end
function Visulie.Pause(self: Visulie)
	if self._Runner then
		self._Runner:Disconnect()
		self._Runner = nil
	end
end
function Visulie.Resume(self: Visulie)
	self:_LoadInstances()
	self:_StartPlaying()
end
function Visulie.Stop(self: Visulie)
	self:_Reset()
end
--<< (player)

-->> (utility)
function Visulie.ForEachWithTag(self: Visulie, tagName: string, callback: (value: any) -> any)
	if not self._TaggedKeyframes[tagName] then
		error(`{tagName} is not a valid tag in the animation`)
	end

	-->> for each keyframe with the specified tag, the value can be alteredby returning another value
	for _, keyframe in self._TaggedKeyframes[tagName] do
		keyframe.value = callback(keyframe.value)
	end
end
function Visulie.SetOrigin(self: Visulie, newOrigin: CFrame)
	self._Origin = newOrigin
	if not self._Runner then
		self:_Render()
	end
end
function Visulie.SetTime(self: Visulie, newTime: number)
	self._Elapsed = newTime
	self:_Render()
	self:_LoadInstances()
	self._PreviousTime = newTime
end
function Visulie.FitTime(self: Visulie, totalTime: number)
	-->> adjusts the animation speed so the absolute time is the specified time
	self.PlackbackSpeed = self._Data.length / totalTime
end
function Visulie.GetEventReachedSignal(self: Visulie, eventName: string): Signal.Signal
	if not self._EventListeners[eventName] then
		self._EventListeners[eventName] = Signal.new()
	end
	return self._EventListeners[eventName]
end
--<< (utility)

function Visulie.Destroy(self: Visulie)
	if self._Runner then
		self._Runner:Disconnect()
		self._Runner = nil
	end
	self:Pause()
	for _, LoadedInstance in self._LiveObjects do
		LoadedInstance:Destroy()
	end
	for _, EventListener in self._EventListeners do
		EventListener:Destroy()
	end
end

export type Visulie = typeof(Visulie.new({} :: animationData))

return Visulie

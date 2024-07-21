--!strict

--[[
	datatypes reference: https://create.roblox.com/docs/reference/engine/datatypes/ColorSequence
]]

local function evalNumberSequence(sequence: NumberSequence, time: number)
	if time == 0 then
		return sequence.Keypoints[1].Value, sequence.Keypoints[1].Envelope
	elseif time == 1 then
		return sequence.Keypoints[#sequence.Keypoints].Value, sequence.Keypoints[#sequence.Keypoints].Envelope
	end

	for i = 1, #sequence.Keypoints - 1 do
		local current = sequence.Keypoints[i]
		local next = sequence.Keypoints[i + 1]
		if time >= current.Time and time < next.Time then
			local alpha = (time - current.Time) / (next.Time - current.Time)
			return
				current.Value + (next.Value - current.Value) * alpha,
				current.Envelope + (next.Envelope - current.Envelope) * alpha
		end
	end

	return 1, 1 --> value, envelope
end
local function evalColorSequence(sequence: ColorSequence, time: number)
	if time == 0 then
		return sequence.Keypoints[1].Value
	elseif time == 1 then
		return sequence.Keypoints[#sequence.Keypoints].Value
	end

	for i = 1, #sequence.Keypoints - 1 do
		local current = sequence.Keypoints[i]
		local next = sequence.Keypoints[i + 1]
		if time >= current.Time and time < next.Time then
			local alpha = (time - current.Time) / (next.Time - current.Time)
			return current.Value:Lerp(next.Value, alpha)
		end
	end

	return Color3.new(1, 1, 1) --> value
end

return {
	
	-->> userdata
	Axes = function(a: Axes, b: Axes, alpha: number)
		return alpha < 1 and a or b
	end,
	BrickColor = function(a: BrickColor, b: BrickColor, alpha: number)
		return alpha < 1 and a or b
	end,
	CFrame = function(a: CFrame, b: CFrame, alpha: number)
		return a:Lerp(b, alpha)
	end,
	Color3 = function(a: Color3, b: Color3, alpha: number)
		return a:Lerp(b, alpha)
	end,
	ColorSequence = function(a: ColorSequence, b: ColorSequence, alpha: number)
		local pointTimes = {}
		for _, Keypoint in a.Keypoints do
			table.insert(pointTimes, Keypoint.Time)
		end
		for _, Keypoint in b.Keypoints do
			if not table.find(pointTimes, Keypoint.Time) then
				table.insert(pointTimes, Keypoint.Time)
			end
		end

		table.sort(pointTimes)

		local keypoints = {}
		for _, pointTime in pointTimes do
			table.insert(
				keypoints,
				ColorSequenceKeypoint.new(
					pointTime,
					evalColorSequence(a, pointTime):Lerp(evalColorSequence(b, pointTime), alpha)
				)
			)
		end

		return ColorSequence.new(keypoints)
	end,
	EnumItem = function(a: EnumItem, b: EnumItem, alpha: number)
		return alpha < 1 and a or b
	end,
	Faces = function(a: Faces, b: Faces, alpha: number)
		return alpha < 1 and a or b
	end,
	NumberRange = function(a: NumberRange, b: NumberRange, alpha: number)
		return NumberRange.new(
			a.Min + (b.Min - a.Min) * alpha,
			a.Max + (b.Max - a.Max) * alpha
		)
	end,
	NumberSequence = function(a: NumberSequence, b: NumberSequence, alpha: number)
		local pointTimes = {}
		for _, Keypoint in a.Keypoints do
			table.insert(pointTimes, Keypoint.Time)
		end
		for _, Keypoint in b.Keypoints do
			if not table.find(pointTimes, Keypoint.Time) then
				table.insert(pointTimes, Keypoint.Time)
			end
		end

		table.sort(pointTimes)

		local keypoints = {}
		for _, pointTime in pointTimes do
			local valA, envA = evalNumberSequence(a, pointTime)
			local valB, envB = evalNumberSequence(b, pointTime)
			table.insert(
				keypoints,
				NumberSequenceKeypoint.new(
					pointTime,
					valA + (valB - valA) * alpha,
					envA + (envB - envA) * alpha
				)
			)
		end

		return NumberSequence.new(keypoints)
	end,
	Ray = function(a: Ray, b: Ray, alpha: number)
		return alpha < 1 and a or b
	end,
	Rect = function(a: Rect, b: Rect, alpha: number)
		return Rect.new(
			a.Min:Lerp(b.Min, alpha),
			a.Max:Lerp(b.Max, alpha)
		)
	end,
	UDim = function(a: UDim, b: UDim, alpha: number)
		return UDim.new(
			a.Scale + (b.Scale - a.Scale) * alpha,
			a.Offset + (b.Offset - a.Offset) * alpha
		)
	end,
	UDim2 = function(a: UDim2, b: UDim2, alpha: number)
		return a:Lerp(b, alpha)
	end,
	Vector2 = function(a: Vector2, b: Vector2, alpha: number)
		return a:Lerp(b, alpha)
	end,
	Vector3 = function(a: Vector3, b: Vector3, alpha: number)
		return a:Lerp(b, alpha)
	end,
	
	-->> primitives
	boolean = function(a: boolean, b: boolean, alpha: number)
		if alpha < 1 then
			return a
		else
			return b
		end
	end,
	number = function(a: number, b: number, alpha: number)
		return a + (b - a) * alpha
	end,
	["nil"] = function(a: string?, b: string?, alpha: number) --> string? because instance values are string?
		if alpha < 1 then
			return a
		else
			return b
		end
	end,
	string = function(a: string?, b: string?, alpha: number) --> string? because instance values are string?
		return alpha < 1 and a or b
	end,
}
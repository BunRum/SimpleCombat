local ReplicatedStorage = game:GetService("ReplicatedStorage")
local types = require(ReplicatedStorage.Modules.types)
local object = require(ReplicatedStorage.Modules.object)
local util = {}
-- types

function util:cardialConvert(dir)
	local angle = math.atan2(dir.X, -dir.Z)
	local quarterTurn = math.pi / 2
	angle = -math.round(angle / quarterTurn) * quarterTurn
	local newX = -math.sin(angle)
	local newZ = -math.cos(angle)
	if math.abs(newX) <= 1e-10 then
		newX = 0
	end
	if math.abs(newZ) <= 1e-10 then
		newZ = 0
	end
	return Vector3.new(newX, 0, newZ)
end

function characters()
    
end

function characterradius(position, radius, exclude, callback, visualizeHitbox)

	local op = OverlapParams.new()
	op.FilterType = Enum.RaycastFilterType.Exclude
	op.FilterDescendantsInstances = exclude
	local partsinbound = workspace:GetPartBoundsInRadius(position, radius, op) --parameters are  (position: Vector3, radius: number, overlapParams: OverlapParams)
	local hits = {} -- so we dont repeat the damage again since character have multiple parts
	for _, part in partsinbound do
		local ancestorModel = part:FindFirstAncestorOfClass("Model")
		local ancestorHumanoid = ancestorModel and ancestorModel:FindFirstChildOfClass("Humanoid")
		if ancestorModel and ancestorHumanoid and table.find(hits, ancestorModel.Name) == nil then
			table.insert(hits, ancestorModel.Name)
			callback(ancestorModel)
		end
	end
end

function characterbox(position, radius, exclude, callback, visualizeHitbox)
    
end

function util:charactersInArea(
	position: Vector3,
	areaType: "Box" | "Circle",
	exclude: { Instance },
	callback: (character: types.Character) -> (),
	settings: { visualizeHitbox: boolean, times: number, timesInterval: number, radius: numbe }
)
	settings = settings or {}
	settings.times = settings.times or 1
	settings.timesInterval = settings.timesInterval or 0

	for i = 1, settings.times, 1 do
		if areaType == "Circle" then
            characterradius(position, settings.radius, exclude, callback, settings.visualizeHitbox)
		else

		end

		task.wait(settings.timesInterval or 0)
	end
end

return util

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

function characterradius(position, radius, exclude, callback)
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

function util:charactersInRadius(
	position: Vector3,
	radius,
	exclude: { Instance },
	callback: (character: types.Character) -> (),
	settings: { visualizeHitbox: boolean, times: number, timesInterval: number }
)
	settings = settings or {}
    print(settings)
	if settings.visualizeHitbox then
		local part: Part = object.new({
			className = "Part",
		})
		part.Shape = Enum.PartType.Ball
		part.Size = Vector3.new(radius * 2, radius * 2, radius * 2)
		part.Position = position
		part.CanCollide = false
		part.Transparency = 0.9
		part.Color = Color3.new(1, 0.505882, 0.505882)
		part.Anchored = true
	end

    if settings.times ~= nil then
        for i = 1, settings.times, 1 do
            characterradius(position, radius, exclude, callback)
            task.wait(settings.timesInterval)
        end
    end

end

return util

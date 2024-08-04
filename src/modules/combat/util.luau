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

function charhits(partsinbound: {BasePart}, callback: () -> ())
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

function util:charactersInArea(
	position: Vector3 | CFrame,
	areaType: "Box" | "Circle",
	exclude: { Instance },
	callback: (character: types.Character) -> (),
	settings: { visualizeHitbox: boolean, times: number, timesInterval: number, radius: number, size: Vector3 }
)
	settings = settings or {}
	settings.times = settings.times or 1
	settings.timesInterval = settings.timesInterval or 0

    local op = OverlapParams.new()
	op.FilterType = Enum.RaycastFilterType.Exclude
	op.FilterDescendantsInstances = exclude

	for i = 1, settings.times, 1 do
        if settings.visualizeHitbox then
            local part: Part = object.new({
                className = "Part",
            })
            part.Shape = if areaType == "Circle" then Enum.PartType.Ball else Enum.PartType.Block
            part.Size = if areaType == "Circle" then Vector3.new(settings.radius*2, settings.radius*2, settings.radius*2) else settings.size
            -- part.Position = position
            if typeof(position) == "Vector3" then 
                part.Position = position
            else
                part.CFrame = position
            end
            part.CanCollide = false
            part.Transparency = 0.9
            part.Color = Color3.new(1, 0.505882, 0.505882)
            part.Anchored = true
        end
		if areaType == "Circle" then
            charhits(workspace:GetPartBoundsInRadius(position, settings.radius, op), callback)
		else
            charhits(workspace:GetPartBoundsInBox(position, settings.size, op), callback)
		end

		task.wait(settings.timesInterval or 0)
	end
end

return util

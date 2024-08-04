local ReplicatedStorage = game:GetService("ReplicatedStorage")
local types = require(ReplicatedStorage.Modules.types)
local object = require(ReplicatedStorage.Modules.object)
local util = {}
-- types


function util:cardialConvert(dir)
    local angle = math.atan2(dir.X, -dir.Z)
    local quarterTurn = math.pi/2
    angle = -math.round(angle/quarterTurn) * quarterTurn
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

function util:charactersInRadius(position: Vector3, radius, exclude: {Instance}, callback: (character: types.Character) -> (), visualize: boolean)

    local part: Part = object.new({
        className = "Part"
    })
    part.Shape = Enum.PartType.Ball
    part.Size = Vector3.new(radius * 2, radius * 2, radius * 2)
    part.Position = position
    part.CanCollide = false
    part.Transparency = 0.9
    part.Color = Color3.new()
    part.Anchored = true

    local op = OverlapParams.new()
    op.FilterType = Enum.RaycastFilterType.Exclude
    op.FilterDescendantsInstances = exclude
    local partsinbound = workspace:GetPartBoundsInRadius(position, radius, op) --parameters are  (position: Vector3, radius: number, overlapParams: OverlapParams)
    local hits = {} -- so we dont repeat the damage again since character have multiple parts
    for _, part in partsinbound do
        -- print(part)
        local ancestorModel = part:FindFirstAncestorOfClass("Model")
        local ancestorHumanoid = ancestorModel and ancestorModel:FindFirstChildOfClass("Humanoid")
        if ancestorModel and ancestorHumanoid and table.find(hits, ancestorModel.Name) == nil then
            table.insert(hits, ancestorModel.Name)
            -- ancestorHumanoid:TakeDamage(10)
            callback(ancestorModel)
        end
    end
end

return util
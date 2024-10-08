local ReplicatedStorage = game:GetService("ReplicatedStorage")
local types = require(ReplicatedStorage.Modules.types)
local object = require(ReplicatedStorage.Modules.object)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
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

function charhits(partsinbound: { BasePart }, callback: () -> ())
	local hits = {} -- so we dont repeat the damage again since character have multiple parts
	for _, part in partsinbound do
		local ancestorModel = part:FindFirstAncestorOfClass("Model")
		local ancestorHumanoid = ancestorModel and ancestorModel:FindFirstChildOfClass("Humanoid")
		if ancestorModel and ancestorHumanoid and table.find(hits, ancestorModel) == nil then
			table.insert(hits, ancestorModel)
			callback(ancestorModel)
		end
	end
end

function util:charactersInArea(
	position: Vector3 | CFrame,
	areaType: "Box" | "Circle",
	exclude: { Instance },
	callback: (character: types.Character) -> (),
	settings: {
		visualizeHitbox: boolean,
		times: number,
		timesInterval: number,
		radius: number,
		size: Vector3,
	}
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
				lifetime = 0.1,
			})
			part.Shape = if areaType == "Circle" then Enum.PartType.Ball else Enum.PartType.Block
			part.Size = if areaType == "Circle"
				then Vector3.new(settings.radius * 2, settings.radius * 2, settings.radius * 2)
				else settings.size
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

function util:castRay(origin, direction, exclude: table, p: Part)
	-- workspace:ray

	if typeof(exclude) == "Instance" then
		p = exclude
		exclude = nil
	end

	p = p or object.new({
			className = "Part",
			Parent = workspace,
		})
	p.Anchored = true
	p.CanCollide = false

	exclude = exclude or {}

	local params = RaycastParams.new()
	params.IgnoreWater = true
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.RespectCanCollide = true
	table.insert(exclude, p)
	params.FilterDescendantsInstances = exclude
	-- local direction = origin + direction * length
	local raycastResult = workspace:Raycast(origin, direction, params)

	local m = (origin - direction).Magnitude
	p.Size = Vector3.new(0.05, 0.05, m)
	p.CFrame = CFrame.lookAt(origin, direction) * CFrame.new(0, 0, -m / 2)

	return raycastResult
end

function util:damage(char: Model, dmg: number)
	if variableModule:get({char.Name, "isBlocking"}) == true then
		return
	end
	local humanoid: Humanoid = char.Humanoid
	humanoid:TakeDamage(dmg)
end

return util

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local log = require(ReplicatedStorage.Modules.log)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local effects = require(ReplicatedStorage.Modules.effects)
-- local object = require(ReplicatedStorage.Modules.object)
-- local variableModule = require(ReplicatedStorage.Modules.variableModule)

local newmain = BridgeNet2.ServerBridge("newmain")
-- script.
newmain:Connect(function(player, move: string)
	if move == "One" then
		effects:sendAll({
			animation = "anim",
			looped = false,
		})

		local radius = 3
		local op = OverlapParams.new()
		op.FilterType = Enum.RaycastFilterType.Exclude
		op.FilterDescendantsInstances = { player.Character }
		-- local part: Part = Instance.new("Part")
		
		-- part.Shape = Enum.PartType.Ball
		-- part.Size = Vector3.new(radius * 2, radius * 2, radius * 2)
		-- part.Position = player.Character:GetPivot().Position
		-- part.CanCollide = false
		-- part.Transparency = 0.9
		-- part.Anchored = true
		local partsinbound = workspace:GetPartBoundsInRadius(player.Character:GetPivot().Position, radius, op) --parameters are  (position: Vector3, radius: number, overlapParams: OverlapParams)
		local hits = {} -- so we dont repeat the damage again since character have multiple parts
		for _, part in partsinbound do
			-- print(part)
			local ancestorModel = part:FindFirstAncestorOfClass("Model")
			local ancestorHumanoid = ancestorModel and ancestorModel:FindFirstChildOfClass("Humanoid")
			if ancestorModel and ancestorHumanoid and table.find(hits, ancestorModel.Name) == nil then
				table.insert(hits, ancestorModel.Name)
				ancestorHumanoid:TakeDamage(10)
			end
		end
	end
end)

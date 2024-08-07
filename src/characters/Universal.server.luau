local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local types = require(ReplicatedStorage.Modules.types)
local log = require(ReplicatedStorage.Modules.log)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local combat = require(ReplicatedStorage.Modules.combat)

local m1Bridge: types.sbridge = variableModule:set({ "bridges", "m1" }, BridgeNet2.ReferenceBridge("m1"))
local dashBridge: types.sbridge = variableModule:set({ "bridges", "dash" }, BridgeNet2.ReferenceBridge("dash"))
local uppercutBridge: types.sbridge =
	variableModule:set({ "bridges", "uppercut" }, BridgeNet2.ReferenceBridge("uppercut"))
local maxM1Combo = 4

m1Bridge:Connect(function(player)
	combat.util:charactersInArea(
		player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 0, -5))),
		"Box",
		{ player.Character },
		function(Character)
			Character.Humanoid:TakeDamage(5)
		end,
		{
			visualizeHitbox = false,
			size = Vector3.new(5, 5, 5),
		}
	)
end)

dashBridge:Connect(function(player, content)
	task.wait(0.2)
end)

uppercutBridge:Connect(function(player, content)
	local inAir = variableModule:get({player.Name, "inAir"}) or false
	combat.util:charactersInArea(
		player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 0, -5))),
		"Box",
		{ player.Character },
		function(Character)
			if inAir == false then
				task.spawn(function()
                    variableModule:set({player.Name, "inAir"}, true)
					local lv: LinearVelocity =
						combat.physics:applyVelocity(player.Character.HumanoidRootPart, Vector3.new(0, 50, 0))
					task.wait(0.5)
					lv.VectorVelocity = Vector3.new()
				end)
			end
			local lv: LinearVelocity = combat.physics:applyVelocity(Character.HumanoidRootPart, Vector3.new(0, 50, 0))
			task.wait(0.5)
			lv.VectorVelocity = Vector3.new()
		end,
		{
			visualizeHitbox = true,
			size = Vector3.new(5, 5, 5),
		}
	)
end)

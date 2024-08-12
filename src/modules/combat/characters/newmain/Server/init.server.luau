local ReplicatedStorage = game:GetService("ReplicatedStorage")
local log = require(ReplicatedStorage.Modules.log)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local effects = require(ReplicatedStorage.Modules.effects)
local combat = require(ReplicatedStorage.Modules.combat)
local newmain = BridgeNet2.ServerBridge("newmain")

newmain:Connect(function(player: Player, move: string)
	if move == "One" then
		effects:sendAll({
			animation = "anim",
			looped = false,
		})
		combat.util:charactersInArea(player.Character:GetPivot():ToWorldSpace(CFrame.new(Vector3.new(0, 0, -5))), "Box", {player.Character}, function(Character) 
			combat.util:damage(Character, 5)
		end, {
			visualizeHitbox = true,
			times = 10,
			timesInterval = 0.1,
			size = Vector3.new(5, 5, 5)
		})
	end
end)

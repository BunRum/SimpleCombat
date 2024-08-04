local ReplicatedStorage = game:GetService("ReplicatedStorage")
local log = require(ReplicatedStorage.Modules.log)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local effects = require(ReplicatedStorage.Modules.effects)
local combat = require(ReplicatedStorage.Modules.combat)
-- local object = require(ReplicatedStorage.Modules.object)
-- local variableModule = require(ReplicatedStorage.Modules.variableModule)

local newmain = BridgeNet2.ServerBridge("newmain")
-- script.
newmain:Connect(function(player: Player, move: string)
	if move == "One" then
		effects:sendAll({
			animation = "anim",
			looped = false,
		})
		combat.util:charactersInRadius(player.Character:GetPivot().Position, 10, {player.Character}, function() 
		
		end)
	end
end)

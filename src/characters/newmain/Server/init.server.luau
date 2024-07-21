local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local ServerStorage = game:GetService("ServerStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local effects = require(ReplicatedStorage.Modules.effects)
local variableModule = require(ReplicatedStorage.Modules.variableModule)

local newmain = BridgeNet2.ServerBridge("newmain")
-- script.
newmain:Connect(function(player, move: string)

	if move == "One" then
		effects:sendAll({
			animation = "anim",
			looped = true
		})
	end

end)

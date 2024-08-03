local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local combatModule = require(ReplicatedStorage.Modules.combat)
local log = require(ReplicatedStorage.Modules.log)
local variables = require(ReplicatedStorage.Modules.variables)
----------------------------------------------------


Players.PlayerAdded:Connect(function(player)
    variableModule:set({player.Name, "character"}, combatModule:getCharacter("newmain"))
    variableModule:set({player.Name, "stunned"}, false)
end) 
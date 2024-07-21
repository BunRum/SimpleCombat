local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
--
local variableModule = require(ReplicatedStorage.Modules.variableModule)
----------------------------------------------------


Players.PlayerAdded:Connect(function(player)
    variableModule:playerAdded(player)
end) 
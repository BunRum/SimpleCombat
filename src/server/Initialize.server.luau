local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
-- ReplicatedStorage

BridgeNet2.ReferenceBridge("variable").OnServerInvoke = function()
	return variableModule.variables
end

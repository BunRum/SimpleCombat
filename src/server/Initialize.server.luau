local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local variables = require(ReplicatedStorage.Modules.variables)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local log = require(ReplicatedStorage.Modules.log)
-- ReplicatedStorage

BridgeNet2.ServerBridge("getvariables").OnServerInvoke = function(plr)
	-- log("funny server says", variableModule.variables)
	log(plr.Name, "called for variables")
	-- since this was called assume that on the client the variables listener was started
	-- variableModule.loadedListeners[plr.Name]
	table.insert(variableModule.loadedListeners, plr.Name)

	return variables
end

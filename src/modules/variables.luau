local ReplicatedStorage = game:GetService("ReplicatedStorage")
local utils = require(ReplicatedStorage.Modules.util)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local log = require(ReplicatedStorage.Modules.log)
local tableModule = require(ReplicatedStorage.Modules.tableModule)
local variables = {}

local hasvariables = false
local attached = false


function variableBridgeClient(content)
    log("message from server (send)", content)
    if content.message == "set" then
        -- log("args are", content.args)
        tableModule:set(variables, table.unpack(content.args))
    end
end

-- log(utils:checkSide() == "Client")
if utils:checkSide() == "Client" then
	if hasvariables == false then
		hasvariables = true
        local variableBridge = BridgeNet2.ClientBridge("variable")
        log("adding listener for variables from server")
        variableBridge:Connect(variableBridgeClient)
        variableBridge.Logging = true
        ---
        log("no varialbes get them nowww")
		warn("variables empty, invoking server now")
        local getVariables = BridgeNet2.ClientBridge("getvariables")
        -- variableBridge.
		variables = getVariables:InvokeServerAsync()
		log("got variables from server", variables)
	end
end

return variables
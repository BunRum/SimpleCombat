local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local tableModule = require(ReplicatedStorage.Modules.tableModule)
local variables = require(ReplicatedStorage.Modules.variables)
local util = require(ReplicatedStorage.Modules.util)
local log = require(ReplicatedStorage.Modules.log)
local variableModule = {}

local variableBridge = BridgeNet2.ReferenceBridge("variable")

function variableModule:get(...): any
	return tableModule:get(variables, ...)
end

variableModule.loadedListeners = {}

function getLoadedListeners()
	if #variableModule.loadedListeners == 0 then
		repeat
			task.wait()
			log("waiting for players")
		until #variableModule.loadedListeners > 0
	end

	return variableModule.loadedListeners
end

function variableModule:set(...): any
	local args = ...
	if util:checkSide() == "Server" then
		-- log(tableModule:pack(...), table.pack(...))
		task.spawn(function()
			variableBridge:Fire(getLoadedListeners(), {
				message = "set",
				args = tableModule:pack(args),
			})
			log("sending to players")
		end)
	end
	return tableModule:set(variables, ...)
end

function variableModule:watch(...)
	tableModule:watch(variables, ...)
end

function variableModule:waitfor(...)
	return tableModule:waitfor(variables, ...)
end

return variableModule

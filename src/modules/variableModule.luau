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
		-- log("waiting for players")
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
			-- log("sending to players")
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

-- function p(a, ...)
--     local args = table.pack(...)
--     local value
--     local ab = {}

--     if typeof(args[1]) == "table" then
--         for index, arg in pairs(args[1]) do
--             if index ~= "n" then
--                 table.insert(a, arg)
--             end
--         end

--         -- Properly handle argument insertion
--         for i = 1, args.n do
--             if args[i] ~= nil then
--                 table.insert(ab, args[i])
--             end
--         end

--         value = ab
--     else
--         -- Handle case when args[1] is not a table
--         for i = 1, args.n do
--             table.insert(ab, args[i])
--         end
--         value = ab
--     end

--     return a, value
-- end

function variableModule:var(arguments: { string })
    local f = {}

    local function safeConcat(tbl)
        local strTbl = {}
        for _, v in ipairs(tbl) do
            if typeof(v) == "string" then
                table.insert(strTbl, v)
            else
                table.insert(strTbl, tostring(v)) -- Convert non-strings to strings
            end
        end
        return table.concat(strTbl, ", ")
    end

    function f:get(...)
        local a = table.pack(...)
        local updatedArguments = { table.unpack(arguments) }

        for i = 1, a.n do
            local b = a[i]
            if i == 1 and typeof(b) == "table" then
                for _, arg in pairs(b) do
                    table.insert(updatedArguments, arg)
                end
            end
        end

        -- print("Updated Arguments:", safeConcat(updatedArguments))
        return variableModule:get(updatedArguments)
    end

    function f:set(...)
        local a = table.pack(...)
        local updatedArguments = { table.unpack(arguments) }
        local other = {}

        for i = 1, a.n do
            local b = a[i]
            if i == 1 and typeof(b) == "table" then
                for _, arg in pairs(b) do
                    table.insert(updatedArguments, arg)
                end
            else
                table.insert(other, b)
            end
        end

        -- print("Updated Arguments:", safeConcat(updatedArguments))
        -- print("Other Arguments:", safeConcat(other))
        return variableModule:set(updatedArguments, table.unpack(other))
    end

    return f
end



return variableModule

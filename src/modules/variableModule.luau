local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local combat = require(ReplicatedStorage.Modules.combat)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local bridgenettypes = require(ReplicatedStorage.Packages._Index["ffrostflame_bridgenet2@1.0.0"].bridgenet2.PublicTypes)

-- bridgenettypes
export type bridge = bridgenettypes.Bridge
export type sbridge = bridgenettypes.ServerBridge
export type cbridge = bridgenettypes.ClientBridge
export type characterType = combat.characterType

local variableModule = {}

variableModule.variables = {}

local variableBridge = BridgeNet2.ReferenceBridge("variable")

function checkSide()
	return RunService:IsServer() and "Server" or RunService:IsClient() and "Client"
end

function variableModule:playerAdded(player: Player)
	-- variableBridge:Fire(player, {
	-- 	message = "joined",
	-- 	table = variableModule.variables,
	-- })
	variableModule:set(player, "character", "newmain")
	variableModule:set(player, "plr", player)
end

function parseArgs(...)
	local args = table.pack(...)
	local parsedArgs = {}

	for index, value in ipairs(args) do
		if typeof(value) == "table" and #args == 1 then
			for i, v in ipairs(value) do
				-- print(type(v))
				if type(v) == "table" and i ~= #v then
					for _, v2 in pairs(v) do
						table.insert(parsedArgs, v2)
					end
				else
					table.insert(parsedArgs, v)
				end
			end
		else
			if index ~= "n" then
				table.insert(parsedArgs, value)
			end
		end
	end

	for index, value in pairs(parsedArgs) do
		if typeof(value) == "Instance" and index ~= #args then
			parsedArgs[index] = value.Name
		end
	end

	return parsedArgs
end

function variableModule:get(...): any
	local args = parseArgs(...)

	if checkSide() == "Client" then
		if args[1] == "local" then
			args[1] = Players.LocalPlayer.Name
		end
		if next(variableModule.variables) == nil then
			-- print("you are nil")
			local new = variableBridge:InvokeServerAsync()
			variableModule.variables = new
		end
	end

	local parsedstring = ""
	for _, arg in args do
		if parsedstring == "" then
			parsedstring = `{arg}`
		else
			parsedstring = `{parsedstring},{arg}`
		end
	end

	local list = {}

	for index, value in pairs(variableModule.variables) do
		if string.match(index, parsedstring) then
			list[index] = value
		end
	end

	local function hang(indexhigh, high, value)
		local crikey = {}
		table.remove(high, indexhigh)
		local hasNext = high[indexhigh + 1]
		-- print(high, "hasnext")
		if hasNext then
			crikey[high[1]] = hang(1, high, value)
		else
			if #high == 0 then
				crikey = value
			else
				crikey[high[1]] = value
			end
		end

		return crikey
	end

	local function combine(table1, table2)
		if table1 == nil then
			table1 = {}
		end
		local newtable = table.clone(table1)

		if type(table2) ~= "table" then
			-- print(table1, table2)
			newtable = table2
		else
			for index, value in table2 do
				if newtable[index] ~= nil then
					newtable[index] = combine(newtable[index], value)
				else
					newtable[index] = value
				end
			end
		end

		return newtable
	end

	local as = {}
	for index, value in pairs(list) do
		local high = string.split(index, ",")
		if #args ~= 0 then
			high = table.move(high, #args, #high, 1, {})
		end
		local firstHigh = high[1]
		--[[
		
		high would be like this
		{"map1", name"}

		]]
		local hangedValues = hang(1, high, value)
		-- we send in the first value of "high" ("map1") in this case
		as[firstHigh] = combine(as[firstHigh], hangedValues)
		-- then combine

		-- print(index, value)
	end

	local returnedValue

	if args[#args] ~= nil then
		returnedValue = as[args[#args]]
	else
		returnedValue = as
	end

	local function bridgeChecker(tbl)
		if type(tbl) == "table" and tbl["_name"] ~= nil and tbl["_maxRate"] ~= nil then
			-- print("you bridge")
			tbl = BridgeNet2.ClientBridge(tbl["_name"])
		elseif type(tbl) == "table" then
			-- print("is table but no _name or _ratemap")
			for index, value in pairs(tbl) do
				tbl[index] = bridgeChecker(value)
			end
		end
		return tbl
	end

	returnedValue = bridgeChecker(returnedValue)

	return returnedValue
end

function variableModule:set(...): any
	-- arg stuff
	local args = parseArgs(...)

	if checkSide() == "Server" then
		if variableBridge.OnServerInvoke == nil then
			variableBridge.OnServerInvoke = function()
				return variableModule.variables
			end
		end
		variableBridge:Fire(BridgeNet2.AllPlayers(), {
			message = "set",
			args = table.pack(...),
			-- tbl: varia
		})
	end

	-- print(args)

	local value = args[#args]
	local modifier = args[#args - 1]
	print(modifier)
	if modifier and type(modifier) == "string" and string.sub(modifier, 1, 1) == "." then
		table.remove(args)
	end

	table.remove(args, #args)

	if checkSide() == "Client" then
		if args[1] == "local" then
			args[1] = Players.LocalPlayer.Name
		end
	end

	local parsedstring = ""
	for _, arg in args do
		if parsedstring == "" then
			parsedstring = `{arg}`
		else
			parsedstring = `{parsedstring},{arg}`
		end
	end

	local function t(a, b)
		for i, v in pairs(a) do
			local defi = `{b},{i}`
			if type(v) == "table" then
				t(v, defi)
			else
				variableModule.variables[defi] = v
				-- print(defi, v)
			end
		end
	end

	local gothrough = true
	local parsetable = true
	if modifier == "character" then
		value = combat:getCharacter(value)
		parsetable = false
	elseif modifier == ".+=" then
		local numba = variableModule:get(args)
		if numba == nil then
			numba = 0
		end
		value = numba + value
	elseif modifier == ".a" then
		if variableModule.variables[parsedstring] == nil then
			variableModule.variables[parsedstring] = {}
		end
		gothrough = false
		table.insert(variableModule.variables[parsedstring], value)
	end

	if type(value) == "table" and parsetable then
		t(value, parsedstring)
	else
		if gothrough == true then
			variableModule.variables[parsedstring] = value
		end
	end

	return value
end

function variableModule:watch(...)
	local args = parseArgs(...)
	-- local callba
	local callback: any = args[#args]
	table.remove(args, #args)

	local initial = variableModule:get(args)
	-- print(initial, "initial", initial == initial)
	return RunService.Heartbeat:Connect(function()
		local newValue = variableModule:get(args)
		-- print(initial, newValue)
		if initial ~= newValue then
			callback(initial, newValue)
			initial = newValue
		end
	end)
end

function variableModule:attach()
	variableBridge:Connect(function(content)
		if content.message == "set" then
			-- print(content, " you man")
			-- variableModule.variables = variableBridge:InvokeServerAsync()
			-- print("set that supreme ", content.args)
			-- print("supreme", test(content.args))
			print(variableModule:set(content.args), content.args)
			-- print(variableModule.variables)
		end
	end)
end

return variableModule

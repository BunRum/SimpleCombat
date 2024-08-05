local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local util = require(ReplicatedStorage.Modules.util)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local animationPlayer = require(ReplicatedStorage.Modules.animationPlayer)
local playerModule = require(ReplicatedStorage.Modules.player)
local log = require(ReplicatedStorage.Modules.log)
local queue = require(ReplicatedStorage.Modules.queue)
local tbl = {}


-- we have tailored the tables to our special format

local function hang(indexhigh, high, value)
	local crikey = {}
	table.remove(high, indexhigh)
	local hasNext = high[indexhigh + 1]
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

local function bridgeChecker(tbl)
    if type(tbl) == "table" and tbl["_name"] ~= nil and tbl["_maxRate"] ~= nil then
        tbl = BridgeNet2.ReferenceBridge(tbl["_name"])
    elseif type(tbl) == "table" then
        for index, value in pairs(tbl) do
            if index ~= "__index" then
                tbl[index] = bridgeChecker(value)
            end
        end
    end
    return tbl
end

local function playerChecker(tbl)
    if type(tbl) == "table" and tbl["module"] and tbl["Player"] then
        tbl = playerModule.New(tbl["Player"])
    elseif type(tbl) == "table" then
        for index, value in pairs(tbl) do
            if index ~= "__index" then
                tbl[index] = playerChecker(value)
            end
        end
    end
    return tbl
end


function tbl:get(tbl: table, arguments: {string})
    -- log(arguments)
    if arguments == nil then
        arguments = {}
    end

    if util:checkSide() == "Client" then
		if arguments[1] == "local" then
			arguments[1] = Players.LocalPlayer.Name
		end
	end

    local list = {}
    for index, value in pairs(tbl) do
		if string.match(index, table.concat(arguments, ",")) then
			list[index] = value
		end
	end
    -- log(list)

    local function doe()
		local as = {}
		for index, value in pairs(list) do
			local high = string.split(index, ",")
			if #arguments ~= 0 then
				high = table.move(high, #arguments, #high, 1, {})
			end
			local firstHigh = high[1]
			local hangedValues = hang(1, high, value)
			as[firstHigh] = combine(as[firstHigh], hangedValues)
		end
	
		local returnedValue
	
		if arguments[#arguments] ~= nil then
			returnedValue = as[arguments[#arguments]]
		else
			returnedValue = as
		end

		return returnedValue
	end

	local returnedValue = doe()
	returnedValue = bridgeChecker(returnedValue)
    returnedValue = playerChecker(returnedValue)
	-- log(returnedValue)

	if Players:FindFirstChild(arguments[1]) and arguments[#arguments] == "character" then
		local plr: Player = Players:FindFirstChild(arguments[1])
		for index, move in pairs(returnedValue.moves) do
			returnedValue.moves[index].animation = animationPlayer.track(plr.Character, move.animation)
		end
	end
	return returnedValue
end

local modifiers = {
    ["a"] = function(tbl, value)
        if tbl == nil then
            tbl = {}
        end
        return table.insert(tbl, value)
    end,
    ["+="] = function(number, value)
		if number == nil then
			number = 0
		end
		number += value
        return number
    end
}

local setQueue = queue.new()

function set(tbl: table, arguments: {string},  modifier: string, value: any): any
	if util:checkSide() == "Client" then
		if arguments[1] == "local" then
			arguments[1] = Players.LocalPlayer.Name
		end
	end
	-- error(table, 1)
	if modifier ~= nil and value == nil then
		value = modifier
		modifier = nil
	end
	-- log(tbl, arguments, modifier, value)
	-- print(table.pack(...))
    arguments = table.concat(arguments, ",")
	-- log("universal", arguments)
    tbl[arguments] = if modifier then modifiers[modifier](tbl[arguments], value) else value
	return tbl[arguments]
end

function tbl:set(tbl: table, arguments: {string},  modifier: string, value: any): any
	return setQueue:enqueue(set, tbl, arguments, modifier, value)
end

function tbl:waitfor(...): any

	local timeStart = os.clock()
	local returnedValue = tbl:get(...)
	if returnedValue == nil then
		-- warn("we have to wait")
		repeat
			wait()
			warn("waiting for " , table.pack(...)[2], os.clock() - timeStart)
		until tbl:get(...) ~= nil
		returnedValue = tbl:get(...)
	else
		-- warn("we didnt have to wait")
	end

	-- warn("got the value")
	return returnedValue
end

function tbl:watch(...)
	local args = table.pack(...)
    args.n = nil
	local callback = args[#args]
	table.remove(args, #args)
    log("nello", args)
	local initial = tbl:get(table.unpack(args))
	-- print(initial, "initial", initial == initial)
	return RunService.Heartbeat:Connect(function()
		local newValue = tbl:get(table.unpack(args))
		-- print(initial, newValue)
		if initial ~= newValue then
			callback(initial, newValue)
			initial = newValue
		end
	end)
end

function tbl:pack(...)
	local packedTable = table.pack(...)
	packedTable.n = nil
	-- table.
	return packedTable
end

return tbl
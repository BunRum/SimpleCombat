--!strict

--[[
	This module is used to create custom events that function the
	same as bindables, but with the convienience or not using
	.Event:Fire() or .Event:Wait() etc.
--]]

--// Dependencies
local Connection = require(script.Connection)

local Signal = {}
Signal.__index = Signal
function Signal.new(): Signal 
	return setmetatable({
		_Connections = {}:: {(...any) -> nil},
		_Destroyed = false,
	}, Signal)
end
function Signal.Connect(self: Signal, func: (...any) -> nil): Connection
	if self._Destroyed then
		error("Attempt to connect to a destroyed signal")
	end
	table.insert(self._Connections, func)
	return Connection.new(self._Connections, func)
end
function Signal.Wait(self: Signal): (...any)
	if self._Destroyed then
		error("Attempt to connect to a destroyed signal")
	end
	
	local returns: {[number]: any}
	
	local func = function(...: any)
		returns = table.pack(...)
	end
	
	table.insert(self._Connections, func)
	
	repeat task.wait() until returns
	
	table.remove(self._Connections,
		table.find(self._Connections,
			func
		)
	)
	return table.unpack(returns)
end
function Signal.Fire(self: Signal, ...: any)
	if self._Destroyed then
		error("Attempt to fire a destroyed signal")
	end
	
	for _, func in ipairs(self._Connections) do
		task.spawn(func, ...)
	end
end
function Signal.Destroy(self: Signal)
	self._Destroyed = true
end

export type Signal = typeof(Signal.new())
export type Connection = Connection.Connection
return Signal
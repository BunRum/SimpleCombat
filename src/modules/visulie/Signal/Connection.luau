--!strict

local Connection = {}
Connection.__index = Connection
function Connection.new(tab: {(...any) -> nil}, func: (...any) -> nil)
	return setmetatable({
		_Table = tab,
		_Func = func
	}, Connection)
end
function Connection.Disconnect(self: Connection)
	table.remove(
		self._Table,
		table.find(
			self._Table,
			self._Func
		)
	)
end

export type Connection = typeof(
	Connection.new(
		{},
		function()
			
		end
	)
)

return Connection
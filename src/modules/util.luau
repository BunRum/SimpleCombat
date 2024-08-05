local RunService = game:GetService("RunService")
local util = {}
-- RunService
function util:checkSide(): "Server" | "Client"
	return RunService:IsServer() and "Server" or RunService:IsClient() and "Client"
end

function util:clearAll(instance: Instance)
	for _, value in instance:GetDescendants() do
		value:Destroy()
	end
end

function util:pack(...)
	local packedTable = table.pack(...)
	local parsedPack = {}
	for index, value in pairs(packedTable) do
		if index ~= "n" then
			table.insert(parsedPack, value)
		end
	end
	return parsedPack
end

function util:when(func, value)
	
end

return util
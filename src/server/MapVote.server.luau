local ReplicatedStorage = game:GetService("ReplicatedStorage")
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local maps = variableModule:set({ "maps" }, {
	map1 = {
		name = "smal",
		totalVotes = 0,
	},
	map2 = {
		name = "smal",
		totalVotes = 0,
	},
	map3 = {
		name = "smal",
		totalVotes = 0,
	},
})
-- bit3
local voteBridge: variableModule.sbridge = variableModule:set({"bridges", "vote"}, BridgeNet2.ReferenceBridge("vote"))
local notifyBridge: variableModule.sbridge = variableModule:set({ "bridges", "notify" }, BridgeNet2.ReferenceBridge("notify"))

print(variableModule.newvar)
voteBridge:Connect(function(player, map, donotify)
	-- print(`{player.Name} chose {map}`)
	local voted = variableModule:get("maps", "voted")

	if voted and voted[player.Name] then
		-- print("you already voted", voted[player.Name])
		if donotify then
			notifyBridge:Fire(player, {
				duration = 1,
				header = "Already voted",
				icon = "rbxassetid://11326670020",
				message = "you already voted",
			})
		end
		return
	end

	variableModule:set("maps", map, "totalVotes", ".+=", 1)
	variableModule:set("maps", map, "votes", ".a", player)
	variableModule:set("maps", "voted", player, map)
end)

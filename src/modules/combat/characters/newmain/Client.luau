local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local types = require(ReplicatedStorage.Modules.types)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
-- local newmain: types.weapon = {}
local bridge = BridgeNet2.ReferenceBridge("newmain")
return {
	[Enum.KeyCode.One] = function()
		local self = variableModule:var({ "local", "newmain" })
		-- print(self:get({ "omg" }))
		local plr: types.playerm = variableModule:get({ "local", "plr" })
		plr:Play("swing")


		
		-- self:set({ "omg" }, true)
	end,
}

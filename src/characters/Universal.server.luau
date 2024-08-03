local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local types = require(ReplicatedStorage.Modules.types)
local log = require(ReplicatedStorage.Modules.log)
local variableModule = require(ReplicatedStorage.Modules.variableModule)

local m1Bridge: types.sbridge  = variableModule:set({"bridges", "m1"}, BridgeNet2.ReferenceBridge("m1"))
local dashBridge: types.sbridge = variableModule:set({"bridges", "dash"}, BridgeNet2.ReferenceBridge("dash"))
local maxM1Combo = 4

m1Bridge:Connect(function(player, content)
    
end)




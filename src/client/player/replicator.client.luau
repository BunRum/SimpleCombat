local ReplicatedStorage = game:GetService("ReplicatedStorage")
local effects = require(ReplicatedStorage.Modules.effects)
-- local variableModule = require(ReplicatedStorage.Modules.variableModule)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local notify = require(ReplicatedStorage.Modules.notify)
local combat = require(ReplicatedStorage.Modules.combat)

print("replicator anno")
effects:attach()
-- variableModule:attach()

BridgeNet2.ClientBridge("notify"):Connect(function(content)
    notify:Notify(content)
end)

BridgeNet2.ClientBridge("velocity"):Connect(function(args)
    combat.physics:applyVelocity(table.unpack(args))
end)
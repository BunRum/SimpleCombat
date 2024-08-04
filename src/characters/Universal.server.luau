local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local types = require(ReplicatedStorage.Modules.types)
local log = require(ReplicatedStorage.Modules.log)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local combat = require(ReplicatedStorage.Modules.combat)

local m1Bridge: types.sbridge  = variableModule:set({"bridges", "m1"}, BridgeNet2.ReferenceBridge("m1"))
local dashBridge: types.sbridge = variableModule:set({"bridges", "dash"}, BridgeNet2.ReferenceBridge("dash"))
local maxM1Combo = 4

m1Bridge:Connect(function(player)
    combat.util:charactersInArea(player.Character:GetPivot():ToWorldSpace(CFrame.new(Vector3.new(0, 0, -5))), "Box", {player.Character}, function(Character) 
        Character.Humanoid:TakeDamage(10)
    end, {
        visualizeHitbox = true,
        size = Vector3.new(5, 5, 5)
    })
    workspace:Raycast()
end)

dashBridge:Connect(function(player, content)
    task.wait(0.2)
    
end)


-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local RunService = game:GetService("RunService")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local visulie = require(ReplicatedStorage.Modules.visulie)
local effects = {}

local replicator = BridgeNet2.ReferenceBridge("replicator")

function effects:sendAll(content)
    replicator:Fire(BridgeNet2.AllPlayers(), content)
end


-- --[[

-- content = {
--     animationType: (character)
-- }

-- ]]

function effects:Play(anim: string)
    local anim = visulie.new(anim)

    anim:Play(false)

    return anim
end

function effects:attach()
    replicator:Connect(function(content)
        -- print(content)
        -- Visulie
        local anim = visulie.new(content.animation)
        -- anim.
        anim.Loops = content.looped
        -- anim:FitTime(10)
        anim:Play()
        -- task.spawn(function()
        --     RunService.Heartbeat:Connect(function()
        --         anim:SetOrigin(Players.LocalPlayer.Character.PrimaryPart.CFrame)
        --     end)
        -- end)
        -- workspace.ChangeCharacter
    end)
end

return effects
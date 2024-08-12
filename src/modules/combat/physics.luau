local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local object = require(ReplicatedStorage.Modules.object)
local util = require(script.Parent.util)
local physics = {}

function physics:applyVelocity(obj: BasePart, target: Vector3, lifetime: number)
    local attachment: Attachment = object.new({
        className = "Attachment",
        name =  "velocityattachment",
        find = true,
        Parent = obj
    })
    -- print(lifetime)
    if obj:FindFirstChildOfClass("LinearVelocity") then
        obj:FindFirstChildOfClass("LinearVelocity"):Destroy()
    end
    local lv: LinearVelocity = object.new( {
        className = "LinearVelocity",
        Parent = obj,
        lifetime = lifetime,
        find = true,
    })
    -- lv.Visible = true
    lv.ForceLimitsEnabled = false
    lv.Attachment0 = attachment
    lv.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
    
    lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    lv.VectorVelocity = target
    return lv
    -- local aasd = obj.CFrame:PointToWorldSpace(target)
    -- local ti = TweenInfo.new(timeToReach)
    -- local tween = TweenService:Create(obj, ti, {CFrame = CFrame.new(target)})
    -- tween:Play()

    -- return tween
    -- return lv
end

function physics:sendFlying(char)
    local lv = physics:applyVelocity(char.HumanoidRootPart, Vector3.new(0,-25, 50))
    -- util:castRay(char.
    local p: Part = object.new({
        className = "Part",
        Parent = char,
    })
    p.Anchored = true
    p.CanCollide = false
    p.Material = Enum.Material.Neon
    p.Color = Color3.new(0.992156, 0.482352, 0.482352)
    local conn: RBXScriptConnection
    conn = RunService.PostSimulation:Connect(function()
        local origin = char.HumanoidRootPart.Position
        local direction = char.HumanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, -5, 0))
        local result = util:castRay(origin, direction, {char}, p)
        print(result)
        if result then
            lv:Destroy()
            conn:Disconnect()
        end
    end)

end

return physics
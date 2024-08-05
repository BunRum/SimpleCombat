local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local object = require(ReplicatedStorage.Modules.object)
local physics = {}

function physics:applyVelocity(obj: BasePart, target: Vector3, lifetime: number)
    local attachment: Attachment = object.new({
        className = "Attachment",
        name =  "velocityattachment",
        find = true,
        Parent = obj
    })
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
    lv.VectorVelocity = target+(target*lifetime)
    return lv
    -- local aasd = obj.CFrame:PointToWorldSpace(target)
    -- local ti = TweenInfo.new(timeToReach)
    -- local tween = TweenService:Create(obj, ti, {CFrame = CFrame.new(target)})
    -- tween:Play()

    -- return tween
    -- return lv
end
return physics
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local object = require(ReplicatedStorage.Modules.object)
local physics = {}

function physics:applyVelocity(obj: BasePart, from: Vector3, studs: number, timeToReach: number)
	local attachment: Attachment = object.new({
		className = "Attachment",
		name = "velocityattachment",
		find = true,
		Parent = obj,
	})
	local lv: LinearVelocity = object.new({
		className = "LinearVelocity",
		Parent = obj,
		lifetime = timeToReach,
		find = true,
	})
	-- lv.Visible = true
	lv.ForceLimitsEnabled = false
	lv.Attachment0 = attachment
	lv.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
	lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
	-- lv.VectorVelocity = ((timeToReach or 1)*target)

	-- Calculate the velocity needed to reach the target in the given time
	-- local startPosition = obj.Position
	-- local direction = (target - startPosition).Unit
	-- local distance = (target - startPosition).Magnitude
	-- local velocity = direction * (distance / (timeToReach or 1))

	lv.VectorVelocity = (from*studs)

	return lv
	-- local aasd = obj.CFrame:PointToWorldSpace(target)
	-- local ti = TweenInfo.new(timeToReach)
	-- local tween = TweenService:Create(obj, ti, {CFrame = CFrame.new(target)})
	-- tween:Play()

	-- return tween
	-- return lv
end
return physics

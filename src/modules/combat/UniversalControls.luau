local ReplicatedStorage = game:GetService("ReplicatedStorage")
local tableModule = require(ReplicatedStorage.Modules.tableModule)
local variables = require(ReplicatedStorage.Modules.variables)
local log = require(ReplicatedStorage.Modules.log)
local combatUtil = require(script.Parent.util)
local object = require(ReplicatedStorage.Modules.object)
local playerModule = require(ReplicatedStorage.Modules.player)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local physics = require(ReplicatedStorage.Modules.combat.physics)

local universalcontrols = {}

function M1Cooldown()
	local self = universalcontrols[Enum.UserInputType.MouseButton1]
	self.M1Stage = 0
	self.cooldown = true
	task.wait(2)
	self.cooldown = false
end

universalcontrols = {
	[Enum.UserInputType.MouseButton1] = {
		bridge = BridgeNet2.ReferenceBridge("m1"),
		func = function()
			local self = universalcontrols[Enum.UserInputType.MouseButton1]
			if self.cooldown then
				return
			end
			self.cooldown = true
			self.M1Stage += 1
			print(self.M1Stage)
			self.bridge:Fire()
			wait(0.1)
			self.cooldown = false
			local thisStage = self.M1Stage
			-- if stage (5) plus 1 (6) is greater than maxStages (5)
			if thisStage + 1 > self.maxStages then
				M1Cooldown()
			else
				task.delay(0.5, function()
					if thisStage == self.M1Stage then
						M1Cooldown()
					end
				end)
			end
		end,
		cooldown = false,
		M1Stage = 0,
		maxStages = 5,
	},
	[Enum.KeyCode.Q] = {
		bridge = BridgeNet2.ReferenceBridge("dash"),
		func = function()
			local self = universalcontrols[Enum.KeyCode.Q]
			if self.cooldown then
				return
			end
			-- self.cooldown = true
			self.bridge:Fire()
			local directionTable = {
				[Vector3.new(1, 0, 0)] = "right",
				[Vector3.new(-1, 0, 0)] = "left",
				[-Vector3.new(0, 0, 1)] = "forward",
				[-Vector3.new(0, 0, -1)] = "back",
			}
			local localPlayer: playerModule.type = tableModule:waitfor(variables, { "local", "plr" })
			local character = localPlayer.Player.Character
			local humanoidrootpart = character.HumanoidRootPart
			local humanoid = character.Humanoid
			local direction = humanoid.MoveDirection
			local animtoplay
			local localdir = humanoidrootpart.CFrame:VectorToObjectSpace(direction)
			local cardialdir = combatUtil:cardialConvert(direction)
			local localdircardial = combatUtil:cardialConvert(humanoidrootpart.CFrame:VectorToObjectSpace(direction))
			if humanoid.MoveDirection == Vector3.new(0, 0, 0) then -- if standing
				localdircardial = -Vector3.new(0, 0, 1)
				localdir = -cardialdir
			end
			animtoplay = directionTable[localdircardial]
			localPlayer:Play(`dash {animtoplay}`)
			-- local lvdata = {
			-- 	className = "LinearVelocity",
			-- 	Parent = humanoidrootpart,
			-- 	lifetime = 0.25,
			-- 	find = true,
			-- }
			print(localdir)
			print(localdir*10)
			local lv: LinearVelocity = physics:applyVelocity(humanoidrootpart, localdir*10, 0.1)
			-- lv.Visible = true
			-- lv.ForceLimitsEnabled = false
			-- lv.Attachment0 = humanoidrootpart.RootAttachment
			-- lv.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
			-- lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
			-- lv.VectorVelocity = localdir * 50
			-- humanoid.WalkSpeed = 5
			-- lv.Destroying:Connect(function()
			-- 	task.delay(0.5, function()
			-- 		humanoid.WalkSpeed = 16
			-- 		self.cooldown = false
			-- 	end)
			-- end)
			-- log("calc", lv.VectorVelocity * lvdata.lifetime)
		end,
		cooldown = false,
	},
}

return universalcontrols

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
local types = require(ReplicatedStorage.Modules.types)
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
			local localPlayer: types.playerm = tableModule:waitfor(variables, { "local", "plr" })
			local character = localPlayer.Player.Character
			local humanoidrootpart: BasePart = character.HumanoidRootPart
			local humanoid: Humanoid = character.Humanoid
			local direction = humanoid.MoveDirection
			if self.cooldown or direction == Vector3.new(0, 0, 0) then
				return
			end
			self.cooldown = true
			self.bridge:Fire()
			local directionTable = {
				[Vector3.new(1, 0, 0)] = "right",
				[Vector3.new(-1, 0, 0)] = "left",
				[Vector3.new(0, 0, -1)] = "forward",
				[Vector3.new(0, 0, 1)] = "back",
			}
			local animtoplay
			local toobjectspace = humanoidrootpart.CFrame:VectorToObjectSpace(direction) -- used for animation
			-- local localspace = humanoidrootpart.CFrame:PointToWorldSpace(direction)
			local localspace = Vector3.new(0, 0, -50)
			local objectspaceCardial = combatUtil:cardialConvert(toobjectspace)
			-- localPlayer:

			animtoplay = directionTable[objectspaceCardial]
			local dashanim = localPlayer:Play(`dash {animtoplay}`)
			local v = physics:applyVelocity(humanoidrootpart, localspace, 0.5)
			wait(dashanim.Length)
			dashanim:AdjustSpeed(0)
			-- self.cooldown = false
			-- dashanim.
			-- dashanim.
			-- dashanim.Length
			-- v.Completed:Once(function()
				
			-- end)
		end,
		cooldown = false,
	},
}

return universalcontrols

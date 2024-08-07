local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
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
	task.wait(4)
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
			local localPlayer: types.playerm = tableModule:waitfor(variables, { "local", "plr" })
			self.cooldown = true
			self.M1Stage += 1

			self.bridge:Fire()
			local anim = localPlayer:Play(`punch {self.M1Stage}`, 0.1, 5, 1)
			if self.M1Stage + 1 > self.maxStages then
				M1Cooldown()
			else
				anim.KeyframeReached:Connect(function(k)
					print(k)
					if k == "cd" then
						self.cooldown = false
						local thisStage = self.M1Stage
						-- task.wait(0.05)
						local start = os.clock()
						local conn: RBXScriptConnection
						conn = RunService.Heartbeat:Connect(function()
							print((os.clock() - start) > 0.5, self.M1Stage)
							if self.M1Stage ~= thisStage or (os.clock() - start) > 0.5 then
								if (os.clock() - start) > 0.5 then
									anim:Stop(0.5)
									self.M1Stage = 0
									-- M1Cooldown()
								end
								if self.M1Stage ~= thisStage then
									anim:Stop(0)
								end
								conn:Disconnect()
							end
						end)
					else
						anim:AdjustSpeed(0)
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
			local localPlayer: playerModule.type = tableModule:waitfor(variables, { "local", "plr" })
			local character = localPlayer.Player.Character
			local humanoidrootpart: BasePart = character.HumanoidRootPart
			local humanoid: Humanoid = character.Humanoid
			local direction = humanoid.MoveDirection
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
			local animtoplay
			local localdir = humanoidrootpart.CFrame:VectorToObjectSpace(direction)
			if direction == Vector3.new(0, 0, 0) then
				localdir = Vector3.new(0, 0, -1)
			end
			local localdircardial = combatUtil:cardialConvert(localdir) -- for animation

			-- print(localdir)
			print(localdircardial)
			animtoplay = directionTable[localdircardial]
			localPlayer:Play(`dash {animtoplay}`)

			local v = physics:applyVelocity(humanoidrootpart, localdir * 50, 0.25)
		end,
		cooldown = false,
	},
}

return universalcontrols

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
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
local util = require(ReplicatedStorage.Modules.util)

local universalcontrols = {}

function M1Cooldown()
	task.spawn(function()
		-- local self = universalcontrols[Enum.UserInputType.MouseButton1]
		local self = variableModule:var({ "local", "m1" })
		-- self.M1Stage = 0
		self:set({ "M1Stage" }, 0)
		-- self.cooldown = true
		self:set({ "cooldown" }, true)
		task.wait(2)
		-- self.cooldown = false
		self:set({ "cooldown" }, false)
	end)
end
local m1bridge = BridgeNet2.ReferenceBridge("m1")
local maxstagees = 5
local interval = 0.2

local uppercutBridge = BridgeNet2.ReferenceBridge("uppercut")

universalcontrols = {
	[Enum.UserInputType.MouseButton1] = function()
		-- local self = universalcontrols[Enum.UserInputType.MouseButton1]
		local self = variableModule:var({ "local", "m1" })

		local candomove = variableModule:var({ "local", "candomove" })
		if self:get({ "cooldown" }) == true or candomove:get() == false then
			return
		end
		local localPlayer: types.playerm = variableModule:waitfor({ "local", "plr" })
		local uppercut = variableModule:var({ "local", "uppercut" })
		localPlayer.Player.Character.Humanoid.WalkSpeed = 5
		-- self.cooldown = true
		self:set({ "cooldown" }, true)
		-- self.M1Stage += 1
		self:set({ "M1Stage" }, "+=", 1)
		m1bridge:Fire()
		local m1stage = self:get({ "M1Stage" })
		local anim = localPlayer:Play(`punch {m1stage}`, 0.001, 5, 1)
		if m1stage + 1 > maxstagees then
			M1Cooldown()
			task.wait(0.5)
			if uppercut:get() == true then
				localPlayer.Player.Character.Humanoid.WalkSpeed = 5
			else
				localPlayer.Player.Character.Humanoid.WalkSpeed = 16
			end
		else
			anim.KeyframeReached:Connect(function(k)
				if k == "cd" then
					self:set({"cooldown"}, false)
					-- self.cooldown = false
					local start = os.clock()
					local conn: RBXScriptConnection
					conn = RunService.Heartbeat:Connect(function()
						if self:get({ "M1Stage" }) ~= m1stage or (os.clock() - start) > interval then
							if (os.clock() - start) > interval then
								anim:Stop(0.5)
								self:set({ "M1Stage" }, 0)
								if uppercut:get() == true then
									localPlayer.Player.Character.Humanoid.WalkSpeed = 5
								else
									localPlayer.Player.Character.Humanoid.WalkSpeed = 16
								end
							elseif self.M1Stage ~= m1stage then
								anim:Stop(0)
							end
							conn:Disconnect()
						end
					end)
				end
			end)
		end
	end,
	[Enum.KeyCode.Q] = function()
		local candomove = variableModule:var({ "local", "candomove" })
		local self = variableModule:var({ "local", "dash" })
		local localPlayer: playerModule.type = tableModule:waitfor(variables, { "local", "plr" })
		local character = localPlayer.Player.Character
		local humanoidrootpart: BasePart = character.HumanoidRootPart
		local humanoid: Humanoid = character.Humanoid
		local direction = humanoid.MoveDirection
		if self:get({ "cooldown" }) == true or candomove:get() == false then
			return
		end
		candomove:set(false)
		-- self.cooldown = true
		-- self:set({"cooldown"}, true)
		-- self.bridge:Fire()
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

		animtoplay = directionTable[localdircardial]
		localPlayer:Play(`dash {animtoplay}`)

		local v = physics:applyVelocity(humanoidrootpart, localdir * 50, 0.25)
		v.Destroying:Connect(function()
			candomove:set(true)
		end)
	end,
	[Enum.UserInputType.MouseButton2] = function()
		-- local self = universalcontrols[Enum.UserInputType.MouseButton2]
		-- local localPlayer: types.playerm = variableModule:waitfor({ "local", "plr" })
		-- local Character = localPlayer.Player.Character
		uppercutBridge:Fire()
		-- local lv = physics:applyVelocity(Character.HumanoidRootPart, Vector3.new(0, 50, 0))
		-- task.wait(0.5)
		-- lv.VectorVelocity = Vector3.new()
		-- lv:Destroy()
	end,
	[Enum.KeyCode.F] = function()
		-- local self = universalcontrols[Enum.KeyCode.F]
		local plr: types.playerm = variableModule:get({ "local", "plr" })
		local candomove = variableModule:var({ "local", "candomove" })
		if candomove:get() == false then
			return
		end
		BridgeNet2.ClientBridge("block"):Fire()
		local blockingAnim = plr:Play("blocking")
		blockingAnim.KeyframeReached:Once(function(keyframeName)
			print(keyframeName)
			if keyframeName == "pause" then
				blockingAnim:AdjustSpeed(0)
				candomove:set(false)
				util:when(
					function()
						return UserInputService:IsKeyDown(Enum.KeyCode.F)
					end,
					false,
					function()
						print("brah")
						BridgeNet2.ClientBridge("block"):Fire()
						blockingAnim:AdjustSpeed(1)
						candomove:set(true)
					end
				)
			end
		end)
	end,
}

return universalcontrols

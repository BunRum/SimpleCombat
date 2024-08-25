local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local types = require(ReplicatedStorage.Modules.types)
local log = require(ReplicatedStorage.Modules.log)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local combat = require(ReplicatedStorage.Modules.combat)
local animationPlayer = require(ReplicatedStorage.Modules.animationPlayer)

local m1Bridge: types.sbridge = variableModule:set({ "bridges", "m1" }, BridgeNet2.ReferenceBridge("m1"))
local dashBridge: types.sbridge = variableModule:set({ "bridges", "dash" }, BridgeNet2.ReferenceBridge("dash"))
local uppercutBridge: types.sbridge =
	variableModule:set({ "bridges", "uppercut" }, BridgeNet2.ReferenceBridge("uppercut"))
local velocityBridge: types.sbridge =
	variableModule:set({ "bridges", "velocity" }, BridgeNet2.ReferenceBridge("velocity"))
local maxM1Stage = 5

m1Bridge:Connect(function(player)
	local M1Stage = variableModule:var({ player.Name, "M1Stage" })
	-- local cooldown = variableModule:var({ player.Name, "M1Cooldown" })
	M1Stage:set("+=", 1)

	local plrLookVector = player.Character.HumanoidRootPart.CFrame.LookVector

	combat.util:charactersInArea(
		player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 0, -3))),
		"Box",
		{ player.Character },
		function(Character: Model)
			combat.util:damage(Character, 5)

			local hmrp: Part = Character.HumanoidRootPart

			local charState = variableModule:var({ Character.Name, "state" })

			local animTrack = animationPlayer.track(Character, combat.animations.onHit[math.random(1, 3)])
			animTrack:Play()

			combat.util:castRay(hmrp.Position, hmrp.CFrame:PointToWorldSpace(plrLookVector * 10))

			hmrp:SetNetworkOwner(player)

			if M1Stage:get() == maxM1Stage then
				if charState:get() ~= "air" then
					velocityBridge:Fire(BridgeNet2.AllPlayers(), { hmrp, plrLookVector * 100, 0.25 })
				else
					combat.physics:sendFlying(Character)
				end
			else
				if charState:get() ~= "air" then
					velocityBridge:Fire(BridgeNet2.AllPlayers(), { hmrp, plrLookVector * 2.5, 0.25 })
				end
			end
		end,
		{ visualizeHitbox = true, size = Vector3.new(5, 5, 5) }
	)

	-- local function M1Cooldown()
	-- 	M1Stage:set(0)
	-- 	cooldown:set(true)
	-- 	task.wait(2)
	-- 	cooldown:set(false)
	-- end

	-- if M1Stage:get() + 1 > maxM1Stage then
	-- 	M1Cooldown()
	-- else
	-- 	local thisStage = M1Stage:get()
	-- 	local start = os.clock()
	-- 	local conn
	-- 	conn = RunService.Heartbeat:Connect(function()
	-- 		-- print((os.clock() - start) > 0.5, M1Stage:get())
	-- 		if M1Stage:get() ~= thisStage or (os.clock() - start) > 0.5 then
	-- 			if (os.clock() - start) > 0.5 then
	-- 				task.spawn(M1Cooldown)
	-- 			end
	-- 			conn:Disconnect()
	-- 		end
	-- 	end)
	-- end
end)

dashBridge:Connect(function(player, content)
	task.wait(0.2)
end)

function up(mdl)
	task.spawn(function()
		local hmrp: Part = mdl.HumanoidRootPart
		velocityBridge:Fire(BridgeNet2.AllPlayers(), { hmrp, Vector3.new(0, 50, 0), 0.25 })
		-- local lv = combat.physics:applyVelocity(mdl.HumanoidRootPart, Vector3.new(0, 50, 0))
		task.wait(0.5)
		-- hmrp:SetNetworkOwnershipAuto()
		local lv = combat.physics:applyVelocity(hmrp, Vector3.new(0, 0, 0))
		lv.ForceLimitsEnabled = true
		lv.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
		lv.MaxAxesForce = Vector3.new(0, 999999995904, 0)
		-- mdl.Humanoid.WalkSpeed = 0
		task.wait(3)
		lv:Destroy()
		task.wait(0.5)
		variableModule:var({ mdl.Name, "uppercut" }):set(false)
		variableModule:set({ mdl.Name, "state" }, "ground")
		mdl.Humanoid.WalkSpeed = 16
	end)
end

uppercutBridge:Connect(function(player, content)
	local uppercut = variableModule:var({ player.Name, "uppercut" })
	if uppercut:get() == true then
		return
	end
	combat.util:charactersInArea(
		player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 0, -3))),
		"Box",
		{ player.Character },
		function(Character: Model)
			local hmrp: Part = Character.HumanoidRootPart
			if uppercut:get() ~= true then
				uppercut:set(true)
				variableModule:set({ player.Name, "state" }, "air")
				up(player.Character)
				player.Character.Humanoid.WalkSpeed = 5
				print("go up player")
			end
			variableModule:set({ Character.Name, "state" }, "air")
			-- Character:
			hmrp:SetNetworkOwner(player)
			up(Character)
		end,
		{
			visualizeHitbox = true,
			size = Vector3.new(5, 5, 5),
		}
	)
end)

BridgeNet2.ServerBridge("block"):Connect(function(player, content)
	variableModule:set({ player.Name, "isBlocking" }, "not")
end)

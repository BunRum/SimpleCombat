local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local types = require(ReplicatedStorage.Modules.types)
local log = require(ReplicatedStorage.Modules.log)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local combat = require(ReplicatedStorage.Modules.combat)

local m1Bridge: types.sbridge = variableModule:set({ "bridges", "m1" }, BridgeNet2.ReferenceBridge("m1"))
local dashBridge: types.sbridge = variableModule:set({ "bridges", "dash" }, BridgeNet2.ReferenceBridge("dash"))
local uppercutBridge: types.sbridge =
	variableModule:set({ "bridges", "uppercut" }, BridgeNet2.ReferenceBridge("uppercut"))

local maxM1Stage = 5

m1Bridge:Connect(function(player)
	local M1Stage = variableModule:var({ player.Name, "M1Stage" })
	local cooldown = variableModule:var({ player.Name, "M1Cooldown" })
	M1Stage:set("+=", 1)
	combat.util:charactersInArea(
		player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 0, -5))),
		"Box",
		{ player.Character },
		function(Character)
			Character.Humanoid:TakeDamage(5)
			if M1Stage:get() == maxM1Stage then
				combat.physics:applyVelocity(Character.HumanoidRootPart, Vector3.new(0, 0, 50), 0.25)
			end
		end,
		{ visualizeHitbox = false, size = Vector3.new(5, 5, 5) }
	)

	local function M1Cooldown()
		M1Stage:set(0)
		cooldown:set(true)
		task.wait(4)
		cooldown:set(false)
	end

	if M1Stage:get() + 1 > maxM1Stage then
		M1Cooldown()
	else
		local thisStage = M1Stage:get()
		local start = os.clock()
		local conn
		conn = RunService.Heartbeat:Connect(function()
			print((os.clock() - start) > 0.5, M1Stage:get())
			if M1Stage:get() ~= thisStage or (os.clock() - start) > 0.5 then
				if (os.clock() - start) > 0.5 then
					task.spawn(M1Cooldown)
				end
				conn:Disconnect()
			end
		end)
	end
end)

dashBridge:Connect(function(player, content)
	task.wait(0.2)
end)

function up(mdl)
	task.spawn(function()
		local lv = combat.physics:applyVelocity(mdl.HumanoidRootPart, Vector3.new(0, 50, 0))
		task.wait(0.5)
		lv.VectorVelocity = Vector3.new()
		lv.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		lv.MaxAxesForce = 
		-- lv:Destroy()
		-- task,wait
		task.wait(5)
		lv:Destroy()
	end)
end

uppercutBridge:Connect(function(player, content)
	local uppercut = variableModule:var({ player.Name, "uppercut" })
	if uppercut:get() == true then
		return
	end
	combat.util:charactersInArea(
		player.Character.HumanoidRootPart.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 0, -5))),
		"Box",
		{ player.Character },
		function(Character)
			if uppercut:get() ~= true then
				uppercut:set(true)
				up(player.Character)
				print("go up player")
			end
			variableModule:set({Character.Name, "state", "air"})
			up(Character)
		end,
		{
			visualizeHitbox = true,
			size = Vector3.new(5, 5, 5),
		}
	)
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local combatModule = require(ReplicatedStorage.Modules.combat)
local variables = require(ReplicatedStorage.Modules.variables)
local tableModule = require(ReplicatedStorage.Modules.tableModule)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local types = require(ReplicatedStorage.Modules.types)
local util = require(ReplicatedStorage.Modules.util)
local object = require(ReplicatedStorage.Modules.object)
local plr: types.playerm = variableModule:waitfor({ "local", "plr" })
-- plr.Player:GetMouse().
local CharacterTBL: types.weapon = combatModule:getCharacter(tableModule:waitfor(variables, { "local", "character" }))
local candomove = variableModule:var({ "local", "candomove" })
print(CharacterTBL)
UserInputService.InputBegan:Connect(function(input: InputObject)
	if candomove:get() == false then
		return
	end
	-- print(Move)
	local Move: types.weaponMove = CharacterTBL[input.KeyCode]
		or combatModule:getUniversal()[input.KeyCode]
		or combatModule:getUniversal()[input.UserInputType]

	if Move then
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local conn: RBXScriptConnection
			conn = RunService.Heartbeat:Connect(function()
				if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == true then
					Move()
				else
					conn:Disconnect()
				end
			end)
		else
			Move()
		end
	end
end)
local p: Part = object.new({
	className = "Part",
	Parent = workspace,
})
p.Anchored = true
p.CanCollide = false
p.Material = Enum.Material.Neon
p.Color = Color3.new(0.992156, 0.482352, 0.482352)
RunService.PostSimulation:Connect(function(deltaTime)
	local char = plr.Player.Character

	local origin = char.HumanoidRootPart.Position
	local direction = char.HumanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, -5, 0))

	combatModule.util:castRay(origin, direction, p)
end)

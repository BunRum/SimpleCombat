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
local CharacterTBL: combatModule.character = tableModule:waitfor(variables, { "local", "character" })
UserInputService.InputBegan:Connect(function(input: InputObject)
	-- input.UserInputState
	-- combatModule.util:
	-- print("input")
	local Move = CharacterTBL.moves[input.KeyCode.Name]
	local universalMove = combatModule:getUniversal()[input.KeyCode] or combatModule:getUniversal()[input.UserInputType]
	if Move then
		-- while UserInputService:IsKeyDown(input.KeyCode) or UserInputService:IsMouseButtonPressed(input.UserInputType) do
		-- print("key dfown")
		CharacterTBL.bridge:Fire(Move.name)
		if Move.animation then
			Move.animation:Play()
		end
		-- task.wait()
		-- end
	elseif universalMove then
		if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == true then
			conn = RunService.Heartbeat:Connect(function()
				if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == true then
					universalMove.func()
				else
					conn:Disconnect()
				end
				
			end)
		else
			universalMove.func()
		end
	end

	-- if input.KeyCode == Enum.KeyCode.G then
	-- 	local test = workspace.test.Position
	-- 	local targetpos = workspace.target.Position
	-- 	local pivotpos = plr.Player.Character:GetPivot().Position
	-- 	plr.Player.Character:PivotTo(CFrame.new(Vector3.new(test.X, pivotpos.Y, test.Z), targetpos))
	-- end

	-- if input.KeyCode == Enum.KeyCode.T then
	-- 	local char: Model = workspace.Dummy

	-- 	local test = workspace.test.Position
	-- 	local targetpos = workspace.target.Position
	-- 	local pivotpos = char:GetPivot().Position
	-- 	char:PivotTo(CFrame.new(Vector3.new(test.X, pivotpos.Y, test.Z), Vector3.new(targetpos.X, pivotpos.Y, targetpos.Z)))

	-- 	local start = os.clock()
	-- 	combatModule.physics:applyVelocity(char.HumanoidRootPart, Vector3.new(0, 0, -10), 10000)

	-- 	util:when(function() return char.HumanoidRootPart.CFrame.Position.Z end, targetpos.Z, function()
	-- 		print(os.clock() - start)
	-- 	end)

	-- end
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

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local combatModule = require(ReplicatedStorage.Modules.combat)
local variables = require(ReplicatedStorage.Modules.variables)
local tableModule = require(ReplicatedStorage.Modules.tableModule)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local types = require(ReplicatedStorage.Modules.types)
local util = require(ReplicatedStorage.Modules.util)
local plr: types.playerm = variableModule:waitfor({ "local", "plr" })
-- plr.Player:GetMouse().
local CharacterTBL: combatModule.character = tableModule:waitfor(variables, { "local", "character" })
UserInputService.InputBegan:Connect(function(input: InputObject)
	-- input.UserInputState
	-- combatModule.util:
	-- print("input")
	local Move = CharacterTBL.moves[input.KeyCode.Name]
	local universalMove = combatModule:getUniversal()[input.KeyCode] or combatModule:getUniversal()[input.UserInputType]
	if Move or universalMove then
		-- while UserInputService:IsKeyDown(input.KeyCode) or UserInputService:IsMouseButtonPressed(input.UserInputType) do
			-- print("key dfown")
			if universalMove then
				universalMove.func()
			elseif Move then
				CharacterTBL.bridge:Fire(Move.name)
				if Move.animation then
					Move.animation:Play()
				end
			end
			-- task.wait()
		-- end
		elseif universalMove then
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

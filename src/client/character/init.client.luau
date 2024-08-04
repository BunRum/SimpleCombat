local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local combatModule = require(ReplicatedStorage.Modules.combat)
local variables = require(ReplicatedStorage.Modules.variables)
local tableModule = require(ReplicatedStorage.Modules.tableModule)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local types = require(ReplicatedStorage.Modules.types)
-- local plr: types.playerm = variableModule:get({ "local", "plr" })
-- plr.Player:GetMouse().
local CharacterTBL: combatModule.character = tableModule:waitfor(variables, { "local", "character" })
UserInputService.InputBegan:Connect(function(input: InputObject)
	-- input.UserInputState
	-- combatModule.util:
	print("input")
	local Move = CharacterTBL.moves[input.KeyCode.Name]
	local universalMove = combatModule:getUniversal()[input.KeyCode] or combatModule:getUniversal()[input.UserInputType]
	if Move or universalMove then
		while UserInputService:IsKeyDown(input.KeyCode) or UserInputService:IsMouseButtonPressed(input.UserInputType) do
			-- print("key dfown")
			if universalMove then
				universalMove.func()
			elseif Move then
				CharacterTBL.bridge:Fire(Move.name)
				if Move.animation then
					Move.animation:Play()
				end
			end
			task.wait()
		end
	end
end)

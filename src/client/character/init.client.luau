local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local combatModule = require(ReplicatedStorage.Modules.combat)
local variables = require(ReplicatedStorage.Modules.variables)
local tableModule = require(ReplicatedStorage.Modules.tableModule)
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local types = require(ReplicatedStorage.Modules.types)
local plr: types.playerm = variableModule:get({ "local", "plr" })
-- plr.Player:GetMouse().
local CharacterTBL: combatModule.character = tableModule:waitfor(variables, { "local", "character" })
UserInputService:IsKeyDown()
UserInputService.InputBegan:Connect(function(input: InputObject)
	-- input.UserInputState
	-- combatModule.util:
	local Move = CharacterTBL.moves[input.KeyCode.Name]
	local universalMove = combatModule:getUniversal()[input.KeyCode] or combatModule:getUniversal()[input.UserInputType]
	if Move or universalMove then
		while UserInputService:IsKeyDown(input.KeyCode) do
			if universalMove then
				universalMove.func()
			end
			task.wait()
		end
	end
	-- print(input.KeyCode, input.UserInputType)
	if Move and Move.cooldown == false then
		CharacterTBL.bridge:Fire(Move.name)

		-- CharacterTBL.bridge
		if Move.animation then
			Move.animation:Play()
		end
	end

end)

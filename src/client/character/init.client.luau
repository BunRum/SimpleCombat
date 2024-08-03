local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local combatModule = require(ReplicatedStorage.Modules.combat)
local variables = require(ReplicatedStorage.Modules.variables)
local tableModule = require(ReplicatedStorage.Modules.tableModule)
print(variables)
-- combatModule.
local CharacterTBL: combatModule.character = tableModule:waitfor(variables, {"local", "character"})

UserInputService.InputBegan:Connect(function(input: InputObject)
	-- input.UserInputState
	local Move = CharacterTBL.moves[input.KeyCode.Name]	
	local universalMove = combatModule:getUniversal()[input.KeyCode] or combatModule:getUniversal()[input.UserInputType]
	-- print(input.KeyCode, input.UserInputType)
	if Move and Move.cooldown == false then
		CharacterTBL.bridge:Fire(Move.name)
		CharacterTBL.bridge:
		-- CharacterTBL.bridge
		if Move.animation then
			Move.animation:Play()
		end
	end
	if universalMove then
		universalMove.func()
	end
end)
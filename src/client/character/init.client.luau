local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local combatModule = require(ReplicatedStorage.Modules.combat)
local variables = require(ReplicatedStorage.Modules.variables)
local tableModule = require(ReplicatedStorage.Modules.tableModule)
print(variables)
local CharacterTBL: combatModule.characterType = tableModule:waitfor(variables, {"local", "character"})

local notify = require(ReplicatedStorage.Packages["banner-notify"])
UserInputService.InputBegan:Connect(function(input: InputObject)
	-- input.UserInputState
	local Move = CharacterTBL.moves[input.KeyCode.Name]	
	local universalMove = combatModule:getUniversal()[input.KeyCode] or combatModule:getUniversal()[input.UserInputType]
	-- print(input.KeyCode, input.UserInputType)
	if Move and Move.cooldown == false then
		CharacterTBL.bridge:Fire(Move.name)
		if Move.animation then
			Move.animation:Play()
		end
	end
	if universalMove then
		universalMove.func()
	end
	notify:Notify({
		duration = 1,
		header = "Already voted",
		icon = "rbxassetid://11326670020",
		message = "you already voted",
	})
end)
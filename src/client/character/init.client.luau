local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local variableModule = require(ReplicatedStorage.Modules.variableModule)

UserInputService.InputBegan:Connect(function(input)
    local Character: variableModule.characterType = variableModule:get("local", "character")
    if Character.moves[input.KeyCode.Name] then
        local moveName = Character.moves[input.KeyCode.Name]
        Character.bridge:Fire(moveName)
    end
end)

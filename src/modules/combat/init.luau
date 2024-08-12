local ReplicatedStorage = game:GetService("ReplicatedStorage")
local types = require(ReplicatedStorage.Modules.types)
local combatModule = {}

export type character = types.character

-- local characters: types.character = {
-- 	newmain = { 
--         bridge = BridgeNet2.ReferenceBridge("newmain"),
--         moves = {
--             [Enum.KeyCode.One.Name] = {
--                 name = "One",
--                 animation = "swing",
--                 cooldown = false,
--                 -- effect = string
--             },
--         }
--     }
-- }

combatModule.animations = {
    onHit = {
        "LeftHit",
        "MiddleHit",
        "RightHit"
    }
}
-- local Universal

combatModule.util = require(script.util)
combatModule.physics = require(script.physics)

function combatModule:getUniversal(): {types.weapon}
    return require(script.UniversalControls)
end

function combatModule:getCharacter(character: string): types.weapon
    -- local charactertoreturn = characters[character]
    -- return charactertoreturn
    print("knowledg")
    return require(script.characters[character].Client)
end


return combatModule

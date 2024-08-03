-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local RunService = game:GetService("RunService")
local types = require(ReplicatedStorage.Modules.types)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local combatModule = {}
local universalcontrols = require(script.UniversalControls)

function combatModule:getUniversal(): typeof(universalcontrols)
    return universalcontrols
end

export type character = types.character

local characters: types.character = {
	newmain = { 
        bridge = BridgeNet2.ReferenceBridge("newmain"),
        moves = {
            [Enum.KeyCode.One.Name] = {
                name = "One",
                animation = "swing",
                cooldown = false,
                -- effect = string
            },
        }
    }
}
function combatModule:getCharacter(character: string)
    local charactertoreturn = characters[character]
    return charactertoreturn
end


return combatModule

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local combat = {}
local bridgenettypes = require(ReplicatedStorage.Packages._Index["ffrostflame_bridgenet2@1.0.0"].bridgenet2.PublicTypes)

export type characterType = {
    bridge: bridgenettypes.Bridge,
    moves: { [Enum.KeyCode]: string }
} 

combat.characters = {
	newmain = { 
        bridge = BridgeNet2.ReferenceBridge("newmain"),
        moves = {
            [Enum.KeyCode.One.Name] = "One"
        }
    }
}

function combat:getCharacter(character: string)
    return combat.characters[character]
end

return combat

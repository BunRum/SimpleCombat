local ReplicatedStorage = game:GetService("ReplicatedStorage")
local types = {}
local bridgenettypes = require(ReplicatedStorage.Packages._Index["ffrostflame_bridgenet2@1.0.0"].bridgenet2.PublicTypes)

export type bridge = bridgenettypes.Bridge
export type sbridge = bridgenettypes.ServerBridge
export type cbridge = bridgenettypes.ClientBridge
export type character = {
    bridge: bridge,
    moves: { [Enum.KeyCode]: {
        name: string,
        animation: AnimationTrack,
        cooldown: boolean
    } }
}

return types
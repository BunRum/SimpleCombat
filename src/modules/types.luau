local ReplicatedStorage = game:GetService("ReplicatedStorage")
local types = {}
local bridgenettypes = require(ReplicatedStorage.Packages._Index["ffrostflame_bridgenet2@1.0.0"].bridgenet2.PublicTypes)
--selene: allow(unused_variable)
local playerModule = require(ReplicatedStorage.Modules.player)

export type bridge = bridgenettypes.Bridge
export type sbridge = bridgenettypes.ServerBridge
export type cbridge = bridgenettypes.ClientBridge
export type weapon = {
    bridge: bridge,
    moves: { [Enum.KeyCode]: {
        name: string,
        animation: AnimationTrack,
        cooldown: boolean
    } }
}
export type Character = typeof(playerModule.Player.Character)

return types
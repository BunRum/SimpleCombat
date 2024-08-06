local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local playerModule: playerm = {} :: playerm
playerModule.__index = playerModule

local animationPlayer = require(ReplicatedStorage.Modules.animationPlayer)
-- local log = require(ReplicatedStorage.Modules.log)
export type playerm = {
	Player: Player,
	module: boolean,
}

export type Character = typeof(playerModule.Player.Character)

function playerModule.New(player: Player)
	if player == nil then
		player = Players.LocalPlayer
	end
	local self = setmetatable({} :: playerm, playerModule)
	self.Player = player
	self.module = true
	return self
end

function playerModule:Play(animation: string, ...)
	local self: plr = self
	-- self.plas
	local animTrack = animationPlayer.track(self.Player.Character, animation)
	animTrack:Play()
	return animTrack
end

return playerModule

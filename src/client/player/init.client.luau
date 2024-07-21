local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local BridgeNet2 = require(ReplicatedStorage.Packages.BridgeNet2)
-- local voteBridge = variableModule:get("bridges", "vote")
local voteBridge: variableModule.cbridge = variableModule:get("bridges", "vote")
print(voteBridge)
local maps = {
	"map1",
	"map2",
	"map3",
}

local plr: Player = variableModule:get("local", "plr")
local VoteMenuModel = workspace:FindFirstChild("MapVoter")

function refresh()
	for _, mapimage: Part in pairs(VoteMenuModel:WaitForChild("mapimages"):GetChildren()) do
		print(mapimage.Name, variableModule:get("maps"))
		mapimage.votes.text.Text = variableModule:get("maps", mapimage.Name, "totalVotes")
	end
end

refresh()
for _, mapplate: Part in pairs(VoteMenuModel:WaitForChild("mapplates"):GetChildren()) do
	mapplate.Touched:Connect(function(otherPart: BasePart)
		if otherPart:FindFirstAncestor(plr.Name) then
			voteBridge:Fire(mapplate.Name, false)
		end
	end)
end

for _, map in maps do
	variableModule:watch("maps", map, "totalVotes", function()
		refresh()
	end)
end
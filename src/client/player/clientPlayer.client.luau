local ReplicatedStorage = game:GetService("ReplicatedStorage")
local variableModule = require(ReplicatedStorage.Modules.variableModule)
local playerModule = require(ReplicatedStorage.Modules.player)
local log = require(ReplicatedStorage.Modules.log)
-- local voteBridge = variableModule:get("bridges", "vote")
-- local voteBridge: variableModule.cbridge = variableModule:get("bridges", "vote")
-- -- print(voteBridge)
-- local maps = {
-- 	"map1",
-- 	"map2",
-- 	"map3",
-- }
local plr: playerModule.plr = variableModule:set({ "local", "plr" }, playerModule.New())
-- local localPlayer = plr.Player
-- local localCharacter = localPlayer.Character
log("thesilly", plr)
log(plr.Player.Name, "brand new world")

-- tableModule:watch(variables, {"ownedCounter"}, function(old, new)
--     log(old, new)
-- end)

-- local camera = workspace.CurrentCamera
-- local length = 500
-- function GetPartsInView()
-- 	local parts = {}
-- 	for i, obj in pairs(workspace:GetDescendants()) do
-- 		if not obj:IsA("BasePart") then
-- 			continue
-- 		end
-- 		local vector, isOnScreen = camera:WorldToScreenPoint(obj.Position)
-- 		if isOnScreen then
-- 			table.insert(parts, obj)
-- 		end
-- 	end

-- 	return parts
-- end

-- ContextActionService:BindAction("asd", function(an, is: Enum.UserInputState, io)
-- 	if is == Enum.UserInputState.Begin then
-- 		local size = workspace.CurrentCamera.ViewportSize
-- 		-- local included: {Instance} = {}
-- 		local camcframe = camera.CFrame
-- 		local excluded = workspace:GetDescendants()
-- 		task.spawn(function()
--             for y = 0, 1, 1 do
--                 for x = 0, size.X, 32 do
--                     task.spawn(function()
--                         local unitRay = camera:ViewportPointToRay(x, y)
--                         local origin = unitRay.Origin
--                         local direction = unitRay.Direction
--                         direction = origin + direction * length
--                         local params = RaycastParams.new()
--                         params.IgnoreWater = true
--                         params.FilterType = Enum.RaycastFilterType.Exclude
--                         params.FilterDescendantsInstances = { localCharacter }
--                         local raycastResult = workspace:Raycast(origin, direction, params)
--                         if raycastResult then
--                             -- table.insert(included, raycastResult.Instance)
--                             if excluded[table.find(excluded, raycastResult.Instance)] then
                                
--                             excluded[table.find(excluded, raycastResult.Instance)] = nil
--                             end
--                             -- table.remove(excluded, table.find(excluded, raycastResult.Instance))
--                             object:addToQueue(function()
--                                 if raycastResult.Instance:IsA("BasePart") then
--                                     local part: BasePart = raycastResult.Instance
--                                     part.Transparency = 0
--                                 end
--                             end)
--                         end
--                         -- object:addToQueue(function()
--                         --     local p: Part = object.new({
--                         --         className = "Part",
--                         --         Parent = workspace,
--                         --     })
--                         --     p.Anchored = true
--                         --     p.CanCollide = false
--                         --     local m = (origin - direction).Magnitude
--                         --     p.Size = Vector3.new(0.01, 0.01, m)
--                         --     p.CFrame = CFrame.lookAt(camcframe.Position, direction) * CFrame.new(0, 0, -m / 2)
--                         -- end)
--                     end)
--                 end
--             end
--             for index, instance in excluded do
--                 object:addToQueue(function()
--                     if instance:IsA("BasePart") then
--                         instance.Transparency = 1
--                     end
--                 end)
--             end
--             print("done")
--         end)
--     end
-- end, false, Enum.KeyCode.H)

--selene: allow(deprecated)
-- local txt = Instance.new("TextLabel", Instance.new("ScreenGui", plr.PlayerGui))
-- txt.Size = UDim2.fromOffset(100, 100)
-- txt.TextScaled = true
-- txt.Position = UDim2.fromScale(0.5, 0.5)

-- RunService.Heartbeat:Connect(function(deltaTime)
--     txt.Text = 1/   RunService.Heartbeat:Wait()
-- end)

-- local VoteMenuModel = workspace:FindFirstChild("MapVoter")
-- plr:test()
-- function refresh()
-- 	for _, mapimage: Part in pairs(VoteMenuModel:WaitForChild("mapimages"):GetChildren()) do
-- 		print(mapimage.Name, variableModule:get("maps"))
-- 		mapimage.votes.text.Text = variableModule:get("maps", mapimage.Name, "totalVotes")
-- 	end
-- end

-- refresh()
-- for _, mapplate: Part in pairs(VoteMenuModel:WaitForChild("mapplates"):GetChildren()) do
-- 	mapplate.Touched:Connect(function(otherPart: BasePart)
-- 		if otherPart:FindFirstAncestor(plr.Name) then
-- 			voteBridge:Fire(mapplate.Name, false)
-- 		end
-- 	end)
-- end

-- for _, map in maps do
-- 	variableModule:watch("maps", map, "totalVotes", function()
-- 		refresh()
-- 	end)
-- end

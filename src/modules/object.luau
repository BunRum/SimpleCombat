local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local object = {}
object.__index = object
-- local tableModulem = require(ReplicatedStorage.Modules.tableModule)
local queue = require(ReplicatedStorage.Modules.queue)
local objects = {}
-- local objects = {}
object.n = 0

function object.new(args: { name: string, className: string, Parent: Instance, find: boolean, lifetime: number })
	local obj: Instance
	local id
	if args.find then
		obj = args.Parent:FindFirstChildOfClass(args.className) or args.name and args.Parent:FindFirstChild(args.name)
		if obj == nil then
			args.find = false
		else
			-- print("found existing obj")
			id = obj:GetAttribute("id")
			-- print(id)
			if id == nil then
				object.n += 1
				id = object.n
				objects[id] = {}
			end
			objects[id].modified = true
		end
	end
	if not args.find then
		obj = Instance.new(args.className)
		object.n += 1
		id = object.n
		objects[id] = {
			modified = false,
		}
		obj:SetAttribute("id", id)
	end

	-- CollectionService
	obj.Name = args.name or args.className
	obj.Parent = args.Parent or workspace
	-- obj.
	if args.lifetime then
		-- object.n+= 1
		-- local mynumber = object.n
		task.delay(args.lifetime, function()
			if objects[id].modified == true then
				objects[id].modified = false
				return
			end
			obj:Destroy()
		end)
	end

	return obj
end

local queue = queue.new()

function object:addToQueue(func)
	-- table.insert(queue, func)
	queue:enqueue(func)
	-- print("object added")
end

RunService.PreRender:Connect(function()
	local currentQueueFunc = queue:dequeue()
	-- currentQueueFunc()
	if currentQueueFunc then
		-- print("thats func")
		currentQueueFunc()
		if not queue.head then
			print("queue empty")
		end
	end
end)

export type what = typeof(object.new(...))

return object

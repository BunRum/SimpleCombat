local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local util = require(ReplicatedStorage.Modules.util)
-- Simple Linked List Implementation
local Queue: QueueSelf = {} :: QueueSelf
Queue.__index = Queue

-- Type definitions
type Node = {
    task: () -> (),
    nextNode: Node | nil,  -- Next node can be nil
    parameters: any,
    uniqueID: number,
}

type QueueSelf = {
    firstNode: Node | nil,  -- First node can be nil
    lastNode: Node | nil,   -- Last node can be nil,
	currentNode: Node | nil,
    total: number           -- Total number of nodes
}

function Queue.new(): QueueSelf
	local self = setmetatable({} :: QueueSelf, Queue)
	self.firstNode = nil
	self.lastNode = nil
	self.total = 0
	self.currentNode = nil
	RunService.Heartbeat:Connect(function()
		local currentQueuenode = self:dequeue()
		if currentQueuenode then
			self.currentNode = currentQueuenode
		end
	end)
	return self
end

-- type newQueue = typeof(Queue.new())

function Queue:enqueue(func: () -> (), ...): ()
	self.total += 1
	local newNode: node = {task = func, nextNode = nil, parameters = util:pack(...), uniqueID = self.total}
	if self.lastNode then
		self.lastNode.nextNode = newNode
	else
		self.firstNode = newNode
	end
	-- self.
	self.lastNode = newNode
	while self.currentNode ~= newNode do
		task.wait()
		-- print("waiting for node")
	end
	-- print("currentnode = this node")
	return self.currentNode.task(...)
end

function Queue:dequeue(): Node | nil
	if not self.firstNode then return nil end
	local node = self.firstNode
	self.firstNode = self.firstNode.nextNode
	if not self.firstNode then
		self.lastNode = nil
	end
	return node
end


return Queue
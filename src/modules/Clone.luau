return function(partToclone: Instance?, part: Instance?)
	if not partToclone then return end
	local clone = partToclone:Clone()
	clone.Parent = part
	return clone
end

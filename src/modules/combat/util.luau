local util = {}

function util:cardialConvert(dir)
    local angle = math.atan2(dir.X, -dir.Z)
    local quarterTurn = math.pi/2
    angle = -math.round(angle/quarterTurn) * quarterTurn
    local newX = -math.sin(angle)
    local newZ = -math.cos(angle)
    if math.abs(newX) <= 1e-10 then
        newX = 0
    end
    if math.abs(newZ) <= 1e-10 then
        newZ = 0
    end
    return Vector3.new(newX, 0, newZ)
end


return util
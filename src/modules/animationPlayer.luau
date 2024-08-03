local aniamtionPlayer = {}

local kfsqp =  game:GetService("KeyframeSequenceProvider")

local loadedanims = {

}

function aniamtionPlayer.track(character: Model?, animation: string): AnimationTrack | nil
    if typeof(animation) == "Instance" then
        return animation
    end
    local animInstance
    if loadedanims[animation] then
        animInstance = loadedanims[animation]
        print("kroger")
    else
        local keyframe = kfsqp:RegisterKeyframeSequence(workspace.ChangeCharacter.AnimSaves[animation])
        if keyframe == nil then
            return nil
        end
        animInstance = Instance.new("Animation")
        animInstance.AnimationId = keyframe
        loadedanims[animation] = animInstance
    end

    -- table.move()
    local humanoid = character:FindFirstChild("Humanoid") or character:WaitForChild("Humanoid")
    -- humanoid.+
    local animator = humanoid:FindFirstChild("Animator") or humanoid:WaitForChild("Animator")
    -- print(character:GetDescendants())
    -- task.wait()
    -- warn(character.Parent)
    local track = animator:LoadAnimation(animInstance)
    repeat 
        task.wait() 
    until track.length > 0
    return track
end

return aniamtionPlayer
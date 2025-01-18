local Character = {}

local Players = GetService("Players")

function Character:Anchor(Value)
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character

    if (Character == nil) then
        return
    end

    local HumanoidRootPart = Character.HumanoidRootPart

    if (HumanoidRootPart == nil) then
        return
    end

    HumanoidRootPart.Anchored = Value
end

return Character
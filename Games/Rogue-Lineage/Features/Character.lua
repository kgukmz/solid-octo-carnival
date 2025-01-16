local Character = {}

local Players = GetService("Players")
local Lighting = GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

function Character:Reset()
    if (LocalPlayer.Character == nil) then
        return
    end

    if (LocalPlayer.Character:FindFirstChild("Head")) then
        LocalPlayer.Character.Head:Destroy()
    end
end

function Character:NoBlur(Value)
    local Blur = Lighting:FindFirstChild("Blur")
    Blur.Enabled = not Value
end

function Character:NoBlindness(Value)
    local Blindness = Lighting:FindFirstChild("Blindness")
    Blindness.Enabled = not Value
end

return Character
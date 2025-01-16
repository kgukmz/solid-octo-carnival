local Character = {}

local Players = GetService("Players")
local LocalPlayer = Players.LocalPlayer

function Character:Reset()
    if (LocalPlayer.Character == nil) then
        return
    end

    if (LocalPlayer.Character:FindFirstChild("Head")) then
        LocalPlayer.Character.Head:Destroy()
    end
end

return Character
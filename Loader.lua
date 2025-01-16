local GameData = Get_Script("Modules/GameData.lua")
local SelectedGame = GameData:GetGame()
local StartTime = tick()
warn(SelectedGame)

if (SelectedGame == nil) then
    warn("No game data for:", game.PlaceId)
    return
end

local Success, Menu = pcall(function()
    local ScriptPath = string.format("Games/%s/Menu.lua", SelectedGame)
    local Loaded = Get_Script(ScriptPath)

    return Loaded
end)

if (Success == false) then
    warn("Loader was unable to proceed:", Menu)
    return
end

Menu:Load()
print("Took:", tick() - StartTime .. "s to load")
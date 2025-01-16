local GameData = Get_Script("Modules/GameData.lua")
local SelectedGame = GameData:GetGame()
warn(SelectedGame)

if (SelectedGame == nil) then
    warn("No game data for:", game.PlaceId)
    return
end

print("Game data!")

local Success, Menu = pcall(function()
    local ScriptPath = string.format("Games/%s/Menu.lua", SelectedGame)
    print(ScriptPath)
    local Loaded = Get_Script(ScriptPath)

    return Loaded
end)

if (Success == false) then
    warn("Script was unable to proceed:", Menu)
    return
end

Menu:Load()
local GameData = Get_Script("Modules/GameData.lua")
local SelectedGame = GameData:GetGame()
warn(SelectedGame)

if (SelectedGame == nil) then
    warn("No game data for:", game.PlaceId)
    return
end

local Success, Error = pcall(function()
    local ScriptPath = string.format("Games/%s/Menu.lua", SelectedGame)
    local Loaded = Get_Script(ScriptPath)

    return Loaded
end)

if (Success == false) then
    warn("Script was unable to proceed:", Error)
    return
end
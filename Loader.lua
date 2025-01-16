print("Loader")

local GameData = Get_Script("Modules/GameData.lua")

print("Hi")
local SelectedGame = GameData:GetGame()
warn(SelectedGame)

if (SelectedGame == nil) then
    warn("No game data for:", game.PlaceId)
    return
end

Get_Script(string.format("Games/%s/Menu.lua", SelectedGame))
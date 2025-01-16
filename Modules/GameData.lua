local GameData = {
    [4483381587] = "LiteralBaseplate";
}

function GameData:GetGame()
    local PlaceID = game.PlaceId
    local SelectedGame = self[PlaceID]

    if (SelectedGame == nil) then
        return nil
    end

    return SelectedGame
end

return GameData
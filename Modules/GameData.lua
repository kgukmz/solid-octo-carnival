local GameData = {
    [4483381587] = "LiteralBaseplate";
    [5208655184] = "Rogue-Lineage";
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
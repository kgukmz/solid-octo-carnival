if (getgenv().AlchemyLoaded == true) then
	return
end

local Games = {
	[5208655184] = "RogueLineage";
	[4483381587] = "LiteralBaseplate";
}

local Library = require("modules/ImGui.lua")
local Services = require("modules/GetServices.lua")

local A = Games[game.PlaceId]
print(A, game.PlaceId, Games[game.PlaceId])

if (A ~= nil) then
	local GameScriptPath = string.format("games/%s/main.lua", A)
	
	require(GameScriptPath)
end

print("succulent-cess")
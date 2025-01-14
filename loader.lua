xpcall(function()
	if (getgenv().AlchemyLoaded == true) then
		return
	end

	getgenv().Library = require("modules/ImGui.lua")
	local Services = require("modules/GetServices.lua")
	local GamesList = require("SupportedGames.json")
	
	local HttpService = Services:Get("HttpService")
	local SupportedGames = HttpService:JSONEncode(GamesList)
	
	local GameName = SupportedGames[game.PlaceId]
	print(GameName)

	print("No")
end, function(Error)
	warn(Error)
end)
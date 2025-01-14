xpcall(function()
	if (getgenv().AlchemyLoaded == true) then
		return
	end
	
	print("v")
	
	getgenv().Library = require("modules/ImGui.lua")
	
	local Services = require("modules/GetServices.lua")
	local GamesList = require("SupportedGames.json")
	
	local HttpService = Services:Get("HttpService")
	local SupportedGames = HttpService:JSONEncode(GamesList)
	
	local GameScript = require(string.format("games/%s/main.lua", SupportedGames[game.PlaceId]))
	
	if (not GameScript) then
		warn("no game script")
	end
end, function(...)
	table.foreach({...}, warn)
end)
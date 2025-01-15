if (getgenv().AlchemyLoaded == true) then
	return
end

local Games = {
	[5208655184] = "RogueLineage";
	[4483381587] = "LiteralBaseplate";
}

local Library = dRequire("modules/ImGui.lua")
local Services = dRequire("modules/GetServices.lua")

local SelectedGame = Games[game.PlaceId]
print(SelectedGame, game.PlaceId, Games[game.PlaceId])

if (SelectedGame == nil) then
	return
end

local UIWindow = Library:CreateWindow({
	Title = "Alchemy | " .. identifyexecutor(),
	Size = UDim2.fromOffset(400, 250),
	Position = UDim2.new(0.5, 0, 0, 70),
	NoResize = true,
})

if (getgenv().DebugMode == true and getgenv().ConsoleEnabled ~= true) then
	local DebugWindow = Library:CreateWindow({
		Title = "Alchemy: Debug | " .. identifyexecutor(),
		Size = UDim2.fromOffset(300, 300),
		Position = UDim2.new(0.5, 0, 0, 70),
	}):CreateTab({
		Name = "Console";
        Visible = true;
	})

	local DebugConsole = DebugWindow:Console({
		Text = "[DEBUG WINDOW]";
		ReadOnly = true;
		Border = false;
		Fill = true;
		RichText = true;
		Enabled = true;
		AutoScroll = true;
		MaxLines = math.huge;
	})

	local function DebugConsoleLog(...)
		DebugConsole:AppendText(`<font color="rgb(240, 40, 10)">[DEBUG]:</font>`, table.unpack({...}))
	end

	getgenv().DebugConsoleLog = DebugConsoleLog
	getgenv().ConsoleEnabled = true
end

print("V")

getgenv().ImGui_Window = UIWindow

local GameScriptPath = string.format("games/%s/main.lua", SelectedGame)
dRequire(GameScriptPath)

UIWindow:Center()
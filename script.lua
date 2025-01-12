local ContextActionService = game:GetService("ContextActionService")
local SourceURL = 'https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'
local ImGui = loadstring(game:HttpGet(SourceURL))()

local Window = ImGui:CreateWindow({
	Title = "Window",
	Size = UDim2.fromOffset(400, 250),
	Position = UDim2.new(0.5, 0, 0, 70),
})

local ActiveTabs = {
    Main = Window:CreateTab({
        Name = "ROGUE LINEAGE";
        Visible = true;
    });

    Player = Window:CreateTab({
        Name = "PLAYER";
        Visible = true;
    });

    Settings = Window:CreateTab({
        Name = "SETTINGS";
        Visible = true;
    });

    Debug = Window:CreateTab({
        Name = "DEBUG";
        Visible = true;
    });
}

-- // Rogue Lineage 

local TabMain = ActiveTabs.Main

TabMain:Seperator({
    Text = "Rogue Lineage";
})

-- // Player

local TabPlayer = ActiveTabs.Player

TabPlayer:Seperator({
    Text = "Player";
})
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local SourceURL = 'https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'
local ImGui = loadstring(game:HttpGet(SourceURL))()

local Player = Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character.Humanoid

getgenv().ScriptData = {
    KillMethod = nil
}

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

TabMain:Separator({
    Text = "ROGUE LINEAGE";
})

-- // Player

local function Reset()
    local Head = Player.Character:FindFirstChild("Head")

    if (Head == nil) then
        return
    end

    Head:Destroy()
end

local function Kill()
    if (getgenv().ScriptData.KillMethod == nil) then
        return
    end

    if (getgenv().ScriptData.KillMethod == "Solans") then
        if (getgenv().firetouchinterest == nil) then
            warn("Executor does not support this feature.")
            return
        end

        local SolansSword

        for _,Obj in next, workspace:GetDescendants() do
            if (Obj.Name ~= "SealedSword") then
                continue
            end

            SolansSword = Obj
            break
        end

        if (SolansSword == nil) then
            return
        end

        firetouchinterest(SolansSword, Player.Character.Torso, true)
    end
end

local TabPlayer = ActiveTabs.Player
local PlayerRow = ActiveTabs.Player:Row()

PlayerRow:Button({
    Text = "Reset";
    Callback = Reset
})

PlayerRow:Button({
    Text = "Kill Self";
    Callback = Kill
})

TabPlayer:Separator({
    Text = "PLAYER";
})

TabPlayer:Combo({
    Placeholder = "...";
    Label = "Kill Method";
    Items = {
        "Solans"
    };
    Callback = function(self, Value)
        getgenv().ScriptData.KillMethod = Value
    end;
})

-- // Misc

local function ClientAntiBan()
    for i, v : AnimationTrack in next, Humanoid:GetPlayingAnimationTracks() do
        if (string.match(v.Animation.AnimationId, "4595066903") == nil) then
            continue
        end

        RunService:SetThrottleEnabled("RenderStepped", false)
        Player:Kick("Kicked in order to prevent anti-cheat ban")
    end
end

RunService:BindToRenderStep("AntiBan", 1, ClientAntiBan)

PlayerRow:Fill()
Window:ShowTab(TabMain)
Window:Center()
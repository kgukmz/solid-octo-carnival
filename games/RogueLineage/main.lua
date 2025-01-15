print("ippatsushobuda - sae itoshi")

local UIWindow = getgenv().ImGui_Window

local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local CollectionService = cloneref(game:GetService("CollectionService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Players = cloneref(game:GetService("Players"))

local Player = game.Players.LocalPlayer

local AlchemyClient = {
    Configs = {
        Client = {
            ClimbSpeedValue = 0;
            ClimbSpeedEnabled = false;

            TheSoulEnabled = false;
            AcrobatEnabled = false;

            AntiAfkEnabled = false;
            KillMethod = "Default";

            SpeedhackValue = 10;
            SpeedhackEnabled = false;

            InfiniteJumpVelocity = 10;
            InfiniteJumpEnabled = false;
        };
    }
}

RunService:UnbindFromRenderStep("ClientChecks")

local function Reset()
    local Character = Player.Character

    if (Character:FindFirstChild("Head") == nil) then
        return
    end

    Character.Head:Destroy()
end

local function EnableAntiAFK(_, Value)
    if (getgenv().getconnections == nil) then
        return
    end

    for _, Connection in next, getconnections(Player.Idled) do
        if (Value == true) then
            Connection:Disable()
            DebugConsoleLog("Enabled Anti-AFK")
        elseif (Value == false) then
            Connection:Enable()
            DebugConsoleLog("Disabled Anti-AFK")
        end
    end
end

local function InfiniteJump()
    
end

local function TheSoul(_, Value)
    if (Value == true) then
        if (CollectionService:HasTag(Player.Character, "The Soul")) then
            return
        end

        CollectionService:AddTag(Player.Character, "The Soul")
    elseif (Value == false) then
        if (not CollectionService:HasTag(Player.Character, "The Soul")) then
            return
        end

        CollectionService:RemoveTag(Player.Character, "The Soul")
    end
end

local function Acrobat(_, Value)
    if (Value == true) then
        if (CollectionService:HasTag(Player.Character, "Acrobat")) then
            return
        end

        CollectionService:AddTag(Player.Character, "Acrobat")
    elseif (Value == false) then
        if (not CollectionService:HasTag(Player.Character, "Acrobat")) then
            return
        end

        CollectionService:RemoveTag(Player.Character, "Acrobat")
    end
end

local ClimbBoost 
local function EnableClimbSpoof(_, Value)
    if (Value == true) then
        ClimbBoost = Instance.new("NumberValue")
        ClimbBoost.Name = "ClimbBoost"
        ClimbBoost.Value = AlchemyClient.Configs.Client.ClimbSpeedValue
        ClimbBoost.Parent = Player.Character.Boosts
    elseif (Value == false) then
        if (ClimbBoost == nil) then
            return
        end

        ClimbBoost:Destroy()
        ClimbBoost = nil
    end
end

local WindowTabs = {
    Main = UIWindow:CreateTab({
        Name = "MAIN";
        Visible = true;
    });
    Client = UIWindow:CreateTab({
        Name = "CLIENT";
        Visible = true;
    });
}

do -- // CLIENT
    local ClientTab = WindowTabs.Client
    local ButtonRow = ClientTab:Row()

    ButtonRow:Button({
        Text = "Reset";
        Callback = Reset;
    })

    ButtonRow:Button({
        Text = "Kill Self";
    })

    ClientTab:Separator({ Text = "CLIENT" })

    ClientTab:Combo({
        Selected = AlchemyClient.Configs.Client.KillMethod;
        Label = "Kill Method";
        Items = {"Default"; "Solans"};
        Callback = function(self, Value)
            AlchemyClient.Configs.Client.KillMethod = Value
        end;
    })

    ClientTab:Checkbox({
        Label = "Anti-AFK";
        Value = AlchemyClient.Configs.Client.AntiAfkEnabled;
        Callback = EnableAntiAFK;
    })

    local SpeedhackHeader = ClientTab:CollapsingHeader({ Title = "Speedhack" })
    
    SpeedhackHeader:Slider({
        Label = "Speed";
        Format = "%.d/%s";
	    Value = AlchemyClient.Configs.Client.SpeedhackValue;
	    MinValue = 10;
	    MaxValue = 200;

	    Callback = function(self, Value)
            AlchemyClient.Configs.Client.SpeedhackValue = Value
	    end;
    })

    SpeedhackHeader:Checkbox({
        Label = "Speedhack";
        Value = AlchemyClient.Configs.Client.SpeedhackEnabled;
        Callback = function()
            
        end
    })

    local InfiniteJumpHeader = ClientTab:CollapsingHeader({ Title = "Infinite Jump" })

    InfiniteJumpHeader:Slider({
        Label = "Velocity";
        Format = "%.d/%s";
	    Value = AlchemyClient.Configs.Client.InfiniteJumpVelocity;
	    MinValue = 10;
	    MaxValue = 200;
	    Callback = function(self, Value)
            AlchemyClient.Configs.Client.InfiniteJumpVelocity = Value
	    end;
    })

    InfiniteJumpHeader:Checkbox({
        Label = "Infinite Jump";
        Value = AlchemyClient.Configs.Client.InfiniteJumpEnabled;
        Callback = function()
            
        end
    })

    local SpoofsHeader = ClientTab:CollapsingHeader({ Title = "Client Spoofs" })

    SpoofsHeader:Slider({
        Label = "Climb Boost";
        Format = "%.d/%s";
	    Value = AlchemyClient.Configs.Client.ClimbSpeedValue;
	    MinValue = 0;
	    MaxValue = 1;
	    Callback = function(self, Value)
            AlchemyClient.Configs.Client.ClimbSpeedValue = Value
	    end;
    })

    SpoofsHeader:Checkbox({
        Label = "Spoof Climb Speed";
        Value = AlchemyClient.Configs.Client.ClimbSpeedEnabled;
        Callback = EnableClimbSpoof
    })

    SpoofsHeader:Separator()

    SpoofsHeader:Checkbox({
        Label = "Spoof The Soul";
        Value = AlchemyClient.Configs.Client.TheSoulEnabled;
        Callback = TheSoul
    })

    SpoofsHeader:Checkbox({
        Label = "Spoof Acrobat";
        Value = AlchemyClient.Configs.Client.AcrobatEnabled;
        Callback = Acrobat;
    })

    ButtonRow:Fill()
end

local function ClientChecks()
    if (ClimbBoost ~= nil) then
        local ClimbBoostValue = AlchemyClient.Configs.Client.ClimbSpeedValue
        ClimbBoost.Value = ClimbBoostValue
    end
end

RunService:BindToRenderStep("ClientChecks", 1, ClientChecks)
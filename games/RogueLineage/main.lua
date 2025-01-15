print("ippatsushobuda - sae itoshi")

local UIWindow = getgenv().ImGui_Window

local UserInputService = cloneref(game:GetService("UserInputService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Players = cloneref(game:GetService("Players"))

local Player = game.Players.LocalPlayer

local AlchemyClient = {
    Configs = {
        Client = {
            KillMethod = "Default";

            SpeedhackValue = 10;
            SpeedhackEnabled = false;

            InfiniteJumpVelocity = 10;
            InfiniteJumpEnabled = false;
        };
    }
}

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
            if (Connection.Enabled == false) then
                return
            end

            Connection:Disable()
        elseif(Value == false) then
            if (Connection.Enabled == true) then
                return
            end

            Connection:Enable()
        end

        DebugConsoleLog("Connection value:", Connection.Enabled)
    end
end

local function InfiniteJump()
    
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
        Value = AlchemyClient.Configs.Client.SpeedhackEnabled;
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

    ButtonRow:Fill()
end
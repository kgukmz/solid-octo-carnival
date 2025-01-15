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
        Items = {"Default"; "Solans"};
        Callback = function(self, Value)
            AlchemyClient.Configs.Client.KillMethod = Value
        end;
    })

    ButtonRow:Fill()
end
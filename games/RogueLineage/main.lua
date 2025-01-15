print("ippatsushobuda - sae itoshi")

local UIWindow = getgenv().ImGui_Window

local UserInputService = cloneref(game:GetService("UserInputService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Players = cloneref(game:GetService("Players"))

local Player = game.Players.LocalPlayer

local AlchemyClient = {
    Configs = {
        Client = {
            SpeedhackValue = 10;
            SpeedhackEnabled = false;

            InfiniteJumpVelocity = 10;
            InfiniteJumpEnabled = false;
        };
    }
}

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
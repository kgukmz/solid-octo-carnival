print("ippatsushobuda - sae itoshi")

local UIWindow = getgenv().ImGui_Window

local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local CollectionService = cloneref(game:GetService("CollectionService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
local Players = cloneref(game:GetService("Players"))

local LocalPlayer = game.Players.LocalPlayer

local AlchemyClient = {
    Configs = {
        Main = {
            AutoDribble = false;
        };
    }
}

local function AutoDribble(Enabled)
    if (Enabled == false) then
        return
    end

    repeat
        task.wait()

        for _, Character in pairs(workspace:GetChildren()) do
            if (not Character:FindFirstChild("Values")) then
                continue
            end

            if (not Character:FindFirstChild("RagdollR6")) then
                continue
            end
    
            if (Character == LocalPlayer.Character) then
                continue
            end
    
            if ((Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < getgenv().Studs) then
                local Values = Character.Values
                local Sliding = Values.Sliding

                if (Sliding.Value == true) then
                    if (LocalPlayer.Character.Values.HasBall == false) then
                        return
                    end

                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, nil)
                end
            end
        end
    until AlchemyClient.Configs.Main.AutoDribble == false
end

local WindowTabs = {
    UIWindow:CreateTab({
        Name = "MAIN";
        Visible = true;
    });
}

do -- // Main
    local MainTab = WindowTabs.Main
    MainTab:Separator({ Text = "MAIN" })

    MainTab:Checkbox({
        Label = "Auto-dribble";
        Value = AlchemyClient.Configs.Main.AutoDribble;
        Callback = function(self, Value)
            AlchemyClient.Configs.Main.AutoDribble = Value
            AutoDribble(Value)
        end
    })
end
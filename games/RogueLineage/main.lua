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
        Main = {
            NoOrderlyBarriers = false;
        };

        Client = {
            PulseType = "LifeSense";
            PulseSpoofEnabled = false;

            ClimbSpeedValue = 10;
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

local OrderlyBarriers = {}

RunService:UnbindFromRenderStep("ClientAntiBan")
RunService:UnbindFromRenderStep("ClientChecks")

local function ShutdownClient()
    game:Shutdown()
end

local function Reset()
    local Character = Player.Character

    if (Character:FindFirstChild("Head") == nil) then
        return
    end

    Character.Head:Destroy()
end

local function SelfKill()
    local Configs = AlchemyClient.Configs.Client

    if (Player.Character == nil) then
        return
    end

    if (Configs.KillMethod == "Default") then
        
    elseif (Configs.KillMethod == "Solans") then
        local SealedSword
        
        for _, Object in next, getinstances() do
            if (Object.Name ~= "SealedSword") then
                continue
            end

            if (Object.Parent.ClassName ~= "Folder") then
                continue
            end

            SealedSword = Object
            break
        end

        if (SealedSword == nil) then
            DebugConsoleLog("Solans has already been pulled")
            return
        end

        firetouchinterest(SealedSword, Player.Character.Torso, 1)
    end
end

local function EnableAntiAFK(_, Value)
    if (getgenv().getconnections == nil) then
        return
    end

    for _, Connection in next, getconnections(Player.Idled) do
        if (Value == true) then
            Connection:Disable()
        elseif (Value == false) then
            Connection:Enable()
        end
    end
end

local function Speedhack(_, Value)
    if (Value == false) then
        return
    end

    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * math.huge

    repeat
        if (Player.Character == nil) then
            return
        end

        local Humanoid = Player.Character.Humanoid
        local HumanoidRootPart = Player.Character.HumanoidRootPart

        BodyVelocity.Parent = HumanoidRootPart
        
        if (Humanoid.MoveDirection.Magnitude > 0) then
            BodyVelocity.Velocity = BodyVelocity.Velocity * Humanoid.MoveDirection.Unit * AlchemyClient.Configs.Client.SpeedhackValue
        end

        task.wait()
    until AlchemyClient.Configs.Client.SpeedhackEnabled == false

    BodyVelocity:Destroy()
end

local function InfiniteJump(_, Value)
    if (Value == false) then
        return
    end

    repeat
        if (Player.Character == nil) then
            return
        end

        local HumanoidRootPart = Player.Character.HumanoidRootPart
        local InfiniteJumpVelocity = AlchemyClient.Configs.Client.InfiniteJumpVelocity

        if (UserInputService:IsKeyDown(Enum.KeyCode.Space) == true) then
            HumanoidRootPart.Velocity = Vector3.new(HumanoidRootPart.Velocity.X, InfiniteJumpVelocity, HumanoidRootPart.Velocity.Z)
        end

        task.wait(0.1)
    until AlchemyClient.Configs.Client.InfiniteJumpEnabled == false
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

local function EnablePulse(Type, Value)
    if (Value == true) then
        local PulseType = Instance.new("Accessory")
        PulseType.Name = Type
        PulseType.Parent = Player.Character

        CollectionService:AddTag(PulseType, "1e9")
    else
        for _, PulseType in next, {"LifeSense", "WorldPulseUltra", "WorldPulse"} do
            local PulseInstance = Player.Character:FindFirstChild(PulseType)
            if (not PulseInstance) then
                continue
            end

            if (not CollectionService:HasTag(PulseInstance, "1e9")) then
                continue
            end

            PulseInstance:Destroy()
        end
    end
end

local function RemoveBarriers(_, Value)
    if (Value == true) then
        for i, v in next, getinstances() do
            if (v.Name ~= "OrderField" and v.Name ~= "MageField") then
                continue
            end

            table.insert(OrderlyBarriers, v)
            v.Parent = nil
        end
    elseif (Value == false) then
        if (#OrderlyBarriers == 0) then
            return
        end

        for i, v in next, OrderlyBarriers do
            if (v.Parent == nil) then
                v.Parent = workspace.Map
            end
        end
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

do -- // MAIN
    local WorldTab = WindowTabs.Main
    WorldTab:Separator({ Text = "MAIN" })

    local WorldHeader = WorldTab:CollapsingHeader({ Title = "World"; })

    WorldHeader:Checkbox({
        Label = "Remove Orderly Fields";
        Value = AlchemyClient.Configs.Main.NoOrderlyBarriers;
        Callback = RemoveBarriers
    })
end

do -- // CLIENT
    local ClientTab = WindowTabs.Client
    local ButtonRow = ClientTab:Row()

    ButtonRow:Button({
        Text = "Reset";
        Callback = Reset;
    })

    ButtonRow:Button({
        Text = "Kill Self";
        Callback = SelfKill
    })

    ButtonRow:Button({
        Text = "Shutdown Client";
        Callback = ShutdownClient;
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
        Callback = function(self, Value)
            AlchemyClient.Configs.Client.SpeedhackEnabled = Value
            Speedhack(nil, Value)
        end
    })

    local InfiniteJumpHeader = ClientTab:CollapsingHeader({ Title = "Infinite Jump" })

    InfiniteJumpHeader:Slider({
        Label = "Velocity";
        Format = "%.d/%s";
	    Value = AlchemyClient.Configs.Client.InfiniteJumpVelocity;
	    MinValue = 10;
	    MaxValue = 100;
	    Callback = function(self, Value)
            AlchemyClient.Configs.Client.InfiniteJumpVelocity = Value
	    end;
    })

    InfiniteJumpHeader:Checkbox({
        Label = "Infinite Jump";
        Value = AlchemyClient.Configs.Client.InfiniteJumpEnabled;
        Callback = function(self, Value)
           AlchemyClient.Configs.Client.InfiniteJumpEnabled = Value
           InfiniteJump(nil, Value)
        end
    })

    local SpoofsHeader = ClientTab:CollapsingHeader({ Title = "Client Spoofs" })

    SpoofsHeader:Separator({ Text = "Sliders" })

    SpoofsHeader:Slider({
        Label = "Climb Boost";
        Format = "%.d/%s";
	    Value = AlchemyClient.Configs.Client.ClimbSpeedValue;
	    MinValue = 10;
	    MaxValue = 200;
	    Callback = function(self, Value)
            AlchemyClient.Configs.Client.ClimbSpeedValue = (Value / 100)
	    end;
    })

    SpoofsHeader:Checkbox({
        Label = "Spoof Climb Speed";
        Value = AlchemyClient.Configs.Client.ClimbSpeedEnabled;
        Callback = EnableClimbSpoof
    })

    SpoofsHeader:Separator({ Text = "World's Pulse / Life Sense" })

    SpoofsHeader:Combo({
        Selected = AlchemyClient.Configs.Client.PulseType;
        Label = "Pulse Type";
        Items = {
            "LifeSense";
            "WorldPulseUltra";
            "WorldPulse";
        };
        Callback = function(self, Value)
            AlchemyClient.Configs.Client.PulseType = Value
        end;
    })

    SpoofsHeader:Checkbox({
        Label = "Enable Pulse";
        Value = AlchemyClient.Configs.Client.PulseSpoofEnabled;
        Callback = function(self, Value)
            local PulseType = AlchemyClient.Configs.Client.PulseType
            EnablePulse(PulseType, Value)
        end
    })

    SpoofsHeader:Separator({ Text = "Toggles" })

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

local function ClientAntiBan()
    if (Player.Character == nil) then
        return
    end
    if (Player.Character.Humanoid == nil) then
        return
    end
    
    for i, v : AnimationTrack in next, Player.Character.Humanoid:GetPlayingAnimationTracks() do
        if (string.match(v.Animation.AnimationId, "4595066903") == nil) then
            continue
        end

        Player:Kick("Kicked in order to prevent anti-cheat ban")
        ShutdownClient()
    end
end

local function ClientChecks()
    if (ClimbBoost ~= nil) then
        local ClimbBoostValue = AlchemyClient.Configs.Client.ClimbSpeedValue
        ClimbBoost.Value = ClimbBoostValue
    end
end

RunService:BindToRenderStep("ClientAntiBan", 1, ClientAntiBan)
RunService:BindToRenderStep("ClientChecks", 1, ClientChecks)

UIWindow:ShowTab(WindowTabs.Main)
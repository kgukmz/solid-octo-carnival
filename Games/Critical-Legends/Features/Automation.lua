local Automation = {}

local VirtualInputManager = GetService("VirtualInputManager")
local Players = GetService("Players")

-- // TODO: make these loops threads maybe

function Automation:AutoUse(Value)
    if (Value == false) then
        return
    end

    -- // Temporary settings and stuff until config system is made
    repeat
        local ActiveSelected = getgenv().ActiveSkill
        local UseWaitInterval = getgenv().UseWaitInterval
        local WaitInterval = getgenv().WaitInterval
    
        if (ActiveSelected == nil) then
            return
        end

        VirtualInputManager:SendKeyEvent(true, ActiveSelected, false, game)
        task.wait()
    until getgenv().AutoUseLol == false
end

function Automation:AutoMaterial()
    if (getgenv().AutoMaterial == false) then
        return
    end
    if (getgenv().MaterialString == nil) then
        return
    end
    if (getgenv().MidAction2 == true) then
        return
    end

    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character.HumanoidRootPart

    if (Character == nil or HumanoidRootPart == nil) then
        return
    end

    local MaterialTable = string.split(getgenv().MaterialString, "/")
    local MaterialGivers = workspace.MaterialGivers

    getgenv().MidAction2 = true

    for i, Material in next, MaterialTable do
        if (Material == "Iron") then
            continue
        end

        local MaterialFolder = MaterialGivers:FindFirstChild(Material)

        if (MaterialFolder == nil) then
            continue
        end

        for i, Model in next, MaterialFolder:GetChildren() do
            local Giver = Model.Giver

            firetouchinterest(Giver, HumanoidRootPart, 0)
            task.wait()
            firetouchinterest(Giver, HumanoidRootPart, 1)
        end
    end

    getgenv().MidAction2 = false
end

function Automation:AutoCollectOrb()
    if (getgenv().AutoCollectOrb == false) then
        return
    end
    if (getgenv().MidAction == true) then
        return
    end

    if (workspace:FindFirstChild("CombatFolder") == nil) then
        return
    end

    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character.HumanoidRootPart
    
    local CombatFolder = workspace.CombatFolder
    local PlayerFolder = CombatFolder:FindFirstChild(LocalPlayer.Name)

    if (PlayerFolder == nil) then
        return
    end

    local ActionOrbs = PlayerFolder:GetChildren()

    if (#ActionOrbs > 0) then
        getgenv().MidAction = true
    
        for i, Orb in next, ActionOrbs do
            if (Orb.ClassName ~= "Model") then
                continue
            end

            local Hitbox = Orb.HitBox
            firetouchinterest(Hitbox, HumanoidRootPart, 0)
            task.wait()
            firetouchinterest(Hitbox, HumanoidRootPart, 1)
        end
    end

    getgenv().MidAction = false
end

return Automation
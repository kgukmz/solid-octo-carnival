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
            local MaterialGiver = Model.Giver

            firetouchinterest(MaterialGiver, HumanoidRootPart, 0)
            task.wait()
            firetouchinterest(MaterialGiver, HumanoidRootPart, 1)
        end
    end

    getgenv().MidAction2 = false
end

function Automation:AutoCollectOrb()
    if (getgenv().AutoCollectOrb == false) then
        print("Where hav i been?")
        return
    end

    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character.HumanoidRootPart
    
    local CombatFolder = workspace:FindFirstChild("CombatFolder")

    if (CombatFolder == nil) then
        return
    end
    if (Character == nil or HumanoidRootPart == nil) then
        return
    end

    local PlayerFolder = CombatFolder:FindFirstChild(LocalPlayer.Name)
    local FolderContents = PlayerFolder:GetChildren()

    for i, Orb in next, FolderContents do
        local OrbHitbox = Orb:FindFirstChild("HitBox", true)

        if (OrbHitbox == nil) then
            repeat
                task.wait()
                OrbHitbox = Orb:FindFirstChild("HitBox")
            until OrbHitbox ~= nil or Orb == nil
        end

        firetouchinterest(OrbHitbox, HumanoidRootPart, 0)
        firetouchinterest(OrbHitbox, HumanoidRootPart, 1)
    end
end

function Automation:OrbHitboxExpand()
    if (getgenv().OrbHitboxExpand == false) then
        return
    end

    local CombatFolder = workspace:FindFirstChild("CombatFolder")
    local LocalPlayer = Players.LocalPlayer

    if (CombatFolder == nil) then
        return
    end

    local PlayerCombatFolder = CombatFolder:FindFirstChild(LocalPlayer.Name)

    if (PlayerCombatFolder == nil) then
        return
    end

    local FolderContents = PlayerCombatFolder:GetChildren()

    for i, Orb in next, FolderContents do
        local HitBox = Orb:FindFirstChild("HitBox")
        
        if (HitBox == nil) then
            repeat
                task.wait()
                HitBox = Orb:FindFirstChild("HitBox")
            until HitBox ~= nil
        end

        HitBox.Size = Vector3.new(1, 1, 1) * 1000
    end
end

function Automation:TeleportOrbs()
    if (getgenv().TeleportOrbs == false) then
        return
    end

    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character

    if (Character == nil) then
        return
    end

    local HumanoidRootPart = Character.HumanoidRootPart

    local CombatFolder = workspace:FindFirstChild("CombatFolder")

    if (CombatFolder == nil) then
        return
    end

    local PlayerFolder = CombatFolder:FindFirstChild(LocalPlayer.Name)
    
    if (PlayerFolder == nil) then
        return
    end

    local FolderContents = PlayerFolder:GetChildren()

    for i, Orb in next, FolderContents do
        if (Orb.PrimaryPart == nil) then
            repeat
                task.wait()
                PrimaryPart = Orb.PrimaryPart
            until PrimaryPart ~= nil 
        end

        pcall(Orb.SetPrimaryPartCFrame, Orb, HumanoidRootPart.CFrame)
    end
end

return Automation
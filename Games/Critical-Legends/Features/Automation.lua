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

function Automation:AutoMaterial(Value)
    if (Value == false) then
        return
    end

    repeat
        if (getgenv().MaterialString == nil) then
            return
        end

        local LocalPlayer = Players.LocalPlayer
        local MaterialTable = string.split(getgenv().MaterialString, "/")
        local MaterialGivers = workspace.MaterialGivers

        if (#MaterialTable == 0) then
            return
        end

        for i, Material in next, MaterialTable do
            if (Material == "Iron") then -- // no iron support i cba rn
                continue
            end

            local MaterialFolder = MaterialGivers:FindFirstChild(Material)
            
            if (MaterialFolder == nil) then
                continue
            end

            for i, Model in next, MaterialFolder:GetChildren() do
                if (Model.ClassName ~= "Model") then
                    continue
                end

                local Giver = Model:FindFirstChild("Giver")

                if (Giver == nil) then
                    continue
                end

                if (LocalPlayer.Character == nil) then
                    continue
                end
                
                coroutine.wrap(function()
                    firetouchinterest(Giver, LocalPlayer.Character.HumanoidRootPart, 0)
                    task.wait()
                    firetouchinterest(Giver, LocalPlayer.Character.HumanoidRootPart, 1)
                end)()
            end
        end

        task.wait(0.1)
    until getgenv().AutoMaterial == false
end

return Automation
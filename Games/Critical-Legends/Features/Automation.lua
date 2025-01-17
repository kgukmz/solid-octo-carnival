local Automation = {}

local VirtualInputManager = GetService("VirtualInputManager")

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
    
        local Part = Instance.new("Part")
        VirtualInputManager:SendKeyEvent(true, ActiveSelected, false, Part)
        Part:Destroy()
        task.wait()
    until getgenv().AutoUseLol == false
end

return Automation
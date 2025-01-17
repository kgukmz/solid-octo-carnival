local Automation = {}

local VirtualInputManager = GetService("VirtualInputManager")

function Automation:AutoUse(Value)
    if (Value == false) then
        return
    end

    -- // Temporary settings and stuff until config system is made
    repeat
        if (getgenv().IsWaiting == true) then
            return
        end

        local ActiveSelected = getgenv().ActiveSkill
        local UseWaitInterval = getgenv().UseWaitInterval
        local WaitInterval = getgenv().WaitInterval
    
        if (ActiveSelected == nil) then
            return
        end
    
        if (UseWaitInterval ~= nil and UseWaitInterval == true) then
            getgenv().IsWaiting = true
    
            task.delay(WaitInterval, function()
                getgenv().IsWaiting = nil
            end)
        end
    
        -- //VirtualInputManager:SendKeyEvent(true, ActiveSelected)
        keypress(0x31)
        keyrelease(0x31)

        task.wait()
    until getgenv().AutoUseLol == false
end

return Automation
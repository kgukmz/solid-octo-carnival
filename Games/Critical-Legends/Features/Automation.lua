local Automation = {}

local VirtualInputManager = GetService("VirtualInputManager")

function Automation:AutoUse(Value)
    if (Value == false) then
        return
    end

    -- // Temporary settings and stuff until config system is made
    repeat
        if (getgenv().IsWaiting == true) then
            continue
        end

        local ActiveSelected = getgenv().ActiveSkill
        local UseWaitInterval = getgenv().UseWaitInterval
        local WaitInterval = getgenv().WaitInterval
    
        if (ActiveSelected == nil) then
            break
        end
    
        if (UseWaitInterval ~= nil and UseWaitInterval == true) then
            if (getgenv().IsWaiting == true) then
                continue
            end

            getgenv().IsWaiting = true
    
            task.delay(WaitInterval, function()
                getgenv().IsWaiting = nil
            end)
        end
    
        VirtualInputManager:SendKeyEvent(true, ActiveSelected, false, nil)

        task.wait()
    until getgenv().AutoUseLol == false
end

return Automation
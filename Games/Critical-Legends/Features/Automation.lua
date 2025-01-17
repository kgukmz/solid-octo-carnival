local Automation = {}

local VirtualInputManager = GetService("VirtualInputManager")

function Automation:AutoUse(Value)
    if (Value == false) then
        return
    end

    if (getgenv().IsWaiting == true) then
        return
    end

    -- // Temporary settings until config system is made
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

    VirtualInputManager:SendKeyEvent(true, ActiveSelected, false, nil)
end

return Automation
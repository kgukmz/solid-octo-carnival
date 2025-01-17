local Automation = {}

local VirtualInputManager = GetService("VirtualInputManager")

function Automation:AutoUse(Value)
    if (Value == false) then
        return
    end

    local function PressAndRelease(KeyCode)
        local KeyCodes = {
            [Enum.KeyCode.One] = 0x31;
            [Enum.KeyCode.Two] = 0x32;
            [Enum.KeyCode.Three] = 0x33;
        }
        
        keypress(KeyCodes[KeyCode])
        keyrelease(KeyCodes[KeyCode])
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
    
        -- // VirtualInputManager:SendKeyEvent(true, ActiveSelected)
        -- // temp replacement idk why vim isnt workijg

        PressAndRelease(ActiveSelected)

        task.wait(0.1)
    until getgenv().AutoUseLol == false
end

return Automation
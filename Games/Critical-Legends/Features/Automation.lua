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
        local ActiveSelected = getgenv().ActiveSkill
        local UseWaitInterval = getgenv().UseWaitInterval
        local WaitInterval = getgenv().WaitInterval
    
        if (ActiveSelected == nil) then
            return
        end
    
        -- // VirtualInputManager:SendKeyEvent(true, ActiveSelected)
        -- // temp replacement idk why vim isnt workijg

        for i = 1, 5 do -- // oh no boii
            task.wait()
            PressAndRelease(ActiveSelected)
        end

        task.wait()
    until getgenv().AutoUseLol == false
end

return Automation
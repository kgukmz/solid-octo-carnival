local Main = {}

local Automation = Get_Script("Games/Critical-Legends/Features/Automation.lua")

function Main:Load(Window)
    local Tab = Window:CreateTab({
        Name = "MAIN";
        Visible = true;
    })
    
    Tab:Separator({ Text = "MAIN"; })

    local AutomationHeader = Tab:CollapsingHeader({
        Title = "Automation";
    })

    AutomationHeader:Separator({ Text = "Auto-Use"; })

    AutomationHeader:Combo({
        Placeholder = "...";
        Label = "Skill";
        Items = {
            ["Active 1"] = Enum.KeyCode.One;
            ["Active 2"] = Enum.KeyCode.Two;
            ["Active 3"] = Enum.KeyCode.Three;
        }
    })

    AutomationHeader:Checkbox({
        Label = "Auto Use"
    })
    
    AutomationHeader:Separator()

    AutomationHeader:Slider({
        Label = "Wait Interval";
        Value = 1;
        MinValue = 1;
        MaxValue = 10;
    })

    AutomationHeader:Checkbox({
        Label = "Wait Interval";
    })

    return Tab
end

return Main
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
            ["Active 3"] = Enum.KeyCode.Three;
            ["Active 2"] = Enum.KeyCode.Two;
            ["Active 1"] = Enum.KeyCode.One;
        };
        Callback = function(self, Value)
            getgenv().ActiveSkill = Value
        end
    })

    AutomationHeader:Checkbox({
        Label = "Auto Use";
        Callback = function(self, Value)
            getgenv().AutoUseLol = Value
            Automation:AutoUse(Value)
        end;
    })
    
    AutomationHeader:Separator({ Text = "Material Collection" })

    AutomationHeader:InputTextMultiline({
        PlaceHolder = "Seperate materials with '/'";
        Callback = function(self, Value)
            getgenv().MaterialString = Value;
        end
    })

    AutomationHeader:Checkbox({
        Label = "Auto Collect Materials";
        Callback = function(self, Value)
            getgenv().AutoMaterial = Value
            Automation:AutoMaterial(Value)
        end
    })

    return Tab
end

return Main
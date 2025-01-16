local Main = {}

local Removals = Get_Script("Games/Rogue-Lineage/Features/Removals.lua")

function Main:Load(Window)
    local Tab = Window:CreateTab({
        Name = "MAIN";
        Visible = true;
    })
    
    Tab:Separator({ Text = "MAIN"; })

    local WorldHeader = Tab:CollapsingHeader({
        Title = "World";
        -- // NoAnimation = true;
    })

    WorldHeader:Separator({ Text = "Visuals" })

    WorldHeader:Checkbox({
        Label = "Enable Fullbright";
        Value = false; -- // add configs
        Callback = Removals.RemoveAmbient
    });

    WorldHeader:Separator({ Text = "World" })

    WorldHeader:Checkbox({
        Label = "Remove Orderly Fields";
        Value = false; -- // add configs
        Callback = Removals.RemoveOrderFields
    });

    WorldHeader:Checkbox({
        Label = "Remove Kill Bricks";
        Value = false; -- // add configs
        Callback = Removals.RemoveKillBricks
    });

    return Tab
end

return Main
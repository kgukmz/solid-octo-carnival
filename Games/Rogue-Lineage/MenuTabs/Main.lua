local Main = {}

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

    WorldHeader:Checkbox({
        Label = "Remove Orderly Fields";
        Value = false; -- // add configs
    });

    return Tab
end

return Main
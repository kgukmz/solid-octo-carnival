local Main = {}

function Main:Load(Window)
    local Tab = Window:CreateTab({
        Name = "MAIN";
        Visible = true;
    })
    
    Tab:Separator({ Text = "MAIN"; })

    local WorldHeader = Tab:CollapsingHeader({
        Text = "World";
        NoAnimation = true;
        Image = "rbxassetid://6403436054";
    })

    return Tab
end

return Main
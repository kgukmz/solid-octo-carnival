local Client = {}

local Character = Get_Script("Games/Critical-Legends/Features/Character.lua")

function Client:Load(Window)
    local Tab = Window:CreateTab({
        Name = "CLIENT";
        Visible = true;
    })
    
    Tab:Separator({ Text = "CLIENT"; })

    Tab:Checkbox({
        Label = "Anchor Character";
        Callback = Character.Anchor
    })

    return Tab
end

return Client
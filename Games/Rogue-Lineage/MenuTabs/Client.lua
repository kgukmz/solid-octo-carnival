local Client = {}

local Character = Get_Script("Games/Rogue-Lineage/Features/Character.lua")

function Client:Load(Window)
    local Tab = Window:CreateTab({
        Name = "CLIENT";
        Visible = true;
    })
    
    local ButtonRow = Tab:Row()

    ButtonRow:Button({
        Text = "Reset";
        Callback = Character.Reset;
    })

    Tab:Separator({ Text = "CLIENT"; })

    ButtonRow:Fill()
    return Tab
end

return Client
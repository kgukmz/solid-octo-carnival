local Client = {}

local Character = Get_Script("Games/Rogue-Lineage/Features/Character.lua")

function Main:Load(Window)
    local Tab = Window:CreateTab({
        Name = "CLIENT";
        Visible = true;
    })
    
    Tab:Separator({ Text = "CLIENT"; })

    local ButtonRow = Tab:Row()

    ButtonRow:Button({
        Text = "Reset";
        Callback = Character.Reset;
    })


    ButtonRow:Fill()
    return Tab
end

return Client
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

    Tab:Checkbox({
        Label = "No Blindness";
        Value = false; -- // add configs
        Callback = Character.NoBlindness;
    });

    Tab:Checkbox({
        Label = "No Sanity [Sunken]";
        Value = false; -- // add configs
        Callback = Character.NoBlur;
    });

    Tab:Checkbox({
        Label = "No Blur";
        Value = false; -- // add configs
        Callback = Character.NoBlur;
    });

    ButtonRow:Fill()
    return Tab
end

return Client
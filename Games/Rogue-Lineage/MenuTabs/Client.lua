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

    ButtonRow:Button({
        Text = "Shutdown Client";
        Callback = game.Shutdown;
    })

    Tab:Separator({ Text = "CLIENT"; })

    local CheckboxRow = Tab:Row()

    CheckboxRow:Checkbox({
        Label = "No Shadows";
        Value = false; -- // add configs
        Callback = Character.NoShadows;
    });

    CheckboxRow:Checkbox({
        Label = "No Sanity";
        Value = false; -- // add configs
        Callback = Character.NoSanity;
    });

    CheckboxRow:Checkbox({
        Label = "No Blind";
        Value = false; -- // add configs
        Callback = Character.NoBlindness;
    });

    CheckboxRow:Checkbox({
        Label = "No Blur";
        Value = false; -- // add configs
        Callback = Character.NoBlur;
    });

    CheckboxRow:Fill()
    ButtonRow:Fill()
    return Tab
end

return Client
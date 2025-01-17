local Misc = {}

function Misc:Load(Window)
    local Tab = Window:CreateTab({
        Name = "MISC";
        Visible = true;
    })

    Tab:Image({
        Image = 140697214772731;
	    Ratio = 16 / 9;
	    AspectType = Enum.AspectType.FitWithinMaxSize;
	    Size = UDim2.fromScale(1, 1);
    })
end

return Misc
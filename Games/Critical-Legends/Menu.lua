local Menu = {}

local Library = Get_Script("Modules/UI/ImGui.lua")
local Event = Get_Script("Modules/Event.lua")

local Main = Get_Script("Games/Critical-Legends/MenuTabs/Main.lua")

function Menu:Load()
    self.Library = Library
    self.Window = Library:CreateWindow({
        Title = "Alchemy | " .. identifyexecutor(),
        Size = UDim2.fromOffset(400, 250),
        Position = UDim2.new(0.5, 0, 0, 70),
        NoResize = true,
    })

    -- // Load tabs
    self.Main = Main:Load(self.Window)

    self.Window:ShowTab(self.Main)
    self.Window:Center()
end

return Menu
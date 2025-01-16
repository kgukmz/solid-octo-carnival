local Menu = {}

local Library = Get_Script("Modules/UI/ImGui.lua")

local Main = Get_Script("Games/Rogue-Lineage/MenuTabs/Main.lua")

function Menu:Load()
    self.Library = Library
    self.Window = Library:CreateWindow({
        Title = "Alchemy | " .. identifyexecutor(),
        Size = UDim2.fromOffset(400, 250),
        Position = UDim2.new(0.5, 0, 0, 70),
        NoResize = true,
    })

    -- // Load tabs
    print("Loading...")
    print(self.Window)
    Main:Load(self.Window)

    -- // self.Window:ShowTab(self.TabNameHere)
    self.Window:Center()
end

return Menu
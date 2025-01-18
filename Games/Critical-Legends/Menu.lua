local Menu = {}

local Library = Get_Script("Modules/UI/ImGui.lua")

local Main = Get_Script("Games/Critical-Legends/MenuTabs/Main.lua")
local Client = Get_Script("Games/Critical-Legends/MenuTabs/Client.lua")

-- // features (find a diff way of doing this omds)
local Automation = Get_Script("Games/Critical-Legends/Features/Automation.lua")

function Menu:Load()
    -- // Reset global configs for CL (Temoprary until config system is made)
    getgenv().AutoMaterial = false
    getgenv().TeleportOrbs = false
    getgenv().OrbHitboxExpand = false
    getgenv().AutoCollectOrb = false
    getgenv().AutoUseLol = false
    getgenv().ActiveSkill = nil
    getgenv().UseWaitInterval = nil
    getgenv().WaitInterval = nil
    getgenv().MaterialString = nil

    self.Library = Library
    self.Window = Library:CreateWindow({
        Title = "Alchemy | " .. identifyexecutor(),
        Size = UDim2.fromOffset(400, 250),
        Position = UDim2.new(0.5, 0, 0, 70),
        NoResize = true,
    })

    -- // Load tabs
    self.Main = Main:Load(self.Window)
    self.Client = Client:Load(self.Window)

    self.Window:ShowTab(self.Main)
    self.Window:Center()

    print("Where have you been?")
    return Menu
end

function Menu:BindFunctions()
    Automation:AutoMaterial()
    Automation:OrbHitboxExpand()
    Automation:TeleportOrbs()
    Automation:AutoCollectOrb()
end

return Menu
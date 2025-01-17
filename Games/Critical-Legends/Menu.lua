local Menu = {}

local RunService = GetService("RunService")

local Library = Get_Script("Modules/UI/ImGui.lua")
local Event = Get_Script("Modules/Event.lua")

local Main = Get_Script("Games/Critical-Legends/MenuTabs/Main.lua")
local Misc = Get_Script("Games/Critical-Legends/MenuTabs/Misc.lua")

-- // features (find a diff way of doing this omds)
local Automation = Get_Script("Games/Critical-Legends/Features/Automation.lua")

function Menu:Load()
    -- // Reset global configs for CL (Temoprary until config system is made)
    getgenv().AutoMaterial = false
    getgenv().AutoUseLol = false
    getgenv().ActiveSkill = nil
    getgenv().UseWaitInterval = nil
    getgenv().WaitInterval = nil
    getgenv().MaterialString = nil
    getgenv().AutoCollectOrb = nil

    self.Library = Library
    self.Window = Library:CreateWindow({
        Title = "Alchemy | " .. identifyexecutor(),
        Size = UDim2.fromOffset(400, 250),
        Position = UDim2.new(0.5, 0, 0, 70),
        NoResize = true,
    })

    -- // Load tabs
    self.Main = Main:Load(self.Window)
    self.Misc = Misc:Load(self.Window)

    self.Window:ShowTab(self.Main)
    self.Window:Center()

    print("Where have you been?")
    return Menu
end

function Menu:BindFunctions()
    Automation:AutoCollectOrb()
end

return Menu
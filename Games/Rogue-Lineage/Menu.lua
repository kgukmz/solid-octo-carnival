local Menu = {}

local Library = Get_Script("Modules/UI/ImGui.lua")

local Main = Get_Script("Games/Rogue-Lineage/MenuTabs/Main.lua")
local Client = Get_Script("Games/Rogue-Lineage/MenuTabs/Client.lua")

function Menu:Load()
    if (getgenv().getconnections ~= nil) then
        -- // Disable Rogues Script Context Ban
        local Success, Error = pcall(function()
            for i, Connection in next, getconnections(game:GetService("ScriptContext").Error) do
                Connection:Disable()
            end
        end)

        if (Success == false) then
            warn("[ALCHEMY] Error disabling script context connections:", Error)
        end
    end

    self.Library = Library
    self.Window = Library:CreateWindow({
        Title = "Alchemy | " .. identifyexecutor(),
        Size = UDim2.fromOffset(400, 250),
        Position = UDim2.new(0.5, 0, 0, 70),
        NoResize = true,
    })

    -- // Load tabs
    print("[ALCHEMY] Loading tabs...")
    self.Main = Main:Load(self.Window)
    self.Client = Client:Load(self.Window)


    self.Window:ShowTab(self.Main)
    self.Window:Center()
end

return Menu
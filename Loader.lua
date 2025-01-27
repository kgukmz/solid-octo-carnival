local GameData = Get_Script("Modules/GameData.lua")
local Event = Get_Script("Modules/Event.lua")

local SelectedGame = GameData:GetGame()
local StartTime = tick()

warn(SelectedGame)

if (SelectedGame == nil) then
    warn("No game data for:", game.PlaceId)
    return
end

local Success, GetMenu = pcall(function()
    local ScriptPath = string.format("Games/%s/Menu.lua", SelectedGame)
    local Loaded = Get_Script(ScriptPath)

    return Loaded
end)

if (Success == false) then
    warn("Loader was unable to proceed:", Menu)
    return
end

local Menu = GetMenu:Load()

local Succes, Error = pcall(function()
    local a = true
    
    for i, Item in next, Menu do
        if (typeof(Item) ~= "function") then
            continue
        end

        local Info = debug.getinfo(Item)

        if (Info.name == "BindFunctions") then
            a = true
            break
        end
    end

    if (a == true) then
        return
    end
    
    local NewEvent = Event:Create(GetService("RunService").Heartbeat)
    NewEvent:Connect(Menu.BindFunctions)
end)

print("Took:", tick() - StartTime .. "s to load")
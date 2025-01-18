local Removals = {}

local Event = Get_Script("Modules/Event.lua")

local Lighting = GetService("Lighting")

local FullbrightConnect = Event:Create(Lighting:GetPropertyChangedSignal("Ambient"))
local OldAmbient = nil

local OrderFields = {}

function Removals:RemoveOrderFields(Value)
    if (getgenv().getinstances == nil) then
        warn("Executor does not support getinstances")
        return
    end
    
    if (Value == true) then
        for i, Object in next, getinstances() do
            if (Object.Name ~= "OrderField" and Object.Name ~= "MageField") then
                continue
            end

            if (not table.find(OrderFields, Object)) then
                table.insert(OrderFields, Object) 
            end

            Object.Parent = nil
        end
    elseif (Value == false) then
        if (#OrderFields == 0) then
            return
        end
        
        for i, Object in next, OrderFields do
            Object.Parent = workspace.Map
        end
    end
end

function Removals:RemoveKillBricks(Value)
    local BrickNames = {
        "Fire";
        "BaalField";
        "ArdorianKillbrick";
        "CryptKiller";
        "KillBrick";
        "KillFire";
        "PitKillBrick";
        "Lava";
    }

    for i, Object in next, workspace.Map:GetChildren() do
        if (table.find(BrickNames, Object.Name)) then
            continue
        end

        Object.CanTouch = not Value
    end
end

function Removals:RemoveAmbient(Value) -- // Add a scale later maybe lol
    if (Value == true) then
        OldAmbient = Lighting.Ambient
        Lighting.Ambient = Color3.fromRGB(220, 220, 220)
        print("Set ambient to white")

        FullbrightConnect:Connect(function(NewValue)
            OldAmbient = NewValue
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        end)
    elseif (Value == false) then
        FullbrightConnect:Disconnect()

        if (OldAmbient ~= nil) then
            Lighting.Ambient = OldAmbient
            print("Reverted to original ambient")
        end
    end
end

return Removals
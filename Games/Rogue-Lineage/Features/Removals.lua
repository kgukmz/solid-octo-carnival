local Removals = {}

local OrderFields = {}
local KillbrickData = {
    Fakes = {};
    Real = {};
}

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
    if (getgenv().getinstances == nil) then
        warn("Executor does not support getinstances")
        return
    end

    local FakeKillbricks = KillbrickData.Fakes
    local RealKillbricks = KillbrickData.Real

    local BrickNames = {
        "ArdorianKillbrick";
        "CryptKiller";
        "KillBrick";
        "KillFire";
        "PitKillBrick";
        "Lava";
    }

    if (Value == true) then
        if (#FakeKillbricks > 0) then
            for i, Object in next, getinstances() do
                if (not table.find(BrickNames, Object.Name)) then
                    continue
                end

                local FakeKillbrick = Object:Clone()
                FakeKillbrick:FindFirstChild("TouchInterest"):Destroy()
                FakeKillbrick.CanTouch = false

                table.insert(RealKillbricks, Object)
                Object.Parent = nil

                table.insert(FakeKillbricks, FakeKillbrick)
                FakeKillbrick.Parent = workspace.Map
            end
        else
            for i, Killbrick in next, RealKillbricks do
                Killbrick.Parent = nil
            end

            for i, Killbrick in next, FakeKillbricks do
                Killbrick.Parent = workspace.Map
            end
        end
    elseif (Value == false) then
        if (#FakeKillbricks == 0 or #RealKillbricks == 0) then
            return
        end

        for i, Killbrick in next, RealKillbricks do
            Killbrick.Parent = workspace.Map
        end

        for i, Killbrick in next, FakeKillbricks do
            Killbrick.Parent = nil
        end
    end
end

return Removals
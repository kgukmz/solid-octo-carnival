local Removals = {}

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

return Removals
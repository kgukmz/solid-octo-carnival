local GetService = {}

setmetatable(GetService, {
    __index = function(Table, Index)
        local Success, Service = pcall(function()
            return game:GetService(Index)
        end)

        if (Success == false) then
            Service = nil
        end

        return Service
    end
})

function GetService:Get(...)
    local Services = {}

    table.foreach({...}, function(_, Service)
        table.insert(Services, self[Service])
    end)

    return table.unpack(Services)
end

return GetService
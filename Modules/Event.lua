local EventModule = {}
EventModule.__index = EventModule

function EventModule:Create(Connection)
    local EventData = {
        Connection = Connection;
        Callback = nil
    }

    setmetatable(EventData, self)

    return EventData
end

function EventModule:Connect(Callback)
    if (self.Connection == nil) then
        return
    end

    if (self.Callback ~= nil) then
        self.Callback:Disconnect()
    end

    self.Callback = self.Connection:Connect(Callback)
end

function EventModule:Disconnect()
    if (self.Callback == nil) then
        return
    end

    self.Callback:Disconnect()
end

return EventModule
local ConnectionModule = {
    Connections = {}
}

function ConnectionModule:Connect(Flag, Callback)
    local NewConnection = self.Connections[Flag] = Callback
    return NewConnection
end

function ConnectionModule:Disconnect(Flag)
    if (self.Connections[Flag] == nil) then
        continue
    end

    self.Connections[Flag]:Disconnect()
    self.Connections[Flag] = nil
end

return ConnectionModule
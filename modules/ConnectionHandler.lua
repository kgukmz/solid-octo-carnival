local ConnectionHandler = {
    Connections = {}
}

function ConnectionHandler:Connect(Flag, Callback)
    local NewConnection = self.Connections[Flag]
    NewConnection = Callback()

    return NewConnection
end

function ConnectionHandler:Disconnect(Flag)
    if (self.Connections[Flag] == nil) then
        return
    end

    self.Connections[Flag]:Disconnect()
    self.Connections[Flag] = nil
end

return ConnectionHandler
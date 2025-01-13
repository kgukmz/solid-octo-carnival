local ParentDirectory = "https://raw.githubusercontent.com/kgukmz/solid-octo-carnival/main/"

local ScriptStartTick = tick()


local ImGui = loadstring(game:HttpGet('https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'))()

local Window = ImGui:CreateWindow({
	Title = "Alchemy" .. " | " .. IdentifyExecutor,
	Size = UDim2.fromOffset(400, 250),
	Position = UDim2.new(0.5, 0, 0, 70),
    NoResize = true,
})


Window:Center()
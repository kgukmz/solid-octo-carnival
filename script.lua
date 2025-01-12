local SourceURL = 'https://github.com/depthso/Roblox-ImGUI/raw/main/ImGui.lua'
local ImGui = loadstring(game:HttpGet(SourceURL))()

local Window = ImGui:CreateWindow({
	Title = "Window",
	Size = UDim2.fromOffset(250, 300),
	Position = UDim2.new(0.5, 0, 0, 70),
})
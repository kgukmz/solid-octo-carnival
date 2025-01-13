local OldRequire = require

local function DirectoryRequire(Path)
	if (type(Path) ~= "string") then
		return OldRequire(Path)
	end

	local ParentDirectory = "https://raw.githubusercontent.com/kgukmz/solid-octo-carnival/main/"
	local JapanU20Match = ParentDirectory .. Path

	local Success, Response = pcall(function()
		return game:HttpGet(JapanU20Match)
	end)

	if (Success == false) then
		warn("Error:", Response)
		return nil
	end

	return loadstring(Response)()
end

getgenv().require = DirectoryRequire
local OldRequire = require

local function DirectoryRequire(Path)
	if (type(Path) ~= "string") then
		return OldRequire(Path)
	end

	local ParentDirectory = "https://raw.githubusercontent.com/kgukmz/solid-octo-carnival/main/"
	local JapanU20Match = ParentDirectory 
end

getgenv().require = DirectoryRequire
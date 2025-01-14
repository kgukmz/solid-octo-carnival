local OldRequire = require

local function DirectoryRequire(Path)
	if (type(Path) ~= "string") then
		local ModuleScript = OldRequire(Path)
		return ModuleScript
	end

	local MainDirectory = "https://raw.githubusercontent.com/kgukmz/solid-octo-carnival/refs/heads/main/"
	local RequestedFile = (MainDirectory .. Path)

	local Success, Request = pcall(function()
		return http_request({
			Url = RequestedFile;
			Method = "GET";
		})
	end)

	if (Request and Request.Body == nil) then
		return nil
	end

	return loadstring(Request.Body)()
end

getgenv().require = DirectoryRequire

DirectoryRequire("loader.lua")

if (getgenv().cloneref == nil) then
	warn("cloneref is not supported")
	return nil
end

local function GetService(Service)
	return cloneref(game:GetService(Service))
end

local function GetScript(Path)
	local MainDirectory = "https://raw.githubusercontent.com/kgukmz/solid-octo-carnival/refs/heads/main/"
	local RequestedFile = (MainDirectory .. Path)

	local Success, Request = pcall(function()
		return http_request({
			Url = RequestedFile;
			Method = "GET";
		})
	end)

	if (Success == false) then
		warn("Error:", Request)
		return nil
	end

	return loadstring(Request.Body)()
end

getgenv().GetService = GetService
getgenv().Get_Script = GetScript

GetScript("Loader.lua")
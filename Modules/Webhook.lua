local Webhook = {}
Webhook.__index = Webhook

function Webhook.new(WebhookURL)
    local self = setmetatable({}, Webhook)
    
    self.WebhookURL = WebhookURL

    return self
end

function Webhook:SendEmbed(Data)
    if (self.WebhookURL == nil) then
        warn("No webhook url set")
        return
    end

    http_request({
        Url = self.WebhookURL;
        Method = "POST";
        Headers = {
            ["Content-Type"] = "application/json";
        };
        Body = GetService("HttpService"):JSONEncode({
            embeds = Data
        })
    })
end

return Webhook
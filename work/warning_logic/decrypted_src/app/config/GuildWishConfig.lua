--[[
    公会许愿池相关配置文件
]]--

local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local GuildWish = {}
Config.GuildWish = GuildWish 

local GuildWishDataCache = nil

function GuildWish:getCfgData()
    if not GuildWishDataCache then
        GuildWishDataCache = require("profiles/commonProfile/ProfileFountain")
    end

    local cfg = GuildWishDataCache[1]
    return cfg;
end

function GuildWish:clear()
    reload_script_file("profiles/commonProfile/ProfileFountain")
    GuildWishDataCache = nil
end
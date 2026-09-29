--[[
    梦境商店相关配置文件
]]--

local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local DreamShop = {}
Config.DreamShop = DreamShop 

local DreamShopDataCache = nil

function DreamShop:getShopItem(level, index)
    if not DreamShopDataCache then
        DreamShopDataCache = require("profiles/commonProfile/ProfileDreamShop")
    end

    local cfg = DreamShopDataCache[level];
    if not cfg then
        return {};
    end

    local item = {};
    item.id = cfg.itemContent[index];
    item.num = cfg.itemNum[index];
    item.cost = cfg.itemValue[index];
    return item;
end

function DreamShop:clear()
    reload_script_file("profiles/commonProfile/ProfileDreamShop")
    DreamShopDataCache = nil
end
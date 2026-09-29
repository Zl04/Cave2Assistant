-- GemShopConfig.lua
-- Author: ydli
-- Date: 2018-06-19
--宝石商店配置表
local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local GemShopConfig = {}
Config.GemShopConfig = GemShopConfig 

-- 缓存配置数据
local DataCache = nil

function GemShopConfig:getAllGemStoneShopData()
    if (not DataCache) then
        local list = require("profiles/commonProfile/ProfileGemstoneShop")
        assert(type(list) == "table", "[ERROR] GemShopConfig DataCache: could not get all the GemShopConfig config.")
        DataCache = {}
        for k,v in pairs(list) do
            if type(v) == "table" and v.ID then
                v.description = LanguageManager:getInstance():getLocalString(v.description)
                v.contentDesc = LanguageManager:getInstance():getLocalString(v.contentDesc)
                v.name = LanguageManager:getInstance():getLocalString(v.name)
                v.explorationExpDesc = UI.TEXT_223903 .. v.explorationExp
                table.insert(DataCache, v)
            end
        end
    end
    return DataCache
end

function GemShopConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileGemstoneShop")
    DataCache = nil
end
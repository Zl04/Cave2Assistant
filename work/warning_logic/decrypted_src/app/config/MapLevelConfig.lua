-- MonsterAffixConfig.lua
-- Author:zp
-- 2017年4月12日
-- Using:地图怪物配置

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local MapLevel = {}
Config.MapLevel = MapLevel

local mapLevelConfigList = {}
-- 根据效果id获取配置数据
function MapLevel:getMapLevelConfig(level, caveMode, caveDiffculty)
    local filename = string.format("profiles/dataProfile/ProfileClientLevel_%d_%d", caveMode, caveDiffculty)
    local path = cc.FileUtils:getInstance():fullPathForFilename(filename..".lua")
    if not cc.FileUtils:getInstance():isFileExist(path) then
        return nil
    end
    local mapConfig = require(filename);
    table.insert(mapLevelConfigList, filename)
    local levelConfig = nil
    if(mapConfig) then
        levelConfig = mapConfig[level]
    end

    return levelConfig
end

-- 清理
function MapLevel:clear()
    for k,v in pairs(mapLevelConfigList) do
        reload_script_file(v)
    end
    mapLevelConfigList = {}
end
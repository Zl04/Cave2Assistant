--[[
    梦境挑战相关配置文件
]]--

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local Dream = {}
Config.DreamConfig = Dream

-- 缓存效果配置数据
local DreamDataCache = nil
local MaxSize = 0

-- 根据效果id获取配置数据
function Dream:getDreamForLV(LV)
    if(DreamDataCache == nil) then 
        local temp = require("profiles/commonProfile/ProfileDream")
        DreamDataCache = {}
        for k,v in pairs(temp) do
            if (type(v) == "table") then
                table.insert(DreamDataCache, v)
            end
        end
        MaxSize = table.nums(DreamDataCache)
    end

    return DreamDataCache[LV], MaxSize
end

-- 清理
function Dream:clear()
    reload_script_file("profiles/commonProfile/ProfileDream")
    DreamDataCache = nil
end
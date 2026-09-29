--[[
    效果配置文件
]]--

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local Effect = {}
Config.Effect = Effect

-- 缓存效果配置数据
local effectDataCache = nil

-- 获取所有的效果配置数据
function Effect:getAllEffect()
    if (not effectDataCache) then
        effectDataCache = require("profiles/commonProfile/ProfileEffect")
        
        assert(type(effectDataCache) == "table", "[ERROR] Effect getAllEffect: could not get effect config.")
    end
    return effectDataCache
end

-- 根据效果id获取配置数据
function Effect:getEffect(effectID)
    local allEffectData = self:getAllEffect()
    if (allEffectData) then
        local data = allEffectData[effectID]
        if(data) then
            return data
        else
            assert(false,string.format("Effect:getEffect  Effect:getEffect=%d  not found config", effectID))
            return nil
        end
    else
        return nil
    end
end

-- 清理
function Effect:clear()
    reload_script_file("profiles/commonProfile/ProfileEffect")
    effectDataCache = nil
end
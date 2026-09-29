-- 天气系统

Config = Config or {}

local Weather = {}
Config.Weather = Weather 

-- 缓存效果配置数据
local WeatherDataCache = nil

function Weather:getAllWeather()
    -- 考虑这里是否做全局缓存
    if (not WeatherDataCache) then
    -- 获取所有技能
        WeatherDataCache = require("profiles/commonProfile/ProfileWeather")
    end

    return WeatherDataCache
end

-- 根据任务ID获取任务数据
function Weather:getWeatherById(id)
    local all = self:getAllWeather()

    local weather = all[id]

    return weather
end

function Weather:random()
    local all = self:getAllWeather()
    local max = all.size
    local r = math.random( 1,max )
    local w = all[r]
    return w
end

function Weather:clear()
    reload_script_file("profiles/commonProfile/ProfileWeather")
    WeatherDataCache = nil
end

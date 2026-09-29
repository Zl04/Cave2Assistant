

Config = Config or {}


local PlotEventConfig = {}
Config.PlotEventConfig = PlotEventConfig 

-- 缓存效果配置数据
local PlotEventConfigDataCache = nil

function PlotEventConfig:getAllPlotEventConfig()
    -- 获取所有技能
    if (not PlotEventConfigDataCache) then
        PlotEventConfigDataCache = require("profiles/dataProfile/ProfileClientPlotEvent")
        
        assert(type(PlotEventConfigDataCache) == "table", "[ERROR] PlotEventConfig getAllPlotEventConfig: could not get all the PlotEventConfig config.")
    end
    return PlotEventConfigDataCache
end



function PlotEventConfig:getPlotEventConfig(plotEventID)
    plotEventID = tonumber(plotEventID)

    local allPlotEventConfig = self:getAllPlotEventConfig()
    return clone(allPlotEventConfig[plotEventID])
end


-- 清理
function PlotEventConfig:clear()
    reload_script_file("profiles/dataProfile/ProfileClientPlotEvent")
    PlotEventConfigDataCache = nil
end
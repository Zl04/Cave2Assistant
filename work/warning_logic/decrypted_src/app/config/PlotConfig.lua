

Config = Config or {}


local PlotConfig = {}
Config.PlotConfig = PlotConfig 

-- 缓存效果配置数据
local PlotConfigDataCache = nil

function PlotConfig:getAllPlotConfig()
    -- 获取所有技能
    if (not PlotConfigDataCache) then
        PlotConfigDataCache = require("profiles/dataProfile/ProfileClientPlot")

        for k,v in pairs(PlotConfigDataCache) do

            if type(v) == "table" and v.ID then
                local txtPlot = "return "..v.plot
                local fun = assert(loadstring(txtPlot))
                local plot = fun()
                v.plot = plot
            end
        end
        
        assert(type(PlotConfigDataCache) == "table", "[ERROR] PlotConfig getAllPlotConfig: could not get all the PlotConfig config.")
    end
    return PlotConfigDataCache
end



function PlotConfig:getPlotConfig(plotID)
    plotID = tonumber(plotID)
    local allPlotConfig = self:getAllPlotConfig()

    return clone(allPlotConfig[plotID])
end


-- 清理
function PlotConfig:clear()
    reload_script_file("profiles/dataProfile/ProfileClientPlot")
    PlotConfigDataCache = nil
end
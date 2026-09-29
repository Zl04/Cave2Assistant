
--[[
    处理技能树 数据定义
]]

require "app.datas.GameData"

--事件类型


local PlotData = class("PlotData",GameData.Base)

Data = Data or {}
Data.PlotData = PlotData

PlotDataID = 1

-- 构造函数(会自动调用)  
function PlotData:ctor()
    self.super.ctor(self,Category.PLOT)
    self.PlotDataID = PlotDataID        --剧情唯一ID
    PlotDataID = PlotDataID + 1
    self.id = 1;            --模板ID
    self.plot = {};         --剧情事件轴
    self.plotTime = 0       --剧情行进事件
end

--事件ID
function PlotData:getID()
    return self.id
end


--事件类型
function PlotData:getPlot()
    return self.plot
end

function PlotData:getPlotTime()
    return self.plotTime
end

function PlotData:setPlotTime(var)
    self.plotTime = var
end

function PlotData:initNet(mesData)
    --TODO 根据网络数据初始化
    self.id = mesData.ID or 1;
    self.plot = mesData.plot or nil
    self.plotTime = 0
end





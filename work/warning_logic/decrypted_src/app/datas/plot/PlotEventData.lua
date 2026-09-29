
--[[
    处理技能树 数据定义
]]

require "app.datas.GameData"

--事件类型


local PlotEventData = class("PlotEventData",GameData.Base)

Data = Data or {}
Data.PlotEventData = PlotEventData

PlotEventDataID = 1

-- 构造函数(会自动调用)  
function PlotEventData:ctor()
    self.super.ctor(self,Category.PLOT)
    self.plotEventDataID = PlotEventDataID
    PlotEventDataID = PlotEventDataID + 1
    self.id = 1;                                --模板ID
    self.eventType = PlotEventType.NONE;        --事件类型
    self.params = {}

end

--事件ID
function PlotEventData:getID()
    return self.id
end

--事件类型
function PlotEventData:getType()
    return self.eventType
end

--获取参数
function PlotEventData:getParam()
    return self.params
end


function PlotEventData:initNet(mesData)
    --TODO 根据网络数据初始化
    
    self.id = mesData.id or 1;
    self.eventType = mesData.type or PlotEventType.NONE
    
    
    self.params = {}
    if mesData.param1 then
        table.insert(self.params,mesData.param1)
    end
    if mesData.param2 then
        table.insert(self.params,mesData.param2)
    end
    if mesData.param3 then
        table.insert(self.params,mesData.param3)
    end
    if mesData.param4 then
        table.insert(self.params,mesData.param4)
    end
    if mesData.param5 then
        table.insert(self.params,mesData.param5)
    end
    if mesData.param6 then
        table.insert(self.params,mesData.param6)
    end
end





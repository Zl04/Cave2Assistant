--[[--
数据模型MainCityModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/10/16
--desc	: MainCityModel
------------------------------------------------------------------------------

local MainCityModel = class("MainCityModel",mvc.GameModel)

function MainCityModel:initData()
	self._choiceTriggerData = nil
end

function MainCityModel:setChoiceTriggerData(triggerData)
    self._choiceTriggerData = triggerData
end

function MainCityModel:getChoiceTriggerData()
    return self._choiceTriggerData
end


return MainCityModel
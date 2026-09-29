--[[--
数据模型RelicModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/05/19
--desc	: RelicModel
------------------------------------------------------------------------------

local RelicModel = class("RelicModel",mvc.GameModel)

function RelicModel:initData()
	
end


return RelicModel
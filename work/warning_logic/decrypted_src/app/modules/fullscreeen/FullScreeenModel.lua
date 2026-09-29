--[[--
数据模型FullScreeenModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/05/06
--desc	: FullScreeenModel
------------------------------------------------------------------------------

local FullScreeenModel = class("FullScreeenModel",mvc.GameModel)

function FullScreeenModel:initData()
	
end


return FullScreeenModel
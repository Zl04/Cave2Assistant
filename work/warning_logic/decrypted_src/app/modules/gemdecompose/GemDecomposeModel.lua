--[[--
数据模型GemDecomposeModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/04/26
--desc	: GemDecomposeModel
------------------------------------------------------------------------------

local GemDecomposeModel = class("GemDecomposeModel",mvc.GameModel)

function GemDecomposeModel:initData()
	
end


return GemDecomposeModel
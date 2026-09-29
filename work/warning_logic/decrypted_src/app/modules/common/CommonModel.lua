--[[--
数据模型CommonModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/11
--desc	: CommonModel
------------------------------------------------------------------------------

local CommonModel = class("CommonModel",mvc.GameModel)

function CommonModel:initData()
	
end


return CommonModel
--[[--
数据模型RoleReincarnationModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/03/06
--desc	: RoleReincarnationModel
------------------------------------------------------------------------------

local RoleReincarnationModel = class("RoleReincarnationModel",mvc.GameModel)

function RoleReincarnationModel:initData()
	
end


return RoleReincarnationModel
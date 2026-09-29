--[[--
数据模型PetReincarnationModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/03/17
--desc	: PetReincarnationModel
------------------------------------------------------------------------------

local PetReincarnationModel = class("PetReincarnationModel",mvc.GameModel)

function PetReincarnationModel:initData()
	
end


return PetReincarnationModel
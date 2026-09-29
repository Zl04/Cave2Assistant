--[[--
数据模型BarterTableModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/25
--desc	: BarterTableModel
------------------------------------------------------------------------------

local BarterTableModel = class("BarterTableModel",mvc.GameModel)

function BarterTableModel:initData()
	self.npcId = nil
end

function BarterTableModel:setNpc(npc)
    self.npcId = npc
end

function BarterTableModel:getNpcId()
    return self.npcId
end

return BarterTableModel
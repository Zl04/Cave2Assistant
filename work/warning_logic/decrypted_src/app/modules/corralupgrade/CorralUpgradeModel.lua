--[[--
数据模型CorralUpgradeModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/05/10
--desc	: CorralUpgradeModel
------------------------------------------------------------------------------

local CorralUpgradeModel = class("CorralUpgradeModel",mvc.GameModel)

function CorralUpgradeModel:initData()
	self._itemData = {}
end

function CorralUpgradeModel:setItemData(itemData)
	self._itemData = itemData or {}
end

function CorralUpgradeModel:getItemData()
	return self._itemData
end


return CorralUpgradeModel
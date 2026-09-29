--[[--
数据模型DeepInWormholeModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/11/28
--desc	: DeepInWormholeModel
------------------------------------------------------------------------------

local DeepInWormholeModel = class("DeepInWormholeModel",mvc.GameModel)

function DeepInWormholeModel:initData()
	self.curTabIndex = 1
    self.deepInWormholeData = {}
end

function DeepInWormholeModel:setTabIndex(idx)
	self.curTabIndex = idx
end

function DeepInWormholeModel:getTabIndex()
	return self.curTabIndex
end

function DeepInWormholeModel:getCurLevel()
	return (self.curTabIndex-1)*10+1
end

function DeepInWormholeModel:getCurLevelByCopyLevel(level)
	return (level-1)*10+1
end

return DeepInWormholeModel
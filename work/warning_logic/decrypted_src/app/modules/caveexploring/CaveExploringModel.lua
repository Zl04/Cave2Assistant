--[[--
数据模型CaveExploringModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/06/07
--desc	: CaveExploringModel
------------------------------------------------------------------------------

local CaveExploringModel = class("CaveExploringModel",mvc.GameModel)

function CaveExploringModel:initData()
	self.boxMapInfo = {}
    self.refreshNum = 0
end

function CaveExploringModel:initBoxMapInfo(data)
	-- self.boxMapInfo = data
    for k, v in pairs(data.info) do
        self.boxMapInfo[v.id] = v.boxinfo
    end
    self.boxMapInfo.refreshNum = data.refreshNum
    self.boxMapInfo.isEnterCaved = data.isEnterCaved
end

function CaveExploringModel:getBoxMapInfo()
	return self.boxMapInfo
end

return CaveExploringModel
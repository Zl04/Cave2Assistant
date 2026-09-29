--[[--
数据模型EverWinterRiftModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/02/16
--desc	: EverWinterRiftModel
------------------------------------------------------------------------------

local EverWinterRiftModel = class("EverWinterRiftModel",mvc.GameModel)

function EverWinterRiftModel:initData()
	self.curTabIndex = 1
    self.everWinterRiftData = {}
end

function EverWinterRiftModel:setEverWinterRiftData(data)
	self.everWinterRiftData = data
end

function EverWinterRiftModel:getEverWinterRiftData()
	return self.everWinterRiftData
end

function EverWinterRiftModel:setTabIndex(idx)
	self.curTabIndex = idx
end

function EverWinterRiftModel:getTabIndex()
	return self.curTabIndex
end

function EverWinterRiftModel:getCurLevel()
	return (self.curTabIndex-1)*10+1
end

function EverWinterRiftModel:getCurLevelByCopyLevel(level)
	return (level-1)*10+1
end

function EverWinterRiftModel:checkIsCanGetRewardsByID(id)
    local fightInfo = self.everWinterRiftData.fightInfo
	if not self.everWinterRiftData.fightInfo then
        return false
    end
    local can = false
    for k, v in pairs(fightInfo) do
        if v.configId == id and v.flag == 1 then
            can = true
            break
        end
    end
    return can
end

function EverWinterRiftModel:checkIsCanGetRewards()
    local fightInfo = self.everWinterRiftData.fightInfo
	if not self.everWinterRiftData.fightInfo then
        return false
    end
    local can = false
    for k, v in pairs(fightInfo) do
        if v and v.flag == 1 then
            can = true
            break
        end
    end
    return can
end

function EverWinterRiftModel:checkIsGetRewardsByID(id)
    local fightInfo = self.everWinterRiftData.fightInfo
	if not self.everWinterRiftData.fightInfo then
        return false
    end
    local get = false
    for k, v in pairs(fightInfo) do
        if v.configId == id and v.flag == 2 then
            get = true
            break
        end
    end
    return get
end



return EverWinterRiftModel
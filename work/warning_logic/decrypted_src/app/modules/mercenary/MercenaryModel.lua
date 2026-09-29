--[[--
数据模型MercenaryModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2021/04/07
--desc	: MercenaryModel
------------------------------------------------------------------------------

local MercenaryModel = class("MercenaryModel",mvc.GameModel)

function MercenaryModel:initData()
	self.gameDay = 0
    self.hireCount = 0
    self.timestamp = 0
    self._mercenaryList = nil -- 用于等待加载列表的处理 
    self.mercenaryList = nil

    -- 本地数据
    self._mercenaryCostArr = nil

    -- TODO test
    -- self.mercenaryList = {}
    -- for i=1, 5, 1 do 
    --     local oneData = {}
    --     oneData.baseData = {}
    --     oneData.baseData.pk = i--;                 // 佣兵玩家PK
    --     oneData.baseData.name = "fsdfasdfjsld"--               // 名字
    --     oneData.baseData.level = 3--              // 等级
    --     oneData.baseData.job = 4--                // 职业
    --     oneData.baseData.faceDecodeId = 5--       // 头像
    --     oneData.baseData.equips = {}--             // 装备ID（用于显示玩家形象）
    --     local equipIDArr = {21010050, 21010050, 21010051, 21010060}
    --     for k,v in ipairs(equipIDArr) do 
    --         local oneEqui = {}
    --         oneEqui.id = v
    --         oneEqui.index = k
    --         oneEqui.illusion = 0
    --         table.insert(oneData.baseData.equips, oneEqui)
    --     end

    --     oneData.baseData.skills = {30300505, 30300506, 30300507, 30300508, 30300509}--            // 技能列表
    --     oneData.baseData.sex = 1--
    --     oneData.baseData.looks = 0--              // 外观
    --     oneData.hirer = {hirer=1}

    --     table.insert(self.mercenaryList, oneData)
    -- end
end

function MercenaryModel:handleMercenaryList(data)
    self.gameDay = data.gameDay
    if(data.serialNo == 0 or self._mercenaryList == nil) then
        self._mercenaryList = {}
    end
    -- local list = {}
    for k, v in ipairs(data.list) do 
        local oneData = {}
        oneData.hirer = v.hirer
        oneData.baseData = v.baseData

        -- list[k] = oneData
        table.insert(self._mercenaryList, oneData)
    end
    self.timestamp = data.timestamp
    self.hireCount = data.hireCount
    if(data.isEnd) then
        self:set("mercenaryList", self._mercenaryList)
        self._mercenaryList = nil
    end
end

function MercenaryModel:getMercenaryRefreshTimestamp()

    return self.timestamp
end

function MercenaryModel:getMercenaryList()

    return self.mercenaryList
end

function MercenaryModel:triggerNewDay(refreshDay)
    -- add by zp 在打开页面的时候会主动重新拉取最新的数据
    -- if(refreshDay > self.gameDay) then
    --     Net.NetRoleSystem:reqMercenaryList()
    -- end
end

-- 获取雇佣花费
function MercenaryModel:getMercenaryCostNum()
    self:_initMercenaryCost()
    if(self._mercenaryCostArr and #self._mercenaryCostArr > 0) then 
        if(self._mercenaryCostArr[self.hireCount + 1]) then 
            return self._mercenaryCostArr[self.hireCount + 1].cost
        end

        return self._mercenaryCostArr[#self._mercenaryCostArr].cost
    end
    return 0
end

-- 获取今日雇佣次数
function MercenaryModel:getMercenaryNum()
    return self.hireCount
end

-- 获取每日雇佣限制次数
function MercenaryModel:getOneDayMercenaryNum()
    self:_initMercenaryCost()

    if(self._mercenaryCostArr) then
        return #self._mercenaryCostArr
    else
        return 0
    end
end

-- 获取雇佣复活时间（秒）
function MercenaryModel:getMercenaryReviveTimeSeconds()
    
    return tonumber(ConfigManager:getGeneralForKey("resurrectionMercenaryTime"))
end

function MercenaryModel:_initMercenaryCost()
    if(self._mercenaryCostArr == nil) then
        self._mercenaryCostArr = {}
        local mercenaryCost = ConfigManager:getGeneralForKey("mercenaryCost")
        print("_initMercenaryCost", mercenaryCost)
        if(mercenaryCost) then 
            local strArr = string.split(mercenaryCost, ";")
            for k,v in ipairs(strArr) do
                local arr = string.split(v, ",")
                local oneData = {}
                oneData.ID = tonumber(arr[1])
                oneData.cost = tonumber(arr[2])
                print("_initMercenaryCost", k, oneData)
                self._mercenaryCostArr[k] = oneData
            end
        end
    end
end

return MercenaryModel
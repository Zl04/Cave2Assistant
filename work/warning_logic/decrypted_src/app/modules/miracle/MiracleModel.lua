--[[--
数据模型MiracleModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/12/07
--desc	: MiracleModel
------------------------------------------------------------------------------

local MiracleModel = class("MiracleModel",mvc.GameModel)

function MiracleModel:initData()
    self.miracleSlots = nil -- 神迹属性数据 MiraclePrayerSlotData
    self.lastDrawDay = 0 -- 最近一次抽取游戏日
    self.drawCount = 0   -- 当日抽取次数

    -- 配置数据信息
    local prayerCost = ConfigManager:getGeneralForKey("miraclePrayerCost")
    local arr = string.split(prayerCost, ",")
    local costArr = {}
    for k,v in ipairs(arr) do 
        table.insert(costArr, tonumber(v))
    end
    self.miraclePrayerCostArr = costArr
end

function MiracleModel:hanldePrayerData(data)
    self.miracleSlots = data.slots
    self.lastDrawDay = data.lastDrawDay
    self.drawCount = data.drawCount
end

function MiracleModel:getAllMiracleSlotData()
    return self.miracleSlots
end

function MiracleModel:getMiracleSlotDataByID(ID)
    if(self.miracleSlots) then 
        for k,slot in ipairs(self.miracleSlots) do 
            if(slot.slotId == ID) then 
                return slot
            end
        end
    end

    return nil
end

function MiracleModel:getTotalDrawCount()
    if(RoleDataManager:getMaster():getRefreshDay() ~= self.lastDrawDay) then 
        return 0
    end

    return self.drawCount
end

--[[
    获取祈福花费，nil表示不能在祈福
]]
function MiracleModel:getPrayerCost()
    local count = self:getTotalDrawCount()
    if(self.miraclePrayerCostArr[count + 1]) then 
        return self.miraclePrayerCostArr[count + 1]
    end

    return nil
end

function MiracleModel:getPrayerTotalNum()
    if(self.miraclePrayerCostArr) then 
        return #self.miraclePrayerCostArr
    end

    return 0
end

--[[
    获取道具祈福次数
    return 次数，是否锁定
]]
function MiracleModel:getItemPrayerNum()

    return GoodsDataManager:getGoodsDataNum(RoleDataManager:getMasterPK(), PublicDefine.PACKET_TYPE.PACKET_BAG, PublicDefine.ITEM_ID.ITEM_ID_DRAW_MIRACLEPRAYER, true)
end

function MiracleModel:getIsShowRedHot()
    -- if(self:getItemPrayerNum()>0) then 
    --     return true
    -- end
    if(self:getPrayerCost() == 0) then 
        return true
    end

    return false
end

function MiracleModel:getAllMiracleAttributes()

    return ConfigManager:getAllMiracleAttributes()
end

function MiracleModel:getAllPrayerIcon()
    return ConfigManager:getAllMiraclePrayerIcon()
end

--[[
    根据属性ID计算该属性值添加的
]]
function MiracleModel:getPrayerAttr(attrID)
    local attrData = ConfigManager:getMiracleAttributesByID(attrID)
    local attrArr = {}
    if(attrData) then
        local slotData = self:getMiracleSlotDataByID(attrID)
        if(slotData) then
            local masterData = RoleDataManager:getMaster()
            table.insert(attrArr, self:createOneAttrArr(attrData.attributeslist, slotData.level, masterData:getLevel()))
            table.insert(attrArr, self:createOneAttrArr(attrData.attributeslist, slotData.level + 1, masterData:getLevel()))
        end
    end

    return attrArr
end

function MiracleModel:createOneAttrArr(attributeslist, level, masterLevel)
    local attrArr = {}
    local prayerData = ConfigManager:getMiraclePrayerByID(level)
    local coefficentData = ConfigManager:getMiracleCoefficientByID(masterLevel)
    if(prayerData and coefficentData) then
        for k, v in ipairs(attributeslist) do 
            local attrNum = self:calculationAttr(coefficentData, prayerData, v, false, false)
            local showData = {}
            showData.title = ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[v])
            showData.attrNum = attrNum

            table.insert(attrArr, showData)
        end
    end

    return attrArr
end

function MiracleModel:calculationAttr(coefficentData, prayerData, attrType, isCoin, isCrystal)
    if(coefficentData == nil or prayerData == nil ) then 
        printError("MiracleModel:calculationAttr params is error dataIsNil=", coefficentData==nil, prayerData == nil)
        return 0
    end

    -- data[1] = { ID = 1,  attributeCofficent = "51,1;54,1;53,1;59,1;60,1;61,1;62,1;63,1;64,1;56,1;67,1",  coinCofficent = "1",  crystalCofficent = "1"}
    -- data[1] = { ID = 1,  exp = 0,  baseAttribute = "51,19;54,5;53,3;59,4;60,2;61,2;62,2;63,2;64,2;56,4;67,4",  coin = 10000,  crystal = 5}
    if isCoin then 
        return math.floor( tonumber(prayerData.coin) * tonumber(coefficentData.coinCofficent) / 3 )
    elseif isCrystal then 
        return math.floor( tonumber(prayerData.crystal) * tonumber(coefficentData.crystalCofficent) / 3 )
    elseif attrType then
        if coefficentData.attrArr == nil then 
            local strArr = string.split(coefficentData.attributeCofficent, ";")
            local attrArr = {}
            for k, v in ipairs(strArr) do
                local numArr = string.split(v, ",")
                attrArr[tonumber(numArr[1])] = tonumber(numArr[2])
            end

            coefficentData.attrArr = attrArr
        end

        if prayerData.attrArr == nil then 
            local strArr = string.split(prayerData.baseAttribute, ";")
            local attrArr = {}
            for k, v in ipairs(strArr) do
                local numArr = string.split(v, ",")
                attrArr[tonumber(numArr[1])] = tonumber(numArr[2])
            end

            prayerData.attrArr = attrArr
        end

        if(coefficentData.attrArr 
            and prayerData.attrArr 
            and prayerData.attrArr[attrType] 
            and coefficentData.attrArr[attrType]) then 
            return math.floor(prayerData.attrArr[attrType] * coefficentData.attrArr[attrType] / 3 )
        end
    else
        printError("MiracleModel:calculationAttr params is error attrType, isCoin, isCrystal=", attrType, isCoin, isCrystal)
    end

    return 0
end

function MiracleModel:getLimitLevel()
    local masterData = RoleDataManager:getMaster()
    
    local heroLevel = 1
    local minLimitLevel = 1
    local limitLevel = 0
    if(masterData and allLevelLimit) then
        heroLevel = masterData:getLevel()
    end

    local allLevelLimit = ConfigManager:getAllMiracleLevelLimit()
    for k, v in pairs(allLevelLimit) do 
        if(v.playerlevel <= heroLevel) then
            if(limitLevel< v.levellimit) then 
                limitLevel = v.levellimit 
            end
        end
        if(minLimitLevel > v.levellimit) then 
            minLimitLevel = v.levellimit
        end
    end
    if(limitLevel == 0) then 
        limitLevel = minLimitLevel
    end

    return limitLevel
end

return MiracleModel
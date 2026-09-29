--[[--
数据模型ExpeditionModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/05/09
--desc	: ExpeditionModel
------------------------------------------------------------------------------

local ExpeditionModel = class("ExpeditionModel",mvc.GameModel)

function ExpeditionModel:initData()
    self.expeditionStatus = false;     -- 探险状态
    self.startTime = 0;          -- 探险的开始时间(对时的服务器时间)
    self.usedTime = 0;           -- 探险使用时间
    self.quickExpeditionNum = 0; -- 快速探险使用次数
    self.caveMode = 0;           -- 洞窟模式(MODE_HERO|MODE_NORMAL)
    self.caveLevel = 0;          -- 选择关卡
    self.speedMode = 0;           -- 增益模式
    self.speedLevel = 0;          -- 增益关卡
    self.speedType = 0;           -- 0 标识金币，1 标识经验

    self.normalCoin = 0;        -- 普通金币
    self.normalExp = 0;         -- 普通经验
    self.quickCoin = 0;         -- 快速金币
    self.quickExp = 0;          -- 快速经验

    -- 客户端计算时间
    self.noticeDataServerTime = 0;

    -- self.expeditionStatus = true;     -- 探险状态
    -- self.startTime = 0;          -- 探险的开始时间(对时的服务器时间)
    -- self.usedTime = 0;           -- 探险使用时间
    -- self.quickExpeditionNum = 0; -- 快速探险使用次数
    -- self.caveMode = 1;           -- 洞窟模式(MODE_HERO|MODE_NORMAL)
    -- self.caveLevel = 2001;          -- 选择关卡
    -- self.speedMode = 4;           -- 增益模式
    -- self.speedLevel = 2001;          -- 增益关卡
    -- self.speedType = 2;           -- 1 标识金币，2 标识经验
end

function ExpeditionModel:updateExpeditionData(expeditionData)
    if(expeditionData) then 
        self.expeditionStatus = expeditionData.expeditionStatus;     
        self.startTime = expeditionData.startTime;          
        self.usedTime = expeditionData.usedTime;      
        self.quickExpeditionNum = expeditionData.quickExpeditionNum; 
        self.caveMode = expeditionData.caveMode;           -- 洞窟模式(MODE_HERO|MODE_NORMAL)
        self.caveLevel = expeditionData.caveLevel;          -- 选择关卡
        self.speedMode = expeditionData.speedMode;           -- 增益模式
        self.speedLevel = expeditionData.speedLevel;         -- 增益关卡
        self.speedType = expeditionData.speedType;           -- 枚举 ExpeditionSpeedType
        self.normalCoin = expeditionData.normalCoin;        -- 普通金币
        self.normalExp = expeditionData.normalExp;         -- 普通经验
        self.quickCoin = expeditionData.quickCoin;         -- 快速金币
        self.quickExp = expeditionData.quickExp;          -- 快速经验

        self.noticeDataServerTime = AvalonUtil.getCurrentTime()

        mvc.send(mvc.events.Expedition_Data_Update)
        mvc.send(mvc.events.Expedition_Bag_Attr_Change)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_EXPEDITION_BAG_CHANGE)

        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        if(machine and machine._model) then
            local master = machine._model:getMaster()
            if(master) then 
                local SceneManager = require("app.game.SceneManager")
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initExpeditionUpdate(master:getId(), self.expeditionStatus)
                SceneManager:getInstance():pushCommand(renderCommand)     
            end
        end
    end
end

function ExpeditionModel:updateExpeditionLV(data) 
    if(data) then 
        self.caveMode = data.mode;           -- 洞窟模式(MODE_HERO|MODE_NORMAL)
        self.caveLevel = data.lv;          -- 选择关卡
        -- print("updateExpeditionLV =", data)
    end
end

function ExpeditionModel:getExpeditionStatus()
    return self.expeditionStatus
end

function ExpeditionModel:getExpeditionMode()
    return self.caveMode
end

function ExpeditionModel:getNormalCoin()
    return self.normalCoin
end

function ExpeditionModel:getNormalExp()
    return self.normalExp
end

function ExpeditionModel:getQuickCoin()
    return self.quickCoin
end

function ExpeditionModel:getQuickExp()
    return self.quickExp
end

function ExpeditionModel:getExpeditionLevel()
    -- return self.caveLevel
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():checkModeIsNewCave(self.caveMode)) then
        -- 这里由于扭曲空间的解锁方式，导致里面的配置方式和其它渠道不一样。
        -- add by zp CO-12741
        return self:maxLevelCoverToCheckpoint(self.caveMode, self:_calculateExpeLevelToGameLevel(self.caveLevel))
    elseif (self.caveMode == PublicDefine.CAVE_MODE.MODE_HERO) then
        return self:maxLevelCoverToCheckpoint(self.caveMode, self:_calculateExpeLevelToGameLevel(self.caveLevel))
    else
        -- 由于正常模式下面，我们需要倒到12层才能探险11层，导致进度在12层的时候，探险的是11层，在根据11层去探险配置表里面去找对应的checkpoint 为2001，导致重新打开界面有问题
        -- add by zp CO-12442
        return self:maxLevelCoverToCheckpoint(self.caveMode, self:_calculateExpeLevelToGameLevel(self.caveLevel) + 1)
    end
end

function ExpeditionModel:getExpeditionCaveLevel()
    return self.caveLevel
end

function ExpeditionModel:getQuickExpeditionNum()
    return self.quickExpeditionNum
end

function ExpeditionModel:getHaveFreeExpedition()
    local diamondArr = string.split(ConfigManager:getGeneralForKey("fastAdventurediamond"), ";")
    local expedNum = self:getQuickExpeditionNum()
    
    if(diamondArr[expedNum + 1] and self:getQuickExpeditionNum() < #diamondArr and tonumber(diamondArr[expedNum + 1]) <= 0) then
        return true 
    end

    return false
end

function ExpeditionModel:getSpeedMode()
    return self.speedMode
end

function ExpeditionModel:getSpeedLevel()
    --self.speedLevel = 2016
    return self.speedLevel
    -- self.speedLevel = 2016
    -- return self:_calculateExpeLevelToGameLevel(self.speedLevel)
end

function ExpeditionModel:getSpeedType()
    return self.speedType
end


-- 获取剩余的时间
function ExpeditionModel:getRemainTime()
    local totalTime = tonumber(ConfigManager:getGeneralForKey("generalAdventuretime"))
    local endTime = totalTime - self.usedTime/1000
    if(self:getExpeditionStatus()) then 
        endTime = endTime - (AvalonUtil.getCurrentTime() - self.noticeDataServerTime)/1000
    end
    return endTime
    -- return 10000
end

-- 获取已经探险的时间
function ExpeditionModel:getExpeditionTime()
    if(self:getExpeditionStatus()) then 
        return self.usedTime/1000 + (AvalonUtil.getCurrentTime() - self.noticeDataServerTime)/1000
    end

    return tonumber(ConfigManager:getGeneralForKey("generalAdventuretime"))
end

function ExpeditionModel:getBagHaveGoodsForPacketType(packetType)

    return GoodsDataManager:getHaveGoodsForPK(RoleDataManager:getMasterPK(), packetType)
end

function ExpeditionModel:getIsNotNullForPacketType(packetType)
    if GoodsDataManager:getHaveGoodsForPK(RoleDataManager:getMasterPK(), packetType) then 
        return true
    end
    if(packetType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then
        if(self.normalCoin ~= 0 or self.normalExp ~= 0) then 
            return true
        end
    elseif (packetType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then
        if(self.quickCoin ~= 0 or self.quickExp ~= 0) then 
            return true
        end
    end

    return false
end

function ExpeditionModel:getGoodsArrForBag(packageType)
    local pk = RoleDataManager:getMasterPK()

    -- packageType = PublicDefine.PACKET_TYPE.PACKET_BAG

    local goodsArr = {}
    goodsArr.wearEquipmentArr = {}
    goodsArr.haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    goodsArr.haveItemArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    goodsArr.haveMaterialArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    goodsArr.haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    goodsArr.haveRelicArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_RELIC)
    goodsArr.haveTreasureArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    
    local totalSize = #goodsArr.haveEquipmentArr + #goodsArr.haveItemArr + #goodsArr.haveMaterialArr + #goodsArr.haveGemStoneArr + #goodsArr.haveRelicArr
    local row,low = math.modf(totalSize/5)
    if(low > 0) then 
        totalSize = (row + 1) * 5
    end

    -- 这里做容错处理，在加入背包的时候都已经做了锁定的统一处理
    if(packageType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL or 
        packageType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then 
        
        if(goodsArr.haveEquipmentArr) then 
            for k, v in pairs(goodsArr.haveEquipmentArr) do 
                v:setIsLock(false)
            end
        end
        if(goodsArr.haveItemArr) then 
            for k, v in pairs(goodsArr.haveItemArr) do 
                v:setIsLock(false)
            end
        end
        if(goodsArr.haveMaterialArr) then 
            for k, v in pairs(goodsArr.haveMaterialArr) do 
                v:setIsLock(false)
            end
        end
        if(goodsArr.haveTreasureArr) then 
            for k, v in pairs(goodsArr.haveTreasureArr) do 
                v:setIsLock(false)
            end
        end
        if(goodsArr.haveGemStoneArr) then 
            for k, v in pairs(goodsArr.haveGemStoneArr) do 
                v:setIsLock(false)
            end
        end
        if(goodsArr.haveRelicArr) then 
            for k, v in pairs(goodsArr.haveRelicArr) do 
                v:setIsLock(false)
            end
        end
    end

    if(totalSize < 30) then 
        totalSize = 30
    end

    -- 背包能够使用的格子数
    goodsArr.packetBoxBeUseNum = totalSize
    -- 背包最大格子数
    goodsArr.packetBoxMaxNum = totalSize
    -- 获取背包解锁次数
    goodsArr.unlockBagTimes = 0

    return goodsArr
end

function ExpeditionModel:getExpeditionConfigData(model, checkPoint)
    local arr = ConfigManager:getExpeditionConfigByCP(self:calculationExpeditionID(model, checkPoint)) 
    if(arr) then
        -- 排序, ID大的在前面，小的在后面
        table.sort(arr, function(a, b)
            if(a.ID > b.ID) then 
                return true
            end
            return false
        end)

        if(model == PublicDefine.CAVE_MODE.MODE_HERO) then
            local maxLevel = RoleDataManager:getMaster():getHeroCaveStageMaxLevelForCheckPoint(checkPoint)
            -- maxLevel = 100
            -- print("getExpeditionConfigData maxLevel=", maxLevel)
            for k,v in pairs(arr) do
                if(v.level <= maxLevel) then 
                    return v
                end
            end
        elseif(model == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then
            local maxLevel = RoleDataManager:getMaster():getTitanHeroCaveStageMaxLevelForCheckPoint(checkPoint)
            -- maxLevel = 100
            -- print("getExpeditionConfigData maxLevel=", maxLevel)
            for k,v in pairs(arr) do
                if(v.level <= maxLevel) then 
                    return v
                end
            end
        else
            local maxLevelData = RoleDataManager:getMaster():getMaxLevelData(model, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
            -- print("getExpeditionConfigData normal maxLevel=", maxLevelData:getMaxLevel())
            for k,v in pairs(arr) do
                if self:checkExpeditionLevelUnlock(v, maxLevelData, checkPoint) then 
                    return v
                end
            end
        end
    end
    -- printError("error  getExpeditionConfigData=", model, checkPoint)
    -- print("error  getExpeditionConfigData=", model, checkPoint)
    return nil
end

function ExpeditionModel:getExpeditionMaxLevelForModelOrCheckpoint(model, checkPoint)
    local expeditionData = self:getExpeditionConfigData(model, checkPoint)
    if(expeditionData) then 
        return self:getExpeditionMaxLevelForExpeditionData(expeditionData)
    end

    return 0
end

function ExpeditionModel:getExpeditionMaxLevelForExpeditionData(expeditionData)
    if(expeditionData) then 
        -- print("getExpeditionMaxLevelForExpeditionData", expeditionData.ID)
        return expeditionData.ID - math.floor(expeditionData.ID /100000) * 100000
        -- if(expeditionData.level == -1) then 
        --     return (expeditionData.checkpoint - 100000 - PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN + 1) * SHOP_INTERVAL
        -- else 
        --     if(expeditionData.level == 0) then 
        --         return 1
        --     else 
        --         return expeditionData.level - 1 
        --     end
        -- end
    end

    return 0
end

function ExpeditionModel:getCheckPointForExpeditionData(expeditionData)
    if(expeditionData) then 
        -- print("getCheckPointForExpeditionData", expeditionData.checkpoint)
        return expeditionData.checkpoint - math.floor(expeditionData.checkpoint /100000) * 100000
    end

    return PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN
end

function ExpeditionModel:maxLevelCoverToCheckpoint(mode, maxlevel)
    if(maxlevel) then
        -- print("maxLevelCoverToCheckpoint", mode, maxlevel, PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN)
        local all = ConfigManager:getAllExpeditionConfig()
        local arr = {}
        for k, v in pairs(all) do 
            if(arr[v.checkpoint] == nil and v.level ~= -1 and v.level <= maxlevel and math.floor(v.checkpoint / 100000) == mode) then
                arr[v.checkpoint] = v
            end
        end
        table.sort(arr, function(a, b)
            if(a.ID > b.ID) then 
                return true
            end
            return false
        end)

        local nowExpeditionData = nil
        local maxID = 0
        local topMaxID = mode * 100000 + maxlevel
        for k,v in pairs(arr) do
            if(v.level <= maxlevel and v.ID <= topMaxID and maxID < v.ID) then 
                nowExpeditionData = v
                maxID = v.ID
            end
        end

        if(nowExpeditionData) then 
            return self:getCheckPointForExpeditionData(nowExpeditionData)
        end

        return PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN
    else 
        return PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN
    end
end

function ExpeditionModel:checkExpeditionLevelUnlock(expeditionConfigData, maxLevelData, checkPoint)
    -- 这里处理解锁的逻辑
    if(maxLevelData and expeditionConfigData) then
        local caveMode = math.floor(expeditionConfigData.ID / 100000)
        if(((expeditionConfigData.level ~= -1 and expeditionConfigData.level <= maxLevelData:getMaxLevel())
        or (caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL 
            and expeditionConfigData.level == -1 
            and self:getExpeditionMaxLevelForExpeditionData(expeditionConfigData) <= maxLevelData:getMaxLevel() 
            and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave))
        or (caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES 
            and expeditionConfigData.level == -1 
            and self:getExpeditionMaxLevelForExpeditionData(expeditionConfigData) <= maxLevelData:getMaxLevel() 
            and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace))
        or (caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD 
            and expeditionConfigData.level == -1 
            and self:getExpeditionMaxLevelForExpeditionData(expeditionConfigData) <= maxLevelData:getMaxLevel() 
            and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad))
        or (caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO 
            and expeditionConfigData.level == -1 
            and self:getExpeditionMaxLevelForExpeditionData(expeditionConfigData) <= maxLevelData:getMaxLevel() 
            and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero))
        or (caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING 
            and expeditionConfigData.level == -1 
            and self:getExpeditionMaxLevelForExpeditionData(expeditionConfigData) <= maxLevelData:getMaxLevel() 
            and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring)))) then 

            return true
        end
        local SceneManager = require("app.game.SceneManager")
        if( (SceneManager:getInstance():checkModeIsNewCave(caveMode)) 
            and expeditionConfigData.level == -1) then 
            local checkpointData = RoleDataManager:getCheckpointData(caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2)
            if(checkpointData and checkpointData:getCheckpoint() >= checkPoint) then 
                return true
            end
        end
    end

    return false
end

function ExpeditionModel:calculationExpeditionID(model, level)
    return model * 100000 + level
end

function ExpeditionModel:getExpeditionMaxLevelForData(caveMode, checkPoint)
    -- local heroData = RoleDataManager:getMaster()
    -- if(caveMode == PublicDefine.CAVE_MODE.MODE_HERO) then 
    --     return heroData:getHeroCaveStageMaxLevelForCheckPoint(checkPoint)
    -- else 
    --     local maxLevelData = heroData:getMaxLevelData(caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    --     if(maxLevelData) then
    --         local maxLevel = ToolsUtil:getCaveLevelForShopLevel(checkPoint + 1)
    --         if(maxLevel > maxLevelData:getMaxLevel()) then 

    --         end
    --     end
    -- end
end

function ExpeditionModel:getHaveMonthDay()
    local heroData = RoleDataManager:getMaster()
    local currentDay = heroData:getRefreshDay() or 0
    local monthCardDay = heroData:getMonthCardDay() or 0
    local day = monthCardDay - currentDay
    if (day > 0) then
        return true
    else
        return false
    end
end

function ExpeditionModel:_calculateExpeLevelToGameLevel(expeLevel)
    -- local chu = 10000
    -- local a,b = math.modf(expeLevel/chu)
    -- return expeLevel - a * chu
    return expeLevel
end

return ExpeditionModel
--[[--
数据模型DockModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: DockModel
------------------------------------------------------------------------------

local DockModel = class("DockModel",mvc.GameModel)

function DockModel:initData()
	-- self.sailConfig = {}
    self.dockLevel = 1
    self.sailLenth = nil
    self.embattlePets = {}

    -- 解锁庄园存在服务器没有及时同步boatid的情况
    self.boatID = 23290001 
    self.boatConfig = ConfigManager:getAllBoatDataByID(self.boatID)

    self.sailData = nil
    self.boatData = nil
    self.supplyAmount = {}
    self.sailingStatus = {}
    self.boatsCellLIst = nil
    self.levelGainsMap = {}
    self.qualityGainsMap = {}
    self.speedAttrGains = {}
    -- self.attrGains.speed = {}
    self.curTabIndex = nil
    
    self.sailLogData = {}
    self.sailLogData.logs = {}

    self.unLockFacades = {}
end

function DockModel:getAllSailConfig()
	return ConfigManager:getAllSailData()
end

function DockModel:setTabIndex(idx)
	self.curTabIndex = idx
end

function DockModel:setBoatConfig(boatID)
    self.boatID = boatID
	self.boatConfig = ConfigManager:getAllBoatDataByID(self.boatID)

    local qualityGains = Config.General:getValueForKey("voyagePetSpeedBonus") 
    local levelGains = Config.General:getValueForKey("voyagePetLevelInfluence") 
    local qualityGainsList = string.split(qualityGains, ";")
    local levelGainsList = string.split(levelGains, ";")
    
    self.levelGainsMap = {}
    self.qualityGainsMap = {}
    for k, v in pairs(levelGainsList) do
        local levelGain = string.split(v, ",")
        table.insert(self.levelGainsMap, levelGain)
    end

    for k, v in pairs(qualityGainsList) do
        local qualityGain = string.split(v, ",")
        self.qualityGainsMap[tonumber(qualityGain[1])] = tonumber(qualityGain[2])
    end
    self.boatData.facadeId = boatID
end

function DockModel:getCurBoatConfig()
	return self.boatConfig
end

function DockModel:setBoatConfigByChangeBoat()
	self.boatConfig = ConfigManager:getAllBoatDataByID(self.boatID)
end

function DockModel:setDockData(data)
	self.sailData = data.sailData or nil
    self.boatData = data.boatData or nil
    if data.boatData then
        self.boatData.facadeId = data.boatData.boatId
        if data.boatData.boatId ~= 0 then
            self.boatID = data.boatData.boatId
        end
    end
    
end

function DockModel:getSailData()
	return self.sailData
end

function DockModel:getBoatData()
	return self.boatData
end

function DockModel:getNaviGoldCoin()
    local coin = 0
	for k, v in pairs(self.sailData.lootItems) do
        if v.templateId == 23280001 then
            coin = v.num
        end
    end
    return coin
end

function DockModel:getPacketPets()
    local bagPets = clone(MasterDataManager:getBagPets())
    -- for k, v in pairs(bagPets) do
    --     if self:checkPetCanSail(v:getId()) then
    --     end
    -- end

    for _, v in pairs(self.embattlePets) do
        for key, value in pairs(bagPets) do
            if v and v.spriteID and value:getId() == v:getId() then
                table.remove(bagPets, key)
                break
            end
        end
    end

    return bagPets
end

function DockModel:setEmbattlePets(k, pet)
	self.embattlePets[k] = pet
end

function DockModel:getEmbattlePets()
	return self.embattlePets
end

function DockModel:clearEmbattlePets()
	self.embattlePets = {}
end

function DockModel:setSupplyAmount(k, num)
	self.supplyAmount[k] = num
end

function DockModel:getSupplyAmount()
	return self.supplyAmount 
end

function DockModel:getSupplyAmountByID(sailConfig)
    local id = sailConfig.ID
    local pk = RoleDataManager:getMaster():getPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, sailConfig.SuppliesID) or 0
    if self.supplyAmount[id] and self.supplyAmount[id] > itemTotalNum then
        self.supplyAmount[id] = itemTotalNum
    end
	return self.supplyAmount[id] 
end

function DockModel:clearSupplyAmount()
	self.supplyAmount = {}
end

function DockModel:setSailingStatus(k, b)
	self.sailingStatus[k] = b
end

function DockModel:getSailingStatus()
	return self.sailingStatus
end

function DockModel:clearSailingStatus()
	-- self.sailingStatus = {}
    for k, v in pairs(self.sailingStatus) do
        self.sailingStatus[k] = nil
    end
end

function DockModel:isSailing()
	local isSailing = false
    for k, v in pairs(self.sailingStatus) do
        if v then
            isSailing = true
        end
    end
    return isSailing
end

function DockModel:getBoatsCellListData()
    if(self.boatsCellLIst == nil) then
        self.boatsCellLIst = {}
        local shopAll = ConfigManager:getAllBoatData()
        for _,data in pairs(shopAll) do 
            local boatData = GoodsDataManager:createLocalGoodsData(data.ID)
            boatData.ID = data.ID
            boatData:setIsNew(false)
            boatData:setIsBoat(true)
            boatData:setIsLock(self:checkBoatIsUnlock(tonumber(boatData.ID)))
            boatData:setNum(0)
            table.insert(self.boatsCellLIst, boatData)
        end
    end

    return self.boatsCellLIst
end

function DockModel:checkBoatIsUnlock(boatID)
    local boats = self.boatData.boats 
    local unlock = false
    for k, v in pairs(boats) do
        if v == boatID then
            unlock = true
            break
        end
    end
    if not unlock then
        unlock = self.unLockFacades[boatID] or false
    end
    return unlock
end

-- 获取剩余航行时间 
function DockModel:getSailRemainTime(sailConfig)
    local supplementarySuppliesList = string.split(sailConfig.supplementarySupplies, ",")
    local startTime = self.sailData.startTime -- 开始航行时间
    local speed = self.sailData.speed/100 -- 航行速度
    local distance = self.sailData.distance/100 -- 已航行距离
    local curDistance = sailConfig.routeLength - distance -- 实际路程  

    local supplyAmount = self.sailData.supplyAmount/100
    local supplyContinued = supplyAmount/sailConfig.supplyConsumptionSpeed -- 自带补给维持时间=补给数/每分消耗补给数
    local routeWithSupply = speed*supplyContinued   -- 自带补给航行长度=航行速度*自带补给维持时间
    local sailTimeLeft = math.floor(curDistance/speed) -- 剩余航行时间(分)
    if curDistance > routeWithSupply then
        local inSituSupplyNum = tonumber(supplementarySuppliesList[2])
        local inSituSupplyTime = tonumber(supplementarySuppliesList[1]) 
        local inSituSupplyCount = (curDistance-routeWithSupply)/speed*sailConfig.supplyConsumptionSpeed -- 原地补给品数量=（航线长度-自带补给航行长度）/航行速度*每分钟消耗补给数
        local inSituSupplyCountTime = inSituSupplyCount / inSituSupplyNum * inSituSupplyTime -- 原地补给时间=原地补给品数量/每次停船补给数*每次原地补给时间
        sailTimeLeft = sailTimeLeft+inSituSupplyCountTime -- 实际航行时间=航线长度/航行速度+原地补给时间
    end

    local time = AvalonUtil:getNewFullFormatTime(sailTimeLeft*60 + GameManager:getNormalServerTime(), Game.TIME_LEVEL.TIME_LEVEL_MINUTE)
    return time
end

-- 获取航线是否解锁
function DockModel:getSailIsLock(config)
    local GameInManorManager = require "app.game.GameInManorManager"
    local isLock = false
    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(PublicDefine.ManorBuildID.BuildID_Dock)
    local conditionValue = tonumber(config.conditionValue)
    if conditionValue > buildData.level then
        isLock = true
    end 
    return isLock
end

-- 获取航行背包是否有可领取道具
function DockModel:getSailBagHaveItemCouldTake(packageType)
    local could = false
    local pk = RoleDataManager:getMasterPK()

    local goodsArr = {}
    goodsArr.wearEquipmentArr = {}
    goodsArr.haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    goodsArr.haveItemArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    goodsArr.haveMaterialArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    goodsArr.haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
    goodsArr.haveRelicArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_RELIC)
    goodsArr.haveTreasureArr = GoodsDataManager:getGoodsArrForPK(pk,packageType,PublicDefine.GOODS_TYPE.GOODS_TREASURE)
    
    
    local totalSize = #goodsArr.haveEquipmentArr + #goodsArr.haveItemArr + #goodsArr.haveMaterialArr + #goodsArr.haveGemStoneArr + #goodsArr.haveRelicArr + #goodsArr.haveTreasureArr
    if totalSize > 0 then
        could = true
    end
    local naviCoin = self:getNaviGoldCoin()
    print("获取航行背包是否有可领取金币:", naviCoin)
    if not could  then
        if naviCoin and naviCoin ~= 0 then
            could = true
        end
    end

    return could
end

-- 宠物是否忙碌
function DockModel:checkPetCanSail(petID)
    print("checkPetCanSail:", petID)
    local isBusy = false
    local petData = MasterDataManager:getBagPetById(petID)
    if petData:isFight() then
        isBusy = true
        return isBusy
    end

    -- 冒险状态下
    if mvc.petTreasureModel:getExploreState() then
        local explorePets = mvc.petTreasureModel:getPetAdvEmbattlePets()
        for _, v in pairs(explorePets) do
            if v:getId() == petID then
                isBusy = true
                return isBusy
            end
        end
    end

    -- 派遣状态下
    if mvc.petTreasureModel:getIsGathering() then
        local gatherPets = mvc.petTreasureModel:getWorkersData()
        for _, v in pairs(gatherPets) do
            if v:getId() == petID then
                isBusy = true
                return isBusy
            end
        end
    end
    return isBusy
end

-- 宠物是否忙碌
function DockModel:checkPetIsSailing(petID)
    local isSailing = false
    for k, v in pairs(self.sailData.pets) do
        if tonumber(petID) == v then
            isSailing = true
            break
        end
    end
    return isSailing
end

-- 计算宠物增益
function DockModel:calculatePetGains(petData)
    local sailConfig = ConfigManager:getAllSailDataByID(self.curTabIndex)
    local lv = petData:getLevel()
    local petQuality = petData:getPetQuality()
    local levelGain = 0
    local qualityGain = 0

    local levelGainsMap = {}
    local qualityGainsMap = {}

    for k, v in pairs(self.levelGainsMap) do
        local levelNum = tonumber(v[1])
        if lv > levelNum then
            local dValue = lv - sailConfig.recommendGrade
            -- print("dValue:", dValue, lv, levelNum)
            if dValue < levelNum then
                break
            end
            levelGain = tonumber(v[2])
            -- print("levelGain", levelGain)
        end
    end

    qualityGain = self.qualityGainsMap[petQuality] or 0
    -- print("calculatePetGains:", qualityGain, levelGain, petQuality, lv)
    return qualityGain+levelGain
end

function DockModel:setAttrGains(data, state)
    if state == 1 then
        self.speedAttrGains[data.index] = data.gains
    end
end

function DockModel:getSpeedAttrGains()
    -- MasterDataManager:getBagPetById(petID)
    -- self.sailData.pets
    return self.speedAttrGains
end

function DockModel:clearSpeedAttrGains()
    self.speedAttrGains = {}
end

function DockModel:setSailLogData(data)
    -- self.sailLogData = data
    if data.clear and data.clear == 1 then
        self.sailLogData.logs = {}
    end
    if data.logs then
        for _, v in pairs(data.logs) do
            table.insert(self.sailLogData.logs, v)
        end
    end
    self.sailLogData.lastTime = data.lastTime
end

function DockModel:getSailLogData()
    return self.sailLogData
end

function DockModel:setUnlockFacade(data)
    for _, v in pairs(data) do
        self.unLockFacades[v] = true
    end
end

return DockModel
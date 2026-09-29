--[[--
数据模型BigSailPortModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/14
--desc	: BigSailPortModel
------------------------------------------------------------------------------

local BigSailPortModel = class("BigSailPortModel",mvc.GameModel)
local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")

local BigSailItemType = {
    BigSailItemType_debris = 1,
    BigSailItemType_supply = 2,
    BigSailItemType_PortOutput = 3,
    BigSailItemType_Activity = 4,
    BigSailItemType_BetItem = 5
}

local BigSailStoreType = {
    BigSailStoreType_Common = 1,
    BigSailStoreType_Activity = 2
}

function BigSailPortModel:initData()
	-- 个人同步数据(只在登录港口时同步一次)
	self.baseData = nil
	-- 船只上的船员信息
	self.embattlePets = {}
	-- 解锁庄园存在服务器没有及时同步boatid的情况
    self.boatID = 23290001 
    self.boatConfig = ConfigManager:getAllBoatDataByID(self.boatID)

    self.eventData = {}

    self.eventRedPointShowList = {}

    self.bossFoughtNum = 0

    self.isMonsterEnd = false

    self.nowMonsterBattle = {} -- 本次岛怪驱逐结果数据
    self.monsterBattlePvpShowData = nil -- 本次岛怪驱逐战斗界面，具体岛怪类型
end

function BigSailPortModel:saveBaseData(data)
	self.baseData = data
    self.bossFoughtNum =  self.baseData.bossChallengeNum


    -- 测试添加代码
    -- self.mapData.harvestIslandsMonster = {{islandid = 2, monsterids = {1, 2}}, {islandid = 3, monsterids = {1, 2}},
    --     {islandid = 4, monsterids = {1}},{islandid = 10, monsterids = {2}},{islandid = 16, monsterids = {2}},{islandid = 22, monsterType = {2}},
    --     {islandid = 5, monsterids = {1, 2}},{islandid = 11, monsterids = {1}},{islandid = 17, monsterids = {1, 2}},{islandid = 23, monsterType = {1, 2}},
    --     {islandid = 6, monsterids = {2}},{islandid = 12, monsterids = {2}},{islandid = 18, monsterids = {1}},{islandid = 24, monsterType = {1, 2}},
    --     {islandid = 7, monsterids = {1}},{islandid = 13, monsterids = {1}},{islandid = 19, monsterids = {2}},{islandid = 25, monsterType = {1, 2}},
    --     {islandid = 8, monsterids = {1}},{islandid = 14, monsterids = {1}},{islandid = 20, monsterids = {1}},
    --     {islandid = 9, monsterids = {2}},{islandid = 15, monsterids = {2}},{islandid = 21, monsterids = {2}},
    -- }
    --print("saveBaseData--->: ", data)
    --self.baseData.monsters = {{islandid = 2, monsterids = {1, 2}}, {islandid = 3, monsterids = {1, 2}}}

end

function BigSailPortModel:getBaseData()
	return self.baseData
end

function BigSailPortModel:getBossFoughtNum()
	return self.bossFoughtNum
end

function BigSailPortModel:changeBossFoughtNum()
	self.bossFoughtNum = self.bossFoughtNum + 1
end

function BigSailPortModel:saveBoatInfo(boatInfo)
    if self.baseData then
        for k,v in pairs(self.baseData.useBoats) do
            if v.boatId == boatInfo.boatId then
                self.baseData.useBoats[k] = boatInfo
                return
            end
        end
    end
end

function BigSailPortModel:saveTaskInfo(taskInfos)
    if self.baseData then
        for k1,v1 in pairs(taskInfos) do
            -- 是否有需要改变状态的任务
            local isChangeHave = false
            for k,v in pairs(self.baseData.tasks) do
                if v.id == v1.id then
                    self.baseData.tasks[k] = v1
                    isChangeHave = true
                end
            end
            if not isChangeHave then
                 table.insert(self.baseData.tasks, v1)
            end
        end
    end
end

function BigSailPortModel:setEmbattlePets(k, pet)
	self.embattlePets[k] = pet
end

function BigSailPortModel:getEmbattlePets()
	return self.embattlePets
end

function BigSailPortModel:clearEmbattlePets()
	self.embattlePets = {}
end

function BigSailPortModel:getPetsOfBoatId(boatId)
    -- 根据船ID获取船上的船员
    for k,v in pairs(self.baseData.useBoats) do
        if v.boatId == boatId then
            local pets = v.pets
            local petsData = {}
            for k,v in pairs(pets) do
                local data = MasterDataManager:getBagPetById(v)
                if data then
                    table.insert(petsData, data)
                end
            end
            return petsData
        end
    end
    return nil
end

function BigSailPortModel:getPacketPets(isFirst,boatId)
    local bagPets = clone(MasterDataManager:getBagPets())

    if isFirst then
        self.embattlePets = {}
    end

    local removePetIdTable = {}
    local baseInfo = mvc.bigSailPortModel:getBaseData()

    for k,v in pairs(baseInfo.useBoats) do
        if v.pets then
            for _, rId in pairs(v.pets) do
                table.insert(removePetIdTable,{rId = rId,boatId = v.boatId})
            end
        end
    end

    local index = 1
    for _, v in pairs(removePetIdTable) do
        for key, value in pairs(bagPets) do
            if tonumber(value:getId()) == tonumber(v.rId) then
                if (boatId == v.boatId and isFirst) then
                    local petData = MasterDataManager:getBagPetById(v.rId)
                    if petData then
                        self:setEmbattlePets(index,petData)
                        index = index + 1
                    end
                end

                if isFirst or boatId ~= v.boatId then
                    table.remove(bagPets, key)
                end

                break
            end
        end
    end

    for _, v in pairs(self.embattlePets) do
        for key, value in pairs(bagPets) do
            if v and v.spriteID and tonumber(value:getId()) == tonumber(v:getId()) then
                table.remove(bagPets, key)
                break
            end
        end
    end

    return bagPets
end

function BigSailPortModel:getCurBoatConfig()
	return self.boatConfig
end

-- 宠物是否忙碌
function BigSailPortModel:checkPetCanSail(petID)
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

function BigSailPortModel:setBoatConfig(boatID)
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

function BigSailPortModel:getCurBoatConfig()
	return self.boatConfig
end

function BigSailPortModel:setBoatConfigByChangeBoat()
	self.boatConfig = ConfigManager:getAllBoatDataByID(self.boatID)
end

function BigSailPortModel:setEventData(data)
    if data.type == 1 then 
        self.eventData.personal = data.data
    elseif data.type == 2 then
        self.eventData.guild = data.data
    end
    local lastGameTime = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.SailEventRedPointLastRefreshTime..data.type..GameDataManager:getInstance():getMasterPK(), 0)

    if data.data[1] and data.data[1].gameTime > lastGameTime then
        self:setRedPointIsShow(data.type, true)
    end
end

function BigSailPortModel:updateEventData(data)
	-- self.eventData = data
    if data.type == 1 then 
        if self.eventData.personal then
            for k, v in pairs(data.data) do
                table.insert(self.eventData.personal, v)
            end
        else
            self:setEventData(data)
        end
    elseif data.type == 2 then
        if self.eventData.guild then
            for k, v in pairs(data.data) do
                table.insert(self.eventData.guild, v)
            end
        else
            self:setEventData(data)
        end
    end
    self:setRedPointIsShow(data.type, true)
end

function BigSailPortModel:getEventData()
	return self.eventData
end

function BigSailPortModel:setRedPointIsShow(eventType, isShow)
	self.eventRedPointShowList[eventType] = isShow

    Avalon.MessageCenter:notice(GameMessage.MC_UI_PORT_REFRESH_EVENT_RED_POINT)
end

function BigSailPortModel:getRedPointIsShow()
	return self.eventRedPointShowList
end

function BigSailPortModel:setMaterialData(data)
    if self.baseData then
        if data.itemType == BigSailItemType.BigSailItemType_debris then
            self.baseData.debris = data.itemNum
        elseif data.itemType == BigSailItemType.BigSailItemType_supply then
            self.baseData.supplyAmount = data.itemNum
        elseif data.itemType == BigSailItemType.BigSailItemType_PortOutput then
            self.baseData.outputNum = data.itemNum
        elseif data.itemType == BigSailItemType.BigSailItemType_Activity then
            self.baseData.activityDebris = data.itemNum
        elseif data.itemType == BigSailItemType.BigSailItemType_BetItem then
            self.baseData.betItemNum = data.itemNum

            mvc.send("BetItemNum_Refresh", data.itemNum)
        end
    end
end

function BigSailPortModel:getPortOpenTime()
    local config = ConfigManager:getNavigationGeneralConfigByID(1)
    local startTime = GameManager:getUnixTimeByConfigTimeStr(config.activityFirstTimeOpenTime)
    -- local curWeek = GameManager:calculationGameWeek(GameManager:getNormalServerTime())
    return startTime
end

function BigSailPortModel:getPortBtnIsSHow()
    local SceneManager = require("app.game.SceneManager")
    local isInport = SceneManager:getInstance():isInPort()
    local isShow = false
    local config = ConfigManager:getNavigationGeneralConfigByID(1)
    local startTime = self:getPortOpenTime()
    local roleLv = RoleDataManager:getMaster():getLevel()
    local nowTime = GameManager:getNormalServerTime()
    -- if nowTime >= startTime and roleLv >= config.openLevel and not isInport and not SceneManager:getInstance():isInCave() then
    if nowTime >= startTime and roleLv >= config.openLevel and not isInport and SceneManager:getInstance():isInTownRelated() then
        isShow = true
    end
    return isShow
end

function BigSailPortModel:getCurWeekSartTime()
    local nowTime = GameManager:getNormalServerTime()
    
    -- local curWeekSartTime = curWeek*7*SECONDS_ONE_DAY - 5*SECONDS_ONE_DAY
    local curWeekSartTime = (nowTime + 5*SECONDS_ONE_DAY) % SECONDS_ONE_WEEK

    return nowTime - curWeekSartTime
end

function BigSailPortModel:saveStoreInfo(data)

    if BigSailStoreType.BigSailStoreType_Common == data.storeType then
        for k,v in pairs(self.baseData.limitStoreinfo) do
            if data.info.cfgId == v.cfgId then
                self.baseData.limitStoreinfo[k].buyNum = data.info.buyNum
            end
        end
    elseif BigSailStoreType.BigSailStoreType_Activity == data.storeType then
        for k,v in pairs(self.baseData.activityStoreinfo) do
            if data.info.cfgId == v.cfgId then
                self.baseData.activityStoreinfo[k].buyNum = data.info.buyNum
            end
        end
    end
end

function BigSailPortModel:isCanFightBoss()
    local data = {}
    data.islandId = 0
    data.boatId = 0

    for k,v in pairs(self.baseData.useBoats) do
        if v.islandId > 0 then
            local isAssociatedWithBoss1 = ConfigManager:getIslandsByID(v.islandId).isAssociatedWithBoss
            if isAssociatedWithBoss1 ~= 0 then
                data.islandId = v.islandId
                data.boatId = v.boatId
                return data
            end
        end
    end

    return data
end

function BigSailPortModel:getIsPortClose()
    local isClose = false
    local secondOfToday = GameManager:calculationGameSecondOfToday()
    local config = ConfigManager:getNavigationGeneralConfigByID(1)
    local closeTimeStart = config.dailyCloseTime*3600
    local closeTimeEnd = config.dailyOpenTime*3600
    if secondOfToday >= closeTimeStart or secondOfToday < closeTimeEnd then
        isClose = true
    end
    return isClose
end

function BigSailPortModel:getIslandMonsterIsOpen()
    local isShow = false
    local SceneManager = require("app.game.SceneManager")
    local config = ConfigManager:getNavigationGeneralConfigByID(1)
    local startTime = GameManager:getUnixTimeByConfigTimeStr(config.islandMonsterStartTime)
    local endTime = GameManager:getUnixTimeByConfigTimeStr(config.islandMonsterEndTime)
    local nowTime = GameManager:getNormalServerTime()
    if nowTime >= startTime and nowTime <= endTime and not SceneManager:getInstance():isInCave() then
        isShow = true
    end
    return isShow
end

function BigSailPortModel:getIslandMonsterInfos()
    return self.baseData.monsters
end

function BigSailPortModel:clearMonsterInfos()
    self.baseData.monsters = {}
end

function BigSailPortModel:updateMonsterInfos(data)
    for k,v in pairs(data.info) do
        local isRefresh = false
        for k1,v1 in pairs(self.baseData.monsters) do
            if v1.islandid == v.islandid then
                isRefresh = true
                self.baseData.monsters[k1] = v
                break
            end
        end

        if not isRefresh then
            -- 不是刷新岛屿上的岛怪，就是岛屿上新生成添加上的岛怪
            table.insert(self.baseData.monsters, v)
        end
    end
    self.baseData.dayRefreshMonsterNum = data.dayRefreshMonsterNum
end

function BigSailPortModel:saveMonsterBattleData(data)
    self.nowMonsterBattle = data
end

function BigSailPortModel:getMonsterBattleData()
    return self.nowMonsterBattle
end

function BigSailPortModel:setEndPvpIsMonster(isMonster)
    self.isMonsterEnd = isMonster
    if not isMonster then
        self.nowMonsterBattle = {}
    end
end

function BigSailPortModel:getEndPvpIsMonster()
    return self.isMonsterEnd
end

function BigSailPortModel:setMonsterBattlePvpData(monsterId)
    self.monsterBattlePvpShowData = monsterId
end

function BigSailPortModel:getMonsterBattlePvpData()
    return self.monsterBattlePvpShowData
end

return BigSailPortModel
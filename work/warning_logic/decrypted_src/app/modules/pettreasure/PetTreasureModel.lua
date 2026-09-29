--[[--
数据模型PetTreasureModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2019/10/23
--desc	: PetTreasureModel
------------------------------------------------------------------------------

local PetTreasureModel = class("PetTreasureModel",mvc.GameModel)

local GameDataManager = require("app.game.GameDataManager")

function PetTreasureModel:initData()

    self.NPCID = 0

    -- 交互锁标识
    self.interactiveLock = 0

    -- 采集出阵的三个宠物
    self.workers = {}

    -- 记录挑战出阵的三个宠物(记录唯一id，获取时加载实例)
    self.battlePets = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
    }

    -- 当前布阵的出阵宠物
    self.curEmbattlePets = {
        [1] = {},
        [2] = {},
        [3] = {},
    }

    -- 神器碎片(位置对应类型，0为无，1为有)目前互相排斥，同类型只有1个，后面如果不排斥可以改成数量
    self.fragmentsBag = {0, 0, 0, 0, 0, 0}

    -- 守卫数据
    self.guardInfo = {
        guards = {
        },
        totalPower = 0,
        isPass = false,
    }

    -- 宝藏数据
    self.treasureInfo = {
        level = 30,
        gatherStartTime = 641559141,
        gatherAwards = {
            {
            num = 30,
            ID = 23020001,
            },
            {
            num = 30,
            ID = 23030001,
            },
            {
            num = 30,
            ID = 22080010,
            },
        },
    }

    -- 是否在宝藏挖掘中
    self.isGathering = false

    -- 神器收集挑战列表
    self.challengerList = {

    }

    -- 当前神器碎片收集对应的碎片
    self.curCollectFragmentIndex = 1

    -- 今日神器碎片合成次数
    self.fragmentCompoundNum = 0

    -- 下次碎片可以合成时间点
    self.fragmentCompoundTime = 0

    -- 交战记录版本
    self.battleRecordVersion = 0

    -- 交战记录
    self.battleRecord = {}

    -- 是否在战斗中（用于延迟显示碎片获得表现）
    self.isFragmentBattling = false

    self.fromLayer = nil --记录挑战的入口界面 1、PetTreasureGatherLayer 守卫  2、PetTreasureChallengerLayer pvp 3、PetTreasureChallengeRecordsLayer 复仇

    --宠物探险关卡进度
    self.petAdvCurLevel = nil

    --宠物探险守卫数据
    self.petAdvGuardCache = {}

    -- 宠物探险出阵宠物
    self.petAdvEmbattlePets = {
        [1] = {},
        [2] = {},
        [3] = {},
    }
    self.exploreLevel = nil
    self.isExploring = false
    self.petAdvata = {}
    self.lastChangeTime = nil
    -- 宠物探险探索出阵宠物
    self.exploringPets = {}
end

function PetTreasureModel:setFromLayer(layer)
    self.fromLayer = layer
end

function PetTreasureModel:getFromLayer()
    return self.fromLayer
end


function PetTreasureModel:handleGatherPetsData(data)

    if data.collectStatus and data.collectStatus == 1 then
        self.isGathering = true
    else
        self.isGathering = false
    end

    if data.startCollectTime then
        self.treasureInfo.gatherStartTime = data.startCollectTime
    end

    if data.treasureGuards then
        for key, value in ipairs(data.treasureGuards) do
            local petData = Data.PetRoleData:create()
            petData:init(value, true)
            self.guardInfo.guards[key] = petData
        end
    end

    if data.fightPets and data.fightPets.fightingPets then
        for key, value in ipairs(data.fightPets.fightingPets) do
            local petData = Data.PetRoleData:create()
            petData:init(value, true)
            self.workers[key] = petData
            self.curEmbattlePets[key] = petData
        end
    end

    if data.reward then
        self.treasureInfo.gatherAwards = data.reward
    end

    if data.fragments then
        self:setFragmentsBag(data.fragments)
    end

    if data.petTreasureLV then
        self.treasureInfo.level = data.petTreasureLV
    end

    if data.combinableTime then
        self.fragmentCompoundTime = data.combinableTime
    end
end

function PetTreasureModel:handleCallbackPetsData(data)
    if data.reward then
        self.treasureInfo.gatherAwards = data.reward
    end

    if data.fragments then
        self:setFragmentsBag(data.fragments)
    end

    self.isGathering = false
end

------------------------------------------------
-- 获取npcid
function PetTreasureModel:getNPCID()
    return self.NPCID
end

-- 获取宝藏等级
function PetTreasureModel:getTreasureLevel()
    return self.treasureInfo.level
end

-- 获取宝藏采集的开始时间
function PetTreasureModel:getGatherStartTime()
    return self.treasureInfo.gatherStartTime
end

-- 获取宝藏采集上限的剩余时间
function PetTreasureModel:getGatherRemainTime()
    if not self:getIsGathering() then
        return 0
    end

    local PetTreasureMaxTime = tonumber(ConfigManager:getGeneralForKey("petTreasureMaxTime"))

    local remainTime = PetTreasureMaxTime - (GameManager:getNormalServerTime() - self:getGatherStartTime())

    local remainTimeStr = remainTime > 0 and AvalonUtil:_getFullFormatTime(remainTime, true, true, false) or "00:00:00"

    return remainTimeStr
end

-- 获取宝藏采集奖励（不含碎片）
function PetTreasureModel:getGatherRewards()
    local configData = ConfigManager:getPetTreasureByID(self.treasureInfo.level)
    local PetTreasureMaxTime = tonumber(ConfigManager:getGeneralForKey("petTreasureMaxTime"))
    local intervalTimeStr = ConfigManager:getGeneralForKey("petTreasureTickRate")
    local intervalTime = string.split(intervalTimeStr, ",")
    local passTime = 0
    if GameManager:getNormalServerTime() - self:getGatherStartTime() > PetTreasureMaxTime then
        passTime = PetTreasureMaxTime
    else
        passTime = GameManager:getNormalServerTime() - self:getGatherStartTime()
    end

    local rewards = {}
    for index = 1, 3 do
        local award = {}
        award.ID = tonumber(configData["incomeValue"..index][1])
        if award.ID ~= nil and award.ID ~= 0 then
            award.num = tonumber(configData["incomeValue"..index][2]) * math.floor(passTime / intervalTime[index])
            table.insert(rewards, award)
        end
    end

    self.treasureInfo.gatherAwards = rewards

    return self.treasureInfo.gatherAwards
end

-- 获取宝藏采集守卫数据
function PetTreasureModel:getGuardsData()
    return self.guardInfo.guards
end

-- 获取宝藏采集守卫总战力
function PetTreasureModel:getGuardsTotalPower()
    self.guardInfo.totalPower = 0

    for key, value in pairs(self.guardInfo.guards) do
        self.guardInfo.totalPower = self.guardInfo.totalPower + value.power
    end

    return self.guardInfo.totalPower
end

-- 获取宝藏采集守卫是否被打倒
function PetTreasureModel:isPassGuards()
    return self.guardInfo.isPass
end

-- 获取宝藏采集出阵宠物
function PetTreasureModel:getWorkersData()
    return self.workers
end

-- 获取布阵出阵宠物
function PetTreasureModel:getcurEmbattlePetsData()
    return self.curEmbattlePets
end

-- 获取布阵出阵宠物数量
function PetTreasureModel:getcurEmbattlePetsNum()
    local num = 0
    for _, value in pairs(self.curEmbattlePets) do
        if value and value.templateID then
            num = num + 1
        end
    end
    return num
end

-- 获取出阵总战力
function PetTreasureModel:getCurEmbattlePower()
    local power = 0
    for key, value in pairs(self.curEmbattlePets) do
        if value and value.templateID then
            power = power + value.power
        end
    end

    return power
end

-- 获取探险出阵总战力
function PetTreasureModel:getAdvEmbattlePower()
    local power = 0
    for key, value in pairs(self.petAdvEmbattlePets) do
        if value and value.templateID then
            power = power + value.power
        end
    end

    return power
end

-- 获取神器收集出阵宠物
function PetTreasureModel:getBattlePets()
    local petsBag = MasterDataManager:getBagPets()
    local battlePetsList = {}
    for index = 1, 3 do
        battlePetsList[index] = {}
        if self.battlePets[index] ~= 0 then
            for _, value in pairs(petsBag) do
                if value:getId() == self.battlePets[index] then
                    battlePetsList[index] = value
                end
            end
        end
    end

    return battlePetsList
end

-- 获取神器碎片背包情况
function PetTreasureModel:getFragmentsBag()
    return self.fragmentsBag
end

-- 获取神器碎片总数
function PetTreasureModel:getFragmentsTotalNum()
    local totalNum = 0
    for _, value in pairs(self.fragmentsBag) do
        totalNum = totalNum + value
    end

    return totalNum
end

-- 读取本地神器碎片记录
function PetTreasureModel:readFragmentMessage() 

    local goodsData = GoodsDataManager:getSaveGoodsData()
    local fragmentsBag = {}
    for i = 1, 6 do
        local fragment = tonumber(goodsData._newGoodsFlag.goodsArr[tostring("fragment_"..i)])
        if not fragment then
            self:writeFragmentMessage(i, "1")
            fragment = 1
        end
        fragmentsBag[i] = fragment
    end

    -- return {0,0,0,0,0,0}
    return fragmentsBag

end

-- 写入本地神器碎片记录
function PetTreasureModel:writeFragmentMessage(index, str)
    -- if index then
    --     return
    -- end
    local goodsData = GoodsDataManager:getSaveGoodsData()
    goodsData._newGoodsFlag.goodsArr[tostring("fragment_"..index)] = str
    Avalon.UserDataManager:save()
end

-- 获取神器收集挑战对象列表
function PetTreasureModel:getFragmentsBattleList()
    return self.challengerList
end

-- 获取神器碎片今日合成次数
function PetTreasureModel:getFragmentCompoundNum()
    return self.fragmentCompoundNum
end

-- 获取碎片合成时间点
function PetTreasureModel:getFragmentCompoundTime()
    return self.fragmentCompoundTime
end

-- 是否正在宝藏收集中
function PetTreasureModel:getIsGathering()
    return self.isGathering
end

-- 获取战斗记录
function PetTreasureModel:getBattleRecord()
    return self.battleRecord
end

-- 获取战斗记录版本
function PetTreasureModel:getBattleRecordVersion()
    return self.battleRecordVersion
end

function PetTreasureModel:getPacketPets(stype)
    local bagPets = clone(MasterDataManager:getBagPets())
    if stype == "PetTreasureGatherLayer" or stype == "PetTreasureChallengerLayer" or stype == "PetTreasureChallengeRecordsLayer" then
        for _, v in pairs(self.curEmbattlePets) do
            for key, value in pairs(bagPets) do
                if v and v.spriteID and value:getId() == v:getId() then
                    table.remove(bagPets, key)
                    break
                end
            end
        end
    end
    if stype == "PetTreasureAdventureLayer" then
        -- PetTreasureAdventureLayer:getPetAdvWorkList
        for _, v in pairs(self.petAdvEmbattlePets) do
            for key, value in pairs(bagPets) do
                if v and v.spriteID and value:getId() == v:getId() then
                    table.remove(bagPets, key)
                    break
                end
            end
        end
    end

    return bagPets
end

-- function PetTreasureModel:getAdventurePacketPets(stype)
--     local bagPets = clone(MasterDataManager:getBagPets())
--     if stype == "PetTreasureAdventureLayer" then
--         -- PetTreasureAdventureLayer:getPetAdvWorkList
--         for _, v in pairs(self.petAdvEmbattlePets) do
--             for key, value in pairs(bagPets) do
--                 if v and v.spriteID and value:getId() == v:getId() then
--                     table.remove(bagPets, key)
--                     break
--                 end
--             end
--         end
--     end

--     return bagPets
-- end

-- 获取当前神器碎片挑战对应的碎片
function PetTreasureModel:getCurCollectFragmentIndex()
    return self.curCollectFragmentIndex
end 

-- 是否可以召回 
function PetTreasureModel:getCanCallbackGatherPets()
    local intervalTime = tonumber(ConfigManager:getGeneralForKey("petTreasureRecallLimit"))
    local passTime = GameManager:getNormalServerTime() - self:getGatherStartTime()

    if passTime > intervalTime then
        return true
    else
        return false
    end
end

-- 获取当前是否正在进行碎片挑战
function PetTreasureModel:getIsFragmentBattling()
    return self.isFragmentBattling
end

-----------------------------------
-- 保存npcid
function PetTreasureModel:setNPCID(NPCID)
    self.NPCID = NPCID
end

-- 清空当前采集宠物
function PetTreasureModel:clearWorkersData()
    self.workers = {}
end 

-- 存入当前布阵出阵宠物
function PetTreasureModel:setcurEmbattlePetsData(value)
    self.curEmbattlePets = value
end

-- 清空当前布阵
function PetTreasureModel:clearcurEmbattlePetsData()
    self.curEmbattlePets = {
        [1] = {},
        [2] = {},
        [3] = {},
    }
end

-- 清空冒险布阵
function PetTreasureModel:clearAdvEmbattlePetsData()
    self.petAdvEmbattlePets = {
        [1] = {},
        [2] = {},
        [3] = {},
    }
end

-- 清空碎片
function PetTreasureModel:clearFragmentsBag()
    for index = 1, #self.fragmentsBag do
        self.fragmentsBag[index] = 0
    end
end

-- 记录下出战宠物
function PetTreasureModel:setBattlePets(value)
    self.battlePets = value
end

-- 设置碎片
function PetTreasureModel:setFragmentsBag(value)
    -- 战斗中不设置，延迟表现
    if self.isFragmentBattling then
        return
    end
    self.fragmentsBag = value
end

-- 设置采集状态
function PetTreasureModel:setIsGathering(value)
    self.isGathering = value
end

-- 设置交战记录版本
function PetTreasureModel:setBattleRecordVersion(version)
    self.battleRecordVersion = version
end

-- 设置交战记录
function PetTreasureModel:setBattleRecord(log)
    self.battleRecord = log
end

-- 设置下次碎片合成时间点
function PetTreasureModel:setFragmentCompoundTime(time)
    self.fragmentCompoundTime = time
end

-- 设置当前是否正在进行碎片挑战
function PetTreasureModel:setIsFragmentBattling(value)
    self.isFragmentBattling = value
end

-- 设置神器收集挑战对象列表
function PetTreasureModel:setFragmentsBattleList(value)
    self.challengerList = value
end

-- 获取布阵出阵宠物数量
function PetTreasureModel:getPetAdvPetsNum()
    local num = 0
    for _, value in pairs(self.petAdvEmbattlePets) do
        if value and value.templateID then
            num = num + 1
        end
    end
    return num
end

-- 宠物探险关卡进度
function PetTreasureModel:setPetAdvLevel(curLevle) 
    self.petAdvCurLevel = curLevle
end

-- 宠物探险关卡进度
function PetTreasureModel:getPetAdvLevel()   
    return self.petAdvCurLevel
end

-- 宠物探险记录数据同步时间
function PetTreasureModel:setLastChangeTime(lastChangeTime)  
    self.lastChangeTime = lastChangeTime
end

-- 宠物探险记录数据同步时间
function PetTreasureModel:getLastChangeTime()  
    return self.lastChangeTime
end

-- 宠物探险关卡数据
function PetTreasureModel:setPetAdvData(adventure)
    self.petAdvata = adventure or self.petAdvata
end

-- 宠物探险关卡数据
function PetTreasureModel:getPetAdvData()
    return self.petAdvata
end  

-- 宠物探险关卡配置
function PetTreasureModel:getAdvGuardsDataById(id)
    return ConfigManager:getPetAdvLevleSelectDataById(id)
end

--缓存宠物探险守卫数据
function PetTreasureModel:setPetAdvGuardCache(data)
    local guardData = {}
    for k, v in pairs(data.robots) do
        local petData = Data.PetRoleData:create()
        petData:init(v, true)
        table.insert(guardData, petData)
    end
    self.petAdvGuardCache[data.extra] = guardData
end

--获取宠物探险守卫缓存数据
function PetTreasureModel:getPetAdvGuardCacheById(id)
    return self.petAdvGuardCache[id]
end

--宠物探险上阵宠物
function PetTreasureModel:setPetAdvEmbattlePets(petList)
    self.petAdvEmbattlePets = petList
end

--宠物探险上阵宠物
function PetTreasureModel:getPetAdvEmbattlePets()
    if self:getExploreState() and self.petAdvata.petsId then
        for k, v in pairs(self.petAdvata.petsId) do
            local petData = clone(MasterDataManager:getBagPetById(v))
            -- 出战标识关闭
            petData:setReadyFight(false)
            self.petAdvEmbattlePets[k] = petData
        end
    end
    return self.petAdvEmbattlePets
end

--宠物探险上阵宠物
function PetTreasureModel:setExploringPets(petList)
    self.exploringPets = petList
end

--宠物探险上阵宠物
function PetTreasureModel:getExploringPets()  
    return self.exploringPets
end

--宠物探险探索关卡
function PetTreasureModel:setExploreLevel(levle)
    self.exploreLevel = levle
end

--宠物探险探索关卡
function PetTreasureModel:getExploreLevel()
    local petAdvData = self:getPetAdvData()
    self.exploreLevel = petAdvData.level
    return self.exploreLevel
end

--宠物探险探索状态
function PetTreasureModel:setExploreState(state)
    self.isExploring = state
end

--宠物探险探索状态
function PetTreasureModel:getExploreState()
    -- return self.isExploring
    local petAdvData = self:getPetAdvData()
    if petAdvData and petAdvData.startTime and petAdvData.startTime > 0 then
        self.isExploring = true
    else
        self.isExploring = false
    end
    return self.isExploring
end

-- 获取宠物探险探索的剩余时间 
function PetTreasureModel:getExploreRemainTime()
    if not self:getExploreState() then
        return 0    
    end

    -- local PetTreasureMaxTime = tonumber(ConfigManager:getGeneralForKey("petTreasureMaxTime"))
    local endTime = self.petAdvata.endTime
    local remainTime = endTime - GameManager:getNormalServerTime()
    -- print("getExploreRemainTime", remainTime, endTime, GameManager:getNormalServerTime())
    local remainTimeStr = remainTime > 0 and AvalonUtil:_getFullFormatTime(remainTime, true, true, false) or "00:00:00"

    return remainTime, remainTimeStr
end

-- 获取宠物探险探索奖励
function PetTreasureModel:getExploreRewards()
    local configData = ConfigManager:getPetTreasureByID(self.treasureInfo.level)

    local rewards = {}
    local award = {}
    award.ID = tonumber(23020001)
    if award.ID ~= nil and award.ID ~= 0 then
        award.num = self.petAdvata.dropGold
        table.insert(rewards, award)
    end
    self.treasureInfo.exploreAwards = rewards

    return self.treasureInfo.exploreAwards
end

--宠物探险探索背包
function PetTreasureModel:getGoodsArrForBag(packageType)
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
    
    
    local totalSize = #goodsArr.haveEquipmentArr + #goodsArr.haveItemArr + #goodsArr.haveMaterialArr + #goodsArr.haveGemStoneArr + #goodsArr.haveRelicArr + #goodsArr.haveTreasureArr
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

--宠物探险探索背包
function PetTreasureModel:getGoodsArrLenth(packageType)
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
    
    local totalSize = #goodsArr.haveEquipmentArr + #goodsArr.haveItemArr + #goodsArr.haveMaterialArr + #goodsArr.haveGemStoneArr + #goodsArr.haveRelicArr + #goodsArr.haveTreasureArr
    return totalSize
end

function PetTreasureModel:getBagHaveGoodsForPacketType(packetType)

    return GoodsDataManager:getHaveGoodsForPK(RoleDataManager:getMasterPK(), packetType)
end

return PetTreasureModel


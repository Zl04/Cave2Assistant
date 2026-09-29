--[[--
数据模型StarPrayModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]
------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/24
--desc	: StarPrayModel
------------------------------------------------------------------------------
local StarPrayModel = class("StarPrayModel", mvc.GameModel)
local GameDataManager = require("app.game.GameDataManager")
local PACKET_TYPE = PublicDefine.PACKET_TYPE
local MAX_SWALLOW_BAG_SIZE = 20

function StarPrayModel:initData()
    self.money = 0
    self.luckyDrawData = {}
    self.swallowBagData = {}
    self.shopReward = nil
    self.bagData = {}
    self.poolList = {}

    self.npcId = 0
    self.curSilverBuyCount = 0
    self.curShopExp = 0
    self.maxShopExp = tonumber(ConfigManager:getGeneralForKey("StarPrayLuckyValueTotal")) or 0

    self.swallowSettingMax = tonumber(ConfigManager:getGeneralForKey("StarPrayCanEatRare")) or 2
    
    
    self.curSelectStarPlate = 0
    self.starFireNum = 0
    --当前已激活秘纹
    self.activeStarPatternID = {}
    --增幅等级
    self.level = 1
end

function StarPrayModel:setStarFireNum(num)
    self.starFireNum = num or 0
end

function StarPrayModel:setActiveStarPatternID(activeStarPatternID)
    self.activeStarPatternID = activeStarPatternID or {}
end

function StarPrayModel:setStarPrayLevel(level)
    self.level = level or 1
end

function StarPrayModel:starParyIsActivated(pID)
    local isActivated = false
    for k,v in pairs(self.activeStarPatternID) do
        if tonumber(v) == tonumber(pID) then
            isActivated = true
        end
    end
    return isActivated
end 

function StarPrayModel:getSwllowSettingInfo()
    local selectTagStr = cc.UserDefault:getInstance():getStringForKey("swallowSetting"..GameDataManager:getInstance():getMasterPK(), "1,2") 
    return string.split(selectTagStr, ","), self.swallowSettingMax
end

function StarPrayModel:setSwallowSettingInfo(settings)
    local saveStr = table.concat(settings, ",")
    cc.UserDefault:getInstance():setStringForKey("swallowSetting"..GameDataManager:getInstance():getMasterPK(), saveStr)  
end

function StarPrayModel:getSilverBuyCount()
    return self.curSilverBuyCount
end

function StarPrayModel:updateSilverBuyCount(count)
    self:set("curSilverBuyCount", count)
end

function StarPrayModel:getShopExp()
    return self.curShopExp, self.maxShopExp
end

function StarPrayModel:updateShopExp(exp)
    self:set("curShopExp", exp)
end


function StarPrayModel:getShopCostSilver(plantId)
    local size = #NewConfig.StarPrayShop:getAllDatas()
    local nextIdx = self.curSilverBuyCount + 1
    if size < nextIdx then
        nextIdx = size
    end
    local costConfig = NewConfig.StarPrayShop:getDataById(nextIdx)
    return costConfig.price[plantId] or 0
end

function StarPrayModel:setNpcId(npcId)
    self.npcId = npcId or self.npcId
end

function StarPrayModel:getNpcId()
    return self.npcId
end
function StarPrayModel:isHaveFreePos(num)
    if not self.bagData.haveItemArr or not self.bagData.packetBoxMaxNum then
        self:getStarPrayData()
    end
    local curNum = #self.bagData.haveItemArr
    return curNum + num <= self.bagData.packetBoxMaxNum
end
--获取占星仓库数据
function StarPrayModel:getStarPrayData()
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then
        return nil
    end

    -- 组装背包数据，包括 玩家数据，穿戴装备，拥有物品等数据
    local bagData = {}
    bagData.packetType = PACKET_TYPE.PACKET_STARPRAY
    bagData.heroData = master

    -- 背包能够使用的格子数
    bagData.packetBoxBeUseNum = PublicDefine.CONST_DEFINITION.MAX_STARPRAY_BAG_NUM
    -- 背包最大格子数
    bagData.packetBoxMaxNum = PublicDefine.CONST_DEFINITION.MAX_STARPRAY_BAG_NUM
    -- 获取背包解锁次数
    bagData.unlockBagTimes = 0

    -- 背包信息
    bagData.haveEquipmentArr = {}
    bagData.haveMaterialArr = {}
    bagData.haveGemStoneArr = {}
    bagData.haveItemArr =
        GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )

    table.sort(
        bagData.haveItemArr,
        function(a, b)
            if a.goodsRare ~= b.goodsRare then
                return a.goodsRare > b.goodsRare
            end
            local lv1 = a:getLevel()
            local lv2 = b:getLevel()
            if lv1 ~= lv2 then
                return lv1 > lv2
            end

            local exp1 = a:getExp()
            local exp2 = b:getExp()
            if exp1 ~= exp2 then
                return exp1 > exp2
            end
            return a.goodsID > b.goodsID
        end
    )
    bagData.haveEquipmentArr =
        GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY_WEAR,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )

    self.bagData = bagData
    return bagData
end

function StarPrayModel:isEquiped(goodsData)
    local equips = self.bagData.haveEquipmentArr
    for _, equip in pairs(equips) do
        if equip:getEntityID() == goodsData:getEntityID() then
            return true
        end
    end
    return false
end

function StarPrayModel:sortBagData()
    if self.bagData and self.bagData.haveItemArr then
        table.sort(
            self.bagData.haveItemArr,
            function(a, b)
                if a.goodsRare ~= b.goodsRare then
                    return a.goodsRare > b.goodsRare
                end
                local lv1 = a:getLevel()
                local lv2 = b:getLevel()
                if lv1 ~= lv2 then
                    return lv1 > lv2
                end

                local exp1 = a:getExp()
                local exp2 = b:getExp()
                if exp1 ~= exp2 then
                    return exp1 > exp2
                end
                return a.goodsID > b.goodsID
            end
        )
    end
end
function StarPrayModel:checkCanEquip(goodsData)
    local master = RoleDataManager:getMaster()
    local limitGroup = goodsData.limitGroup

    -- local equipData =
    --     GoodsDataManager:getGoodsArrForPK(
    --     master:getPK(),
    --     PACKET_TYPE.PACKET_STARPRAY_WEAR,
    --     PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    -- )
    local equipData = self:getStarPrayEqiupDataWithIndexOrder()
    for _, equipGoodsData in pairs(equipData) do
        if limitGroup == equipGoodsData.limitGroup then
            return false
        end
    end
    return true
end

function StarPrayModel:checkCanSwallow(goodsData)
    return not goodsData:isMaxLevel()
end

function StarPrayModel:getOneKeyUnEquipIds()
    local master = RoleDataManager:getMaster()
    -- local wearbagData =
    --     GoodsDataManager:getGoodsArrForPK(
    --     master:getPK(),
    --     PACKET_TYPE.PACKET_STARPRAY_WEAR,
    --     PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    -- )
    local wearbagData = self:getStarPrayEqiupDataByStarPlateId(self:getCurStarPlate())

    local res = {}
    for i = 1, #wearbagData do
        local data = wearbagData[i]
        if not data:getIsExpType() then
            table.insert(res, data:getEntityID())
        end
    end
    return res
end

function StarPrayModel:getOneKeyEquipIds()
    local master = RoleDataManager:getMaster()
    local bagData =
        GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )

    local temList = {}
    for i = 1, #bagData do
        local data = bagData[i]
        if not data:getIsExpType() then
            table.insert(temList, data)
        end
    end
    bagData = temList

    -- local wearbagData =
    --     GoodsDataManager:getGoodsArrForPK(
    --     master:getPK(),
    --     PACKET_TYPE.PACKET_STARPRAY_WEAR,
    --     PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    -- )

    local wearbagData = self:getStarPrayEqiupDataByStarPlateId(self:getCurStarPlate())
    
    local candidate = {}
    local bagLen = #bagData
    for i = 1, bagLen do
        table.insert(candidate, i)
    end
    for i = 1, #wearbagData do
        table.insert(candidate, bagLen + i)
    end

    table.sort(
        candidate,
        function(idx1, idx2)
            local a = bagData[idx1]
            if idx1 > bagLen then
                a = wearbagData[idx1 - bagLen]
            end
            local b = bagData[idx2]
            if idx2 > bagLen then
                b = wearbagData[idx2 - bagLen]
            end
            local lv1 = a:getLevel()
            local lv2 = b:getLevel()
            if lv1 ~= lv2 then
                return lv1 > lv2
            end
            
            if a.goodsRare ~= b.goodsRare then
                return a.goodsRare > b.goodsRare
            end
            

            local exp1 = a:getExp()
            local exp2 = b:getExp()
            if exp1 ~= exp2 then
                return exp1 > exp2
            end
            return a.goodsID > b.goodsID
        end
    )

    local tmp = {}
    local maxSlot = self:getUnlockSlotNum()
    -- local items = self:getStarPrayEqiupData()
    -- local nextSlot = #items + 1

    for i = 1, maxSlot do
        -- local idx = #items + i
        local isGet = false
        for i = 1, #candidate do
            local idx = candidate[i]
            local goodsData = bagData[idx]
            if idx > bagLen then
                goodsData = wearbagData[idx - bagLen]
            end
            local limitGroup = goodsData.limitGroup
            local isOk = true
            for i = 1, #tmp do
                if limitGroup == tmp[i].limitGroup then
                    isOk = false
                    break
                end
            end

            if isOk then
                isGet = true
                table.insert(tmp, goodsData)
                break
            end
        end
        if not isGet then
            break
        end
    end
    local res = {}
    for i = 1, #tmp do
        table.insert(res, tmp[i]:getEntityID())
    end
    return res
end

function StarPrayModel:updateStarPrayEquipIndex(entityIds, indexs, plateId)
    local equipDatas = self:getAllStarPrayEqiupData()--self:getStarPrayEqiupDataByStarPlateId(plateId)
    if equipDatas then
        for i = 1, #entityIds do
            local entityId = entityIds[i]
            for _, goodsData in pairs(equipDatas) do
                if goodsData:getEntityID() == entityId then
                    goodsData:setIndex(indexs[i])
                    goodsData:setBelong(plateId)
                    break
                end
            end
        end
    end
end

function StarPrayModel:updateStarPrayEquipBelong(entityIds, plateId)
    local equipDatas = self:getAllStarPrayEqiupData()--self:getStarPrayEqiupDataByStarPlateId(plateId)
    if equipDatas then
        for i = 1, #entityIds do
            local entityId = entityIds[i]
            for _, goodsData in pairs(equipDatas) do
                if goodsData:getEntityID() == entityId then
                    goodsData:setBelong(plateId)
                    break
                end
            end
        end
    end
end

function StarPrayModel:getOneKeySwallowIds(withoutEntityId)
    local master = RoleDataManager:getMaster()
    local bagData =
        GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )
    local res = {}
    local settings = self:getSwllowSettingInfo()
    local settingsmap = {}
    for _, tag in pairs(settings) do
        settingsmap[tonumber(tag)] = true
    end
    
    local exp = 0
    for _, goodsData in pairs(bagData) do
        if not goodsData:getIsLock() and withoutEntityId ~= goodsData:getEntityID() and settingsmap[goodsData:getGoodsRare()] then
            table.insert(res, goodsData:getEntityID())
            exp = exp + goodsData:getSwallowExp() + goodsData:getExp()
        end
    end

    return res, exp
end

function StarPrayModel:getUnlockSlotNum()
    -- local unLockLvList = string.split(ConfigManager:getGeneralForKey("StarPrayUnlockLevel"), ";")
    local heroData = GameDataManager:getInstance():getMaster()
    -- local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
    local usePlate = self:getCurStarPlate()
    local config = ConfigManager:getStarPlateDataByID(usePlate)
    local unLockLvList = config.slotUnlockLevel

    local masterData = GameDataManager:getInstance():getMaster()
    if not (masterData) then
        return 0
    end
    for i = 1, #unLockLvList do
        if masterData:getLevel() < checkint(unLockLvList[i]) then
            return i - 1
        end
    end

    return #unLockLvList
end

function StarPrayModel:findFreePosToEquip(spID)
    local items = self:getStarPrayEqiupDataByStarPlateId(spID)--self:getStarPrayEqiupData()
    local nextSlot = #items + 1
    local maxSlot = self:getUnlockSlotNum()
    if maxSlot >= nextSlot then
        return nextSlot
    end
    return
end

--获取占星装备
function StarPrayModel:getStarPrayEqiupData()
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then
        return nil
    end

    local bagData = GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY_WEAR,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )

    local equipData = {}
    local spId = tonumber(master:getUseStarPlate())
    for k,v in pairs(bagData) do
        if v.getBelong and tonumber(v:getBelong()) == spId then
            table.insert(equipData,v)
        end
    end

    -- return GoodsDataManager:getGoodsArrForPK(
    --     master:getPK(),
    --     PACKET_TYPE.PACKET_STARPRAY_WEAR,
    --     PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    -- )

    return equipData
end

--获取占星装备
function StarPrayModel:getStarPrayEqiupDataByStarPlateId(spId)
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then
        return nil
    end

    local bagData = GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY_WEAR,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )

    local equipData = {}
    -- local spId = tonumber(master:getUseStarPlate())
    for k,v in pairs(bagData) do
        if v.getBelong and tonumber(v:getBelong()) == spId then
            table.insert(equipData,v)
        end
    end

    -- return GoodsDataManager:getGoodsArrForPK(
    --     master:getPK(),
    --     PACKET_TYPE.PACKET_STARPRAY_WEAR,
    --     PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    -- )

    return equipData
end

--获取全部装备
function StarPrayModel:getAllStarPrayEqiupData()
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then
        return nil
    end

    local bagData = GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY_WEAR,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )

    -- local equipData = {}
    -- for k,v in pairs(bagData) do
    --     table.insert(equipData,v)
    -- end

    return GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY_WEAR,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )

    -- return equipData
end

function StarPrayModel:getStarPrayEqiupDataWithIndexOrder()
    local equipDatas = self:getStarPrayEqiupDataByStarPlateId(self:getCurStarPlate())--self:getStarPrayEqiupData()
    if equipDatas then
        table.sort(
            equipDatas,
            function(a, b)
                return (a.index or 0) < (b.index or 0)
            end
        )
    end
    return equipDatas
end

function StarPrayModel:resetStarPrayBagGoodsData(entityId)
    for _, goodsData in pairs(self.bagData.haveItemArr) do
        if goodsData:getEntityID() == entityId then
            goodsData._changeNum = 0
        end
    end
end

function StarPrayModel:resetStarPrayBagGoodsAllData()
    for _, goodsData in pairs(self.bagData.haveItemArr) do
        goodsData._changeNum = 0
    end
    for _, goodsData in pairs(self.bagData.haveEquipmentArr) do
        goodsData._changeNum = 0
    end
end

function StarPrayModel:updateStarPrayInfo(id, lv, exp)
    for k, goodsData in pairs(self.bagData.haveItemArr) do
        if goodsData:getEntityID() == id then
            goodsData:setExp(exp)
            goodsData:setLevel(lv)
            return
        end
    end

    for k, goodsData in pairs(self.bagData.haveEquipmentArr) do
        if goodsData:getEntityID() == id then
            goodsData:setExp(exp)
            goodsData:setLevel(lv)
            return
        end
    end
end

function StarPrayModel:setUseGoodsBagGoods(goodsData)
end

--获取占星仓库数据
function StarPrayModel:getStarPraySwallowData()
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then
        return nil
    end

    -- 组装背包数据，包括 玩家数据，穿戴装备，拥有物品等数据
    self.swallowBagData.packetType = PACKET_TYPE.PACKET_STARPRAY
    self.swallowBagData.heroData = master

    -- 背包能够使用的格子数
    self.swallowBagData.packetBoxBeUseNum = MAX_SWALLOW_BAG_SIZE
    -- 背包最大格子数
    self.swallowBagData.packetBoxMaxNum = MAX_SWALLOW_BAG_SIZE
    -- 获取背包解锁次数
    self.swallowBagData.unlockBagTimes = 0

    -- 背包信息
    self.swallowBagData.haveEquipmentArr = {}
    self.swallowBagData.haveMaterialArr = {}
    self.swallowBagData.haveGemStoneArr = {}
    self.swallowBagData.haveItemArr = {}

    return self.swallowBagData
end

-- 获取当前背包空闲数量
function StarPrayModel:getStarPrayPacketFreeBoxNum()
    -- 玩家属性信息
    local master = RoleDataManager:getMaster()
    if (not master) then
        return 0
    end
    local haveItemArr =
        GoodsDataManager:getGoodsArrForPK(
        master:getPK(),
        PACKET_TYPE.PACKET_STARPRAY,
        PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    )
    return PublicDefine.CONST_DEFINITION.MAX_STARPRAY_BAG_NUM - #haveItemArr
end

function StarPrayModel:getSwallItemEntityIds()
    local res = {}
    local hasGoldRare = false
    local exp = 0
    for k, goodsData in pairs(self.swallowBagData.haveItemArr) do
        table.insert(res, goodsData:getEntityID())
        exp = exp + goodsData:getSwallowExp() + goodsData:getExp()
        if goodsData:getGoodsRare() > 2 then
            hasGoldRare = true
        end
    end
    return res, hasGoldRare, exp
end

function StarPrayModel:getTotalSwallowExp()
    local exp = 0
    for k, goodsData in pairs(self.swallowBagData.haveItemArr) do
        exp = exp + goodsData:getSwallowExp() + goodsData:getExp()
    end
    return exp
end

function StarPrayModel:addSwallowGoodsData(goodsData)
    local cur = #self.swallowBagData.haveItemArr
    if cur >= MAX_SWALLOW_BAG_SIZE then
        return false
    end
    local cloneData = clone(goodsData)
    cloneData._changeNum = 0
    cloneData._hideLock = true
    table.insert(self.swallowBagData.haveItemArr, cloneData)

    self:setForce("swallowBagData")
    return true
end

function StarPrayModel:removeSwallowGoodsData(goodsData)
    for k, v in pairs(self.swallowBagData.haveItemArr) do
        if v == goodsData then
            table.remove(self.swallowBagData.haveItemArr, k)
            break
        end
    end
    self:setForce("swallowBagData")
end

function StarPrayModel:clearSwallowBag()
    self.swallowBagData.haveItemArr = {}
    self:setForce("swallowBagData")
end

--根据配置表 得出每个奖池 能出现的品质
function StarPrayModel:getRandomShopQualityData()
    local poolList = self:generalRandomShopData()
    local qualityList = {}
    for k, v in pairs(poolList) do
        local list = qualityList[k]
        if list == nil then
            list = {}
        end
        for k2, v2 in ipairs(v) do
            list[v2.goodsRare] = 1
        end
        qualityList[k] = table.keys(list)
        table.sort(
            qualityList[k],
            function(a, b)
                return a < b
            end
        )
    end

    return qualityList
end

--根据配置表 得出每个奖池 能出现的品质
function StarPrayModel:generalRandomShopData()
    if table.nums(self.poolList) ~= 0 then
        return self.poolList
    end
    local list = ConfigManager:getAllStarPray()
    local poolList = {}
    for k, v in pairs(list) do
        for k2, v2 in ipairs(v.weight) do
            if v2 > 0 then
                local pool = poolList[k2]
                if pool == nil then
                    pool = {}
                    poolList[k2] = pool
                end
                table.insert(pool, v)
            end
        end
    end
    self.poolList = poolList
    return self.poolList
end

--根据配置表 得出每个奖池 能出现的品质
function StarPrayModel:setLuckyDrawData(isSuccess, data)
    self.luckyDrawData.isSuccess = isSuccess
    if isSuccess then
        self:setStarFireNum(data.starFireNum)
        self.luckyDrawData.curIndex = data.starPrayPool + 1
        self.luckyDrawData.goodsData = data.goodsData
        self:setStarPrayPool(data.starPrayPool)
    end
    self:setForce("luckyDrawData")
end

function StarPrayModel:setStarPrayPool(poolIdx)
    local master = GameDataManager:getInstance():getMaster()
    master:setStarPrayPool(poolIdx)
end

function StarPrayModel:setRewardData(data)
    self.luckyDrawData.goodsData = data.goodsData
    self:setForce("shopReward")
end

function StarPrayModel:getLuckyDrawData()
    return self.luckyDrawData
end

function StarPrayModel:clearRewardData()
    self.luckyDrawData = {}
    self.starFireNum = 0
end

function StarPrayModel:selectStarPlate(curSelectStarPlate)
    self.curSelectStarPlate = curSelectStarPlate
end

function StarPrayModel:getCurStarPlate()
    if self.curSelectStarPlate == 0 then
        local heroData = GameDataManager:getInstance():getMaster()
        local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
        self.curSelectStarPlate = usePlate
    end

    return self.curSelectStarPlate
end

function StarPrayModel:getStarPlateListDatasID()
    --获取每个星盘的数据列表, 出战排第一个,后面根据星盘ID从低到高排序
    local dataID = {}
    local curPlate = self:getCurStarPlate()
    local masterData = RoleDataManager:getMaster()
    local unlockList = masterData:getUnlockStarPlate()

    for k,v in pairs(unlockList) do
        if tonumber(k) ~= tonumber(curPlate) and v == true then
            table.insert(dataID, tonumber(k))
        end
    end

    if #dataID > 1 then
        table.sort(dataID, function(a, b)
            return a > b
        end)
    end

    table.insert(dataID, 1, tonumber(curPlate))

    return dataID
end

function StarPrayModel:getCurStarPlateDatasByBelong(belong)
    local data = {}
    if self.bagData.haveEquipmentArr then
        for k,v in pairs(self.bagData.haveEquipmentArr) do
            if v.belong == belong then
                table.insert(data,v)
            end
        end
    end

    return data
end

function StarPrayModel:checkStarPlateIsUnlock(spID)
    if spID == 1 then
        return true
    end
    local masterData = RoleDataManager:getMaster()
    local unlockList = masterData:getUnlockStarPlate()
    return unlockList[spID]
end

function StarPrayModel:calculateTotalLevelAndGradeList(starData,starPatternLevel,usePlate)
    local totalLv = 0
    local gradeList = {}
    for k, v in pairs(starData) do
        totalLv = totalLv + v.level
        gradeList[v.goodsRare] = (gradeList[v.goodsRare] or 0) + 1
    end

    local additionalAddLevel = self:getLocalStarPlateReduceLevel(starPatternLevel,usePlate)
    totalLv = totalLv + additionalAddLevel

    return totalLv, gradeList
end

function StarPrayModel:calculateUnlockCondition(arrtUnlockType, arrtUnlockNum)
    local unlockCondition = {}
    for k, v in pairs(arrtUnlockType) do
        unlockCondition[k] = {
            unlockTypeList = string.split(arrtUnlockType[k], ","),
            unlockNumList = string.split(arrtUnlockNum[k], ",")
        }
    end
    return unlockCondition
end

function StarPrayModel:checkUnlockCondition(unlockCondition, totalLv, gradeList)
    local activeLv = 0
    for k, v in pairs(unlockCondition) do
        local isUnlock = true
        local realIndex = 1
        for index, unlockType in pairs(v.unlockTypeList) do
            local unlockNum = tonumber(v.unlockNumList[realIndex])
            if tonumber(unlockType) == 1 then
                isUnlock = isUnlock and totalLv >= unlockNum
                realIndex = realIndex + 1
            elseif tonumber(unlockType) == 2 then
                local starNum = 0
                for grade, num in pairs(gradeList) do
                    if grade >= unlockNum then
                        starNum = starNum + num
                    end
                end
                isUnlock = isUnlock and starNum >= tonumber(v.unlockNumList[realIndex+1])
                realIndex = realIndex + 2
            end
        end
        if isUnlock then
            activeLv = k
        end
    end
    return activeLv
end

function StarPrayModel:getPlateActiveAttrLevel(config,starPatternLevel,starData,usePlate)
    local starData = starData or self:getStarPrayEqiupDataByStarPlateId(config.id)
    local attrDesList = config.buffDes
    local arrtUnlockType = string.split(config.buffUnlockType, ";")
    local arrtUnlockNum = string.split(config.buffUnlockNum, ";")

    if #attrDesList == 0 then
        return 0, 0, {}
    end

    local totalLv, gradeList = self:calculateTotalLevelAndGradeList(starData,starPatternLevel,usePlate)
    local unlockCondition = self:calculateUnlockCondition(arrtUnlockType, arrtUnlockNum)
    local activeLv = self:checkUnlockCondition(unlockCondition, totalLv, gradeList)

    return activeLv, totalLv, gradeList
end

--当前增幅等级的符文,是否全都点亮
function StarPrayModel:isAllRuneLight()
    local isLight = false
    -- activeStarPatternID
    local upgradeConfData = ConfigManager:getStarPlateUpgradeDataByID(self.level)
    if upgradeConfData then        
        for m,n in ipairs(upgradeConfData.patternID) do
            isLight = false
            for k,v in pairs(self.activeStarPatternID) do
                if tonumber(v) == tonumber(n) then
                    isLight = true
                    break
                end
            end
            if not isLight then
                return false
            end
        end
    end

    return isLight
end

function StarPrayModel:getStarPatternIDByIndex(index)
    local starPatternID = nil
    local upgradeConfData = ConfigManager:getStarPlateUpgradeDataByID(self.level)
    if upgradeConfData then
        local patternIDList = upgradeConfData.patternID
        starPatternID = patternIDList[index]
    end

    return starPatternID
end

function StarPrayModel:addActiveStarPatternID(id)
    if id == nil then return end
    table.insert(self.activeStarPatternID,id)
end

-- 获取星座效果激活要求减免等级
function StarPrayModel:getLocalStarPlateReduceLevel(starPatternLevel,usePlate)
    local reduceLevel = 0
    local starPatternLevel = starPatternLevel or self.level
    local localStarPlate = usePlate or self:getCurStarPlate()
    for i = starPatternLevel, 1, -1 do
        local upgradeConfData = ConfigManager:getStarPlateUpgradeDataByID(i)
        if upgradeConfData and upgradeConfData.increaseType == 2 then
            local increaseEffectStrList = string.split(upgradeConfData.increaseEffect, ";")
            if #increaseEffectStrList > 0 then
                for k,v in ipairs(increaseEffectStrList) do
                    local strs = string.split(v, ",")
                    if tonumber(strs[1]) == tonumber(localStarPlate) then
                        reduceLevel = reduceLevel + tonumber(strs[2])
                    end
                end
            end
        end
    end
    return reduceLevel
end


function StarPrayModel:getStarPlateAttributes(plateId)
    local heroData = GameDataManager:getInstance():getMaster()
    local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
    plateId = plateId or usePlate
    local attrData = {
        [PublicDefine.ATTR_TYPE.hp] = {attrType = PublicDefine.ATTR_TYPE.hp, icon = "symbol_gaming_blood.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.hp)},
        [PublicDefine.ATTR_TYPE.magic] = {attrType = PublicDefine.ATTR_TYPE.magic, icon = "symbol_gaming_maggicatk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.magic)},
        [PublicDefine.ATTR_TYPE.atkMin] = {attrType = PublicDefine.ATTR_TYPE.atkMin, icon = "symbol_gaming_atk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkMin)},
        [PublicDefine.ATTR_TYPE.atkMax] = {attrType = PublicDefine.ATTR_TYPE.atkMax, icon = "symbol_gaming_atk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkMax)},
        [PublicDefine.ATTR_TYPE.physicDef] = {attrType = PublicDefine.ATTR_TYPE.physicDef, icon = "symbol_gaming_def.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.physicDef)},
        [PublicDefine.ATTR_TYPE.magicDef] = {attrType = PublicDefine.ATTR_TYPE.magicDef, icon = "symbol_gaming_maggicdef.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.magicDef)},
        [PublicDefine.ATTR_TYPE.atkFire] = {attrType = PublicDefine.ATTR_TYPE.atkFire, icon = "symbol_monsterattribute_fire_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkFire)},
        [PublicDefine.ATTR_TYPE.defFire] = {attrType = PublicDefine.ATTR_TYPE.defFire, icon = "symbol_monsterattribute_fire_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defFire)},
        [PublicDefine.ATTR_TYPE.atkWater] = {attrType = PublicDefine.ATTR_TYPE.atkWater, icon = "symbol_monsterattribute_water_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkWater)},
        [PublicDefine.ATTR_TYPE.defWater] = {attrType = PublicDefine.ATTR_TYPE.defWater, icon = "symbol_monsterattribute_water_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defWater)},
        [PublicDefine.ATTR_TYPE.atkWood] = {attrType = PublicDefine.ATTR_TYPE.atkWood, icon = "symbol_monsterattribute_wood_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkWood)},
        [PublicDefine.ATTR_TYPE.defWood] = {attrType = PublicDefine.ATTR_TYPE.defWood, icon = "symbol_monsterattribute_wood_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defWood)},
        [PublicDefine.ATTR_TYPE.atkLight] = {attrType = PublicDefine.ATTR_TYPE.atkLight, icon = "symbol_monsterattribute_light_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkLight)},
        [PublicDefine.ATTR_TYPE.defLight] = {attrType = PublicDefine.ATTR_TYPE.defLight, icon = "symbol_monsterattribute_light_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defLight)},
        [PublicDefine.ATTR_TYPE.atkDark] = {attrType = PublicDefine.ATTR_TYPE.atkDark, icon = "symbol_monsterattribute_dark_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkDark)},
        [PublicDefine.ATTR_TYPE.defDark] = {attrType = PublicDefine.ATTR_TYPE.defDark, icon = "symbol_monsterattribute_dark_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defDark)},
    }

    local starData = self:getStarPrayEqiupDataByStarPlateId(plateId)
    --计算卡片的属性
    for k,v in pairs(starData) do
        if v.ID ~= 0 then
            local cardConfig = ConfigManager:getStarPrayConfigByID(v.ID)
            local level = v.level--starData[v.Id].level

            local attributeTable = cardConfig.attrGroup--string.split(cardConfig.attributeType, ",")
            local overTable = string.split(cardConfig.attrValue, ";")
            local valueTable = string.split(overTable[level], ",")

            for index,attrType in pairs(attributeTable) do
                if attrData[tonumber(attrType)] then
                    attrData[tonumber(attrType)].value = attrData[tonumber(attrType)].value + tonumber(valueTable[index])
                end
            end
        end
    end

    local data = {}
    local sortTable = {
        PublicDefine.ATTR_TYPE.hp,
        PublicDefine.ATTR_TYPE.magic,
        PublicDefine.ATTR_TYPE.atkMin,
        PublicDefine.ATTR_TYPE.atkMax,
        PublicDefine.ATTR_TYPE.physicDef,
        PublicDefine.ATTR_TYPE.magicDef,
        PublicDefine.ATTR_TYPE.atkFire,
        PublicDefine.ATTR_TYPE.defFire,
        PublicDefine.ATTR_TYPE.atkWater,
        PublicDefine.ATTR_TYPE.defWater,
        PublicDefine.ATTR_TYPE.atkWood,
        PublicDefine.ATTR_TYPE.defWood,
        PublicDefine.ATTR_TYPE.atkLight,
        PublicDefine.ATTR_TYPE.defLight,
        PublicDefine.ATTR_TYPE.atkDark,
        PublicDefine.ATTR_TYPE.defDark
    }

    for k,v in ipairs(sortTable) do
        table.insert(data,attrData[v])
    end

    return data
end

function StarPrayModel:getAllStarFireAttributes()
    local attrData = {
        [PublicDefine.ATTR_TYPE.hp] = {attrType = PublicDefine.ATTR_TYPE.hp, icon = "symbol_gaming_blood.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.hp)},
        [PublicDefine.ATTR_TYPE.magic] = {attrType = PublicDefine.ATTR_TYPE.magic, icon = "symbol_gaming_maggicatk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.magic)},
        [PublicDefine.ATTR_TYPE.atkMin] = {attrType = PublicDefine.ATTR_TYPE.atkMin, icon = "symbol_gaming_atk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkMin)},
        [PublicDefine.ATTR_TYPE.atkMax] = {attrType = PublicDefine.ATTR_TYPE.atkMax, icon = "symbol_gaming_atk.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkMax)},
        [PublicDefine.ATTR_TYPE.physicDef] = {attrType = PublicDefine.ATTR_TYPE.physicDef, icon = "symbol_gaming_def.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.physicDef)},
        [PublicDefine.ATTR_TYPE.magicDef] = {attrType = PublicDefine.ATTR_TYPE.magicDef, icon = "symbol_gaming_maggicdef.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.magicDef)},
        [PublicDefine.ATTR_TYPE.atkFire] = {attrType = PublicDefine.ATTR_TYPE.atkFire, icon = "symbol_monsterattribute_fire_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkFire)},
        [PublicDefine.ATTR_TYPE.defFire] = {attrType = PublicDefine.ATTR_TYPE.defFire, icon = "symbol_monsterattribute_fire_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defFire)},
        [PublicDefine.ATTR_TYPE.atkWater] = {attrType = PublicDefine.ATTR_TYPE.atkWater, icon = "symbol_monsterattribute_water_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkWater)},
        [PublicDefine.ATTR_TYPE.defWater] = {attrType = PublicDefine.ATTR_TYPE.defWater, icon = "symbol_monsterattribute_water_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defWater)},
        [PublicDefine.ATTR_TYPE.atkWood] = {attrType = PublicDefine.ATTR_TYPE.atkWood, icon = "symbol_monsterattribute_wood_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkWood)},
        [PublicDefine.ATTR_TYPE.defWood] = {attrType = PublicDefine.ATTR_TYPE.defWood, icon = "symbol_monsterattribute_wood_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defWood)},
        [PublicDefine.ATTR_TYPE.atkLight] = {attrType = PublicDefine.ATTR_TYPE.atkLight, icon = "symbol_monsterattribute_light_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkLight)},
        [PublicDefine.ATTR_TYPE.defLight] = {attrType = PublicDefine.ATTR_TYPE.defLight, icon = "symbol_monsterattribute_light_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defLight)},
        [PublicDefine.ATTR_TYPE.atkDark] = {attrType = PublicDefine.ATTR_TYPE.atkDark, icon = "symbol_monsterattribute_dark_1.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.atkDark)},
        [PublicDefine.ATTR_TYPE.defDark] = {attrType = PublicDefine.ATTR_TYPE.defDark, icon = "symbol_monsterattribute_dark_2.png", value = 0, attrName = ToolsUtil:getNameByAttrType(PublicDefine.ATTR_TYPE.defDark)},
    }

    --计算卡片的属性
    for k,v in pairs(self.activeStarPatternID) do
        if v ~= 0 then
            local sConfig = ConfigManager:getStarPatternDataByID(v)

            local attributeTable = string.split(sConfig.patternAttr, ";")

            for _,attrs in pairs(attributeTable) do
                local att = string.split(attrs, ",")
                if attrData[tonumber(att[1])] then
                    attrData[tonumber(att[1])].value = attrData[tonumber(att[1])].value + tonumber(att[2])
                end
            end
        end
    end

    local data = {}
    local sortTable = {
        PublicDefine.ATTR_TYPE.hp,
        PublicDefine.ATTR_TYPE.magic,
        PublicDefine.ATTR_TYPE.atkMin,
        PublicDefine.ATTR_TYPE.atkMax,
        PublicDefine.ATTR_TYPE.physicDef,
        PublicDefine.ATTR_TYPE.magicDef,
        PublicDefine.ATTR_TYPE.atkFire,
        PublicDefine.ATTR_TYPE.defFire,
        PublicDefine.ATTR_TYPE.atkWater,
        PublicDefine.ATTR_TYPE.defWater,
        PublicDefine.ATTR_TYPE.atkWood,
        PublicDefine.ATTR_TYPE.defWood,
        PublicDefine.ATTR_TYPE.atkLight,
        PublicDefine.ATTR_TYPE.defLight,
        PublicDefine.ATTR_TYPE.atkDark,
        PublicDefine.ATTR_TYPE.defDark
    }

    for k,v in ipairs(sortTable) do
        table.insert(data,attrData[v])
    end

    return data
end

return StarPrayModel

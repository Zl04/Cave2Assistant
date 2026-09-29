--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-06-15 17:48:30
]]


-- 模块初始化 --
--------------------------------------------
require "utils.Scheduler"
local LanguageManager = require("app.game.LanguageManager")

BagNotificationUtil = BagNotificationUtil or {}

BagNotificationUtil.REASON_GIFTBAG = 1
BagNotificationUtil.REASON_SKILLPOINT = 2
BagNotificationUtil.REASON_UPGRADABLE_EQUIP = 3

local currentlyUpgradableEquipTable = {}
local lastUpgradableEquipTable = {}
local lastGiftBagArr = {}
local lastSkillPoint = 0
local giftBoxShowEndTimeStamp = 0
local newSkillPointShowEndTimeStamp = 0
local upgradableEquipShowEndTimeStamp = 0
local newGiftBagID = nil
local newUpgradableEquipID = nil
--------------------------------------------
-- 模块初始化 --



-- 程序逻辑 --
--------------------------------------------
function BagNotificationUtil:checkShowGiftBoxIcon(goodsData)
    if (not goodsData) then return false end

    -- 获取ID
    local ID = goodsData:getId()
    if (not ID) then return false end

    -- 检查类型是否是礼包
    local type = math.floor(ID / 10000) % 100
    if (not goodsData:getIsNew() or (type ~= 12 and type ~= 14)) then return false end

    -- 检查等级礼包等级
    local giftBagID = goodsData:getId()
    local lvBagConfig = Config.ConfigGoods:getChooseBagById(giftBagID)
    local lvLimit = 0
    if (lvBagConfig and lvBagConfig.levellimt) then
        lvLimit = lvBagConfig.levellimt
    end
    require "app.datas.RoleDataManager"
    local master = RoleDataManager:getMaster()
    local masterLv = master and master:getLevel() or 0
    if (masterLv < lvLimit) then return false end

    -- 都通过就返回可以显示
    return true
end

function BagNotificationUtil:checkShowEquipUpgradableIcon(goodsData)
    if (not goodsData) then return false end

    -- 道具类型检查
    local ID = goodsData:getId()
    if (not ID) then return false end
    local itemType = math.floor(ID / 1000000)
    if (itemType ~= 21 or not goodsData.getEquipmentType) then return false end

    -- 检查道具是否在可升级装备列表里
    local upgradableEquip = currentlyUpgradableEquipTable[goodsData:getEquipmentType()]
    if (upgradableEquip and goodsData and 
        upgradableEquip:getEntityID() == goodsData:getEntityID()) 
    then
        return true
    end

    return false
end

function BagNotificationUtil:updateEquipRecordData(isLvUp)
    require "app.datas.RoleDataManager"
    local master = RoleDataManager:getMaster()
    if (not master) then return end

    currentlyUpgradableEquipTable = {}
    if (master:getLevel() > 10) then return end

    -- 获取已有装备
    require "app.datas.GoodsDataManager"
    local allEquipInBag = GoodsDataManager:getGoodsArrForPK(RoleDataManager:getMasterPK(), PublicDefine.PACKET_TYPE.PACKET_BAG, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)

    -- 获取已穿戴装备
    local originalEquipTable = {}
    local tempEquipTable = {}
    local GameDataManager = require("app.game.GameDataManager")
    local equipData = GameDataManager:getWearEquipmentData()
    if (not equipData or not equipData.wearEquipmentArr) then return false end
    for i,wearingEquip in ipairs(equipData.wearEquipmentArr) do
        local equipType = wearingEquip:getEquipmentType()
        originalEquipTable[equipType] = wearingEquip
        tempEquipTable[equipType] = wearingEquip
    end 

    -- 按规则检查所有道具
    for i,equipInBag in ipairs(allEquipInBag) do
        -- 检查等级
        require "app.datas.RoleDataManager"
        local masterLv = master and master:getLevel() or 0
        local equipLv = equipInBag:getWearLV()
        if (masterLv >= equipLv) then
            local equipType = equipInBag:getEquipmentType()
            local equipToCompare = tempEquipTable[equipType]

            -- 检查武器类型
            local subTypeMatch = true
            if (equipToCompare and equipType == PublicDefine.EQUIPMENT_TYPE.Weapon) then
                if (equipToCompare:getWeaponType() ~= equipInBag:getWeaponType()) then
                    subTypeMatch = false 
                end
            end

            -- 检查空位
            if (equipToCompare == nil) then
                tempEquipTable[equipType] = equipInBag
            -- -- 检查品质
            -- elseif (subTypeMatch and equipInBag:getGoodsRare() > equipToCompare:getGoodsRare()) then
            --     print(" 2222222222222222 ",equipInBag:getGoodsRare(), equipToCompare:getGoodsRare())
            --     tempEquipTable[equipType] = equipInBag
            -- 检查星数
            elseif (subTypeMatch and equipInBag:getCombatScore() > equipToCompare:getCombatScore()) then
                -- print(" 3333333333333 ",equipInBag:getCombatScore(), equipToCompare:getCombatScore())
                tempEquipTable[equipType] = equipInBag
            end
        end
    end

    -- 检查是否有变动
    local isEquipChanged = false
    for k,upgradableEquip in pairs(tempEquipTable) do
        local originalEquip = originalEquipTable[k]
        if (upgradableEquip ~= originalEquip) then
            isEquipChanged = true
            currentlyUpgradableEquipTable[k] = upgradableEquip
            if (isLvUp) then
                upgradableEquip:setIsNew(true)
            end
        end
    end
    if (isLvUp and isEquipChanged) then
        lastUpgradableEquipTable = {}
    end
end

function BagNotificationUtil:updateUpgradableItems(isLvUp)
    self:updateEquipRecordData(isLvUp)

    if (isLvUp) then
        require "app.datas.GoodsDataManager"
        require "app.datas.RoleDataManager"
        local bagItemArr = GoodsDataManager:getGoodsArrForPK(RoleDataManager:getMasterPK(), PublicDefine.PACKET_TYPE.PACKET_BAG, PublicDefine.GOODS_TYPE.GOODS_ITEM)
        for i,bagItem in ipairs(bagItemArr) do
            local ID = bagItem and bagItem:getId() or nil
            if (ID) then 
                local type = math.floor(ID / 10000) % 100
                if (type == 12 or type == 14) then 
                    bagItem:setIsNew(true)
                end
            end
        end
        lastGiftBagArr = {}
    end
    
    self:saveGiftCache()
    self:saveEquipCache()
    self:saveSkillPointCache()

    -- 通知显示刷新
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BAG_NOTI_STATUS)
end

function BagNotificationUtil:checkShowBagButtonNotiIcon()
    -- 检查是否有礼包
    local giftBagNow = {}
    require "app.datas.GoodsDataManager"
    require "app.datas.RoleDataManager"
    local bagItemArr = GoodsDataManager:getGoodsArrForPK(RoleDataManager:getMasterPK(), PublicDefine.PACKET_TYPE.PACKET_BAG, PublicDefine.GOODS_TYPE.GOODS_ITEM)
    for i,bagItem in ipairs(bagItemArr) do
        if (self:checkShowGiftBoxIcon(bagItem)) then
            table.insert(giftBagNow, bagItem)
        end
    end
    local masterLv = 0
    local master = RoleDataManager:getMaster()
    if (master) then masterLv = master:getLevel() end
    local isNewGiftBagExist = false
    for i,v in ipairs(giftBagNow) do
        if (lastGiftBagArr[i] ~= v:getId()) then
            newGiftBagID = v:getId()
            isNewGiftBagExist = true
            break
        end
    end
    lastGiftBagArr = {}
    for i,v in ipairs(giftBagNow) do
        table.insert(lastGiftBagArr, v:getId())
    end


    -- 检查是否有技能
    local isNewSkillPointExist = self:checkSkillPointNotiShowCondition()

    -- 检查是否有装备
    -- 不和上次检查时一样
    local isSameAsLast = true
    for k,v in pairs(currentlyUpgradableEquipTable) do
        if (lastUpgradableEquipTable[k] ~= v:getEntityID()) then
            isSameAsLast = false
        end
    end
    -- 并且不为空
    local isNewUpgradableEquipExist = false
    if (not isSameAsLast and next(currentlyUpgradableEquipTable) ~= nil) then
        for k,upgradableEquip in pairs(currentlyUpgradableEquipTable) do
            if (upgradableEquip:getIsNew()) then
                newUpgradableEquipID = upgradableEquip:getId()
                isNewUpgradableEquipExist = true
                break
            end
        end
    end
    -- 为下次检查更新跟踪器
    lastUpgradableEquipTable = {}
    for k,v in pairs(currentlyUpgradableEquipTable) do
        lastUpgradableEquipTable[k] = v:getEntityID()
    end

    -- 更新记录数据
    if (isNewGiftBagExist or isNewSkillPointExist or isNewUpgradableEquipExist) then
        local timeNow = GameManager:getNormalServerTime()
        if (isNewGiftBagExist) then
            giftBoxShowEndTimeStamp = timeNow + self:getShowDuration()
        end
        
        if (isNewSkillPointExist) then
            newSkillPointShowEndTimeStamp = timeNow + self:getShowDuration()
        end
        
        if (isNewUpgradableEquipExist) then
            upgradableEquipShowEndTimeStamp = timeNow + self:getShowDuration()
        end
    end

    self:saveGiftCache()
    self:saveEquipCache()
    self:saveSkillPointCache()

    -- 返回检查值和理由
    local timeNow = GameManager:getNormalServerTime()
    if (giftBoxShowEndTimeStamp > timeNow) then
        return true, BagNotificationUtil.REASON_GIFTBAG, newGiftBagID
    elseif (newSkillPointShowEndTimeStamp > timeNow) then
        return true, BagNotificationUtil.REASON_SKILLPOINT
    elseif (upgradableEquipShowEndTimeStamp > timeNow) then
        return true, BagNotificationUtil.REASON_UPGRADABLE_EQUIP, newUpgradableEquipID
    else
        return false, 0
    end
end

function BagNotificationUtil:getTimeToDisappear()
    local timeNow = GameManager:getNormalServerTime()
    if (giftBoxShowEndTimeStamp > timeNow) then
        return giftBoxShowEndTimeStamp - timeNow
    elseif (newSkillPointShowEndTimeStamp > timeNow) then
        return newSkillPointShowEndTimeStamp - timeNow
    elseif (upgradableEquipShowEndTimeStamp > timeNow) then
        return upgradableEquipShowEndTimeStamp - timeNow
    else
        return 0
    end
end

function BagNotificationUtil:resetTimeStamp(type, isForce)
    if (BagNotificationUtil.REASON_GIFTBAG == type) then
        giftBoxShowEndTimeStamp = 0
    elseif (BagNotificationUtil.REASON_SKILLPOINT == type) then
        if (isForce or not self:checkSkillPointNotiShowCondition()) then
            newSkillPointShowEndTimeStamp = 0
        end
    elseif (BagNotificationUtil.REASON_UPGRADABLE_EQUIP == type) then
        upgradableEquipShowEndTimeStamp = 0
    end
end

function BagNotificationUtil:getShowDuration()
    return 30
end

function BagNotificationUtil:checkSkillPointNotiShowCondition()
    require "app.datas.SkillDataManager"
    local isSkillPointDifferent = false
    local skillPoint = SkillDataManager:getSkillStudyNum()
    if (skillPoint ~= lastSkillPoint) then
        isSkillPointDifferent = true
        lastSkillPoint = skillPoint
    end
    if (skillPoint > 0 and isSkillPointDifferent) then
        return true
    end
    return false
end



-- 保存礼盒暂存数据
function BagNotificationUtil:saveGiftCache()
    local stringToSave = AvalonUtil.arrToString(lastGiftBagArr)
    local GameDataManager = require("app.game.GameDataManager")
    local masterPK = GameDataManager:getInstance():getMasterPK()
    cc.UserDefault:getInstance():setStringForKey("BAG_NOTI_UTIL_GIFTBOX_CACHE" .. masterPK, stringToSave)
    cc.UserDefault:getInstance():setIntegerForKey("BAG_NOTI_UTIL_GIFTBOX_TS" .. masterPK, giftBoxShowEndTimeStamp)
    cc.UserDefault:getInstance():setIntegerForKey("BAG_NOTI_UTIL_GIFTBOX_ID" .. masterPK, newGiftBagID)
end

-- 保存可更新装备暂存数据
function BagNotificationUtil:saveEquipCache()
    local stringToSave = AvalonUtil.tableToString(lastUpgradableEquipTable)
    local GameDataManager = require("app.game.GameDataManager")
    local masterPK = GameDataManager:getInstance():getMasterPK()
    cc.UserDefault:getInstance():setStringForKey("BAG_NOTI_UTIL_EQUIP_CACHE" .. masterPK, stringToSave)
    cc.UserDefault:getInstance():setIntegerForKey("BAG_NOTI_UTIL_EQUIP_TS" .. masterPK, upgradableEquipShowEndTimeStamp)
    cc.UserDefault:getInstance():setIntegerForKey("BAG_NOTI_UTIL_EQUIP_ID" .. masterPK, newUpgradableEquipID)
end

-- 保存技能点暂存数据
function BagNotificationUtil:saveSkillPointCache()
    local GameDataManager = require("app.game.GameDataManager")
    local masterPK = GameDataManager:getInstance():getMasterPK()
    cc.UserDefault:getInstance():setIntegerForKey("BAG_NOTI_UTIL_SKILL_POINT_CACHE" .. masterPK, lastSkillPoint)
    cc.UserDefault:getInstance():setIntegerForKey("BAG_NOTI_UTIL_SKILL_POINT_TS" .. masterPK, newSkillPointShowEndTimeStamp)
end

-- 加载所有数值
function BagNotificationUtil:loadAllNumbers()
    local GameDataManager = require("app.game.GameDataManager")
    local masterPK = GameDataManager:getInstance():getMasterPK()

    -- 加载礼包相关
    local giftBagString = cc.UserDefault:getInstance():getStringForKey("BAG_NOTI_UTIL_GIFTBOX_CACHE" .. masterPK, nil)
    if (giftBagString) then
        lastGiftBagArr = AvalonUtil.stringToArr(giftBagString, true)
    end
    giftBoxShowEndTimeStamp = cc.UserDefault:getInstance():getIntegerForKey("BAG_NOTI_UTIL_GIFTBOX_TS" .. masterPK, 0)
    newGiftBagID = cc.UserDefault:getInstance():getIntegerForKey("BAG_NOTI_UTIL_GIFTBOX_ID" .. masterPK, 0)

    -- 加载装备相关
    local equipString = cc.UserDefault:getInstance():getStringForKey("BAG_NOTI_UTIL_EQUIP_CACHE" .. masterPK, nil)
    if (equipString) then
        lastUpgradableEquipTable = AvalonUtil.stringToTable(equipString, true)
    end
    upgradableEquipShowEndTimeStamp = cc.UserDefault:getInstance():getIntegerForKey("BAG_NOTI_UTIL_EQUIP_TS" .. masterPK, 0)
    newUpgradableEquipID = cc.UserDefault:getInstance():getIntegerForKey("BAG_NOTI_UTIL_EQUIP_ID" .. masterPK, 0)

    -- 加载技能相关
    lastSkillPoint = cc.UserDefault:getInstance():getIntegerForKey("BAG_NOTI_UTIL_SKILL_POINT_CACHE" .. masterPK, 0)
    newSkillPointShowEndTimeStamp = cc.UserDefault:getInstance():getIntegerForKey("BAG_NOTI_UTIL_SKILL_POINT_TS" .. masterPK, 0)
end

BagNotificationUtil:loadAllNumbers()
--------------------------------------------
-- 程序逻辑 --


return BagNotificationUtil

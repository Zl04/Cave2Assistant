--[[
    负责物品属性等相关管理
]]

require "app.config.ConfigManager"

require "app.datas.goods.GoodsData"
require "app.datas.goods.EquipmentData"
require "app.datas.goods.EquipmentPetData"
require "app.datas.goods.MaterialData"
require "app.datas.goods.ItemData"
require "app.datas.goods.GemStoneData"
require "app.datas.goods.ShortcutBarData"
require "app.datas.goods.VirtualData"
require "app.datas.goods.StarPrayData"
require "app.datas.goods.RelicData"
require "app.datas.goods.PetStoneData"
require "app.datas.goods.GoodsTreasureData"
require "app.datas.goods.GlyphData"


local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE
local CONST_DEFINITION = PublicDefine.CONST_DEFINITION 
local PACKET_TYPE = PublicDefine.PACKET_TYPE 
local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE

local GOODS_RARE = PublicDefine.GOODS_RARE
local MATERIAL_TYPE = PublicDefine.MATERIAL_TYPE

GoodsDataManager = GoodsDataManager or {}

local DEBUG = false

function GoodsDataManager:init()
    -- 所有角色的道具列表 key:pk  value:table(key:packetType,value:table(key:index,value:goodsData))
    self._allPKMap = {}
    self._allSpriteIDMap = {}
    -- 快捷条数据  ShortcutBarData 对象 该对象不能够直接释放，最多只能够清空
    self._shortcutBarArr = {}
    for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
    local one = Goods.ShortcutBarData:new()
        self._shortcutBarArr[i] = one
    end
    -- 快捷条迷宫数据  ShortcutBarData 对象 该对象不能够直接释放，最多只能够清空
    self._shortcutBarMazeArr = {}
    for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
        local one = Goods.ShortcutBarData:new()
        one:initNetData(i, 0)
        self._shortcutBarMazeArr[i] = one
    end
    -- 本地数据信息, ShortcutBarData 对象 该对象不能够直接释放，最多只能够清空
    self._shortcutBarLocalArr = {}
    for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
        local one = Goods.ShortcutBarData:new()
        one:initNetData(i, 0)
        self._shortcutBarLocalArr[i] = one
    end

    -- 所有道具冷却
    self._itemCooldownArr = {}
    --虚拟道具list
    self._virtualItemList = {}
    -- 处理当前选择背包项
    self._packetSubType = PACKET_SUB_TYPE.PACKET_SUB_TYPE_1

    --限时反斗乐商店道具限购数据
    self._storePurchaseLimitData = {}
end

function GoodsDataManager:clear()
    table.clear(self._allPKMap)
    table.clear(self._allSpriteIDMap)
    table.clear(self._virtualItemList)
    table.clear(self._storePurchaseLimitData)

    -- change by zp 这里不能释放，最多只能把数据清空
    -- table.clear(self._shortcutBarArr)
    for _,shortcutBarData in pairs(self._shortcutBarArr) do
        shortcutBarData:clear()
    end
    for _,shortcutBarData in pairs(self._shortcutBarMazeArr) do 
        shortcutBarData:clear()
    end
    for _,shortcutBarData in pairs(self._shortcutBarLocalArr) do 
        shortcutBarData:clear()
    end
    

    table.clear(self._itemCooldownArr)

    self:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)
end

function GoodsDataManager:switchMasterSpriteID(oldSpriteID,newSpriteID)
    local masterPK = RoleDataManager:getMasterPK()
    -- 清理掉老的数据，避免新的同屏数据来的玩家spriteID和前面主角spriteID一直导致串数据
    if(oldSpriteID ~= newSpriteID and oldSpriteID ~= -1) then
        self._allSpriteIDMap[oldSpriteID] = nil
    end
    self._allSpriteIDMap[newSpriteID] =  self._allPKMap[masterPK]
    --TODO 处理其余数据
    
end

-- 进入下一层清理数据
function GoodsDataManager:nextFloorClear()
    for k,v in pairs(self._allSpriteIDMap) do
        self._allSpriteIDMap[k] = nil
    end

    local masterPK = RoleDataManager:getMasterPK()
    for pk,v in pairs(self._allPKMap) do
        if (masterPK ~= pk) then
            self._allPKMap[pk] = nil
        end
    end
    self._shortcutBarMazeArr = {}
    for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
        local one = Goods.ShortcutBarData:new()
        one:initNetData(i, 0)
        self._shortcutBarMazeArr[i] = one
    end
end

-- 回档（恢复）清理数据
function GoodsDataManager:restoreClear()
    -- TODO 回档（恢复）清理数据

    -- 对于物品，需要清空背包，穿戴装备数据，仓库等不需要删除
    local masterPK = RoleDataManager:getMasterPK()
    -- 清理玩家道具数据
    self:clearGoodsForPacketType(masterPK,PACKET_TYPE.PACKET_BAG, self._packetSubType)
    self:clearGoodsForPacketType(masterPK,PACKET_TYPE.PACKET_EQUIPMENT, self._packetSubType)
    self:clearGoodsForPacketType(masterPK,PACKET_TYPE.PACKET_PET_EQUIPMENT, self._packetSubType)

    -- -- 快捷条数据  ShortcutBarData 对象
    -- self._shortcutBarArr = {}
    -- for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
    --     local one = Goods.ShortcutBarData:new()
    --     self._shortcutBarArr[i] = one
    -- end
    self._shortcutBarMazeArr = {}
    for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
        local one = Goods.ShortcutBarData:new()
        one:initNetData(i, 0)
        self._shortcutBarMazeArr[i] = one
    end
    self._shortcutBarLocalArr = {}
    for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
        local one = Goods.ShortcutBarData:new()
        one:initNetData(i, 0)
        self._shortcutBarLocalArr[i] = one
    end
    

    -- 所有道具冷却
    self._itemCooldownArr = {}

    -- 回档清理数据
    self._virtualItemList = {} 
end

-- 清理非金色的物品
function GoodsDataManager:clearNoGoldGoodsArr()
    local masterPK = RoleDataManager:getMasterPK()
    self:clearNoGoldGoodsForPacketType(masterPK,PACKET_TYPE.PACKET_BAG, self._packetSubType)
    self:clearNoGoldGoodsForPacketType(masterPK,PACKET_TYPE.PACKET_EQUIPMENT, self._packetSubType)
    self:clearNoGoldGoodsForPacketType(masterPK,PACKET_TYPE.PACKET_PET_EQUIPMENT, self._packetSubType)
end

-- 获取保存的物品数据
function GoodsDataManager:getSaveGoodsData()
    return Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GOODS, GameDataManager:getInstance():getSaveUserKey())
end

-- 设置背包类型
function GoodsDataManager:setPacketSubType(packetSubType)
    self._packetSubType = packetSubType
end

-- 根据 PK和spriteID 清理数据
function GoodsDataManager:clearDataForPKANDSpriteID(pk, spriteID)
    for k,v in pairs(self._allSpriteIDMap) do
        if(k == spriteID) then
            self._allSpriteIDMap[k] = nil
        end
    end

    for k,v in pairs(self._allPKMap) do
        if (k == pk) then
            self._allPKMap[pk] = nil
        end
    end
end

-- 刷新物品新标志
function GoodsDataManager:refreshNewFlag()
    -- 刷新相关标志位，这里主要是清理已经不存在了的装备
    local saveGoodsData = self:getSaveGoodsData()
    if(saveGoodsData) then
        saveGoodsData:clearEquipArr()
        local pk = RoleDataManager:getMasterPK()

        self:_refreshNewFlag(saveGoodsData, pk, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        self:_refreshNewFlag(saveGoodsData, pk, PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
    end
end

function GoodsDataManager:_refreshNewFlag(saveGoodsData, pk, goodsType)
    if(saveGoodsData == nil or pk == nil or goodsType == nil) then 
        return 
    end

    local equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_BAG,goodsType, nil)
    if equipmentArr then
        for k,equipment in ipairs(equipmentArr) do
            saveGoodsData:setDataNew(equipment:getEntityID(),goodsType,equipment:getIsNew())
        end
    end

    local equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_EXPEDITION_NORMAL,goodsType, nil)
    if equipmentArr then
        for k,equipment in ipairs(equipmentArr) do
            saveGoodsData:setDataNew(equipment:getEntityID(),goodsType,equipment:getIsNew())
        end
    end

    local equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_EXPEDITION_QUICK,goodsType, nil)
    if equipmentArr then
        for k,equipment in ipairs(equipmentArr) do
            saveGoodsData:setDataNew(equipment:getEntityID(),goodsType,equipment:getIsNew())
        end
    end
end

-- 根据实例ID获取装备对象
function GoodsDataManager:getEquipmentForEntityID(entityID)
    if entityID == nil or entityID == 0 then
        return
    end
    local pk = RoleDataManager:getMasterPK()

    -- 查找背包数据
    local equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT,nil)
    if(equipmentArr) then
        for k,equipment in ipairs(equipmentArr) do
           if(equipment:getEntityID() == entityID) then
                return equipment
           end
        end
    end
    local equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT,nil)
    if(equipmentArr) then
        for k,equipment in ipairs(equipmentArr) do
           if(equipment:getEntityID() == entityID) then
                return equipment
           end
        end
    end

    -- 查找穿戴的物品
    equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT, nil)
    if(equipmentArr) then
        for k,equipment in ipairs(equipmentArr) do
           if(equipment:getEntityID() == entityID) then
                return equipment
           end
        end
    end

    -- 查找宠物穿戴的物品
    equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_PET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT, nil)
    if(equipmentArr) then
        for k,equipment in ipairs(equipmentArr) do
           if(equipment:getEntityID() == entityID) then
                return equipment
           end
        end
    end
    
    -- 查找仓库的物品
    equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT, nil)
    if(equipmentArr) then
        for k,equipment in ipairs(equipmentArr) do
           if(equipment:getEntityID() == entityID) then
                return equipment
           end
        end
    end

    -- 查找仓库的物品
    equipmentArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT, nil)
    if(equipmentArr) then
        for k,equipment in ipairs(equipmentArr) do
           if(equipment:getEntityID() == entityID) then
                return equipment
           end
        end
    end

    return nil
end

-- 根据模板ID获取有限使用的物品
function GoodsDataManager:getUseGoodsDataForTemplateID(templateID, goodsType)
    local pk = RoleDataManager:getMasterPK()
    local goodsArr = self:getGoodsArrForPK(pk, PACKET_TYPE.PACKET_BAG, goodsType, nil)
    if(goodsArr) then
        local useArr = {}
        for _,goodsData in pairs(goodsArr) do
            if(goodsData:getGoodsID() == templateID and goodsData:getNum() > 0) then
                table.insert(useArr, goodsData)
            end
        end

        local foundData = nil
        for _,goodsData in pairs(useArr) do
            foundData = goodsData
            if(goodsData:getIsGolden() == false) then
                return goodsData
            end
        end

        return foundData
    end

    return nil
end

-- 获取物品的状态
function GoodsDataManager:getGoodsNewStatus(ID,goodsType)
    local saveGoodsData = self:getSaveGoodsData()
    if(saveGoodsData) then
        return saveGoodsData:getNewStatus(ID,goodsType)
    end 

    return true
end

-- 刷新是否为新的标志
function GoodsDataManager:refreshIsNew(goodsData)
    if(goodsData) then 
        local goodsType = goodsData:getGoodsType()
        local ID = goodsData:getGoodsID()
        if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
            ID = goodsData:getEntityID()
        end

        local isNew = GoodsDataManager:getGoodsNewStatus(ID,goodsType)
        self:setGoodsDataNew(goodsData,isNew)
    end
end

function GoodsDataManager:setGoodsDataNew(goodsData,isNew)
    if(goodsData == nil) then 
        return 
    end

    local goodsType = goodsData:getGoodsType()
    local ID = goodsData:getGoodsID()
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT 
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY 
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        goodsData:setIsNew(isNew)
        ID = goodsData:getEntityID()
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_GOODSDATA_REFRESH,goodsData:getGoodsID())
    
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then
        goodsData:setIsNew(isNew)
    else
        -- 把所有堆的数据全部给设置一下
        local pk = GameDataManager:getInstance():getMasterPK()
        local packetType = PACKET_TYPE.PACKET_BAG
        local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, nil)
        for k,goodsData in pairs(goodsArr) do
            if goodsData:getGoodsID() == ID then
                goodsData:setIsNew(isNew)

                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_GOODSDATA_REFRESH,goodsData:getGoodsID())
            end
        end

        local pk = GameDataManager:getInstance():getMasterPK()
        local packetType = PACKET_TYPE.PACKET_EXPEDITION_NORMAL
        local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, nil)
        for k,goodsData in pairs(goodsArr) do
            if goodsData:getGoodsID() == ID then
                goodsData:setIsNew(isNew)

                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_GOODSDATA_REFRESH,goodsData:getGoodsID())
            end
        end

        local pk = GameDataManager:getInstance():getMasterPK()
        local packetType = PACKET_TYPE.PACKET_EXPEDITION_QUICK
        local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, nil)
        for k,goodsData in pairs(goodsArr) do
            if goodsData:getGoodsID() == ID then
                goodsData:setIsNew(isNew)

                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_GOODSDATA_REFRESH,goodsData:getGoodsID())
            end
        end
    end

    local saveGoodsData = self:getSaveGoodsData()
    if(saveGoodsData) then
        saveGoodsData:setDataNew(ID,goodsType,isNew)
    end
end

-- 获取快捷条数据
function GoodsDataManager:getShortcutBar()
    -- self:refreshShortcutBar()
    
    return self._shortcutBarArr
end

function GoodsDataManager:getShortcutBarMaze()
    return self._shortcutBarMazeArr
end

function GoodsDataManager:getShortcutBarLocal()
    return self._shortcutBarLocalArr
end

-- 更新快捷栏数据
function GoodsDataManager:updateShortcutBar(index,templateID)
    if(SceneManager:getInstance():isUseLocalShortcutBar()) then 
        self:updateLocalShortcutBar(index,templateID)
    else
        self:updateNormalShortcutBar(index,templateID)
    end
end

-- 更新快捷栏数据
function GoodsDataManager:updateNormalShortcutBar(index,templateID)
    if(not SceneManager:getInstance():isUseLocalShortcutBar()) then 
        local shortcutBarData = self._shortcutBarArr[index]
        if shortcutBarData then 
            shortcutBarData:initNetData(index,templateID)
        end
    end
end

-- 更新快捷栏数据
function GoodsDataManager:updateLocalShortcutBar(index,templateID)
    if(SceneManager:getInstance():isUseLocalShortcutBar()) then 
        local shortcutBarData = self._shortcutBarLocalArr[index]
        if shortcutBarData then 
            shortcutBarData:initNetData(index,templateID)
        end
    end
end

function GoodsDataManager:updateShortcutBarMaze(index,templateID)
    local shortcutBarData = self._shortcutBarMazeArr[index]
    if shortcutBarData then 
        shortcutBarData:initNetData(index,templateID)
    end
end

-- 清理所有技能
function GoodsDataManager:clearSkillShortcutBar()
    for index,shortcutBar in pairs(self._shortcutBarArr) do
        if (shortcutBar:isSkill()) then
            GameManager:shortcutBarDelete(shortcutBar:getIndex())
        end
    end
end

function GoodsDataManager:clearSkillShortcutBarMaze()
    for index,shortcutBar in pairs(self._shortcutBarMazeArr) do
        if (shortcutBar:isSkill()) then
            shortcutBar:initNetData(shortcutBar:getIndex(), 0)
        end
    end
end

function GoodsDataManager:clearSkillShortcutBarLocal()
    for index,shortcutBar in pairs(self._shortcutBarLocalArr) do
        if (shortcutBar:isSkill()) then
            shortcutBar:initNetData(shortcutBar:getIndex(), 0)
        end
    end
end

-- 加入快捷栏
function GoodsDataManager:insertShortcutBar(templateID)
    if(SceneManager:getInstance():isActCave()) then 
        if(SceneManager:getInstance():isUseLocalShortcutBar()) then
            self:_handleInsertShortcutBar(self._shortcutBarLocalArr, templateID)
        end
        return 
    end

    self:_handleInsertShortcutBar(self._shortcutBarArr, templateID)
end

function GoodsDataManager:_handleInsertShortcutBar(shortcutBarArr, templateID)
    if not (shortcutBarArr and templateID) then 
        return
    end
    -- 先判断是否已经有了
    local have = false
    local category = GameDataManager:getInstance():templateIDToCategory(templateID)
    local skillGroupID = nil
    if(category == Category.SKILL) then
        skillGroupID = SkillDataManager:getSkillGroupIDBySKillID(templateID)
    end

    for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
        local shortcutBarData = shortcutBarArr[i]
        if shortcutBarData:isSkill() then
            if(shortcutBarData:getSkillGroupID() == skillGroupID) then
                -- 处理修改技能ID
                local barData = {}
                barData.index = i
                barData.ID = templateID
                if DEBUG then
                    print(string.format("GoodsDataManager:insertShortcutBar  index=%s,ID=%s",barData.index,barData.ID))
                end

                GameManager:shortcutBarAdd(barData)

                have = true
                break
            end
        else
            if (shortcutBarData:getId() == templateID) then
                have = true
                break
            end
        end
    end

    if have == false then
        for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
            local shortcutBarData = shortcutBarArr[i]
            if shortcutBarData:isNull() then 
                -- 发送添加快捷栏指令
                local barData = {}
                barData.index = i
                barData.ID = templateID
                if DEBUG then
                    print(string.format("GoodsDataManager:insertShortcutBar  index=%s,ID=%s",barData.index,barData.ID))
                end

                GameManager:shortcutBarAdd(barData)
                break
            end
        end
    end
end

function GoodsDataManager:insertShortcutBarMaze(templateID)
    -- 先判断是否已经有了
    local have = false
    local category = GameDataManager:getInstance():templateIDToCategory(templateID)
    local skillGroupID = nil
    if(category == Category.SKILL) then
        skillGroupID = SkillDataManager:getSkillGroupIDBySKillID(templateID)
    end

    if have == false then
        for i=1,CONST_DEFINITION.SHORTCUT_BAR_NUM do
            local shortcutBarData = self._shortcutBarMazeArr[i]
            if shortcutBarData:isNull() then 
                shortcutBarData:initNetData(shortcutBarData:getIndex(), templateID)
                break
            end
        end
    end
end

-- 刷新快捷栏数据
function GoodsDataManager:refreshShortcutBar(onleItem)
    for index,shortcutBar in pairs(self._shortcutBarArr) do
        shortcutBar:refresh(onleItem)
    end

    for index,shortcutBar in pairs(self._shortcutBarLocalArr) do
        shortcutBar:refresh(onleItem)
    end

    for index,shortcutBar in pairs(self._shortcutBarMazeArr) do
        shortcutBar:refresh(onleItem)
    end
end

-- 获取道具冷却所有数据信息
function GoodsDataManager:getItemCooldownStatusArr()

    return self._itemCooldownArr
end

-- 根据道具ID 移除道具冷却时间
function GoodsDataManager:removeItemCooldownByGoodsID(goodsID)
    self._itemCooldownArr[goodsID] = nil
end

-- 处理道具冷却
function GoodsDataManager:handleItemCooldownData(data)
    if (not data) then
        return nil
    end

    local itemCooldownData = self._itemCooldownArr[data.goodsID]
    if (not itemCooldownData) then
        itemCooldownData = Data.GoldBagData:create()
        itemCooldownData:init(data.goodsID,data.curDuration)

        self._itemCooldownArr[data.goodsID] = itemCooldownData
    else
        itemCooldownData:init(data)
    end

    return itemCooldownData
end

-- 获取在洞穴收获
function GoodsDataManager:getInCaveReward(pk,goodsType)
    local goldArr = {}

    -- 处理背包
    local bagGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_BAG,goodsType, nil)
    self:_fliterIsInCaveNewGet(goldArr,bagGoodsArr)

    -- 处理穿戴装备
    local equipGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_EQUIPMENT,goodsType, nil)
    self:_fliterIsInCaveNewGet(goldArr,equipGoodsArr)

    -- 处理宠物穿戴装备
    local equipGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_PET_EQUIPMENT,goodsType, nil)
    self:_fliterIsInCaveNewGet(goldArr,equipGoodsArr)

    -- 处理宠物装备宝石背包
    local petGemStoneArr = self:getGoodsArrForPK(pk,PublicDefine.PACKET_TYPE.PACKET_PET_GEMSTONE,goodsType)--self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_PET_GEMSTONE,goodsType, nil)
    self:_fliterIsInCaveNewTreasureGet(goldArr,petGemStoneArr)

    --TODO 对于道具类需要合并堆叠

    -- 排序
    self:handleGoodsSort(goldArr)
    
    return goldArr
end

-- 获取在洞穴回城自动售卖
function GoodsDataManager:getInCaveAutoSell(pk,goodsType)
    local goldArr = {}

    -- 处理背包
    local bagGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_BAG,goodsType, nil)
    self:_fliterIsInCaveNewGetAutoSell(goldArr,bagGoodsArr)

    -- 处理穿戴装备
    local equipGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_EQUIPMENT,goodsType, nil)
    self:_fliterIsInCaveNewGetAutoSell(goldArr,equipGoodsArr)

    -- 处理宠物穿戴装备
    local equipGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_PET_EQUIPMENT,goodsType, nil)
    self:_fliterIsInCaveNewGetAutoSell(goldArr,equipGoodsArr)

    -- 排序
    self:handleGoodsSort(goldArr)
    
    return goldArr
end

-- 获取洞穴要丢掉的东西
function GoodsDataManager:getInCaveDestory(pk,goodsType)
    local noGoldArr = {}

    -- 处理背包
    local bagGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_BAG,goodsType, nil)
    self:_fliterIsInCaveDestory(noGoldArr,bagGoodsArr)

    -- 处理穿戴装备
    local equipGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_EQUIPMENT,goodsType, nil)
    self:_fliterIsInCaveDestory(noGoldArr,equipGoodsArr)

    -- 处理穿戴装备
    local equipGoodsArr = self:getGoodsArrForPK(pk,PACKET_TYPE.PACKET_PET_EQUIPMENT,goodsType, nil)
    self:_fliterIsInCaveDestory(noGoldArr,equipGoodsArr)

    -- 排序
    self:handleGoodsSort(noGoldArr)
    
    return noGoldArr
end

-- 重置所有在洞穴里面新获得的物品标志
function GoodsDataManager:resetAllInCaveNewGetFlag()
    if DEBUG then
        print("GoodsDataManager:resetAllInCaveNewGetFlag")
    end
    local masterPK = RoleDataManager:getMasterPK()

    local goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    local goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_TREASURE, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_PET_GEMSTONE,PublicDefine.GOODS_TYPE.GOODS_PET_STONE, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_PET_STONE, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_STARPRAY,PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_STARPRAY_WEAR,PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    -- 宠物穿戴装备
    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_PET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    -- 处理穿戴物品
    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_ITEM, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_MATERIAL, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_TREASURE, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE, nil)
    self:_setNewGetFlagToFalse(goodsArr)

    goodsArr = self:getGoodsArrForPK(masterPK,PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_GLYPH, nil)
    self:_setNewGetFlagToFalse(goodsArr)
end

-- 过滤在洞穴中获得的物品
function GoodsDataManager:_fliterIsInCaveNewGet(goodsArr,fliterArr)
    if goodsArr ~= nil and fliterArr ~= nil then
        for _,goodsData in pairs(fliterArr) do
            if goodsData:getGoodsRare() >= GOODS_RARE.RARE_GOLDEN_3 and goodsData:getIsInCaveNewGet() == true then
                table.insert(goodsArr,goodsData)
            end
        end
    end
end

-- 过滤在洞穴中获得的宝物
function GoodsDataManager:_fliterIsInCaveNewTreasureGet(goodsArr,fliterArr)
    if goodsArr ~= nil and fliterArr ~= nil then
        for _,goodsData in pairs(fliterArr) do
            if goodsData:getIsInCaveNewGet() == true then
                table.insert(goodsArr,goodsData)
            end
        end
    end
end

-- 过滤在洞穴中获得的会自动销毁的
function GoodsDataManager:_fliterIsInCaveNewGetAutoSell(goodsArr,fliterArr)
    if goodsArr ~= nil and fliterArr ~= nil then
        for _,goodsData in pairs(fliterArr) do
            if goodsData:getGoodsRare() < GOODS_RARE.RARE_GOLDEN_3 and goodsData:getIsInCaveNewGet() == true then
                table.insert(goodsArr,goodsData)
            end
        end
    end
end

-- 过滤会销毁
function GoodsDataManager:_fliterIsInCaveDestory(goodsArr,fliterArr)
    if goodsArr ~= nil and fliterArr ~= nil then
        for _,goodsData in pairs(fliterArr) do
            if goodsData:getIsInCaveNewGet() == true then
                table.insert(goodsArr,goodsData)
            end
        end
    end
end

-- 设置指定列表数据为非洞穴获得标志
function GoodsDataManager:_setNewGetFlagToFalse(goodsArr)
    if goodsArr then
        for _,goodsData in pairs(goodsArr) do
            goodsData:setIsInCaveNewGet(false)
        end
    end
end


-- 获取某个ID的物品数量
function GoodsDataManager:getGoodsDataNum(pk,packetType,goodsID,includeGolden)
    local goodsType = self:getGoodsTypeForGoodsID(goodsID)

    local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, nil)
    local totalNum = 0
    for k,goodsData in pairs(goodsArr) do
        if goodsData:getGoodsID() == goodsID then
            if includeGolden == false then
                if (goodsData:getIsGolden() == false) then
                    totalNum = totalNum + goodsData:getNum()
                end
            else
                totalNum = totalNum + goodsData:getNum()
            end
        end
    end

    return totalNum
end

-- 获取商店某一层所有商品信息
function GoodsDataManager:getInCaveShopAllGoodsForLevel(caveModel, caveDiffculty, level)
    local config = ConfigManager:getInCaveShopConfigForLevel(caveModel, caveDiffculty, level)
    -- 处理解析相关数据
    if(config) then
        local allShopGoodsData = {}
        if GameDataManager:getInstance():isActiveExtertnTalentSkill(PublicDefine.MainTalentType.MainTalentType_Assist) then 
            -- 添加额外数据
            if(config.talentGoodsID and config.talentGoodsNum and #config.talentGoodsID == #config.talentGoodsNum) then 
                for i=1,#config.talentGoodsID,1 do
                    local goodsID = config.talentGoodsID[i]
                    local goodsData = self:createLocalGoodsData(goodsID)
                    local startNo = CAVE_SHOP_NO_START
                    if(goodsData) then 
                        local goodsNo = startNo + i
                        local goodsNum = config.talentGoodsNum[i]
                        local goodsCostType = PublicDefine.GOODS_COST_TYPE.GEM
                        local goodsCost = 0

                        goodsData:initInCaveShop(goodsNo, goodsNum, goodsCostType, goodsCost)
                        goodsData:setIsNew(false)

                        table.insert(allShopGoodsData,goodsData)
                    end 
                end
            end
        end

        for i=1,#config.goodsID,1 do
            local goodsID = config.goodsID[i]
            local goodsData = self:createLocalGoodsData(goodsID)
            if(goodsData) then 
                local goodsNo = config.goodsNo[i]
                local goodsNum = config.goodsNum[i]
                local goodsCostType = config.goodsCostType[i]
                local goodsCost = config.goodsCost[i]

                goodsData:initInCaveShop( goodsNo, goodsNum, goodsCostType, goodsCost)
                goodsData:setIsNew(false)

                table.insert(allShopGoodsData,goodsData)
            end 
        end

        return allShopGoodsData
    end

    return nil
end

-- 创建一个本地物品数据
function GoodsDataManager:createLocalGoodsData(goodsID)
    local goodsType = self:getGoodsTypeForGoodsID(goodsID)
    if(goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
        goodsData = self:createEquipmentForEquipmentID(goodsID)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
        goodsData = self:createItemForItemID(goodsID)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
        goodsData = self:createMaterialForMaterialID(goodsID)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
        goodsData = self:createVirtualData(goodsID, 1)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
        goodsData = self:createGemStoneData(goodsID, 1)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
        goodsData = self:createStarPrayData(goodsID, 1)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        goodsData = self:createRelicData(goodsID, 1)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        goodsData = self:createPetEquipmentData(goodsID)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
        goodsData = self:createPetGemstone(goodsID)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
        goodsData = self:createGoodsTreasure(goodsID)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        goodsData = self:createGlyphData(goodsID)
    else
        printError(string.format("GoodsDataManager:getInCaveShopAllGoodsForLevel  goodsID=%d  goodsType=%d no handler.",goodsID,goodsType))
    end

    return goodsData
end

-- 创建一个本地的装备
function GoodsDataManager:createEquipmentForEquipmentID(goodsID)
    local goodsAttr = ConfigManager:getEquipmentConfigByID(goodsID)
    local goodsData = nil
    if goodsAttr then
        goodsData = Goods.EquipmentData:create(goodsID)
        goodsData:initLocalData(goodsAttr)
    else
       printError(string.format("GoodsDataManager:createEquipmentForEquipmentID goodsID=%d not found config",goodsID))
    end 

    return goodsData
end

-- 创建一个本地的物品
function GoodsDataManager:createItemForItemID(goodsID)
    local goodsAttr = ConfigManager:getPropConfigByID(goodsID)
    if(goodsAttr) then 
        local goodsData = Goods.ItemData:create(goodsID)

        return goodsData
    else 
        return nil
    end
end

-- 创建一个本地的材料
function GoodsDataManager:createMaterialForMaterialID(goodsID)
    local goodsAttr = ConfigManager:getMaterialConfigByID(goodsID)
    local goodsData = nil
    if goodsAttr then
        goodsData = Goods.MaterialData.new(goodsID)
        goodsData:initLocalData(goodsAttr)
        goodsData.goodsID = goodsID
    else
       printError(string.format("GoodsDataManager:createMaterialForMaterialID goodsID=%d not found config",goodsID))
    end 

    return goodsData
end

--出杨建一个虚拟物品数据
function GoodsDataManager:createVirtualData(goodsID,num)
    local goodsData = nil
    local goodsAttr = ConfigManager:getVirtualItemConfigByID(goodsID)
    if(goodsAttr) then 
        goodsData = Goods.VirtualData:create(goodsID,num)
    end

    return goodsData;
end

--创建一个宝石数据
function GoodsDataManager:createGemStoneData(goodsID,num)
    local goodsData = nil
    local goodsAttr = ConfigManager:getGemStoneConfigByID(goodsID)
    if(goodsAttr) then
        goodsData = Goods.GemStoneData:create(goodsID,num)
    end

    return goodsData;
end

--创建一个星痕数据
function GoodsDataManager:createStarPrayData(goodsID)
    local goodsData = nil
    local goodsAttr = ConfigManager:getStarPrayConfigByID(goodsID)
    if(goodsAttr) then
        goodsData = Goods.StarPrayData:create(goodsID)
    end

    return goodsData;
end

--创建一个宠物装备宝石数据
function GoodsDataManager:createPetGemstone(goodsID)
    local goodsData = nil
    local goodsAttr = ConfigManager:getPetGemstoneConfigByID(goodsID)
    if(goodsAttr) then
        goodsData = Goods.PetStoneData:create(goodsID)
    end

    return goodsData;
end

--创建一个宝藏道具数据
function GoodsDataManager:createGoodsTreasure(goodsID)
    local goodsData = nil
    local goodsAttr = ConfigManager:getGoodsTreasureConfigByID(goodsID)
    if(goodsAttr) then
        goodsData = Goods.GoodsTreasureData:create(goodsID)
    end

    return goodsData;
end


--创建一个遗物数据
function GoodsDataManager:createRelicData(goodsID)
    local goodsData = nil
    local goodsAttr = ConfigManager:getRelicConfigByID(goodsID)
    if(goodsAttr) then
        goodsData = Goods.RelicData:create(goodsID)
    end

    return goodsData;
end

-- 创建一个宠物装备
function GoodsDataManager:createPetEquipmentData(goodsID)
    local goodsData = nil
    local goodsAttr = ConfigManager:getPetEquipmentConfigByID(goodsID)
    if(goodsAttr) then
        goodsData = Goods.EquipmentPetData:create(goodsID)
    end

    return goodsData;
end

--创建一个雕文数据
function GoodsDataManager:createGlyphData(goodsID,num)
    local goodsData = nil
    local goodsAttr = ConfigManager:getGlyphByID(goodsID)
    if(goodsAttr) then
        goodsData = Goods.GlyphData:create(goodsID,num)
    end

    return goodsData;
end

-- 排序物品
function GoodsDataManager:sortGoods(pk,packetType,goodsType)
    local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, nil)
    self:handleGoodsSort(goodsArr)
end

-- 对物品排序
function GoodsDataManager:handleGoodsSort(goodsArr)
    if DEBUG then
        local num = 0
        for k,v in pairs(goodsArr) do
            num = num + 1
        end
    end

    table.sort(goodsArr,function(a,b) 
        local flag = self:_judegeGoodsChange(a,b)
        if DEBUG then
            -- print("GoodsDataManager:handleGoodsSort  ",a:getInstanceID(),b:getInstanceID(),flag)
        end
        return flag
    end)

    if DEBUG then
        -- 验证是否ID连续
        local testIndex = 1;
        for k,v in pairs(goodsArr) do
            if k ~= testIndex then
               assert(false, string.format("[ERROR]  handleGoodsSort  index is not continuous k=%d, index=%d",k,testIndex))
            end

            testIndex = testIndex + 1
        end
    end
end

-- 处理创建物品数据
function GoodsDataManager:handleCreateGoodsData(goodsType,goodsID,num,data,statusData)
    local goodsData = self:_createGoodsData(goodsID,goodsType,num,data,statusData)       
    return goodsData
end

-- 处理物品初始化
function GoodsDataManager:handleInitGoodsData(pk, packetType, packetSubType, goodsType, goodsID, num, data, statusData)
    local goodsData = nil
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC 
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        
        goodsData = self:_createGoodsData(goodsID,goodsType,num,data,statusData)
        -- goodsData:setIsInCaveNewGet(isInCaveNewGet)

        self:addEquipmentDataForPK(pk,packetType,goodsData, packetSubType)
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
            goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
            goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE or
            goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
        self:_initItemOrMaterial(pk,packetType,goodsType,goodsID,num,statusData, packetSubType)
    end

    return goodsData
end

-- 处理物品获得
function GoodsDataManager:handleAddGoodsData(pk,packetType, packetSubType,goodsType,goodsID,num,data,statusData)
    local goodsData = nil
    local isUpdate = false
    local isChange = false
    if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT 
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then
        goodsData = self:getEquipmentDataForEntityID(pk,packetType,goodsType,data.entityID)
        
        -- 这里根据装备的特性做优化处理
        if not goodsData then
            if num == 1 then
                goodsData = self:_createGoodsData(goodsID,goodsType,num,data,statusData)
            else
                printError(string.format("GoodsDataManager:handleAddGoodsData  equipmentData Num not equal one num=%d",num))
            end

            self:addEquipmentDataForPK(pk, packetType, goodsData, packetSubType)
            isChange = true
        else
            if num == 1 then
                -- 处理更新
                goodsData:initNetData(data,num,statusData.isGolden)
                isUpdate = true
            else
                 printError(string.format("GoodsDataManager:handleAddGoodsData update equipmentData Num not equal one num=%d",num))
            end
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
            goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
            goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE or 
            goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then

        isChange = self:_addItemOrMaterial(pk,packetType,goodsType,goodsID,num,statusData, packetSubType)
        -- 创建一个物品对象给外界使用
        goodsData = self:_createGoodsData(goodsID,goodsType,num,data,statusData)
    end

    return goodsData,isUpdate,isChange
end

function GoodsDataManager:handleInlayData(data)
    local equipmentData = self:getEquipmentForEntityID(data.equipmentInstanceID)
    if(equipmentData) then 
        equipmentData:resetHoleData(data.holes)
        
        local ProtobufUtil = require "utils.ProtobufUtil"
        if(data.result == ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidResult", "EquipGemstoneInlaidResult_Succeed")) then 
            if(data.optType == ProtobufUtil:enum_id("NPCSystem.EquipGemstoneInlaidType", "EquipGemstoneInlaidType_Punch")) then 
                if ProtobufUtil:checkFieldIsInit(data, "punchNum") then 
                    equipmentData:setPunchNum(data.punchNum)
                end
            end
        end
    end
end

-- 获取虚拟道具列表
function GoodsDataManager:getVirtualGoodsDataList()

    return self._virtualItemList
end

function GoodsDataManager:isHavaTreasureFragment()
    local treasureMapData_C = ConfigManager:getTreasuremapConfigList()
    for k2, v2 in pairs(self._virtualItemList) do 
        for k,v in pairs(treasureMapData_C) do 
            for k1, v1 in pairs (v.fragmentID) do 
                if v1 == k2 then 
                    return true
                end 
            end 
        end
    end
    return false
end

function GoodsDataManager:isHavaNewTreasureFragment()
    local treasureMapData_C = ConfigManager:getTreasuremapConfigList()
    for k2, v2 in pairs(self._virtualItemList) do 
        for k,v in pairs(treasureMapData_C) do 
            for k1, v1 in pairs (v.fragmentID) do 
                if v1 == k2 and (v2:getIsNew()) then 
                    return true
                end 
            end 
        end
    end
    return false
end



-- 获取虚拟道具
function GoodsDataManager:getVirtualGoodsDataByGoodsID(goodsID)
    return self._virtualItemList[goodsID];
end

--初始化虚拟化道具
function GoodsDataManager:handleInitVirtualGoodsData(goodsID,num)
    local goodsData = self:createVirtualData(goodsID, num)
    if(goodsData) then 
        -- 刷新是否新的标志
        GoodsDataManager:refreshIsNew(goodsData)

        self._virtualItemList[goodsID] = goodsData
    end
    
    return goodsData
end


function GoodsDataManager:handleEquipRemoveLevel(entityID)
    local equipmentData = self:getEquipmentForEntityID(entityID)
    if(equipmentData) then 
        equipmentData:setLvRemoveStatus()
    end
end

--改变物品
function GoodsDataManager:handleChangeVirtualGoodsData(goodsID,num)
    --TODO 以后根据不同的类型改变虚拟物品数据

    local goodsData = nil
    local oldNum = 0
    if self._virtualItemList[goodsID] then
        goodsData = self._virtualItemList[goodsID]
        oldNum = self._virtualItemList[goodsID]:getNum()
        self._virtualItemList[goodsID]:setNum(self._virtualItemList[goodsID]:getNum() + num)
    else
        --没有则初始化
        goodsData = self:handleInitVirtualGoodsData(goodsID,num)
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_VIRTUAL_ITEM_CHANGE,goodsData,num,oldNum)
    return goodsData
end

-- 修改物品锁定状态
function GoodsDataManager:handleGoodsLockChange(data)
    -- 处理物品变化处理
    if(data.result == "LockGoodsSuccess") then
        local pk = RoleDataManager:getMasterPK()

        if(data.entityID ~= 0) then
            if(data.packetType == PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT) then 
                local equipmentPetData = MasterDataManager:getEquipmentPetDataorWearEquipmentID(data.entityID)
                if(equipmentPetData) then
                    equipmentPetData:setIsLock(data.isLock)
                end
            else
                -- 处理装备的状态改变
                local goodsType = self:getGoodsTypeForGoodsID(data.templateID)
                local equipmentArr = self:getGoodsArrForPK(pk, data.packetType, goodsType, nil)
                if(equipmentArr) then
                    for _, equipmentData in pairs(equipmentArr) do
                        if(equipmentData:getEntityID() == data.entityID) then
                            print("GoodsDataManager:handleGoodsLockChange equipment", equipmentData:getEntityID())
                            equipmentData:setIsLock(data.isLock)
                            break;
                        end
                    end
                end
            end
        else
            local goodsID = data.templateID
            local isLock = data.isLock

            local goodsType = self:getGoodsTypeForGoodsID(data.templateID)
            local goodsArr = self:getGoodsArrForPK(pk, PACKET_TYPE.PACKET_BAG, goodsType, nil)

            if(goodsArr) then
                for _,goodsData in pairs(goodsArr) do
                    if(goodsData:getGoodsID() == goodsID) then
                        -- print("GoodsDataManager:handleGoodsLockChange prop=", goodsData:getGoodsID())
                        goodsData:setIsLock(isLock)
                    end
                end
            end

            local goodsWarehouseArr = self:getGoodsArrForPK(pk, PACKET_TYPE.PACKET_WAREHOUSE, goodsType, nil)
            if(goodsWarehouseArr) then
                for _,goodsData in pairs(goodsWarehouseArr) do
                    if(goodsData:getGoodsID() == goodsID) then
                        -- print("GoodsDataManager:handleGoodsLockChange prop=", goodsData:getGoodsID())
                        goodsData:setIsLock(isLock)
                    end
                end
            end
        end

        -- 发送状态改变
        local statusChangeData = {}
        statusChangeData.packetType = data.packetType
        statusChangeData.entityID = data.entityID
        statusChangeData.templateID = data.templateID
        statusChangeData.isLock = data.isLock
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, statusChangeData)
    elseif (data.result == "LockGoodsError") then
        -- TODO 锁定物品错误

    elseif (data.result == "LockGoodsIsNotExist") then
        -- TODO 物品不存在

    elseif (data.result == "LockGoodsNotChange") then
        -- TODO 锁定状态未改变

    end
end

function GoodsDataManager:addEquipmentDataForPK(pk,packetType,goodsData, packetSubType)    
    local packArr = self:getPackArrForPK(pk,packetType)
    -- 这里对于仓库做特殊处理
    if(packetType == PACKET_TYPE.PACKET_WAREHOUSE) then 
        -- add by zp CO-9857
        if(pk == RoleDataManager:getMasterPK() and goodsData.seed and goodsData.seed <= 0) then 
            if (device.platform == "ios" or device.platform == "android") then
                print(debug.traceback())
                buglyReportLuaException("error add equipmentment to master equipment", "masterPK="..tostring(RoleDataManager:getMasterPK()).."seed="..tostring(goodsData.seed))
            end
        end

        local goodsType = goodsData:getGoodsType()
        local ID = goodsData:getEntityID()

        local saveGoodsData = self:getSaveGoodsData()
        if(saveGoodsData) then
            saveGoodsData:setDataNew(ID, goodsType, false)
        end
        goodsData:setIsNew(false)
    end
    goodsData:setBagType(packetType)
    self:_addEquipmentData(packArr,goodsData)
end

function GoodsDataManager:addEquipmentDataForSpriteID(spriteID,packetType,goodsData)    
    local packArr = self:getPackArrForSpriteID(spriteID,packetType)
    goodsData:setBagType(packetType)
    self:_addEquipmentData(packArr,goodsData)
end

-- 清理物品数据
function GoodsDataManager:clearGoodsForPacketType(pk,packetType, packetSubType)
     local packetArr = self:getPackArrForPK(pk,packetType, packetSubType)
     for k,v in pairs(packetArr) do
        packetArr[k] = nil
     end
end

-- 清理颜色值小于金色的物品
function GoodsDataManager:clearNoGoldGoodsForPacketType(pk,packetType, packetSubType)
    local packetArr = self:getPackArrForPK(pk,packetType, packetSubType)
    for k,v in pairs(packetArr) do
        local removeKeyArr = {}
        local goodsArr = v
        for i = #goodsArr, 1, -1 do
            local goodsData = goodsArr[i]
            if goodsData and goodsData:getGoodsRare() < PublicDefine.GOODS_RARE.RARE_GOLDEN_3 then
                table.remove(goodsArr,i)
            end
        end
    end
end

-- 删除某个武器
function GoodsDataManager:deleteEquipment(pk,packetType,goodsType,entityID)

    return self:_removeEquipmentDataForPK(pk,packetType,goodsType,entityID)
end

-- 添加穿戴装备
function GoodsDataManager:addEquipEquipment(spriteID,goodsData)
    local goodsArr = self:getGoodsArrForSpriteID(spriteID, PACKET_TYPE.PACKET_EQUIPMENT, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT, nil)
    if(goodsArr) then
        -- 踢出重复的
        for k, equipmentData in pairs(goodsArr) do
            if equipmentData:getWearPosition() == goodsData:getWearPosition() then
                table.remove(goodsArr,k)
                break
            end
        end

        table.insert(goodsArr, goodsData)
    end
end

-- 移除某个武器
function GoodsDataManager:removeEquipEquipmentForIndex(spriteID,packetType,index)
    local goodsArr = self:getGoodsArrForSpriteID(spriteID,packetType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT, nil)
    if goodsArr then
        for k,equipmentData in pairs(goodsArr) do
            if equipmentData:getWearPosition() == index then
                table.remove(goodsArr,k)
                break
            end
        end
    end
end

-- 删除道具和材料
function GoodsDataManager:deleteMaterialOrItem(pk,packetType,goodsType,goodsID,isGolden,num)
    --print("GoodsDataManager:deleteMaterialOrItem")
    local statusData = {}
    statusData.isGolden = isGolden

    return self:_addItemOrMaterial(pk,packetType,goodsType,goodsID,-num,statusData)
end

function GoodsDataManager:getEquipmentDataForEntityID(pk,packetType,goodsType,entityID)
    local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, nil)

    for k,v in pairs(goodsArr) do
        if v:getEntityID() == entityID then
            return v
        end
    end

    return nil
end


--获取物品
function GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden(pk,packetType,goodsType,goodsID,isGolden)
    assert(type(isGolden) == "boolean", "GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden isGolden: is must be boolean.")
    local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, nil)
    for k,goodsData in pairs(goodsArr) do 
        if goodsData:getGoodsID() == goodsID and goodsData:getIsGolden() == isGolden then
            return goodsData
        end
    end

    return nil
end


--获得物品,没有则创建一个模板的数据
function GoodsDataManager:getGoodsData(packetType,goodsID,isGolden,entityID)
    local goodsType = self:getGoodsTypeForGoodsID(goodsID)
    local goodsData = nil
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        or goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        goodsData = self:getEquipmentDataForEntityID(RoleDataManager:getMasterPK(),packetType,goodsType,entityID)
    else
        goodsData = self:getGoodsDataForGoodsIDAndIsGolden(RoleDataManager:getMasterPK(),packetType,goodsType,goodsID,isGolden)
    end

    if goodsData == nil then
        goodsData = self:createLocalGoodsData(goodsID)
    end

    return goodsData
end

function GoodsDataManager:getGoodsArrForPK(pk,packetType,goodsType, packetSubType)
    local packArr = self:getPackArrForPK(pk, packetType, packetSubType)

    local goodsArr = packArr[goodsType]
    if goodsArr == nil then
        goodsArr = {}
        packArr[goodsType] = goodsArr
    end

    return goodsArr
end

function GoodsDataManager:getHaveGoodsForPK(pk, packetType)
    local packArr = self:getPackArrForPK(pk, packetType)
    if(packArr) then 
        for k,bag in pairs(packArr) do 
            if(bag and #bag > 0) then
                return true
            end
        end
    end
    
    return false
end

function GoodsDataManager:getGoodsArrForSpriteID(spriteID, packetType, goodsType, packetSubType)
    local packArr = self:getPackArrForSpriteID(spriteID, packetType, packetSubType)
    local goodsArr = packArr[goodsType]
    if goodsArr == nil then
        goodsArr = {}
        packArr[goodsType] = goodsArr
    end

    return goodsArr
end

function GoodsDataManager:getPackArrForPK(pk, packetType, packetSubType)
    local userArr = self._allPKMap[pk]
    if userArr == nil then
        userArr = {}
        self._allPKMap[pk] = userArr
    end
    
    local packArr = userArr[packetType]
    if packArr == nil then
        packArr = {}
        userArr[packetType] = packArr
    end

    -- 这里只有背包才会出现该问题
    if(packetType == PACKET_TYPE.PACKET_BAG) then
        if(packetSubType == nil or packetSubType == 0) then
            packetSubType = self._packetSubType
        end

        if(packArr[packetSubType] == nil) then
            packArr[packetSubType] = {}
        end
        return packArr[packetSubType]
    end

    return packArr
end

function GoodsDataManager:getPackArrForSpriteID(spriteID, packetType, packetSubType)
    local userArr = self._allSpriteIDMap[spriteID]
    if userArr == nil then
        userArr = {}
        self._allSpriteIDMap[spriteID] = userArr
    end
    
    local packArr = userArr[packetType]
    if packArr == nil then
        packArr = {}
        userArr[packetType] = packArr
    end

    -- 这里只有背包才会出现该问题
    if(packetType == PACKET_TYPE.PACKET_BAG) then
        if(packetSubType == nil or packetSubType == 0) then
            packetSubType = self._packetSubType
        end

        if(packArr[packetSubType] == nil) then
            packArr[packetSubType] = {}
        end

        return packArr[packetSubType]
    end

    return packArr
end

function GoodsDataManager:getGoodsTypeForGoodsID(goodsID)
    local goodsType =  PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    local preNum = math.modf((goodsID)/1000000)
    if preNum == 21 then
        goodsType =  PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    elseif preNum == 20 then
        goodsType =  PublicDefine.GOODS_TYPE.GOODS_ITEM
    elseif preNum == 22 then
        goodsType =  PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    elseif preNum == 23 then
        goodsType =  PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM
    elseif preNum == 24 then
        goodsType =  PublicDefine.GOODS_TYPE.GOODS_GEM_STONE
    elseif preNum == 25 then
        goodsType = PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
    elseif preNum == 27 then
        goodsType = PublicDefine.GOODS_TYPE.GOODS_RELIC
    elseif preNum == 28 then
        goodsType = PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
    elseif preNum == 29 then
        goodsType = PublicDefine.GOODS_TYPE.GOODS_PET_STONE
    elseif preNum == 50 then
        goodsType = PublicDefine.GOODS_TYPE.GOODS_TREASURE
    elseif preNum == 52 then
        goodsType = PublicDefine.GOODS_TYPE.GOODS_GLYPH
    elseif preNum == 53 then
        goodsType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    else
        print("goodsID=", goodsID)
        printError("GoodsDataManager:getGoodsTypeForGoodsID  no handle new goodsType.")
    end

    return goodsType
end


function GoodsDataManager:getGlyphByEntityID(entityID)
    local master = RoleDataManager:getMaster()
    local glyphArr = self:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_GLYPH,PublicDefine.GOODS_TYPE.GOODS_GLYPH)
    if(glyphArr) then
        for k,glyphData in ipairs(glyphArr) do
           if(glyphData:getEntityID() == entityID) then
                return glyphData
           end
        end
    end
    return nil
end

function GoodsDataManager:getStarPrayByEntityID(entityID)
    local master = RoleDataManager:getMaster()
    local starPrayArr = self:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_STARPRAY_WEAR,PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY)
    if(starPrayArr) then
        for k,starPrayData in ipairs(starPrayArr) do
           if(starPrayData:getEntityID() == entityID) then
                return starPrayData
           end
        end
    end
    return nil
end




----------------------------------------------私有方法----------------------------------------------

-- 创建一个物品对象
function GoodsDataManager:_createGoodsData(goodsID,goodsType,num,data,statusData)
    local goodsData = nil

    if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
        local goodsConfig = ConfigManager:getEquipmentConfigByID(goodsID)
        if(goodsConfig) then
            goodsData = Goods.EquipmentData:create(goodsID)
            goodsData:initNetData(data,num,statusData.isGolden,statusData.isLock,statusData.index)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
        local goodsAttr = ConfigManager:getPropConfigByID(goodsID)
        if(goodsAttr) then 
            goodsData = Goods.ItemData:create(goodsID)
            goodsData:initNetData(num,statusData.isGolden,statusData.isLock)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then
        local goodsConfig = ConfigManager:getMaterialConfigByID(goodsID)
        if(goodsConfig) then 
            goodsData = Goods.MaterialData:create(goodsID)
            goodsData:initNetData(num,statusData.isGolden,statusData.isLock)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then
        local goodsConfig = ConfigManager:getGoodsTreasureConfigByID(goodsID)
        if(goodsConfig) then 
            print("  caocaocoa  ")
            print(debug.traceback())
            goodsData = Goods.GoodsTreasureData:create(goodsID)
            goodsData:initNetData(num,statusData.isGolden,statusData.isLock)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
        local goodsConfig = ConfigManager:getGemStoneConfigByID(goodsID)
        if(goodsConfig) then 
            goodsData = Goods.GemStoneData:create(goodsID)
            goodsData:initNetData(num,statusData.isGolden,statusData.isLock)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then
        local goodsConfig = ConfigManager:getStarPrayConfigByID(goodsID)
        if(goodsConfig) then 
            goodsData = Goods.StarPrayData:create(goodsID)
            goodsData:initNetData(data,num,statusData.isGolden,statusData.isLock,statusData.index)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
        local goodsConfig = ConfigManager:getRelicConfigByID(goodsID)
        if(goodsConfig) then
            goodsData = Goods.RelicData:create(goodsID)
            goodsData:initNetData(data,num,statusData.isGolden,statusData.isLock,statusData.index)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        local goodsConfig = ConfigManager:getPetEquipmentConfigByID(goodsID)
        if(goodsConfig) then
            goodsData = Goods.EquipmentPetData:create(goodsID)
            goodsData:initNetData(data,num,statusData.isGolden,statusData.isLock,statusData.index)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then
        local goodsConfig = ConfigManager:getPetGemstoneConfigByID(goodsID)
        if(goodsConfig) then
            goodsData = Goods.PetStoneData:create(goodsID)
            goodsData:initNetData(data,num,statusData.isGolden,statusData.isLock,statusData.index)
        end
    elseif (goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then
        local goodsConfig = ConfigManager:getGlyphByID(goodsID)
        if(goodsConfig) then
            goodsData = Goods.GlyphData:create(goodsID)
            print("goodsData:initNetData--->: ", num)
            goodsData:initNetData(data,num,statusData.isGolden,statusData.isLock)
        end
    else
        print("goodsType=", goodsType)
        printError("GoodsDataManager:_createGoodsData  no handle create new goodsType.")
    end

    -- 设置是否为在洞穴新获得
    if(goodsData and statusData.isInCaveNewGet ) then
        goodsData:setIsInCaveNewGet(statusData.isInCaveNewGet)
    end

    return goodsData
end



function GoodsDataManager:_addEquipmentData(packetArr,goodsData)
    local goodsType = goodsData:getType()
    local goodsArr = packetArr[goodsType]
    if goodsArr == nil then
        goodsArr = {}
        packetArr[goodsType] = goodsArr
    end

    --  设置是否新状态
    if goodsData:getIsNew() == true then
        goodsData:setIsNew(self:getGoodsNewStatus(goodsData:getEntityID(),goodsType))
    end

    -- TODO 过滤重复实例ID的数据
    for k,v in ipairs(goodsArr) do
        if (v:getEntityID() == goodsData:getEntityID()) then
            return 
        end
    end

    table.insert(goodsArr,goodsData)
end

function GoodsDataManager:_initItemOrMaterial(pk,packetType,goodsType,goodsID,totalNum,statusData, packetSubType)
    if DEBUG then
        print(" GoodsDataManager:_initItemOrMaterial  pk,packetType,goodsType,goodsID,isGolden,isLock,totalNum=",pk,packetType,goodsType,goodsID,statusData.isGolden,statusData.isLock,totalNum)
    end

    local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, packetSubType)
    local isNew = self:getGoodsNewStatus(goodsID,goodsType)

    local isGolden = statusData.isGolden
    -- 删除老数据
    for i = #goodsArr, 1, -1 do
        local goodsData = goodsArr[i]
         if goodsData:getGoodsID() == goodsID  then
            if goodsData:getIsGolden() == isGolden then
                table.remove(goodsArr,i)
            end
        end
    end

    self:_addItemOrMaterial(pk,packetType,goodsType,goodsID,totalNum,statusData, packetSubType)
end

function GoodsDataManager:_addItemOrMaterial(pk,packetType,goodsType,goodsID,addNum,statusData, packetSubType)
    if DEBUG then
        print(" GoodsDataManager:_addItemOrMaterial  pk,packetType,goodsType,goodsID,isGolden,addNum=",pk,packetType,goodsType,goodsID,statusData.isGolden,addNum)
    end

    local isGolden = statusData.isGolden

    local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, packetSubType)
    local isNew = self:getGoodsNewStatus(goodsID,goodsType)

    if(packetType == PACKET_TYPE.PACKET_WAREHOUSE) then 
        isNew = false
    end

    local isInCaveNewGet = statusData.isInCaveNewGet
    if(isInCaveNewGet == nil) then
        isInCaveNewGet = false
    end

    local isLock = statusData.isLock
    if(isLock == nil) then
        isLock = false
    end
    if(isLock == false) then
        if(packetType ~= PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL and 
            packetType ~= PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then 
            isLock = self:getItemOrMaterialLockStatus(pk, goodsID, goodsType)
        end 
    end

    local index = 1
    local haveArr = {}
    local haveKeyArr = {}
    local haveNum = 0
    for k,goodsData in pairs(goodsArr) do 
        if goodsData:getGoodsID() == goodsID  then
            goodsData:setIsNew(isNew)

            if goodsData:getIsGolden() == isGolden then
                haveArr[index] = goodsData
                haveKeyArr[index] = k
                index = index + 1
                haveNum = haveNum + goodsData:getNum()

                if goodsData:getIsInCaveNewGet() == true then
                    isInCaveNewGet = true
                elseif packetType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE then
                    -- CO-17610
                    goodsData:setIsInCaveNewGet(false)
                    isInCaveNewGet = false
                end
            end
        end
    end

    local endTotalNum = haveNum + addNum

    local isChange = false
    local maxNumOfStacks = ConfigManager:getStackNumForTemplateID(goodsID)

    if DEBUG then
        print(" GoodsDataManager:_addItemOrMaterial  maxNumOfStacks=",maxNumOfStacks,endTotalNum)
    end

    if endTotalNum <0 then
        endTotalNum = 0
        isChange = true
    else
        -- 判断是否有修改
        local have,haveYu = math.modf(haveNum / maxNumOfStacks)
        local haveEnd,haveEndYu = math.modf(endTotalNum / maxNumOfStacks)
        if have ~= haveEnd or (haveYu ~= 0 or haveEndYu ~= 0) then
            isChange = true
        end
    end

    local nowNum = endTotalNum
    local index = 1

    -- 处理分堆处理
    while(nowNum >0) do
        local useNum = nowNum
        if useNum > maxNumOfStacks then
            useNum = maxNumOfStacks
        end

        if haveArr[index] ~= nil then
            haveArr[index]:setNum(useNum)
            haveArr[index]:setIsInCaveNewGet(isInCaveNewGet)
            haveArr[index]:setIsLock(isLock)
            if DEBUG then
                print(" GoodsDataManager:_addItemOrMaterial  update =",index,useNum)
            end
        else
            local goodsData = self:_createGoodsData(goodsID,goodsType,useNum,nil,statusData)
            if(goodsData) then
                goodsData:setIsNew(isNew)
                goodsData:setIsInCaveNewGet(isInCaveNewGet)
                goodsData:setIsLock(isLock)
                table.insert(goodsArr,goodsData)
                if DEBUG then
                    print(" GoodsDataManager:_addItemOrMaterial  create new =",index,useNum)
                end
                goodsData:setBagType(packetType)
            end
        end
        
        nowNum = nowNum - useNum
        index = index + 1
    end

    -- 处理多余得数据
    if nowNum <=0 then
        -- TODO 考虑修改为通过查找对象删除数据，那样要安全很多
        for i = #haveKeyArr,index,-1 do
            local key = haveKeyArr[i]
            table.remove(goodsArr,key)
            -- goodsArr[key] = nil
            if DEBUG then
                print(" GoodsDataManager:_addItemOrMaterial  set nil =",i,key)
            end
        end
    end

    return isChange
end

function GoodsDataManager:getItemOrMaterialLockStatus(pk, goodsID, goodsType)
    local goodsArr = self:getGoodsArrForPK(pk, PACKET_TYPE.PACKET_BAG, goodsType, nil)
    for k,goodsData in pairs(goodsArr) do 
        if goodsData:getGoodsID() == goodsID  then
            if(goodsData:getIsLock()) then
                return true
            end
        end
    end
    
    local warehouseArr = self:getGoodsArrForPK(pk, PACKET_TYPE.PACKET_WAREHOUSE, goodsType, nil)
    for k,goodsData in pairs(warehouseArr) do 
        if goodsData:getGoodsID() == goodsID  then
            if(goodsData:getIsLock()) then
                return true
            end
        end
    end

    return false
end

function GoodsDataManager:_removeEquipmentDataForPK(pk,packetType,goodsType,entityID)
    if DEBUG then
        print("GoodsDataManager:_removeEquipmentDataForPK  ",pk,packetType,goodsType,entityID)
    end
    local goodsArr = self:getGoodsArrForPK(pk,packetType,goodsType, nil)

    return self:_removeEquipment(goodsArr,entityID)
end

function GoodsDataManager:_removeEquipmentDataForSpriteID(spriteID,packetType,goodsType,entityID)
    if DEBUG then
        print("GoodsDataManager:_removeEquipmentDataForSpriteID  ",spriteID,packetType,goodsType,entityID)
    end
    local goodsArr = self:getGoodsArrForSpriteID(pk,packetType,goodsType, nil)

    return self:_removeEquipment(goodsArr,entityID)
end


function GoodsDataManager:_removeEquipment(goodsArr,entityID)
    for k,goodsData in pairs(goodsArr) do
        if (goodsData:getEntityID() == entityID) then
            -- goodsArr[k] = nil
            table.remove(goodsArr, k)
            return goodsData
        end
    end

    return nil
end 

--[[
    判断是否交换
]]
function GoodsDataManager:_judegeGoodsChange(a,b)
    --  print("GoodsDataManager:handleGoodsSort getType ",a:getGoodsID(),b:getGoodsID(),a:getType(),b:getType())
    if (a:getType() == b:getType()) then
        if DEBUG then
            print("GoodsDataManager:handleGoodsSort getGoodsRare ",a:getInstanceID(),b:getInstanceID(),a:getGoodsID(),b:getGoodsID(),a:getGoodsRare(),b:getGoodsRare())
        end
        if a:getGoodsRare() ~= b:getGoodsRare() then
            if a:getGoodsRare() > b:getGoodsRare() then
                if DEBUG then
                    print("GoodsDataManager:handleGoodsSort getGoodsRare true=",a:getInstanceID(),b:getInstanceID(),a:getGoodsID(),b:getGoodsID(),a:getGoodsRare(),b:getGoodsRare())
                end
                return true
            end

            return false
        end

        if (a:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            and b:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
            or (
                a:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
                and b:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
            ) then
            local aEquipType = a:getEquipmentType()
            local bEquipType = b:getEquipmentType()

            if (aEquipType ~= bEquipType) then
                -- 判定部位
                return self:_judegeEquipmentType(aEquipType,bEquipType)
            end

            -- -- 价值等级——降序  add by zp  co-2595 优化去掉分数排序
            -- if a:getCombatScore() ~= b:getCombatScore() then
            --     if a:getCombatScore() > b:getCombatScore() then
            --         if DEBUG then
            --             print("GoodsDataManager:handleGoodsSort getCombatScore ",a:getCombatScore(),b:getCombatScore())
            --         end
            --         return true
            --     end

            --     return false
            -- end
        end

        -- 处理宝石的排序需求
        if (a:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE and b:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
            if (a:getStoneLV() ~= b:getStoneLV()) then
                if (a:getStoneLV() > b:getStoneLV()) then
                    return true
                else
                    return false 
                end
            end
        end

        if(a:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
            and b:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)then 
            if(a:getGoodsStar() < b:getGoodsStar()) then 
                return false
            elseif(a:getGoodsStar() > b:getGoodsStar()) then 
                return true
            end
        end

        -- ID 升序
        if (a:getGoodsID() ~= b:getGoodsID()) then
            if a:getGoodsID() < b:getGoodsID() then
                if DEBUG then
                    print("GoodsDataManager:handleGoodsSort  getGoodsID ",a:getGoodsID(),b:getGoodsID())
                end
                return true
            end

            return false
        end

        -- 为了处理装备之间穿戴等级被修改导致的逻辑修改
        if(a:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT 
            and b:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)then 
            if(a:getWearLV() < b:getWearLV()) then 
                return true
            elseif(a:getWearLV() > b:getWearLV()) then 
                return false
            end
        end

        -- 
        if (a:getInstanceID()<b:getInstanceID()) then

            return true
        end
    else
        if a:getType() < b:getType() then
            return true
        end
    end

    return false
end

function GoodsDataManager:_judegeEquipmentType(aEquipType,bEquipType)
    -- 双手
    if (aEquipType == EQUIPMENT_TYPE.TwoHand) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.TwoHand) then
        return false
    end

    -- 单手
    if (aEquipType == EQUIPMENT_TYPE.OneHand) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.OneHand) then
        return false
    end

    -- 副手
    if (aEquipType == EQUIPMENT_TYPE.OffHand) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.OffHand) then
        return false
    end

    -- 头部
    if (aEquipType == EQUIPMENT_TYPE.Helmet) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.Helmet) then
        return false
    end

    -- 肩部
    if (aEquipType == EQUIPMENT_TYPE.Shoulders) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.Shoulders) then
        return false
    end

    -- 胸部
    if (aEquipType == EQUIPMENT_TYPE.Chest) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.Chest) then
        return false
    end
    -- 手部
    if (aEquipType == EQUIPMENT_TYPE.Gloves) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.Gloves) then
        return false
    end

    -- 脚部
    if (aEquipType == EQUIPMENT_TYPE.Boots) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.Boots) then
        return false
    end

    -- 项链
    if (aEquipType == EQUIPMENT_TYPE.Amulet) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.Amulet) then
        return false
    end

    -- 戒指
    if (aEquipType == EQUIPMENT_TYPE.Ring) then
        return true
    end
    if (bEquipType == EQUIPMENT_TYPE.Ring) then
        return false
    end
    
    return false
end

function GoodsDataManager:updateStorePurchaseLimitData(limitData)
    if limitData then
        for k,v in pairs(limitData) do
            self._storePurchaseLimitData[v.goodsIndex] = v
        end
    end
end

function GoodsDataManager:getStorePurchaseLimitData()
    return self._storePurchaseLimitData
end

--默认初始化
GoodsDataManager:init()
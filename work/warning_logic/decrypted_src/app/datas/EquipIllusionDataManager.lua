--[[
    幻化管理器
]]
------------------------------------------------------
require "app.config.ConfigManager"
require "app.datas.equipIllusion.EquipIllusionData"
require "app.datas.FunctionUnlockManager"
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local DEBUG = false

EquipIllusionDataManager = EquipIllusionDataManager or {}

-- 初始化
function EquipIllusionDataManager:init()
    self._possesingEquipIllusions = {}
    self._newIllusions = {}
    self._delayNoticeTable = {}
    self._isDelayNoticeOn = false
    self._illusionIDNewTable = {}

    -- 获取new信息
    local gameUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    if(gameUserData) then
        self._illusionIDNewTable = gameUserData:getIllusionNewTable()
    end

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_EQUIP_ILLUSION_WEAR_RESULT, self, function(self, isSucc, data)
        if (isSucc) then
            local equipArr = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
            local MachineManager = require("app.game.MachineManager")
            local machine = MachineManager:getInstance():getMachine()
            local machineModel = machine:getModel()
            if (not machineModel) then return end

            local masterModel = machineModel:getMaster()
            if (not masterModel) then return end

            if (machine and masterModel and equipArr) then 
                machine:pushRefreshWearEquipmentCommand(masterModel, equipArr)
            end
        end
    end)
end

-- 网络初始化, {{illusionID = 23100001, isBought = false}}
function EquipIllusionDataManager:initNet(illusionDataArray, isReload)
    -- printInfo("EquipIllusionDataManager:initNet, 服务器推送拥有幻化列表", illusionDataArray, isReload)

    -- 精神正常检查
    if (isReload) then self._possesingEquipIllusions = {} end
    if (illusionDataArray == nil) then
        printWarn("EquipIllusionDataManager:initNet, titleIdArray为空")
        return 
    elseif (type(illusionDataArray) ~= "table") then 
        printWarn("EquipIllusionDataManager:initNet, titleIdArray返回值类型不正确, 内容为: ", illusionDataArray)
        return 
    end

    -- 填充幻化数据
    for i, v in ipairs(illusionDataArray) do
        local equipIllusionData = self:getEquipIllusionDataFromID(v.illusionID, v.isBought)
        if (equipIllusionData) then
            self._possesingEquipIllusions[v.illusionID] = equipIllusionData
        end
    end
end

-- 清空幻化管理器
function EquipIllusionDataManager:clear()
    self._possesingEquipIllusions = {}
end

-- 回档（恢复）清理数据
function EquipIllusionDataManager:restoreClear()
    self:clear()
end

-- 从ID获取幻化数据
function EquipIllusionDataManager:getEquipIllusionDataFromID(id, isBought)
    local equipIllusionData = Data.EquipIllusionData:create(id, isBought)
    if(DEBUG and equipIllusionData) then 
        printInfo("EquipIllusionDataManager:getEquipIllusionDataFromID, 正在返回幻化信息", id, equipIllusionData:getIllusionName(), equipIllusionData:getIllusionDescription())
    end
    return equipIllusionData
end

-- 获取拥有的幻化列表
function EquipIllusionDataManager:getPossessingIllusionArray()
    return self._possesingEquipIllusions
end

-- 获取拥有的幻化数量
function EquipIllusionDataManager:getPossessingIllusionNumber()
    local count = 0
    for k,v in pairs(self.possessingEquipIllusions) do
        count = count + 1
    end
    return count
end

-- 设置幻化ID是否为新
function EquipIllusionDataManager:setIllusionIsNew(illusionID, isNew)
    if (not illusionID) then return end
    self._illusionIDNewTable[tostring(illusionID)] = isNew or nil
    self:saveNewStatusDataToFile()
end

-- 获取幻化ID是否为新
function EquipIllusionDataManager:getIllusionIsNew(illusionID)
    if (self:getPossessingIllusionById(illusionID)) then
        return self._illusionIDNewTable[tostring(illusionID)] or false
    end
    return false
end

-- 获取是否有新的幻化ID
function EquipIllusionDataManager:getIsThereAnyNewIllusion()
    for k,v in pairs(self._newIllusions) do
        if (v) then return true end
    end
    return false
end

-- 从ID获取已有幻化数据
function EquipIllusionDataManager:getPossessingIllusionById(id)
    return self._possesingEquipIllusions[id]
end

-- 获取展示信息
function EquipIllusionDataManager:getInfoForDisplayByEquipmentType(equipType, specialItemsOnly)
    local allIllusions = ConfigManager:getAllEquipIllusions()
    local groupData = {}
    local groupDataByID = {}

    -- 遍历幻化数据加入
    -- 过滤装备投放版本
    local SdkBox = require("utils.sdkbox.SdkBox")
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    -- print("getInfoForDisplayByEquipmentType", versionTarget, PublicDefine.VERSION_TARGET.VERSION_TARGET_CN)
    for k,v in pairs(allIllusions) do
        if (k ~= "size") then
            if (versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_DEV or v.cn == nil or v.global == nil or
                (v.cn == 1 and (versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE)) or 
                (v.global == 1 and versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL)) 
            then
                -- 过滤装备类型
                if (equipType == nil or equipType == 0 or  AvalonUtil.getEquipmentTypeFromID(v.position) == equipType) then 
                    -- 如果没有组, 创建组
                    local groupId = v.combinationID
                    local groupEntry = (groupId and groupId ~= 0) and groupDataByID[groupId] or nil

                    -- 添加展现数据
                    local itemEntry = self:getItemEntryForDisplayByID(k)
                    if (not specialItemsOnly or specialItemsOnly and itemEntry.itemIsSpecial) then
                        if (not groupEntry) then
                            local groupNameID = ConfigManager:getEquipIllusionGroupNameIDFromID(groupId)
                            groupEntry = {
                                groupName = groupNameID and LanguageManager:getInstance():getLocalString(groupNameID) or "",
                                groupId = groupId, 
                                itemList = {}
                            }
                            table.insert(groupData, groupEntry)
                            groupDataByID[groupEntry.groupId] = groupEntry
                        end
                        table.insert(groupEntry.itemList, itemEntry)
                    end
                end
            end
        end
    end

    -- 装备顺序
    local GameDataManager = require("app.game.GameDataManager")
    local wearingWeaponType = GameDataManager:getInstance():getWearWeaponType()
    local function mapEquipOrder(equipId)
        local equipType = AvalonUtil.getEquipmentTypeFromID(equipId)
        if (equipType == PublicDefine.EQUIPMENT_TYPE.Weapon) then
            local weaponConfig = ConfigManager:getEquipmentConfigByID(equipId)
            local weaponType = tonumber(weaponConfig.remarksField[1])
            if (weaponType == wearingWeaponType) then
                return 1
            elseif (weaponType == 1) then
                return 2
            elseif (weaponType == 2) then
                return 3
            elseif (weaponType == 3) then
                return 4
            else
                return 4
            end
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Chest) then return 5
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Helmet) then return 6 
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Shoulders) then return 7 
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Gloves) then return 8
        elseif (equipType == PublicDefine.EQUIPMENT_TYPE.Boots) then return 9
        else return 10 end
    end

    -- 子项排序
    local isGroupBought = {}
    local isGroupUnlocked = {}
    for i,groupEntry in ipairs(groupData) do
        if (#groupEntry.itemList > 1) then
            table.sort(groupEntry.itemList, function(a,b)
                -- 首先判断购买状态
                local isBoughtA = a.itemIsBought
                local isBoughtB = b.itemIsBought
                if (isBoughtA and not isBoughtB) then 
                    isGroupBought[a.itemGroupID] = true
                    return true
                end
                if (not isBoughtA and isBoughtB) then 
                    isGroupBought[b.itemGroupID] = true
                    return false
                end
                if (isBoughtA and isBoughtB) then
                    isGroupBought[a.itemGroupID] = true
                    isGroupBought[b.itemGroupID] = true
                end

                -- 然后判断解锁状态
                if (a.itemIsUnlocked and not b.itemIsUnlocked) then 
                    isGroupUnlocked[a.itemGroupID] = true
                    return true
                end
                if (not a.itemIsUnlocked and b.itemIsUnlocked) then
                    isGroupUnlocked[b.itemGroupID] = true
                    return false 
                end
                if (a.itemIsUnlocked and b.itemIsUnlocked) then
                    isGroupUnlocked[a.itemGroupID] = true
                    isGroupUnlocked[b.itemGroupID] = true
                end

                -- 如果都一样再判断部件顺序
                orderA = mapEquipOrder(a.itemEquipID)
                orderB = mapEquipOrder(b.itemEquipID)
                return orderA < orderB
            end)
        elseif (#groupEntry.itemList == 1) then
            -- local itemEntry = groupEntry.itemList[1]
            -- isGroupBought[itemEntry.itemGroupID] = itemEntry.itemIsBought
            -- isGroupUnlocked[itemEntry.itemGroupID] = itemEntry.itemIsUnlocked
        end
    end

    -- 组排序
    table.sort(groupData, function(a, b)
        local isBoughtA = isGroupBought[a.groupId]
        local isBoughtB = isGroupBought[b.groupId]
        local isUnlockedA = isGroupUnlocked[a.groupId]
        local isUnlockedB = isGroupUnlocked[b.groupId]
        local isSingleItemA = #a.itemList == 1
        local isSingleItemB = #b.itemList == 1

        if (isSingleItemA) then
            local itemEntry = a.itemList[1]
            isBoughtA = itemEntry.itemIsBought
            isUnlockedA = itemEntry.itemIsUnlocked
        end
        if (isSingleItemB) then
            local itemEntry = b.itemList[1]
            isBoughtB = itemEntry.itemIsBought
            isUnlockedB = itemEntry.itemIsUnlocked
        end

        -- 首先判断购买状态
        if (isBoughtA and not isBoughtB) then 
            if ((isSingleItemA and isSingleItemB) or (not isSingleItemA and not isSingleItemB)) then
                return true 
            end
        end
        if (not isBoughtA and isBoughtB) then 
            if ((isSingleItemA and isSingleItemB) or (not isSingleItemA and not isSingleItemB)) then
                return false
            end
        end

        -- 然后判断解锁状态
        if (isUnlockedA and not isUnlockedB) then return true end
        if (not isUnlockedA and isUnlockedB) then return false end

        -- 默认顺序判断
        if (isSingleItemA and isSingleItemB) then return mapEquipOrder(a.itemList[1].itemEquipID) < mapEquipOrder(b.itemList[1].itemEquipID) end
        if (not isSingleItemB and isSingleItemA) then return false end
        if (not isSingleItemA and isSingleItemB) then return true end
        return a.groupId < b.groupId
    end)

    return groupData
end

-- 从ID获取显示数据
function EquipIllusionDataManager:getItemEntryForDisplayByID(id)
    local illusionConfig = ConfigManager:getEquipIllusionByID(id)
    if (not illusionConfig) then return end

    local possessingIllusionData = self:getPossessingIllusionById(id)
    local itemEntry = {
        itemName = LanguageManager:getInstance():getLocalString(illusionConfig.name),
        itemPrice = illusionConfig.money,
        itemIsUnlocked = possessingIllusionData and true or false,
        itemIsBought = possessingIllusionData and (possessingIllusionData:isBought() or illusionConfig.money == 0) or false,
        itemIsChecked = false,
        itemIllusionID = illusionConfig.ID,
        itemEquipID = illusionConfig.position,
        itemIsSpecial = illusionConfig.specialappearance ~= 0 and illusionConfig.specialappearance ~= nil,
        itemGroupID = illusionConfig.combinationID
    }
    return itemEntry
end

-- 从装备Data获取幻化表现用的装备Data
function EquipIllusionDataManager:getIllusionEquipDataFromEquipData(equipData)
    local illusionID = equipData:getIllusionID()
    local illusionEquipData = equipData
    if (illusionID ~= 0 and illusionID ~= nil) then
        local illusionData = EquipIllusionDataManager:getItemEntryForDisplayByID(illusionID)
        if (not illusionData) then return illusionEquipData end
        illusionEquipData = GoodsDataManager:createEquipmentForEquipmentID(illusionData.itemEquipID)
    end 
    return illusionEquipData
end

-- 获得新外观, 展示提示; 如果在延迟显示模式, 加入延迟显示队列
function EquipIllusionDataManager:showNewEquipIllusionNotice(illusionID)
    if (not illusionID) then return end

    -- 如果延迟显示模式为开, 推进延迟显示表并返回
    if (self._isDelayNoticeOn) then 
        self._delayNoticeTable[illusionID] = true 
        return
    end

    -- 如果不为延迟显示模式, 展示提示
    local displayData = self:getItemEntryForDisplayByID(illusionID)
    if (displayData) then
        local formatString = LanguageManager:getInstance():getLocalString(1111661)
        local contentString = string.format(formatString, displayData.itemName)
        UI.ScrollBar:createByText(contentString)
        Game.ChatManager:getInstance():sendSystemMsg(contentString, ChatMessageType.SYSTEM_MESSAGE)
    end
end

-- 设置延迟显示模式开关
function EquipIllusionDataManager:setDelayNoticeOn(b)
    self._isDelayNoticeOn = b
    if (self._isDelayNoticeOn) then return end

    -- 如果延迟显示模式为关闭, 展示所有延迟显示的新外观
    for k,v in pairs(self._delayNoticeTable) do
        self:showNewEquipIllusionNotice(k)
        self._delayNoticeTable[k] = nil
    end
end

-- 保存新物品数据
function EquipIllusionDataManager:saveNewStatusDataToFile()
    local gameUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    if(gameUserData) then
        gameUserData:setIllusionNewTable(self._illusionIDNewTable)
        Avalon.UserDataManager:saveDataToFile(gameUserData:getType())
    end
end

--默认初始化
EquipIllusionDataManager:init()
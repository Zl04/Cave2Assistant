--[[
    锻造数据管理器
]]
------------------------------------------------------
require "app.config.ConfigManager"
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local DEBUG = false

EquipForgeDataManager = EquipForgeDataManager or {}

local sortedList = {}
local forgeUnlockList = {}

-- 初始化
function EquipForgeDataManager:init()
end

-- 网络初始化
function EquipForgeDataManager:initNet(dataArray)
    for _, v in ipairs(dataArray) do
        forgeUnlockList[v] = true
    end
end

-- 清空锻造管理器
function EquipForgeDataManager:clear()
    sortedList = {}
    forgeUnlockList = {}
end

function EquipForgeDataManager:clearSortedList()
    sortedList = {}
end

function EquipForgeDataManager:updateForgeUnlockList(id)
    forgeUnlockList[id] = true
end

function EquipForgeDataManager:getForgeUnlockList()
    return forgeUnlockList
end

--[[
    * 右侧列表中的排列顺序按照以下逻辑排列：
    1. 材料是否齐全
    2. 品质从高到低
    3. 等级从高到低
    4. 部位
]]
function EquipForgeDataManager:getEquipForgeListByType(type)
    if not type then
        return {}
    end

    if sortedList[type] then
        return sortedList[type]
    end

    local retList = {}
    local restList = {}
    local list = Config.Manager:getEquipForgeListByType(type);
    for k, v in ipairs(list) do
        -- 材料是否齐全
        local matEnough = true
        for m, matCfg in ipairs(v.material) do
            local matID = matCfg.id
            local matNum = matCfg.num
            -- 锻造天赋对材料需求量有打折效果，需要进行判断
            local percent = MasterDataManager:getEffValueByEffType(PublicDefine.ATTR_TYPE.ForgeDiscountRate)
            if percent > 0 then
                matNum = math.ceil(matNum * (RATIO_NUMBER - percent) / RATIO_NUMBER)
            end
            local goodsNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(matID)
            if goodsNum < matNum then
                matEnough = false
                break
            end
        end

        if matEnough then
            retList[#retList+1] = v
        else
            restList[#restList+1] = v
        end
    end

    local sortFunc = function(a, b)
        local equipCfg1 = Config.Manager:getEquipmentConfigByID(a.id)
        local equipCfg2 = Config.Manager:getEquipmentConfigByID(b.id)
        if equipCfg1.goodsRare == equipCfg2.goodsRare then
            if equipCfg1.equipRequireLV == equipCfg2.equipRequireLV then
                local type1 = math.modf(equipCfg1.ID/10000%10)
                local type2 = math.modf(equipCfg2.ID/10000%10)
                local finalType1 = type1 + 4
                local finalType2 = type2 + 4
                if type1 == PublicDefine.EQUIPMENT_TYPE.Weapon then
                    local subType1 = tonumber(equipCfg1.remarksField[1])
                    if subType1 == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                        finalType1 = 4
                    elseif subType1 == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                        finalType1 = 2
                    elseif subType1 == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                        finalType1 = 3
                    end

                    if type2 == PublicDefine.EQUIPMENT_TYPE.Weapon then
                        local subType2 = tonumber(equipCfg2.remarksField[1])
                        if subType2 == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                            finalType2 = 4
                        elseif subType2 == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                            finalType2 = 2
                        elseif subType2 == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                            finalType2 = 3
                        end
                    end
                elseif type2 == PublicDefine.EQUIPMENT_TYPE.Weapon then
                    local subType2 = tonumber(equipCfg2.remarksField[1])
                    if subType2 == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                        finalType2 = 4
                    elseif subType2 == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                        finalType2 = 2
                    elseif subType2 == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                        finalType2 = 3
                    end
                end

                if finalType1 == finalType2 then
                    return a.id > b.id
                end
                return finalType1 < finalType2
            else
                return equipCfg1.equipRequireLV > equipCfg2.equipRequireLV
            end
        else
            return equipCfg1.goodsRare > equipCfg2.goodsRare
        end
    end

    table.sort(retList, sortFunc)
    table.sort(restList, sortFunc)

    for k, v in ipairs(restList) do
        retList[#retList+1] = v
    end

    sortedList[type] = retList

    return retList
end

function EquipForgeDataManager:getEquipForgeConfigByID(id)
    return Config.Manager:getEquipForgeConfigByID(id);
end

-- 设置锻造ID是否为新
function EquipForgeDataManager:setForgeEquipIsNew(configID)
    if not configID then
        return 
    end

    cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.ForgeEquipNew .. configID .. GameDataManager:getInstance():getMasterPK(), false)
end

-- 获取锻造ID是否为新
function EquipForgeDataManager:getForgeEquipIsNew(configID)
    if Config.Manager:getEquipForgeConfigByID(tonumber(configID)) then
        return cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.ForgeEquipNew .. configID .. GameDataManager:getInstance():getMasterPK(), true)
    end
    return true
end

-- 给主城上的装备锻造按钮显示New标识使用
function EquipForgeDataManager:hasNewEquipForge()
    local equipList = self:getEquipForgeListByType(1);
    local GameDataManager = require("app.game.GameDataManager")
    local ret = false

    for k, v in ipairs(equipList) do
        if GameDataManager:getEquipForgeGroupID() >= v.unlockPoint then
            ret = EquipForgeDataManager:getForgeEquipIsNew(v.configID)
            if ret then
                break
            end
        end
    end

    return ret
end

--默认初始化
EquipForgeDataManager:init()

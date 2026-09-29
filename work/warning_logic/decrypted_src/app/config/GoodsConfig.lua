--[[
    物品配置
]]--

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local ConfigGoods = {}

Config.ConfigGoods = ConfigGoods

local cacheAllEquipmentConfig = nil
local cacheAllItemsConfig = nil
local cacheAllMaterialConfig = nil
local cacheAllGemStoneConfig = nil
local cacheAllEquipmentRandAttrStrengthenConfig = nil
local cacheAllEquipmentSetConfig = nil
local cacheAllChooseBagConfig = nil
local cacheAllDigSlotConfig = nil
local cacheAllPetGemstoneConfig = nil
local cacheAllRoughConfig = nil
local shopInCaveConfigList = {}

--虚拟道具
local cacheAllVirtualItemConfig = nil

function ConfigGoods:getEquipment(equipmentId)
    -- 处理装备的配置文件获取
    local equipmentAttr = self:getAllEquipmentConfig()
    local equipment = equipmentAttr[equipmentId]
    if(equipment) then
        -- 处理多语言以及相关数据转换
        equipment.name = LanguageManager:getInstance():getLocalString(equipment.name)
        equipment.description = LanguageManager:getInstance():getLocalString(equipment.description)
        equipment.randomName = LanguageManager:getInstance():getLocalString(equipment.randomName)
    else
        printError(string.format("not found equipmentID=%d config",equipmentId))
    end

    return equipment
end

function ConfigGoods:getProp(propID)
    -- 获取道具的配置文件
    local propsAttr = self:getAllItemsConfig()
    local prop = propsAttr[propID]

    if(prop) then
        -- 处理多语言以及相关数据转换
        prop.name = LanguageManager:getInstance():getLocalString(prop.name)
        prop.description = LanguageManager:getInstance():getLocalString(prop.description)
    end

    return prop
end

function  ConfigGoods:getMaterial(materialId)
    -- 获取材料的配置文件
    local itemsAttr = self:getAllMaterialConfig()
    local preNum = math.modf((materialId)/1000000)
    if preNum == 53 then
        itemsAttr = self:getAllPrimoGemConfig()
    end

    local material = itemsAttr[materialId]

    if(material) then
        -- 处理多语言以及相关数据转换
        material.name = LanguageManager:getInstance():getLocalString(material.name)
        material.description = LanguageManager:getInstance():getLocalString(material.description)
    end

    return material
end

function  ConfigGoods:getGemStone(gemStoneID)
    -- 获取材料的配置文件
    local gemStoneAttr = self:getAllGemStoneConfig()
    local gemStone = gemStoneAttr[gemStoneID]

    if(gemStone) then
        -- 处理多语言以及相关数据转换
        gemStone.name = LanguageManager:getInstance():getLocalString(gemStone.name)
    end

    return gemStone
end

function  ConfigGoods:getPetGemStone(gemStoneID)
    -- 获取材料的配置文件
    local gemStoneAttr = self:getAllPetGemstoneConfig()
    local gemStone = gemStoneAttr[gemStoneID]

    if(gemStone) then
        -- 处理多语言以及相关数据转换
        gemStone.name = LanguageManager:getInstance():getLocalString(gemStone.name)
    end

    return gemStone
end

function  ConfigGoods:getPrimoGemStone(gemStoneID)
    -- 获取材料的配置文件
    local gemStoneAttr = self:getAllPrimoGemConfig()
    local gemStone = gemStoneAttr[gemStoneID]

    if(gemStone) then
        -- 处理多语言以及相关数据转换
        gemStone.name = LanguageManager:getInstance():getLocalString(gemStone.name)
    end

    return gemStone
end

function  ConfigGoods:getStarPray(starPrayId)
    require "app.config.ConfigManager"
    local starpray = ConfigManager:getStarPrayConfigByID(starPrayId)
    return starpray
end

--根据 大秘境楼层ID   获取需要开启该楼层的秘境钥匙ID
function ConfigGoods:getDungeonKeyByLoftLv(loftLv)
    local itemsAttr = self:getAllMaterialConfig()
    for k, v in pairs(itemsAttr) do
        if type(v) == "table" then
            local materialType = math.modf(v.ID / 10000)
            if materialType == 2206 and loftLv == tonumber(v.value1) then
                return v.ID
            end
        end
    end
end

-- 根据模板ID获取堆叠数量
function ConfigGoods:getStackNumForTemplateID(templateID)
    local propConfig = self:getProp(templateID)
    if(propConfig) then
        return propConfig.stackNum
    end

    local materialConfig = self:getMaterial(templateID)
    if(materialConfig) then
        return materialConfig.stackNum
    end

    local gemStoneConfig = self:getGemStone(templateID)
    if(gemStoneConfig) then
        return gemStoneConfig.stackNum
    end

    local gemStoneConfig = self:getGemStone(templateID)
    if(gemStoneConfig) then
        return 1
    end

    local starPrayConfig = self:getStarPray(templateID)
    if(starPrayConfig) then
        return 1
    end

    local treasurConfig = ConfigManager:getGoodsTreasureConfigByID(templateID)
    if(treasurConfig) then
        return treasurConfig.stackNum
    end
    -- 出现没有找到的情况
    if(templateID) then
        assert(false,string.format("ConfigGoods:getStackNum templateID=%d", templateID))
    else
        assert(false,string.format("ConfigGoods:getStackNum templateID is nil."))
    end
    return 1
end

function ConfigGoods:getVirtualItem(id)
    -- 获取材料的配置文件
    local itemsAttr = self:getAllVirtualIteamConfig()
    local virtualItem = itemsAttr[id]
    if(virtualItem) then
        -- 处理多语言以及相关数据转换
        virtualItem.name = LanguageManager:getInstance():getLocalString(virtualItem.name)
        virtualItem.description = LanguageManager:getInstance():getLocalString(virtualItem.description)
        if virtualItem.effecDescription == 0 then
            virtualItem.effecDescription = ""
        else
            virtualItem.effecDescription = LanguageManager:getInstance():getLocalString(virtualItem.effecDescription)
        end
    else 
        printError("ConfigGoods:getVirtualItem no found id=", id)
    end

    return virtualItem
end

function ConfigGoods:getEquipmentRandAttrStrengthen(attrType)
    local allStrengthen = self:getAllEquipmentRandAttrStrengthenConfig()
    
    return allStrengthen[attrType]
end

function ConfigGoods:getEquipmentSet(equipSetMark)
    local equipmentSetAttr = self:getAllEquipmentSetConfig()
    local equipmentSet = equipmentSetAttr[equipSetMark]

    -- 处理多语言以及相关数据转换
    if(equipmentSet) then
        equipmentSet.equipSetName = LanguageManager:getInstance():getLocalString(equipmentSet.equipSetName)
    else 
        assert(false, string.format("ConfigGoods:getEquipmentSet no found equipSetMark=%s config.", tostring(equipSetMark)))
    end

    return equipmentSet
end

-- 根据洞穴商店层级获取洞穴商店配置
function ConfigGoods:getInCaveShopConfigForLevel(caveModel, caveDiffculty, level)
    local allConfig = self:getInCaveShopConfig(caveModel, caveDiffculty)
    if(allConfig) then
        local config = allConfig[level]
        if(config) then
            return config
        else
            local CAVE_MODE = PublicDefine.CAVE_MODE
            if(caveModel == CAVE_MODE.MODE_DUNGEON) then
                level = allConfig.size;
                local config = allConfig[level]
                if(config) then
                    return config
                end
            end
        end
    end

    assert(false,string.format("ConfigGoods:getInCaveShopConfigForLevel level=%d no found config.",level))

    return nil
end

function ConfigGoods:getDigSlotForRare(rare)
    local allConfig = self:getAllDigSlot()
    if(allConfig) then 
        local config = allConfig[rare]
        if(config) then 
            return config
        end

        printError("ConfigGoods:getDigSlotForRare not found rare config.", rare)
    end

    return nil 
end

function ConfigGoods:getAllEquipmentConfig()
    if cacheAllEquipmentConfig == nil then
        cacheAllEquipmentConfig = require("profiles/dataProfile/ProfileEquipmentsAttrClient")
    end

    return cacheAllEquipmentConfig
end

function ConfigGoods:getAllItemsConfig()
    if cacheAllItemsConfig == nil then
        cacheAllItemsConfig = require("profiles/commonProfile/ProfileItems")
    end

    return cacheAllItemsConfig
end

function ConfigGoods:getAllMaterialConfig()
    if cacheAllMaterialConfig == nil then
        cacheAllMaterialConfig = require("profiles/commonProfile/ProfileMaterials")
    end

    return cacheAllMaterialConfig
end

function ConfigGoods:getAllGemStoneConfig()
    if cacheAllGemStoneConfig == nil then
        cacheAllGemStoneConfig = require("profiles/commonProfile/ProfileGemstone")
    end

    return cacheAllGemStoneConfig
end

function ConfigGoods:getAllPetGemstoneConfig()
    if cacheAllPetGemstoneConfig == nil then
        cacheAllPetGemstoneConfig = require("profiles/commonProfile/ProfilePetGemstone")
    end

    return cacheAllPetGemstoneConfig
end

function ConfigGoods:getAllPrimoGemConfig()
    if cacheAllRoughConfig == nil then
        cacheAllRoughConfig = require("profiles/commonProfile/ProfileStoneUpgrade")
    end

    return cacheAllRoughConfig
end

function ConfigGoods:getAllVirtualIteamConfig()
    if cacheAllVirtualItemConfig == nil then
        cacheAllVirtualItemConfig = require("profiles/commonProfile/ProfileVirtualGoods")
    end

    return cacheAllVirtualItemConfig
end

function ConfigGoods:getAllEquipmentRandAttrStrengthenConfig()
    if cacheAllEquipmentRandAttrStrengthenConfig == nil then
        cacheAllEquipmentRandAttrStrengthenConfig = require("profiles/commonProfile/ProfileRandAttributeStrengthen")
    end

    return cacheAllEquipmentRandAttrStrengthenConfig
end

function ConfigGoods:getAllEquipmentSetConfig()
    if cacheAllEquipmentSetConfig == nil then
        cacheAllEquipmentSetConfig = require("profiles/commonProfile/ProfileEquipSet")
    end

    return cacheAllEquipmentSetConfig
end

function ConfigGoods:getInCaveShopConfig(caveModel, caveDiffculty)
    local shopInCave = string.format("profiles/commonProfile/ProfileShopInCave_%d_%d", caveModel, caveDiffculty)
    table.insert(shopInCaveConfigList,shopInCave)
    return require(shopInCave)
end
function ConfigGoods:getAllChooseBag()
    if cacheAllChooseBagConfig == nil then
        cacheAllChooseBagConfig = require("profiles/commonProfile/ProfileChooseBag")
    end
    return cacheAllChooseBagConfig
end

function ConfigGoods:getAllDigSlot()
    if(cacheAllDigSlotConfig == nil) then 
        cacheAllDigSlotConfig = require("profiles/commonProfile/ProfileDigSlot")
    end

    return cacheAllDigSlotConfig
end

function ConfigGoods:getAllIdentification()
    if(identificationConfig == nil) then 
        identificationConfig = require("profiles/commonProfile/ProfileIdentification")
    end

    return identificationConfig
end


function ConfigGoods:getProfileIdentification(rare)
    local allConfig = self:getAllIdentification()
    if(allConfig) then 
        local config = allConfig[rare]
        if(config) then 
            return config
        end

        printError("ConfigGoods:getDigSlotForRare not found rare config.", rare)
    end

    return nil 
end

function ConfigGoods:getChooseBagById(id)
    local allCfg = self:getAllChooseBag()
    return allCfg[id]
end

 -- 清理
function ConfigGoods:clear()
    print("---------------ConfigGoods:clear()----------------------")
    cacheAllEquipmentConfig = nil
    cacheAllItemsConfig = nil
    cacheAllMaterialConfig = nil
    cacheAllGemStoneConfig = nil
    cacheAllPetGemstoneConfig = nil
    cacheAllEquipmentRandAttrStrengthenConfig = nil
    cacheAllEquipmentSetConfig = nil
    cacheAllRoughConfig = nil
    reload_script_file("profiles/dataProfile/ProfileEquipmentsAttrClient")
    reload_script_file("profiles/commonProfile/ProfileItems")
    reload_script_file("profiles/commonProfile/ProfileMaterials")
    reload_script_file("profiles/commonProfile/ProfileVirtualGoods")
    reload_script_file("profiles/commonProfile/ProfileRandAttributeStrengthen")
    reload_script_file("profiles/commonProfile/ProfileEquipSet")
    reload_script_file("profiles/commonProfile/ProfileGemstone")
    reload_script_file("profiles/commonProfile/ProfileDigSlot")
    reload_script_file("profiles/commonProfile/ProfileStoneUpgrade")
    for k,v in pairs(shopInCaveConfigList) do
        reload_script_file(v)
    end
    shopInCaveConfigList = {}
end


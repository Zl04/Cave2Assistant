
--[[
    材料属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local MaterialData = class("MaterialData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"

local MATERIAL_TYPE = PublicDefine.MATERIAL_TYPE

Goods = Goods or {}

Goods.MaterialData = MaterialData

local GOODS_RARE = PublicDefine.GOODS_RARE

function MaterialData:ctor(goodsID)
    MaterialData.super.ctor(self,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)

    self.goodsID = goodsID
    self.num = 0
    self.isGolden = false
    self:conbinationLocalData()
    self:_refreshMaterialType()

    self._makeGoodsData = nil

    if(self:getMaterialType() == MATERIAL_TYPE.MaterialEquipmentScroll) then 
        -- 解析相关的数据
        local enchantingAttributeTypeList = string.split(self.value1,",")
        if(enchantingAttributeTypeList and enchantingAttributeTypeList[1]) then
            self._makeGoodsData = GoodsDataManager:createLocalGoodsData(tonumber(enchantingAttributeTypeList[1]))
        end
    end
end 

-- 获取物品名字
function MaterialData:getName()
    if(self:getMaterialType() == MATERIAL_TYPE.MaterialEquipmentScroll) then
        if(self._makeGoodsData) then
            return self.name..self._makeGoodsData:getName()
        end
    end 

    return self.name
end

-- return {"设计图", "蜂刺"}
function MaterialData:getNameList()
    if(self:getMaterialType() == MATERIAL_TYPE.MaterialEquipmentScroll) then
        if(self._makeGoodsData) then
            return {self.name, self._makeGoodsData:getName()}
        end
    end 

    return {}
end

-- 获取要制造的物品
function MaterialData:getMakeGoodsData()
    return self._makeGoodsData
end

function MaterialData:getIconName()
    if self.icon == nil or self.icon == "" then
        if(self.materialType == MATERIAL_TYPE.MaterialEquipmentScroll) then
            -- TODO 卷轴材料默认的ICON资源
            self.icon = "icon_202001.png"
        -- elseif(self.materialType == MATERIAL_TYPE.MaterialDungeonKey) then
        --     self.icon = "icon_206001.png"
        else
            self.icon = self:_getIconName()
        end
    end

    return self.icon
end

function MaterialData:getNum()
    if self.num == nil then
        return 0
    end
    return self.num;
end

-- 获取材料类型
function MaterialData:getMaterialType()
    return self.materialType
end

-- 获取是否为附魔材料
function MaterialData:getIsEnchanting()
    if self.materialType == MATERIAL_TYPE.MaterialEnchanting then
        return true
    end

    return false
end

-- 获取堆叠数量
function MaterialData:getStackNum()
    return self.stackNum
end

-- 获取大秘境要是对应的楼层
function MaterialData:getDungeonLevel()
    return tonumber(self.value1)
end

function MaterialData:initLocalData(data)
    self:setLocalConfigData(data)
end

function MaterialData:initNetData(num,isGolden,isLock)
    local oldGoodsID = self.goodsID
    self.goodsRare = nil
    self.num = num
    self.isGolden = isGolden
    self.isLock = isLock

    -- 处理装备的初始化处理
    if oldGoodsID ~= self.goodsID then
        self:conbinationLocalData()
    end

    if self.isGolden == true and self.goodsRare < GOODS_RARE.RARE_GOLDEN_3 then
        self.goodsRare = GOODS_RARE.RARE_GOLDEN_3
    end
end

function MaterialData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getMaterialConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("MaterialData:conbinationLocalData  goodsID=%d no found local data ",self.goodsID))
        end
    end
end

-- 获取详细描述信息
function MaterialData:getDetailDescription()
    -- enchantingAttributeType = {21,22},  enchantingAttributeLV = {2,1},  enchantingSuccessProb = {10,5},  enchantingAttributeDescription = {1101001,1101002},
    local desArr = {}
    if(self:getIsEnchanting()) then
        local enchantingAttributeTypeList = string.split(self.value1,",")
        local enchantingAttributeLVList = string.split(self.value2,",")
        local enchantingSuccessProbList = string.split(self.value3,",")
            
        for i=1,#enchantingAttributeTypeList do 
            if(self.enchantingAttributeDescription and self.enchantingAttributeDescription[i]) then
                local str = LanguageManager:getInstance():getLocalString(self.enchantingAttributeDescription[i])
                local level, reinLv = RoleDataManager:getUIShowLvByItemData(tonumber(enchantingAttributeLVList[i]))
                local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or "LV"..level
                table.insert(desArr,string.format("%s %s %d%%",str,showLv,enchantingSuccessProbList[i]))
            end
        end
    else
        if(self.enchantingAttributeDescription and self.enchantingAttributeDescription[1]) then
            local str = LanguageManager:getInstance():getLocalString(self.enchantingAttributeDescription[1])
            table.insert(desArr,str)
        else
        	table.insert(desArr, "")
            print(string.format("ID=%d MaterialData enchantingAttributeDescription not found ID", self.goodsID))
        end

        if self.materialType == MATERIAL_TYPE.MaterialPrimogem then
            -- 原石附加属性
            local goodsConfig = Config.ConfigGoods:getPrimoGemStone(self.goodsID)
            local attrList = string.split(goodsConfig.attributeValue, ";")
            local attrType = tonumber(attrList[1])
            local attrBaseValue = tonumber(attrList[2])
            
            local languageStr = ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[attrType])
            local desc = string.format("%s %d", languageStr, attrBaseValue)
    
            table.insert(desArr,desc)
        end
    end

    return desArr
end


function MaterialData:_refreshMaterialType()
    -- 计算材料类型
    if self.goodsID then
        self.materialType = self:calculateMaterialType(self.goodsID)
        return
    end

    assert(false, "MaterialData:_refreshMaterialType self.goodsID is nil.")
end

function MaterialData:calculateMaterialType(goodsID)
    local equipType = math.modf(goodsID / 10000)
    if equipType == 2201 then
        return MATERIAL_TYPE.MaterialEnchanting
    elseif equipType == 2202 then
        return MATERIAL_TYPE.MaterialEquipmentScroll
    elseif equipType == 2203 then
        return MATERIAL_TYPE.MaterialForgetSkill
    elseif equipType == 2204 then
        return MATERIAL_TYPE.MaterialEquipment
    elseif equipType == 2205 then
        return MATERIAL_TYPE.MaterialLottery
    elseif equipType == 2206 then
        return MATERIAL_TYPE.MaterialDungeonKey
    elseif equipType == 2207 then
        return MATERIAL_TYPE.MaterialOther
    elseif equipType == 2208 then
        return MATERIAL_TYPE.MaterialPetExp
    elseif equipType == 2209 then
        return MATERIAL_TYPE.MaterialPetWash
    elseif equipType == 2210 then
        return MATERIAL_TYPE.MaterialPetTalent
    elseif equipType == 2211 then   
        return MATERIAL_TYPE.MaterialPetSkill
    elseif equipType == 2212 then  
        return MATERIAL_TYPE.MaterialPetRevive
    elseif equipType == 2213 then  
        return MATERIAL_TYPE.MaterialBarter
    elseif equipType >= 5300 and equipType < 5400 then  
        return MATERIAL_TYPE.MaterialPrimogem
    else
        assert(false, string.format("MaterialData:_refreshMaterialType  error goodsID=%d",self.goodsID))
    end
end
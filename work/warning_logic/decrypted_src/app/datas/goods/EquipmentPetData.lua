
--[[
    装备属性定义
]]

require("app.datas.goods.GoodsData")

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

local GoodsData = Goods.GoodsData

local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY
local ATTR_TYPE = PublicDefine.ATTR_TYPE
local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE
local VALUE_TYPE = PublicDefine.VALUE_TYPE
local WEAPON_TYPE = PublicDefine.WEAPON_TYPE
local GOODS_RARE = PublicDefine.GOODS_RARE

local atkSpdType = ATTR_TYPE["atkSpd"]

-- λ	hp	生命值	=	value*1	
-- λ	mp	魔法值	=	value*5	
-- λ	physicDef 	物理防御	=	value*3 
-- λ	physicPenetrate	物理穿透	=	value*3 
-- λ		魔力	=	value*6
-- λ	 	魔法防御	=	value*3
-- λ		魔法穿透	=	value*3	
-- λ		暴击等级	=	value*6	
-- λ		闪避等级	=	value*4	
-- λ	atk_fire/water/wood/light/dark	属性攻击=value*6 
-- λ	def_fire/water/wood/light/dark	属性防御=value*6	
-- λ		格挡值

local DEBUG = false

------------------------------------开始定义装备参数数据-------------------------------------------

local EquipmentAttr = class("EquipmentAttr")

function EquipmentAttr:ctor()
    -- 装备属性类型 PublicDefine.ATTR_TYPE
    self.attrType = 0
    -- 装备属性值
    self.attrBaseValue = 0
    -- 精炼值（百分比）需要除以100 和类型一起使用区间区分是否大成
    self.refining = 0
    -- 是否改造过（改造后精炼状态消失）
    self.isTransform = false
    -- 是否附魔
    self.isEnchanting = false
    -- 属性类型 1 值，2 是百分比
    self.attrValueType = 1
    -- 幻化初始为0 = 使用装备本身外观
    self.illusionID = 0

    -- 记录最终的值
    self.endAttr = 0
end

function EquipmentAttr:initData(attrType,attrBaseValue,refining,isTransform,isEnchanting,attrValueType)
    if refining == nil then
        refining = 0
    end
    if isTransform == nil then
        isTransform = false
    end
    if isEnchanting == nil then
        isEnchanting = false
    end

    self.attrType = attrType
    self.attrBaseValue = attrBaseValue
    self.refining = refining
    self.isTransform = isTransform
    self.isEnchanting = isEnchanting

    self.attrValueType = attrValueType

    self.endAttr = self.attrBaseValue

    if DEBUG then
        print("EquipmentAttr:initData attrName,endAttr,attrBaseValue,refining,isTransform,isEnchanting,attrValueType=",ATTR_TYPE_ID_KEY[self.attrType],self.endAttr,self.attrBaseValue,self.refining,self.isTransform,self.isEnchanting,self.attrValueType)
    end
end

function EquipmentAttr:getAttrType()
    return self.attrType
end

function EquipmentAttr:getAttrValue()
    return self.endAttr
end

function EquipmentAttr:getBaseValue()
    if self.attrValueType == VALUE_TYPE.Value then
        return self.attrBaseValue
    end

    return 0
end

function EquipmentAttr:getRateValue()
    if self.attrValueType == VALUE_TYPE.Rate then
        return self.attrBaseValue
    end

    return 0
end

function EquipmentAttr:getIsTransform()
    return self.isTransform
end

function EquipmentAttr:getAttrValueType()
    return self.attrValueType
end

--[[
    return: 0 没有精炼 1 精炼小成  2 精炼大成
]]
function EquipmentAttr:getRefiningType()
    if self.refining == 0 then
        return 0
    else
        -- TODO 获取精炼大成比例

        return 1
    end
end

function EquipmentAttr:getDescription()
    -- TODO 处理区分名字描述
    local languageStr = ToolsUtil:attrNameToLanguageString(ATTR_TYPE_ID_KEY[self.attrType])
    --print("EquipmentAttr:getDescription ",languageStr)
    return  string.format("%s : %d", languageStr, self.endAttr)
end

function EquipmentAttr:getBaseDescription()
    -- 处理区分名字描述
    local languageStr = ToolsUtil:attrNameToLanguageString(ATTR_TYPE_ID_KEY[self.attrType])
    --print("EquipmentAttr:getBaseDescription ",languageStr)
    return  string.format("%s",languageStr)
end

-- 获取详细描述
function EquipmentAttr:getDetailDescription()
    -- 获取详情信息
    local oneAttr = {}
    table.insert(oneAttr,self:getBaseDescription())
    -- print("EquipmentAttr:getDetailDescription ",self.attrValueType,self:getBaseValue(),self:getRateValue())

    if self.attrValueType == VALUE_TYPE.Value then
        -- table.insert(oneAttr,string.format("%d", self.endAttr))
        local endStr, valueType = ToolsUtil:calculationAttrShowValue(self.attrType, self.endAttr)
        table.insert(oneAttr,string.format("%s", endStr))
    else
        table.insert(oneAttr,string.format("%.2f%%",self:getRateValue()/100))
        -- print(string.format("wwwwwwwwwwwwwww=%.4f%%",self:getRateValue()/10000))
    end

    table.insert(oneAttr, self.isTransform)
    table.insert(oneAttr, self.attrType)

    return oneAttr
end

-- 随机属性处理计算最终属性
function EquipmentAttr:calculationEndValue(strengthenLevel, randAttributeStrengthenLV)
    -- 获取随机属性的强化比例
    local strengthenConfig = ConfigManager:getEquipmentRandAttrStrengthen(self.attrType)

    local randArr = strengthenConfig.strengthenValuesByLV
    if(DEBUG) then
        print("EquipmentAttr:calculationEndValue =",strengthenLevel,self.attrBaseValue ,self.refining)
    end
    self.endAttr = self.attrBaseValue
    if strengthenLevel >0 then
        if randAttributeStrengthenLV <= #randArr then
            self.endAttr = (self.attrBaseValue + strengthenLevel*randArr[randAttributeStrengthenLV])
        else
            -- TODO 这里用于提示服务器相关数据出现错误
            -- assert(false, string.format("The  strengthenLevel=%d of the configuration appears",strengthenLevel))
        end
    end
    if(DEBUG) then
        print("EquipmentAttr:calculationEndValue endAttr=", self.endAttr)
    end
    -- TODO 注意处理百分比值

    self.endAttr = self.endAttr * (1+self.refining/ RATIO_NUMBER)
end

function EquipmentAttr:print()
    -- print(string.format("属性名=%s,属性类型=%d,最终值=%d,基础属性=%d,精炼值=%d,改造=%s,附魔=%s,属性类型（1值，2比例）=%d",ATTR_TYPE_ID_KEY[self.attrType],self.attrType,self.endAttr,self.attrBaseValue,self.refining,tostring(self.isTransform),tostring(self.isEnchanting),self.attrValueType))
end

------------------------------------开始定义装备--------------------------------------------------
local EquipmentPetData = class("EquipmentPetData",GoodsData)  

require "app.config.ConfigManager"

Goods = Goods or {}

Goods.EquipmentPetData = EquipmentPetData

function EquipmentPetData:ctor(goodsID)
    EquipmentPetData.super.ctor(self,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
    self.goodsID = goodsID
    self.isGolden = false

    --强化等级
    self.strengthenLevel = 0
    -- 是否新（保存在本地）
    self.isNew = false

    -- 实例ID
    self.entityID = 0

    --基础属性列表（本地） EquipmentAttr
    self._baseArr = {}
    -- -- 百分比词条属性 EquipmentAttr
    -- self._rateArr = {}

    self:conbinationLocalData()
end 

function EquipmentPetData:getIconName()
    if self.icon == nil or self.icon == "" then
        self.icon = self:_getIconName()
    end
    if DEBUG then
        print("EquipmentPetData:getIconName ",self.icon)
    end
    
    return self.icon
end

-- 判断角色是否可以穿戴
function EquipmentPetData:isAvailable(petStar)
    -- 判断是否可以穿戴
    print("EquipmentPetData:isAvailable", petStar, self:getGoodsStar())
    if petStar >= self:getGoodsStar() then
        return true
    end
    
    return false
end

function EquipmentPetData:getNextEquipmentPetData()
    if(self.StrengthenID ~= nil and self.StrengthenID ~= 0) then 

        return GoodsDataManager:createLocalGoodsData(self.StrengthenID)
    end
    
    return nil
end

-- 获取装备类型
function EquipmentPetData:getEquipmentType()

    return self.equipType
end

-- 获取装备类型
function EquipmentPetData:getSkillID()

    return self.specialAttribute
end


-- 获取attachment 字符串  return string
function EquipmentPetData:getAttachmentID()
    if not self.attachmentID then
        local id = (self.goodsID)/10
        self.attachmentID = string.sub(string.format("%d",id),2)
    end

    return self.attachmentID     
end

-- 获取武器相关效果
function EquipmentPetData:getWeaponEffectCombination()
    local spineName = nil
    local slotOrAnimationArr = {}
    if(self.equipEffectID and self.equipEffectID ~=0 and self.equipEffectID ~= "") then
        local combinationStr = self.equipEffectID
        local strArr = string.split(combinationStr, ";")
        for k, v in ipairs(strArr) do 
            if(k == 1) then
                spineName = v
            else
                table.insert(slotOrAnimationArr, v)            
            end
        end
    end

    return spineName, slotOrAnimationArr
end

-- 获取装备是否可以分解
function EquipmentPetData:getResolveType()
    return self.DecompositionToMaterialEquipment
end

-- 获取实例ID
function EquipmentPetData:getEntityID()
    return self.entityID
end

-- 获取装备插槽数据
function EquipmentPetData:getSlotsData()
    return self.slots or {}
end

function EquipmentPetData:setSlotsData(slots)
    self.slots = slots or {}
end

function EquipmentPetData:haveSlotsAndGemData()
    if self.slots and #self.slots > 0 then
        for k,v in ipairs(self.slots) do
            if v.gemId ~= 0 then
                return true
            end
        end
    end
    return false
end

function EquipmentPetData:getGoodsStar()
    return self.goodsStar
end

-- 设置穿戴位置
function EquipmentPetData:setWearPosition(index)
    self.wearPosition = index
end

-- 获取穿戴位置
function EquipmentPetData:getWearPosition()

    return self.wearPosition
end

-- 获取装备战力评分
function EquipmentPetData:getCombatScore()

    return self.combatScore
end

-- 获取强化后的装备ID，0标识无法强化
function EquipmentPetData:getStrengthenNextEquipmentID()

    return self.StrengthenID
end

-- 获取强化所需要的材料 23020001,5000;28320001,1
function EquipmentPetData:getStrengthenNeeds()
    return self.StrengthenNeeds
end

-- 获取卖出价格
function EquipmentPetData:getBaseSellPrice()
    return self.sellPrice
end

-- 获取卖出价格
function EquipmentPetData:getSellPrice()
    if self.DecompositionToMaterialEquipment then
        local arr = string.split(self.DecompositionToMaterialEquipment, ",")
        if(arr and #arr == 2) then 
            if(tonumber(arr[1]) == Game.ConstGoods.Coin) then 
                return tonumber(arr[2])
            end
        end
    end

    return 0
end

function EquipmentPetData:isWeapon()
    if (self.equipmentType == PET_EQUIPMENT_TYPE.PetWeapon) then
        return true
    end

    return false
end

-- 获取装备的详情信息
function EquipmentPetData:getDetailDescription()
    -- 获取详情信息
    local detail = {}
    -- 基础属性
    detail.baseArr = {}
    for k,v in ipairs(self._baseArr) do
        if(v:getAttrType() > 0) then
            table.insert(detail.baseArr,v:getDetailDescription())
        end
    end

    return detail
end

-- 获取基础攻击速度
function EquipmentPetData:getAtkSpd()
    -- 获取攻击速率
    local allAttr = self:getAllAttr()
    local atkSpd = 4000

    for k,equipmentArr in ipairs(allAttr) do
        if equipmentArr:getAttrType() == atkSpdType then
            atkSpd = equipmentArr:getBaseValue()
        end
    end
    
    return atkSpd
end


-- 获取所有装备基础，随机，附魔属性
function EquipmentPetData:getAllAttr()
    local attrAll = {}

    for k,v in ipairs(self._baseArr) do
        table.insert(attrAll,v)
    end

    -- for k,v in ipairs(self._rateArr) do
    --     table.insert(attrAll,v)
    -- end

    return attrAll
end


function EquipmentPetData:initLocalData(data)
    self:setLocalConfigData(data)
    self._baseArr = {}

    -- 处理本地属性
    local basicAttribute = data.basicAttribute
    local basicAttributeValue = data.basicAttributeValue

    for i=1,#basicAttribute do
        local attrType = basicAttribute[i]
        local attrValue = basicAttributeValue[i]

        if DEBUG then
            print("EquipmentPetData:initLocalData attrType,attrValue=",attrType,attrValue)
        end

        local refining = 0
        local isTransform = false
        local isEnchanting = false
        local attrValueType = VALUE_TYPE.Value

        local oneEquipment = EquipmentAttr:create()
        oneEquipment:initData(attrType,attrValue,refining,isTransform,isEnchanting,attrValueType)
        if oneEquipment then
            table.insert(self._baseArr,oneEquipment)
        end
    end
end

--获取主属性 生成区间
function EquipmentPetData:getBasicAttrArea()
     -- 处理本地属性
    local tempAttr = {}
    local basicAttribute = self.basicAttribute
    local basicAttributeValue = data.basicAttributeValue

    for i = 1, #basicAttribute do
        local attrType = basicAttribute[i]
        local attrTypeStr = ATTR_TYPE_ID_KEY[attrType]
        local value = basicAttributeValue[i]
        -- 处理强化值
        local data = {}
        data.showtext = ""
        local value = ToolsUtil:calculationAttrShowValue(attrType, value)
        data.showText = string.format("%s", value)

        data.name = ToolsUtil:attrNameToLanguageString(attrTypeStr)
        table.insert(tempAttr, data)
    end
    return tempAttr
end

function EquipmentPetData:initLocalBaseAttr(data)
    self._baseArr = {}
    -- 处理本地属性
    local basicAttribute = data.basicAttribute
    local basicAttributeValue = data.basicAttributeValue

    for i=1,#basicAttribute do
        local attrType = basicAttribute[i]
        local attrValue = basicAttributeValue[i]

        local refining = 0
        local isTransform = false
        local isEnchanting = false
        local attrValueType = VALUE_TYPE.Value

        local oneEquipment = EquipmentAttr:create()
        oneEquipment:initData(attrType,attrValue,refining,isTransform,isEnchanting,attrValueType)
        if oneEquipment then
            table.insert(self._baseArr,oneEquipment)
        end
    end
end

function EquipmentPetData:initNetData(netData,num,isGolden,isLock,index)
    self:_clear()

    print("netData ====== ",netData)

    local oldGoodsID = self.goodsID

    self.entityID = netData.entityID
    self.slots = netData.slots or {}
    self.isGolden = isGolden
    self.isLock = isLock
    self.num = num
    self.wearPosition = index
    -- print("EquipmentPetData:initNetData entityID,seed, netData.seed=", self.entityID, self.seed, netData.seed)

    -- 处理装备的初始化处理
    self:conbinationLocalData()

    if DEBUG then 
        print("-------------------EquipmentPetData:initNetData rate end--------------------")
    end

    if self.isGolden == true and self.goodsRare < GOODS_RARE.RARE_GOLDEN_3 then
        self.goodsRare = GOODS_RARE.RARE_GOLDEN_3
    end

    -- 计算最终的属性值
    self:refreshEndAttr()
end

function EquipmentPetData:getBytesData()
    local ProtobufUtil = require "utils.ProtobufUtil"
    local decodeData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData", self.BytesData)

    if not decodeData then
        return
    end
    decodeData.entityID = self.entityID
    
    self.BytesData =  ProtobufUtil:encode("GoodsSystem.PetEquipmentData", decodeData)   
    return self.BytesData
end

function EquipmentPetData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getPetEquipmentConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            printError(string.format("EquipmentPetData:conbinationLocalData  %d no found local data ",self.goodsID))
        end
    end
end

-- 刷新一下最终的属性
function EquipmentPetData:refreshEndAttr()
    -- TODO 刷新最终的属性

end

function EquipmentPetData:print()
    -- print("--------------------------------------")
    -- print(string.format("entityID=%d,goodsID=%d, isGolden=%s,strengthenLevel=%d,isLock=%s,isNew=%s,isInCaveNewGet=%s",self.entityID,self.goodsID,tostring(self.isGolden),self.strengthenLevel,tostring(self.isLock),tostring(self.isNew),tostring(self.isInCaveNewGet)))
    -- print("----------基础属性-----------")
    -- for k,v in ipairs(self._baseArr) do
    --     v:print()
    -- end
    -- print("----------随机属性----------")
    -- for k,v in ipairs(self._randomArr) do
    --     v:print()
    -- end
    -- print("----------附魔属性----------")
    -- if self.enchanting then
    --     self.enchanting:print()
    -- end
    -- print("----------比例属性----------")
    -- if self._rateArr then
    --     for k,v in ipairs(self._rateArr) do
    --         v:print()
    --     end
    -- end

    -- print("--------------------------------------")
end

function EquipmentPetData:_clear()
    -- 这里采用暴力清空，后续需要优化处理
    self.goodsRare = nil

    self._baseArr = {}
    self._randomArr = {}
    -- self._rateArr = {}

    self.enchanting = nil
    self._specialAttr = {}
    self._holeDataArr = {}
    self.seed = -1

    self:clearBytesData()
    -- self.goodsRare = nil

    -- for k,v in pairs(self._baseArr) do
    --     self._baseArr[k] = nil
    -- end

    -- for k,v in pairs(self._randomArr) do
    --     self._randomArr[k] = nil
    -- end

    -- for k,v in pairs(self._rateArr) do
    --     self._rateArr[k] = nil
    -- end

    -- self.enchanting = nil

    -- for k,v in pairs(self._specialAttr) do
    --     self._specialAttr[k] = nil
    -- end
end

-- 获取是否获得
function EquipmentPetData:getWasGet()
    -- body
    if(self.seed == -1) then 
        return false
    end 
    return true
end

function EquipmentPetData:getSkillDescription()
    if(self.specialAttribute and self.specialAttribute ~= 0) then 
        local skillData = SkillDataManager:createSkillForSkillId(self.specialAttribute)
        if(skillData) then 
            return skillData:getDescription()
        end
    end

    return ""
end
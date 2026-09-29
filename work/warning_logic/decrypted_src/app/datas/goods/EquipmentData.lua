
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
function EquipmentAttr:calculationEndValue(strengthenLevel, randAttributeStrengthenLV, data)
    -- 获取随机属性的强化比例
    local strengthenConfig = ConfigManager:getEquipmentRandAttrStrengthen(self.attrType)
    
    local calculationStrengthenLV = randAttributeStrengthenLV
    --修改随机属性
    if data and data.createLevel and data.createLevel > 0 then
        local levelLimiteList = string.split(data.equipRequireLvIntervals, ";")
        local strengthenLevelLimite = string.split(levelLimiteList[2], ",")

        local strengthenLowerLimite = tonumber(strengthenLevelLimite[1])
        local strengthenUpperLimite = tonumber(strengthenLevelLimite[2])

        local limitStrengthenLevel = clone(data.createLevel)
        limitStrengthenLevel = math.max(limitStrengthenLevel, strengthenLowerLimite + data.qualityGrade)
        limitStrengthenLevel = math.min(limitStrengthenLevel, strengthenUpperLimite + data.qualityGrade)

        
        calculationStrengthenLV = limitStrengthenLevel
    end

    local randArr = strengthenConfig.strengthenValuesByLV
    if(DEBUG) then
        print("EquipmentAttr:calculationEndValue =",strengthenLevel,self.attrBaseValue ,self.refining)
    end
    self.endAttr = self.attrBaseValue
    if strengthenLevel >0 then
        if calculationStrengthenLV <= #randArr then
            self.endAttr = (self.attrBaseValue + strengthenLevel*randArr[calculationStrengthenLV])
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

------------------------------------开始定义套装属性-------------------------------------------
local EquipmentSet = class("EquipmentSet")

function EquipmentSet:ctor(setID, chageSetData)
    local setMarkData = ConfigManager:getEquipmentSetBySetMark(setID)
    -- print("EquipmentSet:ctor =",setID,setMarkData)
    self.localSetData = nil
    if setMarkData then
        self.localSetData = clone(setMarkData)
    end

    if (self.localSetData) then
        self.localSetData.chageSetSkillIndex = {}
        for k,v in pairs(self.localSetData.equipSetSkillUnlock) do
            self.localSetData.chageSetSkillIndex[k] = false
        end
    end

    -- 处理改造后的套装属性配置
    if self.localSetData and chageSetData and table.nums(chageSetData) > 0 and chageSetData.retrofitData and table.nums(chageSetData.retrofitData) > 0 then
        for k,v in pairs(self.localSetData.equipSetSkillUnlock) do
            if chageSetData.retrofitData[v] then
                self.localSetData.equipSetSkill[k] = chageSetData.retrofitData[v].setSkill
                self.localSetData.chageSetSkillIndex[k] = true
            end
        end
    end

    self._chageSetData = chageSetData
    -- 处理解析套装属性
    self._setSkillArr ={}
    local index = 1
    if(self.localSetData) then
        for k,skillID in ipairs(self.localSetData.equipSetSkill) do
            local skillData = SkillDataManager:createSkillForSkillId(skillID)
            if(skillData) then
                self._setSkillArr[index] = skillData

                index = index + 1
            end
        end
    else
        printError(string.format("localSetData is nil. setID=%d", setID)) 
    end
end

function EquipmentSet:getEquipSetNum()
    return self.localSetData.equipSetNum
end

function EquipmentSet:getSetName()
    return self.localSetData.equipSetName
end


--[[
    获取普通描述

    return: {setName="11",attr={{"description","2/5"}}}
]]
function EquipmentSet:getNormalDescriptionArr(activeNum)
    -- TODO 根据触发条件来判断是否
    local setDescriptionArr = {}
    setDescriptionArr.setName = self:getSetName()
    -- 激活字符串
    setDescriptionArr.activeStr = string.format("%d/%d",activeNum, self:getEquipSetNum())
    -- setDescriptionArr.attr={}
    -- 激活属性
    setDescriptionArr.activationArr = {}
    -- 未激活属性
    setDescriptionArr.noActivationArr = {}
    for k,skillData in ipairs(self._setSkillArr) do
        if(skillData) then
            local oneAttr = {}
            table.insert(oneAttr,skillData:getDescription())
            -- table.insert(oneAttr,string.format("%d/%d",self.localSetData.equipSetSkillUnlock[k],self:getEquipSetNum()))
            table.insert(oneAttr,string.format("%d",self.localSetData.equipSetSkillUnlock[k]))

            if(self.localSetData.equipSetSkillUnlock[k] <= activeNum) then
                table.insert(setDescriptionArr.activationArr,oneAttr)
            else
                table.insert(setDescriptionArr.noActivationArr,oneAttr)
            end
        end
    end

    return setDescriptionArr
end

-- 获取激活的套装属性
function EquipmentSet:getActivationSet(equipNum)
    local activationArr = {}
    for k,num in ipairs(self.localSetData.equipSetSkillUnlock) do
        if num <=equipNum then
            table.insert(activationArr,self._setSkillArr[k])
        else
            break
        end
    end

    return activationArr
end

-- 获取未激活的套装属性
function EquipmentSet:getNoActivationSet(equipNum)
    local noActivationArr = {}
    for k,num in ipairs(self.localSetData.equipSetSkillUnlock) do
        if num >equipNum then
            table.insert(noActivationArr,self._setSkillArr[k])
        end
    end

    return noActivationArr
end

-- 开始定义装备宝石插槽
local EquipmentHoleData = class("EquipmentHoleData")

function EquipmentHoleData:ctor(holeType, gemStoneID, viceGemStoneID)
    self.holeType = holeType;                   -- 插槽类型(同宝石类型RuneType)
    self.gemStoneID = gemStoneID or 0;          -- 插槽宝石ID
    self.viceGemStoneID = viceGemStoneID or 0;  -- 插槽副宝石ID
end

-- 获取插槽类型
function EquipmentHoleData:getHoleType()
    return self.holeType
end 

-- 获取插槽index
function EquipmentHoleData:getIndex()
    return self.index
end 

function EquipmentHoleData:initData(data, index)
    -- body
    self.index = index
    self.holeType = data.holeType
    self.gemStoneID = data.gemStoneID
    self.viceGemStoneID = data.viceGemStoneID
end

function EquipmentHoleData:getGemStoneData()
    -- body
    if(self.gemStoneData == nil) then 
        if(self.gemStoneID ~= 0) then 
            local gemStone = Goods.GemStoneData:create(self.gemStoneID)
            gemStone:initNetData(1,nil,nil, true,self.viceGemStoneID)
            self.gemStoneData = gemStone
        end
    end

    return self.gemStoneData
end

-- 开始定义装备雕文
local EquipmentGlyphData = class("EquipmentGlyphData")

function EquipmentGlyphData:ctor(goodsID)
    self.goodsID = goodsID
end

-- 获取雕文类型
function EquipmentGlyphData:getGlyphType()
    return self.data.type
end 

-- 获取雕文index
function EquipmentGlyphData:getIndex()
    return self.index
end 

function EquipmentGlyphData:initData(data, index)
    -- body
    self.index = index
    self.data = data
end

function EquipmentGlyphData:getGlyphData()
    -- body
    if(self.glyphData == nil) then 
        --if(self.data.glyphID ~= 0) then 
        --print("getGlyphData=-===============>: ", self.data)
            local glyph = Goods.GlyphData:create(self.goodsID)
            glyph:initNetData(self.data ,1,nil,nil, true)
            self.glyphData = glyph
        --end
    end

    return self.glyphData
end

------------------------------------开始定义装备--------------------------------------------------
local EquipmentData = class("EquipmentData",GoodsData)  

require "app.config.ConfigManager"

Goods = Goods or {}

Goods.EquipmentData = EquipmentData

function EquipmentData:ctor(goodsID)
    EquipmentData.super.ctor(self,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    
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
    --随机属性列表 EquipmentAttr
    self._randomArr = {}
    --附魔属性 EquipmentAttr
    self.enchanting = nil
    -- 百分比词条属性 EquipmentAttr
    self._rateArr = {}
    
    --装备改造临时属性
    self._tmpRemodelAttr = nil

    --套装属性
    self._equipmentSet = nil
    --特殊属性
    self._specialAttr = {}
    -- 插槽属性
    self._holeDataArr = {}
    -- 雕文属性
    self._glyphDataArr = {}

    self.seed = -1           -- 随机种子,为基础属性使用 eg:-1 标识没有随机基础属性

    self:conbinationLocalData()
    self:_refreshEquipmentType()
    --改造次数
    self.remodelNum = 0
    self.refineNum =  0
    self.setChangeNum =  0
    --是否是构建回来的
    self.fromConverted = 0

    self.createLevel =  0   -- 随机属性构建等级

    self.primogemId = 0

    self.changeEquipID = 0
    --转换之前的idx
    self.fromConvertedGoodsData = nil
end 

function EquipmentData:getIconName()
    if self.icon == nil or self.icon == "" then
        self.icon = self:_getIconName()
    end
    if DEBUG then
        print("EquipmentData:getIconName ",self.icon)
    end

    if self.primogemId > 0 then
        local goodsConfig = Config.ConfigGoods:getPrimoGemStone(self.primogemId)
        self.icon = self:_getChaosIconName(goodsConfig.equipId)
    end
    
    return self.icon
end

-- 判断角色是否可以穿戴
function EquipmentData:isAvailable(roleLV)
    -- 判断是否可以穿戴
    if roleLV >= self:getWearLV() then
        return true
    elseif self.createLevel and self.createLevel > 0 then
        return true
    end
    
    return false
end

-- 获取装备类型
function EquipmentData:getEquipmentType()
    self:_refreshEquipmentType()
    if DEBUG then
        print("EquipmentData:getEquipmentType  ",self.goodsID,self.equipmentType)
    end

    return self.equipmentType
end

-- 获取武器类型
function EquipmentData:getWeaponType()

    return self._weaponType
end

-- 获取attachment 字符串  return string
function EquipmentData:getAttachmentID()
    if not self.attachmentID or self.primogemId > 0 then
        local id = (self.goodsID)/10
        if self.primogemId > 0 then
            local goodsConfig = Config.ConfigGoods:getPrimoGemStone(self.primogemId)
            id = (goodsConfig.equipId)/10
        end
        self.attachmentID = string.sub(string.format("%d",id),2)
    end

    return self.attachmentID     
end

-- 获取武器相关效果
function EquipmentData:getWeaponEffectCombination()
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

-- 是否改造过
function EquipmentData:getIsTransform()
    local isTransform = false

    for k,equipmentAttr in pairs(self._randomArr) do
        if(equipmentAttr:getIsTransform()) then
            return true
        end
    end

    for k,equipmentAttr in pairs(self._rateArr) do
        if(equipmentAttr:getIsTransform()) then
            return true
        end
    end

    if(self.enchanting) then
        if(self.enchanting:getIsTransform()) then
            return true
        end
    end

    return false
end
-- 获取装备是否可以分解
function EquipmentData:getResolveType()
    return self.DecompositionToMaterialEquipment
end
-- 获取能够强化最大等级
function EquipmentData:getStrengthenMaxLv()
    return self.equipStrengthenMaxLv
end

-- 获取是否解锁多彩孔
function EquipmentData:getIsUnlockColorHole()
    if(self.strengthenLevel >= self:getColorHoleUnlockLevel()) then 
        return true
    else  
        return false
    end
end

-- 获取多彩孔解锁等级
function EquipmentData:getColorHoleUnlockLevel()
    -- body
    return tonumber(self.rainbowSlotUnlockLevel)
end

-- 获取实例ID
function EquipmentData:getEntityID()
    return self.entityID
end

-- 获取装备重量
function EquipmentData:getWeight()
    return self.weight
end

-- 设置等级移除
function EquipmentData:setLvRemoveStatus()
    self.isLvRemove = true
end

function EquipmentData:getLvRemove()
    return self.isLvRemove
end

-- 获取穿戴需求等级
function EquipmentData:getWearLV()
    if(self.isLvRemove) then
        return 1
    end 
    return self.equipRequireLV
end

-- 获取装备等级
function EquipmentData:getEquipLV()
    return self.equipLV
end


-- 设置穿戴位置
function EquipmentData:setWearPosition(index)
    self.wearPosition = index
end

-- 获取穿戴位置
function EquipmentData:getWearPosition()

    return self.wearPosition
end

-- 获取装备战力评分
function EquipmentData:getCombatScore()

    return self.combatScore
end

-- 获取精炼星级
function EquipmentData:getStarData()
    local starData = {}

    starData.goldStar = 0
    starData.silverStar = 0

    return starData
end

-- 获取卖出价格
function EquipmentData:getBaseSellPrice()
    return self.sellPrice
end

-- 获取卖出价格
function EquipmentData:getSellPrice()
    return ToolsUtil:calculationSellCoin(self)
end

function EquipmentData:getStrengthenLeve()
    return self.strengthenLevel
end 

function EquipmentData:getPunchNum()
    return self.punchNum
end

function EquipmentData:setPunchNum(punchNum)
    self.punchNum = punchNum
end

function EquipmentData:isWeapon()
    if (self.equipmentType == EQUIPMENT_TYPE.Weapon) then
        return true
    end

    return false
end

function EquipmentData:isFish()
    if (self.equipmentType == EQUIPMENT_TYPE.Fish) then
        return true
    end

    return false
end

-- 获取装备的详情信息  activeNum 激活数量,如果nil 就表示直接去当前玩家数据
function EquipmentData:getDetailDescription(activeNum)
    -- TODO 获取详情信息
    local detail = {}

    -- 基础属性
    detail.baseArr = {}

    if(self:getWasGet()) then
        local minV = nil
        local maxV = nil
        for k,v in ipairs(self._baseArr) do
            if ATTR_TYPE_ID_KEY[v:getAttrType()] == "atkMin" then
                minV = v
            elseif ATTR_TYPE_ID_KEY[v:getAttrType()] == "atkMax" then
                maxV = v
            else
                if(v:getAttrType() > 0) then
                    table.insert(detail.baseArr,v:getDetailDescription())
                end
            end
        end
        if(minV ~= nil or maxV ~= nil) then
            local oneAttr = {}
            table.insert(oneAttr,ToolsUtil:attrNameToLanguageString("atk"))
            
            local str = ""
            if(minV) then
                str = ""..minV:getBaseValue()
            else
                str = "0"
            end
            if(maxV) then
                str = str.."-"..maxV:getBaseValue()
            else
                str = str.."-0"
            end
            table.insert(oneAttr,string.format("%s",str))

            table.insert(detail.baseArr, 1, oneAttr)
        end
    else 

        local configData = ConfigManager:getEquipmentConfigByID(self.goodsID)

        -- 处理本地属性
        local basicAttribute = configData.basicAttribute
        -- local basicAttributeValue = data.basicAttributeValue
        local basicAttributeValueMin = configData.basicAttributeValueMin
        local basicAttributeValueMax = configData.basicAttributeValueMax
        local basicAttributeStrengthenValue = configData.basicAttributeStrengthenValue

        local minArr = {}
        local maxArr = {}
        for i=1,#basicAttribute do
            local attrType = basicAttribute[i]

            local basicAttributeValueMinByIndex = basicAttributeValueMin[i]
            local basicAttributeValueMaxByIndex = basicAttributeValueMax[i]
            if self.createLevel and self.createLevel > 0 then
                local createLevel = clone(self.createLevel)
                local levelLimiteList = string.split(configData.equipRequireLvIntervals, ";")
                local levelLimite = string.split(levelLimiteList[1], ",")
                local lowerLimite = tonumber(levelLimite[1])
                local upperLimite = tonumber(levelLimite[2])
                    
                createLevel = math.max(createLevel, lowerLimite + self.qualityGrade)
                createLevel = math.min(createLevel, upperLimite + self.qualityGrade)

                local basicAttributeConfig = ConfigManager:getBasicAttributeByID(attrType)

                if configData.occupDiffer == 0 then
                    basicAttributeValueMinByIndex = basicAttributeConfig.minCommonMainAttribute[createLevel]
                    basicAttributeValueMaxByIndex = basicAttributeConfig.maxCommonMainAttribute[createLevel]
                elseif configData.occupDiffer == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                    basicAttributeValueMinByIndex = basicAttributeConfig.minShieldMainAttribute[createLevel]
                    basicAttributeValueMaxByIndex = basicAttributeConfig.maxShieldMainAttribute[createLevel]
                elseif configData.occupDiffer == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                    basicAttributeValueMinByIndex = basicAttributeConfig.minSwordMainAttribute[createLevel]
                    basicAttributeValueMaxByIndex = basicAttributeConfig.maxSwordMainAttribute[createLevel]
                elseif configData.occupDiffer == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                    basicAttributeValueMinByIndex = basicAttributeConfig.minMasterMainAttribute[createLevel]
                    basicAttributeValueMaxByIndex = basicAttributeConfig.maxMasterMainAttribute[createLevel]
                end
            end

            if ATTR_TYPE_ID_KEY[attrType] == "atkMin" then
                minArr[1] = basicAttributeValueMinByIndex
                minArr[2] = basicAttributeValueMaxByIndex
            elseif ATTR_TYPE_ID_KEY[attrType] == "atkMax" then
                maxArr[1] = basicAttributeValueMinByIndex
                maxArr[2] = basicAttributeValueMaxByIndex
            elseif ATTR_TYPE_ID_KEY[attrType] == "atkSpd" then
                local oneAttr = {}
                local name = ToolsUtil:attrNameToLanguageString(ATTR_TYPE_ID_KEY[attrType])
                table.insert(oneAttr, name)

                local endStr, valueType = ToolsUtil:calculationAttrShowValue(attrType, basicAttributeValueMinByIndex)
                table.insert(oneAttr, string.format("%s", endStr))

                table.insert(detail.baseArr, oneAttr)
            else
                if attrType > 0 then
                    local oneAttr = {}
                    local name = ToolsUtil:attrNameToLanguageString(ATTR_TYPE_ID_KEY[attrType])
                    table.insert(oneAttr, name)
                    if(basicAttributeValueMinByIndex == basicAttributeValueMaxByIndex) then 
                        table.insert(oneAttr, string.format("%d", basicAttributeValueMinByIndex))
                    else 
                        local endStrMin, valueType = ToolsUtil:calculationAttrShowValue(attrType, basicAttributeValueMinByIndex)
                        local endStrMax, valueType = ToolsUtil:calculationAttrShowValue(attrType, basicAttributeValueMaxByIndex)
                        table.insert(oneAttr, string.format("%s~%s", endStrMin, endStrMax))
                    end

                    table.insert(detail.baseArr, oneAttr)
                end
            end


        end

        if(#minArr >0 and #maxArr > 0) then
            local oneAttr = {}
            table.insert(oneAttr,ToolsUtil:attrNameToLanguageString("atk"))

            table.insert(oneAttr, string.format("(%d~%d)-(%d~%d)", minArr[1], minArr[2], maxArr[1], maxArr[2]))
            table.insert(detail.baseArr, 1, oneAttr)
        end
        if self.fromConvertedGoodsData then
            detail.baseArr = {}
            self:initLocalBaseAttr(configData)
            local minV = nil
            local maxV = nil
            for k,v in ipairs(self._baseArr) do
                if ATTR_TYPE_ID_KEY[v:getAttrType()] == "atkMin" then
                    minV = v
                elseif ATTR_TYPE_ID_KEY[v:getAttrType()] == "atkMax" then
                    maxV = v
                else
                    table.insert(detail.baseArr,v:getDetailDescription())
                end
            end
            if(minV ~= nil or maxV ~= nil) then
                local oneAttr = {}
                table.insert(oneAttr,ToolsUtil:attrNameToLanguageString("atk"))
                
                local str = ""
                if(minV) then
                    str = ""..minV:getBaseValue()
                else
                    str = "0"
                end
                if(maxV) then
                    str = str.."-"..maxV:getBaseValue()
                else
                    str = str.."-0"
                end
                table.insert(oneAttr,string.format("%s",str))

                table.insert(detail.baseArr, 1, oneAttr)
            end
        end
    end

    -- 随机属性
    detail.randomArr = {}
    for k,v in ipairs(self._randomArr) do

        table.insert(detail.randomArr,v:getDetailDescription())
    end

    if self.createLevel and self.primogemId > 0 then
        -- 原石附加属性
        detail.primogemArr = {}
        local goodsConfig = Config.ConfigGoods:getPrimoGemStone(self.primogemId)
        local attrList = string.split(goodsConfig.attributeValue, ";")
        local attrData = {}
        attrData.attrType = tonumber(attrList[1])
        attrData.attrBaseValue = tonumber(attrList[2])
        attrData.attrValueType = 1

        local primogemAttr = self:createEquipmentPrimogemAttr(attrData)

        table.insert(detail.primogemArr,primogemAttr:getDetailDescription())
    end
    

    -- 附魔属性
    detail.enchanting = nil
    if self.enchanting then

        detail.enchanting = self.enchanting:getDetailDescription()
    end

    -- 比例属性
    detail.rateArr = {}
    for k,v in ipairs(self._rateArr) do
        table.insert(detail.rateArr,v:getDetailDescription())
    end

    -- 套装属性
    if self._equipmentSet then
        -- 获取激活数量
        if(activeNum == nil) then
            activeNum = GameDataManager:getInstance():getWearSetActiveNum(self:getEquipSetID())
        end
            
        detail.equipmentArr = self._equipmentSet:getNormalDescriptionArr(activeNum)
    end

    -- 特殊属性
    detail.specialArr = {}
    for k,v in ipairs(self._specialAttr) do
        table.insert(detail.specialArr,v:getDescription())
    end

    -- TODO 获取镶嵌属性


    return detail
end

-- 获取基础攻击速度
function EquipmentData:getAtkSpd()
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

-- 获取套装ID
function EquipmentData:getEquipSetID()
    return self.equipSetMark
end

-- 获取所有装备基础，随机，附魔属性
function EquipmentData:getAllAttr()
    local attrAll = {}

    for k,v in ipairs(self._baseArr) do
        table.insert(attrAll,v)
    end

    for k,v in ipairs(self._randomArr) do
        table.insert(attrAll,v)
    end

    if self.enchanting then
        table.insert(attrAll,self.enchanting)
    end

    for k,v in ipairs(self._rateArr) do
        table.insert(attrAll,v)
    end

    return attrAll
end


function EquipmentData:initLocalData(data)
    self:setLocalConfigData(data)

    self._baseArr = {}

    -- 处理本地属性
    local basicAttribute = data.basicAttribute
    -- local basicAttributeValue = data.basicAttributeValue
    local basicAttributeValueMin = data.basicAttributeValueMin
    local basicAttributeValueMax = data.basicAttributeValueMax
    local basicAttributeStrengthenValue = data.basicAttributeStrengthenValue
    if DEBUG then
        print("EquipmentData:initLocalData  strengthenLevel=",self.strengthenLevel)
    end

    local randomGenerater = nil
    if(self.seed ~= -1) then
        randomGenerater = Avalon.RandomGenerater:new(self.seed)
    end
    local localData
    if self.fromConverted ~= 0 then
        local goodsId = Config.Manager:getEquipIdByConvertEquipId(self.goodsID)
        if goodsId then
            localData = ConfigManager:getEquipmentConfigByID(goodsId)
        end
    end

    self.equipLevelRemoveConfig = ConfigManager:getEquipLevelRemove(self.goodsID)

    for i=1,#basicAttribute do
        local attrType = basicAttribute[i]
        -- local attrValue = basicAttributeValue[i]
    
        local basicAttributeValueMinByIndex = basicAttributeValueMin[i]
        local basicAttributeValueMaxByIndex = basicAttributeValueMax[i]
        local basicAttributeStrengthenValueByIndex = basicAttributeStrengthenValue[i]
        if self.createLevel and self.createLevel > 0 then 
            local createLevel = clone(self.createLevel)
            local levelLimiteList = string.split(data.equipRequireLvIntervals, ";")
            local baseLevelLimite = string.split(levelLimiteList[1], ",")
            local strengthenLevelLimite = string.split(levelLimiteList[2], ",")
            local lowerLimite = tonumber(baseLevelLimite[1])
            local upperLimite = tonumber(baseLevelLimite[2])

            local strengthenLowerLimite = tonumber(strengthenLevelLimite[1])
            local strengthenUpperLimite = tonumber(strengthenLevelLimite[2])

            createLevel = math.max(createLevel, lowerLimite + self.qualityGrade)
            createLevel = math.min(createLevel, upperLimite + self.qualityGrade)

            local strengthenLevel = clone(self.createLevel)
            strengthenLevel = math.max(strengthenLevel, strengthenLowerLimite + self.qualityGrade)
            strengthenLevel = math.min(strengthenLevel, strengthenUpperLimite + self.qualityGrade)

            local basicAttributeConfig = ConfigManager:getBasicAttributeByID(attrType)
            local strengthenConfig = ConfigManager:getBasicAttributeStrengthenByID(attrType)
            
            if data.occupDiffer == 0 then
                basicAttributeValueMinByIndex = basicAttributeConfig.minCommonMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxCommonMainAttribute[createLevel]

                basicAttributeStrengthenValueByIndex = strengthenConfig.CommonAttributeLv[strengthenLevel]
            elseif data.occupDiffer == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                basicAttributeValueMinByIndex = basicAttributeConfig.minShieldMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxShieldMainAttribute[createLevel]

                basicAttributeStrengthenValueByIndex = strengthenConfig.ShieldAttributeLv[strengthenLevel]
            elseif data.occupDiffer == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                basicAttributeValueMinByIndex = basicAttributeConfig.minSwordMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxSwordMainAttribute[createLevel]

                basicAttributeStrengthenValueByIndex = strengthenConfig.SwordAttributeLv[strengthenLevel]
            elseif data.occupDiffer == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                basicAttributeValueMinByIndex = basicAttributeConfig.minMasterMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxMasterMainAttribute[createLevel]

                basicAttributeStrengthenValueByIndex = strengthenConfig.MasterAttributeLv[strengthenLevel]
            end
        end

        local min,max = basicAttributeValueMinByIndex or 0, basicAttributeValueMaxByIndex or 0
        if localData and (not self.createLevel or self.createLevel == 0) then
            min, max = localData.basicAttributeValueMin[i], localData.basicAttributeValueMax[i]
        end

        local attrValue = 0
        if(randomGenerater) then
            attrValue = randomGenerater:random(min, max)
        end

        --是否是转换来的装备
        if localData then
            local rate = attrValue/max
            attrValue = math.floor(basicAttributeValueMaxByIndex * rate) 
        end


        local strenghthenValue = basicAttributeStrengthenValueByIndex
        if DEBUG then
            print("EquipmentData:initLocalData attrType,attrValue,strenghthenValue=",attrType,attrValue,strenghthenValue)
        end

        local refining = 0
        local isTransform = false
        local isEnchanting = false
        local attrValueType = VALUE_TYPE.Value

        -- 处理强化值
        attrValue = attrValue + strenghthenValue * self.strengthenLevel

        local oneEquipment = EquipmentAttr:create()
        oneEquipment:initData(attrType,attrValue,refining,isTransform,isEnchanting,attrValueType)
        if oneEquipment then
            table.insert(self._baseArr,oneEquipment)
        end
    end

    if(randomGenerater) then 
        randomGenerater:delete()
        randomGenerater = nil
    end

    -- 处理套装属性处理
    self:updateStarPrayEquipmentSet()
end

function EquipmentData:updateStarPrayEquipmentSet()
    -- 处理套装属性处理
    local setMark = self.equipSetMark
    if setMark ~= 0 and setMark ~= nil then
        local chageSetData = mvc.suitTransformationModel:getEquipmentSetDataBySetId(setMark)
        self._equipmentSet = EquipmentSet:create(setMark, chageSetData)
    end
end

--获取主属性 生成区间
function EquipmentData:getBasicAttrArea()
     -- 处理本地属性
    local tempAttr = {}
    local basicAttribute = self.basicAttribute
    -- local basicAttributeValue = data.basicAttributeValue
    local basicAttributeValueMin = self.basicAttributeValueMin
    local basicAttributeValueMax = self.basicAttributeValueMax
    local basicAttributeStrengthenValue = self.basicAttributeStrengthenValue

    for i = 1, #basicAttribute do
        local attrType = basicAttribute[i]
        local attrTypeStr = ATTR_TYPE_ID_KEY[attrType]

        local basicAttributeValueMinByIndex = basicAttributeValueMin[i]
        local basicAttributeValueMaxByIndex = basicAttributeValueMax[i]
        local basicAttributeStrengthenValueByIndex = basicAttributeStrengthenValue[i]
        if self.createLevel and self.createLevel > 0 then
            local createLevel = clone(self.createLevel)
            local levelLimiteList = string.split(self.equipRequireLvIntervals, ";")
            local baseLevelLimite = string.split(levelLimiteList[1], ",")
            local strengthenLevelLimite = string.split(levelLimiteList[2], ",")
            local lowerLimite = tonumber(baseLevelLimite[1])
            local upperLimite = tonumber(baseLevelLimite[2])

            local strengthenLowerLimite = tonumber(strengthenLevelLimite[1])
            local strengthenUpperLimite = tonumber(strengthenLevelLimite[2])

            createLevel = math.max(createLevel, lowerLimite + self.qualityGrade)
            createLevel = math.min(createLevel, upperLimite + self.qualityGrade)

            local strengthenLevel = clone(self.createLevel)
            strengthenLevel = math.max(strengthenLevel, strengthenLowerLimite + self.qualityGrade)
            strengthenLevel = math.min(strengthenLevel, strengthenUpperLimite + self.qualityGrade)

            local basicAttributeConfig = ConfigManager:getBasicAttributeByID(attrType)
            local strengthenConfig = ConfigManager:getBasicAttributeStrengthenByID(attrType)

            if self.occupDiffer == 0 then
                basicAttributeValueMinByIndex = basicAttributeConfig.minCommonMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxCommonMainAttribute[createLevel]
    
                basicAttributeStrengthenValueByIndex = strengthenConfig.CommonAttributeLv[strengthenLevel]
            elseif self.occupDiffer == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                basicAttributeValueMinByIndex = basicAttributeConfig.minShieldMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxShieldMainAttribute[createLevel]
    
                basicAttributeStrengthenValueByIndex = strengthenConfig.ShieldAttributeLv[strengthenLevel]
            elseif self.occupDiffer == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                basicAttributeValueMinByIndex = basicAttributeConfig.minSwordMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxSwordMainAttribute[createLevel]
    
                basicAttributeStrengthenValueByIndex = strengthenConfig.SwordAttributeLv[strengthenLevel]
            elseif self.occupDiffer == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                basicAttributeValueMinByIndex = basicAttributeConfig.minMasterMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxMasterMainAttribute[createLevel]
    
                basicAttributeStrengthenValueByIndex = strengthenConfig.MasterAttributeLv[strengthenLevel]
            end
        end

        local min,max = basicAttributeValueMinByIndex, basicAttributeValueMaxByIndex

        local strenghthenValue = basicAttributeStrengthenValueByIndex
        -- 处理强化值
        local data = {}
        min = min + strenghthenValue * self.strengthenLevel
        max = max + strenghthenValue * self.strengthenLevel
        data.showtext = ""
        if(min == max) then 
            local value = ToolsUtil:calculationAttrShowValue(attrType, min)
            data.showText = string.format("%s", value)
        else 
            min = ToolsUtil:calculationAttrShowValue(attrType, min)
            max = ToolsUtil:calculationAttrShowValue(attrType, max)
            data.showText = string.format("%s~%s", min, max)
        end
        data.name = ToolsUtil:attrNameToLanguageString(attrTypeStr)
        table.insert(tempAttr, data)
    end
    return tempAttr
end

function EquipmentData:initLocalBaseAttr(data)
    self._baseArr = {}

    -- 处理本地属性
    local basicAttribute = data.basicAttribute
    -- local basicAttributeValue = data.basicAttributeValue
    local basicAttributeValueMin = data.basicAttributeValueMin
    local basicAttributeValueMax = data.basicAttributeValueMax
    local basicAttributeStrengthenValue = data.basicAttributeStrengthenValue
    
    

    local randomGenerater = nil
    if(self.fromConvertedGoodsData.seed ~= -1) then
        randomGenerater = Avalon.RandomGenerater:new(self.fromConvertedGoodsData.seed)
    end

    local localData
    if self.fromConvertedGoodsData then
        localData = ConfigManager:getEquipmentConfigByID(self.fromConvertedGoodsData.goodsID)
    end


    for i=1,#basicAttribute do
        local attrType = basicAttribute[i]
        -- local attrValue = basicAttributeValue[i]

        local basicAttributeValueMinByIndex = basicAttributeValueMin[i]
        local basicAttributeValueMaxByIndex = basicAttributeValueMax[i]
        local basicAttributeStrengthenValueByIndex = basicAttributeStrengthenValue[i]
        if self.createLevel and self.createLevel > 0 then
            local createLevel = clone(self.createLevel)
            local levelLimiteList = string.split(data.equipRequireLvIntervals, ";")
            local baseLevelLimite = string.split(levelLimiteList[1], ",")
            local strengthenLevelLimite = string.split(levelLimiteList[2], ",")
            local lowerLimite = tonumber(baseLevelLimite[1])
            local upperLimite = tonumber(baseLevelLimite[2])

            local strengthenLowerLimite = tonumber(strengthenLevelLimite[1])
            local strengthenUpperLimite = tonumber(strengthenLevelLimite[2])

            createLevel = math.max(createLevel, lowerLimite + self.qualityGrade)
            createLevel = math.min(createLevel, upperLimite + self.qualityGrade)

            local strengthenLevel = clone(self.createLevel)
            strengthenLevel = math.max(strengthenLevel, strengthenLowerLimite + self.qualityGrade)
            strengthenLevel = math.min(strengthenLevel, strengthenUpperLimite + self.qualityGrade)

            local basicAttributeConfig = ConfigManager:getBasicAttributeByID(attrType)
            local strengthenConfig = ConfigManager:getBasicAttributeStrengthenByID(attrType)

            if data.occupDiffer == 0 then
                basicAttributeValueMinByIndex = basicAttributeConfig.minCommonMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxCommonMainAttribute[createLevel]
        
                basicAttributeStrengthenValueByIndex = strengthenConfig.CommonAttributeLv[strengthenLevel]
            elseif data.occupDiffer == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                basicAttributeValueMinByIndex = basicAttributeConfig.minShieldMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxShieldMainAttribute[createLevel]
        
                basicAttributeStrengthenValueByIndex = strengthenConfig.ShieldAttributeLv[strengthenLevel]
            elseif data.occupDiffer == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                basicAttributeValueMinByIndex = basicAttributeConfig.minSwordMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxSwordMainAttribute[createLevel]
        
                basicAttributeStrengthenValueByIndex = strengthenConfig.SwordAttributeLv[strengthenLevel]
            elseif data.occupDiffer == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                basicAttributeValueMinByIndex = basicAttributeConfig.minMasterMainAttribute[createLevel]
                basicAttributeValueMaxByIndex = basicAttributeConfig.maxMasterMainAttribute[createLevel]
        
                basicAttributeStrengthenValueByIndex = strengthenConfig.MasterAttributeLv[strengthenLevel]
            end
        end

        local min,max = basicAttributeValueMinByIndex, basicAttributeValueMaxByIndex
        if localData and (not self.createLevel or self.createLevel == 0) then
            min, max = localData.basicAttributeValueMin[i], localData.basicAttributeValueMax[i]
        end

        local attrValue = 0
        if(randomGenerater) then
            attrValue = randomGenerater:random(min, max)
        end
        --是否是转换来的装备
        if localData then
            local rate = attrValue/max
            attrValue = math.floor(basicAttributeValueMaxByIndex * rate) 
        end


        -- local strenghthenValue = basicAttributeStrengthenValue[i]
        -- if DEBUG then
        --     print("EquipmentData:initLocalData attrType,attrValue,strenghthenValue=",attrType,attrValue,strenghthenValue)
        -- end

        local refining = 0
        local isTransform = false
        local isEnchanting = false
        local attrValueType = VALUE_TYPE.Value

        -- 处理强化值
        -- attrValue = attrValue + strenghthenValue * self.fromConvertedGoodsData.strengthenLevel

        local oneEquipment = EquipmentAttr:create()
        oneEquipment:initData(attrType,attrValue,refining,isTransform,isEnchanting,attrValueType)
        if oneEquipment then
            table.insert(self._baseArr,oneEquipment)
        end
    end

    -- TODO 释放随机种子生成器
    if(randomGenerater) then 
        randomGenerater:delete()
        randomGenerater = nil
    end
end


-- 处理添加一条随机属性
function EquipmentData:handleAddOneRandomAttr(v, data)
    if(v == nil ) then return end
 

    local attrType = v.attrType
    local attrBaseValue = v.attrBaseValue
    local attrValueType = v.attrValueType
    -- 这里建立在只有一条附魔属性的情况
    local oneEquipment = EquipmentAttr:create()
    oneEquipment:initData(attrType,attrBaseValue,v.refining,v.isTransform,v.isEnchanting,attrValueType)
    if v.isEnchanting then
        self.enchanting = oneEquipment
    else
        oneEquipment:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV, data)
        table.insert(self._randomArr,oneEquipment)
    end

    self:_refreshCombatScore()
end

-- 处理改造一条随机属性
function EquipmentData:transformAttrByType(attrType)
    for k,v in pairs(self._randomArr) do
        if v.attrType == attrType then
            v.isTransform = true
            break
        end
    end
end


function EquipmentData:initNetData(netData,num,isGolden,isLock,index)

    self:_clear()

    local oldGoodsID = self.goodsID

    self.entityID = netData.entityID
    self.isGolden = isGolden
    self.isLock = isLock
    self.num = num
    self.wearPosition = index

    self.isRecasted = netData.isRecasted
    self.recastNum = netData.recastNum or 0
    self.strengthenLevel = netData.strengthenLevel or 0
    self.remodelNum = netData.remodelNum or 0
    self.fromConverted = netData.fromConverted or 0  
    self.seed = netData.seed or 0
    self.punchNum = netData.punchNum or 0
    self.illusionID = netData.illusionID or 0
    self.isLvRemove = netData.isLvRemove or false
    self.refineNum = netData.refineNum or 0
    self.setChangeNum = netData.setChangeNum or 0
    self.createLevel = (netData.createLevel and netData.createLevel > 0) and netData.createLevel + self.qualityGrade or 0
    -- print("EquipmentData:initNetData entityID,seed, netData.seed=", self.entityID, self.seed, netData.seed)

    -- 紫升红
    self.primogemId = netData.primogemId or 0         --升红装的原石id

    if self.primogemId > 0 then
        local goodsConfig = Config.ConfigGoods:getPrimoGemStone(self.primogemId)
        self.equipSetMark = goodsConfig.equipSetMark
        self.changeEquipID = goodsConfig.equipId

        local configData = ConfigManager:getEquipmentConfigByID(goodsConfig.equipId)
        self.randomName = LanguageManager:getInstance():getLocalString(configData.randomName)
        self.randomGoodsRare = configData.randomGoodsRare

    end

    -- 处理装备的初始化处理
    self:conbinationLocalData()

    -- -- 处理套装属性处理
    -- local setMark = self.equipSetMark
    -- if setMark ~= 0 and setMark ~= nil then
    --     self._equipmentSet = EquipmentSet:create(setMark)
    -- end

    local specialAttr = netData.specialAttr
    if specialAttr then
        -- 处理特殊属性处理
        for k,skillId in ipairs(specialAttr) do
            if(skillId ~= 0) then
                local skillData = SkillDataManager:createSkillForSkillId(skillId)
                if(skillData) then
                    table.insert(self._specialAttr,skillData)
                end
            end
        end
    end

    -- if DEBUG then 
    --     print("-------------------EquipmentData:initNetData random start--------------------",self.goodsID)
    -- end

    -- 处理随机属性
    if netData.attr and #netData.attr >0 then
        for k,v in pairs(netData.attr) do
            self:handleAddOneRandomAttr(v, self)
        end
    end

    -- if DEBUG then 
    --     print("-------------------EquipmentData:initNetData random end--------------------")
    -- end
    -- if DEBUG then 
    --     print("-------------------EquipmentData:initNetData rate start--------------------")
    -- end

    -- 处理百分比词条
    if netData.rateAttr and #netData.rateAttr >0 then
        for k,v in pairs(netData.rateAttr) do
            local attrType = v.attrType
            local attrBaseValue = v.attrBaseValue
            local refining = 0
            local isTransform =false
            local isEnchanting = false
            local attrValueType = v.attrValueType

            -- 这里建立在只有一条附魔属性的情况
            local oneEquipment = EquipmentAttr:create()
            oneEquipment:initData(attrType,attrBaseValue,refining,isTransform,isEnchanting,attrValueType)
            -- oneEquipment:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV)
            if isEnchanting then
                assert(false," there isEnchanting not true " )
                -- self.enchanting = oneEquipment
            else
                table.insert(self._rateArr,oneEquipment)
            end
        end
    end


    -- 装备改造临时属性
    self:setTmpRemodelAttr(netData.tmpRemodelAttr)

    if DEBUG then 
        print("-------------------EquipmentData:initNetData rate end--------------------")
    end

    -- 处理镶嵌宝石信息
    self:resetHoleData(netData.holes)

    -- 处理镶嵌雕文信息
    local glyphs = {}
    if netData.glyphattrData then
        glyphs.glyphTemplateId = netData.glyphTemplateId
        glyphs.glyphattrData = netData.glyphattrData
        glyphs.glyphlastRefineAttrData = netData.glyphlastRefineAttrData
    end
    self:resetGlyphData(glyphs)

    if isGolden and self.randomGoodsRare < GOODS_RARE.RARE_GOLDEN_3 then
        self.randomGoodsRare = GOODS_RARE.RARE_GOLDEN_3
    end

    if self.isGolden == true and self.goodsRare < GOODS_RARE.RARE_GOLDEN_3 then
        self.goodsRare = GOODS_RARE.RARE_GOLDEN_3
    end

    -- 计算最终的属性值
    self:refreshEndAttr()

    self:_refreshCombatScore()
end

---------
function EquipmentData:resetGlyphData(glyphs)
    table.clear(self._glyphDataArr)
    if(glyphs and glyphs.glyphattrData) then 
        if #glyphs.glyphattrData > 0 then
            local index = 1
            --for _,glyph in ipairs(glyphs) do 
                local netData = {}
                netData.attrData = glyphs.glyphattrData
                netData.lastRefineAttrData = glyphs.glyphlastRefineAttrData
                local glyphData = EquipmentGlyphData:create(glyphs.glyphTemplateId)
                glyphData:initData(netData, index)
                table.insert(self._glyphDataArr, glyphData)
                --index = index + 1
            --end
        end

    end
    self:_refreshCombatScore()
end

-- 获取雕文数据
function EquipmentData:getGlyphDatas()
    -- body
    return self._glyphDataArr
end

-- 获取解锁的列表
function EquipmentData:getUnLockGlyphDatas()
    -- body
    local lockArr = {}
    for k,glyphData in ipairs(self._glyphDataArr) do 
        table.insert(lockArr, glyphData)
    end

    return lockArr
end

-- 判断是否有雕文
function EquipmentData:haveGlyph()
    if(self._glyphDataArr) then 
        for k,glyphData in ipairs(self._glyphDataArr) do 
            if(glyphData and glyphData:getGlyphData()) then
                return true
            end
        end
    end
    
    return false
end
---------

function EquipmentData:resetHoleData(holes)
    table.clear(self._holeDataArr)
    print("EquipmentData:resetHoleData", holes)

    if(holes and #holes>0) then 
        local index = 1
        for _,hole in ipairs(holes) do 
            local holeData = EquipmentHoleData:create()
            holeData:initData(hole, index)
            table.insert(self._holeDataArr, holeData)
            index = index + 1
        end

        self:_refreshCombatScore()
    end
end

-- 获取插槽数据
function EquipmentData:getHoleDatas()
    -- body
    return self._holeDataArr
end

-- 获取解锁的列表
function EquipmentData:getUnLockHoleDatas()
    -- body
    local lockArr = {}
    for k,holeData in ipairs(self._holeDataArr) do 
        if(holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then 
            if(self:getIsUnlockColorHole()) then 
                table.insert(lockArr, holeData)
            end
        else 
            table.insert(lockArr, holeData)
        end
        
    end

    return lockArr
end

-- 获取是否有彩色孔
function EquipmentData:getIsHaveColourfulHole()
    for k,holeData in ipairs(self._holeDataArr) do 
        if(holeData:getHoleType() == PublicDefine.GemStoneType.GemStoneType_Colourful) then 
            return true
        end
    end

    return false
end

-- 判断是否有宝石
function EquipmentData:haveGemStone()
    if(self._holeDataArr) then 
        for k,holeData in ipairs(self._holeDataArr) do 
            if(holeData and holeData:getGemStoneData()) then
                return true
            end
        end
    end
    
    return false
end

function EquipmentData:getBytesData()
    local ProtobufUtil = require "utils.ProtobufUtil"
    local decodeData = ProtobufUtil:decode("GoodsSystem.EquipmentData", self.BytesData)

    if not decodeData then
        return
    end

    --刷新 最新数据
    decodeData.strengthenLevel = self.strengthenLevel--强化等级
    
    local attr = {}
    for k,v in ipairs(self._randomArr) do
        local data = {}
        data.attrType = v.attrType
        data.attrBaseValue = v.attrBaseValue--装备属性值(没有计算强化等级,精炼相关的基础值) 
        data.refining = v.refining --//精炼值（百分比）需要除以100 和类型一起使用区间区分是否大成
        data.isTransform = v.isTransform --是否改造过（改造后精炼状态消失）
        data.isEnchanting = v.isEnchanting  --是否附魔
        data.attrValueType = v.attrValueType
        table.insert(attr, data)
    end

    if(self.enchanting) then
        local data = {}
        data.attrType = self.enchanting.attrType
        data.attrBaseValue = self.enchanting.attrBaseValue--装备属性值(没有计算强化等级,精炼相关的基础值) 
        data.refining = self.enchanting.refining --//精炼值（百分比）需要除以100 和类型一起使用区间区分是否大成
        data.isTransform = self.enchanting.isTransform --是否改造过（改造后精炼状态消失）
        data.isEnchanting = true  --是否附魔
        data.attrValueType = self.enchanting.attrValueType
        table.insert(attr, data)
    end

    decodeData.attr = attr--属性列表 PublicDefine.EquipmentAttr
    
    local rateAttr = {}
    for k, v in ipairs(self._rateArr) do
        local data = {}
        data.attrType = v.attrType
        data.attrBaseValue = v.attrBaseValue--装备属性值(没有计算强化等级,精炼相关的基础值) 
        data.refining = v.refining --//精炼值（百分比）需要除以100 和类型一起使用区间区分是否大成
        data.isTransform = v.isTransform --是否改造过（改造后精炼状态消失）
        data.isEnchanting = v.isEnchanting  --是否附魔
        data.attrValueType = v.attrValueType
        table.insert(rateAttr, data)
    end
    decodeData.rateAttr = rateAttr

    local specialAttr = {}
    for k,v in ipairs(self._specialAttr) do
        table.insert(specialAttr,v:getSkillID())
    end
    decodeData.specialAttr = specialAttr--专有属性
    decodeData.remodelNum = self.remodelNum -- 改造次数
    decodeData.isRecasted = self.isRecasted --是否重铸过
    decodeData.recastNum = self.recastNum--重铸次数
    decodeData.illusionID = self.illusionID --装备的幻化ID
    decodeData.punchNum = self.punchNum --//开孔次数
    decodeData.fromConverted = self.fromConverted  --是否从转换而来
    decodeData.isLvRemove = self.isLvRemove
    decodeData.refineNum = self.refineNum

    decodeData.primogemId = self.primogemId


    local holeDatas = self:getHoleDatas()
    if(holeDatas) then --插槽属性
        local netHoles = {}
        for k, holeData in pairs(holeDatas) do 
            local netHole = {}
            netHole.holeType = holeData.holeType
            netHole.gemStoneID = holeData.gemStoneID
            netHole.viceGemStoneID = holeData.viceGemStoneID
            table.insert(netHoles, netHole)
        end
        decodeData.holes = netHoles
    end

    local glyphDatas = self:getGlyphDatas()
    if(glyphDatas) then --雕文属性
        local netGlyphs = {}
        for k, glyph in pairs(glyphDatas) do 
            -- local netGlyph = {}
            -- netGlyph = glyphData:getGoodsID()
            -- netGlyph. = glyphData.
            -- netGlyph. = glyphData.
            -- table.insert(netGlyphs, netGlyph)
            local glyphData = glyph:getGlyphData()

            decodeData.glyphTemplateId = glyphData:getGoodsID()
            decodeData.glyphattrData = glyphData.attrData
            decodeData.glyphlastRefineAttrData = glyphData.lastAttrData
        end
        --decodeData.glyphs = netGlyphs
    end

    self.BytesData =  ProtobufUtil:encode("GoodsSystem.EquipmentData", decodeData)   
    return self.BytesData
end

-- 刷新强化等级带来的属性变化
function EquipmentData:refreshStrengthenLevel()
    -- print("EquipmentData:refreshStrengthenLevel  ", self.strengthenLevel)
    --TODO 这里可以优化处理
    self:conbinationLocalData()

    -- 刷新随机属性
    for k,oneEquipment in pairs(self._randomArr) do
        oneEquipment:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV, self)
    end

    if self._tmpRemodelAttr then
        self._tmpRemodelAttr:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV, self)
    end

    -- -- 刷新百分比词条
    -- for k,oneEquipment in pairs(self._rateArr) do
    --     oneEquipment:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV)
    -- end

    -- -- 附魔属性
    -- if self.enchanting then
    --     self.enchanting:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV)
    -- end

    self:_refreshCombatScore()
end

function EquipmentData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getEquipmentConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            printError(string.format("EquipmentData:conbinationLocalData  %d no found local data ",self.goodsID))
        end
    end
end

-- 刷新一下最终的属性
function EquipmentData:refreshEndAttr()
    -- TODO 刷新最终的属性

end

function EquipmentData:getSeed()
    return self.seed
end

function EquipmentData:setSeed(seed)
    if(seed == nil) then 
        return 
    end
    self.seed = seed
    self:conbinationLocalData()
end

function EquipmentData:print()
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

function EquipmentData:_clear()
    -- TODO 这里采用暴力清空，后续需要优化处理
    self.goodsRare = nil

    self._baseArr = {}
    self._randomArr = {}
    self._rateArr = {}

    self.enchanting = nil
    self._specialAttr = {}
    self._holeDataArr = {}
    self._glyphDataArr = {}
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

function EquipmentData:_refreshCombatScore()
    self.combatScore = nil
    if self.createLevel and self.createLevel > 0 and self.combatScore == 0 then
        local createLevel = clone(self.createLevel)
        local levelLimiteList = string.split(self.equipRequireLvIntervals, ";")
        local levelLimite = string.split(levelLimiteList[6], ",")
        local lowerLimite = tonumber(levelLimite[1])
        local upperLimite = tonumber(levelLimite[2])
        
        createLevel = math.max(createLevel, lowerLimite + self.qualityGrade)
        createLevel = math.min(createLevel, upperLimite + self.qualityGrade)

        self.combatScore = ConfigManager:getCombatScoreByID(createLevel).combatScoreLv
    else
        self.combatScore = self.combatScore
    end
    
    if not self.combatScore then
        self.combatScore = 0
    end
    local startCombatScore = self.combatScore
    local combatScoreRate = GameDataManager:getInstance():getCombatScoreRate()


    -- for k,equipmentAttr in pairs(self._baseArr) do
        -- if(combatScoreRate[equipmentAttr:getAttrType()]) then 
    --     print("EquipmentData:_refreshCombatScore =",equipmentAttr:getAttrType(),combatScoreRate[equipmentAttr:getAttrType()],equipmentAttr:getAttrValue())
    --      self.combatScore = self.combatScore + math.floor(combatScoreRate[equipmentAttr:getAttrType()] * equipmentAttr:getAttrValue()/RATIO_NUMBER)
        -- end 
    -- end

    for k,equipmentAttr in pairs(self._randomArr) do
        if(combatScoreRate and combatScoreRate[equipmentAttr:getAttrType()]) then 
            -- print("EquipmentData:_refreshCombatScore =",equipmentAttr:getAttrType(),combatScoreRate[equipmentAttr:getAttrType()],equipmentAttr:getAttrValue())
            self.combatScore = self.combatScore + math.floor(combatScoreRate[equipmentAttr:getAttrType()] * equipmentAttr:getAttrValue()/RATIO_NUMBER)
        end
    end

    if self.enchanting then
        if(combatScoreRate and combatScoreRate[self.enchanting:getAttrType()]) then 
            self.combatScore = self.combatScore + math.floor(combatScoreRate[self.enchanting:getAttrType()] * self.enchanting:getAttrValue()/RATIO_NUMBER)
        end 
    end

    -- 添加宝石的战力
    local holeDatas = self:getHoleDatas()
    if(holeDatas) then 
        for k, holeData in pairs(holeDatas) do 
            local gemStoneData = holeData:getGemStoneData()
            if(gemStoneData) then
                self.combatScore = self.combatScore + gemStoneData:getCombatScore()
            end
        end
    end

    -- 添加雕文的战力
    local glyphDatas = self:getGlyphDatas()
    if(glyphDatas) then 
        for k, glyph in pairs(glyphDatas) do 
            local glyphData = glyph:getGlyphData()
            if(glyphData) then
                self.combatScore = self.combatScore + glyphData:getCombatScore()
            end
        end
    end

    if DEBUG then
        print(" EquipmentData:_refreshCombatScore  combatScore=",startCombatScore,self.combatScore)
    end
end

function EquipmentData:_refreshEquipmentType()
    if self.goodsID then
        local equipType = AvalonUtil.getEquipmentTypeFromID(self.goodsID)
        if (equipType == EQUIPMENT_TYPE.Weapon) then
            self:_refreshWeaponType()
        end
        self.equipmentType = equipType
    end
end

function EquipmentData:_refreshWeaponType()
    self._weaponType = tonumber(self.remarksField[1])
end

--更新强化等级
function EquipmentData:updateStrengthenLevel(strengthenLevel)
    self.strengthenLevel = strengthenLevel
    self:refreshStrengthenLevel()
end

-- 获取是否获得
function EquipmentData:getWasGet()
    -- body
    if(self.seed == -1) then 
        return false
    end 
    return true
end

function EquipmentData:getRemodelAttr()
    local list = {}
    for k, v in ipairs(self._randomArr) do
        if v.isTransform then
            table.insert(list, v)
            break
        end
    end
    return list
end

function EquipmentData:replaceRemodelInheritAttr(inheritAttr, baseAttrType)
    for k,v in pairs(self._randomArr) do
        if v.attrType == baseAttrType then
            v.attrType = inheritAttr.attrType
            v.attrBaseValue = inheritAttr.attrBaseValue--装备属性值(没有计算强化等级,精炼相关的基础值) 
            v.refining = inheritAttr.refining --//精炼值（百分比）需要除以100 和类型一起使用区间区分是否大成
            v.isEnchanting = inheritAttr.isEnchanting  --是否附魔
            v.attrValueType = inheritAttr.attrValueType
            v.isTransform = true
            v:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV,self)
            break
        end
    end
    self:_refreshCombatScore()
end

function EquipmentData:setTmpRemodelAttr(netAttr, isAddCount)
    if netAttr and netAttr.attrType ~= 0 then
        local oneEquipment = EquipmentAttr:create()
        oneEquipment:initData(netAttr.attrType, netAttr.attrBaseValue, netAttr.refining, netAttr.isTransform, netAttr.isEnchanting, netAttr.attrValueType)
        oneEquipment:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV,self)
        self._tmpRemodelAttr = oneEquipment
        if isAddCount then
            self.remodelNum = self.remodelNum + 1
        end
    end
end

function EquipmentData:getTmpRemodelAttr()
    local list = {}
    for k, v in ipairs(self._randomArr) do
        if v.isTransform then
            table.insert(list, v)
            break
        end
    end

    if self._tmpRemodelAttr then
        table.insert(list, self._tmpRemodelAttr)
    end
    return list
end

function EquipmentData:replaceTmpRemodelAttr(attrType)
    if self._tmpRemodelAttr == nil then
        return
    end
    for k,v in pairs(self._randomArr) do
        if v.attrType == attrType then
            v.attrType = self._tmpRemodelAttr.attrType
            v.attrBaseValue = self._tmpRemodelAttr.attrBaseValue--装备属性值(没有计算强化等级,精炼相关的基础值) 
            v.refining = self._tmpRemodelAttr.refining --//精炼值（百分比）需要除以100 和类型一起使用区间区分是否大成
            v.isEnchanting = self._tmpRemodelAttr.isEnchanting  --是否附魔
            v.attrValueType = self._tmpRemodelAttr.attrValueType
            v.isTransform = true
            v:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV,self)
            break
        end
    end
    self:_refreshCombatScore()
    self._tmpRemodelAttr = nil
end

function EquipmentData:clearTmpRemodelAttr()
    self._tmpRemodelAttr = nil
end

function EquipmentData:isHaveTmpRemodelAttr()
    local haveTransform = false
    for k, v in ipairs(self._randomArr) do
        if v.isTransform then
            haveTransform = true
            break
        end
    end
    if not haveTransform then
        return false
    end
    if self._tmpRemodelAttr == nil then
        return false
    end
    return true
end

function EquipmentData:getRemodelCount()
    return self.remodelNum
end

function EquipmentData:getIllusionID()
    return self.illusionID
end

function EquipmentData:setIllusionID(id)
    self.illusionID = id or 0
end

function EquipmentData:setPrimogemID(id)
    self.primogemId = id or 0
end

function EquipmentData:getIsRemoveLevel()
    if(self.equipLevelRemoveConfig) then 
        return true
    end 

    return false
end

function EquipmentData:getEquipRemoveConfig()
    return self.equipLevelRemoveConfig
end

function EquipmentData:getEquipRecastData()
    return ConfigManager:getEquipRecastById(self.goodsID)
end

function EquipmentData:updateEquipByPrimogem(primogemId)
    self.primogemId = primogemId
    self.goodsRare = self.goodsRare + 1

    if self.primogemId > 0 then
        local goodsConfig = Config.ConfigGoods:getPrimoGemStone(self.primogemId)
        self.equipSetMark = goodsConfig.equipSetMark
        self.changeEquipID = goodsConfig.equipId

        local configData = ConfigManager:getEquipmentConfigByID(goodsConfig.equipId)
        self.randomGoodsRare = configData.randomGoodsRare

        if self.isGolden and self.randomGoodsRare < GOODS_RARE.RARE_GOLDEN_3 then
            self.randomGoodsRare = GOODS_RARE.RARE_GOLDEN_3
        end

        self:updateStarPrayEquipmentSet()
    end
end

function EquipmentData:resetEquipByPrimogem()
    if self.primogemId ~= 0 then
        self.goodsRare = self.goodsRare - 1
        self.primogemId = 0

        self.icon = self:_getIconName()

        self.changeEquipID = 0

        local configData = ConfigManager:getEquipmentConfigByID(self.goodsID)
        self.equipSetMark = configData.equipSetMark
        self.randomGoodsRare = configData.randomGoodsRare
        self.randomName = configData.randomName

        if self.isGolden and self.randomGoodsRare < GOODS_RARE.RARE_GOLDEN_3 then
            self.randomGoodsRare = GOODS_RARE.RARE_GOLDEN_3
        end

        self:updateStarPrayEquipmentSet()
        self._equipmentSet = nil
    end
end



function EquipmentData:getPrimogemId()
    return self.primogemId
end

function EquipmentData:createEquipmentAttr(netAttr)
    local oneEquipment = EquipmentAttr:create()
    oneEquipment:initData(netAttr.attrType, netAttr.attrBaseValue, netAttr.refining, netAttr.isTransform, netAttr.isEnchanting, netAttr.attrValueType)
    oneEquipment:calculationEndValue(self.strengthenLevel, self.randAttributeStrengthenLV,self)
    return oneEquipment
end

function EquipmentData:getName()
    if self.createLevel and self.createLevel > 0 then
        return self.randomName
    else
        return self.name
    end
end

function EquipmentData:createEquipmentPrimogemAttr(netAttr)
    local oneEquipment = EquipmentAttr:create()
    oneEquipment:initData(netAttr.attrType, netAttr.attrBaseValue, false, false, false, netAttr.attrValueType)
    return oneEquipment
end

-- 判断是否可以卖或者销毁
function EquipmentData:getIsSellOrDestory()
    local canSell = true
    if self.createLevel and self.createLevel > 0 and self.primogemId > 0 then
        canSell = false
    end
    return canSell
end
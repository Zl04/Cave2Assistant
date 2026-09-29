--[[
    宠物宝石属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local PetStoneData = class("PetStoneData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"
local GameDataManager = require("app.game.GameDataManager")

local GemStoneType = PublicDefine.GemStoneType

Goods = Goods or {}

Goods.PetStoneData = PetStoneData

local GOODS_RARE = PublicDefine.GOODS_RARE

function PetStoneData:ctor(goodsID, slotIndex)
    PetStoneData.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_PET_STONE)

    self.goodsID = goodsID
    self.slotIndex = slotIndex or 0
    self.num = 1
    self.isGolden = false
    self.combatScore = 0
    self.level = 1
    self.exp = 0
    self.attrList = {}
    self:conbinationLocalData()
    self:refreshAttr()
    self:refreshCombatScore()
end 

-- 获取物品名字
function PetStoneData:getName()
    return LanguageManager:getInstance():getLocalString(self.name)
end

function PetStoneData:getIconName()
    if self.icon == nil or self.icon == "" then
        self.icon = self:_getIconName()
    end
    return self.icon
end

-- 获取物品描述
function PetStoneData:getDescription()
    -- TODO 这里根据类型获取描述信息
    return ""
end


function PetStoneData:getEntityID()
    return self.entityID
end

function PetStoneData:getEquipmentID()
    return self.equipId
end

function PetStoneData:getSlotIndex()
    return self.slotIndex
end

-- 获取宝石特殊技能详情
function PetStoneData:getSpecialDetailDescription()
    if(self.specialAttribute and self.specialAttribute ~= 0 and self.effectDes and self.effectDes ~= 0) then
        return PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(self.effectDes), self.specialAttribute)
    end 

    return  nil
end

function PetStoneData:getNum()
    if self.num == nil then
        return 1
    end
    return self.num;
end

-- 获取宝石战力评分
function PetStoneData:getCombatScore()
    if self.combatScore == 0 then 
        self:refreshCombatScore()
    end
    return self.combatScore
end

function PetStoneData:getLevel()
    return self.level
end

function PetStoneData:initLocalData(data)
    self:setLocalConfigData(data)
end

function PetStoneData:initNetData(netData,num,isGolden,isLock,index,equipId)
    local oldGoodsID = self.goodsID
    self.goodsRare = nil
    self.isGolden = isGolden or false
    self.isLock = isLock or false

    self.entityID = netData.entityID or 0
    self.level = netData.level or 0
    self.exp = netData.exp or 0
    self.equipId = equipId or 0
    self.index = index

    -- 处理装备的初始化处理
    if oldGoodsID ~= self.goodsID then
        self:conbinationLocalData()
    end
    self:refreshAttr()
    self:refreshCombatScore()
    
end

function PetStoneData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getPetGemstoneConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("GemStoneData:conbinationLocalData  goodsID=%d no found local data ",self.goodsID))
        end
    end
end

function PetStoneData:refreshAttr()
    local attrList = {}
    if self.value ~= "" then
        local valueList = string.split(self.value, ";")
        valueList = string.split(valueList[self.level] or "", ",") or {}
        local attrGroup = string.split(self.attrGroup, ";") or {}
        for k, v in ipairs(attrGroup) do
            local data = {}
            data.type = checkint(v)
            data.value = checkint(valueList[k])
            data.valueType = PublicDefine.VALUE_TYPE.Value
            table.insert(attrList, data)
        end
    end

    if self.percentValue ~= "" then
        local valueList = string.split(self.percentValue, ";")
        valueList = string.split(valueList[self.level] or "", ",") or {}
        local percentGroup = string.split(self.percentGroup, ";") or {}
        for k, v in ipairs(percentGroup) do
            local data = {}
            data.type = checkint(v)
            data.valueType = PublicDefine.VALUE_TYPE.Rate
            data.value = checkint(valueList[k])
            table.insert(attrList, data)
        end
    end

    if self.awakeAttrList ~= "" then
        local valueList = string.split(self.awakeAttr, ";") or {}
        local attrGroup = string.split(self.awakeAttrList, ";") or {}
        for k, v in ipairs(attrGroup) do
            local data = {}
            data.type = checkint(v)
            data.valueType = PublicDefine.VALUE_TYPE.Rate
            data.value = checkint(valueList[k])
            table.insert(attrList, data)
        end
    end

    self.attrList = attrList

end

-- 获取宝石普通详情
function PetStoneData:getNormalDetailDescription()
    local desArr = {}
    for k, data in pairs(self.attrList) do 
        local oneAttr = {}
        table.insert(oneAttr, ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[data.type]))
        if(data.valueType == PublicDefine.VALUE_TYPE.Value) then 
            local endStr, valueType = ToolsUtil:calculationAttrShowValue(data.type, data.value)
            table.insert(oneAttr,string.format("%s", endStr))
        else 
            table.insert(oneAttr,string.format("%.2f%%",data.value / 100))
        end
        table.insert(desArr, oneAttr)
    end
    return desArr
end

function PetStoneData:setExp(exp)
    self.exp = exp
end

function PetStoneData:setLevel(level)
    if self.level ~= level then
        self.level = level
        self:refreshAttr()
        self:refreshCombatScore()
    end
end

function PetStoneData:setIndex(index)
    self.index = index
end


function PetStoneData:refreshCombatScore()
    if self.valuation then
        self.combatScore = self.valuation[self.level] or self.valuation[#self.valuation]
    end
end

function PetStoneData:isMaxLevel()
    if self:getMaxLevel() <= self.level then
        return true
    end
    return false
end

function PetStoneData:getMaxLevel()
    return self.maxLevel
end

function PetStoneData:getExp()
    local expList = string.split(self.needExp, ";")
    local needExp = expList[self.level] or expList[#expList]
    return self.exp, needExp
end

function PetStoneData:getDistanceMaxExp()
    local expList = string.split(self.needExp, ";")
    local needExp = expList[self.level] or expList[#expList]

    local preExp = needExp - self.exp

    if self.level < #expList then
        for i = self.level + 1, #expList do
            local lcExp = expList[i]
            preExp = preExp + lcExp
        end
    end

    return preExp
end

function PetStoneData:budgetNeedLevel(addExp)
    local exp = self.exp + addExp
    local level = self.level

    local expList = string.split(self.needExp, ";")
    local mosaicLevel = string.split(self.mosaicLevel, ";")

    local fLevel = #expList
    for i = level, #expList do
        local lcExp = expList[i]
        exp = exp - lcExp
        if exp < 0 then
            fLevel = i
            break
        end
    end

    local needLevel = tonumber(mosaicLevel[fLevel])
    return needLevel
end

function PetStoneData:howMuchExp()
    local exp = self.devourExp
    exp = exp + self.exp

    if self.needExp ~= "" then
        local expList = string.split(self.needExp, ";")

        for k,v in ipairs(expList) do
            if k < self.level and v ~= "" then
                exp = exp + tonumber(v)
            end
        end
    end

    return exp
end

function PetStoneData:getRequireLevel()
    local mosaicLevel = string.split(self.mosaicLevel, ";")
    local needLevel = tonumber(mosaicLevel[self.level] or mosaicLevel[#mosaicLevel])

    return needLevel
end

function PetStoneData:getSwallowExp()
    local devourExp = self.devourExp
    return devourExp
end

function PetStoneData:getMaxExp()
    -- local maxExp = self.giveexp[#self.giveexp]
    -- return maxExp
    return 0
end

function PetStoneData:getGemStoneType()
    return self.gemStoneType
end



function PetStoneData:getBytesData()
    local ProtobufUtil = require "utils.ProtobufUtil"
    local decodeData = {}
    --刷新 最新数据
    decodeData.entityID = self.entityID
    decodeData.level = self.level
    decodeData.exp = self.exp
    
    local bytesData =  ProtobufUtil:encode("GoodsSystem.PetGemStoneData", decodeData)   
    return bytesData
end

function PetStoneData:getIsExpType()
    -- print("  self.gemstoneType ==== ",self.gemstoneType,self.percentGroup)
    if self.gemstoneType > 0 then return true end 
    
    return false
end

function PetStoneData:canEvolution()
    local _,maxExp = self:getExp()
    local needMaxLevel = tonumber(maxExp) == 0;
    local needRare = self.goodsRare >= PublicDefine.GOODS_RARE.RARE_DARKRED

    if (self.goodsRare == PublicDefine.GOODS_RARE.RARE_DARKRED and needMaxLevel and self.upgradeItem ~= 0) then
        return true
    elseif (self.goodsRare > PublicDefine.GOODS_RARE.RARE_DARKRED and self.upgradeItem ~= 0) then
        return true
    end

    if self.goodsRare > PublicDefine.GOODS_RARE.RARE_DARKRED and self.upgradeItem == 0 then
        return false, true
    end

    return false

end

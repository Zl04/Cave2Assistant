--[[
    宝石属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local StarPrayData = class("StarPrayData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"
local GameDataManager = require("app.game.GameDataManager")

local GemStoneType = PublicDefine.GemStoneType

Goods = Goods or {}

Goods.StarPrayData = StarPrayData

local GOODS_RARE = PublicDefine.GOODS_RARE

function StarPrayData:ctor(goodsID)
    StarPrayData.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY)

    self.goodsID = goodsID
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
function StarPrayData:getName()
    return self.name
end

function StarPrayData:getIconName()
    if self.icon == nil or self.icon == "" then
        self.icon = self:_getIconName()
    end
    return self.icon
end

-- 获取物品描述
function StarPrayData:getDescription()
    -- TODO 这里根据类型获取描述信息
    return ""
end

-- 获取宝石普通详情
function StarPrayData:getNormalDetailDescription()
    local attrTypeArr = self.attrType
    local valueTypeArr = self.valueType
    local valueArr = self.value

    local desArr = {}

    for i=1,#attrTypeArr do 
        local oneAttr = {}
        table.insert(oneAttr, ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[attrTypeArr[i]]))

        if(valueTypeArr[i] == PublicDefine.VALUE_TYPE.Value) then 
            local endStr, valueType = ToolsUtil:calculationAttrShowValue(attrTypeArr[i], valueArr[i])
            table.insert(oneAttr,string.format("%s", endStr))
        else 
            table.insert(oneAttr,string.format("%.2f%%",(valueArr[i]/10000)* 100))
        end

        table.insert(desArr, oneAttr)
    end

    return desArr
end


function StarPrayData:getEntityID()
    return self.entityID
end
-- 获取宝石特殊技能详情
function StarPrayData:getSpecialDetailDescription()
    if(self.specialAttribute ~= 0) then
        return PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(self.effectDes), self.specialAttribute)
    end 

    return  nil
end

function StarPrayData:getNum()
    if self.num == nil then
        return 1
    end
    return self.num;
end

-- 获取宝石战力评分
function StarPrayData:getCombatScore()
    if self.combatScore == 0 then 
        self:refreshCombatScore()
    end
    return self.combatScore
end

function StarPrayData:getLevel()
    return self.level
end

function StarPrayData:initLocalData(data)
    self:setLocalConfigData(data)
end

function StarPrayData:initNetData(netData,num,isGolden,isLock,index)
    local oldGoodsID = self.goodsID
    self.goodsRare = nil
    self.isGolden = isGolden or false
    self.isLock = isLock or false

    self.entityID = netData.entityID
    self.level = netData.lv or 0
    self.exp = netData.exp or 0
    self.belong = netData.belong or 0 --所属星盘(星盘ID)
    self.index = index

    -- 处理装备的初始化处理
    if oldGoodsID ~= self.goodsID then
        self:conbinationLocalData()
    end
    self:refreshAttr()
    self:refreshCombatScore()
    
end

function StarPrayData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getStarPrayConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("GemStoneData:conbinationLocalData  goodsID=%d no found local data ",self.goodsID))
        end
    end
end

function StarPrayData:refreshAttr()
    local attrList = {}
    local valueList = string.split(self.attrValue, ";")
    valueList = string.split(valueList[self.level] or "", ",") or {}
    for k, v in ipairs(self.attrGroup) do
        local data = {}
        data.type = checkint(v)
        data.value = checkint(valueList[k])
        data.valueType = PublicDefine.VALUE_TYPE.Value
        table.insert(attrList, data)
    end

    local valueList = string.split(self.percentValue, ";")
    valueList = string.split(valueList[self.level] or "", ",") or {}
    for k, v in ipairs(self.percentGroup) do
        local data = {}
        data.type = checkint(v)
        data.valueType = PublicDefine.VALUE_TYPE.Rate
        data.value = checkint(valueList[k])
        table.insert(attrList, data)
    end
    self.attrList = attrList
end

function StarPrayData:setExp(exp)
    self.exp = exp
end

function StarPrayData:setLevel(level)
    if self.level ~= level then
        self.level = level
        self:refreshAttr()
        self:refreshCombatScore()
    end
end

function StarPrayData:setIndex(index)
    self.index = index
end


function StarPrayData:refreshCombatScore()
    self.combatScore = self.valuation[self.level] or self.valuation[#self.valuation]
end

-- 获取宝石普通详情
function StarPrayData:getNormalDetailDescription()
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

function StarPrayData:isMaxLevel()
    if self:getMaxLevel() <= self.level then
        return true
    end
    return false
end

function StarPrayData:getMaxLevel()
    if self.needexp then
        return #self.needexp
    end
    return 0
end

function StarPrayData:getExp()
    local needExp = self.needexp[self.level] or self.needexp[#self.needexp]
    return self.exp, needExp
end

function StarPrayData:getSwallowExp()
    local giveexp = self.giveexp[self.level] or self.giveexp[#self.giveexp]
    return giveexp
end

function StarPrayData:getMaxExp()
    local maxExp = self.giveexp[#self.giveexp]
    return maxExp
end

--所属星痕ID
function StarPrayData:getBelong()
    return self.belong
end

function StarPrayData:setBelong(starPlate)
    self.belong = starPlate
end


function StarPrayData:getBytesData()
    local ProtobufUtil = require "utils.ProtobufUtil"
    local decodeData = {}
    --刷新 最新数据
    decodeData.entityID = self.entityID
    decodeData.lv = self.level
    decodeData.exp = self.exp
    local bytesData =  ProtobufUtil:encode("GoodsSystem.StarPrayData", decodeData)   
    return bytesData
end

function StarPrayData:getIsExpType()
    if #self.attrGroup == 0 then return true end 
    
    return false
end

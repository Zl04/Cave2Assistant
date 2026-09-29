--[[
    宝石属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local GemStoneData = class("GemStoneData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"

local GemStoneType = PublicDefine.GemStoneType

Goods = Goods or {}

Goods.GemStoneData = GemStoneData

local GOODS_RARE = PublicDefine.GOODS_RARE

function GemStoneData:ctor(goodsID)
    GemStoneData.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)

    self.goodsID = goodsID
    self.num = 0
    self.isGolden = false
    self.isEquiped = false
    self.isWear = false
    self.equipEntityId = 0
    self.equipSlotIdx = 0
    self.viceGemStoneID = 0
    
    self:conbinationLocalData()
    self:_refreshGemStoneType()

    self._makeGoodsData = nil
end 

-- 获取物品名字
function GemStoneData:getName()

    return self.name
end

function GemStoneData:getIconName()
    if self.icon == nil or self.icon == "" then
        self.icon = self:_getIconName()
    end
    
    return self.icon
end

-- 获取物品描述
function GemStoneData:getDescription()
    -- TODO 这里根据类型获取描述信息
    return ""
end

-- 获取宝石普通详情
function GemStoneData:getNormalDetailDescription()
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

-- 链接宝石详情
function GemStoneData:getLinkDetailDescription(onlyPreviewViceGemStoneID)
    local isUnlock = false
    local desArr = {}
    local viceGemStoneID = self.viceGemStoneID
    if onlyPreviewViceGemStoneID then
        viceGemStoneID = onlyPreviewViceGemStoneID
    end
    if viceGemStoneID ~= 0 then
        isUnlock = true
        local goodsData = Goods.GemStoneData:create(viceGemStoneID)
        if goodsData then
            local connectAttrTypeTable = string.split(self.connectAttrType, ";")
            local levelDifference = #connectAttrTypeTable - (self.gemstoneLV - goodsData.gemstoneLV)
            if levelDifference > 0 then
                local connectValueTypeTable = string.split(self.valueType2, ";")
                local connectValueTable = string.split(self.connectAttrRatio, ";")
                if levelDifference > #connectAttrTypeTable then
                    levelDifference = #connectAttrTypeTable
                end

                if #connectAttrTypeTable == #connectValueTypeTable and #connectValueTypeTable == #connectValueTable then
                    local attrTypeArr = string.split(connectAttrTypeTable[levelDifference], ",")
                    local valueTypeArr = string.split(connectValueTypeTable[levelDifference], ",")
                    local valueArr = string.split(connectValueTable[levelDifference], ",")

                    if #attrTypeArr == #valueTypeArr and #valueTypeArr == #valueArr and #valueArr > 0 and valueArr[1] ~= "" then
                        for i=1,#attrTypeArr do 
                            local oneAttr = {}
                            table.insert(oneAttr, ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[tonumber(attrTypeArr[i])]))
                    
                            if(valueTypeArr[i] == PublicDefine.VALUE_TYPE.Value) then 
                                local endStr, valueType = ToolsUtil:calculationAttrShowValue(tonumber(attrTypeArr[i]), tonumber(valueArr[i]))
                                table.insert(oneAttr,string.format("%s", endStr))
                            else 
                                table.insert(oneAttr,string.format("%.2f%%",(tonumber(valueArr[i])/10000)* 100))
                            end
                    
                            table.insert(desArr, oneAttr)
                        end
                    end
                end

            end
        end
    else
        local connectAttrTypeTable = string.split(self.connectAttrType, ";")
        local connectValueTypeTable = string.split(self.valueType2, ";")
        local connectValueTable = string.split(self.connectAttrRatio, ";")
        
        if #connectAttrTypeTable == #connectValueTypeTable and #connectValueTypeTable == #connectValueTable 
        and #connectAttrTypeTable > 0 and connectAttrTypeTable[1] ~= "" then
            local i = 1
            local j = #connectAttrTypeTable
            local attrTypeArr = string.split(connectAttrTypeTable[i], ",")
            local valueTypeArr = string.split(connectValueTypeTable[i], ",")
            local valueArr = string.split(connectValueTable[i], ",")
            local attrTypeArr2 = string.split(connectAttrTypeTable[j], ",")
            local valueTypeArr2 = string.split(connectValueTypeTable[j], ",")
            local valueArr2 = string.split(connectValueTable[j], ",")
            if #attrTypeArr == #valueTypeArr and #valueTypeArr == #valueArr and #valueArr > 0 and 
                #attrTypeArr2 == #valueTypeArr2 and #valueTypeArr2 == #valueArr2 and #valueArr2 > 0 
                and valueArr[1] ~= "" and valueArr2[1] ~= "" then

                for m=1,#attrTypeArr do
                    local oneAttr = {}
                    table.insert(oneAttr, ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[tonumber(attrTypeArr[m])]))
            
                    if(valueTypeArr[m] == PublicDefine.VALUE_TYPE.Value) then 
                        local endStr = ToolsUtil:calculationAttrShowValue(tonumber(attrTypeArr[m]), tonumber(valueArr[m]))
                        local endStr2 = ToolsUtil:calculationAttrShowValue(tonumber(attrTypeArr2[m]), tonumber(valueArr2[m]))
                        table.insert(oneAttr,string.format("%s-%s", endStr, endStr2))
                    else
                        table.insert(oneAttr,string.format("%.2f%%-%.2f%%",(tonumber(valueArr[m])/10000)* 100,(tonumber(valueArr2[m])/10000)* 100))
                    end
            
                    table.insert(desArr, oneAttr)
                end

            end
        end
    end
    

    return desArr,isUnlock
end

-- 获取宝石特殊技能详情
function GemStoneData:getSpecialDetailDescription()
    if(self.specialAttribute ~= 0) then
        return PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(self.effectDes), self.specialAttribute)
    end 

    return  nil
end

function GemStoneData:getNum()
    if self.num == nil then
        return 0
    end
    return self.num;
end

-- 获取宝石战力评分
function GemStoneData:getCombatScore()

    return self.combatScore
end

function GemStoneData:getStoneLV()
    -- body
    return self.gemstoneLV
end

function GemStoneData:getTransDropGroupID()
    -- body
    return self.transDropGroupID
end

function GemStoneData:getNextLVID()
    -- body
    return self.nextLVID
end

function GemStoneData:getRequireLevel()
    return self.gemstoneRequireLV
end


function GemStoneData:getGemStoneType()
    return self.gemStoneType
end

-- 获取堆叠数量
function GemStoneData:getStackNum()
    return self.stackNum
end

-- 获取大秘境要是对应的楼层
function GemStoneData:getDungeonLevel()
    return tonumber(self.value1)
end

function GemStoneData:initLocalData(data)
    self:setLocalConfigData(data)
end

function GemStoneData:initNetData(num,isGolden,isLock,isEquiped,viceGemStoneID)
    local oldGoodsID = self.goodsID
    self.goodsRare = nil
    self.num = num
    self.isGolden = isGolden
    self.isLock = isLock
    self.isEquiped = isEquiped
    self.viceGemStoneID = viceGemStoneID or 0 --链接副宝石ID
    -- 处理装备的初始化处理
    if oldGoodsID ~= self.goodsID then
        self:conbinationLocalData()
    end

    if self.isGolden == true and self.goodsRare < GOODS_RARE.RARE_GOLDEN_3 then
        self.goodsRare = GOODS_RARE.RARE_GOLDEN_3
    end
end

function GemStoneData:setIsWear(isWear, equipEntityId, equipSlotIdx)
    self.isWear = isWear

    self.equipEntityId = equipEntityId
    self.equipSlotIdx = equipSlotIdx
end

function GemStoneData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getGemStoneConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("GemStoneData:conbinationLocalData  goodsID=%d no found local data ",self.goodsID))
        end
    end
end

function GemStoneData:_refreshGemStoneType()
    -- 计算材料类型
    if self.goodsID then
        self.gemStoneType = self:calculateGemStoneType(self.goodsID)
        return
    end

    assert(false, "GemStoneData:_refreshMaterialType self.goodsID is nil.")
end

function GemStoneData:calculateGemStoneType(goodsID)
    local equipType = math.modf(goodsID / 10000)
    if equipType == 2401 then
        return GemStoneType.GemStoneType_Red
    elseif equipType == 2402 then
        return GemStoneType.GemStoneType_Yellow
    elseif equipType == 2403 then
        return GemStoneType.GemStoneType_Blue
    elseif equipType == 2404 then
        return GemStoneType.GemStoneType_Colourful
    else
        assert(false,"no handle type")
    end 
end
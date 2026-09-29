--[[
    雕文属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local GlyphData = class("GlyphData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"

local GlyphType = PublicDefine.GlyphType

Goods = Goods or {}

Goods.GlyphData = GlyphData

local GOODS_RARE = PublicDefine.GlyphType -- 雕文之间的区别就只有稀有度不同，相同的稀有度的属性都是服务器随机给的。

function GlyphData:ctor(goodsID)
    GlyphData.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_GLYPH)

    self.goodsID = goodsID
    self.num = 0
    self.isGolden = false
    self.isEquiped = false
    self.isWear = false
    self.entityID = 0
    self.equipEntityId = 0
    self.equipSlotIdx = 0
    self.combatScore = 0
    self.equipPacketType = 0
    
    self:conbinationLocalData()
    self:_refreshGlyphType()
    self:refreshAttr()

    self._makeGoodsData = nil
end 

-- 获取物品名字
function GlyphData:getName()
    return self.name
end

function GlyphData:getIconName()
    if self.icon == nil or self.icon == "" then
        self.icon = self:_getIconName()
    end

    local localData = ConfigManager:getGlyphByID(self.goodsID)

    self.icon = localData.icon
    
    return self.icon
end

-- 获取物品描述
function GlyphData:getDescription()
    -- TODO 这里根据类型获取描述信息
    return ""
end

function GlyphData:refreshAttr()
    local attrList = {}
    if self.attrData ~= nil then
        for k, v in ipairs(self.attrData) do
            local data = {}
            data.type = v.attrType
            data.value = v.attrValue
            data.valueType = PublicDefine.VALUE_TYPE.Value
            table.insert(attrList, data)
        end
    end

    -- 测试代码，雕纹随机添加四种属性
    -- attrList = {{type = 51, valueType = 1, value = 49},
    --             {type = 52, valueType = 1, value = 3},
    --             {type = 53, valueType = 1, value = 37},
    --             {type = 54, valueType = 1, value = 83},
    --             }

    self.attrList = attrList

    -- 属性改变时战力同样改变
    self:_refreshCombatScore()
end

-- 获取雕文普通详情
function GlyphData:getNormalDetailDescription()
    self:refreshAttr()

    local desArr = {}
    for k, data in pairs(self.attrList) do 
        local oneAttr = {}
        table.insert(oneAttr, ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[data.type]))
        if(data.valueType == PublicDefine.VALUE_TYPE.Value) then 
            local endStr, valueType = ToolsUtil:calculationAttrShowValue(data.type, data.value)
            table.insert(oneAttr,string.format("%s", endStr))

            ------
            -- 避免报错临时加上的,后面要去掉
            --table.insert(oneAttr,string.format("%s", tostring(data.value)))
        else 
            table.insert(oneAttr,string.format("%.2f%%",data.value / 100))
        end
        table.insert(oneAttr, data.type)
        table.insert(desArr, oneAttr)
    end
    return desArr
end

-- 获取雕文特殊技能详情
function GlyphData:getSpecialDetailDescription()
    if(self.specialAttribute ~= 0) then
        return PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(self.effectDes), self.specialAttribute)
    end 

    return  nil
end

function GlyphData:getNum()
    if self.num == nil then
        return 0
    end
    return self.num;
end

-- 获取雕文战力评分
function GlyphData:getCombatScore()

    return self.combatScore
end

function GlyphData:getEntityID()
    return self.entityID
end

function GlyphData:getEquipEntityId()
    return self.equipEntityId
end

function GlyphData:getEquipPacketType()
    return self.equipPacketType
end

function GlyphData:getGlyphLV()
    -- body
    return self.glyphLV
end

function GlyphData:getTransDropGroupID()
    -- body
    return self.transDropGroupID
end

function GlyphData:getNextLVID()
    -- body
    return self.nextLVID
end

function GlyphData:getRequireLevel()
    return self.glyphRequireLV
end


function GlyphData:getGlyphType()
    return self.glyphType
end

-- 获取堆叠数量
function GlyphData:getStackNum()
    return self.stackNum
end

-- 获取大秘境要是对应的楼层
function GlyphData:getDungeonLevel()
    return tonumber(self.value1)
end

function GlyphData:initLocalData(data)
    self:setLocalConfigData(data)
end

function GlyphData:saveRefinedConfirmResult(data, isGet)
    if data then
        if isGet then
            for k,v in pairs(self.attrData) do
                -- for k1,v1 in pairs(data.data.lastRefineAttrData) do
                --     if v.attrType == v1.attrType then
                --         v.attrValue = v.attrValue + v1.attrValue
                --         -- 这里这个判断，雕纹重新洗练后的值是否超过当前等级能允许的最大值
                --         -- 超过则设置为最大值
                --         local attributeConfig = ConfigManager:getGlyphAttributeByID(v1.attrType)
                --         local heroData = RoleDataManager:getMaster()
                --         local attributeValueMax = 
                --         if v.attrValue > attributeValueMax then
                --             v.attrValue = attributeValueMax
                --         elseif v.attrValue < 0 then
                --             v.attrValue = 0
                --         end
                --     end
                -- end
                for k1,v1 in pairs(data.data.attrData) do
                    if v.attrType == v1.attrType then
                        v.attrValue = v1.attrValue
                    end
                end
            end
            self.lastAttrData = {}
        else
            self.lastAttrData = {}
        end
    end
end

function GlyphData:saveRefinedLastAttrData(data)
    -- local isNeedSetLastAttr = true
    -- if data then
    --     -- 若本次洗练结果全为正向或无变化，则不需要保存洗练结果，服务器会直接替换
    --     for k,v in pairs(self.attrData) do
    --         for k1,v1 in pairs(data.lastRefineAttrData) do
    --             if v.attrType == v1.attrType then
    --                 if tonumber(v1.attrValue) < 0 then
    --                     isNeedSetLastAttr = false
    --                 end
    --             end
    --         end
    --     end
    -- end

    -- if isNeedSetLastAttr then
    --     self.lastAttrData = nil
    --     return
    -- end

    if data then
        self.lastAttrData = data.lastRefineAttrData
    else
        self.lastAttrData = {}
    end
end

function GlyphData:getLastAttrData()
    return self.lastAttrData
end

function GlyphData:getNowAttrData()
    return self.attrData
end

function GlyphData:initNetData(netData,num,isGolden,isLock,isEquiped)
    local oldGoodsID = self.goodsID
    self.goodsRare = nil
    self.num = num
    self.isGolden = isGolden
    self.isLock = isLock
    self.isEquiped = isEquiped and true or false
    self.entityID = netData and netData.entityID or 0
    self.attrData = netData and netData.attrData or nil
    self.lastAttrData = netData and netData.lastRefineAttrData or {}
    -- 处理装备的初始化处理
    if oldGoodsID ~= self.goodsID then
        self:conbinationLocalData()
    end

    if self.isGolden == true and self.goodsRare < GOODS_RARE.RARE_GOLDEN_3 then
        self.goodsRare = GOODS_RARE.RARE_GOLDEN_3
    else
        self.goodsRare = self:calculateGlyphType()
    end

    --------
    -- --测试
    -- self.attrData = {
    --     {attrType = 60, attrValue = 20},
    --     {attrType = 61, attrValue = 40},
    --     {attrType = 62, attrValue = 50},
    --     {attrType = 63, attrValue = 40},
    -- }

    self:refreshAttr()

    self:setGlyphName()
end

-- function GlyphData:getBytesData()
--     local ProtobufUtil = require "utils.ProtobufUtil"
--     local decodeData = {}
--     --刷新 最新数据
--     -- decodeData.entityID = self.entityID
--     -- decodeData.level = self.level
--     -- decodeData.exp = self.exp
    
--     local bytesData =  ProtobufUtil:encode("GoodsSystem.", decodeData)   
--     return bytesData
-- end

function GlyphData:setIsWear(isWear, equipEntityId, equipSlotIdx, equipPacketType)
    self.isWear = isWear

    self.equipEntityId = equipEntityId
    self.equipSlotIdx = equipSlotIdx
    self.equipPacketType = equipPacketType
end

function GlyphData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getGlyphByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("GlyphData:conbinationLocalData  goodsID=%d no found local data ",self.goodsID))
        end
    end
end

function GlyphData:_refreshGlyphType()
    -- 计算材料类型
    if self.goodsID then
        self.glyphType = self:calculateGlyphType(self.goodsID)
        return
    end

    assert(false, "GlyphData:_refreshMaterialType self.goodsID is nil.")
end

function GlyphData:calculateGlyphType(goodsID)
    local glyphId = nil
    if not goodsID then
        glyphId = self.goodsID
    else
        glyphId = goodsID
    end
    local equipType = math.modf(glyphId / 10000)
    if equipType == 5202 then
        return GlyphType.GlyphType_Blue
    elseif equipType == 5203 then
        return GlyphType.GlyphType_Gold
    elseif equipType == 5204 then
        return GlyphType.GlyphType_DarkGold
    elseif equipType == 5205 then
        return GlyphType.GlyphType_Purple
    else
        assert(false,"no handle type")
    end 
end

function GlyphData:setGlyphName()
    local glyphConfig = ConfigManager:getGlyphAllData()
    local name = ""
    for k, v in pairs(self.attrData) do
        name = name..ToolsUtil:getGlyphsNameByAttr(v.attrType)
    end

    for k ,v in pairs(glyphConfig) do
        if self.goodsRare == v.goodsRare then
            name = name.. UI.TEXT_227060 ..LanguageManager:getInstance():getLocalString(v.name)
            break
        end
    end
    self.name = name
end

function GlyphData:isRefined()
    local isRefined = false
    if self.attrData ~= nil then
        for k, v in ipairs(self.attrData) do
            if tonumber(v.attrValue) > 0 then
                isRefined = true
                return 
            end
        end
    end

    return isRefined
end

function GlyphData:restAttrData(attrData)
    self.attrData = attrData or nil
    self:refreshAttr()
    self:setGlyphName()
end

function GlyphData:_refreshCombatScore()
    self.combatScore = 0
    if self.attrData ~= nil then
        for k,v in pairs(self.attrData) do
            local attributeConfig = ConfigManager:getGlyphAttributeByID(tonumber(v.attrType))
            self.combatScore = self.combatScore + (attributeConfig.combatScore / 10 * v.attrValue)
        end
        self.combatScore = math.floor(self.combatScore)
    end
    
end

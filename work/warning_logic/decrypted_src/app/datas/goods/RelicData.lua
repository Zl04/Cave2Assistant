--[[
    遗物属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local RelicData = class("RelicData",GoodsData)
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"

Goods = Goods or {}

Goods.RelicData = RelicData

function RelicData:ctor(goodsID)
    RelicData.super.ctor(self, PublicDefine.GOODS_TYPE.GOODS_RELIC)

    self.goodsID = goodsID
    self.num = 1
    self.isGolden = false
    -- 星级
    self.combatScoreNum = 0
    -- 遗物等级
    self.level = 1
    -- 遗物强化次数
    self.levelCnt = 0
    -- 遗物展示所用等级（别人展示传递的等级，自己的遗物此字段为0）
    self.heroLv = 0
    -- 自身等级
    self.masterLevel = 0
    self.attrList = nil
    self:conbinationLocalData()
end

-- 获取物品名字
function RelicData:getName()
    return self.name
end

function RelicData:getIconName()
    self:updateIconName()
    return self.icon
end

function RelicData:updateIconName()
    self.icon = tostring(string.split(self.relicIcon,";")[self.level])
end

-- 获取物品描述
function RelicData:getDescription()
    -- TODO 这里根据类型获取描述信息
    return ""
end

function RelicData:getEntityID()
    return self.entityID
end

function RelicData:getNum()
    if self.num == nil then
        return 1
    end
    return self.num
end

-- 获取遗物战力评分
function RelicData:getCombatScore()
    self:refreshCombatScore()

    return self.combatScoreNum
end

function RelicData:getLevel()
    return self.level
end

function RelicData:initLocalData(data)
    self:setLocalConfigData(data)
end

function RelicData:initNetData(netData,num,isGolden,isLock,index)
    self.isGolden = isGolden or false
    self.isLock = isLock or false
    self.entityID = netData.entityID
    self.level = netData.lv or 1
    self.heroLv = netData.heroLv or 0
    self.levelCnt = netData.lvCnt or 0
    self.index = index

    self:conbinationLocalData()
end

function RelicData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getRelicConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("GemStoneData:conbinationLocalData  goodsID=%d no found local data ",self.goodsID))
        end

        self:refreshRare()
    end
end

function RelicData:refreshAttr()
    local master = RoleDataManager:getMaster()
    if not master then
        return
    end

    local attrList = {}

    local roleLevel = 0
    if self.heroLv ~= 0 then
        roleLevel = self.heroLv
    else
        local myLevel = master:getLevel()
        if self.masterLevel ~= myLevel then
            self.masterLevel = myLevel
        end
        roleLevel = self.masterLevel
    end

    local attrNumConfig = ConfigManager:getRelicAttrConfigByID(roleLevel)
    for k, v in ipairs(self.attrType) do
        local attrValue = attrNumConfig["attrEnum_"..tostring(v)][self.level]
        local data = {}
        data.type = checkint(v)
        data.value = checkint(attrValue)
        data.valueType = PublicDefine.VALUE_TYPE.Value
        table.insert(attrList, data)

        local attrPercentList = string.split(self.attrPercent, ";")[k]
        local attrPercent = tonumber(string.split(attrPercentList, ",")[self.level])
        local data = {}
        data.type = checkint(v)
        data.value = checkint(attrPercent)
        data.valueType = PublicDefine.VALUE_TYPE.Rate
        table.insert(attrList, data)
    end

    self.attrList = attrList
end

function RelicData:setLevel(level)
    if self.level ~= level then
        self.level = level
        self:refreshAttr()
        self:refreshCombatScore()
        self:refreshRare()
        self:updateIconName()
    end
end

function RelicData:refreshRare()
    self.goodsRare = self.relicRare[self.level]
end

function RelicData:setIndex(index)
    self.index = index
end


function RelicData:refreshCombatScore()
    local relicLevelStarNum = self.combatScore[self.level]

    local roleLevel = 0
    if self.heroLv ~= 0 then
        roleLevel = self.heroLv
    else
        local myLevel = RoleDataManager:getMaster():getLevel()
        if self.masterLevel ~= myLevel then
            self.masterLevel = myLevel
        end
        roleLevel = self.masterLevel
    end

    self.combatScoreNum = relicLevelStarNum * roleLevel
end

-- 获取遗物普通详情
function RelicData:getNormalDetailDescription()
    self:refreshAttr()

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

function RelicData:isMaxLevel()
    if self:getMaxLevel() <= self.level then
        return true
    end
    return false
end

function RelicData:getMaxLevel()
    if self.maxLevel then
        return self.maxLevel
    end
    return 0
end

function RelicData:isMaxLevelCnt()
    if self:getMaxLevelCnt() <= self.levelCnt then
        return true
    end
    return false
end

function RelicData:getMaxLevelCnt()
    local levelConfig = ConfigManager:getRelicLevelConfigByID(self.level)
    local maxLevelCnt = levelConfig.tryMaxTimes
    if maxLevelCnt then
        return maxLevelCnt
    end
    return 0
end

function RelicData:getLevelCnt()
    if self.levelCnt then
        return self.levelCnt
    end
    return 0
end

function RelicData:getRelicType()
    if self.type then
        return self.type
    end
    return 0
end

function RelicData:getBytesData()
    local ProtobufUtil = require "utils.ProtobufUtil"
    local decodeData = {}
    --刷新 最新数据
    decodeData.entityID = self.entityID
    decodeData.lv = self.level
    decodeData.lvCnt = self.levelCnt
    decodeData.heroLv = self.masterLevel
    local bytesData =  ProtobufUtil:encode("GoodsSystem.RelicData", decodeData)
    return bytesData
end

function RelicData:doLevelUpResult(isSuccess)
    local levelConfig = ConfigManager:getRelicLevelConfigByID(self.level)
    if isSuccess then
        self:setLevel(self.level + 1)
    else
        -- 根据配置判断是否失败掉级
        if levelConfig.failChange ~= 0 then
            self:setLevel(self.level - levelConfig.failChange)
        end
    end
    self.levelCnt = self.levelCnt + 1
end
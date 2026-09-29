
--[[
    道具属性定义
]]

require("app.datas.goods.GoodsData")
local GoodsData = Goods.GoodsData

local ItemData = class("ItemData",GoodsData)  
local LanguageManager = require "app.game.LanguageManager"
require "app.config.ConfigManager"

local GOODS_RARE = PublicDefine.GOODS_RARE
local ITEM_TYPE = PublicDefine.ITEM_TYPE

Goods = Goods or {}

Goods.ItemData = ItemData

function ItemData:ctor(goodsID)
    ItemData.super.ctor(self,PublicDefine.GOODS_TYPE.GOODS_ITEM)
    self.goodsID = goodsID
    self.num = 0
    self.isGolden = false
    self._targetTypeArr = {}

     -- 初始化处理
    local localData = ConfigManager:getPropConfigByID(self.goodsID)
    if localData then
        self:initLocalData(localData)
    else
        assert(false, string.format("ItemData:initNetData  %d no found local data ",self.goodsID))
    end

    self:conbinationLocalData()
    self:_refreshItemType()
end 

function ItemData:getIconName()
    if self.icon == nil or self.icon == "" then
        self.icon = self:_getIconName()
    end
    -- print("ItemData:getIconName",self.icon)
    return self.icon
end

-- 获取武器类型
function ItemData:getItemType()

    return self.itemType
end

-- 获取公共cd 组别（同一组才使用公共cd 否者不cd）
function ItemData:getPublicCdType()

    return self.pubCDTimeType
end

-- 获取物品使用范围
function ItemData:getUseRange()
    return self.useRange
end

-- 获取物品的使用条件
function ItemData:getUseCondition()
    return self.useStatus
end

-- 获取物品使用场景
function ItemData:getUseScene()
    return self.useArea
end

-- 获取堆叠数量
function ItemData:getStackNum()
    return self.stackNum
end

-- 获取冷却时间
function ItemData:getCooldown()
    return self.cooldown
end

function ItemData:initLocalData(data)
    self:setLocalConfigData(data)

    -- 处理本地数据的初始化
    self._targetTypeArr = {}
    self._targetTypeArr = ToolsUtil:splitPositionForValue(self.targetType)
end
-- 获取物品功能描述
function ItemData:geteffecDescription()
    return LanguageManager:getInstance():getLocalString(self.effecDescription)
end

function ItemData:getIsDirection()
    -- TODO 判断是否为指向性技能
    if self.targetType ~= 1 then
        return true
    else
        return false
    end
end

-- 获取是否自动加入快捷栏
function ItemData:getIsAutoAddBar()
    if(self:getItemType() == PublicDefine.ITEM_TYPE.ChooseBag 
        or self:getItemType() == PublicDefine.ITEM_TYPE.LevelBag 
        or self:getItemType() == PublicDefine.ITEM_TYPE.ItemUnlockBag
        or self:getItemType() == PublicDefine.ITEM_TYPE.ItemUnlockWarehouse
        or self:getItemType() == PublicDefine.ITEM_TYPE.PetEgg
        or self:getItemType() == PublicDefine.ITEM_TYPE.PetHPPotion
        or self:getItemType() == PublicDefine.ITEM_TYPE.RandomBag
        or self:getItemType() == PublicDefine.ITEM_TYPE.BackTown
        or self:getItemType() == PublicDefine.ITEM_TYPE.UIShape
        or self:getItemType() == PublicDefine.ITEM_TYPE.AddExp
        or self:getItemType() == PublicDefine.ITEM_TYPE.StarCard
        or self:getItemType() == PublicDefine.ITEM_TYPE.TransCard
    ) 
        then
        return false
    end

    return true
end

function ItemData:hasTargetType(type)
	if(self._targetTypeArr) then
		for k,v in pairs(self._targetTypeArr) do 
			if(v == type) then
				return true
			end
		end
    end
    
    return  false
end

function ItemData:initNetData(num,isGolden,isLock)
    local oldGoodsID = self.goodsID
    self.goodsRare = nil
    self.num = num
    self.isGolden = isGolden
    self.isLock = isLock

    -- 初始化处理
    if oldGoodsID ~= self.goodsID then
        self:conbinationLocalData()
    end

    if self.isGolden == true and self.goodsRare < GOODS_RARE.RARE_GOLDEN_3 then
        self.goodsRare = GOODS_RARE.RARE_GOLDEN_3
    end
end

function ItemData:conbinationLocalData()
    if (self.goodsID ~= -1) then
        local localData = ConfigManager:getPropConfigByID(self.goodsID)
        if localData then
            self:initLocalData(localData)
        else
            assert(false, string.format("ItemData:conbinationLocalData  %d no found local data ",self.goodsID))
        end
    end
end

-- 战斗中不可用的物品
function ItemData:isNotUseItem()

    if self.itemType == ITEM_TYPE.IronPickaxe then  -- 铁锹
        return true 
    elseif self.itemType == ITEM_TYPE.ForgetSkillPotion  then -- 遗忘药剂
        return true 
    elseif self.itemType == ITEM_TYPE.Mushroom then-- 蘑菇
        return true 
    elseif self.itemType == ITEM_TYPE.EscapeScroll then-- 逃脱卷轴
        return true 
    elseif self.itemType == ITEM_TYPE.OpenMapShadowScroll then --灵视卷轴
        return true 
    elseif self.itemType == ITEM_TYPE.TransferScroll then-- 传送卷轴
        return true 
    elseif self.itemType == ITEM_TYPE.FlyScroll then -- 漂浮卷轴
        return true 
    elseif self.itemType == ITEM_TYPE.RunScroll then-- 疾跑卷轴
        return true 
    else 
        return false
    end 
end 

function ItemData:_refreshItemType()
    -- 计算道具类型
    if self.goodsID then
        local equipType = math.modf(self.goodsID / 10000)
        if equipType == 2001 then
            self.itemType = ITEM_TYPE.RestorePotion
        elseif equipType == 2002 then
            self.itemType = ITEM_TYPE.IronPickaxe
        elseif equipType == 2003 then
            self.itemType = ITEM_TYPE.ForgetSkillPotion
        elseif equipType == 2004 then
            self.itemType = ITEM_TYPE.Mushroom
        elseif equipType == 2005 then
            self.itemType = ITEM_TYPE.EscapeScroll
        elseif equipType == 2006 then
            self.itemType = ITEM_TYPE.OpenMapShadowScroll
        elseif equipType == 2007 then
            self.itemType = ITEM_TYPE.TransferScroll
        elseif equipType == 2008 then
             self.itemType = ITEM_TYPE.FlyScroll
        elseif equipType == 2009 then
            self.itemType = ITEM_TYPE.RunScroll
        elseif equipType == 2010 then
            self.itemType = ITEM_TYPE.MagicScroll
        elseif equipType == 2011 then
            self.itemType = ITEM_TYPE.DispelBuff
        elseif equipType == 2012 then
            self.itemType = ITEM_TYPE.ChooseBag
        elseif equipType == 2013 then
            self.itemType = ITEM_TYPE.Firecrackers
        elseif equipType == 2014 then
            self.itemType = ITEM_TYPE.LevelBag
        elseif equipType == 2015 then
            self.itemType = ITEM_TYPE.ItemFunTrap
        elseif equipType == 2016 then
            self.itemType = ITEM_TYPE.ItemFunMark
        elseif equipType == 2017 then
            self.itemType = ITEM_TYPE.ItemFunExplore
        elseif equipType == 2018 then
            self.itemType = ITEM_TYPE.ItemUnlockBag
        elseif equipType == 2019 then
            self.itemType = ITEM_TYPE.ItemUnlockWarehouse
        elseif equipType == 2020 then
            self.itemType = ITEM_TYPE.PetEgg
        elseif equipType == 2021 then
            self.itemType = ITEM_TYPE.PetHPPotion
        elseif equipType == 2022 then
            self.itemType = ITEM_TYPE.RandomBag
        elseif equipType == 2023 then
            self.itemType = ITEM_TYPE.HuluSkill
        elseif equipType == 2024 then
            self.itemType = ITEM_TYPE.BackTown
        elseif equipType == 2025 then
            self.itemType = ITEM_TYPE.UIShape
        elseif equipType == 2026 then
            self.itemType = ITEM_TYPE.AddExp
        elseif equipType == 2027 then
            self.itemType = ITEM_TYPE.StarCard
        elseif equipType == 2028 then
            self.itemType = ITEM_TYPE.TransCard
        else
            printError("ItemData:_refreshItemType  error goodsID=",goodsID)
        end

    end
end

-- 获取回复药剂类型 1：生命回复 2：魔法回复
function ItemData:getRemarksField()
    return self.extendValue1 
end 

-- 获取禁用类型
function ItemData:getDisableSituation()
    return self.disableSituation
end 

-- 判断是否可以卖或者销毁
function ItemData:getIsSellOrDestory()
    if(self.itemType == ITEM_TYPE.LevelBag) then 

        return false
    end

    return true
end

function ItemData:isUseInMaze()
    if(self.itemType == ITEM_TYPE.ItemFunTrap or 
        self.itemType == ITEM_TYPE.ItemFunMark or 
        self.itemType == ITEM_TYPE.ItemFunExplore) then 
        
        return true
    end

    return false
end

function ItemData:isMazeMark()
    if(self.itemType == ITEM_TYPE.ItemFunMark) then 
        
        return true
    end

    return false
end

function ItemData:isUnlockPackege()
    if(self.itemType == ITEM_TYPE.ItemUnlockBag 
        or self.itemType == ITEM_TYPE.ItemUnlockWarehouse) then 
        
        return true
    end

    return false
end
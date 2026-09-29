-- ItemSprite.lua
-- Author:ODEI
-- 2017年4月18日
-- Using:物品cell(轻量级)

require "app.ui.Component"
require("utils.res.ResHelper")

UI = UI or {}

local ItemSprite = class("ItemSprite", cc.Node)
UI.ItemSprite = ItemSprite

-- private:
local DEBUG = false

-- 资源
local ITEM_RES_LIST = {
}

-- 构造函数
function ItemSprite:ctor(data)
    for i = 1, #ITEM_RES_LIST do
        local resName = ITEM_RES_LIST[i]
        Avalon.ResHelper:loadPlistSync(resName)
    end

    self._data = data

    -- 物品的状态
    self._iconLock  = nil 

    -- 物品稀有度
    self._bgRare =  nil 

    -- 背景图片
    self._bgSprite = nil
    -- 物品图标
    self._iconSprite = nil
    -- 物品数量视图
    self._goodsCountLable = nil
    -- 新装备标识
    self._newEquipIcon = nil
    
    self:onInitView()

    self:onUpdateView();
end

-- 获取数据
function ItemSprite:getData()
    return self._data
end

-- 物品新图标
function ItemSprite:showNewIcon()
    if self._data:getIsNew() then
        if not self._newIcon then
            self._newIcon = AvalonUtil.createRedPoint(self, 0, 0, 3)
        end
    end
end




-- 初始化视图
function ItemSprite:onInitView()
    -- 格子背景
    local bgSprite = cc.Sprite:create()
    bgSprite:setSpriteFrame("box_quality_box_01.png")
    self:addChild(bgSprite, 1)
    self._bgSprite = bgSprite


    -- 不同品质的背景
    local bgRare = cc.Sprite:create()
    bgRare:setSpriteFrame("box_quality_0_1.png")
    bgRare:setPosition(0,0)
    self:addChild(bgRare, 1)
    self._bgRare = bgRare 
 
    -- 物品图标
    self._iconSprite = cc.Sprite:create()
    self:addChild(self._iconSprite, 2)
    
    -- 物品数量
    local goodsCountLable = cc.Label:createWithSystemFont(string.format("%s", 0), UI.FONT_ARIAL, UI.FONT_SIZE_25PX)
    goodsCountLable:setPosition(bgSprite:getContentSize().width/2, -bgSprite:getContentSize().height/2)
    goodsCountLable:setAnchorPoint(1,0)
    self:addChild(goodsCountLable, 5)
    self._goodsCountLable = goodsCountLable
end



-- 更新视图
function ItemSprite:onUpdateView()
    local data = self._data

    -- dump(data)
    if (data) then
        local iconName = data:getIconName()
        local rare = data:getGoodsRare()
        local goodsGroupType = data:getGoodsGroupType()
        if (iconName) then
            if (DEBUG) then
                print(string.format("ItemSprite onUpdateView: icon name is %s.", iconName))
            end
            
            self._iconSprite:setSpriteFrame(iconName)
            self._iconSprite:setPosition(0, 0)

        end
        
        self._bgRare:setSpriteFrame(string.format("box_quality_%s_%s.png",goodsGroupType,rare))
        
        self._goodsCountLable:setString(string.format("%s", data:getNum()))
        self._goodsCountLable:setVisible(true)

        if  data:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            or data:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then 
            self._goodsCountLable:setVisible(false)
        end
        
    else
        assert(false)
    end
end

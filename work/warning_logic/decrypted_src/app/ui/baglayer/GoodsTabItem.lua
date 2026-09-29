--[[
    UI - Tab 
]]--

require "app.ui.common.Tab.TabItem"

UI = UI or {}

local GoodsTabItem = class("GoodsTabItem", UI.TabItem)
UI.GoodsTabItem = GoodsTabItem

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 构造函数
function GoodsTabItem:ctor(viewType)
    GoodsTabItem.super.ctor(self, viewType or UIType.TAB_ITEM, nil, 0, 0)

    self._normalSpriteName = nil
    self._activeSpriteName = nil
    self._activeItemSpriteName = nil
    self._normalItemSpriteName = nil

    self._normalSprite = nil
    self._activeSprite = nil
    self._activeItemImage = nil
    self._normalItemImage = nil

    self._index = 0
end

-- 析构函数
function GoodsTabItem:dtor()
    self._normalSpriteName = nil
    self._activeSpriteName = nil
    self._activeItemSpriteName = nil
    self._normalItemSpriteName = nil

    self._normalSprite = nil
    self._activeSprite = nil
    self._activeItemImage = nil
    self._normalItemImage = nil

    GoodsTabItem.super.dtor(self)
end

-- public:
-- 初始化
function GoodsTabItem:init(normalSpriteName, activeSpriteName, normalItemSpriteName, activeItemSpriteName)
    self._normalSpriteName = normalSpriteName
    self._activeSpriteName = activeSpriteName
    self._activeItemSpriteName = activeItemSpriteName
    self._normalItemSpriteName = normalItemSpriteName

    GoodsTabItem.super.init(self)
end

-- 初始化视图
function GoodsTabItem:onInitView()
    self._normalSprite = cc.Sprite:create()
    self._normalSprite:initWithSpriteFrameName(self._normalSpriteName)
    self:addChild(self._normalSprite)

    self._activeSprite = cc.Sprite:create()
    self._activeSprite:initWithSpriteFrameName(self._activeSpriteName)
    self._activeSprite:setVisible(false)
    self:addChild(self._activeSprite)
    
    self._normalItemImage = cc.Sprite:create()
    self._normalItemImage:initWithSpriteFrameName(self._normalItemSpriteName)
    self:addChild(self._normalItemImage)

    self._activeItemImage = cc.Sprite:create()
    self._activeItemImage:initWithSpriteFrameName(self._activeItemSpriteName)
    self._activeItemImage:setVisible(false)
    self:addChild(self._activeItemImage)

end

-- 更新视图
function GoodsTabItem:onUpdateView()
    self._normalSprite:setPosition(self._hw, self._hh)
    self._activeSprite:setPosition(self._hw, self._hh)
    self._activeItemImage:setPosition(self._hw, self._hh)
    self._normalItemImage:setPosition(self._hw, self._hh)
end

-- 被点击
function GoodsTabItem:onPress()
    if (self._normalSprite) then
        self._normalSprite:setScale(1.1)
    end
    if (self._normalItemImage) then
        self._normalItemImage:setScale(1.1)
    end
end

-- 显示被激活
function GoodsTabItem:onActive()
    self._activeSprite:setVisible(true)
    self._activeSprite:setScale(1.0)
    self._normalSprite:setVisible(false)
    self._activeItemImage:setVisible(true)
    self._activeItemImage:setScale(1.0)
    self._normalItemImage:setVisible(false)
end

-- 恢复
function GoodsTabItem:onRestore()
    self._normalSprite:setScale(1.0)
    self._normalSprite:setVisible(true)
    self._activeSprite:setVisible(false)
    self._normalItemImage:setScale(1.0)
    self._normalItemImage:setVisible(true)
    self._activeItemImage:setVisible(false)
end
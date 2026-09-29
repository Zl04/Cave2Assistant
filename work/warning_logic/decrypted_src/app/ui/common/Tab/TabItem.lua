--[[
    UI - Tab 
]]--

require "app.ui.Component"

UI = UI or {}

local TabItem = class("TabItem", UI.HWBtnComponent)
UI.TabItem = TabItem

-- private:
local DEBUG = false
local DEBUG_DRAW = true

local TabState = {
    NORMAL = 1,
    ACTIVE = 2,
    DISABLE = 3,
}

local function onTabTouchBeganHandler(self, tab)
    touchChange = false
    if (self._state == TabState.NORMAL) then
        self:onPress()
    end
end

local function onTabTouchMovedHandler(self, tab, touchPosition)
    if self:checkTouchPosition(touchPosition) then
        if (self._state == TabState.NORMAL) then
            self:onPress()
        end
    else
        if (self._state == TabState.NORMAL) then
            self:restore()
        end
    end
end

-- 被点击的处理器
local function onTabTouchEndedHandler(self, tab, touchPosition)
    if (self._state == TabState.NORMAL) then
        self:release()
    elseif (self._state == TabState.DISABLE) then --disable 状态要通知逻辑 做提示
        self:onDisableClick(self)
    end
end

local function onTabClickHandler(self, tab)
    if tab and not tab:isDisable() then
        self:dispatchEvent(UIEvent.TAB_CLICK, tab)
    end
end

-- 构造函数
function TabItem:ctor(type)
    local _type = type or UIType.TAB_ITEM
    TabItem.super.ctor(self, _type, nil, 0, 0)

    -- tab的索引
    self._index = 0
    -- tab的状态
    self._state = TabState.NORMAL

    -- 正常状态的图片名字
    self._normalSpriteName = nil
    -- 激活状态的图片名字
    self._activeSpriteName = nil
        -- 的图片名字
    self._disableSpriteName = nil
    -- 图片
    self._sprite = nil

    self._changeScale = true
end

-- 析构函数
function TabItem:dtor()
    TabItem.super.dtor(self)
end

-- public:
-- 初始化
function TabItem:init(normalSpriteName, activeSpriteName)
    if (normalSpriteName) then 
        assert(type(normalSpriteName) == "string", "TabItem init: normal sprite name is invalid.") 
        self._normalSpriteName = normalSpriteName
    end
    if (activeSpriteName) then 
        assert(type(activeSpriteName) == "string", "TabItem init: active sprite name is invalid.") 
        self._activeSpriteName = activeSpriteName
    end

    TabItem.super.init(self)

    self:setTouchEnable(true)
    self:setCloseDrag(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, onTabTouchBeganHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, onTabTouchEndedHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, onTabTouchMovedHandler)
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, onTabClickHandler)
    self:setClickAudioEnable(true)
end

-- 设置索引
function TabItem:setIndex(index)
    assert(type(index) == "number" and index > 0, "TabItem setIndex: index is invalid..")

    self._index = index
end

-- 获取索引
function TabItem:getIndex()
    return self._index
end

-- 显示被激活
function TabItem:active()
    if (self._state == TabState.NORMAL) then
        if (DEBUG) then
            print(string.format("TabItem active: active tab %d.", self._index))
        end

        self._state = TabState.ACTIVE
        self:onActive()
    end
end

-- 显示被激活
function TabItem:disable()
    self._state = TabState.DISABLE
    self:onDisable()
end

-- 恢复
function TabItem:restore()
    if (DEBUG) then
        print(string.format("TabItem restore: restore tab %d.", self._index))
    end
    if self:isDisable() then
        return
    end

    self._state = TabState.NORMAL
    self:onRestore()
end

-- 模版函数：初始化视图
function TabItem:onInitView()
    if (self._normalSpriteName) then
        self._sprite = cc.Sprite:create()
        self._sprite:setSpriteFrame(self._normalSpriteName)
        self:addChild(self._sprite)
    end
end

-- 模版函数：更新视图
function TabItem:onUpdateView()
    if (self._sprite) then
        if (self._alignLeft) then
            local contentSize = self._sprite:getContentSize()
            self._sprite:setPosition(contentSize.width / 2, self._hh)
        else
            self._sprite:setPosition(self._hw, self._hh)
        end
    end
end

-- 模版函数：被点击
function TabItem:onPress()
    if (self._normalSpriteName and self._sprite) then
        if self._changeScale then
            self._sprite:setScale(1.1)
        end
    end
end

-- 模版函数：激活
function TabItem:onActive()
    if (self._activeSpriteName and self._sprite) then
        self._sprite:setSpriteFrame(self._activeSpriteName)
        self:updateView()
    end
end

function TabItem:release()

end

-- 模版函数：恢复
function TabItem:onRestore()
    if (self._normalSpriteName and self._sprite) then
        if self._changeScale then
            self._sprite:setScale(1.0)
        end
        self._sprite:setSpriteFrame(self._normalSpriteName)
        self:updateView()
    end
end

function TabItem:onDisable()
    if (self._disableSpriteName and self._sprite) then
        if self._changeScale then
            self._sprite:setScale(1.0)
        end
        self._sprite:setSpriteFrame(self._disableSpriteName)
        self:updateView()
    end
end

function TabItem:isDisable()
    return self._state == TabState.DISABLE
end

function TabItem:removeDisable()
    self._state = TabState.NORMAL
    self:onRestore()
end

--disable 状态要通知逻辑 做提示
function TabItem:onDisableClick(target)
    
end

function TabItem:setChangeScale(var)
    self._changeScale = var
end

function TabItem:alignLeft(b)
    self._alignLeft = b
end
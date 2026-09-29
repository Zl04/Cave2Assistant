-- SwitchButton.lua
-- Author:zp
-- 2018年10月20日
-- Using:开关按钮

require "app.ui.Component"
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local SwitchButton = class("SwitchButton", UI.HWBtnComponent)
UI.SwitchButton = SwitchButton
local scheduler = cc.Director:getInstance():getScheduler()

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 背包资源
local COM_RES_LIST = nil
-- 按钮中的子对象z序
local BUTTON_SPRITE_ZORDER = 1
local BUTTON_TITLE_ZORDER = 2

UI.ButtonState = {
    NORMAL = 1,   -- 正常
    ACTIVE = 2,   -- 点击
    RELEASE = 3,  -- 释放
    DISABLE = 4   -- 不可用状态
}
ButtonState = UI.ButtonState

local COM_WIDTH = 90
local COM_HEIGHT = 50

-- 构造函数
function SwitchButton:ctor()
    SwitchButton.super.ctor(self, UIType.SWITCH_BUTTON, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self._state = ButtonState.NORMAL
    self._isOpen = false
end

-- 析构函数
function SwitchButton:dtor()

    SwitchButton.super.dtor(self)
end

-- public:
-- 初始化
function SwitchButton:init(isOpen, bgSpriteName, closeBgSpriteName, closeSpriteName, openBgSpriteName, openSpriteName)
    self._isOpen = isOpen
    self._bgSpriteName = bgSpriteName
    self._closeBgSpriteName = closeBgSpriteName
    self._closeSpriteName = closeSpriteName
    self._openBgSpriteName = openBgSpriteName
    self._openSpriteName = openSpriteName

    self:setTouchEnable(true)
    SwitchButton.super.init(self)
end

function SwitchButton:setStateChangeCallBack(callBack)
    self._callBack = callBack
end

function SwitchButton:setBeforeStateChangeCallBack(callBack)
    self._beforeStateChangeCallBack = callBack
end


function SwitchButton:onInitView()
    if(self._bgSpriteName) then 
        local bg = UI.Image:create()
        bg:init(self._bgSpriteName)
        bg:leftUp(0, -0.5)
        self:addChild(bg)
        local contentSize = bg:getContentSize()
        -- local width = math.max(COM_WIDTH, contentSize.width)
        -- local height = math.max(COM_HEIGHT, contentSize.height)
        self:setSize(contentSize.width, contentSize.height)
    end

    self._switchBg = UI.Image:create()
    self._switchBg:init(self._closeBgSpriteName)
    self._switchBg:center()
    self:addChild(self._switchBg)


    self._switch = UI.Image:create()
    self._switch:init(self._closeSpriteName)
    self._switchBg:addChild(self._switch)
    self:setClickAudioEnable(true)
    self:refreshSwitch()

    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self, button, touchPosition)
        -- self:press()
    end)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, button, touchPosition)
        -- self:release()
    end)
    local function onTouch(self, button, touchPosition)
        if self._beforeStateChangeCallBack then
            local canSwitch = self._beforeStateChangeCallBack()
            if canSwitch == nil or canSwitch == false then
                return
            end
        end
        self._isOpen = not self._isOpen
        self:refreshSwitch()
        if self._callBack then
            self._callBack(self._isOpen)
        end
    end
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, button, touchPosition)
        if(self._state ~= ButtonState.DISABLE) then
            onTouch(self, button, touchPosition)
        end
    end)
end

-- 更新视图
function SwitchButton:onUpdateView()
    
end

function SwitchButton:setSwitchStatus(isOpen)
    self._isOpen = isOpen
    self:refreshSwitch()
end

function SwitchButton:disable()
    self._state = ButtonState.DISABLE
end

function SwitchButton:enable()
    self._state = ButtonState.NORMAL
end

function SwitchButton:refreshSwitch()
    if(self._switch and self._switchBg) then
        if(self._isOpen) then 
            self._switchBg:setSpriteName(self._openBgSpriteName)
            self._switch:setSpriteName(self._openSpriteName)
            self._switch:centerRight(-3)
        else 
            self._switchBg:setSpriteName(self._closeBgSpriteName)
            self._switch:setSpriteName(self._closeSpriteName)
            self._switch:centerLeft(-3)
        end
    end
end 




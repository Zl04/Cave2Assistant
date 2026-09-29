--[[
    UI - 按钮扩展，很多按钮都会采用通用的背包，中间添加功能图标
]]--

require "app.ui.Component"
UI = UI or {}

local ButtonExt = class("ButtonExt", UI.Button)
UI.ButtonExt = ButtonExt
local scheduler = cc.Director:getInstance():getScheduler()

-- private:
local DEBUG = false
local DEBUG_DRAW = true
-- 背包资源
local COM_RES_LIST = nil
-- 按钮中的子对象z序
local BUTTON_SPRITE_ZORDER = 1
local BUTTON_TITLE_ZORDER = 2

-- 构造函数
function ButtonExt:ctor(comType)
    local comType = comType or UIType.BUTTON_EXT
    ButtonExt.super.ctor(self, comType)
end

-- 析构函数
function ButtonExt:dtor()
    -- print("-------------------ButtonExt:dtor()")

    ButtonExt.super.dtor(self)
end

function ButtonExt:extInit(normal, active, disable)
    self._extNormal = normal
    self._extActive = active
    self._extDisable = disable
end

function ButtonExt:onInitView()
    ButtonExt.super.onInitView(self)

    local sprite = self._sprite
    if(sprite) then
        -- print("ButtonExt:onInitView",self._extNormal) 
        local extSprite = cc.Sprite:create()
        if (self._extNormal) then
            extSprite:initWithSpriteFrameName(self._extNormal)
            sprite:addChild(extSprite, 20)
            extSprite:setPosition(self._width / 2, self._height/ 2)
        end

        self._extSprite = extSprite
        self:addEventListener(UIEvent.BUTTON_PRESS,self,function()
            -- print("ButtonExt:onInitView  BUTTON_PRESS", self._extActive, tolua.isnull(self._extSprite)) 
            if(not tolua.isnull(self._extSprite)) then 
                if(self._extActive) then
                    -- print("ButtonExt:onInitView  BUTTON_PRESS", self._extActive) 
                    self._extSprite:setSpriteFrame(self._extActive)                
                end
            end
        end)

        self:addEventListener(UIEvent.BUTTON_RELEASE,self,function()
            -- print("ButtonExt:onInitView  BUTTON_RELEASE") 
            if(not tolua.isnull(self._extSprite)) then 
                if(self._extNormal) then 
                    self._extSprite:setSpriteFrame(self._extNormal)                
                end
            end
        end)
    end
end

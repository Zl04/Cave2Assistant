-- BannerCursor.lua
-- Author:ydli
-- 2018年10月19日
-- Using:banner 滑动是的光标

UI = UI or {}
local BannerCursor = class("BannerCursor", UI.HWBtnComponent)
UI.BannerCursor = BannerCursor

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(40, 5)
-- 背包资源
local COM_RES_LIST = {
}

function BannerCursor:ctor(normalImg, selectImg, cursorImg)
    BannerCursor.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)
    self:init(normalImg, selectImg, cursorImg)
end

function BannerCursor:dtor()
    BannerCursor.super.dtor(self)
end

function BannerCursor:init(normalImg, selectImg, cursorImg)
    BannerCursor.super.init(self)
    self.normalImg = normalImg
    self.selectImg = selectImg
    self.cursorImg = cursorImg
    local bg = UI.Image:create()
    bg:init(self.normalImg)
    self.bg = bg
    self.bg:leftBottom(0, 0)
    self:setSize(bg:getContentSize().width + 2, bg:getContentSize().height + 4)
    local _ckipperSprite = cc.LayerColor:create(cc.c4b(0,0,0,200))
    _ckipperSprite:setContentSize(bg:getContentSize().width, bg:getContentSize().height)
    local _clipper = cc.ClippingNode:create(_ckipperSprite)
    _clipper:setPosition(0, 2)
    _clipper:setAlphaThreshold(1.0)

    _clipper:addChild(self.bg)
    self:addChild(_clipper)
end

function BannerCursor:onInitView()
end

function BannerCursor:onUpdateView()
end

function BannerCursor:runCursorAct()
    if self.selectImg then
        self.bg:setSpriteName(self.selectImg)
    end
    if self.cursor == nil and self.cursorImg then
        self.cursor = UI.Image:create()
        self.cursor:init(self.cursorImg)
        self.cursor:centerLeft(0)
        -- self.cursor:centerLeft(self.cursor:getContentSize().width * -1)
        self.bg:addChild(self.cursor)
        -- self.cursor:refreshPosition()
        -- local posX = self.cursor:getPositionX()
        -- local actionFunc =  cc.CallFunc:create(function()
        --     self.cursor:setPositionX(self.cursor:getContentSize().width * -1)
        -- end)
        -- local action = cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(5, cc.p(self.bg:getContentSize().width, self.cursor:getPositionY())), actionFunc))
        -- self.cursor:runAction(action)
    end
end

function BannerCursor:removeCursorAct()
    if self.cursor then
        self.cursor:removeFromParent()
        self.cursor = nil
    end
    self.bg:setSpriteName(self.normalImg)
end
--[[
    -- DropFragment.lua
    -- Author:ydli
    -- 2018年2月2日
    -- Using:获取物品类的子类  道具碎片  的飞行道具 UI
]]--

require "app.object.aircraft.Aircraft"
require "app.object.geometric.GeometricRect"
require "app.game.GameDefine"
require "utils.message.MessageCenter"


UI = UI or {}

local DropFragment = class("DropFragment", UI.HWBtnComponent)
UI.DropFragment = DropFragment
local FILE_NAME = "image/fragment/"
local layerSize = cc.size(700, 300) 
local fragmentSize = cc.size(280, 280)
local winSize = cc.Director:getInstance():getWinSize()
-- private:
-- 构造函数
function DropFragment:ctor(goodsData)
    print("----DropFragment:ctor goodsId = "..goodsData:getGoodsID())
    DropFragment.super.ctor(self, 0, {"ui_package_task.plist"}, layerSize.width, layerSize.height)
    self:init(goodsData)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self.isPlay = true
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
end

-- 析构函数
function DropFragment:dtor()
    DropFragment.super.dtor(self)
    self:unRegisterListener()
    self.isPlay = false
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_FRAGMENT_DROP, self.goodsData)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)
    if self.fileName then
        cc.Director:getInstance():getTextureCache():removeTextureForKey(self.fileName)
    end
end

function DropFragment:init(goodsData)
    self.goodsData = goodsData
    DropFragment.super.init(self)
end

-- 初始化
function DropFragment:onInitView()
    print("----DropFragment:onInitView goodsId = "..self.goodsData:getGoodsID())
    local bg = UI.Layout:create()
    bg:init()
    bg:setSize(layerSize.width, layerSize.height)
    bg:center()
    -- bg:enableDebugDraw()
    self:addChild(bg)

    local bgImage = UI.Image:create()
    bgImage:init("ui_task_teasuremap_bg.png")
    bgImage:centerLeft(180)
    bg:addChild(bgImage)
-- 
    self.fileName = FILE_NAME..self.goodsData.value3
    local icon = cc.Sprite:create()
    icon:initWithFile(self.fileName)
    icon:getTexture():setAntiAliasTexParameters();
    bg:addChild(icon, 10)       
    
    local pointArray = AvalonUtil:splitStr(self.goodsData.value4,';')
    local pointX = tonumber(pointArray[1])
    local pointY = tonumber(pointArray[2])
    icon:setAnchorPoint(pointX / icon:getContentSize().width, pointY / icon:getContentSize().height)
    icon:setPosition(layerSize.width / 5, layerSize.height / 2 )

    local scaleX =  fragmentSize.width / icon:getContentSize().width
    local scaleY =  fragmentSize.height / icon:getContentSize().height
    local scale = scaleX > scaleY and scaleY or scaleX --取最小缩放值
    scale = scale > 1 and 1 or scale --只缩小 不放大 
    icon:setScale(scale)
   


    local settlementBgAnimation = UI.Animation:create()
    settlementBgAnimation:init("effect_ui_common_settlement.json", "effect_ui_common_settlement.atlas")
    settlementBgAnimation:center()
    icon:addChild(settlementBgAnimation, -1)
    settlementBgAnimation:setAnimation("begin", false)
    settlementBgAnimation:addAnimation("idle", true)


    local title = UI.Text:create()
    title:init(UI.TEXT_1110503, "", UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
    title:leftUp(450 - title:getContentSize().width / 2, 98)
    bg:addChild(title)

    local decorateLeft = UI.Image:create()
    decorateLeft:init("ui_task_teasuremap_tilte.png")
    decorateLeft:leftUp(title:getLeft() - decorateLeft:getContentSize().width - 10, 97)
    bg:addChild(decorateLeft)

    local decorateRight = UI.Image:create()
    decorateRight:init("ui_task_teasuremap_tilte.png")
    decorateRight:rotate(180)
    decorateRight:leftUp(title:getLeft() + title:getContentSize().width + 10, 97)
    bg:addChild(decorateRight)

    local LanguageManager = require("app.game.LanguageManager")
    -- local des = LanguageManager:getInstance():getLocalString(tonumber(self.goodsData.value2))
    -- des = AvalonUtil:getSubNameStr(des, 3200, 16, true)
    -- des = "dasdasdjlkjkjlkasd"
    local desText = UI.Text:create()
    desText:init(UI.TEXT_1212322, UI.FONT_STANDARD , UI.FONT_SIZE_16PX)
    desText:setSize(350, 90)
    desText:setFontColor(UI.FONT_COLOR_255_255_255)
    desText:leftUp(275, 120)
    desText:setTextCenter()
    bg:addChild(desText)

    self.isPlay = true
    bg:setScale(0.1)
    bg:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
        self.isPlay = false
    end)))

    self.decorateLeft = decorateLeft
    self.decorateRight = decorateRight
    self.title = title
    self.desText = desText
end

function DropFragment:onUpdateView()
    Avalon.AudioManager:playSound("1043")
end

-- 注册监听事件(可选)
function DropFragment:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
    self:addEventListener(UI.Event.COMPONENT_CLICK, self,function ()
        self:onTouchDialogOutsizeHandler()
    end)
end

function DropFragment:onTouchDialogOutsizeHandler()
    print("-----------DropFragment:onTouchDialogOutsizeHandler()")
    -- 
    if self.isPlay then
        return
    end
    self.decorateLeft:hide()
    self.decorateRight:hide()
    self.title:hide()
    self.desText:hide()
    self:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.6, 0.01), cc.MoveBy:create(0.6,cc.p(0, 0))), cc.CallFunc:create(function()
        self:close()
    end)))
end

-- 注销监听事件(可选)
function DropFragment:unRegisterListener()

end
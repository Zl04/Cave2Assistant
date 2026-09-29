--[[
    -- RuneMoldDropFragment.lua
    -- Author:ydli
    -- 2018年2月2日
    -- Using:获取物品类的子类  道具碎片  的飞行道具 UI
]]--

require "app.object.aircraft.Aircraft"
require "app.object.geometric.GeometricRect"
require "app.game.GameDefine"
require "utils.message.MessageCenter"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()

UI = UI or {}

local RuneMoldDropFragment = class("RuneMoldDropFragment", UI.HWBtnComponent)
UI.RuneMoldDropFragment = RuneMoldDropFragment
local FILE_NAME = "image/mold/"
local layerSize = cc.size(700, 300) 
local fragmentSize = cc.size(280, 280)
local winSize = cc.Director:getInstance():getWinSize()
-- private:
-- 构造函数
function RuneMoldDropFragment:ctor(goodsData)
    print("----RuneMoldDropFragment:ctor goodsId = "..goodsData:getGoodsID())
    RuneMoldDropFragment.super.ctor(self, 0, {"ui_town_rune_mold.plist"}, layerSize.width, layerSize.height)
    self:init(goodsData)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self.isPlay = true
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
end

-- 析构函数
function RuneMoldDropFragment:dtor()
    RuneMoldDropFragment.super.dtor(self)
    self:unRegisterListener()
    self.isPlay = false
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_FRAGMENT_DROP, self.goodsData)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)
    if self.fileName then
        cc.Director:getInstance():getTextureCache():removeTextureForKey(self.fileName)
    end
end

function RuneMoldDropFragment:init(goodsData)
    self.goodsData = goodsData
    RuneMoldDropFragment.super.init(self)
end

-- 初始化
function RuneMoldDropFragment:onInitView()
    print("----RuneMoldDropFragment:onInitView goodsId = "..self.goodsData:getGoodsID())
    local bg = UI.Layout:create()
    bg:init()
    bg:setSize(layerSize.width, layerSize.height)
    bg:center()
    -- bg:enableDebugDraw()
    self:addChild(bg)

    local bgImage = UI.Image:create()
    bgImage:init("ui_mold_teasuremap.png")
    bgImage:centerLeft(180)
    bg:addChild(bgImage)

    self.fileName = FILE_NAME..self.goodsData.value3
    local icon = cc.Sprite:create()
    icon:initWithFile(self.fileName)
    icon:getTexture():setAntiAliasTexParameters();
    bg:addChild(icon, 10)    
    -- icon:centerLeft() 
    
    -- local pointArray = AvalonUtil:splitStr(self.goodsData.value4,';')
    -- local pointX = 70--tonumber(pointArray[1])
    -- local pointY = 90--tonumber(pointArray[2])
    icon:setAnchorPoint(0.3, 0.5)--(pointX / icon:getContentSize().width, pointY / icon:getContentSize().height)
    icon:setPosition(layerSize.width / 5, layerSize.height / 2 )

    local scaleX =  fragmentSize.width / icon:getContentSize().width
    local scaleY =  fragmentSize.height / icon:getContentSize().height
    local scale = scaleX > scaleY and scaleY or scaleX --取最小缩放值
    scale = scale > 1 and 1 or scale --只缩小 不放大 
    icon:setScale(scale)
   


    local settlementBgAnimation = UI.Animation:create()
    settlementBgAnimation:init("effect_ui_mold_show_guang.json", "effect_ui_mold_show_guang.atlas")
    settlementBgAnimation:center()
    icon:addChild(settlementBgAnimation, -1)
    settlementBgAnimation:setAnimation("begin", false)
    settlementBgAnimation:addAnimation("idle", true)

    local name = languageManagerInstance:getLocalString(self.goodsData.name)
    local title = UI.Text:create()
    title:init(name, "", UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
    title:leftUp(450 - title:getContentSize().width / 2, 105)
    bg:addChild(title)

    -- local decorateLeft = UI.Image:create()
    -- decorateLeft:init("ui_task_teasuremap_tilte.png")
    -- decorateLeft:leftUp(title:getLeft() - decorateLeft:getContentSize().width - 10, 97)
    -- bg:addChild(decorateLeft)

    -- local decorateRight = UI.Image:create()
    -- decorateRight:init("ui_task_teasuremap_tilte.png")
    -- decorateRight:rotate(180)
    -- decorateRight:leftUp(title:getLeft() + title:getContentSize().width + 10, 97)
    -- bg:addChild(decorateRight)

    local des = languageManagerInstance:getLocalString(tonumber(self.goodsData.value2))
    local desText = UI.Text:create()
    desText:init(des, UI.FONT_STANDARD , UI.FONT_SIZE_16PX)
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

    -- self.decorateLeft = decorateLeft
    -- self.decorateRight = decorateRight
    self.title = title
    self.desText = desText
end

function RuneMoldDropFragment:onUpdateView()
    Avalon.AudioManager:playSound("1043")
end

-- 注册监听事件(可选)
function RuneMoldDropFragment:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
    self:addEventListener(UI.Event.COMPONENT_CLICK, self,function ()
        self:onTouchDialogOutsizeHandler()
    end)
end

function RuneMoldDropFragment:onTouchDialogOutsizeHandler()
    print("-----------RuneMoldDropFragment:onTouchDialogOutsizeHandler()")
    -- 
    if self.isPlay then
        return
    end
    -- self.decorateLeft:hide()
    -- self.decorateRight:hide()
    self.title:hide()
    self.desText:hide()
    self:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.6, 0.01), cc.MoveBy:create(0.6,cc.p(0, 0))), cc.CallFunc:create(function()
        self:close()
    end)))
end

-- 注销监听事件(可选)
function RuneMoldDropFragment:unRegisterListener()

end
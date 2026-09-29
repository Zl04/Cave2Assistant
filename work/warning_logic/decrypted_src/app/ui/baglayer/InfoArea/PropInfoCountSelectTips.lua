--[[
    UI - 背包中的道具数量选择tips
]]--

require "app.ui.Component"
require "app.ui.common.Image"
require "app.ui.common.Button"
require "app.ui.common.Text"
require "app.ui.common.ProgressTimer"

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local PropInfoCountSelectTips = class("PropInfoCountSelectTips",UI.HWBtnComponent)
UI.PropInfoCountSelectTips = PropInfoCountSelectTips

local LEAVE_TEAM_TIPS_PLIST = {
    "ui_general_tips.plist",
    "ui_general_shop.plist",
    "ui_shop_article_2.plist",
}

local COM_WIDTH = 428
local COM_HEIGHT = 288
local winSize = cc.Director:getInstance():getWinSize()

--  构造函数
function PropInfoCountSelectTips:ctor()
    print("PropInfoCountSelectTips:ctor")

    self._cancelCallFun = nil 
    self._okCallFun = nil 

    PropInfoCountSelectTips.super.ctor(self,UIType.PROP_AMOUNT_TIPS,LEAVE_TEAM_TIPS_PLIST, COM_WIDTH, COM_HEIGHT)
end

--  初始化函数
function PropInfoCountSelectTips:init(maxAmount)
    self._maxAmount = maxAmount
    PropInfoCountSelectTips.super.init(self)
end

--  点击确定按钮 
local function onConfirmButton(self)
    if(self._okCallFun ~= nil ) then 
        self._okCallFun(self.curSelectNum) 
    end 
    self:close()  
end

--  点击取消按钮
local function onCancleButton(self)
    self:close()   
    if(self._cancelCallFun ~= nil ) then 
    end 
end

-- 点击外部区域的处理器(关闭)
local function onTouchDialogOutsizeHandler(self)
    self:close()
end

--  初始化界面函数
function PropInfoCountSelectTips:onInitView()
    self.curSelectNum = 1
    self.lastSelectNum = 0

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
    
    -- 背景
    local maskLayout = UI.Layout:create();
    maskLayout:init()
    maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    maskLayout:center()
    maskLayout:setTouchEnable(true)
    maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() 
        self:close() 
    end)
    self:addChild(maskLayout)

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box3.png")
    bgImage:setContentSize(COM_WIDTH, COM_HEIGHT)
    bgImage:setCapInsets(CCRectMake(COM_WIDTH/2, COM_HEIGHT/2, 1, 1))
    bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self:addChild(bgImage, 1)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    --contentLayout:enableDebugDraw()
    bgImage:addChild(contentLayout)
    self.contentLayout = contentLayout

    local numMin = UI.Text:create()
    numMin:init("1", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numMin:leftUp(54, 95)
    self.contentLayout:addChild(numMin)
    self.numMinTxt = numMin

    local numPrgBar = UI.ProgressTimer:create()
    numPrgBar:init("ui_shop_article_1.png", nil, "ui_shop_article_2.png")
    numPrgBar:leftUp(95, 100)
    numPrgBar:setPercent(0)
    self.contentLayout:addChild(numPrgBar)
    self.numPrgBar = numPrgBar

    local maxX = numPrgBar:getContentSize().width

    local numPopPlus  = UI.Image:create();
    numPopPlus:init("ui_shop_article_3.png");
    local offsetX = numPopPlus:getContentSize().width/2
    numPopPlus:centerLeft(-offsetX);
    numPopPlus:setTouchEnable(true)
    numPopPlus:setSwallowTouches(true)
    self.numPopPlus = numPopPlus
    self.originOffsetX = offsetX
    numPopPlus:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, function(self, com, touchpos)

        local deltaX = touchpos.x-com:Local2Global().x

        if com:getPositionX()+deltaX <= -offsetX then
            com:setPosition(-offsetX, com:getPositionY())
        end
        if com:getPositionX()+deltaX >= maxX-offsetX then
            com:setPosition(maxX-offsetX, com:getPositionY())
        end
        if com:getPositionX()+deltaX > -offsetX and com:getPositionX()+deltaX < maxX-offsetX then
            com:setPosition(com:getPositionX()+deltaX, com:getPositionY())
        end

        local curX = com:getPositionX()+offsetX
        if curX == 0 then
            self.numPopTxt:setText("1")
            self.curSelectNum = 1
        else
            local realNum = math.floor(self._maxAmount * curX/maxX)
            if realNum == 0 then
                realNum = 1
            end
            self.numPopTxt:setText(tostring(realNum))
            self.curSelectNum = realNum
        end

        self.numPrgBar:setPercent(curX/maxX)

        if self.curSelectNum ~= self.lastSelectNum then
            self.lastSelectNum = self.curSelectNum
        end
    end)

    numPrgBar:addChild(numPopPlus, 10);

    local numBG  = UI.Image:create();
    numBG:init("ui_shop_article_4.png");
    numBG:leftUp(-15, -60);
    numPopPlus:addChild(numBG);

    local numTxt = UI.Text:create()
    numTxt:init(tostring(self.curSelectNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numTxt:centerUp(2)
    numBG:addChild(numTxt)
    self.numPopTxt = numTxt

    local numMax = UI.Text:create()
    numMax:init(tostring(self._maxAmount), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    numMax:leftUp(360, 95)
    self.contentLayout:addChild(numMax)
    self.numMaxTxt = numMax

    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, onCancleButton)
    no:leftBottom(51, 32)
    self.contentLayout:addChild(no)

    -- 确认按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, onConfirmButton)
    yes:rightBottom(51, 32)
    self.contentLayout:addChild(yes)
end

-- 传递回调函数名字
function PropInfoCountSelectTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end
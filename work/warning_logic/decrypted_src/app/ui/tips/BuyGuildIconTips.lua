-- BuyGuildIconTips.lua
-- Author:zp
-- 2017年9月25日
-- Using:购买公会图标

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local BuyGuildIconTips = class("BuyGuildIconTips",UI.HWBtnComponent)
UI.BuyGuildIconTips = BuyGuildIconTips
--  ui_tips_team
local VOTE_SUCCEED_TIPS_PLIST = {
}


local function onCancelHandler(self)

    self:close();
end

local function onOkHandler(self)
    if(self._okCallFun) then 
        self._okCallFun()
    end
    self:close();
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    -- self:close();
end

--  构造函数
function BuyGuildIconTips:ctor()
    BuyGuildIconTips.super.ctor(self, UIType.BUY_GUILD_ICON_TIPS, VOTE_SUCCEED_TIPS_PLIST, winSize.width, winSize.height)
    self.iconData = nil
    self._cancelCallFun = nil 
    self._okCallFun = nil 
end

--  析构函数 调用父类的方法
function BuyGuildIconTips:dtor()
    BuyGuildIconTips.super.dtor(self)
end

--  初始化函数
function BuyGuildIconTips:init(guildIconData)
    self.iconData = guildIconData
    BuyGuildIconTips.super.init(self)
end

--  初始化界面函数
function BuyGuildIconTips:onInitView()
    self:setTouchEnable(true)
    self:setInterceptTouches(true)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local bg = UI.Image:create()
    self._bg = bg
    bg:init("ui_setup_banner_box3.png")
    bg:center()
    self:addChild(bg)

    local iconBg = UI.Image:create()
    iconBg:init("ui_guild_headframe_big.png")
    iconBg:centerUp(67-iconBg:getContentSize().height/2)
    bg:addChild(iconBg)

    local icon = UI.Image:create()
    icon:init(self.iconData.iconSpriteName)
    icon:center()
    iconBg:addChild(icon)

    local desBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_setup_banner_box_up.png", cc.rect(0,0,1,1))
    desBg:setContentSize(cc.size(370, 64))  
    desBg:setAnchorPoint(cc.p(0, 0))
    desBg:setPosition(cc.p(30, 93))
    bg:addChild(desBg)

    local buyText = UI.Text:create()
    buyText:init(LanguageManager:getInstance():getLocalString(1110621),UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyText:setTextCenter()
    buyText:setWidth(322)
    buyText:centerUp(131 + 32 - buyText:getContentSize().height)
    bg:addChild(buyText)

    -- 取消按钮
    local button = UI.Button:create()
    button:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
    button:leftBottom(51, 32)
    bg:addChild(button)

    -- 确认购买按钮
    local button = UI.Button:create()
    button:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onOkHandler)
    button:rightBottom(51, 32)
    bg:addChild(button)

    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
end

-- 传递回调函数名字
function BuyGuildIconTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end

-- 更新视图
function BuyGuildIconTips:onUpdateView()

end
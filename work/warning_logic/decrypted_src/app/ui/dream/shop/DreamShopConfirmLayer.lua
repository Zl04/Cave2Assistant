-- DreamShopConfirmLayer.lua
-- Author:lzm
-- 2019年3月1日
-- Using:梦境商店兑换确认框

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local DreamShopConfirmLayer = class("DreamShopConfirmLayer", UI.BaseWin)
UI.DreamShopConfirmLayer = DreamShopConfirmLayer

local winSize = cc.Director:getInstance():getWinSize()

local VIEW_WIDTH = 430;
local VIEW_HEIGHT = 290;

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_shopping.plist",
}

--构造函数(必备)
function DreamShopConfirmLayer:ctor()
    --窗口大小
    DreamShopConfirmLayer.super.ctor(self, UIType.DREAM_SHOP_CONFIRM_LAYER, COM_RES_LIST, VIEW_WIDTH, VIEW_HEIGHT)
    self:setTouchEnable(true);
    self:setInterceptTouches(true);

    self.diamond = 0;
end

--虚构函数,destroy时调用(必备)
function DreamShopConfirmLayer:dtor()
    DreamShopConfirmLayer.super.dtor(self)

    self.diamond = nil;
end

-- 初始化(必备)
function DreamShopConfirmLayer:init(cost)
    self.diamond = tostring(cost)
    DreamShopConfirmLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function DreamShopConfirmLayer:onInitView()
    local range = UI.Layout:create();
    range:init();
    range:center();
    range:setSize(VIEW_WIDTH, VIEW_HEIGHT);
    self:addChild(range);
    -- range:enableDebugDraw()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    range:addChild(mask)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_setup_banner_box3.png")
    bg:center()
    range:addChild(bg)

    local splitbg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_setup_banner_box_up.png")
    splitbg:setContentSize(369, 125)
    splitbg:setPosition(430/2, 252-125/2)
    bg:addChild(splitbg)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light2.png")
    splitLine:setContentSize(371, 2)
    splitLine:setPosition(430/2, 252)
    bg:addChild(splitLine)

    -- txt1
    local titleText1 = UI.Text:create()
    titleText1:init(UI.TEXT_1212302, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    titleText1:centerUp(37)
    splitbg:addChild(titleText1)

    -- txt2
    local titleText2 = UI.Text:create()
    titleText2:init(UI.TEXT_1212303, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    titleText2:rightUp(200, 60)
    titleText2:floatLeft(0)
    titleText2:autoAdapt()
    splitbg:addChild(titleText2)

    -- 需要花费的水晶数量
    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_dreamword.png")
    diamondIcon:leftUp(174, 60)
    splitbg:addChild(diamondIcon, 10)

    -- 花费的水晶数量
    local diamondCost  = UI.Text:create();
    diamondCost:init(self.diamond, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45);
    diamondCost:floatRight(0);
    diamondCost:leftUp(206, 60);
    splitbg:addChild(diamondCost, 10);

    local btn1 = UI.Button:create();
    btn1:init("ui_btn_no1_0.png","ui_btn_no1_0.png","ui_btn_no1_0.png");
    btn1:leftBottom(53, 33);
    btn1:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:closeWin();
    end)
    range:addChild(btn1);

    local btn2 = UI.Button:create();
    btn2:init("ui_btn_yes1_1.png","ui_btn_yes1_1.png","ui_btn_yes1_1.png");
    btn2:rightBottom(56, 33);
    btn2:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:closeWin();
        if self.okCallback then
            self.okCallback()
        end
    end)
    range:addChild(btn2);
end

function DreamShopConfirmLayer:openShow()
    self:open()
end

function DreamShopConfirmLayer:setCallback(callback)
    self.okCallback = callback
end
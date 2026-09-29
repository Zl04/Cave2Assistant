-- BindAccountTips.lua
-- Author:zp
-- 2018年10月23日
-- Using:绑定账号

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local BindAccountTips = class("BindAccountTips",UI.HWBtnComponent)
UI.BindAccountTips = BindAccountTips
--  ui_tips_team
local VOTE_SUCCEED_TIPS_PLIST = {
}


local function onCancelHandler(self)

    self:close();
end

local function onConfirmHandler(self)
    if(self._okCallFun) then 
        self._okCallFun()
    end
    self:close();
end

local function onCenterHandler(self)
    if(self._centerCallFun) then 
        self._centerCallFun()
    end
    self:close();
end


-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    -- self:close();
end

--  构造函数
function BindAccountTips:ctor()
    BindAccountTips.super.ctor(self,UIType.BIND_ACCOUNT_TIPS,VOTE_SUCCEED_TIPS_PLIST, winSize.width, winSize.height)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
    self._centerCallFun = nil
end

--  析构函数 调用父类的方法
function BindAccountTips:dtor()
    BindAccountTips.super.dtor(self)
end

--  初始化函数
function BindAccountTips:init()
    BindAccountTips.super.init(self)
end

--  初始化界面函数
function BindAccountTips:onInitView()
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
    self:setSize(bg._width,bg._height)

    local contentBg = UI.Image9:create()
    contentBg:init("ui_scale9image_setup_banner_box_up.png", {x = 0, y = 0, width = 20, height = 20})
    contentBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentBg:centerUp(36)
    contentBg:setReflectSize(370, 84)
    contentBg:computePosition()
    bg:addChild(contentBg)

    local titleText = UI.Text:create() 
    titleText:init(UI.TEXT_111155, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(36 + 42- titleText:getContentSize().height/2)
    titleText:setWidth(322)
    titleText:setTextCenter()
    bg:addChild(titleText, 10)


    local confirmButton = UI.Button:create()
    confirmButton:init("ui_setup_button_language_0.png", "ui_setup_button_language_1.png", "ui_setup_button_language_0.png")
    confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, onConfirmHandler)
    confirmButton:openClickScale()
    self._bg:addChild(confirmButton, 10)
    confirmButton:setTextFont(UI.FONT_BOLD,UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    confirmButton:setText(UI.TEXT_1170211)

    local cancleButton = UI.Button:create()
    cancleButton:init("ui_setup_button_language_0.png", "ui_setup_button_language_1.png", "ui_setup_button_language_0.png")
    cancleButton:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
    self._bg:addChild(cancleButton, 10)
    cancleButton:setTextFont(UI.FONT_BOLD,UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    cancleButton:setText(UI.TEXT_110012)
    cancleButton:openClickScale()
    

    local centerButton = UI.Button:create()
    centerButton:init("ui_setup_button_language_0.png", "ui_setup_button_language_1.png", "ui_setup_button_language_0.png")
    centerButton:addEventListener(UIEvent.BUTTON_CLICK, self, onCenterHandler)
    self._bg:addChild(centerButton, 10)
    centerButton:setTextFont(UI.FONT_BOLD,UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    centerButton:setText(UI.TEXT_111154)
    centerButton:openClickScale()

    
    confirmButton:centerUp(131)
    centerButton:centerUp(181)
    cancleButton:centerUp(233)
end

-- 传递回调函数名字
function BindAccountTips:callfunName(okCallFun,cancelCallFun, centerCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
    self._centerCallFun = centerCallFun
end

-- 更新视图
function BindAccountTips:onUpdateView()

end
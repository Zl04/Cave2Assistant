-- RemouldCloseLayer.lua
-- Author:siyu
-- 2023年8月23日
-- Using:改造 

require "app.ui.shoplayer.BagGoodsPanel"
local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.EquipWorkshop")

UI = UI or {}

local RemouldCloseLayer = class("RemouldCloseLayer", UI.HWBtnComponent)
UI.RemouldCloseLayer = RemouldCloseLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local COM_WIDTH = 852
local COM_HEIGHT = 534


-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_common_btn.plist",
    "ui_login.plist",
}

--构造函数(必备)
function RemouldCloseLayer:ctor()
    --窗口大小
    RemouldCloseLayer.super.ctor(
    self,UIType.REMOULD_LAYER,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )
    self.rootLayer = nil;           --root节点
end

--虚构函数,destroy时调用(必备)
function RemouldCloseLayer:dtor()
    RemouldCloseLayer.super.dtor(self)
end

-- 初始化(必备)
function RemouldCloseLayer:init()
    RemouldCloseLayer.super.init(self)

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        -- mvc.closePanel("BigSailIsland", "BigSailIslandInfo")
        --self:close()
    end)
end


-- 模版函数：初始化组建的视图(必备)
function RemouldCloseLayer:onInitView()
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    --mask:setPosition(self._width / 2, self._height / 2)
    self.contentLayout:addChild(mask)

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_paper.png")
    --bgImage:setContentSize(COM_WIDTH, COM_HEIGHT)
    --bgImage:setCapInsets(CCRectMake(430/2, 288/2, 1, 1))
    --bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self.contentLayout:addChild(bgImage)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222300, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    titleText:center(0, -125)
    bgImage:addChild(titleText)

    local contentText = UI.Text:create()
    contentText:init(UI.TEXT_226606, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_60_58_46)
    contentText:center(0, -15)
    contentText:setSize(370,150)
    contentText:setTextCenter()
    bgImage:addChild(contentText)

    -- 取消按钮
    local no = UI.Button:create()
    no:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_0.png")
    no:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local parent = self:getParent()
        if parent.mCloseLayer then
            parent.mCloseLayer = nil
        end
        self:close()
    end)
    no:center(120, 110)
    bgImage:addChild(no)

    -- 确认按钮
    local yes = UI.Button:create()
    yes:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
    yes:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local parent = self:getParent()
        if parent then
            parent.mCloseLayer = nil
            parent.mIsRunningInherit = false
            self:close()
            parent:closeWin()
        end
    end)
    yes:center(-110, 110)
    bgImage:addChild(yes)
end


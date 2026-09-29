------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/08/15
--desc	: 
------------------------------------------------------------------------------
require "app.ui.common.Tab.TabList"
require "app.ui.baglayer.FunctionTabItem"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorDressUpShelfView = class("ManorDressUpShelfView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_illusion.plist",
    "ui_common_btn.plist",
    "ui_bg_paper3.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 1111
local COM_HEIGHT = 564

local ModelPageType = {
    Model_Invalid       = 0,       -- 无效的
    Model_Operation     = 1,       -- 幻化操作界面
    Model_Upgrade       = 2,       -- 升级
    Model_Pokedex       = 3,       -- 图鉴
    Model_Max           = 4        -- 最大值
}

local winSize = cc.Director:getInstance():getWinSize()

-- 图片名字
local BUTTON_NORMAL = "ui_btn_gray2_0.png"
local BUTTON_ACTIVE = "ui_btn_gray2_1.png"
local BUTTON_DISABLE = "ui_btn_gray2_2.png"

function ManorDressUpShelfView:ctor(shelfIndex)
    ManorDressUpShelfView.super.ctor(
    	self,
    	UI.Type.DRESS_UP_SHELF,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._pageType = ModelPageType.Model_Invalid
    self._shelfIndex = shelfIndex or 1
end

function ManorDressUpShelfView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manordressupshelf", "ManorDressUpShelf", false)
    ManorDressUpShelfView.super.init(self, ... )
end

function ManorDressUpShelfView:dtor()
    ManorDressUpShelfView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manordressupshelf.ManorDressUpShelfView")
end


function ManorDressUpShelfView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_illusionstand_bg.png")
    bg:center()
    self:addChild(bg)
    self._bg = bg

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:updatePageView(ModelPageType.Model_Operation)
    -- self._pageTable = {}

    local ModelPageName = {
        [ModelPageType.Model_Operation] = UI.TEXT_222801,
        [ModelPageType.Model_Upgrade] = UI.TEXT_222800,
        [ModelPageType.Model_Pokedex] = UI.TEXT_222802,
    }

    local functionTabList = UI.TabList:create()
    functionTabList:init(3,114,64)
    functionTabList:leftUp(1010, 45)
    functionTabList:setTouchEnable(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex)
        self:updatePageView(tabIndex)
    end)
    functionTabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    self._functionTabList = functionTabList
    self._functionTabList:setReverseOrder(true)

    for i = ModelPageType.Model_Operation, ModelPageType.Model_Max - 1 do
        local functionTab = UI.FunctionTabItem:create()
        functionTab:init(BUTTON_NORMAL, BUTTON_ACTIVE, BUTTON_DISABLE, ModelPageName[i], UI.FONT_BOLD, UI.FONT_SIZE_20PX)
        functionTabList:addToTab(functionTab, i)
        functionTab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
        functionTab:getTextLabel():setWidth(80)
        functionTab:getTextLabel():setTextCenter()
    end

    self._functionTabList:setDefaultIndex(ModelPageType.Model_Operation)
    self._bg:addChild(functionTabList)

    local titleBg = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:centerUp(-22)
    self._bg:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222801, UI.FONT_BOLD, UI.FONT_SIZE_26PX, {r=144,g=144,b=144})
    titleText:center()
    titleBg:addChild(titleText)

end

function ManorDressUpShelfView:updatePageView(pageType)
    if pageType == nil or pageType == self._pageType then
        return
    end

    self.contentLayout:removeAllChildren()

    self._pageType = pageType

    self._upgradeView = nil
    self._operationView = nil
    self._pokedexView = nil

    if self._pageType == ModelPageType.Model_Upgrade then
        local view = mvc.manorDressUpShelfUpgradeView:create()
        view:init()
        view:leftBottom(0,0)
        self.contentLayout:addChild(view)

        self._upgradeView = view
    elseif self._pageType == ModelPageType.Model_Operation then
        local view = mvc.manorDressUpShelfOperationView:create(self._shelfIndex)
        view:init()
        view:leftBottom(0,0)
        self.contentLayout:addChild(view)

        self._operationView = view
    elseif self._pageType == ModelPageType.Model_Pokedex then
        local view = mvc.manorDressUpShelfPokedexView:create()
        view:init()
        view:leftBottom(0,0)
        self.contentLayout:addChild(view)

        self._pokedexView = view
    end

end

function ManorDressUpShelfView:bindModel()

end


function ManorDressUpShelfView:unbindModel()

end





return ManorDressUpShelfView













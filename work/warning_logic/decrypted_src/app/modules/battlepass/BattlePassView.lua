------------------------------------------------------------------------------
--author: 
--date	: 2019/08/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BattlePassView = class("BattlePassView", UI.HWBtnComponent)
require("app.ui.common.CurrencyPanel")

-- 资源
local COM_RES_LIST = {
    "ui_town_passcheck.plist",
    "ui_general_shopping.plist",
    "ui_common_information.plist"
}
local LAYOUT = {
    TAB_LIST_LEFT = 900,
    TAB_LIST_UP = 75,
    TAB_ITEM_SPACE = 3,
    TAB_ITEM_WIDTH = 114,
    TAB_ITEM_HEIGHT = 64
}

local COM_WIDTH = 915
local COM_HEIGHT = 590
local layoutUU
function BattlePassView:ctor()
    BattlePassView.super.ctor(
    	self,
    	UI.Type.BATTLE_PASS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    layoutUU = UIUtil:createAutoUILayout("BattlePassView","app.modules.battlepass.BattlePassPosConfig", false)

    local  sourceType = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_None
    Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_BattlePass, 1, nil, nil, sourceType)
end

function BattlePassView:dtor()
    BattlePassView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.battlepass.BattlePassView")
end


function BattlePassView:onInitView()
    self.rootLayer = self:createBg()
    self:createTabList()
    self:createCommonPanel()
    self:refreshDataCallback()
end


function BattlePassView:bindModel()
    mvc.battlePassModel:bind("PassRewardData", self, self.refreshDataCallback)
    mvc.battlePassModel:bind("BattlePassIcon", self, self.refreshBattlePassIcon)
end


function BattlePassView:unbindModel()
    mvc.battlePassModel:unbind("PassRewardData", self, self.refreshDataCallback)
    mvc.battlePassModel:unbind("BattlePassIcon", self, self.refreshBattlePassIcon)
end

function BattlePassView:refreshBattlePassIcon()
    self.momey:setText(RoleDataManager:getMaster():getBattlePassCoin())
end

function BattlePassView:refreshDataCallback()
    self.title1:setText(string.format(UI.TEXT_1212902, mvc.battlePassModel:getBattlePassSeasonId()))
    self.title3:leftUp(self.title1:getLeft() + self.title1:getContentSize().width + 2, self.title3:getUp())

    local level, curExp, curTotalExp = mvc.battlePassModel:getBattlePassLvAndExp()
    self.level:setText(string.format("lv.%d", level))
    if mvc.battlePassModel:isMaxLevel() then
        self.expIcon:hide()
        self.exp:hide()
        self.maxFlag:show()
        self.progress:setPercentage(100)
    else
        self.maxFlag:hide()
        self.expIcon:show()
        self.exp:show()
        if curTotalExp <= 0 then
            self.progress:setPercentage(0)
        else
            local percent = curExp / curTotalExp * 100
            percent = percent > 100 and 100 or percent
            self.progress:setPercentage(percent)
        end
        self.exp:setText(string.format(UI.TEXT_1212904, curExp, curTotalExp))
        self.expIcon:rightUp(self.exp:getRight() + self.exp:getContentSize().width + 10, self.expIcon:getUp())
    end
    self.momey:setText(RoleDataManager:getMaster():getBattlePassCoin())
    local startTime, endTime = mvc.battlePassModel:getBattlePassSeasonTime()
    self.title3:setText(string.format("(%s ~ %s)", os.date("%m/%d", startTime), os.date("%m/%d", endTime)))
     
    local button = self._tabList._compList[1]
    if button then
        if self.redPoint then
            if mvc.battlePassModel:isHaveRward() then
                self.redPoint:show()
            else
                self.redPoint:hide()
            end
        else
            if mvc.battlePassModel:isHaveRward() then
                self.redPoint = AvalonUtil.createRedPoint(button, 3, 3)
            end
        end
    end
end

function BattlePassView:createBg()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(-8)
    self:addChild(contentLayout)
    
    local board = UI.Image:create()
    board:init("ui_bg_box2.png")
    board:center()
    contentLayout:addChild(board, 1)

    local upLine = UI.Image:create()
    upLine:init("ui_bg_title.png")
    upLine:centerUp(-10)
    contentLayout:addChild(upLine, 12)

    local text =
        UIUtil:createAdaptTextComponent(
        UI.TEXT_1212900,
        UI.FONT_BOLD,
        UI.FONT_SIZE_26PX,
        UI.FONT_COLOR_155_155_155,
        200
    )
    text:center()
    upLine:addChild(text)
    
    return contentLayout
end

function BattlePassView:createTabList()
    -- tab控件
    local tabList = UI.TabList:create()
    tabList:init(LAYOUT.TAB_ITEM_SPACE, LAYOUT.TAB_ITEM_WIDTH, LAYOUT.TAB_ITEM_HEIGHT)
    tabList:leftUp(LAYOUT.TAB_LIST_LEFT, LAYOUT.TAB_LIST_UP)
    tabList:setReverseOrder(true)
    tabList:addEventListener(UIEvent.TAB_ACTIVE, self, self.onActiveTabHandler)
    tabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    for k, textStr in ipairs({UI.TEXT_1212901, UI.TEXT_1212227}) do
        local tab = UI.FunctionTabItem:create()
        tab:init(
            "ui_btn_gray2_0.png",
            "ui_btn_gray2_1.png",
            "ui_btn_gray2_2.png",
            textStr,
            UI.FONT_BOLD,
            UI.FONT_SIZE_20PX
        )
        tabList:addToTab(tab, k)
        tab:setFontColor(UI.FONT_COLOR_48_50_56, UI.FONT_COLOR_220_211_147, UI.FONT_COLOR_37_40_44)
        tab.onDisableClick = handler(self, self.tabDisableClick)
    end
    self._tabList = tabList
    self.rootLayer:addChild(tabList, 100)
end

function BattlePassView:tabDisableClick()
end

function BattlePassView:createCommonPanel()
    local currentLayout = UI.CurrencyPanel:create(UI.FONT_COLOR_204_204_204)
    currentLayout:leftUp(515, 55)
    currentLayout:setParentWin(self)
    -- currentLayout:enableDebugDraw()
    self.rootLayer:addChild(currentLayout, 100)

    self.passImage = UI.Image:create()
    self.passImage:init("symbol_gaming_passcheck.png")
    self.passImage:leftUp(360, 68)
    self.rootLayer:addChild(self.passImage, 100)

    self.momey = UI.NumberText:create(RoleDataManager:getMaster():getBattlePassCoin(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204, 20)
    self.momey:setTextLeft()
    self.momey:centerLeft(self.passImage:getContentSize().width + 5)
    self.passImage:addChild(self.momey, 4)


    local lvBg = UI.Image:create()
    lvBg:init("ui_passcheck_lv.png")
    lvBg:leftUp(53, 49)
    self.rootLayer:addChild(lvBg, 10)

    local level = UI.Text:create()
    level:init("lv.0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    level:centerBottom(14)
    lvBg:addChild(level)
    self.level = level

    local starButton = UI.Button:create() 
    starButton:init()
    starButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showStarInfo)
    starButton:setSize(50,50)
    starButton:rightUp(-8, -10)
    lvBg:addChild(starButton, 10)

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:center()
    starButton:addChild(detailAnimation, 10)

    local title1 = UI.Text:create()
    title1:init(string.format(UI.TEXT_1212902, 10), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_204_204_204)
    title1:leftUp(183, 108)
    self.rootLayer:addChild(title1, 10)
    self.title1 = title1

    local title3 =  UI.Text:create()
    title3:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_204_204_204)
    title3:leftUp(title1:getLeft() + title1:getContentSize().width - 8, 115)
    self.rootLayer:addChild(title3, 10)
    self.title3 = title3

    local progressbg = UI.Image:create()
    progressbg:init("ui_passcheck_banner_countdown_box.png")
    progressbg:leftUp(187, 145)
    self.rootLayer:addChild(progressbg, 100)

    local  progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_passcheck_banner_countdown.png"))
    progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    progress:setMidpoint(cc.p(0, 0))
    progress:setBarChangeRate(cc.p(1, 0))
    progress:setPercentage(99)
    progress:setAnchorPoint(0, 0)
    progress:setPosition(1, 1)
    progressbg:addChild(progress)
    self.progress = progress

    local expName = UI.Text:create()
    expName:init(string.format(UI.TEXT_1212904, 10, 100), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_102)
    expName:rightUp(194, 115)
    self.rootLayer:addChild(expName, 10)
    self.exp = expName

    local expIcon = UI.Image:create()
    expIcon:init("symbol_gaming_passcheck_xp.png")
    expIcon:rightUp(expName:getRight() + expName:getContentSize().width + 10, 111)
    self.rootLayer:addChild(expIcon, 10)
    self.expIcon = expIcon

    local addbutton = UI.Button:create()
    addbutton:init("ui_btn_yellow_0.png","ui_btn_yellow_1.png","ui_btn_yellow_2.png")
    addbutton:leftUp(732, 107)
    addbutton:addEventListener(UIEvent.BUTTON_CLICK,self, self.onAddClick)
    self.rootLayer:addChild(addbutton, 10)
    addbutton:setText(UI.TEXT_1212905)
    addbutton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)

    local max = UI.Image:create()
    max:init("ui_information_max_2.png")
    max:rightUp(190, 100)
    self.rootLayer:addChild(max, 10)
    self.maxFlag = max
end

function BattlePassView:showStarInfo()
    if self.infoPanel == nil or tolua.isnull(self.infoPanel) then
        local panel = UI.Image:create()
        panel:init("ui_information_banner_details.png")
        panel:centerLeft(190)
        self:getParent():addChild(panel, 100)
        local xAdd = 65
        local yAdd = 80
        local title = UI.Text:create()
        title:init(LanguageManager:getInstance():getLocalString(1112499), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
        panel:addChild(title) 
        title:centerUp(25 + yAdd)

        local line  = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
        line:setContentSize(282, 2)
        line:setCapInsets(CCRectMake(20,1,1,1))
        line:setPosition(160+xAdd, 382+yAdd)
        panel:addChild(line)

        local desc = UI.Text:create()
        desc:init(UI.TEXT_1212914, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
        desc:setWidth(280)
        desc:autoAdapt()
        desc:centerUp(1)

        local height = desc:getContentSize().height
        height = height < 320 and 320 or height
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(280, height)
        if height > 320 then
            local scrollView = UI.ScrollView:create()
            scrollView:setSize(290, 320)
            scrollView:init()
            scrollView:leftUp(25+xAdd, 67+yAdd)
            scrollView:addInnerNode(layout)
            scrollView:useDefaultScrollBar()
            panel:addChild(scrollView)    
        else
            layout:leftUp(25+xAdd, 67+yAdd)
            panel:addChild(layout)
        end
        layout:addChild(desc)

        local touch = UI.Component:create()
        touch:init()
        touch:setSize(310,410)
        touch:center()
        panel:addChild(touch)
    
        touch:setTouchEnable(true)
        touch:setInterceptTouches(true)
        touch:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, panel, function()
            panel:removeFromParent()
        end)
    else
        self.infoPanel:show()
    end
end

function BattlePassView:onActiveTabHandler(index)
    mvc.send("BattlePass_ChangeLayer", index)
end

function BattlePassView:onAddClick()
    print("--onAddClick--")
    mvc.openPanel("BattlePass", "BattlePassGuide")
end

return BattlePassView













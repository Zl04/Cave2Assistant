------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2023/12/28
--desc	: 
------------------------------------------------------------------------------

require "app.modules.bet.BetHistoryCell"
require "app.modules.bet.BetInfoCell"

local BetHistoryView = require("app.modules.bet.BetHistoryView")
local BetInfoView = require("app.modules.bet.BetInfoView")

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BetMainView = class("BetMainView", UI.HWBtnComponent)

local scheduler = cc.Director:getInstance():getScheduler()

-- 资源
local COM_RES_LIST = {
    "ui_town_navigation.plist",
    "ui_town_greatnavigation.plist",
    "ui_town_businessactivities.plist",
    "ui_common_btn.plist",
    "ui_town_rally.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local INNER_WIDTH = 980
local INNER_HEIGHT = 540

local FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM = 20
local FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_ACTV = 10
local FUNCTION_TAG_NEW_APPLY_REDPOINT_UP = 10
local TAB_ACTIVE_FONT_COLOR = {r = 220, g= 211, b = 147}


function BetMainView:ctor()
    print("BetMainView:ctor")
    BetMainView.super.ctor(
    self,
    UI.Type.RALLY_BET,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)

self.schedulerID = 0;
self:bindModel()

self.inDefaultTabIdx = 1
self._choiceTabIndex = -1

end

function BetMainView:init( ... )
    print("BetMainView:init")
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bet", "Bet", false)
    BetMainView.super.init(self, ... )
end

function BetMainView:dtor()
    BetMainView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bet.BetMainView")
    reload_script_file("app.modules.bet.BetHistoryCell")
    reload_script_file("app.modules.bet.BetHistoryCellInfo")
    reload_script_file_mvc("app.modules.bet.BetHistoryView")
    reload_script_file_mvc("app.modules.bet.BetInfoView")
end


function BetMainView:onInitView()
    print("BetMainView:onInitView")
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    
    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_businessactivities_bg.png")
    bg:center()
    contentLayout:addChild(bg)
    
    -- 历史记录标题
    local historyTitle  = UI.Image:create()
    historyTitle:init("ui_bg_title.png")
    historyTitle:center(0, -265)
    contentLayout:addChild(historyTitle)
    
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_227600, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_204_204_204)
    titleText:center(10,3)
    historyTitle:addChild(titleText)
    self._historyTitle = historyTitle

    -- 投注标题
    local betTitle  = UI.Image:create()
    betTitle:init("ui_rally_title.png")
    betTitle:center(0, -288)
    contentLayout:addChild(betTitle, 100)

    local betLayout = UI.Layout:create();
    betLayout:init()
    betLayout:enableAutoWidth()
    betLayout:enableAutoHeight()
    betLayout:centerBottom(10)
    betTitle:addChild(betLayout)
    self._betLayout = betLayout

    local betPreText = UI.Text:create()
    betPreText:init(UI.TEXT_227641, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r=254, g= 196, b= 39})
    betPreText:floatLeft(0)
    betLayout:addComponent(betPreText)

    local rallyBetGoodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.RALLY_BET)
    local betImage = UI.Image:create()
    betImage:init(rallyBetGoodsData:getSmallIconName())
    -- guessImage:centerRight(105)
    -- guessLayout:addChild(guessImage, 10)
    betImage:floatLeft(5)
    betLayout:addComponent(betImage)

    local betTitleText = UI.Text:create()
    betTitleText:init(AvalonUtil:getCommaNumber(mvc.betModel:getBetPoolNum()).."", UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r=254, g= 196, b= 39})
    betTitleText:floatLeft(5)
    betLayout:addComponent(betTitleText)

    self._betTitleText = betTitleText
    self._betTitle = betTitle
    self._betLayout = betLayout

    
    -- 内部背景图片
    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)
    
    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_navigation_bg_1.png")
    centerBg:center()
    contentLayout:addChild(centerBg, 10)
    self._centerBg = centerBg
    
    self:InitBet()
    self:InitBetHistory()
    
    self:InitFunctionBtn()
    self:choiceTabIndex(self.inDefaultTabIdx)

    -- 装饰
    self:initDecorate()
end


function BetMainView:bindModel()
    if(self.schedulerID == 0) then 
        self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 10, false)
    end
end

function BetMainView:unbindModel()
    if self.schedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
end

function BetMainView:InitBet()
    self._betInfoView = BetInfoView:create()
    self._betInfoView:init()
    self._betInfoView:leftUp(0, 0)
    self._centerBg:addChild(self._betInfoView,10)
    self._betInfoView:setVisible(false)
end

function BetMainView:update()
    -- 定时请求基础数据信息
    Net.NetBigSailSystem:reqBetBaseInfo(0)
end

function BetMainView:RefreshBet()
    
end

function BetMainView:InitBetHistory()
    self._betHistoryView = BetHistoryView:create()
    self._betHistoryView:init()
    self._betHistoryView:leftUp(0, 0)
    self._centerBg:addChild(self._betHistoryView, 10)
    self._betHistoryView:setVisible(false)
end

function BetMainView:RefreshBetHistory()
    
end


function BetMainView:InitFunctionBtn()
    -- 标签点击遮挡
    local clickBlocker = UI.Layout:create()
    clickBlocker:init()
    clickBlocker:setSize(100, 270)
    --clickBlocker:leftUp(912, 75)
    clickBlocker:leftUp(880, 8)
    clickBlocker:setTouchEnable(true)
    clickBlocker:setSwallowTouches(true)
    self.contentLayout:addChild(clickBlocker)
    
    -- 标签宿主
    local functionTabList = UI.TabList:create()
    functionTabList:init(2, nil, nil, true)
    functionTabList:leftUp(0, 30)
    functionTabList:setTouchEnable(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex, lastIndex)
        -- print(string.format("BagPanel onInitView: select function tab %d.", tabIndex))
        if (not self:choiceTabIndex(tabIndex)) then
            functionTabList:activeTab(lastIndex)
            -- local timestampToSeeable = GameManager:getNormalServerTime() + GuildBoxDataManager:getTimeDurationToSeeable()
            -- UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1112229)--[["%s后才能打开公会宝箱"]], AvalonUtil:getFullFormatTime(timestampToSeeable)))
        end
    end)
    functionTabList:setLayout(LayoutArrayType.VERTICAL, LayoutFloatType.FLOAT_UP)
    functionTabList:setReverseOrder(true)
    self._functionTabList = functionTabList
    clickBlocker:addChild(functionTabList, 10)
    
    -- 比赛日志按钮
    local functionTab = UI.TabItem:create()
    functionTab:init("ui_btn_gray2_0.png", "ui_btn_gray2_1.png")
    functionTab:setSize(109, 68)
    functionTab:alignLeft(true)
    functionTab:setSwallowTouches(true)
    functionTab:setChangeScale(false)
    functionTabList:addToTab(functionTab, UI.BET_MAIN_TYPE.BET_HISTORY)
    
    -- 比赛日志
    self._mainTabText = UI.Text:create()
    self._mainTabText:init(UI.TEXT_227601, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    self._mainTabText:center(-4, 0)
    functionTab:addChild(self._mainTabText)
    
    -- 比赛投注按钮
    self._managerFunctionTab = UI.TabItem:create()
    self._managerFunctionTab:init("ui_btn_gray2_0.png", "ui_btn_gray2_1.png")
    self._managerFunctionTab:setSize(109, 68)
    self._managerFunctionTab:alignLeft(true)
    self._managerFunctionTab:setSwallowTouches(true)
    self._managerFunctionTab:setChangeScale(false)
    -- self._newApplyStatus = AvalonUtil.createRedPoint(self._managerFunctionTab, FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
    -- self._newApplyStatus:setVisible(false)
    functionTabList:addToTab(self._managerFunctionTab, UI.BET_MAIN_TYPE.BET)
    
    -- 比赛投注
    self._managerTabText = UI.Text:create()
    self._managerTabText:init(UI.TEXT_227602, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    self._managerTabText:center(-4, 0)
    self._managerFunctionTab:addChild(self._managerTabText)
end

-- 选择标签
function BetMainView:choiceTabIndex(tabIndex)
    local isAbleToChange = true
    if (self._choiceTabIndex ~= tabIndex) then
        self._choiceTabIndex = tabIndex
        self._functionTabList:setDefaultIndex(tabIndex)
        
        self._mainTabText:setFontColor(UI.FONT_COLOR_47_50_55)
        self._managerTabText:setFontColor(UI.FONT_COLOR_47_50_55)
        
        self._betHistoryView:setVisible(false)
        self._betInfoView:setVisible(false)
        self._betTitle:setVisible(false)
        self._historyTitle:setVisible(false)
        
        -- self._newApplyStatus:rightUp(FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
        -- self._boxStatus:rightUp(FUNCTION_TAG_NEW_APPLY_REDPOINT_RIGHT_NORM, FUNCTION_TAG_NEW_APPLY_REDPOINT_UP)
        if (tabIndex == UI.BET_MAIN_TYPE.BET_HISTORY) then
            -- 激活投注历史
            self._mainTabText:setFontColor(TAB_ACTIVE_FONT_COLOR)
            self._betHistoryView:setVisible(true)
            self._historyTitle:setVisible(true)
        elseif (tabIndex == UI.BET_MAIN_TYPE.BET) then
            -- 激活投注页面
            self._managerTabText:setFontColor(TAB_ACTIVE_FONT_COLOR)
            self._betInfoView:setVisible(true)
            self._betTitle:setVisible(true)
        end
        
        -- 刷新页面
    end
    
    return isAbleToChange
end

function BetMainView:initDecorate()
    local left = UI.Image:create()
    left:init("ui_rally_decorate.png")
    left:leftBottom(-130, 0)
    self.contentLayout:addChild(left, 90)

    local right = UI.Image:create()
    right:init("ui_rally_decorate_02.png")
    right:rightBottom(-80, 0)
    self.contentLayout:addChild(right, 9)
end

-- 更新竞猜币的数据
function BetMainView:updateBetIntemNum()
    if(self._betInfoView) then 
        self._betInfoView:updateBetIntemNum()
    end
end

-- 更新当前竞猜信息
function BetMainView:refreshInfo()
    -- print("BetMainView:refreshInfo")
    if(self._betInfoView) then 
        -- print("BetMainView:refreshInfo 1")
        self._betInfoView:refreshView()
    end

    if(self._betHistoryView ~= nil) then 
        -- print("BetMainView:refreshInfo 22")
        self._betHistoryView:refreshView()
    end

    self._betTitleText:setText(AvalonUtil:getCommaNumber(mvc.betModel:getBetPoolNum()))
    self._betTitleText:updateView()
    self._betLayout:updateView()
end

return BetMainView













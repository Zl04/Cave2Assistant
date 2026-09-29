------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/02
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BetHistoryView = class("BetHistoryView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_navigation.plist",
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 890
local COM_HEIGHT = 459

local INNER_WIDTH = 980
local INNER_HEIGHT = 540

function BetHistoryView:ctor()
    BetHistoryView.super.ctor(
    self,
    UI.Type.TIPS,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)
self:bindModel()

self._lastInfo = mvc.betModel:GetLastInfo()
self._myLastInfo = mvc.betModel:GetMyLastInfo()
self._curShowList = nil

self._choiceHistoryTabIndex = -1;
end

function BetHistoryView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bet", "Bet", false)
    BetHistoryView.super.init(self, ... )
end

function BetHistoryView:dtor()
    BetHistoryView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bet.BetHistoryView")
end


function BetHistoryView:onInitView()
    local betHistoryLayout = UI.Layout:create()
    betHistoryLayout:init()
    betHistoryLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    --clickBlocker:leftUp(912, 75)
    betHistoryLayout:leftUp(0, 0)
    -- betHistoryLayout:setTouchEnable(false)
    -- betHistoryLayout:setSwallowTouches(true)
    self:addChild(betHistoryLayout)
    self._betHistoryLayout = betHistoryLayout
    
    -- 横线
    local line  = UI.Image:create()
    line:init("ui_navigation_line_4.png")
    line:centerUp(70)
    self:addChild(line)
    
    -- 中间列表区域
    -- 称号列表本身
    self._titleTableView = UI.TableView:create({}, 863, 379)
    self._titleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._titleTableView:leftUp(21, 72)
    self._titleTableView:setDelegate()
    self._titleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._titleTableView:setBounceable(true)
    self._titleTableView:setOpacityModifyRGB(true)
    self._titleTableView:init()
    self._titleTableView:onUpdateCellSize(function (table,idx)
        return 863, 322
    end)
    
    self._titleTableView:onUpdateCells(function (table, idx)
        -- print("self._titleTableView:onUpdateCells=", idx)
        -- 获取缓存的格子, 如果没有, 就新建
        local reusedCell = table:dequeueCell()
        if (not reusedCell) then
            reusedCell = UI.TableViewCell:create()
            xpcall(function()
                local cellView = UI.BetHistoryCell:create()
                cellView:init()
                cellView:setTouchClipNode(self._titleTableView)
                cellView:leftBottom(0, 0)
                cellView:setName("cellView")
                reusedCell:addChild(cellView)
                
                cellView:updateData(self._curShowList, idx * 4 + 1, self._choiceHistoryTabIndex, self._titleTableView)
            end,
            function(e) 
                printError("------------------------_titleTableView:tableCellAtIndex-----------------error", e)
            end, 1);
        else 
            local cellView = reusedCell:getChildByName("cellView")
            if (cellView) then
                cellView:updateData(self._curShowList, idx * 4 + 1, self._choiceHistoryTabIndex, self._titleTableView)
            end
        end
        
        return reusedCell
    end)
    
    self._titleTableView:onUpdateCellNumbers(function ()
        
        return self:calcuRowNun(#self._curShowList)
    end)
    
    self._titleTableView:onTableCellTouched(function(table, cell)
        
    end)
    betHistoryLayout:addChild(self._titleTableView, 0)
    
    
    
    local historyTabList = UI.TabList:create()
    historyTabList:init(2, nil, nil, true)
    historyTabList:leftUp(53, 32)
    historyTabList:setTouchEnable(true)
    historyTabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, tabIndex, lastIndex)
        -- print(string.format("BagPanel onInitView: select function tab %d.", tabIndex))
        if (not self:choiceHistoryTabIndex(tabIndex)) then
            historyTabList:activeTab(lastIndex)
            -- local timestampToSeeable = GameManager:getNormalServerTime() + GuildBoxDataManager:getTimeDurationToSeeable()
            -- UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1112229)--[["%s后才能打开公会宝箱"]], AvalonUtil:getFullFormatTime(timestampToSeeable)))
        end
    end)
    
    historyTabList:setLayout(LayoutArrayType.HORIZONTAL, LayoutFloatType.FLOAT_RIGHT)
    historyTabList:setReverseOrder(true)
    self._historyTabList = historyTabList
    betHistoryLayout:addChild(historyTabList, 10)
    
    -- 投注历史tab
    local functionTab = UI.TabItem:create()
    functionTab:init("ui_rally_lable_normal.png", "ui_rally_lable_checked.png")
    functionTab:setSize(124, 38)
    -- functionTab:alignLeft(true)
    functionTab:setSwallowTouches(true)
    functionTab:setChangeScale(false)
    historyTabList:addToTab(functionTab, UI.BET_HISTORY_TYPE.HISTORY)
    
    local allText = UI.Text:create()
    allText:init(UI.TEXT_227603, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    allText:center(-4, 0)
    functionTab:addChild(allText)
    
    -- 我的投注
    local functionOurTab = UI.TabItem:create()
    functionOurTab:init("ui_rally_lable_normal.png", "ui_rally_lable_checked.png")
    functionOurTab:setSize(124, 38)
    -- functionOurTab:alignLeft(true)
    functionOurTab:setSwallowTouches(true)
    functionOurTab:setChangeScale(false)
    historyTabList:addToTab(functionOurTab, UI.BET_HISTORY_TYPE.OUR)
    
    local ourText = UI.Text:create()
    ourText:init(UI.TEXT_227604, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    ourText:center(-4, 0)
    functionOurTab:addChild(ourText)
    
    if (not self:choiceHistoryTabIndex(UI.BET_HISTORY_TYPE.HISTORY)) then
        historyTabList:activeTab(UI.BET_HISTORY_TYPE.HISTORY)
    end
end

function BetHistoryView:calcuRowNun(totalNum)
    local yu = totalNum % 4
    if(yu == 0) then 
        return totalNum / 4
    else 
        return totalNum / 4 + 1
    end
end

function BetHistoryView:bindModel()
    
end


function BetHistoryView:unbindModel()
    
end

function BetHistoryView:refreshView()
    -- print("BetHistoryView:refreshView")
    local preIndex = self._choiceHistoryTabIndex
    self._choiceHistoryTabIndex = -1
    
    self._lastInfo = mvc.betModel:GetLastInfo()
    self._myLastInfo = mvc.betModel:GetMyLastInfo()
    self._curShowList = nil

    self:choiceHistoryTabIndex(preIndex)
end
-- function BetHistoryView:refresh

function BetHistoryView:choiceHistoryTabIndex(tabIndex)
    local isAbleToChange = true
    if(self._choiceHistoryTabIndex ~= tabIndex) then 
        self._choiceHistoryTabIndex = tabIndex
        
        if(self._choiceHistoryTabIndex == UI.BET_HISTORY_TYPE.HISTORY) then 
            self._curShowList = self._lastInfo
        elseif (self._choiceHistoryTabIndex == UI.BET_HISTORY_TYPE.OUR) then 
            self._curShowList = self._myLastInfo
        end

        -- 载入数据
        self._titleTableView:reloadData()
        self._titleTableView:fixContentOffset()
        
        self._historyTabList:setDefaultIndex(tabIndex)
    end
    
    return isAbleToChange
end


return BetHistoryView













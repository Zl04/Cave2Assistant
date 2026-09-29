------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2021/04/07
--desc	: 
------------------------------------------------------------------------------

local mercenaryCellView = require "app.modules.mercenary.MercenaryCellView"
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MercenaryView = class("MercenaryView", UI.HWBtnComponent)
local winSize = cc.Director:getInstance():getWinSize()
-- 资源
local COM_RES_LIST = {
    "ui_town_mercenary.plist",
}

local COM_WIDTH = 510
local COM_HEIGHT = 592

function MercenaryView:ctor(data)
    MercenaryView.super.ctor(
    	self,
    	UI.Type.MERCENARY_LIST_VIEW,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self._barHeight = 416
    self._caveData = data
    self:bindModel()
end

function MercenaryView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.mercenary", "Mercenary", false)
    MercenaryView.super.init(self, ... )
end

function MercenaryView:dtor()
    MercenaryView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.mercenary.MercenaryView")
end


function MercenaryView:onInitView()
    self._mercenaryList = mvc.mercenaryModel:getMercenaryList()
    Net.NetRoleSystem:reqMercenaryList(mvc.mercenaryModel:getMercenaryRefreshTimestamp())

    mvc.mercenaryModel:bind("mercenaryList", self, function(this, data)
        self._mercenaryList = data
        if(not tolua.isnull(self)) then
            self:refreshMercenaryList()
            self:refreshButtonStatus()
        end
    end)

    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,120))
    blackBg:setContentSize(winSize.width*2, winSize.height*2)
    blackBg:setPosition(-winSize.width, -winSize.height)
    self:addChild(blackBg)

    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:setSize(COM_WIDTH, COM_HEIGHT)
    -- rootLayout:enableDebugDraw()
    self:addChild(rootLayout)
    self.rootLayout = rootLayout

    local bg = UI.Image:create()
    bg:init("ui_mercenary_bg2.png")
    bg:center()
    rootLayout:addChild(bg)

    local titleImage = UI.Image:create()
    titleImage:init("ui_mercenary_title.png")
    titleImage:centerUp(20)
    rootLayout:addChild(titleImage)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1325700, UI.FONT_STANDARD, UI.FONT_SIZE_28PX, UI.FONT_COLOR_168_160_147)
    titleText:center()
    titleText:setTextCenter()
    titleImage:addChild(titleText)

    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(473, 2))
    splitLine:centerUp(80)
    rootLayout:addChild(splitLine, 20)

    self:initTableView()

    -- 没有佣兵列表的提示
    local noMercenaryText = UI.Text:create()
    noMercenaryText:init(UI.TEXT_1325703, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    noMercenaryText:center()
    rootLayout:addComponent(noMercenaryText, 10)
    self.noMercenaryText = noMercenaryText
    noMercenaryText:setVisible(false)

    -- 次数处理
    local numberLayout = UI.Layout:create();
    numberLayout:init()
    numberLayout:enableAutoWidth()
    numberLayout:enableAutoHeight()
    numberLayout:centerBottom(60)
    rootLayout:addChild(numberLayout)

    local numTitleText = UI.Text:create()
    numTitleText:init(UI.TEXT_1325702, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    numTitleText:floatLeft(0)
    numberLayout:addComponent(numTitleText, 10)

    local numTxt = UI.Text:create()
    numTxt:init("0/0", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    numTxt:floatLeft(10)
    numberLayout:addComponent(numTxt, 10)
    self._numTxt = numTxt

    local mercenaryButton  = UI.Button:create()
    mercenaryButton:init("ui_mercenary_btn_3.png", "ui_mercenary_btn_3.png", "ui_mercenary_btn_4.png")
    mercenaryButton:centerBottom(11)
    mercenaryButton:setInterval(1)
    rootLayout:addChild(mercenaryButton)
    self._mercenaryButton = mercenaryButton
    mercenaryButton:disable()
    mercenaryButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- print("mercenaryButton click")
        -- 处理点击后的效果
        if(self:checkButtonStatus(true)) then 
            self._caveData.mercenaryPk = self._choiceMercenaryData.baseData.pk
            -- add by zp 这里服务器就认为这个模式为单人模式，客户端要做相关的区分，所以这里做了相关的处理
            self._caveData.mode = PublicDefine.GAME_MODE.MODE_SOLO
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetRoleSystem:reqEnterMercenaryCave(self._caveData)
        end
    end)
    mercenaryButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        -- print("mercenaryButton BUTTON_DISABLE_PRESS")
        -- 处理逻辑
        self:checkButtonStatus(true)
    end)

    local costLayout = UI.Layout:create();
    costLayout:init()
    costLayout:enableAutoWidth()
    costLayout:enableAutoHeight()
    costLayout:center()
    mercenaryButton:addChild(costLayout, 100)

    local costImg  = UI.Image:create();
    costImg:init("icon_contribution.png");  --icon_guild.png
    costImg:floatLeft(-15)
    costImg:setScale(0.7)
    -- costImg:enableDebugDraw()
    costLayout:addComponent(costImg, 10)

    local costNumTxt = UI.Text:create()
    costNumTxt:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_50_50_44)
    costNumTxt:floatLeft(-15)
    costLayout:addComponent(costNumTxt, 10)
    self._costNumTxt = costNumTxt

    local costDesTxt = UI.Text:create()
    costDesTxt:init(UI.TEXT_1325701, UI.FONT_STANDARD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_50_50_44)
    costDesTxt:floatLeft(5)
    costLayout:addComponent(costDesTxt, 10)

    self:refreshMercenaryList()
    self:refreshButtonStatus()
end

function MercenaryView:refreshMercenaryList()
    if(self.m_mercenaryTableView) then 
        self.m_mercenaryTableView:reloadData()
    end
    self:refreshInfo()
end

function MercenaryView:refreshInfo()
    if(self._numTxt) then 
        local num = mvc.mercenaryModel:getOneDayMercenaryNum() - mvc.mercenaryModel:getMercenaryNum()
        self._numTxt:setText(num .. "/" .. mvc.mercenaryModel:getOneDayMercenaryNum())
    end

    if(self._costNumTxt) then 
        local masterData = RoleDataManager:getMaster()
        local mercenaryCost = mvc.mercenaryModel:getMercenaryCostNum()
        self._costNumTxt:setFontColor(UI.FONT_COLOR_50_50_44)
        if(mercenaryCost > masterData:getGuildContrib()) then 
            self._costNumTxt:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
        self._costNumTxt:setText("" .. mvc.mercenaryModel:getMercenaryCostNum())
    end

    if(self.noMercenaryText) then 
        if(self._mercenaryList and #self._mercenaryList > 0) then 
            self.noMercenaryText:setVisible(false)
        else
            self.noMercenaryText:setVisible(true) 
        end
    end
end

function MercenaryView:refreshButtonStatus()
    local enable = self:checkButtonStatus(false)
    if(self._mercenaryButton) then 
        if(enable) then 
            self._mercenaryButton:enable()
        else
            self._mercenaryButton:disable()
        end
    end
end

function MercenaryView:checkButtonStatus(showNotice)
    -- 判断次数
    if mvc.mercenaryModel:getMercenaryNum() >= mvc.mercenaryModel:getOneDayMercenaryNum() then
        if(showNotice) then 
            UI.ScrollBar:createByText(UI.TEXT_1325705)
        end
        return false
    end

    -- 是否已经选择雇佣人
    if(self._choiceMercenaryData == nil) then 
        if(showNotice) then 
            UI.ScrollBar:createByText(UI.TEXT_1325704)
        end
        return false
    end

    local masterData = RoleDataManager:getMaster()
    if(masterData == nil) then
        return false
    end
    local mercenaryCost = mvc.mercenaryModel:getMercenaryCostNum()
    if(mercenaryCost > masterData:getGuildContrib()) then 
        if(showNotice) then 
            UI.ScrollBar:createByText(UI.TEXT_1325706)
        end
        return false
    end

    return true
end

function MercenaryView:choiceMercenaryData(data)
    self._choiceMercenaryData = data
    if(self.m_mercenaryTableView) then 
        local oldSet = self.m_mercenaryTableView:getContentOffset()
        self.m_mercenaryTableView:reloadData()
        self.m_mercenaryTableView:setContentOffset(oldSet)
    end

    local pk = 0
    if(self._choiceMercenaryData) then 
        pk = self._choiceMercenaryData.baseData.pk
    end
    if(self.pMyCelltop) then
        self.pMyCelltop:reload(self._choiceMercenaryData, pk)
    end
    if(self.pMyCellbottom) then
        self.pMyCellbottom:reload(self._choiceMercenaryData, pk)
    end
    self:refreshButtonStatus()
end

function MercenaryView:initTableView()
    local mercenaryTableView = cc.TableView:create(cc.size(476,416))
    mercenaryTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    mercenaryTableView:setPosition(cc.p(13, 94))
    mercenaryTableView:setDelegate()
    mercenaryTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.rootLayout:addChild(mercenaryTableView)
    --registerScriptHandler functions must be before the reloadData funtion
    mercenaryTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    mercenaryTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    -- mercenaryTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    mercenaryTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    mercenaryTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    mercenaryTableView:registerAbsScriptHandler(handler(self,self.reloadActionEndCallback),cc.Handler.TABLEVIEW_RELOAD_ACTION_END)
    mercenaryTableView:setScrollBarEnabled(false)
    self.m_mercenaryTableView = mercenaryTableView

    -- local capImage = UI.Image:create()
    -- capImage:init("ui_rankinglist_gradually.png")
    -- capImage:leftBottom(232, 28)
    -- self.rootLayer:addChild(capImage)
    -- capImage:setScale(1.06)
    -- self.capImage = capImage

    local pMyCellbottom = mercenaryCellView:create(self)
    pMyCellbottom:setName("myCell")
    pMyCellbottom:leftBottom(13, 86)
    -- pMyCellbottom:setSingle(true, true)
    self.rootLayout:addChild(pMyCellbottom, 100)
    self.pMyCellbottom = pMyCellbottom
    -- self.pMyCellbottom:setVisible(false)
    self.pMyCellbottom:leftBottom(10000, 86)
    self.pMyCellbottom:setTouchEnable(true)
    self.pMyCellbottom:setInterceptTouches(false)


    local pMyCelltop = mercenaryCellView:create(self)
    pMyCelltop:setName("myCell")
    pMyCelltop:leftUp(13, 82)
    -- pMyCelltop:setSingle(true, false)
    self.rootLayout:addChild(pMyCelltop, 100)
    self.pMyCelltop = pMyCelltop
    pMyCellbottom.testCell = true
    pMyCelltop.testCell = true
    -- self.pMyCelltop:setVisible(false)
    self.pMyCelltop:leftBottom(10000, 86)
    self.pMyCelltop:setTouchEnable(true)
    self.pMyCelltop:setInterceptTouches(false)
end

function MercenaryView:numberOfCellsInTableView(table)
    -- print("RankingLayer:numberOfCellsInTableView")
    if self._mercenaryList then
        return #(self._mercenaryList)
    else
        return 0
    end
end

function MercenaryView:tableCellAtIndex(tableView,idx)
    -- print("RankingLayer:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    local pk = 0
    if(self._choiceMercenaryData) then 
        pk = self._choiceMercenaryData.baseData.pk
    end
    xpcall(function()      
        if nil == cell then
            cell = cc.TableViewCell:new()
            local pRankingCell = mercenaryCellView:create(self)
            pRankingCell:reload(self._mercenaryList[idx+1], pk)
            pRankingCell:setName("cell")
            pRankingCell:leftBottom(0, 0)
            cell:addChild(pRankingCell)
            self._mercenaryList[idx+1].idx = idx+1
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self._mercenaryList[idx+1], pk)
            self._mercenaryList[idx+1].idx = idx+1
        end
    end, 
    function(e) 
        printError("--------------------RankingLayer:tableCellAtIndex---------------------error")
    end, 1) 
    -- self._tableRankCellArr[idx + 1] = cell
    return cell;
end

function MercenaryView:scrollViewDidScroll(view)
    if self.actionFlag then
        return
    end
    local offsetY = view:getContentOffset().y
    if offsetY > 0 then
        offsetY = 0;
    end
    local viewHeight = view:getViewSize().height;
    local height = view:getContentSize().height;
    -- self.capImage:leftBottom(232, 28)
    local cellHeight = 110
    local y = (offsetY + height - viewHeight) * self._barHeight/(height - viewHeight)

    local pk = 0
    if(self._choiceMercenaryData) then 
        pk = self._choiceMercenaryData.baseData.pk
    end

    -- self.pRankingProBar:updateNowBar(self._barHeight - y)
    -- print("height",height,offsetY,view:getContentOffset().y,(self.data[self.rankType].myRank - 1) * 70 - 5,(viewHeight - height - (self.data[self.rankType].myRank - 1) * 70 - 5) > offsetY)
    if self._mercenaryList and self._choiceMercenaryData ~= nil then
        local idx = self._choiceMercenaryData.idx
        if (height + offsetY > idx * cellHeight - 5) or view:getContentOffset().y > -5 then
            if self.pMyCellbottom then
                -- self.pMyCellbottom:setVisible(false)
                self.pMyCellbottom:leftBottom(10000, 86)
            end
        else
            if self.pMyCellbottom then
                self.pMyCellbottom:leftBottom(13, 86)
                -- self.pMyCellbottom:setVisible(true)
                self.pMyCellbottom:reload(self._choiceMercenaryData, pk)
                -- self.capImage:leftBottom(232, 101)
            end
        end
        -- print("offsetY",offsetY)
        -- print("view:getContentOffset().y",view:getContentOffset().y)
        -- print(viewHeight , height , (self.data[self.rankType].myRank -1) * 70 - 5 , (viewHeight - height + (self.data[self.rankType].myRank - 1) * 70 - 5), offsetY )
        if (viewHeight - height + idx * cellHeight + 1) > view:getContentOffset().y  then
            if self.pMyCelltop then
                -- self.pMyCelltop:setVisible(false)
                self.pMyCelltop:leftBottom(10000, 86)
            end
        else
            if self.pMyCelltop then
                self.pMyCelltop:leftUp(13, 82)
                -- self.pMyCelltop:setVisible(true)
                self.pMyCelltop:reload(self._choiceMercenaryData, pk)
            end
        end
    else
        if self.pMyCellbottom then 
            -- self.pMyCellbottom:setVisible(false)
            self.pMyCellbottom:leftBottom(10000, 86)
        end
        if self.pMyCelltop then
            self.pMyCelltop:leftBottom(10000, 86)
            -- self.pMyCelltop:setVisible(false)
        end
    end
end

function MercenaryView:cellSizeForTable(table,idx)
    return 476, 110
end

function MercenaryView:reloadActionEndCallback(table)
    self.actionFlag = false
    self:scrollViewDidScroll(table)
end

function MercenaryView:bindModel()

end


function MercenaryView:unbindModel()

end





return MercenaryView













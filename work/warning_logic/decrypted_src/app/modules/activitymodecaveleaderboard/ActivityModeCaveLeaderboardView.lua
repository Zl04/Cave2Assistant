------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveLeaderboardView = class("ActivityModeCaveLeaderboardView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

require "app.ui.common.Tab.TabItem"

-- 资源
local COM_RES_LIST = {
    "ui_town_trial.plist",
    "ui_town_guild_icon.plist",
    "ui_common_btn.plist",
    "ui_town_ranking.plist",
}

local COM_WIDTH = 1026
local COM_HEIGHT = 571

local ModeCaveLeaderboardType = {
    Invalid = 0,                    -- 无效的
    Ranking = 1,                    -- 排名
    RankReward = 2,                 -- 排行奖励
    ParticipationRewards = 3,       -- 参与奖励
    Max = 4,                        -- 最大值
}

local winSize = cc.Director:getInstance():getWinSize()


local CustomTabItem = class("Custom", UI.TabItem)
-- 模版函数：激活
function CustomTabItem:onActive()
    if (self._activeSpriteName and self._sprite) then
        self._sprite:setSpriteFrame(self._activeSpriteName)
            local sp = UI.Image:create()
            sp:init("ui_btn_screening_triangle.png")
            sp:setName("jiantou")
            sp:centerRight(-20)
            self:addChild(sp, 1000)
    end
end

-- 模版函数：恢复
function CustomTabItem:onRestore()
    if (self._normalSpriteName and self._sprite) then
        if self._changeScale then
            self._sprite:setScale(1.0)
        end
        self._sprite:setSpriteFrame(self._normalSpriteName)
        self:removeChildByName("jiantou")
    end
end


local function createCustomItemHelper(lang, isNormal)
    local tab
    if isNormal then
        tab = UI.TabItem:create()
    else
        tab = CustomTabItem:create()
    end
    tab:init("ui_btn_language_0.png", "ui_btn_language_1.png")
    tab._changeScale = false
    local title = UI.Text:create()
    title:init(lang, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK )
    title:center()
    title:setTextCenter()
    tab:addChild(title)
    return tab
end

function ActivityModeCaveLeaderboardView:ctor(trialModelID)
    ActivityModeCaveLeaderboardView.super.ctor(
    	self,
    	UI.Type.MODE_CAVE_LEADERBOARD,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._pageType = ModeCaveLeaderboardType.Ranking
    self._pageTable = {}
    self._trialModelID = trialModelID or 1
end

function ActivityModeCaveLeaderboardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecaveleaderboard", "ActivityModeCaveLeaderboard", false)
    ActivityModeCaveLeaderboardView.super.init(self, ... )
end

function ActivityModeCaveLeaderboardView:dtor()
    ActivityModeCaveLeaderboardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecaveleaderboard.ActivityModeCaveLeaderboardView")
end


function ActivityModeCaveLeaderboardView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_trial_ranking_bg.png")
    bg:center()
    self:addChild(bg)
    self._bg = bg

    local titleBg  = UI.Image:create()
    titleBg:init("ui_trial_ranking_title.png")
    titleBg:centerUp(-10)
    bg:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223500, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 25, g = 23, b = 21})
    titleText:center()
    titleBg:addChild(titleText)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self._pageTable = {}

    local pageName = {
        [ModeCaveLeaderboardType.Ranking] = UI.TEXT_223501,
        [ModeCaveLeaderboardType.RankReward] = UI.TEXT_223502,
        [ModeCaveLeaderboardType.ParticipationRewards] = UI.TEXT_223503,
    }

    --某些模式需要移除参与奖励
    local pageMaxIndex = ModeCaveLeaderboardType.Max - 1
    local noShowModel = mvc.activityModeCaveLeaderboardModel:isNoShowModelId(self._trialModelID)
    if noShowModel then
        pageMaxIndex = pageMaxIndex - 1
    end

    local index = 0
    for i = ModeCaveLeaderboardType.Ranking, pageMaxIndex do
        local pageBtn = UI.Button:create()
        pageBtn:init('ui_trial_ranking_bookmark.png', 'ui_trial_ranking_bookmark.png', 'ui_trial_ranking_bookmark2.png')
        pageBtn:leftBottom(self._bg:getContentSize().width - 102, self._bg:getContentSize().height - 145 - index*70)
        pageBtn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 25, g = 23, b = 21})
        pageBtn:setText(pageName[i])
        pageBtn:closeClickScale()
        
        pageBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:updatePageView(i)

            for k,v in pairs(self._pageTable) do
                if i == k then
                    v:disable()
                    -- v:setFontColor({r = 240, g = 200, b = 56})
                else
                    v:enable()
                    -- v:setFontColor({r = 134, g = 115, b = 90})
                end
            end

        end)
        self._bg:addChild(pageBtn)
        self._pageTable[i] = pageBtn

        if i == self._pageType then
            pageBtn:disable()
            -- pageBtn:setFontColor({r = 240, g = 200, b = 56})
        else
            pageBtn:enable()
            -- pageBtn:setFontColor({r = 134, g = 115, b = 90})
        end

        local redPoint = AvalonUtil.createRedPoint(pageBtn, 15, 0, 100)
        redPoint:setName("redPoint")
        redPoint:hide()

        if i == ModeCaveLeaderboardType.ParticipationRewards then
            local isShow = mvc.activityModeCaveLeaderboardModel:needShowRedPoint(self._trialModelID)
            if isShow then
                redPoint:show()
            end
        end

        -- pageBtn:setFontColor({r = 25, g = 23, b = 21})

        index = index + 1
    end


    local topLayout = UI.Layout:create()
    topLayout:init()
    topLayout:setSize(COM_WIDTH, COM_HEIGHT)
    topLayout:center()
    self:addChild(topLayout)
    self.topLayout = topLayout

    local leftFrame = UI.Animation:create()
    leftFrame:init("effect_ui_town_rankinglist_left.json", "effect_ui_town_rankinglist_left.atlas", 1);
    leftFrame:leftBottom(70,22)
    leftFrame:addAnimation("idle", true)
    topLayout:addChild(leftFrame)

    local rightFrame = UI.Animation:create()
    rightFrame:init("effect_ui_town_ranking_crystal.json", "effect_ui_town_ranking_crystal.atlas", 1);
    rightFrame:rightBottom(78,127)
    rightFrame:addAnimation("idle", true)
    topLayout:addChild(rightFrame)

    local rbgFrame = UI.Image:create()
    rbgFrame:init("ui_trial_ranking_decorate.png")
    rbgFrame:rightBottom(2,8)
    topLayout:addChild(rbgFrame)


    local filterBtn = UI.Button:create() 
    filterBtn:init("ui_btn_language_0.png", "ui_btn_language_1.png", "ui_btn_yellow5_0.png")
    filterBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    filterBtn:leftUp(132,53)
    filterBtn:setText("XXXXXX")
    filterBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:showSelectContent()
    end)
    topLayout:addChild(filterBtn)
    self.filterBtn = filterBtn

    self:initCurDefault()

    -- self:updatePageView(ModeCaveLeaderboardType.Ranking)

    self.filterBtn:setText(self:getFilterOpStr(self.curFilterBigType, self.curFilterSmallType,true))

    Net.NetRankSystem:requestCustomRankSelfIndexData(PublicDefine.CustomRankType.CustomRankType_TrialLand,
    self._trialModelID, 
    {1,2,3})

end

function ActivityModeCaveLeaderboardView:refereshRedPoint()
    if not self._pageTable then
        return
    end

    for k,v in pairs(self._pageTable) do
        if k == ModeCaveLeaderboardType.ParticipationRewards then
            local isShow = mvc.activityModeCaveLeaderboardModel:needShowRedPoint(self._trialModelID)
            local redPoint = v:getChildByName("redPoint")
            if isShow then
                redPoint:show()
            else
                redPoint:hide()
            end
        end
    end
end

function ActivityModeCaveLeaderboardView:rankingViewAction(data)--(subType,subIndex)
    if (#data > 0) then
        self.curFilterBigType = data[1].subType --职业类型
        if data[1].subIndex > 0 then
            self.curFilterSmallType = data[1].subIndex --等级区间
        end
    end

    self._myData = data

    self:updatePageView(ModeCaveLeaderboardType.Ranking,true)
end


function ActivityModeCaveLeaderboardView:showSelectContent()
    if not self.selectRootNode then
        self.m_pSelectLvView = nil
        local bG = UI.Image:create()
        bG:init("ui_trial_ranking_paper.png")
        bG:leftUp(132,97)
        self.topLayout:addChild(bG, 1000)
        self.selectRootNode = bG
        self.selectRootNode:setTouchEnable(true)
        self.selectRootNode:setInterceptTouches(true)

        self.selectRootNode:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchSelectOutsizeHandler)


        local scrollView = UI.ScrollView:create()
        scrollView:init(0, 0, 0, 0)
        scrollView:setSize(240, 300)
        scrollView:leftUp(16, 8)
        scrollView:setScrollType(UI.ScrollType.VERTICAL)
        scrollView:setScrollBarEnabled(false)
        scrollView:setBounceEnabled(false)

        -- 物品分类按钮
        local tabList = UI.TabList:create()
        tabList:init( 5, 210, 41)
        tabList:addEventListener(UIEvent.TAB_ACTIVE, self, self.showSelectLevelContent)
        tabList:setLayout(UI.LayoutArrayType.VERTICAL, UI.LayoutFloatType.FLOAT_UP)

        local maxIndex = 4
        local tab = createCustomItemHelper(UI.TEXT_1324001)
        tabList:addToTab(tab,maxIndex - 1)
        tab.tabType = 1
        local tab = createCustomItemHelper(UI.TEXT_1324000)
        tabList:addToTab(tab,maxIndex - 2)
        tab.tabType = 2
        local tab = createCustomItemHelper(UI.TEXT_1324002)
        tabList:addToTab(tab,maxIndex - 3)
        tab.tabType = 3

        tabList:setDefaultIndex(maxIndex - self.curFilterBigType)

        tabList:leftBottom(5,0)
        scrollView:addInnerNode(tabList)
        self.selectRootNode:addChild(scrollView)

        self.filterBtn:setBtnStatus(ButtonState.ACTIVE)
    else
        self:onTouchSelectOutsizeHandler()
    end
end

function ActivityModeCaveLeaderboardView:isActive(tabIndex, smallType)
    return self.curFilterBigType == tabIndex and self.curFilterSmallType == smallType
end

function ActivityModeCaveLeaderboardView:isSelf(tabIndex, smallType)
    local isSelf = false

    if self._myData then
        for k,v in pairs(self._myData) do
            if v.subType == tabIndex and v.subIndex == smallType then
                isSelf = true
                break
            end
        end
    end

    return isSelf
end

function ActivityModeCaveLeaderboardView:showSelectLevelContent(tabIndex, lastTabIndex, tabItem)
    if self.m_pSelectLvView then
        self.m_pSelectLvView:removeFromParent()
        self.m_pSelectLvView = nil
    end
    local tabType = tabItem.tabType

    self.selectContentData = {}
    local tabCount = self._maxInterval
    for i = 1, tabCount do
        self.selectContentData[i] = {isActive = self:isActive(tabType, i), lang = self:getFilterOpStr(tabType, i), isSelf = self:isSelf(tabType, i)}
    end

    self.curClickFiterBigType = tabType

    self.m_pSelectLvView = cc.TableView:create(cc.size(220,280))
    self.m_pSelectLvView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.m_pSelectLvView:setPosition(cc.p(250, 30))
    self.m_pSelectLvView:setDelegate()
    self.m_pSelectLvView:initScrollBar(true)
    self.m_pSelectLvView:setScrollBarWidth(5)
    self.m_pSelectLvView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    self.m_pSelectLvView:registerScriptHandler(handler(self,self.tableCellNumsBySelectType),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.m_pSelectLvView:registerScriptHandler(handler(self,self.tableCellTouchedBySelectType),cc.TABLECELL_TOUCHED)
    self.m_pSelectLvView:registerScriptHandler(handler(self,self.cellSizeForTableBySelectType),cc.TABLECELL_SIZE_FOR_INDEX)
    self.m_pSelectLvView:registerScriptHandler(handler(self,self.tableCellAtIndexBySelectType),cc.TABLECELL_SIZE_AT_INDEX)
    self.selectRootNode:addChild(self.m_pSelectLvView)

    self.lastSelectType = nil
    self.m_pSelectLvView:reloadData()
end

function ActivityModeCaveLeaderboardView:tableCellNumsBySelectType(tabIndex, lastTabIndex)
    return #self.selectContentData
end

function ActivityModeCaveLeaderboardView:cellSizeForTableBySelectType(table,idx)
    return 210, 45
end

function ActivityModeCaveLeaderboardView:tableCellTouchedBySelectType(table,cell)
    -- print("RankingLayer:tableCellTouchedBySelectType",cell:getIdx())
    if cell:getIdx() + 1 == self.lastSelectType then
        return
    end
    self.selectContentData[cell:getIdx() + 1].isActive = true
    if self.lastSelectType then
        self.selectContentData[self.lastSelectType].isActive = false
    end
    self.lastSelectType = cell:getIdx() + 1
    self:getRankInfo(self.curClickFiterBigType, cell:getIdx() + 1)
end

function ActivityModeCaveLeaderboardView:tableCellAtIndexBySelectType(tableView,idx)
    local cell = tableView:dequeueCell()
    xpcall(function()
        if nil == cell then
            cell = cc.TableViewCell:new()

            local pRankingTypeCell = UI.RankSelectSubTypeCell:create()
            pRankingTypeCell:setName("cell")
            pRankingTypeCell:leftBottom(0, 0)
            cell:addChild(pRankingTypeCell)
            pRankingTypeCell:reload(self.selectContentData[idx + 1])
        else
            local obj = cell:getChildByName("cell")
            obj:reload(self.selectContentData[idx + 1])
        end
    end, 
    function(e) 
        printError("--------------------BagFullLayer:tableCellAtIndex---------------------error")
    end, 1) 

   return cell;
end

function ActivityModeCaveLeaderboardView:getRankInfo(tabType, selectIdx)

    self:onTouchSelectOutsizeHandler()
    self.filterBtn:setText(self:getFilterOpStr(tabType, selectIdx,true))
    self.curFilterBigType = tabType
    self.curFilterSmallType = selectIdx
    
    --刷新排行数据以及显示
    self:updatePageView(self._pageType, true)
end

function ActivityModeCaveLeaderboardView:onTouchSelectOutsizeHandler()
    Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
        if self.selectRootNode then
            self.selectRootNode:removeFromParent()
            self.selectRootNode = nil
            self.filterBtn:setBtnStatus(ButtonState.NORMAL)

        end
    end, 1)
end

function ActivityModeCaveLeaderboardView:initCurDefault()
    self.curFilterBigType = 1 --职业类型
    self.curFilterSmallType = 1 --等级区间

    local wearEquipData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
    for k,v in pairs(wearEquipData.wearEquipmentArr) do
        -- 判断是否有盔甲
        local equipType = v:getEquipmentType()
        if equipType == PublicDefine.EQUIPMENT_TYPE.Weapon then
            local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
            if(illusionEquipData) then
                self.curFilterBigType = illusionEquipData:getWeaponType()
            end
            break
        end
    end

    self._maxInterval = 1
    self.trialData = ConfigManager:getAllTrialModelDataByID(self._trialModelID)
    if self.trialData then
        local gradeIntervalTable = AvalonUtil:splitStr(self.trialData.gradeInterval, ":")
        self._maxInterval = #gradeIntervalTable
        self._gradeIntervalTable = gradeIntervalTable

        local heroData = RoleDataManager:getMaster()
        local heroLevel = heroData:getLevel()
        for k,v in ipairs(self._gradeIntervalTable) do
            local ids = AvalonUtil:splitStr(v, ",")
            if tonumber(ids[1]) <= heroLevel and heroLevel <= tonumber(ids[2]) then
                self.curFilterSmallType = k
                break
            end
        end
    end
end

function ActivityModeCaveLeaderboardView:getFilterOpStr(filterType, filterIdx, isMerge)
    local lang = ""
    local langId = {
        1111376, 1111375,1111377
    }
    if filterType ~= nil and filterIdx == nil then
        lang = LanguageManager:getInstance():getLocalString(langId[filterType])
    else
        if isMerge and filterType ~= nil and filterIdx ~= nil then
            local tempLang = LanguageManager:getInstance():getLocalString(langId[filterType])
            if self._gradeIntervalTable[filterIdx] then
                local ids = AvalonUtil:splitStr(self._gradeIntervalTable[filterIdx], ",")
                local qwe = self:getHeroLevelStr(ids)
                lang = tempLang .. string.format(UI.TEXT_223504,qwe[1],qwe[2])
            end
        elseif filterType ~= nil and filterIdx ~= nil then
            if self._gradeIntervalTable[filterIdx] then
                local ids = AvalonUtil:splitStr(self._gradeIntervalTable[filterIdx], ",")
                local qwe = self:getHeroLevelStr(ids)
                lang = string.format(UI.TEXT_223504,qwe[1],qwe[2])
            end
        end
    end

    return lang
end

function ActivityModeCaveLeaderboardView:getHeroLevelStr(ids)
    local levelConfig = ConfigManager:getAllRoleReincarnationData()
    local reincarntionLv = 0
    local allStr = {}
    for k1,v1 in pairs(ids) do
        for k,v in pairs(levelConfig) do
            if tonumber(v1) <= v.roleLevelCap then
                reincarntionLv = v.roleReiLv
                if reincarntionLv == 0 then
                    table.insert(allStr, tostring(v1))
                else
                    table.insert(allStr, string.format(UI.TEXT_227100, reincarntionLv, tonumber(v1) - v.initialLevel + 1))
                end
                break
            elseif tonumber(v1) > v.roleLevelCap and (k >= (#levelConfig - 1)) then
                reincarntionLv = v.roleReiLv + 1
                table.insert(allStr, string.format(UI.TEXT_227100, reincarntionLv, tonumber(v1) - levelConfig[k + 1].initialLevel + 1))
                break
            end
        end
    end
    return allStr
end

function ActivityModeCaveLeaderboardView:updatePageView(pageType, isForce)
    if (pageType == nil or pageType == self._pageType) and not isForce then
        return
    end

    self.contentLayout:removeAllChildren()

    self._pageType = pageType

    self._rankingView = nil
    self._rankRewardView = nil
    self._participationRewardsView = nil

    if self._pageType == ModeCaveLeaderboardType.Ranking then
        local view = mvc.activityModeCaveLeaderboardRankingView:create(self._trialModelID,self.curFilterBigType,self.curFilterSmallType)
        view:init()
        view:leftBottom(0,0)
        self.contentLayout:addChild(view)

        self._rankingView = view
        self.filterBtn:show()
    elseif self._pageType == ModeCaveLeaderboardType.RankReward then
        local view = mvc.activityModeCaveLeaderboardAwardView:create(self._trialModelID,self.curFilterBigType,self.curFilterSmallType)
        view:init()
        view:leftBottom(0,0)
        self.contentLayout:addChild(view)

        self._rankRewardView = view
        self.filterBtn:show()
    elseif self._pageType == ModeCaveLeaderboardType.ParticipationRewards then
        local view = mvc.activityModeCaveLeaderboardParticipationAwardView:create(self._trialModelID)
        view:init()
        view:leftBottom(0,0)
        self.contentLayout:addChild(view)

        self._participationRewardsView = view
        self.filterBtn:hide()
    end

end


function ActivityModeCaveLeaderboardView:bindModel()

end


function ActivityModeCaveLeaderboardView:unbindModel()

end





return ActivityModeCaveLeaderboardView













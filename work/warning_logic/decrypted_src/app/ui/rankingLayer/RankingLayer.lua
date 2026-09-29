-- RankingLayer.lua
-- Author:ODEI
-- 2017年9月13日
-- Using:排行榜 
require("app.ui.rankingLayer.RankingCell")
require("app.ui.rankingLayer.RankingTypeCell")
require "app.ui.baglayer.RoleShow.RoleAnimation"
require("app.net.NetRankSystem")
require("app.ui.rankingLayer.RankSelectSubTypeCell")
require "cocos.cocos2d.functions"
require "utils.List"
local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"
--队列维护
local List = Avalon.List

UI = UI or {}

local RankingLayer = class("RankingLayer", UI.DownShowWin)
UI.RankingLayer = RankingLayer
local winSize = cc.Director:getInstance():getWinSize()

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_town_guild_icon.plist",
    "ui_common_btn.plist",
    "ui_town_ranking.plist",
}

local SelectTabType ={
    ALL = 0,
    JOB = 1,
    CAVE =2,
    DESERT_EYE =3,
    DISTORTED_SPACE =4,
    INFERNO =5,
    VOIDRIFT =6,
    VIKING =7,
    TITAN_ROAD =9,
    DRIED_SPRING =10,
    CHAOS =11,
}
local recordTags = {}
function RankingLayer:ctor()
    RankingLayer.super.ctor(self,UIType.RANKING_LAYER, COM_RES_LIST, winSize.width, winSize.height)
    recordTags = {}

    self._barHeight = 384
    self.rootLayer = nil;           --root节点
    self.myRank = 20
    self.rankType = -1
    self.renderQueue = List:create()
    self.actionFlag = false
    self.data = MasterDataManager:getRankingData()
    self.isPlayTableAct = {}
    self._tableCellArr = {}
    self._tableRankCellArr = {}
    self:init();
    self:registerListener();

    Avalon.Scheduler:scheduleUpdate(self, self.update)
    -- self:enableDebugDraw()
end

function RankingLayer:dtor()
    RankingLayer.super.dtor(self)
    self:unRegisterListener();
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    self.renderQueue:destroy()
    self.isPlayTableAct = {}
    self._tableCellArr = {}
    self._tableRankCellArr = {}
    reload_script_file("app.ui.rankingLayer.RankingLayer")
    reload_script_file("app.ui.rankingLayer.RankingCell")
    reload_script_file("app.ui.rankingLayer.RankingTypeCell")
    --reload_script_file("app.ui.rankingLayer.RankSelectSubTypeCell")
end

-- public:
-- 初始化
function RankingLayer:init()
    RankingLayer.super.init(self)
end

-- 模版函数：初始化组建的视图
function RankingLayer:onInitView()
    -- self:enableDebugDraw()
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:center()
    self.rootLayer:setSize(980, 541)
    self:addChild(self.rootLayer)

    local desBG = UI.Image:create()
    desBG:init("ui_rankinglist_announcement.png")
    desBG:leftBottom(6, -7)
    self.rootLayer:addChild(desBG, 5)
    self.desBG = desBG

    local picBG = UI.Image:create()
    picBG:init("ui_rankinglist_bg.png")
    picBG:centerRight(-55)
    self.rootLayer:addChild(picBG)
    self.picBG = picBG

    ---[[装饰物
    local decorations1 = UI.Image:create()
    decorations1:init("ui_rankinglist_decorate.png")
    decorations1:leftUp(225, -36)
    self.rootLayer:addChild(decorations1, -1)

    local decorations2 = UI.Image:create()
    decorations2:init("ui_rankinglist_railing.png")
    decorations2:rightBottom(15, 13)
    self.rootLayer:addChild(decorations2, 10)


    local decorations3 = UI.Animation:create()
    decorations3:init("effect_ui_town_rankinglist_right.json", "effect_ui_town_rankinglist_right.atlas", 1)
    decorations3:setAnimation("idle", true)
    decorations3:leftBottom(105, -15)
    desBG:addChild(decorations3)

    local decorations4 = UI.Animation:create()
    decorations4:init("effect_ui_town_rankinglist_left.json", "effect_ui_town_rankinglist_left.atlas", 1)
    decorations4:setAnimation("idle", true)
    decorations4:leftUp(101, 1)
    desBG:addChild(decorations4)

    local decorations5 = UI.Image:create()
    decorations5:init("ui_rankinglist_tree.png")
    decorations5:leftUp(28, -193)
    desBG:addChild(decorations5, -1)
   ---装饰物]]

    self.contentLayer = cc.Layer:create()
    self.contentLayer:setPosition(cc.p(0,-43))
    self.contentLayer:setContentSize(cc.size(980,541))
    self.rootLayer:addChild(self.contentLayer, 6)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine:setContentSize(578, 2)
    splitLine:setAnchorPoint(0, 0)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(220, 440)
     self.contentLayer:addChild(splitLine)

 

    local title = UI.Text:create()
    title:init(UI.TEXT_110047, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_207_182_89)
    title:setSize(280, 30)
    title:leftUp(275, 8)
    title:setTextCenter()
    -- title:enableDebugDraw()
    picBG:addChild(title)
    self.title = title

    local titleTime = UI.Text:create()
    titleTime:init(UI.TEXT_110047, UI.FONT_STANDARD, UI.FONT_SIZE_13PX, UI.FONT_COLOR_194_194_194)
    titleTime:setSize(280, 20)
    titleTime:leftUp(275, 39)
    titleTime:setTextCenter()
    -- titleTime:enableDebugDraw()
    picBG:addChild(titleTime)
    self.titleTime = titleTime

    local txtDesData = UI.Text:create()
    txtDesData:init("",UI.FONT_STANDARD,UI.FONT_SIZE_14PX, UI.FONT_COLOR_194_194_194)
    txtDesData:leftBottom(30, 82)
    txtDesData:setSize(142, 200)
    if LanguageManager:getInstance():isCJKUnicode() then
        txtDesData:setTextLeftUp()
    else
        txtDesData:setTextHorizontalCenter()
    end
    self.txtDesData = txtDesData
    -- txtDesData:enableDebugDraw()
    desBG:addChild(txtDesData)



    self.m_pItemTableView = cc.TableView:create(cc.size(610, 360))
    self.m_pItemTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.m_pItemTableView:setPosition(cc.p(206, 75))
    self.m_pItemTableView:setDelegate()
    self.m_pItemTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.contentLayer:addChild(self.m_pItemTableView)
    --registerScriptHandler functions must be before the reloadData funtion
    self.m_pItemTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.m_pItemTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellRecycle),cc.TABLECELL_WILL_RECYCLE)
    self.m_pItemTableView:registerAbsScriptHandler(handler(self,self.reloadActionEndCallback),cc.Handler.TABLEVIEW_RELOAD_ACTION_END)
    self.m_pItemTableView:initScrollBar(false)
    self.m_pItemTableView:setScrollBarWidth(6)
    self.m_pItemTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    if GameManager:getIsGooglePlay() then
        self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellHightLightByRankCell),cc.TABLECELL_HIGH_LIGHT)
        self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellUnHightLightByRankCell),cc.TABLECELL_UNHIGH_LIGHT)
    end

    local txtTitleRank = UI.Text:create()
    txtTitleRank:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtTitleRank:leftBottom(230,435)
    txtTitleRank:setSize(100, 44)
    txtTitleRank:setName("txtTitleRank")
    txtTitleRank:setTextCenter()
    self.contentLayer:addChild(txtTitleRank)
    self.txtTitleRank = txtTitleRank

    local txtTitlePhoto = UI.Text:create()
    txtTitlePhoto:init(UI.TEXT_1212015, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtTitlePhoto:leftBottom(331,435)
    txtTitlePhoto:setSize(80, 44)
    txtTitlePhoto:setTextCenter()
    self.contentLayer:addChild(txtTitlePhoto)

    local filterBtn = UI.Button:create() 
    filterBtn:init("ui_btn_language_0.png", "ui_btn_language_1.png", "ui_btn_yellow5_0.png")
    filterBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    filterBtn:leftBottom(250,473)
    filterBtn:setText("XXXXXX")
    filterBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.rankType > 0 then
            self:showSelectContent()
        end
    end)
    self.contentLayer:addChild(filterBtn)
    self.filterBtn = filterBtn

    local txtTitleName = UI.Text:create()
    txtTitleName:init("",UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtTitleName:leftBottom(465,435)
    txtTitleName:setSize(150, 44)
    txtTitleName:setTextCenter()
    self.contentLayer:addChild(txtTitleName)
    self.txtTitleName = txtTitleName


    local txtTitleData = UI.Text:create()
    txtTitleData:init("",UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtTitleData:leftBottom(675,435)
    txtTitleData:setSize(150, 44)
    txtTitleData:setTextCenter()
    self.contentLayer:addChild(txtTitleData)
    self.txtTitleData = txtTitleData


    local txtNoData = UI.Text:create()
    txtNoData:init(UI.TEXT_1150023,UI.FONT_STANDARD,UI.FONT_SIZE_20PX)
    txtNoData:leftBottom(330,230)
    txtNoData:setFontColor(UI.FONT_COLOR_41_41_45)
    txtNoData:setSize(400, 100)
    txtNoData:setTextCenter()
    self.contentLayer:addChild(txtNoData)
    self.txtNoData = txtNoData


    self.rightLayer = cc.Layer:create()
    self.rightLayer:setPosition(cc.p(0,0))
    self.rightLayer:setContentSize(cc.size(958,575))
    self.rootLayer:addChild(self.rightLayer)

    self.m_pRankTypeTableView = cc.TableView:create(cc.size(140,444))
    self.m_pRankTypeTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.m_pRankTypeTableView:setPosition(cc.p(841, 39))
    self.m_pRankTypeTableView:setDelegate()
    self.m_pRankTypeTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.rightLayer:addChild(self.m_pRankTypeTableView)
    --registerScriptHandler functions must be before the reloadData funtion
    self.m_pRankTypeTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableViewByRankType),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.m_pRankTypeTableView:registerScriptHandler(handler(self,self.tableCellTouchedByRankType),cc.TABLECELL_TOUCHED)
    self.m_pRankTypeTableView:registerScriptHandler(handler(self,self.cellSizeForTableByRankType),cc.TABLECELL_SIZE_FOR_INDEX)
    self.m_pRankTypeTableView:registerScriptHandler(handler(self,self.tableCellAtIndexByRankType),cc.TABLECELL_SIZE_AT_INDEX)
    self.m_pRankTypeTableView:setScrollBarEnabled(false)
    if GameManager:getIsGooglePlay() then
        self.m_pRankTypeTableView:registerScriptHandler(handler(self,self.tableCellHightLightByRankType),cc.TABLECELL_HIGH_LIGHT)
        self.m_pRankTypeTableView:registerScriptHandler(handler(self,self.tableCellUnHightLightByRankType),cc.TABLECELL_UNHIGH_LIGHT)
    end

    local capImage = UI.Image:create()
    capImage:init("ui_rankinglist_gradually.png")
    capImage:leftBottom(232, 28)
    self.rootLayer:addChild(capImage)
    capImage:setScale(1.06)
    self.capImage = capImage

    local pMyCellbottom = UI.RankingCell:create(nil,self.myRank - 1,nil,self.myRank,self)
    pMyCellbottom:setName("myCell")
    pMyCellbottom:leftBottom(206,29)
    pMyCellbottom:setSingle(true, true)
    self.rootLayer:addChild(pMyCellbottom, 100)
    self.pMyCellbottom = pMyCellbottom
    self.pMyCellbottom:setVisible(false)
    self.pMyCellbottom:setTouchEnable(true)
    self.pMyCellbottom:setInterceptTouches(false)


    local pMyCelltop = UI.RankingCell:create(nil,self.myRank - 1,nil,self.myRank,self)
    pMyCelltop:setName("myCell")
    pMyCelltop:leftUp(206,150)
    pMyCelltop:setSingle(true, false)
    self.rootLayer:addChild(pMyCelltop, 100)
    self.pMyCelltop = pMyCelltop
    self.pMyCelltop:setVisible(false)
    self.pMyCelltop:setTouchEnable(true)
    self.pMyCelltop:setInterceptTouches(false)

    self:initCurDefault()

    self:updateRankType(self:computeRankType(1, self.curFilterBigType, self.curFilterSmallType))
    self.m_pRankTypeTableView:reloadData()

    self.filterBtn:setText(self:getFilterOpStr(self.curFilterBigType, self.curFilterSmallType))
end

function RankingLayer:tableCellHightLightByRankCell(table,cell)
    if(not cell or cell.getIdx == nil) then 
        return
    end
    local endIndex = cell:getIdx() + 1
    if self._tableRankCellArr[endIndex] and not tolua.isnull(self._tableRankCellArr[endIndex]) then 
        self._tableRankCellArr[endIndex]:getChildByName("cell"):hightLight()
    end

    Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
        if(not tolua.isnull(self)) then
            if(self._tableRankCellArr[endIndex]) then 
                self._tableRankCellArr[endIndex]:getChildByName("cell"):unHightLight()
            end
        end
    end, 1)
end
function RankingLayer:tableCellUnHightLightByRankCell(table,cell)
    if(not cell or cell.getIdx == nil) then 
        return
    end
    local endIndex = cell:getIdx() + 1
    if self._tableRankCellArr[endIndex] and not tolua.isnull(self._tableRankCellArr[endIndex]) then 
        self._tableRankCellArr[endIndex]:getChildByName("cell"):unHightLight()
    end
end

function RankingLayer:tableCellHightLightByRankType(table,cell)
    if(not cell or cell.getIdx == nil) then 
        return
    end
    local endIndex = cell:getIdx() + 1
    if self._tableCellArr[endIndex] and not tolua.isnull(self._tableCellArr[endIndex]) then 
        self._tableCellArr[endIndex]:getChildByName("cell"):hightLight()
    end

    Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
        if(not tolua.isnull(self)) then
            print("wwwwww=", self.data[self:cellIdxToType(endIndex - 1) + 1].rankType, self:getBigRankType(self.rankType))
            if(self._tableCellArr[endIndex] and 
                self.data[self:cellIdxToType(endIndex - 1) + 1].rankType ~= self:getBigRankType(self.rankType)) then 
                self._tableCellArr[endIndex]:getChildByName("cell"):unHightLight()
            end
        end
    end, 1)
end
function RankingLayer:tableCellUnHightLightByRankType(table,cell)
    if(not cell or cell.getIdx == nil) then 
        return
    end
    local endIndex = cell:getIdx() + 1
    if self._tableCellArr[endIndex] and not tolua.isnull(self._tableCellArr[endIndex]
        and self.data[self:cellIdxToType(endIndex - 1) + 1].rankType ~= self:getBigRankType(self.rankType)) then 
        self._tableCellArr[endIndex]:getChildByName("cell"):unHightLight()
    end
end

function RankingLayer:refreshNoDataTip()
    if self.rankType == -1 then
        return
    end
    if self.data[self.rankType] == nil then
        self.txtNoData:setVisible(true)
    elseif #self.data[self.rankType].data > 0 then
        self.txtNoData:setVisible(false)
    else
        -- if self.rankType == PublicDefine.RankType.RankType_Dungeon then
        --     local seasonData = MasterDataManager:getCurrentSeasonData()
        --     if seasonData == nil or seasonData.open == false then
        --         self.txtNoData:setText(UI.TEXT_110089)
        --     else
        --         self.txtNoData:setText(UI.TEXT_110088)
        --     end
        -- else
            self.txtNoData:setText(UI.TEXT_110088)
        -- end
        self.txtNoData:setVisible(true)
    end
end

function RankingLayer:getBigRankType(rankType)
    return (rankType or self.rankType) - math.floor((rankType or self.rankType)/10)*10
end
function RankingLayer:isTotalRankType(rankType)
    local rt = (rankType or self.rankType)
    rt = (rt - self:getBigRankType(rt))/10
    return (rt - math.floor(rt/100)*100) == SelectTabType.ALL
end

function RankingLayer:adapterRankType(ordinaryRankType)
    local rType = ordinaryRankType - math.floor(ordinaryRankType/10)*10
    local tmp = (ordinaryRankType - rType)/10
    local filterType = tmp - math.floor(tmp/100) * 100
    local filterIndex = (tmp - filterType)/100
    if filterType == SelectTabType.CAVE then
        if filterIndex == self.normalCaveCount then
            filterType = SelectTabType.DESERT_EYE
            return self:computeRankType(rType, filterType, 0)
        elseif filterIndex == self.normalCaveCount + 1 then
            filterType = SelectTabType.DISTORTED_SPACE
            return self:computeRankType(rType, filterType, 0)
        elseif filterIndex == self.normalCaveCount + 2 then
            filterType = SelectTabType.INFERNO
            return self:computeRankType(rType, filterType, 0)
        elseif filterIndex == self.normalCaveCount + 3 then
            filterType = SelectTabType.VOIDRIFT
            return self:computeRankType(rType, filterType, 0)
        elseif filterIndex == self.normalCaveCount + 4 then
            filterType = SelectTabType.VIKING
            return self:computeRankType(rType, filterType, 0)
        elseif filterIndex == self.normalCaveCount + 5 then
            filterType = SelectTabType.TITAN_ROAD
            return self:computeRankType(rType, filterType, 0)
        elseif filterIndex == self.normalCaveCount + 6 then
            filterType = SelectTabType.DRIED_SPRING
            return self:computeRankType(rType, filterType, 0)
        elseif filterIndex == self.normalCaveCount + 7 then
            filterType = SelectTabType.CHAOS
            return self:computeRankType(rType, filterType, 0)
        end
    end
    return ordinaryRankType
end


--改变排行榜类型
function RankingLayer:updateRankType(rankType)
    -- if self.actionFlag then
    --     return
    -- end

    print("updateRankType=======", rankType)
    if self.data[rankType] == nil or self.data[rankType].data == nil or self.data[rankType].time <= 0 then
        
        Net.NetRankSystem:requestRankList(self:adapterRankType(rankType))
        if table.nums(self.isPlayTableAct) == 0 then
            self.isPlayTableAct[rankType] = AvalonUtil.getCurrentTime()
        end
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            if self ~= nil and not tolua.isnull(self) then
                self:refreshNoDataTip()
            end
        end, 0.5)
        return
    end
    if self.rankType == rankType then
        return
    end
    self.rankType = rankType
    local score = self.data[rankType].myRankData.score
    if self:isTotalRankType(rankType) then
        local rank = 0
        if self:getBigRankType() == PublicDefine.RankType.RankType_EquipMent then
            -- score
            score = MasterDataManager:getMaxEquipScore()
        elseif self:getBigRankType() == PublicDefine.RankType.RankType_Achievement then
            --成就
            score = RoleDataManager:getMaster():getAchievementPoint()
        elseif self:getBigRankType() == PublicDefine.RankType.RankType_Guild then
            --公会
            if MasterDataManager:getGuildData() then
                score = MasterDataManager:getGuildData():getContib()
            end

        elseif self:getBigRankType() == PublicDefine.RankType.RankType_Dungeon then
            score = RoleDataManager:getMaster():getMaxDungeonLevelAndMinTimeForSeason()
        elseif self:getBigRankType() == PublicDefine.RankType.RankType_Mentor then
            score = 0
        end

        if score < self.data[rankType].myRankData.score then
            score = self.data[rankType].myRankData.score
        end

        -- dump(self.data[rankType].myRankData)

        if self.data[rankType].myRankData.score ~= score or self.data[rankType].myRankData.rank == nil then
            self.data[rankType].myRankData.score = score
            -- dump(self.data[rankType].data[#self.data[rankType].data].score)
            if #self.data[rankType].data > 0 and (score >= self.data[rankType].data[#self.data[rankType].data].score or self.data[rankType].myRankData.rank == nil) then
                --重新排序
                local mark = false
                for i = 1,#self.data[rankType].data do
                    -- print(self.data[rankType].myRank,i,mark,rank)
                    -- print(mark == true and i < rank)
                    if mark == true and i <= rank  then
                        self.data[rankType].data[i].rank = self.data[rankType].data[i].rank + 1
                    end

                    if mark == false and score > self.data[rankType].data[i].score then

                        if i > self.data[rankType].myRank then
                            break
                        end

                        rank = self.data[rankType].myRank
                        self.data[rankType].myRankData.rank = i


                        if self.data[rankType].myRank <= 200 then
                            table.remove(self.data[rankType].data,self.data[rankType].myRank)
                        elseif self.data[rankType].myRank >= 9999 then
                            table.remove(self.data[rankType].data,#self.data[rankType].data)
                        end

                        self.data[rankType].myRank = i
                        table.insert(self.data[rankType].data,i,self.data[rankType].myRankData)
                        mark = true
                    end
                end
            end
        end
    end
    print("@@@",self.data[rankType].myRank,score)

    self:refreshNoDataTip()
    self.headDataList = {}
    local bigRankType = self:getBigRankType(rankType)
    self.txtTitleRank:setText(self.data[bigRankType].titleRank)
    self.txtTitleName:setText(self.data[bigRankType].titleName)
    self.txtTitleData:setText(self.data[bigRankType].titleData)
    if self.data[self.rankType].myRankData.score == 0 then
        self.data[self.rankType].myRankData.show = false
    else
        self.data[self.rankType].myRankData.show = true
    end

    if self.data[self.rankType].myRankData.show ~= false then
        local command = {
            execute = function ( ... )
                if not tolua.isnull(self) and not tolua.isnull(self.pMyCellbottom) and self.pMyCellbottom ~= nil then
                    self.pMyCellbottom:reload(self.data[self.rankType].myRankData,self.data[self.rankType].myRank - 1,bigRankType,self.data[self.rankType].myRank)
                end
            end,
            isExecute = false,
        }
        self.renderQueue:push_back(command)
        
        local command = {
            execute = function ( ... )
                if not tolua.isnull(self) and not tolua.isnull(self.pMyCelltop) and self.pMyCelltop ~= nil then
                    self.pMyCelltop:reload(self.data[self.rankType].myRankData,self.data[self.rankType].myRank - 1,bigRankType,self.data[self.rankType].myRank)
                end
            end,
            isExecute = false,
        }
        self.renderQueue:push_back(command)
    end

    if self.pMyCellbottom then
        self.pMyCellbottom:setVisible(false)
    end
    if self.pMyCelltop then
        self.pMyCelltop:setVisible(false)
    end

    -- self.m_pItemTableView:setContentOffset(cc.p(0,-self.m_pItemTableView:getContentSize().height + self.m_pItemTableView:getViewSize().height), false)
    self.actionFlag = true
    self.m_pItemTableView:stopScrolling()

    local totalTime = 0.18
    -- dump(self.isPlayTableAct, "---self.isPlayTableAct---")
    if table.nums(self.isPlayTableAct) == 0 then
       self.m_pItemTableView:reloadData(true, totalTime, Game.TableCellInitTime, Game.TableCellAddTime)
    elseif self.isPlayTableAct[rankType] ~= nil then
        local time = totalTime - self.isPlayTableAct[rankType]
        time = time < 0 and 0 or time
        if time == 0 then
            self.m_pItemTableView:reloadData()
        else
            self.m_pItemTableView:reloadData(true, time, Game.TableCellInitTime, Game.TableCellAddTime)
        end
    else
        self.m_pItemTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    end
    self.isPlayTableAct[rankType] = totalTime
    self.m_pRankTypeTableView:reloadData()

    self.txtDesData:setVisible(true)
    if self:getBigRankType() == PublicDefine.RankType.RankType_Dungeon then
        -- local currentSeasonData = MasterDataManager:getCurrentSeasonData()
        -- if currentSeasonData ~= nil and currentSeasonData.seasonID ~= 0 then
            -- if currentSeasonData.open then
                -- local GameInDungeonManager = require "app.game.GameInDungeonManager"
                -- local startTime, endTime = GameInDungeonManager:getSeasonShowTime()
                -- local startTimeStr = GameManager:getNowServerDate("%Y/%m/%d", startTime + GameManager:getEPOCHTime())
                -- local endTimeStr = GameManager:getNowServerDate("%Y/%m/%d", endTime + GameManager:getEPOCHTime())
                -- self.txtDesData:setText(string.format(self.data[rankType].des[1],currentSeasonData.seasonID,startTimeStr,endTimeStr))
                -- self.titleTime:setText(string.format("%s-%s",startTimeStr,endTimeStr))
                -- self.titleTime:show()
                -- self.title:leftUp(self.title:getLeft(), 8)
            -- else
                self.txtDesData:setText(self.data[bigRankType].des[1])
                self.title:leftUp(self.title:getLeft(), 18)
                self.titleTime:hide()
            -- end
        -- else
        --     self.txtDesData:setVisible(false)
        --     self.title:leftUp(self.title:getLeft(), 18)
        --     self.titleTime:hide()
        -- end
    else
        self.txtDesData:setText(self.data[bigRankType].des)
        self.title:leftUp(self.title:getLeft(), 18)
        self.titleTime:hide()
    end
end

--跳转到指定的cell
--index cell的index
--animated 如果为true则以MoveTo滚动的方式延迟到达指定的cell
function RankingLayer:scrollToCell(index)
    local point = self.m_pItemTableView:getContentOffset()
    local height = self.m_pItemTableView:getContentSize().height;
    local viewHeight = self.m_pItemTableView:getViewSize().height;

    point.y =  -height + viewHeight +((index) * 550)

    if point.y > 0 then
        point.y = 0
    end

    self.m_pItemTableView:setContentOffset(point, false)
end


function RankingLayer:scrollView(y)
    local point = self.m_pItemTableView:getContentOffset()
    -- print("RankingLayer:scrollView11",point.y)
    local height = self.m_pItemTableView:getContentSize().height;
    local viewHeight = self.m_pItemTableView:getViewSize().height;
    point.y = -height + viewHeight + (height-viewHeight) * y / self._barHeight

    if point.y > 0 then
        point.y = 0
    end

    if height < viewHeight then
        point.y = viewHeight - height
    end

    self.m_pItemTableView:setContentOffset(point, false)
end

function RankingLayer:numberOfCellsInTableView(table)
    -- print("RankingLayer:numberOfCellsInTableView")
    if self.data[self.rankType] and self.data[self.rankType].data then
        return #(self.data[self.rankType].data)
    else
        return 0
    end
end


function RankingLayer:scrollViewDidScroll(view)

 
    if self.actionFlag then
        return
    end
    local offsetY = view:getContentOffset().y
    if offsetY > 0 then
        offsetY = 0;
    end
    local viewHeight = view:getViewSize().height;
    local height = view:getContentSize().height;
    self.capImage:leftBottom(232, 28)
    local y = (offsetY + height - viewHeight) * self._barHeight/(height - viewHeight)
    -- self.pRankingProBar:updateNowBar(self._barHeight - y)
    -- print("height",height,offsetY,view:getContentOffset().y,(self.data[self.rankType].myRank - 1) * 70 - 5,(viewHeight - height - (self.data[self.rankType].myRank - 1) * 70 - 5) > offsetY)
    if self.data[self.rankType].myRankData.show ~= false then
        if (height + offsetY > (self.data[self.rankType].myRank) * 73 - 5) or view:getContentOffset().y > -5 then
            if self.pMyCellbottom then
                self.pMyCellbottom:setVisible(false)
            end
        else
            if self.pMyCellbottom then
                self.pMyCellbottom:setVisible(true)
                self.capImage:leftBottom(232, 101)
            end
        end
        -- print("offsetY",offsetY)
        -- print("view:getContentOffset().y",view:getContentOffset().y)
        -- print(viewHeight , height , (self.data[self.rankType].myRank -1) * 70 - 5 , (viewHeight - height + (self.data[self.rankType].myRank - 1) * 70 - 5), offsetY )
        if (viewHeight - height + (self.data[self.rankType].myRank - 1) * 73 + 1) > view:getContentOffset().y  then
            if self.pMyCelltop then
                self.pMyCelltop:setVisible(false)
            end
        else
            if self.pMyCelltop then
                self.pMyCelltop:setVisible(true)
            end
        end
    else
        if self.pMyCellbottom then 
            self.pMyCellbottom:setVisible(false)
        end
        if self.pMyCelltop then
            self.pMyCelltop:setVisible(false)
        end
    end
end

function RankingLayer:scrollViewDidZoom(view)
    -- print("scrollViewDidZoom")
end

function RankingLayer:tableCellTouched(table,cell)
    Avalon.AudioManager:playSound(self.clickAudioID)
    local index = cell:getIdx()
    local pk = self.data[self.rankType].data[index + 1].pk

    if self:getBigRankType() == PublicDefine.RankType.RankType_EquipMent 
        or self:getBigRankType() == PublicDefine.RankType.RankType_Achievement 
        or self:getBigRankType() == PublicDefine.RankType.RankType_Dungeon 
        or self:getBigRankType() == PublicDefine.RankType.RankType_Mentor
    then
        if pk ~= RoleDataManager:getMasterPK() then
            Net.NetRoleSystem:heroDetailRequest(pk, 1,nil,nil,self:getBigRankType())
        end
    elseif self:getBigRankType() == PublicDefine.RankType.RankType_Guild then
        mvc.openPanel("GuildInfo", "GuildInfo", pk)
    end
end

function RankingLayer:cellSizeForTable(table,idx)
    return 668, 73
end

function RankingLayer:tableCellRecycle(table,cell)
    -- print(cell:getIdx(),"被回收")
    local idx = checkint(cell:getIdx())
    local needRemove = self.renderQueue:find(function (command)
        -- dump(command)
        -- print(command.idx)
        if command and command.idx == idx then return true end
        return false;
    end)
    if needRemove then 
        -- print("删除未执行的")
        self.renderQueue:remove(needRemove)
    end
end

function RankingLayer:reloadActionEndCallback(table)
    self.actionFlag = false
    self:scrollViewDidScroll(table)
end

function RankingLayer:tableCellAtIndex(tableView,idx)
    -- print("RankingLayer:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    xpcall(function()      
    local bigRankType = self:getBigRankType(self.rankType)
        if nil == cell then
            cell = cc.TableViewCell:new()
            local pRankingCell = UI.RankingCell:create(self.data[self.rankType].data[idx + 1],idx,bigRankType,self.data[self.rankType].myRank,self)
            pRankingCell:setName("cell")
            pRankingCell:leftBottom(0, 0)
            cell:addChild(pRankingCell)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self.data[self.rankType].data[idx + 1],idx,bigRankType,self.data[self.rankType].myRank)
        end
    end, 
    function(e) 
        printError("--------------------RankingLayer:tableCellAtIndex---------------------error")
    end, 1) 
    self._tableRankCellArr[idx + 1] = cell
    return cell;
end


function RankingLayer:numberOfCellsInTableViewByRankType(tableView)
    return 5
end

function RankingLayer:cellIdxToType(idx)
    -- Type 5 被梦境使用了, 必须跳过
    return idx > 3 and idx + 1 or idx
end

function RankingLayer:tableCellTouchedByRankType(table,cell)
    -- print("RankingLayer:tableCellTouchedByRankType",cell:getIdx())
    Avalon.AudioManager:playSound(self.clickAudioID)
    local idx = self:cellIdxToType(cell:getIdx())
    local toRankType = self.data[idx + 1].rankType 
    self.filterBtn:show()
    local lastRankType = self:getBigRankType(self.rankType)
    recordTags[lastRankType] = {self.curFilterBigType, self.curFilterSmallType}
    local record = recordTags[toRankType]
    if not record then
        if toRankType == 2 then
            record = recordTags[1]
        elseif toRankType == 4 then
            record = {SelectTabType.ALL, 0}
        end
    end

    if toRankType == 3 or 
       toRankType == PublicDefine.RankType.RankType_Mentor then
        self.filterBtn:hide()
    end
    
    self.curFilterBigType = record and record[1] or 0
    self.curFilterSmallType = record and record[2] or 0

    self.filterBtn:setText(self:getFilterOpStr(self.curFilterBigType, self.curFilterSmallType))
    self:updateRankType(self:computeRankType(toRankType, self.curFilterBigType, self.curFilterSmallType))
end

function RankingLayer:cellSizeForTableByRankType(table,idx)
    return 100, 75
end

function RankingLayer:tableCellAtIndexByRankType(tableView,idx)
    local cell = tableView:dequeueCell()
    xpcall(function()
        if nil == cell then
            cell = cc.TableViewCell:new()
            local pRankingTypeCell = UI.RankingTypeCell:create()
            pRankingTypeCell:setName("cell")
            pRankingTypeCell:reload(self.data[self:cellIdxToType(idx) + 1],self:getBigRankType(self.rankType))
            cell:addChild(pRankingTypeCell)
            pRankingTypeCell:leftBottom(0, 0)
        else
             local obj = cell:getChildByName("cell")
            obj:reload(self.data[self:cellIdxToType(idx) + 1],self:getBigRankType(self.rankType))
        end
    end, 
    function(e) 
        printError("--------------------BagFullLayer:tableCellAtIndex---------------------error")
    end, 1) 

    self._tableCellArr[idx + 1] = cell
    return cell;
end

-- 每帧截屏3个
function RankingLayer:update(dt)
    local limite = 3
    local size = self.renderQueue:size()
    size = size > limite and limite or size
    if size > 0 then
        for i = 1, size do
            local renderCMD = self.renderQueue:pop_front();
            if renderCMD then 
                renderCMD.execute()
            end
        end
    end  
end

--获取头像
function RankingLayer:getHead(sex,faceDecodeID, callfunc,idx)
    -- print("RankingLayer:getHead",sex,faceDecodeID, #self.headDataList)
    local heroData = Data.HeroData:create()
    heroData:setNickName("")
    heroData:setLevel(0)
    heroData:setSex(sex or PublicDefine.HERO_SEX.MALE)
    heroData:setFaceDecodeID(faceDecodeID)

    local command = {
        execute = function ( ... )
            self:exportHead(heroData, callfunc);
        end,
        isExecute = false,
        idx = idx,
    }
    self.renderQueue:push_back(command)

end

function RankingLayer:exportHead(headData, callfunc)
    -- if self.headDataList[1] == nil then
    --     return
    -- end
    Avalon.WidgetUtil:getHead(self, headData ,{}, self, handler(self,function(self,pic)
        if self and not tolua.isnull(self) then
           callfunc(pic, headData.faceDecodeID)
        end
    end),true)

end


-- 模版函数：更新组建的视图
function RankingLayer:onUpdateView()
end

function RankingLayer:refreshRankListData(data) 

    local filterType = data.filter.filterType or 0
    local filterIndex = data.filter.filterIndex or 0
    if filterType == SelectTabType.CAVE then --服务器从0开始计数的
        filterIndex = filterIndex + 1
    end
    if filterType == SelectTabType.DESERT_EYE then
        filterType = SelectTabType.CAVE
        filterIndex = self.normalCaveCount + 1
    elseif filterType == SelectTabType.DISTORTED_SPACE then
        filterType = SelectTabType.CAVE
        filterIndex = self.normalCaveCount  + 2
    elseif filterType == SelectTabType.INFERNO then
        filterType = SelectTabType.CAVE
        filterIndex = self.normalCaveCount  + 3
    elseif filterType == SelectTabType.VOIDRIFT then
        filterType = SelectTabType.CAVE
        filterIndex = self.normalCaveCount  + 4
    elseif filterType == SelectTabType.VIKING then
        filterType = SelectTabType.CAVE
        filterIndex = self.normalCaveCount  + 5
    elseif filterType == SelectTabType.TITAN_ROAD then
        filterType = SelectTabType.CAVE
        filterIndex = self.normalCaveCount  + 6
    elseif filterType == SelectTabType.DRIED_SPRING then
        filterType = SelectTabType.CAVE
        filterIndex = self.normalCaveCount  + 7
    elseif filterType == SelectTabType.CHAOS then
        filterType = SelectTabType.CAVE
        filterIndex = self.normalCaveCount  + 8
    end

    data.rankType = self:computeRankType(data.rankType, filterType, filterIndex)

    local myRankData = {}
    myRankData.score = data.selfScore
    myRankData.show = true
    myRankData.rank = nil
    if data.selfRank == 0 then
        self.myRank = nil
        if self:getBigRankType(data.rankType) == PublicDefine.RankType.RankType_Dungeon and self:isTotalRankType(data.rankType) then
            local maxLevelData = RoleDataManager:getMaster():getMaxDungeonLevelAndMinTimeForSeason()
            if maxLevelData ~= 0 then
                myRankData.score = maxLevelData

            else
                myRankData.score = 0
                myRankData.show = false
            end
        elseif self:getBigRankType(data.rankType) == PublicDefine.RankType.RankType_Guild then
            if MasterDataManager:getGuildData() then
                myRankData.score = MasterDataManager:getGuildData():getContib()
            else
                myRankData.score = 0
                myRankData.show = false
            end
        end
    else
        self.myRank = data.selfRank
    end
    myRankData.rank = self.myRank

    if self:getBigRankType(data.rankType) == PublicDefine.RankType.RankType_Dungeon then
        if self.myRank == nil then
            MasterDataManager:setDungeonRanking(-1)
        else
            MasterDataManager:setDungeonRanking(self.myRank)
        end
    end
    
    if self:getBigRankType(data.rankType) ~= PublicDefine.RankType.RankType_Guild then
        myRankData.nickName = ToolsUtil:replaceShowNickNameStr(RoleDataManager:getMaster():getNickName())
        myRankData.faceId = RoleDataManager:getMaster():getFaceDecodeID()
        myRankData.sex = RoleDataManager:getMaster():getSex()
        myRankData.pk = RoleDataManager:getMasterPK()
    else
        if GameDataManager:getInstance():getIsJoinGuild() then
            myRankData.nickName = ToolsUtil:replaceShowNickNameStr(MasterDataManager:getGuildData().name)
            myRankData.faceId = MasterDataManager:getGuildData().iconID
            myRankData.pk = MasterDataManager:getGuildData():getID()
        else
            myRankData.pk = 0
        end
    end


    if myRankData.score == 0 then
        myRankData.show = false
    end
    -- dump(myRankData)
    -- print(self.myRank)
    self.data[data.rankType] = self.data[data.rankType] or {}
    self.data[data.rankType].myRankData = myRankData
    self.data[data.rankType].myRank = self.myRank or 9999
    self.data[data.rankType].time = tonumber(ConfigManager:getGeneralForKey("rankRefresh"))/1000
    self.data[data.rankType].data = {}
    if data.rankList then
        for i = 1,#data.rankList do
            local rankData = {}
            rankData.pk = data.rankList[i].pk
            rankData.rank = data.rankList[i].rank
            rankData.score = data.rankList[i].score
            rankData.nickName = ToolsUtil:replaceShowNickNameStr(data.rankList[i].nickName)
            rankData.faceId = data.rankList[i].faceId
            rankData.sex = data.rankList[i].sex
            -- print(rankData.rank,rankData.nickName,rankData.score)
            table.insert(self.data[data.rankType].data,rankData)
        end
    end

    if myRankData.show ~= false then
        if (self:getBigRankType(data.rankType) == PublicDefine.RankType.RankType_EquipMent 
            or self:getBigRankType(data.rankType) == PublicDefine.RankType.RankType_Dungeon) and (data.selfRank == 0 or data.selfRank > 200) then
            table.insert(self.data[data.rankType].data,myRankData)
        end

        if self:getBigRankType(data.rankType) == PublicDefine.RankType.RankType_Guild and (data.selfRank == 0 or data.selfRank > 200) then
            if GameDataManager:getInstance():getIsJoinGuild() then
                table.insert(self.data[data.rankType].data,myRankData)
            end
        end
    end
    if self.isPlayTableAct[data.rankType] and self.isPlayTableAct[data.rankType] > 1000 then -- 值 代表的开始时间
        self.isPlayTableAct[data.rankType] = (AvalonUtil.getCurrentTime() - self.isPlayTableAct[data.rankType]) / 1000
    end
    self:updateRankType(data.rankType)
end

function RankingLayer:showRankHeroInfo(data)
    if data.heroInfo.result == nil or data.heroInfo.result ~= "HeroDetailResult_success" then
        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.HeroDetailResult", data.result))
    else
        local heroData = Data.HeroData:create()
        heroData:setNickName(ToolsUtil:replaceShowNickNameStr(data.heroInfo.nickName))
        heroData:setLevel(data.heroInfo.roleLV)
        heroData:setSex(data.heroInfo.sex)
        heroData:setFaceDecodeID(data.heroInfo.faceDecodeID)
        -- print("data.heroInfo.sex",data.heroInfo.sex)
        local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(heroData.spriteID)
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_SHOW_ROLE_INFO, heroData)
    end
end

-- 注册监听事件
function RankingLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_LIST, self, self.refreshRankListData)
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_HERO_INFO, self, self.showRankHeroInfo)
end


-- 注销监听事件
function RankingLayer:unRegisterListener()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_RANK_LIST, self, self.refreshRankListData)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RANK_HERO_INFO, self, self.showRankHeroInfo)
end

function RankingLayer:openShow()
    self:open(self.rootLayer)
end





function RankingLayer:onTouchSelectOutsizeHandler()
    Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
        if self.selectRootNode then
            self.selectRootNode:removeFromParent()
            self.selectRootNode = nil
            self.filterBtn:setBtnStatus(ButtonState.NORMAL)

        end
    end, 1)
end

require "app.ui.common.Tab.TabItem"
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



function RankingLayer:computeRankType(rankType, filterBigType, filterSmallType)
    if filterBigType == SelectTabType.CAVE then --服务器从0开始计数的
        filterSmallType = filterSmallType - 1
    end
    return filterSmallType * 1000 + filterBigType * 10 + rankType
end

function RankingLayer:getRankInfo(tabType, selectIdx)
    if tabType == self.curFilterBigType and self.curFilterBigType == SelectTabType.ALL 
        or tabType == self.curFilterBigType and selectIdx == self.curFilterSmallType then
        if self.ignorClicked == 1 then
            self:onTouchSelectOutsizeHandler()
        end
        self.ignorClicked = self.ignorClicked - 1
        return
    end

    self:onTouchSelectOutsizeHandler()
    self.filterBtn:setText(self:getFilterOpStr(tabType, selectIdx))
    self.curFilterBigType = tabType
    self.curFilterSmallType = selectIdx
    
    local rankType = self:getBigRankType(self.rankType)

    self:updateRankType(self:computeRankType(rankType, tabType, selectIdx))

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
    title:init(lang, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK )
    title:center()
    title:setTextCenter()
    tab:addChild(title)
    return tab
end


function RankingLayer:getMaxCave()
    local maxCave = tonumber(ConfigManager:getGeneralForKey("maxLayers"))
    return maxCave,30
end

function RankingLayer:getMyCaveIdx( )
    local maxCave,perGrade = self:getMaxCave()
    local normalCaveCount = math.ceil(maxCave/perGrade)
    self.normalCaveCount = normalCaveCount

    local chaosSpaceLevel = ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_CHAOS)
    if chaosSpaceLevel > 0 then
        return normalCaveCount + 8
    end

    local driedSpringLevel = ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_DRIED_SPRING)
    if driedSpringLevel > 0 then
        return normalCaveCount + 7
    end

    local titanRoadLevel = ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD)
    if titanRoadLevel > 0 then
        return normalCaveCount + 6
    end

    local distortedSpaceLevel = ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_VIKING)
    if distortedSpaceLevel > 0 then
        return normalCaveCount + 5
    end
    local distortedSpaceLevel = ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_VOID_RIFT)
    if distortedSpaceLevel > 0 then
        return normalCaveCount + 4
    end
    local distortedSpaceLevel = ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_INFERNO)
    if distortedSpaceLevel > 0 then
        return normalCaveCount + 3
    end

    local distortedSpaceLevel = ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE)
    if distortedSpaceLevel > 0 then
        return normalCaveCount + 2
    end
    local desertEyeLevel = ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_DESERT_EYES)
    if desertEyeLevel > 0 then
        return normalCaveCount + 1
    end

    local maxLevelData = GameDataManager:getMaster():getMaxLevelData(PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    local caveLevel = maxLevelData:getMaxLevel()
    local idx = math.ceil(caveLevel/perGrade)
    return idx
end

function RankingLayer:initCurDefault()
    self.curFilterBigType = SelectTabType.CAVE
    
    self.curFilterSmallType = self:getMyCaveIdx( )
    if self.curFilterSmallType == 0 then
        self.curFilterSmallType = 1
    end
end


function RankingLayer:tableCellTouchedBySelectType(table,cell)
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

function RankingLayer:tableCellAtIndexBySelectType(tableView,idx)
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
function RankingLayer:tableCellNumsBySelectType(tabIndex, lastTabIndex)
    return #self.selectContentData
end

function RankingLayer:cellSizeForTableBySelectType(table,idx)
    return 210, 45
end

function RankingLayer:getFilterOpStr(filterType, filterIdx)
    local lang = ""
    if filterType == SelectTabType.JOB then
        local langId = {
            1111376, 1111375,1111377
        }
        lang = LanguageManager:getInstance():getLocalString(langId[filterIdx])
    elseif filterType == SelectTabType.CAVE then
        local max,perGrade = self:getMaxCave()
        if filterIdx == self.normalCaveCount + 1 then
            return UI.TEXT_1212850
        elseif filterIdx == self.normalCaveCount + 2 then
            return UI.TEXT_1212851
        elseif filterIdx == self.normalCaveCount + 3 then
            return UI.TEXT_1325500  
        elseif filterIdx == self.normalCaveCount + 4 then
            return UI.TEXT_222100
        elseif filterIdx == self.normalCaveCount + 5 then
            return UI.TEXT_223800
        elseif filterIdx == self.normalCaveCount + 6 then
            return UI.TEXT_224400
        elseif filterIdx == self.normalCaveCount + 7 then
            return UI.TEXT_225000
        end
        lang = string.format(UI.TEXT_1212244, (filterIdx - 1) * perGrade + 1, filterIdx*perGrade > max and max or filterIdx*perGrade)
    else
        lang = UI.TEXT_1212240
    end
    return lang
end

function RankingLayer:isActive(tabIndex, smallType)
    return self.curFilterBigType == tabIndex and self.curFilterSmallType == smallType
end

function RankingLayer:showSelectLevelContent(tabIndex, lastTabIndex, tabItem)
    -- self.selectRootNode:removeChildByName("scrollviewContent")
    if self.m_pSelectLvView then
        self.m_pSelectLvView:removeFromParent()
        self.m_pSelectLvView = nil
    end
    local tabType = tabItem.tabType


    if tabType == SelectTabType.ALL then
        self:getRankInfo(SelectTabType.ALL,SelectTabType.ALL)
        return
    end
    self.selectContentData = {}
    if tabType == SelectTabType.JOB then
        local lang = {
            1111376, 1111375,1111377
        }
        for i = 1, #lang do
            self.selectContentData[i] = {isActive = self:isActive(tabType, i), lang = LanguageManager:getInstance():getLocalString(lang[i]), isSelf = false}
        end
    elseif tabType == SelectTabType.CAVE then
        local max,perGrade = self:getMaxCave()
        local tabCount = math.ceil(max/perGrade)
        local curIdx = self:getMyCaveIdx( )
        for i = 1, tabCount do
            self.selectContentData[i] = {isActive = self:isActive(tabType, i), lang = self:getFilterOpStr(tabType, i), isSelf = curIdx == i}
        end

        self.selectContentData[tabCount + 1] = {
            isActive = self:isActive(tabType, tabCount + 1), 
            lang = UI.TEXT_1212850, 
            isSelf = curIdx == tabCount + 1,
        }

        self.selectContentData[tabCount + 2] = {
            isActive = self:isActive(tabType, tabCount + 2), 
            lang = UI.TEXT_1212851, 
            isSelf = curIdx == tabCount + 2
        }

        self.selectContentData[tabCount + 3] = {
            isActive = self:isActive(tabType, tabCount + 3), 
            lang = UI.TEXT_1325500, 
            isSelf = curIdx == tabCount + 3
        }

        self.selectContentData[tabCount + 4] = {
            isActive = self:isActive(tabType, tabCount + 4), 
            lang = UI.TEXT_222100, 
            isSelf = curIdx == tabCount + 4
        }

        self.selectContentData[tabCount + 5] = {
            isActive = self:isActive(tabType, tabCount + 5), 
            lang = UI.TEXT_223800, 
            isSelf = curIdx == tabCount + 5
        }

        self.selectContentData[tabCount + 6] = {
            isActive = self:isActive(tabType, tabCount + 6), 
            lang = UI.TEXT_224400, 
            isSelf = curIdx == tabCount + 6
        }

        self.selectContentData[tabCount + 7] = {
            isActive = self:isActive(tabType, tabCount + 7), 
            lang = UI.TEXT_225000, 
            isSelf = curIdx == tabCount + 7
        }

        self.selectContentData[tabCount + 8] = {
            isActive = self:isActive(tabType, tabCount + 8), 
            lang = UI.TEXT_226500, 
            isSelf = curIdx == tabCount + 8
        }
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

function RankingLayer:showSelectContent()
    if not self.selectRootNode then
        self.m_pSelectLvView = nil
        local bG = UI.Image:create()
        bG:init("ui_rankinglist_screening_bg.png")
        bG:center(0)
        self.rootLayer:addChild(bG, 1000)
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

        local tab = createCustomItemHelper(UI.TEXT_1212240,true)
        tabList:addToTab(tab,3)
        tab.tabType = SelectTabType.ALL
        local tab = createCustomItemHelper(UI.TEXT_1212241)
        tabList:addToTab(tab,SelectTabType.JOB)
        tab.tabType = SelectTabType.JOB
        if self:getBigRankType(self.ranktype) ~= 4 then
            local tab = createCustomItemHelper(UI.TEXT_1212242)
            tabList:addToTab(tab,SelectTabType.CAVE)
            tab.tabType = SelectTabType.CAVE
        end

        if self.curFilterBigType == 0 then
            self.ignorClicked = 2
            tabList:setDefaultIndex(3)
        else
            self.ignorClicked = 2
            tabList:setDefaultIndex(self.curFilterBigType)
        end
        local view = cc.Layer:create()
        tabList:leftBottom(5,0)
        scrollView:addInnerNode(tabList)
        self.selectRootNode:addChild(scrollView)

        self.filterBtn:setBtnStatus(ButtonState.ACTIVE)
    else
        self:onTouchSelectOutsizeHandler()
    end
end
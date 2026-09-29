------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/29
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ArenaRankingView = class("ArenaRankingView", UI.HWBtnComponent)

local rankingCellView = require "app.modules.arena.ArenaRankingCellView"


-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 978
local COM_HEIGHT = 555

local cellHeight = 95

function ArenaRankingView:ctor()
    ArenaRankingView.super.ctor(
    	self,
    	UI.Type.ARENA_RANKING,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    reload_script_file_mvc("app.modules.arena.ArenaRankingCellView")
    self:bindModel()
    self.renderQueue = Avalon.List:create()
    self.data = mvc.arenaModel:getRankData()
    self.selfRankData = mvc.arenaModel:getSelfRankData()
    -- print("ArenaRankingView", #self.data)
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function ArenaRankingView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.arena", "Arena", false)
    ArenaRankingView.super.init(self, ... )
end

function ArenaRankingView:dtor()
    ArenaRankingView.super.dtor(self)
    self:unbindModel()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    self.renderQueue:destroy()
    reload_script_file_mvc("app.modules.arena.ArenaRankingView")
end


function ArenaRankingView:onInitView()
    local bg2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    bg2:setContentSize(939, 531)
    bg2:setCapInsets(CCRectMake(304, 141, 1, 1))
    bg2:setPosition(cc.p(939 / 2 + 18, 531 / 2 + 11))
    self:addChild(bg2)
    self.contentLayout = bg2

    -- 标题头
    local upOffset = 23
    local txtTitleRank = UI.Text:create()
    txtTitleRank:init(UI.TEXT_1212293, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    txtTitleRank:leftUp(22,upOffset)
    txtTitleRank:setSize(121, 44)
    txtTitleRank:setTextCenter()
    self.contentLayout:addChild(txtTitleRank)
    -- -- 头像
    -- local txtTitlePhoto = UI.Text:create()
    -- txtTitlePhoto:init(UI.TEXT_1212015, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- txtTitlePhoto:leftBottom(331,435)
    -- txtTitlePhoto:setSize(80, 44)
    -- txtTitlePhoto:setTextCenter()
    -- self.contentLayout:addChild(txtTitlePhoto)

    -- 昵称
    local nickName = UI.Text:create()
    nickName:init(UI.TEXT_110045,UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    nickName:leftUp(242,upOffset)
    nickName:setSize(200, 44)
    nickName:setTextCenter()
    -- nickName:enableDebugDraw()
    self.contentLayout:addChild(nickName)

    local scoreName = UI.Text:create()
    scoreName:init(UI.TEXT_1324406,UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    scoreName:leftUp(428,upOffset)
    scoreName:setSize(184, 44)
    scoreName:setTextCenter()
    self.contentLayout:addChild(scoreName)

    local rewardName = UI.Text:create()
    rewardName:init(UI.TEXT_1324407, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rewardName:leftUp(630,upOffset)
    rewardName:setSize(225, 44)
    rewardName:setTextCenter()
    self.contentLayout:addChild(rewardName)
    -- 标题结束

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine:setContentSize(902, 2)
    splitLine:setAnchorPoint(0, 0)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(19, 470)
    self.contentLayout:addChild(splitLine)

    local TABLE_SIZE_WIDHT = 889
    local TABLE_SIZE_HEIGHT = 465
    local tableLayout = UI.Layout:create()
    tableLayout:init()
    tableLayout:leftBottom(36, 3)
    tableLayout:setSize(TABLE_SIZE_WIDHT, TABLE_SIZE_HEIGHT)
    self.contentLayout:addChild(tableLayout)
    -- tableLayout:enableDebugDraw()

    self.m_pItemTableView = cc.TableView:create(cc.size(TABLE_SIZE_WIDHT, TABLE_SIZE_HEIGHT))
    self.m_pItemTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.m_pItemTableView:setPosition(cc.p(0, 0))
    self.m_pItemTableView:setDelegate()
    self.m_pItemTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableLayout:addChild(self.m_pItemTableView)
    --registerScriptHandler functions must be before the reloadData funtion
    self.m_pItemTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.m_pItemTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    -- self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellRecycle),cc.TABLECELL_WILL_RECYCLE)
    self.m_pItemTableView:registerAbsScriptHandler(handler(self,self.reloadActionEndCallback),cc.Handler.TABLEVIEW_RELOAD_ACTION_END)
    self.m_pItemTableView:initScrollBar(false)
    self.m_pItemTableView:setScrollBarWidth(6)
    self.m_pItemTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    if(self.data) then
        self.m_pItemTableView:reloadData()
    end


    local pMyCellbottom = rankingCellView:create(self, self.selfRankData)
    pMyCellbottom:setName("myCell")
    pMyCellbottom:leftBottom(0,0)
    pMyCellbottom:setSingle(true, true)
    tableLayout:addChild(pMyCellbottom, 100)
    self.pMyCellbottom = pMyCellbottom
    self.pMyCellbottom:setVisible(false)
    self.pMyCellbottom:setTouchEnable(true)
    self.pMyCellbottom:setInterceptTouches(false)


    local pMyCelltop = rankingCellView:create(self, self.selfRankData)
    pMyCelltop:setName("myCell")
    pMyCelltop:leftUp(0,0)
    pMyCelltop:setSingle(true, false)
    tableLayout:addChild(pMyCelltop, 100)
    self.pMyCelltop = pMyCelltop
    self.pMyCelltop:setVisible(false)
    self.pMyCelltop:setTouchEnable(true)
    self.pMyCelltop:setInterceptTouches(false)
end


function ArenaRankingView:numberOfCellsInTableView(table)
    -- print("RankingLayer:numberOfCellsInTableView")
    if self.data then
        return #self.data
    else
        return 0
    end
end


function ArenaRankingView:scrollViewDidScroll(view)
    if self.actionFlag then
        return
    end
    local offsetY = view:getContentOffset().y
    if offsetY > 0 then
        offsetY = 0;
    end
    local viewHeight = view:getViewSize().height;
    local height = view:getContentSize().height;
    -- local y = (offsetY + height - viewHeight) * self._barHeight/(height - viewHeight)
    -- self.pRankingProBar:updateNowBar(self._barHeight - y)
    -- print("height",height,offsetY,view:getContentOffset().y)
    if self.selfRankData.show ~= false then
        if (height + offsetY > (self.selfRankData.rank) * cellHeight - 5) or view:getContentOffset().y > -5 then
            if self.pMyCellbottom then
                self.pMyCellbottom:setVisible(false)
            end
        else
            if self.pMyCellbottom then
                self.pMyCellbottom:setVisible(true)
            end
        end
        -- print("offsetY",offsetY)
        -- print("view:getContentOffset().y",view:getContentOffset().y)
        -- print(viewHeight , height , (self.data[self.rankType].myRank -1) * 70 - 5 , (viewHeight - height + (self.data[self.rankType].myRank - 1) * 70 - 5), offsetY )
        if (viewHeight - height + (self.selfRankData.rank - 1) * cellHeight + 1) > view:getContentOffset().y  then
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

function ArenaRankingView:scrollViewDidZoom(view)
    -- print("scrollViewDidZoom")
end

function ArenaRankingView:tableCellTouched(table,cell)
    -- Avalon.AudioManager:playSound(self.clickAudioID)
    -- local index = cell:getIdx()
    -- local pk = self.data[self.rankType].data[index + 1].pk

    -- if self:getBigRankType() == PublicDefine.RankType.RankType_EquipMent 
    --     or self:getBigRankType() == PublicDefine.RankType.RankType_Achievement 
    --     or self:getBigRankType() == PublicDefine.RankType.RankType_Dungeon 
    --     or self:getBigRankType() == PublicDefine.RankType.RankType_Mentor
    -- then
    --     if pk ~= RoleDataManager:getMasterPK() then
    --         Net.NetRoleSystem:heroDetailRequest(pk, 1,nil,nil,self:getBigRankType())
    --     end
    -- elseif self:getBigRankType() == PublicDefine.RankType.RankType_Guild then
    --     mvc.openPanel("GuildInfo", "GuildInfo", pk)
    -- end
end

function ArenaRankingView:cellSizeForTable(table,idx)
    return 886, cellHeight
end

function ArenaRankingView:tableCellRecycle(table,cell)
    -- print(cell:getIdx(),"被回收")
    local idx = checkint(cell:getIdx())
    local needRemove = self.renderQueue:find(function (command)
        -- dump(command)
        -- print(command.idx)
        if command and command.idx == idx + 1 then return true end
        return false;
    end)
    if needRemove then 
        -- print("删除未执行的")
        self.renderQueue:remove(needRemove)
    end
end

function ArenaRankingView:reloadActionEndCallback(table)
    self.actionFlag = false
    self:scrollViewDidScroll(table)
end

function ArenaRankingView:tableCellAtIndex(tableView,idx)
    print("ArenaRankingView:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    xpcall(function()
        if nil == cell then
            print("ArenaRankingView:tableCellAtIndex  create",idx)
            cell = cc.TableViewCell:new()
            local pRankingCell = rankingCellView:create(self, self.data[idx + 1])
            pRankingCell:setName("cell")
            -- pRankingCell:enableDebugDraw()
            pRankingCell:leftBottom(0, 0)
            cell:addChild(pRankingCell)
        else
            local obj = cell:getChildByName("cell");
            if(obj) then
                print("ArenaRankingView:tableCellAtIndex  update",idx)
                obj:reload(self.data[idx + 1])
            end
        end
    end, 
    function(e) 
        printError("--------------------RankingLayer:tableCellAtIndex---------------------error")
    end, 1) 
    return cell;
end

-- 每帧截屏3个
function ArenaRankingView:update(dt)
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
function ArenaRankingView:getHead(sex,faceDecodeID, callfunc,idx)
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

function ArenaRankingView:exportHead(headData, callfunc)
    Avalon.WidgetUtil:getHead(self, headData ,{}, self, handler(self,function(self,pic)
        if self and not tolua.isnull(self) then
           callfunc(pic, headData.faceDecodeID)
        end
    end),true)

end


function ArenaRankingView:bindModel()

end


function ArenaRankingView:unbindModel()

end





return ArenaRankingView













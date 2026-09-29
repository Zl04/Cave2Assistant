------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveLeaderboardRankingView = class("ActivityModeCaveLeaderboardRankingView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 1026
local COM_HEIGHT = 571

function ActivityModeCaveLeaderboardRankingView:ctor(trialModelID,curFilterBigType,curFilterSmallType)
    ActivityModeCaveLeaderboardRankingView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._trialModelID = trialModelID
    self._curFilterBigType = curFilterBigType
    self._curFilterSmallType = curFilterSmallType

    self._ranklistData = nil
    self._mineRankData = nil
end

function ActivityModeCaveLeaderboardRankingView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecaveleaderboard", "ActivityModeCaveLeaderboard", false)
    ActivityModeCaveLeaderboardRankingView.super.init(self, ... )
end

function ActivityModeCaveLeaderboardRankingView:dtor()
    ActivityModeCaveLeaderboardRankingView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecaveleaderboard.ActivityModeCaveLeaderboardRankingView")
end


function ActivityModeCaveLeaderboardRankingView:onInitView()

    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    Net.NetRankSystem:requestRankCustomRankList(PublicDefine.CustomRankType.CustomRankType_TrialLand,
    self._trialModelID, self._curFilterBigType, self._curFilterSmallType, RoleDataManager:getMasterPK())

end

function ActivityModeCaveLeaderboardRankingView:updateRankView()
    self.contentLayout:removeAllChildren()

    local randText = UI.Text:create()
    randText:init(UI.TEXT_223501, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 37, g = 37, b = 37})
    randText:centerUp(95, -340)
    self.contentLayout:addChild(randText)

    local randText = UI.Text:create()
    randText:init(UI.TEXT_1212295, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 37, g = 37, b = 37})
    randText:centerUp(95, -206)
    self.contentLayout:addChild(randText)

    local randText = UI.Text:create()
    randText:init(UI.TEXT_223508, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 37, g = 37, b = 37})
    randText:centerUp(95, 7)
    self.contentLayout:addChild(randText)

    local randText = UI.Text:create()
    randText:init(UI.TEXT_223509, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 37, g = 37, b = 37})
    randText:centerUp(95, 189)
    self.contentLayout:addChild(randText)

    local randText = UI.Text:create()
    randText:init(UI.TEXT_223510, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 37, g = 37, b = 37})
    randText:centerUp(95, 309)
    self.contentLayout:addChild(randText)

    local rankingLine = UI.Image:create()
    rankingLine:init("ui_trial_ranking_line.png")
    rankingLine:centerUp(126)
    self.contentLayout:addChild(rankingLine)

    self._ranklistData = mvc.activityModeCaveLeaderboardModel:getRankListDataByIndex(self._curFilterBigType,self._curFilterSmallType)
    self._mineRankData = mvc.activityModeCaveLeaderboardModel:getMineRankDataByIndex(self._curFilterBigType,self._curFilterSmallType)

    -- print("self._ranklistData ==== ",self._ranklistData)
    -- print("self._mineRankData ==== ",self._mineRankData)

    --tableview
    local tableview = UI.TableView.new({}, 780, 330)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableview:centerBottom(110)
    tableview:setDelegate()
    -- tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init()
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 780, 72;
    end);
    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createRankCell(self._ranklistData[index])
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local desCell = cell:getChildByName("desCell")
            if desCell and tolua.isnull(desCell) then
                desCell:removeFromParent()
                desCell = nil
            end
            cell:removeFromParent()
            cell = self:createRankCell(self._ranklistData[index])
        end

        return cell;
    end);

    tableview:onUpdateCellNumbers(function ()
        return table.nums(self._ranklistData)
    end);

    tableview:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        local clickIndex = cell:getIdx() + 1

        Net.NetRankSystem:requestCustomRankHeroDetailData(PublicDefine.CustomRankType.CustomRankType_TrialLand,
            self._trialModelID, self._ranklistData[clickIndex].pk)

    end)

    self.contentLayout:addChild(tableview, 100)
    tableview:reloadData(true)
    self.tableview = tableview



    --自己的排名
    local myBgImg = UI.Image:create()
    myBgImg:init("ui_trial_paper_up.png")
    myBgImg:centerBottom(33)
    self.contentLayout:addChild(myBgImg)

    local myCell = mvc.activityModeCaveLeaderboardRankingCellView:create(self._mineRankData, true)
    -- local myCell = mvc.activityModeCaveLeaderboardRankingCellView:create(self._ranklistData[1], true)
    myCell:init()
    myCell:centerBottom(38)
    self.contentLayout:addChild(myCell, 101)
end

function ActivityModeCaveLeaderboardRankingView:createRankCell(rankData)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(780, 72))
    
    local desCell = mvc.activityModeCaveLeaderboardRankingCellView:create(rankData)
    desCell:init()
    desCell:center()
    desCell:setName("desCell")
    cell:addChild(desCell)

    return cell
end

function ActivityModeCaveLeaderboardRankingView:bindModel()

end


function ActivityModeCaveLeaderboardRankingView:unbindModel()

end





return ActivityModeCaveLeaderboardRankingView













------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveLeaderboardRankingCellView = class("ActivityModeCaveLeaderboardRankingCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_trial.plist",
    "ui_common_information.plist"
}

local COM_WIDTH = 780
local COM_HEIGHT = 72

function ActivityModeCaveLeaderboardRankingCellView:ctor(rankData, hideLine)
    ActivityModeCaveLeaderboardRankingCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._rankData = rankData
    self._hideLine = hideLine
end

function ActivityModeCaveLeaderboardRankingCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecaveleaderboard", "ActivityModeCaveLeaderboard", false)
    ActivityModeCaveLeaderboardRankingCellView.super.init(self, ... )
end

function ActivityModeCaveLeaderboardRankingCellView:dtor()
    ActivityModeCaveLeaderboardRankingCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecaveleaderboard.ActivityModeCaveLeaderboardRankingCellView")
end


function ActivityModeCaveLeaderboardRankingCellView:onInitView()
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    if not self._rankData or not self._rankData.nickName then
        return
    end

    local rankImg = ""
    if self._rankData.rank == 1 then
        rankImg = "ui_trial_ranking_cup.png"
    elseif self._rankData.rank == 2 then
        rankImg = "ui_trial_ranking_cup2.png"
    elseif self._rankData.rank == 3 then
        rankImg = "ui_trial_ranking_cup3.png"
    end

    if rankImg ~= "" then
        local rankCup = UI.Image:create()
        rankCup:init(rankImg)
        rankCup:center(-340)
        contentLayout:addChild(rankCup)
    else
        local randText = UI.Text:create()
        randText:init(tostring(self._rankData.rank), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 37, g = 37, b = 37})
        randText:center(-340)
        contentLayout:addChild(randText)
    end

    --头像
    
    local iconButton = UI.Button:create()
    iconButton:init("ui_information_headframe_bottom.png", "ui_information_headframe_bottom.png")
    iconButton:centerLeft(88)
    iconButton:setScale(0.8)
    contentLayout:addChild(iconButton)
    self._iconButton = iconButton

    local heroData = Data.HeroData:create()
    heroData:setNickName("")
    heroData:setLevel(0)
    heroData:setSex(self._rankData.sex or PublicDefine.HERO_SEX.MALE)
    heroData:setFaceDecodeID(self._rankData.faceId)

    Avalon.WidgetUtil:getHead(self, heroData, {},self,handler(self,function(self,pic)
        if self._iconButton and not tolua.isnull(self._iconButton) then
            pic:setPosition(42, 35)
            pic:setScale(0.9)
            self._iconButton:addChild(pic, 2) 
        end
    end))

    --名称
    local nameText = UI.Text:create()
    nameText:init(self._rankData.nickName, UI.SYS_FONT, UI.FONT_SIZE_18PX, {r = 37, g = 37, b = 37})
    nameText:center(-175)
    contentLayout:addChild(nameText)

    --词条
    local tableview = UI.TableView.new({}, 226, COM_HEIGHT)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    tableview:centerBottom(0,8)
    tableview:setDelegate()
    tableview:init()
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 50, 72;
    end);
    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createEffectsCell(self._rankData.data.effects[index])
            end,
            function(e)
                printError("------------------------ActivityModeCaveLeaderboardRankingCellView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local desCell = cell:getChildByName("desCell")
            if desCell and tolua.isnull(desCell) then
                desCell:removeFromParent()
                desCell = nil
            end
            cell:removeFromParent()
            cell = self:createEffectsCell(self._rankData.data.effects[index])
        end

        return cell;
    end);

    tableview:onUpdateCellNumbers(function ()
        return table.nums(self._rankData.data.effects)
    end);

    self.contentLayout:addChild(tableview, 100)
    tableview:reloadData(true)


    --得分
    local scoreText = UI.Text:create()
    scoreText:init(tostring(math.floor(self._rankData.score / 100000)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 37, g = 37, b = 37})
    scoreText:center(191)
    contentLayout:addChild(scoreText)

    --通关时长
    local timeNum = 100000 - (self._rankData.score % 100000)
    local timeStr = ToolsUtil:getTime(timeNum)
    local timeText = UI.Text:create()
    timeText:init(timeStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 37, g = 37, b = 37})
    timeText:center(310)
    contentLayout:addChild(timeText)

    --线
    if not self._hideLine then
        local lineImg = UI.Image:create()
        lineImg:init("ui_trial_ranking_line2.png")
        lineImg:centerBottom(1)
        contentLayout:addChild(lineImg)
    end

end

function ActivityModeCaveLeaderboardRankingCellView:createEffectsCell(effectID)

    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(50, 72))

    local cellLayout = UI.Layout:create();
    cellLayout:init()
    cellLayout:setSize(50, 72)
    cellLayout:center()
    cellLayout:setName("desCell")
    cell:addChild(cellLayout)

    local config = ConfigManager:getAllTrialEntryDataByID(effectID)
    local effectImg = UI.Image:create()
    effectImg:init(config.icon)
    effectImg:centerLeft(0,0)
    cellLayout:addChild(effectImg)

    print("effectID ====== ",effectID, index)

    return cell

end

function ActivityModeCaveLeaderboardRankingCellView:bindModel()

end


function ActivityModeCaveLeaderboardRankingCellView:unbindModel()

end





return ActivityModeCaveLeaderboardRankingCellView













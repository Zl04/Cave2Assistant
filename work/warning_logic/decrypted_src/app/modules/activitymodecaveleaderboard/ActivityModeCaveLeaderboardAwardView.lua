------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveLeaderboardAwardView = class("ActivityModeCaveLeaderboardAwardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 1026
local COM_HEIGHT = 571

function ActivityModeCaveLeaderboardAwardView:ctor(trialModelID,curFilterBigType,curFilterSmallType)
    ActivityModeCaveLeaderboardAwardView.super.ctor(
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

    self._rankIntervalTable = {}
    self._rankRewardTable = {}
    self._rankRewardNumTable = {}
end

function ActivityModeCaveLeaderboardAwardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecaveleaderboard", "ActivityModeCaveLeaderboard", false)
    ActivityModeCaveLeaderboardAwardView.super.init(self, ... )
end

function ActivityModeCaveLeaderboardAwardView:dtor()
    ActivityModeCaveLeaderboardAwardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecaveleaderboard.ActivityModeCaveLeaderboardAwardView")
end


function ActivityModeCaveLeaderboardAwardView:onInitView()

    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local randText = UI.Text:create()
    randText:init(UI.TEXT_223501, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 37, g = 37, b = 37})
    randText:centerUp(95,-298)
    contentLayout:addChild(randText)

    local randText = UI.Text:create()
    randText:init(UI.TEXT_223502, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 37, g = 37, b = 37})
    randText:centerUp(95,100)
    contentLayout:addChild(randText)

    local rankingLine = UI.Image:create()
    rankingLine:init("ui_trial_ranking_line.png")
    rankingLine:centerUp(126)
    contentLayout:addChild(rankingLine)



    self.trialData = ConfigManager:getAllTrialModelDataByID(self._trialModelID)
    if self.trialData then
        local rankIntervalTable = AvalonUtil:splitStr(self.trialData.rankInterval, ":")
        local rankRewardTable = AvalonUtil:splitStr(self.trialData.rankRewardId, ":")
        local rankRewardNumTable = AvalonUtil:splitStr(self.trialData.rankRewardNum, ":")
        
        local rankIntervalTB = {}
        local rankRewardTB = {}
        for i = 1, #rankIntervalTable do
            if self._curFilterSmallType == i then
                rankIntervalTB = rankIntervalTable[i]
                rankRewardTB = rankRewardTable[i]
                rankRewardNum = rankRewardNumTable[i]
                break
            end
        end

        local rankTB = AvalonUtil:splitStr(rankIntervalTB, ";")
        local rewardTB = AvalonUtil:splitStr(rankRewardTB, ";")
        local rewardNumTB = AvalonUtil:splitStr(rankRewardNum, ";")
        for k,v in ipairs(rankTB) do
            local rewardStr = rewardTB[k]
            local rewardNumStr = rewardNumTB[k]
            local rankStr = ""
            local rtb = AvalonUtil:splitStr(v, ",")
            if rtb[1] == "1" and rtb[2] == "1" then
                rankStr = "1"
            elseif rtb[1] == "2" and rtb[2] == "2" then
                rankStr = "2"
            elseif rtb[1] == "3" and rtb[2] == "3" then
                rankStr = "3"
            else
                rankStr = string.format(UI.TEXT_223507,rtb[1],rtb[2])
            end

            self._rankIntervalTable[k] = rankStr
            self._rankRewardTable[k] = rewardStr
            self._rankRewardNumTable[k] = rewardNumStr

        end


        --tableview
        local tableview = UI.TableView.new({}, 780, 370)
        tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
        tableview:centerBottom(72)
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
                    cell = self:createAwardCell(self._rankIntervalTable[index], self._rankRewardTable[index],self._rankRewardNumTable[index])
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
                cell = self:createAwardCell(self._rankIntervalTable[index], self._rankRewardTable[index],self._rankRewardNumTable[index])
            end

            return cell;
        end);

        tableview:onUpdateCellNumbers(function ()
            return table.nums(self._rankIntervalTable)
        end);

        self.contentLayout:addChild(tableview, 100)
        tableview:reloadData(true)
        self.tableview = tableview
        
    end

end

function ActivityModeCaveLeaderboardAwardView:createAwardCell(rankStr,rewardStr,rewardNum)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(780, 72))
    
    local desCell = mvc.activityModeCaveLeaderboardAwardCellView:create(rankStr, rewardStr,rewardNum)
    desCell:init()
    desCell:center()
    desCell:setName("desCell")
    cell:addChild(desCell)

    return cell
end

function ActivityModeCaveLeaderboardAwardView:bindModel()

end


function ActivityModeCaveLeaderboardAwardView:unbindModel()

end





return ActivityModeCaveLeaderboardAwardView













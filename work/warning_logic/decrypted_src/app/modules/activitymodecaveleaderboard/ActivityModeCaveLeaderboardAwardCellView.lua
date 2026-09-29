------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveLeaderboardAwardCellView = class("ActivityModeCaveLeaderboardAwardCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 780
local COM_HEIGHT = 72

function ActivityModeCaveLeaderboardAwardCellView:ctor(rankStr, rewardStr,rewardNum)
    ActivityModeCaveLeaderboardAwardCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._rankStr = rankStr
    self._rewardStr = rewardStr
    self._rewardNum = rewardNum
end

function ActivityModeCaveLeaderboardAwardCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecaveleaderboard", "ActivityModeCaveLeaderboard", false)
    ActivityModeCaveLeaderboardAwardCellView.super.init(self, ... )
end

function ActivityModeCaveLeaderboardAwardCellView:dtor()
    ActivityModeCaveLeaderboardAwardCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecaveleaderboard.ActivityModeCaveLeaderboardAwardCellView")
end


function ActivityModeCaveLeaderboardAwardCellView:onInitView()
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local rankImg = ""
    if self._rankStr == "1" then
        rankImg = "ui_trial_ranking_cup.png"
    elseif self._rankStr == "2" then
        rankImg = "ui_trial_ranking_cup2.png"
    elseif self._rankStr == "3" then
        rankImg = "ui_trial_ranking_cup3.png"
    end

    if rankImg ~= "" then
        local rankCup = UI.Image:create()
        rankCup:init(rankImg)
        rankCup:center(-297)
        contentLayout:addChild(rankCup)
    else
        local randText = UI.Text:create()
        randText:init(self._rankStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 37, g = 37, b = 37})
        randText:center(-297)
        contentLayout:addChild(randText)
    end

    --线 
    local lineImg = UI.Image:create()
    lineImg:init("ui_trial_ranking_line2.png")
    lineImg:centerBottom(1)
    contentLayout:addChild(lineImg)

    -- print("self._rewardStr ==== ",self._rewardStr)


    local awardIDList = AvalonUtil:splitStr(self._rewardStr, ",")
    local awardNumList = AvalonUtil:splitStr(self._rewardNum, ",")
    for k,v in ipairs(awardIDList) do
        local itemId = tonumber(awardIDList[k])
        local itemNum = tonumber(awardNumList[k])

        local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
        if(goodsData) then
            goodsData:setNum(itemNum)
            goodsData:setIsNew(false)

            local goodsGrid = UI.GoodsGrid:create()
            goodsGrid:init(goodsData)
            if k == 1 then
                goodsGrid:floatLeft(280)
            else
                goodsGrid:floatLeft(8)
            end
            goodsGrid:showInfoArea(true, false)
            goodsGrid:setScale(0.9)
            contentLayout:addComponent(goodsGrid)

        end
    end
end


function ActivityModeCaveLeaderboardAwardCellView:bindModel()

end


function ActivityModeCaveLeaderboardAwardCellView:unbindModel()

end





return ActivityModeCaveLeaderboardAwardCellView













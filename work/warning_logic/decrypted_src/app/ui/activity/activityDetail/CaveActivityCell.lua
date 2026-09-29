-- CaveActivityCell.lua
-- Author:zp
-- 2019年1月7日
-- Using:邮箱绑定页面

local winSize = cc.Director:getInstance():getWinSize()
local SdkBox = require("utils.sdkbox.SdkBox")
require "app.utils.PlaceholderUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local CaveActivityCell = class("CaveActivityCell", UI.HWBtnComponent)
UI.CaveActivityCell = CaveActivityCell

local scheduler = cc.Director:getInstance():getScheduler()

local DEBUG = true

local CELL_WIDTH = ACTIVITY_WIDTH

-- 资源文件
local COM_RES_LIST = {
    "ui_town_ranking.plist",
}

function CaveActivityCell:ctor()
    CaveActivityCell.super.ctor(self, UIType.ACTIVITY_DETAIL_CAVE, COM_RES_LIST, 0, 0)
    self.isDayRefresh = false
end

function CaveActivityCell:init(activityData, listView, activityPanel)
    self.activityData = activityData
    self.isDayRefresh = activityData:getIsDayRefresh()
    self._data = activityData:getCaveActivityData()
    self.listView = listView
    self.activityPanel = activityPanel
    CaveActivityCell.super.init(self)
end


function CaveActivityCell:dtor()
    CaveActivityCell.super.dtor(self)
end

function CaveActivityCell:onInitView()
    self.height = 0

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 显示标题
    local titleStr = ""
    local rankReward = self._data:getRankReward()
    local isRankType = false
    if(rankReward and #rankReward > 0) then 
        isRankType = true
        titleStr = UI.TEXT_1212078 .. ":"
    else 
        titleStr = UI.TEXT_1212079
    end

    local titleBg = UI.Layout:create()
    titleBg:init()
    titleBg:setSize(370, 33)
    titleBg:leftUp(25,10)
    self._contentLayout:addChild(titleBg)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_activity_banner_books.png")
    lineUpImage:setContentSize(370, 33)
    lineUpImage:setCapInsets(CCRectMake(159,15,1,1))
    lineUpImage:setPosition(cc.p(370/2, 33/2))
    titleBg:addChild(lineUpImage)

    local nameText = UI.Text:create()
    nameText:init(titleStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    nameText:centerLeft(4)
    titleBg:addChild(nameText)
    self.height = self.height + 33 + 18

    -- 显示详情信息
    if(isRankType) then 
        -- 获取第一个奖励的表现
        local fristRank = nil
        for _, rankData in ipairs(rankReward) do 
            if(rankData.rankStart == 1) then 
                fristRank = rankData
                break
            end
        end
        if(fristRank) then 
            local up = self.height + 48

            local rankIcon = UI.Image:create()
            rankIcon:init("ui_rankinglist_gold.png")
            rankIcon:leftUp(30, up - rankIcon:getContentSize().height/2)
            contentLayout:addChild(rankIcon)

            local rewards = fristRank.rewards
            local startRightX = 195
            local oneWidth = 78
            startRightX = startRightX + 2.5 * oneWidth - #rewards/2 * oneWidth
            for i=1,#rewards do
                if(i > 5) then 
                    break
                end
                local reward = rewards[i]
                if(reward) then
                    local goodsData = GoodsDataManager:createLocalGoodsData(reward.id)
                    if(goodsData) then
                        goodsData:setNum(reward.num)
                        goodsData:setIsNew(false)

                        local goodsGrid = UI.GoodsGrid:create()
                        goodsGrid:setTouchClipNode(self.listView)
                        goodsGrid:rightUp(startRightX + oneWidth*(i-1), up - goodsGrid:getContentSize().height/2)
                        goodsGrid:init(goodsData)
                        goodsGrid:showInfoArea(true, false)
                        contentLayout:addChild(goodsGrid)
                    end
                else
                    break
                end 
            end
            -- 右边的按钮以及显示界面
            local countStr = ""
            local titleStr = ""
            local limitNum = self._data:getLimitNum()
            local haveTrigger = true
            if(limitNum > 0) then 
                local costNum = self._data:getCostNum()
                if(self.isDayRefresh) then 
                    titleStr = UI.TEXT_1212082
                else 
                    titleStr = UI.TEXT_1212083
                end

                if(costNum >= limitNum) then 
                    haveTrigger = false
                    costNum = limitNum
                end
                countStr = string.format("%d/%d", limitNum - costNum, limitNum)
            end 
            local titleText = UI.Text:create()
            titleText:init(titleStr, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_50_50_44)
            contentLayout:addChild(titleText)

            local countText = UI.Text:create()
            countText:init(countStr, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_36_181_118)
            if(haveTrigger == false) then 
                countText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            end
            contentLayout:addChild(countText)

            -- 
            local centerX = 37 + 132/2
            local centerY = self.height
            local rightX = centerX - (countText:getContentSize().width + titleText:getContentSize().width + 4)/2
            countText:rightUp(rightX, centerY - countText:getContentSize().height/2)
            titleText:rightUp(rightX + countText:getContentSize().width + 4, centerY - countText:getContentSize().height/2)


            local jumpButton = UI.Button:create()
            jumpButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
            jumpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                if self._data:getLimitNum() <= self._data:getCostNum() then
                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111670))
                else 
                    -- 处理挑战调用
                    if TeamDataManager:getReadyState() then
                         UI.ScrollBar:createByTextID(1111556)
                    else
                        -- if(mvc.expeditionModel:getExpeditionStatus()) then
                        --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
                        --         Net.NetNPCSystem:reqStopExpedition()
                        --         UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                        --         Net.NetActivitySystem:requestMacth(self.activityData:getID())
                        --     end)
                        -- else 
                            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                            Net.NetActivitySystem:requestMacth(self.activityData:getID())
                        -- end
                    end
                end
            end)
            jumpButton:rightUp(32, up -  jumpButton:getContentSize().height/2)
            jumpButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
            jumpButton:setText(UI.TEXT_1212081)
            contentLayout:addChild(jumpButton)
            if(haveTrigger == false or not SceneManager:getInstance():isInTownOrInHome()) then 
                jumpButton:disable()
            else 
                jumpButton:enable()
            end

            self.height = self.height + 96
            local bottom = UI.Layout:create()
            bottom:init()
            bottom:setSize(630, 1)
            bottom:centerUp(self.height - 1)
            self._contentLayout:addChild(bottom)

            -- 添加分割线
            local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
            lineUpImage:setContentSize(630, 1)
            lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
            lineUpImage:setPosition(cc.p(630/2, 1))
            bottom:addChild(lineUpImage)
        end

        -- 显示更多排行按钮,显示更多排行
        local moreRankButton = UI.Button:create()
        moreRankButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
        moreRankButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            -- 处理跳转到更多界面
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_ACTIVITY_RANK_DETAIL, self.spriteID, false, self.activityPanel, rankReward)
            require "app.ui.activity.caveActivity.CaveActivityRankDetail"
            local rankDetail = UI.CaveActivityRankDetail:create(npcID)
            rankDetail:setGoBackWin(gobackWin)
            rankDetail:init(rankReward)
            rankDetail:center()
            self.activityPanel:addChild(rankDetail, 100000)
        end)
        moreRankButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
        moreRankButton:setText(UI.TEXT_1212084)
        moreRankButton:centerUp(self.height + 18)
        contentLayout:addChild(moreRankButton)

        self.height = self.height + 72
    else 

    end

    self._contentLayout:setSize(CELL_WIDTH, self.height)
    self:setSize(CELL_WIDTH, self.height)
end

function CaveActivityCell:onUpdateView()

end

function CaveActivityCell:getActivityHeight()
    return self.height
end
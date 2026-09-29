-- GuildQuestConditionPanel.lua
-- Author:zp
-- 2018年12月12日
-- Using:公会任务活动子类单个页面

local winSize = cc.Director:getInstance():getWinSize()

require "app.utils.PlaceholderUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local ProtobufUtil = require "utils.ProtobufUtil"

UI = UI or {}

local GuildQuestConditionPanel = class("GuildQuestConditionPanel", UI.HWBtnComponent)
UI.GuildQuestConditionPanel = GuildQuestConditionPanel

local DEBUG = true

local CELL_WIDTH = ACTIVITY_WIDTH

-- 资源文件
local COM_RES_LIST = {
}

local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

function GuildQuestConditionPanel:ctor()
    GuildQuestConditionPanel.super.ctor(self, UIType.ACTIVITY_DETAIL_GUILD_QUEST_CONDITION, COM_RES_LIST, 0, 0)

    self.height = 0
    self._startX = 0

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

function GuildQuestConditionPanel:init(activityData, data, lastOne, listView)
    self._activityData = activityData
    self._activityID = activityData:getID()
    self._data = data
    self._lastOne = lastOne
    if(self._lastOne == nil) then 
        self._lastOne = false
    end
    self.listView = listView
    GuildQuestConditionPanel.super.init(self)
end

function GuildQuestConditionPanel:dtor()
    GuildQuestConditionPanel.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

function GuildQuestConditionPanel:onInitView()
    self.height = 0

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    local titleStr, targetStr = self:getTitle()

    -- 标题文字
    local titleBg = UI.Layout:create()
    titleBg:init()
    titleBg:setSize(600, 33)
    titleBg:leftUp(25,10)
    self._contentLayout:addChild(titleBg)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_activity_banner_books.png")
    lineUpImage:setContentSize(600, 33)
    lineUpImage:setCapInsets(CCRectMake(159,15,1,1))
    lineUpImage:setPosition(cc.p(300, 33/2))
    titleBg:addChild(lineUpImage)

    local nameText = UI.Text:create()
    nameText:init(targetStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    nameText:centerLeft(4)
    titleBg:addChild(nameText)
    self.height = self.height + 33 + 18

    -- 显示公会进度
    local selfText = UI.Text:create()
    local guildTotalNum = self._data:getGuildTotalNum()
    local guildMaxNum = self._data:getGuildMaxNum()
    if(guildTotalNum > guildMaxNum) then
        guildTotalNum = guildMaxNum
    end

    selfText:init(LanguageManager:getInstance():getLocalString(1111488)..titleStr .. string.format("    (%d/%d)", guildTotalNum, guildMaxNum), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    selfText:leftUp(25,self.height)
    self:addChild(selfText)

    local guildProgressBg = UI.Image:create()
    guildProgressBg:init("ui_activity_banner_countdown_box.png")
    guildProgressBg:leftUp(25,self.height + 30)
    self:addChild(guildProgressBg)

    local percent = 0
    if(guildMaxNum > 0) then 
        percent = guildTotalNum*100/guildMaxNum
    end
    local  guildProgress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_activity_banner_countdown.png"))
    guildProgress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    guildProgress:setMidpoint(cc.p(0, 0))
    guildProgress:setBarChangeRate(cc.p(1, 0))
    guildProgress:setPercentage(percent)
    guildProgress:setPosition(1 + 435/2, 5.5)
    guildProgressBg:addChild(guildProgress)
    
    self.height = self.height + 60

    -- 显示个人进度
    local selfText = UI.Text:create()
    local totalNum = self._data:getTotalNum()
    local maxNum = self._data:getMaxNum()
    if(totalNum > maxNum) then
        totalNum = maxNum
    end
    selfText:init(LanguageManager:getInstance():getLocalString(1111489)..titleStr .. string.format("    (%d/%d)", totalNum, maxNum), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    selfText:leftUp(25,self.height)
    self:addChild(selfText)

    local progressBg = UI.Image:create()
    progressBg:init("ui_activity_banner_countdown_box.png")
    progressBg:leftUp(25,self.height + 30)
    self:addChild(progressBg)

    local percent = 0
    if(maxNum~=0) then 
        percent = totalNum*100/maxNum
    end
    local  progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_activity_banner_countdown.png"))
    progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    progress:setMidpoint(cc.p(0, 0))
    progress:setBarChangeRate(cc.p(1, 0))
    progress:setPercentage(percent)
    progress:setPosition(1+ 435/2, 5.5)
    progressBg:addChild(progress)

    self.height = self.height + 60

    local start = self.height
    local rewards = self._data:getRewards()
    if(rewards) then
        local index = 1
        for i=1,#rewards do 
            if(rewards[index]) then
                for i=1,4 do
                    if(rewards[index]) then
                        local rewardPanel = self:createOneRewardPanel(rewards[index])
                        if(rewardPanel) then
                            rewardPanel:leftUp((i-1)*80 + 25, self.height)
                            self._contentLayout:addChild(rewardPanel)
                        end
                        index = index + 1
                    else
                        break
                    end 
                end

                self.height = self.height + 80
            end 
        end
    end

    self._contentLayout:setSize(CELL_WIDTH, self.height)
    self:setSize(CELL_WIDTH, self.height)

    -- 添加跳转页面
    self:refreshJumpButton(start + 75/2)
    self._startX = start + 75/2

    local bottom = UI.Layout:create()
    bottom:init()
    bottom:setSize(630, 1)
    bottom:centerUp(self.height - 1)
    self._contentLayout:addChild(bottom)

    if(self._lastOne == false) then
        local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        lineUpImage:setContentSize(630, 1)
        lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
        lineUpImage:setPosition(cc.p(630/2, 1))
        bottom:addChild(lineUpImage)
    end
end

function GuildQuestConditionPanel:getQuestConditionHeight()
    return self.height
end

function GuildQuestConditionPanel:refreshJumpButton(startCenter)
    if(self._rightLayout) then
        self._rightLayout:removeFromParent(true)
        self._rightLayout = nil
    end

    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:rightUp(0, startCenter)
    self._contentLayout:addChild(rightLayout)
    self._rightLayout = rightLayout

    if(self._data:getIsReceive()) then
        local bg = UI.Image:create()
        bg:init("ui_information_banner_receive.png")
        bg:centerRight(30)
        rightLayout:addChild(bg)

        local completeText = UI.Text:create()
        completeText:init(UI.TEXT_1110721, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
        completeText:center()
        completeText:setRotationSkewX(-9.0)
        completeText:setRotationSkewY(-9.0)
        bg:addChild(completeText)
    elseif(self._data:getIsComplete()) then
        -- 已经完成，可以领取奖励
        -- 判断是否为洞穴内，如果为洞穴内就显示盖章的可领取
        if(not SceneManager:getInstance():isInTownOrInHome()) then
            local bg = UI.Image:create()
            bg:init("ui_information_banner_receive.png")
            bg:centerRight(30)
            -- bg:rightUp(30, startCenter- bg:getContentSize().height/2)
            rightLayout:addChild(bg)

            local completeText = UI.Text:create()
            completeText:init(UI.TEXT_1170937, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
            -- completeText:setFontSize(24)
            -- completeText:setFontColor(UI.FONT_COLOR_122_142_53)
            completeText:center()
            completeText:setRotationSkewX(-9.0)
            completeText:setRotationSkewY(-9.0)
            bg:addChild(completeText)
        else 
            local jumpButton = UI.Button:create()
            jumpButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
            jumpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                -- 请求领取奖励
                -- 判断背包是否已经满
                local goodsArr = {}
                local rewards = self._data:getRewards()
                if(rewards) then
                    for i=1,#rewards do 
                        local reward = rewards[i]
                        if(reward) then
                            local data = {}
                            data.goodsID = reward.id
                            data.num = reward.num
                            data.isGolden = true
                            table.insert(goodsArr, data)
                        end
                    end
                end

                if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) == false) then 
                    UI.ScrollBar:createByTextID(1110793)
                    return
                else 
                    if (RoleBehaviorManager:activityRewardCheck()) then 
                        Net.NetActivitySystem:requestActivityReward(self._activityID, self._data:getID())
                        Avalon.AudioManager:playSound("1509")
                        jumpButton:disable()
                    end 
                end
            end)

            local text = UI.Text:create()
            text:init(LanguageManager:getInstance():getLocalString(1110165), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
            text:center()
            jumpButton:addChild(text,10)
            jumpButton:centerRight(30)
            rightLayout:addChild(jumpButton)

            local key = self._activityID..":"..self._data:getID()

            local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.ACTIVITY_REWARD)
            if(repeatData and repeatData[key]) then
                jumpButton:disable()
            end
        end 
    else 
        local jumpStr = self._data:getJumpStr()
        if(jumpStr and jumpStr ~= "") then
            local jumpButton = UI.Button:create()
            jumpButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
            jumpButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                -- 根据条件来判断如何处理该逻辑
                GameManager:openUrl(jumpStr)
            end)

            local text = UI.Text:create()
            text:init(LanguageManager:getInstance():getLocalString(1110941), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
            text:center()
            jumpButton:addChild(text,10)
            jumpButton:centerRight(30)
            -- jumpButton:rightUp(30, startCenter- jumpButton:getContentSize().height/2)
            rightLayout:addChild(jumpButton)
        else
            local bg = UI.Image:create()
            bg:init("ui_information_banner_unfinished1.png")
            bg:centerRight(30)
            rightLayout:addChild(bg)
    
            local completeText = UI.Text:create()
            completeText:init(UI.TEXT_111022, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
            completeText:center()
            completeText:setRotationSkewX(-9.0)
            completeText:setRotationSkewY(-9.0)
            bg:addChild(completeText)
        end 
    end 
end

function GuildQuestConditionPanel:rewardResult(data)
    if(tolua.isnull(self)) then
        return
    end
    -- print("GuildQuestConditionPanel:rewardResult", data, self._data:getID())
    if(self._data:getID() == data.subId) then
        if(data.result == "ActivityRewardResult_Succeed") then 
            -- Avalon.AudioManager:playSound("1509") --音效改为在点击过后立马播放
        else 
            GameErrorManager:showError(ProtobufUtil:enum_id("ActivitySystem.ActivityRewardResultType", data.result))
        end
        -- print("GuildQuestConditionPanel:rewardResult handle")
        self:refreshJumpButton(self._startX)
    end 
end

function GuildQuestConditionPanel:createOneRewardPanel(reward)
    if(reward) then
        local goodsData = GoodsDataManager:createLocalGoodsData(reward.id)
        if(goodsData) then
            goodsData:setNum(reward.num)
            goodsData:setIsNew(false)

            local goodsGrid = UI.GoodsGrid:create()
            goodsGrid:setTouchClipNode(self.listView)
            goodsGrid:centerUp(0)
            goodsGrid:init(goodsData)
            
            goodsGrid:showInfoArea(true, false)

            return goodsGrid
        end
    end

    return nil 
end

function GuildQuestConditionPanel:getTitle()

    return AvalonUtil:getQuestConditionTitle(self._data)
end
-- QuestConditionPanel.lua
-- Author:zp
-- 2017年12月22日
-- Using:任务活动子类单个页面

local winSize = cc.Director:getInstance():getWinSize()

require "app.utils.PlaceholderUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local ProtobufUtil = require "utils.ProtobufUtil"

UI = UI or {}

local QuestConditionPanel = class("QuestConditionPanel", UI.HWBtnComponent)
UI.QuestConditionPanel = QuestConditionPanel

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

function QuestConditionPanel:ctor()
    QuestConditionPanel.super.ctor(self, UIType.ACTIVITY_DETAIL_QUEST_CONDITION, COM_RES_LIST, 0, 0)

    self.height = 0
    self._startX = 0

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

function QuestConditionPanel:init(activityData, data, lastOne, listView)
    self._activityData = activityData
    self._activityID = activityData:getID()
    self._data = data
    self._lastOne = lastOne
    if(self._lastOne == nil) then 
        self._lastOne = false
    end
    self.listView = listView
    QuestConditionPanel.super.init(self)
end

function QuestConditionPanel:dtor()
    QuestConditionPanel.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

function QuestConditionPanel:onInitView()
    self.height = 0

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

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
    local totalNum = self._data:getTotalNum()
    if(totalNum > self._data:getMaxNum()) then
        totalNum = self._data:getMaxNum()
    end

    local titleStr = self:getTitle() 
    local showMaxNum = self._data:getMaxNum()
    if(self._data:getType() ~= PublicDefine.QuestConditionType.QuestConditionType_Version) then 
        if self._data:getType() == PublicDefine.QuestConditionType.QuestConditionType_CashRecharge then
            totalNum = totalNum/100
            showMaxNum = showMaxNum/100
            titleStr = titleStr.. string.format(UI.TEXT_224900, totalNum, showMaxNum)
        elseif self._data:getType() == PublicDefine.QuestConditionType.QuestConditionType_LoginOut and self._data.targetID == 3 then
            local startTime = self._data.startTime --- GameManager:get_timezone_offset()
            local endTime = self._data.endTime --- GameManager:get_timezone_offset()
            -- startTime = startTime > 0 and startTime or startTime + 86400
            -- endTime = endTime > 0 and endTime or endTime + 86400
            -- local startDate = os.date("%H:%M", startTime);
            -- local endDate = os.date("%H:%M", endTime);
            local timeStr = self:getDisplayTimeString(startTime, endTime)
            titleStr = titleStr.. timeStr--string.format("    (%s-%s)", startDate, endDate)
        else
            titleStr = titleStr.. string.format("    (%d/%d)", totalNum, showMaxNum)
        end    
    end 
    nameText:init(titleStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    nameText:centerLeft(4)
    titleBg:addChild(nameText)
    self.height = self.height + 33 + 18
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

-- 获取服务器到下次
function QuestConditionPanel:getOffsetTimeToNextTimeInDay(timeInDayInSeconds)
    local timeNow = GameManager:getNormalServerTime()
    local timeNowInDay = timeNow % SECONDS_ONE_DAY
    -- 从一天中的时间获得下一次距离到达目标时间点的时间差
	local deltaToTarget = timeInDayInSeconds - timeNowInDay
	-- 如果还未到目标时间就选取今天的目标时间, 如果已经过了目标时间就选取明天的目标时间
	local deltaToTargetNext = deltaToTarget > 0 and deltaToTarget or deltaToTarget + SECONDS_ONE_DAY
	return deltaToTargetNext
end

-- 获取显示时间
function QuestConditionPanel:getDisplayTimeString(startTime, endTime)
    if (not startTime) then return "" end

    -- 获取本地时间
    local localDate = os.date("*t", os.time())
    local localTime = localDate.hour * 3600 + localDate.min * 60 + localDate.sec

    -- 拼装展示本地时间
    local timeString = ""
    local count = 0
    -- local endTime = self._data.endArr[i]
    if (startTime and endTime) then
        -- 计算开始时间
        local offsetOpenTime = self:getOffsetTimeToNextTimeInDay(startTime)
        local localOpenTime = (localTime + offsetOpenTime) % SECONDS_ONE_DAY
        local openHour = math.floor(localOpenTime / 3600)
        local openMin = math.round(localOpenTime % 3600 / 60)
        if (openMin >= 60) then
            openMin = openMin - 60
            openHour = openHour + 1
        end
        local openString = tostring(openHour) .. ":" .. (math.floor(openMin / 10) == 0 and string.format("0%s", openMin) or tostring(openMin))

        -- 计算结束时间
        local offsetEndTime = self:getOffsetTimeToNextTimeInDay(endTime)
        local localEndTime = (localTime + offsetEndTime) % SECONDS_ONE_DAY
        local endHour = math.floor(localEndTime / 3600)
        local endMin = math.round(localEndTime % 3600 / 60)
        if (endMin >= 60) then
            endMin = endMin - 60
            endHour = endHour + 1
        end
        local endString = tostring(endHour) .. ":" .. (math.floor(endMin / 10) == 0 and string.format("0%s", endMin) or tostring(endMin))
        timeString = timeString .. openString .. "-" .. endString
    end
    
    return timeString
end

function QuestConditionPanel:getQuestConditionHeight()
    return self.height
end

function QuestConditionPanel:refreshJumpButton(startCenter)
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
                if (self._data and self._data:getType() == PublicDefine.QuestConditionType.QuestConditionType_Version) then 
                    cc.Application:getInstance():openURL(jumpStr)
                else 
                    -- 根据条件来判断如何处理该逻辑
                    GameManager:openUrl(jumpStr)
                end
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

function QuestConditionPanel:rewardResult(data)
    if(tolua.isnull(self)) then
        return
    end
    -- print("QuestConditionPanel:rewardResult", data, self._data:getID())
    if(self._data:getID() == data.subId) then
        if(data.result == "ActivityRewardResult_Succeed") then 
            -- Avalon.AudioManager:playSound("1509") --音效改为在点击过后立马播放
        else 
            GameErrorManager:showError(ProtobufUtil:enum_id("ActivitySystem.ActivityRewardResultType", data.result))
        end
        -- print("QuestConditionPanel:rewardResult handle")
        self:refreshJumpButton(self._startX)
    end 
end

function QuestConditionPanel:createOneRewardPanel(reward)
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

function QuestConditionPanel:getTitle()
    return AvalonUtil:getQuestConditionTitle(self._data)
end
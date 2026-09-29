-- ActivityDetailNode.lua
-- Author:zp
-- 2017年12月22日
-- Using:用于显示活动相关的信息

local winSize = cc.Director:getInstance():getWinSize()

require "app.utils.PlaceholderUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local BG_BIG = "ui_activity_banner_no_found_big.png"
local BG_LITTLE = "ui_activity_banner_no_found_little.png"

local ActivityDetailNode = class("ActivityDetailNode", UI.HWBtnComponent)
UI.ActivityDetailNode = ActivityDetailNode

local DEBUG = true

local CELL_WIDTH = ACTIVITY_WIDTH
local titleOffsetX = 29-16

-- 资源文件
local COM_RES_LIST = {
    "ui_town_activity.plist"
}

local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

function ActivityDetailNode:ctor()
    ActivityDetailNode.super.ctor(self, UIType.ACTIVTIY_DETAIL_EXTRA_DROP, COM_RES_LIST, 0, 0)
    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.refreshTime), 60, false)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

function ActivityDetailNode:init(data)
    self._data = data
    -- self:setInterceptTouches(true)
    -- self:setTouchEnable(true)

    ActivityDetailNode.super.init(self)
end


function ActivityDetailNode:dtor()
    ActivityDetailNode.super.dtor(self)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REWARD_RESULT, self, self.rewardResult)
end

function ActivityDetailNode:onInitView()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    if(self._data.imgType == 0) then 
        contentLayout:setSize(ACTIVITY_WIDTH, ACTIVITY_LITTLE_HEIGHT)
        self:setSize(ACTIVITY_WIDTH, ACTIVITY_LITTLE_HEIGHT)
    else 
        contentLayout:setSize(ACTIVITY_WIDTH, ACTIVITY_BIG_HEIGHT)
        self:setSize(ACTIVITY_WIDTH, ACTIVITY_BIG_HEIGHT)
    end 
    -- contentLayout:leftBottom(0, 0)
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 计算大小
    local bgSpriteName = BG_BIG
    if(self._data.imgType == 0) then 
        bgSpriteName = BG_LITTLE
    end

    -- 背景
    -- local bg = UI.Image:create()
    -- bg:init(bgSpriteName)
    -- bg:center()
    -- self._contentLayout:addChild(bg)

    -- 活动图片
    local activtyImage = UI.Image:create()
    -- if(self._data.imgType == 0) then 
    --     activtyImage = UI.Image:create(ACTIVITY_WIDTH, ACTIVITY_LITTLE_HEIGHT)
    -- else 
    --     activtyImage = UI.Image:create(ACTIVITY_WIDTH, ACTIVITY_BIG_HEIGHT)
    -- end
    activtyImage:init(bgSpriteName)
    activtyImage:center()

    self._contentLayout:addChild(activtyImage)
    -- print("ActivityDetailNode", self._data:getImageName(), self._data.imgType)
    if(self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
        if(not tolua.isnull(activtyImage)) then
            activtyImage:setTexture(self._data:getImageName())
        end
    elseif(self._data:getType() == 0) then
        -- 世界boss入口的特殊处理
        if(not tolua.isnull(activtyImage)) then
            activtyImage:setSpriteName(self._data:getImageName())
        end
    else 
        ImageDownLoadUtil:downLoadImage(self._data:getImageName(), activtyImage, function(imgName, localUrl)
            if(not tolua.isnull(activtyImage) and localUrl and localUrl ~= "") then
                activtyImage:setTexture(localUrl)
            end
        end)
    end
    self._activityImage = activtyImage

    -- 透明底板
    local showBg = UI.Image:create()
    showBg:init("ui_activity_banner_black.png")
    showBg:leftBottom(5,5)
    self._contentLayout:addChild(showBg)

    -- 活动名字
    local nameText = nil
    if(self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
        nameText = UI.Text:create()
        nameText:init(self._data:getName(), UI.FONT_BOLD, UI.FONT_SIZE_28PX, {r = 250, g = 250, b = 250})
    elseif(self._data:getType() == 0) then
        -- 世界boss入口的特殊处理
        nameText = UI.Text:create()
        nameText:init(self._data:getName(), UI.FONT_BOLD, UI.FONT_SIZE_28PX, {r = 250, g = 250, b = 250})
    else 
        if self._data:getName() then
            nameText = UI.RichText:create()
            nameText:initForNetJson(self._data:getName(), 400, 20)
        end
    end

    if(nameText) then
        nameText:leftUp(titleOffsetX,3)
        showBg:addChild(nameText)
        self._nameText = nameText
    end

    -- 活动状态
    local stausText = UI.Text:create()
    stausText:init("", UI.FONT_ARIAL, UI.FONT_SIZE_18PX)
    stausText:leftBottom(titleOffsetX,3)
    showBg:addChild(stausText)
    self._statusText = stausText

    -- 活动标签
    local activityLabelImage = UI.Image:create()
    activityLabelImage:init("ui_information_banner_new2.png")
    activityLabelImage:rightUp(3,5)
    activityLabelImage:hide()
    self._contentLayout:addChild(activityLabelImage)
    self._activityLabelImage = activityLabelImage

    -- 显示是否为每日刷新
    local dayRefreshText = UI.Text:create()
    dayRefreshText:init(UI.TEXT_1213304, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 215, g = 129, b = 34})
    dayRefreshText:rightBottom(3,3)
    self._contentLayout:addChild(dayRefreshText)
    self._dayRefreshText = dayRefreshText
    dayRefreshText:setVisible(false)

    self:refreshDayRefreshText()
    self:refreshLabelImage()
end

function ActivityDetailNode:refreshDayRefreshText()
    if self._data and self._dayRefreshText 
        and self._data.getIsDayRefresh
        and self._data:getIsDayRefresh() 
        and self._data:getType() ~= PublicDefine.ActivityType.ActivityType_Festival then 
        self._dayRefreshText:setVisible(true)
    else
        if self._dayRefreshText then 
            self._dayRefreshText:setVisible(false)
        end
    end
end

function ActivityDetailNode:onUpdateView(data)
    if(data) then
        self._data = data
        self:refreshDayRefreshText()

        local bgSpriteName = BG_BIG
        if(self._data.imgType == 0) then 
            self._contentLayout:setSize(ACTIVITY_WIDTH, ACTIVITY_LITTLE_HEIGHT)
            bgSpriteName = BG_LITTLE
        else 
            self._contentLayout:setSize(ACTIVITY_WIDTH, ACTIVITY_BIG_HEIGHT)
        end 

        -- 刷新名字
        if(self._nameText) then
            local parent = self._nameText:getParent()
            self._nameText:removeFromParent()
            self._nameText = nil

            if(parent) then
                local nameText = UI.RichText:create()
                if(self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
                    nameText = UI.Text:create()
                    nameText:init(self._data:getName(), UI.FONT_BOLD, UI.FONT_SIZE_28PX, {r = 250, g = 250, b = 250})
                else 
                    nameText = UI.RichText:create()
                    nameText:initForNetJson(self._data:getName(), 400, 20)
                end
                nameText:leftBottom(titleOffsetX,35)
                parent:addChild(nameText)
                self._nameText = nameText
            end 
        end

        if(self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
            self._activityImage:setTexture(self._data:getImageName())
        else 
            self._activityImage:setTexture(bgSpriteName)
            ImageDownLoadUtil:downLoadImage(self._data:getImageName(), self._activityImage, function(imgName, localUrl)
                self._activityImage:setTexture(localUrl)
            end)
        end

        -- 刷新右上角的标志
        self:refreshLabelImage()
    end
    self:refreshTime()
end

function ActivityDetailNode:rewardResult(data)
    if(tolua.isnull(self)) or self._data == nil or (not self._data.getID) then
        return
    end
    if(self._data:getID() ~= data.id) then
        return
    end
    
    self:refreshLabelImage()
end

-- 刷新标签
function ActivityDetailNode:refreshLabelImage()
    if(self._data and self._activityLabelImage) then
        self._activityLabelImage:show()
        if(self._data:getIsHaveAward()) then
            self._activityLabelImage:setSpriteName("ui_information_banner_complete.png")
        elseif (self._data:getIsNew()) then
            self._activityLabelImage:setSpriteName("ui_information_banner_new2.png")
        elseif (self._data:getIsHot()) then
            self._activityLabelImage:setSpriteName("ui_information_banner_hot.png")
        else
            self._activityLabelImage:hide()
        end
    end
end

function ActivityDetailNode:refreshTime(dt)
    if(self._statusText and not tolua.isnull(self._statusText)) then
        local serverTime = GameManager:getNormalServerTime()
        local getTime = true
        local text = ""
        local color = UI.FONT_COLOR_69_162_227

        local status = self._data:getStatus()
        if(status == PublicDefine.ActivityRunningStat.ActivityRunningStat_Waiting) then
            --等待中

        elseif(status == PublicDefine.ActivityRunningStat.ActivityRunningStat_Showing) then
            --展示
            -- 即将开始
            text = string.format(LanguageManager:getInstance():getLocalString(1110936).."%s", self:calculationTime(self._data.startTime))
            color = UI.FONT_COLOR_69_162_227
        elseif (status == PublicDefine.ActivityRunningStat.ActivityRunningStat_Running) then
            color = UI.FONT_COLOR_69_227_154
            -- 进行中
            if(self._data:getType() == PublicDefine.ActivityType.ActivityType_MailBind) then 
                text = ""
            elseif(self._data:getType() == 0) then
                -- 世界boss入口的特殊处理
                local stateBox = mvc.worldBossModel:getStateBox()
                if stateBox.stateType == 2 or stateBox.stateType == 4 then
                    -- 即将开始
                    local showStr = string.format("00:%02d", math.modf(stateBox.countDown/SECONDS_ONE_MINUTES))
                    text = string.format(LanguageManager:getInstance():getLocalString(1110936).."%s", showStr)
                    color = UI.FONT_COLOR_69_162_227
                else
                    local stateData = mvc.worldBossModel:getStateData()
                    if not stateData.isApplying and not stateData.isFighting then
                        -- 结束了
                        text = string.format(LanguageManager:getInstance():getLocalString(1110939))
                        color = UI.FONT_COLOR_254_216_0
                    else
                        -- 进行中
                        local showStr = string.format("00:%02d", math.modf(stateBox.nextTime/SECONDS_ONE_MINUTES))
                        text = string.format(LanguageManager:getInstance():getLocalString(1110937).."%s", showStr)
                    end
                end
            else
                text = string.format(LanguageManager:getInstance():getLocalString(1110937).."%s", self:calculationTime(self._data.endTime))
            end
        elseif (status == PublicDefine.ActivityRunningStat.ActivityRunningStat_Ending) then
            -- 即将结束
            --结束
            text = string.format(LanguageManager:getInstance():getLocalString(1110939))
            -- color = UI.FONT_COLOR_51_51_51
            color = UI.FONT_COLOR_254_216_0
        else
            text = LanguageManager:getInstance():getLocalString(1110939)
        end

        self._statusText:setText(text)
        self._statusText:setFontColor(color)
    end
end

function ActivityDetailNode:calculationTime(time)
    local mode1 = "%s"
    local mode2 = "%d:%d:%d"

    local curTime = GameManager:getNowServerTime()
    local waitingTime = time + GameManager:getEPOCHTime() - curTime

    local str = ""
    if(waitingTime > 0) then
        local day = math.modf(waitingTime / SECONDS_ONE_DAY)
        waitingTime = waitingTime % SECONDS_ONE_DAY
        local hour = math.modf(waitingTime / SECONDS_ONE_HOUR)
        waitingTime = waitingTime % SECONDS_ONE_HOUR
        local minute = math.modf(waitingTime/SECONDS_ONE_MINUTES)
        waitingTime = waitingTime % SECONDS_ONE_MINUTES
        local second = waitingTime
        if day > 0 then
            if(day > 365) then
                day = "365+"
            end 
            return tostring(day)..UI.TEXT_1170921
        else
            if(hour>=10) then
                str = str..tostring(hour)
            else 
                str = str.."0"..tostring(hour)
            end 

            if(minute>=10) then
                str = str..":"..tostring(minute)
            else 
                str = str..":".."0"..tostring(minute)
            end 

            if(second>=10) then
                str = str..":"..tostring(second)
            else 
                str = str..":".."0"..tostring(second)
            end 
        end
    else 
        str = "00:00:00"
    end

    return str
end


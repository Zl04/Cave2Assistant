-- ActivityPointCell.lua
-- Author:CMonk
-- 2019年06月26日

require "app.ui.common.Text"
require "utils.AvalonUtil"

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local ActivityPointCell = class("ActivityPointCell", UI.TableViewCell)
UI.ActivityPointCell = ActivityPointCell

ActivityPointCell.CELL_WIDTH = 813
ActivityPointCell.CELL_HEIGHT = 116

local SECONDS_ONE_DAY = 24 * 3600

function ActivityPointCell:updateOncePerSecond()

end

function ActivityPointCell:ctor(parentTable)
    ActivityPointCell.super.ctor(self)

    self._parentTable = parentTable
    self:onInitView()

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateOncePerSecond), 1, false)
end

function ActivityPointCell:dtor()
    ActivityPointCell.super.dtor(self)

    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function ActivityPointCell:onInitView()
    -- 内容运载层
    self._rootLayer = UI.Layout:create()
    self._rootLayer:init()
    self._rootLayer:setSize(UI.ActivityPointCell.CELL_WIDTH, UI.ActivityPointCell.CELL_HEIGHT)
    self._rootLayer:leftBottom(0, 0)
    self:addChild(self._rootLayer)

    -- 整体背景
    local cellBg  = UI.Image:create()
    cellBg:init("ui_daily_banner.png")
    cellBg:leftBottom(0, 0)
    self._rootLayer:addChild(cellBg)

    -- 标题图标
    self._icon  = UI.Image:create()
    self._icon:init("ui_daily_icon_abyss.png")
    self._icon:center(-347, 0)
    cellBg:addChild(self._icon)
    
    -- 标题
    self._title = UI.Text:create()
	self._title:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 187, g = 181, b = 175})
	self._title:leftBottom(121, 65)
    cellBg:addChild(self._title)

    -- 描述
    self._desc = UI.Text:create()
	self._desc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 87, g = 68, b = 63})
    self._desc:leftUp(121, 50)
    self._desc:setWidth(350)
    self._desc:autoAdapt()
    cellBg:addChild(self._desc)

    -- 次数标签
    local numLabel = UI.Text:create()
	numLabel:init(LanguageManager:getInstance():getLocalString(1112427)--[["次数"]], UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 77, g = 71, b = 70})
	numLabel:rightBottom(244, 61)
    cellBg:addChild(numLabel)

    -- 次数
    self._num = UI.Text:create()
	self._num:init(LanguageManager:getInstance():getLocalString(1112429) --[["不限"]], UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 17, g = 112, b = 39})
	self._num:leftBottom(586, 61)
    cellBg:addChild(self._num)

    -- 开启时间
    self._openTime = UI.Text:create()
    self._openTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 57, g = 52, b = 51})
    self._openTime:setLineSpacing(-7)
	self._openTime:center(332, -35)
    cellBg:addChild(self._openTime)

    -- 活跃数标签
    local activityPointLabel = UI.Text:create()
	activityPointLabel:init(LanguageManager:getInstance():getLocalString(1112430) --[["活跃"]], UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 77, g = 71, b = 70})
	activityPointLabel:rightBottom(244, 26)
    cellBg:addChild(activityPointLabel)

    -- 活跃数
    self._activityPoint = UI.Text:create()
	self._activityPoint:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 17, g = 112, b = 39})
	self._activityPoint:leftBottom(586, 26)
    cellBg:addChild(self._activityPoint)
    
    -- 前往按钮
    self._goButton = UI.Button:create()
    self._goButton:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    self._goButton:centerRight(20)
    self._goButton:setText(LanguageManager:getInstance():getLocalString(1111614)) --"前往"
    self._goButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 87, g = 68, b = 63})
    self._goButton:setTouchClipNode(self._parentTable)
    self._goButton:setInterval(1)
    cellBg:addChild(self._goButton)
    self._goButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (self._clickCB) then self._clickCB() end
    end)
end

-- 获取服务器到下次
function ActivityPointCell:getOffsetTimeToNextTimeInDay(timeInDayInSeconds)
    local timeNow = GameManager:getNormalServerTime()
    local timeNowInDay = timeNow % SECONDS_ONE_DAY
    -- 从一天中的时间获得下一次距离到达目标时间点的时间差
	local deltaToTarget = timeInDayInSeconds - timeNowInDay
	-- 如果还未到目标时间就选取今天的目标时间, 如果已经过了目标时间就选取明天的目标时间
	local deltaToTargetNext = deltaToTarget > 0 and deltaToTarget or deltaToTarget + SECONDS_ONE_DAY
	return deltaToTargetNext
end

-- 获取显示时间
function ActivityPointCell:getDisplayTimeString()
    if (not self._data) then return "" end

    -- 获取本地时间
    local localDate = os.date("*t", os.time())
    local localTime = localDate.hour * 3600 + localDate.min * 60 + localDate.sec

    -- 拼装展示本地时间
    local timeString = ""
    local count = 0
    for i,openTime in ipairs(self._data.openArr) do
        local endTime = self._data.endArr[i]
        if (openTime and endTime) then
            count = count + 1
            if (count ~= 1) then timeString = timeString .. "\n" end

            -- 计算开始时间
            local offsetOpenTime = self:getOffsetTimeToNextTimeInDay(openTime)
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
    end
    return timeString
end

-- 检查是否在可用时间以内
function ActivityPointCell:isInTimeLimit()
    if (not self._data) then return false end
    if (self._data.limittime ~= 1 or 
        not self._data.openArr or 
        #self._data.openArr == 0 or 
        not self._data.endArr or
        #self._data.endArr == 0) 
    then 
        return true
    end
    
    local isInLimit = true
    for i,v in ipairs(self._data.openArr) do
        local openTime = v
        local closeTime = self._data.endArr[i]
        if (openTime and closeTime) then
            local timeNow = GameManager:getNormalServerTime()
            local timeInDay = timeNow % 24 * 3600
            if (timeInDay < openTime or timeInDay > closeTime) then
                isInLimit = false
                break
            end
        end
    end
    return isInLimit
end








-------------SevenDayLayer 接口--------------
function ActivityPointCell:reset()
    self._clickCB = nil
    self._data = nil
end

function ActivityPointCell:setClickCallback(cb)
    self._clickCB = cb
end

function ActivityPointCell:updateData(data)
    self._data = data

    if (self._data) then
        -- 图标
        if (data.icon and data.icon ~= "") then
            self._icon:show()
            self._icon:setSpriteName(data.icon)
        else
            self._icon:hide()
        end

        -- 名字
        if (data.name) then
            self._title:show()
            self._title:setText(LanguageManager:getInstance():getLocalString(data.name))
        else
            self._title:hide()
        end

        -- 解释
        if (data.desc) then
            self._desc:show()
            self._desc:setText(LanguageManager:getInstance():getLocalString(data.desc))
        else
            self._desc:hide()
        end

        -- 次数
        if (data.rewardtimes and data.rewardtimes > 0) then
            self._num:setText(string.format("%s/%s", data.actNum, data.rewardtimes))
        else
            self._num:setText(LanguageManager:getInstance():getLocalString(1112429)) --"不限"
        end

        -- 活跃
        local activityPointNum = 0
        if (data.activityPointNum) then
            activityPointNum = data.activityPointNum > data.activityPointLimit and data.activityPointLimit or data.activityPointNum
        end 
        self._activityPoint:setText(string.format("%s/%s", activityPointNum, data.activityPointLimit))

        -- 开启关闭时间
        if (data.limittime and data.limittime == 1) then
            self._openTime:show()
            self._openTime:setText(self:getDisplayTimeString())
        else
            self._openTime:hide()
        end

        -- 按钮更新
        if (data.isUnlocked) then
            if (data.rewardtimes) then
                if (data.limittime == 1) then
                    local isInTimeFrame, notRunningType = mvc.activityPointModel:isInTimeLimit(data)
                    if (isInTimeFrame) then
                        self._goButton:enable()
                        self._goButton:setText(LanguageManager:getInstance():getLocalString(1111614)) --"前往"
                    elseif (notRunningType == mvc.activityPointModel.NOT_RUNNING_TYPE.BEFORE) then
                        self._goButton:setText(LanguageManager:getInstance():getLocalString(1112431)) --"未开始"
                        self._goButton:disable()
                    elseif (notRunningType == mvc.activityPointModel.NOT_RUNNING_TYPE.AFTER) then
                        self._goButton:setText(LanguageManager:getInstance():getLocalString(1110939)) --"已结束"
                        self._goButton:disable()
                    else
                        self._goButton:enable()
                        self._goButton:setText(LanguageManager:getInstance():getLocalString(1111614)) --"前往"
                    end
                else
                    if (data.actNum < data.rewardtimes) then
                        self._goButton:enable()
                        self._goButton:setText(LanguageManager:getInstance():getLocalString(1111614)) --"前往"
                    else
                        self._goButton:setText(LanguageManager:getInstance():getLocalString(1110153)) --"已完成"
                        self._goButton:disable()
                    end
                end
            else
                self._goButton:enable()
            end
        else
            self._goButton:setText(LanguageManager:getInstance():getLocalString(1112432)) --"未解锁"
            self._goButton:disable()
        end
    end
end
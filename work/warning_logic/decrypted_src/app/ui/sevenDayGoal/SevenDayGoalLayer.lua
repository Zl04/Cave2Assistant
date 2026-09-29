-- SevenDayGoalLayer.lua
-- Author:CMonk
-- 2018年1月8日

require "app.ui.UIDefine"
require "app.ui.sevenDayGoal.SevenDayGoalCell"
require "app.ui.sevenDayGoal.SevenDayGoalTaskCell"
require "app.datas.GoalDataManager"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local SevenDayGoalLayer = class("SevenDayGoalLayer", UI.DownShowWin)
UI.SevenDayGoalLayer = SevenDayGoalLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local TIMER_STRING_FORMAT = LanguageManager:getInstance():getLocalString(1111958) --"剩余%s天"

--资源列表(必备)
local COM_RES_LIST = {
    "ui_sevendays.plist",
    "ui_common_btn.plist",
    "ui_common_information.plist",
    "ui_common_scale9image.plist"
}


function SevenDayGoalLayer:updateOncePerSecond()
    -- 更新倒计时显示
    self:updateTimerView()
    -- 检查关闭时间
    self:checkTimeAutoClose()
end

--构造函数(必备)
function SevenDayGoalLayer:ctor(npcSpriteID)
    SevenDayGoalLayer.super.ctor(
        self, 
        UIType.SEVEN_DAY,
        COM_RES_LIST,
        winSize.width,
        winSize.height
    )
    self:init()
    self:open()
    self:registerListener()

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateOncePerSecond), 1, false)
end


--虚构函数, destroy时调用(必备)
function SevenDayGoalLayer:dtor()
    SevenDayGoalLayer.super.dtor(self)
    self:unregisterListener()

    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

-- 初始化(必备)
function SevenDayGoalLayer:init()
    SevenDayGoalLayer.super.init(self)

    self:setStageByIdx(0, true)
end

-- 模版函数：初始化组建的视图(必备)
function SevenDayGoalLayer:onInitView()
    -- 运载层
    self._rootLayer = UI.Layout:create()
    self._rootLayer:init()
    self._rootLayer:setSize(winSize.width, winSize.height)
    self:addChild(self._rootLayer)

    -- 背景
    self._bg = UI.Image:create()
    self._bg:init("ui_sevendays_bg.png")
    self._bg:setTouchEnable(true)
    self._bg:setInterceptTouches(true)
    self._bg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:closeWin()
    end)
    self._bg:center()
    self._rootLayer:addChild(self._bg)

    -- 目标的任务列表
    self:initGoalActivityList()

    -- 目标列表
    self:initGoalList()

    -- 列表下部遮罩
    local mask = UI.Image:create()
    mask:init("ui_sevendays_shelter.png")
    mask:leftBottom(335, 44)
    self._bg:addChild(mask)

    -- 关闭按钮
    local closeBtn = UI.Button:create()
    closeBtn:init("ui_btn_close_0.png", "ui_btn_close_2.png", "ui_btn_close_0.png")
    closeBtn:rightUp(0, 20)
    closeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:closeWin()
    end)
    self._bg:addChild(closeBtn, 1)

    -- 倒计时排版
    self._timerLayout = UI.Layout:create()
    self._timerLayout:init()
    self._timerLayout:enableAutoWidth()
    self._timerLayout:enableAutoHeight()
    self._timerLayout:center(-377, -257)
    self._bg:addChild(self._timerLayout)

    -- 倒计时
    local clockIcon = AvalonUtil.createClockAnimation()
    clockIcon:floatLeft(0)
    self._timerLayout:addComponent(clockIcon)

    -- 倒计时文字
    self._timeText = UI.Text:create()
    self._timeText:init(TIMER_STRING_FORMAT, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_77_77_84)
    self._timeText:setAdditionalKerning(3)
    self._timeText:autoAdapt()
    self._timeText:floatLeft(0)
    self._timerLayout:addComponent(self._timeText)

    -- 入门守则标签
    local goalListLabel = UI.Text:create()
    goalListLabel:init(LanguageManager:getInstance():getLocalString(1111959) --[["入门守则"]], UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_77_77_84)
    goalListLabel:center(-377, -231)
    self._bg:addChild(goalListLabel)

    -- 指南针
    local compass = UI.Image:create()
    compass:init("ui_sevendays_compass.png")
    compass:leftBottom(930, 0)
    self._bg:addChild(compass)
end

function SevenDayGoalLayer:initGoalList()
    self._goalListView = self:getTable(
        UI.SevenDayGoalCell.CELL_WIDTH,
        458,
        UI.SevenDayGoalCell,
        function() return GoalDataManager:getStageArr(3) end,
        function(idx, comp) 
            printInfo("SevenDayGoalLayer SevenDayGoalCell", idx)
            self:setStageByIdx(idx)
        end)
    self._goalListView:leftBottom(74, 67)
    self._bg:addChild(self._goalListView)

    -- 加载数据
    self._goalListView:reload()
end

function SevenDayGoalLayer:initGoalActivityList()
    self._goalListTaskView = self:getTable(
        UI.SevenDayGoalTaskCell.CELL_WIDTH + 20,
        500,
        UI.SevenDayGoalTaskCell,
        function() return GoalDataManager:getActiveStageActivityArr(3) end,
        function(idx, comp) 
            printInfo("SevenDayGoalLayer SevenDayGoalTaskCell", idx)
            self:getReward(idx)
        end)
    self._goalListTaskView:setScrollBarEnabled(true)
    self._goalListTaskView:setCircleVisible(false)
    self._goalListTaskView:setScrollBarWidth(5)
    self._goalListTaskView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    self._goalListTaskView:leftBottom(342, 70)
    self._bg:addChild(self._goalListTaskView)

    -- 加载数据
    self._goalListTaskView:reload()
end

-- 模版函数：更新组建的视图(必备)
function SevenDayGoalLayer:onUpdateView()
    GoalDataManager:updateFinishStat()
    self._goalListView:reload()
    self._goalListTaskView:reload()
    self:updateTimerView()
end

-- 更新时间显示
function SevenDayGoalLayer:updateTimerView()
    local goalData = GoalDataManager:getGoalData(3)
    if (goalData.endTimeStamp) then
        require "app.game.GameManager"
        local timeNow = GameManager:getNormalServerTime()
        local deltaInSecond = goalData.endTimeStamp - timeNow
        local deltaInDay = math.ceil(deltaInSecond / 86400)
        if (deltaInDay < 0) then deltaInDay = 0 end
        self._timeText:setText(string.format(TIMER_STRING_FORMAT, deltaInDay))
        self._timerLayout:updateView()
    end
end

-- 根据时间自动关闭
function SevenDayGoalLayer:checkTimeAutoClose()
    local goalData = GoalDataManager:getGoalData(3)
    if (goalData.closeTimeStamp) then
        require "app.game.GameManager"
        local timeNow = GameManager:getNormalServerTime()
        if (timeNow > goalData.closeTimeStamp) then
            self:closeWin()
        end
    end
end

-- 一个公用的Table创建工具
function SevenDayGoalLayer:getTable(listWidth, listHeight, cellTemplate, dataArrFunc, cb)
    -- 目标列表
    local tableView = UI.TableView:create({}, listWidth, listHeight)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:init()
    tableView:onUpdateCellSize(function ()
        return cellTemplate.CELL_WIDTH, cellTemplate.CELL_HEIGHT
    end) 
    tableView:onUpdateCells(function (tableview, idx)
        -- 创建单元
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = cellTemplate.new(tableView)
        end

        -- 更新单元
        xpcall(function()
            local goalData = dataArrFunc()[idx + 1]
            if (goalData) then
                if (cell.reset) then cell:reset() end
                cell:setClickCallback(function(comp)
                    if (cb) then cb(idx + 1, comp) end
                end)
                cell:updateData(goalData)
            end
        end, 
        function(e) 
            printInfo("SevenDayGoalLayer:tableCellAtIndex, error")
        end, 1) 

        return cell
    end)
    tableView:onUpdateCellNumbers(function()
        return #dataArrFunc()
    end)

    return tableView
end

-- 切换阶段, 0 = 最新
function SevenDayGoalLayer:setStageByIdx(idx, isForceSet)
    local sevenDayGoalData = GoalDataManager:getGoalData(3)

    -- 如果idx为0, 设置为最新
    if (idx == 0) then
        local curStage = sevenDayGoalData.curStage and sevenDayGoalData.curStage or 1
        if (sevenDayGoalData.curStage > sevenDayGoalData.stageSize) then
            curStage = sevenDayGoalData.stageSize
        end
        idx = curStage
    end
    local newStageData = GoalDataManager:getStageArr(3)[idx]
    local updateTask = true

    -- 检查解锁状态
    if (newStageData.isLocked) then
        self._goalListTaskView:hide()
        updateTask = false
    else
        self._goalListTaskView:show()
    end

    -- 检查是否已经激活
    if (not isForceSet) then
        if (newStageData.isActive) then 
            self._goalListView:reload()
            updateTask = false
        end
    end

    if (not updateTask) then return end

    -- 表现: 清除老激活标签
    for i,stageData in ipairs(GoalDataManager:getStageArr(3)) do
        stageData.isActive = false
    end

    -- 表现: 设置新的激活标签
    if (newStageData) then
        newStageData.isActive = true
        self._goalListView:reload()
        self._goalListView:scrollRectToVisible({
            origin = {x = 0, y = (sevenDayGoalData.stageSize - newStageData.ID) * UI.SevenDayGoalCell.CELL_HEIGHT}, 
            size = {width = 0, height = UI.SevenDayGoalCell.CELL_HEIGHT}})
    end

    -- 逻辑: 刷新任务列表
    self._goalListTaskView:reload()
    self._goalListTaskView:scrollToTop()
end

-- 通过指针获取现在任务列表中的奖励
function SevenDayGoalLayer:getReward(idx)
    -- 检查是否能够领取奖励
    if (not GoalDataManager:isAbleToGetReward()) then
        UI.ScrollBar:createByTextID(1111316)
        return
    end

    -- 检查并执行领取奖励
    local activityData = GoalDataManager:getActiveStageActivityArr(3)[idx]
    if (activityData) then
        -- 检查背包格数
        local goodsArr = {}
        for i,rewardID in ipairs(activityData.rewardid) do
            local rewardNum = activityData.rewardnum[i]
            if (rewardID and rewardNum) then
                local data = {}
                data.goodsID = rewardID
                data.num = rewardNum
                data.isGolden = true
                table.insert(goodsArr, data)
            end
        end

        -- 背包检查合格, 请求获取奖励; 不合格, 提示
        if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)) then 
            local activityId = activityData.id and activityData.id or activityData.ID
            Net.NetRoleSystem:requestGoalReward(activityData.goalID, activityData.stageID, activityId)
        else
            UI.ScrollBar:createByTextID(1170081)
        end
    end
end









-- 事件处理 --
---------------------------------------

function SevenDayGoalLayer:refreshAllViews()
    self:updateView()
end

function SevenDayGoalLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_REFRESH_SEVEN_DAY, self, self.refreshAllViews)
end

function SevenDayGoalLayer:unregisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_REFRESH_SEVEN_DAY, self, self.refreshAllViews)
end
---------------------------------------
-- eo 事件处理 --

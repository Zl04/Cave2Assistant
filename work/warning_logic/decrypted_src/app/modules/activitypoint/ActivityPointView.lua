------------------------------------------------------------------------------
--author: 
--date	: 2019/06/26
--desc	: 
------------------------------------------------------------------------------

require "app.modules.activitypoint.ActivityPointCell"
local LanguageManager = require("app.game.LanguageManager")

local ActivityPointView = class("ActivityPointView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_daily.plist"
}

function ActivityPointView:ctor()
    ActivityPointView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        0,
        0
    )
    self:bindModel()
    self._data = {}
end

function ActivityPointView:dtor()
    ActivityPointView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitypoint.ActivityPointView")
    reload_script_file("app.modules.activitypoint.ActivityPointCell")
end


function ActivityPointView:onInitView()
    self:center()

    -- 总背景
    local bg  = UI.Image:create();
    bg:init("ui_bg_box2.png")
    bg:center()
    self:addChild(bg)
    self:setSize(bg:getSize())

    -- 标题背景
    local titleBg  = UI.Image:create()
    titleBg:init("ui_bg_title.png")
    titleBg:centerUp(-8)
    bg:addChild(titleBg)

    -- 标题
    local title = UI.Text:create()
	title:init(LanguageManager:getInstance():getLocalString(1112427)--[["日常活动"]], UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_187_181_175)
	title:center()
    titleBg:addChild(title)
    
    -- 背景纸
    local bgPaper  = UI.Image:create()
    bgPaper:init("ui_bg_paper3.png")
    bgPaper:leftBottom(106, 30)
    self:addChild(bgPaper)

    -- 上装饰条
    local splitterUp = UI.Image9:create()
    splitterUp:init("ui_scale9image_black.png", CCRectMake(2,0,1,1), cc.size(840, 2))
    splitterUp:centerUp(12)
    bgPaper:addChild(splitterUp, 100)

    -- 任务列表
    self._tableView = UI.TableView:create({}, 819, 357)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(23, 141)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:onUpdateCellSize(function ()
        return UI.ActivityPointCell.CELL_WIDTH, UI.ActivityPointCell.CELL_HEIGHT
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.ActivityPointCell.new(self._tableView)
        end

        -- 更新单元
        xpcall(function()
            local data = mvc.activityPointModel:getActivityFromIdx(luaIdx)
            cell:updateData(data)
            cell:setClickCallback(function()
                mvc.activityPointController:autoMove(data.ID, luaIdx)
                mvc.closePanel("ActivityPoint", "ActivityPoint")
            end)
        end, 
        function(e) 
            printInfo("ActivityPointView:tableCellAtIndex, error")
        end, 1) 

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return mvc.activityPointModel:getActivityNum()
    end)
    bgPaper:addChild(self._tableView)
    self._tableView:reloadData()

    -- 下装饰条
    local splitterUp = UI.Image9:create()
    splitterUp:init("ui_scale9image_black.png", CCRectMake(2,0,1,1), cc.size(840, 2))
    splitterUp:centerUp(370)
    bgPaper:addChild(splitterUp, 100)

    -- 进度条
    self._progressBar = UI.ProgressTimer:create()
    self._progressBar:init("ui_daily_progressbar_2.png", "ui_daily_progressbar_1.png", "ui_daily_progressbar_1.png")
    self._progressBar:leftBottom(68, 68)
    bgPaper:addChild(self._progressBar)

    -- 活跃度背景
    local totalActivityPointBg  = UI.Image:create()
    totalActivityPointBg:init("ui_daily_box_0.png")
    totalActivityPointBg:leftBottom(23, 34)
    bgPaper:addChild(totalActivityPointBg)

    -- 活跃度
    self._activityPointText = UI.Text:create()
	self._activityPointText:init("60", UI.FONT_BOLD, 38, {r = 57,  g = 52,  b = 51})
	self._activityPointText:center()
    totalActivityPointBg:addChild(self._activityPointText)

    -- 每日重置标签
    local resetLabel = UI.Text:create()
	resetLabel:init(LanguageManager:getInstance():getLocalString(1112424)--[[每日重置"]], UI.FONT_BOLD, 16, {r = 31,  g = 29,  b = 28})
	resetLabel:centerBottom(-22)
    totalActivityPointBg:addChild(resetLabel)

    local stagePointArr = mvc.activityPointModel:getProgressPointArr()
    local iconConfigs = {
        {num = stagePointArr[1] or 20, x = 0, y = -10},
        {num = stagePointArr[2] or 50, x = 0, y = -10},
        {num = stagePointArr[3] or 80, x = 0, y = -9.5},
        {num = stagePointArr[4] or 100, x = 0, y = -10.5},
        {num = stagePointArr[5] or 150, x = 0, y = -11},
        {num = stagePointArr[6] or 200, x = 0, y = -11},
    }
    self._iconConfigs = iconConfigs
    self._stageIcons = {}
    self._stageBgs = {}
    self._stageStars = {}
    self._stageNewBgs = {}
    local startX = 23
    local oneWidth = 725/ #iconConfigs
    local startY = 18
    for i=1,#iconConfigs do
        local stageConfig = iconConfigs[i]
        local stageBg, stageIcon, stageStar, stageNewbg = self:createStageIcon(string.format("ui_daily_box_%s_1.png", i), string.format("ui_daily_box_%s_2.png", i), stageConfig.num, stageConfig.x, stageConfig.y, i)
        -- local stageBg, stageIcon, stageStar, stageNewbg = self:createStageIcon(string.format("ui_daily_box_%s_1.png", 3), string.format("ui_daily_box_%s_2.png", 3), stageConfig.num, stageConfig.x, stageConfig.y, i)
        stageBg:leftBottom(startX + oneWidth * i, startY)
        bgPaper:addChild(stageBg)
        table.insert(self._stageIcons, stageIcon)
        table.insert(self._stageBgs, stageBg)
        table.insert(self._stageStars, stageStar)
        table.insert(self._stageNewBgs, stageNewbg)
    end

    -- 靶子
    local targetPoint  = UI.Image:create()
    targetPoint:init("ui_daily_foreground_1.png")
    targetPoint:leftBottom(-28, 0)
    bg:addChild(targetPoint)
    

    -- 纸
    local paper  = UI.Image:create()
    paper:init("ui_daily_foreground_2.png")
    paper:rightBottom(10, 55)
    bg:addChild(paper)
end

function ActivityPointView:onUpdateView()
    self:updateStageView()
    self._data = mvc.activityPointModel:getAllActivity()
    self._tableView:reloadData()
end

function ActivityPointView:createStageIcon(normalIconName, greyIconName, num, xOffset, yOffset, idx)
    -- 背景
    local bg  = UI.Image:create()
    bg:init("ui_daily_box_00.png")

    -- 按钮
    local iconButton  = UI.Button:create()
    iconButton:init(normalIconName, normalIconName, greyIconName)
    iconButton:center(xOffset, yOffset)
    iconButton:setInterval(1)
    bg:addChild(iconButton)
    iconButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local currentStage = mvc.activityPointModel:getStage()
        if (idx > currentStage) then
            if (idx == currentStage + 1) then
                mvc.activityPointController:requestActivityPointReward(idx)
            else
                mvc.activityPointController:showItemByIndex(idx, LanguageManager:getInstance():getLocalString(1112425)--[["宝箱内容"]])
            end 
        else
            mvc.activityPointController:showItemByIndex(idx, LanguageManager:getInstance():getLocalString(1112425)--[["宝箱内容"]])
        end
    end)
    iconButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        mvc.activityPointController:showItemByIndex(idx, LanguageManager:getInstance():getLocalString(1112425)--[["宝箱内容"]])
    end)

    -- 新标签背景
    local newLabelBg  = UI.Image:create()
    newLabelBg:init("ui_daily_received.png")
    newLabelBg:leftBottom(0, 18)
    bg:addChild(newLabelBg)
    
    -- 新标签文字
    local newLabel = UI.Text:create()
	newLabel:init(LanguageManager:getInstance():getLocalString(1112426)--[["已领取"]], UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 249,  g = 190,  b = 86})
    newLabel:center(-3, 3)
    newLabel:rotate(18)
    newLabelBg:addChild(newLabel)

    -- 数字
    local numLabel = UI.Text:create()
    numLabel:init(tostring(num), UI.FONT_BOLD, 18, {r = 213,  g = 205,  b = 205})
    numLabel:centerBottom(-2)
    bg:addChild(numLabel)

    -- 红点
    local starPoint = UI.Animation:create()
    starPoint:init("effect_ui_package_return_gift.json", "effect_ui_package_return_gift.atlas", 1)
    starPoint:setAnimation("idle", true)
    starPoint:rightUp(10, 10)
    bg:addChild(starPoint)

    return bg, iconButton, starPoint, newLabelBg
end

function ActivityPointView:updateStageView()
    -- 更新进度条
    local totalPoint = mvc.activityPointModel:getTotalPoint()

    if self._iconConfigs then
        local maxPoint = self._iconConfigs[#self._iconConfigs].num
        local progressPoint = totalPoint
        local preProVale = 1 / #self._iconConfigs -- 每个阶段的进度
        local localStageMaxValue = 50 --当前阶段的最大值
        local localStageValue = 0 --当前阶段的值
        local localStage = 0

        for i=1,#self._iconConfigs do
            local num = self._iconConfigs[i].num

            if i == 1 then
                localStageMaxValue = num
            else
                localStageMaxValue = num - self._iconConfigs[i-1].num
            end

            if progressPoint <= num then
                localStageValue = num - progressPoint
                if progressPoint == num then
                    localStage = localStage + 1
                end
                break
            end

            localStage = localStage + 1
        end

        local progress = preProVale * localStage + preProVale * (localStageValue / localStageMaxValue)
        if (progress > 1) then progress = 1 end
        if (progress < 0) then progress = 0 end

        self._progressBar:setPercent(progress)
    end

    -- -- 这里以每隔20来做进度显示，后续不为20一段的全部按照数据转换为20来计算
    -- local maxPoint = #self._stageIcons * 20

    -- -- 拆分100-150
    -- local split = 100
    -- local progressPoint = totalPoint
    -- if progressPoint > split then 
    --     local lessNum = progressPoint - split
    --     progressPoint = split + lessNum/2.5
    -- end
    -- local progress = progressPoint / maxPoint
    -- if (progress > 1) then progress = 1 end
    -- if (progress < 0) then progress = 0 end
    -- self._progressBar:setPercent(progress)

    -- 更新活跃度数字
    self._activityPointText:setText(tostring(totalPoint))

    -- 更新按钮状态
    local progressIdx = mvc.activityPointModel:getProgressStage()
    local stage = mvc.activityPointModel:getStage()
    for i=1,#self._stageIcons do
        local icon = self._stageIcons[i]
        local newLabelBg = self._stageNewBgs[i]
        if (icon and newLabelBg) then
            -- 设置按钮状态
            if (i <= progressIdx) then
                icon:enable()
                if (i <= stage) then
                    newLabelBg:show()
                else
                    newLabelBg:hide()
                end
            else
                icon:disable()
                newLabelBg:hide()
            end

            -- 设置红点状态
            local currentStage = mvc.activityPointModel:getStage()
            local star = self._stageStars[i]
            if (star and i == currentStage + 1 and i <= progressIdx) then
                star:show()
            else
                star:hide()
            end
        end
    end
end


function ActivityPointView:bindModel()

end


function ActivityPointView:unbindModel()

end





return ActivityPointView













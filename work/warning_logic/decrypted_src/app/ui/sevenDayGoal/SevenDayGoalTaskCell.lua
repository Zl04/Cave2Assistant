-- SevenDayGoalTaskCell.lua
-- Author:CMonk
-- 2019年04月09日

require "app.game.GameManager"
require "utils.AvalonUtil"

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local SevenDayGoalTaskCell = class("SevenDayGoalTaskCell", UI.TableViewCell)
UI.SevenDayGoalTaskCell = SevenDayGoalTaskCell

SevenDayGoalTaskCell.CELL_WIDTH = 630
SevenDayGoalTaskCell.CELL_HEIGHT = 130
local COLOR_FONT_GREEN = {r = 36, g = 181, b = 118}
local COLOR_FONT_RED = {r = 208, g = 50, b = 60}

function SevenDayGoalTaskCell:updateOncePerSecond()
    -- 更新倒计时显示
    self:updateTimerView()

    -- 更新过期状态
    self:updateExpireStat()
end

function SevenDayGoalTaskCell:ctor(parentTable)
    SevenDayGoalTaskCell.super.ctor(self)
    
    self._parentTable = parentTable
    self:onInitView()

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateOncePerSecond), 1, false)
    self._rewardItemGrids = {}
end

function SevenDayGoalTaskCell:dtor()
    SevenDayGoalTaskCell.super.dtor(self)
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function SevenDayGoalTaskCell:onInitView()
    -- 内容运载层
    self._contentLayer = UI.Image:create()
    self._contentLayer:init()
    self._contentLayer:setSize(UI.SevenDayGoalTaskCell.CELL_WIDTH, UI.SevenDayGoalTaskCell.CELL_HEIGHT)
    self._contentLayer:leftBottom(0, 0)
    self:addChild(self._contentLayer)

    -- 标题背景
    local titleBg = UI.Image:create()
    titleBg:init("ui_sevendays_strip.png")
    titleBg:centerUp(0)
    self._contentLayer:addChild(titleBg)

    -- 标题布局
    self._titleLayout = UI.Layout:create()
    self._titleLayout:init()
    self._titleLayout:enableAutoHeight()
    self._titleLayout:enableAutoWidth()
    self._titleLayout:centerLeft(15)
    titleBg:addChild(self._titleLayout)

    -- 标题
    self._titleLabel = UI.Text:create()
    self._titleLabel:init("Title", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    self._titleLabel:floatLeft(0)
    self._titleLayout:addComponent(self._titleLabel)

    -- 计数器
    self._counterLabel = UI.Text:create()
    self._counterLabel:init("0/0", UI.FONT_BOLD, UI.FONT_SIZE_18PX, COLOR_FONT_GREEN)
    self._counterLabel:floatLeft(30)
    self._titleLayout:addComponent(self._counterLabel)

    -- 倒计时排版
    self._timerLayout = UI.Layout:create()
    self._timerLayout:init()
    self._timerLayout:enableAutoWidth()
    self._timerLayout:enableAutoHeight()
    self._timerLayout:centerRight(0)
    titleBg:addChild(self._timerLayout)

    -- 倒计时文字
    self._timeText = UI.Text:create()
    self._timeText:init("00:00:00", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_155_155_155)
    self._timeText:floatRight(17)
    self._timerLayout:addComponent(self._timeText)

    -- 倒计时
    local clockIcon = AvalonUtil.createClockAnimation()
    clockIcon:floatRight(0)
    self._timerLayout:addComponent(clockIcon)

    -- 奖励列表
    self._rewardLayout = UI.Layout:create()
    self._rewardLayout:init()
    self._rewardLayout:setSize(0, 70)
    self._rewardLayout:enableAutoWidth()
    self._rewardLayout:leftBottom(16, 19)
    self._contentLayer:addChild(self._rewardLayout)

    -- 已经完成的背景
    self._finishedTaskBg = UI.Animation:create()
    self._finishedTaskBg:init("effect_ui_common_stamp_rect_green.json", "effect_ui_common_stamp_rect_green.atlas", 1);
    self._finishedTaskBg:center(230, 11)
    self._finishedTaskBg:hide()
    self._contentLayer:addChild(self._finishedTaskBg)

    -- 已完成文字
    local finishedTaskText = UI.Text:create()  
    finishedTaskText:init(UI.TEXT_111021, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
    finishedTaskText:center()
    self._finishedTaskBg:addComponent("seal-zi", finishedTaskText)

    -- 未完成背景
    self._noFinishedTaskBg = UI.Image:create()
    self._noFinishedTaskBg:init("ui_information_banner_unfinished1.png")
    self._noFinishedTaskBg:center(230, 11)
    self._noFinishedTaskBg:hide()
    self._contentLayer:addChild(self._noFinishedTaskBg)

    -- 未完成文字
    local noFinishedTaskText = UI.Text:create()
    noFinishedTaskText:init(UI.TEXT_111022, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
    noFinishedTaskText:center()
    noFinishedTaskText:setRotationSkewX(-9.0)
    noFinishedTaskText:setRotationSkewY(-9.0)
    self._noFinishedTaskBg:addChild(noFinishedTaskText)

    -- 已过期背景
    self._expiredTaskBg = UI.Animation:create()
    self._expiredTaskBg:init("effect_ui_common_stamp_rect_gray.json", "effect_ui_common_stamp_rect_gray.atlas", 1);
    self._expiredTaskBg:center(230, 11)
    self._expiredTaskBg:hide()
    self._contentLayer:addChild(self._expiredTaskBg)

    -- 已过期文字
    local noFinishedTaskText = UI.Text:create()
    noFinishedTaskText:init(LanguageManager:getInstance():getLocalString(1170080), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_92_92_92)
    noFinishedTaskText:center()
    self._expiredTaskBg:addComponent("seal-zi", noFinishedTaskText)

    -- 领奖按钮
    self._rewardBtn = UI.Button:create()
    self._rewardBtn:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    self._rewardBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_19PX, UI.FONT_COLOR_50_50_44)
    self._rewardBtn:center(230, 11)
    self._rewardBtn:closeClickScale()
    self._rewardBtn:setInterval(1)
    self._rewardBtn:setSwallowTouches(false)
    self._rewardBtn:setTouchClipNode(self._parentTable)
    self._rewardBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if (self._clickCB) then self._clickCB(self._rewardBtn) end
    end)
    self._contentLayer:addChild(self._rewardBtn)

    -- 红点
    self._redPoint = AvalonUtil.createRedPoint(self._rewardBtn, 0, 0)
    self._redPoint:hide()

    -- 底部线条
    local splitter = UI.Image9:create()
    splitter:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(UI.SevenDayGoalTaskCell.CELL_WIDTH, 1))
    splitter:centerBottom(10)
    self._contentLayer:addChild(splitter)

    -- 上层
    self._topLayer = UI.Image:create()
    self._topLayer:init()
    self._topLayer:setSize(UI.SevenDayGoalTaskCell.CELL_WIDTH, UI.SevenDayGoalTaskCell.CELL_HEIGHT)
    self._topLayer:leftBottom(0, 0)
    self:addChild(self._topLayer)

    -- 未开启
    self._lock = UI.Image:create()
    self._lock:init("ui_sevendays_lock.png")
    self._lock:center()
    self._lock:hide()
    self._topLayer:addChild(self._lock)
end

-- 更新倒计时表现
function SevenDayGoalTaskCell:updateTimerView()
    if (self._data and self._data.stat == 1 and self._data.overTime and self._data.overTime ~= 0) then
        local timeNow = GameManager:getNormalServerTime()
        local deltaTime = self._data.overTime - timeNow
        if (deltaTime < 0) then
            deltaTime = 0
            self._timerLayout:hide()
        else
            self._timerLayout:show()
            local timeString = AvalonUtil:_getFullFormatTime(deltaTime, true)
            self._timeText:setText(timeString)
            self._timerLayout:updateView()
        end
    else
        self._timerLayout:hide()
    end
end

-- 更新过期状态
function SevenDayGoalTaskCell:updateExpireStat()
    if (self._data and self._data.overTime and self._data.overTime ~= 0) then
        local timeNow = GameManager:getNormalServerTime()
        if (self._data.overTime - timeNow < 0) then
            if (self._data.stat and self._data.stat ~= 4) then 
                self._data.stat = 4 
                self:updateData(self._data)
            end
        end
    end
end

-- 更新奖品列表表现
function SevenDayGoalTaskCell:updateRewardView()
    if (self._data and self._data.rewardid) then
        self._rewardLayout:removeAllChildren()
        self._rewardLayout:clearComponentList()
        self._rewardItemGrids = {}
 
        for i,v in ipairs(self._data.rewardid) do
            -- 创建奖励道具图标
            local goodData = self:getDummyItemData(v)
            if (goodData) then
                local num = self._data.rewardnum[i] or 0
                goodData:setNum(num)
                local rewardGrid = UI.GoodsGrid:create()
                rewardGrid:init(goodData)
                rewardGrid:hideNewIcon()
                rewardGrid:setTouchEnable(true)
                rewardGrid:setSwallowTouches(false)
                rewardGrid:setTouchClipNode(self._parentTable)
                rewardGrid:showInfoArea(true, false)
                rewardGrid:floatLeft(8)
                if (num == 0) then
                    rewardGrid:hideCountLabel()
                end
                self._rewardLayout:addComponent(rewardGrid)
                table.insert(self._rewardItemGrids, rewardGrid)
            end
        end
    end
end

function SevenDayGoalTaskCell:getDummyItemData(id)
    require "app.datas.GoodsDataManager"
    local goodData = GoodsDataManager:createLocalGoodsData(id) --23030001
    if goodData then
        goodData:setNum(0)
        goodData:setIsNew(false)
        goodData.isHaveGet = false
    end
    return goodData
end

function SevenDayGoalTaskCell:showCompleteAnimation(isShowProcess)
    if (isShowProcess) then
        self._finishedTaskBg:setAnimation("begin", false)
    end
    self._finishedTaskBg:addAnimation("end", false)
end

function SevenDayGoalTaskCell:showExpireAnimation(isShowProcess)
    if (isShowProcess) then
        self._expiredTaskBg:setAnimation("begin", false)
    end
    self._expiredTaskBg:addAnimation("end", false)
end


-------------SevenDayLayer 接口--------------
function SevenDayGoalTaskCell:reset()
    self._lastState = nil
end

function SevenDayGoalTaskCell:setClickCallback(cb)
    self._clickCB = cb
end

function SevenDayGoalTaskCell:updateData(data)
    self._data = data
    if (self._data) then
        -- 更新标题
        if (self._data.descLocal) then
            self._titleLabel:setText(self._data.descLocal)
        end

        -- 更新进度
        if (self._data.count and self._data.targetAmount and self._data.targetAmount ~= 0) then
            self._counterLabel:show()
            local displayCount = self._data.count > self._data.targetAmount and self._data.targetAmount or self._data.count
            self._counterLabel:setText(tostring(displayCount) .. "/" .. tostring(self._data.targetAmount))
            if (self._data.count < self._data.targetAmount) then
                self._counterLabel:setFontColor(COLOR_FONT_RED)
            else
                self._counterLabel:setFontColor(COLOR_FONT_GREEN)
            end
        else
            self._counterLabel:hide()
        end

        -- 更新完成状态
        if (self._data.stat) then
            if (self._data.stat == 0) then
                -- 未开启
                self._contentLayer:setOpacity(70)
                self._noFinishedTaskBg:hide()
                self._finishedTaskBg:hide()
                self._rewardBtn:hide()
                self._expiredTaskBg:hide()
                self._lock:show()
            elseif (self._data.stat == 1) then
                -- 进行中
                self._contentLayer:setOpacity(255)
                self._noFinishedTaskBg:show()
                self._finishedTaskBg:hide()
                self._rewardBtn:hide()
                self._expiredTaskBg:hide()
                self._lock:hide()
            elseif (self._data.stat == 2) then
                -- 可领奖
                self._contentLayer:setOpacity(255)
                self._noFinishedTaskBg:hide()
                self._finishedTaskBg:hide()
                self._rewardBtn:show()
                self._expiredTaskBg:hide()
                self._lock:hide()
            elseif (self._data.stat == 3) then
                -- 已领奖
                self._contentLayer:setOpacity(255)
                self._noFinishedTaskBg:hide()
                self._finishedTaskBg:show()
                self._rewardBtn:hide()
                self._expiredTaskBg:hide()
                self._lock:hide()
                self:showCompleteAnimation(self._lastState ~= nil and self._lastState ~= self._data.stat)
            elseif (self._data.stat == 4) then
                -- 已过期
                self._contentLayer:setOpacity(255)
                self._noFinishedTaskBg:hide()
                self._finishedTaskBg:hide()
                self._rewardBtn:hide()
                self._expiredTaskBg:show()
                self._lock:hide()
                self:showExpireAnimation(self._lastState ~= nil and self._lastState ~= self._data.stat)
            end
        else
            self._contentLayer:setOpacity(255)
            self._noFinishedTaskBg:hide()
            self._finishedTaskBg:hide()
            self._rewardBtn:hide()
            self._expiredTaskBg:hide()
            self._lock:hide()
        end

        -- 更新按钮标题
        if (self._data.buttonText) then
            self._rewardBtn:setText(self._data.buttonText)
        else
            self._rewardBtn:setText(UI.TEXT_111035)
        end

        -- 有没有可以领取的东西?
        if (self._data.isFinishStatExist) then
            self._redPoint:show()
        else
            self._redPoint:hide()
        end

        -- 更新物品列表
        self:updateRewardView()

        -- 立马更新时间进度
        self:updateTimerView()

        -- 为下次保存状态
        if (self._data.stat) then self._lastState = self._data.stat end
    end
end
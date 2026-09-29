--[[
    家园通用信息页面
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.home.HomeBasePanel"
local LanguageManager = require("app.game.LanguageManager")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local HomeBaseInfoPanel = class("HomeBaseInfoPanel", UI.HomeBasePanel)
UI.HomeBaseInfoPanel = HomeBaseInfoPanel

-- 私有变量
local DEBUG_DRAW = false
local COLOR_FONT_GREEN = {r = 36, g = 181, b = 118}
local COLOR_FONT_RED = {r = 208, g = 50, b = 60}
---------------------------------------
-- eo 模块初始化 --






-- 资源统合 --
---------------------------------------
local COM_RES_LIST = {
}
---------------------------------------
-- eo 资源统合 --






-- 生命周期 --
---------------------------------------
-- 构造函数
function HomeBaseInfoPanel:ctor(...)
    HomeBaseInfoPanel.super.ctor(self, ...)
end

-- 析构函数
function HomeBaseInfoPanel:dtor()
    HomeBaseInfoPanel.super.dtor(self)
    if (self._schedulerId) then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._schedulerId)
    end
end

-- 初始化
function HomeBaseInfoPanel:init(hostLayer, width, height)
    self._hostLayer = hostLayer
    self:setSize(width, height)
    HomeBaseInfoPanel.super.init(self)

    self._boostTimeRemainingLastCheck = 0
    -- 时间刷新
    self._schedulerId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
        self:updateBoostTimeRemaining()
        self:updateSize()
    end, 1, false)
end

-- 初始化视图
function HomeBaseInfoPanel:onInitView()
    -- 获取数据
    local configData = self:getConfigData()

    -- 主图标
    self._mainIcon = UI.Image:create()
    self._mainIcon:init(configData:getCurrentIcon())
    self._mainIcon:center(-17, -138)
    self:addChild(self._mainIcon)

    -- 领取按钮
    self._recvBtn = UI.Button:create()
    self._recvBtn:init("ui_btn_yellow10_0.png", "ui_btn_yellow10_1.png", "ui_btn_yellow10_2.png", cc.p(0, 5))
    self._recvBtn:setInterval(1)
    self._recvBtn:setText(LanguageManager:getInstance():getLocalString(1111510)) --"收取"
    self._recvBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    self._recvBtn:leftBottom(158, 333)
    self._recvBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        local nextTimeStamp = self:getNextRecvTimestamp()
        local normalTime = GameManager:getNormalServerTime()
        local deltaTime = nextTimeStamp - normalTime
        if (deltaTime > 120 or deltaTime <= 0) then
            self:onClickRecvBtn()
        else
            UI.ScrollBar:createByText(string.format(LanguageManager:getInstance():getLocalString(1111555), deltaTime))            
        end
    end)
    self:addChild(self._recvBtn)

    -- 加速排版
    self._boostLayout = UI.Layout:create()
    self._boostLayout:init()
    self._boostLayout:leftBottom(70, 305)
    self._boostLayout:enableAutoWidth()
    self._boostLayout:enableAutoHeight()
    self:addChild(self._boostLayout)

    -- 加速标签
    local speedingLabel = UI.Text:create()
    speedingLabel:init(LanguageManager:getInstance():getLocalString(1111501), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"高速状态"
    speedingLabel:floatLeft(0)
    self._boostLayout:addComponent(speedingLabel)

    -- ON图标
    self._onIcon = UI.Image:create()
    self._onIcon:init("ui_home_banner_on.png")
    self._onIcon:floatLeft(5)
    self._onIcon:hide()
    self._boostLayout:addComponent(self._onIcon)

    -- OFF图标
    self._offIcon = UI.Image:create()
    self._offIcon:init("ui_home_banner_off.png")
    self._offIcon:floatLeft(5)
    self._offIcon:hide()
    self._boostLayout:addComponent(self._offIcon)

    -- 时间图标
    self._timeIcon = AvalonUtil.createClockAnimation()
    self._timeIcon:leftBottom(263, 303)
    self:addChild(self._timeIcon)

    -- 时间文字
    self._timeText = UI.Text:create()
    self._timeText:init("00:00:00", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    self._timeText:leftBottom(293, 309)
    self:addChild(self._timeText)

    local rowLayout = UI.Layout:create()
    rowLayout:init()
    -- 用一个很黑得方法, 布局全无宽度来做一个很丑的全居左
    -- rowLayout:enableAutoWidth()
    rowLayout:enableAutoHeight()
    rowLayout:leftUp(100, 325)
    self:addChild(rowLayout)

    -- 等级布局
    self._lvLayout = UI.Layout:create()
    self._lvLayout:init()
    self._lvLayout:floatUp(3)
    self._lvLayout:enableAutoHeight()
    rowLayout:addComponent(self._lvLayout)

    -- 等级标签
    local lvLabel = UI.Text:create()
    lvLabel:init(self:getLvLabel(), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    lvLabel:floatLeft(0)
    self._lvLayout:addComponent(lvLabel)

    -- 等级数值
    self._lvText = UI.Text:create()
    self._lvText:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._lvText:floatLeft(5)
    self._lvLayout:addComponent(self._lvText)

    -- 输出等级布局
    self._outputLevelLayout = UI.Layout:create()
    self._outputLevelLayout:init()
    self._outputLevelLayout:floatUp(3)
    self._outputLevelLayout:enableAutoHeight()
    rowLayout:addComponent(self._outputLevelLayout)

    -- 输出等级标签
    local amountLabel = UI.Text:create()
    amountLabel:init(self:getOutputLevelLabel(), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    amountLabel:floatLeft(0)
    self._outputLevelLayout:addComponent(amountLabel)

    -- 输出等级数值
    self._outputLevelText = UI.Text:create()
    self._outputLevelText:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._outputLevelText:floatLeft(5)
    self._outputLevelLayout:addComponent(self._outputLevelText)

    -- 生产速度布局
    self._speedLayout = UI.Layout:create()
    self._speedLayout:init()
    self._speedLayout:floatUp(3)
    self._speedLayout:enableAutoHeight()
    rowLayout:addComponent(self._speedLayout)

    -- 生产速度标签
    local speedLabel = UI.Text:create()
    speedLabel:init(self:getSpeedLabel(), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    speedLabel:floatLeft(0)
    self._speedLayout:addComponent(speedLabel)

    -- 生产速度数值
    self._speedText = UI.Text:create()
    self._speedText:init("0/h", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._speedText:floatLeft(5)
    self._speedLayout:addComponent(self._speedText)

    -- 加速数值
    self._boostText = UI.Text:create()
    self._boostText:init("+ 0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, COLOR_FONT_GREEN)
    self._boostText:floatLeft(8)
    self._speedLayout:addComponent(self._boostText)

    -- 容量布局
    self._sizeLayout = UI.Layout:create()
    self._sizeLayout:init()
    self._sizeLayout:floatUp(3)
    self._sizeLayout:enableAutoHeight()
    rowLayout:addComponent(self._sizeLayout)

    -- 容量标签
    local amountLabel = UI.Text:create()
    amountLabel:init(self:getSizeLabel(), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    amountLabel:floatLeft(0)
    self._sizeLayout:addComponent(amountLabel)

    -- 容量数值
    self._sizeText = UI.Text:create()
    self._sizeText:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._sizeText:floatLeft(5)
    self._sizeLayout:addComponent(self._sizeText)
end

-- 更新视图时
function HomeBaseInfoPanel:onUpdateView()
    -- 获取数据
    local configData = self:getConfigData()

    -- 更新等级
    local level = configData:getCurrentLevel()
    if (level ~= nil) then
        self._mainIcon:setSpriteName(configData:getCurrentIcon())
        self._lvText:setText(tostring(level))
    end

    -- 更新加速OnOff
    local isBoostOn = configData:getIsInBoost()
    if (isBoostOn and not self._onIcon:isVisible()) then
        AvalonUtil.runBounceInAnimation(self._onIcon)
    end
    self._onIcon:setVisible(isBoostOn)
    self._offIcon:setVisible(not isBoostOn)
    self._boostLayout:updateView()

    -- 更新加速时间
    self:updateBoostTimeRemaining()

    -- 更新速度
    local speed = configData:getCurrentBaseSpeed()
    local spoeedText = AvalonUtil.ConvertNumberToStringWithOptionalDecimal(speed, 2) .. "/" .. self:getUnitSymbol()
    self._speedText:setText(spoeedText)

    -- 更新加速速度
    local extraSpeedText = ""
    if (configData:getIsInBoost()) then
        local extraBoostSpeed = configData:getCurrentExtraBoostSpeedNumber()
        extraSpeedText = "+ " .. AvalonUtil.ConvertNumberToStringWithOptionalDecimal(extraBoostSpeed, 2)
    end
    self._boostText:setText(extraSpeedText)
    self._speedLayout:updateView()

    -- 更新产出等级
    local outputLevel = configData:getCurrentOutputLevel()
    if (outputLevel) then
        self._outputLevelLayout:show()
        self._outputLevelText:setText(tostring(outputLevel))
    else
        self._outputLevelLayout:hide()
    end

    -- 更新容量
    self:updateSize()
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
function HomeBaseInfoPanel:getConfigData()
    printError("HomeBaseInfoPanel:getConfigData 请重载")
end

function HomeBaseInfoPanel:onClickRecvBtn()
    printError("HomeBaseInfoPanel:onClickRecvBtn 请重载")
end

function HomeBaseInfoPanel:getLvLabel()
    printError("HomeBaseInfoPanel:getLvLabel 请重载")
end

function HomeBaseInfoPanel:getSpeedLabel()
    printError("HomeBaseInfoPanel:getSpeedLabel 请重载")
end

function HomeBaseInfoPanel:getSizeLabel()
    printError("HomeBaseInfoPanel:getSizeLabel 请重载")
end

function HomeBaseInfoPanel:getOutputLevelLabel()
    printError("HomeBaseInfoPanel:getOutputLevelLabel 请重载")
end

function HomeBaseInfoPanel:getNextRecvTimestamp()
    printError("HomeBaseInfoPanel:getNextRecvTimestamp 请重载")
end

function HomeBaseInfoPanel:getUnitSymbol()
    printError("HomeBaseInfoPanel:getUnitSymbol 请重载")
end

function HomeBaseInfoPanel:updateBoostTimeRemaining()
    local configData = self:getConfigData()
    
    -- 更新剩余时间
    local timeRemaining = configData:getBoostTimeRemaining()
    if (configData:getIsInBoost() and timeRemaining) then
        self._timeIcon:show()
        self._timeText:show()
        local timeText = AvalonUtil:_getFullFormatTime(timeRemaining, true)
        self._timeText:setText(timeText)
    else
        self._timeIcon:hide()
        self._timeText:hide()
    end

    -- 时间结束后刷新
    if (self._boostTimeRemainingLastCheck ~= 0 and timeRemaining == 0) then
        self._boostTimeRemainingLastCheck = 0
        self:updateView()
        self._hostLayer:runBoostAnimation(false)
    end
    self._boostTimeRemainingLastCheck = timeRemaining
end

-- 更新容量
function HomeBaseInfoPanel:updateSize()
    local configData = self:getConfigData()
    local size = math.floor(configData:getCurrentSize())
    local maxSize = configData:getMaxSize()
    if (size ~= nil and maxSize ~= nil) then
        self._sizeText:setText(tostring(size) .. "/" .. tostring(maxSize))

        -- 显示数值到跟最大数值相同时, 需要变红
        if (size >= maxSize) then
            self._sizeText:setFontColor(COLOR_FONT_RED)
        else
            self._sizeText:setFontColor(UI.FONT_COLOR_41_41_45)
        end

        -- 改变按钮可点击状态
        if (size <= 0) then
            self._recvBtn:disable()
        else
            self._recvBtn:enable()
        end
    end
end
---------------------------------------
-- eo 通用逻辑 --





-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --
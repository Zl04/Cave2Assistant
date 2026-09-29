--[[
    家园通用加速页面
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
local HomeBaseAcceleratePanel = class("HomeBaseAcceleratePanel", UI.HomeBasePanel)
UI.HomeBaseAcceleratePanel = HomeBaseAcceleratePanel

-- 设计中窗口大小
local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

-- 私有变量
local DEBUG_DRAW = false
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
function HomeBaseAcceleratePanel:ctor(...)
    HomeBaseAcceleratePanel.super.ctor(self, ...)
end

-- 析构函数
function HomeBaseAcceleratePanel:dtor()
    HomeBaseAcceleratePanel.super.dtor(self)
    self:unRegisterListener()

    if (self._schedulerId) then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._schedulerId)
    end
end

-- 初始化
function HomeBaseAcceleratePanel:init(hostLayer, width, height)
    self:setSize(width, height)
    self._hostLayer = hostLayer
    HomeBaseAcceleratePanel.super.init(self)

    -- 时间刷新
    self._schedulerId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
        self:updateTimeRemaining()
    end, 1, false)
    self:registerListener()
end

-- 初始化视图
function HomeBaseAcceleratePanel:onInitView()
    -- 未加速布局
    self._questOffLayout = UI.Layout:create()
    self._questOffLayout:init()
    self._questOffLayout:leftBottom(0, 0)
    self._questOffLayout:setSize(self:getSize())
    self:addChild(self._questOffLayout)

    -- 道具框背景1
    self._goodFrame1 = UI.Animation:create()
    self._goodFrame1:init("effect_ui_town_home_icon.json", "effect_ui_town_home_icon.atlas")
    self._goodFrame1:center(-96, -96)
    self._goodFrame1:setAnimation("begin")
    self._questOffLayout:addChild(self._goodFrame1)

    -- 道具框背景2
    self._goodFrame2 = UI.Animation:create()
    self._goodFrame2:init("effect_ui_town_home_icon.json", "effect_ui_town_home_icon.atlas")
    self._goodFrame2:center(-9, -196)
    self._goodFrame2:setAnimation("begin")
    self._questOffLayout:addChild(self._goodFrame2)

    -- 道具框背景2
    self._goodFrame3 = UI.Animation:create()
    self._goodFrame3:init("effect_ui_town_home_icon.json", "effect_ui_town_home_icon.atlas")
    self._goodFrame3:center(78, -96)
    self._goodFrame3:setAnimation("begin")
    self._questOffLayout:addChild(self._goodFrame3)

    -- 已加速布局
    self._questOnLayout = UI.Layout:create()
    self._questOnLayout:init()
    self._questOnLayout:leftBottom(0, 0)
    self._questOnLayout:setSize(self:getSize())
    self:addChild(self._questOnLayout)

    -- 时间图标
    local questTimeIcon = AvalonUtil.createClockAnimation()
    questTimeIcon:leftBottom(163, 405)
    self._questOnLayout:addChild(questTimeIcon)

    -- 时间文字
    self._questTimeText = UI.Text:create()
    self._questTimeText:init("00:00:00", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    self._questTimeText:leftBottom(195, 411)
    self._questOnLayout:addChild(self._questTimeText)

    -- 下个任务时间标签
    local priceLabel = UI.Text:create()
    priceLabel:init(LanguageManager:getInstance():getLocalString(1111521), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"下个任务刷新时间:"
    priceLabel:center(-13, -135)
    self._questOnLayout:addChild(priceLabel)

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

    -- 加速时间图标
    self._boostTimeIcon = AvalonUtil.createClockAnimation()
    self._boostTimeIcon:leftBottom(263, 303)
    self:addChild(self._boostTimeIcon)

    -- 加速时间文字
    self._boostTimeText = UI.Text:create()
    self._boostTimeText:init("00:00:00", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    self._boostTimeText:leftBottom(293, 309)
    self:addChild(self._boostTimeText)

    -- 解释滚动框
    local scrollWidth = 263
    local descScroll = UI.ScrollView:create()
    descScroll:init(0, 0, 0, 0)
    descScroll:setSize(scrollWidth, 130)
    descScroll:leftUp(79, 323)
    self:addChild(descScroll)

    -- 解释布局
    local descLayout = UI.Layout:create()
    descLayout:init()
    descLayout:setSize(scrollWidth, 0)
    descLayout:enableAutoHeight()
    descScroll:addInnerNode(descLayout)

    -- 解释
    local descText = UI.Text:create()
    descText:init(self:getDescText(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    descText:setWidth(263)
    descText:setTextHorizontalCenter()
    descText:setLineSpacing(5)
    descText:autoAdapt()
    descText:floatUp(10)
    descLayout:addComponent(descText)

    -- 激活按钮
    self._boostButton = UI.Button:create()
    self._boostButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    self._boostButton:setText(LanguageManager:getInstance():getLocalString(1111524)) --"激活"
    self._boostButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._boostButton:leftBottom(119, 31)
    self._boostButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:onClickAccelerateBtn()
    end)
    self:addChild(self._boostButton)
end


-- 更新视图时
function HomeBaseAcceleratePanel:onUpdateView()
    -- 获取数据
    local configData = self:getConfigData()

    -- 更新加速OnOff
    local isBoostOn = configData:getIsInBoost()
    if (isBoostOn and not self._onIcon:isVisible()) then
        AvalonUtil.runBounceInAnimation(self._onIcon)
    end
    self._onIcon:setVisible(isBoostOn)
    self._offIcon:setVisible(not isBoostOn)

    -- 更新时间
    self:updateTimeRemaining()

    -- 更新加速表现
    self:setQuestOnMode(not configData:getIsQuestAvailable())
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
-- 暴露给外部, 往未加速的布局添加元素
function HomeBaseAcceleratePanel:addChildToQuestOffLayout(child)
    self._questOffLayout:addChild(child)
end

-- 暴露给外部, 往已加速的布局添加元素
function HomeBaseAcceleratePanel:addChildToQuestOnLayout(child)
    self._questOnLayout:addChild(child)
end

-- 设置加速任务是否可用, 只用于表现
function HomeBaseAcceleratePanel:setQuestOnMode(b)
    if (b) then
        self._questOnLayout:leftBottom(0, 0)
        self._questOffLayout:leftBottom(-winSize.width, -winSize.height)
    else
        self._questOffLayout:leftBottom(0, 0)
        self._questOnLayout:leftBottom(-winSize.width, -winSize.height)
    end
end

-- 从ID获取一个假物品数据, 用于表现
function HomeBaseAcceleratePanel:getDummyItemDataFromId(id)
    local goodData = GoodsDataManager:createLocalGoodsData(id) --23030001
    if goodData then
        goodData:setNum(0)
        goodData:setIsNew(false)
        goodData.isHaveGet = false
    end
    return goodData
end

-- 从ID获取拥有的物品数量
function HomeBaseAcceleratePanel:getItemAmount(id)
    local goodsNum = GoodsDataManager:getGoodsDataNum(RoleDataManager:getMasterPK(), PublicDefine.PACKET_TYPE.PACKET_BAG, id, true)
    if (id == 23020001) then
        local GameDataManager = require("app.game.GameDataManager")
        goodsNum = GameDataManager:getInstance():getCurCoin()
    elseif (id == 23030001) then
        local GameDataManager = require("app.game.GameDataManager")
        goodsNum = GameDataManager:getInstance():getDiamond()
    end
    return goodsNum or 0
end

-- 更新剩余时间表现 (任务剩余时间, 加速剩余时间)
function HomeBaseAcceleratePanel:updateTimeRemaining()
    local configData = self:getConfigData()

    -- 更新加速剩余时间
    local boostTimeRemaining = configData:getBoostTimeRemaining()
    if (configData:getIsInBoost() and boostTimeRemaining) then
        self._boostTimeIcon:show()
        self._boostTimeText:show()
        local timeText = AvalonUtil:_getFullFormatTime(boostTimeRemaining, true)
        self._boostTimeText:setText(timeText)
    else
        self._boostTimeIcon:hide()
        self._boostTimeText:hide()
    end

    -- 更新任务剩余时间
    local timeToNextQuest = configData:getTimeToNextQuest()
    if (timeToNextQuest) then
        local timeText = AvalonUtil:_getFullFormatTime(timeToNextQuest, true)
        self._questTimeText:setText(timeText)
    end

    -- 加速时间结束后刷新界面和背板动画
    if (self._boostTimeRemainingLastCheck ~= 0 and boostTimeRemaining == 0) then
        self._boostTimeRemainingLastCheck = 0
        self:updateView()
        self._hostLayer:runBoostAnimation(false)
    end
    self._boostTimeRemainingLastCheck = boostTimeRemaining

    -- 任务间隔时间结束后刷新页面
    if (self._timeToNextQuestLastCheck ~= 0 and timeToNextQuest == 0) then
        self._timeToNextQuestLastCheck = 0
        self:updateView()
    end
    self._timeToNextQuestLastCheck = timeToNextQuest
end

-- 更新道具框的背景动画
function HomeBaseAcceleratePanel:runItemFrameAnimation(loop, transition)
    if (transition) then
        self._goodFrame1:setAnimation(transition, false)
        self._goodFrame2:setAnimation(transition, false)
        self._goodFrame3:setAnimation(transition, false)
        self._goodFrame1:addAnimation(loop, true)
        self._goodFrame2:addAnimation(loop, true)
        self._goodFrame3:addAnimation(loop, true)
    else
        self._goodFrame1:setAnimation(loop, true)
        self._goodFrame2:setAnimation(loop, true)
        self._goodFrame3:setAnimation(loop, true)
    end
end

-- 需要子类重载, 获取解释文字
function HomeBaseAcceleratePanel:getDescText()
    printError("HomeBaseAcceleratePanel:getDescText 请重载")
end

-- 需要子类重载, 获取配置数据
function HomeBaseAcceleratePanel:getConfigData()
    printError("HomeBaseAcceleratePanel:getConfigData 请重载")
end

-- 需要子类重载, 加速按钮点击回调
function HomeBaseAcceleratePanel:onClickAccelerateBtn()
    printError("HomeBaseAcceleratePanel:onClickRecvBtn 请重载")
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------

-- 注册监听事件(可选)
function HomeBaseAcceleratePanel:registerListener()
end

-- 注销监听事件(可选)
function HomeBaseAcceleratePanel:unRegisterListener()
end

---------------------------------------
-- eo 事件处理 --
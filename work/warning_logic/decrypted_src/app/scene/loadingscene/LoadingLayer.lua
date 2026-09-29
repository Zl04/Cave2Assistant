--[[
    游戏加载场景
]]--

require("app.ui.Component")
require("utils.Animation.AvalonAnimation")
local LanguageManager = require("app.game.LanguageManager")

local LoadingLayer = class("LoadingLayer", UI.Component)

local size = cc.Director:getInstance():getWinSize()

local UI_AND_TRANSITION_LAYER_Z = 1000

-- 资源
local COM_RES_LIST = {
    "ui_common_information.plist",
    "ui_general_tips.plist"
}

-- CTOR
function LoadingLayer:ctor()
    print("LoadingLayer:ctor")
    LoadingLayer.super.ctor(self, UIType.LOADING, COM_RES_LIST, size.width, size.height, true)

    self._preProgress = 0   -- 表现到达点进度点
    self._progress = 0      -- 当前应该到达的进度点 
    self._waitingTime = 0   -- 剩余时间

    self._waitingRemove = false
    self._removeWaitingTime = 0
end

-- DTOR
function LoadingLayer:dtor()
    self:unregisterScriptHandler()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

-- 初始化
function LoadingLayer:init(loadingType)
    self._loadingType = loadingType
    LoadingLayer.super.init(self)

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
end

-- 初始化表现
function LoadingLayer:onInitView()
    -- 创建登录UI层(包含过度层)
    require "app.ui.UIManager"
    local uiLayer = UI.UIManager:loadLoadingUI()
    self:addChild(uiLayer, UI_AND_TRANSITION_LAYER_Z)

    print("LoadingLayer:onInitView", self._loadingType)
    if(self._loadingType == LoadingType.LoadingType_Downstairs) then
        local fireImage = UI.Image:create()
        fireImage:init("ui_information_delay4.png")
        fireImage:rightBottom(30,30)
        self:addChild(fireImage)

        local littleCricle = UI.Image:create()
        littleCricle:init("ui_information_delay3.png")
        littleCricle:rightBottom(30,30)
        self:addChild(littleCricle)
    
        local ralateAction = cc.RotateBy:create(1, 360)
        local endAction = cc.RepeatForever:create(ralateAction)
        littleCricle:runAction(endAction)
    else 
        -- 添加背景动画
        self._loadingAniamtionBack = Avalon.Animation:create("effect_ui_loading_scene_down.json", "effect_ui_loading_scene.atlas", 1);
        self._loadingAniamtionBack:setPosition(size.width/2, size.height/2)
        self._loadingAniamtionBack:setAnimation(0, "idle", true)
        self._loadingAniamtionBack:setScale(ToolsUtil:getAdaptationMaxScale())
        self:addChild(self._loadingAniamtionBack)

        -- 人物1
        self._role01 = Avalon.Animation:create("effect_ui_loading_role03.json", "effect_ui_loading_role03.atlas", 1);
        self._role01:setAnimation(0, "idle", true)
        self._role01:setPosition(-13, -25)
        self._loadingAniamtionBack:addChild(self._role01, 100)

        -- 人物2
        self._role02 = Avalon.Animation:create("effect_ui_loading_role01.json", "effect_ui_loading_role01.atlas", 1);
        self._role02:setAnimation(0, "idle", true)
        self._role02:setPosition(-120, -63)
        self._loadingAniamtionBack:addChild(self._role02, 100)

        -- 人物3
        self._role03 = Avalon.Animation:create("effect_ui_loading_role02.json", "effect_ui_loading_role02.atlas", 1);
        self._role03:setAnimation(0, "idle", true)
        self._role03:setPosition(130, -80)
        self._loadingAniamtionBack:addChild(self._role03, 100)

        -- 添加前景动画
        self._loadingAniamtionFront = Avalon.Animation:create("effect_ui_loading_scene_up.json", "effect_ui_loading_scene.atlas", 1);
        self._loadingAniamtionFront:setPosition(size.width/2, size.height/2)
        self._loadingAniamtionFront:setAnimation(0, "idle", true)
        self._loadingAniamtionFront:setScale(ToolsUtil:getAdaptationMaxScale())
        self:addChild(self._loadingAniamtionFront)

        -- 循环激活闪电特效, 随机间隔
        function recursiveRandomThunder(isFirstTime)
            local delayTime = math.random(400, 800) / 100
            if (isFirstTime) then delayTime = math.random(0, 200) / 100 end

            performWithDelay(self, function()
                self._loadingAniamtionBack:setAnimation(0, "idle2", false)
                self._loadingAniamtionBack:addAnimation(0, "idle", true)
                self._role01:setAnimation(0, "idle2", false)
                self._role01:addAnimation(0, "idle", true)
                self._role02:setAnimation(0, "idle2", false)
                self._role02:addAnimation(0, "idle", true)
                self._role03:setAnimation(0, "idle2", false)
                self._role03:addAnimation(0, "idle", true)

                recursiveRandomThunder(false)
            end, delayTime)
        end
        recursiveRandomThunder(true)

        -- 加载百分比
        local percentLabel = UI.Text:create()
        percentLabel:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_LOADING_PERCENT_TEXT)
        percentLabel:centerBottom(135)
        self:addChild(percentLabel)
        self._percentLabel = percentLabel

        -- 加载进度条背景
        local progressBg = UI.Image9:create()
        progressBg:init("ui_tips_banner_countdown_box.png", CCRectMake(0, 0, 244, 11), cc.size(643, 16))
        progressBg:centerBottom(116)
        self:addChild(progressBg)

        -- 加载进度条内容
        local progressTimer = UI.Image9:create()
        progressTimer:init("ui_tips_banner_countdown.png", CCRectMake(120,0,1,9), cc.size(642, 14))
        progressTimer:leftBottom(1, 1)
        progressBg:addChild(progressTimer)
        self._progressTimer = progressTimer

        -- 进度提示文字
        local functionLabel = UI.Text:create()
        functionLabel:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_146_211_205)
        progressBg:addChild(functionLabel, 100)
        self._functionLabel = functionLabel

        -- 温馨提示
        local tipsLabel = UI.Text:create()
        tipsLabel:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_LOADING_NOTE_TEXT)
        tipsLabel:setWidth(size.width * 2 / 3)
        tipsLabel:setTextHorizontalCenter()
        tipsLabel:autoAdapt()
        tipsLabel:centerBottom(106 - tipsLabel:getContentSize().height)
        self:addChild(tipsLabel)
        self._tipsLabel = tipsLabel

        self:triggerTips()

        -- 这里给初始化一个缓冲时间
        self:setProgress(0.2, 1)

        -- 入场效果
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.ENTER_LOADING)
    end

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

-- 帧回调
function LoadingLayer:update(dt)
    if(self._loadingType == LoadingType.LoadingType_Downstairs) then
        if(self._waitingRemove) then
            self._removeWaitingTime = self._removeWaitingTime + dt
            if(self._removeWaitingTime >= 0) then
                if(self._callBack) then
                    self._callBack()
                    self._callBack = nil
                end
                self:close()
            end
        end
    else 
        if(self._waitingTime >0) then
            local progress = self._progress - self._preProgress
            local oneProgress = progress / self._waitingTime

            self._preProgress = self._preProgress + oneProgress * dt
            self._waitingTime = self._waitingTime - dt
            if(self._waitingTime < 0) then
                self._waitingTime = 0
            end 
            if(self._preProgress > self._progress) then 
                self._preProgress = self._progress
            end

            self:setDisplayProgress(self._preProgress)
        end

        if(self._waitingTime <= 0 and self._waitingRemove) then
            self._removeWaitingTime = self._removeWaitingTime + dt
            if(self._removeWaitingTime >= 0.1 and not self._isRemoving) then
                self._isRemoving = true
                -- 出场效果
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.AFTER_LOADING, self, function()
                    if(self._callBack) then
                        self._callBack()
                        self._callBack = nil
                    end
                    if(not tolua.isnull(self))then
                        self:close()
                    end
                end)
            end
        end
    end
end

-- 等待移除
function LoadingLayer:waitingRemove(callBack)
    self._removeWaitingTime = 0
    self._callBack = callBack
    self._waitingRemove = true
end

-- 添加随机提示
function LoadingLayer:triggerTips()
    -- 触发提示语言的表现
    local tipsConfig = ConfigManager:getLoadingTips()
    if(tipsConfig and not tolua.isnull(self._tipsLabel)) then
        local index = math.random(1, tipsConfig.size)
        local data = tipsConfig[index]
        if(data) then
            self._tipsLabel:setText(LanguageManager:getInstance():getLocalString(data.description) .. "\n" .. UI.TEXT_221302)
            self._tipsLabel:autoAdapt()
            self._tipsLabel:centerBottom(106 - self._tipsLabel:getContentSize().height)
        end
    end
end

-- 设计加载进度
function LoadingLayer:setProgress(progress, time)
    self._progress = progress
    if(self._progress > 1) then
        self._progress = 1
    end 
    if(self._progress < 0) then
        self._progress = 0.01
    end 
    self._waitingTime = self._waitingTime + time
end

-- 设置加载进度表现
function LoadingLayer:setDisplayProgress(progress)
    if(self._progressTimer) then
        -- self._progressTimer:setScaleX(progress)
        self._progressTimer:setSize(642 * progress, 14)
        self._progressTimer:onUpdateView()
    end

    if(self._percentLabel) then
        progress = math.floor(progress * 100)
        self._percentLabel:setText(string.format("%s%%", progress))
    end
end

-- 更新显示逻辑
function LoadingLayer:setInfo(info)
    if (self._functionLabel) then
        self._functionLabel:setText(string.format("%s", info))
    end
end

return LoadingLayer
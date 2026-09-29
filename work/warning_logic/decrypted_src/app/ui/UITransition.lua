-- 模块初始化 --
--------------------------------------------
require "app.ui.UIDefine"
require "app.game.GameDefine"

local UI = UI or {}
local UITransition = class("UITransition",  UI.HWBtnComponent)
UI.UITransition = UITransition
local size = cc.size(CONFIG_SCREEN_WIDTH, CONFIG_SCREEN_HEIGHT)
local windowSize = cc.Director:getInstance():getWinSize()
local MASTER_SWITCH_ON = true
--------------------------------------------
-- 模块初始化 --











-- 资源 --
--------------------------------------------
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_common_scale9image.plist",
}
--------------------------------------------
-- 资源 --









-- 总入口 --
--------------------------------------------
UI.UITransitionScenarios = {
    ENTER_LOGIN = 1,
    AFTER_LOGIN = 2,
    AFTER_LOGIN_FINISH = 3,
    ENTER_CHARACTER_CREATION = 4,
    AFTER_CHARACTER_CREATION = 5,
    ENTER_LOADING = 6,
    AFTER_LOADING = 7,
    ENTER_GAME_SCENE = 8,
    AFTER_GAME_SCENE = 9,
}


-- 为某个场景做过场特效
function UITransition:runTransitionForScenario(scenario, callerSelf, callback)
    -- 总开关关闭的话, 直接回调
    if (not MASTER_SWITCH_ON) then
        performWithDelay(self, function() if (callback) then callback() end end, 0.01)
        return
    end 

    -- 根据不同的应用场景来做过场特效
    if (scenario == UI.UITransitionScenarios.ENTER_LOGIN) then
        -- 进入登录场景的特效
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_LOGIN_ANIMATION, callback)
    elseif(scenario == UI.UITransitionScenarios.AFTER_LOGIN) then
        -- 离开登录场景的特效
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_TWIRL_OUT, callback, callerSelf, 1, false, 0.8)
    elseif(scenario == UI.UITransitionScenarios.AFTER_LOGIN_FINISH) then
        -- 离开登录场景完毕时的回调
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_QUEUE_FUNC, callerSelf, callback, AvalonMessage.MC_UI_TRANSITION_TWIRL_OUT)
    elseif(scenario == UI.UITransitionScenarios.ENTER_CHARACTER_CREATION) then
        -- 进入角色创建时的特效
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN)
    elseif(scenario == UI.UITransitionScenarios.AFTER_CHARACTER_CREATION) then
        -- 离开角色创建时的特效
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_FADEOUT, callback, 0.5, nil, 0.4)
    elseif(scenario == UI.UITransitionScenarios.ENTER_LOADING) then
        -- 进入加载界面的特效
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_FADEIN, callback)
    elseif(scenario == UI.UITransitionScenarios.AFTER_LOADING) then
        -- 离开加载界面的特效
        Avalon.MessageCenter:notice(GameMessage.MC_UI_TRANSITION_FADEOUT, callback)
    elseif(scenario == UI.UITransitionScenarios.ENTER_GAME_SCENE) then
        -- 进入游戏场景时的特效
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_FADEIN, callback, nil, true)
    elseif(scenario == UI.UITransitionScenarios.AFTER_GAME_SCENE) then
        -- 离开游戏场景时的特效
        Avalon.MessageCenter:notice(GameMessage.MC_UI_TRANSITION_FADEOUT, callback)
    else
        printInfo("UITransition:runTransitionForScenario, 场特效应用场景为空", scenario, callerSelf, callback)
    end 
end
--------------------------------------------
-- 总入口 --










-- 程序逻辑 --
--------------------------------------------
-- 往动画完成回调列队中加入方法, 没有动画名
function UITransition:runOnceAfterTransition(target, func, transID)
    printInfo("UITransition:runOnceAfterTransition, 推入切换特效后执行方法", target, func, transID)
    assert(type(func) == "function", "Must be a function")

    if (not self:isInTransition(transID)) then 
        func(target)
        return
    end

    local entry = {target = target, func = func, transID = transID}
    table.insert(self._runQ, entry)
end

-- 清空回调列队
function UITransition:clearCallbacks()
    self._runQ = {}
end

-- 运行回调列队中的回调
function UITransition:runCallbacks(transID)
    if (transID == nil) then
        printInfo("UITransition:runCallbacks, 清理回调ID为空; 清理所有回调")
    end

    local i = 1
    while (i <= #self._runQ) do
        local v = self._runQ[i]
        if (v.transID == transID or transID == nil) then
            printInfo("UITransition:runCallbacks, 为切换特效运行回调, 特效ID = ", v.transID)
            table.remove(self._runQ, i)     -- 一定要先清除队列中的ID再调用方法, 因为调用回调方法可能再次调用这里
            v.func(v.target)
        end
        i = i + 1
    end
end

-- 判断是否某跳转动画在执行中, 没有名字则判断所有动画
function UITransition:isInTransition(transID)
    if(transID)then
        return self._runningStates[transID] == true and true or false
    else
        for k,v in pairs(self._runningStates) do
            if (v) then return true end
        end
        return false
    end
end

-- 渐入
function UITransition:fadeIn(callback, duration, autoRemove, callbackDelay, trueIsBlackFalseIsWhite)
    -- if (true) then performWithDelay(self, function() if (callback) then callback() end end, 0.01) return end

    -- 参数检查
    duration = duration or 0.5
    autoRemove = autoRemove ~= nil and autoRemove or false
    if (trueIsBlackFalseIsWhite == nil) then trueIsBlackFalseIsWhite = true end

    -- 开始状态
    self:changeRunningState(GameMessage.MC_UI_TRANSITION_FADEIN, true)

    -- 创建图层
    local colorLayer = UI.Image9:create()
    local pixelFileName = trueIsBlackFalseIsWhite and "ui_scale9image_black.png" or "ui_scale9image_white.png"
    colorLayer:init(pixelFileName, CCRectMake(0,0,1,1), cc.size(UI.size.width, UI.size.height))
    colorLayer:leftBottom(0, 0)
    local easeAction = cc.EaseOut:create(cc.FadeOut:create(duration), 2)
    colorLayer:runAction(cc.Sequence:create(
        easeAction,
        cc.CallFunc:create(function()
            self:changeRunningState(GameMessage.MC_UI_TRANSITION_FADEIN, false)
        end)
    ))
    self._rootLayer:addChild(colorLayer, 10)

    -- 延迟回调
    if (callbackDelay and callback) then performWithDelay(self, callback, callbackDelay) end

    -- 结束回调
    self:runOnceAfterTransition(nil, function()
        if (not callbackDelay and callback) then callback() end
        if (autoRemove and colorLayer and not tolua.isnull(colorLayer)) then colorLayer:removeFromParent() end
    end, GameMessage.MC_UI_TRANSITION_FADEIN)
end

-- 渐出
function UITransition:fadeOut(callback, duration, autoRemove, callbackDelay, trueIsBlackFalseIsWhite)
    -- 参数检查
    if tolua.isnull(self) then
        return
    end
    duration = duration or 0.5
    autoRemove = autoRemove ~= nil and autoRemove or false
    if (trueIsBlackFalseIsWhite == nil) then trueIsBlackFalseIsWhite = true end
    
    -- 开始状态
    self:changeRunningState(GameMessage.MC_UI_TRANSITION_FADEOUT, true)
    
    -- 创建图层
    local colorLayer = UI.Image9:create()
    local pixelFileName = trueIsBlackFalseIsWhite and "ui_scale9image_black.png" or "ui_scale9image_white.png"
    colorLayer:init(pixelFileName, CCRectMake(0,0,1,1), cc.size(UI.size.width, UI.size.height))
    colorLayer:setOpacity(0)
    colorLayer:leftBottom(0, 0)
    self:retain()
    local easeAction = cc.EaseIn:create(cc.FadeIn:create(duration), 2)
    colorLayer:runAction(cc.Sequence:create(
        easeAction,
        cc.CallFunc:create(function()
            if (self and not tolua.isnull(self)) then self:changeRunningState(GameMessage.MC_UI_TRANSITION_FADEOUT, false) end
            self:release()
        end)
    ))
    self._rootLayer:addChild(colorLayer, 10)

    -- 延迟回调
    if (callbackDelay and callback) then performWithDelay(self, callback, callbackDelay) end

    -- 结束回调
    self:runOnceAfterTransition(nil, function()
        if (not callbackDelay and callback) then callback() end
        if (autoRemove and colorLayer and not tolua.isnull(colorLayer)) then colorLayer:removeFromParent() end
    end, GameMessage.MC_UI_TRANSITION_FADEOUT)
end

-- 登录动画
function UITransition:enterLoginAnimation(callback)
    -- 开始状态
    self:changeRunningState(GameMessage.MC_UI_TRANSITION_LOGIN_ANIMATION, true)

    -- 创建背景
    local bg = UI.Image9:create()
    bg:init("ui_scale9image_black.png", CCRectMake(0,0,1,1), cc.size(windowSize.width, windowSize.height))
    bg:leftBottom(0, 0)
    self._rootLayer:addChild(bg, 1000000)

    -- 创建动画
    local ani = UI.Animation:create()
    ani:init("loadinggbnew_begin.json", "loadinggbnew_begin.atlas", 1)
    ani:setAnimation("idle", false)
    ani:setSize(size.width, size.height)
    ani:leftBottom(windowSize.width / 2 - 630, -30)
    ani:setTouchEnable(true)
    bg:addChild(ani)

    ani._spine:registerSpineEventHandler(function(event)
        ani:setTouchEnable(false)
        if(bg._sprite)then
            bg._sprite:setOpacity(0)
        end
        ani:runAction(cc.Sequence:create(
            cc.FadeOut:create(1.5),
            cc.CallFunc:create(function()
                self:changeRunningState(GameMessage.MC_UI_TRANSITION_LOGIN_ANIMATION, false)
            end)))
    end, 1)

    -- 注册动画音效事件
    ani._spine:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- TODO 播放音效文件
                local soundFilename = string.sub(event.eventData.name,7,-1)
                Avalon.AudioManager:playSound(soundFilename)
            end

            local shakePos = string.find(event.eventData.name, "hitshake_")
            if(shakePos ~= nil) then
                -- 播放抖动
                local shake = string.sub(event.eventData.name,10,-1)
                if(shake) then 
                    Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                end
            end
        end
    end, sp.EventType.ANIMATION_EVENT)

    -- 注册动画点击事件
    ani:addEventListener(UI.Event.COMPONENT_CLICK, self,function()
        ani:setTouchEnable(false)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_FADEOUT, function() 
            if (bg and not tolua.isnull(bg)) then 
                bg:removeFromParent() 
                bg = nil 
            end
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_FADEIN, function()
                self:changeRunningState(GameMessage.MC_UI_TRANSITION_LOGIN_ANIMATION, false)
            end, 1.5, true, nil, false)
        end, 0.15, true, nil, false)
    end)
 
    -- 结束回调
    self:runOnceAfterTransition(nil, function()
        if (callback) then callback() end
        if (bg and not tolua.isnull(bg)) then 
            bg:removeFromParent() 
            bg = nil
        end
    end, GameMessage.MC_UI_TRANSITION_LOGIN_ANIMATION)
end

-- callback 始终会被调用, 不管设定的是延迟回调还是普通切换完成回调, 用来处理一些始终在动画完成后需要处理的逻辑
function UITransition:twirlOut(callback, screenShotTarget, durationRatio, autoRemove, callbackDelayRatio)
    if tolua.isnull(self) then
        return
    end
    -- 播放音效
    Avalon.AudioManager:playSound("1044")

    -- 处理参数
    local masterDurationRatio = durationRatio
    local scaleDuration = 1.5
    local fadeoutDelay = 0.5
    local fadeoutDuration = 1.3
    local totalDuration = masterDurationRatio * fadeoutDuration + fadeoutDelay -- 用淡出做总时间

    -- 开始状态
    self:changeRunningState(GameMessage.MC_UI_TRANSITION_TWIRL_OUT, true)

    -- 黑色背景
    local black = cc.LayerColor:create(cc.c4b(0, 0, 0, 255))
    black:runAction(cc.EaseCubicActionIn:create(cc.ScaleBy:create(scaleDuration * masterDurationRatio, 30)))
    self._rootLayer:addChild(black, 1)

    -- 网格动画模板
    local grid = cc.NodeGrid:create()
    black:addChild(grid, 1)

    -- 截图
    local renderTexture = cc.RenderTexture:create(windowSize.width, windowSize.height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
    renderTexture:begin()
    screenShotTarget:visit()
    renderTexture:endToLua()
    local pic = cc.Sprite:createWithTexture(renderTexture:getSprite():getTexture())
    pic:setPosition(windowSize.width / 2, windowSize.height / 2)
    pic:setAnchorPoint(0.5, 0.5)
    pic:setScaleY(-1)
    grid:addChild(pic)

    -- 渐入边缘遮罩
    local circle = UI.Image:create()
    circle:init("ui_general_information_mask.png")
    circle:setPos(windowSize.width / 2 - circle._hw, windowSize.height / 2 - circle._hh)
    circle:setScale(8.5)
    circle:setOpacity(0)
    circle:runAction(cc.FadeIn:create(0.3 * masterDurationRatio))
    black:addChild(circle, 2)
    
    -- 旋转特效
    local twirl = cc.Twirl:create(3 * masterDurationRatio, cc.size(50, 50), cc.p(windowSize.width / 2, windowSize.height / 2), 1, 12)
    local easeTwirl = cc.EaseCubicActionIn:create(twirl)
    grid:runAction(cc.Spawn:create(easeTwirl))

    -- 放大特效
    local scaleFadeout = cc.Spawn:create(
        -- cc.EaseCubicActionIn:create(cc.ScaleBy:create(scaleDuration * masterDurationRatio, 1)),
        cc.Sequence:create(
            cc.DelayTime:create(fadeoutDelay), 
            cc.FadeOut:create(fadeoutDuration * masterDurationRatio), 
            cc.CallFunc:create(function() 
                self:changeRunningState(GameMessage.MC_UI_TRANSITION_TWIRL_OUT, false) 
            end)),
        cc.EaseCubicActionIn:create(cc.RotateBy:create(scaleDuration * masterDurationRatio, -720))
    )
    pic:runAction(cc.Sequence:create(scaleFadeout))

    -- 延迟回调
    if (callbackDelayRatio and callback) then
        performWithDelay(self._rootLayer, function()
            if (callback) then callback() end
            callback = nil
        end, callbackDelayRatio * totalDuration)
    end 

    -- 圈圈层
    local waitingHost = UI.Component:create()
    waitingHost:init()
    waitingHost:center()
    self._rootLayer:addChild(waitingHost, 2)

    -- 结束回调
    self:runOnceAfterTransition(nil, function()
        if (autoRemove) then 
            -- 如果自动移除, 就移除动画后调整动画状态
            if (black and not tolua.isnull(black)) then black:removeFromParent() end
        elseif (waitingHost and not tolua.isnull(waitingHost)) then
            -- 如果不自动移除, 就显示一个小的Loading界面避免黑屏. 并且永远不会自己主动改变动画状态.
            UI.WaitingLayer:showWaiting(true, waitingHost, GAME_NET_DELAY_OTHER, 9999)
        end
        if (callback) then callback() end
    end, GameMessage.MC_UI_TRANSITION_TWIRL_OUT)
end

-- 统一处理动画开始播放和结束播放的事件
function UITransition:changeRunningState(transitionID, state)
    self._runningStates[transitionID] = state
    if (state == false) then 
        self:runCallbacks(transitionID)
    end
end

-- 清除所有现在播放的特效并调用其回调
function UITransition:clearUITransition(clearDoneTransitionID, ...)
    printInfo("UITransition:clearUITransition 正在清除所有过场特效, 清除后的进场特效为: ", clearDoneTransitionID, ...)
    local isAnyTransitionRunning = false
    self._rootLayer:removeAllChildren()
    for k,v in pairs(self._runningStates) do
        if (v == true) then
            if (not isAnyTransitionRunning) then isAnyTransitionRunning = true end
            self:changeRunningState(k, false)
            -- self._runningStates[k] = false
            -- self:runCallbacks(k)
        end
    end

    if (isAnyTransitionRunning and clearDoneTransitionID) then
        Avalon.MessageCenter:notice(clearDoneTransitionID, ...)
    end
end
--------------------------------------------
-- 程序逻辑 --















-- 生命周期 --
--------------------------------------------
--构造函数(必备)
function UITransition:ctor(spriteID)
    --窗口大小
    UITransition.super.ctor(
        self, UIType.TRANSITION,
        COM_RES_LIST,
        UI.size.width,    
        UI.size.height
    )

    self._rootLayer = nil           --root节点
    self._runQ = {}
    self._runningStates = {}

    self:init();
    self:registerListener()
end

--虚构函数,destroy时调用(必备)
function UITransition:dtor()
    self:clearUITransition()
    UITransition.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化(必备)
function UITransition:init()
    UITransition.super.init(self)

    --root节点
    self._rootLayer = cc.Layer:create();
    self._rootLayer:setContentSize(cc.size(UI.size.width,UI.size.height))
    self._rootLayer:setPosition(cc.p(0,0))
    self:addChild(self._rootLayer)
end

-- 模版函数：初始化组建的视图(必备)
function UITransition:onInitView()
end

-- 模版函数：更新组建的视图(必备)
function UITransition:onUpdateView()
end
--------------------------------------------
-- 生命周期 --

















-- 事件处理 --
--------------------------------------------
-- 注册监听事件(可选)
function UITransition:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_FADEIN, self, self.fadeIn)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_FADEOUT, self, self.fadeOut)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_CLEAR, self, self.clearUITransition)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_QUEUE_FUNC, self, self.runOnceAfterTransition)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_LOGIN_ANIMATION, self, self.enterLoginAnimation)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_TWIRL_OUT, self, self.twirlOut)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, self, self.runTransitionForScenario)
end

-- 注销监听事件(可选)
function UITransition:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_FADEIN, self, self.fadeIn)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_FADEOUT, self, self.fadeOut)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_CLEAR, self, self.clearUITransition)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_QUEUE_FUNC, self, self.runOnceAfterTransition)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_LOGIN_ANIMATION, self, self.enterLoginAnimation)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_TWIRL_OUT, self, self.twirlOut)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, self, self.runTransitionForScenario)
end
--------------------------------------------
-- 事件处理 --

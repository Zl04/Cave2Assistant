-- FishingLayer.lua
-- Author:llf
-- 2022年3月23日
-- Using:宝石合成界面


require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local GameInManorManager = require "app.game.GameInManorManager"
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
UI = UI or {}

local FishingLayer = class("FishingLayer",UI.HWBtnComponent)
UI.FishingLayer = FishingLayer

local VOTE_SUCCEED_TIPS_PLIST = {
    "ui_town_fisihing.plist",
}

local DEBUG = false

local RESULT_COLOR = {
    fail = 0,
    success_1 = 1,
    success_2 = 2,
    success_3 = 3,
}

local viewSize = {
    x = 1136,
    y = 640
}

local bubblePreY = -152
local lineEffectPreY = -68 + 5
local FISH_PULL_DISTANCE = 0.15


local swingSpeed = 100 --抛竿时,进度条力度的速度
local updateHandler = nil

local FishingActionEnum = {
    nothing = "", --无状态
    fish_idle = "fish_idle", --装备鱼竿idle
    fish_back = "fish_back", --抛竿起手
    fish_back_idle = "fish_back_idle", --循环抛竿动作
    fish_forward = "fish_forward", --抛竿
    fish_forward_fail = "fish_forward_fail", --抛竿失败
    fishing_idle = "fishing_idle", --垂钓idle
    fish_catch = "fish_catch", --收杆（渔获）
    fish_lost = "fish_lost", --收杆（脱竿）
    fish_took_1 = "fish_took_1", --角力1
    fish_took_2 = "fish_took_2", --角力2
}

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    self:close();
end

--  构造函数
function FishingLayer:ctor()

    self._fishingType = FishingActionEnum.nothing
    
    self:initFishingValue()

    self._fishingProgressNode = nil
    self._topNode = nil

    self._fishData = {}
    self._fishColorData = {}

    self._fishHook = nil

    self._totalWidth = 454 --钓鱼跑道长度
    self._leftSide = 200 --绿条左边边界位置
    self._rightSide = 300 --绿条右边边界位置
    self._fishProgressTimer = nil
    self._bubbleAnimation = nil
    self._lineEffectAnimation = nil


    if(updateHandler == nil)  then 
        local scheduler = cc.Director:getInstance():getScheduler()
        updateHandler = scheduler:scheduleScriptFunc(handler(self, self.update), 0.0, false)
    end


    FishingLayer.super.ctor(self,UIType.MANOR_FISHING_LAYER,VOTE_SUCCEED_TIPS_PLIST, viewSize.x, viewSize.y)

    self:setTouchEnable(true)
    self:setSwallowTouches(false)

    Avalon.MessageCenter:bind(AvalonMessage.MC_CLOSE_FISHING_VIEW, self, self.onCloseView)

    -- Avalon.MessageCenter:bind(AvalonMessage.MC_CLOSE_FISHING_SUCCESS, self, self.success)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_CLOSE_FISHING_FAIL_FLEE, self, self.fail)
    Avalon.MessageCenter:bind(AvalonMessage.MC_CLOSE_FISHING_BEGINE, self, self.begine)
end

--  析构函数 调用父类的方法
function FishingLayer:dtor()
    FishingLayer.super.dtor(self)

    if (updateHandler) then
        local scheduler = cc.Director:getInstance():getScheduler()
        scheduler:unscheduleScriptEntry(updateHandler)
        updateHandler = nil
    end
   
    self._fishData = nil
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CLOSE_FISHING_VIEW, self, self.onCloseView)

    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_CLOSE_FISHING_SUCCESS, self, self.success)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_CLOSE_FISHING_FAIL_FLEE, self, self.fail)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CLOSE_FISHING_BEGINE, self, self.begine)
end

function FishingLayer:setFishingType(fType)
    self._fishingType = fType


    if self._fishingType ~= FishingActionEnum.nothing then

        local machine = MachineManager:getInstance():getMachine()
        if (machine) then
            local model = machine:getModel()
            local master = model:getMaster()
            local rendererCommand = Command.RendererCommand:create(true)
            rendererCommand:initUpdateAnimationCommand(master:getId(), AnimationType.CUSTOM, 1.0,self._fishingType)
            SceneManager:getInstance():pushCommand(rendererCommand)
        end
    end


    if self._fishingType == FishingActionEnum.fish_back then
        self:updateMasterDirection()
    end



    if self._fishingType ~= FishingActionEnum.nothing and self._fishingType ~= FishingActionEnum.fish_idle then
        self:clodeMainUI()
    else
        self:openMainUI()
    end

    self:updateFishingTimer()
end

function FishingLayer:initFishingValue()
    self._strengthPercentage = 0
    self._strengthDirection = 1
    self._plyNumber = 0 --往返次数   3次后抛竿失败
    self._localFishIntegral = 0 --评分满了之后就钓鱼成功
    self._fishingStart = false
    self._resultID = RESULT_COLOR.fail
    self._progressTimerList = {}
end

--  初始化函数 
function FishingLayer:init()
    FishingLayer.super.init(self)
end

function FishingLayer:updateFishingData()
    self._fishColorData = {}
    if self._fishData then
        for k,v in ipairs(self._fishData.colorList) do
            if v.progressTimer then
                local percent = self._strengthPercentage
                if v.endNum <= percent and percent >= v.beginNum then
                    self._fishColorData = clone(v)
                    break
                end
            end
        end
    end
end

--  初始化界面函数
function FishingLayer:onInitView()

    local fishingButton = UI.Button:create()
    fishingButton:init("ui_fishing_btn_1.png", "ui_fishing_btn_1.png", "ui_fishing_btn_1.png")
    fishingButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        local masterData = GameDataManager:getInstance():getMaster()
        if masterData:isRide() then
            return
        end

        if not GameInManorManager:getInstance():isEquipFishingWeapon(PublicDefine.EQUIPMENT_TYPE.Fish) then
            --没有鱼竿, 提示内容
            UI.Tips:createTips(UI.TEXT_221701,UI.TipsType.CONFIRM,UI.TipsUiType.NORMAL) 
            return
        end

        if GameInManorManager:getInstance():getRemainingFishingTime() <= 0 then
            --没有次数了, 提示内容
            UI.Tips:createTips(UI.TEXT_221702,UI.TipsType.CONFIRM,UI.TipsUiType.NORMAL)
            return
        end

        if(GameDataManager:getInstance():getFreePacketBoxNum() == 0) then 
            --背包已满，请先清理 
            UI.ScrollBar:createByText(UI.TEXT_1212011)
            return
        end

        if self._fishingType == FishingActionEnum.nothing or self._fishingType == FishingActionEnum.fish_idle then
            self:initFishingValue()
            self._fishData = GameInManorManager:getInstance():getFishingData()
            self:createFishingProgress()
            if self._fishingType == FishingActionEnum.nothing then
                --换装
                local masterData = RoleDataManager:getMaster()
                local heroSpriteId = masterData:getSpriteID()
                GameInManorManager:getInstance():updateChangeFishingWeapon(heroSpriteId,true)
            end

            --状态改变
            self:setFishingType(FishingActionEnum.fish_back)

            Avalon.Scheduler:scheduleUpdateOnce(self, function()
                self:setFishingType(FishingActionEnum.fish_back_idle)
            end,0.3)
        elseif self._fishingType == FishingActionEnum.fish_back or self._fishingType == FishingActionEnum.fish_back_idle then


            for k,v in ipairs(self._fishData.colorList) do
                if v.progressTimer and v.progressTimer:isVisible() then
                    self._resultID = v.color
                    break
                end
            end
            
            self:updateFishingData()
            self:removeFishingProgress()
            self:setFishingType(FishingActionEnum.fish_forward)
            self:gameStart()


            Avalon.Scheduler:scheduleUpdateOnce(self, function()
                self:setFishingType(FishingActionEnum.fishing_idle)
            end,0.5)

            -- local rTime = math.random(2, 3)
            -- Avalon.Scheduler:scheduleUpdateOnce(self, function()
            --     --上面的界面掉下来
            --     self:createTopPanel()
            -- end,0.56 + rTime)


        elseif self._fishingStart then
            if math.random(1,2) <=1 then
                self:setFishingType(FishingActionEnum.fish_took_1)
            else
                self:setFishingType(FishingActionEnum.fish_took_2)
            end

            self:perTimePullFishHookMove()
        end
    end)
    fishingButton:center(0,150)
    self:addChild(fishingButton)

    --钓鱼剩余次数
    self:createFishingTimer()

end

function FishingLayer:createFishingTimer()
    self._timerBg = UI.Image:create()
    self._timerBg:init("ui_fishing_bg_5.png")
    self._timerBg:center(0,230)
    self:addChild(self._timerBg)

    local str = AvalonUtil:serializeText(UI.TEXT_221703, {r = 174, g = 174, b = 174}, UI.FONT_SIZE_20PX, UI.FONT_BOLD)
    str = str .. AvalonUtil:serializeText(tostring(GameInManorManager:getInstance():getRemainingFishingTime()), {r = 230, g = 198, b = 87}, UI.FONT_SIZE_20PX, UI.FONT_BOLD)
    self._timerLabel = UI.RichText:create()
	self._timerLabel:init(str,nil, nil, true)
	self._timerLabel:center()
	self._timerBg:addChild(self._timerLabel)
end

function FishingLayer:updateFishingTimer()
    if self._timerBg then
        if self._fishingType == FishingActionEnum.nothing or self._fishingType == FishingActionEnum.fish_idle then
            self._timerBg:show()
        else
            self._timerBg:hide()
        end
    end

    if self._timerLabel and self._timerBg then
        self._timerLabel:removeFromParent()
        self._timerLabel = nil

        local str = AvalonUtil:serializeText(UI.TEXT_221703, {r = 174, g = 174, b = 174}, UI.FONT_SIZE_20PX, UI.FONT_BOLD)
        str = str .. AvalonUtil:serializeText(tostring(GameInManorManager:getInstance():getRemainingFishingTime()), {r = 230, g = 198, b = 87}, UI.FONT_SIZE_20PX, UI.FONT_BOLD)
        
        self._timerLabel = UI.RichText:create()
        self._timerLabel:init(str,nil, nil, true)
        self._timerLabel:center()
        self._timerBg:addChild(self._timerLabel)
    end
end


function FishingLayer:createTopPanel()
    if self._topNode then
        self._topNode:removeFromParent()
        self._topNode = nil
    end

    self._topNode = UI.Layout:create();
    self._topNode:init()
    self._topNode:setSize(601,313)
    self._topNode:center(0, -340)
    self._topNode:setScale(0.8)
    self:addChild(self._topNode)

    local topBg = UI.Image:create();
    topBg:init("ui_fishing_bg_4.png");
    topBg:center();
    self._topNode:addChild(topBg)

    local fishBg = UI.Image:create();
    fishBg:init("ui_fishing_big_line.png");
    fishBg:center(-5,-5);
    self._topNode:addChild(fishBg)


    self._fishProgressTimer = UI.ProgressTimer:create()
    self._fishProgressTimer:init(nil, "ui_fishing_big_article.png", "ui_fishing_big_article.png")
    self._fishProgressTimer:center(-2,-1)
    fishBg:addChild(self._fishProgressTimer, -10)
    self._fishProgressTimer:setPercent(0)
    self._fishProgressTimer:setMidpoint(cc.p(1,0))
    self._fishProgressTimer:setBarChangeRate(cc.p(0,1))


    local bubbleAnimation = UI.Animation:create()
    bubbleAnimation:init("effect_ui_fish_bubble.json", "effect_ui_fish_bubble.atlas", 1.0)
    bubbleAnimation:setAnimation("idle", true)
    bubbleAnimation:setPosition(0,bubblePreY)
    self._bubbleAnimation = bubbleAnimation

    local lineEffectAnimation = UI.Animation:create()
    lineEffectAnimation:init("effect_ui_fish_active.json", "effect_ui_fish_active.atlas", 1.0)
    lineEffectAnimation:setAnimation("idle", true)
    lineEffectAnimation:setPosition(0,lineEffectPreY)
    lineEffectAnimation:setOpacity(0)
    self._lineEffectAnimation = lineEffectAnimation

    local ckipperSprite = cc.Sprite:createWithSpriteFrameName("ui_fishing_big_white.png")
    local clipper = cc.ClippingNode:create(ckipperSprite)
    clipper:addChild(bubbleAnimation)
    clipper:addChild(lineEffectAnimation)

    clipper:setInverted(false);
    clipper:setAlphaThreshold(0.5);
    clipper:setPosition(fishBg:getContentSize().width / 2 + 2, fishBg:getContentSize().height / 2);
    fishBg:addChild(clipper, -5)



    local grooveBg = UI.Image:create();
    grooveBg:init("ui_fishing_bg_line.png");
    grooveBg:centerBottom(56);
    topBg:addChild(grooveBg)

    local scheduleWidth = self._fishData.finalPixel
    local greenBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_fishing_bg_nine.png");
    greenBg:setContentSize(cc.size(scheduleWidth, 29));
    greenBg:setCapInsets(CCRectMake(28, 10, 1, 1))
    greenBg:setPosition(grooveBg:getContentSize().width / 2, grooveBg:getContentSize().height / 2);
    grooveBg:addChild(greenBg);

    self._fishHook = UI.Image:create();
    self._fishHook:init("ui_fishing_btn_bait.png");
    self._fishHook:center();
    grooveBg:addChild(self._fishHook);

    self._leftSide = greenBg:getPositionX() - scheduleWidth / 2;
    self._rightSide = greenBg:getPositionX() + scheduleWidth / 2;

    if (DEBUG) then
        print("    self._leftSide ====== ",self._leftSide, self._rightSide, self._fishHook:getPositionX() + self._fishHook:getContentSize().width / 2)
    end

    self._topNode:runAction(cc.Sequence:create(
        cc.EaseBackOut:create(cc.MoveBy:create(0.3, cc.p(0,-150))),
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function()
            self._fishingStart = true
            if math.random(1,2) <=1 then
                self:setFishingType(FishingActionEnum.fish_took_1)
            else
                self:setFishingType(FishingActionEnum.fish_took_2)
            end

            self:perTimeFishHookMove()

        end)))

end

function FishingLayer:removeTopPanel()

    if self._fishHook then
        self._fishHook:stopAllActions()
        self._fishHook:removeFromParent()
        self._fishHook = nil
    end

    if self._topNode then
        self._topNode:stopAllActions()
    end

    self._topNode:runAction(cc.Sequence:create(
        cc.EaseBackOut:create(cc.MoveBy:create(0.3, cc.p(0,350))),
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function()
            
            if self._bubbleAnimation then 
                self._bubbleAnimation:removeFromParent()
                self._bubbleAnimation = nil
            end
        
            if self._lineEffectAnimation then
                self._lineEffectAnimation:removeFromParent()
                self._lineEffectAnimation = nil
            end
        
            if self._fishProgressTimer then
                self._fishProgressTimer:removeFromParent()
                self._fishProgressTimer = nil
            end
        
            if self._topNode then
                self._topNode:removeFromParent()
                self._topNode = nil
            end
        end)))
end

function FishingLayer:createFishingProgress()
    self:removeFishingProgress()

    self._fishingProgressNode = UI.Layout:create();
    self._fishingProgressNode:init()
    self._fishingProgressNode:setSize(194, 74)
    self._fishingProgressNode:center(0, 170)
    self:addChild(self._fishingProgressNode)

    local progressTimerBg = UI.Image:create();
    progressTimerBg:init("ui_fishing_progress_bg.png");
    progressTimerBg:center();
    progressTimerBg:setRotation(-60)
    self._fishingProgressNode:addChild(progressTimerBg)

    for k,v in ipairs(self._fishData.colorList) do
        local progressTimer = UI.ProgressTimer:create()
        local progress = "ui_fishing_progress_red.png"
        if v.color == 1 then
            progress = "ui_fishing_progress_red.png"
        elseif v.color == 2 then
            progress = "ui_fishing_progress_yellow.png"
        elseif v.color == 3 then
            progress = "ui_fishing_progress_green.png"
        end
        progressTimer:init(nil, progress, progress,UI.ProgressTimerType.RADIAL)
        progressTimer:center()
        progressTimer:setRotation(-60)
        self._fishingProgressNode:addChild(progressTimer, 200 - k)
        progressTimer:setPercent(0)

        v.progressTimer = progressTimer
    end
end

function FishingLayer:removeFishingProgress()
    if self._fishingProgressNode then
        self._fishingProgressNode:removeFromParent()
        self._fishingProgressNode = nil
    end

    if self._fishData and self._fishData.colorList then
        for k,v in ipairs(self._fishData.colorList) do
            v.progressTimer = nil
        end
    end
end

function FishingLayer:perTimeFishHookMove()
    --鱼儿每次移动的行为
    if self._fishingStart and self._fishHook then
        local timeInterval = 1.5
        local fishDistance = 0.5 * self._totalWidth
        if self._fishColorData and self._fishColorData.leftTimeInterval then
            timeInterval = math.random(self._fishColorData.leftTimeInterval, self._fishColorData.rightTimeInterval) / 1000
            fishDistance = math.random(self._fishColorData.leftDistance, self._fishColorData.rightDistance) / 10000 * self._totalWidth
        end

        self._fishHook:runAction(cc.Sequence:create(
            cc.MoveBy:create(timeInterval, cc.p(fishDistance,0)),
            cc.CallFunc:create(function()
               self:perTimeFishHookMove()
            end)))
    end
end

function FishingLayer:perTimePullFishHookMove()
    --每次拉动鱼竿,位移的距离
    if self._fishingStart and self._fishHook then
        local offsetX = self._totalWidth * FISH_PULL_DISTANCE
        self._fishHook:runAction(cc.MoveBy:create(0.075, cc.p(-offsetX,0)))
    end
end


function FishingLayer:update(dt)

    if (self._fishingType == FishingActionEnum.fish_back_idle or self._fishingType == FishingActionEnum.fish_back) and not self._fishingStart then
        if self._strengthPercentage > 120 then
            self._strengthDirection = -1
            self._strengthPercentage = 120
        elseif self._strengthPercentage < 0 then
            self._plyNumber = self._plyNumber + 1
            self._strengthDirection = 1
            self._strengthPercentage = 0
        end

        self._strengthPercentage = self._strengthPercentage + dt * self._strengthDirection * swingSpeed

        for k,v in ipairs(self._fishData.colorList) do
            if not tolua.isnull(v.progressTimer) then

                local percent = self._strengthPercentage
                if v.endNum <= percent then
                    percent = v.endNum
                end

                local viewPercent = self._strengthPercentage
                if viewPercent >= 120 then
                    viewPercent = 120
                end

                if v.beginNum <= viewPercent and v.endNum >= viewPercent then
                    v.progressTimer:setVisible(true)
                else
                    v.progressTimer:setVisible(false)
                end

                v.progressTimer:setPercent(percent / 360)
            end
        end

        if self._plyNumber >= 3 then
            self._strengthPercentage = 0
            self._plyNumber = 0
            self:removeFishingProgress()
            self:setFishingType(FishingActionEnum.fish_forward_fail)

            Avalon.Scheduler:scheduleUpdateOnce(self, function()
                self:setFishingType(FishingActionEnum.fish_idle)
            end,0.12)
            
        end

    end


    if self._fishingStart and self._fishHook then

        local x = self._fishHook:getPositionX() + self._fishHook:getContentSize().width / 2;

        if (self._leftSide <= x and self._rightSide >= x) then
            self._localFishIntegral = self._localFishIntegral + self._fishData.preAddEnergy

            if self._fishProgressTimer then

                local perrcentValue = self._localFishIntegral / self._fishData.totalEnergy

                self._fishProgressTimer:setPercent(perrcentValue)

                if self._lineEffectAnimation then
                    self._lineEffectAnimation:setPositionY(lineEffectPreY + 124 * perrcentValue)
                    self._lineEffectAnimation:stopAllActions()
                    self._lineEffectAnimation:setOpacity(255)
                    self._lineEffectAnimation:runAction(cc.FadeTo:create(0.3,0))
                end

                if self._bubbleAnimation then
                    self._bubbleAnimation:setPositionY(bubblePreY + 124 * perrcentValue)
                end
            end
        end

        if self._localFishIntegral >= self._fishData.totalEnergy then
            if (DEBUG) then
                print("钓鱼成功")
            end
            self:success()
        elseif x < 0 or x > self._totalWidth then
            if (DEBUG) then
                print("钓鱼失败")
            end
            self:failFlee()
        end
    end
end

function FishingLayer:updateMasterDirection()
    local machine = MachineManager:getInstance():getMachine()
    if (machine) then
        local model = machine:getModel()
        local master = model:getMaster()
        local coord = master:getCoord()
        local direction = model:getFishDirection(coord.x,coord.y)

        if direction == 1 then
            direction = DirectionType.EAST
        else
            direction = DirectionType.WEAST
        end

        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initUpdateDirectionCommand(master:getId(), direction)
        SceneManager:getInstance():pushCommand(directionCommand)
    end
end

function FishingLayer:gameStart()
    --开始钓鱼 (向服务器发消息)

    local machine = MachineManager:getInstance():getMachine()
    if (machine) then
        local model = machine:getModel()
        local master = model:getMaster()
        local coord = master:getCoord()
        local spriteID = model:getFishNpcSpriteIdForCoord(coord.x,coord.y)
        Net.NetManorSystem:reqFishingBegine(spriteID)
    end
end

function FishingLayer:begine()
    

    local rTime = math.random(2, 3)
    Avalon.Scheduler:scheduleUpdateOnce(self, function()
        --上面的界面掉下来
        self:createTopPanel()
    end,0.56 + rTime)
end

function FishingLayer:success()
    --成功

    local machine = MachineManager:getInstance():getMachine()
    if (machine) then
        local model = machine:getModel()
        local master = model:getMaster()
        local coord = master:getCoord()
        local spriteID = model:getFishNpcSpriteIdForCoord(coord.x,coord.y)
        Net.NetManorSystem:reqFishingResult(self._resultID, spriteID)
    end
    

    self:removeTopPanel()
    self:initFishingValue()

    self:setFishingType(FishingActionEnum.fish_catch)
    Avalon.Scheduler:scheduleUpdateOnce(self, function()
        self:setFishingType(FishingActionEnum.fish_idle)
    end,1.06)

end

function FishingLayer:failFlee()
    self._resultID = RESULT_COLOR.fail

    local machine = MachineManager:getInstance():getMachine()
    if (machine) then
        local model = machine:getModel()
        local master = model:getMaster()
        local coord = master:getCoord()
        local spriteID = model:getFishNpcSpriteIdForCoord(coord.x,coord.y)
        Net.NetManorSystem:reqFishingResult(self._resultID, spriteID)
    end

    --鱼儿逃跑
    self:removeTopPanel()
    self:initFishingValue()

    self:setFishingType(FishingActionEnum.fish_lost)
    Avalon.Scheduler:scheduleUpdateOnce(self, function()
        self:setFishingType(FishingActionEnum.fish_idle)
    end,1.55)
end

function FishingLayer:clodeMainUI()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_BAG_BUTTON)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
    self:setSwallowTouches(true)
end

function FishingLayer:openMainUI()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_BAG_BUTTON)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER)
    self:setSwallowTouches(false)
end


function FishingLayer:onCloseView()

    --离开钓鱼,还原成武器表现
    local masterData = RoleDataManager:getMaster()
    local heroSpriteId = masterData:getSpriteID()
    GameInManorManager:getInstance():updateChangeFishingWeapon(heroSpriteId,false)

    self:openMainUI()
    self:removeFromParent()
end


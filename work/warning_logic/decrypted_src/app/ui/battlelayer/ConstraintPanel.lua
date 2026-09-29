-- ConstraintPanel.lua
-- Author:ydli
-- 2019年12月27日
-- Using:束缚界面

local winSize = cc.Director:getInstance():getWinSize()

UI = UI or {}

local ConstraintPanel = class("ConstraintPanel", UI.HWBtnComponent)
UI.ConstraintPanel = ConstraintPanel

local POWER_MAX = 1000
local POWER_DEL_PER_SCEOND = 60
local POWER_ADD_PER_CLICK = 60

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
-- 资源
local COM_RES_LIST = {
}


-- 构造函数
function ConstraintPanel:ctor()
    ConstraintPanel.super.ctor(self, 0, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.curPower = 0
    self.totalDt = 0
    self.isMax = false
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:init()
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end


-- 析构函数
function ConstraintPanel:dtor()
    ConstraintPanel.super.dtor(self) 
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    reload_script_file("app.ui.battlelayer.ConstraintPanel")
end


-- public:
-- 初始化
function ConstraintPanel:init()
    ConstraintPanel.super.init(self)
end

function ConstraintPanel:update(dt)
    self.totalDt = self.totalDt + dt
    self.curPower = self.curPower - POWER_DEL_PER_SCEOND * dt
    self.curPower = self.curPower < 0 and 0 or self.curPower
    if self.totalDt >= 0.05 then
        self.totalDt = 0
        local showNum = self.curPower < 0 and 0 or self.curPower
        if not tolua.isnull(self.progress) then
            self.progress:setPercentage(showNum / POWER_MAX * 100)
        end
    end
end

-- 初始化视图
function ConstraintPanel:onInitView()
     -- 添加一个半透明背景
    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,0))
    blackBg:setContentSize(winSize.width, winSize.height)
    self:addChild(blackBg)

    local bg  = UI.Image:create()
    bg:init("ui_distortedspace_gaming_struggle_bg.png")
    bg:centerBottom(100)
    self:addChild(bg, 10)

    local tip = UI.Text:create()
    tip:init(UI.TEXT_1213820, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_170_170_170)
    tip:setWidth(310)
    tip:autoAdapt()
    tip:setLineSpacing(-8)
    tip:setTextLeftUp()
    tip:leftBottom(120, 90)
    bg:addChild(tip, 20)

    local animtion = UI.Animation:create()
    animtion:init("effect_ui_gaming_jiechu.json", "effect_ui_gaming_jiechu.atlas", 1);
    animtion:leftBottom(66, 64)
    bg:addChild(animtion, 20)
    animtion:setAnimation("idle", true)
    self.animtion = animtion
    animtion:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(_, event, sender)
        if(event and event.animation == "jiechu") then
            self:close()
        end
    end)
    animtion:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData and event.eventData.name == "jiechu") then
            self.progress:removeFromParent()
        end
    end)


    local progressbg = UI.Image:create()
    progressbg:init("ui_distortedspace_gaming_struggle_progressbar_0.png")
    progressbg:leftBottom(115, 50)
    bg:addChild(progressbg, 10)

     --progress
    local  progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_distortedspace_gaming_struggle_progressbar_1.png"))
    progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    progress:setMidpoint(cc.p(0, 0))
    progress:setBarChangeRate(cc.p(1, 0))
    progress:setPercentage(0)
    progress:setAnchorPoint(0, 0)
    progress:setPosition(1, 1)
    progressbg:addChild(progress)
    self.progress = progress


    --button
    local addbutton = UI.Layout:create()
    addbutton:init()
    addbutton:setSize(80, 80)
    addbutton:leftBottom(-40, -36)
    addbutton:setTouchEnable(true)
    addbutton:addEventListener(UIEvent.COMPONENT_CLICK,self, self.onAddClick)
    animtion:addChild(addbutton, 10)

    local tips2 = UI.Text:create()
    tips2:init(UI.TEXT_111118, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    tips2:setWidth(80)
    tips2:autoAdapt()
    tips2:setLineSpacing(-8)
    tips2:setTextCenter()
    tips2:center()
    addbutton:addChild(tips2, 20)
end

function ConstraintPanel:onAddClick()
    self.curPower = self.curPower + POWER_ADD_PER_CLICK
    local showNum = self.curPower < 0 and 0 or self.curPower
    if tolua.isnull(self.progress) or self.isMax then
        return
    end
    self.progress:setPercentage(showNum / POWER_MAX * 100)
    if self.animtion then
        self.animtion:setAnimation("click", false)
        self.animtion:addAnimation("idle", true)
    end
    if self.curPower >= POWER_MAX then
        self.isMax = true
        Net.NetRoleSystem:reqCancleConstrait()
        self.animtion:setAnimation("jiechu", false)
    end
end





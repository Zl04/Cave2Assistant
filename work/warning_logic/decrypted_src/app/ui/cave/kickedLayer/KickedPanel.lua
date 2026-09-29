
-- KickedPanel.lua
-- Author:zp
-- 2017年8月2日
-- Using:被踢出队伍，即将进入小黑屋

local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local KickedPanel = class("KickedPanel", UI.HWBtnComponent)
UI.KickedPanel = KickedPanel

local winSize = cc.Director:getInstance():getWinSize()

-- 资源文件
local COM_RES_LIST = {

}

function KickedPanel:refreshTime(dt)
    if self.endCallback then
        self.endCallback(self)
        return
    end
    -- 处理倒计时
    if(self._countDown == 0) then 
        --  处理相关的逻辑代码
        SceneManager:getInstance():leaveWaiting()
    end
end


function KickedPanel:ctor(kickType, endCallback)
    KickedPanel.super.ctor(self, UIType.KICKED_PANEL, COM_RES_LIST, winSize.width, winSize.height)
    self.kickType = kickType
    self.tipsStr = ""
    self.endCallback = endCallback

    if(kickType == KICK_OUT_TYPE.KICK_OUT_TYPE_KICK 
        or kickType == KICK_OUT_TYPE.KICK_OUT_TYPE_END_GUILD_BOSS) then
        self._countDown = 5
        self.tipsStr = LanguageManager:getInstance():getLocalString(1110417)
    else 
        self._countDown = 10
        self.tipsStr = LanguageManager:getInstance():getLocalString(1111667)
    end
    
    Avalon.Scheduler:scheduleUpdate(self, self.refreshTime)
end

function KickedPanel:dtor()
    KickedPanel.super.dtor(self)

    Avalon.Scheduler:unscheduleUpdate(self, self.refreshTime)
end

-- public:
-- 初始化
function KickedPanel:init()
    self:setInterceptTouches(true)
    self:setTouchEnable(true)

    KickedPanel.super.init(self)
end

-- 模版函数：初始化组建的视图
function KickedPanel:onInitView()
    -- 显示被踢的相关的界面
    local slotAnimation = Avalon.Animation:create("effect_ui_gaming_count_dead.json", "effect_ui_gaming_count_dead.atlas", 1);
    slotAnimation:setAnimation(0, "idle2", true)
    self:addChild(slotAnimation)
    slotAnimation:setPosition(cc.p(winSize.width/2, winSize.height /2+ 100))
    self._slotAnimation = slotAnimation

    -- 添加提示文字
    local labelName = UI.Text:create()
    labelName:init(self.tipsStr, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_255_255_255)
    labelName:setOutline(UI.FONT_COLOR_BLACK)
    labelName:centerUp(winSize.height/2-200)
    self:addChild(labelName, 1)

    -- 添加挂载点
    local countTimeLabel = cc.LabelAtlas:create(string.format("%d",self._countDown), "ui_dead_number.png", 80, 120, 48)
    countTimeLabel:setAnchorPoint(cc.p(0.5, 0.5))
    slotAnimation:addComponent("count-dead-number1", countTimeLabel)

    Avalon.AudioManager:playSound("506")
    
    local this = self
    slotAnimation:registerSpineEventHandler(function (event)
        print(string.format("[spine] %d complete: %d", 
                                event.trackIndex, 
                                event.loopCount))
        if(self._countDown > 0) then                            
            self._countDown = self._countDown - 1

            Avalon.AudioManager:playSound("506")
        end
        
        -- 更新倒计时显示
        countTimeLabel:setString(string.format("%d",self._countDown))

    end, sp.EventType.ANIMATION_COMPLETE)
end
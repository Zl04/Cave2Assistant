------------------------------------------------------------------------------
--author: 
--date	: 2019/08/14
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ApprenticeshipMentorResultDailyView = class("ApprenticeshipMentorResultDailyView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ApprenticeshipMentorResultDailyView:ctor(apprenticeIdx)
    self._apprenticeIdx = apprenticeIdx
    ApprenticeshipMentorResultDailyView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ApprenticeshipMentorResultDailyView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.apprenticeship", "Apprenticeship", false)
    ApprenticeshipMentorResultDailyView.super.init(self, ... )
    self:center()
end

function ApprenticeshipMentorResultDailyView:dtor()
    ApprenticeshipMentorResultDailyView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.apprenticeship.ApprenticeshipMentorResultDailyView")
end


function ApprenticeshipMentorResultDailyView:onInitView()
------程序生成区块开始 node_1368294785_1565319536-------
    local node_1368294785_1565319536 = UI.Layout:create()
    node_1368294785_1565319536:init()
    node_1368294785_1565319536:setSize(671, 444)
    node_1368294785_1565319536.__uiComposerID = "1368294785_1565319536"
    addChildAuto(self._layoutUU, self, node_1368294785_1565319536, "layout_1368294785_1565319536")
------程序生成区块结束 node_1368294785_1565319536-------
------程序生成区块开始 node_551410630_1565543164-------
    local node_551410630_1565543164 = UI.Image:create()
    node_551410630_1565543164:init('ui_mentor_bg_paper_up.png')
    node_551410630_1565543164.__uiComposerID = "551410630_1565543164"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_551410630_1565543164, "layout_551410630_1565543164")
------程序生成区块结束 node_551410630_1565543164-------
------程序生成区块开始 node_1553871489_1565710967-------
    local node_1553871489_1565710967 = UI.Animation:create()
    node_1553871489_1565710967:init("effect_ui_general_mentor_baoxiang.json", "effect_ui_general_mentor_baoxiang.atlas", 1);
    node_1553871489_1565710967:setAnimation("idle", true)
    node_1553871489_1565710967:setSize(120, 120)
    node_1553871489_1565710967.__uiComposerID = "1553871489_1565710967"
    addChildAuto(self._layoutUU, node_551410630_1565543164, node_1553871489_1565710967, "layout_1553871489_1565710967")
    self._aniReward = node_1553871489_1565710967 -- 暴露名字至self
    node_1553871489_1565710967:setTouchEnable(true)
    node_1553871489_1565710967:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        node_1553871489_1565710967:stopAllActions()
        node_1553871489_1565710967:runAction(cc.ScaleTo:create(0.1, 1.2))
    end)
    node_1553871489_1565710967:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        node_1553871489_1565710967:stopAllActions()
        node_1553871489_1565710967:runAction(cc.ScaleTo:create(0.1, 1))
        node_1553871489_1565710967:setAnimation("idle2", false)
        node_1553871489_1565710967:addAnimation("idle", true)
    end)
    node_1553871489_1565710967:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        local timeNow = GameManager:getNormalServerTime()
        if (self._nextRewardTime and self._nextRewardTime > timeNow) then return end
        self._nextRewardTime = GameManager:getNormalServerTime() + 1

        mvc.apprenticeshipController:mentorGetDailyRewardByIndex(self._apprenticeIdx)
    end)

    node_1553871489_1565710967:addEventListener(UIEvent.ANIMATION_END,self,function(this, event)
        local startPos = string.find(event.animation, "idle2")
        if (startPos ~= nil) then
            if (not mvc.apprenticeshipModel:mentorIsApprenticeAbleToGetQuestRewardByIndex(self._apprenticeIdx)) then
                self._aniReward:setTouchEnable(false)
                self._aniReward:restore()
                self._aniReward:setTimeScale(0)
                self._aniReward:playTransFormGray(0, true)
            end
        end
    end)


------程序生成区块结束 node_1553871489_1565710967-------
------程序生成区块开始 node_360886938_1565319643-------
local node_360886938_1565319643 = UI.Text:create()
    node_360886938_1565319643:init(LanguageManager:getInstance():getLocalString(1112672) --[["你的学员已经完成了今日的任务\n快领取你的奖励吧!"]], UI.FONT_STANDARD, 16, {r = 41, g = 41, b = 45})
    node_360886938_1565319643:setWidth(350)
    node_360886938_1565319643:autoAdapt()
    node_360886938_1565319643.__uiComposerID = "360886938_1565319643"
    addChildAuto(self._layoutUU, node_1368294785_1565319536, node_360886938_1565319643, "layout_360886938_1565319643")
------程序生成区块结束 node_360886938_1565319643-------
end

function ApprenticeshipMentorResultDailyView:onUpdateView()
    if (mvc.apprenticeshipModel:mentorIsApprenticeAbleToGetQuestRewardByIndex(self._apprenticeIdx)) then
        self._aniReward:setTouchEnable(true)
        self._aniReward:setTimeScale(1)
        self._aniReward:playTransFormGray(0, false)
        self._aniReward:restore()

    else
        if(self._aniReward:getAnimationName(0) == "idle") then 
            self._aniReward:setTouchEnable(false)
            self._aniReward:restore()
            self._aniReward:setTimeScale(0)
            self._aniReward:playTransFormGray(0, true)
        end
    end
end

function ApprenticeshipMentorResultDailyView:bindModel()

end


function ApprenticeshipMentorResultDailyView:unbindModel()

end





return ApprenticeshipMentorResultDailyView













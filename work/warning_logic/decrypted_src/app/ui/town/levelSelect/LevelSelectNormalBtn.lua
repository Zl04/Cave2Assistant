-- LevelSelectNormalBtn.lua
-- Author:ydli
-- 2018年12月27日
-- Using:关卡选择界面btn 


UI = UI or {}
require("app.ui.town.levelSelect.LevelSelectBtn")
local LevelSelectNormalBtn = class("LevelSelectNormalBtn", UI.LevelSelectBtn)
UI.LevelSelectNormalBtn = LevelSelectNormalBtn

function LevelSelectNormalBtn:ctor()
    LevelSelectNormalBtn.super.ctor(self)
end

function LevelSelectNormalBtn:dtor()
    LevelSelectNormalBtn.super.dtor(self)
end

-- public:
-- 初始化
function LevelSelectNormalBtn:init(spineName)
    LevelSelectNormalBtn.super.init(self)
    self:changeSkin(spineName)
end

-- 模版函数：初始化组建的视图
function LevelSelectNormalBtn:onInitView()

end

-- 模版函数：更新组建的视图
function LevelSelectNormalBtn:onUpdateView()
    LevelSelectNormalBtn.super.onUpdateView(self)
end


function LevelSelectNormalBtn:lock()
    self.spineIcon:setToSetupPose()
    self.spineIcon:setAnimation("idle1",false)
    self:setBtnState(SpineIconStatus.locked)
end

function LevelSelectNormalBtn:waitUnLock()
    self.spineIcon:setToSetupPose()
    self.spineIcon:setAnimation("start1",true)
    self:setBtnState(SpineIconStatus.waitUnLock)
end

function LevelSelectNormalBtn:unLocked()
    self.spineIcon:setToSetupPose()
    self.spineIcon:setAnimation("idle2",false)
    self:setBtnState(SpineIconStatus.haveUnLocked)
end

function LevelSelectNormalBtn:selected()
    self.spineIcon:setToSetupPose()
    self.spineIcon:setAnimation("start3",false)
    self:setBtnState(SpineIconStatus.selected)
end

function LevelSelectNormalBtn:showStartAnimation()
    self.spineIcon:setToSetupPose()
    self.spineIcon:setAnimation("start2", false)
    Avalon.AudioManager:playSound("1521")
end

function LevelSelectNormalBtn:showStepEndAnimation()
    self.spineIcon:setToSetupPose()
    self.spineIcon:setAnimation("showup",false)
    self.spineIcon:addAnimation("idle2",true) 
end

--[[切换按钮外表]]
function LevelSelectNormalBtn:changeSkin(spineName)
    if self.spineName == spineName then
        return
    end
    if self.spineIcon then
        self.spineIcon:removeFromParent()
    end
    self.spineName = spineName
    local spineIcon = UI.Animation:create()
    spineIcon:init(string.format("%s.json", spineName), string.format("%s.atlas", spineName), 1)
    spineIcon:setTouchEnable(true)
    spineIcon:setSwallowTouches(false)
    spineIcon:setClickAudioEnable(true)
    spineIcon:center()
    self:addChild(spineIcon)

    self.spineIcon = spineIcon
    self.spineIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function(sender, _, _, touchPosition)
        if self.clickCallback and self.isEnable then
            self:clickCallback(touchPosition)
        end
    end)
    self.spineIcon:addEventListener(UIEvent.ANIMATION_END,self, function(self, event, obj)
        if self.animationEndCallback then
            self:animationEndCallback(event, obj)
        end
    end)

    self.spineIcon:addEventListener(UIEvent.ANIMATION_START,self, function(self, event, obj)
        if self.animationStartCallback then
            self:animationStartCallback(event, obj)
        end
    end)

    if self.state == SpineIconStatus.locked then
        self:lock()
    elseif self.state == SpineIconStatus.waitUnLock then
        self:waitUnLock()
    elseif self.state == SpineIconStatus.haveUnLocked then
        self:unLocked()
    elseif self.state == SpineIconStatus.selected then
        self:selected()
    else

    end
end

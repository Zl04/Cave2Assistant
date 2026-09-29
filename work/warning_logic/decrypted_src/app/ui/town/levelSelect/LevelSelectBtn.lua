-- LevelSelectBtn.lua
-- Author:ydli
-- 2018年12月27日
-- Using:关卡选择界面btn 虚基类


UI = UI or {}
local LevelSelectBtn = class("LevelSelect", UI.Component)
UI.LevelSelectBtn = LevelSelectBtn

SpineIconStatus = {
    locked = 0,
    waitUnLock = 1,
    haveUnLocked = 2,
    selected = 3,
}

function LevelSelectBtn:ctor()
    LevelSelectBtn.super.ctor(self, 0, {}, 0, 0)
    self.state = SpineIconStatus.locked
    self.clickCallback = nil
    self.animationEndCallback = nil
    self.animationStartCallback = nil
    self.isEnable = true
end

function LevelSelectBtn:dtor()
    LevelSelectBtn.super.dtor(self)
end

-- public:
-- 初始化
function LevelSelectBtn:init()
    LevelSelectBtn.super.init(self)
end

-- 模版函数：初始化组建的视图
function LevelSelectBtn:onInitView()

end

-- 模版函数：更新组建的视图
function LevelSelectBtn:onUpdateView()
    LevelSelectBtn.super.onUpdateView(self)
end

function LevelSelectBtn:setBtnState(state)
    self.state = state
end

function LevelSelectBtn:lock()
    print("---error：in class[LevelSelectBtn] no implementation functionl lock")
end

function LevelSelectBtn:waitUnLock()
    print("---error：in class[LevelSelectBtn] no implementation functionl waitUnLock")
end

function LevelSelectBtn:unLocked()
    print("---error：in class[LevelSelectBtn] no implementation functionl unLocked")
end

function LevelSelectBtn:selected()
    print("---error：in class[LevelSelectBtn] no implementation functionl selected")
end

function LevelSelectBtn:setClickCallback(clickCallback)
    self.clickCallback = clickCallback
end

function LevelSelectBtn:setAnimationEndCallback(animationEndCallback)
    self.animationEndCallback = animationEndCallback
end

function LevelSelectBtn:setAnimationStartCallback(animationStartCallback)
    self.animationStartCallback = animationStartCallback
end

function LevelSelectBtn:disable()
    self.isEnable = false
end

function LevelSelectBtn:enable()
    self.isEnable = true
end
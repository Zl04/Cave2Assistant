--[[
    AUTHOR:ZIHANCHEN
    2017-4-26
    USING: 倒计时的TIPS
]]

require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local TimeBarTips = class("TimeBarTips", UI.ConfirmDialog)
UI.TimeBarTips = TimeBarTips
local scheduler = cc.Director:getInstance():getScheduler()

function TimeBarTips:ctor(text, time)
    TimeBarTips.super.ctor(self)
    self.time = time or 0
    self.mSchedulerID = scheduler:scheduleScriptFunc(handler(self,self.schedulerTimeOut), 1 ,false)
    self:init(text)
end

--  析构函数 调用父类的方法
function TimeBarTips:dtor()
    TimeBarTips.super.dtor(self)
    if self.mSchedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
        self.mSchedulerID = nil
    end
end

--  初始化函数
function TimeBarTips:init(text)
    TimeBarTips.super.init(self, text)
end

--  初始化界面函数
function TimeBarTips:onInitView()
    TimeBarTips.super.onInitView(self)
      -- 不足 TEXT_111015 
    self.ConfirmDialogModel.contentLabel:setFontName(UI.SYS_FONT)
    self.ConfirmDialogModel.contentLabel:setText(self.text)
    self.ConfirmDialogModel.contentLabel:setSize(305, 100)
    self.ConfirmDialogModel.contentLabel:centerUp(13)
    self.ConfirmDialogModel.contentLabel:setTextCenter()
    

 -- 进度条背景
    local proBG = cc.Sprite:createWithSpriteFrameName("ui_information_banner_countdown_box.png")
    proBG:setPosition(180, -26)
    self.ConfirmDialogModel.contentBg:addChild(proBG)

    self._pro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_information_banner_countdown.png"))
    self._pro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self._pro:setMidpoint(cc.p(0,0))
    self._pro:setBarChangeRate(cc.p(1,0))
    self._pro:setPosition(cc.p(proBG:getContentSize().width/2, proBG:getContentSize().height/2))
    proBG:addChild(self._pro,20)
    self._pro:setPercentage(100)
    local to1 = cc.ProgressTo:create(self.time,0)
    local action = cc.Sequence:create(to1, cc.CallFunc:create(handler(self,self.timeOutCallBack)))
    self._pro:runAction(action)

    self.mTxtPro = UI.Text:create()
    self.mTxtPro:init(self.time.."s", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_247_202)
    proBG:addChild(self.mTxtPro,100)
    self.mTxtPro:center()
end


-- 更新视图
function TimeBarTips:onUpdateView()

end

-- 传递回调函数名字
function TimeBarTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end

--倒计时成功后处理
function TimeBarTips:timeOutCallBack()
    self:dispatchEvent(UIEvent.DIALOG_TIMEOUT)
end

function TimeBarTips:schedulerTimeOut(dt)
    self.time = self.time - 1
    if self.mTxtPro then
        if self.time <= 0 then
            self.time = 0 
        end
        self.mTxtPro:setText(self.time.."s")
    end
    if(self.time <= 0) then
        if self.mSchedulerID ~= nil then
            scheduler:unscheduleScriptEntry(self.mSchedulerID)
            self.mSchedulerID = nil
        end
    end
end

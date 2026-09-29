-- ActivityTimeBarTips.lua
-- Author:ydlu
-- 2018年1月10日
-- Using: 活动副本倒计时
UI = UI or {}

local ActivityTimeBarTips = class("ActivityTimeBarTips", UI.HWBtnComponent)
UI.ActivityTimeBarTips = ActivityTimeBarTips
UI = UI or {}
local COM_RES_LIST = {
    "ui_town_activity.plist",
}

local scheduler = cc.Director:getInstance():getScheduler()

function ActivityTimeBarTips:ctor(time)
    ActivityTimeBarTips.super.ctor(self, nil, COM_RES_LIST)
    self.time = time or PublicDefine.CONST_DEFINITION.COUNTDOWN_CANCEL_MATCH / 1000
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self:init()
end

--  析构函数 调用父类的方法
function ActivityTimeBarTips:dtor()
    ActivityTimeBarTips.super.dtor(self)
    self:unRegisterListener()
    TeamDataManager:setReadyState(false)
end

--  初始化函数
function ActivityTimeBarTips:init()
    ActivityTimeBarTips.super.init(self)
end

--  初始化界面函数
function ActivityTimeBarTips:onInitView()
    ActivityTimeBarTips.super.onInitView(self)

    --bg
    local bg = UI.Image:create()
    bg:init("ui_activity_progressbar_bg.png")
    bg:center()
    self:addChild(bg) 
 
    local decoration = UI.Image:create()
    decoration:init("ui_activity_progressbar_down.png")
    decoration:leftUp(-53, -40)
    bg:addChild(decoration, -1) 

    local decorationTop = UI.Image:create()
    decorationTop:init("ui_activity_progressbar_up.png")
    decorationTop:leftBottom(-60, -15)
    bg:addChild(decorationTop, 100) 

    local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_activity_progressbar.png"))
    timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    timer:setPercentage(80)
    bg:addChild(timer)
    timer:setAnchorPoint(0.5, 0.5)
    timer:setPosition(timer:getContentSize().width / 2, timer:getContentSize().height / 2)
    timer:rotate(180)
    timer:setScaleX(-1)
    self.timer = timer
    --head
    local headBg = UI.Image:create()
    headBg:init("ui_playerstate_me_black_up.png")
    headBg:center()
    bg:addChild(headBg)
    self.headBg = headBg

    local headCap = UI.Image:create()
    headCap:init("ui_activity_headframe_box.png")
    headCap:center()
    headBg:addChild(headCap, 10)

    --name
    local nickName = RoleDataManager:getMaster():getNickName()
    local name = UI.Text:create()
    name:init(nickName, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    name:centerBottom(70)
    bg:addChild(name)

    --btn
    local sureButton = UI.Button:create() 
    sureButton:init("ui_btn_yellow11_0.png", "ui_btn_yellow11_1.png", "ui_btn_yellow11_3.png")
    sureButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    sureButton:setText(UI.TEXT_1212094)
    sureButton:centerBottom(-10)
    sureButton:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetActivitySystem:requestSureMacth()
    end)
    self.sureButton = sureButton
    bg:addChild(sureButton, 200)

    --logo
    local okFlag = UI.Image:create()
    okFlag:init("ui_btn_yes4_1.png")
    okFlag:centerBottom(-10)
    bg:addChild(okFlag, 200)
    okFlag:hide()
    self.okFlag = okFlag
end


-- 更新视图
function ActivityTimeBarTips:onUpdateView()
    local GameDataManager = require("app.game.GameDataManager")
    local wearEquipmentDataArr = {}
    if not RoleDataManager:getMaster():getIsHideHelmet() then
        wearEquipmentDataArr = clone(GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)
    end
    Avalon.WidgetUtil:getHead(self, RoleDataManager:getMaster() ,_wearEquipmentDataArr, self, handler(self,function(self,pic)
        if self and not tolua.isnull(self) then
            self.headBg:removeChildByName("heorIcon", true)
            pic:setPosition(37, 37)
            pic:setName("heorIcon")
            self.headBg:addChild(pic, 1)
        end
    end),true)

    local percent = self.time / (PublicDefine.CONST_DEFINITION.COUNTDOWN_CANCEL_MATCH/1000) * 100
    self.timer:setPercentage(percent)
    local action = cc.ProgressTo:create(self.time, 0) 
    self.timer:runAction(cc.Sequence:create(action, cc.CallFunc:create(function()
        if not tolua.isnull(self) then
            self:close()
        end
    end)))
end

-- 传递回调函数名字
function ActivityTimeBarTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end

--倒计时成功后处理
function ActivityTimeBarTips:timeOutCallBack()
    self:dispatchEvent(UIEvent.DIALOG_TIMEOUT)
end

function ActivityTimeBarTips:schedulerTimeOut(dt)
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

function ActivityTimeBarTips:reponseSure(isSuccess, pk)
    if(pk == RoleDataManager:getMasterPK()) then
        if isSuccess then
            self.sureButton:hide()
            self.okFlag:show()
        else
            self:close()
        end
    end
end

-- 注册监听事件
function ActivityTimeBarTips:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, self, self.reponseSure)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self.close)
end

-- 注销监听事件
function ActivityTimeBarTips:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, self, self.reponseSure)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self.close)
end



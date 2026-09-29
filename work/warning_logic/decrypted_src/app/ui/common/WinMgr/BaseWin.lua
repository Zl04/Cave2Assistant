

UI = UI or {}

require "app.ui.Component"
require("app.ui.HWBtnComponent")

local BaseWin = class("BaseWin", UI.HWBtnComponent)
UI.BaseWin = BaseWin

local DOOR_OUT_ANIMATION_TIME = 0.2
--------------------------生命周期--------------------------
function BaseWin:ctor(...)
    BaseWin.super.ctor(self, ...)
    self.goBackWin = nil
    self.isNoticeShowMainUI = true
end

function BaseWin:init(...)
    BaseWin.super.init(self, ...)
end

function BaseWin:dtor()
    BaseWin.super.dtor(self)
end

function BaseWin:setCloseEndCallBack(closeEndCallBack)
    self.closeEndCallBack =closeEndCallBack
end

--设置开门动画回调
function BaseWin:setOpeCallBack(openCallBack)
    self.openCallBack = openCallBack
end

--设置关门开始动画回调, 回调可以返回false阻止关闭
function BaseWin:setCloseStartCallBack(closeStartCallBack)
    self.closeStartCallBack = closeStartCallBack
end

--设置关门完成动画回调
function BaseWin:setCloseFinishCallBack(closeFinishCallBack)
    self.closeFinishCallBack = closeFinishCallBack
end

function BaseWin:setGoBackWin(win)
    self.goBackWin = win
end

function BaseWin:setGoBackWinStatus(enable)
    if self.goBackWin then
        if enable then
            self.goBackWin:setVisible(true)
            AvalonUtil.resumeNode(self.goBackWin)
        else
            self.goBackWin:setVisible(false)
            AvalonUtil.pauseNode(self.goBackWin)
        end
    end
end

function BaseWin:open(node, isModelWin)
    if self.isOpenStatus then
        return
    end
    self.isOpenStatus = true

    self.animationtNode = node or self
    if isModelWin == nil or isModelWin == false then
        self.animationtNode:setTouchEnable(true)
        self.animationtNode:setSwallowTouches(true)
        self.animationtNode:setInterceptTouches(true)
        self.animationtNode:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
        if (self.animationtNode ~= self) then
            self:setForceListenBackKey(true)
        end
    end
    
    self.animationtNode:setVisible(false)

    self:setGoBackWinStatus(false)

    self:prepareOpenEvent()

    local delayCallbackfunc = cc.CallFunc:create(function()
        self:openImp()
    end)
    local delayAction = cc.DelayTime:create(0.01)
    self:runAction(cc.Sequence:create(delayAction, delayCallbackfunc))
end

-- 准备开场动画，用来设置节点的初始位置
function BaseWin:prepareOpenEvent()
end

function BaseWin:openImp()
    local func = cc.CallFunc:create(function()
            self.isOpenComplete = true
            if self.openCallBack then
                self.openCallBack()
            end
        end
    )

    self.animationtNode:setVisible(true)
    self.animationtNode:computePosition()
    self.animationtNode._enableAutoUpdatePos = false

    local animation = self:getOpenAnimation()

    self.animationtNode:runAction(cc.Sequence:create(animation, func))
    Avalon.AudioManager:playSound("1501")

end

-- 获取开场动画
function BaseWin:getOpenAnimation()
    return nil
end

function BaseWin:closeWin(...)
    if not self.isOpenStatus or not self.isOpenComplete then
        return
    end
    local generalHelp = self:getChildByName("GeneralHelp")
    if generalHelp then
        generalHelp:hide()
    end

    self.isOpenStatus = false

    self:setGoBackWinStatus(true)


    local closeAnimation = self:getCloseAnimation()
    if closeAnimation then
        local delayCalbackfunc = cc.CallFunc:create(function()
            local needClose = true
            if self.closeFinishCallBack then
                needClose = self.closeFinishCallBack()
            end

            if (needClose == true or needClose == nil) then
                print("BaseWin:closeWin release")
                self:willClose()
            end
        end)
        self.animationtNode:runAction(cc.Sequence:create(closeAnimation, cc.DelayTime:create(0.2), delayCalbackfunc))
    else
        local needClose = true
        if self.closeFinishCallBack then
            needClose = self.closeFinishCallBack()
        end

        if (needClose == true or needClose == nil) then
            print("BaseWin:closeWin release")
            self:willClose()
        end
    end

    local panel = nil
    if mvc and mvc.panelMonitor then
        panel = mvc.panelMonitor:getTopZOrderPanel(mvc.VIEW_TYPE.PANEL)
    end

    if self.goBackWin == nil and self.isNoticeShowMainUI and not panel then
        if not RoleBehaviorManager:checkMasterIsInBattle() then
            GameManager:centerToMap()
        end
        GameManager:hideNPCInfomation(self.spriteID)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
    end
    Avalon.AudioManager:playSound("1502")
    self.goBackWin = nil

    -- 检测是否有panel界面隐藏，有的话就打开（用作mvc界面隐藏自身并打开老界面后，老界面关闭时的自动返回显示）
    if panel and not self.dontShowPanel then
        mvc.panelMonitor:showTopPanel()
    end
end

function BaseWin:willClose()
    if(self.closeEndCallBack) then 
        self.closeEndCallBack()
        self.closeEndCallBack = nil
    else 
        self:close()
    end 
end 

function BaseWin:close()
    -- print(" BaseWin:close", self.__cname, self.viewType, self.__testName)
    BaseWin.super.close(self)
end

function BaseWin:getCloseAnimation(...)
    return nil
end

-- 点击外部区域的处理器(关闭)(可选)
function BaseWin:onTouchOutSizeEvent()
    print(" BaseWin:onTouchOutSizeEvent", self.__cname, self.viewType, self.__testName)
    local needClose = true
    if self.closeStartCallBack then
        local rs = self.closeStartCallBack()
        if rs == false then
            needClose = false
        end
    end
    if needClose then
        self:closeWin()
    end
end

-- 兼容处理self.animationNode不为自己的情况
function BaseWin:handleKeyBackUp()
    local nodeToSendTouchOutside = self.animationtNode or self
    if (not tolua.isnull(nodeToSendTouchOutside)) then
        AvalonUtil.simulateTouchOutsideForNode(nodeToSendTouchOutside)
    end
    return self.___eatHWBackEvent
end

function BaseWin:setNoticeShowMainUI(isShow)
    self.isNoticeShowMainUI = isShow
end
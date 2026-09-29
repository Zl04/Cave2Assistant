-- EmailBindPanel.lua
-- Author:zp
-- 2018年4月17日
-- Using:邮箱绑定页面

local winSize = cc.Director:getInstance():getWinSize()
local SdkBox = require("utils.sdkbox.SdkBox")
require "app.utils.PlaceholderUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local EmailBindPanel = class("EmailBindPanel", UI.HWBtnComponent)
UI.EmailBindPanel = EmailBindPanel

local scheduler = cc.Director:getInstance():getScheduler()

local DEBUG = true

local CELL_WIDTH = ACTIVITY_WIDTH

-- 资源文件
local COM_RES_LIST = {
    "ui_town_activity.plist",
}

local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

function EmailBindPanel:ctor()
    EmailBindPanel.super.ctor(self, UIType.ACTIVTIY_DETAIL_EXTRA_DROP, COM_RES_LIST, 0, 0)

    self.schedulerID = 0
    self.height = 0
    self._waitingTime = 0

    self._cd = false
end

function EmailBindPanel:init(data, listView)
    self._data = data
    self.listView = listView
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 0.1, false)
    EmailBindPanel.super.init(self)
end


function EmailBindPanel:dtor()
    EmailBindPanel.super.dtor(self)
    if(not tolua.isnull(self._bindEditBox)) then
        self._bindEditBox:removeFromParent(true)
        self._bindEditBox = nil
    end

    if(not tolua.isnull(self._emailEditBox)) then
        self._emailEditBox:removeFromParent(true)
        self._emailEditBox = nil
    end

    if self.schedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
end

function EmailBindPanel:onInitView()
    self.height = 0

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    local editboxOffseX = 11
    local offsetY = 50
    -- 输入邮箱地址
    local gotoEdit = UI.EditBox:create(320, 61)
    gotoEdit:init(LanguageManager:getInstance():getLocalString(1111207), cc.EDITBOX_INPUT_MODE_EMAILADDR, "ui_activity_banner_mailbox.png", 21, 14)
    gotoEdit:setFontSize(20)
    gotoEdit:setFontColor(UI.FONT_COLOR_155_155_155)
    gotoEdit:setPlaceholderFontSize(20)
    gotoEdit:setPlaceholderFontColor(UI.FONT_COLOR_155_155_155)
    gotoEdit:setReturnCallback(function(text)
        self:refreshSendButton()
        if (not tolua.isnull(self._bindEditBox)) then 
            self._bindEditBox:setText("")
            self:refreshBindButton()
        end
    end)
    gotoEdit:leftUp(editboxOffseX, offsetY - gotoEdit:getContentSize().height/2)
    contentLayout:addComponent(gotoEdit)
    self._emailEditBox = gotoEdit

    -- 添加输入框的蒙层
    local lianzi = UI.Image:create()
    lianzi:init("ui_activity_banner_mailbox.png")
    lianzi:leftUp(editboxOffseX, offsetY - lianzi:getContentSize().height/2)
    contentLayout:addChild(lianzi)
    lianzi:setTouchEnabled(true)
    self._mengButton = lianzi

    local titleText = UI.Text:create()
    titleText:init("INIT", UI.FONT_STANDARD , UI.FONT_SIZE_20PX)
    titleText:setFontColor(UI.FONT_COLOR_41_41_45)
    titleText:centerLeft(21)
    lianzi:addChild(titleText)
    self._mengText = titleText

    -- 恢复邮箱
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if(globalUserData) then
        local bindEmail = globalUserData:getBindEmail()
        if(bindEmail and bindEmail ~= "") then 
            self._emailEditBox:setText(bindEmail)
            self._mengText:setText(bindEmail)
        end
    end

    local sendButton = UI.Button:create()
    sendButton:setTouchClipNode(self.listView)
    sendButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    sendButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    sendButton:setText(LanguageManager:getInstance():getLocalString(1110596))
    sendButton:rightUp(30, offsetY - sendButton:getContentSize().height/2)
    sendButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- 处理显示逻辑
        local email = self._emailEditBox:getText()
        if(AvalonUtil:strIsEmail(email)) then
            self:sendBindEmail(email)
        else 
            -- 提示输入错误
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170171))
        end 
    end)
    contentLayout:addComponent(sendButton)
    self.sendButton = sendButton

    offsetY = 90 + 30
    -- 输入验证码
    local bindCodeEdit = UI.EditBox:create(320, 61)
    bindCodeEdit:init(LanguageManager:getInstance():getLocalString(1111208), cc.EDITBOX_INPUT_MODE_SINGLELINE, "ui_activity_banner_mailbox.png", 21, 14)
    bindCodeEdit:leftUp(editboxOffseX, offsetY - bindCodeEdit:getContentSize().height/2)
    contentLayout:addComponent(bindCodeEdit)
    bindCodeEdit:setFontSize(20)
    bindCodeEdit:setFontColor(UI.FONT_COLOR_155_155_155)
    bindCodeEdit:setPlaceholderFontSize(20)
    bindCodeEdit:setPlaceholderFontColor(UI.FONT_COLOR_155_155_155)

    bindCodeEdit:setReturnCallback(function(text)
        self:refreshBindButton()
    end)

    self._bindEditBox = bindCodeEdit
    bindCodeEdit:setTouchEnabled(false)

    local bindButton = UI.Button:create()
    bindButton:setTouchClipNode(self.listView)
    bindButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    bindButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    bindButton:setText(LanguageManager:getInstance():getLocalString(1111206))
    bindButton:rightUp(30, offsetY - bindButton:getContentSize().height/2)
    bindButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- 处理显示逻辑
        local code = self._bindEditBox:getText()
        if(code and string.len(code) > 0) then
            self:sendBindCode(code)
        else 
            -- 提示输入正确的验证码
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111208))
        end
    end)
    contentLayout:addComponent(bindButton)
    self.bindButton = bindButton

    self.height = self.height + 160
    -- self.height = self.height + 80

    self._contentLayout:setSize(CELL_WIDTH, self.height)
    self:setSize(CELL_WIDTH, self.height)

    self:refreshBindButton()
    self:refreshSendButton()
    self:refreshCD()
end

function EmailBindPanel:refreshSendButton()
    if (not tolua.isnull(self._emailEditBox) and not tolua.isnull(self.sendButton)) then 
        local str = self._emailEditBox:getText()

        if(str and string.len(str) > 0 and AvalonUtil:strIsEmail(str)) then
            self.sendButton:enable()
        else 
            self.sendButton:disable()
        end
    end
end

function EmailBindPanel:refreshBindButton()
    if (not tolua.isnull(self._bindEditBox) and not tolua.isnull(self.bindButton)) then 
        local str = self._bindEditBox:getText()
        if(str and string.len(str) > 0) then
            self.bindButton:enable()
        else 
            self.bindButton:disable()
        end
    end
    -- body
end

function EmailBindPanel:refreshCD()
    local cdTime = self:getWaitingTime()
    if(cdTime > 0) then
        self._cd = true
    else
        self._cd = false
    end

    self:refreshSendStatus()
end

function EmailBindPanel:getWaitingTime()
    -- body
    local waitingTime = 60 - (GameManager:getNowServerTime() - self._data:getSendEmailTime())

    return waitingTime
end

function EmailBindPanel:refreshSendStatus()
    if(self._cd) then
    -- body
        self._mengButton:setVisible(true)
        self._mengText:setVisible(true)


        self._emailEditBox:setVisible(false)
        if(not tolua.isnull(self.sendButton)) then
            self.sendButton:disable()
            local cdTime = self:getWaitingTime()
            if(cdTime <=0) then 
                self:refreshCD()
            else 
                self.sendButton:setText(string.format("%sS", cdTime))
            end
        end
    else 
        self._mengButton:setVisible(false)
        self._mengText:setVisible(false)

        self._emailEditBox:setVisible(true)

        self.sendButton:enable()
        self.sendButton:setText(LanguageManager:getInstance():getLocalString(1110596))
    end
end

function EmailBindPanel:getEmailBindHeight()
    return self.height
end

function EmailBindPanel:update(dt)
    -- 处理倒计时
    if(self._cd) then
        -- 处理刷新倒计时
        self._waitingTime = self._waitingTime + dt
        if(self._waitingTime >= 1) then 
            self:refreshSendStatus()
            self._waitingTime = self._waitingTime - 1
        end
    else 
        self._waitingTime = 0
    end
end

function EmailBindPanel:sendBindEmail(email)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

    self._mengText:setText(email)

    local gameLoginManager = require("app.game.GameLoginManager")
    local PK = GameDataManager:getInstance():getMasterPK()
    local account = gameLoginManager:getInstance():getAccountId()
    local languageType = LanguageManager:getInstance():getLanguage()
    local zone = gameLoginManager:getInstance():getServerId()




    local params = {}
    params.email = email
    params.pk = PK
    params.zone = zone
    params.accountStr = account
    params.languageType = tonumber(languageType)


    params.platform = SdkBox:getInstance():getVersionPlatform()
    params.account = SdkBox:getInstance():getVersionAccount()
    params.channel = SdkBox:getInstance():getVersionChannel()

    Net.Helper:sendHttpMessage(Net.HttpSubDirection.SendEmail,params,function(response)
        -- TODO 处理按钮冷却倒计时，同时变灰输入框
        self._data:setSendEmailTime(GameManager:getNowServerTime())
        self:refreshCD()

        local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
        globalUserData:setBindEmail(email)

        print("-------------EmailBindPanel:sendBindEmail success")
        dump(response)
        local data = json.decode(response)
        UI.WaitingLayer:hideWaiting() 
        if(data) then
            local languageID = 0
            if(data.status == PublicDefine.MailBindingSendMailStatus.MailBindingSendMailStatus_Success) then
                languageID = 1170172
            elseif (data.status == PublicDefine.MailBindingSendMailStatus.MailBindingSendMailStatus_InValidEmail) then
                languageID = 1170171
            elseif (data.status == PublicDefine.MailBindingSendMailStatus.MailBindingSendMailStatus_SendCodeFailed) then
                languageID = 1170174
            elseif (data.status == PublicDefine.MailBindingSendMailStatus.MailBindingSendMailStatus_ActionCoolDown) then
                languageID = 0
            else

            end 
            print("dd", languageID, data.status)
            if(languageID ~= 0) then
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(languageID))
            end
        else 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170149))
        end
    end,function(readyState, status)
        UI.WaitingLayer:hideWaiting()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170149))
        print("-------------EmailBindPanel:sendBindEmail !!!! fail")
    end)
end

function EmailBindPanel:sendBindCode(code)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

    local gameLoginManager = require("app.game.GameLoginManager")
    local zone = gameLoginManager:getInstance():getServerId()
    local PK = GameDataManager:getInstance():getMasterPK()

    local params = {}
    params.code = code
    params.pk = PK
    params.zone = zone

    Net.Helper:sendHttpMessage(Net.HttpSubDirection.VerifyEmail,params,function(response)
        -- TODO 根据错误码处理错误
        print("-------------EmailBindPanel:sendBindCode success")
        dump(response)
        local data = json.decode(response)
        UI.WaitingLayer:hideWaiting() 
        if(data) then
            local languageID = 0
            if(data.status == PublicDefine.MailBindingVerifyStatus.MailBindingVerifyStatus_Success) then
                languageID = 1170175
            elseif (data.status == PublicDefine.MailBindingVerifyStatus.MailBindingVerifyStatus_InValidCode) then
                languageID = 1170173
            else
                
            end

            if(languageID ~= 0) then
                 UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(languageID))
            end
        else 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170149))
        end
    end,function(readyState, status)
        UI.WaitingLayer:hideWaiting()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170149))
        print("-------------EmailBindPanel:sendBindCode !!!! fail")
    end)
end

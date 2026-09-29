-- BindAccount.lua
-- Author:zp
-- 2018年5月8日
-- Using:绑定账号

UI = UI or {}

local model = require("app.uiExport.languageSetting")

-- 背包资源
local COM_RES_LIST = {
    "ui_package_setup.plist"
}
local SdkBox = require("utils.sdkbox.SdkBox")
local BindAccount = class("BindAccount", UI.HWBtnComponent)
UI.BindAccount = BindAccount


function BindAccount:ctor()
    BindAccount.super.ctor(self, UIType.SELECT_LANGUAGE_LAYER, COM_RES_LIST, 483, 290)
    self.bindButtons_ = {}
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:registerListener();
end

function BindAccount:dtor()
    -- 清理sdkbox回调
    SdkBox:getInstance():onSdkLoginSuccess(nil)
    SdkBox:getInstance():onSdkLoginFail(nil)
    self:unRegisterListener()
end
-- 初始化视图
function BindAccount:onInitView()
    self:showLucencyLight(self._width, self._height)

    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(cc.p(0,0))
    self.rootLayer:setContentSize(cc.size(525, 305))
    self:addChild(self.rootLayer)

    self.bindAccountModel = model.create("bindAccount")
    self.rootLayer = self.bindAccountModel.root;
    self.rootLayer:center();
    self:addChild(self.rootLayer)


    local gameLoginManager = require("app.game.GameLoginManager")
    local versionAccount = gameLoginManager:getInstance():getVersionAccount()
    local supportLoginSdks = SdkBox:getInstance():getSupportLoginSdks()
    versionAccount = checkint(versionAccount)
    -- print("versionAccount",versionAccount)
    -- supportLoginSdks = {
    --     PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GAMECENTER,
    --     PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GOOGLEPLAY,
    --     PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_FB,
    -- }
    
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        if versionAccount ~= PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST then
            self:showThirdInfo()
        else
            -- 去掉游客登录
            for i = 1,#supportLoginSdks do
                if supportLoginSdks[i] == PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST then
                    table.remove(supportLoginSdks,i)
                    break
                end
            end
            for i = 1,#supportLoginSdks do
                local btnBinding = UI.Button:create()
                btnBinding:init(
                    string.format("ui_setup_button_entrance_%d.png",supportLoginSdks[i]),
                    string.format("ui_setup_button_entrance_%d.png",supportLoginSdks[i]))
                btnBinding:leftBottom(265 - 80 * #supportLoginSdks/2 + 80 * (i - 1), 70)
                btnBinding:addEventListener(UIEvent.BUTTON_CLICK, self, self.onBinding)
                btnBinding:setTag(supportLoginSdks[i])
                self:addChild(btnBinding)

                table.insert(self.bindButtons_,btnBinding)
            end
            dump("=====AccountBinding for current: versionAccount", supportLoginSdks)
        end
    end
end
-- 更新视图
function BindAccount:onUpdateView()
    print(" SettingPanel:onUpdateView  ")

    local sdkbox = SdkBox:getInstance()
    sdkbox:init()
    sdkbox:onSdkLoginSuccess(handler(self,self.onSdkLoginSuccess))
    sdkbox:onSdkLoginFail(handler(self,self.onSdkLoginFail))

end
function BindAccount:showThirdInfo()
    print("============BindAccount:showThirdInfo")
    local gameLoginManager = require("app.game.GameLoginManager")
    local versionAccount = gameLoginManager:getInstance():getVersionAccount()
    if not versionAccount then return end
    local btnBinding = UI.Button:create()
    btnBinding:init(string.format("ui_setup_button_entrance_%d.png",versionAccount),
        string.format("ui_setup_button_entrance_%d.png",versionAccount))
    btnBinding:centerBottom(100)
    btnBinding:setTag(1)
    btnBinding:disable()
    self:addChild(btnBinding)
    print("gameLoginManager:getInstance():getNickName()",gameLoginManager:getInstance():getNickName())
    local nickName = gameLoginManager:getInstance():getNickName() or "nickName"
    local text = UI.Text:create()
    text:init(nickName, UI.FONT_ARIAL)
    text:setFontSize(20)
    text:setFontColor(UI.FONT_COLOR_41_41_45)
    text:centerBottom(80)
    text:setTextCenter()
    self:addChild(text)
end




--[[
    {
    accountId:”xxx”,    //平台_版本_渠道_账号id
    host:”xxx”,         //游戏tcp服务器监听主机名（域名或ip）
    port:”xxx,”         //游戏tcp服务器监听端口
    versionAccount:"",         //登录的渠道sdk 定义在PublicDefine.VERSION_ACCOUNT
    nickname:"xxx"      //第三方昵称
    }

]]
function BindAccount:onSdkLoginSuccess(params)
    printInfo("BindAccount:onSdkLoginSuccess:", params)

    -- 隐藏SDK登录菊花
    self:_hideLoading()

    -- 检查登录状态码
    local loginStatusNum = tonumber(params.loginStatus)
    if (loginStatusNum ~= PublicDefine.LoginStatus.Success) then
        -- SDK登录状态有问题, 提示
        UI.ScrollBar:createByText(UI.TEXT_1110372 .. "," .. "loginStatus1: " .. tostring(params.loginStatus))
        return
    end

    -- 设置登录Token
    ServerConfigUtil:setAvalonLoginToken(params.avalonLoginToken)
    ServerConfigUtil:setNickName(params.nickName)
    ServerConfigUtil:setPlayerID(params.playerID)

    -- 显示菊花, 向WEB请求登录游戏
    self:_showLoading()
    ServerConfigUtil:queryGameLogin(
        function(data)      -- 强更
            -- 不应该发生
            self:_hideLoading()
            UI.ScrollBar:createByText(UI.TEXT_1110372 .. "," .. "hotfix")
        end, function(data) -- 热更
            -- 不应该发生
            self:_hideLoading()
            UI.ScrollBar:createByText(UI.TEXT_1110372 .. "," .. "forcedUpdate")
        end, function(data) -- 成功
            self:_hideLoading()

            -- 检查登录状态码
            local loginStatusNum = tonumber(params.loginStatus)
            if (loginStatusNum ~= PublicDefine.LoginStatus.Success) then
                -- SDK登录状态有问题, 提示
                UI.ScrollBar:createByText(UI.TEXT_1110372 .. "," .. "loginStatus2: " .. tostring(params.loginStatus))
                return
            end

            -- 准备绑定信息
            local gameLoginManager = require("app.game.GameLoginManager")
            local oldAccountId = gameLoginManager:getInstance():getAccountId()
            local newAccountId = data.accountId
            printInfo("BindAccount:onSdkLoginSuccess, 绑定老账号和新账号: ", oldAccountId, newAccountId)

            -- 设置绑定信息
            gameLoginManager:getInstance():setBindVersionAccount(SdkBox:getInstance():getVersionAccount())
            gameLoginManager:getInstance():setBindAccountId(newAccountId)
            gameLoginManager:getInstance():setBindNickName(params.nickname or params.nickName)

            -- 向服务器请求绑定
            Net.NetLoginSystem:bindAccount(oldAccountId, newAccountId)
        end, function(data) -- 超时
            self:_hideLoading()
            UI.ScrollBar:createByText(UI.TEXT_1150010)
        end, function(data) -- 未知状态
            self:_hideLoading()
            UI.ScrollBar:createByText(UI.TEXT_1110372)
        end)
end

function BindAccount:onSdkLoginFail(code, params)
    -- 如果是gamecenter 由于只能弹出一次登录界面 所以提示用户去外部登录
    if code == Avalon.UserActionResultCode.kInitFail and
        self._clickLoginType == PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GAMECENTER
        then
            local tips = UI.Tips:createTips(UI.TEXT_111152,UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL)
            tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                
            end)
            tips:removeFromParent(false)
            self:getParent():addChild(tips,self:getLocalZOrder() + 10)
            
    else
        UI.ScrollBar:createByText(UI.TEXT_111143)
    end
    self:_hideLoading()
end
--绑定账号
function BindAccount:onBinding(obj)
    local supportLoginSdks = SdkBox:getInstance():getSupportLoginSdks()
    local versionAccount = obj:getTag() --相应的渠道
    printInfo("BindAccount:onBinding ", versionAccount)
    
    
    local logoutTips = UI.Tips:createTips(UI.TEXT_111141,UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
    logoutTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        self:_showLoading()
        --唤醒sdk
        self._clickLoginType = versionAccount
        SdkBox:getInstance():loginCustom({
            versionAccount = versionAccount,
            url = ServerConfigUtil:getLoginVerifyUrl()
        })
    end)
    logoutTips:removeFromParent(false)
    self:getParent():addChild(logoutTips,self:getLocalZOrder() + 10)
end
-- 绑定账号成功 需要刷新页面
function BindAccount:onBindSuccess()
    self:_hideLoading()
    for i, button in ipairs( self.bindButtons_ ) do
        if not tolua.isnull(button) then
            button:destroy()
        end
    end
    self:showThirdInfo()
end
-- 绑定失败 已有角色
function BindAccount:onBindFailsHasHero(data)
    local buyGridsTips = UI.Tips:createTips(string.format(UI.TEXT_111127,data.heroName,data.heroLv),UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)

    buyGridsTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        -- 切换场景之前调用destroy 以免切换场景之后异步释放造成的奇怪问题
        if self.destroy then
            self:destroy()
        end
        --这里处理切换账号
        local gameLoginManager = require("app.game.GameLoginManager")
        gameLoginManager:getInstance():bindFailsChangeAccount()
    end)
    buyGridsTips:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
    buyGridsTips:removeFromParent(false)
    self:getParent():addChild(buyGridsTips,self:getLocalZOrder() + 10)
end
-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self, tips, touchPosition)
    self:close()
end

-- 注册监听事件(可选)
function BindAccount:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_LOGIN_BIND_SUCCESS,self,self.onBindSuccess)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_LOGIN_BIND_FAILS_HASHERO,self,self.onBindFailsHasHero)
end

-- 显示登录界面
function BindAccount:_showLoading(delayCancel)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_OTHER, 99999)

    if(delayCancel) then
        Avalon.Scheduler:setDelayForUpdateOnce(self, self._scheduleEnd, delayCancel)
    end
end

-- 隐藏登录界面
function BindAccount:_hideLoading()
    UI.WaitingLayer:hideWaiting()
    Avalon.Scheduler:unscheduleUpdate(self, self._scheduleEnd)
end

-- 倒计时结束
function BindAccount:_scheduleEnd()
    UI.WaitingLayer:hideWaiting()
end
-- 注销监听事件(可选)
function BindAccount:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_LOGIN_BIND_SUCCESS,self,self.onBindSuccess)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_LOGIN_BIND_FAILS_HASHERO,self,self.onBindFailsHasHero)
end
-- WebViewLayer.lua
-- Author:ydli
-- 2017年11月11日
-- Using:内置浏览器 调用框架的webview组件， 放到游戏自己定制的带返回按钮的 layer上

UI = UI or {}
local WebViewLayer = class("WebViewLayer", UI.HWBtnComponent)
UI.WebViewLayer = WebViewLayer

local winSize = cc.Director:getInstance():getWinSize()
-- 背包资源
local COM_RES_LIST = {
    "ui_common_btn.plist",
}


function WebViewLayer:ctor()
    WebViewLayer.super.ctor(self, UIType.WEB_VIEW_LAYER, COM_RES_LIST, winSize.width, winSize.height)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
end

function WebViewLayer:dtor()
    WebViewLayer.super.dtor(self)
end

function WebViewLayer:init(url)
    local titleBg = UI.Image:create()
    titleBg:init("ui_information_lookup.png")
    titleBg:centerUp(0)
    self:addChild(titleBg)
    titleBg:setScale(winSize.width / 1136)

    local logo = UI.Image:create()
    logo:init("ui_information_share_logo.png")
    logo:rightUp(160, 6)
    self:addChild(logo)

    local closeBtn = UI.Button:create()
    closeBtn:init("ui_information_return_0.png", "ui_information_return_1.png", "ui_information_return_0.png")
    closeBtn:rightUp(41, 9)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.closeCallback)
    self:addChild(closeBtn)

    WebViewLayer.super.init(self)
    dump(ccexp)
    self._webView = ccexp.WebView:create()
    self._webView:setPosition(winSize.width / 2, winSize.height / 2 - 31)
    self._webView:setContentSize(winSize.width,  winSize.height - 60)
    self._webView:loadURL(url, true)
    self._webView:setScalesPageToFit(true)

    self._webView:setOnShouldStartLoading(function(sender, url)
        print("onWebViewShouldStartLoading, url is ", url)
        return true
    end)
    self._webView:setOnDidFinishLoading(function(sender, url)
        print("onWebViewDidFinishLoading, url is ", url)
    end)
    self._webView:setOnDidFailLoading(function(sender, url)
        print("onWebViewDidFinishLoading, url is ", url)
    end)

    self:addChild(self._webView)

    self:setForceListenBackKey(true)
end

function WebViewLayer:onInitView()
end

function WebViewLayer:onUpdateView()
end

-- 注册监听事件(可选)
function WebViewLayer:registerListener()
end

function WebViewLayer:onTouchDialogOutsizeHandler()

end

-- 注销监听事件(可选)
function WebViewLayer:unRegisterListener()

end

function WebViewLayer:closeCallback()
    -- UI.WaitingLayer:showWaiting(true)
    self:close()
    require "app.datas.TaskDataManager"
    TaskDataManager:endFollowTask()
    -- self:removeFromParent(true)
end

function WebViewLayer:handleKeyBackUp()
    if (self._webView:canGoBack()) then
        self._webView:goBack()
    else
        self:closeCallback()
    end

    -- 吃掉返回, 不影响浏览器内的返回处理
    return true
end
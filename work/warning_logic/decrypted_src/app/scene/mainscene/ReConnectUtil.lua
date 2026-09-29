-- ServerConfigUtil

require("app.utils.ServerConfigUtil")
local gameLoginManager = require("app.game.GameLoginManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
require "app.ui.shieldingLayer.ReconnectWaitingLayer"
ReconnectUtil = {}
local function failCallback()
    Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
    local SceneManager = require("app.game.SceneManager")
    if (SceneManager:getInstance():isInLogin()) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RESET_LOGINBUTTON)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
    else
        Game.Manager:clearScene()
        SceneManager:getInstance():startLoginScene()
    end
    
end



-- 进入游戏
function ReconnectUtil:_listenerEnterGame()
    -- 上报进入loading界面
    gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Loading_Start)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR)
    GameManager:initGameModules()
    -- SceneManager:getInstance():replaceLoadingScene()
    self:unregisterEvent()
end

function ReconnectUtil:registerEvent()
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_ENTER_GAME, self, self._listenerEnterGame)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NET_DISCONNECT, self, self.doNetDisconnect)
end

function ReconnectUtil:unregisterEvent()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_ENTER_GAME, self, self._listenerEnterGame)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NET_DISCONNECT, self, self.doNetDisconnect)
end

function ReconnectUtil:doNetDisconnect()
    Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
    print("disconnect....do....")
end

local entertime = 0

function ReconnectUtil:reconect()
    if UI.UIManager.cannotRecconnect then
        return
    end
    isFromReconnect = true
    UI.ReconnectWaitingLayer:showWaiting(true, nil, 10000, 0, 6)
    local machin = MachineManager:getInstance():getMachine()
    if machin then
        machin._paused = true
    end
    self:reconect1()
    self:registerEvent()
end

function ReconnectUtil:showWaiting()
    UI.ReconnectWaitingLayer:showWaiting(true, nil, 10000, entertime > 5 and 5 or entertime, 5)
end


function ReconnectUtil:reconect1(repeatTime)
    entertime = repeatTime or 1
    self:showWaiting()
    if entertime > 6 then
        isFromReconnect = false
        UI.UIManager._showDisconnetLayer = true
        UI.UIManager:triggerShowDisconnectTips()
        self:unregisterEvent()
        UI.ReconnectWaitingLayer:hideWaiting()
        return
    end
    ServerConfigUtil:queryGameLogin(
        function(data) -- 强更
            failCallback()
        end,
        function(data) -- 热更
            failCallback()
        end,
        function(data) -- 成功
            -- 设置登录模块参数, 然后执行连接
            -- 处理测试账号, 如果是以test_打头的测试账号, 去掉五段式
            local accountId = data.accountId
            local testPlayerID = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify, "")
            if (testPlayerID:sub(1, 5):lower() == "test_") then
                printInfo("MainLayer:loginGame(), 测试账号以test_开头, 裁剪五段式: ", accountId, testPlayerID)
                accountId = testPlayerID
            end
            local gameLoginManager = require("app.game.GameLoginManager")

            -- 设置登录参数
            gameLoginManager:getInstance():setAccountId(accountId)
            gameLoginManager:getInstance():setVersionChannel(SdkBox:getInstance():getVersionChannel())
            gameLoginManager:getInstance():setVersionAccount(SdkBox:getInstance():getVersionAccount())
            gameLoginManager:getInstance():setServerPort(ServerConfigUtil:getGatePort())
            gameLoginManager:getInstance():setServerId(ServerConfigUtil:getZoneId())
            gameLoginManager:getInstance():setServerName(ServerConfigUtil:getName())
            gameLoginManager:getInstance():setNickName(ServerConfigUtil:getNickName())

            -- 连接游戏服务器
            self:tryConnectToGameServer()
        end,
        function(data) -- 超时
            Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function() 
                entertime = entertime + 1
                ReconnectUtil:reconect1(entertime)
            end, 6)
        end,
        function(data) -- 未知状态
            failCallback()
        end
    )
end
-- 通过HTTPDNS将URL或者IP转化成IP,
function ReconnectUtil:httpdnsGetIPAsync(url, callback, isInit)
    if (not url) then
        printWarn("MainLayer:httpdnsGetIPAsync, url为空")
        return
    else
        printInfo("MainLayer:httpdnsGetIPAsync, HTTPDNS请求", url)
    end

    -- global安卓屏蔽httpdns
    require "app.datas.PublicDefine"
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    if
        (device.platform == "android" and versionTarget ~= nil and
            versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL)
     then
        if callback then
            callback(url)
        end
        return
    end

    -- 使用httpdns
    local httpdns = avalon.HttpDNSUtil:getInstance()
    if (isInit) then
        httpdns:init({url})
    end
    httpdns:beginQuery(
        url,
        function(ip)
            printInfo("MainLayer:httpdnsGetIPAsync, HTTPDNS获取到的IP ", ip)
            if callback then
                callback(ip)
            end
        end
    )
end

function ReconnectUtil:tryConnectToGameServer()
    -- 走httpdns的流程
    self:httpdnsGetIPAsync(
        ServerConfigUtil:getGateHost(),
        function(ip)
            printInfo(
                "ReconnectUtil:tryConnectToGameServer httpdns",
                ServerConfigUtil:getGateHost(),
                ServerConfigUtil:getGatePort(),
                ip
            )
            if (ip) then
                -- self.ip = ip
                gameLoginManager:getInstance():setServerUrl(ip)
                Net.NetInnerSystem:connect(Net.MAIN_SERVER, ip, ServerConfigUtil:getGatePort())
            end
        end
    )
end

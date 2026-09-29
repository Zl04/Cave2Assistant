--[[
    内部网络消息
]]

Net = Net or {}

local NetInnerSystem = {}
Net.NetInnerSystem = NetInnerSystem

-- 处理器
local reconnect = false
local manualClose = false;
function NetInnerSystem:onInnerMessageHandler(no, data, id)

    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        if id == Net.MAIN_TEXT_SERVER or id == Net.MAIN_TEXT_SERVER2 then
            if (no == NetMessageType.CONNECT_HEART_BEAT.NO  and id == Net.MAIN_TEXT_SERVER) then
                -- print("  2222222222222  ",no, data, id)
                if mvc then
                    mvc.networkEnvironmentTestingModel:addAliyunTimeData(data)
                end
            elseif (no == NetMessageType.CONNECT_HEART_BEAT.NO and id == Net.MAIN_TEXT_SERVER2) then
                if mvc then
                    mvc.networkEnvironmentTestingModel:addAWSTimeData(data)
                end
            end
            return
        end
    end

    if (no == NetMessageType.CONNECT_COMPLETE.NO) then
        print(string.format("NetInnerSystem connection complete. [no:%d data:%s]", no, data))

        if isFromReconnect then
            local gameLoginManager = require("app.game.GameLoginManager")
            local account =gameLoginManager:getInstance():getAccountId()
            Net.NetLoginSystem:verify(account)
            local GameDataManager = require("app.game.GameDataManager")
            GameDataManager:getInstance():setNetworkMode(AvalonUtil.getNetworkMode())
            return
        end

        if(isFromChangeArea) then 
            local gameLoginManager = require("app.game.GameLoginManager")
            local account =gameLoginManager:getInstance():getAccountId()
            Net.NetLoginSystem:verify(account)
            return
        end

        if(isFromChangeScene) then 
            local gameLoginManager = require("app.game.GameLoginManager")
            local account =gameLoginManager:getInstance():getAccountId()
            Net.NetLoginSystem:verify(account)
            return
        end
        

        local connid = AvalonUtil.strToNumber(data)
        local GameLoginManager = require("app.game.GameLoginManager")

        if (reconnect) then
            Game.Manager:clearScene()
            local SceneManager = require("app.game.SceneManager")
            -- GameLoginManager:getInstance():onSelectRole()
            SceneManager:getInstance():startLoginScene()
        
            reconnect = false
        else 
            Avalon.MessageCenter:notice(GameMessage.MC_NET_CONNECT_COMPLETE, connid)
            GameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Req_LoginToGameServer)
            GameLoginManager:onVerify()
        end
        local GameDataManager = require("app.game.GameDataManager")
        GameDataManager:getInstance():setNetworkMode(AvalonUtil.getNetworkMode())
    elseif (no == NetMessageType.CONNECT_FAIL.NO) then
        print(string.format("NetInnerSystem connection fail. [no:%d data:%s]", no, data))
        if not manualClose then
            local connid = AvalonUtil.strToNumber(data)
            Avalon.MessageCenter:notice(GameMessage.MC_NET_DISCONNECT, connid)
            manualClose = false;
        end

        local GameDataManager = require("app.game.GameDataManager")
        GameDataManager:getInstance():setNetworkMode(nil)
    elseif (no == NetMessageType.CONNECT_DISCONNECTED.NO) then
        print(string.format("NetInnerSystem connection disconnected. [no:%d data:%s]", no, data))
        if not manualClose then
            local connid = AvalonUtil.strToNumber(data)
            Avalon.MessageCenter:notice(GameMessage.MC_NET_DISCONNECT, connid)
            manualClose = false;
        end
        local GameDataManager = require("app.game.GameDataManager")
        GameDataManager:getInstance():setNetworkMode(nil)
    elseif (no == NetMessageType.CONNECT_HEART_BEAT.NO) then
        print(string.format("NetInnerSystem heart beat. [no:%d data:%s]", no, data))

        Avalon.MessageCenter:notice(GameMessage.MC_PING_VALUE, data)

        -- if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        --     if mvc then
        --         mvc.networkEnvironmentTestingModel:addAWSTimeData(data)
        --     end
        -- end
    elseif (no == NetMessageType.CONNECT_SEND_INTERVAL.NO) then
        print(string.format("NetInnerSystem send interval. [no:%d data:%s]", no, data))

        Avalon.MessageCenter:notice(GameMessage.MC_SEND_INTERVAL, data)
    else
        print(string.format("[WARNING] NetInnerSystem no handler for this message. [no:%d data:%s]", no, data))
    end
end

function NetInnerSystem:disconnect(connid)
    manualClose = true;
    NetHelper:disconnect(connid)
end

function NetInnerSystem:reconnect(connid, host, port)
    NetHelper:reconnect(connid, host, port)

    reconnect = true
end

-- 连接网络
function NetInnerSystem:connect(connid, host, port, onComplete, onFail)
    manualClose = false;
    print("host , port = ", host, port)
    NetHelper:connect(connid, host, port, onComplete, onFail)
end

-- 连接网络
function NetInnerSystem:connect2(connid, host, port, onComplete, onFail)
    -- manualClose = false;
    print("host , port 2222 = ", host, port)
    NetHelper:connect(connid, host, port, onComplete, onFail)
end

function NetInnerSystem:disconnect2(connid)
    NetHelper:disconnect(connid)
end
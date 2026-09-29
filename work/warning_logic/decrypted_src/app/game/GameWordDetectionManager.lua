-- 
-- 敏感词检测接口管理
-- llf
-- 
require "cocos.cocos2d.json"
require "app.datas.RoleDataManager"
require "utils.AvalonUtil"
local SdkBox = require("utils.sdkbox.SdkBox")
local gameLoginManager = require("app.game.GameLoginManager")
local wordDetectionKey = "sf_AxB_z"
-- local nicknameUrl = "https://testsafe.leiting.com/common/sensitive/detection/nickname"
-- local textUrl = "https://testsafe.leiting.com/common/sensitive/detection/text"
local nicknameUrl = "https://safe.leiting.com/common/sensitive/detection/nickname"
local textUrl = "https://safe.leiting.com/common/sensitive/detection/text"


local GameWordDetectionManager = class("GameWordDetectionManager")
g_GameWordDetectionManager = nil;

function GameWordDetectionManager:getInstance()
    if g_GameWordDetectionManager == nil then
       g_GameWordDetectionManager = GameWordDetectionManager.new()
    end
    return g_GameWordDetectionManager;
end

function GameWordDetectionManager:ctor()
end

function GameWordDetectionManager:dtor()
end

-- serverTag ===== ChatChannelType = {
    --     ChatChannelType_Near = 1;      --附近频道
    --     ChatChannelType_Team = 2;      --队伍频道
    --     ChatChannelType_Guild = 3;    --公会频道
    --     ChatChannelType_Private = 4;    --私聊频道
    --     ChatChannelType_WorldChat = 5;    --世界频道
    -- }
function GameWordDetectionManager:createParamTable(nickStr,serverTag)
    local paramTable = {}

    local nickName = ""
    if (RoleDataManager:getMaster()) then
        nickName = RoleDataManager:getMaster():getNickName()
    end
    local content = nickStr
    local os = 3
    if AvalonUtil.getPlatform() == AvalonUtil.CC_PLATFORM_IOS then
        os = 2
    elseif AvalonUtil.getPlatform() == AvalonUtil.CC_PLATFORM_ANDROID then
        os = 1
    end

    local zone = tostring(gameLoginManager:getInstance():getServerId())
    local imei = AvalonUtil.getIMEI()
    local game = "caveonline"
    local gameLevel = 1
    if (RoleDataManager:getMaster()) then
        gameLevel = RoleDataManager:getMaster():getLevel()
    end
    local isYd = 2
    local channelId = SdkBox:getSubChannel()
    local sid = gameLoginManager:getInstance():getAccountId()--"lh7e5e6z"

    local sign = AvalonUtil:MD5(game .. sid .. "%" .. wordDetectionKey)
    
    local server = serverTag or PublicDefine.ChatChannelType.ChatChannelType_Near

    local gid = ""
    if (RoleDataManager:getMaster()) then
        gid = RoleDataManager:getMasterPK()
    end

    paramTable["game"] = game
    paramTable["sid"] = sid
    paramTable["imei"] = imei
    paramTable["zone"] = zone
    paramTable["os"] = os
    paramTable["nickName"] = nickName
    paramTable["content"] = content
    paramTable["isYd"] = isYd
    paramTable["channelId"] = channelId
    paramTable["gameLevel"] = gameLevel
    paramTable["sign"] = sign
    paramTable["server"] = tostring(server)
    paramTable["gid"] = gid
    

    return paramTable
end

--昵称检测
function GameWordDetectionManager:nicknameDetection(nickStr, func, failFunc)

    if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) then
    else
        if func ~= nil then
            func(nickStr)
        end
        return
    end

    local paramTable = self:createParamTable(nickStr)

    local httpurl = nicknameUrl
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    local function onReadyStateChanged()
        -- print("nicknameDetection  request_check",xhr.readyState,xhr.status,xhr.response)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print("nicknameDetection   response ===== ",xhr.response)
            local xhrResp = xhr.response:gsub("\\/", "/")
            local resp = json.decode(xhrResp)
            -- print(resp,"web create order")
            local status = checkint(resp.status)
            if status == 0 then
                local data = resp.data
                if data.code == 2 then
                    nickStr = data.text or ""
                end


                if data.code == 1 then
                    if func ~= nil then
                        func(nickStr)
                    end
                else
                    UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(UI.TEXT_1170323)
                    if failFunc ~= nil then
                        failFunc()
                    end
                end

            end
        else
            print("web create order  failed",xhr.readyState,xhr.status,xhr.response)
            if failFunc ~= nil then
                failFunc()
            end
        end
    end
    
    xhr:registerScriptHandler(onReadyStateChanged)
    local sendParam = json.encode(paramTable)
    print("------sendParam"..sendParam)
    xhr:send(sendParam)
end

--全文本检测
function GameWordDetectionManager:textDetection(nickStr, func, failFunc, serverTag)

    if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) then
    else
        if func ~= nil then
            func(nickStr)
        end
        return
    end

    

    local paramTable = self:createParamTable(nickStr,serverTag)

    local httpurl = textUrl
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON
    
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    local function onReadyStateChanged()
        -- print("nicknameDetection  request_check",xhr.readyState,xhr.status,xhr.response)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print("nicknameDetection   response ===== ",xhr.response)
            local xhrResp = xhr.response:gsub("\\/", "/")
            local resp = json.decode(xhrResp)
            -- print(resp,"web create order")
            local status = checkint(resp.status)
            if status == 0 then
                local data = resp.data
                if data.code == 2 then
                    nickStr = data.text or ""
                end


                if data.code == 1 then
                    if func ~= nil then
                        func(nickStr)
                    end
                else
                    UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(UI.TEXT_1170323)
                    if failFunc ~= nil then
                        failFunc()
                    end
                end

            end
        else
            print("web create order  failed",xhr.readyState,xhr.status,xhr.response)
            if failFunc ~= nil then
                failFunc()
            end
        end
    end
    
    xhr:registerScriptHandler(onReadyStateChanged)
    local sendParam = json.encode(paramTable)
    print("------sendParam"..sendParam)
    xhr:send(sendParam)
end

return GameWordDetectionManager
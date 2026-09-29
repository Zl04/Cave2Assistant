--[[
    登录相关的网络消息处理
]]--

Net = Net or {}
local NetLoginSystem = {}
Net.NetLoginSystem = NetLoginSystem
local GameDataManager = require("app.game.GameDataManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local LanguageManager = require("app.game.LanguageManager")
require "app.utils.ToolsUtil"

-- 验证
function NetLoginSystem:verify(maccount,mkey)
    local debugKey = nil
    -- add by zp 用于调试线上BUG，这里填写运营添加的测试key和账号数据，可以直接登录运维指定的玩家账号
    -- maccount = "1_hu_0422"   -- 要登录的账号，为最后的组合账号
    -- debugKey = "helloworld"  -- 调试key, 由运营添加调试账号的时候设置。 
    if(DEVELOPMENT_MODE) then
        if GLOBAL_TEST_CHANNEL_STR and GLOBAL_TEST_CHANNEL_DEBUG_KEY_STR then 
            maccount = GLOBAL_TEST_CHANNEL_STR
            debugKey = GLOBAL_TEST_CHANNEL_DEBUG_KEY_STR
            print("maccount=", maccount)
            print("debugKey=", debugKey)
        end
    end
    ServerConfigUtil:saveAreaData()
    -- print ("==verify==", maccount)
    require "app.utils.AntiAddictionUtil"
    local adultType = AntiAddictionUtil:getMappedAdultType()
    -- print("==adultType==", adultType)
    local gameLoginManager = require("app.game.GameLoginManager")
    gameLoginManager:getInstance():setAccountId(maccount)
    if maccount ~= nil then
        local loginMessage_table = {
            account = maccount,
            key = mkey ,
            -- 数据收集
            -- ip = Net.Helper:getIPAddress(),
            idfa = AvalonUtil.getIDFA(),
            uuid = AvalonUtil.getOpenUUID(),
            imei = AvalonUtil.getIMEI(),
            adid = AvalonUtil.getADID(),
            mac = AvalonUtil.getMAC(),
            device = AvalonUtil.getDeviceName(),
            osVersion = AvalonUtil.getSystemVersion(),
            location= AvalonUtil.getLocation(),
            networkMode = AvalonUtil.getNetworkMode(),
            adultType = adultType,
            platform = SdkBox:getInstance():getVersionPlatform(),
        }
        if(debugKey) then 
            loginMessage_table.debugKey = debugKey
        end

        -- 判断是否已经选择了区服
        local areaID = gameLoginManager:getInstance():getAreaID()
        areaID = areaID or -1
        loginMessage_table.areaId = areaID

        -- local protoMsg = proto:encode("LoginSystem.VerifyMessage", loginMessage_table)
        
        -- local typeId = proto:enum_id("LoginSystem.LOGINSYSTEM_MESSAGE_TYPE","Type_VerifyMessage")
        -- print ("typeId ",typeId)
        -- avalon.NetManager:getInstance():send(3,2,typeId, protoMsg)

        Net.Helper:sendMessage(NetMessageType.LOGIN_VERIFY, loginMessage_table)
    end
end
    
-- 创建一个英雄
function NetLoginSystem:createHero(account, nickName, sex, faceDecodeID ,hairSelectNum,eyeSelectNum,mouthSelectNum,skinSelectNum,sexSelectNum,tRandomNum,areaID)
    print("NetLoginSystem:createHero ", account, nickName, sex, faceDecodeID,hairSelectNum,eyeSelectNum,mouthSelectNum,skinSelectNum,sexSelectNum,tRandomNum, areaID)
    areaID = areaID or -1
    local loginMessage_table = {
        account = account,
        nickName = nickName,
        sex = sex,
        faceDecodeID = faceDecodeID,
        -- 数据收集
        -- ip = Net.Helper:getIPAddress(),
        -- idfa = AvalonUtil.getIDFA(),
        -- uuid = AvalonUtil.getOpenUUID(),
        -- imei = AvalonUtil.getIMEI(),
        -- adid = AvalonUtil.getADID(),
        -- mac = AvalonUtil.getMAC(),
        -- device = AvalonUtil.getDeviceName(),
        -- osVersion = AvalonUtil.getSystemVersion(),
        -- location= AvalonUtil.getLocation(),
        hairSelectNum = hairSelectNum,
        eyeSelectNum = eyeSelectNum,
        mouthSelectNum = mouthSelectNum,
        skinSelectNum = skinSelectNum,
        sexSelectNum = sexSelectNum,
        tRandomNum = tRandomNum,
        networkMode = AvalonUtil.getNetworkMode(),
        platform = SdkBox:getInstance():getVersionPlatform(),
        areaId = areaID
    }

    Net.Helper:sendMessage(NetMessageType.LOGIN_CREATE_HERO, loginMessage_table)
end

-- -- 请求验证账号
-- function NetLoginSystem:reqAccountVerify(channelNo,params)
--     -- Net.NetLoginSystem:reqAccountVerify(channelNo,params)
--     local verifyMessage_table = {
--         channelNo = channelNo,
--         params = params,
--     }
--     Net.Helper:sendMessage(NetMessageType.LOGIN_ACCOUNT_VERIFY, verifyMessage_table)
-- end
-- -- 选择角色
-- function NetLoginSystem:selectRole(roleID)
--     print ("==selectRole==",roleID)
--     if roleID ~= nil then
--         local selectHeroMessage_table = {
--             ID  = roleID
--         }
        
--         Net.Helper:sendMessage(NetMessageType.LOGIN_SELECT_HERO, selectHeroMessage_table)
--     end
-- end

-- 退出游戏 (CD) 无消息内容
function NetLoginSystem:loginOutGame(pk, reason)
    print ("==NetLoginSystem:loginOutGame==",pk, reason)
    reason = reason or 1
    pk = pk or 0
    if(pk < 0) then 
        pk = 0
    end
    local logout_message_table = {
        -- 玩家手动退出
        reason = reason,
        pk = pk,
    }
    Net.Helper:sendMessage(NetMessageType.LOGIN_LOGIN_OUT_GAME,logout_message_table)
    print ("==NetLoginSystem:loginOutGame 2==")
end

-- 请求账号绑定 CD
function NetLoginSystem:bindAccount(guestAccount, bindAccount)
    print ("NetLoginSystem:bindAccount", guestAccount, bindAccount)

    local requestData = {}
    requestData.guestAccount = guestAccount
    requestData.bindAccount = bindAccount
        
    Net.Helper:sendMessage(NetMessageType.LOGIN_REQ_BIND_ACCOUNT, requestData)
end

-- 请求获取服务器列表
function NetLoginSystem:reqAreaList()
    local requestData = {}
    -- requestData.account = account

    Net.Helper:sendMessage(NetMessageType.LOGIN_REQ_AREA_LIST, requestData)
end

-- 请求获取玩家IP信息
function NetLoginSystem:reqRoleIP(pk)
    if not pk then
        printError("role pk is nil")
        return
    end
    local requestData = {}
    requestData.pk = pk
    Net.Helper:sendMessage(NetMessageType.LOGIN_REQ_HERO_CONNECTON_INFO_MESSAGE, requestData)
end

-- 记录网络信息
function NetLoginSystem:reqRecordNetInfoMessage(jsonStr)
    local data = {}
    data.info = jsonStr

    -- print("reqRecordNetInfoMessage  data ========")
    -- dump(data,nil,10)
    Net.Helper:sendMessage(NetMessageType.LOGIN_REQ_RECORD_NET_INFO_MESSAGE, data)
end


-- 登录消息处理
function NetLoginSystem:onLoginMessageHandler(no, data)
     print (" Net.NetLoginSystem:onNetMessageHandler :no, data  :",no,data)
  

    if (no == NetMessageType.LOGIN_REPLY_VERIFY_RESULT.NO) then
        print("NetMessageType.LOGIN_REPLY_VERIFY_RESULT")
        dump(data)

        local ProtobufUtil = require "utils.ProtobufUtil"
        if(data.result == ProtobufUtil:enum_id("LoginSystem.VerifyResult","VerifyResult_Ok")) then
            if isFromReconnect then
                isFromReconnect = false
                Game.Manager:clearScene()
                if mvc then
                    mvc.initFramework()
                end
            end

            if(isFromChangeArea) then 
                isFromChangeArea = false
                Game.Manager:clearScene()
                if mvc then
                    mvc.initFramework()
                end
            end

            if(isFromChangeScene) then 
                isFromChangeScene = false
                Game.Manager:clearScene()
                if mvc then
                    mvc.initFramework()
                end
            end

            
            
            RoleDataManager:setMasterPK(data.PK)

            -- 处理加载页面
            Avalon.MessageCenter:notice(AvalonMessage.MC_LOGIN_ENTER_GAME)
            -- 登入角色数据上传
            -- GameDataManager:getInstance():submitExtraData(Avalon.SubmitExtraDataType.SubmitExtraDataLoginRole);

            local gameLoginManager = require("app.game.GameLoginManager")
            gameLoginManager:getInstance():setEnterGameSubmitExtraDataType(Avalon.SubmitExtraDataType.SubmitExtraDataLoginRole)
            
        elseif(data.result == ProtobufUtil:enum_id("LoginSystem.VerifyResult","VerifyResult_Banned")) then
            UI.TipsLayer:createLoginSealTips(data.banSec)
        elseif(data.result == ProtobufUtil:enum_id("LoginSystem.VerifyResult","VerifyResult_AccountTakenOver")) then
            UI.TipsLayer:createAccountTakeOver()
        -- 系统繁忙
        elseif(data.result == ProtobufUtil:enum_id("LoginSystem.VerifyResult","VerifyResult_SystemBusy")) then
            -- 系统繁忙
            Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
            UI.ScrollBar:createByText(UI.LOGIN_ERROR_SYSTEM_BUSY)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
        -- 排队中
        elseif(data.result == ProtobufUtil:enum_id("LoginSystem.VerifyResult","VerifyResult_Queuing")) then
            -- print("VerifyResult_Queuing  data.banSec =", data.banSec)
            UI.TipsLayer:createSystemBusyTips(data.banSec)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
        else 
            -- 登陆验证失败,关闭连接
            Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
            
            -- 飘窗提示
            GameErrorManager:showError(data.result)
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_LOGIN_VERIFY_RESULT, data)
    -- elseif (no == NetMessageType.LOGIN_GET_HERO_LIST.NO) then
    --     for k,v in pairs(data) do
    --         print (k)
    --     end
    --     print ("==LOGIN_GET_HERO_LIST== accout :", data.account)

    --     -- local event = cc.EventCustom:new(NetMessageType.LOGIN_GET_HERO_LIST.HEAD)
    --     -- event._usedata = data
    --     -- cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
    --     local event = {}
    --     event.data = data
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_LOGIN_GET_HERO_LIST, event)

    -- elseif (no == NetMessageType.LOGIN_VERIFY_FAILED.NO) then
    --     for k,v in pairs(data) do
    --         print (k)
    --     end
    --     print ("==LOGIN_VERIFY_FAILED== reason :",data.reason)

    --     -- local event = cc.EventCustom:new(NetMessageType.LOGIN_VERIFY_FAILED.HEAD)
    --     -- event._usedata = data
    --     -- cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
    --     local event = {}
    --     event.data = data
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_LOGIN_LOGIN_VERIFY_FAILED, event)
    -- elseif (no == NetMessageType.LOGIN_ACCOUNT_VERIFY_RESP.NO) then
    --     local event = {}
    --     event.data = data
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_LOGIN_ACCOUNT_VERIFY, event)
    -- 没有英雄账号
    elseif (no == NetMessageType.LOGIN_NO_HERO.NO) then
        print("NetMessageType.LOGIN_NO_HERO")
        isFromChangeArea = false
        isFromChangeScene = false
        UI.TipsLayer:closeSystemBusyTips()
        Avalon.MessageCenter:notice(AvalonMessage.MC_LOGIN_NO_HERO, data)
    -- 回复创建英雄结果消息(DC)
    elseif (no == NetMessageType.LOGIN_REPLY_CREATE_HERO_RESULT.NO) then    
        print("NetMessageType.LOGIN_REPLY_CREATE_HERO_RESULT")
        dump(data)

        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.CREATE_ROLE)
        local ProtobufUtil = require "utils.ProtobufUtil"
        if(data.result == ProtobufUtil:enum_id("LoginSystem.CreateHeroResult", "CreateHeroResult_Ok")) then
            RoleDataManager:setMasterPK(data.PK)

            local gameLoginManager = require("app.game.GameLoginManager")
            -- 上报创建角色成功
            gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.RoleCreate_Result)
            
            -- 处理加载页面
            Avalon.MessageCenter:notice(AvalonMessage.MC_LOGIN_ENTER_GAME)
            -- 创建角色数据上传
            -- GameDataManager:getInstance():submitExtraData(Avalon.SubmitExtraDataType.SubmitExtraDataCreateRole);

            
            gameLoginManager:getInstance():setEnterGameSubmitExtraDataType(Avalon.SubmitExtraDataType.SubmitExtraDataCreateRole)
            
            -- 标记为新账号
            gameLoginManager:getInstance():setNewAccount();
        else 
            local gameLoginManager = require("app.game.GameLoginManager")
            -- 上报创建角色失败
            gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.RoleCreate_Result,0,nil,0)
            -- 飘窗提示
            GameErrorManager:showError(data.result)
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_LOGIN_CREATE_HERO_RESULT, data)

        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.fisrt_play_game, true)
    -- 账号绑定结果 DC
    elseif (no == NetMessageType.LOGIN_REPLY_BIND_ACCOUNT_RESULT.NO) then    
        -- TODO 处理账号绑定结果
        print("NetMessageType.LOGIN_REPLY_BIND_ACCOUNT_RESULT")
        dump(data)
        
        local ProtobufUtil = require "utils.ProtobufUtil"
        if(data.result == ProtobufUtil:enum_id("LoginSystem.BindAccountResult", "BindAccountResult_Ok")) then 
            -- 处理绑定成功，进入加载页面，进入开始游戏页面
            local gameLoginManager = require("app.game.GameLoginManager")
            gameLoginManager:getInstance():bindSuccess()
            -- 先处理数据.再通知刷新界面.否则拿不到正确的渠道
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_LOGIN_BIND_SUCCESS, data)
            UI.ScrollBar:createByText(UI.TEXT_111146)
        else
            -- 绑定失败处理
            if data.result == ProtobufUtil:enum_id("LoginSystem.BindAccountResult", "BindAccountResult_AlreadyBind") then
                UI.ScrollBar:createByText(UI.TEXT_111158)
            elseif data.result == ProtobufUtil:enum_id("LoginSystem.BindAccountResult", "BindAccountResult_AccountHasHero") then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_LOGIN_BIND_FAILS_HASHERO, data)
            else
                GameErrorManager:showError(data.result)
            end
            SdkBox:getInstance():logout(true, true)
            SdkBox:getInstance():saveUserDataLoginType(PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_GUEST)
        end
    -- 登出账号返回
    elseif (no == NetMessageType.LOGIN_LOGIN_OUT_GAME.NO) then    
        print("LOGIN_LOGIN_OUT_GAME")
        dump(data)
        local isLogoutSdk = false
        local ProtobufUtil = require "utils.ProtobufUtil"
        local rtext = UI.TEXT_1110372
        if data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "Manual") then
            -- 客户端玩家手动退出
            return
        elseif data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "LoginByOther")
            or data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "ChangeArea") then
            rtext = UI.TEXT_111151     
            -- 标记为被顶号
            local gameLoginManager = require("app.game.GameLoginManager")
            gameLoginManager:getInstance():setAccountReplace();
            isLogoutSdk = true
        elseif data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "KickByGM") then
            rtext = UI.TEXT_1170944
        elseif data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "GateQuit") or
            data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "SceneQuit") then
            rtext = UI.TEXT_1170943
        elseif data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "SceneError") then 
            rtext = UI.TEXT_1170943
        elseif data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "KickAllByGm") then
            rtext = UI.TEXT_1170951
        elseif data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "AuthTime") then
            rtext = LanguageManager:getInstance():getLocalString(1112369)
            local versionTarget = SdkBox:getInstance():getVersionTarget()
            if (versionTarget ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL) then
                isLogoutSdk = true
            end
        elseif data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "AuthOnLine") then
            rtext = LanguageManager:getInstance():getLocalString(1112369)
            local versionTarget = SdkBox:getInstance():getVersionTarget()
            if (versionTarget ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL) then
                isLogoutSdk = true
            end
        elseif data.reason == ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "KickByGMSilent") then
            rtext = LanguageManager:getInstance():getLocalString(1113855)
        elseif data.reason > 0 then
            rtext = UI.TEXT_111027
        end
        
        UI.TipsLayer:createLoginOutGameTips(rtext, isLogoutSdk)

        -- local tips = UI.Tips:createTips(rtext,UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL,nil,nil,false)
        -- tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        --     -- 关闭连接
        --     Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
        --     Game.Manager:clearScene()
        --     local SceneManager = require("app.game.SceneManager")
        --     SceneManager:getInstance():startLoginScene()
        -- end)
        -- tips.touchDialogOutsizeClose = false;
        
        -- local tipsParentLayer = cc.Director:getInstance():getRunningScene()
        -- tipsParentLayer:addChild(tips)

        -- tips:setLocalZOrder(UI_ZORDER.RECONNECT_TIPS)
    elseif no == NetMessageType.LOGIN_ADDICTION_RESULT.NO then
        MasterDataManager:setAntiData(data)

        local AntiAddictionUtil = require("app.utils.AntiAddictionUtil")
        AntiAddictionUtil:doLoginActions()

    elseif no == NetMessageType.LOGIN_RESP_AREA_LIST.NO then
        -- 返回服务器逻辑分区数据
        mvc.send(mvc.events.Setting_Area_Server_RespAreaList, data)
    elseif no == NetMessageType.LOGIN_NOTIFY_CLIENT_DO_SOMETHING_MESSAGE.NO then
        --加载关键字屏蔽  data.type == PublicDefine.SomethingType.SomethingType_ReloadDirtyWords 时执行这个代码.  因为目前只有一个类型,就没判断了.
        ToolsUtil:httpGetMaskword()
    elseif no == NetMessageType.LOGIN_RES_HERO_CONNECTON_INFO_MESSAGE.NO then
        dump(data, "LOGIN_RES_HERO_CONNECTON_INFO_MESSAGE1")
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_ROLE_IP, data)
    else
        assert(false, string.format("LoginManager:onNetMessageHandler no %d is invaild.", no))
    end
end


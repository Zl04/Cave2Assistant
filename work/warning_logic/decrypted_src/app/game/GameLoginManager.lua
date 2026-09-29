--[[
    游戏登录管理
]]--

require "utils.AvalonUtil"
require "app.utils.ToolsUtil"

local SceneManager = require("app.game.SceneManager")
local GameInCaveManager = require("app.game.GameInCaveManager")
local GameLoginManager = class("GameLoginManager")
local GameDataManager = require("app.game.GameDataManager")
local SdkManager = require"app.game.SdkManager"
require "app.datas.TitleDataManager"
require "app.datas.GuildBoxDataManager"
g_GameLoginManager = nil;
local firstReportLoginStep = true;
function GameLoginManager:getInstance()
    if g_GameLoginManager == nil then
        g_GameLoginManager = GameLoginManager.new()
    end
    return g_GameLoginManager;
end

function GameLoginManager:purgeInstance()
    if g_GameLoginManager ~= nil then
        g_GameLoginManager = nil;
    end
end

function GameLoginManager:ctor()
    self._heroListData = nil;
    self._account = nil
    self._versionChannel = nil;
    self._versionAccount = nil
    self._nickName = nil;
    
    self._bindNickName = nil;
    self._testAccount = nil;
    self._serverName = "";
    self._serverId = -1;
    -- 用户处理指定的区服 -1 或者不设置表示服务器默认值, 改值在enter_scene 消息后会被清除
    self._areaID = -1;   
    
    -- 是否已经加载了loading 页面动画资源
    self._isLoadLoadingSpine = false
end

function GameLoginManager:setNickName(nickName)
    self._nickName = nickName
end

function GameLoginManager:setAccountId(account)
    self._account = account
end

function GameLoginManager:setVersionAccount(versionAccount)
    self._versionAccount = checkint(versionAccount)
end

function GameLoginManager:setVersionChannel(channel)
    self._versionChannel = channel 
end

function GameLoginManager:setServerUrl(serverUrl) 
    self._serverUrl = serverUrl
end
function GameLoginManager:setServerName(serverName)
    self._serverName = serverName
end
function GameLoginManager:setServerPort(port)
    if(port) then
        self._port = tonumber(port)
    else 
        self._port = port
    end
end
function GameLoginManager:setServerId(id)
    self._serverId = id
end
function GameLoginManager:getServerName()
    return self._serverName
end
function GameLoginManager:getServerId()
    return checkint(self._serverId)
end
function GameLoginManager:getTestAccount()
    return self._testAccount
end
function GameLoginManager:getAccountId()
    return self._account
end
function GameLoginManager:getVersionAccount()
    return self._versionAccount
end
function GameLoginManager:getVersionChannel()

    return self._versionChannel
end

function GameLoginManager:getServerUrl()
    return self._serverUrl
end

function GameLoginManager:getServerPort()
    return self._port
end
function GameLoginManager:getNickName()
    return self._nickName
end

function GameLoginManager:clearLoginData()
    self._account = nil
    self._serverUrl = nil
    self._port = nil
    self._nickName = nil;
end

-- 设置绑定服务器数据
function GameLoginManager:setBindAccountId(account)
    self._bindAccountId = account
end
function GameLoginManager:setBindVersionChannel(channel) 
    self._bindVersionChannel = channel
end
function GameLoginManager:setBindVersionAccount(versionAccount) 
    self._bindVersionAccount = versionAccount
end
function GameLoginManager:setBindNickName(setNickName)
    self._bindNickName = setNickName
end

function GameLoginManager:setAreaID(id)
    self._areaID = id
end

function GameLoginManager:getAreaID()
    return self._areaID
end

-- 设置进入游戏类型， 用于向SDK提交相关数据
function GameLoginManager:setEnterGameSubmitExtraDataType(extraType)
end

function GameLoginManager:sendSubmitExtraData()
end
-- 激活游戏
function GameLoginManager:activity()
    GameDataManager:getInstance():activity()
end
function GameLoginManager:loginreport()
    GameDataManager:getInstance():loginreport()
    if GameDataManager:getInstance()._isNewAccount == 1 then
        GameDataManager:getInstance():submitExtraData(Avalon.SubmitExtraDataType.SubmitExtraDataCreateRole)
    end
    GameDataManager:getInstance():submitExtraData(Avalon.SubmitExtraDataType.SubmitExtraDataLoginRole)
end
function GameLoginManager:logoutreport()
    GameDataManager:getInstance():logoutreport()
end
function GameLoginManager:setAccountReplace()
    GameDataManager:getInstance():setAccountReplace()
end

function GameLoginManager:setNewAccount()
    GameDataManager:getInstance():setNewAccount()
end

function GameLoginManager:getBindVersionChannel()
    return self._bindVersionChannel
end

-- 获取服务器账号ID
function GameLoginManager:getBindServerAccount()
    return self._bindAccountId
end

-- 登出游戏
function GameLoginManager:loginOutGame()
    print("GameLoginManager:loginOutGame")
    -- 记录登出游戏
    self:logoutreport();
    SdkManager:purgeInstance();
    --
    Net.NetLoginSystem:loginOutGame(GameDataManager:getInstance():getMasterPK())
    -- 关闭连接
    Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
    --todo
    Net.Helper:clearQueue()
    -- 退出相关的数据逻辑
    SceneManager:getInstance():exitCurrentState()
    -- 清理相关的数据
    GameManager:clearScene()
    -- 清除称号
    TitleDataManager:clear()    
    GuildBoxDataManager:clear()
    -- 清除防沉迷数据
    require "app.utils.AntiAddictionUtil"
    AntiAddictionUtil:clear()
    collectgarbage("collect")
    isFromChangeArea = false
    isFromChangeScene = false
    -- 跳转界面
    self:startLogin()

    local GameInPortManager = require "app.game.GameInPortManager"
    GameInPortManager:getInstance():purgeInstance()
end

-- 切换区服
function GameLoginManager:changeServerArea()
    print("GameLoginManager:changeServerArea")
    -- 记录登出游戏
    -- self:logoutreport();
    -- SdkManager:purgeInstance();
    UI.UIManager.cannotRecconnect = true
    --
    local ProtobufUtil = require("utils.ProtobufUtil")
    Net.NetLoginSystem:loginOutGame(GameDataManager:getInstance():getMasterPK(), ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "ChangeArea"))

    Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
        -- 关闭连接
        Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
        --todo
        Net.Helper:clearQueue()
        -- 退出相关的数据逻辑
        SceneManager:getInstance():exitCurrentState()
        -- 清理相关的数据
        GameManager:clearScene()
        -- 清除称号
        TitleDataManager:clear()    
        GuildBoxDataManager:clear()
        -- 清除防沉迷数据
        require "app.utils.AntiAddictionUtil"
        AntiAddictionUtil:clear()
        collectgarbage("collect")
        print("GameLoginManager isFromChangeArea", isFromChangeArea)
        isFromChangeArea = true
        -- -- 跳转界面
        self:startLogin()


        -- require "app.scene.mainscene.ReConnectUtil"
        -- SceneManager:getInstance():replaceLoadingScene()
        -- ReconnectUtil:tryConnectToGameServer()
    end, 0.5)
end

-- 切换场景
function GameLoginManager:changeScene()
    print("GameLoginManager:changeServerArea")
    UI.UIManager.cannotRecconnect = true
    --
    local ProtobufUtil = require("utils.ProtobufUtil")
    Net.NetLoginSystem:loginOutGame(GameDataManager:getInstance():getMasterPK(), ProtobufUtil:enum_id("LoginSystem.LoginOutGameReason", "NetDisconnected"))

    Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
        -- 关闭连接
        Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
        --todo
        Net.Helper:clearQueue()
        -- 退出相关的数据逻辑
        SceneManager:getInstance():exitCurrentState()
        -- 清理相关的数据
        GameManager:clearScene()
        -- 清除称号
        TitleDataManager:clear()    
        GuildBoxDataManager:clear()
        -- 清除防沉迷数据
        require "app.utils.AntiAddictionUtil"
        AntiAddictionUtil:clear()
        collectgarbage("collect")
        print("GameLoginManager isFromChangeScene", isFromChangeScene)
        isFromChangeScene = true
        isFromChangeSceneUsedInEnterScence = true
        -- -- 跳转界面
        self:startLogin()
    end, 0.5)
end

-- 绑定账号成功
function GameLoginManager:bindSuccess()
    -- TODO 处理进入主页面，并且显示开始游戏页面
    -- Net.NetLoginSystem:loginOutGame()
    --  -- 关闭连接
    -- Net.NetInnerSystem:disconnect(Net.MAIN_SERVER)
    self:changeBindToLogin()
    -- -- 跳转界面
    -- self:startLogin()
end

-- 绑定失败，切换账号
function GameLoginManager:bindFailsChangeAccount()
    self:changeBindToLogin()
    self:loginOutGame()
end

function GameLoginManager:changeBindToLogin()
    -- 设置最新的状态
    self:setAccountId(self._bindAccountId)
    self:setVersionAccount(self._bindVersionAccount)
    self:setNickName(self._bindNickName)
    -- 设置最新的登录状态
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    if(globalUserData) then
        globalUserData:setLoginType(self._versionAccount)
        -- 存入本地
        Avalon.UserDataManager:saveDataToFile(globalUserData:getType());
    end
end

-- 验证
function GameLoginManager:onVerify()
    -- 加上test_前缀作为测试账号标识
    -- if(DEVELOPMENT_LOGIN) then
    --     local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    --     if (cc.PLATFORM_OS_MAC  == targetPlatform) then
    --         print("GameLoginManager:onVerify  ", "test_"..AvalonUtil.getIdentifier().."538")
    --         Net.NetLoginSystem:verify("test_"..AvalonUtil.getIdentifier(),"key456")
    --     else
    --         if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
    --             local identify = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify,"")
    --             if(identify == "") then
    --                 identify = string.format("test_%d:%d", AvalonUtil.getCurrentTime(), math.random(100000,10000000))
    --                 cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.identify, identify)
    --             end

    --             Net.NetLoginSystem:verify(identify, "key456")
    --             -- Net.NetLoginSystem:verify("38:C9:86:43:13:4E536", "key456")
    --         else
    --             Net.NetLoginSystem:verify(AvalonUtil.getIdentifier(), "key456")
    --         end
    --     end
    -- else 
        -- 获取账号信息
        local account = self:getInstance():getAccountId()

        print("GameLoginManager:onVerify() account=", account)
        --TODO 测试逻辑
        if(account == nil) then
            -- local targetPlatform = cc.Application:getInstance():getTargetPlatform()
            -- if (cc.PLATFORM_OS_MAC  == targetPlatform) then
            --     local newID = "test_504512131"..AvalonUtil.getIdentifier()..""
            --     print("GameLoginManager:onVerify  ",newID )
            --     Net.NetLoginSystem:verify(newID,"key456")
            --     self._testAccount = newID
            -- else
                if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
                    local identify = cc.UserDefault:getInstance():getStringForKey(UserDefaultKeyWord.identify,"")
                    if(identify == "") then
                        identify = string.format("test_%d:%d", AvalonUtil.getCurrentTime(), math.random(100000,10000000))
                        cc.UserDefault:getInstance():setStringForKey(UserDefaultKeyWord.identify, identify)
                    end

                    account = identify
                else
                    account = AvalonUtil.getIdentifier()
                end
                self._testAccount = account
            -- end
            print("GameLoginManager:onVerify() addTest account=", account)
        end

        Net.NetLoginSystem:verify(account)
    -- end
end

-- 选择角色
function GameLoginManager:onSelectRole()
    GameManager:initGameModules()
    self:endLogin()
    SceneManager:getInstance():replaceLoadingScene()
end

-- 设置角色数据
function GameLoginManager:setHeroListData(data)
    print("Manager:setHeroListData  ",data)
    self._heroListData = data
end

-- public:
-- 开始登录
function GameLoginManager:startLogin()
    print("GameLoginManager:startLogin")
    SceneManager:getInstance()._state = GameState.LOGIN

    Avalon.issUtil:updateSafeRect()

    -- 创建登录场景
    local loginScene = cc.Layer:create()

    -- 创建登录UI层
    local uiLayer = UI.UIManager:loadLoginUI()
    loginScene:addChild(uiLayer, 2)

    -- 创建登录主层
    require "app.scene.mainscene.MainLayer"
    local mainLayer = UI.MainLayer:create()
    mainLayer:init()
    -- mainLayer:addEventListener(UI.Event.EVENT_SELECT_ROLE, self, GameLoginManager.onSelectRole)
    loginScene:addChild(mainLayer, 1)

    -- 替换登录场景
    SceneManager:getInstance():replaceScene(loginScene)
    
    -- 结束载入场景
    SceneManager:getInstance():endLoadingScene()
    Avalon.AudioManager:stopMusic()

    --加载关键字屏蔽
    ToolsUtil:httpGetMaskword()
end

-- 完成登录
function GameLoginManager:endLogin()
    UI.UIManager:unloadLoginUI()
end

function GameLoginManager:loginEnterCave()
    -- GameInCaveManager:getInstance():enterCave()
    -- 进入加载场景
    SceneManager:getInstance():replaceLoadingScene()
end

function GameLoginManager:getIsLoadLoadingSpine()
    return self._isLoadLoadingSpine
end

function GameLoginManager:setIsLoadLoadingSpine()
    self._isLoadLoadingSpine = true
end

-- 像web服务器上报登陆过程进度
-- step
-- platform
-- zone
-- channel
-- account
-- accountStr
-- pk
-- nickname
-- phoneInfo
-- phoneVersion
-- phoneLocation
-- idfa
-- imei
-- adid
-- mac
-- isSuccess
-- openuuid 
function GameLoginManager:reportLoginStep(step,subStep,params,result, always)
    require("app.utils.ServerConfigUtil")
    local is_first_report = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.is_first_report, false)
    if always == nil or not always then
        --is_first_report = false
        print("is_first_report",is_first_report)
        -- 如果不是第一次激活,并且不是热更新和强更新相关的,不记录
        if  is_first_report  
        and step ~= PublicDefine.LoginLogType.App_Update
        and step ~= PublicDefine.LoginLogType.Hotfix_Start
        and step ~= PublicDefine.LoginLogType.Hotfix_Error
        and step ~= PublicDefine.LoginLogType.Hotfix_Success
        then
            return;
        end
    end
    -- 如果第一次登陆流程走完了才标记为旧玩家。不再记录。
    if not is_first_report and step >= PublicDefine.LoginLogType.EnterGameDone  then
        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.is_first_report, true)
        is_first_report = true;
    end
    require "cocos.cocos2d.json"
    local SdkBox = require("utils.sdkbox.SdkBox")
    local sdkbox = SdkBox:getInstance()

    local heroData = RoleDataManager:getMaster()
    -- 1代表成功,默认都是成功
    result = result or 1
    subStep = subStep or 0
    -- 拓展参数 json格式,同样劲量不为空
    params = params or {}
    local ext = json.encode(params)
    
   
    local tableData = {}
    tableData.step = checkint(step)
    tableData.subStep = checkint(subStep)
    tableData.openuuid = AvalonUtil.getOpenUUID()
    tableData.platform = checkint(sdkbox:getVersionPlatform())
    tableData.zone = checkint(ServerConfigUtil:getZoneId())
    tableData.channel = checkint(sdkbox:getVersionChannel())
    tableData.account =  sdkbox:getVersionAccount()
    tableData.accountStr =tostring(self:getAccountId() or "")
    if RoleDataManager:getMasterPK() > 0 then
        tableData.pk = RoleDataManager:getMasterPK()
    end
    
    tableData.clientVersion = Avalon.HotfixManager:getLocalVersion()
    tableData.clientBuild = Avalon.HotfixManager:getLocalBuild()
    if heroData and heroData.getNickName then
        tableData.nickname = heroData:getNickName()
    else
        tableData.nickname = ""
    end
    

    tableData.phoneInfo = AvalonUtil.getDeviceName()
    tableData.phoneVersion = AvalonUtil.getSystemVersion()
    tableData.phoneLocation = AvalonUtil.getLocation()
    tableData.idfa = AvalonUtil.getIDFA()
    tableData.imei = AvalonUtil.getIMEI()
    tableData.adid = AvalonUtil.getADID()
    tableData.mac = AvalonUtil.getMAC()
    tableData.oaid = AvalonUtil.getOAID()
    tableData.isNewDevice = ifelse(is_first_report == true,0,1)
    tableData.isSuccess = checkint(result)


    tableData.ext = ext
    tableData.costSecond = 0;

    -- 记录和上一次的时间差
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    if(globalUserData) then
        local lastTime = globalUserData:getReportLoginStepTime()
        if lastTime == 0 then
            tableData.costSecond = 0;
        else
            local costTime = os.time() - lastTime
            if costTime <= 0 then
                costTime = 0
            end
            tableData.costSecond = costTime;
        end
        globalUserData:markReportLoginStepTime()
        Avalon.UserDataManager:saveDataToFile(globalUserData:getType());
        
    end
    if firstReportLoginStep then
        tableData.costSecond = 0;
        firstReportLoginStep = false;
    end
    print(string.format("GameLoginManager:reportLoginStep() start!  step = %d result = %s",step ,result),ServerConfigUtil:getZoneId())
    Net.Helper:sendHttpMessage(Net.HttpSubDirection.LoginStep,tableData,function(response)
        
        print(string.format("GameLoginManager:reportLoginStep() succ!  step = %d result = %s",step ,result))
    end,function(readyState,status)
        printWarn("GameLoginManager:reportLoginStep() fail!  step = %d result = %s",step ,result)
    end)
    --add by zp s3打点
    Avalon.AWSLogUtil:sendAWSLOGINInfo(tableData)
end

return GameLoginManager;

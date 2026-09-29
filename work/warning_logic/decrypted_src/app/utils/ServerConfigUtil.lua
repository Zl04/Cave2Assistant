local SdkBox = require("utils.sdkbox.SdkBox")
local LanguageManager = require("app.game.LanguageManager")
local GameLoginManager = require("app.game.GameLoginManager")

require("utils.Scheduler")
require("utils.AvalonUtil")
require("utils.userdata.UserDataManager")
require("utils.net.NetMessage")

ServerConfigUtil = ServerConfigUtil or {}

local HTTP_RETRY_INTERVAL = 5
local HTTP_TIMEOUT_FAIL_NUM = 4

local queryAntiAddictionTryNum = 0
local queryConfigTryNum = 0
local gotReviewResponse = false
local gotServerListResponse = false
local gotGameLoginResponse = false
local gotValidData = false

-- *沈河*阶段返回
local isReview = false
local loginVerifyUrl = nil
local delayCollectionUrl = nil
local webUrl = nil
local hotFixManifestUrl = nil
local hotFixPackageUrl = nil
local hotFixVersion = nil
local forceUpdateBuild = nil
local forceUpdateUrl = nil
local assetsUrl = nil
local isTestEnv = nil
local verifyUrl = nil
-- 服务器列表阶段返回
local serverList = nil
local currentCfg = nil
local webManageUrl = nil
local webConfiguredBundleId = nil
local webConfiguredCommentUrl = nil

-- 第三方SDK登录验证后获得
local avalonLoginToken = nil
local nickName = nil
local playerID = nil
local projectId = nil --web 的工程ID， 区分 预发布、审核、正式服
local sdkToken = nil

-- 防沉迷验证获得
local aaIsGuest = nil
local aaIDCard = nil
local aaAge = nil
local aaAuth = nil

-- 选区相关的流程  key={cfg.id={areaServerData,...}, cfg.id={areaServerData,...}}
local areaServerArr = {}
local nowChoiceAreaServer = nil

-- 请求失败处理
local function failRetryCallback(self, logPrefix, retryCallback, tryNumOverLimitCallback)
    logPrefix = logPrefix or "ServerConfigUtil:queryServerConfig 失败重试连接"
    queryConfigTryNum = queryConfigTryNum + 1
    if (queryConfigTryNum < HTTP_TIMEOUT_FAIL_NUM) then
        printWarn(logPrefix, queryConfigTryNum)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            if (retryCallback) then retryCallback() end
        end, 0.1)
    else
        queryConfigTryNum = 0
        if (tryNumOverLimitCallback) then tryNumOverLimitCallback() end
    end
end

-- 请求评审状态， 返回一些后面要用的数据
function ServerConfigUtil:queryServerReviewConfig(forcedUpdateCallback, hotfixCallback, successCallback, timeoutCallback, unkownStatusCallback)
    -- 检查URL
    if (not SERVER_CONFIG_URL) then
        printError("ServerConfigUtil:queryServerReviewConfig, SERVER_CONFIG_URL不存在")
        if (timeoutCallback) then timeoutCallback() end
        return
    end

    -- 生成请求参数
    local platform = PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS
    if (device.platform == "android") then
        platform = PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID
    end
    local deviceId = AvalonUtil.getDeviceID()
    if (SdkBox:getInstance():getVersionTarget() == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL or 
        deviceId:lower() == "unknown" or deviceId:lower() == "avalon_unknown") 
    then
        deviceId = AvalonUtil.getOpenUUID() -- 适合的情况下用UUID代替IMEI
    end 
    require("utils.HotfixManager")
    local params = {
        platform = platform,
        deviceId = deviceId, 
        channel = SdkBox:getInstance():getVersionChannel(),
        version = Avalon.HotfixManager:getLocalVersion(),
        build = AvalonUtil.getPackageBuild()
    }
    print("ServerConfigUtil:queryServerReviewConfig, 请求*沈河*状态参数", params)
    -- 检查URL是否被重定向
    if avalon.Util.getCustomMainUrl then
        local customUrl = avalon.Util:getCustomMainUrl()
        if customUrl and customUrl ~= "" then
            SERVER_CONFIG_URL = customUrl
            printWarn("URL被重定向",customUrl)
        end
    end
    if DEVELOPMENT_MODE and 
        (device.platform == "mac" or device.platform == "windows" or device.platform == "ios" or device.platform == "android")
    then
        local testServerConfigUrl = cc.UserDefault:getInstance():getStringForKey("TEST_SERVER_CONFIG_URL", "")
        if(testServerConfigUrl and testServerConfigUrl ~= "") then 
            SERVER_CONFIG_URL = testServerConfigUrl
        end
    end

    print("  SERVER_CONFIG_URL .. Net.HttpSubDirection.ReviewCheck ===  ",SERVER_CONFIG_URL .. Net.HttpSubDirection.ReviewCheck)

    -- 检查是否在评审中
    Net.Helper:sendHttpMessageByUrl(SERVER_CONFIG_URL .. Net.HttpSubDirection.ReviewCheck, params, function(reviewResponse)
        queryConfigTryNum = 0
        gotReviewResponse = true

        -- 解开JSON并设置获取到的数据
        local data = json.decode(reviewResponse)
        print("ServerConfigUtil:queryServerReviewConfig, 获得Web返回数据:", data)
        if data.projectId ~= nil and data.projectId ~= "" then
            projectId = data.projectId
        end
        if (projectId == "cave_online_all_internal" or projectId == "cave_online_beta_internal" or
            projectId == "cave_online_trunk_internal") and CONFIG_HOTFIX == false then  --CO-内网测试(beta)  CO-内网测试(主干) CO-内网测试(official)   
            if data.loginStatus == PublicDefine.LoginStatus.NeedForceUpdate or data.loginStatus == PublicDefine.LoginStatus.NeedHotFix then
                data.loginStatus = PublicDefine.LoginStatus.Success
            end
        end
        isTestEnv = data.isTestEnv
        -- 成功获取数据, 处理登录状态
        self:parseLoginStatusAndParams(
            data,                   -- 原始数据
            forcedUpdateCallback,   -- 强更回调
            hotfixCallback,         -- 热更回调
            function(data)              -- 成功回调
                isReview = data.isReview
                webUrl = data.webUrl
                loginVerifyUrl = data.loginVerifyUrl
                delayCollectionUrl = data.delayCollectionUrl
                projectId = data.projectId
                assetsUrl = data.assetsUrl
                verifyUrl = data.verifyUrl
                self:setWebManageUrl(data.webManageUrl)
                if (successCallback) then successCallback(data) end
            end,
            unkownStatusCallback)   -- 未知状态码回调
    end, function(readyState, status)
        if DEVELOPMENT_MODE then
            local testServerConfigUrl = cc.UserDefault:getInstance():getStringForKey("TEST_SERVER_CONFIG_URL", "")
            if(testServerConfigUrl and testServerConfigUrl ~= "") then 
                cc.UserDefault:getInstance():setStringForKey("TEST_SERVER_CONFIG_URL", "")
                require "app.ui.common.Dialog.ScrollBar" 
                UI.ScrollBar:createByText("已经清空了切换服务器配置，请重启客户端后重新配置连接服务器列表")
            end
        end

        -- 失败重试
        failRetryCallback(
            self, 
            "========重试连接评审服务器:" .. SERVER_CONFIG_URL,    -- 日志信息
            function()                            -- 重试回调 
                self:queryServerReviewConfig(forcedUpdateCallback, hotfixCallback, successCallback, timeoutCallback) 
            end,
            timeoutCallback)                      -- 超过重试次数回调
    end, HTTP_RETRY_INTERVAL) -- 5秒超时
end

-- 向WEB请求服务器列表
function ServerConfigUtil:queryServerListConfig(forcedUpdateCallback, hotfixCallback, successCallback, timeoutCallback, unkownStatusCallback)
    -- 检查URL
    if (not webUrl) then
        printError("ServerConfigUtil:queryServerListConfig, webUrl不存在")
        if (timeoutCallback) then timeoutCallback() end
        return
    end

    -- 生成请求参数
    local params = {
        channel = SdkBox:getInstance():getVersionChannel(),
        languageType = LanguageManager:getInstance():getLanguage()
    }
    printInfo("ServerConfigUtil:queryServerListConfig, 请求服务器列表参数", params)

--print("    webUrlwebUrlwebUrl  ServerConfig ====   ",webUrl .. Net.HttpSubDirection.ServerConfig)
--print("params.channel ===== ",params.channel)
--print("params.languageType ===== ",params.languageType)

    -- 获取服务器配置
    Net.Helper:sendHttpMessageByUrl(webUrl .. Net.HttpSubDirection.ServerConfig, params, function(response)
        queryConfigTryNum = 0
        gotServerListResponse = true
        
        -- 解开JSON并设置获取到的数据
        local data = json.decode(response)
        printInfo("ServerConfigUtil:queryServerListConfig, 获得Web返回数据:", data)

        -- print("ServerConfigUtil:queryServerListConfig, 获得Web返回数据 ===== ")
        -- dump(data,nil,10)


--for k,v in pairs(data.serverList) do
--    print("data.serverList ===== ",v)
--end

        -- -- 临时测试
        -- if (data and data.serverList and #data.serverList > 0) then
        --     local serverTemplate = nil
        --     for i,serverConf in ipairs(data.serverList) do
        --         if (serverConf.id == 3) then
        --             serverTemplate = serverConf
        --         end
        --     end
        --     if (serverTemplate) then
        --         local dummyServerList = {}
        --         local singaporeConf = clone(serverTemplate)
        --         singaporeConf.name = "Singapore"
        --         singaporeConf.gateHost = "cave2-all-sg-zs-game-0000.avalongames.com"
        --         singaporeConf.gatePort = 12001
        --         singaporeConf.id = 0
        --         table.insert(dummyServerList, singaporeConf)

        --         local koreaConf = clone(serverTemplate)
        --         koreaConf.name = "Korea"
        --         koreaConf.gateHost = "cave2-all-kr-zs-game-0000.avalongames.com"
        --         koreaConf.gatePort = 12001
        --         koreaConf.id = 1
        --         table.insert(dummyServerList, koreaConf)

        --         data.serverList = dummyServerList
        --     end
        -- end

        local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)

        -- print("渠道号 channelchannelchannel ===== ",channel)
        local filtServerList = {}
        if CAVEOL_TARGET == CAVEOL_TARGET_CN then
            if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING or 
            channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE or 
            channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_QUICK  then
                filtServerList = data.serverList--正式服
            else
                local targetId = 1
                if channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_BILIBILI then
                    targetId = 1 --B站
                else
                    targetId = 2 --新增的渠道服
                end

                for k, v in pairs(data.serverList) do
                    if v.id == targetId then
                        table.insert(filtServerList, v)
                    end
                end
                if #filtServerList == 0 then
                    for i = 1, 3 do
                        UI.ScrollBar:createByText("server error no n"..targetId)
                    end
                end
                -- filtServerList = data.serverList
            end
        else
            if (channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_XIAOMI) then
                local targetId = 2

                for k, v in pairs(data.serverList) do
                    if v.id == targetId then
                        table.insert(filtServerList, v)
                    end
                end
                if #filtServerList == 0 then
                    for i = 1, 3 do
                        UI.ScrollBar:createByText("server 222 error no n"..targetId)
                    end
                end

            else
                filtServerList = data.serverList
            end
        end
        -- 成功获取数据, 处理登录状态
        self:parseLoginStatusAndParams(
            data,                   -- 原始数据
            forcedUpdateCallback,   -- 强更回调
            hotfixCallback,         -- 热更回调
            function(data)          -- 成功回调
                serverList = filtServerList
                self:setWebManageUrl(data.webManageUrl)
                webConfiguredBundleId = data.bundleId
                webConfiguredCommentUrl = data.commentUrl
                if (successCallback) then successCallback(data) end
            end,
            unkownStatusCallback)   -- 未知状态码回调
    end,function(readyState,status)
        -- 失败重试
        failRetryCallback(
            self, 
            "========重试连接配置服务器: " .. webUrl, -- 日志信息 
            function()                          -- 重试回调
                self:queryServerListConfig(forcedUpdateCallback, hotfixCallback, successCallback, timeoutCallback)
            end, 
            timeoutCallback)                    -- 超过重试次数回调
    end, HTTP_RETRY_INTERVAL) -- 5秒超时
end

-- 向WEB请求区服信息
function ServerConfigUtil:queryAreaListConfig(forcedUpdateCallback, hotfixCallback, successCallback, timeoutCallback, unkownStatusCallback)
    local webUrl = verifyUrl

    -- 检查URL
    if (not webUrl) then
        printError("ServerConfigUtil:queryAreaListConfig, webUrl不存在")
        if (timeoutCallback) then timeoutCallback() end
        return
    end

    -- 生成请求参数
    local params = {
    }
    printInfo("ServerConfigUtil:queryAreaListConfig, 请求服务器列表参数", params)
    local zoneID = ServerConfigUtil:getZoneId() or "0"
    local gameLoginManager = require("app.game.GameLoginManager")
    
    local account = ServerConfigUtil:getAccountId()
    local accountID = account or ""
    local fullWebUrl = webUrl.. string.format(Net.HttpSubDirection.AreaServer, tostring(zoneID), tostring(accountID))
    printInfo("ServerConfigUtil:queryAreaListConfig, fullWebUrl", fullWebUrl)
    -- 获取服务器配置
    Net.Helper:sendNormalHttpGet(fullWebUrl, params, function(response)
        queryConfigTryNum = 0
        gotServerListResponse = true
        
        -- 解开JSON并设置获取到的数据
        local data = json.decode(response)
        print("ServerConfigUtil:queryAreaListConfig, 获得Web返回数据:", data)
        ServerConfigUtil:handleAreaData(data.data)
        if (successCallback) then successCallback(data) end
    end,function(readyState,status)
        print("ServerConfigUtil:queryAreaListConfig, 请求失败:", data)

        if(timeoutCallback) then 
            timeoutCallback()
        end
        -- 失败重试
        -- failRetryCallback(
        --     self, 
        --     "========重试连接配置服务器: " .. webUrl, -- 日志信息 
        --     function()                          -- 重试回调
        --         self:queryAreaListConfig(forcedUpdateCallback, hotfixCallback, successCallback, timeoutCallback)
        --     end, 
        --     timeoutCallback)                    -- 超过重试次数回调
    end, 2) -- 5秒超时
end

-- 海外IOS 向WEB请求区服信息, 用于获取所有服务器列表中存在的角色数据(目前取当前服务器的)
function ServerConfigUtil:GlobelIOSQueryAreaListConfig(successCallback, timeoutCallback)
    local webUrl = verifyUrl

    -- 检查URL
    if (not webUrl) then
        printError("ServerConfigUtil:GlobelIOSQueryAreaListConfig, webUrl不存在")
        if (timeoutCallback) then timeoutCallback() end
        return
    end

    local gameLoginManager = require("app.game.GameLoginManager")
    local roleList = {}

    -- 生成请求参数
    local params = {
    }
    printInfo("ServerConfigUtil:GlobelIOSQueryAreaListConfig, 请求服务器列表参数", params)
    local zoneID = ServerConfigUtil:getZoneId() or "0"
    
    local account = ServerConfigUtil:getAccountId()
    local accountID = account or ""
    local fullWebUrl = webUrl.. string.format(Net.HttpSubDirection.AreaServer, tostring(zoneID), tostring(accountID))
    printInfo("ServerConfigUtil:GlobelIOSQueryAreaListConfig, fullWebUrl", fullWebUrl)

    -- 获取服务器配置
    Net.Helper:sendNormalHttpGet(fullWebUrl, params, function(response)
        -- 解开JSON并设置获取到的数据
        local data = json.decode(response)
        print("ServerConfigUtil:GlobelIOSQueryAreaListConfig, 获得Web返回数据:", data)

        if data.data and data.data.areas and data.data.heroes then
            for _, heroData in pairs(data.data.heroes) do
                table.insert(roleList,heroData)
            end
        end
        
        if (successCallback) then successCallback(roleList) end
    end,function(readyState,status)
        print("ServerConfigUtil:GlobelIOSQueryAreaListConfig, 请求失败:", data)

        if(timeoutCallback) then 
            timeoutCallback()
        end
    end, 2)
end

-- 请求删除角色消息
function ServerConfigUtil:deleteAccountRoleData(callfuncSuccess)
    local vUrl = self:getLoginVerifyUrl()
    if not vUrl then
        return
    end

    local params = {}
    params.avalonLoginToken = self:getAvalonLoginToken()
    local url = vUrl .. "/apply-account-delete"

    Net.Helper:sendHttpMessageByUrl(url, params, callfuncSuccess, function(readyState,status)
        -- 失败重试
    end, HTTP_RETRY_INTERVAL) -- 5秒超时

end

-- 立即删除角色消息
function ServerConfigUtil:immediatelyDeleteAccountRoleData(loginToken,callfuncSuccess)
    local vUrl = self:getLoginVerifyUrl()
    if not vUrl then
        return
    end

    local params = {}
    params.avalonLoginToken = loginToken
    local url = vUrl .. "/do-account-delete"

    Net.Helper:sendHttpMessageByUrl(url, params, function(response)
        -- 解开JSON并设置获取到的数据
        local data = json.decode(response)
        printInfo("ServerConfigUtil:immediatelyDeleteAccountRoleData, 获得Web返回数据:", data)

        self:setAvalonLoginToken(data.newAvalonLoginToken)

        if callfuncSuccess then
            callfuncSuccess()
        end
        
    end, function(readyState,status)
        -- 失败重试
    end, HTTP_RETRY_INTERVAL) -- 5秒超时

end

-- 解除删除角色消息
function ServerConfigUtil:liftDeleteAccountRoleData(loginToken,callfuncSuccess)
    local vUrl = self:getLoginVerifyUrl()
    if not vUrl then
        return
    end

    local params = {}
    params.avalonLoginToken = loginToken
    local url = vUrl .. "/cancel-account-delete"

    Net.Helper:sendHttpMessageByUrl(url, params, function(response)

        if callfuncSuccess then
            callfuncSuccess()
        end
        
    end, function(readyState,status)
        -- 失败重试
    end, HTTP_RETRY_INTERVAL) -- 5秒超时
end


-- 请求登录游戏
function ServerConfigUtil:queryGameLogin(forcedUpdateCallback, hotfixCallback, successCallback, timeoutCallback, unkownStatusCallback)
    -- 检查URL
    if (not self:getLoginUrl()) then
        printError("ServerConfigUtil:queryGameLogin, loginUrl不存在")
        if (timeoutCallback) then timeoutCallback() end
        return
    end

    -- 检查Token
    if (not avalonLoginToken) then
        printError("ServerConfigUtil:queryGameLogin, avalonLoginToken不存在")
        if (timeoutCallback) then timeoutCallback() end
        return
    end

    -- 生成请求参数
    local platform = PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS
    if (device.platform == "android") then
        platform = PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID
    end

    local deviceId = AvalonUtil.getDeviceID()
    if (SdkBox:getInstance():getVersionTarget() == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL or 
        deviceId:lower() == "unknown" or deviceId:lower() == "avalon_unknown") 
    then
        deviceId = AvalonUtil.getOpenUUID() -- 适合的情况下用UUID代替IMEI
    end 
    require("utils.HotfixManager")
    local params = {
        platform = platform,
        deviceId = deviceId,
        target = SdkBox:getInstance():getVersionTarget(),
        zone = checkint(self:getZoneId()),
        channel = SdkBox:getInstance():getVersionChannel(),
        subChannel = SdkBox:getInstance():getSubChannel(),
        account = SdkBox:getInstance():getVersionAccount(),
        build = AvalonUtil.getPackageBuild(),
        version = Avalon.HotfixManager:getLocalVersion(),
        avalonLoginToken = avalonLoginToken
    }
    printInfo("ServerConfigUtil:queryGameLogin, 请求登录游戏验证参数", params)

    -- CO-5444 诡异登录问题暂时强制修复
    if (params.account == 0) then
        -- 上报VersionAccount错误
        assert(false, "SdkBox:getInstance():getVersionAccount() 为 0, 验证参数为: " .. tostring(params))
    end
    -- if (SdkBox:getInstance():getVersionTarget() == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or
    --     SdkBox:getInstance():getVersionTarget() == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE)
    -- then
    --     params.account = PublicDefine.VERSION_ACCOUNT.VERSION_ACCOUNT_LEITING
    -- end
    -- print("params=", params)
    -- 获取服务器配置
    Net.Helper:sendHttpMessageByUrl(self:getLoginUrl() .. Net.HttpSubDirection.GameLogin, params, function(response)
        queryConfigTryNum = 0
        gotGameLoginResponse = true
        
        -- 解开JSON并设置获取到的数据
        local data = json.decode(response)
        printInfo("ServerConfigUtil:queryGameLogin, 获得Web返回数据:", data)

        -- 成功获取数据, 处理登录状态
        self:parseLoginStatusAndParams(
            data,                   -- 原始数据
            forcedUpdateCallback,   -- 强更回调
            hotfixCallback,         -- 热更回调
            function(data)          -- 成功回调
                accountId = data.accountId
                if (successCallback) then successCallback(data) end
            end,
            unkownStatusCallback)   -- 未知状态码回调
    end, function(readyState,status)
        -- 失败重试
        failRetryCallback(
            self, 
            "========重试连接WEB登录验证服务器: " .. self:getLoginUrl(), -- 日志信息 
            function()                          -- 重试回调
                self:queryGameLogin(forcedUpdateCallback, hotfixCallback, successCallback, timeoutCallback)
            end, 
            timeoutCallback)                    -- 超过重试次数回调
    end, HTTP_RETRY_INTERVAL) -- 5秒超时
end

-- 处理不同的登录状态和参数
function ServerConfigUtil:parseLoginStatusAndParams(data, forcedUpdateCallback, hotfixCallback, successCallback, unkownCallback)
    -- 处理data为空的情况
    if (not data) then
        data = {loginStatus = 0}
        if (unkownCallback) then unkownCallback(data) end
    end

    -- 如果data不为空, loginStatus登录状态
    if (data.loginStatus == PublicDefine.LoginStatus.NeedForceUpdate) then
        -- 需要强更
        gotValidData = true
        
        webConfiguredBundleId = data.bundleId
        forceUpdateUrl = data.forceUpdateUrl
        forceUpdateBuild = data.forceUpdateBuild
        if (forcedUpdateCallback) then forcedUpdateCallback(data) end
    elseif (data.loginStatus == PublicDefine.LoginStatus.NeedHotFix) then
        -- 需要热更新
        gotValidData = true
        self:setWebManageUrl(data.webManageUrl)
        hotFixManifestUrl = data.hotFixManifestUrl
        hotFixPackageUrl = data.hotFixPackageUrl
        hotFixVersion = data.hotFixVersion
        if (hotfixCallback) then hotfixCallback(data) end
    elseif (data.loginStatus == PublicDefine.LoginStatus.Success) then
        -- 验证成功, 可以正常登录
        gotValidData = true
        if (successCallback) then successCallback(data) end
    else
        if (unkownCallback) then unkownCallback(data) end
    end
end

-- 向服务器请求防沉迷信息
function ServerConfigUtil:queryAntiAddiction(cb)
    local SdkBox = require("utils.sdkbox.SdkBox")
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    if (versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_CN or 
        versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE)
    then
        if (not playerID or not sdkToken) then
            if (cb) then cb(false, 3) end
            return
        end
        -- 获取防沉迷信息
        -- local params = {
        --     userId = playerID,
        --     game = "caveonline",
        --     channelNo = tostring(SdkBox:getInstance():getSubChannel()),
        --     token = sdkToken
        -- }
        local urlParams = "?userId="..playerID..
                          "&game=caveonline"..
                          "&channelNo="..tostring(SdkBox:getInstance():getSubChannel())..
                          "&token="..sdkToken
        printInfo("ServerConfigUtil:queryAntiAddiction, 请求第三方服务器:", urlParams)
        Net.Helper:sendHttpMessageByUrl("https://logincave.leiting.com/login/verify/verifyToken.do"..urlParams, {}, function(rawRes)
            -- 解开JSON并设置获取到的数据
            local response = json.decode(rawRes)
            printInfo("ServerConfigUtil:queryAntiAddiction, 获得Web返回数据:", rawRes)

            if (response and response.status == "success") then
                local rawData = response.data
                aaIsGuest = rawData.isGuest == 1
                aaIDCard = rawData.idCard
                aaAge = rawData.age
                aaAuth = rawData.auth
                if (cb) then cb(true, 0, response.msg) end
            else
                if (cb) then cb(false, 1, response.msg) end
            end
            queryAntiAddictionTryNum = 0
        end, function(readyState, status)
            queryAntiAddictionTryNum = queryAntiAddictionTryNum + 1
            if (queryAntiAddictionTryNum < HTTP_TIMEOUT_FAIL_NUM) then
                printWarn("========连接防沉迷服务器失败, 重试:", queryAntiAddictionTryNum, readyState, status)
                Avalon.Scheduler:scheduleUpdateOnce(self, function()
                    self:queryAntiAddiction(cb)
                end, 0.1)
            else
                queryAntiAddictionTryNum = 0
                if (cb) then cb(false, 2) end
            end
        end, HTTP_RETRY_INTERVAL) -- 5秒超时
    else
        cb(true, 0)
    end
end

-- 设置向WEB请求游戏登录验证使用的Token
function ServerConfigUtil:setAvalonLoginToken(token)
    avalonLoginToken = token
    if(avalonLoginToken) then
        if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
            local str = GameLoginManager:getInstance():getAccountId()
            if(str and string.sub(str,1,4) == "test") then 
                accountId = str
                return
            end
        end
        xpcall(function()
            local arrStr = string.split(avalonLoginToken, ".")
            if(arrStr and arrStr[2]) then
                -- print("ServerConfigUtil:getFullAccountID() 1", avalonLoginToken, arrStr[2],Base64Decode(arrStr[2].."=="))
                local jsonStr = Base64Decode(arrStr[2])
                if(not jsonStr) then 
                    jsonStr = Base64Decode(arrStr[2].."=")
                    if(not jsonStr) then 
                        jsonStr = Base64Decode(arrStr[2].."==")
                    end
                end
                if(jsonStr) then
                    local data = json.decode(jsonStr)
                    -- print("ServerConfigUtil:getFullAccountID() 2", Base64Decode(arrStr[2]), data)
                    if(data and data.account and data.thirdToken) then
                        accountId = data.account.."_"..data.thirdToken
                    end
                end
            end
        end, 
        function(e)
            printError("setAvalonLoginToken e=", e)
        end)
    end
end

-- 获取向WEB请求游戏登录验证使用的Token
function ServerConfigUtil:getAvalonLoginToken()
    return avalonLoginToken
end

-- 设置WEB第三方SDK登录验证后返回的昵称
function ServerConfigUtil:setNickName(nname)
    nickName = nname
end

-- 返回设置的昵称
function ServerConfigUtil:getNickName()
    return nickName
end

-- 设置WEB第三方SDK登录验证后返回的playerID
function ServerConfigUtil:setPlayerID(id)
    playerID = id
end

-- 返回设置的playerID
function ServerConfigUtil:getPlayerID()
    return playerID
end

-- 设置SDKToken
function ServerConfigUtil:setSDKToken(st)
    sdkToken = st
end

-- 获取SDKToken
function ServerConfigUtil:getSDKToken()
    return sdkToken
end

function ServerConfigUtil:clearServerListQueryData()
    serverList = nil
end

-- 设置服务器列表
function ServerConfigUtil:setServerList(serverList)
    assert(type(serverList) == "table", "服务器列表类型错误")
    serverList = serverList
end

-- 获取服务器列表
function ServerConfigUtil:getServerList()
    -- 根据渠道 来写死进那个服务器
    return serverList or {}
end

-- 用指针设置当前服务器配置
function ServerConfigUtil:setCurrentCfgByIdx(idx)
    assert(#serverList >= idx, "索引超出服务器列表大小")
    self:setCurrentCfg(serverList[idx])
end

-- 用服务器ID(zoneId)设置当前服务器
function ServerConfigUtil:setCurrentCfgById(id)
    local serverCfg = self:findCfgById(id)
    if (not serverCfg) then return end
    self:setCurrentCfg(serverCfg)
    printInfo("ServerConfigUtil:setCurrentCfgById, config: ", currentCfg)
end

-- 用配置设置当前服务器
function ServerConfigUtil:setCurrentCfg(cfg)
    currentCfg = cfg

    -- 存储选择的服务器ID
    local uuid = AvalonUtil.getIdentifier()
    local gameData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, uuid)
    if(gameData) then gameData:setServerId(cfg.id) end
    GameLoginManager:getInstance():setServerId(cfg.id)
    Avalon.UserDataManager:writeUserData(uuid, gameData);

    local isDeepLink, data = SdkBox:getInstance():getDeepLinkParams()
    if isDeepLink then
        Avalon.MessageCenter:notice(GameMessage.MC_LOGIN_AUTO_LOGIN)
    end

    -- add by zp 这里触发获取新的服务器的区服信息列表
    print("change server data.")
    if(GameManager:getIsOpenArea()) then
        if not (isFromChangeArea or isFromReconnect) then 
            GameLoginManager:getInstance():setAreaID(nil)
            if(gameData) then
                nowChoiceAreaServer = gameData:getAreaServerDataArr(ServerConfigUtil:getAccountId())
            end
            if(nowChoiceAreaServer == nil) then 
                nowChoiceAreaServer = {}
            end
            if(nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())] == nil) then
                ServerConfigUtil:queryAreaListConfig()
            else
                local saveData = nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())]
                GameLoginManager:getInstance():setAreaID(saveData.areaId) 
            end
            -- 这里都需要刷新服务器的显示信息
            Avalon.MessageCenter:notice(GameMessage.MC_LOGIN_REFRESH_AREAINFO)
        end
    end
end

-- 从本地存储读强制指定服务器IP
function ServerConfigUtil:getServerIPOverride()
    local savedIPStr = cc.UserDefault:getInstance():getStringForKey("DEV_HOST_IP_OVERRIDE", "")
    if (savedIPStr == "") then savedIPStr = nil end
    return savedIPStr
end

-- 从本地存储读强制指定服务器端口
function ServerConfigUtil:getServerPortOverride()
    local savedPortStr = cc.UserDefault:getInstance():getStringForKey("DEV_HOST_PORT_OVERRIDE", "")
    if (savedPortStr == "") then savedPortStr = nil end
    return tonumber(savedPortStr)
end

-- 配置强制指定服务器IP
function ServerConfigUtil:setServerIPOverride(ip)
    cc.UserDefault:getInstance():setStringForKey("DEV_HOST_IP_OVERRIDE", tostring(ip))
    cc.UserDefault:getInstance():flush()
    printInfo("======ServerConfigUtil:setServerIPOverride, 强制指定游戏服务器IP", ip)
end

-- 配置强制指定服务器端口
function ServerConfigUtil:setServerPortOverride(port)
    cc.UserDefault:getInstance():setStringForKey("DEV_HOST_PORT_OVERRIDE", tostring(port))
    cc.UserDefault:getInstance():flush()
    printInfo("======ServerConfigUtil:setServerPortOverride, 强制指定游戏服务器端口", port)
end

-- 获取当前配置
function ServerConfigUtil:getCurrentCfg()
    return currentCfg
end

-- 获取存储的当前配置ID, 默认为列表首位地址
function ServerConfigUtil:getSavedCurrentCfgId()
    local gameData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
    local curServerId = nil
    if(gameData) then
        curServerId = gameData:getServerId()
    end
    printInfo("======ServerConfigUtil:getSavedCurrentCfgId, 获取存储地址", curServerId)

    if (not curServerId or curServerId == -1 and not self:isServerListEmpty()) then 
        curServerId = self:getServerList()[1].id
        printWarn("======ServerConfigUtil:getSavedCurrentCfgId, 获取存储地址为空, 覆盖为列表首位ID", curServerId)
    end

    return curServerId
end

-- 获取当前配置中的登录URL
function ServerConfigUtil:getLoginUrl()
    if (self:isCurrentCfgEmpty()) then return nil end
    return currentCfg.loginUrl
end

-- 获取当前配置中的游戏服URL/IP
function ServerConfigUtil:getGateHost()
    if (self:isCurrentCfgEmpty()) then return nil end
    local gateIPOveride = self:getServerIPOverride()
    if (gateIPOveride and gateIPOveride ~= "") then 
        return gateIPOveride
    end
    return currentCfg.gateHost
end

-- 获取当前配置中的游戏服端口
function ServerConfigUtil:getGatePort()
    if (self:isCurrentCfgEmpty()) then return nil end
    local gatePortOverride = self:getServerPortOverride()
    if (gatePortOverride) then 
        return gatePortOverride
    end
    return currentCfg.gatePort
end

-- 获取当前配置中的ID(zoneId)
function ServerConfigUtil:getZoneId()
    if (self:isCurrentCfgEmpty()) then return nil end
    return currentCfg.id
end

-- 获取当前配置中的服务器维护状态
function ServerConfigUtil:getIsMaintenance()
    if (self:isCurrentCfgEmpty()) then return nil end
    return currentCfg.isMaintenance
end

-- 获取当前配置中的服务器多语言名字
function ServerConfigUtil:getName()
    if (self:isCurrentCfgEmpty()) then return nil end
    return tostring(currentCfg.name)
end

-- 获取当前配置中的服务器付费URL
function ServerConfigUtil:getPurchaseUrl()
    if (self:isCurrentCfgEmpty()) then return nil end
    return currentCfg.purchaseUrl
end

-- 获取当前配置中的WebUrl(游戏登录使用)
function ServerConfigUtil:getWebUrl()
    if ( not self:gotValidData() ) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 webUrl = ", webUrl)
    end
    return webUrl
end

-- 获取当前配置中的LoginVerifyUrl(登录第三方SDK使用)
function ServerConfigUtil:getLoginVerifyUrl()
    if ( not self:gotValidData() ) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 loginVerifyUrl = ", loginVerifyUrl)
    end
    return loginVerifyUrl
end

-- 获取当前配置中的delayCollectionUrl(延迟收集使用)
function ServerConfigUtil:getDelayCollectionUrl()
    if ( not self:gotValidData() ) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 delayCollectionUrl = ", delayCollectionUrl)
    end
    return delayCollectionUrl
end

function ServerConfigUtil:setWebManageUrl(url)
    if webManageUrl ~= url then
        webManageUrl = url
        require "app.utils.ImageDownLoadUtil"
        ImageDownLoadUtil:sendGetSplashImage()
    end
end


-- 获取当前配置中的WebManageUrl(所有功能性HTTP请求使用)
function ServerConfigUtil:getWebManageUrl()
    if ( not self:gotValidData() ) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 webManageUrl = ", webManageUrl)
    end
    return webManageUrl
end

-- 获取当前配置中的客户端BundleId
function ServerConfigUtil:getWebConfiguredBundleId()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 webConfiguredBundleId = ", webConfiguredBundleId)
    end
    return webConfiguredBundleId or ""
end

-- 获取当前配置中的引导评论URL
function ServerConfigUtil:getWebConfiguredCommentUrl()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 webConfiguredCommentUrl = ", webConfiguredCommentUrl)
    end
    return webConfiguredCommentUrl or ""
end

-- 获取当前配置中的热更新描述文件URL
function ServerConfigUtil:getHotFixManifestUrl()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 hotFixUrl = ", hotFixManifestUrl)
    end
    return hotFixManifestUrl
end

-- 获取当前配置中的热更新文件下载URL
function ServerConfigUtil:getHotFixPackageUrl()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 hotFixUrl = ", hotFixPackageUrl)
    end
    return hotFixPackageUrl
end

function ServerConfigUtil:getAssetsUrl()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 hotFixUrl = ", hotFixPackageUrl)
    end
    return assetsUrl
end

function ServerConfigUtil:getServerIsTest()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 hotFixUrl = ", hotFixPackageUrl)
    end
    return isTestEnv
end



-- 获取当前配置中的热更新需要更新到的版本
function ServerConfigUtil:getHotFixVersion()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 hotFixVersion = ", hotFixVersion)
    end
    return hotFixVersion
end

-- 获取当前配置中的强更版本URL
function ServerConfigUtil:getForceUpdateBuild()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 forceUpdateBuild = ", forceUpdateBuild)
    end
    return forceUpdateBuild
end
-- 获取当前配置中的强更版本
function ServerConfigUtil:getForceUpdateUrl()
    if ( not self:gotValidData()) then 
        printWarn("===============ServerConfigUtil, 未获得有效的服务器返回数据 forceUpdateUrl = ", forceUpdateUrl)
    end
    return forceUpdateUrl
end

-- 返回登录验证返回的账号Id
function ServerConfigUtil:getAccountId()
    -- if ( not self:gotGameLoginResponse()) then 
    --     printWarn("===============ServerConfigUtil, 未获得游戏登录验证回复 accountId = ", accountId)
    -- end
    return accountId
end


-- 检查服务器列表是否为空
function ServerConfigUtil:isServerListEmpty()
    if (type(serverList) ~= "table" or #serverList == 0) then return true end
    return false
end

-- 检查是否有足够的信息登录游戏
function ServerConfigUtil:isAbleToLoginGame()
    return not self:isServerListEmpty() and self:getAvalonLoginToken()
end

-- 检查是否获得*沈河*服务器回复
function ServerConfigUtil:gotReviewResponse()
    return gotReviewResponse
end

-- 检查是否获得服务器列表回复
function ServerConfigUtil:gotServerListResponse()
    return gotServerListResponse
end

-- 检查是否获得游戏登录验证回复
function ServerConfigUtil:gotGameLoginResponse()
    return gotGameLoginResponse
end

-- 检查是否获得有用信息
function ServerConfigUtil:gotValidData()
    return gotValidData
end

-- 检查是否在*沈河*中
function ServerConfigUtil:isInReview()
    return isReview
end

-- 检查是否屏蔽聊天
function ServerConfigUtil:isForbideChat()
    return false
end

-- 检查当前选择的服务器是否为空
function ServerConfigUtil:isCurrentCfgEmpty(breakOnError)
    if (not currentCfg) then 
        local msg = "ServerConfigUtil:isCurrentCfgEmpty, 当前服务器配置为空"
        if (breakOnError == true) then 
            assert(false, msg)
        else
            printInfo(msg)
        end
        return true 
    end
    return false
end

-- 用ID(zoneId)从服务器列表里面获取服务器配置
function ServerConfigUtil:findCfgById(id)
    if (self:isServerListEmpty()) then return nil end
    for i,v in ipairs(serverList) do
        if (v.id == id) then return v end
    end
    return nil
end

function ServerConfigUtil:getProjectId()
    if projectId ~= nil then
        return projectId
    end
    -- printError("============== projectId is nil so fix it", projectId)
    return 0
end

function ServerConfigUtil:getAdultType()
    return aaAuth
end

function ServerConfigUtil:getAge()
    return aaAge
end

function ServerConfigUtil:getIsGuest()
    return aaIsGuest
end

function ServerConfigUtil:getFbForumUrl()
    return "https://www.facebook.com/GreedyCave2"
end

function ServerConfigUtil:getSelfForumUrl()
    return "http://forum.avalongames.com/forum.php?gid=40"
end

------------------------ 以下为选区相关的数据区 --------------------

function ServerConfigUtil:saveAreaData()
    if(not GameManager:getIsOpenArea()) then return end

    if(nowChoiceAreaServer) then 
        local gameData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
        if(gameData) then 
            gameData:setAreaServerDataArr(nowChoiceAreaServer, ServerConfigUtil:getAccountId())
            Avalon.UserDataManager:writeUserData(AvalonUtil.getIdentifier(), gameData);
        end
        
    end
end

function ServerConfigUtil:clearCacheSaveAreaServer()
    if not (isFromChangeArea or isFromReconnect) then 
        nowChoiceAreaServer = nil
    end
end

function ServerConfigUtil:handleAreaData(data)
    if(not GameManager:getIsOpenArea()) then return end
    -- if(nowChoiceAreaServer) then
    --     nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())] = nil
    -- end
    if(data == nil) then 
        return
    end

    local oneData = {}
    oneData._areaServerList = {}
    oneData._preferAreaId = data.preferAreaId
    oneData._lastAreaId = data.lastAreaId

    -- 这里以客户端的记录为优先级
    if(nowChoiceAreaServer and nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())]) then
        oneData._lastAreaId = nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())].areaId
    end

    local currentCfg = ServerConfigUtil:getCurrentCfg()
    if(currentCfg == nil) then 
        return
    end
    -- print("ServerConfigUtil:handleAreaData", currentCfg.id)
    if(areaServerArr[ServerConfigUtil:getAccountId()] == nil ) then 
        areaServerArr[ServerConfigUtil:getAccountId()] = {}
    end

    local defaultChoidId = data.preferAreaId
    if(data.lastAreaId) then 
        defaultChoidId = data.lastAreaId
    end

    areaServerArr[ServerConfigUtil:getAccountId()][currentCfg.id] = oneData
    require "app.datas.common.AreaServerData"
    for k,v in ipairs(data.areas) do 
        local areaServerData = Data.AreaServerData:create(v)
        table.insert(oneData._areaServerList, areaServerData)

        if(areaServerData and areaServerData:getAreaID() == defaultChoidId) then 
            if(nowChoiceAreaServer and nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())] == nil) then
                nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())] = areaServerData:getSaveData()
                ServerConfigUtil:saveAreaData()
            end
        end
    end

    if(data.heroes) then
        for k,v in ipairs(data.heroes) do 
            for _,areaServerData in ipairs(oneData._areaServerList) do 
                if(areaServerData:getAreaID() == v.areaId) then 
                    areaServerData:setHeroInfo(v.pk, v.nickname, v.level)
                    break
                end
            end
        end
    end

    -- 触发获取多语言
    local keyList = {}
    for k,v in ipairs(oneData._areaServerList) do 
        if(v:getLangId()) then
            table.insert(keyList, v:getLangId())
        end
    end

    local LanguageManager = require("app.game.LanguageManager")
    LanguageManager:getInstance():getLanguageFromWebServer(keyList, handler(self, function()
        for k,v in ipairs(oneData._areaServerList) do 
            if(v:getLangId()) then 
                local areaNameJson = LanguageManager:getInstance():getLanguageWebStrForKey(v:getLangId())
                if(areaNameJson) then 
                    xpcall(function()
                        local jsonArr = json.decode(areaNameJson)
                        if(#jsonArr>=1) then 
                            v:setAreaName(json.decode(areaNameJson)[1].text or "")
                        end
                    end, 
                    function(e) 

                    end, 1)
                end
            end

            if(v and v:getAreaID() == defaultChoidId) then 
                if(nowChoiceAreaServer) then
                    nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())] = v:getSaveData()
                    ServerConfigUtil:saveAreaData()
                end
            end
        end
        -- print("LanguageManager:getInstance():getLanguageFromWebServer")
        Avalon.MessageCenter:notice(GameMessage.MC_LOGIN_REFRESH_AREAINFO)
    end))
end

function ServerConfigUtil:getNowAreaServerData()
    if(not GameManager:getIsOpenArea()) then return end

    local currentCfg = ServerConfigUtil:getCurrentCfg()
    if(currentCfg == nil) then 
        return nil
    end
    -- print("ServerConfigUtil:getNowAreaServerData()", currentCfg.id)
    if(areaServerArr[ServerConfigUtil:getAccountId()]) then 
        return areaServerArr[ServerConfigUtil:getAccountId()][currentCfg.id]
    end
    return nil
end

function ServerConfigUtil:changeNowChoiceAreaID(areaData)
    if(nowChoiceAreaServer and areaData) then
        nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())] = areaData:getSaveData()
    end
end

function ServerConfigUtil:setNowChoiceAreaID(areaID)
    if(not GameManager:getIsOpenArea()) then return end
    local data = ServerConfigUtil:getNowAreaServerData()
    if(data == nil) then 
        return
    end

    data._nowChoiceAreaID = areaID
    local areaServerList = data._areaServerList
    if(areaServerList) then 
        for k, areaData in pairs(areaServerList) do 
            if(areaData:getAreaID() == areaID) then 
                if(nowChoiceAreaServer) then
                    nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())] = areaData:getSaveData()
                end
                break
            end
        end
    end

    GameLoginManager:getInstance():setAreaID(areaID)
    Avalon.MessageCenter:notice(GameMessage.MC_LOGIN_REFRESH_AREAINFO)
end

function ServerConfigUtil:getNowChoiceAreaID()
    local data = ServerConfigUtil:getNowAreaServerData()
    if(data == nil) then 
        return nil
    end
    -- print("ServerConfigUtil:getNowChoiceAreaID() 1")
    if(data._nowChoiceAreaID) then 
        return data._nowChoiceAreaID
    end
    -- print("ServerConfigUtil:getNowChoiceAreaID() 2")
    if data._lastAreaId ~= nil then 
        return data._lastAreaId
    end

    return data._preferAreaId
end

function ServerConfigUtil:checkIsNowChoiceForAreaID(areaID)
    if(areaID == ServerConfigUtil:getNowChoiceAreaID()) then 
        return true
    end

    return false
end

function ServerConfigUtil:getPreferAreaID()
    local data = ServerConfigUtil:getNowAreaServerData()
    if(data == nil) then 
        return {}
    end

    return data._preferAreaId
end

function ServerConfigUtil:getNowChoiceAreaName()
    local data = ServerConfigUtil:getNowChoiceAreaServerData()
    if(data) then 
        return data:getAreaName()
    end

    -- 读取本地缓存
    local data = nowChoiceAreaServer[tostring(ServerConfigUtil:getZoneId())]
    if(data) then 
        return data.areaName
    end

    return nil
end

function ServerConfigUtil:getNowChoiceAreaServerData()
    local data = ServerConfigUtil:getNowAreaServerData()
    if(data == nil) then 
        return nil
    end
    local nowAreaID = ServerConfigUtil:getNowChoiceAreaID()
    local areaServerList = data._areaServerList
    -- print("ServerConfigUtil:getNowChoiceAreaServerData() 1", nowAreaID, areaServerList)
    if(areaServerList) then 
        for k, areaData in pairs(areaServerList) do 
            -- print("ServerConfigUtil:getNowChoiceAreaServerData() 2", nowAreaID, areaData:getAreaID())
            if(areaData:getAreaID() == nowAreaID) then 
                return areaData
            end
        end
    end

    return nil
end

function ServerConfigUtil:getAreaListData()
    local data = ServerConfigUtil:getNowAreaServerData()
    if(data == nil) then 
        return {}
    end

    return data._areaServerList
end

function ServerConfigUtil:getAreaListDataForHaveRole()
    local data = ServerConfigUtil:getNowAreaServerData()
    if(data == nil) then 
        return {}
    end
    local _areaServerList = data._areaServerList

    local serverList = {}
    if(_areaServerList) then 
        for k, v in pairs(_areaServerList) do 
            if(v:getIsRole()) then 
                table.insert(serverList, v)
            end
        end
    end
    -- 把有等级高的放到前面
    table.sort(serverList, function(a, b)
        if(a:getLv() == b:getLv()) then 
            if(a:getAreaID() > b:getAreaID()) then 
                return true
            else
                return false 
            end
        elseif(a:getLv() > b:getLv()) then 
            return true
        else
            return false
        end
    end)

    print("serverList ====== ")
    dump(serverList)
    
    return serverList
end


------------------------ 以上为选区相关的数据区 --------------------


return ServerConfigUtil

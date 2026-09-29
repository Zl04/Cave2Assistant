--[[
    网络助手类
    - 代理网络数据发送和接受
    - 代理数据解析，分发数据到相应模块
    - 网络相关的宏定义
]] --

require "utils.net.NetMacro"
require "utils.Queue"
require "utils.AvalonUtil"
require "app.utils.ServerConfigUtil"
require "utils.net.NetPetPVPProxy"

local GameDataManager = require("app.game.GameDataManager")
local proto = require "utils.ProtobufUtil"

-- by CMonk, LatSim 加入延迟模拟器, 不存在也不会报错, 如需清理请搜索删除 LatSim 并删除所有段
-- 目的是不大范围修改NetHelper
local gmlStatus, err = pcall(require, "app.ui.gmUtil.GMUtilLatencySimulator")
local latSim = gmlStatus and UI.GMUtilLatencySimulator or nil -- latency simulator
-- eo CMonk

-- 网络助手单例
local Helper = {}

local msgAnalysis = {}
local msgAnalysisEnable = false
-- private:
-- 更新函数句柄
local updateHandler = nil
-- 所有网络链接id
local connids = {}
-- 网络消息处理器
local handlers = {}
-- 未处理的网络包
local unhandlePackMap = {}
-- 未处理的系统包
local unhandleSystemPackMap = {}

local parallel = false

local function handleOnePack(packQueue, connid)
    if (packQueue == nil) then
        return
    end
    local pack = packQueue:front()
    if (not pack) then
        -- print("[ERROR] NetHelper update: pack from queue is nil.")
        return
    end

    local section, no, data = Helper:parseMessage(pack)
    -- print(string.format("NetHelper update: parse one pack, [section:%d no:%d].", section, no))

    if (section > NetSection.MIN and section < NetSection.MAX) then
        local newid = section * 10000 + connid
        local handler = handlers[newid]
        if (handler) then
            if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
                if NetPackMap and NetPackMap[section] and NetPackMap[section][no] ~= "" 
                    and "GoodsSystem.PacketArchiveMessage" ~= NetPackMap[section][no]
                    and "PurchaseSystem.ResProductListMessage" ~= NetPackMap[section][no]
                then
                    local str = ""
                    local depth = 1
                    -- for key, v in pairs(data) do

                    -- end
                    -- print("[Receive Proto] "..tostring(NetPackMap[section][no]) .. " data = ", data)
                end
            end

            -- target:func(no, data)
            local target = handler.target
            local func = handler.func
            if (section == NetMessageCategory.PET.SECTION and no == NetMessageType.PET_PVP_FIGHT_RECORD_MESSAGE.NO) then
                -- print("--data----", data)
                Net.PetPVPProxy:init()
                Net.PetPVPProxy:addFightRecord(data)
            else
                if Net.showLog and section ~= NetMessageCategory.INNER.SECTION and section ~= NetMessageCategory.LOGIN.SECTION then
                    local noNickName = ""
                    for _, v in pairs(NetMessageType) do
                        if v.NO == no and section == v.CATEGORY.SECTION then
                            noNickName = v.HEAD
                        end
                    end
                    -- print("++[recive data]: ", data)
                    printWarn("++[recive data] " .. noNickName .. " : " .. tostring(data))
                end
                func(target, no, data, connid)
            end
        else
            packQueue:push(pack)

            printWarn("NetHelper:update no handler found for section, on=", section, no, connid,newid)
        end
    elseif (section == NetSection.MIN) then
        printWarn("NetHelper:update on seciton, on=", seciton, no)
    else
        printError("NetHelper:update on seciton, on=", seciton, no)
    end
end

-- 更新函数
local function update(dt)
    for i = 1, #connids do
        require "app.ui.gmUtil.GMUtilExecutor"
        if (CONFIG_SHOW_DEBUG_PANEL and not UI.GMUtilExecutor:isNetAllow()) then
            return
        end

        local connid = connids[i]
        local packQueue = unhandlePackMap[connid]
        local systemPackQueue = unhandleSystemPackMap[connid]

        -- 获取网络消息
        local systemPacks = avalon.NetManager:getInstance():getSystemPacks(connid)
        local packs = avalon.NetManager:getInstance():getPacks(connid)

        -- by CMonk, LatSim 添加可选延迟模拟器, 绕个路目的是不修改原代码, 可随时删除此区域
        -- 接收包移花接木, 把新接收到的包推进列队, 取出已经到延迟时间的包 (注意开启拦截后系统包也会被作为普通包处理, 关闭时不影响)
        if (latSim) then
            packs, systemPacks = latSim:recvInterceptAndReturnDue(connid, packs, systemPacks)
        end
        -- eo CMonk

        -- 附加未处理的消息
        local count = #packs
        if (count > 0) then
            for j = 1, count do
                packQueue:push(packs[j])
            end
        end
        local sysPackCount = #systemPacks
        if (sysPackCount > 0) then
            for j = 1, sysPackCount do
                systemPackQueue:push(systemPacks[j])
            end
        end

        -- 处理消息 (优先处理系统消息, 一帧内处理所有系统消息, 一帧内批量处理普通消息)
        while (not systemPackQueue:empty()) do
            handleOnePack(systemPackQueue, connid)
        end

        if (not packQueue:empty()) then
            if (parallel) then
                local size = packQueue:size()
                for m = 1, size do
                    handleOnePack(packQueue,connid)
                end
            else
                for m = 1, 10 do
                    handleOnePack(packQueue,connid)
                end
            end
        end
    end
end

-- 发送数据
-- connid：网络连接id
-- dir：消息定向
-- sect：消息分段
-- no：消息编号
-- body：消息体
local function send(connid, dir, sect, no, body)
    if (#connids > 0) then
        avalon.NetManager:getInstance():send(connid, dir, sect, no, body)
    end
end

-- public:
-- 初始化
function Helper:init()
    connids = {}
    -- 网络消息处理器
    handlers = {}
    -- 未处理的网络包
    unhandlePackMap = {}
    unhandleSystemPackMap = {}

    local scheduler = cc.Director:getInstance():getScheduler()
    updateHandler = scheduler:scheduleScriptFunc(update, 0.0, false)

    Net.initMessageNo()

    parallel = false

    -- self:register(NetMessageCategory.INNER, self, Helper.onInnerSystemMessageHandler)

    print("NetHelper: init net helper.")
end

-- 清除消息
function Helper:clearQueue()
    for i = 1, #connids do
        local connid = connids[i]
        local packQueue = unhandlePackMap[connid]
        local systemPackQueue = unhandleSystemPackMap[connid]

        -- 获取网络消息
        local systemPacks = avalon.NetManager:getInstance():getSystemPacks(connid)
        local packs = avalon.NetManager:getInstance():getPacks(connid)

        -- by CMonk, LatSim 添加可选延迟模拟器, 绕个路目的是不修改原代码, 可随时删除此区域
        -- 接收包移花接木, 把新接收到的包推进列队, 取出已经到延迟时间的包 (注意开启拦截后系统包也会被作为普通包处理, 关闭时不影响)
        if (latSim) then
            packs, systemPacks = latSim:recvInterceptAndReturnDue(connid, packs, systemPacks)
        end
        -- eo CMonk

        -- 附加未处理的消息
        local count = #packs
        if (count > 0) then
            for j = 1, count do
                packQueue:push(packs[j])
            end
        end
        local sysPackCount = #systemPacks
        if (sysPackCount > 0) then
            for j = 1, sysPackCount do
                systemPackQueue:push(systemPacks[j])
            end
        end
        packQueue:reset()
        systemPackQueue:reset()
    end
end

-- 销毁
function Helper:destroy()
    if (updateHandler) then
        local scheduler = cc.Director:getInstance():getScheduler()
        scheduler:unscheduleScriptEntry(updateHandler)
    end

    for i = 1, #connids do
        local connid = connids[i]
        self:disconnect(connid)
        connids[i] = nil
    end
    connids = nil

    for i = 1, #handlers do
        handlers[i].target = nil
        handlers[i].func = nil
        handlers[i] = nil
    end
    handlers = nil

    for connid, packQueue in pairs(unhandlePackMap) do
        packQueue:destroy()
        unhandlePackMap[connid] = nil
    end
    unhandlePackMap = nil

    for connid, systemPackQueue in pairs(unhandleSystemPackMap) do
        systemPackQueue:destroy()
        unhandleSystemPackMap[connid] = nil
    end
    unhandleSystemPackMap = nil

    parallel = false

    print("NetHelper: destroy net helper.")
end

function Helper:handleAllPack()
    self:enableParallel()
    update(0)
    self:disableParallel()
end

-- 连接网络
function Helper:connect(connid, host, port, onComplete, onFail)
    assert(type(host) == "string" and type(port) == "number", "[ERROR] NetHelper:connect host and port is invalid.")

    print(string.format("NetHelper:connect connid:%d host:%s port:%d", connid, host, port))

    avalon.NetManager:getInstance():connect(connid, host, port, onComplete, onFail)

    table.insert(connids, connid)
    unhandlePackMap[connid] = Avalon.Queue:create()
    unhandleSystemPackMap[connid] = Avalon.Queue:create()
end

-- 重连网络
function Helper:reconnect(connid, host, port)
    self:resetPackQueueForConn(connid)
    if (host) then
        assert(type(host) == "string" and type(port) == "number", "[ERROR] NetHelper:connect host and port is invalid.")

        avalon.NetManager:getInstance():reconnect(connid, host, port)
    else
        avalon.NetManager:getInstance():reconnect(connid)
    end
end

-- 断开网络
function Helper:disconnect(connid)
    self:resetPackQueueForConn(connid)
    if (#connids > 0) then
        avalon.NetManager:getInstance():disconnect(connid)
    end
end

-- 注册网络消息回调函数
-- target：回到函数目标对象
-- func：回调函数
function Helper:register(MessageCategory, target, func)
    assert(MessageCategory and MessageCategory.SECTION, "[ERROR] NetHelper:register MessageCategory is invalid.")

    local found = false
    local section = MessageCategory.SECTION
    local connid = MessageCategory.CONNID
    local newid = section * 10000 + connid

    print("   register =======  ",connid,newid)

    local handler = handlers[newid]
    if (handler and handler.target == target and handler.func == func) then
        print("[WARNING] NetHelper:register the same handler found.")
        found = true
    end

    if (not found) then
        handlers[newid] = {
            target = target,
            func = func,
            connectid = MessageCategory.CONNID
        }
    end
end

-- 清空一个连接的接收列队
function Helper:resetPackQueueForConn(connid)
    local packQueue = unhandlePackMap[connid]
    if (packQueue) then
        packQueue:reset()
    end
    local systemPackQueue = unhandleSystemPackMap[connid]
    if (systemPackQueue) then
        systemPackQueue:reset()
    end
end

-- 取消注册网络消息回调函数
function Helper:unregister(MessageCategory, target, func)
    assert(MessageCategory and MessageCategory.SECTION, "[ERROR] NetHelper:register MessageCategory is invalid.")

    local section = MessageCategory.SECTION
    local newid = section * 10000 + MessageCategory.CONNID
    local handler = handlers[newid]
    if (handler and handler.target == target and handler.func == func) then
        handlers[newid] = nil
    else
        print("[WARNING] NetHelper:register no handler found.")
    end
end

function Helper:disableParallel()
    parallel = false
end

function Helper:enableParallel()
    parallel = true
end

-- 发送消息
-- MessageType：消息类型，在NetMessage.lua中定义
-- data：消息数据
function Helper:sendMessage(MessageType, data)
    assert(MessageType and MessageType.NO, "[ERROR] NetHelper:sendMessage MessageType is invalid.")

    -- by CMonk, LatSim 添加可选延迟模拟器, 绕个路目的是不修改原代码, 可随时删除此区域
    -- 拦截会返回true, 拦截关闭或者模拟器自己发送延迟到达的包时会返回false 让消息通过
    -- 延迟模拟器会在自己的update循环中调用这里指定的方法和参数来代理发送到时间的包
    if (latSim and latSim:sendIntercept(self, self.sendMessage, MessageType, data)) then
        return
    end
    -- eo CMonk

    local category = MessageType.CATEGORY
    local headName = MessageType.HEAD
    local bodyName = MessageType.BODY
    local no = MessageType.NO
    local dir = MessageType.DIRECTION

    -- local body = proto:encode(bodyName, data)

    -- add by zp
    local body = nil
    if (bodyName and bodyName ~= "" and data and data ~= "") then
        body = proto:encode(bodyName, data)
    else
        body = data
    end
    if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
        if not bodyName then
            print("[Send Proto] "..tostring(bodyName).." data = ", data)
        else
            print("[Send Proto] "..tostring(headName).." data = ", data)
        end
    end
    -- print(string.format("NetHelper:sendMessage 消息定向:%d 消息分段:%d 消息编号:%d 消息内容:[%s].", dir, category.SECTION, no, body));

    send(category.CONNID, dir, category.SECTION, no, body)
end

-- 解析消息
-- pack：网络数据包
function Helper:parseMessage(pack)
    assert(pack, "[ERROR] NetHelper:parseMessage pack is nil.")
    --print("Helper:parseMessage",pack)
    local section = pack[NetPackField.SECTION]
    local no = pack[NetPackField.NO]
    local body = pack[NetPackField.BODY]

    Helper.analysisMsg(no, section, body)
    local data = nil
    local bodyName = nil
    -- print("Helper:parseMessage  1",seciton,no,body)
    if (section == NetSection.MIN) then
        -- 暂时不处理section为0的消息
        printInfo("min section, no=", section, no)
        no = 0
    elseif (section == NetSection.INNER_SYSTEM) then
        -- print("Helper:parseMessage  5",body)
        data = body
    else
        -- print("Helper:parseMessage@@@",section,no,body)
        if (NetPackMap and NetPackMap[section]) then
            bodyName = NetPackMap[section][no]
            -- print("Helper:parseMessage  2",bodyName)
            if (bodyName and bodyName ~= "" and body and body ~= "") then
                -- print("Helper:parseMessage  3",bodyName,body)
                -- print(string.format("NetHelper:parseMessage bodyName:%s  body:%s ",bodyName,body))
                data = proto:decode(bodyName, body)
            else
                -- print("Helper:parseMessage  4",body)
                data = body
            end
        else
            printError("no register section, no=", section, no)
            section = NetSection.MIN
            no = 0
        end
    end
    -- print(string.format("NetHelper:parseMessage 消息分段:%d 消息编号:%d 消息体名字:%s.", section, no, bodyName));

    -- print("Helper:parseMessage  6",data)

    return section, no, data
end

-- 内部系统数据处理器
function Helper:onInnerSystemMessageHandler(no, data)
    if (no == NetMessageType.CONNECT_COMPLETE.NO) then
        print(string.format("NetHelper:onInnerSystemMessageHandler connection complete. [no:%d data:%s]", no, data))

        local connid = AvalonUtil.strToNumber(data)
    elseif (no == NetMessageType.CONNECT_FAIL.NO) then
        print(string.format("NetHelper:onInnerSystemMessageHandler connection fail. [no:%d data:%s]", no, data))

        local connid = AvalonUtil.strToNumber(data)
    elseif (no == NetMessageType.CONNECT_DISCONNECTED.NO) then
        print(string.format("NetHelper:onInnerSystemMessageHandler connection disconnected. [no:%d data:%s]", no, data))

        local connid = AvalonUtil.strToNumber(data)
    elseif (no == NetMessageType.CONNECT_HEART_BEAT.NO) then
        -- local ping = data;
        print(string.format("NetHelper:onInnerSystemMessageHandler heart beat. [no:%d data:%s]", no, data))
    else
        print(
            string.format(
                "[WARNING] NetHelper:onInnerSystemMessageHandler no handler for this message. [no:%d data:%s]",
                no,
                data
            )
        )
    end
end
function Helper:sendHttpMessageByUrl(httpurl, data, callfuncSuccess, callfuncFail, timeout, repeatCount)
    --数据封装
    if repeatCount ~= nil and repeatCount > ADS_HTTP_REPEAT_COUNT then
        repeatCount = ADS_HTTP_REPEAT_COUNT
    end
    local sortTable = AvalonUtil:sortParamByFirstChar(data)
    -- dump(sortTable, "sortTable")
    local md5ParamStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        md5ParamStr = md5ParamStr .. v.value
        paramTable[v.key] = v.value
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr .. WEB_MD5_KEY)

    local xhr = cc.XMLHttpRequest:new()
    if (timeout) then
        xhr.timeout = timeout
    end
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    xhr:setRequestHeader("Authorization", "Bearer " .. md5Str)

    local function onReadyStateChanged()
        -- print("xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status, "xhr.status", xhr.status)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            if callfuncSuccess then
                callfuncSuccess(xhr.response)
            end
        else
            if callfuncFail then
                callfuncFail(xhr.readyState, xhr.status)
            elseif callfuncFail == nil and callfuncSuccess == nil and repeatCount ~= nil then
                repeatCount = repeatCount - 1
                if repeatCount > 0 then
                    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function () 
                        self:sendHttpMessageByUrl(httpurl, data, callfuncSuccess, callfuncFail, timeout, repeatCount)
                    end, 60 * (ADS_HTTP_REPEAT_COUNT - repeatCount))
                else
                    printError("--------http fail----", data)
                end
            end
        end
    end

    xhr:registerScriptHandler(onReadyStateChanged)
    local sendParam = json.encode(paramTable)
    -- print("  =----- sendParam "..sendParam)
    xhr:send(sendParam)
end
local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local SceneManager = require("app.game.SceneManager")

function Helper:getCommonSharedData()
    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    local gameLoginManager = require("app.game.GameLoginManager")
    local checkpointTb =
        RoleDataManager:getCheckpointData(
        LevelSelectUtil:getInstance().mCaveMode,
        LevelSelectUtil:getInstance().mOpenDifficulty
    ) or nil
    local guildData = MasterDataManager:getGuildData() or {}
    local masterData = RoleDataManager:getMaster()

    local GobalCommonData = {
        game_name = "caveonline",
        is_encrypted = AvalonUtil:checkSupportAES(),
        -- package_name = --暂时没有接口，如果需要后期再加入
        netmode = AvalonUtil.getNetworkMode(), --PublicDefine.NetworkMode.WIFI
        idfv = AvalonUtil:encryptAES(AvalonUtil.getIDFV(),AvalonUtil:getPublicAesKey()),
        idfa = AvalonUtil:encryptAES(AvalonUtil.getIDFA(),AvalonUtil:getPublicAesKey()),
        adid = AvalonUtil:encryptAES(AvalonUtil.getADID(),AvalonUtil:getPublicAesKey()),
        imei = AvalonUtil:encryptAES(AvalonUtil.getIMEI(),AvalonUtil:getPublicAesKey()),
        mac = AvalonUtil:encryptAES(AvalonUtil.getMAC(),AvalonUtil:getPublicAesKey()),
        uuid = AvalonUtil:encryptAES(AvalonUtil.getOpenUUID(),AvalonUtil:getPublicAesKey()),
        timestamp = os.time(),
        package_version = AvalonUtil.getPackageVersion(),
        hotfix_version = Avalon.HotfixManager:getLocalVersion(),
        phoneInfo = AvalonUtil:encryptAES(AvalonUtil.getDeviceName(),AvalonUtil:getPublicAesKey()),
        phone_version = AvalonUtil.getSystemVersion(),
        phone_location = AvalonUtil.getLocation(),
        languageType = LanguageManager:getInstance():getLanguage(),
        -- }

        project_id = ServerConfigUtil:getProjectId(),

        -- local projectCommonData =
        -- {
        account = SdkBox:getInstance():getVersionAccount(),
        account_str = gameLoginManager:getInstance():getAccountId(),
         --"1_2_3_4_5_9999",
        platform = SdkBox:getInstance():getVersionPlatform(),
        channel = SdkBox:getInstance():getVersionChannel(),
        zone = gameLoginManager:getInstance():getServerId(),
        pk = masterData and masterData:getPK() or -1,
        lv = masterData and masterData:getLevel() or 0,
        nickname = masterData and masterData:getNickName() or "",
        checkpoint = checkpointTb and checkpointTb:getCheckpoint() or 0,
        mode = LevelSelectUtil:getInstance().mCaveMode,
        diff = LevelSelectUtil:getInstance().mOpenDifficulty,
        scLv = guildData.techTotalLv,
        scene = SceneManager:getInstance()._state
    }

    return GobalCommonData, projectCommonData
end

local AWS_BRANCH = {
    TRUNK_INTRANET = "intranet_trunk",
    RELEASE_GLOBAL = "global",
    RELEASE_CN = "cn_lt_public",
    RELEASE_CHANNEL = "cn_lt_channel",
    BETA_CN = "cn_lt_pre",
}

local AWS_FUNCTION_TYPE = {
    DELAY = "client_delay_collection",
    CLICK = "client_ui_currency",
    AD = "client_ad",
    LOGIN = "client_login_process"
}

local AWS_URL = {
    DEBUG = "https://cave2-all-all-cs-bilog-0000.avalongames.com",
    RELEASE = "https://cave2-all-all-zs-bilog-0000.avalongames.com",   -- global 版本
    RELEASE_CN = "https://cave2-all-all-zs-bilog-0001.avalongames.com" -- 解析到国内
}

local AWS_VERSION = "v1"


function Helper:getAWSUrl()
    if ServerConfigUtil:getServerIsTest() then
    -- if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
        return AWS_URL.DEBUG .. "/" .. AWS_VERSION .. "/" .. AWS_BRANCH.TRUNK_INTRANET
    end

    if CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
        return AWS_URL.RELEASE_CN .. "/" .. AWS_VERSION .. "/" .. AWS_BRANCH.BETA_CN
    elseif CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        return AWS_URL.RELEASE .. "/" .. AWS_VERSION .. "/" .. AWS_BRANCH.RELEASE_GLOBAL
    elseif CAVEOL_TARGET == CAVEOL_TARGET_CN then
        local channel = SdkBox:getInstance():getVersionChannel()
        channel = checkint(channel)
        if channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING 
            and channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_APPSTORE 
            and channel ~= PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_QUICK 
        then
            return AWS_URL.RELEASE_CN .. "/" .. AWS_VERSION .. "/" .. AWS_BRANCH.RELEASE_CHANNEL
        else
            return AWS_URL.RELEASE_CN .. "/" .. AWS_VERSION .. "/" .. AWS_BRANCH.RELEASE_CN
        end
    end

    return
end


function Helper:sendAWSDelayInfo(data)
    self:sendHttpAWS(
        AWS_FUNCTION_TYPE.DELAY,
        data
    )
end

function Helper:sendAWSClickInfo(data)
    self:sendHttpAWS(
        AWS_FUNCTION_TYPE.CLICK,
        data
    )
end

function Helper:sendAWSAdInfo(data)
    self:sendHttpAWS(
        AWS_FUNCTION_TYPE.AD,
        data
    )
end
function Helper:sendAWSLOGINInfo(data)
    self:sendHttpAWS(
        AWS_FUNCTION_TYPE.LOGIN,
        data
    )
end


function Helper:sendNormalHttpGet(httpurl, data, callfuncSuccess, callfuncFail, repeatSend)
    if repeatSend and repeatSend > 3 then --连续发送失败5次则不再发送
        return
    end
    if not httpurl then
        print("httpurl not exist……")
        return
    end
    local xhr = cc.XMLHttpRequest:new()
    xhr.timeout = 8
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json")

    local function onReadyStateChanged()
        -- print("onReadyStateChanged", xhr.readyState, xhr.status)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            if callfuncSuccess then
                callfuncSuccess(xhr.response)
            end
        else
            if callfuncFail then
                callfuncFail(xhr.readyState, xhr.status)
            elseif callfuncFail == nil and callfuncSuccess == nil and repeatCount ~= nil then
                repeatCount = repeatCount - 1
                if repeatCount > 0 then
                    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function () 
                        self:sendNormalHttp(httpurl, data, callfuncSuccess, callfuncFail, timeout, repeatCount)
                    end, 60 * (ADS_HTTP_REPEAT_COUNT - repeatCount))
                else
                    printError("--------http fail----", data)
                end
            end
        end
    end

    xhr:registerScriptHandler(onReadyStateChanged)
    xhr:send()
end

function Helper:sendHttpAWS(functionType, data, repeatSend)
    
    if repeatSend and repeatSend > 3 then --连续发送失败5次则不再发送
        return
    end

    local url = self:getAWSUrl()
    if not url then
        print("url not exist……")
        return
    end

    local gobalCommonData = self:getCommonSharedData()
    table.merge(gobalCommonData,data)

    --数据封装
    local sortTable = AvalonUtil:sortParamByFirstChar(gobalCommonData)
    -- dump(sortTable, "sortTable")
    -- local md5ParamStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        -- md5ParamStr = md5ParamStr .. v.value
        paramTable[v.key] = v.value
    end

    local functionTypeStr = functionType or AWS_FUNCTION_TYPE.DELAY

    local sendContent = {
        event = functionTypeStr,
        context = paramTable
    }

    -- local md5Str = AvalonUtil:MD5(md5ParamStr..WEB_MD5_KEY)

    local xhr = cc.XMLHttpRequest:new()
    xhr.timeout = 8
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

    xhr:open("POST", url)
    xhr:setRequestHeader("Content-Type", "application/json")
    -- xhr:setRequestHeader("Authorization", "Bearer "..md5Str)
    xhr:setRequestHeader("x-api-key", "YghX2AfsNnICEYgZ79837zkDwfKIwBg5yaJ2V3J4")

    local function onReadyStateChanged()
        print("xhr.readyState is:", xhr.readyState, "xhr.status is: ", xhr.status, "xhr.status", xhr.status)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- if callfuncSuccess then
            --     callfuncSuccess(xhr.response)
            -- end
        else
            repeatSend = (repeatSend or 0) + 1
            Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function () 
                self:sendHttpAWS(functionType, data, repeatSend)
            end, (repeatSend +30) * repeatSend * 2)
        end
    end

    xhr:registerScriptHandler(onReadyStateChanged)
    local sendParam = json.encode(sendContent)
    xhr:send(sendParam)
end

-- 封装http消息
function Helper:sendHttpMessage(functionURL, data, callfuncSuccess, callfuncFail, repeatCount)
    local webManageUrl = ServerConfigUtil:getWebManageUrl()
    if (not webManageUrl) then
        return
    end

    --URL拼接
    local httpurl = webManageUrl .. functionURL
    self:sendHttpMessageByUrl(httpurl, data, callfuncSuccess, callfuncFail, nil, repeatCount)
end
-- start --

--------------------------------
-- 检查地 WIFI 网络是否可用
-- @function [parent=#network] isLocalWiFiAvailable
-- @return boolean#boolean ret (return value: bool)  网络是否可用

--[[--

检查地 WIFI 网络是否可用

提示： WIFI 网络可用不代表可以访问互联网。

]]
-- end --

function Helper:isLocalWiFiAvailable()
    return avalon.NetManager:isLocalWiFiAvailable()
end

-- start --

--------------------------------
-- 检查互联网连接是否可用
-- @function [parent=#network] isInternetConnectionAvailable
-- @return boolean#boolean ret (return value: bool)  网络是否可用

--[[--

检查互联网连接是否可用

通常，这里接口返回 3G 网络的状态，具体情况与设备和操作系统有关。 

]]
-- end --

function Helper:isInternetConnectionAvailable()
    return avalon.NetManager:isInternetConnectionAvailable()
end

-- start --

--------------------------------
-- 检查是否可以解析指定的主机名
-- @function [parent=#network] isHostNameReachable
-- @param string hostname 主机名
-- @return boolean#boolean ret (return value: bool)  主机名是否可以解析

--[[--

检查是否可以解析指定的主机名

~~~ lua

if Helper:isHostNameReachable("www.google.com") then
    -- 域名可以解析
end

~~~

注意： 该接口会阻塞程序，因此在调用该接口时应该提醒用户应用程序在一段时间内会失去响应。 

]]
-- end --

function Helper:isHostNameReachable(hostname)
    if type(hostname) ~= "string" then
        printError("Helper:isHostNameReachable() - invalid hostname %s", tostring(hostname))
        return false
    end
    return avalon.NetManager:isHostNameReachable(hostname)
end

-- start --

--------------------------------
-- 返回互联网连接状态值
-- @function [parent=#network] getInternetConnectionStatus
-- @return string#string ret (return value: string)  互联网连接状态值

--[[--

返回互联网连接状态值

状态值有三种：

-   kCCNetworkStatusNotReachable: 无法访问互联网
-   kCCNetworkStatusReachableViaWiFi: 通过 WIFI
-   kCCNetworkStatusReachableViaWWAN: 通过 3G 网络

]]
-- end --

function Helper:getInternetConnectionStatus()
    return avalon.NetManager:getInternetConnectionStatus()
end

function Helper:getIPAddress()
    return avalon.NetManager:getIPAddress()
end

-- 统计网络消息
function Helper.analysisMsg(id, section, body)
    if msgAnalysisEnable then
        local key = tostring(tonumber(section) * 1000) .. tostring(id)
        local len = string.len(body)
        local data = msgAnalysis[key]
        if data == nil then
            data = {}
            data.count = 1
            data.len = len
            msgAnalysis[key] = data
        else
            data.count = data.count + 1
            data.len = data.len + len
        end
    end
end

function Helper.setAnalysisEnable(enable)
    if msgAnalysisEnable and not enable then
        Helper.saveAnalysisData()
    end
    msgAnalysisEnable = enable
end

function Helper.saveAnalysisData()
    AvalonUtil.saveObjectToFile(msgAnalysis, "netAnalysis", cc.FileUtils:getInstance():getWritablePath())
end

Net = Net or {}
Net.Helper = Helper
NetHelper = Net.Helper

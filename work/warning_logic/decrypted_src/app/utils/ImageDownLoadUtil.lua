--[[
    1、发送http请求拉取版本 和 图片url 保存本地（是否加密， 且标记已拉取最新信息
    2、对比本地版本号 如果大于本地版本号 直接下载且保存本地 (是否加密)
    3、打开界面时 判断是否已经是最新信息， 
    4   如果是 根据图片url判断本地是否有该文件 如果有直接使用， 如果没有先下载 再使用
        如果不是 先拉最新信息， 重复第二步，如果还在当前界面  重复第四步
]]

require("cocos.cocos2d.json")
require("cocos.network.NetworkConstants")
require("app.utils.ServerConfigUtil")
local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local GameDataManager = require("app.game.GameDataManager")

ImageDownLoadUtil = ImageDownLoadUtil or {}
local downLoadHandlers = {}
--下载存储目录
local CONSTANS_LOCAL_DIRECTION = "banner/downLoadImage/"
--banner 数据
local _saveDirection = CONSTANS_LOCAL_DIRECTION
local _bannerFile = "BannerInfo.ud"
local _splashFile = "SplashInfo.ud"
local _hasRefreshInfo = false 
local _bannerInfoData = nil
local _splashInfoData = nil
local REFRESH_FLAG_TIME = 60  --刷新_hasRefreshInfo 的时间间隔   秒
local _lastGetTime = 0 -- 上次拉取时间 秒
--游戏内公告数据
local _tNoticeFile = "TNoticeInfo"
local _noticeInfoData = {}
local _isFirstShowTNotice = true --防止 来回进入主城 都弹游戏内公告

function ImageDownLoadUtil:getUnionKey()
   return GameDataManager:getInstance():getSaveVersionKey()
end

-----------------拉取 开屏  begin---------------------------------
function ImageDownLoadUtil:getSplashFileName()
    if _splashInfoData == nil then
        _splashInfoData = self:readSplashInfo()
        if _splashInfoData == nil then
            return
        end
        return _splashInfoData.fileName, _splashInfoData.logoPosition
    end
    return _splashInfoData.fileName, _splashInfoData.logoPosition
end

function ImageDownLoadUtil:sendGetSplashImage()
    print("+++++++++++++++ServerConfigUtil:sendGetSplashImage()+++++++++++")
    if _splashInfoData == nil then
        _splashInfoData = self:readSplashInfo()
    end
    local params = {}
    params.target = SdkBox:getInstance():getVersionTarget()
    params.zone = checkint(ServerConfigUtil:getZoneId())
    params.channel = SdkBox:getInstance():getVersionChannel()
    params.platform = SdkBox:getInstance():getVersionPlatform()
    params.language = LanguageManager:getInstance():getLanguage()

    Net.Helper:sendHttpMessageByUrl(ServerConfigUtil:getWebManageUrl()..Net.HttpSubDirection.GetSplashImage, params, function(response)
        local newInfoData = json.decode(response)
        print("----------------++++++newInfoData", newInfoData)
        self:writeSplashInfo(response)
        _splashInfoData = newInfoData
        if _splashInfoData ~= nil and _splashInfoData.fileName ~= "" then
            self:downLoadImage(_splashInfoData.fileName, nil, nil, nil, true)
        end
    end, function(readyState,status)
        -- 失败重试
    end, HTTP_RETRY_INTERVAL) -- 5秒超时
end

function ImageDownLoadUtil:writeSplashInfo(fileData)
    local filePath = Avalon.FileManager:getPublicDataDirection().."splash/".._splashFile
    local isSuccess = Avalon.FileManager:writeDataToFile(Base64Encode(fileData) ,filePath)
    if not isSuccess then
        cc.FileUtils:getInstance():createDirectory(Avalon.FileManager:getPublicDataDirection().."splash/")
        Avalon.FileManager:writeDataToFile(Base64Encode(fileData) ,filePath)
    end
end

function ImageDownLoadUtil:_readSplashInfoo()
    local filePath = Avalon.FileManager:getPublicDataDirection().."splash/".._splashFile
    local content = Avalon.FileManager:readDataFromFile(filePath)
    if content == nil then
        return
    end
    local base64Str = Base64Decode(content)
    return json.decode(base64Str)
end

function ImageDownLoadUtil:readSplashInfo()
    local content = nil
    xpcall(function()
        content = self:_readSplashInfoo()
    end, 
    function(e) 
        self:writeSplashInfo("")
    end, 1)  
    return content
end
-----------------拉取 开屏  end---------------------------------


-----------------拉取banner  begin---------------------------------
--md5 加密校验
function ImageDownLoadUtil:getBannerInfoList()
    local webManageUrl = ServerConfigUtil:getWebManageUrl()
    if (not webManageUrl) then return end
    local httpurl = webManageUrl..Net.HttpSubDirection.BannerInfo
    local oldSaveDirection = _saveDirection
    _saveDirection = CONSTANS_LOCAL_DIRECTION..self:getUnionKey().."/"
    if oldSaveDirection ~= _saveDirection then
        _hasRefreshInfo = false
    end
    if _bannerInfoData == nil or #_bannerInfoData == 0 then
        _bannerInfoData = self:readBannerInfo()
    end
    local curTime = os.time()
    if curTime - _lastGetTime > REFRESH_FLAG_TIME then
        _lastGetTime = curTime
        _hasRefreshInfo = false
    end
    if _hasRefreshInfo then
        return
    end
    local sdkbox = SdkBox:getInstance()
    local tableData = {}
    tableData.target = sdkbox:getVersionTarget()
    tableData.zone = checkint(ServerConfigUtil:getZoneId())
    tableData.channel = sdkbox:getVersionChannel()
    tableData.platform = sdkbox:getVersionPlatform()
    tableData.language = LanguageManager:getInstance():getLanguage()
    local sortTable = AvalonUtil:sortParamByFirstChar(tableData)
    -- dump(sortTable, "sortTable")
    local md5ParamStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        md5ParamStr = md5ParamStr..v.value
        paramTable[v.key] = v.value
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr..WEB_MD5_KEY)

    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    -- print("--------get banner httpurl = "..httpurl)
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    xhr:setRequestHeader("Authorization", "Bearer "..md5Str)
    local function onReadyStateChanged()
        -- print("get banner reponse xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status, "xhr.status", xhr.status)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print(xhr.response)            
            local newInfoData = json.decode(xhr.response)
            -- dump(_bannerInfoData, "----_bannerInfoData")
            -- dump(table.nums(_bannerInfoData), "----#_bannerInfoData")
            if _bannerInfoData == nil or table.nums(_bannerInfoData) == 0  then
                self:writeBannerInfo(xhr.response)
                _bannerInfoData = newInfoData
            else
                if tonumber(_bannerInfoData.version or 0) < tonumber(newInfoData.version or 0) then
                    self:writeBannerInfo(xhr.response)
                    _bannerInfoData = newInfoData
                end
            end
            if _bannerInfoData ~= nil and _bannerInfoData.banner ~= nil then
                Avalon.MessageCenter:notice(GameMessage.MC_HTTP_BANNER_INFO_REFRESH, _bannerInfoData.banner)
                _hasRefreshInfo = true
  
                for k, v in pairs(_bannerInfoData.banner) do
                   self:downLoadImage(v.fileName)
                end
            end
        else
            -- print("get banner xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
        xhr:unregisterScriptHandler()
    end

    xhr:registerScriptHandler(onReadyStateChanged)
    local sendParam = json.encode(paramTable)
    -- print("  =----- sendParam "..sendParam)
    xhr:send(sendParam)
    -- xhr:send()
end

function ImageDownLoadUtil:getBannerInfoData()
    if _bannerInfoData == nil then
        return nil, false
    end
    local curTime = os.time()
    if curTime - _lastGetTime > REFRESH_FLAG_TIME then
        _lastGetTime = curTime
        _hasRefreshInfo = false
    end
    return _bannerInfoData.banner, _hasRefreshInfo
end

function ImageDownLoadUtil:writeBannerInfo(fileData)
    local filePath = Avalon.FileManager:getUserDataDirection().._saveDirection.._bannerFile
    local isSuccess = Avalon.FileManager:writeDataToFile(Base64Encode(fileData) ,filePath)
    if not isSuccess then
        cc.FileUtils:getInstance():createDirectory(Avalon.FileManager:getUserDataDirection().._saveDirection)
        Avalon.FileManager:writeDataToFile(Base64Encode(fileData) ,filePath)
    end
end

function ImageDownLoadUtil:_readBannerInfo()
    local filePath = Avalon.FileManager:getUserDataDirection().._saveDirection.._bannerFile
    local content = Avalon.FileManager:readDataFromFile(filePath)
    if content == nil then
        return
    end
    local base64Str = Base64Decode(content)
    return json.decode(base64Str)
end

function ImageDownLoadUtil:readBannerInfo()
    local content = ""
    xpcall(function()
        content = self:_readBannerInfo()
    end, 
    function(e) 
        self:writeBannerInfo("")
    end, 1)  
    return content
end
-----------------拉取banner  end---------------------------------


-----------------拉取游戏内公告  begin---------------------------------
function ImageDownLoadUtil:getTownNoticeFromWeb()
    -- print("--------------ImageDownLoadUtil:getTownNoticeFromWeb()")
    local webManageUrl = ServerConfigUtil:getWebManageUrl()
    if (not webManageUrl) then return end
    local httpurl = webManageUrl..Net.HttpSubDirection.TownNotice
    local sdkbox = SdkBox:getInstance()
    local tableData = {}
    tableData.zone = checkint(ServerConfigUtil:getZoneId())
    tableData.channel = sdkbox:getVersionChannel()
    tableData.languageType = LanguageManager:getInstance():getLanguage()
    local filterP = self:getTownNoticeFilterParam()
    if not filterP then
        return
    end

    tableData.filterCondition = json.encode(filterP)--赛选条件

    local sortTable = AvalonUtil:sortParamByFirstChar(tableData)
    -- dump(sortTable, "sortTable")
    local md5ParamStr = ""
    local paramTable = {}
    for k, v in ipairs(sortTable) do
        md5ParamStr = md5ParamStr..v.value
        paramTable[v.key] = v.value
    end
    local md5Str = AvalonUtil:MD5(md5ParamStr..WEB_MD5_KEY)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    -- print("--------get TownNotice httpurl = "..httpurl)
    xhr:open("POST", httpurl)
    xhr:setRequestHeader("Content-Type", "application/json; charset=utf-8")
    xhr:setRequestHeader("Authorization", "Bearer "..md5Str)
    local function onReadyStateChanged()
        -- print("get TownNotice reponse xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status, "xhr.status", xhr.status)
        -- dump(xhr.response, "---------xhr.response------")
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            -- print(xhr.response)            
            _noticeInfoData = json.decode(xhr.response)
            -- dump(_noticeInfoData, "----_noticeInfoData---")
            if _noticeInfoData ~= nil then
                for k, v in pairs(_noticeInfoData) do
                    if type(v) == "table" then
                        self:downLoadImage(v.image)
                    end
                end
            end
        else
            -- print("get banner xhr.readyState is:", xhr.readyState, "xhr.status is: ",xhr.status)
        end
        xhr:unregisterScriptHandler()
    end

    xhr:registerScriptHandler(onReadyStateChanged)
    local sendParam = json.encode(paramTable)
    -- print("  =----- sendParam "..sendParam)
    xhr:send(sendParam)
end

function ImageDownLoadUtil:getTownNoticeFilterParam()
    local params = {}
    local master = RoleDataManager:getMaster()
    if not master then
        return
    end

    params.chargeMoney = MasterDataManager:getPayMoneyCount()-- 1   充值金额(分)
    params.lastLoginTime = master:getLastOffLineTime()-- 2   回归条件(天)
    params.level = master:getLevel()-- 3   等级范围
    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    params.normalLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())-- 4   洞窟进度
    params.createTime = master:getCreateRoleTime()-- 5   注册时间(天)
    params.lastCharge = master:getLastPurchaseTime()-- 6   付费沉默(天)
    if master.isOldPlayerComeBack then
        params.secondLevelTime = master:getLastOffLineTime()-- 7   老玩家二次参数的离线时间(天)
    else
        params.secondLevelTime = 0
    end
    return params
end

function ImageDownLoadUtil:getTNoticeInfo()
    if not _isFirstShowTNotice or _noticeInfoData == nil or #_noticeInfoData == 0 then
        return {}
    end
    local list = {}
    local curDate = os.date("*t")
    local pk = RoleDataManager:getMaster():getPK()
    local generateDate = os.date("*t", cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.ShowTownNoticeTime..pk, 0))
    local isOutOfDate = false
    if curDate.year * 10000 + curDate.month * 100 + curDate.day > generateDate.year * 10000 + generateDate.month * 100 + generateDate.day then
        isOutOfDate = true
    end
    local isTap = self:checkIsTap()
    for k, v in ipairs(_noticeInfoData) do
        if v.isOnce and not isOutOfDate then
        else
            if not v.isTapTap then
                table.insert(list, v)
            elseif v.isTapTap and v.isTapTap ~= 1 then
                table.insert(list, v)
            elseif v.isTapTap and v.isTapTap == 1 and isTap then
                table.insert(list, v)
            end
            
        end
    end
    return list
end

function ImageDownLoadUtil:setIsFirstShowTNotice(isFirstShowTNotice)
    _isFirstShowTNotice = isFirstShowTNotice
end

function ImageDownLoadUtil:getTapTNoticeInfo()
    if _noticeInfoData == nil or #_noticeInfoData == 0 then
        return {}
    end
    local list = {}
    local curDate = os.date("*t")
    local pk = RoleDataManager:getMaster():getPK()
    local generateDate = os.date("*t", cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.ShowTownNoticeTime..pk, 0))
    local isOutOfDate = false
    if curDate.year * 10000 + curDate.month * 100 + curDate.day > generateDate.year * 10000 + generateDate.month * 100 + generateDate.day then
        isOutOfDate = true
    end
    local isTap = self:checkIsTap()
    for k, v in ipairs(_noticeInfoData) do
        
        if v.isOnce and not isOutOfDate then
        elseif v.isTapTap and v.isTapTap == 1 and isTap then
            table.insert(list, v)
        end
    end
    return list
end

function ImageDownLoadUtil:getTapTapBtnIsShow()
    local isShow = false
    local tapTNoticeInfo = self:getTapTNoticeInfo()

    if tapTNoticeInfo ~= {} and next(tapTNoticeInfo) and self:checkIsTap() then
        isShow = true
    end

    return isShow
end

function ImageDownLoadUtil:checkIsTap()
    local isRightChannel = false
    local SdkBox = require("utils.sdkbox.SdkBox")
    local channel = SdkBox:getInstance():getVersionChannel()
    local media = SdkBox:getInstance():getLeitingMediaValue()
    print("checkIsTap1111:", media, channel)

    if (media == "M142073" or device.platform == "ios" or CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        isRightChannel = true
    elseif media == "none" and channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_LEITING or channel == PublicDefine.VERSION_CHANNEL.VERSION_CHANNEL_QUICK then
        isRightChannel = true
    end

    print("checkIsTapss:", isRightChannel)
    return isRightChannel
end
-----------------拉取游戏内公告  end---------------------------------

function ImageDownLoadUtil:downLoadImage(url, target, func, funcFailed, isPublic)
    if url == nil or url == "" then
        return
    end
    --print("downLoadImage device.platform = ", device.platform)
    if (device.platform == "ios" or device.platform == "mac" ) then
        url = string.urldecode(url)
        --print("downLoadImage url = ", url)
    end

    local encodeKey = AvalonUtil:MD5(url)
    local direction = ""
    if isPublic then
        direction = Avalon.FileManager:getPublicDataDirection().._saveDirection
    else
        direction = Avalon.FileManager:getUserDataDirection().._saveDirection
    end
    local fullFileName =  direction..encodeKey

    if cc.FileUtils:getInstance():isFileExist(fullFileName) then
        -- print("file is have save!!!!!!!!")
        if target ~= nil and func ~= nil then
            func(url, fullFileName)
        end
        return
    end
    if target ~= nil and func ~= nil then
        self:addHandler(encodeKey, target, func)
    end
    local xhr = cc.XMLHttpRequest:new()
    -- url = "http://cocos2d-x.org/s/images/img-cocos2dx.jpg"
    xhr._urlFileName = "urlFileName"
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", url)
    local function onDownloadImage()
        -- print("xhr.readyState is:", xhr.readyState, "xhr.status is: ", xhr.status)
        if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            local fileData = xhr.response
            cc.FileUtils:getInstance():createDirectory(direction)   
            -- print("fullFileName = "..fullFileName)
            local file = io.open(fullFileName,"wb")
            if file then
                file:write(fileData)
                file:close()
            end
            self:imageDownCallback(url, encodeKey, fullFileName)
        else
            if (funcFailed) then funcFailed(target, url) end
        end
    end
    xhr:registerScriptHandler(onDownloadImage)
    xhr:send()
end

function ImageDownLoadUtil:addHandler(md5key, target, func)
    if downLoadHandlers[md5key] == nil then
        local handlerList ={}
        local handler = {
            [1] = target,
            [2] = func
        }
        table.insert(handlerList, handler)
        downLoadHandlers[md5key] = handlerList
    else
        local handlerList ={}
        local handler = {
            [1] = target,
            [2] = func
        }
        table.insert(downLoadHandlers[md5key], handler)
    end
end

function ImageDownLoadUtil:imageDownCallback(url, md5key, fullFileName)
    for k, handlerList in pairs(downLoadHandlers) do
        if k == md5key then
            for k = #handlerList, 1, -1 do
                local handler = handlerList[k]
                _target = handler[1]
                _func = handler[2]
                if _target ~= nil and _func ~= nil then
                    _func(url, fullFileName)
                end
                table.remove(handlerList, k)
            end
            break
        end
    end
end

function ImageDownLoadUtil:clear()
    _hasRefreshInfo = false 
    _bannerInfoData = {}
    _lastGetTime = 0

    _noticeInfoData = {}
    _isFirstShowTNotice = true
end

return ImageDownLoadUtil
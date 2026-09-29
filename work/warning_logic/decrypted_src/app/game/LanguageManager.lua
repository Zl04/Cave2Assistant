-- LanguageManager.lua
-- Author:ODEI
-- 2017年3月31日
-- Using:多语言管理 
          
local SdkBox = require("utils.sdkbox.SdkBox")

local LanguageManager = class("LanguageManager")
g_LanguageManager = nil;

function LanguageManager:ctor()
	self.profileLanguage = nil --语言表

    self._inited = false
    self._languagePath = nil
    -- self.handlerList ={}

    self.currentLanguageType = cc.LANGUAGE_CHINESE      --当前语言
    self:clear()
end


function LanguageManager:getInstance()
	if g_LanguageManager == nil then
		g_LanguageManager = LanguageManager.new()
        g_LanguageManager:initLanguage()

	end
	return g_LanguageManager;
end


function LanguageManager:purgeInstance()
	if g_LanguageManager ~= nil then
		g_LanguageManager = nil;
	end
end

function LanguageManager:clear()
    self._localWebLanguageList = {}
    self._isHaveRead = false
end

-- 设置当前语言
function LanguageManager:setLanguage(language)
    print("----------------- LanguageManager:setLanguage language = "..language)
    if self.currentLanguageType == languages then
        return
    end

    -- add by zp 这里由于公会日志缓存了最终的文本，里面携带有多语言相关文字，这里清理掉本地缓存
    local GameDataManager = require("app.game.GameDataManager")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if(globalUserData) then
        globalUserData:setGuildLogVersion(0)
        globalUserData:setGuildMinVersion(0)
        local stringKeyArr = {}
        globalUserData:setGuildLogData(stringKeyArr)
        Avalon.UserDataManager:saveDataToFile(globalUserData:getType())
    end
    
    self.protocolLanguage = nil

    if (device.platform == "mac") then
    else
        local searchPath = self:getLanguageSearchPath(self.currentLanguageType)
        local pSearchPaths = cc.FileUtils:getInstance():getSearchPaths()
        for i = #pSearchPaths,1,-1 do
            if string.find(pSearchPaths[i],searchPath) then
                table.remove(pSearchPaths,i)
            end
        end
        cc.FileUtils:getInstance():setSearchPaths(pSearchPaths)
        cc.FileUtils:getInstance():purgeCachedEntries()
    end
    -- dump(pSearchPaths)
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.oldLanguage, self.currentLanguageType)
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.language, language)
    cc.UserDefault:getInstance():flush()
    self.currentLanguageType = language
    self._inited = false
    self:clear()
    self:initLanguage()

    reload_script_file("ProfileLanguage")
    self.profileLanguage = require "ProfileLanguage"
    -- print("1111",UI.TEXT_111140)
    reload_script_file("app.ui.UIDes")
    -- print("2222",UI.TEXT_111140)
    reload_script_file("app.config.ConfigManager", 0 )
    ConfigManager:clear()

    Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_LANGUAGE)
end

-- 获取当前语言
function LanguageManager:getLanguage()
    return self.currentLanguageType
end

-- 获取当前语言 isJudeOnly:是否判断当前只支持一种语言的情况
function LanguageManager:getLanguageSearchPath(languageType, isJudeOnly)
    if isJudeOnly == nil then
        isJudeOnly = true
    end
    local searchPath = "ResourceEN/"
    UI.FONT_BOLD = searchPath.."bold.ttf"
    UI.FONT_STANDARD = searchPath.."standard.ttf"
    UI.FONT_DES = searchPath.."describe.ttf"

    local userProtocolFileName = "ProfileUserAgreement_cn"
    if languageType == cc.LANGUAGE_ENGLISH then
        -- print("current language is English")
        searchPath = "ResourceEN/"
        UI.FONT_BOLD = searchPath.."bold.ttf"
        UI.FONT_STANDARD = searchPath.."standard.ttf"
        UI.FONT_DES = searchPath.."describe.ttf"
        userProtocolFileName = "ProfileUserAgreement_en"
    elseif languageType == cc.LANGUAGE_CHINESE then
        -- print("current language is Chinese")
        searchPath = "ResourceCN/"
        UI.FONT_BOLD = searchPath.."bold.ttf"
        UI.FONT_STANDARD = searchPath.."standard.ttf"
        UI.FONT_DES = searchPath.."describe.ttf"
        userProtocolFileName = "ProfileUserAgreement_cn"
    -- elseif languageType == cc.LANGUAGE_FRENCH then
    --     -- print("current language is French")
    --     searchPath = "ResourceFR/"
    -- elseif languageType == cc.LANGUAGE_GERMAN then
    --     -- print("current language is German")
    --     searchPath = "ResourceDE/"
    -- elseif languageType == cc.LANGUAGE_ITALIAN then
    --     -- print("current language is Italian")
    --     searchPath = "ResourceEN/"
    elseif languageType == cc.LANGUAGE_RUSSIAN then
        -- print("current language is Russian")
        searchPath = "ResourceRU/"
        UI.FONT_BOLD = searchPath.."bold.ttf"
        UI.FONT_STANDARD = searchPath.."standard.ttf"
        UI.FONT_DES = searchPath.."describe.ttf"
        userProtocolFileName = "ProfileUserAgreement_ru"
    -- elseif languageType == cc.LANGUAGE_SPANISH then
    --     -- print("current language is Spanish")
    elseif languageType == cc.LANGUAGE_THAI then
        -- print("current language is Spanish")
        searchPath = "ResourceTH/"
        UI.FONT_BOLD = searchPath.."bold.ttf"
        UI.FONT_STANDARD = searchPath.."standard.ttf"
        UI.FONT_DES = searchPath.."describe.ttf"
        userProtocolFileName = "ProfileUserAgreement_th"
    elseif languageType == cc.LANGUAGE_KOREAN then
        -- print("current language is Korean")
        searchPath = "ResourceKR/"
        UI.FONT_BOLD = searchPath.."bold.ttf"
        UI.FONT_STANDARD = searchPath.."standard.ttf"
        UI.FONT_DES = searchPath.."describe.ttf"
        userProtocolFileName = "ProfileUserAgreement_kr"
    -- elseif languageType == cc.LANGUAGE_JAPANESE then
    --     -- print("current language is Japanese")
    --     searchPath = "ResourceJP/"
    -- elseif languageType == cc.LANGUAGE_HUNGARIAN then
    --     -- print("current language is Hungarian")
    -- elseif languageType == cc.LANGUAGE_PORTUGUESE then
    --     -- print("current language is Portuguese")
    elseif languageType == cc.LANGUAGE_CHINESE_TRADITIONAL then
        searchPath = "ResourceCNTRA/"
        UI.FONT_BOLD = searchPath.."bold.ttf"
        UI.FONT_STANDARD = searchPath.."standard.ttf"
        UI.FONT_DES = searchPath.."describe.ttf"
        userProtocolFileName = "ProfileUserAgreement_hant"
    else
        local supportLans = SdkBox:getInstance():getSupportLanguages()
        if #supportLans == 1 and isJudeOnly then
            searchPath, userProtocolFileName = self:getLanguageSearchPath(supportLans[1], false)
        else
            searchPath = "ResourceEN/"
            UI.FONT_BOLD = searchPath.."bold.ttf"
            UI.FONT_STANDARD = searchPath.."standard.ttf"
            UI.FONT_DES = searchPath.."describe.ttf"
            userProtocolFileName = "ProfileUserAgreement_en"
        end
    end
    return searchPath, userProtocolFileName
end

--初始化多语言和设置searchPath
function LanguageManager:initLanguage()
    print("----------------- LanguageManager:initLanguage ")
    -- dump( cc.FileUtils:getInstance():getSearchPaths(), "-----1111111------- cc.FileUtils:getInstance():getSearchPaths()")
    if (self._inited) then return end
    if (device.platform == "mac") then
        self:__initLanguage()
    else
        self:_initLanguage()
    end

    local versionTarget = SdkBox:getInstance():getVersionTarget()
    self.userProtocolDir = ""
    if versionTarget == PublicDefine.VERSION_TARGET.VERSION_TARGET_DEV then
        self.userProtocolDir = "userProtocol.global."
    elseif versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
        self.userProtocolDir = "userProtocol.global."
    elseif versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_CN then
        self.userProtocolDir = "userProtocol.cn."
    elseif versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE then
        self.userProtocolDir = "userProtocol.cn."
    else
        self.userProtocolDir = "userProtocol.cn."
    end
    print("initLanguage versionTarget = ", versionTarget .. ", userProtocolDir = " .. self.userProtocolDir)
    -- dump( cc.FileUtils:getInstance():getSearchPaths(), "--222222---------- cc.FileUtils:getInstance():getSearchPaths()")

    SdkBox:getInstance():initGoogleTranslation(self.currentLanguageType)

end


--移动端处理逻辑
function LanguageManager:_initLanguage()
    local supportLans = SdkBox:getInstance():getSupportLanguages()

    local currentLanguageType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.language,-1)          -- 语言    
    if currentLanguageType == -1 then
        currentLanguageType = cc.LANGUAGE_ENGLISH
        local versionTarget = SdkBox:getInstance():getVersionTarget()
        if versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_CN
            or versionTarget ==  PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE
            then
                currentLanguageType = cc.LANGUAGE_CHINESE
        end
        local localLan = cc.Application:getInstance():getCurrentLanguage()
        for i,v in ipairs(supportLans) do
            if localLan == v then
                currentLanguageType = localLan 
                break;
            end
        end
    end
    local searchPath = self:getLanguageSearchPath(currentLanguageType)
    local tempSearchPath = "res/"..searchPath
    local tempWritableSearchPath = cc.FileUtils:getInstance():getWritablePath().."CaveOnline/Hotfix/res/"..searchPath
    cc.FileUtils:getInstance():addSearchPath(tempSearchPath)
    cc.FileUtils:getInstance():addSearchPath(tempWritableSearchPath,true)
    self._inited = true
    self._languagePath = tempSearchPath
    self.currentLanguageType = currentLanguageType
    
end

--模拟器处理逻辑
function LanguageManager:__initLanguage()
    print("----------LanguageManager:__initLanguage()")
    local supportLans = SdkBox:getInstance():getSupportLanguages()

    local currentLanguageType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.language,-1)          -- 语言
    local oldLanguageType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.oldLanguage,-1)
    
    if currentLanguageType == -1 then
        currentLanguageType = cc.LANGUAGE_CHINESE
        local localLan = cc.Application:getInstance():getCurrentLanguage()
        for i,v in ipairs(supportLans) do
            if localLan == v then
                currentLanguageType = localLan 
                break;
            end
        end
    end
    if oldLanguageType == -1 then
        oldLanguageType = cc.LANGUAGE_CHINESE
    end
    local searchPath = self:getLanguageSearchPath(currentLanguageType)
    local oldSearchPath = self:getLanguageSearchPath(oldLanguageType)
    local pSearchPaths = cc.FileUtils:getInstance():getSearchPaths()

        print("----------oldSearchPath searchPath = ", oldSearchPath, searchPath)


    self._languagePath = "res/"..searchPath
    for i = #pSearchPaths,1,-1 do
        if string.find(pSearchPaths[i],oldSearchPath) then
            local newPath = string.gsub(pSearchPaths[i], oldSearchPath, searchPath)
            self._languagePath = newPath
            pSearchPaths[i] = newPath
        end
    end

    cc.FileUtils:getInstance():setSearchPaths(pSearchPaths)
    cc.FileUtils:getInstance():purgeCachedEntries()
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.oldLanguage,-1)

    -- local tempWritableSearchPath = cc.FileUtils:getInstance():getWritablePath().."CaveOnline/Hotfix/res/"..searchPath
    -- cc.FileUtils:getInstance():addSearchPath(tempWritableSearchPath,true)
    
    self._inited = true
    self.currentLanguageType = currentLanguageType

end

-- 判断是否为中文语言
function LanguageManager:isChineseLanguage()
     local currentLanguageType = cc.Application:getInstance():getCurrentLanguage()

    if currentLanguageType == cc.LANGUAGE_CHINESE then
        return true
    end

    return false
end

-- 获取多语言目录
function LanguageManager:getPath()
    -- 路径到这一层就够了,而且fullPathForFilename只传路径 在android下获取不到的。因为android资源都是在apk下面。
    if (self._languagePath) then
        -- return cc.FileUtils:getInstance():fullPathForFilename(self._languagePath).."/"
        return self._languagePath
    else
        return nil 
    end
end

--根据策划给的ID获得多语言文本
--@param #int mKey 相应的语言ID 
--@return #string 返回对应的字符串
function LanguageManager:getLocalString(mKey, isDefault)
    if (not self._inited) then self:initLanguage() end
    if(mKey == nil) then 
        assert(false, "LanguageManager:getLocalString mKey is nil.")
        return "" 
    end 

    if self.profileLanguage == nil then 
        -- print("LanguageManager:getLocalString",111)
        self.profileLanguage = require "ProfileLanguage"
        -- print(self.profileLanguage[1010001].language)
    end

    local data = self.profileLanguage[mKey]
    if(data) then
        return self.profileLanguage[mKey].language
    else
        if isDefault then
            return "e:"..mKey
        else
            if(type(mKey) == "number") then
                return "e:"..mKey
            else
                return mKey
            end
        end
    end

    -- return self.profileLanguage[mKey].language
end

--根据策划给的ID获得多语言文本
--@param #int mKey 相应的语言ID 
--@return #string 返回对应的字符串
function LanguageManager:getProtocolString(mKey, defaultValue)
    if (not self._inited) then 
        self:initLanguage()
    end
    if(mKey == nil) then 
        assert(false, "LanguageManager:getProtocolString mKey is nil.")
        return "" 
    end 

    if self.protocolLanguage == nil then 
        local _, userProtocolFileName = self:getLanguageSearchPath(self.currentLanguageType)
        print("init protocolLanguage currentLanguageType = ", self.currentLanguageType)
        print("init protocolLanguage userProtocolFileName = ", self.userProtocolFileName)
        local languageFile = self.userProtocolDir .. userProtocolFileName
        self.protocolLanguage = require (languageFile)
    end

    local data = self.protocolLanguage[mKey]
    if(data) then
        return self.protocolLanguage[mKey].language
    else
        return defaultValue
    end
end

function LanguageManager:getLanguageWebStrForKey(key)
    if(key == nil or key == "") then 
        return ""
    end
    if(self:isHaveLocalLanguage(key)) then
        return self._localWebLanguageList[key]
    end
    
    return ""
end

-- 获取网络数据
function LanguageManager:getLanguageFromWebServer(keyList, callback, ...)
    local params = {...}
    local function successCallback(languageList)
        local dataMap = {}
        local isNewData = false
        local logKey = {} --用于上报日志服务器 是否有缺失的多语言key
        for k, v in ipairs(keyList) do
            if self:isHaveLocalLanguage(v) then
                dataMap[v] = self._localWebLanguageList[v]
            else
                for k2, v2 in ipairs(languageList) do
                    if v2.id == v then
                        dataMap[v] = v2.arr
                        self._localWebLanguageList[v] = v2.arr
                        isNewData = true
                        break
                    end
                end
            end
            if dataMap[v] == nil then
                table.insert(logKey, v)
            end
        end

        if #logKey > 0 then
            local keyStr = ""
            for k, v in ipairs(logKey) do
                keyStr = keyStr..","..v
            end
            printError("webServer do not have languageKeys : "..keyStr)   
        end

        if callback then
            callback(dataMap, params)
        end
        if isNewData then
            self:writeLocalLanguageList()
        end
    end 

    local idsStr = ""
    for k, v in ipairs(keyList) do
        if not self:isHaveLocalLanguage(v) then
            idsStr = idsStr..v..","
        end
    end
    if string.trim(idsStr) == "" then
        successCallback({})
        return
    end
    local strLen = string.len(idsStr)  
    idsStr = string.sub(idsStr, 0, strLen - 1)

    local tableData = {}
    tableData.languageType = self:getLanguage()
    tableData.id = idsStr

    Net.Helper:sendHttpMessage(Net.HttpSubDirection.WebLanguage,tableData,function(response)
        local languageList = json.decode(response).data
        successCallback(languageList)
    end,function(readyState,status)
        print("-------------LanguageManager:getLanguageFromWebServer !!!! fail", readyState, status)
    end)
end

function LanguageManager:isHaveLocalLanguage(languageKey)
    if not self._isHaveRead then
        self:readLocalLanguageList()
    end
    return self._localWebLanguageList[languageKey] ~= nil
end

--
function LanguageManager:writeLocalLanguageList()
    if not self._isHaveRead then
        return
    end
    local languageType = self:getLanguage()
    Avalon.FileManager:saveMapDataToLocal(self._localWebLanguageList, "webLanguage"..languageType, true)
end

function LanguageManager:readLocalLanguageList()
    self._isHaveRead = true
    local languageType = self:getLanguage()
    self._localWebLanguageList = Avalon.FileManager:readMapDataFromLocal("webLanguage"..languageType, true)
    -- dump(self._localWebLanguageList, "-----self._localWebLanguageList")
end

function LanguageManager:getCurrencySymbol()
    local symbol = "￥"
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        symbol = "$"
    end
	return symbol
end

--已知道： 中、繁、日、韩
function LanguageManager:isCJKUnicode(languageType)
    if languageType == nil then
        languageType = self:getLanguage()
    end
    if languageType == cc.LANGUAGE_CHINESE  or languageType == cc.LANGUAGE_CHINESE_TRADITIONAL  or 
        languageType == cc.LANGUAGE_JAPANESE  or languageType == cc.LANGUAGE_KOREAN then
        return true
    end
end

return LanguageManager;
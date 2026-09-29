

AvalonUtil = {}

AvalonUtil.CC_PLATFORM_IOS = 1
AvalonUtil.CC_PLATFORM_ANDROID = 2
require "cocos.cocos2d.json"
local ProtobufUtil = require("utils.ProtobufUtil")

local PUBLIC_AES_KEY = "#LeitingAESKey#!"
local PUBLIC_GLOBAL_AES_KEY = "#AvalongAESKey#!"

local DEBUG = true
if DEBUG then
    function printfmt(...)
        local function wrapper(...) 
            local w = debug.getinfo(4, "Sl")
            io.write(w.short_src .. ":" .. w.currentline .. " ".. string.format(...) .. "\n") 
        end
        local status, result = pcall(wrapper, ...)
        if not status then error(result, 2) end
    end

    function printfmt2(...)
        local function wrapper(...) 
            local w = debug.getinfo(6, "Sl")
            io.write(w.short_src .. ":" .. w.currentline .. " ".. string.format(...) .. "\n") 
        end
        local status, result = pcall(wrapper, ...)
        if not status then error(result, 2) end
    end
else 
    function printfmt() end
    function printfmt2() end
end

function string.hasPrefix(string, prefix)
    return string.sub(string, 1, string.len(prefix)) == prefix 
end

function string.hasSuffix(string, suffix)
    return suffix == "" or string.sub(string, -string.len(suffix)) == suffix 
end

function string:split(sep)
    local t = {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) t[#t+1] = c end)
    return t
end

function AvalonUtil.lines(str)
    local t = {}
    local function helper(line)
        if #line > 0 then
            table.insert(t, line)
        end
        return ""
    end
    helper((str:gsub("(.-)\r?\n", helper)))
    return t
end

--获取设备的平台 IOS ANDROID
function AvalonUtil.getPlatform()
    local platformTemp = avalon.Util:getPlatform()
    -- print ("Current Platform:",platformTemp)
    return platformTemp
end

-- 获取target
function AvalonUtil.getCaveOnlineTarget()
    local target = avalon.Util:getCaveOnlineTarget()
    print("CaveOnlineTarget ",target)
    return target
end

-- 获取设备标识
function AvalonUtil.getIdentifier()
    local identifier = avalon.Util:getIdentifier()
    return identifier
end

-- 获取当前版本
function AvalonUtil.getMyVersion()
    local version = avalon.Util.getMyVersion()

    print("version:",version)

    return version
end

-- 版本号比对
function AvalonUtil.checkTargetVersionCompar(versionOne, versionTow)
    -- versionOne >= versionTow
    local compar = false
    local oneList = string.split(versionOne, ".")
    local towList = string.split(versionTow, ".")

    if #oneList == #towList then
        local less = false
        for k,v in ipairs(oneList) do
            local leftValue = tonumber(v)
            local rightValue = tonumber(towList[k])

            if leftValue < rightValue then
                less = true
                break
            elseif leftValue > rightValue then
                compar = true
                break
            end
        end

        if not less then
            compar = true
        end
    end

    return compar
end

-- 判断是否安装某个应用
function AvalonUtil.checkIsInstalled(urlScheme)
    local isInstall = avalon.Util.checkIsInstalled(urlScheme)

    print("checkIsInstalled:",isInstall)

    return isInstall
end

function AvalonUtil.openUrl(url)
    local openSuccess = avalon.Util.openUrl(url)

    print("openUrl:",openSuccess)

    return openSuccess
end

-- 获取当前系统毫秒级时间
function AvalonUtil.getCurrentTime()
    local time = avalon.Util.getCurrentTime()

    return time
end

function AvalonUtil.getSpineVersion()
    if sp.AvalonAnimation.getSpineVersion == nil then
        return 0
    else
        return sp.AvalonAnimation:getSpineVersion()
    end
end

-- 
function AvalonUtil.getLock()
    return avalon.Util.getClock()
end

function AvalonUtil:strIsEmail(str)
    -- body
    if(str and type(str) == "string") then
        if (str:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")) then  
            return true
        end
        -- return string.match(str,"%w+([-+.]%w+)*@%w+([-.]%w+)*%.%w+([-.]%w+)*") == str
    end

    return false
end

-- 是否为全面屏，这里在未来获取不一定完全正确，需要对新的设备做持续适配
function AvalonUtil.isFullScreen()
    -- local director = cc.Director:getInstance()
    -- local glView   = director:getOpenGLView()
    -- local screenSize = glView:getFrameSize()

    -- print("AvalonUtil.isFullScreen=", screenSize.width, screenSize.height)
    -- if(screenSize.width / screenSize.height > 16/9) then
    --     return true
    -- end

    return false
end

-- 判断是否低内存设备
function AvalonUtil.isSmallMemoryDevice()
    if(AvalonUtil.IsIphone6()) then 
        --print("this device is iphone6")
        return true
    end

    return false
end

--判断IOS设备
function AvalonUtil.IsIphone6()
    --  判断平台 flag
    if AvalonUtil.getPlatform() ~= AvalonUtil.CC_PLATFORM_IOS then
        return false
    end
    local deviceName = AvalonUtil.getDeviceName()
    if(deviceName == "iPhone7,2" or deviceName == "iPhone7,1") then 
        return true
    end

    return false
end

--判断IOS设备
function AvalonUtil.IsIphone5()
    local director = cc.Director:getInstance()
    local glView   = director:getOpenGLView()
    local screenSize = glView:getFrameSize()
    local flag = false
    --  判断平台 flag
    if AvalonUtil.getPlatform() == AvalonUtil.CC_PLATFORM_IOS then
        flag = true
    end

    if screenSize.width == 1136 and flag then
        return true
    else
        return false
    end
end

function AvalonUtil.ISIphone4()
    local director = cc.Director:getInstance()
    local glView   = director:getOpenGLView()
    local screenSize = glView:getFrameSize()
    local flag = true
    --  判断平台 flag
    if AvalonUtil.getPlatform() == AvalonUtil.CC_PLATFORM_IOS then
        flag = true
    end

    if screenSize.width == 960 and screenSize.width == 640 and flag then
        return true
    else
        return false
    end
end

function AvalonUtil.IsIPad()
    local director = cc.Director:getInstance()
    local glView   = director:getOpenGLView()
    local screenSize = glView:getFrameSize()
    local flag = true
    --  判断平台 flag
    if AvalonUtil.getPlatform() == AvalonUtil.CC_PLATFORM_IOS then
        flag = true
    end

    if screenSize.width == 1024 and screenSize.height == 768 and flag then
        return true
    elseif screenSize.width == 1024*2 and screenSize.height == 768*2 and flag then
        return true
    else
        return false
    end
end


function AvalonUtil.IsIPad1or2()
    local director = cc.Director:getInstance()
    local glView   = director:getOpenGLView()
    local screenSize = glView:getFrameSize()
    local flag = true
        --  判断平台 flag
    if AvalonUtil.getPlatform() == AvalonUtil.CC_PLATFORM_IOS then
        flag = true
    end

    if screenSize.width == 1024 and screenSize.height == 768 and flag then
        return true
    else
        return false
    end
end

function AvalonUtil.strToNumber(numberStr)
    local type = type(numberStr)
    if (type == "number") then
        return numberStr
    else
        if (type ~= "string") then
            assert(string.format("[ERROR] AvalonUtil:strToNumber excepte string argument."))
            return nil
        end
    end

    local number = tonumber(numberStr)
    if number ~= nil then
        return number;
    else
        assert(string.format("[ERROR] AvalonUtil:strToNumber could not convert %s to number.", numberStr))
        return nil;
    end
end

local str_sub   = string.sub
local str_rep   = string.rep
function AvalonUtil:c3b_parse(s)
    local r, g, b = 0, 0, 0
    if #s == 4 then
        r, g, b =   tonumber(str_rep(str_sub(s, 2, 2), 2), 16),
            tonumber(str_rep(str_sub(s, 3, 3), 2), 16),
            tonumber(str_rep(str_sub(s, 4, 4), 2), 16)
    elseif #s == 7 then
        r, g, b =   tonumber(str_sub(s, 2, 3), 16),
            tonumber(str_sub(s, 4, 5), 16),
            tonumber(str_sub(s, 6, 7), 16)
    elseif #s == 6 then
        r, g, b =  tonumber(str_sub(s, 1, 2), 16),
            tonumber(str_sub(s, 3, 4), 16),
            tonumber(str_sub(s, 5, 6), 16)
    elseif #s<=2 then
         return tonumber(s)                           
    end

    return cc.c3b(r, g, b)
end
function AvalonUtil:splitStr(str, delimiter)
    local result = {}

    if (str and #str > 0) then
        local startPos = 0
        local endPos = 0
        local lastPos = 0
        repeat 
            lastPos = startPos + 1
            startPos, endPos = string.find(str, delimiter, startPos + 1)

            local subStr = nil
            if (startPos) then
                subStr = string.sub(str, lastPos, startPos - 1)
            else
                subStr = string.sub(str, lastPos)
            end
            if (subStr) then
                table.insert(result, subStr)
            end
        until (startPos == nil)
    end
    return result
end

-- 计算 UTF8 字符串的长度，每一个中文算一个字符
-- @function [parent=#string] utf8len
-- @param string input 输入字符串
-- @return integer#integer  长度
--[[--
计算 UTF8 字符串的长度，每一个中文算一个字符
~~~ lua
local input = "你好World"
print(string.utf8len(input))
-- 输出 7
~~~
]]
-- end --
function AvalonUtil.utf8len(input)
    local len  = string.len(input)
    local left = len
    local cnt  = 0
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    while left ~= 0 do
        local tmp = string.byte(input, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i                
                break
            end
            i = i - 1
        end
        cnt = cnt + 1
    end
    return cnt
end

-- lzh
-- 功能：将字符串拆成单个字符，存在一个table中
function AvalonUtil.utf8tochars(input)
     local list = {}
     local len  = string.len(input)
     local index = 1
     local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
     while index <= len do
        local c = string.byte(input, index)
        local offset = 1
        if c < 0xc0 then
            offset = 1
        elseif c < 0xe0 then
            offset = 2
        elseif c < 0xf0 then
            offset = 3
        elseif c < 0xf8 then
            offset = 4
        elseif c < 0xfc then
            offset = 5
        end
        local str = string.sub(input, index, index+offset-1)
        -- print(str)
        index = index + offset
        table.insert(list, {byteNum = offset, char = str})
     end

     return list
end

function StringToTable(s)  
    local tb = {}  
      
    --[[  
    UTF8的编码规则：  
    1. 字符的第一个字节范围： 0x00—0x7F(0-127),或者 0xC2—0xF4(194-244); UTF8 是兼容 ascii 的，所以 0~127 就和 ascii 完全一致  
    2. 0xC0, 0xC1,0xF5—0xFF(192, 193 和 245-255)不会出现在UTF8编码中   
    3. 0x80—0xBF(128-191)只会出现在第二个及随后的编码中(针对多字节编码，如汉字)   
    ]]  
    for utfChar in string.gmatch(s, "[%z\1-\127\194-\244][\128-\191]*") do  
        table.insert(tb, utfChar)  
    end  
      
    return tb  
end  
-- ifelse ,a? b :c
function ifelse(a,b,c)
    if a then return b else return c end
end

function AvalonUtil.GetUTFLenWithCount(s, count)  
    local sTable = StringToTable(s)  
  
    local len = 0  
    local charLen = 0  
    local isLimited = (count >= 0)  
  
    for i=1,#sTable do  
        local utfCharLen = string.len(sTable[i])  
        if utfCharLen > 1 then -- 长度大于1的就认为是中文  
            charLen = 2  
        else  
            charLen = 1  
        end  
  
        len = len + utfCharLen  
  
        if isLimited then  
            count = count - utfCharLen  
            if count <= 0 then  
                break  
            end  
        end  
    end  
  
    return len  
end 
-- 获取DeviceID
function AvalonUtil.getDeviceID()
    if (device.platform == "ios") then
        return AvalonUtil.getIDFA()
    elseif(device.platform == "android") then
        return AvalonUtil.getIMEI()
    else
        return "1234567898012345"
    end
end
-- 获取openUUID
function AvalonUtil.getOpenUUID()
    return avalon.Util.getOpenUUID()
end
-- getIDFA
function AvalonUtil.getIDFA()
    return avalon.Util.getIDFA()
end
-- getIDFV
function AvalonUtil.getIDFV()
    if avalon.Util.getIDFV then
        return avalon.Util.getIDFV()
    end
    return ""
end
-- getIMEI
function AvalonUtil.getIMEI()
    local imei = nil
    local SdkBox = require("utils.sdkbox.SdkBox")
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    if (versionTarget ~=  PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL) then
        imei = avalon.Util.getIMEI()
    end
    if imei == nil 
    or imei == "nil" 
    or imei == "null" 
    or imei == "Null" 
    or imei == "NULL" 
    or imei == "" 
    then
        imei = "avalon_unknown"
    end
    imei = string.trim(imei)
    return imei
end
-- getOAID
function AvalonUtil.getOAID()
    local SdkBox = require("utils.sdkbox.SdkBox")
    return SdkBox:getInstance():getOAID()
end

-- getADID
function AvalonUtil.getADID()
    return avalon.Util.getADID()
end
-- getMAC
function AvalonUtil.getMAC()
    return avalon.Util.getMAC()
end
-- getLocation
function AvalonUtil.getLocation()
    return avalon.Util.getLocation()
end
-- getSystemVersion
function AvalonUtil.getSystemVersion()
    return avalon.Util.getSystemVersion()
end
-- getDeviceName
function AvalonUtil.getDeviceName()
    return avalon.Util.getDeviceName()
end

-- 获取GL支持最大纹理
function AvalonUtil.getGlMaxTextureSize()
    if(avalon.Util and avalon.Util.getGlMaxTextureSize) then 
        local maxTextureSize = avalon.Util:getGlMaxTextureSize()
        return tonumber(maxTextureSize)
    end

    return 0
end

function AvalonUtil.getNetworkMode()
    if(device.platform == "windows") then 
        return PublicDefine.NetworkMode.WIFI
    end
    local netMode = avalon.NetManager.kCCNetworkStatusNotReachable
    local mode = Net.Helper:getInternetConnectionStatus();
    if mode == avalon.NetManager.kCCNetworkStatusReachableViaWiFi then
        netMode = PublicDefine.NetworkMode.WIFI
    elseif mode == avalon.NetManager.kCCNetworkStatusReachableViaWWAN then
        netMode = PublicDefine.NetworkMode.WWAN
    end
    return netMode
end

function AvalonUtil.TryCatch(func, errFunc, finally)
    local rs
    xpcall(
        function()
            rs = func()
        end,
        function(e)
            if (errFunc) then
                errFunc(e .. "\n" .. debug.traceback())
            end
        end
    )

    if (finally) then
        finally()
    end

    return rs
end



-- 生成md5
function AvalonUtil:MD5(input,isRawOutput)
    input = tostring(input)
    if type(isRawOutput) ~= "boolean" then isRawOutput = false end
    return avalon.Util.MD5(input,isRawOutput)
end
-- 生成文件md5
function AvalonUtil:MD5File(path)
    if not path then
        printError("crypto.md5file() - invalid filename")
        return nil
    end
    path = tostring(path)
    if DEBUG > 1 then
        printInfo("crypto.md5file() - filename: %s", path)
    end
    return avalon.Util.MD5File(path)
end
-- xxtea加密
function AvalonUtil:encryptXXTEA(plaintext, key)
    plaintext = tostring(plaintext)
    key = tostring(key)
    return avalon.Util.encryptXXTEA(plaintext, string.len(plaintext), key, string.len(key))
end

-- xxtea解密
function AvalonUtil:decryptXXTEA(ciphertext, key)
    ciphertext = tostring(ciphertext)
    key = tostring(key)
    return avalon.Util.decryptXXTEA(ciphertext, string.len(ciphertext), key, string.len(key))
end

function AvalonUtil:checkSupportAES()
    if(avalon.Util and avalon.Util.encryptAES and avalon.Util.decryptAES) then
        return true
    end

    return false
end

-- aes加密
function AvalonUtil:encryptAES(plaintext, key)
    if(self:checkSupportAES()) then
        plaintext = tostring(plaintext)
        key = tostring(key)
        if(avalon.Util and avalon.Util.encryptAES) then
            return avalon.Util.encryptAES(plaintext, key)
        end
    end

    return plaintext
end

-- aes解密
function AvalonUtil:decryptAES(ciphertext, key)
    if(self:checkSupportAES()) then
        ciphertext = tostring(ciphertext)
        key = tostring(key)
        if(avalon.Util and avalon.Util.decryptAES) then
            return avalon.Util.decryptAES(ciphertext, key)
        end
    end

    return ciphertext
end

function AvalonUtil:getPublicAesKey()
    require "app.utils.ServerConfigUtil"
    if(ServerConfigUtil:getServerIsTest()) then 
        return PUBLIC_GLOBAL_AES_KEY
    end

    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then 
        return PUBLIC_GLOBAL_AES_KEY
    elseif CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then 
        return PUBLIC_AES_KEY
    else
       return PUBLIC_GLOBAL_AES_KEY 
    end
end

-- 生成uuid
local UUID_COUNT = 0
function AvalonUtil:generateUUID()
    local start = os.time({
        year = 2017, 
        month = 1, 
        day = 20, 
        hour = 0,
        min = 0,
        sec = 0
    }) 
    local now = os.time()
    local time = now - start

    UUID_COUNT = UUID_COUNT + 1
    
    return string.format("%X-%X", time, UUID_COUNT)
end

-- 解析骨骼数据文件
function AvalonUtil:getSkeletonData(skeletonFileName)
    -- print(" AvalonUtil:getSkeletonData=",skeletonFileName)
    local fileContent = Avalon.FileManager:readResDataFile(skeletonFileName)
    if(fileContent and fileContent ~= "") then 
        local skeletonData = avalon.Util.decodeJSON(fileContent) 
        if (skeletonData) then
            return skeletonData
        end

    end

    return nil
end

-- 获取spine动画时间
function AvalonUtil:getAnimationDuration(skeletonDataFile, animationName)
    assert(type(skeletonDataFile) == "string", "AvalonUtil getAnimationTime: skeleton data file is invaild.")
    assert(type(animationName) == "string", "AvalonUtil getAnimationTime: animation name is invaild.")

    local duration = 0

    -- 获取骨骼数据
    local skeletonData = AvalonUtil:getSkeletonData(skeletonDataFile)
    if (skeletonData and skeletonData.animations) then
        -- 获取动画数据
        local skeletonAnimationData = skeletonData.animations[animationName]
        -- 提取动画数据中的时间
        if (skeletonAnimationData) then
            local slotAnimationList = skeletonAnimationData.slots
            if (slotAnimationList) then
                for slotIndex, slotAnimation in pairs(slotAnimationList) do
                    local slotAnimation = slotAnimationList[slotIndex]
                    if (slotAnimation) then
                        local attachmentAnimationList = slotAnimation.attachment
                        if (attachmentAnimationList) then
                            for i = 1, #attachmentAnimationList do
                                local attachmentAnimation = attachmentAnimationList[i]
                                if (attachmentAnimation.time > duration) then
                                    duration = attachmentAnimation.time
                                end
                            end
                        end

                        local colorAnimationList = slotAnimation.color
                        if (colorAnimationList) then
                            for i = 1, #colorAnimationList do
                                local colorAnimation = colorAnimationList[i]
                                if (colorAnimation.time > duration) then
                                    duration = colorAnimation.time
                                end
                            end
                        end
                    end
                end
            end
        else
            print(string.format("[WARNING][AvalonUtil getAnimationDuration] could not get skeleton animation data by name %s.", animationName))
        end
    else
        print(string.format("[WARNING][AvalonUtil getAnimationDuration] could not get skeleton data by file %s.", skeletonDataFile))
    end

    return duration
end

-- 获取动画事件的时刻
function AvalonUtil:getAnimationEventTime(skeletonDataFile, animationName, animationEvent)
    assert(type(skeletonDataFile) == "string", "AvalonUtil getAnimationTime: skeleton data file is invaild.")
    assert(type(animationName) == "string", "AvalonUtil getAnimationTime: animation name is invaild.")
    assert(type(animationEvent) == "string", "AvalonUtil getAnimationTime: animation event name is invaild.")

     -- 获取骨骼数据
    local skeletonData = AvalonUtil:getSkeletonData(skeletonDataFile)
    if (skeletonData and skeletonData.animations) then
        -- 获取动画数据
        local skeletonAnimationData = skeletonData.animations[animationName]
        if (skeletonAnimationData) then
            local skeletonAnimationEventList = skeletonAnimationData.events
            for i = 1, #skeletonAnimationEventList do
                local skeletonAnimationEvent = skeletonAnimationEventList[i]
                if (skeletonAnimationEvent.name == animationEvent) then
                    return skeletonAnimationEvent.time
                end
            end
        else
            print(string.format("[WARNING][AvalonUtil getAnimationDuration] could not get skeleton animation data by name %s.", animationName))
        end
    else
        print(string.format("[WARNING][AvalonUtil getAnimationDuration] could not get skeleton data by file %s.", skeletonDataFile))
    end
    return 0
end

--localTIme = utctime + 时区差
function AvalonUtil:UTC2LocalTime(utcTime, isStamp)
    -- body
    if isStamp then
        return os.date("%Y-%m-%d %H:%M:%S", utcTime)
    else
        return os.time(utcTime)
    end
end

function AvalonUtil:getSubNameStr(str, subWidth, fontSize, decorate)
    -- print("--------ChatMainLayer:getSubNameStr")
    if(str == nil) then 
        str = ""
    end
    local subStr = ""
    local width = 0
    local lenInByte =string.len(str)
    local i = 1
    while true do
        if i <= lenInByte then
            local byteCount = self:getCharByteCount(str, i)
            if byteCount == 1 then
                width = width + fontSize * 0.5
            else
                width = width + fontSize
            end
            if width > subWidth then
                if decorate then
                    return subStr.."..."
                end
                return subStr
            end

            local char = string.sub(str, i, i+byteCount-1)
            i = i + byteCount
            subStr = subStr..char
        else
            break
        end
    end
    return subStr
end


--检查文字长度 是否超上限
function AvalonUtil:isUpLimiteStr(str, limiteWidth, fontSize)
    local size = cc.Label:CalculateStringSize(str, UI.FONT_ARIAL, fontSize)
    if size.width >= limiteWidth then
        return true
    end
    return false
end

--传入原始文本 和 长度， 返回截取文本的列表(非精确截断，当为英文模式时，需满足空格才能截断)
function AvalonUtil:splitByLength(str, length)
    local list = {}
    if(str == nil) then
        return list
    end
    local lenInByte = string.len(str)
    if lenInByte <= length then
        table.insert(list, str)
        return list
    end
    local isWordMode = self:isWordMode(str)
    -- dump(isWordMode, "----isWordMode-----")
    local cutStr, remainStr = self:_splitByLength(str, length, isWordMode)
    while true do
        table.insert(list, cutStr)
        local lenInByte = 0
        if remainStr ~= nil then
            lenInByte = string.len(remainStr)
        end
        if lenInByte <= length then
            table.insert(list, remainStr)
            break
        else
            cutStr, remainStr = self:_splitByLength(remainStr, length, isWordMode)
        end
    end
    -- dump(list, " AvalonUtil:splitByLength")
    return list
end

--传入原始文本 和 长度， 返回截取文本 和 剩余文本
function AvalonUtil:_splitByLength(str, length, isWordMode)
    local width = 0
    local lenInByte = string.len(str)
    local i = 1
    while true do
        if i <= lenInByte then
            local byteCount, curByte = self:getCharByteCount(str, i)
            i = i + byteCount
            if isWordMode then
                if i >= length and (curByte == 0 or curByte == 32) then
                    return string.sub(str, 0, i - byteCount - 1), string.sub(str, i - byteCount, lenInByte)
                end
            else
                if i >= length then
                    return string.sub(str, 0, i - byteCount - 1), string.sub(str, i - byteCount, lenInByte)
                end
            end
        else
            break
        end
    end
    return str
end

--是否是一个英文句子   assic码全部掉在 0～127 内 且有空格
function AvalonUtil:isWordMode(str)
    -- print("------AvalonUtil:isWordMode(str)---------")
    local lenInByte = string.len(str)
    local i = 1
    local isHavaSpace = false
    while true do
        if i <= lenInByte then
            local byteCount, curByte = self:getCharByteCount(str, i)
            local char = string.sub(str, i, i+byteCount-1)
            i = i + byteCount
            if curByte > 127 then
                return false
            elseif curByte == 0 or curByte == 32 then
                isHavaSpace = true
            end
        else
            break
        end
    end
    if isHavaSpace then
        return true
    end
    return false
end

--检查文字长度 是否超上限
function AvalonUtil:getSubNameStrByLabel(str, limiteWidth, fontSize, decorate)
    if(str == nil) then
        str = ""
        return str
    end
    local width = 0
    local lenInByte =string.len(str)
    local i = 1
    local subStr = ""
    while true do
        if i <= lenInByte then
            local byteCount = self:getCharByteCount(str, i)
            local char = string.sub(str, i, i+byteCount-1)
            i = i + byteCount
            subStr = subStr..char
            local size = cc.Label:CalculateStringSize(subStr, UI.FONT_ARIAL, fontSize)
            if size.height > fontSize * 2 then
                if size.width * math.floor(size.height / fontSize)  >= limiteWidth then
                    if decorate then
                        return string.sub(str, 0, i - byteCount - 1).."..."
                    end
                    return string.sub(str, 0, i - byteCount - 1)
                end
            else
                if size.width >= limiteWidth then
                    if decorate then
                        return string.sub(str, 0, i - byteCount - 1).."..."
                    end
                    return string.sub(str, 0, i - byteCount - 1)
                end
            end
        else
            break
        end
    end
    return subStr
end


function AvalonUtil:getCharByteCount(str, i)
    local byteCount = 1 
    local curByte = string.byte(str, i)
    if curByte>0 and curByte<=127 then
        byteCount = 1
    elseif curByte>=192 and curByte<=223 then
        byteCount = 2
    elseif curByte>=224 and curByte<=239 then
        byteCount = 3
    elseif curByte>=240 and curByte<=255 then
        byteCount = 4
    end
    -- print("   str = "..curByte.."  curByte =  "..curByte.."   and  byteCount = "..byteCount)
    return byteCount, curByte
end

function AvalonUtil:sortParamByFirstChar(tableData)
    local paramTable = {}
    for k, v in pairs(tableData) do
        local data = {}
        data.key = k

        local lowerKey = string.lower(k)
        local lenInByte =string.len(lowerKey)
        local asciiTable = {}
        local i = 1
        while true do
            if i <= lenInByte then
                local byteCount = self:getCharByteCount(lowerKey, i)
                local asciiNumber = string.byte(lowerKey, i)
                table.insert(asciiTable, asciiNumber) 
                i = i + byteCount
            else
                break
            end
        end
        data.asciiTable = asciiTable
        data.value = v
        table.insert(paramTable, data)
    end
    table.sort(paramTable, function(a, b)
        local alen = table.nums(a.asciiTable)
        local blen = table.nums(b.asciiTable)
        local sizeNum = alen < blen and blen or alen
        --print(a.key, b.key)
        for i = 1, sizeNum do
            local aNumber = a.asciiTable[i] or 0
            local bNumber = b.asciiTable[i] or 0
            -- print(aNumber, bNumber)
            if aNumber < bNumber then
                return true
            elseif aNumber > bNumber then
                return false
            end   
        end
        -- return true
    end)
    for k, v in ipairs(paramTable) do
        v.asciiTable = nil
    end
    return paramTable
end



--用逗号分隔 数字number 每三位一个逗号
--number : 需要处理的数字 
function AvalonUtil:getCommaNumber(number)
    if type(number) == "string" then
        number= tonumber(number)
    end
    if number < KILO then
        return number
    end
    -- if number ~= math.floor(number) then
    --     return number
    -- end

    local oldHighNumber = number
    local highNumber = math.floor(number / KILO)
    local showNumber = string.format(",%03d", oldHighNumber - highNumber * KILO)

    while highNumber >= KILO do
        oldHighNumber = highNumber
        highNumber = math.floor(highNumber / KILO)
        showNumber = string.format(",%03d%s", oldHighNumber - highNumber * KILO, showNumber)
    end
    showNumber = string.format("%d%s", highNumber, showNumber)
    return showNumber
end

--number : 需要处理的数字 size：总的位数，
function AvalonUtil:getSimpleNumber(number, size, smallPointSize)
    local highNumber = 0
    local lowNumber = 0
    local dimension = ONE
    local smallPointSize = size --最大的小数点位数
    if number >= BILLION then
        highNumber = math.floor(number / BILLION)
        dimension = BILLION
        smallPointSize = 2
    elseif number >= MILLION then
        highNumber = math.floor(number / MILLION)
        dimension = MILLION
        smallPointSize = 2
    elseif number >= KILO then
        highNumber = math.floor(number / KILO)
        dimension = KILO
    else
        highNumber = number
        dimension = ONE
    end
    lowNumber = number - highNumber * dimension
    local showNumber, isComma = self:getPointNumber(highNumber, lowNumber, dimension, size, smallPointSize)
    if not isComma then
        showNumber = self:getCommaNumber(showNumber)
    end
    if dimension == BILLION then
        showNumber = showNumber .. "B"
    elseif dimension == MILLION then
        showNumber = showNumber .. "M"
    elseif dimension == KILO then
        showNumber = showNumber .. "K"
    elseif dimension == ONE then
        showNumber = showNumber..""
    else
        showNumber = showNumber..""
    end
    return showNumber
end

--number : 需要处理的数字 size：总的位数，
function AvalonUtil:getSimpleKILONumber(number, size, smallPointSize)
    local highNumber = 0
    local lowNumber = 0
    local dimension = ONE
    local smallPointSize = size --最大的小数点位数
    if number >= KILO then
        highNumber = math.floor(number / KILO)
        dimension = KILO
    else
        highNumber = number
        dimension = ONE
    end
    lowNumber = number - highNumber * dimension
    local showNumber, isComma = self:getPointNumber(highNumber, lowNumber, dimension, size, smallPointSize)
    if not isComma then
        showNumber = self:getCommaNumber(showNumber)
    end
    if dimension == KILO then
        showNumber = showNumber .. "K"
    else
        showNumber = showNumber..""
    end
    return showNumber
end

--return 展示的number， 是否含有小数点
function AvalonUtil:getPointNumber(highNumber, lowNumber, dimension, size, smallPointSize)
    if lowNumber == 0 then
        return highNumber, false
    end
    local highNumberSize = self:getNumberSize(highNumber)
    local lowNumberSize = self:getNumberSize(lowNumber)

    local pointSize = smallPointSize --
    if (highNumberSize + smallPointSize) > size then
        pointSize = size - highNumberSize
    end
    if pointSize <= 0 then
        return highNumber, false
    end
    if dimension / math.pow(10, pointSize) > lowNumber then
        return highNumber, false
    end
    if lowNumberSize < pointSize then
        pointSize = lowNumberSize
    end
    local mode = "%." .. string.format("%df", pointSize)
    local showNumber = string.format(mode, highNumber + lowNumber / dimension)
    return showNumber, true
end

-- CN包使用"万", GLOBAL包使用K、M  smallPointSize:为最小需要达到某个值才开始转换
function AvalonUtil:getTargetFormatedNum(number, smallPointSize)
    smallPointSize = smallPointSize or 0
    if(tonumber(number) < smallPointSize)  then 
        return number
    end

    if AvalonUtil.getCaveOnlineTarget() == CAVEOL_TARGET_GLOBAL then
        return tostring(AvalonUtil:getSimpleNumber(number, 3, 1))
    end

    local numSize = AvalonUtil:getNumberSize(number)
    if numSize < 5 then
        return tostring(number)
    end

    local numShow = number/10000
    return numShow .. "万"
end

--获取一个数字整数部分的长度
function AvalonUtil:getNumberSize(number)
    local size = 0 
    if number >= 1 then
        size = 1
    end
    while true do
        number = math.floor(number / 10)
        if number < 1 then
            break
        end
        size = size + 1
    end
    return size
end

--[[
    获取倒计时的时间，天-时-分-秒
    time:相对于服务器的截止时间
    时间精确级别，具体查看定义：Game.TIME_LEVEL
]]
function AvalonUtil:getNewFullFormatTime(time, showLevel)
    local curTime = GameManager:getNowServerTime()
    local waitingTime = time + GameManager:getEPOCHTime() - curTime
    if waitingTime <= 0 then
        return 0
    end
    local str = ""
    local day = nil
    local hour = nil 
    local minute = nil
    local second = nil
    if(showLevel <= Game.TIME_LEVEL.TIME_LEVEL_DAY) then 
        day = math.modf(waitingTime / SECONDS_ONE_DAY)
        waitingTime = waitingTime % SECONDS_ONE_DAY
        if(showLevel == Game.TIME_LEVEL.TIME_LEVEL_DAY) then 
            if(waitingTime > 0) then 
                day = day + 1
            end
        end
    end

    if(showLevel <= Game.TIME_LEVEL.TIME_LEVEL_HOUR) then 
        hour = math.modf(waitingTime / SECONDS_ONE_HOUR)
        waitingTime = waitingTime % SECONDS_ONE_HOUR
        if(showLevel == Game.TIME_LEVEL.TIME_LEVEL_HOUR) then 
            if(waitingTime > 0) then 
                hour = hour + 1
            end
        end
    end

    if(showLevel <= Game.TIME_LEVEL.TIME_LEVEL_MINUTE) then 
        minute = math.modf(waitingTime/SECONDS_ONE_MINUTES)
        waitingTime = waitingTime % SECONDS_ONE_MINUTES
        if(showLevel == Game.TIME_LEVEL.TIME_LEVEL_MINUTE) then 
            if(waitingTime > 0) then 
                minute = minute + 1
            end
        end
    end
    if(showLevel <= Game.TIME_LEVEL.TIME_LEVEL_SECONDS) then 
        second = waitingTime
    end

    if(minute and minute >=60) then 
        hour = hour + 1
        minute = minute - 60
    end

    if(hour and hour >=24) then 
        day = day + 1
        hour = hour - 24
    end

    if(day ~= nil and day ~= 0) then 
        str = str.. day .. UI.TEXT_1170921
    end
    if(hour ~= nil and hour ~= 0) then 
        str = str.. hour .. UI.TEXT_111033
    end
    if(minute ~= nil and minute ~= 0) then 
        str = str.. minute .. UI.TEXT_111034
    end
    if(second ~= nil and second ~= 0) then 
        local LanguageManager = require("app.game.LanguageManager")
        str = str.. second .. LanguageManager:getInstance():getLocalString(1111475)
    end

    return str
end

--天-时-分-秒 
--time：精确到秒的  服务器时间搓
--isSimple true: 用冒号分割
--isShowSeconds true : 显示秒数
function AvalonUtil:getFullFormatTime(time, isSimple, isShowSeconds)
    if isShowSeconds == nil then
        isShowSeconds = true
    end
    local curTime = GameManager:getNowServerTime()
    local waitingTime = time + GameManager:getEPOCHTime() - curTime
    if waitingTime <= 0 then
        return 0
    end
    
    return self:_getFullFormatTime(waitingTime, isSimple, isShowSeconds)
end

--天-时-分-秒 
--time：精确到秒的  本地时间搓
--isSimple true: 用冒号分割
--isShowSeconds true : 显示秒数
function AvalonUtil:_getFullFormatTime(waitingTime, isSimple, isShowSeconds,isShowDay)
    if isShowSeconds == nil then
        isShowSeconds = true
    end
    if isShowDay == nil then
        isShowDay = true
    end
    local mode1 = UI.TEXT_1170705
    local mode2 = UI.TEXT_1170706
    local mode3 = UI.TEXT_1170707
    local mode4 = UI.TEXT_1170708
    if isSimple then
        mode1 = "%d:%02d:%02d:%02d"
        mode2 = "%02d:%02d:%02d"
        mode3 = "%02d:%02d"
        mode4 = "%02d"
    end 

    local str = ""
    if isShowSeconds then
        if(waitingTime > 0) then
            local day = math.modf(waitingTime / SECONDS_ONE_DAY)
            waitingTime = waitingTime % SECONDS_ONE_DAY
            local hour = math.modf(waitingTime / SECONDS_ONE_HOUR)
            waitingTime = waitingTime % SECONDS_ONE_HOUR
            local minute = math.modf(waitingTime/SECONDS_ONE_MINUTES)
            waitingTime = waitingTime % SECONDS_ONE_MINUTES
            local second = waitingTime
            if not isShowDay then
                hour = hour + day * 24
                day = 0
            end 
            if day ~= 0 then
                str = string.format(mode1, day, hour, minute, second)
            else
                if hour ~= 0 then
                    str = string.format(mode2, hour, minute, second)
                else
                    if minute ~= 0 then
                        str = string.format(mode3, minute, second)
                    else
                        str = string.format(mode4, second)
                    end
                end
            end
        end
    else
        local remianTime = waitingTime % SECONDS_ONE_MINUTES
        if remianTime > 0 then
            waitingTime = waitingTime + SECONDS_ONE_MINUTES - remianTime
        end
        if(waitingTime > 0) then
            local day = math.modf(waitingTime / SECONDS_ONE_DAY)
            waitingTime = waitingTime % SECONDS_ONE_DAY
            local hour = math.modf(waitingTime / SECONDS_ONE_HOUR)
            waitingTime = waitingTime % SECONDS_ONE_HOUR
            local minute = math.modf(waitingTime/SECONDS_ONE_MINUTES)
            if day ~= 0 then
                str = string.format(mode2, day, hour, minute)
            else
                if hour ~= 0 then
                    str = string.format(mode3, hour, minute)
                else
                    if minute ~= 0 then
                        str = string.format(mode3, 0, minute)
                    end
                end
            end
        end
    end

    return str
end


--富文本 相关
--把颜色rgb格式变换成字符串 #00ff00
function AvalonUtil:colorRGB2Str(rgbTable)
    if rgbTable == nil or rgbTable == "" then
        return "#ffffff"
    end
    return string.format("#%.2x%.2x%.2x", rgbTable.r, rgbTable.g, rgbTable.b)
end
--序列化普通文本
function AvalonUtil:serializeText(text, fontColor, fontSize, fontName)
    if fontSize == "" or fontSize == nil then
        fontSize  = DEFALAULT_FONT_SIZE
    end
    if fontColor == "" or fontColor == nil then
        fontColor = DEFALAULT_FONT_COLOR
    end
    if fontName == "" or fontName == nil then
        fontName = UI.SYS_FONT_CHAT
    end
    if type(fontColor) == "table" then
        fontColor = AvalonUtil:colorRGB2Str(fontColor)
    end
    -- local model = "<font size='%d' color='%s' face='%s'>%s</font>"
    -- local str = string.format(model, fontSize, fontColor, fontName, text)
    text = Base64Encode(text)
    local model = "<font size='%d' color='%s' face='%s' isEncode='1'>%s</font>"
    local str = string.format(model, fontSize, fontColor, fontName, text)
    return str
end

--序列化  游戏内部超连接数据
function AvalonUtil:serializeInnerHref(name, href, fontColor, fontSize, fontName)
    -- fontColor = UI.FONT_COLOR_255_211_155 --固定颜色
    if fontSize == "" or fontSize == nil then
        fontSize  = DEFALAULT_FONT_SIZE
    end
    if fontColor == "" or fontColor == nil then
        fontColor = DEFALAULT_FONT_COLOR
    end
    if fontName == "" or fontName == nil then
        fontName = UI.SYS_FONT_CHAT
    end
    if type(fontColor) == "table" then
        fontColor = AvalonUtil:colorRGB2Str(fontColor)
    end
    local data = {}
    data.dataType = PublicDefine.TagClickType.InnerHref
    data.href = href
    local jsonStr = json.encode(data)
    -- local model = "<click size='%d' color='%s' face='%s' data='%s'>%s</click>"
    -- local str = string.format(model, fontSize, fontColor, fontName, Base64Encode(jsonStr), name)
    local model = "<click size='%d' color='%s' face='%s' data='%s'>%s</click>"
    local str = string.format(model, fontSize, fontColor, fontName, Base64Encode(jsonStr), name)
    return str
end

--序列化公会名字名字 并生成 超连接数据 （removeLink：在快捷聊天频道的超链接也只按普通文本显示）
function AvalonUtil:serializeGuildName(name, protodata, fontColor, fontSize, fontName, removeLink)
    if fontSize == "" or fontSize == nil then
        fontSize  = DEFALAULT_FONT_SIZE
    end
    if fontColor == "" or fontColor == nil then
        fontColor = DEFALAULT_FONT_COLOR
    end
    if fontName == "" or fontName == nil then
        fontName = UI.SYS_FONT_CHAT
    end
    if type(fontColor) == "table" then
        fontColor = AvalonUtil:colorRGB2Str(fontColor)
    end
    local data = {}
    data.data = protodata
    data.dataType = PublicDefine.TagClickType.GuildName
    local jsonStr = json.encode(data)
    name = string.gsub(name, "<", "(")
    name = string.gsub(name, ">", ")")

    local str = ""
    if removeLink then
        local model = "<font size='%d' color='%s' face='%s'>[%s]</font>"
        str = string.format(model, fontSize, fontColor, fontName, name)
    else
        local model = "<click size='%d' color='%s' face='%s' data='%s'>[%s]</click>"
        str = string.format(model, fontSize, fontColor, fontName, Base64Encode(jsonStr), name)
    end
    return str
end


--序列化玩家 名字 并生成 超连接数据（removeLink：在快捷聊天频道的超链接也只按普通文本显示）
function AvalonUtil:serializeNickName(name, data, fontColor, fontSize, fontName, removeLink)
    if fontSize == "" or fontSize == nil then
        fontSize  = DEFALAULT_FONT_SIZE
    end
    if fontColor == "" or fontColor == nil then
        fontColor = DEFALAULT_FONT_COLOR
    end
    if fontName == "" or fontName == nil then
        fontName = UI.SYS_FONT_CHAT
    end
    if type(fontColor) == "table" then
        fontColor = AvalonUtil:colorRGB2Str(fontColor)
    end
    data.dataType = PublicDefine.TagClickType.NickName
    local jsonStr = json.encode(data)
	name = string.gsub(name, "<", "(")
    name = string.gsub(name, ">", ")")
    name = ToolsUtil:replaceShowNickNameStr(name)
    local str = ""
    if removeLink then
        local model = "<font size='%d' color='%s' face='%s'>[%s]</font>"
        str = string.format(model, fontSize, fontColor, fontName, name)
    else
        local model = "<click size='%d' color='%s' face='%s' data='%s'>[%s]</click>"
        str = string.format(model, fontSize, fontColor, fontName, Base64Encode(jsonStr), name)
    end
    return str
end

--序列化 道具名字 并生成 超连接数据（removeLink：在快捷聊天频道的超链接也只按普通文本显示）
function AvalonUtil:serializeItemName(name, itemData, fontColor, fontSize, fontName, removeLink)
    if fontSize == "" or fontSize == nil then
        fontSize  = DEFALAULT_FONT_SIZE
    end
    if fontColor == "" or fontColor == nil then
        fontColor = DEFALAULT_FONT_COLOR
    end
    if fontName == "" or fontName == nil then
        fontName = UI.SYS_FONT_CHAT
    end
    if type(fontColor) == "table" then
        fontColor = AvalonUtil:colorRGB2Str(fontColor)
    end
    local data = {}
    local data = ProtobufUtil:decode("GoodsSystem.GoodsData", itemData)
    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(data.templateID)

    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        data.goodsMesData = ProtobufUtil:decode("GoodsSystem.EquipmentData", data.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        data.goodsMesData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData", data.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
        data.goodsMesData = ProtobufUtil:decode("GoodsSystem.StarPrayData", data.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        data.goodsMesData = ProtobufUtil:decode("GoodsSystem.RelicData", data.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
        data.goodsMesData = ProtobufUtil:decode("GoodsSystem.PetGemStoneData", data.goodsDataBytes)
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        data.goodsMesData = ProtobufUtil:decode("GoodsSystem.EquipmentGlyphData", data.goodsDataBytes)
    end
    -- dump(data.goodsMesData , "data.goodsMesData ")
    data.goodsDataBytes = nil
    data.dataType = PublicDefine.TagClickType.ItemName
    local jsonStr = json.encode(data)

    local str = ""
    if removeLink then
        local model = "<font size='%d' color='%s' face='%s'>[%s]</font>"
        str = string.format(model, fontSize, fontColor, fontName, name)
    else
        local model = "<click size='%d' color='%s' face='%s' data='%s'>[%s]</click>"
        str = string.format(model, fontSize, fontColor, fontName, Base64Encode(jsonStr), name)
    end
    return str
end


--序列化 宠物名字 并生成 超连接数据（removeLink：在快捷聊天频道的超链接也只按普通文本显示）
function AvalonUtil:serializePetName(name, petData, fontColor, fontSize, fontName, removeLink)
    if fontSize == "" or fontSize == nil then
        fontSize  = DEFALAULT_FONT_SIZE
    end
    if fontColor == "" or fontColor == nil then
        fontColor = DEFALAULT_FONT_COLOR
    end
    if fontName == "" or fontName == nil then
        fontName = UI.SYS_FONT_CHAT
    end
    if type(fontColor) == "table" then
        fontColor = AvalonUtil:colorRGB2Str(fontColor)
    end
    name = ToolsUtil:replaceShowNickNameStr(name)
    local data = {}
    data.petMesData = petData
    data.dataType = PublicDefine.TagClickType.PetName
    local jsonStr = json.encode(data)
    local str = ""
    if removeLink then
        local model = "<font size='%d' color='%s' face='%s'>[%s]</font>"
        str = string.format(model, fontSize, fontColor, fontName, name)
    else
        local model = "<click size='%d' color='%s' face='%s' data='%s'>[%s]</click>"
        str = string.format(model, fontSize, fontColor, fontName, Base64Encode(jsonStr), name)
    end
    return str
end


--序列化logo 图片 和图片上的文本
function AvalonUtil:serializeImage(iconName, text, fontColor, fontSize, fontName)
    if fontSize == "" or fontSize == nil then
        fontSize  = DEFALAULT_FONT_SIZE
    end
    if fontColor == "" or fontColor == nil then
        fontColor = DEFALAULT_FONT_COLOR
    end
    if fontName == "" or fontName == nil then
        fontName = UI.SYS_FONT_CHAT
    end
    if type(fontColor) == "table" then
        fontColor = AvalonUtil:colorRGB2Str(fontColor)
    end
    text      = text or ""
    local mode = "<img src='%s' text='%s' size='%d' color='%s' face='%s'></img>"
    local str = string.format(mode, iconName, text, fontSize, fontColor, fontName)
    return str
end

function AvalonUtil:formartRichText(defaultColor, defaultFontSize, defaultFontName, mode, ...)
    local params = {...}
    local modeList = string.split(mode, "%s")
    local content = ""
    for k, v in ipairs(modeList) do
        if v ~= "" then
            local str = self:serializeText(v, defaultColor, defaultFontSize, defaultFontName)
            content = content..str
        end
        local linkStr = params[k] or ""
        content = content..linkStr
    end
    return content
end

function AvalonUtil:formartRichTextToArray(defaultColor, defaultFontSize, defaultFontName, mode, params)
    local modeList = string.split(mode, "%s")
    local array = {}
    params = params or {}
    for k, v in ipairs(modeList) do
        if v ~= "" then
            local textTable = {}
            textTable.text = v
            textTable.color =  defaultColor
            textTable.fontSize = defaultFontSize
            table.insert(array, textTable)
        end
        local value = params[k]
        if value ~= nil then
            if type(value) == "table" and #value >= 1 then
                for k2, v2 in ipairs(value) do
                    table.insert(array, v2)
                end
            else
                table.insert(array, params[k])
            end
        end
    end
    return array
end

--封装的网络数据格式 用于生成pb chatSystem.ContentMessage
function AvalonUtil:formartRichTextToTableArray(defaultColor, defaultFontSize, defaultFontName, mode, params)
    local modeList = string.split(mode, "%s")
    local array = {}
    params = params or {}
    for k, v in ipairs(modeList) do
        if v ~= "" then
            local textTable = Game.ChatManager:textTbData(v, defaultColor, defaultFontSize, defaultFontName)
            table.insert(array, textTable)
        end
        local value = params[k]
        if value ~= nil then
            if type(value) == "table" and #value >= 1 then
                for k2, v2 in ipairs(value) do
                    table.insert(array, v2)
                end
            else
                table.insert(array, params[k])
            end
        end
    end
    return array
end

function AvalonUtil:splitChinese(str)
    local tableStr = AvalonUtil.utf8tochars(str)

    local str = ""
    for k, v in pairs(tableStr) do 
        if(str == "") then
            str = v.char
        else 
            str = str .. "\n".. v.char
        end
    end

    return str
end

--简单判断 大于4字节 默认是emoji， 可能会遗漏组合型的emoji
function AvalonUtil:isEmoji(str)
    local result = avalon.Util.isHaveEmoji(str)
    return result
end

-- 卸载字库资源
function AvalonUtil:fontPurgeCachedData(str)
    if(str and str ~= "") then
        local result = avalon.Util.fontPurgeCachedData(str)
        return result
    end
end

function AvalonUtil:isRectContainsPoint(node, location)
    local point = node:convertToWorldSpace(cc.p(0,0))
    local size = node:getContentSize()
    if node.getViewSize ~= nil then--优先使用viewsize  针对tableview 特殊处理
        size = node:getViewSize()
    end
    local rect = cc.rect(point.x, point.y, size.width, size.height)
    if cc.rectContainsPoint(rect, location) then
        return true
    end 
    return false
end

function AvalonUtil:isRectContainsRect(node, targetNode)
    local point = node:convertToWorldSpace(cc.p(0,0))
    local size = node:getContentSize()
    if node.getViewSize ~= nil then--优先使用viewsize  针对tableview 特殊处理
        size = node:getViewSize()
    end
    local rect = cc.rect(point.x, point.y, size.width, size.height)

    local targetNodepoint = targetNode:convertToWorldSpace(cc.p(0,0))
    local targetNodesize = targetNode:getContentSize()
    if targetNode.getViewSize ~= nil then--优先使用viewsize  针对tableview 特殊处理
        targetNodesize = targetNode:getViewSize()
    end
    local targetNoderect = cc.rect(targetNodepoint.x, targetNodepoint.y, targetNodesize.width, targetNodesize.height)

    if cc.rectIntersectsRect(rect, targetNoderect) then
        return true
    end 
    return false
end

function AvalonUtil:isSensitiveTouch(benginTouh, endTouh)
    if benginTouh == nil or endTouh == nil then
        return true
    end
    if math.abs(benginTouh.x - endTouh.x) > 10 or math.abs(benginTouh.y - endTouh.y) > 10 then
        return false
    end
    return true
end

function AvalonUtil:pointToAngle(pos1, pos2)
    local len_y = pos2.y - pos1.y
    local len_x = pos2.x - pos1.x
    local M_PI = math.pi
    local tan_yx = math.abs(len_y) / math.abs(len_x)
    local angle = 0
    local area = QUADRANT_AREA.AREA_1 --象限
    if (len_y > 0 and len_x < 0) then
        angle = math.atan(tan_yx) * 180 / M_PI - 90
        area = QUADRANT_AREA.AREA_2
    elseif (len_y > 0 and len_x > 0) then
        angle = 90 - math.atan(tan_yx) * 180 / M_PI
        area = QUADRANT_AREA.AREA_1
    elseif (len_y < 0 and len_x < 0) then
        angle = -1 * math.atan(tan_yx) * 180 / M_PI - 90
        area = QUADRANT_AREA.AREA_3
    elseif (len_y < 0 and len_x > 0) then
        angle = math.atan(tan_yx) * 180 / M_PI + 90
        area = QUADRANT_AREA.AREA_4
    end
    -- print(" --- angle = "..angle)
    return angle, area
end

function AvalonUtil:angleToPoint(origin, angle, R)
    local _x = math.sin(math.rad(angle)) * R
    local _y = math.cos(math.rad(angle)) * R
    -- print("  angleToPoint = ".._x .. " / ".._y)
    return {x = origin.x + _x, y = origin.y + _y}
end

--判断两个毫秒时间 是否在同一天
function AvalonUtil:isInSameDay(timeA, timeB)
    if timeA == nil or timeB == nil then
        return false
    end
    local dayA = math.floor(timeA / (SECONDS_ONE_DAY * 1000))
    local dayB = math.floor(timeB / (SECONDS_ONE_DAY * 1000))
    if dayA == dayB then
        return true
    end
    return false
end

--游戏内红点创建 统一封装
function AvalonUtil.createRedPoint(parent, offsetX, offsetY, zorder)
    local redPoint = UI.Image:create()
    redPoint:init("ui_information_newitem.png")

    zorder = zorder or 101
    offsetX = offsetX or -redPoint:getContentSize().width / 2
    offsetY = offsetY or -redPoint:getContentSize().height / 2

    redPoint:rightUp(offsetX, offsetY)
    redPoint:setName("redPoint")
    parent:addChild(redPoint, zorder)
    return redPoint
end

function AvalonUtil.createDialogMask()
    local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width, winSize.height)
    return mask;
end

function AvalonUtil.runTipsAppearShowAnimation(node, callback)
    if node == nil then
        return
    end
    node:stopAllActions()
    node:computePosition()

    local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    local posY = node:getPositionY()
    local startPos = winSize.height
    local move = nil

    node:setScale(0.01)
    node:setAnchorPoint(0.5,0.5)

    local func = cc.CallFunc:create(function()
            if callback then
                callback()
            end
        end
    )
    node:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1), func))
end

function AvalonUtil.runTipsShowAnimationAndSetAnchorPoint(node, anchorX, anchorY, callback)
    if node == nil then
        return
    end
    node:stopAllActions()
    node:computePosition()

    local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    local posY = node:getPositionY()
    local startPos = winSize.height
    local move = nil

    node:setScale(0.01)
    node:setAnchorPoint(anchorX, anchorY)

    local func = cc.CallFunc:create(function()
            if callback then
                callback()
            end
        end
    )
    node:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1), func))
end

function AvalonUtil.resumeNode(node)
    AvalonUtil.pauseNode(node, false)
end

function AvalonUtil.pauseNode(node, pause)
    local dispatcher = cc.Director:getInstance():getEventDispatcher()
    if pause == nil then
        pause = true
    end

    if pause == true then
        dispatcher:pauseEventListenersForTarget(node)
    else
        dispatcher:resumeEventListenersForTarget(node)
    end

    local children = node:getChildren()
    for k, child in pairs(children) do
        AvalonUtil.pauseNode(child, pause)
    end
end


--改变图片颜色， sprite:cc.Sprite   color:cc.vec4(1.0, 1.0, 1.0, 1.0)
function AvalonUtil.useColorShader(sprite, color)
    if sprite == nil or color == nil then
        return
    end
    -- local glProgram = cc.GLProgram:createWithFilenames("shaders/TextureLight.vert", "shaders/TextureLight.frag")
    -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    local glProgramState = AvalonUtil:getGLProgramState("shaders/TextureLight.vert", "shaders/TextureLight.frag", AvalonUtil:_makeGLProgramKeyForColor("shaders/TextureLight.vert", "shaders/TextureLight.frag", color))
    glProgramState:setUniformVec4("u_lightColor", color)
    sprite:setGLProgramState(glProgramState)
end


function AvalonUtil.useColorShaderForSpine(spine, color)
    if spine == nil or color == nil then
        return
    end
    local vertName = "shaders/TextureLight3Spine.vert"
    local fragName = "shaders/TextureLight3Spine.frag"
    if AvalonUtil.getSpineVersion() < 3060039 then
        vertName = "shaders/TextureLight2Spine.vert"
        fragName = "shaders/TextureLight2Spine.frag"
    end
    local glProgramState = AvalonUtil:getGLProgramState(vertName, fragName, AvalonUtil:_makeGLProgramKeyForColor(vertName, fragName, color))
    glProgramState:setUniformVec4("u_lightColor", color)
    spine:setGLProgramState(glProgramState)
end

-- 为一些特定按钮增加框框动画 (大秘境, 锻造, 等)
function AvalonUtil.addBracketsAnimationToButton(button, aniFileWithoutSuffix, offsetX, offsetY, isSimpleAnimation)
    if (aniFileWithoutSuffix == nil) then aniFileWithoutSuffix = "effect_ui_b_enchanting_button" end
    if (offsetX == nil) then offsetX = -7 end
    if (offsetY == nil) then offsetY = 0 end
    require "app.ui.common.Animation"

    -- 此按钮点击不做放大处理
    button:closeClickScale()

    -- 按钮上的左右装饰
    button.__mBtnBeginLeft = UI.Animation:create()
    button.__mBtnBeginLeft:init(aniFileWithoutSuffix .. ".json", aniFileWithoutSuffix .. ".atlas")
    button.__mBtnBeginLeft:setSize(18, 41)
    button.__mBtnBeginLeft:setInnerOffset(offsetX, offsetY)
    button.__mBtnBeginLeft:centerLeft(0)
    button.__mBtnBeginLeft:setAnimation("idle")
    button:addChild(button.__mBtnBeginLeft, 10000)

    button.__mBtnBeginRight = UI.Animation:create()
    button.__mBtnBeginRight:init(aniFileWithoutSuffix .. ".json", aniFileWithoutSuffix .. ".atlas")
    button.__mBtnBeginRight:setSize(18, 41)
    button.__mBtnBeginRight:setScaleX(-1)
    button.__mBtnBeginRight:setInnerOffset(offsetX, offsetY)
    button.__mBtnBeginRight:centerRight(0)
    button.__mBtnBeginRight:setAnimation("idle")
    button:addChild(button.__mBtnBeginRight, 10000)

    -- 装饰物按按钮状态动态调整
    button:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, button, function()
        if (isSimpleAnimation) then
            button.__mBtnBeginLeft:setAnimation("trigger", true)
            button.__mBtnBeginRight:setAnimation("trigger", true)
        else
            button.__mBtnBeginLeft:setAnimation("trigger_begin", false)
            button.__mBtnBeginRight:setAnimation("trigger_begin", false)
            button.__mBtnBeginLeft:addAnimation("trigger_idle", true)
            button.__mBtnBeginRight:addAnimation("trigger_idle", true)
        end
    end)
    button:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, button, function()
        if (isSimpleAnimation) then
            button.__mBtnBeginLeft:setAnimation("idle", true)
            button.__mBtnBeginRight:setAnimation("idle", true)
        else
            button.__mBtnBeginLeft:setAnimation("trigger_end", false)
            button.__mBtnBeginRight:setAnimation("trigger_end", false)
            button.__mBtnBeginLeft:setAnimation("idle", true)
            button.__mBtnBeginRight:setAnimation("idle", true)
        end
    end)
    button:addEventListener(UI.Event.BUTTON_ENABLE, button, function()
        button.__mBtnBeginLeft:setAnimation("idle", true)
        button.__mBtnBeginLeft:setTimeScale(1)
        button.__mBtnBeginRight:setAnimation("idle", true)
        button.__mBtnBeginRight:setTimeScale(1)
        button.__mBtnBeginLeft:setVisible(true)
        button.__mBtnBeginRight:setVisible(true)
    end)
    button:addEventListener(UI.Event.BUTTON_DISABLE, button, function()
        button.__mBtnBeginLeft:setAnimation("idle", true)
        button.__mBtnBeginLeft:setTimeScale(0)
        button.__mBtnBeginRight:setAnimation("idle", true)
        button.__mBtnBeginRight:setTimeScale(0)
        button.__mBtnBeginLeft:setVisible(false)
        button.__mBtnBeginRight:setVisible(false)
    end)

    -- button.oldEnable = button.enable;
    -- button.enable = function(self)
    --     self.oldEnable();
    --     self.__mBtnBeginRight:setVisible(true)
    --     self.__mBtnBeginLeft:setVisible(true)
    -- end

    -- button.oldDisable = button.disable;
    -- button.disable = function(self)
    --     self.oldDisable();
    --     self.__mBtnBeginRight:setVisible(false)
    --     self.__mBtnBeginLeft:setVisible(false)
    -- end
end

function AvalonUtil.createClockAnimation(clockIcon)
    if clockIcon == nil then
        clockIcon = UI.Image:create()
        clockIcon:init("ui_information_clock_bg.png")
    end
    
    local clockPoint = cc.Sprite:create()
    clockPoint:initWithSpriteFrameName("ui_information_clock_point.png")
    clockPoint:setAnchorPoint(0.3, 0.3)
    clockPoint:setPosition(clockIcon:getContentSize().width / 2, clockIcon:getContentSize().height / 2 + 1)
    clockIcon:addChild(clockPoint)

    local ralateAction = cc.RotateBy:create(60, 360)
    local endAction = cc.RepeatForever:create(ralateAction)
    clockPoint:runAction(endAction)
    return clockIcon
end

function AvalonUtil.updateIconStringLayout(node, blank)
    local blank = blank or 10;
    local list = node:getChildren();
    local size = 0
    for k, v in pairs(list) do
        size = size + v:getContentSize().width
    end
    size = size + blank
    node:setSize(size, node:getContentSize().height);
end

function AvalonUtil.createSplitLine(width, iconName, isTitleLine)
    width = width or 160
    iconName = iconName or "ui_scale9image_banner_line_dark.png"
    local rect = CCRectMake(20, 1, 1, 1)
    local splitLine1 = UI.Image9:create()
    splitLine1:init(iconName, rect)
    splitLine1:setReflectSize(width, 1)
    return splitLine1
end

--创建分享公用node 界面必须有 ui_general_uishare.plist 资源
function AvalonUtil.getPublicShareBg(shareDatas, shareChannel)
    local SdkBox = require("utils.sdkbox.SdkBox")
    local LanguageManager = require("app.game.LanguageManager")

    local bg = UI.Image:create()
    bg:init("ui_share_banner.png")
    bg:center()

    local bgBgBlackLayer = UI.Image9:create()
    bgBgBlackLayer:init("ui_scale9image_black.png", CCRectMake(0,0,1,1), cc.size(bg:getContentSize().width, bg:getContentSize().height))
    bgBgBlackLayer:leftBottom(0, 0)
    bgBgBlackLayer:setOpacity(160)
    bg:addChild(bgBgBlackLayer)

    -- 添加背景
    local paper = UI.Image:create()
    paper:init("ui_share_banner2.png")
    paper:leftBottom(150, 27)
    bg:addChild(paper)

    local _ShareNode = UI.Layout:create()
    _ShareNode:init()
    _ShareNode:setSize(bg:getContentSize().width, bg:getContentSize().height)
    _ShareNode:centerLeft(-5000)
    _ShareNode:addChild(bg)
    cc.Director:getInstance():getRunningScene():addChild(_ShareNode, -1)

    local sprite = SdkBox:getInstance():createQRSprite(shareDatas.url);
    sprite:setPosition(bg:getContentSize().width - 175, 103)
    sprite:setScale(80 / sprite:getContentSize().width)
    bg:addChild(sprite, 1500)

     -- 公司LOGO
    local logo = UI.Image:create()
    logo:init("ui_information_share_logo.png")
    logo:rightUp(17, 9)
    bg:addChild(logo, 1200)

    local npcBg = UI.Image:create()
    npcBg:init("ui_share_banner_round.png")
    npcBg:leftBottom(10, 34)
    bg:addChild(npcBg, 1200)
    npcBg:setName("npcBg")

    local npc = UI.Image:create()
    npc:init("ui_share_npc_3.png")
    npc:leftBottom(5, 26)
    npcBg:addChild(npc)
    npc:setName("npc")

    local npcDialogBg = UI.Image:create()
    npcDialogBg:init("ui_share_paper.png")
    npcDialogBg:leftBottom(10, 361)
    bg:addChild(npcDialogBg, 1200)
    npcDialogBg:setName("npcDialogBg")

    local npcDialog = UI.Text:create()
    npcDialog:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    npcDialog:setSize(250, 122)
    npcDialog:centerUp(2)
    npcDialog:setTextCenter()
    npcDialog:setLineSpacing(-3)
    npcDialogBg:addChild(npcDialog)
    npcDialog:setName("npcDialog")

    performWithDelay(_ShareNode,function()
        SdkBox:getInstance():createImage(bg,"share.png",function(path)
            SdkBox:getInstance():share({
                channel = shareChannel,
                link = shareDatas.url,
                content =  LanguageManager:getInstance():getLocalString(shareDatas.content[math.random(1,table.nums(shareDatas.content))]),
                type = PublicDefine.SHARE_CONTENT_TYPE.IMAGE,
                title = LanguageManager:getInstance():getLocalString(shareDatas.title[math.random(1,table.nums(shareDatas.title))]),
                thumb = AvalonUtil.getShareThumbPath(shareDatas),
                image = path,
            })
         
            if _ShareNode and not tolua.isnull(_ShareNode) then
                _ShareNode:setVisible(false)
                _ShareNode:runAction(cc.RemoveSelf:create())
            end
        end)
    end, 0.05)
    return bg, _ShareNode
end

function AvalonUtil.saveObjectToFile(obj, fileName, path)
    local str = "local " .. fileName .. "= "
    local objectStr = AvalonUtil.serialize(obj)
    str = str .. objectStr
    str = str .. "\n return " .. fileName

    path = path .. "\\" .. fileName .. ".lua"
    local res = cc.FileUtils:getInstance():writeStringToFile(str, path)
    print("AvalonUtil.saveObjectToFile:", path)
    if res then
        return path
    else
        return nil
    end
end

function AvalonUtil.serialize(obj, tab)
    local tabCount = tab or 0  
    local lua = ""  
    local t = type(obj)  
    if t == "number" then  
        lua = lua .. obj
    elseif t == "boolean" then  
        lua = lua .. tostring(obj)
    elseif t == "string" then  
        lua = lua .. string.format("%q", obj)
    elseif t == "table" then  
        lua = lua .. "{\n"
        for k, v in pairs(obj) do  
            if type(v) ~= "userdata" then
                lua = lua .. AvalonUtil.getTabStrig("[" .. AvalonUtil.serialize(k, tabCount + 1) .. "]=" .. AvalonUtil.serialize(v, tabCount + 1) .. ",\n", tabCount + 1) 
            end
        end  
        local metatable = getmetatable(obj)  
            if metatable ~= nil and type(metatable.__index) == "table" then  
            for k, v in pairs(metatable.__index) do  
                if type(v) ~= "userdata" then
                    lua = lua .. AvalonUtil.getTabStrig("[" .. AvalonUtil.serialize(k, tabCount + 1) .. "]=" .. AvalonUtil.serialize(v, tabCount + 1) .. ",\n", tabCount + 1)  
                end
            end  
        end  
        lua = lua .. AvalonUtil.getTabStrig("}", tabCount)   
    elseif t == "nil" then  
        return nil  
    else  
        error("can not serialize a " .. t .. " type.")  
    end  
    return lua  
end 

function AvalonUtil.getTabStrig(content, tabCount)
    local text = ""
    for i = 1, tabCount, 1 do
        text = text .. "    "
    end
    text = text .. content
    return text
end

function table.tostring(t, usen)
    if t == nil then return nil end

    if type(t) ~= "table" then return tostring(t) end
    if t.tostring and type(t.tostring)=="function" then
        return t:tostring();
    end
    local str, _type = "";
    local nchar = usen and "\n" or "";
    for k, v in pairs(t) do
        _type = type(v);
        if _type == "nil" then
            str = str .. k .. "=nil, " .. nchar;
        elseif _type == "table" then
            if(v.class) then
                str = str .. k .. "={" .. (v.tostring and v.tostring(v) or ("class="..tostring(v.class.__cname))).. "}, " .. nchar;
            else
                str = str .. k .. "={" .. (v.tostring and v.tostring(v) or table.tostring(v, usen)).. "}, " .. nchar;
            end
        else
            str = str .. k .. "=" .. tostring(v) .. ", " .. nchar;
        end
    end
    return str;
end

function AvalonUtil.getShareThumbPath(shareDate)
    local SdkBox = require("utils.sdkbox.SdkBox")
    local platForm = SdkBox:getInstance():getVersionPlatform()
    local imageName = "thumbImage.png"
    if SdkBox:getInstance():getVersionTarget() == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN 
        or SdkBox:getInstance():getVersionTarget() == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE then
        imageName = "thumbImageCN.png"
    end
    if platForm == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
        return imageName
    elseif platForm == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
        return cc.FileUtils:getInstance():fullPathForFilename(imageName)
    end
    return imageName
end

--输入框特殊处理一下
function AvalonUtil.closeKeyBoard(editBox)
    if editBox == nil then
        return
    end
    local SdkBox = require("utils.sdkbox.SdkBox")
    local platForm = SdkBox:getInstance():getVersionPlatform()
    if platForm == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID then
        --todo nothing
    elseif platForm == PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_IOS then
        editBox:closeKeyboard()
    end
end

function AvalonUtil.getHeXieSpriteFrameName(iconName)
    local SdkBox = require("utils.sdkbox.SdkBox")
    local ver = SdkBox:getInstance():getVersionTarget()
    if ver == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN 
        or ver == PublicDefine.VERSION_TARGET.VERSION_TARGET_CN_PRE
        or ver == PublicDefine.VERSION_TARGET.VERSION_TARGET_DEV then
        local parttern = ".png"
        local index = string.find( iconName, parttern)
        if index ~= nil then
            index = index - 1
            local str = string.sub(iconName, 1, index)
            local hexieStr = str .. "_hexie" .. parttern
            local hexieSpriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrameByName(hexieStr)
            if hexieSpriteFrame ~= nil then
                iconName = hexieStr
            end
        end
    end
    return iconName;
end

function AvalonUtil.isResFileExisit(filename)
    local path = cc.FileUtils:getInstance():fullPathForFilename("res/Resource/"..filename)
    if cc.FileUtils:getInstance():isFileExist(path) then
        return true
    end
    local direction = Avalon.FileManager:getHotfixDirection()
    local remotePath = cc.FileUtils:getInstance():fullPathForFilename(direction..filename)
    return  cc.FileUtils:getInstance():isFileExist(remotePath)
end


function AvalonUtil.simulateTouchOutsideForNode(node)
    local x, y = -1000000, -100000
    local customTouch = cc.Touch:new()
    customTouch:setTouchInfo(100000, x, y, 100, 100)
    node:dispatchEvent(UIEvent.COMPONENT_TOUCH_OUTSIDE, node, {x = x, y = y}, customTouch)
end

-- 判断传入的版本号是否高于本地逻辑层版本(会通过热更新变动)
function AvalonUtil.isClientVersionEqualOrGreaterThan(remoteVersion)
    local clientVersion = Avalon.HotfixManager:getLocalVersion()
    local clientVerTemp = string.split(clientVersion,".") or {}
    local remoteVerTemp = string.split(remoteVersion,".") or {}
    for i=1,3 do
        if checkint(clientVerTemp[i]) < checkint(remoteVerTemp[i]) then
            return false
        elseif checkint(clientVerTemp[i]) > checkint(remoteVerTemp[i]) then
            return true
        end
    end

    return true;
end
-- 判断传入的版本号是否高于本地包体本身的版本(不会更随热更新变动)
function AvalonUtil.isClientPackageVersionEqualOrGreaterThan(remoteVersion)
    local clientVersion = AvalonUtil.getPackageVersion()
    local clientVerTemp = string.split(clientVersion,".") or {}
    local remoteVerTemp = string.split(remoteVersion,".") or {}
    for i=1,3 do
        if checkint(clientVerTemp[i]) < checkint(remoteVerTemp[i]) then
            return false
        elseif checkint(clientVerTemp[i]) > checkint(remoteVerTemp[i]) then
            return true
        end
    end
    return true;
end
-- 获取包体的版本
function AvalonUtil.getPackageVersion()
    local version = "0.0.0.0"
    local manifestUrl = cc.FileUtils:getInstance():fullPathForFilename("res/Resource/CaveOnline_project.manifest")
    if manifestUrl then
        local fileContent = cc.FileUtils:getInstance():getStringFromFile(manifestUrl)
        if fileContent then
            local manifest = avalon.Util.decodeJSON(fileContent)     
            version = manifest.version
        end
    end
    return version
end

-- 获取包体的版本
function AvalonUtil.getPackageBuild()
    local build = "9991"
    local manifestUrl = cc.FileUtils:getInstance():fullPathForFilename("res/Resource/CaveOnline_project.manifest")
    if manifestUrl then
        local fileContent = cc.FileUtils:getInstance():getStringFromFile(manifestUrl)
        if fileContent then
            local manifest = avalon.Util.decodeJSON(fileContent)     
            build = manifest.build
        end
    end
    return build
end

function AvalonUtil.ConvertNumberToStringWithOptionalDecimal(num, decimalPlaceNum)
    local tailMasker = math.pow(10, decimalPlaceNum)
    return tostring(math.floor(num * tailMasker + 0.5) / tailMasker)
end

function AvalonUtil.getEquipmentTypeText(int)
    local LanguageManager = require("app.game.LanguageManager")
    if (int == PublicDefine.EQUIPMENT_TYPE.Helmet) then
        return LanguageManager:getInstance():getLocalString(1111378) --"头盔"
    elseif (int == PublicDefine.EQUIPMENT_TYPE.Chest) then
        return LanguageManager:getInstance():getLocalString(1111380) --"胸甲"
    elseif (int == PublicDefine.EQUIPMENT_TYPE.Shoulders) then
        return LanguageManager:getInstance():getLocalString(1111379) --"肩甲"
    elseif (int == PublicDefine.EQUIPMENT_TYPE.Boots) then
        return LanguageManager:getInstance():getLocalString(1111382) --"鞋子"
    elseif (int == PublicDefine.EQUIPMENT_TYPE.Amulet) then
        return LanguageManager:getInstance():getLocalString(1111383) --"项链" 
    elseif (int == PublicDefine.EQUIPMENT_TYPE.Ring) then
        return LanguageManager:getInstance():getLocalString(1111384) --"戒指"
    elseif (int == PublicDefine.EQUIPMENT_TYPE.Weapon) then
        return LanguageManager:getInstance():getLocalString(1111536) --"武器"
    elseif (int == PublicDefine.EQUIPMENT_TYPE.Gloves) then
        return LanguageManager:getInstance():getLocalString(1111381) --"手套"
    else
        return "Unkown"
    end
end

function AvalonUtil.runBounceInAnimation(node)
    node:setScale(0.01)
    local scaleAction = cc.ScaleTo:create(0.15, 1)
    local bounceScaleAction = cc.EaseBackOut:create(scaleAction)
    node:runAction(bounceScaleAction)
end

-- 获取一个节点, 上面运载了多位兼容的图片数字
function AvalonUtil:getStyledNumberNode(num)
    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    if num == 0 then
        local styledDigit = UI.Image:create()
        styledDigit:init("ui_home_unmber_" .. tostring(num) .. ".png")
        styledDigit:floatRight(0)
        layout:addComponent(styledDigit)
    else
        while (num ~= 0) do
            local digit = num % 10
            num = math.floor(num / 10)

            local styledDigit = UI.Image:create()
            styledDigit:init("ui_home_unmber_" .. tostring(digit) .. ".png")
            styledDigit:floatRight(0)
            layout:addComponent(styledDigit)
        end
    end
    return layout
end

-- function AvalonUtil:getQuestConditionTitle(activityData)
--     if(activityData == nil) then 
--         return ""
--     end
    
--     local LanguageManager = require("app.game.LanguageManager")
--     local type = activityData:getType()
--     local littleType = activityData:getLittleType()

--     local typeData = 100000000
--     local titleStr = ""
--     if(type == PublicDefine.QuestConditionType.QuestConditionType_Killing) then
--         --杀怪(目标ID 0为所有)
--         -- print("QuestConditionType_Killing", littleType)
--         if(littleType == 0) then
--             titleStr = LanguageManager:getInstance():getLocalString(1271001)
--         else
--             local diffculty = math.modf(littleType / typeData)
--             local templateID = littleType - diffculty * typeData
--             local mode = math.modf(diffculty / 100)
--             diffculty = diffculty - mode * 100
--             local modelStr = ToolsUtil:getModeStr(mode)
--             local diffcultyStr = ToolsUtil:getDiffcultName(diffculty)
--             titleStr = PlaceholderUtil:formatName(string.format(LanguageManager:getInstance():getLocalString(1271002), modelStr), templateID, mode, diffculty)
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_KillingBoss) then 
--         --击杀BOSS ()
--         local diffculty = math.modf(littleType / typeData)
--         local templateID = littleType - diffculty * typeData
--         local mode = math.modf(diffculty / 100)
--         diffculty = diffculty - mode * 100
--         local modelStr = ToolsUtil:getModeStr(mode)
--         titleStr = string.format(LanguageManager:getInstance():getLocalString(1271003), modelStr)
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_NPCOper) then 
--         --完成NPC操作(FUNCTION_TYPE) 
--         if(littleType == PublicDefine.FUNCTION_TYPE.LUCKYWHEEL_TURN) then 
--             -- 使用转盘次数：
--             titleStr = LanguageManager:getInstance():getLocalString(1271004)
--         elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN then
--             titleStr = LanguageManager:getInstance():getLocalString(1271005)
--         elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_DECOMPOSE then
--             titleStr = LanguageManager:getInstance():getLocalString(1271007)
--         elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_REMODEL then
--             titleStr = LanguageManager:getInstance():getLocalString(1271008)
--         elseif littleType == PublicDefine.FUNCTION_TYPE.BLACK_MARKET then
--             titleStr = LanguageManager:getInstance():getLocalString(1271009)
--         elseif littleType == PublicDefine.FUNCTION_TYPE.CAT_FOOD then
--             titleStr = LanguageManager:getInstance():getLocalString(1271010)
--         elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_FORGE then
--             titleStr = LanguageManager:getInstance():getLocalString(1271011)
--         elseif littleType == PublicDefine.FUNCTION_TYPE.ENCHANT then
--             titleStr = LanguageManager:getInstance():getLocalString(1271006)
--         elseif littleType == PublicDefine.FUNCTION_TYPE.GOLD_TOUCH then
--             titleStr = LanguageManager:getInstance():getLocalString(1271012)
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_NPCOperSuc) then 
--         if(littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN) then
--             -- 强化成功次数
--             titleStr = LanguageManager:getInstance():getLocalString(1271013)
--         elseif (littleType == PublicDefine.FUNCTION_TYPE.ENCHANT) then
--             -- 附魔成功次数
--             titleStr = LanguageManager:getInstance():getLocalString(1271014)
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Collection) then 
--         --完成收集 (目标ID 0为所有)
--         print("QuestConditionType_Collection", littleType)
--         if(littleType == 0) then 
--             -- 道具获得数：
--             titleStr = LanguageManager:getInstance():getLocalString(1271015)
--         else 
--             titleStr = PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(1271016), littleType)
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_CollectionCoin) then 
--         -- 完成收集金币 
--         -- 黄金获得数：
--         titleStr = LanguageManager:getInstance():getLocalString(1271017)
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_LoginOut) then 
--         --登录 (1 连续登录 2累计登录)
--         if(littleType == 1) then 
--             titleStr = LanguageManager:getInstance():getLocalString(1271018)
--         elseif littleType == 2 then
--             titleStr = LanguageManager:getInstance():getLocalString(1271019)
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_DiamodCost) then 
--         --水晶消耗(FUNCTION_TYPE 填0为所有)
--         if littleType == 1 then
--             -- 累积消耗
--             titleStr = LanguageManager:getInstance():getLocalString(1271020)
--         elseif littleType == 2 then
--             -- 黑市消耗水晶
--             titleStr = LanguageManager:getInstance():getLocalString(1271021)
--         elseif littleType == 3 then
--             -- 料理消耗水晶
--             titleStr = LanguageManager:getInstance():getLocalString(1271022)
--         elseif littleType == 4 then
--             -- 改造消耗水晶
--             titleStr = LanguageManager:getInstance():getLocalString(1271023)
--         elseif littleType == 5 then
--             -- 黑市水晶够买次数：
--             titleStr = LanguageManager:getInstance():getLocalString(1271024)
--         elseif littleType == 6 then
--             -- 宝箱购买消耗水晶数量:
--             titleStr = UI.TEXT_1172021
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_EnterCave) then 
--         --进洞探险(1.进入普通洞窟 2.进入大秘境 3组队进入大秘境 )
--         if(littleType == 1) then
--             -- 探索洞窟：
--             titleStr = LanguageManager:getInstance():getLocalString(1271025)
--         elseif (littleType == 2) then 
--             -- 参与大秘境：
--             titleStr = LanguageManager:getInstance():getLocalString(1271026)
--         elseif (littleType == 3) then 
--             -- 参与大秘境（组队）：
--             titleStr = LanguageManager:getInstance():getLocalString(1271027)
--         elseif (littleType == 4) then 
--             -- 进入英雄洞窟(单人+组队)
--             titleStr = UI.TEXT_1172030
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_LeaveCave) then 
--         --探险完成(1,单人普通成功 2组队普通成功  )
--         if(littleType == 1) then
--             -- 成功探索洞窟：
--             titleStr = LanguageManager:getInstance():getLocalString(1271028)
--         elseif (littleType == 2) then
--             -- 成功探索洞窟（组队）：
--             titleStr = LanguageManager:getInstance():getLocalString(1271029)
--         elseif (littleType == 3) then
--             -- 探索时光之门（英雄）成功次数:
--             titleStr = UI.TEXT_1172028
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_ArrivalLevel) then 
--         --到达指定层数(模式难度层数复合字段)
--         -- 探索XX难度洞窟YY层：   01:01:1001  模式:难度:层数
--         -- 参与大秘境XX层：
--         local caveMode = 1
--         local diffculty = 1
--         local level = 23
--         local value = checkint(littleType)
--         caveMode = math.modf(value/1000000)
--         value = value - 1000000 * caveMode
--         diffculty = math.modf(value/10000)
--         value = value - 10000 * diffculty    
--         level = value

--         local modeStr = ToolsUtil:getModeStr(caveMode)
--         local levelStr = tostring(level)
--         local diffcultyStr = ToolsUtil:getDiffcultName(diffculty)
        
--         if caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then 
--             titleStr = string.format(LanguageManager:getInstance():getLocalString(1271036), levelStr)
--         else 
--             titleStr = string.format(LanguageManager:getInstance():getLocalString(1271030), modeStr, levelStr, diffcultyStr)
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_AchievementPoint) then 
--         --成就
--         titleStr = LanguageManager:getInstance():getLocalString(1271031)
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_EquipScore) then 
--         --装备
--         titleStr = LanguageManager:getInstance():getLocalString(1271032)
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Guild) then  
--         --公会
--         titleStr = LanguageManager:getInstance():getLocalString(1271033)
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Rechage) then  
--         --充值
--         if(littleType == 0) then 
--             titleStr = LanguageManager:getInstance():getLocalString(1271034)
--         else 
--             titleStr = string.format(LanguageManager:getInstance():getLocalString(1271035), littleType)
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_BoxBought) then
--         -- 宝箱购买次数：
--         titleStr = UI.TEXT_1172024
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_GemStoneType) then
--         -- 
--         if(littleType == 0) then 
--             -- 获得任意符文数量：
--             titleStr = UI.TEXT_1172025
--         elseif (littleType == 1) then 
--             titleStr = UI.TEXT_1172026
--         elseif (littleType == 2) then 
--             titleStr = UI.TEXT_1172027
--         end
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_GemStoneLevel) then
--         -- 获得%s级符文数量：
--         titleStr = string.format(UI.TEXT_1172023, littleType)
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_BuyMonthCard) then
--         -- 购买月卡次数
--         titleStr = UI.TEXT_1172022
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Version) then 
--         local curStr = string.format(UI.TEXT_1212284, AvalonUtil.getPackageVersion())
--         -- 处理指定版本活动
--         titleStr = string.format(LanguageManager:getInstance():getLocalString(1111484), activityData:getTargetVersion()) .. curStr
--     elseif (type == PublicDefine.QuestConditionType.QuestConditionType_OpenBox) then
        
--     else 
--         printError("QuestConditionPanel no handle type=", type)
--     end

--     return titleStr
-- end

function AvalonUtil:getQuestConditionTitle(activityData)
    if(activityData == nil) then 
        return "", ""
    end
    local LanguageManager = require("app.game.LanguageManager")
    local type = activityData:getType()
    local littleType = activityData:getLittleType()

    local typeData = 100000000

    local targetStr = ""
    local titleStr = ""
    print("getQuestConditionTitle", type)
    if(type == PublicDefine.QuestConditionType.QuestConditionType_Killing) then
        --杀怪(目标ID 0为所有)
        -- print("QuestConditionType_Killing", littleType)
        if(littleType == 0) then
            titleStr = LanguageManager:getInstance():getLocalString(1271001)
        else
            local diffculty = math.modf(littleType / typeData)
            local templateID = littleType - diffculty * typeData
            local mode = math.modf(diffculty / 100)
            diffculty = diffculty - mode * 100
            local modelStr = ToolsUtil:getModeStr(mode)
            local diffcultyStr = ToolsUtil:getDiffcultName(diffculty)
            titleStr = PlaceholderUtil:formatName(string.format(LanguageManager:getInstance():getLocalString(1271002), self:_getModeStr(mode,diffculty)), templateID, mode, diffculty)
        end

        targetStr = LanguageManager:getInstance():getLocalString(1122007)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_KillingBoss) then 
        --击杀BOSS ()
        local diffculty = math.modf(littleType / typeData)
        local templateID = littleType - diffculty * typeData
        local mode = math.modf(diffculty / 100)
        diffculty = diffculty - mode * 100
        local modelStr = ToolsUtil:getModeStr(mode)
        local diffcultyStr = ToolsUtil:getDiffcultName(diffculty)
        titleStr = string.format(LanguageManager:getInstance():getLocalString(1271003), self:_getModeStr(mode, diffculty))
        if(mode == PublicDefine.CAVE_MODE.MODE_HERO) then 
            targetStr = LanguageManager:getInstance():getLocalString(1122010)
        elseif(mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then 
            targetStr = LanguageManager:getInstance():getLocalString(1122010)
        else
            targetStr = LanguageManager:getInstance():getLocalString(1122009)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_NPCOper) then 
        --完成NPC操作(FUNCTION_TYPE) 
        if(littleType == PublicDefine.FUNCTION_TYPE.LUCKYWHEEL_TURN) then 
            -- 使用转盘次数：
            titleStr = LanguageManager:getInstance():getLocalString(1271004)
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN then
            titleStr = LanguageManager:getInstance():getLocalString(1271005)
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_DECOMPOSE then
            titleStr = LanguageManager:getInstance():getLocalString(1271007)
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_REMODEL then
            titleStr = LanguageManager:getInstance():getLocalString(1271008)
        elseif littleType == PublicDefine.FUNCTION_TYPE.BLACK_MARKET then
            titleStr = LanguageManager:getInstance():getLocalString(1271009)
        elseif littleType == PublicDefine.FUNCTION_TYPE.CAT_FOOD then
            titleStr = LanguageManager:getInstance():getLocalString(1271010)
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_FORGE then
            titleStr = LanguageManager:getInstance():getLocalString(1271011)
        elseif littleType == PublicDefine.FUNCTION_TYPE.ENCHANT then
            titleStr = LanguageManager:getInstance():getLocalString(1271006)
        elseif littleType == PublicDefine.FUNCTION_TYPE.GOLD_TOUCH then
            titleStr = LanguageManager:getInstance():getLocalString(1271012)
        elseif littleType == PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_GET then
            titleStr = LanguageManager:getInstance():getLocalString(1112531) --"使用占星次数:"
        elseif littleType == PublicDefine.FUNCTION_TYPE.EQUIP_RECAST then
            titleStr = LanguageManager:getInstance():getLocalString(1112530) --"使用重铸次数:"
        end

        targetStr = LanguageManager:getInstance():getLocalString(1122011)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_NPCOperSuc) then 
        if(littleType == PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN) then
            -- 强化成功次数
            titleStr = LanguageManager:getInstance():getLocalString(1271013)
        elseif (littleType == PublicDefine.FUNCTION_TYPE.ENCHANT) then
            -- 附魔成功次数
            titleStr = LanguageManager:getInstance():getLocalString(1271014)
        end

        targetStr = LanguageManager:getInstance():getLocalString(1122012)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Collection) then 
        --完成收集 (目标ID 0为所有)
        if(littleType == 0) then 
            -- 道具获得数：
            titleStr = LanguageManager:getInstance():getLocalString(1271015)
        else 
            titleStr = PlaceholderUtil:formatName(LanguageManager:getInstance():getLocalString(1271016), littleType)
        end

        targetStr = LanguageManager:getInstance():getLocalString(1122013)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_CollectionCoin) then 
        -- 完成收集金币 
        -- 黄金获得数：
        titleStr = LanguageManager:getInstance():getLocalString(1271017)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_LoginOut) then 
        --登录 (1 连续登录 2累计登录 3限时登录)
        if(littleType == 1) then 
            titleStr = LanguageManager:getInstance():getLocalString(1271018)
        elseif littleType == 2 then
            titleStr = LanguageManager:getInstance():getLocalString(1271019)
        elseif littleType == 3 then
            titleStr = LanguageManager:getInstance():getLocalString(1116256)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_DiamodCost) then 
        --水晶消耗(FUNCTION_TYPE 填0为所有)
        if littleType == 1 then
            -- 累积消耗
            titleStr = LanguageManager:getInstance():getLocalString(1271020)
        elseif littleType == 2 then
            -- 黑市消耗水晶
            titleStr = LanguageManager:getInstance():getLocalString(1271021)
        elseif littleType == 3 then
            -- 料理消耗水晶
            titleStr = LanguageManager:getInstance():getLocalString(1271022)
        elseif littleType == 4 then
            -- 改造消耗水晶
            titleStr = LanguageManager:getInstance():getLocalString(1271023)
        elseif littleType == 5 then
            -- 黑市水晶够买次数：
            titleStr = LanguageManager:getInstance():getLocalString(1271024)
        elseif littleType == 6 then
            -- 宝箱购买消耗水晶数量:
            titleStr = UI.TEXT_1172021
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_EnterCave) then 
        --进洞探险(1.进入普通洞窟 2.进入大秘境 3组队进入大秘境 )
        if(littleType == 1) then
            -- 探索洞窟：
            titleStr = LanguageManager:getInstance():getLocalString(1271025)
        elseif (littleType == 2) then 
            -- 参与大秘境：
            titleStr = LanguageManager:getInstance():getLocalString(1271026)
        elseif (littleType == 3) then 
            -- 参与大秘境（组队）：
            titleStr = LanguageManager:getInstance():getLocalString(1271027)
        elseif (littleType == 4) then 
            -- 进入英雄洞窟(单人+组队)
            titleStr = UI.TEXT_1172030
        elseif (littleType == 5) then 
            -- 进入沙之眼洞窟(单人+组队))
            titleStr = LanguageManager:getInstance():getLocalString(1112523)--"探索沙之眼次数："
        elseif (littleType == 6) then 
            -- 进入扭曲空间洞窟(单人+组队)) 
            titleStr = LanguageManager:getInstance():getLocalString(1112524)--"探索扭曲空间次数："
        elseif (littleType == 7) then 
            -- 进入扭曲空间困难洞窟(单人+组队))
            titleStr = LanguageManager:getInstance():getLocalString(1112525)--"探索扭曲空间(困难)次数："
        end

        targetStr = LanguageManager:getInstance():getLocalString(1271014)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_LeaveCave) then 
        --探险完成(1,单人普通成功 2组队普通成功  )
        if(littleType == 1) then
            -- 成功探索洞窟：
            titleStr = LanguageManager:getInstance():getLocalString(1271028)
        elseif (littleType == 2) then
            -- 成功探索洞窟（组队）：
            titleStr = LanguageManager:getInstance():getLocalString(1271029)
        elseif (littleType == 3) then
            -- 探索时光之门（英雄）成功次数:
            titleStr = UI.TEXT_1172028
        elseif (littleType == 4) then
            -- 沙之眼洞窟成功（单人+组队）)
            titleStr = LanguageManager:getInstance():getLocalString(1112520) --"探索沙之眼成功次数："
        elseif (littleType == 5) then
            -- 扭曲空间洞窟成功（单人+组队） )
            titleStr = LanguageManager:getInstance():getLocalString(1112521) --"探索扭曲空间成功次数："
        elseif (littleType == 6) then
            -- 扭曲空间困难洞窟成功（单人+组队） )
            titleStr = LanguageManager:getInstance():getLocalString(1112522) --"探索扭曲空间(困难)成功次数："
        end

        targetStr = LanguageManager:getInstance():getLocalString(1271015)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_ArrivalLevel) then 
        --到达指定层数(模式难度层数复合字段)
        -- 探索XX难度洞窟YY层：   01:01:1001  模式:难度:层数
        -- 参与大秘境XX层：
        local caveMode = 1
        local diffculty = 1
        local level = 23
        local value = checkint(littleType)
        caveMode = math.modf(value/1000000)
        value = value - 1000000 * caveMode
        diffculty = math.modf(value/10000)
        value = value - 10000 * diffculty    
        level = value

        local modeStr = ToolsUtil:getModeStr(caveMode)
        local levelStr = tostring(level)
        local diffcultyStr = ToolsUtil:getDiffcultName(diffculty)
        
        if caveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then 
            titleStr = string.format(LanguageManager:getInstance():getLocalString(1271036), levelStr)
        else 
            titleStr = string.format(LanguageManager:getInstance():getLocalString(1271030), self:_getModeStr(caveMode, diffculty), levelStr, diffcultyStr)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_AchievementPoint) then 
        --成就
        titleStr = LanguageManager:getInstance():getLocalString(1271031)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_EquipScore) then 
        --装备
        titleStr = LanguageManager:getInstance():getLocalString(1271032)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Guild) then  
        --公会
        titleStr = LanguageManager:getInstance():getLocalString(1271033)

        targetStr = LanguageManager:getInstance():getLocalString(1271008)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Rechage) then  
        --充值
        if(littleType == 0) then 
            titleStr = LanguageManager:getInstance():getLocalString(1271034)
        else 
            titleStr = string.format(LanguageManager:getInstance():getLocalString(1271035), littleType)
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_BoxBought) then
        -- 宝箱购买次数：
        titleStr = UI.TEXT_1172024
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_GemStoneType) then
        -- 
        if(littleType == 0) then 
            -- 获得任意符文数量：
            titleStr = UI.TEXT_1172025
        elseif (littleType == 1) then 
            titleStr = UI.TEXT_1172026
        elseif (littleType == 2) then 
            titleStr = UI.TEXT_1172027
        end
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_GemStoneLevel) then
        -- 获得%s级符文数量：
        titleStr = string.format(UI.TEXT_1172023, littleType)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_BuyMonthCard) then
        -- 购买月卡次数
        titleStr = UI.TEXT_1172022
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_Version) then 
        -- 处理指定版本活动
        local curStr = string.format("("..tostring(UI.TEXT_1212284)..")", AvalonUtil.getPackageVersion())
        titleStr = string.format(LanguageManager:getInstance():getLocalString(1111484), activityData:getTargetVersion()) .. curStr
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_OpenBox) then
        local str = ""
        -- 陶罐
        if(littleType == PublicDefine.BOX_TYPE.BOX_POT) then 
            str = UI.TEXT_1212520
        -- 骨头堆
        elseif (littleType == PublicDefine.BOX_TYPE.BOX_BONE) then 
            str = UI.TEXT_1212521
        -- 木宝箱
        elseif (littleType == PublicDefine.BOX_TYPE.BOX_WOOD) then 
            str = UI.TEXT_1212522
        -- 金宝箱
        elseif (littleType == PublicDefine.BOX_TYPE.BOX_GOLD) then 
            str = UI.TEXT_1212523
        end

        titleStr = string.format(UI.TEXT_1212519, str) 
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_LuckyLotter) then
        titleStr = LanguageManager:getInstance():getLocalString(1112582)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_DrawMarblesFever) then
        titleStr = LanguageManager:getInstance():getLocalString(1114568)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_SetSail) then
        titleStr = LanguageManager:getInstance():getLocalString(1115326)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_FinishSail) then
        titleStr = LanguageManager:getInstance():getLocalString(1115327)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_FinishFish) then
        titleStr = LanguageManager:getInstance():getLocalString(1115328)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_UseRecipe) then
        titleStr = LanguageManager:getInstance():getLocalString(1115329)
    elseif (type == PublicDefine.QuestConditionType.QuestConditionType_CashRecharge) then
        titleStr = LanguageManager:getInstance():getLocalString(1116266)
    else 
        printError("GuildQuestConditionPanel no handle type=", type)
    end

    return titleStr, targetStr
end

function AvalonUtil:_getModeStr(mode, diffculty)
    local modelStr = ToolsUtil:getModeStr(mode)
    local diffcultyStr = ToolsUtil:getDiffcultName(diffculty)

    if(diffculty > PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1) then 
        return modelStr.."("..diffcultyStr..")"
    end

    return modelStr
end

function AvalonUtil:isMicPermissionDenied()
    if (not avalon or not avalon.Util or not avalon.Util.isMicPermissionDenied) then
        return false
    end
    return avalon.Util.isMicPermissionDenied()
end

function AvalonUtil:isHavePermission(permission)
    if (not avalon or not avalon.Util or not avalon.Util.isHavePermission) then
        return true
    end
    return avalon.Util.isHavePermission(permission)
end


local function autoEnableMoving(self) 
    if (self._disabledMoving) then
        self._disabledMoving = false
        GameManager:enableMovingHandler()
        Avalon.MessageCenter:notice(GameMessage.MC_SET_BLOCKING_TOUCHES, false)
    end
end

function AvalonUtil:moveCameraToCoord(x, y, duration, actionTag, cb)
    -- if not GameManager:getIsCenterByMaster() then 
    --     return 
    -- end

    local MachineManager = require("app.game.MachineManager")
    if (MachineManager:getInstance():getMachine() and
        MachineManager:getInstance():getMachine()._view and
        MachineManager:getInstance():getMachine()._view._map ) 
    then
        -- 停止移动阻止点击(动画被打断的情况下会自动解除阻止)
        self._disabledMoving = true
        GameManager:disableMovingHandler()
        Avalon.MessageCenter:notice(GameMessage.MC_SET_BLOCKING_TOUCHES, true)
        Avalon.Scheduler:setDelayForUpdateOnce(self, autoEnableMoving, duration + 0.5)

        local map = MachineManager:getInstance():getMachine()._view._map
        local mapPosX, mapPosY = map:coordinateToMapPosition(x, y)
        local MapHelper = require "app.mapkit.MapHelper"
        local moveto = cc.EaseInOut:create(cc.MoveTo:create(duration, cc.p(mapPosX, mapPosY)), MapHelper.CAMERA_MOVE_CURVE)
        if (actionTag) then
            moveto:setTag(actionTag)
        end
        map:stopAllActions()
        map:runAction(cc.Sequence:create(
            moveto,
            cc.CallFunc:create(function()
                -- 开始移动允许点击
                self._disabledMoving = false
                GameManager:enableMovingHandler() 
                Avalon.MessageCenter:notice(GameMessage.MC_SET_BLOCKING_TOUCHES, false)
                if (cb) then cb() end
            end)
        ))

        -- 移动途中更新地图显示, 避免走出优化位置出现空白地图
        local curCord = map:getCenterCoord()
        local distX = x - curCord.x
        local distY = y - curCord.y
        local dist = math.ceil(math.pow(math.pow(distX, 2) + math.pow(distY, 2), 1/2))
        local unitTime = dist >= 1 and duration / dist or 0
        if (dist > 5) then
            for i=1,dist do
                local timeNow = i * unitTime
                local progress = timeNow / duration
                performWithDelay(map, function() 
                    -- 更新地图
                    map:updateMapTileAround(math.floor(curCord.x + progress * distX), math.floor(curCord.y + progress * distY))
                end, timeNow)
            end
        end 
        return true
    else
        if (cb) then cb() end
        return false
    end
end

function AvalonUtil:moveCameraToMaster(duration, isEaseInOut, cb)
    if not GameManager:getIsCenterByMaster() then 
        return 
    end

    if (isEaseInOut == nil) then isEaseInOut = true end
    local MachineManager = require("app.game.MachineManager")
    local GameDataManager = require("app.game.GameDataManager")
    if (MachineManager:getInstance():getMachine() and
        MachineManager:getInstance():getMachine()._view and
        MachineManager:getInstance():getMachine()._view._map) 
    then
        local master = GameDataManager:getInstance():getMaster()
        local coord = master:getCoord()
        if (master and coord) then
            local map = MachineManager:getInstance():getMachine()._view._map
            -- 这里根据业务逻辑做的特殊处理，由于每个场景都是重新创建的，所有不会有问题。
            if(map._screenBack ~= true) then 
                -- 停止移动阻止点击(动画被打断的情况下会自动解除阻止)
                self._disabledMoving = true
                GameManager:disableMovingHandler()
                Avalon.MessageCenter:notice(GameMessage.MC_SET_BLOCKING_TOUCHES, true)
                Avalon.Scheduler:setDelayForUpdateOnce(self, autoEnableMoving, duration + 0.5)

                map:stopAllActions()
                map:screenCenterToCoord(coord.x, coord.y, true, duration, nil, isEaseInOut, function()
                    -- 开始移动允许点击
                    self._disabledMoving = false
                    GameManager:enableMovingHandler()
                    Avalon.MessageCenter:notice(GameMessage.MC_SET_BLOCKING_TOUCHES, false)
                    map._screenBack = false
                    if (cb) then cb() end
                end)
                map._screenBack = true
            end 
        end
        return true
    else
        if (cb) then cb() end
        return false
    end
end


-- 为一些特定按钮增加框框动画 (大秘境, 锻造, 等)
function AvalonUtil.createPlayAdsButton(callback, text)
    local des = UI.Text:create()
    des:init(text, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_102)
    des:setWidth(88)
    des:setTextCenter()
    des:center()
    des:autoAdapt()
   
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_public_banner_black_image.png", cc.rect(70,1,400,25))
    bg:setOpacity(160)
    bg:setContentSize(88, des:getContentSize().height + 10)
    bg:addChild(des)
    bg:setPosition(44, bg:getContentSize().height / 2)

    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(88, 84 + des:getContentSize().height)
    layout:setTouchEnable(true)
    layout:addEventListener(UIEvent.COMPONENT_CLICK, layout, function(target, sender, touchPosition)
        -- body
        local animation = sender:getChildByName("Animation")
        animation:setAnimation("begin", false)
        animation:addAnimation("idle", true)
        if callback then
            callback()
        end
    end)
    layout:addChild(bg)

    local animation = UI.Animation:create()
    animation:init("effect_ui_common_dvertisement.json", "effect_ui_common_dvertisement.atlas")
    animation:setSize(88, 70)
    animation:centerUp(1)
    animation:setName("Animation")
    animation:setAnimation("idle", true)
    layout:addChild(animation, 10)
    return layout
end

function AvalonUtil.getQulityRichTexts(qulityList, fontSize, fontName)
    -- body
    local LanguageManager = require("app.game.LanguageManager")
    
    if fontSize == "" or fontSize == nil then
        fontSize  = DEFALAULT_FONT_SIZE
    end
    if fontName == "" or fontName == nil then
        fontName = UI.SYS_FONT_CHAT
    end
    local PUFTRARE = PublicDefine.GOODS_RARE
    local cfgList = {[PUFTRARE.RARE_WHITE_1] = {text = ToolsUtil:getGoodsRareStr(PUFTRARE.RARE_WHITE_1)}, 
                     [PUFTRARE.RARE_BLUE_2] = {text = ToolsUtil:getGoodsRareStr(PUFTRARE.RARE_BLUE_2)},
                     [PUFTRARE.RARE_GOLDEN_3] = {text = ToolsUtil:getGoodsRareStr(PUFTRARE.RARE_GOLDEN_3)}, 
                     [PUFTRARE.RARE_DARKGOLDEN_4] = {text = ToolsUtil:getGoodsRareStr(PUFTRARE.RARE_DARKGOLDEN_4)}, 
                     [PUFTRARE.RARE_DARKGOLDEN_BORDERS_5] = {text = ToolsUtil:getGoodsRareStr(PUFTRARE.RARE_DARKGOLDEN_BORDERS_5)}}
                    --  [PUFTRARE.RARE_DARKRED] = {text = ToolsUtil:getGoodsRareStr(PUFTRARE.RARE_DARKRED)}}

    local masterData = RoleDataManager:getMaster()
    if masterData:getIsReincarntion() then
        -- table.insert()
        cfgList[PUFTRARE.RARE_DARKRED] = {text = ToolsUtil:getGoodsRareStr(PUFTRARE.RARE_DARKRED)}
    end

    -- local cfgList = {[PUFTRARE.RARE_WHITE_1] = {text = "白色"}, 
    --              [PUFTRARE.RARE_BLUE_2] = {text = "蓝色"},
    --              [PUFTRARE.RARE_GOLDEN_3] = {text = "金色"}, 
    --              [PUFTRARE.RARE_DARKGOLDEN_4] = {text = "暗金"}, 
    --              [PUFTRARE.RARE_DARKGOLDEN_BORDERS_5] = {text ="紫色"}}

    local richTexts = ""
    local size = #qulityList
    for k, v in ipairs(qulityList) do
        if not masterData:getIsReincarntion() and v == PUFTRARE.RARE_DARKGOLDEN_BORDERS_5 and k == 1 then
            size = 1
        end

        local data = cfgList[v]
        if data then
            local color = UI.ITEM_QUALITY_FONT_COLOR[v]
            if k == size then
                richTexts = richTexts..AvalonUtil:serializeText(data.text, color, fontSize, fontName)
            else
                richTexts = richTexts..AvalonUtil:serializeText(data.text..", ", color, fontSize, fontName)
            end
        end
    end
    return richTexts
end

function AvalonUtil.androidRequestPermission(permission, rationale)
    if (not avalon or not avalon.Util or not avalon.Util.androidRequestPermission) then
        return false
    end
    avalon.Util.androidRequestPermission(permission, rationale)
    return true
end

function AvalonUtil.getEquipmentTypeFromID(ID)
    local equipType = math.modf(ID / 10000)
    if equipType == 2101 then
        return PublicDefine.EQUIPMENT_TYPE.Helmet
    elseif equipType == 2102 then
        return PublicDefine.EQUIPMENT_TYPE.Chest
    elseif equipType == 2103 then
       return PublicDefine.EQUIPMENT_TYPE.Shoulders
    elseif equipType == 2104 then
       return PublicDefine.EQUIPMENT_TYPE.Gloves
    elseif equipType == 2105 then
       return PublicDefine.EQUIPMENT_TYPE.Boots
    elseif equipType == 2106 then
       return PublicDefine.EQUIPMENT_TYPE.Amulet
    elseif equipType == 2107 then
       return PublicDefine.EQUIPMENT_TYPE.Ring
    elseif equipType == 2108 then
       return PublicDefine.EQUIPMENT_TYPE.Weapon
    elseif equipType == 2109 then
        return PublicDefine.EQUIPMENT_TYPE.Fish
    else
        assert(false, string.format("EquipmentData:_refreshEquipmentType  error goodsID %d",ID))
    end
    return PublicDefine.EQUIPMENT_TYPE.Helmet
end

function AvalonUtil.tableToString(table)
    local count = 0
    local string = ""
    for k,v in pairs(table) do
        if (count ~= 0) then
            string = string .. ","
        end
        string = string .. k .. "," .. v
        count = count + 1
    end
    return string
end

function AvalonUtil.arrToString(arr)
    local count = 0
    local string = ""
    for i,v in ipairs(arr) do
        if (count ~= 0) then
            string = string .. ","
        end
        string =  string .. v
        count = count + 1
    end
    return string
end

function AvalonUtil.stringToTable(rawStr, isNumber)
    local table = {}
    local splitedString = string.split(rawStr, ",")
    local k = nil
    local count = 0
    for i,v in ipairs(splitedString) do
        if (isNumber) then v = tonumber(v) end
        local idx = count % 2
        if (idx == 0) then
            k = v
        elseif (k ~= nil) then
            table[k] = v
            k = nil
        end
        count = count + 1
    end
    return table
end

function AvalonUtil.stringToArr(rawStr, isNumber)
    local arr = string.split(rawStr, ",")
    if (isNumber) then
        for i,v in ipairs(arr) do
            arr[i] = tonumber(v)
        end
    end
    return arr or {}
end

function AvalonUtil.playShakeAct(node, repeatForever)
    local actionTag = 10010101
    node:stopActionByTag(actionTag)
    node:rotate(0)
    local delayAct1 = cc.DelayTime:create(3)
    local rotateAct1 = cc.RotateBy:create(0.06, 25)
    local rotateAct2 = cc.RotateBy:create(0.11, -60)
    local rotateAct3 = cc.RotateBy:create(0.09, 57)
    local rotateAct4 = cc.RotateBy:create(0.09, -52)
    local rotateAct5 = cc.RotateTo:create(0.07, 0)
    -- local rotateAct6 = cc.RotateBy:create(0.07, -42)
    -- local rotateAct7 = cc.RotateBy:create(0.05, 37)
    -- local rotateAct8 = cc.RotateBy:create(0.05, -32)
    -- local rotateAct9 = cc.RotateBy:create(0.03, 20)
    local action = cc.Sequence:create(
        rotateAct1,
        rotateAct2,
        rotateAct3,
        rotateAct4,
        rotateAct5,
        delayAct1)
    if (repeatForever) then
        action = cc.RepeatForever:create(action)
    end
    node:runAction(action)
    node:setTag(actionTag)
end


function AvalonUtil.textFormat(webLaunguageList, fontColor, fontSize, fontName, modeText, extendArray)
-- print("-------AvalonUtil:textFormat--------", modeText, extendArray)
    local LanguageManager = require("app.game.LanguageManager")
    if extendArray ~= nil and #extendArray > 0 and modeText ~= nil then
        local param = {}
        for k, formatParam in ipairs(extendArray) do
            local textTable = {}
            textTable.color = fontColor
            textTable.fontSize = fontSize
            if formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_Time then
                textTable.text = GameManager:getNowServerDate("%Y.%m.%d %H:%M:%S", formatParam.contentValue + GameManager:getEPOCHTime())
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_Number then
                textTable.text = formatParam.contentValue..""
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_Text then
                textTable.text = formatParam.externValue..""
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_RoleName then
                textTable.text = formatParam.externValue..""
                textTable.color = UI.FONT_COLOR_92_144_249
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_GuildName then
                textTable.text = formatParam.externValue..""
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_ItemId then
                --道具得有品质颜色 
                local goodsData = GoodsDataManager:createLocalGoodsData(formatParam.contentValue)
                if goodsData then
                    textTable.text = goodsData:getName()
                    textTable.color = UI.ITEM_QUALITY_FONT_COLOR[goodsData:getGoodsRare()]
                end
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_LocalLanguageId then
                textTable.text = LanguageManager:getInstance():getLocalString(formatParam.contentValue)
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_WebLanguageId then
                textTable = AvalonUtil.getWebLaunguageByKey(webLaunguageList, formatParam.contentValue)
                if textTable ~= "" then
                    textTable = json.decode(textTable)
                    for k, v in ipairs(textTable) do
                        v.fontSize = fontSize
                    end
                    table.insert(param, textTable)
                end
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_Currency then
                local symbol = LanguageManager:getInstance():getCurrencySymbol()
                textTable.text = symbol..string.format("%.2f", formatParam.contentValue / 100)
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_MonsterId then
                require "app.utils.PlaceholderUtil"
                textTable.text = PlaceholderUtil:parseMonsterById(formatParam.contentValue)
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_PetName then
                textTable.text = ""
                if formatParam.contentValue ~= nil and formatParam.contentValue ~= 0 then
                    textTable.text = LanguageManager:getInstance():getLocalString(checkint(formatParam.contentValue))
                else
                    textTable.text = formatParam.externValue..""
                end
                textTable.color = UI.FONT_COLOR_92_144_249
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_LuckDrawPk then
                textTable.text = ""
                if formatParam.externValue ~= nil and formatParam.externValue ~= "" then
                    textTable.text = formatParam.externValue ..""--string.format(des, formatParam.externValue)
                end
                textTable.color = UI.FONT_COLOR_92_144_249
                table.insert(param, textTable)
            elseif formatParam.formatType == PublicDefine.ContentFormatType.ContentFormatType_BetBoatId then
                textTable.text = ""
                if formatParam.contentValue ~= nil and formatParam.contentValue ~= 0 then
                    textTable.text = mvc.betModel:getBoatName(checkint(formatParam.contentValue))
                end
                textTable.color = UI.FONT_COLOR_92_144_249
                table.insert(param, textTable)
            end
        end
        modeText = AvalonUtil:formartRichTextToArray(fontColor, fontSize, fontName, modeText, param)
        modeText = json.encode(modeText)
        print("modeText2233:", modeText)
    else
        local dataContent = {}
        dataContent.text = modeText
        dataContent.color =  fontColor
        dataContent.fontSize = fontSize
        local temp = {}
        table.insert(temp, dataContent)
        modeText = json.encode(temp)
    end
    return modeText
end

function AvalonUtil.getWebLaunguageByKey(webLaunguageList, key)
    if key == nil or key == 0 then
        return ""
    end
    return webLaunguageList[key] or ""
end

-- 根据道具ID检查道具是否有穿戴相同的装备或者相同类型的装备
-- 返回参数: 1: 是否有穿戴相同类型但是不同ID的装备, 2: 是否有穿戴相同类型的装备, 3: 是否有穿戴相同ID的装备
function AvalonUtil.equipTypesAndDuplicationFilter(itemID)
    -- 检查必须有相同位置装备
    if (not itemID) then return true end
    local GameDataManager = require("app.game.GameDataManager")
    local isWearingSameType = false
    local itemData = GoodsDataManager:createEquipmentForEquipmentID(itemID)
    local wearList = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
    if(itemData == nil or wearList == nil) then 
        return isWearingSameType
    end
    local itemType = itemData:getEquipmentType()
    for i,v in ipairs(wearList) do
        if (v:getEquipmentType() == itemType) then
            if (itemType == PublicDefine.EQUIPMENT_TYPE.Weapon) then
                if (itemData:getWeaponType() == v:getWeaponType()) then
                    isWearingSameType = true
                    break
                end
            else
                isWearingSameType = true
                break
            end
        end
    end

    -- 检查外观不能和身上任何装备ID相同
    local isWearingSameEquip = false
    for i,v in ipairs(wearList) do
        -- if (math.floor(tonumber(v:getGoodsID()) / 10) == math.floor(tonumber(itemData:getGoodsID()) / 10)) then -- 装备ID最后一位和外观无关, 检查穿戴时不判断
        --     isWearingSameEquip = true
        -- end

        if (v:getGoodsID() == itemData:getGoodsID()) then
            isWearingSameEquip = true
        end

    end
    return isWearingSameType and not isWearingSameEquip, isWearingSameType, isWearingSameEquip
end

function AvalonUtil.getCurrencySignFromPriceString(priceString)
    priceString = priceString or ""
    local sign = priceString:gsub("%d", ""):gsub("%.", ""):gsub(",", "")
    return sign
end

function AvalonUtil:handleTRACKBACK(msg)
    local DebugLogLayerUtil = require("app.ui.debugLogLayer.debugLogLayerUtil")
    print("-------------- error ---------------")
    local brief = msg
    local msg = debug.traceback(msg, 3)
    print(msg)
    if string.find(msg,"in function 'require'") then
        require("AppError")
        showAppError()    
    end
    --Testin
    if errTip == false then
        if (device.platform == "ios" or device.platform == "android") then
            local txtLog = ""
            local logData = DebugLogLayerUtil:getInstance():getData()
            for i = 1,#logData do
                txtLog = logData[i].."\n"
            end

            -- 记录崩溃日志信息
            buglyReportLuaException(tostring(brief), msg,false)    
        end
        
    end

    Avalon.Log:record(msg)

    if DEVELOPMENT_MODE then 
        if errTip == false then
            errTip = true;
            gLaError = cc.Label:createWithSystemFont(msg, "Arial", 25)
            gLaError:setPosition(cc.p(0,cc.Director:getInstance():getWinSize().height))
            gLaError:setAnchorPoint(0,1)
            cc.Director:getInstance():getRunningScene():addChild(gLaError,9999999)
            gLaError:setWidth(cc.Director:getInstance():getWinSize().width)
        end
    end

    print("------------------------------------")

    return msg
end

function AvalonUtil:profilerStart()
    if (CAVEOL_TARGET ~= CAVEOL_TARGET_DEVELOPMENT) then
        return
    end

    if not self.profilerInited then
        self.profilerInited = true

        require("profiler") -- Run this once per program only
        function exampleConsolePrint(msg)
            print(msg)
        end
        attachPrintFunction(exampleConsolePrint, true) -- Function and verbose output
    end

    self.profiling = true

    -- 开始收集
    profilerStart()
end

function AvalonUtil:profilerStop()
    if (CAVEOL_TARGET ~= CAVEOL_TARGET_DEVELOPMENT) then
        return
    end

    if not self.profiling then
        return
    end

    -- 结束收集
    profilerStop()
    -- 打印日志
    profilerReport("profiler.log") -- exampleConsolePrint can be called from this

    self.profiling = false
end

-- 返回第几周
--time：2000-1-1到现在的秒数（2000-1-1是星期六）
function AvalonUtil:getWeekNum(time)
    if time <= 0 then
        return 0
    end
    return math.ceil((SECONDS_ONE_DAY * 5 + time) / SECONDS_ONE_WEEK)
end

function AvalonUtil:testPayDelayTime()
    -- if(self._testPayDelayNum == nil) then 
    --     self._testPayDelayNum = 0
    -- end
    -- self._testPayDelayNum = self._testPayDelayNum + 1
    -- if(self._testPayDelayNum > 3) then return end

    -- local startTime = AvalonUtil.getCurrentTime()
    -- -- print("--testPayDelayTime begin", self._testPayDelayNum)
    -- local url = "https://corp-all-all-zs-pay-0000.avalongames.com";
    -- -- url = "https://www.baidu.com";
    -- Net.Helper:sendNormalHttpGet(url, nil,function(response)
    --     local endTime = AvalonUtil.getCurrentTime()
    --     -- print("--testPayDelayTime end", self._testPayDelayNum, endTime - startTime)
    --     Avalon.AWSLogUtil:sendAWSDelayInfo(endTime- startTime, PublicDefine.WebLogS3DelayType.WebLogS3DelayType_Pay)
    --     -- if(self.testPayDelayTime) then
    --     --     self:testPayDelayTime()
    --     -- end
    -- end,function(readyState,status)
    --     Avalon.AWSLogUtil:sendAWSDelayInfo(9999999, PublicDefine.WebLogS3DelayType.WebLogS3DelayType_Pay)
    --     -- if(self.testPayDelayTime) then
    --     --     self:testPayDelayTime()
    --     -- end
    -- end)
end

function AvalonUtil:testCNPayDelayTime()
    -- if(self._testCNPayDelayNum == nil) then 
    --     self._testCNPayDelayNum = 0
    -- end
    -- self._testCNPayDelayNum = self._testCNPayDelayNum + 1
    -- if(self._testCNPayDelayNum > 3) then return end

    -- local startTime = AvalonUtil.getCurrentTime()
    -- -- print("--testCNPayDelayTime begin", self._testCNPayDelayNum)
    -- local url = "https://corp-all-cn-zs-iapverify-0000.avalongames.cn";
    -- -- url = "https://www.baidu.com";
    -- Net.Helper:sendNormalHttpGet(url, nil,function(response)
    --     local endTime = AvalonUtil.getCurrentTime()
    --     -- print("--testCNPayDelayTime end", self._testCNPayDelayNum, endTime - startTime)
    --     Avalon.AWSLogUtil:sendAWSDelayInfo(endTime- startTime, PublicDefine.WebLogS3DelayType.WebLogS3DelayType_CNPay)
    --     -- if(self.testCNPayDelayTime) then
    --     --     self:testCNPayDelayTime()
    --     -- end
    -- end,function(readyState,status)
    --     Avalon.AWSLogUtil:sendAWSDelayInfo(9999999, PublicDefine.WebLogS3DelayType.WebLogS3DelayType_CNPay)
    --     -- if(self.testCNPayDelayTime) then
    --     --     self:testCNPayDelayTime()
    --     -- end
    -- end)
end

function AvalonUtil:getAnimationGrayGLProgramState()
    local vertName = "shaders/PositionTextureTransformGrayColor2.vert"
    local fragName = "shaders/PositionTextureTransformGrayColor2.frag"
    if AvalonUtil.getSpineVersion() < 3060039 then
        vertName = "shaders/PositionTextureTransformGrayColor.vert"
        fragName = "shaders/PositionTextureTransformGrayColor.frag"
    end
    local glProgramState = AvalonUtil:getGLProgramState(vertName, fragName)

    return glProgramState
end

--[[
    根据资源名字获取GLProgram
    shadersVertName:  "shaders/PositionTextureTransformGrayColor2.vert"
    shadersFragName:  "shaders/PositionTextureTransformGrayColor2.frag"
    normalKey:用于缓存的key,一般情况下为nil,如果指定就用指定的key 
]]
function AvalonUtil:getGLProgram(shadersVertName, shadersFragName, normalKey)
    local programKey = normalKey
    if(programKey == nil) then
        programKey = self:_makeGLProgramKey(shadersVertName, shadersFragName)
    end
    local glProgram = cc.GLProgramCache:getInstance():getGLProgram(programKey)
    -- print("getGLProgram", programKey, shadersVertName, shadersFragName)
    -- if(programKey == nil or programKey == "") then 
    --     print(debug.traceback())
    -- end
    if(not glProgram) then 
        glProgram = cc.GLProgram:createWithFilenames(shadersVertName, shadersFragName)
        if(glProgram)then 
            -- print("getGLProgram addGLProgram", programKey)
            cc.GLProgramCache:getInstance():addGLProgram(glProgram, programKey)
        end
    end

    return glProgram
end
--[[
    根据资源名字获取GLProgramState
    shadersVertName:  "shaders/PositionTextureTransformGrayColor2.vert"
    shadersFragName:  "shaders/PositionTextureTransformGrayColor2.frag"
    normalKey:用于缓存的key,一般情况下为nil,如果指定就用指定的key 
]]
function AvalonUtil:getGLProgramState(shadersVertName, shadersFragName, normalKey)
    local glProgramState = nil
    -- print("getGLProgramState", AvalonUtil.getSpineVersion(), shadersVertName, shadersFragName)
    local glProgram = self:getGLProgram(shadersVertName, shadersFragName, normalKey)
    if(glProgram) then
        glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    end

    return glProgramState
end

function AvalonUtil:_makeGLProgramKeyForColor(shadersVertName, shadersFragName, color)
    local key = shadersVertName..shadersFragName
    if(color and color.x and color.y and color.z and color.w) then 
        key = key.."x="..color.x.."y="..color.y.."z="..color.z.."w="..color.w
    end
    return key
end

function AvalonUtil:_makeGLProgramKey(shadersVertName, shadersFragName)
    return shadersVertName..shadersFragName
end


function AvalonUtil:wasGlobalIos()
    if device.platform == "ios" and CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then 
        return true
    end

    return false
end

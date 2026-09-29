cc.FileUtils:getInstance():addSearchPath("../../../../../src")
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")
cc.FileUtils:getInstance():addSearchPath("res/Resource")

require "app.utils.UserDefaultSyncHelper"
UserDefaultSyncHelper:setUserDefaultSyncFilter()

require "utils.Macros"
require "utils.AvalonUtil"
require "utils.reload"

-- require("LuaPanda").start("127.0.0.1",8818)

function init()
    -- 初始化target 等参数
    CAVEOL_TARGET = AvalonUtil.getCaveOnlineTarget()
    if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        -- 开发模式
        DEVELOPMENT_MODE = true
    else
        DEVELOPMENT_MODE = false
    end
end
init()

-- 屏蔽梦境模式功能  true 表示屏蔽， false 或nil 表示不屏蔽
SHEILD_DREAM_FLAG = false
-- 是否打开分享功能
CONFIG_SHARE = true
-- 是否开启引导评论
CONFIG_COMMENT = true
if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) then
    CONFIG_SHARE = false 
    CONFIG_COMMENT = false
end



-- 是否开启语音
CONFIG_VOICECHAT = true
-- if (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) then
--     CONFIG_VOICECHAT = false
-- end
CONFIG_FIRST_PASS = false


require "config"
require "CaveOnline"
require "cocos.init"
require "app.game.GameDefine"
require "app.audio.AudioManager"
-- require "thirdparty.MobClickForLua"
-- 修改帧率
cc.Director:getInstance():setAnimationInterval(1/CONFIG_FPS)
-- cc.Director:getInstance():setDisplayStats(true)
-- require("LuaPanda").start("127.0.0.1",8818)
local DebugLogLayerUtil = require("app.ui.debugLogLayer.debugLogLayerUtil")
-- 扩展table 清空函数
if table then
    if table.clear == nil then
        table.clear = function(list)
            -- 实现移除方法
            if list and type(list) == "table" then
                -- for i= #list,1,-1 do
                --     table.remove(list,i)
                -- end
                for index, item in pairs(list) do
                    list[index] = nil
                end
            end
        end
    end

    if(table.unpack == nil) then 
        table.unpack = function(t, i)
            i = i or 1
            if t[i] ~= nil then
                return t[i], table.unpack(t, i + 1)
            end
        end
    end
else
    assert(false,"table not define.")
end

--关闭bugly,
if (CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL and cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_ANDROID) then
    buglyReportLuaException = function()
        -- print("---buglyReportLuaException-----")
    end

    buglyLog = function()
        -- print("---buglyLog-----")
    end
end

-- 调试模式 - 主城压力测试
DEVELOPMENT_TOWN_PRESSURE = false

errTip = false

math.newrandomseed()


function print(...)
    -- if DEVELOPMENT_MODE then

        luaPrint(...)

        if errTip == false then
            local txt = DebugLogLayerUtil:getInstance():addData(...)
        end
    -- end

    local SdkBox = require("utils.sdkbox.SdkBox")
    require "app.datas.PublicDefine"
    local versionTarget = SdkBox:getInstance():getVersionTarget()
    if (device.platform == "ios" or 
            (device.platform == "android" and 
            (not versionTarget or versionTarget ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL))
    ) then
        local tab = {...}
        local txt = ""
        for i = 1,#tab do
            if i == 1 then
                txt = tostring(tab[i])
            else
                txt = txt.."  "..tostring(tab[i])
            end
            
        end
        
        if (device.platform ~= "android" or SdkBox:getInstance():getSDKIsInit()) then
            txt = string.gsub(txt,"%%","*")
            buglyLog(5,"CaveOnline",txt)
        end
        
    end
end

function assert(cond,msg)
    if not cond then
        local trace = debug.traceback(msg, 2)
        printLog("ERR",trace)
        if (device.platform == "ios" or device.platform == "android") then
            if buglyReportLuaException then
                buglyReportLuaException(tostring(msg), trace,false)  
            end
        end
    end
    return cond
end
function main()
    -- add by zp 这里把加载脚本拆分为多帧,用于解决anr 问题
    local loadScrit = true
    local updateHandler = nil
    local asynLoadScrit = function(dt)
        if(loadScrit) then
            loadScrit = false
            --友盟
            -- if (device.platform == "ios") then
            --     MobClickForLua.startMobclick("591d7536f5ade4111700002f","test");
            -- end
            require "app.ui.HWBtnComponent"
            require "app.game.GameManager"
            -- 开始游戏
            -- Game.Manager:startGame()
            -- by CMonk, 机器人总开关
            require "utils.auto.Robot"
        else 
            if (updateHandler) then
                local scheduler = cc.Director:getInstance():getScheduler()
                scheduler:unscheduleScriptEntry(updateHandler)
                updateHandler = nil
            end

            if (Auto and Auto.Robot and Auto.Robot:on()) then else
                local SdkBox = require("utils.sdkbox.SdkBox")
                if (CAVEOL_TARGET_CN == CAVEOL_TARGET or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE) and device.platform == "android" and SdkBox:getInstance():isSupportPrivacy() then
                    SdkBox:getInstance():init()
                else
                    Game.Manager:enterSplash()
                end
            end
            
            local maxTextureSize = AvalonUtil.getGlMaxTextureSize()
            if(maxTextureSize > 4096 and maxTextureSize ~= 0) then 
                -- buglyReportLuaException("These devices support 8192 textures", AvalonUtil.getDeviceName().. AvalonUtil.getSystemVersion()..maxTextureSize)
            end
            if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL and avalon.Util.stopWatchdogDaemon then
                avalon.Util:stopWatchdogDaemon()
            end
        end
    end

    local scheduler = cc.Director:getInstance():getScheduler()
    updateHandler = scheduler:scheduleScriptFunc(asynLoadScrit, 0.0, false)
end

local oldSetSpriteFrame = cc.Sprite.setSpriteFrame
local oldSetDimensions = cc.Label.setDimensions

function cc.Sprite:setSpriteFrame(fileName)
    if not fileName then
        printError("Sprite:setSpriteFrame invalid fileName",fileName)
        return
    end
    if type(fileName) == "string" then
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrameByName(fileName)
        if(frame) then
            oldSetSpriteFrame(self, fileName)
        else
            printError("setSpriteFrame no found spriteFrameCache=",fileName)
        end
    elseif type(fileName) == "userdata" then
        oldSetSpriteFrame(self,fileName)
    else
        printError("Sprite:setSpriteFrame invalid fileName",fileName)
    end
end

function cc.Label:setDimensions(width, height)
    if width ~= nil and height ~= nil then
        oldSetDimensions(self, width, height)
        self:autoUpdateAlignment();
    end
end

function cc.Label:autoUpdateAlignment()
    local size = self:getDimensions();
    if size.width > 0 and size.height == 0 then
        local contentSize = self:getContentSize();
        print("autoUpdateAlignment:", contentSize.width, size.width, self.name)
        if contentSize.width < size.width then
            self:setAlignment(0, self:getVerticalAlignment())
        else
            self:setAlignment(1, self:getVerticalAlignment())
        end
    end
end

__G__TRACKBACK__ = function(msg)
    return AvalonUtil:handleTRACKBACK(msg)
end

collectgarbage("setpause", 200)  
collectgarbage("setstepmul", 5000) 

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    
    print("-------------- main crash ---------------")
    print(msg)
    print("------------------------------------")
    require "app.game.GameManager"
    -- 记录崩溃日志信息
    Avalon.Log:record(msg)
        -- 销毁
    Game.Manager:destroyModules()
end
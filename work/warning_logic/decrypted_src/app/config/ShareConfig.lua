--
-- Author: Your Name
-- Date: 2017-10-27 21:23:14
--

local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
Config = Config or {}

local ShareConfig = {}
Config.ShareConfig = ShareConfig 


-- 缓存效果配置数据
local ShareConfigAttrDataCache = nil
function ShareConfig:getAllShareConfig()
    -- 获取所有技能
    if (not ShareConfigAttrDataCache) then
        ShareConfigAttrDataCache = {}
    	local temp = require("profiles/commonProfile/ProfileShare")
        for k, v in pairs(temp) do
            if type(v) == "table" then
                table.insert(ShareConfigAttrDataCache, v)
            end
        end
    end
    return ShareConfigAttrDataCache
end

-- 清理
function ShareConfig:clear()
	reload_script_file("profiles/commonProfile/ProfileShare")
    ShareConfigAttrDataCache = nil
end

--暂时不区分sdkType， 每个sdkType 分享的内容一样（优先判断分析图片 + 文字， 其次判断分享 图片 ，再其次分享文本）
function ShareConfig:getShareConfigByType(moduleType,sdkType)
    require("app.utils.ServerConfigUtil")
    local all = self:getAllShareConfig()

    local target = SdkBox:getInstance():getVersionTarget()
    local platForm = SdkBox:getInstance():getVersionPlatform()
    local channel = SdkBox:getInstance():getVersionChannel()
    local deviceTarget = cc.Application:getInstance():getTargetPlatform()
    if deviceTarget == cc.PLATFORM_OS_WINDOWS or deviceTarget == cc.PLATFORM_OS_MAC then
        target = 3 
        platForm = PublicDefine.VERSION_PLATFORM.VERSION_PLATFORM_ANDROID 
        channel = 0
    end

    local data = nil
    local defaultData = nil
    for k, v in pairs(all) do
        if target == v.target and platForm == v.platform and moduleType == sharetype and v.channel == channel then
            data = v
        end
        if target == v.target and platForm == v.platform and moduleType == v.sharetype and v.channel == 0 then
            defaultData = v
        end
    end
    if data == nil and defaultData ~= nil then
        data = defaultData
    end
    if data == nil then
        printWarn("----!!!!error!!!!--------   shareData is null ", target, platForm, channel, moduleType, sdkType)
    end
    return data;
end
-- 根据任务ID获取任务数据
function ShareConfig:getShareConfig(id)
    local all = self:getAllShareConfig()

    local cfg = all[id]

    return cfg
end
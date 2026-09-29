require "app.game.GameDefine"

UserDefaultSyncHelper = {}

local USER_DEFAULTS_ICLOUD_SYNC_PREFIX = "COSync_" --这里和底层AppController.mm里初始化MKiCloudSync时用的前缀必须一样, 否则不能同步至iCloud
local USER_DEFAULTS_PREFIX = "CO_"
local UserDefaultOriginals = {}

function UserDefaultSyncHelper:filterUserDefaultsKey(key)
    -- 这里通过key来判断需要同步到iCloud的值
    if (key == UserDefaultKeyWord.musicVolume or 
        key == UserDefaultKeyWord.soundsVolume or 
        key == UserDefaultKeyWord.musicVolumeForDisplay or 
        key == UserDefaultKeyWord.soundsVolumeForDisplay or 
        key == UserDefaultKeyWord.PunishmentState or 
        key == UserDefaultKeyWord.PunishmentTime or 
        key == UserDefaultKeyWord.moveType or 
        key == UserDefaultKeyWord.showType or 
        key == UserDefaultKeyWord.CommentSuccess or 
        key == UserDefaultKeyWord.LastShowArhMode or 
        key == UserDefaultKeyWord.LoginNoticeLastShowTime
        -- key == "shieldChat" or                   -- 不同步, 避免造成玩家混乱增加客服压力
        -- key == UserDefaultKeyWord.fpsMode or     -- 不同步, 避免造成玩家混乱增加客服压力
        -- key == UserDefaultKeyWord.oldLanguage or -- 不同步, 需要重新启动游戏, 体验差
        -- key == UserDefaultKeyWord.language or    -- 不同步, 需要重新启动游戏, 体验差
        -- key == UserDefaultKeyWord.fpsToast or    -- 不需要同步
        -- key == UserDefaultKeyWord.InStoryLastKillerIsBoss or -- 不需要同步
    ) then
        return USER_DEFAULTS_ICLOUD_SYNC_PREFIX .. key
    else
        return USER_DEFAULTS_PREFIX .. key
    end
end

-- 设置iCloud上传过滤
function UserDefaultSyncHelper:setUserDefaultSyncFilter()
    -- userDefaults添加前缀, 好做iCloud同步. addUserDefaultsPrefix中处理不需要同步的key
    UserDefaultOriginals.setFloatForKey = cc.UserDefault.setFloatForKey
    cc.UserDefault.setFloatForKey = function(userDefaultInstance, key, value) return UserDefaultOriginals.setFloatForKey(userDefaultInstance, self:filterUserDefaultsKey(key), value) end
    UserDefaultOriginals.setBoolForKey = cc.UserDefault.setBoolForKey
    cc.UserDefault.setBoolForKey = function(userDefaultInstance, key, value) return UserDefaultOriginals.setBoolForKey(userDefaultInstance, self:filterUserDefaultsKey(key), value) end
    UserDefaultOriginals.setDoubleForKey = cc.UserDefault.setDoubleForKey
    cc.UserDefault.setDoubleForKey = function(userDefaultInstance, key, value) return UserDefaultOriginals.setDoubleForKey(userDefaultInstance, self:filterUserDefaultsKey(key), value) end
    UserDefaultOriginals.setStringForKey = cc.UserDefault.setStringForKey
    cc.UserDefault.setStringForKey = function(userDefaultInstance, key, value) return UserDefaultOriginals.setStringForKey(userDefaultInstance, self:filterUserDefaultsKey(key), value) end
    UserDefaultOriginals.setIntegerForKey = cc.UserDefault.setIntegerForKey
    cc.UserDefault.setIntegerForKey = function(userDefaultInstance, key, value) return UserDefaultOriginals.setIntegerForKey(userDefaultInstance, self:filterUserDefaultsKey(key), value) end
    UserDefaultOriginals.getFloatForKey = cc.UserDefault.getFloatForKey
    cc.UserDefault.getFloatForKey = function(userDefaultInstance, key, default) return UserDefaultOriginals.getFloatForKey(userDefaultInstance, self:filterUserDefaultsKey(key), default) end
    UserDefaultOriginals.getBoolForKey = cc.UserDefault.getBoolForKey
    cc.UserDefault.getBoolForKey = function(userDefaultInstance, key, default) return UserDefaultOriginals.getBoolForKey(userDefaultInstance, self:filterUserDefaultsKey(key), default) end
    UserDefaultOriginals.getDoubleForKey = cc.UserDefault.getDoubleForKey
    cc.UserDefault.getDoubleForKey = function(userDefaultInstance, key, default) return UserDefaultOriginals.getDoubleForKey(userDefaultInstance, self:filterUserDefaultsKey(key), default) end
    UserDefaultOriginals.getStringForKey = cc.UserDefault.getStringForKey
    cc.UserDefault.getStringForKey = function(userDefaultInstance, key, default) return UserDefaultOriginals.getStringForKey(userDefaultInstance, self:filterUserDefaultsKey(key), default) end
    UserDefaultOriginals.getIntegerForKey = cc.UserDefault.getIntegerForKey
    cc.UserDefault.getIntegerForKey = function(userDefaultInstance, key, default) return UserDefaultOriginals.getIntegerForKey(userDefaultInstance, self:filterUserDefaultsKey(key), default) end
end
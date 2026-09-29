-- lua端配置宏定义,C++端是define.h文件
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 0

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- show FPS on screen
CC_SHOW_FPS = true

-- disable create unexpected global variable
CC_DISABLE_GLOBAL = false

CONFIG_SCREEN_WIDTH = 1136

CONFIG_SCREEN_HEIGHT = 640

CONFIG_ACTUAL_WIDTH = CONFIG_SCREEN_WIDTH

CONFIG_ACTUAL_HEIGHT = CONFIG_SCREEN_HEIGHT

-- for module display
CC_DESIGN_RESOLUTION = {
    width = 1136,
    height = 640,
    autoscale = "FIXED_HEIGHT",
    callback = function(framesize)
        -- local ratio = framesize.width / framesize.height
        -- if ratio <= 1.34 then
        --     -- iPad 768*1024(1536*2048) is 4:3 screen
        --     return {autoscale = "FIXED_WIDTH"}
        -- end
        CONFIG_ACTUAL_WIDTH = framesize.width
        CONFIG_ACTUAL_HEIGHT = framesize.height

        -- 分辨率适配
        local configs = {}
        configs.width = 1136
        configs.height = 640
        if framesize.width / framesize.height >= CONFIG_SCREEN_WIDTH / CONFIG_SCREEN_HEIGHT then
            configs.autoscale = "FIXED_HEIGHT"
        else
            configs.autoscale = "FIXED_WIDTH"
        end
        return configs
    end
}

-- 初始化初始化逻辑
PB_LOGIN_FILES = {
    "pb/public_define.pb",
    "pb/login_system.pb",
}

-- 包含游戏中需要加载的pb 文件列表
PB_ALL_FILES = {
    "pb/goods_system.pb",
    "pb/NPC_system.pb",
    "pb/role_system.pb",
    "pb/team_system.pb",
    "pb/task_system.pb",
    "pb/treasureMap_system.pb",
    "pb/gm_system.pb",
    "pb/guild_system.pb",
    "pb/chat_system.pb",
    "pb/pet_system.pb",
    "pb/friend_system.pb",
    "pb/mail_system.pb",
    "pb/purchase_system.pb",
    "pb/activity_system.pb",
	"pb/tutor_system.pb",
    "pb/logic_system.pb",
    "pb/play_system.pb",
    "pb/rank_system.pb",
    "pb/manor_system.pb",
    "pb/bigSail_system.pb",
}

-- host
-- if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
--     SERVER_CONFIG_URL = "http://cave2-all-local-cs-login-0000.avalongames.cn"
--     WEB_MD5_KEY = "avalon" 
-- elseif CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
--     SERVER_CONFIG_URL = "http://106.15.49.119:14000"
--     WEB_MD5_KEY = "avalon" 
-- elseif CAVEOL_TARGET == CAVEOL_TARGET_CN then
--     SERVER_CONFIG_URL = "http://106.15.49.119:14000"
--     WEB_MD5_KEY = "avalon" 
-- else 
--     assert(false, string.format("[ERROR ] no handle target=%d", CAVEOL_TARGET))
-- end

--[[
    游戏管理器
    -- 场景切换管理
    -- 玩家状态数据
    -- 战斗时间戳
]]--
local SdkBox = require("utils.sdkbox.SdkBox")
require "app.game.GameDefine"
require "utils.MathUtil"
require "utils.AvalonUtil"
require "utils.FileManager"
require "utils.userdata.UserDataManager"
require "utils.message.MessageCenter"
require "utils.Scheduler"
require "utils.log.AvalonLog"
-- 初始化网络助手
require "utils.net.NetHelper"
require "utils.log.AWSLogUtil"
require "app.system.redpoint.RedPointManager"
if not json then
    require "cocos.cocos2d.json"
end

-- require "app.config.FontManager"

Game = Game or {}

local Manager = {}
Game.Manager = Manager
GameManager = Game.Manager

local SceneManager = require("app.game.SceneManager")

local DEBUG = true

-- private:
-- 服务器对时时间戳
local server_timestamp = 0
local Local_timestamp = AvalonUtil.getCurrentTime()
-- 记录客户端发起对时的时间
local local_requestTimestamp = 0
-- 记录客户端通信最好收到回复的时间
local local_goodAnswerTimestamp = 0
-- 记录当前时间差最小的服务器时间
local server_goodTimestamp = 0
-- 最小的时差
local goodTimeDifference = nil

-- 记录服务器最后对时完成时服务器时间
local sync_end_serverTime = 0
-- 记录服务器最后对时完成时客户端得时间
local sync_end_localTime = 0

-- 记录服务器与零时区差值
local sync_differ_Area = 0

-- 存储是否初始化相关的数据
local INIT_BASE = false
local INIT_LOGIN = false
local INIT_GAME = false
-- 是否已经显示过免责声明
local showDisclaimer = false
-- 倒计时控制开关，这里为了和服务器计算保持相对的一致 true 标识服务器在倒计时，false 服务器没有计算倒计时，这里根据消息来同步消息
local COUNT_DOWN_SWITCH = false
-- 清理command
function Manager:clearCommandList(commandList, clean)
    if (not clean) then
        clean = false
    end

    for i = 1, #commandList do
        local command = commandList[i]
        if (clean) then
            command:destroy()
        end
        commandList[i] = nil
    end
end

local GAME_COMMON_SPINE_RES_LIST = {
    "role_hero_1.json", ToolsUtil:getHeroAtlas(), Game.HERO_ANIMATION_SCALE,
    "role_hero_2.json", ToolsUtil:getHeroAtlas(), Game.HERO_ANIMATION_SCALE,
    -- "effect_ui_package_task_achievements_cup.json", "effect_ui_package_task_achievements_cup.atlas", 1,
}

local GAME_COMMON_UI_RES_PLISTS = {
    "ui_common_grid.plist",
    "ui_package.plist",
    "ui_package_role.plist",
    "ui_common_symbol.plist",
    "ui_general_character.plist",
    "ui_common_btn.plist",
    "ui_common_scale9image.plist",
    "ui_bg_paper3.plist",
    "ui_town_upgrade.plist",
    "ui_general_itemInfo.plist",
    "ui_common_information.plist",
    "ui_common_monsterhead.plist",
    "ui_package_task.plist",
    "ui_common_icon_equip.plist",
    "ui_general_tips.plist",
    "ui_gaming_battle.plist",
    "ui_gaming_quickPanel.plist",
    "ui_gaming_info.plist",
    "ui_gaming_playerstate.plist",
    "ui_common_icon_item.plist",
    "ui_common_icon_equipment.plist",
    "ui_common_icon_material.plist",
    "ui_common_icon_starpray.plist",
    "ui_common_icon_skill.plist",
    "ui_common_icon_gemstone.plist",
    "ui_common_icon_petsgemstone.plist",
    "ui_common_goods.plist",
    "ui_common_icon_operation.plist",
    "ui_common_functionIcon.plist",
    "ui_general_signal.plist", -- 延迟和信号
    "ui_general_signal.plist",
    "ui_general_minimap_icon.plist",
    "ui_common_pethead.plist",
    "ui_package_pets.plist",
    "ui_town_manor.plist",
}
-- 可选预加载资源
local GAME_OPTIONAL_UI_RES_PLISTS = {
    "ui_town_guild_icon.plist",
    "ui_town_guild_general.plist",
    "ui_town_guild_management.plist",
    "ui_town_guild_giftbox.plist",
    "ui_general_shopping.plist",
    "ui_town_guild_writ.plist",
}


-- public:
-- 初始化
function Manager:init()
    server_timestamp = 0
    Local_timestamp = AvalonUtil.getCurrentTime()

    require "app.datas.SkillDataManager"
    require "app.datas.GoodsDataManager"
    require "app.datas.TeamDataManager"
    require "app.datas.TaskDataManager"
    require "app.datas.PictureAlbumManager"

    require "app.datas.FriendDataManager"
    require "app.game.ChatManager"
    require "app.datas.MailDataManager"
    require "app.utils.ShareUtil"

    require "app.game.GameSetting"
    
    local MachineManager = require("app.game.MachineManager")
    MachineManager:getInstance():setMachine(nil);
    self._isLoadingData = false
    self._isLoadingRes = false
    self._loadingLayer = nil

    require "app.net.NetRoleSystem"
    require "app.net.NetGoodsSystem"
    require "app.net.NetNPCSystem"
    require "app.net.NetTeamSystem"
    require "app.net.NetTaskSystem"
    require "app.net.NetTreasureMapSystem"
    require "app.net.NetGMSystem"
    require "app.net.NetGuildSystem"
    require "app.net.NetChatSystem"
    require "app.net.NetRankSystem"
    require "app.net.NetFriendSystem"
    require "app.net.NetMailSystem"
    require "app.net.NetPurchaseSystem"
    require "app.net.NetActivitySystem"
	require "app.net.NetMentorSystem"
    require "app.net.NetLogicSystem"
    require "app.net.NetPetSystem"
    require "app.net.NetPlaySystem"
    require "app.net.NetManorSystem"
    require "app.net.NetBigSailSystem"

    Net.Helper:register(NetMessageCategory.ROLE, Net.NetRoleSystem, Net.NetRoleSystem.onRoleMessageHandler)
    Net.Helper:register(NetMessageCategory.GOODS, Net.NetGoodsSystem, Net.NetGoodsSystem.onGoodsMessageHandler)
    Net.Helper:register(NetMessageCategory.NPC, Net.NetNPCSystem, Net.NetNPCSystem.onNPCMessageHandler)
    Net.Helper:register(NetMessageCategory.TEAM, Net.NetTeamSystem, Net.NetTeamSystem.onTeamMessageHandler)
    Net.Helper:register(NetMessageCategory.TASK, Net.NetTaskSystem, Net.NetTaskSystem.onTaskMessageHandler)
    Net.Helper:register(NetMessageCategory.TREASUREMAP, Net.NetTreasureMapSystem, Net.NetTreasureMapSystem.onTreasureMapMessageHandler)
    Net.Helper:register(NetMessageCategory.GM, Net.NetGMSystem, Net.NetGMSystem.onGMMessageHandler)
    Net.Helper:register(NetMessageCategory.GUILD, Net.NetGuildSystem, Net.NetGuildSystem.onGuildMessageHandler)
    Net.Helper:register(NetMessageCategory.CHAT, Net.NetChatSystem, Net.NetChatSystem.onChatMessageHandler)
    Net.Helper:register(NetMessageCategory.RANK, Net.NetRankSystem, Net.NetRankSystem.onRankMessageHandler)
    Net.Helper:register(NetMessageCategory.FRIEND, Net.NetFriendSystem, Net.NetFriendSystem.onFriendMessageHandler)
    Net.Helper:register(NetMessageCategory.MAIL, Net.NetMailSystem, Net.NetMailSystem.onMailMessageHandler)
    Net.Helper:register(NetMessageCategory.PURCHASE, Net.NetPurchaseSystem, Net.NetPurchaseSystem.onPurchaseMessageHandler)
    Net.Helper:register(NetMessageCategory.ACTIVITY, Net.NetActivitySystem, Net.NetActivitySystem.onActivityMessageHandler)
	Net.Helper:register(NetMessageCategory.MENTOR, Net.NetMentorSystem, Net.NetMentorSystem.onMentorMessageHandler)
    Net.Helper:register(NetMessageCategory.LOGIC, Net.NetLogicSystem, Net.NetLogicSystem.onLogicMessageHandler)
    Net.Helper:register(NetMessageCategory.PET, Net.NetPetSystem, Net.NetPetSystem.onPetMessageHandler)
    Net.Helper:register(NetMessageCategory.PLAY, Net.NetPlaySystem, Net.NetPlaySystem.onPlayMessageHandler)
    Net.Helper:register(NetMessageCategory.MANOR, Net.NetManorSystem, Net.NetManorSystem.onManorMessageHandler)
    Net.Helper:register(NetMessageCategory.BIGSAIL, Net.NetBigSailSystem, Net.NetBigSailSystem.onBigSailMessageHandler)
    
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.MonsterIsGod, 0)
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.HeroIsGod, 0)
    print("GameManager: init game manager.")


    --大秘境倒计时
    self._dungeonCountDown = 100            --倒计时,-1为已结束,0为关闭
local scheduler=cc.Director:getInstance():getScheduler()
    self.mSchedulerID = scheduler:scheduleScriptFunc(handler(self,self.schedulerTimeOut),1,false)

    
    -- 注册富文本点击
    -- self:registerRichLinkClickCallBack()

    self._isResLoading = false
    self._isLockQuestionNaire = false

    self.lockLoadAdsTips = nil
    self.lockLoadAdsTips2 = nil
end

function Manager:getDungeonCountDown()
    return self._dungeonCountDown
end

function Manager:setDungeonCountDown(var)
    self._dungeonCountDown = var
    Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_UPDATE_DUNGEON_COUNT_DOWN)
end

function Manager:schedulerTimeOut(dt)
    local old = self._dungeonCountDown
    self._dungeonCountDown = self._dungeonCountDown - dt;
    if(old >0 and self._dungeonCountDown <=0) then 
        -- 第%d 层已经关闭
        if SceneManager:getInstance():isInDungeon() then 
            local MachineManager = require("app.game.MachineManager")
            local machine = MachineManager:getInstance():getMachine()
            if(machine) then
                local model = machine:getModel()
                if(model) then 
                    local mapData = model:getMapData()
                    if mapData then 
                        local level = mapData:getLevel()
                        -- print("Manager:schedulerTimeOut level", level)
                        local bossLevel = (math.floor((level - 1) /5) +1) * 5
                        local LanguageManager = require("app.game.LanguageManager")
                        -- print("Manager:schedulerTimeOut bossLevel", bossLevel)
                        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, string.format(LanguageManager:getInstance():getLocalString(1230046), bossLevel))
                    end
                end
            end

        end
    end
    if self._dungeonCountDown <= -1000 then
        self._dungeonCountDown = -1000
    end
end

-- 销毁
function Manager:destroy()
    if (SceneManager:getInstance()._state == GameState.IN_CAVE) then
        local GameInCaveManager = require "app.game.GameInCaveManager"
        GameInCaveManager:getInstance():exitCave()
    end
    Net.Helper:unregister(NetMessageCategory.ROLE, Net.NetRoleSystem, Net.NetRoleSystem.onRoleMessageHandler)
    Net.Helper:unregister(NetMessageCategory.GOODS, Net.NetGoodsSystem, Net.NetGoodsSystem.onGoodsMessageHandler)
    Net.Helper:unregister(NetMessageCategory.NPC, Net.NetNPCSystem, Net.NetNPCSystem.onNPCMessageHandler)
    Net.Helper:unregister(NetMessageCategory.TEAM, Net.NetTeamSystem, Net.NetTeamSystem.onTeamMessageHandler)
    Net.Helper:unregister(NetMessageCategory.TASK, Net.NetTaskSystem, Net.NetTaskSystem.onTaskMessageHandler)
    Net.Helper:unregister(NetMessageCategory.TREASUREMAP, Net.NetTreasureMapSystem, Net.NetTreasureMapSystem.onTreasureMapMessageHandler)
    Net.Helper:unregister(NetMessageCategory.GM, Net.NetGMSystem, Net.NetGMSystem.onGMMessageHandler)
    Net.Helper:unregister(NetMessageCategory.GUILD, Net.NetGuildSystem, Net.NetGuildSystem.onGuildMessageHandler)
    Net.Helper:unregister(NetMessageCategory.CHAT, Net.NetChatSystem, Net.NetChatSystem.onChatMessageHandler)
    Net.Helper:unregister(NetMessageCategory.RANK, Net.NetRankSystem, Net.NetRankSystem.onRankMessageHandler)
    Net.Helper:unregister(NetMessageCategory.FRIENT, Net.NetFriendSystem, Net.NetFriendSystem.onFriendMessageHandler)
    Net.Helper:unregister(NetMessageCategory.MAIL, Net.NetMailSystem, Net.NetMailSystem.onMailMessageHandler)
    Net.Helper:unregister(NetMessageCategory.PURCHASE, Net.NetPurchaseSystem, Net.NetPurchaseSystem.onPurchaseMessageHandler)
    Net.Helper:unregister(NetMessageCategory.ACTIVITY, Net.NetActivitySystem, Net.NetActivitySystem.onActivityMessageHandler)
    Net.Helper:unregister(NetMessageCategory.MENTOR, Net.NetMentorSystem, Net.NetMentorSystem.onMentorMessageHandler)
    Net.Helper:unregister(NetMessageCategory.LOGIC, Net.NetLogicSystem, Net.NetLogicSystem.onLogicMessageHandler)
    Net.Helper:unregister(NetMessageCategory.PET, Net.NetPetSystem, Net.NetPetSystem.onPetMessageHandler)
    Net.Helper:unregister(NetMessageCategory.PLAY, Net.NetPlaySystem, Net.NetPlaySystem.onPlayMessageHandler)
    Net.Helper:unregister(NetMessageCategory.MANOR, Net.NetManorSystem, Net.NetManorSystem.onManorMessageHandler)
    Net.Helper:unregister(NetMessageCategory.BIGSAIL, Net.NetBigSailSystem, Net.NetBigSailSystem.onBigSailMessageHandler)

    print("GameManager: destroy game manager.")
end


function Manager:initBaseModules()
    if(INIT_BASE == false) then
        print("Manager:initBaseModules")
        require("utils.HotfixManager")
        -- 初始化文件管理器
        Avalon.FileManager:init()
        -- 日志系统
        Avalon.Log:init()
        -- 计时器
        Avalon.Scheduler:init()
        --初始化多语言所对应的资源路径searchpaths
        local LanguageManager = require("app.game.LanguageManager")
        LanguageManager:getInstance()
        -- 用户数据管理器初始化
        Avalon.UserDataManager:init()
        -- 资源助手
        require "utils.res.ResHelper"
        Avalon.ResHelper:init()
        -- 注册lua回调函数
        avalon.Util.registerLuaCallback(handler(self,Game.Manager.onGameExit), handler(self,Game.Manager.onGameActive), handler(self,Game.Manager.onGameInactive))

        -- 初始化pb注册
        local ProtobufUtil = require "utils.ProtobufUtil"
        ProtobufUtil:registerFiles(PB_LOGIN_FILES)
        require "app.datas.PublicDefine"
        PublicDefine:init()
        
        --配置表
        require "app.config.ConfigManager"
        ConfigManager:initConfig()

        -- UI管理器
        require "app.ui.UIManager"
        UI.UIManager:init()

        INIT_BASE = true
    end
end

function Manager:initLoginModules()
    if(INIT_LOGIN == false) then
        print("Manager:initLoginModules")


        Net.Helper:init()
        Net.initMessageNo(Net.InitMessageType.InitMessageType_Login)

        require "app.net.NetInnerSystem"
        require "app.net.NetLoginSystem"
        Net.Helper:register(NetMessageCategory.INNER, Net.NetInnerSystem, Net.NetInnerSystem.onInnerMessageHandler)
        Net.Helper:register(NetMessageCategory.LOGIN, Net.NetLoginSystem, Net.NetLoginSystem.onLoginMessageHandler)

        Net.Helper:register(NetMessageCategory.INNER2, Net.NetInnerSystem, Net.NetInnerSystem.onInnerMessageHandler)
        Net.Helper:register(NetMessageCategory.INNER3, Net.NetInnerSystem, Net.NetInnerSystem.onInnerMessageHandler)
        
        
        require "app.datas.RoleDataManager"
        require "app.datas.GoodsDataManager"
        require "app.game.GameClientMessageManager"
        require "utils.Animation.AvalonAnimation"
        require "app.game.RoleBehaviorManager"

        INIT_LOGIN = true
    end
end

-- 初始化所有功能模块
function Manager:initGameModules()
    require "app.mvc.core.MVCInit"
    mvc.initFramework()

    if(INIT_GAME == false) then
        

        if(UI and UI.UIManager and UI.UIManager:getRootNode()) then 
            mvc.panelMonitor:setMainLayer(UI.UIManager:getRootNode())
        end

        print("Manager:initGameModules")
        -- 初始化pb注册
        local ProtobufUtil = require "utils.ProtobufUtil"
        ProtobufUtil:registerFiles(PB_ALL_FILES);
        Net.initMessageNo(Net.InitMessageType.InitMessageType_Game)
        
        self:init()

        INIT_GAME = true
    end
    local SdkManager = require "app.game.SdkManager"
    SdkManager:getInstance():init();
    
    require "app.utils.ImageDownLoadUtil"
    ImageDownLoadUtil:getBannerInfoList()
end

-- 销毁所有功能模块
function Manager:destroyModules()
    print("Game: destroy all the modules.")

    -- Game.Manager:destroy()
    -- UI.UIManager:destryUI()
    if(Net.Helper) then
        Net.Helper:destroy()
    end
    if(Avalon.Scheduler) then
        Avalon.Scheduler:destroy()
    end
    if(Avalon.UserDataManager) then
        Avalon.UserDataManager:destroy()
    end
    if(Avalon.ResHelper) then
        Avalon.ResHelper:destroy()
    end
    if(Avalon.Log) then
        Avalon.Log:destroy()
    end
    if(Avalon.FileManager) then
        Avalon.FileManager:destroy()
    end
end

-- 打印游戏相关信息
function Manager:printGameInfo()
    if AvalonUtil.getPlatform() == AvalonUtil.CC_PLATFORM_IOS then
        print ("CaveOnline: platform is IOS")
    elseif AvalonUtil.getPlatform() == AvalonUtil.CC_PLATFORM_ANDROID then
        print ("CaveOnline: platform is Andriod")
    else 
        print ("CaveOnline: platform is unknow")
    end
end

-- 游戏退出时候的lua回调
function Manager:onGameExit()
    print("Game: the game is exiting.")

    -- Avalon.UserDataManager:save()
end

-- 游戏进入前台时候的lua回调
function Manager:onGameActive()
    print("Game: the game is active.")
    
    Avalon.MessageCenter:notice(GameMessage.MC_COMMENT_END, COMMENT_END_NOTICE_TYPE.GAME_ACTIVE)
    Avalon.MessageCenter:notice(GameMessage.MC_GAME_ENTER_PROGROUND)

    -- 进入前景撤销推送
    Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
        require "app.utils.PushUtil"
    	PushUtil:removeAllLocalNotifications()
    end, 1)

    Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
        Net.Helper:handleAllPack()
    end, 1)

    Avalon.Scheduler:scheduleUpdateOnce(self, function()
        UI.HWBtnComponent:mainSwitchOn()
    end, 0.5)
end

-- 游戏进入后台时候的lua回调
function Manager:onGameInactive()
    print("Game: the game is inactive.")
    
    -- 停止移动
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    if(machine) then
        machine:_battleStopMove(true)
    end

    -- 进入后台保存数据
    Avalon.UserDataManager:save()
    
    -- 进入后台设置推送
    require "app.utils.PushUtil"
    PushUtil:setupNotifications()

    -- 进入后台广播消息
    Avalon.MessageCenter:notice(GameMessage.MC_GAME_ENTER_BACKGROUND)
    UI.HWBtnComponent:mainSwitchOff()
end
function Manager:enterSplash()
    -- 目前只有CN和CN_PRE才有第二屏闪屏
    if (CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_NOADS) then
        SceneManager:getInstance():startSplashScene();
    else
        self:enterLogin()
    end

    
end
function Manager:enterLogin()
    self:initBaseModules()

    SceneManager:getInstance():startLoginScene();
end

-- 游戏开始
function Manager:startGame()
    print("----------------------------------")
    print("start the game:")

    self:initBaseModules()

    -- self:initModules();

    -- self:printGameInfo()
    -- -- if DEVELOPMENT_LOGIN == false then
    -- --     -- 连接主机
    -- --     Net.Helper:connect(Net.MAIN_SERVER, AVALON_LOGIN_HOST, AVALON_LOGIN_PORT)
    -- -- end

    SceneManager:getInstance():startLoginScene();
    
end

-- 清理当前场景的数据
function Manager:clearScene()
    local state = SceneManager:getInstance()._state
    if (state == GameState.IN_CAVE) 
        or state == GameState.IN_WORLDBOSS
        or state == GameState.IN_GUILDBOSS
        or state == GameState.IN_DESERT_EYES
        or state == GameState.IN_DISTORTED_SPACE
        or state == GameState.IN_ACT
        or state == GameState.IN_INFERNO
        or state == GameState.IN_VOID_RAFT
        or state == GameState.IN_TRIAL_LAND
        or state == GameState.IN_VIKING
        or state == GameState.IN_EVER_WINTER
        or state == GameState.IN_TITAN_ROAD
        or state == GameState.IN_TREATURE_HUNT
        or state == GameState.IN_DRIED_SPRING
        or state == GameState.IN_EXP
        or state == GameState.IN_WORMHOLE
    then
        local GameInCaveManager = require "app.game.GameInCaveManager"
        GameInCaveManager:getInstance():exitCave()
    elseif (state == GameState.IN_TOWN) then
        local GameInTownManager = require "app.game.GameInTownManager"
        GameInTownManager:getInstance():exitTown()
    elseif (state == GameState.IN_DUNGEON) then
        local GameInDungeonManager = require "app.game.GameInDungeonManager"
        GameInDungeonManager:getInstance():exitDungeon()
    elseif (state == GameState.IN_STORY) then
        local GameInStoryManager = require "app.game.GameInStoryManager"
        GameInStoryManager:getInstance():exitGuide()
    elseif (state == GameState.IN_HERO
            or state == GameState.IN_TITAN_HERO) then
        local GameInHeroManager = require "app.game.GameInHeroManager"
        GameInHeroManager:getInstance():exitHero()
    elseif (state == GameState.IN_DREAM) then
        local GameInDreamManager = require "app.game.GameInDreamManager"
        GameInDreamManager:getInstance():exitDream()
    elseif state == GameState.IN_GUILD 
        or state == GameState.IN_HOME then
        local GameInGuildManager = require "app.game.GameInGuildManager"
        GameInGuildManager:getInstance():exitGuild()
    elseif state == GameState.IN_MANOR then
        local GameInManorManager = require "app.game.GameInManorManager"
        GameInManorManager:getInstance():enterManor()
    elseif state == GameState.IN_PORT then
        local GameInPortManager = require "app.game.GameInPortManager"
        GameInPortManager:getInstance():enterPort()
    else
        assert(true, "没有清理函数")
    end

    if(RoleDataManager) then
        RoleDataManager:clear()
    end
    if(GoodsDataManager) then
        GoodsDataManager:clear()
    end
    if(SkillDataManager) then
        SkillDataManager:clear()
    end
    if (TaskDataManager) then
        TaskDataManager:clear()
    end
    if(TeamDataManager) then
        TeamDataManager:clear()
    end
    if(PictureAlbumManager) then
        PictureAlbumManager:clear()
    end
    if(MasterDataManager) then
        MasterDataManager:clear()
    end
    if(EquipIllusionDataManager) then
        EquipIllusionDataManager:clear()
    end
    local SceneManager = require('app.game.SceneManager')
    SceneManager:getInstance():leaveWaiting()
    SceneManager:getInstance():purgeInstance()
    -- add by zp 清理model的数据
    -- for k,v in pairs(mvc) do 
    --     print("clear pre mvc key=", k)
    -- end
    -- print("activity pre num=", #mvc.activityModel._activityData)
    if(mvc) then
        mvc.clearFramework()
    end
    -- for k,v in pairs(mvc) do 
    --     print("clear end mvc key=", k)
    -- end
    -- print("activity end num=", #mvc.activityModel._activityData)

    -- 清理数据
    local GameDataManager = require("app.game.GameDataManager")
    GameDataManager:getInstance():setLoginOutTipsText(nil)
    GameDataManager:getInstance():purgeInstance()
    
    local LanguageManager = require("app.game.LanguageManager")
    LanguageManager:getInstance():clear()
    
    -- 保存本地数据，然后清理掉上个账号的信息的缓存
    if(Avalon.UserDataManager) then
        Avalon.UserDataManager:save()
        Avalon.UserDataManager:clearAllCache()
    end

    if(Game.FriendManager) then
        Game.FriendManager:getInstance():clear()
    end
    if(Game.ChatManager) then
        Game.ChatManager:getInstance():clear()
    end
    if(Game.MailManager) then
        Game.MailManager:getInstance():clear()
    end
    
    if(Game.FunctionUnlockManager) then
        Game.FunctionUnlockManager:getInstance():clear()
    end

    local storyManager = require("app.story.StoryManager")
    storyManager:purgeInstance()

    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    LevelSelectUtil:purgeInstance()

    require "app.utils.ImageDownLoadUtil"
    ImageDownLoadUtil:clear()

    require("app.ui.notice.RunningLamp")
    UI.RunningLamp:clear()

    local SdkManager = require "app.game.SdkManager"
    SdkManager:getInstance():purgeInstance();
end

-- 获取主角的角色模型
function Manager:getMasterRole()
    local GameDataManager = require("app.game.GameDataManager")
    local masterData = GameDataManager:getInstance():getMaster()
    if (masterData) then
        local spriteID = masterData:getSpriteID()
        return self:getRole(spriteID)
    else
         assert(false)
    end
    return nil
end

-- 获取角色模型
function Manager:getRole(spriteID)
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    if (machine) then
        local model = machine:getModel()
        if (model) then

            return model:getRoleBySpriteID(spriteID)
        else
            -- assert(false)
        end
    else
        -- assert(false)
    end
    return nil
end

function Manager:openCountDownSwitch()
    COUNT_DOWN_SWITCH = true
end

function Manager:closeCountDownSwitch()
    COUNT_DOWN_SWITCH = false
end

function Manager:getCountDownSwitch()
    return COUNT_DOWN_SWITCH
end

-- 设置服务器对时时间戳
function Manager:setServerTimestamp(timestamp)
    server_timestamp = timestamp
end

-- 获取服务器对时时间戳
function Manager:getServerTimestamp()
    return server_timestamp
end

-- 设置本地对时时间戳
function Manager:setLocalTimestamp(timestamp)
    Local_timestamp = timestamp
end

-- 获取本地对时时间戳
function Manager:getLocalTimestamp()
    return Local_timestamp
end

-- 获取模拟的服务器时间  --服务器发送给客户端消息时间
function Manager:getNowServerTimestamp()
    local nowServerTimeStamp = server_timestamp + (AvalonUtil.getCurrentTime()-Local_timestamp)
    if(nowServerTimeStamp <0) then 
        nowServerTimeStamp = 0
    end

    return nowServerTimeStamp
end

-- 根据配置表时间转出时间戳，此时间与getNormalServerTime()方法判断
-- timeStr格式：“2020.11.02.00.00.00”
function Manager:getUnixTimeByConfigTimeStr(timeStr)
    local timeList = string.split(timeStr, ",")
    local unixTime = os.time({
        day=tonumber(timeList[3]),
        month=tonumber(timeList[2]),
        year=tonumber(timeList[1]),
        hour=tonumber(timeList[4]),
        min=tonumber(timeList[5]),
        sec=tonumber(timeList[6])
    })

    -- 获取日期对应零时区的unix时间戳
    unixTime = unixTime + self:get_timezone_offset()

    unixTime = unixTime - self:getEPOCHTime()

    return unixTime
end

-- 根据配置表时间转出当前客户端显示时间格式
-- timeStr格式：“2020.11.02.00.00.00”
function Manager:getClientDateByConfigTimeStr(timeStr, formatDate)
    local unixTime = GameManager:getUnixTimeByConfigTimeStr(timeStr)

    local date = os.date(formatDate, unixTime  + GameManager:getEPOCHTime() - GameManager:getServerDifferArea())

    return date
end


-- 获取指定格式的服务器时间
function Manager:getNowServerDate(formatDate, timeStamp)
    if(formatDate == nil) then
        formatDate = "%Y.%m.%d %H:%M:%S"
    end

    local timeStamp = timeStamp - self:get_timezone_offset()

    return os.date(formatDate, timeStamp)
end

-- 获取当前服务器时间   --服务器相对于1970年的时间
function Manager:getNowServerTime()
    local localTime = math.modf(AvalonUtil.getCurrentTime() / 1000)

    return sync_end_serverTime + (localTime - sync_end_localTime)
end

--服务器相对于游戏元年的时间, 服务器通知的客户端时间都是以该之间为参照
function Manager:getNormalServerTime()
    local localTime = self:getNowServerTime()

    return localTime - self:getEPOCHTime()
end

-- 获取当前是周几
function Manager:getNowCurWeekDay()
    local nowTime = self:getNormalServerTime()
    -- local weekDay = math.mod(math.floor(nowTime / 86400 + 6), 7)
    --CO-17606 【深渊】深渊扫荡功能异常
    local weekDay = math.floor(nowTime / 86400 + 6) % 7
    return weekDay
end

-- 获取当前时间是第几天
function Manager:getNowCurDayByTimestamp(timestamp)
    local nowTime = timestamp
    local day = math.floor(nowTime / 86400) 
    return day
end

-- function Manager:getGameWeek()
--     return math.modf((self:getNowServerTime() + SECONDS_ONE_DAY * 5) / SECONDS_ONE_WEEK )
-- end

-- -- 计算指定服务器时间属于多少周
-- function Manager:calculationGameWeek(serverTime)
--     return math.modf((serverTime + SECONDS_ONE_DAY * 5) / SECONDS_ONE_WEEK )
-- end

function Manager:calculationGameWeekForDay(serverDay)
     local week = math.modf((serverDay +  5) / 7)
     return week
end

-- 计算指定服务器时间当天过了多少秒
function Manager:calculationGameSecondOfToday()
    local timeNow = self:getNormalServerTime()
    local secondOfToday = timeNow % SECONDS_ONE_DAY

    -- local nowServerTime = self:getNowServerTime() - self:get_timezone_offset()
    -- local serverDate = os.date("*t", nowServerTime)
    -- local timeStampOfToday = os.time({day=serverDate.day, month=serverDate.month,year=serverDate.year, hour=0, minute=0, second=0})
    -- local secondOfToday = nowServerTime - timeStampOfToday
    return secondOfToday
end

function Manager:getClientOffsetZone()
    if(self._offsetZone == nil) then
        local nowTime = os.time()
        self._offsetZone = os.difftime(nowTime, os.time(os.date("!*t", nowTime)))/3600
    end 

    return self._offsetZone
end

function Manager:get_timezone_offset()
    if(self._offsetOffsetTime == nil) then
        local ts = os.time()
        local utcdate   = os.date("!*t", ts)
        local localdate = os.date("*t", ts)
        localdate.isdst = false -- this is the trick
        
        self._offsetOffsetTime = os.difftime(os.time(localdate), os.time(utcdate))
    end 

    return self._offsetOffsetTime
end

-- 下面几个函数为临时数据
function Manager:setLocalRequestTimestamp(localTimestamp)
    local_requestTimestamp = localTimestamp
end

function Manager:getLocalRequestTimestamp()

    return local_requestTimestamp
end

function Manager:setAnswerServerTime(answerTimestamp)

    server_answerTimestamp = answerTimestamp
end

function Manager:getAnswerServerTime()

    return  server_answerTimestamp
end

-- 发送对时请求
function Manager:syncTimeRequest()
    Net.NetRoleSystem:syncTimeRequest()
end

function Manager:syncTimeAnswer(mesData)
    self:_handleSyncTime(mesData.serverStamp)
    
    Net.NetRoleSystem:syncTimeRequest()
end

function Manager:syncTimeEnd(mesData)
    -- 记录服务器当前时间，并且开启一个时钟来模拟服务器时间
    sync_end_serverTime = mesData.serverTime + self:getEPOCHTime()
    -- print("Manager:syncTimeEnd  ", mesData.serverTime, self:getEPOCHTime())
    sync_end_localTime = math.modf(AvalonUtil.getCurrentTime() / 1000)

    self:_handleSyncTime(mesData.serverStamp)

    -- 设置服务器与零时区差值
    local ProtobufUtil = require "utils.ProtobufUtil"
    if ProtobufUtil:checkFieldIsInit(mesData, "timeArea") then
        self:setServerDifferArea(mesData.timeArea)
    end
    
    -- 设置最后的结果
    self:setServerTimestamp(server_goodTimestamp + goodTimeDifference/2)
    self:setLocalTimestamp(local_goodAnswerTimestamp)

    -- if DEBUG then
    --     print(string.format("Manager:syncTimeEnd  本地对时服务器时间=%d,对时客户端时间=%d,最低延迟时间=%d",self:getServerTimestamp(),self:getLocalTimestamp(),goodTimeDifference/2))
    -- end

    -- 清理对时本地保存的数据
    local_requestTimestamp = 0
    goodTimeDifference = nil
end

function Manager:setServerDifferArea(differTime)
    sync_differ_Area = differTime
end

function Manager:getServerDifferArea()
    return sync_differ_Area
end

-- 发送角色状态改变消息
function Manager:notifyRoleFSMChange(roleData)
    -- print("Manager:notifyRoleFSMChange  ",roleData:getSpriteID())
    -- local data = {}
    -- data.spriteID = spriteID
    -- data.fsmState = fsmState
    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE,roleData)
end

-- 获取系统元年时间
function Manager:getEPOCHTime()
    -- 这里直接使用数值，避免了时区问题
    
    return 946684800
end

function Manager:_handleSyncTime(serverTime)
    local localTime = AvalonUtil.getCurrentTime()
    local chaTime = AvalonUtil.getCurrentTime() - self:getLocalRequestTimestamp()
    -- if DEBUG then
    --     print(string.format("Manager:_handleSyncTime 本次对时 服务器时间=%d,本地时间=%d,时间差%d",serverTime,localTime,chaTime))
    -- end

    if chaTime <=0 then
        return
    end

    if goodTimeDifference == nil then
        goodTimeDifference = chaTime
        server_goodTimestamp = serverTime
        local_goodAnswerTimestamp = localTime
    else
        if goodTimeDifference > chaTime then
            -- 当前请求时间最短
            goodTimeDifference = chaTime
            server_goodTimestamp = serverTime
            local_goodAnswerTimestamp = localTime
        end 
    end
end

function Manager:getAttrList()
    require "app.datas.PublicDefine"
    local ProtobufUtil = require "utils.ProtobufUtil"
    local list = {}
    for k,v in pairs(PublicDefine.ATTR_TYPE) do
        local id = ProtobufUtil:enum_id("PublicDefine.ATTR_TYPE",k)
        local name = ToolsUtil:attrNameToLanguageString(k)
        -- print("-----key = "..k.." and name = "..name)
        if name ~= nil and name ~= "" and name ~= "e:0" then
            local data = {}
            data.name = name
            data.type = id
            table.insert(list, data)
            -- print("id = "..id)
        end
    end
    table.sort(list, function(a, b)
        return a.type < b.type
    end)
    --dump(list, "-------------------Manager:getAttrList()")
    return list
end

function Manager:addExpressionCommand(spineAction, spriteId)
    local target = self:getRole(spriteId)
    if(target) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initExpressionCommand(target:getId(), spineAction, target:getDirection())
        local MachineManager = require("app.game.MachineManager")
        MachineManager:getInstance():getMachine():pushCommand(renderCommand)
    end
end

function Manager:refreshMailNewFlag(isRemove)
    local MachineManager = require("app.game.MachineManager")
    local battleMachine = MachineManager:getInstance():getMachine()
    if battleMachine == nil then
        MasterDataManager:setHaveNewMail(true)
        return false
    end
    local battleModel = battleMachine:getModel()
    if (battleModel) then
        local mailModels = battleModel:getMailModels()
        for k, mailModel in ipairs(mailModels) do
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initMailNewFlag(mailModel:getId(), isRemove)
            MachineManager:getInstance():getMachine():pushCommand(renderCommand)
        end
    end
    return true
end

--内部跳转  约定 jumpLayer:// + 界面ID
function Manager:openDeepLink(data, isFromCave)
    if data ~= nil and data.layerId ~= nil and data.layerId ~= "" then
        local url = string.format("jumpLayer://%s?guildId=%s", data.layerId, data.action or "")

        local  sourceType = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_None
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_DeepLink, data.layerId, data.action, nil, sourceType)
        self:openUrl(url, nil, isFromCave)
    else
        print(" error openDeepLink data = ", data)
    end
end

--内部跳转  约定 jumpLayer:// + 界面ID
function Manager:openUrl(url, callback, isFromCave, isTapTap)
    if url == nil or url == "" then
        return
    end
    isFromCave = isFromCave == nil and false or isFromCave
    local startPos = string.find(url, "jumpLayer://")
    local layerIDStrArr = string.trim(string.gsub(url, "jumpLayer://", "")):split("?")
    -- layerIDStr = string.sub(layerIDStr, 2, string.len(layerIDStr) - 1)
    local layerID = tonumber(layerIDStrArr[1])
    if startPos ~=nil and layerID ~= nil and layerID > GameMessage.MC_UI_JUMP_LAYER_MIN and layerID < GameMessage.MC_UI_JUMP_LAYER_MAX then --n
        local jumpFlag = true
        if(layerID == GameMessage.MC_UI_JUMP_BAG) then
            -- 显示背包界面
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
        elseif (layerID == GameMessage.MC_UI_JUMP_FRIEND_MAIN) then
            -- 好友界面
            -- 判断是否解锁
            local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_FriendShip)
            if(isUnlock) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FRIEND_MAIN)
            else
                -- UI.ScrollBar:createByText(UI.TEXT_1170931)
                jumpFlag =  false
            end
        elseif (layerID == GameMessage.MC_UI_JUMP_IAPSHOP) then
            -- 显示商城界面
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP,false, 1, nil, 
                PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_OpenFromUrl)
        elseif (layerID == GameMessage.MC_UI_JUMP_IAP_GOLD_BOX) then
            -- 显示宝箱（内购页面的宝箱）
            -- TODO 判断是否有宝箱
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, 2, nil, 
                PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_OpenFromUrl, true)
        elseif (layerID == GameMessage.MC_UI_JUMP_GUILD) then
            -- 跳转公会
            local guildData = MasterDataManager:getGuildData()
            if(guildData) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_GUILD_MANAGER)
            else
                -- UI.ScrollBar:createByText(UI.TEXT_1170930)
                jumpFlag =  false
            end
        elseif (layerID == GameMessage.MC_UI_JUMP_ACTIVITY_POINT and not isFromCave) then
            local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DailyAction)
            if(isUnlock) then
                mvc.openPanel("ActivityPoint", "ActivityPoint")
            else
                -- UI.ScrollBar:createByText(UI.TEXT_1212915)
                jumpFlag =  false
            end
        -- elseif (layerID == GameMessage.MC_UI_JUMP_LUCK_DROP and not isFromCave) then -- 转盘
        --     local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Luckywheel)
        --     if(isUnlock) then
        --         Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_LUCKDROP)
        --     else
        --         UI.ScrollBar:createByText(UI.TEXT_1170901)
        --         jumpFlag =  false
        --     end        
        -- elseif (layerID == GameMessage.MC_UI_JUMP_LOTTERY and not isFromCave) then -- 幸运抽奖
        --     local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyLottery)
        --     if activityData and activityData:getLotteryData():getLevelLimit() <= RoleDataManager:getMaster():getLevel() then  
        --         mvc.openPanel("ActivityLottery", "ActivityLottery")
        --     else
        --         UI.ScrollBar:createByTextID(1111668)
        --         jumpFlag =  false
        --     end 
        elseif (layerID == GameMessage.MC_UI_JUMP_MAIN_ACTIVITY and not isFromCave) then --运营活动列表
            local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity)
            if(isUnlock) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_ACTIVITY_PANEL)
            else
                -- UI.ScrollBar:createByText(UI.TEXT_1170901)
                jumpFlag =  false
            end    
        elseif (layerID == GameMessage.MC_UI_JUMP_BATTLE_PASS and not isFromCave) then --通行证
            local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_BattlePass)
            if(isUnlock) then
                mvc.openPanel("BattlePass", "BattlePass")
            else
                -- UI.ScrollBar:createByText(UI.TEXT_1170901)
                jumpFlag =  false
            end 
        -- elseif (layerID == GameMessage.MC_UI_JUMP_STARPROY_SHOP and not isFromCave) then --占星抽奖
        --     local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_StarPray)
        --     if(isUnlock) then
        --         mvc.openPanel("StarPray", "StarPrayShop")
        --     else
        --         UI.ScrollBar:createByText(UI.TEXT_1170901)
        --         jumpFlag =  false
        --     end
        -- elseif (layerID == GameMessage.MC_UI_JUMP_STARPROY_SWALLOW and not isFromCave) then --占星装备、吞噬
        --     local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_StarPray)
        --     if(isUnlock) then
        --         mvc.openPanel("StarPray", "StarPray")
        --     else
        --         UI.ScrollBar:createByText(UI.TEXT_1170901)
        --         jumpFlag =  false
        --     end
        -- elseif (layerID == GameMessage.MC_UI_JUMP_ENCHANTMENT) then -- 装备附魔
        --     Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_IN_CAVE_ENCHANTMENT)
        -- elseif (layerID == GameMessage.MC_UI_JUMP_EQUIP_STRENG and not isFromCave) then -- 铁匠装备强化
        --     local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Strengthen)
        --     if(isUnlock) then
        --         Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_STRENGTHEN)
        --     else
        --         UI.ScrollBar:createByText(UI.TEXT_1170901)
        --         jumpFlag =  false
        --     end   
        -- elseif (layerID == GameMessage.MC_UI_JUMP_EQUIP_RESOLVE and not isFromCave) then -- 铁匠装备分解
        --     local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Decompose)
        --     if(isUnlock) then
        --         Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_RESOLVE)
        --     else
        --         UI.ScrollBar:createByText(UI.TEXT_1170901)
        --         jumpFlag =  false
        --     end  
        -- elseif (layerID == GameMessage.MC_UI_JUMP_EQUIP_REMOULD and not isFromCave) then -- 铁匠装备改造
        --     local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Remodel)
        --     if(isUnlock) then
        --         Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_REMOULD)
        --     else
        --         UI.ScrollBar:createByText(UI.TEXT_1170901)
        --         jumpFlag =  false
        --     end  
        -- elseif (layerID == GameMessage.MC_UI_JUMP_EQUIP_FORGE and not isFromCave) then -- 铁匠装备锻造
        --     local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Forge)
        --     if(isUnlock) then
        --         Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_FORGE)
        --     else
        --         UI.ScrollBar:createByText(UI.TEXT_1170901)
        --         jumpFlag =  false
        --     end  
        elseif (layerID == GameMessage.MC_UI_JUMP_HORCURX and not isFromCave) then -- 魂器
            local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Horcrux)
            if(isUnlock) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG, UI.BagPanel.TAB_INDEX.HORCURX)
            else
                -- UI.ScrollBar:createByText(UI.TEXT_1170901)
                jumpFlag =  false
            end
        elseif (layerID == GameMessage.MC_UI_JUMP_GUILD_INFO) then -- 公会信息
            local param1 = layerIDStrArr[2]
            if (param1) then
                local param1Str = param1:gsub(" ", ""):gsub("guildId=", "")
                if (param1Str) then
                    local processedParam1 = tonumber(param1Str)
                    if (processedParam1) then
                        mvc.openPanel("GuildInfo", "GuildInfo", processedParam1)            
                    end
                end
            end
        elseif (layerID == GameMessage.MC_UI_JUMP_ACTIVITY_FESTIVAL and not isFromCave) then --节日活动界面
            local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Festival)
            if(isUnlock) then
                local dataArr = MasterDataManager:getActivityDataArr()
                local found = false
                for k, v in pairs(dataArr) do
                    if v:getType() == PublicDefine.ActivityType.ActivityType_Festival then
                        found = true
                        break
                    end
                end

                if found then
                    local spriteId = self:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL)
                    mvc.openPanel("Festival", "Festival", spriteId)
                else
                    jumpFlag =  false
                end
            else
                -- UI.ScrollBar:createByText(UI.TEXT_1170901)
                jumpFlag =  false
            end
        elseif (layerID == GameMessage.MC_UI_JUMP_FESTIVAL_SIGN_VIEW and not isFromCave) then -- 双节签到
            -- 显示双节限定签到界面
            mvc.openPanel("FestivalSign", "FestivalSign", {planType = FALL_FESTIVAL_TASK , signInType = FALL_FESTIVAL_SIGN})
        -- elseif (layerID == GameMessage.MC_UI_JUMP_SF_SIGN and not isFromCave) then -- 春节限定签到
            -- 显示春节限定签到界面
            -- mvc.openPanel("SFSign", "SFSign")
        elseif (layerID == GameMessage.MC_UI_JUMP_FIGHT_BACK_SHOP and not isFromCave) then -- 反斗乐
            mvc.openPanel("TradeActivity", "TradeActivityMain", PublicDefine.TradeActivityIDList.TradeActivityFightBack)
        elseif (layerID == GameMessage.MC_UI_JUMP_LIMITED_FIGHT_BACK_SHOP and not isFromCave) then -- 限时反斗乐
            mvc.openPanel("TradeActivity", "TradeActivityMain", PublicDefine.TradeActivityIDList.TradeActivityTimeLimitedFightBack)
            
        else
            -- 没有提出要处理，让策划可以配置一个非常规的值，一般情况不应该出现这样的情况。
            print("Manager:openUrl layerID=", layerID)
            -- Avalon.MessageCenter:notice(layerID)
        end      

        if callback then
            callback(jumpFlag)
        end
    else
        -- url = "pk,lv,account,accountStr,channel,platform,zone,languageType|http://www.baidu.com"
        -- 特殊格式 根据需求添加参数
        local paramsIdx = string.find(url,"|")

        
        if  paramsIdx then
            local pureUrl = string.sub( url, paramsIdx + 1 )
            local paramsStr = string.sub( url, 1,paramsIdx - 1 )
            -- print("paramsIdx",paramsIdx,pureUrl,paramsStr)
            local params = {}
            local needParams = string.split(paramsStr,",")
            print("url")
            dump(needParams,"自定义URL参数")
            for i,v in ipairs(needParams) do
                if v == "pk" then
                    params.pk = RoleDataManager:getMasterPK() or "unkown"
                elseif v == "lv" then
                    params.lv = "1"
                    local heroData = RoleDataManager:getMaster()
                    if heroData then
                        params.lv = heroData:getLevel()
                    end
                elseif v == "accountStr" then
                    local gameLoginManager = require("app.game.GameLoginManager")
                    local accountStr = gameLoginManager:getInstance():getAccountId() or "unkown"
                    params.accountStr = accountStr
                elseif v == "account" then
                    local account = SdkBox:getInstance():getVersionAccount()
                    params.account = account or "unkown"
                elseif v == "channel" then
                    local channel = SdkBox:getInstance():getVersionChannel()
                    params.channel = channel or "unkown" 
                elseif v == "platform" then
                    local platform = SdkBox:getInstance():getVersionPlatform()
                    params.platform = platform or "unkown" 
                elseif v == "zone" then
                    local gameLoginManager = require("app.game.GameLoginManager")
                    local zone = gameLoginManager:getInstance():getServerId()
                    params.zone = zone or "unkown" 
                elseif v == "languageType" then
                    local LanguageManager = require("app.game.LanguageManager")
                    local languageType = LanguageManager:getInstance():getLanguage()
                    params.languageType = languageType or "unkown"
                elseif v == "roleName" then
                    params.roleName = "unkown"
                    local heroData = RoleDataManager:getMaster()
                    if heroData then
                        params.roleName = string.urlencode(heroData:getNickName())
                    end
                end
            end
            params.target = SdkBox:getInstance():getVersionTarget()
            local sortTable = AvalonUtil:sortParamByFirstChar(params)
            -- dump(sortTable, "sortTable")
            local md5ParamStr = ""
            local paramsStr = ""
            local paramTable = {}
            for k, v in ipairs(sortTable) do
                md5ParamStr = md5ParamStr..v.value
                paramsStr = paramsStr..v.key.."="..v.value.."&"
            end
            local md5Str = AvalonUtil:MD5(md5ParamStr..WEB_MD5_KEY)
            paramsStr = paramsStr.."md5Str="..md5Str

            url = pureUrl .. "?"..paramsStr
            -- print("url",url)
        end
        




        local targetPlatform = cc.Application:getInstance():getTargetPlatform()
        if cc.PLATFORM_OS_WINDOWS == targetPlatform or cc.PLATFORM_OS_MAC == targetPlatform or cc.PLATFORM_OS_LINUX == targetPlatform or isTapTap then
            cc.Application:getInstance():openURL(url)
        else
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_WEBVIEW_LAYER, url)
            self:openWebView(url)
        end

        if callback then
            callback(true)
        end
    end
end

function Manager:getNpcsForFuntionType(functionType)
    local spriteID = 0
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    if (machine) then
        local model = machine:getModel()
        if (model) then
            local modelArr = model:getNpcsForFuntionType(functionType)
            if(modelArr and #modelArr > 0) then 
                spriteID = modelArr[1]:getSpriteID()
            end
        end
    end
    return spriteID
end

function Manager:openWebView(url)
    local webViewLayer = cc.Director:getInstance():getRunningScene():getChildByName("WebViewLayer")
    if webViewLayer == nil then
        require("app.ui.webview.WebViewLayer")
        local webViewLayer = UI.WebViewLayer:create()
        webViewLayer:init(url)
        webViewLayer:center(0)
        webViewLayer:setName("WebViewLayer")
        cc.Director:getInstance():getRunningScene():addChild(webViewLayer,UI_ZORDER.WEBVIEW)
    end
end

function Manager:registerRichLinkClickCallBack()
    if self._listener ~= nil then
        return
    end
    local _listener = cc.EventListenerCustom:create("game_custom_event_click_name", function(event)
        print("------------------_listener  success")
        Game.ChatManager:getInstance().isLockTouchTranslate = true
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            Game.ChatManager:getInstance().isLockTouchTranslate = false
        end, 1)
        -- dump(event, "event")
        local sender = event:getSender()
        -- dump(sender:getContentSize().width, "sender")
        local data = event:getItemData()
        data = Base64Decode(data)
        local itemTable = json.decode(data)
        -- dump(itemTable, "itemTable")
        if itemTable.dataType == PublicDefine.TagClickType.ItemName then
            -- local deProtoData = ProtobufUtil:decode("GoodsSystem.GoodsData",itemTable.protoData)
            -- local goodsMesData = ProtobufUtil:decode("GoodsSystem.EquipmentData",deProtoData.goodsDataBytes)
            local itemData = itemTable
            -- dump(itemData, "itemData")
            local goodsMesData = itemData.goodsMesData
            local goodsID = itemData.templateID
            local goodsType =  GoodsDataManager:getGoodsTypeForGoodsID(goodsID)
            local statusData = {}
            statusData.isGolden = itemData.isGolden or false
            statusData.isLock = itemData.isLock or false
            statusData.index = itemData.index or 0 
            statusData.isInCaveNewGet = itemData.isInCaveNewGet or false
            statusData.strengthenLevel = itemData.strengthenLevel

            local goodsData = GoodsDataManager:_createGoodsData(goodsID,goodsType,itemData.num,goodsMesData,statusData)
           -- dump(deProtoData, "deProtoData")
            local ProtobufUtil = require("utils.ProtobufUtil")
            if goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                local byteData = ProtobufUtil:encode("GoodsSystem.EquipmentData", goodsMesData)
                goodsData:setBytesData(byteData)
                if goodsData.resetHoleData then
                    goodsData:resetHoleData(goodsMesData.holes)
                end   
            elseif goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
                local byteData = ProtobufUtil:encode("GoodsSystem.PetEquipmentData", goodsMesData)
                goodsData:setBytesData(byteData)
            end
            self:onShowInfoAreaHandler(goodsData, sender)
        elseif itemTable.dataType == PublicDefine.TagClickType.InnerHref then
            GameManager:openUrl(itemTable.href)
        elseif itemTable.dataType == PublicDefine.TagClickType.GuildName then
            mvc.openPanel("GuildInfo", "GuildInfo", itemTable.data.guildID)
        elseif itemTable.dataType == PublicDefine.TagClickType.PetName then
            local petMesData = itemTable.petMesData
            local ProtobufUtil = require("utils.ProtobufUtil")
            local byteData = ProtobufUtil:decode("PetSystem.PetRoleData", petMesData)
            local pet = MasterDataManager:getBagPetById(byteData.uniqueid)
            if pet then
                 mvc.openPanel("Pet", "PetMain", {tabIdx=1, innerTabIdx=1, petID=pet:getId()})
            else
                local petData = Data.PetRoleData:create()
                petData:init(byteData, true)
                mvc.openPanel("Pet", "PetLookMain", {pet = petData, isShow = false})
            end
        end
    end)
    local _eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    _eventDispatcher:addEventListenerWithFixedPriority(_listener, 1);
    self._listener = _listener 
end

--copy from GoodsGrid:onShowInfoAreaHandler 
function Manager:onShowInfoAreaHandler(goodsData, sender)
    local pInfoArea = nil;
    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
        -- 装备详情
        pInfoArea = UI.EquipmentInfoArea:create()
        pInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
        -- 处理试穿对比
        local GameDataManager = require("app.game.GameDataManager")
        local blackTable = GameDataManager:getInstance():tryEquipment(goodsData)
        pInfoArea:updateInfo(blackTable)
        pInfoArea:showStrength()
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        pInfoArea = UI.EquipmentPetInfoArea:create()
        pInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
        pInfoArea:updateInfo(goodsData, MasterDataManager:getFightWearEquipmentForEquipmentType(goodsData:getEquipmentType()))
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
        -- 道具详情界面
        local itemType = goodsData:getItemType()
        if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
            pInfoArea = UI.SelectGoodsBagInfoArea:create()
        elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then 
            pInfoArea = UI.RandomBagInfoArea:create()
        elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then 
            pInfoArea = UI.LevelBagInfoArea:create()
            pInfoArea:lockNextLevelBag()
            pInfoArea:disableUse()
        else
            pInfoArea = UI.PropInfoArea:create(true)
        end
        pInfoArea:init(UI.PROP_MATER.PROPINFO)
        
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
        -- 材料详情界面
        if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then 
            pInfoArea = UI.PropInfoArea:create(true)
        else 
            pInfoArea = UI.MaterialEquipScrollInfoArea:create()
        end
        pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then  
        pInfoArea = UI.PropInfoArea:create(true)
        pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
        -- 虚拟物品详情界面
        if(goodsData:getCanBeView()) then 
            pInfoArea = UI.PropInfoArea:create(true)
            pInfoArea:init(UI.PROP_MATER.VIRTUALITEM_INFO)
            pInfoArea:setHideLink(true)
        else
            return 
        end
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
        -- 宝石详情界面
        pInfoArea = UI.GemStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
        pInfoArea = UI.StarPrayInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
        pInfoArea = UI.PetStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then 
        pInfoArea = UI.RelicInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then 
        pInfoArea = UI.GlyphInfoArea:create()
        pInfoArea:init(goodsData)
    else 
        return 
    end

    local point = sender:convertToWorldSpace(sender:getAnchorPoint())

    pInfoArea:setVisible(true)
    pInfoArea:updateView(goodsData)
    pInfoArea:closeLockFlag()
    pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        pInfoArea:close();
    end)
    -- local chatLayer = UI.UIManager:getCurrentChatLayer()
    local winSize = cc.Director:getInstance():getWinSize()
    pInfoArea:leftBottom(point.x + 160, point.y)
    local size = pInfoArea:getContentSize()
    if point.y + size.height > winSize.height then
        pInfoArea:leftBottom(pInfoArea:getLeft(), winSize.height - size.height - 50)
    end
    pInfoArea:setName("INFO_AREA")
    -- pInfoArea:setStatic(true)
    UI.UIManager:addToRootNode(pInfoArea, UI_ZORDER.TIPS)
end

function Manager:isResLoading()
    return self._isResLoading
end

function Manager:setResLoading(isResLoading)
    self._isResLoading = isResLoading
end
function Manager:isShowDisclaimer()
    return showDisclaimer
end
function Manager:markShowDisclaimer()
    showDisclaimer = true
end
function Manager:clearShowDisclaimer()
    showDisclaimer = false
end

function Manager:triggerLoadCommonRes(callback)
    -- -- 是否在等待加载资源
    -- self.isWaitingLoadRes = true 
    -- -- 资源加载完成
    -- self.resWasLoadEnd = false

    if(self.resWasLoadEnd) then 
        if(callback) then 
            callback()
        end
        return 
    end

    self.callback = callback
    if(self.isWaitingLoadRes) then 
        return
    end

    if(self._loadindResCount == nil) then 
        self._loadindResCount = 0 
    end

    if(self._loadedResCount == nil) then 
        self._loadedResCount = 0 
    end
    self.isWaitingLoadRes = true

    -- 加载资源
    Avalon.ResHelper:beginLoading(nil, function()
        self._loadedResCount = self._loadedResCount + 1
        if(self._loadedResCount >= self._loadindResCount) then 
            self.resWasLoadEnd = true
            self.isWaitingLoadRes = false
            if (self.callback) then
                self.callback()
            end
        end
    end)
    local i = 1
    local count = #GAME_COMMON_SPINE_RES_LIST
    repeat
        local skeletonJSON = GAME_COMMON_SPINE_RES_LIST[i]
        local skeletonAtlas = GAME_COMMON_SPINE_RES_LIST[i+1]
        local skeletonScale = GAME_COMMON_SPINE_RES_LIST[i+2]
        Avalon.ResHelper:pushSpine(skeletonJSON, skeletonAtlas, skeletonScale)

        i = i + 3
    until (i >= count)
    Avalon.ResHelper:endLoading()
    self._loadindResCount = self._loadindResCount + 1

    Avalon.ResHelper:beginLoading(nil, function()
        self._loadedResCount = self._loadedResCount + 1
        if(self._loadedResCount >= self._loadindResCount) then 
            self.resWasLoadEnd = true
            self.isWaitingLoadRes = false
            if (self.callback) then
                self.callback()
            end
        end
    end)

    for i = 1, #GAME_COMMON_UI_RES_PLISTS do
        Avalon.ResHelper:pushPlist(GAME_COMMON_UI_RES_PLISTS[i])
    end
    if(not AvalonUtil.isSmallMemoryDevice()) then
        for i = 1, #GAME_OPTIONAL_UI_RES_PLISTS do
            Avalon.ResHelper:pushPlist(GAME_OPTIONAL_UI_RES_PLISTS[i])
        end
    end

    Avalon.ResHelper:endLoading()
    self._loadindResCount = self._loadindResCount + 1
end

function Manager:showConfirmOpenWebView(text, itemId, url)
    if (device.platform == "mac" or device.platform == "windows") then
        print("++++++++showConfirmOpenWebView and platform = ", device.platform)
        Net.NetGoodsSystem:requestFinishQuestion(itemId, true)
        return
    end
    if not SdkBox:getInstance():isHaveShowWebViewAPI() or self._isLockQuestionNaire then
        return
    end
    self._isLockQuestionNaire = true
    UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(text, function(isSelect)
        local params = {}
        params.roleId = RoleDataManager:getMasterPK()
        local heroData = RoleDataManager:getMaster()
        local gameLoginManager = require("app.game.GameLoginManager")
        local ServerConfigUtil = require("app.utils.ServerConfigUtil")
        params.roleName = heroData:getNickName()
        params.roleLevel = tostring(heroData:getLevel())
        params.zoneId = tostring(gameLoginManager:getInstance():getServerId())
        params.zoneName = tostring(gameLoginManager:getInstance():getServerId())
        params.userId = ServerConfigUtil:getPlayerID()
        params.url = url
        local jsonStr = json.encode(params)

        params = {}
        params.paramStr = jsonStr
        SdkBox:getInstance():showWebView(params)

        self._isLockQuestionNaire = false
        Net.NetGoodsSystem:requestFinishQuestion(itemId, true)
    end, function(isSelect)
        self._isLockQuestionNaire = false
        Net.NetGoodsSystem:requestFinishQuestion(itemId, false)
    end, nil, nil)
end

function Manager:loadAds(placeId, serverPlaceId)
    local GameDataManager = require("app.game.GameDataManager")
    local gameLoginManager = require("app.game.GameLoginManager")
    local ServerConfigUtil = require("app.utils.ServerConfigUtil")
    local data = ConfigManager:getAdsCodeId(placeId, device.platform, ServerConfigUtil:getProjectId()) or {}

    local extraTable = {}
    local params = {}
        -- 这里CN ios 修改为了topon广告聚合平台
    if(self:isCNIOSTopOn()) then 
        local ad = self:getCNIOSTopOnPlacementID()
        local ID = ad
        -- print("----loadAds-extraTable-----", extraTable)
        extraTable.place = serverPlaceId
        extraTable.zone = gameLoginManager:getInstance():getServerId()
        extraTable.id = ID
        extraTable.ad = ad
        params = {
            userId = tostring(GameDataManager:getInstance():getMasterPK()),
            codeId = ad,
            serPlace = extraTable.place,
            zone = extraTable.zone,
            timeStamp = orderId,
            cfgPlace = placeId,
            extraParams = json.encode(extraTable),
        }
    else
        extraTable.place = serverPlaceId
        extraTable.zone = gameLoginManager:getInstance():getServerId()
        extraTable.id = data.ID or ""
        extraTable.ad = data.ad or ""
        --print("----loadAds-extraTable-----", extraTable)
        params = {
            userId = tostring(GameDataManager:getInstance():getMasterPK()),
            codeId = data.ad or "",
            serPlace = extraTable.place,
            zone = extraTable.zone,
            cfgPlace = placeId,
            extraParams = json.encode(extraTable),
        }
    end

    local SdkBox = require("utils.sdkbox.SdkBox")
    --权限
    local isHavePermisson = AvalonUtil:isHavePermission(Game.AndroidPermission.ACCESS_COARSE_LOCATION)
    if device.platform == "android" and CAVEOL_TARGET ~= CAVEOL_TARGET_GLOBAL and not isHavePermisson then
        if self.lockLoadAdsTips == nil then
            -- print("SdkBox:isDouYinMedia() ======= ",SdkBox:isDouYinMedia())
            -- if SdkBox:isDouYinMedia() or true then
            --     SdkBox:getInstance():loadAds(params)
            -- else
                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1212805, function()
                    SdkBox:getInstance():loadAds(params)
                end)
            -- end
            self.lockLoadAdsTips = true
            -- Avalon.Scheduler:scheduleUpdateOnce(self, function()
            --     self.lockLoadAdsTips = nil
            -- end, 0.5)
        end
    else
        if self.lockLoadAdsTips2 == nil then
            SdkBox:getInstance():loadAds(params)
            self.lockLoadAdsTips2 = true
            Avalon.Scheduler:scheduleUpdateOnce(self, function()
                self.lockLoadAdsTips2 = nil
            end, 0.5)
        end
       
    end
end

function Manager:playAds(placeId, serverPlaceId, orderId)
    local GameDataManager = require("app.game.GameDataManager")
    local gameLoginManager = require("app.game.GameLoginManager")
    local extraTable = {}
    local params = {}
    -- print("----playAds-extraTable-----", CAVEOL_TARGET, CAVEOL_TARGET_CN, device.platform, SdkBox:getInstance():getAdsSDKType())
    -- 这里CN ios 修改为了topon广告聚合平台
    if(self:isCNIOSTopOn()) then 
        local ad = self:getCNIOSTopOnPlacementID()
        -- ad = "b5b44a0f115321" -- 通用测试ID
        local ID = ad
        -- print("----playAds-extraTable-----", extraTable)
        extraTable.place = serverPlaceId
        extraTable.zone = gameLoginManager:getInstance():getServerId()
        extraTable.id = ID
        extraTable.ad = ad
        params = {
            userId = tostring(GameDataManager:getInstance():getMasterPK()),
            codeId = ad,
            serPlace = extraTable.place,
            zone = extraTable.zone,
            timeStamp = orderId,
            cfgPlace = placeId,
            extraParams = json.encode(extraTable),
        }
    else
        local ServerConfigUtil = require("app.utils.ServerConfigUtil")
        local data = ConfigManager:getAdsCodeId(placeId, device.platform, ServerConfigUtil:getProjectId()) or {}
        extraTable.place = serverPlaceId
        extraTable.zone = gameLoginManager:getInstance():getServerId()
        extraTable.id = data.ID or ""
        extraTable.ad = data.ad or ""
        params = {
            userId = tostring(GameDataManager:getInstance():getMasterPK()),
            codeId = data.ad or "",
            serPlace = extraTable.place,
            zone = extraTable.zone,
            timeStamp = orderId,
            cfgPlace = placeId,
            extraParams = json.encode(extraTable),
        }
    end

    local SdkBox = require("utils.sdkbox.SdkBox")
    --权限
    local isHavePermisson = AvalonUtil:isHavePermission(Game.AndroidPermission.ACCESS_COARSE_LOCATION)
    if device.platform == "android" and CAVEOL_TARGET ~= CAVEOL_TARGET_GLOBAL and not isHavePermisson then
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1212805, function()
            SdkBox:getInstance():loadAds(params)
        end)
        
        UI.ScrollBar:createByTextID(1170247)
    else
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            SdkBox:getInstance():playAds(params)
        end, 0.1)
    end
end

function Manager:getCNIOSTopOnPlacementID()
    return "b5efc3fbb11c7a"
    -- return "b5b44a0f115321" -- 通用测试ID
end

function Manager:isCNIOSTopOn()
    if(CAVEOL_TARGET == CAVEOL_TARGET_CN 
        and device.platform == "ios" 
        and SdkBox:getInstance():getAdsSDKType() == AdsSDKType.AdsTOPON) then 
        return true
    end

    return false
end

--[[
1、开始播放。 2、完成播放。 3、关闭广告。 4、播放失败。 5、点击UI按钮 。6、2次弹窗按钮点击确认。 7、2次弹窗按钮点击取消。
1-4 在sdk回调回来再收集
]]
function Manager:sendAdsLog(placeId, serverPlaceId, orderId, type)
    local SdkManager = require"app.game.SdkManager"

    local data = ConfigManager:getAdsCodeId(placeId, device.platform, ServerConfigUtil:getProjectId()) or {}
    local params = {}
    params.serPlace = serverPlaceId
    params.cfgPlace = placeId
    params.adsId = data.ad or ""
    params.time = orderId
    -- SdkManager:getInstance():sendWebLogWithParams(PublicDefine.WebLogType.WebLogType_AdsEvent, type, params, ADS_HTTP_REPEAT_COUNT)
    Avalon.AWSLogUtil:sendAWSAdInfo(type, data.ad, placeId, serverPlaceId)
end

-- 获取是否在新场景
function Manager:getIsInNewScene()
    if(GameManager:getIsNewTownType() and
        (SceneManager:getInstance():isInTown())) then 
        return true
    end

    return false
end

-- 
function Manager:getIsInNPCSpriteID2Zero()
    if(SceneManager:getInstance():isInTown() 
        or SceneManager:getInstance():isHome()) then 
        return true
    end

    return false
end

-- 获取是否显示自动战斗
function Manager:getIsShowAutoBattle()
    if(SceneManager:getInstance():isInFightScene()) then
        if not (SceneManager:getInstance():isInHitRat()
            or SceneManager:getInstance():isInMaze()
            or SceneManager:getInstance():isInPuzzle()
            or SceneManager:getInstance():isInHuLu()
            or SceneManager:getInstance():isInLostRealm()) then 

            return true
        end
    end

    return false
end

function Manager:getIsShowFireWork()
    if self.showFireWork == nil then 
        return true
    end

    return self.showFireWork
end

function Manager:setIsShowFireWork(flag)
    self.showFireWork = flag
end

function Manager:getIsOpenArea()
    if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
        return true
    end
    if (CAVEOL_TARGET == CAVEOL_TARGET_CN) then 
        return true
    end

    if(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL) then
        return false
    end

    return false
end

function Manager:getIsCenterByMaster()
    if SceneManager:getInstance():isInHitRat() 
        or SceneManager:getInstance():isInPuzzle()
        or SceneManager:getInstance():isInLostRealm() then
        return false
    end

    return true
end

function Manager:getLostRealmOffsetCoord()
    if(self.lostOffsetCoor) then 
        return self.lostOffsetCoor
    end
    return {x=0, y=40}
end

function Manager:setLostRealmOffsetCoord(coord)
    self.lostOffsetCoor = coord
end

function Manager:getIsGooglePlay()
    if(CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL
        and device.platform == "android") then
        return true
    end

    return false
end
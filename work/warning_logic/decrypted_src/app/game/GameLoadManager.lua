-- PlotManager.lua
-- Author:zp
-- 2017年12月5日
-- Using:提供加载页面的一些公共方法

local SceneManager = require("app.game.SceneManager")
local GameLayer = require "app.scene.gamescene.GameLayer"
local GameMapManager = require("app.game.GameMapManager")
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")

GameLoadManager = class("GameLoadManager")

local LOADING_INIT_UI_RES_PROGRESS = 0.6
local LOADING_INIT_UI_RES_TIME = 2

local LOADING_LOADING_MAP_PROGRESS = 0.8
local LOADING_LOADING_MAP_TIME = 0.5

local LOADING_INIT_SCENE_PROGRESS = 1
local LOADING_INIT_SCENE_TIME = 0.5

function GameLoadManager:ctor()
    -- 统计加载资源次数
    self._countLoadUIRes = 0
    self._countLoadPNGRes = 0
    self._countLoadSpineRes = 0

    self._prepareSyncTime = false

    self:resetLoadData()

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function GameLoadManager:dtor()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)

    self._prepareSyncTime = false
end

function GameLoadManager:resetLoadData()
    self._battleUI = nil
    self._battleMapData = nil
    self._battleCommandList = {}

    -- 这里用来标记加载完数据后运行到哪一步了， 1加载动画资源   2用于创建运行layer  >=3 运行指令
    self._step = 0
    self._waitingTime = -1

    self._loadedTime = 0
    self._loadTotalTime = 0

    self._waitingLoadSpineCount = 0
    self._loadedSpineCount = 0

    -- 保存记载动画列表
    self._loadUIResourceList = {}
    self._loadSpineResourceList = {}
    self._loadPNGResourceList = {}

    self._loadUIResEnd = false
    self._loadPNGResEnd = false
    self._loadCommonResEnd = false

    -- 是否加载完成
    self._loadingEnd = false

    self._prepareSyncTime = false
end

function GameLoadManager:addInitUIResourceList(list)
    if(list) then
        for k,v in pairs(list) do 
            table.insert(self._loadUIResourceList, v)
        end
        -- 这里是根据当前业务逻辑来写，如果逻辑业务修改需要重新修改加载位置
        self._loadUIResEnd = false
        self:loadUIRes()
    else 
        self._loadUIResEnd = true
    end
end

function GameLoadManager:addInitPNGResourceList(list)
    if(list) then
        for k,v in pairs(list) do 
            if cc.FileUtils:getInstance():isFileExist(v) then
                table.insert(self._loadPNGResourceList, v)
            end
        end
        -- 这里是根据当前业务逻辑来写，如果逻辑业务修改需要重新修改加载位置
        self._loadPNGResEnd = false
        self:loadPNGRes()
    else 
        self._loadPNGResEnd = true
    end
end

function GameLoadManager:addInitSpineResourceList(list)
    if(list) then
        -- self._waitingLoadSpineCount = 0
        -- self._loadedSpineCount = 0

        -- for k,v in pairs(list) do 
        --     table.insert(self._loadSpineResourceList, v)
        -- end

        -- self._waitingLoadSpineCount = self._waitingLoadSpineCount + 1
        -- self:loadSpineRes(function()
        --     self._loadedSpineCount = self._loadedSpineCount + 1
        -- end)
        local count = #list
        if count > 0 then
            local i = 1
            repeat
                local skeletonJSON = list[i]
                local skeletonAtlas = list[i+1]
                local skeletonScale = list[i+2]
                -- Avalon.ResHelper:pushSpine(skeletonJSON, skeletonAtlas, skeletonScale)
                self:addOneSpineResource(skeletonJSON,skeletonAtlas,skeletonScale)
                i = i + 3
            until (i >= count)
        end
        
    end

    self:loadCommonRes()
end

function GameLoadManager:addOneSpineResource(json, atlas, scale)
    if(json and atlas and scale) then
        table.insert(self._loadSpineResourceList, json)
        table.insert(self._loadSpineResourceList, atlas)
        table.insert(self._loadSpineResourceList, scale)

        self._waitingLoadSpineCount = self._waitingLoadSpineCount + 1
        Avalon.ResHelper:loadSpine(json, atlas, scale, self, function()
            self._loadedSpineCount = self._loadedSpineCount + 1
            
        end)
    end 
    -- print("self._loadSpineResourceList",#self._loadSpineResourceList/3)
end

function GameLoadManager:setLoadingInitUIResTime(progress, time)
    if(time and progress) then
        LOADING_INIT_UI_RES_PROGRESS = progress
        LOADING_INIT_UI_RES_TIME = time
    end
end

function GameLoadManager:setLoadingMapDataTime(progress, time)
    if(time) then
        LOADING_LOADING_MAP_PROGRESS = progress
        LOADING_LOADING_MAP_TIME = time
    end 
end

function GameLoadManager:setLoadingInitSceneTime(progress, time)
    if(time) then
        LOADING_INIT_SCENE_PROGRESS = progress
        LOADING_INIT_SCENE_TIME = time
    end
end

-- 添加命令
function GameLoadManager:_pushCommand(command)
    -- 数据加载完成
    if (not GameManager._isLoadingData) then
        if(self._loadingEnd) then
            if (MachineManager:getInstance():getMachine()) then
                MachineManager:getInstance():getMachine():pushCommand(command)
            else
                table.insert(self._battleCommandList, command)
            end
        else 
            table.insert(self._battleCommandList, command)
        end
    -- 场景创建之前，加载数据阶段
    else
        self:_loadData(command)
    end
end

-- 加载游戏数据
function GameLoadManager:_loadData(command)
    local commandType = command.type

    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        local mapData = GameMapManager:getInstance():loadMapDataForState(command.data)

        -- 处理加载使用到的资源文件
        if(mapData and not GameManager:getIsInNewScene()) then
            local level = mapData.level 
            local caveMode = mapData.caveMode
            local difficulty = mapData.difficulty
            if(caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL) then 
                local mapConfig = ConfigManager:getMapLevelConfig(level, caveMode, difficulty)
                if(mapConfig) then 
                    if(mapConfig.monsterID) then
                        for _,monsterID in ipairs(mapConfig.monsterID) do 
                            local monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(monsterID, GameMapManager:getInstance():getModel(), GameMapManager:getInstance():getDifficulty())
                            if(monsterData) then 
                                local spine = monsterData.spine
                                if (spine and spine ~= "") then
                                    local skeletonJSON = spine..".json"
                                    local skeletonAtlas = spine..".atlas"
                                    local skeletonScale = Game.MONSTER_ANIMATION_SCALE

                                    self:addOneSpineResource(skeletonJSON, skeletonAtlas, skeletonScale)
                                end
                            end
                        end 
                    end

                    if(mapConfig.boxID) then
                        for _,templateID in ipairs(mapConfig.boxID) do 
                            local triggerNPCData = Data.TriggerNpcData:create(templateID)
                            local spine = triggerNPCData.spine
                            
                            if(triggerNPCData and not (triggerNPCData:getCategory() == Category.TRIGGER_NPC  and triggerNPCData:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE) ) then
                                if (spine and spine ~= "") then
                                    local skeletonJSON = spine..".json"
                                    local skeletonAtlas = spine..".atlas"
                                    local skeletonScale = Game.NPC_ANIMATION_SCALE

                                    self:addOneSpineResource(skeletonJSON, skeletonAtlas, skeletonScale)
                                end
                            end
                        end 
                    end
                end
            end 
        end
        SceneManager:getInstance():setLoadingProgressAndTime(LOADING_LOADING_MAP_PROGRESS, LOADING_LOADING_MAP_TIME)
        self._loadTotalTime = self._loadTotalTime + LOADING_LOADING_MAP_TIME
        -- print("GameLoadManager loadDataForInCaveState: 加载地图数据完成...")
    elseif (commandType == CommandType.CONTROL_GLOBAL_TRIGGERNPC) then
        if(not GameManager:getIsInNewScene()) then
            if not AvalonUtil.isSmallMemoryDevice() then
                -- print("ROLE_GLOBAL_TRIGGER_NPC 11111=", command.data)
                local data = command.data 
                local triggerNPCData = Data.TriggerNpcData:create(data.templateID)
                local spine = triggerNPCData.spine  
                if(triggerNPCData and not (triggerNPCData:getCategory() == Category.TRIGGER_NPC  and triggerNPCData:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE) ) then
                    if (spine and spine ~= "") then
                        -- print("ROLE_GLOBAL_TRIGGER_NPC .boxID=", spine)
                        local skeletonJSON = spine..".json"
                        local skeletonAtlas = spine..".atlas"
                        local skeletonScale = Game.NPC_ANIMATION_SCALE

                        self:addOneSpineResource(skeletonJSON, skeletonAtlas, skeletonScale)
                    end
                end    
            end
        end
    elseif (commandType == CommandType.CONTROL_WAITING_BEGIN_SYNC) then
        local callFunction = function ()
            -- print("CONTROL_WAITING_BEGIN_SYNC load mapResEnd", self._step, self._loadedTime, self._loadTotalTime,AvalonUtil.getCurrentTime())
            self._prepareSyncTime = true
            if SceneManager:getInstance():isInPetPVP() then
                isFromChangeSceneUsedInEnterScence = true
                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_ENTER_SCENE, nil)
                SceneManager:getInstance():pushCommand(command)
            end
        end

        if(not GameManager:getIsInNewScene()) then
            GameMapManager:getInstance():loadMapResForState(callFunction)
        else
            callFunction() 
        end
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        NetHelper:disableParallel()
        if(SceneManager:getInstance():getIsDownstairs()) then
            self:endLoading()
            self._waitingTime = -1
        else 
            if(SceneManager:getInstance():isInFightScene()) then 
                self._step = 3
                self._waitingTime = 0.01
                SceneManager:getInstance():setLoadingProgressAndTime(LOADING_INIT_SCENE_PROGRESS, self._waitingTime)
            else 
                self._step = 0
                self._waitingTime = LOADING_INIT_SCENE_TIME

                SceneManager:getInstance():setLoadingProgressAndTime(LOADING_INIT_SCENE_PROGRESS, self._waitingTime)
            end
        end 

        if MasterDataManager:getAutoShowSelectFlag() then
            local subCommand = Command.ControlCommand:create(true)
            subCommand:initForTypeAndData(CommandType.CONTROL_OPEN_UILAYER, AvalonMessage.MC_UI_SHOW_DREAM_CHALLENGE)
            self:_pushCommand(subCommand)
            MasterDataManager:setAutoShowSelectFlag(false)
        end
    else
        -- print(string.format("GameLoadManager loadDataForInCaveState: 加载了一条数据, command type %d. ", command.type))
    end
    table.insert(self._battleCommandList, command)
end

function GameLoadManager:update(dt)
    self._loadedTime = self._loadedTime + dt

    if self._loadUIResEnd and self._loadPNGResEnd and self._loadCommonResEnd and self._waitingLoadSpineCount <= self._loadedSpineCount and self._prepareSyncTime then 
        if(SceneManager:getInstance():getIsDownstairs()) then 
            self._prepareSyncTime = false
            NetHelper:enableParallel()
            GameManager:syncTimeRequest()
        else 
            if(self._loadedTime >= self._loadTotalTime) then 
                self._prepareSyncTime = false
                NetHelper:enableParallel()
                GameManager:syncTimeRequest()
            end
        end
    end

    if(self._waitingTime > 0) then
        -- print("GameLoadManager:update", self._loadUIResEnd, self._waitingLoadSpineCount,self._loadedSpineCount, self._loadedTime, self._loadTotalTime )
        if self._loadUIResEnd and self._loadPNGResEnd and self._loadCommonResEnd and self._waitingLoadSpineCount <= self._loadedSpineCount and self._loadedTime >= self._loadTotalTime then
            self._step = self._step + 1
            self._waitingTime = self._waitingTime - dt
            if(self._step <= 4 and self._waitingTime <= 0) then
                self._waitingTime = self._waitingTime + dt
                SceneManager:getInstance():setLoadingProgressAndTime(LOADING_INIT_SCENE_PROGRESS, dt)
            end
            if(self._waitingTime <= 0) then
                -- 执行指令
                self:endLoading()

                self._waitingTime = -1
            end
        else 
            if(self._loadedTime >= self._loadTotalTime) then 
                SceneManager:getInstance():setLoadingProgressAndTime(LOADING_INIT_SCENE_PROGRESS, dt)
                self._loadTotalTime = self._loadTotalTime + dt
            end
        end
    end
end

-- 父类，需要子类实现该方法
function GameLoadManager:createLayer()
    printError("[ERROR] GameLoadManager:createLayer this method should be overrided.")
end

-- 父类，需要子类实现该方法
function GameLoadManager:createMachine()
    printError("[ERROR] GameLoadManager:createMachine this method should be overrided.")
end

function GameLoadManager:createUIManager()
    printError("[ERROR] GameLoadManager:createUIManager this method should be overrided.")
end

function GameLoadManager:endLoading()
    print("GameLoadManager:endLoading")
    SceneManager:getInstance():removeLodingScene(function()
        if(self) then
            if SceneManager:getInstance():isInPetPVP() then
                local GameInCaveManager = require("app.game.GameInCaveManager")
                local gameLayer = GameInCaveManager:getInstance():createLayer()
                gameLayer:setName("PETPVP")
                self._sceneLayer:addChild(gameLayer, 10000)
                -- 创建machine
                local battleLayer = gameLayer:getSceneLayer();
                local machine = GameInCaveManager:getInstance():createMachine()
                MachineManager:getInstance():setMachine(machine)
                MachineManager:getInstance():getMachine():init(battleLayer)

                local battleUILayer = gameLayer:getUILayer();
                self._battleUI = self:createPetPVPUI()
                if (self._battleUI) then
                    battleUILayer:addChild(self._battleUI)
                else
                    printError("[ERROR] [GameLoadManager] fail to create battle UI.")
                end

                GameManager._isLoadingData = false
                self._loadingEnd = true
                MachineManager:getInstance():getMachine():executeCommandList(self._battleCommandList)
                GameManager:clearCommandList(self._battleCommandList, true)

                
                -- ---debug
                -- local btnDebugLogLayer = UI.Button:create()
                -- btnDebugLogLayer:init()
                -- btnDebugLogLayer:centerUp(40)
                -- btnDebugLogLayer:setSize(100, 30)
                -- btnDebugLogLayer:setTextFont(UI.SYS_FONT, 25, UI.FONT_COLOR_255_255_255)
                -- btnDebugLogLayer:setFontSize(25)
                -- btnDebugLogLayer:setText("关闭")--(string.format(UI.TEXT_1170214,100))--
                -- btnDebugLogLayer:setEnableMinTouchSize(false)
                -- btnDebugLogLayer:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)   
                --     self:endPetPVP()
                -- end)
                -- gameLayer:addChild(btnDebugLogLayer, 10000)
            else
                -- 创建场景对象
                local gameLayer = self:createLayer()
                -- SceneManager:getInstance():addSceneLayer(gameLayer)
                SceneManager:getInstance():replaceScene(gameLayer)
                self._sceneLayer = gameLayer
                -- 创建machine
                local battleLayer = self._sceneLayer:getSceneLayer();
                local machine = self:createMachine()
                MachineManager:getInstance():setMachine(machine)
                MachineManager:getInstance():getMachine():init(battleLayer)
                -- 创建天气系统
                local weatherLayer = self._sceneLayer:getWeatherLayer();
                local weather = self:createWeatherManager();
                if weather then
                    weatherLayer:addChild(weather)
                end
                -- 创建ui
                local battleUILayer = self._sceneLayer:getUILayer();
                self._battleUI = self:createUIManager()
                if (self._battleUI) then
                    battleUILayer:addChild(self._battleUI)
                else
                    printError("[ERROR] [GameLoadManager] fail to create battle UI.")
                end

                GameManager._isLoadingData = false
                self._loadingEnd = true
                MachineManager:getInstance():getMachine():executeCommandList(self._battleCommandList)
                GameManager:clearCommandList(self._battleCommandList, true)
                SceneManager:getInstance():endLoadingScene()

                self._sceneLayer:beginShow()
                Game.FunctionUnlockManager:getInstance():noticeShowAction()

                -- 触发活动NPC吆喝
                local battleCMD = Command.BattleCommand:create(true)
                battleCMD:initTriggerNpcActivityCrying()
                SceneManager:getInstance():pushCommand(battleCMD)
                -- 刷新最大分数
                local masterData = RoleDataManager:getMaster()
                if(masterData) then
                    MasterDataManager:updateMaxEquipScore(masterData:getCombatScore())
                    --清理掉repeatdata 
                    MasterDataManager:clearAllRepeatHandleData()
                end
                print("GameLoadManager:endLoading  isDownstairs=", SceneManager:getInstance():getIsDownstairs())
                if(SceneManager:getInstance():getIsDownstairs()) then
                    Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SHOW_DOWNSTAIRS_ENTER)
                end
                -- 触发请求前面排行的数据处理
                MasterDataManager:triggerRefreshPreRankData()

                -- 入场效果
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.ENTER_GAME_SCENE, self)

                -- 上报完成进入场景
                local gameLoginManager = require("app.game.GameLoginManager")
                gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Loading_Client_IntoScene_Done)
                if SceneManager:getInstance():isInCave() and SceneManager:getInstance():isInShopCave() then
                    local level = GameMapManager:getInstance():getLevel()
                    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
                    level = LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(level)
                    GameDataManager:getInstance():enterNormalShopCaveReport(level)
                end
                Net.NetChatSystem:requestAllLampDatas()

                if(not GameManager:getIsNewTownType() 
                    and SceneManager:getInstance():isHome()) then
                    Net.NetRoleSystem:reqEnterTownScene()
                end
            end
        end
    end)
    self._loadUIResEnd = false
    self._loadPNGResEnd = false
    self._loadCommonResEnd = false
end

function GameLoadManager:loadCommonRes()
    GameManager:triggerLoadCommonRes(handler(self, function()
        self._loadCommonResEnd = true
    end))
end

-- 记载动画资源
function GameLoadManager:loadSpineRes(callback)
    local i = 1
    local GAME_IN_CAVE_SPINE_RES_LIST = self._loadSpineResourceList
    local count = #GAME_IN_CAVE_SPINE_RES_LIST
    if(count > 0) then 
        Avalon.ResHelper:beginLoading(nil, function()
            if (callback) then
                callback()
            end
        end)

        repeat
            local skeletonJSON = GAME_IN_CAVE_SPINE_RES_LIST[i]
            local skeletonAtlas = GAME_IN_CAVE_SPINE_RES_LIST[i+1]
            local skeletonScale = GAME_IN_CAVE_SPINE_RES_LIST[i+2]
            Avalon.ResHelper:pushSpine(skeletonJSON, skeletonAtlas, skeletonScale)

            i = i + 3
        until (i >= count)

        Avalon.ResHelper:endLoading()
        self._countLoadSpineRes = self._countLoadSpineRes + 1
    else 
        if (callback) then
            callback()
        end
    end
end

-- 卸载动画资源
function GameLoadManager:unloadSpineRes()
    -- print("GameLoadManager:unloadSpineRes()",#self._loadSpineResourceList/3)
    -- if(self._countLoadSpineRes > 0) then
    local i = 1

    local GAME_IN_CAVE_SPINE_RES_LIST = self._loadSpineResourceList
    -- dump(GAME_IN_CAVE_SPINE_RES_LIST)
    local count = #GAME_IN_CAVE_SPINE_RES_LIST
    if count > 0 then
        repeat
            local skeletonJSON = GAME_IN_CAVE_SPINE_RES_LIST[i]
            local skeletonAtlas = GAME_IN_CAVE_SPINE_RES_LIST[i+1]
            local skeletonScale = GAME_IN_CAVE_SPINE_RES_LIST[i+2]
            
            Avalon.ResHelper:unloadSpine(skeletonJSON, skeletonAtlas, skeletonScale)
            -- print("Avalon.ResHelper:unloadSpine",skeletonJSON)
            i = i + 3
        until (i >= count)    
    end
    

    self._countLoadSpineRes = self._countLoadSpineRes - 1
    -- end
end

-- 加载PNG资源
function GameLoadManager:loadPNGRes(callback)
    Avalon.ResHelper:beginLoading(nil, function()
        self._loadPNGResEnd = true
        if (callback) then
            callback()
        end
    end)

    local GAME_IN_CAVE_UI_RES_PLISTS = self._loadPNGResourceList
    for i = 1, #GAME_IN_CAVE_UI_RES_PLISTS do
        Avalon.ResHelper:pushImage(GAME_IN_CAVE_UI_RES_PLISTS[i])
    end
    Avalon.ResHelper:endLoading()
    self._countLoadPNGRes = self._countLoadPNGRes + 1

    SceneManager:getInstance():setLoadingProgressAndTime(LOADING_INIT_UI_RES_PROGRESS, 0.1)
    self._loadTotalTime = self._loadTotalTime + 0.1
end

-- 卸载PNG资源
function GameLoadManager:unloadPNGRes()
    if(self._countLoadPNGRes >0) then
        local GAME_IN_CAVE_UI_RES_PLISTS = self._loadPNGResourceList
        for i = 1, #GAME_IN_CAVE_UI_RES_PLISTS do
            Avalon.ResHelper:unloadImage(GAME_IN_CAVE_UI_RES_PLISTS[i])
        end
        self._countLoadPNGRes = self._countLoadPNGRes - 1
    end
end

-- 加载ui资源
function GameLoadManager:loadUIRes(callback)
    Avalon.ResHelper:beginLoading(nil, function()
        self._loadUIResEnd = true
        if (callback) then
            callback()
        end
    end)

    local GAME_IN_CAVE_UI_RES_PLISTS = self._loadUIResourceList
    for i = 1, #GAME_IN_CAVE_UI_RES_PLISTS do
        Avalon.ResHelper:pushPlist(GAME_IN_CAVE_UI_RES_PLISTS[i])
    end
    Avalon.ResHelper:endLoading()
    self._countLoadUIRes = self._countLoadUIRes + 1

    SceneManager:getInstance():setLoadingProgressAndTime(LOADING_INIT_UI_RES_PROGRESS, LOADING_INIT_UI_RES_TIME)
    self._loadTotalTime = self._loadTotalTime + LOADING_INIT_UI_RES_TIME
end

-- 卸载ui资源
function GameLoadManager:unloadUIRes()
    if(self._countLoadUIRes >0) then
        local GAME_IN_CAVE_UI_RES_PLISTS = self._loadUIResourceList
        for i = 1, #GAME_IN_CAVE_UI_RES_PLISTS do
            Avalon.ResHelper:unloadPlist(GAME_IN_CAVE_UI_RES_PLISTS[i])
        end
        self._countLoadUIRes = self._countLoadUIRes - 1
    end
end

-- 获取战斗中的游戏模型
function GameLoadManager:getBattleModel()
    if (MachineManager:getInstance():getMachine()) then
        return MachineManager:getInstance():getMachine():getModel()
    end
    return nil
end

-- 获取战斗中的角色模型,未调用
function GameLoadManager:getBattleRole(roleSpriteID)
    if (MachineManager:getInstance():getMachine()) then
        local battleModel = MachineManager:getInstance():getMachine():getModel()
        if (battleModel) then
            return battleModel:getRoleBySpriteID(roleSpriteID)
        end
    end
    return nil
end
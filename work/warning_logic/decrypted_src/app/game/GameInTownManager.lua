--[[
    城镇中的游戏管理
]]--

require "app.town.TownMachine"
require "app.battle.BattleMachine"
require "app.game.GameLoadManager"

local SceneManager = require("app.game.SceneManager")
local TownLayer = require "app.scene.townscene.TownLayer"
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local WeatherManager = require("app.game.WeatherManager")
local MapDataManager = require "app.mapkit.model.MapDataManager"
local MapDefine = require "app.mapkit.MapDefine"

local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE

local GameInTownManager = class("GameInTownManager", GameLoadManager)
g_GameInTownManager = nil;

-- 主城压力测试
local TOWN_PRESSURE_TEST_HERO_COUNT = 160
function GameInTownManager:startTownPressureTest()
    local mapData = GameMapManager:getInstance():getMapData()
    local mapWidth, mapHeight = mapData:getSize()

    print(string.format("GameInTownManager startTownPressureTest: map data size %f %f.", mapWidth, mapHeight))

    -- math.randomseed(os.time())
    -- 生成测试的玩家数据
    for i = 1, TOWN_PRESSURE_TEST_HERO_COUNT do
        local coordX = 31
        local coordY = 22
        local tileData = nil
        -- repeat
        --     coordX = math.random(0, mapWidth-1)
        --     coordY = math.random(0, mapHeight-1)
        --     tileData = mapData:getTileDataAtCoord(coordX, coordY)
        -- until (tileData and tileData:getTerrainType() == MapDefine.TerrainType.Ground)

        print(string.format("GameInTownManager startTownPressureTest: i %d  role coord %f %f.", i, coordX, coordY))
        local GameDataManager = require("app.game.GameDataManager")
        -- 获取玩家当前装备来模拟测试数据
        local bagData = GameDataManager:getInstance():getPacketBoxData()
        local equipmentArr = {}
        if(bagData.wearEquipmentArr) then
            for _,equipmentData in ipairs(bagData.wearEquipmentArr) do 
                local equipment = {}
                equipment.templateID = equipmentData.ID
                equipment.index = equipmentData.index

                table.insert(equipmentArr, equipment)
            end
        end
        print("GameInTownManager startTownPressureTest  equipmentNum", #equipmentArr)

        local heroDataMessage = {
            pk = 10000 + i,
            spriteID = 10000 + i,
            nickName = "猜猜我是谁",
            occupation = 1,
            coordX = coordX,
            coordY = coordY,
            equipment = equipmentArr,
        }
        local heroData = Data.HeroData:create()
        heroData:changeInit(heroDataMessage)
        heroData:handleAttr(heroDataMessage.attr)

        -- 生成创建测试角色的命令
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SCREENHERO, heroData)
        self:_pushCommand(command)
    end
end

function GameInTownManager:getInstance()
    if g_GameInTownManager == nil then
        g_GameInTownManager = GameInTownManager.new()
    end
    return g_GameInTownManager;
end


function GameInTownManager:purgeInstance()
    if g_GameInTownManager ~= nil then
        g_GameInTownManager = nil;
    end
end

function GameInTownManager:ctor()
    GameInTownManager.super.ctor(self)
end

local LOADED_STEPS = 4
local NEXT_STEP_INTERVAL = 0.05

-- 加载的动画资源列表
local GAME_IN_CAVE_SPINE_RES_LIST = {

}

local GAME_IN_TOWN_UI_RES_PLISTS = {

}

local GAME_IN_TOWN_PNG_RES_PLISTS = {
    "image/levelSelect/ui_selectfloor_heromap_1.png",
    "image/levelSelect/ui_selectfloor_heromap_2.png",
    "image/levelSelect/ui_selectfloor_plotmap_1.png",
    "image/levelSelect/ui_selectfloor_plotmap_2.png",
}

-- 初始化,目前没用
function GameInTownManager:initForInTownState()
   
end

-- 添加命令
function GameInTownManager:pushCommandForInTownState(command)
    -- print("###GameInTownManager:pushCommandForInTownState")

    if (GameManager._isLoadingData) then
        self:loadDataForInTownState(command)
    end
    if command.type == CommandType.CONTROL_END_PET_PVP then
        self:endPetPVP()
    end
    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInTownManager:loadDataForInTownState(command)
    -- print("GameInTownManager:loadDataForInTownState")
    local commandType = command.type
    -- print("GameInTownManager:loadDataForInTownState  commandType=",commandType)
    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        self:setLoadingMapDataTime(0.8, 0.5)
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:setLoadingInitSceneTime(1, 0.5)        
    else
        -- assert(false, string.format("[ERROR] command type %d is invalid when loading scene.", commandType))
    end
end

-- 
function GameInTownManager:createLayer()
    return TownLayer:create()
end

function GameInTownManager:createMachine()
    return Town.Machine:create()
end

function GameInTownManager:createUIManager()
    return UI.UIManager:loadTownUI()
end
function GameInTownManager:createWeatherManager( )
    return WeatherManager:getInstance():loadWeaterSystem();
end
-- public:

-- 获取城镇中的游戏模型
function GameInTownManager:getTownModel()
    if (MachineManager:getInstance():getMachine()) then
        return MachineManager:getInstance():getMachine():getModel()
    end
    return nil
end

function GameInTownManager:loginEnterTown()
    self:enterTown()
    -- 进入加载场景
    SceneManager:getInstance():replaceLoadingScene()
end

-- 玩家进入城镇
function GameInTownManager:enterTown()
    print("GameInTownManager:enterTown")

    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)

    -- 设置包裹类型
    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)
    SceneManager:getInstance()._state = GameState.IN_TOWN

    
    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true

    -- 处理加载资源
    self:setLoadingInitUIResTime(0.6, 1)

    self:addInitUIResourceList(GAME_IN_TOWN_UI_RES_PLISTS)
    self:addInitPNGResourceList(GAME_IN_TOWN_PNG_RES_PLISTS)
    self:addInitSpineResourceList(GAME_IN_CAVE_SPINE_RES_LIST)
end

-- 退出城镇
function GameInTownManager:exitTown()
    if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():destroy()
        MachineManager:getInstance():setMachine(nil);
    end
    -- 清理其余角色数据
    if(RoleDataManager) then
        RoleDataManager:clearOtherData()
    end

    UI.UIManager:unloadTownUI()
    
    WeatherManager:getInstance():unloadWeaterSystem();

    GameMapManager:getInstance():unloadMapResForState()
    self:unloadUIRes()
    self:unloadPNGRes()
    self:unloadSpineRes()

    -- add by yys 暂时不调用
    -- display.removeUnusedSpriteFrames()
    collectgarbage("collect")

    -- 清理加载数据
    self:resetLoadData()
end

function GameInTownManager:createPetPVPUI()
    return UI.UIManager:loadPetPVPUI()
end

--[[实现保留model 和 view的切换]]
function GameInTownManager:beginPetPVP()
    if (MachineManager:getInstance():getMachine()) then
        self.view = MachineManager:getInstance():getMachine()._view
        self.model = MachineManager:getInstance():getMachine()._model
        MachineManager:getInstance():getMachine():destroy(true)
        self.view:setVisible(false)
        MachineManager:getInstance():setMachine(nil);
    end
end

--加载资源
function GameInTownManager:enterPetPVP()
    print("GameInCaveManager:enterPetPVP")
    -- 记录宠物战斗前的state
    SceneManager:getInstance()._state = GameState.PET_PVP
    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true
    self:setLoadingInitUIResTime(0.8, 2)

    self:addInitUIResourceList({})
    self:addInitPNGResourceList({})
    self:addInitSpineResourceList({})
end

--执行TRANS_SCENE，释放BattleMachie创建TownMachine，释放宠物战斗资源（整套mvc都释放掉）， 把之前没有释放的townview和townModel挂到TownMachine上
function GameInTownManager:endPetPVP()
    if not SceneManager:getInstance():isInPetPVP() then
        return
    end
    --怎么卸载动画资源、地图资源、UI资源
    MachineManager:getInstance():getMachine():executeCommandList(self._battleCommandList)
    GameManager:clearCommandList(self._battleCommandList, true)
   if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():destroy()
        MachineManager:getInstance():setMachine(nil);
    end

    self.view:setVisible(true)
    self._sceneLayer:removeChildByName("PETPVP")
    GameMapManager:getInstance():unloadMapResForState()
    -- 恢复宠物战斗前的state
    -- SceneManager:getInstance()._state = GameState.IN_TOWN
    SceneManager:getInstance()._state = SceneManager:getInstance()._preState
    
    local battleLayer = self._sceneLayer:getSceneLayer();
    
    local machine = self:createMachine()
    MachineManager:getInstance():setMachine(machine)

    MachineManager:getInstance():getMachine():initWithViewAndMode(self.view, self.model)

    local battleUILayer = self._sceneLayer:getUILayer();
    self._battleUI = self:createUIManager()
    if (self._battleUI) then
        battleUILayer:addChild(self._battleUI)
    else
        printError("[ERROR] [GameLoadManager] fail to create battle UI.")
    end
    RoleDataManager:clearPetPVPRoles()
    Net.PetPVPProxy:destroy()

    collectgarbage("collect")
    --请求同屏角色数据
    Net.NetRoleSystem:reqSynScreenRole()
    mvc.send("PetTreasure_Handle_Open_origin_Layer")
    AudioUtil:playSceneMusic()

    local data = {}
    local GameDataManager = require("app.game.GameDataManager")
    data.spriteID = GameDataManager:getInstance():getMaster():getSpriteID()
    local command = Command.ControlCommand:create(true)
    command:initForTypeAndData(CommandType.CONTROL_NOTIFY_HERO_STOP_MOVE,data)
    SceneManager:getInstance():pushCommand(command)
    
end


return GameInTownManager;


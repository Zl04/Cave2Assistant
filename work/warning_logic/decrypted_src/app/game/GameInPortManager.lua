--[[
    港口的游戏管理
]]--

require "app.town.TownMachine"
require "app.battle.BattleMachine"
require "app.game.GameLoadManager"

local SceneManager = require("app.game.SceneManager")
local TownLayer = require "app.scene.townscene.TownLayer"
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
local MapDataManager = require "app.mapkit.model.MapDataManager"
local WeatherManager = require("app.game.WeatherManager")
local MapDefine = require "app.mapkit.MapDefine"

local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE

local GameInPortManager = class("GameInPortManager", GameLoadManager)
g_GameInPortManager = nil;

local BUILD2FUNCTION = {
    [PublicDefine.ManorBuildID.BuildID_Manor] = PublicDefine.FUNCTION_TYPE.FUNCTION_MANOR_HOUSEKEEPER, -- 管家NPC
    [PublicDefine.ManorBuildID.BuildID_StarMap] = PublicDefine.FUNCTION_TYPE.FUNCTION_MANOR_DESK, -- 书桌NPC
    [PublicDefine.ManorBuildID.BuildID_TravelShop] = PublicDefine.FUNCTION_TYPE.FUNCTION_TRAVELING_BUSINESSMAN, -- 行商NPC
    [PublicDefine.ManorBuildID.BuildID_Dock] = PublicDefine.FUNCTION_TYPE.FUNCTION_MANOR_BOAT, -- 远航NPC
    [PublicDefine.ManorBuildID.BuildID_Table] = PublicDefine.FUNCTION_TYPE.FUNCTION_MANOR_DININGTABLE, -- 餐桌NPC
}

local SailEventType =
{
    SailEventType_SetSail = 1;                              -- 出航
    SailEventType_FinishSail = 2;                           -- 航行结束
    SailEventType_OutOfSupply = 3;                          -- 补给耗尽
    SailEventType_RecoverSupply = 4;                        -- 补给恢复
    SailEventType_DropStarCard = 5;                         -- 星辰卡掉落
    
    SailEventType_EventTriggered = 11;                      -- 事件触发
    SailEventType_EventDetermine = 12;                      -- 事件判定
    
    SailEventType_AcquireSupply = 21;                        -- 补给变化
    SailEventType_AcquireSupplyPercent = 22;                 -- 补给变化百分比
    SailEventType_ChangeSpeed = 23;                         -- 速度变化
    SailEventType_ChangeSpeedPercent = 24;                  -- 速度变化百分比
    SailEventType_ChangeConsume = 25;                       -- 消耗补给
    SailEventType_ChangeConsumePercent = 26;                -- 消耗补给百分比
    SailEventType_DropItem = 27;                            -- 物品掉落
    SailEventType_StayInplace = 28;                         -- 原地停留
}

-- 主城压力测试
local TOWN_PRESSURE_TEST_HERO_COUNT = 40
function GameInPortManager:startTownPressureTest()
    local mapData = GameMapManager:getInstance():getMapData()
    local mapWidth, mapHeight = mapData:getSize()

    print(string.format("GameInPortManager startTownPressureTest: map data size %f %f.", mapWidth, mapHeight))

    -- math.randomseed(os.time())
    for i = 1, TOWN_PRESSURE_TEST_HERO_COUNT do
        local coordX = 31
        local coordY = 22
        local tileData = nil
        -- repeat
        --     coordX = math.random(0, mapWidth-1)
        --     coordY = math.random(0, mapHeight-1)
        --     tileData = mapData:getTileDataAtCoord(coordX, coordY)
        -- until (tileData and tileData:getTerrainType() == MapDefine.TerrainType.Ground)

        print(string.format("GameInPortManager startTownPressureTest: i %d  role coord %f %f.", i, coordX, coordY))

        local heroDataMessage = {
            pk = 10000 + i,
            spriteID = 10000 + i,
            nickName = "猜猜我是谁",
            occupation = 1,
            coordX = coordX,
            coordY = coordY,
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

function GameInPortManager:getInstance()
    if g_GameInPortManager == nil then
        g_GameInPortManager = GameInPortManager.new()
    end
    return g_GameInPortManager;
end


function GameInPortManager:purgeInstance()
    if g_GameInPortManager ~= nil then
        g_GameInPortManager:dtor()
        g_GameInPortManager = nil;
    end
end

function GameInPortManager:ctor()
    GameInPortManager.super.ctor(self)
    
    self._townMapData = nil

    -- 统计加载资源次数
    self._countLoadUIRes = 0
    self._countLoadSpineRes = 0
    self._fishingLayer = nil

    --今日已钓鱼次数
    self._fishingTime = 0
    --庄园通用数据 (自己的)
    self._manorCommonData = {}
    --庄园通用数据 (场景的))
    self._manorSceneCommonData = {}
    --庄园主PK
    self._ownerPk = 0
    --所有在线好友的行商数据
    self._purchaseItems = {}
    --自己 行商选择的材料航线ID
    self._raderMaterialId = 0
    --行商材料刷新航线ID列表
    self._unlockMaterials = {}
    --上次获取行商数据的服务器时间天数
    self._gameDay = 0

    -- 建筑数据
    self._buildsData = {}
    -- 当前进入的庄园建筑数据
    self._curEnteredBuildsData = {}

    -- 庄园外观数据
    self._baseData  = {}


    -- --测试数据
    -- --自己 行商选择的材料航线ID
    -- self._raderMaterialId = 2
    -- --行商材料刷新航线ID列表
    -- self._unlockMaterials = {1,2,3,4,5}

    self:registerListener()
end

function GameInPortManager:dtor()
    self:unRegisterListener()
end

function GameInPortManager:setOwnerPk(ownerPk)
    self._ownerPk = ownerPk
end

function GameInPortManager:getOwnerPk()
    return self._ownerPk
end

function GameInPortManager:updateFishingTime(fishingTime)
    self._fishingTime = fishingTime
end

function GameInPortManager:updateBuildsData(buildsData)
    for k,v in pairs(buildsData) do
        self._buildsData[v.buildId] = v
    end
end

function GameInPortManager:updateMannorBaseData(baseData)
        self._baseData = baseData
end

function GameInPortManager:updateMannorBaseDataFacadeId(facadeId)
    self._baseData.facadeId = facadeId
end

function GameInPortManager:updateCurEnteredBuildsData(buildsData)
    for k,v in pairs(buildsData) do
        self._curEnteredBuildsData[v.buildId] = v
    end
end

function GameInPortManager:updateManorCommonData(manorCommonData)
    self._manorCommonData = manorCommonData
end

function GameInPortManager:updateManorSceneCommonData(ownerPk,manorCommonData)
    self._manorSceneCommonData[ownerPk] = manorCommonData
end



function GameInPortManager:getBuildDataByBuildId(buildId)
    return self._buildsData[buildId]
end

--检测指定类型建筑是否满足给定等级
function GameInPortManager:checkBuildLevelIsConditions(buildId, level)
    local isConditions = false

    if self._buildsData[buildId] and self._buildsData[buildId].level >= level then
        isConditions = true
    end

    return isConditions
end

function GameInPortManager:getMannorBaseData()
    return self._baseData
end

function GameInPortManager:getCurEnteredBuildDataByBuildId(buildId)
    return self._curEnteredBuildsData[buildId]
end


function GameInPortManager:updatePurchaseItems(data)

    local purchaseItems = data.purchaseItems
    local gameDay = data.gameDay
    if gameDay ~= self._gameDay then
        self._gameDay = gameDay
        self._purchaseItems = purchaseItems
    else
        for _,v in pairs(purchaseItems) do
            local need = true
            for _,item in pairs(self._purchaseItems) do
                if item.pk == v.pk then
                    need = false

                    item.saleID = v.saleID
                    item.giveID = v.giveID
                    item.givePrice = v.givePrice

                    break
                end
            end

            if need then
                table.insert(self._purchaseItems,v)
            end
        end

    end

    -- required uint64 pk = 1;// PK
    -- optional uint32 saleID = 2;// 收购的物品ID
    -- optional uint32 giveID = 3;// 给与的物品ID
    -- optional uint32 givePrice = 4;// 给与的物品价格

    -- self._purchaseItems = purchaseItems
end

function GameInPortManager:updateRaderMaterialId(materialId)    
    self._raderMaterialId = materialId or 0
end

function GameInPortManager:getRaderMaterialId()    
    return self._raderMaterialId
end

function GameInPortManager:updatePedleryMaterialData(data)    
    self._unlockMaterials = data.unlockMaterials or {}
    if data.chooseId and data.chooseId > 0 then
        self._raderMaterialId = data.chooseId
    end
end

function GameInPortManager:getMateriaRouteList()
    return self._unlockMaterials
end

function GameInPortManager:havaMateriaRoute(materialId)
    local have = false
    for k,v in pairs(self._unlockMaterials) do
        if tonumber(v) == tonumber(materialId) then
            have = true
            break
        end
    end

    return have
end

function GameInPortManager:isSelectRaderMaterialId(materialId)
    local isSelect = false
    if tonumber(self._raderMaterialId) == tonumber(materialId) then
        isSelect = true
    end
    return isSelect
end


function GameInPortManager:getFriendPurchaseItemByPk(friendPk)
    local purchaseItem = nil

    -- local nowTime = GameManager:getNowCurDayByTimestamp(timestamp)


    for k,v in pairs(self._purchaseItems) do
        -- print("v.pk ===== ",v.pk,friendPk)
        if (v.pk == friendPk and v.saleID ~= 0 and v.giveID ~= 0) then
            purchaseItem = clone(v)
            break
        end
    end

    return purchaseItem
end

function GameInPortManager:getRemainingFishingTime()
    local dailyFishingTime = tonumber(ConfigManager:getDailyFishingTime())
    local heroData = RoleDataManager:getMaster()
    if heroData then
        dailyFishingTime = dailyFishingTime + heroData:getMaxFishingTime()
    end
    return dailyFishingTime - self._fishingTime
end

function GameInPortManager:initOutSideValue()
    self._ownerPk = 0
end


local LOADED_STEPS = 4
local NEXT_STEP_INTERVAL = 0.05

-- 加载的动画资源列表
local GAME_IN_GUILD_SPINE_RES_LIST = {

}

local GAME_IN_GUILD_UI_RES_PLISTS = {

}

-- 初始化,目前没用
function GameInPortManager:initForInTownState()

end

-- 添加命令
function GameInPortManager:pushCommandForInPortState(command)
    -- print("###GameInPortManager:pushCommandForInPortState")
    -- 数据加载完成
    if (GameManager._isLoadingData) then
        self:loadDataForInTownState(command)
    end
    if command.type == CommandType.CONTROL_END_PET_PVP then
        self:endPetPVP(command.data)
    end
    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInPortManager:loadDataForInTownState(command)
    -- print("GameInPortManager:loadDataForInTownState")
    local commandType = command.type
    -- print("GameInPortManager:loadDataForInTownState  commandType=",commandType)
    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        self:setLoadingMapDataTime(0.8, 0.5)
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:setLoadingInitSceneTime(1, 0.5)
    else
        -- assert(false, string.format("[ERROR] command type %d is invalid when loading scene.", commandType))
    end
end

-- 
function GameInPortManager:createLayer()
    return TownLayer:create()
end

function GameInPortManager:createMachine()
    local GameDataManager = require("app.game.GameDataManager")
        local masterData = GameDataManager:getInstance():getMaster()
        if masterData then
            local fPet = masterData:getCaptainPetData()
            if fPet and fPet:isRide() then
                Net.NetPetSystem:readyToFollow(fPet:getId())
            end
        end
    return Town.Machine:create()
end

function GameInPortManager:createUIManager()
    return UI.UIManager:loadTownUI()
end
function GameInPortManager:createWeatherManager( )
    return nil;
end

-- 获取城镇中的游戏模型
function GameInPortManager:getTownModel()
    if (MachineManager:getInstance():getMachine()) then
        return MachineManager:getInstance():getMachine():getModel()
    end
    return nil
end

function GameInPortManager:loginEnterTown()
    self:enterPort()
    -- 进入加载场景
    SceneManager:getInstance():replaceLoadingScene()
end

-- 玩家进入城镇
function GameInPortManager:enterPort()
    self._fishingLayer = nil
    

    printfmt("GameInPortManager:enterPort")

    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)

    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)
    SceneManager:getInstance()._state = GameState.IN_PORT
    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true
    
    -- 处理加载资源
    self:setLoadingInitUIResTime(0.6, 1)

    self:addInitUIResourceList(GAME_IN_GUILD_UI_RES_PLISTS)
    self:addInitPNGResourceList(nil)
    self:addInitSpineResourceList(GAME_IN_GUILD_SPINE_RES_LIST)

    -- 请求航海日志信息
    Net.NetBigSailSystem:reqEventData()
    Net.NetBigSailSystem:reqGuildEventData()
    Net.NetBigSailSystem:reqAllIslandsBase()

    -- 拉力赛相关数据
    Net.NetBigSailSystem:reqBetBaseInfo(0)
    Net.NetBigSailSystem:reqBetLastResult()
    Net.NetBigSailSystem:reqMyLastbet()
end

-- 退出城镇
function GameInPortManager:exitPort()
    self._fishingLayer = nil

    if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():destroy()
        MachineManager:getInstance():setMachine(nil);
    end
    GameInPortManager:getInstance()._battleUI = nil
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
    local GameDataManager = require("app.game.GameDataManager")
end

--打开钓鱼界面
function GameInPortManager:openFishingView()
    self:closeFishingView()

    require "app.ui.manor.FishingLayer"
    local fishingLayer = UI.FishingLayer:create()
    fishingLayer:init()
    fishingLayer:center()
    UI.UIManager:getRootNode():addChild(fishingLayer,UI_ZORDER.FUNCTION_NPC)

    self._fishingLayer = fishingLayer
    -- print( "  钓鱼界面打开了!!!!!!  ")
end

--关闭钓鱼界面
function GameInPortManager:closeFishingView()
    Avalon.MessageCenter:notice(AvalonMessage.MC_CLOSE_FISHING_VIEW)

    self._fishingLayer = nil
    -- print( "  钓鱼界面关闭了!!!!!!  ")
end



--背包里面是否有场景行商需要的货物 return 拥有货物数量,  0表示没有
function GameInPortManager:getSaleGoodsNumber()
    local manorShopData = GameInPortManager:getInstance():getPeddlerShopData()
    if manorShopData == nil then
        return 0
    end

    local GameDataManager = require("app.game.GameDataManager")
    local saleID = manorShopData.saleID

    local haveNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(checkint(saleID), true)
    if haveNumber <= 0 then
        return 0
    end  

    return haveNumber
end

function GameInPortManager:changeNPCSpine(functionID, spineName)
    local machine = MachineManager:getInstance():getMachine()
    local triggerNpcArr = RoleDataManager:getTriggerNpcArr()
    local npcData = nil
    if(triggerNpcArr) then
        local npcArr = {}
        for k, triggerNpcData in pairs(triggerNpcArr) do 
            if(triggerNpcData and triggerNpcData:hasFunction(functionID)) then 
                npcData = triggerNpcData
            end
        end 
    end
    if (machine and npcData) then
        local spriteID = npcData:getSpriteID()
        local coord = npcData:getCoord()
        local model = machine:getModel()
        local view = machine:getView()
        local role = model:getRoleBySpriteID(spriteID)
        
        local npcModel = model:getModelByModelID(role:getId())
        local renderer = view:getRenderer(npcModel:getId())
        if renderer then
            -- local rendererCoord = renderer:getCoord()
            local renderViewNode = renderer:getView()
            view._map:unsetMapObject(Avalon.MathUtil:getInt(coord.x), Avalon.MathUtil:getInt(coord.y), renderViewNode)

            renderer:remove()
            view:addDelayRenderer(npcModel, renderer)
            
            npcModel:setAnimationData(spineName)

            local newRenderer = view:createRenderAndAddToMap(npcModel)

            if (newRenderer) then
                view._rendererMap[npcModel:getId()] = newRenderer
                local newRenderViewNode = newRenderer:getView()
                view._map:setMapObject(Avalon.MathUtil:getInt(coord.x), Avalon.MathUtil:getInt(coord.y), newRenderViewNode)
            else
                printError("[ERROR] ShareView addView: no renderer to created. modelCategory, modelType, modelId=", modelCategory, modelType, modelId)
            end
        end
        
    end
end

function GameInPortManager:updateRackNPCEquip(indexID)
    local tempId = self:indexIdTransShelfNPCID(indexID)

    local machine = MachineManager:getInstance():getMachine()
    local triggerNpcArr = RoleDataManager:getTriggerNpcArr()
    local npcData = nil
    if(triggerNpcArr) then
        local npcArr = {}
        for k, triggerNpcData in pairs(triggerNpcArr) do 
            if(triggerNpcData and triggerNpcData:getId() == tempId) then 
                npcData = triggerNpcData
            end
        end 
    end
    if (machine and npcData) then
        local spriteID = npcData:getSpriteID()

        local model = machine:getModel()
        local view = machine:getView()
        local role = model:getRoleBySpriteID(spriteID)
        
        local npcModel = model:getModelByModelID(role:getId())
        local renderer = view:getRenderer(npcModel:getId())
        if renderer and renderer.handleEquipmentChange then
            local wearEquipArr = GameInPortManager:getShelfWearEquipArr(tempId)
            if wearEquipArr then
                renderer:handleEquipmentChange(wearEquipArr)
            end
        end
        
    end
end

function GameInPortManager:setAnimationData(functionID, spineName)
    local machine = MachineManager:getInstance():getMachine()
    local triggerNpcArr = RoleDataManager:getTriggerNpcArr()
    local npcData = nil
    if(triggerNpcArr) then
        local npcArr = {}
        for k, triggerNpcData in pairs(triggerNpcArr) do 
            if(triggerNpcData and triggerNpcData:hasFunction(functionID)) then 
                npcData = triggerNpcData
            end
        end 
    end
    if (machine and npcData) then
        local spriteID = npcData:getSpriteID()

        local model = machine:getModel()
        local view = machine:getView()
        local role = model:getRoleBySpriteID(spriteID)
        
        local npcModel = model:getModelByModelID(role:getId())
        npcModel:setAnimationData(spineName)
    end
end

function GameInPortManager:isShelfNPC(templateID)
    local isShelf = false

    if templateID == 10425040 or templateID == 10425041 or templateID == 10425042 then
        isShelf = true
    end

    return isShelf
end

function GameInPortManager:indexIdTransShelfNPCID(indexId)
    local templateID = 10425040

    if indexId == 1 then
        templateID = 10425040
    elseif indexId == 2 then
        templateID = 10425041
    elseif indexId == 3 then
        templateID = 10425042
    end

    return templateID
end

function GameInPortManager:getShelfNPCIDTransToIndex(templateID)
    local shelfIndex = 1

    if templateID == 10425040 then
        shelfIndex = 1
    elseif templateID == 10425041 then
        shelfIndex = 2
    elseif templateID == 10425042 then
        shelfIndex = 3
    end

    return shelfIndex
end

function GameInPortManager:getShelfWearEquipArr(templateID)
    local shelfIndex = self:getShelfNPCIDTransToIndex(templateID)
    local wearEquipArr = {}
    
    local sData = mvc.manorDressUpShelfModel:getShelfDataByIndex(shelfIndex)

    if sData ~= nil then
        for k,v in pairs(sData) do
            for m,n in pairs(v) do
                local goodsData = GoodsDataManager:createLocalGoodsData(n)
                if goodsData then
                    goodsData:setWearPosition(goodsData:getEquipmentType())
                    table.insert(wearEquipArr,goodsData)
                end
            end
        end
    end

    return wearEquipArr
end




function GameInPortManager:getWholeManorFacade(decorationId)
    local pk = RoleDataManager:getMaster():getPK()
    local buildData = self._ownerPk == pk and self:getMannorBaseData() or self:getManorSceneCommonData().commonData
    local animeName = ""
    if buildData.facadeId ~= 0 then
        local shapeConfig = ConfigManager:getAllMannorShapeDataByID(buildData.facadeId)
        local skinNameList = self:packMannorFacaResourceList(shapeConfig)
        if skinNameList[decorationId] then
            animeName = skinNameList[decorationId]
        end
    end
    if animeName and animeName ~= "" then
        return animeName
    end

    return false
end

function GameInPortManager:packMannorFacaResourceList(shapeConfig)
    local packedList = {}
    local decorationIdList = string.split(shapeConfig.replaceDecorationId, ",")
    local resourceList = string.split(shapeConfig.replaceResource, ",")
    -- local coordConfig = string.split(shapeConfig.coord, ";")

    for k, v in ipairs(decorationIdList) do
        packedList[tonumber(v)] = resourceList[k]
        -- packedList[tonumber(v)] = {
        --     skin = resourceList[k]
        -- }
        
    end
    return packedList
end

function GameInPortManager:changeMannorDecoration(shapeConfig)
    local machine = MachineManager:getInstance():getMachine()
    if (machine) then
        local decorationIdList = string.split(shapeConfig.replaceDecorationId, ",")
        local skinNameList = self:packMannorFacaResourceList(shapeConfig)
        for _, decorationID in pairs(decorationIdList) do
            -- local config = skinNameList[tonumber(decorationID)]

            local view = machine:getView()
            
            view._map:removeMapTileDecorationsByID(tonumber(decorationID))
        end
        
        
    end
end

function GameInPortManager:createPetPVPUI()
    return UI.UIManager:loadPetPVPUI()
end

--[[实现保留model 和 view的切换]]
function GameInPortManager:beginPetPVP()
    if (MachineManager:getInstance():getMachine()) then
        self.view = MachineManager:getInstance():getMachine()._view
        self.model = MachineManager:getInstance():getMachine()._model
        MachineManager:getInstance():getMachine():destroy(true)
        self.view:setVisible(false)
        MachineManager:getInstance():setMachine(nil);
    end
end

--加载资源
function GameInPortManager:enterPetPVP()
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
function GameInPortManager:endPetPVP(commandData)
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
    
    if commandData then
        if commandData.enemySupply <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_226178)
        elseif commandData.mySupply <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_226177)
        end

        mvc.openPanel("BigSailIsland", "BigSailIslandShowMap")
    end
end

function GameInPortManager:showBlackDialog()
    if not mvc.bigSailPortModel then
        return
    end
    local GameDataManager = require("app.game.GameDataManager")
    local saveKey = UserDefaultKeyWord.BigSailActivityOpen..GameDataManager:getInstance():getMasterPK()
    local isFisrt = cc.UserDefault:getInstance():getIntegerForKey(saveKey, 0)
    local isOpenBigSailActivity = mvc.bigSailPortModel:getIslandMonsterIsOpen()
    if isFisrt == 0 then
        -- 第一次进入大航海
        if isOpenBigSailActivity then
            -- 开启了，第一次进入港口，存2，并且展示黑屏提示
            cc.UserDefault:getInstance():setIntegerForKey(saveKey, 2)
            Game.BlackDialogManager:getInstance():addEevntSyncIfFree(BlackDialogEventType.BIGSAIL_ACTIVITY_OPEN_FIRST, 0, 0, 0, functionType, function()
            end)
        else
            -- 没有播放过存 1
            cc.UserDefault:getInstance():setIntegerForKey(saveKey, 1)
        end
    else
        if isOpenBigSailActivity then
            -- 开启了活动后第一次进入港口，存2，并且展示黑屏提示
            if isFisrt ~= 2 then
                cc.UserDefault:getInstance():setIntegerForKey(saveKey, 2)
                Game.BlackDialogManager:getInstance():addEevntSyncIfFree(BlackDialogEventType.BIGSAIL_ACTIVITY_OPEN_FIRST, 0, 0, 0, functionType, function()
                end)
            end
        else
            -- 没有开启存 1
            cc.UserDefault:getInstance():setIntegerForKey(saveKey, 1)
        end
    end
end

function GameInPortManager:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_TRANSITION_FADEIN, self, self.showBlackDialog)
end

function GameInPortManager:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_TRANSITION_FADEIN, self, self.showBlackDialog)
end

return GameInPortManager;


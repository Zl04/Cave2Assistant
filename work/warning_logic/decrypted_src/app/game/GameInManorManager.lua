--[[
    庄园中的游戏管理
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

local GameInManorManager = class("GameInManorManager", GameLoadManager)
g_GameInManorManager = nil;

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
function GameInManorManager:startTownPressureTest()
    local mapData = GameMapManager:getInstance():getMapData()
    local mapWidth, mapHeight = mapData:getSize()

    print(string.format("GameInManorManager startTownPressureTest: map data size %f %f.", mapWidth, mapHeight))

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

        print(string.format("GameInManorManager startTownPressureTest: i %d  role coord %f %f.", i, coordX, coordY))

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

function GameInManorManager:getInstance()
    if g_GameInManorManager == nil then
        g_GameInManorManager = GameInManorManager.new()
    end
    return g_GameInManorManager;
end


function GameInManorManager:purgeInstance()
    if g_GameInManorManager ~= nil then
        g_GameInManorManager = nil;
    end
end

function GameInManorManager:ctor()
    GameInManorManager.super.ctor(self)
    
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
end

function GameInManorManager:setOwnerPk(ownerPk)
    self._ownerPk = ownerPk
end

function GameInManorManager:getOwnerPk()
    return self._ownerPk
end

function GameInManorManager:updateFishingTime(fishingTime)
    self._fishingTime = fishingTime
end

function GameInManorManager:updateBuildsData(buildsData)
    for k,v in pairs(buildsData) do
        self._buildsData[v.buildId] = v
    end
end

function GameInManorManager:updateMannorBaseData(baseData)
        self._baseData = baseData
end

function GameInManorManager:updateMannorBaseDataFacadeId(facadeId)
    self._baseData.facadeId = facadeId
end

function GameInManorManager:updateCurEnteredBuildsData(buildsData)
    for k,v in pairs(buildsData) do
        self._curEnteredBuildsData[v.buildId] = v
    end
end

function GameInManorManager:updateManorCommonData(manorCommonData)
    self._manorCommonData = manorCommonData
end

function GameInManorManager:updateManorSceneCommonData(ownerPk,manorCommonData)
    self._manorSceneCommonData[ownerPk] = manorCommonData
end



function GameInManorManager:getBuildDataByBuildId(buildId)
    return self._buildsData[buildId]
end

--检测指定类型建筑是否满足给定等级
function GameInManorManager:checkBuildLevelIsConditions(buildId, level)
    local isConditions = false

    if self._buildsData[buildId] and self._buildsData[buildId].level >= level then
        isConditions = true
    end

    return isConditions
end

function GameInManorManager:getMannorBaseData()
    return self._baseData
end

function GameInManorManager:getCurEnteredBuildDataByBuildId(buildId)
    return self._curEnteredBuildsData[buildId]
end


function GameInManorManager:updatePurchaseItems(data)

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

function GameInManorManager:updateRaderMaterialId(materialId)    
    self._raderMaterialId = materialId or 0
end

function GameInManorManager:getRaderMaterialId()    
    return self._raderMaterialId
end

function GameInManorManager:updatePedleryMaterialData(data)    
    self._unlockMaterials = data.unlockMaterials or {}
    if data.chooseId and data.chooseId > 0 then
        self._raderMaterialId = data.chooseId
    end
end

function GameInManorManager:getMateriaRouteList()
    return self._unlockMaterials
end

function GameInManorManager:havaMateriaRoute(materialId)
    local have = false
    for k,v in pairs(self._unlockMaterials) do
        if tonumber(v) == tonumber(materialId) then
            have = true
            break
        end
    end

    return have
end

function GameInManorManager:isSelectRaderMaterialId(materialId)
    local isSelect = false
    if tonumber(self._raderMaterialId) == tonumber(materialId) then
        isSelect = true
    end
    return isSelect
end


function GameInManorManager:getFriendPurchaseItemByPk(friendPk)
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

function GameInManorManager:getRemainingFishingTime()
    local dailyFishingTime = tonumber(ConfigManager:getDailyFishingTime())
    local heroData = RoleDataManager:getMaster()
    if heroData then
        dailyFishingTime = dailyFishingTime + heroData:getMaxFishingTime()
    end
    return dailyFishingTime - self._fishingTime
end

function GameInManorManager:initOutSideValue()
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
function GameInManorManager:initForInTownState()

end

-- 添加命令
function GameInManorManager:pushCommandForInManorState(command)
    -- print("###GameInManorManager:pushCommandForInManorState")
    -- 数据加载完成
    if (GameManager._isLoadingData) then
        self:loadDataForInTownState(command)
    end

    self:_pushCommand(command)
end

-- 加载游戏数据
function GameInManorManager:loadDataForInTownState(command)
    -- print("GameInManorManager:loadDataForInTownState")
    local commandType = command.type
    -- print("GameInManorManager:loadDataForInTownState  commandType=",commandType)
    if (commandType == CommandType.CONTROL_LOADSCENCE) then
        self:setLoadingMapDataTime(0.8, 0.5)
    elseif (commandType == CommandType.CONTROL_ENTER_SCENE) then
        self:setLoadingInitSceneTime(1, 0.5)
    else
        -- assert(false, string.format("[ERROR] command type %d is invalid when loading scene.", commandType))
    end
end

-- 
function GameInManorManager:createLayer()
    return TownLayer:create()
end

function GameInManorManager:createMachine()
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

function GameInManorManager:createUIManager()
    return UI.UIManager:loadTownUI()
end
function GameInManorManager:createWeatherManager( )
    return nil;
end

-- 获取城镇中的游戏模型
function GameInManorManager:getTownModel()
    if (MachineManager:getInstance():getMachine()) then
        return MachineManager:getInstance():getMachine():getModel()
    end
    return nil
end

function GameInManorManager:loginEnterTown()
    self:enterManor()
    -- 进入加载场景
    SceneManager:getInstance():replaceLoadingScene()
end

-- 玩家进入城镇
function GameInManorManager:enterManor()
    self._fishingLayer = nil
    

    printfmt("GameInManorManager:enterManor")

    local setpause = collectgarbage("setpause", 200)
    local setstepmul = collectgarbage("setstepmul", 100)

    GoodsDataManager:setPacketSubType(PACKET_SUB_TYPE.PACKET_SUB_TYPE_1)
    SceneManager:getInstance()._state = GameState.IN_MANOR
    GameManager._isLoadingData = true
    GameManager._isLoadingRes = true
    
    -- 处理加载资源
    self:setLoadingInitUIResTime(0.6, 1)

    self:addInitUIResourceList(GAME_IN_GUILD_UI_RES_PLISTS)
    self:addInitPNGResourceList(nil)
    self:addInitSpineResourceList(GAME_IN_GUILD_SPINE_RES_LIST)
end

-- 退出城镇
function GameInManorManager:exitManor()
    self._fishingLayer = nil

    if (MachineManager:getInstance():getMachine()) then
        MachineManager:getInstance():getMachine():destroy()
        MachineManager:getInstance():setMachine(nil);
    end
    GameInManorManager:getInstance()._battleUI = nil
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
function GameInManorManager:openFishingView()
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
function GameInManorManager:closeFishingView()
    Avalon.MessageCenter:notice(AvalonMessage.MC_CLOSE_FISHING_VIEW)

    self._fishingLayer = nil
    -- print( "  钓鱼界面关闭了!!!!!!  ")
end


--初始化当次钓鱼相关数据 (根据鱼竿和甩杆区间来确定)
function GameInManorManager:getFishingData()
    local  profileFishPool = require("profiles/commonProfile/ProfileFishPool")
    local poolId = self:getEquipmentFishWeaponRemarksField()
    local poolData = nil

    if poolId ~= "" then
        poolData = clone(profileFishPool[tonumber(poolId)])
    else
        poolData = clone(profileFishPool[1001])
    end
    

    poolData.colorList = {}

    local speedArr = string.split(poolData.Speed,";")
    local stringArr = string.split(poolData.ColorLine,";")
    for k,v in ipairs(stringArr) do
        local oneArr = string.split(v, ",")
        local twoArr = string.split(speedArr[k], ",")
        local tb = {}
        local beginNum = oneArr[1]
        local endNum = oneArr[2]
        local color = oneArr[3]
        tb.beginNum = tonumber(beginNum)
        tb.endNum = tonumber(endNum)
        tb.color = tonumber(color)
        tb.leftTimeInterval = tonumber(twoArr[1])
        tb.rightTimeInterval = tonumber(twoArr[2])
        tb.leftDistance = tonumber(twoArr[3])
        tb.rightDistance = tonumber(twoArr[4])
        table.insert(poolData.colorList,tb)
    end

    local pixelArr = string.split(poolData.fishingPixel,";")
    poolData.finalPixel = math.random(pixelArr[1], pixelArr[2])

    local pointArr = string.split(poolData.point,";")
    poolData.preAddEnergy = tonumber(pointArr[1])
    poolData.totalEnergy = tonumber(pointArr[2])

    -- print(  "poolData.preAddEnergy ==== ",poolData.preAddEnergy ,poolData.totalEnergy)

    return poolData
end

--是否装备鱼竿
function GameInManorManager:isEquipFishingWeapon(equipmentType)
    local GameDataManager = require("app.game.GameDataManager")
    local equipmentData = GameDataManager:getInstance():getPacketBoxData()
    local equipmentList  = equipmentData.wearEquipmentArr
    if equipmentList then
        for k, v in pairs(equipmentList) do
            if v:getEquipmentType() == equipmentType then
                return true
            end
        end
    end
    
    return false
end

--获取鱼竿对应的掉落池
function GameInManorManager:getEquipmentFishWeaponRemarksField()
    local GameDataManager = require("app.game.GameDataManager")
    local equipmentData = GameDataManager:getInstance():getPacketBoxData()
    local equipmentList  = equipmentData.wearEquipmentArr
    local fishWeaponData = nil
    local remarksField = ""
    if equipmentList then
        for k, v in pairs(equipmentList) do
            if v:getEquipmentType() == PublicDefine.EQUIPMENT_TYPE.Fish then
                fishWeaponData = v
                break
            end
        end
    end

    if fishWeaponData then
        remarksField = fishWeaponData._localConfig.remarksField[1]
    end
    
    return remarksField
end

--通知render更换鱼竿表现
function GameInManorManager:updateChangeFishingWeapon(heroSpriteId,isShowFishingWeapon)
    -- local masterData = RoleDataManager:getMaster()
    -- local heroSpriteId = masterData:getSpriteID()

    local MachineManager = require("app.game.MachineManager")
    local model = MachineManager:getInstance():getMachine():getModel()
    local heroRole = model:getRoleBySpriteID(heroSpriteId)

    if heroRole then
        local heroModelId = heroRole:getId()

        local data = {
            isShowFishingWeapon = isShowFishingWeapon
        }

        local ridingCMD = Command.RendererCommand:create(true)
        ridingCMD:initForTypeAndData(CommandType.RENDERER_HERO_CHANGE_FISHING_WEAPON, heroModelId, data)
        SceneManager:getInstance():pushCommand(ridingCMD)
    end
end

function GameInManorManager:getManorSceneCommonData()
    return self._manorSceneCommonData[self._ownerPk]
end

function GameInManorManager:showHarvestEffect(heroSpriteId, fishResult)
    if fishResult < 2 then
        return
    end

    local MachineManager = require("app.game.MachineManager")
    local model = MachineManager:getInstance():getMachine():getModel()
    local heroRole = model:getRoleBySpriteID(heroSpriteId)

    if heroRole then
        local heroModelId = heroRole:getId()

        local data = {
            fishResult = fishResult
        }

        local ridingCMD = Command.RendererCommand:create(true)
        ridingCMD:initForTypeAndData(CommandType.RENDERER_HERO_SHOW_HARVEST_EFFECT, heroModelId, data)
        SceneManager:getInstance():pushCommand(ridingCMD)
    end

end

function GameInManorManager:getPeddlerShopData()
    local manorShopData = GameInManorManager:getInstance():getFriendPurchaseItemByPk(self._ownerPk)
    return manorShopData
end

--背包里面是否有场景行商需要的货物 return 拥有货物数量,  0表示没有
function GameInManorManager:getSaleGoodsNumber()
    local manorShopData = GameInManorManager:getInstance():getPeddlerShopData()
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

function GameInManorManager:changeNPCSpine(functionID, spineName)
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

function GameInManorManager:updateRackNPCEquip(indexID)
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
            local wearEquipArr = GameInManorManager:getShelfWearEquipArr(tempId)
            if wearEquipArr then
                renderer:handleEquipmentChange(wearEquipArr)
            end
        end
        
    end
end

function GameInManorManager:setAnimationData(functionID, spineName)
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

function GameInManorManager:getManorBuildFacade(model)
    local buildId = model:getData().buildId
    local pk = RoleDataManager:getMaster():getPK()
    local buildData = self._ownerPk == pk and self:getBuildDataByBuildId(buildId) or self:getCurEnteredBuildDataByBuildId(buildId)
    local animeName = nil
    -- if buildId == PublicDefine.ManorBuildID.BuildID_Dock then
    --     local boatData = mvc.dockModel:getBoatData()
    --     if boatData.boatId ~= 0 then
    --         local shapeConfig = ConfigManager:getAllBoatDataByID(boatData.boatId)
    --         animeName = shapeConfig.replaceResource
    --     end
    -- else
    --     if buildData.facadeId ~= 0 then
    --         local shapeConfig = ConfigManager:getAllOtherShapeDataByID(buildData.facadeId)
    --         animeName = shapeConfig.replaceResource
    --     end
    -- end
    if buildData.facadeId and buildData.facadeId ~= 0 then
        local shapeConfig = ConfigManager:getAllOtherShapeDataByID(buildData.facadeId)
        animeName = shapeConfig.replaceResource
    end
    if animeName and animeName ~= "" then
        -- facadeSkeleton, facadeAtlas = animeName..".json", animeName..".atlas"
        return animeName
    end
    return false
end

function GameInManorManager:getBuildID2FunctionMap()
    return BUILD2FUNCTION
end

function GameInManorManager:getEventTypeMap()
    return SailEventType
end

function GameInManorManager:getBuildUpDataByLevel(buildID,level)
    local allBuildUpConfig = ConfigManager:getAllBuildUpData()

    local index = buildID*1000+level
    local buildUpConfig = ConfigManager:getAllBuildUpDataByID(index)
    return buildUpConfig
end

function GameInManorManager:getPackedBuildMaterialData(buildData)
    local buildMaterialData = {}
    if buildData.materials then
        for _, v in pairs(buildData.materials) do
            buildMaterialData[v.id] = v.count
        end
    end
    return buildMaterialData
end

function GameInManorManager:isShelfNPC(templateID)
    local isShelf = false

    if templateID == 10425040 or templateID == 10425041 or templateID == 10425042 then
        isShelf = true
    end

    return isShelf
end

function GameInManorManager:indexIdTransShelfNPCID(indexId)
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

function GameInManorManager:getShelfNPCIDTransToIndex(templateID)
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

function GameInManorManager:getShelfWearEquipArr(templateID)
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




function GameInManorManager:getWholeManorFacade(decorationId)
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

function GameInManorManager:packMannorFacaResourceList(shapeConfig)
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

function GameInManorManager:changeMannorDecoration(shapeConfig)
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

return GameInManorManager;


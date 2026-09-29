-- ShareModel.lua
-- Author:zp
-- 2017年4月13日
-- Using:通用数据模型方法

local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameMapManager = require("app.game.GameMapManager")
require "utils.AvalonUtil"
require "bit"

local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE

Machine = Machine or {}

local ShareModel = class("ShareModel", Machine.Model)
Machine.ShareModel = ShareModel

local DEBUG = false

-- private:
-- 创建角色
local function createRole(self, roleType, data)
    local role = nil
    -- 英雄
    if (roleType == RoleType.Hero) then
        role = Model.Hero:create()
        role:init(data)

        -- 普通攻击技能
        local normalAttackSkillData = SkillDataManager:getNormalSkillForPK(data:getPK())
        if (normalAttackSkillData) then
            local normalAttackSkill = Model.Skill:create(true)
            normalAttackSkill:init(normalAttackSkillData)
            role:setNormalAttackSkill(normalAttackSkill)
        else
            if(role:isMaster()) then 
                printError("ShareModel:createRole no found normalAttackSkillData.")
            end
        end
    -- 怪物
    elseif (roleType == RoleType.Monster) then
        role = Model.Monster:create()
        role:init(data)
    elseif (roleType == RoleType.Pet) then
        role = Model.Pet:create()
        role:init(data)
    else
        printError(string.format("[ERROR] ShareModel createRole: role type %d is invalid.", roleType))
    end

    local coordX, coordY = data.coordX, data.coordY
    if coordX and coordY then
        local coordZ = self:getMapTileCoordZ(coordX, coordY)
        role:setCoord(coordX, coordY, coordZ)
    end
    if (data.isMaster and roleType == RoleType.Hero) then
        self._master = role
    end
    return role
end

-- 创建NPC 
local function createNpc(self,npcType,data)
    local npc = nil
    if DEBUG then
        print("createNpc()  npcType,data=",npcType,data)
    end
    if npcType == PublicDefine.TRIGGER_NPC_TYPE.BOX then
        npc = Model.Treasure:create()
        npc:init(data)

        if DEBUG then
            for k,v in pairs(npc) do
                print("createNpc()  k,v=",k,v)
            end 
        end

    -- 处理钱袋
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.GOLD_BAG then
        npc = Model.GoldBag:create()
        npc:init(data)

    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.RUNE then
        npc = Model.Rune:create()
        npc:init(data)

    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRAP then
        npc = Model.Trap:create()
        npc:init(data)
        
    -- 处理传送门 
    elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR then
        npc = Model.TransDoor:create()
        npc:init(data)
    -- elseif npcType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT then
    --     npc = Model.TransDoor:create()
    --     npc:init(data)
    -- TODO 处理其余npc 
    else
        printError("create NpcModel not handle npcType=", npcType)
    end

    if data.coordX and data.coordY then
        npc:setCoord(data.coordX, data.coordY)
    end

    return npc
end

local function createTriggerNpc(self,data)
    local npc = nil
    if DEBUG then
        print("createTriggerNpc()  type=",data:getType())
    end
    
    npc = Model.TriggerNpc:create(true)
    npc:init(data)

    if DEBUG then
        for k,v in pairs(npc) do
            print("createTriggerNpc()  k,v=",k,v)
        end 
    end

    if data.coordX and data.coordY then
        npc:setCoord(data.coordX, data.coordY)
    end

    return npc
end

-- 清理所有模型
local function clearAllModel(self)
    self._master = nil

    local roleMap = self._roleMap
    for spriteID, role in pairs(roleMap) do
        roleMap[spriteID] = nil
    end

    local battleFieldMap = self._battleFieldMap
    for id, battleField in pairs(battleFieldMap) do
        battleFieldMap[id] = nil
    end

    local modeMap = self._modelMap
    for id, model in pairs(modeMap) do
        model:destroy()
        modeMap[id] = nil
    end

    local modeMap = self._patrolNpcMap
    for id, model in pairs(modeMap) do
        modeMap[id] = nil
    end
end

-- 清理地图模型
local function clearMap(self)
    self._mapConfig = nil
    self._mapData = nil
end

-- public:
-- 构造函数
function ShareModel:ctor()
    -- 地图
    self._mapConfig = nil
    self._mapData = nil

    -- 玩家
    self._master = nil
    -- 英雄
    self._heroMap = nil
    -- 宠物
    self._petMap = nil
    -- 所有角色
    self._roleMap = nil
    -- 所有战斗场景
    self._battleFieldMap = nil
    -- 所有游戏模型
    self._modelMap = nil
    -- 场景的巡逻NPC
    self._patrolNpcMap = nil

    -- 记录所有传送门对象
    self._transDoorMap = nil
    self._collectNpcMap = nil
    
    self:registerListener();
end

-- 销毁
function ShareModel:destroy()
    clearAllModel(self)
    clearMap(self)

    self._heroMap = nil
    self._petMap = nil
    self._roleMap = nil
    self._battleFieldMap = nil
    self._modelMap = nil
    self._patrolNpcMap = nil
    self._collectNpcMap = nil

    self:unRegisterListener();
end

-- 初始化
function ShareModel:init()
    self._heroMap = {}
    self._petMap = {}
    self._roleMap = {}
    self._battleFieldMap = {}
    self._modelMap = {}
    self._transDoorMap = {}
    self._patrolNpcMap = {}
    self._collectNpcMap = {}
end

-- 清理
function ShareModel:clear()
    clearAllModel(self)
    clearMap(self)
end

-- 添加游戏模型
function ShareModel:addModel(model)
    -- print(string.format("ShareModel addModel: add model, category:%d, type:%d, id:%d.", model:getCategory(), model:getType(), model:getId()))

    local id = model:getId()
    if (not self._modelMap[id]) then
        self._modelMap[id] = model
    else
        printError(string.format("[ERROR] ShareModel addModel: model %d is already in map.", id))
    end
end

-- 删除游戏模型
function ShareModel:removeModel(model)
    if(DEBUG) then
        print(string.format("ShareModel removeModel: remove model, category:%d, type:%d, id:%d.", model:getCategory(), model:getType(), model:getId()))
    end

    local id = model:getId()
    if (self._modelMap[id] == model) then
        local category = model:getCategory()
        if(category == Category.ROLE or category == Category.TRIGGER_NPC or category == Category.FUNCTION_NPC) then
            self._heroMap[model:getSpriteID()] = nil
            self._petMap[model:getSpriteID()] = nil
            self._roleMap[model:getSpriteID()] = nil
            self._transDoorMap[model:getSpriteID()] = nil
            self._patrolNpcMap[model:getSpriteID()] = nil
            self._collectNpcMap[model:getSpriteID()] = nil
        end

        model:destroy()
        self._modelMap[id] = nil
    else
        printError(string.format("[ERROR] ShareModel removeModel: model %d not found.", id))
    end
end

-- 创建地图
function ShareModel:createMap(data)
    print("########ShareModel:createMap")
    self._mapData = GameMapManager:getInstance():loadMapDataForState(data)
end

function ShareModel:getAllHero()
    return self._heroMap
end

function ShareModel:getAllPet()
    return self._petMap
end

function ShareModel:getAllHeroNum()
    local num = 0
    for k, v in pairs(self._heroMap) do 
        num = num + 1
    end

    return num
end

function ShareModel:getAllHeroExtMasterNum()
    local num = 0
    for k, v in pairs(self._heroMap) do 
        if(v and not v:isMaster()) then
            num = num + 1
        end
    end

    return num
end

-- 获取所有任务模型
function ShareModel:getTaskArr()
    local taskArr = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            local gameData = role:getNpcData()
            if(gameData and (gameData:hasFunction(FUNCTION_TYPE.TASK) or gameData:hasFunction(FUNCTION_TYPE.GUILD_TASK))) then
                
                table.insert(taskArr, role)
            end
        end
    end

    return taskArr
end

-- 获取巡逻NPC列表
function ShareModel:getPatrolNpcArr()
    return self._patrolNpcMap
end

-- 获取 邮箱模型
function ShareModel:getMailModels()
    local models = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            local gameData = role:getNpcData()
            if(gameData and gameData:hasFunction(FUNCTION_TYPE.MAILBOX)) then
                table.insert(models, role)
            end
        end
    end
    return models
end

-- 获取 梦境npc模型
function ShareModel:getDreamNpcModels()
    local models = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            local gameData = role:getNpcData()
            if(gameData and gameData:hasFunction(FUNCTION_TYPE.FUNCTION_TYPE_DREAM)) then
                table.insert(models, role)
            end
        end
    end
    return models
end

function ShareModel:getTrapPointArr()
    local models = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT) then
            table.insert(models, role)
        end
    end
    return models
end

-- 获取 陷阱列表
function ShareModel:getTrapArr()
    local models = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
            table.insert(models, role)
        end
    end
    return models
end

-- 获取演员类NPC列表
function ShareModel:getActorArr()
    local models = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.NPC_TYPE_ACTOR) then
            table.insert(models, role)
        end
    end
    return models
end

-- 获取传送门列表
function ShareModel:getTransDoorArr()
    local models = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
            table.insert(models, role)
        end
    end
    return models
end

-- 获取所有功能NPC列表
function ShareModel:getAllFunctionNpcArr()
    local models = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC) then
            table.insert(models, role)
        end
    end
    return models
end

-- 获取符合条件的NPC列表
function ShareModel:getNpcsForFuntionType(functionType)
    local npcArr = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            local gameData = role:getNpcData()
            if(gameData and gameData:hasFunction(functionType)) then
                table.insert(npcArr, role)
            end
        end
    end

    return npcArr
end

-- 获取指定坐标的NPC SpriteId  这里的NPC类型必须是 FISH 钓鱼类NPC
function ShareModel:getFishNpcSpriteIdForCoord(x,y)
    local spriteId = 0
    for _,role in pairs(self._roleMap) do
        local coord = role:getCoord()
        if (coord.x == x and coord.y == y and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.FISH) then
            spriteId = role:getSpriteID()
            break
        end
    end

    return spriteId
end

function ShareModel:getFishDirection(x,y)
    local direction = 1
    local templateID = 0
    for _,role in pairs(self._roleMap) do
        local coord = role:getCoord()
        if (coord.x == x and coord.y == y and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.FISH) then
            templateID = role._fsm._dataModel.templateID
            break
        end
    end

    if (templateID ~= 0) then
        local collectData = ConfigManager:getTriggerNpcConfigByID(templateID)
        direction = collectData.extendValue2
    end

    return direction
    -- 
end



-- 获取场景中所有指定模板ID的NPC
function ShareModel:getNpcsForTemplateID(templateID)
    local npcArr = {}
    for _,role in pairs(self._roleMap) do
        local data = role:getData()
        -- 没有ID则匹配所有怪物， 有ID则匹配ID（包括NPC）
        if(data and 
           (((templateID == nil) and
             (data:getCategory() == Category.ROLE) and 
             (data:getType() == RoleType.Monster)) or 
            (data:getId() == templateID))) 
        then
            table.insert(npcArr, role)
        end
    end

    return npcArr
end

-- 获取场景中所有指定模板ID的精英怪
function ShareModel:getElitesForTemplateID(templateID)
    local npcArr = {}
    for _,role in pairs(self._roleMap) do
        local data = role:getData()
        if ((data) and
            (templateID == nil or (data:getId() == templateID)) and
            (data:getCategory() == Category.ROLE) and 
            (data:getType() == RoleType.Monster) and
            (data:isEliteMonster()))
        then
            table.insert(npcArr, role)
        end
    end

    return npcArr
end

-- 获取场景中所有怪物
function ShareModel:getAllMonsterModel()
    local npcArr = {}
    for _,role in pairs(self._roleMap) do
        local data = role:getData()
        if (data and data:getCategory() == Category.ROLE 
            and data:getType() == RoleType.Monster)
        then
            table.insert(npcArr, role)
        end
    end

    return npcArr
end

-- 获取场景中所有角色，包括hero,monster,triggerNPC
function ShareModel:getAllRoleModel()
    local npcArr = {}
    for _,role in pairs(self._roleMap) do
        table.insert(npcArr, role)
    end

    return npcArr
end

-- 获取场景中所有指定模板ID的小BOSS
function ShareModel:getSmallBossesForTemplateID(templateID)
    local npcArr = {}
    for _,role in pairs(self._roleMap) do
        local data = role:getData()
        if ((data) and
            (templateID == nil or (data:getId() == templateID)) and
            (data:getCategory() == Category.ROLE) and 
            (data:getType() == RoleType.Monster) and
            (data:isSmallBoss()))
        then
            table.insert(npcArr, role)
        end
    end

    return npcArr
end

-- 获取boss 对象
function ShareModel:getBoss()
    printError("[ERROR ] ShareModel:getBoss method should be overrided.")
end

-- 获取地图配置数据
function ShareModel:getMapConfig()
    return self._mapConfig
end

-- 设置地图数据
function ShareModel:setMapData(mapData)
    print("ShareModel:setMapData")
    self._mapData = mapData
end

-- 获取地图数据
function ShareModel:getMapData()
    return self._mapData
end

local function createBitMask(startBit, endBit)
    local mask = 0
    for i = startBit + 1 , endBit + 1 do 
        mask = bit.bor(mask, bit.lshift(1, i - 1))
    end
    return mask;
end

-- 获取地块的z坐标
function ShareModel:getMapTileCoordZ(coordX, coordY)
    local x, y, z = math.floor(coordX + 0.5), math.floor(coordY + 0.5), 0
    local mapTile = self._mapData.tileDataMap[y + 1][x + 1]
    if (mapTile) then
        if (mapTile.z) then 
            z = mapTile.z
        else
            printError(string.format("[ERROR] ShareModel getMapTileCoordZ: coord z is invalid at (%f,%f).", x, y))
        end
    end
    return z
end

-- 获取地块数据
function ShareModel:getMapTileData(coordX, coordY)

    return self._mapData:getTileDataAtCoord(coordX, coordY)
end

-- 获取角色周围可以挖的墙的坐标
function ShareModel:getDiggableWallCoordList(coordX, coordY, radius, targetType)
    if(targetType == PublicDefine.ESkillTargetType.ESkillTargetType_Ground) then 
        return self._mapData:getCoordinatesReachableInVisionRadius(coordX, coordY, radius)
    elseif(targetType == PublicDefine.ESkillTargetType.ESkillTargetType_Wall) then
        return self._mapData:getCoordinatesForDestructibleInVisionRadius(coordX, coordY, radius)
    end
end

-- 寻路
function ShareModel:findMapPath(startCoordX, startCoordY, endCoordX, endCoordY)
    return MapDataManager:getInstance():findPath(self._mapData, startCoordX, startCoordY, endCoordX, endCoordY, true)
end

-- 获取玩家对象
function ShareModel:getMaster()
    return self._master
end

-- 获取所有角色
function ShareModel:getRoleMap()
    return self._roleMap
end

-- 获取某个角色
function ShareModel:getRoleBySpriteID(spriteID)
    if(spriteID == nil) then 
        return nil
    end
    return self._roleMap[spriteID]
end

-- 获取某个模型对象
function ShareModel:getModelByModelID(modelID) 
    if(modelID == nil) then
        return nil
    end
    return self._modelMap[modelID]
end

-- 获取某个模型对象
function ShareModel:getModelByModelType(category, type) 
    local list = {}
    if(type == nil or category == nil) then
        return list
    end
    for k, role in pairs(self._modelMap) do
        if (role:getCategory() == category) and role:getType() == type then
            table.insert(list, role)
        end
    end
    return list
end

-- 添加角色
-- category : 大类
-- roleType : 角色类型
-- data : 角色数据
-- 返回值：角色模型，是否更新
function ShareModel:addOrUpdateRole(category, roleType, data)
    if (data) then
        local spriteID = data.spriteID

        local role = self:getRoleBySpriteID(spriteID)
        local isUpdate = false
        local roleData = nil

        if category == Category.ROLE then
            -- 如果角色存在，更新角色数据
            if roleType == RoleType.Pet then
                if (role == nil) then
                    role = createRole(self, roleType, data)
                    self._roleMap[spriteID] = role
                    self._petMap[spriteID] = role
                    roleData = role:getRoleData()
                end
            else
                if (role) then
                    roleData = role:getRoleData()
                    roleData:changeInit(data)
                    isUpdate = true
                else
                    role = createRole(self, roleType, data)
                    if (role) then
                        if (roleType == RoleType.Hero and not role:isMaster()) then
                            if(GameManager:getPersonNum() <= self:getAllHeroExtMasterNum())then

                                return 
                            end
                        end

                        roleData = role:getRoleData()
                        self._roleMap[spriteID] = role
                        if(roleData:getType() == RoleType.Hero) then
                            self._heroMap[spriteID] = role
                        end
                    end
                end
            end
        elseif category == Category.TRIGGER_NPC then
            if (role) then
                roleData = role:getNpcData()
                roleData:changeInit(data)
                isUpdate = true
            else
                role = createTriggerNpc(self, data)
                if (role) then
                    roleData = role:getNpcData()
                    self._roleMap[spriteID] = role

                    if(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.PATROL_NPC) then 
                        self._patrolNpcMap[spriteID] = role
                    end
                    
                    if(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
                        self._transDoorMap[spriteID] = role
                    elseif(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.COLLECT) then
                        self._collectNpcMap[spriteID] = role
                    end
                end
            end
        else
            printError("ShareModel:addOrUpdateRole category no handle. category, roleType=", category, roleType)
        end

        if (role and roleData) then
            if (not isUpdate) then
                local coord = role:getCoord()
                MapDataManager:getInstance():addRole(self._mapData, coord.x, coord.y, roleData)

                self:addModel(role)
            end
        else
            -- printError("[ERROR] ShareModel addRole: no role found  spriteID=", data.spriteID)
        end

        return role, isUpdate
    else
        printError("[ERROR] ShareModel addRole: no data to create role, type=", roleType)
    end
    return nil
end

-- 删除角色
function ShareModel:removeRole(role)
    if(role == nil) then 
        printError("ShareModel:removeRole param role is nil.")
        return 
    end
    local modelID = role:getId()
    local spriteID = role:getSpriteID()

    if DEBUG then
        print(string.format("ShareModel removeRole: remove one role model, modelID %d, spriteID %d.", modelID, spriteID))
    end
    if (self._modelMap[modelID] == role) then
        self:removeRoleFromMap(role)
        if(role:getCategory() == Category.ROLE) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_GAME_MODEL, role:getData())
        end

        self._roleMap[spriteID] = nil
        self._patrolNpcMap[spriteID] = nil
        self:removeModel(role)
    else 
        local coord = role:getCoord()
        if(coord) then 
            print("ShareModel:removeRole coord.x, coord.y=", coord.x, coord.y)
        end
        print("ShareModel:removeRole category,type,id,spriteID=", role:getCategory(), role:getType(), role:getId(), role:getSpriteID())
        printError("ShareModel:removeRole  no found role.")
    end
end

-- 从地图上面移除一个角色
function ShareModel:removeRoleFromMap(role)
    if role then
        local coord = role:getCoord()
        MapDataManager:getInstance():removeRole(self._mapData,Avalon.MathUtil:getInt(coord.x),Avalon.MathUtil:getInt(coord.y),role:getData())

        if DEBUG then
            print(string.format("ShareModel removeRoleFromMap: x:%d, y:%d  mapData:%s.",coord.x,coord.y,self._mapData))
        end
    end
end

-- 删除模型
function ShareModel:removeModelByModelID(modelID)
    local model = self._modelMap[modelID]
    if (model) then
        self:removeRole(model)
    else
        printError(string.format("[ERROR] ShareModel removeModelByModelID: could not find the model (%d) in modelMap.", modelID))
    end
end

--播放boss1技能效果
function ShareModel:playBoss1SKill()
    if self.bPlayBoss1SKill == nil then
        local PlotManager = require("app.game.PlotManager")
        PlotManager:getInstance():runPlotByID(1010022)
        self.bPlayBoss1SKill = true
    end
end

-- 新手引导移除NPC
function ShareModel:storyRemoveNpc(templateID)
    GameManager:triggerNppForTemplateID(templateID)
end

-- 注册监听事件(可选)
function ShareModel:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_PLOTEVENT_BOSSS1SKILL, self, self.playBoss1SKill)
    Avalon.MessageCenter:bind(AvalonMessage.MC_STORY_REMOVE_NPC, self, self.storyRemoveNpc)
    
end

-- 注销监听事件(可选)
function ShareModel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PLOTEVENT_BOSSS1SKILL, self, self.playBoss1SKill)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_STORY_REMOVE_NPC, self, self.storyRemoveNpc)
end


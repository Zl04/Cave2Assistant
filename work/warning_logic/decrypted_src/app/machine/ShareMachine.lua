-- ShareMachine.lua
-- Author:zp
-- 2017年4月13日
-- Using:通用引擎 


require "app.machine.Machine"
require "app.machine.Model"
require "app.machine.View"
-- 配置数据
require "app.config.ConfigManager"
-- 引擎执行的命令
require "app.command.RendererCommand"
require "app.command.ControlCommand"
require "app.command.BattleCommand"
require "app.command.GenerationCommand"
-- 几何模型
require "app.object.geometric.GeometricModel"
-- 模型的action
require "app.action.fsm.IDLEStateAction"
require "app.action.fsm.WaitingStateAction"
require "app.action.fsm.ReviveStateAction"
require "app.action.fsm.battle.BattleStateActionForHero"
require "app.action.fsm.battle.BattleStateActionForOtherHero"
require "app.action.fsm.battle.BattleStateActionForMonster"
require "app.action.fsm.move.BattleMoveStateActionForMe"
require "app.action.fsm.move.MoveStateActionForNpc"
require "app.action.buffer.BufferAction"
require "app.action.effect.EffectAction"
require "app.action.aircraft.BulletAction"
require "app.action.aircraft.GetGoodsAction"
require "app.action.skill.NormalAttackAction"
require "app.action.skill.SkillAction"
require "app.action.function.RoleZorderAction"
-- 游戏模型
require "app.object.role.Hero"
require "app.object.role.Monster"
require "app.object.skill.Skill"
require "app.object.effect.Effect"
require "app.object.buffer.Buffer"
require "app.object.group.BattleField"
require "app.object.aircraft.Bullet"
require "app.object.aircraft.GetGoods"
require "app.object.goods.Prop"
require "app.object.goods.Material"
require "app.object.goods.Equipment"
require "app.object.role.Pet"
-- 渲染器
require "app.renderer.HeroRenderer"
require "app.renderer.MonsterRenderer"
require "app.renderer.BulletRenderer"
require "app.renderer.GoodsRenderer"
require "app.renderer.FunctionNPCRenderer"
require "app.renderer.PatrolNPCRenderer"
require "app.renderer.TriggerNPC.ActorNpcRenderer"
require "app.renderer.component.AttributeComponent"
require "app.renderer.PetRenderer"
-- 引擎的数据模型和视图
require "app.machine.ShareModel"
require "app.machine.ShareView"
-- 添加工具类
require "app.utils.ToolsUtil"


-- 地图
local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
local GameMapManager = require("app.game.GameMapManager")
local LanguageManager = require("app.game.LanguageManager")
Machine = Machine or {}

local ShareMachine = class("ShareMachine", Machine.Base)
Machine.ShareMachine = ShareMachine

require "app.machine.ShareMachineFunction"
require "app.machine.ShareMachineGenerationCmd"

local TRACKS_INDEX = GameTracksIndex
local TRIGGER_TYPE = GameTriggerType
local HANDLE_TRIGGER_TYPE = GameHandleTriggerType
local MonsterSubType = PublicDefine.MonsterSubType
local TRANS_DOOR_TYPE = PublicDefine.TRANS_DOOR_TYPE


local DEBUG = false
local DEBUG_ATTR = false

-- private

-- 根据action类型获取轨道索引
local function getTrackIndexByActionType(actionType)     
    if (actionType == ActionType.FSM_IDLE or
        actionType == ActionType.FSM_MOVE or
        actionType == ActionType.FSM_DIRECTION_MOVE or
        actionType == ActionType.FSM_CLICK_MOVE or
        actionType == ActionType.FSM_BATTLE_MOVE or
        actionType == ActionType.FSM_BATTLE or
        actionType == ActionType.FSM_DIE or
        actionType == ActionType.FSM_WAITING or
        actionType == ActionType.FSM_REVIVE ) then
        return TRACKS_INDEX.FSM
    elseif (actionType == ActionType.BUFFER) then
        return TRACKS_INDEX.BUFFER
    elseif (actionType == ActionType.EFFECT) then
        return TRACKS_INDEX.EFFECT
    elseif (actionType == ActionType.AIRCRAFT_BULLET or
            actionType == ActionType.AIRCRAFT_GETGOODS ) then
        return TRACKS_INDEX.AIRCRAFT
    elseif (actionType == ActionType.FUNCTION_ADD_ROLE or
            actionType == ActionType.FUNCTION_ROLE_ZOEDER or 
            actionType == ActionType.FUNCTION_ROLE_LEVEL_UP or
            actionType == ActionType.NPC_BOX_OPEN or
            actionType == ActionType.NPC_GOLDBAG_OPEN or 
            actionType == ActionType.NPC_RUNE_OPEN or
            actionType == ActionType.NPC_TRAP_OPEN or 
            actionType == ActionType.NPC_TRIGGER_OPEN) then
        return TRACKS_INDEX.FUNCTION
    else
        assert(false, string.format("[ERROR] ActionManager getTrackIndexByType: no track index found by this action type %d.", actionType))
    end
end

-- 获取添加action的轨道信息
local function getActionTrackInfo(self, action)
    -- 获取action的所属轨道
    local type = action:getType()
    local trackIndex = getTrackIndexByActionType(type)

    -- 获取id，如果action没有目标对象，默认id是0
    local id = 0
    local target = action:getTarget()
    if (target) then
        id = target:getId()
    end

    return trackIndex, id
end

-- 构造函数
function ShareMachine:ctor()
    ShareMachine.super.ctor(self)

    -- 角色是否可以移动
    self._enableRoleMoving = true
    self:registerListener()
end

function ShareMachine:destroy(isSimple)

    ShareMachine.super.destroy(self, isSimple)
    self:unRegisterListener()
end

-- 启用角色移动
function ShareMachine:enableRoleMoving()
    self._enableRoleMoving = true
    
end

-- 禁用角色移动
function ShareMachine:disableRoleMoving()
    self._enableRoleMoving = false
end

-- public:
-- 初始化
function ShareMachine:init(battleModel, battleView)
    ShareMachine.super.init(self, battleModel, battleView)

    self._triggerModelArr = {}
    self._triggerCoordArr = {}

    self._clickMonster = false
end

-- 检查玩家是否处于逃跑中
function ShareMachine:checkMasterIsRunAway()
    if(self._model == nil) then 
        return false 
    end
    local master =  self._model:getMaster()
    if(master) then 
        local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if firstAction then
            if firstAction:getFSMState() == FSMState.BATTLE then
                return firstAction:checkIsRunAway()
            end
        end
    end

    return false
end

-- 检查玩家是否处于战斗中
function ShareMachine:checkMasterIsBattle()
    if(self._model == nil) then 
        return false 
    end
    local master =  self._model:getMaster()
    if(master) then 
        local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if firstAction then
            if firstAction:getFSMState() == FSMState.BATTLE then
                return true
            end
        end
    end

    return false
end


-- 推送一个刷新装备指令
function ShareMachine:pushRefreshWearEquipmentCommand(target,wearEquipmentArr)
    if(target) then
        local command = Command.RendererCommand:create(true)
        command:initRefreshWearEquipmentCommand(target:getId(),wearEquipmentArr)
        self:pushCommand(command)
    end
end

-- 点击坐标转换成地图坐标
function Machine:convertCoordToTouchPosition(mapCoord)
    local coordX = 0
    local coordY = 0
    if (self._view) then
        coordX, coordY = self._view:convertCoordToPosition(mapCoord)
    end
    return coordX, coordY
end

-- 点击坐标转换成地图坐标
function ShareMachine:convertTouchPositionToCoord(touchPosition)
    local coordX = 0
    local coordY = 0
    if (self._view) then
        coordX, coordY = self._view:convertPositionToCoord(touchPosition)
    end
    return coordX, coordY
end

-- 处理命令
function ShareMachine:executeCommand(command)
    printError("[ERROR] ShareMachine executeCommand: this method should be overrided.")
    return false
end

-- 添加行为
function ShareMachine:setAction(action)
    local trackIndex, id = getActionTrackInfo(self, action)
    action:setBattleMachine(self)
    if(self._actionTrack) then
        self._actionTrack:setAction(trackIndex, id, action)
    end
end

-- 添加行为
function ShareMachine:addAction(action)
    local trackIndex, id = getActionTrackInfo(self, action)
    action:setBattleMachine(self)
    if(self._actionTrack) then
        self._actionTrack:addAction(trackIndex, id, action)
    end
end

-- 获取某个轨道上的所有行为
function ShareMachine:getActionListByTrackIndex(trackIndex)
    if(self._actionTrack) then
        local actionList = self._actionTrack:getActionListByTrackIndex(trackIndex)
        return actionList
    else
        return nil 
    end
end

-- 获取某个轨道上的某个entry的所有行为
function ShareMachine:getActionListByTrackIndexAndEntryID(trackIndex, entryID)
    if(self._actionTrack) then
        local actionList = self._actionTrack:getActionListByTrackIndexAndEntryID(trackIndex, entryID)
        return actionList
    end
    return nil
end

function ShareMachine:setNewCenterCoordinate(startCoord,endCoord,nowCoord)
    if self._view and startCoord and endCoord and nowCoord then
        -- print("ShareMachine:setNewCenterCoordinate ",startCoord.x,startCoord.y,endCoord.x,endCoord.y,nowCoord.x,nowCoord.y)
        self._view:setNewCenterCoordinate(startCoord,endCoord,nowCoord)
    end
end

function ShareMachine:addIdleAction(target,coord)
    -- print("ShareMachine:addIdleAction ", noInitIdle)
    local action = Action.IDLEStateAction:create(true)
    action:init(target,coord, self)
    self:addAction(action)
end

function ShareMachine:refreshTrapCoverForChamber()
    -- 先判断是否在陷阱的区域内，如果在区域内刷新 placeholder 和 render 表现
    if(SceneManager:getInstance():isInFightScene() == false) then
        return 
    end

    local trapArr = self._model:getTrapArr()
    if(trapArr) then
        for _, trap in pairs(trapArr) do 
            local npcData = trap:getNpcData()
            if(npcData) then
                local occupySize = npcData:getOccupySize()
                local height = occupySize[2]
                local width = occupySize[1]

                local coord = npcData:getCoord()
                if(coord) then 
                    MapDataManager:getInstance():removeRole(
                        GameMapManager:getInstance():getMapData(),
                        Avalon.MathUtil:getInt(coord.x),
                        Avalon.MathUtil:getInt(coord.y),
                        npcData
                    )

                    MapDataManager:getInstance():addRole(
                        GameMapManager:getInstance():getMapData(),
                        Avalon.MathUtil:getInt(coord.x),
                        Avalon.MathUtil:getInt(coord.y),
                        npcData
                    )

                    -- 刷新表现
                    if(self._view) then
                        self._view:refresTrapView(trap)
                    end
                end
            end
        end
    end
end

-- 这里再被挖墙以及不可达到的NPC被移除后都应该被调用
function ShareMachine:refreshTrapCover(coordX, coordY)
    -- 先判断是否在陷阱的区域内，如果在区域内刷新 placeholder 和 render 表现
    if(SceneManager:getInstance():isInFightScene() == false) then
        return 
    end

    local trapArr = self._model:getTrapArr()
    if(trapArr) then
        for _, trap in pairs(trapArr) do 
            local npcData = trap:getNpcData()
            if(npcData) then
                local occupySize = npcData:getOccupySize()
                local height = occupySize[2]
                local width = occupySize[1]

                local coord = npcData:getCoord()
                if(coord) then 
                    if(math.abs(coord.x - coordX) <= (width - 1) / 2 and math.abs(coord.y - coordY) <= (height - 1) / 2) then
                        MapDataManager:getInstance():removeRole(
                            GameMapManager:getInstance():getMapData(),
                            Avalon.MathUtil:getInt(coord.x),
                            Avalon.MathUtil:getInt(coord.y),
                            npcData
                        )

                        MapDataManager:getInstance():addRole(
                            GameMapManager:getInstance():getMapData(),
                            Avalon.MathUtil:getInt(coord.x),
                            Avalon.MathUtil:getInt(coord.y),
                            npcData
                        )

                        -- 刷新表现
                        if(self._view) then
                            self._view:refresTrapView(trap)
                        end
                    end
                end
            end
        end
    end
end

function ShareMachine:hideTownTransDoorTrigger()
    for k,transDoor in pairs(self._model._transDoorMap) do 
        local transData = transDoor:getData()
        local transCoord = transDoor:getCoord()
        if(transData and (transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.CAVE_TO_TOWN or
            transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.GUILD_TO_TOWN or 
            transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.TOWN_TO_GUILD or
            transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.TOWN_TO_MANOR or
            transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.MANOR_TO_TOWN or
            transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.TOWNCAVE_TO_TOWN or
            transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.TOWN_TO_TOWNCAVE or 
            transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.TOWN_TO_BIGSAILPORT or
            transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.BIGSAILPORT_TO_TOWN )) then

            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initHideTransdoorTrigger(transDoor:getId())
            SceneManager:getInstance():pushCommand(renderCommand)
        end
    end
end 

-- 移动一个触发，包括移除等操作
function ShareMachine:moveOneStepTrigger()
    for k,transDoor in pairs(self._model._transDoorMap) do 
        local transData = transDoor:getData()
        local transCoord = transDoor:getCoord()
        if(transData and transData:getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.ROOM_TO_ROOM) then
            local hideTrigger = true
            for _,heroRole in pairs(self._model._heroMap) do 
                local coord = heroRole:getCoord()
                if(coord.x == transCoord.x and coord.y == transCoord.y) then
                    hideTrigger = false
                    break
                end
            end
            if(hideTrigger) then
                -- print("ShareMachine:moveOneStepTrigger ", transCoord.x, transCoord.y)
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initHideTransdoorTrigger(transDoor:getId())
                SceneManager:getInstance():pushCommand(renderCommand)
            else
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initOpenItCommand(transDoor:getId(), false)
                SceneManager:getInstance():pushCommand(renderCommand)
            end
        end
    end

    if(SceneManager:getInstance():isInMaze()) then
        -- print("ShareMachine:moveOneStepTrigger  ")
        -- print(debug.traceback())

        -- for _,heroRole in pairs(self._model._heroMap) do 
        --     local coord = heroRole:getCoord()
        --     -- print("====", coord.x, coord.y)
        -- end

        local transPontArr = self._model:getTrapPointArr()
        for k,transPoint in pairs(transPontArr) do 
            local transData = transPoint:getData()
            local transCoord = transPoint:getCoord()
            if(transData and transData:getTransPointType() ~= PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_ROLE_END) then
                local hideTrigger = true
                local isMaster = false
                for _,heroRole in pairs(self._model._heroMap) do 
                    local coord = heroRole:getCoord()
                    if(coord.x == transCoord.x and coord.y == transCoord.y) then
                        hideTrigger = false
                        if(heroRole:isMaster()) then
                            isMaster = true
                        end
                        break
                    end
                end
                
                if(not isMaster) then
                    -- print("ShareMachine:moveOneStepTrigger ", hideTrigger, transCoord.x, transCoord.y, AvalonUtil.getCurrentTime())
                    if(hideTrigger) then
                        -- print("ShareMachine:moveOneStepTrigger ", transCoord.x, transCoord.y)
                        local renderCommand = Command.RendererCommand:create(true)
                        renderCommand:initHideTransdoorTrigger(transPoint:getId())
                        SceneManager:getInstance():pushCommand(renderCommand)
                    else
                        local renderCommand = Command.RendererCommand:create(true)
                        renderCommand:initOpenItCommand(transPoint:getId(), false, 0)
                        SceneManager:getInstance():pushCommand(renderCommand)
                    end
                end
            end
        end
    end
end

--[[
    角色位置触发时间分发,区分目标位置到达情况
    triggerType: TRIGGER_TYPE 值
    triggerCoord :触发坐标点
    isMaster: 是否为主角
    stop: true 要停止  false 还要继续移动
    moving: 是否移动中
    triggerTimeType:  GameTriggerTimeType
    response: false 需要停止运行了，true 可以继续运行
]] 
function ShareMachine:handleMapTrigger(triggerType,triggerCoord,isMaster,stop, moving, triggerTimeType)
    if(DEBUG) then
        print("ShareMachine:handleMapTrigger  triggerType,triggerCoord.x,triggerCoord.y,isMaster,triggerTimeType=",triggerType,triggerCoord.x,triggerCoord.y,isMaster,triggerTimeType)
    end
    local tileData = self._model:getMapData():getTileDataAtCoord(triggerCoord.x, triggerCoord.y)
    if(isMaster) then 
        if((moving == true and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_MOVE_HALF)
        end

        if((triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NOW)then
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_MASTER_UPDATE_COORD, triggerCoord.x, triggerCoord.y)
        end

        if(SceneManager:getInstance():isInLostRealm()) then 
            local masterModel = self._model:getMaster()
            local step = 5
            local isEnd = false

            -- triggerCoord.x == and triggerCoord.y

            if triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE then 
                local oneData = mvc.festivalModel:getLostRealmDataByCoord(triggerCoord.x, triggerCoord.y)
                -- print("triggerCoord=", triggerCoord, oneData)
                if(oneData) then
                    local lostRealmData = mvc.festivalModel:getLostRealmData()
                    step = 1 + mvc.festivalModel:calculationDisStep(oneData.ID, lostRealmData.currentStep)
                    
                    local str = ConfigManager:getGeneralForKey("LostRealmStart")
                    local strArr = string.split(str, ",")
                    if(strArr and #strArr == 2)then
                        if tonumber(strArr[1]) == triggerCoord.x and tonumber(strArr[2]) == triggerCoord.y then 
                            if(self._view) then
                                self._view:refreshLostRealmCircle(mvc.festivalModel:getWasRunCirle())
                            end
                        end
                    end

                    -- print(":handleMapTrigger( start")
                    -- print(mvc.festivalModel:calculationDisStep(24, 50))
                    -- print(mvc.festivalModel:calculationDisStep(1, 50))
                    -- print(mvc.festivalModel:calculationDisStep(23, 50))
                    -- print(mvc.festivalModel:calculationDisStep(23, 48))
                    -- print(":handleMapTrigger( end")

                    if(step > 0) then
                        local data = {}
                        data.isEnd = isEnd
                        data.step = step

                        local rendererCommand = Command.RendererCommand:create()
                        rendererCommand:initForTypeAndData(CommandType.RENDERER_LOSTREALM_CHANGE, masterModel:getId(), data)
                        SceneManager:getInstance():pushCommand(rendererCommand)
                    end
                end
            end
        end
    end

    local trigerNoReachable = true
    local triggerNotBeNodePath = true
    local triggerBeNodePath = true
    if triggerType == TRIGGER_TYPE.TRIGGER_NOBENODEPATH  then
        triggerBeNodePath = false
    end

    if triggerType == TRIGGER_TYPE.TRIGGER_BENODEPATH then
        trigerNoReachable = false
        triggerNotBeNodePath = false
    end
    
    if DEBUG then
        print("ShareMachine:handlePreMoveNext  titleData", tileData, triggerCoord.x, triggerCoord.y)
        if(tileData) then
            print("ShareMachine:handlePreMoveNext reachable, canBeNodeOfPath=",tileData:isReachable(),tileData:canBeNodeOfPath())
        end
        print("ShareMachine:handlePreMoveNext trigerNoReachable,triggerNotBeNodePath,triggerBeNodePath=",trigerNoReachable,triggerNotBeNodePath,triggerBeNodePath)
    end
    if tileData then
        -- 判断下一格是否可以移动过去以及是否有怪物是否需要进入战斗
        if not tileData:isReachable() then
            if trigerNoReachable then
                --  触发不可达障碍物
                -- self:triggerNoReachable(tileData,stop,isMaster)
                self:titleTrigger(HANDLE_TRIGGER_TYPE.TRIGGER_NO_REACHABLE, tileData, stop, isMaster, moving, triggerTimeType)
            end
        else
            -- print("ShareMachine:handlePreMoveNext isReachable")
            if tileData:canBeNodeOfPath() == false then
                --  触发不可寻路触发
                if triggerNotBeNodePath then
                    -- self:triggerNotBeNodeOfPath(tileData,stop,isMaster)
                    self:titleTrigger(HANDLE_TRIGGER_TYPE.TRIGGER_NO_BE_NODE_OF_PATH, tileData, stop, isMaster, moving, triggerTimeType)
                end
            else
                if triggerBeNodePath then
                    --  触发可直接寻路触发
                    -- self:triggerBeNodeOfPath(tileData,stop,isMaster)
                    return self:titleTrigger(HANDLE_TRIGGER_TYPE.TRIGGER_BE_NODE_OF_PATH, tileData, stop, isMaster, moving, triggerTimeType)
                end

                return true
            end
        end
    end

    return false
end

--[[
    Using:处理可以到达的角色触发
    handleTriggerType: GameHandleTriggerType 值
    tileData: 地图块
    stop:是否移动完这格就停止
    isMaster:是否主角
    moving:是否处于移动中
    triggerTimeType:GameTriggerTimeType

    response: false 需要停止移动，true 可以继续移动
]]
function ShareMachine:titleTrigger(handleTriggerType, tileData, stop, isMaster, moving, triggerTimeType)
    local returnFlag = false
    local returnStatus = true
    if(isMaster and SceneManager:getInstance():isActCave()) then 
        -- print("ShareMachine:titleTrigger(", isMaster and moving and SceneManager:getInstance():isActCave())
        self:_controlMazeFunExploreEnd()
    end

    if(isMaster) then
        if DEBUG then
            print("ShareMachine:titleTrigger tileData=",handleTriggerType)
            -- dump(tileData)
        end

        -- 处理多格触发, 在MapDataManager:addRole  里面添加了对应的 placeholder 
        if tileData.placeholderDatas then
            -- 获取当前角色所在格子的数据信息
            local preNPCInfomationIDArr = {}
            if((moving == true and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE)) then 
                local masterCoord = self._model:getMaster():getCoord()
                local titleData = self._model:getMapTileData(masterCoord.x, masterCoord.y)
                if(titleData) then
                    for _,placeholderData in pairs(titleData.placeholderDatas) do
                        if placeholderData:getTypeName() == PlaceholerTypeName.NPC_INFOMATION then
                            local spriteID = placeholderData:getAssocialtedID()
                            preNPCInfomationIDArr[spriteID] = spriteID
                        end
                    end
                end
            end

            local NPCInfomationIDArr = {}
            for _,placeholderData in pairs(tileData.placeholderDatas) do
                if(DEBUG) then
                    print("ShareMachine:titleTrigger  ",placeholderData:getTypeName(), placeholderData:getAssocialtedID())
                end
                if placeholderData:getTypeName() == PlaceholerTypeName.TRIGGER_NPC 
                    or placeholderData:getTypeName() == PlaceholerTypeName.MONSTER 
                    or placeholderData:getTypeName() == PlaceholerTypeName.TRIGGER_MONSTER_TITLE then
                    if(DEBUG) then
                        print(placeholderData:getTypeName())
                    end

                    local roleData = self._model:getRoleBySpriteID(placeholderData:getAssocialtedID())
                    if(roleData ~= nil) then
                        if(DEBUG) then
                            print("ShareMachine:titleTrigger roleData is not nil.")
                        end
                        if(handleTriggerType == HANDLE_TRIGGER_TYPE.TRIGGER_NO_REACHABLE) then
                            self:handleNoReachable(roleData, stop, moving, triggerTimeType,tileData,placeholderData, isMaster)
                        elseif handleTriggerType == HANDLE_TRIGGER_TYPE.TRIGGER_NO_BE_NODE_OF_PATH then
                            self:handleNoBeNodeOfPath(roleData, stop, moving, triggerTimeType,tileData,placeholderData, isMaster)
                        elseif handleTriggerType == HANDLE_TRIGGER_TYPE.TRIGGER_BE_NODE_OF_PATH then
                            returnFlag = true
                            local status = self:handleBeNodeOfPath(roleData, stop, moving, triggerTimeType,tileData,placeholderData, isMaster)
                            if(status == false and returnStatus == true) then
                                returnStatus = false
                            end
                        end
                    end
                end

                -- 处理NPC气泡处理  
                if placeholderData:getTypeName() == PlaceholerTypeName.NPC_INFOMATION then
                    local spriteID = placeholderData:getAssocialtedID()
                    NPCInfomationIDArr[spriteID] = spriteID
                    -- print("placeholderData:getTypeName()=", placeholderData:getTypeName(), spriteID)
                end
            end

            -- 处理气泡范围离开等相关的逻辑
            -- 先判断离开的
            for k,v in pairs(preNPCInfomationIDArr) do
                if(NPCInfomationIDArr[k] == nil) then
                    -- 处理离开了逻辑
                    local npcModel = self._model:getRoleBySpriteID(k)
                    if(npcModel) then
                        npcModel:getNpcData():setNPCInfomationStatus(false)
                    end
                end
            end

            -- 判断新进入
            for k,v in pairs(NPCInfomationIDArr) do
                if(preNPCInfomationIDArr[k] == nil) then
                    -- 处理新进入的东西
                    local npcModel = self._model:getRoleBySpriteID(k)
                    if(npcModel) then
                        -- 处理是否有任务的相关提示
                        if(npcModel:getNpcData():judgeNPCInfomationTrigger()) then
                            local speak, taskData = npcModel:getNpcData():getComeUpChat()
                            local txt = nil
                            local internal = 0
                            if(speak and taskData)then
                                txt = speak:getRandomText()
                                internal = taskData:getShowTime()
                            end

                            -- print("ShareMachine:titleTrigger", npcModel:getNpcData():getId(), txt, internal, npcModel:getNpcData():getCoord())
                            if(txt and internal) then 
                                local renderCommand = Command.RendererCommand:create(true)
                                renderCommand:initNPCInfomationShow(npcModel:getId(), LanguageManager:getInstance():getLocalString(tonumber(txt)), internal)
                                SceneManager:getInstance():pushCommand(renderCommand)
                                npcModel:getNpcData():setNPCInfomationTriggerTime()
                                return 
                            end 
                        end

                        -- 处理屏蔽是否解锁
                        local functionTypeArr = npcModel:getNpcData():getFunctionTypeArr()
                        local newFunctionTypeArr = Game.FunctionUnlockManager:getInstance():checkNpcFunction(functionTypeArr)
                        if(#functionTypeArr == #newFunctionTypeArr) then
                            if(npcModel:getNpcData():judgeNPCInfomationTrigger()) then
                                -- 这里区别对待运营活动
                                if(npcModel:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.ACTIVITY)) then
                                    local chatRoom = npcModel:getNpcData():getChatRoom()
                                    if(chatRoom and #chatRoom == 2) then 
                                        local activityArr = MasterDataManager:getActivityDataArr()

                                        local haveComplete = false
                                        local haveNew = false
                                        if(activityArr) then
                                            for k, activityData in ipairs(activityArr) do 
                                                if(activityData:getIsNew()) then
                                                    haveNew = true
                                                end
                                                if(activityData:getIsHaveAward()) then
                                                    haveComplete = true
                                                end 
                                            end
                                        end

                                        local chat = nil
                                        if(haveComplete) then
                                            chat = chatRoom[1]
                                        elseif haveNew then
                                            chat = chatRoom[2]
                                        end

                                        if(chat) then
                                            local renderCommand = Command.RendererCommand:create(true)
                                            renderCommand:initNPCInfomationShow(npcModel:getId(), LanguageManager:getInstance():getLocalString(tonumber(chat)), npcModel:getNpcData():getTalkDuration())
                                            SceneManager:getInstance():pushCommand(renderCommand)
                                            npcModel:getNpcData():setNPCInfomationTriggerTime()
                                        end
                                    end
                               elseif(npcModel:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.GEMSTONE_BUY)) then
                                    -- 宝石商人吆喝
                                    local chatRoom = npcModel:getNpcData():getChatRoom()
                                    if(chatRoom and #chatRoom == 1) then
                                        local dataList = ConfigManager:getAllGemStoneShopData()
                                        local haveFreeGem = false
                                        for k, v in pairs(dataList) do
                                            local netData = MasterDataManager:getOneGemstoneShopRecordById(v.ID)
                                            if netData and netData.freeSec <= GameManager:getNormalServerTime() then
                                                haveFreeGem = true
                                                break
                                            end
                                        end
                                        if haveFreeGem then
                                            local chat = chatRoom[1]
                                            local renderCommand = Command.RendererCommand:create(true)
                                            renderCommand:initNPCInfomationShow(npcModel:getId(), LanguageManager:getInstance():getLocalString(tonumber(chat)), npcModel:getNpcData():getTalkDuration())
                                            SceneManager:getInstance():pushCommand(renderCommand)
                                            npcModel:getNpcData():setNPCInfomationTriggerTime()
                                        end
                                    end 

                                elseif(npcModel:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION)) then
                                    -- 探险队功能
                                    local informationStr = npcModel:getNpcData():getInformationFunction()
                                    local chat = nil
                                    if(informationStr) then 
                                        local infoArr = string.split(informationStr,";")

                                        -- 第一级：玩家有免费快速探险次数
                                        if mvc.expeditionModel:getHaveFreeExpedition() then 
                                            chat = infoArr[1]
                                        -- 有探险时间未探险
                                        elseif mvc.expeditionModel:getRemainTime() > 0 and mvc.expeditionModel:getExpeditionStatus() == false then 
                                            chat = infoArr[2]
                                        -- 快速探险袋不空
                                        elseif mvc.expeditionModel:getIsNotNullForPacketType(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then 
                                            chat = infoArr[3]
                                        -- 普通探险带不空
                                        elseif mvc.expeditionModel:getIsNotNullForPacketType(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then
                                            chat = infoArr[4]
                                        end 
                                    end
                                    -- print("cat 2222=", informationStr, chat, LanguageManager:getInstance():getLocalString(tonumber(chat)))
                                    if(chat) then
                                        local renderCommand = Command.RendererCommand:create(true)
                                        renderCommand:initNPCInfomationShow(npcModel:getId(), LanguageManager:getInstance():getLocalString(tonumber(chat)), npcModel:getNpcData():getTalkDuration())
                                        SceneManager:getInstance():pushCommand(renderCommand)
                                        npcModel:getNpcData():setNPCInfomationTriggerTime()
                                    end
                                else 
                                    -- 添加表现
                                    local chatRoom = npcModel:getNpcData():getChatRoom()
                                    local chat = chatRoom[math.random(#chatRoom)]
                                    if(chat) then
                                        local renderCommand = Command.RendererCommand:create(true)
                                        renderCommand:initNPCInfomationShow(npcModel:getId(), LanguageManager:getInstance():getLocalString(tonumber(chat)), npcModel:getNpcData():getTalkDuration())
                                        SceneManager:getInstance():pushCommand(renderCommand)
                                        npcModel:getNpcData():setNPCInfomationTriggerTime()
                                    end
                                end
                            end
                            npcModel:getNpcData():setNPCInfomationStatus(true)
                        end 
                    end
                end
            end
        end

        -- 判断是否为怪物，地刺等需要触发
        if tileData.roleDatas then
            for _, roleData in pairs(tileData.roleDatas) do
                if DEBUG then
                    print("ShareMachine:triggerNoReachable 2 key,type,Monster=",roleData:getType(),roleData:getCategory())
                    if not roleData:getType() then
                        for k,v in pairs(roleData) do
                            print("ShareMachine:triggerNoReachable k,v=",k,v)
                        end 
                    end
                end

                returnFlag = true
                local status = true
                if(handleTriggerType == HANDLE_TRIGGER_TYPE.TRIGGER_NO_REACHABLE) then
                    status = self:handleNoReachable(roleData, stop, moving, triggerTimeType,tileData, nil, isMaster)
                elseif handleTriggerType == HANDLE_TRIGGER_TYPE.TRIGGER_NO_BE_NODE_OF_PATH then
                    status = self:handleNoBeNodeOfPath(roleData, stop, moving, triggerTimeType,tileData, nil, isMaster)
                elseif handleTriggerType == HANDLE_TRIGGER_TYPE.TRIGGER_BE_NODE_OF_PATH then
                    status = self:handleBeNodeOfPath(roleData, stop, moving, triggerTimeType,tileData, nil, isMaster)
                end

                if(status == false and returnStatus == true) then
                    returnStatus = false
                end
            end
        end     
    end
    if(returnFlag) then 
        return returnStatus
    end

    return true
end

--[[
    Using:处理不可以到达的角色触发
    roleData: 角色数据
    stop:是否移动完这格就停止
    moving:是否处于移动中
    triggerTimeType:GameTriggerTimeType
]]
function ShareMachine:handleNoReachable(roleData, stop, moving, triggerTimeType,tileData,placeholderData,isMaster)
     -- 判断是否为怪物，地刺等需要触发
    local category = roleData:getCategory()
    if category == Category.ROLE then
        if roleData:getType() == RoleType.Monster then
            if DEBUG then
                print("ShareMachine:handleNoReachable",roleData:getCoord().x, tileData:getX() , roleData:getCoord().y ,tileData:getY())
            end 

            if stop == false and roleData:getCoord().x == tileData:getX() and roleData:getCoord().y == tileData:getY() then
                if DEBUG then
                    print("ShareMachine:triggerNotBeNodeOfPath isReachable trigger battle spriteID=",roleData.spriteID)
                end
                -- 触发怪物
                local fsmCommand = Command.BattleCommand:create(true)
                fsmCommand:initForTypeAndData(CommandType.BATTLE_START_BATTLE,roleData)
                SceneManager:getInstance():pushCommand(fsmCommand)

                return false
            end
        elseif roleData:getType() == RoleType.Monster then
            -- TODO 
            
        end
    elseif category == Category.TRIGGER_NPC then
        if(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
            if ((moving == true and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
                -- local battleCmd = Command.BattleCommand:create()
                -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                -- SceneManager:getInstance():pushCommand(battleCmd)

                self:_pushOpenTriggerNpcCommand(roleData)
            end
        else
            if((stop == false and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
                if DEBUG then
                    print("ShareMachine:handleNoReachable",roleData:getSpriteID(), category,roleData:getType())
                end
                
                -- local battleCmd = Command.BattleCommand:create()
                -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                -- SceneManager:getInstance():pushCommand(battleCmd)

                self:_pushOpenTriggerNpcCommand(roleData)
            end
        end
    else
        
    end

    return true
end

--[[
    Using:处理不能直接走过去的角色触发
    roleData: 角色数据
    stop:是否移动完这格就停止
    moving:是否处于移动中
    triggerTimeType:GameTriggerTimeType
]]
function ShareMachine:handleNoBeNodeOfPath(roleData, stop, moving, triggerTimeType,tileData,placeholderData,isMaster)
    local category = roleData:getCategory()
    if category == Category.ROLE then
        if roleData:getType() == RoleType.Monster then
            if DEBUG then
                print("ShareMachine:handleBeNodeOfPath",roleData:getCoord().x, tileData:getX() , roleData:getCoord().y ,tileData:getY())
            end

            if (roleData:getMonsterSubType() == MonsterSubType.Trigger or roleData:getMonsterSubType() == MonsterSubType.Treasure) then
                if ((moving == true and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
                    --是否达到角色触发的位置
                    -- 触发怪物
                    if (not roleData:getIsTrigger()) then 
                        local battleCMD = Command.BattleCommand:create(true)
                        battleCMD:initForTypeAndData(CommandType.BATTLE_TRIGGER_MONSTER, roleData:getSpriteID())
                        SceneManager:getInstance():pushCommand(battleCMD)
                    end
                end
                
                if stop == false and roleData:getCoord().x == tileData:getX() and roleData:getCoord().y == tileData:getY() then
                    if DEBUG then
                        print("ShareMachine:triggerNotBeNodeOfPath isReachable trigger battle spriteID=",roleData.spriteID)
                    end
                    
                    local fsmCommand = Command.BattleCommand:create(true)
                    fsmCommand:initForTypeAndData(CommandType.BATTLE_START_BATTLE,roleData)
                    SceneManager:getInstance():pushCommand(fsmCommand)
                    return false
                end
            else
                if stop == false then
                    if DEBUG then
                        print("ShareMachine:triggerNotBeNodeOfPath isReachable trigger battle spriteID=",roleData.spriteID)
                    end
                    local fsmCommand = Command.BattleCommand:create(true)
                    fsmCommand:initForTypeAndData(CommandType.BATTLE_START_BATTLE,roleData)
                    SceneManager:getInstance():pushCommand(fsmCommand)
                    return false
                end
            end
            
        elseif roleData:getType() == RoleType.Monster then
            -- TODO 

        end
    elseif category == Category.TRIGGER_NPC then
        if(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
            -- 这里对于传送门处理两种方案的触发
            if(roleData:getTransdoorType() == TRANS_DOOR_TYPE.CAVE_TO_TOWN 
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_GUILD
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.GUILD_TO_TOWN
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWNCAVE_TO_TOWN
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.MANOR_TO_TOWN
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_MANOR
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_TOWNCAVE
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_BIGSAILPORT
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.BIGSAILPORT_TO_TOWN ) then
                if DEBUG then
                    print("ShareMachine TRANSDOOR", moving, triggerTimeType)
                end
                if ((moving == false and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE))then
                    if DEBUG then
                        print("ShareMachine TRANSDOOR   trigger openTrigger")
                    end
                    -- local battleCmd = Command.BattleCommand:create()
                    -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                    -- SceneManager:getInstance():pushCommand(battleCmd)

                    self:_pushOpenTriggerNpcCommand(roleData)
                elseif (triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NOW ) then
                    if DEBUG then
                        print("ShareMachine TRANSDOOR   trigger transDoorTrigger")
                    end
                    -- 触发传送回城
                    local battleCmd = Command.BattleCommand:create()
                    battleCmd:initTransDoorTrigger(roleData:getSpriteID())
                    SceneManager:getInstance():pushCommand(battleCmd)

                    return false
                end
            elseif(roleData:getTransdoorType() == TRANS_DOOR_TYPE.ROOM_TO_ROOM ) then
                if DEBUG then
                    print("ShareMachine TRANSDOOR", moving, triggerTimeType)
                end
                if (triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NOW or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL) then
                    if DEBUG then
                        print("ShareMachine TRANSDOOR   trigger transDoorTrigger")
                    end
                    -- 触发传送到其它房间
                    local battleCmd = Command.BattleCommand:create()
                    battleCmd:initTransDoorTrigger(roleData:getSpriteID())
                    SceneManager:getInstance():pushCommand(battleCmd)

                    return false
                end
            else
                if(stop == false and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE)then
                    -- local battleCmd = Command.BattleCommand:create()
                    -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                    -- SceneManager:getInstance():pushCommand(battleCmd)

                    self:_pushOpenTriggerNpcCommand(roleData)
                end
            end
        elseif(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
            if ((moving == true and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
                -- local battleCmd = Command.BattleCommand:create()
                -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                -- SceneManager:getInstance():pushCommand(battleCmd)

                self:_pushOpenTriggerNpcCommand(roleData)
            end
        elseif(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT) then
            -- print("ShareMachine handleBeNodeOfPath   trigger transDoorTrigger 0")
            if(roleData and roleData:getCoord()) then 
                local coord = roleData:getCoord()
                -- print("ShareMachine handleBeNodeOfPath   trigger transDoorTrigger 1")
                if not MasterDataManager:getIsOnlyMasterTrapMazePointForCoord(coord.x, coord.y) 
                    or (roleData.getIsSystemTransPointType and roleData:getIsSystemTransPointType())  then
                    if (moving and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NOW or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL) then
                    -- if (triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NOW or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL) then
                        -- local battleCmd = Command.BattleCommand:create()
                        -- battleCmd:initTransDoorTrigger(roleData:getSpriteID())
                        -- SceneManager:getInstance():pushCommand(battleCmd)
                        -- print("ShareMachine handleBeNodeOfPath   trigger transDoorTrigger 2")
                        local battleCmd = Command.BattleCommand:create()
                        if(isMaster) then
                            -- self:disableRoleMoving()
                            GameManager:disableMovingHandler()
                            battleCmd:initTransPointTrigger(roleData:getSpriteID(), RoleDataManager:getMasterPK())
                        else
                            battleCmd:initTransPointTrigger(roleData:getSpriteID(), 0)
                        end
                        
                        SceneManager:getInstance():pushCommand(battleCmd)
                        return false
                    end
                end 
            end
        else
            if((stop == false and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
                -- local battleCmd = Command.BattleCommand:create()
                -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                -- SceneManager:getInstance():pushCommand(battleCmd)

                self:_pushOpenTriggerNpcCommand(roleData)
            end
        end
    end

    return true
end

--[[
    Using:处理可以直接走过去的角色触发
    roleData: 角色数据
    stop:是否移动完这格就停止
    moving:是否处于移动中
    triggerTimeType:GameTriggerTimeType
]]
function ShareMachine:handleBeNodeOfPath(roleData, stop, moving, triggerTimeType,tileData,placeholderData, isMaster)
    local category = roleData:getCategory()
    if category == Category.ROLE then
        if roleData:getType() == RoleType.Monster then
            if (roleData:getMonsterSubType() == MonsterSubType.Trigger or roleData:getMonsterSubType() == MonsterSubType.Treasure) then
                if ((moving == true and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
                    -- 触发怪物
                    if (not roleData:getIsTrigger()) then 
                        local battleCMD = Command.BattleCommand:create(true)
                        battleCMD:initForTypeAndData(CommandType.BATTLE_TRIGGER_MONSTER, roleData:getSpriteID())
                        SceneManager:getInstance():pushCommand(battleCMD)
                    end
                end

                if stop == false and roleData:getCoord().x == tileData:getX() and roleData:getCoord().y == tileData:getY() then
                    if DEBUG then
                        print("ShareMachine:triggerNotBeNodeOfPath isReachable trigger battle spriteID=",roleData.spriteID)
                    end
                    local fsmCommand = Command.BattleCommand:create(true)
                    fsmCommand:initForTypeAndData(CommandType.BATTLE_START_BATTLE,roleData)
                    SceneManager:getInstance():pushCommand(fsmCommand)

                    return false
                end
            else
                if stop == false then
                    if DEBUG then
                        print("ShareMachine:triggerNotBeNodeOfPath isReachable trigger battle spriteID=",roleData.spriteID)
                    end
                    local fsmCommand = Command.BattleCommand:create(true)
                    fsmCommand:initForTypeAndData(CommandType.BATTLE_START_BATTLE,roleData)
                    SceneManager:getInstance():pushCommand(fsmCommand)

                    return false
                end
            end
        elseif roleData:getType() == RoleType.Monster then
            -- TODO 

        end
    elseif category == Category.TRIGGER_NPC then
        if(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
            if(roleData:getTransdoorType() == TRANS_DOOR_TYPE.ROOM_TO_ROOM
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_GUILD
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.GUILD_TO_TOWN
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWNCAVE_TO_TOWN
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.MANOR_TO_TOWN 
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_MANOR
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_TOWNCAVE
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_BIGSAILPORT
                or roleData:getTransdoorType() == TRANS_DOOR_TYPE.BIGSAILPORT_TO_TOWN  ) then
                if DEBUG then
                    print("ShareMachine TRANSDOOR", moving, triggerTimeType)
                end
                if (triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NOW or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL) then
                    if DEBUG then
                        print("ShareMachine TRANSDOOR   trigger transDoorTrigger")
                    end
                    -- 触发传送到其它房间
                    local battleCmd = Command.BattleCommand:create()
                    battleCmd:initTransDoorTrigger(roleData:getSpriteID())
                    SceneManager:getInstance():pushCommand(battleCmd)
                end
            else
                if ((moving == true and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL
                    or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NOW)then
                    -- local battleCmd = Command.BattleCommand:create()
                    -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                    -- SceneManager:getInstance():pushCommand(battleCmd)

                    self:_pushOpenTriggerNpcCommand(roleData)
                end
            end
        elseif(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
            if ((moving == true and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
                -- local battleCmd = Command.BattleCommand:create()
                -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                -- SceneManager:getInstance():pushCommand(battleCmd)

                self:_pushOpenTriggerNpcCommand(roleData)
            end
        elseif(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.COLLECT) then
            
        elseif(roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT) then
            -- print("ShareMachine TRANSDOOR   trigger transDoorTrigger 0")
            if(roleData and roleData:getCoord()) then 
                local coord = roleData:getCoord()
                -- print("ShareMachine TRANSDOOR   trigger transDoorTrigger 1")
                if not MasterDataManager:getIsOnlyMasterTrapMazePointForCoord(coord.x, coord.y) 
                    or (roleData.getIsSystemTransPointType and roleData:getIsSystemTransPointType()) then 
                    if (moving and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NOW or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL) then
                        if DEBUG then
                            print("ShareMachine TRANSDOOR   trigger transDoorTrigger")
                        end
                        local battleCmd = Command.BattleCommand:create()
                        if(isMaster) then
                            -- self:disableRoleMoving()
                            GameManager:disableMovingHandler()
                            battleCmd:initTransPointTrigger(roleData:getSpriteID(), RoleDataManager:getMasterPK())
                        else
                            battleCmd:initTransPointTrigger(roleData:getSpriteID(), 0)
                        end
                        -- MachineManager:getInstance():executeCommand(battleCmd)
                        SceneManager:getInstance():pushCommand(battleCmd)
                        return false
                    end
                end
            end
        else
            if((stop == false and triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_PRE) or triggerTimeType == GameTriggerTimeType.TRIGGER_TIME_NORMAL)then
                -- local battleCmd = Command.BattleCommand:create()
                -- battleCmd:initForOpenTriggerNpc(roleData:getSpriteID())
                -- -- SceneManager:getInstance():pushCommand(battleCmd)
                -- MachineManager:getInstance():executeCommand(battleCmd)

                self:_pushOpenTriggerNpcCommand(roleData)
            end
        end
    end

    return true
end

function ShareMachine:_pushOpenTriggerNpcCommand(roleData, isMiniMap)
    if(roleData) then
        local battleCmd = Command.BattleCommand:create()
        battleCmd:initForOpenTriggerNpc(roleData:getSpriteID(), isMiniMap)
        -- 这里对于 FunctionNPC 特殊处理是为了处理 CO-3477
        if ( roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC ) then 
            MachineManager:getInstance():executeCommand(battleCmd)
        else 
            SceneManager:getInstance():pushCommand(battleCmd)
        end
    end
end

function ShareMachine:_handleResetTimeBuff(bufferData)
    -- 刷新BUFF 
    local bufferActionList = self:getActionListByTrackIndex(TRACKS_INDEX.BUFFER)
    if (bufferActionList) then
        for i=1, #bufferActionList do
            bufferAction = bufferActionList[i]

            if(bufferAction:hasBuffer(bufferData.targetSpriteID, bufferData.entityID)) then
                -- 处理添加刷新时间的处理
                bufferAction:refreshBuffer()
                break
            end
        end
    end
end

-- 处理添加一个buff
function ShareMachine:_handleAddBuff(data, targetSpriteID, isRecover)
    -- print(string.format("BattleMachine _handleAddBuff: add buffer (entityID:%d bufferID:%d sourceID:%d targetID:%d duration:%d overlay:%d) from server.",
    --     data.entityID,
    --     data.buffID,
    --     targetSpriteID,
    --     data.sourceSpriteID,
    --     data.curDuration,
    --     data.overlayNum
    -- ))

    local bufferAction = nil
    local buffer = nil

    local found = false
    local isSameAction = false

    local bufferActionList = self:getActionListByTrackIndex(TRACKS_INDEX.BUFFER)
    if (bufferActionList) then
        for i=1, #bufferActionList do
            bufferAction = bufferActionList[i]

            if(bufferAction:hasBuffer(targetSpriteID, data.entityID)) then
                found = true
                break
            end

            -- buffer = bufferAction:getBuffer()
            
            -- if buffer:getEntityID() == data.entityID then 
            --     found = true
            --     break 
            -- end
            
            -- if bufferAction:isSameBuffer(data.buffID, data.sourceSpriteID, targetSpriteID) then
            --     isSameAction = true
            --     break
            -- end
        end
    end
    if found then
        -- local overlayType = buffer:getOverlayType()
        -- if (overlayType == BufferOverlayType.REFRESH) then
        --     bufferAction:overlayAndRefresh(data.overlayNum, data.curDuration)
        -- elseif (overlayType == BufferOverlayType.NO_REFRESH) then
        --     bufferAction:overlay(data.overlayNum)
        -- else
        --    assert(false, "[ERROR] BattleMachine _handleAddBuff: overlayType is invalid.")
        -- end
    else
        local bufferTarget = self._model:getRoleBySpriteID(targetSpriteID)
        local bufferCaster = self._model:getRoleBySpriteID(data.sourceSpriteID)

        if (bufferTarget) then

            local master = self._model:getMaster()
            local masterSpriteID = nil
            if master then
                masterSpriteID = master:getSpriteID()
            end
            if SceneManager:getInstance():isInHitRat() and masterSpriteID == targetSpriteID then
                local directionCommand = Command.RendererCommand:create(true)
                directionCommand:initForTypeAndData(CommandType.RENDERER_HIT_RAT_BUFF, bufferTarget:getId(), data:isGood())
                self:pushCommand(directionCommand)
                local langMap = {
                    [31009300] = 1112948,
                    [31009301] = 1112999,
                    [31009302] = 1112949,
                    [31009303] = 1112950,
                    [31009304] = 1112951,
                }
                if langMap[data:getID()]  then
                    UI.ScrollBar:createByText(UIUtil:lang(langMap[data:getID()]))
                end
            end

            if isSameAction then
                -- print("BattleMachine _handleAddBuff: add the same buffer.")

                bufferAction:addBuffer(data.entityID)
                bufferAction:refresh(data.curDuration)
            else
                -- print("BattleMachine _handleAddBuff: add a new buffer.")

                bufferAction = Action.BufferAction:create(true)
                -- bufferAction:initByID(data.buffID, data.entityID,bufferCaster, bufferTarget, data.curDuration, data.overlayNum)
                bufferAction:initByData(data, bufferCaster, bufferTarget, isRecover)
                self:addAction(bufferAction)
            end
        else
            if (bufferTarget == nil) then
                -- 这里去掉这个错误，为了兼容在没有创建玩家对象的时候，直接给玩家添加bufff ，这里的buff 会在收到数据的时候缓存，最后在显示玩家数据的时候恢复buff 
                --assert(false, string.format("[ERROR] BattleMachine _handleAddBuff: buffer target %d is nil.", targetSpriteID))
            end
            if (bufferCaster == nil) then
                --assert(false, string.format("[ERROR] BattleMachine _handleAddBuff: buffer caster %d is nil.", data.sourceSpriteID))
            end
        end
    end
end

-- 把属性改变消息转换为伤害显示数据
function ShareMachine:_handleAttrChangeMes(mesData,wasBattleMaster,masterSpriteID, isMonster, masterPetSpriteID)
    local data = {}
    if mesData and mesData.attrChange then
        data.attrChange = {}
        local ATTR_TYPE = PublicDefine.ATTR_TYPE
        for k,attrInfo in pairs(mesData.attrChange) do
            if DEBUG_ATTR then
                print("ShareMachine:_handleAttrChangeMes   sourceSpriteID,masterSpriteID,mesData.spriteID=",attrInfo.sourceSpriteID,masterSpriteID,mesData.spriteID)
            end
            
            if attrInfo.changeType == ATTR_TYPE.curCoin or attrInfo.changeType == ATTR_TYPE.curLVExp then
                self:_removeDropTrigger(attrInfo.sourceSpriteID)

                -- 不管来源
                self:_handleOneAttrChange(data.attrChange,attrInfo.changeValue,attrInfo.changeType,attrInfo.changeReason,wasBattleMaster)
            else
                -- 过滤来源问题
                -- TOD 处理确定是否一定需要来源ID
                if attrInfo.sourceSpriteID 
                    and (attrInfo.sourceSpriteID == masterSpriteID 
                    or masterSpriteID == mesData.spriteID 
                    or masterPetSpriteID == mesData.spriteID
                    or attrInfo.sourceSpriteID == masterPetSpriteID
                    or (attrInfo.sourceSpriteID == mesData.spriteID and isMonster)) 
                then
                -- if attrInfo.sourceSpriteID and attrInfo.sourceSpriteID ~= 0 and (attrInfo.sourceSpriteID == masterSpriteID or masterSpriteID == mesData.spriteID) then
                    self:_handleOneAttrChange(data.attrChange,attrInfo.changeValue,attrInfo.changeType,attrInfo.changeReason,wasBattleMaster)
                end
            end
        end
    end

    return data
end

-- 把属性改变消息转换为伤害显示数据
function ShareMachine:_handleNoFilterAttrChangeMes(mesData)
    local data = {}
    if mesData and mesData.attrChange then
        data.attrChange = {}
        local ATTR_TYPE = PublicDefine.ATTR_TYPE
        for k,attrInfo in pairs(mesData.attrChange) do
            if attrInfo.changeType == ATTR_TYPE.curCoin or attrInfo.changeType == ATTR_TYPE.curLVExp then
            else
                self:_handleOneAttrChange(data.attrChange,attrInfo.changeValue,attrInfo.changeType,attrInfo.changeReason)
            end
        end
    end
    return data
end

-- 处理一条属性改变的消息的转换
function ShareMachine:_handleOneAttrChange(allData,value,type,reason,wasBattleMaster)
    if DEBUG_ATTR then
        print("ShareMachine:_handleOneAttrChange  value,type,reason,wasBattleMaster =",value,type,reason,wasBattleMaster)
    end
    -- TODO 测试效果
    -- wasBattleMaster = true

    local attrType = CLIENT_ATTR_CHANGE_REASON
    local ATTR_TYPE = PublicDefine.ATTR_TYPE
    local ATTR_CHANGE_STYLE = PublicDefine.ATTR_CHANGE_STYLE
    local ATTR_CHANGE_REASON_TYPE = PublicDefine.ATTR_CHANGE_REASON_TYPE
    local EFFECTED_REASON_TYPE = PublicDefine.EFFECTED_REASON_TYPE

    local data = {}
    data.value = value
    data.type = type

    -- 解析原因
    local reasonTypeOne,reasonTypeTwo,reasonTypeThree,reasonTypeFour = ToolsUtil:splitAttrReason(reason)

    if DEBUG_ATTR then
        print("ShareMachine:_handleOneAttrChange  =",reasonTypeOne,reasonTypeFour, data.type, data.value)
        print("reasonTypeTwo")
        dump(reasonTypeTwo)
        print("reasonTypeThree")
        dump(reasonTypeThree)
    end

    -- 生命值恢复
    if value >0 and type == ATTR_TYPE.curHp then
        -- 和策划确认不需要判定原因
        if reasonTypeOne ~= ATTR_CHANGE_REASON_TYPE.EQUIP_EQUIPMENT then

            data.reason = attrType.HP_RESTORE
        end
    -- 魔法值恢复
    elseif value >0 and type == ATTR_TYPE.curMp then
        if reasonTypeOne == ATTR_CHANGE_REASON_TYPE.USE_ITEM
            or reasonTypeOne == ATTR_CHANGE_REASON_TYPE.RESTORE
            or reasonTypeOne == ATTR_CHANGE_REASON_TYPE.RESTORE_AFTER_ATTACK
            or reasonTypeOne == ATTR_CHANGE_REASON_TYPE.RESTORE_AFTER_BATTLE
            or reasonTypeOne == ATTR_CHANGE_REASON_TYPE.EXTRA_RESTORE then
            
            data.reason = attrType.MAGIC_RESTORE
        end
    -- 获得金币
    elseif value >0 and type == ATTR_TYPE.curCoin then
        if reasonTypeOne == ATTR_CHANGE_REASON_TYPE.DROP_MONSTER
            or reasonTypeOne == ATTR_CHANGE_REASON_TYPE.DROP_BOX then

            data.reason = attrType.ADD_COIN
        end        
    -- 获得经验
    elseif value >0 and type == ATTR_TYPE.curLVExp then
        data.reason = attrType.ADD_EXP
    end
    -- TODO 这里感觉不用判断是否在战斗中
    -- if wasBattleMaster then
        -- 伤害类
        -- 处理屏蔽逻辑 add by zp 2018-4-19 策划孙雪龙确定数值为0 不弹伤害表现
        if type == ATTR_TYPE.curHp and value ~= 0 then
            if(reasonTypeTwo[ATTR_CHANGE_STYLE.CRIT]) then
                if(reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_TRUE) then 
                    data.reason = attrType.DAMAGE_TRUE_CRIT
                elseif (reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_PHYSICAL) then 
                    data.reason = attrType.DAMAGE_PHYSICAL_CRIT
                elseif (reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_MAGIC) then 
                    data.reason = attrType.DAMAGE_MAGIC_CRIT
                elseif (reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_ELEMENTAL) then 
                    data.reason = attrType.DAMAGE_ELEMENTAL
                end
            else
                local num = 0
                for _,v in pairs(reasonTypeTwo) do
                    num = num + 1
                end

                if(num == 0) then
                    if(reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_TRUE) then 
                        data.reason = attrType.DAMAGE_TRUE
                    elseif (reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_PHYSICAL) then 
                        data.reason = attrType.DAMAGE_PHYSICAL
                    elseif (reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_MAGIC) then 
                        data.reason = attrType.DAMAGE_MAGIC
                    elseif (reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_ELEMENTAL) then 
                        data.reason = attrType.DAMAGE_ELEMENTAL
                    elseif (reasonTypeThree == EFFECTED_REASON_TYPE.EDAMAGE_DIRECTSUBTRACTION) then 
                        data.reason = attrType.DAMAGE_PHYSICAL
                    end
                end
            end 
        end

        -- 格挡
        if reasonTypeTwo[ATTR_CHANGE_STYLE.BLOCK] ~= nil then
            local oneData = {}
            oneData.value = value
            oneData.type = type
            oneData.reason = attrType.DAMAGE_BLOCK
            table.insert(allData,oneData)
        end

        -- 吸收
        if reasonTypeTwo[ATTR_CHANGE_STYLE.ABSORPTION] ~= nil then
            local oneData = {}
            oneData.value = value
            oneData.type = type
            oneData.reason = attrType.DAMAGE_ABSORB
            table.insert(allData,oneData)
        end
    -- end

    if not data.reason then
        data = nil
    end 

    if DEBUG_ATTR then
        if data then
            print("ShareMachine:_handleOneAttrChange  data.value,data.type,data.reason,wasBattleMaster =",data.value,data.type,data.reason,wasBattleMaster)
        end
    end

    if data then
        table.insert(allData,data)
    end
end

-- 获取角色的所有buffer行为
function ShareMachine:_getBufferActionList(role)
    local foundActionList = nil

    local allBufferActionList = self:getActionListByTrackIndex(TRACKS_INDEX.BUFFER)
    if (allBufferActionList) then
        for i = 1, #allBufferActionList do
            local bufferAction = allBufferActionList[i]
            if (bufferAction:getBufferTarget() == role) then
                if (not foundActionList) then
                    foundActionList = {}
                end
                table.insert(foundActionList, bufferAction)
            end
        end
    end
    return foundActionList
end

-- 移除所有buffer
function ShareMachine:_clearAllBufferForRole(role)
    local bufferActionList = self:_getBufferActionList(role)
    if (bufferActionList) then
        for i = 1, #bufferActionList do
            local bufferAction = bufferActionList[i]
            bufferAction:stop()
        end
    end
end

-- 添加触发掉落记录
function ShareMachine:_addDropTrigger(model)
    if self._triggerModelArr == nil then
        self._triggerModelArr = {}
    end

    if model then
        if DEBUG then
            print("ShareMachine:_addDropTrigger  spriteID=",model:getSpriteID())
        end
        self._triggerModelArr[model:getSpriteID()] = model
    end
end

-- 添加触发的坐标
function ShareMachine:_addCoordTrigger(coord)
    if self._triggerCoordArr == nil then
        self._triggerCoordArr = {}
    end

    if coord then
        if DEBUG then
            print("ShareMachine:_addCoordTrigger  x,y=",coord.x,coord.y)
        end
        table.insert(self._triggerCoordArr,coord)
    end
end

-- 移除掉落触发记录
function ShareMachine:_removeDropTrigger(sourceSpriteID)
    if DEBUG then
        print("ShareMachine:_removeDropTrigger  spriteID=",sourceSpriteID)
    end
    local model = self._triggerModelArr[sourceSpriteID]
    if model then
        -- 过滤掉前面的怪物
        if model:getCategory() == Category.ROLE and model:getType() ==  RoleType.Monster then
            for k,target in pairs(self._triggerModelArr) do
                if target:getCategory() == Category.ROLE and target:getType() ==  RoleType.Monster then   
                    self._triggerModelArr[k] = nil
                end
            end 
        end

        self._triggerModelArr[sourceSpriteID] = nil
    else
        print("ShareMachine:_removeDropTrigger ",sourceSpriteID)
    end
end

-- 移除触发坐标数据
function ShareMachine:_removeDropCoordTrigger(coord) 
    if coord then
        for k,curCoord in ipairs(self._triggerCoordArr) do
            if curCoord.x == coord.x and curCoord.y == coord.y then
                table.remove(self._triggerCoordArr,k)
                return true
            end
        end
    end

    return false
end

-- 获取掉落模型对象
function ShareMachine:_getDropModel(sourceSpriteID)
    return self._triggerModelArr[sourceSpriteID]
end

-- 判断该对象是否为自己触发
function ShareMachine:_judgeOpenWithSelf(sourceSpriteID)
    if self._triggerModelArr[sourceSpriteID] ~= nil then

        return true
    end

    return false
end

-- 注册监听事件
function ShareMachine:registerListener()
    --晃动
    Avalon.MessageCenter:bind(AvalonMessage.MC_RENDERER_PLOT_NOTICE, self, self.rendererPlotNotice)
    Avalon.MessageCenter:bind(AvalonMessage.MC_DECORATION_HANDLE, self, self.handleDecoration)
end


-- 注销监听事件
function ShareMachine:unRegisterListener()
    --晃动
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RENDERER_PLOT_NOTICE, self, self.rendererPlotNotice)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DECORATION_HANDLE, self, self.handleDecoration)
end

function ShareMachine:rendererPlotNotice(plotName)
    print("ShareMachine:rendererPlotNotice 1", plotName)
    if(plotName == "boss_start_enter_scene") then
        --  BOSS 出场第一帧
        local targetArr = self._model:getNpcsForTemplateID(10307010)
        if(targetArr and #targetArr > 0) then
            local target = targetArr[1]
            local animationNames = {{"begin2", false}, {"idle_lock", true}}
            print("ShareMachine boss_start_enter_scene", animationNames)
            local command = Command.RendererCommand:create(true)
            command:initRoleRunAnimations(target:getId(), animationNames)
            self:pushCommand(command)
        end
    elseif (plotName == "boss_start_dead") then
        -- BOSS 死亡第一帧
        local targetArr = self._model:getNpcsForTemplateID(10307010)
        if(targetArr and #targetArr > 0) then
            local bossLevel = self._model:getMapData().number
            if(not TeamDataManager:hasTeam() and bossLevel == 8 and self._preDistortedSpaceUnlockType == false) then
            -- if(bossLevel == 8) then 
                local target = targetArr[1]
                local animationNames = {}
                animationNames = {{"dead", false}, {"begin_eye", false}, {"idle_eye", true}}
                print("ShareMachine boss_start_dead", animationNames)
                local command = Command.RendererCommand:create(true)
                command:initRoleRunAnimations(target:getId(), animationNames)
                self:pushCommand(command)
            end
        end
    elseif (plotName == "trigger_gate_dead_end") then 
        -- boss 大门把boss吸回去后最后一帧处理
        -- 沙之眼的boss 第一次死亡触发和门联动效果
        local bossLevel = self._model:getMapData().number
        if(not TeamDataManager:hasTeam() and bossLevel == 8 and self._preDistortedSpaceUnlockType == false) then
        -- if(bossLevel == 8) then 
            print("MC_UI_SHOW_NPC_DIALOG", 100301)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, 100301)
            local master = self._model:getMaster()
            if master then
                self:_fsmWaiting(master, WaitingType.WAITING_NORMAL, nil, master)
            end
        end
    -- 沙之眼对话框中途完成，需要联动眼睛了
    elseif (plotName == "map8_trigger_dialog_half") then 
        local targetArr = self._model:getNpcsForTemplateID(10307010)
        if(targetArr and #targetArr > 0) then
            local bossLevel = self._model:getMapData().number
            if(bossLevel == 8) then 
                local target = targetArr[1]
                local animationNames = {}
                animationNames = {{"trigger_eye", false}, {"idle_eye", true}}
                print("ShareMachine map8_trigger_dialog_half", animationNames)
                local command = Command.RendererCommand:create(true)
                command:initRoleRunAnimations(target:getId(), animationNames)
                self:pushCommand(command)
            end
        end      
    elseif (plotName == "map8_trigger_dialog_end") then 
        local targetArr = self._model:getNpcsForTemplateID(10307010)
        if(targetArr and #targetArr > 0) then
            local bossLevel = self._model:getMapData().number
            if(bossLevel == 8) then 
                local target = targetArr[1]
                local animationNames = {}
                animationNames = {{"open1_eye", false}, {"end", true}}
                print("ShareMachine map8_trigger_dialog_end", animationNames)
                local command = Command.RendererCommand:create(true)
                command:initRoleRunAnimations(target:getId(), animationNames)
                self:pushCommand(command)

                local master = self._model:getMaster()
                if master then
                    self:_fsmIdle(master, master:getCoord(), true)
                end
            end
        end      
    end
end

--[[

    animationNames:动画名字 eg:{{"idle", false},{"end", true}}
]]
function ShareMachine:handleDecoration(spineName, coordX, coordY, animationNames)
    -- print("ShareMachine:handleDecoration", spineName, coordX, coordY, animationNames)
    if(spineName == nil or coordX == nil or coordY == nil or animationNames == nil) then 
        return
    end

    loop = loop or false
    local machine = MachineManager:getInstance():getMachine()
    if(machine and machine._view and machine._view._map) then
        local _map = machine._view._map
        if(_map) then
            local _decoration = _map:getDecoration(spineName, coordX, coordY)
            -- print("ShareMachine:handleDecoration 1")
            if _decoration then
                -- print("ShareMachine:handleDecoration 2")
                if(animationNames) then 
                    for k,v in ipairs(animationNames) do 
                        -- print("ShareMachine:handleDecoration", v)
                        if(k == 1) then 
                            _decoration:runAnim(v[1], v[2])
                        else 
                            _decoration:addAnim(v[1], v[2])
                        end
                    end
                end
            end
        end
    end
end
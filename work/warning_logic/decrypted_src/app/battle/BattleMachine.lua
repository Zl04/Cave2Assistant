-- NewBattleMachine.lua
-- Author:zp
-- 2017年4月13日
-- Using:战斗引擎

require "app.machine.ShareMachine"
require "app.machine.ShareModel"
require "app.machine.ShareView"
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
require "app.action.npc.TriggerNPCOpenAction"
require "app.action.buffer.BufferAction"
require "app.action.effect.EffectAction"
require "app.action.aircraft.BulletAction"
require "app.action.aircraft.GetGoodsAction"
require "app.action.skill.NormalAttackAction"
require "app.action.skill.SkillAction"
require "app.action.function.RoleZorderAction"
require "app.action.function.RoleLevelUpAction"
require "app.action.fsm.DeadStateAction"
-- 游戏模型
require "app.object.role.Hero"
require "app.object.role.Monster"
require "app.object.skill.Skill"
require "app.object.effect.Effect"
require "app.object.buffer.Buffer"
require "app.object.group.BattleField"
require "app.object.aircraft.Bullet"
require "app.object.aircraft.GetGoods"
require "app.object.npc.TriggerNpc"
require "app.object.goods.Prop"
require "app.object.goods.Material"
require "app.object.goods.Equipment"
-- 渲染器
require "app.renderer.HeroRenderer"
require "app.renderer.MonsterRenderer"
require "app.renderer.BossRenderer"
require "app.renderer.BossNewsRenderer"
require "app.renderer.BulletRenderer"
require "app.renderer.GoodsRenderer"
require "app.renderer.TriggerNPCRenderer"
require "app.renderer.FunctionNPCRenderer"
require "app.renderer.FunctionNPCNewSceneRenderer"
require "app.renderer.TriggerNPC.ActorNpcRenderer"
require "app.renderer.component.AttributeComponent"
require "app.renderer.TriggerNPC.TrapNPCRenderer"
require "app.renderer.TriggerNPC.GateNPCRenderer"
require "app.renderer.TriggerNPC.CollectRender"
require "app.renderer.TriggerNPC.TransDoorNpcRendere"
require "app.renderer.TriggerNPC.TransPointNpcRender"
require "app.renderer.TriggerNPC.MazeFlagRenderer"
-- 引擎的数据模型和视图
require "app.battle.BattleModel"
require "app.battle.BattleView"
-- 添加工具类
require "app.utils.ToolsUtil"

-- 地图
-- local MapDefine = require "app.mapkit.MapDefine"
-- local MapDataManager = require "app.mapkit.model.MapDataManager"
-- local SceneManager = require("app.game.SceneManager")
-- local MachineManager = require("app.game.MachineManager")
Battle = Battle or {}

local Machine = class("NewBattleMachine", Machine.ShareMachine)
Battle.Machine = Machine

require "app.battle.BattleMachineCommon"
require "app.battle.BattleMachineBattleCmd"
require "app.battle.BattleMachineControlCmd"

-- private:
local DEBUG = false

--处理加载场景消息
function Machine:_onShowMapCompleteHandler()
    print("Battle Machine _onShowMapCompleteHandler: create map view complete.")
    -- self._view:addTouchMapHandler(self, Machine.onMapTouchHandler)
    local roleMap = self._model:getRoleMap()
    if (roleMap) then
        for id, role in pairs(roleMap) do
            self._view:addView(role)
        end
    end
end

-- 构造函数
function Machine:ctor()
    Machine.super.ctor(self)
end

-- 添加进入战斗状态的action
function Machine:addEnterBattleAction(target, attackTarget)
    local battleStateAction = nil

    if (target) then
        local state = target:getState();
        if (state == FSMState.IDLE or
            state == FSMState.MOVE) then
            battleStateAction = Action.BattleStateAction:create(true)
            battleStateAction:init(target, attackTarget)
            self:setAction(battleStateAction)
        elseif (state == FSMState.BATTLE) then
            -- TODO
        else
            assert(false, "[ERROR] [Battle Machine] state is invalid.")
        end
    end
    return battleStateAction
end

-- public:
-- 初始化
function Machine:init(viewNode)
    -- TODO 切换需要修改名字  NewBattleModel  -》BattleModel
    local battleModel = Battle.NewBattleModel:create()
    battleModel:init()

    local battleView = nil
    if (viewNode) then
        -- TODO 切换需要修改名字  NewBattleModel  -》BattleModel
        battleView = Battle.NewBattleView:create()
        battleView:init(battleModel, viewNode)
    end

    Machine.super.init(self, battleModel, battleView)

    self._triggerModelArr = {}
    self._triggerCoordArr = {}

    self._clickMonster = false
end

-- 点击坐标转换成地图坐标
function Machine:convertTouchPositionToCoord(touchPosition)
    local coordX = 0
    local coordY = 0
    if (self._view) then
        coordX, coordY = self._view:convertPositionToCoord(touchPosition)
    end
    return coordX, coordY
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

-- 处理命令
function Machine:executeCommand(command)
    -- print("Machine:executeCommand")
    local commandCategory = command.category
    
    if (commandCategory == CommandCategory.CONTROL) then
        return self:onExecuteControlCommand(command)
    elseif (commandCategory == CommandCategory.BATTLE) then
        return self:onExecuteBattleCommand(command)
    elseif (commandCategory == CommandCategory.GENERATION) then
        return self:_onExecuteGenerationCommand(command)
    else
        assert(false, string.format("[ERROR] Battle machine _onExecuteCommand: command category %d is invalid.", commandCategory))
    end
    return false
end

function Machine:judgeInSameBattleField(spriteID, targetSpriteID)
    if(self._model) then
        return self._model:judgeInSameBattleField(spriteID, targetSpriteID)
    end

    return false
end

-- 获取角色的战斗行为
function Machine:_getBattleAction(role)
    local actionList = self:getActionListByTrackIndexAndEntryID(GameTracksIndex.FSM, role:getId())
    if (actionList) then
        for i = 1, #actionList do
            local action = actionList[i]
            if (action:getFSMState() == FSMState.BATTLE) then
                return action
            end
        end
    end
    return nil
end

-- 添加触发掉落记录
function Machine:_addDropTrigger(model)
    if self._triggerModelArr == nil then
        self._triggerModelArr = {}
    end

    if model then
        if DEBUG then
            print("Machine:_addDropTrigger  spriteID=",model:getSpriteID())
        end
        self._triggerModelArr[model:getSpriteID()] = model
    end
end

-- 添加触发的坐标
function Machine:_addCoordTrigger(coord)
    if self._triggerCoordArr == nil then
        self._triggerCoordArr = {}
    end

    if coord then
        if DEBUG then
            print("Machine:_addCoordTrigger  x,y=",coord.x,coord.y)
        end
        table.insert(self._triggerCoordArr,coord)
    end
end

-- 移除掉落触发记录
function Machine:_removeDropTrigger(sourceSpriteID)
    if DEBUG then
        print("Machine:_removeDropTrigger  spriteID=",sourceSpriteID)
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
        print("Machine:_removeDropTrigger ",sourceSpriteID)
    end
end

-- 移除触发坐标数据
function Machine:_removeDropCoordTrigger(coord) 
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
function Machine:_getDropModel(sourceSpriteID)
    return self._triggerModelArr[sourceSpriteID]
end

-- 判断该对象是否为自己触发
function Machine:_judgeOpenWithSelf(sourceSpriteID)
    if self._triggerModelArr[sourceSpriteID] ~= nil then

        return true
    end

    return false
end
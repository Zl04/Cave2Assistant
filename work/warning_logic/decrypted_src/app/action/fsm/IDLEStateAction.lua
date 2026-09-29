--[[
    状态机行为：闲置状态
]]--

require "app.action.Action"
require "app.pool.Pool"

local MapDataManager = require "app.mapkit.model.MapDataManager"

Action = Action or {}

local IDLEStateAction = class("IDLEStateAction", Action.Base)
Action.IDLEStateAction = IDLEStateAction

-- private:
-- 对象池
local IDLEStateActionPool = nil
local DEBUG = false

-- public:
-- 创建对象
function IDLEStateAction:create(reused, ...)
    if (reused) then
        if (not IDLEStateActionPool) then
            IDLEStateActionPool = Pool.Pool:create(IDLEStateAction)
        end
        return IDLEStateActionPool:applyObject()
    else
        return IDLEStateAction.new(...)
    end
end

-- 构造函数
function IDLEStateAction:ctor()
    IDLEStateAction.super.ctor(self, ActionType.FSM_IDLE)
    
    self._coord = Geome.Coord:create(0, 0, 0)
    self._battleMachine = nil
end

-- 模版函数：销毁
function IDLEStateAction:dtor()
    IDLEStateAction.super.dtor(self)

    self._coord = nil
    self._battleMachine = nil
end

-- 初始化
function IDLEStateAction:init(target, coord, battleMachine)
    IDLEStateAction.super.init(self, target)

    self._coord = coord
    self._battleMachine = battleMachine
end

-- 清理
function IDLEStateAction:clear()
    IDLEStateAction.super.clear(self)

    self._coord = nil
    self._battleMachine = nil
end

-- 模版函数：action开始
function IDLEStateAction:onStart()
    if (self._coord ~= nil) then
        if(DEBUG) then
            print("IDLEStateAction:onStart ", self._coord.x, self._coord.y)
        end

        self._target:setCoord(self._coord.x, self._coord.y)

        MapDataManager:getInstance():addRole(self._battleMachine._model._mapData,Avalon.MathUtil:getInt(self._coord.x),Avalon.MathUtil:getInt(self._coord.y),self._target:getData())

        if(self._target:getCategory() == Category.ROLE and self._target:getType() == RoleType.Hero) then 
            -- 发送移动消息
            Avalon.MessageCenter:notice(GameMessage.MC_ROLE_IDLE, self._coord, self._target:isMaster(), self._target:getSpriteID())
        end
    end

    --  刷新层级
    local battleCMD = Command.GenerationCommand:create(true)
    battleCMD:initForRoleZorder(self._target:getSpriteID(),true)
    self._battleMachine:executeCommand(battleCMD)

    -- 切换
    if (not self._target:switchState(FSMState.IDLE)) then

        return false
    end

    if(DEBUG) then
        print("IDLEStateAction:onStart 2", self._target:getCoord().x, self._target:getCoord().y)
    end
    
    GameManager:notifyRoleFSMChange(self._target:getData())


    return true
end

-- 模版函数：action结束
function IDLEStateAction:onEnd()
    -- 这里还是有逻辑上面的问题需要做处理。
    if(self._target and self._target:getIsDead() == false) then
        if(self._target:getCategory() == Category.ROLE and self._target:getType() == RoleType.Hero) then
            local coord = self._target:getCoord()
            if (coord) then
                local updatePositionCommand = Command.RendererCommand:create(true)
                updatePositionCommand:initUpdatePositionCommand(self._target:getId(), coord, self._target:isMaster())
                self._battleMachine:pushCommand(updatePositionCommand)
            end

            local pet = self._target:getFightPet()
            for k, v in pairs(pet) do
                if v and v:getState() == FSMState.BATTLE then
                    local coord = v:getCoord()
                    if (coord) then
                        local action = Action.IDLEStateAction:create(true)
                        action:init(v, coord, self._battleMachine)
                        self._battleMachine:setAction(action)
                    end
                end
            end
            
        end 
    
        local updateAnimationCommand = Command.RendererCommand:create(true)
        updateAnimationCommand:initUpdateAnimationCommand(self._target:getId(), CommandAnimationType.IDLE)
        self._battleMachine:pushCommand(updateAnimationCommand)
    else
        -- 这里过滤掉死亡的特殊处理
        -- print("IDLEStateAction:onEnd  isDead  spriteID=",self._target:getSpriteID())
        -- print("DeadStateAction:onStart  onEnd")
    end
end

function IDLEStateAction:onFail()
    
end

-- 获取状态
function IDLEStateAction:getFSMState()
    return FSMState.IDLE
end
--[[
    子弹的行为
]]--

require "app.action.Action"
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
Action = Action or {}

local BulletAction = class("BulletAction", Action.Base)
Action.BulletAction = BulletAction

local computeSpeedComp2 = Geome.computeSpeedComp2

-- private:
local DEBUG = false

-- 构造函数
function BulletAction:ctor()
    BulletAction.super.ctor(self, ActionType.AIRCRAFT_BULLET)

    self._bulletFromTarget = nil
    self._bulletToTarget = nil
    self._bulletFromMount = nil
    self._bulletToMount = nil
    self._flyTime = 0

    self._flySpeedX = 0
    self._flySpeedY = 0
    self._flySpeedZ = 0
end

-- 模版函数：销毁
function BulletAction:dtor()
    BulletAction.super.dtor(self)

    self._bulletFromTarget = nil
    self._bulletToTarget = nil
    self._bulletFromMount = nil
    self._bulletToMount = nil
end

-- public:
-- 创建对象
local BulletActionPool = nil
function BulletAction:create(reused, ...)
    if (reused) then
        if (not BulletActionPool) then
            BulletActionPool = Pool.Pool:create(BulletAction)
        end
        return BulletActionPool:applyObject()
    else
        return BulletAction.new(...)
    end
end

-- 初始化
function BulletAction:init(bullet, bulletFromTarget, bulletFromMount, bulletToTarget, bulletToMount)
    BulletAction.super.init(self, bullet)

    self._bulletFromTarget = bulletFromTarget
    self._bulletToTarget = bulletToTarget
    self._bulletFromMount = bulletFromMount
    self._bulletToMount = bulletToMount
    self._flyTime = bullet:getFlyTime()
end

-- 清理
function BulletAction:clear()
    BulletAction.super.clear(self)

    self._bulletFromTarget = nil
    self._bulletToTarget = nil
    self._bulletFromMount = nil
    self._bulletToMount = nil
    self._flyTime = 0

    self._flySpeedX = 0
    self._flySpeedY = 0
    self._flySpeedZ = 0
end

-- 模版函数：action开始
function BulletAction:onStart()
    local bullet = self._target
    local bulletFromTarget = self._bulletFromTarget
    local bulletToTarget = self._bulletToTarget

    if (bullet and bulletFromTarget and bulletToTarget) then
        if(DEBUG) then
            print(string.format("BulletAction onStart: bullet (id:%d type:%d) is starting to fly.", bullet:getId(), bullet:getType()))
        end

        self:forceUpdate()

        -- 计算飞行速度
        self._flySpeedX, self._flySpeedY, self._flySpeedZ = computeSpeedComp2(
            bulletFromTarget:getBattleCoord(), 
            bulletToTarget:getBattleCoord(), 
            self._flyTime
        )
        -- 设置子弹的位置
        local coord = self._target:getCoord()
        coord:setCoord(bulletFromTarget:getBattleCoord())

        -- 渲染子弹特效的消息
        local bulletStateCommand = Command.RendererCommand:create(true)
        bulletStateCommand:initBulletStateCommand(
            bullet:getId(), 
            bulletFromTarget:getId(), self._bulletFromMount, 
            bulletToTarget:getId(), self._bulletToMount, 
            self._flyTime
        )
        SceneManager:getInstance():pushCommand(bulletStateCommand)
        -- 更新子弹的z序
        MachineManager:getInstance():pushZOrderRendererCommand(bullet, coord, 1)

        if (DEBUG) then
            local srcCoord = self._bulletFromTarget:getCoord()
            local dstCoord = self._bulletToTarget:getCoord()
            print(string.format("BulletAction onStart: bullet is starting to fly from (%f,%f,%f) to (%f,%f,%f), fly time:%f.", srcCoord.x, srcCoord.y, srcCoord.z, dstCoord.x, dstCoord.y, dstCoord.z, self._flyTime))
        end

        return true
    else
        if(DEBUG) then
            print(string.format("BulletAction onStart: bullet (id:%d type:%d) is fail to fly.", bullet:getId(), bullet:getType()))
        end

        return false
    end
end

-- action更新
function BulletAction:onUpdate(dt)
    if (self._currentTime >= self._flyTime) then
        return true
    end
    return false
end

-- 模版函数：action结束
function BulletAction:onEnd()
    local bullet = self._target
    
    if(DEBUG) then
        print(string.format("BulletAction onEnd: bullet (id:%d type:%d) fly complete, and cost %f.", bullet:getId(), bullet:getType(), self._currentTime))
    end

    local coord = bullet:getCoord()
    coord:setCoord(self._bulletToTarget:getCoord())
    -- 更新子弹的z序
    MachineManager:getInstance():pushZOrderRendererCommand(bullet, coord, 1)
  
    -- 移除模型
    MachineManager:getInstance():pushRemoveModelCommand(bullet:getId(), false)
end
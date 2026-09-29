--[[
    游戏中的角色对象：英雄，怪物
]]--

require "app.object.GameModel"

Model = Model or {}

local Role = class("Role", Model.Base)
Model.Role = Role

local computeSpeedComp = Geome.computeSpeedComp
local computeMoveDuration = Geome.computeMoveDuration
local reverseDirection = Geome.reverseDirection
local SPEED_UNIT = 1000

-- private:
-- 构造函数
function Role:ctor(type)
    Role.super.ctor(self, Category.ROLE, type)

    -- 角色数据
    self._roleData = nil
    -- 角色id
    self._spriteID = 0
    -- 普攻
    self._normalAttackSkill = nil
    -- 技能列表
    self._skillMap = {}
    -- 生效的buffer
    self._activeBufferList = {}
    -- 角色战斗的位置
    self._battleCoord = Geome.Coord:create(0, 0, 0)
    -- 角色的默认尺寸
    self._size = {[1] = 1, [2] = 1}
end

-- 析构函数
function Role:dtor()
    -- print("Role dtor: destroy the role, id:%d, sprite id:%d.", self._id, self._spriteID)

    Role.super.dtor(self)

    self._roleData = nil
    
    for skillID, skill in pairs(self._skillMap) do
        skill:destroy()
    end
    self._skillMap = nil
    self._normalAttackSkill = nil

    local bufferList = self._activeBufferList
    for i = 1, #bufferList do
        local buffer = bufferList[i]
        buffer:destroy()
    end
    self._activeBufferList = nil

    self._battleCoord = nil
end

-- public:
-- 初始化
function Role:init(data, fsm, geometric)
    Role.super.init(self, fsm, geometric)

    self._roleData = data
    -- 设置同步服务器spriteID
    if (data.spriteID) then
        self._spriteID = data.spriteID
    end

    -- 角色待机
    self:idle()
end

-- 清理
function Role:clear()
    print("Role clear: clear the role, id:%d, sprite id:%d.", self._id, self._spriteID)

    Role.super.clear(self)

    self._roleData = nil
    self._spriteID = 0
    if (self._normalAttackSkill) then
        self._normalAttackSkill:destroy()
        self._normalAttackSkill = nil
    end
    for skillID, skill in pairs(self._skillMap) do
        skill:destroy()
        self._skillMap[skillID] = nil
    end

    local bufferList = self._activeBufferList
    for i = 1, #bufferList do
        local buffer = bufferList[i]
        buffer:destroy()
        bufferList[i] = nil
    end

    self._battleCoord:reset()
end

-- 设置为待机状态
function Role:idle()
    local success = self:switchState(FSMState.IDLE)
    if (success) then
        if (self._renderer) then 
            self._renderer:idle()
        end 
    end
end

-- 获取角色数据
function Role:getData()
    return self._roleData
end

-- 获取角色数据
function Role:getRoleData()
    return self._roleData
end

-- 获取服务器同步的精灵ID
function Role:getSpriteID()
    return self._spriteID
end

-- 获取普攻技能
function Role:getNormalAttackSkill()
    return self._normalAttackSkill
end

-- 添加普攻技能
function Role:setNormalAttackSkill(skill)
    if (self._normalAttackSkill) then
        self._normalAttackSkill:destroy()
        self._normalAttackSkill = nil
    end
    self._normalAttackSkill = skill
end

-- 获取技能模型
function Role:getSkillById(skillID)
    if (self._normalAttackSkill and self._normalAttackSkill:getSkillID() == skillID) then
        return self._normalAttackSkill
    else
        local skill = self._skillMap[skillID]
        if not skill then
            local skillData = SkillDataManager:createSkillForSkillId(skillID)
            if(skillData) then 
                skill = Model.Skill:create(true)
                skill:init(skillData)
                self._skillMap[skillID] = skill
                if skill:getSkillType() == SkillType.NORMAL_ATTACK then
                    if(self._normalAttackSkill) then 
                        -- 这里必须先把前面缓存的数据清理掉
                        self._skillMap[self._normalAttackSkill:getSkillID()] = nil
                        -- 为了让战斗action 里面引用到最新的数据对象
                        self._normalAttackSkill:init(skillData)
                        skill = self._normalAttackSkill
                    else
                        self:setNormalAttackSkill(skill)
                    end
                end
            end
        else 
            if skill:getSkillType() == SkillType.NORMAL_ATTACK then
                if(self._normalAttackSkill) then 
                    -- 这里必须先把前面缓存的数据清理掉
                    self._skillMap[self._normalAttackSkill:getSkillID()] = nil
                    -- 为了让战斗action 里面引用到最新的数据对象
                    self._normalAttackSkill:init(skill:getSkillData())
                else
                    self:setNormalAttackSkill(skill)
                end
            end
        end
        return skill
    end

    return nil
end

-- 获取当前血量
function Role:getHP()
    if(self._roleData) then
        return self._roleData.hp
    end

    return 1
end

-- 获取移动速度
function Role:getSpeed()
    if(self._roleData) then
        return self._roleData.moveSpeed / SPEED_UNIT
    end

    return 1000 / SPEED_UNIT
end

function Role:getMoveSpeed()
    if(self._roleData) then
        return self._roleData.moveSpeed
    end
    return 1000 
end

-- 获取三个方向分量上的移动速率
function Role:getSpeedComp(dstCoord)
    return computeSpeedComp(self:getCoord(), dstCoord, self:getSpeed())
end

-- 获取移动时间
function Role:getMoveDuration(dstCoord)
    return computeMoveDuration(self:getCoord(), dstCoord, self:getSpeed())
end

-- 反向
function Role:reverseDirection()
    local newDirection = reverseDirection(self:getDirection())
    self:setDirection(newDirection)
    return newDirection
end

-- 添加buffer
function Role:addBuffer(buffer)
    -- print(string.format("Role addBuffer: add the buffer, buffer id:%d, entity id:%d.", buffer:getBufferID(), buffer:getEntityID()))

    table.insert(self._activeBufferList, buffer)
    return true
end

-- 移除buffer
function Role:removeBuffer(buffer)
    -- print(string.format("Role removeBuffer: add the buffer, buffer id:%d, entity id:%d.", buffer:getBufferID(), buffer:getEntityID()))

    local found = false
    local bufferList = self._activeBufferList
    for i = 1, #bufferList do
        local existBuffer = bufferList[i]
        if (existBuffer == buffer) then
            existBuffer:destroy()
            table.remove(bufferList, i)
            found = true
            break
        end
    end
    assert(found, string.format("[ERROR] Role removeBuffer: no buffer (bufferID:%d entityID:%d) found.", buffer:getBufferID(), buffer:getEntityID()))
    return found
end
function Role:removeBufferByEntityID(entityID)
    -- print(string.format("Role removeBuffer: remove the buffer %d.", entityID))
    local found = false
    local bufferList = self._activeBufferList
    if(bufferList) then
        for i = 1, #bufferList do
            local existBuffer = bufferList[i]
            if (existBuffer:getEntityID() == entityID) then
                existBuffer:destroy()
                table.remove(bufferList, i)
                found = true
                break
            end
        end
    end
    -- assert(found, string.format("[ERROR] Role removeBufferByEntityID: no buffer (entityID:%d) found.", entityID))
    return found
end
function Role:removeAllBuffer()
    -- print(string.format("Role removeAllBuffer: remove all the buffer for role %d.", self._spriteID))
    
    local bufferList = self._activeBufferList
    if (bufferList) then
        local bufferCount = #bufferList
        for i = 1, bufferCount do
            local existBuffer = bufferList[i]
            existBuffer:destroy()

            bufferList[i] = nil
        end
        return true
    end
    return false
end

-- 判断角色是否为玩家自己
function Role:isMaster()
    if self._roleData and self._roleData.isMaster then
        return self._roleData.isMaster
    end
    
    return false
end

-- 战斗中的位置
function Role:setBattleCoord(battleCoord)
    if(self._battleCoord and battleCoord) then
        self._battleCoord:setCoord(battleCoord)
    end
end

-- 获取战斗中的坐标
function Role:getBattleCoord()
    return self._battleCoord
end

-- 设置是否死亡
function Role:setIsDead(isDead)
    if(self._roleData) then
        self._roleData:setIsDead(isDead)
    end
end

-- 获取是否已经死亡
function Role:getIsDead()
    if(self._roleData) then
        return self._roleData:getIsDead()
    end

    return true
end

-- 获取角色的站位尺寸
function Role:getOccupySize()
    return self._size
end

-- 打印信息
function Role:print()
    local roleTypeName = "Role"
    local type = self:getType()
    if (type == RoleType.Hero) then
        roleTypeName = "Hero"
    elseif (type == RoleType.Monster) then
        roleTypeName = "Monster"
    else
        assert(false)
    end

    print("------------------------")
    print(string.format("%s info:", roleTypeName))
    local coord = self:getCoord()
    print(string.format("id:%d  sprite id:%d  state:%d  coord:(%f,%f).", self:getId(), self:getSpriteID(), self:getState(), coord.x, coord.y))
    print("------------------------")
end

--重写状态机方法
-- 切换状态
function Role:switchState(state)
    if (self._fsm) then
        return self._fsm:switch(state)
    end
    return false
end
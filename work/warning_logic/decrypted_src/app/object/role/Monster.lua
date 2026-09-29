--[[
    怪物
]]--

require "app.object.role.Role"
require "app.object.fsm.MonsterFSM"
require "app.object.geometric.GeometricRect"

local MonsterType = PublicDefine.MonsterType

Model = Model or {}

local Monster = class("RoleMonster", Model.Role)
Model.Monster = Monster

-- private:
-- 构造函数
function Monster:ctor()
    Monster.super.ctor(self, RoleType.Monster)

    self._monsterData = nil
end

-- 析构函数
function Monster:dtor()
    Monster.super.dtor(self)

    self._monsterData = nil
end

 -- public:
 -- 创建对象
local MonsterPool = nil
function Monster:create(reused, ...)
    if (reused) then
        if (not MonsterPool) then
            MonsterPool = Pool.Pool:create(Monster)
        end
        return MonsterPool:applyObject()
    else
        return Monster.new(...)
    end
end

-- 初始化
function Monster:init(monsterData)
    if (monsterData) then
        local fsm = FSM.MonsterFSM:create(monsterData)
        fsm:init(self)
        local geometric = Geome.GeometricRect:create(monsterData)
        geometric:init(0, 0, 0, monsterData.width, monsterData.height, monsterData.direction)
        Monster.super.init(self, monsterData, fsm, geometric)
    else
        assert(false, "[ERROR] Monster init: monster data is nil.")
    end

    self._monsterData = monsterData
end

-- 获取装饰物对象id
function Monster:getDecorationId()
    if(self._monsterData) then
        return self._monsterData:getDecorationId()
    end

    return 0
end

-- 装饰物是否移除
function Monster:isToRemoveDecoration()
    if(self._monsterData) then
        return self._monsterData:isToRemoveDecoration()
    end

    return true
end

-- 自己是否移除
function Monster:isToRemoveSelf()
    -- 计算是否移除
    if(self._monsterData) then
        return self._monsterData:isToRemoveSelf()
    end

    return true
end

-- 获取品质
function Monster:getRare()
    if(self._monsterData) then
        return self._monsterData:getMonsterRare()
    end

    return MonsterType.Normal
end

-- 获取怪物类型
function Monster:getMonsterType()
    if(self._monsterData) then
        return self._monsterData:getMonsterType()
    end

    return PublicDefine.MonsterType.Normal
end

-- 是否小boss
function Monster:isSmallBoss()
    if(self._monsterData) then
        return self._monsterData:isSmallBoss()
    end

    return false
end

-- 是否为大boss
function Monster:isBigBoss()
    if(self._monsterData) then
        return self._monsterData:isBigBoss()
    end

    return false
end

-- 是否反转
function Monster:isTurnAround()
    if(self._monsterData) then
        return self._monsterData:isTurnAround()
    else 
        return true
    end
end

-- 是否激活
function Monster:getIsWake()
    if(self._monsterData) then
        return self._monsterData:getIsWake()
    else 
        return true
    end
end

-- 获取是否改变模板ID
function Monster:getIsChangeTemplateID()
    if(self._monsterData) then
        return self._monsterData:getIsChangeTemplateID()
    else 
        return false
    end
end

-- 设置是否改变模板ID的标志
function Monster:setIsChangeTemplateID(flag)
    if(self._monsterData) then
        self._monsterData:setIsChangeTemplateID(flag)
    end
end

-- 获取怪物站位尺寸
function Monster:getOccupySize()
    if(self._monsterData) then
        return self._monsterData:getOccupySize()
    end
    -- add by zp 给一个默认大小
    return {1,1}
end

-- 获取动画配置数据
function Monster:getAnimationData()
    if(self._monsterData) then
    local monsterData = self._monsterData
    return monsterData.skeleton, monsterData.atlas, monsterData.scale
    end

    return nil, nil, nil
end

-- 获取怪兽类型
function Monster:getMonsterSubType()
    if(self._monsterData) then
        return self._monsterData:getMonsterSubType(); 
    end 

    return 1
end

-- 判读是否为触发怪
function Monster:judgeNeedToTrigger()
    if(self._monsterData) then
        return self._monsterData:judgeNeedToTrigger()
    end

    return false
end

-- 获取怪兽是否触发
function Monster:getIsTrigger()
    if(self._monsterData) then
        return self._monsterData:getIsTrigger(); 
    end

    return true
end

--设置怪兽触发
function Monster:setIsTrigger(var)
    if(self._monsterData) then
        self._monsterData:setIsTrigger(var)
    end
end

function Monster:setTriggerNum(triggerNum)
    if(self._monsterData) then
        self._monsterData:setTriggerNum(triggerNum)
    end
end

function Monster:getIsPet()
    if(self._monsterData) then
        return self._monsterData:getIsPet()
    end
    return false
end

function Monster:getPetName()
    if(self._monsterData) then
        return self._monsterData:getPetName()
    end
    return ""
end

-- 判断是否变形
function Monster:isDeformation()
    if(self._monsterData) then
        return self._monsterData:isDeformation()
    end

    return false
end



-- 获取是否有英雄模式变形数据
function Monster:getIsNormalDeformation()
    if(self._monsterData) then
        return self._monsterData:getIsNormalDeformation()
    end

    return false
end

-- 获取是否有英雄模式变形数据
function Monster:getIsHeroDeformation()
    if(self._monsterData) then
        return self._monsterData:getIsHeroDeformation()
    end

    return false
end

-- 获取是否变身了
function Monster:getIsTransform()
    if(self._monsterData) then
        return self._monsterData:getIsTransform()
    end

    return false
end

-- 获取变形后的数据
function Monster:getDeformationData()
    if(self._monsterData) then
        return self._monsterData:getDeformationData()
    end

    return nil
end

-- 设置变形的数据  nil 代表清空变形效果
function Monster:setDeformationID(deformationID)
    if(self._monsterData) then
        self._monsterData:setDeformationID(deformationID)
    end
end

-- 设置英雄模式变形的数据
function Monster:setHeroDeformationID(deformationID)
    if(self._monsterData) then
        self._monsterData:setHeroDeformationID(deformationID)
    end
end

-- 获取怪物ID
function Monster:getMonsterID()
    if(self._monsterData) then 
        return self._monsterData:getTemplateID()
    end

    return 0
end

--重写状态机方法
-- 切换状态
function Monster:switchState(state)
    if (self._fsm) then
        --     IDLE = 1,       -- 待机状态
        -- MOVE = 2,       -- 移动状态
        -- BATTLE = 3,     -- 战斗状态
        -- DIE = 4,        -- 死亡状态
        -- REVIVE = 5,     -- 复活状态
        -- WAITING_FLOOR = 6,    -- 等待下楼状态
        -- WAITING = 7,    -- 等待状态
        -- print("  pet  state ============== ",state, self._roleData.looks)

        return self._fsm:switch(state)
    end
    return false
end
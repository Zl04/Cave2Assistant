--[[
    英雄
]]--

require "app.object.role.Role"
require "app.object.fsm.HeroFSM"
require "app.object.geometric.GeometricRect"
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
Model = Model or {}

local Pet = class("Pet", Model.Role)
Model.Pet = Pet

-- private:
-- 构造函数
function Pet:ctor()
    Pet.super.ctor(self, RoleType.Pet)
    if(self.master) then 
        self.master:setFightPet(nil)
    end
    self.master = nil
    self._roleData = nil
    self._preOrderCoord = nil
end

-- 析构函数
function Pet:dtor()
    Pet.super.dtor(self)

    self._roleData = nil
    self._preOrderCoord = nil
end

-- public:
 -- 创建对象
local PetPool = nil
function Pet:create(reused, ...)
    if (reused) then
        if (not PetPool) then
            PetPool = Pool.Pool:create(Pet)
        end
        return PetPool:applyObject()
    else
        return Pet.new(...)
    end
end

-- 初始化
function Pet:init(petData)
    local fsm = FSM.HeroFSM:create(petData)
    fsm:init(self)
    local geometric = Geome.GeometricRect:create(petData)
    geometric:init(0, 0, 0, petData.width, petData.height, petData.direction)
    Pet.super.init(self, petData, fsm, geometric)

end

-- 获取性别
function Pet:getSex()
    return self._roleData.sex
end

-- 获取名字
function Pet:getName()
    if self._roleData.nickName == nil or self._roleData.nickName == "" then
        return string.format("%d",self._roleData.spriteID)
    else
        return self._roleData:getNickName()
    end
end

-- 设置上次刷新层级坐标
function Pet:setPreOrderCoord(coord)
    if coord then
        if self._preOrderCoord == nil then
            self._preOrderCoord = Geome.Coord:create(0, 0, 0)
        end
        self._preOrderCoord:setCoord(coord)
    else
        self._preOrderCoord = nil
    end
end

-- 判断是否移动
function Pet:judegeToMove()
    if(self._roleData) then
        return self._roleData:judegeToMove()
    end

    return false
end

-- 设置是否处于逃跑状态
function Pet:setIsEscape(isEscape)
end

-- 获取是否处于逃跑中
function Pet:getIsEscape()
    if (self.master) then
        return self.master:getIsEscape()
    end

    return false
end

-- 获取上次刷新层级坐标
function Pet:getPreOrderCoord()
    return self._preOrderCoord
end

-- 获取幻境信息
function Pet:getDelusion()
    return self._roleData:getDelusion()
end

-- 获取动画配置数据
function Pet:getAnimationData()
    local skeletonFile, atlasFile, scale = self._roleData:getAnimationData()
    local sceneScale = self._roleData:getSceneScale()
    return skeletonFile, atlasFile, scale, sceneScale
end

-- 获取普攻技能
function Pet:getNormalAttackSkill()
    if (not self._normalAttackSkill) then
        self._normalAttackSkill = Model.Skill:create(true)
    end
    local normalAttackSkillData = SkillDataManager:getSkillDataForSkillIDFromPet(self._roleData, self._roleData:getBaseSkill())
    if (normalAttackSkillData) then
        self._normalAttackSkill:init(normalAttackSkillData)
    end
    return self._normalAttackSkill
end

-- 获取导师名字
function Pet:getMentorName()
    if (self._roleData) then
        return self._roleData.tutorName
    end
end

-- 设置导师名字
function Pet:setMentorName(s)
    if (self._roleData) then
        self._roleData.tutorName = s
    end
end

-- 获取PK
function Pet:getPK()
    if (self._roleData) then
        return self._roleData:getPK()
    end
end

function Pet:setMaster(master)
    self.master = master
end

function Pet:getMaster()
    return self.master
end

function Pet:getSpeed()
    return self.master:getSpeed()
end

function Pet:getMoveSpeed()
    return self.master:getMoveSpeed()
end

--重写状态机方法
-- 切换状态
function Pet:switchState(state)
    if (self._fsm) then
        --     IDLE = 1,       -- 待机状态
        -- MOVE = 2,       -- 移动状态
        -- BATTLE = 3,     -- 战斗状态
        -- DIE = 4,        -- 死亡状态
        -- REVIVE = 5,     -- 复活状态
        -- WAITING_FLOOR = 6,    -- 等待下楼状态
        -- WAITING = 7,    -- 等待状态
        -- print("  pet  state ============== ",state, self._roleData.looks)
        if not SceneManager:getInstance():isInPetPVP() then
            -- print("  爪子了!!!!  ",state)
            if state == FSMState.BATTLE or state == FSMState.DIE then
                --通知HeroRender在battleView中的行为变化(用户骑乘宠物表现)
                local ridingCMD = Command.RendererCommand:create(true)
                ridingCMD:initForTypeAndData(CommandType.RENDERER_PET_DOWN, self:getId(), {})
                SceneManager:getInstance():pushCommand(ridingCMD)
            elseif state == FSMState.IDLE or state == FSMState.MOVE then

                if self._roleData then
                    local isRiding = self._roleData:isRide()--MasterDataManager:getPetRidingState()
                    local masterSpID =  self._roleData:getMasterSpriteID()
                    local masterData = RoleDataManager:getMaster()
                    if masterData then
                        local heroMaterSpID = masterData:getSpriteID()
                        if masterSpID == heroMaterSpID then
                            isRiding = MasterDataManager:getPetRidingState()
                        end
                    end
                    
                    local data = {
                        isRiding = isRiding
                    }
                    if self._roleData and self._roleData.looks ~= 0 and self._roleData.looks ~= nil then
                        data.isRiding = false
                    end

                    -- if MachineManager:getInstance():getMachine() then
                    --     local model = MachineManager:getInstance():getMachine():getModel()
                    --     if model then
                    --         local heroRole = model:getRoleBySpriteID(masterSpID)
                    --         print(" pet  heroRole._fsm._state ===   ",heroRole._fsm._state,FSMState.DIE )
                    --         if heroRole and heroRole._fsm._state == FSMState.DIE then
                    --             data.isRiding = false
                    --         end
                    --     end
                    -- end

                    local ridingCMD = Command.RendererCommand:create(true)
                    ridingCMD:initForTypeAndData(CommandType.RENDERER_PET_RIDE, self:getId(), data)
                    SceneManager:getInstance():pushCommand(ridingCMD)
                end
            end
        end


        return self._fsm:switch(state)
    end
    return false
end
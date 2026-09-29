--[[
    英雄
]]--

require "app.object.role.Role"
require "app.object.fsm.HeroFSM"
require "app.object.geometric.GeometricRect"

local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")

Model = Model or {}

local Hero = class("RoleHero", Model.Role)
Model.Hero = Hero

-- private:
-- 构造函数
function Hero:ctor()
    Hero.super.ctor(self, RoleType.Hero)

    self._heroData = nil
    self._preOrderCoord = nil
    self.fightPet = {}
end

-- 析构函数
function Hero:dtor()
    Hero.super.dtor(self)

    self._heroData = nil
    self._preOrderCoord = nil
    self.fightPet = {}
end

-- public:
 -- 创建对象
local HeroPool = nil
function Hero:create(reused, ...)
    if (reused) then
        if (not HeroPool) then
            HeroPool = Pool.Pool:create(Hero)
        end
        return HeroPool:applyObject()
    else
        return Hero.new(...)
    end
end

-- 初始化
function Hero:init(heroData)
    local fsm = FSM.HeroFSM:create(heroData)
    fsm:init(self)
    local geometric = Geome.GeometricRect:create(heroData)
    geometric:init(0, 0, 0, heroData.width, heroData.height, heroData.direction)
    Hero.super.init(self, heroData, fsm, geometric)

    self._heroData = heroData
    -- print("Hero:init",self._heroData:getFaceDecodeID())
end

-- 获取性别
function Hero:getSex()
    -- print("Hero:getSex",self._heroData.sex)
    return self._heroData.sex
end

-- 获取脸部
function Hero:getFaceDecodeID()
    return self._heroData:getFaceDecodeID()
end

-- 获取称号ID
function Hero:getHeroTitleID()
    -- return self._heroData:getHeroTitleID()
    if self._heroData then
        return self._heroData:getHeroTitleID()
    end
end

-- 获取名字
function Hero:getName()
    if self._heroData.nickName == nil or self._heroData.nickName == "" then
        return string.format("%d",self._heroData.spriteID)
    else
        return self._heroData.nickName
    end
end

-- 设置上次刷新层级坐标
function Hero:setPreOrderCoord(coord)
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
function Hero:judegeToMove()
    if(self._heroData) then
        return self._heroData:judegeToMove()
    end

    return false
end

-- 设置是否处于逃跑状态
function Hero:setIsEscape(isEscape)
    if self._heroData then
        self._heroData:setIsEscape(isEscape)
    end
end

-- 获取是否处于逃跑中
function Hero:getIsEscape()
    if (self._heroData) then
        return self._heroData:getIsEscape()
    end

    return false
end

function Hero:setInfernoReviveNum(infernoReviveNum)
    if (self._heroData) then
        self._heroData:setInfernoReviveNum(infernoReviveNum)
    end
end

function Hero:setVoidRiftReviveNum(voidRiftReviveNum)
    if (self._heroData) then
        self._heroData:setVoidRiftReviveNum(voidRiftReviveNum)
    end
end

function Hero:setViKingReviveNum(viKingReviveNum)
    if (self._heroData) then
        self._heroData:setViKingReviveNum(viKingReviveNum)
    end
end

-- 获取上次刷新层级坐标
function Hero:getPreOrderCoord()
    return self._preOrderCoord
end

-- 获取幻境信息
function Hero:getDelusion()
    return self._heroData:getDelusion()
end

-- 获取动画配置数据
function Hero:getAnimationData()
    local heroData = self._heroData
    return heroData.skeleton, heroData.atlas, heroData.scale
end

-- 获取普攻技能
function Hero:getNormalAttackSkill()
    if (not self._normalAttackSkill) then
        self._normalAttackSkill = Model.Skill:create(true)
    end
    local normalAttackSkillData = SkillDataManager:getNormalSkillForPK(self._roleData:getPK())
    if (normalAttackSkillData) then
        self._normalAttackSkill:init(normalAttackSkillData)
    end
    return self._normalAttackSkill
end

-- 获取导师名字
function Hero:getMentorName()
    if (self._heroData) then
        return self._heroData.tutorName
    end
end

-- 设置导师名字
function Hero:setMentorName(s)
    if (self._heroData) then
        self._heroData.tutorName = s
    end
end

-- 获取PK
function Hero:getPK()
    if (self._heroData) then
        return self._heroData:getPK()
    end
end

function Hero:setFightPet(pet)
    -- dump(self.fightPet, "HerosetFightPet111")
    -- dump(pet, "HerosetFightPet1ss")
    -- dump(pet:getRoleData(), "HerosetFightPet2aaa")
    -- for k, v in pairs(self.fightPet) do
    --     print("fightPet123sd:", k, v.getRoleData)
    --     dump(v, "fightPet123")
        
    --     dump(v:getRoleData(), "fightPet123sd")
    --     if not v.getRoleData or v:getRoleData():getSiteId() == pet:getRoleData():getSiteId() then
    --         self.fightPet[k] = pet
    --         dump(self.fightPet, "fightPet22221")
    --         return
    --     end
    -- end
    
    -- table.insert(self.fightPet, pet)
    self.fightPet[pet:getRoleData():getSiteId()+1] = pet
end

function Hero:getFightPet()
    return self.fightPet
end

--兽栏下阵
function Hero:removeFightPet(data)
    
    for k, v in pairs(self.fightPet) do
        if v:getPK() == data:getPK() then
            -- table.remove(self.fightPet, k)
            self.fightPet[k] = nil
            break
        end
    end
end

function Hero:getCaptainPet()
    if self.fightPet then
        for _, v in ipairs(self.fightPet) do
            if v:getRoleData():getSiteId() == 0 then
                return v
            end
        end
    end
end

--重写状态机方法
-- 切换状态
function Hero:switchState(state)
    if (self._fsm) then
        --     IDLE = 1,       -- 待机状态
        -- MOVE = 2,       -- 移动状态
        -- BATTLE = 3,     -- 战斗状态
        -- DIE = 4,        -- 死亡状态
        -- REVIVE = 5,     -- 复活状态
        -- WAITING_FLOOR = 6,    -- 等待下楼状态
        -- WAITING = 7,    -- 等待状态
        
        -- print("  Hero  state ============== ",state)
        if not SceneManager:getInstance():isInPetPVP() then
            if state == FSMState.BATTLE or state == FSMState.DIE then
                --通知HeroRender在battleView中的行为变化(用户骑乘宠物表现)
                -- print("  死了死了  !!!!  ???  ",state)
                local ridingCMD = Command.RendererCommand:create(true)
                ridingCMD:initForTypeAndData(CommandType.RENDERER_HERO_DOWN, self:getId(), {})
                SceneManager:getInstance():pushCommand(ridingCMD)


                local petData = self._heroData:getCaptainPetData()
                if petData then
                    local model = MachineManager:getInstance():getMachine():getModel()
                    local petRole = model:getRoleBySpriteID(petData:getId())
                    -- print("!!!!!!!!!!!!!!!!!!! ",petData:getId())
                    if petRole then
                        -- print("!!!!!!!!!!!!!!!@@@@@!!!! ")
                        local petModelId = petRole:getId()
                        local ridingCMD = Command.RendererCommand:create(true)
                        ridingCMD:initForTypeAndData(CommandType.RENDERER_PET_FOLLOW, petModelId, {})
                        SceneManager:getInstance():pushCommand(ridingCMD)
                    end
                end

                --是否包含变身道具卡的buff数据
                -- local buffId = 31101614
                -- local hasEat = SkillDataManager:checkBuffIsExistBySproteID(self._heroData.spriteID,buffId)
                local monsterIdRange = ConfigManager:getGeneralForKey("monsterIdRange")
	            local arr = string.split(monsterIdRange, ",")
                local looks = self._heroData:getLooks()
                local hasEat = looks >= tonumber(arr[1]) and looks <= tonumber(arr[2])
                if hasEat then
                    local model = MachineManager:getInstance():getMachine():getModel()
                    local role = model:getRoleBySpriteID(self._heroData.spriteID)
                    if role then
                        local modelId = role:getId()
                        local ridingCMD = Command.RendererCommand:create(true)
                        ridingCMD:initForTypeAndData(CommandType.RENDERER_HERO_TRANSFORM_INTO_BATTLE, modelId, {})
                        SceneManager:getInstance():pushCommand(ridingCMD)
                    end
                end

            elseif state == FSMState.IDLE or state == FSMState.MOVE then

                if self._heroData then
                    local petData = self._heroData:getCaptainPetData()
                    if petData then
                        local isRiding = petData:isRide()--MasterDataManager:getPetRidingState()
                        if self._heroData.isMaster then
                            isRiding = MasterDataManager:getPetRidingState()
                        end
                        
                        local data = {
                            isRiding = isRiding,
                            petSiteId = petData:getSiteId()
                        }
                        local ridingCMD = Command.RendererCommand:create(true)
                        ridingCMD:initForTypeAndData(CommandType.RENDERER_HERO_RIDE, self:getId(), data)
                        SceneManager:getInstance():pushCommand(ridingCMD)
                    end

                    --是否包含变身道具卡的buff数据
                    -- local buffId = 31101614
                    -- local hasEat = SkillDataManager:checkBuffIsExistBySproteID(self._heroData.spriteID,buffId)
                    local monsterIdRange = ConfigManager:getGeneralForKey("monsterIdRange")
	                local arr = string.split(monsterIdRange, ",")
                    local looks = self._heroData:getLooks()
                    local hasEat = looks >= tonumber(arr[1]) and looks <= tonumber(arr[2])
                    if hasEat then
                        local model = MachineManager:getInstance():getMachine():getModel()
                        local role = model:getRoleBySpriteID(self._heroData.spriteID)
                        if role then
                            local modelId = role:getId()
                            local ridingCMD = Command.RendererCommand:create(true)
                            ridingCMD:initForTypeAndData(CommandType.RENDERER_HERO_TRANSFORM_LEAVE_BATTLE, modelId, {})
                            SceneManager:getInstance():pushCommand(ridingCMD)
                        end
                    end
                end
            end

            
        end


        return self._fsm:switch(state)
    end
    return false
end
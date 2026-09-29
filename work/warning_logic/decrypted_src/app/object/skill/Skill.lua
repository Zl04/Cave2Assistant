--[[
    技能
]]--

require "app.object.GameModel"
require "app.object.effect.Effect"
require "app.object.buffer.Buffer"

Model = Model or {}

local Skill = class("Skill", Model.Base)
Model.Skill = Skill

-- private:

-- public:
-- 创建对象
local SkillPool = nil
function Skill:create(reused, ...)
    if (reused) then
        if (not SkillPool) then
            SkillPool = Pool.Pool:create(Skill)
        end
        return SkillPool:applyObject()
    else
        return Skill.new(...)
    end
end

-- 构造函数
function Skill:ctor()
    Skill.super.ctor(self, Category.SKILL, 0)

    -- 配置id
    self._skillID = 0
    -- 类型
    self._skillType = SkillType.NONE
    -- 配置数据
    self._skillData = nil
    -- 技能状态
    self._skillState = SkillState.NONE
    -- 效果触发时间列表
    self._effectTimeList = {}
end

-- 析构函数
function Skill:dtor()
    Skill.super.dtor(self)

    self._effectTimeList = nil
end

-- 初始化
function Skill:init(skillData)
    assert(type(skillData) == "table", "[ERROR] Skill init: skillData is invalid.")

    Skill.super.init(self)

    self._skillID = skillData.ID
    self._skillType = skillData.type
    self._skillData = skillData
    self._skillState = SkillState.IDLE

    local timeList = self._skillData.effectTrigerTimeList
    for i = 1, #timeList do
        self._effectTimeList[i] = timeList[i] / TIME_UNIT
    end
end

-- 清理
function Skill:clear()
    self._skillID = 0
    self._skillType = SkillType.NONE
    self._skillData = nil
    self._skillState = SkillState.NONE

    for i = 1, #self._effectTimeList do
        self._effectTimeList[i] = nil
    end
end

-- 获取技能id
function Skill:getSkillID()
    return self._skillID
end

-- 获取技能类型
function Skill:getSkillType()
    return self._skillType
end

-- 获取数据
function Skill:getSkillData()
    return self._skillData
end

-- 获取技能状态
function Skill:getSkillState()
    return self._skillState
end

-- 设置技能状态
function Skill:switchState(newState)
    local success = false

    local currentState = self._skillState
    if (currentState ~= SkillState.NONE) then
        if (currentState == SkillState.IDLE and newState == SkillState.COOL_DOWN) then
            success = true
        elseif (currentState == SkillState.COOL_DOWN and newState == SkillState.IDLE) then
            success = true
        end
    end
    if (not success) then
        print(string.format("[WARNING] Skill setSkillState: fail to switch state from %d to %d.", currentState, newState))
    end

    return success
end

-- 是否可用
function Skill:isReady()
    return self._skillState == SkillState.IDLE
end

-- 获取技能释放时常
function Skill:getCastDurationForAnimation()
    if (self._skillData) then
        return self._skillData.castDuration / TIME_UNIT
    else
        return 0
    end
end

-- 是否有蓄力动作
function Skill:hasPrepareAction()
    if (self._skillData) then
        return self._skillData.spellPerf ~= nil
    else
        return false
    end
end

-- 获取技能蓄力或者呤唱时间
function Skill:getPrepareTime()
    if (self._skillData) then
        return self._skillData:getPrepareTime()
    else 
        return 0
    end
end

-- 获取蓄力或者呤唱的准备动画
function Skill:getPrepareAnim()
    if(self._skillData) then
        local spellPerf = self._skillData.spellPerf
        if (spellPerf) then
            return spellPerf.castAnimName[1]
        end
    end
    return nil
end

-- 是否有蓄力或者呤唱技能的特效
function Skill:hasPrepareFX()
    if(self._skillData) then
        local spellPerf = self._skillData.spellPerf
        if (spellPerf) then
            return spellPerf.castFxAnimName ~= ""
        end
    end

    return false
end

-- 获取蓄力或者呤唱技能时候的特效和挂载点
function Skill:getPrepareFXAnimAndMount()
    if(self._skillData) then
        local spellPerf = self._skillData.spellPerf
        if (spellPerf) then
            return spellPerf.castFxAnimName, spellPerf.castAnimMount
        end
    end 

    return nil, nil
end

-- 是否有释放动作
function Skill:hasReleaseAction()
    if(self._skillData) then
        return #self._skillData.castPerfList > 0
    end

    return false
end

-- 是否有收招动作
function Skill:hasFinishAction()
    return true
end

-- 获取释放技能的时间
function Skill:getReleaseTime()
    if(self._skillData) then
        return self._skillData.castDuration / TIME_UNIT
    else
        return 0 
    end
end

-- 呤唱产生特效的时间
function Skill:getPrepareFXTime()
    if(self._skillData) then
        local spellPref = self._skillData.spellPerf
        if (not spellPerf) then
            return 0
        end
        return spellPref.castFxTiming / TIME_UNIT
    else 
        return 0
    end
end

-- 释放产生特效的时间
function Skill:getReleaseFXTime()
    if(self._skillData) then
        local castPerf = self._skillData.castPerfList[1]
        if (not castPerf) then
            return 0
        end
        return castPerf.castFxTiming / TIME_UNIT
    end

    return 0
end

-- 获取释放动作列表
function Skill:getReleaseAnimList()
    if(self._skillData) then
        return self._skillData.castPerfList
    end

    return nil
end

-- 获取当前的释放动作
function Skill:getReleaseAnim()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    if(self._skillData) then
        local currentCastPerf = self._skillData.castPerfList[1]
        if (currentCastPerf) then
            return currentCastPerf.castAnimName[1]
        end
    end 
    return nil
end

-- 获取相关的刀光效果
function Skill:getReleaseWeaponAnim()
    if(self._skillData) then
        local currentCastPerf = self._skillData.castPerfList[1]
        if (currentCastPerf and currentCastPerf.weaponFxName) then
            return currentCastPerf.weaponFxName[1]
        end
    end

    return nil
end

function Skill:getNormalAnimation()
    local animationName = nil
    local weaponName = nil
    if(self._skillData and self._skillData.castPerfList) then
        local castPert = self._skillData.castPerfList[1]
        if(castPert and castPert.castAnimName) then
            local totalNum = #castPert.castAnimName

            local randNum = 1
            -- 随机获取攻击动画
            randNum = math.random(100)%totalNum + 1
            if(randNum > totalNum) then
                randNum = totalNum
            elseif (randNum<=0) then
                randNum = 1
            end
            
            animationName = castPert.castAnimName[randNum]

            if (castPert.weaponFxName and castPert.weaponFxName[randNum]) then
                weaponName = castPert.weaponFxName[randNum]
            end
            -- print("Skill:getNormalAnimation ", randNum, animationName, weaponName)
        end
    end

    return animationName, weaponName
end

-- 是否有释放技能的特效
function Skill:hasReleaseFX()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    if(self._skillData) then
        local currentCastPerf = self._skillData.castPerfList[1]
        if (currentCastPerf) then
            return currentCastPerf.castFxAnimName ~= ""
        end
    end

    return false
end

-- 获取释放技能时候的特效和挂载点
function Skill:getReleaseFXAnimAndMount()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    if(self._skillData) then
        local castPerf = self._skillData.castPerfList[1]
        if (castPerf) then
            return castPerf.castFxAnimName, castPerf.castAnimMount
        end
    end 
    return nil, nil
end

-- 获取技能收招时候的动画
function Skill:getFinishAnim()
    return nil
end

-- 获取效果出发时间列表
function Skill:getEffectTriggerTimeList()
    return self._effectTimeList
end

-- 获取触发效果列表
function Skill:getEffectIDList()
    if(self._skillData) then
        return self._skillData.efffectIDList
    end

    return nil
end

-- 获取飞行道具的出现时间
function Skill:getAircraftShowTime()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    if(self._skillData) then
        local currentCastPerf = self._skillData.castPerfList[1]
        if (currentCastPerf) then
            return currentCastPerf.flyFxTiming / TIME_UNIT
        end
    end

    return 0
end

-- 是否会产生飞行道具
function Skill:hasAircraft()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    if(self._skillData) then
        local currentCastPerf = self._skillData.castPerfList[1]
        if (currentCastPerf) then
            return currentCastPerf.flyFxAnimName ~= ""
        end
    end
    return false
end

-- 获取飞行道具的飞行时间
function Skill:getFlyTime()
    return self._effectTimeList[1]
end

-- 获取飞行道具的动画名字
function Skill:getFlyAnimName()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    if(self._skillData) then
        local currentCastPerf = self._skillData.castPerfList[1]
        if (currentCastPerf) then
            return currentCastPerf.flyFxAnimName
        end
    end
    return nil
end

-- 获取飞行挂载点
function Skill:getFlyMountPoint()
    if(self._skillData) then
        return self._skillData:getFlyMountPoint()
    end

    return nil
end

-- 获取飞行轨迹
function Skill:getFlyTrajectory()
    if(self._skillData) then
        return self._skillData:getFlyTrajectory()
    end

    return 0
end

-- 获取释放飞行道具的起飞点
function Skill:getAircraftStartMount()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    if(self._skillData) then
        local currentCastPerf = self._skillData.castPerfList[1]
        if (currentCastPerf) then
            return currentCastPerf.flyMountPoint
        end
    end
    return nil
end

-- 获取飞行道具的击中点
function Skill:getAircraftEndMount()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    if(self._skillData) then
        local currentCastPerf = self._skillData.castPerfList[1]
        if (currentCastPerf) then
            return currentCastPerf.hitMountPoint
        end
    end 
    return nil
end

-- 获取释放 act 的动画效果
function Skill:getReleaseActAnimation()
    if(self._skillData) then
        return self._skillData:getReleaseActAnimation()
    end

    return nil
end
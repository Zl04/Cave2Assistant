
--[[
    技能数据

]]
require "app.datas.GameData"

local LanguageManager = require("app.game.LanguageManager")

local SkillData = class("SkillData",GameData.Base)

Data = Data or {}
Data.SkillData = SkillData

-- private:

-- 构造函数(会自动调用)  
function SkillData:ctor(skillID, isPetActive)
    SkillData.super.ctor(self, Category.SKILL)

    self.skillID = skillID
    self.isOpening = false
    self.isPetActive = isPetActive or false -- 这里是否激活，eg:宠物技能如果是出站为true,否者为false
    self:conbinationLocalData()
end

function SkillData:initNet(mesData)
    -- 根据网络数据初始化
    local oldSkillId = self.skillID
    self.pk = mesData.pk or -1
    self.spriteID = mesData.spriteID or -1
    self.skillID = mesData.skillID or -1
    self.groupId = 0 --所属技能组ID
    if oldSkillId ~= mesData.skillID then
        self:conbinationLocalData()
    end

end

function SkillData:setIsOpening(isOpening)
    -- body
    self.isOpening = isOpening
end

function SkillData:getIsOpening()
    -- body
    return self.isOpening
end

function SkillData:setIsPetActive(isPetActive)
    self.isPetActive = isPetActive
end

function SkillData:getIsPetActive()
    return self.isPetActive
end

function SkillData:initLocal(data)
    if not data then
        return 
    end

    if self.skillID ~= data.skillID then
        self:setLocalConfigData(data)
    end
end

function SkillData:conbinationLocalData()
    if (self.skillID ~= -1) then
        local data = ConfigManager:getSkillConfigById(self.skillID)
        -- for k,v in pairs(data) do 
        --     self[k] = v
        -- end
        if(data) then 
            self:setLocalConfigData(data)
        end
    end
end

-- 获取技能id
function SkillData:getId()
    return self.skillID
end

function SkillData:getSkillID()
    return self.skillID
end

-- 获取技能类型
function SkillData:getSkillType()
    return self.type
end

-- 获取技能名字
function SkillData:getName()
    return self.name
end

-- 获取技能图标
function SkillData:getIconName()
    -- TODO 返回测试图标
    return self.iconID
end

-- 获取技能描述
function SkillData:getDescription()

    return self.description
end

function SkillData:getComparedTxt()
    if(self.comparedTxt ~= 0) then 
        return LanguageManager:getInstance():getLocalString(self.comparedTxt)
    end

    return nil
end

-- 是否是指向性技能
function SkillData:getIsDirection()
    if self.targetType ~= 1 and self.targetType ~= 4 then
        return true
    else
        return false
    end
end

-- TODO 该函数为测试函数，正式需要删掉
function SkillData:getNum()
    return 0
end

-- 是否为主动技能
function SkillData:isActive()
    if self.type == SkillType.PHYSICAL or self.type == SkillType.MAGIC then 
        return true
    end
    
    return false
end

-- 是否为辅助技能
function SkillData:isAssist()
    if (self.type == SkillType.ASSIST) then
        return true
    end

    return false
end
-- 是否为辅助技能
function SkillData:isHorcurx()
    if (self.type == SkillType.HORCURX) then
        return true
    end

    return false
end


-- 获取目标类型
function SkillData:getTargetType()
    return self.targetType
end

-- 是否有技能引导
function SkillData:hasGuide()
    return self.canBeChannelling == 1
end

-- 是否有呤唱
function SkillData:hasPrepareStep()
    return self.spellAnimID ~= 0
end

-- 获取技能范围
function SkillData:getUseRange()
    return self.targetRange
end

-- 获取技能释放时常
function SkillData:getCastDuration()
    return self.castDuration / TIME_UNIT
end

-- 是否有蓄力动作
function SkillData:hasPrepareAction()
    return self.spellPerf ~= nil
end

-- 获取技能冷却时间
function SkillData:getCooldown()
    return MasterDataManager:calculationSkillCooldown(self, self.cooldown, ToolsUtil:getRoleType(self.skillID, self:getIsPetActive()))
    -- return self.cooldown
end

-- 获取技能蓄力或者呤唱时间
function SkillData:getPrepareTime()
    if(self:hasPrepareStep() == true) then
        -- 处理呤唱时间
        return MasterDataManager:calculationSkillSing(self, self.spellDuration, ToolsUtil:getRoleType(self.skillID, self:getIsPetActive())) / TIME_UNIT
    end

    return self.spellDuration / TIME_UNIT
end



-- 获取蓄力或者呤唱的准备动画
function SkillData:getPrepareAnim()
    local spellPerf = self.spellPerf
    if (spellPerf) then
        return spellPerf.castAnimName[1]
    end
    return nil
end

-- 是否有蓄力或者呤唱技能的特效
function SkillData:hasPrepareFX()
    local spellPerf = self.spellPerf
    if (spellPerf) then
        return spellPerf.castFxAnimName ~= ""
    end
    return false
end

-- 获取蓄力或者呤唱技能时候的特效和挂载点
function SkillData:getPrepareFXAnimAndMount()
    local spellPerf = self.spellPerf
    if (spellPerf) then
        return spellPerf.castFxAnimName, spellPerf.castAnimMount
    end
    return nil, nil
end

-- 是否有释放动作
function SkillData:hasReleaseAction()
    if(self.castPerfList) then
        return #self.castPerfList > 0
    end

    return false
end

-- 是否有收招动作
function SkillData:hasFinishAction()
    return true
end

-- 获取释放技能的时间
function SkillData:getReleaseTime()
    return self.castDuration / TIME_UNIT
end

-- 呤唱产生特效的时间
function SkillData:getPrepareFXTime()
    local spellPref = self.spellPerf
    if (not spellPerf) then
        return 0
    end
    return spellPref.castFxTiming / TIME_UNIT
end

-- 释放产生特效的时间
function SkillData:getReleaseFXTime()
    local castPerf = self.castPerfList[1]
    if (not castPerf) then
        return 0
    end
    return castPerf.castFxTiming / TIME_UNIT
end

-- 获取释放动作列表
function SkillData:getReleaseAnimList()
    return self.castPerfList
end

-- 获取当前的释放动作
function SkillData:getReleaseAnim()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return currentCastPerf.castAnimName[1]
    end
    return nil
end

-- 是否有释放技能的特效
function SkillData:hasReleaseFX()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return currentCastPerf.castFxAnimName ~= ""
    end
    return false
end

-- 获取释放技能时候的特效和挂载点
function SkillData:getReleaseFXAnimAndMount()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    local castPerf = self.castPerfList[1]
    if (castPerf) then
        return castPerf.castFxAnimName, castPerf.castAnimMount
    end
    return nil, nil
end

-- 获取释放 act 的动画效果
function SkillData:getReleaseActAnimation()
    local castPerf = self.castPerfList[1]
    if(castPerf) then
        -- print("SkillData  ", castPerf.ID)
        return castPerf.skillActTargetType, castPerf.actAnimMount, castPerf.actAnimName, castPerf.actAnimTiming
    end
    
    return nil, nil, nil, nil
end

-- 获取技能收招时候的动画
function SkillData:getFinishAnim()
    return nil
end

-- 获取效果出发时间列表
function SkillData:getEffectTriggerTimeList()
    local effectTimeList = {}
    local timeList = self.effectTrigerTimeList
    for i = 1, #timeList do
        effectTimeList[i] = timeList[i] / TIME_UNIT
    end
    return effectTimeList
end

-- 获取是否有抖动
function SkillData:getHitFeedBack()
    return self.hitFeedBack
end

-- 屏幕抖动
function SkillData:getHitShake()
    return self.hitShake
end

-- 定帧时间
function SkillData:getHitFreeze()
    return self.hitFreeze/ TIME_UNIT
end

-- 获取触发效果列表
function SkillData:getEffectIDList()
    return self.efffectIDList
end

-- 获取飞行道具的出现时间
function SkillData:getAircraftShowTime()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return currentCastPerf.flyFxTiming / TIME_UNIT
    end
    return 0
end

-- 是否会产生飞行道具
function SkillData:hasAircraft()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return currentCastPerf.flyFxAnimName ~= ""
    end
    return false
end

-- 获取飞行道具的飞行时间
function SkillData:getFlyTime()
    if(self.effectTrigerTimeList[1]) then 
        return checkint(self.effectTrigerTimeList[1]) / TIME_UNIT
    else 
        return 0
    end
end

-- 获取飞行道具的动画名字
function SkillData:getFlyAnimName()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return currentCastPerf.flyFxAnimName
    end
    return nil
end

-- 获取释放飞行道具的起飞点
function SkillData:getAircraftStartMount()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return currentCastPerf.flyMountPoint
    end
    return nil
end

-- 获取飞行道具的击中点
function SkillData:getAircraftEndMount()
    -- TODO: 暂时之使用第一个，后期会根据单手和双手切换
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return currentCastPerf.hitMountPoint
    end
    return nil
end

-- 获取飞行挂载点
function SkillData:getFlyMountPoint()
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return currentCastPerf.flyMountPoint
    end
    return nil
end

-- 获取飞行轨迹
function SkillData:getFlyTrajectory()
    local currentCastPerf = self.castPerfList[1]
    if (currentCastPerf) then
        return tonumber(currentCastPerf.flyTrajectory)
    end

    return 0
end

-- 获取技能消耗的血或者蓝
function SkillData:getHPCost()
    if (self.costType == 2) then
        return self.cost
    end
    return 0
end

-- 获取技能消耗的血或者蓝
function SkillData:getMPCost()
    if (self.costType == 1) then
   
        return self.cost
        
    end
    return 0
end

-- 获取禁用类型
function SkillData:getDisableSituation()
    return self.disableSituation
end 

function SkillData:setGroupId(groupId)
    self.groupId = groupId
end 

function SkillData:getGroupId()
    return self.groupId or 0
end 




local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local Skill = {}
Config.Skill = Skill 
local cacheSkillAttr = nil

function Skill:getAllSkill()
    -- 获取所有技能
    if(cacheSkillAttr == nil) then
        local skillAttr = require("profiles/commonProfile/ProfileSkill")
        for k,v in pairs(skillAttr) do
            if (type(v) == "table") then
                v.skillID = v.ID
            end
        end
        cacheSkillAttr = skillAttr
    end

    return cacheSkillAttr
end

function Skill:getSkillConfigByOccupation(occupation)
    local allSkill = self:getAllSkill()
    local occupationList = {}

    -- 根据职业获取相关的技能配置
    for k,v in pairs (allSkill) do
        if (type(v) == "table")  then
            local int , yu = math.modf((v.ID-30000000)/100000)
            if int == occupation then
                table.insert(occupationList,v)
            end
        end 
    end

    return occupationList
end

-- 获取技能状态配置
function Skill:getSkillStatusConfig(statusType, roleType)
    local roleStatusAll = require "profiles/dataProfile/ProfileClientRoleStatus"

    for k, v in pairs(roleStatusAll) do
        if (type(v) == "table")  then
            if(v.statusType == statusType) then
                if(v.roleType == 4 or v.roleType == roleType) then
                    return v
                end
            end
        end
    end

    return nil
end

function Skill:getSkill(skillID)
    skillID = tonumber(skillID)
    -- print("Get skill config skillID=", skillID)
    -- print("--------------------------------")
    -- 根据skill id 获取配置文件
    local allSkill = self:getAllSkill()
    local skill = allSkill[skillID]
    if(skill == nil) then 
        -- printError("skill getSkill is nil by "..skillID)
        return nil
    end
    
    -- 获取与技能有关的客户端专用配置
    local SkillPerfMap = require "profiles/dataProfile/ProfileClientSkill"
    local spellPerfID = skill.spellAnimID
    local castPerf1ID = skill.castAnimID1
    local castPerf2ID = skill.castAnimID2

    local spellPerf = SkillPerfMap[spellPerfID]
    local castPerf1 = SkillPerfMap[castPerf1ID]
    local castPerf2 = SkillPerfMap[castPerf2ID]
    -- if (spellPerf) then
    --     print("spellPerf ", spellPerfID)
    --     for key, value in pairs(spellPerf) do
    --         print("key ", key, value)
    --     end
    -- end
    -- if (castPerf1) then
    --     print("castPerf1 ", castPerf1ID)
    --     for key, value in pairs(castPerf1) do
    --         print("key ", key, value)
    --     end
    -- end
    -- if (castPerf2) then
    --     print("castPerf2 ", castPerf2ID)
    --     for key, value in pairs(castPerf2) do
    --         print("key ", key, value)
    --     end
    -- end

    -- 客户端表现配置
    skill.spellPerf = spellPerf
    skill.castPerfList = {
        [1] = castPerf1,
        [2] = castPerf2
    }

    -- 效果触发时间列表
    skill.effectTrigerTimeList = {}
    local effectTriggerTiming = skill.effectTriggerTiming
    local result = AvalonUtil:splitStr(effectTriggerTiming, ",")
    if (result and #result > 0) then
        -- skill.effectTrigerTimeList = {}
        for i = 1, #result do
            local timeStr = result[i]
            table.insert(skill.effectTrigerTimeList, AvalonUtil.strToNumber(timeStr))
        end
    end

    -- 技能产生的效果列表
    skill.efffectIDList = {
        [1] = skill.effectID1 ~= 0 and skill.effectID1 or nil,
        [2] = skill.effectID2 ~= 0 and skill.effectID2 or nil,
        [3] = skill.effectID3 ~= 0 and skill.effectID3 or nil,
        [4] = skill.effectID4 ~= 0 and skill.effectID4 or nil
    }

    skill.name = LanguageManager:getInstance():getLocalString(skill.name)
    skill.description = LanguageManager:getInstance():getLocalString(skill.description)

    -- print("--------------------------------\n")

    return skill
end

function Skill:getSkillBlessing()
    local skillBlessing = require "profiles/commonProfile/ProfileSkillBlessing"

    return skillBlessing
end

function Skill:clear()
    cacheSkillAttr = nil
    reload_script_file("profiles/commonProfile/ProfileSkill")
    reload_script_file("profiles/dataProfile/ProfileClientRoleStatus")
    reload_script_file("profiles/dataProfile/ProfileClientSkill")
    reload_script_file("profiles/commonProfile/ProfileSkillBlessing")
end
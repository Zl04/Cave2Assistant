

Config = Config or {}


local SkillTree = {}
Config.SkillTree = SkillTree 

-- 缓存效果配置数据
local SkillTreeDataCache = nil
local SkillTreeAdvancedDataCache = nil
local SkillTreeReincarnationdDataCache = nil

function SkillTree:getAllSkillTree(skillTreeModel)
    local skillTree = nil

    if(skillTreeModel == SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then 
        -- 获取所有技能
        if (not SkillTreeDataCache) then
            SkillTreeDataCache = require("profiles/commonProfile/ProfileSkillTree")
            
            assert(type(SkillTreeDataCache) == "table", "[ERROR] SkillTree getAllSkillTree: could not get all the SkillTree config.")
        end

        skillTree = SkillTreeDataCache
    elseif(skillTreeModel == SkillTreeModel.SKILL_TREE_MODEL_ADVANCED) then 
        if (not SkillTreeAdvancedDataCache) then
            SkillTreeAdvancedDataCache = require("profiles/commonProfile/ProfileSkillTreeAdvanced")
        end

        skillTree = SkillTreeAdvancedDataCache
    elseif (skillTreeModel == SkillTreeModel.SKILL_TREE_MODEL_REINCARNATION) then
        if (not SkillTreeReincarnationdDataCache) then
            SkillTreeReincarnationdDataCache = require("profiles/commonProfile/ProfileSkillTreeReincarnation")
        end

        skillTree = SkillTreeReincarnationdDataCache
    else 
        printError("SkillTree:getAllSkillTree not handle skillTreeModel.", skillTreeModel)
    end

    return skillTree
end

function SkillTree:getSkillTree(skillTreeModel, skillGroupID)
    skillGroupID = tonumber(skillGroupID)
    -- print("Get skill config skillID=", skillGroupID, skillTreeModel)
    -- TODO 根据skill id 获取配置文件
    local allSkillTree = self:getAllSkillTree(skillTreeModel)
    return allSkillTree[skillGroupID]
end

function SkillTree:getSkillTreeByType(skillTreeModel, skillTreeType, storey, stage)
    local skillTreeData = self:getAllSkillTree(skillTreeModel);
    if stage ~= nil then --转职后才有二阶技能
        local temp = {}
        for k,v in pairs(skillTreeData) do
            if type(v) == "table" then
                v.skillAdvancement = v.skillAdvancement or Game.SkillAdvanceType.AdvanceTypeOne
                if v.skillAdvancement == stage then
                    table.insert(temp, v)
                end
            end
        end
        skillTreeData = temp
    end
    local data = {}
    if storey == nil then
        for k,v in pairs(skillTreeData) do
            if type(v) == "table" and v.skillGroupID then
                if string.sub(tostring(v.skillGroupID),3,3) == tostring(skillTreeType) then
                    table.insert(data,v)
                end
            end
        end
    else
        for k,v in pairs(skillTreeData) do
            if type(v) == "table" and v.skillGroupID then
                if string.sub(tostring(v.skillGroupID),3,3) == tostring(skillTreeType) and storey == v.storey then
                    table.insert(data,v)
                end
            end
        end
    end
    return data
end


-- 清理
function SkillTree:clear()
    reload_script_file("profiles/commonProfile/ProfileSkillTree")
    reload_script_file("profiles/commonProfile/ProfileSkillTreeAdvanced")
    reload_script_file("profiles/commonProfile/ProfileSkillTreeReincarnation")
    SkillTreeDataCache = nil
    SkillTreeAdvancedDataCache = nil
    SkillTreeReincarnationdDataCache = nil
end
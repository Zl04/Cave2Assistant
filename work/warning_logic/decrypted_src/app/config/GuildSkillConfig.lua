

Config = Config or {}


local GuildSkill = {}
Config.GuildSkill = GuildSkill 

-- 缓存效果配置数据
local GuildSkillDataCache = nil

function GuildSkill:getAllGuildSkill()
    -- 获取所有技能
    if (not GuildSkillDataCache) then
        GuildSkillDataCache = require("profiles/commonProfile/ProfileGuildSkill")
        
        assert(type(GuildSkillDataCache) == "table", "[ERROR] GuildSkill getAllGuildSkill: could not get all the GuildSkill config.")
    end
    return GuildSkillDataCache
end



function GuildSkill:getGuildSkill(guildSkillID)
    guildSkillID = tonumber(guildSkillID)
    --print("Get skill config skillID=", guildSkillID)
    -- TODO 根据skill id 获取配置文件
    local allGuildSkill = self:getAllGuildSkill()
    return allGuildSkill[guildSkillID]
end


function GuildSkill:getGuildSkillByType(guildSkillType)
    local allGuildSkill = self:getAllGuildSkill();
    local data = {}
    for k,v in pairs(allGuildSkill) do

        if type(v) == "table" and v.ID then
            if v.needTechID == guildSkillType then
                table.insert(data,v)
            end
        end
    end
    return data
end


-- 清理
function GuildSkill:clear()
    reload_script_file("profiles/commonProfile/ProfileGuildSkill")
    GuildSkillDataCache = nil
end
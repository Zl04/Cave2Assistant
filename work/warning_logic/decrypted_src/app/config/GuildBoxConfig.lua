Config = Config or {}


local GuildBox = {}
Config.GuildBox = GuildBox 

-- 缓存效果配置数据
local GuildBoxDataCache = nil

function GuildBox:getAllGuildBox()
    -- 获取所有技能
    if (not GuildBoxDataCache) then
        GuildBoxDataCache = require("profiles/commonProfile/ProfileGuildBox")
        
        assert(type(GuildBoxDataCache) == "table", "[ERROR] GuildBox getAllGuildBox: could not get all the GuildBox config.")
    end
    return GuildBoxDataCache
end

function GuildBox:getGuildBox(guildSkillID)
    guildSkillID = tonumber(guildSkillID)
    --print("Get skill config skillID=", guildSkillID)
    -- 根据skill id 获取配置文件
    local allGuildSkill = self:getAllGuildBox()
    return allGuildSkill[guildSkillID]
end

-- 清理
function GuildBox:clear()
    reload_script_file("profiles/commonProfile/ProfileGuildBox")
    GuildBoxDataCache = nil
end
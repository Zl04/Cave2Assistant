local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local Pond = {}
Config.Pond = Pond 

local POND_CACHE = nil


-- 根据任务ID获取任务数据
function Pond:getPondById(pondId)
    local pondMap = self:getAllPond()
    local pond = pondMap[pondId]
    return pond
end

--获取所有任务数据
function Pond:getAllPond()
    if POND_CACHE == nil then
        local pondMap = require("profiles/commonProfile/ProfilePond")
        POND_CACHE = {}
        for k,v in pairs(pondMap) do
            if type(v) == "table" and v.id then
                POND_CACHE[v.id] = v
            end
        end
    end
    return POND_CACHE
end


-- 清理
function Pond:clear()
    reload_script_file("profiles/commonProfile/ProfilePond")
    POND_CACHE = nil
end
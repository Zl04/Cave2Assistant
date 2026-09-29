
local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}


local FaceConfig = {}
Config.FaceConfig = FaceConfig 

-- 缓存效果配置数据
local FaceConfigDataCache = nil

function FaceConfig:getAllFaceConfig()
    -- 获取所有技能
    if (not FaceConfigDataCache) then
        FaceConfigDataCache = require("profiles/commonProfile/ProfileFace")
        
        assert(type(FaceConfigDataCache) == "table", "[ERROR] FaceConfig getAllFaceConfig: could not get all the FaceConfig config.")
    end
    return FaceConfigDataCache
end

function FaceConfig:getFaceConfig(id)
    -- print("FaceConfig:getFaceConfig",id)
    id = tonumber(id)

    local allFaceConfig = self:getAllFaceConfig()
    return allFaceConfig[id]
end

function FaceConfig:serializeFaceConfig()
    local FaceConfigData = self:getAllFaceConfig();
    local data = {}
    for k,v in pairs(FaceConfigData) do
        if type(v) == "table" and v.id then
            local complexion = math.floor(v.id/1000000)
            local faceType = math.floor((v.id%10000)/1000)
            local id = math.floor((v.id%1000))

            for i = 1,#v.name do
                v.name[i] = LanguageManager:getInstance():getLocalString(v.name[i])
            end


            if data[complexion] == nil then
                data[complexion] = {}
            end

            if data[complexion][faceType] == nil then
                data[complexion][faceType] = {}
            end
            data[complexion][faceType][id] = v
        end
    end
    return data
end


-- 清理
function FaceConfig:clear()
    reload_script_file("profiles/commonProfile/ProfileFace")
    FaceConfigDataCache = nil
end
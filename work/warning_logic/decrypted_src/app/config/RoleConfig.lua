--[[
    角色配置
]]--

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

-- 角色类型
Config.RoleType = {
    HERO = 1,
    MONSTER = 2,
    NPC = 3,
    PET = 4,
}
ConfigRoleType = Config.RoleType

ConfigRole = {}
Config.ConfigRole = ConfigRole

local _heroConfigCache = nil
local _monsterConfigCache = {}
local _monsterConfigMap = {}
local _monsterConfigCacheList = {}


-- 清理
function ConfigRole:clear()
    _heroConfigCache = nil
    _monsterConfigCache = {}
    _monsterConfigMap = {}
    for k,v in pairs(_monsterConfigCacheList) do
        reload_script_file(v)
    end
    _monsterConfigCacheList = {}
end

local function getHeroSpineName(sex)
    local fileName = "role_hero_"

    if sex == PublicDefine.HERO_SEX.MALE then
        fileName = fileName.."1.json"
    elseif sex == PublicDefine.HERO_SEX.FEMALE then
        fileName = fileName.."2.json"
    else
        fileName = fileName.."1.json"
    end

    return fileName
end

function ConfigRole:getHeroConfig(sex,roleLV)
    if not _heroConfigCache then
        _heroConfigCache = require("profiles/commonProfile/ProfileHeroAttribute")
    end

    if _heroConfigCache then
        local heroConfig = _heroConfigCache[roleLV]
        if heroConfig then
            heroConfig = clone(heroConfig)
            heroConfig.skeleton = getHeroSpineName(sex)
            heroConfig.atlas = ToolsUtil:getHeroAtlas()

            heroConfig.width = 0
            heroConfig.height = 0
            heroConfig.direction = 1
            heroConfig.scale = Game.HERO_ANIMATION_SCALE 

            return heroConfig
        end
    end

    return nil
end


function ConfigRole:getMonsterListConfig(model, diffculty)
    -- print("ConfigRole:getMonsterListConfig",model, diffculty)
    if(_monsterConfigCache[model] == nil) then
        _monsterConfigCache[model] = {}
    end
    if _monsterConfigCache[model][diffculty] == nil then
        -- print("123",string.format("profiles/commonProfile/ProfileMonstersAttribute_%d_%d", model, diffculty))
        _monsterConfigCache[model][diffculty] = require(string.format("profiles/commonProfile/ProfileMonstersAttribute_%d_%d", model, diffculty))
        table.insert(_monsterConfigCacheList,string.format("profiles/commonProfile/ProfileMonstersAttribute_%d_%d", model, diffculty))
        local monsterConfig = _monsterConfigCache[model][diffculty]
        -- print(_monsterConfigCache[model][diffculty][10201101].name)
        for k,v in pairs(monsterConfig) do 
            if type(v) == "table" then
                v = self:_configToData(v)
            end
        end
        -- print(_monsterConfigCache[model][diffculty])
    end

    return _monsterConfigCache[model][diffculty]
end

function ConfigRole:getMonsterConfig(monsterID, model, diffculty)
    -- print("ConfigRole:getMonsterConfig ", monsterID, model, diffculty)
    if(model == nil) then
        model = 1
    end

    if(diffculty == nil) then
        diffculty = 1
    end

    if(monsterID) then
        monsterID = checkint(monsterID)
    end

    local key = monsterID..":"..model..":"..diffculty
    -- print("ConfigRole:getMonsterConfig ", key)
    local monsterData = _monsterConfigMap[key]
    if not monsterData then

        local monsterConfig = self:getMonsterListConfig(model, diffculty)

        local mAttr = monsterConfig[monsterID]
        if mAttr ==nil then
            return nil
        end

        monsterData = mAttr
        _monsterConfigMap[key] = monsterData
    end

    return monsterData
end 

function ConfigRole:getMonsterConfigByChangeId(monsterID, model, diffculty)
    -- print("ConfigRole:getMonsterConfig ", monsterID, model, diffculty)
    if(model == nil) then
        model = 1
    end

    if(diffculty == nil) then
        diffculty = 1
    end

    if(monsterID) then
        monsterID = checkint(monsterID)
    end
    local monsterConfig = self:getMonsterListConfig(model, diffculty)
    for k, v in pairs(monsterConfig) do
        if type(v) == "table" and v.changeID == monsterID then
            return v
        end
    end
    return nil
end 


function ConfigRole:getMonsterModeAndDiffcultFromMonsterID(monsterID)
    -- print("ConfigRole:getMonsterFromAllConfig ", monsterID, model, diffculty)
    local diffculty = 1

    if(monsterID) then
        monsterID = checkint(monsterID)
    end

    for model = PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_MODE.MODE_MAX -1, 1 do 
        local monsterData = self:getMonsterConfig(monsterID, model, diffculty)
        if(monsterData) then 
            return model, diffculty
        end
    end
    return nil
end 

function ConfigRole:_configToData(monster)
    --用于角色显示效果
    monster.monsterID= monster.id
    monster.type = ConfigRoleType.MONTER
    monster.direction = 1
    if monster.spine then
        -- 添加了对于动画是否存在的测试代码
        local fullPath =  cc.FileUtils:getInstance():fullPathForFilename(""..monster.spine..".json")
        if cc.FileUtils:getInstance():isFileExist(fullPath) then
            monster.skeleton = ""..monster.spine..".json"
            monster.atlas = ""..monster.spine..".atlas"
        else 
            monster.skeleton = monster.spine..".json"
            monster.atlas = monster.spine..".atlas"
            print("ConfigRole:_configToData not fond new spine=", monster.spine..".json")
        end
        if(monster.spineAtlas and monster.spineAtlas ~= "") then 
            monster.atlas = monster.spineAtlas..".atlas"
        end
    else
        assert(false,"[ERROR] RoleConfig:getMonsterConfig  spine is null")
    end

    monster.width = 0
    monster.height = 0
    monster.scale = 1.0

    -- 相关多语言转换
    -- monster.name = LanguageManager:getInstance():getLocalString(monster.name)
    -- if tostring(monster.name) == "1010001" then
    --     print("monster.name","1010001",monster.name,LanguageManager:getInstance():getLocalString(monster.name))
    -- end

    monster.name = LanguageManager:getInstance():getLocalString(monster.name)
    monster.petName = LanguageManager:getInstance():getLocalString(monster.petName)
    monster.description = LanguageManager:getInstance():getLocalString(monster.description)
    return monster
end






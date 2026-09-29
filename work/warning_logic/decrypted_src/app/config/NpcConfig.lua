
local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local Npc = {}
Config.Npc = Npc 

local triggerNPCCache = nil
local trapNpcCache = nil
local collectCache = nil
local blackMarketCache = nil
local functionNPCButtonCache = nil

function Npc:getAllTriggerNPCConfig()
    if triggerNPCCache == nil then
        triggerNPCCache = require("profiles/commonProfile/ProfileTriggerNPC")
    end

    return triggerNPCCache
end

function Npc:getAllTrapNpcConfig()
    if trapNpcCache == nil then
        trapNpcCache = require("profiles/commonProfile/ProfileTrap")
    end

    return trapNpcCache
end

function Npc:getAllCollectNpcConfig()
    if collectCache == nil then
        collectCache = require("profiles/commonProfile/ProfileCollectNPC")
    end

    return collectCache
end

function Npc:getAllBlackMarketConfig()
    if blackMarketCache == nil then
        blackMarketCache = require("profiles/commonProfile/ProfileBlackMarket")
    end

    return blackMarketCache
end

function Npc:getClientFuntionButtonConfig()
    if functionNPCButtonCache == nil then
        functionNPCButtonCache = require("profiles/dataProfile/ProfileClientFunctionNPCButton")
    end

    return functionNPCButtonCache
end


-- 清理
function Npc:clear()
    reload_script_file("profiles/commonProfile/ProfileTriggerNPC")
    reload_script_file("profiles/commonProfile/ProfileTrap")
    reload_script_file("profiles/commonProfile/ProfileBlackMarket")
    reload_script_file("profiles/dataProfile/ProfileClientFunctionNPCButton")
    triggerNPCCache = nil
    trapNpcCache = nil
    blackMarketCache = nil
    functionNPCButtonCache = nil
end

function Npc:getClientFuntionButtonConfigByID(functionType)
    local allCache = self:getClientFuntionButtonConfig()

    local config = nil
    if(allCache) then
        config = allCache[functionType]
    end

    if(config == nil) then
        assert(false,string.format("Npc:getClientFuntionButtonConfigByID functionType=%d",functionType))
    end

    return config
end

function Npc:getTriggerConfigByID(ID)
    local allTriggerNpcConfig = self:getAllTriggerNPCConfig()

    local npcConfig = allTriggerNpcConfig[ID]

    -- 处理陷阱的配置文件逻辑处理
    if(not npcConfig) then
        local allTrapConfig = self:getAllTrapNpcConfig()
        npcConfig = allTrapConfig[ID]
        if(npcConfig) then
            local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE
            npcConfig.NPCType = TRIGGER_NPC_TYPE.TRAP
        end
    end
    if(not npcConfig) then
        local allCollectConfig = self:getAllCollectNpcConfig()
        npcConfig = allCollectConfig[ID]
        if(npcConfig) then
            local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE
            npcConfig.NPCType = TRIGGER_NPC_TYPE.COLLECT
        end
    end

    if(npcConfig == nil) then
        assert(false, string.format("Npc:getTriggerConfigByID  id=%d", ID))
        return npcConfig
    end

    -- spine 资源问题
    npcConfig.skeleton = npcConfig.spine..".json"
    npcConfig.atlas = npcConfig.spine..".atlas"
    
    npcConfig.scale = 1.0

    return npcConfig   
end

-- 获取配置列表
function Npc:getBlackMarketByGroupID(groupID)
    local blackMarketConfig = self:getAllBlackMarketConfig()
    if(blackMarketConfig) then
        return blackMarketConfig[groupID]
    end

    return nil
end
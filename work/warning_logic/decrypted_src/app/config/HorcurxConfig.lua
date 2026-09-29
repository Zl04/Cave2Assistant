--[[
    装备锻造相关配置文件
]]--

local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local HorcurxConfig = {}
Config.HorcurxConfig = HorcurxConfig 


local upgradeConfig
local evolutionConfig
local cultureConfig
local inited = false
function HorcurxConfig:init()
    if not inited then
        inited = true
    else
        return
    end
    upgradeConfig = require("profiles.commonProfile.ProfilehorcruxUpgrade")
    evolutionConfig = require("profiles.commonProfile.ProfilehorcruxEvolution")
    cultureConfig = require("profiles.commonProfile.ProfilehorcruxCulture")

end

function HorcurxConfig:getUpdateConfig()
    return upgradeConfig
end

function HorcurxConfig:getUpdateConfigById(idx)
    return upgradeConfig[idx]
end

function HorcurxConfig:getEvolutionConfig()
    return evolutionConfig
end
function HorcurxConfig:getEvolutionConfigById(idx)
    return evolutionConfig[idx]
end

function HorcurxConfig:getCultureConfigById(idx)
    return cultureConfig[idx]
end

function HorcurxConfig:clear()
    upgradeConfig = nil
    evolutionConfig = nil
    cultureConfig = nil

    inited = false
end

HorcurxConfig:init()
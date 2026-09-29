Config = Config or {}

local General = {}
Config.General = General

-- 缓存效果配置数据
local generalDataCache = nil

function General:getAllConfig()
    if not generalDataCache then
        generalDataCache = require("profiles/commonProfile/ProfileGeneralConfig")
    end

    return generalDataCache
end

-- 清理
function General:clear()
    reload_script_file("profiles/commonProfile/ProfileGeneralConfig")
    generalDataCache = nil
end

function General:getMoveSpeed()
    local generalData = self:getAllConfig()

    return generalData["moveSpeed"].value
end

-- 获取逃跑时间
function General:getEscapeTime()
    local generalData = self:getAllConfig()

    return generalData["escapeTime"].value
end

-- 获取技能公共CD
function General:getPublicCDTime()
    local generalData = self:getAllConfig()

    return generalData["publicCDTime"].value
end

function General:getGoldBagID()
    local generalData = self:getAllConfig()

    return generalData["goldBagID"].value
end

function General:getGoldBagSpine()
    local generalData = self:getAllConfig()

    return generalData["goldBagSpine"].value
end

function General:getBlackShopRefreshTime()
    local generalData = self:getAllConfig()

    return generalData["blackMarketRefreshTime"].value
end

function General:getRandomShopRefreshTime()
    local generalData = self:getAllConfig()

    return generalData["randShopRefreshTime"].value
end

function General:getDungeonMaxLevel()
    local generalData = self:getAllConfig()

    return tonumber(generalData["maxDungeonLevel"].value)
end
-- 获取绑定账号提示时间
function General:getBindAccountInterval()
    local generalData = self:getAllConfig()

    return tonumber(generalData["pushBindAccountIntervalTime"].value)
    -- return 1;
end

-- 获取濒死血量比例
function General:getDangerousHPPercent()
    -- body
    local generalData = self:getAllConfig()

    return tonumber(generalData["DangerousHPPercent"].value)
end

function General:getInitSkillGroupList()
    -- body
    local generalData = self:getAllConfig()

    return generalData["initSkillGroupList"].value
end

function General:getValueForKey(key)
    local generalData = self:getAllConfig()
    if generalData[key] == nil then
        return 0
    end
    return generalData[key].value
end

function General:getMarblesFeverLuckyPoint()
    -- body
    local generalData = self:getAllConfig()

    return generalData["marblesFeverLuckyPoint"].value
end

function General:getMarblesLimitedFeverLuckyPoint()
    -- body
    local generalData = self:getAllConfig()

    return generalData["marblesLimitedFeverLuckyPoint"].value
end

function General:getDreamExchangeShopRefresh()
    local generalData = self:getAllConfig()

    return generalData["dreamExchangeShopRefresh"].value
end

function General:getBossPortalConfig()
    local generalData = self:getAllConfig()

    return generalData["everydayJumpTimes_BOSS"].value
end

function General:getDailyFishingTime()
    local generalData = self:getAllConfig()

    return generalData["dailyFishingTime"].value
end

-- 获取水晶夺宝1次和10次消耗道具数量 "23030001,60;23030001,600"
function General:getCrystalLootConsumption()
    local generalData = self:getAllConfig()

    return generalData["crystalLootConsumption"].value
end

-- 获取经验副本每周上限次数
function General:getExpPerNums()
    -- body
    local generalData = self:getAllConfig()

    return tonumber(generalData["coinChallengeNumPerWeek"].value)
end

-- 获取雕文洗练消耗材料
function General:getGlyphsRefinedCostConfig()
    -- body
    local generalData = self:getAllConfig()

    local config = {}
    config.glyphCommonRefinedConsume = generalData["glyphCommonRefinedConsume"].value
    config.glyphPayRefinedConsume = generalData["glyphPayRefinedConsume"].value

    return config
end
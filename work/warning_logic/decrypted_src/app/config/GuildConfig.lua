--[[
    公会配置
]]--

local LanguageManager = require("app.game.LanguageManager")

Config = Config or {}

local ConfigGuild = {}
Config.ConfigGuild = ConfigGuild

-- 缓存效果配置数据
local guildCache = nil

local allIconList = nil
local allMemberList = nil

function ConfigGuild:getAllIconList()
    if(allIconList == nil) then 
        local guildConfig = self:getGuild()
        -- print("ConfigGuild:getAllIconList")
        -- dump(guildConfig)
        -- print("ConfigGuild:getAllIconList  end")

        local iconIDList = AvalonUtil:splitStr(guildConfig.iconIDList, ";")
        local iconResList = AvalonUtil:splitStr(guildConfig.iconResList, ";")
        local iconCostList = AvalonUtil:splitStr(guildConfig.iconCostList, ";")

        allIconList = {}
        for i=1, #iconIDList do  
            local iconData = {}
            
            iconData.iconID = iconIDList[i]
            iconData.iconSpriteName = iconResList[i]
            iconData.iconCost = iconCostList[i]

            table.insert(allIconList, iconData)
        end
    end

    return allIconList
end

function ConfigGuild:getAllMemberList()
    if(allMemberList == nil) then 
        local guildConfig = self:getGuild()

        local levelList = AvalonUtil:splitStr(guildConfig.levelList, ";")
        local memberCapList = AvalonUtil:splitStr(guildConfig.memberCapList, ";")

        allMemberList = {}
        for i=1, #levelList do  
            local memberData = {}
            
            memberData.level = levelList[i]
            memberData.memberCap = memberCapList[i]

            table.insert(allMemberList, memberData)
        end
    end

    return allMemberList
end

function ConfigGuild:getDiamondForCreation()
    local guildConfig = self:getGuild()

    return guildConfig.diamondForCreation
end

function ConfigGuild:getDiamondForRename()
    local guildConfig = self:getGuild()
    return guildConfig.changeGuildNameCostDiamond 
end

function ConfigGuild:getDiamondForRenameTitle()
    local guildConfig = self:getGuild()
    return guildConfig.renameTitlePrice 
end

function ConfigGuild:getMinLevelCreation()
    local guildConfig = self:getGuild()
    if(guildConfig.buildGuildRoleLv == nil) then 
        return 10
    end
    return tonumber(guildConfig.buildGuildRoleLv)
end

function ConfigGuild:getGuildEquipScore()
    local guildConfig = self:getGuild()

    return guildConfig.equipScoreList
end

function ConfigGuild:getGuildTechExp()
    local guildConfig = self:getGuild()

    return AvalonUtil:splitStr(guildConfig.techExpRequireList, ";")
end

function ConfigGuild:getGuildTechDesc()
    local guildConfig = self:getGuild()
    local idList = AvalonUtil:splitStr(guildConfig.techDescriptionList, ";")
    local textList = {}
    for k, v in ipairs(idList) do
        table.insert(textList, LanguageManager:getInstance():getLocalString(tonumber(v)))
    end
    return textList
end

function ConfigGuild:getOverthrowOfflineDurationForCoLeader()
    local guildConfig = self:getGuild()
    local offlineRecallDurationArr = AvalonUtil:splitStr(guildConfig.offlineRecallDuration, ";")
    return offlineRecallDurationArr[1]
end

function ConfigGuild:getOverthrowOfflineDurationForMemeber()
    local guildConfig = self:getGuild()
    local offlineRecallDurationArr = AvalonUtil:splitStr(guildConfig.offlineRecallDuration, ";")
    return offlineRecallDurationArr[2]
end

function ConfigGuild:getOverthrowVoteDuration()
    local guildConfig = self:getGuild()
    return guildConfig.revokeSettlementTime
end

function ConfigGuild:getOverthrowOpenTimeForNewMember()
    local guildConfig = self:getGuild()
    return guildConfig.removalAuthorityOpened
end

function ConfigGuild:getBoxNumLimit()
    local guildConfig = self:getGuild()
    return guildConfig.guildBoxLimit
end

function ConfigGuild:getNewMemberBoxOpenLimitTime()
    local guildConfig = self.getGuild()
    return guildConfig.guildBoxGetLimit
end

function ConfigGuild:getGuildConfigForKey(key)
    local guildConfig = self.getGuild()
    if(guildConfig) then 
        return guildConfig[key]
    end

    return nil
end

function ConfigGuild:getGuildRandomShopData()
    local guildConfig = self.getGuild()
    local data = {}
    data.refreshTime = guildConfig.randomShopRefreshTime*60*60*24
    data.price = {}
    local priceArr = string.split(guildConfig.randomShopRefreshPrice, ";")
    for _, v in ipairs(priceArr) do
        local onePrice = string.split(v, ",")
        table.insert(data.price, {id=tonumber(onePrice[1]), num=tonumber(onePrice[2])})
    end
    return data
end

function ConfigGuild:getGuild()
    if not generalDataCache then
        guildCache = require("profiles/commonProfile/ProfileGuild")
    end
    return guildCache[1]
end

-- 清理
function ConfigGuild:clear()
    reload_script_file("profiles/commonProfile/ProfileGuild")
    guildCache = nil
end

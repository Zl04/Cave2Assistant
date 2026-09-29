--[[
    装备锻造相关配置文件
]]--

local LanguageManager = require("app.game.LanguageManager")
Config = Config or {}

local EquipForge = {}
Config.EquipForge = EquipForge 

local formatedData = {}
local tabEquips = {}
local inited = false
local cfgData = nil

local TAB_TYPE = {
    ALL = 1;            -- 全部
    SWORD_SHIELD = 2;   -- 剑盾
    GREAT_SWORD = 3;    -- 大剑
    MAGIC_STAFF = 4;    -- 法杖
    HELMET = 5;         -- 头盔
    CHEST = 6;          -- 胸甲
    SHOULDERS = 7;      -- 肩甲
    GLOVES = 8;         -- 手套
    BOOTS = 9;          -- 鞋子
    AUMLET = 10;        -- 项链
    RING = 11;          -- 戒指
}

function EquipForge:init()
    if not inited then
        inited = true
    else
        return
    end

    cfgData = require("profiles/commonProfile/ProfileForgingequipment")
    local equipConfig = require("profiles/dataProfile/ProfileEquipmentsAttrClient")

    for i = 1, 11 do
        tabEquips[i] = {}
    end

    local counter = 0
    for k, v in ipairs(cfgData) do
        local oneData = {}
        oneData.configID = v.ID
        oneData.id = v.name
        oneData.forgeConsume = {}
        oneData.forgeConsume.type = v.Forgingconsumption[1]
        oneData.forgeConsume.price = v.Forgingconsumption[2]

        oneData.unlockConsume = {}
        oneData.unlockConsume.type = v.Unlockconsumption[1]
        oneData.unlockConsume.price = v.Unlockconsumption[2]

        oneData.unlockPoint = v.Unlockmaxpoint

        oneData.material = {}
        local matCfgs = string.split(v.value, ";")
        for m, n in ipairs(matCfgs) do
            local cfg = string.split(n, ",")
            local oneMat = {}
            oneMat.id = tonumber(cfg[1])
            oneMat.num = tonumber(cfg[2])
            oneData.material[m] = oneMat
        end

        formatedData[k] = oneData

        -- 处理tab页的分类
        local equipCfg = equipConfig[oneData.id]
        local type = math.modf(oneData.id/10000%10)
        if type == PublicDefine.EQUIPMENT_TYPE.Weapon then
            -- 武器
            local subType = tonumber(equipCfg.remarksField[1])
            local finalType = subType
            if subType == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                finalType = 4
            elseif subType == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                finalType = 2
            elseif subType == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                finalType = 3
            end
            local idx = #tabEquips[finalType]+1
            tabEquips[finalType][idx] = oneData
        else
            local idx = #tabEquips[type+4]+1
            tabEquips[type+4][idx] = oneData
        end

        tabEquips[1][#tabEquips[1]+1] = oneData
    end
end

function EquipForge:getEquipForgeListByType(type)
    self:init()

    return tabEquips[type]
end

function EquipForge:getEquipForgeConfigByID(id)
    self:init()

    return cfgData[id]
end

function EquipForge:clear()
    reload_script_file("profiles/commonProfile/ProfileForgingequipment")
    formatedData = {}
    tabEquips = {}
end
--[[
    配置文件管理器
]]--


local configTable = {  
     "app.config.RoleConfig",
     "app.config.GoodsConfig",
     "app.config.SkillConfig",
     "app.config.BufferConfig",
     "app.config.EffectConfig",
     "app.config.GeneralConfig",
     "app.config.NpcConfig",
     "app.config.MonsterAffixConfig",
     "app.config.LocalSpineConfig",
     "app.config.SkillTreeConfig",
     "app.config.RandAttributeConfig",
     "app.config.TaskConfig",
     "app.config.PlotEventConfig",
     "app.config.PlotConfig",
     "app.config.AudioConfig",
     "app.config.TreasuremapConfig",
     "app.config.FaceConfig",
     "app.config.CatFoodConfig",
     "app.config.DropListConfig",
     "app.config.PondConfig",
     "app.config.PondConfig",
     "app.config.BlackDialogConfig",
     "app.config.QuickExpressionConfig",
     "app.config.MapLevelConfig",
     "app.config.GuildConfig",
     "app.config.GuildSkillConfig",
     "app.config.DungeonSeasonRewardConfig",
     "app.config.ShareConfig",
     "app.config.ServerListConfig",
     "app.config.FunnyRecordConfig",
     "app.config.FunctionUnlockConfig",
     "app.config.LoadingConfig",
     "app.config.CommentEventConfig",
     "app.config.StoryConfig",
     "app.config.WeatherConfig",
     "app.config.RandAttributeGroupConfig",
     "app.config.LevelSelectConfig",
     "app.config.GemShopConfig",
     "app.config.QuickChatConfig",
     "app.config.GoldenMineConfig",
     "app.config.GemFactoryConfig",
     "app.config.HomeTaskConfig",
     "app.config.MainTalentConfig",
     "app.config.SubTalentConfig",
     "app.config.GemChangeCostConfig",
     "app.config.EquipStrengthenConfig",
     "app.config.EquipIllusionConfig",
     "app.config.EquipIllusionGroupConfig",
     "app.config.DreamConfig",
     "app.config.DreamShopConfig",
     "app.config.EquipConvertConfig",
     "app.config.DreamTaskConfig",
     "app.config.EquipForgeConfig",
     "app.config.HorcurxConfig",
     "app.config.TargetActivityConfig",
     "app.config.TargetConfig",
     "app.config.GuildBoxConfig",
     "app.config.GuildWishConfig",
}

for k, v in ipairs(configTable) do
    require (v)
end

Config = Config or {}
NewConfig = NewConfig or {}

--{"类名", "相对路径", "主键", {"多语言key1", "多语言key2"}}
local newConfigList = {
    {"SpecialEventConfig",  "profiles/commonProfile/ProfileSpecialEvent",     "ID", {"name", "description"}},
    {"EquipRecastConfig",   "profiles/commonProfile/ProfileEquipmentRecast",  "ID"}, 
    {"NpcDialogConfig",     "profiles/dataProfile/ProfileClientDialogue",     "ID"}, 
    {"Achievement",         "profiles/commonProfile/ProfileAchievement",      "ID", {"name", "description"}}, 
    {"StarPray",            "profiles/commonProfile/ProfileStarPray",         "ID", {"name"}}, 
    {"Advert",              "profiles/dataProfile/ProfileClientadvertisement",      "ID"}, 
    {"Expedition",          "profiles/commonProfile/ProfileExpedition",      "ID"}, 
    {"WorldBoss",           "profiles/commonProfile/ProfileWorldBoss",      "mapConfig"}, 
    {"GuildBossPool",       "profiles/commonProfile/ProfileGuildBossPool", "monsterID"},
    {"GuildBossCfg",        "profiles/commonProfile/ProfileGuildBossCfg", "level"},
    {"GuildShop",           "profiles/commonProfile/ProfileGuildshop",      "ID"}, 
    {"StarPrayShop",        "profiles/commonProfile/ProfileGoldStarPray",      "times"}, 
    {"ActivityPoint",       "profiles/commonProfile/ProfileActivepoint",      "ID"},     
    {"IconMap",             "profiles/commonProfile/ProfileIconMap",      "ID"}, 
    {"WorldEvent",          "profiles/commonProfile/ProfileWorldEvent",      "ID", {"eventName", "eventDes", "eventEndDes"}}, 
    {"EquipLevelRemove",    "profiles/commonProfile/ProfileEquipLevelRemoval",      "ID"}, 
    {"BattlePassReward",    "profiles/commonProfile/ProfileBattlePass",      "ID"}, 
    {"BattlePassShop",      "profiles/commonProfile/ProfileBattlePassShop",      "ID"}, 
    {"MasterReward",        "profiles/commonProfile/ProfileMasterreward",      "ID"}, 
    {"Festival",            "profiles/commonProfile/ProfileFestival",      "mapid"},
    {"FirstPassage",        "profiles/commonProfile/ProfileFirstPassage",      "GroupID"},
    {"GreedyOption",        "profiles/commonProfile/ProfileGreedyOption",      "ID"},
    {"GreedyGoods",         "profiles/commonProfile/ProfileGreedyGoods",      "ID"},
    {"GuildTech",           "profiles/commonProfile/ProfileGuildTech",      "ID", {"name", "description"}},
    {"PetData",             "profiles/commonProfile/ProfilePetTemplate",     "id", {"name", "description"}},
    {"PetTalent",           "profiles/commonProfile/ProfilePetTalent",       "talentID"},
    {"PetTreasure",         "profiles/commonProfile/ProfilePetTreasure",       "ID"},
    {"PetAdventure",         "profiles/commonProfile/ProfilePetAdventure",       "ID"},
    {"PetInitAttr",         "profiles/commonProfile/ProfilePetInitAttribute",   "initID"},
    {"PetGrowAttr",         "profiles/commonProfile/ProfilePetGrowAttribute",   "growID"},
    {"PetEXP",              "profiles/commonProfile/ProfilePetEXP",   "roleLV"},
    {"PetSite",             "profiles/commonProfile/ProfilePetSite",   "ID"},
    {"PetSkillPool",        "profiles/commonProfile/ProfilePetSkillPool",   "skillPoolID"},
    {"FastBuy",             "profiles/commonProfile/ProfileFastBuy",   "ID"},
    {"ClientHelp",          "profiles/dataProfile/ProfileClientHelp",   "ID"},  
    {"GuildWrit",           "profiles/commonProfile/ProfileGuildWrit",   "ID", {"name", "description"}},
    {"GAuctionPool",        "profiles/commonProfile/ProfileGuildAuctionPool",   "id"},
    {"RandomBag",           "profiles/commonProfile/ProfileRandomBag",   "ID"},
    {"DreamVault",          "profiles/commonProfile/ProfileDreamVault",   "ID", {"name"}},
    {"BuffSet",             "profiles/dataProfile/ProfileClientBuffSet",   "ID"},
    {"ExchangeShop",        "profiles/commonProfile/ProfileExchangeShop",   "ID"},
    {"PauseSence",          "profiles/dataProfile/ProfileClientPauseSence",   "ID"},
    {"PetShop",             "profiles/commonProfile/ProfilePetShop",   "ID"},
    {"RelicData",           "profiles/commonProfile/ProfileRelicTemplate",   "ID", {"name"}},
    {"RelicLevel",          "profiles/commonProfile/ProfileRelicLevelCfg",   "ID"},
    {"RelicAttr",           "profiles/commonProfile/ProfileRelicAttribute",   "ID"},
    {"TradeActivity",       "profiles/commonProfile/ProfileTradeActivity",   "ID", {"name", "description"}},
    {"AutoAttack",          "profiles/commonProfile/ProfileAutoAttack",   "ID", {"name", "description"}},
    {"TownMap",             "profiles/dataProfile/ProfileClientTownMap",   "ID"},
    {"ClientTownBtnUI",     "profiles/dataProfile/ProfileClientTownBtnUI",   "ID", {"name"}},
    {"MiracleLevelLimit",   "profiles/commonProfile/ProfileMiracleLevelLimit", "ID"},
    {"MiraclePrayer",       "profiles/commonProfile/ProfileMiraclePrayer", "ID"},
    {"MiraclePrayerIcon",   "profiles/commonProfile/ProfileMiraclePrayerIcon", "ID"},
    {"MiracleAttributes",   "profiles/commonProfile/ProfileMiracleAttributes", "ID"},
    {"MiracleCoefficient",  "profiles/commonProfile/ProfileMiracleCofficent", "ID"},
    {"LostRealm",           "profiles/commonProfile/ProfileLostRealm", "ID"},
    {"LostRealmReward",     "profiles/commonProfile/ProfileLostRealmReward", "ID"},
    {"PetEquipment",        "profiles/commonProfile/ProfilePetEquip", "ID", {"name", "description"}},
    {"MarblesFever",        "profiles/commonProfile/ProfileMarblesFever", "ID"},
    {"LimitedMarblesFever", "profiles/commonProfile/ProfileLimitedMarblesFever", "ID"},
    
    {"MarblesShop",         "profiles/commonProfile/ProfileMarblesShop", "ID"},
    {"LimitedMarblesShop",  "profiles/commonProfile/ProfileLimitedMarblesShop", "ID"},
    {"GhostAbyss",          "profiles/commonProfile/ProfileGhostAbyss", "ID", {"description","unlockdes"}},
    {"GhostAbyssShop",      "profiles/commonProfile/ProfileGhostAbyssShop", "ID"},
    {"QQGameGiftPack",      "profiles/commonProfile/ProfileTradeActivity", "ID"},
    -- {"FishShop",            "profiles/commonProfile/ProfileFishShop", "ID"},
    {"FishShop",            "profiles/commonProfile/ProfileManorShop", "ID"},
    {"Sail",                "profiles/commonProfile/ProfileSail", "ID"},
    {"DockControler",       "profiles/commonProfile/ProfileDockControler", "ID"},
    {"Barter",              "profiles/commonProfile/ProfileBarter", "barterMaterials"},
    {"CurseBuff",           "profiles/commonProfile/ProfileCurseBuff", "id"},
    {"MonthlySign",         "profiles/commonProfile/ProfilethirtyDaySignIn", "id"},
    {"CardSlot",            "profiles/commonProfile/ProfileCardSlot", "ID"},
    {"StarCard",            "profiles/commonProfile/ProfileStarCard", "ID"},
    {"StarMap",             "profiles/commonProfile/ProfileStarMap", "Id"},
    {"Desk",                "profiles/commonProfile/ProfileDesk", "ID"},
    {"UpgradeSlot",         "profiles/commonProfile/ProfileUpgradeSlot", "ID"},
    {"Boat",                "profiles/commonProfile/ProfileBoat", "ID"},
    {"OtherShape",          "profiles/commonProfile/ProfileOtherShape", "ID"},
    {"IllusionRack",          "profiles/commonProfile/ProfileIllusionRack", "ID"},
    {"ManorBuildUpgrade",   "profiles/commonProfile/ProfileManorBuildUpgrade", "ID"},
    {"Recipe",              "profiles/commonProfile/ProfileRecipe", "ID"},
    {"MannorShape",         "profiles/commonProfile/ProfileMannorShape", "ID"},
    {"MannorControler",     "profiles/commonProfile/ProfileMannorControler", "ID"},
    {"FullServerSchedule",     "profiles/commonProfile/ProfileFullServerSchedule", "ID"},
    {"TrialModel",          "profiles/commonProfile/ProfileTrialModel", "ID"},
    {"CombinatorialEntry",          "profiles/commonProfile/ProfileCombinatorialEntry", "ID"},
    {"TrialEntry",          "profiles/commonProfile/ProfileTrialEntry", "ID"},
    {"ActiveDuplication",          "profiles/commonProfile/ProfileActiveDuplication", "ID"},
    {"ParticipateSchedule",          "profiles/commonProfile/ProfileParticipateSchedule_1", "ID"},
    {"AnniversaryLuckyDraw",  "profiles/commonProfile/ProfileAnniversaryLuckyDraw", "ID"},
    {"ProfileIntegralShop", "profiles/commonProfile/ProfileIntegralShop", "ID"},
    {"ProfileGemstoneCave", "profiles/commonProfile/ProfileGemstoneCave", "caveLV"},
    {"TravelShop", "profiles/commonProfile/ProfileTravelShop", "ID"},
    {"MaterialClassification", "profiles/commonProfile/ProfileMaterialClassification", "ID"},
    {"PetGemstone", "profiles/commonProfile/ProfilePetGemstone", "ID"},
    {"GoodsTreasure", "profiles/commonProfile/ProfileTreasure", "ID"},
    {"EverwinterRift", "profiles/commonProfile/ProfileEverwinterRift", "copyLv"},
    {"RoleReincarnation", "profiles/commonProfile/ProfileRoleReincarnation", "roleReiLv"},
    {"ReincarnationDes", "profiles/dataProfile/ProfileClientReincarnationDes", "ID"},
    {"PetReincarnation", "profiles/commonProfile/ProfilePetReincarnation", "petReiLv"},
    {"CrystalTreasure", "profiles/commonProfile/ProfileCrystalTreasure", "ID"},
    {"CrystalTreasureShop", "profiles/commonProfile/ProfileCrystalTreasureShop", "ID"},
    {"StageRewards", "profiles/commonProfile/ProfileStageRewards", "ID"},
    {"PetReincarnationSkill", "profiles/commonProfile/ProfilePetReincarnationSkill", "changeSkillId"},
    {"MoldForging", "profiles/commonProfile/ProfileMoldForging", "id"},
    {"MoldToolbox", "profiles/commonProfile/ProfileMoldToolbox", "id"},
    {"CaveHunt", "profiles/commonProfile/ProfileCaveHunt", "ID"},
    {"NavigationGeneralConfig", "profiles/commonProfile/ProfileNavigationGeneralConfig", "id"},
    {"NavigationShop", "profiles/commonProfile/ProfileNavigationShop", "ID"},
    {"Islands", "profiles/commonProfile/ProfileIslands", "id"},
    {"NavigationTask", "profiles/commonProfile/ProfileNavigationTask", "ID"},
    {"YieldBonus", "profiles/commonProfile/ProfileYieldBonus", "id"},
    {"NavigationEvent", "profiles/commonProfile/ProfileNavigationEvent", "id"},
    {"NavigationBossGroup", "profiles/commonProfile/ProfileBossGroup", "id"},
    {"BasicAttribute", "profiles/commonProfile/ProfilebasicAttribute", "attrType"},
    {"BasicAttributeStrengthen", "profiles/commonProfile/ProfilebasicAttributeStrengthen", "attrType"},
    {"EquipRefineValue", "profiles/commonProfile/ProfileequipRefineValue", "attrType"},
    {"EquipRefineCost", "profiles/commonProfile/ProfileequipRefineCost", "attrType"},
    {"CombatScore", "profiles/commonProfile/ProfilecombatScore", "attrType"},
    {"PetSkin", "profiles/commonProfile/ProfilePetSkin", "id"},
    {"IslandMonster", "profiles/commonProfile/ProfileIslandMonster", "id"},
    {"NavigationShopLimitTime", "profiles/commonProfile/ProfileNavigationShopLimitTime", "ID"},
    {"FullServerGroupBuy", "profiles/commonProfile/ProfileFullServerGroupBuy", "id"},
    {"Glyph", "profiles/commonProfile/ProfileEquipmentGlyph", "ID"},
    {"GlyphAttribute", "profiles/commonProfile/ProfileGlyphAttribute", "attrType"},
    {"GlyphForging", "profiles/commonProfile/ProfileGlyphForging", "attrType"},
    {"WormholeDeep", "profiles/commonProfile/ProfileWormholeDeep", "copyLv"},
    {"MonstersSkin", "profiles/commonProfile/ProfilemonstersSkin", "ID"},
    {"NavigationRacingBoats", "profiles/commonProfile/ProfileNavigationRacingBoats", "id"},
    {"NavigationRacingEvent", "profiles/commonProfile/ProfileNavigationRacingEvent", "id"},
    {"StoneExchangeStore", "profiles/commonProfile/ProfileStoneExchangeStore", "ID"},
    {"StarPlate", "profiles/commonProfile/ProfileStarPlate", "id"},
    {"StarPlateUpgrade", "profiles/commonProfile/ProfileStarPlateUpgrade", "ID"},
    {"StarPattern", "profiles/commonProfile/ProfileStarPattern", "ID"},
    {"Souvenir", "profiles/commonProfile/ProfileSouvenir", "ID"},
    {"SouvenirAttr", "profiles/commonProfile/ProfileSouvenirAttr", "ID"},
    
}

local Manager = {}

--缓存角色配置文件
local cacheRoleConfigByType = nil
--缓存物品配置文件
local cacheGoodConfigByType = nil


function Manager:clear()
    Config.AudioConfig:clear()
    Config.BlackDialogConfig:clear()
    Config.Buffer:clear()
    Config.CatFoodConfig:clear()

    Config.CommentEventConfig:clear()
    Config.DropList:clear()
    Config.DungeonSeasonRewardConfig:clear()
    Config.Effect:clear()
    Config.FaceConfig:clear()

    Config.FunctionUnlockConfig:clear()
    Config.FunnyRecordConfig:clear()
    Config.General:clear()
    Config.ConfigGoods:clear()
    Config.ConfigGuild:clear()

    Config.GuildSkill:clear()
    Config.Loading:clear()
    Config.MonsterAffix:clear()
    Config.MapLevel:clear()

    Config.LocalSpine:clear()
    Config.Npc:clear()
    Config.PlotConfig:clear()
    Config.PlotEventConfig:clear()

    Config.Pond:clear()
    Config.QuickExpressionConfig:clear()
    Config.RandAttribute:clear()
    Config.ConfigRole:clear()
    Config.ShareConfig:clear()

    Config.Skill:clear()
    Config.SkillTree:clear()
    Config.Task:clear()
    Config.TreasuremapConfig:clear()
    Config.ServerList:clear()

    Config.StoryConfig:clear()
    Config.Weather:clear()
    Config.RandAttributeGroup:clear()
    Config.LevelSelectData:clear()
    Config.GemShopConfig:clear()
    Config.QuickChatConfig:clear()
    Config.GoldenMineConfig:clear()
    Config.GemFactoryConfig:clear()
    Config.HomeTaskConfig:clear()

    Config.MainTalentConfig:clear()
    Config.SubTalentConfig:clear()
    Config.GemChangeCostConfig:clear()
    Config.EquipStrengthenConfig:clear()

    Config.EquipIllusionConfig:clear()
    Config.EquipIllusionGroupConfig:clear()
    Config.DreamConfig:clear()
    Config.EquipConvert:clear()
    Config.DreamShop:clear()
    Config.DreamTaskConfig:clear()
    Config.EquipForge:clear()

    Config.HorcurxConfig:clear()

    Config.TargetConfig:clear()
    Config.TargetActivityConfig:clear()

    Config.GuildBox.clear()
    Config.GuildWish.clear()

    for k, v in ipairs(configTable) do
        reload_script_file(v)
    end

    for k, v in pairs(NewConfig) do
        v:clear()
    end
    NewConfig = {}
end

-- 初始化配置文件
function Manager:initConfig()
    -- TODO
    local generate = require "app.config.ConfigGenerate"
    for k, v in ipairs(newConfigList) do
        generate:generate(v[1], v[2], v[3], v[4])
    end
end

function Manager:getEquipStrengthenCost(equipLevel)
    return Config.EquipStrengthenConfig:getEquipStrengthenCost(equipLevel)
end
-- 获取英雄配置文件
function Manager:getHeroConfig(sex,roleLV)
    -- print("Manager:getHeroConfig  ",sex,roleLV)
    if roleLV <=0 then
        roleLV = 1
    end
    
    return ConfigRole:getHeroConfig(sex,roleLV)
end

--[[
    获取怪物配置文件
    monsterID:怪物ID
]]
function Manager:getMonsterConfig(monsterID, model, diffculty)

    return ConfigRole:getMonsterConfig(monsterID, model, diffculty)
end

--[[
    获取怪物配置文件
    changeID:怪物ID  更具changeID寻找变换之前的怪物数据
]]
function Manager:getMonsterConfigByChangeId(changeID, model, diffculty)
    return ConfigRole:getMonsterConfigByChangeId(changeID, model, diffculty)
end

function Manager:getMonsterModeAndDiffcultFromMonsterID(monsterID)

    return ConfigRole:getMonsterModeAndDiffcultFromMonsterID(monsterID)
end

function Manager:getMonsterListConfig(model,difficulty)
    return ConfigRole:getMonsterListConfig(model,difficulty)
end


function Manager:getEquipmentConfigByID(equipmentID)

    return Config.ConfigGoods:getEquipment(equipmentID)
end

function Manager:getAllEquipmentConfig()
    return Config.ConfigGoods:getAllEquipmentConfig()
end

function Manager:getGemStoneConfigByID(gemStoneID)

    return Config.ConfigGoods:getGemStone(gemStoneID)
end

function Manager:getAllGemStoneConfig()
    return Config.ConfigGoods:getAllGemStoneConfig(gemStoneID)
end

function Manager:getAllPetGemstoneConfig()
    return Config.ConfigGoods:getAllPetGemstoneConfig(gemStoneID)
end

function Manager:getPropConfigByID(propID)

    return Config.ConfigGoods:getProp(propID)
end

function Manager:getMaterialConfigByID(materialID)

    return Config.ConfigGoods:getMaterial(materialID)
end

--获取虚拟道具
function Manager:getVirtualItemConfigByID(materialID)
    return Config.ConfigGoods:getVirtualItem(materialID)
end

-- 获取堆叠数量
function Manager:getStackNumForTemplateID(templateID)
    return Config.ConfigGoods:getStackNumForTemplateID(templateID)
end

function Manager:getEquipmentRandAttrStrengthen(attrType)

    return Config.ConfigGoods:getEquipmentRandAttrStrengthen(attrType)
end

function Manager:getEquipmentSetBySetMark(equipSetMark)

    return Config.ConfigGoods:getEquipmentSet(equipSetMark)
end

function Manager:getAllEquipmentSetConfig()

    return Config.ConfigGoods:getAllEquipmentSetConfig()
end

function Manager:getSkillConfigById(skillID)

    return Config.Skill:getSkill(skillID)
end

function Manager:getAllSkillBlessing()

    return Config.Skill:getSkillBlessing()
end

function Manager:getSkillConfigByOccupation(occupation)

    return Config.Skill:getSkillConfigByOccupation(occupation)
end

function Manager:getRoleStatusForStatusTypeOrRoleType(statusType, roleType)
    return Config.Skill:getSkillStatusConfig(statusType, roleType)
end

--获取技能组数据
function Manager:getAllSkillTree(skillTreeModel)
    
    return Config.SkillTree:getAllSkillTree(skillTreeModel)
end

--通过技能组ID获取技能组数据
function Manager:getSkillTreeConfigById(skillTreeModel, skillGroupID)

    return Config.SkillTree:getSkillTree(skillTreeModel, skillGroupID)
end

--通过技能类型获取技能组数据
--[[ skillTreeModel:转职模式， skillTreeType：技能类型（大剑、坚盾、 法杖）， storey：排数， stage：阶段（一阶、二阶技能）]]
function Manager:getSkillTreeByType(skillTreeModel, skillTreeType, storey, stage)
    return Config.SkillTree:getSkillTreeByType(skillTreeModel, skillTreeType, storey, stage)
end


function Manager:getBufferConfigById(bufferID)
    return Config.Buffer:getBuffer(bufferID)
end

function Manager:getEffectConfigById(effectId)
    return Config.Effect:getEffect(effectId)
end

function Manager:getBoxConfigByBoxID(boxID)
    return Config.Npc:getBoxConfigByBoxID(boxID)
end

function Manager:getTriggerNpcConfigByID(ID)
    return Config.Npc:getTriggerConfigByID(ID)
end

function Manager:getBlackMarketByGroupID(groupID)
    return Config.Npc:getBlackMarketByGroupID(groupID)
end

function Manager:getFunctionNPCButtonByFunctionType(functionType)
    return Config.Npc:getClientFuntionButtonConfigByID(functionType)
end

function Manager:getMonsterAffixConfigByID(affixID)
    return Config.MonsterAffix:getAffix(affixID)
end

-- 根据等级获取大秘境
function Manager:getMonsterCoefficientConfigByLevel(level)
    return Config.MonsterAffix:getCoefficient(level)
end

function Manager:getInCaveShopConfigForLevel(caveModel, caveDiffculty, level)
    return Config.ConfigGoods:getInCaveShopConfigForLevel(caveModel, caveDiffculty, level)
end

function Manager:getDigSlotForRare(rare)
    return Config.ConfigGoods:getDigSlotForRare(rare)
end

-- 获取基础移动速度
function Manager:getMoveSpeed()
    return Config.General:getMoveSpeed()
end

-- 获取逃跑时间
function Manager:getGeneralEscapeTime()

    return Config.General:getEscapeTime()
end

-- 获取逃跑时间
function Manager:getPublicCDTime()
    -- add by zp 这里为了处理公共CD一样的情况下，客户端已经可以，但是在服务器出现没有冷却的情况
    return Config.General:getPublicCDTime() + 100
end

-- 获取钱袋ID
function Manager:getGoldBagID()
    return Config.General:getGoldBagID()
end

-- 获取钱袋spine 名字
function Manager:getGoldBagSpine()
    return Config.General:getGoldBagSpine()
end

-- 获取大秘境最大楼层
function Manager:getDungeonMaxLevel()
    return Config.General:getDungeonMaxLevel()
end

-- 根据key 获取变量值
function Manager:getGeneralForKey(key)
    return Config.General:getValueForKey(key)
end

function Manager:getBlackRefreshTime()
    return Config.General:getBlackShopRefreshTime()
end

function Manager:getRandomShopRefreshTime()
    return Config.General:getRandomShopRefreshTime()
end

function Manager:getFirstChargeReward()
    return Config.General:getValueForKey("firstChargeReward")
end

function Manager:getMonthCardReward()
    local value = Config.General:getValueForKey("monthCardReward")
    return tonumber(value)
end

function Manager:getMonthCardDaily()
    return tonumber(Config.General:getValueForKey("monthCarddaily"))
end

function Manager:getMonthCardBonus()
    return tonumber(Config.General:getValueForKey("monthCardBonus"))
end

function Manager:getLifeCardDaily()
    return tonumber(Config.General:getValueForKey("lifeCardBonus"))
end

function Manager:getLifeCardReward()
    return tonumber(Config.General:getValueForKey("lifeCardReward"))
end

-- 根据key 获取本地配置文件
function Manager:getLocalForKey(key)
    return Config.LocalSpine:getValueForKey(key)
end

-- 获取属性表数据
function Manager:getALLRandAttribute()
    return Config.RandAttribute:getAllRandAttribute()
end

--通过属性ID获取属性表
function Manager:getRandAttributeByID(id)
    return Config.RandAttribute:getRandAttributeByID(id)
end

-- 获取所有得主线任务
function Manager:getAllThreadTask()
    return Config.Task:getAllMainTask()
end

-- 获取所有英雄模式任务
function Manager:getAllCaveHeroTask()
    return Config.Task:getAllCaveHeroTask()
end

-- 获取所有环任务
function Manager:getAllCycleTask()
    return Config.Task:getAllCycleTask()
end

-- 获取所有扭曲空间任务
function Manager:getAllDistortedSpaceTask()
    return Config.Task:getAllDistortedSpaceTask()
end

-- 获取所有扭曲空间任务
function Manager:getAllInfernoTask()
    return Config.Task:getAllInfernoTask()
end

-- 获取所有虚空秘境任务
function Manager:getAllVoidRiftTask()
    return Config.Task:getAllVoidRiftTask()
end

-- 获取所有维京时代任务
function Manager:getAllViKingTask()
    return Config.Task:getAllViKingTask()
end

-- 获取所有维京时代任务
function Manager:getAllEverWinterTask()
    return Config.Task:getAllEverWinterTask()
end

-- 获取所有混沌虫洞任务
function Manager:getAllChaosTask()
    return Config.Task:getAllChaosTask()
end

-- 获取所有虫洞深处任务
function Manager:getAllWormholeTask()
    return Config.Task:getAllWormholeTask()
end

-- 根据分组来获取日常任务列表
function Manager:getDailyConfigForGroupID(groupID)
    return Config.Task:getTaskForGroupID(groupID)
end

-- 根据分组来获取公会任务
function Manager:getGuildConfigForGroupID(groupID)
    return Config.Task:getGuildTaskForGroupID(groupID)
end

-- 根据分组来获取限制每日任务
function Manager:getLimitDailyConfigForGroupID(groupID)
    return Config.Task:getLimitDailyConfigForGroupID(groupID)
end

-- 根据任务ID获取任务配置文件
function Manager:getTaskConfigForTaskID(taskID)
    return Config.Task:getTaskForID(taskID)
end

-- 根据剧情事件ID获取剧情事件数据
function Manager:getPlotEventForPlotEventID(plotEventID)
    return Config.PlotEventConfig:getPlotEventConfig(plotEventID)
end

-- 根据剧情ID获取剧情数据
function Manager:getPlotConfigForPlotID(plotID)
    return Config.PlotConfig:getPlotConfig(plotID)
end

-- 根据剧情ID获取剧情数据
function Manager:getAudioConfig(id)
    return Config.AudioConfig:getAudioConfig(id)
end


-- 根据藏宝图ID获取藏宝图数据
function Manager:getTreasuremapConfigByID(id)
    return Config.TreasuremapConfig:getTreasuremapConfig(id)
end

-- 根据藏宝图列表
function Manager:getTreasuremapConfigList()
    return Config.TreasuremapConfig:getTreasuremapList()
end

-- 根据碎片列表
function Manager:getFragmentConfigList()
    return Config.TreasuremapConfig:getFragmentList()
end

-- 根据藏宝图列表
function Manager:getFaceConfig(id)
    return Config.FaceConfig:getFaceConfig(id)
end

-- 根据藏宝图列表
function Manager:serializeFaceConfig()
    return Config.FaceConfig:serializeFaceConfig()
end

-- 获取所有猫饭列表
function Manager:getCaFoodConfig()
    return Config.CatFoodConfig:getCatFoodList()
end
-- 根据猫饭ID获取某个猫饭数据
function Manager:getCaFoodConfigByID(id)
    return Config.CatFoodConfig:getCatFoodConfigDataConfig(id)
end

-- 获取抽奖掉落数组
function Manager:getDropListConfig(dropListId)
    return Config.DropList:getDropListByDropListId(dropListId)
end

-- 获取抽奖掉落物品Id
function Manager:getPondById(pondId)
    return Config.Pond:getPondById(pondId)
end

-- 获取相关的地图配置信息
function Manager:getMapLevelConfig(level, caveMode, caveDiffculty)
    return Config.MapLevel:getMapLevelConfig(level, caveMode, caveDiffculty)
end

--获取所有 黑屏对话事件
function Manager:getAllBlackDialogEvent()
    return Config.BlackDialogConfig:getAllDialogEventConfig()
end

--获取所有 快捷表情数据
function Manager:getAllExpressionData()
    return Config.QuickExpressionConfig:getAllExpressionConfig()
end

-- 获取公会图标列表
function Manager:getGuildIconList()
    return Config.ConfigGuild:getAllIconList()
end

-- 获取公会成员列表
function Manager:getGuildMemberList()
    return Config.ConfigGuild:getAllMemberList()
end

-- 获取创建公会的钻石数量
function Manager:getDiamondForCreation()
    return Config.ConfigGuild:getDiamondForCreation()
end

-- 获取更改公会名字的钻石数量
function Manager:getDiamondForRename()
    return Config.ConfigGuild:getDiamondForRename()
end

-- 获取更改公会职级名称的钻石数量
function Manager:getDiamondForRenameTitle()
    return Config.ConfigGuild:getDiamondForRenameTitle()
end

-- 获取公会随机商店的数据
function Manager:getGuildRandomShopData()
    return Config.ConfigGuild:getGuildRandomShopData()
end

-- 获取对副会长来说的罢免开始时间
function Manager:getOverthrowOfflineDurationForCoLeader()
    return Config.ConfigGuild:getOverthrowOfflineDurationForCoLeader()
end

-- 获取对普通会员来说的罢免开始时间
function Manager:getOverthrowOfflineDurationForMemeber()
    return Config.ConfigGuild:getOverthrowOfflineDurationForMemeber()
end

-- 获取投票时间
function Manager:getOverthrowVoteDuration()
    return Config.ConfigGuild:getOverthrowVoteDuration()
end

-- 获取新会员多久过后可以投票罢免
function Manager:getOverthrowOpenTimeForNewMember()
    return Config.ConfigGuild:getOverthrowOpenTimeForNewMember()
end

-- 获取创建公会科技数据
function Manager:getGuildTechExp()
    return Config.ConfigGuild:getGuildTechExp()
end

-- 获取创建公会科技数据
function Manager:getGuildTechDesc()
    return Config.ConfigGuild:getGuildTechDesc()
end

function Manager:getGuildConfigForKey(key)
    return Config.ConfigGuild:getGuildConfigForKey(key)
end

-- 获取公会技能
function Manager:getAllGuildSkill()
    return Config.GuildSkill:getAllGuildSkill()
end

-- 获取公会技能
function Manager:getGuildSkill(guildSkillID)
    return Config.GuildSkill:getGuildSkill(guildSkillID)
end

-- 获取公会技能
function Manager:getGuildSkillByType(guildSkillType)
    return Config.GuildSkill:getGuildSkillByType(guildSkillType)
end

-- 获取限制列表
function Manager:getGuildEquipScore()
    return Config.ConfigGuild:getGuildEquipScore()
end

function Manager:getDungeonSeasonRewardById(seasonID)
    return Config.DungeonSeasonRewardConfig:getDungeonSeasonRewardById(seasonID)
end

-- 获取所有日常
function Manager:getAllActivityPointConfig()
    return NewConfig.ActivityPoint:getAllDatas()
end

-- 获取所有成就
function Manager:getAllAchievement()
    local list = NewConfig.Achievement:getAllDatas()
    for k, v in pairs(list) do
        -- 如果分享是关闭的
        if not CONFIG_SHARE then
            if checkint(v.type) == 16 then
                list[k] = nil
            end
        end
    end
    return list
end


-- 获取某一条成就
function Manager:getAchievement(id)
    return NewConfig.Achievement:getDataById(id)
end

function Manager:getShareConfigByType(moduleType,sdkType)
    return Config.ShareConfig:getShareConfigByType(moduleType,sdkType)
end
--根据 大秘境楼层ID   获取需要开启该楼层的秘境钥匙ID
function Manager:getDungeonKeyByLoftLv(loftLv)
    return Config.ConfigGoods:getDungeonKeyByLoftLv(loftLv)
end

-- 根据target获取服务器列表
function Manager:getServerListByTarget( target )
    return Config.ServerList:getServerListByTarget( target )
end
-- 根据服务器ID获取名字
function Manager:getServerName( ID )
    return Config.ServerList:getServerName(ID)
end

-- 获取所有趣味数据的点
function Manager:getAllFunnyRecord()
    return Config.FunnyRecordConfig:getAllFunnyRecord()
end



function Manager:getFunctionUnlockCfgData(functionType)
    return Config.FunctionUnlockConfig:getFunctionUnlockCfgData(functionType)
end

-- 获取加载页面小提示
function Manager:getLoadingTips()
    return Config.Loading:getAllConfig()
end

-- 新手引导数据
function Manager:getStoryConfigById(id)
    return Config.StoryConfig:getStoryStepConfig(id)
end


-- 新手引导数据
function Manager:getAllStoryConfig()
    return Config.StoryConfig:getAllStoryConfig()
end

-- npc 对话
function Manager:getNpcDialogConfigById(id)
    return NewConfig.NpcDialogConfig:getDataById(id)
end


--获取引导评论时间点
function Manager:getAllCommentEventCfg()
    return Config.CommentEventConfig:getAllEventConfig()
end

function Manager:getBindAccountInterval()
    return Config.General:getBindAccountInterval()
end

-- 获取濒死的血量比例
function Manager:getDangerousHPPercent()
    return Config.General:getDangerousHPPercent()
end

-- 获取创建公会最低等级
function Manager:getCreateGuildMinLevel()
    -- body
    return Config.ConfigGuild:getMinLevelCreation()
end

-- 获取公会箱子最大开箱数量
function Manager:getBoxNumLimit()
    return Config.ConfigGuild:getBoxNumLimit()
end

-- 获取新会员加入多久才能开箱
function Manager:getNewMemberBoxOpenLimitTime()
    return Config.ConfigGuild:getNewMemberBoxOpenLimitTime()
end

function Manager:getInitSkillGroupList()
    return Config.General:getInitSkillGroupList()
end

function Manager:getWeatherById(id)
    return Config.Weather:getWeatherById(id)
end

function Manager:getRandAttributeGroupByKey(key)
    return Config.RandAttributeGroup:getRandAttributeGroupByKey(key)
end

function Manager:getAllLevelSelectDataByType(lType)
    local list = Config.LevelSelectData:getAllLevelSelectData()
    local leveDatas = {}
    for k, v in ipairs(list) do
        if v.type == lType then
            table.insert(leveDatas, v)
        end
    end
    table.sort(leveDatas, function(a, b)
        return a.ID < b.ID
    end)
    return leveDatas
end

function Manager:getAllLevelSelectDataByTypeNormal(lType)
    local list = Config.LevelSelectData:getAllLevelSelectData()
    local leveDatas = {}
    for k, v in ipairs(list) do
        if v.type == lType and v.is_specialShow == 0 then
            table.insert(leveDatas, v)
        end
    end
    table.sort(leveDatas, function(a, b)
        return a.ID < b.ID
    end)
    return leveDatas
end

function Manager:getAllLevelSelectDataByTypeSpecial(lType)
    local list = Config.LevelSelectData:getAllLevelSelectData()
    local leveDatas = {}
    for k, v in ipairs(list) do
        if v.type == lType and v.is_specialShow == 1 then
            table.insert(leveDatas, v)
        end
    end
    table.sort(leveDatas, function(a, b)
        return a.ID < b.ID
    end)
    return leveDatas
end

function Manager:getHeroCaveNameByLevel(level, lType)
    local list = self:getAllLevelSelectDataByType(lType)
    for k, v in ipairs(list) do
        for k2, cfgLevel in ipairs(v.includeLevel) do
            if level == cfgLevel then
                return v.name
            end
        end
    end
    return ""
end

function Manager:getLevelSelectDataByLevel(level, lType)
    local list = self:getAllLevelSelectDataByType(lType)
    print("getLevelSelectDataByLevel", #list, level, lType)
    for k, v in ipairs(list) do
        print("getLevelSelectDataByLevel 2", v.includeLevel)
        for k2, cfgLevel in ipairs(v.includeLevel) do
            if level == cfgLevel then
                return v
            end
        end
    end
    return nil
end


function Manager:getAllGemStoneShopData()
    local list = Config.GemShopConfig:getAllGemStoneShopData()
    table.sort(list, function(a, b)
        return a.ID < b.ID
    end)
    return list
end

function Manager:getAllProfileGemStoneShopDataByID(ID)
    local list = Config.GemShopConfig:getAllGemStoneShopData()
    local data = nil

    for k,v in pairs(list) do
        if v.ID == ID then
            data = v
            break
        end
    end
    return data
end

function Manager:getCoastByLevel(level)
    return Config.GemChangeCostConfig:getCoastByLevel(level)
end
function Manager:getComposeCostByLevel(level)
    return Config.GemChangeCostConfig:getComposeCostByLevel(level)
end



function Manager:getAllQuickChatData()
    return Config.QuickChatConfig:getAllQuickChatData()
end

function Manager:getQuickChatDataById(id)
    return Config.QuickChatConfig:getQuickChatDataById(id)
end

function Manager:getAllSpecialEventData()
    return NewConfig.SpecialEventConfig:getAllDatas()
end

function Manager:getSpecialEventDataById(id)
    return NewConfig.SpecialEventConfig:getDataById(id)
end

function Manager:getScoreForEventList(list)
    local score = 0
    for k, v in pairs(list) do
        local data = self:getSpecialEventDataById(v)
        --dump(data)
        score = score + data.point
    end
    return score;
end

function Manager:getEventBoxLevel(list)
    local score = self:getScoreForEventList(list)
    local boxLevel = self:getEventBoxLevelByScore(score)
    return boxLevel
end

function Manager:getEventBoxLevelByScore(score)
    local config = Config.General:getValueForKey("modeHeroPointSegmentation")
    local scoreList = string.split(config, ";");
    local level = 1;
    for i = 2, #scoreList, 1 do
        local tmp = tonumber(scoreList[i])
        if score >= tmp then
            level = i - 1
        end
    end
    level = level > #Game.SpecialBoxImageName and #Game.SpecialBoxImageName or level
    level = level < 1 and 1 or level
    return level
end

-- 获取本地称号配置
function Manager:getTitleItem(id)
    return self:getVirtualItemConfigByID(id)
end

-- 获取金矿等级信息
function Manager:getGoldenMineConfigAtLevel(lv)
    if (lv > self:getGoldenMineConfigMaxLv()) then
        return
    end
    return Config.GoldenMineConfig:getAllGoldenMineConfig()[lv]
end

-- 获取金矿配置满级
function Manager:getGoldenMineConfigMaxLv()
    return #Config.GoldenMineConfig:getAllGoldenMineConfig()
end

-- 获取工坊等级信息
function Manager:getGemFactoryConfigAtLevel(lv)
    if (lv > self:getGemFactoryConfigMaxLv()) then
        return
    end
    return Config.GemFactoryConfig:getAllGemFactoryConfig()[lv]
end

-- 获取工坊配置满级
function Manager:getGemFactoryConfigMaxLv()
    return #Config.GemFactoryConfig:getAllGemFactoryConfig()
end

-- 获取家园任务组
function Manager:getHomeTaskFromID(id)
    return Config.HomeTaskConfig:getAllHomeTaskConfig()[id]
end

-- 获取人物天赋单个 主天赋
function Manager:getMainRoleTalentById(id)
    return Config.MainTalentConfig:getMainTalentDataById(id)
end

-- 获取人物天赋单个 子天赋
function Manager:getSubRoleTalentById(id)
    return Config.SubTalentConfig:getSubTalentById(id)
end

function Manager:getAllSubRoleTalent()
    return Config.SubTalentConfig:getAllSubTalentData()
end

--非副本的组队 只有一级限制时间 返回秒数
function Manager:getPunishmentTime()
    local list = string.split(ConfigManager:getGeneralForKey("punishmentTime"), ";")
    return checkint(list[1]) * 60
end

function Manager:getAllEquipIllusions()
    return Config.EquipIllusionConfig:getAllEquipIllusions()
end

function Manager:getEquipIllusionByID(id)
    return Config.EquipIllusionConfig:getEquipIllusionByID(id)
end

function Manager:getEquipIllusionGroupByID(id)
    return Config.EquipIllusionGroupConfig:getEquipIllusionGroupByID(id)
end

function Manager:getEquipIllusionGroupNameIDFromID(id)
    local illusionGroupConfig = self:getEquipIllusionGroupByID(id)
    if (not illusionGroupConfig) then return end
    return illusionGroupConfig.name
end

function Manager:getDreamConfigForLV(lv)
    return Config.DreamConfig:getDreamForLV(lv)
end

function Manager:getEquipConvert(id)
    return Config.EquipConvert:getEquipConvert(id)
end
function Manager:getAllEquipConvert()
    return Config.EquipConvert:getAllEquipConvert()
end
function Manager:getEquipIdByConvertEquipId(conventId)
    return Config.EquipConvert:getEquipIdByConvertEquipId(conventId)
end

function Manager:getDreamShopItem(level, index)
    return Config.DreamShop:getShopItem(level, index)
end

function Manager:getDreamTaskById(id)
    return Config.DreamTaskConfig:getDreamTaskById(id)
end

function Manager:getEquipForgeListByType(type)
    return Config.EquipForge:getEquipForgeListByType(type)
end

function Manager:getEquipRecastById(ID)
    return NewConfig.EquipRecastConfig:getDataById(ID)
end

function Manager:getEquipForgeConfigByID(id)
    return Config.EquipForge:getEquipForgeConfigByID(id)
end

function Manager:getHorcurxConfig()
    return Config.HorcurxConfig
end

function Manager:getStarPrayConfigByID(ID)
    return NewConfig.StarPray:getDataById(ID)
end

function Manager:getAllStarPray()
    return NewConfig.StarPray:getAllDatas()
end

function Manager:getPetGemstoneConfigByID(ID)
    return NewConfig.PetGemstone:getDataById(ID)
end

function Manager:getAllPetGemstone()
    return NewConfig.PetGemstone:getAllDatas()
end

function Manager:getGoodsTreasureConfigByID(ID)
    return NewConfig.GoodsTreasure:getDataById(ID)
end

function Manager:getAllGoodsTreasure()
    return NewConfig.GoodsTreasure:getAllDatas()
end

function Manager:getRelicConfig()
    return NewConfig.RelicData:getAllDatas()
end

function Manager:getRelicConfigByID(ID)
    return NewConfig.RelicData:getDataById(ID)
end

function Manager:getRelicLevelConfigByID(ID)
    return NewConfig.RelicLevel:getDataById(ID)
end

function Manager:getRelicAttrConfigByID(ID)
    return NewConfig.RelicAttr:getDataById(ID)
end

function Manager:getEquipLevelRemove(ID)
    return NewConfig.EquipLevelRemove:getDataById(ID)
end

function Manager:getPetEquipmentConfigByID(ID)
    return NewConfig.PetEquipment:getDataById(ID)
end

--[[
ID projectName                 描述                 回调地址
1  "cave_online_cn"            cn正式服          https://cavewebgm.leiting.com/cave-online-operation/advertisement/pangolin
2  "cave_online_cn_beta_test"  beta外网测试      http://cave2-all-sz-beta-player-0000.avalongames.cn/cave-online-operation/advertisement/pangolin
3  "cave_online_cn_pre_test"   cn内测专区        https://cavewebgmxf.leiting.com/cave-online-operation/advertisement/pangolin
4  "cave_online_cn_bilibili"   cnB站            https://cavewebgmbb.leiting.com/cave-online-operation/advertisement/pangolin
11 "cave_online_global"        global正式服      https://cave2-all-global-zs-player-0000.avalongames.com/cave-online-operation/advertisement/admob
12 "cave_online_global_test"   global外网测试    https://cave2-all-hk-cs-player-0000.avalongames.cn/cave-online-operation/advertisement/admob

新增：
5  "cave_online_cn_test"       外网cn测试         http://cave2-all-hk-cntest-player-0000.avalongames.cn/cave-online-operation/advertisement/pangolin
6  "cave_online_cn_pre"        外网cn预发布       https://cavewebgmtyzs.leiting.com/cave-online-operation/advertisement/pangolin
13 "cave_online_global_pre"    CO-GLOBAL预发布    https://cave2-all-global-pre-player-0000.avalongames.com/cave-online-operation/advertisement/admob

新增：
7  "cave_online_cn_review"           CN评审服务器         https://cavewebgmtf.leiting.com/cave-online-operation/advertisement/pangolin
14 "cave_online_global_review"       GLOBAL评审服务器     https://cave2-all-global-ps-gm-0000.avalongames.com/cave-online-operation/advertisement/admob
]]
function Manager:getAdsCodeId(placeId, deviceType, projectId)
    local device = nil
    if deviceType == "android" then
        device = 1
    elseif deviceType == "ios" then
        device = 2
    end

    local project = nil
    if projectId == "cave_online_cn" then
        project = 1
    elseif projectId == "cave_online_cn_beta_test" then
        project = 2
    elseif projectId == "cave_online_cn_pre_test" then
        project = 3
    elseif projectId == "cave_online_cn_bilibili" then
        project = 4
    elseif projectId == "cave_online_cn_test" then
        project = 5
    elseif projectId == "cave_online_cn_pre" then
        project = 6
    elseif projectId == "cave_online_cn_review" then
        project = 7
    elseif projectId == "cave_online_global" then
        project = 11
    elseif projectId == "cave_online_global_test" then
        project = 12
    elseif projectId == "cave_online_global_pre" then
        project = 13
    elseif projectId == "cave_online_global_review" then
        project = 14
    end
    
    local deviceTarget = cc.Application:getInstance():getTargetPlatform()
    
    if deviceTarget == cc.PLATFORM_OS_WINDOWS or deviceTarget == cc.PLATFORM_OS_MAC then
        project = 2
        device = 2
    elseif CONFIG_SHOW_DEBUG_PANEL then
        if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
            project = 11
        elseif CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
            project = 2
        else
            project = 5
        end
    end
    if device == nil or project == nil then
       printError("Manager:getAdsCodeId param is invild (placeId, projectId , deviceType) = ", placeId, projectId, deviceType)
       return
    end

    local list = NewConfig.Advert:getAllDatas()
    for k, v in ipairs(list) do
        if device == v.device and project == v.ser and placeId == v.func then
            return v
        end
    end
end

function Manager:getAllExpeditionConfig()
    local allConfig = NewConfig.Expedition:getAllDatas()

    return allConfig
end

function Manager:getExpeditionConfigByID(ID)
    return NewConfig.Expedition:getDataById(ID)
end

function Manager:getExpeditionConfigByCP(ID)
    local allConfig = NewConfig.Expedition:getAllDatas()
    local arr = {}
    if(allConfig) then 
        for k,v in pairs(allConfig) do 
            if(v.checkpoint == ID) then 
                table.insert(arr, v)
            end
        end
    end

    return arr
end

function Manager:getGuildBoxByID(ID)
    return Config.GuildBox:getGuildBox(ID)
end

function Manager:getGuildBossPoolByID(ID)
    return NewConfig.GuildBossPool:getDataById(ID)
end

function Manager:getGuildBossCfgByID(ID)
    return NewConfig.GuildBossCfg:getDataById(ID)
end

function Manager:getIconMapByID(ID)
    if(NewConfig.IconMap) then
        return NewConfig.IconMap:getDataById(ID)
    end 

    return nil
end

function Manager:getWorldEventByID(ID)
    if(NewConfig.WorldEvent) then
        return NewConfig.WorldEvent:getDataById(ID)
    end 

    return nil
end

function Manager:getAllMasterReward()
    if(NewConfig.MasterReward) then
        return NewConfig.MasterReward:getAllDatas()
    end

    return nil 
end

function Manager:getAllFestivalData()
    if(NewConfig.Festival) then
        return NewConfig.Festival:getAllDatas()
    end

    return nil 
end

function Manager:getFestivalDataForID(ID)
    if(NewConfig.Festival) then
        return NewConfig.Festival:getDataById(ID)
    end

    return nil
end

function Manager:getFirstPassageData(model, diff)
    local beginIdex = model * 1000000 + diff * 10000
    local endIdex = beginIdex + 10000
    local allList = NewConfig.FirstPassage:getAllDatas()
    local list = {}
    for k, v in pairs(allList) do
        if v.GroupID > beginIdex and v.GroupID < endIdex then
            v.level = v.GroupID - beginIdex
            table.insert(list, v)
        end
    end
    return list
end

function Manager:getGuildWishData()
    return Config.GuildWish:getCfgData()
end

function Manager:getAllGuildTech()
    return NewConfig.GuildTech:getAllDatas()
end

function Manager:getGuildTechForID(ID)
    return NewConfig.GuildTech:getDataById(ID)
end

function Manager:getGuildTechForID(ID)
    return NewConfig.GuildTech:getDataById(ID)
end

function Manager:getClientHelpForID(ID, subType)
    if(NewConfig.ClientHelp) then
        local list = NewConfig.ClientHelp:getAllDatas()
        subType = subType or -1
        for k, v in pairs(list) do
            if v.ID == ID and v.subtype == subType then
                return v
            end
        end
    end 
    return nil
end

function Manager:getAllPetTemplateData()
    return NewConfig.PetData:getAllDatas()
end

function Manager:getPetShopData()
    return NewConfig.PetShop:getAllDatas()
end

function Manager:getPetDataByID(tempId)
    return NewConfig.PetData:getDataById(tempId)
end

function Manager:getPetTalentByID(talentId)
    return NewConfig.PetTalent:getDataById(talentId)
end

function Manager:getPetTreasureByID(id)
    return NewConfig.PetTreasure:getDataById(id)
end

function Manager:getPetTreasureByRoleLv(roleLV)
    local list = NewConfig.PetTreasure:getAllDatas()
    if list[1].ID > roleLV then
        return list[1]
    elseif list[#list].ID < roleLV then
        return list[#list]
    else
        for k, v in ipairs(list) do
            if v.ID == roleLV then
                return v;
            end
        end
    end
end

function Manager:getAllPetAdvLevleSelectData()
    return NewConfig.PetAdventure:getAllDatas()
end

function Manager:getPetAdvLevleSelectDataById(id)
    return NewConfig.PetAdventure:getDataById(id)
end

function Manager:getPetInitAttrByID(id)
    return NewConfig.PetInitAttr:getDataById(id)
end

function Manager:getPetGrowAttrByID(id)
    return NewConfig.PetGrowAttr:getDataById(id)
end

function Manager:getPetSkillPoolByID(skillPoolID)
    return NewConfig.PetSkillPool:getDataById(skillPoolID)
end

function Manager:getPetExpByID(lv)
    return NewConfig.PetEXP:getDataById(lv)
end

function Manager:getPetSiteData()
    return NewConfig.PetSite:getAllDatas()
end

function Manager:getPetSiteByID(id)
    return NewConfig.PetSite:getDataById(id)
end

function Manager:getFastBuyByID(id)
    return NewConfig.FastBuy:getDataById(id)
end

function Manager:getGuildAuctionItemDataByID(id)
    return NewConfig.GAuctionPool:getDataById(id)
end

function Manager:getRandomBagByID(id)
    return NewConfig.RandomBag:getDataById(id)
end

--返回升级到下一级需要的经验
function Manager:getPetExpByLevel(level)
    level = level <= 1 and 1 or level
    local data = NewConfig.PetEXP:getDataById(level)
    if data == nil then
        return 0, true
    end
    return data.expToNextLV, false
end

function Manager:getAllBuffSet()
    return NewConfig.BuffSet:getAllDatas()
end

function Manager:getExchangeShop()
    return NewConfig.ExchangeShop:getAllDatas()
end

function Manager:getExchangeShopByID(ID)
    return NewConfig.ExchangeShop:getDataById(ID)
end

function Manager:getPauseSenceByID(ID) 
    return NewConfig.PauseSence:getDataById(ID)
end

function Manager:getTradeActivityData()
    return NewConfig.TradeActivity:getAllDatas()
end

function Manager:getTradeActivityDataByID(ID) 
    return NewConfig.TradeActivity:getDataById(ID)
end

function Manager:getAutoAttackDataByID(weaponID, order) 
    local autoAttackAllData = NewConfig.AutoAttack:getAllDatas()
    if(autoAttackAllData) then 
        for k,v in pairs(autoAttackAllData) do 
            if(v.weaponID == weaponID and v.order == order) then 
                return v
            end
        end
    end

    return nil
end

function Manager:getTownMapDataByID(ID) 
    return NewConfig.TownMap:getDataById(ID)
end
function Manager:getTownBtnData()
    return NewConfig.ClientTownBtnUI:getAllDatas()
end

function Manager:getTownBtnDataByID(ID)
    return NewConfig.ClientTownBtnUI:getDataById(ID)
end

function Manager:getAllMiracleLevelLimit()
    return NewConfig.MiracleLevelLimit:getAllDatas()
end

function Manager:getMiraclePrayerByID(ID)
    return NewConfig.MiraclePrayer:getDataById(ID)
end

function Manager:getAllMiraclePrayerIcon()
    return NewConfig.MiraclePrayerIcon:getAllDatas()
end

function Manager:getMiraclePrayerIconByID(ID)
    return NewConfig.MiraclePrayerIcon:getDataById(ID)
end

function Manager:getAllMiracleAttributes()
    return NewConfig.MiracleAttributes:getAllDatas()
end

function Manager:getMiracleAttributesByID(ID)
    return NewConfig.MiracleAttributes:getDataById(ID)
end

function Manager:getMiracleCoefficientByID(ID)
    return NewConfig.MiracleCoefficient:getDataById(ID)
end

function Manager:getLostRealmByID(ID)
    return NewConfig.LostRealm:getDataById(ID)
end

function Manager:getAllLostRealm()
    return NewConfig.LostRealm:getAllDatas()
end

function Manager:getAllLostRealmByID(ID)
    return NewConfig.LostRealm:getDataById(ID)
end

function Manager:getLostRealmRewardByID(ID)
    return NewConfig.LostRealmReward:getDataById(ID)
end

function Manager:getAllLostRealmReward()
    return NewConfig.LostRealmReward:getAllDatas()
end

function Manager:getAllMarblesFever()
    return NewConfig.MarblesFever:getAllDatas()
end

function Manager:getMarblesFeverByID(ID)
    return NewConfig.MarblesFever:getDataById(ID)
end

function Manager:getMarblesFeverLuckyPoint()
    return Config.General:getMarblesFeverLuckyPoint()
end

function Manager:getAllLimitedMarblesFever()
    return NewConfig.LimitedMarblesFever:getAllDatas()
end

function Manager:getLimitedMarblesFeverByID(ID)
    return NewConfig.LimitedMarblesFever:getDataById(ID)
end

function Manager:getMarblesLimitedFeverLuckyPoint()
    return Config.General:getMarblesLimitedFeverLuckyPoint()
end

function Manager:getDreamExchangeShopRefresh()
    return Config.General:getDreamExchangeShopRefresh()
end

function Manager:getBossPortalConfig()
    return Config.General:getBossPortalConfig()
end

function Manager:getAllMarblesShop()
    return NewConfig.MarblesShop:getAllDatas()
end

function Manager:getMarblesShopByID(ID)
    return NewConfig.MarblesShop:getDataById(ID)
end

function Manager:getAllLimitedMarblesShop()
    return NewConfig.LimitedMarblesShop:getAllDatas()
end

function Manager:getLimitedMarblesShopByID(ID)
    return NewConfig.LimitedMarblesShop:getDataById(ID)
end

function Manager:getAllGhostAbyss()
    return NewConfig.GhostAbyss:getAllDatas()
end

function Manager:getGhostAbyssByID(ID)
    return NewConfig.GhostAbyss:getDataById(ID)
end

function Manager:getAllGhostAbyssShop()
    return NewConfig.GhostAbyssShop:getAllDatas()
end 

function Manager:getAllQQGameGiftPackByID(ID)
    return NewConfig.QQGameGiftPack:getDataById(ID)
end

function Manager:getAllQQGameGiftPack()
    return NewConfig.QQGameGiftPack:getAllDatas()
end

function Manager:getAllFishShopDataByID(ID)
    return NewConfig.FishShop:getDataById(ID)
end

function Manager:getAllFishShopData()
    return NewConfig.FishShop:getAllDatas()
end

function Manager:getDailyFishingTime()
    return Config.General:getDailyFishingTime()
end

function Manager:getAllSailDataByID(ID)
    return NewConfig.Sail:getDataById(ID)
end

function Manager:getAllSailData()
    return NewConfig.Sail:getAllDatas()
end

function Manager:getAllDockDataByID(ID)
    return NewConfig.DockControler:getDataById(ID)
end

function Manager:getAllDockData()
    return NewConfig.DockControler:getAllDatas()
end

function Manager:getAllBarterDataByID(ID)
    return NewConfig.Barter:getDataById(ID)
end

function Manager:getAllBarterData()
    return NewConfig.Barter:getAllDatas()
end

function Manager:getAllCurseBuffData()
    return NewConfig.CurseBuff:getAllDatas()
end

function Manager:getAllCurseBuffDataByID(ID)
    return NewConfig.CurseBuff:getDataById(ID)
end

function Manager:getAllMonthlySignData()
    return NewConfig.MonthlySign:getAllDatas()
end

function Manager:getAllMonthlySignDataByID(ID)
    return NewConfig.MonthlySign:getDataById(ID)
end

function Manager:getAllBoatDataByID(ID)
    return NewConfig.Boat:getDataById(ID)
end

function Manager:getAllBoatData()
    return NewConfig.Boat:getAllDatas()
end

function Manager:getAllCardSlotData()
    return NewConfig.CardSlot:getAllDatas()
end

function Manager:getAllCardSlotDataByID(ID)
    return NewConfig.CardSlot:getDataById(ID)
end

function Manager:getAllStarCardData()
    return NewConfig.StarCard:getAllDatas()
end

function Manager:getAllStarCardDataByID(ID)
    return NewConfig.StarCard:getDataById(ID)
end

function Manager:getAllStarMapData()
    return NewConfig.StarMap:getAllDatas()
end

function Manager:getAllStarMapDataByID(ID)
    return NewConfig.StarMap:getDataById(ID)
end

function Manager:getAllDeskData()
    return NewConfig.Desk:getAllDatas()
end

function Manager:getAllDeskDataByID(ID)
    return NewConfig.Desk:getDataById(ID)
end

function Manager:getAllUpgradeSlotData()
    return NewConfig.UpgradeSlot:getAllDatas()
end

function Manager:getAllUpgradeSlotDataByID(ID)
    return NewConfig.UpgradeSlot:getDataById(ID)
end

function Manager:getAllOtherShapeDataByID(ID)
    return NewConfig.OtherShape:getDataById(ID)
end

function Manager:getAllOtherShapeData()
    return NewConfig.OtherShape:getAllDatas()
end

function Manager:getAllIllusionRackDataByID(ID)
    return NewConfig.IllusionRack:getDataById(ID)
end

function Manager:getAllIllusionRackData()
    return NewConfig.IllusionRack:getAllDatas()
end


function Manager:getAllBuildUpDataByID(ID)
    return NewConfig.ManorBuildUpgrade:getDataById(ID)
end

function Manager:getAllBuildUpData()
    return NewConfig.ManorBuildUpgrade:getAllDatas()
end

function Manager:getAllRecipeDataByID(ID)
    return NewConfig.Recipe:getDataById(ID)
end

function Manager:getAllRecipeData()
    return NewConfig.Recipe:getAllDatas()
end

function Manager:getAllMannorShapeDataByID(ID)
    return NewConfig.MannorShape:getDataById(ID)
end

function Manager:getAllMannorShapeData()
    return NewConfig.MannorShape:getAllDatas()
end

function Manager:getAllMannorControlerDataByID(ID)
    return NewConfig.MannorControler:getDataById(ID)
end

function Manager:getAllMannorControlerData()
    return NewConfig.MannorControler:getAllDatas()
end

function Manager:getAllFullServerScheduleDataByID(ID)
    return NewConfig.FullServerSchedule:getDataById(ID)
end

function Manager:getAllFullServerScheduleData()
    return NewConfig.FullServerSchedule:getAllDatas()
end

function Manager:getAllTrialModelDataByID(ID)
    return NewConfig.TrialModel:getDataById(ID)
end

function Manager:getAllTrialModelData()
    return NewConfig.TrialModel:getAllDatas()
end

function Manager:getAllCombinatorialEntryDataByID(ID)
    return NewConfig.CombinatorialEntry:getDataById(ID)
end

function Manager:getAllCombinatorialEntryData()
    return NewConfig.CombinatorialEntry:getAllDatas()
end

function Manager:getAllTrialEntryDataByID(ID)
    return NewConfig.TrialEntry:getDataById(ID)
end

function Manager:getAllTrialEntryData()
    return NewConfig.TrialEntry:getAllDatas()
end

function Manager:getAllParticipateScheduleDataByID(ID)
    return NewConfig.ParticipateSchedule:getDataById(ID)
end

function Manager:getAllParticipateScheduleData()
    return NewConfig.ParticipateSchedule:getAllDatas()
end

function Manager:getAllActiveDuplicationDataByID(ID)
    return NewConfig.ActiveDuplication:getDataById(ID)
end

function Manager:getAllActiveDuplicationData()
    return NewConfig.ActiveDuplication:getAllDatas()
end

function Manager:getAllAnniversaryLuckyDrawDataByID(ID)
    return NewConfig.AnniversaryLuckyDraw:getDataById(ID)
end

function Manager:getAllAnniversaryLuckyDrawData()
    return NewConfig.AnniversaryLuckyDraw:getAllDatas()
end

function Manager:getAllProfileIntegralShopDataByID(ID)
    return NewConfig.ProfileIntegralShop:getDataById(ID)
end

function Manager:getAllProfileIntegralShopData()
    return NewConfig.ProfileIntegralShop:getAllDatas()
end

function Manager:getAllProfileGemstoneCaveDataByID(ID)
    return NewConfig.ProfileGemstoneCave:getDataById(ID)
end

function Manager:getAllProfileGemstoneCaveData()
    return NewConfig.ProfileGemstoneCave:getAllDatas()
end

function Manager:getAllTravelShopDataByID(ID)
    return NewConfig.TravelShop:getDataById(ID)
end

function Manager:getAllTravelShopData()
    return NewConfig.TravelShop:getAllDatas()
end

function Manager:getAllMaterialClassificationDataByID(ID)
    return NewConfig.MaterialClassification:getDataById(ID)
end

function Manager:getAllMaterialClassificationData()
    return NewConfig.MaterialClassification:getAllDatas()
end

function Manager:getAllEverwinterRiftDataByID(ID)
    return NewConfig.EverwinterRift:getDataById(ID)
end

function Manager:getAllEverwinterRiftData()
    return NewConfig.EverwinterRift:getAllDatas()
end

function Manager:getAllRoleReincarnationDataByID(ID)
    return NewConfig.RoleReincarnation:getDataById(ID)
end

function Manager:getAllRoleReincarnationData()
    return NewConfig.RoleReincarnation:getAllDatas()
end

function Manager:getAllReincarnationDesDataByID(ID)
    return NewConfig.ReincarnationDes:getDataById(ID)
end

function Manager:getAllReincarnationDesData()
    return NewConfig.ReincarnationDes:getAllDatas()
end

function Manager:getAllPetReincarnationDataByID(ID)
    return NewConfig.PetReincarnation:getDataById(ID)
end

function Manager:getAllPetReincarnationData()
    return NewConfig.PetReincarnation:getAllDatas()
end

function Manager:getAllCrystalTreasureData()
    return NewConfig.CrystalTreasure:getAllDatas()
end

function Manager:getAllCrystalTreasureDataByID(ID)
    return NewConfig.CrystalTreasure:getDataById(ID)
end

function Manager:getCrystalLootConsumption()
    return Config.General:getCrystalLootConsumption()
end

function Manager:getAllCrystalTreasureShop()
    return NewConfig.CrystalTreasureShop:getAllDatas()
end

function Manager:getAllStageRewards()
    return NewConfig.StageRewards:getAllDatas()
end

function Manager:getAllPetReincarnationSkillData()
    return NewConfig.PetReincarnationSkill:getAllDatas()
end

function Manager:getPetReincarnationSkillDataByID(ID)
    return NewConfig.PetReincarnationSkill:getDataById(ID)
end

function Manager:getAllMoldForgingData()
    return NewConfig.MoldForging:getAllDatas()
end

function Manager:getAllMoldForgingDataByID(ID)
    return NewConfig.MoldForging:getDataById(ID)
end

function Manager:getAllMoldToolboxData()
    return NewConfig.MoldToolbox:getAllDatas()
end

function Manager:getAllMoldToolboxDataByID(ID)
    return NewConfig.MoldToolbox:getDataById(ID)
end

function Manager:getAllCaveHuntData()
    return NewConfig.CaveHunt:getAllDatas()
end

function Manager:getCaveHuntDataByID(ID)
    return NewConfig.CaveHunt:getDataById(ID)
end

function Manager:getAllNavigationGeneralConfigData()
    return NewConfig.NavigationGeneralConfig:getAllDatas()
end

function Manager:getNavigationGeneralConfigByID(ID)
    return NewConfig.NavigationGeneralConfig:getDataById(ID)
end

function Manager:getAllNavigationShopData()
    return NewConfig.NavigationShop:getAllDatas()
end

function Manager:getNavigationShopByID(ID)
    return NewConfig.NavigationShop:getDataById(ID)
end

function Manager:getAllIslandsData()
    return NewConfig.Islands:getAllDatas()
end

function Manager:getIslandsByID(ID)
    return NewConfig.Islands:getDataById(ID)
end

function Manager:getAllNavigationTaskData()
    return NewConfig.NavigationTask:getAllDatas()
end

function Manager:getNavigationTaskByID(ID)
    return NewConfig.NavigationTask:getDataById(ID)
end

function Manager:getAllYieldBonusData()
    return NewConfig.YieldBonus:getAllDatas()
end

function Manager:getYieldBonusByID(ID)
    return NewConfig.YieldBonus:getDataById(ID)
end

function Manager:getAllNavigationEventData()
    return NewConfig.NavigationEvent:getAllDatas()
end

function Manager:getNavigationEventByID(ID)
    return NewConfig.NavigationEvent:getDataById(ID)
end

function Manager:getAllNavigationBossGroupData()
    return NewConfig.NavigationBossGroup:getAllDatas()
end

function Manager:getNavigationBossGroupByID(ID)
    return NewConfig.NavigationBossGroup:getDataById(ID)
end

function Manager:getAllBasicAttributeData()
    return NewConfig.BasicAttribute:getAllDatas()
end

function Manager:getBasicAttributeByID(ID)
    return NewConfig.BasicAttribute:getDataById(ID)
end

function Manager:getAllBasicAttributeStrengthenData()
    return NewConfig.BasicAttributeStrengthen:getAllDatas()
end

function Manager:getBasicAttributeStrengthenByID(ID)
    return NewConfig.BasicAttributeStrengthen:getDataById(ID)
end

function Manager:getAllEquipRefineValueData()
    return NewConfig.EquipRefineValue:getAllDatas()
end

function Manager:getEquipRefineValueByID(ID)
    return NewConfig.EquipRefineValue:getDataById(ID)
end

function Manager:getAllEquipRefineCostData()
    return NewConfig.EquipRefineCost:getAllDatas()
end

function Manager:getEquipRefineCostByID(ID)
    return NewConfig.EquipRefineCost:getDataById(ID)
end

function Manager:getAllCombatScoreData()
    return NewConfig.CombatScore:getAllDatas()
end

function Manager:getCombatScoreByID(ID)
    return NewConfig.CombatScore:getDataById(ID)
end

function Manager:getExpPerNums()
    return Config.General:getExpPerNums()
end

function Manager:getAllPetSkinData()
    return NewConfig.PetSkin:getAllDatas()
end

function Manager:getPetSkinByID(ID)
    return NewConfig.PetSkin:getDataById(ID)
end

function Manager:getAllIslandMonsterData()
    return NewConfig.IslandMonster:getAllDatas()
end

function Manager:getIslandMonsterByID(ID)
    return NewConfig.IslandMonster:getDataById(ID)
end

function Manager:getNavigationShopLimitTimeAllData()
    return NewConfig.NavigationShopLimitTime:getAllDatas()
end

function Manager:getNavigationShopLimitTimeByID(ID)
    return NewConfig.NavigationShopLimitTime:getDataById(ID)
end

function Manager:getFullServerGroupBuyAllData()
    return NewConfig.FullServerGroupBuy:getAllDatas()
end

function Manager:getFullServerGroupBuyByID(ID)
    return NewConfig.FullServerGroupBuy:getDataById(ID)
end

function Manager:getGlyphAllData()
    return NewConfig.Glyph:getAllDatas()
end

function Manager:getGlyphByID(ID)
    return NewConfig.Glyph:getDataById(ID)
end

function Manager:getGlyphAttributeAllData()
    return NewConfig.GlyphAttribute:getAllDatas()
end

function Manager:getGlyphAttributeByID(ID)
    return NewConfig.GlyphAttribute:getDataById(ID)
end

function Manager:getGlyphForgingAllData()
    return NewConfig.GlyphForging:getAllDatas()
end

function Manager:getGlyphForgingByID(ID)
    return NewConfig.GlyphForging:getDataById(ID)
end

function Manager:getGlyphsRefinedCostConfig()
    return Config.General:getGlyphsRefinedCostConfig()
end

function Manager:getAllWormholeDeepDataByID(ID)
    return NewConfig.WormholeDeep:getDataById(ID)
end

function Manager:getAllWormholeDeepData()
    return NewConfig.WormholeDeep:getAllDatas()
end

function Manager:getAllMonstersSkinDataByID(ID)
    return NewConfig.MonstersSkin:getDataById(ID)
end

function Manager:getAllMonstersSkinData()
    return NewConfig.MonstersSkin:getAllDatas()
end

function Manager:getNavigationRacingBoatsDatayID(ID)
    return NewConfig.NavigationRacingBoats:getDataById(ID)
end

function Manager:getAllNavigationRacingBoatsData()
    return NewConfig.NavigationRacingBoats:getAllDatas()
end

function Manager:getAllNavigationRacingEventData()
    return NewConfig.NavigationRacingEvent:getAllDatas()
end

function Manager:getNavigationRacingEventDataByID(ID)
    return NewConfig.NavigationRacingEvent:getDataById(ID)
end

function Manager:getAllStoneExchangeStoreData()
    return NewConfig.StoneExchangeStore:getAllDatas()
end

function Manager:getStoneExchangeStoreDataByID(ID)
    return NewConfig.StoneExchangeStore:getDataById(ID)
end

function Manager:getAllStarPlateData()
    return NewConfig.StarPlate:getAllDatas()
end

function Manager:getStarPlateDataByID(ID)
    return NewConfig.StarPlate:getDataById(ID)
end

function Manager:getAllStarPlateUpgradeData()
    return NewConfig.StarPlateUpgrade:getAllDatas()
end

function Manager:getStarPlateUpgradeDataByID(ID)
    return NewConfig.StarPlateUpgrade:getDataById(ID)
end

function Manager:getAllStarPatternData()
    return NewConfig.StarPattern:getAllDatas()
end

function Manager:getStarPatternDataByID(ID)
    return NewConfig.StarPattern:getDataById(ID)
end

function Manager:getAllSouvenirData()
    return NewConfig.Souvenir:getAllDatas()
end

function Manager:getSouvenirDataByID(ID)
    return NewConfig.Souvenir:getDataById(ID)
end

function Manager:getAllSouvenirAttrData()
    return NewConfig.SouvenirAttr:getAllDatas()
end

function Manager:getSouvenirAttrDataByID(ID)
    return NewConfig.SouvenirAttr:getDataById(ID)
end




Config.Manager = Manager
ConfigManager = Config.Manager
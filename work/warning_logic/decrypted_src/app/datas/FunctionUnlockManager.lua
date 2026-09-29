-- FunctionUnlockManager.lua
-- Author:ydli
-- 2017年11月21日
-- Using:系统解锁 对MasterDataManager的辅助
local FunctionUnlockManager = class("FunctionUnlockManager")
Game = Game or {}
Game.FunctionUnlockManager = FunctionUnlockManager
require "cocos.cocos2d.json"
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")
local lockFlagsFile = "sysUnlockFlags.ud"
local newFlagFile = "sysNewFlag.ud"
--队列维护
local Queue = Avalon.Queue

function FunctionUnlockManager:ctor()

end

function FunctionUnlockManager:dtor()
    self._isFree = true
    self.isReadCache = false
    self._showUnlockActFlag = {}
    self._showNewFlag = {}
end

function FunctionUnlockManager:getInstance()
    if g_Manager == nil then
        g_Manager = FunctionUnlockManager.new()
        g_Manager:init()
    end
    return g_Manager
end

function FunctionUnlockManager:purgeInstance()
    if g_Manager ~= nil then
        g_Manager = nil
    end
end

function FunctionUnlockManager:init()
    print("FunctionUnlockManager:init")
    self._queue = Queue:create()
    self._isFree = true
    self.isReadCache = false
    self._showUnlockActFlag = {}
    self._showNewFlag = {}
end

function FunctionUnlockManager:clear()
    self:dtor()
    self:purgeInstance()
end

-- 回档（恢复）清理数据
function FunctionUnlockManager:restoreClear()
end

--清除解锁展示缓存
function FunctionUnlockManager:clearEventQueue()
    self._queue:reset()
end

--缓存功能解锁
function FunctionUnlockManager:addEvent(functionType)
    print("FunctionUnlockManager:addEvent  "..functionType)
    --todo  判断是否是默认开启
    local cfgData = ConfigManager:getFunctionUnlockCfgData(functionType)
    if cfgData == nil or cfgData.defaultType == 1 or cfgData.defaultType == 2 then --默认开启 不处理
        return
    end
    local data = {}
    data.functionType = functionType
    data.actionType = HIGH_TIP_ACTION_TYPE.FUNCTION_UNLOCK
    self._queue:push(data)

    self:addUnlockActFlag(functionType)
    self:addNewFlag(functionType)
    self:noticeShowAction()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_FUNCTION_UNLOCK, functionType)
    if functionType == PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave then
        TaskDataManager:triggerAcceptTask()
    end
    if functionType == PublicDefine.UnlockFunctionType.UnlockFunctionType_GemShopBuy or functionType == PublicDefine.UnlockFunctionType.UnlockFunctionType_Luckywheel then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    end
    if functionType == PublicDefine.UnlockFunctionType.UnlockFunctionType_Horcrux then
        local id = HorcurxDataManager:getHorcurxIllusionId() or 0
        if id > 0 then
            local MachineManager = require("app.game.MachineManager")
            local machine = MachineManager:getInstance():getMachine()
            if machine and machine:getModel() and machine:getModel():getMaster() and machine:getModel():getMaster():getId() then
                MachineManager:pushHorcruxShowOrHideCommand(machine:getModel():getMaster())
                -- local renderCommand = Command.RendererCommand:create(true)
                -- renderCommand:initHorcruxExterior(machine:getModel():getMaster():getId(),id)
                -- SceneManager:getInstance():pushCommand(renderCommand)
            end
        end
    end
end

--缓存存档点
function FunctionUnlockManager:addCheckPoint()
    print("FunctionUnlockManager:addCheckPoint")
    --todo  判断是否是默认开启
    local data = {}
    data.functionType = functionType
    data.actionType = HIGH_TIP_ACTION_TYPE.CHECK_POINT
    self._queue:push(data)
    self:noticeShowAction()
end

--缓存成就
function FunctionUnlockManager:addAchevement(id,icon,text)
    print("FunctionUnlockManager:addAchevement")
    --todo  判断是否是默认开启
    local data = {}
    data.id = id
    data.icon = icon
    data.text = text
    data.actionType = HIGH_TIP_ACTION_TYPE.ACHEVEMENT
    self._queue:push(data)
    self:noticeShowAction()
end

--缓存难度解锁
function FunctionUnlockManager:addLevelDifficulty(cave,cave_difficulty)
    print("FunctionUnlockManager:addLevelDifficulty")
    --todo  判断是否是默认开启
    local data = {}
    data.cave = cave
    data.cave_difficulty = cave_difficulty
    if data.cave_difficulty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2 then
        data.text = UI.TEXT_1150024
    elseif data.cave_difficulty == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then
        data.text = UI.TEXT_1150025
    else
        data.text = UI.TEXT_1150024
    end

    data.actionType = HIGH_TIP_ACTION_TYPE.UNLOCK_LEVEL_DIFFICULTY
    self._queue:push(data)
    self:noticeShowAction()
end

--玩家获得新称号
function FunctionUnlockManager:addHeroTitle(titleID)
    print("FunctionUnlockManager:addHeroTitle")
    --todo  判断是否是默认开启
    local data = {}
    data.titleID = titleID
    data.actionType = HIGH_TIP_ACTION_TYPE.HERO_TITLE_UNLOCK
    self._queue:push(data)
    self:noticeShowAction()
end


function FunctionUnlockManager:noticeShowAction()
    if SceneManager:getInstance():getIsInLoading() then
        return
    end
    if self._isFree then
        local data = self._queue:front()
        --全局 notice 
    if data ~= nil then
            self._isFree = false
            if data.actionType == HIGH_TIP_ACTION_TYPE.FUNCTION_UNLOCK then
                local unlockCfgData = ConfigManager:getFunctionUnlockCfgData(data.functionType)
                if unlockCfgData.name == 0 and unlockCfgData.icon == "" then
                    self._isFree = true
                    self:noticeShowAction()
                else
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_UNLOCK,unlockCfgData.icon,LanguageManager:getInstance():getLocalString(unlockCfgData.name))
                end
            elseif data.actionType == HIGH_TIP_ACTION_TYPE.CHECK_POINT then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_UNLOCK,nil,LanguageManager:getInstance():getLocalString(1110362))
            elseif data.actionType == HIGH_TIP_ACTION_TYPE.ACHEVEMENT then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_UNLOCK,data.icon,data.text)
            elseif data.actionType == HIGH_TIP_ACTION_TYPE.UNLOCK_LEVEL_DIFFICULTY then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_UNLOCK,nil,data.text)                
            elseif data.actionType == HIGH_TIP_ACTION_TYPE.HERO_TITLE_UNLOCK then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_UNLOCK,nil,nil,data)
            else
                self._isFree = true
                self:noticeShowAction()
            end
        end
    end
end

function FunctionUnlockManager:clearQueneLock()
    self._isFree = true
end

--是否播放解锁动画
function FunctionUnlockManager:isShowUnlockAction(functionType)
    if self._showUnlockActFlag[functionType] ~= nil then
        return true
    end
    return false
    -- return true
end

--移除播放解锁动画标记
function FunctionUnlockManager:removeUnlcokActFlag(functionType)
    if self._showUnlockActFlag[functionType] then
        self._showUnlockActFlag[functionType] = nil
        self:writeLockFlagList()
        Avalon.MessageCenter:notice(GameMessage.MC_UI_FUNCTION_UNLOCK)
    end
end

--添加解锁动画标记
function FunctionUnlockManager:addUnlockActFlag(functionType)
    self._showUnlockActFlag[functionType] = 1
    self:writeLockFlagList()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_FUNCTION_UNLOCK)
end

--是否播放new 动画
function FunctionUnlockManager:isShowNewAction(functionType)
    if self._showNewFlag[functionType] then
        return true
    end
    return false
end

--移除new动画标记
function FunctionUnlockManager:removeNewFlag(functionType)
    if self._showNewFlag[functionType] then
        self._showNewFlag[functionType] = nil
        self:writeNewFlagList()
        -- dump(self._showNewFlag, "------removeNewFlag functionType = "..functionType)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_FUNCTION_UNLOCK)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_FUNCTION_REMOVE_NEW, functionType)
    end
end

function FunctionUnlockManager:addNewFlag(functionType)
    self._showNewFlag[functionType] = 1
    self:writeNewFlagList()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_FUNCTION_UNLOCK)
end

--
function FunctionUnlockManager:writeLockFlagList()
    Avalon.FileManager:saveMapDataToLocal(self._showUnlockActFlag, lockFlagsFile, true)
end

function FunctionUnlockManager:readLockFlagList()
    self._showUnlockActFlag = Avalon.FileManager:readMapDataFromLocal(lockFlagsFile, true)
end

function FunctionUnlockManager:writeNewFlagList()
    Avalon.FileManager:saveMapDataToLocal(self._showNewFlag, newFlagFile, true)
end

function FunctionUnlockManager:readNewFlagList()
    self._showNewFlag = Avalon.FileManager:readMapDataFromLocal(newFlagFile, true)
end

function FunctionUnlockManager:loadLocalFile()
    if self.isReadCache then
        return
    end
    self.isReadCache = true
    self:readLockFlagList()
    self:readNewFlagList()
end

function FunctionUnlockManager:showLockTips(functionType, caveMode)
    local CONDITION_TYPE = PublicDefine.FunctionUnlockConditionType 
    local cfgData = ConfigManager:getFunctionUnlockCfgData(functionType)
    if cfgData == nil or cfgData.type == nil or #cfgData.type == 0 then --默认开启 不处理
        UI.ScrollBar:createByText(UI.TEXT_1170901)
        return
    end
    local tips = UI.TEXT_1170902 
    for key, conditionType in ipairs(cfgData.type) do
        local conditionValue = tonumber(cfgData.value[key])
        local conditionTip = ""
        if conditionType == CONDITION_TYPE.FunctionUnlockConditionType_Lv then --系统解锁条件-等级解锁
            conditionTip = string.format(UI.TEXT_1170903, conditionValue).." "
        elseif conditionType == CONDITION_TYPE.FunctionUnlockConditionType_CheckPoint then --系统解锁条件-关卡解锁
            local level = conditionValue % 10000
            conditionValue = math.floor(conditionValue / 10000)

            local diffculty = conditionValue % 100
            conditionValue = math.floor(conditionValue / 100)

            local mode = conditionValue
            if caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
                mode = caveMode
            end
            -- local levelName = ToolsUtil:getModeName(mode)..ToolsUtil:getDiffcultName(diffculty)..UI.TEXT_1170906
            local levelName = ToolsUtil:getModeName(mode)
            local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
            level = LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(level)
            conditionTip = string.format(UI.TEXT_1170905, levelName, level).." "
        elseif conditionType == CONDITION_TYPE.FunctionUnlockConditionType_Task then --系统解锁条件-任务解锁
            local taskData = Data.TaskData:create(task.taskID)
            conditionTip = string.format(UI.TEXT_1170904, taskData:getDescription()).." "
        elseif conditionType == CONDITION_TYPE.FunctionUnlockConditionType_Killing then
            local monsterId = conditionValue % 100000000
            local monsterConfig = ConfigManager:getMonsterConfig(monsterId)
            conditionTip = string.format(UI.TEXT_1212215, LanguageManager:getInstance():getLocalString(monsterConfig.name))
        end
        tips = tips..conditionTip
    end
    UI.ScrollBar:createByText(tips)
end

--检查npc function  如果未解锁移除
function FunctionUnlockManager:checkNpcFunction(functionArry)
    local newFunctionArry = {}
    for k, npcType in pairs(functionArry) do
        local lockType = self:npcTypeToLockType(npcType)
        if lockType == nil then
            table.insert(newFunctionArry, npcType)
        elseif RoleDataManager:isUnlockByFunctionType(lockType) then
            table.insert(newFunctionArry, npcType)
        end
    end
    return newFunctionArry
end

--返回小地图 是否播放动画：（如果有功能解锁 且 new 返回true）
function FunctionUnlockManager:isShowMiniMapAction(functionArry)
    local newFunctionArry = {}
    for k, npcType in pairs(functionArry) do
        local lockType = self:npcTypeToLockType(npcType)
        if RoleDataManager:isUnlockByFunctionType(lockType) and self:isShowNewAction(lockType) then
            return true
        end
    end
    return false
end

function FunctionUnlockManager:isUnlockByNpcLockType(npcFuncType)
    local lockType = self:npcTypeToLockType(npcFuncType)
    if lockType == nil then
        return true
    end
    if RoleDataManager:isUnlockByFunctionType(lockType) then
        return true
    end
    return false
end

--npc 的 功能类型  和 打点的功能类型的 映射
function FunctionUnlockManager:npcTypeToLockType(npcType)
    local npcFuncType = PublicDefine.FUNCTION_TYPE
    local lockFuncType = PublicDefine.UnlockFunctionType
    local lockType = nil
    if npcType == npcFuncType.EXCHANGE_IN_CAVE then-- 洞内交易
    elseif npcType == npcFuncType.GOLD_TOUCH then -- 点金
    elseif npcType == npcFuncType.ENCHANT then-- 附魔
        lockType = lockFuncType.UnlockFunctionType_Enchant
    elseif npcType == npcFuncType.EXCHANGE_IN_TOWN then -- 城镇交易
    elseif npcType == npcFuncType.BLACK_MARKET then-- 黑市交易
        lockType = lockFuncType.UnlockFunctionType_BlackMarket
    elseif npcType == npcFuncType.RANDOMSHOPUNLOCK then  -- 随机商店
        lockType = lockFuncType.UnlockFunctionType_RandomShop
    elseif npcType == npcFuncType.SELL_GOODS then
    elseif npcType == npcFuncType.MAILBOX then-- 邮箱
        lockType = lockFuncType.UnlockFunctionType_Mail
    elseif npcType == npcFuncType.GENERAL_ENTRANCE then-- 普通入口
        lockType = lockFuncType.UnlockFunctionType_Cave
    elseif npcType == npcFuncType.SPECIFIC_ENTRANCE then-- 特殊入口
        lockType = lockFuncType.UnlockFunctionType_Dungeon
    elseif npcType == npcFuncType.TASK then-- 任务
        lockType = lockFuncType.UnlockFunctionType_Task
    elseif npcType == npcFuncType.ACHIEVEMENT then-- 成就
        lockType = lockFuncType.UnlockFunctionType_Achievement
    elseif npcType == npcFuncType.LEADERBOARD then-- 排行榜
        lockType = lockFuncType.UnlockFunctionType_Rangking
    elseif npcType == npcFuncType.WAREHOUSE then -- 仓库
        lockType = lockFuncType.UnlockFunctionType_Warehouse
    elseif npcType == npcFuncType.GUILD_ENTRANCE then-- 公会入口
        lockType = lockFuncType.UnlockFunctionType_Guild
    elseif npcType == npcFuncType.SPEAKER then -- 话痨（说话的NPC）
    elseif npcType == npcFuncType.EQUIPMENT_STRENGTHEN then -- 装备强化
        lockType = lockFuncType.UnlockFunctionType_Strengthen
    elseif npcType == npcFuncType.PET_EQUIPMENT_STRENGTHEN then -- 宠物装备强化
        lockType = lockFuncType.UnlockFunctionType_PetStrengthen
    elseif npcType == npcFuncType.EQUIPMENT_REMODEL then-- 装备改造
        lockType = lockFuncType.UnlockFunctionType_Remodel
    elseif npcType == npcFuncType.CAT_FOOD then-- 猫饭
        lockType = lockFuncType.UnlockFunctionType_Catfood
    elseif npcType == npcFuncType.EQUIPMENT_DECOMPOSE then -- 装备分解
        lockType = lockFuncType.UnlockFunctionType_Decompose
    elseif npcType == npcFuncType.EQUIPMENT_FORGE then-- 装备锻造
        lockType = lockFuncType.UnlockFunctionType_Forge
    elseif npcType == npcFuncType.FACELIFT then-- 捏脸
        lockType = lockFuncType.UnlockFunctionType_Facelift
    elseif npcType == npcFuncType.LUCKYWHEEL_TURN then-- 转盘抽奖
        lockType = lockFuncType.UnlockFunctionType_Luckywheel
    elseif npcType == npcFuncType.GUILD_TASK then-- 公会任务
        lockType = lockFuncType.UnlockFunctionType_Guild
    elseif npcType == npcFuncType.GUILD_TECH then-- 公会科技
        lockType = lockFuncType.UnlockFunctionType_Guild
    elseif npcType == npcFuncType.GUILD_MANAGER then-- 公会管理员
        lockType = lockFuncType.UnlockFunctionType_Guild
    elseif npcType == npcFuncType.GUILD_MARKET then-- 公会商人
        lockType = lockFuncType.UnlockFunctionType_GuildShop
    elseif npcType == npcFuncType.DUNGEON_SEASON_REWARD then--大秘境赛季奖励
        lockType = lockFuncType.UnlockFunctionType_Dungeon
    elseif npcType == Game.TREASURE_FUNCTION_TYPE then
        lockType = lockFuncType.UnlockFunctionType_TreasureMap 
    elseif npcType == npcFuncType.ACTIVITY then
        lockType = lockFuncType.UnlockFunctionType_Activity
    elseif npcType == npcFuncType.GEMSTONE_INLAID then-- 宝石镶嵌
        lockType = lockFuncType.UnlockFunctionType_GemSlot
    elseif npcType == npcFuncType.GEMSTONE_COMPOSE then-- 宝石合成
        lockType = lockFuncType.UnlockFunctionType_GemSynthesis    
    elseif npcType == npcFuncType.FUNCTION_GEMCONNECT then-- 符文连接
        lockType = lockFuncType.UnlockFunctionType_GemConnect
    elseif npcType == npcFuncType.FUNCTION_GEMDECOMPOSE then-- 符文分解
        lockType = lockFuncType.UnlockFunctionType_GemDecompose
    elseif npcType == npcFuncType.GEMSTONE_TRANSFORM then-- 宝石转化
        lockType = lockFuncType.UnlockFunctionType_GemTransform   
    elseif npcType == npcFuncType.GEMSTONE_BUY then-- 宝石购买
        lockType = lockFuncType.UnlockFunctionType_GemShopBuy 
    elseif npcType == npcFuncType.HOME_SYSTEM_MINE then-- 家园系统 金矿
        lockType = lockFuncType.UnlockFunctionType_GoldenMine 
    elseif npcType == npcFuncType.HOME_SYSTEM_GEM then-- 家园系统 符文石
        lockType = lockFuncType.UnlockFunctionType_GemFactory
    elseif npcType == npcFuncType.SKILL_ADVANCED then-- 职业进阶
        lockType = lockFuncType.UnlockFunctionType_OccupationAdvanced
    elseif npcType == npcFuncType.EQUIPMENT_ILLUSION then-- 装备幻化
        lockType = lockFuncType.UnlockFunctionType_EquipmentIllusion
    elseif npcType == npcFuncType.FUNCTION_TYPE_DREAM then-- 梦境试验
        lockType = lockFuncType.UnlockFunctionType_Dream
    elseif npcType == npcFuncType.EQUIP_CONVERT then-- 装备转换
        lockType = lockFuncType.UnlockFunctionType_EquipConvert
    elseif npcType == npcFuncType.FUNCITON_TYPE_DREAM_TASK then-- 梦境任务
        lockType = lockFuncType.UnlockFunctionType_DreamTask
    elseif npcType == npcFuncType.DREAMSHOP then-- 梦境商店
        lockType = lockFuncType.UnlockFunctionType_DreamShop
    elseif npcType == npcFuncType.EQUIP_RECAST then  --装备重铸
        lockType = lockFuncType.UnlockFunctionType_EquipRecast
    elseif npcType == npcFuncType.FUNCTION_TYPE_STARPRAY_GET then --星痕抽奖
        lockType = lockFuncType.UnlockFunctionType_StarPray
    elseif npcType == npcFuncType.EQUIP_REFINE then 
        lockType = lockFuncType.UnlockFunctionType_EquipRefine
    elseif npcType == npcFuncType.EQUIP_SET_CHANGE then
        lockType = lockFuncType.UnlockFunctionType_EquipSuitTransform
    elseif npcType == npcFuncType.FUNCTION_TYPE_STARPRAY_EQUIP then --星痕装配+吞噬
        lockType = lockFuncType.UnlockFunctionType_StarPray
    elseif npcType == npcFuncType.FUNCTION_TYPE_EXPEDITION then  -- 探险队
        lockType = lockFuncType.UnlockFunctionType_Expedition
    elseif npcType == npcFuncType.FUNCTION_TYPE_GUILDSHOP then  -- 公会商店
    elseif npcType == npcFuncType.FUNCTION_TYPE_GUILDBOSS then  -- 公会boss
        lockType = lockFuncType.UnlockFunctionType_GuildBoss
    elseif npcType == npcFuncType.DESERT_EYE then  -- 沙之眼
        lockType = lockFuncType.UnlockFunctionType_DesertEye
    elseif npcType == npcFuncType.DISTORTED_SPACE then  -- 扭曲空间
        lockType = lockFuncType.UnlockFunctionType_DistortedSpace
    elseif npcType == npcFuncType.EQUIP_LEVEL_REMOVE then  -- 装备等级移除
        lockType = lockFuncType.UnlockFunctionType_EquipLevelRemove
    elseif npcType == npcFuncType.APPRENTICESHIP then       -- 师徒系统
        lockType = lockFuncType.UnlockFunctionType_Apprenticeship
    elseif npcType == npcFuncType.FUNCTION_TYPE_FESTIVAL then       -- 节日活动系统
        lockType = lockFuncType.UnlockFunctionType_Festival
    elseif npcType == npcFuncType.FUNCTION_TYPE_PETTREASURE then       -- 宠物宝藏收集
        lockType = lockFuncType.UnlockFunctionType_PetTreasureCollection
    elseif npcType == npcFuncType.FUNCTION_TYPE_FESTIVAL_EXCHANGE_SHOP then  -- 节日活动兑换商店
        lockType = lockFuncType.UnlockFunctionType_FestivalExchangeShop
    elseif npcType == npcFuncType.FUNCTION_TYPE_PETRECYCLINGSHOP then       -- 宠物回收商店
        lockType = lockFuncType.UnlockFunctionType_PetRecyclingShop
    elseif npcType == npcFuncType.FUNCTION_TYPE_PETDEVELOP then -- 宠物成长
        lockType = lockFuncType.UnlockFunctionType_PetDevelop
    elseif npcType == npcFuncType.FUNCTION_TYPE_HOME then -- 家园
        lockType = lockFuncType.UnlockFunctionType_Home
    elseif npcType == npcFuncType.FUNCTION_INFERNO then -- 深红炼狱
        lockType = lockFuncType.UnlockFunctionType_Inferno
    elseif npcType == npcFuncType.FUNCTION_GHOST_LEVELSELECT then -- 幽林深渊
        lockType = lockFuncType.UnlockFunctionType_GhostAbyss
    elseif npcType == npcFuncType.FUNCTION_GHOST_SHOP then -- 幽林深渊 商店  
        lockType = lockFuncType.UnlockFunctionType_GhostAbyss
    elseif npcType == npcFuncType.FUNCTION_PET_ADVENTURE then -- 宠物冒险 
        lockType = lockFuncType.UnlockFunctionType_PetAdventure
    elseif npcType == npcFuncType.FUNCTION_GHOST_ABYSS_TOTEM then -- 幽灵深渊：初始图腾
    elseif npcType == npcFuncType.FUNCTION_GHOST_ABYSS_ACTIVATED_TOTEM then -- 幽灵深渊：被激活图腾
    elseif npcType == npcFuncType.FUNCTION_BOSS_PORTAL then -- Boss直达
        lockType = lockFuncType.UnlockFunctionType_BossDirect
    elseif npcType == npcFuncType.FUNCTION_MANOR_PORTAL 
            or npcType == npcFuncType.FUNCTION_TRAVELING_BUSINESSMAN
            or npcType == npcFuncType.FUNCTION_MANOR_HOUSEKEEPER
            or npcType == npcFuncType.FUNCTION_MANOR_DESK
            or npcType == npcFuncType.FUNCTION_MANOR_BOAT
            or npcType == npcFuncType.FUNCTION_MANOR_DRESS_UP_SHELF
            or npcType == npcFuncType.FUNCTION_FISH_SHOP
            or npcType == npcFuncType.FUNCTION_MANOR_DININGTABLE then --庄园入口
        lockType = lockFuncType.UnlockFunctionType_Manor
    elseif npcType == npcFuncType.FUNCTION_VOID_RIFT then -- 虚空秘境
        lockType = lockFuncType.UnlockFunctionType_VoidRift
    elseif npcType == npcFuncType.FUNCTION_SUIT_TRANSFORMATION then -- 套装改造
        lockType = lockFuncType.UnlockFunctionType_Manor_Suit_Transformation
    elseif npcType == npcFuncType.FUNCTION_TYPE_PET_POKEDEX then -- 宠物图鉴
        lockType = lockFuncType.UnlockFunctionType_Pokedex
    elseif npcType == npcFuncType.FUNCTION_VIKING then -- 宠物图鉴
        lockType = lockFuncType.UnlockFunctionType_Viking
    elseif npcType == npcFuncType.FUNCTION_PET_STONE then -- 宠物宝石
        lockType = lockFuncType.UnlockFunctionType_PetEquipmentUpgrade
    elseif npcType == npcFuncType.FUNCTION_TREASURE_IDENTIFY then -- 宝物鉴定
        lockType = lockFuncType.UnlockFunctionType_IdentifyTreasureItem
    elseif npcType == npcFuncType.FUNCTION_EVER_WINTER then -- 永冬裂缝
        lockType = lockFuncType.UnlockFunctionType_EverWinterRift
    elseif npcType == npcFuncType.FUNCTION_REINCARNATION then -- 角色转生
        lockType = lockFuncType.UnlockFunctionType_Reincarnation
    elseif npcType == npcFuncType.FUNCTION_MOLDFORING then -- 模具锻造
        lockType = lockFuncType.UnlockFunctionType_Mold
    elseif npcType == npcFuncType.FUNCTION_MOLDUSE then -- 模具使用
        lockType = lockFuncType.UnlockFunctionType_Mold
    elseif npcType == npcFuncType.FUNCTION_NAVIGATION_STORE then -- 大航海商人
        lockType = lockFuncType.UnlockFunctionType_NAVIGATION_STORE
    elseif npcType == npcFuncType.FUNCTION_NAVIGATION_TASK then -- 大航海任务
        lockType = lockFuncType.UnlockFunctionType_NAVIGATION_TASK
    elseif npcType == npcFuncType.FUNCTION_NAVIGATION_SUPPLY then -- 大航海码头
        lockType = lockFuncType.UnlockFunctionType_Invalid
    elseif npcType == npcFuncType.FUNCTION_CHAOS then -- 混沌虫洞
        lockType = lockFuncType.UnlockFunctionType_CHAOS
    elseif npcType == npcFuncType.FUNCTION_GLYPH then -- 雕纹
        lockType = lockFuncType.UnlockFunctionType_Glyph
    elseif npcType == npcFuncType.FUNCTION_WORMHOLE then -- 虫洞深处
        lockType = lockFuncType.UnlockFunctionType_Wromhole
    elseif npcType == npcFuncType.FUNCTION_CHANGEPURPLE then -- 紫升红
        lockType = lockFuncType.UnlockFunctionType_EquipUpgrade
    elseif npcType == npcFuncType.FUNCTION_BET
        or npcType == npcFuncType.FUNCTION_RALLYGAME then -- 拉力赛
        lockType = lockFuncType.UnlockFunctionType_Bet
    else
        printError("FunctionUnlockManager:checkNpcFunction unknow npcType ==> "..npcType)
    end
    return lockType
end

--
function FunctionUnlockManager:lockTypeToNPCFuncType(lockType)
    local npcFuncType = PublicDefine.FUNCTION_TYPE
    local lockFuncType = PublicDefine.UnlockFunctionType 
    local _npcFuncType = {}
    if lockType == lockFuncType.UnlockFunctionType_Guild then               --公会
        table.insert(_npcFuncType,npcFuncType.GUILD_ENTRANCE)
    elseif lockType == lockFuncType.UnlockFunctionType_FriendShip then      --好友
    elseif lockType == lockFuncType.UnlockFunctionType_StudySkill then      --学习技能
    elseif lockType == lockFuncType.UnlockFunctionType_Task then            --任务
        table.insert(_npcFuncType,npcFuncType.TASK)
    elseif lockType == lockFuncType.UnlockFunctionType_Rangking then        --排行榜
        table.insert(_npcFuncType,npcFuncType.LEADERBOARD)
    elseif lockType == lockFuncType.UnlockFunctionType_Warehouse then       --仓库
        table.insert(_npcFuncType,npcFuncType.WAREHOUSE)
    elseif lockType == lockFuncType.UnlockFunctionType_Strengthen then      --装备强化
        table.insert(_npcFuncType,npcFuncType.EQUIPMENT_STRENGTHEN)
    elseif lockType == lockFuncType.UnlockFunctionType_PetStrengthen then   --宠物装备强化
        table.insert(_npcFuncType,npcFuncType.PET_EQUIPMENT_STRENGTHEN)
    elseif lockType == lockFuncType.UnlockFunctionType_Remodel then         --装备改造
        table.insert(_npcFuncType,npcFuncType.EQUIPMENT_REMODEL)
    elseif lockType == lockFuncType.UnlockFunctionType_Decompose then       --装备分解
        table.insert(_npcFuncType,npcFuncType.EQUIPMENT_DECOMPOSE)
    elseif lockType == lockFuncType.UnlockFunctionType_Forge then           --装备锻造
        table.insert(_npcFuncType,npcFuncType.UnlockFunctionType_Forge)
    elseif lockType == lockFuncType.UnlockFunctionType_Luckywheel then      --抽奖
        table.insert(_npcFuncType,npcFuncType.LUCKYWHEEL_TURN)
    elseif lockType == lockFuncType.UnlockFunctionType_Catfood then         --猫饭
        table.insert(_npcFuncType,npcFuncType.CAT_FOOD)
    elseif lockType == lockFuncType.UnlockFunctionType_Facelift then        --捏脸
        table.insert(_npcFuncType,npcFuncType.FACELIFT)
    elseif lockType == lockFuncType.UnlockFunctionType_BlackMarket then     --黑市
        table.insert(_npcFuncType,npcFuncType.BLACK_MARKET)
    elseif lockType == lockFuncType.UnlockFunctionType_RandomShop then      --随机商店
        table.insert(_npcFuncType,npcFuncType.RANDOMSHOPUNLOCK)
    elseif lockType == lockFuncType.UnlockFunctionType_Mail then            --邮箱
        table.insert(_npcFuncType,npcFuncType.MAILBOX)
    elseif lockType == lockFuncType.UnlockFunctionType_Dungeon then         --大秘境
        table.insert(_npcFuncType,npcFuncType.SPECIFIC_ENTRANCE)
        table.insert(_npcFuncType,npcFuncType.DUNGEON_SEASON_REWARD)
    elseif lockType == lockFuncType.UnlockFunctionType_Pokedex then         --图鉴
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_PET_POKEDEX)
    elseif lockType == lockFuncType.UnlockFunctionType_TreasureMap then     --藏宝图
    elseif lockType == lockFuncType.UnlockFunctionType_Cave then            --洞窟
        table.insert(_npcFuncType,npcFuncType.GENERAL_ENTRANCE)
    elseif lockType == lockFuncType.UnlockFunctionType_Invalid then         --有效打点 截止 服务器使用
    elseif lockType == lockFuncType.UnlockFunctionType_Achievement then     --成就
        table.insert(_npcFuncType,npcFuncType.ACHIEVEMENT)
    elseif lockType == lockFuncType.UnlockFunctionType_FightLog then        --战利品日志
    elseif lockType == lockFuncType.UnlockFunctionType_FunnyRecord then     --趣味数据
    elseif lockType == lockFuncType.UnlockFunctionType_AutoFight then     --自动解锁
    elseif lockType == lockFuncType.UnlockFunctionType_Horcrux then     --趣味数据
    elseif lockType == lockFuncType.UnlockFunctionType_Relic then           --遗物系统

    elseif lockType == lockFuncType.UnlockFunctionType_Activity then        --运营活动
        table.insert(_npcFuncType,npcFuncType.ACTIVITY)
    elseif lockType == lockFuncType.UnlockFunctionType_GemSlot then        --宝石镶嵌
        table.insert(_npcFuncType,npcFuncType.GEMSTONE_INLAID)
    elseif lockType == lockFuncType.UnlockFunctionType_GemSynthesis then        --宝石合成
        table.insert(_npcFuncType,npcFuncType.GEMSTONE_COMPOSE)
    elseif lockType == lockFuncType.UnlockFunctionType_GemConnect then      --符文连接
        table.insert(_npcFuncType,npcFuncType.FUNCTION_GEMCONNECT)
    elseif lockType == lockFuncType.UnlockFunctionType_GemDecompose then      --符文分解
        table.insert(_npcFuncType,npcFuncType.FUNCTION_GEMDECOMPOSE)
    elseif lockType == lockFuncType.UnlockFunctionType_GemTransform then        --宝石转换
        table.insert(_npcFuncType,npcFuncType.GEMSTONE_TRANSFORM)
    elseif lockType == lockFuncType.UnlockFunctionType_GemShopBuy then        --宝石商店购买
        table.insert(_npcFuncType,npcFuncType.GEMSTONE_BUY)
    elseif lockType == lockFuncType.UnlockFunctionType_HeroCave then          --英雄模式
    elseif lockType == lockFuncType.UnlockFunctionType_GoldenMine then          --家园系统 金矿
        table.insert(_npcFuncType,npcFuncType.HOME_SYSTEM_MINE)
    elseif lockType == lockFuncType.UnlockFunctionType_GemFactory then          --家园系统 符文石
        table.insert(_npcFuncType,npcFuncType.HOME_SYSTEM_GEM)
    elseif lockType == lockFuncType.UnlockFunctionType_OccupationAdvanced then          --职业进阶
        table.insert(_npcFuncType,npcFuncType.SKILL_ADVANCED)
    elseif lockType == lockFuncType.UnlockFunctionType_EquipmentIllusion then          --装备幻化
        table.insert(_npcFuncType,npcFuncType.EQUIPMENT_ILLUSION)
    elseif lockType == lockFuncType.UnlockFunctionType_Dream then              --梦境试验
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_DREAM)
    elseif lockType == lockFuncType.UnlockFunctionType_EquipConvert then       --装备转换
        table.insert(_npcFuncType,npcFuncType.EQUIP_CONVERT)
    elseif lockType == lockFuncType.UnlockFunctionType_EquipRecast then       --装备重铸
        table.insert(_npcFuncType,npcFuncType.EQUIP_RECAST)
    elseif lockType == lockFuncType.UnlockFunctionType_StarPray then       --星痕
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_STARPRAY_GET)
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_STARPRAY_EQUIP)
    elseif lockType == lockFuncType.UnlockFunctionType_EquipRefine then      
        table.insert(_npcFuncType,npcFuncType.EQUIP_REFINE)
    elseif lockType == lockFuncType.UnlockFunctionType_EquipSuitTransform then       
        table.insert(_npcFuncType,npcFuncType.EQUIP_SET_CHANGE)
    elseif lockType == lockFuncType.UnlockFunctionType_Expedition then       -- 探险队
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_EXPEDITION)
    elseif lockType == lockFuncType.UnlockFunctionType_GuildShop then       -- 公会商店
        table.insert(_npcFuncType,npcFuncType.GUILD_MARKET)
    elseif lockType == lockFuncType.UnlockFunctionType_GuildBoss then       -- 公会商店
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_GUILDBOSS)
    elseif lockType == lockFuncType.UnlockFunctionType_DesertEye then       -- 沙之眼
        table.insert(_npcFuncType,npcFuncType.DESERT_EYE)
    elseif lockType == lockFuncType.UnlockFunctionType_DistortedSpace then       -- 扭曲空间
        table.insert(_npcFuncType,npcFuncType.DISTORTED_SPACE)
    elseif lockType == lockFuncType.UnlockFunctionType_EquipLevelRemove then       -- 装备等级移除
        table.insert(_npcFuncType,npcFuncType.EQUIP_LEVEL_REMOVE)
    elseif lockType == lockFuncType.UnlockFunctionType_Apprenticeship then       -- 师徒系统
        table.insert(_npcFuncType,npcFuncType.APPRENTICESHIP)  
    elseif lockType == lockFuncType.UnlockFunctionType_Festival then       -- 节日活动系统
        table.insert(_npcFuncType,npcFuncType.ActivityType_Festival)  
    elseif lockType == lockFuncType.UnlockFunctionType_PetTreasureCollection then       -- 宠物宝藏收集
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_PETTREASURE)
    elseif lockType == lockFuncType.UnlockFunctionType_FestivalExchangeShop then       -- 节日活动兑换商店
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_FESTIVAL_EXCHANGE_SHOP)
    elseif lockType == lockFuncType.UnlockFunctionType_PetDevelop then     -- 宠物培养
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_PETDEVELOP)
    elseif lockType == lockFuncType.UnlockFunctionType_Inferno then     -- 宠物培养
        table.insert(_npcFuncType,npcFuncType.FUNCTION_INFERNO)
    elseif lockType == lockFuncType.UnlockFunctionType_GhostAbyss then     -- 幽林深渊
        table.insert(_npcFuncType,npcFuncType.FUNCTION_GHOST_LEVELSELECT)
        table.insert(_npcFuncType,npcFuncType.FUNCTION_GHOST_SHOP)
    elseif lockType == lockFuncType.UnlockFunctionType_PetAdventure then     -- 幽林深渊
        table.insert(_npcFuncType,npcFuncType.FUNCTION_PET_ADVENTURE)
    elseif localType == lockFuncType.UnlockFunctionType_Manor then --庄园
        table.insert(_npcFuncType,npcFuncType.FUNCTION_MANOR_PORTAL)
    elseif lockType == lockFuncType.UnlockFunctionType_VoidRift then     -- 虚空秘境
        table.insert(_npcFuncType,npcFuncType.FUNCTION_VOID_RIFT)
    elseif localType == lockFuncType.UnlockFunctionType_Manor_Suit_Transformation then --套装改造
        table.insert(_npcFuncType,npcFuncType.FUNCTION_SUIT_TRANSFORMATION)
    elseif lockType == lockFuncType.UnlockFunctionType_Enchant then --附魔
        table.insert(_npcFuncType,npcFuncType.ENCHANT)
    elseif lockType == lockFuncType.UnlockFunctionType_Home then --家园
        table.insert(_npcFuncType,npcFuncType.FUNCTION_TYPE_HOME)
    elseif lockType == lockFuncType.UnlockFunctionType_Viking then     -- 虚空秘境
        table.insert(_npcFuncType,npcFuncType.FUNCTION_VIKING)
    elseif lockType == lockFuncType.UnlockFunctionType_EverWinterRift then     --永冬裂缝
        table.insert(_npcFuncType,npcFuncType.FUNCTION_EVER_WINTER)
    elseif lockType == lockFuncType.UnlockFunctionType_Reincarnation then     --永冬裂缝
        table.insert(_npcFuncType,npcFuncType.FUNCTION_REINCARNATION)
    elseif lockType == lockFuncType.UnlockFunctionType_Mold then     --模具锻造
        table.insert(_npcFuncType,npcFuncType.FUNCTION_MOLDFORING)
        table.insert(_npcFuncType,npcFuncType.FUNCTION_MOLDUSE)     --模具使用
    elseif lockType == lockFuncType.UnlockFunctionType_CHAOS then     -- 混沌虫洞
        table.insert(_npcFuncType,npcFuncType.FUNCTION_CHAOS)
    elseif lockType == lockFuncType.UnlockFunctionType_Wromhole then     -- 虫洞深处
        table.insert(_npcFuncType,npcFuncType.FUNCTION_WORMHOLE)
    elseif lockType == lockFuncType.UnlockFunctionType_Bet then     -- 拉力赛
        table.insert(_npcFuncType,npcFuncType.FUNCTION_BET)
    elseif lockType == lockFuncType.UnlockFunctionType_EquipUpgrade then     -- 紫升红
        table.insert(_npcFuncType,npcFuncType.FUNCTION_CHANGEPURPLE)
    end
    return _npcFuncType
end

return FunctionUnlockManager














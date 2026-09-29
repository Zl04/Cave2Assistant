

--[[
    负责属性定义以及提供基础函数
]]
RoleDataManager = RoleDataManager or {}

require "app.datas.role.HeroData"
require "app.datas.role.MonsterData"
require "app.datas.role.PetRoleData"
-- require "app.datas.npc.TreasureData"
-- require "app.datas.npc.GoldBagData"
-- require "app.datas.npc.TransDoorData"
require "app.datas.npc.TriggerNpcData"
require "app.datas.skill.MonsterAffixData"
require "app.datas.common.CheckpointData"
require "app.datas.common.MaxLevelData"
require "app.datas.common.UnlockCaveData"
require "app.datas.common.CaveIndexData"

local PACKET_TYPE = PublicDefine.PACKET_TYPE

local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")

local DEBUG = true

function RoleDataManager:init()
    self.masterPK = -1

    --自己英雄
    self._master = nil
    --里面是包含的 HeroData 对象 （key=spriteID value=HeroData )
    self._heroMap = {}

    --宠物相关
    self._fightPet = {} --自己的出战宠物
    self._petsMap = {} --在当前场景的宠物

    --怪物列表
    self._monsterMap = {}
    -- NPC列表      {key=spriteID value=NpcData}
    self._npcMap = {}
    -- 所有角色列表  {key=spriteID value=RoleData}
    self._roleMap = {}
    -- 功能NPC 数据
    self._functionNpcData = {}
    -- 洞穴商店数据
    self._functionNpcData.caveShopData = nil
    -- 洞穴是否点金了
    self._functionNpcData.goldTouched = 0
    -- 修改的存档点    
    self._changeCheckPoint = nil
    --
    self._advanceStat = 0 --是否转职
    --
    self._petPVPRoles = nil--{myRoles = {hero = nil, pets = {}}, enemyRole = {hero = nil, pets = {}}}

    self.oldPet = nil

    self._reincarnationLv = 0 --转生等级
end

function RoleDataManager:clear()
    self.masterPK = -1
    self._master = nil
    -- self._fightPet = nil
    table.clear(self._fightPet)
    table.clear(self._heroMap)
    table.clear(self._monsterMap)
    table.clear(self._npcMap)
    table.clear(self._roleMap)
    table.clear(self._functionNpcData)
    table.clear(self._petsMap)
    self._functionNpcData.caveShopData = nil
    self._functionNpcData.goldTouched = 0
    self._changeCheckPoint = nil
    self._advanceStat = 0 --是否转职
    self.oldPet = nil
    self._reincarnationLv = 0 --转生等级
end

-- hero一定是两只 pet 一定是三只
function RoleDataManager:initPetPVPRoles(heros, pets)
    self._petPVPRoles = {myRoles = {hero = heros[1].spriteID, pets = {pets[1].spriteID, pets[2].spriteID, pets[3].spriteID}}, 
    enemyRoles = {hero = heros[2].spriteID, pets = {pets[4].spriteID, pets[5].spriteID, pets[6].spriteID}}}
end

function RoleDataManager:initPetPVERoles(heros, pets)
    self._petPVPRoles = {myRoles = {hero = heros[1].spriteID, pets = {pets[1].spriteID, pets[2].spriteID, pets[3].spriteID}}, 
    enemyRoles = {hero = heros[2].spriteID, pets = {pets[4].spriteID}}}
end

function RoleDataManager:getPetPVPRoles()
    return self._petPVPRoles
end

function RoleDataManager:clearPetPVPRoles()
    if self._petPVPRoles ~= nil then

        self._heroMap[self._petPVPRoles.myRoles.hero] = nil
        self._roleMap[self._petPVPRoles.myRoles.hero] = nil
        self._heroMap[self._petPVPRoles.enemyRoles.hero] = nil
        self._roleMap[self._petPVPRoles.enemyRoles.hero] = nil

        for k, v in ipairs(self._petPVPRoles.myRoles.pets) do
            self._roleMap[v] = nil
            self._petsMap[v] = nil
        end
        for k, v in ipairs(self._petPVPRoles.enemyRoles.pets) do
            self._roleMap[v] = nil
            self._petsMap[v] = nil
        end
    end
    self._petPVPRoles = nil
end

function RoleDataManager:switchMasterSpriteID(oldSpriteID,newSpriteID)
    -- 处理其余数据
    if(oldSpriteID ~= newSpriteID) then
        self._heroMap[oldSpriteID] = nil
        self._roleMap[oldSpriteID] = nil
    end

    self._heroMap[newSpriteID] = self._master
    self._roleMap[newSpriteID] = self._master
end

-- 进入下一层清理数据
function RoleDataManager:nextFloorClear()
    self._heroMap = {}
    self._monsterMap = {}
    self._npcMap = {}
    self._roleMap = {}
    self._petsMap = {}

    -- 重置点金台,这里不用清理数据只需要在业务逻辑清理就可以了
    -- print("RoleDataManager:nextFloorClear() run.")
    -- self._functionNpcData.goldTouched = 0
    self._changeCheckPoint = nil
    self._advanceStat = 0 --是否转职
end

-- 回档（恢复）清理数据
function RoleDataManager:restoreClear()
    -- 回档（恢复）清理数据
    self._master:clear()
    if self._fightPet then
        -- self._fightPet:clear()
        self._fightPet = {}
    end
    self._heroMap = {}
    self._monsterMap = {}
    self._npcMap = {}
    self._roleMap = {}
    self._petsMap = {}
    self:clearPetPVPRoles()
end

-- 清理除了玩家以外的数据
function RoleDataManager:clearOtherData()
    self._heroMap = {}
    self._monsterMap = {}
    self._npcMap = {}
    self._roleMap = {}
    self._petsMap = {}
end

-- 根据 PK和spriteID 清理数据
function RoleDataManager:clearDataForPKANDSpriteID(pk, spriteID)
    self._heroMap[spriteID] = nil
    self._roleMap[spriteID] = nil
end

-- 每层清理功能数据
function RoleDataManager:clearFunctionData()
    -- print("RoleDataManager:clearFunctionData()")
    self._functionNpcData = {}
end

-- 设置玩家PK值
function RoleDataManager:setMasterPK(pk)
    -- print("RoleDataManager:setMasterPK",pk)
    self.masterPK = pk

    -- setUserInfo(tostring(pk))

end
-- 获取玩家PK值
function RoleDataManager:getMasterPK()
    -- print("RoleDataManager:getMasterPK")
    if self.masterPK ~= -1 then
        return self.masterPK
    else
        if self._master then
            self.masterPK = self._master:getPK()
            -- print("getMasterPK",self.masterPK)
            return self.masterPK
        else
            return -1
        end
    end
end

--获取主角信息
function RoleDataManager:getMaster()

    return self._master
end

--获取主角ID
function RoleDataManager:getMasterSpriteID()
    if(self._master) then
        return self._master:getSpriteID()
    end 

    return nil
end

--获取当前的技能树模式
function RoleDataManager:getMasterSkillTreeModel()
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isInHuLu()) then 
        return SkillTreeModel.SKILL_TREE_MODEL_ADVANCED
    else
        -- body
        -- 技能进阶导致技能数模式变化
        if self._master then 
            if(self._master:getAdvanceStat() == 1) then 
                return Game.SkillTreeModel.SKILL_TREE_MODEL_ADVANCED
            end
        end
        if self._advanceStat == 1 then--是否转职 == 1
            return Game.SkillTreeModel.SKILL_TREE_MODEL_ADVANCED
        end
    end
    return Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL
end

function RoleDataManager:setAdvanceStat(advanceStat)
    self._advanceStat = advanceStat
end

-- 根据精灵ID获取角色对象
function RoleDataManager:getRoleDataBySpriteID(spriteID, ingoreMaster)
    if ingoreMaster then
        local hero = self._roleMap[spriteID]
        if hero ~= nil then
            return hero
        end
        return self:getScreenPetDataByID(spriteID)
    else
        if(self._master) then
            if(self._master:getSpriteID() == spriteID) then
                return self._master
            end
        end
        local hero = self._roleMap[spriteID]
        if hero ~= nil then
            return hero
        end
        -- if self._fightPet ~= nil and self._fightPet:getSpriteID() == spriteID then
        --     return self._fightPet
        -- end
        -- if self._fightPet ~= nil then
        --     for k, v in pairs(self._fightPet) do
        --         if v:getSpriteID() == spriteID then
        --             return v
        --         end
        --     end
        -- end
        return self:getScreenPetDataByID(spriteID)
    end
end

-- 根据PK获取英雄数据
function RoleDataManager:getHeroDataForPK(PK)
    for k,v in pairs(self._heroMap) do
        if(v:getPK() == PK) then
            return v
        end
    end

    if(self._master) then
        if(self._master:getPK() == PK) then
            return self._master
        end
    end

    return nil
end

function RoleDataManager:getHeroDataForSpriteID(spriteID)
    for k,v in pairs(self._heroMap) do
        if(v:getSpriteID() == spriteID) then
            return v
        end
    end

    if(self._master) then
        if(self._master:getSpriteID() == spriteID) then
            return self._master
        end
    end

    return nil
end

function RoleDataManager:getAllScreenPetData()

    return self._petsMap
end

function RoleDataManager:getScreenPetDataByID(spriteID)
    for k,v in pairs(self._petsMap) do
        if(tostring(v:getSpriteID()) == tostring(spriteID)) then
            return v
        end
    end
    return nil
end

function RoleDataManager:getScreenPetDataByInsId(insId)
    for k,v in pairs(self._petsMap) do
        if(v:getPetInstId() == insId) then
            return v
        end
    end
    return nil
end


function RoleDataManager:getScreenFightPetData()
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isInHuLu()) then
        return nil
    else
        if self._fightPet and next(self._fightPet) then
            return self._fightPet
        elseif self._master then
            for k,v in pairs(self._petsMap) do
                if(v.masterSpriteID == self._master:getSpriteID()) then
                    -- self._fightPet = v
                    -- print("getScreenFightPetData12232",self._master:getSpriteID())
                    table.insert(self._fightPet, v)
                    -- return self._fightPet
                end
            end
        end
        return self._fightPet
    end
end

function RoleDataManager:getFightPetbyId(spriteID)
    if self._fightPet and next(self._fightPet) then
        
        for _, v in pairs(self._fightPet) do
            if tonumber(v.petInstId) == tonumber(spriteID) then
                return v
            end
        end
    end
    for _, v in ipairs(self._petsMap) do
        if v:isFight() and tonumber(v.petInstId) == tonumber(spriteID)  then
            return v
        end
    end
    return nil
end

function RoleDataManager:setScreenFightPetData(data)
    local oldPetData = self:getOldPetData(data, self._fightPet)
    if(oldPetData) then
        self:setMasterOldPetData(oldPetData)
        -- add by zp 清理上一只宠物buff
        local buffList = SkillDataManager:getBufferDataListForSpriteID(oldPetData.spriteID)--(self._fightPet.spriteID)
        if(buffList) then 
            for k, v in pairs(buffList) do 
                -- print("RoleDataManager:setScreenFightPetData removeBuff=", v)
                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REMOVE_BUFFER, {
                    bufferData = v,
                    bufferEntityID = v.entityID,
                    bufferTargetID = v.targetSpriteID
                })
                SkillDataManager:deleteBuff(self._fightPet.spriteID, v.entityID)
            end
        end 
        local bagPetData = MasterDataManager:getBagPetById(oldPetData.petInstId)
        bagPetData:setReadyFight(false)
    end
    for k, v in pairs(self._fightPet) do
        if v.siteId == data.siteId and data.masterSpriteID == self._master:getSpriteID() then
            self._fightPet[k] = data
            return
        end
    end
    if data.masterSpriteID  == self._master:getSpriteID() then
        table.insert(self._fightPet, data)
    end
end

function RoleDataManager:setMasterOldPetData(oldPet)
    self.oldPet = oldPet
end

function RoleDataManager:getMasterOldPetData()
    return self.oldPet
end

-- 获取当前所有玩家的消息 (当前只是用于表现需要)
function RoleDataManager:getAllRole()
    local arr = {}
    for _,v in pairs(self._heroMap) do
        table.insert(arr,v)
    end

    return arr
end

--返回宠物队长data
function RoleDataManager:getCaptain()
    print("RoleDataManagergetCaptain", table.nums(self._fightPet))
    if self._fightPet then
        -- dump(self._fightPet, "getCaptainfightPet")
        for k, v in pairs(self._fightPet) do
            print("RoleDataManagergetCaptain", v.siteId)
            if v.siteId == 0 then
                return v
            end
        end
    end
    if self._petsMap then
        -- dump(self._petsMap, "getCaptain_petsMap")
        for k, v in pairs(self._petsMap) do
            if self._master then
                if v.siteId == 0 and v.masterSpriteID == self._master:getSpriteID() then
                    return v
                end
            end
            -- if v.siteId == 0 then
            --     return v
            -- end
        end
    end
    return nil
end

function RoleDataManager:getAllOtherRole()
    local arr = {}
    local masterPK = self._master:getPK()
    for key, v in pairs(self._heroMap) do
        if masterPK ~= v:getPK() then
            table.insert(arr,v)
        end
    end
    return arr
end

-- 获取存档点数据
function RoleDataManager:getCheckpointData(caveMode, caveDifficulty)
    if(self._master) then
        return self._master:getCheckpointData(caveMode, caveDifficulty)
    end

    return nil
end

-- 获取玩家是否达到特定存档点
function RoleDataManager:getCheckpointIsOver(levelNumber, curMode, curDiff)
    if(self._master) then
        return self._master:getCheckpointIsOver(levelNumber, curMode, curDiff)
    end
end

function RoleDataManager:getMaxLevelArr()
    if(self._master) then
        return self._master.maxLevelArr
    end
end

-- 更新进入洞穴时的金币
function RoleDataManager:updateEnterCaveCoin()
    if(DEBUG) then
        print("RoleDataManager:updateEnterCaveCoin")
    end
    if (self._master) then
        self._master:setEnterCaveCoin(self._master:getCurCoin())
    end
end

function RoleDataManager:getCaveShopData()
    return self._functionNpcData.caveShopData
end

-- 获取角色点金记录
function RoleDataManager:getHeroGoldTouched()
    if(self._functionNpcData.goldTouched == nil) then
        -- print(" RoleDataManager:getHeroGoldTouched()  is nil.")
        self._functionNpcData.goldTouched = 0
    end

    return self._functionNpcData.goldTouched
end

-- 更新进入洞穴时的铭文
function RoleDataManager:updateEnterCaveInscription()
    if(DEBUG) then
        print("RoleDataManagerupdateEnterCaveInscription", self._master:getInscriptionNum())
    end
    if (self._master) then
        self._master:setEnterCaveInscription(self._master:getInscriptionNum())
    end
end

-------------------------------------------------------

function RoleDataManager:handleEndLogin(data)
    local master = self:getMaster()
    if(master) then
        -- 处理
        master:changeInit(data)

        self:triggerSwitchMasterSpriteID(data.spriteID)
    else
        printError("RoleDataManager:handleEndLogin no masterData.")
    end
end

-- 处理英雄数据
function RoleDataManager:handleHeroData(data)
    if( not data) then
        return nil
    end

    local heroData = self:getHeroDataForSpriteID(data.spriteID)
    if(not heroData) then
        heroData = Data.HeroData:create()
        heroData:changeInit(data)
        heroData:handleAttr(data.attr)
        self:_addHeroData(heroData)

        -- TODO 这里需要考虑处理的位置
        -- 处理快捷栏数据
        for k,v in pairs(data.shortcutsData) do
            -- if (DEBUG) then
            --     print("RoleDataManager:handleHeroData  reback index,templateID=",v.index,v.templateID)
            -- end
            GoodsDataManager:updateNormalShortcutBar(v.index,v.templateID)
        end
        -- 发送通知消息
        local shortcutsData = GameDataManager:getInstance():getShortcutBarData()
        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE,shortcutsData)
    else
        heroData:changeInit(data)
        heroData:handleAttr(data.attr)
          for k,v in pairs(data.shortcutsData) do
            GoodsDataManager:updateNormalShortcutBar(v.index,v.templateID)
        end
    end
    if (heroData) then
        heroData:initCheckpoint(data.checkpoint)
--dump(data.checkpoint)
        heroData:initMaxLevel(data.maxLevel, data.maxLevelGeneral, data.heroMaxlLevelGeneral)
        heroData:initUnlockCave(data.unlockCave)
        heroData:initCaveIndex(data.caveIndex)
        -- heroData:initProductPurchase(data.diamondProductPurchase)
        heroData:initProductPurchase(data.diamondRecords)

    end

    return heroData
end

function RoleDataManager:handleRoleDie(data)
    if(data) then
        local heroData = self:getHeroDataForSpriteID(data.spriteID)
        if(heroData) then
            heroData:setIsReviveFree(data.isReviveFree)
            heroData:setIsFirstFree(data.isFirstFree)
            -- add by zp 用于修复 CO-5504,这里添加了相关的协议
            if heroData.setOnceExploreDeadTimes and  ProtobufUtil:checkFieldIsInit(data, "onceExploreDeadTimes") then 
                heroData:setOnceExploreDeadTimes(data.onceExploreDeadTimes)
            end
        end
    end
end

function RoleDataManager:handleLevelUp(data)
    local oldLevel = 0
    local heroData = self:getHeroDataForSpriteID(data.spriteID)
    if(heroData) then
        local masterPK = self:getMasterPK()
        if (masterPK == heroData:getPK()) then
            -- 更新红点提示信息数据
            require "app.utils.BagNotificationUtil"
            BagNotificationUtil:updateUpgradableItems(true)
        end

        oldLevel = heroData:getLevel()

        heroData:setLevel(data.totalLevel)

        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA,heroData)
        Avalon.MessageCenter:notice(GameMessage.MC_CHAT_REFRESH_TIPS)
    end

    return oldLevel
end

function RoleDataManager:handleUnlockCaveDiffculty(data)
    if(self._master) then
        if(data.result == "UnlockCaveModeDiffcultyResult_Success") then
            local cave = data.caveMode 
            local diffculty = data.caveDiffculty

            if cave == PublicDefine.CAVE_MODE.MODE_NORMAL then
                local _checkpointData = RoleDataManager:getCheckpointData(cave,diffculty) 
                if _checkpointData == nil or _checkpointData:getUnlockLevel() == 0 then
                    --新难度
                    Game.FunctionUnlockManager:getInstance():addLevelDifficulty(cave,diffculty)
                end
            end

            self._master:updateUnclokCave(cave, diffculty)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.UnlockCaveModeDiffcultyResult",data.result))
        end
    end
end

function RoleDataManager:handleClearLevelOrPoint(data)
    if(self._master and data) then
        local caveMode = data.cavemode
        local diffculty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1

        self._master:clearMaxLevelData(caveMode, diffculty)

        local checkpointData = RoleDataManager:getCheckpointData(caveMode, diffculty)
        if(checkpointData) then 
            checkpointData:setCheckpoint(0)
        end
    end
end

function RoleDataManager:handleNoticeUnlockCaveDiffculty(data)
    if(self._master and self._master:getPK() == data.pk) then
        local cave = data.caveMode 
        local diffculty = data.caveDiffculty

        if cave == PublicDefine.CAVE_MODE.MODE_NORMAL then
            local _checkpointData = RoleDataManager:getCheckpointData(cave,diffculty) 
            if _checkpointData == nil or _checkpointData:getUnlockLevel() == 0 then
                --新难度
                Game.FunctionUnlockManager:getInstance():addLevelDifficulty(cave,diffculty)
            end
        end

        self._master:updateUnclokCave(cave, diffculty)
    end
end

function RoleDataManager:handleScreenExpeditionInfo(data)
    if(data) then
        local heroData = self:getHeroDataForSpriteID(data.spriteID)
        if(heroData) then 
            heroData:startUpdateAttr()
            heroData:setExpeditonStatus(data.isExpeditionRun)
            heroData:endUpdateAttr()
        end
    end
end

function RoleDataManager:handleNoticeUnlockCheckPoint(data)
    if(self._master and self._master:getPK() == data.pk) then
        local checkPoint = self._master:getCheckpointData(data.checkpoint.caveMode, data.checkpoint.caveDifficulty)
        self._changeCheckPoint = clone(checkPoint)

        self._master:updateCheckPoint(data.checkpoint)
    end
end

-- 获取存档点
function RoleDataManager:getChangeCheckPoint()
    return self._changeCheckPoint
end

-- 处理同屏英雄数据
function RoleDataManager:handleScreenHeroData(data)
    if( not data) then
        return nil
    end

    if(data.pk == self:getMasterPK()) then 
        return self:getMaster()
    end

    local heroData = self:getHeroDataForSpriteID(data.spriteID)
    if(not heroData) then
        heroData = Data.HeroData:create()
        heroData:changeInit(data)

        self:_addHeroData(heroData)
    else
        heroData:changeInit(data)
    end

    if(data.isDead) then
        heroData:setIsDead(true)
    else
        heroData:setIsDead(false)
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA,heroData)

    return heroData
end

-- 处理同屏英雄数据
function RoleDataManager:handleScreenPetData(data)
    local isDirty = false
    if( not data) then
        return nil, isDirty
    end
    local oldStatus = nil
    local petData = self:getScreenPetDataByID(data.spriteID)
    if(not petData) then
        petData = Data.PetRoleData:create()
        petData:init(data, false)
        self:_addPetData(petData)
        isDirty = true
    else
        oldStatus = petData.status
        isDirty = petData:changeInit(data)
    end

    return petData, isDirty
end

--同步到屏幕周围骑行状态 data.isRiding 代表骑乘的一种行为
function RoleDataManager:handlePetRidingState(data, isMaster)
    local isRiding = data.isRiding
    local petSpriteId = nil
    local heroSpriteId = nil
    if isMaster then
        petSpriteId = self:getCaptain().spriteID
        -- petSpriteId = MasterDataManager:getCaptainPet().spriteID
        heroSpriteId = self:getMasterSpriteID()
        print(" petSpriteId ==== ",petSpriteId)
        print(" heroSpriteId ==== ",heroSpriteId)
    else
        petSpriteId = data.petSpriteId
        heroSpriteId = data.heroSpriteId
    end

    local petData = self:getScreenPetDataByID(petSpriteId)
    
    -- print("  handlePetRidingState ======  ",data)
    if petData then
        local heroData = self:getHeroDataForSpriteID(heroSpriteId)

        -- print("  petData:setReadyRide(isRiding) ======  ",isRiding)
        petData:setReadyRide(isRiding)
        local SceneManager = require("app.game.SceneManager")

        if not  MachineManager:getInstance():getMachine() or not MachineManager:getInstance():getMachine():getModel() then
            return
        end

        local model = MachineManager:getInstance():getMachine():getModel()
        local heroRole = model:getRoleBySpriteID(heroSpriteId)
        local petRole = model:getRoleBySpriteID(petSpriteId)
        if not petRole then
            return
        end
        local petModelId = petRole:getId()
        local data = {
            isRiding = isRiding,
            petSiteId = petData:getSiteId()
        }

        if not heroData or not heroRole then
            printError("not heroData or not heroRol", not heroData, not heroRole)
            return 
        end

        petData:setLooks(heroData:getLooks())

        print("heroRole._fsm._state =====", heroRole._fsm._state,FSMState.DIE)
        if heroRole._fsm._state == FSMState.DIE then
            return
        end

        print(" petData:getLooks()  ===  ",petData:getLooks())
        if petData:getLooks() ~= 0 and petData:getLooks() ~= nil then
            data.isRiding = false
        end

        if heroRole._fsm._state ~= FSMState.BATTLE then
            local ridingCMD = Command.RendererCommand:create(true)
            ridingCMD:initForTypeAndData(CommandType.RENDERER_PET_RIDE, petModelId, data)
            SceneManager:getInstance():pushCommand(ridingCMD)
        end


        local heroRole = model:getRoleBySpriteID(heroSpriteId)
        local heroModelId = heroRole:getId()
        local data2 = {
            isRiding = isRiding,
            petSiteId = petData:getSiteId()
        }
        local ridingCMD2 = Command.RendererCommand:create(true)
        ridingCMD2:initForTypeAndData(CommandType.RENDERER_HERO_RIDE, heroModelId, data2)
        SceneManager:getInstance():pushCommand(ridingCMD2)

    end
    
end

-- 处理角色详情
function RoleDataManager:handleHeroDetailData(data)
    if(not data) then
        return nil
    end

    local oldHeroData = nil
    for _,heroData in pairs(self._heroMap) do
        if(heroData:getPK() == data.pk) then
            oldHeroData = heroData
            break
        end
    end

    local heroData = oldHeroData
    if(not heroData) then
        heroData = Data.HeroData:create()
        heroData:changeInit(data)
        heroData:handleAttr(data.attr)
        self:_addHeroData(heroData)
    else
        heroData:clearAllAttr()
        heroData:changeInit(data)
        heroData:handleAttr(data.attr)
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA,heroData)

    return heroData
end

-- 处理同屏脸型数据改变
function RoleDataManager:handleScreenFaceChange(data)
    local heroData = self:getHeroDataForSpriteID(data.spriteID)
    if(heroData) then
        heroData:setFaceDecodeID(data.faceDecodeID)
    end

    return heroData
end

-- 处理怪物数据
function RoleDataManager:handleMonsterData(data, model, difficulty)
    if (not data) then
        return nil
    end
    -- print("RoleDataManager:handleMonsterData ", model, difficulty)
    local monsterData = self._monsterMap[data.spriteID]
    if(not monsterData) then
        monsterData = self:createLocalMonsterDataForModeAndDiff(data.monsterID, model, difficulty)
        if(monsterData) then 
            monsterData:changeInit(data)
            self:_addMonsterData(monsterData)
        end
    else
        monsterData:changeInit(data)
    end 

    return monsterData
end

-- 创建一个本地符合当前场景的怪物数据
function RoleDataManager:createLocalMonsterData(templateID)
    -- 创建一个怪物

    return self:createLocalMonsterDataForModeAndDiff(templateID, GameMapManager:getInstance():getModel(), GameMapManager:getInstance():getDifficulty())
end

-- 创建一个本地怪物数据，会所搜索所有的怪物配置文件
function RoleDataManager:createLocalMonsterDataForAllConfig(templateID)
    -- 创建一个怪物
    local model,difficulty = ConfigManager:getMonsterModeAndDiffcultFromMonsterID(templateID)
    if(model and difficulty) then 
        return Data.MonsterData:create(templateID, model, difficulty)
    else 
        print("RoleDataManager:_createLocalMonsterData templateID, model, difficulty=", templateID, model, difficulty)
        printError("RoleDataManager:_createLocalMonsterData  no monster config.")

        return nil
    end
end

-- 创建一个剧情模式第一难度的配置
function RoleDataManager:createNormalConfigLocalMonsterData(templateID)

    return self:createLocalMonsterDataForModeAndDiff(templateID, PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
end

-- 根据模式以及难度创建一个本地怪物数据
function RoleDataManager:createLocalMonsterDataForModeAndDiff(templateID, model, difficulty) 
    -- 先验证是否有该配置文件，然后在创建
    local monsterConfig = ConfigManager:getMonsterConfig(templateID, model, difficulty)
    if(monsterConfig) then 
        return Data.MonsterData:create(templateID, model, difficulty)
    else 
        print("RoleDataManager:_createLocalMonsterData templateID, model, difficulty=", templateID, model, difficulty)
        printError("RoleDataManager:_createLocalMonsterData  no monster config.")

        return nil
    end
end

-- 创建一个本地触发NPC的数据
function RoleDataManager:createLocalTriggerNpcData(templateID)

    return Data.TriggerNpcData:create(templateID)
end

-- 创建一个怪或者触发NPC
function RoleDataManager:createLocalMonsterOrTriggerNpcData(templateID)
    -- body
    if(templateID) then 
        local preNum = math.modf((templateID)/100000)
        if preNum == 102 then
            return self:createLocalMonsterData(templateID)
        elseif preNum == 103 or preNum == 104 then
           return self:createLocalTriggerNpcData(templateID)
        else
            printError("RoleDataManager:createLocalMonsterOrTriggerNpcData  error role type   templateID=", templateID)
        end
    end

    return nil
end

-- 处理解锁背包格子数量
function RoleDataManager:handleResponseUnlockBagSpace(data)
    --print("RoleDataManager:handleResponseUnlockBagSpace")
    --     required uint32 packetType = 1;   // 包裹的类型 public_define.PACKET_TYPE 
    -- required uint32 unlockTimes = 2;  // 目前的解锁次数
    -- required uint32 unlockNumTotal = 3;    // 总的解锁格数
    -- required UnlockBagSpaceResult result = 4;
    if(data.result == "UnlockBagSpaceSuccess") then
        -- TODO 处理解锁背包成功
        if(data.packetType == PACKET_TYPE.PACKET_BAG) then
            MasterDataManager:setUnlockBagTimes(data.unlockTimes)
            MasterDataManager:setTotalBoxCanBeUsedNum(data.unlockNumTotal)
            if(data.itemUnlockTimes) then 
                MasterDataManager:setUnlockBagTimesItem(data.itemUnlockTimes)
                MasterDataManager:setBoxCanBeUsedNumItem(data.itemUnlockTimes * tonumber(Config.General:getValueForKey("itemUnlockPacketBoxSpace")))
            end
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_UNLOCK_BAG)
        elseif (data.packetType == PACKET_TYPE.PACKET_WAREHOUSE) then
            local master = self:getMaster()
            if master then
                master:setUnlcokWarehouseTimes(data.unlockTimes)
                master:setWarehouseCanBeUsedNum(data.unlockNumTotal)
                if(data.itemUnlockTimes) then 
                    master:setUnlcokWarehouseTimesItem(data.itemUnlockTimes)
                    master:setWarehouseCanBeUsedNumItem(data.itemUnlockTimes * tonumber(Config.General:getValueForKey("itemUnlockPacketBoxSpace")))
                end
                Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE)
            end
        else
            printError(string.format("RoleDataManager:handleResponseUnlockBagSpace packetType=%d", data.packetType))
        end
    else
        -- 处理异常错误
        GameErrorManager:showError(ProtobufUtil:enum_id("GoodsSystem.UnlockBagSpaceResult", data.result))
    end
end

-- 处理选择穿戴套装返回数据
function RoleDataManager:handleResponseSelectShortcutEquip(data)
    if(data.result == "SelectShortcutEquipSuccess" or data.result == "SelectShortcutEquipIncomplete" ) then
        -- 处理切换装备页码数据
        local master = self:getMaster()
        master:setSelectShortcutEquipPage(data.index)

        -- 发送切换选中效果页面
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_SELECT_SHORTCUT_EQUIP_CHANGE, data.index)

        if(data.result == "SelectShortcutEquipIncomplete") then
            GameErrorManager:showError(ProtobufUtil:enum_id("GoodsSystem.SelectShortcutEquipResult", data.result))
        end

        Avalon.AudioManager:playSound("1528")
    else
        --TODO 播放切换失败音效

        GameErrorManager:showError(ProtobufUtil:enum_id("GoodsSystem.SelectShortcutEquipResult", data.result))
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_SELECT_SHORTCUT_BACK)
end

-- 移除所有怪物身上指定词缀
function RoleDataManager:handleRemoveAffixForAllMonster(data)
    if (data) then
        local affixID = data.affixID
        for _,monsterData in pairs(self._monsterMap) do
            monsterData:removeAffixForID(affixID)

            -- 发送更新通知
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_MONSTER_DATA, monsterData)
        end 
    end
end

function RoleDataManager:getTriggerNpcArr()
    return self._npcMap
end

function RoleDataManager:handleTriggerNpcData(data)
    if (not data) then
        return nil
    end

    local triggerNpcData = self._npcMap[data.spriteID]
    if (not triggerNpcData) then
        triggerNpcData = Data.TriggerNpcData:create(data.templateID)
        triggerNpcData:changeInit(data)

        self:_addNpcData(triggerNpcData)
    else
        triggerNpcData:changeInit(data)
    end

    return triggerNpcData    
end

function RoleDataManager:handleInitFunctionData(data)
    if(data) then
        -- 处理洞穴商店数据
        if(data.boughtGoods ) then
            self._functionNpcData.caveShopData = {}
            if(#data.boughtGoods>0) then
                for i=1,#data.boughtGoods,1 do
                    local buyData = data.boughtGoods[i]

                    -- 这里处理重复数据
                    local found = false
                    for i=1,#self._functionNpcData.caveShopData,1 do
                        local oldData = self._functionNpcData.caveShopData[i]
                        if buyData.goodsNo == oldData.goodsNo then
                            found = true
                            break;
                        end
                    end

                    if(found == false) then
                        -- 整理数据
                        local oneData = {}
                        oneData.goodsNo = buyData.goodsNo
                        oneData.goodsQuantity = buyData.goodsQuantity

                        table.insert(self._functionNpcData.caveShopData, oneData)
                    end
                end
            end
        end

        -- 处理点金是否触发的处理
        self._functionNpcData.goldTouched = data.goldTouched
        --TODO 修改点金台得状态


        -- TODO 处理其余功能NPC数据

    end
end

-- 处理点金操作
function RoleDataManager:handleCaveGoldTouchSuccess()
    if(self._functionNpcData.goldTouched == nil) then
        self._functionNpcData.goldTouched = 0
    end

    self._functionNpcData.goldTouched = self._functionNpcData.goldTouched + 1
end

-- 处理商店购买成功数据处理
function RoleDataManager:handleCaveShopBuySuccessData(data)
    if(self._functionNpcData.caveShopData == nil) then
        self._functionNpcData.caveShopData = {}
    end

    -- 查找以前是否有
    local found = false
    for i=1,#self._functionNpcData.caveShopData,1 do
        local buyData = self._functionNpcData.caveShopData[i]
        if buyData.goodsNo == data.goodsNo then
            found = true
            buyData.goodsQuantity = buyData.goodsQuantity + data.goodsQuantity
            break;
        end
    end

    if found == false then
        local oneData = {}
        oneData.goodsNo = data.goodsNo
        oneData.goodsQuantity = data.goodsQuantity

        table.insert(self._functionNpcData.caveShopData,oneData)
    end
end

--[[
    负责提供网络接收数据处理
]]
function RoleDataManager:initHero(data,isSync)
    if data ~= nil and data.heroData ~= nil then
        local heroData = self:handleHeroData(data.heroData)
        heroData.isMaster = true
        self._master = heroData

        if isSync then
            return
        end
        -- 这里要考虑更换问题
        self:triggerSwitchMasterSpriteID(heroData:getSpriteID())

        -- 更新红点提示信息数据
        require "app.utils.BagNotificationUtil"
        BagNotificationUtil:updateUpgradableItems()
    end     
    Avalon.MessageCenter:notice(GameMessage.MC_COMMON_SHOW_PET)
end

-- 处理修改昵称
function RoleDataManager:handEditNickName(data)
    if(data ~= nil) then
        local PK = data.pk
        for k,v in pairs(self._heroMap) do
            if(v:getPK() == PK) then
                v:setNickName(data.nickName)
                return v
            end
        end
    end

    return nil
end

function RoleDataManager:handleUpdateHeroStageMaxLevel(data)
    if(self._master) then 
        self._master:updateAllHeroCaveStageMaxLevel(data)
    end
end

--[[
    处理属性变化
    roleData:  要修改的角色对象
    mesData:   服务器传递的消息数据
]]
function RoleDataManager:handleAttrChange(mesData)
    --print("RoleDataManager:handleAttrChange  mesData",mesData)
    if not mesData then
        return false
    end

    --遍历修改属性
    if mesData ~= nil then
        if DEBUG then
            --print("RoleDataManager:handleAttrChange  mesData.spriteID",mesData.spriteID)
            local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY
            -- for k,v in pairs(mesData.attrChange) do
            --     print("RoleDataManager:handleAttrChange name,changeValue,resultValue,changeReason=",ATTR_TYPE_ID_KEY[v.changeType],v.changeValue,v.resultValue,v.changeReason)
            -- end
        end
        -- 根据spriteID 获取数据对象
        local roleData = self:getRoleDataBySpriteID(mesData.spriteID)
        if not roleData then
            return false
        end
        --print("RoleDataManager:handleAttrChange  roleData isFound")
        roleData:startUpdateAttr()
        -- 修改属性
        for k,v in pairs(mesData.attrChange) do
            roleData:attrChange(v)
        end
        roleData:endUpdateAttr()

        -- 根据类型发送通知消息
        if roleData:getType() == RoleType.Hero then
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, roleData)
            local ATTR_TYPE = PublicDefine.ATTR_TYPE
            for k,v in pairs(mesData.attrChange) do
                if v.changeType == ATTR_TYPE.horcruxEnergy then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_HORCRUX_ENGERY_REFRESH)
                    break
                end
            end
        elseif  roleData:getType() == RoleType.Monster then
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_MONSTER_DATA, roleData)
        elseif roleData:getType() == RoleType.Pet then
             Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, roleData)
        end
        
        -- TODO 这里处理所有类型的角色属性改变

        -- if DEBUG then
        --     for k,v in pairs(roleData) do
        --         print("RoleDataManager:handleAttrChange print all value  k,v=",k,v)
        --     end
        -- end

        return true
    end

    return false
end

function RoleDataManager:triggerSwitchMasterSpriteID(spriteID)
    GoodsDataManager:switchMasterSpriteID(-1,spriteID)
    SkillDataManager:switchMasterSpriteID(-1,spriteID)
    self:switchMasterSpriteID(-1,spriteID)
end

function RoleDataManager:handleChangeGuild(data)
    local heroData = RoleDataManager:getHeroDataForPK(data.PK)
    if(heroData) then 
        heroData:changeGuildName(data.guildName)
        heroData:changeGuildID(data.guildID)

        local SceneManager = require("app.game.SceneManager")
        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initForRoleGuildName(heroData:getSpriteID())
        SceneManager:getInstance():pushCommand(battleCMD)
    end
end

function RoleDataManager:setAdvGiftProgress(progress)
    self._master.stage = progress
end

function RoleDataManager:setAdvGiftRefreshTime(time)
    self._master.stageRefreshTime = time
end

function RoleDataManager:setAdvGiftResetProgress()
    self.advGiftResetProgress = true
end

function RoleDataManager:getAdvGiftResetProgress()
    return self.advGiftResetProgress
end

--------------------------------------------------

-- 私有方法
function RoleDataManager:_addHeroData(data)
    if data then

        -- 移除以前的数据
        for spriteID, heroData in pairs(self._heroMap) do
            if(heroData:getPK() == data:getPK() and data:getPK() ~= -1) then
                self._heroMap[heroData:getSpriteID()] = nil
                self._roleMap[heroData:getSpriteID()] = nil
            end
        end

        self._heroMap[data:getSpriteID()] = data
        self._roleMap[data:getSpriteID()] = data
    end
end

-- 私有方法
function RoleDataManager:_addPetData(data)
    if data then
        -- 清理旧数据
        if data.masterSpriteID ~= nil and data.masterSpriteID ~= 0 then
            -- for k,v in pairs(self._petsMap) do
            --     if(data.masterSpriteID == v.masterSpriteID) then
            --         self._petsMap[k] = nil
            --         break
            --     end
            -- end

            -- for k,v in pairs(self._roleMap) do
            --     if(data.masterSpriteID == v.masterSpriteID) then
            --         self._roleMap[k] = nil
            --         break
            --     end
            -- end
            self:clearOldPetData(data, self._petsMap)
            self:clearOldPetData(data, self._roleMap)
        end
        self._petsMap[data:getSpriteID()] = data
        self._roleMap[data:getSpriteID()] = data
        -- print("RoleDataManager_addPetData", self._master)
        if self._master ~= nil and data.masterSpriteID == self._master:getSpriteID() then
            self:setScreenFightPetData(data)
        end
    end
end

--兽栏多宠物清理数据
function RoleDataManager:clearOldPetData(data, map)
    if map then
        for k, v in pairs(map) do
            if data.siteId == v.siteId and data.masterSpriteID == v.masterSpriteID then--data:getSiteId() == v:getSiteId() then
                map[k] = nil
                break
            end
        end
    end
end

--兽栏多宠物数据
-- function RoleDataManager:coverOldPetData(data, map)
--     if map then
--         for k, v in pairs(map) do
--             print("clearOldPetData", data.siteId, v.siteId)
--             if data.siteId == v.siteId then--data:getSiteId() == v:getSiteId() then
--                 map[k] = v
--                 break
--             end
--         end
--     end
-- end

--兽栏下阵
function RoleDataManager:removeFightPet(data)
    self._petsMap[data:getSpriteID()] = nil
    self._roleMap[data:getSpriteID()] = nil
    for k, v in pairs(self._fightPet) do
        if v:getPetInstId() == data:getPetInstId() then
            table.remove(self._fightPet, k)
            break
        end
    end
end

function RoleDataManager:getOldPetData(data, map)
    for k, v in pairs(map) do
        if data:getSiteId() == v:getSiteId() then
            -- if data.petInstId == v.petInstId then
            --     return nil
            -- end
            return v
        end
    end
    return nil
end

function RoleDataManager:_addMonsterData(data)
    if data then
        -- print("RoleDataManager:_addMonsterData spriteID=",data.spriteID)
        self._monsterMap[data.spriteID] = data
        self._roleMap[data.spriteID] = data
    end
end

function RoleDataManager:_addNpcData(data)
    if data then
        -- print("RoleDataManager:_addNpcData spriteID=",data.spriteID)
        self._npcMap[data.spriteID] = data
        self._roleMap[data.spriteID] = data
    end
end

--系统是否解锁:
function RoleDataManager:isUnlockByFunctionType(functionType)
    if (not self._master) then return nil end
    local map = self._master:getFunctionUnlockMap()
    if functionType == PublicDefine.UnlockFunctionType.UnlockFunctionType_TreasureMap then
        local isHave = GoodsDataManager:isHavaTreasureFragment()
        local isHaveReward = #MasterDataManager:getTreasureMapList() > 0 and true or false
        -- dump(isHave, "------isHave---------")
        if (isHaveReward or isHave) and (map[functionType] == nil or map[functionType] == 1) then--系统是否解锁: 为1表示已解锁 ， 为空表示未统计 也是已解锁
            return true
        end
    elseif functionType == PublicDefine.UnlockFunctionType.UnlockFunctionType_PetDevelop then
        local pet = RoleDataManager:getScreenFightPetData()
        if pet and table.nums(pet) > 0 then
            return true
        end
    else
        if map[functionType] == nil or map[functionType] == 1 then--系统是否解锁: 为1表示已解锁 ， 为空表示未统计 也是已解锁
            return true
        end
    end
    return false
end

function RoleDataManager:addFunctionUnlock(functionType)
    if(self._master) then 
        self._master:addFunctionUnlock(functionType)
    else 
        printError("RoleDataManager:addFunctionUnlock  not master.")
    end
end

function RoleDataManager:addFunctionLock(functionType)
    if(self._master) then 
        self._master:addFunctionLock(functionType)
    else 
        printError("RoleDataManager:addFunctionLock  not master.")
    end
end

function RoleDataManager:handleScreenHorcrux(data)
    -- body
    local heroData = self:getHeroDataForSpriteID(data.spriteID)
    if(heroData) then 
        heroData:setHorcruxExteriorId(data.exteriorID)
    end
end

function RoleDataManager:getFollowPet(masterSpriteId)
    local followPets = {}
    for k, v in pairs(self._petsMap) do
        if v.masterSpriteID == masterSpriteId then
            -- return v
            table.insert(followPets, v)
        end
    end

    return followPets ~= {} and followPets or nil
end

function RoleDataManager:handleRoleRecarnation(data)
    local heroData = self:getHeroDataForSpriteID(data.spriteID)
    if(heroData) then
        -- local masterPK = self:getMasterPK()
        -- if (masterPK == heroData:getPK()) then
        --     -- 更新红点提示信息数据
        --     require "app.utils.BagNotificationUtil"
        --     BagNotificationUtil:updateUpgradableItems(true)
        -- end

        heroData:setReincarntionLv(data.reincarnationLevel)
    end

    return oldLevel
end

function RoleDataManager:setRoleReincarnationLv(lv)
    self._reincarnationLv = lv
end

function RoleDataManager:getRoleReincarnationLv(lv)
    local reinLv = self._master and self._master:getReincarntionLv() or self._reincarnationLv
    return reinLv == 0 and self._reincarnationLv or reinLv
end

function RoleDataManager:getUIShowLv()
    local lv = self._master:getUIShowLv()
    return lv
end

function RoleDataManager:getIsReincarntion()
    return self._master:getIsReincarntion()
end

function RoleDataManager:getUIShowLvByOtherData(level, reincarntionLv)
    local reLv = reincarntionLv == 0 and reincarntionLv or reincarntionLv-1
    local config = ConfigManager:getAllRoleReincarnationDataByID(reLv)
    local maxLevel = reincarntionLv == 0 and 0 or config.roleLevelCap
    local showLv = level - maxLevel
    return showLv
end

function RoleDataManager:getUIShowLvByItemData(level)
    local maxLv = 0
    local config = ConfigManager:getAllRoleReincarnationData()
    local reincarnationLv = 0
    for k, v in pairs(config) do
        if level > v.roleLevelCap then
            maxLv = v.roleLevelCap
            reincarnationLv = k
        end
        if level < v.roleLevelCap then
            break
        end
    end

    return level - maxLv, reincarnationLv
end

function RoleDataManager:getReincarntionSkillMode()
    -- local master = self:getMaster()
    -- local mode 
    -- if master then
    --     mode = master:getIsReincarntion() and SkillTreeModel.SKILL_TREE_MODEL_REINCARNATION or self:getMasterSkillTreeModel()
    -- else
    --     local reincarnationLv = self:getRoleReincarnationLv()
    --     mode = reincarnationLv > 0 and SkillTreeModel.SKILL_TREE_MODEL_REINCARNATION or self:getMasterSkillTreeModel()
    -- end
    local reincarnationLv = self:getRoleReincarnationLv()
    local mode = reincarnationLv > 0 and SkillTreeModel.SKILL_TREE_MODEL_REINCARNATION or self:getMasterSkillTreeModel()

    return mode
end

function RoleDataManager:getReincarntionSkillModeByOtherReinLv(reincarnationLv)
    local mode = reincarnationLv > 0 and SkillTreeModel.SKILL_TREE_MODEL_REINCARNATION or self:getMasterSkillTreeModel()

    return mode
end

function RoleDataManager:getHeadFrameByReinLv(reincarnationLv)
    local headFrame, levelFrame = "ui_information_headframe_box.png", "ui_information_headframe_grade.png"
    if reincarnationLv == 0 then

    elseif reincarnationLv == 1 then
        headFrame = "ui_information_headframe_box3.png"
        levelFrame = "ui_information_headframe_grade3.png"
    end

    return headFrame, levelFrame
end



--默认初始化
RoleDataManager:init()










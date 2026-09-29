--[[
   宠物相关的网络消息处理
]] --

Net = Net or {}
local NetPetSystem = {}
Net.NetPetSystem = NetPetSystem
local ProtobufUtil = require("utils.ProtobufUtil")
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
require "app.datas.PictureAlbumManager"

local DEBUG = false

-- 验证
function NetPetSystem:sendMessage()
end

-- CS 英雄使用技能（包括普通技能）,这里设计为在开始战斗使用普攻技能，技能，在次使用普攻技能，三种情况才触发。
function NetPetSystem:petUseSkillRequest(skillID, targetSpriteID, coordX, coordY)
    if DEBUG then
        print(
            "[Net.NetPetSystem] petUseSkillRequest skillID,targetSpriteID,clientServerTime=",
            skillID,
            targetSpriteID,
            coordX,
            coordY,
            GameManager:getNowServerTimestamp()
        )
    end
    if skillID then
        local messageData = {}
        messageData.skillID = skillID
        if targetSpriteID then
            messageData.targetSpriteID = targetSpriteID
        end
        if coordX then
            messageData.coordX = coordX
        end

        if coordY then
            messageData.coordY = coordY
        end

        Net.Helper:sendMessage(NetMessageType.PET_USE_SKILL_MESSAGE, messageData)
    end
end

--[[必须是场景 里的宠物（roledataManager 里的数据）]]
function NetPetSystem:getPetDetail(spriteId)
    if spriteId == nil then
        print("spriteId param is nil")
        return
    end

    local messageData = {}
    messageData.spriteId = spriteId
    -- print("getPetDetail messageData: ", messageData)
    Net.Helper:sendMessage(NetMessageType.PET_REQUEST_DETAIL_MESSAGE, messageData)
end

-- 宠物出战
function NetPetSystem:readyToFight(petId)
    if petId == nil then
        print("readyToFight petId is nil")
        return
    end

    --出战前先处理骑乘宠物
    if MasterDataManager:getPetRidingState() then
        local fPetId = MasterDataManager:getCaptainPet():getPetInstId()--MasterDataManager:getCaptainPet():getId()
        self:readyToRide(fPetId)
    end

    -- add CO-14826【宠物】减CD技能书学习后，其他宠物也受影响  清理相关的状态信息
    MasterDataManager:clearSkillVariation(PublicDefine.EObjectType.Pet)

    local messageData = {}
    messageData.petid = petId
    messageData.istakeout = true
    -- print("readyToFight messageData: ", messageData)
    Net.Helper:sendMessage(NetMessageType.PET_TOFIGHT_REQUEST_MESSAGE, messageData)
end

--宠物骑乘
function NetPetSystem:readyToRide(petId)
    print("进来了 !!!  ")
    if petId == nil then
        print("readyToRide petId is nil")
        -- RoleDataManager:handlePetRidingState({isRiding = false}, true)
        return
    end

    local curPet = MasterDataManager:getBagPetById(petId)
    if curPet:canRide() then
        local messageData = {}
        Net.Helper:sendMessage(NetMessageType.PET_REQ_RIDE_PET_MESSAGE, messageData)
    -- else
    --     RoleDataManager:handlePetRidingState({isRiding = false}, true)
    end

    -- -- add CO-14826【宠物】减CD技能书学习后，其他宠物也受影响  清理相关的状态信息
    -- MasterDataManager:clearSkillVariation(PublicDefine.EObjectType.Pet)

    -- local messageData = {}
    -- messageData.petid = petId
    -- messageData.istakeout = true
    -- -- print("readyToFight messageData: ", messageData)
    -- Net.Helper:sendMessage(NetMessageType.PET_REQ_RIDE_PET_MESSAGE, messageData)
end

--宠物跟随
function NetPetSystem:readyToFollow(petId)
    print("进来了 !!!  22222 ")
    if petId == nil then
        print("readyToFollow petId is nil")
        return
    end

    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.PET_REQ_RIDE_PET_MESSAGE, messageData)

    -- -- add CO-14826【宠物】减CD技能书学习后，其他宠物也受影响  清理相关的状态信息
    -- MasterDataManager:clearSkillVariation(PublicDefine.EObjectType.Pet)

    -- local messageData = {}
    -- messageData.petid = petId
    -- messageData.istakeout = true
    -- -- print("readyToFight messageData: ", messageData)
    -- Net.Helper:sendMessage(NetMessageType.PET_REQ_RIDE_PET_MESSAGE, messageData)
end

-- 宠物吃经验丹
function NetPetSystem:levelup(petId, itemId, itemNum)
    if petId == nil or itemId == nil or itemNum == nil then
        print("levelup param is nil")
        return
    end

    local messageData = {}
    messageData.petId = petId
    messageData.itemId = itemId
    messageData.itemNum = itemNum
    -- print("levelup messageData: ", messageData)
    Net.Helper:sendMessage(NetMessageType.PET_LEVELUP_REQUEST_MESSAGE, messageData)
end

function NetPetSystem:revive(petInstId)
    local messageData = {}
    messageData.petId = petInstId
    Net.Helper:sendMessage(NetMessageType.PET_REVIVE_REQUEST_MESSAGE, messageData)
end

-- 宠物吃洗炼丹
function NetPetSystem:reborn(petId, itemId, itemNum)
    if petId == nil or itemId == nil or itemNum == nil then
        print("reborn param is nil")
        return
    end

    local messageData = {}
    messageData.petId = petId
    messageData.itemId = itemId
    messageData.itemNum = itemNum
    -- print("reborn messageData: ", messageData)
    Net.Helper:sendMessage(NetMessageType.PET_REBORN_REQUEST_MESSAGE, messageData)
end

-- 宠物吃资质丹
function NetPetSystem:raiseQuality(petId, itemId)
    if petId == nil or itemId == nil then
        print("raiseQuality param is nil")
        return
    end

    local messageData = {}
    messageData.petId = petId
    messageData.itemId = itemId
    -- print("raiseQuality messageData: ", messageData)
    Net.Helper:sendMessage(NetMessageType.PET_RAISE_TALENT_REQUEST_MESSAGE, messageData)
end

-- 宠物学习技能
function NetPetSystem:learnSkill(petId, itemId)
    if petId == nil or itemId == nil then
        print("learnSkill param is nil")
        return
    end

    local messageData = {}
    messageData.petId = petId
    messageData.skillItem = itemId
    -- print("learnSkill messageData: ", messageData)
    Net.Helper:sendMessage(NetMessageType.PET_LEARN_SKILL_REQUEST_MESSAGE, messageData)
end

-- 宠物改名
function NetPetSystem:requestPetRename(petId, newName)
    if petId == nil or newName == nil then
        print("petRename param is nil")
        return
    end

    local messageData = {}
    messageData.petId = petId
    messageData.newName = newName
    Net.Helper:sendMessage(NetMessageType.PET_RENAME_REQUEST_MESSAGE, messageData)
end

-- 宠物合成
function NetPetSystem:compose(petId, materialIds)
    if petId == nil or materialIds == nil then
        print("compose param is nil")
        return
    end

    local messageData = {}
    messageData.petId = petId
    messageData.mergeIds = materialIds
    -- print("compose messageData: ", messageData)
    Net.Helper:sendMessage(NetMessageType.PET_COMPOSE_REQUEST_MESSAGE, messageData)
end

-- 宠物炼化
function NetPetSystem:refine(petId, refineType, skillId, isReservePet)
    if petId == nil or refineType == nil then
        print("refine param is nil")
        return
    end

    local messageData = {}
    messageData.petId = petId
    local typeStr = {"RefineTypeExp", "RefineTypeTalent", "RefineTypeSkill"}
    messageData.refineType = typeStr[refineType]
    messageData.skillId = skillId
    messageData.isReservePet = isReservePet
    -- print("refine messageData: ", messageData)
    Net.Helper:sendMessage(NetMessageType.PET_REFINE_REQUEST_MESSAGE, messageData)
end

-- 宠物一键炼化
function NetPetSystem:multipleRefine(petId)
    if petId == nil or #petId <= 0 then
        print("multipleRefine param is nil")
        return
    end

    local messageData = {}
    messageData.petIds = petId
    print(messageData)
    Net.Helper:sendMessage(NetMessageType.PET_SEND_MULTIPLE_REFINE_MESSAGE, messageData)
end

-- 宠物继承
function NetPetSystem:inherit(parentId, childId)
    if parentId == nil or childId == nil then
        printInfo("inherit param is nil")
        return
    end

    local messageData = {}
    messageData.parentPetID = parentId
    messageData.childPetID = childId

    Net.Helper:sendMessage(NetMessageType.PET_INHERIT_REQUEST_MESSAGE, messageData)
end

-- 宠物宝藏采集请求
function NetPetSystem:petTreasureGather(pets, pk)
    if not pets or #pets < 3 then
        printInfo("inherit param is nil")
        return
    end

    local messageData = {}
    messageData.petId = pets
    messageData.PK = pk
    printInfo(messageData)
    Net.Helper:sendMessage(NetMessageType.PET_TREASURE_SEND_GATHER_MESSAGE, messageData)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

-- 宠物宝藏召回请求
function NetPetSystem:petTreasureCallback(pk)
    local messageData = {}
    messageData.heroPk = pk
    printInfo(messageData)
    Net.Helper:sendMessage(NetMessageType.PET_TREASURE_SEND_CALLBACK_MESSAGE, messageData)
end

-- 宠物宝藏碎片挑战信息请求
function NetPetSystem:petTreasureChallengeInfo(pk, reload)
    local messageData = {}
    messageData.heroPk = pk
    messageData.reload = reload or 0
    printInfo(messageData)
    Net.Helper:sendMessage(NetMessageType.PET_TREASURE_SEND_CHALLENGE_INFO_MESSAGE, messageData)
end

-- 宠物宝藏碎片发起挑战
function NetPetSystem:petTreasureSendFragmentChallenge(fragmentId, index, petsId)
    local messageData = {}
    messageData.fragmentId = fragmentId
    messageData.index = index
    messageData.petsId = petsId
    printInfo(messageData)
    Net.Helper:sendMessage(NetMessageType.PET_TREASURE_SEND_CHALLENGE_MESSAGE, messageData)
end

-- 宠物宝藏碎片合成
function NetPetSystem:petTreasureCombineFragment()
    local messageData = {}
    printInfo(messageData)
    Net.Helper:sendMessage(NetMessageType.PET_TREASURE_SEND_COMBINEFRAGMENT_MESSAGE, messageData)
end

-- 宠物宝藏碎片挑战记录信息请求
function NetPetSystem:petTreasureChallengeRecords(version)
    local messageData = {}
    messageData.version = version
    printInfo(messageData)
    Net.Helper:sendMessage(NetMessageType.PET_TREASURE_SEND_CHALLENGE_RECORDS_MESSAGE, messageData)
end

-- 宠物宝藏碎片挑战发起复仇
function NetPetSystem:petTreasureChallengeRevenge(index, petsId)
    local messageData = {}
    messageData.index = index
    messageData.petsId = petsId
    printInfo(messageData)
    Net.Helper:sendMessage(NetMessageType.PET_TREASURE_SEND_CHALLENGE_REVENGE_MESSAGE, messageData)
end

-- 请求画册数据
function NetPetSystem:pictureAlbumDataRequest()
    -- local messageData = {}
    Net.Helper:sendMessage(NetMessageType.PET_ALBUM_DETAIL_MESSAGE)
end

function NetPetSystem:wearPetEquipmentRequest(petId, equipId, putOn)
    --print("wearPetEquipmentRequest=", petId, equipId, putOn)
    print(debug.traceback())
    local messageData = {}
    messageData.petId = petId
    messageData.equipId = equipId
    messageData.putOn = putOn -- true 为穿戴, false 为脱下

    Net.Helper:sendMessage(NetMessageType.PET_REQ_WEAR_PET_EQUIPMENT_MESSAGE, messageData)
end

function NetPetSystem:strengthenEquipmentRequest(equipId, petID, packageType)
    local messageData = {}
    messageData.equipId = equipId -- 装备ID
    messageData.petId = petID -- 要强化的装备在宠物装备栏时
    messageData.packetType = packageType

    Net.Helper:sendMessage(NetMessageType.PET_REQ_STRENGTHEN_EQUIPMENT_MESSAGE, messageData)
end

--兽栏解锁
function NetPetSystem:unlockPetSite()
    Net.Helper:sendMessage(NetMessageType.PETSITE_REQ_ACTIVATE_SITE)
end

--兽栏升级
function NetPetSystem:upgradePetSite(siteId, useDiamond, upgradeType)
    local messageData = {}
    messageData.siteId = siteId -- 兽栏ID
    messageData.useDiamond = useDiamond or false
    messageData.upgradeType = upgradeType or 0
    Net.Helper:sendMessage(NetMessageType.PETSITE_REQ_UPGRADE_SITE, messageData)
end

--兽栏出战
function NetPetSystem:petSiteTakeOut(data)
    local messageData = {}
    messageData.siteId = data.siteId -- 兽栏ID
    messageData.petId = data.petId -- 宠物实例ID（为0表示将兽栏中的宠物收回）
    Net.Helper:sendMessage(NetMessageType.PETSITE_REQ_PET_SITE_TAKE_OUT, messageData)
end

--宠物探险挑战
function NetPetSystem:petAdventureChallenge(level, petIds)
    local messageData = {}
    messageData.level = level -- 关卡ID
    messageData.petsId = petIds -- 出战宠物实例ID
    print("petAdventureChallenge", level, petIds)
    Net.Helper:sendMessage(NetMessageType.PET_ADV_REQ_CHALLENGE, messageData)
end

--宠物探险探索
function NetPetSystem:petAdventureExplor(level, petIds)
    local messageData = {}
    messageData.level = level -- 关卡ID
    messageData.petsId = petIds -- 出战宠物实例ID
    Net.Helper:sendMessage(NetMessageType.PET_ADV_REQ_EXPLORE, messageData)
end

--宠物探险停止探索
function NetPetSystem:petAdventureStopExplor()
    local messageData = {}
    -- messageData.level = data.level    -- 关卡ID
    -- messageData.petId = data.petId      -- 出战宠物实例ID
    Net.Helper:sendMessage(NetMessageType.PET_ADV_REQ_EXPLORE_STOP, messageData)
end

--宠物探险请求守卫数据
function NetPetSystem:petAdventureReqGuardData(data, lv)
    local messageData = {}
    messageData.robots = data --守卫id和lv
    messageData.extra = lv -- 关卡id
    Net.Helper:sendMessage(NetMessageType.PET_ADV_REQ_GUARD_DATA, messageData)
end

--宠物探险请求同步数据
function NetPetSystem:petAdventureReqPetAdvData(lastChangeTime)
    local messageData = {}
    messageData.lastChangeTime = lastChangeTime --上次同步时间
    Net.Helper:sendMessage(NetMessageType.PET_ADV_DATA_REQ_SYNC_MESSAGE, messageData)
end

--请求宠物资质加点
function NetPetSystem:petUpTalentPoint(petId, addPoint, talentType)
    local messageData = {}
    messageData.petId = petId --宠物唯一ID
    messageData.addPoint = addPoint --加点数量
    messageData.talentType = talentType --资质类型
    Net.Helper:sendMessage(NetMessageType.PET_REQ_UP_TALENT_POINT, messageData)
end

--请求重置宠物资质加点
function NetPetSystem:petResetTalentPoint(petId)
    local messageData = {}
    messageData.petId = petId --宠物唯一ID
    Net.Helper:sendMessage(NetMessageType.PET_REQ_RESET_TALENT_POINT, messageData)
end

--宠物宝石：装备打孔
function NetPetSystem:digEquipmentSlot(petId,equipId)
    local messageData = {}
    messageData.petId = petId --宠物唯一ID
    messageData.equipId = equipId --装备唯一ID
    Net.Helper:sendMessage(NetMessageType.PET_REQ_DIG_EQUIPMENT_SLOT_MESSAGE, messageData)
end

--宠物宝石：镶嵌宝石
function NetPetSystem:embedEquipmentGemStone(source,destination)
    local messageData = {}
    messageData.source = source --宝石源位置
    messageData.destination = destination --宝石目标位置
    Net.Helper:sendMessage(NetMessageType.PET_REQ_EMBED_EQUIPMENT_GEM_STONE_MESSAGE, messageData)
end

--宠物宝石：取下宝石（保留）
function NetPetSystem:takeDownEquipmentGemStone(position)
    local messageData = {}
    messageData.position = position
    Net.Helper:sendMessage(NetMessageType.PET_REQ_TAKE_DOWN_EQUIPMENT_GEM_STONE_MESSAGE, messageData)
end

--宠物宝石：吞噬宝石（保留）
function NetPetSystem:devourEquipmentGemStone(goodsData, itemList)
    local messageData = {}

    local equipId = goodsData:getEquipmentID()
    local petRoleData = MasterDataManager:getPetDataForWearEquipmentID(equipId)
    local petId = 0
    if petRoleData then
        petId = petRoleData:getPK()
    end
    
    local position = {}
    position.petId = tonumber(petId)
    position.slotIndex = goodsData:getSlotIndex() - 1
    position.equipId = equipId or 0
    position.gemId = goodsData:getEntityID()

    if position.slotIndex < 0 then
        position.slotIndex = 0
    end

    messageData.position = position
    local stuffs = {}

    for k,v in ipairs(itemList) do
        table.insert(stuffs,v:getEntityID())
    end
    messageData.stuffs = stuffs

    print("devourEquipmentGemStone   messageData ======== ",messageData)

    Net.Helper:sendMessage(NetMessageType.PET_REQ_DEVOUR_EQUIPMENT_GEM_STONE_MESSAGE, messageData)
end

--宠物转生请求
function NetPetSystem:petAdvanceRequest(petIdConfig)
    if petIdConfig == nil then
        print("petAdvanceRequest error")
        return
    end

    -- 数据包
    local messageData = {}
    messageData.id = petIdConfig.id -- 转生后数据读取的表的id
    messageData.petId = petIdConfig.petId -- 要转生的宠物id

    Net.Helper:sendMessage(NetMessageType.PET_REQ_REINCARNATION_MESSAGE, messageData)
end

--宠物突破等级上限请求
function NetPetSystem:petLvBreakRequest(petId, addLevel)
    if petId == nil or addLevel == nil then
        print("petLvBreakRequest error")
        return
    end
    print("petLvBreakRequest---->petId: ", petId)
    print("petLvBreakRequest---->addLevel: ", addLevel)
    -- 数据包
    local messageData = {}
    messageData.petId = petId -- 宠物的ID
    messageData.addLevel = addLevel -- 突破多少级

    Net.Helper:sendMessage(NetMessageType.PET_REQ_LVBREAK_MESSAGE, messageData)
end

--请求转换魂玉
function NetPetSystem:petStoneConvertRequest(data)
    -- 数据包
    local messageData = {}
    messageData.gemInstId = data.gemid -- 转换的物品id

    Net.Helper:sendMessage(NetMessageType.PET_GEM_STONE_CONVERT_REQ_MESSAGE, messageData)
end

--请求选择魂玉
function NetPetSystem:petStoneChoseRequest(data)
    -- 数据包
    local messageData = {}
    messageData.gemid = data.gemid -- 选择转换后的物品id

    Net.Helper:sendMessage(NetMessageType.PET_GEM_STONE_CONVERT_CHOSE_REQ_MESSAGE, messageData)
end

--请求魂玉缓存数据
function NetPetSystem:petStoneChoseCacheRequest()
    -- 数据包
    local messageData = {}

    Net.Helper:sendMessage(NetMessageType.PET_GEM_STONE_CONVERT_CACHE_CHOSE_REQ_MESSAGE, messageData)
end

-- 请求魂玉升阶
function NetPetSystem:reqPetGemAwakeMessage(data)
    local messageData = {}
    messageData.position = {}
    messageData.position.petId = data.petId
    messageData.position.slotIndex = data.slotIndex
    messageData.position.equipId = data.equipId
    messageData.position.gemId = data.gemId

    print("reqPetGemAwakeMessage messageData === ",messageData)

    Net.Helper:sendMessage(NetMessageType.PET_GEM_STONE_CONVERT_REQ_AWAKE_MESSAGE, messageData)
end


--请求更换宠物皮肤
function NetPetSystem:petRequestChangeSkin(data)
    -- 数据包
    local messageData = {}
    messageData.petId = data.petId
    messageData.skinId = data.skinId 

    Net.Helper:sendMessage(NetMessageType.PET_REQUEST_CHANGE_PET_SKIN, messageData)
end

-- 登录消息处理
function NetPetSystem:onPetMessageHandler(no, data)
    -- print (" Net.NetPetSystem:onNetMessageHandler :no, data  :",no)
    ---战斗相关 begin----
    if (no == NetMessageType.PET_INIT_DATA_MESSAGE.NO) then
        MasterDataManager:initPetData(data)
        if data.sites and #data.sites > 0 then
            MasterDataManager:setSiteList(data.sites)
        end
        
        -- if ProtobufUtil:checkFieldIsInit(data, "adventure") and data.adventure then
        --     mvc.petTreasureModel:setPetAdvData(data.adventure.adventure)
        -- end
        -- mvc.petTreasureModel:setPetAdvLevel(data.adventure.maxLevel or 0)
    elseif (no == NetMessageType.PET_CHANGE_DATA_MESSAGE.NO) then
        local pet = MasterDataManager:getBagPetById(data.uniqueid)
        if pet then
            pet:refreshData(data)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_DATA_REFRESH)
        end
    elseif (no == NetMessageType.PET_USE_SKILL_RESULT_MESSAGE.NO) then
        if DEBUG then
            print("PET_USE_SKILL_RESULT data = ", data)
        end
        -- 处理使用技能的结果
        local command = Command.ControlCommand:create(true)
        data.isPet = true
        command:initForTypeAndData(CommandType.CONTROL_SKILL_USE_RESULT, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.PET_NTF_SKILL_COOLDOWN_MESSAGE.NO) then
        if DEBUG then
            print("PET_NTF_SKILL_COOLDOWN_MESSAGE data = ", data)
        end
        -- local pet = RoleDataManager:getScreenFightPetData()
        local pet = RoleDataManager:getCaptain()
        -- local pet = MasterDataManager:getCaptainPet()

        if ProtobufUtil:checkFieldIsInit(data, "spriteID") then
            if pet and (pet:getSpriteID() == data.spriteID or pet:getPetInstId() == data.spriteID )then
                pet:setSkillCd(data.skillID, data.residualTime)
            end
        else
            if pet then
                pet:setSkillCd(data.skillID, data.residualTime)
            end
        end
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NOTIFY_ROLE_SKILL_COOLDOWN, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.PET_REFRESH_ALL_SKILL_CD_MESSAGE.NO) then
        if DEBUG then
            print("PET_REFRESH_ALL_SKILL_CD_MESSAGE data = ", data)
        end
    elseif (no == NetMessageType.PET_ADD_BUFF_MESSAGE.NO) then
        if DEBUG then
            print("PET_ADD_BUFF_MESSAGE data = ", data)
        end
        local command = Command.ControlCommand:create(true)
        command:initForAddBuff(data, false)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.PET_REMOVE_BUFF_MESSAGE.NO) then
        if DEBUG then
            print("PET_REMOVE_BUFF_MESSAGE data = ", data)
        end
        SkillDataManager:deleteBuff(data.targetSpriteID, data.entityID)
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REMOVE_BUFFER, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.PET_ADD_EFFECT_MESSAGE.NO) then
        if DEBUG then
            print("PET_ADD_EFFECT_MESSAGE data = ", data)
        end
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ADD_EFFECT, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.PET_GET_SKILL_LIST_MESSAGE.NO) then
        if DEBUG then
            print("NetMessageType.PET_GET_SKILL_LIST_MESSAGE data = ", data)
        end
        -- 处理技能初始化
        local pk = GameDataManager:getInstance():getMasterPK()
        for k, oneData in ipairs(data.skills) do
            local skillData = SkillDataManager:createSkillForSkillId(oneData.skillID)
            if (skillData) then
                skillData:setIsOpening(oneData.isOpen)
                SkillDataManager:addSkill(pk, skillData)
            end
        end
    elseif (no == NetMessageType.PET_SCREEN_PET_MESSAGE.NO) then
        if not SceneManager:getInstance():isInPetPVP() then
            --同屏同步宠物消息
            local master = GameDataManager:getInstance():getMaster()
            local _, isNeedRefresh = RoleDataManager:handleScreenPetData(data)
            if master and data.masterSpriteID == master:getSpriteID() then
                local curPet = MasterDataManager:getBagPetById(data.petInstId)
                if curPet then
                    curPet:setReadyFight(true)
                end
                local petData = MasterDataManager:getFightPetbyId(data.petInstId)--(data.spriteID)
                petData = Data.PetRoleData:create()
                petData:init(data, false)
                MasterDataManager:setFightPet(petData)

                if isNeedRefresh then
                    Avalon.MessageCenter:notice(GameMessage.MC_COMMON_SHOW_PET)
                end
                Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_READY_FIGHT_OK, data.petInstId)
            end
            local hero = RoleDataManager:getHeroDataForSpriteID(data.masterSpriteID)
            if hero then
                local SceneManager = require("app.game.SceneManager")
                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_SCREENPET, data)
                SceneManager:getInstance():pushCommand(command)
            end
            -- end

            -- Avalon.Scheduler:setDelayForUpdateOnce(self, function()
            local transData = data
            transData.petSpriteId = data.spriteID
            transData.heroSpriteId = data.masterSpriteID
            -- print("   transData ===11111111111=== ",transData)
            RoleDataManager:handlePetRidingState(transData)
        -- end, 1)
        end
    elseif (no == NetMessageType.PET_SYNC_RIDE_PET_MESSAGE.NO) then
        -- print("PET_SYNC_RIDE_PET_MESSAGE ===2222222=== ",data)
        if not SceneManager:getInstance():isInPetPVP() then
            --同步到屏幕周围骑行状态 data.isRiding 代表骑乘的一种行为
            local petData = RoleDataManager:getScreenPetDataByID(data.petSpriteId)
            if petData then
                petData:setReadyRide(data.isRiding)
            else
                print("  petData 为空 ", data)
            end

            RoleDataManager:handlePetRidingState(data)
        end
    elseif (no == NetMessageType.PET_RESP_RIDE_PET_MESSAGE.NO) then
        --上宠物的后果
        -- print("PET_RESP_RIDE_PET_MESSAGE ==3333333333==== ",data,data.petId)
        if not SceneManager:getInstance():isInPetPVP() then
            local curPet = MasterDataManager:getBagPetById(data.petId)
            MasterDataManager:setRidePet(curPet, data.ride)
            MasterDataManager:setPetRidingState(data.ride)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_READY_FIGHT_OK, data.petId)
            RoleDataManager:handlePetRidingState({isRiding = data.ride}, true)
        end
    elseif (no == NetMessageType.PET_RESPONSE_DETAIL_MESSAGE.NO) then
        local pet = MasterDataManager:getBagPetById(data.pet.uniqueid)
        if pet then
            mvc.openPanel("Pet", "PetMain", {tabIdx = 1, innerTabIdx = 1, petID = pet:getId()})
        else
            pet = Data.PetRoleData:create()
            pet:init(data.pet, true)
            mvc.openPanel("Pet", "PetLookMain", {pet = pet, isShow = false})
        end
    elseif (no == NetMessageType.PET_GET_BUFF_LIST_MESSAGE.NO) then
        SkillDataManager:savePetRecoverBuffData(data.buffInfo)
    elseif (no == NetMessageType.PET_REFRESH_BUFF_BY_KIND_MESSAGE.NO) then
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REFRESH_BUFFER_BY_KIND, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.PET_REFRESH_BUFF_BY_INSTID_MESSAGE.NO) then
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REFRESH_BUFFER_BY_EFFECT, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.PET_REVIVE_RESPONSE_MESSAGE.NO) then
        -- 复活完成，队友，同屏都会收到
        if (data.result == 1) then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_ROLE_REVIVE, data)
            local SceneManager = require("app.game.SceneManager")
            SceneManager:getInstance():pushCommand(command)
            local pet = RoleDataManager:getScreenPetDataByID(data.spriteID)
            if pet then
                pet:setIsDead(false)
            end
            -- local pets = RoleDataManager:getScreenFightPetData()
            -- if pets then
            --     for k, pet in pairs(pets) do
            --         if pet and pet:getSpriteID() == data.spriteID and not SceneManager:getInstance():isInPetPVP() then
            --             MasterDataManager:setPetReviveTimes(data.revivetimes)
            --         end
            --     end
            -- end
            MasterDataManager:setPetSiteReviveTimes(data)

            Avalon.MessageCenter:notice(GameMessage.MC_PET_REVIVE, data.spriteID)
        else
            -- 处理是否由于数据不同步导致的复活失败的问题
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.PET_TOFIGHT_RESPONSE_MESSAGE.NO) then
        -- end
        if DEBUG then
            print("PET_GET_NEW_PET_MESSAGE data = ", data)
        end
        -- local curPet = MasterDataManager:getBagPetById(data.petid)
        
        -- if curPet then
        --     -- curPet:setReadyFight(true)
        --     local petData = MasterDataManager:getFightPetbyId(data.petid)--(data.spriteID)
        --     if(not petData) then
        --         petData = Data.PetRoleData:create()
        --         petData:init(data, false, true)
        --         MasterDataManager:setFightPet(petData)
        --     end
        --     -- Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_READY_FIGHT_OK, data.petid)
        -- end
        
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_SITE_TAKE_OUT_RESULT, data)
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_READY_FIGHT_OK)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_LEVELUP_OK, data.petid)

        -- --成功出战后,如果该宠物能骑乘,则通知服务器骑乘行为
        -- self:readyToRide(data.petid)

        -- if data.isRiding then
        if data.siteId == 0 then
            local curPet = MasterDataManager:getBagPetById(data.petid)
            MasterDataManager:setRidePet(curPet, data.isRiding)
            MasterDataManager:setPetRidingState(data.isRiding)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_READY_FIGHT_OK, data.petid)
            RoleDataManager:handlePetRidingState({isRiding = data.isRiding}, true)
        end
        
    elseif (no == NetMessageType.PET_TOFIGHT_STATUS_MESSAGE.NO) then
        ---战斗相关 end----
        ---养成相关 begin----
    elseif (no == NetMessageType.PET_GET_NEW_PET_MESSAGE.NO) then
        if DEBUG then
            print("PET_GET_NEW_PET_MESSAGE data = ", data)
        end

        if not data.issuccess then
            print("PET_GET_NEW_PET_MESSAGE Faild")
            return
        end

        if not (ProtobufUtil:checkFieldIsInit(data, "petId")) then
            print("PET_GET_NEW_PET_MESSAGE ERR, petId is nil")
            return
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(
            CommandType.CONTORL_UNLOCK_FUNCTION,
            PublicDefine.UnlockFunctionType.UnlockFunctionType_PetDevelop
        )
        SceneManager:getInstance():pushCommand(command)

        mvc.petModel:getNewPet(data.petId)
    elseif (no == NetMessageType.PET_LEVELUP_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_LEVELUP_RESPONSE_MESSAGE data = ", data)
        end

        if data.result ~= "UpLevelResultOK" then
            print("PET_LEVELUP_RESPONSE_MESSAGE result is err: ")
            return
        end

        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_LEVELUP_OK, data.petId)
    elseif (no == NetMessageType.PET_REBORN_RESPONSE_MESSAGE.NO) then
        --如果变异 客户端回收一下宠物再创建
        -- if isVariant and pet:isFight() then
        --     local fPet = RoleDataManager:getScreenFightPetData()
        --     if fPet then
        --         fPet:setVariant(true)
        --         Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, fPet)
        --         local battleCmd = Command.BattleCommand:create()
        --         battleCmd:initRefreshPetInScreen(fPet:getSpriteID())
        --         SceneManager:getInstance():pushCommand(battleCmd)
        --     end
        -- end
        if DEBUG then
            print("PET_REBORN_RESPONSE_MESSAGE data = ", data)
        end

        if data.result ~= "RebornResultOK" then
            print("PET_REBORN_RESPONSE_MESSAGE result is err")
            return
        end

        local isVariant = false
        if ProtobufUtil:checkFieldIsInit(data, "isMutated") then
            isVariant = data.isMutated
        end

        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end

        local LanguageManager = require("app.game.LanguageManager")
        local textStr = UI.TEXT_1213678
        textStr = PlaceholderUtil:formatName(textStr, data.itemId)
        textStr = string.format(textStr, data.itemNum)
        Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, textStr)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REBORN_OK, {id = data.petId, isVariant = isVariant})

        if isVariant then
            local isRiding = MasterDataManager:getPetRidingState()
            local masterData = RoleDataManager:getMaster()
            local heroSpriteId = masterData:getSpriteID()

            local MachineManager = require("app.game.MachineManager")
            local model = MachineManager:getInstance():getMachine():getModel()
            local heroRole = model:getRoleBySpriteID(heroSpriteId)

            if heroRole then
                local heroModelId = heroRole:getId()
                print("RENDERER_HERO_RIDEnnnnn", pet:getSiteId())
                local data2 = {
                    isRiding = false,
                    petSiteId = pet:getSiteId()
                }
                local data3 = {
                    isRiding = isRiding,
                    petSiteId = pet:getSiteId()
                }
                local ridingCMD = Command.RendererCommand:create(true)
                ridingCMD:initForTypeAndData(CommandType.RENDERER_HERO_RIDE, heroModelId, data2)
                SceneManager:getInstance():pushCommand(ridingCMD)

                local ridingCMD2 = Command.RendererCommand:create(true)
                ridingCMD2:initForTypeAndData(CommandType.RENDERER_HERO_RIDE, heroModelId, data3)
                SceneManager:getInstance():pushCommand(ridingCMD2)
            end
        end
    elseif (no == NetMessageType.PET_RAISE_TALENT_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_RAISE_TALENT_RESPONSE_MESSAGE data = ", data)
        end

        if data.result ~= "UpTalentResultOK" then
            print("PET_RAISE_TALENT_RESPONSE_MESSAGE result is err")
            return
        end

        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end

        local LanguageManager = require("app.game.LanguageManager")
        local textStr = UI.TEXT_1213678
        textStr = PlaceholderUtil:formatName(textStr, data.itemId)
        textStr = string.format(textStr, 1)
        Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, textStr)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_RAISE_QUALITY_OK, data)
    elseif (no == NetMessageType.PET_LEARN_SKILL_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_LEARN_SKILL_RESPONSE_MESSAGE data = ", data)
        end

        if data.result ~= "StudySkillResultOK" then
            print("PET_LEARN_SKILL_RESPONSE_MESSAGE result is err")
            return
        end

        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_LEARN_SKILL_OK, data.petId)
    elseif (no == NetMessageType.PET_COMPOSE_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_COMPOSE_RESPONSE_MESSAGE data = ", data)
        end

        if data.result ~= "MergeResultOK" then
            print("PET_COMPOSE_RESPONSE_MESSAGE result is err")
            return
        end

        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_COMPOSE_OK, data.petId, data.mergeIds)
    elseif (no == NetMessageType.PET_REFINE_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_REFINE_RESPONSE_MESSAGE data = ", data)
        end
        if data.result == "RefineResultInPetTreasure" then
            UI.ScrollBar:createByText(UI.TEXT_221112)
            return
        elseif data.result == "RefineResultInPetAdventure" then
            UI.ScrollBar:createByText(UI.TEXT_221111)
            return
        elseif data.result ~= "RefineResultOK" then
            print("PET_REFINE_RESPONSE_MESSAGE result is err")
            return
        end

        local skillId = 0
        if ProtobufUtil:checkFieldIsInit(data, "skillId") then
            skillId = data.skillId
        end

        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REFINE_OK, data)
    elseif (no == NetMessageType.PET_RESPONSE_MULTIPLE_REFINE_MESSAGE.NO) then
        if DEBUG then
            print("PET_RESPONSE_MULTIPLE_REFINE_MESSAGE data = ", data)
        end

        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_RESPONSE_MULTIPLE_REFINE_MESSAGE result is err : " .. data.result)
            return
        end

        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REFINE_OK, data, true)
    elseif (no == NetMessageType.PET_INHERIT_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_INHERIT_RESPONSE_MESSAGE data = ", data)
        end

        if data.result ~= "InheritPetSkillResultOK" then
            print("PET_INHERIT_RESPONSE_MESSAGE result is err")
            return
        end

        local parentPet = MasterDataManager:getBagPetById(tostring(data.parentPetID))
        if parentPet then
            parentPet:calculateFightAttrs()
        end

        local childPet = MasterDataManager:getBagPetById(tostring(data.childPetID))
        if childPet then
            childPet:calculateFightAttrs()
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_INHERIT_OK, data.parentPetID, data.childPetID)
    elseif (no == NetMessageType.PET_TREASURE_INFO_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_TREASURE_INFO_RESPONSE_MESSAGE data = ", data)
        end

        mvc.send("PetTreasure_Handle_Gather_Data", data)
    elseif (no == NetMessageType.PET_TREASURE_RESPONSE_GATHER_MESSAGE.NO) then
        if DEBUG then
            print("PET_TREASURE_INFO_RESPONSE_MESSAGE data = ", data)
        end

        if data.sendPetsResult ~= "SendPets_Suc" then
            print("PET_TREASURE_RESPONSE_GATHER_MESSAGE result is err")
            return
        end

        mvc.send("PetTreasure_Handle_Gather_Pets", data)
    elseif (no == NetMessageType.PET_TREASURE_RESPONSE_CALLBACK_MESSAGE.NO) then
        if DEBUG then
            print("PET_TREASURE_RESPONSE_CALLBACK_MESSAGE data = ", data)
        end

        mvc.send("PetTreasure_Handle_Callback_Gather_Pets", data)
    elseif (no == NetMessageType.PET_TREASURE_RESPONSE_FRAGMENTS_UPDATE_MESSAGE.NO) then
        if data.isUpdate then
            mvc.send("PetTreasure_Handle_Fragments_update")
        end
    elseif (no == NetMessageType.PET_TREASURE_RESPONSE_CHALLENGE_INFO_MESSAGE.NO) then
        if DEBUG then
            print("PET_TREASURE_RESPONSE_CHALLENGE_INFO_MESSAGE data = ", data)
        end

        mvc.send("PetTreasure_Handle_Battle_Info_Pets", data)
    elseif (no == NetMessageType.PET_TREASURE_RESPONSE_CHALLENGE_MESSAGE.NO) then
        if DEBUG then
            print("PET_TREASURE_RESPONSE_CHALLENGE_MESSAGE data = ", data)
        end

        mvc.send("PetTreasure_Handle_Battle_Pets", data)
    elseif (no == NetMessageType.PET_TREASURE_RESPONSE_COMBINEFRAGMENT_MESSAGE.NO) then
        if DEBUG then
            print("PET_TREASURE_RESPONSE_COMBINEFRAGMENT_MESSAGE data = ", data)
        end

        mvc.send("PetTreasure_Handle_Fragment_Compound_Pets", data)
    elseif (no == NetMessageType.PET_TREASURE_RESPONSE_CHALLENGE_RECORDS_MESSAGE.NO) then
        if DEBUG then
            print("PET_TREASURE_RESPONSE_CHALLENGE_RECORDS_MESSAGE data = ", data)
        end

        mvc.send("PetTreasure_Handle_Battle_Record_Pets", data)
    elseif (no == NetMessageType.PET_TREASURE_RESPONSE_CHALLENGE_REVENGE_MESSAGE.NO) then
        if DEBUG then
            print("PET_TREASURE_RESPONSE_CHALLENGE_REVENGE_MESSAGE data = ", data)
        end

        mvc.send("PetTreasure_Handle_Battle_Revenge_Pets", data)
    elseif (no == NetMessageType.PET_REMOVE_RESPONSE_MESSAGE.NO) then
        -- 改名相关 --
        if DEBUG then
            print("PET_REMOVE_RESPONSE_MESSAGE data = ", data)
        end

        MasterDataManager:delBagPetById(data.petId)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REMOVE, data.petId)
    elseif (no == NetMessageType.PET_RENAME_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_RENAME_RESPONSE_MESSAGE data = ", data)
        end

        if data.result ~= "ChangeNameResultOK" then
            print("PET_RENAME_RESPONSE_MESSAGE result is err")
            return
        else
            local pet = MasterDataManager:getBagPetById(data.petId)
            if pet and pet:isFight() then
                --出战宠物才有当前血量
                local fPets = RoleDataManager:getScreenFightPetData()
                -- local fPets = MasterDataManager:getFightPet()
                if fPets then
                    for _, fPet in pairs(fPets) do
                        if tostring(fPet:getPetInstId()) == tostring(data.petId) then
                            fPet:setNickName(data.newName)
                            fPet:setNameTimes(pet:getNameTimes() + 1)
                            local command = Command.ControlCommand:create(true)
                            command:initForTypeAndData(CommandType.CONTROL_EDIT_NICK_NAME, fPet)
                            SceneManager:getInstance():pushCommand(command)
                        end
                    end
                end
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, MasterDataManager:getCaptainPet())--RoleDataManager:getCaptain())
            end
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_RENAME_OK, data)
    elseif (no == NetMessageType.PET_RENAME_NOTIFY_MESSAGE.NO) then
        ---养成相关 end----
        local fPet = RoleDataManager:getScreenPetDataByID(data.spriteID)
        if fPet then
            fPet:setNickName(data.nickName)
            fPet:setNameTimes(fPet:getNameTimes() + 1)
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_EDIT_NICK_NAME, fPet)
            SceneManager:getInstance():pushCommand(command)
        end
    elseif (no == NetMessageType.PET_UNLOCK_LIST_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_UNLOCK_LIST_RESPONSE_MESSAGE data = ", data)
        end
        mvc.petModel:receiveUnlockPets(data.pets)
    elseif (no == NetMessageType.PET_UNLOCK_ONE_RESPONSE_MESSAGE.NO) then
        if DEBUG then
            print("PET_UNLOCK_ONE_RESPONSE_MESSAGE data = ", data)
        end
        mvc.petModel:addUnlockOnePet(data.pet)
    elseif (no == NetMessageType.PET_PVP_SCREEN_DATA_MESSAGE.NO) then
        table.sort(
            data.pets,
            function(a, b)
                if a.coordX == b.coordX then
                    return a.coordY > b.coordY
                end
                return a.coordX < b.coordX
            end
        )
        table.sort(
            data.monsters,
            function(a, b)
                if a.coordX == b.coordX then
                    return a.coordY > b.coordY
                end
                return a.coordX < b.coordX
            end
        )

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REMOVEALLOTHERSCREENROLE)
        local MachineManager = require("app.game.MachineManager")
        MachineManager:getInstance():getMachine():executeCommand(command)

        local SceneManager = require("app.game.SceneManager")
        local cmdData = {}
        cmdData.transType = "Switch"
        cmdData.transReason = "BeginPetPVP"
        local command = Command.ControlCommand:create(true)

        command:initForTypeAndData(CommandType.CONTROL_BEGIN_TRANS_SCENE, cmdData)
        SceneManager:getInstance():pushCommand(command)

        local sceneType = SceneManager:getInstance():getSceneType()
        cmdData = {}
        cmdData.type = sceneType == PublicDefine.SCENE_TYPE.TOWN_CAVE and PublicDefine.SCENE_TYPE.TOWN or sceneType--PublicDefine.SCENE_TYPE.BIGSAILPORT
        cmdData.caveMode = PublicDefine.CAVE_MODE.MODE_PET
        local cfgData = ConfigManager:getPetTreasureByRoleLv(data.heros[1].roleLV)
        if sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT then
            cmdData.level = data.mapID
        else
            cmdData.level = cfgData.mapid
        end
        

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_LOADSCENCE, cmdData)
        SceneManager:getInstance():pushCommand(command)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_WAITING_BEGIN_SYNC, cmdData)
        SceneManager:getInstance():pushCommand(command)

        -- print("------data.pets------", data.pets)

        for k, v in ipairs(data.pets) do
            local petData = RoleDataManager:handleScreenPetData(v)
            if petData then
                petData:setIsEnemy(k > 3)
            end
            local SceneManager = require("app.game.SceneManager")
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_SCREENPET, v)
            SceneManager:getInstance():pushCommand(command)
        end

        
        for k, monsterDetail in ipairs(data.monsters) do
            local heroDetail = data.heros[k]
            if heroDetail then
                local data = {}
                data.spriteID = monsterDetail.spriteID
                if heroDetail.pk == 0 then
                    data.nickName = UI.TEXT_1314124
                else
                    data.nickName = heroDetail.nickName
                end
                data.faceDecodeID = heroDetail.faceDecodeID
                data.sex = heroDetail.sex
                data.coordX = monsterDetail.coordX
                data.coordY = monsterDetail.coordY
                data.equipment = heroDetail.equipShow
                data.roleLV = heroDetail.roleLV

                -- 大航海驱逐岛怪
                if sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT and heroDetail.pk == 0 then
                    data.islandMonster = true
                else
                    data.islandMonster = false
                end
    
                local heroData = RoleDataManager:handleScreenHeroData(data)
                if heroData then
                    heroData:setIsEnemy(k > 1)
                end
                -- 大航海驱逐不显示英雄
                if sceneType ~= PublicDefine.SCENE_TYPE.BIGSAILPORT then
                    local command = Command.ControlCommand:create(true)
                    command:initForTypeAndData(CommandType.CONTROL_SCREENHERO, data)
                    SceneManager:getInstance():pushCommand(command)
                end
            end
        end
        
        if sceneType == PublicDefine.SCENE_TYPE.BIGSAILPORT and #data.pets < 6 then
            RoleDataManager:initPetPVERoles(data.monsters, data.pets)
        else
            RoleDataManager:initPetPVPRoles(data.monsters, data.pets)
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_INIT_PET_PVP_DATA)
    elseif (no == NetMessageType.PET_PVP_FIGHT_END_MESSAGE.NO) then
        local petPVPRoles = RoleDataManager:getPetPVPRoles()
        if petPVPRoles ~= nil then
            for k, spriteID in ipairs(petPVPRoles.myRoles.pets) do
                local SceneManager = require("app.game.SceneManager")
                local command = Command.BattleCommand:create(true)
                command:initForTypeAndData(CommandType.BATTLE_END, spriteID)
                SceneManager:getInstance():pushCommand(command)
            end
            for k, spriteID in ipairs(petPVPRoles.enemyRoles.pets) do
                local SceneManager = require("app.game.SceneManager")
                local command = Command.BattleCommand:create(true)
                command:initForTypeAndData(CommandType.BATTLE_END, spriteID)
                SceneManager:getInstance():pushCommand(command)
            end
        end

        if SceneManager:getInstance():isInPort() and mvc.bigSailIslandModel:getisExpelMore() then
            mvc.bigSailIslandModel:saveExpelInfo(data)

            local AllFightNums = mvc.bigSailIslandModel:getExpelEndNum()
            if AllFightNums > 0 then
                -- 总共战斗场次
                local nowAddFightNums = #mvc.bigSailIslandModel:getExpelInfo()
                if nowAddFightNums == AllFightNums then
                    UI.WaitingLayer:hideWaiting()
                    -- 当前所有场次的数据都已经加载完毕
                    mvc.openPanel("BigSailIsland","BigSailIslandRankResult")
                end
            end
        else
            print(debug.traceback("MC_UI_OPEN_PETPVPEND"))
            -- 在大航海多次驱逐船只时，不显示所有战斗流程，显示结果只通过结算界面点击显示。
            local expelBaseData = mvc.bigSailIslandModel:getExpelSettleData()
            -- print("expelBaseData ========  ")
            -- dump(expelBaseData,nil,10)

            local showData = clone(data)
            showData.myPower = expelBaseData.myPower or 0
            showData.otherPower = expelBaseData.otherPower or 0
            showData.num = expelBaseData.num or 0
            showData.mysupply = expelBaseData.mysupply or 0
            showData.othersuppy = expelBaseData.othersuppy or 0
            showData.mysupply = expelBaseData.mysupply or 0
            Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_PETPVPEND, showData)
        end
    elseif (no == NetMessageType.PET_ALBUM_DETAIL_RESPONSE_MESSAGE.NO) then
        -- if(DEBUG) then
        print("  PET_ALBUM_DETAIL_RESPONSE_MESSAGE ", data)
        -- end
        PictureAlbumManager:updateAllData(data)

        Avalon.MessageCenter:notice(AvalonMessage.MC_PICTURE_ALBUM)
    elseif (no == NetMessageType.PET_ALBUM_DETAIL_SYNC_MESSAGE.NO) then
        -- if(DEBUG) then
        print("  PET_ALBUM_DETAIL_SYNC_MESSAGE ", data)
        -- end
        PictureAlbumManager:addData(data)
    elseif (no == NetMessageType.PET_RESP_WEAR_PET_EQUIPMENT_MESSAGE.NO) then
        -- message RespWearPetEquipmentMessage
        -- {
        --     required uint32 result = 1;         // PublicDefine.ErrNo
        --     required uint64 petId = 2;
        --     required uint64 equipId = 3;
        --     required bool putOn = 4;            // true 为穿戴, false 为脱下
        -- }
        -- SC 穿戴装备返回
        print("PET_RESP_WEAR_PET_EQUIPMENT_MESSAGE", data)

        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_WEAR_EQUIPMENT_RESULT, data)
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.PET_RESP_STRENGTHEN_EQUIPMENT_MESSAGE.NO) then
        -- message RespStrengthenEquipmentMessage
        -- {
        --     required uint32 result = 1;                 // PublicDefine.ErrNo
        --     required uint64 equipId = 2;                // 装备ID
        --     optional uint64 petId = 3;                  // 要强化的装备在宠物装备栏时
        -- }
        --解锁兽栏
        -- SC 强化宠物装备返回
        print("PET_RESP_STRENGTHEN_EQUIPMENT_MESSAGE", data)
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.PET_STRENGTHEN)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_STRENGTHEN_EQUIPMENT_RESULT, data)
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.PETSITE_RSP_ACTIVATE_SITE.NO) then
        --解锁兽栏
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        -- dump(data, "MC_UI_PET_SITE_UNLOCK_RESULT")
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_SITE_UNLOCK_RESULT, data)
    elseif (no == NetMessageType.PETSITE_RSP_UPGRADE_SITE.NO) then
        --升级兽栏
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_SITE_UPGRADE_RESULT, data)
    elseif (no == NetMessageType.PETSITE_RSP_PET_SITE_TAKE_OUT.NO) then
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        -- dump(data, "MC_UI_PET_SITE_TAKE_OUT_RESULT")
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_SITE_TAKE_OUT_RESULT, data)
    elseif (no == NetMessageType.PET_ADV_DATA_SYNC_MESSAGE.NO) then
        --宠物探险数据同步
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        dump(data, "PET_ADV_DATA_SYNC_MESSAGE")
        -- print("PET_ADV_DATA_SYNC_MESSAGE", data.data.maxLevel)
        mvc.petTreasureModel:setPetAdvData(data.data.adventure)
        mvc.petTreasureModel:setPetAdvLevel(data.data.maxLevel or 0)
        mvc.petTreasureModel:setLastChangeTime(data.lastChangeTime)
        mvc.send("PetAdventure_Update_Explor_Layer")
    elseif (no == NetMessageType.PET_ADV_RSP_GUARD_DATA.NO) then
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        -- dump(data, "PET_ADV_RSP_GUARD_DATA")
        mvc.send("PetAdventure_Handle_Level_Guard_Data_REQ_Callback", data)
    elseif (no == NetMessageType.PET_ADV_RSP_CHALLENGE.NO) then
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        -- dump(data, "PET_ADV_RSP_CHALLENGE")
        mvc.send("PetAdventure_Handle_Challenge_Callback", data)
    elseif (no == NetMessageType.PET_ADV_RSP_EXPLORE.NO) then
        -- dump(data, "PET_ADV_RSP_EXPLORE")
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        mvc.send("PetAdventure_Handle_Explore_Callback", data)
    elseif (no == NetMessageType.PET_ADV_RSP_EXPLORE_STOP.NO) then
        -- dump(data, "PET_ADV_RSP_EXPLORE")
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        mvc.send("PetAdventure_Handle_Explore_Stop_Callback")
    elseif (no == NetMessageType.PET_RSP_UP_TALENT_POINT.NO) then
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end
        UI.ScrollBar:createByText(UI.TEXT_224005)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_ON_TALENT_POINT_UPDATE, data.petId)
    elseif (no == NetMessageType.PET_RSP_RESET_TALENT_POINT.NO) then
        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            GameErrorManager:showError(data.result)
            return
        end
        local pet = MasterDataManager:getBagPetById(data.petId)
        if pet then
            pet:calculateFightAttrs()
        end
        UI.ScrollBar:createByText(UI.TEXT_224006)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_ON_TALENT_POINT_UPDATE, data.petId)
    elseif (no == NetMessageType.PET_RESP_DIG_EQUIPMENT_SLOT_MESSAGE.NO) then
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_RESP_DIG_EQUIPMENT_SLOT_MESSAGE result is err : " .. data.result)
            return
        end

        local equipmentData = GoodsDataManager:getEquipmentForEntityID(data.equipId)
        if not equipmentData then
            equipmentData = mvc.petGemStoneDevelopmentModel:getFightPetWearEquipmentDataByEntityId(data.equipId)
        end
        if(equipmentData) then
            local netData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData",data.equipData.goodsDataBytes)
            -- equipmentData:setSlotsData(data.equipData.)

            local num = equipmentData.num
            local isLock = equipmentData.isLock
            local index = equipmentData.index
            local isGolden = equipmentData.isGolden
            equipmentData:initNetData(netData,num,isGolden,isLock,index)

            if mvc.petGemStoneDevelopmentController then
                -- 本次是在装备打孔界面打孔,需要刷新孔的状态信息
                mvc.petGemStoneDevelopmentController:refreshLeftView(1, equipmentData)
            end
        end

        local petEquipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE,petEquipmentArr)
        local equipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,equipmentArr)
        local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

        UI.WaitingLayer:hideWaiting()
    elseif (no == NetMessageType.PET_RESP_EMBED_EQUIPMENT_GEM_STONE_MESSAGE.NO) then
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_RESP_EMBED_EQUIPMENT_GEM_STONE_MESSAGE result is err : " .. data.result)
            return
        end

        print("  PET_RESP_EMBED_EQUIPMENT_GEM_STONE_MESSAGE ==== ",data)

        if data.destEquipData then
            local netData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData",data.destEquipData.goodsDataBytes)

            local equipmentData = GoodsDataManager:getEquipmentForEntityID(netData.entityID)
            if not equipmentData then
                equipmentData = mvc.petGemStoneDevelopmentModel:getFightPetWearEquipmentDataByEntityId(netData.entityID)
            end

            if(equipmentData) then
                local num = equipmentData.num
                local isLock = equipmentData.isLock
                local index = equipmentData.index
                local isGolden = equipmentData.isGolden
                equipmentData:initNetData(netData,num,isGolden,isLock,index)
            end

            local destination = data.destination
            local slotIndex = 0
            if destination then
                slotIndex = destination.slotIndex
            end
            mvc.petGemStoneDevelopmentController:refreshLeftView(3, equipmentData,slotIndex + 1)

            local petEquipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE,petEquipmentArr)
            local equipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,equipmentArr)
            local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

            UI.WaitingLayer:hideWaiting()
            
        end

    elseif (no == NetMessageType.PET_RESP_TAKE_DOWN_EQUIPMENT_GEM_STONE_MESSAGE.NO) then
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_RESP_TAKE_DOWN_EQUIPMENT_GEM_STONE_MESSAGE result is err : " .. data.result)
            return
        end
        print("PET_RESP_TAKE_DOWN_EQUIPMENT_GEM_STONE_MESSAGE ===== ",data)

        if data.equipData then
            local netData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData",data.equipData.goodsDataBytes)

            local equipmentData = GoodsDataManager:getEquipmentForEntityID(netData.entityID)
            if not equipmentData then
                equipmentData = mvc.petGemStoneDevelopmentModel:getFightPetWearEquipmentDataByEntityId(netData.entityID)
            end

            if(equipmentData) then
                local num = equipmentData.num
                local isLock = equipmentData.isLock
                local index = equipmentData.index
                local isGolden = equipmentData.isGolden
                equipmentData:initNetData(netData,num,isGolden,isLock,index)
            end

            local destination = data.position
            local slotIndex = 0
            if destination then
                slotIndex = destination.slotIndex
            end
            mvc.petGemStoneDevelopmentController:refreshLeftView(3, equipmentData,slotIndex + 1)

            local petEquipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE,petEquipmentArr)
            local equipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,equipmentArr)
            local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

            UI.WaitingLayer:hideWaiting()
            
        end
    elseif (no == NetMessageType.PET_RESP_DEVOUR_EQUIPMENT_GEM_STONE_MESSAGE.NO) then
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_RESP_DEVOUR_EQUIPMENT_GEM_STONE_MESSAGE result is err : " .. data.result)
            return
        end

        if data.goodsData then
            local goodsData = nil
            if data.position.equipId == 0 then --证明吞噬者是宝石背包的数据
                local netData = ProtobufUtil:decode("GoodsSystem.PetGemStoneData",data.goodsData.goodsDataBytes)
                
                local master = RoleDataManager:getMaster()
                if (not master) then return end
                local stoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_PET_GEMSTONE,PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
                if stoneArr then
                    local gData = nil
                    for k,v in pairs(stoneArr) do
                        if v:getEntityID() == netData.entityID then
                            gData = v
                            break
                        end
                    end

                    if gData then
                        gData:initNetData(netData,gData.num,gData.isGolden,gData.isLock,gData.index,gData.equipId)
                        goodsData = gData
                    end
                end

                --mvc.petGemStoneDevelopmentController:refreshLeftViewTwo(goodsData)
                mvc.petGemStoneDevelopmentController:refreshStoneTriggerAnimation(goodsData)
            else --否则是装备数据
                local netData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData",data.goodsData.goodsDataBytes)

                local equipmentData = GoodsDataManager:getEquipmentForEntityID(netData.entityID)
                if not equipmentData then
                    equipmentData = mvc.petGemStoneDevelopmentModel:getFightPetWearEquipmentDataByEntityId(netData.entityID)
                end

                if(equipmentData) then
                    local num = equipmentData.num
                    local isLock = equipmentData.isLock
                    local index = equipmentData.index
                    local isGolden = equipmentData.isGolden
                    equipmentData:initNetData(netData,num,isGolden,isLock,index)
                end

                -- print("  data.position ==== ",data.position, data.position.slotIndex, netData.slots)
                local slotNetData = netData.slots[data.position.slotIndex + 1]
                slotNetData.entityID = 0
                local goodsData = mvc.petGemStoneDevelopmentModel:createPetStoneData(slotNetData,data.position.equipId,data.position.slotIndex + 1)
                if goodsData then
                    goodsData:setIsNew(false)
                    --mvc.petGemStoneDevelopmentController:refreshLeftViewTwo(goodsData)
                    mvc.petGemStoneDevelopmentController:refreshStoneTriggerAnimation(goodsData)
                end
            end

            
            

            local petEquipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE,petEquipmentArr)
            local equipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,equipmentArr)
            local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

            UI.WaitingLayer:hideWaiting()
        end

    elseif (no == NetMessageType.PET_RESP_REINCARNATION_MESSAGE.NO) then
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_RESP_REINCARNATION_MESSAGE result is err : " .. data.result)
            return
        end

        mvc.send("PetReincarnation_Update_Pet_Layout", data)
    elseif (no == NetMessageType.PET_RESP_LVBREAK_MESSAGE.NO) then
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_RESP_LVBREAK_MESSAGE result is err : " .. data.result)
            return
        end

        -- 突破成功后刷新对应宠物的最大等级上限
        Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_BREAKLEVELUP_OK, data)
    elseif (no == NetMessageType.PET_GEM_STONE_CONVERT_RESP_MESSAGE.NO) then
        print("PET_GEM_STONE_CONVERT_RESP_MESSAGE: ", data)
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            -- 有还上次转换后还没有选择的魂玉
            if data.result == PublicDefine.ErrNo.ErrNo_PetGemConversionNotEmpty then
                UI.ScrollBar:createByText(UI.TEXT_226305)
            end
            UI.WaitingLayer:hideWaiting()
            print("PET_GEM_STONE_CONVERT_RESP_MESSAGE result is err : " .. data.result)
            return

        end

        local awardsList = {}
        for k,v in pairs(data.gemids) do
            local goodsData = nil
            goodsData = GoodsDataManager:createLocalGoodsData(v)
            --print("goodsData==>: ", goodsData)
            if goodsData then
                goodsData:setNum(1) -- 因为是宝石，所以数量默认为1
                local netData = ProtobufUtil:decode("GoodsSystem.PetGemStoneData",data.goodsDataBytes)
                --local netData = {level = 1, exp = 0, entityID = 1383}
                goodsData:initNetData(netData)
                table.insert(awardsList,goodsData)
            end
        end

        --mvc.petGemStoneDevelopmentController:refreshLeftViewTwo(goodsData)
        mvc.petGemStoneDevelopmentController:refreshConvertTriggerAnimation(awardsList)
        --UI.WaitingLayer:hideWaiting()
    elseif (no == NetMessageType.PET_GEM_STONE_CONVERT_RESP_AWAKE_MESSAGE.NO) then
        print("PET_GEM_STONE_CONVERT_RESP_AWAKE_MESSAGE: ", data)
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_GEM_STONE_CONVERT_RESP_AWAKE_MESSAGE result is err : " .. data.result)
            return
        end

        if data.destEquipData then
            local netData = ProtobufUtil:decode("GoodsSystem.PetEquipmentData",data.destEquipData.goodsDataBytes)

            local equipmentData = GoodsDataManager:getEquipmentForEntityID(netData.entityID)
            if not equipmentData then
                equipmentData = mvc.petGemStoneDevelopmentModel:getFightPetWearEquipmentDataByEntityId(netData.entityID)
            end

            if(equipmentData) then
                local num = equipmentData.num
                local isLock = equipmentData.isLock
                local index = equipmentData.index
                local isGolden = equipmentData.isGolden
                equipmentData:initNetData(netData,num,isGolden,isLock,index)
            end

            local petEquipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE,petEquipmentArr)
            local equipmentArr = GameDataManager:getInstance():getBagGoodsArrForType(PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE,equipmentArr)
            local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(RoleDataManager:getMaster():getSpriteID())
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

            UI.WaitingLayer:hideWaiting()
        end


        if data.getGem then
            local goodsData = nil
            goodsData = GoodsDataManager:createLocalGoodsData(data.getGem.entityID)
            if goodsData then
                goodsData:setNum(1)
                goodsData:initNetData(data.getGem,1)
            end
        end

        mvc.petGemStoneDevelopmentController:refreshConvertTriggerEndAnimation2(goodsData)

    elseif (no == NetMessageType.PET_GEM_STONE_CONVERT_CHOSE_RESP_MESSAGE.NO) then
        print("PET_GEM_STONE_CONVERT_CHOSE_RESP_MESSAGE: ", data)
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            print("PET_GEM_STONE_CONVERT_CHOSE_RESP_MESSAGE result is err : " .. data.result)
            return
        end

        local goodsData = nil
        goodsData = GoodsDataManager:createLocalGoodsData(data.gemid)
        if goodsData then
            goodsData:setNum(1) -- 因为是宝reqPetGemAwakeMessage石，所以数量默认为1
        end

        local netData = ProtobufUtil:decode("GoodsSystem.PetGemStoneData",data.goodsDataBytes)
        goodsData:initNetData(netData)
        --print("netData--->: ", netData)

        --mvc.petGemStoneDevelopmentController:refreshLeftViewTwo(goodsData)
        mvc.petGemStoneDevelopmentController:refreshConvertTriggerEndAnimation(goodsData)
        UI.WaitingLayer:hideWaiting()
    elseif (no == NetMessageType.PET_GEM_STONE_CONVERT_CACHE_CHOSE_RESP_MESSAGE.NO) then
        print("PET_GEM_STONE_CONVERT_CACHE_CHOSE_RESP_MESSAGE: ", data)
        if #data.gemids > 0 then
            -- 之前有转换后没有选择的魂玉
            UI.ScrollBar:createByText(UI.TEXT_226305)
            mvc.petGemStoneDevelopmentController:saveConvertChoseData(data)
        end
    elseif (no == NetMessageType.PET_RESPONSE_CHANGE_PET_SKIN.NO) then
        -- dump(data, "PET_RESPONSE_CHANGE_PET_SKINss")
        -- local pet = MasterDataManager:getBagPetById(data.petId)
        if (data.result == 1) then
            local skinChangeCMD = Command.RendererCommand:create(true)
            skinChangeCMD:initForTypeAndData(CommandType.RENDERER_PET_CHANGE_SKIN, nil, data)
            SceneManager:getInstance():pushCommand(skinChangeCMD)
            
        end
    elseif (no == NetMessageType.PET_RESPONSE_PET_GET_SKIN.NO) then
        -- dump(data, "PET_RESPONSE_PET_GET_SKINaa")
        local isUnlock = MasterDataManager:checkPetSkinIsUnlock(data.skinid)
        if isUnlock then
            UI.ScrollBar:createByText(UI.TEXT_226801)
        else
            UI.ScrollBar:createByText(UI.TEXT_226800)
            MasterDataManager:updatePetUnlockSkinList(data.skinid)
        end
    else
        -- assert(false, string.format("LoginManager:onNetMessageHandler no %d is invaild.", no))
    end
end
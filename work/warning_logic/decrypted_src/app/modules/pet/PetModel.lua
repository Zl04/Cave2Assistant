--[[--
数据模型PetModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/23
--desc	: PetModel
------------------------------------------------------------------------------

local PetModel = class("PetModel",mvc.GameModel)

function PetModel:initData()
    self.newEggType = 0
    self.rebornPillIDs = nil
    self.expPillIDs = nil
    self.qualityPillIDs = nil
    self.skillBookIDs = nil
    self.ranksList = {}
    self.unlockPets = {}
end

function PetModel:getTalentConfig(templateID, isVariant)
    local cfg = ConfigManager:getPetDataByID(templateID)
    if not cfg then
        return
    end

    local talentID = 0
    if isVariant then
        talentID = cfg.talentID[2]
    else
        talentID = cfg.talentID[1]
    end
    local talentCfg = ConfigManager:getPetTalentByID(talentID)
    return talentCfg
end

function PetModel:getSimpleArr(arr)
    if not arr or type(arr) ~= "number" then
        return arr
    end

    if arr >= 100000 then
        return AvalonUtil:getSimpleNumber(arr,4)
    end

    return arr
end

function PetModel:getAllBaseAttr(petData, _xArr, changeData)
    local attrData = {}

    -- 先竖后横
    local xArr = {
        6, 6, 6, 6, 6, 6, 6, 6, 
        180, 180, 180, 180, 180, 180, 180, 180}
    if _xArr then
        xArr = _xArr
    end

    local yArr = {
        0, 34, 68, 102, 136, 170, 204, 238,
        0, 34, 68, 102, 136, 170, 204, 238}

    local icons = {
        "symbol_gaming_blood.png", "symbol_gaming_atk.png", "symbol_gaming_def.png", "symbol_monsterattribute_fire_1.png",
        "symbol_monsterattribute_water_1.png", "symbol_monsterattribute_wood_1.png", "symbol_monsterattribute_light_1.png", "symbol_monsterattribute_dark_1.png",
    
        "symbol_gaming_aspd.png", "symbol_gaming_maggicatk.png", "symbol_gaming_maggicdef.png", "symbol_monsterattribute_fire_2.png",
        "symbol_monsterattribute_water_2.png", "symbol_monsterattribute_wood_2.png", "symbol_monsterattribute_light_2.png", "symbol_monsterattribute_dark_2.png",
    }

    local values = {}
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("hp")))
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("atkMin")).."-"..mvc.petModel:getSimpleArr(petData:getAttrByName("atkMax"))) --攻击力
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("physicDef"))) -- 物抗
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("atkFire"))) -- 火攻
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("atkWater"))) -- 水攻
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("atkWood"))) -- 木攻
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("atkLight"))) -- 光攻
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("atkDark"))) -- 暗攻

    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("atkSpd")/1000)) -- 攻速
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("magic"))) -- 魔力
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("magicDef"))) -- 魔抗
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("defFire"))) -- 火抗
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("defWater"))) -- 水抗
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("defWood"))) -- 木抗
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("defLight"))) -- 光抗
    table.insert(values, mvc.petModel:getSimpleArr(petData:getAttrByName("defDark"))) -- 暗抗

    local changes = {}


    local tipTxt = {
        UI.TEXT_1213732, UI.TEXT_1213751, UI.TEXT_1213730, UI.TEXT_1213740, UI.TEXT_1213741, UI.TEXT_1213742, UI.TEXT_1213743, UI.TEXT_1213744,
        UI.TEXT_1213750, UI.TEXT_1213752, UI.TEXT_1213731, UI.TEXT_1213745, UI.TEXT_1213746, UI.TEXT_1213747, UI.TEXT_1213748, UI.TEXT_1213749, 
    }
    if changeData then
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("hp")-changeData.hp))
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("atkMax")-changeData.atkMax)) --攻击力
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("physicDef")-changeData.physicDef)) -- 物抗
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("atkFire")-changeData.atkFire)) -- 火攻
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("atkWater")-changeData.atkWater)) -- 水攻
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("atkWood")-changeData.atkWood)) -- 木攻
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("atkLight")-changeData.atkLight)) -- 光攻
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("atkDark")-changeData.atkDark)) -- 暗攻

        table.insert(changes, mvc.petModel:getSimpleArr((petData:getAttrByName("atkSpd")-changeData.atkSpd)/1000)) -- 攻速
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("magic")-changeData.magic)) -- 魔力
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("magicDef")-changeData.magicDef)) -- 魔抗
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("defFire")-changeData.defFire)) -- 火抗
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("defWater")-changeData.defWater)) -- 水抗
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("defWood")-changeData.defWood)) -- 木抗
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("defLight")-changeData.defLight)) -- 光抗
        table.insert(changes, mvc.petModel:getSimpleArr(petData:getAttrByName("defDark")-changeData.defDark)) -- 暗抗
    end

    for k, v in ipairs(icons) do
        local oneAttr = {}
        oneAttr.idx = k
        oneAttr.x = xArr[k]
        oneAttr.y = yArr[k]
        oneAttr.icon = v
        oneAttr.val = values[k]
        oneAttr.tipTxt = tipTxt[k]
        if changeData then
            oneAttr.change = changes[k]
        end

        table.insert(attrData, oneAttr)
    end

    return attrData
end

function PetModel:setNewEggType(type)
    self.newEggType = type
end

function PetModel:getNewPet(petId)
    local newPet = MasterDataManager:getBagPetById(petId)
    if not newPet then
        print("PetModel getNetPet faild")
        return
    end
    mvc.openPanel("Pet", "PetResultShow", {showType = 1, eggType = self.newEggType, id = petId})
    self.newEggType = 0
    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        local str = UI.TEXT_1170325
        local linkStr = ""
        if newPet.isVariant then
            linkStr = AvalonUtil:serializePetName(newPet:getNickName(), newPet:getBytesData(), UI.FONT_COLOR_177_81_15)
        else
            linkStr = AvalonUtil:serializePetName(newPet:getNickName(), newPet:getBytesData(), UI.FONT_COLOR_224_176_59)
        end
        local you = AvalonUtil:serializeText(UI.TEXT_1170328, UI.FONT_COLOR_BLUE)
        Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, str, you, linkStr)
    end, 0.5)
end

function PetModel:readyToFight(petId)
    local petData = MasterDataManager:getBagPetById(petId)
    if not petData then
        print("PetModel getNetPet faild")
        return
    end
    MasterDataManager:setFightPet(petData)
end

-- 接受排行数据并缓存
function PetModel:receivePetRanks(rank)
    for k, v in pairs(rank) do    
        self.ranksList[v.petTemplateId] = v.pets
    end
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_RANK_LIST)
end

-- 获取排行缓存
function PetModel:getRanksByTemID(id)
    return self.ranksList[id]
end

-- 销毁缓存
function PetModel:clearRanksList()
    self.ranksList = {}
end

function PetModel:receiveUnlockPets(data)
    self.unlockPets = data
end

function PetModel:addUnlockOnePet(id)
    table.insert(self.unlockPets, id)
end

function PetModel:getUnlockPets()
    return self.unlockPets
end

function PetModel:getAllSkillBooks()
    local booksArr = {}
    local PACKET_TYPE = PublicDefine.PACKET_TYPE
    local MATERIAL_TYPE = PublicDefine.MATERIAL_TYPE
    local master = RoleDataManager:getMaster()
    local materialArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
    for k, v in pairs(materialArr) do
        if v:getMaterialType() == MATERIAL_TYPE.MaterialPetSkill then
            table.insert(booksArr, v)
        end
    end

    return booksArr
end

-- 获取所有资质丹的id
function PetModel:getAllQualityPillID()
    if self.qualityPillIDs then
        return self.qualityPillIDs
    end

    local allMaterials = Config.ConfigGoods:getAllMaterialConfig()
    local pillArr = {}
    for id, v in pairs(allMaterials) do
        if type(v) == "table" then
            local type = math.floor(math.floor(id/10000)%100)
            if type == PublicDefine.MATERIAL_TYPE.MaterialPetTalent then
                local onePill = {}
                onePill.id = v.ID
                onePill.rang = string.split(v.value2, ",")

                local qType = tonumber(v.value1)
                pillArr[qType] = onePill
            end
        end
    end

    self.qualityPillIDs = pillArr

    return self.qualityPillIDs
end

-- 获取所有技能书的id
function PetModel:getAllSkillBookID()
    if self.skillBookIDs then
        return self.skillBookIDs
    end

    local allMaterials = Config.ConfigGoods:getAllMaterialConfig()
    local booksArr = {}
    for id, v in pairs(allMaterials) do
        if type(v) == "table" then
            local type = math.floor(math.floor(id/10000)%100)
            if type == PublicDefine.MATERIAL_TYPE.MaterialPetSkill then
                local oneSkillBook = {}
                oneSkillBook.id = v.ID
                oneSkillBook.cost = string.split(v.value2, ",")

                local sType = tonumber(v.value1)
                booksArr[sType] = oneSkillBook
            end
        end
    end

    self.skillBookIDs = booksArr

    return self.skillBookIDs
end

-- 获取所有的经验丹
function PetModel:getAllExpPill()
    if self.expPillIDs then
        return self.expPillIDs
    end

    local allMaterials = Config.ConfigGoods:getAllMaterialConfig()
    local pillArr = {}
    for id, v in pairs(allMaterials) do
        if type(v) == "table" then
            local type = math.floor(math.floor(id/10000)%100)
            if type == PublicDefine.MATERIAL_TYPE.MaterialPetExp then
                local onePill = {}
                onePill.id = v.ID
                onePill.exp = tonumber(v.value1)
                table.insert(pillArr, onePill)
            end
        end
    end

    table.sort(pillArr, function(a, b)
        return a.exp > b.exp
    end)
    self.expPillIDs = pillArr

    return self.expPillIDs
end

-- 获取所有的洗炼丹
function PetModel:getAllRebornPill()
    if self.rebornPillIDs then
        return self.rebornPillIDs
    end

    local allMaterials = Config.ConfigGoods:getAllMaterialConfig()
    local pillArr = {}
    for id, v in pairs(allMaterials) do
        if type(v) == "table" then
            local type = math.floor(math.floor(id/10000)%100)
            if type == PublicDefine.MATERIAL_TYPE.MaterialPetWash then
                pillArr[tonumber(v.value1)] = v.ID
            end
        end
    end

    self.rebornPillIDs = pillArr

    return self.rebornPillIDs
end

function PetModel:getCurPetMaxExp(petID)
    local petData = MasterDataManager:getBagPetById(petID)
    local totalExp = 0
    for i = 1, petData.maxLV do
        local cfg = ConfigManager:getPetExpByID(i)
        totalExp = totalExp + cfg.expToNextLV
    end

    return totalExp
end

function PetModel:getRefineReturnMoney(petID)
    local petData = MasterDataManager:getBagPetById(petID)
    local cfg = ConfigManager:getPetExpByID(petData:getLevel())
    local finalMoney = cfg.returnGold
    local alpha = petData.extraReturn
    if petData.isVariant then
        finalMoney = finalMoney + alpha[2]
    elseif self:isHightQuality(petID) then
        finalMoney = finalMoney + alpha[1]
    end

    return finalMoney
end

function PetModel:getRefineReturnDust(petID)
    local petData = MasterDataManager:getBagPetById(petID)
    local index = petData.isVariant and 2 or 1
    local cfg = ConfigManager:getPetDataByID(petData.templateID)
    if not cfg or not cfg.dustReturn then
        return nil
    end

    local dustData = {}

    -- 根据变异与否决定基础值
    local dustStr = string.split(cfg.dustReturn, ";")[index]
    local dustStrList = string.split(dustStr, ",")
    dustData[1] = dustStrList[1]

    -- 根据升星吃掉的宠物数量计算粉尘数
    local dustOnceStr = string.split(cfg.dustReturn, ";")[1]
    local dustOnceNum = tonumber(string.split(dustOnceStr, ",")[2])
    local petStarInfoList = string.split(petData:getNowReincarnationConfig().combineLimit, ";")
    --local petStarInfoList = string.split(cfg.combineLimit, ";")
    local petStatNum, _ = petData:getStarLv()
    local petNum = 0
    if petStatNum ~= 0 then
        for star = 1, petStatNum do
            petNum = petNum + tonumber(string.split(petStarInfoList[star], ",")[2])
        end
    end
    local dustStarNum = petNum * dustOnceNum

    dustData[2] = tonumber(dustStrList[2]) + tonumber(dustStarNum)

    return dustData
end

function PetModel:isHightQuality(petID)
    local petData = MasterDataManager:getBagPetById(petID)

    -- 最大资质之和
    local cfg = mvc.petModel:getTalentConfig(petData.templateID, petData.isVariant)
    local maxTotalVal = cfg.talent_atk[2]+cfg.talent_physicDef[2]+cfg.talent_magicAtk[2]+cfg.talent_magicDef[2]
                        +cfg.talent_element[2]+cfg.talent_elementDef[2]+cfg.talent_hp[2]

    -- 当前资质之和
    local type = PublicDefine.PetTalentType
    local curTotalVal = petData:getTalentByType(type.TPhysicAtk)+petData:getTalentByType(type.TPhysicDef)+petData:getTalentByType(type.TMagicAtk)
                        +petData:getTalentByType(type.TMagicDef)+petData:getTalentByType(type.TElement)+petData:getTalentByType(type.TResist)
                        +petData:getTalentByType(type.TLife)

    local ret = tonumber(ConfigManager:getGeneralForKey("highTalentRatio"))
    return curTotalVal / maxTotalVal > ret/10000
end

function PetModel:getFightPetIdx()
    local idx = 1
    local allPets = MasterDataManager:getBagPets()
    for k, v in ipairs(allPets) do
        if v:isFight() then
            idx = k
            break
        end
    end

    return idx
end

function PetModel:getPetTalentMaterialMax(config, level)
    local maxLimit = 0
    local talentMaterialMaxList = string.split(config.talentMaterialMax, ";")
    local petLevel2TalentMaterialMaxList = {}
    for k, v in pairs(talentMaterialMaxList) do
        local list = string.split(v, ",")
        local dataList = {}
        dataList.level = tonumber(list[1])
        dataList.num = tonumber(list[2])
        table.insert(petLevel2TalentMaterialMaxList, dataList)
    end

    for k, v in ipairs(petLevel2TalentMaterialMaxList) do
        if level >= v.level then
            maxLimit = v.num
        else
            break
        end
    end
    return maxLimit
end

function PetModel:getPetTalentPoint(config, level)
    local talentPoint = 0
    local talentPointList = string.split(config.talentPoints, ";")
    local petLevel2TalentPointList = {}
    for k, v in ipairs(talentPointList) do
        local list = string.split(v, ",")
        petLevel2TalentPointList[tonumber(list[1])] = tonumber(list[2])
    end
    talentPoint = petLevel2TalentPointList[level] or 0
    return talentPoint
end

function PetModel:computeLevelInStage(talentType, level, stars, totalTalentValue, initAttrMode, growAttrMode, factor)
    talentType = talentType + 1
    local MAX_PET_STAR_NUMB =  PublicDefine.CONST_DEFINITION.MAX_PET_STAR_NUMB
    local stageCount = (level % 10 == 0) and (level / 10) or math.ceil(level / 10);
    local stageRemain = level - (stageCount - 1) * 10
    local number = 0--initAttrMode[1] or 0
    local addConst = initAttrMode[2] or 0
    for stage = 0, stageCount - 1 do
        local levelInStage = (stage == stageCount - 1) and stageRemain or 10;
        local talentFactorIndex = 0;
        if (stage == 0) then
            levelInStage = levelInStage - 1;
        end
        if (stars < stage) then
            talentFactorIndex = stars
        elseif (stage >= MAX_PET_STAR_NUMB) then
            talentFactorIndex = MAX_PET_STAR_NUMB - 1;
        else
            talentFactorIndex = stage
        end
        local growAttrStr = growAttrMode[string.format("talentParam_%d", talentFactorIndex)]
        if growAttrStr == nil then
            return 0
        end
        local talentFactors = growAttrStr[talentType] or 0
        -- local totalTalentValue = self:getTalentByType(talentType - 1) + self:getExtraTalentByType(talentType - 1) + talentValue
        number = number + (totalTalentValue * talentFactors / 1000 + addConst) * levelInStage;
    end
    number = math.floor(initAttrMode[1] * factor) + math.floor(number) * factor
    return math.floor(number)
end 


function PetModel:getMaxLevelLimit()
    local checkLv = RoleDataManager:getMaster():getLevel()
    local limitLvStr = ConfigManager:getGeneralForKey("petLevelBreakthrough")
    local limitLvList = string.split(limitLvStr, ",")
    local limitLv = tonumber(limitLvList[1])
    local addLv = tonumber(limitLvList[2])
    if checkLv >= limitLv then
        checkLv = checkLv + addLv
    end
    return checkLv
end


return PetModel


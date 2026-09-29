
--[[
    英雄属性定义
]]
require "app.datas.role.RoleData"
local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"

local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY
local ATTR_TYPE = PublicDefine.ATTR_TYPE
local FunctionFlag = PublicDefine.FunctionFlag
local DelusionType = PublicDefine.DelusionType
local TalentType = PublicDefine.PetTalentType

local DEBUG = false

local PetRoleData = class("PetRoleData",Data.RoleData)

Data = Data or {}
Data.PetRoleData = PetRoleData  

-- 英雄移动速度默认值
local heroMoveSpeedDefault = 0


-- 构造函数(会自动调用)  
-- 外界构造时可以传任意参数XXX.new(...)  
function PetRoleData:ctor()
    PetRoleData.super.ctor(self, RoleType.Pet)
    -- 比例属性列表
end  

function PetRoleData:clear()
end

-- 模版函数：
function PetRoleData:getId()
    -- 这里需要返回一个指定值
	return self.spriteID
end

-- 为了兼容herodata
function PetRoleData:getPK()
    -- 这里需要返回一个指定值
    return self:getId()
end

-- 模版函数：
function PetRoleData:isReachable()
    return true
end

-- 获取性别
function PetRoleData:getSex()
    -- print("HeroData:getSex",self.sex)
    return self.sex
end

function PetRoleData:setSex(value)
    self.sex = value
end


-- 获取动画配置数据
function PetRoleData:getAnimationData()
    return self.mSpine..".json", self.mSpine..".atlas", 1
end

function PetRoleData:getSceneScale()
    return self.mSceneScale
end

function PetRoleData:getLayerScale()
    return self.mLayerScale
end

-- 设置等级
function PetRoleData:setLevel(roleLV)
    self.roleLV = roleLV
    local exp, isMax = ConfigManager:getPetExpByLevel(roleLV)
    if isMax then
        self:setMaxLVExp(1)
    else
        self:setMaxLVExp(exp)
    end
end

-- 获取等级
function PetRoleData:getLevel()
    return self.roleLV
end

-- 获取转生等级
function PetRoleData:getReincarntionLv()
    return self.reincarntionLv
end

-- 设置转生等级
function PetRoleData:setReincarntionLv(reincarntionLV)
    self.reincarntionLv = reincarntionLV
end

-- 设置等级上限
function PetRoleData:setMaxLevelLimit(maxLV)
    self.maxLV = maxLV
end

-- 获取等级上限
function PetRoleData:getMaxLevelLimit()
    return self.maxLV
end

-- 设置当前经验
function PetRoleData:setMaxLVExp(curMaxExp)
    self.curMaxExp = curMaxExp
end

function PetRoleData:getMaxExp()
    return self.curMaxExp
end

-- 设置昵称
function PetRoleData:setNickName(nickName)
    self.nickName = nickName
    self.nickName = ToolsUtil:replaceShowNickNameStr(self.nickName)
end

-- 获取名字
function PetRoleData:getNickName()
    if self.nameTimes == 0 then
        local petDataConfig = ConfigManager:getPetDataByID(self.templateID)
        return petDataConfig.name
    else
        -- add by zp CO-14453【改名】IOS玩家可以改名将名字换行竖名显示
        return ToolsUtil:replaceShowNickNameStr(self.nickName)
        -- return self.nickName
    end
end

--获取宠物品质
function PetRoleData:getPetQuality()--setReadyFight()
    local petDataConfig = ConfigManager:getPetDataByID(self.templateID)
    return petDataConfig.petquality
end

--获取骑宠骑乘属性字段
function PetRoleData:getPetRoleAttribute()
    local petDataConfig = ConfigManager:getPetDataByID(self.templateID)
    return petDataConfig.petRoleAttribute
end

--获取分解保留宠物需要的水晶
function PetRoleData:getPetRetainCost()
    local petDataConfig = ConfigManager:getPetDataByID(self.templateID)
    return petDataConfig.petRetainCost
end

--获取骑宠骑乘属性字段描述
function PetRoleData:getPetRoleAttributeDes()
    local LanguageManager = require "app.game.LanguageManager"
    local languageManagerInstance = LanguageManager:getInstance()
    local petDataConfig = ConfigManager:getPetDataByID(self.templateID)
    return languageManagerInstance:getLocalString(petDataConfig.attributeDes)--petDataConfig.attributeDes
end

function PetRoleData:getIsMaxLevel()
    local maxLevel = tonumber(ConfigManager:getGeneralForKey("heroMaxLevel"))
    if(self.roleLV >=maxLevel) then
        return true
    end

    return false
end

--
function PetRoleData:getCombatScore()
    return self.equipScore
end

-- 模版函数：
function PetRoleData:getType()
	return RoleType.Pet
end

function PetRoleData:setLooks(looks)
	self.looks = looks
    -- print(" PetRoleData  setLookssetLookssetLooks  ",looks)
end

function PetRoleData:getLooks()
	return self.looks
end

-- 根据当前的宠物阶级表里的等级上限数据
function PetRoleData:refreshMaxLevelLimit()
    -- 等级上限
    -- 取表里的数据
    local templateConfig = ConfigManager:getPetDataByID(self.templateID)
    local levelList = string.split(templateConfig.maxLV, ";")
    self.maxLV = tonumber(levelList[self.reincarntionLv + 1])
    self.baseMaxLV = self.maxLV
end

function PetRoleData:init(data, isBag, sitePet)
    --[[ 要特别注意 在背包里面的唯一标识 和 在场景里面的表示的意义完全不一样，两套ID机制
        如果有需求 可以为背包里的ID 单独申请一个字段]]
    if not sitePet then
        --昵称
        self.nickName = data.nickName or ""
        --模版ID
        self.templateID = data.templateID;
        --是否变异
        self.isVariant = data.isVariant;
        
        --经验
        self.curLVExp = data.exp
        --战力
        self.power = data.power
        --玩家变身状态
        self.looks = 0
    end
    --是否骑乘
    self.isReadyRide = false

    --宠物主人的pk
    self.pk = data.pk or 0

    --狐仙宠物是否变身
    self.isTransform = data.isTransform or 0

    --当前宠物皮肤:0为未装备皮肤
    self.skinId = data.skinId   

    self.isBag = isBag
    if isBag then

        if sitePet then
            --宠物实例ID
            self.petInstId = data.petid
            --出战宠物序号（0为主宠物）
            self.siteId = data.siteId
        end
        -- uniqueid是string类型，背包宠物的唯一ID
        self.spriteID = data.uniqueid or -1

        --资质
        local talents = {}
        for k, v in ipairs(data.talents) do
            table.insert(talents, v)
        end
        self.talents = talents

         -- 通过资质丹额外增长部分
        local extraTalents = {}
        for k, v in ipairs(data.extraTalents) do
            table.insert(extraTalents, v)
        end
        self.extraTalents = extraTalents

        -- 通过资质加点额外增长部分
         local extraTalentPoints = {}
         for k, v in ipairs(data.extraTalentPoints) do
             table.insert(extraTalentPoints, v)
         end
        self.extraTalentPoints = extraTalentPoints

        self.talenPointUseNum = data.talenPointUseNum
        self.talenPointItemUseNum = data.talenPointItemUseNum
        
        --是否出战
        print("--isReadyFight----=",  data.isReadyFight, self.spriteID)
        self.isReadyFight = data.isReadyFight

        self.stars = data.stars

        local skills = {}
        for k, v in ipairs(data.skillids) do
            table.insert(skills, v)
        end
        self.skillids = skills

        self.nameTimes = data.nameTimes

        if ProtobufUtil:checkFieldIsInit(data, "buffs") then
            local buffs = {}
            for k, v in ipairs(data.buffs) do
                table.insert(buffs, v)
            end

            self.buffs = buffs
        end
        self.validSkill = data.validSkill
    else
        -- spriteID是number类型，是非背包宠物的精灵ID而并未唯一ID
        self.spriteID = data.spriteID or -1
        self.status = data.status
        self.skillState = data.skillState
        self.buff = data.buff
        self.curHp = data.curHp
        self.hp = data.maxHp
        --宠物实例ID
        self.petInstId = data.petInstId
        --出战宠物序号（0为主宠物）
        self.siteId = data.siteId
        if ProtobufUtil:checkFieldIsInit(data, "masterSpriteID") then
            self.masterSpriteID = data.masterSpriteID
            local masterData = RoleDataManager:getRoleDataBySpriteID(self.masterSpriteID)
            if masterData then
                print("masterData:getLooks() ==== ",masterData:getLooks())
                self:setLooks(masterData:getLooks())
            end

        end
        self.skillids = nil
        if ProtobufUtil:checkFieldIsInit(data, "changeNameTimes") then
            self.nameTimes = data.changeNameTimes
        end
        self.functionFlag = data.functionFlag
        self.isReadyFight = true
        if ProtobufUtil:checkFieldIsInit(data, "coordX") then
            self.coord = {x = data.coordX, y = data.coordY}
        end
    end

    -- 处理穿戴装备列表
    self.wearEquipmentArr = {}
    if(ProtobufUtil:checkFieldIsInit(data, "equips")) then 
        for k,v in ipairs(data.equips) do 
            local goodsData = Net.NetGoodsSystem:handlePackGoodsData(v)
            if(v.index ~= 0) then
                goodsData:setWearPosition(v.index)
                goodsData:setBytesData(v.goodsDataBytes)
                table.insert(self.wearEquipmentArr, goodsData)
            else
                assert(false,"NetRoleSystem  ROLE_RESPONSE_HERO_DETAIL not set equipment index value.")
            end
        end
    end
    self:conbinationLocalData()
    --等级
    self:showLevelUpAction(self:getLevel(), data.level + 1)
    self:setLevel(data.level)
    if isBag then
        self:calculateFightAttrs()
    end
    self.skillCd = {}
    self._onLineState = PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE --加入状态

    -- 背包格子属性
    self.petGridData = {}
    self.nickName = ToolsUtil:replaceShowNickNameStr(self.nickName)

    -- 转生阶数
    self.reincarntionLv = 0
    -- 首先获取转生配置表所有数据
    local allConfigDatas = ConfigManager:getAllPetReincarnationData()
    for k, v in pairs(allConfigDatas) do
        local nowConfig = v
        local minLevel = tonumber(nowConfig.value)
        local maxLevel = tonumber(nowConfig.maxLevel)
        if self.roleLV > minLevel and self.roleLV <= maxLevel then
            self.reincarntionLv = nowConfig.petReiLv
            break
        end
    end
    -- 等级上限
    -- 取表里的数据
    local templateConfig = ConfigManager:getPetDataByID(self.templateID)
    local levelList = string.split(templateConfig.maxLV, ";")
    self.maxLV = tonumber(levelList[self.reincarntionLv + 1])
    self.baseMaxLV = self.maxLV

    if isBag then
        if data.maxLevelLimit then
            self.maxLV = self.baseMaxLV + data.maxLevelLimit
        end

        if data.reincarnationLevel then
            self.reincarntionLv = data.reincarnationLevel
        end
    end

    -- 根据阶级匹配对应技能槽
    self:refreshSkillNum()

    -- 根据当前阶数刷新技能描述
    self:refreshSkill()
end

-- 获取位置
function PetRoleData:getCoord()
    return self._coord
end

-- 设置位置
function PetRoleData:setCoord(coord)
    self._coord = coord
end


-- 模板函数
function PetRoleData:refreshCurInitData()
    local iconList = string.split(self.icon, ";")
    if self.isVariant then
        self.mIcon = iconList[2] or iconList[1]
    else
        self.mIcon = iconList[1]
    end
    
    self.useIcon = nil

    local spineList = string.split(self.spine, ";")
    local sceneScale = string.split(self.scenescale, ";")
    local layerScale = string.split(self.spinescale, ";")
    if self.isVariant then
        self.mSpine = spineList[2] or spineList[1]
        self.mSceneScale = tonumber(sceneScale[2] or sceneScale[1])
        self.mLayerScale =  tonumber(layerScale[2] or layerScale[1])
    else
        self.mSpine = spineList[1]
        self.mSceneScale =  tonumber(sceneScale[1])
        self.mLayerScale =  tonumber(layerScale[1])
    end

    
    if self.skinId and self.skinId ~= 0 then
        local skinConfig = ConfigManager:getPetSkinByID(self.skinId)
        self.mIcon = skinConfig.skinIcon
        self.mSpine = skinConfig.skinSpine
    end

    self.skillPoolID = nil
    self.talentID = nil
    if self.isVariant then
        self.mInitID = self.initID[2] or self.initID[1]
        self.mGrowID = self.growID[2] or self.growID[1]
    else
        self.mInitID = self.initID[1]
        self.mGrowID = self.growID[1]
    end
    self.buff = {}
end

function PetRoleData:getIcon()
    if self.useIcon == nil or self.useIcon == "" then
        self.useIcon = AvalonUtil.getHeXieSpriteFrameName(self.mIcon..".png")
    end

    return self.useIcon
end

function PetRoleData:getWearEquipmentArr()
    return self.wearEquipmentArr
end

function PetRoleData:getWearEquipmentForEquipType(equipmentType)
    for k, data in ipairs(self.wearEquipmentArr) do 
        if(data:getEquipmentType() == equipmentType) then 
            return data
        end
    end

    return nil
end

function PetRoleData:addWearEquipmentData(petEquipmentData)
    table.insert(self.wearEquipmentArr, petEquipmentData)
end

function PetRoleData:removeWearEquipmentDataFromInstID(petInstId)
    for k, data in ipairs(self.wearEquipmentArr) do 
        if(data:getEntityID() == petInstId) then 
            table.remove(self.wearEquipmentArr, k)
            break
        end
    end
end

function PetRoleData:conbinationLocalData()
    -- 检测是否操作了最大配置等级
    local petDataConfig = ConfigManager:getPetDataByID(self.templateID)
    if petDataConfig then
        self:setLocalConfigData(petDataConfig)
    end
    self:refreshCurInitData()
end

--场景宠物专用：场景宠物刷新数据
function PetRoleData:changeInit(data)
    local isDirty = false
    if type(data) ~= "table" then
        return isDirty
    end
    if self.status ~= data.status or self.nickName ~= data.nickName or self.isVariant ~= data.isVariant
        or self.curHp ~= data.curHp or self.roleLV ~= data.level or self.curLVExp ~= data.exp then
        isDirty = true
    end
    self:showLevelUpAction(self:getLevel(), data.level)
    self:setVariant(data.isVariant)
    self.nickName = data.nickName
    self.status = data.status              
    self.skillID = data.skillID
    self.skillState = data.skillState

    self.buff = data.buff
    self.curLVExp = data.exp
    self.curHp = data.curHp
    self.hp = data.maxHp
    self.roleLV = data.level

    self.siteId = data.siteId
    self.petInstId = data.petInstId

    self.isReadyRide = data.isRiding or false

    --宠物主人的pk
    self.pk = data.pk or 0

    --狐仙宠物是否变身
    self.isTransform = data.isTransform or 0

    self.nickName = ToolsUtil:replaceShowNickNameStr(self.nickName)
    return isDirty
end

--场景宠物专用：场景查看宠物头像
function PetRoleData:refreshDetail(data)
    for k,v in pairs(data) do 
        if type(v) ~= "table" then
            self[k] = v
        else 
            if k == "attr" then
                for k2, data in ipairs(v) do
                    self[ATTR_TYPE_ID_KEY[data.changeType]] = data.resultValue
                end
            end
        end
    end
end

function PetRoleData:setVariant(isVariant)
    if self.isVariant ~= isVariant then
        self.isVariant = isVariant
        self:conbinationLocalData()
    end
end

-- 判断是否可以移动
function PetRoleData:judegeToMove()
    if(self:getIsFrozen() or self:getIsStun() or self:getIsConstraint()) then
        return false
    end

    if ( self:getState() == FSMState.MOVE or self:getState() == FSMState.IDLE ) and self:getIsDead() == false then
        return true
    end

    return false
end

function PetRoleData:getIsBlind()
    if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Blind) == false) then
        return false
    else
        return true
    end
end

-- 获取是否翻转
function PetRoleData:getIsReverse()
    if(self:haveFunctionFlag(FunctionFlag.FunctionFlag_Reverse) == false) then
        if(self.delusion == DelusionType.DelusionType_Mental) then
            return true
        end

        return false
    else
        return true
    end
end

-- 判断是否迷惑
function PetRoleData:isConfuse()
    if(self.delusion == DelusionType.DelusionType_Mental) then
        return true
    end

    return false
end

-- 获取强化百分比
function PetRoleData:getStrengthenExtraRate()
    return self.strengthenExtraRate
end

function PetRoleData:isReachable()
    return true
end

function PetRoleData:canBeNodeOfPath()
    return true
end

function PetRoleData:canBeEndOfPath()
    return true
end 

function PetRoleData:isFight()
    return self.isReadyFight
end

function PetRoleData:setReadyFight(readyFight)
    self.isReadyFight = readyFight
end

function PetRoleData:isRide()
    return self.isReadyRide
end

function PetRoleData:setReadyRide(readyRide)
    self.isReadyRide = readyRide
end

function PetRoleData:canRide()
    -- local petRoleAttribute = self:getPetRoleAttribute()
    local petDataConfig = ConfigManager:getPetDataByID(self.templateID)
    local ridingPet = petDataConfig.ridingPet
    -- if petRoleAttribute ~= "" then
    if ridingPet and ridingPet > 0 then
        return true
    else
        return false
    end
end

function PetRoleData:getNameTimes()
    return self.nameTimes or 0
end

function PetRoleData:setNameTimes(nameTimes)
    self.nameTimes = nameTimes
end

function PetRoleData:getSiteId()
    return self.siteId or nil
end

function PetRoleData:getPetInstId()
    return self.petInstId or nil
end

-- 星级（阶数）
-- 通过一次合成，宠物个体的星级会提升，星级更高的宠物每个等级增长的属性更多
function PetRoleData:getStarLv()
    -- local curLv = self:getLevel()
    -- local conditions = string.split(self.combineLimit, ";")
    -- local canLvUpNum = math.min(math.floor(curLv/10)-self.stars, #conditions-self.stars)
    -- 因为引入了宠物可以转生的概念，所以这里获取当前转生阶级对应的可升级的最大星数
    local curLv = self:getLevel()
    local nowConfig = self:getNowReincarnationConfig()
    local conditions = string.split(nowConfig.combineLimit, ";")
    local quality = 0
    for k,v in pairs(conditions) do
        local conditions2 = string.split(v, ",")
        local levelMax = tonumber(conditions2[1])
        if curLv > levelMax then
            quality = quality + 1
        else
            break
        end
    end
    local canLvUpNum = math.min(math.floor(curLv/10)-self.stars, quality - self.stars)
    --local canLvUpNum = math.min(math.floor(curLv/10)-self.stars, #conditions - self.stars)
    return self.stars, canLvUpNum
end

function PetRoleData:getNowReincarnationConfig()
    -- 首先获取转生配置表所有数据
    local configDatas = ConfigManager:getAllPetReincarnationDataByID(self.reincarntionLv)
    
    return configDatas
end

-- 战力
function PetRoleData:getPower()
    local power = self.power
    
    -- if(self.wearEquipmentArr) then 
    --     for k, equipmentData in ipairs(self.wearEquipmentArr) do 
    --         power = power + equipmentData:getCombatScore()
    --     end 
    -- end

    return power
end

function PetRoleData:getTalentByType(tType)
    return self.talents[tType+1] or 0
end

function PetRoleData:getExtraTalentByType(tType)
    return self.extraTalents[tType+1] or 0
end

function PetRoleData:getExtraTalentPoint(tType)
    return self.extraTalentPoints[tType+1] or 0
end

function PetRoleData:getUsedTalentPoint()
    return self.talenPointUseNum or 0
end

function PetRoleData:getTalentPointItemUsed()
    return self.talenPointItemUseNum or 0
end

function PetRoleData:getAllSkills()
    return self.skillids
end

function PetRoleData:getInitiativeSkill()
    return self.validSkill or 0
end

function PetRoleData:getGiftedSkill()
    --- 此处没有特质技能，统一返回nil
    local skillInfo = string.split(self.giftedskill, ";")

    if self.giftedskill == "" then
        return nil
    end

    local skillId
    -- 变异宠物特质技能是后面
    if self.isVariant then
        -- 逗号前是技能id，后面是服务器用作释放概率
        skillId = string.split(skillInfo[2], ",")[1]
    else
        skillId = string.split(skillInfo[1], ",")[1]
    end

    if skillId == "0" then
        return nil
    end

    return skillId
end

function PetRoleData:getGiftedSkill2()
    --- 此处没有特质技能，统一返回nil
    local skillInfo = string.split(self.giftedskill2, ";")

    if self.giftedskill2 == "" then
        return nil
    end

    local skillId
    -- 变异宠物特质技能是后面
    if self.isVariant then
        -- 逗号前是技能id，后面是服务器用作释放概率
        skillId = string.split(skillInfo[2], ",")[1]
    else
        skillId = string.split(skillInfo[1], ",")[1]
    end

    if skillId == "0" then
        return nil
    end

    return skillId
end

-- 获取普通可改变技能格子数（排除特质技能）
function PetRoleData:getNormalSkillSlotNum()
    local cfgIdx = self.isVariant and 2 or 1
    local num = self.skillNum[cfgIdx]
    return num
end

function PetRoleData:getInheritCost()
    return self.inheritCost
end

-- 获取攻击时长
function PetRoleData:getAttackDuration()
    return self.atkSpd / 1000
end


function PetRoleData:isHaveSkill()
    if self.skillids == nil then
        return false
    end
    return true
end

function PetRoleData:refreshData(data)
    if data.datatype == "PETDATA_EXP" then
        self.curLVExp = data.intvalue
    elseif data.datatype == "PETDATA_LEVEL" then
        self:showLevelUpAction(self:getLevel(), data.intvalue)
        self:setLevel(data.intvalue)
    elseif data.datatype == "PETDATA_TALENTS" then
        if self.talents == nil then
            self.talents = {}
        end
        self.talents[data.dataindex+1] = data.intvalue
    elseif data.datatype == "PETDATA_SKILLIDS" then
        if self.skillids == nil then
            self.skillids = {}
        end

        if data.intvalue == 0 then
            self.skillids[data.dataindex+1] = nil
        else
            self.skillids[data.dataindex+1] = data.intvalue
        end
    elseif data.datatype == "PETDATA_STATUS" then
        self.status = data.intvalue
    elseif data.datatype == "PETDATA_NICKNAME" then
        self.nickName = data.strvalue
        self.nickName = ToolsUtil:replaceShowNickNameStr(self.nickName)
    elseif data.datatype == "PETDATA_EXTRA_TALENTS" then
        if self.extraTalents == nil then
            self.extraTalents = {}
        end
        self.extraTalents[data.dataindex+1] = data.intvalue
    elseif data.datatype == "PETDATA_EXTRA_POINTS" then
        if self.extraTalentPoints == nil then
            self.extraTalentPoints = {}
        end
        self.extraTalentPoints[data.dataindex+1] = data.intvalue
    elseif data.datatype == "PETDATA_TALENT_POINT_USE" then
        self.talenPointUseNum = data.intvalue
    elseif data.datatype == "PETDATA_TALENT_POINT_ITEM_USE" then
        self.talenPointItemUseNum = data.intvalue
    elseif data.datatype == "PETDATA_MUTATED" then  
        if data.intvalue >= 1 then
            self:setVariant(true)
        else
            self:setVariant(false)
        end
    elseif data.datatype == "PETDATA_STARS" then  
        self.stars = data.intvalue
    elseif data.datatype == "PETDATA_NAME_TIMES" then  
        self.nameTimes = data.intvalue
    elseif data.datatype == "PETDATA_POWER" then  
        self.power = data.intvalue
    elseif data.datatype == "PETDATA_VALID_SKILL" then 
        self.validSkill = data.intvalue
    elseif data.datatype == "PETDATA_REINCARNATIONLV" then 
        self.reincarntionLv = data.intvalue -- 当前的转生等级
    elseif data.datatype == "PETDATA_MAXLEVELLIMIT" then 
        self.maxLV = self.baseMaxLV + data.intvalue -- 等级上限
    elseif data.datatype == "PETDATA_SKIN" then 
        self.skinId = data.intvalue -- 宠物皮肤修改
        self:calculateFightAttrs()
    end   
end

function PetRoleData:calculateFightAttrs()
    local generateAttr = function(self, talentType, initAttrMode, growAttrMode, factor)
        talentType = talentType + 1
        local MAX_PET_STAR_NUMB =  PublicDefine.CONST_DEFINITION.MAX_PET_STAR_NUMB
        local level = self:getLevel()
        local stars = self.stars
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
            local talentValue = self:getTalentByType(talentType - 1) + self:getExtraTalentByType(talentType - 1) + self:getExtraTalentPoint(talentType - 1)
            number = number + (talentValue * talentFactors / 1000 + addConst) * levelInStage;
        end
        number = math.floor(initAttrMode[1] * factor) + math.floor(number) * factor
        return math.floor(number)
    end
    self.hp = 0;             --生命资质
    self.atkMin = 0;         --物攻资质
    self.atkMax = 0;         --物攻资质
    self.physicDef = 0;      --物防资质
    self.magicDef = 0;       --法防资质
    self.magic = 0;          --法攻资质 
    self.atkFire = 0;        --元素资质
    self.atkWater = 0;       --元素资质
    self.atkWood = 0;        --元素资质
    self.atkLight = 0;       --元素资质
    self.atkDark = 0;        --元素资质
    self.defFire = 0;        --抗性资质
    self.defWater = 0;       --抗性资质
    self.defWood = 0;        --抗性资质
    self.defLight = 0;       --抗性资质
    self.defDark = 0;        --抗性资质

    local initAttrData = ConfigManager:getPetInitAttrByID(self.mInitID)
    local growAttrData = ConfigManager:getPetGrowAttrByID(self.mGrowID)
    if initAttrData == nil or growAttrData == nil then
        return
    end
    self.hp = generateAttr(self, TalentType.TLife, initAttrData.init_hp, growAttrData, 1)
    self.atkMin = generateAttr(self, TalentType.TPhysicAtk, initAttrData.init_atk, growAttrData, (1 - 0.05))
    self.atkMax = generateAttr(self, TalentType.TPhysicAtk, initAttrData.init_atk, growAttrData, (1 + 0.05))
    self.physicDef = generateAttr(self, TalentType.TPhysicDef, initAttrData.init_physicDef, growAttrData, 1)
    self.magicDef = generateAttr(self, TalentType.TMagicDef, initAttrData.init_magicDef, growAttrData, 1)
    self.magic = generateAttr(self, TalentType.TMagicAtk, initAttrData.init_magicAtk, growAttrData, 1)

    self.atkFire = generateAttr(self, TalentType.TElement, initAttrData.init_atkFire, growAttrData, 1)
    self.atkWater = generateAttr(self, TalentType.TElement, initAttrData.init_atkWater, growAttrData, 1)
    self.atkWood = generateAttr(self, TalentType.TElement, initAttrData.init_atkWood, growAttrData, 1)
    self.atkLight = generateAttr(self, TalentType.TElement, initAttrData.init_atkLight, growAttrData, 1)
    self.atkDark = generateAttr(self, TalentType.TElement, initAttrData.init_atkDark, growAttrData, 1)

    self.defFire = generateAttr(self, TalentType.TResist, initAttrData.init_defFire, growAttrData, 1)
    self.defWater = generateAttr(self, TalentType.TResist, initAttrData.init_defWater, growAttrData, 1)
    self.defWood = generateAttr(self, TalentType.TResist, initAttrData.init_defWood, growAttrData, 1)
    self.defLight = generateAttr(self, TalentType.TResist, initAttrData.init_defLight, growAttrData, 1)
    self.defDark = generateAttr(self, TalentType.TResist, initAttrData.init_defDark, growAttrData, 1)
    -- print(string.format("attr: hp = %d, atkMin = %d, atkMax = %d, physicDef = %d, magicDef = %d, magic = %d, atkFire = %d, atkWater = %d, atkWood = %d, atkLight = %d, atkDark = %d, defFire = %d, defWater = %d, defWood = %d, defLight = %d, defDark = %d", self.hp, self.atkMin, self.atkMax, self.physicDef, self.magicDef, self.magic, self.atkFire, self.atkWater, self.atkWood, self.atkLight, self.atkDark, self.defFire, self.defWater, self.defWood, self.defLight, self.defDark))

    if self.skinId and self.skinId > 0 then
        local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY
        local skinConfig = ConfigManager:getPetSkinByID(self.skinId)
        local skinAttr = string.split(skinConfig.skinAttribute, ";")
        for k, v in pairs(skinAttr) do
            local skinAttrList = string.split(v, ",")
            local skinAttrType = tonumber(skinAttrList[1])
            local skinAttrValue = tonumber(skinAttrList[2])
            local percent = (skinAttrValue / 10000)
            local changeAttr = self[ATTR_TYPE_ID_KEY[skinAttrType]] or 0
            local skinAttrAddValue = changeAttr * percent
            self[ATTR_TYPE_ID_KEY[skinAttrType]] = math.floor(changeAttr + skinAttrAddValue)
        end
    end
end

--资质类型 影响的属性类型
function PetRoleData:getAttrByTalent(talentType)
    local map = self:getTalentAttrMap()
    return map[talentType]
end

--资质类型 影响的属性类型
function PetRoleData:getTalentAttrMap()
    local ATTR = PublicDefine.ATTR_TYPE
    local map = {[TalentType.TLife] = {ATTR.hp}, [TalentType.TPhysicAtk] = {ATTR.atkMin, ATTR.atkMax}, [TalentType.TMagicAtk] = {ATTR.magic},
                [TalentType.TPhysicDef] = {ATTR.physicDef}, [TalentType.TMagicDef] = {ATTR.magicDef}, 
                [TalentType.TElement] = {ATTR.atkFire, ATTR.atkWater, ATTR.atkWood, ATTR.atkLight, ATTR.atkDark},
                [TalentType.TResist] = {ATTR.defFire, ATTR.defWater, ATTR.defWood, ATTR.defLight, ATTR.defDark}}
    return map
end

-- 改变血量的需求
function PetRoleData:attrChange(data)
     if data.changeType ~= nil then
        local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY 
        self[ATTR_TYPE_ID_KEY[data.changeType]] = data.resultValue
    end
end


-- 开始刷新属性
function PetRoleData:startUpdateAttr()
    self.oldStatus = self.status
    self.oldNickName = self.nickName 
    self.oldIsVariant = self.isVariant
    self.oldCurHp = self.curHp
    self.oldRoleLV = self.roleLV
    self.oldCurLVExp = self.curLVExp 
end

-- 刷新最终属性
function PetRoleData:endUpdateAttr()
    self.nickName = ToolsUtil:replaceShowNickNameStr(self.nickName)
    if self.oldIsVariant ~= self.isVariant then
        self:conbinationLocalData()
    end
    self:showLevelUpAction(self.oldRoleLV, self.roleLV)
    if self.oldRoleLV ~= self.roleLV or self.oldIsVariant ~= self.isVariant then 
        self:setLevel(self.roleLV)
        if self.isBag then--背包宠才有的属性，来判断是否是背包宠
            self:calculateFightAttrs()
        end
    end

    if self.oldRoleLV ~= self.roleLV or self.oldIsVariant ~= self.isVariant or self.oldCurLVExp ~= self.curLVExp then
        self:refreshToBagPet()
        if not self.isBag and self:isFight() and self:getMasterSpriteID() == RoleDataManager:getMaster():getSpriteID() then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, self)
        end
    end
end

function PetRoleData:showLevelUpAction(startLevel, totalLevel)
    if startLevel and startLevel ~= totalLevel and not self.isBag then
        local cmdData = {}
        cmdData.spriteID = self.spriteID
        cmdData.startLevel = startLevel
        cmdData.totalLevel = totalLevel
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ROLE_LEVEL_UP, cmdData)
        local SceneManager = require("app.game.SceneManager")
        SceneManager:getInstance():pushCommand(command)
    end
end


--特殊操作 客户端需要同步最新场景宠物的属性到背包宠物里面
function PetRoleData:refreshToBagPet()
    if not self.isBag and self:isFight() and self:getMasterSpriteID() == RoleDataManager:getMaster():getSpriteID() then
        local bagPet = MasterDataManager:getBagPetById(self.petInstId)
        if bagPet and self.templateID == bagPet.templateID and self.spriteID == bagPet.spriteID then
            bagPet.isVariant = self.isVariant
            bagPet.curLVExp = self.curLVExp
            bagPet.hp = self.hp
            bagPet:conbinationLocalData()
            bagPet:setLevel(self:getLevel())
            bagPet:calculateFightAttrs()
        end
        
    end
end

-- 获取宠物依赖的ID
function PetRoleData:getMasterSpriteID()
    return self.masterSpriteID
end

function PetRoleData:setSkillCd(skillId, cdTime)
    self.skillCd[skillId] = cdTime + AvalonUtil.getCurrentTime()
end

function PetRoleData:getSkillCd(skillId)
    return self.skillCd[skillId] or 0
end

function PetRoleData:clearSkillCd()
    self.skillCd = {}
end


function PetRoleData:changeFunctionFlag(functionFlag)
    if not self.oldFunctionFlag then
        self.oldFunctionFlag = 0
    end

    self.functionFlag = functionFlag
    if self.oldFunctionFlag ~= self.functionFlag then
        self:handleFunctionFlag(self.oldFunctionFlag)
        self.oldFunctionFlag = functionFlag
    end
end

function PetRoleData:fullHp(hp)
    self.curHp = hp
    self.hp = hp
end

--如果是出战宠物  优先去出战位置获取
function PetRoleData:getAttrByName(attrName)
    if self:isFight() and self.isBag then
        local fPets = RoleDataManager:getScreenFightPetData()
        for k, fPet in pairs(fPets) do
            if fPet and tonumber(fPet.petInstId) == tonumber(self.spriteID) then--fPet.templateID == self.templateID then
                return fPet:getAttrByName(attrName)
            end
        end
        
    end
    return self[attrName] or 0
end

function PetRoleData:getBaseSkill()
    if self.isVariant then
        return self.baseskill[2]
    else
        return self.baseskill[1]
    end
end

-- 当前等级段内所拥有的经验
function PetRoleData:getCurExp()
    return self.curLVExp
end

-- 获取当前所拥有的所有经验
function PetRoleData:getCurTotalExp()
    local petData = MasterDataManager:getBagPetById(self.spriteID)
    local level = self.roleLV
    local curTotalExp = self.curLVExp
    for i = 1, level do
        local cfg = ConfigManager:getPetExpByID(i)
        curTotalExp = curTotalExp + cfg.expToNextLV
    end

    return curTotalExp
end

-- UI显示等级
function PetRoleData:getUIShowLv()
    local levelConfig = self:getNowReincarnationConfig()
    return self.roleLV - levelConfig.value
end

function PetRoleData:refreshSkillNum()
    -- 取表里的数据
    local templateConfig = ConfigManager:getPetDataByID(self.templateID)
    local levelList = string.split(templateConfig.skillNum, ";")
    local str1 = levelList[self.reincarntionLv + 1]
    local levelList2 = string.split(str1, ",")
    local tableList = {}
    for k,v in pairs(levelList2) do
        table.insert(tableList, tonumber(v))
    end
    self.skillNum = tableList

    self:refreshSkill()
end

function PetRoleData:refreshSkill()
    -- 根据转生等级刷新对应的技能ID
    -- self.giftedskill
    -- self.skillids

    --- 此处没有特质技能，统一返回nil
    local skillInfo = string.split(self.giftedskill, ";")

    if self.giftedskill == "" then
        return nil
    end

    local skillId
    -- 变异宠物特质技能是后面
    if self.isVariant then
        -- 逗号前是技能id，后面是服务器用作释放概率
        skillId = string.split(skillInfo[2], ",")[1]
    else
        skillId = string.split(skillInfo[1], ",")[1]
    end

    local config = ConfigManager:getPetReincarnationSkillDataByID(tonumber(skillId))
    if config and (self.reincarntionLv > 0) then
        -- 有需要的转生后的特质技能
        local skillIdInfo1 = string.split(skillInfo[1], ",")[2]
        local skillIdInfo2 = string.split(skillInfo[2], ",")[2]
        local giftedskillFinal = string.format("%d,%d;%d,%d", config.afterChangeSkillId, skillIdInfo1,config.afterChangeSkillId, skillIdInfo2)
        self.giftedskill = giftedskillFinal
        --print("self.giftedskill2222--->: ", self.giftedskill)
    end

    -- 普通技能
    if self.skillids and (self.reincarntionLv > 0) then
        for k,v in pairs(self.skillids) do
            local config = ConfigManager:getPetReincarnationSkillDataByID(tonumber(v))
            if config then
                self.skillids[k] = config.afterChangeSkillId
                --print("self.giftedskill--->: ", self.skillids[k])
            end
        end
    end

    self:refreshGiftSkill2()
end

function PetRoleData:refreshGiftSkill2()
    if self.giftedskill2 == "" then
        return
    end
    --- 此处没有特质技能，统一返回nil
    local skillInfo = string.split(self.giftedskill2, ";")

    local skillId
    -- 变异宠物特质技能是后面
    if self.isVariant then
        -- 逗号前是技能id，后面是服务器用作释放概率
        skillId = string.split(skillInfo[2], ",")[1]
    else
        skillId = string.split(skillInfo[1], ",")[1]
    end

    local config = ConfigManager:getPetReincarnationSkillDataByID(tonumber(skillId))
    if config and (self.reincarntionLv > 0) then
        -- 有需要的转生后的特质技能
        local skillIdInfo1 = string.split(skillInfo[1], ",")[2]
        local skillIdInfo2 = string.split(skillInfo[2], ",")[2]
        local giftedskillFinal = string.format("%d,%d;%d,%d", config.afterChangeSkillId, skillIdInfo1,config.afterChangeSkillId, skillIdInfo2)
        self.giftedskill2 = giftedskillFinal
    end
end

function PetRoleData:setSkinId(skinId)
    self.skinId = skinId
end

--生成PB数据发送到聊天 pet_system.petot >> PetRoleData
function PetRoleData:getBytesData()
    local ProtobufUtil = require "utils.ProtobufUtil"
    local decodeData = {}
    decodeData.uniqueid    = self.spriteID      -- 唯一ID
    decodeData.templateID  = self.templateID    --模版ID
    decodeData.nickName    = self.nickName      -- 昵称
    decodeData.level       = self:getLevel()    --等级
    decodeData.exp         = self:getCurExp()   --经验
    decodeData.isVariant   = self.isVariant     -- 是否变异
    decodeData.talents     = self.talents       -- 资质 按PetTalentType枚举值的顺序
    decodeData.extraTalents= self.extraTalents  -- 额外资质 按PetTalentType枚举值的顺序
    decodeData.skillids    = self.skillids      -- 技能列表，第一个是主动技能
    decodeData.stars       = self.stars         -- 星级
    decodeData.isReadyFight    = false          -- 是否出战
    decodeData.nameTimes   = self.nameTimes     -- 修改名字的次数
    decodeData.power       = self.power         -- 宠物战力(星数)
    decodeData.extraTalentPoints  = self.extraTalentPoints         -- 资质加点 按PetTalentType枚举值的顺序
    decodeData.talenPointUseNum = self.talenPointUseNum
    decodeData.talenPointItemUseNum = self.talenPointItemUseNum
    local bytesData =  ProtobufUtil:encode("PetSystem.PetRoleData", decodeData)
    return bytesData
end

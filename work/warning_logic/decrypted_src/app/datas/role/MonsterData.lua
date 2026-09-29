
--[[
    处理怪物属性定义
]]
require "app.datas.role.RoleData"

local MonsterData = class("MonsterData",Data.RoleData)  
local LanguageManager = require "app.game.LanguageManager"
local GameMapManager = require("app.game.GameMapManager")
local MonsterType = PublicDefine.MonsterType
local MonsterSubType = PublicDefine.MonsterSubType

Data = Data or {}
Data.MonsterData = MonsterData  
  
-- 构造函数(会自动调用)  
-- 外界构造时可以传任意参数XXX.new(...)  
function MonsterData:ctor(monsterID, model, difficulty)
    MonsterData.super.ctor(self, RoleType.Monster)
    
    self._model = model
    self._difficulty = difficulty 

    -- 蘑菇导致的怪物变形处理
    self._deformationData = nil
    -- 英雄模式变形的事件的处理
    self._heroModelDeformationData = nil
    self._enableDeformation = true

    --TODO 获取显示类型

    --TODO 添加基本属性

    self.isRandomChange = false

    self:init({monsterID = monsterID})

    --TODO 对于BOSS 以及特殊怪物还需要添加技能以及属性

    self.evoParts = {}

end  

-- 模版函数：
function MonsterData:getId()

	return self.monsterID
end

function MonsterData:getTemplateID()
    return self.monsterID
end

-- 模版函数：
function MonsterData:isReachable()
    if(self.isDead == false) then
        return true
    else
        return false
    end
end

function MonsterData:canBeNodeOfPath()
    if(self.isDead == false) then
        if self:getMonsterSubType() == MonsterSubType.Trigger  and self.isTrigger == false then
            return true
        end
    end

    return false
end

function MonsterData:canBeEndOfPath()
    if(self.isDead == false) then
        return true
    else    
        return false
    end
end

function MonsterData:init(data)
    --怪物ID
    self.monsterID = data.monsterID or -1
    self.roleNum = -1
    -- 怪物稀有度 (0-n 和服务器约定) 
    self.rare = data.rare or 0
    -- 词缀
    self._affixArr = {}
    -- -- 是否触发 ，这里只是对于 boss 以及触发怪，宝箱怪等才有意义， -- 弃用
    -- self.isTrigger = data.isTrigger or false
    self.triggerNum = data.triggerNum or 0
    -- 是否变身
    self.isTransform = false
    -- 是否激活
    self.isWaked = true
    self._changeTemplateID = false

    self._deformationData = nil
    self._heroModelDeformationData = nil
    self._enableDeformation = true
    self.isGroupMonster = data.isGroupMonster or false
    
    self:conbinationLocalData()

    self:refreshCurInitData()
    
    --怪物ID
    self.spriteID = data.spriteID or -1
    self.functionFlag = 0

    self.bossCallMonsterFlag = data.bossCallMonsterFlag or 0 -- 值为1 表示为发起召唤的怪物, 值为2 表示为被召唤出来的怪物 changeInit处初始化

    self.BossAIFlag = data.BossAIFlag or 0     -- BOSS进化标记 按位与

    self.coordX = data.coordX or 0
    self.coordY = data.coordY or 0
end

function MonsterData:setCoordXY(coordX, coordY)
    self.coordX = coordX
    self.coordY = coordY
end

function MonsterData:getAbsPosition()
    local MachineManager = require("app.game.MachineManager")
    local battleMachine = MachineManager:getInstance():getMachine()
    local sx, sy = battleMachine:getView()._map:coordinateToPosition(self.coordX, self.coordY)
    local pos = battleMachine:getView()._map:convertToWorldSpace(cc.p(sx,sy))
    return pos.x, pos.y
end

-- 模板函数
function MonsterData:refreshCurInitData()
    self.curHp = self.hp or 0
    self.curMp = self.mp or 0
end

function MonsterData:conbinationLocalData()
    if (self.monsterID ~= -1) then
        self._monsterData = ConfigManager:getMonsterConfig(self.monsterID, self._model, self._difficulty)
        if(self._monsterData) then
            self:setLocalConfigData(self._monsterData)
            self:refreshAttr(1, false)
        else
            printError(string.format("MonsterData:conbinationLocalData monsterID=%d", self.monsterID))
        end 
    end
end

-- 人数改变导致的数据变化
function MonsterData:refreshAttr(roleNum, isCoefficient)
    self.roleNum = roleNum

    if(isCoefficient == nil) then
        isCoefficient = false
    end

    if not self._monsterData then
        printError(string.format("MonsterData:refreshAttr  _monsterData is nil, monsterID=%d init is error",self.monsterID))
    end

    -- TODO 根据需求，需要在查看属性的时候只看本地数据，这里需要恢复

    -- 处理难度改变后怪物属性转换
    -- print("MonsterData:refreshAttrmonster.monsterID,hp,atkMin,defWater pre=",self.monsterID,self.hp,self.atkMin,self.defWater)
    local attrGetArr = {
        "hp","atkMin","atkMax","magicAtkMin","magicAtkMax","physicDef","magicDef",
        "atkFire","atkWater","atkWood","atkLight","atkDark",
        "defFire","defWater","defWood","defLight","defDark","dropCoin","dropExp"
    }

    for k,v in pairs(attrGetArr) do
        self:_attrTableToValue(self._monsterData,v,roleNum,self.rare)
    end
    -- print("MonsterData:refreshAttr  isCoefficient=", isCoefficient)
    if(isCoefficient) then
        local SceneManager = require("app.game.SceneManager")
        if((SceneManager:getInstance():isInDungeon() 
            or SceneManager:getInstance():isInHero()
            or SceneManager:getInstance():isInDream()
            or SceneManager:getInstance():isInHuLu()
            or SceneManager:getInstance():isInTitanHero())) then 
            local level = GameMapManager:getInstance():getLevel()

            if(SceneManager:getInstance():isInHero()) then 
                local calLevel = 900000
                local mapData = GameMapManager:getInstance():getMapData()
                local GameDataManager = require("app.game.GameDataManager")
                local stage = GameDataManager:getInstance():getHeroModelStageLevel(level)
                if(mapData) then
                    local schemeIDS = mapData:getHeroCaveSchemeIDS()
                    if(schemeIDS) then 
                        calLevel = calLevel + 1000 * #schemeIDS
                    end
                    -- calLevel = calLevel + mapData:getNumber()
                    calLevel = calLevel + stage
                end

                -- print("SceneManager:getInstance():isInHero() 1", calLevel, mapData:getNumber())
                -- print("SceneManager:getInstance():isInHero() 2", calLevel, stage)
                level = calLevel
            elseif SceneManager:getInstance():isInTitanHero() then
                local calLevel = 900000
                local mapData = GameMapManager:getInstance():getMapData()
                local GameDataManager = require("app.game.GameDataManager")
                local stage = GameDataManager:getInstance():getHeroModelStageLevel(level)
                if(mapData) then
                    local schemeIDS = mapData:getHeroCaveSchemeIDS()
                    if(schemeIDS) then 
                        calLevel = calLevel + 1000 * #schemeIDS
                    end
                    -- calLevel = calLevel + mapData:getNumber()
                    calLevel = calLevel + stage
                end

                -- print("SceneManager:getInstance():isInTitanHero() 1", calLevel, mapData:getNumber())
                -- print("SceneManager:getInstance():isInTitanHero() 2", calLevel, stage)
                level = calLevel
            elseif(SceneManager:getInstance():isInDungeon()) then 
                local maxLevel = ConfigManager:getDungeonMaxLevel()
                if(level > maxLevel) then
                    level = maxLevel
                end
            elseif(SceneManager:getInstance():isInDream()) then 
                local dreamLevel = GameMapManager:getInstance():getDreamLV()
                local bossID = GameMapManager:getInstance():getDreamCurBossIndex()
                local dreamConfig = ConfigManager:getDreamConfigForLV(dreamLevel)
                if(dreamConfig and bossID >= 0) then 
                    level = dreamConfig.monsterCoefficientID[bossID]
                else 
                    level = -1
                end
            elseif(SceneManager:getInstance():isInHuLu()) then 
                level= 110001
                local masterData = RoleDataManager:getMaster()
                if(masterData and masterData:getLevel() >= 21) then 
                    level = level + math.floor((masterData:getLevel()-1)/10) -1
                end
            end

            local coefficientConfig = ConfigManager:getMonsterCoefficientConfigByLevel(level)
            -- print("MonsterData:refreshAttr  isCoefficient, level=", coefficientConfig, level)
            
            local attrPercentArr = {
                "hp","atkMin","atkMax","magicAtkMin","magicAtkMax","physicDef","magicDef",
                "atkFire","atkWater","atkWood","atkLight","atkDark",
                "defFire","defWater","defWood","defLight","defDark"
            }

            if(coefficientConfig) then
                for k,v in pairs(attrPercentArr) do
                    if(coefficientConfig[v]) then
                        local coefficent = AvalonUtil:splitStr(coefficientConfig[v], ";")
                        -- print("wwwwwwwwwwww", roleNum, k, v)
                        if(coefficent and coefficent[roleNum] ~= nil) then
                            -- local old = self[v]
                            -- 计算秘境强度处理向下取整
                            self[v] = math.floor(self[v] * tonumber(coefficent[roleNum]) /RATIO_NUMBER)

                            -- print("attrname, now, old=", v, self[v], old)
                        end
                    end
                end  
            end         
        end 
    end
    -- print("MonsterData:refreshAttrmonster.monsterID,hp,atkMin,defWater end=",self.monsterID,self.hp,self.atkMin,self.defWater)
end

-- 开始刷新属性
function MonsterData:startUpdateAttr()
    self.skillRelatedFlagOld = self.skillRelatedFlag
    self.functionFlagOld = self.functionFlag

    self.BossAIFlagOld = self.BossAIFlag
end

-- 刷新最终属性
function MonsterData:endUpdateAttr()
    self:handleFunctionFlag(self.functionFlagOld)
    -- 处理刷新技能是否能够使用的状态
    if(self.skillRelatedFlagOld ~= self.skillRelatedFlag) then
        self:handleSkillRelatedFlag(self.skillRelatedFlagOld)
    end

    if self.BossAIFlagOld ~= self.BossAIFlag then
        self:handleBossAIFlag(self.BossAIFlag)
    end

    local percent = (self.energy or 0)/PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE
    Avalon.MessageCenter:notice(GameMessage.MC_UI_UPDATE_DECORETION_PROGRESS, "BOSS6_ENERGY_KEY", percent)
end

function MonsterData:changeInit(data)
    if type(data) ~= "table" then
        return
    end
    local oldMonsterId = self.monsterID
    self:startUpdateAttr()
    for k,v in pairs(data) do 
        if type(v) ~= "table" then
            self[k] = v
        else 
            --TODO 处理table属性的处理
        end
    end
    
    self:endUpdateAttr()
    -- print("MonsterData:changeInit  monsterID,spriteID,type,category=",self.monsterID,self.spriteID,self:getType(),self._category)
    local oldCurHp = self.curHp
    local oldHp = self.hp

    --初始化energy值
    self.energy = self.energyValue
    
    print("   data.monsterID ========= ",data.monsterID, oldMonsterId, data.monsterID and (oldMonsterId ~= data.monsterID) and (data.monsterID ~= -1))

    if data.monsterID and (oldMonsterId ~= data.monsterID) and (data.monsterID ~= -1) then
        -- 在这里只会是出现变身情况逻辑。
        self._changeTemplateID = true
        self:conbinationLocalData()
        self.curHp = oldCurHp
        self.hp = oldHp
    end
end

function MonsterData:clearAllAffix()
    self._affixArr = {}
end

-- 添加词缀
function MonsterData:addAffix(affixID)
    -- 处理词缀更新
    local affixData = Data.MonsterAffixData:create(affixID)
    if(affixData) then
        table.insert(self._affixArr,affixData)
    end
end

-- 移除词缀
function MonsterData:removeAffixForID(affixID)
    if self._affixArr then
        for k,affixData in ipairs(self._affixArr) do
            if(affixData.affixID == affixID) then
                table.remove(self._affixArr,k)
                break;
            end
        end
    end
end

function MonsterData:attrChange(data)
    if data.changeType ~= nil then
        local ATTR_TYPE_ID_KEY = PublicDefine.ATTR_TYPE_ID_KEY 
        -- print("MonsterData:attrChange pre key,value=",ATTR_TYPE_ID_KEY[data.changeType],self[ATTR_TYPE_ID_KEY[data.changeType]])
        -- self[ATTR_TYPE_ID_KEY[data.changeType]] = self[ATTR_TYPE_ID_KEY[data.changeType]] + data.changeValue
        self[ATTR_TYPE_ID_KEY[data.changeType]] = data.resultValue
        
        -- print("MonsterData:attrChange end key,value=",ATTR_TYPE_ID_KEY[data.changeType],self[ATTR_TYPE_ID_KEY[data.changeType]])

        --TODO 处理发送相关的消息
    end
end

-- 启用变身
function MonsterData:enableDeformation()
    self._enableDeformation = true
end

-- 禁用变身
function MonsterData:disableDeformation()
    self._enableDeformation = false
end

function MonsterData:getTreasureType()
    if(self._enableDeformation) then 
        if (self._deformationData) then
            return self._deformationData:getTreasureType()
        end

        if (self._heroModelDeformationData) then 
            if(self._heroModelDeformationData:getCategory() == Category.TRIGGER_NPC) then 
                return self._heroModelDeformationData:getTreasureType()
            end 
        end 
    end 

    return 0
end

function MonsterData:getIsOpen()
    if(self._enableDeformation) then 
        if (self._deformationData) then
            return self._deformationData:getIsOpen()
        end

        if (self._heroModelDeformationData) then 
            if(self._heroModelDeformationData:getCategory() == Category.TRIGGER_NPC) then 
                return self._heroModelDeformationData:getIsOpen()
            end 
        end 
    end 

    return false
end

-- 获取等级
function MonsterData:getLevel()
    return self.roleLV
end

-- 获取虚幻后的分类
function MonsterData:getDeformationCategory()
    if(self._enableDeformation) then 
        if (self._deformationData) then
            return self._deformationData:getCategory()
        end

        if (self._heroModelDeformationData) then 
            return self._heroModelDeformationData:getCategory()
        end 
    end 

    return self._category
end

-- 获取虚幻后的类型
function MonsterData:getDeformationType()
    if(self._enableDeformation) then 
        if (self._deformationData) then
            return self._deformationData:getType()
        end

        if (self._heroModelDeformationData) then 
            return self._heroModelDeformationData:getType()
        end 
    end 

    return self._type
end

function MonsterData:getDeformationTypeForMinimap()
    if(self._enableDeformation) then 
        if (self._deformationData) then
            return self._deformationData:getTypeForMinimap()
        end

        if (self._heroModelDeformationData) then 
            return self._heroModelDeformationData:getTypeForMinimap()
        end 
    end 

    return 0
end

-- 判断是否变形
function  MonsterData:isDeformation()
    if(self._enableDeformation) then 
        if(self._deformationData) then
            return true
        end

        if(self._heroModelDeformationData) then 
            return true
        end
    end 

    return false
end

-- 获取变形后的数据
function MonsterData:getDeformationData()
    if(self._enableDeformation) then 
        if (self._deformationData) then 
            return self._deformationData
        end

        if (self._heroModelDeformationData) then 
            return self._heroModelDeformationData
        end
    end 

    return nil
end

-- 设置变形的数据  nil 代表清空变形效果
function MonsterData:setDeformationID(deformationID)
    if(deformationID) then
        self._deformationData = RoleDataManager:createLocalTriggerNpcData(deformationID)
    else
        self._deformationData = nil
    end
end

function MonsterData:setHeroDeformationID(deformationID)
    if(deformationID) then
        self._heroModelDeformationData = RoleDataManager:createLocalMonsterOrTriggerNpcData(deformationID)
    else
        self._heroModelDeformationData = nil
    end
end

-- 获取迷惑变型数据
function MonsterData:getIsNormalDeformation()
    if self._deformationData then 
        return true 
    else 
        return false 
    end 
end

-- 获取英雄模式变形
function MonsterData:getIsHeroDeformation()
    if self._heroModelDeformationData then 
        return true 
    else 
        return false 
    end 
end

function MonsterData:getName()
    if(self:getIsPetTrigger()) then 
        return self.petName
    else 
        return self.name
    end
end

-- 获取怪物的攻击间隔
function MonsterData:getAttackDuration()
    return self.atkSpd / 1000
end

-- 获取怪物品质
function MonsterData:getMonsterRare()
    return self.rare
end

function MonsterData:setMonsterRare(rare)
    self.rare = rare
end

-- 获取所有词缀列表
function MonsterData:getAllAffixArr()
    return self._affixArr
end

-- 判断是否需要触发
function MonsterData:judgeNeedToTrigger()
    if(self:isBigBoss() or self:getMonsterSubType() == MonsterSubType.Trigger or self:getMonsterSubType() == MonsterSubType.Treasure) then
        return true
    end

    return false
end

-- 获取是否触发，仅用于相关boss，触发怪等
function MonsterData:getIsTrigger()
    -- print("getIsTrigger", self:getId(), self.triggerNum, self:judgeNeedToTrigger())
    if(self:judgeNeedToTrigger()) then
        -- add by zp 这里由于服务器设置状态没有调试成功，临时客户端做的处理
        local SceneManager = require("app.game.SceneManager")
        if(SceneManager:getInstance():isActivityCave()) then 
            return true
        end
        if(SceneManager:getInstance():isGhostAbyss()) then 
            return true
        end

        return self.triggerNum == 1 or self.triggerNum == 2
    end

    return false
end

function MonsterData:setIsTrigger(var)
    -- self.isTrigger = var
    if(not var) then 
        if(self:judgeNeedToTrigger()) then 
            if(self.triggerNum == 1) then 
                self.triggerNum = 0
            end
        else 
            if(self.triggerNum == 1) then 
                self.triggerNum = 0
            end
        end
    else 
        -- if(self.triggerNum == 0 and self:judgeNeedToTrigger()) then 
        --     self.triggerNum = 1
        -- end
    end
end

--  获取是否宠物宝宝触发状态
function MonsterData:getIsPetTrigger()
    if(self.isPet == 1) then
        if(self:judgeNeedToTrigger()) then 
            return self.triggerNum == 2
        else  
            return self.triggerNum == 1
        end
    else
        return false
    end
end

function MonsterData:setTriggerNum(triggerNum)
    self.triggerNum = triggerNum
end

function MonsterData:getTriggerNum()
    return self.triggerNum
end

function MonsterData:getIsPet()
    -- print("MonsterData:getIsPet", self.isPet)
    return self.isPet == 1
end

function MonsterData:getPetName()
    return self.petName
end

-- 获取是否变身
function MonsterData:getIsTransform()
    return self.isTransform
end

-- 是否激活
function MonsterData:getIsWake()
    return self.isWaked
end

-- 获取是否改变模板ID
function MonsterData:getIsChangeTemplateID()
    return self._changeTemplateID
end

-- 设置是否改变模板ID的标志
function MonsterData:setIsChangeTemplateID(flag)
    self._changeTemplateID = flag
end

-- 获取是否变身
function MonsterData:getTransformAnimation()
    if self.changeID == nil or self.changeID == 0 then
        return
    end
    local tempData = ConfigManager:getMonsterConfig(self.changeID, self._model, self._difficulty)
    if tempData == nil then
        return
    end
    return tempData.skeleton, tempData.atlas, tempData.scale, tempData.name
end

-- 普通怪
function MonsterData:isNormalMonster()
    if self:getMonsterType() == MonsterType.Normal then
        return self.rare == 0
    else
        return false
    end
end

-- 精英怪
function MonsterData:isEliteMonster()
    if self:getMonsterType() == MonsterType.Normal then
        return self.rare == 1
    else
        return false
    end
end

-- 在战斗胜利后是否往前面走一格
function MonsterData:getIsMoveFowardAfterWin()
    if(self.property == 1) then 
        return false
    end

    if(self:isSmallBoss()) then 
        return false
    end

    return true
end

-- 小boss
function MonsterData:isSmallBoss()
    if self:getMonsterType() == MonsterType.LittleBoss then
        return true
    else
        return false
    end
end

-- 大boss
function MonsterData:isBigBoss()
    if self:getMonsterType() == MonsterType.Boss then
        return true
    else
        return false
    end
end

-- 获取装饰物ID
function MonsterData:getDecorationId()
    return tonumber(self.beConnectedObjectId)
end

-- 装饰物是否移除
function MonsterData:isToRemoveDecoration()
    if(self.objectCanBeDisappeared ~= 0) then
        return true
    end

    return false
end

-- 自己是否移除
function MonsterData:isToRemoveSelf()
    -- 计算是否移除
    if(self.bodyCanBeDisappeared ~=0) then
        return true
    end

    return false
end

-- 判断是否转向
function MonsterData:isTurnAround()
    if(self.ifTurnedAround == 1) then
        return true
    else 
        return false
    end 
end

-- 获取怪物ICON
function MonsterData:getIcon()
    return self.icon
end
-- 获取尺寸
function MonsterData:getOccupySize()
    return self.occupySize
    -- return {3,3}
end

-- 获取怪物类型
function MonsterData:getMonsterType()
    return ToolsUtil:calculationMonsterType(self.monsterID)
end

-- 获取怪物
function MonsterData:getMonsterSubType()
    return self.monsterSubType
end

-- 怪物是否是群怪
function MonsterData:getIsGroupMonster()
    return self.isGroupMonster
end

function MonsterData:_attrTableToValue(monsterData,attrName,roleNum,rare)
    -- print("ConfigRole:_attrTableToValue  monsterData,attrName,roleNum,rare=",monsterData,attrName,roleNum,rare)
    if monsterData then
        if (monsterData[attrName]) then
            local allStr = monsterData[attrName]
            -- 新怪物配置解析方式
            local diffArr = AvalonUtil:splitStr(allStr, ";")
            local attrArr = AvalonUtil:splitStr(diffArr[roleNum],",")
            local str = attrArr[rare+1]
            self[attrName] =  tonumber(str)
        end
    end
end

--如果是self.isTransform 为 true， 但是模版数据里面有没有变身后的模版ID（changeID），则认为这个monster 是变身后的monster，需要重新组装显示数据
function MonsterData:refreshTransformData()
    if not self.isTransform then
        return
    end
    if self.changeID ~= nil and self.changeID ~= 0 then
        return
    end
    local tempData = ConfigManager:getMonsterConfigByChangeId(self.monsterID, self._model, self._difficulty)

    if tempData == nil then
        return
    end


    return true, tempData.skeleton, tempData.atlas, tempData.scale
end

-- 存在配置没有changeID但是需要随机变身的怪物，变身怪物ID由服务器下发
function MonsterData:setChangeID(monsterID)
    if self.changeID == nil or self.changeID == 0 or (self.changeID ~= 0 and self.isRandomChange) then
        self.changeID = monsterID
        self.isRandomChange = true
    end
end

function MonsterData:getChangeID()
    return self.changeID
end

function MonsterData:checkIsRandomChange()
    return self.isRandomChange
end

function MonsterData:checkIsRandomChangeMonster()
    local isRandomChangeMonster = false
    if self.randomChangeID then
        if next(self.randomChangeID) and table.nums(self.randomChangeID) > 0 then
            isRandomChangeMonster = true
        end
    end
    return isRandomChangeMonster
end

function MonsterData:handleBossAIFlag(flag)
    local evoParts = {}
    local monsterEvoConfig = ConfigManager:getAllMonstersSkinDataByID(self.monsterID)
    if monsterEvoConfig then
        local partsList = string.split(monsterEvoConfig.FxAnimName, ";" )
        local partsAttrList = string.split(monsterEvoConfig.partAttribute, ";" )

        for k, v in pairs(partsAttrList) do
            v = tonumber(v) 
            if bit.band(flag, v) > 0 then
                evoParts[v] = partsList[k]
            end 
        end

        self.evoParts = evoParts
        if next(evoParts) then
            local SceneManager = require("app.game.SceneManager")
            local evoCommand = Command.BattleCommand:create(true)
            evoCommand:initTriggerMonsterEvo(self.spriteID, evoParts)
            SceneManager:getInstance():pushCommand(evoCommand)
        end
    end
    
end


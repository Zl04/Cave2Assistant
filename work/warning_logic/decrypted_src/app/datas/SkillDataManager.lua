--[[
    技能数据管理：
        包括内容：技能，BUFF，效果
]]

require "app.config.ConfigManager"

require "app.datas.skill.SkillData"
require "app.datas.skill.SkillBlessingData"
require "app.datas.skill.BufferData"
require "app.datas.skill.EffectData"
require "app.datas.skill.SkillGroupData"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local DEBUG = false

SkillDataManager = SkillDataManager or {}

function SkillDataManager:init()
    -- 玩家自己技能
    self._masterList = {}  
    -- 所有需要保存玩家的技能 {pk:{SkillData}}
    self._skillMap = {}
    -- 所有角色身上的BUFF {entityID:bufferData}
    self._buffMap = {}
    -- 用来区分角色对象
    self._buffRoleArr = {}
    -- 所有角色身上的EFFECT
    self._effectList = {}
    -- 进阶后的对比文件
    self._skillBlessingArr = nil

    -- 主角身上的技能列表
    self._skillGroupList = {}

    --技能group替换log
    self._skillGroupReplacLog = {}

    self.curSkillSelectType = 0

    -- 正常战斗场景配置技能
    self._configBattleSkills = {}

     --被锁技能的状态 key = skillID value = remainCount
    self._shadowSkill = {}

    -- 大地诅咒锁定的技能 key = skillID
    self._ntfMarkSkill = {}

    -- 进战技能列表CD
    self.enterFightSkillCoolDownList = {}

    -- 宠物进战技能列表CD
    self.petEnterFightSkillCoolDownList = {}

    -- 已购买技能页
    self.boughtSkillLabelList = {}
end

function SkillDataManager:setCurSkillSelectType(curSkillSelectType)
    local oldSkillSelectType = self.curSkillSelectType
    self.curSkillSelectType = curSkillSelectType
end

function SkillDataManager:getCurSkillSelectType()
    if(SceneManager:getInstance():isInHuLu()) then 
        return 0
    end

    return self.curSkillSelectType
end


function SkillDataManager:clear()
    table.clear(self._masterList)
    table.clear(self._skillMap)
    table.clear(self._buffMap)
    table.clear(self._buffRoleArr)
    table.clear(self._effectList)
    table.clear(self._skillGroupList)
    self._shadowSkill = {}
    self._ntfMarkSkill = {}
    self._skillBlessingArr = nil
    self.cacheSkillIDForSkillTree = nil

end

function SkillDataManager:switchMasterSpriteID(oldSpriteID,newSpriteID)
    -- 处理其余数据
    self._buffRoleArr[newSpriteID] = self._buffRoleArr[oldSpriteID]
    if newSpriteID ~= oldSpriteID then
        self._buffRoleArr[oldSpriteID] = nil
    end
end

-- 进入下一层清理数据
function SkillDataManager:nextFloorClear()
    local masterData = GameDataManager:getInstance():getMaster()
    local spriteID = nil
    if(masterData) then
        spriteID = masterData:getSpriteID()
    end

    -- 清理buff 数据
    for k,arr in pairs(self._buffRoleArr) do
        if k ~= spriteID then
            for index,bufferData in ipairs(arr) do
                self._buffMap[bufferData.entityID] = nil
            end
            self._buffRoleArr[k] = nil
        end
    end
end

-- 回档（恢复）清理数据
function SkillDataManager:restoreClear()
    -- TODO 回档（恢复）清理数据

    self._masterList = {} --通过addSkill协议进行加入，玩家获取主动技能等的源
    self._skillMap = {} --_masterList == _skillMap[masterpk]
    self._buffMap = {}
    self._buffRoleArr = {}
    self._effectList = {}
    self._skillGroupList = {}
    self._skillGroupReplacLog = {}
    
end

-- 重置技能数的配置文件
function SkillDataManager:resetSkillTreeConfig()
    for k, skillGroupData in pairs(self._skillGroupList) do 
        skillGroupData:refreshConfig()
    end
end

function SkillDataManager:update(dt)
    -- 刷新BUFF的时间
    if(GameManager:getCountDownSwitch()) then
        if(self._buffMap) then 
            for _,bufferData in pairs(self._buffMap) do 
                bufferData:update(dt)
            end
        end
    end
end

-- 根据 PK和spriteID 清理数据
function SkillDataManager:clearDataForPKANDSpriteID(pk, spriteID)
    for k,arr in pairs(self._buffRoleArr) do
        if k == spriteID then
            for index,bufferData in ipairs(arr) do
                self._buffMap[bufferData.entityID] = nil
            end
            self._buffRoleArr[k] = nil
        end
    end
end

-- 根据 spriteID 清理buff数据
function SkillDataManager:clearDataForSpriteID(spriteID)
    for k,arr in pairs(self._buffRoleArr) do
        if k == spriteID then
            for index,bufferData in ipairs(arr) do
                self._buffMap[bufferData.entityID] = nil
            end
            self._buffRoleArr[k] = nil
        end
    end
end

-- 获取玩家学习的技能列表
function SkillDataManager:getMasterLearnSkillList()
    --TODO 获取玩家学习的技能列表

    -- TODO 用于测试
    local learnArr = {}
    local skillArr = self._masterList
    for k,skillData in pairs(skillArr) do
        if skillData.type == SkillType.NORMAL_ATTACK 
        or skillData.type == SkillType.PHYSICAL 
        or skillData.type == SkillType.MAGIC 
        or skillData.type == SkillType.ASSIST 
        or skillData.type == SkillType.PASSIVE then

            table.insert(learnArr,skillData)
        end
    end
    if DEBUG then
        print("SkillDataManager:getMasterLearnSkillList 3=",#learnArr)
    end

    return learnArr
end

function SkillDataManager:getLearnPointByWeapType(equipType)
    local point = 0
    for k,v in pairs(self._skillGroupList) do
        if v:getLevel() ~= 0 then
            if v:getSkillType() == equipType then
                point = point + v.level or 0 --不能使用getLevel
            end
        end
    end
    return point
end

-- 获取玩家学习了那些主动技能
function SkillDataManager:getMasterLearnActiveSkillList(weaponType)
    -- 获取玩家学习的主动技能
    local learnArr = {}
    local skillArr = self._masterList

    local weaponType = weaponType or GameDataManager:getInstance():getWearWeaponType()
    local userSkillList = self:getUseSKillListByEquipType(weaponType)
    print(string.format("weaponType=%d",weaponType))
    -- dump(userSkillList)

    -- print("master Have Skill List ")
    -- dump(skillArr)

    for k,skillData in pairs(skillArr) do
        if DEBUG then
            print("SkillDataManager:getMasterLearnActiveSkillList skillID",skillData.skillID,skillData:isActive(),weaponType,self:getSkillTypeBySkillID(skillData.skillID))
        end
        if skillData:isActive() then
            local _weaType = self:getSkillTypeBySkillID(skillData.skillID)
            if(_weaType == weaponType or _weaType == 0) then
                table.insert(learnArr,skillData)
            end
        end
    end

    print("SkillDataManager:getMasterLearnActiveSkillList learnArr.lenght=",#learnArr)
    return learnArr
end

function SkillDataManager:getReplaceMasterLearnActiveSkillList(weaponType)
    local list = self:getMasterLearnActiveSkillList()
    local tempList = {}
    for k, skillData in ipairs(list) do
        local orgGroupId = self:getSkillGroupIDBySKillID(skillData:getId())
        local orgGroupData = self:getSkillGroup(orgGroupId)
        local isFound = false
        if orgGroupData then
            local repGroupId = self:getChangedGroupID(orgGroupData.skillGroupID)
            if repGroupId then
                local skillGroup = self:createTempSkillGroupData(repGroupId, orgGroupData:getLevel() + orgGroupData:getChangeLv())
                table.insert(tempList, skillGroup.skillData) 
                isFound = true
            end
        end
        if not isFound then
            table.insert(tempList, skillData)
        end
    end
    return tempList
end

--创建一个临时的技能组数据
function SkillDataManager:createTempSkillGroupData(skillGroupID, level)
    local data = {}
    data.skillGroupID = skillGroupID
    data.level = level
    local skillTreeData = Data.SkillGroupData:create()
    skillTreeData:initNet(data)
    return skillTreeData
end



-- 获取玩家的辅助技能
function SkillDataManager:getMasterLearnAssistSkillList()
    -- 获取玩家学习的辅助技能
    local learnArr = {}
    local skillArr = self._masterList

    -- local userSkillList = self:getUseSKillListByEquipType(GameDataManager:getInstance():getWearWeaponType())
    -- for _,skillID in pairs(userSkillList) do
    --     for k,skillData in pairs(skillArr) do
    --         if(skillData:getSkillID() == skillID) then
    --             if skillData:isAssist() then
    --                 table.insert(learnArr,skillData)
    --             end
    --             break
    --         end
    --     end
    -- end
    if(not SceneManager:getInstance():isUseLocalShortcutBar()) then
        local weaponType = GameDataManager:getInstance():getWearWeaponType()
        for k,skillData in pairs(skillArr) do
            if DEBUG then
                print("SkillDataManager:getMasterLearnActiveSkillList skillID",skillData.skillID,skillData:isAssist(),weaponType,self:getSkillTypeBySkillID(skillData.skillID))
            end
            if skillData:isAssist() then
                local _weaType = self:getSkillTypeBySkillID(skillData.skillID)
                if(_weaType == weaponType or _weaType == 0) then
                    table.insert(learnArr,skillData)
                end
            end
        end
    end
    return learnArr
end


-- 根据pk 获取英雄学习的技能列表
function SkillDataManager:getLearnSkillDataForPk(pk)
    -- 根据英雄ID获取玩家技能列表
    local learnArr = {}
    local skillArr = self._skillMap[pk]
    if skillArr then
        for k,skillData in pairs(skillArr) do
            if skillData.type == SkillType.PHYSICAL or skillData.type == SkillType.MAGIC then
                table.insert(learnArr,skillData)
            end
        end
    end

    return learnArr
end

-- 根据技能ID获取技能数据
function SkillDataManager:getSkillDataForSkillID(skillID, isPet) 
    if not isPet then
        local masterPK = RoleDataManager:getMasterPK()
        local skillArr = self._skillMap[masterPK]
        if(skillArr) then
            for k,skillData in pairs(skillArr) do
                if skillData:getSkillID() == skillID then
                    return skillData
                end
            end
        end
    else
        return self:getSkillDataForSkillIDFromPet(nil, skillID)
    end
    return nil
end


function SkillDataManager:getSkillDataForSkillIDFromPet(petRoleData, skillID) 
    require "app.config.ConfigManager"
    local skillData = self:createSkillForSkillId(skillID)
    return skillData
end


function SkillDataManager:getAllSkillBlessing()
    if(self._skillBlessingArr == nil) then 
        self._skillBlessingArr = {}
        local skillBlessing = ConfigManager:getAllSkillBlessing()
        if(skillBlessing) then 
            for k, localData in pairs(skillBlessing) do 
                if(type(localData) == "table") then
                    local blessingData = Data.SkillBlessingData:create()
                    blessingData:initLocal(localData)

                    table.insert(self._skillBlessingArr, blessingData)
                end
            end
        end

        table.sort(self._skillBlessingArr, function(a, b)
            if(a:getID() < b:getID()) then 
                return true 
            end

            return false
        end)
    end

    return self._skillBlessingArr
end

function SkillDataManager:clearIsOpenStatus()
    local masterPK = RoleDataManager:getMasterPK()
    local skillArr = self._skillMap[masterPK]
    if(skillArr) then
        for k,skillData in pairs(skillArr) do
            skillData:setIsOpening(false) 
        end
    end
end

-- 根据技能ID获取技能数据
function SkillDataManager:createSkillForSkillId(skillID)
    if DEBUG then
        print("SkillDataManager:createSkillForSkillId ",skillID)
    end
    local skillAttr = ConfigManager:getSkillConfigById(skillID)
    if(skillAttr) then
        local skillData = Data.SkillData:create(skillID)
        skillData:initLocal(skillAttr)

        return skillData
    end 

    return nil
end

-- 根据PK获取普通攻击
function SkillDataManager:getNormalSkillForPK(pk)
    if DEBUG then
        print("SkillDataManager:getNormalSkillForPK ",pk)
    end
    local skillArr = self._skillMap[pk]
    local normalSkillData = nil
    if skillArr then
        for k,skillData in ipairs(skillArr) do
            if skillData.type == SkillType.NORMAL_ATTACK then
                normalSkillData = skillData
                break
            end
        end
    end

    return normalSkillData
end

-- 处理BUFF 数据处理
function SkillDataManager:handleBufferData(data, isRecover)
    print("SkillDataManager:handleBufferData",isRecover, data.entityID, data.buffID)
    local bufferData = self:createBufferData(data.buffID)
    if(bufferData) then
        bufferData:initNet(data)
        if(isRecover) then
            bufferData:setAddNew(false)
        else 
            bufferData:setAddNew(true)
        end

        -- 添加buff 到列表里面
        return self:addBuff(data.targetSpriteID,bufferData)
    else
        return nil
    end
end

-- 处理BUFF 恢复数据
function SkillDataManager:handleBufferDataReback(data,targetSpriteID)
    local bufferData = self:createBufferData(data.buffID)
    if(bufferData) then
        bufferData:initNetReback(data,targetSpriteID)
        bufferData:setAddNew(false)

        -- 添加buff 到列表里面
        return self:addBuff(targetSpriteID,bufferData)
    else 
        return nil
    end
end

-- 获取所有buff 列表
function SkillDataManager:getBufferDataListForSpriteID(spriteID)
    return self._buffRoleArr[spriteID]
end

-- 判断指定spriteID 中是否存在某个buff
function SkillDataManager:checkBuffIsExistBySproteID(spriteID)
    local hasEat = false
    local buffList = self:getBufferDataListForSpriteID(spriteID)
    local buffData = nil
    if buffList then
        for k,v in pairs(buffList) do
            if v:getBuffEffectType() == 24 then
            -- if v.buffID == buffId then
                hasEat = true
                buffData = v
                break
            end
        end
    end

    return hasEat,buffData
end

-- 创建一个bufferData
function SkillDataManager:createBufferData(buffID)
    local buffConfig = ConfigManager:getBufferConfigById(buffID)
    if(buffConfig) then
        return Data.BufferData:create(buffID)
    end 

    return nil
end

function SkillDataManager:handleBuffRemain(data) 
    local bufferDataList = {}
    local buffArr = self:getBufferDataListForSpriteID(data.spriteID)
    if(buffArr) then 
        for k,bufferData in pairs(buffArr) do
            if bufferData.entityID == data.instID then
                bufferData:setServerDuration(data.remainTime)

                table.insert(bufferDataList, bufferData)

                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_UPDATE_BUFFER, {
                    bufferData = bufferData,
                    bufferEntityID = bufferData:getEntityID(),
                    bufferTargetID = bufferData:getTargetSpriteID(),
                    overlay = bufferData:getOverlayNum(),
                    leftTime = bufferData:getDuration()*1000
                })
            end
        end
    end

    return bufferDataList
end

--------------------------------以下为加入相关数据的接口---------------------------------------

-- 存储恢复buff 数据
function SkillDataManager:saveRecoverBuffData(data)
    -- self._saveBuffData = data
    if(data) then 
        self._saveBuffData = {}
        for k,v in pairs(data) do
            table.insert(self._saveBuffData, v)
        end
    else 
        self._saveBuffData = nil
    end
end

-- 获取暂存数据
function SkillDataManager:getSaveRecoverBuffData()
    return self._saveBuffData
end

-- 删除暂存的buffer数据（这里是玩家自己的数据）
function SkillDataManager:_deleteSaveRecoverBuffData(entityID)
    if(self._saveBuffData) then 
        for k,v in pairs(self._saveBuffData) do
            if(v.entityID == entityID) then 
                table.remove(self._saveBuffData, k)
                break;
            end
        end
    end
end

-- 存储恢复buff 数据
function SkillDataManager:savePetRecoverBuffData(data)
    -- self._saveBuffData = data
    if(data) then 
        self._savePetBuffData = {}
        for k,v in pairs(data) do
            table.insert(self._savePetBuffData, v)
        end
    else 
        self._savePetBuffData = nil
    end
end

-- 获取暂存数据
function SkillDataManager:getPetRecoverBuffData()
    return self._savePetBuffData
end


-- 删除暂存的buffer数据（这里是玩家自己的数据）
function SkillDataManager:_deletePetRecoverBuffData(entityID)
    if(self._savePetBuffData) then 
        for k,v in pairs(self._savePetBuffData) do
            if(v.entityID == entityID) then 
                table.remove(self._savePetBuffData, k)
                break;
            end
        end
    end
end


function SkillDataManager:addSkill(pk,skillData)
    local skillArr = self._skillMap[pk]
    if not skillArr then
        skillArr = {}
        if pk == GameDataManager:getInstance():getMasterPK() then
            self._masterList = skillArr
        end
        self._skillMap[pk] = skillArr
    end

    table.insert(skillArr,skillData)
end

-- 删除技能数据
function SkillDataManager:deleteSkill(pk,skillID)
    local skillArr = self._skillMap[pk]
    if skillArr then
       for k,skillData in ipairs(skillArr) do
            if skillData:getId() == skillID then
                table.remove(skillArr,k)
                break
            end
       end
    end
end

function SkillDataManager:addBuff(spriteID,bufferData)
    if bufferData then
        local buffArr = self._buffRoleArr[spriteID]
        if not buffArr then
            buffArr = {}
            self._buffRoleArr[spriteID] = buffArr
        end 
        -- 排除有的情况
        local entityID = bufferData.entityID
        for k,oldData in pairs(buffArr) do
            if oldData.entityID == entityID then
                if(oldData:getID() == bufferData:getID()) then 
                    return oldData
                else 
                    -- local command = Command.ControlCommand:create(true)
                    -- command:initForTypeAndData(CommandType.CONTROL_REMOVE_BUFFER, oldData)
                    -- SceneManager:getInstance():pushCommand(command)
                    table.remove(buffArr, k)
                end
                break
            end
        end

        -- print(" SkillDataManager:addBuff 2", spriteID, bufferData.entityID, bufferData.buffID)
        table.insert(buffArr,bufferData)
        self._buffMap[bufferData.entityID] = bufferData
    end

    return bufferData
end

function SkillDataManager:deleteBuff(spriteID,entityID)
    self._buffMap[entityID] = nil
    -- print(" SkillDataManager:deleteBuff 1", spriteID, entityID)
    if(RoleDataManager:getMasterSpriteID() == spriteID) then 
        -- print(" SkillDataManager:deleteBuff 1.5", spriteID, entityID)
        self:_deleteSaveRecoverBuffData(entityID)
    end

    if(RoleDataManager:getScreenFightPetData() and next(RoleDataManager:getScreenFightPetData()) and RoleDataManager:getCaptain():getId()) then--RoleDataManager:getScreenFightPetData():getId() == spriteID) then 
        self:_deletePetRecoverBuffData(entityID)
    end

    local buffArr = self._buffRoleArr[spriteID]
    if buffArr then
        for k,bufferData in pairs(buffArr) do
            if bufferData.entityID == entityID then
                -- print(" SkillDataManager:deleteBuff 2", spriteID, entityID, bufferData.buffID)
                table.remove(buffArr, k)
                break
            end
        end
    end
end

function SkillDataManager:handleSyncAllBuffID(spriteID, entityIDArr)
    -- print("SkillDataManager:handleSyncAllBuffID", spriteID, entityIDArr)
    if(spriteID == nil or entityIDArr == nil or #entityIDArr == 0) then 
        return
    end

    local buffArr = self._buffRoleArr[spriteID]
    if buffArr then
        local removeIDArr = {}

        for k,bufferData in pairs(buffArr) do
            local found = false
            for _,entityID in pairs(entityIDArr) do 
                if bufferData.entityID == entityID then
                    found = true
                end
            end
            if(found == false) then 
                table.insert(removeIDArr, bufferData.entityID)
            end
        end

        for _,entityID in ipairs(removeIDArr) do 
            for k,bufferData in pairs(buffArr) do
                if bufferData.entityID == entityID then
                    table.remove(buffArr, k)

                    local command = Command.ControlCommand:create(true)
                    command:initForTypeAndData(CommandType.CONTROL_REMOVE_BUFFER, {targetSpriteID = spriteID, entityID = bufferData.entityID})
                    SceneManager:getInstance():pushCommand(command)
                    break 
                end
            end
        end
    end
end

-- 根据buffer 类型刷新buffer
function SkillDataManager:refreshBuffByBufferType(spriteID, bufferType)
    local buffArr = self._buffRoleArr[spriteID]
    local changeArr = {}
    if buffArr then
        for k,bufferData in pairs(buffArr) do
            if(bufferData:getType() == bufferType) then
                bufferData:resetBuffer()

                table.insert(changeArr, bufferData)

                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_UPDATE_BUFFER, {
                    bufferData = bufferData,
                    bufferEntityID = bufferData:getEntityID(),
                    bufferTargetID = bufferData:getTargetSpriteID(),
                    overlay = bufferData:getOverlayNum(),
                    leftTime = bufferData:getDuration()*1000
                })
            end
        end
    end

    return changeArr
end

-- 根据buffer 类型刷新buffer
function SkillDataManager:refreshBuffByBufferEffectType(spriteID, effectType)
    local buffArr = self._buffRoleArr[spriteID]
    local changeArr = {}
    if buffArr then
        for k,bufferData in pairs(buffArr) do
            if(bufferData.buffEffectType == effectType) then
                bufferData:resetBuffer()
                table.insert(changeArr, bufferData)

                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_UPDATE_BUFFER, {
                    bufferData = bufferData,
                    bufferEntityID = bufferData:getEntityID(),
                    bufferTargetID = bufferData:getTargetSpriteID(),
                    overlay = bufferData:getOverlayNum(),
                    leftTime = bufferData:getDuration()*1000
                })
            end
        end
    end

    return changeArr
end

function SkillDataManager:refreshBuffByEntityID(spriteID, entityID)
    local buffArr = self._buffRoleArr[spriteID]
    local changeArr = {}
    if buffArr then
        for k,bufferData in pairs(buffArr) do
            if(bufferData:getEntityID() == entityID) then
                bufferData:resetBuffer()

                table.insert(changeArr, bufferData)

                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_UPDATE_BUFFER, {
                    bufferData = bufferData,
                    bufferEntityID = bufferData:getEntityID(),
                    bufferTargetID = bufferData:getTargetSpriteID(),
                    overlay = bufferData:getOverlayNum(),
                    leftTime = bufferData:getDuration()*1000
                })
            end
        end
    end

    return changeArr
end

-- 判断主角是否用某个BUFF
function SkillDataManager:judgeMasterHaveBuff(bufferID)
    local spriteID = RoleDataManager:getMaster():getSpriteID()
    if(spriteID) then
        local buffArr = self._buffRoleArr[spriteID]
        if buffArr then
            for k,bufferData in pairs(buffArr) do
                if bufferData:getID() == bufferID then
                    return true
                end
            end
        end
    end

    return false
end

--------------------------------以下为技能树数据的接口---------------------------------------

function SkillDataManager:getAllSkillTree()
    return self._skillGroupList;
end

function SkillDataManager:getSkillGroup(skillGroupID)
    if skillGroupID == nil then
         printError("[SkillDataManager] getSkillGroup skillGroupID is nil.")
        return
    end
    if self._skillGroupList[skillGroupID] == nil then
        local mode = RoleDataManager:getReincarntionSkillMode()
        
        if ConfigManager:getSkillTreeConfigById(mode, skillGroupID) ~= nil then
            local skillTreeData = {}
            skillTreeData.skillGroupID = skillGroupID
            skillTreeData.level = 0
            SkillDataManager:handleSkillTreeData(skillTreeData)
        else
            -- printError(string.format("[SkillDataManager] getSkillTree no %d is invaild and  mode is %s.", skillGroupID, mode))
        end
    end
    return self._skillGroupList[skillGroupID];
end

function SkillDataManager:handleSkillTreeData(data, changeLv)
    local skillTreeData = Data.SkillGroupData:create()
    skillTreeData:initNet(data)
    if changeLv then
        skillTreeData:setChangeLv(changeLv)
    end
    self._skillGroupList[data.skillGroupID] = skillTreeData;
end

function SkillDataManager:refreshSkillTree(data)
    local groupData = self:getSkillGroup(data.skillGroupID)
    if groupData then
        groupData:setLevel(data.level)
    end
end

function SkillDataManager:initSkillGroupIDArr(dataArr)
    if(dataArr) then 
        for _,data in ipairs(dataArr) do 
            self:replaceSkillGroupID(data)
        end
    end
end

function SkillDataManager:clearReplaceSkill()
    self._skillGroupReplacLog = {}
end

function SkillDataManager:getOriginalGroupID( groupId )
    for key, val in pairs(self._skillGroupReplacLog) do
        if val == groupId then
            return key
        end
    end
    return groupId
end

function SkillDataManager:getChangedGroupID( groupId )
    return self._skillGroupReplacLog[groupId] or groupId
end

function SkillDataManager:getUserFightSkill(mWeaponType)
    local weaponType = mWeaponType or GameDataManager:getInstance():getWearWeaponType()
    self._configBattleSkills = self._configBattleSkills or {}
    local list = self._configBattleSkills[weaponType] or {}
    for i = 1, 5 do
        if list[i] == nil then
            list[i] = 0
        end
    end
    self._configBattleSkills[weaponType] = list
    return list
end


function SkillDataManager:setUserFightSkill(type, idx, originalGroupID)
    -- print("set fightSkills: idx = ", idx, "originalGroupID:", originalGroupID)
    self._configBattleSkills[type] =self._configBattleSkills[type] or {}
    local old = self._configBattleSkills[type][idx]
    self._configBattleSkills[type][idx] = originalGroupID
    return old
end

function SkillDataManager:removeUserFightSkill(weaponType, originalGroupID)
    if self._configBattleSkills[weaponType] then
        for k, v in pairs(self._configBattleSkills[weaponType]) do
            if v == originalGroupID then
                self._configBattleSkills[weaponType][k] = 0
                break
            end
        end
    end
end

function SkillDataManager:initBattleSkillConfigFromServer(data)
    self._configBattleSkills = {}
    for i = 1, #data.skillConfs do
        local conf = data.skillConfs[i]
        self._configBattleSkills[conf.weaponType] = {}
        for j = 1, #conf.fightSkills do
            local groupId = conf.fightSkills[j]    
            self:setUserFightSkill(conf.weaponType, j, groupId)
        end
    end
    for _, skillConfs in pairs(self._configBattleSkills) do
        for i = 1, 5 do
            local cur = skillConfs[i]
            if cur and cur ~= 0 then
                for j = i + 1, 5 do
                    if skillConfs[j] == cur then
                        skillConfs[j] = 0
                    end
                end
            end
        end
    end
end

function SkillDataManager:addBattleSkillConfigFromServer(data)
    for i = 1, #data.skillConfs do
        local conf = data.skillConfs[i]
        self._configBattleSkills[conf.weaponType] = {}
        for j = 1, #conf.fightSkills do
            local groupId = conf.fightSkills[j]    
            self:setUserFightSkill(conf.weaponType, j, groupId)
        end
    end
    for _, skillConfs in pairs(self._configBattleSkills) do
        for i = 1, 5 do
            local cur = skillConfs[i]
            if cur and cur ~= 0 then
                for j = i + 1, 5 do
                    if skillConfs[j] == cur then
                        skillConfs[j] = 0
                    end
                end
            end
        end
    end
end

function SkillDataManager:getIsFullChoiceBattleSkill(mWeaponType)
    local skillArr = self:getUserFightSkill(mWeaponType)
    if(skillArr) then 
        for k, v in pairs(skillArr) do 
            if(v == 0) then 
                return false
            end
        end
    else
        return false 
    end

    return true
end

-- 替换技能组的ID
function SkillDataManager:replaceSkillGroupID(data)
    if(data) then
        local oldSkillID = nil 
        local skillID = nil
        local old,lvOld = self:getSkillIDBySkillGropuID(data.oldSkillGroupID)
        if old ~= nil then
            local lv = lvOld
            if(old == nil) then
                local new,lvNew = self:getSkillIDBySkillGropuID(data.skillGroupID)
                lv = lvNew
                skillID = new
                oldSkillID = self:getSkillIDBySkillGropuID(data.oldSkillGroupID, lvNew)
            else 
                oldSkillID = old
                skillID = self:getSkillIDBySkillGropuID(data.skillGroupID, lv)
            end

            if(oldSkillID and skillID) then
                local skillData = self:getSkillDataForSkillID(skillID)
                if(skillData) then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SKILL_REPLACE_SKILL, oldSkillID, skillData)
                else 
                    if(DEBUG) then
                        print("SkillDataManager:replaceSkillGroupID no found skillID=", skillID)
                    end
                end
            else  
                if(DEBUG) then
                    print("SkillDataManager:replaceSkillGroupID oldSkillID , skillID", oldSkillID , skillID)
                end
            end
        end
        
        if not self._skillGroupReplacLog[data.oldSkillGroupID] then
            if self._skillGroupReplacLog[data.skillGroupID] then --取消
                self._skillGroupReplacLog[data.skillGroupID] = nil
            else--新加
                self._skillGroupReplacLog[data.oldSkillGroupID] = data.skillGroupID
            end
        else--非法：不存在A->B 然后再发A->C的情况
            self._skillGroupReplacLog[data.oldSkillGroupID] = data.skillGroupID
            print("_skillGroupReplacLog error")
        end

    end
end

-- 初始化技能数等级修改
function SkillDataManager:initSkillTreeChangeLv(changeLvSkillArr)
    if(changeLvSkillArr) then 
        for _, data in ipairs(changeLvSkillArr) do 
            self:refreshSkillTreeChangeLv(data)
        end
    end
end

function SkillDataManager:refreshSkillTrees(changeLvSkillArr)
    -- add by zp CO-5354【技能】技能加成异常, 这里修改了同步机制
    if(self._skillGroupList) then 
        for k, skillGroup in pairs(self._skillGroupList) do 
            skillGroup:setChangeLv(0)
        end
    end

    if(changeLvSkillArr) then 
        for _, data in ipairs(changeLvSkillArr) do 
            self:refreshSkillTreeChangeLv(data)
        end
    end
end

--刷新技能改变等级
function SkillDataManager:refreshSkillTreeChangeLv(changeLvSkill)
    if changeLvSkill.changeType == PublicDefine.SkillLvChangeType.SkillLvChangeType_GroupID then
        local skillTree = self:getSkillGroup(changeLvSkill.changeID)
        if skillTree ~= nil then
            skillTree:setChangeLv(skillTree:getChangeLv() + changeLvSkill.changeValue)

            Avalon.MessageCenter:notice(AvalonMessage.MC_STUDY_SKILL,changeLvSkill.changeID)
        end

    elseif changeLvSkill.changeType == PublicDefine.SkillLvChangeType.SkillLvChangeType_WeaponType then
        local mode = RoleDataManager:getReincarntionSkillMode()
        local skillTreeDatas = ConfigManager:getSkillTreeByType(mode, changeLvSkill.changeID)
        for k,v in pairs(skillTreeDatas) do
            local skillTree = self:getSkillGroup(v.skillGroupID)
            if skillTree ~= nil then
                skillTree:setChangeLv(skillTree:getChangeLv() + changeLvSkill.changeValue)
            end
        end
    end    
end

function SkillDataManager:resetSkillTree()
    --print("SkillDataManager:resetSkillTree")
    local initSkillGroupArr = self:getInitSkillArr()

    for k,v in pairs(self._skillGroupList) do
        -- 清理掉初始化数据
        if(initSkillGroupArr[v.skillGroupID] == nil) then
            v:setLevel(0)
        end
    end
    self._configBattleSkills = {}
    GoodsDataManager:clearSkillShortcutBar()
end


--获取剩余技能学习点
function SkillDataManager:getSkillStudyNum()
    local num = 0;
    local initSkillGroupArr = self:getInitSkillArr()
    for k,v in pairs(self._skillGroupList) do
        if(initSkillGroupArr[v.skillGroupID] == nil) then
            num = num + v.level;
        end
    end 
    return GameDataManager:getTotalSkillPoints() - num,num;
end

function SkillDataManager:getInitSkillArr()
    local initSkillGroupList = string.split(ConfigManager:getInitSkillGroupList(),";")
    local initSkillGroupArr = {}
    if(initSkillGroupList) then
        for _, v in ipairs(initSkillGroupList) do 
            local groupId = tonumber(v)
            if(groupId) then
                initSkillGroupArr[groupId] = groupId
            end
        end
    end

    return initSkillGroupArr
end

function SkillDataManager:hasUserFightSkill(mWeaponType, groupId)
    local weaponType = mWeaponType or GameDataManager:getInstance():getWearWeaponType()
    self._configBattleSkills = self._configBattleSkills or {}
    if self._configBattleSkills[weaponType] then
        for i = 1 ,#self._configBattleSkills[weaponType] do
            if groupId == self._configBattleSkills[weaponType][i] then
                return true
            end
        end
    end
    return false
end


function SkillDataManager:getActiveSkillByStorey(weapon,storey)
    weapon = weapon or GameDataManager:getInstance():getWearWeaponType()
    local activeDatas = self:getMasterLearnActiveSkillList(weapon)
    for k, data in ipairs(activeDatas) do
        local skillGroupID, skillGroup = SkillDataManager:getSkillGroupIDBySKillID(data:getId())
        if skillGroup.storey == storey then
            return data:getId()
        end
    end
end

--通过技能ID获取技能组ID和技能组数据
function SkillDataManager:getSkillGroupIDBySKillID(skillID)
    if(self.cacheSkillIDForSkillTree and self.cacheSkillIDForSkillTree[skillID]) then 
        local skillTreeData = self.cacheSkillIDForSkillTree[skillID]
        return skillTreeData.skillGroupID, skillTreeData
    end 

    if(self.cacheSkillIDForSkillTree == nil) then
        self.cacheSkillIDForSkillTree = {}
        local mode = RoleDataManager:getReincarntionSkillMode()
        local skillTreeDatas = ConfigManager:getAllSkillTree(mode);

        for k,v in pairs(skillTreeDatas) do
            if type(v) == "table" and v.skillGroupID then
                for i = 1,#v.skillIDList do
                    -- if v.skillIDList[i] == skillID then
                    --     self.cacheSkillIDForSkillTree[skillID] = v
                    --     return v.skillGroupID,v
                    -- end
                    self.cacheSkillIDForSkillTree[v.skillIDList[i]] = v
                end 
            end
        end
    end
    
    if(self.cacheSkillIDForSkillTree and self.cacheSkillIDForSkillTree[skillID]) then 
        local skillTreeData = self.cacheSkillIDForSkillTree[skillID]
        return skillTreeData.skillGroupID, skillTreeData
    end

    return nil
end

-- 根据技能ID 获取技能所处的技能树的 skillSort 数值
function SkillDataManager:getSkillSortBySKillID(skillID)
    local mode = RoleDataManager:getReincarntionSkillMode()
    local skillTreeDatas = ConfigManager:getAllSkillTree(mode);

    for k,v in pairs(skillTreeDatas) do
        if type(v) == "table" and v.skillGroupID then
            for i = 1,#v.skillIDList do
                if v.skillIDList[i] == skillID then
                    return v.skillSort,v
                end
            end 
        end
    end
    
    return nil
end


--通过技能组ID获取当前学习的技能ID,等级,对应的技能组技能列表和技能组数据
function SkillDataManager:getSkillIDBySkillGropuID(skillGroupID,lv)
    local skillGroupData = self:getSkillGroup(skillGroupID)
    if skillGroupData == nil then
        return 0,0,{},nil
    end
    local lv = lv or skillGroupData.level
    local skillID = nil
    if lv == 0 then
        skillID = nil
    else
        skillID = skillGroupData.skillIDList[lv]
    end
    local skillList = skillGroupData.skillIDList
    return skillID, lv, skillList, skillGroupData
end

--通过武器类型获取当前正在使用的技能
function SkillDataManager:getUseSKillListByEquipType(equipType)

    local useSkillList = {}
    for k,v in pairs(self._skillGroupList) do
        if v:getLevel() ~= 0 then
            if v:getSkillType() == equipType or v:getSkillType() == 0 then
                table.insert(useSkillList, v:getSkillId())
            end
        end
    end
    return useSkillList
end

--通过武器类型获取当前已经学习的主动技能组ID
function SkillDataManager:getUseGroupListByEquipType(equipType, advanceType)
    local useSkillList = {}
    for k,v in pairs(self._skillGroupList) do
        if v:getLevel() ~= 0 then
            if v:getSkillType() == equipType and advanceType == v.skillAdvancement and v.skillData:isActive() then
                table.insert(useSkillList, v)
            end
        end
    end
    return useSkillList
end

--通过技能ID获取技能类型
function SkillDataManager:getSkillTypeBySkillID(skillID)
    local skillGroupID = self:getSkillGroupIDBySKillID(skillID)
    if skillGroupID then
        return tonumber(string.sub(tostring(skillGroupID),3,3))
    end
    return nil
end

--切换技能
function SkillDataManager:switchSkillGroup(skillGID, removeSkillGID)
    local oldGoupData = self._skillGroupList[removeSkillGID]
    local mode = RoleDataManager:getReincarntionSkillMode()
    if ConfigManager:getSkillTreeConfigById(mode, skillGID) ~= nil then
        local skillTreeData = {}
        skillTreeData.skillGroupID = skillGID
        skillTreeData.level = oldGoupData.level
        SkillDataManager:handleSkillTreeData(skillTreeData, oldGoupData.changeLv)
    else
        printError(string.format("[SkillDataManager] getSkillTree no %d is invaild.", skillGID))
    end
    self._skillGroupList[removeSkillGID] = nil
end

--刷新处理技能切换关系
function SkillDataManager:checkReleateSkill(list, advanceType)
    if advanceType  == Game.SkillAdvanceType.AdvanceTypeOne then
        return list
    end

    local temp = {}
    for k, v in ipairs(list) do
        local isDirty = false
        if v.relatedSkills ~= nil and v.relatedSkills ~= 0 then
            local relatedGroup = self:getSkillGroup(v.relatedSkills)
            if relatedGroup and relatedGroup.level > 0 then
                self._skillGroupList[v.skillGroupID] = nil
                isDirty = true                
            end
        end
        if not isDirty then
            temp[v.skillGroupID] = v
        end
    end

    local list = {}
    for k, v in pairs(temp) do
        if temp[v.relatedSkills] ~= nil then
            temp[v.relatedSkills] = nil
        end
    end

    for k, v in pairs(temp) do
        table.insert(list, v)
    end
    return list
end


function SkillDataManager:initShadowSkill(list)
    self._shadowSkill = {}
    local max = tonumber(ConfigManager:getGeneralForKey("removeSkillLockingTouchTimes"))
    for k, v in ipairs(list) do
        self._shadowSkill[v] = max
    end
end

function SkillDataManager:addShadowSkill(skillId)
    local max = tonumber(ConfigManager:getGeneralForKey("removeSkillLockingTouchTimes"))
    self._shadowSkill[skillId] = max
end

function SkillDataManager:refreshShadowSkill(skillId, addNumber)
    if self._shadowSkill[skillId] == nil then
        return
    end
    self._shadowSkill[skillId] = self._shadowSkill[skillId] + addNumber
    if self._shadowSkill[skillId] <= 0 then
        self:clearShadowSkill(skillId)
        return true
    end
    return false
end

function SkillDataManager:clearShadowSkill(skillId)
    self._shadowSkill[skillId] = nil
end

function SkillDataManager:clearAllShadowSkill()
    self._shadowSkill = {}
end

function SkillDataManager:isShadowSkill(skillId)
    if self._shadowSkill[skillId] ~= nil then
        return true, self._shadowSkill[skillId]
    end
    return false, 0
end



function SkillDataManager:initNtfMarkSkill(list)
    self._ntfMarkSkill = {}
    for k, v in ipairs(list) do
        self._ntfMarkSkill[v] = 1
    end
end

function SkillDataManager:addNtfMarkSkill(skillId)
    self._ntfMarkSkill[skillId] = 1
end

function SkillDataManager:clearNtfMarkSkill(skillId)
    if not self._ntfMarkSkill[skillId] then
        return
    end

    self._ntfMarkSkill[skillId] = nil
end

function SkillDataManager:clearAllNtfMarkSkill()
    self._ntfMarkSkill = {}
end

function SkillDataManager:isNtfMarkSkill(skillId)
    if self._ntfMarkSkill[skillId] ~= nil then
        return true
    end
    return false
end

-- CO-18933 技能配置进战CD，冷却不显示
function SkillDataManager:setEnterFightSkillCoolDownList(skillId, residualTime)
    self.enterFightSkillCoolDownList[skillId] = residualTime
end

function SkillDataManager:getEnterFightSkillCoolDownList()
    return self.enterFightSkillCoolDownList
end

function SkillDataManager:setPetEnterFightSkillCoolDownList(skillId, residualTime)
    self.petEnterFightSkillCoolDownList[skillId] = residualTime
end

function SkillDataManager:getPetEnterFightSkillCoolDownList()
    return self.petEnterFightSkillCoolDownList
end

function SkillDataManager:setboughtSkillLabelListList(boughtLabels)
    for k, v in pairs(boughtLabels) do
        self.boughtSkillLabelList[v+1] = true
    end
end

function SkillDataManager:getBoughtSkillLabelListList()
    return self.boughtSkillLabelList
end
-------------------------------
--默认初始化
SkillDataManager:init()









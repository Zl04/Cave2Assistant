
--[[
    技能组：名字、icon相同 但是等级、数值不同的技能集合。（现有技能升级是替换技能ID）
]]

require "app.datas.GameData"

local SkillGroupData = class("SkillGroupData",GameData.Base)

Data = Data or {}
Data.SkillGroupData = SkillGroupData

-- 构造函数(会自动调用)  
function SkillGroupData:ctor()
    self.super.ctor(self,Category.SKILL)
    self.changeLv = 0           --变化数量受装备等影响
    self.level = 0              --真实学习的技能
    self._state = Game.SkillIconState.StateLock
end

function SkillGroupData:getId()

    return self.skillGroupID
end

function SkillGroupData:initLocal(data)
    if self.skillGroupID ~= data.skillGroupID then
        self:setLocalConfigData(data)
    end

end

function SkillGroupData:initNet(mesData)
    -- 根据网络数据初始化
    self.skillGroupID = mesData.skillGroupID or -1
    self.level = mesData.level or 0;
    self:refreshConfig()
end

function SkillGroupData:refreshConfig()
    local mode = RoleDataManager:getReincarntionSkillMode()

    local configData = ConfigManager:getSkillTreeConfigById(mode, self.skillGroupID)
    if(configData == nil) then 
        configData = ConfigManager:getSkillTreeConfigById(SkillTreeModel.SKILL_TREE_MODEL_ADVANCED, self.skillGroupID)
    end
    self:setLocalConfigData(configData)
    local lv = self.level + self.changeLv
    if lv > #self.skillIDList then
        lv = #self.skillIDList
    elseif lv == 0 then
        lv = 1
    end
    local skillID = self.skillIDList[lv]
    self.skillData = SkillDataManager:createSkillForSkillId(skillID)    
    self._skillType = tonumber(string.sub(tostring(self.skillGroupID),3,3))
end

function SkillGroupData:getLevel()
	return self.level
end

function SkillGroupData:setLevel(level)
    if self.level ~= level then
        self.level = level
        self:refreshConfig()
    end
end

function SkillGroupData:getChangeLv()
    return self.changeLv
end

function SkillGroupData:setChangeLv(changeLv)
    if self.changeLv ~= changeLv then
        self.changeLv = changeLv
        self:refreshConfig()
    end
end

function SkillGroupData:getSkillId()
    if self.skillData then
        return self.skillData:getId()
    end
end

function SkillGroupData:getSkillType()
    return self._skillType
end


function SkillGroupData:refreshSkillState()
    if self.level > 0  then
        self._state = Game.SkillIconState.StateLearned
    elseif self:isLock() then
        self._state = Game.SkillIconState.StateLock
    else
        self._state = Game.SkillIconState.StateCanLearn
    end
end

function SkillGroupData:getState()
    return self._state
end

--检测技能状态
--解锁判断条件 一阶技能：人物等级、前置技能、至少消耗多少点技能点、同一组是否已有学习的技能
--           二阶技能：人物等级、前置技能、至少消耗多少点技能点
function SkillGroupData:isLock(isShowTips)
    --判断解锁等级
    if self:getUnlockLevel() > RoleDataManager:getMaster():getLevel() then
        if isShowTips then
            UI.ScrollBar:createByText(string.format(UI.TEXT_1150003, self:getUnlockLevel()))
        end
        return true
    end
    --判断相同层是否学习了技能
    if (self.storey ~= 0) then
        local mode = RoleDataManager:getReincarntionSkillMode()
        local skillTreeDatas = ConfigManager:getSkillTreeByType(mode,  self:getSkillType(), self.storey)
        for k1, v1 in pairs(skillTreeDatas) do
            if v1.hidden == 0 and v1.skillGroupID ~= self.skillGroupID then
                local _userSkillTreeData = SkillDataManager:getSkillGroup(v1.skillGroupID)
                -- CO-18975【技能】三阶技能无法升级
                if _userSkillTreeData:getLevel() > 0 and self.skillAdvancement < Game.SkillAdvanceType.AdvanceTypeThree then
                    if isShowTips then
                        UI.ScrollBar:createByTextID(1170170)
                    end
                    return true
                end
            end
        end
    end

    -- 判断是否学习了前排技能
    if not self:judgeLearnPreStoreySkill() then
        if isShowTips then
            UI.ScrollBar:createByTextID(1110948)
        end
        return true
    end

    --判断前一层是否学习了技能
    if not self:judgeLearnPreSkill() then
        if isShowTips then
            UI.ScrollBar:createByTextID(1110867)
        end
        return true
    end

    --判断本系累计消耗点是够
    if self:getNeedLearnPoint() > SkillDataManager:getLearnPointByWeapType(self._skillType) then
        if isShowTips then
            UI.ScrollBar:createByTextID(1170260)
        end
        return true
    end
    return false
end


function SkillGroupData:getUnlockLevel()
    if #self.unlockLevel == 0 then
        return 0
    end
    return self.unlockLevel[self.level + 1] or 0
end

--判断前一层是否学习了前置技能
function SkillGroupData:judgeLearnPreSkill()
    local isAllLearn = false
    local isOrSkillListLearn = false
    local isHadOrSkill = false
    local isHadAndSkill = false
    local preSkillGroupList = self:getPreSkillGroupID()
    if (#preSkillGroupList > 0) then
        for i = 1, #preSkillGroupList do
            local data = preSkillGroupList[i]
            if data.isAnd then
                isHadOrSkill = true
            else
                isHadAndSkill = true
            end
            if SkillDataManager:getSkillGroup(data.gId).level >= data.level and data.isAnd then
                -- return false, preSkillGroupList
                isOrSkillListLearn = true
            end

            if SkillDataManager:getSkillGroup(data.gId).level >= data.level and not data.isAnd then
                isAllLearn = true
            end
            
        end

        if not isHadOrSkill or (isOrSkillListLearn and isHadAndSkill) then
            isAllLearn = isAllLearn
        elseif (isOrSkillListLearn and not isHadAndSkill) then
            isAllLearn = true
        else
            isAllLearn = false
        end

        return isAllLearn, preSkillGroupList
    else
        return true
    end
end

--获取前置技能{{gId = 0, level = 1}, {}, ...}
function SkillGroupData:getPreSkillGroupID()
    if self.preSkillGroupID == nil then
        return {}
    end
    local list = {}
    local strList = string.split(self.preSkillGroupID, ";")
    local params = strList[self.level == 0 and 1 or self.level]
    if params == nil then
        return list
    end
    local strList2 = string.split(params, ",")
    for k = 1, #strList2, 2 do
        if strList2[k] and strList2[k + 1] then
            local data = {}
            data.gId = checkint(strList2[k])
            data.level = checkint(strList2[k + 1])
            table.insert(list, data)
        end
    end

    --CO-20258 转生技能-前置要求：新增条件或
    if self.preSkillGroupID2 and self.preSkillGroupID2 ~= "" then
        local strList = string.split(self.preSkillGroupID2, ";")
        local params = strList[self.level == 0 and 1 or self.level]
        if params == nil then
            return list
        end
        
        local strList2 = string.split(params, ",")
        for k = 1, #strList2, 2 do
            if strList2[k] and strList2[k + 1] then
                local data = {}
                data.gId = checkint(strList2[k])
                data.level = checkint(strList2[k + 1])
                data.isAnd = true
                table.insert(list, data)
            end
        end
    end
    
    
  
    return list
end

--仅用于连线参考
function SkillGroupData:getLineReferPreSkillGroupID()
    if self.preSkillGroupID == nil then
        return {}
    end
    local list = {}
    local strList = string.split(self.preSkillGroupID, ";")
    local params = strList[self.level == 0 and 1 or self.level]
    if params == nil then
        return list
    end
    local strList2 = string.split(params, ",")
    for k = 1, #strList2, 2 do
        if strList2[k] and strList2[k + 1] then
            local data = {}
            data.gId = checkint(strList2[k])
            data.level = checkint(strList2[k + 1])
            table.insert(list, data)
        end
    end
  
    return list
end

-- 判断是否学习了前排技能
function SkillGroupData:judgeLearnPreStoreySkill()
    if self.storey <= 1 then
        return true
    end
    local mode = RoleDataManager:getReincarntionSkillMode()
    local skillTreeDatas = ConfigManager:getSkillTreeByType(mode, self:getSkillType(), self.storey - 1)
    for k1, v1 in pairs(skillTreeDatas) do
        if v1.hidden == 0 then
            local _userSkillTreeData = SkillDataManager:getSkillGroup(v1.skillGroupID)
            if _userSkillTreeData:getLevel() > 0 then
                return true
            end
        end
    end
    return false
end

--需要在本系消耗多少点技能点 才能解锁
function SkillGroupData:getNeedLearnPoint()
    if self.occupationalPoints == nil or #self.occupationalPoints == 0 then
        return 0
    end
    return self.occupationalPoints[self.level + 1] or 0
end

function SkillGroupData:isHasVideo()
    return self.hasVideo == 1
end

function SkillGroupData:getCanBeLearnedLevel()
    if self.canBeLearnedLevel == nil or (type(self.canBeLearnedLevel) == "table" and #self.canBeLearnedLevel == 0) then
        return 0
    end
    if type(self.canBeLearnedLevel) == "table" then
        return self.canBeLearnedLevel[1]
    else
        return self.canBeLearnedLevel
    end
end

--获取互斥技能列表
function SkillGroupData:getLimitSkills()
    self.activeSkillLimit = self.activeSkillLimit == nil and {} or self.activeSkillLimit
    self.passiveSkillLimit = self.passiveSkillLimit == nil and {} or self.passiveSkillLimit
    if #self.activeSkillLimit == 0 and #self.passiveSkillLimit == 0 then
        return {}
    end
    local list = {}
    for k, v in ipairs(self.activeSkillLimit) do
        local data = SkillDataManager:createTempSkillGroupData(v, 0)
        table.insert(list, data)
    end
    for k, v in ipairs(self.passiveSkillLimit) do
        local data = SkillDataManager:createTempSkillGroupData(v, 0)
        table.insert(list, data)
    end
    return list
end
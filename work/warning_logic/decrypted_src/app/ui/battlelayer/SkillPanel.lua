--[[
  技能界面
]]--

require "app.ui.battlelayer.SkillButton"
local ProtobufUtil = require "utils.ProtobufUtil"

UI = UI or {}
local SkillPanel = class("SkillPanel",UI.HWBtnComponent)
UI.SkillPanel = SkillPanel
local SkillRelatedFlag = PublicDefine.SkillRelatedFlag
local SkillUseCondition = PublicDefine.SkillUseCondition
local Scheduler = Avalon.Scheduler
local FunctionFlag = PublicDefine.FunctionFlag
-- 测试开关
local DEBUG = false

local WIDTH  = 230
local HEIGHT = 350
-- 公共CD时间
local TIME_SPACED = 1
-- 资源列表
local SKILL_PANEL_RES_LIST = {
    "ui_common_icon_effect.plist",
    "ui_town_guild_giftbox.plist",
}
--技能不可用原因
UI.EnabelSkillStateType = {
    looks = 1      --变身

}

-- 点击到技能按钮
local function onActiveUseSkillHandler(self, data , state)

    -- 某一技能被点击
    if state ==  UI.SKILL_STATE.BUTTON_END_CLICK then
        -- 触发公共CD
        if self._currentSkill and self._currentSkill:getTag() ~= data:getId() then
            self._currentSkill:cancelSkill()
        end

        if data.cooddownOnly == 0 then
            self:runPublicCoolDown(data)
        end
        self._currentSkill = nil 

    -- 技能已经释放，该技能进入CD状态
    elseif state ==  UI.SKILL_STATE.BUTTON_COOLDOWN then
        
        -- 如果当前选择性技能在选择，本次释放的不是指向性技能
        -- 触发公共CD
        if self._currentSkill and self._currentSkill:getTag() ~= data:getId() then
            self._currentSkill:cancelSkill()
        end
        
        if data.cooddownOnly == 0 then
            self:runPublicCoolDown(data)
        end
        -- if self._currentSkill then
        --     self._currentSkill:runCoolDown()
        -- end
        
    -- 技能进入选择目标阶段
    elseif state ==  UI.SKILL_STATE.BUTTON_CHOICE then 
        -- 设置为不用
        -- self._func(self._target,self)
        for k,button in pairs(self._skillmenu) do
            if button and button:getTag() == data:getId() then
                if button ~= self._currentSkill then 
                    self._lastSkill = self._currentSkill
                    self._currentSkill = button 
                end
            end
        end

        -- 如果上次的技能没有释放完成
        if self._lastSkill then 
            self._lastSkill:cancelSkill()
            self._lastSkill = nil 
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SHOW_SKILL_TARGE,data.targetType)
    elseif state ==  UI.SKILL_STATE.BUTTON_SING then 
        -- 吟唱主动技能不可以释放
        self:setSkillUnable(data)
    end
end

function SkillPanel:ctor()
    self._data = nil
    self.skillGroupIDForSkillItem = {}
    self._horcurxChange = nil
    -- 用户记录技能自动失败冷却时间(ms)
    self._waitingAutoSkillCD = 10
    -- {skillID = {time = systemTime, CDType=, CDTime}}
    self.skillCooldDownArr = {}

    SkillPanel.super.ctor(self,UIType.SKILL_PANEL, SKILL_PANEL_RES_LIST, WIDTH, HEIGHT, true)
    Avalon.Scheduler:scheduleUpdate(self, self.update)
    self:handleConfig()
end

function SkillPanel:dtor()
    self._data = nil
    self.skillGroupIDForSkillItem = {}
    self.skillCooldDownArr = {}

    SkillPanel.super.dtor(self)
    self:unRegisterListener();
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

function SkillPanel:init(data)
    -- print ("====SkillPanel:init====")

    self._data = data
    self._skillmenu  = {}
    self._currentSkill = nil  -- 记录本次点击技能(指向性）
    self._lastSkill    = nil  -- 记录上次点击技能(指向性）

    SkillPanel.super.init(self,data)
    
    self:registerListener();
end

-- function SkillPanel:registerSkillHandler(target, func, self)
--     -- body
--     self._target = target
--     self._func   = func
-- end

function SkillPanel:onInitView()
    self.skillGroupIDForSkillItem = {}
    local heroData = RoleDataManager:getMaster()
    local data
    local fightSkills
    if not heroData:isHorcruxTransform() then
        data = self._data
        fightSkills = SkillDataManager:getUserFightSkill()
         local posList = {{120, 230}, {10, 170}, {120, 120}, {10, 60}, {120, 10}} 
        for k = 1, 5 do
            local skillData
            local handleGroupID = nil
            if fightSkills ~= nil then
                local groupId = fightSkills[k]
                if groupId and groupId > 0 then
                    handleGroupID = groupId
                    local skillGroupData = SkillDataManager:getSkillGroup(groupId)
                    local repGroupId = SkillDataManager:getChangedGroupID(skillGroupData.skillGroupID)
                    if repGroupId then
                        local reqSkillGroup = SkillDataManager:createTempSkillGroupData(repGroupId, skillGroupData:getLevel() + skillGroupData:getChangeLv())
                        skillData = reqSkillGroup.skillData
                    else
                        skillData = skillGroupData.skillData
                    end
                end
            else
                skillData = data[k]
            end
          
            if skillData then
                skillData:setIsOpening(false) --进入战斗中，强制设置为false
                local button = UI.SkillButton:create(RoleDataManager:getMaster())
                button:init(skillData,handleGroupID)
                button:setSize(100, 100)

                -- 给按钮设置一个唯一的ID
                local posTemp = posList[k] or {0, 0}
                button:setTag(skillData:getId())
                button:leftBottom(posTemp[1], posTemp[2])
                self:addChild(button)

                button:addEventListener(UIEvent.USE_SKLL_CLICK, self,onActiveUseSkillHandler)
                table.insert(self._skillmenu,button)
                if(handleGroupID) then
                    self.skillGroupIDForSkillItem[handleGroupID] = button
                end

                -- -- 恢复冷却时间
                -- local skillID = skillData:getSkillID()
                -- if(self.skillCooldDownArr[skillID]) then 
                --     local data = self.skillCooldDownArr[skillID]
                --     local waitingTime = AvalonUtil.getCurrentTime() - data.time
                --     if(waitingTime < data.CDTime) then 
                --         button:restoreCoolDown(data.CDType, data.CDTime - waitingTime)
                --     end
                -- end

                -- CO-18933 技能配置进战CD，冷却不显示
                local enterFightSkillCoolDownList = SkillDataManager:getEnterFightSkillCoolDownList()
                if enterFightSkillCoolDownList[skillData:getId()] and enterFightSkillCoolDownList[skillData:getId()] ~= 0 then
                    self:skillIsUseable(skillData:getId(), enterFightSkillCoolDownList[skillData:getId()])
                    SkillDataManager:setEnterFightSkillCoolDownList(skillData:getId(), nil)
                end
                ---------------------
            else
                -- print("[SkillPanel] not found slot", k)
            end
        end
    else
        local skillIds = HorcurxDataManager:getCurTransformSkillIds()
        local skillDatas = {} 
        for i = 1, #skillIds do
            local skillID = tonumber(skillIds[i])
            local skillData = SkillDataManager:getSkillDataForSkillID(skillID, false) 
            table.insert(skillDatas, skillData)
        end
        data = skillDatas

        for k = 1, 5 do
            local skillData
            if fightSkills ~= nil then
                local groupId = fightSkills[k]
                if groupId and groupId > 0 then
                    local skillGroupData = SkillDataManager:getSkillGroup(groupId)
                    local repGroupId = SkillDataManager:getChangedGroupID(skillGroupData.skillGroupID)
                    if repGroupId then
                        local reqSkillGroup = SkillDataManager:createTempSkillGroupData(repGroupId, skillGroupData:getLevel() + skillGroupData:getChangeLv())
                        skillData = reqSkillGroup.skillData
                    else
                        skillData = skillGroupData.skillData
                    end
                end
            else
                skillData = data[k]
            end

            if skillData then
                local pointX = 0
                local pointY = 0
                if k == 1 or  k == 2 then 
                    pointX = 120
                    pointY = 10 + 110 * (k-1)  
                elseif k == 3 then
                    pointX = 10
                    pointY = 60
                elseif k == 4  then
                    pointX = 10
                    pointY = 60 + 110
                elseif k == 5 then
                    pointX = 120
                    pointY = 10 + 110 * 2
                end
                skillData:setIsOpening(false) --进入战斗中，强制设置为false
                local button = UI.SkillButton:create(RoleDataManager:getMaster())
                button:init(skillData)
                button:setSize(100, 100)

                -- 给按钮设置一个唯一的ID
                button:setTag(skillData:getId())
                button:leftBottom(pointX, pointY)
                self:addChild(button)

                -- 这里在战斗中魂器变身，给所有技能都添加一个冷却时间
                if(self._horcurxChange) then 
                    button:runPublicCoolDownForce()
                end

                button:addEventListener(UIEvent.USE_SKLL_CLICK, self,onActiveUseSkillHandler)
                table.insert(self._skillmenu,button)
            else
                -- print("[SkillPanel] not found slot", k)
            end
        end
    end
   

    self:setTouchEnable(true)
    self:setInterceptTouches(false)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self, infoArea , touchPosition)
        -- 如果有指向性技能正在释放，取消释放
        if self._currentSkill then
            -- 技能取消
            self._currentSkill:cancelSkill()
            self._currentSkill = nil 
            self:setSkillClickable()
        end
    end)
    self._horcurxChange = nil
end

function SkillPanel:onHorcurxTransChanged()
    self._eventHandlerMap = {}
    if self._currentSkill then
        -- 技能取消
        self._currentSkill:cancelSkill()
        self._currentSkill = nil 
    end
    -- add by zp 记录技能的冷却时间，这里本来应该单独保存，项目到目前这个点，也就没有专门单独保存了
    for k,button in pairs(self._skillmenu) do
        local skillID = button:getTag()
        local cdType,cdTime = button:getCDTypeOrCDTime()
        local data = {}
        data.time = AvalonUtil.getCurrentTime()
        -- 这里默认是公共CD，不然会导致后续技能无法使用的问题
        data.CDType = UI.SKILL_COOLDOWN_TYPE.COOLDOWN_PUBLIC
        data.CDTime = cdTime * TIME_UNIT

        self.skillCooldDownArr[skillID] = data
        button:removeFromParent()
    end
    self._data = SkillDataManager:getMasterLearnActiveSkillList()
    self._skillmenu  = {}
    self._horcurxChange = true
    self:onInitView()
    
    --变身后，需要同步强制刷新技能按钮状态
    self:onSkillRelatedFlagChange(RoleDataManager:getMasterSpriteID(),RoleDataManager:getMaster().skillRelatedFlag)
end

function SkillPanel:update(dt)
    for k,button in pairs(self._skillmenu) do
        button:update(dt)
    end

    if(GameManager:getAutoBattleStatus() and GameManager:getIsShowAutoBattle()) then
        self:handleAutoBattle(dt)
    end
end
-- 释放技能触发公共CD
function SkillPanel:runPublicCoolDown(data,time)
    for k,button in pairs(self._skillmenu) do
        if button and button:getTag() ~= data:getId() then
            -- 进入公共CD
            button:runPublicCoolDown(time)
        end
    end
end

-- 设置其他技能不可用,状态改变时才能使用，时间不确定
function SkillPanel:setSkillUnable(data)
    for k,button in pairs(self._skillmenu) do
        -- if button and button:getTag() ~= data:getId() then
        --     -- 按钮不可用
        --     button:setSkillUnable()
        -- end
        if button then
            -- 按钮不可用
            button:setSkillUnable()
        end
    end
end
-- 技能释放结果
function SkillPanel:onUseSkillResult(skillID,result)
    -- print(".....fail===>", skillID, result)
    -- 如果服务器告诉客户端没有释放技能成功,强行清理所有CD
    if result ~= "HeroUseSkillResult_Succeed" then
        -- 强行中断技能CD
        -- self:clearAllCd()
        for k,button in pairs(self._skillmenu) do
            -- print(button:getTag(), skillID)
            if button and button:getTag() == skillID  then
                button:clearCD()
                self._waitingAutoSkillCD = 100
            end
        end
    else

    end
end

-- 指向性技能被打断
function SkillPanel:setSkillClickable()
    for k,button in pairs(self._skillmenu) do
        if button then
            -- 设置按钮可用
            button:setSkillClickable()
        end
    end
end

-- 技能页面更新
function SkillPanel:onUpdateView(data)
    -- body
end

-- 目标选择好的回调 
function SkillPanel:skillTarget(data)
    if data and self._currentSkill then 
        local targetId = data 
        self._currentSkill:choseTarget(targetId)

    end
end

-- 吟唱结束
function SkillPanel:skillEndSing(skillData, isMaster)
    if skillData and isMaster then 
        local skillID = skillData:getId()
        local hasGuide = skillData:hasGuide()

        for k,button in pairs(self._skillmenu) do
            if button and button:getTag() == skillID  then
                -- button:runCoolDown()
                -- button:runPublicCoolDown()
                -- 这里修改使用技能后，等待服务器通知开始冷却的消息
                button:runWaitingCoolDown()
            end
        end
    end
end

function SkillPanel:skillStartCooldown(skillID,isOpen)
    if skillID then 
        for k,button in pairs(self._skillmenu) do
            if button and button:getTag() == skillID  then
                button:runCoolDown()

                local skillData = SkillDataManager:getSkillDataForSkillID(skillID, false)
                if skillData and skillData.hasOpenState == 1 then
                    skillData:setIsOpening(isOpen)
                    button:refreshIsOpen(isOpen)
                end
            end
        end
    end  
end

-- 技能可以使用（若无吟唱过程的技能不发送此消息，技能button中添加本地CD好的动画）

-- todo add by yys 如果我A技能还剩0.5sCD 我使用了技能B,这个时候A应该继续执行1s公共CD
-- 而服务器并未跟客户端同步任何公共CD。所以,服务器会在A技能剩下这0.5sCD执行完毕之后告知客户端A技能已经可以使用了
-- 所以,客户端不能直接清理掉所有CD和执行冷却逻辑,这种情况下完全由客户端接管CD流程
function SkillPanel:skillIsUseable(skillID, residualTime)
    if skillID then 
        for k,button in pairs(self._skillmenu) do
            if button and button:getTag() == skillID  then
                -- 三阶技能需求 在CD中需要能刷新技能
                -- if not button:isInPublicCooldown() then
                --     -- button:showCoolDown()
                --     -- button:clearCD();   
                --     button:skillCoolDown(residualTime)
                -- end
                button:skillCoolDown(residualTime)
            end
        end
    end  
end
-- 清理所有CD(释放技能报错用)
function SkillPanel:clearAllCd()
    for k,button in pairs(self._skillmenu) do
        button:clearCD()
       
    end
end
--所有技能可以使用(清除CD)
function SkillPanel:skillAllUseable()
    for k,button in pairs(self._skillmenu) do
        button:runPublicCoolDownForce()
    end
end

-- 技能施法资源是否足够
function SkillPanel:updateSkillState(roleData)
    if roleData then 
        for k,button in pairs(self._skillmenu) do
            if button then
                button:skillIsEnable(roleData)
            end
        end
    end
end

function SkillPanel:enable()
    for k,button in pairs(self._skillmenu) do
        if button then
            button:enable()
        end
    end
end

function SkillPanel:disable()
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:disable()
        end
    end
end


-- 技能施法资源是否足够
function SkillPanel:onUpdateHeroDataHandler(roleData)
    local spriteID = roleData:getSpriteID()
    if RoleDataManager:getMasterSpriteID() == spriteID then
        if self ~= nil and (not tolua.isnull(self)) then 
            self:skillResIsEnable(roleData)
            self:skillHpPercentIsEnable(roleData)
        end
    end
end

--技能触发条件改变列表
function SkillPanel:skillResIsEnable(roleData)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:skillResIsEnable(roleData)
        end
    end
end

-- 技能血量的条件
function SkillPanel:skillHpPercentIsEnable(roleData)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:skillHpPercentIsEnable(roleData)
        end
    end
end

--技能触发条件改变列表
function SkillPanel:skillTriggerChange(triggerData)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:skillTriggeringIsEnable(triggerData)
        end
    end
end

--变形状态改变
function SkillPanel:onLooksChangeHandler(spriteID,looks)
    -- local spriteID = roleData:getSpriteID()

    local heroData = RoleDataManager:getMaster()
    if heroData:isHorcruxTransform() then
        return
    end

    if RoleDataManager:getMasterSpriteID() == spriteID then
        for k,button in pairs(self._skillmenu) do
            if button and (not tolua.isnull(button)) then
                local isEnable = false
                local monsterIdRange = ConfigManager:getGeneralForKey("monsterIdRange")
                local arr = string.split(monsterIdRange, ",")
                if looks == 0 or (looks >= tonumber(arr[1]) and looks <= tonumber(arr[2])) then
                    isEnable = true
                end
                button:skillStateIsEnable(UI.EnabelSkillStateType.looks,isEnable)
            end
        end
    end
end

--技能花费改变
function SkillPanel:onSkillSpendChangeHandler(var)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:onSkillSpendChangeHandler(var)
        end
    end
end

--技能免吟唱状态改变
function SkillPanel:onNoSpellTimeHandler(var)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:onNoSpellTimeHandler(var)
        end
    end
end

--技能相关标志改变
function SkillPanel:onSkillRelatedFlagChange(spriteID,skillRelatedFlag)

    if RoleDataManager:getMasterSpriteID() == spriteID then
        if self ~= nil and (not tolua.isnull(self)) then 
            local skillRelatedFlagArr = ToolsUtil:splitPositionForValue(skillRelatedFlag)
            
            --免消耗
            if(skillRelatedFlagArr[SkillRelatedFlag.NoCost]) then
                self:onSkillSpendChangeHandler(true)
            else 
                self:onSkillSpendChangeHandler(false)
            end

            --瞬发
            if(skillRelatedFlagArr[SkillRelatedFlag.NoSpellTime]) then
                
                self:onNoSpellTimeHandler(true)
            else 
                self:onNoSpellTimeHandler(false)
            end

            --触发方式
            local triggerData = {}
            for k,v in pairs(skillRelatedFlagArr) do
                local type = nil
                if(v == SkillRelatedFlag.Blocked) then
                    type = SkillUseCondition.HasBlocked
                elseif (v == SkillRelatedFlag.Dodged) then
                    type = SkillUseCondition.HasDodged
                elseif (v == SkillRelatedFlag.SkillCrited) then
                    type = SkillUseCondition.HasSkillCrited
                elseif (v == SkillRelatedFlag.GeneralAtkCrited) then
                    type = SkillUseCondition.HasGeneralAtkCrited
                end
                if type ~= nil then
                    triggerData[type] = type
                end
            end

            local master = RoleDataManager:getMaster()
            local anger = master.anger or 0
            if anger >= PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE and triggerData[SkillUseCondition.AngerFull] == nil then
                triggerData[SkillUseCondition.AngerFull] = SkillUseCondition.AngerFull
            elseif anger < PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE then
                triggerData[SkillUseCondition.AngerFull] = nil
            end
            
            self:skillTriggerChange(triggerData)
        end
    end
end
-- 战斗中的功能标记改变
function SkillPanel:onFunctionFlagChange(flag,value)
    -- print("状态改变   ",flag,value)
    -- 沉默
    if flag == FunctionFlag.FunctionFlag_Silence 
    -- -- 封印
    -- or flag == FunctionFlag.FunctionFlag_Seal
    -- 冰冻
    or flag == FunctionFlag.FunctionFlag_Frozen
    -- 眩晕
    or flag == FunctionFlag.FunctionFlag_Stun
    or flag == FunctionFlag.FunctionFlag_Constraint
    then
        for k,button in pairs(self._skillmenu) do
            if button and (not tolua.isnull(button)) then
                button:forbidden(value)
            end
        end
    end
end

-- 替换技能
function SkillPanel:onReplaceSkill(oldSkillID, skillData)
    for k,button in pairs(self._skillmenu) do
        if(button:getSkillID() == oldSkillID) then
            button:replaceSkill(skillData)
            break
        end
    end
end

-- 打断技能
function SkillPanel:onBreakSkill(skillID, skillState, isMaster)
    for k,button in pairs(self._skillmenu) do
        if(button:getSkillID() == skillID) then
            button:resetSkillState()
            -- button:cancelSkill()
            -- add by zp 添加一个公共CD
            if(skillState == Game.UseSkillState.RELEASE or skillState == Game.UseSkillState.COOLDOWN) then
                -- button:runCoolDown()
                -- button:runPublicCoolDown()
            else 
                button:runPublicCoolDown()
            end
            break
        end
    end
end

function SkillPanel:onRefresIsopen(skillID)
    for k,button in pairs(self._skillmenu) do
        if(button:getSkillID() == skillID) then
            button:refreshIsOpen()
            break
        end
    end
end

function SkillPanel:updateMasterAnger()
    local master = RoleDataManager:getMaster()
    if self ~= nil and (not tolua.isnull(self)) and master then 
        local anger = master.anger
        local skillRelatedFlagArr = ToolsUtil:splitPositionForValue(master.skillRelatedFlag)
        --触发方式
        local triggerData = {}
        for k,v in pairs(skillRelatedFlagArr) do
            local type = nil
            if(v == SkillRelatedFlag.Blocked) then
                type = SkillUseCondition.HasBlocked
            elseif (v == SkillRelatedFlag.Dodged) then
                type = SkillUseCondition.HasDodged
            elseif (v == SkillRelatedFlag.SkillCrited) then
                type = SkillUseCondition.HasSkillCrited
            elseif (v == SkillRelatedFlag.GeneralAtkCrited) then
                type = SkillUseCondition.HasGeneralAtkCrited
            end
            if type ~= nil then
                triggerData[type] = type
            end
        end
        local isChange = false
        if anger >= PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE and triggerData[SkillUseCondition.AngerFull] == nil then
            triggerData[SkillUseCondition.AngerFull] = SkillUseCondition.AngerFull
            isChange = true
        elseif anger < PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE then
            triggerData[SkillUseCondition.AngerFull] = nil
            isChange = true
        end
        if isChange then
            self:skillTriggerChange(triggerData)
        end
    end
end

function SkillPanel:refreshShadowLock(skillId)
    -- print("---refreshShadowLock---", skillId)
    for k, button in pairs(self._skillmenu) do
        if(button:getSkillID() == skillId) then
            local isLock, remianCount = SkillDataManager:isShadowSkill(skillId)
            if isLock then
                button:shadowLock(remianCount)
            end
            break
        end
    end
end

function SkillPanel:refreshMarkLock(data)
    printInfo("--- SkillPanel:refreshMarkLock ---")
    for k, button in pairs(self._skillmenu) do
        if ProtobufUtil:checkFieldIsInit(data, "addID") and data.addID > 0 then
            if(button:getSkillID() == data.addID) then
                local isLock = SkillDataManager:isNtfMarkSkill(data.addID)
                if isLock then
                    button:markLock()
                end
                break
            end
        elseif ProtobufUtil:checkFieldIsInit(data, "delID") and data.delID > 0 then
            if(button:getSkillID() == data.delID) then
                local isLock = SkillDataManager:isNtfMarkSkill(data.delID)
                if not isLock then
                    button:markUnlock()
                end
                break
            end
        elseif ProtobufUtil:checkFieldIsInit(data, "allIDs") and table.nums(data.allIDs) > 0 then
            for _, skillid in pairs(data.allIDs) do
                if(button:getSkillID() == skillid) then
                    local isLock = SkillDataManager:isNtfMarkSkill(skillid)
                    if not isLock then
                        button:markUnlock()
                    else
                        button:markLock()
                    end
                end
            end
        end
    end
end

function SkillPanel:scenePauseOrResume(isPause)
    -- print("---scenePauseOrResume---", isPause)
    for k, button in pairs(self._skillmenu) do
        if(not tolua.isnull(button)) then 
            if(isPause) then
                button:pause()
            else
                button:resume()
            end
        end
    end
end

function SkillPanel:autoBattleChange()
    -- print("---scenePauseOrResume---", isPause)
    self:handleConfig()
end

function SkillPanel:handleConfig()
    local GameDataManager = require("app.game.GameDataManager")
    local weaponType = GameDataManager:getInstance():getWearWeaponType()
    local order = GameManager:getAutoBattleType()

    self.autoData = nil
    local autoAttackConfig = ConfigManager:getAutoAttackDataByID(weaponType, order)
    if(autoAttackConfig) then 
        self.autoData = {}
        if(#autoAttackConfig.claimHpPercentForUse == #autoAttackConfig.skillSearchID and 
            #autoAttackConfig.skillSearchID == #autoAttackConfig.skillFinishCD) then 
            for i=1,#autoAttackConfig.claimHpPercentForUse,1 do 
                local oneData = {}
                oneData.hpPercentForUse = autoAttackConfig.claimHpPercentForUse[i]
                oneData.skillGroupID = autoAttackConfig.skillSearchID[i]
                oneData.finishCD = autoAttackConfig.skillFinishCD[i]
                oneData.useLimitTime = tonumber(autoAttackConfig.skillUseTimes[i])
                oneData.useTime = 0

                table.insert(self.autoData, oneData)
            end
        else
            --print("SkillPanel:handleConfig 3", #autoAttackConfig.claimHpPercentForUse, #autoAttackConfig.skillSearchID, #autoAttackConfig.skillFinishCD) 
        end
    end
end

function SkillPanel:handleAutoBattle(dt)
    if(self.autoData) then 
        self._waitingAutoSkillCD = self._waitingAutoSkillCD - dt * TIME_UNIT
        if(self._waitingAutoSkillCD <= 0) then
            self._waitingAutoSkillCD = 200
            local heroData = RoleDataManager:getMaster()
            if(heroData) then
                local nowPercet = heroData:getHpPercent()

                for k,oneConfig in ipairs(self.autoData) do 
                    if oneConfig and oneConfig.skillGroupID 
                        and self.skillGroupIDForSkillItem[oneConfig.skillGroupID] then 
                        local button = self.skillGroupIDForSkillItem[oneConfig.skillGroupID]
                        if(button:checkToUseSkill())then
                            if(oneConfig and nowPercet <= oneConfig.hpPercentForUse
                                and (oneConfig.useLimitTime ==-1 or oneConfig.useLimitTime >oneConfig.useTime )) then 
                                oneConfig.useTime = oneConfig.useTime + 1
                                -- 触发使用技能，如果是有目标的技能都以自己为目标，所以需要触发两次
                                button:autoUseSkill()
                                if(button:wasDirectSkill()) then 
                                    button:autoUseSkill()
                                end
                                -- 这里使用技能后都会有一个技能使用间隔
                                self._waitingAutoSkillCD = oneConfig.finishCD
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end

-- 注册监听事件
function SkillPanel:registerListener()
    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:bind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateHeroDataHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)

    -- 技能可以使用
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN, self, self.skillIsUseable)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_START_COOLDOWN, self, self.skillStartCooldown)

    -- 全部技能可以使用
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_REFRESH_ALL_CD, self, self.skillAllUseable)

 
    --变形状态改变 0:正常
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LOOKS_CHANGE, self, self.onLooksChangeHandler)

    --技能相关标志改变
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_RELATED_FLAG_CHANGE, self, self.onSkillRelatedFlagChange)

    --点击头像
    Avalon.MessageCenter:bind(AvalonMessage.MC_HAND_CLICK, self, self.skillTarget)

    --技能使用
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_RELEASE, self, self.skillEndSing)

    -- 功能标记
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_FLAG_CHANGE_FOR_SKILL, self, self.onFunctionFlagChange)
    
    -- 使用技能返回
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_USE_SKILL_RESULT,self,self.onUseSkillResult)
    -- 技能替换
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SKILL_REPLACE_SKILL,self,self.onReplaceSkill)
    -- 技能打断  
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_BREAK,self,self.onBreakSkill)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_SKILL_ISOPEN_STATUS,self,self.onRefresIsopen)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_HORCURX_TRANS_CHANGED,self,self.onHorcurxTransChanged)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ROLE_ANGER_CHANGED, self, self.updateMasterAnger)

    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REFRESH_SHADOW_LOCK, self, self.refreshShadowLock)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REFRESH_SKILL_MARK_LOCK, self, self.refreshMarkLock)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_CHANGE_AUTO_BATTLE_TYPE, self, self.autoBattleChange) 
end


-- 注销监听事件
function SkillPanel:unRegisterListener()
    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:unbind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateHeroDataHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN, self, self.skillIsUseable)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_START_COOLDOWN, self, self.skillStartCooldown)
    -- 全部技能可以使用
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_REFRESH_ALL_CD, self, self.skillAllUseable)
    --变形状态改变 0:正常
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LOOKS_CHANGE, self, self.onLooksChangeHandler)
    --技能相关标志改变
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_RELATED_FLAG_CHANGE, self, self.onSkillRelatedFlagChange)
    --点击头像
    Avalon.MessageCenter:unbind(AvalonMessage.MC_HAND_CLICK, self, self.skillTarget)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_RELEASE, self, self.skillEndSing)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_FLAG_CHANGE_FOR_SKILL, self, self.onFunctionFlagChange)
    -- 使用技能返回
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_USE_SKILL_RESULT,self,self.onUseSkillResult)
    -- 技能替换
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SKILL_REPLACE_SKILL,self,self.onReplaceSkill)
    -- 技能打断  
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_BREAK,self,self.onBreakSkill)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_SKILL_ISOPEN_STATUS,self,self.onRefresIsopen)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_HORCURX_TRANS_CHANGED,self,self.onHorcurxTransChanged)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ROLE_ANGER_CHANGED, self, self.updateMasterAnger)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REFRESH_SHADOW_LOCK, self, self.refreshShadowLock)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REFRESH_SKILL_MARK_LOCK, self, self.refreshMarkLock)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_CHANGE_AUTO_BATTLE_TYPE, self, self.autoBattleChange) 
end


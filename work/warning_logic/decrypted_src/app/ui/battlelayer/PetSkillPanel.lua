--[[
  技能界面
]]--

require "app.ui.battlelayer.SkillButton"

UI = UI or {}
local PetSkillPanel = class("PetSkillPanel",UI.HWBtnComponent)
UI.PetSkillPanel = PetSkillPanel

-- 测试开关
local DEBUG = false

local WIDTH  = 150
local HEIGHT = 150
-- 资源列表
local SKILL_PANEL_RES_LIST = {
    "ui_common_icon_effect.plist",
}

local SkillRelatedFlag = PublicDefine.SkillRelatedFlag
local SkillUseCondition = PublicDefine.SkillUseCondition
local Scheduler = Avalon.Scheduler
local FunctionFlag = PublicDefine.FunctionFlag

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

function PetSkillPanel:ctor()
    self._data = nil
    self._skillmenu = {}
    PetSkillPanel.super.ctor(self, 0, SKILL_PANEL_RES_LIST, WIDTH, HEIGHT, true)
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function PetSkillPanel:dtor()
    self._data = nil
    self._skillmenu = {}
    PetSkillPanel.super.dtor(self)
    self:unRegisterListener();
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

function PetSkillPanel:init(data)
    print ("====PetSkillPanel:init====")
    self._data = data
    PetSkillPanel.super.init(self,data)
    self:registerListener();
end

function PetSkillPanel:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_gaming_pets_fight_skill_bg.png")
    bg:center()
    self:addChild(bg)

    local button = UI.SkillButton:create(self._data)
    local skillID = 0
    if RoleDataManager:getScreenFightPetData() and RoleDataManager:getCaptain() then
        -- skillID = MasterDataManager:getCaptainPet():getInitiativeSkill()
        local captainId = RoleDataManager:getCaptain():getPetInstId()
        skillID = MasterDataManager:getBagPetById(captainId):getInitiativeSkill()
        -- for _, v in pairs(MasterDataManager:getFightPet()) do
        --     if v.petInstId == tostring(RoleDataManager:getCaptain():getPetInstId()) then
        --         skillID = v:getInitiativeSkill()
        --     end
        -- end
    else
        self:hide()
        return
    end
    require "app.config.ConfigManager"
    local skillData = SkillDataManager:createSkillForSkillId(skillID)
    if skillData then
        local cdTime = RoleDataManager:getCaptain():getSkillCd(skillID) - AvalonUtil.getCurrentTime()
        skillData:setIsOpening(false)
        skillData:setIsPetActive(true)
   	 	button:init(skillData)
    	button:setSize(100, 100)

    	-- 给按钮设置一个唯一的ID
    	button:setTag(skillData:getId())
    	button:center()
    	self:addChild(button)

    	button:addEventListener(UIEvent.USE_SKLL_CLICK, self, onActiveUseSkillHandler)
        table.insert(self._skillmenu, button)
        print("cdTime===", cdTime, RoleDataManager:getCaptain():getSkillCd(skillID), AvalonUtil.getCurrentTime())
        if cdTime > 0 then
            button:skillCoolDown(cdTime)
        end

        -- CO-20251 技能配置进战CD，冷却不显示
        local petEnterFightSkillCoolDownList = SkillDataManager:getPetEnterFightSkillCoolDownList()
        if petEnterFightSkillCoolDownList[skillData:getId()] and petEnterFightSkillCoolDownList[skillData:getId()] ~= 0 then
            self:skillIsUseable(skillData:getId(), petEnterFightSkillCoolDownList[skillData:getId()])
            SkillDataManager:setPetEnterFightSkillCoolDownList(skillData:getId(), nil)
        end
    else
        self:hide()
    end
end

function PetSkillPanel:update(dt)
    if self._skillmenu == nil then
        return
    end
    for k,button in pairs(self._skillmenu) do
        button:update(dt)
    end

    if(GameManager:getAutoBattleStatus() and GameManager:getIsShowAutoBattle()) then
        self._waitingTime = self._waitingTime or 100
        self._waitingTime = self._waitingTime - dt*TIME_UNIT
        if(self._waitingTime <= 0) then
            -- 这里设置每次轮训间隔100ms
            self._waitingTime = 100
            for k,button in pairs(self._skillmenu) do
                if(button:checkToUseSkill())then
                    -- 触发使用技能，如果是有目标的技能都以自己为目标，所以需要触发两次
                    button:autoUseSkill()
                    if(button:wasDirectSkill()) then 
                        button:autoUseSkill()
                    end
                    self._waitingTime = button:getSelfCooldDown() + 1000
                end
            end
        end
    end
end
-- 释放技能触发公共CD
function PetSkillPanel:runPublicCoolDown(data,time)
    for k,button in pairs(self._skillmenu) do
        if button and button:getTag() ~= data:getId() then
            -- 进入公共CD
            button:runPublicCoolDown(time)
        end
    end
end

-- 设置其他技能不可用,状态改变时才能使用，时间不确定
function PetSkillPanel:setSkillUnable(data)
    for k,button in pairs(self._skillmenu) do
        if button then
            -- 按钮不可用
            button:setSkillUnable()
        end
    end
end

-- 技能释放结果
function PetSkillPanel:onUseSkillResult(skillID,result)
    print("PetSkillPanel .....fail===>", skillID, result)
    if result ~= "HeroUseSkillResult_Succeed" then
        for k,button in pairs(self._skillmenu) do
            if button and button:getTag() == skillID  then
                button:clearCD()
                self._waitingTime = 1000
            end
        end
    end
end

-- 指向性技能被打断
function PetSkillPanel:setSkillClickable()
    for k,button in pairs(self._skillmenu) do
        if button then
            -- 设置按钮可用
            button:setSkillClickable()
        end
    end
end

-- 技能页面更新
function PetSkillPanel:onUpdateView(data)
    -- body
end


-- 吟唱结束
function PetSkillPanel:skillEndSing(skillData, isMaster)
    if skillData and not isMaster then 
        local skillID = skillData:getId()
        local hasGuide = skillData:hasGuide()

        for k,button in pairs(self._skillmenu) do
            if button and button:getTag() == skillID  then
                button:runWaitingCoolDown()
            end
        end
    end
end

function PetSkillPanel:skillStartCooldown(skillID,isOpen)
    if skillID then 
        for k,button in pairs(self._skillmenu) do
            if button and button:getTag() == skillID  then
                button:runCoolDown()
                local skillData = SkillDataManager:getSkillDataForSkillID(skillID, true)
                if skillData.hasOpenState == 1 then
                    skillData:setIsOpening(isOpen)
                    button:refreshIsOpen()
                end
            end
        end
    end  
end

-- 技能可以使用（若无吟唱过程的技能不发送此消息，技能button中添加本地CD好的动画）

-- todo add by yys 如果我A技能还剩0.5sCD 我使用了技能B,这个时候A应该继续执行1s公共CD
-- 而服务器并未跟客户端同步任何公共CD。所以,服务器会在A技能剩下这0.5sCD执行完毕之后告知客户端A技能已经可以使用了
-- 所以,客户端不能直接清理掉所有CD和执行冷却逻辑,这种情况下完全由客户端接管CD流程
function PetSkillPanel:skillIsUseable(skillID, residualTime)
    if skillID then 
        for k,button in pairs(self._skillmenu) do
            if button and button:getTag() == skillID  then
                if not button:isInPublicCooldown() then  
                    button:skillCoolDown(residualTime)
                end
            end
        end
    end  
end
-- 清理所有CD(释放技能报错用)
function PetSkillPanel:clearAllCd()
    for k,button in pairs(self._skillmenu) do
        button:clearCD()
       
    end
end
--所有技能可以使用(清除CD)
function PetSkillPanel:skillAllUseable()
    for k,button in pairs(self._skillmenu) do
        button:runPublicCoolDownForce()
    end
end

-- 技能施法资源是否足够
function PetSkillPanel:updateSkillState(roleData)
    if roleData then 
        for k,button in pairs(self._skillmenu) do
            if button then
                button:skillIsEnable(roleData)
            end
        end
    end
end

function PetSkillPanel:enable()
    for k,button in pairs(self._skillmenu) do
        if button then
            button:enable()
        end
    end
end

function PetSkillPanel:disable()
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:disable()
        end
    end
end

--技能触发条件改变列表
function PetSkillPanel:skillResIsEnable(roleData)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:skillResIsEnable(roleData)
        end
    end
end

-- 技能血量的条件
function PetSkillPanel:skillHpPercentIsEnable(roleData)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:skillHpPercentIsEnable(roleData)
        end
    end
end

--技能触发条件改变列表
function PetSkillPanel:skillTriggerChange(triggerData)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:skillTriggeringIsEnable(triggerData)
        end
    end
end


--技能免吟唱状态改变
function PetSkillPanel:onNoSpellTimeHandler(var)
    for k,button in pairs(self._skillmenu) do
        if button and (not tolua.isnull(button)) then
            button:onNoSpellTimeHandler(var)
        end
    end
end

--技能相关标志改变
function PetSkillPanel:onSkillRelatedFlagChange(spriteID,skillRelatedFlag)

    if RoleDataManager:getMasterSpriteID() == spriteID then
        if self ~= nil and (not tolua.isnull(self)) then 
            local skillRelatedFlagArr = ToolsUtil:splitPositionForValue(skillRelatedFlag)
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
            self:skillTriggerChange(triggerData)
        end
    end
end
-- 战斗中的功能标记改变
function PetSkillPanel:onFunctionFlagChange(flag,value)
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
function PetSkillPanel:onReplaceSkill(oldSkillID, skillData)
    for k,button in pairs(self._skillmenu) do
        if(button:getSkillID() == oldSkillID) then
            button:replaceSkill(skillData)
            break
        end
    end
end

-- 打断技能
function PetSkillPanel:onBreakSkill(skillID, skillState, isMaster)
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

function PetSkillPanel:onRefresIsopen(skillID)
    for k,button in pairs(self._skillmenu) do
        if(button:getSkillID() == skillID) then
            button:refreshIsOpen()
            break
        end
    end
end

--处理宠物死掉后 技能按钮 灰调
function PetSkillPanel:onRefreshDeadState(roleData)
    if self._data:getType() ~= RoleType.Pet then
        return
    end
    if roleData:getSpriteID() ~= self._data:getSpriteID() then
        return
    end
    for k,button in pairs(self._skillmenu) do
        button:skillIsEnable()
    end
end

function PetSkillPanel:scenePauseOrResume(isPause)
    print("---PetSkillPanel:scenePauseOrResume---", isPause)
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

-- 注册监听事件
function PetSkillPanel:registerListener()
    -- 技能可以使用
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN, self, self.skillIsUseable)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_START_COOLDOWN, self, self.skillStartCooldown)

    -- -- 全部技能可以使用
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_REFRESH_ALL_CD, self, self.skillAllUseable)

 
    --技能相关标志改变
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_RELATED_FLAG_CHANGE, self, self.onSkillRelatedFlagChange)

    --技能使用
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_RELEASE, self, self.skillEndSing)

    -- 功能标记
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_FLAG_CHANGE_FOR_SKILL_PET, self, self.onFunctionFlagChange)
    
    -- 使用技能返回
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_USE_SKILL_RESULT,self,self.onUseSkillResult)
    -- 技能替换
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SKILL_REPLACE_SKILL,self,self.onReplaceSkill)
    -- 技能打断  
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_BREAK,self,self.onBreakSkill)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_SKILL_ISOPEN_STATUS,self,self.onRefresIsopen)
    --状态同步
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE,self,self.onRefreshDeadState)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)
end


-- 注销监听事件
function PetSkillPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN, self, self.skillIsUseable)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_START_COOLDOWN, self, self.skillStartCooldown)
    -- -- 全部技能可以使用
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_REFRESH_ALL_CD, self, self.skillAllUseable)
    --技能相关标志改变
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_RELATED_FLAG_CHANGE, self, self.onSkillRelatedFlagChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_RELEASE, self, self.skillEndSing)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_FLAG_CHANGE_FOR_SKILL_PET, self, self.onFunctionFlagChange)
    -- 使用技能返回
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_USE_SKILL_RESULT,self,self.onUseSkillResult)
    -- 技能替换
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SKILL_REPLACE_SKILL,self,self.onReplaceSkill)
    -- 技能打断  
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_BREAK,self,self.onBreakSkill)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_SKILL_ISOPEN_STATUS,self,self.onRefresIsopen)
    --状态同步
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE,self,self.onRefreshDeadState)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, self, self.scenePauseOrResume)
end


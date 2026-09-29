--[[
  技能按钮
]] --

require "app.ui.common.Animation"

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local SkillButton = class("SkillButton", UI.HWBtnComponent)
UI.SkillButton = SkillButton

local Scheduler = Avalon.Scheduler

-- 测试开关
local DEBUG = true
local DEBUG_DRAW = true
local width = 0
local height = 0

local SKILL_BUTTON_RES_LIST = {}

local SKILL_SP_BG_1 = "ui_btn_gaming_battleskill_01.png"
local SKILL_SP_COOLD_1 = "ui_btn_gaming_battleskill_cooldown01.png"
local SKILL_SP_BG_2 = "ui_btn_gaming_battleskill_02.png"

local SKILL_JSON = "effect_ui_gaming_itemselect.json"
local SKILL_ATLAS = "effect_ui_gaming_itemselect.atlas"

-- 子节点的z序
local ZORDER_SKILL_BG = 1
local ZORDER_SKILL_ICON = 2
local ZORDER_SKILL_TIMER = 3
local ZORDER_SKILL_COOLDOWN = 4

-- 技能按钮的状态
UI.SKILL_STATE = {
    --可点击状态(准备点击)
    BUTTON_CLICKABLE = 1,
    --点击结束
    BUTTON_END_CLICK = 2,
    -- 吟唱
    BUTTON_SING = 3,
    -- 选择目标
    BUTTON_CHOICE = 4,
    -- 开始冷却
    BUTTON_COOLDOWN = 5,
    -- 技能不可用
    BUTTON_UNABLE = 6,
    -- 指向性技能取消
    BUTTON_CANCEL = 7
}
UI.SKILL_COOLDOWN_TYPE = {
    NONE = 0,
    -- 正常
    COOLDOWN_NORMAL = 1,
    -- 公共CD
    COOLDOWN_PUBLIC = 2
}
local skillState = UI.SKILL_STATE

function SkillButton:ctor(heroData)
    self._data = nil
    self._skillGroupID = nil
    -- 冷却类型
    self._coolDownType = UI.SKILL_COOLDOWN_TYPE.NONE
    self._heroData = heroData
    SkillButton.super.ctor(self, UIType.SKILL_BUTTON, SKILL_BUTTON_RES_LIST, width, height)
end

function SkillButton:dtor()
    self:unRegisterListener()
    self._data = nil
    -- Scheduler:unscheduleUpdate(self, SkillButton.skillIsEnable)
    SkillButton.super.dtor(self)
end

function SkillButton:checkToUseSkill()
    if self._enable then
        -- 技能类型 瞬发 吟唱 引导
        if self._data then
            -- 这里可能服务器还没有通知冷却完成
            if self._timer and self._timer:isVisible() then 
                return false
            end

            if self._skillState == skillState.BUTTON_CLICKABLE then
                if not self._heroData:judgeToUseSkill() then
                    
                    return false
                end

                if self.curTouchCount and self.targetTouchCount and self.curTouchCount <= self.targetTouchCount then
                    return false
                end

                local isLock, remianCount = SkillDataManager:isShadowSkill(self._data:getSkillID())
                if(isLock) then 
                    return false
                end

                -- if self._heroData:getIsSeal() then 
                --     print("self._heroData:getIsSeal")
                --     return false
                -- end

                -- 判断技能CD
                if self._startCD then
                    -- print("CD中 不能使用技能")
                    return false
                end
                if not self._resIsEnough then
                    -- print("资源不足")
                    return false
                end

                if self._triggeringEnable == false then
                    -- print("未达成触发条件")
                    return false
                end

                if (self._hpPercentToUse) == false then
                    -- print("当前血量不满足释放条件")
                    return false
                end

                if #self.enableSkillStateList > 0 then
                    -- print("存在不可用条件")
                    return false
                end

                return true
            end
        end
    end

    return false
end

-- 技能点击的处理
local function onActiveUseSkillHandler(self)
    -- print("----", #self.enableSkillStateList, self._startCD, self._resIsEnough, self._triggeringEnable, self._hpPercentToUse, self._skillState)
    if self._enable then
        -- 技能类型 瞬发 吟唱 引导
        if self._data then
            if self._skillState == skillState.BUTTON_CLICKABLE then
                if not self._heroData:judgeToUseSkill() then
                    -- print("负面状态 不能使用技能")
                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170090))
                    return
                end
                -- 判断技能CD
                if self._startCD then
                    -- print("CD中 不能使用技能")
                    return
                end
                if not self._resIsEnough then
                    -- print("资源不足")
                    return
                end

                if self._triggeringEnable == false then
                    -- print("未达成触发条件")
                    return
                end

                if (self._hpPercentToUse) == false then
                    -- print("当前血量不满足释放条件")
                    return
                end

                if #self.enableSkillStateList > 0 then
                    -- print("存在不可用条件")
                    return
                end

                if self._noSpellEffect and (tolua.isnull(self._noSpellEffect)) then
                end

                self:showClickAnimation()
                if self._heroData:getType() == RoleType.Pet then
                    local PTargetType = PublicDefine.ESkillTargetType
                    if self._data:getTargetType() == PTargetType.ESkillTargetType_Self then
                        self:useSkill(self._data, self._heroData:getSpriteID())
                    elseif self._data:getTargetType() == PTargetType.ESkillTargetType_Master then
                        self:useSkill(self._data,  self._heroData.masterSpriteID)
                    elseif self._data:getTargetType() == PTargetType.ESkillTargetType_Target then --敌人
                        local MachineManager = require("app.game.MachineManager")
                        local machine = MachineManager:getInstance():getMachine()
                        if(machine and machine._model) then 
                            local battleField = machine._model:getBattleFieldBySpriteID(self._heroData:getSpriteID(),nil)
                            if battleField then
                                local targetSpriteID = nil
                                local monster = battleField:getTargetMonster()
                                if monster then
                                     self:useSkill(self._data, monster:getSpriteID())
                                end
                            end
                        end 
                    else
                        self:useSkill(self._data)
                    end
                    self._skillState = skillState.BUTTON_END_CLICK
                else
                    if self._isDirection then
                        self._skillAnimation:setAnimation("loop_fillet2", true)
                        self._skillState = skillState.BUTTON_CHOICE
                        self:dispatchEvent(UIEvent.USE_SKLL_CLICK, self._data, self._skillState)
                    else
                        -- 是否有吟唱
                        local sing = self._data:hasPrepareStep()
                        if sing == true and self.noSpellTime then
                            sing = false
                        end
                        if sing then
                            -- print("===吟唱")
                            self:loopClickAnimation()
                            self._skillState = skillState.BUTTON_SING
                            self:dispatchEvent(UIEvent.USE_SKLL_CLICK, self._data, self._skillState)
                            -- 发送使用技能
                            self:useSkill(self._data)
                        else
                            -- print("==没有吟唱==")
                            -- 发送使用技能
                            self:useSkill(self._data)
                            self:dispatchEvent(UIEvent.USE_SKLL_CLICK, self._data, skillState.BUTTON_COOLDOWN)
                        end

                        -- 技能可以使用，触发公共CD
                        self._skillState = skillState.BUTTON_END_CLICK
                        self:dispatchEvent(UIEvent.USE_SKLL_CLICK, self._data, self._skillState)
                    end
                end
            elseif self._skillState == skillState.BUTTON_SING then
                -- print("==吟唱开始==")
            elseif self._skillState == skillState.BUTTON_CHOICE then
                -- 选中自己
                local roleData = RoleDataManager:getMaster()
                local targetId = roleData.spriteID
                self:choseTarget(targetId)
            elseif self._skillState == skillState.BUTTON_COOLDOWN then
                -- print("===技能自身CD")
            elseif self._skillState == skillState.BUTTON_UNABLE then
            -- print("==技能按钮不可用==")
            -- 公共CD或者指向性技能选择目标
            end
        else
            assert(false)
        end
    else
        -- print("==技能按钮不可用==_enable")
    end
end

--data.__cname = skillData
function SkillButton:init(data, skillGroupID)
    self._data = data
    self._skillGroupID = skillGroupID
    -- 技能冷却动画,指向性技能
    self._coolDown = nil
    self._targetSkill = nil
    -- 技能图标
    self._itemSp = nil
    -- 技能背景
    self._itemBG = nil

    self._timer = nil
    self._isDirection = false
    -- 技能自身CD时间
    self._selfCDTime = 0
    -- 公共CD时间
    self._publicCDTime = 0
    self._skillState = skillState.BUTTON_CLICKABLE

    self._enable = true --技能可用
    self._resIsEnough = false

    self._triggeringEnable = true --是否到达触发条件
    self._hpPercentToUse = true

    if self._data.useCondition ~= 0 then
        self._triggeringEnable = false
    end
    self:refreshHpPercentToUse()

    --技能是否被禁用(变身,禁言等)
    self.enableSkillStateList = {}

    --免费技能花费
    self.freeSkillSpend = false
    --下一技能瞬发
    self.noSpellTime = false
    --技能增益效果
    self._skillBuff = false
    -- 记录服务器是否通知了客户端已经冷却完成
    self._serverNoticeCoolDown = false

    self._startCD = false
    self._cdTime = 0
    self._curTime = 0
    SkillButton.super.init(self, data)

    self:registerListener()
end

function SkillButton:onInitView(data)
    -- print ("====SkillButton:initView====")
    -- 冷却完成后的动画
    local skillAnimation = UI.Animation:create()
    skillAnimation:init(SKILL_JSON, SKILL_ATLAS, 1, true)
    skillAnimation:center()
    self:addChild(skillAnimation, ZORDER_SKILL_COOLDOWN)
    self._skillAnimation = skillAnimation

    -- 技能背景
    local itemBG = UI.Image:create()
    itemBG:init(SKILL_SP_BG_1)
    itemBG:center()
    self:addChild(itemBG, ZORDER_SKILL_BG)
    self._itemBG = itemBG

    -- 技能图标
    local itemSp = UI.Image:create()
    itemSp:init(self._data:getIconName())
    itemSp:center()
    itemSp:setTouchEnable(true)
    -- 这里设计一个防止多次连续点击的操作
    itemSp:addEventListener(UIEvent.COMPONENT_CLICK, self, self.clickUseSkill)
    itemBG:addChild(itemSp, ZORDER_SKILL_ICON)
    self._itemSp = itemSp

    -- 技能图标
    local timer = nil
    if self._heroData:getType() == RoleType.Pet then
        timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_btn_gaming_pets_battleskill_cooldown01.png"))
    else
        timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(SKILL_SP_COOLD_1))
    end
    timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    timer:setContentSize(cc.p(94, 94))
    timer:setPercentage(0)

    itemBG:addChild(timer, ZORDER_SKILL_ICON)
    timer:setVisible(false)
    self._timer = timer
    if self._heroData:getType() == RoleType.Pet then
        self._timer:setPosition(-7, -8)
    else
        self._timer:setPosition(0, 0)
    end

    local itemIsOpen = UI.Image:create()
    itemIsOpen:init("ui_skill_banner_black2.png")
    itemIsOpen:center()
    itemIsOpen:setVisible(false)
    itemBG:addChild(itemIsOpen, ZORDER_SKILL_ICON)
    self._itemIsOpen = itemIsOpen

    self:skillResIsEnable()
    local triggerData = {}
    self:skillTriggeringIsEnable(triggerData)

    if self._heroData:getType() == RoleType.Hero and not self._heroData:isHorcruxTransform() then

        local isEnable = false
        local looks = self._heroData:getLooks()
        local monsterIdRange = ConfigManager:getGeneralForKey("monsterIdRange")
        local arr = string.split(monsterIdRange, ",")
        if looks == 0 or (looks >= tonumber(arr[1]) and looks <= tonumber(arr[2])) then
            isEnable = true
        end

        self:skillStateIsEnable(UI.EnabelSkillStateType.looks, isEnable)
    end

    self:refreshIsOpen()
end

function SkillButton:refreshIsOpen(isOpening)
    if (self._data) then
        if isOpening ~= nil then
            self._data:setIsOpening(isOpening)
        end
        if (self._data:getIsOpening()) then
            self._itemIsOpen:setVisible(true)
        else
            self._itemIsOpen:setVisible(false)
        end
    end
end

function SkillButton:getSkillID()
    if (self._data) then
        return self._data:getSkillID()
    end

    return nil
end

-- 判断消耗资源是否充足
function SkillButton:skillResIsEnable()
    if self.freeSkillSpend then
        self._resIsEnough = true
        self:skillIsEnable()
        return
    end

    -- 判断消耗资源是否充足
    if self._heroData:getType() == RoleType.Hero then
        if self._data.costType == 1 then
            local skillID = 0
            if(self._data) then 
                skillID = self:getSkillID()
            end
            skillID = skillID or 0
            local cast = MasterDataManager:calculationSkillMp(self._data, self._data.cost, ToolsUtil:getRoleType(skillID))
            if cast <= self._heroData.curMp then
                self._resIsEnough = true
            else
                self._resIsEnough = false
            end
        elseif self._data.costType == 2 then
            if self._data.cost <= self._heroData.curHp then
                self._resIsEnough = true
            else
                self._resIsEnough = false
            end
        else
            self._resIsEnough = true
        end
    else
        self._resIsEnough = true
    end

    self:skillIsEnable()
end

-- 刷新技能的血量逻辑
function SkillButton:skillHpPercentIsEnable()
    self:refreshHpPercentToUse()
    self:skillIsEnable()
end

function SkillButton:refreshHpPercentToUse()
    -- body
    if (self._data.claimHpPercentForUse ~= 0) then
        self._hpPercentToUse = false
        if (self._heroData and self._heroData:judgeHpPercertToUseSkill(self._data.claimHpPercentForUse)) then
            self._hpPercentToUse = true
        end
    end
end

-- 判断技能触发条件判断
function SkillButton:skillTriggeringIsEnable(triggerData)
    if self._data.useCondition == 0 then
        return
    end
    self._triggeringEnable = false
    local useCondition = self._data.useCondition

    local useConditionList = ToolsUtil:splitPositionForValue(useCondition)

    for k, v in pairs(useConditionList) do
        for k1, v1 in pairs(triggerData) do
            if k1 == k then
                self._triggeringEnable = true
                self:skillIsEnable()
                print(self._triggeringEnable)
                return
            end
        end
    end

    self:skillIsEnable()
end

--技能使用状态
function SkillButton:skillStateIsEnable(enableStateType, value)
    -- print("SkillButton:skillStateIsEnable(enableStateType,value)",enableStateType,value)
    for i = 1, #(self.enableSkillStateList) do
        if self.enableSkillStateList[i] == enableStateType then
            if value then
                table.remove(self.enableSkillStateList, i)
                self:skillIsEnable()
                return
            else
                return
            end
        end
    end

    if value == false then
        table.insert(self.enableSkillStateList, enableStateType)
    end

    self:skillIsEnable()
end

--技能花费状态改变
function SkillButton:onSkillSpendChangeHandler(var)
    self.freeSkillSpend = var
    self:skillResIsEnable(RoleDataManager:getMaster())
    if var then
        if not self._noSpendEffect or (tolua.isnull(self._noSpellEffect)) then
            local _noSpendEffect = UI.Animation:create()
            _noSpendEffect:init("effect_ui_gaming_skill_freeskill.json", "effect_ui_gaming_skill_freeskill.atlas", 1, true)
            _noSpendEffect:center()
            self:addChild(_noSpendEffect, -10)
            self._noSpendEffect = _noSpendEffect
        end
        self._noSpendEffect:clearTrack()
        self._noSpendEffect:setAnimation("trigger", false)
        self._noSpendEffect:addAnimation("idle", true)
    else
        if self._noSpendEffect and (not tolua.isnull(self._noSpendEffect)) then
            self._noSpendEffect:clearTrack()
            self._noSpendEffect:setAnimation("end", false)
        end
    end
end

--技能免吟唱状态改变
function SkillButton:onNoSpellTimeHandler(var)
    --吟唱技能则添加瞬发特效
    if self._data:hasPrepareStep() then
        self.noSpellTime = var
        if var then
            if not self._noSpellEffect or (tolua.isnull(self._noSpellEffect)) then
                local noSpellEffect = UI.Animation:create()
                noSpellEffect:init("effect_ui_gaming_skill_instant.json", "effect_ui_gaming_skill_instant.atlas", 1, true)
                noSpellEffect:center()
                self:addChild(noSpellEffect, -10)
                self._noSpellEffect = noSpellEffect
            end
            self._noSpellEffect:clearTrack()
            self._noSpellEffect:setAnimation("trigger", false)
            self._noSpellEffect:addAnimation("idle", true)
        else
            if self._noSpellEffect and (not tolua.isnull(self._noSpellEffect)) then
                self._noSpellEffect:setAnimation("end", false)
            end
        end
    end
end

-- 更新技能触发表现
function SkillButton:skillIsEnable()
    -- print("SkillButton:skillIsEnable")
    if self._itemSp then
        if not  self._heroData:judgeToUseSkill() then
            -- print("负面状态 不能使用技能", self._data:getId())
            self._itemSp:useShader(UI.COMPONENT_GRAY_SHADER)
            self._itemBG:useShader(UI.COMPONENT_GRAY_SHADER)
            return
        end

        if self._resIsEnough and self._triggeringEnable and self._hpPercentToUse then
        else
            -- print(self._resIsEnough , self._triggeringEnable, self._hpPercentToUse, self._data.useCondition)
            self._itemSp:useShader(UI.COMPONENT_GRAY_SHADER)
             self._itemBG:useShader(UI.COMPONENT_GRAY_SHADER)
            return
        end

        if #self.enableSkillStateList > 0 then
            self._itemSp:useShader(UI.COMPONENT_GRAY_SHADER)
            self._itemBG:useShader(UI.COMPONENT_GRAY_SHADER)
            return
        end

        self._itemSp:useShader(UI.COMPONENT_NORMAL_SHADER)
        self._itemBG:useShader(UI.COMPONENT_NORMAL_SHADER)
    end
end
-- 禁用技能
function SkillButton:forbidden(forbidden)
    if forbidden then
        if self._skillState == skillState.BUTTON_SING then
            self:cancelSkill()
        end

        self:endClickAnimation()
    end

    self:skillIsEnable()
end

function SkillButton:onUpdateView(data)
    local data = self._data
    if data then
        self._data = data
        self._isDirection = data:getIsDirection()

        -- print("====技能的目标类型",self._directionType)
        if self._heroData:getType() == RoleType.Pet then
            self._itemBG:setSpriteName("ui_gaming_pet_skill_box.png")
        elseif self._isDirection then
            self._itemBG:setSpriteName(SKILL_SP_BG_2)
        end
        -- 技能图标
        self._itemSp:setSpriteName(data:getIconName())

        local time = ConfigManager:getPublicCDTime()

        local mCDTime = data and data:getCooldown()

        -- 测试
        self._publicCDTime = time * 1
        -- 冷却时间
        if mCDTime < time * 1 then
            self._selfCDTime = time * 1
        else
            self._selfCDTime = mCDTime
        end
        local isLock, remianCount = SkillDataManager:isShadowSkill(data:getSkillID())
        if isLock then
            self:shadowLock(remianCount)
        end

        local isMarkLock = SkillDataManager:isNtfMarkSkill()
        if isMarkLock then
            self:markLock()
        end
    end
end
function SkillButton:update(dt)
    if not self._startCD then
        return
    end
    if(self.isPause) then 
        return
    end

    self._curTime = self._curTime + dt
    local progress = 1 - self._curTime / self._cdTime
    progress = progress < 0 and 0 or progress
    self._timer:setPercentage(progress * 100)
    
    if self._cdTime - self._curTime <= 0 then
        self._curTime = 0
        self._startCD = false
        -- print("SkillButton:update   ===", self._data:getId(), self._coolDownType, UI.SKILL_COOLDOWN_TYPE.COOLDOWN_NORMAL)
        -- add by zp 这里不应该自己冷却
        if self._coolDownType ~= UI.SKILL_COOLDOWN_TYPE.COOLDOWN_NORMAL then
            self:showCoolDown()
            self:clearCD()
        else
            -- print("SkillButton:update  wwwww  skillID=", self._data:getId())
            if (self._serverNoticeCoolDown) then
                self:showCoolDown()
                self:clearCD()
            elseif self._heroData:getType() == RoleType.Pet then
                self:showCoolDown()
                self:clearCD()
            end
        end
    end
end
-- 强行清理CD 比如在释放技能后服务器返回错误的时候
function SkillButton:clearCD()
    self._skillState = skillState.BUTTON_CLICKABLE
    self._coolDownType = UI.SKILL_COOLDOWN_TYPE.NONE
    self._startCD = false
    self._cdTime = 0
    self._curTime = 0
    self._timer:setPercentage(0)
    self._serverNoticeCoolDown = false

    self:showCoolDown()
    self:skillIsEnable()
end
-- 强制进入公共CD(刷新冷却时间)
function SkillButton:runPublicCoolDownForce(time)
    self._coolDownType = UI.SKILL_COOLDOWN_TYPE.COOLDOWN_PUBLIC
    if not time then
        time = self._publicCDTime
    end
    -- print("强制冷却  当前时间",self._curTime, self._data:getId())
    time = time / 1000
    self._startCD = true
    self._curTime = 0
    self._cdTime = time

    self._timer:setVisible(true)

    self._skillState = skillState.BUTTON_COOLDOWN
    self:skillIsEnable()
end

-- 获取剩余冷区类型以及剩余冷却时间
function SkillButton:getCDTypeOrCDTime()

    return self._coolDownType, self._cdTime - self._curTime
end

function SkillButton:getSelfCooldDown()
    return self._selfCDTime
end

--[[
    恢复冷却
    CDType:恢复类型
    CDTime:恢复时间
]]
function SkillButton:restoreCoolDown(CDType, CDTime)
    if(CDType == UI.SKILL_COOLDOWN_TYPE.COOLDOWN_PUBLIC) then 
        self:runPublicCoolDown(CDTime)
    elseif(CDType == UI.SKILL_COOLDOWN_TYPE.COOLDOWN_NORMAL) then 
        self:runCoolDown(CDTime)
    end
end

-- 进入等待使用技能状态
function SkillButton:runWaitingCoolDown()
    -- print("SkillButton:runWaitingCoolDown", self._data:getId())
    -- print(debug.traceback())
    if (self._itemSp) then
        self._itemSp:useShader(UI.COMPONENT_GRAY_SHADER)
        self._itemBG:useShader(UI.COMPONENT_GRAY_SHADER)
    end
end

-- 重置技能状态
function SkillButton:resetSkillState()
    self._skillState = skillState.BUTTON_CLICKABLE
end

-- 公共CD(时间为毫秒)
function SkillButton:runPublicCoolDown(time)
    -- print("SkillButton:runPublicCoolDown", self._data:getId())
    -- print(debug.traceback())
    self:skillIsEnable()
    self._coolDownType = UI.SKILL_COOLDOWN_TYPE.COOLDOWN_PUBLIC
    if not time then
        time = self._publicCDTime
    end
    time = time / 1000
    -- 如果当前剩余CD时间比新的CD时间还长,忽略掉
    -- print("self._cdTime",self._cdTime,self._curTime)
    if self._startCD and self._cdTime - self._curTime > time then
        return
    end
    self._startCD = true
    self._cdTime = time
    self._curTime = 0

    self._timer:setVisible(true)

    self._skillState = skillState.BUTTON_COOLDOWN
end

-- 技能冷却蒙板(时间为毫秒)
function SkillButton:runCoolDown(time)
    -- print("SkillButton:runCoolDown", self._data:getId())
    self._coolDownType = UI.SKILL_COOLDOWN_TYPE.COOLDOWN_NORMAL
    -- 冷却前停止点击的动画
    self:endClickAnimation()
    self:skillIsEnable()
    if not time then
        time = self._selfCDTime

        if time < self._publicCDTime then
            time = self._publicCDTime
        end
    end

    -- 三阶技能需求 在CD中需要能刷新技能 加一个公共技能CD判断
    if self._publicCDTime and self._publicCDTime > time then
        return
    end

    time = time / 1000
    
    -- 如果当前剩余CD时间比新的CD时间还长,忽略掉 
    -- if self._startCD and self._cdTime - self._curTime > time then
    --     return
    -- end
    
    self._startCD = true
    self._cdTime = time
    self._curTime = 0
    self._timer:setVisible(true)
    self._skillState = skillState.BUTTON_COOLDOWN
end

function SkillButton:skillCoolDown(residualTime)
    if residualTime and residualTime > 0 then
        self:runCoolDown(residualTime)
        return
    end
    -- 判断公共CD是否走完了，如果没有走完继续走公共CD
    if (self._startCD) then
        self._serverNoticeCoolDown = true
        -- print("SkillButton:skillCoolDown",self._curTime, self._cdTime, self._publicCDTime)
        if (self._curTime >= self._publicCDTime / 1000) then
            self:showCoolDown()
            self:clearCD()
        else
            self._cdTime = self._publicCDTime / 1000
        end
    else
        -- 客户端已经倒计时完成了，但是还没有收到服务器通知冷却的情况
        self:showCoolDown()
        self:clearCD()
    end
end

-- 是否在公共CD
function SkillButton:isInPublicCooldown()
    return self._coolDownType == UI.SKILL_COOLDOWN_TYPE.COOLDOWN_PUBLIC
end
-- 是否在普通CD中
function SkillButton:isInNormalCooldown()
    return self._coolDownType == UI.SKILL_COOLDOWN_TYPE.COOLDOWN_NORMAL
end

-- 技能中断，或者取消
function SkillButton:cancelSkill()
    -- print("SkillButton:cancelSkill", self._data:getId())
    -- 指向性技能
    -- self._targetSkill:hide()
    if (self._isDirection) then
        self._skillAnimation:setAnimation("end_fillet2", false)
    end

    self._skillState = skillState.BUTTON_CLICKABLE
    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_CANCEL_SKILL)
    self:skillIsEnable()
end

-- 处理使用技能
function SkillButton:useSkill(skill, id)
    -- print("=====使用技能处理=====")
    local isPet = self._heroData:getType() == RoleType.Pet
    local data = {
        skillData = skill,
        targetSpriteID = id,
        coordX = coordX,
        coordY = coordY,
        isPet = isPet
    }

    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_USE_SKILL, data, self._heroData:getType() == RoleType.Hero)
    GameManager:useSkillHandler(data)
end

function SkillButton:replaceSkill(skillData)
    if (skillData) then
        self._data = skillData
        self:updateView()
    end
end

function SkillButton:setState(value)
    if (type(value) ~= "number") then
        printError("Skill Button: state is invalid.")
    end

    self._skillState = value
end

-- 设置按钮不可用
function SkillButton:setSkillUnable()
    self._skillState = skillState.BUTTON_UNABLE
end

-- 设置按钮可点击
function SkillButton:setSkillClickable()
    self._skillState = skillState.BUTTON_CLICKABLE
end

-- 服务器按钮可用
function SkillButton:severSkillClickable()
    -- self._severUseable = true
end

-- 指向性技能选择好目标
function SkillButton:choseTarget(targetId)
    if not self._heroData:judgeToUseSkill() then
        -- print("负面状态 不能使用技能")
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170090))
        self:cancelSkill()
        return
    end

    local sing = self._data:hasPrepareStep()
    -- 测试无吟唱
    -- local sing = false

    if sing then
        -- print("===吟唱")
        self._skillState = skillState.BUTTON_SING
        self:dispatchEvent(UIEvent.USE_SKLL_CLICK, self._data, self._skillState)
        -- 使用技能
        self:useSkill(self._data, targetId)
        -- 通知角色面板停止选择目标
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_CANCEL_SKILL)
    else
        -- 使用技能
        self:useSkill(self._data, targetId)

        -- 进行CD
        self:dispatchEvent(UIEvent.USE_SKLL_CLICK, self._data, skillState.BUTTON_COOLDOWN)

        -- 通知角色面板停止选择目标
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_CANCEL_SKILL)
    end

    self._skillState = skillState.BUTTON_END_CLICK
    self:dispatchEvent(UIEvent.USE_SKLL_CLICK, self._data, self._skillState)
end

--播放技能点击时候的动画
function SkillButton:showClickAnimation()
    if self._heroData:getType() == RoleType.Pet then
        self._skillAnimation:setAnimation("start_circle", false)
    elseif (self._isDirection) then
        self._skillAnimation:setAnimation("start_fillet2", false)
    else
        self._skillAnimation:setAnimation("start_fillet", false)
    end
end

--播放技能点击后有吟唱的动画
function SkillButton:loopClickAnimation()
    if self._heroData:getType() == RoleType.Pet then
        self._skillAnimation:setAnimation("loop_circle", true)
    elseif (self._isDirection) then
        self._skillAnimation:setAnimation("loop_fillet2", true)
    else
        self._skillAnimation:setAnimation("loop_fillet", true)
    end
end

-- --播放技能点击后消失
function SkillButton:endClickAnimation()
    if self._heroData:getType() == RoleType.Pet then
        self._skillAnimation:setAnimation("end_circle", false)
    elseif (self._isDirection) then
        self._skillAnimation:setAnimation("end_fillet2", false)
    else
        self._skillAnimation:setAnimation("end_fillet", false)
    end
end

-- 设置冷却动画
function SkillButton:showCoolDown()
    self._timer:stopAllActions()
    if self._heroData:getType() == RoleType.Pet then
        self._skillAnimation:setAnimation("renew_circle", false)
    elseif (self._isDirection) then
        self._skillAnimation:setAnimation("renew_fillet2", false)
    else
        self._skillAnimation:setAnimation("renew_fillet", false)
    end
    self._timer:setVisible(false)
end

-- 技能用点击
function SkillButton:enable()
    self._enable = true
end

-- 技能不可用点击，不影响状态
function SkillButton:disable()
    self._enable = false
end

--攻击怪物的血条改变
function SkillButton:onAttackMonsterHPChangeHandler(curHp, hp)
    if self._performTriggerEventData[1] == "1" then
        if curHp * 100.0 / hp < tonumber(self._performTriggerEventData[2]) then
            self:skillBuff(true)
        else
            self:skillBuff(false)
        end
    end
end

-- 技能变强
function SkillButton:skillBuff(var)
    if self._skillBuff ~= var then
        if var then
            if not self._noSpellEffect or (tolua.isnull(self._noSpellEffect)) then
                local noSpellEffect = UI.Animation:create()
                noSpellEffect:init("effect_ui_gaming_skill_powerup.json", "effect_ui_gaming_skill_powerup.atlas", 1, true)
                noSpellEffect:center()
                self:addChild(noSpellEffect, -10)
                self._noSpellEffect = noSpellEffect
            end
            self._noSpellEffect:clearTrack()
            self._noSpellEffect:setAnimation("trigger", false)
            self._noSpellEffect:addAnimation("idle", true)
        else
            if self._noSpellEffect and (not tolua.isnull(self._noSpellEffect)) then
                self._noSpellEffect:setAnimation("end", false)
            end
        end
        self._skillBuff = var
    end
end

-- 注册监听事件
function SkillButton:registerListener()
    if self._data.UIPerformTriggerEvent ~= "" then
        local performTriggerEventData = string.split(self._data.UIPerformTriggerEvent, ";")
        if performTriggerEventData[1] == "1" then
            Avalon.MessageCenter:bind(
                AvalonMessage.MC_SKILL_ATTACK_MONSTER_HP_CHANGE,
                self,
                self.onAttackMonsterHPChangeHandler
            )
        end
        self._performTriggerEventData = performTriggerEventData
    end
end

-- 注销监听事件
function SkillButton:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SKILL_ATTACK_MONSTER_HP_CHANGE,self,self.onAttackMonsterHPChangeHandler)
end

--被阴影笼罩技能锁住
function SkillButton:shadowLock(remianCount)
    print("---SkillButton:shadowLock--", remianCount)
    if self.shadowLockAni ~= nil then
        print("error shadowLock not null")
        return
    end
    local shadowLock = UI.Animation:create()
    shadowLock:init("effect_role_monster_boss_shadow_avatar_skill2_fang.json", "effect_role_monster_boss_shadow_avatar_skill2_fang.atlas", 1, true);
    shadowLock:center()
    shadowLock:setSize(100, 100)
    self:addChild(shadowLock, 100)
    shadowLock:setAnimation("begin", false)
    shadowLock:setTouchEnable(true)
    shadowLock:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:shadowClick(true)
    end)
    self.shadowLockAni = shadowLock
    shadowLock:setTouchEnable(true)
    shadowLock:setSwallowTouches(true)
    shadowLock:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "end") then
            sender:destroy()
            self.shadowLockAni = nil
            self:runPublicCoolDown()
        end
    end)
     -- 注册动画音效事件
    shadowLock:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- TODO 播放音效文件
                local soundFilename = string.sub(event.eventData.name,7,-1)
                Avalon.AudioManager:playSound(soundFilename)
            end

            local shakePos = string.find(event.eventData.name, "hitshake_")
            if(shakePos ~= nil) then
                -- 播放抖动
                local shake = string.sub(event.eventData.name,10,-1)
                if(shake) then 
                    Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                end
            end
        end
    end)

    local max = tonumber(ConfigManager:getGeneralForKey("removeSkillLockingTouchTimes"))
    self.curTouchCount = max - remianCount
    self.targetTouchCount = max
    if self.curTouchCount == 0 then
        shadowLock:addAnimation("idle", false)
    else
        self:shadowClick()
    end
    UI.ScrollBar:createByText(UI.TEXT_1213958)
end

--点击解锁阴影笼罩
function SkillButton:shadowClick(isClick)
    if self.curTouchCount > self.targetTouchCount then
        return
    end
    if(isClick == true) then
        GameManager:setAutoBattleStatus(false)
    end
    self.curTouchCount = self.curTouchCount + 1
    SkillDataManager:refreshShadowSkill(self._data:getSkillID(), -1)
    local list = {"trigger1", "trigger2", "trigger3", "trigger4", "trigger5", "trigger6", "trigger7", "trigger8"}
    if self.curTouchCount <= self.targetTouchCount then
        local index = math.ceil(self.curTouchCount / self.targetTouchCount * #list)
        self.shadowLockAni:setAnimation(list[index], false)
    else
        self.shadowLockAni:setAnimation("end", false)
        SkillDataManager:clearShadowSkill(self._data:getSkillID())
        Net.NetRoleSystem:reqUnlockShadowSkill(self._data:getSkillID())
    end
end

--被大地诅咒技能锁住
function SkillButton:markLock()
    printInfo("---SkillButton:markLock--")
    if self.markLockSign then
        return
    end

    self.markLockSign = true

    if self.markLockAni == nil then
        local markLockAni = UI.Animation:create()
        markLockAni:init("effect_role_boss_oldgodrebron_skill2.json", "effect_role_boss_oldgodrebron_skill2.atlas", 1, true);
        markLockAni:center()
        -- markLockAni:setSize(100, 100)
        self:addChild(markLockAni, 100)
        self.markLockAni = markLockAni
    end

    self.markLockAni:setAnimation("begin", false)
    -- performWithDelay(self, function()
        self.markLockAni:addAnimation("idle", true)
    -- end, 0.25)

    UI.ScrollBar:createByText(UI.TEXT_1213968)
end

--大地诅咒技能解锁
function SkillButton:markUnlock()
    printInfo("--- SkillButton:markUnlock ---")
    if not self.markLockSign then
        printInfo("--- not self.markLockSign ---")
        return
    end

    if self.markLockAni == nil then
        printInfo("error markLockAni not null")
        return
    end

    self.markLockSign = false

    self.markLockAni:setAnimation("end", false)
end


function SkillButton:pause()
    self.isPause = true
end

function SkillButton:resume()
    self.isPause = false
end

function SkillButton:clickUseSkill()
    GameManager:setAutoBattleStatus(false)
    onActiveUseSkillHandler(self)
end

function SkillButton:autoUseSkill()
    onActiveUseSkillHandler(self)
end

function SkillButton:wasDirectSkill()
    return self._isDirection
end

function SkillButton:getSkillGroupID()
    if self._skillGroupID then 
        return self._skillGroupID
    else
        local skillGroupID = SkillDataManager:getSkillGroupIDBySKillID(self:getSkillID() or 0)
        return skillGroupID
    end
end
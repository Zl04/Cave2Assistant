--[[
    BOSS新的渲染器，用于后期对于boss的多个阶段做一个统一的逻辑处理。
    我们目前已经有三种特殊（不包含普通的表现）boss的表现形式：
    （1）变身的表现融合到

    主要有以下两个功能：
    1. 通过切换boss的模板数据来切换动画表现
    2. 通过boss的未激活状态来模拟一个场景状态

    和以前boss最大的区别，这里的boss不会存在状态回退。
]]--

require "app.renderer.RoleRenderer"
local SceneManager = require("app.game.SceneManager")

Renderer = Renderer or {}

local BossNewsRenderer = class("BossNewsRenderer", Renderer.RoleRenderer)
Renderer.BossNewsRenderer = BossNewsRenderer

-- private:
local winSize = cc.Director:getInstance():getWinSize()

local DEBUG = false

local DEAD_NANIMATION_NAME = "dead"

-- public:
-- 初始化
function BossNewsRenderer:init(skeletonFile, atlasFile, scale, params)
    if(DEBUG) then
        print("BossNewsRenderer:init ", skeletonFile, atlasFile, scale, params)
    end
    BossNewsRenderer.super.init(self, skeletonFile, atlasFile, scale, RoleType.Monster, true)

    --  decorationId, toRemoveDecoration, toRemoveSelf,rare,monsterSubType,isTrigger, coordX, coordY

    self._decorationId = params.decorationId
    self._toRemoveDecoration = params.toRemoveDecoration
    self._toRemoveSelf = params.toRemoveSelf
    self._rare = params.rare

    self._isTransfor = params.isTransform
    self._isTurnAround = params.isTurnAround
    self._isInactive = params.isWaked

    self._coordX = params.coordX
    self._coordY = params.coordY

    self._appear = false
    self._transforRecover = false
    self._transforing = false;
    self._labelPos = params.labelPos

    self._monsterData = params.monsterData
    self._isRemoveSelf = false
    -- self._deathEntityAnimation = nil

    if(self._isTransfor) then
        -- self:showAttackIDLE()
        self:showTransforEndAnimation()
    else
        -- self:idle()
        self:showSleep()
    end

    local name = params.name or "DEADBEEF"
    self._transSkeletonFile = params.transSkeletonFile
    self._transAtlasFile = params.transAtlasFile
    self._transScale = params.transScale

    self.nickNameLabel = UI.Text:create()
    self.nickNameLabel:init(name, UI.FONT_ARIAL, UI.FONT_SIZE_26PX, UI.FONT_COLOR_WHITE)
    self.nickNameLabel:setVisible(false)
    self._viewNode:addChild(self.nickNameLabel, 100)
    self:_refreshNickNamePosition()

    self:_registerSpineEventHandler()

    self:refreshLockShow()
end

function BossNewsRenderer:statusChange(changeTemplateID, transSkeletonFile, transAtlasFile, transScale, isWaked)
    -- changeTemplateID 处理表现切换
    -- print("BossNewsRenderer:statusChange", changeTemplateID, transSkeletonFile, transAtlasFile, transScale, isWaked)
    if(changeTemplateID) then
        self._transSkeletonFile = transSkeletonFile
        self._transAtlasFile = transAtlasFile
        self._transScale = transScale
        -- 这里等待切换完状态后再赋值
        self._waitingIsWaked = isWaked
        self._transforing = true
        -- print("BossNewsRenderer:statusChange 2=", self._isInactive, self:getAnimationPre().."transfor")
        if(self._isInactive == true) then
            self._roleAnimation:setAnimation(0, self:getAnimationPre().."transfor", false)
        else
            -- 处于为未解锁状态
            self._roleAnimation:setAnimation(0, self:getAnimationPre().."end", false)
            self._roleAnimation:addAnimation(0, self:getAnimationPre().."transfor", false)
        end
    else
        -- isWaked 处理锁定状态切换
        if(self._isInactive ~= isWaked) then 
            self._isInactive = isWaked
            self:refreshLockShow()
        end
    end
end

function BossNewsRenderer:refreshLockShow()
	require "app.datas.MasterDataManager"

    if not self.lockBossBack then
        local lockBossBack = Avalon.Animation:create("effect_role_npc_treasure_seal.json", "effect_role_npc_treasure_seal.atlas", 1);
        local lockBossUp = Avalon.Animation:create("effect_role_npc_treasure_seal.json", "effect_role_npc_treasure_seal.atlas", 1);
        self:addChild(lockBossBack, ROLE_ANIMATION_ZORDER -2)
        self:addChild(lockBossUp, ROLE_ANIMATION_ZORDER +1)

        self:handleAddAnimation(lockBossBack)
        self:handleAddAnimation(lockBossUp)

        lockBossBack:setAnimation(0,"idle_down", true)
        lockBossUp:setAnimation(0,"idle", true)
        self.lockBossUp = lockBossUp
        self.lockBossBack = lockBossBack
    end

    if self._isInactive then
        -- self.lockBossBack:setAnimation(0,"open_down", false)
        -- self.lockBossUp:setAnimation(0,"open1", false)
        self.lockBossBack:removeFromParent()
        self.lockBossUp:removeFromParent()

        self.lockBossUp = nil
        self.lockBossBack = nil
    end
end

function BossNewsRenderer:showSleep()
    if(DEBUG) then
        print("BossNewsRenderer:showSleep ")
    end

    if(self._isInactive == false) then
        print("BossNewsRenderer:showSleep",  self:getAnimationPre().."begin")
        self._roleAnimation:setAnimation(0, self:getAnimationPre().."begin", false)
        self._roleAnimation:addAnimation(0, self:getAnimationPre().."idle", true)
    else
        print("BossNewsRenderer:showSleep",  "idle1")
        self._roleAnimation:setAnimation(0, "idle1", true)
    end
end

-- 显示出场动画
function BossNewsRenderer:showAppear()
    if(DEBUG) then
        print("BossNewsRenderer:showAppear ")
    end
    self._appear = true
    self._roleAnimation:setAnimation(0, self:getAnimationPre().."begin2", false)
    self._roleAnimation:addAnimation(0, self:getAnimationPre().."idle1", true)
end

-- 显示待机动画
function BossNewsRenderer:showIDLE(judgeNeedToTrigger, isTrigger)
    if(DEBUG) then
        print("BossNewsRenderer:showIDLE ", judgeNeedToTrigger, isTrigger)
        print(debug.traceback())
    end
    if(self._transforing) then 
        return
    end
    self:removeWeaponAnimation()
    self:clearSkillFX()
    self:clearAllActAnimation()
    self:clearAllAssistActAnimation()
    
    self._roleAnimation:setToSetupPose()
    if(self._appear) then
        self._roleAnimation:setAnimation(0, self:getAnimationPre().."idle1", true)
    else
        if(judgeNeedToTrigger) then
            if(isTrigger) then
                self:showSleep()
            end
        else 
            self._roleAnimation:setAnimation(0, self:getAnimationPre().."idle1", true)
        end
    end
end

-- 获取待机动画名字
function BossNewsRenderer:getIDLEAnim()
    return "idle1"
end

-- 获取动画的前缀
function BossNewsRenderer:getAnimationPre()
    if(self._isInactive == false) then
        return "inactivated_"
    end

    return ""
end

function BossNewsRenderer:getAttackIdleAnimationName()

    return self:getIDLEAnim()
end

-- 显示移动动画
function BossNewsRenderer:showMove()
    self._roleAnimation:setAnimation(0, self:getAnimationPre().."move", true)
end

-- 显示攻击动画
function BossNewsRenderer:showAttack()
    if(self._transforing) then 
        return
    end
    if(self._transforRecover ~= true) then
        if(self._isTransfor) then
            if self._transSkeletonFile then
                self._roleAnimation:setToSetupPose()
                self._roleAnimation:setAnimation(0, self:getAnimationPre().."attack", false)
                self._roleAnimation:addAnimation(0, self:getAnimationPre().."idle1", true)
            end
        else
            self._roleAnimation:setToSetupPose()
            self._roleAnimation:setAnimation(0, self:getAnimationPre().."attack", false)
            self._roleAnimation:addAnimation(0, self:getAnimationPre().."idle1", true)
        end
    end
end

-- 屏蔽相关处理
function BossNewsRenderer:showNormalSkill(animName, weaponAnim, speedUp)
    if(animName == nil) then 
        return
    end
    if(self._transforRecover ~= true) then
        if(self._isTransfor == false) then
            BossNewsRenderer.super.showNormalSkill(self, self:getAnimationPre()..animName, weaponAnim, speedUp)
        elseif self._transSkeletonFile then
            BossNewsRenderer.super.showNormalSkill(self, self:getAnimationPre()..animName, weaponAnim, speedUp)
        end
    end
end

function BossNewsRenderer:showReleaseSkill(animName, weaponAnim)
    if(animName == nil) then 
        return
    end
    if(self._transforRecover ~= true) then
        if(self._isTransfor == false) then
            BossNewsRenderer.super.showReleaseSkill(self, self:getAnimationPre()..animName, weaponAnim)
        elseif self._transSkeletonFile then
            BossNewsRenderer.super.showReleaseSkill(self, self:getAnimationPre()..animName, weaponAnim)
        end
    end
end

-- 显示完成技能动画
function BossNewsRenderer:showFinishSkill(animName)
    if(animName == nil) then 
        return
    end
    if(animName) then
        if(self._transforRecover ~= true) then
            if(self._isTransfor == false) then
                BossNewsRenderer.super.showFinishSkill(self, self:getAnimationPre()..animName)
            elseif self._transSkeletonFile then
                BossNewsRenderer.super.showFinishSkill(self, self:getAnimationPre()..animName)
            end
        end
    end
end

-- 显示复活动画
function BossNewsRenderer:showRevive()
    self:removeWeaponAnimation()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setVisible(true)
    self._roleAnimation:setTimeScale(1.0)
    self:frozenRecover()
    self._roleAnimation:setAnimation(0, "revive", false)
    self._roleAnimation:addAnimation(0, "idle1", true)
    self:_reviveEffect()

    if self._deathEntityAnimation then
        self._deathEntityAnimation:runAction(cc.Sequence:create(cc.RemoveSelf:create(),cc.CallFunc:create(function()
            self._deathEntityAnimation = nil
        end)))
    end

end

function BossNewsRenderer:_reviveEffect()
    local reviveEffect = Avalon.Animation:create("effect_role_hero_revive.json", "effect_role_hero_revive.atlas", 1.0);
    reviveEffect:setAnimation(0,"idle",false)

    reviveEffect:registerSpineEventHandler(function(event)
        --print("HeroRenderer:_reviveEffect end animation=",event.animation)
        if event.animation == "idle" then
             reviveEffect:runAction(cc.RemoveSelf:create())
        end
    end, sp.EventType.ANIMATION_END)

    reviveEffect:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- TODO 播放音效文件
                local soundFilename = string.sub(event.eventData.name,7,-1)
                Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
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
    end, sp.EventType.ANIMATION_EVENT)

    self:addChild(reviveEffect, ROLE_ANIMATION_BOTTOM)
end

-- 显示死亡动画
function BossNewsRenderer:showDie(_,_,_,hitratMonsterRefresh,isRemoveSelf)
    self:clearAllFX()
    self:removeWeaponAnimation()
    -- 避免出现恢复到最初状态
    if(self._isTransfor == false) then
        self._roleAnimation:setToSetupPose()
    elseif self._transSkeletonFile then
        self._roleAnimation:setToSetupPose()
    end
    self._roleAnimation:setTimeScale(1.0)
    self:frozenRecover()
    self._isRemoveSelf = isRemoveSelf
    self._roleAnimation:setAnimation(0, DEAD_NANIMATION_NAME, false)
end

-- 显示攻击中的待机动画
function BossNewsRenderer:showAttackIDLE()
    if(DEBUG) then
        print("BossNewsRenderer:showAttackIDLE ")
    end 
    if(self._transforing) then 
        return
    end
    if(self._transforRecover ~= true) then
        if(self._isTransfor) then
            if self._transSkeletonFile then
                if(self._transforRecover ~= true) then
                    self._roleAnimation:setToSetupPose()
                    self._roleAnimation:setAnimation(0, self:getAnimationPre().."idle1", true)
                end
            end
        else
            if(self._transforRecover ~= true) then
                self._roleAnimation:setToSetupPose()
                self._roleAnimation:setAnimation(0, self:getAnimationPre().."idle1", true)
            end
        end
    end
end

function BossNewsRenderer:showTransforEndAnimation()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setAnimation(0, "transfor_skill1", true)
end

-- 显示变身动画
function BossNewsRenderer:showTransfor()
    print("-----showTransfor-------", self._isTransfor)
    if(self._isTransfor == false) then
        self._isTransfor = true
        if(DEBUG) then
            print("BossNewsRenderer:showTransfor ")
        end
        -- if self._transSkeletonFile then
        --     self._transforRecover = true
        --     self._roleAnimation:setToSetupPose()
        --     self._roleAnimation:setAnimation(0, "transfor", false)
        -- else
        --     self._roleAnimation:setToSetupPose()
        --     self._roleAnimation:setAnimation(0, "transfor", false)
        --     self._roleAnimation:addAnimation(0, "transfor_skill1", true)
        -- end
    end
end

-- 显示变身后回到第一形态
function BossNewsRenderer:showTransforRecover()
    printError("BossNewsRenderer:showTransforRecover ", self._isTransfor)
    -- if(self._isTransfor) then
    --     if(DEBUG) then
    --         print("BossNewsRenderer:showTransforRecover ")
    --     end
    --     if self._transSkeletonFile then
    --         self._roleAnimation:setToSetupPose()
    --         self._roleAnimation:setAnimation(0, "transfor_recovery_2", false)
    --     else
    --         self._roleAnimation:setToSetupPose()
    --         self._roleAnimation:setAnimation(0, "transfor_recovery", false)
    --         self._roleAnimation:addAnimation(0, "idle1", true)
    --     end
    --     self._isTransfor = false
    --     self._transforRecover = true
    -- end
end

function BossNewsRenderer:addName(spriteID)
    if DEVELOPMENT_MODE then
        require "app.ui.gmUtil.GMUtilExecutor"
        if (UI.GMUtilExecutor:getShowTestUI()) then
            self.testTitleLabel = cc.Label:createWithSystemFont(string.format("%d",spriteID), "Arial", 20)
            self.testTitleLabel:setPosition(cc.p(0, 170))
            self._viewNode:addChild(self.testTitleLabel,100)
        end
    end
end

function BossNewsRenderer:setGuildBossName(name, weaknessType)
    if DEBUG then
        print("MonsterRenderer:setGuildBossName ",name, weaknessType)
    end

    self.guildBossLabel = UI.Text:create()
    self.guildBossLabel:init(name, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_223_117_22)
    self.guildBossLabel:centerBottom(140)
    -- self.guildBossLabel:setVisible(true)
    self._viewNode:addChild(self.guildBossLabel, 100)

    local weakSpriteName = ToolsUtil:getWeakSpriteName(weaknessType)
    if(weakSpriteName and weakSpriteName ~= "") then 
        local weakBgImage = UI.Image:create()
        weakBgImage:init("ui_common_symbol_weakness.png")
        weakBgImage:centerRight(-weakBgImage:getContentSize().width)
        self.guildBossLabel:addChild(weakBgImage)

        local weakImage = UI.Image:create()
        weakImage:init("symbol_monsterattribute_dark_2.png")
        weakImage:center()
        weakBgImage:addChild(weakImage)
        weakImage:setSpriteName(weakSpriteName)
    end
        
    self:_refreshNickNamePosition()
end

-- 处理更新名字显示
function BossNewsRenderer:updateName(name, isShow, isMaster, color)
    if DEBUG then
        print("MonsterRenderer:updateName ",name,isShow,color)
    end
    if (isShow == nil) then isShow = true end

    if (name) then self.nickNameLabel:setText(name) end
    if (color) then self.nickNameLabel:setFontColor(color) end
    if (isShow ~= nil and self._isShowName ~= isShow) then
        self._isShowName = isShow
        self.nickNameLabel:stopAllActions()
        if (isShow) then
            self.nickNameLabel:setVisible(true)
            self.nickNameLabel:runAction(cc.FadeIn:create(0.096))
        else
            self.nickNameLabel:runAction(cc.Sequence:create(
                cc.FadeOut:create(0.096),
                cc.CallFunc:create(function() self.nickNameLabel:setVisible(false) end)
            ))
        end
    end

    if(self.testTitleLabel) then
        self.testTitleLabel:setVisible(isShow)
    end
end

function BossNewsRenderer:_registerSpineEventHandler()
    self._roleAnimation:registerSpineEventHandler(function (event)
        -- if(DEBUG) then
            print(string.format("BossNewsRenderer:_registerSpineEventHandler[spine] %d end  animation=",event.trackIndex),event.animation)
        -- end
        
        if event.animation == DEAD_NANIMATION_NAME and not self._isRemoveSelf then -- 死亡动画播放完成
            self:_triggerRemoveSelf()
        elseif(event.animation == self:getAnimationPre().."transfor") then --变身
            print("_registerSpineEventHandler", self._transSkeletonFile, self._isInactive, self._waitingIsWaked)
            self._transforing = false
            
            if self._transSkeletonFile then
                local tempAnim = Avalon.Animation:create(self._transSkeletonFile, self._transAtlasFile, self._transScale)            
                self:addChild(tempAnim, ROLE_ANIMATION_ZORDER)
                self:handleAddAnimation(tempAnim)

                -- 添加了挂载点扩展
                self._mountBottomDown = cc.Node:create()
                self._mountBottomUp = cc.Node:create()
                self:addChild(self._mountBottomDown, ROLE_ANIMATION_BOTTOM_DOWN)
                self:addChild(self._mountBottomUp, ROLE_ANIMATION_BOTTOM)
                self._roleAnimation:runAction(cc.RemoveSelf:create())
                self._roleAnimation = tempAnim
                self:setDirection(self._direction)

                -- isWaked 处理锁定状态切换
                if(self._isInactive ~= self._waitingIsWaked) then 
                    self._isInactive = self._waitingIsWaked
                end
                self:refreshLockShow()
                
                if(self._isInactive == false) then
                    tempAnim:setAnimation(0, self:getAnimationPre().."begin", false)
                    tempAnim:addAnimation(0, self:getAnimationPre().."idle", true)
                else
                    tempAnim:setAnimation(0, "idle1", true)
                end
                self:_registerSpineEventHandler()
            end
            -- self._transforRecover = false
            -- if self._isTransfor == false and self._transSkeletonFile then
            --     self._roleAnimation:setToSetupPose()
            --     self._roleAnimation:setAnimation(0, "transfor_recovery_2", false)
            --     self._transforRecover = true
            -- end
        -- elseif(event.animation == "transfor_recovery_2") then --变身返回
        --     if self._transSkeletonFile then
        --         local tempAnim = Avalon.Animation:create(self._skeletonFile, self._atlasFile, self._scale)
        --         self:addChild(tempAnim, ROLE_ANIMATION_ZORDER)
        --         self:handleAddAnimation(tempAnim)

        --         -- 添加了挂载点扩展
        --         self._mountBottomDown = cc.Node:create()
        --         self._mountBottomUp = cc.Node:create()
        --         self:addChild(self._mountBottomDown, ROLE_ANIMATION_BOTTOM_DOWN)
        --         self:addChild(self._mountBottomUp, ROLE_ANIMATION_BOTTOM)
        --         self._roleAnimation:runAction(cc.RemoveSelf:create())
        --         self._roleAnimation = tempAnim
        --         self._roleAnimation:setAnimation(0, "transfor_recovery", false)
        --         self._roleAnimation:addAnimation(0, "idle1", true)
        --         self:_registerSpineEventHandler()
        --     end
        --     self._transforRecover = false
        --     self._isTransfor = false
        -- elseif(event.animation == "transfor_recovery") then -- 旧逻辑变身返回（盖亚）
        --     self._transforRecover = false
        --     self._isTransfor = false
        end
    end, sp.EventType.ANIMATION_END)

    -- self._roleAnimation:registerSpineEventHandler(function (event)

    -- end, sp.EventType.ANIMATION_START)

    -- self._roleAnimation:registerSpineEventHandler(function (event)
    --     if(event and event.eventData and event.eventData.name) then
    --         local startPos = string.find(event.eventData.name, "sound_")
    --         if(startPos ~= nil) then
    --             local soundFilename = string.sub(event.eventData.name,7,-1)
    --             Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
    --         end
    --     end
    -- end, sp.EventType.ANIMATION_EVENT)

    -- self._roleAnimation:registerSpineEventHandler(function (event)
    --     if(event and event.eventData and event.eventData.name) then
    --         local startPos = string.find(event.eventData.name, "die")
    --         if(startPos ~= nil) then
    --             -- TODO 播放墓碑动画
    --             if self._monsterData and self._monsterData.tombstoneAnimation ~= "" then
    --                 local deathEntityAnimation = Avalon.Animation:create(self._monsterData.tombstoneAnimation .. ".json", self._monsterData.tombstoneAnimation .. ".atlas", 1);
    --                 self:addChild(deathEntityAnimation)
    --                 deathEntityAnimation:setAnimation(0,"begin",false)
    --                 deathEntityAnimation:addAnimation(0,"idle",true)
    --                 self._deathEntityAnimation = deathEntityAnimation
    --             end
    --         end

    --     end
    -- end, sp.EventType.ANIMATION_EVENT)

    self:_registerRoleSpineEventHandle()
end

-- 添加精英怪得表现
function BossNewsRenderer:_addEliteView()
    -- 判断是否为精英怪
    local isElite = false
    if (self._rare ~= 0) then
        isElite = true
    end
    if(DEBUG) then
        print("BossNewsRenderer:_addEliteView ",self._rare)
    end
    if isElite then
        self._eliteBack = Avalon.Animation:create("effect_role_monster_elitemonster.json", "effect_role_monster_elitemonster.atlas", 1);
        self._eliteSurface = Avalon.Animation:create("effect_role_monster_elitemonster.json", "effect_role_monster_elitemonster.atlas", 1);
        
        self._roleAnimation:setSpineZOrder(2)
        self._roleAnimation:addComponent("mount_bottomdown",self._eliteBack)
        self._roleAnimation:addComponent("mount_bottom",self._eliteSurface)

        self:handleAddAnimation(self._eliteBack)
        self:handleAddAnimation(self._eliteSurface)

        self._eliteBack:setAnimation(0,"idle2",true)
        self._eliteSurface:setAnimation(0,"idle1",true)

        self._eliteBack:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- TODO 播放音效文件
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
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
        end, sp.EventType.ANIMATION_EVENT)

        self._eliteSurface:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- TODO 播放音效文件
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
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
        end, sp.EventType.ANIMATION_EVENT)
    end
end

function BossNewsRenderer:_endEliteView()
    if self._eliteBack then
        self._eliteBack:setAnimation(0,"end2",false)
    end
    if self._eliteSurface then
        self._eliteSurface:setAnimation(0,"end1",false)
    end
end

-- 触发移除自己
function BossNewsRenderer:_triggerRemoveSelf()
    local removeSelf = self._toRemoveSelf
    -- TODO 根据数值判断是否移除自己
    if (DEBUG) then
        print("BossNewsRenderer:_triggerRemoveSelf ",removeSelf)
    end

    self:_triggerDecorationsRemove()

    if(self.nickNameLabel) then 
        self.nickNameLabel:setVisible(false)
    end
    if(self.guildBossLabel) then 
        self.guildBossLabel:setVisible(false)
    end

    if self._deathEntityAnimation then
        self._deathEntityAnimation:runAction(cc.Sequence:create(cc.RemoveSelf:create(),cc.CallFunc:create(function()
            self._deathEntityAnimation = nil
        end)))
    end

    if removeSelf then
        self:remove()
    else
        if self._eliteBack then
            self._eliteBack:runAction(cc.RemoveSelf:create())
            self._eliteBack = nil
        end
        if self._eliteSurface then
            self._eliteSurface:runAction(cc.RemoveSelf:create())
            self._eliteSurface = nil
        end
    end
end

function BossNewsRenderer:_triggerDecorationsRemove()
    -- 
    if(self._toRemoveDecoration and self._decorationId ~= 0) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initRemoveDecoration(nil, self._coordX, self._coordY, self._decorationId)
        SceneManager:getInstance():pushCommand(renderCommand)
    end
end

-- 触发加载动画完成
function BossNewsRenderer:_triggerLoadSpineSuccess()
    BossNewsRenderer.super._triggerLoadSpineSuccess(self)

    -- TODO 更新spriteID显示位置
    self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(function()
        self:_refreshNickNamePosition()

        local size = self._roleAnimation:getBoundingBox()
        self.setRoleAnimationSize(size)

        if self.testTitleLabel then
            local size = self._roleAnimation:getBoundingBox()
            self.testTitleLabel:setPosition(cc.p(0, size.height+10))
        end
    end)))

end

function BossNewsRenderer:setVisible( visible )
    BossNewsRenderer.super.setVisible(self,visible)

    if self._eliteBack then
        self._eliteBack:setVisible(visible)
    end
    if self._eliteSurface then
        self._eliteSurface:setVisible(visible)
    end
    -- print("BossNewsRenderer.setVisible",visible)
end

function BossNewsRenderer:_refreshNickNamePosition()
    if(self.nickNameLabel) then
        if (self._labelPos) then
            self.nickNameLabel:leftBottom(self._labelPos.x, self._labelPos.y)
        else
            self.nickNameLabel:centerBottom(-85)
        end
    end 

    local size = nil
    if(self.guildBossLabel) then
        if(self._deformationAniamtion) then
            size = self._deformationAniamtion:getBoundingBox()
        else 
            if(self._roleAnimation) then
                size = self._roleAnimation:getBoundingBox()
            end 
        end
    end

    if(self.guildBossLabel) then 
        if(size) then
            if (size.height > 200) then size.height = 200 end
            self.guildBossLabel:centerBottom(size.height+10)
        end
    end
end

function BossNewsRenderer:pause()
    BossNewsRenderer.super.pause(self)
    local arr = self:getAllAnimation()
    for k, v in ipairs(arr) do 
        if(not tolua.isnull(v)) then 
            v:pause()
        end
    end
end

function BossNewsRenderer:resume()
    BossNewsRenderer.super.resume(self)
    local arr = self:getAllAnimation()
    for k, v in ipairs(arr) do 
        if(not tolua.isnull(v)) then 
            v:resume()
        end
    end
end

function BossNewsRenderer:getAllAnimation()
    local arr = {}
    if(not tolua.isnull(self._eliteBack)) then 
        table.insert(arr, self._eliteBack)
    end
    if(not tolua.isnull(self._eliteSurface)) then 
        table.insert(arr, self._eliteSurface)
    end

    return arr
end
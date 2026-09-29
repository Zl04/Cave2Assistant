--[[
    怪物的渲染器
]]--

require "app.renderer.RoleRenderer"
local SceneManager = require("app.game.SceneManager")

Renderer = Renderer or {}

local MonsterRenderer = class("MonsterRenderer", Renderer.RoleRenderer)
Renderer.MonsterRenderer = MonsterRenderer

-- private:
local DEBUG = false

local DEAD_NANIMATION_NAME = "dead"
local AUTO_DEAD_NANIMATION_NAME = "auto_dead"

-- public:
-- 初始化
function MonsterRenderer:init(skeletonFile, atlasFile, scale, params)
    -- print("MonsterRenderer:init ", decorationId, toRemoveDecoration, toRemoveSelf,rare, coordX, coordY)
    MonsterRenderer.super.init(self, skeletonFile, atlasFile, scale, RoleType.Monster, false)

    self._decorationId = params.decorationId
    self._toRemoveDecoration = params.toRemoveDecoration
    self._toRemoveSelf = params.toRemoveSelf
    self._rare = params.rare
    self.monsterType = params.monsterType
    self.monsterSubType = params.monsterSubType
    self.isTrigger = params.isTrigger

    self._idleNum = 0
    self._isRemoveSelf = false
    -- self._deathEntityAnimation = nil

    self._monsterData = params.monsterData

    self._coordX = params.coordX
    self._coordY = params.coordY
    self._holidayNum = 1
    -- add by zp 用于处理节假日的功能，这个只处理触发宝箱怪的动画
    self._isHoliday = false
    -- 新春版本去掉该功能
    -- if(skeletonFile == "role_monster_mimic.json" or skeletonFile == "role_monster_mimic2.json") then 
    --     self._isHoliday = true
    -- end
    if(self._isHoliday) then 
        self._holidayNum = math.random(1, 3)
    end

    self._deformationAniamtion = nil

    -- self._skeletonFile = skeletonFile
    -- self._atlasFile = atlasFile

    self._isTransfor = params.isTransform
    if(self._isTransfor) then
        self:showTransforEndAnimation()
    end
    self._transSkeletonFile = params.transSkeletonFile or nil
    self._transAtlasFile = params.transAtlasFile or nil
    self._transScale = params.transScale or nil

    if self.monsterSubType == 1 or self.monsterSubType == 2 then
        if self.isTrigger then
            self:idle()
            self:showHoliday()
        else
            self:showSleep()
        end
    else
        if self.monsterSubType == 3 then
            self:showHitRatComming()
        else
            self:idle()
        end
    end

    self._name = params.name or "DEADBEEF"
    self.nickNameLabel = UI.Text:create()
    self.nickNameLabel:init(self._name, UI.FONT_ARIAL, UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
    self.nickNameLabel:centerBottom(140)
    self.nickNameLabel:setVisible(false)
    self._viewNode:addChild(self.nickNameLabel, 100)

    local groupSymbol = UI.Image:create()
    groupSymbol:init("ui_minimap_icon_blame03.png")
    groupSymbol:centerLeft(-40)
    self.nickNameLabel:addChild(groupSymbol, 101)
    groupSymbol:setVisible(self._monsterData:getIsGroupMonster())

    self:_addEliteView()
    self:_addSmallBossView()

    self:_registerSpineEventHandler()
    self:_registerTransSpineEventHandler()
end

function MonsterRenderer:showHoliday()
    -- print("MonsterRenderer:showHoliday", self._isHoliday, self._holidayNum)
    if(self._isHoliday and self._holidayBack == nil) then 
        local holidayBack = Avalon.Animation:create("effect_festival_christmas_snow.json", "effect_festival_christmas_snow.atlas", 1);
        local holidayUp = Avalon.Animation:create("effect_festival_christmas_snow.json", "effect_festival_christmas_snow.atlas", 1);

        -- self._roleAnimation:addComponent("mount_bottomdown", holidayBack)
        -- self._roleAnimation:addComponent("mount_bottom", holidayUp)

        self._holidayBack = holidayBack
        self._holidayUp = holidayUp
        self:handleAddAnimation(self._holidayBack)
        self:handleAddAnimation(self._holidayUp)
        self:addChild(holidayBack, ROLE_ANIMATION_ZORDER -1)
        self:addChild(holidayUp, ROLE_ANIMATION_ZORDER +1)

        -- local slotDownNode = self._roleAnimation:getNodeForSlot("mount_bottomdown")
        -- if(slotDownNode) then 
        --     holidayBack:setScaleX(slotDownNode:getScaleX())
        --     holidayBack:setScaleY(slotDownNode:getScaleY())

        --     holidayUp:setScaleX(slotDownNode:getScaleX())
        --     holidayUp:setScaleY(slotDownNode:getScaleY())
        -- end

        holidayBack:setAnimation(0,"begin_down", false)
        holidayBack:addAnimation(0,"idle_down", true)

        holidayUp:setAnimation(0,string.format("%d_begin_up", self._holidayNum), false)
        holidayUp:addAnimation(0,string.format("%d_idle_up", self._holidayNum), true)

        self._holidayBack:registerSpineEventHandler(function (event)
            if event.animation == "end_down" then
                if(not tolua.isnull(self._holidayBack)) then 
                    self._holidayBack:runAction(cc.RemoveSelf:create())
                    self._holidayBack = nil
                end 

                if(not tolua.isnull(self._holidayUp)) then 
                    self._holidayUp:runAction(cc.RemoveSelf:create())
                    self._holidayUp = nil
                end
            end
        end, sp.EventType.ANIMATION_END)
    end
end

function MonsterRenderer:removeHoliday()
    -- print("MonsterRenderer:removeHoliday", self._isHoliday, self._holidayNum)
    if(not tolua.isnull(self._holidayBack)) then 
        self._holidayBack:setAnimation(0,"end_down", false)
    end 

    if(not tolua.isnull(self._holidayUp)) then 
        self._holidayUp:setAnimation(0,string.format("%d_end_up", self._holidayNum), false)
    end
end

function MonsterRenderer:showNormalSkill(animName, weaponAnim, speedUp)
    MonsterRenderer.super.showNormalSkill(self, animName, weaponAnim, speedUp)
end

function MonsterRenderer:judgeShowBuff()
    if(self:judgeIsTrigger()) then
        return true
    end

    return false
end

function MonsterRenderer:judgeIsTrigger()
    if self.monsterSubType == 1 or self.monsterSubType == 2 then
        if self.isTrigger then
            return true
        else
            return false
        end
    else
        return true
    end
end

-- 显示待机动画
function MonsterRenderer:showIDLE()
    self:removeWeaponAnimation()
    self:clearSkillFX()
    self:clearAllActAnimation()
    self:clearAllAssistActAnimation()

    self._roleAnimation:setTimeScale(1.0)
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setAnimation(0, "idle1", true)
end

function MonsterRenderer:showHitRatComming()
    print("MonsterRenderer:show hit rat showing ")
    self._roleAnimation:setTimeScale(1.0)
    self._roleAnimation:setAnimation(0, "pre_idle", false)
    self._roleAnimation:addAnimation(0, "idle", true)
end


function MonsterRenderer:showSleep()
    print("MonsterRenderer:showSleep ")
    self._roleAnimation:setTimeScale(1.0)
    self._roleAnimation:setAnimation(0, "idle_fake1", true)
end


function MonsterRenderer:showTarget()
    self.isTrigger = true
    self:showHoliday()

    self._roleAnimation:setTimeScale(1.0)
    self._roleAnimation:setAnimation(0, "begin", false)
    self._roleAnimation:addAnimation(0, "idle1", true)

    self:_refreshEliteView()
    self:_refreshSmallBossView()

    self:refreshBuffShow()
end

-- 获取待机动画名字
function MonsterRenderer:getIDLEAnim()
    return "idle1"
end

function MonsterRenderer:getAttackIdleAnimationName()

    return self:getIDLEAnim()
end

-- 显示移动动画
function MonsterRenderer:showMove()
    self._roleAnimation:setAnimation(0, "move", true)
end

-- 显示攻击动画
function MonsterRenderer:showAttack()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setVisible(true)
    self:removeDeformation()
    self._roleAnimation:setAnimation(0, "attack", true)
    self._roleAnimation:addAnimation(0, "idle1", true)
end

-- 显示死亡动画
function MonsterRenderer:showDie(_,_,_,hitratMonsterRefresh,isRemoveSelf)
    self:clearAllFX()
    self:removeHoliday()
    self:removeWeaponAnimation()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setVisible(true)
    self:removeDeformation()
    self._roleAnimation:setTimeScale(1.0)
    self:frozenRecover()
    self._isRemoveSelf = isRemoveSelf
    if hitratMonsterRefresh then
        self._roleAnimation:setAnimation(0, AUTO_DEAD_NANIMATION_NAME, false)
    else
        self._roleAnimation:setAnimation(0, DEAD_NANIMATION_NAME, false)
    end
end

-- 显示复活动画
function MonsterRenderer:showRevive()
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

function MonsterRenderer:_reviveEffect()
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

-- 显示攻击中的待机动画
function MonsterRenderer:showAttackIDLE()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setAnimation(0, "idle1", true)
end

function MonsterRenderer:showTransforEndAnimation()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setAnimation(0, "transfor_skill1", true)
end

-- 显示变身动画
function MonsterRenderer:showTransfor()
    print("-----MonsterRenderershowTransfor-------", self._isTransfor)
    if(self._isTransfor == false) then
        self._isTransfor = true
        if(DEBUG) then
            print("MonsterRenderer:showTransfor ")
        end
        if self._monsterData:checkIsRandomChange() then
            local transSkeletonFile, transAtlasFile, transScale = self._monsterData:getTransformAnimation()
            self._transSkeletonFile = transSkeletonFile
            self._transAtlasFile = transAtlasFile
            self._transScale = transScale
        end
        if self._transSkeletonFile then
            self._transforRecover = true
            self._roleAnimation:setToSetupPose()
            self._roleAnimation:setAnimation(0, "transfor", false)
        else
            self._roleAnimation:setToSetupPose()
            self._roleAnimation:setAnimation(0, "transfor", false)
            self._roleAnimation:addAnimation(0, "transfor_skill1", true)
        end
    end
end

-- 显示变身后回到第一形态
function MonsterRenderer:showTransforRecover()
    print("MonsterRenderer:showTransforRecover ", self._isTransfor)
    if(self._isTransfor) then
        if(DEBUG) then
            print("MonsterRenderer:showTransforRecover ")
        end
        -- if self._transSkeletonFile then
        --     self._roleAnimation:setToSetupPose()
        --     self._roleAnimation:setAnimation(0, "transfor_recovery_2", false)
        -- end
        if self._transSkeletonFile then
            local tempAnim = Avalon.Animation:create(self._skeletonFile, self._atlasFile, self._scale)
            self:addChild(tempAnim, ROLE_ANIMATION_ZORDER)
            self:handleAddAnimation(tempAnim)

            self:showMonsterTransSmoke(0.4)

            -- 添加了挂载点扩展
            self._mountBottomDown = cc.Node:create()
            self._mountBottomUp = cc.Node:create()
            self:addChild(self._mountBottomDown, ROLE_ANIMATION_BOTTOM_DOWN)
            self:addChild(self._mountBottomUp, ROLE_ANIMATION_BOTTOM)
            self._roleAnimation:runAction(cc.RemoveSelf:create())
            self._roleAnimation = tempAnim
            self._roleAnimation:setAnimation(0, "idle1", true)
            -- self._roleAnimation:addAnimation(0, "idle1", true)
            self:_registerTransSpineEventHandler()
        end
        self._transforRecover = false
        self._isTransfor = false

        -- self._isTransfor = false
        -- self._transforRecover = true
    end
end

function MonsterRenderer:_registerTransSpineEventHandler()
    self._roleAnimation:registerSpineEventHandler(function (event)
        if(DEBUG) then
            print(string.format("MonsterRenderer:_registerSpineEventHandler[spine] %d end  animation=",event.trackIndex),event.animation, self._isTransfor)
        end
        
        if event.animation == DEAD_NANIMATION_NAME and not self._isRemoveSelf then -- 死亡动画播放完成
            self:_triggerRemoveSelf()
        elseif(event.animation == "transfor") then --变身
            if self._transSkeletonFile then
                local tempAnim = Avalon.Animation:create(self._transSkeletonFile, self._transAtlasFile, self._transScale)            
                self:addChild(tempAnim, ROLE_ANIMATION_ZORDER)
                self:handleAddAnimation(tempAnim)

                self:showMonsterTransSmoke(0.4)

                -- 添加了挂载点扩展
                self._mountBottomDown = cc.Node:create()
                self._mountBottomUp = cc.Node:create()
                self:addChild(self._mountBottomDown, ROLE_ANIMATION_BOTTOM_DOWN)
                self:addChild(self._mountBottomUp, ROLE_ANIMATION_BOTTOM)
                self._roleAnimation:runAction(cc.RemoveSelf:create())
                self._roleAnimation = tempAnim
                tempAnim:setAnimation(0, "transfor_2", false)
                tempAnim:addAnimation(0, "idle1", true)
                self:_registerTransSpineEventHandler()
            end
            self._transforRecover = false
            if self._isTransfor == false and self._transSkeletonFile then
                self._roleAnimation:setToSetupPose()
                self._roleAnimation:setAnimation(0, "transfor_recovery_2", false)
                self._transforRecover = true
            end
        elseif(event.animation == "transfor_recovery_2") then --变身返回
            if self._transSkeletonFile then
                local tempAnim = Avalon.Animation:create(self._skeletonFile, self._atlasFile, self._scale)
                self:addChild(tempAnim, ROLE_ANIMATION_ZORDER)
                self:handleAddAnimation(tempAnim)

                -- 添加了挂载点扩展
                self._mountBottomDown = cc.Node:create()
                self._mountBottomUp = cc.Node:create()
                self:addChild(self._mountBottomDown, ROLE_ANIMATION_BOTTOM_DOWN)
                self:addChild(self._mountBottomUp, ROLE_ANIMATION_BOTTOM)
                self._roleAnimation:runAction(cc.RemoveSelf:create())
                self._roleAnimation = tempAnim
                self._roleAnimation:setAnimation(0, "transfor_recovery", false)
                self._roleAnimation:addAnimation(0, "idle1", true)
                self:_registerTransSpineEventHandler()
            end
            self._transforRecover = false
            self._isTransfor = false
        elseif(event.animation == "transfor_recovery") then -- 旧逻辑变身返回（盖亚）
            self._transforRecover = false
            self._isTransfor = false
        end
    end, sp.EventType.ANIMATION_END)

    -- self:_registerRoleSpineEventHandle()
end

function MonsterRenderer:showDeformation(skeletonFile, atlasFile, scale, idleName, deformationIsMonster)
    if(skeletonFile == self._preDeformationSkeleton) then
        return 
    end
    
    if(self._deformationAniamtion) then
        self._deformationAniamtion:runAction(cc.RemoveSelf:create())
        self._deformationAniamtion = nil
    end
    self._preDeformationSkeleton = skeletonFile

    -- 添加变身特效
    self:addDeformationView()
    -- 
    self._roleAnimation:setVisible(false)
    self._deformationAniamtion = Avalon.Animation:create(skeletonFile, atlasFile, 1)
    self._deformationAniamtion:setAnimation(0, idleName, true)
    self:handleAddAnimation(self._deformationAniamtion)
    local direction = self._direction 
    
    if(self._isTurnAround) then
        if (direction == DirectionType.EAST or
            direction == DirectionType.SOUTH) then
            self._deformationAniamtion:setScaleX(-1)
        else
            self._deformationAniamtion:setScaleX(1)
        end
    end

    self._deformationAniamtion:registerSpineEventHandler(function (event)
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

    self:addChild(self._deformationAniamtion, ROLE_ANIMATION_ZORDER)

    
    self._deformationAniamtion:setLoadedSpineSuccessCallBack(function ()
        self._deformationAniamtion:runAction(cc.Sequence:create(cc.DelayTime:create(0.02),cc.CallFunc:create(function()
            self:_refreshNickNamePosition()
        end)))
    end)

    if(self._isElite and deformationIsMonster) then
        local eliteBack = Avalon.Animation:create("effect_role_monster_elitemonster.json", "effect_role_monster_elitemonster.atlas", 1);
        local eliteSurface = Avalon.Animation:create("effect_role_monster_elitemonster.json", "effect_role_monster_elitemonster.atlas", 1);
        self._eliteBack = eliteBack
        self._eliteSurface = eliteSurface
        self:handleAddAnimation(self._eliteBack)
        self:handleAddAnimation(self._eliteSurface)
        self._deformationAniamtion:addComponent("mount_bottomdown", eliteBack)
        self._deformationAniamtion:addComponent("mount_bottom", eliteSurface)

        eliteBack:setAnimation(0,"idle2",true)
        eliteSurface:setAnimation(0,"idle1",true)
    end

    if(self.monsterType == PublicDefine.MonsterType.LittleBoss and deformationIsMonster)  then 
        local smallBossBack = Avalon.Animation:create("effect_role_monster_bossmonster.json", "effect_role_monster_bossmonster.atlas", 1);
        local smallBossSurface = Avalon.Animation:create("effect_role_monster_bossmonster.json", "effect_role_monster_bossmonster.atlas", 1);

        self._smallBossBack = smallBossBack
        self._smallBossSurface = smallBossSurface
        self:handleAddAnimation(self._smallBossBack)
        self:handleAddAnimation(self._smallBossSurface)

        self._deformationAniamtion:addComponent("mount_bottomdown",smallBossBack)
        self._deformationAniamtion:addComponent("mount_bottom",smallBossSurface)

        smallBossBack:setAnimation(0,"idle2",true)
        smallBossSurface:setAnimation(0,"idle1",true)
    end
end

function MonsterRenderer:removeDeformation()
    self._isShowName = self._name 
    self.nickNameLabel:setText(self._name)

    self._preDeformationSkeleton = nil
    if(self._deformationAniamtion) then
        self._deformationAniamtion:runAction(cc.RemoveSelf:create())
        self._deformationAniamtion = nil

        -- 添加变身特效
        self:addDeformationView()
    end

    self:_refreshNickNamePosition()

    self._roleAnimation:setVisible(true)
end

function MonsterRenderer:addName(spriteID)
    if DEVELOPMENT_MODE then
        require "app.ui.gmUtil.GMUtilExecutor"
        if (UI.GMUtilExecutor:getShowTestUI()) then
            self.testTitleLabel = cc.Label:createWithSystemFont(string.format("%d",spriteID), "Arial", 20)
            self.testTitleLabel:setPosition(cc.p(0, 170))
            self._viewNode:addChild(self.testTitleLabel,100)
        end
    end
end

function MonsterRenderer:setGuildBossName(name, weaknessType)
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
function MonsterRenderer:updateName(name, isShow, isMaster, color)
    if DEBUG then
        print("MonsterRenderer:updateName ",name,isShow,color)
    end
    -- add by zp 有下面一段代码会导致开始名字都显示出来
    -- if (isShow == nil) then isShow = true end

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
        
        self:_refreshNickNamePosition()
    end

    if(self.testTitleLabel) then
        self.testTitleLabel:setVisible(isShow)
    end
end

function MonsterRenderer:_refreshNickNamePosition()
    local size = nil
    if(self.nickNameLabel or self.guildBossLabel) then
        if(self._deformationAniamtion) then
            size = self._deformationAniamtion:getBoundingBox()
        else 
            if(self._roleAnimation) then
                size = self._roleAnimation:getBoundingBox()
            end 
        end
    end

    if(self.nickNameLabel) then
        if(size) then
            if (size.height > 200) then size.height = 200 end
            self.nickNameLabel:centerBottom(size.height+10)
        end
    end 

    if(self.guildBossLabel) then 
        if(size) then
            if (size.height > 200) then size.height = 200 end
            self.guildBossLabel:centerBottom(size.height+10)
        end
    end
    if(self.clearImage and size) then
        self.clearImage:centerBottom(size.height / 2)
    end
end

function MonsterRenderer:_refreshSmallBossView()
    local isTrigger = self:judgeIsTrigger()

    if self._smallBossBack then
        self._smallBossBack:setVisible(isTrigger)
    end
    if self._smallBossSurface then
        self._smallBossSurface:setVisible(isTrigger)
    end
end

function MonsterRenderer:_refreshEliteView()
    local isTrigger = self:judgeIsTrigger()
    print(" MonsterRenderer:_refreshEliteVie", isTrigger, self.isTrigger)
    if self._eliteBack then
        self._eliteBack:setVisible(isTrigger)
    end
    if self._eliteSurface then
        self._eliteSurface:setVisible(isTrigger)
    end
end

function MonsterRenderer:_registerSpineEventHandler()
    self._roleAnimation:registerSpineEventHandler(function (event)
        -- print(string.format("MonsterRenderer:_registerSpineEventHandler[spine] %d end  animation=",event.trackIndex),event.animation)
        
        if (event.animation == DEAD_NANIMATION_NAME
            or event.animation == AUTO_DEAD_NANIMATION_NAME) and not self._isRemoveSelf
        then
            -- 死亡动画播放完成
            self:_triggerRemoveSelf()
        end
    end, sp.EventType.ANIMATION_END)

    self._roleAnimation:registerSpineEventHandler(function (event)

    end, sp.EventType.ANIMATION_START)

    self._roleAnimation:registerSpineEventHandler(function (event)
        -- print("MonsterRenderer:_registerSpineEventHandler ANIMATION_COMPLETE ", 
        --                       event.trackIndex, 
        --                       event.loopCount, event.animation)
        if(event.animation == "idle1") then
            if self._idleNum == nil then
                self._idleNum = 0
            end
            self._idleNum = self._idleNum + 1
            if(self._idleNum >3) then
                if math.random(1,4) <=1 then
                    -- print("MonsterRenderer:_registerSpineEventHandler ANIMATION_COMPLETE run idle2")
                    self._idleNum = 0
                    self._roleAnimation:setAnimation(0, "idle2", false)
                    self._roleAnimation:addAnimation(0, "idle1", true)
                end
            end
        end
    
    end, sp.EventType.ANIMATION_COMPLETE)

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

end

function MonsterRenderer:_addSmallBossView()
    if(self.monsterType == PublicDefine.MonsterType.LittleBoss)  then 
        self._smallBossBack = Avalon.Animation:create("effect_role_monster_bossmonster.json", "effect_role_monster_bossmonster.atlas", 1);
        self._smallBossSurface = Avalon.Animation:create("effect_role_monster_bossmonster.json", "effect_role_monster_bossmonster.atlas", 1);
        self:handleAddAnimation(self._smallBossBack)
        self:handleAddAnimation(self._smallBossSurface)
        self._roleAnimation:setSpineZOrder(2)
        self:selfAddComponent("mount_bottomdown",self._smallBossBack)
        self:selfAddComponent("mount_bottom",self._smallBossSurface)

        self._smallBossBack:setAnimation(0,"idle2",true)
        self._smallBossSurface:setAnimation(0,"idle1",true)

        self._smallBossBack:registerSpineEventHandler(function (event)
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

        self._smallBossSurface:registerSpineEventHandler(function (event)
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

        self:_refreshSmallBossView()
    end
end

-- 添加精英怪得表现
function MonsterRenderer:_addEliteView()
    -- 判断是否为精英怪
    local isElite = false
    self._isElite = false
    if (self._rare ~= 0) then
        isElite = true
        self._isElite = true
    end
    -- print("MonsterRenderer:_addEliteView ",self._rare)
    if isElite then
        self._eliteBack = Avalon.Animation:create("effect_role_monster_elitemonster.json", "effect_role_monster_elitemonster.atlas", 1);
        self._eliteSurface = Avalon.Animation:create("effect_role_monster_elitemonster.json", "effect_role_monster_elitemonster.atlas", 1);
        self:handleAddAnimation(self._eliteBack)
        self:handleAddAnimation(self._eliteSurface)
        self._roleAnimation:setSpineZOrder(2)
        self:selfAddComponent("mount_bottomdown",self._eliteBack)
        self:selfAddComponent("mount_bottom",self._eliteSurface)

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

        self:_refreshEliteView()
    end
end

function MonsterRenderer:_endEliteView()
    if not tolua.isnull(self._eliteBack) then
        self._eliteBack:setAnimation(0,"end2",false)
    end
    if not tolua.isnull(self._eliteSurface) then
        self._eliteSurface:setAnimation(0,"end1",false)
    end
end

function MonsterRenderer:_endSmallBossView()
    if not tolua.isnull(self._smallBossBack) then
        self._smallBossBack:setAnimation(0,"end2",false)
    end

    if not tolua.isnull(self._smallBossSurface) then
        self._smallBossSurface:setAnimation(0,"end1",false)
    end
end

-- 触发移除自己
function MonsterRenderer:_triggerRemoveSelf()
    local removeSelf = self._toRemoveSelf
    -- TODO 根据数值判断是否移除自己
    if (DEBUG) then
        print("MonsterRenderer:_triggerRemoveSelf ",removeSelf)
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

    self:_endEliteView()
    self:_endSmallBossView()

    if removeSelf then
        self:remove()
    else 
        -- 修改自己的层级
        if(self._viewNode) then
            self._viewNode:setZOrder(self._viewNode:getZOrder() - 4999)
        end

        if self._eliteBack and not tolua.isnull(self._eliteBack) then
            self._eliteBack:runAction(cc.RemoveSelf:create())
            self._eliteBack = nil
        end
        if self._eliteSurface and not tolua.isnull(self._eliteSurface) then
            self._eliteSurface:runAction(cc.RemoveSelf:create())
            self._eliteSurface = nil
        end

        if(self._smallBossBack and not tolua.isnull(self._smallBossBack)) then
            self._smallBossBack:runAction(cc.RemoveSelf:create())
            self._smallBossBack = nil
        end

        if(self._smallBossSurface and not tolua.isnull(self._smallBossSurface)) then
            self._smallBossSurface:runAction(cc.RemoveSelf:create())
            self._smallBossSurface = nil
        end
    end
end

function MonsterRenderer:_triggerDecorationsRemove()
    -- 
    if(self._toRemoveDecoration and self._decorationId ~= 0) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initRemoveDecoration(nil, self._coordX, self._coordY, self._decorationId)
        SceneManager:getInstance():pushCommand(renderCommand)
    end
end

-- 触发加载动画完成
function MonsterRenderer:_triggerLoadSpineSuccess()
    MonsterRenderer.super._triggerLoadSpineSuccess(self)
    self._triggerLoadSpineSuccess = true
    self:_triggerGray()

     -- 处理跳伤害的处理
    self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(function()
        local size = self._roleAnimation:getBoundingBox()
        self.setRoleAnimationSize(size)
    end)))

    -- -- 处理精英怪脚下表现
    -- if self._eliteBack then
    --     self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(function()
    --         local bottomSlot = self._roleAnimation:getNodeForSlot("mount_bottom")
    --         if bottomSlot then
    --             print("MonsterRenderer:init   self._eliteBack ",bottomSlot:getScaleX(),bottomSlot:getScaleY())
    --             self._eliteBack:setScaleX(bottomSlot:getScaleX())
    --             self._eliteBack:setScaleY(bottomSlot:getScaleY())
    --         end
    --     end)))
    -- end

    -- TODO 更新spriteID显示位置
    
    self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()
        local size = self._roleAnimation:getBoundingBox()
        if (size.height > 200) then size.height = 200 end
        self:_refreshNickNamePosition()
        if self.testTitleLabel then
            self.testTitleLabel:setPosition(cc.p(0, size.height+50))
        end
    end)))
end


function MonsterRenderer:setVisible( visible )
    MonsterRenderer.super.setVisible(self,visible)

    
    if self._eliteBack then
        self._eliteBack:setVisible(visible)
    end
    if self._eliteSurface then
        self._eliteSurface:setVisible(visible)
    end
    if self._deformationAniamtion then
        self._deformationAniamtion:setVisible(visible)
    end
    if self._smallBossBack then
        self._smallBossBack:setVisible(visible)
    end
    if self._smallBossSurface then
        self._smallBossSurface:setVisible(visible)
    end
    -- print("MonsterRenderer.setVisible",visible)
end

--被当作npc死亡
function MonsterRenderer:npcDead()
    -- if(self.clearImage == nil) then 
    --     local clearImage = UI.Image:create()
    --     clearImage:init("ui_guild_copy_clear.png")
    --     local size = self._roleAnimation:getBoundingBox()
    --     clearImage:centerBottom(size.height / 2)
    --     self.clearImage = clearImage
    --     self._viewNode:addChild(clearImage, 100)
    -- end
    -- self:_triggerGray()
end

function MonsterRenderer:_triggerGray()
    if(self._triggerLoadSpineSuccess and not tolua.isnull(self.clearImage)) then
        self._roleAnimation:setAnimation(0, "idle1", true)

        local glProgramState = AvalonUtil:getAnimationGrayGLProgramState()
        self._roleAnimation:setGLProgramState(glProgramState)
        self._roleAnimation:updateTime(0.01)
        self._roleAnimation:setTimeScale(0)
    end
end


function MonsterRenderer:showBossSealInfoUpdate()
	require "app.datas.MasterDataManager"
    -- MasterDataManager._curCaveBossInfoCache

    -- message NtfLittleBossSealInfoMessage
    -- {
    --     required uint32 spriteID = 1;   // 小Boss精灵ID
    --     required uint32 curScore = 2;   // 当前分数
    --     required uint32 wakeScore = 3;  // 唤醒分数
    -- }

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

    if MasterDataManager:isLittleBossInfoFull() then
        -- self.lockBossBack:setAnimation(0,"open_down", false)
        -- self.lockBossUp:setAnimation(0,"open1", false)
        self.lockBossBack:removeFromParent()
        self.lockBossUp:removeFromParent()

        self.lockBossUp = nil
        self.lockBossBack = nil
    end
end

function MonsterRenderer:pause()
    MonsterRenderer.super.pause(self)
    local arr = self:getAllAnimation()
    for k, v in ipairs(arr) do 
        if(not tolua.isnull(v)) then
            v:pause()
        end
    end
end

function MonsterRenderer:resume()
    MonsterRenderer.super.resume(self)
    local arr = self:getAllAnimation()
    for k, v in ipairs(arr) do 
        if(not tolua.isnull(v)) then
            v:resume()
        end
    end
end

function MonsterRenderer:getAllAnimation()
    local arr = {}
    if(not tolua.isnull(self._horcruxExteriorAnimation)) then 
        table.insert(arr, self._horcruxExteriorAnimation)
    end
    if(not tolua.isnull(self.lockBossUp)) then 
        table.insert(arr, self.lockBossUp)
    end
    if(not tolua.isnull(self.lockBossBack)) then 
        table.insert(arr, self.lockBossBack)
    end
    if(not tolua.isnull(self._smallBossBack)) then 
        table.insert(arr, self._smallBossBack)
    end
    if(not tolua.isnull(self._smallBossSurface)) then 
        table.insert(arr, self._smallBossSurface)
    end
    if(not tolua.isnull(self._eliteBack)) then 
        table.insert(arr, self._eliteBack)
    end
    if(not tolua.isnull(self._eliteSurface)) then 
        table.insert(arr, self._eliteSurface)
    end

    return arr
end
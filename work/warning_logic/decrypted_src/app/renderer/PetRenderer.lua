--[[
    怪物的渲染器
]]--

require "app.renderer.RoleRenderer"
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE
Renderer = Renderer or {}

local PetRenderer = class("PetRenderer", Renderer.RoleRenderer)
Renderer.PetRenderer = PetRenderer

-- private:
local DEBUG = false

local DEAD_NANIMATION_NAME = "dead"
local AUTO_DEAD_NANIMATION_NAME = "auto_dead"

-- 构造函数
function PetRenderer:ctor()
    PetRenderer.super.ctor(self)

    self._equipmentArr = {}
end

-- 析构函数
function PetRenderer:dtor()
    PetRenderer.super.dtor(self)

    self:clearEquipmentArrEffect()
end

function PetRenderer:clearEquipmentArrEffect()
    for _, arr in pairs(self._equipmentArr) do 
        if(arr and #arr) then 
            for k, animation in pairs(arr) do 
                if(not tolua.isnull(animation)) then
                    animation:runAction(cc.RemoveSelf:create())
                end
            end
        end
    end
    self._equipmentArr = {}
end

-- public:
-- 初始化
function PetRenderer:init(skeletonFile, atlasFile, scale, params)
    -- print("MonsterRenderer:init ", decorationId, toRemoveDecoration, toRemoveSelf,rare, coordX, coordY)
    PetRenderer.super.init(self, skeletonFile, atlasFile, scale, RoleType.Monster, false)
    self._idleNum = 0

    self._coordX = params.coordX
    self._coordY = params.coordY

    self.isTransform = 0
    self.heroData = nil
    self._weaponType = 1

    self._deformationAniamtion = nil
    self:idle()
 
    self.nickNameLabel = UI.Text:create()
    self.nickNameLabel:init(self._name, UI.FONT_ARIAL, UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
    self.nickNameLabel:centerBottom(140)
    self.nickNameLabel:setVisible(false)
    self._viewNode:addChild(self.nickNameLabel, 100)

    self:_registerSpineEventHandler()
end

-- 显示待机动画
function PetRenderer:showIDLE()
    self:removeWeaponAnimation()
    self:clearSkillFX()
    self:clearAllActAnimation()
    self:clearAllAssistActAnimation()

    self._roleAnimation:setTimeScale(1.0)
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setAnimation(0, "idle1", true)
end


function PetRenderer:setAnimationScale(scale)
    self:setScale(scale)
    -- add by zp  CO-15138【宠物】毛球名字字体比其他的都要大  大部分都是0.6的比例，毛球是1，导致大小有问题。
    if(self.nickNameLabel) then 
        self.nickNameLabel:setScale(0.6/scale)
    end
end

-- 获取待机动画名字
function PetRenderer:getIDLEAnim()
    return "idle1"
end

function PetRenderer:getAttackIdleAnimationName()

    return self:getIDLEAnim()
end

-- 显示移动动画
function PetRenderer:showMove()
    -- self._roleAnimation:setToSetupPose()
    self._roleAnimation:setAnimation(0, "move_0", true)
end

-- 显示攻击动画
function PetRenderer:showNormalSkill(animName, weaponAnim, speedUp)

    if self.isTransform == 1 and self.heroData then
        --狐仙变身为人时的动画
        local attackIdleName = string.format("attackidle_%d",self._weaponType)
        local attackName = string.format("attack_1_%d",self._weaponType)

        self._roleAnimation:setAnimation(0, attackName, false)
        -- 这里给每种攻击状态后都添加一个idle 动作
        self._roleAnimation:addAnimation(0, attackIdleName, true)

        if(weaponAnim and weaponAnim ~= "") then
            -- 播放刀光效果
            self._weaponAnimation = Avalon.Animation:create(weaponAnim..".json", weaponAnim..".atlas", self._scale);
            self._weaponAnimation:setUnloadResFlag(false)
            self._weaponAnimation:setAnimation(0, "release_skill", false)
            self._weaponAnimation:registerSpineEventHandler(function(event)
                if(self._weaponAnimation) then
                    self._weaponAnimation:runAction(cc.RemoveSelf:create())
                    self._weaponAnimation = nil
                end
            end, sp.EventType.ANIMATION_END)

            self._weaponAnimation:registerSpineEventHandler(function (event)
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
            -- 这里由于是刀光效果，所有这里没有使用共用的方式添加，不然会出现不旋转的情况
            self._roleAnimation:addComponent(MOUNT_BOTTOM_UP, self._weaponAnimation)

            if(self.isPause) then 
                Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
                    if(not tolua.isnull(self._weaponAnimation)) then
                        self._weaponAnimation:pause()
                    end
                end, 2)
            end
        end


        if(speedUp == nil) then
            speedUp = 1.0
        end

        self:speedUp(speedUp)
        
    else
        PetRenderer.super.showNormalSkill(self,animName, weaponAnim, speedUp) 
    end
end

-- 显示死亡动画
function PetRenderer:showDie()
    self:removeWeaponAnimation()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setVisible(true)
    self._roleAnimation:setTimeScale(1.0)
    self:frozenRecover()
    self:clearAllFX()
    self._roleAnimation:setAnimation(0, "fall_ready", false)
end

-- 显示复活动画
function PetRenderer:showRevive()
    if self:isRide() then
        return
    end
    self:removeWeaponAnimation()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setVisible(true)
    self._roleAnimation:setTimeScale(1.0)
    self:frozenRecover()
    self._roleAnimation:setAnimation(0, "fall_revive", false)
    self:_reviveEffect()
end

function PetRenderer:_reviveEffect()
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
function PetRenderer:showSkillAct()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setAnimation(0, "ready", false)
    self._roleAnimation:addAnimation(0, "loop", false)
    self._roleAnimation:addAnimation(0, "free", false)
end

-- 显示攻击中的待机动画
function PetRenderer:showAttackIDLE()
    self._roleAnimation:setToSetupPose()
    self._roleAnimation:setAnimation(0, "idle1", true)
end


function PetRenderer:addName(spriteID)
    if DEVELOPMENT_MODE then
        require "app.ui.gmUtil.GMUtilExecutor"
        if (UI.GMUtilExecutor:getShowTestUI()) then
            self.testTitleLabel = cc.Label:createWithSystemFont(string.format("%d",spriteID), "Arial", 20)
            self.testTitleLabel:setPosition(cc.p(0, 170))
            self._viewNode:addChild(self.testTitleLabel,100)
        end
    end
end

-- 处理更新名字显示
function PetRenderer:updateName(name, isShow, isMaster, color)
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

            self:hidePet(self:isRide())
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

function PetRenderer:_refreshNickNamePosition()
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


function PetRenderer:_registerSpineEventHandler()

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
        elseif (event.animation == "fall_ready") then
            self._roleAnimation:setAnimation(0, "fall_loop", false)
        end
    
    end, sp.EventType.ANIMATION_COMPLETE)
end

-- 触发移除自己
function PetRenderer:_triggerRemoveSelf()
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

    self:_endEliteView()
    self:_endSmallBossView()

    if removeSelf then
        self:remove()
    else 
        -- 修改自己的层级
        if(self._viewNode) then
            self._viewNode:setZOrder(self._viewNode:getZOrder() - 4999)
        end

        if self._eliteBack then
            self._eliteBack:runAction(cc.RemoveSelf:create())
            self._eliteBack = nil
        end
        if self._eliteSurface then
            self._eliteSurface:runAction(cc.RemoveSelf:create())
            self._eliteSurface = nil
        end

        if(self._smallBossBack) then
            self._smallBossBack:runAction(cc.RemoveSelf:create())
            self._smallBossBack = nil
        end

        if(self._smallBossSurface) then
            self._smallBossSurface:runAction(cc.RemoveSelf:create())
            self._smallBossSurface = nil
        end
    end
end

function PetRenderer:_triggerDecorationsRemove()
    -- 
    if(self._toRemoveDecoration and self._decorationId ~= 0) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initRemoveDecoration(nil, self._coordX, self._coordY, self._decorationId)
        SceneManager:getInstance():pushCommand(renderCommand)
    end
end

-- 触发加载动画完成
function PetRenderer:_triggerLoadSpineSuccess()
    PetRenderer.super._triggerLoadSpineSuccess(self)
    self._triggerLoadSpineSuccess = true
    self:_triggerGray()

     -- 处理跳伤害的处理
    self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(function()
        local size = self._roleAnimation:getBoundingBox()
        self.setRoleAnimationSize(size)
    end)))
    
    self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()
        local size = self._roleAnimation:getBoundingBox()
        if (size.height > 200) then size.height = 200 end
        self:_refreshNickNamePosition()
        if self.testTitleLabel then
            self.testTitleLabel:setPosition(cc.p(0, size.height+50))
        end
    end)))
end

function PetRenderer:setVisible( visible )
    PetRenderer.super.setVisible(self,visible)
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
end

function PetRenderer:showSelect()
    -- 处理显示选择表现
    if(self._selectHeroAnimation == nil) then
        self._selectHeroAnimation = Avalon.Animation:create("effect_role_hero_selected.json", "effect_role_hero_selected.atlas", 0.6)
        self._viewNode:addChild(self._selectHeroAnimation)

        self._selectHeroAnimation:registerSpineEventHandler(function (event)
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

        self._selectHeroAnimation:setAnimation(0, "selected", true)
    end
end

function PetRenderer:hideSelect()
    -- 处理隐藏选择表现
    if(self._selectHeroAnimation) then
        self._selectHeroAnimation:runAction(cc.RemoveSelf:create())
        self._selectHeroAnimation = nil
    end
end

function PetRenderer:_triggerGray()
    if(self._triggerLoadSpineSuccess and not tolua.isnull(self.clearImage)) then
        self._roleAnimation:setAnimation(0, "idle1", true)
        
        local glProgramState = AvalonUtil:getAnimationGrayGLProgramState()
        self._roleAnimation:setGLProgramState(glProgramState)
        self._roleAnimation:updateTime(0.01)
        self._roleAnimation:setTimeScale(0)
    end
end

function PetRenderer:isPetRender()

end

function PetRenderer:endRevive()
end

function PetRenderer:showLevelUp()
    -- 处理玩家升级表现
    self:_triggerLevelUp()
end

function PetRenderer:_triggerLevelUp(isBag)
    local levelUpAnimation = Avalon.Animation:create("effect_role_hero_levelup.json", "effect_role_hero_levelup.atlas", 0.6);

    -- Avalon.AudioManager:playSound("504")
    Avalon.AudioManager:playDynamicSound("504",nil,self:getCoord())
    levelUpAnimation:setAnimation(0,"animation",false)

    levelUpAnimation:registerSpineEventHandler(function(event)
           levelUpAnimation:runAction(cc.RemoveSelf:create())
    end, sp.EventType.ANIMATION_END)

    levelUpAnimation:registerSpineEventHandler(function (event)
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

    self:addChild(levelUpAnimation,ROLE_LEVEL_UP_ZORDER)
end

function PetRenderer:showLevelUpAttr(attrArr)
    --print("HeroRenderer:showLevelUpAttr  ",attrArr)
    -- 处理升级属性表现
    self:_triggerLevelUpAttr(attrArr)
end

function PetRenderer:_triggerLevelUpAttr(attrArr)
    local levelUpAttrAnimation = Avalon.Animation:create("effect_role_hero_levelup_information.json", "effect_role_hero_levelup.atlas", 0.6);
    levelUpAttrAnimation:setAnimation(0,"animation",false)
    levelUpAttrAnimation:registerSpineEventHandler(function(event)
        if event.animation == "animation" then
           levelUpAttrAnimation:runAction(cc.RemoveSelf:create())
        end
    end, sp.EventType.ANIMATION_END)

    levelUpAttrAnimation:registerSpineEventHandler(function (event)
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

    -- 根据情况处理显示
    local addNum = 1;
    for _,attrData in ipairs(attrArr) do
        local level = cc.Label:createWithTTF(attrData.attrName.." +"..attrData.attrNum, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
        level:setTextColor(attrData.color)
        level:enableOutline(attrData.outlineColor, 2)
        level:setAnchorPoint(cc.p(0.5, 0.5))

        levelUpAttrAnimation:addComponent(string.format("1%d",addNum),level)
        addNum = addNum + 1
    end

    self:addChild(levelUpAttrAnimation, ROLE_LEVEL_UP_ATTR_ZORDER)
end

function PetRenderer:setRideType(petData, notChange)
    -- print("宠物状态设置~~~~~~~~~~ ",isRide,notChange)
    if not notChange then
        self.isReadyRide = petData.isRide and petData:isRide() or false
    end
    local isisRide = petData.isRide and petData:isRide() or false
    -- printError("________setRideType________", isisRide, self.isReadyRide)
    if isisRide then
        self._roleAnimation:setVisible(false)
        -- self._viewNode:setVisible(false)
        self.nickNameLabel:setVisible(false)
    else
        self._roleAnimation:setVisible(true)
        -- self._viewNode:setVisible(true)
        self.nickNameLabel:setVisible(true)
    end
    
end

function PetRenderer:hidePet(isRide, notChange,petData)
    -- printError("________hidePet________", isRide) 
    -- print("宠物状态设置~~~~~~~~~~ ",isRide,notChange)
    if not notChange then
        self.isReadyRide = isRide
    end

    if petData and petData.getState and petData:getState() == FSMState.BATTLE then
        return
    end
    
    if isRide then
        self._roleAnimation:setVisible(false)
        -- self._viewNode:setVisible(false)
        self.nickNameLabel:setVisible(false)
    else
        self._roleAnimation:setVisible(true)
        -- self._viewNode:setVisible(true)
        self.nickNameLabel:setVisible(true)
    end
    
end

function PetRenderer:isRide()
    return self.isReadyRide or false
end

function PetRenderer:_changeAnimation(newAnimation)
    if(newAnimation) then
        if(self._roleAnimation ~= newAnimation) then
            self:removeAllFxFromNowRoleAnimation()
            self._roleAnimation = newAnimation

            -- self:setRoleAnimationPosition(0,0)

            self:setDirection(self._direction)
            self:addAllFxToNowRoleAnimation()
        end
    end
end

function PetRenderer:createFoxSpiritTransformHero(petData)
    if not petData then
        return
    end

    if petData.isTransform == 0 then
        return
    end

    local heroData = RoleDataManager:getHeroDataForPK(petData.pk)
    if not heroData then
        return
    end

    self:clearEquipmentArrEffect()

    self.isTransform = petData.isTransform

    --狐仙变成hero
    if petData.isTransform == 1 then

        self.heroData = heroData
        

        local skeletonFile, atlasFile, scale = heroData:getAnimationData()

        if(self._roleAnimation) then
            self._roleAnimation:runAction(cc.RemoveSelf:create())
            self._roleAnimation = nil
        end

        local newAnimation = Avalon.Animation:create(skeletonFile, atlasFile, scale)
        self:addChild(newAnimation, ROLE_ANIMATION_ZORDER)
        
        -- print("heroData ======= ==== === ")
        -- dump(heroData,nil,10)

        self:_changeAnimation(newAnimation)

        self:refreshHeroEquip(heroData)

        local attackIdleName = string.format("attackidle_%d",self._weaponType)
        newAnimation:setAnimation(0, attackIdleName, true)
        newAnimation:setPosition(0,0)

        -- self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()    
        --     self:idle()
        -- end)))
    else
        -- 变回狐仙

        local skeletonFile, atlasFile, scale = petData:getAnimationData()

        if(self._roleAnimation) then
            self._roleAnimation:runAction(cc.RemoveSelf:create())
            self._roleAnimation = nil
        end

        local newAnimation = Avalon.Animation:create(skeletonFile, atlasFile, scale)
        self:addChild(newAnimation, ROLE_ANIMATION_ZORDER)
        newAnimation:setAnimation(0, "idle1", true)
        newAnimation:setPosition(0,0)

        

        self:_changeAnimation(newAnimation)

        self.heroData = nil
    end

    

    self:_registerSpineEventHandler()

    self:addDeformationView(false,true)

end

function PetRenderer:refreshHeroEquip(heroData)
    if not heroData then
        return
    end

    local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(heroData:getSpriteID())
    if not wearData then
        return
    end
    local wearEquipArr = wearData.wearEquipmentArr
    if not wearEquipArr then
        return
    end

    require "app.datas.EquipIllusionDataManager"

    local skin = "initial"
    for k,v in pairs(wearEquipArr) do
        -- 判断是否有盔甲
        local equipType = v:getEquipmentType()
        if equipType == EQUIPMENT_TYPE.Chest then
            local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
            if(illusionEquipData) then
                skin = illusionEquipData:getAttachmentID()
            end
            break
        end
    end

    -- 替换盔甲
    self:_changeArmor(skin)

    local faceDecodeID = heroData:getFaceDecodeID()
    local sex = heroData:getSex() or 1
    self:refreshFace(faceDecodeID,sex)

    local handleTypeArr = {}
    
    for k,v in pairs(wearEquipArr) do
        -- 替换装备,这里要求不能为盔甲
        local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
        local equipType = illusionEquipData:getEquipmentType()

        local animationArr = self._equipmentArr[equipType]
        if(animationArr) then 
            for k, animation in pairs(animationArr) do
                if(not tolua.isnull(animation)) then 
                    animation:removeFromParent()
                end
            end
        end
        animationArr = {}

        if equipType == EQUIPMENT_TYPE.Helmet then
            local isHideHelmet = heroData:getIsHideHelmet()
            self:_changeHelmet(illusionEquipData,isHideHelmet)
        elseif equipType == EQUIPMENT_TYPE.Shoulders then
            self:_changeShoulder(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Gloves then
            self:_changeGloves(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Boots then
            self:_changeShoes(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Weapon then
            self:_changeWeapon(illusionEquipData)
            self._weaponType = illusionEquipData:getWeaponType()
        end
        handleTypeArr[equipType] = true
        self:_handleEquipmentAnimation(illusionEquipData)
    end

    for k, animationArr in pairs(self._equipmentArr) do 
        if(not handleTypeArr[k] and animationArr) then 
            for k, animation in pairs(animationArr) do 
                if(not tolua.isnull(animation)) then
                    animation:removeFromParent()
                end
            end
            animationArr = nil
        end
    end
end

-- 换盔甲
function PetRenderer:_changeArmor(skin)
    if self._roleAnimation and skin then
        -- if (self._skin ~= skin) then
        --     self._skin = skin
            self._roleAnimation:setSkin(skin)
        -- end
        -- self._roleAnimation:setToSetupPose()
    end
end

-- 刷新脸型
function PetRenderer:refreshFace(faceDecodeID,sex)
    -- 处理脸型的相关逻辑
    if faceDecodeID == nil or faceDecodeID == 0 then
        faceDecodeID = 3010101
    end
    -- 处理脸型刷新
    local bodyID,hairID, eyeID, mouthID = ToolsUtil:splitFaceDecodeID(faceDecodeID)

    self:_changeModelSkin(bodyID, sex)
    self:changeModelHair(bodyID, hairID, sex)
    self:changeModelEye(bodyID, eyeID, sex)
    self:changeModelMouth(bodyID, mouthID, sex)
end

-- 肤色
function PetRenderer:_changeModelSkin(body,sex)
    if self._roleAnimation then
        local attachmentName = string.format("skincolor/%d/%d/205/205001/%d205001-%d-",sex,body,body,sex)

        local mountName = 205
        local combinationArr = {"01","02","03","04","05","06","07","08","09"}

        for k,v in pairs(combinationArr) do
            local name = mountName..v
            local attachment = attachmentName..v
            self._roleAnimation:setAttachment(name,attachment)
        end

        self:_changeModelNose(body, sex)
    end
end

-- 鼻子
function PetRenderer:_changeModelNose(body,sex)
    if self._roleAnimation then
        local attachmentName = string.format("skincolor/%d/%d/203/203001/%d203001-%d-",sex,body,body,sex)
        local mountName = 203

        local combinationArr = {"01"}
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name = mountName..v
                    local attachment = attachmentName..v
                    self._roleAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end

-- 头发
function PetRenderer:changeModelHair(body,hair,sex)
    if self._roleAnimation then
        local attachmentName = string.format("skincolor/%d/%d/201/201%03d/%d201%03d-%d-",sex,body,hair,body,hair,sex)

        local mountName = 201
        local faceID = body * 1000000 + 201000 + hair;
        local faceConfig = ConfigManager:getFaceConfig(faceID)
        if faceConfig == nil then
            return
        end
        local combinationArr = faceConfig.componentCombination

        if combinationArr then
            local combinationArr = AvalonUtil:splitStr(combinationArr[sex], ",")

            for i = 1,7 do
                local mark = false
                for k,v in pairs(combinationArr) do
                    if tonumber(v) == i then
                        local name = mountName..v
                        local attachment = attachmentName..v
                        self._roleAnimation:setAttachment(name,attachment)
                        mark = true
                        break
                    end
                end

                if mark == false then
                    local name = mountName.."0"..i
                    local attachment = "skincolor/hair/0"..i
                    self._roleAnimation:setAttachment(name,attachment)
                end
            end

        end
    end
end

-- 眼睛
function PetRenderer:changeModelEye(body,eye,sex)
    if self._roleAnimation then
        local attachmentName = string.format("skincolor/%d/%d/202/202%03d/%d202%03d-%d-",sex,body,eye,body,eye,sex)

        local mountName = 202
        local faceID = body * 1000000 + 202000 + eye;

        local faceConfig = ConfigManager:getFaceConfig(faceID)
        if faceConfig == nil then
            return
        end
        local combinationArr = faceConfig.componentCombination

        if combinationArr then
            local combinationArr = AvalonUtil:splitStr(combinationArr[sex], ",")
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name = mountName..v
                    local attachment = attachmentName..v
                    self._roleAnimation:setAttachment(name,attachment)
                end
            end
        end

        -- 眨眼效果
        local attachment = string.format("skincolor/%d/%d/202/initial/%d202000-%d-01-close",sex,body,body,sex)
        local mountName = "20201-close"
        self._roleAnimation:setAttachment(mountName,attachment)

        -- 死亡效果
        local attachment = string.format("skincolor/%d/%d/202/initial/%d202000-%d-01-dead",sex,body,body,sex)
        local mountName = "20201-dead"
        self._roleAnimation:setAttachment(mountName,attachment)
    end
end
-- 嘴巴
function PetRenderer:changeModelMouth(body,mouth,sex)
    if self._roleAnimation then
        local attachmentName = string.format("skincolor/%d/%d/204/204%03d/%d204%03d-%d-",sex,body,mouth,body,mouth,sex)

        local mountName = 204

        local faceID = body * 1000000 + 204000 + mouth;
        local faceConfig = ConfigManager:getFaceConfig(faceID)
        if faceConfig == nil then
            return
        end
        local combinationArr = faceConfig.componentCombination

        if combinationArr then
            local combinationArr = AvalonUtil:splitStr(combinationArr[sex], ",")
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name = mountName..v
                    local attachment = attachmentName..v
                    self._roleAnimation:setAttachment(name,attachment)
                end
            end
        end

        -- 切换死亡效果
        local attachment = string.format("skincolor/%d/%d/204/initial/%d204000-%d-01-dead",sex,body,body,sex)
        local mountName = "20401-dead"
        self._roleAnimation:setAttachment(mountName,attachment)

        -- 张嘴效果效果
        local attachment = string.format("skincolor/%d/%d/204/initial/%d204000-%d-01-open",sex,body,body,sex)
        local mountName = "20401-open"
        self._roleAnimation:setAttachment(mountName,attachment)
    end
end

-- 换头盔
function PetRenderer:_changeHelmet(equipmentData,isHideHelmet)
    if isHideHelmet == true then
        return
    end
    
    if self._roleAnimation and equipmentData then
        local equipmentID = equipmentData.goodsID
        local remarksField = AvalonUtil:splitStr(equipmentData.remarksField[1], ",")
        -- 处理最前面一位
        local attachmentID = equipmentData:getAttachmentID()        

        -- 新增的头盔表现
        local attachmentName = string.format("101/0/%s/%s-0-",attachmentID,attachmentID)
        local mountName = 101
        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:_calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._roleAnimation:setAttachment(name,attachment)
                end
            end
        end

        -- 处理遮挡头发关系
        local allShow = {"01","02","03","04","05","06","07"}
        local mountName = 201
        local attachmentName = "skincolor/hair/"
        for k1,attr in ipairs(allShow) do
            local show = false
            for k2,showAttr in ipairs (remarksField) do
                if (showAttr == attr) then
                    show = true
                    break
                end
            end
            if show == false then
                local name = mountName..attr
                local attachment = attachmentName..attr
                
                self._roleAnimation:setAttachment(name,attachment)
            end
        end
    end
end

-- 换肩膀
function PetRenderer:_changeShoulder(equipmentData)
    if self._roleAnimation and equipmentData then
        local equipmentID = equipmentData.goodsID
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("103/0/%s/%s-0-",attachmentID,attachmentID)

        local mountName = 103

        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:_calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._roleAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end 

-- 换手套
function PetRenderer:_changeGloves(equipmentData)
    if self._roleAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("104/0/%s/%s-0-",attachmentID,attachmentID)

        local mountName = 104

        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:_calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._roleAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end

-- 换鞋子
function PetRenderer:_changeShoes(equipmentData)
    if self._roleAnimation and equipmentData then
        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("105/0/%s/%s-0-",attachmentID,attachmentID)

        local mountNameOne = "insideshoe_"
        local mountNameTwo = "outsideshoe_"

        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    self._roleAnimation:setAttachment(mountNameOne..v,attachmentName..tostring(10+ tonumber(v)))
                    self._roleAnimation:setAttachment(mountNameTwo..v,attachmentName..v)
                end
            end
        end
    end
end

function PetRenderer:_getWeaponStr(weaponType) 
    local weaponStr = nil
    if(weaponType == 1) then 
        weaponStr = "01"
    elseif (weaponType == 2) then 
        weaponStr = "02"
    elseif (weaponType == 3) then 
        weaponStr = "03"
    end

    return weaponStr
end

-- 武器
function PetRenderer:_changeWeapon(equipmentData)
    if self._roleAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentNamePre = string.format("108/0/%s/%s-0-",attachmentID,attachmentID)
        local weaponStr = self:_getWeaponStr(equipmentData:getWeaponType())
        local combination = equipmentData.componentCombination
        for k,value in ipairs(combination) do
            local mountName = "outside"
            local attachmentName = attachmentNamePre

            if value == "01" then
                mountName = "inside"
            elseif value == "02" then
                mountName = "outside"
            elseif value == "03" then
                mountName = "book"
            elseif value == "04" then
                mountName = "shield"
            elseif(tonumber(value) > 100 and tonumber(value) < 400) then 
                mountName = string.format("inside-%s-%s", weaponStr, value)
                attachmentName = string.format("%s01-", attachmentName)
            elseif (tonumber(value) > 400) then
                mountName = string.format("shield-%s-%s", weaponStr, value)
                attachmentName = string.format("%s04-", attachmentName)
            end

            attachmentName = attachmentName..value

            self._roleAnimation:setAttachment(mountName,attachmentName)
        end
    end
end

function PetRenderer:heroSelfAddComponent(mountName, animationNode)
    if(self._roleAnimation and animationNode and mountName) then
        self._roleAnimation:addComponent(mountName, animationNode)
        local slotNode = self._roleAnimation:getNodeForSlot(mountName, true)
        animationNode:setRotation(-slotNode:getRotation())
        if(self.isPause) then
            Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function()
                if(not tolua.isnull(animationNode)) then
                    animationNode:pause()
                end
            end, 2)
        end
    end
end

function PetRenderer:_handleEquipmentAnimation(equipmentData)
    if(equipmentData) then 
        local equipType = equipmentData:getEquipmentType()
        local spineName,slotOrAnimationArr = equipmentData:getWeaponEffectCombination()
        
        if spineName and string.find(spineName, "role_hero_halo_effect_equipment") ~= nil then
            -- --光环特效特殊处理
            -- self._haloEffectName = spineName
            -- self:createEquipmentSkinHaloEffect(self._haloEffectName)
        else
            if(spineName and slotOrAnimationArr and #slotOrAnimationArr > 0) then
                self._equipmentArr[equipType] = {}
                for k, v in ipairs(slotOrAnimationArr) do 
                    local slotName = v
                    local animationName = v
                    --CO-16977 使用lua封装的animation
                    -- local animation = Avalon.Animation:create(spineName..".json", spineName..".atlas", 1)
                    local animation = UI.Animation:create()
                    animation:init(spineName..".json", spineName..".atlas", 1)
                    -----------------------------------------------------------
                    animation:setAnimation(animationName, true)
                    self:heroSelfAddComponent(slotName, animation)

                    if self._equipmentArr[equipType] == nil then 
                        self._equipmentArr[equipType] = {}
                    end
                    table.insert(self._equipmentArr[equipType], animation)
                end
            end
        end
    end
    -- 
end

function PetRenderer:_calculationMountNameAndAttachmentName(mountBase, attachmentBaseName, combination)
    -- print("_calculationMountNameAndAttachmentName start=", mountBase, attachmentBaseName, combination)
    local totalLen = string.len(combination)
    local mountName = mountBase
    local attachment = ""
    if(totalLen <=2) then 
        mountName = mountName..combination
        attachment = attachmentBaseName..combination
    else
        local partStr = string.format("%02d", string.sub(combination, 1, totalLen- 2))
        mountName = mountName..partStr.."-"..combination
        attachment = attachmentBaseName..partStr.."-"..combination
    end
    -- print("_calculationMountNameAndAttachmentName end=", mountName, attachment)

    return mountName, attachment
end
--[[
    英雄的渲染器
]]--

require "app.renderer.RoleRenderer"
require "app.renderer.component.AttributeComponent"
require "app.config.ConfigManager"
local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE

local evolutionConfig = require("profiles.commonProfile.ProfilehorcruxEvolution")
local GameDataManager = require("app.game.GameDataManager")


Renderer = Renderer or {}

local HeroRenderer = class("HeroRenderer", Renderer.RoleRenderer)
Renderer.HeroRenderer = HeroRenderer

local RoleRenderer = Renderer.RoleRenderer

-- private:
local DEBUG = false

local NICK_NAME_LABEL_Y = 163
local TITLE_LABEL_Y = 140

local GHOST_REVIVE_ANIMATION_NAME = "ghost_revive"

-- 构造函数
function HeroRenderer:ctor()
    HeroRenderer.super.ctor(self)

    self.lostRealmAnimation = nil
    self._expeditionStatus = false
    -- {equipType={animation, animation2}, equipType={...}}
    self._equipmentArr = {}
end

-- 析构函数
function HeroRenderer:dtor()
    HeroRenderer.super.dtor(self)

    self.lostRealmAnimation = nil
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
function HeroRenderer:init(skeletonFile, atlasFile, scale, sex, isMaster,faceDecodeID,looks,isHideHelmet, isFightScene,isReadyRide,pk)
    --print("HeroRenderer:init", skeletonFile, atlasFile, scale, sex, isMaster,faceDecodeID,looks)
    HeroRenderer.super.init(self, skeletonFile, atlasFile, scale, RoleType.Hero)

    self._skeletonFile = skeletonFile
    -- 角色性别
    self._sex = sex
    self._skin = ""
    -- 初始化数据  1 标识单手武器  2 标识双手武器
    self._weaponType = 1
    self._ghostAnimation = nil
    self._isMaster = isMaster
    self._recoverDead = false
    self._showRevive = false
    self._showDie = false
    self._isHideHelmet = isHideHelmet
    self._isFightScene = isFightScene
    self._dieCallBack = nil
    self._isReadyRide = isReadyRide

    self._isFishing = false

    self._selfHeroAnimationSize = {width=73, height=86}
    self._lookAnimationSize = {width=73,height=66}

    -- 脸型值
    self._faceDecodeID = faceDecodeID
    -- --print("self._faceDecodeID",faceDecodeID)
    -- 英雄原本的表现动画，这里只是临时表现
    self._heroSelfAnimation = self._roleAnimation

    self._idleNum = 0

    self._heroRideAnimation = nil

    --装备光环特效
    self._haloEffectAnimation = nil
    
    if(looks == nil) then
        looks = 0
    end

    self._tempLooks = 0

    self:setHeroPK(pk)
    self:looksChange(looks, true)

    -- 疾跑效果
    self._runSmokeAnimation = Avalon.Animation:create("effect_role_hero_run_smoke.json", "effect_role_hero_run_smoke.atlas", 0.6)
    self._viewNode:addChild(self._runSmokeAnimation)
    -- self._runSmokeAnimation:setAnimation(0, "run_smoke", true)
    self._runSmokeAnimation:setVisible(false)
    self._runSmokeAnimation:registerSpineEventHandler(function (event)
        if(string.find(event.animation, "run_done") == 1) then
            self._runSmokeAnimation:setVisible(false)
        end
    end, sp.EventType.ANIMATION_END)

    self._runSmokeAnimation:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- 播放音效文件
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

    self:refreshEquip(nil)

    --CO-16977 特殊处理
    self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()    
        self:idle()
    end)))

    self:_registerHeroSpineEventHandle()
end

function HeroRenderer:setHeroPK(pk)
    self._PK = pk
end

function HeroRenderer:getHeroAnimation()
    -- body
    return self._heroSelfAnimation
end

function HeroRenderer:changeIsHideHelmet(isHideHelmet)
    -- --print("HeroRenderer:changeIsHideHelmet ", isHideHelmet)
    self._isHideHelmet = isHideHelmet
end

function HeroRenderer:showAnimation(animationName, ...)
    assert(type(animationName) == "string", "RoleRenderer showAnimation: animation name is invalid.")
    if(self._looks == 0) then
        HeroRenderer.super.showAnimation(self, animationName, ...)
    else
        if (self._roleAnimation) then 
            self._roleAnimation:setAnimation(0, animationName, true)
            local animationNameList = {...}
            for i = 1, #animationNameList do 
                local _animationName = animationNameList[i]
                self._roleAnimation:addAnimation(0, _animationName, true)
            end
        else assert(false)
        end
    end
end

-- 设置方向
function HeroRenderer:setDirection(direction)
    HeroRenderer.super.setDirection(self, direction)

    if (direction == nil or direction == DirectionType.NONE) then         
        return 
    end
    -- print("hero  转向了")

    if (direction == DirectionType.EAST or
        direction == DirectionType.SOUTH) then
        self._roleAnimation:setScaleX(-1)
    else
        self._roleAnimation:setScaleX(1)
    end

    self:setHeroRidePetDirection()

    if DEBUG then
        --print(string.format("RoleRenderer setDirection: set direction %d.", direction))
    end
end

-- 显示待机动画
function HeroRenderer:showIDLE()
    self:removeWeaponAnimation()
    self:clearSkillFX()
    self:clearAllActAnimation()
    self:clearAllAssistActAnimation()
    
    self:_triggerRefreshWaiting()
    if(self._looks ~=0) then
        self._roleAnimation:setToSetupPose()
    end
    if self._showDie == false then
        self._roleAnimation:setAnimation(0, self:getIdleAnimationName(), true)
    end
    if(self._runSmokeAnimation) then
        self._runSmokeAnimation:setAnimation(0, self:getSmokeEndName(), false)
        -- --print("HeroRenderer:speedUp 22")
    end

    self:setHeroRidePetIdleShow()

    -- 这里如果复活，鬼魂等后需要移除相关的表现状态
    if(DEBUG) then
        --print("HeroRenderer:showIDLE")
    end
    if self._ghostAnimation then
        self._ghostAnimation:runAction(cc.RemoveSelf:create())
        self._ghostAnimation = nil
    end

    self:createHeroRidePetRunderer(self._tempModel)
end

function HeroRenderer:showNormalSkill(animName, weaponAnim, speedUp)
    if(self._looks ~= 0) then
        self:showAttack()
    else
        HeroRenderer.super.showNormalSkill(self,animName, weaponAnim, speedUp) 
    end
end

-- 获取待机动画名字
function HeroRenderer:getIDLEAnim()
    return self:getIdleAnimationName()
end

-- 显示移动动画
function HeroRenderer:showMove()
    self:removeWeaponAnimation()
    -- self:clearAllFX()
    self:_triggerRefreshWaiting()
    if(self._looks ~=0) then
        self._roleAnimation:setToSetupPose()
    end
    if(self._showDie == false) then
        local moveAnimationName = self:getMoveAnimationName()
        self._roleAnimation:setAnimation(0, moveAnimationName, true)

        self:setHeroRidePetMoveShow()
    end

    -- self:createHeroRidePetRunderer(self._tempModel)
end

-- 显示攻击动画
function HeroRenderer:showAttack()
    -- print("  攻击???????? ")
    -- self:clearAllFX()
    self:_triggerRefreshWaiting()
    if(self._looks ~=0) then
        self._roleAnimation:setToSetupPose()
    end

    self._roleAnimation:setAnimation(0, self:getAttackAnimationName(), false)
    self._roleAnimation:addAnimation(0, self:getAttackIdleAnimationName(), true)
    if(self._runSmokeAnimation) then
        self._runSmokeAnimation:setVisible(false)
    end

    -- --下骑乘
    -- self:removeHeroRidePetRunderer(true)
end

-- 显示死亡动画
function HeroRenderer:showDie(recoverDead, showRevive, dieCallBack)
    self:removeWeaponAnimation()
    --print("HeroRenderer:showDie  recoverDead, showRevive=",recoverDead, showRevive)
    --print("event.animation == self:getDeadAnimationName()  showDie  currentTime=",AvalonUtil:getCurrentTime())
    if(self._roleAnimation ~= self._heroSelfAnimation) then
        if(self._roleAnimation) then
            self._roleAnimation:runAction(cc.RemoveSelf:create())
            self._roleAnimation = nil
        end
    end

    if(self._runSmokeAnimation) then
        self._runSmokeAnimation:setVisible(false)
    end

    self._dieCallBack = dieCallBack
    -- 判断是否切换了动画对象
    self:_changeAnimation(self._heroSelfAnimation)
    -- self._roleAnimation = self._heroSelfAnimation
    self._roleAnimation:setTimeScale(1)
    self._roleAnimation:setVisible(true)
    -- 移除冰冻效果
    self:frozenRecover()

    self:clearAllFX()
    self:_triggerRefreshWaiting()
    self._recoverDead = recoverDead
    self._showRevive = showRevive
    self._showDie = true

    self._inRevive = false

    local animationName = self:getDeadAnimationName()
    if recoverDead == true then
        -- 处理死亡恢复
       self._roleAnimation:setAnimation(0,animationName, false)
       local animationDuration = AvalonUtil:getAnimationDuration(self._skeletonFile, animationName)
       self._roleAnimation:updateTime(animationDuration)

        --print("HeroRenderer:showDie  recoverDead  1111")
    else
        self._roleAnimation:setAnimation(0,animationName, false)
        -- Avalon.AudioManager:playSound("505")
        Avalon.AudioManager:playDynamicSound("505",nil,self:getCoord())
    end

    -- --移除骑乘表现
    -- self:removeHeroRidePetRunderer(true)
end

function HeroRenderer:startShowReviveLayer()
    self:removeWeaponAnimation()
    --print("HeroRenderer:startShowReviveLayer ", self._showDie, self._showRevive)
    if(self._showDie == false) then
        self._showRevive = true
        -- 直接显示复活界面
        if (self._isMaster == true) then
            -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE)
            self:_triggerRevive()
        else 
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SHOW_HELP_REVIVE, self._PK)
        end
    else
        self._showRevive = true
    end
end

-- 显示复活
function HeroRenderer:showRevive(callback, positionX, positionY)
    self._showDie = false
    self._inRevive = true
    self._reviveCallBack = nil
    self._reviveEndPositionX = positionX
    self._reviveEndPositionY = positionY

    self:_triggerRefreshWaiting()

    if self._ghostAnimation then
        self._ghostAnimation:setToSetupPose()
        self._ghostAnimation:setAnimation(0,GHOST_REVIVE_ANIMATION_NAME,false)

        self._reviveCallBack = callback
    else
        self._reviveCallBack = callback
        self:_ghostReviveEnd()
    end

    -- 显示复活特效
    self:_reviveEffect()
    
    -- self:removeHeroRidePetRunderer(true)
end

function HeroRenderer:endRevive()
    self._showDie = false
    self._inRevive = false
    self._reviveCallBack = nil
    
end

-- 显示回城效果
function HeroRenderer:showBackTown(isMaster)
    self:_triggerRefreshWaiting()

    -- 处理回城逻辑
    self:_backTown(isMaster)
end

-- 移除回城效果
function HeroRenderer:removeBackTown()
    self:_triggerRefreshWaiting()
    if(self._backTownDown) then
        self._backTownDown:runAction(cc.RemoveSelf:create())
        self._backTownDown = nil
    end
    if(self._backTownUp) then
        self._backTownUp:runAction(cc.RemoveSelf:create())
        self._backTownUp = nil
    end
end

-- 显示攻击idle动画
function HeroRenderer:showAttackIDLE()
    -- self:clearAllFX()
    self:removeWeaponAnimation()
    self:_triggerRefreshWaiting()

    --  显示背包idle 状态
    local animationName = self:getAttackIdleAnimationName()
    self._roleAnimation:setAnimation(0, animationName, true)
end

function HeroRenderer:showCamp(campId)
    if campId and campId > 0 then
        self:initNameLayout()

        self._campLayout:removeAllChildren()

        local campImg = UI.Image:create()
        campImg:init("ui_information_camp".. campId ..".png")
        campImg:center()
        self._campLayout:addComponent(campImg)
        self._campLayout:updateView()
        self._headLayout:updateView()
        if campId == PublicDefine.Camp.Blue then
            self._nickNameLabel:setFontColor(UI.FONT_COLOR_BLUE)
        else
            self._nickNameLabel:setFontColor(UI.FONT_COLOR_RED)
        end
    end
end

function HeroRenderer:initNameLayout()
    if (not self._nameLayout) then
        -- 获取统一颜色
        local nameColor = nil
        if(self._isMaster) then
            nameColor = UI.FONT_COLOR_MASTER_HERO_NAME
        else
            nameColor = UI.FONT_COLOR_OTHER_HERO_NAME
        end

        -- 名字自动排版
        self._headLayout = UI.Layout:create()
        self._headLayout:init()
        self._headLayout:enableAutoHeight()
        self._headLayout:enableAutoWidth()
        self._headLayout:centerBottom(140)
        self._viewNode:addChild(self._headLayout, 100)

        self._campLayout = UI.Layout:create()
        self._campLayout:init()
        self._campLayout:enableAutoHeight()
        self._campLayout:enableAutoWidth()
        self._campLayout:floatLeft(0)
        self._headLayout:addComponent(self._campLayout)

        -- 名字自动排版
        self._nameLayout = UI.Layout:create()
        self._nameLayout:init()
        self._nameLayout:enableAutoHeight()
        self._nameLayout:enableAutoWidth()
        self._nameLayout:centerBottom(140)
        self._nameLayout:floatLeft(0)
        self._headLayout:addComponent(self._nameLayout)

        -- 名字和公会排版
        self._nameAndGuildLayout = UI.Layout:create()
        self._nameAndGuildLayout:init()
        self._nameAndGuildLayout:enableAutoHeight()
        self._nameAndGuildLayout:enableAutoWidth()
        self._nameAndGuildLayout:floatUp(0)
        self._nameLayout:addComponent(self._nameAndGuildLayout)

        -- 称号
        self._titleText = UI.Text:create()
        self._titleText:init("", UI.SYS_FONT, UI.FONT_SIZE_18PX, nameColor)
        self._titleText:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
        self._titleText:floatLeft(0)
        self._nameAndGuildLayout:addComponent(self._titleText)

        -- 名字
        self._nickNameLabel = UI.Text:create()
        self._nickNameLabel:init("", UI.SYS_FONT, UI.FONT_SIZE_18PX, nameColor)
        self._nickNameLabel:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
        self._nickNameLabel:floatLeft(0)
        self._nameAndGuildLayout:addComponent(self._nickNameLabel)

        -- 内挂图标
        local expeditionImage = UI.Image:create()
        expeditionImage:init("ui_information_gules.png")
        expeditionImage:centerRight(- expeditionImage:getContentSize().width)
        self._nickNameLabel:addChild(expeditionImage)
        self._expeditionImage = expeditionImage
        if(self._expeditionStatus) then 
            expeditionImage:setVisible(self._expeditionStatus)
        else 
            expeditionImage:setVisible(false)
        end

        -- 公会
        self._guildNameText = UI.Text:create()
        self._guildNameText:init("", UI.SYS_FONT, UI.FONT_SIZE_18PX, nameColor)
        self._guildNameText:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
        self._guildNameText:floatUp(0)
        self._nameLayout:addComponent(self._guildNameText)
    end
end

-- 处理称号
function HeroRenderer:updateGuildName(guildName, isShow)
    self:initNameLayout()

    -- 更新工会名称
    self._guildNameText:setText("<" .. guildName .. ">")
    self._guildNameText:setVisible(isShow)

    -- 更新排版
    self._nameLayout:updateView()
    self._headLayout:updateView()
end

-- 处理称号
function HeroRenderer:updateTitle(titleID, param)
    self:initNameLayout()

    require("app.datas.TitleDataManager")
    -- 如果无称号, 隐藏, 移动名字至称号位置; 如果有称号, 把名字上移, 设置显示称号
    if (titleID == nil or titleID == 0) then
        self._titleText:setText("")
        self._titleText:setVisible(false)
    else
        local titleData = TitleDataManager:getTitleDataFromID(titleID, param)
        if (titleData) then
            if (titleData:getTitleFunctionType() == 51) then
                if (param and param ~= "") then
                    self._titleText:setText(titleData:getTitleName())
                    self._titleText:setVisible(true)
                else
                    self._titleText:setVisible(false)
                end
            else
                self._titleText:setText(titleData:getTitleName())
                self._titleText:setVisible(true)
            end 
        else
            self._titleText:setVisible(false)
        end
    end

    if self._titleText:isVisible() then
        self._nickNameLabel:floatLeft(10)
    else
        self._nickNameLabel:floatLeft(0)
    end

    -- 更新排版
    self._nameAndGuildLayout:updateView()
    self._nameLayout:updateView()
    self._headLayout:updateView()

    --先清除称号特效表现 (称号表现最多前后两个表现)
    if (self._titleEffectAnimationOne ~= nil) then
        self._titleEffectAnimationOne:removeFromParent()
        self._titleEffectAnimationOne = nil
    end

    if (self._titleEffectAnimationTwo ~= nil) then
        self._titleEffectAnimationTwo:removeFromParent()
        self._titleEffectAnimationTwo = nil
    end

    local effectData = TitleDataManager:getEffectDataByTitleID(titleID)
    if effectData ~= nil then
        for k,v in pairs(effectData.spineNames) do
            local skeletonName = effectData.skeletons[k]
            if k == 1 then
                self._titleEffectAnimationOne = Avalon.Animation:create(v .. ".json", v .. ".atlas", 1)
                self._titleEffectAnimationOne:setAnimation(0, "idle", true)
                self._heroSelfAnimation:addComponent(skeletonName, self._titleEffectAnimationOne)
            elseif k == 2 then
                self._titleEffectAnimationTwo = Avalon.Animation:create(v .. ".json", v .. ".atlas", 1)
                self._titleEffectAnimationTwo:setAnimation(0, "idle", true)
                self._heroSelfAnimation:addComponent(skeletonName, self._titleEffectAnimationTwo)
            end
        end
    end
end

-- 处理更新名字显示
function HeroRenderer:updateName(name, isShow, isMaster)
    self:initNameLayout()

    -- 更新名字
    self._nickNameLabel:setText(name)
    self._nickNameLabel:setVisible(isShow)

    -- 更新排版
    self._nameAndGuildLayout:updateView()
    self._nameLayout:updateView()
    self._headLayout:updateView()

    --  测试名称
    if(self.testTitleLabel) then
        self.testTitleLabel:setVisible(isShow)
    end

    if(self._nameLayout) then 
        self._nameLayout:setVisible(isShow)
    end 
end

function HeroRenderer:showLevelUp()
    -- 处理玩家升级表现
    self:_triggerLevelUp()
end

function HeroRenderer:showLevelUpAttr(attrArr)
    --print("HeroRenderer:showLevelUpAttr  ",attrArr)
    -- 处理升级属性表现
    self:_triggerLevelUpAttr(attrArr)
end

function HeroRenderer:showSkilAdvanced()
    self:_triggerSkillAdvanced()
end

-- 刷新当前动画
function HeroRenderer:refreshCurrentAnimation()
    local refreshShow = true
    local animationName = self._roleAnimation:getAnimationName(0)
    if animationName ~= nil then
        if string.find(animationName,"idle") == 1 then
            refreshShow = true
        elseif string.find(animationName,"move") == 1 then
            refreshShow = true
        -- elseif string.find(animationName, "attackidle") == 1 then
        --     refreshShow = true
        else
            refreshShow = false
        end
    end

    self._waitingRefreshArr = nil
    if refreshShow then
        local refreshAnimationName = nil
        if animationName ~= nil and animationName ~= "" then
            if string.find(animationName,"idle") == 1 then
                refreshAnimationName = self:getIdleAnimationName()
            elseif string.find(animationName,"move") == 1 then
                refreshAnimationName = self:getMoveAnimationName()
            elseif string.find(animationName, "attackidle") == 1 then
                refreshAnimationName = self:getAttackIdleAnimationName()
            end
        else
            refreshAnimationName = self:getIdleAnimationName()
        end

        if refreshAnimationName then
             self._roleAnimation:setAnimation(0, refreshAnimationName, true)
        end
    end
    if DEBUG then
        --print("HeroRenderer:refreshCurrentAnimation  ",refreshShow)
    end
end

-- 刷新装备的表现
function HeroRenderer:refreshEquip(wearEquipArr, showfFishWeapon)
    -- 测试开关控制
    if true then
        -- 测试刷新装备
        if not wearEquipArr then
            wearEquipArr = {}
        end
        if DEBUG then
            --print("HeroRenderer:refreshEquip  wearEquipArr.length=",#wearEquipArr)
        end
        
        -- print("  caocaocaocaocoaocaocoacoaocao   1111111111 ")
        -- printInfo(debug.traceback())
        self:_handleEquipmentChange(wearEquipArr,showfFishWeapon)
    else 
        local skin = "initial"
        self:_changeArmor(skin)
    end
end


-- 刷新脸型
function HeroRenderer:refreshFace(faceDecodeID)
    -- 处理脸型的相关逻辑
    if faceDecodeID == nil or faceDecodeID == 0 then
        self._faceDecodeID = 3010101
    else
        self._faceDecodeID = faceDecodeID
    end
    -- 处理脸型刷新
    local bodyID,hairID, eyeID, mouthID = ToolsUtil:splitFaceDecodeID(self._faceDecodeID)
    -- --print("HeroRenderer:refreshFace bodyID, hairID, eyeID, mouthID=", bodyID, hairID, eyeID, mouthID)

    self:_changeModelSkin(bodyID, self._sex)
    self:changeModelHair(bodyID, hairID, self._sex)
    self:changeModelEye(bodyID, eyeID, self._sex)
    self:changeModelMouth(bodyID, mouthID, self._sex)
end

-- 触发刷新一些等待处理
function HeroRenderer:_triggerRefreshWaiting()
    if self._waitingRefreshArr then
        self:_handleEquipmentChange(self._waitingRefreshArr)
        self._waitingRefreshArr = nil
    end
end

function HeroRenderer:showDreamWinding()
    if(self._dreamWindingAnimation == nil) then 
        self._dreamWindingAnimation = Avalon.Animation:create("effect_buff_dreamword_topten.json", "effect_buff_dreamword_topten.atlas", 1)
        self._dreamWindingAnimation:setAnimation(0, "trigger", true)
        self._heroSelfAnimation:addComponent("mount_bottomdown", self._dreamWindingAnimation)
    end
end

function HeroRenderer:hideDreamWinding()
    if(self._dreamWindingAnimation) then 
        self._dreamWindingAnimation:removeFromParent()
        self._dreamWindingAnimation = nil
    end
end

function HeroRenderer:showHorcruxExterior(evolutionID)
    if(evolutionID and evolutionID ~= 0) then 
        if(self.oldevolutionID ~= evolutionID) then
            if self._horcruxExteriorAnimation then 
                -- self:removeRoleFxFromSave(self._horcruxExteriorAnimation)
                self._horcruxExteriorAnimation:runAction(cc.RemoveSelf:create())
                self._horcruxExteriorAnimation = nil
            end
        end
        if tolua.isnull(self._horcruxExteriorAnimation) then
            self._horcruxExteriorAnimation = nil
        end
        self.oldevolutionID = evolutionID
        if(self._horcruxExteriorAnimation == nil) then 
            local evoConfig = HorcurxDataManager:getHorcurxEvolutionConfig(evolutionID)
            if(evoConfig) then 
                local img = string.split(evoConfig.position, "_")
                local spineName = "effect_role_" .. img[1] .. "_cave_" ..img[2]
                local mount = "mount_horcruxes"
                if(spineName and spineName ~= "" and spineName ~= 0) then 
                    -- print("HeroRenderer:showHorcruxExterior", spineName)
                    self._horcruxExteriorAnimation = Avalon.Animation:create(spineName..".json", spineName..".atlas", 1)
                    self._horcruxExteriorAnimation:setAnimation(0, "idle1", true)
                    self._heroSelfAnimation:addComponent(mount, self._horcruxExteriorAnimation)

                    local idleNum = 0
                    self._horcruxExteriorAnimation:registerSpineEventHandler(function(event)
                        if(event.animation == "idle1") then 
                            idleNum = idleNum + 1
                            if(idleNum > 4) then 
                                if math.random(1,4) <=4 then 
                                    idleNum = 0
                                    self._horcruxExteriorAnimation:setAnimation(0, "idle2", false)
                                    self._horcruxExteriorAnimation:addAnimation(0, "idle1", true)
                                end
                            end
                        end
                    end, sp.EventType.ANIMATION_COMPLETE)

                    -- self:addRoleFxToSave(self._horcruxExteriorAnimation, mount)
                end
            end
        end
    else 
        if self._horcruxExteriorAnimation then 
            -- self:removeRoleFxFromSave(self._horcruxExteriorAnimation)
            self._horcruxExteriorAnimation:runAction(cc.RemoveSelf:create())
            self._horcruxExteriorAnimation = nil
        end
    end
end

function HeroRenderer:showSelect()
    -- 处理显示选择表现
    if(self._selectHeroAnimation == nil) then
        self._selectHeroAnimation = Avalon.Animation:create("effect_role_hero_selected.json", "effect_role_hero_selected.atlas", 0.6)
        self._viewNode:addChild(self._selectHeroAnimation)

        self._selectHeroAnimation:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- 播放音效文件
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

function HeroRenderer:hideSelect()
    -- 处理隐藏选择表现
    if(self._selectHeroAnimation) then
        self._selectHeroAnimation:runAction(cc.RemoveSelf:create())
        self._selectHeroAnimation = nil
    end
end

function HeroRenderer:looksChange(looks, isInit, saveTempLooks, mode)

    if saveTempLooks then
        self._tempLooks = self._looks
    end

    if mode then
        self._tempModel = mode
    end


    local MachineManager = require("app.game.MachineManager")
    local SceneManager = require("app.game.SceneManager")
    local heroData = RoleDataManager:getHeroDataForPK(self._PK)

    local monsterIdRange = ConfigManager:getGeneralForKey("monsterIdRange")
    local arr = string.split(monsterIdRange, ",")
    local hasEat = looks >= tonumber(arr[1]) and looks <= tonumber(arr[2]) 
    if heroData and heroData:getState() == FSMState.BATTLE and hasEat then
        looks = 0
    end
    -- print("   caocaocaoo ", looks)
    -- printInfo(debug.traceback())

    -- print(" 变身 heroData ==== ", self._PK)
    if (self._looks == 0 and looks ~= 0) then
        --骑乘表现改为跟随
        self:removeHeroRidePetRunderer()

        --移除光环特效
        self:removeEquipmentSkinHaloEffect()

        if heroData then
            local petData = heroData:getCaptainPetData()
            if petData then
                local petSpriteId = petData:getId()
                local model = MachineManager:getInstance():getMachine():getModel()
                local petRole = model:getRoleBySpriteID(petSpriteId)
                if petRole then
                    local petModelId = petRole:getId()

                    -- print(" 变身 设置了looks ==== ",looks)
                    petData:setLooks(looks)


                    local ridingCMD = Command.RendererCommand:create(true)
                    ridingCMD:initForTypeAndData(CommandType.RENDERER_PET_FOLLOW, petModelId, {})
                    SceneManager:getInstance():pushCommand(ridingCMD)
                end
            end
        end
    elseif (self._looks ~= 0 and looks == 0) then
        --骑乘表现改为正常表现
        if heroData then
            local petData = heroData:getCaptainPetData()
            if petData then
                
                local canCreate = true
                local petSpriteId = petData:getId()
                local model = MachineManager:getInstance():getMachine():getModel()
                local petRole = model:getRoleBySpriteID(petSpriteId)
                if petRole then
                    local petModelId = petRole:getId()

                    -- print(" 变身 设置了looks ==22== ",looks)
                    petData:setLooks(looks)
                    local isRiding = MasterDataManager:getPetRidingState()
                    local data = {
                        isRiding = isRiding,
                        petSiteId = petData:getSiteId()
                    }

                    -- if petRole._fsm._state == FSMState.BATTLE or petRole._fsm._state == FSMState.DIE then
                    if petRole._fsm._state == FSMState.BATTLE then
                        data.isRiding = false
                        canCreate = false
                    end

                    local ridingCMD = Command.RendererCommand:create(true)
                    ridingCMD:initForTypeAndData(CommandType.RENDERER_PET_RIDE, petModelId, data)
                    SceneManager:getInstance():pushCommand(ridingCMD)
                end
                
                if canCreate then
                    self:createHeroRidePetRunderer(self._tempModel,petData,true)
                end
            else 
                self:createHeroRidePetRunderer(self._tempModel)
            end
        else
            self:createHeroRidePetRunderer(self._tempModel)
        end

        self:createEquipmentSkinHaloEffect(self._haloEffectName)
    end

    -- body
    if(self._looks ~= looks) then
        self._looks = looks
        local animationName = self._roleAnimation:getAnimationName(0)

        local changeAnimation = false
        if(self._roleAnimation ~= self._heroSelfAnimation) then 
            self._roleAnimation:runAction(cc.RemoveSelf:create())
            self._roleAnimation = nil
            changeAnimation = true
        end
        local isHorcurxLooks = looks < table.nums(evolutionConfig) --7

        if(isInit == false or isInit == nil) then
            -- 添加变身特效
            self:addDeformationView(isHorcurxLooks)
        end

        if(looks ~= 0) then
            -- 计算表现
            local skeletonFile = nil
            local atlasFile = nil
            local scale = 1
            if isHorcurxLooks then
                skeletonFile, atlasFile, scale= HorcurxDataManager:getHocruxLooksAnimation(looks)
                self.oldevolutionID = 0
            else
                local monsterData = RoleDataManager:createNormalConfigLocalMonsterData(looks)
                if(monsterData) then
                    skeletonFile = monsterData.skeleton
                    atlasFile = monsterData.atlas
                    scale = monsterData.scale
                end
            end
            if skeletonFile then
                if(self._roleAnimation == nil) then
                    self._roleAnimation = self._heroSelfAnimation
                end
                -- 切换角色动画
                self:setRoleAnimationPosition(1000000,100000)

                local newAnimation = Avalon.Animation:create(skeletonFile, atlasFile, scale)
                self:addChild(newAnimation, ROLE_ANIMATION_ZORDER)
                newAnimation:setAnimation(0, "idle1", true)

                -- 监听 spine 加载完成
                newAnimation:setLoadedSpineSuccessCallBack(function ()
                    -- 处理跳伤害的处理
                    newAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(function()
                        local size = newAnimation:getBoundingBox()
                        self.setRoleAnimationSize(size)
                        self._lookAnimationSize = size
                    end)))
                end)

                newAnimation:registerSpineEventHandler(function (event)
                end, sp.EventType.ANIMATION_START)

                newAnimation:registerSpineEventHandler(function (event)
                    if(event and event.eventData and event.eventData.name) then
                        local startPos = string.find(event.eventData.name, "sound_")
                        if(startPos ~= nil) then
                            -- 播放音效文件
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

                self:_changeAnimation(newAnimation)

                changeAnimation = true
                self._looks = looks
            end 
        else
            self._looks = looks
            if(self._roleAnimation == nil) then
                self:_changeAnimation(self._heroSelfAnimation)
            end

            self._roleAnimation:setVisible(true)
            self:setRoleAnimationPosition(0,0)
            self._roleAnimation:setTimeScale(1)
        end

        if(changeAnimation) then
            if(animationName) then 
                if(string.find(animationName, "move") == 1) then
                    self._roleAnimation:setAnimation(0, self:getMoveAnimationName(), true)
                elseif (string.find(animationName, "idle") == 1) then
                    self._roleAnimation:setAnimation(0, self:getIdleAnimationName(), true)
                else
                    self._roleAnimation:setAnimation(0, self:getIdleAnimationName(), true)
                end
            else 
                if(self._looks and self._looks ~= 0) then
                    self._roleAnimation:setAnimation(0, "idle1", true)
                else    
                    self._roleAnimation:setAnimation(0, self:getIdleAnimationName(), true)
                end
            end
        end
    end


    self:setHeroHaloEffectShow()

    --如果是狐仙骑宠,则隐藏角色
    self:transformHuli()
end


-- 特殊道具变身,进入战斗后的处理
function HeroRenderer:transformToHeroAnimaiton()
    -- if(self._roleAnimation ~= self._heroSelfAnimation) then 
    --     self._roleAnimation:runAction(cc.RemoveSelf:create())
    --     self._roleAnimation = nil
    -- end

    -- if(self._roleAnimation == nil) then
    --     self:_changeAnimation(self._heroSelfAnimation)
    -- end

    -- if self._roleAnimation then
    --     self._roleAnimation:setVisible(true)
    --     self:setRoleAnimationPosition(0,0)
    --     self._roleAnimation:setTimeScale(1)
    -- end

    self:looksChange(0,false,true)
end

-- 特殊道具变身,退出战斗后的处理
function HeroRenderer:transformToLooksAnimaiton()
    if(self._roleAnimation == self._heroSelfAnimation and self._tempLooks ~= 0) then 
        self:looksChange(self._tempLooks)
    end
end

function HeroRenderer:speedUp(timeScale)
    if (self._looks == 0) then
        HeroRenderer.super.speedUp(self, timeScale)
    else
        if (self._roleAnimation) then
            self._roleAnimation:setTimeScale(timeScale)
        end
    end

    if (self._runSmokeAnimation) then
        if (timeScale > 1) then
            local animationName = self._roleAnimation:getAnimationName(0)
            -- --print("HeroRenderer:speedUp ", timeScale, self._roleAnimation:getScaleX(), animationName)
            if (animationName and string.find(animationName, "move") == 1) then
                -- --print("HeroRenderer:speedUp 11")
                if (self._runSmokeAnimation:isVisible() == false) then
                    self._runSmokeAnimation:setVisible(true)
                    self._runSmokeAnimation:setAnimation(0, self:getSmokeStartName(), false)
                    self._runSmokeAnimation:addAnimation(0, self:getSmokeLoopName(), true)
                end
                self._runSmokeAnimation:setScaleX(self._roleAnimation:getScaleX())
            end
        else
            -- self._runSmokeAnimation:setVisible(false)
            if (self._runSmokeAnimation:isVisible()) then
                local runAnimationName = self._runSmokeAnimation:getAnimationName(0)
                if (runAnimationName and string.find(runAnimationName, "run_done") == 1) then
                else
                    self._runSmokeAnimation:setAnimation(0, self:getSmokeEndName(), false)
                end
            end
        end

    -- if(timeScale > 1) then
    --     self._runSmokeAnimation:setVisible(true)
    --     self._runSmokeAnimation:setScaleX(-self._roleAnimation:getScaleX())
    -- else
    --     self._runSmokeAnimation:setVisible(false)
    -- end
    end
end

function HeroRenderer:setDirection(direction)
    HeroRenderer.super.setDirection(self, direction)
    if(not tolua.isnull(self._runSmokeAnimation)) then
        local runAnimationName = self._runSmokeAnimation:getAnimationName(0)
        if
            (runAnimationName and string.find(runAnimationName, "run_smoke") == 1) or
                (runAnimationName and string.find(runAnimationName, "run_begin") == 1)
        then
            self._runSmokeAnimation:setAnimation(0, self:getSmokeLoopName(), true)
        end
    end
end

function HeroRenderer:getSmokeStartName()
    local direction = self._direction
    if (direction == DirectionType.EAST or direction == DirectionType.NORTH) then
        return "run_begin_1"
    else
        return "run_begin_2"
    end
end

function HeroRenderer:getSmokeLoopName()
    local direction = self._direction
    if (direction == DirectionType.EAST or direction == DirectionType.NORTH) then
        return "run_smoke_1"
    else
        return "run_smoke_2"
    end
end

function HeroRenderer:getSmokeEndName()
    local direction = self._direction
    if (direction == DirectionType.EAST or direction == DirectionType.NORTH) then
        return "run_done_1"
    else
        return "run_done_2"
    end
end

-- 处理装备改变逻辑
function HeroRenderer:_handleEquipmentChange(wearEquipArr,showfFishWeapon)
    if DEBUG then
        --print("HeroRenderer:_handleEquipmentChange")
        --print(#wearEquipArr)
    end

    require "app.datas.EquipIllusionDataManager"

    if self._isFishing then
        showfFishWeapon = self._isFishing
    end

    self._haloEffectName = ""
    self:removeEquipmentSkinHaloEffect()

    
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
    
    -- 默认都初始化为单手武器动作
    local oldWeaponType = self._weaponType
    self:refreshFace(self._faceDecodeID)
    self._weaponType = 1

    -- self._wearEquipArr = wearEquipArr

    -- :getEquipmentType()
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

        if DEBUG then
            --print("HeroRenderer refreshEquip equipType,goodsID=",equipType,v.goodsID,v:getEntityID())
        end
        if equipType == EQUIPMENT_TYPE.Helmet then
            self:_changeHelmet(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Shoulders then
            self:_changeShoulder(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Gloves then
            self:_changeGloves(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Boots then
            self:_changeShoes(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Weapon and not showfFishWeapon then
            self:_changeWeapon(illusionEquipData)
            self._weaponType = illusionEquipData:getWeaponType()
        -- elseif equipType == EQUIPMENT_TYPE.Weapon and showfFishWeapon then
        --     self:_changeEmptyWeapon()
        elseif equipType == EQUIPMENT_TYPE.Fish and showfFishWeapon then
            self:_changeEmptyWeapon()
            self:_changeFishingWeapon(illusionEquipData)
        end
        handleTypeArr[equipType] = true
        -- print(" caocaocaocaocoaocaocoacoaocao equipType === ",equipType,EQUIPMENT_TYPE.Fish,PublicDefine.EQUIPMENT_TYPE.Fish)
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

    -- 判断是否刷新角色
    if (oldWeaponType ~= self._weaponType and self._showDie == false) then
        self:refreshCurrentAnimation()
    end
end

function HeroRenderer:_handleEquipmentAnimation(equipmentData)
    if(equipmentData) then 
        local equipType = equipmentData:getEquipmentType()
        local spineName,slotOrAnimationArr = equipmentData:getWeaponEffectCombination()
        
        if spineName and string.find(spineName, "role_hero_halo_effect_equipment") ~= nil then
            --光环特效特殊处理
            self._haloEffectName = spineName
            self:createEquipmentSkinHaloEffect(self._haloEffectName)
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

-- 头发
function HeroRenderer:changeModelHair(body,hair,sex)
    if DEBUG then
        --print("HeroRenderer:changeModelHair body, hair,sex=",body,hair,sex)
    end
    if self._heroSelfAnimation then
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
                        if DEBUG then
                            --print("HeroRenderer:changeModelHair123  name,attachment=",name,attachment)
                        end
                        self._heroSelfAnimation:setAttachment(name,attachment)
                        mark = true
                        break
                    end
                end

                if mark == false then
                    local name = mountName.."0"..i
                    local attachment = "skincolor/hair/0"..i
                    if DEBUG then
                        --print("HeroRenderer:changeModelHair  name,attachment=",name,attachment)
                    end
                    self._heroSelfAnimation:setAttachment(name,attachment)
                end
            end

        end
    end
end
-- 眼睛
function HeroRenderer:changeModelEye(body,eye,sex)
    if DEBUG then
        --print("HeroRenderer:changeModelEye  eye,sex=",body,eye,sex)
    end
    if self._heroSelfAnimation then
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
                    if DEBUG then
                        --print("HeroRenderer:changeModelEye  name,attachment=",name,attachment)
                    end
                    self._heroSelfAnimation:setAttachment(name,attachment)
                end
            end
        end

        -- 眨眼效果
        local attachment = string.format("skincolor/%d/%d/202/initial/%d202000-%d-01-close",sex,body,body,sex)
        local mountName = "20201-close"
        self._heroSelfAnimation:setAttachment(mountName,attachment)

        -- 死亡效果
        local attachment = string.format("skincolor/%d/%d/202/initial/%d202000-%d-01-dead",sex,body,body,sex)
        local mountName = "20201-dead"
        self._heroSelfAnimation:setAttachment(mountName,attachment)
    end
end
-- 嘴巴
function HeroRenderer:changeModelMouth(body,mouth,sex)
    if DEBUG then
        --print("HeroRenderer:changeModelMouth  mouth,sex=",mouth,sex)
    end
    if self._heroSelfAnimation then
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
                    if DEBUG then
                        --print("HeroRenderer:changeModelMouth  name,attachment=",name,attachment)
                    end
                    self._heroSelfAnimation:setAttachment(name,attachment)
                end
            end
        end

        -- 切换死亡效果
        local attachment = string.format("skincolor/%d/%d/204/initial/%d204000-%d-01-dead",sex,body,body,sex)
        local mountName = "20401-dead"
        self._heroSelfAnimation:setAttachment(mountName,attachment)

        -- 张嘴效果效果
        local attachment = string.format("skincolor/%d/%d/204/initial/%d204000-%d-01-open",sex,body,body,sex)
        local mountName = "20401-open"
        self._heroSelfAnimation:setAttachment(mountName,attachment)
    end
end
-- 鼻子
function HeroRenderer:_changeModelNose(body,sex)
    if DEBUG then
        --print("HeroRenderer:_changeModelNose  nose,sex=", body, sex)
    end
    if self._heroSelfAnimation then
        local attachmentName = string.format("skincolor/%d/%d/203/203001/%d203001-%d-",sex,body,body,sex)
        local mountName = 203

        local combinationArr = {"01"}
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name = mountName..v
                    local attachment = attachmentName..v
                    if DEBUG then
                        --print("HeroRenderer:_changeModelNose  name,attachment=",name,attachment)
                    end
                    self._heroSelfAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end

-- 肤色
function HeroRenderer:_changeModelSkin(body,sex)
    if DEBUG then
        --print("HeroRenderer:_changeModelSkin body,sex=",body,sex)
    end
    if self._heroSelfAnimation then
        local attachmentName = string.format("skincolor/%d/%d/205/205001/%d205001-%d-",sex,body,body,sex)

        local mountName = 205
        local combinationArr = {"01","02","03","04","05","06","07","08","09"}

        for k,v in pairs(combinationArr) do
            local name = mountName..v
            local attachment = attachmentName..v
            if DEBUG then
                --print("HeroRenderer:changeModelHair  name,attachment=",name,attachment)
            end
            self._heroSelfAnimation:setAttachment(name,attachment)
        end

        self:_changeModelNose(body, sex)
    end
end

function HeroRenderer:_calculationMountNameAndAttachmentName(mountBase, attachmentBaseName, combination)
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

-- 换头盔
function HeroRenderer:_changeHelmet(equipmentData)
    -- --print("HeroRenderer:_changeHelmet")
    if self._isHideHelmet == true then
        return
    end
    -- --print("HeroRenderer:_changeHelmet1123123")
    if self._heroSelfAnimation and equipmentData then
        local equipmentID = equipmentData.goodsID
        local remarksField = AvalonUtil:splitStr(equipmentData.remarksField[1], ",")
        -- 处理最前面一位
        local attachmentID = equipmentData:getAttachmentID()        
        -- self._heroSelfAnimation:setAttachment(10101,string.format("101/0/%s/%s-0-01",attachmentID,attachmentID))
        -- self._heroSelfAnimation:setAttachment(10102,string.format("101/0/%s/%s-0-02",attachmentID,attachmentID))

        -- 新增的头盔表现
        local attachmentName = string.format("101/0/%s/%s-0-",attachmentID,attachmentID)
        local mountName = 101
        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:_calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._heroSelfAnimation:setAttachment(name,attachment)
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
                if DEBUG then
                    --print("HeroRenderer:_changeHelmet Shelter name,attachment=",name,attachment)
                end
                self._heroSelfAnimation:setAttachment(name,attachment)
            end
        end
    end
end

-- 换盔甲
function HeroRenderer:_changeArmor(skin)
    if self._heroSelfAnimation and skin then
        if DEBUG then
            --print("HeroRenderer:_changeArmor  skin=",skin)
        end
        if (self._skin ~= skin) then
            self._skin = skin
            self._heroSelfAnimation:setSkin(skin)
        end
        self._heroSelfAnimation:setToSetupPose()
    end
end

-- 换肩膀
function HeroRenderer:_changeShoulder(equipmentData)
    if self._heroSelfAnimation and equipmentData then
        local equipmentID = equipmentData.goodsID
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("103/0/%s/%s-0-",attachmentID,attachmentID)

        local mountName = 103

        if DEBUG then
            --print("HeroRenderer:_changeShoulder   equipmentID=",equipmentData.goodsID)
        end

        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:_calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    if DEBUG then
                        --print("HeroRenderer:_changeShoulder  name,attachment=",name,attachment)
                    end
                    self._heroSelfAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end 

-- 换手套
function HeroRenderer:_changeGloves(equipmentData)
    if self._heroSelfAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("104/0/%s/%s-0-",attachmentID,attachmentID)

        local mountName = 104

        if DEBUG then
            --print("HeroRenderer:_changeGloves   equipmentID=",equipmentData.goodsID)
        end

        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:_calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    if DEBUG then
                        --print("HeroRenderer:_changeGloves  name,attachment=",name,attachment)
                    end
                    self._heroSelfAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end

-- 换鞋子
function HeroRenderer:_changeShoes(equipmentData)
    if self._heroSelfAnimation and equipmentData then
        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("105/0/%s/%s-0-",attachmentID,attachmentID)

        local mountNameOne = "insideshoe_"
        local mountNameTwo = "outsideshoe_"

        if DEBUG then
            --print("HeroRenderer:_changeShoes   mountName,attachmentName=",mountNameOne,attachmentName)
        end

        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    self._heroSelfAnimation:setAttachment(mountNameOne..v,attachmentName..tostring(10+ tonumber(v)))
                    self._heroSelfAnimation:setAttachment(mountNameTwo..v,attachmentName..v)
                end
            end
        end
    end
end

-- 副手
function HeroRenderer:_changeDeputy(equipmentData,isDoubleHold)
    if self._heroSelfAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        -- 处理判断是否为单手装备
        local equipType = equipmentData:getEquipmentType()
        if equipType == EQUIPMENT_TYPE.OneHand then
            local attachmentID = equipmentData:getAttachmentID()
            local attachmentName = string.format("107/0/%s/%s-0-01",attachmentID,attachmentID)

            local mountName = "outside"
            if isDoubleHold == false then
                mountName = "inside"
            end

            if DEBUG then
                --print("HeroRenderer:_changeDeputy weapon   mountName,attachmentName=",mountName,attachmentName)
            end
            self._heroSelfAnimation:setAttachment(mountName,attachmentName)
        else
            local attachmentID = equipmentData:getAttachmentID()
            local attachmentName = string.format("106/0/%s/%s-0-01",attachmentID,attachmentID)

            local mountName = "book"
            if remarksField[1] == "1" then
                -- 书
                mountName = "book"
            elseif remarksField[1] == "2" then
                -- 盾
                mountName = "shield"
            end

            if DEBUG then
                --print("HeroRenderer:_changeDeputy goods  remarksField,mountName,attachmentName=",remarksField[1],mountName,attachmentName)
            end

            self._heroSelfAnimation:setAttachment(mountName,attachmentName)
        end

    end
end

function HeroRenderer:_getWeaponStr(weaponType) 
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
function HeroRenderer:_changeWeapon(equipmentData)
    if self._heroSelfAnimation and equipmentData then
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
                -- print("1000=", value, mountName, attachmentName)
            elseif (tonumber(value) > 400) then
                mountName = string.format("shield-%s-%s", weaponStr, value)
                attachmentName = string.format("%s04-", attachmentName)

                -- if hidShieldEffects then
                --     attachmentName = "108/0/108433/108433-0-04-"
                --     value = "401"
                -- end
            end

            attachmentName = attachmentName..value
            -- print("4000=", equipmentData:getWeaponType(), value, mountName, attachmentName)
            if DEBUG then
                --print("HeroRenderer:_changeWeapon   mountName,attachmentName=",mountName,attachmentName)
            end
            self._heroSelfAnimation:setAttachment(mountName,attachmentName)
        end
    end
end

--将武器换位空白资源
function HeroRenderer:_changeEmptyWeapon()
    if self._heroSelfAnimation then
        local mountName = "inside"
        local attachmentName = "weapon-fishing"
        self._heroSelfAnimation:setAttachment(mountName,attachmentName)
    end
end

-- 钓鱼武器
function HeroRenderer:_changeFishingWeapon(equipmentData)
    if self._heroSelfAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentNamePre = string.format("109/0/%s/%s-0-",attachmentID,attachmentID)
        local weaponStr = self:_getWeaponStr(equipmentData:getWeaponType())
        local combination = equipmentData.componentCombination
        for k,value in ipairs(combination) do
            local mountName = "fishing_rod"
            local attachmentName = attachmentNamePre

            if value == "01" then
                mountName = "fishing_rod"
            elseif value == "02" then
                mountName = "fishing_line"
            elseif value == "03" then
                mountName = "float"
            end

            if value == "03" then
                attachmentName = "109/0/109001/109001-0-03"
            else
                attachmentName = attachmentName..value
            end
            -- print("设置鱼竿显示属性  =====  ", equipmentData:getWeaponType(), value, mountName, attachmentName)
            if DEBUG then
                --print("HeroRenderer:_changeWeapon   mountName,attachmentName=",mountName,attachmentName)
            end
            self._heroSelfAnimation:setAttachment(mountName,attachmentName)
        end
    end
end

function HeroRenderer:sChangeWeapon(hidShieldEffects)

    local GameInManorManager = require "app.game.GameInManorManager"
    if (GameInManorManager:getInstance()._fishingLayer) then
        return false
    end

    if self._heroSelfAnimation then

        self._heroSelfAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()
            self._heroSelfAnimation:setOffSlotVisible(hidShieldEffects)
        end)))

        for i = 1, 20 do 
            local slotNode = self._heroSelfAnimation:getNodeForSlot("shield-01-"..(400+i), true)
            if slotNode then
                if hidShieldEffects then
                    slotNode:setVisible(false)
                else
                    slotNode:setVisible(true)
                end
            end
        end
    end

    return true
end

function HeroRenderer:getAttackAnimationName()
    if(self._looks == 0) then
        local randNum = 1
        -- 随机获取攻击动画
        randNum = math.random(100)%2 + 1
        return self:getAttackAnimationNameForNum(randNum)
    else
        return "attack"
    end
end

-- 根据num 获取攻击动画类型
function HeroRenderer:getAttackAnimationNameForNum(num)
    if(num > 2) then
        num = 2
    elseif (num<=0) then
        num = 1
    end

    return string.format("attack_%d_%d", num, self._weaponType)
end

function HeroRenderer:getAttackIdleAnimationName()

    return string.format("attackidle_%d",self._weaponType)
end

function HeroRenderer:getDeadAnimationName()

    return string.format("dead_%d",self._weaponType)
end

function HeroRenderer:getHappyAnimationName()

    return string.format("happy_%d",self._weaponType)
end

function HeroRenderer:getIdleAnimationName()
    if self:isRide() and self._heroRideAnimation and self._looks == 0 then
        local petData = self._tempModel._heroData:getCaptainPetData()
        if petData and petData.rideAnimation and petData.rideAnimation ~= "" then
            local name = "ride_idle1"
            local animeList = string.split(petData.rideAnimation, ";")
            if #animeList > 0 then
                local animeList2 = string.split(animeList[1], ",")
                if #animeList2 == 1 then
                    name = animeList2[1]
                elseif #animeList2 > 1 then
                    if petData.isVariant then
                        name = animeList2[2]
                    else
                        name = animeList2[1]
                    end
                end
            end

            return name
        end
        if (petData and petData.templateID == 1020) then
            return "ride_idle3"
        elseif (petData and petData.templateID == 1031) then
            return "ride_idle8"
        else
            return "ride_idle1"
        end
    end

    if(self._looks ==0) then
        if self._isFightScene then
            return string.format("idle_%d",self._weaponType)
        else 
            return string.format("idle_town_%d",self._weaponType)
        end
    else
        return "idle1"
    end
end

function HeroRenderer:getMoveAnimationName()
    -- print("self._looks ====222== ",self._looks)
    if self:isRide() and self._heroRideAnimation and self._looks == 0 then
        local petData = self._tempModel._heroData:getCaptainPetData()
        
        if petData and petData.rideAnimation and petData.rideAnimation ~= "" then
            local name = "ride_run"
            local animeList = string.split(petData.rideAnimation, ";")
            if #animeList > 1 then
                local animeList2 = string.split(animeList[2], ",")
                if #animeList2 == 1 then
                    name = animeList2[1]
                elseif #animeList2 > 1 then
                    if petData.isVariant then
                        name = animeList2[2]
                    else
                        name = animeList2[1]
                    end
                end
            end
            return name
            -- return animeList[2]
        end

        if (petData and self:isRideRun1(petData.templateID)) then
            return "ride_run1"
        elseif (petData and petData.templateID == 1018) then
            return "ride_run2"
        elseif (petData and petData.templateID == 1020) then
            -- print("petData.templateID ==== ",petData.templateID)
            return "ride_run3"
        elseif (petData and petData.templateID == 1031) then
            return "ride_run8"
        else 
            return "ride_run"
        end
    end

    if(self._looks ==0) then
        if self._isFightScene then
            return string.format("move_%d",self._weaponType)
        else 
            return string.format("move_town_%d",self._weaponType)
        end
    else
        return "move_0"
    end
end

function HeroRenderer:getReviveAnimationName()

    return string.format("revive_%d",self._weaponType)
end


-- 添加测试名字
function HeroRenderer:addName(spriteID,pk)
    if DEVELOPMENT_MODE then
        require "app.ui.gmUtil.GMUtilExecutor"
        if (UI.GMUtilExecutor:getShowTestUI()) then
            local heroData = RoleDataManager:getHeroDataForPK(pk)
            local userID = 0
            if(heroData) then
                userID = heroData:getUserID()
            end

            self.testTitleLabel = cc.Label:createWithSystemFont(string.format("%d:%d:%d", pk, spriteID, userID), "Arial", 20)
            self.testTitleLabel:setPosition(cc.p(0, 240))
            self._viewNode:addChild(self.testTitleLabel,100)
        end
    end
end

function HeroRenderer:getRoleAnimationSize()
    local size = self._roleAnimation:getBoundingBox()
    return size
end

function HeroRenderer:_changeAnimation(newAnimation)
    if(newAnimation) then
        if(self._roleAnimation ~= newAnimation) then
            self:removeAllFxFromNowRoleAnimation()
            self._roleAnimation = newAnimation
            if(self._heroSelfAnimation == self._roleAnimation) then
                self:setRoleAnimationSize(self._selfHeroAnimationSize)
            else 
                self:setRoleAnimationSize(self._lookAnimationSize)
            end

            if(self._roleAnimation ~= self._heroSelfAnimation) then
                self._heroSelfAnimation:setPosition(100000,100000)
            end
            self:setRoleAnimationPosition(0,0)

            self:setDirection(self._direction)
            self:addAllFxToNowRoleAnimation()
        end
    end
end

function HeroRenderer:_triggerRevive()
    if (self._isMaster == true) then
        if(self._showRevive) then
            if(self._dieCallBack) then
                self._dieCallBack()
                self._dieCallBack = nil
            else
                Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE)
            end

            self._showRevive = false
        end
    else 
        if(self._showRevive) then
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SHOW_HELP_REVIVE, self._PK)
            self._showRevive = false
        end
    end
end

-- 注册英雄动画事件
function HeroRenderer:_registerHeroSpineEventHandle()
    self._heroSelfAnimation:registerSpineEventHandler(function(event)
        if event.animation == "dead_0" or event.animation == "dead_1" or event.animation == "dead_2" or event.animation == "dead_3" or event.animation == "dead_4" then
            -- 处理死亡触发
            --print("event.animation == self:getDeadAnimationName() _registerHeroSpineEventHandle currentTime=",AvalonUtil:getCurrentTime())
            self:_triggerGhost()
        elseif event.animation == "revive_0" or event.animation == "revive_1" or event.animation == "revive_2" or event.animation == "revive_3" or event.animation == "revive_4" then
            -- 复活动画完成，恢复战斗前位置
            self:_reviveEnd()
        elseif (event.animation == self:getIdleAnimationName()) then
            -- 9 88 交替播放
            -- Avalon.AudioManager:playSound("501")
        end
    end, sp.EventType.ANIMATION_END)

    self._heroSelfAnimation:registerSpineEventHandler(function (event)

        if self:isRide() then return end
        
        if(string.find(event.animation, "idle_town_")) then
            -- 切换城镇特殊表现
            if self._idleNum == nil then
                self._idleNum = 0
            end
            self._idleNum = self._idleNum + 1   
            if(self._idleNum >3) then
                if math.random(1,4) <=1 then
                    -- --print("MonsterRenderer:_registerSpineEventHandler ANIMATION_COMPLETE run idle2")
                    self._idleNum = 0
                    self._roleAnimation:setAnimation(0, "idle_fun_"..math.random(1,4), false)
                    self._roleAnimation:addAnimation(0, self:getIdleAnimationName(), true)
                end
            end
        elseif (string.find(event.animation, "ride_idle1")) then
            if self._idleNum == nil then
                self._idleNum = 0
            end
            self._idleNum = self._idleNum + 1   
            if(self._idleNum >3) then
                if math.random(1,4) <=1 then
                    self._idleNum = 0
                    self._roleAnimation:setAnimation(0, "ride_idle2", false)
                    self._roleAnimation:addAnimation(0, self:getIdleAnimationName(), true)
                end
            end
        end

        self:_triggerRefreshWaiting()
    end, sp.EventType.ANIMATION_COMPLETE)

    self._heroSelfAnimation:registerSpineEventHandler(function (event)
        -- if(event.animation == self:getAttackAnimationNameForNum(1)) then
        --     Avalon.AudioManager:playSoundDelay("86",366)
        -- elseif (event.animation == self:getAttackAnimationNameForNum(2)) then
        --     Avalon.AudioManager:playSoundDelay("87",366)
        -- end
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- 播放音效文件
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

        if (event.animation == "dead_0" 
            or event.animation == "idle_0" 
            or event.animation == "idle_fun_0" 
            or event.animation == "move_0" 
            or event.animation == "dead_1" 
            or event.animation == "idle_fun_1" 
            or event.animation == "dead_2" 
            or event.animation == "idle_2" 
            or event.animation == "idle_fun_2" 
            or event.animation == "move_2" 
            or event.animation == "dead_3" 
            or event.animation == "idle_3" 
            or event.animation == "idle_fun_3" 
            or event.animation == "move_3" 
            or event.animation == "hitrat" 
            or event.animation == "idle_fun_4" 
            or event.animation == "move_town_2" 
            or event.animation == "revive_0" 
            or event.animation == "ride_idle1" 
            or event.animation == "revive_1" 
            or event.animation == "ride_idle2" 
            or event.animation == "ride_idle3" 
            or event.animation == "revive_2" 
            or event.animation == "ride_run" 
            or event.animation == "revive_3" 
            or event.animation == "ride_run1"
            or event.animation == "ride_run3"
            or event.animation == "ride_run2"
            or event.animation == "ride_run4"
            or event.animation == "ride_idle4"
            or event.animation == "ride_run5"
            or event.animation == "ride_idle5"
            or event.animation == "ride_run8"
            or event.animation == "ride_idle8") then
            
            self:sChangeWeapon(true);
        else
            self:sChangeWeapon(false);

        end

        --处理钓鱼状态时换装时,还是选择鱼竿作为武器
        if (event.animation == "fishing_idle" 
        or event.animation == "fish_back" 
        or event.animation == "fish_back_idle" 
        or event.animation == "fish_catch" 
        or event.animation == "fish_forward" 
        or event.animation == "fish_forward_fail" 
        or event.animation == "fish_idle" 
        or event.animation == "fish_lost" 
        or event.animation == "fish_took_1" 
        or event.animation == "fish_took_2" ) then
            self._isFishing = true
        else
            self._isFishing = false
        end


        --CO-16977 特殊处理-------------------------------
        if self._equipmentArr[EQUIPMENT_TYPE.Weapon] then
            if (event.animation == "dead_0" 
            or event.animation == "idle_0" 
            or event.animation == "idle_fun_0" 
            or event.animation == "move_0" 
            or event.animation == "dead_1" 
            -- or event.animation == "idle_1" 
            or event.animation == "idle_fun_1" 
            -- or event.animation == "move_1" 
            or event.animation == "dead_2" 
            or event.animation == "idle_2" 
            -- or event.animation == "idle_fun_2" 
            or event.animation == "move_2" 
            or event.animation == "dead_3" 
            or event.animation == "idle_3" 
            or event.animation == "idle_fun_3" 
            or event.animation == "move_3" 
            or event.animation == "hitrat" 
            or event.animation == "idle_fun_4" 
            or event.animation == "move_town_2" 
            or event.animation == "revive_0" 
            or event.animation == "ride_idle1" 
            or event.animation == "revive_1" 
            or event.animation == "ride_idle2" 
            or event.animation == "ride_idle3" 
            or event.animation == "revive_2" 
            or event.animation == "ride_run" 
            or event.animation == "revive_3" 
            or event.animation == "ride_run3" 
            or event.animation == "ride_run2" 
            or event.animation == "ride_run1"
            or event.animation == "ride_run4"
            or event.animation == "ride_idle4"
            or event.animation == "ride_run5"
            or event.animation == "ride_idle5"
            or event.animation == "ride_run8"
            or event.animation == "ride_idle8") then
                for _, v in pairs(self._equipmentArr[EQUIPMENT_TYPE.Weapon]) do
                    if v and not tolua.isnull(v) then
                        v:setVisible(false)
                    end
                end
            else
                for _, v in pairs(self._equipmentArr[EQUIPMENT_TYPE.Weapon]) do
                    if v and not tolua.isnull(v) then
                        v:setVisible(true)
                    end
                end
            end
        end
        ------------------------------------------------------------------------------
    end, sp.EventType.ANIMATION_START)
end

-- 触发加载动画完成
function HeroRenderer:_triggerLoadSpineSuccess()
    HeroRenderer.super._triggerLoadSpineSuccess(self)

    -- 处理跳伤害的处理
    self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(function()
        local size = self._roleAnimation:getBoundingBox()
        self.setRoleAnimationSize(size)
        self._selfHeroAnimationSize = size
    end)))

    -- 更新spriteID显示位置
    if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
        if self.testTitleLabel then
            self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(function()
                local size = self._roleAnimation:getBoundingBox()
                self.testTitleLabel:setPosition(cc.p(0, size.height+40))
            end)))
        end
    end
end

-- 触发添加鬼魂
function HeroRenderer:_triggerGhost()
    if (self._ghostAnimation) then
        self._ghostAnimation:runAction(cc.RemoveSelf:create())
        self._ghostAnimation = nil
    end

    if(self._inRevive ) then
        return
    end
    local GHOST_DEAD_ANIMATION_NAME = "ghost_dead"
    self._ghostAnimation = Avalon.Animation:create("effect_role_hero_ghost.json", "effect_role_hero_ghost.atlas", 1.0);
    if self._recoverDead == true then
        self._ghostAnimation:setAnimation(0,"ghost_loop",true)
        -- 更具情况做相关的逻辑处理
    else
        self._ghostAnimation:setAnimation(0,GHOST_DEAD_ANIMATION_NAME,false)
        self._ghostAnimation:addAnimation(0,"ghost_loop",true)
    end

    self._ghostAnimation:registerSpineEventHandler(function(event)
        -- --print("HeroRenderer:_triggerGhost end animation=",event.animation)
        if event.animation == GHOST_DEAD_ANIMATION_NAME then

        elseif event.animation == GHOST_REVIVE_ANIMATION_NAME then
            -- 复活完成
            --print("HeroRenderer:_triggerGhost  role revive success.")
            self:_ghostReviveEnd()
        end
    end, sp.EventType.ANIMATION_END)

    self._ghostAnimation:registerSpineEventHandler(function(event)
        if event.eventData.name == "dead_countdown" then
            -- 触发复活倒计时
            --print("HeroRenderer:_triggerGhost   dead_countdown")
            -- self._showDie = false
            -- if (self._isMaster == true) then
                if(self._showRevive) then
                    self:_triggerRevive()
                end
            -- end
        end

        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- 播放音效文件
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
    end,sp.EventType.ANIMATION_EVENT)

    -- 同步方向
    self._ghostAnimation:setScaleX(self._roleAnimation:getScaleX())

    self:addChild(self._ghostAnimation, ROLE_GHOST_ZORDER)

    -- 罗阳那边提出倒计时和死亡鬼魂一起出来
    self._showDie = false
    -- if (self._isMaster == true) then
        if(self._showRevive) then
            self:_triggerRevive()
        end
    -- end

    -- self:selfAddComponent("mount_bottom",self._ghostAnimation)
end

function HeroRenderer:_triggerSkillAdvanced()
    local skillAdvancedAnimation = Avalon.Animation:create("effect_role_hero_zhuanhuanzhiye.json", "effect_role_hero_zhuanhuanzhiye.atlas", 0.6);

    -- Avalon.AudioManager:playDynamicSound("504",nil,self:getCoord())

    skillAdvancedAnimation:setAnimation(0,"trigger",false)

    skillAdvancedAnimation:registerSpineEventHandler(function(event)
        skillAdvancedAnimation:runAction(cc.RemoveSelf:create())
    end, sp.EventType.ANIMATION_END)

    skillAdvancedAnimation:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- 播放音效文件
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

    self:addChild(skillAdvancedAnimation, ROLE_LEVEL_UP_ZORDER)
end

function HeroRenderer:_triggerLevelUp(isBag)
    if(isBag == nil) then
        isBag = false
    end
    local levelUpAnimation = Avalon.Animation:create("effect_role_hero_levelup.json", "effect_role_hero_levelup.atlas", 0.6);

    -- Avalon.AudioManager:playSound("504")
    Avalon.AudioManager:playDynamicSound("504",nil,self:getCoord())

    if(isBag) then
        levelUpAnimation:setAnimation(0,"animation2",false)
    else
        levelUpAnimation:setAnimation(0,"animation",false)
    end

    levelUpAnimation:registerSpineEventHandler(function(event)
        --print("HeroRenderer:_triggerLevelUp end animation=",event.animation)
        -- if event.animation == "animation" then
           levelUpAnimation:runAction(cc.RemoveSelf:create())
        -- end
    end, sp.EventType.ANIMATION_END)

    levelUpAnimation:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- 播放音效文件
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

function HeroRenderer:_triggerLevelUpAttr(attrArr)
    local levelUpAttrAnimation = Avalon.Animation:create("effect_role_hero_levelup_information.json", "effect_role_hero_levelup.atlas", 0.6);

    levelUpAttrAnimation:setAnimation(0,"animation",false)

    levelUpAttrAnimation:registerSpineEventHandler(function(event)
        --print("HeroRenderer:_triggerLevelUpAttr end animation=",event.animation)
        if event.animation == "animation" then
           levelUpAttrAnimation:runAction(cc.RemoveSelf:create())
        end
    end, sp.EventType.ANIMATION_END)

    levelUpAttrAnimation:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- 播放音效文件
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

function HeroRenderer:isDecorateValue(dValue)
    local useValue = PublicDefine.UseUIDecorateValue.DecorateValue_Default
    local masterData = GameDataManager:getInstance():getMaster()
    if not masterData then
        return useValue
    end

    local eData = masterData:getGameUIEquippedDecorates()
    for k,v in pairs(eData) do
        if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_Portal then
            if v.value == dValue then
                useValue = dValue
                break;
            end
        end
    end

    return useValue
end

function HeroRenderer:initUseUIValue()
    local isTiger = false
    local appendStr = ""
    for i = PublicDefine.UseUIDecorateValue.DecorateValue_Tiger, PublicDefine.UseUIDecorateValue.DecorateValue_Max - 1, 1 do
        local useValue = self:isDecorateValue(i)
        if useValue ~= PublicDefine.UseUIDecorateValue.DecorateValue_Default then
            isTiger = true
            if useValue == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger then
                appendStr = "_tiger"
            elseif useValue == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate then
                appendStr = "_pirate"
            end
        end
    end
    return isTiger,appendStr
end

function HeroRenderer:_backTown(isMaster)
    -- local backTownUp = Avalon.Animation:create("effect_role_hero_backtown_up.json", "effect_role_hero_backtown.atlas", 1.0);
    -- local backTownDown = Avalon.Animation:create("effect_role_hero_backtown_down.json", "effect_role_hero_backtown.atlas", 1.0);

    -- local isTiger = false

    -- local masterData = GameDataManager:getInstance():getMaster()
    -- if masterData then
    --     local eData = masterData:getGameUIEquippedDecorates()

    --     for k,v in pairs(eData) do
    --         if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_Portal then
    --             if v.value == 1 then --虎年
    --                 isTiger = true
    --                 break
    --             end
    --         end
    --     end
    -- end

    local isTiger,appendStr = self:initUseUIValue()
    

    local backTownUp = nil
    local backTownDown = nil

    if not isMaster then
        local heroData = RoleDataManager:getHeroDataForPK(self._PK)
        local portalEffect = 0
        
        if heroData then
            portalEffect = heroData:getPortalEffect()
        end
        if portalEffect > 0 then
            local effctStr = "_tiger"
            if portalEffect == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger then
                effctStr = "_tiger"
            elseif portalEffect == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate then
                effctStr = "_pirate"
            end
            local backTownUpJson = string.format("effect_role_hero_backtown%s_up.json",effctStr)
            local backTownUpAtlas = string.format("effect_role_hero_backtown%s.atlas",effctStr)
            local backTownDownJson = string.format("effect_role_hero_backtown%s_down.json",effctStr)
            local backTownDownAtlas = string.format("effect_role_hero_backtown%s.atlas",effctStr)

            -- backTownUp = Avalon.Animation:create("effect_role_hero_backtown_tiger_up.json", "effect_role_hero_backtown_tiger.atlas", 1.0)
            -- backTownDown = Avalon.Animation:create("effect_role_hero_backtown_tiger_down.json", "effect_role_hero_backtown_tiger.atlas", 1.0)
            backTownUp = Avalon.Animation:create(backTownUpJson, backTownUpAtlas, 1.0)
            backTownDown = Avalon.Animation:create(backTownDownJson, backTownDownAtlas, 1.0)
        else
            backTownUp = Avalon.Animation:create("effect_role_hero_backtown_up.json", "effect_role_hero_backtown.atlas", 1.0)
            backTownDown = Avalon.Animation:create("effect_role_hero_backtown_down.json", "effect_role_hero_backtown.atlas", 1.0)
        end
        
    else
        if isTiger and isMaster then
            local backTownUpJson = string.format("effect_role_hero_backtown%s_up.json",appendStr)
            local backTownUpAtlas = string.format("effect_role_hero_backtown%s.atlas",appendStr)
            local backTownDownJson = string.format("effect_role_hero_backtown%s_down.json",appendStr)
            local backTownDownAtlas = string.format("effect_role_hero_backtown%s.atlas",appendStr)

            -- backTownUp = Avalon.Animation:create("effect_role_hero_backtown_tiger_up.json", "effect_role_hero_backtown_tiger.atlas", 1.0)
            -- backTownDown = Avalon.Animation:create("effect_role_hero_backtown_tiger_down.json", "effect_role_hero_backtown_tiger.atlas", 1.0)
            backTownUp = Avalon.Animation:create(backTownUpJson, backTownUpAtlas, 1.0)
            backTownDown = Avalon.Animation:create(backTownDownJson, backTownDownAtlas, 1.0)
        else
            backTownUp = Avalon.Animation:create("effect_role_hero_backtown_up.json", "effect_role_hero_backtown.atlas", 1.0)
            backTownDown = Avalon.Animation:create("effect_role_hero_backtown_down.json", "effect_role_hero_backtown.atlas", 1.0)
        end
    end

    if(isMaster) then
        backTownDown:setAnimation(0,"animation",true)
        backTownUp:setAnimation(0,"animation",true)
    else
        backTownDown:setAnimation(0,"animation",false)
        backTownUp:setAnimation(0,"animation",false)
    end

    backTownUp:registerSpineEventHandler(function(event)
        if event.eventData.name == "hero_disappear" then
            --print("HeroRenderer:backTownUp   hero_disappear")
            -- 触发回城消失
            -- local fadeOut = cc.FadeOut:create(0.7)
            -- if self._roleAnimation then
            --     --print("HeroRenderer:backTownUp   hero_disappear runAction")
            --     self._roleAnimation:runSpineAction(fadeOut)
            -- end
        end

        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- 播放音效文件
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
    end,sp.EventType.ANIMATION_EVENT)

    backTownUp:registerSpineEventHandler(function(event)
        --print("HeroRenderer:_triggerGhost end animation=",event.animation)
        if event.animation == "animation" then
            -- 触发回城结算界面
            -- local battleCMD = Command.BattleCommand:create(true)
            -- battleCMD:initForTypeAndData(CommandType.BATTLE_ROLE_REWARD,nil)
            -- MachineManager:getInstance():executeCommand(battleCMD)

            -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD)
        end
        -- 移除对应动画
        if(isMaster == false) then
            if(backTownDown) then
                backTownDown:runAction(cc.RemoveSelf:create())
            end
            if(backTownUp) then
                backTownUp:runAction(cc.RemoveSelf:create())
            end

            self._backTownDown = nil
            self._backTownUp = nil
        end
    end, sp.EventType.ANIMATION_END)

    -- self:addChild(backTownDown, ROLE_ANIMATION_BOTTOM_DOWN)
    self:addChild(backTownDown, -10)
    self:addChild(backTownUp,ROLE_ANIMATION_BOTTOM)

    self._backTownDown = backTownDown
    self._backTownUp = backTownUp
end

function HeroRenderer:_ghostReviveEnd()
    if (self._ghostAnimation) then
        self._ghostAnimation:runAction(cc.RemoveSelf:create())
        self._ghostAnimation = nil
    end

    if self._roleAnimation then
        self._roleAnimation:setAnimation(0,self:getReviveAnimationName(),false)
        -- -- 显示复活特效
        -- self:_reviveEffect()
    else
        -- 直接恢复战斗前状态
        self:_reviveEnd()
    end
end

function HeroRenderer:_reviveEffect()
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
                -- 播放音效文件
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

-- 复活表现完成
function HeroRenderer:_reviveEnd()
    if(self._reviveEndPositionX and self._reviveEndPositionY) then
        if self._reviveCallBack then
            self._reviveCallBack()
            self._reviveCallBack = nil
        end
        self._inRevive = false
    else
        if self._reviveCallBack then
            self._reviveCallBack()
            self._reviveCallBack = nil
        end
        self._inRevive = false
    end

    --还原骑乘表现
    self:createHeroRidePetRunderer(self._tempModel)
end

function HeroRenderer:showExpression(spineAction, direction)
    --print("-----------direction = "..direction)
    if not tolua.isnull(spineAction) then
        local node = UI.Layout:create()
        node:init(0,0,0,0)
        node:setSize(100, 100)    
        node:addChild(spineAction)
        self._viewNode:addChild(node, 101)
        local scale = 1
        if (direction == DirectionType.EAST or direction == DirectionType.SOUTH) then
            node:setScaleX(-1)
            scale = 1
        else
            scale = -1
        end
        node:setPosition(-50 + 80 * scale, 70)
    end
end

function HeroRenderer:showDreamStyleName(nickName, guildName)
    nickName = nickName or ""

    local viewNode = self:getView()
    -- 名字自动排版
    local nameLayout = UI.Layout:create()
    nameLayout:init()
    nameLayout:enableAutoHeight()
    nameLayout:enableAutoWidth()
    nameLayout:centerBottom(140)
    viewNode:addChild(nameLayout, 100)

    -- 名字
    local nickNameLabel = UI.Text:create()
    nickNameLabel:init(nickName, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_212_96_203)
    nickNameLabel:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
    nickNameLabel:floatUp(0)
    nameLayout:addComponent(nickNameLabel)

    -- 公会
    if(guildName and guildName ~= "") then
        local guildNameText = UI.Text:create()
        guildNameText:init("<" .. guildName .. ">", UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_212_96_203)
        guildNameText:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
        guildNameText:floatUp(0)
        nameLayout:addComponent(guildNameText)
    end
end

function HeroRenderer:setCoord(x, y)
    HeroRenderer.super.setCoord(self, x, y)
    self:updateGuidePointerView()
end

function HeroRenderer:setShowGuidePointer(isShowGuidePointer, title, targetX, targetY)
    -- 设置开启的时候需要的参数
    self._guideTitle = title
    self._guideTargetX = targetX
    self._guideTargetY = targetY

    -- 初始化
    self:initGuidePointerIfDidNot()
    
    -- 动画出现和消失
    local isPointerVisible = self._pointerAnchor:isVisible()
    if (isShowGuidePointer and not isPointerVisible) then
        self._pointerAnchor:setVisible(true)
        self._pointerAnchor:setScale(0)
        self._pointerAnimation:setTimeScale(1)
        self._pointerAnchor:runAction(cc.EaseBackOut:create(cc.ScaleTo:create(0.4, 1)))
    elseif (not isShowGuidePointer and isPointerVisible) then
        self._pointerAnchor:runAction(cc.Sequence:create(
            cc.EaseBackIn:create(cc.ScaleTo:create(0.3, 0)),
            cc.CallFunc:create(function()
                self._pointerAnchor:setVisible(false)
                self._pointerAnchor:setScale(1)
                self._pointerAnimation:setTimeScale(0)
            end)))
    end

    -- 设置方向更新开关
    if (not isShowGuidePointer) then
        self._isUpdatingGuidePointer = false
        return
    end

    -- 立马更新一次
    self._isUpdatingGuidePointer = true
    self:updateGuidePointerView()
end

function HeroRenderer:initGuidePointerIfDidNot()
    --创建指针显示
    if (not self._pointerAnchor) then
        self._pointerAnchor = UI.Component:create()
        self._pointerAnchor:init()
        self._pointerAnchor:setVisible(false)
        self._pointerAnchor:centerBottom(235)
        self:addChild(self._pointerAnchor, 100)

        self._pointerAnimation = UI.Animation:create()
        self._pointerAnimation:init("effect_ui_twon_enter.json", "effect_ui_twon_enter.atlas", 1.0)
        self._pointerAnimation:setAnimation("idle", true)
        self._pointerAnchor:addChild(self._pointerAnimation)

        local textLabel = UI.Text:create()
        textLabel:init(self._guideTitle, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_WHITE)
        textLabel:centerBottom(20)
        self._pointerAnchor:addChild(textLabel)
    end
end

function HeroRenderer:updateHitRatBuff(isGood)
    local ratHitBuffEff = UI.Animation:create()
    if isGood then
        ratHitBuffEff:init("effect_buff_zengyi.json", "effect_buff_zengyi.atlas", 1.0)
    else
        ratHitBuffEff:init("effect_buff_jianyi.json", "effect_buff_jianyi.atlas", 1.0)
    end
    ratHitBuffEff:setAnimation("trigger", false)
    self:addChild(ratHitBuffEff)

    ratHitBuffEff:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        ratHitBuffEff:runAction(cc.RemoveSelf:create())
    end)
end

function HeroRenderer:updateGuidePointerView()
    if (not self._isUpdatingGuidePointer or not self._pointerAnimation or not self._guideTargetX or not self._guideTargetY) then return end
    
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    if (not machine) then return end

    -- 箭头转向
    targetScreenX, targetScreenY = machine:convertCoordToTouchPosition({x = self._guideTargetX, y = self._guideTargetY})
    heroScreenPos = self._pointerAnchor:convertToWorldSpace(cc.p(0, 0))
    local deltaX = targetScreenX - heroScreenPos.x
    local deltaY = targetScreenY - heroScreenPos.y
    local angleRadian = math.atan2(deltaX, deltaY)
    local angleDegree = angleRadian * (180 / math.pi)
    self._pointerAnimation:rotate(angleDegree + 180)

    -- 箭头压缩
    local compressRate = 0.4
    local sin = math.sin(angleRadian)
    local cos = math.cos(angleRadian)
    local compressX = 1 - math.abs(sin * compressRate)
    local compressY = 1 - math.abs(cos * compressRate)
    self._pointerAnimation:setScaleX(compressX)
    self._pointerAnimation:setScaleY(compressY)
end

function HeroRenderer:updateExpeditionStatus(expeditionStatus)
    self._expeditionStatus = expeditionStatus
    if(not tolua.isnull(self._expeditionImage)) then 
        self._expeditionImage:setVisible(expeditionStatus)
    end
end

function HeroRenderer:pause()
    HeroRenderer.super.pause(self)
    
    if(not tolua.isnull(self._horcruxExteriorAnimation)) then
        self._horcruxExteriorAnimation:pause()
    end
    for _, arr in pairs(self._equipmentArr) do 
        if(arr and #arr) then 
            for k, animation in pairs(arr) do 
                if(not tolua.isnull(animation)) then
                    animation:pause()
                end
            end
        end
    end
end

function HeroRenderer:resume()
    HeroRenderer.super.resume(self)
    if(not tolua.isnull(self._horcruxExteriorAnimation)) then
        self._horcruxExteriorAnimation:resume()
    end
    for _, arr in pairs(self._equipmentArr) do 
        if(arr and #arr) then 
            for k, animation in pairs(arr) do 
                if(not tolua.isnull(animation)) then
                    animation:resume()
                end
            end
        end
    end
end

function HeroRenderer:setDirection(direction)
    HeroRenderer.super.setDirection(self, direction)
    if(self.lostRealmNumImage) then
        if(self._isTurnAround) then
            if (direction == DirectionType.EAST or
                direction == DirectionType.SOUTH) then
                self.lostRealmNumImage:setScaleX(-1)
            else
                self.lostRealmNumImage:setScaleX(1)
            end
        end
    end
end

--[[
    lostStep: 剩余步数
]]
function HeroRenderer:showLostRealm(lostStep)
    local spriteName = string.format("ui_monopoly_stepcount_big_0%d.png", lostStep)
    if(not self.lostRealmAnimation) then 
        self.lostRealmAnimation = Avalon.Animation:create("effect_ui_town_lostrealm_bsdaojishi.json", "effect_ui_town_lostrealm_bsdaojishi.atlas", 1)
        self.lostRealmAnimation:setVisible(false)
        self.lostRealmAnimation:setPosition(0, 60)
        self._heroSelfAnimation:addComponent("mount_icon", self.lostRealmAnimation)

        local image = UI.Image:create()
        image:init(spriteName)
        image:center()
        self.lostRealmAnimation:addComponent("num", image, true)
        self.lostRealmNumImage = image
    end
    if(not self.lostRealmAnimation:isVisible()) then 
        self.lostRealmAnimation:setVisible(true)
        self.lostRealmAnimation:setAnimation(0, "begin", false)
        self.lostRealmAnimation:addAnimation(0, "idle", true)
        self.lostRealmNumImage:setSpriteName(spriteName)
    else
        self.lostRealmAnimation:setAnimation(0, "trigger", false)
        self.lostRealmAnimation:addAnimation(0, "idle", true)
        self.lostRealmAnimation:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "num")
                if(startPos ~= nil) then
                    self.lostRealmNumImage:setSpriteName(spriteName)
                end
            end
        end, sp.EventType.ANIMATION_EVENT)
    end

    self:setDirection(self._direction)
end

function HeroRenderer:hideLostRealm()
    if(self.lostRealmAnimation) then 
        self.lostRealmAnimation:setVisible(false)
    end
end


function HeroRenderer:heroSelfAddComponent(mountName, animationNode)
    if(self._heroSelfAnimation and animationNode and mountName) then
        self._heroSelfAnimation:addComponent(mountName, animationNode)
        local slotNode = self._heroSelfAnimation:getNodeForSlot(mountName, true)
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

function HeroRenderer:setRideType(petData)
    self._isReadyRide = petData.isRide and petData:isRide() or false
end

function HeroRenderer:hidePet(isRide)
    self._isReadyRide = isRide
end

function HeroRenderer:isRide()
    return self._isReadyRide or false
end

--hero偏移坐标
function HeroRenderer:setRoleAnimationDisplacementPosition(pos)
    self.roleAnimationPrePos = pos
    self:setRoleAnimationPosition(0,0)
end

function HeroRenderer:getRoleAnimationDisplacementPosition()
    return self.roleAnimationPrePos or {x=0,y=0}
end

function HeroRenderer:setRoleAnimationPosition(x,y)
    local prePos = self:getRoleAnimationDisplacementPosition()
    self._roleAnimation:setPosition(x + prePos.x,y + prePos.y)

    if self._headLayout then
        self._headLayout:centerBottom(140 + prePos.y)
    end
end

--创建骑乘宠物
function HeroRenderer:createHeroRidePetRunderer(model, fightPetData, force)
    if (not model and not fightPetData) then
        self._tempModel = nil
        -- print( "createHeroRidePetRunderer    111111111"  )
        return
    end
    self._tempModel = model
    local petData = nil
    if fightPetData then
        petData = fightPetData
    else
        petData = self._tempModel._heroData:getCaptainPetData()
    end
    

    if petData and petData:getState() == FSMState.BATTLE then
        return
    end

    if self._PK then
        local heroData = RoleDataManager:getHeroDataForPK(self._PK)
        if heroData and heroData:getState() == FSMState.BATTLE then
            return
        end
    end

    
    if not self._roleAnimation or not self:isRide() or not petData or (self._looks ~= 0 and not force) then
        -- print( "createHeroRidePetRunderer    22222222222222"  ,self:isRide(), self._looks)
        return
    end

    if not self._heroRideAnimation then
        local skeletonFile, atlasFile, scale = petData:getAnimationData()
        local sceneScale = petData:getSceneScale()

        --骑宠动画对象
        self._heroRideAnimation = Avalon.Animation:create(skeletonFile, atlasFile, scale)
        -- self._heroRideAnimation._spine:setScale(sceneScale or 1)
        local zOrder = self._roleAnimation:getLocalZOrder()
        local parent = self._roleAnimation:getParent()
        -- print("createHeroRidePetRunderer zOrder ===== ",zOrder,scale, sceneScale)
        parent:addChild(self._heroRideAnimation,zOrder-1)
        -- self._heroRideAnimation:update(0)

        -- self._heroRideAnimation:setTimeScale(self._roleAnimation._timeScale)

        if self._heroRideAnimation._spine then
            self._heroRideAnimation._spine:setScale(sceneScale or 1)
        end

        self._heroRideAnimation._loadedSpineSuccessCallBack = function()
            self._heroRideAnimation._spine:setScale(sceneScale or 1)

            local positionOfSlotX,positionOfSlotY = self._heroRideAnimation:getPositionOfSlot("ride_top")
            self:setRoleAnimationDisplacementPosition({x=positionOfSlotX,y=positionOfSlotY})
        end

        self._heroRideAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
            local positionOfSlotX,positionOfSlotY = self._heroRideAnimation:getPositionOfSlot("ride_top")
            self:setRoleAnimationDisplacementPosition({x=positionOfSlotX,y=positionOfSlotY})
        end)))


        -- print("showIDLEshowIDLEshowIDLE 22222222222222 ")
        self:setHeroRidePetIdleShow()
        self:addDeformationView(false,true)
        self:showIDLE()
        self:setHeroRidePetDirection()

        --如果是狐仙骑宠,则隐藏角色
        self:transformHuli()
    end

    local positionOfSlotX,positionOfSlotY = self._heroRideAnimation:getPositionOfSlot("ride_top")
    -- print(" positionOfSlotX,positionOfSlotY ==== ", positionOfSlotX,positionOfSlotY)
    self:setRoleAnimationDisplacementPosition({x=positionOfSlotX,y=positionOfSlotY})
    
    self:setHeroHaloEffectShow()
    
end

function HeroRenderer:transformHuli()
    --如果是狐仙骑宠,则隐藏角色
    if self._tempModel and self._tempModel._heroData then
        local petData = self._tempModel._heroData:getCaptainPetData()
        if (petData and petData.templateID == 1032 and self:isRide()) then
            self._roleAnimation:hide()
        end
    end
end

--移除骑乘宠物
function HeroRenderer:removeHeroRidePetRunderer(notShow)
    --如果是狐仙骑宠,则显示角色
    if self._tempModel then
        local petData = self._tempModel._heroData:getCaptainPetData()
        if (petData and petData.templateID == 1032) then
            self._roleAnimation:show()
        elseif not self._roleAnimation:isVisible() then
            self._roleAnimation:show()
        end
    end

    self._tempModel = nil
    -- print( " 进来没!!!!!!!!!!!!!!!!啊啊啊   ",notShow)
    if not self._roleAnimation then
        return
    end

    if self._heroRideAnimation then
        self._heroRideAnimation:removeFromParent()
        self._heroRideAnimation = nil
        self:addDeformationView(false,true)
        if not notShow then
            self:showIDLE()
        end
    end

    self:setRoleAnimationDisplacementPosition({x=0,y=0})

    -- if not notShow then
    --     print(" showIDLEshowIDLEshowIDLE  ")
    --     self:showIDLE()
    -- end

    self:setHeroHaloEffectShow()

    
    
end

-- --设置骑乘宠物方向
-- function HeroRenderer:setHeroRidePetDirection()
--     print(" 骑乘转向!!!!!!!!!  ")
--     if not self._heroRideAnimation then
--         return
--     end
--     local direction = self._direction
--     if (direction == DirectionType.EAST or
--         direction == DirectionType.SOUTH) then
--         self._heroRideAnimation:setScaleX(-1)
--         print(" 骑乘转向!!!!!!!!!  11 ")
--     else
--         self._heroRideAnimation:setScaleX(1)
--         print(" 骑乘转向!!!!!!!!!  222")
--     end
-- end

--骑乘宠物移动动画
function HeroRenderer:setHeroRidePetMoveShow()
    -- if not self._heroRideAnimation or self._looks ~= 0 then
    if not self._heroRideAnimation then
        return
    end
    -- self._heroRideAnimation:setToSetupPose()
    self._heroRideAnimation:setAnimation(0, "move_1", true)
end

--骑乘宠物移动动画
function HeroRenderer:setHeroRidePetIdleShow()
    -- if not self._heroRideAnimation or self._looks ~= 0 then
    if not self._heroRideAnimation then
        return
    end
    -- self._heroRideAnimation:setToSetupPose()
    self._heroRideAnimation:setAnimation(0, "idle4", true)
end

--穿件专属于衣服的光环型特效
function HeroRenderer:createEquipmentSkinHaloEffect(spineName)
    if not self._roleAnimation or spineName == "" or spineName == nil then
        return
    end

    if not self._haloEffectAnimation then
        local skeletonFile, atlasFile, scale = spineName .. ".json", spineName .. ".atlas", 1

        --光环动画对象
        self._haloEffectAnimation = Avalon.Animation:create(skeletonFile, atlasFile, scale)
        local zOrder = self._roleAnimation:getLocalZOrder()
        local parent = self._roleAnimation:getParent()
        parent:addChild(self._haloEffectAnimation,zOrder-2)

        self._haloEffectAnimation:setVisible(false)

        self:setHeroHaloEffectShow()
    end

end

--移除穿件专属于衣服的光环型特效
function HeroRenderer:removeEquipmentSkinHaloEffect()
    if self._haloEffectAnimation then
        self._haloEffectAnimation:removeFromParent()
        self._haloEffectAnimation = nil
    end
end

--光环idle动画
function HeroRenderer:setHeroHaloEffectShow()
    local isRiding = MasterDataManager:getPetRidingState()
    if not self._haloEffectAnimation or self._looks ~= 0 or isRiding then
        if self._haloEffectAnimation then
            self._haloEffectAnimation:setVisible(false)
        end
        return
    end

    if self._haloEffectAnimation then
        self._haloEffectAnimation:setVisible(true)
        self._haloEffectAnimation:setAnimation(0, "idle", true)
    end
end

--显示丰收effect
function HeroRenderer:showHarvestEffect(fishResult)
    local zOrder = self._roleAnimation:getLocalZOrder()
    local parent = self._roleAnimation:getParent()

    local triggerName = "trigger_1"
    if fishResult == 3 then
        triggerName = "trigger_2"
    end

    local harvestEffect = Avalon.Animation:create("effect_ui_fish_fengshou.json", "effect_ui_fish_fengshou.atlas", 1)
    harvestEffect:setPosition(0, 140)
    parent:addChild(harvestEffect,zOrder+1)

    harvestEffect:setAnimation(0, triggerName, false)

    harvestEffect:registerSpineEventHandler(function (event)
        harvestEffect:runAction(cc.RemoveSelf:create())
    end, sp.EventType.ANIMATION_COMPLETE)
end

-- run1骑乘动画
function HeroRenderer:isRideRun1(templateID)
    local isRun1 = false
    if templateID == 1015 or
    templateID == 1023 then
        isRun1 = true
    end
    return isRun1
end
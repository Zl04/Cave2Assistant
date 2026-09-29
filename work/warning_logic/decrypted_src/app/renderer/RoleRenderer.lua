--[[
    角色的渲染器
]]--

require "app.renderer.Renderer"

local PlotManager = require("app.game.PlotManager")
local AngerProgressComponent = require ("app.renderer.component.AngerProgressComponent")

Renderer = Renderer or {}

local RoleRenderer = class("RoleRenderer", Renderer.Base)
Renderer.RoleRenderer = RoleRenderer

-- private:
local DEBUG = false

-- 角色层级关系
-- 角色脚下节点下面层级
ROLE_ANIMATION_BOTTOM_DOWN = 0
-- 角色节点层级
ROLE_ANIMATION_ZORDER = 1
-- 角色脚下节点上面层级
ROLE_ANIMATION_BOTTOM = 2
-- 角色鬼魂层级
ROLE_GHOST_ZORDER = 3
ROLE_LEVEL_UP_ZORDER = 3
ROLE_LEVEL_UP_ATTR_ZORDER = 4
ROLE_ANIMATION_DEFORMATION_ZORDER = 4
-- 角色属性数字层级
ROLE_ATTRIBUTE_ZORDER = 5
-- 设置血条最高的点
BLOOD_MAX_HEIGHT = 200

local ATTR_TYPE = PublicDefine.ATTR_TYPE

-- 挂载点名字
local MOUNT_BOTTOM_DOWN = "mount_bottomdown"
local MOUNT_BOTTOM_UP = "mount_bottom"

-- private:
-- 构造函数
function RoleRenderer:ctor()
    RoleRenderer.super.ctor(self)
     -- 脚下光环 
    self._lightAnimationList = nil
end

-- 析构函数
function RoleRenderer:dtor()
    RoleRenderer.super.dtor(self)
    if(self._lightAnimationList) then
        for i = 1, #self._lightAnimationList do
            local npcAnimation = self._lightAnimationList[i]
            if (npcAnimation:getParent()) then
                npcAnimation:runAction(cc.RemoveSelf:create())
            else
                npcAnimation:destroy()
            end
            npcAnimation:release()
        end
        self._lightAnimationList = nil
    end 
end

-- 创建角色动画上的特效
function RoleRenderer:addRoleFX(animName, mount, scale, startAfterLoading, fxFlip)
    if (animName and mount) then
        if DEBUG then
            print(string.format("RoleRenderer addRoleFX: %s show animation fx of role, animation name %s, mount %s.", self, animName, mount))
        end

        local skeleton = animName..".json"
        local atlas = animName..".atlas"
        scale = (scale ~= nil) and scale or 1.0

        local fxNode = Avalon.Animation:create(skeleton, atlas, scale, nil, startAfterLoading);
        fxNode:setUnloadResFlag(false)
        fxNode:registerSpineEventHandler(function(event)
            local startPos = string.find(event.animation, "end")
            if (startPos ~= nil) then
                fxNode:runAction(cc.RemoveSelf:create())

                self:removeRoleFxFromSave(fxNode)
                self:removeBuffFx(fxNode)
            end
            -- if event.animation == "end" then
            --     fxNode:runAction(cc.RemoveSelf:create())
            -- end

            if DEBUG then
                print(string.format("RoleRenderer addRoleFX: %s animation end, event track %d, event name %s.", self, event.trackIndex, event.animation))
            end
        end, sp.EventType.ANIMATION_END)

        fxNode:registerSpineEventHandler(function (event)
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

        -- 处理效果是否翻转
        fxNode.oldScaleX = 1
        if(self._roleAnimation) then
            fxNode.oldScaleX = self._roleAnimation:getScaleX()
        end

        if(fxFlip == 2) then
            if fxNode.oldScaleX < 0 then
                fxNode:setScaleX(-1)
            end
        end
        fxNode.fxFlip = fxFlip

        self:selfAddComponent(mount, fxNode)
        self:addRoleFxToSave(fxNode, mount)

        return fxNode
    else
        if DEBUG then
            print(string.format("RoleRenderer addRoleFX: %s no animation fx to show.", self))
        end

        return nil
    end
end

function RoleRenderer:refreshAllFxFlip()
    if(self._roleFxArr and self._roleAnimation) then
        local nowScaleX = self._roleAnimation:getScaleX()

        for k,data in pairs(self._roleFxArr) do 
            if(data.animation) then
                if data.animation.fxFlip == 0 then
                    if(data.animation.oldScaleX < 0) then
                        if(nowScaleX > 0) then
                            data.animation:setScaleX(-1)
                        else 
                            data.animation:setScaleX(1)
                        end
                    else 
                        if(nowScaleX < 0) then
                            data.animation:setScaleX(-1)
                        else 
                            data.animation:setScaleX(1)
                        end
                    end
                elseif data.animation.fxFlip == 2 then
                    data.animation:setScaleX(nowScaleX)
                end
            end
        end
    end
end

-- 这里为暂时充老的动作里面移除对象，后面还会调用addAllFxToNowRoleAnimation方法加载到新的动画里面
function RoleRenderer:removeAllFxFromNowRoleAnimation()
    if(self._roleFxArr) then
        for k,data in pairs(self._roleFxArr) do 
            if(data.animation) then
                -- data.animation:removeFromParentAndCleanup(false)
                data.animation:removeFromParent()
                self._roleFxArr[k] = nil
            end
        end
    end
end

-- 添加所有效果给当前角色动画
function RoleRenderer:addAllFxToNowRoleAnimation()
    if(self._roleFxArr and self._roleAnimation) then
        for k,data in pairs(self._roleFxArr) do 
            if(data.animation and data.mount) then
                self:selfAddComponent(data.mount, data.animation)
            end
        end
    end
end

-- 添加一个角色效果
function RoleRenderer:addRoleFxToSave(fxNode, mount)
    if(fxNode and mount and self._roleFxArr) then
        fxNode:retain()
        table.insert(self._roleFxArr, {animation=fxNode, mount=mount})
    end
end

-- 移除一个角色效果
function RoleRenderer:removeRoleFxFromSave(animation)
    if(animation and self._roleFxArr) then
        for k,data in pairs(self._roleFxArr) do 
            if(data.animation == animation) then
                data.animation:release()
                table.remove(self._roleFxArr, k)
                break
            end
        end
    end
end

-- 移除一个buff 效果
function RoleRenderer:removeBuffFx(animation) 
    if(animation and self._bufferFXMap) then 
        for buffID, fxNodeList in pairs(self._bufferFXMap) do
            for i = 1, #fxNodeList do
                local fxNode = fxNodeList[i]
                if(animation == fxNode) then
                    table.remove(fxNodeList, i)
                    break
                end
            end
        end
    end
end

-- 显示特效
function RoleRenderer:showRoleFX(fxNode, loop, mountAnimationPrefix)
    if (fxNode) then
        if DEBUG then
            print(string.format("RoleRenderer showRoleFX: show animation fx of role, prefix %s.", mountAnimationPrefix))
        end

        local beginAnimation = nil
        local idleAnimation = nil
        local triggerAnimation = nil
        local endAnimation = nil
        if (mountAnimationPrefix) then
            beginAnimation = mountAnimationPrefix.."_begin"
            idleAnimation = mountAnimationPrefix.."_idle"
            triggerAnimation = mountAnimationPrefix.."_trigger"
            endAnimation = mountAnimationPrefix.."_end"
        else
            beginAnimation = "begin"
            idleAnimation = "idle"
            triggerAnimation = "trigger"
            endAnimation = "end"
        end

        fxNode:setAnimation(0, beginAnimation, false)
        fxNode:addAnimation(0, idleAnimation, loop)
        if (not loop) then
            fxNode:addAnimation(0, triggerAnimation, false)
            fxNode:addAnimation(0, endAnimation, false)
        end
    else
        if DEBUG then
           assert(false, string.format("RoleRenderer showRoleFX: no fx node found."))
        end
    end
end

-- 结束特效
function RoleRenderer:hideRoleFX(fxNode, mountAnimationPrefix)
    if (fxNode) then
        if DEBUG then
            print(string.format("RoleRenderer hideRoleFX: hide animation fx of role, prefix %s .", mountAnimationPrefix))
        end

        local triggerAnimation = nil
        local endAnimation = nil
        if (mountAnimationPrefix) then
            triggerAnimation = mountAnimationPrefix.."_trigger"
            endAnimation = mountAnimationPrefix.."_end"
        else
            triggerAnimation = "trigger"
            endAnimation = "end"
        end

        fxNode:setToSetupPose()
        local triggerAnimation = fxNode:setAnimation(0, triggerAnimation, false)
        if (triggerAnimation) then
            fxNode:addAnimation(0, endAnimation, false)
        else
            fxNode:setAnimation(0, endAnimation, false)
        end
    else
        if DEBUG then
           assert(false, string.format("RoleRenderer hideRoleFX: no fx node found."))
        end
    end
end

-- 中断角色身上的特效
function RoleRenderer:breakRoleFX(fxNode)
    if (fxNode) then
        if DEBUG then
            print(string.format("RoleRenderer breakRoleFX: break animation fx of role."))
        end

        fxNode:setAnimation(0, "end", false)
    else
        if DEBUG then
           assert(false, string.format("RoleRenderer breakRoleFX: no fx node found."))
        end
    end
end

-- 删除技能的特效
function RoleRenderer:removeSkillFX()
    if (self._skillFX) then
        self._skillFX:removeFromParent()
        self._skillFX = nil
    end
end

-- 给自身添加一个绑定效果
function RoleRenderer:selfAddComponent(mountName, animationNode)
    if(self._roleAnimation and animationNode and mountName) then
        -- if(mountName == MOUNT_BOTTOM_DOWN) then
        --     self._mountBottomDown:addChild(animationNode)
        -- elseif (mountName == MOUNT_BOTTOM_UP) then 
        --     self._mountBottomUp:addChild(animationNode)
        -- else 
            self._roleAnimation:addComponent(mountName, animationNode)
            if(self.isPause) then
                Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function()
                    if(not tolua.isnull(animationNode)) then
                        animationNode:pause()
                    end
                end, 2)
            end
        -- end
    end
end

-- 添加变身特效
function RoleRenderer:addDeformationView(isHorcurx,isRide)
    local deformationAnimation 
    if isRide then
        deformationAnimation = Avalon.Animation:create("effect_role_pet_protoceratops_ride.json", "effect_role_pet_protoceratops_ride.atlas", 1)
        deformationAnimation:setScale(0.8)
    else
        if isHorcurx then
            deformationAnimation = Avalon.Animation:create("effect_role_horcruxes_npc_bianshen.json", "effect_role_horcruxes_npc_bianshen.atlas", 1)
        else
            deformationAnimation = Avalon.Animation:create("effect_role_hero_deformation.json", "effect_role_hero_deformation.atlas", 1)
        end
    end
    deformationAnimation:setAnimation(0, "deformation", false)
    -- TODO 变身暂时音效
    -- Avalon.AudioManager:playSound("553")
    if not isRide then
        Avalon.AudioManager:playDynamicSound("553",nil,self:getCoord())
    end

    deformationAnimation:registerSpineEventHandler(function (event)
        deformationAnimation:runAction(cc.RemoveSelf:create())
    end, sp.EventType.ANIMATION_END)

    deformationAnimation:registerSpineEventHandler(function (event)
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

    self:addChild(deformationAnimation, ROLE_ANIMATION_DEFORMATION_ZORDER)

    if(self.isPause) then
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function()
            if(not tolua.isnull(deformationAnimation)) then
                deformationAnimation:pause()
            end
        end, 2)
    end
end

-- public:
-- 构造函数
function RoleRenderer:ctor()
    RoleRenderer.super.ctor(self)

    -- 角色动画
    self._roleAnimation = nil
    -- 骑宠动画
    self._heroRideAnimation = nil
    -- buff的特效列表
    self._bufferFXMap = {}
    -- 技能特效
    self._skillFX = nil

    -- 添加脚下视图表现
    self._mountBottomDown = nil
    self._mountBottomUp = nil

    -- 属性视图
    self._attribute = nil
    self._attrAddNode = nil

    -- 是否为boss
    self._isBoss = false

    self._isTurnAround = true

    self._curHp = 0
    self._hp = 0

    self._scale = 1
    self._timeScale = 1.0
    -- 刀光动画
    self._weaponAnimation = nil
    -- 处理辅助技能的刀光
    self._weaponAssistAnimation = nil
    -- 状态列表
    self._statusAnimationArr = {}
    -- 释放技能的效果
    self._realeseActAniamtionArr = {}
    -- 释放辅助技能的效果
    self._realeseAssistActAniamtionArr = {}
    
    -- 保存所有的buff effect 效果对象  {{animation, mount}}
    self._roleFxArr = {}

    self._bloodNode = nil
    self._bloodKuang = nil
    self._bloodView = nil

    self._miniBloodBar = nil

    self._oldGlProgramState = nil

    self._direction = DirectionType.NONE
    --所有被遗弃的动画
    self._dirtyActFXMap = {}
end

-- 销毁
function RoleRenderer:destroy()
    self:clearAllFX()
    self._bufferFXMap = nil

    if self._attribute then
        if self._attribute:getParent() then
            self._attribute:removeFromParent()
        end
        self._attribute = nil
    end
    self._attrAddNode = nil

    if (self._heroRideAnimation and (not tolua.isnull(self._heroRideAnimation))) then
        self._heroRideAnimation:removeFromParent()
    end
    self._heroRideAnimation = nil

    if (self._roleAnimation and (not tolua.isnull(self._roleAnimation))) then
        self._roleAnimation:removeFromParent()
    end
    self._roleAnimation = nil

    self._isBoss = false

    self._curHp = 0
    self._hp = 0

    self._scale = 1
    self._timeScale = 1.0

    self._oldGlProgramState = nil

    if(self._weaponAnimation and (not tolua.isnull(self._weaponAnimation))) then
        self._weaponAnimation:removeFromParent()
        self._weaponAnimation = nil
    end

    if(self._weaponAssistAnimation and (not tolua.isnull(self._weaponAssistAnimation))) then
        self._weaponAssistAnimation:removeFromParent()
        self._weaponAssistAnimation = nil
    end

    if(self._statusAnimationArr) then 
        for k, animation in pairs(self._statusAnimationArr) do 
            if((not tolua.isnull(animation)) and animation:getParent()) then 
                animation:removeFromParent()
            end
        end
        self._statusAnimationArr = {}
    end

    if(self._bloodNode and (not tolua.isnull(self._bloodNode))) then
        self._bloodNode:removeFromParent()
    end

    if(self._miniBloodBar and (not tolua.isnull(self._miniBloodBar))) then
        self._miniBloodBar:removeFromParent()
    end

    self._miniBloodBar = nil
    self._bloodNode = nil
    self._bloodKuang = nil
    self._bloodView = nil

    self._realeseActAniamtionArr = {}
    self._realeseAssistActAniamtionArr = {}
    
    self._direction = DirectionType.NONE

    RoleRenderer.super.destroy(self)
end

-- 渲染
function RoleRenderer:onDraw(dt)
    if not tolua.isnull(self._attribute) then
        self._attribute:onUpdate(dt)
        
        local x,y = self._viewNode:getPosition()
        local size = self._attribute:getSize()
        if(size.width ==0 and size.height == 0) then
            size = self:getRoleAnimationSize()
            self:setRoleAnimationSize(size)
        end
        self._attribute:setPosition(x,y + size.height*0.67)
    end

    if (self._roleAnimation) then
        self._roleAnimation:update(dt)

        -- 更新脚底下挂载点的缩放比例
        if(self._mountBottomDown) then
            local slotDownNode = self._roleAnimation:getNodeForSlot(MOUNT_BOTTOM_DOWN)
            if(slotDownNode) then 
                self._mountBottomDown:setScaleX(slotDownNode:getScaleX())
                self._mountBottomDown:setScaleY(slotDownNode:getScaleY())
            end
        end

        if(self._mountBottomUp) then
            local slotUpNode = self._roleAnimation:getNodeForSlot(MOUNT_BOTTOM_UP)
            if(slotUpNode) then
                self._mountBottomUp:setScaleX(slotUpNode:getScaleX())
                self._mountBottomUp:setScaleY(slotUpNode:getScaleY())
            end
        end
    end


end

-- 初始化
function RoleRenderer:init(skeletonFile, atlasFile, scale, roleType, isBoss)
    -- 添加角色动画
    self._roleAnimation = Avalon.Animation:create(skeletonFile, atlasFile, scale)
    self._skeletonFile = skeletonFile
    self._atlasFile = atlasFile
    self._scale = scale
    if (self._roleAnimation) then
        -- local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
        -- if (shader) then
        --     self._roleAnimation:setGLProgramState(shader)
        -- end

        self:addChild(self._roleAnimation, ROLE_ANIMATION_ZORDER)

        -- 添加了挂载点扩展
        self._mountBottomDown = cc.Node:create()
        self._mountBottomUp = cc.Node:create()
        self:addChild(self._mountBottomDown, ROLE_ANIMATION_BOTTOM_DOWN)
        self:addChild(self._mountBottomUp, ROLE_ANIMATION_BOTTOM)
    else
       assert(false, string.format("[ERROR] RoleRenderer init: create role animation (%s,%s,%f) failed.", skeletonFile, atlasFile, scale))
    end

    self._roleType = roleType

    self:_registerRoleSpineEventHandle()

    if(isBoss) then
        self._isBoss = isBoss
    else
        self._isBoss = false
    end

    self:initCommonAttrHandler()
end

-- 播放动画
function RoleRenderer:showAnimation(animationName, ...)
    assert(type(animationName) == "string", "RoleRenderer showAnimation: animation name is invalid.")

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

-- 设置待机视图
function RoleRenderer:idle()
    self:showIDLE()
end

-- 获取待机动画名字
function RoleRenderer:getIDLEAnim()
   assert(false, "[ERROR] RoleRenderer getIDLEAnim: this method should be overrided by sub class.")
end

-- 设置跳伤害的加载点
function RoleRenderer:setAttrAddNode(addNode)
    self._attrAddNode = addNode
end

-- 设置皮肤
function RoleRenderer:setSkin(skinName)
    self._roleAnimation:setSkin(skinName)
end

-- 设置方向
function RoleRenderer:setDirection(direction)
    if (direction == nil or direction == DirectionType.NONE) then 
        if DEBUG then
            print(string.format("[WARNING] RoleRenderer setDirection: set direction %s.", direction))
        end
        
        return 
    end
    self._direction = direction
    
    -- print("hero  转向了  2")
    -- print(debug.traceback())

    if(self._isTurnAround) then
        if (direction == DirectionType.EAST or
            direction == DirectionType.SOUTH) then
            self._roleAnimation:setScaleX(-1)
        else
            self._roleAnimation:setScaleX(1)
        end

        self:refreshAllFxFlip()

        self:setHeroRidePetDirection()
    end

    if DEBUG then
        print(string.format("RoleRenderer setDirection: set direction %d.", direction))
    end
end

--设置骑乘宠物方向
function RoleRenderer:setHeroRidePetDirection()
    -- print(" 骑乘转向!!!!!!!!!  ")
    if not self._heroRideAnimation then
        return
    end
    local direction = self._direction
    if (direction == DirectionType.EAST or
        direction == DirectionType.SOUTH) then
        self._heroRideAnimation:setScaleX(-1)
        -- print(" 骑乘转向!!!!!!!!!  11 ")
    else
        self._heroRideAnimation:setScaleX(1)
        -- print(" 骑乘转向!!!!!!!!!  222")
    end

    if self.setRoleAnimationDisplacementPosition then
        local positionOfSlotX,positionOfSlotY = self._heroRideAnimation:getPositionOfSlot("ride_top")
        self:setRoleAnimationDisplacementPosition({x=positionOfSlotX,y=positionOfSlotY})
    end
end


-- 显示角色属性
function RoleRenderer:showAttribute(attributeData, direction)
    -- print("---------RoleRenderer:showAttribute ", direction)
    if not self._attribute then
        self:_createAttributeComponent()
    end
    if self._attribute then
        local scale = self._roleAnimation:getScaleX()
        if direction then 
            if (direction == DirectionType.EAST or
                direction == DirectionType.SOUTH) then
                scale = -1
            else
                scale = 1
            end
        end

        local size = self._roleAnimation:getBoundingBox()
        self._attribute:addAttr(attributeData, size, scale)
    end

    if(self._roleType ~= RoleType.Hero and self._roleType ~= RoleType.Pet) then
        local shack = false
        for k,v in pairs(attributeData.attrChange) do
            local reason = v.reason
            if  reason == CLIENT_ATTR_CHANGE_REASON.ADD_EXP or
                reason == CLIENT_ATTR_CHANGE_REASON.ADD_COIN or
                reason == CLIENT_ATTR_CHANGE_REASON.MAGIC_RESTORE or
                reason == CLIENT_ATTR_CHANGE_REASON.HP_RESTORE  then
                
            else
                shack = true
                break
            end
        end

        -- 暴击默认12 震动
        if(shack) then
            -- Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, 13, 2)
            -- ToolsUtil:cardFrame(0.08)
            -- self:animationGray(0.05)
            -- self:attackShack()
        end
    end
end

function RoleRenderer:getRoleAnimationSize()
    local size = self._roleAnimation:getBoundingBox()
    -- self:setRoleAnimationSize(size)
    return size
end

-- 显示血条
function RoleRenderer:showBloodView(curHp, hp)
    if DEBUG then
        print("RoleRenderer:showBloodView ")
    end
    self._curHp = curHp
    self._hp = hp

    if(self._bloodNode == nil) then
        self._bloodNode = nil
        self._bloodKuang = nil
        self._bloodView = nil

        self._bloodNode = cc.Node:create()

        local bloodKuangSprite = "ui_battle_monsteblood_02.png"
        local bloodSprite = "ui_battle_monsteblood_12.png"
        if(self._isBoss) then
            bloodKuangSprite = "ui_battle_monsteblood_01.png"
            bloodSprite = "ui_battle_monsteblood_11.png"
        end

        -- 血条框
        self._bloodKuang = cc.Sprite:createWithSpriteFrameName(bloodKuangSprite)
        local px = 0
        local py = 0
        self._bloodKuang:setAnchorPoint(cc.p(0.5,0.5))
        self._bloodKuang:setPosition(cc.p(px,py))
        self._bloodNode:addChild(self._bloodKuang)

        -- 血条
        self._bloodView = cc.Sprite:createWithSpriteFrameName(bloodSprite)
        local px = -self._bloodView:getContentSize().width/2 
        local py = 0
        self._bloodView:setAnchorPoint(cc.p(0,0.5))
        self._bloodView:setPosition(cc.p(px,py))
        self._bloodNode:addChild( self._bloodView)

        self._viewNode:addChild(self._bloodNode, 1)

        if(self._roleAnimation) then
            local boundBosSize = self._roleAnimation:getBoundingBox()
            local bloodHeight = boundBosSize.height
            if(bloodHeight > BLOOD_MAX_HEIGHT) then 
                bloodHeight = BLOOD_MAX_HEIGHT
            end
            self._bloodNode:setPosition(cc.p(0, bloodHeight))
        end
    end

    self:_updateBloodScale()
end

function RoleRenderer:showMiniBloodView(curHp, hp, isEnemy)
    self._miniBloodBar = UI.ProgressTimer:create()
    if isEnemy then
        self._miniBloodBar:init("ui_general_pvp_blood_pet_0.png", nil, "ui_general_pvp_blood_pet_2_1.png")
    else
        self._miniBloodBar:init("ui_general_pvp_blood_pet_0.png", nil, "ui_general_pvp_blood_pet_1_1.png")
    end
    self._miniBloodBar:setAnchorPoint(0.5, 0.5)
    self._miniBloodBar:centerBottom(-20)
    self._viewNode:addChild(self._miniBloodBar)
    self._miniBloodBar:setPercent(1)
end

-- 更新血条
function RoleRenderer:updateBloodView(curHp, hp)
    self._curHp = curHp
    self._hp = hp

    self:_updateBloodScale()
end

-- 移除血条
function RoleRenderer:removeBloodView()
    if DEBUG then
        print("RoleRenderer:removeBloodView ", self._bloodNode)
    end
    if(self._bloodNode) then

        self._bloodNode:removeFromParent()
        self._bloodNode = nil
    end

    self._bloodView = nil
    self._bloodKuang = nil
end

-- 更新血条进度
function RoleRenderer:_updateBloodScale()
    -- 
    -- print("----RoleRenderer:_updateBloodScale")
    if(self._bloodView and self._curHp and self._hp) then
        if DEBUG then
            print("RoleRenderer:_updateBloodScale ", self._curHp, self._hp)
        end
        self._bloodView:setScaleX(tonumber(self._curHp)/tonumber(self._hp))
    elseif (self._miniBloodBar and self._curHp and self._hp) then
        self._miniBloodBar:setPercent(tonumber(self._curHp)/tonumber(self._hp))
    end
end

-- 显示状态动画
function RoleRenderer:showStatusAnimation(animationName, loop)
    self:removeWeaponAnimation()
    if(self._roleAnimation) then
        self._roleAnimation:setAnimation(0, animationName, loop)
    end
end

function RoleRenderer:showStatusEffect(statusID, mount, animation)
    if(self._statusAnimationArr[statusID] == nil) then
        local statusEffect = self:addRoleFX(animation, mount, 1.0, false, false)
        statusEffect:setAnimation(0, "begin", false)
        statusEffect:addAnimation(0, "idle", true)
        statusEffect:registerSpineEventHandler(function(event)
            local startPos = string.find(event.animation, "end")
            if (startPos ~= nil and statusEffect) then
                statusEffect:runAction(cc.RemoveSelf:create())
                statusEffect = nil
            end
        end, sp.EventType.ANIMATION_END)

        self._statusAnimationArr[statusID] = statusEffect
    end
end

function RoleRenderer:endStatusEffect(statusID)
    if(self._statusAnimationArr[statusID]) then
        self._statusAnimationArr[statusID]:setAnimation(0, "trigger", false)
        self._statusAnimationArr[statusID]:addAnimation(0, "end", false)
        self._statusAnimationArr[statusID] = nil
    end
end

-- 显示buff 效果
function RoleRenderer:showBuff(buffID, loop, animName, mountNameList, mountAnimationPrefixList, fxFlip)
    if (mountNameList and 
        #mountNameList >= 1) then
        for i = 1, #mountNameList do
            local mountName = mountNameList[i]
            local mountAnimationPrefix = nil
            if (mountAnimationPrefixList and #mountAnimationPrefixList >= i) then
                mountAnimationPrefix = mountAnimationPrefixList[i]
            end

            local fxNode = self:addRoleFX(animName, mountName, Game.BUFFER_EFFECT_SCALE, true, fxFlip)
            if (fxNode) then
                if DEBUG then
                    print(string.format("RoleRenderer showBuffer: %s show buff animation %s for buff %d.", self, animName, buffID))
                end
                
                self:showRoleFX(fxNode, loop, mountAnimationPrefix)
                if (not self._bufferFXMap[buffID]) then
                    self._bufferFXMap[buffID] = {}
                end
                table.insert(self._bufferFXMap[buffID], fxNode)
                fxNode:setVisible(self:judgeShowBuff())
            else
                if DEBUG then
                    print(string.format("RoleRenderer showBuffer: %s no buff animation to show for buff %d.", self, buffID))
                end
            end
        end
    else
        assert(false)
    end
end

-- 刷新buff 显示状态
function RoleRenderer:refreshBuffShow()
    local showBuff = self:judgeShowBuff()
    -- print("RoleRenderer:refreshBuffShow" , showBuff)
    for k, fxNodeList in pairs(self._bufferFXMap) do 
        for k,fxNode in pairs(fxNodeList) do 
            -- print("RoleRenderer:refreshBuffShow 1")
            fxNode:setVisible(showBuff)
        end
    end
end

function RoleRenderer:judgeShowBuff()
    return true
end

-- 移除buff 效果
function RoleRenderer:hideBuff(buffID, mountAnimationPrefixList)
    local fxNodeList = self._bufferFXMap[buffID]
    if (fxNodeList) then
        -- print(string.format("RoleRenderer hideBuffer: hide buff animation for buff %d.", buffID))

        for i = 1, #fxNodeList do
            local mountAnimationPrefix = nil
            if (mountAnimationPrefixList and #mountAnimationPrefixList >= i) then
                mountAnimationPrefix = mountAnimationPrefixList[i]
            end

            local fxNode = fxNodeList[i]
            self:hideRoleFX(fxNode, mountAnimationPrefix)
            table.insert(self._dirtyActFXMap, fxNode)
        end
        self._bufferFXMap[buffID] = nil
    else
        if DEBUG then
            print(string.format("RoleRenderer hideBuffer: no buff animation to hide for buff %d.", buffID))
        end
    end
end

-- 显示效果
function RoleRenderer:showEffect(animName, mount, fxFlip)
    local fxNode = self:addRoleFX(animName, mount, Game.NORMAL_EFFECT_SCALE, false, fxFlip)
    if (fxNode) then
        if DEBUG then
            print(string.format("RoleRenderer showEffect: show effect animation %s.", animName))
        end

        self:showRoleFX(fxNode, false)
    else
        if DEBUG then
            print(string.format("RoleRenderer showEffect: no effect animation to show."), animName)
        end
    end
end

-- 显示技能蓄力或者呤唱动画
function RoleRenderer:showPrepareSkill(animNameArr)
    self:removeWeaponAnimation()
    if (animNameArr) then
        if DEBUG then
            print(string.format("RoleRenderer showPrepareSkill: show the animation %s of preparing skill.", animNameArr[1]))
        end
        if(#animNameArr == 1) then
            self._roleAnimation:setAnimation(0, animNameArr[1], true)
        elseif (#animNameArr == 2) then
            self._roleAnimation:setAnimation(0, animNameArr[1], false)
            self._roleAnimation:addAnimation(0, animNameArr[2], true)
        else 
            if DEBUG then
                assert(false, "ProfileClientSkill.lua castAnimName config is error.")
            end
        end
    else
        if DEBUG then
            print(string.format("RoleRenderer showPrepareSkill: no prepare skill animation to show."))
        end
    end
end

-- 处理
function RoleRenderer:showNormalSkill(animName, weaponAnim, speedUp)
    self:showReleaseSkill(animName, weaponAnim)

    if(speedUp == nil) then
        speedUp = 1.0
    end

    self:speedUp(speedUp)

    -- add by zp  在释放的时候统一添加了
    -- if(self._roleType == RoleType.Hero) then 
    --     self._roleAnimation:addAnimation(0, self:getAttackIdleAnimationName(), true)
    -- end
end

-- 显示技能释放动画
function RoleRenderer:showReleaseSkill(animName, weaponAnim)
    self:speedUp(1.0)
    self:removeWeaponAnimation()
    if (animName) then
        if DEBUG then
            print(string.format("RoleRenderer showReleaseSkill: show the animation %s of releasing skill.", animName))
        end

        self._roleAnimation:setAnimation(0, animName, false)
        -- 这里给每种攻击状态后都添加一个idle 动作
        self._roleAnimation:addAnimation(0, self:getAttackIdleAnimationName(), true)

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
    else
        if DEBUG then
            print(string.format("RoleRenderer showReleaseSkill: no release skill animation to show."))
        end
    end
end

-- 显示技能释放动画
function RoleRenderer:showReleaseAssistSkill(animName, weaponAnim, skillID)
    self._assistSkillID = skillID
    self:speedUp(1.0)
    self:removeWeaponAnimation()
    self:removeWeaponAssistAnimation()
    if (animName) then
        if DEBUG then
            print(string.format("RoleRenderer showReleaseAssistSkill: show the animation %s of releasing skill.", animName))
        end

        self._roleAnimation:setAnimation(0, animName, false)
        self._roleAnimation:addAnimation(0, self:getIDLEAnim(), true)

        if(weaponAnim and weaponAnim ~= "") then
            -- 播放刀光效果
            self._weaponAssistAnimation = Avalon.Animation:create(weaponAnim..".json", weaponAnim..".atlas", self._scale);
            self._weaponAssistAnimation:setUnloadResFlag(false)
            self._weaponAssistAnimation:setAnimation(0, "release_skill", false)
            self._weaponAssistAnimation:registerSpineEventHandler(function(event)
                if(self._weaponAssistAnimation) then
                    self._weaponAssistAnimation:runAction(cc.RemoveSelf:create())
                    self._weaponAssistAnimation = nil
                end
            end, sp.EventType.ANIMATION_END)

            self._weaponAssistAnimation:registerSpineEventHandler(function (event)
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
            self._roleAnimation:addComponent(MOUNT_BOTTOM_UP, self._weaponAssistAnimation)

            if(self.isPause) then 
                Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
                    if(not tolua.isnull(self._weaponAssistAnimation)) then
                        self._weaponAssistAnimation:pause()
                    end
                end, 2)
            end
        end
    else
        if DEBUG then
            print(string.format("RoleRenderer showReleaseAssistSkill: no release skill animation to show."))
        end
    end
end

function RoleRenderer:showReleaseAssistActAnimation(fromSpriteID, spineName, mountName, delayTime, timeScale)
    if DEBUG then
        print("RoleRenderer:showReleaseAssistActAnimation ", fromSpriteID, spineName, mountName, delayTime, timeScale)
    end

    local actAnimation = Avalon.Animation:create(spineName..".json", spineName..".atlas", self._scale);
    actAnimation:setUnloadResFlag(false)

    if (self._direction == DirectionType.EAST or
        self._direction == DirectionType.SOUTH) then
        actAnimation:setScaleX(-1)
    else
        actAnimation:setScaleX(1)
    end

    -- 处理加速的逻辑处理
    actAnimation:registerSpineEventHandler(function(event)
        for k, animation in pairs(self._realeseAssistActAniamtionArr) do 
            if(animation == actAnimation) then 
                self._realeseAssistActAniamtionArr[k] = nil
                table.insert(self._dirtyActFXMap, actAnimation)
                break
            end
        end

        if(actAnimation) then
            actAnimation:runAction(cc.RemoveSelf:create())
            actAnimation = nil
        end
    end, sp.EventType.ANIMATION_END)

    actAnimation:registerSpineEventHandler(function (event)
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

    self:selfAddComponent(mountName, actAnimation)

    table.insert(self._realeseAssistActAniamtionArr, actAnimation)

    if(delayTime == 0) then 
        actAnimation:setAnimation(0, "trigger", false)
    else 
        delayTime = delayTime /1000
        self._viewNode:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime), cc.CallFunc:create(function()
            if actAnimation and (not tolua.isnull(actAnimation)) then
                actAnimation:setAnimation(0, "trigger", false)
            end
        end)))
    end
end

-- 移除所有辅助效果
function RoleRenderer:clearAllReleaseAssistActAnimation(spriteID, fromSpriteID)
    if DEBUG then
        print("RoleRenderer:clearAllReleaseAssistActAnimation ", spriteID, fromSpriteID)
    end

    self:removeWeaponAnimation()

    for k, animation in pairs(self._realeseAssistActAniamtionArr) do 
        if(animation and not tolua.isnull(animation)) then 
            animation:runAction(cc.RemoveSelf:create())
        end
    end

    table.clear(self._realeseAssistActAniamtionArr)
end

function RoleRenderer:showReleaseActAnimation(fromSpriteID, spineName, mountName, delayTime, timeScale, direction, isSelf)
    if DEBUG then
        print("RoleRenderer:showReleaseActAnimation ", fromSpriteID, spineName, mountName, delayTime, timeScale)
    end

    local actAnimation = Avalon.Animation:create(spineName..".json", spineName..".atlas", self._scale);
    actAnimation:setUnloadResFlag(false)

    -- 这里如果为自己就不用反转等操作了
    if(isSelf == false) then
        if (direction == DirectionType.EAST or
            direction == DirectionType.SOUTH) then
            actAnimation:setScaleX(-1)
        else
            actAnimation:setScaleX(1) 
        end
    end

    -- TODO 处理加速的逻辑处理
    actAnimation:registerSpineEventHandler(function(event)
        for k, animation in pairs(self._realeseActAniamtionArr) do 
            if(animation == actAnimation) then 
                self._realeseActAniamtionArr[k] = nil
                table.insert(self._dirtyActFXMap, actAnimation)
                break
            end
        end

        if(actAnimation) then
            actAnimation:runAction(cc.RemoveSelf:create())
            actAnimation = nil
        end
    end, sp.EventType.ANIMATION_END)

    actAnimation:registerSpineEventHandler(function (event)
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

    self:selfAddComponent(mountName, actAnimation)

    table.insert(self._realeseActAniamtionArr, actAnimation)

    if(delayTime == 0) then 
        actAnimation:setAnimation(0, "trigger", false)
    else 
        delayTime = delayTime /1000
        self._viewNode:runAction(cc.Sequence:create(cc.DelayTime:create(delayTime), cc.CallFunc:create(function()
            if actAnimation and (not tolua.isnull(actAnimation)) then
                actAnimation:setAnimation(0, "trigger", false)
            end
        end)))
    end
end

-- 移除所有效果
function RoleRenderer:clearAllReleaseActAnimation(spriteID, fromSpriteID)
    if DEBUG then
        print("RoleRenderer:clearAllReleaseActAnimation ", spriteID, fromSpriteID)
    end
    if(spriteID == fromSpriteID) then 
        self:removeWeaponAnimation()
    end

    for k, animation in pairs(self._realeseActAniamtionArr) do 
        if(animation and not tolua.isnull(animation)) then 
            animation:runAction(cc.RemoveSelf:create())
        end
    end

    table.clear(self._realeseActAniamtionArr)
end

-- 显示技能收招动画
function RoleRenderer:showFinishSkill(animName)
    local idleAnim = nil
    if(self._roleType == RoleType.Hero) then 
        idleAnim = self:getAttackIdleAnimationName() -- self:getIDLEAnim()
    else
        idleAnim = self:getIDLEAnim()
    end

    if(idleAnim == nil) then
        idleAnim = self:getIDLEAnim()
    end
    if (animName) then
        if DEBUG then
            print(string.format("RoleRenderer showFinishSkill: show the animation %s of finishing skill.", animName))
        end

        self._roleAnimation:setAnimation(0, animName, false)
        self._roleAnimation:addAnimation(0, idleAnim, true)
    else
        if DEBUG then
            print(string.format("RoleRenderer showFinishSkill: no finish skill animation to show."))
        end

        self._roleAnimation:setAnimation(0, idleAnim, true)
    end
end

-- 显示蓄力或者呤唱技能时的特效
function RoleRenderer:showPrepareSkillFX(animName, mount)
    self:removeSkillFX()

    if (not self._skillFX) then
        if DEBUG then
            print(string.format("RoleRenderer showPrepareSkillFX: show the animation fx %s of releasing skill.", animName))
        end

        self._skillFX = self:addRoleFX(animName, mount, Game.SKILL_EFFECT_SCALE)
        if (self._skillFX) then
            self:showRoleFX(self._skillFX, true)
        else
            assert(false, string.format("[ERROR] RoleRenderer showPrepareSkillFX: create skill fx %s failded.", animName))
        end
    else
        assert(false, string.format("[ERROR] RoleRenderer showPrepareSkillFX: skill fx %s is already exist.", animName))
    end
end

-- 完成技能准备特效
function RoleRenderer:finishPrepareSkillFX()
    if (self._skillFX) then
        if DEBUG then
            print(string.format("RoleRenderer finishPrepareSkillFX: finish the preparing skill fx."))
        end

        self._skillFX:setVisible(false)
    end
end

-- 显示释放技能时候的特效
function RoleRenderer:showReleaseSkillFX(animName, mount)
    if (self._skillFX) then
        if DEBUG then
            print(string.format("RoleRenderer showReleaseSkillFX: hide the last animation fx of preparing skill."))
        end

        self._skillFX:setVisible(true)
        self:hideRoleFX(self._skillFX)
        self._skillFX = nil
    else
        if DEBUG then
            print(string.format("RoleRenderer showReleaseSkillFX: create the last animation fx of preparing skill."))
        end

        local fxNode = self:addRoleFX(animName, mount, Game.SKILL_EFFECT_SCALE)
        if (fxNode) then
            self:hideRoleFX(fxNode)
        else
            assert(false, string.format("[ERROR] RoleRenderer showPrepareSkillFX: create skill fx %s failded.", animName))
        end
    end
end

-- 显示取消技能特效
function RoleRenderer:showBreakSkillFX(animName, mount)
    if (self._skillFX) then
        if DEBUG then
            print(string.format("RoleRenderer showBreakSkillFX: break the animation fx %s of releasing skill.", animName))
        end

        self:breakRoleFX(self._skillFX)
        self._skillFX = nil
    else
        if DEBUG then
            print(string.format("RoleRenderer showBreakSkillFX: could not break the animation fx %s of releasing skill.", animName))
        end
    end
end

-- 移除刀光效果
function RoleRenderer:removeWeaponAnimation()
    if(not tolua.isnull(self._weaponAnimation)) then
        self._weaponAnimation:removeFromParent()
        self._weaponAnimation = nil
    end
end

-- 移除辅助技能刀光
function RoleRenderer:removeWeaponAssistAnimation()
    -- body
    if(not tolua.isnull(self._weaponAssistAnimation)) then
        self._weaponAssistAnimation:removeFromParent()
        self._weaponAssistAnimation = nil
    end
end

-- 移除身上的所有特效
function RoleRenderer:clearAllFX()
    self:clearBufferFX()
    self:clearSkillFX()
    self:clearRoleFx()
    self:clearAllActAnimation()
    self:clearAllAssistActAnimation()
    for k, v in ipairs(self._dirtyActFXMap) do
        if not tolua.isnull(v) then
            v:removeFromParent()
        end
    end
    self._dirtyActFXMap = {}
    if(self._statusAnimationArr) then 
        for k, animation in pairs(self._statusAnimationArr) do 
            if((not tolua.isnull(animation)) and animation:getParent()) then 
                animation:removeFromParent()
            end
        end
        self._statusAnimationArr = {}
    end
end

function RoleRenderer:clearAllAssistActAnimation()
    self:removeWeaponAnimation()

    for k, animation in pairs(self._realeseAssistActAniamtionArr) do 
        if(animation and not tolua.isnull(animation)) then 
            animation:runAction(cc.RemoveSelf:create())
        end
    end

    table.clear(self._realeseAssistActAniamtionArr)
end

function RoleRenderer:clearAllActAnimation()
    -- body
    for k, animation in pairs(self._realeseActAniamtionArr) do 
        if(animation and not tolua.isnull(animation)) then 
            animation:runAction(cc.RemoveSelf:create())
        end
    end

    table.clear(self._realeseActAniamtionArr)
end

function RoleRenderer:clearRoleFx()
    -- body
    for k, data in pairs(self._roleFxArr) do 
        if(data.animation and (not tolua.isnull(data.animation))) then 
            data.animation:release()
        end
    end
    self._roleFxArr = {}
end

-- 清理buff特效
function RoleRenderer:clearBufferFX()
    local bufferFXMap = self._bufferFXMap
    for buffID, fxNodeList in pairs(bufferFXMap) do
        for i = 1, #fxNodeList do
            local fxNode = fxNodeList[i]
            if(fxNode and not tolua.isnull(fxNode) and fxNode:getParent()) then
                fxNode:removeFromParent()
            end
        end
        -- bufferFXMap[buffID] = nil
    end
    self._bufferFXMap = {}
end

-- 清理技能特效
function RoleRenderer:clearSkillFX()
    if (self._skillFX) then
        self._skillFX:removeFromParent()
        self._skillFX = nil
    end
end

-- 获取角色动画
function RoleRenderer:getRoleAnimation()
    return self._roleAnimation
end

-- 获取角色挂载点的在地图中的位置
function RoleRenderer:getPositionOfSlot(slotName)
    if (self._roleAnimation) then
        local slotPosX, slotPosY = self._roleAnimation:getPositionOfSlot(slotName)
        local posX, posY = self:getPosition()
        return slotPosX + posX, slotPosY + posY
    else
        return 0, 0
    end
end

-- 设置角色动画大小
function RoleRenderer:setRoleAnimationSize(roleAnimationSize)
    self._roleAnimationSize = roleAnimationSize
    if self._attribute then
        self._attribute:setSize(self._roleAnimationSize)
    end
end

-- 注册英雄动画事件
function RoleRenderer:_registerRoleSpineEventHandle()
    -- print("RoleRenderer:_registerRoleSpineEventHandle 22222222222=", self._roleType)
    self._roleAnimation:registerSpineEventHandler(function(event)
        -- print("RoleRenderer:_registerRoleSpineEventHandle eventName=", event.eventData.name)
        if string.find(event.eventData.name, "plot_") ~= nil then
            local plotID = string.sub(event.eventData.name,6,-1)
            if DEBUG then
                print("RoleRenderer:_registerRoleSpineEventHandle plotID=", plotID)
            end
            PlotManager:getInstance():runPlotByID(plotID)
        end

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
        
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "skill_30000401")
            if(startPos ~= nil) then
                -- print("RoleRenderer:_registerRoleSpineEventHandle eventName=", event.eventData.name, self._assistSkillID)
                if(self._assistSkillID == TRANSFER_SKILL_ID) then
                    -- 播放传送特效
                    self:_showTranserEffect()
                    -- 开始消失
                    self._roleAnimation:runSpineAction(cc.FadeOut:create(0.5))
                end
            end
        end

        if(event and event.eventData and event.eventData.name) then 
            if(event.eventData.name == "boss_start_enter_scene" or event.eventData.name == "boss_start_dead") then 
                Avalon.MessageCenter:notice(GameMessage.MC_RENDERER_PLOT_NOTICE, event.eventData.name)
            end
        end

        if(event and event.eventData and event.eventData.name) then 
            if self._monsterData then
                print(" event.eventData.name ====   ",event.eventData.name, self._monsterData.tombstoneAnimation)
            end
            local startPos = string.find(event.eventData.name, "die")
            if(startPos ~= nil) then
                -- TODO 播放墓碑动画
                if self._monsterData and self._monsterData.tombstoneAnimation ~= "" then
                    local deathEntityAnimation = Avalon.Animation:create(self._monsterData.tombstoneAnimation .. ".json", self._monsterData.tombstoneAnimation .. ".atlas", 1);
                    self:addChild(deathEntityAnimation)
                    deathEntityAnimation:setAnimation(0,"begin",false)
                    deathEntityAnimation:addAnimation(0,"idle",true)
                    self._deathEntityAnimation = deathEntityAnimation
                end
            end
        end
    end,sp.EventType.ANIMATION_EVENT)

    -- 监听 spine 加载完成
    self._roleAnimation:setLoadedSpineSuccessCallBack(function ()
        -- print("RoleRenderer:init  spine load success callback")
        self:_triggerLoadSpineSuccess()
    end)
end

function RoleRenderer:assistSkillTranseferEnd()
    if(self._assistSkillID) then
        self:_showTranserEffect()
        -- 开始显示
        
        self._roleAnimation:runSpineAction(cc.FadeIn:create(0.5))

        self._assistSkillID = nil
    end
end

function RoleRenderer:assistSkillUseFail()
    -- print(":assistSkillUseFail")
    self._assistSkillID = nil
    -- self:showIDLE()
    self._roleAnimation:stopSpineAction()
    self._roleAnimation:runSpineAction(cc.FadeIn:create(0.01))
    self:removeWeaponAssistAnimation()
end

function RoleRenderer:_showTranserEffect()
    local skeleton = "skill_30000401.json"
    local atlas = "skill_30000401.atlas"
    local mount = "mount_bottom"

    scale = (scale ~= nil) and scale or 1.0

    local fxNode = Avalon.Animation:create(skeleton, atlas, scale);
    fxNode:setUnloadResFlag(false)
    fxNode:registerSpineEventHandler(function(event)
        local startPos = string.find(event.animation, "release_skill")
        if (startPos ~= nil) then
            fxNode:runAction(cc.RemoveSelf:create())

            self:removeRoleFxFromSave(fxNode)
            self:removeBuffFx(fxNode)
        end
        -- if event.animation == "end" then
        --     fxNode:runAction(cc.RemoveSelf:create())
        -- end

        if DEBUG then
            print(string.format("RoleRenderer addRoleFX: %s animation end, event track %d, event name %s.", self, event.trackIndex, event.animation))
        end
    end, sp.EventType.ANIMATION_END)

    fxNode:registerSpineEventHandler(function (event)
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

    self:selfAddComponent(mount, fxNode)
    fxNode:setAnimation(0, "release_skill", false)
end

-- 创建一个伤害组件
function RoleRenderer:_createAttributeComponent()
    -- 添加属性改变显示
    if self._attribute then
        if self._attribute:getParent() then
            self._attribute:removeFromParent()
        end
        self._attribute = nil
    end

    self._attribute = Component.Attribute:create()
    if (self._attribute) then
        self._attribute:setRoleType(self._roleType)
        if self._roleAnimationSize then
            self._attribute:setSize(self._roleAnimationSize)
        end

        local addMap = true
        if addMap == true then
            -- TODO 这里添加显示的方式需要做相关处理
            if self._attrAddNode then
                self._attrAddNode:addNodeBeyondMap(self._attribute)
            else
                assert(false, "self._attribute not add node")
                -- if self._viewNode then
                --     local parentNode = self._viewNode:getParent()
                --     if parentNode then
                --         parentNode:addChild(self._attribute,1000000)
                --     else
                --         -- TODO 不建议这样做，这里应该整理
                --         local BattleMachine = MachineManager:getInstance():getMachine()
                --         if (BattleMachine) then
                --             BattleMachine._view._mapNode.map:addChild(self._attribute,1000000)
                --         end
                --     end
                -- end
            end
        else
            self:addChild(self._attribute, ROLE_ATTRIBUTE_ZORDER)
        end
    else
        assert(false, string.format("[ERROR] RoleRenderer init: create role Attribute Component (%d) failed.", roleType))
    end
end

-- 加速(1.0表示不加速)
function RoleRenderer:speedUp(timeScale)
    self._timeScale = timeScale
    if (self._roleAnimation) then
        self._roleAnimation:setTimeScale(timeScale)
    end
    if self._heroRideAnimation then
        self._heroRideAnimation:setTimeScale(timeScale)
    end
end

-- 恢复播放速度
function RoleRenderer:recoverSpeedUp()
    if (self._roleAnimation) then
        self._roleAnimation:setTimeScale(self._timeScale)
    end
end

-- 冰冻效果
function RoleRenderer:frozen()
    if DEBUG then
        print("RoleRenderer:frozen ")
    end
    
    if (self._roleAnimation) then
        self._roleAnimation:setTimeScale(0)
    end
end

-- 从冰冻中恢复
function RoleRenderer:frozenRecover()
    if DEBUG then
        print("RoleRenderer:frozenRecover ")
    end
    self:recoverSpeedUp()
end

-- 束缚效果
function RoleRenderer:constraint()
    if DEBUG then
        print("RoleRenderer:constraint ")
    end
    if (self._roleAnimation) then
        self._roleAnimation:setTimeScale(0)
    end
end

-- 从束缚中恢复
function RoleRenderer:constraintRecover()
    if DEBUG then
        print("RoleRenderer:constraintRecover ")
    end
    self:recoverSpeedUp()
end

function RoleRenderer:addLoadedSpineSuccessCallBack(obj,callBack)
    self.loadedSpineSuccessObj = obj
    self.loadedSpineSuccessCallBack = callBack
end

-- 处理攻击移动
function RoleRenderer:attackShack()
    -- print("RoleRenderer:attackShack()")
    if(self._roleAnimation) then
        -- print("RoleRenderer:attackShack()  1")
        self._roleAnimation:stopAllActions()

        self:animationGray(0.05)

        local time = 0.1
        local x,y = 0, 0
        local d = 0.02
        local allAction = {}
        local offsetX = 10
        local offsetY = -10
        if (self._direction == DirectionType.EAST or
            self._direction == DirectionType.SOUTH) then
            offsetX = -10
            offsetY = 10
        else

        end 
        for j = 1,math.floor(time/d/4) do
            local mt1 = cc.MoveTo:create(d*2,cc.p(x + offsetX, y+offsetY));
            local mt2 = cc.MoveTo:create(d*2,cc.p(x, y));

            table.insert(allAction, mt1)
            table.insert(allAction, mt2)
        end

        local endActon = cc.MoveTo:create(d, cc.p(x,y));
        table.insert(allAction,endActon)

        local _action = cc.Sequence:create(allAction)
        self._roleAnimation:runAction(_action)
    end
end

function RoleRenderer:animationGray(time)
    if(self._roleAnimation and self._roleAnimation._spine and self._oldGlProgramState) then
        if self._roleAnimation:getSpineVersion() < 3060039 then
            self._roleAnimation._spine:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_TEXTURE_RED_COLOR))
        else
            self._roleAnimation._spine:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_TEXTURE_RED_COLOR2))
        end
        local callBack = function()
            if(not tolua.isnull(self._roleAnimation) and not tolua.isnull(self._roleAnimation._spine) and self._oldGlProgramState) then 
                self._roleAnimation._spine:setGLProgramState(self._oldGlProgramState)
            end
        end
        -- Avalon.Scheduler:scheduleUpdateOnce(self, callBack, time)
        Avalon.Scheduler:scheduleUpdateOnceAndMinFrame(self, callBack, time, 2)
    end
end

-- 角色动画加载完成的逻辑处理
function RoleRenderer:_triggerLoadSpineSuccess()

    if self.loadedSpineSuccessObj and self.loadedSpineSuccessCallBack then
        self.loadedSpineSuccessCallBack(self.loadedSpineSuccessObj)
    end
    -- 触发血条显示高度问题
    if(self._roleAnimation and self._roleAnimation._spine) then
        self._roleAnimation:runAction(cc.Sequence:create(cc.DelayTime:create(0.1),cc.CallFunc:create(function()
            --TODO 处理动画加载完成的逻辑处理
            -- print("RoleRenderer:_triggerLoadSpineSuccess  delay handle.")
            if (self._roleAnimation and not tolua.isnull(self._roleAnimation._spine)) then
                self._oldGlProgramState = self._roleAnimation._spine:getGLProgramState()

                if (self._bloodNode) then
                    local boundBosSize = self._roleAnimation:getBoundingBox()
                    if(boundBosSize) then
                        local bloodHeight = boundBosSize.height
                        if(bloodHeight > BLOOD_MAX_HEIGHT) then 
                            bloodHeight = BLOOD_MAX_HEIGHT
                        end

                        self._bloodNode:setPosition(cc.p(0, bloodHeight))
                    end
                end
            end 
        end)))
    end

end
function RoleRenderer:setVisible( visible )
    RoleRenderer.super.setVisible(self,visible)

    if self._roleAnimation then
        self._roleAnimation:setVisible(visible)
    end
    if self._weaponAnimation then
        self._weaponAnimation:setVisible(visible)
    end
    if self._weaponAssistAnimation then
        self._weaponAssistAnimation:setVisible(visible)
    end
    
    for k, animation in pairs(self._statusAnimationArr) do 
        if(not tolua.isnull(animation))  then 
            animation:setVisible(visible)
        end
    end
    
    for k, data in pairs(self._roleFxArr) do 
        if(data.animation and (not tolua.isnull(data.animation))) then 
            data.animation:setVisible(visible)
        end
    end
    -- print("RoleRenderer.setVisible",visible)
end

function RoleRenderer:_handleAngerAttrChange(changeInfo)

-- print("_handleAngerAttrChange  anger......11111", changeInfo)
    if changeInfo.resultValue > 0 then
        local percent = changeInfo.resultValue/PublicDefine.CONST_DEFINITION.MAX_ANGER_VALUE
        if not self._bossAngerProgress then
            self._bossAngerProgress = AngerProgressComponent:create(percent)
            
            self:addChild(self._bossAngerProgress, ROLE_ATTRIBUTE_ZORDER)
            if (self._direction == DirectionType.EAST or
                self._direction == DirectionType.SOUTH) then
                self._bossAngerProgress:setPosition(cc.p(-105, 100))
                self._bossAngerProgress:setFlippedX(false)
            else
                self._bossAngerProgress:setPosition(cc.p(45, 100))
                self._bossAngerProgress:setFlippedX(true)
            end
        else
            self._bossAngerProgress:updateProcess(percent)
        end
        
    else
        if self._bossAngerProgress then
            self._bossAngerProgress:removeFromParent()
            self._bossAngerProgress = nil
        end
    end
end

function RoleRenderer:_handleHorcurxChange(changeInfo)
    if changeInfo.resultValue > 0 then
        local percent = changeInfo.resultValue/PublicDefine.CONST_DEFINITION.MAX_ANGER_VALUE
        if not self._horcurxEnergyProgress then
            self._horcurxEnergyProgress = AngerProgressComponent:create(percent,3)
            
            self:addChild(self._horcurxEnergyProgress, ROLE_ATTRIBUTE_ZORDER)
            if (self._direction == DirectionType.EAST or
                self._direction == DirectionType.SOUTH) then
                self._horcurxEnergyProgress:setPosition(cc.p(-105, 100))
                self._horcurxEnergyProgress:setFlippedX(false)
            else
                self._horcurxEnergyProgress:setPosition(cc.p(45, 100))
                self._horcurxEnergyProgress:setFlippedX(true)
            end
        else
            self._horcurxEnergyProgress:updateProcess(percent)
        end
        
    else
        if self._horcurxEnergyProgress then
            self._horcurxEnergyProgress:removeFromParent()
            self._horcurxEnergyProgress = nil
        end
    end
end

function RoleRenderer:_handleEnergyAttrChange(changeInfo)
-- print("_handleEnergyAttrChange  energy......11111", changeInfo)
    if changeInfo.resultValue > 0 then
        local percent = changeInfo.resultValue/PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE
        if not self._energyProgress then
            self._energyProgress = AngerProgressComponent:create(percent, 2)
            
            self:addChild(self._energyProgress, ROLE_ATTRIBUTE_ZORDER)
        else
            self._energyProgress:updateProcess(percent)
        end
        if (self._direction == DirectionType.EAST or
            self._direction == DirectionType.SOUTH) then
            self._energyProgress:setPosition(cc.p(-105, 100))
        else
            self._energyProgress:setPosition(cc.p(45, 100))
        end
    else
        if self._energyProgress then
            self._energyProgress:removeFromParent()
            self._energyProgress = nil
        end
    end
end


function RoleRenderer:_handleHorcurxEnergyAttrChange(changeInfo)
    if self._looks then
        if self._looks > 0 and self._looks < 9 then
            return
        end
    end
    print("_handleHorcurxEnergyAttrChange  ......11111", changeInfo)
    if tolua.isnull(self._horcruxExteriorAnimation) then
        return
    end
    if changeInfo.changeValue > 0 then
        if self._horcruxExteriorAnimation then
            if tolua.isnull(self._horcruxExteriorAnimation.horcruxAnim) then
                local slotNode = self._horcruxExteriorAnimation:getNodeForSlot("horcruxes_fx", isDefaultOrder)
                if (not slotNode) then 
                    return
                end
                local horcruxAnim = Avalon.Animation:create("effect_role_horcruxes_icon0103.json", "effect_role_horcruxes_icon0103.atlas", 1)
                horcruxAnim:setAnimation(0, "begin", false)
                -- horcruxAnim:addAnimation(0, "idle", true)
                horcruxAnim:setScale(10)
                self._horcruxExteriorAnimation:addComponent("horcruxes_fx", horcruxAnim)
                -- self:addChild( horcruxAnim,10001)
                self._horcruxExteriorAnimation.horcruxAnim = horcruxAnim
            else
                self._horcruxExteriorAnimation.horcruxAnim:setAnimation(0, "begin", false)
                -- self._horcruxExteriorAnimation.horcruxAnim:addAnimation(0, "idle", true)
            end
        end
    end

    -- self:_handleHorcurxChange(changeInfo)
end

function RoleRenderer:initCommonAttrHandler()
    self.commonAttrHandlers = {
        -- [ATTR_TYPE.anger] = self._handleAngerAttrChange,
        [ATTR_TYPE.horcruxEnergy] = self._handleHorcurxEnergyAttrChange,
    }
end

---现在只是在battleview中才会触发，如果城镇需要的话，需要再处理townview中
-- local mmm = 100
function RoleRenderer:handleCommonAttrChanged(data)
    local attrChange = data.attrChange
    -- print("enter....do doCommonAttrChanged....")
    -- local attrChange = {{changeType = ATTR_TYPE.energy, resultValue = mmm}}
    -- mmm = mmm + 1000
   
    -- print(attrChange)
    if attrChange  then
        for i = 1, #attrChange do
            local changeInfo = attrChange[i]
            if changeInfo.changeType ~= 6 then
                -- print("handleCommonAttrChanged", changeInfo)
            end
            local handler = self.commonAttrHandlers[changeInfo.changeType]
            if handler then
                handler(self, changeInfo)
            end
        end
    end
end

function RoleRenderer:getViewList()
    return self._lightAnimationList
end

function RoleRenderer:createLightViewList(animation, rotate)
    if(self._lightAnimationList == nil) then
        self._lightAnimationList = {}
        
        local npcAnimation = Avalon.Animation:create("effect_role_npc_bottom_light.json", "effect_role_npc_bottom_light.atlas", 1.0)
        npcAnimation:retain()
        table.insert(self._lightAnimationList, npcAnimation)
        npcAnimation:setAnimation(0, animation, true)
        npcAnimation:rotate(rotate)
    end

    return self._lightAnimationList
end

function RoleRenderer:runRoleAnimations(animations)
    if(self._roleAnimation and animations) then 
        for k, v in ipairs(animations) do 
            -- print("RoleRenderer:runRoleAnimations", v[1], v[2])
            if(k == 1) then 
                self._roleAnimation:setAnimation(0, v[1], v[2])
            else 
                self._roleAnimation:addAnimation(0, v[1], v[2])
            end
        end
    end
end

function RoleRenderer:showMonsterTransSmoke(scale)
    -- TODO 变身播放烟雾动画
    local transScale = scale or 1
    if self._monsterData then
        local tansSmokeAnimeName = "effect_role_monster_transfor"
        local tansSmokeAnime = Avalon.Animation:create(tansSmokeAnimeName .. ".json", tansSmokeAnimeName .. ".atlas", transScale);
        self:addChild(tansSmokeAnime, 99)
        tansSmokeAnime:setAnimation(0,"trigger",false)
        -- tansSmokeAnime:addAnimation(0,"idle",true)
        self._tansSmokeAnime = tansSmokeAnime

        self:_registerTransSpineEventHandler()
    end
end

function RoleRenderer:_registerTransSpineEventHandler()
    self._tansSmokeAnime:registerSpineEventHandler(function (event)
        if(DEBUG) then
            print(string.format("RoleRenderer:_registerTransSpineEventHandler[spine] %d end  animation=",event.trackIndex),event.animation)
        end
        
        if event.animation == "trigger" then -- 死亡动画播放完成
            if self._tansSmokeAnime then
                self._tansSmokeAnime:runAction(cc.Sequence:create(cc.RemoveSelf:create(),cc.CallFunc:create(function()
                    self._tansSmokeAnime = nil
                end)))
            end
        end
    end, sp.EventType.ANIMATION_END)

    -- self:_registerRoleSpineEventHandle()
end

function RoleRenderer:pause()
    RoleRenderer.super.pause(self)
    if(self._lightAnimationList) then 
        for i = 1, #self._lightAnimationList do
            local npcAnimation = self._lightAnimationList[i]
            if(not tolua.isnull(npcAnimation)) then
                if (npcAnimation:getParent() and npcAnimation.pause) then
                    npcAnimation:pause()
                end
            end
        end
    end

    if(not tolua.isnull(self._roleAnimation)) then
        self._roleAnimation:pause()
    end

    if(self._statusAnimationArr) then 
        for k, v in pairs(self._statusAnimationArr) do
            if(not tolua.isnull(v)) then
                if (v:getParent() and v.pause) then
                    v:pause()
                end
            end
        end
    end

    for k, data in pairs(self._roleFxArr) do 
        if(data.animation and (not tolua.isnull(data.animation))) then 
            data.animation:pause()
        end
    end
    if(not tolua.isnull(self._weaponAnimation)) then
        self._weaponAnimation:pause()
    end
    if(not tolua.isnull(self._weaponAssistAnimation)) then
        self._weaponAssistAnimation:pause()
    end
    for k, animation in pairs(self._statusAnimationArr) do 
        if((not tolua.isnull(animation)) and animation:getParent()) then 
            animation:pause()
        end
    end
    for k, animation in pairs(self._realeseActAniamtionArr) do 
        if((not tolua.isnull(animation)) and animation:getParent()) then 
            animation:pause()
        end
    end
    for k, animation in pairs(self._realeseAssistActAniamtionArr) do 
        if((not tolua.isnull(animation)) and animation:getParent()) then 
            animation:pause()
        end
    end
end

function RoleRenderer:resume()
    RoleRenderer.super.resume(self)
    if(self._lightAnimationList) then 
        for i = 1, #self._lightAnimationList do
            local npcAnimation = self._lightAnimationList[i]
            if(not tolua.isnull(npcAnimation)) then
                if (npcAnimation:getParent() and npcAnimation.resume) then
                    npcAnimation:resume()
                end
            end
        end
    end
    if(not tolua.isnull(self._roleAnimation)) then
        self._roleAnimation:resume()
    end
    if(self._statusAnimationArr) then 
        for k, v in pairs(self._statusAnimationArr) do
            if(not tolua.isnull(v)) then
                if (v:getParent() and v.resume) then
                    v:resume()
                end
            end
        end
    end

    for k, data in pairs(self._roleFxArr) do 
        if(data.animation and (not tolua.isnull(data.animation))) then 
            data.animation:resume()
        end
    end
    if(not tolua.isnull(self._weaponAnimation)) then
        self._weaponAnimation:resume()
    end
    if(not tolua.isnull(self._weaponAssistAnimation)) then
        self._weaponAssistAnimation:resume()
    end
    for k, animation in pairs(self._statusAnimationArr) do 
        if((not tolua.isnull(animation)) and animation:getParent()) then 
            animation:resume()
        end
    end
    for k, animation in pairs(self._realeseActAniamtionArr) do 
        if((not tolua.isnull(animation)) and animation:getParent()) then 
            animation:resume()
        end
    end
    for k, animation in pairs(self._realeseAssistActAniamtionArr) do 
        if((not tolua.isnull(animation)) and animation:getParent()) then 
            animation:resume()
        end
    end
end

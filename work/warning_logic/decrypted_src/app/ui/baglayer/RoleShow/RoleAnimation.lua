--[[
    UI - 角色动画
]]--

require "app.ui.Component"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local RoleAnimation = class("RoleAnimation", UI.HWBtnComponent)
UI.RoleAnimation = RoleAnimation

local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE

-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local ROLE_ANIMATION_WIDTH = 120
local ROLE_ANIMATION_HEIGHT = 140
-- 背包资源
local ROLE_ANIMATION_RES_LIST = nil
-- 动画缩放值
local ROLE_ANIMATION_SCALE = 1.8
local ROLE_HORCURX_TRANS_SCALE = 1

-- 获取开心的动画名字
local function getHappyAnim(self)
    local happyAnim = ""
    if(self._roleData and self._roleData:getLooks() ==0) then
        local no = math.random(1, 2)
        happyAnim = string.format("happy_%d", no)
    else
        --TODO 处理变形后高兴动画的处理
        happyAnim = "idle"
    end

    return happyAnim
end

-- 获取待机的动画名字
local function getIDLEAnim(self, weaponType)
    local idleAnim = ""
    if(self._roleData and self._roleData:getLooks() ==0) then
        idleAnim = string.format("attackidle_%d", weaponType)
    else
        --TODO 处理变形后待机动画的处理
        idleAnim = "idle"
    end

    return idleAnim
end

-- 升级处理器
local function onLevelUpHandler(self)
    if (self._roleRenderer) then
        self._roleRenderer:_triggerLevelUp(true)
    end
end

-- 状态刷新了
local function onLooksChangeHandler(self, spriteID, looks)
    if(self._roleData and spriteID == self._roleData:getSpriteID()) then
        if(self._roleRenderer) then
            self._roleRenderer:looksChange(looks)

            local weaponEquipmentData = nil
            local wearEquipmentData = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
            if (wearEquipmentData) then
                for i = 1, #wearEquipmentData do
                    local equipmentData = wearEquipmentData[i]
                    local equipmentType = equipmentData:getEquipmentType()
                    if (equipmentType == EQUIPMENT_TYPE.Weapon) then weaponEquipmentData= equipmentData
                    end
                end
            end

            self:showIDLEAnimation(weaponEquipmentData)
        end
    end
end

-- 构造函数
function RoleAnimation:ctor(bListen)
    RoleAnimation.super.ctor(
        self, 
        UIType.BAG_ROLE_ANIMATION, 
        ROLE_ANIMATION_RES_LIST, 
        ROLE_ANIMATION_WIDTH, 
        ROLE_ANIMATION_HEIGHT
    )

    self._currentIDLEAnimation = nil
     self._currentWeaponType = 1
    self._roleData = nil
    self._roleRenderer = nil
    self._showHelmet = true
    self.roleLoadedSpineSuccess = false

    self._wearEquipmentData = nil
    self._showBlink = false

    self.bListen = bListen
    if self.bListen == nil then
        self.bListen = true
    end
    if bListen then
        Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_LEVEL_UP, self, onLevelUpHandler)
        Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LOOKS_CHANGE, self, onLooksChangeHandler)
    end
end

-- 析构函数
function RoleAnimation:dtor()
    self._currentIDLEAnimation = nil
     self._currentWeaponType = 1
    self._roleData = nil
    if (self._roleRenderer) then
        self._roleRenderer:destroy()
        self._roleRenderer = nil
    end

    RoleAnimation.super.dtor(self)
    if bListen then
        Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_LEVEL_UP, self, onLevelUpHandler)
        Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LOOKS_CHANGE, self, onLooksChangeHandler)
    end
end

-- public:
-- 初始化
function RoleAnimation:init(roleData)
    self._roleData = roleData

    RoleAnimation.super.init(self)

    self:updateUIScale()
end

-- 初始化视图
function RoleAnimation:onInitView()
    
end

function RoleAnimation:updataLooks(looks)
    self.looks = looks

    if (self._roleRenderer) then
        self._roleRenderer:looksChange(looks,true)
    end
end

-- 更新视图
function RoleAnimation:onUpdateView()
    if (self._roleData) then
        -- 清理旧的角色渲染器
        if (self._roleRenderer) then
            self._roleRenderer:destroy()
            self._roleRenderer = nil
        end

        -- print(debug.traceback())

        -- 创建新的角色渲染器
        local wearEquipmentData = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr

        -- self._wearEquipmentData = wearEquipmentData

        local skeletonFile, atlasFile, scale = self._roleData:getAnimationData()

        local sex = self._roleData:getSex()
        local faceDecodeID = self._roleData:getFaceDecodeID()
        
        local looks = self._roleData:getLooks()
        self._roleRenderer = Renderer.HeroRenderer:create()
        
        self._roleRenderer:addLoadedSpineSuccessCallBack(self, function()
            self:dispatchEvent(UIEvent.ROLE_LOADED_SPINE_SUCCESS)
            self.roleLoadedSpineSuccess = true
        end)
        print("RoleAnimation:onUpdateView",skeletonFile, atlasFile, scale,sex)
        if not self.looks then
            self.looks = looks
        end
        
        local isHideHelmet = self._roleData:getIsHideHelmet()
        self._roleRenderer:init(skeletonFile, atlasFile, scale, sex,self._roleData:isMasterHero(),faceDecodeID, self.looks, isHideHelmet)
        self._showHelmet = not isHideHelmet
        if self._showHelmet == false then
            self._roleRenderer:changeIsHideHelmet(true)
        else
            self._roleRenderer:changeIsHideHelmet(false)
        end
        self._roleRenderer:setPosition(ROLE_ANIMATION_WIDTH / 2, 5)
        if self._roleData:isMasterHero() then
            self:updateRoleEquipment(wearEquipmentData)
            self._roleRenderer:refreshEquip(wearEquipmentData)
        end
        
        self._roleRenderer:setScale(ROLE_ANIMATION_SCALE)
        if self._roleData:isMasterHero() then
            if self._roleData:isHorcruxTransform() and self.looks > 0 then
                self._roleRenderer:setScale(ROLE_HORCURX_TRANS_SCALE)
            end
        end
        self:addChild(self._roleRenderer:getView())

        self._roleRenderer:getHeroAnimation():registerSpineEventHandler(function (event)
            -- print("self._roleRenderer:getHeroAnimation():registerSpineEventHandler", self._showBlink, event.animation)
            if self._showBlink then 
                if(string.find(event.animation, "idle_town_")) then
                    -- 切换城镇特殊表现
                    if self._idleNum == nil then
                        self._idleNum = 0
                    end
                    self._idleNum = self._idleNum + 1   
                    if(self._idleNum >3) then
                        -- if math.random(1,4) <=1 then
                            -- print("MonsterRenderer:_registerSpineEventHandler ANIMATION_COMPLETE run idle2")
                            self._idleNum = 0
                            self._roleRenderer:getHeroAnimation():setAnimation(0, "idle_blink_"..self._currentWeaponType, false)
                            self._roleRenderer:getHeroAnimation():addAnimation(0, "idle_town_"..self._currentWeaponType, true)
                        -- end
                    end
                end
            end 
        end, sp.EventType.ANIMATION_COMPLETE)
    end
end

-- 设置角色数据
function RoleAnimation:setRoleData(roleData)
    self._roleData = roleData

    self:updateUIScale()
end

function RoleAnimation:updateUIScale()
    if not self._roleData then
        return
    end
    local sc = self._roleData:getUIScale()
    self:setScale(sc)
end

-- 显示武器的动画
function RoleAnimation:showIDLEAnimation(equipmentData)
    if (self._roleRenderer) then
        self._currentWeaponType = 1
        if (equipmentData) then
            local weaponType = equipmentData:getWeaponType()
            self._currentIDLEAnimation = getIDLEAnim(self, weaponType)
            self._currentWeaponType = weaponType
        else
            -- self._currentIDLEAnimation = self._roleRenderer:getIDLEAnim()
            if(self._roleData and self._roleData:getLooks() ==0) then
                self._currentIDLEAnimation = "attackidle_0"
            else
                self._currentIDLEAnimation = "idle"
            end
        end
        self._roleRenderer:showAnimation(self._currentIDLEAnimation)
    end
end

-- 播放开心的动画
function RoleAnimation:showHappyAnimation()
    if (self._roleRenderer) then
        local happyAnimationName = getHappyAnim(self)
        self._roleRenderer:showAnimation(happyAnimationName, self._currentIDLEAnimation)
    end
end

function RoleAnimation:showBlink(blinkFlag)
    self._showBlink = blinkFlag
end

-- 刷新装备
function RoleAnimation:updateRoleEquipment(wearEquipmentData)
    if (self._roleRenderer and wearEquipmentData) then
        self._wearEquipmentData = wearEquipmentData
        self._roleRenderer:refreshEquip(wearEquipmentData)
    end
end

--获取roleRender
function RoleAnimation:getRoleRender()
    return self._roleRenderer
end

function RoleAnimation:showHelmet()
    -- print("RoleAnimation:showHelmet")
    self._showHelmet = true
    if self._roleRenderer then
        self._roleRenderer:changeIsHideHelmet(false)
        self._roleRenderer:refreshEquip(self._wearEquipmentData)
    end
end


function RoleAnimation:hideHelmet()
    -- print("RoleAnimation:hideHelmet")
    self._showHelmet = false
    if self._roleRenderer then
        self._roleRenderer:changeIsHideHelmet(true)
        self._roleRenderer:refreshEquip(self._wearEquipmentData)
    end
end

function RoleAnimation:refreshFace(faceDecodeID)
    if (self._roleRenderer) then
        self._roleRenderer:refreshFace(faceDecodeID)
    end
end


-- 播放转生的动画
function RoleAnimation:showReincarnactionAnimation(dt)
    if (self._roleRenderer) then
        local weaponEquipmentData = nil
        local wearEquipmentData = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
        if (wearEquipmentData) then
            for i = 1, #wearEquipmentData do
                local equipmentData = wearEquipmentData[i]
                local equipmentType = equipmentData:getEquipmentType()
                if (equipmentType == EQUIPMENT_TYPE.Weapon) then 
                    weaponEquipmentData= equipmentData
                end
            end
        end
        if weaponEquipmentData then
            local weaponType = weaponEquipmentData:getWeaponType()
            self._currentIDLEAnimation = getIDLEAnim(self, weaponType)
            self._currentWeaponType = weaponType
        end
    
        local animationName = "hero_zhuansheng"
        -- self._roleRenderer:showCustomAnimation(animationName, self._currentIDLEAnimation)

        self._roleRenderer:getHeroAnimation():setAnimation(0, animationName, false)
        self._roleRenderer:getHeroAnimation():setMix(animationName, self._currentIDLEAnimation, dt)
        -- self._roleRenderer:getHeroAnimation():addAnimation(0, self._currentIDLEAnimation, false)
        -- self._roleRenderer:getHeroAnimation():addAnimation(0, "idle_blink_"..self._currentWeaponType, false)
        performWithDelay(self, function() 
            self._roleRenderer:getHeroAnimation():addAnimation(0, self._currentIDLEAnimation, true)
        end, dt+0.3)
        
    end
end
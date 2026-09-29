local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local CaveShadowLayer = class("CaveShadowLayer", UI.HWBtnComponent)
UI.CaveShadowLayer = CaveShadowLayer

local winSize = cc.Director:getInstance():getWinSize()
local caveShadowDesignWidth = 1136
local caveShadowDesignHeight = 640
local caveShadowMaxSceneLevel = 5
local caveShadowPulseScaleOffset = 0.3
local caveShadowLevelScaleFactorMin = 0
local caveShadowLevelScaleFactorMax = 0
local caveShadowPulseIntervalNormal = 1.5
local caveShadowPulseIntervalLowHP = 0.5

-- 资源列表(必备)
local COM_RES_LIST = {

}

function CaveShadowLayer:isShowNormalLayer(b)
    self._showNormal = b
    self:refreshCaveShadow(true)
end

--构造函数(必备)
function CaveShadowLayer:ctor(spriteID)
    CaveShadowLayer.super.ctor(
        self, UIType.FULL_SCREEN,
        COM_RES_LIST,
        winSize.width,    
        winSize.height
    )
    self._showNormal = true
    local masterData = GameDataManager:getInstance():getMaster()
    local dangerousHp =  masterData:getHp() * ConfigManager:getDangerousHPPercent() / PERCENT_NUMBER
    if(dangerousHp <= masterData:getCurHp()) then
        self._dangerousHp = false
    else 
        self._dangerousHp = true
    end

    self:init(SceneManager:getInstance():isNotInFightScene())

    Avalon.MessageCenter:bind(AvalonMessage.MC_MAP_SET_IS_CAVE_SHADOW_SHOW, self, self.isShowNormalLayer)
end

--虚构函数,destroy时调用(必备)
function CaveShadowLayer:dtor()
    Avalon.ResHelper:unloadPlist("ui_bg_cover.plist")
    CaveShadowLayer.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MAP_SET_IS_CAVE_SHADOW_SHOW, self, self.isShowNormalLayer)
end

-- 初始化(必备)
function CaveShadowLayer:init(isInTown)
    self._isInTown = isInTown
    CaveShadowLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function CaveShadowLayer:onInitView()
    CaveShadowLayer.super.onInitView(self)
    self._caveShadowComponents = {}

    if (self._isInTown) then
        Avalon.ResHelper:loadPlistSync("ui_bg_cover.plist")
        -- 城里使用静态拼凑图
        local caveShadowScaleX = (winSize.width - Avalon.issUtil:getWidthOffset()) / 1136
        local caveShadowScaleY = winSize.height / 640
        self._caveShadowStaticRed = UI.Component:create()
        self._caveShadowStaticRed:init()
        self._caveShadowStaticRed:center()
        self._caveShadowStaticRed:setSize(winSize.width, winSize.height)
        self._caveShadowStaticRed:setVisible(false)
        self:addChild(self._caveShadowStaticRed)

        self._caveShadowStatic = UI.Component:create()
        self._caveShadowStatic:init()
        self._caveShadowStatic:center()
        self._caveShadowStatic:setSize(winSize.width, winSize.height)
        self:addChild(self._caveShadowStatic)

        local halfIPhoneXWidth = 640 / 1125 * 2436 / 2
        local winSizeHalf = winSize.width / 2
        self._caveShadowStaticLeftHost = UI.Component:create()
        self._caveShadowStaticLeftHost:init()
        self._caveShadowStaticLeftHost:centerRight(winSizeHalf)
        self._caveShadowStaticLeftHost:setSize(halfIPhoneXWidth, 640)
        self._caveShadowStaticLeftHost:setScaleX(halfIPhoneXWidth > winSizeHalf and 1 or (winSizeHalf + 1) / halfIPhoneXWidth)
        self._caveShadowStaticLeftHost:setScaleY(winSize.height / caveShadowDesignHeight)
        self:addChild(self._caveShadowStaticLeftHost)

        self._caveShadowStaticRightHost = UI.Component:create()
        self._caveShadowStaticRightHost:init()
        self._caveShadowStaticRightHost:centerLeft(winSizeHalf)
        self._caveShadowStaticRightHost:setSize(halfIPhoneXWidth, 640)
        self._caveShadowStaticRightHost:setScaleX(halfIPhoneXWidth > winSizeHalf and 1 or (winSizeHalf + 1) / halfIPhoneXWidth)
        self._caveShadowStaticRightHost:setScaleY(winSize.height / caveShadowDesignHeight)
        self:addChild(self._caveShadowStaticRightHost)

        self._caveShadowStaticLeft = UI.Image:create()
        self._caveShadowStaticLeft:init("ui_bg_mask3.png")
        self._caveShadowStaticLeft:setScaleX(-1)
        self._caveShadowStaticLeft:setOpacity(230)
        self._caveShadowStaticLeft:centerRight(winSizeHalf - (self._caveShadowStaticLeft._width - 140) - Avalon.issUtil:getLeftMargin())
        self._caveShadowStaticLeftHost:addChild(self._caveShadowStaticLeft)

        self._caveShadowStaticRight = UI.Image:create()
        self._caveShadowStaticRight:init("ui_bg_mask3.png")
        self._caveShadowStaticRight:setOpacity(230)
        self._caveShadowStaticRight:centerLeft(winSizeHalf - (self._caveShadowStaticRight._width - 140) - Avalon.issUtil:getRightMargin())
        self._caveShadowStaticRightHost:addChild(self._caveShadowStaticRight) 
    else
        -- 洞内使用动画
        local caveShadowScaleX = winSize.width / 1120
        local caveShadowScaleY = winSize.height / 630
        local levelBgFileName = "effect_ui_town_full_shadow0%d"
        local mapSceneLevel = self:getSceneLevelForShadow()
        if not mapSceneLevel then
            return
        end
        if mapSceneLevel >= 10 then
            levelBgFileName = "effect_ui_town_full_shadow%d"
        end
        levelBgFileName = string.format(levelBgFileName, mapSceneLevel)

        self._caveShadow = UI.Animation:create()
        self._caveShadow:init(levelBgFileName .. ".json", levelBgFileName .. ".atlas")
        self._caveShadow:center(-20, 1)
        self._caveShadow:setScaleX(caveShadowScaleX * self:getCurrentLevelScaleFactor())
        self._caveShadow:setScaleY(caveShadowScaleY * self:getCurrentLevelScaleFactor())
        self._caveShadow:setAnimation("shadow", true)
        self:addChild(self._caveShadow)

        local levelBgFileName = levelBgFileName.."_bubble"
        if AvalonUtil.isResFileExisit(levelBgFileName .. ".json") then
            local rotation = {180,90,-90,0}
            for i = 1, 4 do
                local ani = UI.Animation:create()
                ani:init(levelBgFileName .. ".json", levelBgFileName .. ".atlas")
                if self._caveShadow:hasSlot("shadow"..i) then
                    ani:center()
                    -- ani:setScaleX(caveShadowScaleX * self:getCurrentLevelScaleFactor())
                    -- ani:setScaleY(caveShadowScaleY * self:getCurrentLevelScaleFactor())
                    ani:setAnimation("shadow", true)
                    ani:setRotation(rotation[i])
                    self._caveShadow:addComponent("shadow"..i, ani, true)
                    self._caveShadowComponents[i] = ani
                end
            end
        end
    end
    self:refreshCaveShadow(true)
end

-- 模版函数：更新组建的视图
function CaveShadowLayer:onUpdateView()
    CaveShadowLayer.super.onUpdateView(self)
end

-- 更新遮罩状态
function CaveShadowLayer:refreshCaveShadow(isInstant)
    if (self._isInTown) then
        self._caveShadowStatic:stopAllActions()
        self._caveShadowStaticRed:stopAllActions()
        local caveShadowCurrent = nil
        local caveShadowPulseInterval = caveShadowPulseIntervalNormal
        local caveShadowLevelFactor = 1
        if(isInstant) then
            if(self._dangerousHp) then 
                self._caveShadowStatic:setVisible(false)
                self._caveShadowStaticRed:setVisible(true)
                caveShadowCurrent = self._caveShadowStaticRed
                caveShadowPulseInterval = caveShadowPulseIntervalLowHP
            else
                self._caveShadowStatic:setVisible(true)
                self._caveShadowStaticRed:setVisible(false)
                caveShadowCurrent = self._caveShadowStatic
                caveShadowLevelFactor = self:getCurrentLevelScaleFactor()
            end
        else 
            if(self._dangerousHp) then 
                self._caveShadowStatic:runAction(cc.Sequence:create(
                    cc.FadeOut:create(0.5),
                    cc.CallFunc:create(function() self._caveShadowStatic:setVisible(false) end)))
                self._caveShadowStaticRed:setVisible(true)
                self._caveShadowStaticRed:setOpacity(0)
                -- self._caveShadowStaticRed:runAction(cc.FadeIn:create(0.5))
                caveShadowCurrent = self._caveShadowStaticRed
                caveShadowPulseInterval = caveShadowPulseIntervalLowHP
            else
                self._caveShadowStaticRed:runAction(cc.Sequence:create(
                    cc.FadeOut:create(0.5),
                    cc.CallFunc:create(function() self._caveShadowStaticRed:setVisible(false) end)))
                self._caveShadowStatic:setVisible(true)
                self._caveShadowStatic:setOpacity(0)
                -- self._caveShadowStatic:runAction(cc.FadeIn:create(0.5))
                caveShadowCurrent = self._caveShadowStatic
                caveShadowLevelFactor = self:getCurrentLevelScaleFactor()
            end
        end
        caveShadowCurrent:runAction(cc.RepeatForever:create(cc.Sequence:create(
            cc.FadeTo:create(caveShadowPulseInterval, 255 * 0.8),
            cc.FadeTo:create(caveShadowPulseInterval, 255)
            -- cc.ScaleTo:create(caveShadowPulseInterval, caveShadowScaleX * caveShadowLevelFactor + caveShadowPulseScaleOffset, caveShadowScaleY * caveShadowLevelFactor + caveShadowPulseScaleOffset),
            -- cc.ScaleTo:create(caveShadowPulseInterval, caveShadowScaleX * caveShadowLevelFactor, caveShadowScaleY * caveShadowLevelFactor)
        )))
    else
        if(isInstant) then
            if not self._caveShadow then
                return
            end
            if(self._dangerousHp) then 
                self._caveShadow:show()
                self._caveShadow:setAnimation("red", true)
                for _, ani in pairs(self._caveShadowComponents) do
                    ani:setAnimation("red", true)
                end
            elseif (self._showNormal) then
                self._caveShadow:show()
                self._caveShadow:setAnimation("shadow", true)
                for _, ani in pairs(self._caveShadowComponents) do
                    ani:setAnimation("shadow", true)
                end
            else
                self._caveShadow:hide()
            end
        else
            if(self._dangerousHp) then
                self._caveShadow:show()
                self._caveShadow:setAnimation("black_red", false)
                self._caveShadow:addAnimation("red", true)
                for _, ani in pairs(self._caveShadowComponents) do
                    ani:setAnimation("black_red", false)
                    ani:addAnimation("red", true)
                end
            elseif (self._showNormal) then
                self._caveShadow:show()
                self._caveShadow:setAnimation("red_black", false)
                self._caveShadow:addAnimation("shadow", true)

                for _, ani in pairs(self._caveShadowComponents) do
                    ani:setAnimation("red_black", false)
                    ani:addAnimation("shadow", true)
                end
            else
                self._caveShadow:hide()
            end
        end
    end
end

-- 根据洞内层数获取遮罩适用的场景ID
function CaveShadowLayer:getSceneLevelForShadow()
    -- 这里不需要阴影
    if(SceneManager:getInstance():isInLostRealm()) then 
        return nil
    end

    if SceneManager:getInstance():isDistortedSpaceCave()
    then
        return 9
    end
    if(SceneManager:getInstance():isInInferno()) then 
        -- TODO 这里将来添加后续副本的时候可能需要根据楼层做区分
        return 2
    end

    if(SceneManager:getInstance():isInWormhole()) then 
        -- TODO 这里将来添加后续副本的时候可能需要根据楼层做区分
        return 10
    end

    local level = GameMapManager:getInstance():getLevel()
    if SceneManager:getInstance():isActCave() then
        if level == PublicDefine.CONST_DEFINITION.MAZE_MAP_ID
            or level == PublicDefine.CONST_DEFINITION.BIG_CRACK_MAP_ID
        then
            return 0
        end
    end

    
    if (not SceneManager:getInstance():isInCave() and not SceneManager:getInstance():isInHero() and not SceneManager:getInstance():isInTitanHero()) then
        if (SceneManager:getInstance():isInTown()) then
            return 0
        else
            return 6
        end
    end

    local level = GameMapManager:getInstance():getLevel()
    if (not level) then return 0 end
    if (level == 1001 or
        level == 1002 or
        level == 1003 or
        level == 1004 or
        level == 1005)
    then
        return 1
    end

    local sceneLevel = math.ceil(level / 30)
    return sceneLevel > caveShadowMaxSceneLevel and caveShadowMaxSceneLevel or sceneLevel
end

-- 根据层数获取放大大小
function CaveShadowLayer:getCurrentLevelScaleFactor()
	if (not SceneManager:getInstance():isInCave() and not SceneManager:getInstance():isInHero() and not SceneManager:getInstance():isInTitanHero()) then
		return 1
	end

	local level = GameMapManager:getInstance():getLevel()
	if (not level) then return 0 end
	if (level == 1001 or
		level == 1002 or
		level == 1003 or
		level == 1004 or
		level == 1005)
	then
		return 1
	end

	local levelWithin30 = (level - 1) % 30
	local factor = (1 - levelWithin30 / 29) * (caveShadowLevelScaleFactorMax - caveShadowLevelScaleFactorMin)
	return 1 + factor
end

-- 红血事件处理
function CaveShadowLayer:onDangerousChange(flag) 
    if(self._dangerousHp ~= flag) then
        self._dangerousHp = flag
        self:refreshCaveShadow(false)
    end
end 
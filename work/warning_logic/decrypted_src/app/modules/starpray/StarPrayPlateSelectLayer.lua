-- StarPrayPlateSelectLayer.lua
-- Author:ydli
-- 2019年04月25日
-- Using: 星痕插槽公用圆盘，能够预览和拖拽（装配、个人面板、人物详情共用）
--传入 人物数据、槽位背包数据 

UI = UI or {}
local StarPrayPlateSelectLayer = class("StarPrayPlateSelectLayer", UI.Component)
UI.StarPrayPlateSelectLayer = StarPrayPlateSelectLayer
local GameDataManager = require("app.game.GameDataManager")

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(720, 720)
-- 背包资源
local COM_RES_LIST = {
    -- "ui_town_starpray.plist",
}


function StarPrayPlateSelectLayer:ctor()
    StarPrayPlateSelectLayer.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)
    -- self.equipsGrid = {}
    -- self.isSelf = false
    -- self.lastShowStarRoleLevel = 0
end

function StarPrayPlateSelectLayer:dtor()
    StarPrayPlateSelectLayer.super.dtor(self)
    reload_script_file("app.modules.starpray.StarPrayPlateSelectLayer")
end

function StarPrayPlateSelectLayer:init(heroData, starData, plateConfig)
    -- self:enableDebugDraw()
    self.starData = starData
    self.heroData = heroData

    -- self.plateConfig = plateConfig
    StarPrayPlateSelectLayer.super.init(self)

    -- if self.isSelf then
    --     cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.ShowStarPrayLockNew..heroData:getPK(), heroData:getLevel()) 
    -- end
    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:closePannelAction()
    end)
end

function StarPrayPlateSelectLayer:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

	local rootLayer = UI.Layout:create()
	rootLayer:init()
	rootLayer:setSize(layerSize.width, layerSize.height)
	rootLayer:center()
	self:addChild(rootLayer, 10)
	self.rootLayer = rootLayer
    -- rootLayer:enableDebugDraw()

    local bgAnime = UI.Animation:create()
    bgAnime:init("effect_ui_town_xingpan_b_di2.json", "effect_ui_town_xingpan_b_di2.atlas")
    bgAnime:center()
    -- bgAnime:setAnimation("idle1", false)
    -- bgAnime:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(self)
    --     bgAnime:destroy()
    --     if not tolua.isnull(self) then
    --         self:showRedPoint(bg)
    --     end
    -- end)
    rootLayer:addChild(bgAnime)

    local ringBg = UI.Image:create()
    ringBg:init("ui_starmarks_quan_01.png")
    ringBg:center()
    rootLayer:addChild(ringBg)

    local ring = UI.Image:create()
    ring:init("ui_starmarks_quan_02.png")
    ring:center()
    rootLayer:addChild(ring)

    local circleAnime = UI.Animation:create()
    circleAnime:init("effect_ui_town_xingpan_b_di.json", "effect_ui_town_xingpan_b_di.atlas")
    circleAnime:center()
    circleAnime:setAnimation("idle", true)
    rootLayer:addChild(circleAnime)

    
    local iconLayout = UI.Animation:create()
    iconLayout:init("effect_ui_town_xingpa_zuobiao.json", "effect_ui_town_xingpa_zuobiao.atlas")
    iconLayout:center()
    ring:addChild(iconLayout)
    self.iconLayout = iconLayout

    self:initSelectView()
end

function StarPrayPlateSelectLayer:onUpdateView()

end

function StarPrayPlateSelectLayer:initSelectView()
    local config = ConfigManager:getAllStarPlateData()
    local nodeSlotName = "icon"
    for k, v in pairs(config) do
        local starPlateIconNode = self.iconLayout:getNodeForSlot(nodeSlotName..tostring(k), true)
        if starPlateIconNode then

            local starPlateIconAnimation = UI.Animation:create()
            starPlateIconAnimation:init("effect_ui_town_xingpan_b_icon.json", "effect_ui_town_xingpan_b_icon.atlas")
            starPlateIconAnimation:center()
            starPlateIconAnimation._spine:setSkin(v.icon1)
            starPlateIconAnimation:setAnimation("idle", true)
            starPlateIconAnimation:setName(nodeSlotName..tostring(k))
            starPlateIconNode:addChild(starPlateIconAnimation)
            starPlateIconAnimation:setTouchEnable(true)
            starPlateIconAnimation:setSwallowTouches(false)
            starPlateIconAnimation:setClickAudioEnable(true)
            starPlateIconAnimation:addEventListener(UIEvent.COMPONENT_CLICK, self, function(sender, _, _, touchPosition)
                self:onSelectStarPlate(k)
            end)

            -- local starPlateIcon = UI.Image:create()
            -- starPlateIcon:init(v.icon1)
            -- starPlateIcon:center()
            -- starPlateIconNode:addChild(starPlateIcon)
            -- starPlateIcon:setName(nodeSlotName..tostring(k))
            -- starPlateIcon:setTouchEnable(true)  
            -- starPlateIcon:setSwallowTouches(true)
            -- starPlateIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            --     self:onSelectStarPlate(k)
            -- end)

            local curStarPlate = mvc.starPrayModel:getCurStarPlate()
            if curStarPlate == tonumber(v.id) then
                local selectMark = UI.Animation:create()
                selectMark:init("effect_ui_town_xingpan_b_kuang.json", "effect_ui_town_xingpan_b_kuang.atlas")
                selectMark:center()
                selectMark:setAnimation("idle2", true)
                starPlateIconNode:addChild(selectMark)
                self.selectMark = selectMark
            end
        end
    end
end

function StarPrayPlateSelectLayer:onSelectStarPlate(index)
    mvc.send("StarPray_Change_Plate", index)
    if self.selectMark and not tolua.isnull(self.selectMark) then
        self.selectMark:removeFromParent(true)
        self.selectMark = nil
    end
    local nodeSlotName = "icon"
    local starPlateIconNode = self.iconLayout:getNodeForSlot(nodeSlotName..tostring(index), true)
    if starPlateIconNode then
        local selectMark = UI.Animation:create()
        selectMark:init("effect_ui_town_xingpan_b_kuang.json", "effect_ui_town_xingpan_b_kuang.atlas")
        selectMark:center()
        selectMark:setAnimation("trigger", false)
        selectMark:addAnimation("idle2", true)
        starPlateIconNode:addChild(selectMark)
        self.selectMark = selectMark
    end

    self:close()
end

function StarPrayPlateSelectLayer:showPannelAction()
    local posX, posY = self.rootLayer:getPosition()
    self.rootLayer:centerLeft(-900)
    local baseTime = 0.2

    local moveAnimation = cc.MoveTo:create(baseTime, {x = posX, y = posY})
    -- local bounceOut = cc.EaseBounceIn:create(moveAnimation)
    local action = cc.Sequence:create(moveAnimation, cc.CallFunc:create(
        function()
            -- self:setVisible(show)
            -- self.modeBgAnim:addAnimation("idle")
        end)
    )
    self.rootLayer:runAction(action)
end

function StarPrayPlateSelectLayer:closePannelAction()
    local posX, posY = self.rootLayer:getPosition()
    -- self.rootLayer:centerLeft(-900)
    posX = posX-500
    local baseTime = 0.2

    local moveAnimation = cc.MoveTo:create(baseTime, {x = posX, y = posY})
    -- local bounceOut = cc.EaseBounceIn:create(moveAnimation)
    local action = cc.Sequence:create(moveAnimation, cc.CallFunc:create(
        function()
            -- self:setVisible(show)
            -- self.modeBgAnim:addAnimation("idle")
            self:close()
        end)
    )
    self.rootLayer:runAction(action)
end

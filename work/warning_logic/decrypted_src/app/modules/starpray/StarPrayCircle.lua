-- StarPrayCircle.lua
-- Author:ydli
-- 2019年04月25日
-- Using: 星痕插槽公用圆盘，能够预览和拖拽（装配、个人面板、人物详情共用）
--传入 人物数据、槽位背包数据 

UI = UI or {}
local StarPrayCircle = class("StarPrayCircle", UI.Component)
UI.StarPrayCircle = StarPrayCircle
local GameDataManager = require("app.game.GameDataManager")

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(440, 536)
-- 背包资源
local COM_RES_LIST = {
    "ui_town_starpray.plist",
}


function StarPrayCircle:ctor(isFromNPC)
    StarPrayCircle.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)
    self.equipsGrid = {}
    self.isSelf = false
    self.isFromNPC = isFromNPC
    self.lastShowStarRoleLevel = 0
end

function StarPrayCircle:dtor()
    StarPrayCircle.super.dtor(self)
    reload_script_file("app.modules.starpray.StarPrayCircle")
end

function StarPrayCircle:init(heroData, starData,onTouchBeganByGoodsGridHandler, onTouchEndedByGoodsGridHandler, plateConfig)
    -- self:enableDebugDraw()
    self.starData = starData
    self.heroData = heroData
    self.onTouchEndedByGoodsGrid = onTouchEndedByGoodsGridHandler
    self.onTouchBeganByGoodsGrid = onTouchBeganByGoodsGridHandler
    self.plateConfig = plateConfig
    if heroData:getPK() == GameDataManager:getInstance():getMasterPK() then
        self.isSelf = true
        self.lastShowStarRoleLevel = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.ShowStarPrayLockNew..heroData:getPK(), 1) 
    end
    StarPrayCircle.super.init(self)

    if self.isSelf then
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.ShowStarPrayLockNew..heroData:getPK(), heroData:getLevel()) 
    end
end

function StarPrayCircle:onInitView()
	local rootLayer = UI.Layout:create()
	rootLayer:init()
	rootLayer:setSize(layerSize.width, layerSize.height)
	rootLayer:center()
	self:addChild(rootLayer, 10)
	self.rootLayer = rootLayer
    -- rootLayer:enableDebugDraw()
	-- self.rootLayer:rotate(-54)

    local bg = UI.Image:create()
    bg:init("ui_starmarks_bg.png")
    bg:center()
    -- bg:rotate(54)
    rootLayer:addChild(bg)
    bg:setVisible(self.isFromNPC)

    -- ui_starmarks_paper_01.png
    local bgName = self.isFromNPC and "ui_starmarks_runebg_01.png" or "ui_starmarks_paper_01.png"
    local runeBg = UI.Image:create()
    runeBg:init(bgName)
    runeBg:center()
    rootLayer:addChild(runeBg)
    if self.isFromNPC then
        runeBg:rotate(-17)
    end
    self.runeBg = runeBg

    -- local proBG = cc.Sprite:createWithSpriteFrameName("ui_starpray_progressbar_box.png")
    -- proBG:setAnchorPoint(0, 0)
    -- proBG:setPosition(30, 30)
    -- rootLayer:addChild(proBG)

    -- local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_starpray_progressbar.png"))
    -- timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    -- proBG:addChild(timer)
    -- timer:setAnchorPoint(0.5, 0.5)
    -- timer:setPosition(timer:getContentSize().width / 2, timer:getContentSize().height / 2)
    -- self.timer = timer
    
    -- local nameBg = UI.Image:create()
    -- nameBg:init("ui_starpray_playerstate_bar.png")
    -- nameBg:leftBottom(100, 120)
    -- self:addChild(nameBg)

    local gearAnimation = UI.Animation:create()
    gearAnimation:init("effect_ui_town_xingpan_a_di.json", "effect_ui_town_xingpan_a_di.atlas")
    gearAnimation:center()
    gearAnimation:setAnimation("idle1", false)
    gearAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(self)

    end)
    rootLayer:addChild(gearAnimation)
    self.gearAnimation = gearAnimation
    gearAnimation:setVisible(self.isFromNPC)

    self:initStarSlot(self.heroData:getLevel())

    local iconLayout = UI.Layout:create()
	iconLayout:init()
	iconLayout:setSize(90, 90)
	iconLayout:center()
	rootLayer:addChild(iconLayout, 10)
	self.iconLayout = iconLayout
    iconLayout:setTouchEnable(true)
    iconLayout:addEventListener(UI.Event.COMPONENT_CLICK, self, function()
        mvc.send("StarPray_Show_Active_Attr_View")
    end)


    -- skin
    -- local plateIcon = UI.Image:create()
    -- plateIcon:init(self.plateConfig.spine)

    -- plateIcon:center(-1, -3)
    -- iconLayout:addChild(plateIcon)

    local plateIconAnimation = UI.Animation:create()
    plateIconAnimation:init("effect_ui_town_xingpan_a_icon.json", "effect_ui_town_xingpan_a_icon.atlas")
    plateIconAnimation:center(-1, -3)
    -- plateIconAnimation._spine:setSkin(self.plateConfig.skin)
    -- plateIconAnimation:setAnimation(self.plateConfig.animation, true)
    iconLayout:addChild(plateIconAnimation)
    self.plateIconAnimation = plateIconAnimation



    local lvBg = UI.Image:create()
    lvBg:init("ui_starmarks_lvbg.png")
    lvBg:rightBottom(-15, -20)
    iconLayout:addChild(lvBg)
    self.lvBg = lvBg

    local lv = UI.Text:create()
    lv:init("1", UI.FONT_BOLD,UI.FONT_SIZE_18PX,UI.FONT_COLOR_246_220_149)
    lv:center(0, -2)
    lvBg:addChild(lv)
    self.lv = lv

    self:updateLvView()

    if self.isFromNPC then
        self:showAnimation()
    end


    if not self.isFromNPC and self.heroData.starPatternLevel and self.heroData.starPatternLevel > 0 then
        local plateNameBg = UI.Image:create()
        plateNameBg:init('ui_starmarks_label_01.png')
        plateNameBg:centerUp(5,-2)
        runeBg:addChild(plateNameBg)

        local plateName = UI.Text:create()
        local pLevel = self.heroData.starPatternLevel
        plateName:init(UI.TEXT_228205 .. pLevel,UI.FONT_STANDARD,UI.FONT_SIZE_24PX,UI.FONT_COLOR_34_31_31)
        plateName:center(0, -5)
        plateNameBg:addChild(plateName)
    end

end

function StarPrayCircle:updateLvView()

    local usePlate = self.heroData:getUseStarPlate() == 0 and 1 or self.heroData:getUseStarPlate()
    if self.heroData.showCurPlate and self.heroData.showCurPlate ~= usePlate then
        usePlate = self.heroData.showCurPlate
    end
    local activeAttrGrade, _, _ = mvc.starPrayModel:getPlateActiveAttrLevel(self.plateConfig, self.heroData.starPatternLevel,self.starData,usePlate)
    if activeAttrGrade > 0 then
        if self.lv then
            self.lv:setText(activeAttrGrade)
        end

        if self.lvBg then
            self.lvBg:show()
        end

        if self.plateIconAnimation then
            self.plateIconAnimation._spine:setSkin(self.plateConfig.skin)
            self.plateIconAnimation:setToSetupPose()
            self.plateIconAnimation:setAnimation(self.plateConfig.animation, true)
        end
    else
        if self.lvBg then
            self.lvBg:hide()
        end

        if self.plateIconAnimation then
            self.plateIconAnimation._spine:setSkin(self.plateConfig.skin2)
            self.plateIconAnimation:setToSetupPose()
            self.plateIconAnimation:setAnimation("idle_lock", true)
        end
        
    end
end

function StarPrayCircle:onUpdateView()

end

function StarPrayCircle:initStarSlot(level)
    local usePlate = self.heroData:getUseStarPlate() == 0 and 1 or self.heroData:getUseStarPlate()
    self.plateConfig = self.plateConfig or ConfigManager:getStarPlateDataByID(usePlate)
	local unLockLvList = self.plateConfig.slotUnlockLevel--string.split(ConfigManager:getGeneralForKey("StarPrayUnlockLevel"), ";")
    local starNum = #unLockLvList
	local totalUnLockNum = 0
    local isNextLock = nil
    local isEvenNumber = starNum % 2 == 0   --是否是偶数

    if starNum >= 12 then
        local bgName = self.isFromNPC and "ui_starmarks_runebg_02.png" or "ui_starmarks_paper_02.png"
        self.runeBg:setSpriteName(bgName)
    end

    for k, unlockLv in ipairs(unLockLvList) do
        if level < checkint(unlockLv) and isNextLock == nil then
            isNextLock = true
        end
        local node, isUnlock = self:createOneStarSlot(k, level, unlockLv, {}, isNextLock)
        if isNextLock then
            isNextLock = false
        end
        -- node:rotate(54)
        -- 求圆弧上点的坐标
        local offsetAngle = self.isFromNPC and 0 or 1.5
        local holeNum = isEvenNumber and starNum or starNum - 1
        local degree = math.pi * 2 / holeNum * (k - offsetAngle)
        local offset = self.isFromNPC and 162 or 172
        
        if isEvenNumber or k < starNum then
            node:leftBottom(layerSize.width / 2 + offset * math.sin(degree) - node:getContentSize().width / 2, layerSize.height / 2 + offset * math.cos(degree) - node:getContentSize().height / 2)
        else
            node:center(0, 90)
        end
        self.rootLayer:addChild(node, 100)
        if isUnlock then
            totalUnLockNum = totalUnLockNum + 1
        end
    end
    -- self.timer:setPercentage((totalUnLockNum - 1) / #unLockLvList * 100)
end

function StarPrayCircle:setStarData(starData)
    self.starData = starData
    for k, grid in pairs(self.equipsGrid) do
        if self.starData[k] then
            grid:setData(self.starData[k])
            grid:updateView()
            grid:show()

            self:showAnimation(true)
        else
            grid:hide()
            grid:reset()
        end
    end

    self:updateLvView()
end


function StarPrayCircle:createOneStarSlot(index, level, unlockLv, starData, isNextLock)
    -- print("---isNextLock----", isNextLock, level, unlockLv,)
    local isUnlock = false
    if level >= checkint(unlockLv) then
        isUnlock = true
    end
    --bg
    local bg = UI.Image:create()

    local isPlayAction = false
    if self.lastShowStarRoleLevel < checkint(unlockLv) and isUnlock then
        isPlayAction = true
    end
    -- print("---isNextLock----", isNextLock, level, unlockLv,isUnlock)
    --gridebg
    local gridebg = UI.Image:create()
    if isUnlock then
    	bg:init("ui_starmarks_box_01.png")
        gridebg:init(string.format("box_quality_box_0%d.png", (index % 2) + 1))
    else
    	bg:init("ui_starpray_box_quality.png")
        gridebg:init("ui_goods_banner_lock.png")
    end
    gridebg:center()
    bg:addChild(gridebg)

    
    if not isUnlock then
	    --lvbg
	    local lvbg = UI.Image:create()
	    lvbg:init("ui_starpray_grade_box.png")
	    lvbg:center()
	    bg:addChild(lvbg)

	    --lv
	    local lvText = UI.Text:create()
        if isNextLock then
	        lvText:init("lv"..unlockLv, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_102)
        else
            lvText:init("lv.??", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_102)
        end
	    lvText:center()
        lvbg:addChild(lvText)
    else
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init()
        goodsGrid:hide()
        goodsGrid:hideCountLabel()
        goodsGrid:hideNewIcon()
        if self.onTouchBeganByGoodsGrid then
            goodsGrid:setDragOutAreaJudgeNode(goodsGrid)
            goodsGrid:setTouchEnable(true)
            goodsGrid:setDragBeginCallback( self.onTouchBeganByGoodsGrid)
            goodsGrid:setDragEndCallback(self.onTouchEndedByGoodsGrid)
        end
        goodsGrid:showInfoArea();
        goodsGrid:hideAllAnimation()
        goodsGrid:center()
        goodsGrid.index = index
        gridebg:addChild(goodsGrid)
        if self.starData[index] then
            goodsGrid:setData(self.starData[index])
            goodsGrid:show()
        end
        gridebg:setScale(0.8)
        self.equipsGrid[index] = goodsGrid
	end

    --gride
    if self.isSelf then
        if isPlayAction and self.starData[index] == nil then
            local unlockAnimation = UI.Animation:create()
            unlockAnimation:init("effect_ui_package_character_unlock.json", "effect_ui_package_character_unlock.atlas")
            unlockAnimation:center()
            unlockAnimation:setAnimation("unlock", false)
            unlockAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(self)
                unlockAnimation:destroy()
                if not tolua.isnull(self) then
                    self:showRedPoint(bg)
                end
            end)
            bg:addChild(unlockAnimation, 10)
        end
    end

    return bg, isUnlock
end


function StarPrayCircle:showRedPoint(panel)
    local redPoint = panel:getChildByName("REDPOINT")
    if redPoint == nil then
        redPoint = UI.Image:create()
        redPoint:init("ui_information_newitem.png")
        redPoint:setName("REDPOINT")
        redPoint:rightUp(2, 2)
        panel:addChild(redPoint, 20)
    end
end

function StarPrayCircle:showAnimation(isAdd)
    -- self.gearAnimation:setAnimation("idle2", false)
    local unLockLvList = self.plateConfig.slotUnlockLevel
    local holeNum = #unLockLvList
    local starNum = #self.starData
    if not isAdd and starNum > 0 then
        self.gearAnimation:setAnimation("idle2", true)
    end 

    if isAdd then
        if starNum < holeNum then
            self.gearAnimation:setAnimation("trigger1", false)
            self.gearAnimation:addAnimation("idle2", true)
        else
            self.gearAnimation:setAnimation("trigger2", false)
            self.gearAnimation:addAnimation("idle2", true)
        end
    end
end



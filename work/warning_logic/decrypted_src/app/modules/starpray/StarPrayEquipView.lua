------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/24
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require 'app.game.LanguageManager'
local languageManagerInstance = LanguageManager:getInstance()
local StarPrayEquipView = class('StarPrayEquipView', UI.HWBtnComponent)
local LayoutUtil = require 'app.ui.UILayoutUtils'
local StarPrayBagLayer = require('app.modules.starpray.StarPrayBagLayer')
local GameDataManager = require('app.game.GameDataManager')
require('app.modules.starpray.StarPrayCircle')
require('app.modules.starpray.StarPrayPlateSelectLayer')
require('app.modules.starpray.StarPrayPlateAttrLayer')
require('app.modules.starpray.StarPrayAddPlateAttrLayer')

-- 资源
local COM_RES_LIST = {}

-- local COM_WIDTH = 852
local COM_WIDTH = 914
local COM_HEIGHT = 534
local layoutUU
function StarPrayEquipView:ctor()
    StarPrayEquipView.super.ctor(self, UI.Type.STAR_PRAY_EQUIP_VIEW, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
    self:center(-45, 30)

    layoutUU = UIUtil:createAutoUILayout("StarPrayEquipView","app.modules.starpray.StarPrayPosConfig", false)
end

function StarPrayEquipView:dtor()
    StarPrayEquipView.super.dtor(self)
    -- reload_script_file("app.modules.starpray.StarPrayEquipView")

    local heroData = GameDataManager:getInstance():getMaster()
    local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
    mvc.starPrayModel:selectStarPlate(usePlate)

    self:unbindModel()
    reload_script_file("app.modules.starpray.StarPrayEquipView")
end

-- 注册监听事件(可选)
function StarPrayEquipView:bindModel()
end
-- 注册监听事件(可选)
function StarPrayEquipView:unbindModel()
end

function StarPrayEquipView:isPositionInBag(touchPosition)
    local target = self.circleLayer
    local pos = target:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(pos.x - 10, pos.y - 10, target._width + 20, target._height + 20)
    local isInBag = cc.rectContainsPoint(rect, touchPosition)
    return isInBag
end

local lastClock = 0
function StarPrayEquipView:onOneKeyEquip()
    local curClock = os.clock()
    if curClock - lastClock < 0.3 then
        return
    end
    lastClock = curClock
    mvc.send('StarPray_Equip_DoOneKey')
end

function StarPrayEquipView:onTouchBeganByGoodsGrid(grid, touchPosition)
    if grid:getData() then
        return true
    end
    return false
end

function StarPrayEquipView:onTouchEndedByGoodsGrid(grid, inSide, touchPosition)
    mvc.send('StarPray_Equip_DoEquip', grid, inSide, touchPosition)
end

function StarPrayEquipView:onInitView()
    -- local spr = cc.Sprite:create("xxxx.png")
    -- spr:setOpacity(150)
    -- addChildAuto(layoutUU,self, spr, "spr")
    local heroData = GameDataManager:getInstance():getMaster()
    local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
    local config = ConfigManager:getStarPlateDataByID(usePlate)

    local plateNameBg = UI.Image:create()
    plateNameBg:init('ui_starmarks_label_01.png')
    plateNameBg:leftUp(110, 10)
    self:addChild(plateNameBg, 99)

    local plateName = UI.Text:create()
    plateName:init(languageManagerInstance:getLocalString(config.name),UI.FONT_STANDARD,UI.FONT_SIZE_24PX,UI.FONT_COLOR_34_31_31)
    plateName:center(0, -5)
    plateNameBg:addChild(plateName,101)
    self.plateName = plateName

    local gridImageBg = UI.Image:create()
    gridImageBg:init('ui_starpray_bg.png')
    addChildAuto(layoutUU, self, gridImageBg, 'gridImageBg')

    local iconAnimation = UI.Animation:create()
    iconAnimation:init("effect_ui_town_starpray_tunshi_book.json", "effect_ui_town_starpray_tunshi_book.atlas", 1)
    iconAnimation:setAnimation("idle", true)
    iconAnimation:setSize(50, 50)
    addChildAuto(layoutUU, self, iconAnimation, "BgAnimation1", "center",900210)

    heroData.starPatternLevel = mvc.starPrayModel.level
    local layer = UI.StarPrayCircle:create(true)
    layer:init(
        heroData,
        mvc.starPrayModel:getStarPrayEqiupDataWithIndexOrder(),
        handler(self, self.onTouchBeganByGoodsGrid),
        handler(self, self.onTouchEndedByGoodsGrid),
        config
    )
    addChildAuto(layoutUU, self, layer, 'circleLayer')
    self.circleLayer = layer

    local changeButton = UI.Button:create()
    changeButton:init('ui_starmarks_btn_switch.png', 'ui_starmarks_btn_switch.png', 'ui_starmarks_btn_switch.png')
    changeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:showStarPlateSelect()
    end)
    changeButton:leftUp(-10, 0)
    self:addChild(changeButton, 99)

    local detailButton = UI.Button:create()
    detailButton:init('ui_starmarks_btn_attributes.png', 'ui_starmarks_btn_attributes.png', 'ui_starmarks_btn_attributes.png')
    detailButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- self:showStarPlateAttr()
        self:showStarPlateAddAttr()
    end)
    detailButton:leftUp(-10, 80)
    self:addChild(detailButton, 99)

    local executeButton = UI.Button:create()
    executeButton:init('ui_starmarks_btn_01.png', 'ui_starmarks_btn_01.png', 'ui_starmarks_btn_01.png')
    -- addChildAuto(layoutUU, self, executeButton, 'onkeyEquipBtn')
    executeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    executeButton:setText(UI.TEXT_1212454)
    executeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onOneKeyEquip)
    executeButton:leftBottom(220, 3)
    self:addChild(executeButton, 99)
    -- self:enableDebugDraw()

    local activeButton = UI.Button:create()
    activeButton:init('ui_starmarks_btn_02.png', 'ui_starmarks_btn_02.png', 'ui_starmarks_btn_03.png')
    activeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    activeButton:setText(UI.TEXT_1213614)
    activeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onPlateActive)
    activeButton:leftBottom(40, 3)
    self:addChild(activeButton, 99)
    self.activeButton = activeButton

    -- self:initStarPlateSelect(config)

    self:updateStarPlateView()
end

function StarPrayEquipView:onPlateActive()
    local spID = mvc.starPrayModel:getCurStarPlate()
    local isUnlock = mvc.starPrayModel:checkStarPlateIsUnlock(spID)
    
    if isUnlock then
        local heroData = GameDataManager:getInstance():getMaster()
        local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
        if usePlate == spID then
            
        else
            Net.NetRoleSystem:reqChangeStarPlate(spID)
        end
    else
        local config = ConfigManager:getStarPlateDataByID(spID)
        -- 1 道具解锁 在starPlateUnlockNum中填解锁道具id
        -- 2 水晶解锁 在starPlateUnlockNum中填水晶数量
        -- 3 等级解锁 在starPlateUnlockNum中填解锁等级
        -- 4 进度解锁 
        if config.starPlateUnlockType == 2 then
            local buyFacaTips = UI.Tips:createTips(string.format(UI.TEXT_227708, config.starPlateUnlockNum),UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
            buyFacaTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                local curDiamond = RoleDataManager:getMaster():getDiamond()
                if (Avalon.MathUtil:checkDiamonEnough(tonumber(config.starPlateUnlockNum), curDiamond)) then
                    Net.NetRoleSystem:reqUnlockStarPlate(spID)
                else
                    UI.TipsLayer:onDiamondNotEnough()
                end
            end) 
        end
        
    end
end

function StarPrayEquipView:updateStarPlateView()
    self.activeButton:enable()
    local spID = mvc.starPrayModel:getCurStarPlate()
    local isUnlock = mvc.starPrayModel:checkStarPlateIsUnlock(spID)
    if isUnlock then
        local heroData = GameDataManager:getInstance():getMaster()
        local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
        if usePlate == spID then
            self.activeButton:setText(UI.TEXT_227703)
            self.activeButton:disable()
        else
            
            self.activeButton:setText(UI.TEXT_1213614)
        end
    else
        local config = ConfigManager:getStarPlateDataByID(spID)
        if config.starPlateUnlockType == 1 then
            self.activeButton:setText(UI.TEXT_227704)
        elseif config.starPlateUnlockType == 2 then
            self.activeButton:setText(UI.TEXT_227707)
        elseif config.starPlateUnlockType == 3 then
            local level, reinLv = RoleDataManager:getUIShowLvByItemData(tonumber(config.starPlateUnlockNum))
            local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
            self.activeButton:setText(string.format(UI.TEXT_227705, showLv))
        elseif config.starPlateUnlockType == 4 then
            self.activeButton:setText(UI.TEXT_227706)
        end
    end
end
 

function StarPrayEquipView:onChangeStarPlate(heroData, config)
    if self.circleLayer and not tolua.isnull(self.circleLayer) then
        self.circleLayer:removeFromParent()
        self.circleLayer = nil
    end
    -- local heroData = GameDataManager:getInstance():getMaster()
    -- local usePlate = heroData:getUseStarPlate() == 0 and 1 or heroData:getUseStarPlate()
    -- local config = ConfigManager:getStarPlateDataByID(usePlate)
    heroData.starPatternLevel = mvc.starPrayModel.level
    heroData.showCurPlate = mvc.starPrayModel:getCurStarPlate()
    local layer = UI.StarPrayCircle:create(true)
    layer:init(
        heroData,
        mvc.starPrayModel:getStarPrayEqiupDataWithIndexOrder(),
        handler(self, self.onTouchBeganByGoodsGrid),
        handler(self, self.onTouchEndedByGoodsGrid),
        config
    )
    layer:leftBottom(0, 0)
    -- addChildAuto(layoutUU, self, layer, 'circleLayer', nil, 1)
    addChildAuto(layoutUU, self, layer, 'circleLayer')
    -- self:addChild(layer, 1)
    self.circleLayer = layer

    self.plateName:setText(languageManagerInstance:getLocalString(config.name))
    self:updateStarPlateView()
end

function StarPrayEquipView:showStarPlateSelect()    
    -- if self.starPlateSelectLayer and not tolua.isnull(self.starPlateSelectLayer) then
    --     self:initStarPlateSelect(config)
    -- else
    --     self.starPlateSelectLayer:showLayer()
    -- end
    local curPlate = mvc.starPrayModel:getCurStarPlate()
    local config = ConfigManager:getStarPlateDataByID(curPlate)
    self:initStarPlateSelect(config)
end

function StarPrayEquipView:initStarPlateSelect(config)
    if self.starPlateSelectLayer and not tolua.isnull(self.starPlateSelectLayer) then
        self.starPlateSelectLayer:removeFromParent()
        self.starPlateSelectLayer = nil
    end
    local layer = UI.StarPrayPlateSelectLayer:create()
    layer:init(
        heroData,
        mvc.starPrayModel:getStarPrayEqiupDataWithIndexOrder(),
        config
    )
    layer:centerLeft(-470)
    self:addChild(layer, 999)
    layer:showPannelAction()
    self.starPlateSelectLayer = layer
end

function StarPrayEquipView:showStarPlateAttr()    
    -- if self.starPlateSelectLayer and not tolua.isnull(self.starPlateSelectLayer) then
    --     self:initStarPlateSelect(config)
    -- else
    --     self.starPlateSelectLayer:showLayer()
    -- end
    local curPlate = mvc.starPrayModel:getCurStarPlate()
    local config = ConfigManager:getStarPlateDataByID(curPlate)
    if table.nums(config.buffDes) == 0 then
        return
    end

    self:initStarPlateAttr(config)
end

function StarPrayEquipView:initStarPlateAttr(config)
    if self.starPlateAttrLayer and not tolua.isnull(self.starPlateAttrLayer) then
        self.starPlateAttrLayer:removeFromParent()
        self.starPlateAttrLayer = nil
    end
    local layer = UI.StarPrayPlateAttrLayer:create()
    layer:init(config, mvc.starPrayModel:getStarPrayEqiupDataWithIndexOrder())
    layer:center()
    self:addChild(layer, 999)
    self.starPlateAttrLayer = layer
end

function StarPrayEquipView:showStarPlateAddAttr()    
    self:initStarPlateAddAttr()
end

function StarPrayEquipView:initStarPlateAddAttr(config)
    if self.starPlateAttrLayer and not tolua.isnull(self.starPlateAttrLayer) then
        self.starPlateAttrLayer:removeFromParent()
        self.starPlateAttrLayer = nil
    end
    local layer = UI.StarPrayAddPlateAttrLayer:create()
    layer:init()
    layer:center(270, 0)
    self:addChild(layer, 999)
    self.starPlateAttrLayer = layer
end

function StarPrayEquipView:onUpdateContentView()
    self.circleLayer:setStarData(mvc.starPrayModel:getStarPrayEqiupDataWithIndexOrder())
end

return StarPrayEquipView

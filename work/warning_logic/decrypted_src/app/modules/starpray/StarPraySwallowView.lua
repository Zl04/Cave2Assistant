------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/04/24
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local StarPraySwallowView = class("StarPraySwallowView", UI.HWBtnComponent)
local StarPrayBagLayer = require("app.modules.starpray.StarPrayBagLayer")
local LayoutUtil = require "app.ui.UILayoutUtils"

-- 资源
local COM_RES_LIST = {
    -- "ui_town_starpray.plist",

}

local COM_WIDTH = 914
local COM_HEIGHT = 534

local GRID_SIZE_WIDTH = 74
local GRID_SIZE_HEIGHT = 74
local layoutUU
function StarPraySwallowView:ctor()
    StarPraySwallowView.super.ctor(self, UI.Type.STAR_PRAY_SWALLOW_VIEW, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
    self:center(-45, 30)

    layoutUU = UIUtil:createAutoUILayout("StarPrayEquipView", "app.modules.starpray.StarPrayPosConfig", false)

    mvc.starPrayModel:clearSwallowBag()
end

function StarPraySwallowView:show()
    StarPraySwallowView.super.show(self)

    self.mTargetGoodsGrid:reset()
    self.mTargetGoodsGrid:updateView()
end

function StarPraySwallowView:dtor()
    StarPraySwallowView.super.dtor(self)
    self:unbindModel()

    reload_script_file("app.modules.starpray.StarPraySwallowView")
end

function StarPraySwallowView:swallowBagDragBeganCallback(grid, touchPosition)
    if (grid) then
        grid:hideSelect()
    end
end

function StarPraySwallowView:bagDragMovedCallback(grid, touchPosition)
end

function StarPraySwallowView:updateSwallowBag()
    if self._swallowGridList then
        self._swallowGridList:showAllGoods()
    end
end

function StarPraySwallowView:isPositionInSwallowBag(target, touchPosition)
    local pos = target:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(pos.x, pos.y, target._width, target._height)
    local isInBag = cc.rectContainsPoint(rect, touchPosition)
    return isInBag
end

function StarPraySwallowView:swallowBagDragEndedCallback(grid, touchPosition)
    mvc.send("StarPray_Swllow_Bag_Touch", "End", grid, touchPosition)
end

function StarPraySwallowView:onInitView()
    local swallowAnimation = UI.Animation:create()
    swallowAnimation:init("effect_ui_town_starpray_tunshi.json", "effect_ui_town_starpray_tunshi.atlas", 1)
    swallowAnimation:setAnimation("begin", true)
    addChildAuto(layoutUU, self, swallowAnimation, "swallowAnimation")
    swallowAnimation:setSize(100, 50)
    self.swallowAnimation = swallowAnimation

    local bagData = mvc.starPrayModel:getStarPraySwallowData()
    local bagView =
        StarPrayBagLayer:create(
        bagData,
        self,
        self.swallowBagDragBeganCallback,
        self.bagDragMovedCallback,
        self.swallowBagDragEndedCallback,
        160
    )
    bagView:init()
    addChildAuto(layoutUU, self, bagView, "swallowView")
    self._swallowGridList = bagView._bagGridList
    -- 进度条背景
    local proBG = cc.Sprite:createWithSpriteFrameName("ui_information_banner_countdown_box.png")
    proBG:setPosition(162, 20)
    addChildAuto(layoutUU, self, proBG, "proBG")

    self._pro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_information_banner_countdown.png"))
    self._pro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self._pro:setMidpoint(cc.p(0, 0))
    self._pro:setBarChangeRate(cc.p(1, 0))
    self._pro:setPosition(cc.p(proBG:getContentSize().width / 2, proBG:getContentSize().height / 2))
    proBG:addChild(self._pro, 20)

    local addExpText = UI.Text:create()
    addExpText:init("+0", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_36_181_118)
    addChildAuto(layoutUU, self, addExpText, "addExpText", "leftBottom")
    addExpText:setOutline(UI.FONT_COLOR_BLACK)
    self.addExpText = addExpText

    local text = UI.Text:create()
    text:init("0/0", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    addChildAuto(layoutUU, self, text, "expmaxExpText", "leftBottom")
    self.curExpText = text

    local iconAnimation = UI.Animation:create()
    iconAnimation:init("effect_ui_town_starpray_tunshi_book.json", "effect_ui_town_starpray_tunshi_book.atlas", 1)
    iconAnimation:setAnimation("idle", true)
    iconAnimation:setSize(50, 50)
    addChildAuto(layoutUU, self, iconAnimation, "BgAnimation1", "center",900210)


    local yellowButton = UI.Button:create()
    yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    yellowButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    yellowButton:setText(UI.TEXT_1212452)
    addChildAuto(layoutUU, self, yellowButton, "swallowBtn", "leftBottom")
    yellowButton:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function()
            mvc.send("StarPray_Swllow_DoSwllow")
        end
    )

    local yellowButton = UI.Button:create()
    yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    yellowButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    yellowButton:setText(UI.TEXT_1212453)
    addChildAuto(layoutUU, self, yellowButton, "swallowOneKeyBtn", "leftBottom")
    yellowButton:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function()
            mvc.send(mvc.events.StarPray_Swllow_DoOneKey)
        end
    )

    local gridImage = UI.Image:create()
    gridImage:init("ui_starpray_banner_mask_2.png")
    addChildAuto(layoutUU, self, gridImage, "gridImage_1")

    self:createTargetItem()

    local btn = UI.Button:create()
    btn:init("ui_btn_starpray_0.png", "ui_btn_starpray_1.png", "ui_btn_starpray_2.png")
    addChildAuto(layoutUU, self, btn, "swallowSetting", "leftBottom")
    btn:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function()
            mvc.send(mvc.events.StarPray_Swllow_SHOW_SETTING)
        end
    )
end

function StarPraySwallowView:onTouchBeganByGoodsGrid(grid, touchPosition)
    self.iconAnimation:setAnimation("putin3", false)
    self.swallowAnimation:setAnimation("putin3", false)

    self.iconAnimation:addAnimation("ready2", true)
    self.swallowAnimation:addAnimation("ready2", true)
    return true
end

function StarPraySwallowView:onTouchEndedByGoodsGrid(grid, inSide)
    if (tolua.isnull(self) or tolua.isnull(grid)) then
        return
    end
    mvc.send("StarPray_Swllow_Target_Touch", "End", grid, inSide)
end

function StarPraySwallowView:updateAddExp()
    local swallowExp = mvc.starPrayModel:getTotalSwallowExp()
    self.addExpText:setText("+" .. swallowExp)
end

function StarPraySwallowView:updateExpPsg()
    local exp, maxExp = 0, 0
    if self.mGoodsData then
        exp, maxExp = self.mGoodsData:getExp()
        self._pro:setPercentage(exp / maxExp * 100)
        if exp == maxExp and exp == 0 then
            self.curExpText:setText("LvMax")
            return
        end
    else
        self._pro:setPercentage(0)
    end
    self.curExpText:setText(exp .. "/" .. maxExp)
end

function StarPraySwallowView:createTargetItem()
    -- 物品图标背景底框
    local spriteBg1 = UI.Image:create()
    spriteBg1:init("box_quality_box_01.png")
    spriteBg1:setSize(GRID_SIZE_WIDTH, GRID_SIZE_HEIGHT)
    addChildAuto(layoutUU, self, spriteBg1, "targetGrid")

    --强化材料框
    self.mTargetGoodsGrid = UI.GoodsGrid:create()
    self.mTargetGoodsGrid:init()
    self.mTargetGoodsGrid:hide()
    self.mTargetGoodsGrid:hideCountLabel()
    self.mTargetGoodsGrid:hideNewIcon()
    self.mTargetGoodsGrid:setTouchEnable(true)
    self.mTargetGoodsGrid:setDragOutAreaJudgeNode(self.mTargetGoodsGrid)
    self.mTargetGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mTargetGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mTargetGoodsGrid:showInfoArea()
    self.mTargetGoodsGrid:hideAllAnimation()

    addChildAuto(layoutUU, spriteBg1, self.mTargetGoodsGrid, "iconAnimation", "center")
    self.mTargetGoodsGrid:setAvailable(true)

    local iconAnimation = UI.Animation:create()
    iconAnimation:init("effect_ui_town_starpray_tunshi_icon.json", "effect_ui_town_starpray_tunshi_icon.atlas", 1)
    iconAnimation:setAnimation("begin", true)
    addChildAuto(layoutUU, spriteBg1, iconAnimation, "iconAnimation", "center")
    iconAnimation:setSize(100, 50)
    iconAnimation:setLocalZOrder(1000)
    self.iconAnimation = iconAnimation
end

function StarPraySwallowView:updateTaregetGoodsData(goodsData)
    if goodsData then
        self.mTargetGoodsGrid:setData(goodsData)
        goodsData._changeNum = -1
        if self.mGoodsData then
            self.mGoodsData._changeNum = 0
        end

        self.mTargetGoodsGrid:updateView()
        self.mTargetGoodsGrid:show()
    else
        self.mGoodsData._changeNum = 0
        self.mTargetGoodsGrid:reset()
        self.mTargetGoodsGrid:hide()
    end
    self.mGoodsData = goodsData
    self:updateExpPsg()
end

function StarPraySwallowView:getTaregetGoodsData()
    return self.mGoodsData
end
function StarPraySwallowView:isInTargetArea(touchPosition)
    local t = self.mTargetGoodsGrid:convertToWorldSpace(cc.p(0, 0))
    local targetSize = self.mTargetGoodsGrid:getContentSize()
    local _rect = cc.rect(t.x - 30, t.y - 30, targetSize.width + 60, targetSize.height + 60)
    return cc.rectContainsPoint(_rect, touchPosition)
end

function StarPraySwallowView:showAnimationPutInCancel()
    self.iconAnimation:setAnimation("ready3", false)
    self.swallowAnimation:setAnimation("ready3", false)
end

function StarPraySwallowView:showAnimationPutIn()
    self.iconAnimation:setAnimation("putin1", false)
    self.swallowAnimation:setAnimation("putin1", false)
    self.iconAnimation:addAnimation("putin2", true)
    self.swallowAnimation:addAnimation("putin2", true)
end

function StarPraySwallowView:showAnimationPutInBegin()
    self.iconAnimation:setAnimation("ready1", false)
    self.iconAnimation:addAnimation("ready2", true)
    self.swallowAnimation:setAnimation("ready1", false)
    self.swallowAnimation:addAnimation("ready2", true)
end

function StarPraySwallowView:onUpdateContentView(isSucc)
    if not isSucc then
        return
    end

    self.swallowAnimation:setAnimation("trigger", false)
    self.iconAnimation:setAnimation("trigger", false)
    Avalon.AudioManager:playSound("1552", false)
    self.mTargetGoodsGrid:refreshGemLevel()
end

-- 注册监听事件(可选)
function StarPraySwallowView:bindModel()
    mvc.starPrayModel:bind("swallowBagData", self, self.updateSwallowBag)
end

-- 注销监听事件(可选)
function StarPraySwallowView:unbindModel()
    mvc.starPrayModel:unbind("swallowBagData", self, self.updateSwallowBag)
end

return StarPraySwallowView

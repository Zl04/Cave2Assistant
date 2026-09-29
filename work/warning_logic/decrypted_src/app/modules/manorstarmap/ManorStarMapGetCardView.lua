------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapGetCardView = class("ManorStarMapGetCardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function ManorStarMapGetCardView:ctor(cardId)
    ManorStarMapGetCardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._cardId = cardId
end

function ManorStarMapGetCardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapGetCardView.super.init(self, ... )
end

function ManorStarMapGetCardView:dtor()
    ManorStarMapGetCardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapGetCardView")
end


function ManorStarMapGetCardView:onInitView()

    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 220))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)


    local startSp = UI.Animation:create()
    startSp:init("effect_ui_starmap_unboxing.json", "effect_ui_starmap_unboxing.atlas", 1);
    startSp:center()
    startSp:setAnimation("begin", false)
    self:addChild(startSp)

    startSp:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event, target)
        target:runAction(
            cc.RemoveSelf:create()
        )

        self:refreshGetCardView()
    end)

end

function ManorStarMapGetCardView:refreshGetCardView()

    local cardData = clone(mvc.manorStarMapModel:getCardDataByCardId(self._cardId))

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_starmap_opencard_bg.png")
    bg:center()
    self:addChild(bg)
    self._bg = bg


    local titleLightSp = UI.Animation:create()
    titleLightSp:init("effect_ui_starmap_show_guang.json", "effect_ui_starmap_show_guang.atlas", 1);
    titleLightSp:centerUp(0)
    titleLightSp:setAnimation("begin", false)
    titleLightSp:addAnimation("idle", true)
    bg:addChild(titleLightSp,-2)
    
    local titleBgSp = UI.Animation:create()
    titleBgSp:init("effect_ui_starmap_show_reward.json", "effect_ui_starmap_show_reward.atlas", 1);
    titleBgSp:centerUp(-15,-10)
    titleBgSp:setAnimation("idle", true)
    bg:addChild(titleBgSp,-1)


    local flagImg = UI.Image:create()
    flagImg:init("ui_starmap_opencard_flag.png")
    flagImg:centerUp(-17)
    bg:addChild(flagImg,10)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222638, UI.FONT_BOLD, UI.FONT_SIZE_26PX, {r = 255, g = 220, b = 111})
    titleText:enableShadow({r = 0, g = 0, b = 0},cc.size(1,-2))
    titleText:centerUp(2,0)
    flagImg:addChild(titleText)


    local cardView = mvc.manorStarMapCardCellView:create(cardData)
    cardView:init()
    cardView:center(0,10)
    cardView:hideName()
    bg:addChild(cardView,10)

    local nameImg = UI.Image:create()
    nameImg:init("ui_starmap_opencard_bg2.png")
    nameImg:centerUp(48)
    bg:addChild(nameImg,10)

    local nameText = UI.Text:create()
    nameText:init(cardView._cardName, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 244, g = 198, b = 130})
    nameText:center()
    nameImg:addChild(nameText)


    local cardLightSp = UI.Animation:create()
    cardLightSp:init("effect_ui_starmap_show_card.json", "effect_ui_starmap_show_card.atlas", 1);
    cardLightSp:center(0,10)    
    bg:addChild(cardLightSp)

    if cardView._cardType == 1 then
        cardLightSp:setAnimation("idle1", true)
    else
        cardLightSp:setAnimation("idle2", true)
    end

    local closeBtn = UI.Button:create()
    closeBtn:init('ui_starmap_btn_3.png', 'ui_starmap_btn_3.png', 'ui_starmap_btn_3.png')
    closeBtn:centerBottom(-80, 0)
    closeBtn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=40,g=40,b=42})
    closeBtn:setText(UI.TEXT_1170211)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("ManorStarMap", "ManorStarMapGetCard")
    end)
    bg:addChild(closeBtn)

end


function ManorStarMapGetCardView:bindModel()

end


function ManorStarMapGetCardView:unbindModel()

end





return ManorStarMapGetCardView













------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/27
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapCardCellView = class("ManorStarMapCardCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local COM_WIDTH = 96
local COM_HEIGHT = 124

function ManorStarMapCardCellView:ctor(cardData, dontShowPage)
    ManorStarMapCardCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._cardData = cardData
    self._dontShowPage = dontShowPage --不显示装备在第几页
    self._cardName = ""
    self._cardType = 1
    self._levelText = nil
    self._icon = nil
end

function ManorStarMapCardCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapCardCellView.super.init(self, ... )
end

function ManorStarMapCardCellView:dtor()
    ManorStarMapCardCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapCardCellView")
end


function ManorStarMapCardCellView:onInitView()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local cardConfig = ConfigManager:getAllStarCardDataByID(self._cardData.cardId)
    self._cardType = cardConfig.type

    local bgStr = cardConfig.cardFrame
    if bgStr == "" then
        bgStr = "ui_starmap_cards_bg.png"
    end

    self._bg = UI.Image:create()
    self._bg:init(bgStr)
    self._bg:center()
    self.contentLayout:addChild(self._bg)

    local icon = UI.Image:create()
    icon:init(cardConfig.icon)
    icon:center()
    self._bg:addChild(icon)
    self._icon = icon

    local levelText = UI.Text:create()
    levelText:init(tostring(self._cardData.level), UI.FONT_BOLD, UI.FONT_SIZE_14PX, {r = 172, g = 166, b = 159})
    levelText:centerUp(1,-33)
    contentLayout:addChild(levelText)
    self._levelText = levelText

    -- self._cardData.cardPage = 3
    if self._cardData.cardPage and self._cardData.cardPage > 0 and not self._dontShowPage then

        local pageBg = UI.Image:create()
        pageBg:init("ui_starmap_subscript.png")
        pageBg:rightUp(0,0)
        contentLayout:addChild(pageBg)

        local pageImg = UI.Image:create()
        pageImg:init(string.format("ui_starmap_label_number_%02d.png", self._cardData.cardPage + 10))
        pageImg:rightUp(2,2)
        contentLayout:addChild(pageImg)
    end

    self._namebg = UI.Image:create()
    self._namebg:init("ui_starmap_banner_bg_7.png")
    self._namebg:centerBottom(0,0)
    contentLayout:addChild(self._namebg)

    self._cardName = languageManagerInstance:getLocalString(cardConfig.name)
    local nameText = UI.Text:create()
    nameText:init(self._cardName, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 172, g = 166, b = 159})
    nameText:center()
    self._namebg:addChild(nameText)

end

function ManorStarMapCardCellView:hideName()
    self._namebg:hide()
end

function ManorStarMapCardCellView:hideLevelText()
    self._levelText:hide()
end

function ManorStarMapCardCellView:useAllShader(shaderData)
    if self._bg then
        self._bg:useShader(shaderData)
    end
    if self._icon then
        self._icon:useShader(shaderData)
    end
end

function ManorStarMapCardCellView:bindModel()

end


function ManorStarMapCardCellView:unbindModel()

end





return ManorStarMapCardCellView













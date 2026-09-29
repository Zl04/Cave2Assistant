------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/22
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorAppearanceInfoCellView = class("ManorAppearanceInfoCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 385
local COM_HEIGHT = 488

function ManorAppearanceInfoCellView:ctor(data)
    ManorAppearanceInfoCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function ManorAppearanceInfoCellView:init(data, ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorappearance", "ManorAppearance", false)
    ManorAppearanceInfoCellView.super.init(self, ... )
end

function ManorAppearanceInfoCellView:dtor()
    ManorAppearanceInfoCellView.super.dtor(self)
    self:unbindModel()
    self.data = nil
    reload_script_file_mvc("app.modules.manorappearance.ManorAppearanceInfoCellView")
end


function ManorAppearanceInfoCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout, 5)
    self.contentLayout = contentLayout

    -- 解锁条件面板
    local unlockLayout = UI.Layout:create()
    unlockLayout:init()
    unlockLayout:setSize(335, 70)
    unlockLayout:centerBottom(0)
    contentLayout:addChild(unlockLayout, 5)
    self.unlockLayout = unlockLayout

    -- 效果描述面板
    local effectLayout = UI.Layout:create()
    effectLayout:init()
    effectLayout:setSize(345, 70)
    effectLayout:centerBottom(135)
    contentLayout:addChild(effectLayout, 5)
    self.effectLayout = effectLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local bg = UI.Image.create()
    bg:init("ui_navigation_popups_2.png")
    bg:center()
    contentLayout:addChild(bg)

    local frame = UI.Image.create()
    frame:init("ui_navigation_floorbg_2.png")
    frame:centerUp(65)
    contentLayout:addChild(frame, 10)

    local decorate = UI.Image.create()
    decorate:init("ui_navigation_floorbg_up.png")
    decorate:rightBottom(12, 10)
    frame:addChild(decorate)
    self.frame = frame

    local image = UI.Image.create()
    image:init("")
    image:rightBottom(-7, 10)
    frame:addChild(image)
    self.image = image

    local name = UI.Text:create()
    name:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_204_204_204)
    name:centerUp(20)
    contentLayout:addChild(name)
    self.name = name

    self:updateCellInfo()
end

function ManorAppearanceInfoCellView:updateCellInfo()
    local skinConfig = ConfigManager:getVirtualItemConfigByID(tonumber(self.data.ID))
    local iconList = string.split(self.data.icon, ";") 
    self.image:setSpriteName(iconList[2])
    self.name:setText(skinConfig.name)

    local unlockDesList = string.split(self.data.unlockDesc, ",")
    for k ,v in pairs(unlockDesList) do
        local unlockDesStr = string.format(UI.TEXT_222714, languageManagerInstance:getLocalString(tonumber(v))) 
        local unlockDes = UI.Text:create()
        unlockDes:init(unlockDesStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        unlockDes:setSize(250, 25)
        unlockDes:setTextLeft()
        unlockDes:center(20, 35*(k-1)-30)
        unlockDes:setFixLineWidth(265)
        self.unlockLayout:addChild(unlockDes)
    end

    local effectDesList = string.split(self.data.effectDesc, ",")
    for k ,v in pairs(effectDesList) do
        local image = UI.Image.create()
        image:init("ui_navigation_square.png")
        image:center(-130, 25*(k-1)-20)
        self.effectLayout:addChild(image)

        local effectDesStr = string.format(UI.TEXT_222713, languageManagerInstance:getLocalString(tonumber(v))) 
        local effectDes = UI.Text:create()
        effectDes:init(effectDesStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        -- effectDes:setSize(250, 25)
        effectDes:setWidth(300)
        effectDes:setTextLeft()
        local height = effectDes:getContentSize().height
        effectDes:center(35, height*(k-1)-20)
        self.effectLayout:addChild(effectDes)
    end

    local animeName = self.data.spine
    if animeName and animeName ~="" then
        local previewAnime = UI.Animation:create()
        previewAnime:init(animeName..".json", animeName..".atlas", 1);
        previewAnime:center(-100, 60)
        self.frame:addChild(previewAnime, 101)
        previewAnime:setAnimation("idle3", true)
        previewAnime:setScale(0.7)
    end
end

function ManorAppearanceInfoCellView:bindModel()

end


function ManorAppearanceInfoCellView:unbindModel()

end





return ManorAppearanceInfoCellView
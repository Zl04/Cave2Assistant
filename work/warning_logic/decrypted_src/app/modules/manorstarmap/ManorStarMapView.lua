------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/27
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapView = class("ManorStarMapView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local COM_WIDTH = 1006
local COM_HEIGHT = 583

local StarMapPageType = {
    Star_Invalid = 0,       -- 无效的
    Star_Map = 1,           -- 星图
    Stars_Card = 2,         -- 星辰卡片
    Stars_Pokedex = 3,      -- 星辰图鉴
    Stars_Max = 4           -- 最大值
}

local StarMapMosaicType = PublicDefine.StarMapMosaicType

local winSize = cc.Director:getInstance():getWinSize()

function ManorStarMapView:ctor()
    ManorStarMapView.super.ctor(
    	self,
    	UI.Type.STAR_MAP_CARD,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._pageType = StarMapPageType.Star_Invalid
    self._pageTable = {}

    self._mosaicType = StarMapMosaicType.MosaicFight
    self._mosaicTable = {}
end

function ManorStarMapView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapView.super.init(self, ... )
    
end

function ManorStarMapView:dtor()
    ManorStarMapView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapView")
end


function ManorStarMapView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_starmap_book.png")
    bg:center()
    self:addChild(bg)
    self._bg = bg

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout


    self:updatePageView(StarMapPageType.Star_Map)

    self._pageTable = {}

    local StarMapPageName = {
        [StarMapPageType.Star_Map] = UI.TEXT_222600,
        [StarMapPageType.Stars_Card] = UI.TEXT_222601,
        [StarMapPageType.Stars_Pokedex] = UI.TEXT_222602,
    }

    local index = 0
    for i = StarMapPageType.Star_Map, StarMapPageType.Stars_Max - 1 do
        local pageBtn = UI.Button:create()
        pageBtn:init('ui_starmap_bookmark.png', 'ui_starmap_bookmark.png', 'ui_starmap_bookmark_checked.png')
        pageBtn:leftBottom(self._bg:getContentSize().width - 44, self._bg:getContentSize().height - 82 - index*65)
        pageBtn:setTextFont( UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 240, g = 200, b = 56})
        pageBtn:setText(StarMapPageName[i])
        pageBtn:closeClickScale()
        
        pageBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:updatePageView(i)

            for k,v in pairs(self._pageTable) do
                if i == k then
                    v:disable()
                    v:setFontColor({r = 240, g = 200, b = 56})
                else
                    v:enable()
                    v:setFontColor({r = 134, g = 115, b = 90})
                end
            end

        end)
        self._bg:addChild(pageBtn)
        self._pageTable[i] = pageBtn

        if i == self._pageType then
            pageBtn:disable()
            pageBtn:setFontColor({r = 240, g = 200, b = 56})
        else
            pageBtn:enable()
            pageBtn:setFontColor({r = 134, g = 115, b = 90})
        end

        index = index + 1
    end

    --------------------------------------------------------------
    -- 辅助星图
    self:updateMosaicTypeView(StarMapMosaicType.MosaicFight)

    local StarMapMosaicName = {
        [StarMapMosaicType.MosaicFight] = UI.TEXT_227400,
        [StarMapMosaicType.MosaicAssist] = UI.TEXT_227401,
    }
    local index = 0
    for i = StarMapMosaicType.MosaicFight, StarMapMosaicType.MosaicMax - 1 do
        local mosaicBtn = UI.Button:create()
        mosaicBtn:init('ui_starmap_bookmark_checked2.png', 'ui_starmap_bookmark_checked2.png', 'ui_starmap_bookmark2.png')
        mosaicBtn:leftBottom(- 41, self._bg:getContentSize().height - 139 - index*115)
        mosaicBtn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=201,g=170,b=102})
        mosaicBtn:setText(StarMapMosaicName[i])
        mosaicBtn:setTextOffset(6,0)
        mosaicBtn:closeClickScale()
        
        mosaicBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:updateMosaicTypeView(i)

            for k,v in pairs(self._mosaicTable) do
                if i == k then
                    v:disable()
                    v:setFontColor({r = 240, g = 200, b = 56})
                else
                    v:enable()
                    v:setFontColor({r = 134, g = 115, b = 90})
                end
            end

        end)
        self._bg:addChild(mosaicBtn)
        self._mosaicTable[i] = mosaicBtn

        if i == self._mosaicType then
            mosaicBtn:disable()
            mosaicBtn:setFontColor({r = 240, g = 200, b = 56})
        else
            mosaicBtn:enable()
            mosaicBtn:setFontColor({r = 134, g = 115, b = 90})
        end

        index = index + 1
    end

end

function ManorStarMapView:updatePageView(pageType)
    if pageType == nil or pageType == self._pageType then
        return
    end

    self.contentLayout:removeAllChildren()

    self._pageType = pageType

    self._cardView = nil
    self._pokedexView = nil
    self._upgradeView = nil

    if self._pageType == StarMapPageType.Star_Map then
        local cardView = mvc.manorStarMapCardView:create(self._mosaicType)
        cardView:init()
        cardView:leftBottom(0,0)
        self.contentLayout:addChild(cardView)

        self._cardView = cardView
    elseif self._pageType == StarMapPageType.Stars_Card then
        local upgradeView = mvc.manorStarMapCardUpgradeView:create(self._mosaicType)
        upgradeView:init()
        upgradeView:leftBottom(0,0)
        self.contentLayout:addChild(upgradeView)

        self._upgradeView = upgradeView
    elseif self._pageType == StarMapPageType.Stars_Pokedex then
        local pokedexView = mvc.manorStarMapPokedexView:create(self._mosaicType)
        pokedexView:init()
        pokedexView:leftBottom(0,0)
        self.contentLayout:addChild(pokedexView)

        self._pokedexView = pokedexView
    end

end

function ManorStarMapView:updateMosaicTypeView(mosaicType)
    if mosaicType == nil or mosaicType == self._mosaicType then
        return
    end

    self._mosaicType = mosaicType

    if self._pageType == StarMapPageType.Star_Map then
        self._cardView:updatePageViewByMosaicType(self._mosaicType)
    elseif self._pageType == StarMapPageType.Stars_Card then
        self._upgradeView:setMosaicType(self._mosaicType)
    elseif self._pageType == StarMapPageType.Stars_Pokedex then
        self._pokedexView:setMosaicType(self._mosaicType)
    end
end

function ManorStarMapView:bindModel()

end


function ManorStarMapView:unbindModel()

end





return ManorStarMapView













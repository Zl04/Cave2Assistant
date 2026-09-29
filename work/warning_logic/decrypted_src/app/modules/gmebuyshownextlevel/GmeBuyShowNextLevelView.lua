------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/12/29
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GmeBuyShowNextLevelView = class("GmeBuyShowNextLevelView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_gemshop.plist", 
    "ui_common_btn.plist",
    "ui_town_fisihing.plist",
    "ui_general_shopping.plist",
}

local COM_WIDTH = 671
local COM_HEIGHT = 454

local director = cc.Director:getInstance()
local winSize = director:getWinSize()

function GmeBuyShowNextLevelView:ctor()
    GmeBuyShowNextLevelView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function GmeBuyShowNextLevelView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.gmebuyshownextlevel", "GmeBuyShowNextLevel", false)
    GmeBuyShowNextLevelView.super.init(self, ... )
end

function GmeBuyShowNextLevelView:dtor()
    GmeBuyShowNextLevelView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.gmebuyshownextlevel.GmeBuyShowNextLevelView")
end


function GmeBuyShowNextLevelView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_rune_paper.png")
    bg:center()
    self:addChild(bg)
    self._bg = bg

    local titleBg  = UI.Image:create()
    titleBg:init("ui_rune_title.png")
    titleBg:centerUp(16)
    bg:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_223905, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 170, g = 170, b = 170})
    titleText:center()
    titleBg:addChild(titleText)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local lineSp = UI.Image:create()
    lineSp:init("ui_rune_line.png")
    lineSp:centerUp(68)
    contentLayout:addChild(lineSp)

    local okBtn = UI.Button:create()
    okBtn:init('ui_rune_btn.png', 'ui_rune_btn.png', 'ui_rune_btn.png')
    okBtn:centerBottom(20, 0)
    okBtn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 25, g = 23, b = 21})
    okBtn:setText(UI.TEXT_1170211)
    
    okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("GmeBuyShowNextLevel", "GmeBuyShowNextLevel")
    end)
    contentLayout:addChild(okBtn)

    self:refreshNextDataList()

    for k,v in ipairs(self.dataList) do
        local cell = UI.GemBuyCell:create(nil, v, k)
        cell:leftBottom(27 + (k - 1)*208, 112)
        cell.gemModel.itemBuyBtn:hide()
        cell.gemModel.diamondBuyBtn:hide()
        cell.gemModel.playAdsBtn:hide()
        cell.gemModel.playAdsDes:hide()
        cell.gemModel.freeDes:hide()
        cell.gemModel.timeIcon:hide()
        cell.gemModel.restTimeStr:hide()
        cell.gemModel.oneTime:hide()
        cell.gemModel.tenTime:hide()
        cell.gemModel.remainingTimesText:hide()
        cell.gemModel.cellRewardDes:hide()
        
        contentLayout:addChild(cell)
    end

end

function GmeBuyShowNextLevelView:refreshNextDataList()
    self.dataList = {}
    local exploreLv = MasterDataManager:getGemstoneExploreLv()
    local allLevelConf = ConfigManager:getAllProfileGemstoneCaveData()
    local maxLevel = allLevelConf[#allLevelConf].caveLV
    if exploreLv >= maxLevel then
        exploreLv = maxLevel
    else
        exploreLv = exploreLv + 1
    end

    local levelConf = ConfigManager:getAllProfileGemstoneCaveDataByID(exploreLv)
    local gemstoneCaveId = levelConf.gemstoneCaveId

    for k,v in ipairs(gemstoneCaveId) do
        local dConf = ConfigManager:getAllProfileGemStoneShopDataByID(v)
        table.insert(self.dataList, dConf)
    end

end


function GmeBuyShowNextLevelView:bindModel()

end


function GmeBuyShowNextLevelView:unbindModel()

end





return GmeBuyShowNextLevelView













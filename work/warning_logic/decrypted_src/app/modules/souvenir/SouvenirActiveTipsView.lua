------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/10/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SouvenirActiveTipsView = class("SouvenirActiveTipsView", UI.HWBtnComponent)

local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_manor_cook.plist",
}

local COM_WIDTH = 429
local COM_HEIGHT = 327

local winSize = cc.Director:getInstance():getWinSize()

function SouvenirActiveTipsView:ctor(data)
    SouvenirActiveTipsView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._data = data
end

function SouvenirActiveTipsView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.souvenir", "Souvenir", false)
    SouvenirActiveTipsView.super.init(self, ... )
end

function SouvenirActiveTipsView:dtor()
    SouvenirActiveTipsView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.souvenir.SouvenirActiveTipsView")
end


function SouvenirActiveTipsView:onInitView()
    if not self._data then return end

    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box3_2.png")
    bg:center()
    contentLayout:addChild(bg)
    self._bg = bg

    local bg2 = UI.Image:create()
    bg2:init("ui_souvenir_banner.png")
    bg2:center(0,-35)
    bg:addChild(bg2)

    local desText = UI.Text:create()
    desText:init(UI.TEXT_228413, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
    desText:center()
    desText:setDimensions(380,0)
    bg2:addChild(desText)

    local oneDayBtnStr = ""
    local oneDayCost = 0
    local oneDayCostGoodsID = 0
    local oneDayHaveGoodNumber = 0

    local sevenDayBtnStr = ""
    local sevenDayCost = 0
    local sevenDayCostGoodsID = 0
    local sevenDayHaveGoodNumber = 0

    local effectCost = self._data.effectCost
    local effectCostStr = string.split(effectCost, ";")
    if #effectCostStr == 2 then
        local oneStrList = string.split(effectCostStr[1], ",")
        local sevenStrList = string.split(effectCostStr[2], ",")

        if #oneStrList == 4 then
            oneDayBtnStr = LanguageManager:getInstance():getLocalString(tonumber(oneStrList[4]))
            oneDayCost = tonumber(oneStrList[2])
            oneDayCostGoodsID = tonumber(oneStrList[1])
            oneDayHaveGoodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(oneDayCostGoodsID, true)
        end
        if #sevenStrList == 4 then
            sevenDayBtnStr = LanguageManager:getInstance():getLocalString(tonumber(sevenStrList[4]))
            sevenDayCost = tonumber(sevenStrList[2])
            sevenDayCostGoodsID = tonumber(sevenStrList[1])
            sevenDayHaveGoodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(sevenDayCostGoodsID, true)
        end

    end

    local oneDayActiveBtn = UI.Button:create()
    oneDayActiveBtn:init("ui_cook_btn.png","ui_cook_btn.png","ui_cook_btn.png");
    oneDayActiveBtn:centerBottom(44,-110)
    oneDayActiveBtn:setText(oneDayBtnStr)
    oneDayActiveBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    oneDayActiveBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if mvc.souvenirModel:activitIsFull() then
            UI.ScrollBar:createByText(UI.TEXT_228416)
            return
        end
        --激活一天
        if oneDayHaveGoodNumber >= oneDayCost then
            Net.NetPlaySystem:requestSouvenirActiviteMessage(self._data.ID, 1)
            mvc.closePanel("Souvenir", "SouvenirActiveTips")
        else
            local goodsName = ""
            local goodsData = GoodsDataManager:createLocalGoodsData(oneDayCostGoodsID)
            if goodsData then
                goodsName = goodsData:getName()
            end
            
            UI.ScrollBar:createByText(string.format(UI.TEXT_228415,goodsName))
        end
    end)
    bg:addChild(oneDayActiveBtn)

    local sevenDayActiveBtn = UI.Button:create()
    sevenDayActiveBtn:init("ui_cook_btn.png","ui_cook_btn.png","ui_cook_btn.png");
    sevenDayActiveBtn:centerBottom(44,110)
    sevenDayActiveBtn:setText(sevenDayBtnStr)
    sevenDayActiveBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    sevenDayActiveBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if mvc.souvenirModel:activitIsFull() then
            UI.ScrollBar:createByText(UI.TEXT_228416)
            return
        end
        --激活七天
        if sevenDayHaveGoodNumber >= sevenDayCost then
            Net.NetPlaySystem:requestSouvenirActiviteMessage(self._data.ID, 2)
            mvc.closePanel("Souvenir", "SouvenirActiveTips")
        else
            local goodsName = ""
            local goodsData = GoodsDataManager:createLocalGoodsData(sevenDayCostGoodsID)
            if goodsData then
                goodsName = goodsData:getName()
            end
            UI.ScrollBar:createByText(string.format(UI.TEXT_228415,goodsName))
        end
    end)
    bg:addChild(sevenDayActiveBtn)

    local oneDayCostLayout = self:createCostNode(oneDayCostGoodsID, oneDayCost)
    oneDayActiveBtn:addChild(oneDayCostLayout,999)
    local sevenDayCostLayout = self:createCostNode(sevenDayCostGoodsID, sevenDayCost)
    sevenDayActiveBtn:addChild(sevenDayCostLayout,999)

end

function SouvenirActiveTipsView:createCostNode(goodsID, needNum)
    local upgradeLayout = UI.Layout:create()
    upgradeLayout:init()
    upgradeLayout:center(0,-38)

    local layoutWidth = 0

    local hfDesText = UI.Text:create()
    hfDesText:init(UI.TEXT_228411, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    hfDesText:floatLeft(3)
    upgradeLayout:addComponent(hfDesText)
    layoutWidth = layoutWidth + hfDesText:getContentSize().width + 3

    local goodsData = GoodsDataManager:createLocalGoodsData(goodsID)
    if goodsData then
        local upgradeIcon = UI.Image:create()
        upgradeIcon:init(goodsData.miniIcon)
        upgradeIcon:floatLeft(3)
        upgradeLayout:addComponent(upgradeIcon)
        layoutWidth = layoutWidth + upgradeIcon:getContentSize().width + 3
    end

    local needNumText = UI.Text:create()
    needNumText:init(tostring(needNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    needNumText:floatLeft(3)
    upgradeLayout:addComponent(needNumText)
    layoutWidth = layoutWidth + needNumText:getContentSize().width + 3

    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID, true)
    if goodNumber < needNum then
        needNumText:setFontColor(UI.FONT_COLOR_RED)
    end

    upgradeLayout:setSize(layoutWidth, 25)

    return upgradeLayout
end


function SouvenirActiveTipsView:bindModel()

end


function SouvenirActiveTipsView:unbindModel()

end





return SouvenirActiveTipsView













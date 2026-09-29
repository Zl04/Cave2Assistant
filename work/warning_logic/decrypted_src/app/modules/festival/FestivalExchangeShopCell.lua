------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2020/5/9
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local FestivalExchangeShopCell = class("FestivalExchangeShopCell", UI.HWBtnComponent)
UI.FestivalExchangeShopCell = FestivalExchangeShopCell

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 621
local COM_HEIGHT = 123

function FestivalExchangeShopCell:ctor()
    FestivalExchangeShopCell.super.ctor(
    	self,
    	UI.Type.NORMAL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
end

function FestivalExchangeShopCell:init(activityID, data)
    FestivalExchangeShopCell.super.init(self)

    self._activityID = activityID
    self._data = data
end

function FestivalExchangeShopCell:dtor()
    FestivalExchangeShopCell.super.dtor(self)
    reload_script_file("app.modules.festival.FestivalExchangeShopCell")
end

function FestivalExchangeShopCell:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_festival_shop_banner_1.png")
    bg:center()
    self:addChild(bg)
    self.bg = bg

    local goodsBg = UI.Image:create()
    goodsBg:init("ui_guild_auction_box_0.png")
    goodsBg:centerLeft(9)
    bg:addChild(goodsBg)
    self.goodsBg = goodsBg

    local goodsData = GoodsDataManager:createLocalGoodsData(20010021)
    goodsData:setIsNew(false)


    self._goodsGrid = UI.GoodsGrid:create()
    self._goodsGrid:init(goodsData)
    self._goodsGrid:center()
    self._goodsGrid:showInfoArea(true, false)
    goodsBg:addChild(self._goodsGrid)

    -- 消耗物品
    self._useGoodsGrid = UI.GoodsGrid:create()
    self._useGoodsGrid:init(goodsData)
    self._useGoodsGrid:centerLeft(227)
    self._useGoodsGrid:showInfoArea(true, false)
    bg:addChild(self._useGoodsGrid)

    -- 数量显示
    local numberBg = UI.Image:create()
    numberBg:init("ui_festival_shop_number_box_1.png")
    numberBg:rightBottom(238, 24)
    -- numberBg:setScale(1)
    bg:addChild(numberBg)
    -- numberBg:enableDebugDraw()
    self.numberBg = numberBg

	local numberText = UI.Text:create()
	numberText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_190_190_190)
	numberText:center()
    numberBg:addChild(numberText, 100)
    self.numberText = numberText

    local btn = UI.Button:create()
    btn:init("ui_btn_yellow9_0.png","ui_btn_yellow9_1.png","ui_btn_yellow9_2.png")
    btn:rightUp(32, 23)
    btn:closeClickScale()
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- 处理兑换逻辑
        local itemData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, tonumber(self._data:getMaterialID()), false, 0)
        if itemData and itemData:getIsLock() then
            UI.ScrollBar:createByTextID(1170266)
            return
        end    

        local goodsArr = {}
        local data = {}
        data.goodsID = self._data:getGoodsID()
        data.num = self._data:getGoodsNum()
        data.isGolden = false
        table.insert(goodsArr, data)
        local GameDataManager = require("app.game.GameDataManager")
        if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr) == false) then 
            UI.ScrollBar:createByTextID(1110793)
            return
        else 
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            mvc.send(mvc.events.Festival_ExchangeShopExchangeRequest, self._activityID, self._data:getID()) 
        end
    end)
    btn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    bg:addChild(btn)
    btn:setText(UI.TEXT_1150011)
    self.exchangeBtn = btn

    local numberText = UI.Text:create()
	numberText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_123_14_14)
	numberText:centerUp(48)
    btn:addChild(numberText, 100)
    self.exchangeNumberText = numberText
end

function FestivalExchangeShopCell:onUpdateView()
    self:updateData(self._data)
end

function FestivalExchangeShopCell:updateData(data)
    self._data = data
    if(self._data) then 
        self._goodsGrid:setData(self._data:getGoodsData())
        self._useGoodsGrid:setData(self._data:getMaterialData())
        self._goodsGrid:showCountLabel()
        self._goodsGrid:updateView()
        self._useGoodsGrid:updateView()

        self.exchangeBtn:enable()
        if self._data:getIsExchangeStatus() then 
            self.bg:setSpriteName("ui_festival_shop_banner_1.png")
            self._goodsGrid:setNormal()
            self._useGoodsGrid:setNormal()
            self.exchangeBtn:setText(UI.TEXT_1150011)
            self.numberBg:setSpriteName("ui_festival_shop_number_box_1.png")
        else
            self.bg:setSpriteName("ui_festival_shop_banner_0.png")
            self._goodsGrid:setIsGray()
            self._useGoodsGrid:setIsGray()

            self.numberBg:setSpriteName("ui_festival_shop_number_box_0.png")
            self.exchangeBtn:disable()
            self.exchangeBtn:setText(UI.TEXT_1324103)
        end

        local materialNum = self._data:getMaterialNum()
        local haveNum = GoodsDataManager:getGoodsDataNum(RoleDataManager:getMasterPK(), PublicDefine.PACKET_TYPE.PACKET_BAG, self._data:getMaterialID(), true)
        self.numberText:setText(haveNum.."/"..materialNum)
        if(haveNum >= materialNum) then 
            self.numberText:setFontColor(UI.FONT_COLOR_190_190_190)
        else
            self.exchangeBtn:disable()
            self.numberText:setFontColor({r = 231,g = 73,b = 42})
        end

        if(self._data:getExchangeLimit() == 0) then 
            self.exchangeNumberText:setText("")
        else
            self.exchangeNumberText:setText(string.format(UI.TEXT_1324102, self._data:getHaveExchangeNum()))
        end
    end
end

------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/04/23
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local CrystalTreatureShopView = class("CrystalTreatureShopView", UI.HWBtnComponent)
local CrystalTreatureShopCell = require("app.modules.crystaltreatureshop.CrystalTreatureShopCell")
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_businessactivities_treasure.plist",
    "ui_common_symbol.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local COLUMN_NUM = 3

function CrystalTreatureShopView:ctor()
    CrystalTreatureShopView.super.ctor(
    	self,
    	UI.Type.CRYSTAL_CAPTURE_SHOP,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._storeType = storeType
    self._bg = nil
    self._tableView = nil
end

function CrystalTreatureShopView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.crystaltreatureshop", "CrystalTreatureShop", false)
    CrystalTreatureShopView.super.init(self, ... )
end

function CrystalTreatureShopView:dtor()
    CrystalTreatureShopView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.crystaltreatureshop.CrystalTreatureShopView")
end


function CrystalTreatureShopView:onInitView()
    self:center()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local innerImg  = UI.Image:create()
    innerImg:init("ui_treasure_bg_4.png")
    innerImg:center()
    contentLayout:addChild(innerImg)
    self._bg = innerImg

    --LanguageManager:getInstance():getLocalString(1114092)
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_224604,UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 215, g = 211, b = 207})
    titleText:center(15,-235)
    titleText:useDefaultShadowOnlyStype(cc.c4b(73, 59, 121, 255))
    innerImg:addChild(titleText)

    -- local decorateImg = UI.Image:create()
    -- decorateImg:init("ui_turntable_decoration.png")
    -- decorateImg:centerUp(25)
    -- self._bg:addChild(decorateImg)

    --描述
    -- local desIcon = UI.Image:create()
    -- desIcon:init("ui_turntable_icon_lucky.png")
    -- desIcon:leftUp(70,80)
    -- self._bg:addChild(desIcon)

    -- local desText = UI.Text:create()
    -- desText:init(LanguageManager:getInstance():getLocalString(1114093),UI.FONT_STANDARD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_164_164_164)
    -- desText:leftUp(70 + 30,85)
    -- self._bg:addChild(desText)

    --钥匙
    local keyStr = "symbol_gaming_207252.png"

    local keyIcon = UI.Image:create()
    keyIcon:init(keyStr)
    keyIcon:leftUp(155 + 460,60)
    self._bg:addChild(keyIcon)

    local contribNum = mvc.fightBackShopModel:getContribNum(self._storeType)
    local numText = UI.Text:create()
    numText:init(tostring(contribNum),UI.FONT_BOLD, 19, UI.FONT_COLOR_222_190_98)
    numText:leftUp(155 + 500,63)
    self._bg:addChild(numText)
    self._numText = numText

    local contribNum = mvc.crystalTreatureShopModel:getContribNum(PublicDefine.StoreType.StoreType_CrystalTreature)
    if self._numText then
        self._numText:setText(tostring(contribNum))
    end


    -- if self._storeType == PublicDefine.StoreType.StoreType_LimitedMarblesFever then
        -- keyStr = "symbol_gaming_antifightingkey_2.png"

        -- local keyIcon = UI.Image:create()
        -- keyIcon:init(keyStr)
        -- keyIcon:leftUp(155 + 440,80)
        -- self._bg:addChild(keyIcon)

        -- local contribNum = mvc.fightBackShopModel:getContribNum(self._storeType)
        -- local contribNum = mvc.crystalTreatureShopModel:getContribNum(PublicDefine.StoreType.StoreType_LimitedMarblesFever)
        -- local numText = UI.Text:create()
        -- numText:init(tostring(contribNum),UI.FONT_BOLD, UI.FONT_SIZE_17PX, UI.FONT_COLOR_222_190_98)
        -- numText:leftUp(155 + 440 + 35,85)
        -- self._bg:addChild(numText)
        -- self._numText2 = numText
    -- end

    --线
    -- local lineImg = UI.Image:create()
    -- lineImg:init("ui_turntable_line.png")
    -- lineImg:centerUp(110)
    -- self._bg:addChild(lineImg)

    self:initTopShop()
    

    -- --线(下)
    -- local lineImg2 = UI.Image:create()
    -- lineImg2:init("ui_shopping_banner_mask.png")
    -- lineImg2:centerBottom(10)
    -- self:addChild(lineImg2)

    --灯
    -- local leftLampImg = UI.Image:create()
    -- leftLampImg:init("ui_turntable_decoration_03.png")
    -- leftLampImg:leftBottom(-55,0)
    -- self._bg:addChild(leftLampImg)

    -- local rightLampImg = UI.Image:create()
    -- rightLampImg:init("ui_turntable_decoration_04.png")
    -- rightLampImg:rightBottom(-30,0)
    -- -- rightLampImg:setScaleX(-1)
    -- self._bg:addChild(rightLampImg)
end

function CrystalTreatureShopView:initTopShop()
    self._data = mvc.crystalTreatureShopModel:refreshShopData(self._storeType)

    if self._tableView then
        self._tableView:removeFromParent()
        self._tableView = nil
    end
    -- 商品列表
    self._tableView = UI.TableView:create({}, 660, 360)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(110, 65)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:setScrollBarEnabled(true)
    self._tableView:setCircleVisible(false)
    self._tableView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    self._tableView:onUpdateCellSize(function ()
        return 199, 309--224, 309
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.CrystalTreatureShopCell.new(self._tableView)
            cell:setCallback(function(id)
                local buyGridsTips = UI.Tips:createTips(languageManagerInstance:getLocalString(1114095),
                    UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)

                buyGridsTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                    mvc.crystalTreatureShopController:requestBuyItem(id,self._storeType)
                end)
            end)
        end
        local tempD = {}
        for i = 1, COLUMN_NUM do
            table.insert(tempD,self._data[idx * COLUMN_NUM + i])
        end
        xpcall(function()
            cell:onUpdateView(tempD)
        end, 
        function(e) 
            printInfo("CrystalTreatureShopView:tableCellAtIndex, error")
        end, 1) 
        
        return cell
    end)
    self._tableView:onUpdateCellNumbers(function ()
        return math.ceil(table.nums(self._data) / COLUMN_NUM)
    end)
    self:addChild(self._tableView)
    self._tableView:reloadData()
end

function CrystalTreatureShopView:updateViewandler(data)
    local contribNum = mvc.crystalTreatureShopModel:getContribNum(PublicDefine.StoreType.StoreType_CrystalTreature)
    -- local contribNum2 = mvc.fightBackShopModel:getContribNum(self._storeType)
    local contribNum2 = mvc.crystalTreatureShopModel:getContribNum(PublicDefine.StoreType.StoreType_CrystalTreature)
    
    print("updateViewandler--->: ", tostring(contribNum))
    if self._numText then
        self._numText:setText(tostring(contribNum))
    end

    if self._numText2 then
        self._numText2:setText(tostring(contribNum2))
    end


    if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
        print("ROLE_REQ_STORE_BUY_GOODS result is err == ".. data.result)

        UI.WaitingLayer:hideWaiting()
        return
    end

    if data and data.awards then
        local awards = data.awards
        local awardsList = {}
        for _, value in ipairs(awards) do
            local awarObj = GoodsDataManager:createLocalGoodsData(value.id)
            awarObj:setNum(value.num)
            if value.num > 0 then
                table.insert(awardsList, awarObj)
            end
        end
        if #awardsList > 0 then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
        end

        UI.WaitingLayer:hideWaiting()
    end

    self:initTopShop()
end

function CrystalTreatureShopView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_FIGHT_BACK_SHOP, self, self.updateViewandler)
end


function CrystalTreatureShopView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_FIGHT_BACK_SHOP, self, self.updateViewandler)
end





return CrystalTreatureShopView













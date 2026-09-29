------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/11/07
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local TradeActivityNewGrowFundTwoView = class("TradeActivityNewGrowFundTwoView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 681
local COM_HEIGHT = 470

local CELL_WIDTH = 360
local CELL_HEIGHT = 84

local ACTIVITY_ID = PublicDefine.TradeActivityIDList.TradeActivityNewGrowFundTwo

function TradeActivityNewGrowFundTwoView:ctor()
    TradeActivityNewGrowFundTwoView.super.ctor(
    	self,
    	UI.Type.TRADE_ACTIVITY_GROW_FUND,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.getItemIndex = nil
    self:bindModel()
end

function TradeActivityNewGrowFundTwoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    TradeActivityNewGrowFundTwoView.super.init(self, ... )
end

function TradeActivityNewGrowFundTwoView:dtor()
    TradeActivityNewGrowFundTwoView.super.dtor(self)
    self.getItemIndex = nil
    self:unbindModel()
    reload_script_file_mvc("app.modules.tradeactivity.TradeActivityNewGrowFundTwoView")
end


function TradeActivityNewGrowFundTwoView:bindModel()
    mvc.tradeActivityModel:bind("newGrowFundTwoIsBuy", self, self.updateBuyBtn)
    mvc.tradeActivityModel:bind("newGrowFundTwoGotAwardsList", self, self.updateGotAwardsBtn)
end


function TradeActivityNewGrowFundTwoView:unbindModel()
    mvc.tradeActivityModel:unbind("newGrowFundTwoIsBuy", self, self.updateBuyBtn)
    mvc.tradeActivityModel:unbind("newGrowFundTwoGotAwardsList", self, self.updateGotAwardsBtn)
end


function TradeActivityNewGrowFundTwoView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 右侧底图
    local innerBg = UI.Image:create()
    innerBg:init("ui_businessactivities_bg_02.png")
    innerBg:center()
    contentLayout:addChild(innerBg)

    -- 内部背景图片
    local leftImg  = UI.Image:create()
    leftImg:init("ui_businessactivities_illustration_07.png")
    leftImg:leftUp(8, 8)
    -- leftImg:enableDebugDraw()
    contentLayout:addChild(leftImg)

    --魂器spine表现
    local spineNameTable = {
        [1] = "role_npc_horcruxes_shoggoth",
        [2] = "role_npc_horcruxes_parasite",
        [3] = "role_npc_horcruxes_madking",
        [4] = "role_npc_horcruxes_troll",
        [5] = "role_npc_horcruxes_destroyer",
        [6] = "role_npc_horcruxes_gaia",
        [7] = "role_npc_horcruxes_tindalos",
        [8] = "role_npc_horcruxes_medusa",
    }

    local nameIndex = math.random(1,#spineNameTable)
    local skeletonFile = spineNameTable[nameIndex] .. ".json"
    local atlasFile = spineNameTable[nameIndex] .. ".atlas"

    local hqAnimation = Avalon.Animation:create(skeletonFile, atlasFile, 1.8)
    hqAnimation:setPosition(leftImg:getContentSize().width / 2,leftImg:getContentSize().height / 2 - 180)
    leftImg:addChild(hqAnimation)
    hqAnimation:setAnimation(0, "idle1", true)


    -- 领取框
    local awardLayout = UI.Layout:create()
    awardLayout:init()
    awardLayout:setSize(368, 390)
    awardLayout:rightUp(12, 8)
    -- awardLayout:enableDebugDraw()
    self:addChild(awardLayout)
    self.awardLayout = awardLayout

    self:createAwardsLayer()

    local level = RoleDataManager:getMaster():getLevel()
    local lvText = UI.Text:create()
    lvText:init(string.format(UI.TEXT_1324537, level), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    lvText:rightBottom(26, 84)
    contentLayout:addChild(lvText)

    -- 购买按钮
    local buyButton = UI.Button:create()
    buyButton:init('ui_btn_yellow12_0.png', 'ui_btn_yellow12_1.png', 'ui_btn_yellow12_2.png')
    buyButton:rightBottom(80, 20)

    buyButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local SceneManager = require("app.game.SceneManager")
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        local SdkManager = require "app.game.SdkManager"
        -- local getIapDatas = SdkManager:getInstance():getIapDatas()
        -- local giftData = nil
        -- for k, v in pairs(getIapDatas) do
        --     if v.label == PublicDefine.PURCHASE_PRODUCT_TYPE.LevelFund then
        --         giftData = v
        --         break
        --     end
        -- end

        local giftData = mvc.tradeActivityModel:getGrowFundGiftData(ACTIVITY_ID)

        if not giftData then
            return
        end

        UI.WaitingLayer:showWaiting(true, nil, 2)


        SdkManager:getInstance():getOrder(giftData, 1, PublicDefine.PURCHASE_PRODUCT_TYPE.LevelFund)
    end)
    self:addChild(buyButton)
    self.buyButton = buyButton

    self:updateBuyButton()

    -- 展示购买立得
    local descBg = UI.Image:create()
    descBg:init("ui_businessactivities_label_05.png")
    descBg:leftBottom(0, 0)
    -- descBg:enableDebugDraw()
    leftImg:addChild(descBg)

    local descLayout = UI.Layout:create()
    descLayout:init()
    descLayout:enableAutoWidth()
    descLayout:enableAutoHeight()
    -- descLayout:enableDebugDraw()
    descLayout:center(6, 11)

    descLayout:setSkewX(10)
    descLayout:setRotation(-21.5)

    descBg:addChild(descLayout)

    local descText = UI.Text:create()
    descText:init(UI.TEXT_1324538, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_255_255_255)
    descText:floatLeft(0)
    
    descText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(2, -2))
    descLayout:addComponent(descText)

    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_horcrux.png")
    diamondImage:floatLeft(3)
    -- diamondImage:setRotation(-40)
    diamondImage:setSkewX(-10)
    descLayout:addComponent(diamondImage)

    local growFundGiftData = mvc.tradeActivityModel:getGrowFundGiftData(ACTIVITY_ID)

    local priceStr = tostring(growFundGiftData.products[1].num)
    -- 价钱文字
    local diamondNum = UI.Text:create()
    diamondNum:init(priceStr, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_255_255_125)
    diamondNum:floatLeft(3)
    diamondNum:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(2, -2))
    descLayout:addComponent(diamondNum)
    -- 刷新descBg的大小
    -- descBg:setSize(descLayout:getContentSize().width + 28, 49)

    -- 30倍返利提示
    local promptBg = UI.Image:create()
    promptBg:init("ui_businessactivities_up_2.png")
    promptBg:rightUp(0, 0)
    -- promptBg:enableDebugDraw()
    leftImg:addChild(promptBg)

    local promptLayout = UI.Layout:create()
    promptLayout:init()
    promptLayout:enableAutoWidth()
    promptLayout:enableAutoHeight()
    promptLayout:setRotation(-7)
    promptLayout:center(0, -13)
    promptBg:addChild(promptLayout)

    local promptNum = UI.Text:create()
    promptNum:init(UI.TEXT_1324540, UI.FONT_BOLD, UI.FONT_SIZE_36PX, UI.FONT_COLOR_255_213_19)
    promptNum:floatLeft(3)
    promptNum:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -5))
    promptLayout:addComponent(promptNum)

    local promptText = UI.Text:create()
    promptText:init(UI.TEXT_1324504, UI.FONT_BOLD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_255_255_255)
    promptText:floatLeft(3)
    promptText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(3, -5))
    promptLayout:addComponent(promptText)
end

function TradeActivityNewGrowFundTwoView:createAwardsLayer()
    local bg = UI.Image:create()
    bg:init("ui_businessactivities_bg_03.png")
    bg:centerUp(0)
    -- bg:enableDebugDraw()
    self.awardLayout:addChild(bg)

    local configData = ConfigManager:getTradeActivityDataByID(ACTIVITY_ID)

    self._tableView = UI.TableView.new({}, CELL_WIDTH + 14, 348)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:center(8, -18)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT
    end)

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createAwardCell(index)
            end,
            function(e)
                printError("------------------------TradeActivityMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local image = cell:getChildByName("image")
            if image and tolua.isnull(image) then
                image:removeFromParent()
            end
            cell = self:createAwardCell(index)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return #configData.exchange
    end)

    self.awardLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end


function TradeActivityNewGrowFundTwoView:createAwardCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

    local image = UI.Image.create()
    image:init("ui_businessactivities_background_02.png")
    image:centerBottom(0)
    image:setName("image")
    cell:addChild(image)

    local configData = ConfigManager:getTradeActivityDataByID(ACTIVITY_ID)

    local awardList = string.split(string.split(configData.reward, ":")[index], ";")
    -- 目前的排版只能显示一个奖励，如果需要显示多个，需要修改此处逻辑
    local awardInfo = string.split(awardList[1], ",")
    local goodData = GoodsDataManager:createLocalGoodsData(tonumber(awardInfo[1]))
    if goodData then
        goodData:setNum(tonumber(awardInfo[2]))
        goodData:setIsNew(false)
        goodData.isHaveGet = false

        local rewardGrid = UI.GoodsGrid:create()
        rewardGrid:init(goodData)
        rewardGrid:centerLeft(16)
        rewardGrid:hideNewIcon()
        rewardGrid:setTouchEnable(true)
        rewardGrid:setSwallowTouches(false)
        rewardGrid:setTouchClipNode(self.awardLayout)
        rewardGrid:showInfoArea(true, false)
        image:addChild(rewardGrid)
    end

    local needLv = configData.exchange[index]
    local text = UI.Text:create()
    text:init(string.format(UI.TEXT_1324506, needLv), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    text:centerLeft(90, 0)
    text:setSize(146, 60)
    text:setTextCenter()
    text:setLineSpacing(-5)
    image:addChild(text)

    local getBtn = UI.Button:create()
    getBtn:init('ui_businessactivities_btn_02.png', 'ui_businessactivities_btn_02.png', 'ui_businessactivities_btn_gray_02.png')
    getBtn:centerRight(2)
    getBtn:closeClickScale()
    getBtn:setText(UI.TEXT_111035)
    getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    getBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local SceneManager = require("app.game.SceneManager")
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        UI.WaitingLayer:showWaiting(true, nil, 5)
        -- 发送领奖时记录一下index方便展示领取奖励框
        self.getItemIndex = index
        print("  sendRequestGrowFundGetAwards ========== ", configData.exchange[index],ACTIVITY_ID)
        Net.NetRoleSystem:sendRequestGrowFundGetAwards(configData.exchange[index],ACTIVITY_ID)
    end)
    getBtn:setName("getBtn")
    image:addChild(getBtn)

    local gotImg = UI.Image.create()
    gotImg:init("ui_information_banner_receive.png")
    gotImg:centerRight(-4)
    gotImg:setScale(0.7)
    gotImg:setName("gotImg")
    gotImg:hide()
    image:addChild(gotImg)

    local gotText = UI.Text:create()
    gotText:init(UI.TEXT_1110721, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_15_85_71)
    gotText:center()
    gotText:setRotation(-9)
    gotText:setName("gotText")
    gotText:hide()
    gotImg:addChild(gotText)

    self:updateAwardCellBtn(image, index)

    return cell
end


function TradeActivityNewGrowFundTwoView:updateAwardCellBtn(image, index)
    local getBtn = image:getChildByName("getBtn")
    if not getBtn or tolua.isnull(getBtn) then
        return
    end

    local configData = ConfigManager:getTradeActivityDataByID(ACTIVITY_ID)

    local gotList = mvc.tradeActivityModel:getNewGrowFundTwoGotAwardsList()

    getBtn:show()
    if not mvc.tradeActivityModel:getNewGrowFundTwoIsBuy() then
        getBtn:disable()
        getBtn:setText(UI.TEXT_1324507)
    elseif gotList[configData.exchange[index]] then
        getBtn:disable()
        getBtn:hide()
        local gotImg = image:getChildByName("gotImg")
        if getBtn and not tolua.isnull(gotImg) then
            gotImg:show()
        end
        local gotText = gotImg:getChildByName("gotText")
        if gotText and not tolua.isnull(gotText) then
            gotText:show()
        end
    elseif RoleDataManager:getMaster():getLevel() >= configData.exchange[index] then
        getBtn:enable()
        getBtn:setText(UI.TEXT_111035)
    else
        getBtn:disable()
        getBtn:setText(UI.TEXT_1324508)
    end
end


function TradeActivityNewGrowFundTwoView:updateBuyButton()
    if mvc.tradeActivityModel:getNewGrowFundTwoIsBuy() then
        self.buyButton:disable()
        self.buyButton:setText(UI.TEXT_1324509)

        if self._priceLayout and not tolua.isnull(self._priceLayout) then
            self._priceLayout:removeFromParent(false)
        end
    else
        self.buyButton:enable()
        self.buyButton:setText("")
        -- 价钱排版
        self._priceLayout = UI.Layout:create()
        self._priceLayout:init()
        self._priceLayout:center()
        self._priceLayout:enableAutoHeight()
        self._priceLayout:enableAutoWidth()
        self.buyButton._text:addChild(self._priceLayout, 100)

        -- 货币图标
        local currencyIcon = UI.Image:create()
        currencyIcon:init(UIUtil:getMoneyPng())
        currencyIcon:floatLeft(0)
        self._priceLayout:addComponent(currencyIcon)

        local growFundGiftData = mvc.tradeActivityModel:getGrowFundGiftData(ACTIVITY_ID)

        local curPrice = ""
        local SdkManager = require "app.game.SdkManager"
        local priceString = SdkManager:getInstance():getPriceStringFromIapID(growFundGiftData.iapId)
        if (priceString) then
            curPrice = priceString
            currencyIcon:hide()
        else
            currencyIcon:show()
            curPrice = UIUtil:getMoneyPriceStr(growFundGiftData.price/100)
        end
        -- print("growFundGiftData  curPrice=", curPrice)
        local priceStr = curPrice.." "..UI.TEXT_1324505

        -- 价钱文字
        local priceLabel = UI.Text:create()
        priceLabel:init(priceStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        priceLabel:floatLeft(8)
        self._priceLayout:addComponent(priceLabel)
    end
end

-- 购买成长基金以后刷新按钮和列表
function TradeActivityNewGrowFundTwoView:updateBuyBtn()
    self:updateBuyButton()
    self._tableView:reloadData(true)
end

-- 领取奖励以后刷新按钮
function TradeActivityNewGrowFundTwoView:updateGotAwardsBtn()
    self._tableView:reloadData(true)

    if not self.getItemIndex then
        return
    end

    local configData = ConfigManager:getTradeActivityDataByID(ACTIVITY_ID)
    local gotList = mvc.tradeActivityModel:getNewGrowFundTwoGotAwardsList()

    if gotList[configData.exchange[self.getItemIndex]] then
        self:showGetAwards()
    end
end

function TradeActivityNewGrowFundTwoView:showGetAwards()
    local configData = ConfigManager:getTradeActivityDataByID(ACTIVITY_ID)

    local awardList = string.split(string.split(configData.reward, ":")[self.getItemIndex], ";")
    -- 重置
    self.getItemIndex = nil

    local awardsList = {}
    for index = 1, #awardList do
        local awardInfo = string.split(awardList[index], ",")
        local awarObj = GoodsDataManager:createLocalGoodsData(tonumber(awardInfo[1]))
        awarObj:setNum(tonumber(awardInfo[2]))
        if tonumber(awardInfo[2]) > 0 then
            table.insert(awardsList, awarObj)
        end
    end
    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
    end
end

return TradeActivityNewGrowFundTwoView













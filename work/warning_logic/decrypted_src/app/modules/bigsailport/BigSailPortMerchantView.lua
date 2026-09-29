------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/14
--desc	: 
------------------------------------------------------------------------------
-- 商人
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortMerchantView = class("BigSailPortMerchantView", UI.HWBtnComponent)
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

UI.BigSailPortMerchantView = BigSailPortMerchantView

-- 资源
local COM_RES_LIST = {
    "ui_general_shop.plist",
    "ui_town_guild_create.plist",
    "ui_common_btn.plist",
    "ui_pet_treasure.plist",
    "ui_common_information.plist",
    "ui_town_dream_common.plist",
    "ui_common_information.plist",
    "ui_town_greatnavigation.plist",
}

local SHOP_INDEX = {
    NORMAL_SHOP = 1,
    LIMIT_SHOP = 2,
}

local COM_WIDTH = 980
local COM_HEIGHT = 600
local INNER_WIDTH = 705
local INNER_HEIGHT = 386
local BTN_CELL_W = 109
local BTN_CELL_H = 70
local ROW_WIDTH = 705
local ROW_HEIGHT = 220
local DUST_ID = ConfigManager:getNavigationShopByID(1).materialID

function BigSailPortMerchantView:ctor()
    BigSailPortMerchantView.super.ctor(
    	self,
    	UI.Type.BIGSAIL_MERCHANT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.shopIndex = SHOP_INDEX.NORMAL_SHOP
    self:initShopConfig()
end

function BigSailPortMerchantView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailPortMerchantView.super.init(self, ... )
end

function BigSailPortMerchantView:dtor()
    BigSailPortMerchantView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailport.BigSailPortMerchantView")
end


function BigSailPortMerchantView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 30)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_guild_create_banner_box.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 内部背景图片
    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)

    -- 标题背景图片
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_bg_title.png");
    bgTitle:centerUp(-7);
    contentLayout:addChild(bgTitle);

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1328003, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_150_150_150)
    titleTxt:center(10,0)
    bgTitle:addChild(titleTxt)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark2.png")
    splitLine:setContentSize(733, 2)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(100+733/2, 514)
    contentLayout:addChild(splitLine)

    -- 左侧蛋图
    local leftManImg  = UI.Image:create()
    leftManImg:init("ui_recovery_foreground_left.png")
    leftManImg:leftBottom(-46, 4)
    contentLayout:addChild(leftManImg)
    self.leftManImg = leftManImg

    -- 右侧老鼠
    local rightWaterEff = UI.Animation:create()
    rightWaterEff:init("effect_ui_recovery_rat.json", "effect_ui_recovery_rat.atlas", 1)
    rightWaterEff:leftBottom(934, 4)
    rightWaterEff:setAnimation("idle1", true)
    contentLayout:addChild(rightWaterEff)
    self.rightWaterEff = rightWaterEff
    rightWaterEff._spine:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- TODO 播放音效文件
                local soundFilename = string.sub(event.eventData.name,7,-1)
                Avalon.AudioManager:playDynamicSound(soundFilename, false, RoleDataManager:getMaster():getCoord())
            end

            local shakePos = string.find(event.eventData.name, "hitshake_")
            if(shakePos ~= nil) then
                -- 播放抖动
                local shake = string.sub(event.eventData.name,10,-1)
                if(shake) then 
                    Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                end
            end
        end
    end, sp.EventType.ANIMATION_EVENT)

    -- 设置下一个动作
    local nextActionName = "idle" .. math.random(2, 3)
    rightWaterEff:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function()
        if not nextActionName then
            nextActionName = "idle1"
            rightWaterEff:setAnimation(nextActionName, true)
            nextActionName = "idle" .. math.random(2, 3)
        elseif nextActionName and nextActionName ~= "idle1" then
            rightWaterEff:setAnimation(nextActionName, false)
            nextActionName = nil
        end
    end)

    -- 航海积分图标
    local config2 = ConfigManager:getAllNavigationShopData()
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(config2[1].materialID))
    local dustIcon = UI.Image:create()
    dustIcon:init(goodsData.miniIcon)
    dustIcon:rightUp(260, 52)
    self.dustIcon = dustIcon
    contentLayout:addChild(dustIcon)

    -- 货币数量
    local dustNum  = UI.Text:create()
    dustNum:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    dustNum:setTextLeft()
    dustNum:centerLeft(50)
    dustIcon:addChild(dustNum)
    self.dustNum = dustNum

    -- 竞猜币图标
    local guesGoodsData = ConfigManager:getVirtualItemConfigByID(23510001)
    local guesIcon = UI.Image:create()
    guesIcon:init(guesGoodsData.miniIcon)
    guesIcon:rightUp(400, 52)
    self.guesIcon = guesIcon
    contentLayout:addChild(guesIcon)

    -- 货币数量
    local guesNum  = UI.Text:create()
    guesNum:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    guesNum:setTextLeft()
    guesNum:centerLeft(50)
    guesIcon:addChild(guesNum)
    self.guesNum = guesNum

    self:updateDustNum()

    -- 常驻商店按钮
    local normalBtn =  UI.Button:create()
    normalBtn:init("ui_greatnavigation_lable_4.png","ui_greatnavigation_lable_3.png","ui_greatnavigation_lable_3.png")
    normalBtn:leftUp(880, 55)
    normalBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 121, g = 110, b = 86})
    normalBtn:setText(UI.TEXT_226704)
    normalBtn:setTextOffset(-12,0)
    normalBtn:closeClickScale()
    normalBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:showNowShop(SHOP_INDEX.NORMAL_SHOP)
    end)
    self.normalBtn = normalBtn
    contentLayout:addChild(normalBtn)

    -- 限时商店按钮
    local limitBtn =  UI.Button:create()
    limitBtn:init("ui_greatnavigation_lable_4.png","ui_greatnavigation_lable_3.png","ui_greatnavigation_lable_3.png")
    limitBtn:leftUp(880, 130)
    limitBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 121, g = 110, b = 86})
    limitBtn:setText(UI.TEXT_226705)
    limitBtn:setTextOffset(-12,0)
    limitBtn:closeClickScale()
    limitBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:showNowShop(SHOP_INDEX.LIMIT_SHOP)
    end)
    contentLayout:addChild(limitBtn)
    self.limitBtn = limitBtn

    -- 目前仅一个物资兑换不涉及页签，暂时屏蔽
    self:updateLayer()

    self:showNowShop(SHOP_INDEX.NORMAL_SHOP)
end

function BigSailPortMerchantView:updateLayer()
    self.dustTotalNum = mvc.bigSailPortModel:getBaseData().debris

    -- 加载物资列表
    self:updateGoodsList()
end

function BigSailPortMerchantView:updateGoodsList()
    self:updateResidentshop()
    self:updateLimitshop()
end

function BigSailPortMerchantView:showNowShop(indexShop)
    self.shopIndex = indexShop

    if indexShop == SHOP_INDEX.NORMAL_SHOP then
        self.recordsTableView:setVisible(true)
        self.normalBtn:disable()
        self.normalBtn:setFontColor({r = 220, g = 182, b = 80})
        self.recordsLimitTableView:setVisible(false)
        self.limitBtn:enable()
        self.limitBtn:setFontColor({r = 121, g = 110, b = 86})

        self:updateNowDustNums()
    else
        local openMonster = mvc.bigSailPortModel:getIslandMonsterIsOpen()
        if openMonster then
            self.recordsTableView:setVisible(false)
            self.normalBtn:enable()
            self.normalBtn:setFontColor({r = 121, g = 110, b = 86})
            self.recordsLimitTableView:setVisible(true)
            self.limitBtn:disable()
            self.limitBtn:setFontColor({r = 220, g = 182, b = 80})

            self:updateNowDustNums()
        end
    end
end

function BigSailPortMerchantView:updateResidentshop()
    -- 常驻商店
    local petShopData = ConfigManager:getAllNavigationShopData()

    if not self.recordsTableView then
        local tableContentLayout = UI.Layout:create()
        tableContentLayout:init()
        tableContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
        tableContentLayout:center(0, 32)
        -- tableContentLayout:enableDebugDraw()
        self.contentLayout:addChild(tableContentLayout)

        -- local lineImg = UI.Image:create()
        -- lineImg:init("ui_pettreasure_record_mask.png")
        -- lineImg:leftBottom(28, 14)
        -- lineImg:setName("cellBg")
        -- self.contentLayout:addChild(lineImg, 100)

        self.recordsTableView = UI.TableView.new({}, 720, 440)
        self.recordsTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
        self.recordsTableView:center(0, -25)
        -- self.recordsTableView:enableDebugDraw()
        self.recordsTableView:setDelegate()
        self.recordsTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
        self.recordsTableView:setBounceable(true)
        self.recordsTableView:init()
        self.recordsTableView:onUpdateCellSize(function (table,idx)
            return ROW_WIDTH, ROW_HEIGHT
        end)

        self.recordsTableView:onUpdateCells(function (table, idx)
            local cell = table:dequeueCell()
            if cell then
                cell:removeAllChildren()
            end
            xpcall(function()
                if not cell then
                    cell = UI.TableViewCell:create()
                    cell:setContentSize(cc.size(ROW_WIDTH, ROW_HEIGHT))
                    self:updateGoodsRowCell(idx + 1, cell, SHOP_INDEX.NORMAL_SHOP)
                else
                    self:updateGoodsRowCell(idx + 1, cell, SHOP_INDEX.NORMAL_SHOP)
                end
            end, 
            function(e) 
                printError("BigSailPortMerchantView:updateGoodsRowCell, error")
            end, 1) 
            return cell
        end)

        self.recordsTableView:onUpdateCellNumbers(function ()
            return math.ceil(#petShopData / 5)
        end)

        tableContentLayout:addChild(self.recordsTableView)
    end

    self.recordsTableView:reloadData(true)
    self.recordsTableView:setVisible(false)

    local openMonster = mvc.bigSailPortModel:getIslandMonsterIsOpen()
    if not openMonster then
        self.limitBtn:setVisible(false)
    end
end

function BigSailPortMerchantView:updateLimitshop()
    -- 限时商店
    local petShopData = ConfigManager:getNavigationShopLimitTimeAllData()

    if not self.recordsLimitTableView then
        local tableContentLayout = UI.Layout:create()
        tableContentLayout:init()
        tableContentLayout:setSize(COM_WIDTH, COM_HEIGHT)
        tableContentLayout:center(0, 32)
        -- tableContentLayout:enableDebugDraw()
        self.contentLayout:addChild(tableContentLayout)

        -- local lineImg = UI.Image:create()
        -- lineImg:init("ui_pettreasure_record_mask.png")
        -- lineImg:leftBottom(28, 14)
        -- lineImg:setName("cellBg")
        -- self.contentLayout:addChild(lineImg, 100)

        self.recordsLimitTableView = UI.TableView.new({}, 720, 440)
        self.recordsLimitTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
        self.recordsLimitTableView:center(0, -25)
        -- self.recordsLimitTableView:enableDebugDraw()
        self.recordsLimitTableView:setDelegate()
        self.recordsLimitTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
        self.recordsLimitTableView:setBounceable(true)
        self.recordsLimitTableView:init()
        self.recordsLimitTableView:onUpdateCellSize(function (table,idx)
            return ROW_WIDTH, ROW_HEIGHT
        end)

        self.recordsLimitTableView:onUpdateCells(function (table, idx)
            local cell = table:dequeueCell()
            if cell then
                cell:removeAllChildren()
            end
            xpcall(function()
                if not cell then
                    cell = UI.TableViewCell:create()
                    cell:setContentSize(cc.size(ROW_WIDTH, ROW_HEIGHT))
                    self:updateGoodsRowCell(idx + 1, cell, SHOP_INDEX.LIMIT_SHOP)
                else
                    self:updateGoodsRowCell(idx + 1, cell, SHOP_INDEX.LIMIT_SHOP)
                end
            end, 
            function(e) 
                printError("BigSailPortMerchantView:updateGoodsRowCell, error")
            end, 1) 
            return cell
        end)

        self.recordsLimitTableView:onUpdateCellNumbers(function ()
            return math.ceil(#petShopData / 5)
        end)

        tableContentLayout:addChild(self.recordsLimitTableView)
    end

    self.recordsLimitTableView:reloadData(true)
    self.recordsLimitTableView:setVisible(false)
end

function BigSailPortMerchantView:initShopConfig()
    self.normalShopConf = clone(ConfigManager:getAllNavigationShopData())
    self.limitShopConf = clone(ConfigManager:getNavigationShopLimitTimeAllData())

    if #self.normalShopConf > 1 then
        table.sort(self.normalShopConf, function(a, b)
            return a.ID < b.ID
        end)
    end

    if #self.limitShopConf > 1 then
        table.sort(self.limitShopConf, function(a, b)
            return a.ID < b.ID
        end)
    end
end

function BigSailPortMerchantView:updateGoodsRowCell(index, cell, shopIndex)
    local petShopData = nil
    if shopIndex == SHOP_INDEX.NORMAL_SHOP then
        petShopData = self.normalShopConf
    else
        petShopData = self.limitShopConf
    end

    local cell = cell
    local RowCell = cell:getChildByName("RowCell")
    if not RowCell then
        RowCell = UI.Layout:create()
        RowCell:init()
        RowCell:setSize(ROW_WIDTH, ROW_HEIGHT)
        -- RowCell:enableDebugDraw()
        RowCell:centerRight(0)
        RowCell:setName("RowCell")
        cell:addChild(RowCell)
    end

    for itemIndex = 1, 5 do
        if petShopData[(index - 1) * 5 + itemIndex] then
            self:updateItem(itemIndex, petShopData[(index - 1) * 5 + itemIndex], RowCell, shopIndex)
        else
            self:updateItem(itemIndex, nil, RowCell, shopIndex)
        end
    end

    return cell
end

function BigSailPortMerchantView:updateItem(index, data, RowCell, shopIndex)

    if not data then
        if RowCell.itemArr and RowCell.itemArr[index] then
            local itemImg = RowCell.itemArr[index]
            itemImg:hide()
        end
        return
    end

    local baseInfo2 = mvc.bigSailPortModel:getBaseData()
    local storeInfo = nil
    if shopIndex == SHOP_INDEX.NORMAL_SHOP then
        storeInfo = baseInfo2.limitStoreinfo
    else
        storeInfo = baseInfo2.activityStoreinfo
    end


    --local baseInfo2 = mvc.bigSailPortModel:getBaseData()
    local isShowGoods = false
    for k,v in pairs(storeInfo) do
        if v.cfgId == data.ID then
            isShowGoods = true
        end
    end
    if not isShowGoods then
        -- 判断是否是随机到的需要展示限购商品
        print("not isShowGoods")
        return
    end

    if not RowCell.itemArr then
        RowCell.itemArr = {}
    end

    local itemImg = RowCell.itemArr[index]
    if not itemImg then
        itemImg = UI.Image:create()
        itemImg:init("ui_dreamword_paper_2.png")
        itemImg:centerLeft(index * 140 - 130, -16)
        itemImg:setName("itemImg")
        RowCell:addChild(itemImg)

        itemImg:setTouchEnable(true)
        itemImg:setSwallowTouches(false)
        itemImg:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, target, touchPosition)
            if itemImg:checkTouchPosition(touchPosition) then
                self:goodItemClick(data.goodsID, touchPosition)
            end
        end)

        RowCell.itemArr[index] = itemImg
    end
    itemImg:show()

    local goodObj = GoodsDataManager:createLocalGoodsData(data.goodsID)
    if(goodObj == nil) then 
        return
    end
    goodObj:setNum(data.goodsNum)
    local needObj = GoodsDataManager:createLocalGoodsData(data.materialID)
    if(needObj == nil) then 
        return
    end
    needObj:setNum(data.materialNum)

    local GoodImg = itemImg:getChildByName("GoodImg")
    if not GoodImg then
        GoodImg = UI.Image:create()
        GoodImg:init(goodObj:getIconName())
        GoodImg:center()
        GoodImg:setName("GoodImg")
        itemImg:addChild(GoodImg)
    end

    -- 判断是否限购和限购次数等
    local canBuyNum = 0
    local onceTimes = 0
    for k,v in pairs(storeInfo) do
        if v.cfgId == data.ID then
            isLimit = true
            --local config = ConfigManager:getNavigationShopByID(v.cfgId)

            local config = nil
            if shopIndex == SHOP_INDEX.NORMAL_SHOP then
                config = ConfigManager:getNavigationShopByID(v.cfgId)
            else
                config = ConfigManager:getNavigationShopLimitTimeByID(v.cfgId)
            end

            onceTimes = config.goodsNum
            if (config.purchaseLimitNum - v.buyNum) <= 0 then
                -- 限购且已售完
                canBuyNum = 0
                break
            else
                canBuyNum = config.purchaseLimitNum - v.buyNum
                break
            end
        end
    end

    local GoodNumBg = UI.Image:create()
    GoodNumBg:init("ui_greatnavigation_lable2.png")
    GoodNumBg:centerLeft(65, -27)
    itemImg:addChild(GoodNumBg)

    local GoodNum = itemImg:getChildByName("GoodNum")
    if not GoodNum then
        GoodNum = UI.Text:create()
        GoodNum:init("0", UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 229, g = 173, b = 86})
        --GoodNum:setRotation(3)
        GoodNum:centerLeft(110, -27)
        GoodNum:setTextLeft()
        GoodNum:setName("GoodNum")
        itemImg:addChild(GoodNum)
    end
    GoodNum:setText(": " .. tostring(canBuyNum))

    GoodNum2 = UI.Text:create()
    GoodNum2:init(UI.TEXT_226162, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 229, g = 173, b = 86})
    --GoodNum2:setRotation(3)
    --GoodNum2:setTextRight()
    GoodNum2:centerLeft(-33, 0)
    GoodNum:addChild(GoodNum2)

    -- 购买一次获得的数量
    local buyOnceNums = UI.Text:create()
    buyOnceNums:init("x" .. tostring(onceTimes), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    buyOnceNums:setRotation(3)
    buyOnceNums:setTextRight()
    buyOnceNums:rightBottom(10, 10)
    itemImg:addChild(buyOnceNums)

    -- 卖光了提示
    local sellOutBg = UI.Image:create()
    sellOutBg:init("ui_catfood_seal.png")
    sellOutBg:center(0, 0)
    itemImg:addChild(sellOutBg)

    local sellOutTxt = UI.Text:create()
    sellOutTxt:init(UI.TEXT_1212304, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r = 154, g = 21, b = 20})
    sellOutTxt:setRotation(15)
    sellOutTxt:setTextRight()
    sellOutTxt:center(0, 1)
    sellOutBg:addChild(sellOutTxt)
    sellOutBg:setVisible(false)

    if canBuyNum == 0 then
        sellOutBg:setVisible(true)
        GoodImg:setVisible(false)
    end

    local buyBtn = itemImg:getChildByName("buyBtn")
    if not buyBtn then
        buyBtn = UI.Button:create()
        buyBtn:init("ui_btn_yellow9_0.png","ui_btn_yellow9_1.png","ui_btn_yellow9_2.png")
        buyBtn:centerBottom(-48)
        buyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            -- -- 兑换材料不足
            -- if self.dustTotalNum < data.materialNum then
            --     UI.ScrollBar:createByText(UI.TEXT_226161)
            --     return
            -- end
            
            -- 背包空间不足
            local goodArr = {{
                goodsID = data.goodsID,
                num = data.goodsNum,
                isGolden = false
            }}
            if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodArr) then
                UI.ScrollBar:createByText(UI.TEXT_1212306)
                return
            end

            local richTextLayout = self:createRichText(data)
            local okCallBack = function (purchase)

                -- if self.shopIndex == SHOP_INDEX.NORMAL_SHOP then
                --     -- 兑换材料不足
                --     if self.dustTotalNum < data.materialNum * purchase then
                --         UI.ScrollBar:createByText(UI.TEXT_226161)
                --         return
                --     end
                -- else
                --     -- 兑换材料不足
                --     local betItemNum = mvc.bigSailPortModel:getBaseData().betItemNum
                --     if betItemNum < data.materialNum * purchase then
                --         UI.ScrollBar:createByText(UI.TEXT_226161)
                --         return
                --     end
                -- end
                
                -- 判断是否限购和限购次数等
                local canBuyNum2 = 0
                for k,v in pairs(storeInfo) do
                    if v.cfgId == data.ID then
                        ---local config = ConfigManager:getNavigationShopByID(v.cfgId)
                        local config = nil
                        if shopIndex == SHOP_INDEX.NORMAL_SHOP then
                            config = ConfigManager:getNavigationShopByID(v.cfgId)
                        else
                            config = ConfigManager:getNavigationShopLimitTimeByID(v.cfgId)
                        end

                        if (config.purchaseLimitNum - v.buyNum) <= 0 then
                            -- 限购且已售完
                            canBuyNum2 = 0
                            GoodNum:setText("x" .. tostring(canBuyNum2))
                            buyBtn:setBtnStatus(ButtonState.DISABLE)
                            return
                        else
                            canBuyNum2 = config.purchaseLimitNum - v.buyNum - (purchase or 1)
                            if canBuyNum2 <= 0 then
                                buyBtn:setBtnStatus(ButtonState.DISABLE)
                            end
                            GoodNum:setText("x" .. tostring(canBuyNum2))
                            break
                        end
                    end
                end

                if canBuyNum2 <= 0 then
                    sellOutBg:setVisible(true)
                    GoodImg:setVisible(false)
                end


                local messageData = {
                    id = data.ID,
                    num = purchase or 1,
                    storeType = shopIndex
                }
                Net.NetBigSailSystem:reqBuyStore(messageData)
            end

            -- UI.TipsLayer:onShowCommonRichTextHandler(richTextLayout, okCallBack, nil, nil, false)

            -- UI.TipsLayer:onCommonBulkPurchaseTips(okCallBack, function()
            -- end, self._commonShopType, purchasedNum, {profileData = self.data, itemId = itemId})

            local maxBuyNum = 0
            if tonumber(data.materialID) == 23510001 then
                -- 兑换材料不足
                local betItemNum = mvc.bigSailPortModel:getBaseData().betItemNum
                maxBuyNum = math.floor(betItemNum/data.materialNum)
                -- print("maxBuyNum ==== maxBuyNum ==== ",maxBuyNum)
            elseif tonumber(data.materialID) == 23500001 then
                local activityDebris = mvc.bigSailPortModel:getBaseData().activityDebris
                maxBuyNum = math.floor(activityDebris/data.materialNum)
            else
                maxBuyNum = math.floor(self.dustTotalNum/data.materialNum)
                -- print("   self.dustTotalNum ====  ",self.dustTotalNum,data.materialNum,maxBuyNum)
            end

            if maxBuyNum > canBuyNum then
                maxBuyNum = canBuyNum
            end

            if maxBuyNum <= 0 then
                UI.ScrollBar:createByText(UI.TEXT_226161)
                return
            else
                UI.TipsLayer:onNumChoice(okCallBack, nil, 1, maxBuyNum, 1, UI.TEXT_227800)
            end
        end)
        buyBtn:setName("buyBtn")
        buyBtn:setSwallowTouches(false)
        itemImg:addChild(buyBtn, 200)
    end

    -- 判断是否限购和限购次数等
    local isLimit = false
    local limitNum = 0
    for k,v in pairs(storeInfo) do
        if v.cfgId == data.ID then
            isLimit = true
            --local config = ConfigManager:getNavigationShopByID(v.cfgId)
            local config = nil
            if shopIndex == SHOP_INDEX.NORMAL_SHOP then
                config = ConfigManager:getNavigationShopByID(v.cfgId)
            else
                config = ConfigManager:getNavigationShopLimitTimeByID(v.cfgId)
            end

            if (config.purchaseLimitNum - v.buyNum) <= 0 then
                -- 限购且已售完
                limitNum = 0
                buyBtn:setBtnStatus(ButtonState.DISABLE)
            end
        end
    end

    local needImg = buyBtn._text:getChildByName("needImg")
    if not needImg then
        needImg = UI.Image:create()
        needImg:init(needObj:getSmallIconName())
        needImg:centerLeft(-50)
        needImg:setName("needImg")
        buyBtn._text:addChild(needImg)
    end

    local needNum = buyBtn._text:getChildByName("needNum")
    if not needNum then
        needNum = UI.Text:create()
        needNum:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        needNum:setTextLeft()
        needNum:centerLeft(-20)
        needNum:setName("needNum")
        buyBtn._text:addChild(needNum)
    end
    needNum:setText(tostring(needObj:getNum()))

    local totalLength = needImg:getContentSize().width + needNum:getContentSize().width + 6
    needImg:centerLeft(- totalLength / 2)
    needNum:centerLeft(- totalLength / 2 + needImg:getContentSize().width + 6)
end

function BigSailPortMerchantView:goodItemClick(goodId, point)
    if not goodId then
        return
    end

    local pInfoArea = nil
    local goodsData = GoodsDataManager:createLocalGoodsData(goodId)

    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
        -- 装备详情
        pInfoArea = UI.EquipmentInfoArea:create()
        pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
        pInfoArea:hideCompInfo()
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
        pInfoArea = UI.EquipmentPetInfoArea:create()
        pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
        pInfoArea:hideCompInfo()
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
        -- 道具详情界面
        local itemType = goodsData:getItemType()
        if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
            pInfoArea = UI.SelectGoodsBagInfoArea:create()
        elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then
            pInfoArea = UI.RandomBagInfoArea:create()
        elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then
            pInfoArea = UI.LevelBagInfoArea:create()
            pInfoArea:lockNextLevelBag()
            pInfoArea:disableUse()
        else
            pInfoArea = UI.PropInfoArea:create(true)
        end
        pInfoArea:init(UI.PROP_MATER.PROPINFO)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
        -- 材料详情界面
        if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then 
            pInfoArea = UI.PropInfoArea:create(true)
        else 
            pInfoArea = UI.MaterialEquipScrollInfoArea:create()
        end
        pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
        pInfoArea = UI.PropInfoArea:create(true)
        pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
        -- 虚拟物品详情界面
        if(goodsData:getCanBeView()) then 
            pInfoArea = UI.PropInfoArea:create(true)
            pInfoArea:init(UI.PROP_MATER.VIRTUALITEM_INFO)
            pInfoArea:setHideLink(true)
        else
            return
        end
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
        -- 宝石详情界面
        pInfoArea = UI.GemStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
        -- 宝石详情界面
        pInfoArea = UI.StarPrayInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
        pInfoArea = UI.PetStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then 
        pInfoArea = UI.GlyphInfoArea:create()
        pInfoArea:init(goodsData)
    else
        return
    end

    pInfoArea:setVisible(true)
    pInfoArea:updateView(goodsData)
    pInfoArea:closeLockFlag()
    pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        pInfoArea:close();
    end)

    local winSize = cc.Director:getInstance():getWinSize()
    local size = pInfoArea:getContentSize()
    local delta = 0
    if point.x > winSize.width*2/3 then
        delta = size.width + 20
    end
    pInfoArea:leftBottom(point.x+10-delta, point.y)

    if point.y + size.height > winSize.height then
        pInfoArea:leftBottom(pInfoArea:getLeft(), winSize.height - size.height - 50)
    end
    pInfoArea:setName("INFO_AREA")

    UI.UIManager:addToRootNode(pInfoArea, UI_ZORDER.TIPS)
end

function BigSailPortMerchantView:updateNowDustNums()
    if self.shopIndex == SHOP_INDEX.NORMAL_SHOP then
        -- 粉尘图标
        local config2 = ConfigManager:getAllNavigationShopData()
        local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(config2[1].materialID))
        self.dustIcon:setSpriteName(goodsData.miniIcon)
        self:updateDustNum()
    elseif self.shopIndex == SHOP_INDEX.LIMIT_SHOP then
        -- 粉尘图标
        local config2 = ConfigManager:getNavigationShopLimitTimeAllData()
        local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(config2[1].materialID))
        self.dustIcon:setSpriteName(goodsData.miniIcon)
        self:updateDustLimitNum()
    end
end

function BigSailPortMerchantView:updateDustNum()
    self.dustTotalNum = mvc.bigSailPortModel:getBaseData().debris
    self.dustNum:setText(self.dustNum:numformat(string.format("%s", self.dustTotalNum)))
    self.dustNum:updateView()


    if self.guesNum then
        local betItemNum = mvc.bigSailPortModel:getBaseData().betItemNum
        self.guesNum:setText(self.guesNum:numformat(string.format("%s", betItemNum)))
        self.guesNum:updateView()
    end
end

function BigSailPortMerchantView:updateDustLimitNum()
    self.dustTotalNum = mvc.bigSailPortModel:getBaseData().activityDebris
    self.dustNum:setText(self.dustNum:numformat(string.format("%s", self.dustTotalNum)))
    self.dustNum:updateView()

    if self.guesNum then
        local betItemNum = mvc.bigSailPortModel:getBaseData().betItemNum
        self.guesNum:setText(self.guesNum:numformat(string.format("%s", betItemNum)))
        self.guesNum:updateView()
    end
end

function BigSailPortMerchantView:createRichText(data)
    local textLayout = UI.Layout:create()
    textLayout:init()
    textLayout:setSize(354, 120)
    -- textLayout:enableDebugDraw()
    textLayout:center()

    local limitLayout = UI.Layout:create()
    limitLayout:init()
    limitLayout:center()
    textLayout:addChild(limitLayout)

    local longText = UI.Text:create()
    longText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    longText:centerUp(8)
    longText:autoAdapt()
    longText:hide()
    limitLayout:addChild(longText)

    local limitText = UI.Text:create()
    limitText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    limitText:centerUp(8)
    limitText:setWidth(354)
    limitText:hide()
    limitLayout:addChild(limitText)

    local limitImg = UI.Image:create()
    limitImg:init("ui_information_btn_yes.png")
    limitImg:center()
    limitImg:hide()
    limitLayout:addChild(limitImg)

    local content = AvalonUtil:serializeText(UI.TEXT_1212302, UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)

    local curPosY = 22
    local curHeight = 28
    local textWidth = 0
    longText:setText(UI.TEXT_1212302)
    textWidth = textWidth + longText:getContentSize().width

    if textWidth > 354 then
        curHeight = math.ceil((textWidth + 2)/354) * 28
        textWidth = 354
    end

    local richtext = UI.RichText:create()
    local success = richtext:init(content, textWidth, curHeight, false)
    if success then
        richtext:centerUp(curPosY)
        -- richtext:enableDebugDraw()
        textLayout:addChild(richtext)
    end
    curPosY = curPosY + curHeight + 4
    local content = AvalonUtil:serializeText(UI.TEXT_1212303, UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)
    content = content .. AvalonUtil:serializeImage("symbol_gaming_"..data.materialID..".png")
    content = content .. AvalonUtil:serializeText(longText:numformat(tostring(data.materialNum)), UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)

    local curHeight = 28
    local textWidth = 0
    longText:setText(UI.TEXT_1212303)
    textWidth = textWidth + longText:getContentSize().width
    --limitImg:setSpriteName("symbol_gaming_"..data.materialID..".png")
    limitImg:setSpriteName("symbol_gaming_"..data.materialID..".png")
    textWidth = textWidth + limitImg:getContentSize().width
    longText:setText(longText:numformat(tostring(data.materialNum)))
    textWidth = textWidth + longText:getContentSize().width
    if textWidth > 354 then
        curHeight = math.ceil((textWidth + 2)/354) * 28
        textWidth = 354
    end

    local richtext = UI.RichText:create()
    local success = richtext:init(content, textWidth, curHeight, false)
    if success then
        richtext:centerUp(curPosY)
        -- richtext:enableDebugDraw()
        textLayout:addChild(richtext)
    end

    limitLayout:removeFromParent(false)

    return textLayout
end

function BigSailPortMerchantView:reloadItem()
    if self.recordsTableView then
        self.recordsTableView:reloadData(false)
    end

    if self.recordsLimitTableView then
        self.recordsLimitTableView:reloadData(false)
    end
end

function BigSailPortMerchantView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_REFRESH_MATERAIL_DATA, self, self.updateNowDustNums)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_COMMON_REWARD, self, self.reloadItem) 
end

function BigSailPortMerchantView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_REFRESH_MATERAIL_DATA, self, self.updateNowDustNums)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_COMMON_REWARD, self, self.reloadItem) 
end


return BigSailPortMerchantView


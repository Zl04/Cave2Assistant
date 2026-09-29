------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/06/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RecyclingShopGoodsLayer = class("RecyclingShopGoodsLayer", UI.HWBtnComponent)

local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")

local COM_WIDTH = 705
local COM_HEIGHT = 436
local ROW_WIDTH = 705
local ROW_HEIGHT = 220
local DUST_ID = 22070570


function RecyclingShopGoodsLayer:ctor()
    RecyclingShopGoodsLayer.super.ctor(
    	self,
    	UI.Type.PET_RECYCLING_SHOP,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function RecyclingShopGoodsLayer:init()
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    RecyclingShopGoodsLayer.super.init(self)
end

function RecyclingShopGoodsLayer:dtor()
    RecyclingShopGoodsLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pettreasure.recyclingshop.RecyclingShopGoodsLayer")
end

function RecyclingShopGoodsLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- -- 内部背景图片
    -- local innerBG  = UI.Image:create()
    -- innerBG:init("ui_pettreasure_record_bg.png")
    -- innerBG:leftUp(28, 16)
    -- contentLayout:addChild(innerBG)
    -- self.innerBG = innerBG

    self:updateLayer()
end

function RecyclingShopGoodsLayer:updateLayer()

    local pk = RoleDataManager:getMaster():getPK()
    self.dustTotalNum = tonumber(GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, DUST_ID))

    -- 加载物资列表
    self:updateGoodsList()
end

function RecyclingShopGoodsLayer:updateGoodsList()
    local petShopData = ConfigManager:getPetShopData()

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
        self.recordsTableView:centerBottom(8)
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

                    self:updateGoodsRowCell(idx + 1, cell)
                else
                    self:updateGoodsRowCell(idx + 1, cell)
                end
            end, 
            function(e) 
                printInfo("RecyclingShopGoodsLayer:updateGoodsRowCell, error")
            end, 1) 
            return cell
        end)

        self.recordsTableView:onUpdateCellNumbers(function ()
            return math.ceil(#petShopData / 5)
        end)

        tableContentLayout:addChild(self.recordsTableView)
    end

    self.recordsTableView:reloadData(true)
end

function RecyclingShopGoodsLayer:updateGoodsRowCell(index, cell)
    local petShopData = ConfigManager:getPetShopData()

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
            self:updateItem(itemIndex, petShopData[(index - 1) * 5 + itemIndex], RowCell)
        else
            self:updateItem(itemIndex, nil, RowCell)
        end
    end

    return cell
end

function RecyclingShopGoodsLayer:updateItem(index, data, RowCell)

    if not data then
        if RowCell.itemArr and RowCell.itemArr[index] then
            local itemImg = RowCell.itemArr[index]
            itemImg:hide()
        end
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

    local GoodNum = itemImg:getChildByName("GoodNum")
    if not GoodNum then
        GoodNum = UI.Text:create()
        GoodNum:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        GoodNum:setRotation(3)
        GoodNum:setTextRight()
        GoodNum:rightBottom(10, 10)
        GoodNum:setName("GoodNum")
        itemImg:addChild(GoodNum)
    end
    GoodNum:setText("x" .. tostring(goodObj:getNum()))

    local buyBtn = itemImg:getChildByName("buyBtn")
    if not buyBtn then
        buyBtn = UI.Button:create()
        buyBtn:init("ui_btn_yellow9_0.png","ui_btn_yellow9_1.png","ui_btn_yellow9_2.png")
        buyBtn:centerBottom(-48)
        buyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if not (SceneManager:getInstance():isNotInFightScene()) then
                UI.ScrollBar:createByText(UI.TEXT_1213665)
                return
            end

            -- 兑换材料不足
            if self.dustTotalNum < data.materialNum then
                UI.ScrollBar:createByText(UI.TEXT_1324200)
                return
            end

            -- 兑换材料被锁定
            if self:getDustIsLock() then
                UI.ScrollBar:createByText(UI.TEXT_1212614)
                return
            end

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

            local showNoMoreKey = "recyclingShopBuyConfirm"..GameDataManager:getInstance():getMasterPK()
            local canNotice = cc.UserDefault:getInstance():getBoolForKey(showNoMoreKey, true)
            if canNotice then
                local richTextLayout = self:createRichText(data.materialNum)
                local okCallBack = function ()
                    UI.WaitingLayer:showWaiting(true, nil, 5)
                    mvc.send("PetTreasure_RecyclingShop_Send_GoodsRecycle", data.shopType, data.ID)
                end

                UI.TipsLayer:onShowCommonRichTextHandler(richTextLayout, okCallBack, nil, nil, showNoMoreKey)
            else
                UI.WaitingLayer:showWaiting(true, nil, 5)
                mvc.send("PetTreasure_RecyclingShop_Send_GoodsRecycle", data.shopType, data.ID)
            end

        end)
        buyBtn:setName("buyBtn")
        itemImg:addChild(buyBtn, 200)
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

function RecyclingShopGoodsLayer:createRichText(dustNum)
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
    content = content .. AvalonUtil:serializeImage("symbol_gaming_souldust.png")
    content = content .. AvalonUtil:serializeText(longText:numformat(tostring(dustNum)), UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)

    local curHeight = 28
    local textWidth = 0
    longText:setText(UI.TEXT_1212303)
    textWidth = textWidth + longText:getContentSize().width
    limitImg:setSpriteName("symbol_gaming_souldust.png")
    textWidth = textWidth + limitImg:getContentSize().width
    longText:setText(longText:numformat(tostring(dustNum)))
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

function RecyclingShopGoodsLayer:getDustIsLock()
    local pk = RoleDataManager:getMaster():getPK()
    local dustData = GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden(
        pk,
        PublicDefine.PACKET_TYPE.PACKET_BAG, 
        GoodsDataManager:getGoodsTypeForGoodsID(DUST_ID), 
        DUST_ID,
        false
    )
    return dustData:getIsLock()
end

function RecyclingShopGoodsLayer:goodItemClick(goodId, point)
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


function RecyclingShopGoodsLayer:bindModel()

end

function RecyclingShopGoodsLayer:unbindModel()

end

return RecyclingShopGoodsLayer
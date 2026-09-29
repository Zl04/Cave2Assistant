-- CaveShopPanel.lua
-- Author:zp
-- 2017年5月17日
-- Using:洞穴商店

require "app.ui.common.ScrollView"
require "app.ui.common.List.ListView"
require "app.ui.common.GridList.GridList"
require "app.ui.shoplayer.ShopGrid"
require "app.ui.shoplayer.BagGoodsPanel"

local ProtobufUtil = require "utils.ProtobufUtil"

local winSize = cc.Director:getInstance():getWinSize()
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
local VIRTUAL_ITEM_TYPE = PublicDefine.VIRTUAL_ITEM_TYPE

local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local CaveShopPanel = class("CaveShopPanel", UI.DoorWin)
UI.CaveShopPanel = CaveShopPanel

local DEBUG = true

-- 资源文件
local COM_RES_LIST = {
    "ui_general_shop.plist",
}

local LAYOUT_DESIGN_WIDTH = 1024
local LAYOUT_FUNCTION_HEIGHT = 640

local LAYOUT_SCROLL_WIDTH = 250
local LAYOUT_SCROLL_HEIGHT = 500

local LEFT_WIDTH = 345
local LEFT_HEIGHT = 617


local SHOP_LAYOUT = {
    -- 背包格子初始化信息
    GOODS_GRID_INIT_COLUMN = 5,
    GOODS_GRID_INIT_ROW = 10,
    GOODS_GRID_WIDTH = 70,
    GOODS_GRID_HEIGHT = 70+44,
    GOODS_GRID_HORIZONTAL_SPACE = 32,
    GOODS_GRID_VERTICAL_SPACE = 0,
    GOODS_GRID_PADDING_SPACE = 14
}


local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

local function refreshCaveShopData(self, dataList)
    if(dataList) then
        local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_CAVE_SHOP_BUY)
        if(repeatData) then
            for k, goodsData in pairs(dataList) do
                goodsData:setUseNum(0)
                if(repeatData[goodsData:getGoodsNo()] ~= nil) then
                    goodsData:setUseNum(repeatData[goodsData:getGoodsNo()])
                    -- print("dddddddddddd refreshCaveShopData", repeatData[goodsData:getGoodsNo()], goodsData:getGoodsNo(), goodsData:getNum())
                end
            end
        else 
            for k, goodsData in pairs(dataList) do
                goodsData:setUseNum(0)
            end
        end
    end
end

local function buySuccess(self, data)
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 

    UI.WaitingLayer:hideWaiting()

    -- 处理一下数据修改
    local goodsID = nil
    if(self._shopDataList) then
        if(data.result == "BuyGoodsResult_Succeed") then
            for i=1,#self._shopDataList,1 do 
                local oneData = self._shopDataList[i]
                if(oneData.goodsNo == data.goodsNo) then
                    goodsID = oneData.goodsID
                    local num = oneData:getNum() - data.goodsQuantity
                    if(num <=0) then
                        table.remove(self._shopDataList,i)
                        break
                    else 
                        oneData:setNum(num)
                    end
                end
            end
        end 
        -- 刷新数据
        if(#self._shopDataList>0) then
            self._buyEndLabel:setVisible(false)
        else
            self._buyEndLabel:setVisible(true)
        end

        refreshCaveShopData(self, self._shopDataList)

        self._shopGridList:setData(self._shopDataList)
    end

    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.BuyGoodsResult", data.result))
end

function CaveShopPanel:ctor()
    CaveShopPanel.super.ctor(self, UIType.CAVE_SHOP_PANEL, COM_RES_LIST, LEFT_WIDTH, LEFT_HEIGHT)
    self._shopGridList = nil
    self._buyEndLabel = nil
    self._bagGridList = nil
    self._isScrolling = false
    self._isDraging = false
    self._leftGrid = nil 

    self._runTime = 0.2
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CAVE_SHOP_DATA_CHANGE, self, buySuccess)
end

function CaveShopPanel:dtor()
    CaveShopPanel.super.dtor(self)
    self._shopGridList = nil
    self._buyEndLabel = nil
    self._bagGridList = nil
    self._isScrolling = false
    self._isDraging = false
    self._leftGrid = nil 

    UI.WaitingLayer:hideWaiting()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CAVE_SHOP_DATA_CHANGE, self, buySuccess)
end

function CaveShopPanel:getInitCaveShopData(level)
    local shopDataList = GameDataManager:getInstance():getInCaveShopAllGoodsForLevel(level)
    local shopBuyList =  RoleDataManager:getCaveShopData()
    -- print(string.format("CaveShopPanel:getInitCaveShopData",level))

    if(shopDataList == nil) then 
        shopDataList = {}
    end

    if(shopBuyList) then
        local removeKey = {}
        for i=1,#shopDataList,1 do 
            local oneData = shopDataList[i]
            for j=1,#shopBuyList,1 do
                local buyData = shopBuyList[j]
                if(oneData.goodsNo == buyData.goodsNo) then
                    local num = oneData:getNum() - buyData.goodsQuantity
                    if(num <=0) then
                        table.insert(removeKey,i)
                    else 
                        oneData:setNum(num)
                    end
                end
            end
        end
        -- 移除数据
        if(removeKey) then
            for i=#removeKey,1,-1 do
                table.remove(shopDataList, removeKey[i])
            end
        end
    end

    return shopDataList
end

-- public:
-- 初始化
function CaveShopPanel:init(spriteID)
    self:setInterceptTouches(true)
    self:setTouchEnable(true)

    self._spriteID = spriteID

    CaveShopPanel.super.init(self)
end

-- 模版函数：初始化组建的视图
function CaveShopPanel:onInitView()
    local scale = computeLayoutScale(winSize.width, LAYOUT_DESIGN_WIDTH)

    local runTime = self._runTime

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:centerLeft(0)
    contentLayout:setSize(winSize.width, winSize.height)
    contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 添加左边商店相关数据
    local titleLayout = UI.Layout:create()
    titleLayout:init()
    titleLayout:setSize(198, 750)
    -- titleLayout:centerLeft(0)
    self._contentLayout:addChild(titleLayout)
    self._titleLayout = titleLayout

    -- 背景框
    local shopImageBG = UI.Image:create()
    shopImageBG:init("ui_shop_bg.png")
    shopImageBG:centerLeft(0)
    shopImageBG:setTouchEnable(true)
    titleLayout:addChild(shopImageBG, 1)

    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(200, 544)
    leftLayout:leftBottom(47, 15)
    shopImageBG:addChild(leftLayout)

    -- -- 底部装饰
    -- local bottomEstrade = UI.Image:create()
    -- bottomEstrade:init("ui_shop_estrade.png")
    -- bottomEstrade:centerBottom(0)
    -- leftLayout:addChild(bottomEstrade)

    -- 左边组件
    local gridList = UI.GridList:create()
    gridList:enableCreateBg(true, "ui_shop_lattice.png")
    gridList:init(UI.ShopGrid, 2, 4, SHOP_LAYOUT.GOODS_GRID_WIDTH, SHOP_LAYOUT.GOODS_GRID_HEIGHT, SHOP_LAYOUT.GOODS_GRID_HORIZONTAL_SPACE, SHOP_LAYOUT.GOODS_GRID_VERTICAL_SPACE, SHOP_LAYOUT.GOODS_GRID_PADDING_SPACE)
    gridList:setSize(200 + 28, 471+ 43)
    gridList:centerBottom(30)
    gridList:setCallbackForGridDragBegan(self, self.shopDragBeganCallback)
    gridList:setCallbackForGridDragMoved(self, self.shopDragMovedCallback)
    gridList:setCallbackForGridDragEnded(self, self.shopDragEndedCallback)
    gridList:setCallbackForGridClick(self, self.shopClickCallback)
    self._shopGridList = gridList
    leftLayout:addChild(gridList)
    gridList:setScrollBarEnabled(true)
    gridList:setScrollBarWidth(5)
    gridList:setScrollBarColor(UI.SLIDER_COLOR_Light)
    gridList:setCircleVisible(false)


    -- 遮罩
    local mask = UI.Image:create()
    mask:init("ui_shop_gradually_1.png")
    mask:centerBottom(20)
    leftLayout:addChild(mask)

    local gaveLock = UI.Image:create()
    gaveLock:init("ui_shop_gavelock.png")
    gaveLock:centerBottom(0)
    leftLayout:addChild(gaveLock)

    -- 添加售罄的标志
    local buyEndLabel = UI.Text:create()
    buyEndLabel:init(LanguageManager:getInstance():getLocalString(1110251), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_155_155_155)
    -- buyEndLabel:init("1234")
    buyEndLabel:centerBottom(504/2 - buyEndLabel:getContentSize().height/2)
    buyEndLabel:setTextCenter()
    leftLayout:addChild(buyEndLabel)
    self._buyEndLabel = buyEndLabel

    -- TODO 优化获取当前楼层
    local level = GameMapManager:getInstance():getMapData().level
    print(string.format("CaveShopPanel:onInitView() level=%d",level))
    local shopDataList = self:getInitCaveShopData(level)

    if(#shopDataList > 0 )then
        self._buyEndLabel:setVisible(false)
    end
    
    -- 剔除已经获得的碎片
    local removeArr = {}
    for k,goodsData in pairs(shopDataList) do
        if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM and goodsData:getVirtualType() == VIRTUAL_ITEM_TYPE.VirtualItemTreasureMapDebris) then
            local isGet = MasterDataManager:fragmentIsGet(goodsData:getGoodsID())
            print("ddddddddd ", isGet, goodsData:getGoodsID())
            if(isGet == false) then
                table.insert(removeArr, goodsData)
            end
        end
    end

    local num = #shopDataList
    dump(removeArr)
    
    if(#removeArr >0) then
        for _,removeData in pairs(removeArr) do
            for k,goodsData in pairs(shopDataList) do
                if(removeData.goodsNo == goodsData.goodsNo) then
                    table.remove(shopDataList, k)
                    break
                end
            end
        end
    end

    refreshCaveShopData(self, shopDataList)
    gridList:setData(shopDataList)
    self._shopDataList = shopDataList


    -- 右边背包数据
    local bagList = UI.BagGoodsPanel:create(nil,false,false)
    bagList:init(self._spriteID, GameBagUIType.CAVE_SHOP)
    -- bagList:centerRight(-bagList:getSize())
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

    self._bagGridList = bagList
    self._contentLayout:addChild(bagList,2)
    bagList:setUseLock(false)

    GameManager:showNPCInfomation(self._spriteID, LanguageManager:getInstance():getLocalString(1110420))
    self:setDoorNode(titleLayout, bagList)

end

-- 模版函数：组件尺寸更新
function CaveShopPanel:onSizeChanged(originalWidth, originalHeight)

end

function CaveShopPanel:shopDragBeganCallback(grid, touchPosition)
    -- print("CaveShopPanel:dragBeganCallback")
    self._isDraging = true
    if(grid) then
        grid:hideSelect()
    end
    if(self._bagGridList) then
        self._bagGridList:showMove()
    end
    self._bagGridList:setSpineBgVisible(true)
end

function CaveShopPanel:shopDragMovedCallback(grid, touchPosition)
    -- print("CaveShopPanel:dragMovedCallback")
    if(self._shopGridList) then 
        self._shopGridList:changeInSideStatus( not self._shopGridList:checkTouchPosition(touchPosition))
    end
end

function CaveShopPanel:shopDragEndedCallback(grid, touchPosition)
    -- print("CaveShopPanel:dragEndedCallback",grid,touchPosition)
    self._isDraging = false
    if(self._shopGridList) then
        Avalon.AudioManager:playSound("1505")

        if(self._shopGridList:checkTouchPosition(touchPosition) == false) then
            -- 处理购买
            if(grid and grid.__cname == "ShopGrid") then
                local goodsData = grid:getData()
                if(goodsData) then
                    if RoleBehaviorManager:caveShopNpcCheck() then
                        printWarn(" been blocked when using cave shop npc function buy goods ! goodsId = "..goodsData:getId())
                        return 
                    end
                    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                        or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                        self:sendBuyRequest(goodsData, 1, grid, true)
                    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
                        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM or 
                        goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
                        if(goodsData:getNum()  - goodsData:getUseNum() == 1) then
                             self:sendBuyRequest(goodsData, 1, grid, true)
                        elseif (goodsData:getNum()  - goodsData:getUseNum() > 1) then
                            function okCallback(num)
                                local buyNum = 0
                                if(num ~= nil) then
                                    buyNum = num
                                end
                                if(not tolua.isnull(self)) then
                                    self:sendBuyRequest(goodsData, buyNum, grid, false)
                                end
                            end
                            function cancelCallback()
                                
                            end

                            local price = GameDataManager:getInstance():calculationShopGoldPriceSale(goodsData:getBuyPrice(), goodsData:getCostType())

                            UI.TipsLayer:onBuyAmount(okCallback, cancelCallback, price,goodsData:getCostType(),goodsData:getNum() - goodsData:getUseNum())
                        end
                    end
                end
            end
        end
    end

    if(self._bagGridList) then
        self._bagGridList:hideMove()
    end
    self._bagGridList:setSpineBgVisible(false)
end

function CaveShopPanel:sendBuyRequest(goodsData,num,grid, isShowConfireTip)
    print("CaveShopPanel:sendBuyRequest ",goodsData:getGoodsID(),num)
    -- 处理发送购买消息
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 

    -- 先判断背包是否够用
    local enough = GameDataManager:getInstance():judgeEnoughPacket(goodsData:getGoodsID(), num, false)
    if(enough) then
        price = GameDataManager:getInstance():calculationShopGoldPriceSale(goodsData:getBuyPrice(), goodsData:getCostType())
        local price = price * num

        local useDiamond = false
        local enough = true
        if(goodsData:getCostType() == GOODS_COST_TYPE.GOLD) then
            if(price > GameDataManager:getInstance():getCurCoin()) then
                -- 金币不够
                -- UI.UIManager:onGlodNotEnough()
                UI.ScrollBar:createByText(UI.TEXT_1110389)
                enough = false
            end
        elseif (goodsData:getCostType() == GOODS_COST_TYPE.GEM) then
            if(not Avalon.MathUtil:checkDiamonEnough(price, GameDataManager:getInstance():getDiamond())) then
                -- 钻石不够
                UI.TipsLayer:onDiamondNotEnough()
                -- UI.ScrollBar:createByText(UI.TEXT_1110390)
                enough = false
            end
            useDiamond = true
        end
        if(enough) then

            local isNotice = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeDiamondBuyItem..GameDataManager:getInstance():getMasterPK(), true) 
            if isShowConfireTip and useDiamond and isNotice and num == 1 then
                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1212238, function(isSelect)
                    if isSelect then
                        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeDiamondBuyItem..GameDataManager:getInstance():getMasterPK(), false)  
                    end
                    local endNum = num
                    local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_CAVE_SHOP_BUY)
                    if(repeatData and repeatData[goodsData:getGoodsNo()]) then
                        endNum = endNum + repeatData[goodsData:getGoodsNo()]
                    end

                    MasterDataManager:insertRepeatHandleData(RepeatHandleType.BAG_CAVE_SHOP_BUY, goodsData:getGoodsNo(), endNum)
                    goodsData:setUseNum(endNum)
                    refreshCaveShopData(self, self._shopDataList)
                    GameManager:bagBuyHandler(goodsData, num, self._spriteID)
                    if(not tolua.isnull(grid)) then
                        grid:updateView()
                    end
                    Avalon.AudioManager:playSound("1504")
                end, function(isSelect)
                    
                end, nil, nil, true, price)
            else
                local endNum = num
                local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_CAVE_SHOP_BUY)
                if(repeatData and repeatData[goodsData:getGoodsNo()]) then
                    endNum = endNum + repeatData[goodsData:getGoodsNo()]
                end

                MasterDataManager:insertRepeatHandleData(RepeatHandleType.BAG_CAVE_SHOP_BUY, goodsData:getGoodsNo(), endNum)
                goodsData:setUseNum(endNum)
                refreshCaveShopData(self, self._shopDataList)
                GameManager:bagBuyHandler(goodsData, num, self._spriteID)
                if(not tolua.isnull(grid)) then
                    grid:updateView()
                end
                Avalon.AudioManager:playSound("1504")
            end            
        end
    else
        -- local tips = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1110396) ,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL,UI.TipsButtonType.TEXT_BUTTON)
        -- tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
        --    --TODO 清理背包

        -- end)
        
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110793))

        -- UI.UIManager.mTipsLayer:onBagIsFullOnlyConfirm()
    end
end

-- 装备详情的touch事件的处理
local function onInfoAreaTouchHandler(self,obj,touchPosition)

    if obj and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

     -- 更新装备对比区域数据
    if(self._infoArea) then
        self._infoArea:close()
        self._infoArea = nil
    end
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 
end

function CaveShopPanel:shopClickCallback( grid)
    print("CaveShopPanel:shopClickCallback",self._isDraging)
    if(self._isDraging) then
        return
    end

    if(not tolua.isnull(grid)) then
        if(DEBUG) then
            print("CaveShopPanel:shopClickCallback  3")
        end
        grid:showSelect()
        self._leftGrid = grid

        local goodsData = grid:getData()
        if(DEBUG) then
            print("shopClickCallback ",goodsData:getId())
        end
        if (goodsData) then
            local leftX = 180 +20 + 75

            -- 类型
            if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                -- 装备详情
                local equipmentInfoArea = UI.EquipmentInfoArea:create()
                equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                self._infoArea = equipmentInfoArea
                -- 处理试穿对比
                local blackTable = GameDataManager:getInstance():tryEquipment(goodsData)
                equipmentInfoArea:updateInfo(blackTable)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                local equipmentInfoArea = UI.EquipmentPetInfoArea:create()
                equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                self._infoArea = equipmentInfoArea
                equipmentInfoArea:updateInfo(goodsData, MasterDataManager:getFightWearEquipmentForEquipmentType(goodsData:getEquipmentType()))
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
                -- 道具详情界面
                local itemType = goodsData:getItemType()
                local propInfo = nil;
                if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
                    propInfo = UI.SelectGoodsBagInfoArea:create()
                elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then
                    propInfo = UI.RandomBagInfoArea:create()
                elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then
                    propInfo = UI.LevelBagInfoArea:create()
                    propInfo:lockNextLevelBag()
                    propInfo:disableUse()
                else
                    propInfo = UI.PropInfoArea:create(true)
                end
                propInfo:init(UI.PROP_MATER.PROPINFO)
                self._infoArea = propInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
                -- 材料详情界面
                local materialInfo = nil
                if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then
                    materialInfo = UI.PropInfoArea:create(true)
                else 
                    materialInfo = UI.MaterialEquipScrollInfoArea:create()
                end
                materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                self._infoArea = materialInfo
            -- 处理虚拟物品表现
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
                -- 虚拟物品
                if(goodsData:getCanBeView()) then
                    local propInfo = UI.PropInfoArea:create(true)
                    propInfo:init(UI.PROP_MATER.VIRTUALITEM_INFO)
                    self._infoArea = propInfo
                end 
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
                -- 宝石
                local propInfo = UI.GemStoneInfoArea:create()
                propInfo:init(goodsData)
                self._infoArea = propInfo
             elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
                -- 宝石
                local propInfo = UI.StarPrayInfoArea:create()
                propInfo:init(goodsData)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
                local propInfo = UI.PetStoneInfoArea:create()
                propInfo:init(goodsData)
                self._infoArea = propInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                local propInfo = UI.RelicInfoArea:create()
                propInfo:init(goodsData)
            end 
            if self._infoArea then
                self._infoArea:centerLeft(leftX)
                self._contentLayout:addChild(self._infoArea,9999)
                self._infoArea:setGoodsGrid(grid)
                self._infoArea:closeLockFlag()

                self._infoArea:setHideLink(true)
                self._infoArea:updateView(goodsData)
                self._infoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onInfoAreaTouchHandler)
            end

        end
    end
end


function CaveShopPanel:bagDragBeganCallback(grid, touchPosition)
    print("CaveShopPanel:bagDragBeganCallback")
    if(not tolua.isnull(grid)) then
        grid:hideSelect()
    end
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 

    self._bagGridList:setSpineBgVisible(true)
end

function CaveShopPanel:bagDragMovedCallback(grid, touchPosition)
    -- print("CaveShopPanel:bagDragMovedCallback")
end

function CaveShopPanel:bagDragEndedCallback(grid, touchPosition, isInBag)
    print("CaveShopPanel:bagDragEndedCallback")
    if(grid == nil or tolua.isnull(grid)) then
        return
    end

    if(grid) then 
        local goodsData = grid:getData()
        if(goodsData and not goodsData:getIsSellOrDestory()) then 
            UI.ScrollBar:createByText(UI.TEXT_1212596)
            return 
        end
    end

    if(self._bagGridList) then
        if not isInBag then
            -- 处理卖出TIPS
            local goodsData = grid:getData()
            if(goodsData) then
                Avalon.AudioManager:playSound("1504")
                if RoleBehaviorManager:caveShopNpcCheck() then
                    printWarn(" been blocked when using cave shop npc function sell goods ! goodsId = "..goodsData:getId())
                    return 
                end
                
                if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                    or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                    UI.TipsLayer:createDestoryGemStoneTips({goodsData}, function() 
                        if (RoleBehaviorManager:caveShopSellItemCheck()) then 
                            UI.TipsLayer:createLostEscapeScrollTips({goodsData}, true, function()
                                GameManager:sellGoodsHandler(goodsData,1,self._spriteID, handler(self, function()
                                    if not tolua.isnull(self) then
                                        goodsData:setUseNum(1)
                                        grid:updateView()
                                    end
                                end))
                            end)
                        end 
                    end)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM or 
                    goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                    goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
                    
                    self:selllGoods(goodsData, grid)
                end
            end
        end
    end
    self._bagGridList:setSpineBgVisible(false)
end

function CaveShopPanel:selllGoods(goodsData, grid)
    if(goodsData:getNum() <= 1) then
        if (RoleBehaviorManager:caveShopSellItemCheck()) then 
            UI.TipsLayer:createLostEscapeScrollTips({goodsData}, true, function()
                GameManager:sellGoodsHandler(goodsData, 1, self._spriteID, handler(self, function()
                    goodsData:setUseNum(1)
                    if(not tolua.isnull(grid)) then 
                        grid:updateView()
                    end
                end))
            end)
        end 
    else
        function okCallback(num)
            local sellNum = 0
            if(num ~= nil) then
                sellNum = num
            end
            if (RoleBehaviorManager:caveShopSellItemCheck()) then 
                UI.TipsLayer:createLostEscapeScrollTips({goodsData}, true, function()
                    GameManager:sellGoodsHandler(goodsData,sellNum,self._spriteID, handler(self, function()
                        goodsData:setUseNum(sellNum)
                        if(not tolua.isnull(grid)) then 
                            grid:updateView()
                        end
                    end))
                end)
            end 
            -- Avalon.AudioManager:playSound("1504")
        end
        function cancelCallback()
            
        end

        UI.TipsLayer:onBuyAmount(okCallback, cancelCallback, goodsData:getSellPrice(), GOODS_COST_TYPE.GOLD,goodsData:getNum()-goodsData:getUseNum(), false, true)
        print("goodsData:getNum()--",goodsData:getNum())
    end
end









-- WarehouseLayer.lua
-- Author:ODEI
-- 2017年7月13日
-- Using:仓库 

require "app.ui.shoplayer.BagGoodsPanel"
require("app.ui.warehouseLayer.WarehouseGoodsPanel")

local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local LanguageManager = require "app.game.LanguageManager"

UI = UI or {}

local WarehouseLayer = class("WarehouseLayer", UI.DoorWin)
UI.WarehouseLayer = WarehouseLayer

local winSize = cc.Director:getInstance():getWinSize()
local PACKET_TYPE = PublicDefine.PACKET_TYPE
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_warehouse.plist",
}

local SHOP_LAYOUT = {
    -- 背包格子初始化信息
    GOODS_GRID_INIT_COLUMN = 5,
    GOODS_GRID_INIT_ROW = 10,
    GOODS_GRID_WIDTH = 74,
    GOODS_GRID_HEIGHT = 74+15,
    GOODS_GRID_HORIZONTAL_SPACE = 6,
    GOODS_GRID_VERTICAL_SPACE = 6,
    GOODS_GRID_PADDING_SPACE = 6
}

--构造函数(必备)
function WarehouseLayer:ctor(spriteID)
    --窗口大小
    WarehouseLayer.super.ctor(
    self,UIType.WAREHOUSE_LAYER,
    COM_RES_LIST,
    459,627
    )
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();

end

--虚构函数,destroy时调用(必备)
function WarehouseLayer:dtor()
    WarehouseLayer.super.dtor(self)
    self:unRegisterListener();
    GameManager:npcInteractionEnd(self.spriteID)
end

-- 初始化(必备)
function WarehouseLayer:init()
    WarehouseLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function WarehouseLayer:onInitView()
    -- self:addColorBG()        --灰色遮罩层

    local rootLayer = UI.Layout:create()
    rootLayer:init()
    rootLayer:centerLeft(0)
    rootLayer:setSize(winSize.width, winSize.height)
    self:addChild(rootLayer)
    self.rootLayer = rootLayer


    self.leftLayer = UI.Component:create()
    self.leftLayer:init()
    self.leftLayer:setSize(459,627)
    self.rootLayer:addChild(self.leftLayer,2)

    --在这里填写界面
    local picBg = UI.Image:create()
    picBg:init("ui_warehouse_bg.png")
    picBg:leftBottom(0,0)
    self.leftLayer:addChild(picBg)

    local pWarehouseGoodsPanel = UI.WarehouseGoodsPanel:create()
    pWarehouseGoodsPanel:init()
    pWarehouseGoodsPanel:setCallbackForGridDragBegan(self, self.warehouseDragBeganCallback)
    pWarehouseGoodsPanel:setCallbackForGridDragMoved(self, self.warehouseDragMovedCallback)
    pWarehouseGoodsPanel:setCallbackForGridDragEnded(self, self.warehouseDragEndedCallback)
    self._bagGridList = pWarehouseGoodsPanel
    self.leftLayer:addChild(pWarehouseGoodsPanel,5)
    local pWarehouseGoodsPanelW,pWarehouseGoodsPanelH = pWarehouseGoodsPanel:getSize()
    pWarehouseGoodsPanel:leftBottom(29, 75)

    -- 上面的装饰物
    -- local decorationImage = UI.Image:create()
    -- decorationImage:init("ui_warehouse_rod.png")
    -- decorationImage:leftBottom(0,0)
    -- self.leftLayer:addChild(decorationImage, 6)

    local decorationImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_warehouse_rod.png")
    decorationImage:setContentSize(429, 565)
    decorationImage:setCapInsets(CCRectMake(57,70,1,1))
    decorationImage:setPosition(cc.p(0 + decorationImage:getContentSize().width/2,23+ decorationImage:getContentSize().height/2))
    self.leftLayer:addChild(decorationImage, 6)


    --右边背包数据
    local bagList = UI.BagGoodsPanel:create(nil,false,false)
    bagList:setHideBagType(
        {
            UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
            UI.BagGoodsPanel.BAG_TYPE.GLYPH,
        }
    )

    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self.rootLayer:addChild(bagList,5)
    local bagListW,bagListH = bagList:getSize()
    bagList:leftBottom(winSize.width + bagListW,300 - bagListH/2)


    local gridList = bagList._bagGridList:getGridList()
    if (gridList) then
        for i = 1, #gridList do
            self:setCheckItemUseState(false)
        end
    end
    self:setDoorNode(self.leftLayer, bagList)
end


-- 模版函数：更新组建的视图(必备)
function WarehouseLayer:onUpdateView()

end

function WarehouseLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end
    self._bagGridList:setSpineBgVisible(true)
end

function WarehouseLayer:bagDragMovedCallback(grid, touchPosition)
end

function WarehouseLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    if(tolua.isnull(self.leftLayer)) then 
        return 
    end

    --放到仓库
    if not isInBag then
        local goodsData = grid:getData()

        --需要判断数量
        local freeNum,freeGrids = GameDataManager:getAddItemMaxNum(PACKET_TYPE.PACKET_WAREHOUSE,goodsData:getGoodsID(), goodsData:getIsGolden());
        if goodsData:getNum() <= freeNum then
            freeNum = goodsData:getNum()
        end
        local role = RoleDataManager:getMaster()
        if role then
            local coord = role:getCoord()
            if coord then
                local legalOp = false
                if (coord.x == 28 and coord.y == 32) or (coord.x == 28 and coord.y == 31) or (coord.x == 29 and coord.y == 30) then
                    legalOp = true;
                end
                local SdkManager = require"app.game.SdkManager"
                
                if not legalOp then
                    -- SdkManager:getInstance():sendWebLog(6, 0)
                end
            end
        end

        if freeNum > 0 then
            if RoleBehaviorManager:wareHouseNpcCheck() then
                printWarn(" been blocked when using ware house function drag to ware house!")
                return
            end
            Net.NetGoodsSystem:dragGoodsToPacketRequest(PACKET_TYPE.PACKET_BAG,PACKET_TYPE.PACKET_WAREHOUSE,goodsData,freeNum)
            goodsData:setUseNum(goodsData:getNum())
            grid:updateView()
        else
            -- 处理仓库满的统一提示
            self:handleWareFullHandle()
        end
    end
    self._bagGridList:setSpineBgVisible(false)
end 


function WarehouseLayer:warehouseDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    if(self._bagGridList) then
        self._bagGridList:showMove()
    end
    self._bagGridList:setSpineBgVisible(true)
end


function WarehouseLayer:warehouseDragMovedCallback(grid, touchPosition)
    -- print("WarehouseLayer:bagDragMovedCallback",touchPosition.x,touchPosition.y)
end

function WarehouseLayer:warehouseDragEndedCallback(grid, touchPosition)
    print("WarehouseLayer:warehouseDragEndedCallback")
    if(self._bagGridList) then
        self._bagGridList:hideMove()
    end

    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))
    self.mRect = cc.rect(pos.x, pos.y, 459,627)
    --放到背包

    if not cc.rectContainsPoint(self.mRect, touchPosition) then
        local goodsData = grid:getData()
        --需要判断数量
        local freeNum = GameDataManager:getAddItemMaxNum(PACKET_TYPE.PACKET_BAG,goodsData:getGoodsID(), goodsData:getIsGolden());
        if goodsData:getNum() <= freeNum then
            freeNum = goodsData:getNum()
        end

        if freeNum > 0 then
            if RoleBehaviorManager:wareHouseNpcCheck() then
                printWarn(" been blocked when using ware house function drag to packet bag!")
                return
            end
            Net.NetGoodsSystem:dragGoodsToPacketRequest(PACKET_TYPE.PACKET_WAREHOUSE,PACKET_TYPE.PACKET_BAG,goodsData,freeNum)
            goodsData:setUseNum(goodsData:getNum())
            grid:updateView()
        else
            -- TODO 判断表现错误
            self:handleBagFullHandle()
        end
    end
    self._bagGridList:setSpineBgVisible(false)
end 

function WarehouseLayer:handleBagFullHandle()
    UI.ScrollBar:createByText(UI.TEXT_110037)
end

function WarehouseLayer:handleWareFullHandle()
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170028))

    -- local bagData = GameDataManager:getInstance():getWearhouseData()
    -- if bagData.packetBoxBeUseNum >= tonumber(Config.General:getValueForKey("packetWarehouseMaxNum")) then
    --     UI.ScrollBar:createByText(UI.TEXT_110032)
    --     return
    -- end

    
    -- -- 每次解锁的背包格子数
    -- local count = Config.General:getValueForKey("unlockPacketWarehouseSpace")
    -- -- 话费的数量
    -- local cost = 0
    -- -- 获取已经购买的次数
    -- local boughtTimes = bagData.unlockBagTimes + 1
    -- if (boughtTimes == 1) then
    --     cost = Config.General:getValueForKey("unlockPacketWarehouseCostDiamond")
    -- elseif (boughtTimes >= 2) then

    --     local increaseEachTime = Config.General:getValueForKey("eachUnlockPacketWarehouseIncreaseCostDiamond") * 
    --         (boughtTimes - 1)
    --     local maxCost = Config.General:getValueForKey("unlockPacketWarehouseCostDiamondMax") 
    --     cost = Config.General:getValueForKey("unlockPacketWarehouseCostDiamond") + increaseEachTime
    --     if (tonumber(cost) > tonumber(maxCost)) then
    --         cost = maxCost
    --     end
    -- else
    --     assert(false)
    -- end

    -- local buyGridsTips = UI.Tips:createTips(string.format(UI.TEXT_110033, cost, count),
    --     UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)

    -- buyGridsTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
    --     local curDiamond = RoleDataManager:getMaster():getDiamond()
    --     if (tonumber(cost) <= curDiamond) then
    --         UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    --         Net.NetGoodsSystem:requestUnlockBagSpace(PACKET_TYPE.PACKET_WAREHOUSE)
    --     else
    --         UI.TipsLayer:onDiamondNotEnough()
    --     end
    -- end)
end 

function WarehouseLayer:onCodeDragGoodsToPacket(data)
    if(data.result == "DragGoodsToPacketResult_BagIsFull") then
        if(data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_BAG and data.toPacketType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE) then
            self:handleWareFullHandle()
        elseif(data.fromPacketType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE and data.toPacketType == PublicDefine.PACKET_TYPE.PACKET_BAG) then
            self:handleBagFullHandle()
        end
    else 
        GameErrorManager:showError(ProtobufUtil:enum_id("GoodsSystem.DragGoodsToPacketResult", data.result))
    end
end

-- 注册监听事件(可选)
function WarehouseLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_CODE_DRAG_GOODS_TO_PACKET, self, self.onCodeDragGoodsToPacket)
end


-- 注销监听事件(可选)
function WarehouseLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_CODE_DRAG_GOODS_TO_PACKET, self, self.onCodeDragGoodsToPacket)
end





------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2024/02/22
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PurpleUpgradeResetView = class("PurpleUpgradeResetView", UI.HWBtnComponent)
local PurpleUpgradePacketLayer = require "app.modules.purpleupgrade.PurpleUpgradePacketLayer"
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
}

local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(341, 632)

local COM_WIDTH = 920
local COM_HEIGHT = 580

function PurpleUpgradeResetView:ctor()
    PurpleUpgradeResetView.super.ctor(
    	self,
    	UI.Type.PURPLE_UPGRADE_RESET,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PurpleUpgradeResetView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.purpleupgrade", "PurpleUpgrade", false)
    PurpleUpgradeResetView.super.init(self, ... )
end

function PurpleUpgradeResetView:dtor()
    PurpleUpgradeResetView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.purpleupgrade.PurpleUpgradeResetView")
end


function PurpleUpgradeResetView:onInitView()
    self.leftLayer = UI.Layout:create();
    self.leftLayer:init()
    self.leftLayer:setSize(leftSize.width, leftSize.height)
    self.leftLayer:center(-270,120)
    self:addChild(self.leftLayer,2)

    self.leftLayer:setTouchEnable(true)
    self.leftLayer:setInterceptTouches(false)
    self.leftLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        
    end)

    self.rightLayer = UI.Layout:create();
    self.rightLayer:init()
    self.rightLayer:setSize(450, COM_HEIGHT)
    self.rightLayer:center(235,0)
    self:addChild(self.rightLayer)

    self:createRightView()
    self:createLeftView()
end

function PurpleUpgradeResetView:createLeftView()
    self.leftLayer:removeAllChildren()

    -- 操作提示区
    local operateBg = UI.Image:create()
    operateBg:init("ui_rough_title.png")
    operateBg:center(50, -315)
    self.leftLayer:addChild(operateBg, 5)

    local operateText = UI.Text:create()
    operateText:init(UI.TEXT_227506,UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 194, g = 194, b = 194})
    operateText:center(0,0)
    operateBg:addChild(operateText)
    self._operateText = operateText

    -- 镶嵌底图
    local leftBgAnimation = UI.Animation:create()
    leftBgAnimation:init("effect_ui_town_yuanshi.json", "effect_ui_town_yuanshi.atlas")
    -- leftBgAnimation:updateTime(0)
    leftBgAnimation:center(50, -200)
    self.leftLayer:addChild(leftBgAnimation, 1)
    self._leftBgAnimation = leftBgAnimation

    leftBgAnimation:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "evnet_show" then
                self:updateRedGrid()
            end
        end
    end)

    -- 添加装备框
    self.mRedGridEquipment = UI.GoodsGrid:create()
    self.mRedGridEquipment:init()
    self.mRedGridEquipment:center(0, 0)
    self.mRedGridEquipment:hide()
    self.mRedGridEquipment:hideCountLabel()
    self.mRedGridEquipment:hideNewIcon()
    self.mRedGridEquipment:setTouchEnable(true)
    self.mRedGridEquipment:setDragOutAreaJudgeNode(self.leftLayer)
    self.mRedGridEquipment:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGridEquipment))
    self.mRedGridEquipment:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridEquipment))
    self.mRedGridEquipment:showInfoArea();

    self._leftBgAnimation:addComponent("icon1", self.mRedGridEquipment, true)

    -- 添加原石框
    self.mPrimogemGrid = UI.GoodsGrid:create()
    self.mPrimogemGrid:init()
    self.mPrimogemGrid:center(0, 0)
    self.mPrimogemGrid:hide()
    self.mPrimogemGrid:hideCountLabel()
    self.mPrimogemGrid:hideNewIcon()
    self.mPrimogemGrid:setTouchEnable(true)
    -- self.mPrimogemGrid:setDragOutAreaJudgeNode(self.leftLayer)
    -- self.mPrimogemGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGridPrimo))
    -- self.mPrimogemGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridPrimo))
    self.mPrimogemGrid:showInfoArea()
    self.mPrimogemGrid:setScale(0.8)
    --self.mGoodsGrid.state = 1

    self._leftBgAnimation:addComponent("icon3", self.mPrimogemGrid, true)

    ------------------------------------------


    -- 添加装备框
    self.mGoodsGridEquipment = UI.GoodsGrid:create()
    self.mGoodsGridEquipment:init()
    self.mGoodsGridEquipment:center(0, 0)
    self.mGoodsGridEquipment:hide()
    self.mGoodsGridEquipment:hideCountLabel()
    self.mGoodsGridEquipment:hideNewIcon()
    self.mGoodsGridEquipment:setTouchEnable(true)
    -- self.mGoodsGridEquipment:setDragOutAreaJudgeNode(self.leftLayer)
    -- self.mGoodsGridEquipment:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGridEquipment))
    -- self.mGoodsGridEquipment:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridEquipment))
    self.mGoodsGridEquipment:showInfoArea();
    self.mGoodsGridEquipment:setScale(0.8)

    self._leftBgAnimation:addComponent("icon2", self.mGoodsGridEquipment, true)

    -- 属性队列
    if self.attributeNode then
        self.attributeNode:removeFromParent()
        self.attributeNode = nil
    end
    self.attributeNode = UI.Layout:create();
    self.attributeNode:init()
    self.attributeNode:setSize(leftSize.width, leftSize.height)
    self.attributeNode:leftBottom(-110,-730)

    leftBgAnimation:addChild(self.attributeNode, 4)

    -- 按钮分割线
    local partitionLineBg = UI.Image:create()
    partitionLineBg:init("ui_rough_line.png")
    partitionLineBg:center(50, -80)
    self.leftLayer:addChild(partitionLineBg, 1)

    local resetConsumption = string.split(ConfigManager:getGeneralForKey("resetConsumption"), ",")
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(resetConsumption[1]))

    -- 水晶
    local diamondIcon = UI.Image:create()
    diamondIcon:init(goodsData.miniIcon)
    diamondIcon:center(40, 35)
    self.leftLayer:addChild(diamondIcon, 10)
    self.diamondIcon = diamondIcon

    -- 花费的水晶数量
    local diamondCost  = UI.Text:create()
    diamondCost:init(resetConsumption[2], UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)    
    diamondCost:center(70, 35)
    self.leftLayer:addChild(diamondCost, 10)   
    self.diamondCost = diamondCost

    local upgradeBtn = UI.Button:create();
    upgradeBtn:init("ui_rough_btn2.png","ui_rough_btn2.png","ui_rough_btn2_3.png")
    upgradeBtn:centerBottom(220, 60)
    upgradeBtn:setText(UI.TEXT_227518)
    upgradeBtn:setFontSize(UI.FONT_SIZE_20PX)
    upgradeBtn:setFontColor(UI.FONT_COLOR_47_50_55)
    self.leftLayer:addChild(upgradeBtn)
    upgradeBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:resetEquip()
    end)
    self.upgradeBtn = upgradeBtn
    -- upgradeBtn:disable()
end

function PurpleUpgradeResetView:createRightView()
    self.rightLayer:removeAllChildren()

    local hideList = {
        UI.BagGoodsPanel.BAG_TYPE.ALL,
        UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
        --UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
        UI.BagGoodsPanel.BAG_TYPE.ITEM,
        -- UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
        UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
        UI.BagGoodsPanel.BAG_TYPE.RELIC,
        UI.BagGoodsPanel.BAG_TYPE.GLYPH,
    }

    local showList = {
        UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
        -- UI.BagGoodsPanel.BAG_TYPE.GLYPH,
    }
    local usedType = {}

    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    _usedType1.type = PublicDefine.MATERIAL_TYPE.MaterialPrimogem
    usedType._usedType1 = _usedType1
    
    local _usedType2 = {}
    _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType2.type = 0 --all
    _usedType2.needPurpleFunc = function(goodsData)
        -- if goodsData.isLock then
        --     return false
        -- end
        if goodsData.createLevel and goodsData.createLevel > 0 and goodsData.primogemId ~= 0 and goodsData.randomGoodsRare == PublicDefine.GOODS_RARE.RARE_DARKRED then
            return true
        end
        if not goodsData.createLevel or goodsData.createLevel == 0 or goodsData.primogemId == 0 then
            return false
        end
    end
    usedType._usedType2 = _usedType2

    local PurpleUpgradePacketLayer = PurpleUpgradePacketLayer:create(hideList, showList, usedType)
    PurpleUpgradePacketLayer:init()
    PurpleUpgradePacketLayer:centerRight(0)
    self.rightLayer:addChild(PurpleUpgradePacketLayer, 99)
    self.PurpleUpgradePacketLayer = PurpleUpgradePacketLayer

    local bagList = PurpleUpgradePacketLayer:getBagList()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    bagList:setTouchEnable(true)
    bagList:setInterceptTouches(false)
    bagList:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        
    end)

    bagList:setRefreshOutSideLabelViewCallback(function()
        self:updateBagName()
    end)

    bagList.updateDeleteCallback = function(bgSelf,deleteItemTable)
        
    end

    self._bagGridList:changeBagDefaultIndex(2)

    self._bagGridList:refreshView()
end

function PurpleUpgradeResetView:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end

    local goodsType = goodsData:getGoodsType()
    -- 根据拖动的类型来判断如何处理后续逻辑
    self:runReadyAnimtion(goodsData, goodsType)
end

function PurpleUpgradeResetView:bagDragEndedCallback(grid, touchPosition, isInBag)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()

    if not isInBag then
        -- if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        --     if goodsData.refineNum ~= goodsData.equipRefineTime then
        --         UI.ScrollBar:createByText(UI.TEXT_227508)
        --         self:runCancelReadyAnimtion()
        --         return
        --     end
        -- end
        -- 根据拖动的类型来判断如何处理后续逻辑
        self:bagDragToFrameLogic(grid)
        -- if self.mGoodsDataEquipment then
        --     -- self:runPutAnimtion(goodsData, goodsType)
        --     self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.MATERIAL)
        -- -- else
        -- --     self:runCancelReadyAnimtion(goodsType)
        -- end
    end
    self:runCancelReadyAnimtion()
    
end

-- 准备放入动画
function PurpleUpgradeResetView:runReadyAnimtion(goodsData, goodsType)
    if goodsData then
        -- 准备放入动画
        local animationPlay = nil

        self._leftBgAnimation:setAnimation("loop_a", false)
        self._leftBgAnimation:setTimeScale(1)
    end
end

-- 放入动画
-- function PurpleUpgradeResetView:runPutAnimtion(goodsData, goodsType)
-- end

-- 取消准备放入动画
function PurpleUpgradeResetView:runCancelReadyAnimtion(goodsType)
    -- 取消准备放入动画
    self._leftBgAnimation:setToSetupPose()

    -- self:clearGridData()
end

function PurpleUpgradeResetView:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    return usedTypeList
end

function PurpleUpgradeResetView:bagDragToFrameLogic(grid)
    local goodsData = grid:getData()
    local goodsType = goodsData:getGoodsType()
    
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        -- 在装备框中 
        isSuccess = self:chosePutInBox(true, goodsData)
    else
        self._bagGridList:refreshView()
    end
end

function PurpleUpgradeResetView:chosePutInBox(isEquipment, goodsData)
    local isSuccess = true
    if isEquipment then
        -- 替换装备栏
        if self.mRedEquipData ~= nil then
            self.mRedEquipData._changeNum = 0
        end
        goodsData._changeNum = -1

        self.mRedEquipData = goodsData
        self._bagGridList:refreshView()

        self.mRedGridEquipment:setData(self.mRedEquipData)
        self.mRedGridEquipment:updateView()
        -- self.mRedGridEquipment:hideCountLabel()
        -- self.mRedGridEquipment:hideNewIcon()
        -- self.mRedGridEquipment:hideBG()
        self.mRedGridEquipment:show()

        -- 移除雕纹框信息一定要放在刷新之前！！
        self:removeGlyphBox()

        self:onSelectRedEquipment(goodsData)
    end

    if not isSuccess then
        self._bagGridList:refreshView()
    end

    return isSuccess
end

function PurpleUpgradeResetView:onSelectRedEquipment(goodsData)
    local originEquipData = clone(goodsData)
    -- originEquipData.primogemId = 0
    originEquipData:resetEquipByPrimogem()
    self.mGoodsDataEquipment = originEquipData
    
    self._bagGridList:refreshView()
    self.mGoodsGridEquipment:setData(self.mGoodsDataEquipment)
    self.mGoodsGridEquipment:updateView()
    self.mGoodsGridEquipment:hideCountLabel()
    self.mGoodsGridEquipment:hideNewIcon()
    self.mGoodsGridEquipment:hideBG()
    self.mGoodsGridEquipment:show()

    local goodsConfig = GoodsDataManager:createLocalGoodsData(goodsData.primogemId)--Config.ConfigGoods:getPrimoGemStone(goodsData.primogemId)
    self.mPrimogemData = goodsConfig

    self.mPrimogemGrid:setData(self.mPrimogemData)
    self.mPrimogemGrid:updateView()
    self.mPrimogemGrid:hideCountLabel()
    self.mPrimogemGrid:hideNewIcon()
    self.mPrimogemGrid:hideBG()
    self.mPrimogemGrid:show()
end

function PurpleUpgradeResetView:removeGlyphBox()
    -- 移除雕纹框
    if self.mPrimogemData ~= nil then
        self.mPrimogemData._changeNum = 0
    end
    self.mPrimogemData = nil
    self._bagGridList:refreshView()
    self.mPrimogemGrid:setVisible(false)
end

function PurpleUpgradeResetView:updateBagName()
    if self.mPrimogemData and self.mGoodsDataEquipment then
        self._operateText:setText(UI.TEXT_227521)
    elseif not self.mGoodsDataEquipment then
        self._operateText:setText(UI.TEXT_227010)
    end
end


------------------------------------------
function PurpleUpgradeResetView:onTouchBeganByGoodsGridEquipment(grid,touchPosition)
    local goodsData = grid:getData()

    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()

    self:runReadyAnimtion(nil, goodsType)

    return true
end

function PurpleUpgradeResetView:onTouchEndedByGoodsGridEquipment(grid, inSide)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()
    if not inSide then
        -- 收回装备
        if self.mRedEquipData ~= nil then
            self.mRedEquipData._changeNum = 0
        end
        --self:runInheritPutAnimtion(true)
        --self:runPutAnimtion();
        -- self.mGoodsDataEquipment = nil
        -- self._bagGridList:refreshView()

        -- --self.mGoodsGridEquipment:setData(nil)
        -- self.mGoodsGridEquipment:updateView()
        -- self.mGoodsGridEquipment:hide()
        -- -- 移除原石框信息一定要放在刷新之前！！
        -- self:removeGlyphBox()
        self:clearGridData()
        self:runCancelReadyAnimtion(goodsType)
    else
        --self:runCancelReadyAnimtion(goodsType)
    end
end
------------------------------------------
function PurpleUpgradeResetView:onTouchBeganByGoodsGridPrimo(grid,touchPosition)
    local goodsData = grid:getData()

    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()

    self:runReadyAnimtion(nil, goodsType)

    return true
end

function PurpleUpgradeResetView:onTouchEndedByGoodsGridPrimo(grid, inSide)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()
    if not inSide then 

        -- self:runCancelReadyAnimtion(goodsType)

        ---------------------------
        self:removeGlyphBox()
    else
        --self:runCancelReadyAnimtion(goodsType)
    end

    self:updateGemDes()
end

function PurpleUpgradeResetView:checkGemTypeIsSuit(gemData)
    local isSuit = false
    if self.mGoodsDataEquipment then
        -- self.mGoodsDataEquipment.occupDiffer
        local equipType = AvalonUtil.getEquipmentTypeFromID(self.mGoodsDataEquipment.goodsID)
        if equipType == PublicDefine.EQUIPMENT_TYPE.Weapon then
            if self.mGoodsDataEquipment.occupDiffer == gemData.occupationType and equipType == gemData.partType then
                isSuit = true
            end
        else
            if equipType == gemData.partType then
                isSuit = true
            end
        end
    end
    return isSuit
end

function PurpleUpgradeResetView:resetEquip()
    if self.mRedEquipData then
        local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
        if freePacketNum < 1 then
            UI.ScrollBar:createByText(UI.TEXT_1314137)
            return
        end

        local messageData = {}
        messageData.entityID = self.mRedEquipData:getEntityID()
        messageData.packetType = self.mRedEquipData:getBagType()
        Net.NetGoodsSystem:requesResetPurpleMessage(messageData)
    else
        UI.ScrollBar:createByText(UI.TEXT_227519)
    end
end


function PurpleUpgradeResetView:updateRedGrid()
    self.mRedGridEquipment:show()
    if self.mRedEquipData and self.mRedGridEquipment then
        self.mRedGridEquipment:show()
    end
end

function PurpleUpgradeResetView:clearGridData()
    self.mGoodsDataEquipment = nil
    self._bagGridList:refreshView()
    self.mGoodsGridEquipment:updateView()
    self.mGoodsGridEquipment:hide()
    
    if self.mRedEquipData ~= nil then
        self.mRedEquipData._changeNum = 0
    end
    self.mRedEquipData = nil
    self.mRedGridEquipment:updateView()
    self.mRedGridEquipment:hide()

    self:removeGlyphBox()

end



function PurpleUpgradeResetView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PURPLE_RESET_SUCCESS,self, self.clearGridData)
end


function PurpleUpgradeResetView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PURPLE_RESET_SUCCESS,self, self.clearGridData)
end





return PurpleUpgradeResetView













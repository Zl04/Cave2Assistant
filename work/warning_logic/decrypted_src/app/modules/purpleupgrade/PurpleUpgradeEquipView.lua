------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/12/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PurpleUpgradeEquipView = class("PurpleUpgradeEquipView", UI.HWBtnComponent)
local PurpleUpgradePacketLayer = require "app.modules.purpleupgrade.PurpleUpgradePacketLayer"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 920
local COM_HEIGHT = 580

local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(341, 632)

function PurpleUpgradeEquipView:ctor()
    PurpleUpgradeEquipView.super.ctor(
    	self,
    	UI.Type.PURPLE_UPGRADE_EQUIP,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.mRedEquipData = nil;               --升级红装属性
    self.mGoodsDataEquipment = nil;          --装备属性
    self.mPrimogemData = nil;              --原石属性
    self:bindModel()
end

function PurpleUpgradeEquipView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.purpleupgrade", "PurpleUpgrade", false)
    PurpleUpgradeEquipView.super.init(self, ... )
end

function PurpleUpgradeEquipView:dtor()
    PurpleUpgradeEquipView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.purpleupgrade.PurpleUpgradeEquipView")
end


function PurpleUpgradeEquipView:onInitView()
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

function PurpleUpgradeEquipView:createLeftView()
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
    leftBgAnimation:updateTime(0)
    leftBgAnimation:center(50, -200)
    self.leftLayer:addChild(leftBgAnimation, 1)
    self._leftBgAnimation = leftBgAnimation

    -- leftBgAnimation:addEventListener(UIEvent.ANIMATION_END, self, function(sender, event)
    --     if(event) then
    --         if event.animation == "trigger_b" then
    --             self:updateRedGrid()
    --         end
    --     end
    -- end)

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
    self.mPrimogemGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mPrimogemGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGridPrimo))
    self.mPrimogemGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridPrimo))
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
    self.mGoodsGridEquipment:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGridEquipment:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGridEquipment))
    self.mGoodsGridEquipment:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridEquipment))
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

    local desBg = UI.Image:create()
    desBg:init("ui_rough_bg.png")
    desBg:center(50, -20)
    self.leftLayer:addChild(desBg, 1)

    local desc = UI.Text:create()
    desc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    desc:setWidth(385)
    desc:autoAdapt()
    desc:centerUp(1)
    self.desc = desc

    local desLayout = UI.Layout:create()
    desLayout:init()
    desLayout:addChild(desc)
    desLayout:setSize(430, 75)
    self.desLayout = desLayout

    local scrollView = UI.ScrollView:create()
    scrollView:init()
    scrollView:setSize(388, 120)
    scrollView:center()
    scrollView:addInnerNode(desLayout)
    scrollView:useDefaultScrollBar()
    desBg:addChild(scrollView)
    self.desScrollView = scrollView

    local upgradeBtn = UI.Button:create();
    upgradeBtn:init("ui_rough_btn2.png","ui_rough_btn2.png","ui_rough_btn2_3.png")
    upgradeBtn:centerBottom(220, 60)
    upgradeBtn:setText(UI.TEXT_227503)
    upgradeBtn:setFontSize(UI.FONT_SIZE_20PX)
    upgradeBtn:setFontColor(UI.FONT_COLOR_47_50_55)
    self.leftLayer:addChild(upgradeBtn)
    upgradeBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:upgradeEquip()
    end)
    self.upgradeBtn = upgradeBtn
    -- upgradeBtn:disable()
end

function PurpleUpgradeEquipView:createRightView()
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
        if goodsData.createLevel and goodsData.createLevel > 0 and goodsData.primogemId == 0 and goodsData.randomGoodsRare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_BORDERS_5 then
            -- if goodsData.randomGoodsRare == PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_BORDERS_5 then
            --     return true
            -- end
            return true
        end
        if not goodsData.createLevel or goodsData.createLevel == 0 or goodsData.primogemId ~= 0 then
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

function PurpleUpgradeEquipView:bagDragBeganCallback(grid, touchPosition)
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

function PurpleUpgradeEquipView:bagDragEndedCallback(grid, touchPosition, isInBag)
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
        if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
            if goodsData.refineNum ~= goodsData.equipRefineTime then
                UI.ScrollBar:createByText(UI.TEXT_227508)
                self:runCancelReadyAnimtion()
                return
            end
        end
        -- 根据拖动的类型来判断如何处理后续逻辑
        self:bagDragToFrameLogic(grid)
        if self.mGoodsDataEquipment then
            -- self:runPutAnimtion(goodsData, goodsType)
            self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.MATERIAL)
        -- else
        --     self:runCancelReadyAnimtion(goodsType)
        end
    end
    self:runCancelReadyAnimtion()
    
end

-- 准备放入动画
function PurpleUpgradeEquipView:runReadyAnimtion(goodsData, goodsType)
    if goodsData then
        -- 准备放入动画
        local animationPlay = nil

        self._leftBgAnimation:setAnimation("loop_b", false)
        self._leftBgAnimation:setTimeScale(1)
    end
end

-- 放入动画
-- function PurpleUpgradeEquipView:runPutAnimtion(goodsData, goodsType)
-- end

-- 取消准备放入动画
function PurpleUpgradeEquipView:runCancelReadyAnimtion(goodsType)
    -- 取消准备放入动画
    self._leftBgAnimation:setToSetupPose()

    -- self:clearGridData()
end

function PurpleUpgradeEquipView:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    return usedTypeList
end

function PurpleUpgradeEquipView:bagDragToFrameLogic(grid)
    local goodsData = grid:getData()
    local goodsType = goodsData:getGoodsType()
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
        -- 在原石中,并且装备栏必须有装备才行
        if self.mGoodsDataEquipment and goodsData:getMaterialType() == PublicDefine.MATERIAL_TYPE.MaterialPrimogem then
            isSuccess = self:chosePutInBox(false, goodsData)
        else
            UI.ScrollBar:createByText(UI.TEXT_227007)
        end
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        -- 在装备框中 
        isSuccess = self:chosePutInBox(true, goodsData)
    else
        self._bagGridList:refreshView()
    end
end

function PurpleUpgradeEquipView:chosePutInBox(isEquipment, goodsData)
    local isSuccess = true

    if isEquipment then
        -- 替换装备栏
        if self.mGoodsDataEquipment ~= nil then
            self.mGoodsDataEquipment._changeNum = 0
        end
        --self:runInheritPutAnimtion(true)
        --self:runPutAnimtion();
        goodsData._changeNum = -1
        self.mGoodsDataEquipment = goodsData
        self._bagGridList:refreshView()

        self.mGoodsGridEquipment:setData(self.mGoodsDataEquipment)
        self.mGoodsGridEquipment:updateView()
        self.mGoodsGridEquipment:hideCountLabel()
        self.mGoodsGridEquipment:hideNewIcon()
        self.mGoodsGridEquipment:hideBG()
        self.mGoodsGridEquipment:show()
        -- 移除雕纹框信息一定要放在刷新之前！！
        self:removeGlyphBox()
    else
        if not self:checkGemTypeIsSuit(goodsData) then
            UI.ScrollBar:createByText(UI.TEXT_227505)
            return 
        end
        -- 替换原石栏
        if self.mPrimogemData ~= nil then
            self.mPrimogemData._changeNum = 0
        end
        goodsData._changeNum = -1
        self.mPrimogemData = goodsData
        self._bagGridList:refreshView()

        self.mPrimogemGrid:setData(self.mPrimogemData)
        self.mPrimogemGrid:updateView()
        self.mPrimogemGrid:hideCountLabel()
        self.mPrimogemGrid:hideNewIcon()
        self.mPrimogemGrid:hideBG()
        self.mPrimogemGrid:show()

        self:updateGemDes()
    end

    if not isSuccess then
        self._bagGridList:refreshView()
    end

    return isSuccess
end

function PurpleUpgradeEquipView:removeGlyphBox()
    -- 移除雕纹框
    if self.mPrimogemData ~= nil then
        self.mPrimogemData._changeNum = 0
    end
    self.mPrimogemData = nil
    self._bagGridList:refreshView()
    self.mPrimogemGrid:setVisible(false)
end

function PurpleUpgradeEquipView:updateBagName()
    if self.mPrimogemData and self.mGoodsDataEquipment then
        self._operateText:setText(UI.TEXT_227507)
    elseif not self.mGoodsDataEquipment then
        self._operateText:setText(UI.TEXT_227010)
    elseif not self.mPrimogemData then
        self._operateText:setText(UI.TEXT_227506)
    end
end


------------------------------------------
function PurpleUpgradeEquipView:onTouchBeganByGoodsGridEquipment(grid,touchPosition)
    local goodsData = grid:getData()

    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()

    self:runReadyAnimtion(nil, goodsType)

    return true
end

function PurpleUpgradeEquipView:onTouchEndedByGoodsGridEquipment(grid, inSide)
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
        if self.mGoodsDataEquipment ~= nil then
            self.mGoodsDataEquipment._changeNum = 0
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
function PurpleUpgradeEquipView:onTouchBeganByGoodsGridPrimo(grid,touchPosition)
    local goodsData = grid:getData()

    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()

    self:runReadyAnimtion(nil, goodsType)

    return true
end

function PurpleUpgradeEquipView:onTouchEndedByGoodsGridPrimo(grid, inSide)
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

function PurpleUpgradeEquipView:checkGemTypeIsSuit(gemData)
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

function PurpleUpgradeEquipView:updateLeftView()

    self:updateGemDes()
end

function PurpleUpgradeEquipView:updateGemDes()
    if self.mPrimogemData then
        local gemDes = ""
        local desc = self.mPrimogemData:getDetailDescription()
        for k,v in pairs(desc) do
            gemDes = gemDes..v.."\n"
        end
        
        self.desc:setText(gemDes)
    else
        self.desc:setText("")
    end
end

function PurpleUpgradeEquipView:upgradeEquip()
    -- self._leftBgAnimation:setAnimation("trigger_b", false)
    if self.mGoodsDataEquipment and self.mPrimogemData then
        local messageData = {}
        messageData.entityID = self.mGoodsDataEquipment:getEntityID()
        messageData.packetType = self.mGoodsDataEquipment:getBagType()
        messageData.consumeid = self.mPrimogemData.goodsID
        Net.NetGoodsSystem:requesPurUpgradeMessage(messageData)
    else
        UI.ScrollBar:createByText(UI.TEXT_227504)
    end
end

function PurpleUpgradeEquipView:upgradeEquipSuccess(equipData)
    if equipData then
        self.mRedEquipData = equipData
        self._bagGridList:refreshView()

        self.mRedGridEquipment:setData(self.mRedEquipData)
        self.mRedGridEquipment:updateView()
        self.mRedGridEquipment:hideCountLabel()
        self.mRedGridEquipment:hideNewIcon()
        self.mRedGridEquipment:hideBG()
    end
    self._leftBgAnimation:setAnimation("trigger_b", false)
    self:clearGridData()
end

function PurpleUpgradeEquipView:updateRedGrid()
    self.mRedGridEquipment:show()
    if self.mRedEquipData and self.mRedGridEquipment then
        self.mRedGridEquipment:show()
    end
end

function PurpleUpgradeEquipView:clearGridData()
    self.mGoodsDataEquipment = nil
    self._bagGridList:refreshView()
    self.mGoodsGridEquipment:updateView()
    self.mGoodsGridEquipment:hide()

    self:removeGlyphBox()

    self.desc:setText("")
end


function PurpleUpgradeEquipView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PURPLE_UPGRADE_SUCCESS,self, self.upgradeEquipSuccess)
end


function PurpleUpgradeEquipView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PURPLE_UPGRADE_SUCCESS,self, self.upgradeEquipSuccess)
end





return PurpleUpgradeEquipView













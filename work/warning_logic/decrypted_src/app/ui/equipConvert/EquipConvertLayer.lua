UI = UI or {}


local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_blacksmith.plist",
}
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local EqiupConvertHelpLayer = require "app.ui.equipConvert.EqiupConvertHelpLayer"

local EquipConvertLayer = class("EquipConvertLayer", UI.DoorWin)
UI.EquipConvertLayer = EquipConvertLayer
local model = require("app.uiExport.EquipWorkshop")
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

local gridType = {
    goods = 2,
    material = 1
}

function EquipConvertLayer:ctor(spriteID)
    --窗口大小
    EquipConvertLayer.super.ctor(
    self,UIType.EQUIPMEN_COVER,
    COM_RES_LIST,
    318,    
    winSize.height
    )
    self.spriteID = spriteID
end
--虚构函数,destroy时调用(必备)
function EquipConvertLayer:dtor()
    EquipConvertLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function EquipConvertLayer:init()
    EquipConvertLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function EquipConvertLayer:onInitView()
    self:registerListener()
    self.rootLayer = cc.Layer:create()
    self.rootLayer:setContentSize(cc.size(winSize.width, winSize.height))
    self:addChild(self.rootLayer)

    self.makeEquipModel = model.createmakeEquipNode()
    self.leftLayer = self.makeEquipModel.root
    self.rootLayer:addChild(self.leftLayer, 1000)

    self.strengLayer = model.createConvertNode()
    self.strengLayer.root:leftUp(96, 0)
    self.strengLayer.root:setVisible(true)
    self.leftLayer:addChild(self.strengLayer.root);

    self.fireAnimation = self.makeEquipModel.fireAnimation
    self.fireAnimation2 = self.makeEquipModel.fireAnimationFront
    self.strengAnimation = self.strengLayer.strengAnimation

    self.equipNameLabel = self.makeEquipModel.titleStr
    self.equipNameLabel:setText(UI.TEXT_1300000)
    -- 强化成功概率
    self.mRateLayer = self.strengLayer.chanceDesLayer
    self.mTxtRateTitle = self.strengLayer.chanceDesLabel
    self.mTxtRate = self.strengLayer.chanceNumberLbale
    self.mRateLayer:setVisible(false)

    --强化btn
    self.mBtnStrengthen = self.makeEquipModel.executeButton
    self.mBtnStrengthen:addEventListener(UIEvent.BUTTON_CLICK, self, self.onStrengthen)
    AvalonUtil.addBracketsAnimationToButton(self.mBtnStrengthen)

    self.mTxtStrengthen = self.makeEquipModel.executeButtonLabel
    self.mTxtStrengthenXPos = self.mTxtStrengthen._posX;

    local functionTabList = UI.TabList:create()
    functionTabList:init(120)
    functionTabList:centerBottom(138)
    functionTabList:setTouchEnable(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, handler(self,self.onCostTypeChange))
    functionTabList:setDefaultIndex(self.costType or gridType.material)
    -- self.makeEquipModel.makeEquipBg:addChild(functionTabList)


    self.leftLayer:addChild(functionTabList)
    -- functionTabList:setVisible(false)
    self.functionTabList = functionTabList

    local tab = UI.TabItem:create()
    tab:init("ui_btn_blacksmith_material_0.png", "ui_btn_blacksmith_material_1.png")
    -- tab:setChangeScale(false)
    functionTabList:addToTab(tab, gridType.goods)

    local tab = UI.TabItem:create()
    tab:init("ui_btn_blacksmith_crystal_0.png", "ui_btn_blacksmith_crystal_1.png")
    -- tab:setChangeScale(false)
    functionTabList:addToTab(tab, gridType.material)
    

    -- 属性显示区域
    self._scrollLayout = UI.Layout:create()
    self._scrollLayout:init()
    -- self._scrollLayout:setSize(LAYOUT_SIZE_WIDTH,250)
    
    local helpBtn = UI.Button:create()
    helpBtn:init("ui_blacksmith_square.png")
    helpBtn:leftBottom(280, 586)
    helpBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        local helpLayer = EqiupConvertHelpLayer:create()
        helpLayer:init()
        helpLayer:leftBottom(0, 8)
        self.leftLayer:addChild(helpLayer) 
    end)

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:center()
    helpBtn:addChild(detailAnimation, 10)


    self.leftLayer:addChild(helpBtn)
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(258,146)
    scrollView:init()
    scrollView:leftUp(42, 314)
    scrollView:addInnerNode(self._scrollLayout)
    scrollView:setScrollBarEnabled(false)
    -- scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    -- scrollView:setScrollBarWidth(5)
    self.leftLayer:addChild(scrollView)

    local toastText = {
        UI.TEXT_1212274,
        UI.TEXT_1212275,
        UI.TEXT_1212276,
        UI.TEXT_1212277,
        UI.TEXT_1212278,
        UI.TEXT_1212283,
    }
    local centerOffsetUp = 13.5
    local pointOffsetY = - 1

    local leftOffset = 0
    local totalHeight = 0
    local pointBaseOffset = 3
    for i,data in ipairs(toastText) do
        local centerUp = totalHeight + centerOffsetUp

        local point = UI.Image:create()
        point:init("ui_information_hero_diamond.png")
        point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
        point:setImageColor(UI.FONT_COLOR_BLACK)
        self._scrollLayout:addChild(point)
        
        
        local baseText = UI.Text:create()
        baseText:init(string.format("%s",data), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        baseText:setTextLeft()
        local textUp = centerUp - baseText:getContentSize().height/2
        baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
        self._scrollLayout:addChild(baseText)

        if(baseText._width > 244) then 
            baseText:setWidth(244)
            baseText:setSize(baseText:getContentSize().width, baseText:getContentSize().height)
            baseText:leftUp(leftOffset + pointBaseOffset + point._width, textUp)
        end
        
        totalHeight = totalHeight + baseText:getContentSize().height
        k = i
    end
    self._scrollLayout:setSize(258, totalHeight)
    --强化框
    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:center(gridXOffset, gridYOffset)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setTouchEnable(true)
    -- self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    -- self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    -- self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mGoodsGrid:showInfoArea();
    self.mGoodsGrid.state = gridType.goods
    self.strengLayer.rightMateralNode:addChild(self.mGoodsGrid, 10)
    
    --强化材料框
    self.mMaterialGoodsGrid = UI.GoodsGrid:create()
    self.mMaterialGoodsGrid:init()
    self.mMaterialGoodsGrid:center(gridXOffset, gridYOffset)
    self.mMaterialGoodsGrid:hide()
    self.mMaterialGoodsGrid:hideCountLabel()
    self.mMaterialGoodsGrid:hideNewIcon()
    self.mMaterialGoodsGrid:setTouchEnable(true)
    self.mMaterialGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mMaterialGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mMaterialGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mMaterialGoodsGrid:showInfoArea();
    self.mMaterialGoodsGrid.state = gridType.goods
    self.mMaterialGoodsGrid:hideAllAnimation()
    self.strengLayer.leftMateralNode:addChild(self.mMaterialGoodsGrid, 10)


    
    -- for i = 1,7 do
    --     local itemModel = model.createattChangeModel()
    --     local txtProperty = itemModel.root
    --     txtProperty.model = itemModel;
    --     txtProperty:centerUp(240 + 26 * i)
    --     self.strengLayer.root:addChild(txtProperty,100)
    --     txtProperty:setVisible(false)
    --     table.insert(self.mPropertyList,txtProperty)
    -- end

    self.mTxtNeedNum = self.makeEquipModel.executeButtonPrice
    self.mTxtNeedNum:setText(0)
    self.mNeedIcon = self.makeEquipModel.executeButtonIcon

    self.strengthenSpine = UI.Animation:create()
    self.strengthenSpine:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    self.strengthenSpine:center()
    self.strengLayer.leftMateralNode:addChild(self.strengthenSpine,10)

    self.strengthenMaterialSpine = UI.Animation:create()
    self.strengthenMaterialSpine:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    self.strengthenMaterialSpine:center()
    self.strengLayer.rightMateralNode:addChild(self.strengthenMaterialSpine,10)

    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0 --"all"
    _usedType1.needConvert = true -- 是否需要筛选可以转化升级的装备

    --CO-6975【装备转换】在转换界面，没有将背包内所有可用装备排序在前(策划还没有想清楚，延后应用)
    -- _usedType1.sortFunc = function(goodsA, goodsB)
    --     local isConvertA = false
    --     local isConvertB = false
    --     if goodsA:getEquipmentType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
    --         isConvertA = Config.Manager:getEquipConvert(goodsA:getId())
    --     end
    --     if goodsB:getEquipmentType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
    --         isConvertB = Config.Manager:getEquipConvert(goodsB:getId())
    --     end

    --     if isConvertB and isConvertA then
    --         return goodsA:getEntityID() < goodsB:getEntityID()
    --     end

    --     if isConvertA then
    --         return true
    --     end
    --     if isConvertB then
    --         return false
    --     end
    --     return goodsA:getEntityID() < goodsB:getEntityID()
    -- end
    table.insert(usedTypeList, _usedType1)

    --右边背包数据
    local bagList = UI.BagGoodsPanel:create(usedTypeList, false, false)
    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self.rootLayer:addChild(bagList, 2)
    local bagListW, bagListH = bagList:getSize()
    self._bagGridList:changeBagDefaultIndex(2)

    self.runSuccess = false
    self.strengAnimation:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "audio_action" then
                if self.runSuccess then
                    Avalon.AudioManager:playSound("1517")
                else
                    Avalon.AudioManager:playSound("1518")
                end
            elseif event.eventData.name == "audio_prepare" then
                Avalon.AudioManager:playSound("1512")
            end
        end
    end)
    
    self:setDoorNode(self.leftLayer, bagList)

    self:updateBtnState();
    GameManager:showNPCInfomation(self.spriteID, UI.TEXT_1212280)


    local text = UI.Text:create()
    text:init(UI.TEXT_1212273, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    text:setSize(263,49)
    text:centerBottom(22)
    text:setTextCenter()
    self.strengLayer.strengChanceBg:addChild(text)

    self.strengLayer.arrowIcon:setImageScaleX(-1)
    self.equipNameLabel:setText(UI.TEXT_1212282)
end
--刷新改造按钮
function EquipConvertLayer:updateBtnState()
    local saveData = MasterDataManager:getRepeatHandleData(RepeatHandleType.CONVERT)
    if saveData then
        self.mBtnStrengthen:disable()
        return
    end
    if  self.mGoodsData == nil then
    -- if not self.mCanStrengthen or self.mGoodsData == nil or self.mMaterialGoodsData == nil then
        self.mBtnStrengthen:disable()
        self.mTxtStrengthen:setFontColor(UI.FONT_COLOR_182_201_201)
        self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_182_201_201)
    else
        self.mBtnStrengthen:enable()
        self.mTxtStrengthen:setFontColor(UI.FONT_COLOR_220_182_80)
        self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_220_182_80)
    end
    self:updateNeed()
end
function EquipConvertLayer:updateNeed(index)
    -- print(index)
    if self.materialObj then
        self.materialObj:removeFromParent()
        self.materialObj = nil
    end

    if not self.mGoodsData then
        self.mTxtNeedNum:setText(0)
        self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_220_182_80)
        self.mNeedIcon:setVisible(true)
        return
    end
   
    local config = Config.Manager:getEquipConvert(self.mGoodsData:getId())
    if gridType.goods == self.costType then
        local goodsId = config.goodsIDs[1]
        local goodsData = GoodsDataManager:createLocalGoodsData(goodsId)
        local grid = UI.GoodsGrid:create()
        grid:init()
        grid:hideCountLabel()
        grid:setTouchEnable(false)
        grid:hideNewIcon()
        grid:hideIcon()
        grid:hideRare()
        grid:hideBG()
        grid:setData(goodsData)
        grid:centerLeft(58)
        grid:setScale(0.6)
        self.mBtnStrengthen:addChild(grid, 100)
        grid:hideNewIcon()
        self.materialObj = grid

        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsId, true)
        if goodNumber > config.goodsNums[1] then
            self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_220_182_80)
        else
            self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end

        self.mTxtNeedNum:setText(config.goodsNums[1])
        self.mNeedIcon:setVisible(false)
    else

        local heroData = RoleDataManager:getMaster()
        if not Avalon.MathUtil:checkDiamonEnough(config.crystalNum, heroData:getDiamond()) then
            self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_220_182_80)
        end
        self.mTxtNeedNum:setText(config.crystalNum)
        self.mNeedIcon:setVisible(true)
    end
end
--强化
function EquipConvertLayer:onStrengthen()
    if not self.mGoodsData then
        return
    end
    if self.isAnimation then
        return
    end
    
    local config = Config.Manager:getEquipConvert(self.mGoodsData:getId())
    if gridType.goods == self.costType then
        local goodsId = config.goodsIDs[1]
        local needNum = config.goodsNums[1]
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsId, true)
        if goodNumber < needNum then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170213))
            return
        end
    else
        local heroData = RoleDataManager:getMaster()
        if not Avalon.MathUtil:checkDiamonEnough(config.crystalNum, heroData:getDiamond()) then
            -- UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110374))
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
    end
    local data = {}
    data.goodsID = tonumber(self.mGoodsData:getId())
            data.num = tonumber(1)
    --背包满
    if(GameDataManager:getInstance():judgeEnoughPacketForGoodsArr({data}) == false) then 
        UI.ScrollBar:createByTextID(1110793)
        return
    end 

    UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212279, function()
        MasterDataManager:setRepeatHandleData(RepeatHandleType.CONVERT, true)
        Net.NetNPCSystem:reqConveretEquip(self.mGoodsData,self.costType,self.spriteID)
    end)

end


function EquipConvertLayer:onCostTypeChange(self,tabIndex)
    -- print("tabIndex",tabIndex)
    self.costType = tabIndex
    self:updateNeed()
end

function EquipConvertLayer:onTouchBeganByGoodsGrid(grid, touchPosition)

    if self.mCanStrengthen == false then
        return false
    end

    self:runReadyAnimtion(true, grid.state)

    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
    return true
end

function EquipConvertLayer:onTouchEndedByGoodsGrid(grid, inSide)
    if ( tolua.isnull(self) or  tolua.isnull(grid)) then 
        return
    end
    
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if inSide then
        self:runPutAnimtion()
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()
        self.mGoodsData._changeNum = 0
        self.mGoodsData = nil
        self:refreshGoodsGrid()
        self:showConvertInfo()

    GameManager:showNPCInfomation(self.spriteID, UI.TEXT_1212280)
        self._bagGridList:refreshView()
        self:runCancelReadyAnimtion()
        self:updateNeed()

    end
end


function EquipConvertLayer:runReadyAnimtion(isDragOut)
    self.strengthenSpine:setAnimation("ready1", false)
end
function EquipConvertLayer:runCancelReadyAnimtion(gridId)
    self.strengthenSpine:setAnimation("ready3", false)
end
function EquipConvertLayer:runPutAnimtion()
    self.strengthenSpine:setAnimation("putin1", false)
end

function EquipConvertLayer:runSuccessAnimtion()
    self.runSuccess = true
    self.fireAnimation:setAnimation("trigger", false)
    self.fireAnimation2:setAnimation("trigger2", false)
    self.strengthenSpine:setAnimation("trigger", false)
    self.strengthenMaterialSpine:setAnimation("ready3", false)
    self.strengAnimation:setAnimation("success", false);
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110843))
end

function EquipConvertLayer:runFailedAnimtion()
    self.runSuccess = false
    self.fireAnimation:setAnimation("trigger", false)
    self.fireAnimation2:setAnimation("trigger2", false)
    self.strengthenSpine:setAnimation("ready3", false)
    self.strengthenMaterialSpine:setAnimation("ready3", false)
    self.strengAnimation:setAnimation("fail", false);
    UI.ScrollBar:createByText(UI.TEXT_1212029)
end
function EquipConvertLayer:bagDragBeganCallback(grid, touchPosition)
    if (grid) then
        grid:hideSelect()
    end

    self:runReadyAnimtion(false)

    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
end

function EquipConvertLayer:bagDragMovedCallback(grid, touchPosition)
    -- print("EquipConvertLayer:bagDragMovedCallback",touchPosition.x,touchPosition.y)
end

function EquipConvertLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    if self.isAnimation then
        return
    end
    
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    


    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))

    if not isInBag then
        local t = self.mGoodsGrid:convertToWorldSpace(cc.p(0, 0))
        local _rect = cc.rect(t.x, t.y, self.mGoodsGrid:getContentSize().width, self.mGoodsGrid:getContentSize().height)
        local goodsData = grid:getData()
        -- if cc.rectContainsPoint(_rect, touchPosition) then
            

            if self.mGoodsData ~= nil then
                self.mGoodsData._changeNum = 0
            end
            goodsData._changeNum = -1
            self.mGoodsData = goodsData
            self._bagGridList:refreshView()
            self:refreshGoodsGrid()

            GameManager:showNPCInfomation(self.spriteID, UI.TEXT_1212281)
            
            self:showConvertInfo()
            self:runPutAnimtion()

            if self.mFinishAnimation then
                self.finishAnimation:setAnimation("ready3", false)
                self.mFinishAnimation = nil
            end
    
    else
        self:runCancelReadyAnimtion();
    end
end
function EquipConvertLayer:showConvertInfo()
    if self.mGoodsGrid then
        if self.mGoodsData then
            local config = Config.Manager:getEquipConvert(self.mGoodsData:getId())
            local targetId = config.targetEquipID
            local goodsData = GoodsDataManager:createLocalGoodsData(targetId)
            goodsData.fromConvertedGoodsData=self.mGoodsData
            self.mGoodsGrid:setData(goodsData)
            self.mGoodsGrid:setInfoArea(true, false)

            self.mGoodsGrid:updateView()
            self.mGoodsGrid:show()
        else
            self.mGoodsGrid:setVisible(false) 
        end
    end
end
--刷新强化装备
function EquipConvertLayer:refreshGoodsGrid()
    if self.mMaterialGoodsGrid then
        if self.mGoodsData then
            self.mMaterialGoodsGrid:setData(self.mGoodsData)

            self.mMaterialGoodsGrid:setVisible(true)
            self.mMaterialGoodsGrid:center(gridXOffset, gridYOffset)

            self.mMaterialGoodsGrid:hideCountLabel()
            self.mMaterialGoodsGrid:hideNewIcon()
            self.mMaterialGoodsGrid:hideBG()
            self.mMaterialGoodsGrid:updateView()
            
        else
            self.mMaterialGoodsGrid:setVisible(false)
        end
        self:updateBtnState()
    end
end


function EquipConvertLayer:FireAnimationCallback(event, obj)
    if event.animation == "trigger" then
        self.mFinishAnimation = true

        local newData = GoodsDataManager:getEquipmentForEntityID(self.mGoodsData:getEntityID())
        self.mGoodsGrid:setData(newData)
        self.mGoodsGrid:setInfoArea(false, false)
        self.mGoodsData = nil
        self.finishAnimation:addAnimation("ready2", true)
        self._bagGridList:updateCanDrag(true)
        self:refreshGoodsGrid()
        self:runCancelReadyAnimtion()
        self.isAnimation = false

    end
end
function EquipConvertLayer:handleConvertResult(data)
--     OK = 1;                     // 成功                      
--     SysError = 2;               // 系统错误
--     ItemNotEnough = 3;          // 材料不足
--     ConvertFaild = 4;           // 转换失败

    if data.errorNo ~= "OK" then
        -- UI.ScrollBar:createByText("data.errorNo")
        if data.errorNo == "SysError" then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111118))
        elseif data.errorNo == "ItemNotEnough" then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170213))
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111803))
        end
        return
    end


    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111802))

    self.isAnimation = true
    self.mMaterialGoodsGrid:setVisible(false)
    if not self.finishAnimation then
        local finishAnimation = UI.Animation:create()
        self.finishAnimation = finishAnimation
        finishAnimation:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1)
        finishAnimation:setLayoutType(UI.LayoutDefaultType.DEFAULT)
        finishAnimation:center()
        finishAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, self.FireAnimationCallback)
        self.strengLayer.rightMateralNode:addChild(finishAnimation, 200)
    end
    self.finishAnimation:setAnimation("trigger", false)

    self:updateNeed()
end

function EquipConvertLayer:onCurrencyChangeHandler()
    self:updateNeed()
end

-- 注册监听事件(可选)
function EquipConvertLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GEM_CONVERT, self, self.handleConvertResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

-- 注销监听事件(可选)
function EquipConvertLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GEM_CONVERT, self, self.handleConvertResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end


return EquipConvertLayer 
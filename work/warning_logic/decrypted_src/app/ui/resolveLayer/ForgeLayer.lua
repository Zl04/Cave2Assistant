-- Author:CHENZIHAN
-- Using:锻造UI
require "app.ui.shoplayer.BagGoodsPanel"
local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.EquipWorkshop")

UI = UI or {}

local ForgeLayer = class("ForgeLayer", UI.DoorWin)
UI.ForgeLayer = ForgeLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_blacksmith.plist",
}


--构造函数(必备)
function ForgeLayer:ctor(spriteID)
    --窗口大小
    ForgeLayer.super.ctor(
    self,UIType.FORGE_LAYER,
    COM_RES_LIST,
    318,    
    winSize.height
    )
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.mGoodsData = nil;          --装备
    self.mGoodsGrid = nil;          --装备框

    self.mSelectArrIndex = 0;            --选中的属性

    self.mPropertyBtnList = {};     --属性列表

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();

    self.materEnough = false;
    self.moneyEnough = false
    self.mCanRemould = true;       --是否能分解
    self._mTime = 3
    self.mSchedulerID = 0

    self.mGoodsGrid2 = nil 
    self.needNumText2 =nil 
    self.iconNameText2= nil 
    self.materGoodsGridList = {}
end

--虚构函数,destroy时调用(必备)
function ForgeLayer:dtor()
    ForgeLayer.super.dtor(self)
    self:unRegisterListener();
    local scheduler=cc.Director:getInstance():getScheduler()
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
end

-- 初始化(必备)
function ForgeLayer:init()
    ForgeLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function ForgeLayer:onInitView()
    -- self:addColorBG()        --灰色遮罩层

    --root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width, winSize.height))
    self.rootLayer:setPosition(cc.p(0,0))
    self:addChild(self.rootLayer)

    self.makeEquipModel = model.createmakeEquipNode()
    self.leftLayer = self.makeEquipModel.root
    self.leftLayer:centerLeft(0)
    self.rootLayer:addChild(self.leftLayer, 100)
    self.executeButtonLabelXPos = self.makeEquipModel.executeButtonLabel._posX

    self.forgeLayer = model.createForgeLayer()
    self.forgeLayer.root:leftUp(96, 0)
    self.forgeLayer.root:setVisible(true)
    self.leftLayer:addChild(self.forgeLayer.root)

    self.fireAnimation = self.makeEquipModel.fireAnimation
    self.fireAnimation:addEventListener(UIEvent.ANIMATION_END, self, self.FireAnimationCallback)
    self.fireAnimation2 = self.makeEquipModel.fireAnimationFront

    --装备的名字
    self.mTxtEquipName = self.makeEquipModel.titleStr

    self.costType2Icon = self.makeEquipModel.executeButtonIcon
    self.costType2Vale = self.makeEquipModel.executeButtonPrice

    --锻造按钮
    self.mBtnRemould = self.makeEquipModel.executeButton
    self.mBtnRemould:addEventListener(UIEvent.BUTTON_CLICK,self,self.onRemould)
    AvalonUtil.addBracketsAnimationToButton(self.mBtnRemould)

    -- 锻造文字
    self.mTxtRemould = self.makeEquipModel.executeButtonLabel
    self.mTxtRemould:setText(UI.TEXT_1110396)

    -- 锻造装备的格子
    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:leftUp(5, 3)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setTouchEnable(true)
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mGoodsGrid:showInfoArea()
    self.forgeLayer.materalNodeForge:addChild(self.mGoodsGrid, 10)

    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    _usedType1.type = PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll

    table.insert(usedTypeList,_usedType1)


    --右边背包数据
    local bagList = UI.BagGoodsPanel:create(usedTypeList, true, false)
    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self.rootLayer:addChild(bagList,5)
    local bagListW,bagListH = bagList:getSize()
    bagList:leftBottom(winSize.width + bagListW,300 - bagListH/2)
    bagList:changeBagDefaultIndex(2)
    
    -- 边框特效
    self.remouldSpine = UI.Animation:create()
    self.remouldSpine:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1);
    self.remouldSpine:center()
    self.forgeLayer.materalNodeForge:addChild(self.remouldSpine, 10)

    self:refreshCurrency()

    self:setOpeCallBack(function()
        local saveData = MasterDataManager:getRepeatHandleData(RepeatHandleType.FORGE)
        if saveData then
            self:reductionInfo(saveData)
        end
    end)

    self.remouldSpine:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "audio_action" then
                Avalon.AudioManager:playSound("1517")
            elseif event.eventData.name == "audio_prepare" then
                Avalon.AudioManager:playSound("1512")
            end
        end
    end)

    self:setDoorNode(self.leftLayer, bagList)
    
    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110432))
    self._bagGridList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.MATERIAL) --默认切换到 第五页 材料
    self:resetSpineAnimation();
end

function ForgeLayer:resetSpineAnimation()
    self.fireAnimation:setAnimation("begin", false)
    self.remouldSpine:setAnimation("begin", false)
    self.fireAnimation2:setAnimation("begin", false)
    self:refreshGoodsGrid(true)
end

function ForgeLayer:runReadyAnimtion(isDragOut)
    if isDragOut ~= nil and isDragOut == true then
        self.fireAnimation:setAnimation("putin3", false)
        self.fireAnimation:addAnimation("ready2", true)
    else
        self.fireAnimation:setAnimation("ready1", false)
        self.fireAnimation:addAnimation("ready2", true)
        self.remouldSpine:setAnimation("ready1", false)
        self.fireAnimation2:setAnimation("ready1", false)
    end
    self.mGoodsGrid:setLocalZOrder(20)
end

function ForgeLayer:runCancelReadyAnimtion()
    self.fireAnimation:setAnimation("ready3", false)
    self.remouldSpine:setAnimation("ready3", false)
    self.fireAnimation2:setAnimation("ready3", false)
end

function ForgeLayer:runPutAnimtion()
    self.fireAnimation:setAnimation("putin1", false)
    self.fireAnimation:addAnimation("putin2", true)
    self.fireAnimation2:setAnimation("putin1", false)
    self.remouldSpine:setAnimation("putin1", false)
    self.mGoodsGrid:setLocalZOrder(0)
end

function ForgeLayer:runSuccessAnimtion()
    self.fireAnimation:setAnimation("trigger", false)
    self.fireAnimation2:setAnimation("trigger2", false)
    self.remouldSpine:setAnimation("trigger", false)
    for k, v in ipairs(self.materGoodsGridList) do
        v.usedAnimation:setAnimation("trigger", false)
    end
end

function ForgeLayer:FireAnimationCallback(event, obj)
    if event.animation == "trigger" then
        self:refreshCurrency()
        self.mGoodsData = nil
        self.mCanRemould = true
        self._bagGridList:updateCanDrag(true)
        self.mGoodsGrid:setVisible(false)
        self.centerLayout:setVisible(false)
        self:updateGridState(true, false)

        self:refreshGoodsGrid()
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110432))
    end
end

-- 背包格子开始拖动
function ForgeLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end
    self._bagGridList:setSpineBgVisible(true)
    self:runReadyAnimtion()
end

function ForgeLayer:bagDragMovedCallback(grid, touchPosition)
end

function ForgeLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    self._bagGridList:setSpineBgVisible(false)

    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))

    if not isInBag then
        local goodsData = grid:getData()
        if goodsData:getIsLock() then
            UI.ScrollBar:createByText(UI.TEXT_110030)
            self:runCancelReadyAnimtion()
            return
        end
        local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
        if freePacketNum <= 0 then
            UI.ScrollBar:createByTextID(1110793)
            self:runCancelReadyAnimtion()
            return
        end

        if self.mGoodsData ~= nil then
            self.mGoodsData._changeNum = 0
        end
        goodsData._changeNum = -1
        self.mGoodsData = goodsData --self.mGoodsData._changeNum = -1
        self:refreshAllInfo(goodsData)

        self._bagGridList:refreshView()
        self:refreshGoodsGrid()
        self:runPutAnimtion()
    else
        self:runCancelReadyAnimtion()
    end
end 

-- 模版函数：更新组建的视图(必备)
function ForgeLayer:onUpdateView()
end

--刷新分解材料
function ForgeLayer:refreshGoodsGrid()
    if self.mGoodsData then
        self.mGoodsGrid:setData(self.mGoodsData)
        self.mGoodsGrid:updateView()
        self.mGoodsGrid:show()
        self.mGoodsGrid:hideCountLabel()
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideBG()

        self.mTxtEquipName:setVisible(true)
        self.mTxtEquipName:setText(UI.TEXT_1212027)

        local remouldMark = false
    else
        self.mGoodsGrid:hide()
    end
end

--
function ForgeLayer:refreshAllInfo(goodsData)
    self:refreshCurrency(goodsData)

    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110433))
end

--刷新所需材料
function ForgeLayer:refreshMaterGrid(goodsData)
    self.materGoodsGridList = {}
    local disableBtn = false
    local needIds = {};
    local needNums = {}
    if goodsData then
        local goodstype  = goodsData:getMaterialType()
        if goodstype ~= 2 then
            UI.ScrollBar:createByText(UI.TEXT_1170021)
        end
        local materData = ConfigManager:getMaterialConfigByID(goodsData.goodsID)
        self.materData = materData
        -- 需要的材料ID
        needIds = AvalonUtil:splitStr(materData.value3, ",")
        -- 需要的材料ID对应的数量
        needNums = AvalonUtil:splitStr(materData.value4, ",")
    end

    if self.centerLayout then
        self.centerLayout:removeFromParent()
    end
    self.centerLayout = UI.Layout:create()
    self.centerLayout:init()
    self.centerLayout:centerUp(235)
    self.centerLayout:setSize(250, 320)
    self.leftLayer:addChild(self.centerLayout, 99)

    local cellSize = 2
    for i = 1, 4 do 
        local itemModel = model.createForgeMaterialModel()

        local indexY = math.ceil(i / cellSize)
        local indexX = i % cellSize
        if indexX == 0 then
            indexX = cellSize
        end
        itemModel.root:leftUp(0 + (indexX - 1) * 130, 2 + (indexY - 1) * 143)
        itemModel.ForgeMaterialName:setVisible(false)
        if(needIds[i] and needNums[i]) then
            itemModel.ForgeMaterialName:setVisible(true)

            local needId = tonumber(needIds[i])
            local needNum = tonumber(needNums[i])
            local percent = MasterDataManager:getEffValueByEffType(PublicDefine.ATTR_TYPE.ForgeDiscountRate)
            if percent > 0 then
                needNum = math.ceil(needNum * (RATIO_NUMBER - percent) / RATIO_NUMBER)
            end
            
            local materGoodsGrid = UI.GoodsGrid:create()
            materGoodsGrid:init()
            materGoodsGrid:hideCountLabel()
            materGoodsGrid:setTouchEnable(true)
            materGoodsGrid:showInfoArea()
            materGoodsGrid:leftUp(20, 1)
            itemModel.root:addChild(materGoodsGrid)


            local usedAnimation = UI.Animation:create()
            usedAnimation:init("effect_ui_town_blacksmith_forge_split.json", "effect_ui_town_blacksmith_forge_split.atlas", 1);
            usedAnimation:center()
            materGoodsGrid:addChild(usedAnimation,10)

            materGoodsGrid.usedAnimation = usedAnimation
            --usedAnimation:setAnimation("trigger", true)

            local needNumText = UI.Text:create()
            needNumText:init()
            needNumText:setFontColor(UI.FONT_COLOR_247_245_232)
            needNumText:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
            needNumText:setFontSize(14)
            needNumText:setSize(80,20)
            needNumText:setTextRight()
            needNumText:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
            needNumText:rightUp(16, 54)
            itemModel.root:addChild(needNumText)

            local iconNameText = itemModel.ForgeMaterialName
            local goodsCount =  GameDataManager:getInstance():getGoodsDataNum(PublicDefine.PACKET_TYPE.PACKET_BAG,needId,false)
            local newGoodsData = GoodsDataManager:createLocalGoodsData(needId)
            if(newGoodsData) then
                local iconName = newGoodsData:getName()
                newGoodsData:setIsNew(false)
                materGoodsGrid:setData(newGoodsData)
                needNumText:setText(string.format(UI.TEXT_1170023,goodsCount,needNum))
                iconNameText:setText(iconName)
                --iconNameText:setFontColor(UI.ITEM_QUALITY_FONT_COLOR[newGoodsData:getGoodsRare()])
            end 
            
            if(goodsCount < needNum) then 
                iconNameText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH_FOR_FORGE)
                needNumText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
                disableBtn = true
            end 
            table.insert(self.materGoodsGridList, materGoodsGrid)
        end 
        self.centerLayout:addChild(itemModel.root)
    end
    self.materEnough = not disableBtn
end

--刷新改造按钮
function ForgeLayer:updateBtnState()
    local enough = (self.materEnough)
    if self.mCanRemould == false or self.mGoodsData == nil or not enough then
        self.mBtnRemould:disable()
        self.mTxtRemould:setFontColor(UI.FONT_COLOR_182_201_201)
        self.costType2Vale:setFontColor(UI.FONT_COLOR_182_201_201)
    else
        self.mBtnRemould:enable()
        self.mTxtRemould:setFontColor(UI.FONT_COLOR_220_182_80)
        self.costType2Vale:setFontColor(UI.FONT_COLOR_220_182_80)
    end
end

function ForgeLayer:onTouchBeganByGoodsGrid(grid,touchPosition)
    if self.mCanRemould == false then
        return false
    end
    self:runReadyAnimtion(true)
    self._bagGridList:setSpineBgVisible(true) 
    return true
end

function ForgeLayer:onTouchEndedByGoodsGrid(grid, inSide)
    if self.mCanRemould == false then
        return
    end

    self._bagGridList:setSpineBgVisible(false) 

    if inSide then
        self.centerLayout:setVisible(true)
        self:runPutAnimtion();
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()
        
        local goodsData = grid:getData()
        self.mGoodsData._changeNum = 0

        self._bagGridList:changeBagIndex(self._bagGridList:getChangeBagIndexByGoodsData(goodsData))

        self.mGoodsData = nil
        self.materData = nil

        self:refreshGoodsGrid()
        self._bagGridList:refreshView()
        self.centerLayout:setVisible(false)
        self:refreshCurrency()
        self.mBtnRemould:disable()
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110432))
        self:runCancelReadyAnimtion();
    end    
end

function ForgeLayer:onRemould()
    if self.mCanRemould == false or self.mGoodsData == nil then
        return
    end
    --todo 条件判断
    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if freePacketNum <= 0 then
        UI.ScrollBar:createByTextID(1110793)
        return
    end
    if self.materData ~= nil then
        local costType = self.materData.value5
        local costValue = self.materData.value6
        if(tonumber(costType) == 1) then  -- 金币
            if GameDataManager:getInstance():getCurCoin() < tonumber(costValue) then
                -- UI.TipsLayer:onGlodNotEnough()
                UI.ScrollBar:createByText(UI.TEXT_110210)
                return
            end
        elseif (tonumber(costType) == 2) then -- 水晶
            if not Avalon.MathUtil:checkDiamonEnough(tonumber(costValue), GameDataManager:getInstance():getDiamond()) then
                UI.TipsLayer:onDiamondNotEnough()
                return
            end
        end 
    end

    --检查角色  行为是否合法
    if RoleBehaviorManager:equipTownNpcCheck() then
        printWarn(" been blocked when using equipment npc forge function !")
        return
    end
    -- 锻造 发送分解的消息
    Net.NetNPCSystem:sendForge(self.mGoodsData, self.spriteID)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    --防止重复发送 阻塞
    local saveData = {}
    local simpleGoodsdata = {}
    simpleGoodsdata.goodsId = self.mGoodsData:getId()
    simpleGoodsdata.isGold = self.mGoodsData:getIsGolden()
    if (self.mGoodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
        simpleGoodsdata.entityId = self.mGoodsData:getEntityID()
    end
    saveData.equipmentGoods = simpleGoodsdata
    MasterDataManager:setRepeatHandleData(RepeatHandleType.FORGE, saveData)
    self:updateGridState(false, true)

    self._bagGridList:updateCanDrag(false)
    self.mCanRemould = false
end

--改造网络回调
function ForgeLayer:remouldCallBack(data)
    UI.WaitingLayer:hideWaiting()

    if data.result == "ForgeType_Succeed" then
        self.mGoodsData._changeNum = 0
        self._bagGridList:refreshView()
        self:runSuccessAnimtion();
    else
        self.mCanRemould = true
        self._bagGridList:updateCanDrag(true)
        self:refreshCurrency()
    end
    self.materData = nil;
end

function ForgeLayer:refreshCurrency(goodsData, doNotFrefreshMaterGrid)
    if doNotFrefreshMaterGrid == nil then
        self:refreshMaterGrid(goodsData)
    end
    self:updateBtnState()
    local costType = 1
    local costValue = 0
    self.moneyEnough = true;
    if self.materData  ~= nil then
        -- 花费的多少钱
        costType = self.materData.value5
        costValue = self.materData.value6
    end
    if(tonumber(costType) == 1) then  -- 金币
        self.costType2Icon:setSpriteName("symbol_gaming_money.png")
        self.costType2Vale:setText(costValue)
        self.costValue1 = costValue

        if GameDataManager:getInstance():getCurCoin() < tonumber(costValue) then
            if self.mCanRemould and self.mGoodsData ~= nil then
                self.costType2Vale:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            end
            self.moneyEnough = false;
        end
    elseif (tonumber(costType) == 2) then -- 水晶
        self.costType2Icon:setSpriteName("symbol_gaming_diamond.png")
        self.costType2Vale:setText(costValue)
        self.costValue2 = costValue
        if not Avalon.MathUtil:checkDiamonEnough(tonumber(costValue), GameDataManager:getInstance():getDiamond()) then
            if self.mCanRemould and self.mGoodsData ~= nil then
                self.costType2Vale:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            end
            self.moneyEnough = false
        end
    end
    AvalonUtil.updateIconStringLayout(self.makeEquipModel.priceLayer)
    self.makeEquipModel.executeButtonPrice:setVisible(costValue ~= 0)
    self.makeEquipModel.executeButtonIcon:setVisible(costValue ~= 0)
    if costValue == 0 then
        self.makeEquipModel.executeButtonLabel:show()
        self.makeEquipModel.titleStr:setText(UI.TEXT_1300000)
    else
        self.makeEquipModel.executeButtonLabel:hide()
    end
end

function ForgeLayer:onCurrencyChangeHandler()
    self:refreshCurrency(nil, true)
end

-- 注册监听事件(可选)
function ForgeLayer:registerListener()
    --监听窗口外关闭事件
    -- 分解结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_FORGE, self, self.remouldCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end


-- 注销监听事件(可选)
function ForgeLayer:unRegisterListener()
    --分解结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_FORGE, self, self.remouldCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

function ForgeLayer:reductionInfo(saveData)
    local equipmentGoods = saveData.equipmentGoods
    local goodsData = self._bagGridList:getGoodsDataArr(equipmentGoods.goodsId, equipmentGoods.isGold, equipmentGoods.entityId)[1] or {}
    self._bagGridList:updateCanDrag(false)
    self.mCanRemould = false

    if self.mGoodsData ~= nil then
        self.mGoodsData._changeNum = 0
    end
    goodsData._changeNum = -1
    self.mGoodsData = goodsData
    self._bagGridList:refreshView()

    self:refreshAllInfo(goodsData)
    self:refreshGoodsGrid()
    self:updateGridState(false, false)
end

--[[锁住左边格子， isDelay 仅表示延时刷新变灰状态（展示效果）]]
function ForgeLayer:updateGridState(isCanUse, isDelay)
    if not isDelay then
        for k, v in ipairs(self.materGoodsGridList) do
            v:updateCanUseState(isCanUse)
        end
    else 
        for k, v in ipairs(self.materGoodsGridList) do
            v:updateCanUseStateAndDelayRefresh(isCanUse, 0.3)
        end
    end
end



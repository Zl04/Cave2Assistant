-- StrengthenLayerPet.lua
-- Author:zp
-- 2021年6月7日
-- Using:宠物装备强化
require "app.ui.shoplayer.BagGoodsPanel"
local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.EquipWorkshop")
UI = UI or {}

local StrengthenLayerPet = class("StrengthenLayerPet", UI.DoorWin)
UI.StrengthenLayerPet = StrengthenLayerPet

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
local gridXOffset = 1
local gridYOffset = -1

local gridType = {
    goods = 1,
    material = 2
}

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_blacksmith.plist"
}

--构造函数(必备)
function StrengthenLayerPet:ctor(spriteID)
    --窗口大小
    StrengthenLayerPet.super.ctor(self, UIType.PET_STRENGTHEN_LAYER, COM_RES_LIST, 300, winSize.height)
    self.spriteID = spriteID
    self.rootLayer = nil --root节点
    self.mGoodsData = nil --装备
    self.mGoodsGrid = nil --装备框

    self.mMaterialGoodsData = nil --材料装备
    self.mMaterialGoodsGrid = nil --材料装备框

    self.mPropertyList = {} --属性列表

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:init()
    self:registerListener()

    self.mCanStrengthen = true --是否能强化

    self.npcInfomationNumByMaterial = 0
    print("self.mGoodsData", self.mGoodsData, self.mMaterialGoodsData)

    self.putGoods = false
    self.putMaterial = false
    self.alreadyCancelGoods = false;
    self.alreadyCancelMaterial = false
    self.costType = GOODS_COST_TYPE.GOLD
end

--虚构函数,destroy时调用(必备)
function StrengthenLayerPet:dtor()
    StrengthenLayerPet.super.dtor(self)
    self:unRegisterListener()
    reload_script_file("app.ui.strengthenLayer.StrengthenLayerPet")
end

-- 初始化(必备)
function StrengthenLayerPet:init()
    StrengthenLayerPet.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function StrengthenLayerPet:onInitView()
    self.rootLayer = cc.Layer:create()
    self.rootLayer:setContentSize(cc.size(winSize.width, winSize.height))
    self:addChild(self.rootLayer)

    self.makeEquipModel = model.createmakeEquipNode()
    self.leftLayer = self.makeEquipModel.root
    self.rootLayer:addChild(self.leftLayer, 1000)

    self.strengLayer = model.createstrengLayer()
    self.strengLayer.root:leftUp(96, 0)
    self.strengLayer.root:setVisible(true)
    self.leftLayer:addChild(self.strengLayer.root);

    self.fireAnimation = self.makeEquipModel.fireAnimation
    self.fireAnimation:addEventListener(UIEvent.ANIMATION_END, self, self.FireAnimationCallback)
    self.fireAnimation2 = self.makeEquipModel.fireAnimationFront
    self.strengAnimation = self.strengLayer.strengAnimation
    self.strengLayer.arrowIcon:setScaleX(-1)

    self.equipNameLabel = self.makeEquipModel.titleStr
    self.equipNameLabel:setText(UI.TEXT_1325903)

    self.mRateLayer = self.strengLayer.chanceDesLayer
    self.strengLayer.chanceDesLabel:setText(UI.TEXT_1325904)
    self.strengLayer.chanceDesLabel:setLayoutType(UI.LayoutDefaultType.CENTER)
    self.strengLayer.chanceNumberLbale:setText("")

    --强化btn
    self.mBtnStrengthen = self.makeEquipModel.executeButton
    self.mBtnStrengthen:addEventListener(UIEvent.BUTTON_CLICK, self, self.onStrengthen)
    self.mBtnStrengthen:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        if(self.mGoodsData == nil) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110423))
            return
        end

        if(self.mMaterialGoodsData == nil) then 
            UI.ScrollBar:createByText(UI.TEXT_1325909)
        end

        if(not self.curForgeMaterialEnough) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170317))
        end
    end)
    AvalonUtil.addBracketsAnimationToButton(self.mBtnStrengthen)
    self.mBtnStrengthen:setText("")

    self.mTxtStrengthen = self.makeEquipModel.executeButtonLabel
    self.mTxtStrengthen:setText("")
    self.makeEquipModel.executeButtonPrice:setLayoutType(UI.LayoutDefaultType.CENTER)
    self.makeEquipModel.executeButtonPrice:setText(UI.TEXT_110207)
    self.mTxtStrengthenXPos = self.mTxtStrengthen._posX;

    local functionTabList = UI.TabList:create()
    functionTabList:init(120)
    functionTabList:centerBottom(130)
    functionTabList:setTouchEnable(true)
    functionTabList:addEventListener(UIEvent.TAB_ACTIVE, self, handler(self,self.onCostTypeChange))
    functionTabList:setDefaultIndex(self.costType or GOODS_COST_TYPE.GOLD)
    self.makeEquipModel.makeEquipBg:addChild(functionTabList)
    functionTabList:setVisible(false)
    self.functionTabList = functionTabList

    local tab = UI.TabItem:create()
    tab:init("ui_btn_blacksmith_gold_0.png", "ui_btn_blacksmith_gold_1.png")
    -- tab:setChangeScale(false)
    functionTabList:addTab(tab)

    local tab = UI.TabItem:create()
    tab:init("ui_btn_blacksmith_crystal_0.png", "ui_btn_blacksmith_crystal_1.png")
    -- tab:setChangeScale(false)
    functionTabList:addTab(tab)
    
    --强化框
    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:center(gridXOffset, gridYOffset)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setTouchEnable(true)
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mGoodsGrid:showInfoArea();
    self.mGoodsGrid.state = gridType.goods
    self.strengLayer.leftMateralNode:addChild(self.mGoodsGrid, 10)

    --强化材料框
    self.mMaterialGoodsGrid = UI.GoodsGrid:create()
    self.mMaterialGoodsGrid:init()
    self.mMaterialGoodsGrid:center(gridXOffset, gridYOffset)
    self.mMaterialGoodsGrid:hide()
    self.mMaterialGoodsGrid:hideCountLabel()
    self.mMaterialGoodsGrid:hideNewIcon()
    self.mMaterialGoodsGrid:setTouchEnable(true)
    self.mMaterialGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    -- self.mMaterialGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    -- self.mMaterialGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mMaterialGoodsGrid:showInfoArea();
    self.mMaterialGoodsGrid.state = gridType.material
    self.mMaterialGoodsGrid:hideAllAnimation()
    self.strengLayer.rightMateralNode:addChild(self.mMaterialGoodsGrid, 10)

    -- 需求材料
    self:refreshStrengthMaterials()

    self.mNeedIcon = self.makeEquipModel.executeButtonIcon
    self.mNeedIcon:setVisible(false)

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
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
    _usedType1.type = 0 --"all"
    table.insert(usedTypeList, _usedType1)

    --右边背包数据
    local bagList = UI.BagGoodsPanel:create(usedTypeList, true, false)
    bagList:setHideBagType(
        {
            UI.BagGoodsPanel.BAG_TYPE.ALL,
            UI.BagGoodsPanel.BAG_TYPE.ITEM,
            UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
            UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
            UI.BagGoodsPanel.BAG_TYPE.RELIC,
        }
    )
    bagList:setShowBagTagExt(
        {
            UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
        }
    )
    bagList:init(nil, nil, FLITER_TYPE.EQUIPMENT_ONLY_SHOW_PET)
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
    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110426))
end
function StrengthenLayerPet:onCostTypeChange(self,tabIndex)
    -- print("tabIndex",tabIndex)
    self.costType = tabIndex
    self:updateNeed()
end
function StrengthenLayerPet:resetSpineAnimation()
    self.fireAnimation:setAnimation("begin", false)
    self.fireAnimation2:setAnimation("begin", false)
    self.strengthenSpine:setAnimation("begin", false)
    self.strengthenMaterialSpine:setAnimation("begin", false)
    self:refreshGoodsGrid(true)
end

function StrengthenLayerPet:refreshStrengthMaterials()
    local tmpLayout = self.strengLayer.root:getChildByName("materialLayout")
    if tmpLayout then
        self.strengLayer.root:removeChildByName("materialLayout")
    end

    if(self.mGoodsData == nil) then 
        return
    end

    local materialLayout = UI.Layout:create()
    materialLayout:init()
    materialLayout:setSize(262, 232)
    materialLayout:setName("materialLayout")
    materialLayout:centerBottom(-340)

    -- materialLayout:enableDebugDraw()
    self.strengLayer.root:addChild(materialLayout,100)

    -- 23020001,5000;28320001,1
    local strengthenNeesStr = self.mGoodsData:getStrengthenNeeds()
    -- strengthenNeesStr = strengthenNeesStr ..";"..strengthenNeesStr
    -- print("strengthenNeesStr=", strengthenNeesStr)
    local materialArr = string.split(strengthenNeesStr, ";")
    local slotLayoutW = 100
    if(materialArr and #materialArr > 0) then 
        self.curForgeMaterialEnough = true
        for k,str in ipairs(materialArr) do
            local strArr = string.split(str, ",")
            if(strArr and #strArr == 2) then
                local goodsID = tonumber(strArr[1])
                local goodsNum = tonumber(strArr[2])

                local slotLayout = UI.Layout:create();
                slotLayout:init();
                slotLayout:setSize(slotLayoutW, 120);
                if(k==1) then 
                    slotLayout:leftUp(20,0)
                elseif (k == 2) then 
                    slotLayout:rightUp(20,0)
                elseif (k==3) then     
                    slotLayout:leftBottom(20,0)
                elseif (k==4) then 
                    slotLayout:rightBottom(20,0)
                end
                materialLayout:addComponent(slotLayout)

                -- 锻造天赋对材料需求量有打折效果，需要进行判断
                local goodsData = GoodsDataManager:createLocalGoodsData(goodsID);
                if goodsData then
                    local goodsGrid = UI.GoodsGrid:create()
                    goodsGrid:init(goodsData)
                    goodsGrid:setTouchClipNode(slotLayout)
                    goodsGrid:centerUp(5)
                    goodsData:setIsNew(false)
                    goodsGrid:showInfoArea(false, false)
                    goodsGrid:setName("goodsSlot")
                    goodsGrid:hideCountLabel()
                    slotLayout:addChild(goodsGrid)

                    local prg = UI.Text:create()
                    prg:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_36_181_118)
                    prg:centerBottom(25)
                    prg:setName("prg")
                    local haveNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID)
                    prg:setText(tostring(goodsNum))
                    if haveNum < goodsNum then
                        prg:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)

                        self.curForgeMaterialEnough = false
                    else
                        prg:setFontColor(UI.FONT_COLOR_36_181_118)
                    end
                    slotLayout:addChild(prg)
                end
                -- self.materialSlots[k] = slotLayout
            end
        end
    end
end

function StrengthenLayerPet:runReadyAnimtion(isDragOut, gridId)
    if isDragOut ~= nil and isDragOut == true then
        if gridId == gridType.goods then
            self.putGoods = false
        elseif gridId == gridType.material then
            self.putMaterial = false
        end
        
        if self.putGoods == false and self.putMaterial == false then
            self.fireAnimation:setAnimation("putin3", false)
            self.fireAnimation:addAnimation("ready2", true)
        end
        if gridId == gridType.goods or gridId == nil then
            self.mGoodsGrid:setLocalZOrder(20)
        end
        if gridId == gridType.material or gridId == nil then
            self.mMaterialGoodsGrid:setLocalZOrder(20)
        end
    else
        if self.putGoods == false and self.putMaterial == false then
            self.fireAnimation:setAnimation("ready1", false)
            self.fireAnimation2:setAnimation("ready1", false)
            self.fireAnimation:addAnimation("ready2", true)
        end
        if (gridId == gridType.goods or gridId == nil) and self.putGoods == false then
            self.mGoodsGrid:setLocalZOrder(20)
            self.strengthenSpine:setAnimation("ready1", false)
            self.alreadyCancelGoods = false;
        end
        if (gridId == gridType.material or gridId == nil) and self.putMaterial == false then
            self.mMaterialGoodsGrid:setLocalZOrder(20)
            self.strengthenMaterialSpine:setAnimation("ready1", false)
            self.alreadyCancelMaterial = false
        end
    end
end

function StrengthenLayerPet:runCancelReadyAnimtion(gridId)
    print("runCancelReadyAnimtion = ", self.putGoods, self.putMaterial)
    if self.putGoods == false and self.putMaterial == false then
        self.fireAnimation:setAnimation("ready3", false)
        self.fireAnimation2:setAnimation("ready3", false)
    end

    if self.putGoods == false and self.alreadyCancelGoods == false then
        self.strengthenSpine:setAnimation("ready3", false)
        self.alreadyCancelGoods = true
    end
    if self.putMaterial == false and self.alreadyCancelMaterial == false  then
        self.strengthenMaterialSpine:setAnimation("ready3", false)
        self.alreadyCancelMaterial = true;
    end
end

function StrengthenLayerPet:runPutAnimtion(gridId, dragFromGridNode)
    if self.putGoods == false and self.putMaterial == false then
        self.fireAnimation:setAnimation("putin1", false)
        self.fireAnimation2:setAnimation("putin1", false)
        self.strengthenSpine:setAnimation("putin1", false)
        self.fireAnimation:addAnimation("putin2", true)
    end
    if gridId == gridType.goods then
        self.putGoods = true
        self.mGoodsGrid:setLocalZOrder(0)
        self.strengthenSpine:setAnimation("putin1", false)
    end
    if gridId == gridType.material then
        self.putMaterial = true
        self.mMaterialGoodsGrid:setLocalZOrder(0)
        self.strengthenMaterialSpine:setAnimation("putin1", false)
    end
    if self.putGoods == false and dragFromGridNode == nil then
        self.strengthenSpine:setAnimation("ready3", false)
        self.alreadyCancelGoods = true
    end
    if self.putMaterial == false and dragFromGridNode == nil then
        self.strengthenMaterialSpine:setAnimation("ready3", false)
        self.alreadyCancelMaterial = true
    end
end

function StrengthenLayerPet:runSuccessAnimtion()
    self.runSuccess = true
    self.fireAnimation:setAnimation("trigger", false)
    self.fireAnimation2:setAnimation("trigger2", false)
    self.strengthenSpine:setAnimation("trigger", false)
    -- self.strengthenMaterialSpine:setAnimation("ready3", false)
    -- self.strengAnimation:setAnimation("success", false);
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110843))
end

function StrengthenLayerPet:runFailedAnimtion()
    self.runSuccess = false
    self.fireAnimation:setAnimation("trigger", false)
    self.fireAnimation2:setAnimation("trigger2", false)
    self.strengthenSpine:setAnimation("ready3", false)
    -- self.strengthenMaterialSpine:setAnimation("ready3", false)
    -- self.strengAnimation:setAnimation("fail", false);
    UI.ScrollBar:createByText(UI.TEXT_1212029)
end

function StrengthenLayerPet:FireAnimationCallback(event, obj)
    if event.animation == "trigger" then
        local itemData = {}
        self.mGoodsData = nil
        self:refreshGoodsGrid()

        table.insert(itemData, self.mMaterialGoodsData)
        self.mMaterialGoodsData = nil
        self:refreshMaterialGoodsGrid()
        local strengtheData = self._strengtheData
        self._strengtheData = nil
        if(strengtheData) then
            if strengtheData.toType == ProtobufUtil:enum_id("PetSystem.StrengthenEquipmentToType", "StrengthenEquipmentToType_ByMail") then 
                UI.ScrollBar:createByText(UI.TEXT_1325907)
            elseif strengtheData.toType == ProtobufUtil:enum_id("PetSystem.StrengthenEquipmentToType", "StrengthenEquipmentToType_ToBag") then 
                UI.ScrollBar:createByText(UI.TEXT_1325908)
            end
        end
        Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
            if not tolua.isnull(self) then
                self:resetSpineAnimation()
            end
        end, 0.1)
        
        -- 展示获得的装备
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, UI.TEXT_1325906, nil, nil, true)
        self.mCanStrengthen = true
        self._bagGridList:updateCanDrag(true)
    end
end

function StrengthenLayerPet:bagDragBeganCallback(grid, touchPosition)
    if (grid) then
        grid:hideSelect()
    end

    self:runReadyAnimtion(false)

    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
end

function StrengthenLayerPet:bagDragMovedCallback(grid, touchPosition)
    -- print("StrengthenLayerPet:bagDragMovedCallback",touchPosition.x,touchPosition.y)
end

function StrengthenLayerPet:bagDragEndedCallback(grid, touchPosition, isInBag)
    -- print("StrengthenLayerPet:bagDragEndedCallback")
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))
    if not isInBag then
        local goodsData = grid:getData()

        local nextID = goodsData:getStrengthenNextEquipmentID()
        if(nextID and nextID ~= 0) then
            self.mMaterialGoodsData = GoodsDataManager:createLocalGoodsData(nextID)
        else
            self.mMaterialGoodsData = nil 
            UI.ScrollBar:createByText(UI.TEXT_1325909)
            self:runCancelReadyAnimtion();
            return
        end
        if self.mGoodsData ~= nil then
            self.mGoodsData._changeNum = 0
        end
        goodsData._changeNum = -1
        self.mGoodsData = goodsData
        self._bagGridList:refreshView()
        self:refreshGoodsGrid()

        self:refreshMaterialGoodsGrid()
        self:runPutAnimtion(gridType.goods)

        self:refreshStrengthMaterials()
        self:updateBtnState()
    else
        self:runCancelReadyAnimtion();
    end
end

-- 模版函数：更新组建的视图(必备)
function StrengthenLayerPet:onUpdateView()
    local saveData = MasterDataManager:getRepeatHandleData(RepeatHandleType.PET_STRENGTHEN)
    dump(saveData, "----StrengthenLayerPet----saveData")
    if saveData then
        self:reductionInfo(saveData)
    end
end

--刷新强化装备
function StrengthenLayerPet:refreshGoodsGrid()
    if self.mGoodsGrid then
        if self.mGoodsData then
            self.mGoodsGrid:setData(self.mGoodsData)

            self.mGoodsGrid:setVisible(true)
            self.mGoodsGrid:center(gridXOffset, gridYOffset)

            self.mGoodsGrid:hideCountLabel()
            self.mGoodsGrid:hideNewIcon()
            self.mGoodsGrid:hideBG()
            self.mGoodsGrid:updateView()
        else
            self.mGoodsGrid:setVisible(false)
        end
        self:updateBtnState()

        self:refreshStrengthMaterials()
    end
end

--刷新强化装备材料
function StrengthenLayerPet:refreshMaterialGoodsGrid()
    if self.mMaterialGoodsGrid then
        if self.mMaterialGoodsData then
            self.mMaterialGoodsGrid:setData(self.mMaterialGoodsData)
            self.mMaterialGoodsGrid:updateView()
            self.mMaterialGoodsGrid:show()
            self.mMaterialGoodsGrid:center(gridXOffset, gridYOffset)

            self.mMaterialGoodsGrid:hideCountLabel()
            self.mMaterialGoodsGrid:hideNewIcon()
            self.mMaterialGoodsGrid:hideBG()
        else
            self.mMaterialGoodsGrid:hide()
        end
        self:updateBtnState()
    end
end

--刷新强化消耗
function StrengthenLayerPet:updateNeed()
    local needNum = 0

    -- self.makeEquipModel.executeButtonLabel:show()
    -- self.equipNameLabel:setText(UI.TEXT_1300000)
end

--[[锁住左边格子， isDelay 仅表示延时刷新变灰状态（展示效果）]]
function StrengthenLayerPet:updateGridState(isCanUse, isDelay)
    print("-----------updateCanUseState")
    if not isDelay then
        self.mGoodsGrid:updateCanUseState(isCanUse)
        self.mMaterialGoodsGrid:updateCanUseState(isCanUse)
    else
        self.mGoodsGrid:updateCanUseStateAndDelayRefresh(isCanUse, 0.3)
        self.mMaterialGoodsGrid:updateCanUseStateAndDelayRefresh(isCanUse, 0.3)
    end
end

--刷新强化按钮
function StrengthenLayerPet:updateBtnState()
    local saveData = MasterDataManager:getRepeatHandleData(RepeatHandleType.PET_STRENGTHEN)
    if saveData then
        self.mBtnStrengthen:disable()
        return
    end
    if not self.mCanStrengthen 
        or not self.curForgeMaterialEnough 
        or self.mGoodsData == nil 
        or self.mMaterialGoodsData == nil then
        self.mBtnStrengthen:disable()
        self.mTxtStrengthen:setFontColor(UI.FONT_COLOR_182_201_201)
    else
        self.mBtnStrengthen:enable()
        self.mTxtStrengthen:setFontColor(UI.FONT_COLOR_220_182_80)
    end
    self:updateNeed()
end

function StrengthenLayerPet:onTouchBeganByGoodsGrid(grid, touchPosition)
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

function StrengthenLayerPet:onTouchEndedByGoodsGrid(grid, inSide)
    if (tolua.isnull(self) or tolua.isnull(grid)) then return end
    
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if inSide then
        self:runPutAnimtion(grid.state, true)
    else
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        local goodsData = grid:getData()
        goodsData._changeNum = 0
        -- self._bagGridList:changeBagIndex(self._bagGridList:getChangeBagIndexByGoodsData(goodsData))

            self.mGoodsData = nil
            self:refreshGoodsGrid()
            self.strengthenSpine:setAnimation("idle1_2", false)

            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110426))
            self.mMaterialGoodsData = nil
            self:refreshMaterialGoodsGrid()
            self.strengthenMaterialSpine:setAnimation("idle1_1", false)

            -- if (self.mGoodsData) then
            --     GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110427))
            -- end
        -- end

        self._bagGridList:refreshView()
        self:runCancelReadyAnimtion(grid.state)
    end
end

--强化
function StrengthenLayerPet:onStrengthen()
    if self.mCanStrengthen == false or self.mGoodsData == nil or self.mMaterialGoodsData == nil then
        return
    end

    local goodsEntityID = self.mGoodsData:getEntityID()
    local rolePetData = MasterDataManager:getPetDataForWearEquipmentID(goodsEntityID)
    local nowGoodsData = self.mGoodsData
    local function doRealStrengthen()
        --检查角色  行为是否合法
        if RoleBehaviorManager:equipTownNpcCheck() then
            printWarn(" been blocked when using equipment npc strengthen function !")
            return
        end
        --强化
        local petID = nil
        if(rolePetData) then 
            petID = rolePetData:getId()
        end

        -- GameDataManager:getInstance():getGoodsPacketType(equipmentGoodsData)
        local goodsPacketType = PublicDefine.PACKET_TYPE.PACKET_BAG
        if(rolePetData) then 
            goodsPacketType = PublicDefine.PACKET_TYPE.PACKET_PET_EQUIPMENT
        else
            goodsPacketType = GameDataManager:getInstance():getGoodsPacketType(nowGoodsData)
        end
        Net.NetPetSystem:strengthenEquipmentRequest(goodsEntityID, petID, goodsPacketType)
        -- Net.NetNPCSystem:sendStrengthen(self.mGoodsData, self.mMaterialGoodsData,self.costType,self.spriteID)
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

        self._bagGridList:updateCanDrag(false)
        self.mCanStrengthen = false
        self:updateBtnState()
        --

        --防止重复发送
        local saveData = {}
        local simpleGoodsdata = {}
        simpleGoodsdata.goodsId = nowGoodsData:getId()
        simpleGoodsdata.isGold = nowGoodsData:getIsGolden()
        if (nowGoodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
            simpleGoodsdata.entityId = nowGoodsData:getEntityID()
        end

        -- local simpleMaterialdata = {}
        -- simpleMaterialdata.goodsId = self.mMaterialGoodsData:getId()
        -- simpleMaterialdata.isGold = self.mMaterialGoodsData:getIsGolden()
        -- if (self.mMaterialGoodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
        --     simpleMaterialdata.entityId = self.mMaterialGoodsData:getEntityID()
        -- end

        saveData.equipmentGoods = simpleGoodsdata
        -- saveData.materialGoods = simpleMaterialdata
        MasterDataManager:setRepeatHandleData(RepeatHandleType.PET_STRENGTHEN, saveData)
        self:updateGridState(false, true)
    end

    -- 判断一下升级后的装备是否能够穿戴的问题
    if rolePetData and not self.mMaterialGoodsData:isAvailable(rolePetData:getStarLv()) then
        -- UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1325905, doRealStrengthen);
        --CO-19844
        --【宠物宝石】宝石升星后如果大于宠物星级，则打孔丢失
        UI.ScrollBar:createByText(UI.TEXT_1325912)
    else
        doRealStrengthen();
    end
end

--强化网络回调
function StrengthenLayerPet:strengthCallBack(data)
    self:updateGridState(true, false)
    UI.WaitingLayer:hideWaiting()

    if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
        self.strengthenSpine:setAnimation("star", false)
        self.strengthenSpine:addAnimation("success", false)
        -- self.strengthenMaterialSpine:setAnimation("idle1_1", false)
        self._strengtheData = data
        self:runSuccessAnimtion();
    else
        self.mCanStrengthen = true
        self._bagGridList:updateCanDrag(true)
    end
end

-- 监听钻石变化
function StrengthenLayerPet:onCurrencyChangeHandler()
    if self.mCanStrengthen then --在动画过程中 不能刷新
        self:updateBtnState()
    end
end
-- 注册监听事件(可选)
function StrengthenLayerPet:registerListener()
    --改造结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_STRENGTHEN_EQUIPMENT_RESULT, self, self.strengthCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

-- 注销监听事件(可选)
function StrengthenLayerPet:unRegisterListener()
    --改造结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_STRENGTHEN_EQUIPMENT_RESULT, self, self.strengthCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

function StrengthenLayerPet:reductionInfo(saveData)
    local equipmentGoods = saveData.equipmentGoods
    local materialGoods = saveData.materialGoods
    self.mGoodsData =
        self._bagGridList:getGoodsDataArr(equipmentGoods.goodsId, equipmentGoods.isGold, equipmentGoods.entityId)[1]
    local nextID = 0
    if(self.mGoodsData) then
        self.mGoodsData._changeNum = -1
        nextID = self.mGoodsData:getStrengthenNextEquipmentID()
    end
    nextID = self.mGoodsData:getStrengthenNextEquipmentID()
    if(nextID and nextID ~= 0) then
        self.mMaterialGoodsData = GoodsDataManager:createLocalGoodsData(nextID)
    else
        self.mMaterialGoodsData = nil 
    end
    self._bagGridList:updateCanDrag(false)
    self.mCanStrengthen = false
    self:refreshMaterialGoodsGrid()
    self:refreshGoodsGrid()
    self:updateGridState(false, false)
    self._bagGridList:refreshView()
end

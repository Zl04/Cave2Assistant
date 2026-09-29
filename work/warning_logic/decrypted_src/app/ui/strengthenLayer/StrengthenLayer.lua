-- StrengthenLayer.lua
-- Author:ODEI
-- 2017年7月17日
-- Using:强化
require "app.ui.shoplayer.BagGoodsPanel"
local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.EquipWorkshop")
UI = UI or {}

local StrengthenLayer = class("StrengthenLayer", UI.DoorWin)
UI.StrengthenLayer = StrengthenLayer

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
function StrengthenLayer:ctor(spriteID)
    --窗口大小
    StrengthenLayer.super.ctor(self, UIType.STRENGTHEN_LAYER, COM_RES_LIST, 300, winSize.height)
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
function StrengthenLayer:dtor()
    StrengthenLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化(必备)
function StrengthenLayer:init()
    StrengthenLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function StrengthenLayer:onInitView()
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
    self.mMaterialGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mMaterialGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mMaterialGoodsGrid:showInfoArea();
    self.mMaterialGoodsGrid.state = gridType.material
    self.mMaterialGoodsGrid:hideAllAnimation()
    self.strengLayer.rightMateralNode:addChild(self.mMaterialGoodsGrid, 10)

    for i = 1,7 do
        local itemModel = model.createattChangeModel()
        local txtProperty = itemModel.root
        txtProperty.model = itemModel;
        txtProperty:centerUp(240 + 26 * i)
        self.strengLayer.root:addChild(txtProperty,100)
        txtProperty:setVisible(false)
        table.insert(self.mPropertyList,txtProperty)
    end

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
            -- UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP
        }
    )
    bagList:setShowBagTagExt(
        {
            UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
        }
    )
    bagList:init(nil, nil, FLITER_TYPE.EQUIPMENT_ONLY_SHOW_HERO)
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
function StrengthenLayer:onCostTypeChange(self,tabIndex)
    -- print("tabIndex",tabIndex)
    self.costType = tabIndex
    self:updateNeed()
end
function StrengthenLayer:resetSpineAnimation()
    self.fireAnimation:setAnimation("begin", false)
    self.fireAnimation2:setAnimation("begin", false)
    self.strengthenSpine:setAnimation("begin", false)
    self.strengthenMaterialSpine:setAnimation("begin", false)
    self:refreshGoodsGrid(true)
end

function StrengthenLayer:runReadyAnimtion(isDragOut, gridId)
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

function StrengthenLayer:runCancelReadyAnimtion(gridId)
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

function StrengthenLayer:runPutAnimtion(gridId, dragFromGridNode)
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

function StrengthenLayer:runSuccessAnimtion()
    self.runSuccess = true
    self.fireAnimation:setAnimation("trigger", false)
    self.fireAnimation2:setAnimation("trigger2", false)
    self.strengthenSpine:setAnimation("trigger", false)
    self.strengthenMaterialSpine:setAnimation("ready3", false)
    self.strengAnimation:setAnimation("success", false);
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110843))
end

function StrengthenLayer:runFailedAnimtion()
    self.runSuccess = false
    self.fireAnimation:setAnimation("trigger", false)
    self.fireAnimation2:setAnimation("trigger2", false)
    self.strengthenSpine:setAnimation("ready3", false)
    self.strengthenMaterialSpine:setAnimation("ready3", false)
    self.strengAnimation:setAnimation("fail", false);
    UI.ScrollBar:createByText(UI.TEXT_1212029)
end

function StrengthenLayer:FireAnimationCallback(event, obj)
    if event.animation == "trigger" then
        self.mCanStrengthen = true
        self._bagGridList:updateCanDrag(true)
        self:refreshGoodsGrid()
    end
end

function StrengthenLayer:bagDragBeganCallback(grid, touchPosition)
    if (grid) then
        grid:hideSelect()
    end

    self:runReadyAnimtion(false)

    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
end

function StrengthenLayer:bagDragMovedCallback(grid, touchPosition)
    -- print("StrengthenLayer:bagDragMovedCallback",touchPosition.x,touchPosition.y)
end

function StrengthenLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    print("StrengthenLayer:bagDragEndedCallback")
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))

    if not isInBag then
        local t = self.mGoodsGrid:convertToWorldSpace(cc.p(0, 0))
        local _rect = cc.rect(t.x, t.y, self.mGoodsGrid:getContentSize().width, self.mGoodsGrid:getContentSize().height)
        local goodsData = grid:getData()
        if cc.rectContainsPoint(_rect, touchPosition) then
            if self:isTargetMaxLevel(goodsData) then
                return;
            end

            if self.mGoodsData ~= nil then
                self.mGoodsData._changeNum = 0
            end
            goodsData._changeNum = -1
            self.mGoodsData = goodsData
            self._bagGridList:refreshView()
            self:refreshGoodsGrid()

            if self.mMaterialGoodsData == nil then
                GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110427))
            else
                GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110428))
            end
            self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT)
            self:runPutAnimtion(gridType.goods)
        else
            local t = self.mMaterialGoodsGrid:convertToWorldSpace(cc.p(0, 0))
            local _rect =
                cc.rect(
                t.x,
                t.y,
                self.mMaterialGoodsGrid:getContentSize().width,
                self.mMaterialGoodsGrid:getContentSize().height
            )

            if cc.rectContainsPoint(_rect, touchPosition) then
                if self:isTargetMaxLevel() then
                    return;
                end
                if goodsData:getIsLock() then
                    UI.ScrollBar:createByText(UI.TEXT_110030)
                    return
                end

                if goodsData:haveGemStone() then
                    local showStr = UI.TEXT_1212875
                    UI.ScrollBar:createByText(showStr)
                    return
                end

                if goodsData:haveGlyph() then
                    local showStr = UI.TEXT_227016 
                    UI.ScrollBar:createByText(showStr)
                    return
                end

                local oldMaterialGoodsData = self.mMaterialGoodsData

                if self.mMaterialGoodsData ~= nil then
                    self.mMaterialGoodsData._changeNum = 0
                end
                goodsData._changeNum = -1
                self.mMaterialGoodsData = goodsData
                self._bagGridList:refreshView()
                self:refreshMaterialGoodsGrid()

                if (oldMaterialGoodsData == nil) then
                    if (self.mGoodsData == nil) then
                        GameManager:showNPCInfomation(
                            self.spriteID,
                            LanguageManager:getInstance():getLocalString(1110426)
                        )
                    else
                        GameManager:showNPCInfomation(
                            self.spriteID,
                            LanguageManager:getInstance():getLocalString(1110428)
                        )
                    end
                end
                self:runPutAnimtion(gridType.material)
            else
                if self.mGoodsData == nil then
                    if self:isTargetMaxLevel(goodsData) then
                        return;
                    end

                    if self.mGoodsData ~= nil then
                        self.mGoodsData._changeNum = 0
                    end
                    goodsData._changeNum = -1
                    self.mGoodsData = goodsData
                    self._bagGridList:refreshView()
                    self:refreshGoodsGrid()
                    self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT)
                    if self.mMaterialGoodsData == nil then
                        GameManager:showNPCInfomation(
                            self.spriteID,
                            LanguageManager:getInstance():getLocalString(1110427)
                        )
                    else
                        GameManager:showNPCInfomation(
                            self.spriteID,
                            LanguageManager:getInstance():getLocalString(1110428)
                        )
                    end
                    self:runPutAnimtion(gridType.goods)
                else
                    if self:isTargetMaxLevel() then
                        return;
                    end
                    if goodsData:getIsLock() then
                        UI.ScrollBar:createByText(UI.TEXT_110030)
                        return
                    end
                    if goodsData:haveGemStone() then
                        local showStr = UI.TEXT_1212875 
                        UI.ScrollBar:createByText(showStr)
                        return
                    end

                    if goodsData:haveGlyph() then
                        UI.ScrollBar:createByText(UI.TEXT_227016)
                        return
                    end
                    
                    local oldMaterialGoodsData = self.mMaterialGoodsData

                    if self.mMaterialGoodsData ~= nil then
                        self.mMaterialGoodsData._changeNum = 0
                    end
                    goodsData._changeNum = -1
                    self.mMaterialGoodsData = goodsData
                    self._bagGridList:refreshView()
                    self:refreshMaterialGoodsGrid()

                    if (oldMaterialGoodsData == nil) then
                        GameManager:showNPCInfomation(
                            self.spriteID,
                            LanguageManager:getInstance():getLocalString(1110428)
                        )
                    end
                    self:runPutAnimtion(gridType.material)
                end
            end
        end
    else
        self:runCancelReadyAnimtion();
    end
end

function StrengthenLayer:isTargetMaxLevel(goodsData)
    local max = false
    local target = goodsData or self.mGoodsData
    if target ~= nil and target.strengthenLevel >= target.equipStrengthenMaxLv then
        max = true
    end
    if max then
        self:runCancelReadyAnimtion()
        UI.ScrollBar:createByText(UI.TEXT_110209)
    end
    return max
end

-- 模版函数：更新组建的视图(必备)
function StrengthenLayer:onUpdateView()
    local saveData = MasterDataManager:getRepeatHandleData(RepeatHandleType.STRENGTHEN)
    dump(saveData, "----StrengthenLayer----saveData")
    if saveData then
        self:reductionInfo(saveData)
    end
end

--获取强化成功率
function StrengthenLayer:getRate()
    local calculateLV = (self.mGoodsData.createLevel and self.mGoodsData.createLevel > 0 ) and self.mGoodsData.createLevel - self.mGoodsData.qualityGrade or self.mGoodsData.equipLV
    local materialClculateLV = (self.mMaterialGoodsData.createLevel and self.mMaterialGoodsData.createLevel > 0 ) and self.mMaterialGoodsData.createLevel - self.mMaterialGoodsData.qualityGrade or self.mMaterialGoodsData.equipLV
    local calculateRare = (self.mGoodsData.createLevel and self.mGoodsData.createLevel > 0 ) and self.mGoodsData.randomGoodsRare or self.mGoodsData.goodsRare
    local materialClculateRare = (self.mMaterialGoodsData.createLevel and self.mMaterialGoodsData.createLevel > 0 ) and self.mMaterialGoodsData.randomGoodsRare or self.mMaterialGoodsData.goodsRare

    local rate =
        100 - self.mGoodsData.strengthenLevel * 5 - (calculateLV - materialClculateLV) * 5 -
        (calculateRare - materialClculateRare) * 5
    local addRate = false

    if rate <= 0 then
        rate = 1
    elseif rate > 100 then
        rate = 100
    end

    -- 添加公会增加的概率
    local masterData = GameDataManager:getInstance():getMaster()
    if (masterData) then
        local extraRate = masterData:getStrengthenExtraRate()
        if (extraRate > 0) then
            addRate = true
            rate = rate + math.floor(extraRate / 100)
        end
    end

    if rate > 100 then
        rate = 100
    end

    return rate, addRate
end

--刷新强化装备
function StrengthenLayer:refreshGoodsGrid()
    if self.mGoodsGrid then
        if self.mGoodsData then
            self.equipNameLabel:setText(UI.TEXT_1212027)
            self.mGoodsGrid:setData(self.mGoodsData)

            self.mGoodsGrid:setVisible(true)
            self.mGoodsGrid:center(gridXOffset, gridYOffset)

            self.mGoodsGrid:hideCountLabel()
            self.mGoodsGrid:hideNewIcon()
            self.mGoodsGrid:hideBG()
            self.mGoodsGrid:updateView()

            local index = 1
            local _baseArr = self.mGoodsData._baseArr
            local _randomArr = self.mGoodsData._randomArr
            local basicAttribute = self.mGoodsData.basicAttribute
            local basicAttributeStrengthenValue = self.mGoodsData.basicAttributeStrengthenValue
            local randAttributeStrengthenLV = self.mGoodsData.randAttributeStrengthenLV
            --刷新属性
            for i = 1, #_baseArr do
                local item =  self.mPropertyList[index]
                if item then
                    item.model.attDownIcon:setVisible(false)
                    local picStrengthenMark = item.model.attUpIcon
                    local txtAddProperty = item.model.attChangeNumber

                    item:setVisible(true)
                    local _DetailDescription = _baseArr[i]:getDetailDescription()
                    item.model.attNameLabel:setText(_DetailDescription[1])
                    item.model.attNumberLabel:setText(_DetailDescription[2]);
                    item.model.attNumberLabel:leftBottom(item.model.attNameLabel._width + 8, 0)

                    local basicAttributeStrengthenValueByIndex = basicAttributeStrengthenValue[i]

                    if self.mGoodsData.strengthenLevel >= self.mGoodsData.equipStrengthenMaxLv then
                        picStrengthenMark:setVisible(false)
                        txtAddProperty:setText(UI.TEXT_110208)
                    else
                        picStrengthenMark:setVisible(true)
                        --修改主属性
                        if self.mGoodsData.createLevel and self.mGoodsData.createLevel > 0 then
                            local attrType = _baseArr[i]:getAttrType()
                            local strengthenConfig = ConfigManager:getBasicAttributeStrengthenByID(attrType)

                            local createLevel = clone(self.mGoodsData.createLevel)
                            local levelLimiteList = string.split(self.mGoodsData.equipRequireLvIntervals, ";")
                            local baseLevelLimite = string.split(levelLimiteList[1], ",")
                            local strengthenLevelLimite = string.split(levelLimiteList[2], ",")
                            local lowerLimite = tonumber(baseLevelLimite[1])
                            local upperLimite = tonumber(baseLevelLimite[2])

                            local strengthenLowerLimite = tonumber(strengthenLevelLimite[1])
                            local strengthenUpperLimite = tonumber(strengthenLevelLimite[2])
                
                            createLevel = math.max(createLevel, lowerLimite + self.mGoodsData.qualityGrade)
                            createLevel = math.min(createLevel, upperLimite + self.mGoodsData.qualityGrade)
                            
                            
                            local strengthenLevel = clone(self.mGoodsData.createLevel)
                            strengthenLevel = math.max(strengthenLevel, strengthenLowerLimite + self.mGoodsData.qualityGrade)
                            strengthenLevel = math.min(strengthenLevel, strengthenUpperLimite + self.mGoodsData.qualityGrade)

                            if self.mGoodsData.occupDiffer == 0 then
                                basicAttributeStrengthenValueByIndex = strengthenConfig.CommonAttributeLv[strengthenLevel]
                            elseif self.mGoodsData.occupDiffer == PublicDefine.WEAPON_TYPE.SWORD_SHIELD then
                                basicAttributeStrengthenValueByIndex = strengthenConfig.ShieldAttributeLv[strengthenLevel]
                            elseif self.mGoodsData.occupDiffer == PublicDefine.WEAPON_TYPE.GREAT_SWORD then
                                basicAttributeStrengthenValueByIndex = strengthenConfig.SwordAttributeLv[strengthenLevel]
                            elseif self.mGoodsData.occupDiffer == PublicDefine.WEAPON_TYPE.MAGIC_STAFF then
                                basicAttributeStrengthenValueByIndex = strengthenConfig.MasterAttributeLv[strengthenLevel]
                            end

                            local str = "+" .. (basicAttributeStrengthenValueByIndex or "0")
                            txtAddProperty:setText(str)
                        else
                            for j = 1, #basicAttribute do
                                if basicAttribute[j] == _baseArr[i]:getAttrType() then
                                    local str = "+" .. basicAttributeStrengthenValue[j]
                                    txtAddProperty:setText(str)
                                end
                            end
                        end
                        
                    end
                    index = index + 1
                end
            end

            for i = 1, #_randomArr do
                local item = self.mPropertyList[index]
                if item then
                    item:setVisible(true)
                    item.model.attDownIcon:setVisible(false)
                    local picStrengthenMark = item.model.attUpIcon
                    local txtAddProperty = item.model.attChangeNumber

                    local _DetailDescription = _randomArr[i]:getDetailDescription()
                    item.model.attNameLabel:setText(_DetailDescription[1])
                    item.model.attNumberLabel:setText(_DetailDescription[2])
                    item.model.attNumberLabel:leftBottom(item.model.attNameLabel._width + 8, 0)

                    item:setVisible(true)

                    if self.mGoodsData.strengthenLevel >= self.mGoodsData.equipStrengthenMaxLv then
                        picStrengthenMark:setVisible(false)
                        txtAddProperty:setText(UI.TEXT_110208)
                    else
                        picStrengthenMark:setVisible(true)
                        --修改随机属性
                        if self.mGoodsData.createLevel and self.mGoodsData.createLevel > 0 then
                            local levelLimiteList = string.split(self.mGoodsData.equipRequireLvIntervals, ";")
                            local strengthenLevelLimite = string.split(levelLimiteList[2], ",")
                
                            local strengthenLowerLimite = tonumber(strengthenLevelLimite[1])
                            local strengthenUpperLimite = tonumber(strengthenLevelLimite[2])
                
                            local strengthenLevel = clone(self.mGoodsData.createLevel)
                            strengthenLevel = math.max(strengthenLevel, strengthenLowerLimite + self.mGoodsData.qualityGrade)
                            strengthenLevel = math.min(strengthenLevel, strengthenUpperLimite + self.mGoodsData.qualityGrade)

                            randAttributeStrengthenLV = strengthenLevel
                        end
                        txtAddProperty:setText(
                            "+" .. tostring(
                                ConfigManager:getEquipmentRandAttrStrengthen(_randomArr[i]:getAttrType()).strengthenValuesByLV[
                                    randAttributeStrengthenLV
                                ]
                            )
                        )
                    end
                    index = index + 1
                end
            end

            for i = index, #self.mPropertyList do
                self.mPropertyList[i]:setVisible(false)
            end
        else
            for i = 1, #self.mPropertyList do
                self.mPropertyList[i]:setVisible(false)
            end
            self.mGoodsGrid:setVisible(false)
        end
        self:updateBtnState()

        self:refreshRate()
    end
end

--刷新强化装备材料
function StrengthenLayer:refreshMaterialGoodsGrid()
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

        self:refreshRate()
    end
end

-- 刷新成功概率
function StrengthenLayer:refreshRate()
    if self.mGoodsData ~= nil and self.mMaterialGoodsData ~= nil then
        local rate, addRate = self:getRate()
        self.mTxtRate:setText(string.format("%d%%", rate))
        AvalonUtil.updateIconStringLayout(self.mRateLayer)
        self.mRateLayer:setVisible(true)
    else
        self.mRateLayer:setVisible(false)
    end
end

--刷新强化消耗
function StrengthenLayer:updateNeed()
    local needNum = 0
    local rs = false
    if self.mGoodsData and not self:isTargetMaxLevel() then
        local costs = Config.EquipStrengthenConfig:getEquipStrengthenCost(self.mGoodsData.equipLV)
        local nextLevel = self.mGoodsData.strengthenLevel + 1
        -- 判断当前等级可否选择钻石强化
        local cost = costs.diamondCost or {}
        needNum = checkint(cost[nextLevel])
        -- 说明当前无法使用钻石
        if needNum <= 0 then
            self.costType = GOODS_COST_TYPE.GOLD
            self.functionTabList:setVisible(false)
            self.functionTabList:activeTab(self.costType)
        else
            self.functionTabList:setVisible(true)
        end
        if self.costType == GOODS_COST_TYPE.GOLD then
            local cost = costs.coinCost or {}
            -- add by zp 把这里的计算方法给抽成了函数处理
            needNum = ToolsUtil:calcalationStrengthCoin(cost, nextLevel, self.mGoodsData.goodsRare)
            -- needNum = checkint(cost[nextLevel]) * self.mGoodsData.goodsRare
            self.mNeedIcon:setSpriteName("symbol_gaming_money.png")
            rs = (GameDataManager:getInstance():getCurCoin() >= needNum)
        elseif self.costType == GOODS_COST_TYPE.GEM then
            local cost = costs.diamondCost or {}
            needNum = checkint(cost[nextLevel]) 
            self.mNeedIcon:setSpriteName("symbol_gaming_diamond.png")
            rs = Avalon.MathUtil:checkDiamonEnough(needNum, GameDataManager:getInstance():getDiamond())
            
            
        end
        self.mTxtNeedNum:setText(needNum)
    end
    if rs then
        self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_220_182_80)
    else
        self.mTxtNeedNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    end

    AvalonUtil.updateIconStringLayout(self.makeEquipModel.priceLayer);

    self.makeEquipModel.priceLayer:setVisible(needNum ~= 0)
    if needNum == 0 then
        self.makeEquipModel.executeButtonLabel:show()
        self.equipNameLabel:setText(UI.TEXT_1300000)
    else
        self.makeEquipModel.executeButtonLabel:hide()
        self.makeEquipModel.executeButtonLabel:center(self.mTxtStrengthenXPos)
    end
    return rs
end

--[[锁住左边格子， isDelay 仅表示延时刷新变灰状态（展示效果）]]
function StrengthenLayer:updateGridState(isCanUse, isDelay)
    print("-----------updateCanUseState")
    if not isDelay then
        self.mGoodsGrid:updateCanUseState(isCanUse)
        self.mMaterialGoodsGrid:updateCanUseState(isCanUse)
    else
        self.mGoodsGrid:updateCanUseStateAndDelayRefresh(isCanUse, 0.3)
        self.mMaterialGoodsGrid:updateCanUseStateAndDelayRefresh(isCanUse, 0.3)
    end
end

--刷新改造按钮
function StrengthenLayer:updateBtnState()
    local saveData = MasterDataManager:getRepeatHandleData(RepeatHandleType.STRENGTHEN)
    if saveData then
        self.mBtnStrengthen:disable()
        return
    end
    if not self.mCanStrengthen or self.mGoodsData == nil or self.mMaterialGoodsData == nil then
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

function StrengthenLayer:onTouchBeganByGoodsGrid(grid, touchPosition)
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

function StrengthenLayer:onTouchEndedByGoodsGrid(grid, inSide)
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

        if grid.state == gridType.goods then
            self.mGoodsData = nil
            self:refreshGoodsGrid()
            self.strengthenSpine:setAnimation("idle1_2", false)

            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110426))
        elseif grid.state == gridType.material then
            self.mMaterialGoodsData = nil
            self:refreshMaterialGoodsGrid()
            self.strengthenMaterialSpine:setAnimation("idle1_1", false)

            if (self.mGoodsData) then
                GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110427))
            end
        end

        self._bagGridList:refreshView()
        self:runCancelReadyAnimtion(grid.state)
    end
end

--强化
function StrengthenLayer:onStrengthen()
    if self.mCanStrengthen == false or self.mGoodsData == nil or self.mMaterialGoodsData == nil then
        return
    end
    -- 判断是否还可以强化
    if self.mGoodsData.strengthenLevel >= self.mGoodsData.equipStrengthenMaxLv then
        UI.ScrollBar:createByText(UI.TEXT_110209)
        return
    end
    local costs = Config.EquipStrengthenConfig:getEquipStrengthenCost(self.mGoodsData.equipLV)
    local nextLevel = self.mGoodsData.strengthenLevel + 1
    -- 判断当前等级可否选择钻石强化
    local cost = costs.diamondCost or {}
    if self.costType == GOODS_COST_TYPE.GOLD then
        local cost = costs.coinCost or {}
        local needNum = checkint(cost[nextLevel]) * self.mGoodsData.goodsRare
        if GameDataManager:getInstance():getCurCoin() < needNum then
            UI.ScrollBar:createByText(UI.TEXT_110210)
            return
        end
    elseif self.costType == GOODS_COST_TYPE.GEM then
        local cost = costs.diamondCost or {}
        local needNum = checkint(cost[nextLevel])
        if not Avalon.MathUtil:checkDiamonEnough(needNum, GameDataManager:getInstance():getDiamond()) then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
        
    end

    local function doRealStrengthen()
        UI.TipsLayer:createDestoryGemStoneTips(
            {self.mMaterialGoodsData},
            function()
                --检查角色  行为是否合法
                if RoleBehaviorManager:equipTownNpcCheck() then
                    printWarn(" been blocked when using equipment npc strengthen function !")
                    return
                end
                --强化
                Net.NetNPCSystem:sendStrengthen(self.mGoodsData, self.mMaterialGoodsData,self.costType,self.spriteID)
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

                self._bagGridList:updateCanDrag(false)
                self.mCanStrengthen = false
                self:updateBtnState()
                --

                --防止重复发送
                local saveData = {}
                local simpleGoodsdata = {}
                simpleGoodsdata.goodsId = self.mGoodsData:getId()
                simpleGoodsdata.isGold = self.mGoodsData:getIsGolden()
                if (self.mGoodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
                    simpleGoodsdata.entityId = self.mGoodsData:getEntityID()
                end

                local simpleMaterialdata = {}
                simpleMaterialdata.goodsId = self.mMaterialGoodsData:getId()
                simpleMaterialdata.isGold = self.mMaterialGoodsData:getIsGolden()
                if (self.mMaterialGoodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
                    simpleMaterialdata.entityId = self.mMaterialGoodsData:getEntityID()
                end

                saveData.equipmentGoods = simpleGoodsdata
                saveData.materialGoods = simpleMaterialdata
                MasterDataManager:setRepeatHandleData(RepeatHandleType.STRENGTHEN, saveData)
                self:updateGridState(false, true)
            end
        )
    end

    -- 暗金以上品质的装备作为材料时进行二次确认
    if self.mMaterialGoodsData.goodsRare >= PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4 then
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212233, doRealStrengthen);
    else
        doRealStrengthen();
    end
end

--强化特效事件
function StrengthenLayer:spineRemouldCallback(event, obj)
    print("StrengthenLayer:spineRemouldCallback event.animation", event.animation)
    if event.animation == "success" or event.animation == "fail" then

        self.mCanStrengthen = true
        self._bagGridList:updateCanDrag(true)
        self:refreshGoodsGrid()
    elseif event.animation == "star" then
        self:refreshGoodsGrid()
    end
end

--强化网络回调
function StrengthenLayer:remouldCallBack(data)
    self:updateGridState(true, false)
    UI.WaitingLayer:hideWaiting()
    if data.flag == "StrengthenResultType_Succeed" then
        self.strengthenSpine:setAnimation("star", false)
        self.strengthenSpine:addAnimation("success", false)
        self.strengthenMaterialSpine:setAnimation("idle1_1", false)
        self.mMaterialGoodsData = nil
        self:refreshMaterialGoodsGrid()
        self:runSuccessAnimtion();
    elseif data.flag == "StrengthenResultType_Failed" then
        self.strengthenSpine:setAnimation("star", false)
        self.strengthenSpine:addAnimation("fail", false)
        self.strengthenMaterialSpine:setAnimation("idle1_1", false)

        self.mMaterialGoodsData = nil
        self:refreshMaterialGoodsGrid()
        self:runFailedAnimtion()
    else
        GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.StrengthenResultType", data.flag))
        self.mCanStrengthen = true
        self._bagGridList:updateCanDrag(true)
    end
end

-- 监听钻石变化
function StrengthenLayer:onCurrencyChangeHandler()
    if self.mCanStrengthen then --在动画过程中 不能刷新
        self:updateBtnState()
    end
end
-- 注册监听事件(可选)
function StrengthenLayer:registerListener()
    --改造结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_STRENGTHEN, self, self.remouldCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

-- 注销监听事件(可选)
function StrengthenLayer:unRegisterListener()
    --改造结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_STRENGTHEN, self, self.remouldCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

function StrengthenLayer:reductionInfo(saveData)
    --todo
    local equipmentGoods = saveData.equipmentGoods
    local materialGoods = saveData.materialGoods
    self.mGoodsData =
        self._bagGridList:getGoodsDataArr(equipmentGoods.goodsId, equipmentGoods.isGold, equipmentGoods.entityId)[1] or
        {}
    self.mMaterialGoodsData =
        self._bagGridList:getGoodsDataArr(materialGoods.goodsId, materialGoods.isGold, materialGoods.entityId)[1] or {}
    self._bagGridList:updateCanDrag(false)
    self.mCanStrengthen = false
    self:refreshMaterialGoodsGrid()
    self:refreshGoodsGrid()
    self:updateGridState(false, false)

    self.mMaterialGoodsData._changeNum = -1

    self.mGoodsData._changeNum = -1
    self._bagGridList:refreshView()
    --self.mMaterialGoodsData._changeNum = 0
end

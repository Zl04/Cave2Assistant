-- EnchantmentLayer.lua
-- Author:ODEI
-- 2017年5月23日
-- Using:附魔 

require "app.ui.shoplayer.BagGoodsPanel"
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")

local EnchantmentLayerUtil = require("app.ui.enchantmentLayer.EnchantmentLayerUtil")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local EnchantmentLayer = class("EnchantmentLayer", UI.DoorWin)
UI.EnchantmentLayer = EnchantmentLayer

local model = require("app.uiExport.Enchant")

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local leftWidth = 417

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_gaming_enchanting.plist",
}

local GRID_TYPE = {
    middle = 0,
    left = 1,
    right = 2,
    top = 3,
    all = 4,
    material = 5
}

--构造函数(必备)
function EnchantmentLayer:ctor(spriteID)
	--窗口大小
    EnchantmentLayer.super.ctor(
    self,UIType.ENCHANTMENT_LAYER,
    COM_RES_LIST,
    leftWidth,	
    winSize.height
    )

    self.showColor = {
        cc.c4b(159, 121, 95,  255),
        cc.c4b(129, 142, 69,  255),
        cc.c4b(86,  146, 152, 255),
        cc.c4b(211, 172, 54,  255),
        cc.c4b(196, 116, 68,  255),
        cc.c4b(199, 84,  77,  255),
    }

    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.mBannerList = {}
    self.mMaxHeight = 180
    self.mEquipGoodsGrid = nil;     --装备框
    self.mMaterialGoodsGrid = {};   --附魔材料框
    self.mCanEnchantment = true;    --是否能附魔
    self.txtProbabilityList = {}

    self.putMaterialLeft = false
    self.putMaterialRight = false
    self.putMaterialTop = false


    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function EnchantmentLayer:dtor()
    EnchantmentLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function EnchantmentLayer:init()
    EnchantmentLayerUtil:getInstance():init()
    EnchantmentLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function EnchantmentLayer:onInitView()
    -- self:addColorBG()		--灰色遮罩层

	--root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width, winSize.height))
    self.rootLayer:setPosition(cc.p(0,0))
    self:addChild(self.rootLayer)

    self.enchantModel = model.create()
    self.leftLayer = self.enchantModel.root

    local leftNode = UI.Component:create()
    leftNode:init()

    local scale = 1
    if winSize.height < self.leftLayer._height then
        scale = (winSize.height - 10) / self.leftLayer._height
        self.leftLayer:setScale(scale)
        local offset = self.leftLayer._width * (1 - scale) / 2
        self.leftLayer:centerLeft(-offset)
    end

    leftNode:setSize(self.leftLayer._width * scale, self.leftLayer._height * scale)
    leftNode:addChild(self.leftLayer, 100)
    self.leftNode = leftNode

    self.rootLayer:addChild(leftNode, 100)

    self:createSpineNode();

    --附魔btn
    self.mBtnEnchantment = self.enchantModel.executeButton
    self.mBtnEnchantment:addEventListener(UIEvent.BUTTON_CLICK,self,self.onEnchantment)
    AvalonUtil.addBracketsAnimationToButton(self.mBtnEnchantment)
    self.mBtnEnchantment:disable()

    self.isInTown = SceneManager:getInstance():isInTownOrInHome()
    if self.isInTown then
        self.enchantModel.executeButtonIcon:setSpriteName("symbol_gaming_money.png")
    end

    -- 附魔文字
    self.mTxtEnchantment = self.enchantModel.executeButtonLabel
    self.enchantBtnStartXPos = self.mTxtEnchantment._posX

    self.mTxtEnchantmentNeedNum = self.enchantModel.executeButtonPrice
    self.mTxtEnchantmentNeedNum:setText("0")

    self.mEquipGoodsGrid = UI.GoodsGrid:create()
    self.mEquipGoodsGrid:init()
    self.mEquipGoodsGrid:hide()
    self.mEquipGoodsGrid:hideNewIcon()
    self.enchantModel.middleGrid:addChild(self.mEquipGoodsGrid, 101)
    self.mEquipGoodsGrid:setTouchEnable(true)
    self.mEquipGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mEquipGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByEquipGoodsGrid))
    self.mEquipGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByEquipGoodsGrid))

    self.mEquipGoodsGrid:showInfoArea();
    self:resetGridPos(self.mEquipGoodsGrid, GRID_TYPE.middle)

    --材料格子
    for i = 1, 3 do
        local _materialGoodsGrid = UI.GoodsGrid:create()
        _materialGoodsGrid:init()
        _materialGoodsGrid.index = i
        _materialGoodsGrid:center(1, 1)
        _materialGoodsGrid:hide()
        self:resetGridPos(_materialGoodsGrid, GRID_TYPE.material);
        _materialGoodsGrid:hideCountLabel()
        _materialGoodsGrid:hideNewIcon()
        _materialGoodsGrid:showInfoArea();

        local node = self.enchantModel.leftGrid
        if i == 2 then
            node = self.enchantModel.rightGrid
        elseif i == 3 then
            node = self.enchantModel.topGrid
        end

        node:addChild(_materialGoodsGrid, 101)
        node.materialGoodsGrid = _materialGoodsGrid

        local lightEffect = UI.Animation:create()
        lightEffect:init("effect_ui_gaming_enchanting_kuang_xiao.json", "effect_ui_gaming_enchanting_kuang_xiao.atlas", 1);
        node:addChild(lightEffect, 102)
        node.lightEffect = lightEffect

        _materialGoodsGrid:setTouchEnable(true)
        _materialGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
        _materialGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByMaterialGoodsGrid))
        _materialGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByMaterialGoodsGrid))

        table.insert(self.mMaterialGoodsGrid,_materialGoodsGrid)
    end

    local clipperPic = cc.Sprite:createWithSpriteFrameName("ui_enchanting_banner_testtube.png")
    self.mMaxHeight = clipperPic:getContentSize().height
    clipperPic:setAnchorPoint(0, 0)
    clipperPic:getTexture():setAliasTexParameters();
    self.clipper = cc.ClippingNode:create(clipperPic)
    self.clipper:setPosition(55, 124)
    self.clipper:setAlphaThreshold(0.05)
    self.leftLayer:addChild(self.clipper)

    self.clipperChildNode = cc.Node:create()
    self.clipper:addChild(self.clipperChildNode)

    --各种buff标签
    for i = 1, 6 do
        local name = "attImage" .. i
        local picBanner = self.enchantModel[name]
        if picBanner then
        else
            printError("picBanner not found : ", name)
        end

        picBanner:setVisible(false)

        local txtBanner = model.create("attLabel").root;
        txtBanner:center()
        txtBanner:setName("txt")
        picBanner:addChild(txtBanner, 2)

        table.insert(self.mBannerList,picBanner)
    end

    self.enchantmentSpineLabel = self.enchantModel.resultLabel
    self.enchantmentSpineLabel:setText("")

    self.enchantModel.triangleBg:addEventListener(UIEvent.ANIMATION_END, self, self.spineEnchantCallback)

    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    local _usedType2 = {}
    _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    _usedType2.type = PublicDefine.MATERIAL_TYPE.MaterialEnchanting
    table.insert(usedTypeList,_usedType2)

    -- 右边背包数据
    local bagList = UI.BagGoodsPanel:create(usedTypeList, true, false)
    bagList:setHideBagType(
        {
            UI.BagGoodsPanel.BAG_TYPE.ALL,
            UI.BagGoodsPanel.BAG_TYPE.ITEM,
            UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
            UI.BagGoodsPanel.BAG_TYPE.RELIC,
        }
    )
    if  SceneManager:getInstance():isInTownOrInHome() then
        bagList:setShowBagTagExt(
            {
                UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
            }
        )
    end
    bagList:init(nil, nil, 3)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

    self._bagGridList = bagList
    self.rootLayer:addChild(bagList,2)
    -- self._bagGridList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT)
    self._bagGridList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP)

    self.succeeded = false
    self.enchantModel.triangleBg:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "audio_action" then
                if self.succeeded then
                    Avalon.AudioManager:playSound("1517")
                else
                    Avalon.AudioManager:playSound("1518")
                end
            elseif event.eventData.name == "audio_prepare" then
                Avalon.AudioManager:playSound("1516")
            elseif event.eventData.name == "event_fuwen" then
                if self.succeeded then
                    self.enchantModel.fuWenBottom:setAnimation("success_xia", false)
                    self.enchantModel.fuWenRight:setAnimation("success_you", false)
                    self.enchantModel.fuWenLeft:setAnimation("success_zuo", false)
                else
                    self.enchantModel.fuWenBottom:setAnimation("fail_xia", false)
                    self.enchantModel.fuWenRight:setAnimation("fail_you", false)
                    self.enchantModel.fuWenLeft:setAnimation("fail_zuo", false)
                end
            elseif event.eventData.name == "event_kuang" then
                if self.succeeded then
                    self.enchantModel.middleGrid:setAnimation("success", false)
                    self.enchantModel.leftGrid:setAnimation("success_zuo", false)
                    self.enchantModel.rightGrid:setAnimation("success_you", false)
                    self.enchantModel.topGrid:setAnimation("success_shang", false)
                    self.enchantModel.middleGrid.lightEffect:setAnimation("success", false)
                    self.enchantModel.leftGrid.lightEffect:setAnimation("success_zuo", false)
                    self.enchantModel.rightGrid.lightEffect:setAnimation("success_you", false)
                    self.enchantModel.topGrid.lightEffect:setAnimation("success_shang", false)
                else
                    self.enchantModel.middleGrid:setAnimation("fail", false)
                    self.enchantModel.leftGrid:setAnimation("fail", false)
                    self.enchantModel.rightGrid:setAnimation("fail", false)
                    self.enchantModel.topGrid:setAnimation("fail", false)
                    self.enchantModel.middleGrid.lightEffect:setAnimation("fail", false)
                    self.enchantModel.leftGrid.lightEffect:setAnimation("fail", false)
                    self.enchantModel.rightGrid.lightEffect:setAnimation("fail", false)
                    self.enchantModel.topGrid.lightEffect:setAnimation("fail", false)
                end
            end
        end
    end)

    self:setDoorNode(self.leftNode, self._bagGridList)

    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110423))
    self:refreshEnchantBtnStatus()
    
    self:resetSpineAnimation();
end

function EnchantmentLayer:createSpineNode()
    self.enchantModel.fuWenBottom = UI.Animation:create()
    self.enchantModel.fuWenBottom:init("effect_ui_gaming_enchanting_fuwen.json", "effect_ui_gaming_enchanting_fuwen.atlas", 1);
    self.enchantModel.triangleBg:addComponent("fuwen_xia", self.enchantModel.fuWenBottom);

    self.enchantModel.fuWenRight = UI.Animation:create()
    self.enchantModel.fuWenRight:init("effect_ui_gaming_enchanting_fuwen.json", "effect_ui_gaming_enchanting_fuwen.atlas", 1);
    self.enchantModel.triangleBg:addComponent("fuwen_you", self.enchantModel.fuWenRight);

    self.enchantModel.fuWenLeft = UI.Animation:create()
    self.enchantModel.fuWenLeft:init("effect_ui_gaming_enchanting_fuwen.json", "effect_ui_gaming_enchanting_fuwen.atlas", 1);
    self.enchantModel.triangleBg:addComponent("fuwen_zuo", self.enchantModel.fuWenLeft);

    self.enchantModel.leftGrid = UI.Animation:create()
    self.enchantModel.leftGrid:init("effect_ui_gaming_enchanting_kuang_xiao_kuang.json", "effect_ui_gaming_enchanting_kuang_xiao.atlas", 1);
    self.enchantModel.triangleBg:addComponent("kuang_xiao_zuo", self.enchantModel.leftGrid);

    self.enchantModel.rightGrid = UI.Animation:create()
    self.enchantModel.rightGrid:init("effect_ui_gaming_enchanting_kuang_xiao_kuang.json", "effect_ui_gaming_enchanting_kuang_xiao.atlas", 1);
    self.enchantModel.triangleBg:addComponent("kuang_xiao_you", self.enchantModel.rightGrid);

    self.enchantModel.topGrid = UI.Animation:create()
    self.enchantModel.topGrid:init("effect_ui_gaming_enchanting_kuang_xiao_kuang.json", "effect_ui_gaming_enchanting_kuang_xiao.atlas", 1);
    self.enchantModel.topGrid:center(0, -2)
    self.enchantModel.triangleBg:addComponent("kuang_xiao_shang", self.enchantModel.topGrid);

    self.enchantModel.middleGrid = UI.Animation:create()
    self.enchantModel.middleGrid:init("effect_ui_gaming_enchanting_kuang_da_kuang.json", "effect_ui_gaming_enchanting_kuang_da.atlas", 1);
    self.enchantModel.middleGrid:center(-4, -2)
    self.enchantModel.triangleBg:addComponent("dakuang", self.enchantModel.middleGrid);

    local lightEffect = UI.Animation:create()
    lightEffect:init("effect_ui_gaming_enchanting_kuang_da.json", "effect_ui_gaming_enchanting_kuang_da.atlas", 1);
    lightEffect:center(2)
    self.enchantModel.middleGrid:addChild(lightEffect, 200);
    self.enchantModel.middleGrid.lightEffect = lightEffect

end

function EnchantmentLayer:resetGridPos(grid, type)
    if type == GRID_TYPE.middle then
        grid:center(3, 1.5)
    else
        grid:center(1, 1.5)
    end
end

function EnchantmentLayer:resetSpineAnimation()
    self.enchantModel.fuWenBottom:setAnimation("begin_xia", false)
    self.enchantModel.fuWenRight:setAnimation("begin_you", false)
    self.enchantModel.fuWenLeft:setAnimation("begin_zuo", false)
    self.enchantModel.triangleBg:setAnimation("begin", false)
    self.enchantModel.middleGrid:setAnimation("begin", false)
    self.enchantModel.leftGrid:setAnimation("begin", false)
    self.enchantModel.rightGrid:setAnimation("begin", false)
    self.enchantModel.topGrid:setAnimation("begin", false)
    self:refreshEnchantBtnStatus()
end

function EnchantmentLayer:runReadyAnimtion(type, dragDownIndex)
    if type == GRID_TYPE.middle then
        self.enchantModel.middleGrid.lightEffect:setAnimation("hint_begin", false)
        self.mEquipGoodsGrid:setLocalZOrder(300)
    elseif type == GRID_TYPE.material then
        if not self.putMaterialLeft then
            self.enchantModel.fuWenBottom:setAnimation("hint_begin_xia", false)
            self.enchantModel.leftGrid.lightEffect:setAnimation("hint_begin", false)
            self.enchantModel.leftGrid.materialGoodsGrid:setLocalZOrder(300)
        else
            if dragDownIndex and dragDownIndex == GRID_TYPE.left then
                self.enchantModel.fuWenBottom:setAnimation("takedown_xia01", false)
                self.enchantModel.leftGrid.lightEffect:setAnimation("hint_begin", false)
                self.enchantModel.leftGrid.materialGoodsGrid:setLocalZOrder(300)
            end
        end
        if not self.putMaterialRight then
            self.enchantModel.rightGrid.lightEffect:setAnimation("hint_begin", false)
            self.enchantModel.fuWenRight:setAnimation("hint_begin_you", false)
            self.enchantModel.rightGrid.materialGoodsGrid:setLocalZOrder(300)
        else
            if dragDownIndex and dragDownIndex == GRID_TYPE.right then
                self.enchantModel.fuWenRight:setAnimation("takedown_you01", false)
                self.enchantModel.rightGrid.lightEffect:setAnimation("hint_begin", false)
                self.enchantModel.rightGrid.materialGoodsGrid:setLocalZOrder(300)
            end
        end
        if not self.putMaterialTop then
            self.enchantModel.fuWenLeft:setAnimation("hint_begin_zuo", false)
            self.enchantModel.topGrid.lightEffect:setAnimation("hint_begin", false)
            self.enchantModel.topGrid.materialGoodsGrid:setLocalZOrder(300)
        else
            if dragDownIndex and dragDownIndex == GRID_TYPE.top then
                self.enchantModel.fuWenLeft:setAnimation("takedown_zuo01", false)
                self.enchantModel.topGrid.lightEffect:setAnimation("hint_begin", false)
                self.enchantModel.topGrid.materialGoodsGrid:setLocalZOrder(300)
            end
        end
        self:setMaterialPutStatus(dragDownIndex, false)
    end 
end


function EnchantmentLayer:setMaterialPutStatus(gridType, status)
    if gridType == GRID_TYPE.left then
        self.putMaterialLeft = status
    elseif gridType == GRID_TYPE.right then
        self.putMaterialRight = status
    elseif gridType == GRID_TYPE.top then
        self.putMaterialTop = status
    end
end

function EnchantmentLayer:runCancelReadyAnimtion(type)
    if type == GRID_TYPE.middle then
        self.enchantModel.middleGrid.lightEffect:setAnimation("hint_end", false)
    elseif type == GRID_TYPE.material then
        if not self.putMaterialLeft then
            self.enchantModel.fuWenBottom:setAnimation("hint_end_xia", false)
            self.enchantModel.leftGrid.lightEffect:setAnimation("hint_end", false)
        end
        if not self.putMaterialRight then
            self.enchantModel.rightGrid.lightEffect:setAnimation("hint_end", false)
            self.enchantModel.fuWenRight:setAnimation("hint_end_you", false)
        end
        if not self.putMaterialTop then
            self.enchantModel.fuWenLeft:setAnimation("hint_end_zuo", false)
            self.enchantModel.topGrid.lightEffect:setAnimation("hint_end", false)
        end
    end 
end

function EnchantmentLayer:runPutAnimtion(gridType)
    if gridType == GRID_TYPE.middle then
        self.enchantModel.middleGrid.lightEffect:setAnimation("enchase", false)
        self.mEquipGoodsGrid:setLocalZOrder(0)
    elseif gridType == GRID_TYPE.left then
        self.enchantModel.fuWenBottom:setAnimation("enchase_xia", false)
        self.enchantModel.leftGrid.lightEffect:setAnimation("enchase", false)
        self.enchantModel.leftGrid.materialGoodsGrid:setLocalZOrder(0)
    elseif gridType == GRID_TYPE.right then
        self.enchantModel.fuWenRight:setAnimation("enchase_you", false)
        self.enchantModel.rightGrid.lightEffect:setAnimation("enchase", false)
        self.enchantModel.rightGrid.materialGoodsGrid:setLocalZOrder(0)
    elseif gridType == GRID_TYPE.top then
        self.enchantModel.fuWenLeft:setAnimation("enchase_zuo", false)
        self.enchantModel.topGrid.lightEffect:setAnimation("enchase", false)
        self.enchantModel.topGrid.materialGoodsGrid:setLocalZOrder(0)
    end
    self:setMaterialPutStatus(gridType, true);
    if gridType ~= GRID_TYPE.middle then
        self:runCancelReadyAnimtion(GRID_TYPE.material)
    end
end

function EnchantmentLayer:runSuccessAnimtion()
    self.enchantModel.triangleBg:setAnimation("success", false)    
end

function EnchantmentLayer:runFailedAnimtion()
    self.enchantModel.triangleBg:setAnimation("fail", false)
end

function EnchantmentLayer:spineEnchantCallback(event,obj)
    if event.animation == "success" or event.animation == "fail" then
        if event.animation == "success" then
            UI.ScrollBar:createByTextID(1110844)
        else
            UI.ScrollBar:createByText(UI.TEXT_1212016)
        end
        self:setMaterialPutStatus(GRID_TYPE.left, false)
        self:setMaterialPutStatus(GRID_TYPE.right, false)
        self:setMaterialPutStatus(GRID_TYPE.top, false)

        self:spineRemouldCallback()
        EnchantmentLayerUtil:getInstance().mMaterialDatas = {}
        for i = 1, 3 do
            self:refreshMaterial(i)
        end
        self._bagGridList:refreshView()
        self.mCanEnchantment = true
        self._bagGridList:updateCanDrag(true)
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110424))
        local delayCallbackfunc = cc.CallFunc:create(function()
            self:resetSpineAnimation()
        end)
        local delayAction = cc.DelayTime:create(0.01)
        self:runAction(cc.Sequence:create(delayAction, delayCallbackfunc))
    end
end

function EnchantmentLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    local goodsData = grid:getData()
    if goodsData and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        self:runReadyAnimtion(GRID_TYPE.middle)
    elseif goodsData and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
        self:runReadyAnimtion(GRID_TYPE.material)
    end

    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true) 
    end
end

function EnchantmentLayer:bagDragMovedCallback(grid, touchPosition)
    -- print("EnchantmentLayer:bagDragMovedCallback",touchPosition.x,touchPosition.y)
end

function EnchantmentLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    local pos = self.leftLayer:convertToWorldSpace(cc.p(0,0))

    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false) 
    end
    local goodsData = grid:getData()
    if not isInBag then
        local materialDatas = EnchantmentLayerUtil:getInstance().mMaterialDatas
        if goodsData then
            if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                if EnchantmentLayerUtil:getInstance().mEquipData ~= nil then
                    EnchantmentLayerUtil:getInstance().mEquipData._changeNum = 0
                end
                EnchantmentLayerUtil:getInstance().mEquipData = goodsData;
                goodsData._changeNum = -1

                self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.MATERIAL)
                self._bagGridList:refreshView()
                self:refreshEquiop()

                if table.nums(materialDatas) <= 0 then
                    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110424))
                else
                    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110425))
                end
                self.enchantmentSpineLabel:setText("")
                self:runPutAnimtion(GRID_TYPE.middle)
            elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
                
                if goodsData:getIsLock() then
                    UI.ScrollBar:createByText(UI.TEXT_110030)
                    return
                end
                self.enchantmentSpineLabel:setText("")

                for i = 1 ,#self.mMaterialGoodsGrid do
                    local t = self.mMaterialGoodsGrid[i]:convertToWorldSpace(cc.p(0,0))
                    local _rect = cc.rect(t.x,t.y,
                        self.mMaterialGoodsGrid[i]:getContentSize().width,self.mMaterialGoodsGrid[i]:getContentSize().height)

                    if cc.rectContainsPoint(_rect, touchPosition) then
                        if materialDatas[i] ~= nil then
                            materialDatas[i]._changeNum = materialDatas[i]._changeNum + 1
                        end

                        materialDatas[i] = self._bagGridList:getGoodsDataLoseGoldenByData(goodsData)
                        if(materialDatas[i]) then
                            materialDatas[i]._changeNum = materialDatas[i]._changeNum - 1
                        end
                        self:refreshMaterial(i)
                        self._bagGridList:refreshView()

                        self:runPutAnimtion(i)

                        if(EnchantmentLayerUtil:getInstance().mEquipData == nil) then
                            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110423))
                        else
                            if table.nums(materialDatas) == 1 then
                                GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110425))
                            end
                        end
                        return
                    end
                end
                
                for i = 1,3 do
                    if materialDatas[i] == nil then
                        materialDatas[i] = self._bagGridList:getGoodsDataLoseGoldenByData(goodsData)
                        if(materialDatas[i]) then
                            materialDatas[i]._changeNum = materialDatas[i]._changeNum - 1
                        end
                        self:refreshMaterial(i)
                        self._bagGridList:refreshView()

                        if(EnchantmentLayerUtil:getInstance().mEquipData == nil) then
                            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110423))
                        else
                            if table.nums(materialDatas) == 1 then
                                GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110425))
                            end
                        end
                        self:runPutAnimtion(i)
                        return
                    end
                end
            end
        end
    else
        if goodsData and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
            self:runCancelReadyAnimtion(GRID_TYPE.middle)
        elseif goodsData and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
            self:runCancelReadyAnimtion(GRID_TYPE.material)
        end
    end
end 


-- 模版函数：更新组建的视图(必备)
function EnchantmentLayer:onUpdateView()

end


--刷新附魔材料
function EnchantmentLayer:refreshEnchantmentProbability()
    -- self.leftLayer:removeChildByName("CupProbabilityTxt")
    for k, v in pairs(self.txtProbabilityList) do
        v:removeFromParent(true)
    end
    self.txtProbabilityList = {}
    --魔法消耗量
    local attributeDatas,tMPCost = EnchantmentLayerUtil:getInstance():getEnchantmentProbability()
    self.mTxtEnchantmentNeedNum:setText(tostring(tMPCost))
    AvalonUtil.updateIconStringLayout(self.enchantModel.priceLayout)

    for i = 1,#self.mBannerList do
        if attributeDatas[i] ~= nil then
            self.mBannerList[i]:setVisible(true)
            local txtBanner = self.mBannerList[i]:getChildByName("txt")
            txtBanner:setText(attributeDatas[i].name..attributeDatas[i].min.."-"..attributeDatas[i].max)
        else
            self.mBannerList[i]:setVisible(false)
        end
    end

    self.clipperChildNode:removeAllChildren();

    local probability = -10
    local proWidth = 53;
    for i = 1,#attributeDatas do
        -- local picProbability = cc.Sprite:createWithSpriteFrameName("ui_enchanting_progressbar_"..i..".png")
        local picProbability  = cc.LayerColor:create(self.showColor[i])
        picProbability:setPosition(0, probability)
        if i == 1 then
            picProbability:setContentSize(proWidth, 20 + self.mMaxHeight / 100 * attributeDatas[i].probability)
        else
            picProbability:setContentSize(proWidth, self.mMaxHeight / 100 * attributeDatas[i].probability)
        end
        self.clipperChildNode:addChild(picProbability)
        picProbability:setAnchorPoint(0,0)
        
        local txtProbability = UI.Text:create()
        txtProbability:init(attributeDatas[i].probability.."%", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_248_242_204)
        txtProbability:useDefaultShadowOnlyStype();
        txtProbability:center()
        -- txtProbability:setName("CupProbabilityTxt")
        picProbability:addChild(txtProbability)
        table.insert(self.txtProbabilityList, txtProbability)
        probability = probability + picProbability:getContentSize().height
    end
end

--刷新装备
function EnchantmentLayer:refreshEquiop()
    if self.mEquipGoodsGrid then
        if EnchantmentLayerUtil:getInstance().mEquipData then
            self.mEquipGoodsGrid:setData(EnchantmentLayerUtil:getInstance().mEquipData)
            self.mEquipGoodsGrid:updateView()
            self.mEquipGoodsGrid:show()
            self:resetGridPos(self.mEquipGoodsGrid, GRID_TYPE.middle)
            self.mEquipGoodsGrid:hideNewIcon()
            self.mEquipGoodsGrid:hideBG()
        else
            self.mEquipGoodsGrid:hide()
        end
        self:updateEnchantment()
    end
end

--刷新材料
function EnchantmentLayer:refreshMaterial(index)
    if self.mMaterialGoodsGrid[index] then
        if EnchantmentLayerUtil:getInstance().mMaterialDatas[index] then
            self.mMaterialGoodsGrid[index]:setData(EnchantmentLayerUtil:getInstance().mMaterialDatas[index])
            self.mMaterialGoodsGrid[index]:updateView()
            self.mMaterialGoodsGrid[index]:show()
            self:resetGridPos(self.mMaterialGoodsGrid[index], GRID_TYPE.material)
            self.mMaterialGoodsGrid[index]:hideCountLabel()
            self.mMaterialGoodsGrid[index]:hideNewIcon()
            self.mMaterialGoodsGrid[index]:hideBG()
        else
            self.mMaterialGoodsGrid[index]:hide()
            self:resetGridPos(self.mMaterialGoodsGrid[index], GRID_TYPE.material)
        end

        self:refreshEnchantmentProbability()
        self:updateEnchantment()
    end
end

function EnchantmentLayer:onTouchBeganByEquipGoodsGrid(grid,touchPosition)
    if self.mCanEnchantment == false then
        return false
    end

    self:runReadyAnimtion(GRID_TYPE.middle);
    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true) 
    end
    return true
end

function EnchantmentLayer:onTouchEndedByEquipGoodsGrid(grid, inSide)
    if self.mCanEnchantment == false then
        return
    end

    if inSide then
        self:runPutAnimtion(GRID_TYPE.middle)
    else
        local goodsData = grid:getData()
        EnchantmentLayerUtil:getInstance().mEquipData._changeNum = 0
        
        EnchantmentLayerUtil:getInstance().mEquipData = nil
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110423))

        self:refreshEquiop()
        self._bagGridList:refreshView()
        self:runCancelReadyAnimtion(GRID_TYPE.middle)

        -- self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.ALL)
        self._bagGridList:refreshView()

    end

    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false) 
    end

    self.enchantmentSpineLabel:setText("")

end


function EnchantmentLayer:onTouchBeganByMaterialGoodsGrid(grid,touchPosition)
    if self.mCanEnchantment == false then
        return false
    end

    self:runReadyAnimtion(GRID_TYPE.material, grid.index)

    if(self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true) 
    end
    return true
end

function EnchantmentLayer:onTouchEndedByMaterialGoodsGrid(grid,inSide)
    if self.mCanEnchantment == false then
        return
    end
    
    if inSide then
        self:runPutAnimtion(grid.index)
    else
        local goodsData = grid:getData()

        EnchantmentLayerUtil:getInstance().mMaterialDatas[grid.index]._changeNum = EnchantmentLayerUtil:getInstance().mMaterialDatas[grid.index]._changeNum + 1
        EnchantmentLayerUtil:getInstance().mMaterialDatas[grid.index] = nil
        
        if(table.nums(EnchantmentLayerUtil:getInstance().mMaterialDatas)==0) then
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110424))
        end

        self:refreshMaterial(grid.index)
        self._bagGridList:refreshView()
        self:runCancelReadyAnimtion(GRID_TYPE.material)
    end

    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false) 
    end

    self.enchantmentSpineLabel:setText("")

end

function EnchantmentLayer:refreshEnchantBtnStatus()
    local canEnchant = true;
    if EnchantmentLayerUtil:getInstance().mEquipData == nil then
        canEnchant = false
    end

    local mark = false
    for k,v in pairs(EnchantmentLayerUtil:getInstance().mMaterialDatas) do
        mark = true
        break
    end

    if mark == false then
        canEnchant = false
    end

    if MasterDataManager:getRepeatHandleData(RepeatHandleType.NPC_ENCHANT) then
        canEnchant = false
    end
    if(not canEnchant) then
        self.mBtnEnchantment:disable()
        self.mTxtEnchantment:setFontColor(UI.FONT_COLOR_182_201_201)
        self.mTxtEnchantmentNeedNum:setFontColor(UI.FONT_COLOR_182_201_201)
        self.mTxtEnchantmentNeedNum:setVisible(false)
        self.enchantModel.executeButtonIcon:setVisible(false)
        self.mTxtEnchantment:show()
    else 
        self.mTxtEnchantment:setFontColor(UI.FONT_COLOR_220_182_80)
        self.mTxtEnchantmentNeedNum:setFontColor(UI.FONT_COLOR_220_182_80)
        self.mTxtEnchantmentNeedNum:setVisible(true)
        self.enchantModel.executeButtonIcon:setVisible(true)
        self.mBtnEnchantment:enable()
        self.mTxtEnchantment:hide()
    end
    return canEnchant
end

--附魔
function EnchantmentLayer:onEnchantment()
    if self.mCanEnchantment == false then
        return
    end

    if not self:isEnoughPrice(true) then
        return
    end

    self.enchantmentSpineLabel:setText("")


    if RoleBehaviorManager:enchantmentNpcCheck() then
        printWarn("been blocked when using enchantment npc function!")
        return
    end

    --装备不用检查
    -- local goodsData = EnchantmentLayerUtil:getInstance().mEquipData
    -- local isExist = GameDataManager:getInstance():isGoodsExisit(goodsData:getBagType(), 
    -- {goodsData:getGoodsID()}, PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
    -- if not isExist then
    --     UI.ScrollBar:createByText(UI.TEXT_1213453)
    --     return
    -- end

    local materialGoodsData = EnchantmentLayerUtil:getInstance().mMaterialDatas
    for k,v in pairs(materialGoodsData) do
        local isExist = GameDataManager:getInstance():isGoodsExisit(v:getBagType(), 
            {v:getGoodsID()}, PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
        if not isExist then
            UI.ScrollBar:createByText(UI.TEXT_1213453)
            return
        end
    end

    Net.NetNPCSystem:sendEnchantment(EnchantmentLayerUtil:getInstance().mEquipData,EnchantmentLayerUtil:getInstance().mMaterialDatas,self.spriteID)
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    MasterDataManager:setRepeatHandleData(RepeatHandleType.NPC_ENCHANT, true)
    self:refreshEnchantBtnStatus()

    self.mCanEnchantment = false
    self._bagGridList:updateCanDrag(false)

    for k,v in pairs(EnchantmentLayerUtil:getInstance().mMaterialDatas) do
        v._changeNum = v._changeNum + 1
    end
end


--刷新附魔信息
function EnchantmentLayer:updateEnchantment()
    local canEnchant = self:refreshEnchantBtnStatus()
   
    if not self:isEnoughPrice() and canEnchant then
        self.mTxtEnchantment:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        self.mTxtEnchantmentNeedNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    end

end

function EnchantmentLayer:isEnoughPrice(needNotice)
    local holdNumber = RoleDataManager:getMaster():getCurMp()
    local noticeStr = UI.TEXT_1150021
    if self.isInTown then
        holdNumber = GameDataManager:getInstance():getCurCoin()
        noticeStr = UI.TEXT_110210
    end
    local enough = tonumber(self.mTxtEnchantmentNeedNum:getText()) <= holdNumber
    if needNotice and not enough then
         UI.ScrollBar:createByText(noticeStr)
    end
    return enough
end

--附魔网络回调
function EnchantmentLayer:enchantmentCallBack(data)
    UI.WaitingLayer:hideWaiting()
    if data.result == "EnchantResultType_Succeed" then
        self.succeeded = true
        self:runSuccessAnimtion()
        self.resultData = data
    elseif data.result == "EnchantResultType_Failed" then
        self.succeeded = false
        self.enchantmentSpineLabel:setText("")
        self:runFailedAnimtion();
    else
        local ProtobufUtil = require "utils.ProtobufUtil"
        GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.EnchantResultType",data.result))
        self.mCanEnchantment = true
        self._bagGridList:updateCanDrag(true)
        for k,v in pairs(EnchantmentLayerUtil:getInstance().mMaterialDatas) do
            v._changeNum = v._changeNum - 1
        end
    end
end

function EnchantmentLayer:spineRemouldCallback(event,obj)
    if self.resultData == nil then
        return
    end
    local data = self.resultData
    local txt = ToolsUtil:getNameByAttrType(data.attr.attrType)..data.attr.attrBaseValue
    self.enchantmentSpineLabel:setText(txt)
    -- local attributeDatas,tMPCost = EnchantmentLayerUtil:getInstance():getEnchantmentProbability()
    -- for k, v in pairs(attributeDatas) do
    --     if v.id == data.attr.attrType then
    --         -- TODO set bg image
    --         break
    --     end
    -- end
    self.enchantModel.numberEffect:setAnimation("success", false);
    self.resultData = nil
end

-- 点击外部区域的处理器(关闭)(可选)
function EnchantmentLayer:onBattlePositionSync()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER,function()
        if (not tolua.isnull(self)) and self.close ~= nil then
            self:close()
        end
    end)
end

-- 注册监听事件(可选)
function EnchantmentLayer:registerListener()
    --监听窗口外关闭事件
    --self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_ENCHANTMENT, self, self.enchantmentCallBack)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_POSITION_SYNC, self, self.onBattlePositionSync)
end

-- 注销监听事件(可选)
function EnchantmentLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_ENCHANTMENT, self, self.enchantmentCallBack)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_POSITION_SYNC, self, self.onBattlePositionSync)
end



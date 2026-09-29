------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2023/02/23
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
require "app.ui.shoplayer.BagGoodsPanel"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
local IdentifyTreasureItemView = class("IdentifyTreasureItemView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_gem.plist",
    "ui_package_pets.plist",
    "ui_town_home.plist"
}

local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(341, 632)

local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height


function IdentifyTreasureItemView:ctor()
    IdentifyTreasureItemView.super.ctor(
    	self,
    	UI.Type.PET_IDENTIFY_TREASURE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.closeIndex = 0
    self._pageTable = {}

    self.mGoodsData = nil;          --鉴定道具
    self.mGoodsGrid = nil;          --装备框

    self._defaultBagIndex = UI.BagGoodsPanel.BAG_TYPE.ALL

    -- 宝物鉴定完毕服务器消息返回鉴定结果
    self.mNowIdentifySuccess = false
end

function IdentifyTreasureItemView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.identifytreasureitem", "IdentifyTreasureItem", false)
    IdentifyTreasureItemView.super.init(self, ... )
end

function IdentifyTreasureItemView:dtor()
    IdentifyTreasureItemView.super.dtor(self)
    self:unbindModel()

    if self.mGoodsData and self.mGoodsData._changeNum < 0 then
        self.mGoodsData._changeNum = 0
    end

    reload_script_file_mvc("app.modules.identifytreasureitem.IdentifyTreasureItemView")
end

-- 模版函数：更新组建的视图(必备)
function IdentifyTreasureItemView:onUpdateView()
    mvc.identifyTreasureItemPanel.ui:setDoorNode(self.leftLayer, self.rightLayer)-- self._bagGridList)
    -- self.ui:setDoorNode(self.leftLayer, self._bagGridList)
    -- GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111281)) 
end


function IdentifyTreasureItemView:onInitView()

    self.leftLayer = UI.Layout:create();
    self.leftLayer:init()
    self.leftLayer:setSize(leftSize.width, leftSize.height)
    self.leftLayer:leftBottom(-winSize.width, (winSize.height - leftSize.height) / 2)
    self:addChild(self.leftLayer,2)

    self.leftLayer:setTouchEnable(true)
    self.leftLayer:setInterceptTouches(false)
    self.leftLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self.closeIndex = 1
    end)

    self.rightLayer = UI.Layout:create();
    self.rightLayer:init()
    self.rightLayer:setSize(450, COM_HEIGHT)
    --self.rightLayer:leftBottom(COM_WIDTH)
    self:addChild(self.rightLayer)


    --背景
    local picBg = UI.Image:create()
    picBg:init("ui_gem_bg.png")
    picBg:centerBottom(0)
    self.leftLayer:addChild(picBg)
    self.picBg = picBg

    self:createLeftView()
    self:createRightView()

end

function IdentifyTreasureItemView:updateGoodsData(equipmentData)
    self.mGoodsData = equipmentData
    if self.mGoodsGrid then
        self.mGoodsGrid:setData(self.mGoodsData)
    end
end

function IdentifyTreasureItemView:nowTimeIdentifyResult(isIdentifySuccess)
    -- 当前本次鉴定结果
    self.mNowIdentifySuccess = isIdentifySuccess
    if not self.mNowIdentifySuccess then
        self.mGoodsData = nil
    end
end

function IdentifyTreasureItemView:createLeftView()

    if self.mGoodsData then
        self.mGoodsData._changeNum = 0
    end

    self.mGoodsData = nil
    self.holeArr = {}
    if self.leftNode then
        self.leftNode:removeFromParent()
        self.leftNode = nil
    end
    self.leftNode = UI.Layout:create();
    self.leftNode:init()
    self.leftNode:setSize(leftSize.width, leftSize.height)
    self.leftNode:leftBottom(0,0)
    self.picBg:addChild(self.leftNode)

    -- 鉴定模块
    self:refreshIdentifyModule()
    
end

function IdentifyTreasureItemView:onTouchBeganByGoodsGrid(grid,touchPosition)
    self:runReadyAnimtion()
    return true
end

function IdentifyTreasureItemView:onTouchEndedByGoodsGrid(grid, inSide)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    local goodsData = grid:getData()
    if not inSide then
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        -- 拖出去了
        self.mGoodsData._changeNum = 0
        self._bagGridList:setUsedType(self:getInitUseType())
        self._bagGridList:refreshView()
        self.mGoodsData = nil
        self.mGoodsGrid:center()
        self.mGoodsGrid:setVisible(false)
        self:runCancelReadyAnimtion();

        self:refreshIdentifyModule()

        -- GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111281))
        
        self._bagGridList:refreshView()
    else
        self:runPutAnimtion()
    end
end

-- 取消准备放入动画
function IdentifyTreasureItemView:runCancelReadyAnimtion()
    self._kuangAnimation:setAnimation("hint_end_yellow", false)
    self._kuangAnimation:setTimeScale(1)
end

-- 准备放入动画
function IdentifyTreasureItemView:runReadyAnimtion()
    self._kuangAnimation:setAnimation("hint_begin_yellow", false)
    self._kuangAnimation:addAnimation("hint_idle_yellow", true)
    self._kuangAnimation:setTimeScale(1)
end

-- 放入动画
function IdentifyTreasureItemView:runPutAnimtion()
    self._kuangAnimation:setAnimation("enchase_yellow", false)
    self._kuangAnimation:setTimeScale(1)
end

function IdentifyTreasureItemView:refreshIdentifyModule(showAnimation)
    if self.leftNode then
        self.leftNode:removeAllChildren()
    end

    local bg = UI.Image:create()
    bg:init("ui_gem_paper.png")
    bg:centerUp(183)
    self.leftNode:addChild(bg)


    local upOffsetY = 155
    
    -- 处理背景用于放大缩小
    local shadown = UI.Image:create()
    shadown:init("ui_gem_shadow.png")
    shadown:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2 - 4, 4 + upOffsetY - shadown:getContentSize().width / 2)
    self.leftNode:addChild(shadown)

    local round = UI.Image:create()
    round:init("ui_gem_round.png")
    round:leftUp(self.leftNode:getContentSize().width/2 - shadown:getContentSize().width / 2, upOffsetY - round:getContentSize().width / 2)
    self.leftNode:addChild(round)
    local inlayAnimation = UI.Animation:create()
    inlayAnimation:init("effect_ui_town_pet_equipment.json", "effect_ui_town_pet_equipment.atlas")
    inlayAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(inlayAnimation, 9)
    self._inlayAnimation = inlayAnimation
    inlayAnimation:setAnimation("jianding_idle_normal", false, 0)
    inlayAnimation:updateTime(0)
    inlayAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "jianding_trigger") then
        end
    end)
    
    -- 装备框
    local kuangAnimation = UI.Animation:create()
    kuangAnimation:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas")
    kuangAnimation:center()
    self._kuangAnimation = kuangAnimation
    kuangAnimation:setAnimation("hint_begin_blue", false)
    kuangAnimation:updateTime(0)
    -- kuangAnimation:setTimeScale(0)
    kuangAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(kuangAnimation, 9)

    local successAnimation = UI.Animation:create()
    successAnimation:init("effect_ui_town_gem_kuang_da_success_yellow.json", "effect_ui_town_gem_kuang_da.atlas")
    successAnimation:center()
    kuangAnimation.successAnimation = successAnimation
    kuangAnimation:addChild(successAnimation, 10)
    
    -- 添加宝石镶嵌框
    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:center()
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setTouchEnable(true)
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mGoodsGrid:showInfoArea();
    self.mGoodsGrid.state = 1
    self._kuangAnimation:addComponent("gem_kuang_da", self.mGoodsGrid, true)

    if self.mGoodsData then

        print("self.mGoodsData num === ", self.mGoodsData:getNum())
        self.mGoodsGrid:setData(self.mGoodsData)
        self.mGoodsGrid:setVisible(true)
        self.mGoodsGrid:show()
        self.mGoodsGrid:hideCountLabel()
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideBG()
        self.mGoodsGrid:updateView()
        self:runReadyAnimtion()
    end

    --鉴定
    local btnHeavyDevour = UI.Button:create()
    btnHeavyDevour:init("ui_pets_equipment_btn2.png", "ui_pets_equipment_btn2.png", "ui_pets_equipment_btn2.png")
    btnHeavyDevour:setText(UI.TEXT_1213952)
    btnHeavyDevour:setTextFont(UI.FONT_BOLD,18,{r=214,g=174,b=78})
    
    btnHeavyDevour:addEventListener(UIEvent.BUTTON_CLICK, self, function()

        if not self.mGoodsData or (not self.mGoodsData.identificationConsumptionQuantity) then
            UI.ScrollBar:createByText(UI.TEXT_224130)
            return
        end

        local useMoney = self.mGoodsData.identificationConsumptionQuantity
        local curCoin = RoleDataManager:getMaster():getCurCoin()
        if curCoin < useMoney then
            UI.ScrollBar:createByText(UI.TEXT_110210)
            return 
        end

        local freePacketNum = GameDataManager:getInstance():getFreePetGemStoneBoxNum()
        if(freePacketNum <= 0) then
            UI.ScrollBar:createByTextID(1110793)
            return
        end

        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        --发送鉴定消息
        Net.NetGoodsSystem:requesIdentifyTreasureItemMessage(self.mGoodsData:getGoodsID())
    end)
    btnHeavyDevour:centerBottom(30)
    self.btnHeavyDevour = btnHeavyDevour
    self.leftNode:addChild(btnHeavyDevour)

    if self.mGoodsData then
        -- local conf = ConfigManager:getProfileIdentification(self.mGoodsData:getGoodsRare())
        local costMoney = self.mGoodsData.identifyConsumableItems
        local useMoney = self.mGoodsData.identificationConsumptionQuantity
        if (costMoney ~= nil) and (useMoney ~= nil) then
            local tColor = UI.FONT_COLOR_250_211_124
            local curCoin = RoleDataManager:getMaster():getCurCoin()
            if curCoin < useMoney then
                tColor = UI.FONT_COLOR_NOT_ENOUGH
            end

            btnHeavyDevour:setTextFont(UI.FONT_BOLD,18,tColor)

            local bText = AvalonUtil:getSimpleNumber(useMoney, 4)
            btnHeavyDevour:setText(bText)
            btnHeavyDevour:setTextOffset(30,0)

            local costGoodsData = GoodsDataManager:createLocalGoodsData(costMoney)

            if costGoodsData then
                local glodIcon = UI.Image:create()
                glodIcon:init(costGoodsData.miniIcon)
                -- glodIcon:setScale(0.3)
                btnHeavyDevour:addChild(glodIcon,999)
                local textCSize = btnHeavyDevour:getTextContentSize()
                if textCSize then
                    glodIcon:center(-30,0)
                end
            end
        end
    end


    local lineImg = UI.Image:create()
    lineImg:init("ui_pets_equipment_line.png")
    lineImg:centerBottom(200)
    bg:addChild(lineImg)

    local desTxt = UI.Text:create()
    desTxt:init(UI.TEXT_224131, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
    desTxt:centerBottom(215)
    bg:addChild(desTxt, 10)

    local desTxt2 = UI.Text:create()
    desTxt2:init(UI.TEXT_224132, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41,g = 41,b = 45})
    desTxt2:leftUp(25,180)
    desTxt2:setSize(210,150)
    desTxt2:setTextLeftUp()
    bg:addChild(desTxt2, 10)

    if showAnimation then
        self._kuangAnimation:setAnimation("hint_begin_yellow", false)
        self._kuangAnimation:addAnimation("hint_idle_yellow", true)
        self._kuangAnimation:setTimeScale(1)
    end
end

function IdentifyTreasureItemView:refreshAll(showAnimation)
    self:refreshIdentifyModule(showAnimation)
    -- self._bagGridList:resetHandleStatus()
    self:createRightView()
end

function IdentifyTreasureItemView:refreshTriggerAnimation()
    -- body
    local upOffsetY = 155
    local leftEquipmentAnimation = UI.Animation:create()
    leftEquipmentAnimation:init("effect_ui_town_pet_equipment_icon.json", "effect_ui_town_pet_equipment_icon.atlas")
    leftEquipmentAnimation:center()
    self._leftEquipmentAnimation = leftEquipmentAnimation
    leftEquipmentAnimation:setAnimation("jianding_trigger", false)
    leftEquipmentAnimation:setTimeScale(1)
    leftEquipmentAnimation:centerUp(upOffsetY)
    self.leftNode:addChild(leftEquipmentAnimation, 11)
    if self.mNowIdentifySuccess then
        self._leftEquipmentAnimation:addAnimation("jianding_success", false)
    else
        self._leftEquipmentAnimation:addAnimation("jianding_fail", false)
    end

    -- 这里背包先锁住，让他的鉴定动画播放完了后再能进行拖动新的宝物来鉴定
    self._bagGridList:updateCanDrag(false)
    if self.mGoodsGrid then 
        self.mGoodsGrid:setTouchEnable(false)
    end

    self._inlayAnimation:addAnimation("jianding_trigger", false)
    self._inlayAnimation:setTimeScale(1)
    self._inlayAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "jianding_trigger") then
            local slotNode = self._kuangAnimation:getNodeForSlot("gem_kuang_da")
            slotNode:removeAllChildren()

            self.mGoodsGrid = UI.GoodsGrid:create()
            self.mGoodsGrid:init()
            self.mGoodsGrid:center()
            self.mGoodsGrid:hide()
            self.mGoodsGrid:hideCountLabel()
            self.mGoodsGrid:hideNewIcon()
            self.mGoodsGrid:setTouchEnable(true)
            self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
            self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
            self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
            self.mGoodsGrid:showInfoArea();
            self.mGoodsGrid.state = 1
            self._kuangAnimation:addComponent("gem_kuang_da", self.mGoodsGrid, true)

            if self.mGoodsData then
                print("self.mGoodsData num === ", self.mGoodsData:getNum())
                self.mGoodsGrid:setData(self.mGoodsData)
                self.mGoodsGrid:setVisible(true)
                self.mGoodsGrid:show()
                self.mGoodsGrid:hideCountLabel()
                self.mGoodsGrid:hideNewIcon()
                self.mGoodsGrid:hideBG()
                self.mGoodsGrid:updateView()
                self:runReadyAnimtion()
            end

            if not self.mNowIdentifySuccess then
                UI.ScrollBar:createByText(UI.TEXT_224139)
            end

            self._bagGridList:updateCanDrag(true)
            self.mGoodsGrid:setTouchEnable(true)

            local awardsList = {}
            table.insert(awardsList,self.mGoodsData)
            if #awardsList > 0 and self.mNowIdentifySuccess then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_1172004, UI_ZORDER.TOP_ACTIVITY)
            end
        end
    end)
end

function IdentifyTreasureItemView:createRightView()

    self.rightLayer:removeAllChildren()

    local userType = self:getInitUseType()

    -- 右边背包数据
    local bagList = UI.BagGoodsPanel:create(userType, true, false)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)

    self._bagGridList = bagList
    local bagListW, bagListH = bagList:getSize()
    bagList:leftBottom(0 , (winSize.height - bagListH) / 2)

    bagList:setTouchEnable(true)
    bagList:setInterceptTouches(false)
    bagList:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        if self.closeIndex == 1 then
            self.closeIndex = 0
            mvc.identifyTreasureItemPanel.ui:onTouchOutSizeEvent();
        end
    end)

    bagList:setRefreshOutSideLabelViewCallback(function()
        self:updateBagName()
    end)

    local nameBg = UI.Image:create()
    nameBg:init("ui_pets_equipment_namebg.png")
    nameBg:centerRight(220,-260)
    self.rightLayer:addChild(nameBg,999)

    local bagNameTxt = UI.Text:create()
    bagNameTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 202,g = 198,b = 155})
    bagNameTxt:centerLeft(49)
    nameBg:addChild(bagNameTxt, 10)
    self.bagNameTxt = bagNameTxt

    self:refreshBagPage()
end

function IdentifyTreasureItemView:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end

    -- 准备放入动画
    self._kuangAnimation:setAnimation("hint_begin_yellow", false)
    self._kuangAnimation:addAnimation("hint_idle_yellow", true)
    self._kuangAnimation:setTimeScale(1)

    self._inlayAnimation:setAnimation("jianding_begin_normal", false)
    self._inlayAnimation:addAnimation("jianding_idle_normal", false)
    self._inlayAnimation:setTimeScale(1)
end

function IdentifyTreasureItemView:bagDragEndedCallback(grid, touchPosition, isInBag)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end

    if goodsData:getIsLock() then
        UI.ScrollBar:createByText(UI.TEXT_221005) -- TEXT_221005 TEXT_1212362
        self:runCancelReadyAnimtion()
        return
    end

    if not isInBag then
        -- 根据拖动的类型来判断如何处理后续逻辑
        if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE and goodsData:getMaterialType() == PublicDefine.MATERIAL_TYPE.MaterialTreasure) then 
            if self.mGoodsData ~= nil then
                self.mGoodsData._changeNum = 0
            end

            goodsData._changeNum = -1
            self.mGoodsData = goodsData
            self._bagGridList:refreshView()

            self.mGoodsGrid:setData(self.mGoodsData)
            self.mGoodsGrid:setVisible(true)
            self.mGoodsGrid:show()
            self.mGoodsGrid:hideCountLabel()
            self.mGoodsGrid:hideNewIcon()
            self.mGoodsGrid:hideBG()
            self.mGoodsGrid:updateView()

            self:refreshIdentifyModule()
            self._inlayAnimation:addAnimation("jianding_end_normal", false)
            self._inlayAnimation:setTimeScale(1)
            self:runPutAnimtion()
        else
            UI.ScrollBar:createByText(UI.TEXT_224136)
            self:runCancelReadyAnimtion()
        end
    else 
        self:runCancelReadyAnimtion()
    end
end 

function IdentifyTreasureItemView:refreshBagPage()
    if not self._bagGridList then
        return
    end
    
    self._bagGridList:setHideBagType(
        {
            -- UI.BagGoodsPanel.BAG_TYPE.ALL,
            UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
            UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
            UI.BagGoodsPanel.BAG_TYPE.ITEM,
            UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
            UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
            UI.BagGoodsPanel.BAG_TYPE.RELIC,
        }
    )

    self._bagGridList:setShowBagTagExt(
        {
            -- UI.BagGoodsPanel.BAG_TYPE.ALL,
            UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
        }
    )

    self._defaultBagIndex = UI.BagGoodsPanel.BAG_TYPE.ALL


    self._bagGridList:init(nil, GameBagUIType.NORMAL, FLITER_TYPE.EQUIPMENT_ONLY_SHOW_PET)
    self._bagGridList:changeBagDefaultIndex(self._defaultBagIndex)

    self._bagGridList:setUsedType(self:getInitUseType())
    self._bagGridList:refreshView()

    self.rightLayer:addChild(self._bagGridList,2)
    -- self._bagGridList:refreshView()
end

function IdentifyTreasureItemView:updateBagName()
    if self.bagNameTxt and self._bagGridList then

        local bIndex = self._bagGridList:getBagIndex()

        if bIndex == UI.BagGoodsPanel.BAG_TYPE.ALL then
            self.bagNameTxt:setText(UI.TEXT_224133)
        elseif bIndex == UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE then
            self.bagNameTxt:setText(UI.TEXT_224134)
        end
    end
end

function IdentifyTreasureItemView:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_TREASURE
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    return usedTypeList
end


function IdentifyTreasureItemView:bindModel()

end


function IdentifyTreasureItemView:unbindModel()

end





return IdentifyTreasureItemView


























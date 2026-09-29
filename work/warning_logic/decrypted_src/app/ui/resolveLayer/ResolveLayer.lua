-- Author:CHENZIHAN
-- Using:分解UI

require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.resolveLayer.ResolveGrid"
local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.EquipWorkshop")
UI = UI or {}

local ResolveLayer = class("ResolveLayer", UI.DoorWin)
UI.ResolveLayer = ResolveLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local RESOLVE_NUMBER_LIMIT = 20 --可批量分解的数量上限
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_blacksmith.plist"
}


--构造函数(必备)
function ResolveLayer:ctor(spriteID)
    --窗口大小
    ResolveLayer.super.ctor(
    self,UIType.RESOLVE_LAYER,
    COM_RES_LIST,
    318,    
    winSize.height
    )
    self.putCount = 0;          -- 放入的装备数量
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.mGoodsDataList = {};          --装备
    -- self.mGoodsGrid = nil;          --装备框

    self.mSelectArrIndex = 0;            --选中的属性

    self.mPropertyBtnList = {};     --属性列表

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();

    self.mCanRemould = true;       --是否能分解
    self._mTime = 3
    self.mSchedulerID = 0
end

--虚构函数,destroy时调用(必备)
function ResolveLayer:dtor()
    ResolveLayer.super.dtor(self)
    self:unRegisterListener();
    local scheduler = cc.Director:getInstance():getScheduler()
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
end

-- 初始化(必备)
function ResolveLayer:init()
    ResolveLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function ResolveLayer:onInitView()
    -- self:addColorBG()        --灰色遮罩层

    --root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width, winSize.height))
    self.rootLayer:setPosition(cc.p(0,0))
    self:addChild(self.rootLayer)

    self.resolveModel = model.createResolveEquipNode()
    self.leftLayer = self.resolveModel.root
    self.leftLayer:centerLeft(0)
    self.rootLayer:addChild(self.leftLayer)

    self.fireAnimation = self.resolveModel.resolveFireAnimation
    self.fireAnimation:addEventListener(UIEvent.ANIMATION_END, self, self.FireAnimationCallback)

    self.mBtnRemould = self.resolveModel.executeButtonResolve
    self.mBtnRemould:addEventListener(UIEvent.BUTTON_CLICK,self,self.onRemould)
    AvalonUtil.addBracketsAnimationToButton(self.mBtnRemould)
    self.mBtnRemould:disable()

    self.mTxtRemould = self.resolveModel.executeButtonLabelResolve

    local gWidth = 72
    local gHeight = 72
    local hSpace = 10
    local vSpace = 3
    local space = 7
    -- 左边组件
    local gridList = UI.GridList:create()
    gridList:enableCreateBg(true, "ui_blacksmith_box1.png")
    gridList:init(UI.ResolveGrid, 2, 4, gWidth, gHeight, hSpace, vSpace, space)
    gridList:setSize(170 + space, 320)
    gridList:leftUp(78 - space, 120)
    gridList:setBounceEnabled(true)
    --gridList:setDoubleClickAsDragEnd(true)
    gridList:setCallbackForGridDragBegan(self, self.onTouchBeganByGoodsGrid)
    gridList:setCallbackForGridDragMoved(self, self.onTouchMoveByGoodsGrid)
    gridList:setCallbackForGridDragEnded(self, self.onTouchEndedByGoodsGrid)
    gridList:setCallbackForGridClick(self, self.onTouchByGoodsGrid)
    gridList:setScrollBarEnabled(true)
    gridList._scrollView:setCircleVisible(false)
    gridList._scrollView:setScrollBarPositionFromCornerForVertical(cc.p(0, 0))
    gridList._scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    self._resolveGridList = gridList
    self.resolveModel.resolveEquipBg:addChild(gridList,10)


    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)
    self.usedTypeList = usedTypeList
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
    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self.rootLayer:addChild(bagList,5)
    local bagListW,bagListH = bagList:getSize()
    bagList:leftBottom(winSize.width + bagListW,300 - bagListH/2)
    bagList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT)
    bagList:setUseLock(false)

    self:setDoorNode(self.leftLayer, bagList)

    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110434))
    self:updateBtnState();
    self:resetSpineAnimation();
end

function ResolveLayer:resetSpineAnimation()
    self.fireAnimation:setAnimation("begin", false)
    self.putCount = 0
end

function ResolveLayer:runReadyAnimtion(isDragOut)
    if isDragOut ~= nil and isDragOut == true then
        self.putCount = self.putCount - 1
        if self.putCount == 0 then
            self.fireAnimation:setAnimation("putin3", false)
            self.fireAnimation:addAnimation("ready2", true)
        end
    else
        if self.putCount == 0 then
            self.fireAnimation:setAnimation("ready1", false)
            self.fireAnimation:addAnimation("ready2", true)
        end
    end
end

function ResolveLayer:runCancelReadyAnimtion()
    if self.putCount == 0 then
        self.fireAnimation:setAnimation("ready3", false)
    end
end

function ResolveLayer:runPutAnimtion()
    if self.putCount == 0 then
        self.fireAnimation:setAnimation("putin1", false)
        self.fireAnimation:addAnimation("putin2", true)
    end
    self.putCount = self.putCount + 1
end

function ResolveLayer:runSuccessAnimtion()
    self.fireAnimation:setAnimation("trigger", false)
end

function ResolveLayer:FireAnimationCallback(event, obj)
    if event.animation == "trigger" then
        self.putCount = 0
    end
end

-- 背包格子开始拖动
function ResolveLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end
    self._bagGridList:setSpineBgVisible(true) 
    self:runReadyAnimtion()
end

function ResolveLayer:bagDragMovedCallback(grid, touchPosition)
end

function ResolveLayer:bagDragEndedCallback(grid, touchPosition, isInBag)

    self._bagGridList:setSpineBgVisible(false) 
    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))

    if not isInBag then
        local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
        if freePacketNum <= 0 then
            UI.ScrollBar:createByTextID(1110793)
            self:runReadyAnimtion();
            return
        end
        local goodsData = grid:getData()

        local _randomArr = goodsData:getResolveType()

        if #_randomArr == 0 then
            -- 提示这个装备不能被分解
            UI.ScrollBar:createByText(UI.TEXT_1110400)
            self:runCancelReadyAnimtion()
            return
        end

        if self:hasGem(goodsData) then
            UI.ScrollBar:createByText(UI.TEXT_1212033)
            self:runCancelReadyAnimtion()
            return
        end
        if goodsData._changeNum == -1 then
            return
        end

        goodsData._changeNum = -1
        self._bagGridList:refreshView()
        goodsData._changeNum = -1
        table.insert(self.mGoodsDataList, goodsData)

        self:refreshGoodsGrid()

        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110435))
        self:checkUpLimite()
        self:runPutAnimtion()
    else
        self:runCancelReadyAnimtion();
    end

end 

function ResolveLayer:hasGem(goodsData)
    local have = false
    for k, v in pairs(goodsData._holeDataArr) do
        if v.gemStoneID ~= 0 then
            have = true
            break
        end
    end
    return have
end

-- 模版函数：更新组建的视图(必备)
function ResolveLayer:onUpdateView()
    self._resolveGridList:setScrollBarWidth(5)
end

--刷新分解材料
function ResolveLayer:refreshGoodsGrid()
    print("ResolveLayer:refreshGoodsGrid")
    local list = {}
    local index = 0
    for k, v in pairs(self.mGoodsDataList) do
        table.insert( list, v )
        index = index + 1
    end
    for i = index + 1, 8, 1 do
        table.insert(list, "")
        index = i
    end

    if index % 2 ~= 0 then
        table.insert(list, "")
        index = index + 1
    end

    self._resolveGridList:setData(list)
    self._resolveGridList:setScrollBarWidth(5)
    self._resolveGridList:scrollToBottom()
    self:updateBtnState()
end

--刷新改造按钮
function ResolveLayer:updateBtnState()
    if self.mCanRemould == false or #self.mGoodsDataList <= 0 then
        self.mBtnRemould:disable()
        self.mTxtRemould:setFontColor(UI.FONT_COLOR_182_201_201)
    else
        self.mBtnRemould:enable()
        self.mTxtRemould:setFontColor(UI.FONT_COLOR_220_182_80)
    end
end

-- 装备详情的touch事件的处理
function ResolveLayer:onItemInfoAreaTouchHandler(obj,touchPosition)
    if obj:getGoodsGrid() ~= nil then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

     -- 更新装备对比区域数据
    if(self._itemInfoArea) then
        self._itemInfoArea:close()
        self._itemInfoArea = nil
    end
    if(self._leftGrid)then 
        self._leftGrid:hideSelect()
        self._leftGrid = nil 
    end 
end


function ResolveLayer:onTouchByGoodsGrid(grid,touchPosition)
    if(grid) then
        self._leftGrid = grid
        local goodsData = grid:getData()
        if (goodsData) then
            local leftX = 180 +20
            -- 类型
            if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                -- 装备详情
                local equipmentInfoArea = UI.EquipmentInfoArea:create()
                equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE)
                self._itemInfoArea = equipmentInfoArea
                -- 处理试穿对比
                local blackTable = GameDataManager:getInstance():tryEquipment(goodsData)
                self._itemInfoArea:updateInfo(blackTable)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                local equipmentInfoArea = UI.EquipmentPetInfoArea:create()
                equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE)
                self._itemInfoArea = equipmentInfoArea
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
                self._itemInfoArea = propInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
                -- 材料详情界面
                local materialInfo = nil
                if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then
                    materialInfo = UI.PropInfoArea:create(true)
                else 
                    materialInfo = UI.MaterialEquipScrollInfoArea:create()
                end
                materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                self._itemInfoArea = materialInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
                -- 宝藏材料详情界面
                local materialInfo = UI.PropInfoArea:create(true)
                materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                self._itemInfoArea = materialInfo
                
            -- 处理虚拟物品表现
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
                -- 虚拟物品
                if(goodsData:getCanBeView()) then
                    local propInfo = UI.PropInfoArea:create(true)
                    propInfo:init(UI.PROP_MATER.VIRTUALITEM_INFO)
                    self._itemInfoArea = propInfo
                end 
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
                local pInfoArea = UI.GemStoneInfoArea:create()
                pInfoArea:init(goodsData)
                self._itemInfoArea = propInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then
                local pInfoArea = UI.StarPrayInfoArea:create()
                pInfoArea:init(goodsData)
                self._itemInfoArea = propInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then
                local pInfoArea = UI.PetStoneInfoArea:create()
                pInfoArea:init(goodsData)
                self._itemInfoArea = propInfo
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                local pInfoArea = UI.RelicInfoArea:create()
                pInfoArea:init(goodsData)
                self._itemInfoArea = propInfo
            end 
            if self._itemInfoArea then
                self._itemInfoArea:centerLeft(leftX)
                self.rootLayer:addChild(self._itemInfoArea,9999)
                self._itemInfoArea:closeLockFlag()
                self._itemInfoArea:setHideLink(true)
                self._itemInfoArea:setGoodsGrid(grid)
                self._itemInfoArea:updateView(goodsData)
                self._itemInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onItemInfoAreaTouchHandler)
            end

        end
    end
end 

function ResolveLayer:onTouchBeganByGoodsGrid(grid,touchPosition)
    -- print("------ResolveLayer:onTouchBeganByGoodsGrid")
    if self.mCanRemould == false then
        return
    end
    self:runReadyAnimtion(true)
    -- 设置初始坐标
    self._bagGridList:setSpineBgVisible(true) 
end

function ResolveLayer:onTouchMoveByGoodsGrid(grid,touchPosition)
    if self.mCanRemould == false then
        return
    end

    if(self._resolveGridList and self.leftLayer) then 
        local pos = self.leftLayer:convertToNodeSpace(touchPosition)
        local size = self.leftLayer:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local inSide = cc.rectContainsPoint(rect, pos)
        if(self._resolveGridList) then 
            self._resolveGridList:changeInSideStatus(not inSide)
        end
    end
end

function ResolveLayer:onTouchEndedByGoodsGrid(grid,touchPosition)
    if self.mCanRemould == false then
        return
    end
    self._bagGridList:setSpineBgVisible(false) 
    
    -- 设置初始坐标
    local rootLayerLocalPosition = grid:getParent():convertToNodeSpace(touchPosition)

    local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))
    if(self._resolveGridList:checkTouchPosition(touchPosition) == false) then
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()

        local goodsData = grid:getData()
        goodsData._changeNum = 0

        self._bagGridList:changeBagIndex(self._bagGridList:getChangeBagIndexByGoodsData(goodsData))
        for k, v in ipairs(self.mGoodsDataList) do
            if v:getEntityID() == goodsData:getEntityID() then
                table.remove(self.mGoodsDataList, k)
            end
        end

        self._bagGridList:refreshView()
        grid:hide()
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            if self.refreshGoodsGrid then
                grid:show()
                self:refreshGoodsGrid()
            end
        end, 1)
        if #self.mGoodsDataList <= 0 then
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110434))
        end
        self:checkUpLimite()
        self:runCancelReadyAnimtion()
    else
        self:runPutAnimtion()
    end

    Avalon.AudioManager:playSound("1505")
end

-- 分解
function ResolveLayer:onRemould()
    if self.mCanRemould == false or #self.mGoodsDataList <= 0 then
        return
    end

    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if freePacketNum <= 0 then
        UI.ScrollBar:createByTextID(1110793)
        return
    end

    local function doRealResolve()
        UI.TipsLayer:createDestoryGemStoneTips(self.mGoodsDataList, function() 
            --检查角色  行为是否合法
            if RoleBehaviorManager:equipTownNpcCheck() then
                printWarn(" been blocked when using equipment npc resolve function !")
                return
            end
            self._resolveGridList:disableToDragGrid()
            Net.NetNPCSystem:sendResolve(self.mGoodsDataList, self.spriteID)
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)

            self:updateGridState(false, true)

            self._bagGridList:updateCanDrag(false)
            self.mCanRemould = false
            self:updateBtnState()
        end)
    end

    if self:checkHightQuality() then
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212232, doRealResolve);
    else
        doRealResolve();
    end
end

-- 暗金以上品质的装备分解时进行二次确认
function ResolveLayer:checkHightQuality()
    local needConfirm = false;
    for k, v in ipairs(self.mGoodsDataList) do
        local goodRare = v:getGoodsRare();
        if (goodRare >= PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4) then
            needConfirm = true;
            break;
        end
    end
    return needConfirm;
end

-- 分解特效事件
function ResolveLayer:spineRemouldCallback(data)
    self.mGoodsDataList = {}
    if(self._itemInfoArea) then
        self._itemInfoArea:close()
        self._itemInfoArea = nil
    end
    self.mCanRemould = true
    self._bagGridList:updateCanDrag(true)
    self._resolveGridList:enableToDragGrid()
    self:refreshGoodsGrid()
    GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1110434))     
    self:checkUpLimite()    
end

--改造网络回调 
function ResolveLayer:remouldCallBack(data)
    UI.WaitingLayer:hideWaiting()
    self:updateGridState(true, false)
    if data.result == "DecomposeResultType_Succeed" then
        Avalon.AudioManager:playSound("1513")
        if(self.mBtnRemould) then 
            self.mBtnRemould:disable()
        end 
        local resolveList = self._resolveGridList:getGridList() or {}
        local size = #resolveList 
        for i = 1, size do  
            local goodsData = resolveList[i]:getData()
            if goodsData then
                for k, v in ipairs(data.decomposeDatas) do
                    print("equipmentInstanceID  and  goodsData:getEntityID() = ", v.equipmentInstanceID, goodsData:getEntityID())
                    if v.equipmentInstanceID == goodsData:getEntityID() then
                        --分解特效 装备
                        local remouldSpine = UI.Animation:create()
                        remouldSpine:init("effect_ui_town_blacksmith_decompose.json", "effect_ui_town_blacksmith_decompose.atlas", 1)
                        remouldSpine:center()
                        remouldSpine:setAnimation("trigger", false)
                        resolveList[i]:addChild(remouldSpine, 100)
                        if k == #data.decomposeDatas then
                            remouldSpine:addEventListener(
                                UIEvent.ANIMATION_COMPLETE,
                                self,
                                function()
                                    Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(
                                        self,
                                        function()
                                            if self.spineRemouldCallback then
                                                self:spineRemouldCallback(data)
                                            end
                                        end,
                                        1
                                    )
                                end
                            )
                        end
                    end
                end
            end
        end
        self:runSuccessAnimtion()
    else
        self.mCanRemould = true
        self._bagGridList:updateCanDrag(true)
        self:updateBtnState()
        self._resolveGridList:enableToDragGrid()
    end
end

-- 注册监听事件(可选)
function ResolveLayer:registerListener()
    -- 分解结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_RESOLVE, self, self.remouldCallBack)
end


-- 注销监听事件(可选)
function ResolveLayer:unRegisterListener()
    --分解结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_RESOLVE, self, self.remouldCallBack)
end

function ResolveLayer:reductionInfo(saveData)
    local equipmentGoods = saveData.equipmentGoods
    self.mGoodsData = self._bagGridList:getGoodsDataArr(equipmentGoods.goodsId, equipmentGoods.isGold, equipmentGoods.entityId)[1] or {}
    self._bagGridList:updateCanDrag(false)
    self.mCanRemould = false
    self:refreshGoodsGrid()

    self.mGoodsData._changeNum = -1
    self._bagGridList:refreshView()
    self:updateGridState(false, false)
end

--[[锁住左边格子， isDelay 仅表示延时刷新变灰状态（展示效果）]]
function ResolveLayer:updateGridState(isCanUse, isDelay)
    print("-----------updateCanUseState")
    -- if not isDelay then
    --     self.mGoodsGrid:updateCanUseState(isCanUse)
    -- else 
    --     self.mGoodsGrid:updateCanUseStateAndDelayRefresh(isCanUse, 0.3)
    -- end
end

--检查是否超过数量上限
function ResolveLayer:checkUpLimite()
    if #self.mGoodsDataList >= RESOLVE_NUMBER_LIMIT then
        UI.ScrollBar:createByText(UI.TEXT_1170718)
        self._bagGridList:setUsedType({})
    else
       self._bagGridList:setUsedType(self.usedTypeList)
    end
end



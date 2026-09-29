------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/10/20
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GlyphsRefinedView = class("GlyphsRefinedView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.baglayer.InfoArea.GlyphInfoArea"
require "app.modules.glyphs.GlyphRefinedItemView"
local GlyphsPacketLayer = require "app.modules.glyphs.GlyphsPacketLayer"

UI = UI or {}

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_town_gem.plist",
    "ui_town_glyphs.plist",
}

-- 洗练状态
local REFINED_STATUS = {
    REFINED_NONE  = 1,     -- 没有放入雕纹
    REFINED_AUTOREFINED = 2,     -- 雕纹自动洗练
}

local GlyphRefineType = {
    GlyphRefineType_None = 0, -- 闲置
    GlyphRefineType_Common = 1, -- 普通
    GlyphRefineType_Pay = 2,  -- 水晶洗练

}

local COM_WIDTH = 920
local COM_HEIGHT = 580

local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(341, 632)

-- local COM_WIDTH = winSize.width
-- local COM_HEIGHT = winSize.height

function GlyphsRefinedView:ctor()
    GlyphsRefinedView.super.ctor(
    	self,
    	UI.Type.GLYPHS_REFINED,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.status = REFINED_STATUS.REFINED_NONE
    self.autoTimes = 0
    self.autoTimesIsPay = GlyphRefineType.GlyphRefineType_None
    self.autoSelectDatas = {}
    self.mlastAttrDatas = {}
    self.mlastIsGiveUp = {}
end

function GlyphsRefinedView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.glyphs", "Glyphs", false)
    GlyphsRefinedView.super.init(self, ... )
end

function GlyphsRefinedView:dtor()
    GlyphsRefinedView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.glyphs.GlyphsRefinedView")
end


function GlyphsRefinedView:onInitView()
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

function GlyphsRefinedView:createLeftView()
    self.leftLayer:removeAllChildren()

    -- 操作提示区
    local operateBg = UI.Image:create()
    operateBg:init("ui_glyphs_title.png")
    operateBg:center(50, -320)
    self.leftLayer:addChild(operateBg, 5)

    local operateText = UI.Text:create()
    operateText:init(UI.TEXT_227002,UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 194, g = 194, b = 194})
    operateText:center(0,0)
    operateBg:addChild(operateText)
    self._operateText = operateText

    -- 洗练底图
    local leftBgAnimation = UI.Animation:create()
    leftBgAnimation:init("effect_ui_town_xiangqian_shengji_di.json", "effect_ui_town_xiangqian_shengji_di.atlas")
    leftBgAnimation:updateTime(0)
    leftBgAnimation:center(50, -230)
    self.leftLayer:addChild(leftBgAnimation, 1)
    self._leftBgAnimation = leftBgAnimation

    -- 洗练框动画
    local kuangAnimation = UI.Animation:create()
    kuangAnimation:init("effect_ui_town_xiangqian_shengji_kuang.json", "effect_ui_town_xiangqian_shengji_kuang.atlas")
    kuangAnimation:updateTime(0)
    kuangAnimation:centerUp(0)
    kuangAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "trigger") then
            if self.autoTimesIsPay ~= GlyphRefineType.GlyphRefineType_None then
                self:autoRefinedChoseSave()
            end
        end
    end)
    self._kuangAnimation = kuangAnimation
    leftBgAnimation:addChild(kuangAnimation, 3)

    -----------------------------------------------------
    self._leftBgAnimation:setTimeScale(0.0)
    --self._kuangAnimation:setTimeScale(0)
    -----------------------------------------------------

    -- 添加洗练雕纹框
    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:center(0,2)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setTouchEnable(true)
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mGoodsGrid:showInfoArea();
    --self.mGoodsGrid.state = 1

    self._kuangAnimation:addComponent("icon", self.mGoodsGrid, true)

    -- 属性队列
    if self.attributeNode then
        self.attributeNode:removeFromParent()
        self.attributeNode = nil
    end
    self.attributeNode = UI.Layout:create();
    self.attributeNode:init()
    self.attributeNode:setSize(leftSize.width, leftSize.height)
    self.attributeNode:leftBottom(-150,-640)

    leftBgAnimation:addChild(self.attributeNode, 4)

    -- 按钮分割线
    local partitionLineBg = UI.Image:create()
    partitionLineBg:init("ui_glyphs_line_2.png")
    partitionLineBg:center(50, 25)
    self.leftLayer:addChild(partitionLineBg, 1)

    -- 洗练
    local refinedBtn = UI.Button:create()
    refinedBtn:init("ui_glyphs_btn_2.png", "ui_glyphs_btn_2.png", "ui_glyphs_btn_2_2.png")
    refinedBtn:setText(UI.TEXT_227053)
    refinedBtn:setTextFont(UI.FONT_BOLD,18,{r=48,g=49,b=53})
    refinedBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not self.mGoodsData or (not self:isAllowRefined()) then
            return
        end

        local data = {}
        data.isPay = false
        data.glyphData = self.mGoodsData

        local GlyphRefinedItemView = UI.GlyphRefinedItemView:create(data)
        GlyphRefinedItemView:init()
        self:addChild(GlyphRefinedItemView, 100001)
    end)
    refinedBtn:center(-100, 310)
    refinedBtn:closeClickScale()
    leftBgAnimation:addChild(refinedBtn)
    self._refinedBtn = refinedBtn

    -- 水晶洗练
    local crystalRefinedBtn = UI.Button:create()
    crystalRefinedBtn:init("ui_glyphs_btn_2.png", "ui_glyphs_btn_2.png", "ui_glyphs_btn_2_2.png")
    crystalRefinedBtn:setText(UI.TEXT_227008)
    crystalRefinedBtn:setTextFont(UI.FONT_BOLD,UI.FONT_SIZE_18PX,{r=48,g=49,b=53})
    crystalRefinedBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if not self.mGoodsData or (not self:isAllowRefined(true)) then
            return
        end

        local data = {}
        data.isPay = true
        data.glyphData = self.mGoodsData

        local GlyphRefinedItemView = UI.GlyphRefinedItemView:create(data)
        GlyphRefinedItemView:init()
        self:addChild(GlyphRefinedItemView, 100001)
    end)
    crystalRefinedBtn:center(120, 310)
    crystalRefinedBtn:closeClickScale()
    leftBgAnimation:addChild(crystalRefinedBtn)
    self._crystalRefinedBtn = crystalRefinedBtn

    -- 停止洗练
    local stopRefinedBtn = UI.Button:create()
    stopRefinedBtn:init("ui_glyphs_btn_2.png", "ui_glyphs_btn_2.png", "ui_glyphs_btn_2_2.png")
    stopRefinedBtn:setText(UI.TEXT_227023)
    stopRefinedBtn:setTextFont(UI.FONT_BOLD,UI.FONT_SIZE_18PX,{r=48,g=49,b=53})
    stopRefinedBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:stopAutoAndShowResult()
    end)
    stopRefinedBtn:center(0, 310)
    stopRefinedBtn:closeClickScale()
    leftBgAnimation:addChild(stopRefinedBtn)
    stopRefinedBtn:setVisible(false)
    self._stopRefinedBtn = stopRefinedBtn

    -- 剩余自动洗练次数
    local remnantText = UI.Text:create()
    remnantText:init(string.format(UI.TEXT_1324102, 0),UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 240, g = 201, b = 68})
    remnantText:center(0,-33)
    remnantText:setName("remnantText")
    stopRefinedBtn:addChild(remnantText)

    ----------------------------------------------------------
    -- 普通洗练
    local addBtn = refinedBtn
    -- 背景底图
    local sellIcon = UI.Layout:create()
    sellIcon:init()
    sellIcon:setSize(112, 20)
    sellIcon:center(0, -35)
    sellIcon:setName("sellIcon")
    addBtn:addChild(sellIcon, 5)

    -- 消耗的材料
    local costConfig = ConfigManager:getGlyphsRefinedCostConfig()
    local final = nil
    final = string.split(costConfig.glyphCommonRefinedConsume, ",")
    local goodsData2 = GoodsDataManager:createLocalGoodsData(tonumber(final[1]))
    local sellIcon1 = UI.Image:create()
    sellIcon1:init(goodsData2:getSmallIconName())
    sellIcon1:center(-30,0)
    sellIcon:addChild(sellIcon1)

    -- 消耗的数量
    local sellText = UI.Text:create()
    local finalCost = nil
    finalCost = string.split(costConfig.glyphCommonRefinedConsume, ",")
    sellText:init(tostring(final[2]),UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 240, g = 201, b = 68})
    sellText:centerLeft(42,0)
    sellIcon:addChild(sellText)
    ----------------------------------------------------------
    -- 水晶洗练
    local addBtn = crystalRefinedBtn
    -- 背景底图
    local sellIcon = UI.Layout:create()
    sellIcon:init()
    sellIcon:setSize(112, 20)
    sellIcon:center(0, -35)
    sellIcon:setName("sellIcon")
    addBtn:addChild(sellIcon, 5)

    -- 消耗的材料
    local costConfig = ConfigManager:getGlyphsRefinedCostConfig()
    local final = nil
    final = string.split(costConfig.glyphPayRefinedConsume, ";")
    for k,v in pairs(final) do
        local config = string.split(v, ",")
        local goodsData2 = GoodsDataManager:createLocalGoodsData(tonumber(config[1]))
        local sellIcon1 = UI.Image:create()
        sellIcon1:init(goodsData2:getSmallIconName())
        sellIcon1:center(-55 + (k - 1) * 80,0)
        sellIcon:addChild(sellIcon1)

        -- 消耗的数量
        local sellText = UI.Text:create()
        local finalCost = nil
        finalCost = string.split(costConfig.glyphPayRefinedConsume, ";")
        sellText:init(tostring(config[2]),UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 240, g = 201, b = 68})
        sellText:centerLeft(17 + (k - 1) * 80,0)
        sellIcon:addChild(sellText)
    end
end

function GlyphsRefinedView:createRightView()
    self.rightLayer:removeAllChildren()

    local hideList = {
        UI.BagGoodsPanel.BAG_TYPE.ALL,
        UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
        UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
        UI.BagGoodsPanel.BAG_TYPE.ITEM,
        UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
        UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
        UI.BagGoodsPanel.BAG_TYPE.RELIC,
        UI.BagGoodsPanel.BAG_TYPE.GLYPH,
    }

    local showList = {
        UI.BagGoodsPanel.BAG_TYPE.GLYPH_ALL,
    }
   

    local glyphsPacketLayer = GlyphsPacketLayer:create(hideList, showList)
    glyphsPacketLayer:init()
    glyphsPacketLayer:centerRight(0)
    self.rightLayer:addChild(glyphsPacketLayer, 99)
    self.glyphsPacketLayer = glyphsPacketLayer

    local bagList = glyphsPacketLayer:getBagList()
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

    self._bagGridList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.GLYPH_ALL)

    self._bagGridList:refreshView()
end

function GlyphsRefinedView:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end
    -- 根据拖动的类型来判断如何处理后续逻辑
    self:runReadyAnimtion()
end

function GlyphsRefinedView:bagDragEndedCallback(grid, touchPosition, isInBag)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
        self._bagGridList:refreshView()
    end
    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end

    if not isInBag then
        -- 根据拖动的类型来判断如何处理后续逻辑
        if self.mGoodsData ~= nil then
            self.mGoodsData._changeNum = 0
        end

        goodsData._changeNum = -1
        self.mGoodsData = goodsData
        -- self._bagGridList:setUsedType(self:getChoiceGemStone())
        self._bagGridList:refreshView()

        self.mGoodsGrid:setData(self.mGoodsData)
        self.mGoodsGrid:setVisible(true)
        self.mGoodsGrid:show()
        self.mGoodsGrid:hideCountLabel()
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideBG()
        self.mGoodsGrid:updateView()

        -- 切换背包的tab
        --self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)

        self:refreshAttributesByGoods()
        self:runPutAnimtion()
    else 
        self:runCancelReadyAnimtion()
    end
end

function GlyphsRefinedView:onTouchBeganByGoodsGrid(grid,touchPosition)
    if self.status == REFINED_STATUS.REFINED_AUTOREFINED then
        return false
    end

    local goodsData = grid:getData()

    self:runReadyAnimtion(grid)

    return true
end

function GlyphsRefinedView:onTouchEndedByGoodsGrid(grid, inSide)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if not inSide then
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()        
        self.mGoodsData._changeNum = 0
        self._bagGridList:setUsedType(self:getInitUseType())
        self._bagGridList:refreshView()
        --self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
        self.mGoodsData = nil
        self.mGoodsGrid:center()
        self.mGoodsGrid:setVisible(false)
        self:runCancelReadyAnimtion();

        self._bagGridList:refreshView()
        self:cancelDevour()
        self:refreshAttributesByGoods()
    else
        self:runPutAnimtion()
    end
end

-- 准备放入动画
function GlyphsRefinedView:runReadyAnimtion(goodsGrid)
    self._kuangAnimation:setAnimation("begin", false, 0)
    self._kuangAnimation:addAnimation("loop", false, 0)
    self._kuangAnimation:setTimeScale(1)
end

-- 放入动画
function GlyphsRefinedView:runPutAnimtion()
    self._kuangAnimation:setAnimation("end", false, 0)
    self._kuangAnimation:setTimeScale(1)
end

-- 取消准备放入动画
function GlyphsRefinedView:runCancelReadyAnimtion()
    self._kuangAnimation:setAnimation("end", false, 0)
    self._kuangAnimation:setTimeScale(1)
end

function GlyphsRefinedView:cancelDevour()
    self._isSelect = false
    if not tolua.isnull(self._bagGridList) then
        self._bagGridList:resetHandleStatus()
        self._bagGridList._deleteItemTable = {}
    end
end

function GlyphsRefinedView:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_GLYPH
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    return usedTypeList
end

function GlyphsRefinedView:equipmentGlyphRefined(data)
    -- 装备上的雕文洗练
    if data then
        if data.glyphsDataByEquipment then
            self.mGoodsData._changeNum = 0
            self.mGoodsData = data.glyphsDataByEquipment
            self.mGoodsData._changeNum = -1
        end
    end
end

function GlyphsRefinedView:refreshAttributesByGoods(data)
    self.attributeNode:removeAllChildren()
    if self.mGoodsData then
        self:equipmentGlyphRefined(data)

        local normalDetailArr = self.mGoodsData:getNormalDetailDescription()
        local lastAttrData = self.mGoodsData:getLastAttrData()
        local leftOffset = 0

        local pInfoArea = UI.GlyphInfoArea:create()
        if normalDetailArr then 
            for i,data in ipairs(normalDetailArr) do
                local attributeConfig = ConfigManager:getGlyphAttributeByID(tonumber(data[3]))
                local levelColor = pInfoArea:getAttributeColor(attributeConfig, tonumber(data[2]), self.mGoodsData)

                local point = UI.Image:create()
                point:init("ui_glyphs_tabulation_2.png")
                point:leftUp(leftOffset, 20 + i * 42)
                self.attributeNode:addChild(point, 5)
                
                -- UI.FONT_COLOR_41_41_45
                local baseText = UI.Text:create()
                baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, levelColor)
                baseText:setTextLeft()
                baseText:leftUp(leftOffset + 10, 24 + i * 42)
                self.attributeNode:addChild(baseText, 5)
                if(baseText:getContentSize().width > 180) then 
                    baseText:setWidth(180)
                    baseText:setText(string.format("%s",data[1]))
                end

                local baseValue = UI.Text:create()
                local heroData = RoleDataManager:getMaster()
                local attributeValueMax = pInfoArea:getAttributeMaxValue(attributeConfig, self.mGoodsData)
                baseValue:init(string.format("%s",data[2]).." ("..attributeValueMax..")", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, levelColor)
                baseValue:setTextLeft()
                baseValue:leftUp(baseText:getContentSize().width + 3, 0)
                baseText:addChild(baseValue)
                --baseValue:setScale(0.7)
                
                if #lastAttrData > 0 then
                    for k1,v1 in pairs(lastAttrData) do
                        if tonumber(data[3]) == v1.attrType then
                            local arrowPicName = "ui_glyphs_arrow_1.png"
                            if tonumber(v1.attrValue) < 0 then
                                arrowPicName = "ui_glyphs_arrow_2.png"
                            end
                            local arrow = UI.Image:create()
                            arrow:init(arrowPicName)
                            --arrow:center(0, 0)
                            arrow:centerRight(-27, 0)
                            point:addChild(arrow)

                            local resultText = UI.Text:create()
                            resultText:init(tostring(v1.attrValue), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r=48,g=49,b=53})
                            resultText:centerRight(35, 0)
                            point:addChild(resultText)

                            -- 判断数值是否超出格子
                            local strLen = string.len(tostring(data[2])) + string.len(tostring(attributeValueMax)) + string.len(tostring(v1.attrValue))
                            if strLen > 20 then
                                baseText:setFontSize(UI.FONT_SIZE_14PX)
                                baseValue:setFontSize(UI.FONT_SIZE_14PX)
                                resultText:setFontSize(UI.FONT_SIZE_14PX)
                                baseValue:leftUp(30, -7)
                            elseif strLen > 17 then
                                baseText:setFontSize(UI.FONT_SIZE_16PX)
                                baseValue:setFontSize(UI.FONT_SIZE_16PX)
                                resultText:setFontSize(UI.FONT_SIZE_16PX)
                                baseValue:leftUp(43, -3)
                            end
                        end
                    end
                end
            end
        end
    end

    self:isAutoRefined(data)
    self:updateBagName()
end

function GlyphsRefinedView:refreshButtonStatus()
    if self.status == REFINED_STATUS.REFINED_NONE then
        self._refinedBtn:setText(UI.TEXT_227053)
        self._refinedBtn:setVisible(true)
        self._crystalRefinedBtn:setText(UI.TEXT_227008)
        self._crystalRefinedBtn:enable()
        self._crystalRefinedBtn:setVisible(true)
        self._stopRefinedBtn:setVisible(false)
        self._stopRefinedBtn:getChildByName("remnantText"):setText(string.format(UI.TEXT_1324102, self.autoTimes))
    else
        self._refinedBtn:setText(UI.TEXT_227053)
        self._refinedBtn:setVisible(false)
        self._crystalRefinedBtn:setText(UI.TEXT_227053)
        self._crystalRefinedBtn:disable()
        self._crystalRefinedBtn:setVisible(false)
        self._stopRefinedBtn:setVisible(true)
        self._stopRefinedBtn:getChildByName("remnantText"):setText(string.format(UI.TEXT_1324102, self.autoTimes))
    end
end

function GlyphsRefinedView:updateBagName()
    if self.status ~= REFINED_STATUS.REFINED_NONE then
        self._operateText:setText(UI.TEXT_227003)
    else
        self._operateText:setText(UI.TEXT_227002)
    end
end

function GlyphsRefinedView:isAllowRefined(isCrystal)
    local isAllow = true

    if not self.mGoodsData then
        isAllow = false
        return isAllow
    end

    local costConfig = ConfigManager:getGlyphsRefinedCostConfig()
    if isCrystal then
        -- 消耗的材料
        local costConfig = ConfigManager:getGlyphsRefinedCostConfig()
        local final = nil
        final = string.split(costConfig.glyphPayRefinedConsume, ";")
        for k,v in pairs(final) do
            local config = string.split(v, ",")
            local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(config[1]), true)
            if goodNumber < tonumber(config[2]) then
                -- 材料不足
                UI.ScrollBar:createByText(UI.TEXT_1212360)
                isAllow = false
                return isAllow
            end
        end
    else
        local final = string.split(costConfig.glyphCommonRefinedConsume, ",")
        local goodNumber = GameDataManager:getInstance():getInscription()
        if goodNumber < tonumber(final[2]) then
            -- 铭文不足
            UI.ScrollBar:createByText(UI.TEXT_227004)
            isAllow = false
            return isAllow
        end
    end

    -- 判断是否全属性都到达最大值
    local nowAttrData = self.mGoodsData:getNowAttrData()
    local allAttainMax = true
    for k,v in pairs(nowAttrData) do
        -- 这里这个判断，雕纹重新洗练后的值是否超过当前等级能允许的最大值
        -- 超过则设置为最大值
        local pInfoArea = UI.GlyphInfoArea:create()
        local attributeConfig = ConfigManager:getGlyphAttributeByID(v.attrType)
        local attributeValueMax = pInfoArea:getAttributeMaxValue(attributeConfig, self.mGoodsData)
        if v.attrValue < attributeValueMax then
            allAttainMax = false
        end
    end
    if allAttainMax then
        isAllow = false
        -- 雕纹属性已满
        UI.ScrollBar:createByText(UI.TEXT_227006)
        return isAllow
    end

    return isAllow
end

function GlyphsRefinedView:isGaveupWorth()
    -- 判断本次放弃洗练的值，是否划算
    if self.mGoodsData then
        local lastAttrData = self.mGoodsData:getLastAttrData()
        if #lastAttrData > 0 then
            local satisfyValue = false
            local satisfyAttr = false
            if self.autoSelectDatas.valueSelect and (#self.autoSelectDatas.selcetAttr > 0 ) then
                -- 要同时满足属性价值为正，且勾选的属性为正值
                satisfyValue = true
                satisfyAttr = true
            elseif (#self.autoSelectDatas.selcetAttr > 0 ) then
                -- 只用满足勾选的属性为正值
                satisfyAttr = true
            else
                -- 只用满足属性价值为正
                satisfyValue = true
            end

            local value = 0
            for k1,v1 in pairs(lastAttrData) do
                if satisfyValue and satisfyAttr then
                    for k2,attrType in pairs(self.autoSelectDatas.selcetAttr) do
                        if (attrType == v1.attrType) and (tonumber(v1.attrValue) < 0) then
                            -- 勾选的属性值为负
                            return false
                        end
                    end
                    value = value + self:practicalChangeValue(v1.attrType, tonumber(v1.attrValue))
                elseif satisfyAttr then
                    for k2,attrType in pairs(self.autoSelectDatas.selcetAttr) do
                        if (attrType == v1.attrType) and (tonumber(v1.attrValue) < 0) then
                            -- 勾选的属性值为负
                            return false
                        end
                    end
                else
                    value = value + self:practicalChangeValue(v1.attrType, tonumber(v1.attrValue))
                end

                if value < 0 then
                    return false
                end
            end
        end
    end

    return true
end

function GlyphsRefinedView:practicalChangeValue(attrType, attrValue)
    local attributeConfig = ConfigManager:getGlyphAttributeByID(tonumber(attrType))
    local combatScore = attributeConfig.combatScore / 10

    local pInfoArea = UI.GlyphInfoArea:create()
    local attributeValueMax = pInfoArea:getAttributeMaxValue(attributeConfig, self.mGoodsData)

    local nowAttrData = self.mGoodsData:getNowAttrData()
    for k,attrData in pairs(nowAttrData) do
        if attrData.attrType == attrType then
            local finalValue = attrValue + attrData.attrValue
            if finalValue == 0 then
                -- 则取attrValue为负的全部值
                return (combatScore * attrValue)
            elseif finalValue < 0 then
                -- 则取当前属性的值
                return (-combatScore * attrData.attrValue)
            elseif finalValue > attributeValueMax then
                -- 则取当前属性和最大属性值的差值
                return (combatScore * (attributeValueMax - attrData.attrValue))
            else
                -- 取升级属性的值
                return (combatScore * attrValue)
            end
        end
    end
end

function GlyphsRefinedView:isAutoRefined(data)
    -- 判断当前是否执行自动洗练步骤
    if self.autoTimes > 0 or self.autoTimesIsPay ~= GlyphRefineType.GlyphRefineType_None then
        if data then
            if data.isRefined then
                self._leftBgAnimation:setAnimation("trigger", false)
                self._kuangAnimation:setAnimation("trigger", false)

                -- 保存/放弃提示
                local goodsType = self.mGoodsData:calculateGlyphType()
                local strPic = "ui_glyphs_box_abandon.png"
                local strPic2 = "ui_glyphs_mark_abandon.png"
                if self:isGaveupWorth() then
                    strPic = string.format("ui_glyphs_box_save%d.png", (goodsType - 1))
                    strPic2 = "ui_glyphs_mark_save.png"
                else
                    strPic = string.format("ui_glyphs_box_abandon%d.png", (goodsType - 1))
                    strPic2 = "ui_glyphs_mark_abandon.png"
                end
                local hintPic = UI.Image:create()
                hintPic:init(strPic)
                hintPic:leftUp(-35,55)
                self.attributeNode:addChild(hintPic, 2)

                local hintPic2 = UI.Image:create()
                hintPic2:init(strPic2)
                hintPic2:center(-176,-260)
                self.attributeNode:addChild(hintPic2, 6)

                -- 保存每次洗练的增长或减少
                local lastAttrData = {}
                lastAttrData = self.mGoodsData:getLastAttrData()
                table.insert(self.mlastAttrDatas, lastAttrData)
                table.insert(self.mlastIsGiveUp, self:isGaveupWorth())
            elseif data.isQuick then
                self.autoTimes = 0
                -- 保存每次洗练的增长或减少
                -- local lastAttrData = {}
                -- lastAttrData = self.mGoodsData:getLastAttrData()
                -- table.insert(self.mlastAttrDatas, lastAttrData)
                table.insert(self.mlastIsGiveUp, self:isGaveupWorth())

                self:stopAutoAndShowResult()
            else
                self:startAutoRefined()
            end
        end
    else
        self:refreshButtonStatus()
    end
end

function GlyphsRefinedView:setAutoRefined(data)
    -- 设置批量洗练初始数据
    self.autoTimes = data.times
    self.autoTimesIsPay = data.isPay and GlyphRefineType.GlyphRefineType_Pay or GlyphRefineType.GlyphRefineType_Common
    self.autoSelectDatas = {}
    self.autoSelectDatas.selcetAttr = data.selcetAttr
    self.autoSelectDatas.valueSelect = data.valueSelect
    self.autoLastAttrDatas = {}

    local isQuick = data.isQuick or false

    local nowAttrData = self.mGoodsData:getNowAttrData()
    for k,v in pairs(nowAttrData) do
        local attr = {}
        attr.attrType = v.attrType
        attr.attrValue = v.attrValue
        table.insert(self.autoLastAttrDatas, attr)
    end

    if isQuick then
        self:sendQuickRefineMessage()
    else
        local lastAttrData = self.mGoodsData:getLastAttrData()
        if #lastAttrData > 0 then
            -- 当前雕纹有未选择的洗练属性,先根据洗练条件进行选择
            self:autoRefinedChoseSave()
        else
            self:startAutoRefined()
        end
    end

    self.status = REFINED_STATUS.REFINED_AUTOREFINED
    self:refreshButtonStatus()

    -- 防止正在洗练的雕纹被替代
    self._bagGridList:updateCanDrag(false)
end

function GlyphsRefinedView:sendQuickRefineMessage()
    local message = {}
    message.refineType = self.autoTimesIsPay
    message.glyphuid = self.mGoodsData:getEntityID()
    message.equipuid = self.mGoodsData:getEquipEntityId()
    message.packetType = self.mGoodsData:getEquipPacketType()
    message.refineNum = self.autoTimes
    Net.NetNPCSystem:sendGlyphQuickRefineMessage(message)
end

function GlyphsRefinedView:startAutoRefined()
    if self.autoTimes <= 0 or self.autoTimesIsPay == GlyphRefineType.GlyphRefineType_None then
        self:stopAutoAndShowResult()
        return
    end

    local isPay = (self.autoTimesIsPay == GlyphRefineType.GlyphRefineType_Pay) and true or false
    if not self:isAllowRefined(isPay) then
        -- 本次自动洗练不满足洗练要求
        self:stopAutoAndShowResult()
        return
    end

    -- 开始批量洗练
    self.autoTimes = self.autoTimes - 1
    if self.autoTimesIsPay == GlyphRefineType.GlyphRefineType_Common then
        -- 洗练消息
        local message = {}
        message.refineType = GlyphRefineType.GlyphRefineType_Common
        message.glyphuid = self.mGoodsData:getEntityID()
        message.equipuid = self.mGoodsData:getEquipEntityId()
        message.packetType = self.mGoodsData:getEquipPacketType()
        Net.NetNPCSystem:sendGlyphRefine(message)
    elseif self.autoTimesIsPay == GlyphRefineType.GlyphRefineType_Pay then
        -- 洗练
        local message = {}
        message.refineType = GlyphRefineType.GlyphRefineType_Pay
        message.glyphuid = self.mGoodsData:getEntityID()
        message.equipuid = self.mGoodsData:getEquipEntityId()
        message.packetType = self.mGoodsData:getEquipPacketType()
        Net.NetNPCSystem:sendGlyphRefine(message)
    end

    self:refreshButtonStatus()
end

function GlyphsRefinedView:autoRefinedChoseSave()
    -- 选择是否保存本次自动洗练结果是否保存
    print("autoRefinedChoseSave---?>:", self:isGaveupWorth())
    if not self:isGaveupWorth() then
        -- 洗练结果消息,放弃
        local message = {}
        message.isGet = false
        message.glyphuid = self.mGoodsData:getEntityID()
        message.equipuid = self.mGoodsData:getEquipEntityId()
        message.packetType = self.mGoodsData:getEquipPacketType()
        Net.NetNPCSystem:sendGlyphRefineConfirm(message)
    else
        -- 洗练结果消息,保存
        local message = {}
        message.isGet = true
        message.glyphuid = self.mGoodsData:getEntityID()
        message.equipuid = self.mGoodsData:getEquipEntityId()
        message.packetType = self.mGoodsData:getEquipPacketType()
        Net.NetNPCSystem:sendGlyphRefineConfirm(message)
    end
end

function GlyphsRefinedView:stopAutoAndShowResult()
    local richTextLayout = self:createRichText()
    local okCallBack = function ()
        self.mlastAttrDatas = {}
        self.mlastIsGiveUp = {}
    end

    local lastAttrDatas = {}
    lastAttrDatas = self.mlastAttrDatas
    local lastIsGiveUp = {}
    lastIsGiveUp = self.mlastIsGiveUp
    local richShow = UI.GlyphRefinedShowResultView:create()
    richShow:init(richTextLayout, okCallBack, lastAttrDatas, lastIsGiveUp)

    self:addChild(richShow, 100001)

    self.autoTimes = 0
    self.autoTimesIsPay = GlyphRefineType.GlyphRefineType_None
    self.autoSelectDatas = {}
    self.status = REFINED_STATUS.REFINED_NONE
    self.autoLastAttrDatas = {}
    self:refreshButtonStatus()
    self._bagGridList:updateCanDrag(true)
end

function GlyphsRefinedView:createRichText()
    -- body
    local textLayout = UI.Layout:create()
    textLayout:init()
    textLayout:setSize(354, 120)
    -- textLayout:enableDebugDraw()
    textLayout:center(0,0)

    local normalDetailArr = self.mGoodsData:getNormalDetailDescription()
    local lastAttrData = self.autoLastAttrDatas
    local leftOffset = 0
    local pInfoArea = UI.GlyphInfoArea:create()

    if normalDetailArr then 
        for i,data in ipairs(normalDetailArr) do
            local attributeConfig = ConfigManager:getGlyphAttributeByID(tonumber(data[3]))
            local levelColor = pInfoArea:getAttributeColor(attributeConfig, tonumber(data[2]), self.mGoodsData)

            local point = UI.Image:create()
            point:init("ui_glyphs_tabulation_2.png")
            point:center(0,(i - 1) * 40)
            --point:leftUp(leftOffset, 20 + i * 40)
            textLayout:addChild(point)
            
            -- UI.FONT_COLOR_41_41_45
            local baseText = UI.Text:create()
            baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, levelColor)
            baseText:setTextLeft()
            baseText:leftUp(leftOffset + 20, (i - 1) * 40 + 45)
            textLayout:addChild(baseText)
            if(baseText:getContentSize().width > 180) then 
                baseText:setWidth(180)
                baseText:setText(string.format("%s",data[1]))
            end

            local baseValue = UI.Text:create()
            local heroData = RoleDataManager:getMaster()
            local attributeValueMax = pInfoArea:getAttributeMaxValue(attributeConfig, self.mGoodsData)
            baseValue:init(string.format("%s",data[2]).." ("..attributeValueMax..")", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, levelColor)
            baseValue:setTextLeft()
            baseValue:leftUp(baseText:getContentSize().width + 3, 0)
            baseText:addChild(baseValue)
            --baseValue:setScale(0.7)
            if #lastAttrData > 0 then
                for k1,v1 in pairs(lastAttrData) do
                    if tonumber(data[3]) == v1.attrType then
                        local promoteValue = data[2] - v1.attrValue
                        local arrowPicName = "ui_glyphs_arrow_1.png"
                        if tonumber(promoteValue) < 0 then
                            arrowPicName = "ui_glyphs_arrow_2.png"
                        end
                        local arrow = UI.Image:create()
                        arrow:init(arrowPicName)
                        --arrow:center(0, 0)
                        arrow:centerRight(10, 0)
                        point:addChild(arrow)

                        local resultText = UI.Text:create()
                        resultText:init(tostring(promoteValue), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r=48,g=49,b=53})
                        resultText:centerRight(35, 0)
                        point:addChild(resultText)

                        -- 判断数值是否超出格子
                        local strLen = string.len(tostring(data[2])) + string.len(tostring(attributeValueMax)) + string.len(tostring(promoteValue))
                        if strLen > 20 then
                            baseText:setFontSize(UI.FONT_SIZE_14PX)
                            baseValue:setFontSize(UI.FONT_SIZE_14PX)
                            resultText:setFontSize(UI.FONT_SIZE_14PX)
                            baseValue:leftUp(30, -7)
                        elseif strLen > 17 then
                            baseText:setFontSize(UI.FONT_SIZE_16PX)
                            baseValue:setFontSize(UI.FONT_SIZE_16PX)
                            resultText:setFontSize(UI.FONT_SIZE_16PX)
                            baseValue:leftUp(43, -3)
                        end
                    end
                end
            end
        end
    end

    return textLayout
end

function GlyphsRefinedView:bindModel()
    Avalon.MessageCenter:bind(GameMessage.MC_NPC_GLYPH_REFINED_REFRESH,self, self.refreshAttributesByGoods)
    Avalon.MessageCenter:bind(GameMessage.MC_NPC_GLYPH_REFINED_MANY_TIMES,self, self.setAutoRefined)
end


function GlyphsRefinedView:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_NPC_GLYPH_REFINED_REFRESH,self, self.refreshAttributesByGoods)
    Avalon.MessageCenter:unbind(GameMessage.MC_NPC_GLYPH_REFINED_MANY_TIMES,self, self.setAutoRefined)
end





return GlyphsRefinedView













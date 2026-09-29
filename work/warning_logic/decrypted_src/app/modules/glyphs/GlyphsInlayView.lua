------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/10/19
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GlyphsInlayView = class("GlyphsInlayView", UI.HWBtnComponent)
local GlyphsPacketLayer = require "app.modules.glyphs.GlyphsPacketLayer"
require "app.ui.shoplayer.BagGoodsPanel"

UI = UI or {}

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_town_gem.plist",
    "ui_town_glyphs.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580

local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(341, 632)

-- local COM_WIDTH = winSize.width
-- local COM_HEIGHT = winSize.height

function GlyphsInlayView:ctor()
    GlyphsInlayView.super.ctor(
    	self,
    	UI.Type.GLYPHS_INLAY,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.mGoodsDataEquipment = nil;          --装备属性
    self.mGoodsDataGlyph = nil;              --雕纹属性
end

function GlyphsInlayView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.glyphs", "Glyphs", false)
    GlyphsInlayView.super.init(self, ... )
end

function GlyphsInlayView:dtor()
    GlyphsInlayView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.glyphs.GlyphsInlayView")
end


function GlyphsInlayView:onInitView()
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

function GlyphsInlayView:createLeftView()
    self.leftLayer:removeAllChildren()

    -- 操作提示区
    local operateBg = UI.Image:create()
    operateBg:init("ui_glyphs_title.png")
    operateBg:center(50, -315)
    self.leftLayer:addChild(operateBg, 5)

    local operateText = UI.Text:create()
    operateText:init(UI.TEXT_227002,UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 194, g = 194, b = 194})
    operateText:center(0,0)
    operateBg:addChild(operateText)
    self._operateText = operateText

    -- 镶嵌底图
    local leftBgAnimation = UI.Animation:create()
    leftBgAnimation:init("effect_ui_town_xiangqian_xiangqian_di.json", "effect_ui_town_xiangqian_xiangqian_di.atlas")
    leftBgAnimation:updateTime(0)
    leftBgAnimation:center(50, -230)
    self.leftLayer:addChild(leftBgAnimation, 1)
    self._leftBgAnimation = leftBgAnimation

    -- 雕纹框动画
    local kuangAnimationGlyph = UI.Animation:create()
    kuangAnimationGlyph:init("effect_ui_town_xiangqian_xiangqian_kuang2.json", "effect_ui_town_xiangqian_xiangqian_kuang2.atlas")
    kuangAnimationGlyph:updateTime(0)
    -- kuangAnimation:setTimeScale(0)
    kuangAnimationGlyph:centerUp(100)
    self._kuangAnimationGlyph = kuangAnimationGlyph
    leftBgAnimation:addChild(kuangAnimationGlyph, 3)
    --kuangAnimationGlyph:setScale(0.9)

    -- 添加雕纹框
    self.mGoodsGridGlyph = UI.GoodsGrid:create()
    self.mGoodsGridGlyph:init()
    self.mGoodsGridGlyph:center(0, -4)
    self.mGoodsGridGlyph:hide()
    self.mGoodsGridGlyph:hideCountLabel()
    self.mGoodsGridGlyph:hideNewIcon()
    self.mGoodsGridGlyph:setTouchEnable(true)
    self.mGoodsGridGlyph:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGridGlyph:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGridGlyph))
    self.mGoodsGridGlyph:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridGlyph))
    self.mGoodsGridGlyph:showInfoArea()
    self.mGoodsGridGlyph:setScale(0.8)
    --self.mGoodsGrid.state = 1

    self._kuangAnimationGlyph:addComponent("icon", self.mGoodsGridGlyph, true)

    ------------------------------------------
    -- 装备框动画
    local kuangAnimationEquipment = UI.Animation:create()
    kuangAnimationEquipment:init("effect_ui_town_xiangqian_xiangqian_kuang1.json", "effect_ui_town_xiangqian_xiangqian_kuang1.atlas")
    kuangAnimationEquipment:setAnimation("hint_begin_blue", false)
    kuangAnimationEquipment:updateTime(0)
    kuangAnimationEquipment:centerUp(0)
    self._kuangAnimationEquipment = kuangAnimationEquipment
    leftBgAnimation:addChild(kuangAnimationEquipment, 3)

    -- 添加装备框
    self.mGoodsGridEquipment = UI.GoodsGrid:create()
    self.mGoodsGridEquipment:init()
    self.mGoodsGridEquipment:center(0, -4)
    self.mGoodsGridEquipment:hide()
    self.mGoodsGridEquipment:hideCountLabel()
    self.mGoodsGridEquipment:hideNewIcon()
    self.mGoodsGridEquipment:setTouchEnable(true)
    self.mGoodsGridEquipment:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGridEquipment:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGridEquipment))
    self.mGoodsGridEquipment:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGridEquipment))
    self.mGoodsGridEquipment:showInfoArea();

    self._kuangAnimationEquipment:addComponent("icon", self.mGoodsGridEquipment, true)

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
    partitionLineBg:init("ui_glyphs_line_2.png")
    partitionLineBg:center(50, -85)
    self.leftLayer:addChild(partitionLineBg, 1)
end

function GlyphsInlayView:createRightView()
    self.rightLayer:removeAllChildren()

    local hideList = {
        UI.BagGoodsPanel.BAG_TYPE.ALL,
        --UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
        --UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
        UI.BagGoodsPanel.BAG_TYPE.ITEM,
        UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
        UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
        UI.BagGoodsPanel.BAG_TYPE.RELIC,
    }

    local showList = {
        UI.BagGoodsPanel.BAG_TYPE.GLYPH,
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

    self._bagGridList:changeBagDefaultIndex(2)

    self._bagGridList:refreshView()
end

function GlyphsInlayView:bagDragBeganCallback(grid, touchPosition)
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

function GlyphsInlayView:bagDragEndedCallback(grid, touchPosition, isInBag)
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
        -- 根据拖动的类型来判断如何处理后续逻辑
        self:bagDragToFrameLogic(grid)
        if self.mGoodsDataEquipment then
            self:runPutAnimtion(goodsData, goodsType)
            self._bagGridList:changeBagIndex(19)
        else
            self:runCancelReadyAnimtion(goodsType)
        end
    else 
        self:runCancelReadyAnimtion(goodsType)
    end
end

-- 准备放入动画
function GlyphsInlayView:runReadyAnimtion(goodsData, goodsType)
    if goodsData then
        -- 准备放入动画
        local animationPlay = nil
        if goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            animationPlay = self._kuangAnimationGlyph
        else
            animationPlay = self._kuangAnimationEquipment
        end
        animationPlay:setAnimation("begin", false)
        animationPlay:addAnimation("loop", false)
        animationPlay:setTimeScale(1)

        self._leftBgAnimation:setAnimation("begin", false)
        self._leftBgAnimation:setAnimation("loop", false)
        self._leftBgAnimation:setTimeScale(1)
    else
        -- 准备从装备框拿起动画
        if goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            self._kuangAnimationGlyph:setAnimation("begin", false)
            self._kuangAnimationGlyph:addAnimation("loop", false)
            self._kuangAnimationGlyph:setTimeScale(1)
        elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
            self._kuangAnimationEquipment:setAnimation("begin", false)
            self._kuangAnimationEquipment:addAnimation("loop", false)
            self._kuangAnimationEquipment:setTimeScale(1)
        end
        self._leftBgAnimation:setAnimation("begin", false)
        self._leftBgAnimation:setAnimation("loop", false)
        self._leftBgAnimation:setTimeScale(1)
    end
end

-- 放入动画
function GlyphsInlayView:runPutAnimtion(goodsData, goodsType)
    if goodsData then
        -- 准备从装备框拿起动画
        local animationPlay = nil
        if goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            animationPlay = self._kuangAnimationGlyph
        elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
            animationPlay = self._kuangAnimationEquipment
        end

        animationPlay:setAnimation("end", false)
        animationPlay:setTimeScale(1)
        self._leftBgAnimation:setAnimation("trigger", false)
        self._leftBgAnimation:setTimeScale(1)
    end
end

-- 取消准备放入动画
function GlyphsInlayView:runCancelReadyAnimtion(goodsType)
    local animationPlay = nil
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        animationPlay = self._kuangAnimationGlyph
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        animationPlay = self._kuangAnimationEquipment
    end

    animationPlay:setAnimation("end", false)
    animationPlay:setTimeScale(1)

    self._leftBgAnimation:setAnimation("trigger", false)
    self._leftBgAnimation:setTimeScale(1)
end

function GlyphsInlayView:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_GLYPH
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    return usedTypeList
end

function GlyphsInlayView:refreshAttributesByGoods()
    self.attributeNode:removeAllChildren()
    if self.mGoodsDataGlyph then
        local normalDetailArr = self.mGoodsDataGlyph:getNormalDetailDescription()
        ----------------------------
        -- local normalDetailArr = {}
        -- attrList = {{type = 51, valueType = 1, value = 49},
        --         {type = 52, valueType = 1, value = 3},
        --         {type = 53, valueType = 1, value = 37},
        --         {type = 54, valueType = 1, value = 83},
        --         }
        -- local desArr = {}
        -- for k, data in pairs(attrList) do 
        --     local oneAttr = {}
        --     table.insert(oneAttr, ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[data.type]))
        --     if(data.valueType == PublicDefine.VALUE_TYPE.Value) then 
        --         local endStr, valueType = ToolsUtil:calculationAttrShowValue(data.type, data.value)
        --         table.insert(oneAttr,string.format("%s", endStr))
        --     else 
        --         table.insert(oneAttr,string.format("%.2f%%",data.value / 100))
        --     end
        --     table.insert(oneAttr, data.type)
        --     table.insert(desArr, oneAttr)
        -- end
        -- normalDetailArr = desArr
        ----------------------------
        local totalHeight = 0
        local leftOffset = 0
        local oneHeight = 20
        local k = 0

        local centerOffsetUp = 13.5
        local pointOffsetY = - 1


        local pInfoArea = UI.GlyphInfoArea:create()
        if normalDetailArr then 
            for i,data in ipairs(normalDetailArr) do
                local attributeConfig = ConfigManager:getGlyphAttributeByID(tonumber(data[3]))
                local levelColor = pInfoArea:getAttributeColor(attributeConfig, tonumber(data[2]), self.mGoodsDataGlyph)

                local point = UI.Image:create()
                point:init("ui_glyphs_tabulation_1.png")
                point:leftUp(leftOffset, 20 + i * 40)
                self.attributeNode:addChild(point)
                
                -- UI.FONT_COLOR_41_41_45
                local baseText = UI.Text:create()
                baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, levelColor)
                baseText:setTextLeft()
                baseText:leftUp(leftOffset + 10, 24 + i * 40)
                self.attributeNode:addChild(baseText)
                if(baseText:getContentSize().width > 180) then 
                    baseText:setWidth(180)
                    baseText:setText(string.format("%s",data[1]))
                end

                local baseValue = UI.Text:create()
                local heroData = RoleDataManager:getMaster()
                local attributeValueMax = pInfoArea:getAttributeMaxValue(attributeConfig, self.mGoodsDataGlyph)
                baseValue:init(string.format("%s",data[2]).." ("..attributeValueMax..")", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, levelColor)
                baseValue:leftUp(leftOffset + baseText._width + 20, 24 + i * 40)
                self.attributeNode:addChild(baseValue)
            end
        end
    else
        --self.status = REFINED_STATUS.REFINED_NONE
    end

    self:updateBagName()
end

function GlyphsInlayView:bagDragToFrameLogic(grid)
    local goodsData = grid:getData()
    local goodsType = goodsData:getGoodsType()
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        -- 在雕纹框中,并且装备栏必须有装备才行
        if self.mGoodsDataEquipment then
            local messageData = {}
            messageData.glyphuid = goodsData:getEntityID()
            messageData.equipuid = self.mGoodsDataEquipment:getEntityID()
            messageData.packetType = self.mGoodsDataEquipment:getBagType()
            Net.NetNPCSystem:sendGlyphEquip(messageData)
            self:refreshAllLayer()
        else
            UI.ScrollBar:createByTextID(UI.TEXT_227007)
        end
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        -- 在装备框中 
        isSuccess = self:chosePutInBox(true, goodsData)
    else
        self._bagGridList:refreshView()
    end
end

function GlyphsInlayView:chosePutInBox(isEquipment, goodsData)
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
        self:refreshAllLayer()
    end

    if not isSuccess then
        self._bagGridList:refreshView()
    end

    return isSuccess
end

function GlyphsInlayView:refreshAllLayer(data)
    -- body
    if self.mGoodsDataEquipment then
        -- 首先获取装备上是否有镶嵌的雕文
        local glyphsDatas = self.mGoodsDataEquipment:getGlyphDatas()

        if #glyphsDatas > 0 and glyphsDatas then
            self.mGoodsDataGlyph = glyphsDatas[1]:getGlyphData()
            self.mGoodsDataGlyph._changeNum = -1
            self.mGoodsGridGlyph:setData(self.mGoodsDataGlyph)
            self.mGoodsGridGlyph:updateView()
            self.mGoodsGridGlyph:hideCountLabel()
            self.mGoodsGridGlyph:hideNewIcon()
            self.mGoodsGridGlyph:hideBG()
            self.mGoodsGridGlyph:show()
        else
            self:removeGlyphBox()
        end

        if data then
            if data.isEquip then
                self._kuangAnimationGlyph:setAnimation("trigger",false)
                self._kuangAnimationEquipment:setAnimation("trigger",false)
            end
        end
    end
    self:refreshAttributesByGoods()
end

function GlyphsInlayView:removeGlyphBox()
    -- 移除雕纹框
    if self.mGoodsDataGlyph ~= nil then
        self.mGoodsDataGlyph._changeNum = 0
    end
    self.mGoodsDataGlyph = nil
    self._bagGridList:refreshView()
    self.mGoodsGridGlyph:setVisible(false)
end

function GlyphsInlayView:updateBagName()
    if self.mGoodsDataGlyph and self.mGoodsDataEquipment then
        self._operateText:setText(UI.TEXT_227009)
    elseif not self.mGoodsDataEquipment then
        self._operateText:setText(UI.TEXT_227010)
    elseif not self.mGoodsDataGlyph then
        self._operateText:setText(UI.TEXT_227002)
    end
end


------------------------------------------
function GlyphsInlayView:onTouchBeganByGoodsGridEquipment(grid,touchPosition)
    local goodsData = grid:getData()

    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()

    self:runReadyAnimtion(nil, goodsType)

    return true
end

function GlyphsInlayView:onTouchEndedByGoodsGridEquipment(grid, inSide)
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
        self.mGoodsDataEquipment = nil
        self._bagGridList:refreshView()

        --self.mGoodsGridEquipment:setData(nil)
        self.mGoodsGridEquipment:updateView()
        self.mGoodsGridEquipment:hide()
        -- 移除雕纹框信息一定要放在刷新之前！！
        self:removeGlyphBox()
        self:refreshAllLayer()
        self:runCancelReadyAnimtion(goodsType)
    else
        --self:runCancelReadyAnimtion(goodsType)
    end
end
------------------------------------------
function GlyphsInlayView:onTouchBeganByGoodsGridGlyph(grid,touchPosition)
    local goodsData = grid:getData()

    if(goodsData == nil) then 
        return 
    end
    local goodsType = goodsData:getGoodsType()

    self:runReadyAnimtion(nil, goodsType)

    return true
end

function GlyphsInlayView:onTouchEndedByGoodsGridGlyph(grid, inSide)
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
        -- 发送取消镶嵌消息
        if self.mGoodsDataEquipment then
            local messageData = {}
            messageData.equipuid = self.mGoodsDataEquipment:getEntityID()
            messageData.packetType = self.mGoodsDataEquipment:getBagType()
            Net.NetNPCSystem:sendGlyphUnEquip(messageData)
        end
        self:runCancelReadyAnimtion(goodsType)

        ---------------------------
        self:removeGlyphBox()
    else
        --self:runCancelReadyAnimtion(goodsType)
    end
end
------------------------------------------

-- function GlyphsInlayView:isBagMax()

--     return false
-- end

function GlyphsInlayView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GLYPH_EQUIP_REFRESH,self, self.refreshAllLayer)
end


function GlyphsInlayView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GLYPH_EQUIP_REFRESH,self, self.refreshAllLayer)
end





return GlyphsInlayView













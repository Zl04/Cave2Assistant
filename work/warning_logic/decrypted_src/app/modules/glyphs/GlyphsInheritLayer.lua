------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/20
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GlyphsInheritLayer = class("GlyphsInheritLayer", UI.HWBtnComponent)
local GlyphsPacketLayer = require "app.modules.glyphs.GlyphsPacketLayer"

-- 资源
local COM_RES_LIST = {

}

local COM_WIDTH = 920
local COM_HEIGHT = 580

local RIGHT_COM_W = 440
local RIGHT_COM_H = 430

local CELL_WIDTH = 240
local CELL_HEIGHT = 40

function GlyphsInheritLayer:ctor()
    GlyphsInheritLayer.super.ctor(
    	self,
    	UI.Type.GLYPHS_INHERIT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.mGoodsData = nil
    self.mConsumeGoodsData = nil
    self.selcetedConsumeAttrType = nil
    self.lockedAttrType = nil
    self.isConsumeListClick = false

    self.lockBtnList = {}

    self:bindModel()
end

function GlyphsInheritLayer:init( ... )
    GlyphsInheritLayer.super.init(self, ... )
end

function GlyphsInheritLayer:dtor()
    GlyphsInheritLayer.super.dtor(self)

    self.mGoodsData = nil
    self.mConsumeGoodsData = nil
    self.selcetedConsumeAttrType = nil
    self.lockedAttrType = nil
    self.isConsumeListClick = false

    self.lockBtnList = nil
    self:unbindModel()

    reload_script_file_mvc("app.modules.glyphs.GlyphsInheritLayer")
end

function GlyphsInheritLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:initLeftLayer()
    self:addGlyphsPacketView()
end

function GlyphsInheritLayer:initLeftLayer()
    -- 内容面板
    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(RIGHT_COM_W, RIGHT_COM_H)
    leftLayout:centerLeft(30)
    self.contentLayout:addChild(leftLayout)
    self.leftLayout = leftLayout

    local optDesBg = UI.Image.create()
    optDesBg:init("ui_glyphs_title.png")
    optDesBg:centerUp(-5)
    leftLayout:addChild(optDesBg, 99)

    local optDes = UI.Text:create()
    optDes:init(UI.TEXT_227061, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_214_251_255)
    optDes:center()
    optDesBg:addChild(optDes)
    self.optDes = optDes

    local leftEffect = UI.Animation:create()
    leftEffect:init("effect_ui_town_xiangqian_shengji_di.json", "effect_ui_town_xiangqian_shengji_di.atlas", 1);
    leftEffect:centerUp(85)
    leftLayout:addChild(leftEffect)
    -- leftEffect:setAnimation("idle", true)
    self.leftEffect = leftEffect

    local frameAnim = UI.Animation:create()
    frameAnim:init("effect_ui_town_xiangqian_shengji_kuang.json", "effect_ui_town_xiangqian_shengji_kuang.atlas", 1);
    frameAnim:center(0, 0)
    leftEffect:addChild(frameAnim)
    -- frameAnim:setAnimation("idle", true)
    self.frameAnim = frameAnim


    local consumeFrameAnim = UI.Animation:create()
    consumeFrameAnim:init("effect_ui_town_xiangqian_shengji_kuang.json", "effect_ui_town_xiangqian_shengji_kuang.atlas", 1);
    consumeFrameAnim:centerBottom(130)
    leftLayout:addChild(consumeFrameAnim)
    -- consumeFrameAnim:setAnimation("idle", true)
    self.consumeFrameAnim = consumeFrameAnim

    local mGridLayout = UI.Layout:create()
    mGridLayout:init()
    mGridLayout:setSize(66, 66)
    mGridLayout:center(0, 2)
    leftEffect:addChild(mGridLayout)
    self.mGridLayout = mGridLayout

    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:center()
    self.mGoodsGrid:hide()
    self.mGoodsGrid:showInfoArea()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setDragOutAreaJudgeNode(mGridLayout)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    mGridLayout:addChild(self.mGoodsGrid, 100)


    local consumeGridLayout = UI.Layout:create()
    consumeGridLayout:init()
    consumeGridLayout:setSize(66, 66)
    consumeGridLayout:center(0, 2)
    consumeFrameAnim:addChild(consumeGridLayout)
    self.consumeGridLayout = consumeGridLayout

    self.consumeGoodsGrid = UI.GoodsGrid:create()
    self.consumeGoodsGrid:init()
    self.consumeGoodsGrid:center()
    self.consumeGoodsGrid:hide()
    self.consumeGoodsGrid:showInfoArea()
    self.consumeGoodsGrid:hideCountLabel()
    self.consumeGoodsGrid:hideNewIcon()
    self.consumeGoodsGrid:setDragOutAreaJudgeNode(consumeGridLayout)
    self.consumeGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByConsumeGoodsGrid))
    self.consumeGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByConsumeGoodsGrid))
    consumeGridLayout:addChild(self.consumeGoodsGrid, 100)

    local inheritBtn = UI.Button:create()
    inheritBtn:init('ui_glyphs_btn_2.png', 'ui_glyphs_btn_2.png', 'ui_glyphs_btn_2_2.png')
    inheritBtn:centerBottom(15)
    -- inheritBtn:closeClickScale()
    inheritBtn:setText(UI.TEXT_227052)
    inheritBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    inheritBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:onInherit()
    end)
    inheritBtn:setName("inheritBtn")
    leftLayout:addChild(inheritBtn)
    self.inheritBtn = inheritBtn
    inheritBtn:disable()

    local costLayout = UI.Layout:create()
    costLayout:init()
    costLayout:setSize(80, 20)
    costLayout:centerBottom(-7)
    leftLayout:addChild(costLayout)
    self.costLayout = costLayout
    -- costLayout:enableDebugDraw()
    costLayout:hide()

    local costIcon = UI.Image.create()
    costIcon:init("symbol_gaming_diamond.png")
    costIcon:centerLeft(10)
    costLayout:addChild(costIcon, 99)

    local costList = string.split(ConfigManager:getGeneralForKey("glyphLockConsume"), ",") 
    local costNum = UI.Text:create()
    costNum:init(costList[2], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    costNum:centerLeft(35)
    costLayout:addChild(costNum)

    -- self:showGlyphAttrView()
end

function GlyphsInheritLayer:addGlyphsPacketView()
    local hideTypeList = {
        UI.BagGoodsPanel.BAG_TYPE.ALL,
        UI.BagGoodsPanel.BAG_TYPE.ITEM,
        UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
        UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
        UI.BagGoodsPanel.BAG_TYPE.RELIC,
        UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
        UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
    }
    local glyphsPacketLayer = GlyphsPacketLayer:create(hideTypeList)
    glyphsPacketLayer:init()
    glyphsPacketLayer:centerRight(0)
    self.contentLayout:addChild(glyphsPacketLayer, 99)
    glyphsPacketLayer:getBagList():changeBagDefaultIndex(19)

    local bagList = glyphsPacketLayer:getBagList()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
end

function GlyphsInheritLayer:showGlyphAttrView()
    if self.glyphAttrListLayout then
        self.glyphAttrListLayout:removeFromParent(true)
        self.glyphAttrListLayout = nil
    end
    self.lockBtnList = {}
    self.lockedAttrType = nil
    self.costLayout:hide()

    local glyphAttrListLayout = UI.Layout:create()
    glyphAttrListLayout:init()
    glyphAttrListLayout:setSize(300, 130)
    glyphAttrListLayout:centerUp(135)
    self.leftLayout:addChild(glyphAttrListLayout)
    self.glyphAttrListLayout = glyphAttrListLayout
    self:createAttrListView()

    self:updateOptDes()
end

function GlyphsInheritLayer:createAttrListView()
    if not self.mGoodsData then
        return 
    end
    self.inheritAttrTableView = UI.TableView.new({}, CELL_WIDTH+30, 165, false)
    self.inheritAttrTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.inheritAttrTableView:center()
    self.inheritAttrTableView:setDelegate()
    self.inheritAttrTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.inheritAttrTableView:setBounceable(false)
    self.inheritAttrTableView:init()
    self.inheritAttrTableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH+10, CELL_HEIGHT
    end)

    self.inheritAttrTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createAttrCell(index,self.mGoodsData:getNormalDetailDescription())
            end,
            function(e)
                printError("------------------------GlyphsInheritLayer:createAttrListView-----------------error")
            end, 1)
        else
            local image = cell:getChildByName("image")
            if image and tolua.isnull(image) then
                image:removeFromParent()
                image = nil
            end
            cell = self:createAttrCell(index, self.mGoodsData:getNormalDetailDescription())
        end

        return cell
    end)

    self.inheritAttrTableView:onUpdateCellNumbers(function ()
        return table.nums(self.mGoodsData:getNormalDetailDescription())
    end)

    self.glyphAttrListLayout:addChild(self.inheritAttrTableView, 100)
    self.inheritAttrTableView:reloadData(true)
    
end

function GlyphsInheritLayer:createAttrCell(index, attrDes, isConsume)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH+10, CELL_HEIGHT))

    local data = attrDes[index]
    
    local image = UI.Image.create()
    image:init("ui_glyphs_tabulation_1.png")
    image:center()
    image:setName("image")
    cell:addChild(image)

    local title = UI.Text:create()
    title:init(string.format("%s", data[1]..data[2]), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    title:center()
    image:addChild(title)

    local lockBtn = UI.Button:create()
    lockBtn:init('ui_glyphs_btn_lock_1.png', 'ui_glyphs_btn_lock_2.png', 'ui_glyphs_btn_lock_1.png')
    lockBtn:centerRight(-25)
    lockBtn:closeClickScale()
    lockBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:onLockClicked(data, index)
    end)
    lockBtn:setName("lockBtn")
    lockBtn:setVisible(not isConsume)
    image:addChild(lockBtn)

    self.lockBtnList[index] = lockBtn

    if isConsume then
        image:setTouchEnable(true)
        image:setSwallowTouches(true)
        image:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)

            -- 下拉框
            if self.isConsumeListClick then
                -- self.btnImage:setSpriteName("ui_btn_spread_1.png")
                self.isConsumeListClick = false
                -- self:closeConsumeAttrListView()
            else
                -- self.btnImage:setSpriteName("ui_btn_spread_0.png")
                self.isConsumeListClick = true
                self:updateConsumDetail(data)
            end
    
        end)
    end

    return cell
end

function GlyphsInheritLayer:showConsumeGlyphAttrView(data)
    if self.consumeGlyphAttrListLayout then
        self.consumeGlyphAttrListLayout:removeFromParent(true)
        self.consumeGlyphAttrListLayout = nil
    end

    local consumeGlyphAttrListLayout = UI.Layout:create()
    consumeGlyphAttrListLayout:init()
    consumeGlyphAttrListLayout:setSize(300, 90)
    consumeGlyphAttrListLayout:centerBottom(0)
    self.leftLayout:addChild(consumeGlyphAttrListLayout)
    self.consumeGlyphAttrListLayout = consumeGlyphAttrListLayout
    -- consumeGlyphAttrListLayout:enableDebugDraw()
    
    local attrDetailList = data:getNormalDetailDescription()
    local showData = attrDetailList[1]
    
    local image = UI.Image.create()
    image:init("ui_glyphs_tabulation_1.png")
    image:centerUp(0)
    image:setName("image")
    consumeGlyphAttrListLayout:addChild(image)
    -- self.selectConsumImage = image

    local consumeListBtn = UI.Button:create()
    consumeListBtn:init('ui_glyphs_btn_arrow.png', 'ui_glyphs_btn_arrow.png', 'ui_glyphs_btn_arrow.png')
    consumeListBtn:centerRight(-32)
    consumeListBtn:closeClickScale()
    consumeListBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:createConsumeAttrListView(attrDetailList)
    end)
    consumeListBtn:setName("consumeListBtn")
    -- consumeListBtn:setVisible(isConsume)
    image:addChild(consumeListBtn)

    local selectConsumDetail = UI.Text:create()
    selectConsumDetail:init(string.format("%s", showData[1]..showData[2]), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    selectConsumDetail:center()
    image:addChild(selectConsumDetail)
    self.selectConsumDetail = selectConsumDetail
    self.selcetedConsumeAttrType = showData[3]

    self:updateOptDes()
end

function GlyphsInheritLayer:createConsumeAttrListView(data)
    if not data then
        return 
    end
    if self.consumeAttrTableView then
        self.consumeAttrTableView:removeFromParent()
        self.consumeAttrTableView = nil
        return 
    end

    self.consumeAttrTableView = UI.TableView.new({}, CELL_WIDTH, 150, false)
    self.consumeAttrTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.consumeAttrTableView:center(0, 65)
    -- self.consumeAttrTableView:enableDebugDraw()
    self.consumeAttrTableView:setDelegate()
    self.consumeAttrTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.consumeAttrTableView:setBounceable(false)
    self.consumeAttrTableView:init()
    self.consumeAttrTableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT
    end)

    self.consumeAttrTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createAttrCell(index,data, true)
            end,
            function(e)
                printError("------------------------GlyphsInheritLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            local image = cell:getChildByName("image")
            if image and tolua.isnull(image) then
                image:removeFromParent()
                image = nil
            end
            cell = self:createAttrCell(index, data, true)
        end

        return cell
    end)

    self.consumeAttrTableView:onUpdateCellNumbers(function ()
        return table.nums(data)
    end)

    self.consumeGlyphAttrListLayout:addChild(self.consumeAttrTableView, 100)
    self.consumeAttrTableView:reloadData(true)
end

function GlyphsInheritLayer:closeInheritAttrListView()
    if self.inheritAttrTableView then
        self.inheritAttrTableView:removeFromParent(true)
        self.inheritAttrTableView = nil
    end
    self.costLayout:hide()
end

function GlyphsInheritLayer:closeConsumeAttrListView(isRomve)
    if self.consumeAttrTableView then
        self.consumeAttrTableView:removeFromParent(true)
        self.consumeAttrTableView = nil
    end

    if isRomve then
        if self.consumeGlyphAttrListLayout then
            self.consumeGlyphAttrListLayout:removeFromParent(true)
            self.consumeGlyphAttrListLayout = nil
        end
    end
    
end

function GlyphsInheritLayer:updateConsumDetail(selectedData)
    self.selectConsumDetail:setText(string.format("%s", selectedData[1]..selectedData[2]))
    self.selcetedConsumeAttrType = selectedData[3]
    self:closeConsumeAttrListView()
end

function GlyphsInheritLayer:bagDragBeganCallback(grid, touchPosition)
    if(grid) then
        grid:hideSelect()
    end

    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end
    -- 根据拖动的类型来判断如何处理后续逻辑
    self:playDragAnime()
end

function GlyphsInheritLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    local goodsData = grid:getData()
    if(goodsData == nil) then 
        return 
    end

    if not isInBag then
        -- 根据拖动的类型来判断如何处理后续逻辑
        local pos = self.mGridLayout:convertToNodeSpace(touchPosition)
        local size = self.mGridLayout:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        if cc.rectContainsPoint(rect, pos) then
            if goodsData:getGoodsRare() <= 2 then
                UI.ScrollBar:createByText(UI.TEXT_227064)
                return
            end

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

            self:showGlyphAttrView()
        end

        local pos = self.consumeGridLayout:convertToNodeSpace(touchPosition)
        local size = self.consumeGridLayout:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        if cc.rectContainsPoint(rect, pos) then
            if not self.mGoodsData then
                UI.ScrollBar:createByText(UI.TEXT_227065)
                return
            end

            if self.mGoodsData:getGoodsRare() - goodsData:getGoodsRare() >= 2 then
                UI.ScrollBar:createByText(string.format(UI.TEXT_227066, self.mGoodsData:getGoodsRare(), self.mGoodsData:getGoodsRare()-1, self.mGoodsData:getGoodsRare()))
                return 
            end

            local inheritGlyphAttr = self.mGoodsData:getNormalDetailDescription()
            local consumeGlyphAttr = goodsData:getNormalDetailDescription()

            if self:checkGlyphAttrIsDuplicate(inheritGlyphAttr, consumeGlyphAttr) then
                UI.ScrollBar:createByText(UI.TEXT_227067)
                return 
            end

            if self.mConsumeGoodsData ~= nil then
                self.mConsumeGoodsData._changeNum = 0
            end

            goodsData._changeNum = -1
            self.mConsumeGoodsData = goodsData
            -- self._bagGridList:setUsedType(self:getChoiceGemStone())
            self._bagGridList:refreshView()

            self.consumeGoodsGrid:setData(goodsData)
            self.consumeGoodsGrid:setVisible(true)
            self.consumeGoodsGrid:show()
            self.consumeGoodsGrid:hideCountLabel()
            self.consumeGoodsGrid:hideNewIcon()
            self.consumeGoodsGrid:hideBG()
            self.consumeGoodsGrid:updateView()

            self:showConsumeGlyphAttrView(goodsData)
        end

        

        -- 切换背包的tab
        --self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)

        -- self:refreshAttributesByGoods()
        -- self:runPutAnimtion()
    else 
        -- self:runCancelReadyAnimtion()
    end
    self:playDragEndAnime()
    self:updateBtnState()
end

function GlyphsInheritLayer:onTouchBeganByGoodsGrid(grid,touchPosition)
    local goodsData = grid:getData()

    self:playDragAnime(grid)

    return true
end

function GlyphsInheritLayer:onTouchEndedByGoodsGrid(grid, inSide)
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
        -- self:runCancelReadyAnimtion();

        self._bagGridList:refreshView()
        -- self:cancelDevour()
        -- self:refreshAttributesByGoods()
        self:closeInheritAttrListView()
    else
        -- self:runPutAnimtion()
    end

    self:updateOptDes()
    self:updateBtnState()
end

function GlyphsInheritLayer:onTouchBeganByConsumeGoodsGrid(grid,touchPosition)
    local goodsData = grid:getData()

    self:playDragAnime(grid)

    return true
end

function GlyphsInheritLayer:onTouchEndedByConsumeGoodsGrid(grid, inSide, isNotDrag)
    if(self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    -- local goodsData = grid:getData()
    if not inSide then
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()        
        self.mConsumeGoodsData._changeNum = 0
        self._bagGridList:setUsedType(self:getInitUseType())
        self._bagGridList:refreshView()
        --self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.PET_STONE)
        self.mConsumeGoodsData = nil
        self.consumeGoodsGrid:center()
        self.consumeGoodsGrid:setVisible(false)
        -- self:runCancelReadyAnimtion();

        self._bagGridList:refreshView()
        -- self:cancelDevour()
        -- self:refreshAttributesByGoods()
        self:closeConsumeAttrListView(true)
        self.selcetedConsumeAttrType = nil
    else
        -- self:runPutAnimtion()
    end

    self:updateOptDes()
    self:updateBtnState()
end

function GlyphsInheritLayer:updateOptDes()
    if not self.mGoodsData then
        self.optDes:setText(UI.TEXT_227061)
    elseif not self.selcetedConsumeAttrType then
        self.optDes:setText(UI.TEXT_227062)
    else
        self.optDes:setText(UI.TEXT_227063)
    end
end

function GlyphsInheritLayer:getInitUseType()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_GLYPH
    _usedType1.type = 0  --"all"
    table.insert(usedTypeList,_usedType1)

    return usedTypeList
end

function GlyphsInheritLayer:updateBtnState()
    if not self.mGoodsData or 
    not self.selcetedConsumeAttrType then
        self.inheritBtn:disable() 
    else
        -- local totalLevel = self.dustUseLevel + self.fragmentUseLevel + self.crystalUseLevel
        -- if totalLevel ~= 10 then
        --     self.inheritBtn:disable() 
        --     UI.ScrollBar:createByText(UI.TEXT_227058)
        --     return 
        -- end

        self.inheritBtn:enable() 
    end

end

function GlyphsInheritLayer:onLockClicked(data, index)
    if self.lockedAttrType then
        for k, v in pairs(self.lockBtnList) do
            if k ~= index then
                v:setVisible(true)
            else
                v:setBtnStatus(1)
                v:setChoiced(false)
            end
        end
        self.lockedAttrType = nil
        self.costLayout:hide()
    else
        for k, v in pairs(self.lockBtnList) do
            if k == index then
                v:setBtnStatus(2)
                v:setChoiced(true)
            else
                v:setVisible(false)
            end
            
        end
        self.costLayout:show()
        self.lockedAttrType = data[3]
    end
end

function GlyphsInheritLayer:playDragAnime()
    self.leftEffect:setAnimation("trigger", false)
end

function GlyphsInheritLayer:playDragEndAnime()
    self.leftEffect:setToSetupPose()
end

function GlyphsInheritLayer:checkGlyphAttrIsDuplicate(inheritGlyphAttr, consumeGlyphAttr)
    local notDuplicate = true
    for k, v in pairs(inheritGlyphAttr) do
        for i, j in pairs(consumeGlyphAttr) do
            if v[3] ~= j[3] then
                notDuplicate = false
                break
            end
        end
    end
    return notDuplicate
end

function GlyphsInheritLayer:onInherit()
    local mainGlyphuid = self.mGoodsData:getEntityID()
    local materialGlyphuid = self.consumeGoodsGrid:getData():getEntityID()
    local lockAttrType = self.lockedAttrType or 0
    local chooseAttrType = self.selcetedConsumeAttrType 

    Net.NetNPCSystem:reqInheritGlyphs(mainGlyphuid, materialGlyphuid, lockAttrType, chooseAttrType)
end

function GlyphsInheritLayer:onInheritSucceed()
    
    self:onTouchEndedByConsumeGoodsGrid(nil, false, true)

    self:showGlyphAttrView()
end

function GlyphsInheritLayer:close()
    GlyphsInheritLayer.super.close(self)
end

function GlyphsInheritLayer:bindModel()

end

function GlyphsInheritLayer:unbindModel()

end


return GlyphsInheritLayer













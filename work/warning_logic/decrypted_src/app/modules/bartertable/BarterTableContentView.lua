------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BarterTableContentView = class("BarterTableContentView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_distortedSpace.plist",
}

local COM_WIDTH = 392
local COM_HEIGHT = 595

function BarterTableContentView:ctor()
    BarterTableContentView.super.ctor(
    	self,
    	UI.Type.BARTER_TABLE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.barterEquipList = {}
    self.selectEquip = nil
    self.selectEquipLayout = nil
    self:bindModel()
end

function BarterTableContentView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bartertable", "BarterTable", false)
    BarterTableContentView.super.init(self, ... )
end

function BarterTableContentView:dtor()
    BarterTableContentView.super.dtor(self)
    self.barterEquipList = {}
    self.selectEquip = nil
    self.selectEquipLayout = nil
    self:unbindModel()
    reload_script_file_mvc("app.modules.bartertable.BarterTableContentView")
end


function BarterTableContentView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(387, 607)
    contentLayout:center()
    self:addChild(contentLayout)
    -- contentLayout:enableDebugDraw()
    self._contentLayout = contentLayout

    -- local bg = UI.Image:create()
    -- bg:init("ui_distortedspace_bg2.png")
    -- bg:center()
    -- contentLayout:addChild(bg)

    local barterBgAnim = UI.Animation:create()
    barterBgAnim:init("effect_ui_town_barter.json", "effect_ui_town_barter.atlas", 1)
    barterBgAnim:center(0, 300)
    contentLayout:addChild(barterBgAnim)
    barterBgAnim:setAnimation("idle1", true)
    self.barterBgAnim = barterBgAnim
    self.barterBgAnim:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "show_icons" then
                -- todo
                self:updateBarterEquip()
            end
        end
    end)

    self.barterBgAnim:addEventListener(UIEvent.ANIMATION_END,self,function(this, event)
        local startPos = string.find(event.animation, "slot")
        if (startPos ~= nil) then
            self:resetBarterEquip()
        end
    end)

    local tableLayout = UI.Layout:create()
    tableLayout:init()
    tableLayout:setSize(387, 607)
    tableLayout:center()
    contentLayout:addChild(tableLayout)
    self.tableLayout = tableLayout

    local titleStr = UI.Text:create()
    titleStr:init(UI.TEXT_222102, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    titleStr:centerUp(155)
    tableLayout:addChild(titleStr)
    self.titleStr = titleStr

    self.iconAnimation = UI.Animation:create()
    self.iconAnimation:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1)
    contentLayout:addChild(self.iconAnimation, 102)
    self.iconAnimation:centerUp(275)

    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:centerUp(240)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:showInfoArea()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setDragOutAreaJudgeNode(contentLayout)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    contentLayout:addChild(self.mGoodsGrid, 100)

    self.equipGrid1 = UI.GoodsGrid:create()
    self.equipGrid1:init()
    -- self.equipGrid1:center(-100, -30)
    self.equipGrid1:center()
    self.equipGrid1:hide()
    -- self.equipGrid1:showInfoArea()
    self.equipGrid1:hideCountLabel()
    self.equipGrid1:hideNewIcon()
    
    local gridLayout1 = UI.Layout:create()
    gridLayout1:init()
    gridLayout1:setSize(70, 70)
    gridLayout1:center(-100, -30)
    contentLayout:addChild(gridLayout1)
    -- gridLayout1:enableDebugDraw()
    self.gridLayout1 = gridLayout1
    gridLayout1:addChild(self.equipGrid1, 100)
    gridLayout1.grid = self.equipGrid1
    gridLayout1:setTouchEnable(true)
    gridLayout1.index = 1
    table.insert(self.barterEquipList, gridLayout1)

    self.equipGrid2 = UI.GoodsGrid:create()
    self.equipGrid2:init()
    self.equipGrid2:center()
    self.equipGrid2:hide()
    -- self.equipGrid2:showInfoArea()
    self.equipGrid2:hideCountLabel()
    self.equipGrid2:hideNewIcon()
    
    local gridLayout2 = UI.Layout:create()
    gridLayout2:init()
    gridLayout2:setSize(70, 70)
    gridLayout2:center(100, -30)
    contentLayout:addChild(gridLayout2)
    -- gridLayout2:enableDebugDraw()
    self.gridLayout2 = gridLayout2
    gridLayout2:addChild(self.equipGrid2, 100)
    gridLayout2.grid = self.equipGrid2
    gridLayout2:setTouchEnable(true)
    gridLayout2.index = 2
    table.insert(self.barterEquipList, gridLayout2)

    self.equipGrid3 = UI.GoodsGrid:create()
    self.equipGrid3:init()
    self.equipGrid3:center()
    self.equipGrid3:hide()
    self.equipGrid3:hideCountLabel()
    self.equipGrid3:hideNewIcon()
    
    local gridLayout3 = UI.Layout:create()
    gridLayout3:init()
    gridLayout3:setSize(70, 70)
    gridLayout3:centerUp(333)
    contentLayout:addChild(gridLayout3)
    -- gridLayout3:enableDebugDraw()
    self.gridLayout3 = gridLayout3
    gridLayout3:addChild(self.equipGrid3)
    gridLayout3.grid = self.equipGrid3
    gridLayout3:setTouchEnable(true)
    gridLayout3.index = 3
    table.insert(self.barterEquipList, gridLayout3)

    -- 下面的操作区域
    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_stone1_0.png", "ui_btn_stone1_1.png", "ui_btn_stone1_2.png")
    executeButton:centerBottom(20)
    contentLayout:addChild(executeButton, 10)
    executeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_220_182_80)
    executeButton:setText(UI.TEXT_222130)
    AvalonUtil.addBracketsAnimationToButton(executeButton)
    executeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onExchange)
    executeButton:disable()
    self.executeButton = executeButton
    
end

function BarterTableContentView:getTargetGridData()
    return self.mGoodsGrid:getData()
end

function BarterTableContentView:onTouchBeganByGoodsGrid(grid)
    -- local isMaterial = grid.tag == "material"
    -- mvc.send(mvc.events.Recast_Grid_Drag_Began, isMaterial, grid)
end

function BarterTableContentView:onTouchEndedByGoodsGrid(grid, isInSide, touchPosition)
    if not self:checkTouchPosition(touchPosition) then
        mvc.send(mvc.events.Barter_Grid_Drag_Out, grid)
    end
end

function BarterTableContentView:setTargetGridData(goodsData)
    if not goodsData then
        self.mGoodsGrid:reset()
        self.mGoodsGrid:hide()
    else
        self.mGoodsGrid:setData(goodsData)
        self.mGoodsGrid:show()
    end
    self.mGoodsGrid:updateView()
end

function BarterTableContentView:updateGridAnimation(tag)
    if tag == "ToTarget" then
        self.iconAnimation:setAnimation("ready1", false)
        self.iconAnimation:addAnimation("ready2", true)
    elseif tag == "ToTargetEnd" then
        self.iconAnimation:setAnimation("put1", false)
        self.iconAnimation:addAnimation("put2", true)
        self.barterBgAnim:setAnimation("activate", false)
    elseif tag == "ToTargetCancel" then
        self.iconAnimation:setAnimation("ready3", false)
        self.barterBgAnim:setAnimation("idle1", true)
        self:resetBarterEquip()
    elseif tag == "MoveOutTargetEnd" then
        self.iconAnimation:setAnimation("ready3", false)
    end
end

function BarterTableContentView:updateBarterEquip()
    local goodsID = self.mGoodsGrid:getData().goodsID
    local barterEquipConfig = ConfigManager:getAllBarterDataByID(goodsID)
    local barterEquipConfList = string.split(barterEquipConfig.barterEquip, ",")
    for k, v in pairs(self.barterEquipList) do
        local equipData = GoodsDataManager:createEquipmentForEquipmentID(tonumber(barterEquipConfList[k]))
        v.grid:setData(equipData)
        v.grid:show()
        v.grid:updateView()
        v:addEventListener(UIEvent.COMPONENT_CLICK, v, function()
            self:onGridClicked(v)
        end)
    end
    self.barterBgAnim:addAnimation("idle2", true)
end

function BarterTableContentView:resetBarterEquip()
    self.selectEquip = nil
    self.selectEquipLayout = nil
    self.executeButton:disable()
    self.barterBgAnim:setAnimation("idle1", true)
    self.mGoodsGrid:reset()
    self.mGoodsGrid:hide()
    self.iconAnimation:setAnimation("ready3", false)
    for k, v in pairs(self.barterEquipList) do
        v.grid:reset()
        v.grid:hide()
        v.grid:hideSelect()
        v:removeEventListenerByName(UIEvent.COMPONENT_CLICK)
    end
end

function BarterTableContentView:onGridClicked(gridLayout)
    if self.selectEquip then
        self.selectEquip:hideSelect()
        self.selectEquipLayout = nil
        self.selectEquip = nil
    end

    gridLayout.grid:onShowInfoAreaHandler()
    gridLayout.grid:showSelect()
    self.selectEquipLayout = gridLayout
    self.selectEquip = gridLayout.grid
    self.executeButton:enable()
end

function BarterTableContentView:onExchange()
    if self.selectEquip then
        local materialID = self.mGoodsGrid:getData().goodsID
        local equipID = self.selectEquip:getData().goodsID
        local npcID = mvc.barterTableModel:getNpcId()
        GameManager:trigerBarterFunction(materialID, equipID, npcID)
    end
end

function BarterTableContentView:onExchangeSuccess()
    if self.selectEquipLayout then
        if self.selectEquipLayout.index == 1 then
            self.barterBgAnim:setAnimation("slot-set1", false)
        elseif self.selectEquipLayout.index == 2 then
            self.barterBgAnim:setAnimation("slot-set2", false)
        elseif self.selectEquipLayout.index == 3 then
            self.barterBgAnim:setAnimation("slot-set3", false)
        end
    end
    
    UI.ScrollBar:createByText(UI.TEXT_222131)
end

function BarterTableContentView:bindModel()

end


function BarterTableContentView:unbindModel()

end





return BarterTableContentView













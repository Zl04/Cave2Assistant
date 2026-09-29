------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/25
--desc	: 
------------------------------------------------------------------------------
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BarterTableBagContentView = class("BarterTableBagContentView", UI.HWBtnComponent)
require "app.ui.shoplayer.BagGoodsPanel"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 400
local COM_HEIGHT = 134

function BarterTableBagContentView:ctor(defaultUseType)
    BarterTableBagContentView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.defaultUseType = defaultUseType
end

function BarterTableBagContentView:init( ... )
    -- self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bartertable", "Bartertable", false)
    BarterTableBagContentView.super.init(self, ... )
end

function BarterTableBagContentView:dtor()
    BarterTableBagContentView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bartertable.BarterTableBagContentView")
end

function BarterTableBagContentView:setUsedType(usedTypeList)
    self._bagGridList:setUsedType(usedTypeList)
end

function BarterTableBagContentView:onInitView()
    -- print("UI.BagGoodsPanel", not UI)
    -- dump(UI, "BagGoodsPanel113")
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    _usedType1.type = PublicDefine.MATERIAL_TYPE.MaterialBarter
    table.insert(usedTypeList,_usedType1)

    -- local _usedType2 = {}
    -- _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    -- _usedType2.type = PublicDefine.MATERIAL_TYPE.MaterialEnchanting
    -- table.insert(usedTypeList,_usedType2)

    -- --右边背包数据
    local bagList = UI.BagGoodsPanel:create(usedTypeList, true)
    bagList:setHideBagType(
        {
            UI.BagGoodsPanel.BAG_TYPE.ALL,
            UI.BagGoodsPanel.BAG_TYPE.ITEM,
            UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
            UI.BagGoodsPanel.BAG_TYPE.RELIC,
            UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
            UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
        }
    )

    bagList:setShowBagTagExt(
        {
            -- UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
        }
    )

    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self:addChild(bagList, 5)
    bagList:centerRight(0)
    bagList:changeBagDefaultIndex(5)
    bagList:setUseLock(true)
end

function BarterTableBagContentView:bagRefresh()
    self._bagGridList:refreshView()
end

function BarterTableBagContentView:bagDragBeganCallback(grid, touchPosition)
    mvc.send(mvc.events.Barter_Bag_Drag_Began, grid, touchPosition)
end

function BarterTableBagContentView:bagDragMovedCallback(grid, touchPosition)
    -- mvc.send(mvc.events.Recast_Bag_Drag_Moved, grid, touchPosition)
end

function BarterTableBagContentView:bagDragEndedCallback(grid, touchPosition, isInBag)
    mvc.send(mvc.events.Barter_Bag_Drag_Ended, grid, touchPosition, isInBag)
end

function BarterTableBagContentView:bindModel()

end


function BarterTableBagContentView:unbindModel()

end





return BarterTableBagContentView













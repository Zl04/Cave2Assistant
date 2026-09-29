------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/08/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RecastBagContentView = class("RecastBagContentView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 152
local COM_HEIGHT = 134

function RecastBagContentView:ctor(defaultUseType)
    RecastBagContentView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.defaultUseType = defaultUseType
end

function RecastBagContentView:init( ... )
    -- self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.recast", "Recast", false)
    RecastBagContentView.super.init(self, ... )
end

function RecastBagContentView:dtor()
    RecastBagContentView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.recast.RecastBagContentView")
end

function RecastBagContentView:setUsedType(usedTypeList)
    self._bagGridList:setUsedType(usedTypeList)
end

function RecastBagContentView:onInitView()
    -- --右边背包数据
    local bagList = UI.BagGoodsPanel:create(self.defaultUseType, true)
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

    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self:addChild(bagList, 5)
    bagList:centerRight(0)
    bagList:changeBagDefaultIndex(2)
    bagList:setUseLock(true)
end

function RecastBagContentView:bagRefresh()
    self._bagGridList:refreshView()
end

function RecastBagContentView:bagDragBeganCallback(grid, touchPosition)
    mvc.send(mvc.events.Recast_Bag_Drag_Began, grid, touchPosition)
end

function RecastBagContentView:bagDragMovedCallback(grid, touchPosition)
    -- mvc.send(mvc.events.Recast_Bag_Drag_Moved, grid, touchPosition)
end

function RecastBagContentView:bagDragEndedCallback(grid, touchPosition, isInBag)
    mvc.send(mvc.events.Recast_Bag_Drag_Ended, grid, touchPosition, isInBag)
end

function RecastBagContentView:bindModel()

end


function RecastBagContentView:unbindModel()

end





return RecastBagContentView













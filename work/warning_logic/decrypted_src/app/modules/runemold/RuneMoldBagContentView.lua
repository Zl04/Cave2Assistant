------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RuneMoldBagContentView = class("RuneMoldBagContentView", UI.HWBtnComponent)
require "app.ui.shoplayer.BagGoodsPanel"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 423
local COM_HEIGHT = 500

function RuneMoldBagContentView:ctor(defaultUseType)
    RuneMoldBagContentView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.defaultUseType = defaultUseType
end

function RuneMoldBagContentView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.runemold", "RuneMold", false)
    RuneMoldBagContentView.super.init(self, ... )

    -- self:setTouchEnable(true)
    -- self:setSwallowTouches(true)
    -- self:setInterceptTouches(true)
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
    --     self:close()
    -- end)
end

function RuneMoldBagContentView:dtor()
    RuneMoldBagContentView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.runemold.RuneMoldBagContentView")
end


function RuneMoldBagContentView:onInitView()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_GEM_STONE
    _usedType1.type = self.defaultUseType or 0--PublicDefine.MATERIAL_TYPE.MaterialBarter
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
            -- UI.BagGoodsPanel.BAG_TYPE.GEM_STONE,
            UI.BagGoodsPanel.BAG_TYPE.RELIC,
            UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
            UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
            UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
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
    bagList:changeBagDefaultIndex(6)
    bagList:setUseLock(true)
    bagList:hideImageBg()
end

function RuneMoldBagContentView:setUsedType(usedTypeList)
    self._bagGridList:setUsedType(usedTypeList)
end

function RuneMoldBagContentView:bagRefresh()
    self._bagGridList:refreshView()
end

function RuneMoldBagContentView:bagDragBeganCallback(grid, touchPosition)
    mvc.send(mvc.events.Rune_Bag_Drag_Began, grid, touchPosition)
end

function RuneMoldBagContentView:bagDragMovedCallback(grid, touchPosition)
    -- mvc.send(mvc.events.Recast_Bag_Drag_Moved, grid, touchPosition)
end

function RuneMoldBagContentView:bagDragEndedCallback(grid, touchPosition, isInBag)
    mvc.send(mvc.events.Rune_Bag_Drag_Ended, grid, touchPosition, isInBag)
end

function RuneMoldBagContentView:close()
    RuneMoldBagContentView.super.close(self)
    mvc.send("Rune_Mold_On_Bag_Close")
end

function RuneMoldBagContentView:bindModel()

end


function RuneMoldBagContentView:unbindModel()

end





return RuneMoldBagContentView













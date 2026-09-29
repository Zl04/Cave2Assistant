------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/20
--desc	: 
------------------------------------------------------------------------------

require "app.ui.shoplayer.BagGoodsPanel"
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PurpleUpgradePacketLayer = class("PurpleUpgradePacketLayer", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    -- "ui_common_information.plist",
    -- "ui_common_btn.plist",
    -- "ui_common_symbol.plist",
    -- "ui_general_shopping.plist",
    -- "ui_manor_cook.plist",
}

local COM_WIDTH = 458
local COM_HEIGHT = 626

function PurpleUpgradePacketLayer:ctor(hideTypeList, showTypeList, usedType)
    PurpleUpgradePacketLayer.super.ctor(
    	self,
    	UI.Type.Tips,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.hideTypeList = hideTypeList

    self.showTypeList = showTypeList

    self.usedType = usedType

    self:bindModel()
end

function PurpleUpgradePacketLayer:init( ... )
    PurpleUpgradePacketLayer.super.init(self, ... )
end

function PurpleUpgradePacketLayer:dtor()
    PurpleUpgradePacketLayer.super.dtor(self)
    self:unbindModel()
    self.hideTypeList = {}
    reload_script_file_mvc("app.modules.purpleupgrade.PurpleUpgradePacketLayer")
end

function PurpleUpgradePacketLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    
    self:initBagView()
end

function PurpleUpgradePacketLayer:initBagView()
    local usedTypeList = {}
    -- local _usedType1 = {}
    -- _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_MATERIAL
    -- _usedType1.type = PublicDefine.MATERIAL_TYPE.MaterialPrimogem
    -- local _usedType2 = {}
    -- _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    -- _usedType2.type = 0 --all
    -- _usedType2.needPurpleFunc = function(goodsData)
    --     -- if goodsData.isLock then
    --     --     return false
    --     -- end
    --     if goodsData.createLevel and goodsData.createLevel > 0 and goodsData.primogemId == 0 then
    --         return true
    --     end
    --     if not goodsData.createLevel or goodsData.createLevel == 0 or goodsData.primogemId ~= 0 then
    --         return false
    --     end
    -- end
    for k, v in pairs(self.usedType) do
        if v then
            table.insert(usedTypeList, v)
        end
    end
    -- table.insert(usedTypeList, self.usedType._usedType1)
    -- table.insert(usedTypeList, _usedType2)

    local bagList = UI.BagGoodsPanel:create(usedTypeList, true, false)
    bagList:setHideBagType(
            self.hideTypeList
        )
    bagList:setShowBagTagExt(
        self.showTypeList
    )
    
    bagList:init(nil, nil, 3)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self.contentLayout:addChild(bagList, 5)
    local bagListW, bagListH = bagList:getSize()
    bagList:center()
    -- bagList:changeBagDefaultIndex(19)
    bagList:hideImageBg()
    bagList:primogemBagRefresh()
end

function PurpleUpgradePacketLayer:getBagList()
    return self._bagGridList
end

function PurpleUpgradePacketLayer:close()
    PurpleUpgradePacketLayer.super.close(self)
end

function PurpleUpgradePacketLayer:bindModel()

end

function PurpleUpgradePacketLayer:unbindModel()

end


return PurpleUpgradePacketLayer













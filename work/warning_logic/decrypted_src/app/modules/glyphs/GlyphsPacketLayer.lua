------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/08/20
--desc	: 
------------------------------------------------------------------------------

require "app.ui.shoplayer.BagGoodsPanel"
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GlyphsPacketLayer = class("GlyphsPacketLayer", UI.HWBtnComponent)

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

function GlyphsPacketLayer:ctor(hideTypeList, showTypeList)
    GlyphsPacketLayer.super.ctor(
    	self,
    	UI.Type.Tips,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.hideTypeList = hideTypeList

    self.showTypeList = showTypeList

    self:bindModel()
end

function GlyphsPacketLayer:init( ... )
    GlyphsPacketLayer.super.init(self, ... )
end

function GlyphsPacketLayer:dtor()
    GlyphsPacketLayer.super.dtor(self)
    self:unbindModel()
    self.hideTypeList = {}
    reload_script_file_mvc("app.modules.glyphs.GlyphsPacketLayer")
end

function GlyphsPacketLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    
    self:initBagView()
end

function GlyphsPacketLayer:initBagView()
    local usedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_GLYPH
    _usedType1.type = 0 --"all"
    local _usedType2 = {}
    _usedType2.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
    _usedType2.type = 0 --"all"
    table.insert(usedTypeList, _usedType2)

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
    bagList:glyphsBagRefresh()
end

function GlyphsPacketLayer:getBagList()
    return self._bagGridList
end

function GlyphsPacketLayer:close()
    GlyphsPacketLayer.super.close(self)
end

function GlyphsPacketLayer:bindModel()

end

function GlyphsPacketLayer:unbindModel()

end


return GlyphsPacketLayer













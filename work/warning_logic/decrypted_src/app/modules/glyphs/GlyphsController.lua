--[[--
控制器GlyphsController，view已经注入,可以通过mvc.glyphsProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2023/10/19
-- desc	: 
------------------------------------------------------------------------------
local GlyphsController = class("GlyphsController", mvc.GameController)

-- mvc.events.Glyphs_Show_Layer 处理函数
function GlyphsController:noticeGlyphsShowLayer(notification, pageIndex, parent)
    local layer
    if pageIndex == 1 then
        local GlyphsCastingLayer = require "app.modules.glyphs.GlyphsCastingLayer"
        self.GlyphsCastingLayer = GlyphsCastingLayer:create()
        layer = self.GlyphsCastingLayer
    elseif pageIndex == 2 then
        local GlyphsInlayView = require "app.modules.glyphs.GlyphsInlayView"
        self.GlyphsInlayView = GlyphsInlayView:create()
        layer = self.GlyphsInlayView
    elseif pageIndex == 3 then
        local GlyphsRefinedView = require "app.modules.glyphs.GlyphsRefinedView"
        self.GlyphsRefinedView = GlyphsRefinedView:create()
        layer = self.GlyphsRefinedView
    elseif pageIndex == 4 then
        local GlyphsInheritLayer = require "app.modules.glyphs.GlyphsInheritLayer"
        self.GlyphsInheritLayer = GlyphsInheritLayer:create()
        layer = self.GlyphsInheritLayer
    end

    layer:init()
    layer:center()
    parent.innerContentLayout:addChild(layer)
end



-- mvc.events.Glyphs_Click_Tab 处理函数
function GlyphsController:noticeGlyphsClickTab(notification, clickIndex)
    if not self.glyphsMainView then
        return
    end

    self.glyphsMainView.curTabIndex = clickIndex
    self.glyphsMainView.btnData[self.glyphsMainView.curTabIndex].select = true
    self.glyphsMainView._tableView:updateCellAtIndex(self.glyphsMainView.curTabIndex - 1)

    if self.glyphsMainView.lastTabIndex > 0 then
        if self.glyphsMainView.lastTabIndex == clickIndex then
            return
        end
        self.glyphsMainView.btnData[self.glyphsMainView.lastTabIndex].select = false
        self.glyphsMainView._tableView:updateCellAtIndex(self.glyphsMainView.lastTabIndex - 1)
    end

    local nowPageId = self.glyphsMainView.curTabIndex
    local lastPageId = self.glyphsMainView.lastTabIndex
    printInfo("nowPageId == " .. nowPageId .. "  lastPageId == " .. lastPageId)

    mvc.send("Glyphs_Show_Layer", nowPageId, self.glyphsMainView)

    if lastPageId == 1 and self.GlyphsCastingLayer and not tolua.isnull(self.GlyphsCastingLayer) then
        self.GlyphsCastingLayer:removeFromParent(true)
        self.GlyphsCastingLayer = nil
    elseif lastPageId == 2 and self.GlyphsInlayView and not tolua.isnull(self.GlyphsInlayView) then
        self.GlyphsInlayView:removeFromParent(true)
        self.GlyphsInlayView = nil
    elseif lastPageId == 3 and self.GlyphsRefinedView and not tolua.isnull(self.GlyphsRefinedView) then
        self.GlyphsRefinedView:removeFromParent(true)
        self.GlyphsRefinedView = nil
    elseif lastPageId == 4 and self.GlyphsInheritLayer and not tolua.isnull(self.GlyphsInheritLayer) then
        self.GlyphsInheritLayer:removeFromParent(true)
        self.GlyphsInheritLayer = nil
    end

    self.glyphsMainView.lastTabIndex = self.glyphsMainView.curTabIndex
end



-- mvc.events.Glyphs_Open_Main_View 处理函数
function GlyphsController:noticeGlyphsOpenMainView(notification, pageIndex)
    mvc.openPanel("Glyphs", "GlyphsMain")
    local openIndex = pageIndex or 1

    mvc.send("Glyphs_Click_Tab", pageIndex)
end



-- mvc.events.Glyphs_On_Casting_Succeed_Show_Get 处理函数
function GlyphsController:noticeGlyphsOnCastingSucceedShowGet(notification, data)
    local awardsList = {}

    local useGoodsData = GoodsDataManager:getGlyphByEntityID(data.glyphInstanceID)--GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_GLYPH, data.glyphConfigID, false, data.glyphInstanceID)

    -- local awarObj = GoodsDataManager:createLocalGoodsData(data.glyphConfigID)
    -- awarObj:setNum(1)
    table.insert(awardsList, useGoodsData)

    if #awardsList > 0 then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD_MAX_ZORDER, awardsList, nil, UI.TEXT_111030, UI_ZORDER.TOP_ACTIVITY)
    end

    if self.GlyphsCastingLayer then
        self.GlyphsCastingLayer:clearSelectedData()
    end
    
end



-- mvc.events.Glyphs_On_Inherit_Succeed 处理函数
function GlyphsController:noticeGlyphsOnInheritSucceed(notification, data)
    local attrData = data.mainData
    local changedGlyphData = GoodsDataManager:getGlyphByEntityID(attrData.entityID)--GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_GLYPH, data.mainglyphTemplateid, false, attrData.entityID)
    changedGlyphData:restAttrData(attrData.attrData)
    if self.GlyphsInheritLayer then
        self.GlyphsInheritLayer:onInheritSucceed()
    end
end



-- mvc.events.Glyphs_Refresh_Casting_Num 处理函数
function GlyphsController:noticeGlyphsRefreshCastingNum(notification)
    if self.GlyphsCastingLayer then
        self.GlyphsCastingLayer:updateDailyCastingNum()
    end
end



return GlyphsController
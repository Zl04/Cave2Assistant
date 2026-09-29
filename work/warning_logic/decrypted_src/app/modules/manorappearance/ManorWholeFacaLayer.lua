------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: 
------------------------------------------------------------------------------
require "app.modules.manorappearance.ManorAppearanceShowCellView"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorWholeFacaLayer = class("ManorWholeFacaLayer", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {

}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local INNER_WIDTH = 681
local INNER_HEIGHT = 470

local TAB_BUTTON_WIDTH = 124
local TAB_BUTTON_HEIGHT = 38

local PICTURE_FRAME_WIDTH = 236
local PICTURE_FRAME_HEIGH = 138

function ManorWholeFacaLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_FACA_LAYER_VIEW, self, self.updateCells)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_GET_NEW_FACA_LAYER_VIEW, self, self.updateCellsByGetNewFacade)
    
end

function ManorWholeFacaLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_FACA_LAYER_VIEW, self, self.updateCells)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_GET_NEW_FACA_LAYER_VIEW, self, self.updateCellsByGetNewFacade)
end

local facaTypeList = {
    ["mannor"] = {
        name = UI.TEXT_222715,
        config = ConfigManager:getAllMannorShapeData()
    },
    ["boat"] = {
        name = UI.TEXT_222718,
        config = ConfigManager:getAllBoatData()
    },
}

function ManorWholeFacaLayer:ctor(buildId)
    ManorWholeFacaLayer.super.ctor(
    	self,
    	UI.Type.MANOR_SHAPE_MANAGE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.btnData = {}
    -- self.shapeConfig = {}
    self.cellList = {}
    self.type = buildId
    self.facaTypeData = {}
    self:bindModel()
end

function ManorWholeFacaLayer:init( ... )
    -- self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.tradeactivity", "TradeActivity", false)
    ManorWholeFacaLayer.super.init(self, ... )
    
end

function ManorWholeFacaLayer:dtor()
    ManorWholeFacaLayer.super.dtor(self)
    self:unbindModel()
    self.cellList = nil
    self.type = nil
    self.facaTypeData = {}
    reload_script_file_mvc("app.modules.manorappearance.ManorWholeFacaLayer")
end

function ManorWholeFacaLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 内部活动附着点
    local innerContentLayout = UI.Layout:create()
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:centerRight(0)
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_navigation_bg_1.png")
    centerBg:center()
    contentLayout:addChild(centerBg)

    -- 背景图片
    local line  = UI.Image:create()
    line:init("ui_navigation_line_4.png")
    line:centerUp(127)
    contentLayout:addChild(line)

    self:makeTabList()
    self:createPageBtn()
end


function ManorWholeFacaLayer:makeTabList()
    -- local shapeConfig = mvc.manorAppearanceModel:getFacaConfigByType(self.type)--ConfigManager:getAllOtherShapeData()
    -- for k, v in pairs(shapeConfig) do
    --     table.insert(self.shapeConfig, v)
    -- end
    local scrollContent = UI.Layout:create()
    scrollContent:init()
    scrollContent:centerUp(20)
    self.scrollContent = scrollContent

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(780, 330)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:center(0, 20)
    scrollView:setCircleVisible(false)

    scrollView:addInnerNode(scrollContent)
    self.contentLayout:addChild(scrollView)
    scrollView:scrollToTop()
    self.scrollView = scrollView

    
end

function ManorWholeFacaLayer:createTabCell(data)
    local onePaddingY = PICTURE_FRAME_HEIGH+90
    local onePaddingX = PICTURE_FRAME_WIDTH+30
    local startX = 0
    local config = {}
    self.scrollContent:removeAllChildren()

    for k, v in pairs(data) do
        
        local cell  = UI.ManorAppearanceShowCellView:create(v, self.type)
        cell:init()
        local idx  = math.floor(k/3)
        if((k-1)%3 == 0 or k == 1) then
            cell:leftUp(startX , onePaddingY*idx)
        else
            local ratio = k%3 == 0 and 3 or k%3
            idx = k%3 == 0 and idx-1 or idx
            cell:leftUp(startX + (ratio-1)*onePaddingX, onePaddingY*idx)
        end
        self.scrollContent:addChild(cell)
        table.insert(self.cellList, cell)
    end
    local len = #data
    local idx = math.floor(len/3)
    local row = len%3 == 0 and idx or idx+1
    self.scrollContent:setSize(780, onePaddingY*row)
end

function ManorWholeFacaLayer:updateCells()
    for k, v in pairs(self.cellList) do
        v:updateCellInfo()
    end
end

function ManorWholeFacaLayer:updateCellsByGetNewFacade()
    for k, v in pairs(self.cellList) do
        v:updateCellInfoByGetNewFacade()
    end
end

function ManorWholeFacaLayer:createPageBtn()
    self.curTabIndex = 1
    self.lastTabIndex = 0

    local pageBtn = UI.Button:create()
        pageBtn:init('ui_navigation_lable_normal_2.png', 'ui_navigation_lable_checked_2.png', 'ui_navigation_lable_checked_2.png')
        pageBtn:leftUp(70,90)
        pageBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        pageBtn:setText(facaTypeList[self.type].name)
        pageBtn:closeClickScale()
        
        self.contentLayout:addChild(pageBtn, 10)
        pageBtn:disable()
        self:updateShowCell()
    
    -- for _, v in pairs(facaTypeList[self.type]) do
    --     local pageBtn = UI.Button:create()
    --     pageBtn:init('ui_navigation_lable_normal_2.png', 'ui_navigation_lable_checked_2.png', 'ui_navigation_lable_checked_2.png')
    --     pageBtn:leftUp(70,90)
    --     pageBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    --     pageBtn:setText(facaTypeList[self.type].name)
    --     -- pageBtn:enableDebugDraw()
    --     pageBtn:closeClickScale()
        
    --     -- pageBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --     --     self:tabPageBtnClick(k)

    --     --     for i,v in pairs(self.btnData) do
    --     --         if k == i then
    --     --             v:disable()
    --     --         else
    --     --             v:enable()
    --     --         end
    --     --     end

    --     -- end)
    --     self.contentLayout:addChild(pageBtn, 10)
    --     -- self.btnData[k] = pageBtn

    --     -- if self.curTabIndex == k then
    --     --     pageBtn:disable()
    --     --     self:updateShowCell(k)
    --     -- else
    --     --     pageBtn:enable()
    --     -- end
    --     self:updateShowCell()
    -- end
end

function ManorWholeFacaLayer:tabPageBtnClick(index)

    -- local clickIndex = index

    -- if self.curTabIndex == clickIndex then
    --     return
    -- end

    -- self.curTabIndex = clickIndex

    -- printInfo("nowPageId == ", index)
    -- self.lastTabIndex = self.curTabIndex
    self:updateShowCell()
end

function ManorWholeFacaLayer:updateShowCell()
    -- print("updateShowCel1l", index)
    -- local curType = self.type or self.facaTypeData[index].type
    local shapeConfig = facaTypeList[self.type].config--mvc.manorAppearanceModel:getFacaConfigByType(curType)
    dump(shapeConfig, "shapeConfig2132")
    self:createTabCell(shapeConfig)
end

return ManorWholeFacaLayer













------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/14
--desc	: 
------------------------------------------------------------------------------
-- 补给仓
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortSupplyView = class("BigSailPortSupplyView", UI.HWBtnComponent)
require "app.modules.bigsailport.BigSailPortShowCellView"
require "app.modules.bigsailport.BigSailPortSupplyItemView"

-- 资源
local COM_RES_LIST = {
    "ui_town_navigation.plist",
    "ui_town_businessactivities.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_bg_paper3.plist",
    "ui_town_businessactivities.plist",
    "ui_town_greatnavigation.plist",
}

local facaTypeList = {
    -- ["mannor"] = {
    --     name = UI.TEXT_222715,
    --     config = ConfigManager:getAllMannorShapeData()
    -- },
    ["boat"] = {
        name = UI.TEXT_222718,
        config = ConfigManager:getAllBoatData()
    },
}

UI = UI or {}

UI.BigSailPortSupplyView = BigSailPortSupplyView

local COM_WIDTH = 852
local COM_HEIGHT = 534
local INNER_WIDTH = 980
local INNER_HEIGHT = 540
local PICTURE_FRAME_WIDTH = 236
local PICTURE_FRAME_HEIGH = 138

-- 最大补给数量
local MAX_SUPPLY_NUMS = ConfigManager:getAllNavigationGeneralConfigData()[1].supplyMax

---------------------
-- 没有完成的注释标记
-- UNSUCCESS_TAB
---------------------

function BigSailPortSupplyView:ctor()
    BigSailPortSupplyView.super.ctor(
    	self,
    	UI.Type.BIGSAIL_SUPPLY,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.cellList = {}
    self.nowSupplyNum = 0 -- 当前补给数量

    -- 这一块仅对要使用的数据做初始化，不对view操作
    self:refreshSupplyNums()

end

function BigSailPortSupplyView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    BigSailPortSupplyView.super.init(self, ... )
end

function BigSailPortSupplyView:dtor()
    print(debug.traceback("BigSailPortSupplyView"))
    BigSailPortSupplyView.super.dtor(self)
    self:unbindModel()
    self.cellList = nil
    reload_script_file_mvc("app.modules.bigsailport.BigSailPortSupplyView")
end


function BigSailPortSupplyView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_businessactivities_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    -- title
    local title  = UI.Image:create()
    title:init("ui_bg_title.png")
    title:center(0, -265)
    contentLayout:addChild(title)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226145, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_155_155_155)
    titleText:center(10,3)
    title:addChild(titleText)

    -- 内部背景图片
    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
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
    line:center(0, -170)
    contentLayout:addChild(line)

    -- UNSUCCESS_TAB 缺 UI.TEXT_221927
    -- 补给品string 
    local supplyString = UI.Text:create()
    supplyString:init(UI.TEXT_226107..":", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    supplyString:center(190, -190)
    contentLayout:addChild(supplyString)
    -- UNSUCCESS_TAB 缺补给品图片
    local goodsData = ConfigManager:getVirtualItemConfigByID(23460001)
    local supplyPic = UI.Image:create()
    supplyPic:init(goodsData.miniIcon)
    supplyPic:center(90, 0)
    supplyString:addChild(supplyPic)
    -- UNSUCCESS_TAB 缺补给品数量字体参数
    local supplyNums = UI.Text:create()
    supplyNums:init(tostring(self.nowSupplyNum), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    supplyNums:center(130, 0)
    supplyString:addChild(supplyNums)
    -- UNSUCCESS_TAB 缺补给品按钮图片
    local supplyBtn = UI.Button:create()
    supplyBtn:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    supplyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- 超过上限
        if self.nowSupplyNum >= MAX_SUPPLY_NUMS then
            UI.ScrollBar:createByText(UI.TEXT_1170851)
            return
        end

        local data = {}
        data.nowNum = self.nowSupplyNum
        data.maxNum = MAX_SUPPLY_NUMS
        data.minNum = 0
        data.type = "buy"
        mvc.openPanel("BigSailPort", "BigSailPortSupplyItem", data)
    end)
    supplyBtn:center(190, 0)
    supplyString:addChild(supplyBtn)

    local pageBtn = UI.Button:create()
    pageBtn:init('ui_navigation_lable_normal_2.png', 'ui_navigation_lable_checked_2.png', 'ui_navigation_lable_checked_2.png')
    pageBtn:leftUp(50,58)
    pageBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    pageBtn:setText(facaTypeList["boat"].name)
    pageBtn:closeClickScale()
    self.contentLayout:addChild(pageBtn, 10)
    pageBtn:disable()


    self:makeTabList()
    self:createPageBtn()
end

function BigSailPortSupplyView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_SUPPLY, self, self.openBoatSupply)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, self, self.refreshDock)
end

function BigSailPortSupplyView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_SUPPLY, self, self.openBoatSupply)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, self, self.refreshDock)
end

function BigSailPortSupplyView:openBoatSupply(data)
    mvc.openPanel("BigSailPort", "BigSailPortSupplyItem", data)
end

function BigSailPortSupplyView:refreshDock(data)
    -- 刷新整个船坞界面
    self.contentLayout:removeAllChildren()
    self:refreshSupplyNums()
    self:onInitView()
    if data == "add" then
        UI.ScrollBar:createByText(UI.TEXT_226105)
    elseif data == "buy" then
        UI.ScrollBar:createByText(UI.TEXT_1212019)
    elseif data == "setPetSuccess" then
        UI.ScrollBar:createByText(UI.TEXT_226113)
    else
        UI.ScrollBar:createByText(UI.TEXT_1110372)
    end
end

function BigSailPortSupplyView:makeTabList()
    -- local shapeConfig = mvc.manorAppearanceModel:getFacaConfigByType(self.type)--ConfigManager:getAllOtherShapeData()
    -- for k, v in pairs(shapeConfig) do
    --     table.insert(self.shapeConfig, v)
    -- end
    local scrollContent = UI.Layout:create()
    scrollContent:init()
    scrollContent:centerUp(20)
    self.scrollContent = scrollContent

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(810, 330)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:center(0, 20)
    scrollView:setCircleVisible(false)

    scrollView:addInnerNode(scrollContent)
    self.contentLayout:addChild(scrollView)
    scrollView:scrollToTop()
    self.scrollView = scrollView

    
end

function BigSailPortSupplyView:createTabCell(data)
    local onePaddingY = PICTURE_FRAME_HEIGH+90
    local onePaddingX = PICTURE_FRAME_WIDTH+30
    local startX = 0
    local config = {}
    self.scrollContent:removeAllChildren()

    local useData = {}
    for k,v in pairs(data) do
        local isUnlock = mvc.dockModel:checkBoatIsUnlock(v.ID)
        if isUnlock then
            table.insert(useData,v)
        end
    end

    -- local isUnlock 
    local checkIndex = 0
    for k, v in ipairs(useData) do
        local isUnlock = mvc.dockModel:checkBoatIsUnlock(v.ID)
    
        if isUnlock then
            local index = k
            if checkIndex > 0 then
                index = index-checkIndex
                checkIndex = 0
            end
            local cell  = UI.BigSailPortShowCellView:create(v, "boat")
            cell:init()
            local idx  = math.floor(index/3)
            if((index-1)%3 == 0 or index == 1) then
                cell:leftUp(startX , onePaddingY*idx)
            else
                local ratio = index%3 == 0 and 3 or index%3
                idx = index%3 == 0 and idx-1 or idx
                cell:leftUp(startX + (ratio-1)*onePaddingX, onePaddingY*idx)
            end
            self.scrollContent:addChild(cell)
            table.insert(self.cellList, cell)
        else
            checkIndex = checkIndex+1
        end

    end
    local len = #data
    local idx = math.floor(len/3)
    local row = len%3 == 0 and idx or idx+1
    self.scrollContent:setSize(780, onePaddingY*row)
end

function BigSailPortSupplyView:updateCells()
    for k, v in pairs(self.cellList) do
        v:updateCellInfo()
    end
end

function BigSailPortSupplyView:updateCellsByGetNewFacade()
    for k, v in pairs(self.cellList) do
        v:updateCellInfoByGetNewFacade()
    end
end

function BigSailPortSupplyView:createPageBtn()
    self.curTabIndex = 1
    self.lastTabIndex = 0
    self:updateShowCell()
end

function BigSailPortSupplyView:tabPageBtnClick(index)
    self:updateShowCell()
end

function BigSailPortSupplyView:updateShowCell()
    -- print("updateShowCel1l", index)
    -- local curType = self.type or self.facaTypeData[index].type
    local shapeConfig = facaTypeList["boat"].config--mvc.manorAppearanceModel:getFacaConfigByType(curType)
    self:createTabCell(shapeConfig)
end

function BigSailPortSupplyView:refreshSupplyNums()
    -- 刷新补给品数量
    self.nowSupplyNum = mvc.bigSailPortModel:getBaseData().supplyAmount
end

return BigSailPortSupplyView













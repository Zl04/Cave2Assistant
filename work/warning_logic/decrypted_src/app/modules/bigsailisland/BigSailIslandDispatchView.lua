------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandDispatchView = class("BigSailIslandDispatchView", UI.HWBtnComponent)

require "app.modules.bigsailport.BigSailPortShowCellView"

-- 资源
local COM_RES_LIST = {
    "ui_town_navigation.plist",
    "ui_town_businessactivities.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_town_businessactivities.plist",
    "ui_town_greatnavigation.plist",
}

local facaTypeList = {
    ["boat"] = {
        name = UI.TEXT_222718,
        config = ConfigManager:getAllBoatData()
    },
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local INNER_WIDTH = 980
local INNER_HEIGHT = 540
local PICTURE_FRAME_WIDTH = 236
local PICTURE_FRAME_HEIGH = 138

function BigSailIslandDispatchView:ctor(data)
    BigSailIslandDispatchView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
    self.cellList = {}
    print("BigSailIslandDispatchView===>: ", data)
end

function BigSailIslandDispatchView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandDispatchView.super.init(self, ... )
end

function BigSailIslandDispatchView:dtor()
    BigSailIslandDispatchView.super.dtor(self)
    self:unbindModel()
    self.cellList = nil
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandDispatchView")
end


function BigSailIslandDispatchView:onInitView()
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
    titleText:init(UI.TEXT_226147, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_204_204_204)
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

    local pageBtn = UI.Button:create()
    pageBtn:init('ui_navigation_lable_normal_2.png', 'ui_navigation_lable_checked_2.png', 'ui_navigation_lable_checked_2.png')
    pageBtn:leftUp(50,58)
    pageBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    pageBtn:setText(facaTypeList["boat"].name)
    pageBtn:closeClickScale()
    self.contentLayout:addChild(pageBtn, 10)
    pageBtn:disable()

    -- 已派遣船只
    local limitMax = ConfigManager:getAllNavigationGeneralConfigData()[1].boatDispatchMax
    local baseInfo = mvc.bigSailPortModel:getBaseData()
    local boatHave = 0
    for k,v in pairs(baseInfo.useBoats) do
        print("v.status==>:", v.status)
        if v.status ~= 0 then
            boatHave = boatHave + 1
        end
    end
    local titleText2 = UI.Text:create()
    titleText2:init(UI.TEXT_226148..tostring(boatHave).."/"..tostring(limitMax), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText2:center(300, -190)
    self.contentLayout:addChild(titleText2)

    self:makeTabList()
    self:updateShowCell()
end

function BigSailIslandDispatchView:updateShowCell()
    local shapeConfig = clone(facaTypeList["boat"].config)--mvc.manorAppearanceModel:getFacaConfigByType(curType)
    self:createTabCell(shapeConfig)
end

function BigSailIslandDispatchView:makeTabList()
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

function BigSailIslandDispatchView:createTabCell(data)
    local onePaddingY = PICTURE_FRAME_HEIGH+90
    local onePaddingX = PICTURE_FRAME_WIDTH+30
    local startX = 0
    local config = {}
    self.scrollContent:removeAllChildren()

    local isUnlock 
    local checkIndex = 0
    for k, v in pairs(data) do
        local isUnlock = mvc.dockModel:checkBoatIsUnlock(v.ID)
        if isUnlock then
            local index = k

            v.dispatchBoat = true
            v.islandId = self.data.islandid

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

function BigSailIslandDispatchView:refreshDock(data)
    -- 刷新整个船坞界面
    self.contentLayout:removeAllChildren()
    self:onInitView()

    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_BIG_MAP)

    if data == "add" then
        UI.ScrollBar:createByText(UI.TEXT_226105)
    elseif data == "buy" then
        UI.ScrollBar:createByText(UI.TEXT_1212019)
    elseif data == "setPetSuccess" then
        UI.ScrollBar:createByText(UI.TEXT_226113)
    elseif data == "sail" then
        UI.ScrollBar:createByText(UI.TEXT_226150)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_REFRESH_BIG_MAP)
    else
        UI.ScrollBar:createByText(UI.TEXT_1110372)
    end
end


function BigSailIslandDispatchView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, self, self.refreshDock)
end


function BigSailIslandDispatchView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_REFRESH_DOCK_LIST, self, self.refreshDock)
end





return BigSailIslandDispatchView













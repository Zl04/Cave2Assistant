------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DockBoatMangeLayer = class("DockBoatMangeLayer", UI.HWBtnComponent)
local PetPacketLayer = require("app.modules.pettreasure.common.PetTreasurePacketLayer")

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local RIGHT_COM_W = 410
local RIGHT_COM_H = 420

local CELL_WIDTH = 384
local CELL_HEIGHT = 80
local TABLE_WIDTH = 384
local TABLE_HEIGHT = 280

function DockBoatMangeLayer:bindModel()

end

function DockBoatMangeLayer:unbindModel()

end

function DockBoatMangeLayer:ctor()
    DockBoatMangeLayer.super.ctor(
    	self,
    	UI.Type.TRADE_ACTIVITY_MAIN,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.tableCellArr = {}
    self._selectedBagGrid = nil
    self:bindModel()
end

function DockBoatMangeLayer:init( ... )
    DockBoatMangeLayer.super.init(self, ... )
    self.isEmbattling = false
end

function DockBoatMangeLayer:dtor()
    DockBoatMangeLayer.super.dtor(self)
    self:unbindModel()
    self.tableCellArr = {}
    self.isEmbattling = false
    self._selectedBagGrid = nil
    reload_script_file_mvc("app.modules.dock.DockBoatMangeLayer")
end

function DockBoatMangeLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_navigation_paperbg.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 左侧内容面板
    local leftContentLayout = UI.Layout:create()
    leftContentLayout:init()
    leftContentLayout:setSize(RIGHT_COM_W, RIGHT_COM_H)
    leftContentLayout:leftUp(35, 80)
    -- leftContentLayout:enableDebugDraw()
    self.contentLayout:addChild(leftContentLayout)
    self.leftContentLayout = leftContentLayout

    -- 右侧内容面板
    local rightContentLayout = UI.Layout:create()
    rightContentLayout:init()
    rightContentLayout:setSize(RIGHT_COM_W, RIGHT_COM_H)
    rightContentLayout:rightUp(35, 80)
    -- rightContentLayout:enableDebugDraw()
    self.contentLayout:addChild(rightContentLayout)
    self.rightContentLayout = rightContentLayout

    local rightTitle = UI.Text:create()
    rightTitle:init(UI.TEXT_221921, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rightTitle:centerUp(-14)
    self.rightContentLayout:addChild(rightTitle)

    -- 背景图片
    local rightTitleLine  = UI.Image:create()
    rightTitleLine:init("ui_navigation_line_2.png")
    rightTitleLine:centerUp(15)
    self.rightContentLayout:addChild(rightTitleLine)

    -- 船只修改
    local changeBoat = UI.Button:create();
    changeBoat:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png");
    changeBoat:leftBottom(100, 20)
    changeBoat:setText(UI.TEXT_221922)
    changeBoat:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    changeBoat:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:changeAndBuyBoat()
    end)
    rightContentLayout:addChild(changeBoat, 100)
    self.changeBoat = changeBoat

    self:initLeftLayer()

    self:addBoatList()
end

function DockBoatMangeLayer:initLeftLayer()
    -- 内容面板
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(384, 350)
    layout:centerUp(70)
    self.leftContentLayout:addChild(layout)
    self.layout = layout
    layout:enableDebugDraw()

    local titleBg  = UI.Image:create()
    titleBg:init("ui_navigation_title_3.png")
    titleBg:centerUp(-5)
    self.leftContentLayout:addChild(titleBg)

    local boatName = UI.Text:create()
    boatName:init(UI.TEXT_221928, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    boatName:centerUp(-7)
    self.leftContentLayout:addChild(boatName)
    self.boatName = boatName

    local boatImage  = UI.Image:create()
    boatImage:init("")
    boatImage:center()
    self.leftContentLayout:addChild(boatImage)
    self.boatImage = boatImage
end

function DockBoatMangeLayer:updateLeftLayer()
    local boatData = self._selectedBagGrid:getData()
    local boatConfig = ConfigManager:getAllBoatDataByID(boatData.ID)
    self.boatImage:setSpriteName(boatConfig.thumbnail)
    self.boatName:setText(boatData.name)
end

function DockBoatMangeLayer:addBoatList()
    local dataList = mvc.dockModel:getBoatsCellListData()
    local data = {}
    data.haveMaterialArr = dataList
    local totalSize = #data
    local row,low = math.modf(totalSize/4)
    if(low > 0) then 
        totalSize = (row + 1) * 4
    end
    if(totalSize < 24) then 
        totalSize = 24
    end
    data.packetBoxBeUseNum = totalSize
    data.packetBoxMaxNum = totalSize

    local bagList = UI.GoodsListNew:create(4)
    bagList:init(data, 290, nil, 20, 20)
    -- bagList:setPos(14+3, 55)
    bagList:center(-55, 20)
    
    bagList:setCallbackForGridClick(self, self.bagClickCallback)
    -- bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    -- bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    -- bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    -- bagList:setDoubleClickAsDragEnd(true)
    bagList:hideBGImageCover()
    self._bagGridList = bagList
    self.rightContentLayout:addChild(bagList, 4)
    -- bagList:showMask()
    bagList:showAllGoods()
    bagList:updataGridCanUseState(true, true)

    local bgImageCover = UI.Image:create()
    bgImageCover:init("ui_navigation_bg_2.png")
    bgImageCover:center(0, 20)
    self.rightContentLayout:addChild(bgImageCover, 3)
end

function DockBoatMangeLayer:bagClickCallback(bagGrid)
    if (DEBUG) then
        print(string.format("DockBoatMangeLayer:bagClickCallback: grid index:%d.", bagGrid:getIndex()))
    end
    if(self._selectedBagGrid) then 
        self._selectedBagGrid:hideSelect()
    end

    local goodsData = nil
    if (bagGrid) then
        goodsData = bagGrid:getData()
        if goodsData then 
            bagGrid:showSelect()
        end
        self._selectedBagGrid = bagGrid

        self:updateLeftLayer()
    end
end

function DockBoatMangeLayer:changeAndBuyBoat()
    if self._selectedBagGrid then
        local boatData = self._selectedBagGrid:getData()
        if boatData.ID == self.boatID then

            return 
        end

        if not mvc.dockModel:checkBoatIsUnlock(boatData.ID) then
            Net.NetManorSystem:reqChangeBoat(boatData.ID)
        else
            -- 船只已解锁

        end
    end
end

return DockBoatMangeLayer













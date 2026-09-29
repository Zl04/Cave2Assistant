------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2021/10/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GhostabyssChoiceLevelView = class("GhostabyssChoiceLevelView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local winSize = cc.Director:getInstance():getWinSize()

require ("app.modules.cave.GhostabyssChoiceLevelCell")

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 600
local COM_HEIGHT = 532

function GhostabyssChoiceLevelView:ctor()
    GhostabyssChoiceLevelView.super.ctor(
    	self,
    	UI.Type.GHOSTABYSS_CHOICE_LEVEL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self:bindModel()
end

function GhostabyssChoiceLevelView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    GhostabyssChoiceLevelView.super.init(self, ... )
end

function GhostabyssChoiceLevelView:dtor()
    GhostabyssChoiceLevelView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.cave.GhostabyssChoiceLevelView")
end


function GhostabyssChoiceLevelView:onInitView()
    self:center()
    self:initData()

    local halfBg = UI.Image9:create()
    halfBg:init("ui_ghostabyss_up_02.png", CCRectMake(2,2,1,1), cc.size(winSize.width*2, winSize.height*2))
    halfBg:center()
    self:addChild(halfBg)

    local winSize = cc.Director:getInstance():getWinSize()
    local screenLayout = UI.Layout:create()
    screenLayout:init()
    screenLayout:setSize(winSize.width, winSize.height)
    screenLayout:center()
    self:addChild(screenLayout)
    screenLayout:setTouchEnable(true)
    screenLayout:setSwallowTouches(true)
    screenLayout:setInterceptTouches(true)

    local bg = UI.Image:create()
    bg:init("ui_ghostabyss_bg_05.png")
    bg:center()
    self:addChild(bg)

    bg:setTouchEnable(true)
    bg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        bg:removeEventListenerByName(UIEvent.COMPONENT_TOUCH_OUTSIDE)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()  
            if not tolua.isnull(self) then
                mvc.send(mvc.events.CloseGhostabyssChoiceLevel)
            end
        end, 0.01) 
    end)

    -- 标题
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1328002, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=203,g=216,b=217})
    titleText:centerUp(38-titleText:getContentSize().height/2)
    bg:addChild(titleText)
    self.levelTitle = titleText

    self:initTableView()

    -- 底部蒙层
    local cellMaskImage = UI.Image:create()
    cellMaskImage:init("ui_ghostabyss_up_04.png")
    cellMaskImage:centerBottom(25)
    self:addChild(cellMaskImage, 20)
    self.cellMaskImage = cellMaskImage
end

function GhostabyssChoiceLevelView:initData()
    self.data = ConfigManager:getAllGhostAbyss()
    self.commondGroupID = GameDataManager:getInstance():getBlackMarketGroupID()
end

function GhostabyssChoiceLevelView:initTableView()
    local master = GameDataManager:getInstance():getMaster()
    if(master) then
        self.heroLevel = master:getLevel()
    else
        self.heroLevel = 1
    end

    -- 中间列表区域
    self._titleTableView = UI.TableView:create({}, 555, 406)
    self._titleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._titleTableView:centerBottom(31)
    self._titleTableView:setDelegate()
    self._titleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._titleTableView:setBounceable(true)
    self._titleTableView:setOpacityModifyRGB(true)
    self._titleTableView:init()
    self._titleTableView:onUpdateCellSize(function (table,idx)
        return 555, 109
    end) 

    self._titleTableView:onUpdateCells(function (table, idx)
        -- print("self._titleTableView:onUpdateCells=", idx)
        -- 获取缓存的格子, 如果没有, 就新建
        local reusedCell = table:dequeueCell()
        if (not reusedCell) then
            reusedCell = UI.TableViewCell:create()
            xpcall(function()
                local cellView = UI.GhostabyssChoiceLevelCell:create()
                cellView:init()
                cellView:setTouchClipNode(self._titleTableView)
                cellView:leftBottom(0, 0)
                cellView:setName("cellView")
                reusedCell:addChild(cellView)
                cellView:updateData(self.data[idx + 1], self.heroLevel, self.commondGroupID)
            end,
            function(e) 
                printError("------------------------GoodsListNew:tableCellAtIndex-----------------error", e)
            end, 1);
        else 
            local cellView = reusedCell:getChildByName("cellView")
            if (cellView) then
                cellView:updateData(self.data[idx + 1], self.heroLevel, self.commondGroupID)
            end
        end

        return reusedCell
    end)

    self._titleTableView:onUpdateCellNumbers(function ()
        return #self.data
    end)

    self._titleTableView:onTableCellTouched(function(table, cell)
        if(cell) then 
            local cellView = cell:getChildByName("cellView")
            if (cellView) then
                if cellView:enableToChoice() then 
                    mvc.caveModel:setGhostabyssChoiceLevel(cellView:getID())
                    Avalon.Scheduler:scheduleUpdateOnce(self, function()  
                        if not tolua.isnull(self) then
                            mvc.send(mvc.events.CloseGhostabyssChoiceLevel)
                        end
                    end, 0.01) 
                end
            end
        end
    end)
    -- 载入数据
    self._titleTableView:reloadData()
    self._titleTableView:fixContentOffset()
    local ghostabyssData = mvc.caveModel:getCurrentGhostabyssData()
    if(ghostabyssData) then
        self._titleTableView:scrollToCell(ghostabyssData.ID + 2, 0, false)
    end
    self:addChild(self._titleTableView, 10)
end

function GhostabyssChoiceLevelView:bindModel()

end


function GhostabyssChoiceLevelView:unbindModel()

end

return GhostabyssChoiceLevelView
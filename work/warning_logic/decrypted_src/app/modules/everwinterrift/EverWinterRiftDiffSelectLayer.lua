------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/2/2
--desc	: 宠物资质加点
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local EverWinterRiftDiffSelectLayer = class("EverWinterRiftDiffSelectLayer", UI.BaseWin)
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

UI = UI or {}

UI.EverWinterRiftDiffSelectLayer = EverWinterRiftDiffSelectLayer

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 468
local COM_HEIGHT = 426

local INNER_WIDTH = 300
local INNER_HEIGHT = 320

function EverWinterRiftDiffSelectLayer:ctor()
    EverWinterRiftDiffSelectLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.dropRewardNode = nil
    self.passRewardNode = nil
    self.tableCellArr = {}

    self.caveMode = PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT
    self.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
    self.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(self.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
    self:bindModel()
end

function EverWinterRiftDiffSelectLayer:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.everwinterrift", "EverWinterRift", false)
    EverWinterRiftDiffSelectLayer.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)
end

function EverWinterRiftDiffSelectLayer:dtor()
    EverWinterRiftDiffSelectLayer.super.dtor(self)
    self:unbindModel()
    self.dropRewardNode = nil
    self.passRewardNode = nil

    reload_script_file_mvc("app.modules.everwinterrift.EverWinterRiftDiffSelectLayer")
end

function EverWinterRiftDiffSelectLayer:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    self.curSelectIdx = 0
    self.lastSelectIdx = 0

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_petschallenge_paper.png")
    bg:center()
    contentLayout:addChild(bg)

    local title = UI.Text:create()
    title:init(UI.TEXT_224204, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    title:centerUp(17)
    contentLayout:addChild(title)

    -- 内部活动附着点
    local innerContentLayout = UI.Layout:create()
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center(0, 20)
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)
    
    self:makeTabList()
end

function EverWinterRiftDiffSelectLayer:makeTabList()
    self.curTabIndex = 0--mvc.everWinterRiftModel:getTabIndex()
    self.lastTabIndex = 0

    local levelConfig = ConfigManager:getAllEverwinterRiftData()
    self.btnData = {}
    for k, v in ipairs(levelConfig) do
        local tab = {}
        tab.config = v
        tab.name = languageManagerInstance:getLocalString(v.name)
        tab.select = false
        tab.rootLayer = self.innerContentLayout

        table.insert(self.btnData, tab)
    end

    self._tableView = UI.TableView.new({}, INNER_WIDTH, INNER_HEIGHT)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:center(0, 20)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return INNER_WIDTH, 60;
    end)

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createTabCell(index)
            end,
            function(e)
                printError("------------------------EverWinterRiftDiffSelectLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createTabCell(index)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end)

    self._tableView:onTableCellTouched(function(table, cell)
        self:tabCellClick(cell:getIdx() + 1)
    end)

    self.contentLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)

    self:tabCellClick(mvc.everWinterRiftModel:getTabIndex(), true)
end

function EverWinterRiftDiffSelectLayer:createTabCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(INNER_WIDTH, 46))

    local image = UI.Image.create()
    image:init("ui_petschallenge_list.png")
    image:center(0)
    image:setName("image")
    cell:addChild(image)

    local text = UI.Text:create()
    text:init(self.btnData[index].name, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    text:center(0, 0)
    text:setWidth(INNER_WIDTH)
    text:setTextCenter()
    text:setLineSpacing(-6)
    text:setName("cellText")
    cell:addChild(text)

    local lock = UI.Image.create()
    lock:init("ui_starmap_label_lock.png")
    lock:leftUp(47, 10)
    lock:setName("lock")
    cell:addChild(lock)
    local curOpenLevel = self.curOpenLevel >= 1 and self.curOpenLevel or 1
    local isLock = curOpenLevel < mvc.everWinterRiftModel:getCurLevelByCopyLevel(index) and true or false
    lock:setVisible(isLock)

    if self.curTabIndex ~= index then
        -- text:setFontColor(UI.FONT_COLOR_41_41_45)
        image:setSpriteName("ui_petschallenge_list.png")
    else
        -- text:setFontColor(UI.FONT_COLOR_218_211_154)
        image:setSpriteName("ui_petschallenge_list2.png")
    end

    local redPoint = AvalonUtil.createRedPoint(cell, 15, 2, 100)
    redPoint:setName("redPoint")
    local idx = self.btnData[index].config.copyLv
    local canGet = mvc.everWinterRiftModel:checkIsCanGetRewardsByID(idx)
    redPoint:setVisible(canGet)

    self.tableCellArr[index] = cell
    return cell
end

function EverWinterRiftDiffSelectLayer:tabCellClick(index, open)
    if not index then
        return
    end

    local curOpenLevel = self.curOpenLevel >= 1 and self.curOpenLevel or 1
    local isLock = curOpenLevel < mvc.everWinterRiftModel:getCurLevelByCopyLevel(index) and true or false
    if isLock then
        UI.ScrollBar:createByText(string.format(UI.TEXT_224206, index-1))
        return
    end

    local clickIndex = index

    if self.curTabIndex == clickIndex then
        return
    end

    self.curTabIndex = clickIndex
    self.btnData[self.curTabIndex].select = true
    self._tableView:updateCellAtIndex(self.curTabIndex - 1)

    if self.lastTabIndex > 0 and self.btnData[self.lastTabIndex] then
        self.btnData[self.lastTabIndex].select = false
        self._tableView:updateCellAtIndex(self.lastTabIndex - 1)
    end

    printInfo("nowPageId == " .. self.curTabIndex .. "  lastPageId == " .. self.lastTabIndex, index)


    self.lastTabIndex = self.curTabIndex
    mvc.everWinterRiftModel:setTabIndex(self.curTabIndex)
    -- self:updateInfoLayer(index)
    local idx = self.btnData[self.curTabIndex].config.copyLv
    mvc.send("EverWinterRift_Refresh_Info", idx)
    if not open then
        self:close()
        UI.ScrollBar:createByText()
    end
end

function EverWinterRiftDiffSelectLayer:updateInfoLayer(idx)
    
end

function EverWinterRiftDiffSelectLayer:bindModel()

end

function EverWinterRiftDiffSelectLayer:unbindModel()

end

return EverWinterRiftDiffSelectLayer

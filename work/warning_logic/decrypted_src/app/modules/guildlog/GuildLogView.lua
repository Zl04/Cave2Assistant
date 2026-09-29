------------------------------------------------------------------------------
--author: 
--date	: 2019/10/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GuildLogView = class("GuildLogView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_common_information.plist"
}

local CELL_WIDTH = 345

function GuildLogView:ctor(pos)
    self._initWorldPos = pos
    GuildLogView.super.ctor(
    	self,
    	nil,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self._data = {}
    self:bindModel()
end

function GuildLogView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.guildlog", "GuildLog", false)
    GuildLogView.super.init(self, ... )
    mvc.guildLogController:requestLog()
end

function GuildLogView:dtor()
    GuildLogView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.guildlog.GuildLogView")
    if (self._testLabel) then
        self._testLabel:release()
        self._testLabel = nil
    end
end


function GuildLogView:onInitView()
------程序生成区块开始 node_1464677462_1571110484-------
    local node_1464677462_1571110484 = UI.Image9:create()
    node_1464677462_1571110484:init("ui_information_banner_background1.png", CCRectMake(12,12,2,2), cc.size(345, 465))
    node_1464677462_1571110484.__uiComposerID = "1464677462_1571110484"
    addChildAuto(self._layoutUU, self, node_1464677462_1571110484, "layout_1464677462_1571110484")
    self:setSize(node_1464677462_1571110484:getSize())
    self:center()
    local viewWidth, viewHeight = self:getSize()
    mvc.guildLogPanel.ui:setSize(viewWidth, viewHeight)
    local parent = mvc.guildLogPanel.ui:getParent()
	if (parent and self._initWorldPos) then
		local localPos = parent:convertToNodeSpace(self._initWorldPos)
		mvc.guildLogPanel.ui:leftBottom(localPos.x, localPos.y - viewHeight)
	end
------程序生成区块结束 node_1464677462_1571110484-------
------程序生成区块开始 node_747623302_1571110867-------
    local width = CELL_WIDTH
    local height = 420
    local cellWidth = CELL_WIDTH
    local cellHeight = 38
    local node_747623302_1571110867 = UI.TableView:create({}, width , height)
    node_747623302_1571110867:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    node_747623302_1571110867:setDelegate()
    node_747623302_1571110867:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    node_747623302_1571110867:setBounceable(true)
    node_747623302_1571110867:init()
    node_747623302_1571110867:onUpdateCellSize(function (tableview, idx)
        local luaIdx = idx + 1
        return cellWidth, self:getHeightForIndex(luaIdx)
    end)
    node_747623302_1571110867:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell == nil then
            cell = UI.TableViewCell:create()
    
            local CellView = require "app.modules.guildlog.GuildLogInfoCellView"
            local cellView = CellView:create()
            cellView.__panel = self.__panel
            cellView:init()
            cellView:setName("cellView")
            cellView:leftBottom(0, 0)
            cell:addChild(cellView)
        end

        local cellView = cell:getChildByName("cellView")
        if (cellView) then
            local cellHegiht = self:getHeightForIndex(luaIdx)
            cell:setContentSize(cellWidth, cellHegiht)
            cellView:setSize(cellWidth, cellHegiht)
            cellView:updateData(self._data[luaIdx])
        end
        return cell
    end)
    node_747623302_1571110867:onUpdateCellNumbers(function ()
        return #self._data
    end)
    node_747623302_1571110867:reloadData()
    node_747623302_1571110867.__uiComposerID = "747623302_1571110867"
    addChildAuto(self._layoutUU, node_1464677462_1571110484, node_747623302_1571110867, "layout_747623302_1571110867")
    self._tableView = node_747623302_1571110867 --暴露名字至self
------程序生成区块结束 node_747623302_1571110867-------
------程序生成区块开始 node_2078953089_1571326426-------
    local node_2078953089_1571326426 = UI.Image:create()
    node_2078953089_1571326426:init('ui_information_banner_background2.png')
    node_2078953089_1571326426.__uiComposerID = "2078953089_1571326426"
    node_2078953089_1571326426:rotate(180)
    addChildAuto(self._layoutUU, node_1464677462_1571110484, node_2078953089_1571326426, "layout_2078953089_1571326426")
------程序生成区块结束 node_2078953089_1571326426-------
------程序生成区块开始 node_673957642_1571113081-------
    local node_673957642_1571113081 = UI.Text:create()
    node_673957642_1571113081:init(LanguageManager:getInstance():getLocalString(1113000) --[["还没有日志"]], UI.SYS_FONT, 14, {r = 193, g = 193, b = 193})
    node_673957642_1571113081:autoAdapt()
    node_673957642_1571113081.__uiComposerID = "673957642_1571113081"
    addChildAuto(self._layoutUU, self, node_673957642_1571113081, "layout_673957642_1571113081")
    self._emptyLabel = node_673957642_1571113081 -- 暴露名字至self
------程序生成区块结束 node_673957642_1571113081-------
end


function GuildLogView:onUpdateView()
    self._data = clone(mvc.guildLogModel:getLogForDisplay())
    self._tableView:reloadData()

    if (not self._data or #self._data == 0) then
        self._emptyLabel:show()
    else
        self._emptyLabel:hide()
    end
end

function GuildLogView:bindModel()

end


function GuildLogView:unbindModel()

end

function GuildLogView:getHeightForIndex(idx)
    local entry = self._data[idx]
    if (entry) then
        -- 时间节点高度固定38
        if (entry.type == mvc.guildLogModel.LogContentTypes.TIME) then
            return 38
        -- 其他节点按内容改变大小
        else
            if (not self._testLabel) then
                local CellView = require "app.modules.guildlog.GuildLogInfoCellView"
                self._testLabel = UI.Text:create()
                self._testLabel:init("", UI.SYS_FONT, 14, {r = 193, g = 193, b = 193})
                self._testLabel:setWidth(CellView.TEXT_WIDTH)
                self._testLabel:retain()
            end

            self._testLabel:setText(entry.content)
            self._testLabel:autoAdapt()
            return self._testLabel._height + 12
        end
    end
    return 0
end





return GuildLogView













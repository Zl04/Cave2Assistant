-- DreamTaskLayer.lua
-- Author:ydli
-- 2019年03月08日
-- Using:梦境任务界面
UI = UI or {}
local DreamTaskLayer = class("DreamTaskLayer", UI.HWBtnComponent)
UI.DreamTaskLayer = DreamTaskLayer
require"app.ui.dream.task.DreamTaskCell"

local size = cc.size(467, 427)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_dream_common.plist"
}
----表情界面
--构造函数(必备)
function DreamTaskLayer:ctor(spriteID)
    --窗口大小
    DreamTaskLayer.super.ctor(self, 0, COM_RES_LIST, size.width, size.height)
    self.spriteID = spriteID
    self.taskList = MasterDataManager:getDreamData().bossInfos or {}
    self:setTouchEnable(true);
    self:setInterceptTouches(false)
    self:registerListener()
    self:showLucencyLight()
end

--虚构函数,destroy时调用(必备)
function DreamTaskLayer:dtor()
    DreamTaskLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化(必备)
function DreamTaskLayer:init()
    DreamTaskLayer.super.init(self)
    local bg = UI.Image:create()
    bg:init("ui_dreamword_task_bg.png")
    bg:center()
    self:addChild(bg)

    local title = UI.Text:create()
    title:init(UI.TEXT_1212265, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_51_51_51)
    title:centerUp(24)
    bg:addChild(title)

     -- 列表
    local taskTableView = cc.TableView:create(cc.size(425, 330))
    taskTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    taskTableView:setPosition(16, 27)
    taskTableView:setDelegate()
    taskTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    bg:addChild(taskTableView, 20)

    taskTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    taskTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    taskTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    taskTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    taskTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    taskTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    taskTableView:registerScriptHandler(handler(self,self.tableCellWillRecycle),cc.TABLECELL_WILL_RECYCLE)
    taskTableView:initScrollBar(false)
    taskTableView:setScrollBarWidth(6)
    taskTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    taskTableView:reloadData()
end

-- 模版函数：初始化组建的视图(必备)
function DreamTaskLayer:onInitView()
end

-- 模版函数：更新组建的视图(必备)
function DreamTaskLayer:onUpdateView()
end

-- 注册监听事件(可选)
function DreamTaskLayer:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchOutSizeEvent)
end

-- 注销监听事件(可选)
function DreamTaskLayer:unRegisterListener()
   
end

-- 点击外部区域的处理器(关闭)(可选)
function DreamTaskLayer:onTouchOutSizeEvent()
    self:close()
end

function DreamTaskLayer:open()
    self:setAnchorPoint(0.5, 0.5)
    local scaleAction = cc.ScaleTo:create(0.15, 1, 1)
    local easeScaleAction = cc.EaseOut:create(scaleAction, 4)
    self:runAction(easeScaleAction)
end

function DreamTaskLayer:numberOfCellsInTableView(table)
    return #self.taskList
end


function DreamTaskLayer:scrollViewDidScroll(view)
end

function DreamTaskLayer:scrollViewDidZoom(view)
    
end

function DreamTaskLayer:tableCellTouched(tableView,cell)

end

function DreamTaskLayer:tableCellWillRecycle(tableView,cell)
    if cell ~= nil then
        cell:removeChildByName("cell");
    end
end

function DreamTaskLayer:cellSizeForTable(table,idx)
    return 411, 99
end

function DreamTaskLayer:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    if cell == nil then
        cell = cc.TableViewCell:new()
    else
        cell:removeChildByName("cell");
    end
    xpcall(function()
         -- dump(taskdata:getRewardGoodsArr())
        local data = self.taskList[idx + 1]
        local taskCell = UI.DreamTaskCell:create(idx + 1, data)
        taskCell:setName("cell")
        taskCell:leftBottom(0, 0)
        cell:addChild(taskCell)
    end, 
    function(e) 
        printError("------------------------TaskLayer:tableCellAtIndex-----------------error")
    end, 1)  
    return cell
end

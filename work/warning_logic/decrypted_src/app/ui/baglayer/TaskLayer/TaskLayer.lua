--[[
    UI：任务界面 包含城镇任务和背包任务 
    Author：CZH
]]

local GameDataManager = require("app.game.GameDataManager")
require "app.ui.baglayer.TaskLayer.TaskScrollView"
require "app.ui.baglayer.TaskLayer.TaskBagSingleList"
local LanguageManager = require("app.game.LanguageManager")
local scheduler = cc.Director:getInstance():getScheduler() 

UI = UI or {}
local TaskLayer = class("TaskLayer", UI.HWBtnComponent)
UI.TaskLayer = TaskLayer

UI.TaskLayerType = {
    TASKLAYER_BAG = 1,  --  背包任务界面
    TASKLAYER_TOWN = 2, --  城镇任务界面
    TASKLAYER_PORT = 3, --  港口任务界面
}
local tasklayerType = UI.TaskLayerType

local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false
-- 尺寸
local COM_WIDTH = 852
local COM_HEIGHT = 534

local CELL_SIZE = cc.size(840, 134)

-- 背包资源
local COM_RES_LIST = {
}


-- 构造函数
function TaskLayer:ctor()
    TaskLayer.super.ctor(self, UIType.TASK_LAYER, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    -- self._scrollLayout = nil    -- 滑动列表的Layout
    self._taskscrollView = nil  -- 任务列表的滚动视图
    self._taskUIType = nil      -- 任务界面的类型  城镇类型  背包类型
    self._taskData = nil        -- 任务数据
    self._newTaskFlag = false
    self._isCanClickTableView = true
    self._haveDataArr = {}
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.completeTask) 
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_REFRESH_ALL_TASK, self, self.flagNewTask) 
    
end

--析构函数
function TaskLayer:dtor()
    TaskLayer.super.dtor(self)
    self._isCanClickTableView = true
    self._newTaskFlag = false
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.completeTask) 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_REFRESH_ALL_TASK, self, self.flagNewTask) 
end

-- 初始化
function TaskLayer:init(type,data)
    self._taskUIType = type 
    self._taskData = data

    TaskLayer.super.init(self)
    -- self:enableDebugDraw()
end

-- 初始化视图
function TaskLayer:onInitView()
    local notTaskText = UI.Text:create()
    notTaskText:init(LanguageManager:getInstance():getLocalString(1113061), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_40_40_45)
    notTaskText:center()
    self._notTaskText = notTaskText
    self._notTaskText:setVisible(false)
    self:addChild(notTaskText)

    self:_refreshTaskArry(self._taskData)
end

-- 更新视图
function TaskLayer:onUpdateView()   

    -- 列表
    local taskTableView = cc.TableView:create(cc.size(COM_WIDTH - 8, COM_HEIGHT - 15))
    taskTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    taskTableView:setPosition(0, 8)
    taskTableView:setDelegate()
    taskTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self:addChild(taskTableView, 20)

    taskTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    taskTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    taskTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    taskTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    taskTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    taskTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    taskTableView:registerScriptHandler(handler(self,self.tableCellWillRecycle),cc.TABLECELL_WILL_RECYCLE)
    self._taskScrollView = taskTableView
    if (self._taskUIType == tasklayerType.TASKLAYER_BAG) then 
        self._taskScrollView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    else
        self._taskScrollView:reloadData(true, 0.18, Game.TableCellInitTime, Game.TableCellAddTime)
    end
    taskTableView:initScrollBar(false)
    taskTableView:setScrollBarWidth(6)
    taskTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    local bottom = UI.Image:create()
    bottom:init("ui_bg_paper_mask1.png")
    bottom:centerBottom(0)
    self:addChild(bottom, 30)
end

function TaskLayer:completeTask()
    local oldSet = self._taskScrollView:getContentOffset()
    local oldNum = #self._haveDataArr
    self:refreshTaskArry()
    local newNum = #self._haveDataArr
    self._taskScrollView:reloadData(false)
    oldSet.y = oldSet.y + (oldNum - newNum) * CELL_SIZE.height
    self._taskScrollView:setContentOffset(oldSet)
end

function TaskLayer:refreshTaskArry()
    local taskData = GameDataManager:getInstance():getTaskArr()
    self:_refreshTaskArry(taskData)
end

function TaskLayer:flagNewTask()
    self._newTaskFlag = true
    if self._isCanClickTableView then
        local oldSet = self._taskScrollView:getContentOffset()
        local oldNum = #self._haveDataArr
        self:refreshTaskArry()
        local newNum = #self._haveDataArr
        self._taskScrollView:reloadData(false)
        oldSet.y = oldSet.y + (oldNum - newNum) * CELL_SIZE.height
        self._taskScrollView:setContentOffset(oldSet)
        self._newTaskFlag = false
    else 
        local oldSet = self._taskScrollView:getContentOffset()
        local oldNum = #self._haveDataArr
        self:refreshTaskArry()
        local newNum = #self._haveDataArr
        self._taskScrollView:reloadData(false)
        oldSet.y = oldSet.y + (oldNum - newNum) * CELL_SIZE.height
        self._taskScrollView:setContentOffset(oldSet)
        self._newTaskFlag = false
    end 
end


--tableview 相关
function TaskLayer:_refreshTaskArry(taskArry)
    -- 这里根据界面替换处理显示相关消息
    local haveDataArr = {}
    -- if not TaskDataManager:isUnlockShow() and self._taskUIType == tasklayerType.TASKLAYER_BAG then
    --     for k, taskData in pairs(taskArry) do 
    --         if taskData:isThread() then
    --             table.insert(haveDataArr, taskData)
    --         end
    --     end
    --     taskArry = haveDataArr
    --     haveDataArr = {}
    -- end
    
    for k, taskData in pairs(taskArry) do 
        -- add by zp CO-9351 公会任务可通过任务板领取(客户端)
        -- if(self._taskUIType ~= tasklayerType.TASKLAYER_BAG) then 
        --     if(taskData:isGuild() == false and not taskData:isDistortedSpace()) then
        --         if taskData:isHeroCave() then
        --             if (taskData:getIsReceived() == false) then
        --                 table.insert(haveDataArr, taskData)
        --             end
        --         else
        --             table.insert(haveDataArr, taskData)
        --         end
        --     end
        -- else
            -- 过滤掉已经领取的任务
            if (taskData:getIsReceived() == false) then
                table.insert(haveDataArr, taskData)
            end
        -- end
    end
    -- 排序
    local SceneManager = require("app.game.SceneManager")
    local isInCave = SceneManager:getInstance():isInFightScene()
    self._haveDataArr = mvc.quickSideBarModel:handleSortTask(haveDataArr, isInCave)

    if (not tolua.isnull(self._notTaskText)) then 
        if(self._haveDataArr and #self._haveDataArr > 0) then
            self._notTaskText:setVisible(false)
        else 
            self._notTaskText:setVisible(true)
        end
    end
end

function TaskLayer:numberOfCellsInTableView(table)
    return #self._haveDataArr
end


function TaskLayer:scrollViewDidScroll(view)
end

function TaskLayer:scrollViewDidZoom(view)
    
end

function TaskLayer:tableCellTouched(tableView,cell)

end

function TaskLayer:tableCellWillRecycle(tableView,cell)
    if cell ~= nil then
        cell:removeChildByName("cell");
    end
end

function TaskLayer:cellSizeForTable(table,idx)
    return CELL_SIZE.width, CELL_SIZE.height
end

function TaskLayer:tableCellAtIndex(tableView,idx)
    local cell = tableView:dequeueCell()
    if cell == nil then
        cell = cc.TableViewCell:new()
    else
        cell:removeChildByName("cell");
    end
    local taskdata = self._haveDataArr[idx + 1]
    xpcall(function()
         -- dump(taskdata:getRewardGoodsArr())
        local taskCell = UI.TaskBagSingleList:create(CELL_SIZE.width, CELL_SIZE.height, idx)
        taskCell:init(taskdata, self._taskScrollView, self._taskUIType )
        taskCell:setParentLayer(self)
        taskCell:setName("cell")
        taskCell:leftBottom(0, 0)
        cell:addChild(taskCell)
    end, 
    function(e) 
        printError("------------------------TaskLayer:tableCellAtIndex-----------------error")
    end, 1)  
    return cell
end

function TaskLayer:setCanClickTableView(isCanClickTableView, isReload)
    self._isCanClickTableView = isCanClickTableView
    if self._newTaskFlag and isReload then
        self:refreshTaskArry()
        self._taskScrollView:reloadData(false)
        self._newTaskFlag = false
    end
end

function TaskLayer:isCanClickTableView()
    return self._isCanClickTableView
end

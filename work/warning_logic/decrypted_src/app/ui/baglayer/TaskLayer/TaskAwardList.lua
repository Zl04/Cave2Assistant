--[[
    单个任务数据列表，由不同的TaskItemGrid组成
    AUTHOR:CZH
]]

require "app.ui.baglayer.InfoArea.PropInfoArea"
require "app.ui.baglayer.InfoArea.EquipmentInfoArea"
require "app.ui.baglayer.InfoArea.EquipmentPetInfoArea"
require "app.ui.baglayer.InfoArea.GemStoneInfoArea"
require "app.ui.baglayer.InfoArea.StarPrayInfoArea"
require "app.ui.baglayer.InfoArea.LevelBagInfoArea"
require "app.ui.baglayer.InfoArea.RandomBagInfoArea"
require "app.ui.baglayer.InfoArea.PetStoneInfoArea"
-- require "app.ui.baglayer.TaskLayer.TaskRewardGrid"
local GameDataManager = require("app.game.GameDataManager")
local size = cc.Director:getInstance():getWinSize()

UI = UI or {}
local TaskAwardList = class("TaskAwardList",UI.HWBtnComponent)
UI.TaskAwardList = TaskAwardList

local RES_LIST = {
} 

-- 道具详情的touch事件处理    
local function onPropInfoAreaTouchHandler(self)
    if(self._propInfoArea) then
        self._propInfoArea:close()
        self._propInfoArea = nil 
        if(self._selectItem ) then 
            self._selectItem:endselectItem()
        end
    end 
    if(self._materialInfoArea) then
        self._materialInfoArea:close()   
        self._materialInfoArea = nil 
        if(self._selectItem ) then 
            self._selectItem:endselectItem()
        end
    end
    if(self._equipmentInfoArea) then
        self._equipmentInfoArea:close() 
        self._equipmentInfoArea = nil 
        if(self._selectItem ) then 
            self._selectItem:endselectItem()
        end
    end
end

function TaskAwardList:ctor()

    TaskAwardList.super.ctor(self,UIType.TASK_AWARD_LIST,RES_LIST,0,0)
    self._taskListView = nil 
    self._data = nil
    self._bagGridList = nil 
    self._propInfoArea = nil 
    self._materialInfoArea = nil    -- 材料详情
    self._equipmentInfoArea = nil   -- 装备详情
    self._layer = nil 
    self._selectItem = nil 
end

function TaskAwardList:dtor()
    self._data = nil
    self._taskListView = nil 
    self._selectItem = nil 
    TaskAwardList.super.dtor(self)
end

function TaskAwardList:init(layer,data)
    self._layer = layer
    self._data = data
    TaskAwardList.super.init(self)
end

function TaskAwardList:onInitView(data)
    local data = self._data
    
    self:initTaskItemGrid()
    self:onUpdateTaskItemGrid(data)
    
end


function  TaskAwardList:initTaskItemGrid(data)

    local data = self._data
    self.taskList = UI.ListView:create()
    self.taskList:init(UI.GoodsGrid,#data,1,78,79,15,0,0,true, false)
    -- self.taskList:leftUp(80,65)
    self:addChild(self.taskList)
    self._taskListView = self.taskList
    self.taskList:setSwallowTouches(false)
end

-- 更新列表数据
function TaskAwardList:onUpdateTaskItemGrid(data)
    local bagList = self._taskListView:getGridList()
    for i = 1 ,#bagList do  
        if(self._data[i]) then
            self._data[i]:setIsNew(false)
            bagList[i]:setData(self._data[i]) 
            bagList[i]:updateView()
            bagList[i]:hideFlagIcon()
            -- bagList[i]:hideBG()
            bagList[i]:setTouchEnable(true)
            bagList[i]:addEventListener(UIEvent.COMPONENT_CLICK, self, function(target, sender, touchPosition)
                bagList[i]:onShowInfoAreaHandler(true)
            end)
        end
    end
end

-- 数据驱动更新视图
function TaskAwardList:onUpdateView(data)
   print("TaskAwardList:onUpdateView")
end






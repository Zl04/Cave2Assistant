-- DebugLogLayer.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:系统日志输出 

local DebugLogLayerUtil = require("app.ui.debugLogLayer.debugLogLayerUtil")

UI = UI or {}

local DebugLogLayer = class("DebugLogLayer", UI.HWBtnComponent)
UI.DebugLogLayer = DebugLogLayer

-- 资源列表(必备)
local COM_RES_LIST = {
}


--构造函数(必备)
function DebugLogLayer:ctor()
	--窗口大小
    DebugLogLayer.super.ctor(
    self,UIType.DEBUG_LOG_LAYER,
    COM_RES_LIST,
    400,
    UI.size.height - 100
    )
    self.mSchedulerID = 0;
    self.rootLayer = nil;           --root节点

    self.mData = clone(DebugLogLayerUtil:getInstance():getData())

    self:setTouchEnable(true);
    self:setInterceptTouches(false);
    self:init();
    self:registerListener();

    
end

--虚构函数,destroy时调用(必备)
function DebugLogLayer:dtor()
    self:unRegisterListener()

    local scheduler=cc.Director:getInstance():getScheduler()
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
end

-- 初始化(必备)
function DebugLogLayer:init()
    DebugLogLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function DebugLogLayer:onInitView()
    DebugLogLayerUtil:getInstance().rootLayer = self
	--root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(cc.p(0,0))
    self.rootLayer:setContentSize(cc.size(self._width,self._height))
    self:addChild(self.rootLayer)

	--在这里填写界面

    self.mPicBG = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_character.png")
    self.mPicBG:setContentSize(cc.size(400,UI.size.height - 100))
    self.mPicBG:setAnchorPoint(0,0)
    self.mPicBG:setPosition(cc.p(0,0))
    self.rootLayer:addChild(self.mPicBG)
	
    self.m_pItemTableView = cc.TableView:create(cc.size(360, UI.size.height - 140))
    self.m_pItemTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.m_pItemTableView:setPosition(cc.p(20,20))
    self.m_pItemTableView:setDelegate()
    self.m_pItemTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.rootLayer:addChild(self.m_pItemTableView)
    --registerScriptHandler functions must be before the reloadData funtion
    self.m_pItemTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.m_pItemTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)

    self.m_pItemTableView:reloadData()


    self:setSwallowTouches(false)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.onTouchBeganHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onTouchMovedHandler)


    self.btnClose = UI.Button:create()
    self.btnClose:init("ui_btn_button_cancel_0.png","ui_btn_button_cancel_0.png")
    self.btnClose:setPos(self._width,0)
    self.rootLayer:addChild(self.btnClose)
    self.btnClose:addEventListener(UIEvent.BUTTON_CLICK, self, self.onClose)

    self.btnRefresh = UI.Button:create()
    self.btnRefresh:init("ui_btn_refresh_0.png","ui_btn_refresh_1.png","ui_btn_refresh_2.png")
    self.btnRefresh:setPos(self._width,50)
    self.rootLayer:addChild(self.btnRefresh)
    self.btnRefresh:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRefresh)

end

function DebugLogLayer:onClose()
    self:close()
end

function DebugLogLayer:onRefresh()
    errTip = false
    self.mData = clone(DebugLogLayerUtil:getInstance():getData())
    self.m_pItemTableView:reloadData()
end


function DebugLogLayer:numberOfCellsInTableView(table)
    
    return #self.mData
end

function DebugLogLayer:cellSizeForTable(table,idx)
    return 360,30
end

function DebugLogLayer:tableCellAtIndex(tableView,idx)
    --print("FightResult:tableCellAtIndex"..idx)
    local cell = tableView:dequeueCell()
    xpcall(function()
        if nil == cell then
            cell = cc.TableViewCell:new()
            local txt = cc.Label:createWithSystemFont(self.mData[idx], UI.FONT_ARIAL, UI.FONT_CONTENT,cc.size(360,30))

            txt:setPosition(0,0)
            txt:setAnchorPoint(0,0)

            txt:setName("cell")
            cell:addChild(txt)
        else
            local obj = cell:getChildByName("cell");
            obj:setString(self.mData[idx])
        end
    end, 
    function(e) 
        printError("--------------------DebugLogLayer:tableCellAtIndex---------------------error")
    end, 1) 
    return cell;
end

-- 列表点击开始处理器
function DebugLogLayer:onTouchBeganHandler(obj, touchPosition)
    self.touchPos = touchPosition
end

-- 列表点击开始处理器
function DebugLogLayer:onTouchMovedHandler(obj, touchPosition)
    local posX,posY = self.rootLayer:getPositionX(),self.rootLayer:getPositionY()
    self.rootLayer:setPosition(posX + (touchPosition.x - self.touchPos.x) , posY + (touchPosition.y - self.touchPos.y))
    self.touchPos = touchPosition
end


function DebugLogLayer:schedulerTime()
    self.m_pItemTableView:reloadData()
end

-- 模版函数：更新组建的视图(必备)
function DebugLogLayer:onUpdateView()

end



-- 注册监听事件(可选)
function DebugLogLayer:registerListener()
end


-- 注销监听事件(可选)
function DebugLogLayer:unRegisterListener()
end




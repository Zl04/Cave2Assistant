-- ChatBlackListLayer.lua
-- Author:ydli
-- 2018年07月13日
-- Using:聊天黑名单界面
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local ChatBlackListLayer = class("ChatBlackListLayer", UI.HWBtnComponent)
UI.ChatBlackListLayer = ChatBlackListLayer

local winSize = cc.Director:getInstance():getWinSize()
local size = cc.size(410, winSize.height)
-- 资源列表(必备)
local COM_RES_LIST = {
  
}
--构造函数(必备)
function ChatBlackListLayer:ctor(width, height)
    size.width = width
    size.height = height
    ChatBlackListLayer.super.ctor(
    self, 0,
    COM_RES_LIST,
    size.width,    
    size.height
    )
    self.rootLayer = nil;           --root节点
    self.actLock = false
    self.blackList = Game.ChatManager:getInstance():getAllShieldPlayer()
    self:init();
    self:registerListener()
    self:setTouchEnable(true)
    -- self:enableDebugDraw()
end

--虚构函数,destroy时调用(必备)
function ChatBlackListLayer:dtor()
    ChatBlackListLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function ChatBlackListLayer:init()
    ChatBlackListLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function ChatBlackListLayer:onInitView()
    local tableView = cc.TableView:create(cc.size(size.width + 8, size.height - 2))
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:setPosition(7,0)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:initScrollBar(false)
    tableView:setScrollBarWidth(4)
    tableView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    self:addChild(tableView, 20)

    tableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    tableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    tableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    tableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    tableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    tableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    tableView:registerScriptHandler(handler(self,self.tableCellWillRecycle),cc.TABLECELL_WILL_RECYCLE)
    self.tableView = tableView
    tableView:reloadData()
end

-- 模版函数：更新组建的视图(必备)
function ChatBlackListLayer:onUpdateView()
   
end

function ChatBlackListLayer:numberOfCellsInTableView(table)
    return #self.blackList
end

function ChatBlackListLayer:scrollViewDidScroll(view)
end

function ChatBlackListLayer:scrollViewDidZoom(view)
    
end

function ChatBlackListLayer:tableCellTouched(tableView,cell)
    print("---ChatBlackListLayer:tableCellTouched(tableView,cell)-----")
     -- bg:setTouchEnable(true)
    local button = cell:getChildByName("Layout"):getChildByName("DeleteBtn")
    local pk = button:getTag()
    local playerData = Game.ChatManager:getInstance():getShieldPlayerByPk(pk)
    if playerData then
        local postion = self:convertToNodeSpace(cell:convertToWorldSpace(cc.p(200, 12)))
        local talkTip = UI.TalkTips:createTips(TalkTipsType.FromBlackListLayer, playerData, postion.x, postion.y, function()
            Game.ChatManager:getInstance():OnPersonalChat(playerData, false)
        end)
        talkTip:setName("TALK_TIP")
        self:addChild(talkTip, 100)
        talkTip:adjustPostion()
    end
end

function ChatBlackListLayer:tableCellWillRecycle(tableView,cell)
    -- print("---AchievementLayer:tableCellWillRecycle------")
end

function ChatBlackListLayer:cellSizeForTable(table,idx)
    return size.width, 54
end

function ChatBlackListLayer:tableCellAtIndex(tableView,idx)
    print("ChatBlackListLayer:tableCellAtIndex", idx)
    local cell = tableView:dequeueCell()
    if cell == nil then
        cell = cc.TableViewCell:new()
    end
    
    xpcall(function()
        local data = self.blackList[idx + 1]
        local layout = cell:getChildByName("Layout")
        if layout == nil then
            layout = self:createCells(data)
            layout:setName("Layout")
            cell:addChild(layout)
        end
        if data then
            local name = layout:getChildByName("Bg"):getChildByName("NickName")
            name:setText(data.nickName)

            local button = layout:getChildByName("DeleteBtn")
            button:setTag(data.pk)
        end
        layout:setTag(idx)
    end, 
    function(e) 
        printError("------------------------ChatBlackListLayer:tableCellAtIndex-----------------error")
    end, 1)  
    return cell
end

-- 注册监听事件(可选)
function ChatBlackListLayer:createCells(playerData)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(size.width, 50)
    layout:leftBottom(1, 0)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_chat_translation_box.png")
    bg:setCapInsets(CCRectMake(9,9,1,1))
    bg:setContentSize(320, 53)
    bg:setAnchorPoint(0, 0)
    bg:setPosition(0, 0)
    bg:setName("Bg")
    layout:addChild(bg)

    local name = UI.Text:create()
    name:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
    name:center()
    bg:addChild(name)
    name:setName("NickName")

    local button = UI.Button:create()
    button:init("ui_chat_btn_no.png")
    button:centerRight(15)
    button:setName("DeleteBtn")
    button:setTag(0)
    layout:addChild(button)
    button:addEventListener(UI.Event.BUTTON_CLICK, self, self.removeClick)
    -- layout:enableDebugDraw()
    return layout
end

function ChatBlackListLayer:removeClick(sender, touchPostion)
    if self.actLock then
        return
    end
    local pk = sender:getTag()
    Game.ChatManager:getInstance():removeShieldPlayer(pk)
    for k, v in ipairs(self.blackList) do
        if v.pk == pk then
            table.remove(self.blackList, k)
        end
    end
    self.actLock = true
    local layout = sender:getParent()
    self.tableView:removeCellAtIndexAndPlayAction(layout:getTag(), 0.2)
    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        self.actLock = false
    end, 0.2)
end

function ChatBlackListLayer:scrollToBottom()
    if self.tableView then
        self.blackList = Game.ChatManager:getInstance():getAllShieldPlayer()
        self.tableView:reloadData(false)
    end
end

-- 注册监听事件(可选)
function ChatBlackListLayer:registerListener()
end

-- 注销监听事件(可选)
function ChatBlackListLayer:unRegisterListener()
end

function ChatBlackListLayer:initDiaLogLayer()
     self.blackList = Game.ChatManager:getInstance():getAllShieldPlayer()
     self.tableView:reloadData(false)
end

function ChatBlackListLayer:addHeightByIndex()
end

function ChatBlackListLayer:checkTranslateMode()
end
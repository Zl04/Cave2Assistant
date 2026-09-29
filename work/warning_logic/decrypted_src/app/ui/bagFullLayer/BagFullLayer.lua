-- BagFullLayer.lua
-- Author:ODEI
-- 2017年8月24日
-- Using:背包满 

local ProtobufUtil = require "utils.ProtobufUtil"
require("app.ui.bagFullLayer.BagFullCell")
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local scheduler = cc.Director:getInstance():getScheduler()

UI = UI or {}

local BagFullLayer = class("BagFullLayer", UI.HWBtnComponent)
UI.BagFullLayer = BagFullLayer or {}

local winSize = cc.Director:getInstance():getWinSize()

local _WIDTH = 860
local _HEIGHT = 190

-- 资源列表(必备)
local COM_RES_LIST = {
}


--构造函数(必备)
function BagFullLayer:ctor()
    -- print("----------BagFullLayer:ctor()")
    --窗口大小
    BagFullLayer.super.ctor(
    self,UIType.BAG_FULL_LAYER,
    COM_RES_LIST,
    _WIDTH,    
    _HEIGHT
    )
    self.rootLayer = nil;           --root节点

    self.mData = MasterDataManager:getFullBagData()
    self.state = 0      --0不显示,1只显示一个,2拓展


    self:setTouchEnable(true);
    self:setInterceptTouches(false);
    
    self:init();

end

--虚构函数,destroy时调用(必备)
function BagFullLayer:dtor()
    BagFullLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function BagFullLayer:init()
    BagFullLayer.super.init(self)
    self:setEatHWBackEvent(false)
end

-- 模版函数：初始化组建的视图(必备)
function BagFullLayer:onInitView()
    --root节点
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:setSize(_WIDTH,_HEIGHT)
    self.rootLayer:leftBottom(0, 0)
    self:addChild(self.rootLayer)

    self.itemLayer = UI.Layout:create()
    self.itemLayer:init()
    self.itemLayer:setSize(_WIDTH, _HEIGHT)
    self.itemLayer:leftBottom(25, 0)
    self.rootLayer:addChild(self.itemLayer)

    self.m_pItemTableView = cc.TableView:create(cc.size(810,190))
    self.m_pItemTableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    self.m_pItemTableView:setPosition(cc.p(25, 0))
    self.m_pItemTableView:setDelegate()
    self.m_pItemTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.rootLayer:addChild(self.m_pItemTableView)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.m_pItemTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)

    local _picNumBG = UI.Image:create()
    _picNumBG:init("ui_information_banner_prompt.png")
    _picNumBG:leftUp(25 -6, -6)
    self.rootLayer:addChild(_picNumBG,200)
    self._picNumBG = _picNumBG

    local txtNum = UI.Text:create()
    txtNum:init(tostring(#self.mData),UI.FONT_STANDARD,UI.FONT_SIZE_14PX, UI.FONT_COLOR_255_255_255)
    txtNum:center()
    _picNumBG:addChild(txtNum)
    self._txtNum = txtNum

    local btnArrow = UI.Button:create()
    btnArrow:init("ui_btn_arrow_up_0.png", "ui_btn_arrow_up_1.png")
    btnArrow:addEventListener(UIEvent.BUTTON_CLICK, self, self.onArrow)
    btnArrow:centerLeft(-30)
    btnArrow:rotate(270)
    self.rootLayer:addChild(btnArrow, 10000)
    self._btnArrow = btnArrow

    self._btnArrow:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.5,cc.p(-10,0)),cc.MoveBy:create(0.5,cc.p(10,0)))))
end

-- 模版函数：更新组建的视图(必备)
function BagFullLayer:onUpdateView()
    -- print("BagFullLayer:onUpdateView")
    self:refreshItemLayer()

    if #self.mData > 0 then
        self:onShowOneBagFullLayer()
    else
        self:onHideBagFullLayer()
    end
    self:refreshNum()
    self:registerListener();
end

--点击箭头事件
function BagFullLayer:onArrow()
    if self.state == 2 then
        self:onShowOneBagFullLayer()
    elseif self.state == 1 then
        self:onShowAllBagFullLayer()
        self.m_pItemTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    end
end

--隐藏
function BagFullLayer:onHideBagFullLayer()
    -- print("BagFullLayer:onHideBagFullLayer")
    self.state = 0

    print(self:getPositionX(),self:getPositionY())
    self:stopAllActions()
    self:runAction(cc.MoveTo:create(0.2,cc.p(winSize.width + 50 + Avalon.issUtil:getWidthOffset(),self:getPositionY())))
end



--显示所有
function BagFullLayer:onShowAllBagFullLayer()
    print("BagFullLayer:onShowAllBagFullLayer")
    self.state = 2
    self._btnArrow:rotate(90)
    self._btnArrow:centerLeft(-10)
    local width = 0
    if #self.mData == 0 then
        width = 0
    elseif #self.mData >= 5 then
        width = 810
    elseif #self.mData == 1 then
        width = 188
    else
        width = 171 * #self.mData + 25
    end
    self:stopAllActions()
    self:runAction(cc.MoveTo:create(0.2,cc.p(winSize.width - width - Avalon.issUtil:getWidthOffset(),self:getPositionY())))

    self:changeLayer()
    self._picNumBG:runAction(cc.ScaleTo:create(0.2,0))
end

--显示一个
function BagFullLayer:onShowOneBagFullLayer()
    -- print("BagFullLayer:onShowOneBagFullLayer")
    self.state = 1
    self._btnArrow:rotate(270)
    self._btnArrow:centerLeft(-25)

    self:changeLayer()
    self._picNumBG:runAction(cc.Sequence:create(cc.DelayTime:create(0.2),cc.ScaleTo:create(0.1,1)))
    self:stopAllActions()
    self:runAction(cc.MoveTo:create(0.2,cc.p(winSize.width - 185 - Avalon.issUtil:getWidthOffset(),self:getPositionY())))
end

--刷新数量
function BagFullLayer:refreshNum()
    if(not tolua.isnull(self._txtNum)) then
        self._txtNum:setText(tostring(#self.mData))
    end

    if #self.mData <= 1 then
        self._picNumBG:setVisible(false)
        self._btnArrow:setVisible(false)
    else
        self._picNumBG:setVisible(true)
        self._btnArrow:setVisible(true)
    end


end

--切换显示layer
function BagFullLayer:changeLayer()
    if #self.mData > 5 and self.state == 2 then
        self.itemLayer:setVisible(false)
        self.itemLayer:removeAllChildren(true)
        self.m_pItemTableView:setVisible(true)

        self.itemLayer:setZOrder(99)
        self.m_pItemTableView:setZOrder(100)
    else
        self.itemLayer:setVisible(true)
        self.m_pItemTableView:setVisible(false)
        self:refreshItemLayer()

        self.itemLayer:setZOrder(100)
        self.m_pItemTableView:setZOrder(99)
    end
end

--刷新itemLayer
function BagFullLayer:refreshItemLayer()
    self.itemLayer:removeAllChildren()

    for i = 1,#self.mData do
        if i <= 5 then
            local pArchiveCell = UI.BagFullCell:create(self.mData[i],i - 1)
            pArchiveCell:setName("cell")
            pArchiveCell:leftBottom(171 * (i - 1), -190)
            self.itemLayer:addChild(pArchiveCell)
        end
    end
end


function BagFullLayer:numberOfCellsInTableView(table)
    return #self.mData
end


function BagFullLayer:tableCellTouched(table,cell)
    -- print("BagFullLayer:tableCellTouched",cell:getIdx())
end

function BagFullLayer:cellSizeForTable(table,idx)
    return 169,190
end

function BagFullLayer:tableCellAtIndex(tableView,idx)
    -- print("BagFullLayer:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    xpcall(function()
        if nil == cell then
            cell = cc.TableViewCell:new()
            local pArchiveCell = UI.BagFullCell:create(self.mData[idx + 1],idx)
            pArchiveCell:setName("cell")
            -- pArchiveCell:leftUp(0, 0)
            cell:addChild(pArchiveCell)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self.mData[idx + 1],idx)
        end
    end, 
    function(e) 
        printError("--------------------BagFullLayer:tableCellAtIndex---------------------error")
    end, 1) 
    return cell;
end


--初始化数据
function BagFullLayer:initData()
    -- print("BagFullLayer:initData")
    self.mData = MasterDataManager:getFullBagData()
    if #self.mData == 0 then
        self:onHideBagFullLayer()
    elseif #self.mData == 1 then
        self:onShowOneBagFullLayer()
    end
end

--添加数据
function BagFullLayer:insterData(data)
    print("BagFullLayer:insterData",self.state,self:getPositionX())
    if #self.mData <= 5 then
        self.m_pItemTableView:reloadData()
    else
        self.m_pItemTableView:insertCellAtIndex(#self.mData - 1)
    end

    self:refreshNum()
    self:changeLayer()

    if self.state == 0 then
        self:onShowOneBagFullLayer()
    elseif self.state == 2 then

        local width = 0
        if #self.mData == 0 then
            width = 0
        elseif #self.mData >= 5 then
            width = 810
        elseif #self.mData == 1 then
                width = 185
        else
            width = 160 * #self.mData + 10
        end
        self:stopAllActions()
        self:runAction(cc.MoveTo:create(0.2,cc.p(winSize.width - width - Avalon.issUtil:getWidthOffset(),self:getPositionY())))
    end
end

--删除数据
function BagFullLayer:removeData()
    print("BagFullLayer:removeData",self.state,self:getPositionX())
    local pos = self.m_pItemTableView:getContentOffset()
    self.m_pItemTableView:reloadData()

    local width = self.m_pItemTableView:getContentSize().width;
    local viewWidth = self.m_pItemTableView:getViewSize().width;

    if -pos.x > width - viewWidth then
        pos.x = -(width - viewWidth)
    end 

    if pos.x > 0 then
        pos.x = 0
    end

    self.m_pItemTableView:setContentOffset(pos)
    self:refreshNum()
    self:changeLayer()

    if #self.mData == 0 then
        self:onHideBagFullLayer()
    else
        if self.state == 2 then
            local width = 0
            if #self.mData == 0 then
                width = 0
            elseif #self.mData >= 5 then
                width = 810
            elseif #self.mData == 1 then
                width = 185
            else
                width = 160 * #self.mData + 10
            end
            self:stopAllActions()
            self:runAction(cc.MoveTo:create(0.2,cc.p(winSize.width - width - Avalon.issUtil:getWidthOffset(),self:getPositionY())))
        elseif self.state == 1 then
            self:stopAllActions()
            self:runAction(cc.MoveTo:create(0.2,cc.p(winSize.width - 185 - Avalon.issUtil:getWidthOffset(),self:getPositionY())))
        end
    end
end

function BagFullLayer:stopFullBagTimeOut()
    -- print("BagFullLayer:stopFullBagTimeOut")
    self:setVisible(false)
    self.rootLayer:leftBottom(winSize.width + 10, 0)
end

function BagFullLayer:resumeFullBagTimeOut()
    -- print("BagFullLayer:resumeFullBagTimeOut")
    self:setVisible(true)
    self.rootLayer:leftBottom(0, 0)
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self, tips, touchPosition)
    if self.state == 2 then
        self:onShowOneBagFullLayer()
    end
end

-- 注册监听事件(可选)
function BagFullLayer:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_FULLBAG_INIT, self, self.initData)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_FULLBAG_INSERT, self, self.insterData)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_FULLBAG_REMOVE, self, self.removeData)
    --进入战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.stopFullBagTimeOut)
    --退出战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.resumeFullBagTimeOut)
    --显示复活界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE, self, self.stopFullBagTimeOut)
    --复活成功
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.resumeFullBagTimeOut)

    --进入答题
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ANSWER_IS_SHOWING, self, self.stopFullBagTimeOut)
    --退出答题
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ANSWER_IS_CLOSED, self, self.resumeFullBagTimeOut)
end


-- 注销监听事件(可选)
function BagFullLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_FULLBAG_INIT, self, self.initData)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_FULLBAG_INSERT, self, self.insterData)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_FULLBAG_REMOVE, self, self.removeData)

    --进入战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.stopFullBagTimeOut)
    --退出战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.resumeFullBagTimeOut)

    --显示复活界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE, self, self.stopFullBagTimeOut)
    --复活成功
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.resumeFullBagTimeOut)

    --进入答题
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ANSWER_IS_SHOWING, self, self.stopFullBagTimeOut)
    --退出答题
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ANSWER_IS_CLOSED, self, self.resumeFullBagTimeOut)
end

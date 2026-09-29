-- DropDownList.lua
-- Author:ydli
-- 2017年8月23日
-- Using:下拉框 实现

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local DropDownList = class("DropDownList", UI.HWBtnComponent)
UI.DropDownList = DropDownList

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local DEBUG_DRAW = false
local size = cc.size(200, 60)
-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
-- 背包资源
local COM_RES_LIST = {

}

-- 图片名字
local TEST_PANEL_SPRITE = {
    EDITE_NORMAL = "ui_goods_button_dustbin_0.png",
    BUTTON_END_NORMAL = "ui_goods_button_dustbin_0.png",
    BUTTON_END_ACTIVE = "ui_goods_button_dustbin_1.png",
}

-- 构造函数
function DropDownList:ctor()
    DropDownList.super.ctor(self,UIType.DROP_DOWN_LIST, COM_RES_LIST, size.width, size.height)
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.mRect = nil;               --判断区域框

    self:setTouchEnable(true);
    -- self:setInterceptTouches(true);
    -- self.mainMenu = nil --下拉列表选项的集合   
    -- self.showLabel = nil --显示选中的结果   
    self.selectLabels = self.selectLabels or {}  --下拉列表label  
    self.bgLayers = self.bgLayers or {} --用于设置 背景  
    self.isShowMenu = false  --是否显示了下拉列表  
    self.lastSelectedIndex = 0 --选中下拉列表的index
    self.direction = 1 -- 1表示向上 -1 表示向下
    self:registerListener()
end

-- 析构函数
function DropDownList:dtor()
    DropDownList.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化
function DropDownList:init(text, _size, direction, nodeNumber)
     size = _size
    self.direction = direction
    DropDownList.super.init(self)
    local scrollHeight = 400
    if scrollHeight > size.height * nodeNumber then
        scrollHeight = size.height * nodeNumber
    end
    self.scrollView = UI.ScrollView:create()
    self.scrollView:init(0, 0, 0, 0)
    self.scrollView:setSize(size.width, scrollHeight)
    self.scrollView:leftBottom(- winSize.width, size.height)
    self.scrollView:setScrollBarEnabled(true)
    -- scrollView:setTouchEnable(true)
    -- scrollView:setRestorePositiion(false)
 
    local bgLayer = cc.LayerColor:create(cc.c4b(255,248,220,255), size.width, scrollHeight)
    self.scrollView:addChild(bgLayer, 1)
    self.mainMenu = UI.Layout:create()
    self.mainMenu:init()
    self.mainMenu:setSize(size.width, size.height * nodeNumber)
    self.scrollView:addInnerNode(self.mainMenu, 2)

    self.showLabel = UI.Button:create()
    self.showLabel:init()
    self.showLabel:setText(text)
    self.showLabel:setTextFont(UI.FONT_ARIAL, 28, cc.c4b(255,215,0,255))
    self.showLabel:centerLeft(0)
    self.showLabel:addEventListener(UIEvent.BUTTON_CLICK,self,self.clickCallback)
    self.showLabel:setSize(size.width, size.height)
    self:addChild(self.showLabel);
    self:addChild(self.scrollView);
    -- print("1--------------DropDownList:init(    self._width  = "..self._width .. "   and  self._height = "..self._height)
    -- self._width = _size.width
    -- self._height = _size.height
    -- print("2--------------DropDownList:init(    self._width  = "..self._width .. "   and  self._height = "..self._height)

    -- self.showLabel:enableDebugDraw(UI.RED)
    -- self:enableDebugDraw(UI.RED)
    -- print("3--------------DropDownList:init(    self._width  = "..self._width .. "   and  self._height = "..self._height)
end


function DropDownList:clickCallback()
    print("ropDownList:clickCallback")
    if not self.isShowMenu then
        self.scrollView:show()
        self:setSelectedIndex()
        self.isShowMenu = true
        self.scrollView:leftBottom(0, size.height)
    else
        self:onClose()
    end
end
-- 初始化视图
function DropDownList:onInitView()
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.onTouchBegan)
end

-- 更新视图
function DropDownList:onUpdateView()

end
 
-- 获取当前选中的index
function DropDownList:getSelectedIndex()
    return self.lastSelectedIndex;
end

--设置选中index
function DropDownList:setSelectedIndex()
    for i = 1, #self.selectLabels do
        if i == self.lastSelectedIndex then
            self.bgLayers[i]:setColor(cc.c4b(255,215,0,255))
            self.showLabel:setText(self.selectLabels[self.lastSelectedIndex]:getText())
        else
            self.bgLayers[i]:setColor(cc.c4b(255,248,220,255))
        end

    end
end

function DropDownList:setDirection()
end

--创建以menu item 并添加一个label覆盖到上面
function DropDownList:addLabel(index, text)
    local normal   = cc.LayerColor:create(cc.c4b(255,248,220,255), size.width, size.height)
    table.insert(self.bgLayers, normal)
            
    local button = UI.Text.create()-- UI.Button:create()
    button:init(text, UI.FONT_ARIAL, 25, UI.FONT_COLOR_42_31_1)
    -- button:setText(text)
    -- button:setTextFont(UI.FONT_ARIAL, 30, UI.FONT_COLOR_42_31_1)
    -- button:leftBottom(0, size.height * index)
    -- button:setSize(size.width, size.height)
    button:centerBottom(self.direction * size.height * (index - 1) + 5)
    button:setTag(index)
    normal:setPosition(cc.p(0, self.direction * size.height * index - 70))
    table.insert(self.selectLabels, button)
    self.mainMenu:addChild(button,3); 
    self.mainMenu:addChild(normal,2); 
    button:setTouchEnable(true)
    button:addEventListener(UIEvent.COMPONENT_CLICK,self,self.onSelected)
end

--选中下拉列表后
function DropDownList:onSelected(sender)
    print("----------DropDownList:onSelected(sender)")
    if not self.isShowMenu then
        return
    end
    if sender then
        self.lastSelectedIndex = sender:getTag()
        self.showLabel:setText(self.selectLabels[sender:getTag()]:getText())
    end
    self:onClose()--关闭下拉列表框
end
        
--关闭下拉列表框
function DropDownList:onClose()
    self.isShowMenu = false;
    -- local x,y = self.mainMenu:getPosition()
    self.scrollView:leftBottom(- winSize.width, size.height)
end

-- 注册监听事件(可选)
function DropDownList:registerListener()
    --监听窗口外关闭事件
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
    --     print("onTouchDialogOutsizeHandler")
    --     if self.isShowMenu then
    --         self:onClose()
    --     end
    -- end)
 
end


-- 注销监听事件(可选)
function DropDownList:unRegisterListener()

end

    
   
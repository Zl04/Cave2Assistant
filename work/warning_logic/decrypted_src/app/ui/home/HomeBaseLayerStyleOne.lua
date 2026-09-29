-- HomeBaseLayerStyleOne.lua
-- Author:CMonk
-- 2018年12月10日
require "app.ui.shoplayer.BagGoodsPanel"

UI = UI or {}
local HomeBaseLayerStyleOne = class("HomeBaseLayerStyleOne", UI.DoorWin)
UI.HomeBaseLayerStyleOne = HomeBaseLayerStyleOne
UI.HOME_BASE_TAG_CHANGE = "HOME_BASE_TAG_CHANGE"

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local BG_ZORDER = 1000
local CONTENT_ZORDER = 2000
local FG_ZORDER = 3000

--资源列表(必备)
local COM_RES_LIST = {
    "ui_town_home.plist",
    "ui_common_btn.plist",
    "ui_general_big_number.plist"
}


--构造函数(必备)
function HomeBaseLayerStyleOne:ctor(uitype)
    HomeBaseLayerStyleOne.super.ctor(
        self, 
        uitype,
        COM_RES_LIST,
        winSize.width / 3,    -- 触摸关闭点暂时在宿主窗体上做
        winSize.height
    )
    self._rootLayer = nil         --root节点
    self._boostStatus = false
    self._cachedPanels = {}
    self._callbackList = {}
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:registerListener()
end


--虚构函数, destroy时调用(必备)
function HomeBaseLayerStyleOne:dtor()
    HomeBaseLayerStyleOne.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化(必备)
function HomeBaseLayerStyleOne:init()
    HomeBaseLayerStyleOne.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function HomeBaseLayerStyleOne:onInitView()
    -- 总板块
    self._rootLayer = UI.Component:create()
    self._rootLayer:init()
    self._rootLayer:setSize(winSize.width, winSize.height)
    self._rootLayer:leftBottom(0, 0)
    self:addChild(self._rootLayer)

    -- 右边板块
    self._rightLayout = UI.Component:create()
    self._rightLayout:init()
    self._rightLayout:setSize(winSize.width, winSize.height)
    self._rightLayout:leftBottom(0, 0)
    self._rootLayer:addChild(self._rightLayout)

    -- 左边板块
    self._leftLayout = UI.Component:create()
    self._leftLayout:init()
    self._leftLayout:setSize(winSize.width, winSize.height)
    self._leftLayout:leftBottom(0, 0)
    self._rootLayer:addChild(self._leftLayout) 

    -- 背景背后的装饰物宿主
    local behindBg = UI.Layout:create()
    behindBg:init()
    behindBg:centerLeft(0)
    self._leftLayout:addChild(behindBg)

    -- 背景背后的装饰物
    self._accessoriesBehind = UI.Animation:create()
    self._accessoriesBehind:init("effect_ui_town_home2.json", "effect_ui_town_home.atlas")
    self._accessoriesBehind:leftBottom(227, 301)
    self._accessoriesBehind:setAnimation("begin")
    behindBg:addChild(self._accessoriesBehind, FG_ZORDER)

    -- 背景版面
    self._bg = UI.Image:create()
    self._bg:centerLeft(0)
    self._bg:init("ui_home_banner_box.png")
    self._leftLayout:addChild(self._bg)
    behindBg:setSize(self._bg:getSize())

    -- 背景圈圈
    self._magicCircle = UI.Animation:create()
    self._magicCircle:init("effect_ui_town_home_quan.json", "effect_ui_town_home_quan.atlas")
    self._magicCircle:leftBottom(227, 301)
    self._magicCircle:setAnimation("begin")
    self._bg:addChild(self._magicCircle, BG_ZORDER)   

    -- 背景动画
    self._accessories = UI.Animation:create()
    self._accessories:init("effect_ui_town_home1.json", "effect_ui_town_home.atlas")
    self._accessories:leftBottom(227, 301)
    self._accessories:setAnimation("begin")
    self._bg:addChild(self._accessories, FG_ZORDER)

    -- 主标题
    self._title = UI.Text:create()
    self._title:init("DEADBEEF", UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_155_155_155)
    self._title:center(-7, -287)
    self._bg:addChild(self._title)

    -- 标签锚点
    local tabListLayout = UI.Layout:create()
    tabListLayout:init()
    tabListLayout:enableAutoHeight()
    tabListLayout:enableAutoWidth()
    tabListLayout:setTouchEnable(true)
    tabListLayout:setSwallowTouches(true)
    tabListLayout:leftUp(362, 34)
    self._bg:addChild(tabListLayout)

    -- 标签内容
    self._tabList = {}
    for i,v in ipairs(self:getTabData()) do
        local tab = UI.Button:create()
        tab:init("ui_btn_gray3_0.png", "ui_btn_gray3_0.png", "ui_btn_gray3_2.png", cc.p(-6, 0))
        tab:floatUp(11)
        tab:closeClickScale()
        tab:setText(v.text)
        tab:setTag(i)
        tab:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_GOLDEN_MINE_TAB_TEXT_NORNAL)
        tab:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            self:showContentPanelByIndex(tab:getTag())
        end)

        -- 设置激活标签图标, 不居中, 这样设置
        local active = UI.Image:create()
        active:init("ui_btn_gray3_1.png")
        active:centerLeft(0)
        tab:setSelectedNode(active, 2)

        -- 加入列表
        tabListLayout:addComponent(tab)
        table.insert(self._tabList, tab)
    end

    --右边背包数据
    local usedTypeList = {
        [1] = {
            goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
        }
    }
    self._bagList = UI.BagGoodsPanel:create(nil, false, false)
    self._bagList:init()
    self._bagList:changeBagDefaultIndex(1)
    self._bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    self._bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    self._bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self:addChild(self._bagList, 5)

    -- 设置默认显示页面
    self:showContentPanelByIndex(1)

    -- 设置入场展现
    self:setDoorNode(self._leftLayout, self._bagList)
end

-- 模版函数：更新组建的视图(必备)
function HomeBaseLayerStyleOne:onUpdateView()
    for k,v in pairs(self._cachedPanels) do
        v:updateView()
    end
end

-- 隐藏面板
function HomeBaseLayerStyleOne:hidePanel(panelToHide)
    if (panelToHide.setPanelActive) then panelToHide:setPanelActive(false) end
    panelToHide:leftBottom(-winSize.width, -winSize.height)
end

-- 显示面板
function HomeBaseLayerStyleOne:showPanel(panelToShow)
    if (panelToShow.setPanelActive) then panelToShow:setPanelActive(true) end
    panelToShow:center()
    panelToShow:updateView()
end

-- 获取或者新建一个面板, 总之搞一个面板进缓存并藏起来
function HomeBaseLayerStyleOne:getOrBuildPanel(idx)
    local panel = self._cachedPanels[idx]
    if (panel == nil) then
        panel = self:getTabData()[idx].getNewContentLayout(self)
        self._cachedPanels[idx] = panel
        self._bg:addChild(panel, CONTENT_ZORDER)
    end
    self:hidePanel(panel)
    return panel
end

-- 换一个面板展现
function HomeBaseLayerStyleOne:showContentPanelByIndex(idx)
    -- 展现标签
    for i, w in ipairs(self._tabList) do
        if (w:getTag() ~= idx) then 
            w:release() 
            w:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_GOLDEN_MINE_TAB_TEXT_NORNAL)
        else
            w:press(false)
            w:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_GOLDEN_MINE_TAB_TEXT_ACTIVE)
        end
    end

    -- 过滤相同标签点击逻辑
    if (self._showingPanelIdx == idx) then return end

    -- 隐藏现在显示的页面
    if (self._showingPanelIdx ~= nil) then
        self:hidePanel(self:getOrBuildPanel(self._showingPanelIdx))
    end
    
    -- 显示选择的页面
    local panelToShow = self:getOrBuildPanel(idx)
    self:showPanel(panelToShow)
    self._showingPanelIdx = idx
    self:runCallback(UI.HOME_BASE_TAG_CHANGE, idx, panelToShow)

    -- 替换标题
    self._title:setText(self:getTabData()[idx].titleText)
end

-- 设置加速表现状态
function HomeBaseLayerStyleOne:runBoostAnimation(isOn)
    if (self._boostStatus ~= isOn) then
        self._boostStatus = isOn
        if (self._boostStatus) then
            self._accessories:setAnimation("trigger_jiasu", false)
            self._accessories:addAnimation("idle", true)
            self._accessoriesBehind:setAnimation("trigger_jiasu", false)
            self._accessoriesBehind:addAnimation("idle", true)
            self._magicCircle:setAnimation("trigger_jiasu", false)
            self._magicCircle:addAnimation("idle", true)
        else
            self._accessories:setAnimation("trigger_jiasu", false)
            self._accessories:addAnimation("begin", true)
            self._accessoriesBehind:setAnimation("trigger_jiasu", false)
            self._accessoriesBehind:addAnimation("begin", true)
            self._magicCircle:setAnimation("trigger_jiasu", false)
            self._magicCircle:addAnimation("begin", true)
        end
    end
end

-- 播放面板动画
function HomeBaseLayerStyleOne:runLvUpAnimation()
    if (self._boostStatus) then
        self._accessories:setAnimation("trigger_shengji2", false)
        self._accessories:addAnimation("idle", true)
        self._accessoriesBehind:setAnimation("trigger_shengji2", false)
        self._accessoriesBehind:addAnimation("idle", true)
        self._magicCircle:setAnimation("trigger_shengji2", false)
        self._magicCircle:addAnimation("idle", true)
    else
        self._accessories:setAnimation("trigger_shengji", false)
        self._accessories:addAnimation("begin", true)
        self._accessoriesBehind:setAnimation("trigger_shengji", false)
        self._accessoriesBehind:addAnimation("begin", true)
        self._magicCircle:setAnimation("trigger_shengji", false)
        self._magicCircle:addAnimation("begin", true)
    end
end



-- 获取TAB数据的方法
function HomeBaseLayerStyleOne:getTabData()
    printError("请重载该方法来设置标签数据")
    -- 页面信息
    -- local TAB_DATA = {
    --     [1] = {            -- 信息标签
    --         index = 1,
    --         text = "信息",
    --         titleText = "金矿信息",
    --         getNewContentLayout = function(self)
    --             require "app.ui.home.goldenMine.GoldenMineInfoPanel"
    --             local content = UI.GoldenMineInfoPanel:create()
    --             content:init(self, 439, 626)
    --             return content
    --         end,
    --     },    
    --     [2] = {            -- 升级标签
    --         index = 2,
    --         text = "升级",
    --         titleText = "金矿升级",
    --         getNewContentLayout = function(self)
    --             require "app.ui.home.goldenMine.GoldenMineLvUpPanel"
    --             local content = UI.GoldenMineLvUpPanel:create()
    --             content:init(self, 439, 626)
    --             return content
    --         end,
    --     },       
    --     [3] = {      -- 加速标签
    --         index = 3,
    --         text = "加速",
    --         titleText = "金矿加速",
    --         getNewContentLayout = function(self)
    --             require "app.ui.home.goldenMine.GoldenMineAcceleratePanel"
    --             local content = UI.GoldenMineAcceleratePanel:create()
    --             content:init(self, 439, 626)
    --             return content
    --         end,
    --     },      
    -- }
end

function HomeBaseLayerStyleOne:bagDragBeganCallback()

end

function HomeBaseLayerStyleOne:bagDragMovedCallback()
    
end

function HomeBaseLayerStyleOne:bagDragEndedCallback()
    
end






-- 事件处理 --
---------------------------------------
function HomeBaseLayerStyleOne:registerListener()
end

function HomeBaseLayerStyleOne:unRegisterListener()
end


function HomeBaseLayerStyleOne:setCallback(name, cb)
    if (not self._callbackList) then
        self._callbackList = {}
    end

    self._callbackList[name] = cb
end

function HomeBaseLayerStyleOne:runCallback(name, ...)
    if (not self._callbackList) then return end
    local cb = self._callbackList[name]
    if (cb) then return cb( ... ) end
end
---------------------------------------
-- eo 事件处理 --

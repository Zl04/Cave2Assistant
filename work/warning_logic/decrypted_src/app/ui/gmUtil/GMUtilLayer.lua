--[[
    新测试工具 2017/11/21
    修改基础：    
        UI - 背包 2017年04月12

    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.game.GameDefine"
require "app.ui.Component"
require "app.ui.common.Tab.TabList"
require "app.ui.gmUtil.control.GMUtilTabItem"
require "app.ui.gmUtil.panel.GMUtilPanelCave"
require "app.ui.gmUtil.panel.GMUtilPanelProgress"
require "app.ui.gmUtil.panel.GMUtilPanelEffect"
require "app.ui.gmUtil.panel.GMUtilPanelItem"
require "app.ui.gmUtil.panel.GMUtilPanelOther"
require "app.ui.gmUtil.panel.GMUtilPanelFrequentUse"
require "app.ui.gmUtil.GMUtilQuickBar"
local GMUtilConfig = require("app.ui.gmUtil.GMUtilConfig")

-- 引用UI命名空间F
UI = UI or {}

-- 模块初始化
local GMUtilLayer = class("GMUtilLayer", UI.HWBtnComponent)
UI.GMUtilLayer = GMUtilLayer

-- 私有变量:
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = true
local DEBUG_DRAW = true
---------------------------------------
-- eo 模块初始化 --







-- 资源统合 --
---------------------------------------
local COM_RES_LIST = {

    {name = GMUtilConfig.SPRITE_FRAME_RES, priority = COM_RES_LEVEL.HIGH},
}
-- 界面背景
local SPRITE_BG = GMUtilConfig.SPRITE_BG
-- 关闭按钮
local SPRITE_CLOSE_NORMAL = GMUtilConfig.SPRITE_CLOSE_NORMAL
local SPRITE_CLOSE_ACTIVE = GMUtilConfig.SPRITE_CLOSE_ACTIVE
-- 角色
local SPRITE_TAB_CAVE_ACTIVE =GMUtilConfig.SPRITE_TAB_CAVE_ACTIVE 
local SPRITE_TAB_CAVE_NORMAL = GMUtilConfig.SPRITE_TAB_CAVE_NORMAL
local SPRITE_TAB_CAVE_PRESS = GMUtilConfig.SPRITE_TAB_CAVE_PRESS
-- 任务
local SPRITE_TAB_PROGRESS_ACTIVE = GMUtilConfig.SPRITE_TAB_PROGRESS_ACTIVE
local SPRITE_TAB_PROGRESS_NORMAL = GMUtilConfig.SPRITE_TAB_PROGRESS_NORMAL
local SPRITE_TAB_PROGRESS_PRESS = GMUtilConfig.SPRITE_TAB_PROGRESS_PRESS
-- 技能
local SPRITE_TAB_EFFECT_ACTIVE = GMUtilConfig.SPRITE_TAB_EFFECT_ACTIVE
local SPRITE_TAB_EFFECT_NORMAL = GMUtilConfig.SPRITE_TAB_EFFECT_NORMAL
local SPRITE_TAB_EFFECT_PRESS = GMUtilConfig.SPRITE_TAB_EFFECT_PRESS
-- 日志
local SPRITE_TAB_ITEM_ACTIVE = GMUtilConfig.SPRITE_TAB_ITEM_ACTIVE 
local SPRITE_TAB_ITEM_NORMAL = GMUtilConfig.SPRITE_TAB_ITEM_NORMAL
local SPRITE_TAB_ITEM_PRESS = GMUtilConfig.SPRITE_TAB_ITEM_PRESS 
-- 设置
local SPRITE_TAB_OTHER_ACTIVE = GMUtilConfig.SPRITE_TAB_OTHER_ACTIVE 
local SPRITE_TAB_OTHER_NORMAL = GMUtilConfig.SPRITE_TAB_OTHER_NORMAL
local SPRITE_TAB_OTHER_PRESS = GMUtilConfig.SPRITE_TAB_OTHER_PRESS 
---------------------------------------
-- eo 资源统合 --







-- 布局 --
---------------------------------------
-- 引用GMUtil公用设置
-- GMUtilConfig.LAYOUT_DESIGN_WIDTH = 1024
-- GMUtilConfig.LAYOUT_DESIGN_HEIGHT = 640
-- GMUtilConfig.LAYOUT_TAB_CONTENT_HEIGHT = 568

-- 调整控件宽高使点击区域更贴合于画面，内容区域独立不被影响
local LAYOUT_GRAPHIC_OFFSET_WIDTH = -20
local LAYOUT_GRAPHIC_OFFSET_HEIGHT = -30
-- 背景
local LAYOUT_BG_BOTTOM = 10
-- 顶部菜单（Tab栏容器）
local LAYOUT_MENU_LEFT = 0
local LAYOUT_MENU_TOP = -10
local LAYOUT_MENU_WIDTH = GMUtilConfig.LAYOUT_DESIGN_WIDTH
local LAYOUT_MENU_HEIGHT = 0
-- 模块功能tab选择控件
local LAYOUT_TAB_LIST_SPACE = 28
local LAYOUT_TAB_LIST_WIDTH = 106
local LAYOUT_TAB_LIST_HEIGHT = 70
local LAYOUT_TAB_LIST_LEFT = 90
local LAYOUT_TAB_LIST_UP = 5
-- 关闭按钮
local LAYOUT_CLOSE_BUTTON_RIGHT = 70
local LAYOUT_CLOSE_BUTTON_UP = 5


-- 组件z序 --
---------------------
-- 布局根节点
local GMUTIL_ROOT_LAYOUT_ZORDER = 1
-- 背景
local GMUTIL_BG_ZORDER = -3
-- 功能面板的背景图
local GMUTIL_CONTENT_PANEL_BG_ZORDER = 3
-- 菜单层(TAB栏容器)
local GMUTIL_CONTENT_MENU_ZORDER = -1
-- 功能模块面板
local GMUTIL_CONTENT_PANEL_ZORDER = 4
-- 关闭按钮
local GMUTIL_CLOSE_BUTTON_ZORDER = 5
-- 便捷按钮
local GMUTIL_QUICK_BAR_ZORDER = 4
---------------------------------------
-- eo 整体布局 --








-- 数据结构 --
---------------------------------------
local TAB_DATA = {
    CAVE = {            -- 洞窟标签
        index = 1,
        normal = SPRITE_TAB_CAVE_NORMAL,
        active = SPRITE_TAB_CAVE_ACTIVE,
        press = SPRITE_TAB_CAVE_PRESS,
        text = "楼层",
        font = UI.FONT_ARIAL,
        getNewContentLayout = function(parentLayout)
            local ret = UI.GMUtilPanelCave:create()
            ret:init()
            return ret
        end,
        adjustPosition = function(contentLayout) contentLayout:centerBottom(0) end
    },    
    PROGRESS = {        -- 进度标签
        index = 2,
        normal = SPRITE_TAB_PROGRESS_NORMAL,
        active = SPRITE_TAB_PROGRESS_ACTIVE,
        press = SPRITE_TAB_PROGRESS_PRESS,
        text = "解锁",
        font = UI.FONT_ARIAL,
        getNewContentLayout = function()
            local ret = UI.GMUtilPanelProgress:create()
            ret:init()
            return ret
        end,
        adjustPosition = function(contentLayout) contentLayout:centerBottom(0) end
    },       
    EFFECT = {          -- 属性效果标签
        index = 3,
        normal = SPRITE_TAB_EFFECT_NORMAL,
        active = SPRITE_TAB_EFFECT_ACTIVE,
        press = SPRITE_TAB_EFFECT_PRESS,
        text = "人物",
        font = UI.FONT_ARIAL,
        getNewContentLayout = function()
            local ret = UI.GMUtilPanelEffect:create()
            ret:init()
            return ret
        end,
        adjustPosition = function(contentLayout) contentLayout:centerBottom(0) end
    },      
    ITEM = {            -- 道具标签
        index = 4,
        normal = SPRITE_TAB_ITEM_NORMAL,
        active = SPRITE_TAB_ITEM_ACTIVE,
        press = SPRITE_TAB_ITEM_PRESS,
        text = "财物",
        font = UI.FONT_ARIAL,
        getNewContentLayout = function()
            local ret = UI.GMUtilPanelItem:create()
            ret:init()
            return ret
        end,
        adjustPosition = function(contentLayout) contentLayout:centerBottom(0) end
    },        
    OTHER = {           -- 其他标签
        index = 5,
        normal = SPRITE_TAB_OTHER_NORMAL,
        active = SPRITE_TAB_OTHER_ACTIVE,
        press = SPRITE_TAB_OTHER_PRESS,
        text = "其他",
        font = UI.FONT_ARIAL,
        getNewContentLayout = function()
            local ret = UI.GMUtilPanelOther:create()
            ret:init()
            return ret
        end,
        adjustPosition = function(contentLayout) contentLayout:centerBottom(0) end
    },
    FREQUENT = {             -- 所有标签
        index = 6,
        normal = SPRITE_TAB_OTHER_NORMAL,
        active = SPRITE_TAB_OTHER_ACTIVE,
        press = SPRITE_TAB_OTHER_PRESS,
        text = "所有",
        font = UI.FONT_ARIAL,
        getNewContentLayout = function()
            local ret = UI.GMUtilPanelFrequentUse:create()
            ret:init()
            return ret
        end,
        adjustPosition = function(contentLayout) contentLayout:centerBottom(0) end
    },
}

-- 数据结构内部方法, 返回所有非方法键值
function TAB_DATA:getValueKeys()
    -- 过滤键值
    local keys = {}
    for k, v in pairs(self) do 
        if(type(v) ~= "function") then
            keys[#keys+1] = k
        end 
    end
    return keys
end

-- 数据结构内部方法, 返回一个根据index有序遍历的迭代器
function TAB_DATA:getIterator()
    local keys = self:getValueKeys()
    -- 根据指针排列键值
    table.sort(keys, function(a, b) return self[a].index < self[b].index end)

    -- 返回迭代器
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], self[keys[i]]
        end
    end
end

-- 数据结构内部方法, 根据index获取一个Tab数据
function TAB_DATA:fromIndex(idx)
    local keys = self:getValueKeys()
    for i,v in pairs(keys) do
        if(self[v].index == idx) then
            return self[v]
        end
    end
    return nil
end

-- 暴露给外部使用
function GMUtilLayer:getTabData()
    return TAB_DATA
end
---------------------------------------
-- eo 数据结构 --











-- 程序逻辑 --
---------------------------------------
-- 内部使用， 根据指针位置返回已经缓存的或者新建一个内容页面
-- 成功返回layout, 失败返回nil
local function getPanelByIndex(self, index)
    -- 如果缓存里有已保存的面板, 返回
    local ret = self._panelList[index]
    if(ret)then return ret end

    -- 否则使用数据结构中配置好的方法新建一个面板
    ret = TAB_DATA:fromIndex(index).getNewContentLayout(self._contentLayout)
    if (not ret) then return nil end 

    -- 加入列表和节点并返回
    self._panelList[index] = ret
    self._contentLayout:addChild(ret)
    return ret
end

-- 内部使用, 用指针来显示一个页面
local function showPanelByIndex(self, index)
    -- 参数检查
    if(type(index) ~= "number")then return end

    -- 获取一个指定的页面
    local panel = getPanelByIndex(self, index)
    if(not panel) then return end

    -- 设置激活状态并调整位置
    self._activePanel = panel
    TAB_DATA:fromIndex(index).adjustPosition(self._activePanel)
end

-- 隐藏一个面板, 现在是用移除屏幕外实现
local function hidePanel(self, panel)
    -- 移动出屏幕
    panel:leftBottom(-CONFIG_SCREEN_WIDTH, -CONFIG_SCREEN_HEIGHT)
end

-- 内部使用, 根据指针隐藏一个面板
local function hidePanelByIndex(self, index)
    -- 参数检查
    if(type(index) ~= "number")then return end
    -- 数据检查
    local panel = self._panelList[index]
    if (not panel) then return end

    -- 隐藏面板
    hidePanel(self, panel)    
end

-- 内部使用, 根据指针来替换一个面板
local function switchPanelByIndex(self, index)
    local lastActivePanel = self._activePanel
    showPanelByIndex(self, index)
    if (lastActivePanel and lastActivePanel ~= self._activePanel) then
        hidePanel(self, lastActivePanel)
    end
    -- Win32上写入时Key不写死会出UserDefault文件崩坏的Bug, 故和下面读入行成对写死
    cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.GMUtilDefaultTab, index)
end
-- 有需求暴露给外部使用
GMUtilLayer.switchPanelByIndex = switchPanelByIndex

-- 隐藏, 会导致场景切换不能打开的问题 FIXME:有什么方法能隐藏又不影响场景切换?
-- function GMUtilLayer:hide()
--     self:leftBottom(-winSize.width, -winSize.height)
--     self:unRegisterListener()
--     self:setInterceptTouches(false);
-- end

-- 显示
function GMUtilLayer:show()
    self:center()
    self:registerListener()
    self:setInterceptTouches(true);
end

-- 关闭, 需要重新加载组件
function GMUtilLayer:close()
    GMUtilLayer.super.close(self)
    if (GMUtilLayer._singleton == self) then GMUtilLayer._singleton = nil end
end





---------------------静态方法， self属于GMUtilLayer类， 不是其对象-------------------
GMUtilLayer._singleton = nil

-- 做素子使用
function GMUtilLayer:getInstance()
    if (GMUtilLayer._singleton) then return GMUtilLayer._singleton end
    GMUtilLayer._singleton = UI.GMUtilLayer:create()
    GMUtilLayer._singleton:init()
    return GMUtilLayer._singleton
end

-- 素子显示方法
-- 参数: 
--  layout: 宿主
--  z     : 在宿主中的z序
function GMUtilLayer:instanceShow(layout, z)
    assert(layout ~= nil)
    z = z or 10000

    local singleton = GMUtilLayer:getInstance()
    if (not singleton:getParent()) then layout:addComponent(singleton, z) end
    singleton:show()
end

-- 素子关闭方法
function GMUtilLayer:instanceClose()
    if (not GMUtilLayer._singleton) then return end
    GMUtilLayer._singleton:close()
    GMUtilLayer._singleton = nil
end
---------------------eo 静态方法--------------------------------------------------
---------------------------------------
-- eo 程序逻辑 --











-- 生命周期 --
---------------------------------------
-- 构造函数
function GMUtilLayer:ctor()
    GMUtilLayer.super.ctor(self, 0 --[[UIType.GMUTIL]], COM_RES_LIST, 0, 0)

    self._GMUtilLayerTag = GMUtilConfig.GMUtilLayerTag

    self._isListeningEvent = false
    self._activePanel = nil
    self._activeTabIndex = 0
    self._panelList = {}

    self:setInterceptTouches(true);
end


-- 析构函数
function GMUtilLayer:dtor()
    if (GMUtilLayer._singleton == self) then
        GMUtilLayer._singleton = nil
    end
    self._activePanel = nil
    self._panelList = {}
    self:unRegisterListener();
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER,function() end)

    GMUtilLayer.super.dtor(self)
    reload_script_file("app.ui.gmUtil.panel.GMUtilPanelContents")
    reload_script_file("app.ui.gmUtil.GMUtilExecutor")
end

-- 初始化
function GMUtilLayer:init()
    GMUtilLayer.super.init(self)

    self:setTouchEnable(true)
    self:registerListener();
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER,function() end)
end


-- 初始化视图
function GMUtilLayer:onInitView()
    -- 计算模块设计到窗口实际缩放值
    local scale = CONFIG_SCREEN_WIDTH / GMUtilConfig.LAYOUT_DESIGN_WIDTH
    if (scale > 1.0) then scale = 1.0 end

    -- 新建模块内容容器
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:center()
    contentLayout:setSize(GMUtilConfig.LAYOUT_DESIGN_WIDTH, GMUtilConfig.LAYOUT_DESIGN_HEIGHT)
    contentLayout:setScale(scale)
    self:addChild(contentLayout, GMUTIL_ROOT_LAYOUT_ZORDER)
    self._contentLayout = contentLayout


    -- 新建并添加模块背景
    local backgroudImage = UI.Image:create()
    backgroudImage:init(SPRITE_BG)
    backgroudImage:centerBottom(LAYOUT_BG_BOTTOM)
    self._contentLayout:addChild(backgroudImage, GMUTIL_BG_ZORDER)


    -- 新建菜单层布局
    local menuLayout = UI.Layout:create()
    menuLayout:init()
    menuLayout:setSize(LAYOUT_MENU_WIDTH, LAYOUT_MENU_HEIGHT)
    menuLayout:leftUp(LAYOUT_MENU_LEFT, LAYOUT_MENU_TOP)
    self._contentLayout:addChild(menuLayout, GMUTIL_CONTENT_MENU_ZORDER)


    -- 创建关闭按钮
    local closeButton = UI.Button:create()
    closeButton:init(SPRITE_CLOSE_NORMAL, SPRITE_CLOSE_ACTIVE)
    closeButton:rightUp(
        LAYOUT_CLOSE_BUTTON_RIGHT, 
        LAYOUT_CLOSE_BUTTON_UP
    )
    closeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self) self:close() end)
    menuLayout:addChild(closeButton, GMUTIL_CLOSE_BUTTON_ZORDER)


    -- 创建快速按钮
    local quickBar = UI.GMUtilQuickBar:create()
    quickBar:init()
    quickBar:leftUp(GMUtilConfig.LAYOUT_QUICK_BAR_LEFT, GMUtilConfig.LAYOUT_QUICK_BAR_TOP)
    self._contentLayout:addChild(quickBar, GMUTIL_QUICK_BAR_ZORDER)


    -- 创建功能便签列表
    local tabList = UI.TabList:create()
    tabList:init(
        LAYOUT_TAB_LIST_SPACE,
        LAYOUT_TAB_LIST_WIDTH,
        LAYOUT_TAB_LIST_HEIGHT)
    -- 设定功能便签位置
    tabList:leftUp(
        LAYOUT_TAB_LIST_LEFT, 
        LAYOUT_TAB_LIST_UP)
    tabList:setTouchEnable(true)
    -- FIXME: TabList bug - TabList的setDefaultIndex会导致第一次TAB_ACTIVE回调函数中的
    -- AddChild函数运行失败. 故设置为nil后在下面手动激活需要的标签
    -- 应该和setDefaultIndex后的第一次TAB_ACTIVE是在TabList的onUpdateView中有关.
    -- 具体病因不知道, 如果知道了请告诉我 by CMonk, 18080449414, QQ 910039530
    tabList:setDefaultIndex(nil)
    tabList:addEventListener(UIEvent.TAB_ACTIVE, self, function(self, index, lastIndex)
        print(string.format("GMUtilLayer onInitView: select tab %d.", index))
        switchPanelByIndex(self, index)
    end)
    -- 显示标签列表控件
    menuLayout:addChild(tabList)
    self._tabList = tabList

    -- 根据标签数据填充标签
    for i=1,5 do
        local tabInfo = TAB_DATA:fromIndex(i)
        local gmUtilTab = UI.GMUtilTabItem:create()
        gmUtilTab:init(
            tabInfo.normal, 
            tabInfo.press,
            tabInfo.active,
            tabInfo.text,
            tabInfo.font
        )
        tabList:addTab(gmUtilTab)
    end





    ---------------------标签初始化-------------------------
    -- Win32上写入时Key不写死会出UserDefault文件崩坏的Bug, 故和上面写入行成对写死
    local defaultTabIndex = cc.UserDefault:getInstance():getIntegerForKey(
        UserDefaultKeyWord.GMUtilDefaultTab, TAB_DATA.OTHER.index)
    -- 第一次打开时强制设定默认页面为新页面
    local GMUtildefaultToNewTab = cc.UserDefault:getInstance():getBoolForKey(
        UserDefaultKeyWord.GMUtildefaultToNewTab, true)
    if (GMUtildefaultToNewTab) then 
        defaultTabIndex = TAB_DATA.FREQUENT.index
        cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.GMUtildefaultToNewTab, false)
    end
    -- 因上述Tablist Bug, 故在这里手动激活一个标签
    tabList:activeTab(defaultTabIndex)
    -- 有存储的内容在默认Tablist选中的5个以外的情况, 这种情况下抛开tabList激活一个标签
    if (not self._activePanel) then showPanelByIndex(self, defaultTabIndex) end
end
---------------------------------------
-- eo 生命周期 --












-- 事件处理 --
---------------------------------------

-- 注册监听事件(可选)
function GMUtilLayer:registerListener()
    -- if (self._isListeningEvent) then return end
    -- self._isListeningEvent = true
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end

-- 注销监听事件(可选)
function GMUtilLayer:unRegisterListener()
    -- if ( not self._isListeningEvent) then return end
    -- self._isListeningEvent = false
    -- self:removeEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end

-- 触摸边框外事件处理
function GMUtilLayer:onTouchDialogOutsizeHandler()
    self:close()
end
---------------------------------------
-- eo 事件处理 --
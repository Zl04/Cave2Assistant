-- RuneFactoryLayer.lua
-- Author:CMonk
-- 2018年12月10日
require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.home.HomeBaseLayerStyleOne"
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local RuneFactoryLayer = class("RuneFactoryLayer", UI.HomeBaseLayerStyleOne)
UI.RuneFactoryLayer = RuneFactoryLayer

-- 模块内部回调ID, 此窗口的 runCallback 和 setCallback 使用. 用来在模块内做跨子模块调用.
UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_RECEIVE_OUTPUT = "RUNE_FACTORY_CALLBACK_BTN_CLICK_RECEIVE_OUTPUT"
UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_LVUP = "RUNE_FACTORY_CALLBACK_BTN_CLICK_LVUP"
UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_BOOST = "RUNE_FACTORY_CALLBACK_BTN_CLICK_BOOST"
UI.RUNE_FACTORY_CALLBACK_BAG_LIST_DRAG_BEGIN = "RUNE_FACTORY_CALLBACK_BAG_LIST_DRAG_BEGIN"
UI.RUNE_FACTORY_CALLBACK_BAG_LIST_DRAG_END = "RUNE_FACTORY_CALLBACK_BAG_LIST_DRAG_END"
UI.RUNE_FACTORY_BOOST_GET_ITEM_GRID_LIST = "RUNE_FACTORY_BOOST_GET_ITEM_GRID_LIST"
UI.RUNE_FACTORY_REFRESH_BAG_LIST = "RUNE_FACTORY_REFRESH_BAG_LIST"
UI.RUNE_FACTORY_CLEAR_ITEM_GRIDS = "RUNE_FACTORY_CLEAR_ITEM_GRIDS"

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

-- 页面信息
local TAB_DATA = {
    [1] = {            -- 信息标签
        index = 1,
        text = LanguageManager:getInstance():getLocalString(1111537), --"信息"
        titleText = LanguageManager:getInstance():getLocalString(1111543), --"符文工房信息"
        getNewContentLayout = function(self)
            require "app.ui.home.runeFactory.RuneFactoryInfoPanel"
            local content = UI.RuneFactoryInfoPanel:create()
            content:init(self, 439, 626)
            return content
        end,
    },    
    [2] = {            -- 升级标签
        index = 2,
        text = LanguageManager:getInstance():getLocalString(1111538), --"升级"
        titleText = LanguageManager:getInstance():getLocalString(1111544), --"符文工房升级"
        getNewContentLayout = function(self)
            require "app.ui.home.runeFactory.RuneFactoryLvUpPanel"
            local content = UI.RuneFactoryLvUpPanel:create()
            content:init(self, 439, 626)
            return content
        end,
    },       
    [3] = {      -- 加速标签
        index = 3,
        text = LanguageManager:getInstance():getLocalString(1111539), --"加速"
        titleText = LanguageManager:getInstance():getLocalString(1111545), --"符文工房加速"
        getNewContentLayout = function(self)
            require "app.ui.home.runeFactory.RuneFactoryAcceleratePanel"
            local content = UI.RuneFactoryAcceleratePanel:create()
            content:init(self, 439, 626)
            return content
        end,
    },      
}


--构造函数(必备)
function RuneFactoryLayer:ctor(npcID)
    RuneFactoryLayer.super.ctor(self, UIType.GEM_FACTORY)
    self._npcID = npcID
    self:registerListener()
end


--虚构函数, destroy时调用(必备)
function RuneFactoryLayer:dtor()
    RuneFactoryLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化(必备)
function RuneFactoryLayer:init()
    RuneFactoryLayer.super.init(self)
    -- 升级条件需要金矿等级, 刷新金矿数据
    Net.NetNPCSystem:reqGoldenMineInfo(self._npcID)
    -- 刷新符文工房数据
    Net.NetNPCSystem:reqGemFactoryInfo(self._npcID)
end

-- 模版函数：初始化组建的视图(必备)
function RuneFactoryLayer:onInitView()
    RuneFactoryLayer.super.onInitView(self)
end

-- 模版函数：更新组建的视图(必备)
function RuneFactoryLayer:onUpdateView()
    RuneFactoryLayer.super.onUpdateView(self)
end

-- 获取TAB数据的方法
function RuneFactoryLayer:getTabData()
    return TAB_DATA
end












-- 事件处理 --
---------------------------------------
-- 包包格子开始拖动回调, 从父类重载
function RuneFactoryLayer:bagDragBeganCallback(...)
    self:runCallback(UI.RUNE_FACTORY_CALLBACK_BAG_LIST_DRAG_BEGIN, ...)
end

-- 包包格子移动回调, 从父类重载
function RuneFactoryLayer:bagDragMovedCallback(grid, touchPosition)

end

-- 包包格子拖动完毕回调, 从父类重载
function RuneFactoryLayer:bagDragEndedCallback(...)
    self:runCallback(UI.RUNE_FACTORY_CALLBACK_BAG_LIST_DRAG_END, ...)
end

-- 服务器数据更新事件
function RuneFactoryLayer:onDataUpdate()
    -- 检查参数
    if (not self._showingPanelIdx) then return end
    local showingPanel = self._cachedPanels[self._showingPanelIdx]
    if (not showingPanel) then return end

    -- 更新正在展现页面
    showingPanel:updateView()

    -- 设置面板动画状态
    local isInBoost = HomeDataManager:getRuneFactoryData():getIsInBoost()
    self:runBoostAnimation(isInBoost)

    -- 判断是否要滚到最上
    if (self._scrollToTheTopOnUpdate) then
        self._scrollToTheTopOnUpdate = false
        self._bagList:scrollToTop(0, false)
    end
end

-- 成功收取产出事件
function RuneFactoryLayer:onOutputReceived(output)
    Net.NetNPCSystem:reqGemFactoryInfo(self._npcID)
    local nextClickTimestamp = 0
    if (output == 0) then -- 产出为0, 背包已满
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110396)) --"背包已满"
        nextClickTimestamp = GameManager:getNormalServerTime() + 5
    else
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111552)) --"符文工坊产出已接收"
        self._bagList:changeBagIndex(self._bagList:getGemStoneBagIndex())
        nextClickTimestamp = GameManager:getNormalServerTime() + 60
        self._scrollToTheTopOnUpdate = true
    end
    cc.UserDefault:getInstance():setIntegerForKey("RUNE_FACTORY_RECV_NEXT_TIMESTAMP", nextClickTimestamp)
end

-- 成功升级事件
function RuneFactoryLayer:onLvUp()
    Net.NetNPCSystem:reqGemFactoryInfo(self._npcID)
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111553)) --"符文工坊升级成功"
    self:runLvUpAnimation()
end

-- 成功加速事件
function RuneFactoryLayer:onBoostStart()
    Net.NetNPCSystem:reqGemFactoryInfo(self._npcID)
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111554)) --"符文工坊开始加速生产"
    self:runBoostAnimation(true)
    self:runCallback(UI.RUNE_FACTORY_CLEAR_ITEM_GRIDS)
end

-- 注册监听事件(可选)
function RuneFactoryLayer:registerListener()
    -- 信息页面点击收取
    self:setCallback(UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_RECEIVE_OUTPUT, function()
        Net.NetNPCSystem:reqGemFactoryOutput(self._npcID)
    end)

    -- 升级页面点击升级
    self:setCallback(UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_LVUP, function() 
        Net.NetNPCSystem:reqGemFactoryLvUp(self._npcID)
    end)

    -- 加速页面点击加速
    self:setCallback(UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_BOOST, function()
        local idList = {}
        local gridList = self:runCallback(UI.RUNE_FACTORY_BOOST_GET_ITEM_GRID_LIST)

        local haveHighRare = false
        for i,v in ipairs(gridList) do
            local goodsData = v:getData()
            if (goodsData and goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4) then
                haveHighRare = true
                break
            end
        end

        if (haveHighRare) then
            -- 二次确认
            local richText = LanguageManager:getInstance():getLocalString(1113954)
            local okCallBack = function ()
                for i,v in ipairs(gridList) do
                    local goodsData = v:getData()
                    if (goodsData) then
                        table.insert(idList, goodsData:getEntityID())
                    end
                end
                Net.NetNPCSystem:reqGemFactoryBoost(self._npcID, idList) 
            end
            local cancelCallBack = function ()
                --不处理
            end
            UI.TipsLayer:onShowCommonTextHandler(richText, okCallBack, cancelCallBack)
        else
            for i,v in ipairs(gridList) do
                local goodsData = v:getData()
                if (goodsData) then
                    table.insert(idList, goodsData:getEntityID())
                end
            end
            Net.NetNPCSystem:reqGemFactoryBoost(self._npcID, idList) 
        end
    end)

    -- 刷新背包
    self:setCallback(UI.RUNE_FACTORY_REFRESH_BAG_LIST, function(goodsData) 
        self._bagList:refreshView()
    end)

    -- 切换到加速页面时需要转至装备标签
    self:setCallback(UI.HOME_BASE_TAG_CHANGE, function(idx, panelToShow)
        if (idx == 3) then
            self._bagList:changeBagIndex(self._bagList:getEquipmentsIndex())
            self._bagList:scrollToTop(0, false)
        end
    end)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_UPDATE, self, self.onDataUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_UPDATE, self, self.onDataUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_OUTPUT_RECEIVED, self, self.onOutputReceived)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_LVUP, self, self.onLvUp)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_BOOST_START, self, self.onBoostStart)
end

-- 注销监听事件(可选)
function RuneFactoryLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_UPDATE, self, self.onDataUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_UPDATE, self, self.onDataUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_OUTPUT_RECEIVED, self, self.onOutputReceived)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_LVUP, self, self.onLvUp)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_BOOST_START, self, self.onBoostStart)
end
---------------------------------------
-- eo 事件处理 --

-- GoldenMineLayer.lua
-- Author:CMonk
-- 2018年12月10日
require "app.ui.shoplayer.BagGoodsPanel"
require "app.ui.home.HomeBaseLayerStyleOne"
require "app.datas.HomeDataManager"
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local GoldenMineLayer = class("GoldenMineLayer", UI.HomeBaseLayerStyleOne)
UI.GoldenMineLayer = GoldenMineLayer
UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_RECEIVE_OUTPUT = "GOLDEN_MINE_CALLBACK_BTN_CLICK_RECEIVE_OUTPUT"
UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_LVUP = "GOLDEN_MINE_CALLBACK_BTN_CLICK_LVUP"
UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_BOOST = "GOLDEN_MINE_CALLBACK_BTN_CLICK_BOOST"

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

-- 页面信息
local TAB_DATA = {
    [1] = {            -- 信息标签
        index = 1,
        text = LanguageManager:getInstance():getLocalString(1111537), --"信息"
        titleText = LanguageManager:getInstance():getLocalString(1111540), --"金矿信息"
        getNewContentLayout = function(self)
            require "app.ui.home.goldenMine.GoldenMineInfoPanel"
            local content = UI.GoldenMineInfoPanel:create()
            content:init(self, 439, 626)
            return content
        end,
    },    
    [2] = {            -- 升级标签
        index = 2,
        text = LanguageManager:getInstance():getLocalString(1111538), --"升级"
        titleText = LanguageManager:getInstance():getLocalString(1111541), --"金矿升级"
        getNewContentLayout = function(self)
            require "app.ui.home.goldenMine.GoldenMineLvUpPanel"
            local content = UI.GoldenMineLvUpPanel:create()
            content:init(self, 439, 626)
            return content
        end,
    },       
    [3] = {      -- 加速标签
        index = 3,
        text = LanguageManager:getInstance():getLocalString(1111539), --"加速"
        titleText = LanguageManager:getInstance():getLocalString(1111542), --"金矿加速"
        getNewContentLayout = function(self)
            require "app.ui.home.goldenMine.GoldenMineAcceleratePanel"
            local content = UI.GoldenMineAcceleratePanel:create()
            content:init(self, 439, 626)
            return content
        end,
    },      
}

--构造函数(必备)
function GoldenMineLayer:ctor(npcID)
    GoldenMineLayer.super.ctor(self, UIType.GOLDEN_MINE)
    self._npcID = npcID
    self:registerListener()
end


--虚构函数, destroy时调用(必备)
function GoldenMineLayer:dtor()
    GoldenMineLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化(必备)
function GoldenMineLayer:init()
    GoldenMineLayer.super.init(self)
    -- 升级条件需要工坊等级, 刷新符文工房数据
    Net.NetNPCSystem:reqGemFactoryInfo(self._npcID)
    -- 刷新金矿数据
    Net.NetNPCSystem:reqGoldenMineInfo(self._npcID)
end

-- 模版函数：初始化组建的视图(必备)
function GoldenMineLayer:onInitView()
    GoldenMineLayer.super.onInitView(self)
end

-- 模版函数：更新组建的视图(必备)
function GoldenMineLayer:onUpdateView()
    GoldenMineLayer.super.onUpdateView(self)
end

-- 获取TAB数据的方法
function GoldenMineLayer:getTabData()
    return TAB_DATA
end












-- 事件处理 --
---------------------------------------
-- 数据更新事件
function GoldenMineLayer:onDataUpdate()
    -- 检查参数
    if (not self._showingPanelIdx) then return end
    local showingPanel = self._cachedPanels[self._showingPanelIdx]
    if (not showingPanel) then return end

    -- 更新正在展现页面
    showingPanel:updateView()

    -- 设置面板动画状态
    local isInBoost = HomeDataManager:getGoldenMineData():getIsInBoost()
    self:runBoostAnimation(isInBoost)
end

-- 获取产出成功
function GoldenMineLayer:onOutputReceived()
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111549)) --"金矿产出已接收"
    Net.NetNPCSystem:reqGoldenMineInfo(self._npcID)
    local nextTimestamp = GameManager:getNormalServerTime() + 60
    cc.UserDefault:getInstance():setIntegerForKey("GOLDEN_MINE_RECV_NEXT_TIMESTAMP", nextTimestamp)
end

-- 升级成功
function GoldenMineLayer:onLvUp()
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111550)) --"金矿升级成功"
    Net.NetNPCSystem:reqGoldenMineInfo(self._npcID)
    self:runLvUpAnimation()
end

-- 加速成功
function GoldenMineLayer:onBoostStart()
    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111551)) --"金矿开始加速生产"
    Net.NetNPCSystem:reqGoldenMineInfo(self._npcID)
    self:runBoostAnimation(true)
end

-- 注册监听事件(可选)
function GoldenMineLayer:registerListener()
    -- 全局消息回调
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_UPDATE, self, self.onDataUpdate)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_OUTPUT_RECEIVED, self, self.onOutputReceived)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_LVUP, self, self.onLvUp)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_BOOST_START, self, self.onBoostStart)

    -- 信息页面点击收取
    self:setCallback(UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_RECEIVE_OUTPUT, function()
        Net.NetNPCSystem:reqGoldenMineOutput(self._npcID) 
    end)

    -- 升级页面点击升级
    self:setCallback(UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_LVUP, function()
        if (HomeDataManager:getGoldenMineData():isMaterialChanging()) then
            UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(LanguageManager:getInstance():getLocalString(1113049)--[["下一级加速材料将会改变, 确认要升级吗?"]], function()
                Net.NetNPCSystem:reqGoldenMineLvUp(self._npcID)
            end, nil, nil, nil, nil)
        else
            Net.NetNPCSystem:reqGoldenMineLvUp(self._npcID)
        end
    end)

    -- 加速页面点击加速
    self:setCallback(UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_BOOST, function(consumeList) 
        -- Net.NetNPCSystem:reqGoldenMineBoost(self._npcID) 
        local mActivityLayer = UI.UIManager.mActivityLayer
        if mActivityLayer then
            mActivityLayer:onShowGoldenMineShowBoostPanel(consumeList, function()
                Net.NetNPCSystem:reqGoldenMineBoost(self._npcID) 
            end)
        end
    end)
end

-- 注销监听事件(可选)
function GoldenMineLayer:unRegisterListener()
    -- 全局消息回调
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_UPDATE, self, self.onDataUpdate)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_OUTPUT_RECEIVED, self, self.onOutputReceived)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_LVUP, self, self.onLvUp)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_BOOST_START, self, self.onBoostStart)
end
---------------------------------------
-- eo 事件处理 --

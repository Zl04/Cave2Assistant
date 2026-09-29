--[[
    金矿加速页面
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.home.HomeBaseAcceleratePanel"
require "app.datas.HomeDataManager"
local LanguageManager = require("app.game.LanguageManager")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local RuneFactoryAcceleratePanel = class("RuneFactoryAcceleratePanel", UI.HomeBaseAcceleratePanel)
UI.RuneFactoryAcceleratePanel = RuneFactoryAcceleratePanel

-- 设计中窗口大小
local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

-- 私有变量
local DEBUG_DRAW = false
local GRID_BG_NAME_FORMAT = "box_quality_1_%d.png"
---------------------------------------
-- eo 模块初始化 --






-- 资源统合 --
---------------------------------------
local COM_RES_LIST = {
    "ui_common_grid.plist",
}
---------------------------------------
-- eo 资源统合 --






-- 生命周期 --
---------------------------------------
-- 构造函数
function RuneFactoryAcceleratePanel:ctor()
    RuneFactoryAcceleratePanel.super.ctor(self, UI.Type.GEM_FACTORY_BOOST, resList, 0, 0)
end

-- 析构函数
function RuneFactoryAcceleratePanel:dtor()
    RuneFactoryAcceleratePanel.super.dtor(self)
end

-- 初始化
function RuneFactoryAcceleratePanel:init(hostLayer, width, height)
    RuneFactoryAcceleratePanel.super.init(self, hostLayer, width, height)
end

-- 初始化视图
function RuneFactoryAcceleratePanel:onInitView()
    RuneFactoryAcceleratePanel.super.onInitView(self)

    -- 背景
    self._greyBg1 = UI.Image:create()
    self._greyBg1:init("box_quality_box_02.png")
    self._greyBg1:center(-96, -96)
    self:addChildToQuestOffLayout(self._greyBg1)

    -- 加号
    local plusMark1 = UI.Image:create()
    plusMark1:init("ui_btn_team_add_0.png")
    plusMark1:center(-96, -96)
    self:addChildToQuestOffLayout(plusMark1)

    -- 放入道具框1
    self._materialGrid1 = UI.GoodsGrid:create()
    self._materialGrid1:init()
    self._materialGrid1:center(-96, -96)
    self._materialGrid1:hideCountLabel()
    self._materialGrid1:hideNewIcon()
    self._materialGrid1:setTouchEnable(true)
    self._materialGrid1:showInfoArea()
    self._materialGrid1:setDragOutAreaJudgeNode(self)
    self._materialGrid1:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onItemGridClick)
    self._materialGrid1:setDragBeginCallback(handler(self, self.onItemGridDragBegin))
    self._materialGrid1:setDragEndCallback(handler(self, self.onItemGridDragEnd))
    self._materialGrid1:hide()
    self:addChildToQuestOffLayout(self._materialGrid1)

    -- 放入道具标签1
    self._amountLabel1 = UI.Text:create()
    self._amountLabel1:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel1:useDefaultShadowOnlyStype()
    self._amountLabel1:center(-96, -45)
    self:addChildToQuestOffLayout(self._amountLabel1)

    -- 背景
    self._greyBg2 = UI.Image:create()
    self._greyBg2:init("box_quality_box_02.png")
    self._greyBg2:center(-9, -196)
    self:addChildToQuestOffLayout(self._greyBg2)

    -- 加号
    local plusMark2 = UI.Image:create()
    plusMark2:init("ui_btn_team_add_0.png")
    plusMark2:center(-9, -196)
    self:addChildToQuestOffLayout(plusMark2)

    -- 放入道具框2
    self._materialGrid2 = UI.GoodsGrid:create()
    self._materialGrid2:init()
    self._materialGrid2:center(-9, -196)
    self._materialGrid2:hideCountLabel()
    self._materialGrid2:hideNewIcon()
    self._materialGrid2:setTouchEnable(true)
    self._materialGrid2:showInfoArea()
    self._materialGrid2:setDragOutAreaJudgeNode(self)
    self._materialGrid2:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onItemGridClick)
    self._materialGrid2:setDragBeginCallback(handler(self, self.onItemGridDragBegin))
    self._materialGrid2:setDragEndCallback(handler(self, self.onItemGridDragEnd))
    self._materialGrid2:hide()
    self:addChildToQuestOffLayout(self._materialGrid2)

    -- 放入道具标签2
    self._amountLabel2 = UI.Text:create()
    self._amountLabel2:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel2:useDefaultShadowOnlyStype()
    self._amountLabel2:center(-9, -146)
    self:addChildToQuestOffLayout(self._amountLabel2)

    -- 背景
    self._greyBg3 = UI.Image:create()
    self._greyBg3:init("box_quality_box_02.png")
    self._greyBg3:center(78, -96)
    self:addChildToQuestOffLayout(self._greyBg3)

    -- 加号
    local plusMark3 = UI.Image:create()
    plusMark3:init("ui_btn_team_add_0.png")
    plusMark3:center(78, -96)
    self:addChildToQuestOffLayout(plusMark3)

    -- 放入道具框3
    self._materialGrid3 = UI.GoodsGrid:create()
    self._materialGrid3:init()
    self._materialGrid3:center(78, -96)
    self._materialGrid3:hideCountLabel()
    self._materialGrid3:hideNewIcon()
    self._materialGrid3:setTouchEnable(true)
    self._materialGrid3:showInfoArea()
    self._materialGrid3:setDragOutAreaJudgeNode(self)
    self._materialGrid3:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onItemGridClick)
    self._materialGrid3:setDragBeginCallback(handler(self, self.onItemGridDragBegin))
    self._materialGrid3:setDragEndCallback(handler(self, self.onItemGridDragEnd))
    self._materialGrid3:hide()
    self:addChildToQuestOffLayout(self._materialGrid3)

    -- 放入道具标签3
    self._amountLabel3 = UI.Text:create()
    self._amountLabel3:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel3:useDefaultShadowOnlyStype()
    self._amountLabel3:center(78, -45)
    self:addChildToQuestOffLayout(self._amountLabel3)

    -- 暴露一个方法返回所有的道具格子
    self._hostLayer:setCallback(UI.RUNE_FACTORY_BOOST_GET_ITEM_GRID_LIST, function()
        return {self._materialGrid1, self._materialGrid2, self._materialGrid3}
    end)
end

-- 更新视图时
function RuneFactoryAcceleratePanel:onUpdateView()
    RuneFactoryAcceleratePanel.super.onUpdateView(self)

    -- 更新颜色
    local labelList = {self._amountLabel1, self._amountLabel2, self._amountLabel3}
    local bgList = {self._greyBg1, self._greyBg2, self._greyBg3}
    local runeFactoryData = self:getConfigData()
    local boostRequirements = runeFactoryData:getBoostMaterialList()
    for i,v in ipairs(boostRequirements) do
        -- 更新标签颜色
        local labelText = AvalonUtil.getEquipmentTypeText(v.part)
        local label = labelList[i]
        if (label) then
            label:setText(labelText)
            label:setFontColor(UI.ITEM_QUALITY_FONT_COLOR[v.rarity])
        end

        -- 更新背景颜色
        local bg = bgList[i]
        if (bg) then bg:setSpriteName(string.format(GRID_BG_NAME_FORMAT, v.rarity)) end
    end

    -- 更新按钮
    self:updateBtnState()
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
-- 重载方法, 给父类返回注释文字
function RuneFactoryAcceleratePanel:getDescText()
    local runeFactoryData = self:getConfigData()
    local boostDurationHr = runeFactoryData:getCurrentBoostDuration() / 60
    local questIntervalHr = runeFactoryData:getCurrentQuestInterval() / 60
    return string.format(LanguageManager:getInstance():getLocalString(1111522), boostDurationHr, questIntervalHr) --"补足工坊材料后, 工坊会激活%d小时高速状态. 任务完成后%d小时会更新新的工坊任务."
end

-- 重载方法, 给父类返回配置文件
function RuneFactoryAcceleratePanel:getConfigData()
    return HomeDataManager:getRuneFactoryData()
end

-- 重载方法, 处理父类加速按钮点击
function RuneFactoryAcceleratePanel:onClickAccelerateBtn()
    self._hostLayer:runCallback(UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_BOOST)
end

-- 根据材料框的材料有无来更新按钮可点状态
function RuneFactoryAcceleratePanel:updateBtnState()
    local isThereAnyEmptyGrid = false
    local goodsGrids = {self._materialGrid1, self._materialGrid2, self._materialGrid3}
    for i,v in ipairs(goodsGrids) do
        if (v:getData() == nil) then
            isThereAnyEmptyGrid = true
            break
        end
    end
    if (isThereAnyEmptyGrid) then
        self._boostButton:disable()
    else
        self._boostButton:enable()
    end
end

-- 根据物品数据, 自动返回一个界面上符合条件的道具框. 优先选择空框.
function RuneFactoryAcceleratePanel:getTargetGridAndFrame(goodsData)
    if (goodsData and goodsData:getGoodsType() ~= PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then return end

    if (goodsData and (goodsData:haveGemStone() or goodsData:haveGlyph())) then return end

    local targetIdx = nil
    local goodsGrids = {self._materialGrid1, self._materialGrid2, self._materialGrid3}
    local gridFrames = {self._goodFrame1, self._goodFrame2, self._goodFrame3}
    local runeFactoryData = self:getConfigData()
    local boostRequirements = runeFactoryData:getBoostMaterialList()

    -- 找两次, 第一次找空位子, 第二次找已有位子, 空位子优先
    for j=1,2 do
        for i,v in ipairs(boostRequirements) do
            if ((j > 1 or goodsGrids[i]:getData() == nil) and 
                v.rarity <= goodsData:getGoodsRare() and 
                v.part == goodsData:getEquipmentType()) 
            then
                targetIdx = i
                break
            end
        end
        if (targetIdx) then break end
    end
    if (not targetIdx) then return end
    return goodsGrids[targetIdx], gridFrames[targetIdx]
end

-- 根据物品数据, 自动把道具图标放入一个符合条件的道具框. 使用 getTargetGridAndFrame, 和getTargetGridAndFrame返回的结果一致.
function RuneFactoryAcceleratePanel:autoPutinGoods(goodsData)
    local targetGrid, targetFrame = self:getTargetGridAndFrame(goodsData)
    if (not targetGrid) then 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111535)) --"请放入正确装备"
        return 
    end

    -- 如果道具栏里已有道具, 清空
    local oldGoodsData = targetGrid:getData()
    if oldGoodsData ~= nil then
        oldGoodsData._changeNum = 0
        targetGrid:reset()
    end

    -- 放入框
    goodsData._changeNum = -1
    targetGrid:setData(goodsData)
    targetGrid:updateView()
    targetGrid:show()
    self._hostLayer:runCallback(UI.RUNE_FACTORY_REFRESH_BAG_LIST)
end

-- 从界面上的一个道具框获取它的背景框动画
function RuneFactoryAcceleratePanel:getFrameFromGrid(grid)
    local gridList = {self._materialGrid1, self._materialGrid2, self._materialGrid3}
    local frameList = {self._goodFrame1, self._goodFrame2, self._goodFrame3}
    for i,v in ipairs(gridList) do
        if (v == grid) then 
            return frameList[i]
        end
    end
end

-- 为一个背景框播放一个指定动画
function RuneFactoryAcceleratePanel:playFrameAnimation(targetFrame, transition, loop)
    if (not targetFrame) then return end
    if (transition) then
        if (type(transition) == "table") then
            local first = true
            for i,v in ipairs(transition) do
                if (first) then 
                    first = false
                    targetFrame:setAnimation(v, false)
                else
                    targetFrame:addAnimation(v, false)
                end
            end
        else
            targetFrame:setAnimation(transition, false)
        end
        targetFrame:addAnimation(loop, true)
    else
        targetFrame:setAnimation(loop, true)
    end
end

-- 从物品数据, 自动选择一个背景框来播放动画. 使用 getTargetGridAndFrame, 保证和上面自动选择放入的物品框是同一个.
function RuneFactoryAcceleratePanel:autoTargetFrameAnimation(goodsData, transition, loop)
    local targetGrid, targetFrame = self:getTargetGridAndFrame(goodsData)
    self:playFrameAnimation(targetFrame, transition, loop)
end

-- 从道具框, 选择相应的背景框播放动画.
function RuneFactoryAcceleratePanel:gridTargetFrameAnimation(grid, transition, loop)
    local targetFrame = self:getFrameFromGrid(grid)
    self:playFrameAnimation(targetFrame, transition, loop)
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------
-- 界面上的道具框点击回调
function RuneFactoryAcceleratePanel:onItemGridClick(grid, touchPosition)

end

-- 界面上的道具框开始拖动回调
function RuneFactoryAcceleratePanel:onItemGridDragBegin(grid)
    self:gridTargetFrameAnimation(grid, "putin3", "ready2")
end

-- 界面上的道具框结束拖动回调
function RuneFactoryAcceleratePanel:onItemGridDragEnd(grid, isInGrid)
    if isInGrid then
        self:gridTargetFrameAnimation(grid, "putin1", "putin2")
        return 
    end

    local oldGoodsData = grid:getData()
    if oldGoodsData ~= nil then
        oldGoodsData._changeNum = 0
        grid:reset()
    end
    grid:updateView()
    grid:hide()
    self._hostLayer:runCallback(UI.RUNE_FACTORY_REFRESH_BAG_LIST)
    self:updateBtnState()
    self:gridTargetFrameAnimation(grid, "ready3", "begin")
end

-- 开始加速事件, 作出表现
function RuneFactoryAcceleratePanel:onBoostStart()
    self:runItemFrameAnimation("begin", "trigger")
end

-- 注册监听事件(可选)
function RuneFactoryAcceleratePanel:registerListener()
    self._hostLayer:setCallback(UI.RUNE_FACTORY_CLEAR_ITEM_GRIDS, function()
        local goodsGrids = {self._materialGrid1, self._materialGrid2, self._materialGrid3}
        for i,v in ipairs(goodsGrids) do
            v:reset()
        end
    end)

    -- 从宿主窗口传来的, 背包内物品拖动开始事件
    self._hostLayer:setCallback(UI.RUNE_FACTORY_CALLBACK_BAG_LIST_DRAG_BEGIN, function(grid, touchPosition)
        if (not self:getPanelActive()) then return end

        -- 拖入
        self:autoTargetFrameAnimation(grid:getData(), "ready1", "ready2")
    end)

    -- 从宿主窗口传来的, 背包内物品拖动结束事件
    self._hostLayer:setCallback(UI.RUNE_FACTORY_CALLBACK_BAG_LIST_DRAG_END, function(grid, touchPosition, isInBag)
        if (not self:getPanelActive()) then return end
        if (self:getConfigData():getTimeToNextQuest() > 0) then return end

        -- 统一处理拖拽取消表现
        local function dragCancelAnimiation()
            self:autoTargetFrameAnimation(grid:getData(), "ready3", "begin")
        end

        -- 如果在背包中放开, 作出取消表现
        if isInBag then 
            dragCancelAnimiation()
            return 
        end

        -- 如果不在背包中放开, 但是是锁掉的物品, 提示后做取消表现
        local goodsData = grid:getData()
        if goodsData:getIsLock() then
            UI.ScrollBar:createByText(UI.TEXT_110030)
            dragCancelAnimiation()
            return
        end

        -- 如果不在背包中放开, 并且不是装备, 作出取消表现
        local goodstype  = goodsData:getGoodsType()
        if (goodstype ~= PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT ) then 
            dragCancelAnimiation()
            return 
        end

        -- 如果不在背包中放开, 并且不满足以上取消条件. 放入满足条件的框后, 播放放入动画, 更新按钮状态.
        self:autoTargetFrameAnimation(grid:getData(), "putin1", "putin2")
        self:autoPutinGoods(goodsData)
        self:updateBtnState()
    end)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_BOOST_START, self, self.onBoostStart)
end

-- 注销监听事件(可选)
function RuneFactoryAcceleratePanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GEM_FACTORY_BOOST_START, self, self.onBoostStart)
end

---------------------------------------
-- eo 事件处理 --
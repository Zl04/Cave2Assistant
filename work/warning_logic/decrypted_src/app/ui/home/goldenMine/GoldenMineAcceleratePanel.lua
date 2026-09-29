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
local GoldenMineAcceleratePanel = class("GoldenMineAcceleratePanel", UI.HomeBaseAcceleratePanel)
UI.GoldenMineAcceleratePanel = GoldenMineAcceleratePanel

-- 设计中窗口大小
local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local COLOR_MATERIAL_AMOUNT_LABEL_NORMAL = UI.FONT_COLOR_41_41_45
local COLOR_MATERIAL_AMOUNT_LABEL_NOT_ENOUGH = UI.FONT_COLOR_80_5_5

-- 私有变量
local DEBUG_DRAW = false
---------------------------------------
-- eo 模块初始化 --






-- 资源统合 --
---------------------------------------
local COM_RES_LIST = {
}
---------------------------------------
-- eo 资源统合 --






-- 生命周期 --
---------------------------------------
-- 构造函数
function GoldenMineAcceleratePanel:ctor()
    GoldenMineAcceleratePanel.super.ctor(self, UI.Type.GOLDEN_MINE_BOOST, resList, 0, 0)
end

-- 析构函数
function GoldenMineAcceleratePanel:dtor()
    GoldenMineAcceleratePanel.super.dtor(self)
end

-- 初始化
function GoldenMineAcceleratePanel:init(hostLayer, width, height)
    GoldenMineAcceleratePanel.super.init(self, hostLayer, width, height)
end

-- 初始化视图
function GoldenMineAcceleratePanel:onInitView()
    GoldenMineAcceleratePanel.super.onInitView(self)

    -- 放入道具框1
    local goodData = self:getDummyItemDataFromId(23020001)
    self._materialGrid1 = UI.GoodsGrid:create()
    self._materialGrid1:init(goodData)
    self._materialGrid1:center(-96, -96)
    self._materialGrid1:hideCountLabel()
    self._materialGrid1:hideNewIcon()
    self._materialGrid1:setTouchEnable(true)
    self._materialGrid1:showInfoArea()
    self:addChildToQuestOffLayout(self._materialGrid1)

    -- 放入道具标签1
    self._amountLabel1 = UI.Text:create()
    self._amountLabel1:init("15/15", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel1:center(-96, -45)
    self:addChildToQuestOffLayout(self._amountLabel1)

    -- 放入道具框2
    local goodData = self:getDummyItemDataFromId(23030001)
    self._materialGrid2 = UI.GoodsGrid:create()
    self._materialGrid2:init(goodData)
    self._materialGrid2:center(-9, -196)
    self._materialGrid2:hideCountLabel()
    self._materialGrid2:hideNewIcon()
    self._materialGrid2:setTouchEnable(true)
    self._materialGrid2:showInfoArea()
    self:addChildToQuestOffLayout(self._materialGrid2)

    -- 放入道具标签2
    self._amountLabel2 = UI.Text:create()
    self._amountLabel2:init("16/16", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel2:center(-9, -146)
    self:addChildToQuestOffLayout(self._amountLabel2)

    -- 放入道具框3
    local goodData = self:getDummyItemDataFromId(22010033)
    self._materialGrid3 = UI.GoodsGrid:create()
    self._materialGrid3:init(goodData)
    self._materialGrid3:center(78, -96)
    self._materialGrid3:hideCountLabel()
    self._materialGrid3:hideNewIcon()
    self._materialGrid3:setTouchEnable(true)
    self._materialGrid3:showInfoArea()
    self:addChildToQuestOffLayout(self._materialGrid3)

    -- 放入道具标签3
    self._amountLabel3 = UI.Text:create()
    self._amountLabel3:init("17/17", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel3:center(78, -45)
    self:addChildToQuestOffLayout(self._amountLabel3)
end

-- 更新视图时
function GoldenMineAcceleratePanel:onUpdateView()
    GoldenMineAcceleratePanel.super.onUpdateView(self)

    -- 更新材料需求
    self:updateMaterialReq()
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
-- 重载父类, 获取解释文字
function GoldenMineAcceleratePanel:getDescText()
    local goldenMineData = self:getConfigData()
    local boostDurationHr = goldenMineData:getCurrentBoostDuration() / 60
    local questIntervalHr = goldenMineData:getCurrentQuestInterval() / 60
    return string.format(LanguageManager:getInstance():getLocalString(1111523), boostDurationHr, questIntervalHr) --"补足金矿材料后, 金矿会激活%d小时高速状态. 任务完成后%d小时会更新新的金矿任务."
end

-- 重载父类, 获取配置数据
function GoldenMineAcceleratePanel:getConfigData()
    return HomeDataManager:getGoldenMineData()
end

-- 重载父类, 加速按钮点击回调
function GoldenMineAcceleratePanel:onClickAccelerateBtn()
    --再check一下
    if not self:updateMaterialReq() then
        UI.ScrollBar:createByText(UI.TEXT_1213453)
        return
    end
    self._hostLayer:runCallback(UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_BOOST, self._consumeList)
end

-- 判断材料是否充足
function GoldenMineAcceleratePanel:checkCanAccelerate(materialInfo)
    local materialId = materialInfo.id
    local needAmount = materialInfo.amount
    local reqDone = false
    local havaAmount = 0
    local totalNum = 0
    local consumeList = {}

    local allConf = ConfigManager:getAllMaterialClassificationData()
    local materialList = {}
    for k,v in ipairs(allConf) do
        local materialIdStrs = v.materialId
        local mList = string.split(materialIdStrs, ";")
        for m,n in ipairs(mList) do
            if tonumber(n) == tonumber(materialId) then
                -- materialList = mList
                for i = m, #mList do
                    table.insert(materialList,mList[i])
                end
                break
            end
        end
    end


    for k,v in ipairs(materialList) do
        local itemAmount = self:getItemAmount(tonumber(v))
        if itemAmount > 0 then
            local preNum = totalNum
            totalNum = totalNum + itemAmount

            if totalNum >= needAmount then
                totalNum = needAmount
                reqDone = true
                table.insert(consumeList,{id = v, count = totalNum - preNum})
                break
            else
                table.insert(consumeList,{id = v, count = itemAmount})
            end
        end
    end


    return reqDone, totalNum, consumeList
end

-- 更新材料框表现
function GoldenMineAcceleratePanel:updateMaterialReq()
    -- 准备列表
    local gridList = {self._materialGrid1, self._materialGrid2, self._materialGrid3}
    local labelList = {self._amountLabel1, self._amountLabel2, self._amountLabel3}
    local materialList = self:getConfigData():getBoostMaterialList()
    local isAllReqDone = true
    self._consumeList = {}

    if (materialList and next(materialList) ~= nil) then
        for i,v in ipairs(gridList) do
            -- 循环准备对象
            local curGrid = gridList[i]
            local curLabel = labelList[i]
            local materialInfo = materialList[i]
            if (materialInfo) then
                local itemData = self:getDummyItemDataFromId(materialInfo.id)

                -- 更新道具槽
                if (curGrid and itemData) then
                    curGrid:setData(itemData)
                    curGrid:updateView()
                end

                -- 更新标签
                -- local itemAmount = self:getItemAmount(materialInfo.id)
                -- local isMaterialEnough = Avalon.MathUtil:checkDiamonEnough(materialInfo.amount, itemAmount)
                -- if (curLabel) then
                --     curLabel:setText(tostring(itemAmount) .. "/" .. tostring(materialInfo.amount))
                --     curLabel:setFontColor(
                --         isMaterialEnough and 
                --         COLOR_MATERIAL_AMOUNT_LABEL_NORMAL or 
                --         COLOR_MATERIAL_AMOUNT_LABEL_NOT_ENOUGH)
                -- end

                local isMaterialEnough,itemAmount,consumeList = self:checkCanAccelerate(materialInfo)

                for k,v in ipairs(consumeList) do
                    table.insert(self._consumeList,v)
                end

                if (curLabel) then
                    curLabel:setText(tostring(itemAmount) .. "/" .. tostring(materialInfo.amount))
                    local labelColor = COLOR_MATERIAL_AMOUNT_LABEL_NOT_ENOUGH
                    if isMaterialEnough then
                        if #consumeList == 1 and tonumber(materialInfo.id) == tonumber(consumeList[1].id) then
                            labelColor = COLOR_MATERIAL_AMOUNT_LABEL_NORMAL
                        else
                            labelColor = {r = 221, g = 144, b = 68}
                        end
                    else
                        labelColor = COLOR_MATERIAL_AMOUNT_LABEL_NOT_ENOUGH
                    end
                    curLabel:setFontColor(labelColor)
                end

                -- 循环计算是否满足所有条件
                isAllReqDone = isAllReqDone and isMaterialEnough
            else
                -- 没有材料信息, 隐藏槽和标签
                curGrid:hide()
                curLabel:hide()
            end
        end
    end

    -- 更新按钮
    local goldenMineData = self:getConfigData()
    if (not goldenMineData:getIsInBoost() and goldenMineData:getIsQuestAvailable() and isAllReqDone) then
        self._boostButton:enable()
        return true
    else
        self._boostButton:disable()
        return false
    end
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------
-- 加速成功事件, 更新表现
function GoldenMineAcceleratePanel:onBoostStart()
    self:runItemFrameAnimation("begin", "trigger")
end

-- 注册监听事件(可选)
function GoldenMineAcceleratePanel:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_BOOST_START, self, self.onBoostStart)
end

-- 注销监听事件(可选)
function GoldenMineAcceleratePanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HOME_GOLDEN_MINE_BOOST_START, self, self.onBoostStart)
end

---------------------------------------
-- eo 事件处理 --
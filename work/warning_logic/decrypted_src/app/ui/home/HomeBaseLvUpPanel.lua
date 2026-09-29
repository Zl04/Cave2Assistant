--[[
    家园通用升级页面
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.home.HomeBasePanel"
local LanguageManager = require("app.game.LanguageManager")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local HomeBaseLvUpPanel = class("HomeBaseLvUpPanel", UI.HomeBasePanel)
UI.HomeBaseLvUpPanel = HomeBaseLvUpPanel

-- 私有变量
local DEBUG_DRAW = false
local COLOR_MATERIAL_AMOUNT_LABEL_NORMAL = UI.FONT_COLOR_41_41_45
local COLOR_MATERIAL_AMOUNT_LABEL_NOT_ENOUGH = UI.FONT_COLOR_80_5_5
local COLOR_FONT_GREEN = {r = 36, g = 181, b = 118}
local COLOR_FONT_RED = {r = 208, g = 50, b = 60}
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
function HomeBaseLvUpPanel:ctor(...)
    HomeBaseLvUpPanel.super.ctor(self, ...)
end

-- 析构函数
function HomeBaseLvUpPanel:dtor()
    HomeBaseLvUpPanel.super.dtor(self)
    self:unRegisterListener()
    reload_script_file("app.ui.home.HomeBaseLvUpPanel")
end

-- 初始化
function HomeBaseLvUpPanel:init(hostLayer, width, height)
    self:setSize(width, height)
    self._hostLayer = hostLayer
    HomeBaseLvUpPanel.super.init(self)
    self:registerListener()
end

-- 初始化视图
function HomeBaseLvUpPanel:onInitView()
    -- 获取数据
    local configData = self:getConfigData()
    
    local rowLayout = UI.Layout:create()
    rowLayout:init()
    -- 用一个很黑得方法, 布局全无宽度来做一个很丑的全居左
    -- rowLayout:enableAutoWidth()
    rowLayout:enableAutoHeight()
    rowLayout:leftUp(90, 70)
    self:addChild(rowLayout)

    -- 当前产量排版
    local speedLayout = UI.Layout:create()
    speedLayout:init()
    speedLayout:enableAutoHeight()
    speedLayout:floatUp(-2)
    rowLayout:addComponent(speedLayout)

    -- 当前产量标签
    local speedLabel = UI.Text:create()
    speedLabel:init(LanguageManager:getInstance():getLocalString(1111511), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"当前基础产量:"
    speedLabel:floatLeft(0)
    speedLayout:addComponent(speedLabel)

    -- 当前产量数值
    self._speedText = UI.Text:create()
    self._speedText:init("300/h", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._speedText:floatLeft(10)
    speedLayout:addComponent(self._speedText)

    -- 当前产出等级排版
    self._outputLevelLayout = UI.Layout:create()
    self._outputLevelLayout:init()
    self._outputLevelLayout:enableAutoHeight()
    self._outputLevelLayout:floatUp(-2)
    rowLayout:addComponent(self._outputLevelLayout)

    -- 当前产出等级标签
    local outputLevelLabel = UI.Text:create()
    outputLevelLabel:init(LanguageManager:getInstance():getLocalString(1113042), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"当前产出符文等级:"
    outputLevelLabel:floatLeft(0)
    self._outputLevelLayout:addComponent(outputLevelLabel)

    -- 当前产出等级数值
    self._outputLevelText = UI.Text:create()
    self._outputLevelText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._outputLevelText:floatLeft(10)
    self._outputLevelLayout:addComponent(self._outputLevelText)

    -- 升级产量排版
    self._postLvSpeedLayout = UI.Layout:create()
    self._postLvSpeedLayout:init()
    self._postLvSpeedLayout:enableAutoHeight()
    self._postLvSpeedLayout:floatUp(-2)
    rowLayout:addComponent(self._postLvSpeedLayout)

    -- 升级产量标签
    local postLvSpeedLabel = UI.Text:create()
    postLvSpeedLabel:init(LanguageManager:getInstance():getLocalString(1111512), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"升级后基础产量:"
    postLvSpeedLabel:floatLeft(0)
    self._postLvSpeedLayout:addComponent(postLvSpeedLabel)

    -- 升级产量数值
    self._postLvSpeedText = UI.Text:create()
    self._postLvSpeedText:init("500/h", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, COLOR_FONT_GREEN)
    self._postLvSpeedText:floatLeft(10)
    self._postLvSpeedLayout:addComponent(self._postLvSpeedText)

    -- 楼层条件排版
    self._floorConditionLayout = UI.Layout:create()
    self._floorConditionLayout:init()
    -- 用一个很黑得方法, 布局全无宽度来做一个很丑的全居左
    -- self._floorConditionLayout:enableAutoWidth()
    self._floorConditionLayout:enableAutoHeight()
    self._floorConditionLayout:floatUp(-2)
    rowLayout:addComponent(self._floorConditionLayout)

    -- 楼层条件标签
    local floorConditionLabel = UI.Text:create()
    floorConditionLabel:init(LanguageManager:getInstance():getLocalString(1111513), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"升级条件:"
    floorConditionLabel:floatLeft(0)
    self._floorConditionLayout:addComponent(floorConditionLabel)

    -- 楼层条件文字
    local floorConditionTextSpacing = 6
    local floorConditionLabelText = UI.Text:create()
    floorConditionLabelText:init(LanguageManager:getInstance():getLocalString(1111514), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"洞窟等级"
    floorConditionLabelText:floatLeft(10)
    self._floorConditionLayout:addComponent(floorConditionLabelText)

    self._floorConditionNumText = UI.Text:create()
    self._floorConditionNumText:init("60", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, COLOR_FONT_RED)
    self._floorConditionNumText:floatLeft(floorConditionTextSpacing)
    self._floorConditionLayout:addComponent(self._floorConditionNumText)

    local floorConditionLvText = UI.Text:create()
    floorConditionLvText:init(LanguageManager:getInstance():getLocalString(1111515), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"层"
    floorConditionLvText:floatLeft(floorConditionTextSpacing)
    self._floorConditionLayout:addComponent(floorConditionLvText)

    -- NPC条件排版
    self._npcConditionLayout = UI.Layout:create()
    self._npcConditionLayout:init()
    -- 用一个很黑得方法, 布局全无宽度来做一个很丑的全居左
    -- self._npcConditionLayout:enableAutoWidth()
    self._npcConditionLayout:enableAutoHeight()
    self._npcConditionLayout:floatUp(-2)
    rowLayout:addComponent(self._npcConditionLayout)

    -- NPC条件标签
    local npcConditionLabel = UI.Text:create()
    npcConditionLabel:init(LanguageManager:getInstance():getLocalString(1111513), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"升级条件:"
    npcConditionLabel:floatLeft(0)
    self._npcConditionLayout:addComponent(npcConditionLabel)

    -- NPC条件文字
    local npcConditionTextSpacing = 6
    self._npcConditionNameText = UI.Text:create()
    self._npcConditionNameText:init(LanguageManager:getInstance():getLocalString(1111516), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"符文工房"
    self._npcConditionNameText:floatLeft(10)
    self._npcConditionLayout:addComponent(self._npcConditionNameText)

    self._npcConditionNumText = UI.Text:create()
    self._npcConditionNumText:init("10", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 208, g = 50, b = 60})
    self._npcConditionNumText:floatLeft(npcConditionTextSpacing)
    self._npcConditionLayout:addComponent(self._npcConditionNumText)

    local npcConditionLvText = UI.Text:create()
    npcConditionLvText:init(LanguageManager:getInstance():getLocalString(1111518), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"级"
    npcConditionLvText:floatLeft(npcConditionTextSpacing)
    self._npcConditionLayout:addComponent(npcConditionLvText)

    -- 升级产出等级排版
    self._nextOutputLevelLayout = UI.Layout:create()
    self._nextOutputLevelLayout:init()
    self._nextOutputLevelLayout:enableAutoHeight()
    self._nextOutputLevelLayout:floatUp(-2)
    rowLayout:addComponent(self._nextOutputLevelLayout)

    -- 升级产出等级标签
    local nextOutputLevelLabel = UI.Text:create()
    nextOutputLevelLabel:init(LanguageManager:getInstance():getLocalString(1113044), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"升级产出符文等级:"
    nextOutputLevelLabel:floatLeft(0)
    self._nextOutputLevelLayout:addComponent(nextOutputLevelLabel)

    -- 升级产出等级数值
    self._nextOutputLevelText = UI.Text:create()
    self._nextOutputLevelText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self._nextOutputLevelText:floatLeft(10)
    self._nextOutputLevelLayout:addComponent(self._nextOutputLevelText)

    -- 满级之前的排版
    self._preMaxLvLayout = UI.Layout:create()
    self._preMaxLvLayout:init()
    self._preMaxLvLayout:setSize(self:getSize())
    self:addChild(self._preMaxLvLayout)

    -- 升级前图标
    self._preLvIcon = UI.Image:create()
    self._preLvIcon:init(configData:getCurrentIcon())
    self._preLvIcon:setScale(0.5)
    self._preLvIcon:center(-99, -50)
    self._preMaxLvLayout:addChild(self._preLvIcon)

    -- 升级箭头
    self._lvArrow = UI.Animation:create()
    self._lvArrow:init("effect_ui_town_home_shengjijiantou.json", "effect_ui_town_home_shengjijiantou.atlas")
    self._lvArrow:center(-25, -27)
    self._lvArrow:setAnimation("idle")
    self._preMaxLvLayout:addChild(self._lvArrow)

    -- 升级后图标
    self._postLvIcon = UI.Image:create()
    self._postLvIcon:init("ui_home_banner_lv.png")
    self._postLvIcon:setScale(0.6)
    self._postLvIcon:center(56, -50)
    self._preMaxLvLayout:addChild(self._postLvIcon)

    -- 升级前等级LV图标
    local preLvLVIcon = UI.Image:create()
    preLvLVIcon:init("ui_home_banner_lv.png")
    preLvLVIcon:leftBottom(99, 307)
    self._preMaxLvLayout:addChild(preLvLVIcon)

    -- 升级前等级数字图标
    self._preLvNumAnchor = UI.Component:create()
    self._preLvNumAnchor:init()
    self._preLvNumAnchor:leftBottom(126, 307)
    self._preMaxLvLayout:addChild(self._preLvNumAnchor)

    -- 升级后等级LV图标
    self._postLvLVIcon = UI.Image:create()
    self._postLvLVIcon:init("ui_home_banner_lv.png")
    self._postLvLVIcon:leftBottom(255, 307)
    self._preMaxLvLayout:addChild(self._postLvLVIcon)
    
    -- 升级后等级数字图标
    self._postLvNumAnchor = UI.Component:create()
    self._postLvNumAnchor:init()
    self._postLvNumAnchor:leftBottom(278, 307)
    self._preMaxLvLayout:addChild(self._postLvNumAnchor)

    -- 消耗材料标签
    local consumption = UI.Text:create()
    consumption:init(LanguageManager:getInstance():getLocalString(1111519), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"消耗材料:"
    consumption:leftBottom(90, 276)
    self._preMaxLvLayout:addChild(consumption)

    -- 放入道具框1
    local goodData = self:getDummyItemDataFromId(23020001)
    self._materialGrid1 = UI.GoodsGrid:create()
    self._materialGrid1:init(goodData)
    self._materialGrid1:center(-96, 77)
    self._materialGrid1:hideCountLabel()
    self._materialGrid1:hideNewIcon()
    self._materialGrid1:setTouchEnable(true)
    self._materialGrid1:showInfoArea()
    self._preMaxLvLayout:addChild(self._materialGrid1)

    -- 放入道具标签1
    self._amountLabel1 = UI.Text:create()
    self._amountLabel1:init("100", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel1:center(-96, 127)
    self._preMaxLvLayout:addChild(self._amountLabel1)

    -- 放入道具框2
    local goodData = self:getDummyItemDataFromId(23030001)
    self._materialGrid2 = UI.GoodsGrid:create()
    self._materialGrid2:init(goodData)
    self._materialGrid2:center(-9, 77)
    self._materialGrid2:hideCountLabel()
    self._materialGrid2:hideNewIcon()
    self._materialGrid2:setTouchEnable(true)
    self._materialGrid2:showInfoArea()
    self._preMaxLvLayout:addChild(self._materialGrid2)

    -- 放入道具标签2
    self._amountLabel2 = UI.Text:create()
    self._amountLabel2:init("8000", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel2:center(-9, 127)
    self._preMaxLvLayout:addChild(self._amountLabel2)

    -- 放入道具框3
    local goodData = self:getDummyItemDataFromId(22010033)
    self._materialGrid3 = UI.GoodsGrid:create()
    self._materialGrid3:init(goodData)
    self._materialGrid3:center(78, 77)
    self._materialGrid3:hideCountLabel()
    self._materialGrid3:hideNewIcon()
    self._materialGrid3:setTouchEnable(true)
    self._materialGrid3:showInfoArea()
    self._preMaxLvLayout:addChild(self._materialGrid3)

    -- 放入道具标签3
    self._amountLabel3 = UI.Text:create()
    self._amountLabel3:init("10", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._amountLabel3:center(79, 127)
    self._preMaxLvLayout:addChild(self._amountLabel3)

    -- 材料框里的元素排版
    self._postMaxLvLayout = UI.Layout:create()
    self._postMaxLvLayout:init()
    self._postMaxLvLayout:setSize(self:getSize())
    self._postMaxLvLayout:leftBottom(0, 0)
    self:addChild(self._postMaxLvLayout)

    -- 满级ICON
    self._maxLvIcon = UI.Image:create()
    self._maxLvIcon:init("ui_home_banner_lv.png")
    self._maxLvIcon:setScale(0.7)
    self._maxLvIcon:center(-9, -121)
    self._postMaxLvLayout:addChild(self._maxLvIcon)

    -- 满级LV图标
    local preLvLVIcon = UI.Image:create()
    preLvLVIcon:init("ui_home_banner_lv.png")
    preLvLVIcon:leftBottom(176, 313)
    self._postMaxLvLayout:addChild(preLvLVIcon)

    -- 满级数字图标
    self._maxLvNumAnchor = UI.Component:create()
    self._maxLvNumAnchor:init()
    self._maxLvNumAnchor:leftBottom(203, 313)
    self._postMaxLvLayout:addChild(self._maxLvNumAnchor)

    -- 满级材料文字
    local maxLvText = UI.Text:create()
    maxLvText:init(LanguageManager:getInstance():getLocalString(1111560), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"已满级"
    maxLvText:center(-13, 75)
    self._postMaxLvLayout:addChild(maxLvText)

    -- 升级按钮
    self._lvUpButton = UI.Button:create()
    self._lvUpButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    self._lvUpButton:setText(LanguageManager:getInstance():getLocalString(1111520)) --"升级"
    self._lvUpButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._lvUpButton:leftBottom(119, 31)
    self._lvUpButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:onClickLvUpBtn()
    end)
    self:addChild(self._lvUpButton)
end

-- 更新视图时
function HomeBaseLvUpPanel:onUpdateView()
    -- 获取数据
    local configData = self:getConfigData()

    -- 更新速度
    local speed = configData:getCurrentBaseSpeed()
    self._speedText:setText(AvalonUtil.ConvertNumberToStringWithOptionalDecimal(speed, 2) .. "/" .. self:getUnitSymbol())

    -- 更新升级后速度
    local speedForNextLv = configData:getBaseSpeedForNextLevel()
    if (speedForNextLv ~= nil and speedForNextLv ~= 0) then
        self._postLvSpeedLayout:show()
        self._postLvSpeedText:setText(AvalonUtil.ConvertNumberToStringWithOptionalDecimal(speedForNextLv, 2) .. "/" .. self:getUnitSymbol())
    else
        self._postLvSpeedLayout:hide()
    end

    -- 更新产出等级
    local outputLevel = configData:getCurrentOutputLevel()
    if (outputLevel) then
        self._outputLevelLayout:show()
        self._outputLevelText:setText(outputLevel)
    else
        self._outputLevelLayout:hide()
    end

    -- 更新升级后的产出等级
    local nextOutputLevel = configData:getNextLevelOutputLevel()
    if (nextOutputLevel) then
        self._nextOutputLevelLayout:show()
        self._nextOutputLevelText:setText(nextOutputLevel)
        if (outputLevel == nextOutputLevel) then
            self._nextOutputLevelText:setFontColor(UI.FONT_COLOR_41_41_45)
        else
            self._nextOutputLevelText:setFontColor(COLOR_FONT_GREEN)
        end
    else
        self._nextOutputLevelLayout:hide()
    end

    -- 更新图标
    local level = configData:getCurrentLevel()
    local maxLevel = configData:getMaxLevel()
    if (level ~= nil and maxLevel ~= nil) then
        -- 更新图标1
        self._preLvIcon:setSpriteName(configData:getCurrentIcon())

        -- 更新等级图标1
        local styleNum = AvalonUtil:getStyledNumberNode(level)
        styleNum:leftBottom(0, 0)
        self._preLvNumAnchor:removeAllChildren()
        self._preLvNumAnchor:addChild(styleNum)

        if (level < maxLevel) then
            -- 更新图标2
            self._postLvIcon:setSpriteName(configData:getIconForNextLevel())

            -- 更新等级图标2
            local styleNum = AvalonUtil:getStyledNumberNode(level + 1)
            styleNum:leftBottom(0, 0)
            self._postLvNumAnchor:removeAllChildren()
            self._postLvNumAnchor:addChild(styleNum)
        else
            self._postLvLVIcon:hide()
            self._postLvIcon:hide()
            self._postLvNumAnchor:hide()
            self._lvArrow:hide()
        end
    end

    -- 更新材料需求
    local isHavingAllMaterial = self:updateMaterialReq()

    -- 更新楼层条件
    local floorReq = self:getFloorReq()
    if (floorReq and floorReq ~= 0) then
        self._floorConditionLayout:show()
        self._floorConditionNumText:setText(tostring(floorReq))
        self._floorConditionLayout:updateView()
    else
        self._floorConditionLayout:hide()
    end

    -- 更新NPC等级条件
    local npcID, npcName, npcLv = self:getNPCReq()
    if (npcID and npcName and npcLv) then
        self._npcConditionLayout:show()
        self._npcConditionNameText:setText(npcName)
        self._npcConditionNumText:setText(tostring(npcLv))
        self._npcConditionLayout:updateView()
    else
        self._npcConditionLayout:hide()
    end

    -- 更新字体颜色
    local bFloorCond = self:isFloorConditionMet()
    local bNPCCond = self:isNPCConditionMet()
    if (bFloorCond) then
        self._floorConditionNumText:setFontColor(COLOR_FONT_GREEN)
    else
        self._floorConditionNumText:setFontColor(COLOR_FONT_RED)
    end
    if (bNPCCond) then
        self._npcConditionNumText:setFontColor(COLOR_FONT_GREEN)
    else
        self._npcConditionNumText:setFontColor(COLOR_FONT_RED)
    end

    -- 更新按钮状态
    if (isHavingAllMaterial and 
        bFloorCond and
        bNPCCond and 
        level < maxLevel)
    then
        self._lvUpButton:enable()
    else
        self._lvUpButton:disable()
    end

    -- 更新等级排版
    if (level < maxLevel) then
        self._preMaxLvLayout:show()
        self._postMaxLvLayout:hide()
    else
        self._preMaxLvLayout:hide()
        self._postMaxLvLayout:show()

        -- 更新满级图标
        self._maxLvIcon:setSpriteName(configData:getCurrentIcon())

        -- 更新更新满级等级
        local styleNum = AvalonUtil:getStyledNumberNode(level)
        styleNum:leftBottom(0, 0)
        self._maxLvNumAnchor:removeAllChildren()
        self._maxLvNumAnchor:addChild(styleNum)
    end
end
---------------------------------------
-- eo 生命周期 --







-- 通用逻辑 --
---------------------------------------
-- 从物品ID获取一个物品数据
function HomeBaseLvUpPanel:getDummyItemDataFromId(id)
    if (id == 0) then return end
    local goodData = GoodsDataManager:createLocalGoodsData(id) --23030001
    if goodData then
        goodData:setNum(0)
        goodData:setIsNew(false)
        goodData.isHaveGet = false
    end
    return goodData
end

-- 获取拥有物品数量
function HomeBaseLvUpPanel:getItemAmount(id)
    if (id == 0) then return 0 end
    local goodsNum = GoodsDataManager:getGoodsDataNum(RoleDataManager:getMasterPK(), PublicDefine.PACKET_TYPE.PACKET_BAG, id, true)
    if (id == 23020001) then
        local GameDataManager = require("app.game.GameDataManager")
        goodsNum = GameDataManager:getInstance():getCurCoin()
    elseif (id == 23030001) then
        local GameDataManager = require("app.game.GameDataManager")
        goodsNum = GameDataManager:getInstance():getDiamond()
    end
    return goodsNum or 0
end

-- 更新需要物品和数量的表现
function HomeBaseLvUpPanel:updateMaterialReq()
    -- 准备列表
    local gridList = {self._materialGrid1, self._materialGrid2, self._materialGrid3}
    local labelList = {self._amountLabel1, self._amountLabel2, self._amountLabel3}
    local materialList = self:getConfigData():getLvUpMaterialList()
    local isHavingAllMaterial = true

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
                    curGrid:show()
                    curGrid:setData(itemData)
                    curGrid:updateView()
                end

                -- 更新标签
                local havingAmount = self:getItemAmount(materialInfo.id)
                local isMaterialEnough = Avalon.MathUtil:checkDiamonEnough(materialInfo.amount, havingAmount)
                if (curLabel) then
                    curLabel:show()
                    -- add by zp 这里专门特殊处理
                    curLabel:setText(AvalonUtil:getTargetFormatedNum(materialInfo.amount, 10000000))
                    curLabel:setFontColor(
                        isMaterialEnough and 
                        COLOR_MATERIAL_AMOUNT_LABEL_NORMAL or 
                        COLOR_MATERIAL_AMOUNT_LABEL_NOT_ENOUGH)
                end

                -- 循环计算是否满足所有条件
                isHavingAllMaterial = isHavingAllMaterial and isMaterialEnough
            else
                -- 没有材料信息, 隐藏槽和标签
                if (curGrid) then curGrid:hide() end
                if (curLabel) then curLabel:hide() end
            end
        end
    end
    return isHavingAllMaterial
end

-- 更新楼层条件表现
function HomeBaseLvUpPanel:getFloorReq()
    local configData = self:getConfigData()
    local floorReq = configData:getLvUpFloorCondition()
    if (math.floor(floorReq / 100) == 101) then
        floorReq = floorReq % 100 * 10
    end
    return floorReq or 0
end

-- 更新NPC条件表现
function HomeBaseLvUpPanel:getNPCReq()
    local configData = self:getConfigData()
    local npcID, npcLv = configData:getLvUpNPCCondition()
    if (npcID == 0 or npcLv == 0) then return end

    local npcName = ""
    if (npcID == 1) then
        npcName = LanguageManager:getInstance():getLocalString(1111517) --"金矿"
    elseif (npcID == 2) then
        npcName = LanguageManager:getInstance():getLocalString(1111516) --"符文工坊"
    end 
    return npcID, npcName, npcLv
end

-- 返回是否满足楼层条件
function HomeBaseLvUpPanel:isFloorConditionMet()
    local GameDataManager = require("app.game.GameDataManager")
    local maxLevelData = GameDataManager:getMaster():getMaxLevelData(PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    local maxLevel = maxLevelData:getMaxLevel()
    return maxLevel >= self:getFloorReq()
end

-- 返回是否满足NPC条件
function HomeBaseLvUpPanel:isNPCConditionMet()
    local npcConditionMet = true
    local npcId, npcName, npcLv = self:getNPCReq()
    if (npcId == 1) then
        npcConditionMet = HomeDataManager:getGoldenMineData():getCurrentLevel() >= npcLv
    elseif (npcId == 2) then
        npcConditionMet = HomeDataManager:getRuneFactoryData():getCurrentLevel() >= npcLv
    end
    return npcConditionMet
end

-- 需要子类重载, 获取配置数据
function HomeBaseLvUpPanel:getConfigData()
    printError("HomeBaseLvUpPanel:getConfigData 请重载")
end

-- 需要子类重载, 升级按钮点击回调
function HomeBaseLvUpPanel:onClickLvUpBtn()
    printError("HomeBaseLvUpPanel:onClickRecvBtn 请重载")
end

-- 需要子类重载, 获取单位字符
function HomeBaseLvUpPanel:getUnitSymbol()
    printError("HomeBaseInfoPanel:getUnitSymbol 请重载")
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------
function HomeBaseLvUpPanel:onCurrencyChangeHandler(data)
    if (data) then
        self:updateView()
    end
end

-- 注册监听事件(可选)
function HomeBaseLvUpPanel:registerListener()
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

-- 注销监听事件(可选)
function HomeBaseLvUpPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end
---------------------------------------
-- eo 事件处理 --
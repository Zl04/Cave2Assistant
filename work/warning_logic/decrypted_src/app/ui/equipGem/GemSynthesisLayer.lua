-- GemSynthesisLayer.lua
-- Author:ydli
-- 2018年6月11日
-- Using:宝石合成
require "app.ui.shoplayer.BagGoodsPanel"
local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local model = require("app.uiExport.GemSynthModel")
require("app.ui.common.RewardLayer")
UI = UI or {}

local GemSynthesisLayer = class("GemSynthesisLayer", UI.DoorWin)
UI.GemSynthesisLayer = GemSynthesisLayer
local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(341, 632)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_gem.plist"
}

GEM_LAYER_TYPE = {
    SYNTHESIS = 1, --合成界面
    TRANSFORM = 2 --转换界面
}

local GridPos = {
    CENTER = 0,
    LEFT = 1,
    RIGHT = 2,
    TOP = 3,
    BOTTOM = 4
}

--构造函数(必备)
function GemSynthesisLayer:ctor(spriteID, type)
    --窗口大小
    if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        GemSynthesisLayer.super.ctor(self, UIType.EQUIP_GEM_TRANSFORM, COM_RES_LIST, leftSize.width, winSize.height)
    else
        GemSynthesisLayer.super.ctor(self, UIType.EQUIP_GEM_SYNTHESIS, COM_RES_LIST, leftSize.width, winSize.height)
    end
    self.spriteID = spriteID
    self.mRect = nil --判断区域框
    self.mGoodsData = nil --装备
    self.mGoodsGrid = nil --装备框
    self.gemstoneData = nil
    self.isAction = false -- 正在播放动画
    self.layerType = type
    self.mMaterialGoodsGrid = {}
    self.animationReadyStatus = {}
    self.animationReadyStatus["0"] = false
    self.animationReadyStatus["1"] = false
    self.animationReadyStatus["2"] = false
    self.animationReadyStatus["3"] = false
    self.animationReadyStatus["4"] = false
    self:init()
    self:registerListener()
end

--虚构函数,destroy时调用(必备)
function GemSynthesisLayer:dtor()
    GemSynthesisLayer.super.dtor(self)
    self.mMaterialGoodsGrid = {}
    self:unRegisterListener()
    if self._bagGridList then
        self._bagGridList:setRefreshFlag(true)
    end
    reload_script_file("app.ui.equipGem.GemSynthesisLayer")
end

-- 初始化(必备)
function GemSynthesisLayer:init()
    self.doSynthAnimationNow = nil

    GemSynthesisLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function GemSynthesisLayer:onInitView()
    -- self:addColorBG()        --灰色遮罩层
    self.gemModel = model.create()
    self.leftLayer = self.gemModel.root
    self:addChild(self.leftLayer, 3)

    self.gemModel.centerGridAnimation:setLocalZOrder(10)
    self:initAnimation(self.gemModel.centerGridAnimation, "hint_begin_blue")
    self:initAnimation(self.gemModel.topGrid, "hint_begin_blue")
    self:initAnimation(self.gemModel.leftGrid, "hint_begin_blue")
    self:initAnimation(self.gemModel.bottomGrid, "hint_begin_blue")
    self:initAnimation(self.gemModel.rightGrid, "hint_begin_blue")
    -- self:initAnimation(self.gemModel.centerGrid, "hint_begin_blue")

    local desc = self.gemModel.desStr
    self.mTxtStrengthen = self.gemModel.executeButtonLabelGem

    if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        -- self:createMeterialGrid(self.gemModel.centerGrid, 1, GridPos.CENTER)
        -- self.gemModel.centerGrid:setLocalZOrder(11)
        -- self:createMeterialGrid(self.gemModel.leftGrid, 2, GridPos.LEFT)
        self.gemModel.gemSynthesisAnimation:setAnimationData(
            "effect_ui_town_gem_di_inlay.json",
            "effect_ui_town_gem_di_inlay.atlas",
            1
        )
        self:initAnimation(self.gemModel.gemSynthesisAnimation, "hint_begin_colour")
        desc:setText(UI.TEXT_1172006)
        self.mTxtStrengthen:setText(UI.TEXT_1172005)
        self.gemModel.topGrid:setVisible(false)
        self.gemModel.bottomGrid:setVisible(false)
        self.gemModel.rightGrid:setVisible(false)
        self.gemModel.leftGrid:setVisible(false)
    else
        self:initAnimation(self.gemModel.gemSynthesisAnimation, "success")
        self:createMeterialGrid(self.gemModel.rightGrid, 1, GridPos.RIGHT)
        self:createMeterialGrid(self.gemModel.bottomGrid, 2, GridPos.BOTTOM)
        self:createMeterialGrid(self.gemModel.leftGrid, 3, GridPos.LEFT)
        self:createMeterialGrid(self.gemModel.topGrid, 4, GridPos.TOP)
    end

    --btn
    self.mBtnSynthesis = self.gemModel.executeButtonGem
    self.mBtnSynthesis:addEventListener(UIEvent.BUTTON_CLICK, self, self.onSynthesis)
    AvalonUtil.addBracketsAnimationToButton(self.mBtnSynthesis)

    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        local oneKeyButtonGem = UI.Button:create()
        oneKeyButtonGem:init("ui_btn_stone1_0.png", "ui_btn_stone1_1.png", "ui_btn_stone1_2.png", {x=0, y=0})
        oneKeyButtonGem._clickScale = false
        oneKeyButtonGem._baseline = 1
        oneKeyButtonGem:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=220,g=182,b=80})
        oneKeyButtonGem:setLayoutType(UI.LayoutDefaultType.CENTER_BOTTOM)
        oneKeyButtonGem:setReflectPos(0, 35 + 61)
        oneKeyButtonGem:computePosition()
        self.leftLayer:addChild(oneKeyButtonGem)
        oneKeyButtonGem:setName("oneKeyButtonGem")
        oneKeyButtonGem:setText(UI.TEXT_1325302)
        oneKeyButtonGem:addEventListener(UIEvent.BUTTON_CLICK, self, self.oneKeySynthesis)
        AvalonUtil.addBracketsAnimationToButton(oneKeyButtonGem)

        self.gemModel.scrollView:setSize(207, 166)
        self.gemModel.scrollView:centerBottom(149)
        self.gemModel.scrollLayout:computePosition()
    end
    self:updateBtnState(false)

    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:center()
    self.mGoodsGrid:hide()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self.mGoodsGrid:showInfoArea()
    self.mGoodsGrid:setTouchEnable(true)
    self.mGoodsGrid.index = 0
    self.mGoodsGrid.state = 1
    self.gemModel.centerGridAnimation:addChild(self.mGoodsGrid, 10)

    -- -- 装备框
    -- local kuangAnimation = UI.Animation:create()
    -- kuangAnimation:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas")
    -- kuangAnimation:center()
    -- self.gemModel.centerGridAnimation = kuangAnimation
    -- kuangAnimation:setAnimation("hint_begin_blue", false)
    -- kuangAnimation:updateTime(0)
    -- kuangAnimation:setTimeScale(0)

    local jsonFileName = "effect_ui_town_gem_kuang_da_success_yellow.json"
    if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        jsonFileName = "effect_ui_town_gem_kuang_da_success_yellow.json"
    end
    local successAnimation = UI.Animation:create()
    successAnimation:init(jsonFileName, "effect_ui_town_gem_kuang_da.atlas")
    successAnimation:center()
    -- kuangAnimation:addChild(successAnimation)
    self.mGoodsGrid.successAnimation = successAnimation
    self.gemModel.centerGridAnimation:addChild(successAnimation, 10)

    local initUsedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_GEM_STONE
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        _usedType1.stoneLockMaxLV = true
        _usedType1.gemStoneType = nil
    end
    _usedType1.type = 0 --"all"
    self.initUsedTypeList = initUsedTypeList
    table.insert(initUsedTypeList, _usedType1)

    --右边背包数据
    local bagList = UI.BagGoodsPanel:create(initUsedTypeList, true, false)

    if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        bagList:setHideBagType(
            {
                UI.BagGoodsPanel.BAG_TYPE.ALL,
                UI.BagGoodsPanel.BAG_TYPE.ITEM,
                UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
                UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
                UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
                UI.BagGoodsPanel.BAG_TYPE.RELIC,
            }
        )
        bagList:setShowBagTagExt(
            {
                UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
            }
        )
    else
        bagList:setHideBagType(
            {
                UI.BagGoodsPanel.BAG_TYPE.ALL,
                UI.BagGoodsPanel.BAG_TYPE.ITEM,
                UI.BagGoodsPanel.BAG_TYPE.MATERIAL,
                UI.BagGoodsPanel.BAG_TYPE.EQUIPMENT,
                UI.BagGoodsPanel.BAG_TYPE.WEAR_EQUIP,
                UI.BagGoodsPanel.BAG_TYPE.RELIC,
            }
        )
        bagList:setShowBagTagExt(
            {
                UI.BagGoodsPanel.BAG_TYPE.GEM_STONE_EQUIP_WEAR,
                UI.BagGoodsPanel.BAG_TYPE.GEM_STONE_EQUIP,
                UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
                
            }
        )
    end
    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    bagList:rightBottom(-winSize.width, (winSize.height - leftSize.height) / 2 - 10)
    self._bagGridList = bagList
    self:addChild(bagList, 2)
    self._bagGridList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.GEM_STONE)
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111256))
    else
        GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111259))
    end

    self.gemModel.gemSynthesisAnimation:addEventListener(
        UIEvent.ANIMATION_COMPLETE,
        self,
        function(sender, event)
            if event.animation == "success" then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, self.toShowGoodsList,
                function()
                    if tolua.isnull(self) or not self.mGoodsGrid then
                        return
                    end
                    self.mGoodsGrid:reset()
                    self.mGoodsGrid:hideIcon()
                    self.mGoodsGrid:hide()
                    if self.gemstoneData then
                        self.gemstoneData._changeNum = 0
                    end
                    self.gemstoneData = nil

                    -- add by 在出现多碟的时候，新合成的宝石无法显示出来，由于  .changeNum = -1 导致，这里强制归零
                    local goodsArr = GoodsDataManager:getGoodsArrForPK(RoleDataManager:getMasterPK(), 1 ,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
                    if goodsArr then 
                        for k, v in ipairs(goodsArr) do 
                            v._changeNum = 0
                        end
                    end

                    -- 恢复数据信息
                    self:clearMaterialGoodsGrid()

                    self.initUsedTypeList[1].stoneShowLV = nil
                    self.initUsedTypeList[1].transDropGroupID = nil
                    self.initUsedTypeList[1].gemStoneType = nil
                    self._bagGridList:setUsedType(self.initUsedTypeList)
                    self._bagGridList:refreshView()


                    self:runCancelReadyAnimtion(self.mGoodsGrid.index, true)
                    self:updateBtnState(false)
                    self.doSynthAnimationNow = false
                end
            ,nil,nil, UI.RewardLayer.Style.notShowAnyButton)
            end
        end
    )

    self.gemModel.gemSynthesisAnimation:addEventListener(
        UIEvent.ANIMATION_EVENT,
        self,
        function(sender, event)
            if (event and event.eventData) then
                if
                    event.eventData.name == "event_synthetise_success_yellow_kunag_da" or
                        event.eventData.name == "event_transform_success_yellow_blue_da" or
                        event.eventData.name == "event_inlay_success_kuang_colour"
                 then
                    self.mGoodsGrid.successAnimation:setAnimation(self.toRunAnimationName, false)
                elseif
                    event.eventData.name == "event_synthetise_success_yellow_kunag_xiao" or
                        event.eventData.name == "event_transform_success_yellow_blue_xiao"
                 then
                    for k, v in pairs(self.mMaterialGoodsGrid) do
                        v.successAnimation:setAnimation(self.toRunAnimationName, false)
                    end
                end
            end
        end
    )
    self:refreshCurrency()
end
local LAYOUT_SIZE_WIDTH = 230

local GRID_SIZE_WIDTH  = 44 
local GRID_SIZE_HEIGHT = 44 
local SPRITE_EQUIPMENT_AREA_POINT = "ui_iteminfo_icon_point_01.png"
function GemSynthesisLayer:showAttrInfoArea(data, nextStoneData)
    if self.attrInfoArea then
        self.attrInfoArea:removeFromParent()
        self.attrInfoArea = nil
    end
    if not data then
        self.gemModel.desStr:setVisible(true)
        self.gemModel.scrollView:setVisible(true)
        return
    end
    self.gemModel.desStr:setVisible(false)
    self.gemModel.scrollView:setVisible(false)
    
    self.attrInfoArea = UI.Component:create()
    self.attrInfoArea:setSize(LAYOUT_SIZE_WIDTH, 218)
    self.attrInfoArea:init()
    self.attrInfoArea:leftBottom(55, 105)
    self.leftLayer:addChild(self.attrInfoArea, 10001)

    local black = UI.Image:create()
    black:init("ui_gem_black.png")
    black:centerUp(0)
    self.attrInfoArea:addChild(black,2)
    
    -- 道具名字
    local name = data:getName() .. "(LV." .. data:getStoneLV() .. ")"
    local  goodsName  = UIUtil:createAdaptTextComponent(name,  
        UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194,225,34)
    goodsName:center()
    black:addChild(goodsName)

    -- 属性显示区域
    local layout = self.attrInfoArea
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        layout = UI.Layout:create()
        layout:init()
        layout:setSize(LAYOUT_SIZE_WIDTH, 218)

        local scrollView = UI.ScrollView:create()
        scrollView:setSize(LAYOUT_SIZE_WIDTH, 177)
        scrollView:init()
        scrollView:addInnerNode(layout)
        scrollView:useDefaultScrollBar()
        scrollView:leftUp(0, 0)
        self.attrInfoArea:addChild(scrollView)
    end

    -- 显示属性信息
    local totalHeight = 0
    local leftOffset = 5
    local oneHeight = 20
    local k = 0
    local centerOffsetUp = 13.5
    local pointOffsetY = -1

    local normalDetailArr = data:getNormalDetailDescription()
    local height = 120
    if normalDetailArr and #normalDetailArr > 0 then
        for i, data in ipairs(normalDetailArr) do
            local baseText = UI.Text:create()
            baseText:init(string.format("%s", data[1]) .. string.format("%s", data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            baseText:centerBottom(height)
            layout:addChild(baseText)
            height = height + 30
        end
    else
        local specialDes = data:getSpecialDetailDescription()
        if specialDes then 
            local baseText = UI.Text:create()
            baseText:init(specialDes, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            baseText:setTextCenter()
            baseText:setWidth(220)
            baseText:setText(specialDes)
            layout:addChild(baseText)
            local content = baseText:getContentSize()
            baseText:centerBottom(145-content.height/2)
        end
    end


    if nextStoneData then
        local normalDetailArr = nextStoneData:getNormalDetailDescription()
        if normalDetailArr and #normalDetailArr > 0 then
            local black = UI.Image:create()
            black:init("ui_information_arrow_under.png")
            black:centerUp(108)
            layout:addChild(black)
            height = 40
            for i, data in ipairs(normalDetailArr) do
                local baseText = UI.Text:create()
                baseText:init(string.format("%s", data[1]) .. string.format("%s", data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_36_181_118)
                baseText:centerBottom(height)
                layout:addChild(baseText)
                height = height - 30
            end
        else
            local black = UI.Image:create()
            black:init("ui_information_arrow_under.png")
            black:centerUp(108)
            layout:addChild(black)

            local specialDes = nextStoneData:getSpecialDetailDescription()
            if specialDes then 
                local baseText = UI.Text:create()
                baseText:init(specialDes, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
                baseText:setTextCenter()
                baseText:setWidth(220)
                baseText:setText(specialDes)
                layout:addChild(baseText)
                
                local content = baseText:getContentSize()
                baseText:centerBottom(-content.height/2 + 40)
            end
        end
    end
end

function GemSynthesisLayer:createAttrInfo(normalDetailArr, color)
     -- 属性显示区域
     local layout = UI.Layout:create()
     layout:init()
 
     if normalDetailArr then
        local height = 0
         for i, data in ipairs(normalDetailArr) do
             local baseText = UI.Text:create()
             baseText:init(string.format("%s", data[1])..string.format("%s", data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, color or UI.FONT_COLOR_41_41_45)
             baseText:centerBottom(textUp)
             layout:addChild(baseText)
             height = height + 30
         end
     end

     return layout
end

function GemSynthesisLayer:createMeterialGrid(parentNode, index, dir)
    local _materialGoodsGrid = UI.GoodsGrid:create()
    _materialGoodsGrid:init()
    _materialGoodsGrid.index = index
    _materialGoodsGrid:center()
    _materialGoodsGrid:hide()
    _materialGoodsGrid:hideCountLabel()
    _materialGoodsGrid:hideNewIcon()
    _materialGoodsGrid:showInfoArea()
    parentNode:addChild(_materialGoodsGrid)
    _materialGoodsGrid.animtionNode = parentNode
    _materialGoodsGrid:setTouchEnable(true)
    _materialGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    _materialGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByMaterialGoodsGrid))
    _materialGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByMaterialGoodsGrid))
    table.insert(self.mMaterialGoodsGrid, _materialGoodsGrid)

    local jsonFileName = "effect_ui_town_gem_kuang_xiao_success_yellow.json"
    if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        jsonFileName = "effect_ui_town_gem_kuang_xiao_success_blue.json"
    end
    local successAnimation = UI.Animation:create()
    successAnimation:init(jsonFileName, "effect_ui_town_gem_kuang_xiao.atlas")
    successAnimation:center()
    _materialGoodsGrid.successAnimation = successAnimation

    parentNode:addChild(successAnimation, 10)
    local rotate = 0
    if dir == GridPos.TOP then
        rotate = 270
    elseif dir == GridPos.LEFT then
        rotate = 180
    elseif dir == GridPos.BOTTOM then
        rotate = 90
    end
    successAnimation:setRotation(rotate)
end

function GemSynthesisLayer:initAnimation(animationNode, animationName)
    animationNode:setAnimation(animationName)
    animationNode:updateTime(0)
    animationNode:setTimeScale(0)
end

-- 准备放入动画
function GemSynthesisLayer:runReadyAnimtion(index, isDragOut)
    local animationName = "hint_begin_blue"
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        animationName = "hint_begin_yellow"
    end
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        if (index == 0 or index == nil) and (self.mGoodsGrid:getData() == nil or isDragOut) then
            self.gemModel.centerGridAnimation:setAnimation(animationName, false)
            self.gemModel.centerGridAnimation:setTimeScale(1)
            self.animationReadyStatus["0"] = true
        end
    else
        self.gemModel.centerGridAnimation:setAnimation("hint_begin_yellow", false)
        self.gemModel.centerGridAnimation:addAnimation("hint_idle_yellow", true)
        self.gemModel.centerGridAnimation:setTimeScale(1)

        self.gemModel.gemSynthesisAnimation:setAnimation("hint_begin_colour", false)
        self.gemModel.gemSynthesisAnimation:addAnimation("hint_idle_colour", true)
        self.gemModel.gemSynthesisAnimation:setTimeScale(1)
    end

    for k, v in pairs(self.mMaterialGoodsGrid) do
        if (k == index or index == nil) and (v:getData() == nil or isDragOut) then
            v.animtionNode:setAnimation(animationName, false)
            v.animtionNode:setTimeScale(1)
            self.animationReadyStatus[tostring(k)] = true
        end
    end
end

-- 取消准备放入动画
function GemSynthesisLayer:runCancelReadyAnimtion(index, isDragOut)
    local animationName = "hint_end_blue"
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        animationName = "hint_end_yellow"
    end
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        if
            (index == 0 or index == nil) and (self.mGoodsGrid:getData() == nil) and
                self.layerType == GEM_LAYER_TYPE.SYNTHESIS
         then
            self.gemModel.centerGridAnimation:setToSetupPose()
            self.gemModel.centerGridAnimation:setTimeScale(1)
            self.gemModel.centerGridAnimation:setAnimation(animationName, false)
            self.animationReadyStatus["0"] = false
        end
    else
        self.gemModel.centerGridAnimation:setToSetupPose()
        self.gemModel.centerGridAnimation:setAnimation("hint_end_yellow", false)
        self.gemModel.centerGridAnimation:setTimeScale(1)
        -- print("准备动画")
        self.gemModel.centerGridAnimation:setAnimation("hint_end_colour", false)
    end
    for k, v in pairs(self.mMaterialGoodsGrid) do
        if (k == index or index == nil) and (v:getData() == nil) then
            v.animtionNode:setToSetupPose()
            v.animtionNode:setTimeScale(1)
            v.animtionNode:setAnimation(animationName, false)
            self.animationReadyStatus[tostring(k)] = false
        end
    end
    self:refreshCurrency()
end

-- 放入动画
function GemSynthesisLayer:runPutAnimtion(index, isDragOut)
    local animationName = "enchase_blue"
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        animationName = "enchase_yellow"
    end
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
            if index == 0 then
                self.gemModel.centerGridAnimation:setAnimation(animationName, false)
            else
                if self.animationReadyStatus["0"] then
                    self:runCancelReadyAnimtion(0, isDragOut)
                end
            end
        end
    else
        --转换放入材料时，清空中间格子
        -- self.mGoodsGrid:reset()
        -- self.mGoodsGrid:hide()
        self.gemModel.centerGridAnimation:setAnimation("enchase_yellow", false)
        self.gemModel.centerGridAnimation:setTimeScale(1)
        self.gemModel.gemSynthesisAnimation:setAnimation("hint_end_colour", false)
    end
    for k, v in pairs(self.mMaterialGoodsGrid) do
        if k == index then
            v.animtionNode:setAnimation(animationName, false)
        else
            if self.animationReadyStatus[tostring(k)] then
                self:runCancelReadyAnimtion(k, isDragOut)
            end
        end
    end
    self:refreshCurrency()
end

function GemSynthesisLayer:runSuccessAnimtion()
    local name = "success_yellow"
    if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        name = "success_yellow"
        self.gemModel.gemSynthesisAnimation:setAnimation("success_colour", false)
    else
        self.gemModel.gemSynthesisAnimation:setAnimation("success", false)
    end

    self.gemModel.gemSynthesisAnimation:setTimeScale(1)
    self.toRunAnimationName = name
    self:spineRemouldCallback()
end

function GemSynthesisLayer:bagDragBeganCallback(grid, touchPosition)
    if (grid) then
        grid:hideSelect()
    end
    self:runReadyAnimtion()
    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
end

function GemSynthesisLayer:bagDragEndedCallback(grid, touchPosition, isInBag)
    if (self._bagGridList) then
        self._bagGridList:setSpineBgVisible(false)
    end
    if not isInBag then
        local goodsData = grid:getData()
        if goodsData and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
            if(self.isAction) then
            	self:runCancelReadyAnimtion()
                return
            end
            
            --如果是合成功能 且 是第一个拖到合成界面的宝石，默认放在主宝石位置
            --先根据玩家放手的落点 放到对应的格子， 如格子里面已有宝石 则替换， 否则直接放入；
            --如果玩家不是对应的格子的落点（且有空格子） 则根据格子顺序判断哪个为空，往空格子里面放
            -- if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
            if self.gemstoneData == nil then
                self:refreshMainGem(goodsData)
                return
            end
            if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
                local t = self.mGoodsGrid:convertToWorldSpace(cc.p(0, 0))
                local space = 3
                local _rect =
                    cc.rect(
                    t.x - space,
                    t.y - space,
                    self.mGoodsGrid._width + space * 2,
                    self.mGoodsGrid._height + space * 2
                )
                if cc.rectContainsPoint(_rect, touchPosition) then
                    self:refreshMainGem(goodsData)
                    return
                end
            else
                self:refreshMainGem(goodsData)
                return
            end
            if goodsData:getIsLock() then
                UI.ScrollBar:createByText(UI.TEXT_110030)
                self:runCancelReadyAnimtion()
                return
            end

            if goodsData.isEquiped then
                UI.ScrollBar:createByText(UI.TEXT_1212873)
                self:runCancelReadyAnimtion()
                return
            end

            -- 判断是否品质一样
            if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
                if(self.gemstoneData and self.gemstoneData:getStoneLV() ~= goodsData:getStoneLV()) then
                        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170183))
                        self:runCancelReadyAnimtion()
                        return 
                end
            end

            for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
                local t = materialGoodsGrid:convertToWorldSpace(cc.p(0, 0))
                local space = 30
                local _rect =
                    cc.rect(
                    t.x - space,
                    t.y - space,
                    materialGoodsGrid._width + space * 2,
                    materialGoodsGrid._height + space * 2
                )
                if cc.rectContainsPoint(_rect, touchPosition) then
                    local goodsData2 = materialGoodsGrid:getData()
                    if goodsData2 ~= nil then
                        goodsData2._changeNum = goodsData2._changeNum + 1
                    end
                    -- goodsData:setNum(1)
                    materialGoodsGrid:setData(goodsData)
                    goodsData._changeNum = goodsData._changeNum - 1
                    self:refreshGoodsGrid(k)
                    self:runPutAnimtion(materialGoodsGrid.index)
                    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
                        self.initUsedTypeList[1].stoneShowLV = goodsData:getStoneLV()
                        self.initUsedTypeList[1].gemStoneType = goodsData:getGemStoneType()
                    else
                        -- self.initUsedTypeList[1].transDropGroupID = goodsData:getTransDropGroupID()
                    end
                    self._bagGridList:setUsedType(self.initUsedTypeList)
                    self._bagGridList:refreshView()
                    return
                end
            end
            local count = goodsData:getNum() + goodsData:getChangeNum()
            if count <= 0 then
                return
            end
            
            for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
                local goodsData2 = materialGoodsGrid:getData()
                if goodsData2 == nil then
                    -- goodsData:setNum(1)
                    materialGoodsGrid:setData(goodsData)
                    goodsData._changeNum = goodsData._changeNum - 1
                    self:refreshGoodsGrid(k)
                    self:runPutAnimtion(materialGoodsGrid.index)
                    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
                        self.initUsedTypeList[1].stoneShowLV = goodsData:getStoneLV()
                        self.initUsedTypeList[1].gemStoneType = goodsData:getGemStoneType()
                    else
                        -- self.initUsedTypeList[1].transDropGroupID = goodsData:getTransDropGroupID()
                    end
                    self._bagGridList:setUsedType(self.initUsedTypeList)
                    self._bagGridList:refreshView()
                    return
                end
            end
        end
    else
        self:runCancelReadyAnimtion()
    end
end

-- 模版函数：更新组建的视图(必备)
function GemSynthesisLayer:onUpdateView()
    self:setDoorNode(self.leftLayer, self._bagGridList)
end

--刷新主宝石
function GemSynthesisLayer:refreshMainGem(goodsData)
    self:showAttrInfoArea(goodsData)

    local goodsData2 = self.mGoodsGrid:getData()
    if goodsData2 ~= nil then
        goodsData2._changeNum = goodsData2._changeNum + 1
        if goodsData2.isEquiped and goodsData2._changeNum > 0 then
            goodsData2._changeNum = 0
        end
    end
    self.mGoodsGrid:show()
    self.mGoodsGrid:setData(goodsData)
    self.mGoodsGrid:updateView()
    self.mGoodsGrid:updateCanUseState(true)
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:center()

    goodsData._changeNum = goodsData._changeNum - 1
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        self.initUsedTypeList[1].stoneShowLV = goodsData:getStoneLV()
        self.initUsedTypeList[1].gemStoneType = goodsData:getGemStoneType()
        self._bagGridList:setUsedType(self.initUsedTypeList)

        -- 把副材料都给清理掉
        self:clearMaterialGoodsGrid()
    end

    self._bagGridList:refreshView()
    self.gemstoneData = goodsData
    self:refreshGoodsGrid(0)
    --刷新气泡
    self:runPutAnimtion(0)
end

--刷新装备
function GemSynthesisLayer:refreshGoodsGrid(index, show)
    local gride = self.mMaterialGoodsGrid[index]
    if gride then
        gride:updateView()
        gride:hideCountLabel()
        local data = gride:getData()
        if data then
            gride:show()
        else
            gride:hide()
        end
    end

    local isAllHave = true
    for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
        if materialGoodsGrid:getData() == nil then
            isAllHave = false
            break
        end
    end

    local isAllNull = true
    if not isAllHave then
        for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
            local goodsData = materialGoodsGrid:getData()
            if goodsData then
                isAllNull = false
                break
            end
        end
    else
        isAllNull = false
    end
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        if isAllNull and self.gemstoneData == nil then
            self.initUsedTypeList[1].stoneShowLV = nil
            self.initUsedTypeList[1].transDropGroupID = nil
            self.initUsedTypeList[1].gemStoneType = nil
            self._bagGridList:setUsedType(self.initUsedTypeList)
            self._bagGridList:refreshView()
        end
    else
        if isAllNull then
            self.initUsedTypeList[1].stoneShowLV = nil
            self.initUsedTypeList[1].transDropGroupID = nil
            self._bagGridList:setUsedType(self.initUsedTypeList)
            self._bagGridList:refreshView()
        end
    end

    self:updateBtnState(isAllHave)

    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        if self.gemstoneData == nil and isAllNull then
            -- elseif isAllNull then
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111256))
        elseif isAllHave then
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111258))
        else
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111257))
        end
    else
        if isAllNull then
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111259))
        elseif isAllHave then
            GameManager:showNPCInfomation(self.spriteID, UI.TEXT_1172010)
        else
            GameManager:showNPCInfomation(self.spriteID, LanguageManager:getInstance():getLocalString(1111257))
        end
    end
end

function GemSynthesisLayer:getGemStoneConfig(gemStoneType, gemStoneLv)
    local allConfig = ConfigManager:getAllGemStoneConfig()
    for key, v in pairs(allConfig) do
        if type(v) == "table" then
            if v.gemstoneType == gemStoneType and v.gemstoneLV == gemStoneLv then
                return v
            end
        end
    end
end

--刷新改造按钮
function GemSynthesisLayer:updateBtnState(enable)
    if enable == nil then
        enable = false
    end
    
    if enable then
        self.gemModel.executeButtonLabelGem:setText(UIUtil:lang(1111262))
        self.mBtnSynthesis:enable()
        self.mTxtStrengthen:setFontColor(UI.FONT_COLOR_220_182_80)

        if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
            local gemStoneType = self.gemstoneData.gemstoneType
            local gemStoneLv = self.gemstoneData:getStoneLV() + 1
            local config = self:getGemStoneConfig(gemStoneType, gemStoneLv)
            if config then
                local gemStone = Goods.GemStoneData:create(config.ID)
                self:showAttrInfoArea(self.gemstoneData, gemStone)
            end
        else
            self:showAttrInfoArea(self.gemstoneData)
        end
    else
        self.gemModel.executeButtonLabelGem:setText(UI.TEXT_1212872)
        if self.gemstoneData then
            self.mBtnSynthesis:enable()
            self.mTxtStrengthen:setFontColor(UI.FONT_COLOR_220_182_80)
        else
            -- self.gemModel.executeButtonLabelGem:setText(UIUtil:lang(1111262))
            self.mBtnSynthesis:disable()
            self.mTxtStrengthen:setFontColor(UI.FONT_COLOR_182_201_201)
        end
        self:showAttrInfoArea(self.gemstoneData)
    end
end

function GemSynthesisLayer:onTouchBeganByGoodsGrid(grid, touchPosition)
    if grid:getData() == nil then
        return false
    end
    if self.isAction then
        return false
    end
    self:runReadyAnimtion(grid.index, true)
    self:updateBtnState(false)
    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
    return true
end

function GemSynthesisLayer:onTouchEndedByGoodsGrid(grid, inSide)
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if not inSide then
        -- 恢复正常状态
        self._bagGridList:resetHandleStatus()
        self:showAttrInfoArea()

        self.gemstoneData = nil
        local goodsData = grid:getData()
        goodsData._changeNum = goodsData._changeNum + 1
        if goodsData.isEquiped and goodsData._changeNum > 0 then
            goodsData._changeNum = 0
        end
        self._bagGridList:refreshView()
        if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
            for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
                if materialGoodsGrid:getData() ~= nil then
                    local goodsData = materialGoodsGrid:getData()
                    goodsData._changeNum = goodsData._changeNum + 1
                    materialGoodsGrid:reset()
                end
                self:refreshGoodsGrid(materialGoodsGrid.index)
            end
        end
        grid:reset()
        self.mGoodsGrid:hideIcon()
        self.mGoodsGrid:hide()
        self:runCancelReadyAnimtion(grid.index, true)
        self:updateBtnState(false)
    else
        self:runPutAnimtion(grid.index, true)
    end
end

function GemSynthesisLayer:onTouchBeganByMaterialGoodsGrid(grid, touchPosition)
    if grid:getData() == nil then
        return false
    end
    if self.isAction then
        return false
    end
    self:runReadyAnimtion(grid.index, true)
    self:updateBtnState(false)
    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
    return true
end

function GemSynthesisLayer:onTouchEndedByMaterialGoodsGrid(grid, inSide)
    self:updateBtnState(true)
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end
    if not inSide then
        local goodsData = grid:getData()
        goodsData._changeNum = goodsData._changeNum + 1
        grid:reset()
        self:refreshGoodsGrid(grid.index)
        self._bagGridList:refreshView()
        self:runCancelReadyAnimtion(grid.index, true)
    else
        self:runPutAnimtion(grid.index, true)
    end
end
-- 刷新金币
function GemSynthesisLayer:refreshCurrency()
    local costValue = 0
    if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        if self.gemstoneData then
            local level = self.gemstoneData:getStoneLV()
            costValue = ConfigManager:getCoastByLevel(level)
        end

        if costValue == 0 then
            self.gemModel.executeButtonLabelGem:show()
        else
            self.gemModel.executeButtonLabelGem:hide()
        end
        self.gemModel.executeButtonPrice:setText(costValue)
        if GameDataManager:getInstance():getCurCoin() < costValue then
            self.gemModel.executeButtonPrice:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            self.gemModel.executeButtonPrice:setFontColor(UI.FONT_COLOR_220_182_80)
        end
        AvalonUtil.updateIconStringLayout(self.gemModel.priceLayer)
    end
    self.gemModel.executeButtonPrice:setVisible(costValue ~= 0)
    self.gemModel.executeButtonIcon:setVisible(costValue ~= 0)
end

function GemSynthesisLayer:oneKeySynthesis()
    --reload_script_file("app.ui.tips.GemSynthesisTips")
    require "app.ui.tips.GemSynthesisTips"
    
    local tips = UI.GemSynthesisTips:create()
    tips:init(goodsData)
    tips:center()
    UI.UIManager:getRootNode():addChild(tips,UI_ZORDER.TIPS)
end

--合成
function GemSynthesisLayer:onSynthesis()
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        if self.doSynthAnimationNow then
            return
        end
    end
    if self.gemstoneData == nil then
        UI.ScrollBar:createByText(UI.TEXT_1172009)
        return
    end

    local needNum = 0
    if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        local level = self.gemstoneData:getStoneLV()
        needNum = ConfigManager:getCoastByLevel(level)
        --
        if self.gemstoneData and self.gemstoneData:getIsLock() then
            UI.ScrollBar:createByText(UI.TEXT_110030)
            return
        end

        if GameDataManager:getInstance():getCurCoin() < needNum then
            UI.ScrollBar:createByText(UI.TEXT_110210)
            return
        end
    end

   

    for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
        local goodsData = materialGoodsGrid:getData()
        if goodsData and goodsData:getIsLock() then
            UI.ScrollBar:createByText(UI.TEXT_110030)
            return
        end
    end

    if RoleBehaviorManager:equipGemTownNpcCheck() then
        printWarn(" been blocked when using gem npc synthesis function !")
        return
    end

    local gemIds = {}
    local emptyGrid = {}
    for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
        local goodsData = materialGoodsGrid:getData()
        if goodsData then
            table.insert(gemIds, goodsData)
        else
            table.insert(emptyGrid, k)
        end
    end
    if #gemIds < #self.mMaterialGoodsGrid then
        if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then

            if self.gemstoneData:getNextLVID() == 0 then
                UI.ScrollBar:createByTextID(UI.TEXT_1212874)
                return
            end


            --
            local allBagGemStone = self._bagGridList._data.haveGemStoneArr
            local neednum = #self.mMaterialGoodsGrid - #gemIds
            
            local tempGemStone = {}
            for key, gemStone in pairs(allBagGemStone) do
                if gemStone:getNum() + gemStone._changeNum > 0 
                   and gemStone:getStoneLV() == self.gemstoneData:getStoneLV()
                   and gemStone:getGemStoneType() == self.gemstoneData:getGemStoneType()
                   and (not gemStone.isLock)
                   and (not gemStone:getNextLVID() ~= 0)
                then
                    table.insert(tempGemStone, gemStone)
                    neednum = neednum - (gemStone:getNum() + gemStone._changeNum)
                    if neednum <= 0 then
                        break
                    end
                end
            end
            if neednum > 0 then
                local master = RoleDataManager:getMaster()
                local haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
                if haveGemStoneArr then
                    for _, gemStone in pairs(haveGemStoneArr) do
                        if gemStone:getNum() + gemStone._changeNum > 0 
                            and gemStone:getStoneLV() == self.gemstoneData:getStoneLV()
                            and gemStone:getGemStoneType() == self.gemstoneData:getGemStoneType()
                            and (not gemStone.isLock)
                            and (not gemStone:getNextLVID() ~= 0)
                        then
                            table.insert(tempGemStone, gemStone)
                            neednum = neednum - (gemStone:getNum() + gemStone._changeNum)
                            if neednum <= 0 then
                                break
                            end
                        end
                    end
                end
            end
            
            local curEmptyIdx = 1
            for i = 1, #tempGemStone do 
                local bagGemStone = tempGemStone[i]
                local curNum = bagGemStone:getNum() + bagGemStone._changeNum
                for j = 1, curNum do
                    local grid = self.mMaterialGoodsGrid[emptyGrid[curEmptyIdx]]
                    if grid then
                        grid:show()
                        grid:setData(bagGemStone)
                        grid:updateView()
                        grid:updateCanUseState(true)
                        grid:hideNewIcon()
                        grid:hideCountLabel()
                        grid:center()
                        bagGemStone._changeNum = bagGemStone._changeNum - 1
                        curEmptyIdx = curEmptyIdx + 1
                    end
                end
            end
            self._bagGridList:refreshView()
            self:refreshGoodsGrid(0)
            if neednum > 0 then
                UI.ScrollBar:createByText(UI.TEXT_1212870)
                return
            end
            return
        end
        UI.ScrollBar:createByTextID(1170182)
        return
    end

    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS and self.gemstoneData.isWear then
        local gemStoneType = self.gemstoneData.gemstoneType
        local gemStoneLv = self.gemstoneData:getStoneLV() + 1
        local config = self:getGemStoneConfig(gemStoneType, gemStoneLv)
        if RoleDataManager:getMaster():getLevel() < config.gemstoneRequireLV then
            UI.ConfirmDialog.showConfrimOnly(UI.TEXT_1212871, nil, nil, nil, nil)
            return
        end
    end

    if self.gemstoneData:getBagType() == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE then
        local freePacketNum = GameDataManager:getInstance():getWarehouseFreePacketBoxNum()
        if freePacketNum <= 0 then
            UI.ScrollBar:createByTextID(1170081)
            return
        end
    end

    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if freePacketNum <= 0 then
        UI.ScrollBar:createByTextID(1170081)
        return
    end

    


    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    self._bagGridList:setRefreshFlag(false)
    self._bagGridList:updateCanDrag(false)
    self:updateBtnState(false)

    local equipmentInstanceID, equipmentPacketType, equipmentHoleIndex
    if self.gemstoneData.isEquiped then
        if self.gemstoneData.isWear then
            equipmentPacketType = PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT
        else
            equipmentPacketType = PublicDefine.PACKET_TYPE.PACKET_BAG
        end
        equipmentInstanceID = self.gemstoneData.equipEntityId
        equipmentHoleIndex = self.gemstoneData.equipSlotIdx - 1
    else  
        local isExist = GameDataManager:getInstance():isGoodsExisit(self.gemstoneData:getBagType(), {self.gemstoneData:getGoodsID()}, PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
        if not isExist then
            UI.ScrollBar:createByText(UI.TEXT_1213453)
            UI.WaitingLayer:hideWaiting()
            self.doSynthAnimationNow = false
            self._bagGridList:setRefreshFlag(true)
            self._bagGridList:updateCanDrag(true)
            return
        end
    end 

    self.doSynthAnimationNow = true

    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        for i = 1, #gemIds do
            local isExist = GameDataManager:getInstance():isGoodsExisit(gemIds[i]:getBagType(), {gemIds[i]:getId()}, PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
            if not isExist then
                UI.ScrollBar:createByText(UI.TEXT_1213453)

                UI.WaitingLayer:hideWaiting()
                self.doSynthAnimationNow = false
                self._bagGridList:setRefreshFlag(true)
                self._bagGridList:updateCanDrag(true)
                return
            end
        end
        -- local isExist = GameDataManager:getInstance():isGoodsExisit(equipmentPacketType, {equipmentInstanceID}, PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
        -- if not isExist then
        --     UI.ScrollBar:createByText(UI.TEXT_1213453)
        --     UI.WaitingLayer:hideWaiting()
        --     self.doSynthAnimationNow = false
        --     return
        -- end

        Net.NetNPCSystem:sendGemSynthesis(self.gemstoneData, gemIds, self.spriteID
            ,equipmentInstanceID, equipmentPacketType, equipmentHoleIndex)
        Avalon.AudioManager:playSound("1533")
    elseif self.layerType == GEM_LAYER_TYPE.TRANSFORM then
        -- local isExist = GameDataManager:getInstance():isGoodsExisit(
        --     self.gemstoneData:getBagType(), {self.gemstoneData:getId()}, PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
        -- if not isExist then
        --     UI.ScrollBar:createByText(UI.TEXT_1213453)
        --     UI.WaitingLayer:hideWaiting()
        --     self.doSynthAnimationNow = false
        --     self._bagGridList:setRefreshFlag(true)
        --     self._bagGridList:updateCanDrag(true)
        --     return
        -- end
        Net.NetNPCSystem:sendGemTransForm(self.gemstoneData:getId(), self.spriteID
            ,self.gemstoneData:getBagType())
        Avalon.AudioManager:playSound("1532")
    end
end

--特效事件
function GemSynthesisLayer:spineRemouldCallback()
    self.toShowGoodsList = nil
    local goodsDataList = {}
    if self.gemstoneData ~= nil then
        self.mGoodsGrid:show()
        self.mGoodsGrid:setData(self.gemstoneData)
        self.mGoodsGrid:updateView()
        self.mGoodsGrid:updateCanUseState(true)
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideCountLabel()
        local gemstoneData = GoodsDataManager:createLocalGoodsData(self.gemstoneData:getId())
        if (gemstoneData) then
            table.insert(goodsDataList, gemstoneData)
        end
        self.toShowGoodsList = goodsDataList
    end

    self.isAction = false
    if self.layerType == GEM_LAYER_TYPE.SYNTHESIS then
        if self.gemstoneData then
            self.initUsedTypeList[1].stoneShowLV = self.gemstoneData:getStoneLV()
            self.initUsedTypeList[1].gemStoneType = self.gemstoneData:getGemStoneType()
            local tempData = self._bagGridList:getGoodsDataLoseGoldenByData(self.gemstoneData)
            if tempData then
                tempData._changeNum = tempData._changeNum - 1
            end
        end
    else
        if self.gemstoneData then
            -- self.initUsedTypeList[1].stoneShowLV = self.gemstoneData:getStoneLV()
            -- self.initUsedTypeList[1].gemStoneType = self.gemstoneData:getGemStoneType()
            local tempData = self._bagGridList:getGoodsDataLoseGoldenByData(self.gemstoneData)
            if tempData then
                tempData._changeNum = tempData._changeNum - 1
            end
        end

        self.mGoodsGrid:setData(self.gemstoneData)
        self.mGoodsGrid:updateView()
        self.mGoodsGrid:hideNewIcon()
        self.mGoodsGrid:hideCountLabel()
        self.mGoodsGrid:show()
        -- self.gemstoneData = nil
        self.initUsedTypeList[1].stoneShowLV = nil
        self.initUsedTypeList[1].transDropGroupID = nil
    end
    self.mGoodsGrid:updateView()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:hideCountLabel()
    self._bagGridList:updateCanDrag(true)
    self._bagGridList:setRefreshFlag(true)
    self._bagGridList:setUsedType(self.initUsedTypeList)
    self._bagGridList:refreshView()

    for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
        local goodsData = materialGoodsGrid:getData()
        if goodsData then
            goodsData._changeNum = goodsData._changeNum + 1
            materialGoodsGrid:reset()
            self:refreshGoodsGrid(materialGoodsGrid.index)
        end
    end
    self:refreshCurrency()
    self:showAttrInfoArea(self.gemstoneData)
end

function GemSynthesisLayer:getUpdateGem(isWear, entityId, slotIdx)
    local bagDatas
    if isWear then
        bagDatas = self._bagGridList._bagGridList.haveGemStoneWearEquipArr
    else
        bagDatas = self._bagGridList._bagGridList.haveGemStoneEquipArr
    end
    for _, gemData in pairs(bagDatas) do
        if gemData.equipEntityId == entityId 
            and gemData.equipSlotIdx == slotIdx 
        then
            return gemData
        end
    end
end

function GemSynthesisLayer:synthesisQuickCallBack(data)
    UI.WaitingLayer:hideWaiting()
    if self.gemstoneData then
        self.gemstoneData._changeNum = 0
        self.gemstoneData = nil
    end
    self.mGoodsGrid:reset()
    self.mGoodsGrid:hideIcon()
    self.mGoodsGrid:hide()
    self:runCancelReadyAnimtion(0, true)
    self:clearMaterialGoodsGrid()
    self:updateBtnState(false)
    self._bagGridList:updateCanDrag(true)
    self._bagGridList:setRefreshFlag(true)
    self.initUsedTypeList[1].stoneShowLV = nil
    self.initUsedTypeList[1].gemStoneType = nil
    self.initUsedTypeList[1].transDropGroupID = nil
    self._bagGridList:setUsedType(self.initUsedTypeList)
    self._bagGridList:refreshView()
end

--强化网络回调
function GemSynthesisLayer:synthesisCallBack(data)
    UI.WaitingLayer:hideWaiting()
    if data.result == ProtobufUtil:enum_id("NPCSystem.GemstoneComposeResult", "GemstoneComposeResult_Succeed") then
        Avalon.AudioManager:playSoundDelay("1111111", 2000)
        if self.gemstoneData then
            self.gemstoneData._changeNum = self.gemstoneData._changeNum + 1
        end

        if self.gemstoneData.isEquiped then
            self._bagGridList:initBagListData()
            self.gemstoneData = self:getUpdateGem(self.gemstoneData.isWear, 
                self.gemstoneData.equipEntityId, self.gemstoneData.equipSlotIdx)
            self._bagGridList:refreshView()
        else
             
            if(data.gemstoneID.packetType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE) then

                local master = RoleDataManager:getMaster()
                local haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
                if haveGemStoneArr then
                    for _, goodsData in pairs(haveGemStoneArr) do
                        if goodsData:getGoodsID() == data.gemstoneID.tempID then
                            self.gemstoneData = goodsData
                            break
                        end
                    end
                end
                
            else
                self.gemstoneData =
                    self._bagGridList:getGoodsData(PublicDefine.GOODS_TYPE.GOODS_GEM_STONE, data.gemstoneID.tempID, false)
            end
        end
      
        self.isAction = true
        self:runSuccessAnimtion()

        if self.layerType == GEM_LAYER_TYPE.TRANSFORM then
            UI.ScrollBar:createByTextID(1111638)
        end
        -- self:updateBtnState(false)
    else
        self.doSynthAnimationNow = false
        GameErrorManager:showError(data.result)
        self:updateBtnState(true)
        self._bagGridList:updateCanDrag(true)
        self._bagGridList:setRefreshFlag(true)
        self.initUsedTypeList[1].stoneShowLV = nil
        self.initUsedTypeList[1].gemStoneType = nil
        self.initUsedTypeList[1].transDropGroupID = nil
        self._bagGridList:setUsedType(self.initUsedTypeList)
        self._bagGridList:refreshView()
    end
end


function GemSynthesisLayer:clearMaterialGoodsGrid()
    for k, materialGoodsGrid in ipairs(self.mMaterialGoodsGrid) do
        local goodsData = materialGoodsGrid:getData()
        if goodsData then
            goodsData._changeNum = goodsData._changeNum + 1
            if(goodsData._changeNum > 0) then
                goodsData._changeNum = 0
            end
            materialGoodsGrid:reset()
            self:refreshGoodsGrid(materialGoodsGrid.index)
            self:runCancelReadyAnimtion(materialGoodsGrid.index, true)
        end
    end
end

-- 注册监听事件(可选)
function GemSynthesisLayer:registerListener()
    --监听窗口外关闭事件
    --结果
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GEM_SYNTHESIS, self, self.synthesisCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GEM_TRANSFORM, self, self.synthesisCallBack)
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GEM_QUICK_SYNTHESIS, self, self.synthesisQuickCallBack)
    
end

-- 注销监听事件(可选)
function GemSynthesisLayer:unRegisterListener()
    --结果
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GEM_SYNTHESIS, self, self.synthesisCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GEM_TRANSFORM, self, self.synthesisCallBack)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GEM_QUICK_SYNTHESIS, self, self.synthesisQuickCallBack)
end

------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/04/26
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GemDecomposeView = class("GemDecomposeView", UI.DoorWin)
local winSize = cc.Director:getInstance():getWinSize()
local GameDataManager = require("app.game.GameDataManager")
require("app.config.ConfigManager")
require "app.ui.shoplayer.BagGoodsPanel"

-- 资源
local COM_RES_LIST = {
    "ui_town_runelink.plist",
    "ui_town_gem.plist",
}

local COM_WIDTH = 350
local COM_HEIGHT = 640

local gemMainLevel = 10 --符文石 最小分解等级

function GemDecomposeView:ctor()
    GemDecomposeView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function GemDecomposeView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.gemdecompose", "GemDecompose", false)
    GemDecomposeView.super.init(self, ... )
end

function GemDecomposeView:dtor()
    GemDecomposeView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.gemdecompose.GemDecomposeView")
end


function GemDecomposeView:onInitView()

    self:setCloseFinishCallBack(handler(self, function()
        mvc.closePanel("GemDecompose", "GemDecompose")
    end))
    self:setCloseStartCallBack(handler(self, function()
        GameManager:centerToMap()
    end))
    

    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:setSize(winSize.width, winSize.height)
    rootLayout:center()
    self:addChild(rootLayout)
    self._rootLayout = rootLayout

    self:createLeftLayer()

    self:createRightLayer()

    self.leftLayer:show()
    self._bagGridList:show()
    self:setDoorNode(self.leftLayer, self._bagGridList)

end

function GemDecomposeView:createLeftLayer()
    local leftLayer = UI.Layout:create()
    leftLayer:init()
    leftLayer:setSize(352, 595)
    leftLayer:centerLeft(0)
    self._rootLayout:addChild(leftLayer)
    self.leftLayer = leftLayer

    local bg = UI.Image:create()
    bg:init("ui_gem_bg.png")
    bg:center()
    self.leftLayer:addChild(bg)

    local desImg = UI.Image:create()
    desImg:init("ui_gem_paper.png")
    desImg:centerUp(155)
    self.leftLayer:addChild(desImg)

    local tImg = UI.Image:create()
    tImg:init("ui_gem_shadow.png")
    tImg:centerUp(-31)
    self.leftLayer:addChild(tImg)

    local tImg2 = UI.Image:create()
    tImg2:init("ui_gem_round.png")
    tImg2:centerUp(-31)
    self.leftLayer:addChild(tImg2)

    self._backFrameAnimation = UI.Animation:create()
    self._backFrameAnimation:init("effect_ui_town_gem_di_inlay.json", "effect_ui_town_gem_di_inlay.atlas", 1);
    self._backFrameAnimation:centerUp(133)
    self._backFrameAnimation:setAnimation("hint_idle_colour", true)
    self.leftLayer:addChild(self._backFrameAnimation)

    -- 主符文模块
    self._mainRuneLayout = UI.Layout:create()
    self._mainRuneLayout:init()
    self._mainRuneLayout:setSize(140, 140)
    self._mainRuneLayout:centerUp(60)
    self.leftLayer:addChild(self._mainRuneLayout)

    self._mainRuneFrame = UI.Animation:create()
    self._mainRuneFrame:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas", 1);
    self._mainRuneFrame:center()
    self._mainRuneFrame:setAnimation("hint_end_yellow", false)
    self._mainRuneLayout:addChild(self._mainRuneFrame,10)

    self._mainRuneGoodsGrid = UI.GoodsGrid:create()
    self._mainRuneGoodsGrid:init()
    self._mainRuneGoodsGrid.index = 1
    self._mainRuneGoodsGrid:center()
    self._mainRuneGoodsGrid:hide()
    self._mainRuneGoodsGrid:hideCountLabel()
    self._mainRuneGoodsGrid:hideNewIcon()
    self._mainRuneGoodsGrid:showInfoArea()
    self._mainRuneLayout:addChild(self._mainRuneGoodsGrid,11)
    self._mainRuneGoodsGrid:setTouchEnable(true)
    self._mainRuneGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self._mainRuneGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByMaterialGoodsGrid))
    self._mainRuneGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByMaterialGoodsGrid))

    self._successAnimation = UI.Animation:create()
    self._successAnimation:init("effect_ui_town_gem_kuang_da_success_yellow.json", "effect_ui_town_gem_kuang_da.atlas", 1);
    self._successAnimation:center()
    self._mainRuneLayout:addChild(self._successAnimation,12)




    local LAYOUT_SIZE_WIDTH = desImg:getContentSize().width - 20
    self._desLayout = UI.Layout:create()
    self._desLayout:init()
    self._desLayout:setSize(LAYOUT_SIZE_WIDTH, 246)

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH,258)
    scrollView:init()
    scrollView:leftUp(24, 105)
    scrollView:addInnerNode(self._desLayout)
    desImg:addChild(scrollView)
    self._desScrollView = scrollView

    local desArry = {
        UI.TEXT_228001
    }
    local totalHeight = 50
    local leftOffset = 0
    local centerOffsetUp = 13.5
    local pointOffsetY = - 1

    for k,v in ipairs(desArry) do
        local centerUp = totalHeight + centerOffsetUp

        local baseText = UI.Text:create()
        baseText:init(v, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_45_44_48)
        baseText:setTextLeft()
        baseText:leftUp(leftOffset + 3, centerUp - baseText:getContentSize().height/2)
        baseText:setWidth(220)
        baseText:setText(v)
        self._desLayout:addChild(baseText)
        
        totalHeight = totalHeight + baseText:getContentSize().height + 15
    end




    --分解按钮
    local linkBtn = UI.Button:create()
    linkBtn:init("ui_runelink_btn.png")
    linkBtn:setText("")
    linkBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_220_182_80)
    self._linkBtn = linkBtn
    linkBtn:centerBottom(30, 0)
    bg:addChild(linkBtn)
    linkBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.sendDecompose)

    self._needLayout = UI.Layout:create()
    self._needLayout:init()
    self._needLayout:centerBottom(40, -20)
    self._needLayout:enableAutoWidth()
    self._needLayout:enableAutoHeight()
    bg:addChild(self._needLayout)

    local moneyImg = UI.Image:create()
    moneyImg:init("symbol_gaming_money.png")
    moneyImg:floatLeft(10)
    self._needLayout:addComponent(moneyImg)

    self._moneyNumText = UI.Text:create()
    self._moneyNumText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_220_182_80)
    self._moneyNumText:floatLeft(10)
    self._needLayout:addComponent(self._moneyNumText)

    self:refreshLeftLayer()
end

function GemDecomposeView:createRightLayer()
    --右边背包数据
    local initUsedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_GEM_STONE
    _usedType1.type = 0
    self.initUsedTypeList = initUsedTypeList
    table.insert(initUsedTypeList, _usedType1)
    self.initUsedTypeList[1].stoneShowLV = gemMainLevel
    self.initUsedTypeList[1].onlyGemDecomposeView = true

    local bagList = UI.BagGoodsPanel:create(initUsedTypeList, false, false)
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
            -- UI.BagGoodsPanel.BAG_TYPE.GEM_STONE_EQUIP_WEAR,
            -- UI.BagGoodsPanel.BAG_TYPE.GEM_STONE_EQUIP,
            
        }
    )
    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self._rootLayout:addChild(bagList, 5)
    bagList:centerLeft(0)
    bagList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.GEM_STONE)
    bagList:setUseLock(false)
    bagList:setUsedType(self.initUsedTypeList)
    bagList:refreshView()
end

function GemDecomposeView:refreshLeftLayer()
    if not self._mainRuneGoodsGrid then
        return
    end
    local goodsData = self._mainRuneGoodsGrid:getData()
    if not goodsData then
        self._linkBtn:setText(UI.TEXT_228000)
        self._linkBtn:disable()
        self._linkBtn:setFontColor(UI.FONT_COLOR_154_154_154)
        self._linkBtn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))

        self._needLayout:hide()
    else
        self._linkBtn:setText("")
        self._linkBtn:enable()
        self._linkBtn:setFontColor(UI.FONT_COLOR_220_182_80)
        self._linkBtn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))

        self._needLayout:show()
        local costValue = tonumber(ConfigManager:getComposeCostByLevel(goodsData:getStoneLV()))
        local coin = RoleDataManager:getMaster():getCurCoin()
        if costValue then
            self._moneyNumText:setText(AvalonUtil:getSimpleNumber(costValue, 4))
        end

        if coin < costValue then
            self._moneyNumText:setFontColor(UI.FONT_COLOR_255_24_0)
        else
            self._moneyNumText:setFontColor(UI.FONT_COLOR_220_182_80)
        end

    end
    -- 
end

function GemDecomposeView:refreshGoodsGrid(grid)
    if grid then
        grid:updateView()
        grid:hideCountLabel()
        local data = grid:getData()
        if data then
            grid:show()
        else
            grid:hide()
        end
    end

end

function GemDecomposeView:refreshGemGridData(grid,goodsData,dontShowEffect)
    if grid == nil or goodsData == nil then
        return
    end

    local goodsData2 = grid:getData()
    if goodsData2 ~= nil then
        goodsData2._changeNum = goodsData2._changeNum + 1
        if goodsData2._changeNum > 0 then
            goodsData2._changeNum = 0
        end
    end

    grid:setData(goodsData)
    goodsData._changeNum = goodsData._changeNum - 1
    self._bagGridList:refreshView()

    self:refreshGoodsGrid(grid)
    if not dontShowEffect then
        self:runPutAnimtion()
    end

    self:refreshLeftLayer()

end

function GemDecomposeView:bagDragBeganCallback(grid, touchPosition)

    local goodsData = grid:getData()
    if goodsData then
        self:runReadyAnimtion()
    end
end

function GemDecomposeView:bagDragEndedCallback(grid, touchPosition, isInBag)
    local goodsData = grid:getData()
    if not isInBag then
        if goodsData and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
            -- print("goodsData ===== ")
            -- dump(goodsData,nil,10)

            self:refreshGemGridData(self._mainRuneGoodsGrid,goodsData)
            self._bagGridList:refreshView()
        end
    else
        self:runCancelReadyAnimtion()
    end
end


function GemDecomposeView:onTouchBeganByMaterialGoodsGrid(grid, touchPosition)
    if grid:getData() == nil then
        return false
    end
    self:runReadyAnimtion()
    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
    return true
end

function GemDecomposeView:onTouchEndedByMaterialGoodsGrid(grid, inSide)
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if not inSide then
        local goodsData = grid:getData()
        goodsData._changeNum = goodsData._changeNum + 1
        grid:reset()
        self:refreshGoodsGrid(grid)
        self:runCancelReadyAnimtion()

        self._bagGridList:refreshView()
    else
        self:runPutAnimtion()
    end

    self:refreshLeftLayer()
end

function GemDecomposeView:runReadyAnimtion()
    local animationName = "hint_begin_yellow"
    if self._mainRuneFrame then
        self._mainRuneFrame:setAnimation(animationName, false)
    end

    if self._backFrameAnimation then
        self._backFrameAnimation:setAnimation("hint_begin_colour", false)
    end

end

function GemDecomposeView:runPutAnimtion()
    local animationName = "enchase_yellow"
    if self._mainRuneFrame then
        self._mainRuneFrame:setAnimation(animationName, false)
    end

    if self._backFrameAnimation then
        self._backFrameAnimation:setAnimation("hint_end_colour", false)
    end
end

function GemDecomposeView:runCancelReadyAnimtion()
    local animationName = "hint_end_yellow"
    if self._mainRuneFrame then
        self._mainRuneFrame:setAnimation(animationName, false)
    end

    if self._backFrameAnimation then
        self._backFrameAnimation:setAnimation("hint_end_colour", false)
    end
end

function GemDecomposeView:runDecomposeAnimation(callback)
    if self._backFrameAnimation then
        self._backFrameAnimation:setAnimation("success_colour", false)
    end

    if self._successAnimation then
        self._successAnimation:setAnimation("success_yellow", false)
    end

    local goodsData = self._mainRuneGoodsGrid:getData()
    if goodsData then
        goodsData._changeNum = goodsData._changeNum + 1
    end

    self:runAction(cc.Sequence:create(
        cc.DelayTime:create(0.5),
        cc.CallFunc:create(function()
            if callback then
                callback()
            end
        end)
    ))

end

function GemDecomposeView:sendDecompose()
    if (GameDataManager:getFreePacketBoxNum() <= 0) then
        UI.ScrollBar:createByText(UI.TEXT_1314137)
        return
    end

    local goodsData = self._mainRuneGoodsGrid:getData()
    if goodsData then

        local costValue = tonumber(ConfigManager:getComposeCostByLevel(goodsData:getStoneLV()))
        local coin = RoleDataManager:getMaster():getCurCoin()

        if coin < costValue then
            UI.ScrollBar:createByText(UI.TEXT_110210)
            return
        end

        UI.WaitingLayer:showWaiting(true, nil, 1)

        local data = {}
        data.gemid = goodsData.goodsID
        Net.NetGoodsSystem:requesGemDecomposeMessage(data)
    end
end

function GemDecomposeView:bindModel()

end


function GemDecomposeView:unbindModel()

end





return GemDecomposeView













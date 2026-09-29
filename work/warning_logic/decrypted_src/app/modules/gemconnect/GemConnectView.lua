------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/03/19
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GemConnectView = class("GemConnectView", UI.DoorWin)
local GameDataManager = require("app.game.GameDataManager")
require "app.ui.shoplayer.BagGoodsPanel"
local winSize = cc.Director:getInstance():getWinSize()

-- 资源
local COM_RES_LIST = {
    "ui_town_runelink.plist",
    "ui_town_gem.plist",
}

local COM_WIDTH = 350
local COM_HEIGHT = 640

function GemConnectView:ctor()
    GemConnectView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function GemConnectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.gemconnect", "GemConnect", false)
    GemConnectView.super.init(self, ... )
end

function GemConnectView:dtor()
    GemConnectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.gemconnect.GemConnectView")
end


function GemConnectView:onInitView()

    self:setCloseFinishCallBack(handler(self, function()
        mvc.closePanel("GemConnect", "GemConnect")
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

function GemConnectView:createLeftLayer()
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
    tImg:init("ui_runelink_panle.png")
    tImg:centerUp(-25)
    self.leftLayer:addChild(tImg)

    -- 主符文模块
    self._mainRuneLayout = UI.Layout:create()
    self._mainRuneLayout:init()
    self._mainRuneLayout:setSize(140, 140)
    self._mainRuneLayout:centerUp(55)
    tImg:addChild(self._mainRuneLayout)

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

    --链接符文模块
    self._connectRuneLayout = UI.Layout:create()
    self._connectRuneLayout:init()
    self._connectRuneLayout:setSize(140, 140)
    self._connectRuneLayout:centerUp(162)
    self._connectRuneLayout:setScale(0.8)
    tImg:addChild(self._connectRuneLayout)

    self._connectRuneFrame = UI.Animation:create()
    self._connectRuneFrame:init("effect_ui_town_gem_kuang_da.json", "effect_ui_town_gem_kuang_da.atlas", 1);
    self._connectRuneFrame:center()
    self._connectRuneFrame:setAnimation("hint_end_yellow", false)
    self._connectRuneLayout:addChild(self._connectRuneFrame,10)

    self._connectRuneGoodsGrid = UI.GoodsGrid:create()
    self._connectRuneGoodsGrid:init()
    self._connectRuneGoodsGrid.index = 2
    self._connectRuneGoodsGrid:center()
    self._connectRuneGoodsGrid:hide()
    self._connectRuneGoodsGrid:hideCountLabel()
    self._connectRuneGoodsGrid:hideNewIcon()
    self._connectRuneGoodsGrid:showInfoArea()
    self._connectRuneLayout:addChild(self._connectRuneGoodsGrid,11)
    self._connectRuneGoodsGrid:setTouchEnable(true)
    self._connectRuneGoodsGrid:setDragOutAreaJudgeNode(self.leftLayer)
    self._connectRuneGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByMaterialGoodsGrid))
    self._connectRuneGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByMaterialGoodsGrid))

    ------------------- 当没有放符文石时,显示的文字模块 ------------------------
    local LAYOUT_SIZE_WIDTH = desImg:getContentSize().width - 20
    self._desLayout = UI.Layout:create()
    self._desLayout:init()
    self._desLayout:setSize(LAYOUT_SIZE_WIDTH, 246)

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH,258)
    scrollView:init()
    scrollView:leftUp(20, 105)
    scrollView:addInnerNode(self._desLayout)
    desImg:addChild(scrollView)
    self._desScrollView = scrollView

    local desArry = {
        UI.TEXT_227900,
        UI.TEXT_227901,
        UI.TEXT_227902,
    }
    local totalHeight = 0
    local leftOffset = 0
    local centerOffsetUp = 13.5
    local pointOffsetY = - 1

    for k,v in ipairs(desArry) do
        local centerUp = totalHeight + centerOffsetUp

        local point = UI.Image:create()
        point:init("ui_runelink_block.png")
        point:leftUp(leftOffset, centerUp - point:getContentSize().height/2 + pointOffsetY)
        self._desLayout:addChild(point)

        local baseText = UI.Text:create()
        baseText:init(v, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_60_57_60)
        baseText:setTextLeft()
        baseText:leftUp(leftOffset + 3 + point._width, centerUp - baseText:getContentSize().height/2)
        baseText:setWidth(220)
        baseText:setText(v)
        self._desLayout:addChild(baseText)
        
        totalHeight = totalHeight + baseText:getContentSize().height + 15
    end
    
    self._desLayout:setSize(LAYOUT_SIZE_WIDTH, totalHeight)
    ------------------- 当没有放符文石时,显示的文字模块 ------------------------



    ------------------- 当放入符文石时,显示的文字模块 ------------------------
    self._linkLayout = UI.Layout:create()
    self._linkLayout:init()
    self._linkLayout:setSize(LAYOUT_SIZE_WIDTH, 258)
    self._linkLayout:centerUp(95)
    desImg:addChild(self._linkLayout)

    local linkDesImg = UI.Image:create()
    linkDesImg:init("ui_gem_black.png")
    linkDesImg:centerUp(5)
    self._linkLayout:addChild(linkDesImg)

    local linkDesText = UI.Text:create()
    linkDesText:init(UI.TEXT_227905, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    linkDesText:setFixLineWidth(194)
    linkDesText:center()
    linkDesImg:addChild(linkDesText)

    -- self._linkDesLayout = UI.Layout:create()
    -- self._linkDesLayout:init()
    -- self._linkDesLayout:center(0,-5)
    -- self._linkDesLayout:enableAutoHeight()
    -- self._linkDesLayout:enableAutoWidth()
    -- self._linkLayout:addChild(self._linkDesLayout)

    ------------------- 当放入符文石时,显示的文字模块 ------------------------





    --链接按钮
    local linkBtn = UI.Button:create()
    linkBtn:init("ui_runelink_btn.png")
    linkBtn:setText(UI.TEXT_227903)
    linkBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_220_182_80)
    self._linkBtn = linkBtn
    linkBtn:centerBottom(30, 0)
    bg:addChild(linkBtn,10)
    linkBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.sendConnect)

    --断开链接按钮 break
    local breakBtn = UI.Button:create()
    breakBtn:init("ui_runelink_btn.png")
    breakBtn:setText(UI.TEXT_227904)
    breakBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_220_182_80)
    self._breakBtn = breakBtn
    breakBtn:centerBottom(30, 0)
    bg:addChild(breakBtn,10)
    breakBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.sendBreak)
    
    --刷新左侧界面
    self:refreshLeftLayer()
end

function GemConnectView:createRightLayer()
    --右边背包数据
    local initUsedTypeList = {}
    local _usedType1 = {}
    _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_GEM_STONE
    _usedType1.type = 0
    self.initUsedTypeList = initUsedTypeList
    table.insert(initUsedTypeList, _usedType1)
    self.initUsedTypeList[1].isEquiped = true
    self.initUsedTypeList[1].onlyGemConnectView = true

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
            UI.BagGoodsPanel.BAG_TYPE.GEM_STONE_EQUIP_WEAR,
            -- UI.BagGoodsPanel.BAG_TYPE.GEM_STONE_EQUIP,
            UI.BagGoodsPanel.BAG_TYPE.WAREHOUSE,
            
        }
    )
    bagList:init()
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    self._bagGridList = bagList
    self._rootLayout:addChild(bagList, 5)
    bagList:centerLeft(0)
    bagList:changeBagDefaultIndex(UI.BagGoodsPanel.BAG_TYPE.GEM_STONE_EQUIP_WEAR)
    bagList:setUseLock(false)
    bagList:setUsedType(self.initUsedTypeList)
    bagList:refreshView()
end

function GemConnectView:refreshLeftLayer()

    self:refreshDesView()
    self:refreshBreakBtn()
    self:refreshConnnectBtn()
end

function GemConnectView:refreshDesView()
    local goodsData = self._mainRuneGoodsGrid:getData()
    local goodsData2 = self._connectRuneGoodsGrid:getData()

    if self._linkDesLayout then
        self._linkDesLayout:removeFromParent()
        self._linkDesLayout = nil
    end

    self._linkDesLayout = UI.Layout:create()
    self._linkDesLayout:init()
    self._linkDesLayout:center(0,-5)
    self._linkDesLayout:enableAutoHeight()
    self._linkDesLayout:enableAutoWidth()
    self._linkLayout:addChild(self._linkDesLayout)


    if not goodsData and not goodsData2 then
        self._desLayout:show()
        self._linkLayout:hide()
    else
        self._desLayout:hide()
        self._linkLayout:show()

        local linkDetailArr = {}
        local isUnlock = false

        if goodsData and not goodsData2 then
            linkDetailArr, isUnlock = goodsData:getLinkDetailDescription()
        elseif goodsData and goodsData2 then
            linkDetailArr, isUnlock = goodsData:getLinkDetailDescription(goodsData2.goodsID)
        end

        if linkDetailArr then
            for i,data in ipairs(linkDetailArr) do
                local attrDesLayout = UI.Layout:create()
                attrDesLayout:init()
                attrDesLayout:enableAutoHeight()
                attrDesLayout:enableAutoWidth()
                attrDesLayout:floatUp(8)
                self._linkDesLayout:addComponent(attrDesLayout)

                local point = UI.Image:create()
                if isUnlock then
                    point:init("ui_runelink_block.png")
                else
                    point:init("ui_runelink_lock.png")
                end
                point:floatLeft(3)
                attrDesLayout:addComponent(point)
                
                local baseText = UI.Text:create()
                if isUnlock then
                    baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_85_49_114)
                else
                    baseText:init(string.format("%s",data[1]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
                end
                -- baseText:setTextLeft()
                baseText:floatLeft(3)
                attrDesLayout:addComponent(baseText)

                local baseValue = UI.Text:create()
                if isUnlock then
                    baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_85_49_114)
                else
                    baseValue:init(string.format("%s",data[2]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
                end
                baseValue:floatLeft(3)
                attrDesLayout:addComponent(baseValue)
                
            end
        end

    end
    
end

function GemConnectView:refreshBreakBtn()
    --更新断开链接按钮状态
    local isEnable = false
    local isVisible = false

    local goodsData = self._mainRuneGoodsGrid:getData()
    local goodsData2 = self._connectRuneGoodsGrid:getData()

    if goodsData and goodsData2 and goodsData.viceGemStoneID and goodsData.viceGemStoneID ~= 0 then
        isVisible = true
        isEnable = true
    end

    if isVisible then
        if self._breakBtn and isEnable then
            self._breakBtn:show()
            self._breakBtn:enable()
            self._breakBtn:setFontColor(UI.FONT_COLOR_220_182_80)
            self._breakBtn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
        elseif self._breakBtn then
            self._breakBtn:show()
            self._breakBtn:disable()
            self._breakBtn:setFontColor(UI.FONT_COLOR_154_154_154)
            self._breakBtn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
        end
    else
        self._breakBtn:hide()
    end
end

function GemConnectView:refreshConnnectBtn()
    --更新链接符文按钮状态
    local isEnable = false
    local isVisible = true

    local goodsData = self._mainRuneGoodsGrid:getData()
    local goodsData2 = self._connectRuneGoodsGrid:getData()

    if goodsData and goodsData2 and goodsData.viceGemStoneID == 0 then
        isVisible = true
        isEnable = true
    elseif goodsData and goodsData2 and goodsData.viceGemStoneID ~= 0 then
        isVisible = false
        isEnable = false
    end

    if isVisible then
        if self._linkBtn and isEnable then
            self._linkBtn:show()
            self._linkBtn:enable()
            self._linkBtn:setFontColor(UI.FONT_COLOR_220_182_80)
            self._linkBtn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
        elseif self._linkBtn then
            self._linkBtn:show()
            self._linkBtn:disable()
            self._linkBtn:setFontColor(UI.FONT_COLOR_154_154_154)
            self._linkBtn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
        end
    else
        self._linkBtn:hide()
    end
end

function GemConnectView:runCancelReadyAnimtion(index)
    if index == nil then
        return
    end
    local animationName = "hint_end_yellow"
    if index == 1 and self._mainRuneFrame then
        self._mainRuneFrame:setAnimation(animationName, false)
    elseif index == 2 and self._connectRuneFrame then
        self._connectRuneFrame:setAnimation(animationName, false)
    end
end

function GemConnectView:runPutAnimtion(index)
    if index == nil then
        return
    end
    local animationName = "enchase_yellow"
    if index == 1 and self._mainRuneFrame then
        self._mainRuneFrame:setAnimation(animationName, false)
    elseif index == 2 and self._connectRuneFrame then
        self._connectRuneFrame:setAnimation(animationName, false)
    end
end

function GemConnectView:runReadyAnimtion(index)
    if index == nil then
        return
    end
    local animationName = "hint_begin_yellow"
    if index == 1 and self._mainRuneFrame then
        self._mainRuneFrame:setAnimation(animationName, false)
    elseif index == 2 and self._connectRuneFrame then
        self._connectRuneFrame:setAnimation(animationName, false)
    end
end

function GemConnectView:refreshGoodsGrid(grid)
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

function GemConnectView:refreshGemGridData(grid,goodsData,dontShowEffect)
    if grid == nil or goodsData == nil then
        return
    end

    local goodsData2 = grid:getData()
    if goodsData2 ~= nil then
        goodsData2._changeNum = goodsData2._changeNum + 1
        if goodsData2.isEquiped and goodsData2._changeNum > 0 then
            goodsData2._changeNum = 0
        end
    end

    if grid.index == 1 then 
        --清理材料
        local goodsData3 = self._connectRuneGoodsGrid:getData()
        if goodsData3 then
            goodsData3._changeNum = goodsData3._changeNum + 1
            if(goodsData3._changeNum > 0) then
                goodsData3._changeNum = 0
            end
            self._connectRuneGoodsGrid:reset()
            self:refreshGoodsGrid(self._connectRuneGoodsGrid)
            if not dontShowEffect then
                self:runCancelReadyAnimtion(self._connectRuneGoodsGrid.index)
            end
        end
    end

    grid:setData(goodsData)
    goodsData._changeNum = goodsData._changeNum - 1
    if grid.index == 1 then 
        self.initUsedTypeList[1].stoneShowLV = goodsData:getStoneLV()
        self.initUsedTypeList[1].gemStoneType = goodsData._localConfig.gemstoneType
        self.initUsedTypeList[1].isEquiped = nil
        self._bagGridList:setUsedType(self.initUsedTypeList)
    end
    self._bagGridList:refreshView()

    self:refreshGoodsGrid(grid)
    if not dontShowEffect then
        self:runPutAnimtion(grid.index)
    end

    self:refreshLeftLayer()

    --如果是放入主符文则刷新副符文
    if grid.index == 1 and goodsData.viceGemStoneID ~= 0 and self._connectRuneGoodsGrid then
        local viceGemStoneData = Goods.GemStoneData:create(goodsData.viceGemStoneID)
        viceGemStoneData:setIsNew(false)
        if viceGemStoneData then
            self:refreshGemGridData(self._connectRuneGoodsGrid,viceGemStoneData,dontShowEffect)
        end
    end
end

function GemConnectView:isRectContainsPointOfGrid(goodsGrid,touchPosition)
    if goodsGrid == nil or touchPosition == nil then
        return false
    end

    local t = goodsGrid:convertToWorldSpace(cc.p(0, 0))
    local space = 3
    local _rect =
        cc.rect(
        t.x - space,
        t.y - space,
        goodsGrid._width + space * 2,
        goodsGrid._height + space * 2
    )

    if cc.rectContainsPoint(_rect, touchPosition) then
        return true
    else
        return false
    end
end

function GemConnectView:bagDragBeganCallback(grid, touchPosition)

    local goodsData = grid:getData()
    if goodsData and goodsData.isEquiped then
        self:runReadyAnimtion(1)
    elseif goodsData then
        self:runReadyAnimtion(2)
    end

end

function GemConnectView:bagDragEndedCallback(grid, touchPosition, isInBag)
    local goodsData = grid:getData()
    if not isInBag then
        if goodsData and goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
            -- print("goodsData ===== ")
            -- dump(goodsData,nil,10)

            if goodsData and goodsData.isEquiped then
                self:refreshGemGridData(self._mainRuneGoodsGrid,goodsData)
                self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.GEM_STONE) --切换到符文背包页
                self._bagGridList:refreshView()
                return
            end

            local mainGoodsData = self._mainRuneGoodsGrid:getData()
            if mainGoodsData and mainGoodsData.viceGemStoneID and mainGoodsData.viceGemStoneID ~= 0 then
                UI.ScrollBar:createByText(UI.TEXT_227909)
                self:runCancelReadyAnimtion(self._connectRuneGoodsGrid.index)
            elseif mainGoodsData then
                self:refreshGemGridData(self._connectRuneGoodsGrid,goodsData)
            end

        end
    else
        if goodsData and goodsData.isEquiped then
            self:runCancelReadyAnimtion(self._mainRuneGoodsGrid.index)
        else
            self:runCancelReadyAnimtion(self._connectRuneGoodsGrid.index)
        end
    end
end

function GemConnectView:onTouchBeganByMaterialGoodsGrid(grid, touchPosition)
    if grid:getData() == nil then
        return false
    end
    self:runReadyAnimtion(grid.index)
    if (self._bagGridList) then
        self._bagGridList:showMove()
        self._bagGridList:setSpineBgVisible(true)
    end
    return true
end

function GemConnectView:onTouchEndedByMaterialGoodsGrid(grid, inSide)
    if (self._bagGridList) then
        self._bagGridList:hideMove()
        self._bagGridList:setSpineBgVisible(false)
    end

    if not inSide then

        if grid.index == 2 then
            local goodsData = self._mainRuneGoodsGrid:getData()
            if goodsData and goodsData.viceGemStoneID ~= 0 then
                --提示是否断开连接
                -- UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_227907,function()
                --     self:sendBreak()
                -- end)
                self:sendBreak()
                self:runPutAnimtion(grid.index)
                return
            end
        end

        local goodsData = grid:getData()
        goodsData._changeNum = goodsData._changeNum + 1
        grid:reset()
        self:refreshGoodsGrid(grid)
        self:runCancelReadyAnimtion(grid.index)

        if grid.index == 1 then
            local goodsData2 = self._connectRuneGoodsGrid:getData()
            if goodsData2 then
                goodsData2._changeNum = goodsData2._changeNum + 1
                self._connectRuneGoodsGrid:reset()
                self:refreshGoodsGrid(self._connectRuneGoodsGrid)
                self:runCancelReadyAnimtion(self._connectRuneGoodsGrid.index)
            end

            self.initUsedTypeList[1].stoneShowLV = nil
            self.initUsedTypeList[1].gemStoneType = nil
            self.initUsedTypeList[1].isEquiped = true
            self._bagGridList:setUsedType(self.initUsedTypeList)

            self._bagGridList:changeBagIndex(UI.BagGoodsPanel.BAG_TYPE.GEM_STONE_EQUIP_WEAR) --切换到装备符文页
        end

        self._bagGridList:refreshView()
    else
        self:runPutAnimtion(grid.index)
    end

    self:refreshLeftLayer()
end

function GemConnectView:sendConnect()
    local goodsData = self._mainRuneGoodsGrid:getData()
    local goodsData2 = self._connectRuneGoodsGrid:getData()

    if goodsData and goodsData2 then
        local data = {}
        data.equipUid = goodsData.equipEntityId
        data.holeIndex = goodsData.equipSlotIdx - 1
        data.viceGemid = goodsData2.goodsID
        -- data.packetType = goodsData:getBagType()

        -- print("  sendConnect data ===  ")
        -- dump(data,nil,10)

        UI.WaitingLayer:showWaiting(true, nil, 1)
        -- UI.WaitingLayer:hideWaiting()

        Net.NetGoodsSystem:requesGemConnectMessage(data)
    end
end

function GemConnectView:sendBreak()
    UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_227907,function()

        if (GameDataManager:getFreePacketBoxNum() <= 0) then
            UI.ScrollBar:createByText(UI.TEXT_1314137)
            return
        end

        local goodsData = self._mainRuneGoodsGrid:getData()
        if goodsData and goodsData.viceGemStoneID and goodsData.viceGemStoneID ~= 0 then
            local data = {}
            data.equipUid = goodsData.equipEntityId
            data.holeIndex = goodsData.equipSlotIdx - 1
            
            Net.NetGoodsSystem:requesGemDisConnectMessage(data)
        end
    end)
end

function GemConnectView:runLinkAnimation(callback)


    local anim1 = UI.Animation:create()
    anim1:init("effect_ui_town_fuwenshi.json", "effect_ui_town_fuwenshi.atlas", 1);
    anim1:center(0,7.5)
    anim1:setAnimation("trigger3", false)
    self._mainRuneLayout:addChild(anim1)

    local anim2 = UI.Animation:create()
    anim2:init("effect_ui_town_fuwenshi.json", "effect_ui_town_fuwenshi.atlas", 1);
    anim2:center(0,7.5)
    anim2:setAnimation("trigger1", false)
    self._mainRuneLayout:addChild(anim2)

    local anim3 = UI.Animation:create()
    anim3:init("effect_ui_town_fuwenshi.json", "effect_ui_town_fuwenshi.atlas", 1);
    anim3:center(0,3)
    anim3:setAnimation("trigger2", false)
    anim3:setScale(1 / self._connectRuneLayout:getScale())
    self._connectRuneLayout:addChild(anim3)

    anim1:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        anim1:runAction(cc.RemoveSelf:create())
    end)

    anim2:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        anim2:runAction(cc.RemoveSelf:create())
    end)

    anim3:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        anim3:runAction(cc.Sequence:create(
            cc.RemoveSelf:create(),
            cc.CallFunc:create(function()
                if callback then
                    callback()
                end
            end)))
    end)

end

function GemConnectView:bindModel()

end


function GemConnectView:unbindModel()

end





return GemConnectView













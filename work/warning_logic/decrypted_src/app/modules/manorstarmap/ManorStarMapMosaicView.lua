------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapMosaicView = class("ManorStarMapMosaicView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
    "ui_common_btn.plist",
}

local COM_WIDTH = 489
local COM_HEIGHT = 568
local winSize = cc.Director:getInstance():getWinSize()

local ManorStarMapMosaicPageType = {
    Star_Invalid = 0,           -- 无效的
    Star_All = 1,               -- 全部
    Star_Mosaic = 2,            -- 已镶嵌
    Star_No_Mosaic = 3,         -- 未镶嵌
    Star_Max = 4                -- 最大值
}

function ManorStarMapMosaicView:ctor(slotData)
    ManorStarMapMosaicView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._pageType = ManorStarMapMosaicPageType.Star_Invalid
    self._pageTable = {}
    self._cardTable = {}
    self._cellView = {}
    self._selectCarData = nil
    self._slotData = slotData
end

function ManorStarMapMosaicView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapMosaicView.super.init(self, ... )
end

function ManorStarMapMosaicView:dtor()
    ManorStarMapMosaicView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapMosaicView")
end


function ManorStarMapMosaicView:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout,10)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_starmap_popups.png")
    bg:center()
    self:addChild(bg)
    self._bg = bg

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222628, UI.FONT_BOLD, UI.FONT_SIZE_22PX, {r = 184, g = 183, b = 182})
    titleText:centerUp(22,0)
    bg:addChild(titleText)

    local closeBtn = UI.Button:create()
    closeBtn:init('ui_btn_no1_0.png', 'ui_btn_no1_0.png', 'ui_btn_no1_0.png')
    closeBtn:centerBottom(25, -106)
    
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.closePanel("ManorStarMap", "ManorStarMapMosaic")
    end)
    self._bg:addChild(closeBtn)

    local okBtn = UI.Button:create()
    okBtn:init('ui_btn_yes1_1.png', 'ui_btn_yes1_1.png', 'ui_btn_yes1_1.png')
    okBtn:centerBottom(25, 106)
    
    okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        print("111111111 ")
        self:doAction()
    end)
    self._bg:addChild(okBtn)



    self:updatePageView(ManorStarMapMosaicPageType.Star_All)

    self._pageTable = {}

    local StarMapPageName = {
        [ManorStarMapMosaicPageType.Star_All] = UI.TEXT_222625,
        [ManorStarMapMosaicPageType.Star_Mosaic] = UI.TEXT_222626,
        [ManorStarMapMosaicPageType.Star_No_Mosaic] = UI.TEXT_222627,
    }

    for i = ManorStarMapMosaicPageType.Star_All, ManorStarMapMosaicPageType.Star_Max - 1 do
        local pageBtn = UI.Button:create()
        pageBtn:init('ui_starmap_btn_gray2.png', 'ui_starmap_btn_gray2.png', 'ui_starmap_btn_gray1.png')
        pageBtn:leftBottom(self._bg:getContentSize().width - 20, self._bg:getContentSize().height - 90 - (i-1) * 70)
        pageBtn:setTextFont( UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r = 215, g = 205, b = 139})
        pageBtn:setText(StarMapPageName[i])
        pageBtn:closeClickScale()
        
        pageBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:updatePageView(i)

            for k,v in pairs(self._pageTable) do
                if i == k then
                    v:disable()
                    v:setFontColor({r = 215, g = 205, b = 139})
                    v:setTextOffset(0,0)
                else
                    v:enable()
                    v:setFontColor({r = 41, g = 44, b = 48})
                    v:setTextOffset(-10,0)
                end
            end

        end)
        self._bg:addChild(pageBtn)
        self._pageTable[i] = pageBtn

        if i == self._pageType then
            pageBtn:disable()
            pageBtn:setFontColor({r = 215, g = 205, b = 139})
            pageBtn:setTextOffset(0,0)
        else
            pageBtn:enable()
            pageBtn:setFontColor({r = 41, g = 44, b = 48})
            pageBtn:setTextOffset(-10,0)
        end

    end

end

function ManorStarMapMosaicView:updatePageView(pageType)
    if pageType == nil or pageType == self._pageType then
        return
    end

    self.contentLayout:removeAllChildren()

    self._pageType = pageType
    self._cardTable = {}
    self._selectCarData = nil

    local allCardData = clone(mvc.manorStarMapModel._starCardData)
    if self._pageType == ManorStarMapMosaicPageType.Star_All then
        for k,v in pairs(allCardData) do

            local canInsert = false
            local cardConfig = ConfigManager:getAllStarCardDataByID(v.cardId)
            local cardConfig2 = ConfigManager:getAllStarCardDataByID(self._slotData.cardId)
            if self._slotData.type == 1 and cardConfig.type == 1 and v.cardId ~= self._slotData.cardId then
                canInsert = true
            elseif self._slotData.type == 2 and v.cardId ~= self._slotData.cardId then
                if cardConfig2 and cardConfig2.type == 2 and cardConfig.type == 1 and v.slotId > 0 then
                    canInsert = false
                else
                    canInsert = true
                end
            end

            if self._slotData.mosaicType ~= cardConfig.mosaicType then
                canInsert = false
            end

            if canInsert then
                table.insert(self._cardTable,v)
            end
        end

    elseif self._pageType == ManorStarMapMosaicPageType.Star_Mosaic then
        for k,v in pairs(allCardData) do
            if v.slotId ~= 0 then

                local canInsert = false
                local cardConfig = ConfigManager:getAllStarCardDataByID(v.cardId)
                local cardConfig2 = ConfigManager:getAllStarCardDataByID(self._slotData.cardId)
                if self._slotData.type == 1 and cardConfig.type == 1 and v.cardId ~= self._slotData.cardId then
                    canInsert = true
                elseif self._slotData.type == 2 and v.cardId ~= self._slotData.cardId then
                    if cardConfig2 and cardConfig2.type == 2 and cardConfig.type == 1 and v.slotId > 0 then
                        canInsert = false
                    else
                        canInsert = true
                    end
                end

                if self._slotData.mosaicType ~= cardConfig.mosaicType then
                    canInsert = false
                end
                
                if canInsert then
                    table.insert(self._cardTable,v)
                end
            end
        end
    elseif self._pageType == ManorStarMapMosaicPageType.Star_No_Mosaic then
        for k,v in pairs(allCardData) do
            if v.slotId == 0 then

                local canInsert = false
                local cardConfig = ConfigManager:getAllStarCardDataByID(v.cardId)
                local cardConfig2 = ConfigManager:getAllStarCardDataByID(self._slotData.cardId)
                if self._slotData.type == 1 and cardConfig.type == 1 and v.cardId ~= self._slotData.cardId then
                    canInsert = true
                elseif self._slotData.type == 2 and v.cardId ~= self._slotData.cardId then
                    if cardConfig2 and cardConfig2.type == 2 and cardConfig.type == 1 and v.slotId > 0 then
                        canInsert = false
                    else
                        canInsert = true
                    end
                end

                if self._slotData.mosaicType ~= cardConfig.mosaicType then
                    canInsert = false
                end

                if canInsert then
                    table.insert(self._cardTable,v)
                end
            end
        end
    end


    if #self._cardTable > 1 then
        table.sort(self._cardTable, 
            function(a, b) 
                if a.cardPage == b.cardPage then
                    if a.level == b.level then
                        return a.cardId > b.cardId 
                    else
                        return a.level > b.level 
                    end
                else
                    return a.cardPage > b.cardPage 
                end
            end
        )
    end

    self:refreshContentView()

end

function ManorStarMapMosaicView:refreshContentView()
    if #self._cardTable == 0 then
        return
    end

    self._cellView = {}
    self._selectCarData = nil

    local tableView = UI.TableView:create({}, 423, 418)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(32,85)
    -- tableView:center(0,0)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 408,201
    end) 
    tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()

                local cardLayout = UI.Layout:create()
                cardLayout:init()
                cardLayout:setSize(408,192)
                cardLayout:leftBottom(0,0)

                
                for i = 1 + (luaIdx - 1)*3, luaIdx*3 do
                    if self._cardTable[i] then
                        local cardView = mvc.manorStarMapMosaicCellView:create(self._cardTable[i],tableView)
                        cardView:init()
                        cardView:enableDrage()
                        cardView:floatLeft(9)
                        cardLayout:addComponent(cardView)

                        cardView:setCallBack(function(mView)
                            for k,v in pairs(self._cellView) do
                                if v == mView and v.setSelect then
                                    v:setSelect(true)
                                    self._selectCarData = v._cardData
                                elseif v.setSelect then
                                    v:setSelect(false)
                                end
                            end
                        end)

                        self._cellView[i] = cardView
                    end
                end

                cell:addChild(cardLayout)
            end, 
            function(e) 
                printError("------------------------refreshCardLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onUpdateCellNumbers(function()
        return math.ceil(#self._cardTable / 3)
    end)
    self.contentLayout:addChild(tableView)
    tableView:reloadData()

end

function ManorStarMapMosaicView:doAction()
    if self._selectCarData == nil then
        UI.ScrollBar:createByText(UI.TEXT_222629)
        return
    end

    local slotId = self._slotData.ID
    local cardId = self._selectCarData.cardId
    
    Net.NetManorSystem:reqStarAtlasEquipCard(slotId,cardId)

    mvc.closePanel("ManorStarMap", "ManorStarMapMosaic")
end

function ManorStarMapMosaicView:bindModel()

end


function ManorStarMapMosaicView:unbindModel()

end





return ManorStarMapMosaicView













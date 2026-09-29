------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/08/14
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RecastSuitTransformContentView = class("RecastSuitTransformContentView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_recasting.plist",
    "ui_common_information.plist"
}

local COM_WIDTH = 352
local COM_HEIGHT = 595

function RecastSuitTransformContentView:ctor()
    RecastSuitTransformContentView.super.ctor(self, UI.Type.EQUIP_TRANS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
end

function RecastSuitTransformContentView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.recast", "Recast", false)
    RecastSuitTransformContentView.super.init(self, ...)
end

function RecastSuitTransformContentView:dtor()
    RecastSuitTransformContentView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.recast.RecastSuitTransformContentView")
end

function RecastSuitTransformContentView:createOneCell(content, isRich)
    local success = false
    local _richText = nil
    local cell = nil
    if isRich then
        _richText = UI.RichText:create()
        success = _richText:init(content, 240, UI.FONT_SIZE_16PX)
    elseif content ~= "" then
        success = true
        _richText = UI.Text:create()
        _richText:init(content, UI.FONT_STANDARD, UI.FONT_SIZE_16PX,UI.FONT_COLOR_41_41_45)
        _richText:setLineSpacing(3)
        -- _richText:setAdditionalKerning(20)
        _richText:setTextLeft()
        _richText:setWidth(280)
        _richText:autoAdapt()
    end
    if success then
        cell = UI.Layout:create()
        cell:init()
        _richText:centerLeft(0)
        cell:setSize(260, _richText:getContentSize().height)
        cell:addChild(_richText)
    end
    return cell
end

function RecastSuitTransformContentView:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_recasting_bg.png")
    bg:center()
    self:addChild(bg)

    local titleBg = UI.Image:create()
    titleBg:init("ui_recasting_title.png")
    titleBg:centerUp(-30)
    self:addChild(titleBg, 10)

    local titleStr = UI.Text:create()
    titleStr:init(UI.TEXT_1212308, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    titleStr:centerBottom(11)
    titleBg:addChild(titleStr)
    self.titleStr = titleStr

    --spine
    self.recastAnimation = UI.Animation:create()
    self.recastAnimation:init("effect_ui_twon_recast_top.json", "effect_ui_twon_recast_top.atlas", 1)
    self.recastAnimation:centerUp(102)
    self:addChild(self.recastAnimation)
    self.recastAnimation:setAnimation("idle", false)

    self.iconAnimation = UI.Animation:create()
    self.iconAnimation:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1)
    self.iconAnimation:centerUp(102)
    self:addChild(self.iconAnimation)

    self.lightAnimation = UI.Animation:create()
    self.lightAnimation:init("effect_ui_twon_recast_top_light.json", "effect_ui_twon_recast_top_light.atlas", 1)
    self.lightAnimation:centerUp(100)
    self:addChild(self.lightAnimation, 200)

    self.downAnimation = UI.Animation:create()
    self.downAnimation:init("effect_ui_twon_recast_down.json", "effect_ui_twon_recast_down.atlas", 1)
    self.downAnimation:centerBottom(39)
    self:addChild(self.downAnimation)
    self.downAnimation:setAnimation("idle", false)
    --spine end
    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:leftUp(285, 38)
    self:addChild(detailAnimation, 100)
    detailAnimation:setTouchEnable(true)
    

    detailAnimation:addEventListener(UIEvent.COMPONENT_CLICK, self, function(_,sender)
        if self.infoPanel == nil or tolua.isnull(self.infoPanel) then
            local panel = UI.Image:create()
            panel:init("ui_information_banner_details.png")
            panel:leftUp(287,-38)
            self:addChild(panel, 1001)
            self.infoPanel= panel
            local xAdd = 65
            local yAdd = 80
            local title = UI.Text:create()
            title:init(LanguageManager:getInstance():getLocalString(1112821), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
            panel:addChild(title) 
            title:centerUp(25 + yAdd)
    
            local line  = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
            line:setContentSize(282, 2)
            line:setCapInsets(CCRectMake(20,1,1,1))
            line:setPosition(160+xAdd, 382+yAdd)
            panel:addChild(line)
            
            local layout = UI.Layout:create()
            layout:init()
            local textArr = {1112822, 1112823,1112824,1112825}
            local height = 3
            local cellSpace = 5
            for k, v in ipairs(textArr) do
                local cell = self:createOneCell(UIUtil:lang(v))
                if cell then
                    cell:leftUp(0, height)
                    layout:addChild(cell)
                    height = height + cell:getContentSize().height + cellSpace
                end
            end
    
            height = height < 320 and 320 or height
            layout:setSize(280, height)
            if height > 320 then
                local scrollView = UI.ScrollView:create()
                scrollView:setSize(290, 320)
                scrollView:init()
                scrollView:leftUp(25+xAdd, 67+yAdd)
                scrollView:addInnerNode(layout)
                scrollView:useDefaultScrollBar()
                panel:addChild(scrollView,1)    
            else
                layout:leftUp(25+xAdd, 67+yAdd)
                panel:addChild(layout)
            end
    
            local touch = UI.Component:create()
            touch:init()
            touch:setSize(310,410)
            touch:center()
            panel:addChild(touch)
        
            touch:setTouchEnable(true)
            touch:setInterceptTouches(true)
            touch:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, panel, function()
                panel:removeFromParent()
                self.infoPanel = nil
            end)
        else
            self.infoPanel:show()
        end
    end)
    -- 中间展示区域
    local centerBg = UI.Image:create()
    centerBg:init("ui_recasting_decorate_02.png")
    centerBg:centerBottom(75)
    self:addChild(centerBg)

    local centeLayout = UI.Layout:create()
    centeLayout:init()
    centeLayout:setSize(centerBg:getContentSize().width, centerBg:getContentSize().height)
    centeLayout:center()
    centerBg:addChild(centeLayout)
    self.centeLayout = centeLayout

    local centerTitleStr = UI.Text:create()
    centerTitleStr:init(UI.TEXT_1213037, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    centerTitleStr:centerUp(-3)
    centerBg:addChild(centerTitleStr)

    local centerTitleStr = UI.Text:create()
    centerTitleStr:init(UI.TEXT_1213038, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    centerTitleStr:centerBottom(61)
    centerBg:addChild(centerTitleStr)

    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:leftUp(143, 67)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:showInfoArea()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setDragOutAreaJudgeNode(self)
    self.mGoodsGrid:setDragBeginCallback(function() end)
    self.mGoodsGrid:setDragEndCallback( function(grid) mvc.send(mvc.events.Recast_Suit_Transform_Drag_Out, grid) end)
    self:addChild(self.mGoodsGrid, 100)

    -- 下面的操作区域
    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_2.png")
    executeButton:centerBottom(6)
    self:addChild(executeButton, 10)
    executeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    executeButton:setText(UI.TEXT_1213036)
    executeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onTransformClick)
    executeButton:disable()
    self.executeButton = executeButton
    local com = UI.Layout:create()
    com:init()
    com:center(0, 0)
    local executeButtonIcon = UI.Image:create()
    executeButtonIcon:init("symbol_gaming_money.png")
    executeButtonIcon:centerLeft(90)
    executeButtonIcon:floatLeft(0)
    com:addComponent(executeButtonIcon)
    self.executeButtonIcon = executeButtonIcon
    local executeButtonPrice = UI.GoodsCostText:create(tostring(0), 
    Game.ConstGoods.Coin, 0, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    executeButtonPrice:setShowSize(10)
    -- local executeButtonPrice = UI.NumberText:create("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51, 10)
    executeButtonPrice:centerLeft(130)
    executeButtonPrice:floatLeft(5)
    com:addComponent(executeButtonPrice)
    self.executeButtonPrice = executeButtonPrice
    com:enableAutoWidth()
    com:enableAutoHeight()
    self.priceLayout = com
    self.priceLayout:hide()
    executeButton:addChild(com, 101)

    local pos = {
        {142,270},
        {55,222},
        {230,223},
        {142, 175}
    }
    self.targetGoodsGrid={}
    for i = 1, 4 do 
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init()
        goodsGrid:leftBottom(pos[i][1], pos[i][2])
        goodsGrid:hide()
        goodsGrid:showInfoArea()
        goodsGrid:hideCountLabel()
        goodsGrid:hideNewIcon()
    
    goodsGrid:addEventListener(UIEvent.COMPONENT_CLICK, self, function() mvc.send(mvc.events.Recast_Suit_Transform_Target_Select, i) end)
        self:addChild(goodsGrid, 100)
        table.insert(self.targetGoodsGrid, goodsGrid)
    end

    self.costItems = {}
    for i = 1, 3 do 
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init()
        goodsGrid:setScale(0.8)
        goodsGrid:leftBottom(55 + (i -1)*86, 72)
        goodsGrid:hide()
        goodsGrid:showInfoArea()
        goodsGrid:hideCountLabel()
        self:addChild(goodsGrid, 100)
        goodsGrid:hideNewIcon()
        local costNumText = UI.GoodsCostText:create(tostring(0), 
            Game.ConstGoods.Coin, 0, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
        costNumText:setShowSize(10)
        costNumText:setCareWarehouseGoods(true)
        costNumText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
        costNumText:rightBottom(0, 0)
        goodsGrid:addChild(costNumText, 100)
        goodsGrid.costNumText = costNumText

        table.insert(self.costItems, goodsGrid)
    end
end

function RecastSuitTransformContentView:updateSelectTarget(idx)
    if self.curSelect then
        self.curSelect:hideSelect()
    end
    self.curSelect = self.targetGoodsGrid[idx]
    self.curSelect:showSelect()
end

function RecastSuitTransformContentView:updateContentItems(suitEquips, costItems)
        
    local num = #suitEquips
    for i = 1, num do
        self.targetGoodsGrid[i]:setData(suitEquips[i])
        self.targetGoodsGrid[i]:updateView()
        self.targetGoodsGrid[i]:show()
    end
    
    for i = num + 1, #self.targetGoodsGrid do
        self.targetGoodsGrid[i]:hide()
    end

    local num = #costItems
    for i = 1, num do
        self.costItems[i]:setData(costItems[i])
        self.costItems[i]:updateView()
        self.costItems[i]:show()
        self.costItems[i]:hideNewIcon()

        local haveNum, warehouse = GameDataManager:getGoodsDataNumForGoodsID(costItems[i].goodsID, true, true) 
        haveNum = haveNum + warehouse

        self.costItems[i].costNumText:updateCost(costItems[i].costNum, 
            haveNum .. "/".. costItems[i].costNum, costItems[i].goodsID)
    end
    for i = num + 1, #self.costItems do
        self.costItems[i]:hide()
    end
end

function RecastSuitTransformContentView:getTargetGridData()
    return self.mGoodsGrid:getData()
end
function RecastSuitTransformContentView:setTargetGridData(goodsData)
    if not goodsData then
        self.mGoodsGrid:reset()
        self.mGoodsGrid:hide()
    else
        self.mGoodsGrid:setData(goodsData)
        self.mGoodsGrid:updateView()
        self.mGoodsGrid:show()
    end
end

function RecastSuitTransformContentView:checkTouchInGrid(touchPosition)
    if self.mGoodsGrid:checkTouchPosition(touchPosition) then
        return true
    end
end
function RecastSuitTransformContentView:updateBtnState(isEnable, cost)
    if(self.mGoodsGrid:getData()) then
        self.executeButton._text:hide()
        self.executeButtonPrice:updateCost(cost, tostring(cost))
        self.priceLayout:updateView()
        self.priceLayout:show()
    else 
        self.executeButton._text:show()
        self.priceLayout:hide()
    end
    if(isEnable) then 
        self.executeButton:enable()
    else 
        self.executeButton:disable()
    end
end

function RecastSuitTransformContentView:updateGridAnimation(tag)
    if tag == "ToTarget" then
        self.iconAnimation:setAnimation("ready1", false)
        self.iconAnimation:addAnimation("ready2", true)
    elseif tag == "ToTargetEnd" then
        self.iconAnimation:setAnimation("put1", false)
        self.iconAnimation:addAnimation("put2", true)
    elseif tag == "ToTargetCancel" then
        self.iconAnimation:setAnimation("ready3", false)
    elseif tag == "MoveOutTargetEnd" then
        self.iconAnimation:setAnimation("ready3", false)
    end
end

function RecastSuitTransformContentView:doRewardAnimation(isSucc)
    if isSucc then
        self.lightAnimation:setAnimation("success", false)
        self.recastAnimation:setAnimation("success", false)
        self.downAnimation:setAnimation("success", false)
    else
        self.lightAnimation:setAnimation("fail", false)
        self.recastAnimation:setAnimation("fail", false)
        self.downAnimation:setAnimation("fail", false)
    end
end
function RecastSuitTransformContentView:onTransformClick()
    mvc.send(mvc.events.Recast_Do_Suit_Transform, self.mGoodsGrid:getData(), self.curSelect:getData())
end

function RecastSuitTransformContentView:bindModel()
end

function RecastSuitTransformContentView:unbindModel()
end

return RecastSuitTransformContentView

-- RewardLayer.lua
-- Author:ydli
-- 2018年7月11日
-- Using:公用奖励获取界面

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local RewardLayer = class("RewardLayer", UI.HWBtnComponent)
UI.RewardLayer = RewardLayer
local winSize = cc.Director:getInstance():getWinSize()

local COM_RES_LIST = {

}

local LAYERSIZE = {
    SMALL = 1,
    MID = 2,
    BIG = 3
}
local CELL_NUMBER = 5 --一排显示的道具数量

RewardLayer.Style = {
    showConfirmButton = 1,
    notShowAnyButton = 2
}

function RewardLayer:ctor(goodsDataList, callback, titleStr, style, equipmentWasGet, buttonStr, isDisable)
    print("RewardLayer:ctor")
    RewardLayer.super.ctor(
        self, 0,
        COM_RES_LIST,
        winSize.width,
        winSize.height
        )
    self.buttonStr = buttonStr
    self.titleStr = titleStr or UI.TEXT_1172004
    self.style = style or RewardLayer.Style.showConfirmButton
    self.rootLayer = nil;           --root节点
    self.goodsDataList = goodsDataList or {}
    self.callback = callback
    self.allGridNode = {}
    self.layerSize = LAYERSIZE.SMALL
    self.equipmentWasGet = equipmentWasGet
    self.isDisable = isDisable

    -- --test
    -- self.style = RewardLayer.Style.showConfirmButton
    -- local tempList = {}
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- table.insert(tempList, self.goodsDataList[1])
    -- self.goodsDataList = tempList
    --test

    local size = table.nums(self.goodsDataList)
    if size <= CELL_NUMBER then
        self.layerSize = LAYERSIZE.SMALL
    elseif size <= CELL_NUMBER * 2 then
        self.layerSize = LAYERSIZE.MID
    else
        self.layerSize = LAYERSIZE.BIG
    end
    self:init()
end

function RewardLayer:dtor()
    RewardLayer.super.dtor(self)
    self:unRegisterListener()
end

-- public:
-- 初始化
function RewardLayer:init()
    RewardLayer.super.init(self)
    self:registerListener()
end

-- 模版函数：初始化组建的视图
function RewardLayer:onInitView()
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init(0, 0, 0, 0)
    self.rootLayer:setSize(winSize.width / 2, winSize.height / 2)
    self.rootLayer:center()
    self:addChild(self.rootLayer, 10)

    self.rootLayer:setTouchEnable(true)
    self.rootLayer:setInterceptTouches(true)
    -- self.rootLayer:enableDebugDraw()

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box2.png")
    bg:setCapInsets(CCRectMake(190,96,5,5))
    local bgSize = cc.size(500, 256)
    if self.layerSize == LAYERSIZE.SMALL then
        bgSize = cc.size(500, 256)
    elseif self.layerSize == LAYERSIZE.MID then
        bgSize = cc.size(500, 335)
    elseif self.layerSize == LAYERSIZE.BIG then
        bgSize = cc.size(540, 370)
    end
    if self.style == RewardLayer.Style.notShowAnyButton then
        bgSize.height = bgSize.height - 30
    end
    bg:setContentSize(bgSize)
    self.bgSize = bgSize
    self:addChild(bg, 20)
    bg:setPosition(winSize.width / 2, winSize.height / 2)
    self.bg = bg
    self.rootLayer:setSize(bgSize.width, bgSize.height)

    local title = UI.Text:create()
    title:init(self.titleStr, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    title:setSize(470, 50)
    title:setTextCenter()
    title:setLineSpacing(-5)
    -- title:enableDebugDraw()
    self.bg:addChild(title)
    title:centerUp(17)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(430, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setAnchorPoint(cc.p(0.5,0.5))
    lineUpImage:setPosition(cc.p(self.bg:getContentSize().width / 2, self.bg:getContentSize().height - 55))
    self.bg:addChild(lineUpImage)

    local lineDownImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineDownImage:setContentSize(430, 1)
    lineDownImage:setCapInsets(CCRectMake(1,0,1,1))
    lineDownImage:setPosition(cc.p(self.bg:getContentSize().width/2, 72))
    self.bg:addChild(lineDownImage)
   
    self.title = title
    local rewardLayer = self:showGoodsView()
    if self.style == RewardLayer.Style.showConfirmButton then
        local confirmButton = UI.Button:create()
        confirmButton:init("ui_btn_yellow2_0.png","ui_btn_yellow2_1.png","ui_btn_yellow2_2.png")
        confirmButton:centerBottom(23)
        self.bg:addChild(confirmButton, 100)
        confirmButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44) 
        confirmButton:setText(self.buttonStr or UI.TEXT_1170211)
        confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(sender, touch) 
            self:closeLayer()
        end)
        self.confirmButton = confirmButton
        local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,125))
        colorLayer:setIgnoreAnchorPointForPosition(false)
        colorLayer:setAnchorPoint(cc.p(0.5,0.5))
        colorLayer:setPosition(winSize.width / 2, winSize.height / 2)
        colorLayer:setContentSize(winSize.width, winSize.height)
        self:addChild(colorLayer,-1)
        title:centerUp(16)
        lineUpImage:setPosition(cc.p(self.bg:getContentSize().width / 2, self.bg:getContentSize().height - 70))
        lineDownImage:setPosition(cc.p(self.bg:getContentSize().width/2, 85))
        if self.layerSize == LAYERSIZE.BIG then
            rewardLayer:centerUp(74)
        else
            rewardLayer:centerUp(80)
        end
        if self.isDisable then
            self.confirmButton:hide()
        end
        self.rootLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
            self:closeLayer()
        end)
    else
        self.rootLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
            self:closeLayer()
        end)
        local lucencyLight = UI.Layout:create()
        lucencyLight:init(0, 0, 0, 0)
        lucencyLight:setSize(bgSize.width, bgSize.height)
        lucencyLight:center()
        bg:addChild(lucencyLight, -1)
        
        title:centerUp(16)
        lucencyLight:showLucencyLight(self.bgSize.width, self.bgSize.height)
        lineUpImage:setPosition(cc.p(self.bg:getContentSize().width / 2, self.bg:getContentSize().height - 72))
        lineDownImage:setPosition(cc.p(self.bg:getContentSize().width/2, 36))
        if self.layerSize == LAYERSIZE.BIG then
            rewardLayer:centerUp(78)
        else
            rewardLayer:centerUp(90)
        end
    end
end

function RewardLayer:showAction(actionType)
    if actionType == Game.RewardLayerOpenAction.Scale_Center then
        self.bg:setScale(0.001)
        local scaleAction = cc.ScaleTo:create(0.15, 1, 1)
        local easeScaleAction = cc.EaseOut:create(scaleAction, 4)
        self.bg:runAction(easeScaleAction)
    elseif actionType == Game.RewardLayerOpenAction.Move_Top2Center_Slow then
        local oldPosY = self.bg:getPositionY()
        self.bg:setPosition(self.bg:getPositionX(), winSize.height)
        local move = cc.MoveTo:create(0.3, cc.p(self.bg:getPositionX(), oldPosY))
        move = cc.EaseOut:create(move, 1)
        self.bg:runAction(move)
    end
end


function RewardLayer:closeLayer()
    if self.callback then
        self.callback()
    end
    self:close()
end

function RewardLayer:setTitle(str)
    self.title:setText(str)
end

function RewardLayer:updateLayout( )

end

function RewardLayer:sortData()
    table.sort( self.goodsDataList, function( a, b )
        return a.goodsRare > b.goodsRare
    end )
end

function RewardLayer:showGoodsView()
    self:sortData()
    local itemPadding = 80
    local size = table.nums(self.goodsDataList)
    local height = math.ceil(size / CELL_NUMBER)
    local width = 0
    if height > 1 then
        width = CELL_NUMBER * itemPadding
    else
        width = size % CELL_NUMBER
        width = (width == 0) and CELL_NUMBER or width
        width = width* itemPadding
    end 
    height = height * itemPadding

    local upLayout = UI.TouchLayout:create()
    upLayout:init(0, 0, 0, 0)
    upLayout:setSize(width, height)
    upLayout:addTouchEvents(self)
    -- upLayout:enableDebugDraw()
    if self.layerSize == LAYERSIZE.BIG then
        upLayout:centerUp(0)
        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        if self.style == RewardLayer.Style.notShowAnyButton then
            detailedScrollView:setSize(410, 220)
        else
            detailedScrollView:setSize(410, 206)
        end
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(upLayout)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarWidth(5)
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(2, 0))
        self.bg:addChild(detailedScrollView)
        self.rewardLayer = detailedScrollView
    else
        self.bg:addChild(upLayout)
        self.rewardLayer = upLayout
    end
    local beginPosX = -8
    local index = 1
    for k, goodData in pairs(self.goodsDataList) do
        goodData:setIsNew(false)
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        upLayout:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        if self.equipmentWasGet == true then 
            goodGrid:setInfoArea(false, false)
        else 
            goodGrid:setInfoArea(true, false)
        end
        local mode = index % CELL_NUMBER
        mode = mode == 0 and CELL_NUMBER or mode
        goodGrid:leftUp((mode - 1) * itemPadding, math.floor((index - 1) / CELL_NUMBER) * itemPadding + 6)
        table.insert(self.allGridNode, goodGrid)
        index = index + 1
    end  
    return self.rewardLayer
end

-- 模版函数：更新组建的视图
function RewardLayer:onUpdateView()
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    print("---onTouchDialogOutsizeHandler-----")
    if self.callback then
        self.callback()
    end
    self:close()
end

-- 注册监听事件
function RewardLayer:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
end

-- 注销监听事件
function RewardLayer:unRegisterListener()
  
end

function RewardLayer:onTouchBegan(touch, event)
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and value:isVisible() then
            self.selectIndex = k
            break
        end
    end
end

function RewardLayer:onTouchEnded(touch, event)
    local location = touch:getLocation()

    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    if not self.rewardLayer:checkTouch(touch) then
        return;
    end

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            local pInfoArea = value:onShowInfoAreaHandler(true)
            if pInfoArea then
                local mode = self.selectIndex % CELL_NUMBER
                mode = mode == 0 and CELL_NUMBER or mode
                if mode < CELL_NUMBER / 2 then
                    pInfoArea:centerRight(winSize.width / 2 + self.bg:getContentSize().width / 2 - 20)
                else
                    pInfoArea:centerLeft(winSize.width / 2 + self.bg:getContentSize().width / 2 - 10)
                end
                if pInfoArea:getZOrder() <= self:getZOrder() then
                    pInfoArea:setZOrder(self:getZOrder())
                end
            end
            break
        end
    end
end

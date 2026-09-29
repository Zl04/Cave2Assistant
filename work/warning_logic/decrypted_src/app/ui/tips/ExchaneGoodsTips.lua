-- ExchaneGoodsTips.lua
-- Author:zp
-- 2019年3月21日
-- Using:集换物品确认框

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local CELL_NUMBER = 4
local ExchaneGoodsTips = class("ExchaneGoodsTips",UI.HWBtnComponent)
UI.ExchaneGoodsTips = ExchaneGoodsTips
--  ui_tips_team
local VOTE_SUCCEED_TIPS_PLIST = {
    "ui_common_btn.plist",
    "ui_general_tips.plist",
    "ui_common_scale9image.plist",
    "ui_common_information.plist"
}


local function onCancelHandler(self)

    self:close();
end

local function onConfirmHandler(self)
    if(self._okCallFun) then 
        self._okCallFun()
    end
    self:close();
end

local function onCenterHandler(self)
    if(self._centerCallFun) then 
        self._centerCallFun()
    end
    self:close();
end


-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    -- self:close();
end

--  构造函数
function ExchaneGoodsTips:ctor()
    ExchaneGoodsTips.super.ctor(self,UIType.EXCHANGE_CONFIRM,VOTE_SUCCEED_TIPS_PLIST, winSize.width, winSize.height)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
    self._centerCallFun = nil
    self.allGridNode = {}
end

--  析构函数 调用父类的方法
function ExchaneGoodsTips:dtor()
    ExchaneGoodsTips.super.dtor(self)
    self.allGridNode = {}
end

--  初始化函数
function ExchaneGoodsTips:init(useGoodsData, wasGetGoodsArr)
    self._useGoodsData = useGoodsData
    self.goodsDataList = wasGetGoodsArr
    ExchaneGoodsTips.super.init(self)
end

--  初始化界面函数
function ExchaneGoodsTips:onInitView()
    self:setTouchEnable(true)
    self:setInterceptTouches(true)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local bg = UI.Image:create()
    self._bg = bg
    bg:init("ui_setup_banner_box2.png")
    bg:center()
    self:addChild(bg)
    self:setSize(bg._width,bg._height)

    local contentTopLine = UI.Image9:create()
    contentTopLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentTopLine:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    contentTopLine:setReflectSize(452, 2)
    contentTopLine:centerUp(55)
    self._bg:addChild(contentTopLine)

    local contentBottomLine = UI.Image9:create()
    contentBottomLine:init("ui_scale9image_banner_line_light2.png",{x=0,y=0,width=20,height=20})
    contentBottomLine:setLayoutType(UI.LayoutDefaultType.LEFT_UP)
    contentBottomLine:setReflectSize(452, 2)
    contentBottomLine:centerUp(282)
    self._bg:addChild(contentBottomLine)


    local contentBg = UI.Image9:create()
    contentBg:init("ui_scale9image_setup_banner_box_up.png", {x = 0, y = 0, width = 20, height = 20})
    contentBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentBg:centerUp(56)
    contentBg:setReflectSize(452, 226)
    contentBg:computePosition()
    bg:addChild(contentBg)

    local titleText = UI.Text:create() 
    titleText:init(LanguageManager:getInstance():getLocalString(1111841), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(34- titleText:getContentSize().height/2)
    titleText:setTextCenter()
    bg:addChild(titleText, 10)

    -- 显示中间的内容
    self._useGoodsData:setIsNew(false)
    local goodGrid = UI.GoodsGrid:create()
    goodGrid:init(self._useGoodsData)
    self._bg:addChild(goodGrid)
    goodGrid:hideFlagIcon()
    goodGrid:showInfoArea(true, false)
    goodGrid:centerUp(65)
    table.insert(self.allGridNode, goodGrid)

    -- 
    local centerImage = UI.Image:create()
    centerImage:init("ui_comment_btn_arrow_1.png")
    self._bg:addChild(centerImage)
    centerImage:centerUp(142)

    self:showGoodsView()

    local confirmButton = UI.Button:create()
    confirmButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png")
    confirmButton:addEventListener(UIEvent.BUTTON_CLICK, self, onConfirmHandler)
    confirmButton:openClickScale()
    self._bg:addChild(confirmButton, 10)

    local cancleButton = UI.Button:create()
    cancleButton:init("ui_btn_no1_0.png", "ui_btn_no1_1.png", "ui_btn_no1_2.png")
    cancleButton:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
    self._bg:addChild(cancleButton, 10)
    cancleButton:openClickScale()
    
    cancleButton:leftBottom(104, 29)
    confirmButton:rightBottom(104, 29)
end

-- 传递回调函数名字
function ExchaneGoodsTips:callfunName(okCallFun,cancelCallFun, centerCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
    self._centerCallFun = centerCallFun
end

-- 更新视图
function ExchaneGoodsTips:onUpdateView()

end

function ExchaneGoodsTips:showGoodsView()
    local itemPadding = 111
    local itemPaddingY = 82
    local size = table.nums(self.goodsDataList)
    if(size > 0) then 
        local height = math.ceil(size / CELL_NUMBER)
        local width = 0
        if height > 1 then
            width = CELL_NUMBER * itemPadding
        else
            width = size % CELL_NUMBER
            width = (width == 0) and CELL_NUMBER or width
            width = width* itemPadding
        end 
        height = height * itemPaddingY

        local scrollViewLayer = UI.Component:create()
        scrollViewLayer:init()
        scrollViewLayer:setLayoutType(UI.LayoutDefaultType.DEFAULT)
        scrollViewLayer:setReflectSize(408, 110)
        scrollViewLayer:computePosition()
        scrollViewLayer:centerUp(170)
        scrollViewLayer:setTouchEnable(true)
        self._bg:addChild(scrollViewLayer)

        -- 遮挡阴影
        local scrollViewMask = UI.Image9:create()
        scrollViewMask:init("ui_setup_banner_mask2.png",{x=250,y=36,width=20,height=20})
        scrollViewMask:setLayoutType(UI.LayoutDefaultType.CENTER)
        scrollViewMask:setReflectSize(452, 36)
        scrollViewMask:computePosition()
        scrollViewMask:centerBottom(-10)
        scrollViewLayer:addChild(scrollViewMask,10)


        local upLayout = scrollViewLayer
        if size > CELL_NUMBER then
            upLayout = UI.TouchLayout:create()
            upLayout:init(0, 0, 0, 0)
            upLayout:setSize(width, height)

            local detailedScrollView = UI.ScrollView:create()
            detailedScrollView:init(0,0,0,0)
            detailedScrollView:setSize(scrollViewLayer._width + 13, scrollViewLayer._height)
            detailedScrollView:leftUp(0, 0)
            detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
            detailedScrollView:addInnerNode(upLayout)
            detailedScrollView:setScrollBarEnabled(true)
            detailedScrollView:setCircleVisible(false);
            detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(0, 0))
            detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
            scrollViewLayer:addChild(detailedScrollView)
        end
        local beginPosX = 4
        local index = 1
        for k, goodData in pairs(self.goodsDataList) do
            goodData:setIsNew(false)
            local goodGrid = UI.GoodsGrid:create()
            goodGrid:init(goodData)
            upLayout:addChild(goodGrid)
            goodGrid:hideFlagIcon()
            goodGrid:showInfoArea(true, false)

            if(size <= CELL_NUMBER) then 
                local startX = beginPosX + (itemPadding * CELL_NUMBER  - itemPadding * size)/2
                local y = math.floor((index - 1) / CELL_NUMBER) * itemPaddingY

                goodGrid:leftUp(startX + (index - 1) * itemPadding, math.floor((index - 1) / CELL_NUMBER) * itemPaddingY)
                table.insert(self.allGridNode, goodGrid)
                index = index + 1
            else 
                local mode = index % CELL_NUMBER
                mode = mode == 0 and CELL_NUMBER or mode
                goodGrid:leftUp((mode - 1) * itemPadding + beginPosX, math.floor((index - 1) / CELL_NUMBER) * itemPaddingY)
                table.insert(self.allGridNode, goodGrid)
                index = index + 1
            end
        end    
    end
end

-- function ExchaneGoodsTips:onTouchBegan(touch, event)
--     print(" ExchaneGoodsTips:onTouchBegan")
--     self.selectIndex = 0
--     local location = touch:getLocation()
--     self.beginTouchPosition = location

--     for k, value in ipairs(self.allGridNode) do
--         if AvalonUtil:isRectContainsPoint(value, location) and value:isVisible() then
--             self.selectIndex = k
--             break
--         end
--     end
-- end

-- function ExchaneGoodsTips:onTouchEnded(touch, event)
--     print(" ExchaneGoodsTips:onTouchEnded")
--     local location = touch:getLocation()
--     if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
--         return
--     end 

--     for k, value in ipairs(self.allGridNode) do
--         if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
--             local pInfoArea = value:onShowInfoAreaHandler(true)
--             if pInfoArea then
--                 local leftX = winSize.width / 2 - self._bg:getContentSize().width / 2 - pInfoArea:getContentSize().width + 66
--                 if(leftX < Avalon.issUtil:getLeftMargin() + 2) then 
--                     leftX = Avalon.issUtil:getLeftMargin() + 2
--                 end
--                 pInfoArea:centerLeft(leftX)
--                 pInfoArea:setZOrder(UI_ZORDER.TIPS)
--             end
--             break
--         end
--     end
-- end
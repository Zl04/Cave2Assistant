-- SpecialEventInfo.lua
-- Author:ydli
-- 2019年2月20日
-- Using:特殊事件奖励界面
local SpecialEventInfo = class("SpecialEventInfo", UI.HWBtnComponent)
UI.SpecialEventInfo = SpecialEventInfo

local winSize = cc.Director:getInstance():getWinSize()
local LayerSize = cc.size(258, 449)
local LanguageManager = require("app.game.LanguageManager")
-- 关卡难度选择资源
local COM_RES_LIST = {
    "ui_town_levelselect.plist"
}

local CELL_NUMBER = 3 --一排显示的道具数量

function SpecialEventInfo:ctor()
    SpecialEventInfo.super.ctor(self, 0, COM_RES_LIST, LayerSize.width, LayerSize.height)
    self:setTouchEnable(true)
    self:registerListener()
end


function SpecialEventInfo:dtor()
    SpecialEventInfo.super.dtor(self)
    self:unRegisterListener()
end

-- public:
-- 初始化
function SpecialEventInfo:init(teamData, goodsDataList)
    SpecialEventInfo.super.init(self)
    self:showLucencyLight()
    self.bg = UI.Image:create()
    self.bg:init("ui_selectfloor_paper.png")
    self.bg:center()
    self:addChild(self.bg)
   
    local laName = UI.Text:create()
    laName:init(teamData.name or teamData.nickName, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    laName:centerUp(20)
    self.bg:addChild(laName, 10)
    
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(250, 370)
    scrollView:init(0, 0, 0, 0)
    scrollView:centerUp(60)
    self.bg:addChild(scrollView)

    self.scrollView = scrollView
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    scrollView:setScrollBarPositionFromCornerForVertical(cc.p(7, 0))

    local infoLayout = UI.TouchLayout:create()
    infoLayout:init()
    infoLayout:setSize(250, 370)
    infoLayout:center()
    infoLayout:addTouchEvents(self)

    local pointList = {}
    local desList = {}
    local layoutHeight = 5
    for i = 1, #teamData.schemeIDs, 1 do
        local data = ConfigManager:getSpecialEventDataById(teamData.schemeIDs[i])
        local picDes = cc.Sprite:createWithSpriteFrameName("ui_selectfloor_hero_diamond.png");
        infoLayout:addChild(picDes,7)
        picDes:setColor(cc.c3b(41, 41, 45))
        table.insert(pointList, picDes)
        local txtDes2 = UI.Text:create()
        txtDes2:init(data.name .. ":".. data.description, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        txtDes2:setLineSpacing(-2)
        txtDes2:setWidth(200)
        infoLayout:addChild(txtDes2, 6)  
        table.insert(desList, txtDes2)      
        layoutHeight = layoutHeight + txtDes2:getContentSize().height + 5  
        -- txtDes2:enableDebugDraw()
        txtDes2:autoAdapt()
    end
    layoutHeight = layoutHeight + 40
    local beginPosX = layoutHeight
    local index = 1
    local itemPadding = 75
    layoutHeight = layoutHeight + math.ceil(table.nums(goodsDataList) / CELL_NUMBER) * itemPadding
    infoLayout:setSize(226, layoutHeight)

    local height = 5
    for k, v in ipairs(desList) do
        local point = pointList[k]
        point:setPosition(20, infoLayout:getContentSize().height - height - 10)
        v:leftUp(28, height)
        height = height + v:getContentSize().height + 5
    end

     local rewardTip = UI.Text:create()
    rewardTip:init(LanguageManager:getInstance():getLocalString(1111346), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    rewardTip:centerUp(height + 2)
    infoLayout:addChild(rewardTip, 10)

    local lineWidth = (infoLayout:getContentSize().width - rewardTip:getContentSize().width - 40) / 2
    local lineL = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineL:setContentSize(lineWidth, 2)
    lineL:setAnchorPoint(0, 0)
    lineL:setPosition(5, layoutHeight - height - 18)
    infoLayout:addChild(lineL,10)

    local lineR = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineR:setContentSize(lineWidth, 2)
    lineR:setAnchorPoint(0, 0)
    lineR:setPosition(infoLayout:getContentSize().width - lineWidth - 5, layoutHeight - height - 18)
    infoLayout:addChild(lineR, 10)

    local goodsFullDataList = {}
    for k, id in pairs(goodsDataList) do
        local goodData = GoodsDataManager:createLocalGoodsData(id)
        if (goodData) then
            goodData:setIsNew(false)
            table.insert(goodsFullDataList, goodData)
        end
    end
    goodsFullDataList = self:removeDuplicates(goodsFullDataList)
    --[[排序规则 1:武器在前 2：品质最高到底 ]]
    table.sort(goodsFullDataList, function( a, b )
        if a.goodsRare == b.goodsRare then
            return a:getGoodsType() < b:getGoodsType()
        else 
            return a.goodsRare > b.goodsRare
        end
    end)

    self.allGridNode = {}
    for k, goodData in pairs(goodsFullDataList) do
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        infoLayout:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        goodGrid:setInfoArea(true, false)
        local mode = index % CELL_NUMBER
        mode = mode == 0 and CELL_NUMBER or mode
        goodGrid:leftUp((mode - 1) * itemPadding + 15, beginPosX + math.floor((index - 1) / CELL_NUMBER) * itemPadding)
        table.insert(self.allGridNode, goodGrid)
        index = index + 1
    end 
    
    scrollView:addInnerNode(infoLayout)
end

--去重
function SpecialEventInfo:removeDuplicates(targetList)
    local temp = {}
    for k, v in ipairs(targetList) do
        local isHave = false
        for k2, v2 in ipairs(temp) do
            if v2:getGoodsID() == v:getGoodsID() then
                isHave = true
                break
            end
        end
        if not isHave then
            table.insert(temp, v) 
        end
    end
    return temp
end


function SpecialEventInfo:onUpdateView()
    SpecialEventInfo.super.onUpdateView(self)
end

function SpecialEventInfo:onTouchBegan(touch, event)
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

function SpecialEventInfo:onTouchEnded(touch, event)
    local location = touch:getLocation()

    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    if not self.scrollView:checkTouch(touch) then
        return
    end

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            local pInfoArea = value:onShowInfoAreaHandler(true)
            if pInfoArea then
                pInfoArea:centerLeft(winSize.width / 2 + 262)
                if pInfoArea:getZOrder() <= self:getZOrder() then
                    pInfoArea:setZOrder(self:getZOrder() + 1)
                end
            end
            self.pInfoArea = pInfoArea
            break
        end
    end
end

function SpecialEventInfo:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end

function SpecialEventInfo:unRegisterListener()
end


-- 点击外部区域的处理器(关闭)(可选)
function SpecialEventInfo:onTouchDialogOutsizeHandler()
    print("---onTouchDialogOutsizeHandler-----")
    if self.callback then
        self.callback()
    end
    self:close()
end

function SpecialEventInfo:removeInfoArea()
    if self.pInfoArea and not tolua.isnull(self.pInfoArea) then
        self.pInfoArea:removeFromParent()
    end
end

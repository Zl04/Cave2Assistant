-- DungeonRankRewardCell.lua
-- Author:ydli
-- 2018年3月27日
-- Using:大秘境赛季奖励 cell

UI = UI or {}
local DungeonRankRewardCell = class("DungeonRankRewardCell", UI.HWBtnComponent)
UI.DungeonRankRewardCell = DungeonRankRewardCell


local COM_RES_LIST = {
}

function DungeonRankRewardCell:ctor(data, width, height, tableView)
    DungeonRankRewardCell.super.ctor(
        self, 0,
        COM_RES_LIST,
        width,
        height
    )
    self.width = width
    self.height = height
    self.data = data
    self.tableView = tableView
    self.rewardItems = {}
    self:init()
    self:registerListener()
end

function DungeonRankRewardCell:dtor()
    DungeonRankRewardCell.super.dtor(self)
    -- self:setInterceptTouches(false)
    self.data = nil
    self.tableView = nil
    self.rewardItems = {}
    self:unRegisterListener()
end

-- public:
-- 初始化
function DungeonRankRewardCell:init()
    DungeonRankRewardCell.super.init(self)
end

-- 模版函数：初始化组建的视图
function DungeonRankRewardCell:onInitView()  
    if self.data.type == DR_REWARD_CELL_TYPE.LOW then

        -- 分割线
        local splitter = UI.Image9:create()
        splitter:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(666, 1))
        splitter:centerUp(0)
        self:addChild(splitter)
    else
        local colorImage = UI.Image:create()
        local filename = string.format("ui_dungeon_picture%d.png", self.data.bgImageId)
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrame(filename)
        if frame ~= nil then
            colorImage:init(filename)
            colorImage:leftUp(0, 0)
            colorImage:setSize(720, 164)
            self:addChild(colorImage)
        end
    end
    self:createRankTitle()
    self:createRankReward()
end

function DungeonRankRewardCell:createRankTitle()
    local rankLabel = nil
    if self.data.rankIconId >= 1 and self.data.rankIconId <= 3 then
        rankLabel = self:createTop3RankTitle()
    else
        rankLabel = self:createNormalRankTitle()
    end
    if rankLabel ~= nil then
        if self.data.rankDownLimit == self.data.rankUpLimit then
            rankLabel:setText(string.format("%d", self.data.rankDownLimit))
        elseif self.data.rankUpLimit > 2100000000 then--上限设置 大于 21 亿
            rankLabel:setText(string.format("%d+",  self.data.rankDownLimit))
        else
            rankLabel:setText(string.format("%d~%d",  self.data.rankDownLimit, self.data.rankUpLimit))
        end
    end
end

function DungeonRankRewardCell:createTop3RankTitle(rank)
    local imagename = string.format("ui_dungeon_icon_medal_0%d.png", self.data.rankIconId)
    local rankTitleBg = UI.Image:create()
    rankTitleBg:init(imagename)
    rankTitleBg:leftUp(36, 18)
    self:addChild(rankTitleBg)
    return nil
end

function DungeonRankRewardCell:createNormalRankTitle()
    local rankLabel = nil
    if self.data.rankIconId == 5 then
        -- 奖杯图标
        local rankIcon = UI.Image:create()
        rankIcon:init("ui_dungeon_icon_trophy2.png")
        rankIcon:leftUp(24, 23)
        self:addChild(rankIcon, 1)

        -- 排名文字背景
        local rankTitleBg = UI.Image:create()
        rankTitleBg:init("ui_dungeon_medal_02.png")
        rankTitleBg:leftUp(40, 33)
        self:addChild(rankTitleBg)

        -- 排名文字
        rankLabel = UI.Text:create()
        rankLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
        rankLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -2))
        rankLabel:centerLeft(42)
        rankTitleBg:addChild(rankLabel)
    elseif self.data.rankIconId == 4 then
        -- 奖杯图标
        local rankIcon = UI.Image:create()
        rankIcon:init("ui_dungeon_icon_trophy1.png")
        rankIcon:leftUp(12, 11)
        self:addChild(rankIcon, 1)

        -- 排名文字背景
        local rankTitleBg = UI.Image:create()
        rankTitleBg:init("ui_dungeon_medal_01.png")
        rankTitleBg:leftUp(40, 22)
        self:addChild(rankTitleBg)
        
        -- 排名文字
        rankLabel = UI.Text:create()
        rankLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_248_201_95)
        rankLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -2))
        rankLabel:centerLeft(42)
        rankTitleBg:addChild(rankLabel)
    end
    return rankLabel
end


function DungeonRankRewardCell:createRankReward()
    if self.data.type == DR_REWARD_CELL_TYPE.LOW then
        self:createNormalRankReward()
    else
        self:createSpecialRankReward()
    end
end

--奖励内容  只有 一排
function DungeonRankRewardCell:createNormalRankReward()
    local rewards = self.data.rewards
    local itemPadding = 75
    local size = #rewards
    local rewardLayout = UI.TouchLayout:create()
    rewardLayout:init(0, 0, 0, 0)
    rewardLayout:setSize(itemPadding * size, 82)
    rewardLayout:addTouchEvents(self)
    local showFromRight = true
    if size <= 5 then 
        rewardLayout:rightUp(25, 5)
        showFromRight = true
        self:addChild(rewardLayout)
    else --滑动展示
        rewardLayout:center()
        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(440, 82)
        detailedScrollView:rightUp(25, 5)
        detailedScrollView:setScrollType(UI.ScrollType.HORIZONTAL)
        detailedScrollView:addInnerNode(rewardLayout)
        showFromRight = false
        self:addChild(detailedScrollView)
        self.detailedScrollView = detailedScrollView
    end
    local beginPosX = 0
    for i = 1, size do
        local goodData = rewards[i]
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        -- goodGrid:showInfoArea(true, false)
        goodGrid:setInfoArea(true, false)
        if showFromRight then
            goodGrid:centerRight(beginPosX)
        else
            goodGrid:centerLeft(beginPosX)
        end
        beginPosX = beginPosX + itemPadding
        rewardLayout:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        goodGrid:hideBG()
        table.insert(self.rewardItems, goodGrid)
    end
end

--奖励内容  有 两排
function DungeonRankRewardCell:createSpecialRankReward()
    printInfo("DungeonRankRewardCell:createSpecialRankReward, 创建大板块的奖励列表", size)
    local rewards = self.data.rewards
    local itemPadding = 75
    local size = #rewards
    local rewardLayout = UI.TouchLayout:create()
    rewardLayout:init(0, 0, 0, 0)
    rewardLayout:addTouchEvents(self)
    local isSingleRow = true
    if size <= 4 then 
        rewardLayout:setSize(itemPadding * size, 82)
        rewardLayout:rightUp(25, 5)
        self:addChild(rewardLayout)
        isSingleRow = true
    elseif size <= 8 then 
        rewardLayout:setSize(320, 150)
        rewardLayout:rightUp(25, 5)
        self:addChild(rewardLayout)
        isSingleRow = false
    else --滑动展示
        rewardLayout:center()
        rewardLayout:setSize(math.ceil(size / 2) * itemPadding, 150)
        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(320, 150)
        detailedScrollView:rightUp(25, 5)
        detailedScrollView:setScrollType(UI.ScrollType.HORIZONTAL)
        detailedScrollView:addInnerNode(rewardLayout)
        self:addChild(detailedScrollView)
        self.detailedScrollView = detailedScrollView
        isSingleRow = false
    end
    local beginPosX = 0
    local beginPosY = 0
    local widthNumber = math.ceil(size / 2)
    for i = 1, size do
        local goodData = rewards[i]
        local goodGrid = UI.GoodsGrid:create()
        goodGrid:init(goodData)
        -- goodGrid:showInfoArea(true, false)
        goodGrid:setInfoArea(true, false)
        if isSingleRow then
            goodGrid:centerRight(beginPosX)
            beginPosX = beginPosX + itemPadding
        else
            if self.detailedScrollView then
                goodGrid:leftUp(beginPosX + itemPadding * ((i - 1) % widthNumber), beginPosY + itemPadding * math.floor((i - 1)/ widthNumber) - 7)
            else
                goodGrid:rightUp(beginPosX + itemPadding * ((i - 1) % widthNumber), beginPosY + itemPadding * math.floor((i - 1)/ widthNumber) - 7)
            end
        end
        rewardLayout:addChild(goodGrid)
        goodGrid:hideFlagIcon()
        goodGrid:hideBG()
        table.insert(self.rewardItems, goodGrid)
    end
end

-- 模版函数：更新组建的视图
function DungeonRankRewardCell:onUpdateView()
    if self.detailedScrollView then
        self.detailedScrollView:scrollToLeft()
    end
end

function DungeonRankRewardCell:reload(data)
   
end



-- 注册监听事件(可选)
function DungeonRankRewardCell:registerListener()
end

-- 注销监听事件(可选)
function DungeonRankRewardCell:unRegisterListener()
end


function DungeonRankRewardCell:isClipping(touchPoint)
    local clippingRect = self.parentLayer:getClippingRect()
    if clippingRect ~= nil and cc.rectContainsPoint(clippingRect, touchPoint) then
        return false
    end
    return true
end





function DungeonRankRewardCell:jumpClick(touchPosition)
    if self:isClipping(touchPosition) then
        return
    end
    local url = self.data.hrefUrl
    if url == nil or url == "" then
        return false
    end
    local isOk = GameManager:openUrl(url, function(isClose)
        if isClose and self.parentLayer ~= nil then
            self.parentLayer:closeCallback()
        end
    end)
end

function DungeonRankRewardCell:onTouchBegan(touch, event)
    --活动距离判断
    --裁剪判断
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    --检查是否在可点击区域 
    if not AvalonUtil:isRectContainsPoint(self.tableView, location) then
        return
    end  

    --检查是否在可点击区域 奖励滑动区域
    if self.detailedScrollView ~= nil and not AvalonUtil:isRectContainsPoint(self.detailedScrollView, location) then
        return
    end 

    for k, value in ipairs(self.rewardItems) do
        if AvalonUtil:isRectContainsPoint(value, location) then
            self.selectIndex = k
            break
        end
    end
end

function DungeonRankRewardCell:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 
   
    if not AvalonUtil:isRectContainsPoint(self.tableView, location) then
        return
    end 

    --检查是否在可点击区域 奖励滑动区域
    if self.detailedScrollView ~= nil and not AvalonUtil:isRectContainsPoint(self.detailedScrollView, location) then
        return
    end 

    for k, value in ipairs(self.rewardItems) do
       if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
            value:onShowInfoAreaHandler(true)
            break
        end
    end
end

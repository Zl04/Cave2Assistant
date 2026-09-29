-- SevenDaysCloseCell.lua
-- Author:lzm
-- 2019年8月19日
-- Using:七日计划cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local SevenDaysCloseCell = class("SevenDaysCloseCell", UI.ListGrid)
UI.SevenDaysCloseCell = SevenDaysCloseCell

local COM_WIDTH = 196
local COM_HEIGHT = 420

--构造函数(必备)
function SevenDaysCloseCell:ctor(viewType)
    self._viewType = viewType
    SevenDaysCloseCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function SevenDaysCloseCell:dtor()
    SevenDaysCloseCell.super.dtor(self)
end

-- 初始化(必备)
function SevenDaysCloseCell:init(data)
    self._data = data
    SevenDaysCloseCell.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function SevenDaysCloseCell:onInitView()
end

function SevenDaysCloseCell:getData()
    return self._data;
end

function SevenDaysCloseCell:isClickShowInfo()
    return true
end

function SevenDaysCloseCell:onUpdateView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    -- cellLayout:enableDebugDraw()
    self:addChild(cellLayout)

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_sevendays_paper_morrow_plan.png")
    bg:centerUp(0)
    cellLayout:addChild(bg)

    local goalData = mvc.sevenDaysModel:getGoalData(self._viewType)
    local titleText = self._data.nameLocal or "Loading..."
    if self._data.ID == goalData.curStage then
        titleText = UI.TEXT_1213090
    elseif self._data.ID == goalData.curStage+1 then
        titleText = UI.TEXT_1213092
    end

    local dayText  = UI.Text:create()
    dayText:init(titleText, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    dayText:centerUp(4);
    bg:addChild(dayText)

    local bgLayout = UI.Layout:create()
    bgLayout:init()
    bgLayout:setSize(188, 152)
    bgLayout:centerUp(60)
    cellLayout:addChild(bgLayout)

    local bg2 = UI.Image:create()
    bg2:init("ui_guild_giftbag_bg.png")
    bg2:setScale(0.6)
    bg2:center()
    bgLayout:addChild(bg2)

    local rewardID = self._data.stageReward.id
    local rewardNum = self._data.stageReward.num
    local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)

    local descText1  = UI.Text:create()
    descText1:init(goodsData:getName(), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    descText1:centerUp(210)
    descText1:setTextHorizontalCenter()
    descText1:autoAdapt()
    descText1:setWidth(170)
    bg:addChild(descText1)

    local descText2  = UI.Text:create()
    descText2:init(goodsData:getDescription(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    descText2:centerUp(236)
    descText2:setTextCenter()
    -- descText2:setSize(190, 60)
    descText2:setSize(170, 70)
    bg:addChild(descText2)

    local descText3  = UI.Text:create()
    descText3:init(UI.TEXT_1213112, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    descText3:centerBottom(30)
    bg:addChild(descText3)

    -- 物品物品图标
    local innerLayout = UI.Layout:create()
    innerLayout:init()
    innerLayout:setSize(60, 60)
    innerLayout:centerUp(40)
    bgLayout:addChild(innerLayout)

    goodsData:setNum(rewardNum)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false

    local goodsGrid = UI.GoodsGrid:create()
    -- goodsGrid:setScale(0.8)
    goodsGrid:center()
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    if (rewardNum == 0) then
        goodsGrid:hideCountLabel()
    end
    innerLayout:addChild(goodsGrid)
end

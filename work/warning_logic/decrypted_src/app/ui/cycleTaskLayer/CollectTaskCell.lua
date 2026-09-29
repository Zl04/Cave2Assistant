-- CollectTaskCell.lua
-- Author:zp
-- 2018年12月31日
-- Using:运营活动cell

require ("app.ui.activity.ActivityDetailNode")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local CollectTaskCell = class("CollectTaskCell",UI.TableViewCell)
UI.CollectTaskCell = CollectTaskCell

function CollectTaskCell:ctor()
    self:setContentSize(cc.size(280, 88))
    self._goodsData = nil
end

function CollectTaskCell:onEnter()
    CollectTaskCell.super.onEnter(self)
    
end

function CollectTaskCell:onExit()
    CollectTaskCell.super.onExit(self)
end

function CollectTaskCell:dtor()
    CollectTaskCell.super.dtor(self)
end

function CollectTaskCell:init(data)
    self._data = data
    if(data) then 
        self._goodsData = GoodsDataManager:createLocalGoodsData(data.goodsID)
    end

    self:onInitView()
end

function CollectTaskCell:onInitView()
    local iconBg = UI.Image:create()
    iconBg:init("ui_upgrade_box.png")
    iconBg:centerLeft(2)
    self:addChild(iconBg)
    self._iconBg = iconBg

    -- self._countLabel = UI.Text:create()
    -- self._countLabel:init(
    --     "", 
    --     UI.FONT_BOLD, 
    --     UI.FONT_SIZE_14PX, 
    --     UI.FONT_COLOR_227_214_172
    -- )
    -- self._countLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
    -- self._countLabel:rightBottom(9, 6)
    -- icon:addChild(self._countLabel)

    local titleBg = UI.Image:create()
    titleBg:init("ui_upgrade_bg.png")
    titleBg:leftUp(88, 9)
    self:addChild(titleBg)

    local titleTxt = UI.Text:create()
    titleTxt:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    titleTxt:center()
    titleBg:addChild(titleTxt)
    self.titleTxt = titleTxt

    -- 进度文本
    local progressTxt = UI.Text:create()
    progressTxt:init("00", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    progressTxt:rightBottom(8, 28 - progressTxt:getContentSize().height /2)
    self:addChild(progressTxt)
    self.progressTxt = progressTxt

    local progressBg = UI.Image:create()
    progressBg:init("ui_upgrade_ash.png")
    progressBg:leftBottom(88, 10)
    self:addChild(progressBg)

    local percent = 0
    local progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_upgrade_yellow.png"))
    progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    progress:setMidpoint(cc.p(0, 0))
    progress:setBarChangeRate(cc.p(1, 0))
    progress:setPercentage(percent)
    progress:setPosition(95.5, 3)
    progressBg:addChild(progress)
    self.progress = progress

    self:refreshView()
end

function CollectTaskCell:onUpdateView(data)
    if(data) then 
        self._data = data
        self._goodsData = GoodsDataManager:createLocalGoodsData(data.goodsID)
        self:refreshView()
    end
end

function CollectTaskCell:refreshView()
    if(self._goodsData) then 
        self.titleTxt:setText(self._goodsData:getName())

        if(not tolua.isnull(self._goodsGrid)) then 
            self._goodsGrid:removeFromParent()
            self._goodsGrid = nil
        end
        self._goodsData:setIsNew(false)
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:center()
        goodsGrid:init(self._goodsData)
        goodsGrid:centerLeft(2.5)
        goodsGrid:showInfoArea(true, false)
        self:addChild(goodsGrid)
        self._goodsGrid = goodsGrid
        goodsGrid:hideBG()
        goodsGrid:hideNewIcon()
        goodsGrid:hideCountLabel()
        if(self._data.collectNum == 0) then 
            goodsGrid:setIsGray()
        end

        local percent = 100
        local reachNum = self._data.reachNum + self._data.collectNum
        local goodsNum = self._data.goodsNum
        if(goodsNum >0) then 
            percent = reachNum * 100/goodsNum
        end

        self.progressTxt:setText(string.format("%s/%s", reachNum, goodsNum))
        self.progress:setPercentage(percent)
        if(percent >=100) then 
            self.progressTxt:setFontColor(UI.FONT_COLOR_36_181_118)
        else
            self.progressTxt:setFontColor(UI.FONT_COLOR_80_5_5)
        end 
    end
end
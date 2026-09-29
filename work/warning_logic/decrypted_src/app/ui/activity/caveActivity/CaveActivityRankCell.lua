-- CaveActivityRankCell.lua
-- Author:zp
-- 2019年1月9日
-- Using:排行榜的表现cell

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local CaveActivityRankCell = class("CaveActivityRankCell",UI.TableViewCell)
UI.CaveActivityRankCell = CaveActivityRankCell

function CaveActivityRankCell:ctor()
    self:setContentSize(cc.size(590, 89))
    self._goodsData = nil
    self.hideLine = false
end

function CaveActivityRankCell:onEnter()
    CaveActivityRankCell.super.onEnter(self)
    
end

function CaveActivityRankCell:onExit()
    CaveActivityRankCell.super.onExit(self)
end

function CaveActivityRankCell:dtor()
    CaveActivityRankCell.super.dtor(self)
end

function CaveActivityRankCell:init(data, listView)
    self._data = data
    self.listView = listView

    self:onInitView()
end

function CaveActivityRankCell:onInitView()
    local rankImage = UI.Image:create()
    rankImage:init("ui_rankinglist_silver.png")
    rankImage:centerLeft(85 - rankImage:getContentSize().width/2)
    self:addChild(rankImage)
    self._rankImage = rankImage

    local rankZoneImage = UI.Image:create()
    rankZoneImage:init("ui_activity_medal.png")
    rankZoneImage:centerLeft(85 - rankZoneImage:getContentSize().width/2)
    self:addChild(rankZoneImage)
    self._rankZoneImage = rankZoneImage

    local rankText = UI.Text:create()
    rankText:init(UI.TEXT_1212086, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    rankText:centerBottom(20 - rankText:getContentSize().height/2)
    -- rankText:leftBottom(71 + 10 - rankText:getContentSize().width /2, 20 - rankText:getContentSize().height/2)
    rankZoneImage:addChild(rankText)
    self._rankText = rankText

    local rewardLayout = UI.Layout:create()
    rewardLayout:init()
    rewardLayout:centerRight(10)
    rewardLayout:setSize(390, 0)
    self:addChild(rewardLayout)
    self._rewardLayout = rewardLayout

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(586, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(293, 1))
    self:addChild(lineUpImage)

    self:refreView()
end

function CaveActivityRankCell:sethideLine()
    self.hideLine = true
end

function CaveActivityRankCell:reloadData(data) 
    if(data) then 
        self._data = data
        self:refreView()
    end 
end

function CaveActivityRankCell:refreView()
    local rankStart = -1
    local randEnd= -1
    if(self._data == nil) then 
        return 
    end

    if(self._data) then 
        rankStart = self._data.rankStart
        randEnd= self._data.randEnd
        -- rankStart = 1000
        -- randEnd= 1000
    end
    if(rankStart == randEnd and rankStart < 4) then 
        self._rankZoneImage:hide()
        self._rankText:hide()
        self._rankImage:show()

        local spriteName = "ui_rankinglist_gold.png"
        if(rankStart == 1) then 
            spriteName = "ui_rankinglist_gold.png"
        elseif (rankStart == 2) then 
            spriteName = "ui_rankinglist_silver.png"
        elseif (rankStart == 3) then 
            spriteName = "ui_rankinglist_copper.png"
        end

        self._rankImage:setSpriteName(spriteName)
    else 
        self._rankImage:hide()
        self._rankZoneImage:show()
        self._rankText:show()
        if(rankStart ~= randEnd) then 
            self._rankText:setText(string.format("%s-%s", rankStart, randEnd))
        else 
            self._rankText:setText(string.format("%s", rankStart))
        end
    end

    if(not tolua.isnull(self._rewardLayout)) then 
        self._rewardLayout:removeAllChildren(false)
    end

    local rewards = self._data.rewards
    local startRightX = 0
    local oneWidth = 78
    startRightX = startRightX + 2.5 * oneWidth - #rewards/2 * oneWidth
    for i=1,#rewards do
        if(i > 5) then 
            break
        end
        local reward = rewards[i]
        if(reward) then
            local goodsData = GoodsDataManager:createLocalGoodsData(reward.id)
            if(goodsData) then
                goodsData:setNum(reward.num)
                goodsData:setIsNew(false)

                local goodsGrid = UI.GoodsGrid:create()
                goodsGrid:setTouchClipNode(self.listView)
                goodsGrid:rightUp(startRightX + oneWidth*(i-1), - goodsGrid:getContentSize().height/2)
                goodsGrid:init(goodsData)
                goodsGrid:showInfoArea(true, false)
                self._rewardLayout:addChild(goodsGrid)
            end
        else
            break
        end 
    end

end

function CaveActivityRankCell:onUpdateView(data)
    
end

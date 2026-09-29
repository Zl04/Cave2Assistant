------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/10/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local LostRealmRewardCell = class("LostRealmRewardCell", UI.HWBtnComponent)
UI.LostRealmRewardCell = LostRealmRewardCell

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 604
local COM_HEIGHT = 112

function LostRealmRewardCell:ctor()
    LostRealmRewardCell.super.ctor(
    	self,
    	UI.Type.NORMAL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
end

function LostRealmRewardCell:init( ... )
    LostRealmRewardCell.super.init(self, ... )
end

function LostRealmRewardCell:dtor()
    LostRealmRewardCell.super.dtor(self)
    
    reload_script_file("app.ui.cave.LostRealmRewardCell")
end

function LostRealmRewardCell:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_monopoly_list_1.png")
    bg:center()
    self:addChild(bg)
    self.bg = bg 

    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(192, 102)
    leftLayout:centerLeft(0)
    bg:addChild(leftLayout)

    local levelTitleText = UI.Text:create()
    levelTitleText:init("23", UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    levelTitleText:setWidth(102)
    levelTitleText:autoAdapt()
    levelTitleText:setTextCenter()
    levelTitleText:center()
    -- levelTitleText:enableDebugDraw()
    leftLayout:addChild(levelTitleText)
    self.choiceLevelText = levelTitleText

    -- 领取标志
    local rewardBg = UI.Image:create()
    rewardBg:init("ui_information_banner_receive.png")
    -- rewardBg:setScale(0.7)
    rewardBg:centerRight(26)
    bg:addChild(rewardBg, 3)
    rewardBg:setVisible(false)
    self.rewardBg = rewardBg

    local text = UI.Text:create()  
    text:init(UI.TEXT_1110721, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_15_85_71)
    text:center()
    text:setRotationSkewX(-9.0)
    text:setRotationSkewY(-9.0)
    rewardBg:addChild(text)
end

function LostRealmRewardCell:onUpdateView()

end

function LostRealmRewardCell:updateData(data, nowLevel)
    -- print("nowLevel=", data.ID, nowLevel, caveMode, ToolsUtil:getShopLevelForCaveLevel(level))
    if data and data.ID == nowLevel then 
        self.bg:setSpriteName("ui_monopoly_list_1.png")
        self.choiceLevelText:setFontColor(UI.FONT_COLOR_41_41_45)
    else
        self.bg:setSpriteName("ui_monopoly_list_2.png")
        self.choiceLevelText:setFontColor(UI.FONT_COLOR_77_77_84)
    end

    self.choiceLevelText:setText(string.format(LanguageManager:getInstance():getLocalString(1113913), data.ID))

    local lostRealmData = mvc.festivalModel:getLostRealmData()
    if(lostRealmData and lostRealmData.claimedCycleReward and lostRealmData.claimedCycleReward[data.ID]) then
        self.rewardBg:setVisible(true)
    else
        self.rewardBg:setVisible(false)
    end

    if (data) then
        local rewardNode = self.bg:getChildByName("RewardNode")
        if rewardNode then
            rewardNode:removeFromParent(true)
        end
        data.circleRewardArr = nil
        if(data.circleRewardArr == nil) then
            data.circleRewardArr = {}
            local strArr = string.split(data.CircleRewards, ";")
            -- local strArr = string.split("20010021,50;20010030,100;20010040,20;20010041,32;20010050,121;20010051,232",";")
            for k, v in ipairs(strArr) do 
                local goodsArr = string.split(v, ",")
                if(#goodsArr == 2) then
                    local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(goodsArr[1]))
                    goodsData:setIsNew(false)
                    goodsData:setNum(tonumber(goodsArr[2]))

                    table.insert(data.circleRewardArr, goodsData)
                end
            end
        end
        local circleRewardArr = data.circleRewardArr
        if(#circleRewardArr > 5) then
            local rewardNode = UI.RewardPreViewUtil:create()
            rewardNode:setTouchClipNode(self.touchClipNode)
            rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
            rewardNode:init(circleRewardArr, 4.5, 1, UI.ScrollType.HORIZONTAL, cc.size(0, 0), true, cc.size(-4, 0), false)
            rewardNode:centerLeft(214)
            rewardNode:showGoodsView()
            rewardNode:setName("RewardNode")
            self.bg:addChild(rewardNode)
        else
            local rightLayout = UI.Layout:create()
            rightLayout:init()
            rightLayout:centerLeft(214)

            local startX = 0
            local oneWidth = 80
            for k,goodsData in ipairs(circleRewardArr) do 
                local goodGrid = UI.GoodsGrid:create()
                goodGrid:init(goodsData)
                goodGrid:centerLeft(startX + oneWidth*(k-1))
                goodGrid:hideFlagIcon()
                goodGrid:showInfoArea(true, false)
                rightLayout:addChild(goodGrid)
                goodGrid:setName("cellView")
                goodGrid:updateView()
                goodGrid:setTouchClipNode(self.touchClipNode)
                goodGrid:setSwallowTouches(false)
                -- goodGrid:enableDebugDraw()
            end
            
            rightLayout:setName("RewardNode")
            self.bg:addChild(rightLayout)
        end
    end
end
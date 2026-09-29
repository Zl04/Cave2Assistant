------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/10/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local GhostabyssChoiceLevelCell = class("GhostabyssChoiceLevelCell", UI.HWBtnComponent)
UI.GhostabyssChoiceLevelCell = GhostabyssChoiceLevelCell

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 553
local COM_HEIGHT = 104

function GhostabyssChoiceLevelCell:ctor()
    GhostabyssChoiceLevelCell.super.ctor(
    	self,
    	UI.Type.NORMAL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
end

function GhostabyssChoiceLevelCell:init( ... )
    GhostabyssChoiceLevelCell.super.init(self, ... )
end

function GhostabyssChoiceLevelCell:dtor()
    GhostabyssChoiceLevelCell.super.dtor(self)
    reload_script_file("app.modules.cave.GhostabyssChoiceLevelCell")
end

function GhostabyssChoiceLevelCell:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_ghostabyss_list_01.png")
    bg:center()
    self:addChild(bg)
    self.bg = bg 

    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(173, 130)
    leftLayout:centerLeft(0)
    bg:addChild(leftLayout)

    local levelTitleText = UI.Text:create()
    levelTitleText:init("1", UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    levelTitleText:centerLeft(42)
    bg:addChild(levelTitleText)
    self.levelTitleText = levelTitleText

    local centerLayout = UI.Layout:create()
    centerLayout:init()
    centerLayout:setSize(0,0)
    centerLayout:centerLeft(180)
    bg:addChild(centerLayout)

    local recommendText = UI.Text:create()
    recommendText:init(UI.TEXT_1328004, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=109,g=101,b=96})
    recommendText:centerUp(-40)
    centerLayout:addChild(recommendText)

    local levelText = UI.Text:create()
    levelText:init("", UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    levelText:centerBottom(-40)
    centerLayout:addChild(levelText)
    self.levelText = levelText

    -- 奖励物品蒙层
    local cellMaskImage = UI.Image:create()
    cellMaskImage:init("ui_ghostabyss_up_03.png")
    cellMaskImage:rightBottom(10,4)
    self:addChild(cellMaskImage, 10)
    self.cellMaskImage = cellMaskImage
    

    -- 没有解锁的表现
    local halfBg = UI.Image9:create()
    halfBg:init("ui_ghostabyss_up_02.png", CCRectMake(2,2,1,1), cc.size(COM_WIDTH, COM_HEIGHT))
    halfBg:center()
    self:addChild(halfBg, 100)
    self.halfBg = halfBg

    local lockNoticeText = UI.Text:create()
    lockNoticeText:init("", UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 203, g = 216, b = 217})
    lockNoticeText:center()
    -- lockNoticeText:setOutline()
    halfBg:addChild(lockNoticeText)
    self.lockNoticeText = lockNoticeText
    lockNoticeText:setVisible(false)
end

function GhostabyssChoiceLevelCell:onUpdateView()
    
end

function GhostabyssChoiceLevelCell:getID()
    if(self.data ~= nil and self.groupID ~= nil) then
        if(self.data.unlockProgress <= self.groupID) then 
            return self.data.ID
        end
    end

    return 0
end

function GhostabyssChoiceLevelCell:enableToChoice()
    if(self.data ~= nil and self.groupID ~= nil) then
        if(self.data.unlockProgress <= self.groupID) then 
            return true
        end
    end

    return false
end

function GhostabyssChoiceLevelCell:updateData(data, heroLevel, groupID)
    self.data = data
    self.heroLevel = heroLevel
    self.groupID = groupID
    
    if (data) then
        self.lockNoticeText:setText(data.unlockdes)
        local opacity = 255
        if(data.unlockProgress <= groupID) then 
            self.halfBg:setVisible(false)
            self.lockNoticeText:setVisible(false)
            self.bg:setOpacity(255)
        else
            self.halfBg:setVisible(true)
            self.lockNoticeText:setVisible(true)
            self.bg:setOpacity(128)
            opacity = 128
        end

        self.levelTitleText:setText(string.format(UI.TEXT_110001, data.ID))

        local level, reinLv = RoleDataManager:getUIShowLvByItemData(data.recommendedLevel)
        local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
        self.levelText:setText(showLv)
        if(heroLevel < data.recommendedLevel) then 
            self.levelText:setFontColor({r=168,g=17,b=17})
        else
            self.levelText:setFontColor(UI.FONT_COLOR_41_41_45)
        end

        local rewardNode = self:getChildByName("RewardNode")
        if rewardNode then
            rewardNode:removeFromParent(true)
        end
        local winSize = cc.Director:getInstance():getWinSize()
        local rewardNode = UI.RewardPreViewUtil:create()
        rewardNode:setTouchClipNode(self.touchClipNode)
        rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
        rewardNode:init(nil, 3.5, 1, UI.ScrollType.HORIZONTAL, cc.size(0, 0), true, cc.size(-4, 0), false)
        rewardNode:centerRight(22)
        local rewardData = data.showReward
        for k, v in pairs(rewardData) do
            rewardNode:addGoodsId(tonumber(v), 0)
        end
        rewardNode:setOpacity(opacity)
        rewardNode:showGoodsView()
        rewardNode:setName("RewardNode")
        self:addChild(rewardNode)
    end
end
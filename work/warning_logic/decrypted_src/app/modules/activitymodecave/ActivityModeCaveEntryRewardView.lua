------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/09
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveEntryRewardView = class("ActivityModeCaveEntryRewardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_trial.plist"
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 1136
local COM_HEIGHT = 282

function ActivityModeCaveEntryRewardView:ctor(data)
    ActivityModeCaveEntryRewardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        winSize.width,
        winSize.height
    )
    self.data = data
    self:bindModel()
end

function ActivityModeCaveEntryRewardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecave", "ActivityModeCave", false)
    ActivityModeCaveEntryRewardView.super.init(self, ... )
end

function ActivityModeCaveEntryRewardView:dtor()
    ActivityModeCaveEntryRewardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecave.ActivityModeCaveEntryRewardView")
end


function ActivityModeCaveEntryRewardView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)
    
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- light
    local light = UI.Animation:create()
    light:init("effect_ui_starmap_show_guang.json", "effect_ui_starmap_show_guang.atlas", 1)
    light:setAnimation("idle", true)
    light:center(0, -150)
    contentLayout:addChild(light)

    local flag = UI.Animation:create()
    flag:init("effect_ui_town_clearance_reward.json", "effect_ui_town_clearance_reward.atlas", 1)
    flag:setAnimation("idle", true)
    flag:center(0, -155)
    contentLayout:addChild(flag, 199)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_trial_ranking_bg3.png")
    bg:center()
    contentLayout:addChild(bg)

    local line  = UI.Image:create()
    line:init("ui_trial_ranking_line3.png")
    line:centerUp(45)
    contentLayout:addChild(line)

    local title = UI.Text:create()
    title:init(UI.TEXT_223403, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_255_224_115)
    title:centerUp(35)
    contentLayout:addChild(title, 299)

    local textOffsetX = 65
    local textOffsetY = 1
    local scoreBg  = UI.Image:create()
    scoreBg:init("ui_trial_ranking_entry_5.png")
    scoreBg:leftBottom(200, -70)
    contentLayout:addChild(scoreBg)

    local scoreDes = UI.Text:create()
    scoreDes:init(UI.TEXT_223404, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_255_115)
    scoreDes:centerLeft(textOffsetX, textOffsetY)
    scoreBg:addChild(scoreDes, 299)

    local scoreDesW = scoreDes:getContentSize().width
    local score = UI.Text:create()
    score:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_224_115)
    score:centerLeft(textOffsetX+10+scoreDesW, textOffsetY)
    scoreBg:addChild(score, 299)
    self.score = score

    local timeBg  = UI.Image:create()
    timeBg:init("ui_trial_ranking_entry_4.png")
    timeBg:rightBottom(200, -70)
    contentLayout:addChild(timeBg)

    local timeDes = UI.Text:create()
    timeDes:init(UI.TEXT_223405, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_255_115)
    timeDes:centerLeft(textOffsetX, textOffsetY)
    timeBg:addChild(timeDes, 299)
    
    local timeDesW = timeDes:getContentSize().width
    local time = UI.Text:create()
    time:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_224_115)
    time:centerLeft(textOffsetX+10+timeDesW, textOffsetY)
    timeBg:addChild(time, 299)
    self.time = time

    -- 按钮功能
    local closeBtn = UI.Button:create()
    closeBtn:init("ui_trial_ranking_btn.png","ui_trial_ranking_btn.png","ui_trial_ranking_btn.png");
    closeBtn:centerBottom(-130);
    -- closeBtn:closeClickScale()
    closeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    closeBtn:setText(UI.TEXT_223406)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        mvc.activityModeCaveModel:clearTrialLandSettleData()
        mvc.closePanel("ActivityModeCave", "ActivityModeCaveEntryReward")
    end)
    contentLayout:addChild(closeBtn)

    self:addEntryView()
    self:updateRewardView()
end

function ActivityModeCaveEntryRewardView:addEntryView()
    -- 内容面板
    local entryLayout = UI.Layout:create();
    entryLayout:init()
    entryLayout:setSize(770, 185)
    entryLayout:center(0, 30)
    self.contentLayout:addChild(entryLayout)
    self.entryLayout = entryLayout

    local entryList = self.data.effects
    -- entryList = {
    --     101,
    --     102,
    --     103,
    --     201,
    --     301,
    --     302
    -- }

    if (entryList and #entryList > 0) then
        table.sort(entryList, function(a, b)
            return a > b
        end)
        local column = 3
        local startX = 50
        local onePaddingX = 216
        local onePaddingY = 50

        for k, v in ipairs(entryList) do
            local config = ConfigManager:getAllTrialEntryDataByID(v)
            local cell = mvc.activityModeCaveEntryRewardCellView:create(config)
            cell:init()
            local idx  = math.floor(k/column)
            if((k-1)%column == 0 or k == 1) then
                cell:leftUp(startX , onePaddingY*idx)
            else
                local ratio = k%column == 0 and column or k%column
                idx = k%column == 0 and idx-1 or idx
                cell:leftUp(startX + (ratio-1)*onePaddingX, onePaddingY*idx)
            end
            entryLayout:addChild(cell)
        end
    end

end

function ActivityModeCaveEntryRewardView:updateRewardView()
    local settleData = mvc.activityModeCaveModel:getTrialLandSettleData()
    local score = 0
    if settleData.effects then
        for k, v in pairs(settleData.effects) do
            if v then
                local config = ConfigManager:getAllTrialEntryDataByID(v)
                score = config.score + score
            end
        end
    end
    local time = string.format("%d：%02d",math.floor(settleData.duration/60),settleData.duration%60)
    self.score:setText(string.format(UI.TEXT_223402, score))
    self.time:setText(time)
    self.score:setText(score)
end

function ActivityModeCaveEntryRewardView:bindModel()

end


function ActivityModeCaveEntryRewardView:unbindModel()

end





return ActivityModeCaveEntryRewardView













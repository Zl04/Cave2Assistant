------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveEntryRewardCellView = class("ActivityModeCaveEntryRewardCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 170
local COM_HEIGHT = 46

function ActivityModeCaveEntryRewardCellView:ctor(data)
    ActivityModeCaveEntryRewardCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function ActivityModeCaveEntryRewardCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecave", "ActivityModeCave", false)
    ActivityModeCaveEntryRewardCellView.super.init(self, ... )
end

function ActivityModeCaveEntryRewardCellView:dtor()
    ActivityModeCaveEntryRewardCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecave.ActivityModeCaveEntryRewardCellView")
end


function ActivityModeCaveEntryRewardCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(3, 25)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("")
    centerBg:center()
    contentLayout:addChild(centerBg)
    self.centerBg = centerBg

    local icon  = UI.Image:create()
    icon:init("")
    icon:centerLeft(3)
    centerBg:addChild(icon)
    self.icon = icon

    local des = UI.Text:create()
    des:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    des:center(15, 0)
    centerBg:addChild(des)
    self.des = des

    self:updateEntryCellView()
end

function ActivityModeCaveEntryRewardCellView:updateEntryCellView()
    self.centerBg:setSpriteName(string.format("ui_trial_ranking_entry_%d", self.data.difficulty)..".png")
    self.icon:setSpriteName(self.data.icon)
    local str = languageManagerInstance:getLocalString(self.data.name)
    self.des:setText(str)
    
end

function ActivityModeCaveEntryRewardCellView:bindModel()

end


function ActivityModeCaveEntryRewardCellView:unbindModel()

end





return ActivityModeCaveEntryRewardCellView













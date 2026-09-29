------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/09
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveRankView = class("ActivityModeCaveRankView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 1136
local COM_HEIGHT = 640

function ActivityModeCaveRankView:ctor()
    ActivityModeCaveRankView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ActivityModeCaveRankView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecave", "ActivityModeCave", false)
    ActivityModeCaveRankView.super.init(self, ... )
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.close)
end

function ActivityModeCaveRankView:dtor()
    ActivityModeCaveRankView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecave.ActivityModeCaveRankView")
end


function ActivityModeCaveRankView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("试炼之地排行.png")
    bg:center()
    contentLayout:addChild(bg)
end


function ActivityModeCaveRankView:bindModel()

end


function ActivityModeCaveRankView:unbindModel()

end





return ActivityModeCaveRankView













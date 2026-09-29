------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveEntryDesCellView = class("ActivityModeCaveEntryDesCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 674
local COM_HEIGHT = 36

function ActivityModeCaveEntryDesCellView:ctor(data, index)
    ActivityModeCaveEntryDesCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.index = index
    self:bindModel()
end

function ActivityModeCaveEntryDesCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecave", "ActivityModeCave", false)
    ActivityModeCaveEntryDesCellView.super.init(self, ... )
end

function ActivityModeCaveEntryDesCellView:dtor()
    ActivityModeCaveEntryDesCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecave.ActivityModeCaveEntryDesCellView")
end


function ActivityModeCaveEntryDesCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_trial_list_4.png")
    bg:center()
    contentLayout:addChild(bg)
    self.bg = bg

    local icon = UI.Image:create()
    icon:init(self.data.icon)
    icon:centerLeft(0, 0)
    contentLayout:addChild(icon)
    icon:setScale(0.9)

    -- 文字
    local str = languageManagerInstance:getLocalString(self.data.des)
    local entryDes = UI.Text:create()
    entryDes:init(str, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    entryDes:centerLeft(45)
    contentLayout:addChild(entryDes)
    self.entryDes = entryDes

    self:updateDesView()
end

function ActivityModeCaveEntryDesCellView:updateDesView()
    self.bg:setVisible(self.index%2 ~= 0)
end

function ActivityModeCaveEntryDesCellView:hideBG()
    self.bg:hide()
end

function ActivityModeCaveEntryDesCellView:bindModel()

end


function ActivityModeCaveEntryDesCellView:unbindModel()

end





return ActivityModeCaveEntryDesCellView













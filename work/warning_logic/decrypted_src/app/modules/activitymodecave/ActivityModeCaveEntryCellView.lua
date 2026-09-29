------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityModeCaveEntryCellView = class("ActivityModeCaveEntryCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 216
local COM_HEIGHT = 38

function ActivityModeCaveEntryCellView:ctor(data, checked)
    ActivityModeCaveEntryCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.checked = checked or false
    self:bindModel()
end

function ActivityModeCaveEntryCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activitymodecave", "ActivityModeCave", false)
    ActivityModeCaveEntryCellView.super.init(self, ... )

    -- self:setTouchEnable(true)
    -- self:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onClickEntry)
end

function ActivityModeCaveEntryCellView:dtor()
    ActivityModeCaveEntryCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activitymodecave.ActivityModeCaveEntryCellView")
end


function ActivityModeCaveEntryCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_trial_entrybg_1.png")
    bg:center()
    contentLayout:addChild(bg)
    self.bg = bg

    local frame = UI.Image:create()
    frame:init("ui_trial_buffbox.png")
    frame:centerLeft(0, -1)
    bg:addChild(frame)

    local icon = UI.Image:create()
    icon:init(self.data.icon)
    icon:centerLeft(4, -1)
    bg:addChild(icon)

    -- 文字
    local str = languageManagerInstance:getLocalString(self.data.name)
    local entryDes = UI.Text:create()
    entryDes:init(str, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    entryDes:centerLeft(55)
    bg:addChild(entryDes)
    self.entryDes = entryDes

    local check = UI.Image:create()
    check:init("ui_trial_hook.png")
    check:centerRight(0, 0)
    bg:addChild(check)
    self.check = check
    check:hide()

    self:initEntryView()
end

function ActivityModeCaveEntryCellView:initEntryView()
    if self.checked then
        self.bg:setSpriteName("ui_trial_entrybg_2.png")
        self.check:show()
    else
        self.bg:setSpriteName("ui_trial_entrybg_1.png")
        self.check:hide()
    end
end

function ActivityModeCaveEntryCellView:updateEntryView()
    if self.checked then
        self.bg:setSpriteName("ui_trial_entrybg_2.png")
        self.check:show()
    else
        self.bg:setSpriteName("ui_trial_entrybg_1.png")
        self.check:hide()
    end
    mvc.send("ActivityModeCave_Refresh_EntryDes_View")
end

function ActivityModeCaveEntryCellView:clearEntryState()
    if self.checked then
        self.bg:setSpriteName("ui_trial_entrybg_1.png")
        self.check:hide()
        self.checked = false
    end
end

function ActivityModeCaveEntryCellView:onClickEntry()
    if self.checked then
        mvc.activityModeCaveModel:removeEntryFromSelctedEntryList(self.data.ID)
        self.checked = false
    else
        mvc.activityModeCaveModel:setSelctedEntryList(self.data.ID)
        self.checked = true
    end
    self:updateEntryView()
end

function ActivityModeCaveEntryCellView:isChecked()
    return self.checked
end

function ActivityModeCaveEntryCellView:bindModel()


end


function ActivityModeCaveEntryCellView:unbindModel()

end





return ActivityModeCaveEntryCellView













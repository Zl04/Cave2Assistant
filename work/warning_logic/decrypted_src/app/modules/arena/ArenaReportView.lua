------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/29
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ArenaReportView = class("ArenaReportView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 978
local COM_HEIGHT = 555

function ArenaReportView:ctor()
    ArenaReportView.super.ctor(
    	self,
    	UI.Type.ARENA_REPORT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ArenaReportView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.arena", "Arena", false)
    ArenaReportView.super.init(self, ... )
end

function ArenaReportView:dtor()
    ArenaReportView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.arena.ArenaReportView")
end


function ArenaReportView:onInitView()
end


function ArenaReportView:bindModel()

end


function ArenaReportView:unbindModel()

end





return ArenaReportView













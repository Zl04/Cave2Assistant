------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/12/23
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ViKingMainView = class("ViKingMainView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ViKingMainView:ctor()
    ViKingMainView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ViKingMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.viking", "ViKing", false)
    ViKingMainView.super.init(self, ... )
end

function ViKingMainView:dtor()
    ViKingMainView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.viking.ViKingMainView")
end


function ViKingMainView:onInitView()
end


function ViKingMainView:bindModel()

end


function ViKingMainView:unbindModel()

end





return ViKingMainView













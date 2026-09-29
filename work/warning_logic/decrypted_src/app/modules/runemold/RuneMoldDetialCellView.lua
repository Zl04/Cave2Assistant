------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/20
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RuneMoldDetialCellView = class("RuneMoldDetialCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function RuneMoldDetialCellView:ctor()
    RuneMoldDetialCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function RuneMoldDetialCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.runemold", "RuneMold", false)
    RuneMoldDetialCellView.super.init(self, ... )
end

function RuneMoldDetialCellView:dtor()
    RuneMoldDetialCellView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.runemold.RuneMoldDetialCellView")
end


function RuneMoldDetialCellView:onInitView()
end


function RuneMoldDetialCellView:bindModel()

end


function RuneMoldDetialCellView:unbindModel()

end





return RuneMoldDetialCellView













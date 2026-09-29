------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/07
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapShowGetCardView = class("ManorStarMapShowGetCardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ManorStarMapShowGetCardView:ctor()
    ManorStarMapShowGetCardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ManorStarMapShowGetCardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapShowGetCardView.super.init(self, ... )
end

function ManorStarMapShowGetCardView:dtor()
    ManorStarMapShowGetCardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapShowGetCardView")
end


function ManorStarMapShowGetCardView:onInitView()
end


function ManorStarMapShowGetCardView:bindModel()

end


function ManorStarMapShowGetCardView:unbindModel()

end





return ManorStarMapShowGetCardView













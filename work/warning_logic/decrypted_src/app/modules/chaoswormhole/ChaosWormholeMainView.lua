------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/08/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ChaosWormholeMainView = class("ChaosWormholeMainView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function ChaosWormholeMainView:ctor()
    ChaosWormholeMainView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ChaosWormholeMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.chaoswormhole", "ChaosWormhole", false)
    ChaosWormholeMainView.super.init(self, ... )
end

function ChaosWormholeMainView:dtor()
    ChaosWormholeMainView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.chaoswormhole.ChaosWormholeMainView")
end


function ChaosWormholeMainView:onInitView()
end


function ChaosWormholeMainView:bindModel()

end


function ChaosWormholeMainView:unbindModel()

end





return ChaosWormholeMainView













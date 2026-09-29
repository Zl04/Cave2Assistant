------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailGuildEventLayer = class("BigSailGuildEventLayer", UI.HWBtnComponent)
local PetPacketLayer = require("app.modules.pettreasure.common.PetTreasurePacketLayer")
local GameInManorManager = require "app.game.GameInManorManager"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local INNER_WIDTH = 681
local INNER_HEIGHT = 470
local BTN_CELL_W = 210
local BTN_CELL_H = 52
local RIGHT_COM_W = 410
local RIGHT_COM_H = 420

local CELL_WIDTH = 384
local CELL_HEIGHT = 80
local TABLE_WIDTH = 384
local TABLE_HEIGHT = 280

function BigSailGuildEventLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW, self, self.updateUpgradeView)
end

function BigSailGuildEventLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_BUILD_UPGRADE_VIEW, self, self.updateUpgradeView)
end

function BigSailGuildEventLayer:ctor(buildId, uiType)
    BigSailGuildEventLayer.super.ctor(
    	self,
    	uiType,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self:bindModel()
end

function BigSailGuildEventLayer:init( ... )
    BigSailGuildEventLayer.super.init(self, ... )

end

function BigSailGuildEventLayer:dtor()
    BigSailGuildEventLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.bigsailport.BigSailGuildEventLayer")
end

function BigSailGuildEventLayer:onInitView()
    
end



return BigSailGuildEventLayer













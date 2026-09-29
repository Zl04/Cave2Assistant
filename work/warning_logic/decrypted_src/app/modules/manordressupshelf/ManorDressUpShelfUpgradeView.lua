------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/08/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorDressUpShelfUpgradeView = class("ManorDressUpShelfUpgradeView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 1111
local COM_HEIGHT = 564

function ManorDressUpShelfUpgradeView:ctor()
    ManorDressUpShelfUpgradeView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function ManorDressUpShelfUpgradeView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manordressupshelf", "ManorDressUpShelf", false)
    ManorDressUpShelfUpgradeView.super.init(self, ... )
end

function ManorDressUpShelfUpgradeView:dtor()
    ManorDressUpShelfUpgradeView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manordressupshelf.ManorDressUpShelfUpgradeView")
end


function ManorDressUpShelfUpgradeView:onInitView()
    self:center()

    local DockUpgradeLayer = require "app.modules.dock.DockUpgradeLayer"
    local dockUpgradeLayer = DockUpgradeLayer:create(PublicDefine.ManorBuildID.BuildID_EquipmentRack)
    dockUpgradeLayer:init()
    dockUpgradeLayer:center()

    self:addChild(dockUpgradeLayer)
end


function ManorDressUpShelfUpgradeView:bindModel()

end


function ManorDressUpShelfUpgradeView:unbindModel()

end





return ManorDressUpShelfUpgradeView













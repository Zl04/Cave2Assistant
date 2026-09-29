------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/21
--desc	: 
------------------------------------------------------------------------------
local SettingAreaServerSelectOneView = require("app.modules.setting.SettingAreaServerSelectOneView")

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SettingAreaServerSelectCellView = class("SettingAreaServerSelectCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 650
local COM_HEIGHT = 71

function SettingAreaServerSelectCellView:ctor()
    SettingAreaServerSelectCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function SettingAreaServerSelectCellView:dtor()
    print("SettingAreaServerSelectCellView:dtor()")
end

function SettingAreaServerSelectCellView:init(areaType, ... )
    self.areaType = areaType
    -- self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.setting", "Setting", false)
    SettingAreaServerSelectCellView.super.init(self, areaType, ... )
end

function SettingAreaServerSelectCellView:dtor()
    SettingAreaServerSelectCellView.super.dtor(self)
    self:unbindModel()
    -- reload_script_file_mvc("app.modules.setting.SettingAreaServerSelectCellView")
end

function SettingAreaServerSelectCellView:setData(data, cellIndex)
    self.data = data
    self.cellIndex = cellIndex

    self:updateView()
end

function SettingAreaServerSelectCellView:onInitView()

    self.oneView = SettingAreaServerSelectOneView:create(self.areaType)
    self.twoView = SettingAreaServerSelectOneView:create(self.areaType)
    self.threeView = SettingAreaServerSelectOneView:create(self.areaType)
    self:addChild(self.oneView)
    self:addChild(self.twoView)
    self:addChild(self.threeView)

    local startX = 2
    local oneWidth = 214
    self.oneView:init()
    self.oneView:centerLeft(startX)
    startX = startX + oneWidth
    self.twoView:init()
    self.twoView:centerLeft(startX)
    startX = startX + oneWidth
    self.threeView:init()
    self.threeView:centerLeft(startX)
end

function SettingAreaServerSelectCellView:onUpdateView()
    local startIndex = self.cellIndex * 3 + 1
    if(self.data[startIndex]) then 
        self.oneView:show()
        self.oneView:setData(self.data[startIndex])
    else
        self.oneView:hide()
    end

    startIndex = startIndex + 1
    if(self.data[startIndex]) then 
        self.twoView:show()
        self.twoView:setData(self.data[startIndex])
    else
        self.twoView:hide()
    end

    startIndex = startIndex + 1
    if(self.data[startIndex]) then 
        self.threeView:show()
        self.threeView:setData(self.data[startIndex])
    else 
        self.threeView:hide()
    end
end

function SettingAreaServerSelectCellView:bindModel()

end


function SettingAreaServerSelectCellView:unbindModel()

end





return SettingAreaServerSelectCellView













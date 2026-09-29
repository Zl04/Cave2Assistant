------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/10/16
--desc	: 
------------------------------------------------------------------------------
local MainCityFunctionChoiceCellView = require "app.modules.maincity.MainCityFunctionChoiceCellView"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local MainCityFunctionChoiceView = class("MainCityFunctionChoiceView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_maincity.plist"
}

local COM_WIDTH = 978
local COM_HEIGHT = 534

function MainCityFunctionChoiceView:ctor()
    MainCityFunctionChoiceView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function MainCityFunctionChoiceView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.maincity", "MainCity", false)
    MainCityFunctionChoiceView.super.init(self, ... )
end

function MainCityFunctionChoiceView:dtor()
    MainCityFunctionChoiceView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.maincity.MainCityFunctionChoiceView")
end


function MainCityFunctionChoiceView:onInitView()
    local choiceTriggerData = mvc.mainCityModel:getChoiceTriggerData()
    if(choiceTriggerData == nil) then 
        
        return 
    end

    local data = choiceTriggerData:getSelectData()
    local spriteID = choiceTriggerData:getSpriteID()
    print("MainCityFunctionChoiceView:onInitView", #data)
    if(data and #data) then 
        local oneHeight = 246
        local oneOffset = 30
        local startY = - (oneHeight * #data + (#data - 1)*oneOffset)/2 + oneHeight/2
        for k, data in ipairs(data) do 
            local cellView = MainCityFunctionChoiceCellView:create()
            cellView:init(data, spriteID)
            cellView:centerUp(startY)
            self:addChild(cellView)
            startY = startY + oneHeight
        end
    end
end


function MainCityFunctionChoiceView:bindModel()

end


function MainCityFunctionChoiceView:unbindModel()

end





return MainCityFunctionChoiceView













------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/21
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SettingAreaServerSelectOneView = class("SettingAreaServerSelectOneView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 214
local COM_HEIGHT = 70

function SettingAreaServerSelectOneView:ctor(areaType)
    SettingAreaServerSelectOneView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.areaType = areaType
    self.areaServerData = nil
    self:bindModel()
end

function SettingAreaServerSelectOneView:init( ... )
    -- self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.setting", "Setting", false)
    SettingAreaServerSelectOneView.super.init(self, ... )
end

function SettingAreaServerSelectOneView:dtor()
    SettingAreaServerSelectOneView.super.dtor(self)
    self:unbindModel()
    -- reload_script_file_mvc("app.modules.setting.SettingAreaServerSelectOneView")
end


function SettingAreaServerSelectOneView:onInitView()
    -- self:enableDebugDraw()
    -- 按钮
    local changeBtn = UI.Button:create()
    changeBtn:init(
        "ui_btn_screening_0.png",
        "ui_btn_screening_0.png",
        "ui_btn_screening_2.png"
    )
    changeBtn:closeClickScale()
    changeBtn:centerUp(5)
    changeBtn:setSwallowTouches(false)
    changeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onChangeAreaServer)
    changeBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    self:addChild(changeBtn, 100)
    self.changeBtn = changeBtn
    
    -- have role tag
    local roleTag = UI.Image:create()
    roleTag:init("ui_setup_server_role_btn_0.png")
    roleTag:centerLeft(5)
    changeBtn:addChild(roleTag, 100)
    self.roleTag = roleTag

    -- server area name 
    local areaText = UI.Text:create()
    areaText:init("", UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    areaText:center(15)
    changeBtn:addChild(areaText,10)
    self.areaText = areaText

    -- 
    local nickNameText = UI.Text:create()
    nickNameText:init("", UI.SYS_FONT, UI.FONT_SIZE_12PX, UI.FONT_COLOR_41_101_25)
    nickNameText:leftBottom(5, 6)
    self:addChild(nickNameText)
    self.nickNameText = nickNameText


    local serverStaus = UI.Image:create()
    serverStaus:init("ui_setup_server_new.png")
    serverStaus:rightUp(-5,-5)
    changeBtn:addChild(serverStaus, 101)
    self.serverStaus = serverStaus
end

function SettingAreaServerSelectOneView:getIsNowServer()
    if(self.areaServerData) then 
        if(self.areaType == Game.AREA_TYPE.AREA_TYPE_MAINLAYER) then 
            return ServerConfigUtil:checkIsNowChoiceForAreaID(self.areaServerData:getAreaID())
        else
            return self.areaServerData:isNowServer()
        end
    end

    return false
end

function SettingAreaServerSelectOneView:getWasRecommenServer()
    if(self.areaServerData) then 
        return self.areaServerData:getWasRecommenServer()
    end
    
    return false
end

function SettingAreaServerSelectOneView:onUpdateView()
    -- print("SettingAreaServerSelectOneView:onUpdateView()", self.areaServerData)
    if(self.areaServerData) then 
        -- print("SettingAreaServerSelectOneView:onUpdateView() 22")
        self:show()
        if(self:getIsNowServer()) then 
            self.changeBtn:setNormal("ui_btn_screening_1.png")
            self.changeBtn:setSelected("ui_btn_screening_1.png")
        else 
            self.changeBtn:setNormal("ui_btn_screening_0.png")
            self.changeBtn:setSelected("ui_btn_screening_0.png")
        end

        self.areaText:setText(self.areaServerData:getAreaName())

        -- 是否维护状态
        local isMaintain = false
        if(self.areaServerData:getStatus() == PublicDefine.AreaStatus.AreaStatus_Maintain) then 
            self.changeBtn:disable()
            isMaintain = true
        elseif(self.areaServerData:getStatus() == PublicDefine.AreaStatus.AreaStatus_Normal) then 
            self.changeBtn:enable()
        end


        if(self.areaServerData:getIsRole()) then
            self.areaText:center(15) 
            self.roleTag:show()
            self.nickNameText:setText(self.areaServerData:getRoleStr())
        else
            self.areaText:center() 
            self.roleTag:hide()
            self.nickNameText:setText("")
        end
        self.serverStaus:show()
        if(isMaintain) then 
            self.serverStaus:setSpriteName("ui_iteminfo_btn_locked.png")
        elseif (self:getWasRecommenServer()) then 
            self.serverStaus:setSpriteName("ui_setup_server_new.png")
        else
            self.serverStaus:hide()
        end
    else
        self:hide()
    end
end

function SettingAreaServerSelectOneView:setData(areaServerData)
    self.areaServerData = areaServerData
    self:updateView()
end

function SettingAreaServerSelectOneView:onChangeAreaServer()
    if(self.areaServerData) then 
        if(self.areaType == Game.AREA_TYPE.AREA_TYPE_MAINLAYER) then 
            ServerConfigUtil:setNowChoiceAreaID(self.areaServerData:getAreaID())

            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170304).."“"..self.areaServerData:getAreaName().."”")
        else
            local nowAreaData = mvc.settingModel:getNowAreaData()
            if(nowAreaData and nowAreaData:getAreaID() == self.areaServerData:getAreaID()) then 
                UI.ScrollBar:createByText(UI.TEXT_1324363)
                return
            end

            local tip = UI.TipsLayer:onShowCommonTextHandler(string.format(UI.TEXT_1324362, self.areaServerData:getAreaName()), function()
                local data = {}
                data.areaID = self.areaServerData:getAreaID()
                ServerConfigUtil:changeNowChoiceAreaID(self.areaServerData)
                -- ServerConfigUtil:setNowChoiceAreaID(self.areaServerData:getAreaID())
                mvc.send(mvc.events.Setting_Area_Server_HandleChangeArea, data)
            end)
            tip:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
        end
    end
end

function SettingAreaServerSelectOneView:bindModel()

end


function SettingAreaServerSelectOneView:unbindModel()

end





return SettingAreaServerSelectOneView













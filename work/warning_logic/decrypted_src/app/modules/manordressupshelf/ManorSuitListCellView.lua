------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/08/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorSuitListCellView = class("ManorSuitListCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 148
local COM_HEIGHT = 50

function ManorSuitListCellView:ctor(templateID)
    ManorSuitListCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._templateID = templateID
    self._templateData = nil
    self._scheduleMax = 0
end

function ManorSuitListCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manordressupshelf", "ManorDressUpShelf", false)
    ManorSuitListCellView.super.init(self, ... )
end

function ManorSuitListCellView:dtor()
    ManorSuitListCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manordressupshelf.ManorSuitListCellView")
end


function ManorSuitListCellView:onInitView()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self._bg = UI.Image:create()
    self._bg:init("ui_illusionstand_bookmark_normal.png")
    self._bg:center()
    self.contentLayout:addChild(self._bg)

    local templateData = ConfigManager:getAllIllusionRackDataByID(self._templateID)
    self._templateData = templateData
    if templateData then
        local suitNameStr = LanguageManager:getInstance():getLocalString(templateData.groupName)

        local nameText = UI.Text:create()
        nameText:init(suitNameStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=37,g=37,b=40})
        nameText:centerUp(2)
        self._bg:addChild(nameText)


        local equipIllusionDatas = string.split(templateData.equipIllusionId, ";")
        local scheduleMax = #equipIllusionDatas
        self._scheduleMax = scheduleMax
        local scheduleMin = 0

        self._scheduleText = UI.Text:create()
        self._scheduleText:init("(" .. scheduleMin .. "/" .. scheduleMax .. ")", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=37,g=37,b=40})
        self._scheduleText:centerBottom(2)
        self._bg:addChild(self._scheduleText)

        self._redPoint = UI.Image:create()
        self._redPoint:init("ui_information_newitem.png")
        self._redPoint:rightUp(-3,-3)
        self._bg:addChild(self._redPoint)

        self._activityImg = UI.Image:create()
        self._activityImg:init("ui_illusionstand_label_activation.png")
        self._activityImg:rightUp(0,-2)
        self._bg:addChild(self._activityImg)

        self._showEffectImg = UI.Image:create()
        self._showEffectImg:init("ui_illusionstand_subscript1.png")
        self._showEffectImg:leftUp(-15,-3)
        self._bg:addChild(self._showEffectImg)



        self:refreshAllState()
    end
end

function ManorSuitListCellView:setSelect(isSelect)
    if isSelect then
        self._bg:setSpriteName("ui_illusionstand_bookmark_select.png")
    else
        self._bg:setSpriteName("ui_illusionstand_bookmark_normal.png")
    end
end

function ManorSuitListCellView:refreshAllState()
    local showRedPoint, activateNum, isAllActivate = mvc.manorDressUpShelfModel:suitListShowRedPointById(self._templateID)
    if showRedPoint then
        self._redPoint:show()
    else
        self._redPoint:hide()
    end

    self._scheduleText:setText("(" .. activateNum .. "/" .. self._scheduleMax .. ")")

    if isAllActivate then
        self._activityImg:show()
    else
        self._activityImg:hide()
    end

    local npcIndex = mvc.manorDressUpShelfModel:getShowSuitViewRetrunNpcIndexByIllusionId(self._templateID)
    self._showEffectImg:show()
    if npcIndex == 1 then
        self._showEffectImg:setSpriteName("ui_illusionstand_subscript1.png")
    elseif npcIndex == 2 then
        self._showEffectImg:setSpriteName("ui_illusionstand_subscript2.png")
    elseif npcIndex == 3 then
        self._showEffectImg:setSpriteName("ui_illusionstand_subscript3.png")
    else
        self._showEffectImg:hide()
    end
end

function ManorSuitListCellView:bindModel()

end


function ManorSuitListCellView:unbindModel()

end





return ManorSuitListCellView













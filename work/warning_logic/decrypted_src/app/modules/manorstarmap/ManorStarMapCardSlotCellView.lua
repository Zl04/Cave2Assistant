------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/29
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapCardSlotCellView = class("ManorStarMapCardSlotCellView", UI.HWBtnComponent)
local GameInManorManager = require "app.game.GameInManorManager"

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local COM_WIDTH = 96
local COM_HEIGHT = 124

function ManorStarMapCardSlotCellView:ctor(data)
    ManorStarMapCardSlotCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._isUnlock = false
    self._data = data
end

function ManorStarMapCardSlotCellView:init( ... ) 
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapCardSlotCellView.super.init(self, ...)
   
end

function ManorStarMapCardSlotCellView:dtor()
    ManorStarMapCardSlotCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapCardSlotCellView")
end


function ManorStarMapCardSlotCellView:onInitView()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    
    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(self._data.unlockType)
    local bgStr = "ui_starmap_cardslot_2.png"
    local buildLevel = buildData and buildData.level or 1
    if buildLevel >= self._data.unlockLevel then
        self._isUnlock = true
        if self._data.type == 2 then
            bgStr = "ui_starmap_cardslot.png"
        end
    else
        self._isUnlock = false
        bgStr = "ui_starmap_cardslot_lock.png"
    end

    self._bg = UI.Image:create()
    self._bg:init(bgStr)
    self._bg:center()
    self.contentLayout:addChild(self._bg)

    if self._isUnlock then
        if self._data.cardId and self._data.cardId ~= 0 then
            local cardView = mvc.manorStarMapCardCellView:create(self._data)
            cardView:init()
            cardView:center()
            self.contentLayout:addChild(cardView)
        end
    else
        local desStr = ""
        if self._data.unlockType == PublicDefine.ManorBuildID.BuildID_Manor then
            desStr = UI.TEXT_222604               
        elseif self._data.unlockType == PublicDefine.ManorBuildID.BuildID_StarMap then
            desStr = UI.TEXT_222605                   
        elseif self._data.unlockType == PublicDefine.ManorBuildID.BuildID_TravelShop then
            desStr = UI.TEXT_222606                   
        elseif self._data.unlockType == PublicDefine.ManorBuildID.BuildID_Dock then
            desStr = UI.TEXT_222607                   
        elseif self._data.unlockType == PublicDefine.ManorBuildID.BuildID_Table then
            desStr = UI.TEXT_222608                   
        elseif self._data.unlockType == PublicDefine.ManorBuildID.BuildID_EquipmentRack then
            desStr = UI.TEXT_222609                   
        end

        desStr = desStr .. "Lv." .. self._data.unlockLevel .. UI.TEXT_222610

        local text = UI.Text:create()
        text:init(desStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=155,g=155,b=155})
        text:center()
        text:setWidth(80)
        text:setTextCenter()
        self._bg:addChild(text)

    end

end


function ManorStarMapCardSlotCellView:bindModel()

end


function ManorStarMapCardSlotCellView:unbindModel()

end





return ManorStarMapCardSlotCellView













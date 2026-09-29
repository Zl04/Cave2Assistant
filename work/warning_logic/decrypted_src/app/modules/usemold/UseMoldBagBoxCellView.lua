------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local UseMoldBagBoxCellView = class("UseMoldBagBoxCellView", UI.ListGrid)
UI.UseMoldBagBoxCellView = UseMoldBagBoxCellView

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 80
local COM_HEIGHT = 80

local RARE_BG = "box_quality_2_%d.png"

function UseMoldBagBoxCellView:ctor(notBag)
    UseMoldBagBoxCellView.super.ctor(
    	self
    )

    self._isDragging = false
    self._touchBeganPosition = nil
    self.notBag = notBag
    self.moldInfo = nil
    self:bindModel()
end

function UseMoldBagBoxCellView:init(data, ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.usemold", "UseMold", false)
    UseMoldBagBoxCellView.super.init(self, ... )
    self.data = data
end

function UseMoldBagBoxCellView:dtor()
    UseMoldBagBoxCellView.super.dtor(self)
    self:unbindModel()
    self.data = nil
    self.moldInfo = nil
    self.dragBeginCallback = nil
    self.dragMoveCallback = nil
    self.dragEndCallback = nil
    self.dragOutAreaJudgeNode = nil
    reload_script_file_mvc("app.modules.usemold.UseMoldBagBoxCellView")
end


function UseMoldBagBoxCellView:onInitView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self:addChild(cellLayout)

    -- 背景
    local bg = UI.Image:create()
    bg:init("box_quality_box_01.png")
    bg:center()
    cellLayout:addChild(bg)
    self.bg = bg

    local rareBg = UI.Image:create()
    rareBg:init()
    rareBg:center()
    cellLayout:addChild(rareBg)
    self.rareBg = rareBg

    local icon = UI.Image:create()
    icon:init()
    icon:center()
    cellLayout:addChild(icon)
    self.icon = icon
end

function UseMoldBagBoxCellView:onUpdateView()
    if self.moldInfo then
        if self.notBag then
            self.rareBg:setSpriteName(string.format(RARE_BG, self.data.rare))--("box_quality_2_3.png")
            self.icon:setSpriteName(self.data.moldIcon)
        elseif not self.notBag and self.moldInfo.pos == 0 then
            self.rareBg:setSpriteName(string.format(RARE_BG, self.data.rare))
            self.icon:setSpriteName(self.data.moldIcon)
        elseif not self.notBag and self.moldInfo.pos ~= 0 then
            self.rareBg:hide()
            self.icon:hide()
        end
        
    end
end

function UseMoldBagBoxCellView:hideBg()
    if self.bg then
        self.bg:hide()
    end
end

function UseMoldBagBoxCellView:isClickShowInfo()
    return true
end

function UseMoldBagBoxCellView:createDraggedView()
    local cardView = mvc.useMoldBagBoxCellView:create()
    cardView:init()
    local data = {}
    data.config = self.data
    data.moldInfo = self.moldInfo
    cardView:setData(data)
    cardView:hideBg()

    return cardView
end

function UseMoldBagBoxCellView:setData(data)
    self.data = data.config
    self.moldInfo = data.moldInfo
end

function UseMoldBagBoxCellView:getData()
    local data = {}
    data.config = self.data
    data.moldInfo = self.moldInfo
    return data
end

function UseMoldBagBoxCellView:isEmpty()
    local isEmpty = false
    if not self.notBag and self.moldInfo and self.moldInfo.pos ~= 0 then
        isEmpty = true
    end
    return self.moldInfo == nil or isEmpty
end

function UseMoldBagBoxCellView:showIcon()

end

function UseMoldBagBoxCellView:bindModel()

end


function UseMoldBagBoxCellView:unbindModel()

end





return UseMoldBagBoxCellView













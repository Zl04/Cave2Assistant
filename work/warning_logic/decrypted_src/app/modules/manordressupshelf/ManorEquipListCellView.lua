------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/08/30
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorEquipListCellView = class("ManorEquipListCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 297
local COM_HEIGHT = 74

function ManorEquipListCellView:ctor(data)
    ManorEquipListCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._data = data
end

function ManorEquipListCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manordressupshelf", "ManorDressUpShelf", false)
    ManorEquipListCellView.super.init(self, ... )
end

function ManorEquipListCellView:dtor()
    ManorEquipListCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manordressupshelf.ManorEquipListCellView")
end


function ManorEquipListCellView:onInitView()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    
    --
    local bg = UI.Image:create()
    bg:init("ui_illusionstand_paper.png")
    bg:leftBottom(0,2)
    contentLayout:addChild(bg)

    local lineImg = UI.Image:create()
    lineImg:init("ui_illusionstand_line.png")
    lineImg:centerBottom(0,0)
    contentLayout:addChild(lineImg)

    local state = self._data.state
    local goodsID = self._data.goodsID

    if state ~= 1 then
        bg:hide()
    end

    if state == 2 then
        local starSp = UI.Animation:create()
        starSp:init("effect_ui_transmutestand_activation.json", "effect_ui_transmutestand_activation.atlas", 1);
        starSp:center()
        contentLayout:addChild(starSp,99)
        starSp:setAnimation("idle", true)
    end

    local goodsData = GoodsDataManager:createLocalGoodsData(goodsID)
    if goodsData then
        goodsData:setIsNew(false)

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:centerLeft(13,0)
        contentLayout:addChild(goodsGrid)
        goodsGrid:hideBG()
        goodsGrid:showInfoArea(true, false)
        
        if state ~= 1 then
            goodsGrid:setIsGray()
        end

        local nameText = UI.Text:create()
        nameText:init(goodsData:getName(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=37,g=37,b=40})
        nameText:centerUp(12,33)
        contentLayout:addChild(nameText)

        local stateText = UI.Text:create()
        stateText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=37,g=37,b=40})
        stateText:centerUp(38,33)
        contentLayout:addChild(stateText)

--         1 --已激活
--  2 -- 可激活
--  3 -- 显示解锁条件(幻化架多少级解锁)
--  4 -- 显示装备幻化来源
        if state == 1 then
            stateText:setText(UI.TEXT_222804)
            stateText:setFontColor({r=4,g=86,b=0})
        elseif state == 2 then
            stateText:setText(UI.TEXT_222810)
            stateText:setFontColor({r=4,g=86,b=0})
        elseif state == 3 then
            stateText:setText(self._data.unlockDesc)
            stateText:setFontColor({r=78,g=21,b=15})
        elseif state == 4 then
            stateText:setText(self._data.getSource)
            stateText:setFontColor({r=78,g=21,b=15})
        end
    end
    

end


function ManorEquipListCellView:bindModel()

end


function ManorEquipListCellView:unbindModel()

end





return ManorEquipListCellView













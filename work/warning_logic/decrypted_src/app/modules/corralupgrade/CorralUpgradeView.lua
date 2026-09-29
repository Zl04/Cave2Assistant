------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/05/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local CorralUpgradeView = class("CorralUpgradeView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 429
local COM_HEIGHT = 287

function CorralUpgradeView:ctor()
    CorralUpgradeView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._canMaterialata = true
end

function CorralUpgradeView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.corralupgrade", "CorralUpgrade", false)
    CorralUpgradeView.super.init(self, ... )
end

function CorralUpgradeView:dtor()
    CorralUpgradeView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.corralupgrade.CorralUpgradeView")
end


function CorralUpgradeView:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_setup_banner_box3.png")
    bg:center()
    contentLayout:addChild(bg)

    local contentBg = UI.Image9:create()
    contentBg:init("ui_scale9image_setup_banner_box_up.png",{x=0,y=0,width=20,height=20})
    contentBg:setLayoutType(UI.LayoutDefaultType.DEFAULT)
    contentBg:setReflectPos(29, 35)
    contentBg:setReflectSize(370, 127)
    contentBg:computePosition()
    bg:addChild(contentBg)

    local title = UI.Text:create()
    title:init(UI.TEXT_228102, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    title:center()
    title:setWidth(320)
    title:setTextCenter()
    title:autoAdapt()
    contentBg:addChild(title)

    local materialUpBtn = UI.Button:create();
    materialUpBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
    materialUpBtn:centerBottom(30, -97)
    materialUpBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    materialUpBtn:setText(UI.TEXT_228100)
    materialUpBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickMaterialUp)
    materialUpBtn:setScale(0.8)
    contentLayout:addChild(materialUpBtn)

    local itemOrCrystalUpBtn = UI.Button:create();
    itemOrCrystalUpBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
    itemOrCrystalUpBtn:centerBottom(30, 97)
    itemOrCrystalUpBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    itemOrCrystalUpBtn:setText(UI.TEXT_221021)
    itemOrCrystalUpBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.clickItemOrCrystalUp)
    itemOrCrystalUpBtn:setScale(0.8)
    contentLayout:addChild(itemOrCrystalUpBtn)

    local pk = RoleDataManager:getMaster():getPK()
    local itemDatas = mvc.corralUpgradeModel:getItemData()

    
    if itemDatas and itemDatas.materialata then
        local dataIndex = 1
        local preY = 24
        for k, v in pairs(itemDatas.materialata) do
            local itemLayout = UI.Layout:create();
            itemLayout:init()
            itemLayout:setScale(0.8)
            itemLayout:enableAutoWidth()
            itemLayout:centerBottom(110 - preY * (dataIndex - 1), -103)
            -- itemLayout:leftBottom(72, 110 - preY * (dataIndex - 1))

            contentLayout:addChild(itemLayout)

            local crystalIcon = UI.Image:create()
            crystalIcon:init(v.miniIcon)
            crystalIcon:floatLeft(5)
            itemLayout:addComponent(crystalIcon)

            local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, v.ID)
            if v.ID == 23030001 then
                itemTotalNum = GameDataManager:getInstance():getDiamond()
            end
            local itemNum = tonumber(itemTotalNum)

            local str = string.format("%d/%d", itemNum, tonumber(v.num))
            local titleText_1 = UI.Text:create()
            if tonumber(v.num) <= itemNum then
                titleText_1:init(str,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            else
                titleText_1:init(str,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_RED)
                self._canMaterialata = false
            end
            titleText_1:floatLeft(5)
            itemLayout:addComponent(titleText_1)

            dataIndex = dataIndex + 1
        end

    end


    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:enableAutoWidth()
    rightLayout:centerBottom(86, 103)
    contentLayout:addChild(rightLayout)

    local costLabel = UI.Text:create()
    costLabel:init(UI.TEXT_1170025, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    costLabel:floatLeft(5)
    rightLayout:addComponent(costLabel)

    local useItemIcon = UI.Image:create()
    useItemIcon:init("symbol_gaming_207180.png")
    useItemIcon:floatLeft(5)
    rightLayout:addComponent(useItemIcon)
    
    local costLabel2 = UI.Text:create()
    costLabel2:init(UI.TEXT_228101, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    costLabel2:floatLeft(5)
    rightLayout:addComponent(costLabel2)

    local crystalIcon = UI.Image:create()
    crystalIcon:init("symbol_gaming_diamond.png")
    crystalIcon:floatLeft(5)
    rightLayout:addComponent(crystalIcon)

    local costLabel3 = UI.Text:create()
    costLabel3:init(UI.TEXT_228100, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    costLabel3:floatLeft(5)
    rightLayout:addComponent(costLabel3)

end

function CorralUpgradeView:clickMaterialUp()
    if not self._canMaterialata then
        UI.ScrollBar:createByText(UI.TEXT_1212360)
        return
    end

    local itemDatas = mvc.corralUpgradeModel:getItemData()
    if itemDatas.siteId then
        Net.NetPetSystem:upgradePetSite(itemDatas.siteId, false, 0)
    end

    mvc.closePanel("CorralUpgrade", "CorralUpgrade")
end

function CorralUpgradeView:clickItemOrCrystalUp()


    mvc.closePanel("CorralUpgrade", "CorralUpgrade")

    mvc.openPanel("CorralUpgrade", "CorralUpgradeUseItem")
end 

function CorralUpgradeView:bindModel()

end


function CorralUpgradeView:unbindModel()

end





return CorralUpgradeView













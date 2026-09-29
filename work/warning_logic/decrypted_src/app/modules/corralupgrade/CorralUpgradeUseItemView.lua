------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/05/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local CorralUpgradeUseItemView = class("CorralUpgradeUseItemView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 429
local COM_HEIGHT = 287

function CorralUpgradeUseItemView:ctor()
    CorralUpgradeUseItemView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    
    self._needConsumeCystal = 0
end

function CorralUpgradeUseItemView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.corralupgrade", "CorralUpgrade", false)
    CorralUpgradeUseItemView.super.init(self, ... )
end

function CorralUpgradeUseItemView:dtor()
    CorralUpgradeUseItemView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.corralupgrade.CorralUpgradeUseItemView")
end


function CorralUpgradeUseItemView:onInitView()
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

    local titleText = UI.Text:create()
    titleText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(10)
    titleText:setWidth(320)
    titleText:setTextCenter()
    titleText:autoAdapt()
    contentBg:addChild(titleText)

    local contentText = UI.Text:create()
    contentText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    contentText:center(0,13)
    contentText:setWidth(320)
    contentText:setTextCenter()
    contentText:autoAdapt()
    contentBg:addChild(contentText)

    local pk = RoleDataManager:getMaster():getPK()
    local itemDatas = mvc.corralUpgradeModel:getItemData()
    local cfg = ConfigManager:getPetSiteByID(itemDatas.siteId)
    if itemDatas and itemDatas.requireItemData and cfg then
        local costItemData = itemDatas.requireItemData.itemData
        local costItemNum =  tonumber(itemDatas.requireItemData.itemNum)
        local costItemName = languageManagerInstance:getLocalString(costItemData.name)
        local costItemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, costItemData.ID)

        
        local titleStr = string.format(UI.TEXT_228103, costItemNum, costItemName)
        local contentStr = ""
        if costItemTotalNum < costItemNum then
            local differenceNum = costItemNum - costItemTotalNum
            local needConsumeCystal = differenceNum * cfg.requiredItemCostCystal
            contentStr = string.format(UI.TEXT_228104, needConsumeCystal, differenceNum, costItemName)
        end
        titleText:setText(titleStr)
        contentText:setText(contentStr)

        if contentStr == "" then
            titleText:center()
            titleText:setWidth(320)
            titleText:setTextCenter()
            titleText:autoAdapt()
        end

        --右上货币展示
        local rightUpLayout = UI.Layout:create();
        rightUpLayout:init()
        rightUpLayout:enableAutoWidth()
        rightUpLayout:rightUp(40,18)
        bg:addChild(rightUpLayout)

        local materialNumText = UI.Text:create()
        materialNumText:init(tostring(costItemTotalNum), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        materialNumText:floatRight(3)
        rightUpLayout:addComponent(materialNumText)

        local miniIcon = costItemData.miniIcon
        local iconImage = UI.Image:create()
        iconImage:init(miniIcon)
        iconImage:setScale(0.8)
        iconImage:floatRight(3)
        rightUpLayout:addComponent(iconImage)

        --按钮
        local cancelBtn = UI.Button:create();
        cancelBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
        cancelBtn:centerBottom(30, -97)
        cancelBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        cancelBtn:setText(UI.TEXT_110012)
        cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.cancelAction)
        cancelBtn:setScale(0.8)
        contentLayout:addChild(cancelBtn)

        local shopBtn = UI.Button:create();
        shopBtn:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
        shopBtn:centerBottom(30, 97)
        shopBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        shopBtn:setText(UI.TEXT_228100)
        shopBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.shopAction)
        shopBtn:setScale(0.8)
        contentLayout:addChild(shopBtn)

        local rightLayout = UI.Layout:create()
        rightLayout:init()
        rightLayout:enableAutoWidth()
        rightLayout:centerBottom(86, 103)
        contentLayout:addChild(rightLayout)

        local costLabel = UI.Text:create()
        costLabel:init(UI.TEXT_1170025, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costLabel:floatLeft(5)
        rightLayout:addComponent(costLabel)

        if costItemTotalNum > 0 then
            local useNum = costItemNum - costItemTotalNum
            if useNum > 0 then
                useNum = costItemTotalNum
            else
                useNum = costItemNum
            end

            local useItemIcon = UI.Image:create()
            useItemIcon:init("symbol_gaming_207180.png")
            useItemIcon:floatLeft(3)
            rightLayout:addComponent(useItemIcon)

            local costLabel2 = UI.Text:create()
            costLabel2:init(tostring(useNum), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            costLabel2:floatLeft(3)
            rightLayout:addComponent(costLabel2)

            
        end

        if costItemTotalNum < costItemNum then

            if costItemTotalNum > 0 then
                local costLabel3 = UI.Text:create()
                costLabel3:init(UI.TEXT_228105, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                costLabel3:floatLeft(3)
                rightLayout:addComponent(costLabel3)
            end

            local differenceNum = costItemNum - costItemTotalNum
            local needConsumeCystal = differenceNum * cfg.requiredItemCostCystal
            self._needConsumeCystal = needConsumeCystal

            local crystalIcon = UI.Image:create()
            crystalIcon:init("symbol_gaming_diamond.png")
            crystalIcon:floatLeft(3)
            rightLayout:addComponent(crystalIcon)

            local costLabel4 = UI.Text:create()
            costLabel4:init(tostring(needConsumeCystal), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            costLabel4:floatLeft(3)
            rightLayout:addComponent(costLabel4)
        end

    end

end

function CorralUpgradeUseItemView:cancelAction()
    mvc.closePanel("CorralUpgrade", "CorralUpgradeUseItem")
end

function CorralUpgradeUseItemView:shopAction()
    local itemDatas = mvc.corralUpgradeModel:getItemData()
    local costItemData = itemDatas.requireItemData.itemData

    local useGoodsData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, costItemData.ID, false, 0)
    if(useGoodsData) then
        if useGoodsData:getIsLock() then
            UI.ScrollBar:createByText(UI.TEXT_110030)
            return
        end
    end

    if tonumber(GameDataManager:getInstance():getDiamond()) < self._needConsumeCystal then
        UI.TipsLayer:onDiamondNotEnough()
        return
    end
    
    if itemDatas.siteId then
        Net.NetPetSystem:upgradePetSite(itemDatas.siteId, false, 2)
    end

    mvc.closePanel("CorralUpgrade", "CorralUpgradeUseItem")
end


function CorralUpgradeUseItemView:bindModel()

end


function CorralUpgradeUseItemView:unbindModel()

end





return CorralUpgradeUseItemView













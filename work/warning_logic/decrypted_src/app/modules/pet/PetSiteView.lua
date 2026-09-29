------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2021/10/09
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
-- local ProtobufUtil = require("utils.ProtobufUtil")
local GameDataManager = require("app.game.GameDataManager")
local PetSiteView = class("PetSiteView", UI.BaseWin)

-- 引擎的数据模型和视图
require "app.machine.ShareModel"
require "app.machine.ShareView"
require "app.config.ConfigManager"

require "app.modules.pet.PetMainListCell"

UI = UI or {}

UI.PetSiteView = PetSiteView

-- 资源
local COM_RES_LIST = {
    "ui_town_gem.plist",
    "ui_package_roleTalent.plist"
}

local COM_WIDTH = 425
local COM_HEIGHT = 500

function PetSiteView:ctor()
    PetSiteView.super.ctor(self, UI.Type.PET_SITE, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
    self.draggedPetsGrid = nil
    self.removePetId = nil
    self.inputPets = {}
    self.petSiteCfg = {}
end

function PetSiteView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetSiteView.super.init(self, ...)
end

function PetSiteView:dtor()
    self.netBlocking = false
    self.draggedPetsGrid = nil
    self.removePetId = nil
    self.inputPets = {}
    self.petSiteCfg = {}
    PetSiteView.super.dtor(self)
    self:unbindModel()

    

    reload_script_file_mvc("app.modules.pet.PetSiteView")
end

function PetSiteView:onEnter()
    PetSiteView.super.onEnter(self);
end

function PetSiteView:onExit()
    PetSiteView.super.onExit(self);
end

function PetSiteView:onInitView()
    self.targetPetData = nil
    self.petSiteCfg = ConfigManager:getPetSiteData()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_pets_merge_rightpage_02.png")
    bg:centerUp(35)
    self.bg = bg
    self.contentLayout:addChild(bg)

    -- local bgEff = UI.Animation:create()
    -- bgEff:init("effect_ui_town_pet_target_bg.json", "effect_ui_town_pet_target_bg.atlas", 1)
    -- bgEff:leftUp(215, 168)
    -- self.contentLayout:addChild(bgEff)
    -- self.targetBGEff = bgEff

    -- 黄金
    local momeyImage = UI.Image:create()
    momeyImage:init("symbol_gaming_money.png")
    momeyImage:leftUp(76, 10)
    self.contentLayout:addChild(momeyImage, 4)
    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._momey:setTextLeft()
    self._momey:centerLeft(momeyImage:getContentSize().width + 4)
    momeyImage:addChild(self._momey, 4)


    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_gaming_diamond.png")
    diamondImage:leftUp(220, 10)
    self.contentLayout:addChild(diamondImage, 4)
    -- 钻石数量
    self._diamond = UI.Text:create()
    self._diamond:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._diamond:setTextLeft()
    -- self._diamond:leftUp(220 + 28, curreyY)
    self._diamond:centerLeft(diamondImage:getContentSize().width + 4)
    diamondImage:addChild(self._diamond, 4)

    local shopButton = UI.Button:create()
    shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, 1, nil,
            PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_Bag)
    end)
    shopButton:rightUp(43 + 3, 0)
    self.contentLayout:addChild(shopButton, 4)

    local petNameTxt = UI.Text:create()
    petNameTxt:init(UI.TEXT_1213621, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_190_190_190)
    petNameTxt:setWidth(300)
    petNameTxt:setTextCenter()
    petNameTxt:autoAdapt()
    petNameTxt:leftUp(58, 47)
    self.contentLayout:addChild(petNameTxt)
    self.petNameTxt = petNameTxt

    local centerImg1 = UI.Image:create()
    centerImg1:init("ui_pets_round.png")
    centerImg1:centerUp(126)
    self.contentLayout:addChild(centerImg1, 10)

    -- 队长拖拽判定框
    local targetCheckLayer = UI.Layout:create()
    targetCheckLayer:init()
    targetCheckLayer:setSize(116, 116)
    targetCheckLayer:centerUp(125)
    -- targetCheckLayer:enableDebugDraw()
    self.contentLayout:addChild(targetCheckLayer, 100)
    self.targetCheckLayer = targetCheckLayer

    local centerImg2 = UI.Image:create()
    centerImg2:init("ui_gem_box_colorful.png")
    centerImg2:center()
    centerImg1:addChild(centerImg2)

    local centerImg3 = UI.Image:create()
    centerImg3:init("ui_pets_merge_box.png")
    centerImg3:center()
    centerImg1:addChild(centerImg3)
    self.centerImg = centerImg3

    -- 左边队员拖拽判定框
    local petSite1 = UI.Layout:create()
    petSite1:init()
    petSite1:setSize(116, 116)
    petSite1:leftBottom(40, 210)
    petSite1:setName("petSite1")
    -- petSite1:setTag(101)
    self.contentLayout:addChild(petSite1)
    self.petSite1 = petSite1

    local leftImg3 = UI.Image:create()
    leftImg3:init("ui_pets_merge_box.png")
    leftImg3:center()
    petSite1:addChild(leftImg3)
    self.leftImg3 = leftImg3

    -- 右边队员拖拽判定框
    local petSite2 = UI.Layout:create()
    petSite2:init()
    petSite2:setSize(116, 116)
    petSite2:rightBottom(40, 210)
    petSite2:setName("petSite2")
    -- petSite2:setTag(102)
    self.contentLayout:addChild(petSite2)
    self.petSite2 = petSite2

    local rightImg3 = UI.Image:create()
    rightImg3:init("ui_pets_merge_box.png")
    rightImg3:center()
    petSite2:addChild(rightImg3)
    self.rightImg3 = rightImg3

    local leftSiteButton = UI.Button:create()
    leftSiteButton:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png", cc.p(0,0), 0.6)
    leftSiteButton:setText(UI.TEXT_221000)
    leftSiteButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    leftSiteButton:leftBottom(25, 173)
    self.contentLayout:addChild(leftSiteButton)
    leftSiteButton:setName("leftSiteButton")
    

    local rightSiteButton = UI.Button:create()
    rightSiteButton:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_2.png", cc.p(0,0), 0.6)
    rightSiteButton:setText(UI.TEXT_221000)
    rightSiteButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    rightSiteButton:rightBottom(25, 173)
    self.contentLayout:addChild(rightSiteButton)
    rightSiteButton:setName("rightSiteButton")
    
    local siteStarBg1  = UI.Image:create()
    siteStarBg1:init("ui_pets_bg_01.png")
    siteStarBg1:leftBottom(58, 211)
    -- siteStarBg1:setName("siteStarBg1")
    self.contentLayout:addChild(siteStarBg1, 100)
    self.siteStarBg1 = siteStarBg1

    local starTxt1 = UI.Text:create()
    starTxt1:init(UI.TEXT_221005, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_193_193_193)
    starTxt1:setName("starTxt")
    siteStarBg1:addChild(starTxt1, 100)
    starTxt1:center()
    self.starTxt1 = starTxt1

    local siteStar1  = UI.Image:create()
    siteStar1:init("ui_pets_box_star.png")
    siteStar1:floatLeft(0)
    siteStar1:setName("siteStar1")
    self.siteStar1 = siteStar1
    siteStarBg1:addChild(siteStar1, 100)

    local siteStarBg2  = UI.Image:create()
    siteStarBg2:init("ui_pets_bg_01.png")
    siteStarBg2:rightBottom(58, 211)
    -- siteStarBg2:setName("siteStarBg2")
    self.contentLayout:addChild(siteStarBg2, 100) 
    self.siteStarBg2 = siteStarBg2

    local starTxt2 = UI.Text:create()
    starTxt2:init(UI.TEXT_221005, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_193_193_193)
    starTxt2:setName("starTxt")
    starTxt2:setTag(0xAc)
    self.siteStarBg2:addChild(starTxt2, 100)
    starTxt2:center()
    self.starTxt2 = starTxt2

    local siteStar2  = UI.Image:create()
    siteStar2:init("ui_pets_box_star.png")
    siteStar2:floatLeft(0)
    siteStar2:setName("siteStar2")
    self.siteStarBg2:addChild(siteStar2, 100)
    self.siteStar2 = siteStar2

    local coverBg = UI.Image:create()
    coverBg:init("ui_pets_merge_rightpage_up.png")
    coverBg:leftBottom(22, 5)
    -- self.coverBg = coverBg
    self.contentLayout:addChild(coverBg, 300)
    
    self:updateLayer()
    self:updateTeamAttr()
    self:updatePowerShow()
    self:updateMoneyView()
end

function PetSiteView:updateLayer()
    local cfg = ConfigManager:getPetSiteByID(1)
    local costTypeList = cfg.raiseLevelCostType:split(";")
    local maxStars = #costTypeList
    local siteList = MasterDataManager:getSitesData()
    local leftSiteButton = self.contentLayout:getChildByName("leftSiteButton")
    local rightSiteButton = self.contentLayout:getChildByName("rightSiteButton")

    if not siteList[1] or not siteList[1].siteId then
        self.siteStar1:setVisible(false)

        if not self.petSite1:getChildByName("lockFrame") then
            local lockFrame1  = UI.Image:create()
            lockFrame1:init("ui_talent_btn_lock.png")
            lockFrame1:center()
            lockFrame1:setName("lockFrame")
            self.petSite1:addChild(lockFrame1)
        end
        
        leftSiteButton:removeEventListenerByName(UIEvent.BUTTON_CLICK)
        leftSiteButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:unlockPetSite(1)
        end)
        rightSiteButton:disable()
    else
        local siteStar1 = self.siteStarBg1:getChildByName("siteStar1")
        if siteStar1 then 
            siteStar1:setVisible(true)
        end
        
        local star = siteList[1].stars or 0
        -- print("self.starTxt1 is:", self.starTxt1)
        -- dump(self.starTxt1, "self.starTxt1")
        local starTxt1 = self.siteStarBg1:getChildByName("starTxt")
        starTxt1:setText(string.format(UI.TEXT_221003, star))

        leftSiteButton:removeEventListenerByName(UIEvent.BUTTON_CLICK)
        leftSiteButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:upgradePetSite(1)
        end)
       
        leftSiteButton:setText(UI.TEXT_221001)
        
        if siteList[1].stars == maxStars then
            leftSiteButton:disable()
        else
            rightSiteButton:enable()
        end
    end
    if not siteList[2] or not siteList[2].siteId then
        self.siteStar2:setVisible(false)  
        if not self.petSite2:getChildByName("lockFrame") then
            local lockFrame2  = UI.Image:create()
            lockFrame2:init("ui_talent_btn_lock.png")
            lockFrame2:center()
            lockFrame2:setName("lockFrame")
            self.petSite2:addChild(lockFrame2)
        end
        rightSiteButton:removeEventListenerByName(UIEvent.BUTTON_CLICK)
        rightSiteButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:unlockPetSite(2)
        end)
    else
        if self.siteStar2 then
            self.siteStar2:setVisible(true)
        end
        local starTxt2 = self.siteStarBg2:getChildByName("starTxt")
        local starTxt = self.siteStarBg2:getChildByTag(0xAc)
        local star = siteList[2].stars or 0
        starTxt2:setText(string.format(UI.TEXT_221003, star))

        rightSiteButton:removeEventListenerByName(UIEvent.BUTTON_CLICK)
        rightSiteButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:upgradePetSite(2)
        end)
        if siteList[2].stars == maxStars then
            rightSiteButton:disable()
        end
        rightSiteButton:setText(UI.TEXT_221001)
    end

    -- local captain = MasterDataManager:getCaptainPet()
    -- local captain = RoleDataManager:getCaptain()
    local captain = MasterDataManager:getCaptainPet()
    local TargetSlot = self.targetCheckLayer:getChildByName("TargetSlot")
    if TargetSlot then
        TargetSlot:removeFromParent()
    end
    if captain then
        local captainPet = UI.PetMainListCell:create()
        captainPet:init(captain.petInstId)
        -- targetPet:leftUp(177, 131)
        captainPet:center()
        captainPet:setName("TargetSlot")
        self.targetCheckLayer:addChild(captainPet, 100)
        -- dump(captainPet, "getCaptainPet1111")
        -- print("captainPet.petInstId", captain.petInstId)
        self:updateInputPets(tostring(captain.petInstId), 0)
        performWithDelay(
            self,
            function() 
                self:updatePetLayer(self.inputPets)
            end,
            0
        )
        
    end

    local fightPet = RoleDataManager:getScreenFightPetData()

    if fightPet and #fightPet>1 then
        for k, v in ipairs(fightPet) do
            if v.siteId == 1 and v.petInstId then
                self:addTargetPet(v.petInstId, self.petSite1, 1)
                self:updateInputPets(tostring(v.petInstId), v.siteId)
                performWithDelay(
                    self,
                    function() 
                        self:updatePetLayer(self.inputPets)
                    end,
                    0
                )
            end
            if v.siteId == 2 and v.petInstId then
                self:addTargetPet(v.petInstId, self.petSite2, 2)
                self:updateInputPets(tostring(v.petInstId), v.siteId)
                performWithDelay(
                    self,
                    function() 
                        self:updatePetLayer(self.inputPets)
                    end,
                    0
                )
            end
            
        end
    end
end

function PetSiteView:updateTeamAttr()
    local title = UI.Text:create()
    title:init("队伍属性", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_193_193_193)
    title:leftBottom(30, 123)
    title:setTextCenter()
    title:autoAdapt()
    self.bg:addChild(title)

    local descText1 = UI.Text:create()
    descText1:init("龙之力: 3只龙属性宠物同时上阵，所以宠物物理攻击提高%15(未激活)", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_45_44_48)
    descText1:leftBottom(40, 70)
    descText1:setTextVerticalCenterAndHLeft()
    descText1:autoAdapt()
    descText1:setSize(340, 50)
    self.bg:addChild(descText1)

    local descText2 = UI.Text:create()
    descText2:init("童心: 3只龙属性宠物同时上阵，所以宠物物理攻击提高%15(未激活)", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_220_185_117)
    descText2:leftBottom(40, 10)
    descText2:setTextVerticalCenterAndHLeft()
    descText2:autoAdapt()
    descText2:setSize(340, 50)
    self.bg:addChild(descText2)
end

function PetSiteView:updatePetSiteState(data)
    local petSite = self.contentLayout:getChildByName("petSite"..data.siteId)

    -- local petSite = self.contentLayout:getChildByTag(100+data.siteId)
    petSite:getChildByName("lockFrame"):setVisible(false)
    
    local btn = nil
    if data.siteId == 1 then
        btn = self.contentLayout:getChildByName("leftSiteButton")
    elseif data.siteId == 2 then
        btn = self.contentLayout:getChildByName("rightSiteButton")
    end

    if btn then
        btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:upgradePetSite(data.siteId)
        end)
    end
    local list = data
    -- list[data.siteId] = data
    -- list[data.siteId].stars = 0
    list.stars = 0
    list.petId = 0
    MasterDataManager:resetSiteData(list)
    -- btn:setText(UI.TEXT_221001)
    self:updateChild()
end

function PetSiteView:updateChild()
    UI.ScrollBar:createByText(UI.TEXT_221018)
    Avalon.MessageCenter:notice(GameMessage.MC_COMMON_SHOW_PET)
    self:updateLayer()
end

function PetSiteView:petTakeOutResult(data)
    -- local target = self.contentLayout:getChildByName("petSite"..data.siteId)
    -- if target:getChildByName("TargetSlot") then
    --     target:getChildByName("TargetSlot"):removeFromParent()
    -- end
    -- dump(data, "petTakeOutResult")
    -- print("petTakeOutResult str", data.siteId, ProtobufUtil:checkFieldIsInit(data, "petId"))
    -- local Machine = Machine.ShareMachine
    -- dump(Machine, "Machine.ShareMachine")
    if data.siteId and data.petId ~= 0 then
        local petSite = self.contentLayout:getChildByName("petSite"..data.siteId)
        self:addTargetPet(data.petId, petSite, data.siteId)
        -- table.insert(self.inputPets, data.petId)
        self:updateInputPets(tostring(data.petId), data.siteId)
        self:updatePetLayer(self.inputPets)
        -- MasterDataManager:resetSiteData(data)
    end
    -- print("removeFightPet", self.removePetId)
    if data.petId == 0 then
        local petData = RoleDataManager:getScreenPetDataByInsId(self.removePetId)
        local masterPet = MasterDataManager:getFightPetbyId(self.removePetId)
        -- local petData = MasterDataManager:getBagPetById(self.removePetId)
        -- local bagPet = MasterDataManager:getBagPetById(self.removePetId)
        
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        local master = machine._model:getMaster()
        -- local allPets = machine._model:getAllPet()
        -- for k, v in pairs(allPets) do
        --     -- print("RoleDataManager:getScreenPetDataByID:", RoleDataManager:getScreenPetDataByID(v:getSpriteID()), v:getSpriteID())
        --     print("get id :", v:getPK(), petData:getPK())
        --     if v:getType() == RoleType.Pet and v:getMaster() ~= nil and v:getMaster():getSpriteID() == petData:getMasterSpriteID() and RoleDataManager:getScreenPetDataByID(v:getSpriteID()) and petData:getPK() == v:getPK() then
        --         -- local coord = v:getCoord()
        --         -- pet:setCoord(coord.x, coord.y, coord.z)
        --         -- local Machine = Machine.ShareMachine
        --         -- 停止所有的效果
        --         machine._actionTrack:clearActionForEntryId(v:getId())
        --         -- 移除所有buffer
        --         machine:_clearAllBufferForRole(v)
        --         machine._view:removeView(v, true)
        --         machine._model:removeModel(v)
        --         break
        --     end
        -- end
        -- bagPet:setReadyFight(false)
        -- petData:setReadyFight(false)
        if petData then
            RoleDataManager:removeFightPet(petData)
        end
        if masterPet then
            MasterDataManager:removeFightPet(masterPet)
            
        end
        if petData and master then
            master:removeFightPet(petData)
        end
        
        self.removePetId = nil
        -- local list = {}
        -- list[data.siteId] = data
        -- MasterDataManager:resetSiteData(data)
    end
    -- self:updateTypeIcon()
    -- self:updateStarShow()
    -- self:updateView()
    MasterDataManager:resetSiteData(data)
    self:updatePowerShow()
    Avalon.MessageCenter:notice(GameMessage.MC_COMMON_SHOW_PET)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_READY_FIGHT_OK)
end

function PetSiteView:upgradePetSiteResult(data)
    MasterDataManager:resetSiteData(data, true)
    UI.ScrollBar:createByText(UI.TEXT_221008)
    self:updateLayer()
end

function PetSiteView:updateStarShow()
    local starLayout = self.contentLayout:getChildByName("StarLayout")
    if starLayout then
        self.contentLayout:removeChildByName("StarLayout")
    end

    -- 星级
    local starLv, canLvUpNum = self.targetPetData:getStarLv()
    printInfo("starLv = " .. starLv .. " canLvUpNum = " .. canLvUpNum)
    if starLv > 0 or canLvUpNum > 0 then
        local starLayout = UI.Layout:create()
        starLayout:init()
        starLayout:setSize(220, 30)
        starLayout:leftUp(100, 52)
        starLayout:setName("StarLayout")
        self.contentLayout:addChild(starLayout, 2)

        local starAutoLayer = UI.Layout:create()
        starAutoLayer:init()
        starAutoLayer:center()
        starAutoLayer:enableAutoWidth()
        starAutoLayer:enableAutoHeight()
        -- starAutoLayer:enableDebugDraw()
        starLayout:addChild(starAutoLayer, 20)

        for i = 1, starLv do
            local starImg = UI.Image:create()
            starImg:init("symbol_character_hero_power.png")
            starImg:floatLeft(-2)
            starAutoLayer:addComponent(starImg)
        end

        for i = 1, canLvUpNum do
            local starImg = UI.Image:create()
            starImg:init("symbol_character_hero_power_0.png")
            starImg:floatLeft(-2)
            starAutoLayer:addComponent(starImg)

            local starEff = UI.Animation:create()
            starEff:init("effect_ui_town_pet_star.json", "effect_ui_town_pet_star.atlas", 1)
            starEff:center()
            starEff:setName("StarEff")
            starEff:hide()
            starImg:addChild(starEff, 10)

            if i == 1 then
                self.lvupStarImg = starImg
            end
        end
    end
end

function PetSiteView:unlockPetSite(siteId)
    local SceneManager = require("app.game.SceneManager")
    if SceneManager:getInstance():isInFightScene() then
        UI.ScrollBar:createByText(UI.TEXT_221011)
        return
    end

    local cfg = ConfigManager:getPetSiteByID(siteId)
    -- "ConfigManager" = {
        --     "ID"                 = 1
        --     "raiseLevelCostNum"  = "1,500;1,500;1,500;1,500;1,500;1,500;1,500;1,500"
        --     "raiseLevelCostType" = "22010195,23030001;22010195,23030001;22010195,23030001;22010195,23030001;22010195,23030001;22010195,23030001;22010195,23030001;22010195,23030001"
        --     "unlockCostNum"      = 200
        --     "unlockCostType"     = 23030001
        --     "unlockLevel"        = 25
        -- }
    local heroData = RoleDataManager:getMaster()
    if heroData:getLevel()< cfg.unlockLevel then
        UI.ScrollBar:createByText(string.format(UI.TEXT_221012, cfg.unlockLevel))
        return
    end

    local costData = ConfigManager:getVirtualItemConfigByID(cfg.unlockCostType)
    local tips = UI.Tips:createTips(
        string.format(UI.TEXT_221002, cfg.unlockCostNum,costData.name),
        UI.TipsType.CONFIRM_AND_CANCEL,
        UI.TipsUiType.NORMAL
    )

    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
        if GameDataManager:getInstance():getDiamond() < cfg.unlockCostNum then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
        
        Net.NetPetSystem:unlockPetSite()
    end)
end

function PetSiteView:upgradePetSite(siteId)
    -- print("upgradePetSite:", siteId)
    local SceneManager = require("app.game.SceneManager")
    if SceneManager:getInstance():isInFightScene() then
        UI.ScrollBar:createByText(UI.TEXT_221011)
        return
    end
    
    local siteList = MasterDataManager:getSitesData()

    local cfg = ConfigManager:getPetSiteByID(siteId)
    local costTypeList = cfg.raiseLevelCostType:split(";")
    local costTypeNumList = cfg.raiseLevelCostNum:split(";")
    local costCrystalList = cfg.raiseLevelCostCystal:split(";")
    local costItemIdList = cfg.requiredItemId:split(";")--string.split(cfg.requiredItemId, ";")
    local costItemNumList = cfg.requiredItemNum:split(";")

    local costTypeCfg = {}
    local costTypeNumCfg = {}
    local requireItemData = {}
    
    if costTypeList and costTypeNumList and siteList[siteId] then
        costTypeCfg = costTypeList[siteList[siteId].stars+1]
        costTypeNumCfg = costTypeNumList[siteList[siteId].stars+1]

        local itemId = tonumber(costItemIdList[siteList[siteId].stars+1])
        requireItemData.itemData = ConfigManager:getMaterialConfigByID(itemId) or ConfigManager:getVirtualItemConfigByID(itemId)
        requireItemData.itemNum = tonumber(costItemNumList[siteList[siteId].stars+1])
    end
    local costType = costTypeCfg:split(",")
    local costTypeNum = costTypeNumCfg:split(",")

    local itemData = {}
    local materialata = {}
    
    for k, v in pairs(costType) do
        materialata[k] = ConfigManager:getMaterialConfigByID(tonumber(v)) or ConfigManager:getVirtualItemConfigByID(tonumber(v))
        materialata[k].num = costTypeNum[k]
    end


    itemData.materialata = materialata
    itemData.crystal = costCrystalList[siteList[siteId].stars+1]
    itemData.requireItemData = requireItemData
    local cancelCB = function()
        Net.NetPetSystem:upgradePetSite(siteId, false, 0)
    end
    local okCB = function() 
        local tips = UI.Tips:createTips(
            string.format(UI.TEXT_221017, costCrystalList[siteList[siteId].stars+1]),
            UI.TipsType.CONFIRM_AND_CANCEL,
            UI.TipsUiType.NORMAL
        )
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            if tonumber(GameDataManager:getInstance():getDiamond()) < tonumber(costCrystalList[siteList[siteId].stars+1]) then
                UI.TipsLayer:onDiamondNotEnough()
                return
            end
            Net.NetPetSystem:upgradePetSite(siteId, true, 1)
        end)
    end

    local pk = RoleDataManager:getMasterPK()
    local costItemData = requireItemData.itemData
    local costItemNum = requireItemData.itemNum
    local costItemName = languageManagerInstance:getLocalString(costItemData.name)
    local costItemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, costItemData.ID)
    local extCB = function() 
        local tips = UI.Tips:createTips(
            string.format(UI.TEXT_221019, costItemNum..costItemName),
            UI.TipsType.CONFIRM_AND_CANCEL,
            UI.TipsUiType.NORMAL
        )
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            local useGoodsData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, costItemData.ID, false, 0)
            if(useGoodsData) then
                if useGoodsData:getIsLock() then
                    UI.ScrollBar:createByText(UI.TEXT_110030)
                    return
                end
            end
            
            if costItemTotalNum < costItemNum then
                UI.ScrollBar:createByText(UI.TEXT_221020)
                return
            end
            Net.NetPetSystem:upgradePetSite(siteId, false, 2)
        end)
    end

    -- UI.TipsLayer:onItemsCost(itemData,okCB, cancelCB, nil, extCB)

    --CO-22115
    --兽栏-允许铲子与水晶同时使用【客户端】
    -- 新的兽栏升级界面
    itemData.siteId = siteId
    mvc.corralUpgradeModel:setItemData(itemData)
    mvc.openPanel("CorralUpgrade", "CorralUpgrade")

end

function PetSiteView:updatePowerShow()
    local layout = self.contentLayout:getChildByName("PowerLayout")
    if layout then
        self.contentLayout:removeChildByName("PowerLayout")
    end

    local powerLayout = UI.Layout:create();
    powerLayout:init()
    powerLayout:enableAutoWidth()
    powerLayout:enableAutoHeight()
    powerLayout:setName("PowerLayout")
    powerLayout:setSize(200, 50)
    self.contentLayout:addChild(powerLayout, 110)


    local starImg = UI.Image:create()
    starImg:init("ui_information_equip.png")
    starImg:floatLeft(0)
    powerLayout:addComponent(starImg)

    local siteList = MasterDataManager:getSitesData()
    local captain = RoleDataManager:getCaptain()
    -- local captain = MasterDataManager:getCaptainPet()
    -- dump(captain, "MasterDataManagercaptain")
    local power = MasterDataManager:getBagPetById(captain:getPetInstId()):getPower()
    for k, v in pairs(siteList) do
        -- dump(v, "MasterDataManagercaptain11")
        if v.petId and v.petId ~= 0 then
            power = power + MasterDataManager:getBagPetById(v.petId):getPower()
        end
    end
    local powerTxt = UI.Text:create()
    powerTxt:init(powerTxt:numformat(tostring(power)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
    powerTxt:floatLeft(4)
    powerLayout:addComponent(powerTxt)
    powerLayout:centerUp(85)
end

function PetSiteView:slotDragEnd(petID, x, y)
    if self.playingEff then
        return
    end

    if not self:isVisible() then
        return
    end

    if mvc.dockModel:checkPetIsSailing(petID) then
        UI.ScrollBar:createByText(UI.TEXT_221932)
        return
    end

    -- target check
    local pos = self.targetCheckLayer:convertToNodeSpace(cc.p(x, y))
    local size = self.targetCheckLayer:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        UI.ScrollBar:createByText(UI.TEXT_221014)
        return
    end
    local pos = self.petSite1:convertToNodeSpace(cc.p(x, y))
    local size = self.petSite1:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        -- print("check pet id:", petID)
        -- self:addTargetPet(petID, self.petSite1,1) 
        -- self:updatePetLayer(petID)
        local siteId = 1
        local petData = MasterDataManager:getBagPetById(petID)
        local siteList = MasterDataManager:getSitesData()
        if not siteList[siteId] or not siteList[siteId].stars then
            UI.ScrollBar:createByText(UI.TEXT_221013)
            return
        end
        if petData:getStarLv() > siteList[siteId].stars then
            UI.ScrollBar:createByText(UI.TEXT_221009)
            return
        end
        Net.NetPetSystem:petSiteTakeOut({siteId = siteId, petId = petID})
    end

    local pos = self.petSite2:convertToNodeSpace(cc.p(x, y))
    local size = self.petSite2:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        local siteId = 2
        local petData = MasterDataManager:getBagPetById(petID)
        local siteList = MasterDataManager:getSitesData()
        if not siteList[siteId] or not siteList[siteId].stars then
            UI.ScrollBar:createByText(UI.TEXT_221013)
            return
        end
        if petData:getStarLv() > siteList[siteId].stars then
            UI.ScrollBar:createByText(UI.TEXT_221009)
            return
        end
        Net.NetPetSystem:petSiteTakeOut({siteId = siteId, petId = petID})
    end
end

function PetSiteView:addTargetPet(petID, node, siteId)
    print("addTargetPet: ",petID, siteId)
    self.targetPetData = MasterDataManager:getBagPetById(petID)
    if siteId ~= 0 then
        self.targetPetData:setReadyFight(true)
    end
    
    -- local starLv, canLvUpNum = self.targetPetData:getStarLv()
    -- if canLvUpNum > 0 then
    --     local conditions = string.split(self.targetPetData.combineLimit, ";")
    --     local con = string.split(conditions[starLv + 1], ",")
    --     self.materialTotalNum = tonumber(con[2])
    -- end

    local targetSlot = node:getChildByName("TargetSlot")
    if targetSlot then
        node:removeChildByName("TargetSlot")
    end

    local targetPet = UI.PetMainListCell:create()
    targetPet:init(petID, nil, nil, nil, nil, siteId)
    -- targetPet:leftUp(177, 131)
    targetPet:center()
    targetPet:setName("TargetSlot")
    node:addChild(targetPet, 100)
    self.targetPet = targetPet

    targetPet:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self.onTargetPetTouchBegin)
    targetPet:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onTargetPetTouchMove) 
    targetPet:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onTargetPetTouchEnd)
end

function PetSiteView:onTargetPetTouchBegin(com, touchPosition)
    self:clearDragGrid()
    self.draggedPetsGrid = com:createDraggedView()
    
    if (self.draggedPetsGrid) then
        self.contentLayout:addChild( self.draggedPetsGrid, UI.MAX_Z_ORDER)
        -- com:setZOrder(101)
        local pos = self.contentLayout:convertToNodeSpace(touchPosition)
        local size = com:getContentSize()
        local x = pos.x - size.width / 2
        local y = pos.y - size.height / 2
        self.draggedPetsGrid:setPosition(cc.p(x, y ))
    end
end

function PetSiteView:onTargetPetTouchMove(com, touchPosition)
    
    if (self.draggedPetsGrid) then
        -- self.contentLayout:addChild( self.draggedPetsGrid, UI.MAX_Z_ORDER)
        -- com:setZOrder(101)
        local pos = self.contentLayout:convertToNodeSpace(touchPosition)
        local size = com:getContentSize()
        local x = pos.x - size.width / 2
        local y = pos.y - size.height / 2
        self.draggedPetsGrid:setPosition(cc.p(x, y ))
    end
end


function PetSiteView:onTargetPetTouchEnd(com, touchPosition)
    com:setZOrder(100)

    local pos = com:convertToNodeSpace(touchPosition)
    local size = com:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        com:center()
        self:clearDragGrid()
    else
        local comData = com:getData()
        self.removePetId = comData.petID
        -- comData:setReadyFight(false)
        local petData = MasterDataManager:getBagPetById(self.removePetId)
        petData:setReadyFight(false)
        performWithDelay(
            self,
            function()
                self:updateInputPets(nil, comData.siteId)
                -- Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_SORT_LIST)
                self:updatePetLayer(self.inputPets)
            end,
            0
        )
        
        dump(comData, "comData")
        Net.NetPetSystem:petSiteTakeOut({siteId = comData.siteId, petId = 0})
        self:clearDragGrid()
        com:removeFromParent()
        self.targetPet = nil

        self.petNameTxt:setText(UI.TEXT_1213621)
    end
end

function PetSiteView:updateInputPets(petId, siteId)
    self.inputPets[siteId] = petId
end

function PetSiteView:updatePetLayer(inputPets)
    -- local inputPet = {}
        
    -- inputPet[1] = petID
    -- -- inputPet[1] = petID
    print("self.draggedPetsGrid:getId()", inputPets)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_DRAG_HIDE_SLOT_BEGAIN, inputPets)
end

-- 货币改变
local function onCurrencyChangeHandler(self, data)
    if (data) then
        self:updateMoneyView()
        --  处理金币以及钻石表现
        local text = UI.Text:create()
        text:init("", UI.FONT_ARIAL)
        text:centerBottom(10)

        if(data.value >0 ) then
            text:setFontColor(UI.FONT_COLOR_GREEN)
            text:setText(string.format("+%d",data.value))
        else
            text:setFontColor(UI.FONT_COLOR_RED)
            text:setText(string.format("-%d",math.abs(data.value)))
        end

        if(data.costType == PublicDefine.GOODS_COST_TYPE.GOLD) then
            
            self._momey:addChild(text)
        elseif data.costType == PublicDefine.GOODS_COST_TYPE.GEM then
            
            self._diamond:addChild(text)
        end
        text:updateView()

        if(self._waitingNum == nil) then
            self._waitingNum = 0
        end

        local delayTime = self._waitingNum * 0.5
        if(delayTime < 0) then
            delayTime = 0
        end

        text:setVisible(false)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            if(self and not tolua.isnull(self)) then
                if not text or tolua.isnull(text) then
                    return
                end
                text:setVisible(true)
                text:runAction(cc.Spawn:create(
                    cc.MoveBy:create(0.5,cc.p(0,20)),
                    cc.Sequence:create(cc.DelayTime:create(0.4),
                    cc.FadeOut:create(0.1),cc.RemoveSelf:create(), cc.CallFunc:create(function() 
                        self._waitingNum = self._waitingNum - 1
                    end))))
            end
        end,delayTime)
        self._waitingNum = self._waitingNum + 1
    else
        assert(false)
    end
end

function PetSiteView:updateMoneyView()
    self._momey:setText(self._momey:numformat(string.format("%d",GameDataManager:getInstance():getCurCoin())))
    self._momey:updateView()
    self._diamond:setText(self._diamond:numformat(string.format("%d",GameDataManager:getInstance():getDiamond())))
    self._diamond:updateView()
end

function PetSiteView:updateToShow()
    self.contentLayout:removeChildByName("TargetSlot")
    self.targetPet = nil

    self.petNameTxt:setText(UI.TEXT_1213621)
    -- self.contentLayout:removeChildByName("StarLayout")
    -- self.contentLayout:removeChildByName("TypeIcon")
    -- self.materialCheckLayer:removeAllChildren()

end

-- 清理拖拽对象
function PetSiteView:clearDragGrid()
    if(self.draggedPetsGrid) then
        self.draggedPetsGrid:destroy()
        self.draggedPetsGrid = nil
    end
end

function PetSiteView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_DRAG_PET_SLOT_END, self, self.slotDragEnd)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SITE_UNLOCK_RESULT, self, self.updatePetSiteState)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SITE_UPGRADE_RESULT, self, self.upgradePetSiteResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_SITE_TAKE_OUT_RESULT, self, self.petTakeOutResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
end

function PetSiteView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_DRAG_PET_SLOT_END, self, self.slotDragEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SITE_UNLOCK_RESULT, self, self.updatePetSiteState)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SITE_UPGRADE_RESULT, self, self.upgradePetSiteResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_SITE_TAKE_OUT_RESULT, self, self.petTakeOutResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
end

return PetSiteView

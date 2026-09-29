------------------------------------------------------------------------------
--author: ting.guan
--date	: 2019/10/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetHandbookView = class("PetHandbookView", UI.BaseWin)

require "app.modules.pet.PetHandBookListCell"
require "app.ui.baglayer.Horcurx.SkillTips"

UI = UI or {}

UI.PetHandbookView = PetHandbookView

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_btn.plist",
    "ui_town_deformation.plist",
    "ui_common_scale9image.plist",
}

local COM_WIDTH = 875
local COM_HEIGHT = 522

function PetHandbookView:ctor()
    PetHandbookView.super.ctor(
    	self,
    	UI.Type.PET_HANDBOOK,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.curTabIdx = 1
    self.curFltIdx = 1
    self.lastFltIdx = 1
    self.isFltClick = true
    self.curRankData = {}
    self.petData = {}

    -- 用来判断当前模板是否被选择
    self._select = false

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_RANK_LIST, self, self.getRanks)

end

function PetHandbookView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetHandbookView.super.init(self, ... )
end

function PetHandbookView:dtor()
    PetHandbookView.super.dtor(self)
    self:unbindModel()

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_RANK_LIST, self, self.getRanks)
    reload_script_file_mvc("app.modules.pet.PetHandbookView")
end

function PetHandbookView:initPetData()

    local data = mvc.petModel:getUnlockPets() 
    local petAllList = ConfigManager:getAllPetTemplateData()
    for k, v in ipairs(petAllList) do
        if v.illustrationSerialNumber ~= 0 then
            local onePet = {}
            onePet.bookId = v.illustrationSerialNumber
            onePet.id = v.id
            onePet.icon = string.split(v.icon, ";")[1]
            onePet.petType = v.petType
            onePet.spine = v.spine
            onePet.illustrationoffset = v.illustrationoffset
            onePet.name = v.name
            onePet.skillNum = v.skillNum
            onePet.talentID = v.talentID
            onePet.skillPoolID = v.skillPoolID
            onePet.select = false
            onePet.showQuestion = true
            onePet.petquality = v.petquality


            -- 取表里的数据
            local levelList = string.split(onePet.skillNum, ";")
            local str1 = levelList[1] -- 因为是图鉴，不考虑一转和一转以后的显示。
            local levelList2 = string.split(str1, ",")
            local tableList = {}
            for k,v in pairs(levelList2) do
                table.insert(tableList, tonumber(v))
            end
            onePet.skillNum = tableList

            for i = 1, (#data) do       
                if data[i] == onePet.id then
                    onePet.showQuestion = false   
                    if i == 1 then
                        onePet.select = true
                        self.curPet = onePet
                        Net.NetRankSystem:requestPetRank({self.curPet.id})
                        self.lastGridDataId = self.curPet.bookId   
                    end
                    break
                end
            end
            table.insert(self.petData, onePet)
        end
    end

    if data == nil then
        self.petData[1].select = true
        self.curPet = self.petData[1]
        self.lastGridDataId = self.curPet.bookId   
    end

    -- 排序
    table.sort(self.petData,function(a, b) 
        return a.bookId < b.bookId
    end)    

end

function PetHandbookView:updatePetData()
    local data = mvc.petModel:getUnlockPets() 
    for k, v in ipairs(self.petsList:getGridList()) do
        for i = 1, #(data) do
            if v:getData().id == id then 
                v:getData().showQuestion = false
            end
        end
    end
end

function PetHandbookView:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(1, 7)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_pets_manual_paper.png")
    bg:center()
    self.contentLayout:addChild(bg)

    self:initPetData()
    self:initLeft()
    self:initRight()
    self:updatePetData()

end

function PetHandbookView:initLeft()

    local ZOrder = 0

    -- 内容面板
    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(285, COM_HEIGHT)
    leftLayout:leftUp(0, 0)
    self.contentLayout:addChild(leftLayout, 10)
    self.leftLayout = leftLayout

    -- 筛选器
    local filterBtnLayout = UI.Layout:create()
    filterBtnLayout:init()
    filterBtnLayout:leftUp(33, 15)
    filterBtnLayout:setSize(230, 52)
    self.leftLayout:addChild(filterBtnLayout, 20)

    local filterBtn = UI.Image:create()
    filterBtn:init("ui_deformation_information.png")
    filterBtn:center()
    filterBtn:setImageScale(230 / 287, 52 / 64)
    filterBtn:setImageScaleX(-(230 / 287))
    filterBtnLayout:addChild(filterBtn, ZOrder)
    ZOrder = ZOrder + 1 

    self:initFilter()

    -- 标签
    local filterTxt = UI.Text:create()
    filterTxt:init(UI.TEXT_1213700, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    filterTxt:center(-20, 0)
    filterTxt:setWidth(631)
    filterTxt:setTextCenter()
    filterTxt:autoAdapt()
    filterBtnLayout:addChild(filterTxt, ZOrder)
    self.filterTxt = filterTxt
    ZOrder = ZOrder + 1

    -- 图标
    local btnImage = UI.Image:create()
    btnImage:init("ui_btn_spread_0.png")
    btnImage:leftUp(188, 9)
    btnImage:setTouchEnable(true)
    btnImage:setSwallowTouches(true)
    filterBtnLayout:addChild(btnImage, ZOrder)
    self.btnImage = btnImage
    ZOrder = ZOrder + 1

    self.btnImage:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)

        -- 下拉框
        if self.isFltClick then
            self.btnImage:setSpriteName("ui_btn_spread_1.png")
            self.filterLayout:leftUp(25, 8)
            self.isFltClick = false
        else
            self.filterLayout:leftUp(-10000, -10000)
            self.btnImage:setSpriteName("ui_btn_spread_0.png")
            self.isFltClick = true
            self:updateGridList(self.lastFltIdx)
        end

    end)

    -- 宠物列表
    local petsList = UI.GridList:create()
    petsList:init(UI.PetHandBookListCell, 3, 10, 78, 78, 0, 0, 0)  
    petsList:setData(self.petData)
    petsList:setSize(260, 448)
    petsList:leftUp(16, 70)
    petsList:setScrollBarEnabled(true)
    petsList:setScrollBarColor(UI.SLIDER_COLOR_Light) 
    petsList:setScrollBarWidth(3)
    petsList:setCallbackForGridClick(self, self.clickCallback) 
    self.leftLayout:addChild(petsList)
    self.petsList = petsList
    ZOrder = ZOrder + 1

    -- 底部虚化
    local effectImage = UI.Image:create()
    effectImage:init("ui_pets_manual_mask.png")
    effectImage:rightBottom(0, 5)
    self.leftLayout:addChild(effectImage, 5)

end

-- 筛选框初始化
function PetHandbookView:initFilter()

    self.filter = {}
    local ZOrder = 0
    local text = {
        UI.TEXT_1213700, 
        UI.TEXT_1213629, 
        UI.TEXT_1213630, 
        UI.TEXT_1213631, 
        UI.TEXT_1213632
    }

    -- 筛选下拉框
    local filterLayout = UI.Layout:create()
    filterLayout:init()
    filterLayout:setSize(246, 319)
    filterLayout:leftUp(-10000, -10000)
    self.leftLayout:addChild(filterLayout, 10)
    self.filterLayout = filterLayout

    -- 蒙板
    local hideLayout = UI.Layout:create()
    hideLayout:init()
    hideLayout:setSize(1000, 800)
    hideLayout:leftUp(0, 0)
    hideLayout:setTouchEnable(true)
    hideLayout:setSwallowTouches(true)
    self.filterLayout:addChild(hideLayout, ZOrder)
    self.hideLayout = hideLayout
    ZOrder = ZOrder + 1

    self.hideLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        self.filterLayout:leftUp(-1000, -1000)
        self.btnImage:setSpriteName("ui_btn_spread_0.png")
        self.isFltClick = true
        self:updateGridList(self.lastFltIdx)
    end)

    local filterBg = UI.Image:create()
    filterBg:init("ui_pets_manual_screen_paper.png")
    filterBg:center()
    self.filterLayout:addChild(filterBg, ZOrder)
    ZOrder = ZOrder + 1
    
    for i = 1, 5 do

        local oneFilter = {}
        -- 类型
        local uiLayout = UI.Layout:create()
        uiLayout:init()
        uiLayout:setSize(246, 52)
        uiLayout:centerUp(59 + (i - 1) * 52)
        uiLayout:setTouchEnable(true)
        uiLayout:setSwallowTouches(true)
        self.filterLayout:addChild(uiLayout, ZOrder)
        oneFilter.uiLayout = uiLayout
        ZOrder = ZOrder + 1
        
        -- 标签
        local flag = UI.Text:create()
        flag:init(text[i], UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
        flag:setTextCenter()
        flag:center(-20, 0)
        uiLayout:addChild(flag, ZOrder)      
        oneFilter.flag = flag
        ZOrder = ZOrder + 1

        -- 复选框
        local checkBoxBg = UI.Image:create()
        checkBoxBg:init("ui_btn_choice_0.png")
        checkBoxBg:center(90, 0)
        checkBoxBg:setImageScale(0.7)
        uiLayout:addChild(checkBoxBg, ZOrder)
        ZOrder = ZOrder + 1

        local checkBox = UI.Image:create()
        checkBox:init("ui_btn_choice_0.png")
        checkBox:center(0, 0)
        checkBox:setImageScale(0.7)
        checkBoxBg:addChild(checkBox)
        oneFilter.checkBox = checkBox
        
        -- 分割线
        local line = UI.Image:create()
        line:init("ui_scale9image_banner_line_dark.png")
        line:centerUp(0)
        line:setImageScaleX(75)
        uiLayout:addChild(line, 20)
    
        table.insert(self.filter, oneFilter)
        self.filter[i].uiLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)

            self.curFltIdx = i
            local lastCheckBox = self.filter[self.lastFltIdx].checkBox
            local curCheckBox = self.filter[self.curFltIdx].checkBox
            if self.curFltIdx == self.lastFltIdx then
                return
            else
                lastCheckBox:setImageScale(0.7)    
                lastCheckBox:setSpriteName("ui_btn_choice_0.png")
                curCheckBox:setSpriteName("ui_btn_choice_1.png")  
                curCheckBox:setImageScale(1)    
                self.filterTxt:setText(text[self.curFltIdx])             
                self.lastFltIdx = i
            end
        end)
    end

    local lastCheckBox = self.filter[self.lastFltIdx].checkBox 
    if lastCheckBox then
        lastCheckBox:setSpriteName("ui_btn_choice_1.png") 
        lastCheckBox:setImageScale(1)
    end

end

function PetHandbookView:initRight()

    local ZOrder = 0
    self.curRankIdx = 0

    -- 右上面板
    local upLayout = UI.Layout:create()
    upLayout:init()
    upLayout:setSize(570, 288)
    upLayout:rightUp(0, 0)
    self.contentLayout:addChild(upLayout, 8)
    self.upLayout = upLayout
  
    -- 普通变异tab
    self:initTab()

    -- 宠物信息
    local petTxtLayout = UI.Layout:create()
    petTxtLayout:init()
    petTxtLayout:setSize(319, 26)
    petTxtLayout:leftUp(3, 20)
    upLayout:addChild(petTxtLayout, 300)
    ZOrder = ZOrder + 1

    local petNameBg = UI.Image:create()
    petNameBg:init("ui_pets_nametitle.png")
    petNameBg:center()
    petTxtLayout:addChild(petNameBg)

    local petTxt = UI.Text:create()
    petTxt:init(self.curPet.name, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_190_190_190)
    petTxt:center()
    petTxt:setWidth(266)
    petTxt:setTextCenter()
    petTxt:autoAdapt()
    petTxtLayout:addChild(petTxt)
    self.petTxt = petTxt

    -- 底光
    local lightDownEff = UI.Animation:create()
    lightDownEff:init("effect_ui_town_pet_show_down.json", "effect_ui_town_pet_show_down.atlas", 1);
    lightDownEff:center(-120, 83)
    -- lightDownEff:setAnimation("idle", true)
    upLayout:addChild(lightDownEff, ZOrder)
    self.lightDownEff = lightDownEff
    ZOrder = ZOrder + 1

    -- 上光
    local lightUpEff = UI.Animation:create()
    lightUpEff:init("effect_ui_town_pet_show_up.json", "effect_ui_town_pet_show_up.atlas", 1);
    lightUpEff:center(-120, 87)
    -- lightUpEff:setAnimation("idle", true)
    upLayout:addChild(lightUpEff, ZOrder)
    self.lightUpEff = lightUpEff
    ZOrder = ZOrder + 1

    local animationName = self:getLightAnimationName()
    lightDownEff:setAnimation(animationName, true)
    lightUpEff:setAnimation(animationName, true)

    -- 宠物动画
    self:updateAnimation(1)

    -- 排行榜
    self:initRankLayout()
    
    -- 右下面板
	local bottomLayout = UI.Layout:create()
    bottomLayout:init()
    bottomLayout:setSize(532, 219)
    bottomLayout:leftUp(320, 293)
    self.contentLayout:addChild(bottomLayout, 8)
    self.bottomLayout = bottomLayout

    -- 资质
    self:initQualityLayer()
    -- 技能
    self:initSkillLayer()
	
end

function PetHandbookView:updatelightAnimation()
    local animationName = self:getLightAnimationName()
    if self.lightDownEff then
        self.lightDownEff:setAnimation(animationName, true)
    end
    if self.lightUpEff then
        self.lightUpEff:setAnimation(animationName, true)
    end
end

function PetHandbookView:getLightAnimationName()
    local petQuality = self.curPet.petquality
    local animationName = "idle1"
    if petQuality == PublicDefine.PetQualityType.Blue then
        animationName = "idle1"
    elseif petQuality == PublicDefine.PetQualityType.Golden then
        animationName = "idle2"
    elseif petQuality == PublicDefine.PetQualityType.HiddenGold then
        animationName = "idle3"
    elseif petQuality == PublicDefine.PetQualityType.Violet then
        animationName = "idle4"
    elseif petQuality == PublicDefine.PetQualityType.Red then
        animationName = "idle5"
    end
    return animationName
end

function PetHandbookView:initTab()

    local normal = {idx = 1, text = UI.TEXT_1213701}
    local mutated = {idx = 2, text = UI.TEXT_1213702}

    -- 普通
    local lytNormal = UI.Layout:create()
    lytNormal:init()
    lytNormal:setSize(138, 50)
    lytNormal:leftBottom(27, -10)
    lytNormal:setTouchEnable(true)
    lytNormal:setSwallowTouches(true)
    self.upLayout:addChild(lytNormal, 10)

    local bgNormal = UI.Image:create()
    bgNormal:init("ui_pets_cultivate_btn_1.png")
    lytNormal:addChild(bgNormal)
    self.bgNormal = bgNormal

    local txtNormal = UI.Text:create()
    txtNormal:init(normal.text, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtNormal:setWidth(138)
    txtNormal:setTextCenter()
    txtNormal:autoAdapt()
    txtNormal:centerBottom(18)
    lytNormal:addChild(txtNormal, 10)
    
    lytNormal:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.normalSelect == true then
            return
        else
            self.bgMutated:hide()
            self.bgNormal:show()
            self.normalSelect = true
            self.mutatedSelect = false
            self:updateQuality(normal.idx)
            self:updateSkill(normal.idx)
            self:updateAnimation(normal.idx)
            self.curTabIdx = 1
            self._select = true
        end
    end)

    -- 变异
    local lytMutated = UI.Layout:create()
    lytMutated:init()
    lytMutated:setSize(138, 50)
    lytMutated:leftBottom(164, -10)
    lytMutated:setTouchEnable(true)
    lytMutated:setSwallowTouches(true)
    self.upLayout:addChild(lytMutated, 10)

    local bgMutated = UI.Image:create()
    bgMutated:init("ui_pets_cultivate_btn_1.png")
    bgMutated:hide()
    lytMutated:addChild(bgMutated)
    self.bgMutated = bgMutated

    local txtMutated = UI.Text:create()
    txtMutated:init(mutated.text, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    txtMutated:centerBottom(18)
    txtMutated:setWidth(138)
    txtMutated:setTextCenter()
    txtMutated:autoAdapt()
    lytMutated:addChild(txtMutated, 10)

    lytMutated:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.mutatedSelect == true then
            return
        else
            self.bgNormal:hide()
            self.bgMutated:show()
            self.mutatedSelect = true
            self.normalSelect = false
            self:updateQuality(mutated.idx)
            self:updateSkill(mutated.idx)
            self:updateAnimation(mutated.idx)
            self.curTabIdx = 2
            self._select = true
        end
    end)
end

function PetHandbookView:initRankLayout()

    self.uiRank = {}
    for i = 1, 3 do
        local oneRank = {}

        local uiLayout = UI.Layout:create()
        uiLayout = UI.Layout:create()
        uiLayout:init()
        uiLayout:setSize(234, 73)
        uiLayout:rightUp(12, -54 + i * 76)
        uiLayout:setTouchEnable(true)
        uiLayout:setSwallowTouches(true)
        self.upLayout:addChild(uiLayout, 10)
        oneRank.layout = uiLayout 

        local uiName = UI.Text:create()
        uiName:init(UI.TEXT_1213703, UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_248_201_95)
        uiName:leftUp(78, 18)
        uiName:setSize(130, 23)
        uiName:enableWrap(false)
        uiName:setTextLeft()
        uiLayout:addChild(uiName, 10)
        oneRank.name = uiName

        local uiMasterName = UI.Text:create()
        uiMasterName:init("??????", UI.SYS_FONT, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
        uiMasterName:leftUp(78, 44)
        uiMasterName:setSize(130, 23)
        uiMasterName:setTextLeft()
        uiMasterName:enableWrap(false)
        uiLayout:addChild(uiMasterName, 10)
        oneRank.master = uiMasterName

        local masterIcon = UI.Image:create()
        masterIcon:init("ui_pets_manual_master.png")
        masterIcon:leftUp(63, 47)
        masterIcon:hide()
        uiLayout:addChild(masterIcon, 10)
        oneRank.masterIcon = masterIcon

        local highLight = UI.Image:create()
        highLight:init(string.format("ui_pets_manual_rank_%d.png", i))
        highLight:hide()
        uiLayout:addChild(highLight, 5)
        oneRank.highLight = highLight
        oneRank.isUpdate = false

        table.insert(self.uiRank, oneRank)
        uiLayout:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self)
            self.uiRank[i].highLight:show()
            self._select = true
        end)
        uiLayout:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
            if not tolua.isnull(self) then
                self.uiRank[i].highLight:hide()
                if self.curPet.showQuestion then 
                    UI.ScrollBar:createByText(UI.TEXT_1213704)
                else 
                    if not self.uiRank[i].isUpdate then
                        UI.ScrollBar:createByText(UI.TEXT_1213705)
                    else
                        local onePet = self.curRankData[i].pet
                        local myPetList = MasterDataManager:getBagPets()
                        local curRankPet = Data.PetRoleData:create()
                        curRankPet:init(onePet, true)
                        for k, v in ipairs(myPetList) do                         
                            if curRankPet:getId() == v:getId() then
                                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_MAIN_TAB_INFO_SHOW, curRankPet:getId())
                                return
                            end
                        end
                        mvc.openPanel("Pet", "PetLookMain", {pet = curRankPet, isShow = true})
                        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_MAIN_VIEW_CENTERUP)
                    end
                end
            end
        end)
    end
end

-- 获取资质列表数据
function PetHandbookView:getQualityData(index)

    local qualityDataSort = {}
    local qualityData = ConfigManager:getPetTalentByID(self.curPet.talentID[index]) 
    table.insert(qualityDataSort, qualityData.talent_atk)
    table.insert(qualityDataSort, qualityData.talent_magicAtk)
    table.insert(qualityDataSort, qualityData.talent_element)
    table.insert(qualityDataSort, qualityData.talent_physicDef)
    table.insert(qualityDataSort, qualityData.talent_magicDef)
    table.insert(qualityDataSort, qualityData.talent_elementDef)
    table.insert(qualityDataSort, qualityData.talent_hp)
    return qualityDataSort  
end

function PetHandbookView:initQualityLayer()

    local qualityDataSort = self:getQualityData(1)
    local names = {
        UI.TEXT_1213633, UI.TEXT_1213635, UI.TEXT_1213637, UI.TEXT_1213634, 
        UI.TEXT_1213636, UI.TEXT_1213638, UI.TEXT_1213639,
    }
    local qualityIcon = {
        "ui_icon_talent_1.png", "ui_icon_talent_2.png", "ui_icon_talent_5.png", "ui_icon_talent_3.png",
        "ui_icon_talent_4.png", "ui_icon_talent_6.png", "ui_icon_talent_0.png", 
    }
    local xArr1 = {16, 16, 16, 186, 186, 186, 355}
    local xArr2 = {52, 52, 52, 221, 221, 221, 391}
    local yArr = {0, 36, 72, 0, 36, 72, 0}
    self.uiQuality = {}

    for i = 1, #names do
        local oneQuality = {}

        -- 类型
        local typeImg = UI.Image:create()
        typeImg:init(qualityIcon[i])
        typeImg:leftUp(xArr1[i], yArr[i])
        typeImg:setTouchEnable(true)
        self.bottomLayout:addChild(typeImg, 10)
        typeImg:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, names[i])
        end)
        typeImg:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
        end)
        oneQuality.typeImg = typeImg
        
		-- 数值
        local numTxt = UI.Text:create()
        if self.curPet.showQuestion then
            numTxt:init("??????", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        else
            numTxt:init(qualityDataSort[i][1].."-"..qualityDataSort[i][2], UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        end
		numTxt:leftUp(xArr2[i], yArr[i]+5)
		numTxt:setWidth(100)
		numTxt:autoAdapt()
        self.bottomLayout:addChild(numTxt, 10)
        oneQuality.numTxt = numTxt

        table.insert(self.uiQuality, oneQuality)
	end
end

-- 获取技能列表
function PetHandbookView:getSkillPoolData(index)

    local skillPoolData = ConfigManager:getPetSkillPoolByID(self.curPet.skillPoolID[index])
    local skillIds = {}

    for i = 1, 8 do 
        if skillPoolData["skill"..i] ~= "" then
            local tempId = string.split(skillPoolData["skill"..i], ";")[1]
            table.insert(skillIds, string.split(tempId, ",")[1])
        end
    end

    return skillIds
end

function PetHandbookView:initSkillLayer()

    local skillIds = self:getSkillPoolData(1)
    local xArr = {17, 79, 141, 203, 265, 327, 389, 451}
    local yArr = 10 
    self.uiSkill = {}

    self.skillNum = self.curPet.skillNum[1]

    local skillTxt = UI.Text:create()
    skillTxt:init(UI.TEXT_1213706, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    skillTxt:leftBottom(42, 78)
    self.bottomLayout:addChild(skillTxt, 10)

    for i = 1, 8 do
        local oneSkill = {}
        local skillBg = UI.Image:create()
        skillBg:init()
		skillBg:setImageScale(0.9)
        skillBg:leftBottom(xArr[i], yArr)
        self.bottomLayout:addChild(skillBg)
        oneSkill.skillBg = skillBg
        table.insert(self.uiSkill, oneSkill)
    end

    self:updateSkillBg()

    for k, v in ipairs(skillIds) do
        local skillOneData = ConfigManager:getSkillConfigById(v)
        -- local skillIcon = self:createSkillIcon(skillOneData, k)
        -- self.uiSkill[k].skillBg:addChild(skillIcon)
        self:createSkillIcon(skillOneData, k)
    end

    -- 额外加特质技能（处于skillIds以外）
    local petConfData = ConfigManager:getPetDataByID(self.curPet.id)
    if petConfData.giftedskill ~= "" or petConfData.giftedskill ~= "0,0;0,0" then
        local skillInfo = string.split(petConfData.giftedskill, ";")
        local giftSkillId = string.split(skillInfo[1], ",")[1]
        local skillConfData = ConfigManager:getSkillConfigById(tonumber(giftSkillId))
        self:createSkillIcon(skillConfData, 8)
    else
        self:createSkillIcon(nil, 8)
    end
end

-- 格子回调函数
function PetHandbookView:clickCallback(grid)

    if self and not tolua.isnull(self) and self.lastGrid and not tolua.isnull(self.lastGrid) then
        self.lastGrid:clearSelect()
    end

    for k, v in ipairs(self.petsList:getGridList()) do
        if v:getData().bookId == self.lastGridDataId then 
            v:clearSelect()
        end
    end

    local clickData = grid:getData()
    self.curPet = clickData
    self:updateRight()
    
    grid:cellClick()
    self.lastGrid = grid
    self._select = true
end

-- 更新模板列表
function PetHandbookView:updateGridList(index)

    if index == 1 then 
        for i = 1, #self.petData do
            self.petData[i].select = false
        end
        if self._select then 
            self:loadLastSelect(self.petData)
        else
            self:defaultSelect(self.petData)
            self:updateRight() 
        end
        self.petsList:setData(self.petData)  

    else
        local petTypeData = {}
        for i = 1, #self.petData do
            if self.petData[i].petType == index - 1 then
                self.petData[i].select = false
                table.insert(petTypeData, self.petData[i])
            end
        end
        if self.curPet.petType == index - 1 then
            self:loadLastSelect(petTypeData)
        else
            self:defaultSelect(petTypeData)
            self:updateRight() 
        end
        self.petsList:setData(petTypeData)
    end   
end

-- 加载上次选中
function PetHandbookView:loadLastSelect(data)
    for k, v in ipairs(data) do
        if v.bookId == self.curPet.bookId then
            v.select = true
            self.lastGridDataId = v.bookId
        end
    end
    self._select = true
end

-- 处理默认选择
function PetHandbookView:defaultSelect(data)
    self._select = false
    -- 默认选中解锁第一个
    for k, v in ipairs(data) do
        if v.showQuestion == false then
            v.select = true
            self.curPet = v
            self.lastGridDataId = v.bookId
            return
        end
    end
    -- 选中第一个
    data[1].select = true
    self.curPet = data[1]
    self.lastGridDataId = data[1].bookId
end

-- 排行榜回调函数
function PetHandbookView:getRanks()
    self.curRankData =  mvc.petModel:getRanksByTemID(self.curPet.id) 
    self:updateRanks()
end

-- 请求排行榜数据
function PetHandbookView:rankRequest()

    self.curRankData =  mvc.petModel:getRanksByTemID(self.curPet.id) 
    if not self.curRankData and not self.curPet.showQuestion then
        Net.NetRankSystem:requestPetRank({self.curPet.id})
    else
        self:updateRanks()
    end

end

-- 更新排行
function PetHandbookView:updateRanks()

    for k, v in ipairs(self.uiRank) do
        v.highLight:hide()
        v.name:setText(UI.TEXT_1213703)
        v.master:setText("??????")
        v.masterIcon:hide()
        v.isUpdate = false
    end

    if (not self.curPet.showQuestion) and self.curRankData then 

        -- 兼容服务器返回templateID = 0
        for i = #(self.curRankData), 1, -1 do
            if self.curRankData[i].pet.templateID == 0 then
                table.remove(self.curRankData, i)
            end
        end

        table.sort(self.curRankData, function(a, b) 
            return a.petRank < b.petRank
        end)  

        for k, v in pairs(self.curRankData) do

            local onePet = v.pet
            local curRankPet = Data.PetRoleData:create()
            curRankPet:init(onePet, true)  
            local petName = curRankPet:getNickName()
            self.uiRank[k].name:setText(petName)
            self.uiRank[k].master:setText(v.nickName)
            self.uiRank[k].isUpdate = true
            self.uiRank[k].masterIcon:show()

        end
    end
end

-- 创建技能背景
function PetHandbookView:updateSkillBg()

    for k, v in ipairs(self.uiSkill) do
        if k <= self.skillNum then       
            v.skillBg:setSpriteName("ui_pets_skill_box.png")
            v.skillBg:setTouchEnable(true)
            v.skillBg:setSwallowTouches(true)

            v.skillBg:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, UI.TEXT_1213729)
            end)
            v.skillBg:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
            end)
        else
            v.skillBg:setSpriteName("ui_pets_skill_box_lock.png")
            v.skillBg:setTouchEnable(false)
        end
    end
end

-- 创建技能icon
function PetHandbookView:createSkillIcon(skillOneData, index)

    local giftSkillBg = self.uiSkill[index].skillBg:getChildByName("giftSkillBg")
    if skillOneData and not giftSkillBg and not self.curPet.showQuestion and index == 8 then
        giftSkillBg = UI.Image:create()
        giftSkillBg:init("ui_pets_skill_box_pvp.png")
        giftSkillBg:setImageScale(0.72)
        giftSkillBg:center()
        giftSkillBg:setName("giftSkillBg")
        self.uiSkill[index].skillBg:addChild(giftSkillBg)
    end

    local skillIcon = UI.Image:create()

    if not skillOneData then
        skillIcon:init("ui_pets_skill_box_lock.png")
        skillIcon:setImageScale(0.9)

        if skillIcon:getChildByName("ring") then
            skillIcon:removeChildByName("ring")
        end

        if self.uiSkill[index].skillBg:getChildByName("giftSkillBg") then
            self.uiSkill[index].skillBg:removeChildByName("giftSkillBg")
        end
    elseif self.curPet.showQuestion then

        skillIcon:init("ui_pets_skill_box_unkown.png")
        skillIcon:setImageScale(0.9)

        if skillIcon:getChildByName("ring") then
            skillIcon:removeChildByName("ring")
        end

        if self.uiSkill[index].skillBg:getChildByName("giftSkillBg") then
            self.uiSkill[index].skillBg:removeChildByName("giftSkillBg")
        end
    else
        local skillData = SkillDataManager:createSkillForSkillId(skillOneData.skillID)
        skillIcon:init(skillOneData.iconID)
        skillIcon:setImageScale(0.72)

        skillIcon:setTouchEnable(true)
        skillIcon:setSwallowTouches(true)

        if skillData:isActive() and index ~= 8 then
            local ring  = UI.Image:create();
            ring:init("ui_information_headframe_box2.png");
            ring:setScaleX(0.75)
            ring:setScaleY(0.75)
            ring:center();
            ring:setName("ring")
            skillIcon:addChild(ring, 1)
        end

        skillIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            local skill = Data.SkillData:create(skillOneData.ID)
            if(self.curPet and self.curPet.isFight and self.curPet:isFight()) then 
                skillData:setIsPetActive(true)
            end
            local tip = UI.SkillTips:create(skill, 3)
            local viewWidth, viewHeight = tip:getSize()
            tip:leftBottom(0, 0)
            tip:init()
            self:addChild(tip, 1000)        
        end)
    end
    skillIcon:setName("skillIcon")
    skillIcon:center()
    self.uiSkill[index].skillBg:addChild(skillIcon)
end

-- 选中模板后右侧界面更新
function PetHandbookView:updateRight()

    self:rankRequest()
    if not self.curPet.showQuestion then 
        self.petTxt:setText(self.curPet.name)
    else
        self.petTxt:setText("??????")
    end
    self.bgMutated:hide()
    self.mutatedSelect = false
    self.bgNormal:show()
    self.normalSelect = true
    self:updateAnimation(1)
    self:updateQuality(1) 
    self:updateSkill(1)
    self:updatelightAnimation()
end


-- 根据Tab更新技能
function PetHandbookView:updateSkill(index)
    self.skillNum = self.curPet.skillNum[index]
    self:updateSkillBg()

    -- 去除之前技能图标
    for k, v in ipairs(self.uiSkill) do
        local skillIconBefore = self.uiSkill[k].skillBg:getChildByName("skillIcon")
        if skillIconBefore then
            self.uiSkill[k].skillBg:removeChildByName("skillIcon")
        end
    end

    local skillIds = self:getSkillPoolData(index)

    for k, v in ipairs(skillIds) do
        local skillOneData = ConfigManager:getSkillConfigById(v)
        -- local skillIcon = self:createSkillIcon(skillOneData, k)
        -- self.uiSkill[k].skillBg:addChild(skillIcon)
        self:createSkillIcon(skillOneData, k)
    end

    -- 额外加特质技能（处于skillIds以外）
    local petConfData = ConfigManager:getPetDataByID(self.curPet.id)
    if petConfData.giftedskill ~= "" or petConfData.giftedskill ~= "0,0;0,0" then
        local skillInfo = string.split(petConfData.giftedskill, ";")
        local giftSkillId = string.split(skillInfo[index], ",")[1]
        local skillConfData = ConfigManager:getSkillConfigById(tonumber(giftSkillId))
        self:createSkillIcon(skillConfData, 8)
    else
        self:createSkillIcon(nil, 8)
    end
end

-- 根据Tab更新资质
function PetHandbookView:updateQuality(index)

    local qualityDataSort = self:getQualityData(index)

    if self.curPet.showQuestion then
        for i = 1, #qualityDataSort do
            self.uiQuality[i].numTxt:setText("??????")
        end
    else    
        for i = 1, #qualityDataSort do
            self.uiQuality[i].numTxt:setText(qualityDataSort[i][1].."-"..qualityDataSort[i][2])
        end
    end
end

-- 根据Tab更新宠物动画
function PetHandbookView:updateAnimation(index)

    local petAni = self.upLayout:getChildByName("PetAnimation")
    if petAni then
        self.upLayout:removeChildByName("PetAnimation")
    end

    local petAnimation = UI.Animation:create()
    local spineArr = string.split(self.curPet.spine, ";")
    local spineName = spineArr[index]
    local spineoffset = string.split(self.curPet.illustrationoffset, ";")
    local offsetOne = spineoffset[index]
    local offset = string.split(offsetOne, ",")
    petAnimation:init(spineName .. ".json", spineName .. ".atlas", 1, true)
    petAnimation:setScale(0.7)
    if self.curPet.showQuestion then 
        AvalonUtil.useColorShaderForSpine(petAnimation._spine, cc.vec4(21/255, 14/255, 6/255, 1.0))      
    end
    petAnimation:leftUp(166, 220 - offset[2])
    petAnimation:setName("PetAnimation")
    petAnimation:setAnimation("idle3", true)
    self.upLayout:addChild(petAnimation)
end

function PetHandbookView:bindModel()

end


function PetHandbookView:unbindModel()

end




return PetHandbookView













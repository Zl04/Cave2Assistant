------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/11/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ActivityAnnivesaryLotteryPetDetailView = class("ActivityAnnivesaryLotteryPetDetailView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 650
local COM_HEIGHT = 527

local PET_TYPE_TEXT = {
    UI.TEXT_1213629,
    UI.TEXT_1213630,
    UI.TEXT_1213631,
    UI.TEXT_1213632,
}

local PET_TYPE_ICON = {
    [1]={"ui_pets_type_attack_0.png", "ui_pets_type_attack_1.png"},
    [2]={"ui_pets_type_defense_0.png", "ui_pets_type_defense_1.png"},
    [3]={"ui_pets_type_balanced_0.png", "ui_pets_type_balanced_1.png"},
    [4]={"ui_pets_type_special_0.png", "ui_pets_type_special_1.png"},
}

function ActivityAnnivesaryLotteryPetDetailView:ctor(data)
    ActivityAnnivesaryLotteryPetDetailView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH, 
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function ActivityAnnivesaryLotteryPetDetailView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.activityannivesarylottery", "ActivityAnnivesaryLottery", false)
    ActivityAnnivesaryLotteryPetDetailView.super.init(self, ... )

    self:setTouchEnable(true)
    self:setSwallowTouches(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function()
        self:close()
    end)
end

function ActivityAnnivesaryLotteryPetDetailView:dtor()
    ActivityAnnivesaryLotteryPetDetailView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.activityannivesarylottery.ActivityAnnivesaryLotteryPetDetailView")
end


function ActivityAnnivesaryLotteryPetDetailView:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)
    

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_anniversary_bg5.png")
    bg:center()
    contentLayout:addChild(bg)

    -- local titleText = UI.Text:create()
    -- titleText:init(UI.TEXT_223602, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- titleText:center(50, 16)
    -- contentLayout:addChild(titleText)

    self:initPetDetailView()
end

function ActivityAnnivesaryLotteryPetDetailView:initPetDetailView()

    local ZOrder = 0
    self.curRankIdx = 0

    -- 右上面板
    local upLayout = UI.Layout:create()
    upLayout:init()
    upLayout:setSize(570, 288)
    upLayout:centerUp(0, 0)
    self.contentLayout:addChild(upLayout, 8)
    self.upLayout = upLayout
  
    -- 普通变异tab
    self:initTab()

    -- 宠物信息
    local petTxtLayout = UI.Layout:create()
    petTxtLayout:init()
    petTxtLayout:setSize(319, 26)
    petTxtLayout:center(0, -112)
    upLayout:addChild(petTxtLayout, 300)
    ZOrder = ZOrder + 1

    local petTxt = UI.Text:create()
    petTxt:init(self.data.name, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_190_190_190)
    petTxt:center()
    -- petTxt:setWidth(266)
    petTxt:setTextCenter()
    -- petTxt:autoAdapt()
    petTxtLayout:addChild(petTxt)
    self.petTxt = petTxt

    -- 底光
    local lightDownEff = UI.Animation:create()
    lightDownEff:init("effect_ui_town_pet_show_down.json", "effect_ui_town_pet_show_down.atlas", 1);
    lightDownEff:center(0, 83)
    -- lightDownEff:setAnimation("idle", true)
    upLayout:addChild(lightDownEff, ZOrder)
    self.lightDownEff = lightDownEff
    ZOrder = ZOrder + 1

    -- 上光
    local lightUpEff = UI.Animation:create()
    lightUpEff:init("effect_ui_town_pet_show_up.json", "effect_ui_town_pet_show_up.atlas", 1);
    lightUpEff:center(0, 87)
    -- lightUpEff:setAnimation("idle", true)
    upLayout:addChild(lightUpEff, ZOrder)
    self.lightUpEff = lightUpEff
    ZOrder = ZOrder + 1

    local animationName = self:getLightAnimationName()
    lightDownEff:setAnimation(animationName, true)
    lightUpEff:setAnimation(animationName, true)

    -- 宠物动画
    self:updateAnimation(1)

    -- -- 排行榜
    -- self:initRankLayout()
    
    -- 右下面板
	local bottomLayout = UI.Layout:create()
    bottomLayout:init()
    bottomLayout:setSize(532, 219)
    bottomLayout:leftUp(70, 293)
    self.contentLayout:addChild(bottomLayout, 8)
    self.bottomLayout = bottomLayout


    -- 宠物类型
    local petTypeBtn = UI.Button:create();
    local icons = PET_TYPE_ICON[self.data.petType]
    self.typeTxt = PET_TYPE_TEXT[self.data.petType]
    petTypeBtn:init(icons[1],icons[2],icons[1]);
    petTypeBtn:rightUp(125, 67);
    petTypeBtn:closeClickScale()
    petTypeBtn:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, self.typeTxt)
    end)
    petTypeBtn:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)
    petTypeBtn:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)
    self.contentLayout:addChild(petTypeBtn)
    self.petTypeBtn = petTypeBtn

    -- 宠物特质
    local preY = self:updateSpecial()

    -- 骑宠骑乘属性
    self:updateRidingAttribute(preY)

    -- 资质
    self:initQualityLayer()
    -- 技能
    self:initSkillLayer()
	
end

function ActivityAnnivesaryLotteryPetDetailView:updateSpecial()
    local petSpecialBtn = self.contentLayout:getChildByName("petSpecialBtn")
    if petSpecialBtn then
        self.contentLayout:removeChildByName("petSpecialBtn")
    end
    local buffs = {}
    local giftedProbList = self.data.giftedProb
    local buffList = string.split(giftedProbList, ";")
    for _, v in pairs(buffList) do
        local buffStr = string.split(v, ",")
        table.insert(buffs, tonumber(buffStr[1]))
    end

    local preY = 117
    local buffIDs = buffs
    if buffIDs then
        for k, v in ipairs(buffIDs) do
            local buffData = ConfigManager:getBufferConfigById(v)
            if buffData then
                local specialTxt = languageManagerInstance:getLocalString(buffData.description)
                local petSpecialBtn = UI.Button:create()
                petSpecialBtn:init("ui_pets_trait_0.png","ui_pets_trait_1.png","ui_pets_trait_0.png")
                petSpecialBtn:rightUp(125, 117 + (k - 1) * 50);
                petSpecialBtn:closeClickScale()
                petSpecialBtn:setName("petSpecialBtn")
                petSpecialBtn:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, specialTxt)
                end)
                petSpecialBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
                end)
                self.contentLayout:addChild(petSpecialBtn)

                preY = 117 + (k - 1) * 50
            end
        end
    end

    preY = preY + 50
    return preY
end

function ActivityAnnivesaryLotteryPetDetailView:updateRidingAttribute(preY)
    local petRidingAttributeBtn = self.contentLayout:getChildByName("petRidingAttributeBtn")
    if petRidingAttributeBtn then
        self.contentLayout:removeChildByName("petRidingAttributeBtn")
    end
    local petRoleAttribute = self.data.petRoleAttribute
    if (petRoleAttribute == "") then
        return preY
    end

    -- PublicDefine.VALUE_TYPE.Value
        -- table.insert(oneAttr,string.format("%s", endStr))
        -- table.insert(oneAttr,string.format("%.2f%%",self:getRateValue()/100))
        -- local endStr, valueType = ToolsUtil:calculationAttrShowValue(self.attrType, self.endAttr)
        -- local languageStr = ToolsUtil:attrNameToLanguageString(ATTR_TYPE_ID_KEY[self.attrType])
    local textAttriList = string.split(petRoleAttribute,";")
    local textAttri = languageManagerInstance:getLocalString(1114079) .. "\n"
    for k, v in ipairs(textAttriList) do 
        local aText = string.split(v,",")
        local attriType,attriValue = tonumber(aText[1]),tonumber(aText[2])
        local languageStr = ToolsUtil:getNameByAttrType(attriType)
        textAttri = textAttri .. languageStr
        -- if attriShowType == PublicDefine.VALUE_TYPE.Value then
        --     textAttri = textAttri .. attriValue
        -- else
            textAttri = textAttri .. string.format("%.2f%%",attriValue/100)
        -- end
        if k < #textAttriList then
            textAttri = textAttri .. "\n"
        end
    end

    -- local textAttri = "攻击增加 100000 \n攻击增加 200000 \n撒子都加简爱家啊啊所多居爱爱姐 1000000%"--languageManagerInstance:getLocalString(buffData.description)
    local petRidingAttributeBtn = UI.Button:create()
    petRidingAttributeBtn:init("ui_pets_trait_0.png","ui_pets_trait_1.png","ui_pets_trait_0.png")
    petRidingAttributeBtn:rightUp(125, preY);
    petRidingAttributeBtn:closeClickScale()
    petRidingAttributeBtn:setName("petRidingAttributeBtn")
    petRidingAttributeBtn:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, textAttri)
    end)
    petRidingAttributeBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)
    self.contentLayout:addChild(petRidingAttributeBtn)

    local fy = preY or 117
    return fy + 50
end

function ActivityAnnivesaryLotteryPetDetailView:initTab()

    local normal = {idx = 1, text = UI.TEXT_1213701}
    local mutated = {idx = 2, text = UI.TEXT_1213702}

    -- 普通
    local lytNormal = UI.Layout:create()
    lytNormal:init()
    lytNormal:setSize(138, 50)
    lytNormal:leftBottom(149, -6)
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
    lytMutated:leftBottom(286, -6)
    lytMutated:setTouchEnable(true)
    lytMutated:setSwallowTouches(true)
    self.upLayout:addChild(lytMutated, 10)
    -- lytMutated:enableDebugDraw()

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

-- 根据Tab更新宠物动画
function ActivityAnnivesaryLotteryPetDetailView:updateAnimation(index)

    local petAni = self.upLayout:getChildByName("PetAnimation")
    if petAni then
        self.upLayout:removeChildByName("PetAnimation")
    end

    local petAnimation = UI.Animation:create()
    local spineArr = string.split(self.data.spine, ";")
    local spineName = spineArr[index]
    local spineoffset = string.split(self.data.illustrationoffset, ";")
    local offsetOne = spineoffset[index]
    local offset = string.split(offsetOne, ",")
    petAnimation:init(spineName .. ".json", spineName .. ".atlas", 1, true)
    petAnimation:setScale(0.7)
    if self.data.showQuestion then 
        AvalonUtil.useColorShaderForSpine(petAnimation._spine, cc.vec4(21/255, 14/255, 6/255, 1.0))      
    end
    petAnimation:center(0, 80 - offset[2])
    petAnimation:setName("PetAnimation")
    petAnimation:setAnimation("idle3", true)
    self.upLayout:addChild(petAnimation)
end

-- 根据Tab更新资质
function ActivityAnnivesaryLotteryPetDetailView:updateQuality(index)

    local qualityDataSort = self:getQualityData(index)

    if self.data.showQuestion then
        for i = 1, #qualityDataSort do
            self.uiQuality[i].numTxt:setText("??????")
        end
    else    
        for i = 1, #qualityDataSort do
            self.uiQuality[i].numTxt:setText(qualityDataSort[i][1].."-"..qualityDataSort[i][2])
        end
    end
end

-- 创建技能背景
function ActivityAnnivesaryLotteryPetDetailView:updateSkillBg()

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
function ActivityAnnivesaryLotteryPetDetailView:createSkillIcon(skillOneData, index)

    local giftSkillBg = self.uiSkill[index].skillBg:getChildByName("giftSkillBg")
    if skillOneData and not giftSkillBg and not self.data.showQuestion and index == 8 then
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
    elseif self.data.showQuestion then

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
            if(self.data and self.data.isFight and self.data:isFight()) then 
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

-- 根据Tab更新技能
function ActivityAnnivesaryLotteryPetDetailView:updateSkill(index)

    self.skillNum = self.data.skillNum[index]
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
    local petConfData = ConfigManager:getPetDataByID(self.data.id)
    if petConfData.giftedskill ~= "" or petConfData.giftedskill ~= "0,0;0,0" then
        local skillInfo = string.split(petConfData.giftedskill, ";")
        local giftSkillId = string.split(skillInfo[index], ",")[1]
        local skillConfData = ConfigManager:getSkillConfigById(tonumber(giftSkillId))
        self:createSkillIcon(skillConfData, 8)
    else
        self:createSkillIcon(nil, 8)
    end
end

-- 获取技能列表
function ActivityAnnivesaryLotteryPetDetailView:getSkillPoolData(index)

    local skillPoolData = ConfigManager:getPetSkillPoolByID(self.data.skillPoolID[index])
    local skillIds = {}

    for i = 1, 8 do 
        if skillPoolData["skill"..i] ~= "" then
            local tempId = string.split(skillPoolData["skill"..i], ";")[1]
            table.insert(skillIds, string.split(tempId, ",")[1])
        end
    end

    return skillIds
end

function ActivityAnnivesaryLotteryPetDetailView:initSkillLayer()

    local skillIds = self:getSkillPoolData(1)
    local xArr = {17, 79, 141, 203, 265, 327, 389, 451}
    local yArr = 10 
    self.uiSkill = {}
    self.skillNum = self.data.skillNum[1]

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
    local petConfData = ConfigManager:getPetDataByID(self.data.id)
    if petConfData.giftedskill ~= "" or petConfData.giftedskill ~= "0,0;0,0" then
        local skillInfo = string.split(petConfData.giftedskill, ";")
        local giftSkillId = string.split(skillInfo[1], ",")[1]
        local skillConfData = ConfigManager:getSkillConfigById(tonumber(giftSkillId))
        self:createSkillIcon(skillConfData, 8)
    else
        self:createSkillIcon(nil, 8)
    end
end

-- 获取资质列表数据
function ActivityAnnivesaryLotteryPetDetailView:getQualityData(index)

    local qualityDataSort = {}
    local qualityData = ConfigManager:getPetTalentByID(self.data.talentID[index]) 
    table.insert(qualityDataSort, qualityData.talent_atk)
    table.insert(qualityDataSort, qualityData.talent_magicAtk)
    table.insert(qualityDataSort, qualityData.talent_element)
    table.insert(qualityDataSort, qualityData.talent_physicDef)
    table.insert(qualityDataSort, qualityData.talent_magicDef)
    table.insert(qualityDataSort, qualityData.talent_elementDef)
    table.insert(qualityDataSort, qualityData.talent_hp)
    return qualityDataSort  
end

function ActivityAnnivesaryLotteryPetDetailView:initQualityLayer()

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
        if self.data.showQuestion then
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

function ActivityAnnivesaryLotteryPetDetailView:getLightAnimationName()
    local petQuality = self.data.petquality
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

function ActivityAnnivesaryLotteryPetDetailView:bindModel()

end


function ActivityAnnivesaryLotteryPetDetailView:unbindModel()

end





return ActivityAnnivesaryLotteryPetDetailView













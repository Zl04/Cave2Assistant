------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/10/30
--desc	: 炼化选择目标界面：技能、经验丹、资质丹
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetRefineSelectView = class("PetRefineSelectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_general_tips.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
}

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = 430
local COM_HEIGHT = 316
local DUST_ID = 22070570

local TargetType = {
    EXP = 1,
    QUALITY = 2,
    SKILL = 3,
}

function PetRefineSelectView:ctor(data)
    PetRefineSelectView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.targetType = data.idx
    self.petID = data.id
    self.curPet = MasterDataManager:getBagPetById(self.petID)
    self.curSkillID = 0
    self.tableviewSize = {width = 380, height = 158}
end

function PetRefineSelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetRefineSelectView.super.init(self, ... )
end

function PetRefineSelectView:dtor()
    PetRefineSelectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pet.PetRefineSelectView")
end


function PetRefineSelectView:onInitView()
    self.awards = {}

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    -- local maskLayout = UI.Layout:create();
    -- maskLayout:init()
    -- maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    -- maskLayout:center()
    -- maskLayout:setTouchEnable(true)
    -- maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() return end)
    -- self:addChild(maskLayout, 0)

    local bgImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box3.png")
    bgImage:setContentSize(COM_WIDTH, COM_HEIGHT)
    bgImage:setCapInsets(CCRectMake(COM_WIDTH/2, COM_HEIGHT/2, 1, 1))
    bgImage:setPosition(cc.p(COM_WIDTH/2, COM_HEIGHT/2))
    self.contentLayout:addChild(bgImage, 0)

    local titleTxt = UI.Text:create()
    titleTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    titleTxt:centerUp(12)
    titleTxt:setWidth(400)
    titleTxt:setTextCenter()
    titleTxt:autoAdapt()
    self.contentLayout:addChild(titleTxt)
    self.titleTxt = titleTxt

    local okBtn = UI.Button:create();
    okBtn:init("ui_btn_yellow6_0.png","ui_btn_yellow6_1.png","ui_btn_yellow6_2.png");
    okBtn:centerBottom(10);
    okBtn:closeClickScale()
    okBtn:setText(UI.TEXT_1213641)
    okBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.targetType == TargetType.SKILL then
            self:skillClick(self.contentLayout.curSkillIndexId)
            if self.curSkillID == 0 and #self.curPet:getAllSkills() > 0 then
                UI.ScrollBar:createByText(UI.TEXT_1213648)
                return
            end

            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REFINE_SELECT, self.targetType, self.awards, self.curSkillID)
        elseif self.targetType == TargetType.QUALITY then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REFINE_SELECT, self.targetType, self.awards)
        elseif self.targetType == TargetType.EXP then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_REFINE_SELECT, self.targetType, self.awards)
        end

        mvc.closePanel("Pet", "PetRefineSelect")
    end)
    self.contentLayout:addChild(okBtn)
    self.okBtn = okBtn

    if self.targetType == TargetType.SKILL then
        self:showSkillPanel()
    elseif self.targetType == TargetType.EXP then
        self:showExpPanel()
    elseif self.targetType == TargetType.QUALITY then
        self:showQualityPanel()
    end
end

function PetRefineSelectView:showSkillPanel()
    self.titleTxt:setText(UI.TEXT_1213683)

    self.skillObjs = {}

    -- 技能
    local skillBG  = UI.Image:create();
    skillBG:init("ui_pets_skill_paper.png");
    skillBG:centerUp(32);
    skillBG:setScaleY(0.87)
    self.contentLayout:addChild(skillBG);

    self:assembleSkill()

    local petId = nil
    if self.curPet then
       petId = self.curPet:getId()
    end
    local PetSkillTableView = UI.PetSkillTableView:create()
    PetSkillTableView:init(petId)
    PetSkillTableView:leftUp(20, -355)
    self.contentLayout:addChild(PetSkillTableView, 1)
    PetSkillTableView:setTableViewSize(self.tableviewSize)
    PetSkillTableView:updateSkillList(self.skillData)
    self.PetSkillTableView = PetSkillTableView
    self.contentLayout.curSkillIndexId = 0

    for k, v in ipairs(self.skillData) do
        local oneSkill = self:addOneSkill(v)
        --self.contentLayout:addChild(oneSkill)

        table.insert(self.skillObjs, oneSkill)
    end

    local allSkills = self.curPet:getAllSkills()
    local skillNameTxt = UI.Text:create()
    skillNameTxt:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_103_29_39)
    skillNameTxt:centerBottom(90)
    skillNameTxt:setWidth(400)
    skillNameTxt:setTextCenter()
    skillNameTxt:autoAdapt()
    self.contentLayout:addChild(skillNameTxt)
    self.skillNameTxt = skillNameTxt

    if #allSkills == 0 then
        self.skillNameTxt:setText(UI.TEXT_1213684)
    end

    self:showOutputGoldDust(86)
end


function PetRefineSelectView:assembleSkill()
    self.skillData = {}

    local ids = {1, 2, 3, 4, 5, 6, 7, 8}

    if self.curPet then
        local ReincarntionLv = self.curPet:getReincarntionLv()
        if ReincarntionLv > 0 then
            local detailConfig = ConfigManager:getAllPetReincarnationDataByID(ReincarntionLv)
            local addSkillNum = detailConfig.addSkillNum
            -- for i=1,addSkillNum do
            --     table.insert(ids, (#ids + i))
            -- end
            ids = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        end
    end

    -- local xArr = {46, 140, 230, 320, 46, 140, 230, 320}
    -- local yArr = {52, 52, 52, 52, 129, 129, 129, 129}
    for k, v in ipairs(ids) do
        local oneSkill = {}
        oneSkill.idx = k
        oneSkill.id = v
        -- oneSkill.x = xArr[k]
        -- oneSkill.y = yArr[k]
        oneSkill.isLock = false
        oneSkill.isUnkown = false
        oneSkill.isGiftSkill = false
        oneSkill.skill = nil

        if not self.curPet then
            oneSkill.isUnkown = true
        else
            if v == 8 or v == 9 then
                -- 特质技能
                oneSkill.skill = v == 8 and self.curPet:getGiftedSkill() or self.curPet:getGiftedSkill2()
                if oneSkill.skill then
                    oneSkill.isGiftSkill = true
                else
                    oneSkill.isLock = true
                end
            else
                local cfgIdx = self.curPet.isVariant and 2 or 1
                oneSkill.isLock = oneSkill.idx > self.curPet.skillNum[cfgIdx]

                local allSkills = self.curPet:getAllSkills()
                oneSkill.skill = allSkills[k] or nil
            end
        end

        table.insert(self.skillData, oneSkill)
    end
end

function PetRefineSelectView:addOneSkill(data)
    local skillLayer = UI.Layout:create();
    skillLayer:init()
    skillLayer:setSize(62, 62)
    --skillLayer:leftUp(data.x, data.y)

    local skillBG  = UI.Image:create()
    if data.isGiftSkill then
        skillBG:init("ui_pets_skill_box_pvp.png")
        skillBG:setImageScale(0.8)
    else
        skillBG:init("ui_pets_skill_box_lock.png")
        skillLayer:setTouchEnable(true)
        skillLayer:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self)
            self:skillClick(data.idx)
        end)
    end
    skillBG:center()
    skillLayer:addChild(skillBG)

    if not data.skill then
        return skillLayer
    end

    if not data.isGiftSkill then
        local selectEff = UI.Animation:create()
        selectEff:init("effect_ui_town_pet_skill_slot1.json", "effect_ui_town_pet_skill_slot1.atlas", 1);
        selectEff:center()
        selectEff:hide()
        selectEff:setName("Select")
        skillLayer:addChild(selectEff, 100)
    end

    local skillIcon = UI.Image:create()
    local skillCfg = ConfigManager:getSkillConfigById(data.skill)
    skillIcon:init(skillCfg.iconID)
    skillIcon:setImageScale(0.8)
    skillIcon:center()
    skillLayer:addChild(skillIcon)

    local skillData = SkillDataManager:createSkillForSkillId(skillCfg.skillID)
    if skillData:isActive() and not data.isGiftSkill  then
        local ring  = UI.Image:create();
        ring:init("ui_information_headframe_box2.png");
        ring:setScaleX(0.8)
        ring:setScaleY(0.8)
        ring:center();
        skillLayer:addChild(ring, 0);
    end

    if data.isGiftSkill then
        skillBG:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
        skillIcon:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
        
        local skillDisableImg = UI.Image:create()
        skillDisableImg:init("ui_pets_skill_disable.png")
        skillDisableImg:center()
        skillLayer:addChild(skillDisableImg)
    end

    return skillLayer
end

function PetRefineSelectView:skillClick(idx)
    -- if not curSkillObj then
    --     return
    -- end

    -- local select = curSkillObj:getChildByName("Select")
    -- if not select then
    --     return
    -- end

    self.curSelectIdx = idx

    local curData = self.skillData[self.curSelectIdx]
    if not curData then
        return
    end
    local ids = self.curPet:getAllSkills()
    local skillData = Data.SkillData:create(ids[curData.idx])
    self.skillNameTxt:setText(skillData:getName())

    -- select:show()
    -- select:setAnimation("trigger", false)
    -- select:addAnimation("idle", true)

    -- if self.curSelectIdx~= self.lastSelectIdx and self.skillObjs[self.lastSelectIdx] then
    --     local lastSelect = self.skillObjs[self.lastSelectIdx]:getChildByName("Select")
    --     lastSelect:hide()
    -- end

    self.lastSelectIdx = self.curSelectIdx

    local allBookIDs = mvc.petModel:getAllSkillBookID()
    local curBookData = allBookIDs[ids[curData.idx]]

    if not curBookData then
        -- 选中的是特质技能
        UI.ScrollBar:createByText(UI.TEXT_224500)
        return        
    end

    self.curSkillID = ids[curData.idx]
    self.awards[2] = {goodsID = curBookData.id, num = 1, isGolden = false}
end

-- 经验丹
function PetRefineSelectView:showExpPanel()
    self.titleTxt:setText(UI.TEXT_1213681)

    local itemLayer = UI.Layout:create();
    itemLayer:init()
    itemLayer:enableAutoWidth()
    itemLayer:enableAutoHeight()
    itemLayer:centerUp(70)
    self.contentLayout:addChild(itemLayer)

    local allExpPill = mvc.petModel:getAllExpPill()
    local curLv = self.curPet:getLevel() - 1
    local totalExp = self.curPet:getCurExp()
    for i = 1, curLv do
        local cfg = ConfigManager:getPetExpByID(i)
        totalExp = totalExp + cfg.expToNextLV
    end

    totalExp = totalExp * tonumber(Config.General:getValueForKey("PetExpReturnRatio"))/10000

    self.totalExpPillType = 0
    local offsets = {0, 30}
    local counts = {}
    local names = {}
    local txtY = {140, 110}
    for k, v in ipairs(allExpPill) do
        local curCount = math.floor(totalExp/v.exp)
        local goodsData = GoodsDataManager:createLocalGoodsData(v.id)
        goodsData:setNum(curCount)
        goodsData:setIsNew(false)
        goodsData.isHaveGet = false

        self.awards[k+1] = {goodsID = tonumber(v.id), num = tonumber(curCount), isGolden = false}
    
        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(false, false)
        goodsGrid:floatLeft(offsets[k])
        itemLayer:addComponent(goodsGrid)

        totalExp = totalExp - curCount*v.exp

        table.insert(counts, curCount)
        table.insert(names, goodsData:getName())

        if curCount > 0 then
            self.totalExpPillType = self.totalExpPillType + 1
        end

        local numTxt = UI.Text:create()
        numTxt:init(goodsData:getName().."  "..tostring(curCount), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_103_29_39)
        numTxt:centerBottom(txtY[k])
        numTxt:setWidth(300)
        numTxt:setTextCenter()
        numTxt:autoAdapt()
        self.contentLayout:addChild(numTxt)
    end

    self:showOutputGoldDust()
end

-- 资质丹
function PetRefineSelectView:showQualityPanel()
    self.titleTxt:setText(UI.TEXT_1213682)

    local qualityPillID = self.curPet.talentItem[1]
    local qualityPillNum = self.curPet.talentItem[2]

    self.awards[2] = {goodsID = tonumber(qualityPillID), num = tonumber(qualityPillNum), isGolden = false}

    local goodsData = GoodsDataManager:createLocalGoodsData(qualityPillID)
    goodsData:setNum(qualityPillNum)
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false

    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    goodsGrid:centerUp(70)
    self.contentLayout:addChild(goodsGrid, 2);

    local tipTxt = UI.Text:create()
    if self.curPet:getLevel() >= self.curPet.maxLV then
        tipTxt:init(string.format(UI.TEXT_1213642,  qualityPillNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_103_29_39)

        self:showOutputGoldDust()
    else
        tipTxt:init(UI.TEXT_1213643, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
        self.okBtn:disable()
    end
    tipTxt:centerBottom(114)
    tipTxt:setWidth(400)
    tipTxt:setTextCenter()
    tipTxt:autoAdapt()
    self.contentLayout:addChild(tipTxt, 2)
end

function PetRefineSelectView:showOutputGoldDust(_offsetY)
    local offsetY = _offsetY or 80
    -- 金币
    local outputLayer = UI.Layout:create();
    outputLayer:init()
    outputLayer:centerBottom(offsetY - 26)
    outputLayer:enableAutoWidth()
    outputLayer:enableAutoHeight()
    self.contentLayout:addChild(outputLayer)

    local momeyImage = UI.Image:create()
    momeyImage:init("symbol_gaming_money.png")
    momeyImage:floatLeft(0)
    outputLayer:addComponent(momeyImage)

    local momeyText = UI.Text:create()
    momeyText:init(tostring(mvc.petModel:getRefineReturnMoney(self.petID)), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    momeyText:floatLeft(6)
    outputLayer:addComponent(momeyText, 4)

    -- 灵魂粉尘
    local dustStrList = mvc.petModel:getRefineReturnDust(self.petID)
    local dustData = GoodsDataManager:createLocalGoodsData(tonumber(dustStrList[1]))
    dustData:setNum(tonumber(dustStrList[2]))

    local outDustLayer = UI.Layout:create();
    outDustLayer:init()
    outDustLayer:centerBottom(offsetY)
    outDustLayer:enableAutoWidth()
    outDustLayer:enableAutoHeight()
    self.contentLayout:addChild(outDustLayer)

    local dustImage = UI.Image:create()
    dustImage:init(dustData:getSmallIconName())
    dustImage:floatLeft(0)
    outDustLayer:addComponent(dustImage)

    local dustText = UI.Text:create()
    dustText:init(tostring(dustData:getNum()), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    dustText:floatLeft(6)
    outDustLayer:addComponent(dustText, 4)

    local totalLength = outputLayer:getContentSize().width + outDustLayer:getContentSize().width + 20
    outputLayer:center(-totalLength/2 + outputLayer:getContentSize().width/2, offsetY - 6)
    outDustLayer:center(totalLength/2 - outDustLayer:getContentSize().width/2, offsetY - 6)

    self.awards[1] = {goodsID = tonumber(dustStrList[1]), num = tonumber(dustStrList[2]), isGolden = false}
end

-- 根据传入的技能数据直接进行更新
function PetRefineSelectView:setTableViewSize(tableviewSize)
    self.tableviewSize = tableviewSize
end

function PetRefineSelectView:bindModel()

end

function PetRefineSelectView:unbindModel()

end

return PetRefineSelectView

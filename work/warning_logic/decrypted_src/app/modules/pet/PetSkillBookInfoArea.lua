--[[
    UI - 技能书tips
]]--

UI = UI or {}

local PetSkillBookInfoArea = class("PetSkillBookInfoArea", UI.HWBtnComponent)
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
UI.PetSkillBookInfoArea = PetSkillBookInfoArea

local SceneManager = require("app.game.SceneManager")

local COM_RES_LIST = {
    "ui_town_starpray.plist",
    "ui_common_btn.plist",
    "ui_package_pets.plist",
    "ui_common_scale9image.plist",
}

local SPRITE_SKILLBOOK_BG1 = "ui_pets_cultivate_skillbook_1.png"
local SPRITE_SKILLBOOK_BG2 = "ui_pets_cultivate_skillbook_2.png"

local layerSize = cc.size(291, 439)
local LAYOUT_SIZE_WIDTH = 250 
function PetSkillBookInfoArea:ctor()
    PetSkillBookInfoArea.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)
    self:setInterceptTouches(false)
    self:setTouchEnable(true)
end

function PetSkillBookInfoArea:init(isBag, petID)
    PetSkillBookInfoArea.super.init(self)

    self.petID = petID
    self.isBag = isBag or false
end

-- 析构函数
function PetSkillBookInfoArea:dtor()
    PetSkillBookInfoArea.super.dtor(self)
end

function PetSkillBookInfoArea:setGoodsGrid(goodsGrid)
    self._goodsGrid = goodsGrid
end

function PetSkillBookInfoArea:getGoodsGrid()
    return self._goodsGrid
end

-- 初始化视图
function PetSkillBookInfoArea:onInitView()

    local ZOrder = 0
    self.isInitiative = false
    self.showConfirm = false

    local bg = UI.Image:create()
    bg:init(SPRITE_SKILLBOOK_BG1)
    bg:center()
    self.bg = bg
    self:addChild(bg)

    AvalonUtil.runTipsAppearShowAnimation(self)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(layerSize.width, layerSize.height)
    contentLayout:center()
    self.contentLayout = contentLayout
    bg:addChild(contentLayout)

    local title = UI.Text:create()
    title:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    title:centerUp(26)
    self.contentLayout:addChild(title, ZOrder)
    self.title = title
    ZOrder = ZOrder + 1

    -- 技能图标
    local skillIcon = UI.Image:create()
    skillIcon:init()
    skillIcon:leftUp(18, 85)
    self.contentLayout:addChild(skillIcon, ZOrder)
    self.skillIcon = skillIcon
    ZOrder = ZOrder + 1

    -- 技能名字
    local skillName = UI.Text:create()
    skillName:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    skillName:leftUp(115, 93)
    skillName:setWidth(155)
    skillName:autoAdapt()
    skillName:setLineSpacing(-6)
    self.contentLayout:addChild(skillName, ZOrder)
    self.skillName = skillName
    ZOrder = ZOrder + 1

    -- 技能类型
    local skillType = UI.Text:create()
    skillType:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    skillType:leftUp(115, 140)
    self.contentLayout:addChild(skillType, ZOrder)
    self.skillType = skillType
    ZOrder = ZOrder + 1

    -- 分割线
    local line = UI.Image:create()
    line:init("ui_scale9image_banner_line_dark.png")
    line:centerUp(190)
    line:setImageScaleX(90)
    self.contentLayout:addChild(line, ZOrder)
    ZOrder = ZOrder + 1

    -- 属性显示区域
    self.scrollLayout = UI.Layout:create()
    self.scrollLayout:init()
    self.scrollLayout:setSize(LAYOUT_SIZE_WIDTH, 300)

    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(LAYOUT_SIZE_WIDTH, 170)
    scrollView:init(10, 0, 0, 0)
    scrollView:centerUp(210)
    scrollView:addInnerNode(self.scrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    self.contentLayout:addChild(scrollView, ZOrder)
    ZOrder = ZOrder + 1

    -- 描述文本
    local scrollTxt = UI.Text:create()
    scrollTxt:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    scrollTxt:leftUp(0, 0)
    scrollTxt:setWidth(220)
    scrollTxt:enableWrap(true)
    self.scrollLayout:addChild(scrollTxt)
    self.scrollTxt = scrollTxt

    -- 按钮
    local btn = UI.Button:create()
    btn:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_0.png")
    btn:centerBottom(30)
    btn:setText(UI.TEXT_1213707)
    btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    btn:setTouchEnable(true)
    btn:setSwallowTouches(true)
    self.contentLayout:addChild(btn, ZOrder)
    ZOrder = ZOrder + 1
    btn:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        if self and (not tolua.isnull(self)) then
            self:close()
        end

        if self.isBag then
            local master = RoleDataManager:getMaster()
            if #MasterDataManager:getBagPets() == 0 then 
                UI.ScrollBar:createByText(UI.TEXT_1213726)
                return
            end

            -- 跳转宠物界面
            local rolePetList = MasterDataManager:getBagPets()
            for k, v in ipairs(rolePetList) do
                if v:isFight() then 
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ROLE_PANEL)
                    mvc.openPanel("Pet", "PetMain", {tabIdx=2, innerTabIdx=3, petID=v:getId()})
                    return
                end
            end
        else
            local bookId = self.bookData:getId()
            local petID = self.petID

            -- 不能使用与其已有技能完全一样的技能书
            local curPet = MasterDataManager:getBagPetById(petID)
            local allSkills = curPet:getAllSkills()
            local itemCfg = ConfigManager:getMaterialConfigByID(bookId)
            for k, v in ipairs(allSkills) do
                if v == tonumber(itemCfg.value1) then
                    UI.ScrollBar:createByText(UI.TEXT_1213709)
                    return
                end
            end

            -- 判断是否拥有主动技能
            for k, v in ipairs(allSkills) do
                local vCfg = ConfigManager:getSkillConfigById(v)
                if vCfg.type ~= SkillType.PASSIVE then
                    self.showConfirm = true
                    break
                end
            end

            -- 主动技能二次确认
            if self.isInitiative and self.showConfirm then
                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                    UI.TEXT_1213754,
                    function()
                        Net.NetPetSystem:learnSkill(petID, bookId)
                    end
                )
            else
                Net.NetPetSystem:learnSkill(petID, bookId)
            end
        end

    end)
end

-- 更新视图
function PetSkillBookInfoArea:onUpdateView(data)

    if not data then
        return
    end

    self.bookData = data

    if data.value3 == "1" then
        self.bg:setSpriteName(SPRITE_SKILLBOOK_BG1)
        self.title:setText(UI.TEXT_1213710)
    elseif data.value3 == "2" then
        self.title:setText(UI.TEXT_1213711)
        self.bg:setSpriteName(SPRITE_SKILLBOOK_BG2)
    end

    local skillData = ConfigManager:getSkillConfigById(tonumber(data.value1))
    self.skillIcon:setSpriteName(skillData.iconID)
    self.skillName:setText(skillData.name)
    if skillData.type == SkillType.PASSIVE then
        self.skillType:setText(UI.TEXT_110038)
    else
        self.skillType:setText(UI.TEXT_110039)
        self.isInitiative = true
    end

    local skillDescription = languageManagerInstance:getLocalString(skillData.description)
    local description = UI.TEXT_1213712..skillDescription
    self.scrollTxt:setText(description)
    self.scrollLayout:setSize(LAYOUT_SIZE_WIDTH, self.scrollTxt:getContentSize().height + 20)
end
------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/11/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetLookAttrView = class("PetLookAttrView", UI.BaseWin)

require "app.modules.pet.PetQualityLayer"
require "app.modules.pet.PetSkillLayer"
require "app.config.ConfigManager"

UI = UI or {}

UI.PetLookAttrView = PetLookAttrView

-- 资源
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_common_symbol.plist",
    "ui_package_pets_share.plist",
}

local COM_WIDTH = 425
local COM_HEIGHT = 500

function PetLookAttrView:ctor()
    PetLookAttrView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PetLookAttrView:init(data, ... )
    self.curPet = data

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetLookAttrView.super.init(self, ... )
end

function PetLookAttrView:dtor()
    PetLookAttrView.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pet.PetLookAttrView")
end

function PetLookAttrView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 顶部按钮条
    -- 背景图片
    local titleBG  = UI.Image:create();
    titleBG:init("ui_pets_attribute_btn_0.png");
    titleBG:centerUp(10);
    contentLayout:addChild(titleBG);

    local select1  = UI.Image:create();
    select1:init("ui_pets_cultivate_btn_1.png");
    select1:leftUp(1, 1);
    titleBG:addChild(select1);
    select1:hide()
    self.tabSelect1 = select1

    local select2  = UI.Image:create();
    select2:init("ui_pets_cultivate_btn_1.png");
    select2:leftUp(138, 1);
    titleBG:addChild(select2);
    select2:hide()
    self.tabSelect2 = select2

    local touchLayer1 = UI.Layout:create();
    touchLayer1:init()
    touchLayer1:setSize(136, 38)
    touchLayer1:leftUp(0, 0)
    touchLayer1:setTouchEnable(true)
    touchLayer1:setSwallowTouches(true)
    touchLayer1:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.curTabIndex == 1 then
            return
        end

        self:updateTabList(1)
    end)
    titleBG:addChild(touchLayer1)

    local touchLayer2 = UI.Layout:create();
    touchLayer2:init()
    touchLayer2:setSize(136, 38)
    touchLayer2:leftUp(138, 0)
    touchLayer2:setTouchEnable(true)
    touchLayer2:setSwallowTouches(true)
    touchLayer2:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.curTabIndex == 2 then
            return
        end

        self:updateTabList(2)
    end)
    titleBG:addChild(touchLayer2)

    local tabTxt1 = UI.Text:create()
    tabTxt1:init(UI.TEXT_1213612, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w1 = tabTxt1:getContentSize().width
    tabTxt1:setWidth(138)
    tabTxt1:setTextCenter()
    tabTxt1:autoAdapt()
    if w1 > 138 then
        tabTxt1:leftUp(0, 0)
    else
        tabTxt1:leftUp(0, 8)
    end
    tabTxt1:setLineSpacing(-6)
    titleBG:addChild(tabTxt1)

    local tabTxt2 = UI.Text:create()
    tabTxt2:init(UI.TEXT_1213613, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
    local w2 = tabTxt2:getContentSize().width
    tabTxt2:setWidth(138)
    tabTxt2:setTextCenter()
    tabTxt2:autoAdapt()
    if w2 > 138 then
        tabTxt2:leftUp(138, 0)
    else
        tabTxt2:leftUp(138, 8)
    end
    tabTxt2:setLineSpacing(-6)
    titleBG:addChild(tabTxt2)

    self:makeTabList()
    self:updateTabList()
end

function PetLookAttrView:makeTabList()
    local baseAttrLayer = UI.Layout:create();
    baseAttrLayer:init()
    baseAttrLayer:setSize(386, 436)
    baseAttrLayer:centerBottom(0)
    -- baseAttrLayer:enableDebugDraw()
    self.contentLayout:addChild(baseAttrLayer, 2)
    self.baseAttrLayer = baseAttrLayer
    self:showBaseAttr()

    local skillAttrLayer = UI.Layout:create();
    skillAttrLayer:init()
    skillAttrLayer:setSize(386, 436)
    skillAttrLayer:centerBottom(2000)
    self.contentLayout:addChild(skillAttrLayer, 2)
    self.skillAttrLayer = skillAttrLayer
    self:showSkillQuality()

    self.tabData = {}
    self.curTabIndex = 1
    self.lastTabIndex = 1

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_1213612
    tab1.select = true
    tab1.showLayer = function()
        self.tabSelect1:show()
        self.baseAttrLayer:centerBottom(0)
    end
    tab1.hideLayer = function()
        self.tabSelect1:hide()
        self.baseAttrLayer:centerBottom(2000)
    end

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_1213613
    tab2.select = false
    tab2.showLayer = function()
        self.tabSelect2:show()
        self.skillAttrLayer:centerBottom(0)
    end
    tab2.hideLayer = function()
        self.tabSelect2:hide()
        self.skillAttrLayer:centerBottom(2000)
    end

    table.insert(self.tabData, tab1)
    table.insert(self.tabData, tab2)
end

function PetLookAttrView:updateTabList(idx)
    if idx then
        self.curTabIndex = idx

        if self.tabData[self.lastTabIndex] then
            self.tabData[self.lastTabIndex].select = false
        end

        self.tabData[self.curTabIndex].select = true
        self.lastTabIndex = self.curTabIndex
    end

    for _, v in ipairs(self.tabData) do
        if v.select then
            v.showLayer()
        else
            v.hideLayer()
        end
    end
end

function PetLookAttrView:showBaseAttr()
    local maxLvLayer = UI.Layout:create();
    maxLvLayer:init()
    maxLvLayer:setSize(374, 38)
    maxLvLayer:centerUp(-4)
    self.baseAttrLayer:addChild(maxLvLayer)

    local maxLvIcon  = UI.Image:create();
    maxLvIcon:init("symbol_pets_levelcap.png");
    maxLvIcon:floatLeft(15);
    maxLvLayer:addComponent(maxLvIcon);

    local nameTxt = UI.Text:create()
    nameTxt:init(string.format(UI.TEXT_1213717, self.curPet.maxLV), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    nameTxt:floatLeft(5)
    maxLvLayer:addComponent(nameTxt)

    local expLayer = UI.Layout:create();
    expLayer:init()
    expLayer:setSize(374, 38)
    expLayer:centerUp(25)
    -- expLayer:enableDebugDraw()
    self.baseAttrLayer:addChild(expLayer)

    local expIcon  = UI.Image:create();
    expIcon:init("symbol_gaming_xp_cn.png");
    expIcon:floatLeft(15);
    expLayer:addComponent(expIcon);

    local nameTxt = UI.Text:create()
    nameTxt:init(UI.TEXT_1213618, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    nameTxt:floatLeft(5)
    expLayer:addComponent(nameTxt)

    local expTxt = UI.Text:create()
    local expStr = ""
    local curLv = self.curPet:getLevel()
    if curLv >= self.curPet.maxLV then
        expStr = "MAX"
    else
        local cfg = ConfigManager:getPetExpByID(curLv)
        local curLvMaxExp = 0
        if cfg then
            curLvMaxExp = cfg.expToNextLV
        end
        expStr = string.format("%d/%d", self.curPet:getCurExp(), curLvMaxExp)
    end
    expTxt:init(expStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    expTxt:floatLeft(5)
    expLayer:addComponent(expTxt)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(364, 1)
    splitLine:setCapInsets(CCRectMake(1,0,1,1))
    splitLine:setPosition(364/2, 0)
    expLayer:addChild(splitLine, 10)

    -- 属性内容
    local scrollContent = UI.Layout:create()
    scrollContent:init()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(386, 283)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:leftUp(0, 67)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarWidth(5)
    scrollView:setScrollBarColor(UI.BLACK)
    scrollView:setCircleVisible(false)
    scrollView:setName("AttrSV")
    -- scrollView:enableDebugDraw()

    scrollView:addInnerNode(scrollContent)
    self.baseAttrLayer:addChild(scrollView)
    scrollView:scrollToTop()

    self:assembleBaseAttr()
    for k, v in ipairs(self.attrData) do
        local oneBaseAttr = self:addOneBaseAttr(v)
        scrollContent:addChild(oneBaseAttr)
    end

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(364, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(364/2, 176))
    scrollContent:addChild(lineUpImage)

    for k, v in ipairs(self.otherAttrData) do
        local oneExtraAttr = self:addOneExtraAttr(v)
        scrollContent:addChild(oneExtraAttr)
    end

    scrollContent:setSize(386, 450)

    local mask  = UI.Image:create();
    mask:init("ui_pets_attribute_mask.png");
    mask:leftBottom(-1, 80);
    self.baseAttrLayer:addChild(mask);
end

function PetLookAttrView:assembleBaseAttr()
    self.attrData = mvc.petModel:getAllBaseAttr(self.curPet)
    self.otherAttrData = {}

    -- 横线以下的内容
    self.criticalParameter = tonumber(ConfigManager:getGeneralForKey("criticalParameter"))          --暴击等级换算成暴击率的系数，暂取7000
    self.physicPenetrateParameter = tonumber(ConfigManager:getGeneralForKey("physicPenetrateParameter"))   --物理穿透换算成物理穿透率的系数，暂取7000
    self.dodgeParameter = tonumber(ConfigManager:getGeneralForKey("dodgeParameter"))             --闪避等级换算成闪避率的系数，暂取7000
    self.blockParameter = tonumber(ConfigManager:getGeneralForKey("blockParameter"))             --格挡等级换算成格挡率的系数，暂取7000
    self.magicPenetrateParameter = tonumber(ConfigManager:getGeneralForKey("magicPenetrateParameter"))

    local xArr1 = {6, 6, 6, 6, 6}
    local yArr1 = {278, 308, 338, 368, 398}
    local names = {UI.TEXT_DES_BLOAK_LEVEL, UI.TEXT_DES_PENETRATE,
        UI.TEXT_DES_MAGIC_PENETRATE, UI.TEXT_DES_DODGE, UI.TEXT_DES_CRITICAL}
    local tipTxt = {UI.TEXT_1213734, UI.TEXT_1213736, UI.TEXT_1213737, UI.TEXT_1213739, UI.TEXT_1213738,}
    local otherValues = {}
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("block"), self.blockParameter)) -- 格挡
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("physicPenetrate"), self.physicPenetrateParameter)) -- 物理穿透
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("magicPenetrate"), self.magicPenetrateParameter)) -- 魔法穿透
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("dodge"), self.dodgeParameter)) -- 闪避
    table.insert(otherValues, self:getParames(self.curPet:getAttrByName("critical"), self.criticalParameter)) -- 暴击

    for k, v in ipairs(names) do
        local oneAttr = {}
        oneAttr.x = xArr1[k]
        oneAttr.y = yArr1[k]
        oneAttr.name = v
        oneAttr.val = otherValues[k]
        oneAttr.tipTxt = tipTxt[k]

        table.insert(self.otherAttrData, oneAttr)
    end
end

function PetLookAttrView:addOneBaseAttr(data)
    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(175, 32)
    innerLayer:leftUp(data.x, data.y)
    innerLayer:setTouchEnable(true)
    innerLayer:setInterceptTouches(false)
    innerLayer:setSwallowTouches(false)
    innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        local pos = innerLayer:convertToNodeSpace(touchPosition)
        local size = innerLayer:getContentSize()
        local offsetIdxX = data.idx <= 8 and 0 or 1
        local offsetIdxY = data.idx % 8
        if offsetIdxY == 0 then
            offsetIdxY = 8
        end
        local rect = cc.rect(data.x-offsetIdxX*180, data.y-(offsetIdxY-1)*34, size.width, size.height)
        if cc.rectContainsPoint(rect, pos) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, self.tipRevert, data.tipTxt)
        end
    end)
    innerLayer:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)

    local attrIcon  = UI.Image:create();
    attrIcon:init(data.icon);
    attrIcon:centerLeft(15);
    innerLayer:addChild(attrIcon);

    local attrVal = UI.Text:create()
    attrVal:init(tostring(data.val), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    attrVal:centerLeft(48)
    innerLayer:addChild(attrVal)

    return innerLayer
end

function PetLookAttrView:addOneExtraAttr(data)
    local innerLayer = UI.Layout:create();
    innerLayer:init()
    innerLayer:setSize(370, 32)
    innerLayer:leftUp(data.x, data.y)

    local attrType = UI.Text:create()
    attrType:init(data.name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_91_47_7)
    attrType:centerLeft(16)
    innerLayer:addChild(attrType)

    local attrVal = UI.Text:create()
    attrVal:init(tostring(data.val), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    attrVal:centerLeft(192)
    innerLayer:addChild(attrVal)

    return innerLayer
end

function PetLookAttrView:showSkillQuality()
    -- 资质部分
    local qualityLayer = UI.PetQualityLayer:create()
    qualityLayer:init(self.curPet, true)
    qualityLayer:leftUp(20, 0)
    self.skillAttrLayer:addChild(qualityLayer, 1);

    -- 技能
    local skillBG  = UI.Image:create();
    skillBG:init("ui_pets_skill_paper.png");
    skillBG:leftBottom(3, 76);
    self.skillAttrLayer:addChild(skillBG, 2);

    local skillLayer = UI.PetSkillLayer:create()
    skillLayer:init(self.curPet, true)
    skillLayer:leftUp(0, 0)
    skillBG:addChild(skillLayer, 1);
end

function PetLookAttrView:getParames(value, valueParameter)
    local newValue = value or 0
    valueParameter = valueParameter or 0

    local str = ""
    if(newValue == 0) then
        str = string.format("0%%")
    else 
        local yu = (newValue * 100/valueParameter)
        -- 这里的效率不好
        local zero = tonumber(string.format("%.0f",yu))
        local one = tonumber(string.format("%.1f",yu))
        local two = tonumber(string.format("%.2f",yu))
        if(zero == one) then
            if(one == two) then
                str = zero
            else 
                str = two
            end
        else 
            if(one == two) then
                str = one
            else 
                str = two
            end
        end 

        str = string.format("%s%%", str)
    end

    return str
end

function PetLookAttrView:bindModel()

end

function PetLookAttrView:unbindModel()

end

return PetLookAttrView

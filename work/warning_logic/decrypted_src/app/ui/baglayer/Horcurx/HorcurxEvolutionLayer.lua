-- HorcurxEvolutionLayer.lua
-- HorcurxLevel.lua
-- Using:魂器 
require("utils.ObserverVariable")
require("app.config.ConfigManager")
local LanguageManager = require "app.game.LanguageManager"
require "app.ui.baglayer.Horcurx.HorcurxDataManager"
require "app.datas.SkillDataManager"
require "app.ui.baglayer.Horcurx.SkillTips"
local GameDataManager = require("app.game.GameDataManager")
require("utils.UIUtil")

local winSize = cc.Director:getInstance():getWinSize()
local languageManagerInstance = LanguageManager:getInstance()
local winSize = cc.Director:getInstance():getWinSize()
local LayoutUtil = require "app.ui.UILayoutUtils"

UI = UI or {}

local HorcurxEvolutionLayer = class("HorcurxEvolutionLayer", UI.HWBtnComponent)
UI.HorcurxEvolutionLayer = HorcurxEvolutionLayer

local layoutUU 

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    -- "ui_common_information.plist",
    -- "ui_common_icon_skill.plist",
    "ui_package_skill.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function HorcurxEvolutionLayer:ctor()
    HorcurxEvolutionLayer.super.ctor(
    self,UIType.HORCURX_LAYER,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
    )
    self.rootLayer = nil;           --root节点

   
    self:registerListener();

    -- self:enableDebugDraw()
    layoutUU = LayoutUtil.new("evolution", "app.scene.mainscene.LayoutPosConfig", true)
end




function HorcurxEvolutionLayer:dtor()
    HorcurxEvolutionLayer.super.dtor(self)
    self:unRegisterListener();

    reload_script_file("app.ui.baglayer.Horcurx.HorcurxEvolutionLayer")
end

function HorcurxEvolutionLayer:onEvolutionResult(data)
    if data.isEvolution then
        UI.ScrollBar:createByText(UI.TEXT_1212416)
        -- animation
        self:showResultAnimation()
    end
end



-- 注册监听事件(可选)
function HorcurxEvolutionLayer:registerListener()
    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onEvolutionResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end


-- 注销监听事件(可选)
function HorcurxEvolutionLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onEvolutionResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

local function createOneDes(isShowBackground, desc, text, add)
    --202,21
    local com = UI.Component:create()
    com:init()
    com:setSize(253,21)

    if isShowBackground then
        local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_bg4.png")
        centerBg:setContentSize(253,22)
        centerBg:setCapInsets(CCRectMake(1,1,1,1))
        centerBg:setPosition(cc.p( 253/2,   22/2))
        com:addChild(centerBg)
    end


    local title = UI.Text:create()
    title:init(desc, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45 )
    title:setTextLeft()
    title:centerLeft(6)
    com:addChild(title)

    local title = UI.Text:create()
    title:init(tostring(text), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45 )
    title:setTextLeft()
    title:centerRight(88)
    com:addChild(title)

    local title = UI.Text:create()
    title:init(tostring(add), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_64_166_105 )
    title:setTextRight()
    title:centerRight(6)
    com:addChild(title)

    return com
end

function HorcurxEvolutionLayer:onCurrencyChangeHandler()
    local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.curEvolationLv)
    local costMoney = config.money
    local goodNumber = 0
    if costMoney[1] == 23020001 then
        goodNumber = RoleDataManager:getMaster():getCurCoin()
    else
        goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(costMoney[1], true)
    end
    if goodNumber < costNum then
        self.numberText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    else
        self.numberText:setFontColor(UI.FONT_COLOR_250_211_124)
    end
end

-- 初始化视图
function HorcurxEvolutionLayer:onInitView()
    local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    centerBg:setContentSize(COM_WIDTH, COM_HEIGHT)
    centerBg:setCapInsets(CCRectMake(304,141,1,1))
    centerBg:setPosition(cc.p( COM_WIDTH/2,   COM_HEIGHT/2))
    self:addChild(centerBg)

    -- local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_bg3.png")
    -- centerBg:setContentSize(273, 342)
    -- centerBg:setCapInsets(CCRectMake(11,11,1,1))
    -- addChildAuto(layoutUU, self, centerBg, "ui_scale9image_banner_bg3")


    local centerBg = UI.Image:create()
    centerBg:init("ui_horcux_evolution_bg_1.png")
    addChildAuto(layoutUU, self, centerBg, "ui_horcux_evolution_bg")

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(252, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    addChildAuto(layoutUU, self, lineUpImage, "lineUpImage")


    local img = UI.Image:create()
    img:init("ui_information_arrow_2.png")
    addChildAuto(layoutUU, self, img, "ui_information_arrow_2")


    local lv = HorcurxDataManager:getCurLevel()
    self.curEvolationLv = HorcurxDataManager:getHorcurxEvolutionLv(lv)

    local name = HorcurxDataManager:getHorcurxName(self.curEvolationLv)
    name = languageManagerInstance:getLocalString(name)
    name = name .. "\n" .. string.format(UI.TEXT_DES_LEVEL, self.curEvolationLv)
    local descText1 = UI.Text:create()
    descText1:init(name, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    descText1:setSize(200,100)
    descText1:setTextHorizontalCenterAndBottom()

    addChildAuto(layoutUU, self, descText1, "horcurxName")

    if not HorcurxDataManager:isMaxEvolationLv(self.curEvolationLv) then
        local name = HorcurxDataManager:getHorcurxName(self.curEvolationLv + 1)
        name = languageManagerInstance:getLocalString(name)
        name = name .. "\n" .. string.format(UI.TEXT_DES_LEVEL, self.curEvolationLv+1)
        local descText1 = UI.Text:create()
        descText1:init(name, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        descText1:setSize(200,100)
        descText1:setTextHorizontalCenterAndBottom()
        addChildAuto(layoutUU, self, descText1, "horcurxName2")
    end
    
    local descText1 = UI.Text:create()
    descText1:init(UI.TEXT_1212401, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    addChildAuto(layoutUU, self, descText1, "descText1")

    local descText1 = UI.Text:create()
    descText1:init(UI.TEXT_1212402, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    addChildAuto(layoutUU, self, descText1, "descText2")


    -- 金币背景
    local bg = UI.Image:create()
    bg:init("ui_information_hero_box_up.png")
    addChildAuto(layoutUU, self, bg, "ui_information_hero_box_up")


    local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.curEvolationLv)
    local costMoney = config.money
    local goodsData = GoodsDataManager:createLocalGoodsData(costMoney[1])

    -- 黄金图标
    local glodIcon = UI.Image:create()
    -- glodIcon:init("symbol_gaming_money.png")
    glodIcon:init(goodsData:getIconName())
    glodIcon:centerLeft(50)
    glodIcon:setScale(0.5)
    bg:addChild(glodIcon)
    local costNum = costMoney[2]
    -- 金币数字
    local number = UI.Text:create()
    number:init(costNum.."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
    number:centerLeft(glodIcon:getContentSize().width + 4)
    number:setTextCenter()
    bg:addChild(number)
    glodIcon:centerLeft(bg:getContentSize().width /2 - (glodIcon:getContentSize().width + number:getContentSize().width + 4)/2)


    if costMoney[1] == 23020001 then
        goodNumber = RoleDataManager:getMaster():getCurCoin()
    else
        goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(costMoney[1], true)
    end
    if goodNumber < costNum then
        number:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    end
    self.numberText = number

     -- 确认按钮
    local btn = UI.Button:create()
    btn:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_2.png")
    btn:centerBottom(41)
    btn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onGoToEvolution)
    btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    btn:setText(UI.TEXT_1212392)
    btn:centerBottom(-52)
    bg:addChild(btn)


    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(100, 20)
    layout:enableAutoWidth()
    
    local nextEvolutionConfig = {}
    if not HorcurxDataManager:isMaxEvolationLv(self.curEvolationLv) then
        nextEvolutionConfig = HorcurxDataManager:getHorcurxEvolutionConfig(self.curEvolationLv + 1)
    end

    local attrTags = {"atkMin",  "atkMax", "magic","hp","physicDef","magicDef"}
    for i = 1, #attrTags do
        local attrName = attrTags[i] .. "Qualifications"
        local attrStr = ToolsUtil:attrNameToLanguageString(attrTags[i])
        local val = config[attrName]
        local nextVal = nextEvolutionConfig[attrName]
        local addStr = ""
        if nextVal then
            addStr = "(+" .. (nextVal - val) .. ")"
        end
        local title = createOneDes((i%2)~=0, attrStr..UI.TEXT_1212393, val, addStr)
        title:floatUp(6)
        layout:addComponent(title)
    end
    addChildAuto(layoutUU, self, layout, "layout")

    local spineName = "effect_role_" .. config.position
    if(spineName and spineName ~= "") then 
        local com = UI.Component:create()
        com:init()
        com:setSize(100,200)
        addChildAuto(layoutUU, self, com, "animationHorcurx1")

        local _horcruxExteriorAnimation = Avalon.Animation:create(spineName..".json", spineName..".atlas", 1)
        _horcruxExteriorAnimation:setAnimation(0, "idle1", true)
        com:addChild(_horcruxExteriorAnimation)
    end
    self:showNextSkill()



end

function HorcurxEvolutionLayer:showResultAnimation(skillData)
    require "app.ui.baglayer.Horcurx.HorcurxEvolutionResultLayer" 
    local view = UI.HorcurxEvolutionResultLayer:create()
    view:init()
    UI.UIManager:getRootNode():addChild(view, UI_ZORDER.TIPS)

    Avalon.MessageCenter:notice(GameMessage.MC_UI_HORCURX_JUMP_VIEW, 1)
end

function HorcurxEvolutionLayer:createSkillBtn(skillData)
      -- 技能背景
    local itemBG = UI.Image:create()
    itemBG:init("ui_skill_banner_skillbox.png")
    itemBG:center()

    -- 技能图标
    local itemSp = UI.Image:create()
    itemSp:init(skillData:getIconName())
    itemSp:center()
    itemSp:setTouchEnable(true)
    itemSp:addEventListener(UIEvent.COMPONENT_CLICK, self,self.onClickSkillHandler)
    itemBG:addChild(itemSp,2)   

    return itemBG
end

function HorcurxEvolutionLayer:onClickSkillHandler()
    local tip = UI.SkillTips:create(self.skillData, self.curGroupIdLv, UIType.HORCURX_LAYER)
    tip:center(-40,30)
    tip:init()
    self:addChild(tip, 1000)
end

function HorcurxEvolutionLayer:showNextSkill()
    local skillInfos = HorcurxDataManager:getSkillInfosByEvolutionLv(self.curEvolationLv)
    if not HorcurxDataManager:isMaxEvolationLv(self.curEvolationLv) then
        local nextSkillInfos = HorcurxDataManager:getSkillInfosByEvolutionLv(self.curEvolationLv + 1)

        local skillId, lv = nextSkillInfos[1][1], nextSkillInfos[1][2]

        local skillData = HorcurxDataManager:getSkillData(skillId)
        local icon = self:createSkillBtn(skillData)
        self.skillData = skillData
        self.curGroupIdLv = lv
        addChildAuto(layoutUU, self, icon, "icon")
        icon:setScale(0.65)


        local descText1 = UI.Text:create()
        descText1:init(skillData:getName(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        addChildAuto(layoutUU, self, descText1, "skillName")

        local layout = UI.Layout:create()
        layout:init()
        addChildAuto(layoutUU, self, layout, "lvStr")


        local lvStr = UI.Text:create()
        lvStr:init(UI.TEXT_110046, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        -- addChildAuto(layoutUU, self, lvStr, "lvStr")
        lvStr:floatLeft(0)
        layout:addComponent(lvStr)


        local lvStr = UI.Text:create()
        lvStr:init(lv .. "", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_64_166_105)
        lvStr:floatLeft(5)
        layout:addComponent(lvStr)
        -- addChildAuto(layoutUU, self, lvStr, "lvStr2")
        
        -- 上机的图标
        local upgradeArrow = UI.Image:create()
        upgradeArrow:init("ui_information_arrow_up_02.png")
        -- addChildAuto(layoutUU, self, upgradeArrow, "upgradeArrow")
        upgradeArrow:setScale(0.65)
        upgradeArrow:floatLeft(5)
        layout:addComponent(upgradeArrow)

        local evoConfig = HorcurxDataManager:getHorcurxEvolutionConfig(self.curEvolationLv + 1)
        if(evoConfig) then 
            local spineName = "effect_role_" .. evoConfig.position
            if(spineName and spineName ~= "") then 
                local com = UI.Component:create()
                com:init()
                com:setSize(100,200)
                addChildAuto(layoutUU, self, com, "animationHorcurx")

                local _horcruxExteriorAnimation = Avalon.Animation:create(spineName..".json", spineName..".atlas", 1)
                _horcruxExteriorAnimation:setAnimation(0, "idle1", true)
                com:addChild(_horcruxExteriorAnimation)
                self.nextAnimatin = _horcruxExteriorAnimation
                com:hide()
                Avalon.Scheduler:scheduleUpdateOnce(self, function()
                    if tolua.isnull(self) then
                        return
                    end
                    com:show()
                    
                    local glProgramState = AvalonUtil:getAnimationGrayGLProgramState()
                    if self.nextAnimatin._spine then
                        self.nextAnimatin._spine :setGLProgramState(glProgramState)
                    end
                end,0.08)
            end
        end
    end
end

function HorcurxEvolutionLayer:onGoToEvolution()
    local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.curEvolationLv)
    local costMoney = config.money
    local goodNumber = 0
    if costMoney[1] == 23020001 then
        goodNumber = RoleDataManager:getMaster():getCurCoin()
    else
        goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(costMoney[1], true)
    end
    print("goodNumber", goodNumber, costMoney[1])
    if goodNumber < costMoney[2] then
        UI.ScrollBar:createByText(UI.TEXT_110210)
        return
    end

    Net.NetRoleSystem:reqHorcurxEvolutionUp()
end









-- HorcurxLevel.lua
-- Using:魂器 
require("utils.ObserverVariable")
require("app.config.ConfigManager")
require("utils.UIUtil")
local LanguageManager = require "app.game.LanguageManager"
require "app.ui.baglayer.Horcurx.HorcurxDataManager"
require "app.ui.baglayer.Horcurx.SkillTips"
local SceneManager = require("app.game.SceneManager")
local winSize = cc.Director:getInstance():getWinSize()
local languageManagerInstance = LanguageManager:getInstance()
require "app.ui.baglayer.RoleShow.RoleAnimation"
local LayoutUtil = require "app.ui.UILayoutUtils"


UI = UI or {}

local HorcurxLevelLayer = class("HorcurxLevelLayer", UI.HWBtnComponent)
UI.HorcurxLevelLayer = HorcurxLevelLayer

local layoutUU 

-- 关卡选择资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    -- "ui_common_scale9image.plist",
    -- "ui_common_btn.plist",
    -- "ui_common_symbol.plist",
    -- "ui_common_information.plist",
    -- "ui_common_icon_skill.plist",
    "ui_package_skill.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function HorcurxLevelLayer:ctor()
    HorcurxLevelLayer.super.ctor(
        self,
        UIType.HORCURX_LAYER,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.rootLayer = nil -- root节点

    self:registerListener()

    layoutUU = LayoutUtil.new("viewName", "app.scene.mainscene.LayoutPosConfig", false)

end

function HorcurxLevelLayer:dtor()
    HorcurxLevelLayer.super.dtor(self)
    self:unRegisterListener()

    reload_script_file("app.ui.baglayer.Horcurx.HorcurxLevelLayer")
end

-- local lastClickTime = 0
function HorcurxLevelLayer:checkAndSendLvUP(handleType)
    local times = HorcurxDataManager:getTodayCanUpgradeRemindAndMaxTime()
    local info = times[handleType]
    if not info then return end

    -- local curtime = os.clock()
    -- if curtime - lastClickTime < 0.5 then
    --     return
    -- end
    -- lastClickTime = curtime


    local curTime = info[1]
    local maxTime = info[2]
    local cost = tonumber(info[3])
    if curTime >= maxTime then
        UI.ScrollBar:createByText(UI.TEXT_1212412)
        return
    end

--check level

    local config = HorcurxDataManager:getUpgradeConfigByLevel(self.lv)
    local master = RoleDataManager:getMaster()
    local playerLv  = master:getLevel()
    if playerLv  < config.palyerlevel then
        UI.ScrollBar:createByText(string.format(UI.TEXT_1212474, config.palyerlevel))
        return
    end

    self.lastClickType = handleType
    local coin = 0
    if handleType == 1 then
        coin = RoleDataManager:getMaster():getCurCoin()
        if coin < cost then
            UI.ScrollBar:createByText(UI.TEXT_110210)
            return
        end
    elseif handleType == 2 then
        coin = RoleDataManager:getMaster():getDiamond()
        if not Avalon.MathUtil:checkDiamonEnough(cost, coin) then
            UI.ScrollBar:createByText(UI.TEXT_1212413)
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
    elseif handleType == 3 then
        coin = RoleDataManager:getMaster():getHorcruxCoin()
        if coin < cost then
            UI.ScrollBar:createByText(UI.TEXT_1212414)
            return
        end
    end

    if (handleType == 1 or handleType == 2) then
        UI.WaitingLayer:showWaiting(true, nil, 5)
        Net.NetRoleSystem:reqHorcurxLvUp(handleType)
    elseif (handleType == 3) then
        local useNumber = coin > 999 and 999 or coin
        UI.TipsLayer:onBuyAmount(function(number)   -- 确认回调
            UI.WaitingLayer:showWaiting(true, nil, 5)
            Net.NetRoleSystem:reqHorcurxLvUp(handleType,number)
        end, nil, 1, PublicDefine.GOODS_COST_TYPE.HORCRUX_COIN, useNumber, false)
    end
    
end

local function createOneBtn(self, str, imgName, cost, upStr, enough, btntype)
    local layout = UI.Component:create()
    layout:init()
    layout:setSize(202, 44)
    local btn = UI.Button:create()
    btn:init(
        "ui_btn_yellow5_0.png",
        "ui_btn_yellow5_1.png",
        "ui_btn_yellow5_2.png"
    )
    btn:addEventListener(
        UIEvent.BUTTON_CLICK,
        btn,
        function() self:checkAndSendLvUP(btntype) end
    )

    local layout2 = UI.Layout:create()
    layout2:init()
    layout2:enableAutoWidth()
    layout2:center()
    btn:addChild(layout2, 1001)
    -- 82,24
    local img = UI.Image:create()
    img:init(imgName)
    -- local size = img:getContentSize()
    -- if size.width > 40 then
    --     local scale = 40/size.width
    --     img:setScale(scale)
    -- end
    img:floatLeft(5)
    layout2:addComponent(img)

    local coin
    local color = UI.FONT_COLOR_50_50_44
    local textStr = tostring(cost)
    if btntype == 1 then
        coin = RoleDataManager:getMaster():getCurCoin()
    elseif btntype == 2 then
        coin = RoleDataManager:getMaster():getDiamond()
    elseif btntype == 3 then
        coin = RoleDataManager:getMaster():getHorcruxCoin()
        textStr = ""
    end
    if not Avalon.MathUtil:checkDiamonEnough(cost, coin) then color = UI.FONT_COLOR_NOT_ENOUGH end

    local text = UI.Text:create()
    text:init(
        textStr,
        UI.FONT_BOLD,
        UI.FONT_SIZE_16PX,
        color
    )
    text:floatLeft(8)
    layout2:addComponent(text)

    if not enough then
        local text = UI.Text:create()
        text:init(
            upStr,
            UI.FONT_STANDARD,
            UI.FONT_SIZE_14PX,
            UI.FONT_COLOR_80_5_5
        )
        text:centerBottom(50)
        btn:addChild(text, 10001)
    else
        local layout2 = UI.Layout:create()
        layout2:init()
        layout2:enableAutoWidth()
        local text = UI.Text:create()
        text:init(
            tostring(str),
            UI.FONT_BOLD,
            UI.FONT_SIZE_20PX,
            UI.FONT_COLOR_50_50_44
        )
        text:floatLeft(0)
        layout2:addComponent(text)
        if upStr then
            local text = UI.Text:create()
            text:init(
                "(" .. upStr .. ")",
                UI.FONT_STANDARD,
                UI.FONT_SIZE_14PX,
                UI.FONT_COLOR_15_85_71
            )
            text:floatLeft(5)
            layout2:addComponent(text)
        end
        layout2:centerBottom(60)
        btn:addChild(layout2, 10001)
    end
    layout:addChild(btn)

    return layout
end

function HorcurxLevelLayer:createSkillBtn(skillData, lv)

    local com = UI.Component:create()
    com:init()
    -- 技能背景
    local itemBG = UI.Image:create()
    itemBG:init("ui_skill_banner_skillbox.png")
    itemBG:center()
    local size = itemBG:getContentSize()
    com:setSize(size.width, size.height)
    com:addChild(itemBG)
    -- 技能图标
    local itemSp = UI.Image:create()
    itemSp:init(skillData:getIconName())
    itemSp:center()
    itemBG:addChild(itemSp, 2)
    itemBG:setScale(0.65)

    local text = UI.Text:create()
    text:init(
        skillData:getName(),
        UI.FONT_STANDARD,
        UI.FONT_SIZE_14PX,
        UI.FONT_COLOR_236_213_153
    )
    text:centerBottom(72)
    text:setTextHorizontalCenterAndBottom()
    text:setSize(size.width, 40)
    com:addChild(text, 10)

    local text = UI.Text:create()
    text:init(
        "",
        UI.FONT_BOLD,
        UI.FONT_SIZE_14PX,
        UI.FONT_COLOR_41_41_45
    )
    text:centerBottom(0)
    com:addChild(text, 10)

    local itemSelect = UI.Image:create()
    itemSelect:init("ui_horcux_click.png")
    itemSelect:center()
    com:addChild(itemSelect, 2)
    itemSelect:hide()
    com.itemSelect = itemSelect
    com.skillData = skillData
    com.lv = lv
    com:setTouchEnable(true)
    com:addEventListener(
        UIEvent.COMPONENT_CLICK,
        self,
        self.onClickSkillHandler
    )
    return com
end

function HorcurxLevelLayer:onClickSkillHandler(com, touchPosition)
    self.curSelectSkillIcon = com
    com.itemSelect:show()

    local tip = UI.SkillTips:create(com.skillData, com.lv, UIType.HORCURX_LAYER)
    tip:leftBottom(COM_WIDTH / 2 - 35, 120)
    tip:init()
    self:addChild(tip, 1000)

end

function HorcurxLevelLayer:refreshSelectSkillIcon()
    if self.curSelectSkillIcon and self.curSelectSkillIcon.itemSelect then 
        self.curSelectSkillIcon.itemSelect:hide() 
    end
end

-- 初始化视图
function HorcurxLevelLayer:onInitView()
    local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    centerBg:setContentSize(COM_WIDTH, COM_HEIGHT)
    centerBg:setCapInsets(CCRectMake(304, 141, 1, 1))
    centerBg:setPosition(cc.p(COM_WIDTH / 2, COM_HEIGHT / 2))
    self:addChild(centerBg)

    -- 货币组件
    self._currencyPanel = UI.CurrencyPanel:create()
    self._currencyPanel:rightUp(135, 81 - 14.5 --[[货币组件空白高度大小]] )
    self._currencyPanel:setShowShopButton(true, 52)
    addChildAuto(
        layoutUU,
        self,
        self._currencyPanel,
        "_currencyPanel"
    )

    local animation2 = UI.Animation:create()
    animation2:init(
        "effect_ui_horcruxes_down.json",
        "effect_ui_horcruxes_down.atlas",
        1
    )
    -- animation2:setAnimation("unlock", false)
    animation2:setAnimation("idle1", true)
    addChildAuto(layoutUU, self, animation2, "animation2")
    animation2:setSize(100, 50)
    -- animation2:enableDebugDraw()

    -- local img = UI.Image:create()
    -- img:init("ui_horcux_click_bg_1.png")
    -- addChildAuto(layoutUU, self, img, "ui_horcux_click_bg_1")

    -- local img = UI.Image:create()
    -- img:init("ui_upgrade_mask.png")
    -- addChildAuto(layoutUU, self, img, "ui_upgrade_mask")

    local progressTimerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_progressbar_box.png")
    progressTimerBg:setContentSize(586, 11)
    progressTimerBg:setCapInsets(CCRectMake(50, 4, 1, 1))
    addChildAuto(layoutUU, self, progressTimerBg, "progressTimerBg")

    local lockEff = UI.Animation:create()
    lockEff:init(
        "effect_ui_horcruxes_bu.json",
        "effect_ui_horcruxes_bu.atlas",
        1
    )
    -- lockEff:setAnimation("unlock", false)
    lockEff:setAnimation("idle1", true)
    addChildAuto(layoutUU, self, lockEff, "ui_upgrade_mask")
    lockEff:setSize(100, 50)

    local lv = HorcurxDataManager:getCurLevel()
    self.curEvolationLv = HorcurxDataManager:getHorcurxEvolutionLv(lv)

    -- 角色动画
    local heroData = clone(RoleDataManager:getMaster())
    heroData:setLooks(0)
    heroData:setextraLooks(0)
    self._roleAnimation = UI.RoleAnimation:create(false)
    self._roleAnimation:init(heroData)
    -- self._roleAnimation:init(RoleDataManager:getMaster())
    self._roleAnimation:setRoleData(heroData)
    self._roleAnimation:showHelmet(true)
    -- self._roleAnimation:setRoleData(RoleDataManager:getMaster())
    
    -- self:addChild(self._roleAnimation, 13)
    addChildAuto(layoutUU, self, self._roleAnimation, "roleAnimation")

    self:createContentView()
end

function HorcurxLevelLayer:showUpdate()
    self._roleAnimation:onUpdateView()
end

function HorcurxLevelLayer:onUpdateView() self:showHorcruxAnimation() end

function HorcurxLevelLayer:showHorcruxAnimation()
    -- local config = HorcurxDataManager:getHorcurxEvolutionConfig(HorcurxDataManager:getHorcurxIllusionId())
    -- local spineName = config.position
    -- local com = UI.Component:create()
    -- com:init()
    -- com:leftBottom(320, 349)
    -- self.updateNode:addChild(com)

    -- local _horcruxExteriorAnimation = Avalon.Animation:create(spineName..".json", spineName..".atlas", 1)
    -- _horcruxExteriorAnimation:setAnimation(0, "idle1", true)
    -- _horcruxExteriorAnimation:setScale(0.4)
    -- com:addChild(_horcruxExteriorAnimation)
    if RoleDataManager:getMaster():isHorcruxTransform() then
        return
    end

    self._roleAnimation:getRoleRender():showHorcruxExterior(HorcurxDataManager:getHorcurxIllusionId())
end

local attrImgMap={
    {"atkMin", "symbol_gaming_atk.png"},
    {"atkMax","symbol_gaming_atk.png"},
    {"physicDef","symbol_gaming_def.png"},
    {"magicDef","symbol_gaming_maggicdef.png"},
    {"hp","symbol_gaming_blood.png"},
    {"magic","symbol_gaming_maggicatk.png"},
    {"atkFire",string.format("symbol_monsterattribute_%s_1.png","fire")},
    {"defFire",string.format("symbol_monsterattribute_%s_2.png","fire")},
    {"atkWater",string.format("symbol_monsterattribute_%s_1.png","water")},
    {"defWater",string.format("symbol_monsterattribute_%s_2.png","water")},
    {"atkWood",string.format("symbol_monsterattribute_%s_1.png","wood")},
    {"defWood",string.format("symbol_monsterattribute_%s_2.png","wood")},
    {"atkLight",string.format("symbol_monsterattribute_%s_1.png","light")},
    {"defLight",string.format("symbol_monsterattribute_%s_2.png","light")},
    {"atkDark",string.format("symbol_monsterattribute_%s_1.png","dark")},
    {"defDark",string.format("symbol_monsterattribute_%s_2.png","dark")},
}
local function getAttrImg(attrName)
    for key, v in pairs(attrImgMap) do
        if v[1] == attrName then
            return v[2]
        end
    end
end

local function createOneDes(isShowBackground, desc, text, color, attrName)
    -- 202,21
    local com = UI.Component:create()
    com:init()
    com:setSize(202, 21)
    color = color or UI.FONT_COLOR_41_41_45
    if isShowBackground then
        local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_bg4.png")
        centerBg:setContentSize(202, 22)
        centerBg:setCapInsets(CCRectMake(1, 1, 1, 1))
        centerBg:setPosition(cc.p(202 / 2, 22 / 2))
        com:addChild(centerBg)
    end
    local imgStr = getAttrImg(attrName)
    local img = UI.Image:create()
    img:init(imgStr)
    img:centerLeft(0)
    com:addChild(img)

    local title = UI.Text:create()
    title:init(
        desc,
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_41_41_45
    )
    title:setTextLeft()
    title:centerLeft(26)
    com:addChild(title)

    local title = UI.Text:create()
    title:init(
        tostring(text),
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        color
    )
    title:setTextRight()
    title:centerRight(6)
    com:addChild(title)

    return com
end

function HorcurxLevelLayer:createAttr(tab)
    local com = UI.Component:create()
    com:init()

    local descText1 = UI.Text:create()
    descText1:init(
        tab.name,
        UI.FONT_BOLD,
        UI.FONT_SIZE_18PX,
        UI.FONT_COLOR_41_41_45
    )
    com:addChild(descText1)

    local height = descText1:getContentSize().height - 18

    local len = #tab.attrName
    local isShowBackground = false
    for i = 1, len, 2 do
        isShowBackground = not isShowBackground
        height = height + 21 +4

        local attrStr = ToolsUtil:attrNameToLanguageString(tab.attrName[i])
        local des
        if tab.isAdd then
            des = createOneDes(
                isShowBackground,
                attrStr,
                tab.attrVal[i],
                UI.FONT_COLOR_15_85_71,
                tab.attrName[i]
            )
        else
            des = createOneDes(isShowBackground, attrStr, tab.attrVal[i],nil, tab.attrName[i])
        end
        des:leftUp(5, height)
        com:addChild(des)

        if tab.attrName[i + 1] then
            local attrStr2 = ToolsUtil:attrNameToLanguageString(tab.attrName[i + 1])
            local des
            if tab.isAdd then
                des = createOneDes(
                    isShowBackground,
                    attrStr2,
                    tab.attrVal[i + 1],
                    UI.FONT_COLOR_15_85_71,
                    tab.attrName[i + 1]
                )
            else
                des = createOneDes(isShowBackground, attrStr2, tab.attrVal[i + 1],nil, tab.attrName[i + 1])
            end
            des:leftUp(205, height)
            com:addChild(des)
        end
    end
    com:setSize(404, height)
    return com
end

function HorcurxLevelLayer:createContentView()
    if self.updateNode then self.updateNode:removeFromParent() end
    self.updateNode = UI.Component:create()
    self.updateNode:init()
    self.updateNode:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(self.updateNode)

    self.skillNode = UI.Layout:create()
    self.skillNode:init()
    self.skillNode:setSize(COM_WIDTH, COM_HEIGHT)
    self.skillNode:center()
    self.updateNode:addChild(self.skillNode)

    local lv = HorcurxDataManager:getCurLevel()
    self.lv = lv
    self.curEvolationLv = HorcurxDataManager:getHorcurxEvolutionLv(lv)

    local config = HorcurxDataManager:getUpgradeConfigByLevel(lv)

    local com = UI.Component:create()
    com:init()
    -- com:setSize(5,5)
    -- com:enableDebugDraw()
    addChildAuto(layoutUU, self.updateNode, com, "horcurxName")

    local name = HorcurxDataManager:getHorcurxName(self.curEvolationLv)
    local descText1 = UI.Text:create()
    descText1:init(
        languageManagerInstance:getLocalString(name),
        UI.FONT_BOLD,
        UI.FONT_SIZE_18PX,
        UI.FONT_COLOR_41_41_45
    )
    descText1:center()
    com:addChild(descText1)
    self.descText1 = descText1

    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:centerBottom(-22)
    local img = UI.Image:create()
    img:init("ui_information_equip.png")
    img:floatLeft(0)
    layout:addComponent(img)

    local descText1 = UI.Text:create()
    descText1:init(
        tostring(HorcurxDataManager:getHorcurxScore(lv)),
        UI.FONT_BOLD,
        UI.FONT_SIZE_18PX,
        UI.FONT_COLOR_41_41_45
    )
    descText1:floatLeft(5)
    layout:addComponent(descText1)
    self.descText2 = descText1
    com:addChild(layout)

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init(
        "ui_scale9image_banner_line_long.png",
        CCRectMake(20, 1, 1, 1),
        cc.size(426, 2)
    )
    addChildAuto(layoutUU, self.updateNode, splitLine, "longdarkline")

    local attrVal = {}
    local attrName = {}
    for i = 1, #attrImgMap do 
        attrName[i] = attrImgMap[i][1]
        attrVal[i] = config[attrImgMap[i][1]] 
    end

    local com = self:createAttr({
        name = UI.TEXT_1212397,
        attrName = attrName,
        attrVal = attrVal
    })
    addChildAuto(layoutUU, self.updateNode, com, "layout")
    self.attrLayout = com

    -- local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    -- lineUpImage:setContentSize(397, 1)
    -- lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    -- addChildAuto(
    --     layoutUU,
    --     self.updateNode,
    --     lineUpImage,
    --     "lineUpImage"
    -- )

    -- local evolutionConfig = HorcurxDataManager:getEvolutionConfigByGradeLevel(lv)
    -- local attrVal = {}
    -- for i = 1, #attrName do
    --     local attrName1 = attrName[i] .. "Qualifications"
    --     local val = evolutionConfig[attrName1]
    --     attrVal[i] = val
    -- end

    -- local com = self:createAttr({
    --     name = UI.TEXT_1212398,
    --     attrName = attrName,
    --     attrVal = attrVal
    -- })
    -- addChildAuto(layoutUU, self.updateNode, com, "layout2")

    -- local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    -- lineUpImage:setContentSize(397, 1)
    -- lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    -- addChildAuto(
    --     layoutUU,
    --     self.updateNode,
    --     lineUpImage,
    --     "lineUpImage2"
    -- )

    local nextLvConfig = HorcurxDataManager:getUpgradeConfigByLevel(lv + 1)
    if nextLvConfig then
        local attrNameTemp = {}
        local attrVal = {}
        for i = 1, #attrName do
            local add = nextLvConfig[attrName[i]] - config[attrName[i]]
            if add > 0 then
                table.insert(attrNameTemp, attrName[i])
                table.insert(attrVal, "+" .. add)
            end
        end

        local com = self:createAttr({
            name = UI.TEXT_1212399,
            attrName = attrNameTemp,
            attrVal = attrVal,
            isAdd = true
        })
        addChildAuto(layoutUU, self.updateNode, com, "layout3", "leftUp")
        self.nextAttrLayout = com
    end

    local centerBg = cc.Sprite:createWithSpriteFrameName("ui_horcrux_banner_progressbar_up.png")
    local ptimer = cc.ProgressTimer:create(centerBg)
    ptimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    ptimer:setMidpoint(cc.p(0, 0))
    ptimer:setBarChangeRate(cc.p(1, 0))
    addChildAuto(layoutUU, self.updateNode, ptimer, "ptimer")

    local per = HorcurxDataManager:getExpPercent(lv) * 100
    ptimer:setPercentage(per)
    self.ptimer = ptimer

    self:createBtnArea()

    self:updateSkillIconArea()
end

function HorcurxLevelLayer:updateContentView()
    -- 是否进阶最后一下的标识
    local isEndOne = false
    local lv = HorcurxDataManager:getCurLevel()
    if self.lv and self.lv ~= lv then
        isEndOne = true
    end
    self.lv = lv
    self.curEvolationLv = HorcurxDataManager:getHorcurxEvolutionLv(lv)
    local config = HorcurxDataManager:getUpgradeConfigByLevel(lv)

    local name = HorcurxDataManager:getHorcurxName(self.curEvolationLv)
    self.descText1:setText(languageManagerInstance:getLocalString(name))
    self.descText2:setText(tostring(HorcurxDataManager:getHorcurxScore(lv)))

    if isEndOne then
        local attrVal = {}
        local attrName = {}
        for i = 1, #attrImgMap do 
            attrName[i] = attrImgMap[i][1]
            attrVal[i] = config[attrImgMap[i][1]] 
        end

        if self.attrLayout and not tolua.isnull(self.attrLayout) then
            self.attrLayout:removeFromParent()

            local com = self:createAttr({
                name = UI.TEXT_1212397,
                attrName = attrName,
                attrVal = attrVal
            })
            addChildAuto(layoutUU, self.updateNode, com, "layout")
            self.attrLayout = com
        end

        if self.nextAttrLayout and not tolua.isnull(self.nextAttrLayout) then
            self.nextAttrLayout:removeFromParent()
            local nextLvConfig = HorcurxDataManager:getUpgradeConfigByLevel(lv + 1)
            if nextLvConfig then
                local attrNameTemp = {}
                local attrVal = {}
                for i = 1, #attrName do
                    local add = nextLvConfig[attrName[i]] - config[attrName[i]]
                    if add > 0 then
                        table.insert(attrNameTemp, attrName[i])
                        table.insert(attrVal, "+" .. add)
                    end
                end

                local com = self:createAttr({
                    name = UI.TEXT_1212399,
                    attrName = attrNameTemp,
                    attrVal = attrVal,
                    isAdd = true
                })
                addChildAuto(layoutUU, self.updateNode, com, "layout3", "leftUp")
                self.nextAttrLayout = com
            end
        end
    end

    local per = HorcurxDataManager:getExpPercent(lv) * 100
    self.ptimer:setPercentage(per)

    self:updateBtnArea()

    self:updateSkillIconArea()
end

function HorcurxLevelLayer:createBtnArea()
    if self.btnAreaNode then
        self.btnAreaNode:removeFromParent()
        self.btnAreaNode = nil
    end

    self.btnAreaNode = UI.Component:create()
    self.btnAreaNode:init()
    self.btnAreaNode:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(self.btnAreaNode)

    local horcurxImg = UI.Image:create()
    horcurxImg:init("symbol_horcrux.png")
    horcurxImg:setScale(0.9)
    addChildAuto(layoutUU, self.btnAreaNode, horcurxImg, "horcurxImg")

    local coin = RoleDataManager:getMaster():getHorcruxCoin()
    local text = UI.Text:create()
    text:init(
        coin .. "",
        UI.FONT_STANDARD,
        UI.FONT_SIZE_14PX,
        UI.FONT_COLOR_41_41_45
    )
    addChildAuto(layoutUU, self.btnAreaNode, text, "horcurxCoin")
    self.horcurxCoinText = text

    if not (SceneManager:getInstance():isNotInFightScene()) then
        local layout = UI.Layout:create()
        layout:init()
        layout:enableAutoWidth()
        layout:centerBottom(48)
        self.btnAreaNode:addChild(layout)

        local max = UI.Image:create()
        max:init("ui_information_reminder.png")
        max:floatLeft(8)
        layout:addComponent(max)

        local text = UI.Text:create()
        text:init(
            UI.TEXT_1212411,
            UI.FONT_STANDARD,
            UI.FONT_SIZE_18PX,
            UI.FONT_COLOR_80_5_5
        )
        text:floatLeft(9)
        layout:addComponent(text)
        return
    end

    local isToNext, nextEvoId = HorcurxDataManager:isCanEvolutionToNext()
    if isToNext or nextEvoId < self.curEvolationLv then
        if isToNext then
            local btn = UI.Button:create()
            btn:init(
                "ui_btn_yellow5_0.png",
                "ui_btn_yellow5_1.png",
                "ui_btn_yellow5_2.png"
            )
            local componet = UIUtil:createAdaptTextComponent(
                UI.TEXT_1212403,
                UI.FONT_BOLD,
                UI.FONT_SIZE_20PX,
                UI.FONT_COLOR_50_50_44,
                160
            )
            componet:center()
            btn:addChild(componet, 1000)
            btn:addEventListener(
                UIEvent.BUTTON_CLICK,
                self,
                function()
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_HORCURX_JUMP_VIEW, 2)
                end
            )
            addChildAuto(layoutUU, self.btnAreaNode, btn, "btnXXX2")
        end
        local max = UI.Image:create()
        max:init("ui_information_max_2.png")
        addChildAuto(layoutUU, self.btnAreaNode, max, "maxPos")

        local layout = UI.Layout:create()
        layout:init()
        layout:enableAutoWidth()
        layout:centerBottom(70)
        self.btnAreaNode:addChild(layout)

        local max = UI.Image:create()
        max:init("ui_information_reminder.png")
        max:floatLeft(8)
        layout:addComponent(max)
        local str = UI.TEXT_1212420
        if isToNext then
            str = UI.TEXT_1212421
            layout:centerBottom(75)
        end

        local text = UI.Text:create()
        text:init(
            str,
            UI.FONT_STANDARD,
            UI.FONT_SIZE_18PX,
            UI.FONT_COLOR_80_5_5
        )
        text:floatLeft(9)
        layout:addComponent(text)

        local eff = UI.Animation:create()
        eff:init(
            "effect_ui_horcruxes_levelup_pgs.json",
            "effect_ui_horcruxes_levelup_pgs.atlas",
            1
        )
        eff:setAnimation("idle1", true)
        eff:center(0, -2)
        self.ptimer:addChild(eff)
        return
    end

    local text = UI.Text:create()
    text:init(
        "Lv." .. self.lv,
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_226_183_86
    )
    addChildAuto(layoutUU, self.btnAreaNode, text, "text")

    local config = HorcurxDataManager:getUpgradeConfigByLevel(self.lv)

    local curExp = HorcurxDataManager:getCurExp()
    local maxExp = config.expToNextLV
    local text = UI.Text:create()
    local maxStr = maxExp
    local curStr = curExp
    if maxExp > 99999 then maxStr = AvalonUtil:getSimpleNumber(maxExp, 5) end
    if curExp > 99999 then curStr = AvalonUtil:getSimpleNumber(curExp, 5) end
    text:init(
        curStr .. "/" .. maxStr,
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_SHARE_EQUIP_GUILD
    )
    addChildAuto(layoutUU, self.btnAreaNode, text, "text2")

    local times = HorcurxDataManager:getTodayCanUpgradeRemindAndMaxTime()

    local btnsInfo = {
        {UI.TEXT_1212394, "symbol_gaming_money.png"},
        {UI.TEXT_1212395, "symbol_gaming_diamond.png"},
        {UI.TEXT_1212396, "symbol_horcrux.png"},

    }
    self.btns = {}

    for i = 1, #times do
        local curTime = times[i][1]
        local maxTime = times[i][2]
        local cost = times[i][3]

        local str
        if curTime == maxTime then
            str = UI.TEXT_1212400
        elseif curTime < maxTime and maxTime < 100 then
            str = curTime .. "/" .. maxTime
        end

        local btn1 = createOneBtn(
            self,
            btnsInfo[i][1],
            btnsInfo[i][2],
            tonumber(cost),
            str,
            curTime ~= maxTime,
            i
        )
        addChildAuto(layoutUU, self.btnAreaNode, btn1, "btnXXX" .. i)
        self.btns[i] = btn1
    end

end

function HorcurxLevelLayer:updateBtnArea()
    self:createBtnArea()
end

function HorcurxLevelLayer:updateSkillIconArea()
    if self.skillNode then
        self.skillNode:removeAllChildren()
    end
    local nextSkillInfos = HorcurxDataManager:getSkillInfosByEvolutionLv(self.curEvolationLv)
    local len = #nextSkillInfos > 2 and 2 or #nextSkillInfos
    for i = 1, len do
        local skillId, lv = nextSkillInfos[i][1], nextSkillInfos[i][2]
        local skillData = HorcurxDataManager:getSkillData(skillId)
        local icon = self:createSkillBtn(skillData, lv)
        addChildAuto(layoutUU, self.skillNode, icon, "icon" .. i)
    end
end

function HorcurxLevelLayer:onLvResultBack(data)
    if data.isUpLv then
        if data.isLevelChanged then
            UI.ScrollBar:createByText(UI.TEXT_1212415)
        else
            UI.ScrollBar:createByText(UI.TEXT_1212419)
        end
        self:updateContentView()
        self:showHorcruxAnimation()
        -- if data.isLevelChanged then
        --     --animation
        -- end

        if data.isCritical then

            if not tolua.isnull(self.btns[self.lastClickType]) then
                local lockEff = UI.Animation:create()
                lockEff:init(
                    "effect_ui_horcruxes_levelup_button.json",
                    "effect_ui_horcruxes_levelup_button.atlas",
                    1
                )
                lockEff:setAnimation("idle1", false)
                lockEff:center()
                self.btns[self.lastClickType]:addChild(lockEff)
            end
        end

        if (self._waitingNum == nil) then self._waitingNum = 0 end

        local delayTime = self._waitingNum * 0.5
        if (delayTime < 0) then delayTime = 0 end

        -- 处理金币以及钻石表现
        local text = UI.Text:create()
        text:init("", UI.FONT_ARIAL)
        text:centerBottom(10)
        text:setFontColor(UI.FONT_COLOR_GREEN)
        text:setText(string.format("+%d", data.addExp or 99))
        text:updateView()
        text:setVisible(false)
        text:leftBottom(727, 92)
        self:addChild(text)
        -- addChildAuto(layoutUU, self, text, "maxPos")
        Avalon.Scheduler:scheduleUpdateOnce(
            self,
            function()
                if (self and not tolua.isnull(self)) then
                    text:setVisible(true)
                    text:runAction(cc.Spawn:create(
                        cc.MoveBy:create(0.5, cc.p(0, 20)),
                        cc.Sequence:create(
                            cc.DelayTime:create(0.4),
                            cc.FadeOut:create(0.1),
                            cc.RemoveSelf:create(),
                            cc.CallFunc:create(function() self._waitingNum = self._waitingNum - 1 end)
                        )
                    ))
                end
            end,
            delayTime
        )
        self._waitingNum = self._waitingNum + 1

        if self.lastClickType == 3 then
            if (self._waitingNum2 == nil) then self._waitingNum2 = 0 end

            local delayTime = self._waitingNum2* 0.5
            if (delayTime < 0) then delayTime = 0 end

            -- 处理金币以及钻石表现
            local text = UI.Text:create()
            text:init("", UI.FONT_BOLD)
            -- text:centerBottom(10)
            text:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            text:setText(tostring(-data.addCount))
            text:updateView()
            text:setVisible(false)
            text:leftBottom(463, 484)
            self:addChild(text)
            -- addChildAuto(layoutUU, self, text, "maxPos")
            Avalon.Scheduler:scheduleUpdateOnce(
                self,
                function()
                    if (self and not tolua.isnull(self)) then
                        text:setVisible(true)
                        text:runAction(cc.Spawn:create(
                            cc.MoveBy:create(0.5, cc.p(0, 20)),
                            cc.Sequence:create(
                                cc.DelayTime:create(0.4),
                                cc.FadeOut:create(0.1),
                                cc.RemoveSelf:create(),
                                cc.CallFunc:create(function() self._waitingNum2 = self._waitingNum2 - 1 end)
                            )
                        ))
                    end
                end,
                delayTime
            )
            self._waitingNum2 = self._waitingNum2 + 1
        end
    end
end

-- 注册监听事件(可选)
function HorcurxLevelLayer:registerListener()
    -- 角色状态更新 
    Avalon.MessageCenter:bind(
        AvalonMessage.MC_UI_COLSE_SKILL_TIP,
        self,
        self.refreshSelectSkillIcon
    )

    Avalon.MessageCenter:bind(
        AvalonMessage.MC_UI_HORCURX_INFO_UPDATE,
        self,
        self.onLvResultBack
    )

    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)

end

function HorcurxLevelLayer:onCurrencyChangeHandler()
    self:updateBtnArea()
end

-- 注销监听事件(可选)
function HorcurxLevelLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(
        AvalonMessage.MC_UI_COLSE_SKILL_TIP,
        self,
        self.refreshSelectSkillIcon
    )
    Avalon.MessageCenter:unbind(
        AvalonMessage.MC_UI_HORCURX_INFO_UPDATE,
        self,
        self.onLvResultBack
    )
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

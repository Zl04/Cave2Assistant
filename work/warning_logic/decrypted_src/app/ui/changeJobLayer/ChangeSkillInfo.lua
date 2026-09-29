-- ChangeJoChangeSkillInfobLayer.lua
-- Author:zp
-- 2018年12月28日
-- Using:转职后详情页面
require "app.ui.shoplayer.BagGoodsPanel"
local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local ChangeSkillInfo = class("ChangeSkillInfo", UI.CenterWin)
UI.ChangeSkillInfo = ChangeSkillInfo
local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(983, 531)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_upgrade.plist",
    "ui_package_skill.plist",
}

--构造函数(必备)
function ChangeSkillInfo:ctor(spriteID)
    --窗口大小
    ChangeSkillInfo.super.ctor(
        self,UIType.TYPE_SKILL_ADVANCED_DETAIL,
        COM_RES_LIST,
        leftSize.width,    
        leftSize.height
    )
    self:setInterceptTouches(true);
	self:setTouchEnable(true)
    self.spriteID = spriteID
    self.isFristInit = true

    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function ChangeSkillInfo:dtor()
    ChangeSkillInfo.super.dtor(self)
    if(self._selectSpine) then 
        self._selectSpine:release()
        self._selectSpine = nil
    end

    self:unRegisterListener()
end

-- 初始化(必备)
function ChangeSkillInfo:init()
    ChangeSkillInfo.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function ChangeSkillInfo:onInitView()
    self.layout = UI.Layout:create();
    self.layout:init()
    self.layout:setSize(leftSize.width, leftSize.height)
    self.layout:center()
    self:addChild(self.layout, 3)

    local bg = UI.Image:create()
    bg:init("ui_upgrade_upgrade_paper_02.png")
    self.layout:addChild(bg)

    local selectSpine = Avalon.Animation:create("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas", 1);
    selectSpine:setAnimation(0,"start_fillet",false)
    selectSpine:addAnimation(0,"idle_fillet",true)
    selectSpine:setName("selectEffect")
    selectSpine:retain()
    self._selectSpine = selectSpine

    self:initRight()
    self:initLeft()

    self:open()
end

function ChangeSkillInfo:initLeft()
    local leftBg = UI.Image:create()
    leftBg:init("ui_upgrade_upgrade_paper_01.png")
    leftBg:leftBottom(10, 20)
    self.layout:addChild(leftBg, 10)

    local changeSkillArr = GameDataManager:getInstance():getChangeSkillData()

    local beginPosX = 10
    local beginPosY = 10
    local oneWidth = 219

    local bg = self:createOneSkillType("icon-equip_metal_21080010_4.png", changeSkillArr[1])
    bg:leftBottom(beginPosX, beginPosY)
    leftBg:addChild(bg)
    beginPosX = beginPosX + oneWidth

    local bg = self:createOneSkillType("icon-equip_metal_21080010_5.png", changeSkillArr[2])
    bg:leftBottom(beginPosX, beginPosY)
    leftBg:addChild(bg)
    beginPosX = beginPosX + oneWidth

    local bg = self:createOneSkillType("icon-equip_metal_21080010_6.png", changeSkillArr[3])
    bg:leftBottom(beginPosX, beginPosY)
    leftBg:addChild(bg)
end

function ChangeSkillInfo:initRight()
    local rightBg = UI.Image:create()
    rightBg:init("ui_upgrade_upgrade_paper_03.png")
    rightBg:rightUp(5, 5)
    self.layout:addChild(rightBg, 20)

    -- 标题
    local titleBg = UI.Image:create()
    titleBg:init("ui_upgrade_title_01.png")
    titleBg:centerUp(27)
    rightBg:addChild(titleBg)

    -- 标题文字
    local titleText = UI.Text:create()
    titleText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    titleText:center()
    titleBg:addChild(titleText)
    self.titleText = titleText

    -- 升级后
    local upgradeEndBg = UI.Image:create()
    upgradeEndBg:init("ui_upgrade_decorate_after.png")
    upgradeEndBg:centerUp(81)
    rightBg:addChild(upgradeEndBg)

    local upgradeEndText = UI.Text:create()
    upgradeEndText:init(UI.TEXT_1212072, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    upgradeEndText:center()
    upgradeEndBg:addChild(upgradeEndText)

    local nowScrollLayout = UI.Layout:create()
    nowScrollLayout:init()
    nowScrollLayout:setSize(260, 135)
    self.nowScrollLayout = nowScrollLayout

    local nowScrollView = UI.ScrollView:create()
    nowScrollView:setSize(285, 135)
    nowScrollView:init()
    nowScrollView:leftUp(18, 114)
    nowScrollView:addInnerNode(nowScrollLayout)
    nowScrollView:setScrollBarEnabled(true)
    nowScrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    nowScrollView:setCircleVisible(false)
    nowScrollView:setScrollBarWidth(5)
    rightBg:addChild(nowScrollView, 10)
    self._nowScrollView = nowScrollView

    -- 上机的图标
    local upgradeArrow = UI.Image:create()
    upgradeArrow:init("ui_information_arrow_up_02.png")
    upgradeArrow:centerUp(256)
    rightBg:addChild(upgradeArrow)

    -- 升级前描述
    local upgradePreBg = UI.Image:create()
    upgradePreBg:init("ui_upgrade_decorate_before.png")
    upgradePreBg:centerUp(308)
    rightBg:addChild(upgradePreBg)

    local upgradePreText = UI.Text:create()
    upgradePreText:init(UI.TEXT_1212073, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    upgradePreText:center()
    upgradePreBg:addChild(upgradePreText)

    local preScrollLayout = UI.Layout:create()
    preScrollLayout:init()
    preScrollLayout:setSize(260, 135)
    self.preScrollLayout = preScrollLayout

    local preScrollView = UI.ScrollView:create()
    preScrollView:setSize(285, 135)
    preScrollView:init()
    preScrollView:leftUp(18, 338)
    preScrollView:addInnerNode(preScrollLayout)
    preScrollView:setScrollBarEnabled(true)
    preScrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    preScrollView:setCircleVisible(false)
    preScrollView:setScrollBarWidth(5)
    rightBg:addChild(preScrollView, 10)
    self._preScrollView = preScrollView
end

function ChangeSkillInfo:createOneSkillType(skillTypeIconSpriteName, skillDataArr)
    local bg = UI.Image:create()
    bg:init("ui_upgrade_occupation_bg.png")
    
    -- 技能类型 ICON 
    local skillTypeIcon = UI.Image:create()
    skillTypeIcon:init(skillTypeIconSpriteName)
    skillTypeIcon:centerUp(67 - skillTypeIcon:getContentSize().height/2)
    bg:addChild(skillTypeIcon)

    -- 添加技能ICON
    local scrollLayout = UI.Layout:create()
    scrollLayout:init()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(223, 286)
    scrollView:init()
    scrollView:leftBottom(0, 11)
    scrollView:addInnerNode(scrollLayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    bg:addChild(scrollView, 10)

    -- 技能列表    
    if(skillDataArr) then
        local size = #skillDataArr
        local oneHeight = 96
        local itemPadding = 96

        local beginPosX = 7
        local beginPosY = 2
        local addIndex = 0
        for i = 1, size do
            local preSkillData = skillDataArr[i][1]
            local nowSkillData = skillDataArr[i][2]

            if(addIndex == 2) then 
                beginPosY = beginPosY + oneHeight
                addIndex = 0
            end

            if(preSkillData and nowSkillData) then 
                local skillBG = UI.Image:create()
                skillBG:init("ui_skill_banner_skillbox_transfer_bg.png")
                skillBG:leftUp(beginPosX + itemPadding * addIndex, beginPosY)
                scrollLayout:addChild(skillBG)
                skillBG:setScale(0.9)
                skillBG:setTouchEnable(true)
                skillBG:setClickAudioEnable(true)
                skillBG:setSwallowTouches(false)

                local skillIcon = UI.Image:create()
                skillIcon:init(nowSkillData.iconID)
                skillIcon:center()
                skillIcon:setCascadeOpacityEnabled(true)
                skillBG:addChild(skillIcon)

                local skillUp = UI.Image:create()
                skillUp:init("ui_skill_banner_skillbox_transfer.png")
                skillUp:center()
                skillUp:setCascadeOpacityEnabled(true)
                skillBG:addChild(skillUp)
                skillUp.data = skillDataArr[i]

                if(self.isFristInit) then 
                    self:handleClick(skillUp)
                    self.isFristInit = false
                end

                skillBG:addEventListener(UIEvent.COMPONENT_CLICK, skillUp, function(skillUp)
                    self:handleClick(skillUp)
                end)
            end

            addIndex = addIndex + 1
        end
        beginPosY = beginPosY + oneHeight

        
        if(beginPosY > scrollLayout:getContentSize().height) then 
            scrollLayout:setSize(scrollLayout:getContentSize().width, beginPosY)
        end
    end

    return bg
end

function ChangeSkillInfo:handleClick(skillBG) 
    if(tolua.isnull(skillBG)) then 
        return 
    end

    if self._selectSpine:getParent() then 
        self._selectSpine:removeFromParent(false)
    end

    skillBG:addChild(self._selectSpine)
    self._selectSpine:setPosition(skillBG:getContentSize().width/2, skillBG:getContentSize().height/2)

    self._selectSpine:setAnimation(0, "start_transfer", false)
    self._selectSpine:addAnimation(0, "idle_transfer", true)

    -- 刷新文件描述
    self:refreshSkillInfo(skillBG.data)
end

-- 模版函数：更新组建的视图(必备)
function ChangeSkillInfo:onUpdateView()
    
end

function ChangeSkillInfo:refreshSkillInfo(data)
    -- print("refreshSkillInfo", data)
    self.preScrollLayout:removeChildren()
    self.nowScrollLayout:removeChildren()
    if(data == nil) then 
        return 
    end

    local preSkillData = data[1]
    local nowSkillData = data[2]
    if(preSkillData == nil or nowSkillData == nil) then 
        return 
    end

    if(not tolua.isnull(self.titleText)) then 
        self.titleText:setText(preSkillData.name)
    end

    -- 处理升级后的表现
    local skillCDStrEnd, skillCDTimeEnd, costStrEnd, costNumEnd, prepareCDStrEnd, prepareCDEnd, richDesStrEnd, desStrEnd = self:handleSkillString(nowSkillData)
    -- 升级前的表现
    local skillCDStrPre, skillCDTimePre, costStrPre, costNumPre, prepareCDStrPre, prepareCDPre, richDesStrPre, desStrPre = self:handleSkillString(preSkillData)

    local beginPosX = 0
    local beginPosY = 5
    local paddingHeight = 5
    local CELL_WIDTH = 260

    -- print("wwwwww")
    -- print(skillCDStrEnd, skillCDTimeEnd, costStrEnd, costNumEnd, prepareCDStrEnd, prepareCDEnd, "dddffd", richDesStrEnd, desStrEnd)
    -- print(skillCDStrPre, skillCDTimePre, costStrPre, costNumPre, prepareCDStrPre, prepareCDPre,"ddddd", richDesStrPre, desStrPre)
    
    if(costStrEnd) then 
        local costText = UI.Text:create()
        costText:init(costStrEnd, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costText:leftUp(beginPosX, beginPosY)
        costText:autoAdapt()
        self.nowScrollLayout:addChild(costText)
        if(costNumEnd == costNumPre) then 
            costText:setText(costStrEnd..string.format("%d",costNumEnd))
        else 
            local costNumText = UI.Text:create()
            costNumText:init(tostring(costNumEnd), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
            costNumText:centerLeft(costText:getContentSize().width + 4)
            costNumText:autoAdapt()
            costText:addChild(costNumText)
        end
        beginPosY = beginPosY + costText:getContentSize().height + paddingHeight
    end

    if(skillCDStrEnd) then
        local costText = UI.Text:create()
        costText:init(skillCDStrEnd, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costText:leftUp(beginPosX, beginPosY)
        costText:autoAdapt()
        self.nowScrollLayout:addChild(costText)
        if(skillCDTimeEnd == skillCDTimePre) then 
            costText:setText(skillCDStrEnd..string.format("%.1f",skillCDTimeEnd))
        else 
            local costNumText = UI.Text:create()
            costNumText:init(string.format("%d",skillCDTimeEnd), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
            costNumText:centerLeft(costText:getContentSize().width + 4)
            costNumText:autoAdapt()
            costText:addChild(costNumText)
        end
        beginPosY = beginPosY + costText:getContentSize().height + paddingHeight
    end

    if(prepareCDStrEnd) then
        local costText = UI.Text:create()
        costText:init(prepareCDStrEnd, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costText:leftUp(beginPosX, beginPosY)
        costText:autoAdapt()
        self.nowScrollLayout:addChild(costText)
        if(prepareCDEnd == prepareCDPre) then 
            if(prepareCDEnd > 0) then 
                costText:setText(prepareCDStrEnd..string.format("%.1f",prepareCDEnd))
            end
        else 
            if(prepareCDEnd > 0) then 
                local costNumText = UI.Text:create()
                costNumText:init(string.format("%.1f",prepareCDEnd), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_36_181_118)
                costNumText:centerLeft(costText:getContentSize().width + 4)
                costNumText:autoAdapt()
                costText:addChild(costNumText)
            end
        end
        beginPosY = beginPosY + costText:getContentSize().height + paddingHeight
    end

    local desText = nil
    if(richDesStrEnd and string.find(richDesStrEnd, "fontSize")) then 
        desText = UI.RichText:create()
        desText:setFontName(UI.FONT_STANDARD)
        local success = desText:initForNetJson(richDesStrEnd, CELL_WIDTH, 0)
        if success then
            desText:leftUp(beginPosX, beginPosY)
            beginPosY = beginPosY + desText:getRichTextHeight() + paddingHeight

            self.nowScrollLayout:addChild(desText)
        else 
            desText = nil
        end
    elseif(desStrEnd) then
        desText = UI.Text:create()
        desText:init(desStrEnd, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        desText:leftUp(beginPosX, beginPosY)
        desText:setWidth(CELL_WIDTH)
        desText:autoAdapt()
        self.nowScrollLayout:addChild(desText)
        beginPosY = beginPosY + desText:getContentSize().height + paddingHeight
    end
    if(beginPosY > self.nowScrollLayout:getContentSize().height) then 
        self.nowScrollLayout:setSize(self.nowScrollLayout:getContentSize().width, beginPosY)
    end

    local beginPosX = 0
    local beginPosY = 5
    -- 升级前的表现
    if(costStrPre) then 
        local costText = UI.Text:create()
        costText:init(costStrPre..tostring(costNumPre), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costText:leftUp(beginPosX, beginPosY)
        costText:autoAdapt()
        self.preScrollLayout:addChild(costText)
        beginPosY = beginPosY + costText:getContentSize().height + paddingHeight
    end

    if(skillCDStrPre) then
        local costText = UI.Text:create()
        costText:init(skillCDStrPre..tostring(skillCDTimePre), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costText:leftUp(beginPosX, beginPosY)
        costText:autoAdapt()
        self.preScrollLayout:addChild(costText)
        beginPosY = beginPosY + costText:getContentSize().height + paddingHeight
    end

    if(prepareCDStrPre) then
        local str = prepareCDStrPre
        if(prepareCDPre > 0) then
            str = str..string.format("%.1f", prepareCDPre)
        end

        local costText = UI.Text:create()
        costText:init(str, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costText:leftUp(beginPosX, beginPosY)
        costText:autoAdapt()
        self.preScrollLayout:addChild(costText)
        beginPosY = beginPosY + costText:getContentSize().height + paddingHeight
    end

    local desText = UI.Text:create()
    desText:init(desStrPre, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    desText:leftUp(beginPosX, beginPosY)
    desText:setWidth(CELL_WIDTH)
    desText:autoAdapt()
    beginPosY = beginPosY + desText:getContentSize().height + paddingHeight
    self.preScrollLayout:addChild(desText)

    if(beginPosY > self.preScrollLayout:getContentSize().height) then 
        self.preScrollLayout:setSize(self.preScrollLayout:getContentSize().width, beginPosY)
    end

    self._preScrollView:scrollToTop(0.1, false)
    self._nowScrollView:scrollToTop(0.1, false)
end

function ChangeSkillInfo:handleSkillString(nowSkillData) 
    local desStr = nowSkillData:getDescription()
    local richDesStr = nowSkillData:getComparedTxt()
    local prepareCDStr = nil 
    local prepareCD = 0
    local costStr = nil
    local costNum = 0
    local skillCDStr = nil
    local skillCDTime = 0

    if nowSkillData.type == SkillType.PASSIVE then
        prepareCDStr = nil
        prepareCD = 0
    else
        prepareCDStr = ""
        prepareCD = 0
        if nowSkillData.costType == 1 then
            costStr = UI.TEXT_111005
            costNum = nowSkillData:getMPCost()
        else
            costStr = UI.TEXT_111004
            costNum = nowSkillData:getHPCost()
        end
        skillCDStr = UI.TEXT_111006
        skillCDTime = nowSkillData.cooldown/1000

        if nowSkillData:isActive() then
            if(nowSkillData:getSkillType() == SkillType.PHYSICAL) then 
                if nowSkillData:getPrepareTime() <= 0 then
                    prepareCDStr = LanguageManager:getInstance():getLocalString(1111371)..LanguageManager:getInstance():getLocalString(1111372)
                else
                    prepareCDStr = LanguageManager:getInstance():getLocalString(1111371)
                    prepareCD = nowSkillData:getPrepareTime()-- string.format("%.1f", )
                end
            elseif(nowSkillData:getSkillType() == SkillType.MAGIC) then 
                if nowSkillData:getPrepareTime() <= 0 then
                    prepareCDStr = LanguageManager:getInstance():getLocalString(1111370)..LanguageManager:getInstance():getLocalString(1111372)
                else
                    prepareCDStr = LanguageManager:getInstance():getLocalString(1111370)
                    prepareCD = nowSkillData:getPrepareTime()-- string.format("%.1f", )
                end
            end
        elseif self.mSelectSkillNode.skillData:isAssist() then 
        end
    end

    return skillCDStr, skillCDTime, costStr, costNum, prepareCDStr, prepareCD, richDesStr, desStr
end

-- 注册监听事件(可选)
function ChangeSkillInfo:registerListener()
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_GEM_INLAY, self, self.inlayCallBack)
    
end

-- 注销监听事件(可选)
function ChangeSkillInfo:unRegisterListener()
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_GEM_INLAY, self, self.inlayCallBack)
end
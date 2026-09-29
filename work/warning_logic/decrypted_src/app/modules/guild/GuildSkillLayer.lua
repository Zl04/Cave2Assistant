-- GuildSkillLayer.lua
-- Author:ODEI
-- 2017年9月13日
-- Using:公会天赋界面 

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
require "utils.WidgetUtil"
require("app.datas.MasterDataManager")
UI = UI or {}

local GuildSkillLayer = class("GuildSkillLayer", UI.HWBtnComponent)
UI.GuildSkillLayer = GuildSkillLayer
local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(853, 537)
-- 关卡选择资源
local COM_RES_LIST = {
}

local SkillIconState = {
    State_Nomal = 1,
    State_NotUpgrade = 2,
    State_UnLock = 3,
    State_UnEffect = 4,
}

local maxWidth = 400
local blackColor = cc.vec4(21/255, 14/255, 6/255, 1.0)

function GuildSkillLayer:ctor(spriteID)
    GuildSkillLayer.super.ctor(
    self,UIType.GUILD_SKILL_LAYER,
    COM_RES_LIST,
    layerSize.width,
    layerSize.height
    )
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.pTableViewList = {}
    self.mSelectGuildSkillID = 0;
    self.mAddExp = 0

    self.selectIdx = 1

    self.mbSendAddExp = false;      --是否已经发送添加经验数据
    self.triangularAnimList = {} --三角形高亮动画
    self.touchTrigger = false    -- 触摸触发
    self:initData();
    self:init();
    self:registerListener();
end


function GuildSkillLayer:dtor()
    GuildSkillLayer.super.dtor(self)
    self:unRegisterListener();
    reload_script_file("app.modules.guild.GuildSkillLayer")
end

-- public:
-- 初始化
function GuildSkillLayer:init()
    GuildSkillLayer.super.init(self)
end

function GuildSkillLayer:initData()
    local data = {}
    -- local guildSkill = ConfigManager:getAllGuildSkill()
    for i = 1,7 do
        data[i] = {}

        local guildTech = ConfigManager:getGuildTechForID(i)
        data[i].name = guildTech.name 
        data[i].guildTechData = guildTech
        data[i].iconName = guildTech.guildTechIcon
        data[i].data = ConfigManager:getGuildSkillByType(i)
        data[i].isUnlock = mvc.guildModel:checkGuildTechUnlock(guildTech)

        table.sort(data[i].data,function(a,b)
            return a.ID < b.ID
        end)
    end

    self.mSelectGuildSkillID = data[1].data[1].ID

    self.data = data
end

function GuildSkillLayer:onClickBtnHandler(bg)
    local curIdx = bg.idx
    self:refreshClickBtn(curIdx)
end

function GuildSkillLayer:refreshClickBtn(index) 
    if self.selectIdx then
        local bg = self.bg[self.selectIdx]
        bg.selectBg:hide()
        bg:setPosition(cc.p(bg.posX, bg.posY))
    end

    self.selectIdx = index
    local bg = self.bg[self.selectIdx]
    bg.selectBg:show()
    bg:setPosition(cc.p(bg.posX + 12, bg.posY))

    self.mSelectGuildSkillID = self.data[self.selectIdx].data[1].ID
    self.skillName:setText(self.data[self.selectIdx].name)
    self:refreshSkillArr()
    self:refreshSkillInfo(self.data[self.selectIdx].data[1])
end

function GuildSkillLayer:refreshLeftChoiceBtn()
    if(self.bg) then 
        for i = 1,#self.data do
            local oneData = self.data[i]
            if(oneData) then 
                local oneNode = self.bg[i]
                if(oneNode) then
                    if mvc.guildModel:checkGuildTechUnlock(oneData.guildTechData) then 
                        oneNode.lockEff:setVisible(false)
                    else 
                        oneNode.lockEff:setVisible(true)
                    end
                end
            end 
        end
    end
end

function GuildSkillLayer:initLeftChoiceBtn()
    self.bg = {}
    local leftBtnLayout = UI.Layout:create()
    leftBtnLayout:init()
    leftBtnLayout:setSize(169, 600)
    -- self:addChild(leftBtnLayout, 20)

    local bg = UI.Image:create()
    bg:init("ui_guild_tech_paper_bg.png")
    bg:leftBottom(0, 35)
    leftBtnLayout:addChild(bg)

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(169, 520)
    scrollView:init()
    scrollView:addInnerNode(leftBtnLayout)
    self:addChild(scrollView, 20)
    -- scrollView:enableDebugDraw()

    local heightSpace = 10
    local startX = 81
    local startY = 20
    local oneX = -9
    local oneY = 78

    for i = 1,#self.data do
        local oneData = self.data[i]
        if(oneData) then 
            local bg = UI.Image:create()
            bg:init("ui_guild_itembox_1.png")
            leftBtnLayout:addChild(bg)
            bg:leftUp(startX + oneX * (i - 1) , startY + oneY * (i - 1))
            
            local img = UI.Image:create()
            img:init("ui_guild_itembox_2.png")
            img:centerLeft(-60)
            bg:addChild(img)
            bg.selectBg = img
            img:hide()

            local img = UI.Image:create()
            img:init(oneData.iconName)
            img:setImageScale(0.6)
            img:center()
            bg:addChild(img)
            bg:setTouchEnable(true)
            bg:addEventListener(UIEvent.COMPONENT_CLICK, self,self.onClickBtnHandler)
            
            local lockEff = UI.Animation:create()
            lockEff:init("effect_ui_common_unlock.json", "effect_ui_common_unlock.atlas", 1);
            lockEff:leftUp(20, 18)
            lockEff:setAnimation("idle", true)
            bg:addChild(lockEff, 10)
            bg.lockEff = lockEff
            lockEff:setVisible(false)

            bg.idx = i
            bg.posX,bg.posY = bg:getPosition()
            self.bg[i] = bg
        end
    end
end

function GuildSkillLayer:createOneSkill(guildSkillData, index)
    local skillList = string.split(guildSkillData.skillIDList,";")
    local lv = 1
    local skillID = skillList[lv]

    local skillData = ConfigManager:getSkillConfigById(skillID)

    local skillNode = UI.Layout:create()
    skillNode:init()
    skillNode:setSize(90,123)
    skillNode:setTag(guildSkillData.ID)
    skillNode:setTouchEnable(true)
    skillNode:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        print("click skillNode")
        self.mSelectGuildSkillID = skillNode.data.ID
        self:refreshSkillArr()
        self:refreshSkillInfo(skillNode.data)
    end)

    local skillBG = UI.Image:create()
    skillBG:init("ui_guild_skillbox_1.png")
    skillBG:setImageScale(0.8)
    skillBG:center()
    skillBG:setName("skillBG")
    skillNode:addChild(skillBG)

    local skillIcon = UI.Image:create()
    skillIcon:init(skillData.iconID)
    skillIcon:center()
    skillIcon:setImageScale(0.8)
    skillIcon:setName("skillIcon")
    skillNode:addChild(skillIcon)

    -- 等级受到限制
    local levelUnlockImage = UI.Image:create()
    levelUnlockImage:init("ui_information_arrow_dwon.png")
    levelUnlockImage:leftUp(8, 26)
    levelUnlockImage:setName("levelUnlockImage")
    levelUnlockImage:setVisible(false)
    skillNode:addChild(levelUnlockImage, 20)

    local skillIconCap = UI.Image:create()
    skillIconCap:init("ui_guild_skill_icon_mask.png")
    skillIconCap:center()
    skillIconCap:setName("skillIconCap")
    skillIcon:addChild(skillIconCap)

    local unlockImage = UI.Image:create()
    unlockImage:init("ui_guild_lockbase.png")
    unlockImage:leftUp(0, 15)
    unlockImage:setName("unlockImage")
    unlockImage:setVisible(false)
    skillNode:addChild(unlockImage, 20)

    local skillIconImage = UI.Image:create()
    skillIconImage:init("ui_information_lock.png")
    skillIconImage:center()
    unlockImage:addChild(skillIconImage)

    -- 等级
    local skillLvBg = UI.Image:create()
    skillLvBg:init("ui_guild_skillbase.png")
    skillLvBg:centerUp(0)
    skillLvBg:setName("skillLvBg")
    skillNode:addChild(skillLvBg)

    local skillLv = UI.Text:create()
    skillLv:init(lv.."/"..#skillList, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_170_170_170)
    skillLv:setSize(62,20)
    skillLv:centerUp(9-skillLv:getContentSize().height/2)
    skillLv:setTextCenter()
    skillLv:setName("skillLv")
    skillNode:addChild(skillLv)

    -- 技能名字
    local skillName = UI.Text:create()
    skillName:init(skillData.name, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    skillName:centerUp(skillNode:getContentSize().height - 24)
    skillName:setTextCenter()
    skillName:setWidth(115)
    skillName:setLineSpacing(-6)
    skillName:setName("skillName")
    skillNode:addChild(skillName)

    self:refreshSkill(skillNode, guildSkillData)

    local oneY = 151
    local oneX = 126
    local startX = 7
    local startY = 54
    local a,b = math.modf((index-1)/3)
    skillNode:leftUp(startX + oneX* b*3, startY + oneY * a)

    return skillNode, skillIcon
end

--刷新技能Icon
function GuildSkillLayer:refreshSkill(skillNode, data)
    if skillNode == nil or MasterDataManager:getGuildSkill() == nil then
        return 
    end
    -- dump(data)
    skillNode.data = data
    local lv = 0
    local guildSkill = MasterDataManager:getGuildSkill()[data.ID]
    local levelUnlockImage = skillNode:getChildByName("levelUnlockImage")
    if(not tolua.isnull(levelUnlockImage)) then 
        levelUnlockImage:setVisible(false)
    end
    local activeMaxLevel = 0
    if guildSkill == nil then
        lv = 0
    else
        lv = guildSkill.curLv
        activeMaxLevel = lv
        -- add by zp CO-6076 判断是否为达到了该公会激活的最高等级
        local maxLevel = self:calculationUnlockLevel(data)
        if (lv > maxLevel) then
            activeMaxLevel = maxLevel
            if(not tolua.isnull(levelUnlockImage)) then 
                levelUnlockImage:setVisible(true)
            end
        end
    end

    local skillList = string.split(data.skillIDList,";")
    local skillID = skillList[1]
    local skillData = ConfigManager:getSkillConfigById(skillID)
    local skillIcon = skillNode:getChildByName("skillIcon")
    local skillBG = skillNode:getChildByName("skillBG")
    local skillIconCap = skillIcon:getChildByName("skillIconCap")
    local selectSpine = skillNode:getChildByName("selectEffect")
    local unlockImage = skillNode:getChildByName("unlockImage")
    if selectSpine ~= nil then
        selectSpine:removeFromParent(true)
    end
    skillIcon:setSpriteName(skillData.iconID)
    local state = self:changeSkillState(data, activeMaxLevel)
    
    local isUnlock = mvc.guildModel:checkGuildTechUnlock(self.data[self.selectIdx].guildTechData)
    if(not isUnlock) then 
        state = SkillIconState.State_UnLock
    end

    local masterData = RoleDataManager:getMaster()
    local roleLv = masterData:getLevel()
    local takeEffectLevel = tonumber(string.split(data.takeEffectLevel,";")[lv + 1]) or 0
    if state ~= SkillIconState.State_UnLock and roleLv < takeEffectLevel then
        state = SkillIconState.State_UnEffect
    end

    if state == SkillIconState.State_Nomal then
        skillBG:setSpriteName("ui_guild_skillbox_1.png")
        skillIcon:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
        skillIconCap:hide()
        unlockImage:hide()
    elseif state == SkillIconState.State_NotUpgrade then
        skillBG:setSpriteName("ui_guild_skillbox_2.png")
        skillIcon:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
        skillIconCap:hide()
        unlockImage:hide()
    elseif state == SkillIconState.State_UnLock then
        skillBG:setSpriteName("ui_guild_skillbox_2.png")
        AvalonUtil.useColorShader(skillIcon._sprite, blackColor)
        skillIconCap:hide()
        unlockImage:show()
    elseif state == SkillIconState.State_UnEffect then
        skillBG:setSpriteName("ui_guild_skillbox_2.png")
        AvalonUtil.useColorShader(skillIcon._sprite, blackColor)
        skillIconCap:hide()
        unlockImage:hide()
    else

    end

    if self.mSelectGuildSkillID == data.ID then
        local selectSpine = skillNode:getChildByName("selectEffect")
        if selectSpine == nil then
            selectSpine = self:createSelectEffect()
            -- selectSpine:setPosition(0,32)
            selectSpine:center()
            skillNode:addChild(selectSpine,2)
        end
    else
        skillNode:removeChildByName("selectEffect")
    end

    local skillLv = skillNode:getChildByName("skillLv")
    local skillLvBg = skillNode:getChildByName("skillLvBg")
    if lv == #skillList then
        local skillLvMax = skillLvBg:getChildByName("skillLvMax")
        if skillLvMax == nil then
            skillLvMax = UI.Image:create()
            skillLvMax:init("ui_guild_tech_skillmax.png")
            skillLvMax:center()
            skillLvMax:setName("skillLvMax")
            skillLvBg:addChild(skillLvMax)
        end
        skillLv:hide()
    else
        skillLvBg:removeChildByName("skillLvMax")
        skillLv:setText(lv.."/"..#skillList)
        skillLv:show()

        if state == SkillIconState.State_Nomal or state == SkillIconState.State_UnEffect then
            skillLv:setFontColor(UI.FONT_COLOR_36_181_118)
        else
            skillLv:setFontColor(UI.FONT_COLOR_208_50_60)
        end
    end

    -- 刷新名字
    local skillName = skillNode:getChildByName("skillName")
    if(skillName) then 
        skillName:setText(skillData.name)
    end
end

function GuildSkillLayer:refreshSkillArr()
    for i=1, #self.data[self.selectIdx].data, 1 do 
        if(self.skillNodeArr[i]) then
            self:refreshSkill(self.skillNodeArr[i], self.data[self.selectIdx].data[i])
        else
            local skillNode,skillIcon = self:createOneSkill(self.data[self.selectIdx].data[i], i)
            table.insert(self.skillNodeArr, skillNode)
            self.skillItemLayout:addChild(skillNode)
            self:refreshSkill(self.skillNodeArr[i], self.data[self.selectIdx].data[i])
        end
    end
end

function GuildSkillLayer:initCenterLayout()
    -- 中间区域布局
    local centerLayout = UI.Layout:create()
    centerLayout:init()
    centerLayout:setSize(362, 526)
    centerLayout:leftBottom(169, 0)
    self:addChild(centerLayout)

    local skillTileBg = UI.Image:create()
    skillTileBg:init("ui_guild_base.png")
    skillTileBg:centerUp(38)
    centerLayout:addChild(skillTileBg)

    local skillName = UI.Text:create()
    skillName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_170_170_170)
    skillName:center()
    skillTileBg:addChild(skillName)
    self.skillName = skillName

    -- 处理具体的表现
    local skillItemLayout = UI.Layout:create()
    skillItemLayout:init()
    skillItemLayout:setSize(362, 375)
    skillItemLayout:centerUp(68)
    centerLayout:addChild(skillItemLayout)
    self.skillItemLayout = skillItemLayout
    
    self.skillNodeArr = {}
end

function GuildSkillLayer:refreshGuildTechUnlockTips()
    local oneData = self.data[self.selectIdx]
    self._unlockTipsImage:setVisible(false)
    if(oneData) then 
        if not mvc.guildModel:checkGuildTechUnlock(oneData.guildTechData) then 
            self._unlockTipsImage:setVisible(true)
        end
    end
end

--刷新右侧技能信息
function GuildSkillLayer:refreshSkillInfo(guildSkillData)
    self:refreshGuildTechUnlockTips()
    print("----refreshSkillInfo------")
    local userGuildSkillData = MasterDataManager:getGuildSkill()[guildSkillData.ID]

    local skillList = string.split(guildSkillData.skillIDList,";")
    local lv = 0
    local exp = 0
    if userGuildSkillData ~= nil then
        lv = userGuildSkillData.curLv
        exp = userGuildSkillData.curExp
    end

    local guildSkillUnlockLevel = lv
    local maxLevel = self:calculationUnlockLevel(guildSkillData)
    if (lv > maxLevel) then
        guildSkillUnlockLevel = maxLevel
    end

    local skillID
    if guildSkillUnlockLevel == 0 then
        skillID = skillList[1]
    else
        skillID = skillList[guildSkillUnlockLevel]
    end

    local skillData = ConfigManager:getSkillConfigById(skillID)

    local state = self:changeSkillState(guildSkillData, guildSkillUnlockLevel)
    self.iconImage:setSpriteName(skillData.iconID)

    self.buyButton:enable()

    local isUnlock = mvc.guildModel:checkGuildTechUnlock(self.data[self.selectIdx].guildTechData)
    if(not isUnlock) then 
        state = SkillIconState.State_UnLock
    end
    local masterData = RoleDataManager:getMaster()
    local roleLv = masterData:getLevel()
    local takeEffectLevel = tonumber(string.split(guildSkillData.takeEffectLevel,";")[guildSkillUnlockLevel + 1]) or 0
    if roleLv < takeEffectLevel then
        state = SkillIconState.State_UnEffect
    end

    if(RoleDataManager:getMaster() and RoleDataManager:getMaster():getGuildContrib() <=0) then 
        self.buyButton:disable()
    end

    if state ~= SkillIconState.State_Nomal then 
        self.buyButton:disable()
    end

    if state == SkillIconState.State_Nomal then
        self.iconImageKuang:setSpriteName("ui_guild_skillbox_1.png")
    elseif state == SkillIconState.State_NotUpgrade then
        self.iconImageKuang:setSpriteName("ui_guild_skillbox_2.png")
    elseif state == SkillIconState.State_UnLock then
        self.iconImageKuang:setSpriteName("ui_guild_skillbox_2.png")
    elseif state == SkillIconState.State_UnEffect then
        self.iconImageKuang:setSpriteName("ui_guild_skillbox_2.png")
    end

    if state == SkillIconState.State_UnLock or state == SkillIconState.State_UnEffect then
        self.buyButton:disable()
        AvalonUtil.useColorShader(self.iconImage._sprite, blackColor)
    else
        self.iconImage._sprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
    end

    self.infoTitle:setText(skillData.name)
    self.infoDetailText:setText(skillData.description)
    -- 显示激活等级
    self.unlockLayout:removeAllChildren(false)
    
    local skillUpExpList = string.split(guildSkillData.skillUpExpList,";")
    local unlockStrArr = {}
    local tipArr = {}
    if #skillUpExpList == guildSkillUnlockLevel then
        self.lvText:setText("Lv."..tostring(lv))
        self.lvProgressTimer:setBarChange(1, 1, 0)
        self.progressText:setText(UI.TEXT_110208)
    else
        self.lvText:setText("Lv."..tostring(lv))
        if(#skillUpExpList == lv) then 
            self.progressText:setText(UI.TEXT_110208)
            self.lvProgressTimer:setBarChange(1, 1, 0)
        else
            local percent = exp/skillUpExpList[lv + 1]
            self.progressText:setText(exp.."/"..skillUpExpList[lv + 1])
            self.lvProgressTimer:setBarChange(percent, percent, 0)
        end
        local guildTech = MasterDataManager:getGuildTechForTechID(guildSkillData.needTechID)
        if tonumber(guildTech.curLv) >= tonumber(string.split(guildSkillData.techLevelListForUnlockSkill,";")[guildSkillUnlockLevel + 1]) then
            -- local takeEffectLevel = tonumber(string.split(guildSkillData.takeEffectLevel,";")[guildSkillUnlockLevel + 1]) or 0
            if roleLv < takeEffectLevel then
                local level, reinLv = RoleDataManager:getUIShowLvByItemData(takeEffectLevel)
                local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
                table.insert(unlockStrArr, string.format(UI.TEXT_1213312, showLv))
            end
        else
            local level = string.split(guildSkillData.techLevelListForUnlockSkill,";")[guildSkillUnlockLevel + 1] or 0
            -- table.insert(unlockStrArr, string.format(self.data[guildSkillData.needTechID].name.." "..UI.TEXT_1110688, tonumber(level)))
            table.insert(unlockStrArr, string.format(UI.TEXT_1213300, self.data[guildSkillData.needTechID].name, tonumber(level)))
            
            -- add by zp CO-6076 刷新当前激活等级
            if (lv > guildSkillUnlockLevel) then
                table.insert(tipArr, string.format(UI.TEXT_1212216, guildSkillUnlockLevel))
            end
        end
    end

    local scrollviewHeight = 205
    local addNum = #tipArr + #unlockStrArr
    local oneHeight = 29
    if(tipArr and #tipArr > 0) then 
        for k,v in ipairs(tipArr) do 
            local tipsText = UI.Text:create()
            tipsText:init(v, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
            tipsText:setTextCenter()
            if(tipsText) then 
                self.unlockLayout:addChild(tipsText)
                tipsText:leftBottom(0, (addNum-1) * oneHeight)
                scrollviewHeight = scrollviewHeight - oneHeight
                addNum = addNum - 1
            end
        end
    end

    if(unlockStrArr and #unlockStrArr > 0) then 
        for k,v in ipairs(unlockStrArr) do 
            local oneLayout = self:createOneTip(v, false)
            if(oneLayout) then 
                self.unlockLayout:addChild(oneLayout)
                oneLayout:leftBottom(0, (addNum-1) * oneHeight)
                scrollviewHeight = scrollviewHeight - oneHeight
                addNum = addNum - 1
            end
        end
    end
    
    -- 刷新界面
    local width, height = self.infoDetailBg:getSize()
    self.infoDetailBg:setSize(width, scrollviewHeight)
    local width, height = self.infoDetailScrollView:getSize()
    self.infoDetailScrollView:setSize(width, scrollviewHeight - 16)
    self.infoDetailScrollLayout:setSize(width, scrollviewHeight - 16)

    self.infoDetailBg:refreshPosition()
    self.infoDetailScrollView:refreshPosition()
    self.infoDetailText:refreshPosition()
    self.infoDetailScrollLayout:refreshPosition()
    self.infoDetailScrollView:scrollToTop()
end

function GuildSkillLayer:createOneTip(textStr, isUnlock)
    local tipLayout = UI.Layout:create()
    tipLayout:init()
    tipLayout:setSize(0, 28)

    local tipsImage = UI.Image:create()
    tipsImage:init("ui_information_reminder.png")
    tipsImage:centerLeft(0)
    tipLayout:addChild(tipsImage)

    local tipsText = UI.Text:create()
    tipsText:init(textStr, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
    tipsText:centerLeft(tipsImage:getContentSize().width + 4)
    tipsText:setTextCenter()
    tipsImage:addChild(tipsText)

    return tipLayout
end

function GuildSkillLayer:initRightLayout()
    local infoBg = UI.Image:create()
    infoBg:init('ui_guild_tech_paper.png')
    infoBg:leftBottom(560, 26)
    self:addChild(infoBg, 200)
    self._infoBg = infoBg

    local infoTitle = UI.Text:create()
    infoTitle:init("33", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_54)
    infoTitle:centerUp(19 - infoTitle:getContentSize().height/2)
    infoBg:addChild(infoTitle)
    self.infoTitle = infoTitle

    local lvText = UI.Text:create()
    lvText:init("01", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    lvText:rightUp(218, 50- lvText:getContentSize().height/2)
    infoBg:addChild(lvText)
    self.lvText = lvText

    local lvProgressTimer =  UI.ProgressTimer:create()
    lvProgressTimer:init("ui_guild_tech_propressbar_00.png", "ui_guild_tech_propressbar_11.png", "ui_guild_tech_propressbar_11.png")
    lvProgressTimer:leftUp(58, 40)
    infoBg:addChild(lvProgressTimer)
    lvProgressTimer:setBarChange(0.5, 0.5, 0)
    self.lvProgressTimer = lvProgressTimer

    local progressText = UI.Text:create()
    progressText:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    progressText:center()
    lvProgressTimer:addChild(progressText, 100)
    self.progressText = progressText
    
    local iconImageKuang = UI.Image:create()
    iconImageKuang:init("ui_guild_skillbox_1.png")
    iconImageKuang:centerUp(123 - iconImageKuang:getContentSize().height/2)
    infoBg:addChild(iconImageKuang)
    self.iconImageKuang = iconImageKuang

    local iconImage = UI.Image:create()
    iconImage:init("ui_guild_skillbox_1.png")
    iconImage:center()
    iconImageKuang:addChild(iconImage)
    self.iconImage = iconImage

    local infoDetailBg = UI.Image9:create()
    infoDetailBg:init("ui_common_information_base.png", CCRectMake(20, 1, 1, 1), cc.size(239, 148))
    infoDetailBg:centerUp(195)
    infoBg:addChild(infoDetailBg)
    self.infoDetailBg = infoDetailBg

    local infoDetailScrollView = UI.ScrollView:create()
    infoDetailScrollView:setSize(229, 132)
    infoDetailScrollView:init(0, 0, 0, 0)
    infoDetailScrollView:centerUp(8)
    infoDetailBg:addChild(infoDetailScrollView)
    self.infoDetailScrollView = infoDetailScrollView

    local infoDetailScrollLayout = UI.Layout:create()
    infoDetailScrollLayout:init()
    infoDetailScrollLayout:setSize(229, 132)
    infoDetailScrollLayout:leftUp(0, 0)
    infoDetailScrollView:addInnerNode(infoDetailScrollLayout)
    self.infoDetailScrollLayout = infoDetailScrollLayout

    local infoDetailText = UI.Text:create()
    infoDetailText:init("01", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    infoDetailText:leftUp(0, 0)
    infoDetailText:setWidth(229)
    infoDetailScrollLayout:addChild(infoDetailText)
    self.infoDetailText = infoDetailText

    -- 解锁提示信息
    local unlockLayout = UI.Layout:create()
    unlockLayout:init()
    unlockLayout:leftBottom(16, 62)
    unlockLayout:setSize(0, 0)
    infoBg:addChild(unlockLayout)
    self.unlockLayout = unlockLayout

    local buyButton = UI.Button:create()
    buyButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    buyButton:keepActivated(true)
    buyButton:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        self:onDonate()
    end)
    buyButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(target, sender, touchPosition)
        self:onDonate()
    end)
    buyButton:centerBottom(12)
    infoBg:addChild(buyButton)
    self.buyButton = buyButton

    local juanxianText = UI.Text:create()
    juanxianText:init(UI.TEXT_110074, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    buyButton:addChild(juanxianText, 10)

    local juanxianImage = UI.Image:create()
    juanxianImage:init("symbol_guild_contribution_icon_medal.png")
    buyButton:addChild(juanxianImage, 10)

    local padding = 10
    local startX = (buyButton:getContentSize().width - (juanxianText:getContentSize().width + juanxianImage:getContentSize().width + padding)) /2
    juanxianText:centerLeft(startX)
    juanxianImage:centerLeft(startX + juanxianText:getContentSize().width + padding)
end

-- 模版函数：初始化组建的视图
function GuildSkillLayer:onInitView()
    local baseImage = UI.Image:create()
    baseImage:init("ui_guild_tech_base.png")
    self:addChild(baseImage)
    baseImage:leftBottom(124, 43)

    -- 左边的选择框
    self:initLeftChoiceBtn()
    self:initCenterLayout()
    self:refreshSkillArr()
    self:refreshLeftChoiceBtn()

    -- 底部提示语言
    -- 所有都有的
    local bottomTipsLayout = UI.Layout:create()
    bottomTipsLayout:init()
    bottomTipsLayout:setSize(maxWidth,0)
    bottomTipsLayout:leftBottom(149, 35)
    self:addChild(bottomTipsLayout)

    local tipsImage = UI.Image:create()
    tipsImage:init("ui_information_reminder.png")
    tipsImage:centerLeft(0)
    bottomTipsLayout:addChild(tipsImage)

    local tipsText = UI.Text:create()
    tipsText:init(UI.TEXT_1212218, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    tipsText:centerLeft(tipsImage:getContentSize().width + 4)
    tipsText:setTextCenter()
    tipsText:setLineSpacing(-6)
    tipsImage:addChild(tipsText)

    if(tipsText:getContentSize().width > maxWidth - 27) then 
        tipsText:setSize(maxWidth - 27,30)
    end
    tipsImage:centerLeft((bottomTipsLayout:getContentSize().width - (tipsImage:getContentSize().width + tipsText:getContentSize().width + 4))/2)

    -- 没有解锁才有的提示语言
    local tipsUnlockImage = UI.Image:create()
    tipsUnlockImage:init("ui_information_reminder.png")
    tipsUnlockImage:centerLeft(0)
    bottomTipsLayout:addChild(tipsUnlockImage)
    self._unlockTipsImage = tipsUnlockImage

    local tipsUnlockText = UI.Text:create()
    tipsUnlockText:init(UI.TEXT_1213302, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    tipsUnlockText:centerLeft(tipsUnlockImage:getContentSize().width + 4)
    tipsUnlockText:setTextCenter()
    tipsUnlockText:setLineSpacing(-6)
    tipsUnlockImage:addChild(tipsUnlockText)
    if(tipsUnlockText:getContentSize().width > maxWidth - 27) then 
        tipsUnlockText:setSize(maxWidth - 27,30)
    end
    tipsUnlockImage:leftBottom((bottomTipsLayout:getContentSize().width - (tipsUnlockImage:getContentSize().width + tipsUnlockText:getContentSize().width + 4))/2, (tipsText:getContentSize().height))


    -- 右边详情
    self:initRightLayout()
end

function GuildSkillLayer:calculationUnlockLevel(guildSkillData)
    local unlockSkill = string.split(guildSkillData.techLevelListForUnlockSkill,";")
    if(unlockSkill) then 
        local guildTech = MasterDataManager:getGuildTechForTechID(guildSkillData.needTechID)
        if(guildTech) then 
            local guildLevel = guildTech.curLv
            if(guildLevel == nil) then 
                guildLevel = 1
            end
            -- print("GuildSkillLayer:calculationUnlockLevel", guildLevel, unlockSkill)
            local unlockLevel = 0
            for k,level in pairs(unlockSkill) do 
                local willUnlockLevel = tonumber(level)
                if(guildLevel >= willUnlockLevel) then 
                    if(unlockLevel < k) then 
                        unlockLevel = k
                    end 
                end
            end

            return unlockLevel
        end
    end

    return 0
end

function GuildSkillLayer:getSkillNode(guildSkillID)
    local guildSkillData = ConfigManager:getGuildSkill(guildSkillID)
    local pTableViewList = self.pTableViewList[guildSkillData.needTechID]

    for i = 1,#(self.data[guildSkillData.needTechID].data) do
        if self.data[guildSkillData.needTechID].data[i].ID == guildSkillID then
            if pTableViewList:cellAtIndex(i - 1) then
                return pTableViewList:cellAtIndex(i - 1),pTableViewList:cellAtIndex(i- 1):getChildByName("skillNode"),i - 1,self.data[guildSkillData.needTechID].data[i]
            else
                return nil,nil,i - 1,self.data[guildSkillData.needTechID].data[i]
            end
        end
    end

end

function GuildSkillLayer:changeSkillState(data, level)
    local guildTech = MasterDataManager:getGuildTechForTechID(data.needTechID)
    if(guildTech == nil) then 
        return SkillIconState.State_NotUpgrade
    end
    level = level or 0
    if MasterDataManager:getGuildSkill()[data.ID] == nil or MasterDataManager:getGuildSkill()[data.ID].curLv < 1 then
        if tonumber(guildTech.curLv) >= tonumber(string.split(data.techLevelListForUnlockSkill,";")[level + 1]) then
            return SkillIconState.State_Nomal
        end
        return SkillIconState.State_UnLock
    else
        if not tonumber(string.split(data.techLevelListForUnlockSkill,";")[level + 1])  then
            return SkillIconState.State_NotUpgrade
        end

        if tonumber(guildTech.curLv) >= tonumber(string.split(data.techLevelListForUnlockSkill,";")[level + 1]) then
            return SkillIconState.State_Nomal
        else
            return SkillIconState.State_NotUpgrade
        end
        return SkillIconState.State_Nomal
    end
end

--创建选中特效
function GuildSkillLayer:createSelectEffect()
    local selectSpine = UI.Animation:create()
    selectSpine:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas", 1);
    selectSpine:setAnimation("loop_square", true)
    selectSpine:setName("selectEffect")

    -- local selectSpine = UI.Animation:create("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas", 1);
    -- selectSpine:setAnimation(0,"loop_square",true)
    -- selectSpine:setName("selectEffect")
    return selectSpine
end

-- 模版函数：更新组建的视图
function GuildSkillLayer:onUpdateView()
    self:refreshClickBtn(self.selectIdx)
end

--刷新数据
function GuildSkillLayer:refresh()
    self.mSelectGuildSkillID = self.data[1].data[1].ID;
    self:refreshSkillInfo(self.data[1].data[1])
    self:refreshSkillArr()
    self:refreshLeftChoiceBtn()
end

function GuildSkillLayer:hideSkill()
    self.skillInfoLayer:setVisible(false)
    self.mSelectGuildSkillID = 0;
end

function GuildSkillLayer:refreshContrib(oldGuildContrib,guildContrib)

end

function GuildSkillLayer:getChoiceGuildSkillData()
    local dataArr = self.data[self.selectIdx].data
    if(dataArr) then 
        for k, v in pairs(dataArr) do 
            print("getChoiceGuildSkillData", v.ID, self.mSelectGuildSkillID)
            if(v.ID == self.mSelectGuildSkillID) then 
                return v 
            end
        end
    end

    return nil 
end

function GuildSkillLayer:onDonate()
    local guildSkillData = self:getChoiceGuildSkillData()
    if(not guildSkillData) then 
        return 
    end

    local isUnlock = mvc.guildModel:checkGuildTechUnlock(self.data[self.selectIdx].guildTechData)
    if(not isUnlock) then 
        UI.ScrollBar:createByText(UI.TEXT_1213301)
        return 
    end

    -- 过滤空主角数据为空
    local masterData = RoleDataManager:getMaster()
    if(masterData == nil) then
        return
    end

    local skillUpExpList = string.split(guildSkillData.skillUpExpList,";")
    local leveUpExp = 0
    local lv = 0
    local guildSkill = MasterDataManager:getGuildSkill()[guildSkillData.ID]
    if guildSkill == nil then
        lv = 0
        leveUpExp = skillUpExpList[lv + 1]
    else
        lv = guildSkill.curLv
        if(lv == #skillUpExpList) then 
            UI.ScrollBar:createByText(UI.TEXT_1213303)
            return 
        end

        local maxLevel = self:calculationUnlockLevel(guildSkillData)
        if (lv >= maxLevel) then
            UI.ScrollBar:createByText(UI.TEXT_110070)
            return 
        end

        leveUpExp = skillUpExpList[lv + 1]
        leveUpExp = leveUpExp - guildSkill.curExp
    end

    local state = self:changeSkillState(guildSkillData, lv)
    if state == SkillIconState.State_NotUpgrade then

        return 
    elseif state == SkillIconState.State_UnLock then
        UI.ScrollBar:createByText(UI.TEXT_110070)
        return 
    end

    local skillList = string.split(guildSkillData.skillIDList,";")
    local nowGuildContrib = masterData:getGuildContrib()
    if(nowGuildContrib <=0 ) then 
        UI.ScrollBar:createByText(UI.TEXT_110069)
        return 
    end
    -- 拥有一个贡献值的时候直接学习, 大于一个弹出数量选择框
    local maxSelectableAmount = math.min(nowGuildContrib, tonumber(leveUpExp))
    if (maxSelectableAmount > 1) then
        UI.TipsLayer:onBuyAmount(function(number)   -- 确认回调
            if not tolua.isnull(self) then
                self:sendGuildSkillRequest(number)
            end
        end, nil, 1, PublicDefine.GOODS_COST_TYPE.GUILD_CONTRIB, maxSelectableAmount, true)
    else
        -- 弹出成功框
        self:sendGuildSkillRequest(1)
    end
end

function GuildSkillLayer:sendGuildSkillRequest(addExp)
    local data = {}
    data.skillID = self.mSelectGuildSkillID
    data.addExp = addExp
    data.spriteID = self.spriteID

    mvc.send(mvc.events.GuildTechOrSkill_GuildSkillRequest, data) 
end

--学习公会技能
function GuildSkillLayer:studyGuildSkill(studyGuildSkillData)
    UI.WaitingLayer:hideWaiting()
    self:refreshSkillInfo(self:getChoiceGuildSkillData())
    self:refreshSkillArr()
    self:refreshLeftChoiceBtn()

    -- for i = 1,#studyGuildSkillData do
    --     local cell,skillNode,index,data = self:getSkillNode(studyGuildSkillData[i].skillGroupId)
    --     self.pTableViewList[data.needTechID]:updateCellAtIndex(index)

    --     if studyGuildSkillData[i].skillGroupId == self.mSelectGuildSkillID then
    --         self:refreshSkillInfo(data)
    --     end
    -- end
end

function GuildSkillLayer:studyGuildSkillFails(data)
    UI.WaitingLayer:hideWaiting()
    GameErrorManager:showError(data.result)
end

function GuildSkillLayer:refreshTechData(data)
    self:refreshSkillArr()
    self:refreshLeftChoiceBtn()
end

-- 注册监听事件
function GuildSkillLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_GUILD_TECH, self, self.refreshTechData)
    --获取公会科技
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_GUILD_SKILL, self, self.refresh)
    --刷新公会勋章
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_CHNAGE_GUILD_CONTRIB, self, self.refreshContrib)
    --学习公会技能
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_STUDY_SKILL, self, self.studyGuildSkill)
    --学习公会技能失败
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_STUDY_SKILL_FAILS, self, self.studyGuildSkillFails)
end

-- 注销监听事件
function GuildSkillLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_GUILD_TECH, self, self.refreshTechData)
    --获取公会科技
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_GUILD_SKILL, self, self.refresh)
    --刷新公会勋章
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_CHNAGE_GUILD_CONTRIB, self, self.refreshContrib)
    --学习公会技能
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_STUDY_SKILL, self, self.studyGuildSkill)
    --学习公会技能失败
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_STUDY_SKILL_FAILS, self, self.studyGuildSkillFails)
end
-- GuildTechLayer.lua
-- Author:ODEI
-- 2017年9月13日
-- Using:公会科技界面 

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local GuildTechLayer = class("GuildTechLayer", UI.HWBtnComponent)
UI.GuildTechLayer = GuildTechLayer
local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(853, 537)
local blackColor = cc.vec4(21/255, 14/255, 6/255, 1.0)
-- 关卡选择资源
local COM_RES_LIST = {
}

function GuildTechLayer:ctor(spriteID)
    GuildTechLayer.super.ctor(
    self,UIType.GUILD_TECH_LAYER,
    COM_RES_LIST,
    layerSize.width,
    layerSize.height
    )

    self.techData = ConfigManager:getAllGuildTech()
    self.techNodeArr = {}

    -- 处理了相关的时间初始化
    self.joinMustWaitingTime = SECONDS_ONE_DAY
    self.waitingTime = 5

    self.spriteID = spriteID
    self.rootLayer = nil;                   -- root节点
    self._choiceTechID = self.techData[1].ID

    self:init();
    self:registerListener();
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function GuildTechLayer:dtor()
    GuildTechLayer.super.dtor(self)
    self.techNodeArr = {}
    self:unRegisterListener()
    reload_script_file("app.modules.guild.GuildTechLayer")
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

-- public:
-- 初始化
function GuildTechLayer:init()
    GuildTechLayer.super.init(self)
end

function GuildTechLayer:update(dt) 
    self.waitingTime = self.waitingTime + dt
    if(self.waitingTime > 5) then 
        self.waitingTime = self.waitingTime -  5

        self:refreshShow()
    end
end

function GuildTechLayer:refreshShow()
    local masterData = GameDataManager:getInstance():getMaster()
    if(masterData == nil) then 
        return nil
    end
    local waitingTime = masterData:getJoinGuildTime() + self.joinMustWaitingTime - GameManager:getNormalServerTime()
    -- print("GameManager:getNormalServerTime()=",self.joinMustWaitingTime, masterData:getJoinGuildTime(), GameManager:getNormalServerTime(), waitingTime, ToolsUtil:getCountData(waitingTime))
    if(waitingTime > 0 and self.remindImage and self.remindTxt) then 
        local str = ToolsUtil:getCountData(waitingTime)
        local waitingStr = string.format(UI.TEXT_1212217, str)
        self.remindTxt:setText(waitingStr)
        self.buyButton:setVisible(false)
        self.memberTip:hide()
        self:refreshWaitingLayout()
    else 
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member then
            self.buyButton:setVisible(false)
            self.memberTip:show()
        else
            self.buyButton:setVisible(true)
            self.memberTip:hide()
        end

        if(self.remindImage) then 
            self.remindImage:removeFromParent()
            self.remindImage = nil
        end
        if(self.remindTxt) then 
            self.remindTxt:removeFromParent()
            self.remindTxt = nil
        end
    end 
end

function GuildTechLayer:refreshTechInfo(guildTechData)
    print("----refreshTechInfo------")
    local userGuildSkillData = MasterDataManager:getGuildTechForTechID(guildTechData.ID)
    local lv = 0
    local exp = 0
    if userGuildSkillData ~= nil then
        lv = userGuildSkillData.curLv
        exp = userGuildSkillData.curExp
    end
    -- 这里由于服务器在没有解锁的时候初始化为0 ，这里强制修改为1
    if(lv < 1) then 
        lv = 1
    end

    local guildSkillUnlockLevel = lv
    local maxLevel = #guildTechData.techExpRequire + 1
    if (lv > maxLevel) then
        guildSkillUnlockLevel = maxLevel
    end

    self.iconImageKuang:setSpriteName(guildTechData.guildTechIcon)
    local isUnlock = self:checkUnlock(guildTechData)

    self.buyButton:enable()
    if not isUnlock then
        self.buyButton:disable()
        -- AvalonUtil.useColorShader(self.iconImageKuang._sprite, blackColor)
    else
        -- self.iconImageKuang._sprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
    end
    if MasterDataManager:getGuildData().guildTeamMedal <= 0 then 
        self.buyButton:disable()
    end

    -- 添加处理加入公会的冷却时间处理



    self.infoTitle:setText(guildTechData.name)
    self.infoDetailText:setText(guildTechData.description)
    -- 显示激活等级
    self.unlockLayout:removeAllChildren(false)
    
    local skillUpExpList = guildTechData.techExpRequire
    local unlockStrArr = {}
    if maxLevel == lv then
        self.lvText:setText("Lv."..tostring(lv))
        self.lvProgressTimer:setBarChange(1, 1, 0)
        self.progressText:setText(UI.TEXT_110208)
    else
        local percent = exp/skillUpExpList[lv]
        self.lvText:setText("Lv."..tostring(lv))
        self.progressText:setText(exp.."/"..skillUpExpList[lv])
        self.lvProgressTimer:setBarChange(percent, percent, 0)

        unlockStrArr = self:makeUnlockStr(guildTechData)
    end

    local scrollviewHeight = 205
    local addNum = #unlockStrArr
    if(unlockStrArr and #unlockStrArr > 0) then 
        local oneHeight = 29
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

function GuildTechLayer:createOneTip(textStr, isUnlock)
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

function GuildTechLayer:initRightLayout()
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
    iconImageKuang:init("ui_guild_tech_icon1.png")
    iconImageKuang:centerUp(120 - iconImageKuang:getContentSize().height/2)
    infoBg:addChild(iconImageKuang)
    self.iconImageKuang = iconImageKuang

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
    juanxianImage:init("symbol_guild_tech_icon_medal.png")
    buyButton:addChild(juanxianImage, 10)

    local memberTip = UI.Text:create()
    memberTip:init(UI.TEXT_1213877, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_RED)
    memberTip:centerBottom(20)
    memberTip:setWidth(229)
    infoBg:addChild(memberTip)
    self.memberTip = memberTip

    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member then
        self.buyButton:setVisible(false)
        self.memberTip:show()
    else
        self.memberTip:hide()
    end

    local padding = 10
    local startX = (buyButton:getContentSize().width - (juanxianText:getContentSize().width + juanxianImage:getContentSize().width + padding)) /2
    juanxianText:centerLeft(startX)
    juanxianImage:centerLeft(startX + juanxianText:getContentSize().width + padding)

    -- 时间限制
    local masterData = GameDataManager:getInstance():getMaster()
    local waitingFlag = false
    local waitingTime = masterData:getJoinGuildTime() + self.joinMustWaitingTime - GameManager:getNormalServerTime()
    if(waitingTime > 0) then 
        waitingFlag = true
    end
    if(waitingFlag) then
        -- 添加了倒计时提醒
        local waitingLayout = UI.Layout:create()
        waitingLayout:init()
        waitingLayout:setSize(240, 0)
        waitingLayout:centerBottom(34)
        infoBg:addChild(waitingLayout)
        self.waitingLayout = waitingLayout

        local remindImage = UI.Image:create()
        remindImage:init("ui_information_reminder.png")
        remindImage:centerLeft(0)
        waitingLayout:addChild(remindImage)
        self.remindImage = remindImage

        -- 
        local str = ToolsUtil:getCountData(waitingTime)
        local waitingStr = string.format(UI.TEXT_1212217, str)

        local remindTxt = UI.Text:create()
        remindTxt:init(waitingStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
        remindTxt:centerLeft(remindImage:getContentSize().width + 4)
        remindTxt:autoAdapt()
        remindTxt:setLineSpacing(-4)

        remindTxt:setTextCenter()
        waitingLayout:addChild(remindTxt)
        self.remindTxt = remindTxt
        self:refreshWaitingLayout()
        self.buyButton:setVisible(false)
    end
end

function GuildTechLayer:refreshWaitingLayout()
    if(self.remindImage and self.waitingLayout and self.remindTxt) then
        if(self.remindTxt:getContentSize().width > 190) then 
            self.remindTxt:setMaxLineWidth(190)
            self.waitingLayout:setSize(self.remindImage:getContentSize().width + 194, 0)
        else 
            self.waitingLayout:setSize(self.remindImage:getContentSize().width + self.remindTxt:getContentSize().width + 4, 0)
        end
    end
end

function GuildTechLayer:clickOneTech(techID)
    if(self.techNodeArr[techID]) then 
        local oldTech = self._choiceTechID
        self._choiceTechID = techID
        self:refreshTech(oldTech)
        self:refreshTech(techID)
        self:refreshTechInfo(self.techNodeArr[techID].guildTechData)
    end
end

function GuildTechLayer:refreshTech(techID)
    local skillNode = self.techNodeArr[techID]
    if skillNode == nil then
        return 
    end
    local guildTechData = skillNode.guildTechData
    local learnData = MasterDataManager:getGuildTechForTechID(techID)
    local lv = 0
    local levelUnlockImage = skillNode:getChildByName("levelUnlockImage")
    if(not tolua.isnull(levelUnlockImage)) then 
        levelUnlockImage:setVisible(false)
    end
    if learnData == nil then
        lv = 0
    else
        lv = learnData.curLv
    end
    -- 这里由于服务器在没有解锁的时候初始化为0 ，这里强制修改为1
    if(lv < 1) then 
        lv = 1
    end

    local skillIcon = skillNode:getChildByName("skillIcon")
    local skillBG = skillNode:getChildByName("skillBG")
    local skillBGKuang = skillNode:getChildByName("skillBGKuang")
    local skillIconCap = skillIcon:getChildByName("skillIconCap")
    local selectSpine = skillNode:getChildByName("selectEffect")
    if selectSpine ~= nil then
        selectSpine:removeFromParent(true)
    end

    local isUnlock = self:checkUnlock(guildTechData)
    if isUnlock then
        skillBG:setSpriteName("ui_guild_skill_banner_skillbox_2.png")
        skillBGKuang:setSpriteName("ui_guild_skill_banner_skillbox_1.png")
        -- skillIcon:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
        skillIconCap:hide()
        if(not tolua.isnull(levelUnlockImage)) then 
            levelUnlockImage:hide()
        end
    else
        skillBG:setSpriteName("ui_guild_skill_banner_skillbox_1_2.png")
        skillBGKuang:setSpriteName("ui_guild_skill_banner_skillbox_1_1.png")
        -- AvalonUtil.useColorShader(skillIcon._sprite, blackColor)
        skillIconCap:show()
        if(not tolua.isnull(levelUnlockImage)) then 
            levelUnlockImage:show()
        end
    end

    if self._choiceTechID == guildTechData.ID then
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
    local maxLv = #guildTechData.techExpRequire + 1
    if lv == maxLv then
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
        skillLv:setText(lv.."/"..maxLv)
        skillLv:show()

        -- if state == SkillIconState.State_Nomal then
        --     skillLv:setFontColor(UI.FONT_COLOR_36_181_118)
        -- else
        --     skillLv:setFontColor(UI.FONT_COLOR_208_50_60)
        -- end
    end
end

function GuildTechLayer:checkUnlock(data)
    local isUnlock = mvc.guildModel:checkGuildTechUnlock(data)
    return isUnlock
end

function GuildTechLayer:makeUnlockStr(data)
    local unlockStr = {}
    local masterData = RoleDataManager:getMaster()
    local roleLv = masterData:getLevel()

    for index,v in ipairs(data.techIDBeforeLearn) do 
        local id = data.techIDBeforeLearn[index]
        local lv = data.techLevelBeforeLearn[index]
        local preTechData = ConfigManager:getGuildTechForID(id)
        if(id ~= 0) then
            -- 判断是否解锁了
            local learnData = MasterDataManager:getGuildTechForTechID(id)
            if(learnData) then 
                if learnData.curLv < lv then 
                    table.insert(unlockStr, string.format(UI.TEXT_1213300, preTechData.name, lv))
                end
                
            else 
                table.insert(unlockStr, string.format(UI.TEXT_1213300, preTechData.name, lv))
            end

        end
    end

    if data.unlockLevel > roleLv then
        local level, reinLv = RoleDataManager:getUIShowLvByItemData(data.unlockLevel)
        local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
        table.insert(unlockStr, string.format(UI.TEXT_1213311, showLv))
    end

    return unlockStr
end

function GuildTechLayer:refreshAllTech()
    if(self.techNodeArr) then 
        for k,v in pairs(self.techNodeArr) do 
            self:refreshTech(k)
        end
    end
    self:refreshTechLine()
end


function GuildTechLayer:refreshTechLine()
    self.lineLayout:removeAllChildren()
    for k, v in pairs(self.techData) do 
        if(v and #v.techIDBeforeLearn > 0 and v.techIDBeforeLearn[1] ~= 0) then 
            local locationArr = string.split(v.cableLocation, ";")
            local nameArr = string.split(v.cableName, ";")
            if(#locationArr == #nameArr) then 
                for index,name in ipairs(nameArr) do 
                    local addFlag = false
                    local line = UI.Image:create()
                    line:init(name..".png")
                    local oneCoord = string.split(locationArr[index], ",")
                    line:leftUp(tonumber(oneCoord[1]), tonumber(oneCoord[2]))
                    if(index == 1) then
                        addFlag = true
                    else 
                        local id = v.techIDBeforeLearn[index - 1]
                        local lv = v.techLevelBeforeLearn[index - 1]

                        -- 判断是否解锁了
                        local learnData = MasterDataManager:getGuildTechForTechID(id)
                        if(learnData) then 
                            if learnData.curLv >= lv then 
                                addFlag = true
                            end
                        end
                    end
                    if(addFlag) then 
                        self.lineLayout:addChild(line)
                    end
                end
            end
        end
    end
end

function GuildTechLayer:createOneTech(guildTechData)
    -- local skillData = ConfigManager:getGuildTechForID(techID)

    local skillNode = UI.Layout:create()
    skillNode.guildTechData = guildTechData
    skillNode:init()
    skillNode:setSize(90,123)
    skillNode:setTag(guildTechData.ID)
    skillNode:setTouchEnable(true)
    skillNode:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        print("click skillNode", skillNode:getTag())
        self:clickOneTech(skillNode:getTag())
    end)

    local skillBG = UI.Image:create()
    skillBG:init("ui_guild_skill_banner_skillbox_2.png")
    skillBG:center()
    skillBG:setName("skillBG")
    skillNode:addChild(skillBG)

    local skillBGKuang = UI.Image:create()
    skillBGKuang:init("ui_guild_skill_banner_skillbox_1.png")
    skillBGKuang:center()
    skillBGKuang:setName("skillBGKuang")
    skillNode:addChild(skillBGKuang)

    local skillIcon = UI.Image:create()
    skillIcon:init(guildTechData.guildTechIcon)
    skillIcon:center()
    skillIcon:setImageScale(0.6)
    skillIcon:setName("skillIcon")
    skillNode:addChild(skillIcon)

    -- 等级受到限制
    local levelUnlockImage = UI.Image:create()
    levelUnlockImage:init("ui_guild_lockbase.png")
    levelUnlockImage:leftUp(0, 15)
    levelUnlockImage:setName("levelUnlockImage")
    levelUnlockImage:setVisible(false)
    skillNode:addChild(levelUnlockImage, 20)

    local skillIconImage = UI.Image:create()
    skillIconImage:init("ui_information_lock.png")
    skillIconImage:center()
    levelUnlockImage:addChild(skillIconImage)

    local skillIconCap = UI.Image:create()
    skillIconCap:init("ui_guild_skill_icon_mask.png")
    skillIconCap:center()
    skillIconCap:setName("skillIconCap")
    skillIcon:addChild(skillIconCap)

    -- 等级
    local skillLvBg = UI.Image9:create()
    skillLvBg:init("ui_guild_skillbase.png", CCRectMake(29, 10, 1, 1), cc.size(90, 19))
    skillLvBg:centerUp(0)
    skillLvBg:setName("skillLvBg")
    skillNode:addChild(skillLvBg)

    local skillLv = UI.Text:create()
    skillLv:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_170_170_170)
    -- skillLv:setSize(100,20)
    skillLv:centerUp(9-skillLv:getContentSize().height/2)
    skillLv:setTextCenter()
    skillLv:setName("skillLv")
    skillNode:addChild(skillLv)

    -- 技能名字
    local skillName = UI.Text:create()
    skillName:init(guildTechData.name, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    skillName:centerBottom(0)
    skillName:setTextCenter()
    skillName:setName("skillName")
    skillNode:addChild(skillName)

    return skillNode
end

function GuildTechLayer:initLeftLayout()
    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(531, 536)
    leftLayout:leftBottom(0, 0)
    self:addChild(leftLayout, 10)

    -- 创建图标
    local offsetX = 36
    local offsetY = 40
    for k, v in pairs(self.techData) do 
        local oneGuildNode = self:createOneTech(v)
        if(oneGuildNode) then 
            self.techNodeArr[v.ID] = oneGuildNode
            oneGuildNode:leftUp(v.iconLocation[1] + offsetX - oneGuildNode:getContentSize().width/2, v.iconLocation[2] + offsetY - oneGuildNode:getContentSize().height/2)
            leftLayout:addChild(oneGuildNode, 100)
        end
    end

    
    local lineLayout = UI.Layout:create()
    lineLayout:init()
    leftLayout:addChild(lineLayout, 50)
    self.lineLayout = lineLayout
    
    -- 刷新连线
    self:refreshTechLine()
    self:refreshAllTech()
end

-- 模版函数：初始化组建的视图
function GuildTechLayer:onInitView()
    local baseImage = UI.Image:create()
    baseImage:init("ui_guild_tech_base.png")
    self:addChild(baseImage)
    baseImage:centerLeft(60)

    self:initLeftLayout()
    self:initRightLayout()
    self:clickOneTech(self._choiceTechID)
end

-- 模版函数：更新组建的视图
function GuildTechLayer:onUpdateView()
    -- print("GuildTechLayer:onUpdateView")

end

function GuildTechLayer:getTechData(techID)
    if(self._techData) then
        return self._techData[techID]
    end

    return nil
end

--捐献
function GuildTechLayer:onDonate(obj)
    local guildTechData = self.techNodeArr[self._choiceTechID].guildTechData
    -- 过滤空数据
    if(guildTechData == nil) then 
        return
    end

    -- 过滤空主角数据为空
    local masterData = RoleDataManager:getMaster()
    if(masterData == nil) then
        return
    end

    local userGuildSkillData = MasterDataManager:getGuildTechForTechID(guildTechData.ID)
    local lv = 0
    local exp = 0
    if userGuildSkillData ~= nil then
        lv = userGuildSkillData.curLv
        exp = userGuildSkillData.curExp
    end

    local guildSkillUnlockLevel = lv
    local maxLevel = #guildTechData.techExpRequire + 1
    if (lv > maxLevel) then
        guildSkillUnlockLevel = maxLevel
    end
    local isUnlock = self:checkUnlock(guildTechData)
    if(not isUnlock) then 
        UI.ScrollBar:createByText(UI.TEXT_1213301)
        return 
    end
    local nowGuildMedal = MasterDataManager:getGuildData().guildTeamMedal
    if(nowGuildMedal <= 0) then 
        UI.ScrollBar:createByText(UI.TEXT_110067)
        return 
    end

    -- 拥有一个勋章的时候直接捐献, 大于一个弹出数量选择框
    if (nowGuildMedal > 1) then
        UI.TipsLayer:onBuyAmount(function(number)   -- 确认回调
            if not tolua.isnull(self) then
                self:sendGuildTechRequest(guildTechData.ID, number)
            end
        end, nil, 1, PublicDefine.GOODS_COST_TYPE.GUILD_MEDAL, nowGuildMedal, true)
    else
        -- 弹出成功框
        self:sendGuildTechRequest(guildTechData.ID, 1)
    end
end

function GuildTechLayer:sendGuildTechRequest(ID, number)
    local guildData = MasterDataManager:getGuildData()
    if(guildData) then
        local guildId = guildData:getID()
        local data = {}
        data.guildId = guildId
        data.ID = ID
        data.number = number
        data.spriteID = self.spriteID

        mvc.send(mvc.events.GuildTechOrSkill_GuildTechRequest, data) 
    end
end

--创建选中特效
function GuildTechLayer:createSelectEffect()
    local selectSpine = UI.Animation:create()
    selectSpine:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas", 1);
    selectSpine:setAnimation("loop_square", true)
    selectSpine:setName("selectEffect")

    return selectSpine
end

function GuildTechLayer:hideTechInfo()

end

function GuildTechLayer:refreshTechData(data)
    self:clickOneTech(self._choiceTechID)
    self:refreshAllTech()
end

function GuildTechLayer:refreshMedal()
    self:clickOneTech(self._choiceTechID)
    self:refreshAllTech()
end

function GuildTechLayer:guildTechResult()
    self:clickOneTech(self._choiceTechID)
    self:refreshAllTech()
end

-- 注册监听事件
function GuildTechLayer:registerListener()
    --获取公会科技
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_GUILD_TECH, self, self.refreshTechData)
    --刷新公会勋章
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self, self.refreshMedal)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_GUILD_GUILD_TECH_RESULT, self, self.guildTechResult)
end

-- 注销监听事件
function GuildTechLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_GUILD_TECH, self, self.refreshTechData)
    --刷新公会勋章
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self, self.refreshMedal)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_GUILD_GUILD_TECH_RESULT, self, self.guildTechResult)
    
end
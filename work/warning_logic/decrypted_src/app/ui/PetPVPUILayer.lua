-- PetPVPUILayer.lua
-- Author:ydli
-- 2020年4月24日
-- Using:宠物战斗UI




local winSize = cc.Director:getInstance():getWinSize()



UI = UI or {}

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetPVPUILayer = class("PetPVPUILayer", UI.Component)
UI.PetPVPUILayer = PetPVPUILayer

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_pet_pvp.plist",
    "ui_town_greatnavigation.plist",
}

local MONSTER_TYPE = {
    SMALL_MONSTER = 1,
    BIG_MONSTER = 2,
}

--构造函数(必备)
function PetPVPUILayer:ctor(MainUILType)
    print("PetPVPUILayer:ctor")

    --窗口大小
    PetPVPUILayer.super.ctor(self,UIType.MAIN_UI_LAYER, COM_RES_LIST, winSize.width, winSize.height)
    self:init();
    self:registerListener();
    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update), 1, false)
end

--虚构函数,destroy时调用(必备)
function PetPVPUILayer:dtor()
    PetPVPUILayer.super.dtor(self)
    self:unRegisterListener();
    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    reload_script_file("app.ui.PetPVPUILayer")
end

-- 初始化(必备)
function PetPVPUILayer:init()
    self:initData()  
    PetPVPUILayer.super.init(self)
end

function PetPVPUILayer:initData()
    local petPVPRoles = RoleDataManager:getPetPVPRoles()
    self.progressBars = {}
    if petPVPRoles ~= nil then
        self.myHero = RoleDataManager:getRoleDataBySpriteID(petPVPRoles.myRoles.hero, true)
        self.enemyHero = RoleDataManager:getRoleDataBySpriteID(petPVPRoles.enemyRoles.hero, true)
        self.myPets = {}
        local myPets = petPVPRoles.myRoles.pets
        for k, v in ipairs(myPets) do
            table.insert(self.myPets, RoleDataManager:getRoleDataBySpriteID(v, true))
        end

        self.enemyPets = {}
        local enemyPets = petPVPRoles.enemyRoles.pets
        for k, v in ipairs(enemyPets) do
            table.insert(self.enemyPets, RoleDataManager:getRoleDataBySpriteID(v, true))
        end
    end
    local SceneManager = require("app.game.SceneManager")
    local isInport = SceneManager:getInstance():isInPort()
    local config = ConfigManager:getNavigationGeneralConfigByID(1)
    if isInport then
        self.petCountDown = table.nums(self.enemyPets) < 3 and config.bossChallengeTime or config.singleExpulsionBattleTime
    else
        self.petCountDown = PublicDefine.CONST_DEFINITION.MAX_PETVERSUS_FIGHT_TIME / 1000   
    end
end
-- 模版函数：初始化组建的视图(必备)
function PetPVPUILayer:onInitView()
    --head
    local leftHead = self:createHead(true)
    leftHead:leftUp(30, 45)
    self:addChild(leftHead)
    self.leftHead = leftHead

    local rightHead = self:createHead(false)
    rightHead:rightUp(30, 45)
    self:addChild(rightHead)
    self.rightHead = rightHead

    --vs action

    --btn and info
    local leaveBtn = UI.Button:create()
    leaveBtn:init("ui_general_pvp_btn_surrender_0.png", "ui_general_pvp_btn_surrender_1.png")
    leaveBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Net.PetPVPProxy:skipFight()
    end)
    leaveBtn:rightUp(0, 170)
    self:addChild(leaveBtn)

    local btnTips = UI.Text:create()
    btnTips:init(UI.TEXT_111029, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    btnTips:center(24, 2)
    leaveBtn:addChild(btnTips, 10)

    local txtCountDown = UI.Text:create()
    txtCountDown:init(UI.TEXT_110065, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_239_201)
    txtCountDown:rightUp(10,220)
    self:addChild(txtCountDown)

    local subTitle = UI.Text:create()
    subTitle:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_239_201)
    subTitle:setWidth(153)
    subTitle:setTextRight()
    txtCountDown:addChild(subTitle)
    subTitle:rightBottom(0, - (subTitle:getContentSize().height + 20))
    self.timeText = subTitle

    local vsAction = UI.Animation:create()
    vsAction:init("effect_ui_town_pet_duizhan.json", "effect_ui_town_pet_duizhan.atlas", 1);
    vsAction:centerUp(64)
    self:addChild(vsAction, 100)
    vsAction:setAnimation("begin", false)

    --skill
    self.skillPanels = {}
    for i = 1, 3 do
        local skillPanel = self:createSkillPanel()
        skillPanel:leftBottom((winSize.width - 570) + (i - 1) * 175, 20)
        self:addChild(skillPanel)
        table.insert(self.skillPanels, skillPanel)
    end


    self:refreshView()

    local hideMainUI = cc.UserDefault:getInstance():getBoolForKey("HideMainUI", false)
    if hideMainUI then
        for k, v in ipairs(self.skillPanels) do
            v:hide()
        end
        self.rightHead:hide()
        self.leftHead:hide()
        vsAction:hide()
    end
end

function PetPVPUILayer:createSkillPanel()
     local panel = UI.Layout:create()
    panel:init()
    panel:setSize(150, 100)

    local bg = UI.Image:create()
    bg:init("ui_general_pvp_pethead_box_1_0.png")
    bg:leftBottom(6, 5)
    panel:addChild(bg)

    local board = UI.Image:create()
    board:init("ui_general_pvp_pethead_box_1_1.png")
    board:leftBottom(1, 1)
    panel:addChild(board, 10)
    board:setName("Board")

    local skillBg = UI.Image:create()
    skillBg:init("ui_pets_skill_box_pvp2.png")
    skillBg:leftBottom(76, -4)
    panel:addChild(skillBg, 20) 
    skillBg:setScale(0.9)
    skillBg:setName("SkillBg")

    -- 进度条
    local progressBar = UI.ProgressTimer:create()
    progressBar:init("ui_general_pvp_skill_bar_0.png", nil, "ui_general_pvp_skill_bar_1.png", UI.ProgressTimerType.RADIAL)
    progressBar:leftBottom(102, 0)
    progressBar:setMidpoint(cc.p(0.01, 0.7))
    progressBar:setReverseProgress(true)
    panel:addChild(progressBar, 30)
    progressBar:setPercent(0.50) --0.5 --0.795
    progressBar:setName("ProgressBar")

            -- local animation = UI.Animation:create()
            -- animation:init("effect_ui_town_pet_chongneng.json", "effect_ui_town_pet_chongneng.atlas", 1);
            -- animation:leftBottom(122, 37)
            -- animation:setAnimation("begin", true)
            -- panel:addChild(animation, 100)


    return panel
end

function PetPVPUILayer:createHead(isLeft)
    -- body
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(479, 54)

    if isLeft then
        local bg = UI.Image:create()
        bg:init("ui_general_pvp_blood_1_bg.png")
        bg:center()
        panel:addChild(bg)

        local head = self:addBasicInfo()
        panel:addChild(head)
        head:leftBottom(-5, 0)

        local roleName = UI.Text:create()
        roleName:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
        roleName:setSize(150, 24)
        roleName:setTextLeft()
        roleName:leftUp(90, -26)
        panel:addChild(roleName)
        self.leftName = roleName

        -- 进度条
        local progressBar = UI.ProgressTimer:create()
        progressBar:init("ui_general_pvp_blood_1_0.png", "ui_general_pvp_blood_1_1.png", "ui_general_pvp_blood_1_1.png")
        progressBar:leftBottom(90, 19)
        panel:addChild(progressBar)
        progressBar:setPercent(0)
        self.leftTimer = progressBar

        local hpNumber = UI.Text:create()
        hpNumber:init(string.format("%d/%d", 0, 0), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 237, g = 204, b = 137})
        hpNumber:center()
        hpNumber:setName("HP")
        hpNumber:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
        progressBar:addChild(hpNumber, 10)

    else
        local bg = UI.Image:create()
        bg:init("ui_general_pvp_blood_1_bg.png")
        bg:center()
        panel:addChild(bg)
        bg:setScaleX(-1)

        local head = self:addBasicInfo()
        panel:addChild(head)
        head:rightBottom(-5, 0)

        local roleName = UI.Text:create()
        roleName:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
        roleName:setSize(150, 24)
        roleName:setTextRight()
        roleName:rightUp(90, -26)
        panel:addChild(roleName)
        self.rightName = roleName

        -- 进度条
        local progressBar = UI.ProgressTimer:create()
        progressBar:init("ui_general_pvp_blood_2_0.png", "ui_general_pvp_blood_2_1.png", "ui_general_pvp_blood_2_1.png")
        progressBar:rightBottom(90, 19)
        panel:addChild(progressBar)
        progressBar:setScaleX(-1)
        progressBar:setPercent(0)
        self.rightTimer = progressBar

        local hpNumber = UI.Text:create()
        hpNumber:init(string.format("%d/%d", 0, 0), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 237, g = 204, b = 137})
        hpNumber:center()
        hpNumber:setName("HP")
        hpNumber:setScaleX(-1)
        hpNumber:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
        progressBar:addChild(hpNumber, 10)
    end

    return panel
end


-- 添加基础信息
function PetPVPUILayer:addBasicInfo()
    --主角背景
    local bg = UI.Image:create()
    bg:centerLeft(1)
    bg:init("ui_playerstate_me_black_down01.png")
    bg:setName("HEADBG")

    local cap = UI.Image:create()
    cap:init("ui_playerstate_me_black_01.png")
    cap:center(0)
    bg:addChild(cap, 10)

    -- 武器类型
    local equipmentType = UI.Image:create()
    equipmentType:init("icon-equip_small1_21080010_1.png")
    equipmentType:leftUp(61, 8)
    bg:addChild(equipmentType, 20)

    local gradeBg = UI.Image:create()
    gradeBg:init("ui_playerstate_me_grade.png")
    gradeBg:leftBottom(0, 6)
    bg:addChild(gradeBg, 20)
    gradeBg:setName("GRADEBG")
    -- 等级
    local lvLabel = UI.Text:create()
    lvLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_187_167_136)
    lvLabel:setSize(100, 50)
    lvLabel:centerLeft(-36)
    lvLabel:setTextCenter()
    gradeBg:addChild(lvLabel, 10)
    lvLabel:setName("LV")

    return bg
end

function PetPVPUILayer:refreshView()
    if self.myHero == nil or self.enemyHero == nil then
        self:initData()
    end
    if self.myHero == nil or self.enemyHero == nil then
        return
    end
    local SceneManager = require("app.game.SceneManager")
    local isInport = SceneManager:getInstance():isInPort()

    self.leftName:setText(self.myHero:getNickName())
    self.rightName:setText(self.enemyHero:getNickName())
    if not isInport then
        self:refreshHPTimer(self.myHero, self.leftTimer)
        self:refreshHPTimer(self.enemyHero, self.rightTimer)
    else
        self:refreshPetsHP(self.leftTimer)
        self:refreshEnemyCurPetsHP(self.rightTimer)

        -- 当为岛怪时
        local monsterShowId = mvc.bigSailPortModel:getMonsterBattlePvpData()
        print("monsterShowId--->: ", monsterShowId)
        local config = ConfigManager:getIslandMonsterByID(monsterShowId)
        print("monsterShowId--2222->: ", config)
        if self.enemyHero.islandMonster and monsterShowId then
            self.rightName:setText(languageManagerInstance:getLocalString(config.name))
        end
    end
    
    --头像 等级  技能icon
    for k, v in ipairs(self.myPets) do
        local panel = self.skillPanels[k]
        local head = panel:getChildByName("HEAD")
        if head == nil then
            local head = UI.Image:create()
            head:init(v:getIcon())
            head:leftBottom(24, 28)
            panel:addChild(head, 5)
            head:setName("HEAD")

            local skillBg = panel:getChildByName("SkillBg")
            local bar = panel:getChildByName("ProgressBar")
            if v:getGiftedSkill() then
                local skillData = SkillDataManager:createSkillForSkillId(v:getGiftedSkill())
                local skillIcon = UI.Image:create()
                skillIcon:init(skillData:getIconName())
                skillIcon:center()
                skillIcon:setName("SkillIcon")
                skillBg:addChild(skillIcon)

                bar:setPercent(0.51)
                self.progressBars[v:getSpriteID()] = bar
            else
                skillBg:hide()
                bar:hide()
            end
        else
           
        end
    end

    if self.headImg == nil then
        local GameDataManager = require("app.game.GameDataManager")
        local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(self.myHero:getSpriteID())
        Avalon.WidgetUtil:getHead(self, self.myHero, wearData.wearEquipmentArr,self, handler(self,function(self,pic)
            if self.leftHead and not tolua.isnull(self.leftHead) then
                pic:setPosition(48, 40)
                self.leftHead:getChildByName("HEADBG"):addChild(pic, 2) 
                self.leftHead:getChildByName("HEADBG"):getChildByName("GRADEBG"):getChildByName("LV"):setText(""..self.myHero:getLevel())
                self.headImg = pic
            end
        end))

        local SceneManager = require("app.game.SceneManager")
        local isInport = SceneManager:getInstance():isInPort()

        if table.nums(self.enemyPets) < 3 and isInport then
            self.boss = self.enemyPets[1]
            local pic = UI.Image:create()
            local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(self.boss:getIcon())
            if spriteFrame ~= nil then
                pic:init(self.boss:getIcon())
            else
                pic:init("ui_playerstate_pet_black_up.png")
            end
            pic:center()
    
            local clipper = UI.ClippingNode:create()
            clipper:initWithSprite("ui_playerstate_pet_black_up.png",  0.01)
            -- clipper:leftBottom(8, 10)
            clipper:center()
            clipper:addInnerNode(pic)
            clipper:setOpacityFilterTouch(false)

            self.rightHead:getChildByName("HEADBG"):addChild(clipper, 2) 
            self.rightHead:getChildByName("HEADBG"):getChildByName("GRADEBG"):getChildByName("LV"):setText(""..self.boss:getLevel())
        else
            local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(self.enemyHero:getSpriteID())
            Avalon.WidgetUtil:getHead(self, self.enemyHero, wearData.wearEquipmentArr,self, handler(self,function(self,pic)
                if self.rightHead and not tolua.isnull(self.rightHead) then
                    -- pic:setPosition(48, 40)
                    -- self.rightHead:getChildByName("HEADBG"):addChild(pic, 2) 
                    -- self.rightHead:getChildByName("HEADBG"):getChildByName("GRADEBG"):getChildByName("LV"):setText(""..self.enemyHero:getLevel())
                    -- 当为岛怪时
                    local monsterShowId = mvc.bigSailPortModel:getMonsterBattlePvpData()
                    local config = ConfigManager:getIslandMonsterByID(monsterShowId)
                    if self.enemyHero.islandMonster and monsterShowId then
                        local pic2 = UI.Image:create()
                        local signName = "ui_greatnavigation_moster_1.png"
                        if MONSTER_TYPE.BIG_MONSTER == monsterShowId then
                            signName = "ui_greatnavigation_moster_2.png"
                        end
                        pic2:init(signName)

                        pic2:setPosition(48, 40)
                        self.rightHead:getChildByName("HEADBG"):addChild(pic2, 2) 
                        self.rightHead:getChildByName("HEADBG"):getChildByName("GRADEBG"):getChildByName("LV"):setText(""..self.enemyHero:getLevel())
                    else
                        pic:setPosition(48, 40)
                        self.rightHead:getChildByName("HEADBG"):addChild(pic, 2) 
                        self.rightHead:getChildByName("HEADBG"):getChildByName("GRADEBG"):getChildByName("LV"):setText(""..self.enemyHero:getLevel())
                    end
                end
            end))
        end
        
    end
end

function PetPVPUILayer:update()
    if self.startTime then
        local remainTime = self.petCountDown -  (os.time() - self.startTime)
        if remainTime > 0 then
            local min = math.floor(remainTime / 60)
            local second = remainTime - min * 60
            if min > 0 then
                self.timeText:setText(string.format("%d:%d", min, second))
            else
                self.timeText:setText(string.format("%d", second))
            end
        else
             self.timeText:setText(string.format("%d", 0))
        end
    end
end

--[[1、刷新血条， 2、刷新死亡状态 3、刷新能量进度]]
function PetPVPUILayer:onUpdateHeroDataHandler(roleData)
    --if roleData:getIsDead())
    if self.myHero == nil or self.enemyHero == nil then
        print(" self.myHero or enemyHero is null")
        return
    end
    if self.startTime == nil then
        self.startTime = os.time()
    end
    local SceneManager = require("app.game.SceneManager")
    local isInport = SceneManager:getInstance():isInPort()

    if roleData:getType() == RoleType.Hero and not isInport then
        if self.myHero:getSpriteID() == roleData:getSpriteID() then
            self.myHero = roleData
            self:refreshHPTimer(roleData, self.leftTimer)
        elseif self.enemyHero:getSpriteID() == roleData:getSpriteID() then
            self.enemyHero = roleData
            self:refreshHPTimer(roleData, self.rightTimer)
        else
            print("----PetPVPUILayer:onUpdateHeroDataHandler error spriteId = ", roleData:getSpriteID())
        end
    elseif roleData:getType() == RoleType.Pet and isInport then
        self:refreshPetsHP(self.leftTimer)
        self:refreshEnemyCurPetsHP(self.rightTimer)
    end
end

function PetPVPUILayer:refreshHPTimer(data, progressBar)
    progressBar:setPercent(data:getCurHp() / data:getHp())
    local text = progressBar:getChildByName("HP")
    text:setText(string.format("%d/%d", data:getCurHp(), data:getHp()))
end

function PetPVPUILayer:skillRefreshCD(skillID, time, spriteID)
    local bar = self.progressBars[spriteID]
    local oldTime = time
    if bar then
        if time > 0 and bar:getPercent() <= 51 then
            bar:setBarChangeAction(0.51, 0.794, time)
        end
    end
end

function PetPVPUILayer:onUseSkillResult(skillID, result, spriteID)
    local bar = self.progressBars[spriteID]
    if bar then
        local animation = UI.Animation:create()
        animation:init("effect_ui_town_pet_chongneng.json", "effect_ui_town_pet_chongneng.atlas", 1);
        animation:leftBottom(121, 43)
        animation:setAnimation("begin", false)
        bar:getParent():addChild(animation, 100)
        animation:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(sender, event)
            if not tolua.isnull(animation) then
                animation:runAction(cc.RemoveSelf:create())
            end
        end)
        local skillData = SkillDataManager:createSkillForSkillId(skillID)
        bar:setBarChangeAction(0.51, 0.794, skillData.cooldown + 1)
    end
end

function PetPVPUILayer:enterFight(_, spriteID)
    local bar = self.progressBars[spriteID]
    if bar then
        local pet = nil
        for k, v in ipairs(self.myPets) do
            if spriteID == v:getSpriteID() then
                pet = v
                break
            end
        end
        if pet and pet:getGiftedSkill() then
            local skillData = SkillDataManager:createSkillForSkillId(pet:getGiftedSkill())
            bar:stopAllActions()
            bar:setBarChangeAction(0.51, 0.794, skillData.enterFightCD + 1)
        end
    end
end

function PetPVPUILayer:petDie(spriteID)
    local bar = self.progressBars[spriteID]
    if bar then
        bar:stopAllActions()
        bar:setPercent(0.51)
    end
    local panel = nil
    for k, v in ipairs(self.myPets) do
        if spriteID == v:getSpriteID() then
            panel = self.skillPanels[k]
            break
        end
    end
    if panel then
        panel:getChildByName("SkillBg"):useShader(UI.COMPONENT_GRAY_SHADER)
        panel:getChildByName("Board"):useShader(UI.COMPONENT_GRAY_SHADER)
        local head = panel:getChildByName("HEAD")
        if head then
            head:useShader(UI.COMPONENT_GRAY_SHADER)
        end
        local skillIcon = panel:getChildByName("SkillBg"):getChildByName("SkillIcon")
        if skillIcon then
            skillIcon:useShader(UI.COMPONENT_GRAY_SHADER)
        end
    end
end

function PetPVPUILayer:revive(spriteID)
    local bar = self.progressBars[spriteID]
    if bar then
        bar:useShader(UI.COMPONENT_NORMAL_SHADER)
        local pet = nil
        local panel = nil
        for k, v in ipairs(self.myPets) do
            if spriteID == v:getSpriteID() then
                pet = v
                panel = self.skillPanels[k]
                break
            end
        end
        if pet and pet:getGiftedSkill() then
            local skillData = SkillDataManager:createSkillForSkillId(pet:getGiftedSkill())
            bar:stopAllActions()
            bar:setBarChangeAction(0.51, 0.794, skillData.enterFightCD + 1)
        end
        if panel then
            panel:getChildByName("SkillBg"):useShader(UI.COMPONENT_NORMAL_SHADER)
            panel:getChildByName("Board"):useShader(UI.COMPONENT_NORMAL_SHADER)
            local head = panel:getChildByName("HEAD")
            if head then
                head:useShader(UI.COMPONENT_NORMAL_SHADER)
            end
            local skillIcon = panel:getChildByName("SkillBg"):getChildByName("SkillIcon")
            if skillIcon then
                skillIcon:useShader(UI.COMPONENT_GRAY_SHADER)
            end
        end
    end
end

function PetPVPUILayer:refreshPetsHP(progressBar)
    local myPetsCurHP = 0
    local myPetsHP = 0

    for k, v in pairs(self.myPets) do
        myPetsHP = myPetsHP + v:getHp()
        myPetsCurHP = myPetsCurHP + v:getCurHp()
    end

    progressBar:setPercent(myPetsCurHP / myPetsHP)
    local text = progressBar:getChildByName("HP")
    text:setText(string.format("%d/%d", myPetsCurHP, myPetsHP))
    
end

function PetPVPUILayer:refreshEnemyCurPetsHP(progressBar)
    local enermyPetsCurHP = 0
    local enermyPetsHP = 0

    for k, v in pairs(self.enemyPets) do
        enermyPetsHP = enermyPetsHP + v:getHp()
        enermyPetsCurHP = enermyPetsCurHP + v:getCurHp()
    end
    
    progressBar:setPercent(enermyPetsCurHP / enermyPetsHP)
    local text = progressBar:getChildByName("HP")
    text:setText(string.format("%d/%d", enermyPetsCurHP, enermyPetsHP))
end

-- 注册监听事件(可选)
function PetPVPUILayer:registerListener()
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_INIT_PET_PVP_DATA, self, self.refreshView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN, self, self.skillRefreshCD)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_USE_SKILL_RESULT,self,self.onUseSkillResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.enterFight)
    Avalon.MessageCenter:bind(AvalonMessage.MC_PET_DEAD,  self, self.petDie)
    Avalon.MessageCenter:bind(AvalonMessage.MC_PET_REVIVE,  self, self.revive)
end

-- 注销监听事件(可选)
function PetPVPUILayer:unRegisterListener()
    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_INIT_PET_PVP_DATA, self, self.refreshView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SKILL_COOLDOWN, self, self.skillRefreshCD)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_USE_SKILL_RESULT,self,self.onUseSkillResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.enterFight)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PET_DEAD,  self, self.petDie)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PET_REVIVE,  self, self.revive)
end




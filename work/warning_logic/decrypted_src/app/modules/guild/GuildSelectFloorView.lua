------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/05/28
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GuildSelectFloorView = class("GuildSelectFloorView", UI.HWBtnComponent)
local scheduler = cc.Director:getInstance():getScheduler()
local GameDataManager = require("app.game.GameDataManager")
-- 资源
local COM_RES_LIST = {
    "ui_town_guild_selectFloor.plist",
    "ui_package_log.plist",
    "ui_town_guild_giftbox.plist",
    "ui_package_log.plist"
}

local COM_WIDTH = 910
local COM_HEIGHT = 610
local animationName = "roleAnimation"
local MAX_INDEX = 5

local layoutUtil
function GuildSelectFloorView:ctor(params)
    GuildSelectFloorView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.bossDataArr = mvc.guildModel:getBossDataArr()
    -- self.choiceIndex = params
    -- print("GuildSelectFloorView params=", params)
    if(self.choiceIndex == nil) then 
        self.choiceIndex = 0;
    end

    self:bindModel()
    layoutUtil = UIUtil:createAutoUILayout("GuildSelectFloorView","app.modules.guild.GuildPosConfig", false)

    -- local index = 1
    -- self.schedulerID = scheduler:scheduleScriptFunc(handler(self, function()
    --     local mn = {}
    --     local oneStrLog = {}
    --     oneStrLog.type = index%2 + 1

    --     local monsterName = "小怪物"
    --     local heroName = UI.TEXT_1212707

    --     if(oneStrLog.type ==  GUILD_LOG_TYPE.GUILD_LOG_TYPE_FIGHT) then 
    --         oneStrLog.str = string.format(UI.TEXT_1212705, heroName, monsterName, 12)
    --     elseif(oneStrLog.type ==  GUILD_LOG_TYPE.GUILD_LOG_TYPE_BOX) then 
    --         oneStrLog.str = string.format(UI.TEXT_1212706, heroName, monsterName, 1)
    --     end
    --     print("add one message", oneStrLog)
    --     table.insert(mn, oneStrLog)

    --     self:addLogMes(mn)
    --     index = index + 1
    -- end), 1, false)
end

function GuildSelectFloorView:dtor()
    -- if self.schedulerID then
    --     scheduler:unscheduleScriptEntry(self.schedulerID)
    --     self.schedulerID = nil
    -- end
    GuildSelectFloorView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.guild.GuildSelectFloorView")
end


function GuildSelectFloorView:onInitView()
    local img = UI.Image:create()
    img:init('ui_guild_copy_bg.png')
    addChildAuto(layoutUtil, self, img, "img")

    local rootLayout = UI.Layout:create()
    rootLayout:init()
    rootLayout:setSize(COM_WIDTH, COM_HEIGHT)
    rootLayout:center()
    self:addChild(rootLayout)
    self.rootLayout = rootLayout

    --boss 头像列表
    self:initLeftMenu()
    -- 左下角血条
    self:initLeftBottom()
    -- 右边区域
    self:initRight()
    -- 左上角区域
    self:initLeftUp()
    
    self:updateHpView()
    self:refreshChallenge()
    self:refreshBuyBuff()
    self:onHeadClick(self.choiceIndex + 1)
end

function GuildSelectFloorView:initLeftMenu()
    local layout = UI.TouchLayout:create()
    layout:init()
    layout:setSize(80, 415)
    layout:addTouchEvents(self)

    local view = UI.ScrollView:create()
    view:setSize(80, 415)
    view:init(0,0,0,0)
    view:leftBottom(16, 116)
    view:addInnerNode(layout)
    view:setScrollType(UI.ScrollType.VERTICAL)
    self.rootLayout:addChild(view)
    self.bossHeadView = view

    -- body
    self.headIconList = {}
    if(self.choiceIndex and self.bossDataArr) then 
        for k, v in ipairs(self.bossDataArr) do 
            local headBg = UI.Image:create()
            headBg:init("ui_guild_copy_monsterhead_box.png")
            headBg:centerUp((k - 1) * 82 + 9)
            layout:addChild(headBg)
            table.insert(self.headIconList, headBg)
        end
    end
    self:refreshHeadIcon()
end

function GuildSelectFloorView:refreshHeadIcon()
    for k, v in ipairs(self.bossDataArr) do 
        local headBg = self.headIconList[k]
        if headBg then
            headBg:removeChildByName("BG")
            headBg:removeChildByName("Progress")

            local bg = UI.Image:create()
            bg:init("icon_monsterhead_banner_normal.png")
            bg:center()
            headBg:addChild(bg)
            bg:setName("BG")

            local monsterID = v:getBossID()
            local monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(monsterID, PublicDefine.CAVE_MODE.MODE_GUILD_BOSS, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
            local icon  = UI.Image:create()
            icon:init(monsterData:getIcon()..".png")
            icon:center()
            bg:addChild(icon)

            local guildBossPool = ConfigManager:getGuildBossPoolByID(v:getBossID())
            if(guildBossPool ~= nil) then 
                local multiHP = guildBossPool.multiHP
                local maxHp = monsterData:getHp()
                local curHp = maxHp - v:getLoseHP()
                curHp = curHp < 0 and 0 or curHp
                local mulHpArr,index, indexHp = ToolsUtil:calculationMulHp(curHp, maxHp, multiHP)
                local progressBg, progress = self:_getSmallHPSpriteName(index, mulHpArr)

                local progressTimer = UI.ProgressTimer:create()
                progressTimer:init(progressBg, progress, progress)
                progressTimer:centerBottom(-6)
                headBg:addChild(progressTimer, 200)
                progressTimer:setName("Progress")
                progressTimer:setPercent(indexHp / mulHpArr[index])
            end
            if v:getIsKilled() then 
                local clear = UI.Image:create()
                clear:init("ui_guild_copy_monsterhead_clear.png")
                clear:centerUp(1)
                bg:addChild(clear, 5)

                icon:useShader(UI.COMPONENT_GRAY_SHADER)
            end
        end
    end
end

function GuildSelectFloorView:onTouchBegan(touch, event)
    print("--------------------------GuildSelectFloorView onTouchBegan")
    local location = touch:getLocation()
    self.beginTouchPosition = location

    --检查是否在可点击区域 邮件活动区域
    if not AvalonUtil:isRectContainsPoint(self.bossHeadView, location) then
        return
    end 

    --检查是否在可点击区域 奖励滑动区域
    if (self.bossHeadView and not tolua.isnull(self.bossHeadView)) and not AvalonUtil:isRectContainsPoint(self.bossHeadView, location) then
        return
    end 
end

function GuildSelectFloorView:onTouchEnded(touch, event)
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

   --检查是否在可点击区域 邮件活动区域
    if not AvalonUtil:isRectContainsPoint(self.bossHeadView, location) then
        return
    end 

    --检查是否在可点击区域 奖励滑动区域
    if (self.bossHeadView and not tolua.isnull(self.bossHeadView)) and not AvalonUtil:isRectContainsPoint(self.bossHeadView, location) then
        return
    end 

    for k, value in ipairs(self.headIconList) do
        if AvalonUtil:isRectContainsPoint(value, location) then
            self:onHeadClick(k) 
            break
        end
    end
end

function GuildSelectFloorView:onHeadClick(index)
    self.choiceIndex = index - 1
    if(self.choiceIndex < 0) then 
        self.choiceIndex = MAX_INDEX -1
    end
    local bingoNode = nil
    for k, value in ipairs(self.headIconList) do
        value:removeChildByName("SelectAction")
        if self.choiceIndex == k - 1 then
            bingoNode = value
        end
    end
    if bingoNode then
        local selectItem = UI.Animation:create()
        selectItem:init("effect_ui_general_guild_xuanzhong.json", "effect_ui_general_guild_xuanzhong.atlas")
        selectItem:center()
        selectItem:setAnimation("idle", false)
        selectItem:setName("SelectAction")
        bingoNode:addChild(selectItem, 100)
    end

    self:refreshMonsterInfo()
    self:refreshChallenge()
end


function GuildSelectFloorView:initLeftUp()
    local leftUpLayout = UI.Layout:create()
    leftUpLayout:init()
    leftUpLayout:setSize(507, 406)
    -- leftUpLayout:enableDebugDraw()
    leftUpLayout:leftBottom(17, 123)
    self.rootLayout:addChild(leftUpLayout)
    self.leftUpLayout = leftUpLayout   

    self:createMonsterInfo()

    self:refreshMonsterInfo(nil, nil)
end

function GuildSelectFloorView:initLeftBottom()
    local leftBottomLayout = UI.Layout:create()
    leftBottomLayout:init()
    leftBottomLayout:setSize(507, 123)
    -- leftBottomLayout:enableDebugDraw()
    leftBottomLayout:leftBottom(17, 0)
    self.rootLayout:addChild(leftBottomLayout)
    self.leftBottomLayout = leftBottomLayout   

    -- 提示语言
    local tipsIcon = UI.Image:create()
    tipsIcon:init("ui_information_reminder.png")
    tipsIcon:leftBottom(85 - tipsIcon:getContentSize().width/2, 105 - tipsIcon:getContentSize().height/2)
    self.leftBottomLayout:addChild(tipsIcon)

    local tipsText = UI.Text:create()
    tipsText:init(UI.TEXT_1212700, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    tipsText:centerLeft(tipsIcon:getContentSize().width + 4)
    tipsIcon:addChild(tipsText)

    -- 进度
    local progressTimer =  UI.ProgressTimer:create()
    progressTimer:init("ui_guild_copy_progressbar_0.png", "ui_guild_copy_progressbar_1.png", "ui_guild_copy_progressbar_1.png")
    progressTimer:leftBottom(3, 70 - progressTimer:getContentSize().height/2)
    self.leftBottomLayout:addChild(progressTimer)
    self.progressTimer = progressTimer

    -- 怪物血条血量
    local progressText = UI.Text:create()
    progressText:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_BLACK )
    -- progressText:useDefaultOutLineShadowStyle()
    progressText:setSize(300, 30)
    progressText:setTextCenter()
    progressText:center(0, -2)
    progressTimer:addChild(progressText, 100)
    self.progressText = progressText

    -- 血量叠层数
    local hpLayerText = UI.Text:create()
    hpLayerText:init("X 1", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_WHITE)
    -- hpLayerText:useDefaultOutLineShadowStyle()
    hpLayerText:setTextCenter()
    hpLayerText:center(270, -2)
    progressTimer:addChild(hpLayerText, 100)
    self.hpLayerText = hpLayerText

    -- 宝箱表现
    local boxImage = UI.Image:create()
    boxImage:init("ui_guild_giftbag_icon_6.png")
    boxImage:setScale(0.77)
    boxImage:centerLeft(25- boxImage:getContentSize().width/2 * boxImage:getScale())
    progressTimer:addChild(boxImage, 100)
    self.boxImage = boxImage

    -- 激活的展现
    local rewardImage = UI.Image:create()
    rewardImage:init("ui_guild_copy_box.png")
    rewardImage:rightBottom(-63, 42 - rewardImage:getContentSize().height/2)
    self.leftBottomLayout:addChild(rewardImage)

    local rewardTitle = UI.Text:create()
    rewardTitle:init(UI.TEXT_1212701, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    rewardTitle:centerLeft(- rewardTitle:getContentSize().width - 4)
    rewardImage:addChild(rewardTitle, 10)

    local rewardDes = UI.Text:create()
    rewardDes:init("X0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    rewardDes:centerLeft(rewardDes:getContentSize().width)
    rewardImage:addChild(rewardDes, 10)
    self.rewardDes = rewardDes
end

function GuildSelectFloorView:showMsgLayer()
    local function showOutSizeTouchHandler(self, obj, touchPosition)
        if (not tolua.isnull(self.chatPanel)) then
            self.chatPanel:removeFromParent(true)
            self.chatPanel = nil
        end
    end

  -- 消息列表
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(355, 465)
    layout:leftBottom(156, 64)
    self.rootLayout:addChild(layout, 10)
    layout:setTouchEnable(true)
    layout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, showOutSizeTouchHandler)
    self.chatPanel = layout

    local bg =  UI.Image9:create()
    bg:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(345, 465))
    bg:centerLeft(10)
    layout:addChild(bg)

    local arrow =  UI.Image:create()
    arrow:init("ui_information_banner_background2.png")
    arrow:leftUp(1, 10)
    layout:addChild(arrow)
    arrow:setScaleX(-1)

    local dialogLayer = UI.ChatDialogLayer:create(ChatChannelType.GUILD_SELECT_FLOOR, ChatDialogType.MainLayer)
    dialogLayer:init(320, 445, true)
    dialogLayer:leftUp(25, 10)
    layout:addChild(dialogLayer)
    dialogLayer:initDiaLogLayer()
    self.dialogLayer = dialogLayer
    local logStrArr = mvc.guildModel:getLogStrArr()
    -- print("ddfdfdfdfdf  2")
    if(logStrArr) then 
        self:addLogMes(logStrArr)
    end
end

function GuildSelectFloorView:initRight()
    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:setSize(290, 529)
    rightLayout:rightBottom(0, 2)
    self.rootLayout:addChild(rightLayout)
    self.rightLayout = rightLayout   

  
    local PBuffData = SkillDataManager:createBufferData(tonumber(ConfigManager:getGuildConfigForKey("guildBossPersonalBuff"))) or {}
    local GBuffData = SkillDataManager:createBufferData(tonumber(ConfigManager:getGuildConfigForKey("guildBossBuffid"))) or {}
    local bufList = {PBuffData, GBuffData}

    self.bufPanel = {}
    for k, buffData in ipairs(bufList) do
        local name = ""
        local des = ""
        if(buffData) then 
            name = buffData:getName()
            des = buffData.description
        end
        local panel = UI.Layout:create()
        panel:init()
        panel:setSize(127, 427)
        panel:leftUp((k - 1) * 128, 0)
        self.rightLayout:addChild(panel)

        local bg = UI.Image:create()
        bg:init("ui_guild_copy_flag_1_2.png")
        bg:center()
        bg:setName("BG")
        panel:addChild(bg)

        --buffIcon
        local buffIcon = UI.Image:create()
        buffIcon:init("ui_guild_copy_ofa_1.png")
        buffIcon:centerUp(47)
        bg:addChild(buffIcon)
        buffIcon:setName("BuffIcon")

        -- buff 加成
        local buffTitle = UI.Text:create()
        buffTitle:init(name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 220, g = 170, b = 80})
        buffTitle:setSize(116, 40)
        buffTitle:centerUp(3)
        buffTitle:setTextCenter()
        buffTitle:setLineSpacing(-4)
        buffTitle:setName("Title")
        panel:addChild(buffTitle, 1)

        local buffBtn = UI.Button:create()
        buffBtn:init("ui_btn_guild_copy_0.png", "ui_btn_guild_copy_1.png", "ui_btn_guild_copy_2.png")
        buffBtn:center(2, 132)
        buffBtn:setTextWidth(80)
        buffBtn:setTextFont( UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
        buffBtn._text:setTextCenter()
        buffBtn._text:setLineSpacing(-8)
        panel:addChild(buffBtn, 1)
        buffBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:onBuyBuffClick(panel, k == 1)
        end)
         buffBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            self:onDisableBuffClick(panel, k == 1)
        end)
        buffBtn:setFontColor(UI.FONT_COLOR_50_50_44)
        buffBtn:setName("BuffBtn")

        local diamondIcon = UI.Image:create()
        diamondIcon:init("symbol_gaming_diamond.png")
        diamondIcon:centerLeft(10)
        buffBtn:addChild(diamondIcon, 10)
        diamondIcon:setVisible(false)
        diamondIcon:setName("DiamondIcon")

        local diamondNum = UI.Text:create()
        diamondNum:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
        diamondNum:centerLeft(10)
        buffBtn:addChild(diamondNum, 10)
        diamondNum:setVisible(false)
        diamondNum:setName("DiamondNum")

        local buffDes = UI.Text:create()
        buffDes:init(des, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, {r = 190, g = 160, b = 150})
        buffDes:setWidth(110)
        buffDes:autoAdapt()
        buffDes:center(5, 25)
        buffDes:setTextLeftUp()
        buffDes:setLineSpacing(-2)
        panel:addChild(buffDes, 1)
        table.insert(self.bufPanel, panel)
    end
   
    -- 挑战按钮
    local challengeBtn = UI.Button:create()
    challengeBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    challengeBtn:rightBottom(58, 53)
    challengeBtn:setTextFont( UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    challengeBtn:setText(UI.TEXT_1212702)
    self.challengeBtn = challengeBtn
    challengeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onChallengeClick)
    self.rightLayout:addChild(challengeBtn)

    local challengeDes = UI.Text:create()
    challengeDes:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_170_170_170)
    challengeDes:rightBottom(60, 30 - challengeDes:getContentSize().height/2)
    self.rightLayout:addChild(challengeDes)
    self.challengeDes = challengeDes

    local challengeTitle = UI.Text:create()
    challengeTitle:init(UI.TEXT_1212082, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_170_170_170)
    challengeTitle:centerLeft(- challengeTitle:getContentSize().width)
    challengeDes:addChild(challengeTitle)

    self:refreshBuyBuff()
    self:refreshChallenge()
end


function GuildSelectFloorView:createOneAttr(iconName, iconX, iconY, txtOffsetX, txtSetName, iconSetName)
    -- body
    local attrImage = UI.ImageText:create()
    attrImage:init(iconName, "", UI.FONT_STANDARD,UI.FONT_SIZE_16PX)
    attrImage:setSize(143, 30)
    attrImage:leftBottom(iconX, iconY - attrImage:getContentSize().height/2)
    attrImage:setName(txtSetName)
    attrImage:setTextFixLineWidth(110)
    attrImage:setFrameSpace(-attrImage:getSpriteWidth()/2, 19)
    -- end
    self.monsterLayer:addChild(attrImage)
end

function GuildSelectFloorView:createStar(starNum)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(128, 24)
    self:updateStar(layout, starNum)

    return layout
end

function GuildSelectFloorView:updateStar(layout, starNum)
    layout:removeAllChildren(true)
    if(starNum) then 
        local yu = math.fmod(starNum, 5)
        local starLevel = math.modf(starNum/5)
        local nowStarNum = starNum
        -- print("GuildSelectFloorView:updateStar",starNum, yu, starLevel, nowStarNum)
        if(yu == 0) then 
            nowStarNum = 5
        else 
            starLevel = starLevel + 1
            nowStarNum = yu
        end
        if(starLevel == 0) then 
            starLevel = 1
        end 
        local spriteName = string.format("ui_guild_copy_star_%d.png", starLevel)
        if(starLevel > 6) then 
            spriteName = "ui_guild_copy_star_6.png"
        end

        for i= 1, nowStarNum, 1 do 
            local starImage = UI.Image:create()
            starImage:init(spriteName)
            starImage:centerLeft((i - 1) *  27)
            layout:addChild(starImage)
        end
    end
end

--创建怪物属性
function GuildSelectFloorView:createMonsterInfo()
    self.monsterLayer = UI.Layout:create()
    self.monsterLayer:init()
    self.monsterLayer:setSize(507, 406)
    self.monsterLayer:leftBottom(84, 0)
    self.leftUpLayout:addChild(self.monsterLayer)
    local BG = UI.Image:create()
    BG:init("ui_guild_copy_paper.png")
    BG:leftBottom(-5, -3)
    BG:setName("BG")
    self.monsterLayer:addChild(BG)

    local infoBtn = UI.Button:create()
    infoBtn:init("ui_btn_guild_diary_0.png", "ui_btn_guild_diary_1.png", "ui_btn_guild_diary_1.png")
    infoBtn:leftUp(20, -7)
    self.monsterLayer:addChild(infoBtn)
    infoBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:showMsgLayer()
    end)


    local _monsterBG = UI.Image:create() --cc.Sprite:createWithSpriteFrameName("ui_log_banner_page_scene1.png")
    _monsterBG:init("ui_log_banner_page_scene1.png")
    _monsterBG:leftBottom(14, 35)
    _monsterBG:setName("monsterBG")
    self.monsterLayer:addChild(_monsterBG)

    -- 怪物死亡状态
    local monsterStatusImage = UI.Image:create()
    monsterStatusImage:init("ui_guild_copy_clear.png")
    monsterStatusImage:center()
    _monsterBG:addChild(monsterStatusImage, 1000)
    self.monsterStatusImage = monsterStatusImage
    monsterStatusImage:setVisible(false)

    -- 战斗中状态
    local battleAnimation = UI.Animation:create()
    battleAnimation:init("effect_ui_town_guild_guildfuben_fighting.json", "effect_ui_town_guild_guildfuben_fighting.atlas")
    battleAnimation:setInnerOffset(-2, -2)
    battleAnimation:leftUp(30, 30)
    battleAnimation:setAnimation("idle", true)
    _monsterBG:addChild(battleAnimation, 999)
    self.battleAnimation = battleAnimation

    local battleDes = UI.Text:create()
    battleDes:init(UI.TEXT_1212708,UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    battleDes:rightBottom(-25- battleDes:getContentSize().width, -20)
    battleDes:setFontColor(UI.FONT_COLOR_216_61_45)
    battleAnimation:addChild(battleDes, 100)

    local namebg = UI.Image:create()
    namebg:init("ui_information_nametitle.png")
    namebg:centerUp(13)
    self.monsterLayer:addChild(namebg)

    local txtName = UI.Text:create()
    txtName:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX)
    txtName:center()
    txtName:setFontColor(UI.FONT_COLOR_190_190_190)
    txtName:setWidth(243)
    txtName:setTextCenter()
    txtName:setName("txtName")
    namebg:addChild(txtName)
    self.txtName = txtName

    -- 怪物难度
    local tipsText = UI.Text:create()
    tipsText:init(UI.TEXT_1170906..":", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    tipsText:leftUp(310, 66)
    self.leftUpLayout:addChild(tipsText)

    local starLayout = self:createStar(mvc.guildModel:getHardLv())
    starLayout:centerLeft(tipsText:getContentSize().width + 4)
    tipsText:addChild(starLayout)
    self.starLayout = starLayout

    --弱点
    local weakImageBg = UI.Image:create()
    weakImageBg:init("ui_guild_copy_weekness.png")
    weakImageBg:rightUp(10, 10)
    self.monsterLayer:addChild(weakImageBg)
    self.weakImageBg = weakImageBg

    local weakImage = UI.Image:create()
    weakImage:init("symbol_monsterattribute_dark_2.png")
    weakImage:center()
    weakImageBg:addChild(weakImage)
    self.weakImage = weakImage

    local weaknessTitle = UI.Text:create()
    weaknessTitle:init(UI.TEXT_DES_WEAK, UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    weaknessTitle:setFontColor(UI.FONT_COLOR_41_41_45)
    weaknessTitle:centerBottom(-18)
    weakImageBg:addChild(weaknessTitle)
    self.weaknessTitle = weaknessTitle
    
    -- 展示buff 的表现
    local buffLayout = UI.Layout:create()
    buffLayout:init()
    buffLayout:setSize(40, 0)
    buffLayout:leftUp(240, 83)
    self.leftUpLayout:addChild(buffLayout)
    self.buffLayout = buffLayout
    buffLayout:setTouchEnable(true)
    buffLayout:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(sender, comp, touchPosition)
        if self then
            local nodePosition = self:convertToNodeSpace(touchPosition)
            -- print("nodePosition=", nodePosition)
            self:showBufInfo(self.buffDataArr, nodePosition)
        end
    end)
    buffLayout:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(sender, comp, touchPosition)
        if self then
            self:hideBufInfo()
        end
    end)


    local oneLineStartX = 238
    local twoLineStartX = 378
    local txtOffsetX = 20
    -- --金币
    -- self:createOneAttr("symbol_gaming_money.png", oneLineStartX, 300, txtOffsetX, "txtMoney")
    -- --经验
    -- self:createOneAttr("symbol_gaming_xp_cn.png", twoLineStartX, 300, txtOffsetX, "txtXP", nil)

    local _picLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    _picLine:setContentSize(270, 1)
    _picLine:setCapInsets(CCRectMake(1,0,1,1))
    _picLine:setPosition(cc.p(220  + _picLine:getContentSize().width/2 , 295))
    
    self.monsterLayer:addChild(_picLine)

    --血量
    self:createOneAttr("symbol_gaming_blood.png", oneLineStartX, 276, txtOffsetX, "txtHP", nil)
    --攻击力
    self:createOneAttr("symbol_gaming_atk.png", oneLineStartX, 250, txtOffsetX, "txtAtk", "_iconAtk")
    --魔法攻击力
    self:createOneAttr("symbol_gaming_maggicatk.png", oneLineStartX, 250, txtOffsetX, "txtMagicAtk", "_iconMagicAtk")
    --攻击速度
    self:createOneAttr("symbol_gaming_aspd.png", twoLineStartX, 250, txtOffsetX, "txtAspd")

    local _picLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    _picLine:setContentSize(270, 1)
    _picLine:setCapInsets(CCRectMake(1,0,1,1))
    _picLine:setPosition(cc.p(220 + _picLine:getContentSize().width/2 , 235))
    self.monsterLayer:addChild(_picLine)

    local offsetY = 216
    local oneSpaceY = 30
    local index = 0
    --防御
    self:createOneAttr("symbol_gaming_def.png", oneLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtDef")
    --魔法防御
    self:createOneAttr("symbol_gaming_maggicdef.png", twoLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtMaggicdef")
    index = index + 1
    --火攻击
    self:createOneAttr("symbol_monsterattribute_fire_1.png", oneLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtFireAtk")
    --火防御
    self:createOneAttr("symbol_monsterattribute_fire_2.png", twoLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtFireDef")
    index = index + 1
    --水攻击
    self:createOneAttr("symbol_monsterattribute_water_1.png", oneLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtWaterAtk")
    --水防御
    self:createOneAttr("symbol_monsterattribute_water_2.png", twoLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtWaterDef")
    index = index + 1
    --木攻击
    self:createOneAttr("symbol_monsterattribute_wood_1.png", oneLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtWoodAtk")
    --木防御
    self:createOneAttr("symbol_monsterattribute_wood_2.png", twoLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtWoodDef")
    index = index + 1
    --光攻击
    self:createOneAttr("symbol_monsterattribute_light_1.png", oneLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtLightAtk")
    --光防御
    self:createOneAttr("symbol_monsterattribute_light_2.png", twoLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtLightDef")
    index = index + 1
    --暗攻击
    self:createOneAttr("symbol_monsterattribute_dark_1.png", oneLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtDarkAtk")
    --暗防御
    self:createOneAttr("symbol_monsterattribute_dark_2.png", twoLineStartX, offsetY - index * oneSpaceY, txtOffsetX, "txtDarkDef")

    local _picLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    _picLine:setContentSize(270, 1)
    _picLine:setCapInsets(CCRectMake(1,0,1,1))
    _picLine:setPosition(cc.p(220 + _picLine:getContentSize().width/2 , 44))
    self.monsterLayer:addChild(_picLine)    
end

function GuildSelectFloorView:refreshMonsterInfo(monsterData, originalMonsterData)
    local monsterID = 0
    local guildBossData = nil
    if(self.choiceIndex and self.bossDataArr) then 
        for k, v in ipairs(self.bossDataArr) do 
            if(v:getBossIndex() == self.choiceIndex) then 
                monsterID = v:getBossID()
                guildBossData = v
                break
            end
        end
    end

    self:updateHpView()

    local monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(monsterID, PublicDefine.CAVE_MODE.MODE_GUILD_BOSS, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)

    -- 添加的测试数据
    -- if(monsterData == nil) then
    --     monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(10208207, PublicDefine.CAVE_MODE.MODE_GUILD_BOSS, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    -- end

    if(monsterData == nil) then 
        return
    end

    local _monsterBG = self.monsterLayer:getChildByName("monsterBG")
    if monsterData == nil then
        _monsterBG:setSpriteName("ui_log_banner_page_scene"..ToolsUtil:getPageSceneID(originalMonsterData)..".png")
    else
        _monsterBG:setSpriteName("ui_log_banner_page_scene"..ToolsUtil:getPageSceneID(monsterData)..".png")
    end

    local animation = _monsterBG:getChildByName(animationName)
    if(not tolua.isnull(animation)) then 
        -- animation:runAction(cc.RemoveSelf:create())
        animation:removeFromParent()
    end

    local roleAnimation = nil
    if monsterData ~= nil then
        roleAnimation = Avalon.Animation:create(monsterData.spine..".json", monsterData.spine..".atlas", 1)
        roleAnimation:setAnimation(0, "idle1", true)
        roleAnimation:setPosition(_monsterBG:getContentSize().width/2, _monsterBG:getContentSize().height/3)
        _monsterBG:addChild(roleAnimation,100)
        roleAnimation:setName(animationName)
        roleAnimation:setScale(monsterData.size/1000.0)
        -- todo 手动调整坐标 解决盖亚位置偏移的问题
        if checkint(monsterData.monsterID) == 10201305 or checkint(monsterData.monsterID) == 10204305 then
            roleAnimation:setPositionX(roleAnimation:getPositionX() + 20)
            roleAnimation:setPositionY(roleAnimation:getPositionY() - 50)
        end  

        if checkint(monsterData.monsterID) == 10205301 or checkint(monsterData.monsterID) == 10206301 then
            roleAnimation:setPositionY(roleAnimation:getPositionY() - 26)
        end 
        roleAnimation:registerSpineEventHandler(function(event)
            if event.animation == "idle1" then
                local roleAnimation = self.monsterLayer:getChildByName("monsterBG"):getChildByName("roleAnimation")
                if math.random() < 0.3 then
                    roleAnimation:setAnimation(0, "idle2", false)
                    roleAnimation:addAnimation(0, "idle1", true)
                end
            end
        end,sp.EventType.ANIMATION_COMPLETE)
    else
        roleAnimation = Avalon.Animation:create(originalMonsterData.spine..".json", originalMonsterData.spine..".atlas", 1)
        roleAnimation:setAnimation(0, "idle1", true)
        roleAnimation:setPosition(_monsterBG:getContentSize().width/2, _monsterBG:getContentSize().height/3)
        _monsterBG:addChild(roleAnimation,100)
        roleAnimation:setName(animationName)
        roleAnimation:setScale(originalMonsterData.size/1000.0)
        -- todo 手动调整坐标 解决盖亚位置偏移的问题
        if checkint(originalMonsterData.monsterID) == 10201305 or checkint(monsterData.monsterID) == 10204305 then
            roleAnimation:setPositionX(roleAnimation:getPositionX() + 20)
            roleAnimation:setPositionY(roleAnimation:getPositionY() - 50)
        end
        
        roleAnimation:registerSpineEventHandler(function(event)
            if event.animation == "idle1" then
                local roleAnimation = self.monsterLayer:getChildByName("monsterBG"):getChildByName("roleAnimation")
                if math.random() < 0.3 then
                    roleAnimation:setAnimation(0, "idle2", false)
                    roleAnimation:addAnimation(0, "idle1", true)
                end
            end
        end,sp.EventType.ANIMATION_COMPLETE)
    end

    -- 根据怪物状态判断相关的表现
    if guildBossData and guildBossData:getIsKilled() then 
        if roleAnimation  then
            local glProgramState = AvalonUtil:getAnimationGrayGLProgramState()

            roleAnimation:setGLProgramState(glProgramState)
            roleAnimation:setAnimation(0, "idle1", true)
            roleAnimation:updateTime(0.1)
            roleAnimation:setTimeScale(0)
        end
        self.monsterStatusImage:setVisible(true)
    else
        self.monsterStatusImage:setVisible(false)
    end
    if(guildBossData) then
        self.battleAnimation:setVisible(guildBossData:getIsFighting())
    else 
        self.battleAnimation:setVisible(false)
    end

    if monsterData == nil then
        self.txtName:setText(originalMonsterData.name)
    else
        self.txtName:setText(monsterData.name)
    end

    -- local txtMoney = self.monsterLayer:getChildByName("txtMoney")
    -- if monsterData == nil then
    --     txtMoney:setText("???")
    -- else
    --     txtMoney:setText(string.split(string.split(monsterData.dropCoin,";")[1],",")[1])
    -- end

    -- local txtXP = self.monsterLayer:getChildByName("txtXP")
    -- if monsterData == nil then
    --     txtXP:setText("???")
    -- else
    --     txtXP:setText(string.split(string.split(monsterData.dropExp,";")[1],",")[1])
    -- end

    local txtHP = self.monsterLayer:getChildByName("txtHP")
    if monsterData == nil then
        txtHP:setText("???")
    else
        txtHP:setText(string.split(string.split(monsterData.hp,";")[1],",")[1])
    end

    local txtAtk = self.monsterLayer:getChildByName("txtAtk")
    local txtMagicAtk = self.monsterLayer:getChildByName("txtMagicAtk")

    if monsterData == nil then
        txtAtk:setVisible(true)
        txtMagicAtk:setVisible(false)
        txtAtk:setText("???-???")
    else
        if string.split(string.split(monsterData.atkMin,";")[1],",")[1] ~= "0" then
            txtAtk:setVisible(true)
            txtMagicAtk:setVisible(false)
            txtAtk:setText(string.split(string.split(monsterData.atkMin,";")[1],",")[1].."-"..string.split(string.split(monsterData.atkMax,";")[1],",")[1])
        else
            txtAtk:setVisible(false)
            txtMagicAtk:setVisible(true)
            txtMagicAtk:setText(string.split(string.split(monsterData.magicAtkMin,";")[1],",")[1].."-"..string.split(string.split(monsterData.magicAtkMax,";")[1],",")[1])
        end
        -- txtAtk:setText("23232323-34343434")
    end

    local txtAspd = self.monsterLayer:getChildByName("txtAspd")
    if monsterData == nil then
        txtAspd:setText("???")
    else
        -- txtAspd:setText(string.split(string.split(monsterData.atkSpd,";")[1],",")[1])
        txtAspd:setText(string.format("%.1f", tonumber(string.split(string.split(monsterData.atkSpd,";")[1],",")[1])/1000))
    end

    local txtDef = self.monsterLayer:getChildByName("txtDef")
    if monsterData == nil then
        txtDef:setText("???")
    else
        txtDef:setText(string.split(string.split(monsterData.physicDef,";")[1],",")[1])
    end

    local txtMaggicdef = self.monsterLayer:getChildByName("txtMaggicdef")
    if monsterData == nil then
        txtMaggicdef:setText("???")
    else
        txtMaggicdef:setText(string.split(string.split(monsterData.magicDef,";")[1],",")[1])
    end

    local txtFireAtk = self.monsterLayer:getChildByName("txtFireAtk")
    if monsterData == nil then
        txtFireAtk:setText("???")
    else
        local atkFire = string.split(string.split(monsterData.atkFire,";")[1],",")[1]
        if atkFire == "0" then
            txtFireAtk:setText("---")
        else
            txtFireAtk:setText(atkFire)
        end
    end

    local txtFireDef = self.monsterLayer:getChildByName("txtFireDef")
    if monsterData == nil then
        txtFireDef:setText("???")
    else
        local defFire = string.split(string.split(monsterData.defFire,";")[1],",")[1]
        if defFire == "0" then
            txtFireDef:setText("---")
        else
            txtFireDef:setText(defFire)
        end
    end

    local txtWaterAtk = self.monsterLayer:getChildByName("txtWaterAtk")
    if monsterData == nil then
        txtWaterAtk:setText("???")
    else
        local atkWater = string.split(string.split(monsterData.atkWater,";")[1],",")[1]

        if atkWater == "0" then
            txtWaterAtk:setText("---")
        else
            txtWaterAtk:setText(atkWater)
        end
    end

    local txtWaterDef = self.monsterLayer:getChildByName("txtWaterDef")
    if monsterData == nil then
        txtWaterDef:setText("???")
    else
        local defWater = string.split(string.split(monsterData.defWater,";")[1],",")[1]
        if defWater == "0" then
            txtWaterDef:setText("---")
        else
            txtWaterDef:setText(defWater)
        end
    end

    local txtWoodAtk = self.monsterLayer:getChildByName("txtWoodAtk")
    if monsterData == nil then
        txtWoodAtk:setText("???")
    else
        local atkWood = string.split(string.split(monsterData.atkWood,";")[1],",")[1]
        if atkWood == "0" then
            txtWoodAtk:setText("---")
        else
            txtWoodAtk:setText(atkWood)
        end
    end

    local txtWoodDef = self.monsterLayer:getChildByName("txtWoodDef")
    if monsterData == nil then
        txtWoodDef:setText("???")
    else
        local defWood = string.split(string.split(monsterData.defWood,";")[1],",")[1]
        if defWood == "0" then
            txtWoodDef:setText("---")
        else
            txtWoodDef:setText(defWood)
        end
    end

    local txtLightAtk = self.monsterLayer:getChildByName("txtLightAtk")
    if monsterData == nil then
        txtLightAtk:setText("???")
    else
        local atkLight = string.split(string.split(monsterData.atkLight,";")[1],",")[1]
        if atkLight == "0" then
            txtLightAtk:setText("---")
        else
            txtLightAtk:setText(atkLight)
        end
    end

    local txtLightDef = self.monsterLayer:getChildByName("txtLightDef")
    if monsterData == nil then
        txtLightDef:setText("???")
    else
        local defLight = string.split(string.split(monsterData.defLight,";")[1],",")[1]
        if defLight == "0" then
            txtLightDef:setText("---")
        else
            txtLightDef:setText(defLight)
        end
    end

    local txtDarkAtk = self.monsterLayer:getChildByName("txtDarkAtk")
    if monsterData == nil then
        txtDarkAtk:setText("???")
    else
        local atkDark = string.split(string.split(monsterData.atkDark,";")[1],",")[1]
        if atkDark == "0" then
            txtDarkAtk:setText("---")
        else
            txtDarkAtk:setText(atkDark)
        end
    end

    local txtDarkDef = self.monsterLayer:getChildByName("txtDarkDef")
    if monsterData == nil then
        txtDarkDef:setText("???")
    else
        local defDark = string.split(string.split(monsterData.defDark,";")[1],",")[1]
        if defDark == "0" then
            txtDarkDef:setText("---")
        else
            txtDarkDef:setText(defDark)
        end
    end

    local weaknessName = self.weaknessTitle
    -- local weaknessBg = self.weakImageBg
    local weaknessImage = self.weakImage
    local showFlag = true
    if monsterData ~= nil then
        local weakSpriteName = ToolsUtil:getWeakSpriteName(monsterData.weaknessType)
        if(weakSpriteName and weakSpriteName ~= "") then 
            weaknessImage:setSpriteName(weakSpriteName)
        else 
            showFlag = false 
        end
    else 
        showFlag = false 
    end
    self.weakImageBg:setVisible(showFlag)

    local buffArr = {}  --{31002008, 31002020, 31002025}
    if(guildBossData) then 
        buffArr = guildBossData:getBuffIDS()
    end 
    -- 处理BUFF的刷新
    self.buffLayout:removeAllChildren(true)
    local buffDataArr = {}
    local index = 1
    for k,v in ipairs(buffArr) do 
        local buffData = SkillDataManager:createBufferData(v)
        if(buffData) then 
            if buffData:getICON() then 
                local iconImage = UI.Image:create()
                iconImage:init(buffData:getICON())
                iconImage:centerUp((index - 1) * 33)
                self.buffLayout:addChild(iconImage)
                index = index + 1
            end 
            table.insert(buffDataArr, buffData)
        end
    end
    self.buffLayout:setSize(self.buffLayout:getContentSize().width, (index - 1)* 33)
    self.buffDataArr = buffDataArr
end


function GuildSelectFloorView:showBufInfo(bufferDataArr, nodePosition)
    local infoNode = self:getChildByName("BufInfo")
    if infoNode then
        infoNode:removeFromParent()
    end
    if(bufferDataArr == nil or #bufferDataArr == 0) then 
        return
    end

    info = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_chat.png")
    info:setCapInsets(CCRectMake(7,7,1,1))
    info:setName("BufInfo")
    self:addChild(info, 200)
    
    local height = 5
    local panelList = {}
    for k, buffData in ipairs(bufferDataArr) do
        if buffData and buffData:getICON() then
            local panel = self:createOneBuf(buffData)
            height = height + panel:getContentSize().height + 5
            table.insert(panelList, panel)
        end
    end
    info:setContentSize(300, height)
    local beginHeight = 5
    for k, v in ipairs(panelList) do
        v:centerUp(beginHeight)
        info:addChild(v)
        beginHeight = beginHeight + v:getContentSize().height
    end
    
    if nodePosition.x < COM_WIDTH / 2 then
        info:setPosition(nodePosition.x + info:getContentSize().width / 2 + 30, nodePosition.y)
    else
        info:setPosition(nodePosition.x - info:getContentSize().width / 2 - 50, nodePosition.y)
    end
end

function GuildSelectFloorView:hideBufInfo()
    local infoNode = self:getChildByName("BufInfo")
    if infoNode then
        infoNode:removeFromParent()
    end
end

function GuildSelectFloorView:createOneBuf(buffData)
    local panel = UI.Layout:create()
    panel:init()
    local icon = UI.Image:create()
    icon:init(buffData.iconID)
    icon:centerLeft(10)

    local desc = UI.Text:create()
    desc:init(buffData.description, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    desc:centerLeft(50)
    desc:setWidth(220)
    
    local height = desc:getContentSize().height + 10
    height = height < 40 and 40 or height
    panel:setSize(280, height)
    panel:addChild(icon)
    panel:addChild(desc)
    desc:autoAdapt()
    return panel
end


function GuildSelectFloorView:bindModel()
    mvc.guildModel:bind("fightNum", self, self.refreshChallenge)
    mvc.guildModel:bind("buffActTime", self, self.refreshBuyBuff)
    mvc.guildModel:bind("hardLv", self, self.refreshLevel)
    mvc.guildModel:bind("isPersonalBuffAct", self, self.refreshBuyBuff)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshBuyBuff)
end


function GuildSelectFloorView:unbindModel()
    mvc.guildModel:unbind("fightNum", self)
    mvc.guildModel:unbind("buffActTime", self)
    mvc.guildModel:unbind("hardLv", self)
    mvc.guildModel:unbind("isPersonalBuffAct", self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshBuyBuff)
end

function GuildSelectFloorView:onChallengeClick()
    local bossIndex = self.choiceIndex
    if mvc.worldBossModel:checkCanEnterOther() then
        self:_handleChallenge(bossIndex)
    else
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1212663,
            function()
                Net.NetActivitySystem:requestWorldbossQuitRoom()
                self:_handleChallenge(bossIndex)
            end
        )
    end
end

function GuildSelectFloorView:_handleChallenge(bossIndex)
    -- if(mvc.expeditionModel:getExpeditionStatus()) then
    --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
    --         Net.NetNPCSystem:reqStopExpedition()
    --         mvc.send(mvc.events.Guild_SelectFloor_Challenge, bossIndex)
    --     end, function()

    --     end)
    -- else 
        mvc.send(mvc.events.Guild_SelectFloor_Challenge, bossIndex)
    -- end
end

function GuildSelectFloorView:onBuyBuffClick(panel, isPersonal)
        local buffName = ""
        local buffTitle = panel:getChildByName("Title")
        if(buffTitle) then 
            buffName = buffTitle:getText()
        end
        local diamond = panel:getChildByName("BuffBtn"):getChildByName("DiamondNum")
        local str = string.format(LanguageManager:getInstance():getLocalString(1112345), "\""..buffName.."\"")
        local diamond = diamond:getText()
        if tonumber(diamond) > GameDataManager:getInstance():getDiamond() then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
        require "app.ui.tips.shop.DiamondBuyTips"
        local tips = UI.DiamondBuyTips:create(str, diamond)
        tips:init()
        tips:center()
        tips:callfunName(function()
            panel:getChildByName("BuffBtn"):disable()
            if isPersonal then
                mvc.send(mvc.events.Guild_SelectFloor_Buy_Personal_Buff)
            else
                mvc.send(mvc.events.Guild_SelectFloor_Buy_Buff)
            end
        end,function()

        end)
        UI.TipsLayer:addTips(tips)
end

function GuildSelectFloorView:onDisableBuffClick(panel, isPersonal)
    if not isPersonal then
        local buyBuff = mvc.guildModel:getBuyBuff()
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()

        if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member and not buyBuff then
            UI.ScrollBar:createByTextID(1170046)
        end
    end
end

function GuildSelectFloorView:refreshLevel()
    self:updateStar(self.starLayout, mvc.guildModel:getHardLv())
end

function GuildSelectFloorView:refreshBuyBuff()
    local buyBuff = mvc.guildModel:getBuyBuff()
    local hardLv = mvc.guildModel:getHardLv()
    -- print("GuildSelectFloorView:refreshBuyBuff", hardLv)
    local guildCfg = ConfigManager:getGuildBossCfgByID(hardLv)
    local buyDiamondNum = 200
    if(guildCfg) then 
        buyDiamondNum = guildCfg.buybuff
    end

    local isBuy, price = mvc.guildModel:getIsPersonalBuffAct()
    local bufDataList = {{isBuy = isBuy, price = price, notGetRes = "ui_guild_copy_self_0.png", getRes = "effect_ui_general_guild_fuben_a", isPersonal = true}, 
        {isBuy = buyBuff, price = buyDiamondNum, notGetRes = "ui_guild_copy_ofa_0.png", getRes = "effect_ui_general_guild_fuben_b", isPersonal = false}}
    for k, data in ipairs(bufDataList) do
        local panel = self.bufPanel[k]
        if panel then
            local button = panel:getChildByName("BuffBtn")
            button:getChildByName("DiamondNum"):setFontColor(UI.FONT_COLOR_41_41_45)
            if(data.isBuy)then
                if data.isPersonal then
                    button:setText(LanguageManager:getInstance():getLocalString(1112259))
                else
                    button:setText(LanguageManager:getInstance():getLocalString(1111623))
                end
                button:disable()
                button:setFontColor(UI.FONT_COLOR_50_50_44)
                button:getChildByName("DiamondIcon"):setVisible(false)
                button:getChildByName("DiamondNum"):setVisible(false)
                panel:removeChildByName("BG")

                local bg = UI.Animation:create()
                bg:init(data.getRes..".json", data.getRes..".atlas", 1);
                bg:centerUp(198)
                panel:addChild(bg)
                bg:setAnimation("idle", true)
                bg:setName("BG")
            else 
                local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
                if (masterTitle ~= PublicDefine.GuildTitle.GuildTitle_Member) or data.isPersonal then
                    button:setText("")
                    button:enable()
                    local diamondIcon = button:getChildByName("DiamondIcon")
                    local diamondNum = button:getChildByName("DiamondNum")
                    diamondIcon:setVisible(true)
                    diamondNum:setVisible(true)
                    diamondNum:setText(tostring(data.price))
                    if data.price >  GameDataManager:getInstance():getDiamond() then
                        diamondNum:setFontColor(UI.FONT_COLOR_RED)
                    end
                    local startX = (button:getContentSize().width - 8 - diamondIcon:getContentSize().width - diamondIcon:getContentSize().width) /2
                    diamondIcon:centerLeft(startX)
                    diamondNum:centerLeft(startX + diamondIcon:getContentSize().width + 5)
                else
                    button:disable()
                    button:getChildByName("DiamondIcon"):setVisible(false)
                    button:getChildByName("DiamondIcon"):setVisible(false)
                    button:getChildByName("DiamondNum"):setVisible(true)
                    button:getChildByName("DiamondNum"):center()
                    button:getChildByName("DiamondNum"):setText(LanguageManager:getInstance():getLocalString(1112258))
                    button:setFontColor(UI.FONT_COLOR_GRAY)
                end
                panel:removeChildByName("BG")
                local bg = UI.Image:create()
                bg:init("ui_guild_copy_flag_0.png")
                bg:center()
                bg:setName("BG")
                panel:addChild(bg)

                local buffIcon = UI.Image:create()
                buffIcon:init(data.notGetRes)
                buffIcon:centerUp(47)
                bg:addChild(buffIcon)
            end
        end
    end

   
end

function GuildSelectFloorView:refreshChallenge()
    local maxNum = tonumber(ConfigManager:getGuildConfigForKey("guildBossDailyLimit"))
    local loseNum = maxNum - mvc.guildModel:getFightNum();

    local guildBossData = nil
    if(self.choiceIndex and self.bossDataArr) then 
        for k, v in ipairs(self.bossDataArr) do 
            if(v:getBossIndex() == self.choiceIndex) then 
                guildBossData = v
                break
            end
        end
    end

    -- self.oneCostIcon:setSpriteName("symbol_gaming_diamond.png")
    self.challengeDes:setText(string.format("%d/%d", loseNum, maxNum))
    if(loseNum == 0 or (guildBossData and not guildBossData:getIsChallenge())) then
        self.challengeBtn:disable()
        if(loseNum == 0) then 
            self.challengeDes:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else 
            self.challengeDes:setFontColor(UI.FONT_COLOR_170_170_170)
        end 
    else 
        self.challengeBtn:enable()
        self.challengeDes:setFontColor(UI.FONT_COLOR_170_170_170)
    end
end

function GuildSelectFloorView:addLogMes(logStrArr)
    if(logStrArr and not tolua.isnull(self.dialogLayer)) then
        self.dialogLayer:clearMessage()
        self.dialogLayer:clearAllChild()
        for k,oneStrLog in ipairs(logStrArr) do 
            local data = {}
            data.content = oneStrLog.str
            if(oneStrLog.type ==  GUILD_LOG_TYPE.GUILD_LOG_TYPE_FIGHT) then 
                data.fontColor = {r = 193,g = 193, b = 193} 
            elseif(oneStrLog.type ==  GUILD_LOG_TYPE.GUILD_LOG_TYPE_BOX) then 
                data.fontColor = {r = 244,g = 200, b = 96} 
            end
            -- print("GuildSelectFloorView:addLogMes", data, oneStrLog)
            self.dialogLayer:showMessage(data, true)
        end
    end
end

function GuildSelectFloorView:updateHpView()
    local monsterID = nil
    local guildBossData = nil
    if(self.choiceIndex and self.bossDataArr) then 
        for k, v in ipairs(self.bossDataArr) do 
            if(v:getBossIndex() == self.choiceIndex) then 
                monsterID = v:getBossID()
                guildBossData = v
                break
            end
        end
    end
    if(guildBossData == nil) then 
        return 
    end

    local guildBossPool = ConfigManager:getGuildBossPoolByID(guildBossData:getBossID())
    local monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(monsterID, PublicDefine.CAVE_MODE.MODE_GUILD_BOSS, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    if(guildBossPool == nil) then 
        return 
    end
    local multiHP = guildBossPool.multiHP
    local maxHp = monsterData:getHp()
    local curHp = maxHp - guildBossData:getLoseHP()
    if(curHp < 0) then 
        curHp = 0
    end
    print("guildBossData:getLoseHP()=", maxHp, curHp, guildBossData:getLoseHP())

    local mulHpArr,index, indexHp = ToolsUtil:calculationMulHp(curHp, maxHp, multiHP)
    print("progressBg, progress, reward  1=", index, indexHp, guildBossData:getBossID())
    local progressBg, progress, reward = self:_getHPSpriteName(index, mulHpArr)
    -- print("progressBg, progress, reward=", progressBg, progress, reward)
    self.boxImage:setSpriteName(reward)
    self.progressTimer:setSpriteName(progressBg, progress, progress)
    self.progressText:setText(string.format("%d/%d", indexHp, mulHpArr[index]))

    if(curHp == 0) then
        self.hpLayerText:setText("X".."0")
    else
        self.hpLayerText:setText("X "..(#mulHpArr-index + 1))
    end
    
    local oldPercent = self.progressTimer:getPercent()
    local nowPercent = indexHp/ mulHpArr[index]
    self.progressTimer:setBarChange(oldPercent, nowPercent, 0.01)
    self.progressTimer:setBarChangeAction(oldPercent, nowPercent, 0.01)

    if indexHp == 0 then 
        self.rewardDes:setText("X"..(#mulHpArr))
    else 
        self.rewardDes:setText("X"..(index- 1)) 
    end
end

function GuildSelectFloorView:_getHPSpriteName(index, mulHpArr)
    local maxIndex = 4
    local progressBg = "ui_guild_copy_progressbar_0.png"
    local progress = "ui_guild_copy_progressbar_1.png"
    local reward = "ui_guild_giftbag_icon_6.png"
    local mod = math.fmod(index, maxIndex + 1)
    if(mod == 0) then 
        mod = 1
    end
    -- print("GuildSelectFloorView:_getHPSpriteName", mod, index, #mulHpArr)
    progress = string.format("ui_guild_copy_progressbar_%d.png", mod)
    reward =  string.format("ui_guild_giftbag_icon_%d.png", 5+mod)
    if(index == #mulHpArr) then 
        progressBg = "ui_guild_copy_progressbar_0.png"
    else
        if(mod == maxIndex) then 
            progressBg = string.format("ui_guild_copy_progressbar_%d.png", 1)
        else 
            progressBg = string.format("ui_guild_copy_progressbar_%d.png", mod + 1)
        end
    end

    return progressBg, progress, reward
end

function GuildSelectFloorView:_getSmallHPSpriteName(index, mulHpArr)
    local maxIndex = 4
    local progressBg = "ui_guild_copy_blood_0.png"
    local progress = "ui_guild_copy_blood_1.png"
    local mod = math.fmod(index, maxIndex + 1)
    if(mod == 0) then 
        mod = 1
    end
    -- print("GuildSelectFloorView:_getHPSpriteName", mod, index, #mulHpArr)
    progress = string.format("ui_guild_copy_blood_%d.png", mod)
    if(index == #mulHpArr) then 
        progressBg = "ui_guild_copy_blood_0.png"
    else
        if(mod == maxIndex) then 
            progressBg = string.format("ui_guild_copy_blood_%d.png", 1)
        else 
            progressBg = string.format("ui_guild_copy_blood_%d.png", mod + 1)
        end
    end

    return progressBg, progress
end

function GuildSelectFloorView:controllerDataUpdate()
    -- print("GuildSelectFloorView:controllerDataUpdate")
    self.bossDataArr = mvc.guildModel:getBossDataArr()
    self:refreshMonsterInfo()
    self:refreshBuyBuff()
    self:refreshChallenge()
    self:refreshHeadIcon()
end

function GuildSelectFloorView:controllerChallengeResult(data)
    -- print("GuildSelectFloorView:controllerChallengeResult", data)
    self:refreshChallenge()
    -- if(data.err ~= ProtobufUtil:enum_id("GuildBossErr", "GuildBossErr_OK")) then 
    --     self:refreshMonsterInfo()
    -- end
end

function GuildSelectFloorView:controllerBuyBuffResult(data)
    self:refreshBuyBuff()

    --showtips
    if data.err == "GuildBossErr_OK" then
        local hardLv = mvc.guildModel:getHardLv()
        local guildCfg = ConfigManager:getGuildBossCfgByID(hardLv)
        if(guildCfg) then 
            local itemId = guildCfg.buybuffreward[1]
            local itemNum = guildCfg.buybuffreward[2]

            local rewardGoodsArr = {}
            local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
            if (goodsData) then
                goodsData:setNum(itemNum)
                goodsData:setIsGolden(true)
                table.insert(rewardGoodsArr, goodsData)
            end
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, nil, UI.TEXT_1213310, nil)  
        end
    end
end

function GuildSelectFloorView:controllerBuyPersonBuffResult(data)
    -- print("GuildSelectFloorView:controllerBuyBuffResult", data)
    self:refreshBuyBuff()
end

function GuildSelectFloorView:controllerAddLog(data)
    -- print("GuildSelectFloorView:controllerAddLog", data)
    -- self:addLogMes(data)
end

return GuildSelectFloorView
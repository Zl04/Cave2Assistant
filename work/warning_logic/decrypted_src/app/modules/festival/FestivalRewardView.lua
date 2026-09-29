------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/08/05
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FestivalRewardView = class("FestivalRewardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_world_boss.plist"

}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
local layoutUtil
function FestivalRewardView:ctor(param)
    FestivalRewardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    param = param or {}
    self.rank = param.rank
    self.oldHighRank = param.oldHighRank
    self.useTime = param.useTime
    self.award = param.award
    self.heroInfos = param.infos or {}
    
    self.remind = 30

    self:bindModel()
    layoutUtil = UIUtil:createAutoUILayout("FestivalRewardView","app.modules.festival.FestivalPosConfig", false)
end

function FestivalRewardView:dtor()
    FestivalRewardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.festival.FestivalRewardView")
end


function FestivalRewardView:createNameAndTime(name, time)
    local com = UI.Component:create()
    com:init()
    com:setSize(180, 70)
    com:center()

    local title = UI.Text:create()
    title:init(tostring(name), UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
    title:centerBottom(25)
    com:addChild(title)

    local timeLayout = self:createOneTime(time)
    timeLayout:centerBottom(5)
    com:addChild(timeLayout)
    return com
end

function FestivalRewardView:createOneTime(time)
    local layout = UI.Layout:create()
    layout:init()

    local title = UI.Text:create()
    title:init(UI.TEXT_1213002..":", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE)
    title:centerBottom(0)
    layout:addChild(title)

    
    local timeText = UI.Text:create()
    timeText:init(ToolsUtil:getTime(time), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_209_171_68)
    timeText:centerBottom(0)
    layout:addChild(timeText)
    layout:setSize(title:getContentSize().width + timeText:getContentSize().width, 0)
    local startX = 0
    title:centerLeft(startX)
    timeText:centerLeft(startX + title:getContentSize().width)

    return layout
end

function FestivalRewardView:onInitView()
    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,255*0.8))
    blackBg:setContentSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(blackBg)

    self.content = UI.Component:create()
    self.content:init()
    self.content:setSize(830, 580)
    self.content:center()
    self:addChild(self.content)

    local bgAnimation = UI.Animation:create()
    bgAnimation:init(
        "effect_ui_town_maze_settlement_win_totem.json",
        "effect_ui_town_maze_settlement_win_totem.atlas",
        1
    )

    bgAnimation:setAnimation("begin", false)
    bgAnimation:addAnimation("idle", true)
    -- addChildAuto(layoutUtil, self.content, bgAnimation, "bgAnimation", "center")
    self.content:addChild(bgAnimation)
    bgAnimation:center()
    bgAnimation:setSize(100, 50)


    local title = UI.Text:create()
    title:init(UI.TEXT_1213000, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_249_226_151)
    title:setOutline(UI.FONT_COLOR_BLACK)
    title:center()
    bgAnimation:addComponent("title", title)

    local title =
        UIUtil:createAdaptTextComponent(UI.TEXT_1213001, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_209_171_68, 175)
    bgAnimation:addComponent("hurt", title)
    title:center()
    self:createBottomContent()
    self:createHeadContent()
end

function FestivalRewardView:createBottomContent()
    local img = UI.Image:create()
    img:init("ui_boss_me_paper.png")
    addChildAuto(layoutUtil, self.content, img, "ui_boss_me_paper")

    local killerNameT = UI.Text:create()
    killerNameT:init(
        UI.TEXT_1212631 .. tostring(self.killerName),
        UI.SYS_FONT,
        UI.FONT_SIZE_24PX,
        UI.FONT_COLOR_209_171_68
    )
    addChildAuto(layoutUtil, self.content, killerNameT, "killerName", "center")
    local heroData = RoleDataManager:getMaster()

    local myNameT = UI.Text:create()
    myNameT:init(heroData:getNickName(), UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
    addChildAuto(layoutUtil, self.content, myNameT, "myName", "leftBottom")
    local myRankInfo = mvc.worldBossModel:getMyHurtRank()

    local myScoreT = self:createOneTime(self.useTime)
    myScoreT:centerLeft(76)
    img:addChild(myScoreT)

    local myRankT = UI.Text:create()
    myRankT:init(self.rank.."", UI.SYS_FONT, UI.FONT_SIZE_24PX, UI.FONT_COLOR_BLACK)
    -- addChildAuto(layoutUtil, self.content, myRankT, "myRank", "center")
    myRankT:centerLeft(33-myRankT:getContentSize().width/2)
    img:addChild(myRankT)

    local cdText = UI.Text:create()
    cdText:init("cd", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_208_50_60)
    cdText:centerBottom(67)
    self.content:addChild(cdText)

    local rewardText = UI.Text:create()
    rewardText:init(UI.TEXT_1213004, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_208_50_60)
    rewardText:centerBottom(67)
    rewardText:setVisible(false)
    addChildAuto(layoutUtil, self.content, rewardText, "rewardText", "leftBottom")
    -- self.content:addChild(rewardText)

    local quitBtn = UI.Button:create()
    quitBtn:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_0.png")
    quitBtn:centerBottom(15)
    quitBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onQuit)
    quitBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    quitBtn:setText(UI.TEXT_1212634)
    self.content:addChild(quitBtn)

    local infoBtn = UI.Component:create()
    infoBtn:init()
    infoBtn:setSize(100, 100)
    infoBtn:setTouchEnable(true)
    infoBtn:centerLeft(261)
    infoBtn:addEventListener(UIEvent.COMPONENT_CLICK, self, self._clickBox)
    img:addChild(infoBtn, 10)
    self.infoBtn = infoBtn

    -- 宝箱按钮
    local boxAnimation = UI.Animation:create()
    boxAnimation:init(
        "effect_ui_town_maze_settlement_box.json",
        "effect_ui_town_maze_settlement_box.atlas",
        1
    )
    -- 根据状态来处理相关的表现
    if(self.rank == 1 ) then
        if(#self.award > 0) then 
            boxAnimation:setAnimation("idle3", true)
        else 
            boxAnimation:setAnimation("end3", true)
            infoBtn:setTouchEnable(false)
        end
    else
        if(self.oldHighRank == 1) then 
            boxAnimation:setAnimation("end3", true)
            infoBtn:setTouchEnable(false)
        else
            if(#self.award > 0) then 
                boxAnimation:setAnimation("idle1", true)
            else 
                boxAnimation:setAnimation("idle2", true)
                infoBtn:setTouchEnable(false)
            end
        end
    end
    boxAnimation:center()
    infoBtn:addChild(boxAnimation)
    self.boxAnimation = boxAnimation

    self.cdText = cdText
    self.remind = 30
    self:scheduleUpdateTime()
end

function FestivalRewardView:_clickBox()
    if(self.rank == 1 ) then
        self.boxAnimation:setAnimation("end3", true)
        self.infoBtn:setTouchEnable(false)
    else 
        self.boxAnimation:setAnimation("idle2", true)
        self.infoBtn:setTouchEnable(false)
    end

    -- self.award
    local itemData = {}
    for k, v in pairs(self.award) do
        local goodData = GoodsDataManager:createLocalGoodsData(v.templateID)
        if(goodData and v.num > 0) then
            goodData:setIsNew(false)
            goodData:setNum(v.num)
            table.insert(itemData, goodData)
        end
    end
    local titleStr = nil 
    Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, itemData, nil, titleStr, nil, nil, true)
end

function FestivalRewardView:onQuit()
    -- mvc.send(mvc.events.WorldBoss_Win_Quit)
    -- mvc.closePanel("Festival", "FestivalReward")
    mvc.send(mvc.events.FestivalReward_Quit)
end

function FestivalRewardView:scheduleUpdateTime()
    if tolua.isnull(self) or tolua.isnull(self.cdText) then
        return
    end

    if self.remind > 0 then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleUpdateTime, 1)
        local showText = AvalonUtil:_getFullFormatTime(self.remind, true, true, false)
        self.cdText:setText(string.format(UI.TEXT_1213003, showText))
        self.remind = self.remind - 1
    else
        self.remind = self.remind - 1
        self.cdText:setText("")
        self:onQuit()
    end
end

function FestivalRewardView:createHeadContent()
    local headAnimation = UI.Animation:create()
    headAnimation:init(
        "effect_ui_town_maze_settlement_win_names.json",
        "effect_ui_town_maze_settlement_win_names.atlas",
        1
    )
    headAnimation:setAnimation("begin", false)
    addChildAuto(layoutUtil, self.content, headAnimation, "headAnimation", "center")
    headAnimation:setSize(100, 50)
    local tab = {
        {"ui_boss_box_1_que.png", 0.9},
        {"ui_boss_box_2_que.png", 0.8},
        {"ui_boss_box_2_que.png", 0.8},
    }

    for i = 1, #self.heroInfos do
        -- local heroData = GameDataManager:getInstance():getMaster()
        local heroData = self.heroInfos[i].heroData
        Avalon.WidgetUtil:getHead(
            self,
            heroData.heroData,
            heroData.wearEquipmentArr,
            self,
            handler(
                self,
                function(self, pic)
                    if self and not tolua.isnull(headAnimation) then
                        headAnimation:addComponent("box" .. i, pic, true)
                    end
                end
            ),
            true,
            tab[i][1],
            tab[i][2]
        )

        local com = self:createNameAndTime(heroData.heroData.nickName, self.heroInfos[i].damage)
        headAnimation:addComponent("name" .. i, com, true)
    end

    for i = #self.heroInfos + 1, 3 do
        local title = UI.Text:create()
        title:init(UI.TEXT_1212636, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
        title:centerBottom(25)
        headAnimation:addComponent("box" .. i, title, true)
    end
end


function FestivalRewardView:bindModel()

end


function FestivalRewardView:unbindModel()

end





return FestivalRewardView













------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/22
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local WorldBossWinResultView = class("WorldBossWinResultView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_world_boss.plist"
    
}

local winSize = cc.Director:getInstance():getWinSize()
require("utils.UIUtil")

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
local layoutUtil
function WorldBossWinResultView:ctor(param)
    WorldBossWinResultView.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    param = param or {}
    self.killerName = param.finalKiller
    self.heroInfos = param.infos or {}
    self.isSucc = param.iskilledBoss 
    self:bindModel()
    layoutUtil =
        UIUtil:createAutoUILayout("WorldBossWinResultView", "app.modules.worldboss.WorldBossPosConfig", __EDIT_)
end

function WorldBossWinResultView:dtor()
    WorldBossWinResultView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.worldboss.WorldBossWinResultView")
end

function WorldBossWinResultView:createNameAndScore(name, score)
    local com = UI.Component:create()
    com:init()
    com:setSize(180, 70)
    com:center()
    -- com:enableDebugDraw()
    -- local img = UI.Image:create()
    -- img:init("ui_boss_name_win.png")
    -- img:centerBottom(22)
    -- com:addChild(img)

    local title = UI.Text:create()
    title:init(tostring(name), UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
    title:centerBottom(25)
    com:addChild(title)

    local title = UI.Text:create()
    title:init(tostring(score), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_209_171_68)
    title:centerBottom(0)
    com:addChild(title)
    return com
end

function WorldBossWinResultView:onInitView()
    -- local spr = cc.Sprite:create("xxxx.png")
    -- spr:setOpacity(150)
    -- spr:setPosition(cc.p(COM_WIDTH / 2, COM_HEIGHT / 2))
    -- self:addChild(spr)
    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,255*0.8))
    blackBg:setContentSize(COM_WIDTH, COM_HEIGHT)
    -- blackBg:setPosition(-COM_WIDTH / 2, -COM_HEIGHT / 2)
    self:addChild(blackBg)

    self.content = UI.Component:create()
    self.content:init()
    self.content:setSize(830, 580)
    self.content:center()
    self:addChild(self.content)

    local bgAnimation = UI.Animation:create()
    if self.isSucc then
        bgAnimation:init(
            "effect_ui_town_worldboss_settlement_win_sword.json",
            "effect_ui_town_worldboss_settlement_win_sword.atlas",
            1
        )
    else
        bgAnimation:init(
            "effect_ui_town_worldboss_settlement_lose_stone.json",
            "effect_ui_town_worldboss_settlement_lose_stone.atlas",
            1
        )
    end
    bgAnimation:setAnimation("begin", false)
    bgAnimation:addAnimation("idle", true)
    addChildAuto(layoutUtil, self.content, bgAnimation, "bgAnimation", "center")
    bgAnimation:setSize(100, 50)
    -- bgAnimation:setTimeScale(0.2)

    local title = UI.Text:create()
    if self.isSucc then
        title:init(UI.TEXT_1212629, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_249_226_151)
    else
        title:init(UIUtil:lang(1112341), UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_249_226_151)
    end
    title:setOutline(UI.FONT_COLOR_BLACK)
    title:center()
    -- addChildAuto(layoutUtil, self.content, title, "title", "center")
    bgAnimation:addComponent("title", title)

    -- local img = UI.Image:create()
    -- img:init("ui_boss_line_win.png")
    -- addChildAuto(layoutUtil, self.content, img, "lineW")
    local title =
        UIUtil:createAdaptTextComponent(UI.TEXT_1212630, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_209_171_68, 175)
    bgAnimation:addComponent("hurt", title)
    title:center()
    self:createBottomContent()
    self:createHeadContent()
end

function WorldBossWinResultView:createBottomContent()
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

    local myScoreT = UI.Text:create()
    myScoreT:init(
        string.format(UI.TEXT_1212633, myRankInfo.damage),
        UI.SYS_FONT,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_209_171_68
    )
    addChildAuto(layoutUtil, self.content, myScoreT, "myScore", "leftBottom")

    local myRankT = UI.Text:create()
    myRankT:init(tostring(myRankInfo.rank), UI.SYS_FONT, UI.FONT_SIZE_24PX, UI.FONT_COLOR_BLACK)
    addChildAuto(layoutUtil, self.content, myRankT, "myRank", "center")

    local cdText = UI.Text:create()
    cdText:init("cd", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_208_50_60)
    addChildAuto(layoutUtil, self.content, cdText, "cdText", "center")

    local quitBtn = UI.Button:create()
    quitBtn:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_0.png")
    addChildAuto(layoutUtil, self.content, quitBtn, "quitBtn", "center")
    quitBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onQuit)
    quitBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    quitBtn:setText(UI.TEXT_1212634)

    self.cdText = cdText
    self.remind = 30
    self:scheduleUpdateTime()
end

function WorldBossWinResultView:onQuit()
    mvc.send(mvc.events.WorldBoss_Win_Quit)
end

function WorldBossWinResultView:scheduleUpdateTime()
    if tolua.isnull(self) or tolua.isnull(self.cdText) then
        return
    end

    if self.remind > 0 then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleUpdateTime, 1)
        local showText = AvalonUtil:_getFullFormatTime(self.remind, true, true, false)
        self.cdText:setText(string.format(UI.TEXT_1212635, showText))
    else
        self.cdText:setText("")
        self:onQuit()
        return
    end
    self.remind = self.remind - 1
end

function WorldBossWinResultView:createHeadContent()
    local headAnimation = UI.Animation:create()
    headAnimation:init(
        "effect_ui_town_worldboss_settlement_win_names.json",
        "effect_ui_town_worldboss_settlement_win_names.atlas",
        1
    )
    headAnimation:setAnimation("begin", false)
    addChildAuto(layoutUtil, self.content, headAnimation, "headAnimation", "center")
    headAnimation:setSize(100, 50)
    local tab = {
        {"ui_boss_box_1_que.png", 0.9},
        {"ui_boss_box_2_que.png", 0.8},
        {"ui_boss_box_2_que.png", 0.8},
        {"ui_boss_box_common_que.png", 0.7},
        {"ui_boss_box_common_que.png", 0.7}
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

        local com = self:createNameAndScore(heroData.heroData.nickName, self.heroInfos[i].damage)
        headAnimation:addComponent("name" .. i, com, true)
    end

    for i = #self.heroInfos + 1, 5 do
        local title = UI.Text:create()
        title:init(UI.TEXT_1212636, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_235_216)
        title:centerBottom(25)
        headAnimation:addComponent("box" .. i, title, true)
    end
end

function WorldBossWinResultView:bindModel()
end

function WorldBossWinResultView:unbindModel()
end

return WorldBossWinResultView

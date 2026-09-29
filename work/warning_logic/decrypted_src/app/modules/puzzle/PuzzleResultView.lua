------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/08/03
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SceneManager = require('app.game.SceneManager')
local winSize = cc.Director:getInstance():getWinSize()
local ProtobufUtil = require("utils.ProtobufUtil")
local PuzzleResultView = class("PuzzleResultView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_festival_hitrat.plist",
    "ui_town_arena.plist",
}

local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function PuzzleResultView:ctor(data)
    PuzzleResultView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.data = data

    -- 关闭倒计时
    self.closeTime = 30

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:mainSwitchOff()

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.updateTime), 1, false)
end

function PuzzleResultView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.puzzle", "Puzzle", false)
    PuzzleResultView.super.init(self, ... )
end

function PuzzleResultView:dtor()
    PuzzleResultView.super.dtor(self)
    self:unbindModel()

    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end

    reload_script_file_mvc("app.modules.puzzle.PuzzleResultView")
end


function PuzzleResultView:onInitView()
    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,240))
    colorLayer:setPosition(0, 0)
    colorLayer:setContentSize(winSize.width, winSize.height)
    self:addChild(colorLayer, -1)

    local animation = UI.Animation:create()
    animation:init("effect_ui_town_puzzle_settlement_background.json", "effect_ui_town_puzzle_settlement_background.atlas", 1);
    animation:center()
    animation:setAnimation("begin", false)
    self:addChild(animation)
    animation:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(sender, event)
        if not tolua.isnull(animation) then
            if (event.animation == "begin") then
                animation:addAnimation("idle", true)
            end
        end
    end)

    local selfRoleLayout = UI.Layout:create()
    selfRoleLayout:init()
    selfRoleLayout:setSize(300, 300)
    selfRoleLayout:center(0, 0)
    -- selfRoleLayout:enableDebugDraw()
    self:addChild(selfRoleLayout)
    self.selfRoleLayout = selfRoleLayout

    local title = UI.Text:create()
    title:init(UI.TEXT_1213447, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, {r = 245, g = 223, b = 114})
    title:center()
    title:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    animation:addComponent("tiao", title, true)

    self:createRoleMode()

    self:createScoreLayout()

    local awardLayout = UI.Layout:create()
    awardLayout:init()
    awardLayout:setSize(520, 120)
    awardLayout:center(-250, 222)
    -- awardLayout:enableDebugDraw()
    self:addChild(awardLayout)
    self.awardLayout = awardLayout

    self:createAwards()

    local BtnLayout = UI.Layout:create()
    BtnLayout:init()
    BtnLayout:setSize(220, 120)
    BtnLayout:center(250, 222)
    -- BtnLayout:enableDebugDraw()
    self:addChild(BtnLayout)

    local leaveBtn = UI.Button:create()
    leaveBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    leaveBtn:setText(UI.TEXT_1213006)
    leaveBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    leaveBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        SceneManager:getInstance():leaveWaiting()
    end)
    leaveBtn:center(0, 0)
    BtnLayout:addChild(leaveBtn)

    local btnTips = UI.Text:create()
    btnTips:init(string.format(UI.TEXT_1212635, 30), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_198_48_58)
    btnTips:centerUp(10)
    BtnLayout:addChild(btnTips)
    self.btnTips = btnTips
end


function PuzzleResultView:createRoleMode()
    local effBG1  = UI.Image:create()
    effBG1:init("ui_festival_hitrat_win_bg.png")
    effBG1:leftUp(33, 4)
    self.selfRoleLayout:addChild(effBG1)

    -- 人物
    local leftRoleAnimation = UI.RoleAnimation:create(false)
    leftRoleAnimation:init(RoleDataManager:getMaster())
    leftRoleAnimation:setScaleX(-0.85 * leftRoleAnimation:getScaleX())
    leftRoleAnimation:setScaleY(0.85 * leftRoleAnimation:getScaleY())
    leftRoleAnimation:centerUp(100)
    leftRoleAnimation:showBlink(true)
    performWithDelay(self, function()
        leftRoleAnimation:showHelmet(true)
        leftRoleAnimation:getRoleRender():getHeroAnimation():setAnimation(0, "jiandun_shenshengguanghui", true)
    end, 0)

    self.selfRoleLayout:addChild(leftRoleAnimation)

    -- 胜利特效
    local leftAnimation = UI.Animation:create()
    leftAnimation:init("effect_ui_town_puzzle_settlement.json", "effect_ui_town_puzzle_settlement.atlas", 1)
    leftAnimation:leftUp(154, 146)
    leftAnimation:setAnimation("begin", false)
    leftAnimation:addAnimation("idle", true)
    self.selfRoleLayout:addChild(leftAnimation)
end

function PuzzleResultView:createScoreLayout()
    local selfRoleInfoImg = UI.Image:create()
    selfRoleInfoImg:init("ui_arena_end_flag_blue.png")
    selfRoleInfoImg:centerBottom(-20)
    self.selfRoleLayout:addChild(selfRoleInfoImg)

    local selfName = UI.Text:create()
    selfName:init(RoleDataManager:getMaster():getNickName(), UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_214_251_255)
    selfName:setTextCenter()
    selfName:center(0, -22)
    selfRoleInfoImg:addChild(selfName)

    local curScoreStr = UI.TEXT_1324402..tostring(mvc.puzzleModel:getCurScoreNum())
    local selfScoreNum = UI.Text:create()
    selfScoreNum:init(curScoreStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    selfScoreNum:leftBottom(34, 32)
    selfRoleInfoImg:addChild(selfScoreNum)

    local recordData = MasterDataManager:getFunnyRecord()
    local highScore = 0
    if recordData and recordData[PublicDefine.FunnyRecordType.FunnyRecordType_Puzzle] then
        highScore = recordData[PublicDefine.FunnyRecordType.FunnyRecordType_Puzzle]
    end
    highScore = highScore > mvc.puzzleModel:getCurScoreNum() and highScore or tostring(mvc.puzzleModel:getCurScoreNum())

    local highScoreStr = UI.TEXT_1324403..highScore
    local selfRankNum = UI.Text:create()
    selfRankNum:init(highScoreStr, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    selfRankNum:leftBottom(34, 12)
    selfRoleInfoImg:addChild(selfRankNum)
end


function PuzzleResultView:createAwards()

    -- 每日最大奖励次数
    local rewardMaxTime = ConfigManager:getFestivalDataForID(PublicDefine.CONST_DEFINITION.PUZZLE_MAP_ID).rewardLimit
    local dataArr = MasterDataManager:getActivityDataArr()
    local festivalData = nil
    for k, v in pairs(dataArr) do
        if v:getType() == PublicDefine.ActivityType.ActivityType_Festival then
            festivalData = v
            break
        end
    end

    if not festivalData then
        printInfo("festivalData is nil")
        return
    end

    -- 判断是否已经领完奖励
    local isAllGot = false
    if rewardMaxTime - festivalData:getFestivalData().puzzleNum <= 0 then
        isAllGot = true
    end

    -- 更新次数
    if festivalData:getFestivalData().puzzleNum < rewardMaxTime then
        festivalData:getFestivalData().puzzleNum = festivalData:getFestivalData().puzzleNum + 1
    end
    local awardsGotNum = festivalData:getFestivalData().puzzleNum

    local desc = UI.Text:create()
    if isAllGot then
        desc:init(UI.TEXT_1213335, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_181_171_171)
        desc:rightBottom(300, 50)
    else
        desc:init(UI.TEXT_1213336, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_181_171_171)
        desc:rightBottom(300, 80)
    end
    self.awardLayout:addChild(desc)

    if not isAllGot then
        local playNumdesc = UI.Text:create()
        playNumdesc:init(string.format(UI.TEXT_1213338, rewardMaxTime - awardsGotNum, rewardMaxTime), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_181_171_171)
        playNumdesc:rightBottom(300, 30)
        self.awardLayout:addChild(playNumdesc)

        -- 奖励物品
        local offset = {230, 310, 390}
        for k, v in ipairs(self.data.goods) do
            local goodData = GoodsDataManager:createLocalGoodsData(tonumber(v.templateID))
            if goodData then
                goodData:setNum(tonumber(v.num))
                goodData:setIsNew(false)
                goodData.isHaveGet = false

                local rewardGrid = UI.GoodsGrid:create()
                rewardGrid:init(goodData)
                rewardGrid:leftUp(offset[k], 18)
                rewardGrid:hideNewIcon()
                rewardGrid:setTouchEnable(true)
                rewardGrid:setSwallowTouches(false)
                rewardGrid:setTouchClipNode(self.awardLayout)
                rewardGrid:showInfoArea(true, false)
                self.awardLayout:addChild(rewardGrid)
            end
        end
    end
end


function PuzzleResultView:updateTime()
    if self.closeTime and self.btnTips and not tolua.isnull(self.btnTips) then
        self.closeTime = self.closeTime - 1
        self.btnTips:setText(string.format(UI.TEXT_1213339, self.closeTime))

        if self.closeTime == 0 then
            SceneManager:getInstance():leaveWaiting()
            return
        end
    end
end


function PuzzleResultView:bindModel()

end


function PuzzleResultView:unbindModel()

end





return PuzzleResultView













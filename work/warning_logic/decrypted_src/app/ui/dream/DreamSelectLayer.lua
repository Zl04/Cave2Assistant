-- DreamSelectLayer.lua
-- Author:ydli
-- 2019年03月04日
-- Using:梦境选关界面
UI = UI or {}
local DreamSelectLayer = class("DreamSelectLayer", UI.CenterWin)
require "app.datas.AnswerDataManager"
UI.DreamSelectLayer = DreamSelectLayer
local DreamSelectCell = require"app.ui.dream.DreamSelectCell"
local scheduler = cc.Director:getInstance():getScheduler()
local winSize = cc.Director:getInstance():getWinSize()
local GameDataManager = require("app.game.GameDataManager")

DREAM_CELL_STATUS = {
    COMPLETED = 1, --已经完成
    SELECT = 2,    --正选中
    UNREACH = 3,   --还未达到
}

local size = cc.size(950, 520)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_dreamword.plist",
    "ui_general_big_number.plist",
    "ui_town_dream_btn.plist",
    "ui_town_dream_common.plist",
    "ui_town_dream_overstep.plist",
}
----表情界面
--构造函数(必备)
function DreamSelectLayer:ctor(spriteID)
    -- 打开重置成普通模式
    MasterDataManager:setDreamChallengeIsPhase(false)
    -- 梦境数据
    if not MasterDataManager:isHaveDreamData() then
        Net.NetRoleSystem:requestGetDreamInfo()
    end
    --窗口大小
    DreamSelectLayer.super.ctor(self, UIType.DREAM_SELECT, COM_RES_LIST, size.width, size.height)
    self.isPhase = MasterDataManager:getDreamData().dreamType == 1 and true or false
    self.spriteID = spriteID
    self.bossCell = {}
    self:registerListener()
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.refreshTime), 60, false)
end

--虚构函数,destroy时调用(必备)
function DreamSelectLayer:dtor()
    DreamSelectLayer.super.dtor(self)
    self.bossCell = {}
    self:unRegisterListener()
    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end

end

-- 初始化(必备)
function DreamSelectLayer:init()
    DreamSelectLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function DreamSelectLayer:onInitView()
    self:updateSelectLayer()
end

-- 模版函数：更新组建的视图(必备)
function DreamSelectLayer:onUpdateView()

end

function DreamSelectLayer:updateSelectLayer()
    local dreamData = MasterDataManager:getDreamData()
    -- print("dreamData : ", dreamData)
    if not self.bg then
        local bg = UI.Image:create()
        bg:init("ui_dreamword_bg_1.png")
        bg:center()
        self.bg = bg
        self:addChild(bg)
    end
    self.bg:setSpriteName("ui_dreamword_bg_1.png")

    local title = self.bg:getChildByName("title")
    if not title then
        title = UI.Text:create()
        title:init(UI.TEXT_1324300, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_255_153_255)
        title:centerUp(24)
        title:setName("title")
        self.bg:addChild(title)
    end

    local levelBg = self.bg:getChildByName("levelBg")
    if not levelBg then
        levelBg = UI.Image:create()
        levelBg:init("ui_dreamword_goods_bg1.png")
        levelBg:leftUp(0, 32)
        levelBg:setName("levelBg")
        self.bg:addChild(levelBg, 10000)
        self.levelBg = levelBg
    end

    local lv = self.bg:getChildByName("lv")
    if not lv then
        lv = UI.Image:create()
        lv:init("ui_home_banner_lv.png")
        lv:leftUp(58, 18)
        lv:setName("lv")
        levelBg:addChild(lv)
        lv:setScale(1.1)
    end

    local levelTitle = levelBg:getChildByName("levelTitle")
    if not levelTitle then
        levelTitle = UI.Text:create()
        levelTitle:init(UI.TEXT_1324301, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_204_153)
        levelTitle:leftUp(54, 40)
        levelTitle:setName("levelTitle")
        levelBg:addChild(levelTitle)
    end

    local time = self.bg:getChildByName("time")
    if not time then
        time = UI.Text:create()
        time:init(UI.TEXT_1212263, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
        time:leftUp(56, 3)
        time:setName("time")
        self.bg:addChild(time, 200)
        time:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
    end

    local remainRefreshTime = self.bg:getChildByName("remainRefreshTime")
    if not remainRefreshTime then
        remainRefreshTime = UI.Text:create()
        remainRefreshTime:init("00:00", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
        remainRefreshTime:leftUp(time:getLeft() + time:getContentSize().width + 5, 3)
        remainRefreshTime:setName("remainRefreshTime")
        self.bg:addChild(remainRefreshTime, 200)
        remainRefreshTime:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
        self.remainRefreshTime = remainRefreshTime
    end

    local stoneBg = self.bg:getChildByName("stoneBg")
    if not stoneBg then
        stoneBg = UI.Image:create()
        stoneBg:init("ui_dreamword_goods_bg2.png")
        stoneBg:rightUp(64, 22)
        stoneBg:setName("stoneBg")
        self.bg:addChild(stoneBg, 200)
    end

    --梦境排行榜
    local rankBtn = self.bg:getChildByName("rankBtn")
    if not rankBtn then
        rankBtn = UI.Button:create()
        rankBtn:init("ui_dreamword_ranking_btn_0.png", "ui_dreamword_ranking_btn_1.png", "ui_dreamword_ranking_btn_2.png")
        rankBtn:rightBottom(10, 175)
        rankBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
            if SHEILD_DREAM_FLAG then
                return
            end
            self:checkSpriteId()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_DREAM_RANK, self.spriteID, self)
        end)
        rankBtn:setName("rankBtn")
        self.bg:addChild(rankBtn, 10)
    end
    
    --梦境商人
    local shopBtn = self.bg:getChildByName("shopBtn")
    if not shopBtn then
        shopBtn = UI.Button:create()
        shopBtn:init("ui_dreamword_shop_btn_0.png", "ui_dreamword_shop_btn_1.png", "ui_dreamword_shop_btn_2.png")
        shopBtn:rightBottom(40, 70)
        shopBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
            if SHEILD_DREAM_FLAG then
                return
            end
            self:checkSpriteId()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_DREAM_SHOP, self.spriteID, self)
        end)
        shopBtn:setName("shopBtn")
        self.bg:addChild(shopBtn, 10)
    end

    --梦境任务
    local taskBtn = self.bg:getChildByName("taskBtn")
    if not taskBtn then
        taskBtn = UI.Button:create()
        taskBtn:init("ui_dreamword_task_btn_0.png", "ui_dreamword_task_btn_1.png", "ui_dreamword_task_btn_2.png")
        taskBtn:rightBottom(130, 0)
        taskBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
            self:checkSpriteId()
            require"app.ui.dream.task.DreamTaskLayer"
            local taskLayer = UI.DreamTaskLayer:create()
            taskLayer:init()
            taskLayer:rightBottom(130, 65)
            taskLayer:open()
            self:addChild(taskLayer, 100)
        end)
        taskBtn:setName("taskBtn")
        self.bg:addChild(taskBtn, 10)
    end

    local challgeBtn = self.bg:getChildByName("challgeBtn")
    if not challgeBtn then
        challgeBtn = UI.Button:create()
        challgeBtn:init("ui_btn_dreamword_0.png", "ui_btn_dreamword_1.png", "ui_btn_dreamword_2.png")
        challgeBtn:centerBottom(45)
        challgeBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
            self:checkWorldBoss()
        end)
        challgeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
        challgeBtn:setText(UI.TEXT_1212262)
        self.bg:addChild(challgeBtn, 200)
        challgeBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            self:checkWorldBoss()
        end)
        challgeBtn:setName("challgeBtn")
        self.challgeBtn = challgeBtn
    end

    local goodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.DreamIcon)
    if (goodsData) then
        local dreamIcon = stoneBg:getChildByName("dreamIcon")
        if not dreamIcon then
            dreamIcon = UI.Image:create()
            dreamIcon:init(goodsData:getSmallIconName())
            dreamIcon:leftUp(54, 33)
            dreamIcon:setScale(1.3)
            dreamIcon:setName("dreamIcon")
            stoneBg:addChild(dreamIcon)
        end
    end

    local backLvBtn = self.bg:getChildByName("backLvBtn")
    if not backLvBtn then
        backLvBtn = UI.Button:create()
        backLvBtn:init("ui_dreamword_challenge_btn_0.png", "ui_dreamword_challenge_btn_1.png", "ui_dreamword_challenge_btn_2.png")
        backLvBtn:rightBottom(-5, 290)
        backLvBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.onBackLevelClick)
        backLvBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, self.onBackLevelClick)
        backLvBtn:setName("backLvBtn")
        self.bg:addChild(backLvBtn, 10)
        self.backLvBtn = backLvBtn
    end

    local dreamNumber = stoneBg:getChildByName("dreamNumber")
    if not dreamNumber then
        dreamNumber = UI.NumberText:create(RoleDataManager:getMaster():getDreamChip(),  UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_204_153)
        dreamNumber:leftUp(96, 33)
        dreamNumber:setName("dreamNumber")
        stoneBg:addChild(dreamNumber)
        self.dreamNumber = dreamNumber
    end

    -- 判断服务器下发的越阶挑战等级是否满足关卡进度，从而能进行挑战
    self.levelIsOpen = false
    local LevelStrList = string.split(ConfigManager:getGeneralForKey("dreamJumpLevel"), ";")
    local levelLimit = 0
    for _, v in ipairs(LevelStrList) do
        local strList = string.split(v, ",")
        if tonumber(strList[2]) == tonumber(dreamData.jump.lv) then
            levelLimit = tonumber(strList[1])
            break
        end
    end

    local maxLevelArr = RoleDataManager:getMaxLevelArr()
    for _,maxLevelData in pairs(maxLevelArr) do
        local curLevelNum = GameDataManager:getInstance():_handleMaxLevelGetGroupID(maxLevelData:getMode(), maxLevelData:getDifficulty()) or 0
        -- printInfo(maxLevelData:getMode().. " : "..maxLevelData:getDifficulty() .. " : " .. tostring(curLevelNum))
        if (maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_NORMAL 
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_HERO 
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_DESERT_EYES 
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE  
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_INFERNO
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_VOID_RIFT 
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_VIKING
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
            or maxLevelData:getMode() == PublicDefine.CAVE_MODE.MODE_CHAOS) and 
            curLevelNum >= tonumber(levelLimit) then
                printInfo("getCheckpointIsOver : " .. curLevelNum .. " : " ..levelLimit)
                self.levelIsOpen = true
                break
        end
    end

    self:refreshAllInfo()
    self:refreshTime()
    self:refreshDreamChipNum()

    local dreamConfig = nil
    if self.isPhase then
        dreamConfig = ConfigManager:getDreamConfigForLV(dreamData.jump.lv)
    else
        dreamConfig = ConfigManager:getDreamConfigForLV(dreamData.lv)
    end
    if dreamConfig and dreamConfig.warningDesc and dreamConfig.warningDesc > 0 then
        local clipper = self.bg:getChildByName("clipper")
        if not clipper or tolua.isnull(clipper) then
            clipper = UI.ClippingNode:create()
            clipper:initWithRect( 540, 25)
            clipper:setOpacityFilterTouch(false)
            clipper:centerUp(58)
            clipper:setName("clipper")
            self.bg:addChild(clipper)
        end
        clipper:setVisible(true)

        local clipperTitle = clipper.clipperTitle
        if not clipperTitle or tolua.isnull(clipperTitle) then
            clipperTitle = UI.Text:create()
            clipperTitle:init(UIUtil:lang(dreamConfig.warningDesc), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 198, g = 108, b = 202})
            clipper.clipperTitle = clipperTitle
            clipper:addInnerNode(clipperTitle)
        end
        clipperTitle:computePosition()

        if clipperTitle:getContentSize().width > clipper:getContentSize().width then
            clipperTitle:stopAllActions()
            clipperTitle:centerLeft(0)
            clipperTitle:computePosition()
            local posY = clipperTitle:getPositionY()
            local moveAction2 = cc.MoveTo:create(18, cc.p(clipperTitle:getContentSize().width * -1, posY))
            moveAction2 = cc.RepeatForever:create(cc.Sequence:create(moveAction2,  cc.MoveTo:create(0, cc.p(clipper:getContentSize().width, posY))))
            clipperTitle:runAction(moveAction2)
        else
            clipperTitle:centerLeft(0)
        end
    else
        local clipper = self.bg:getChildByName("clipper")
        if clipper and not tolua.isnull(clipper) then
            clipper:setVisible(false)
        end
    end

    local phaseSwitchEff = self:getChildByName("phaseSwitchEff")

    local phaseBg = self.bg:getChildByName("phaseBg")
    if not phaseBg or tolua.isnull(phaseBg) then
        phaseBg = UI.Image:create()
        phaseBg:init("ui_dreamword_overstep_banner.png")
        phaseBg:leftBottom(2, 108)
        phaseBg:setTouchEnable(true)
        phaseBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            if not self.levelIsOpen or 
                (dreamData.jump and (dreamData.jump.curBossIndex > #dreamData.jump.bossInfos or dreamData.jump.lv <= dreamData.lv))  then
                    UI.ScrollBar:createByText(UI.TEXT_1324306)
                    return
            end

            if not phaseSwitchEff then
                phaseSwitchEff = UI.Animation:create()
                phaseSwitchEff:init("effect_ui_dreamword_fire.json", "effect_ui_dreamword_fire.atlas", 1)
                phaseSwitchEff:center()
                phaseSwitchEff:setName("phaseSwitchEff")
                self:addChild(phaseSwitchEff, 500)
                phaseSwitchEff:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function()
                    phaseSwitchEff:hide()

                end)
            end

            if self.isPhase then
                MasterDataManager:setDreamChallengeIsPhase(false)
                self.isPhase = false
                phaseSwitchEff:show()
                phaseSwitchEff:setAnimation("idle2", false)
            else
                MasterDataManager:setDreamChallengeIsPhase(true)
                self.isPhase = true
                phaseSwitchEff:show()
                phaseSwitchEff:setAnimation("idle1", false)
            end

            performWithDelay(self, function()
                self:updateSelectLayer()
            end, 0.5)
        end)
        phaseBg:setName("phaseBg")
        self.bg:addChild(phaseBg)
    end

    local phaseBtnEff = phaseBg:getChildByName("phaseBtnEff")
    if not phaseBtnEff or tolua.isnull(phaseBtnEff) then
        phaseBtnEff = UI.Animation:create()
        phaseBtnEff:init("effect_ui_dreamword_button.json", "effect_ui_dreamword_button.atlas", 1)
        phaseBtnEff:center(-2, -24)
        phaseBtnEff:setName("phaseBtnEff")
        phaseBg:addChild(phaseBtnEff, 100)
    end
    if self.isPhase then
        phaseBtnEff:setAnimation("idle2", true)
    else
        phaseBtnEff:setAnimation("idle1", true)
    end

    if self.isPhase then
        title:setText(UI.TEXT_1324300)
        levelTitle:setText(UI.TEXT_1324301)
        time:hide()
        remainRefreshTime:hide()
    else
        title:setText(UI.TEXT_1212260)
        levelTitle:setText(UI.TEXT_1212261)
        time:show()
        remainRefreshTime:show()
    end
end

-- 注册监听事件(可选)
function DreamSelectLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_ALL_DREAM_INFO, self, self.refreshAllInfo)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_DREAM_CHIP_UPDATE, self, self.refreshDreamChipNum)
end

-- 注销监听事件(可选)
function DreamSelectLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_ALL_DREAM_INFO, self, self.refreshAllInfo)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_DREAM_CHIP_UPDATE, self, self.refreshDreamChipNum)
end

function DreamSelectLayer:openShow()
    self:open()
end

function DreamSelectLayer:refreshAllInfo()
    if(not MasterDataManager:isHaveDreamData()) then 
        local dreamData = MasterDataManager:getDreamData()
        local dreamStr = ""
        if(dreamData) then
            dreamStr = "haveDreamData"
            if(dreamData.maxLv) then 
                dreamStr = dreamStr.."maxLv="..tostring(dreamData.maxLv)
            end
            if(dreamData.curBossIndex) then 
                dreamStr = dreamStr..":curBossIndex="..tostring(dreamData.curBossIndex)
            end
            if(dreamData.lv) then 
                dreamStr = dreamStr..":lv="..tostring(dreamData.lv)
            end
        end
        if (device.platform == "ios" or device.platform == "android") then
            buglyReportLuaException("DreamSelectLayer not dreamData", dreamStr)
        end
        return 
    end
    local dreamData = nil
    if self.isPhase then
        dreamData = MasterDataManager:getDreamData().jump
    else
        dreamData = MasterDataManager:getDreamData()
    end

    self.levelBg:removeChildByName("NUMBER")
    local number = AvalonUtil:getStyledNumberNode(dreamData.lv or 0)
    number:leftUp(83, 14)
    self.levelBg:addChild(number)
    number:setName("NUMBER")
    
    for k, v in ipairs(self.bossCell) do
        v:removeFromParent()
    end
    self.bossCell = {}
    if dreamData.bossInfos == nil then
        dreamData.bossInfos = {}
    end
    local cellSpace = 750 / #dreamData.bossInfos
    
    for k, v in ipairs(dreamData.bossInfos) do
        local status = DREAM_CELL_STATUS.COMPLETED
        if k < dreamData.curBossIndex then
            status = DREAM_CELL_STATUS.COMPLETED
        elseif k > dreamData.curBossIndex then
            status = DREAM_CELL_STATUS.UNREACH
        else
            status = DREAM_CELL_STATUS.SELECT
        end
        local cell = UI.DreamSelectCell:create(k, v, status, self, self.isNotFirstShowCell)
        cell:centerLeft(80 + (k - 1) * cellSpace)
        if status == DREAM_CELL_STATUS.SELECT then
            self.bg:add(cell, 100)
        elseif status == DREAM_CELL_STATUS.COMPLETED then
            self.bg:add(cell, 10 + k)
        else
            self.bg:add(cell, 100 - k)
        end
        table.insert(self.bossCell, cell)
    end

    -- 刷新不再显示冒火特效effect_ui_dreamword_up
    self.isNotFirstShowCell = true

    if not self.isPhase and dreamData.maxLv > 1 and dreamData.curBossIndex == 1 and dreamData.maxLv == dreamData.lv then
        self.backLvBtn:enable()
        -- self.backLvText1:setFontColor(UI.FONT_COLOR_255_204_153)
        -- self.backLvText2:setFontColor(UI.FONT_COLOR_255_204_153)
    else
        self.backLvBtn:disable()
        -- self.backLvText1:setFontColor(UI.FONT_COLOR_153_153_153)
        -- self.backLvText2:setFontColor(UI.FONT_COLOR_153_153_153)
    end

    self.challgeBtn:enable()
    self.challgeBtn:removeChildByName("MAX")
    if MasterDataManager:isMaxDreamLv() then
        --max
        local max = UI.Image:create()
        max:setName("MAX")
        max:init("ui_information_max.png")
        max:leftUp(-3, -15)
        self.challgeBtn:addChild(max, 10)
        self.challgeBtn:disable()
        return 
    end

    self.challgeBtn:setText(UI.TEXT_1212262)
    if not self.isPhase and dreamData.curBossIndex and dreamData.curBossIndex > #dreamData.bossInfos then
        --allpass
        self.challgeBtn:setText(UI.TEXT_1212255)
        self.challgeBtn:disable()
        return
    end

    local data = dreamData.bossInfos[dreamData.curBossIndex or 1]
    if data and not data.isUnlock then
        self.challgeBtn:disable()
        return
    end
end

-- 刷新显示
function DreamSelectLayer:refreshTime()
    if self.remainRefreshTime  then
        local refresWaitingTime = GameManager:getNowServerTime() % (SECONDS_ONE_DAY)
        refresWaitingTime = 24 * 60 * 60 - refresWaitingTime
        local str = "00:00"
        if(refresWaitingTime > 0) then
            local hour = math.modf(refresWaitingTime / SECONDS_ONE_HOUR)
            local yu = refresWaitingTime % SECONDS_ONE_HOUR
            local minute = math.modf(yu/60)
            yu = yu % 60
            str = string.format("%.2d:%.2d", hour, minute)
        end
        self.remainRefreshTime:setText(str)
    end
end

function DreamSelectLayer:checkWorldBoss()
    -- 如果 worldboss 已报名，提醒一次
    if mvc.worldBossModel:checkCanEnterOther() then
        self:challgeClick()
    else
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1212663,
            function()
                Net.NetActivitySystem:requestWorldbossQuitRoom()
                self:challgeClick()
            end
        )
    end
end

function DreamSelectLayer:challgeClick()
    if RoleBehaviorManager:dreamCheck() then
        printWarn(" been blocked when refresh dream changlle!")
        return
    end
    local dreamData = MasterDataManager:getDreamData()
    if MasterDataManager:isMaxDreamLv() then
        UI.ScrollBar:createByText(UI.TEXT_1212257)
        return
    end
    if not self.isPhase and dreamData.curBossIndex > #dreamData.bossInfos then
        UI.ScrollBar:createByText(UI.TEXT_1212256)
        return
    end
    local data = dreamData.bossInfos[dreamData.curBossIndex]
    if self.isPhase then
        data = dreamData.jump.bossInfos[dreamData.jump.curBossIndex]
    end
    if not data.isUnlock then
        local list = string.split(ConfigManager:getGeneralForKey("dreamBossText"), ";")
        local listIndex = self.isPhase and dreamData.jump.curBossIndex or dreamData.curBossIndex
        UI.ScrollBar:createByTextID(tonumber(list[listIndex]))
        return
    end
    self:checkSpriteId()
    local dreamConfig = ConfigManager:getDreamConfigForLV(dreamData.lv)
    if self.isPhase then
        dreamConfig = ConfigManager:getDreamConfigForLV(dreamData.jump.lv)
    end
    if dreamConfig == nil then
        printWarn("!!!!!!!!!!!!!!!!!!!reamSelectLayer:challgeClick dreamConfig is null!!!!!!")
    end



    -- 检查答题限制,如果返回true 说明是属于小黑屋,不能进入战斗
    if not AnswerDataManager:canEnterCave() then
        local time = AnswerDataManager:getNextEnterCaveSecRemind()
        local h = math.floor( time / 3600 )
        local m = math.ceil((time - h * 3600) / 60)
        local LanguageManager = require("app.game.LanguageManager")
        UI.ConfirmDialog.showConfrimOnly(string.format(LanguageManager:getInstance():getLocalString(1170210), h, m), nil, nil, nil, nil)
        return
    end

    local sceneId = dreamConfig.shopScene[dreamData.curBossIndex]
    if self.isPhase then
        sceneId = dreamConfig.shopScene[dreamData.jump.curBossIndex]
    end

    -- if(mvc.expeditionModel:getExpeditionStatus()) then
    --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
    --         if not tolua.isnull(self) then
    --             Net.NetNPCSystem:reqStopExpedition()
    --             self:_handleEnterRequest(sceneId)
    --         end
    --     end)
    -- else
        self:_handleEnterRequest(sceneId)
    -- end
end

function DreamSelectLayer:_handleEnterRequest(sceneId)
    local dreamType = self.isPhase and 1 or 0
    Net.NetRoleSystem:heroEnterCaveSceneRequest(
        PublicDefine.GAME_MODE.MODE_SOLO, 
        PublicDefine.CAVE_MODE.MODE_DREAM,
        PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
                    sceneId,
        self.spriteID,
        nil,
        nil,
        dreamType
    )

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
end

function DreamSelectLayer:getOpenAnimation()
    self:setAnchorPoint(0.5, 0.5)
    local scaleAction = cc.ScaleTo:create(0.15, 1, 1)
    local easeScaleAction = cc.Sequence:create(cc.DelayTime:create(0.5), cc.EaseOut:create(scaleAction, 4))

    return easeScaleAction
end

function DreamSelectLayer:showBufInfo(bufferIDs, nodePosition)
    local infoNode = self:getChildByName("BufInfo")
    if infoNode then
        infoNode:removeFromParent()
    end

    info = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_chat.png")
    info:setCapInsets(CCRectMake(7,7,1,1))
    info:setName("BufInfo")
    self:addChild(info, 200)
    
    local height = 5
    local panelList = {}
    for k, v in ipairs(bufferIDs) do
        local buffData = ConfigManager:getBufferConfigById(v)
        if buffData then
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
    
    if nodePosition.x < size.width / 2 then
        info:setPosition(nodePosition.x + info:getContentSize().width / 2 + 30, nodePosition.y - info:getContentSize().height + 40)
    else
        info:setPosition(nodePosition.x - info:getContentSize().width / 2 - 50, nodePosition.y - info:getContentSize().height + 40)
    end
end

function DreamSelectLayer:hideBufInfo()
    local infoNode = self:getChildByName("BufInfo")
    if infoNode then
        infoNode:removeFromParent()
    end
end

function DreamSelectLayer:createOneBuf(buffData)
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

function DreamSelectLayer:checkSpriteId()
    if self.spriteID == 0 or self.spriteID == nil then
        local MachineManager = require("app.game.MachineManager")
        local battleMachine = MachineManager:getInstance():getMachine()
        if battleMachine ~= nil then
            local battleModel = battleMachine:getModel()
            if (battleModel) then
                local npcModels = battleModel:getDreamNpcModels()
                if npcModels[1] then
                    self.spriteID = npcModels[1]:getSpriteID()
                end
            end
        end
    end
end

function DreamSelectLayer:refreshDreamChipNum()
    self.dreamNumber:setText(RoleDataManager:getMaster():getDreamChip())
end

function DreamSelectLayer:onBackLevelClick()
    if SHEILD_DREAM_FLAG then
        return
    end

    if RoleBehaviorManager:dreamCheck() then
        printWarn(" been blocked when refresh dream changlle!")
        return
    end
    local dreamData = MasterDataManager:getDreamData()
    if self.isPhase then
        UI.ScrollBar:createByText(UI.TEXT_1324302)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_SHOW_DREAM_END)
        return
    end
    if dreamData.maxLv <= 1 then
        UI.ScrollBar:createByText(UI.TEXT_1212333)
        return
    end
    if dreamData.maxLv ~= dreamData.lv then
        UI.ScrollBar:createByText(UI.TEXT_1212335)
        return
    end
    if dreamData.curBossIndex > 1 then
        UI.ScrollBar:createByText(UI.TEXT_1212334)
        return
    end
   
    UI.ConfirmDialog.show(UI.TEXT_1212332, function()
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetRoleSystem:requestChangeDreamLv() 
    end)
end
-- DungeonGuardLayer.lua
-- Author:ydli
-- 2017年09月04日
-- Using:大秘境 npc 入口界面
require "utils.AvalonUtil"
require "app.ui.town.levelSelect.LevelSelectTeam"
require "app.ui.shoplayer.BagGoodsPanel"
require "app.datas.AnswerDataManager"
local LanguageManager = require("app.game.LanguageManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

UI = UI or {}
local DungeonGuardLayer = class("DungeonGuardLayer", UI.DoorWin)
UI.DungeonGuardLayer = DungeonGuardLayer


local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local SELECT_TAG = {
    ONE_PLAY = 1,
    TEAM_PLAY = 2,
}


--资源列表(必备)
local COM_RES_LIST = {
    "ui_town_dungeon.plist",
    "ui_town_levelselect.plist",
    "ui_common_scale9image.plist",
}


--构造函数(必备)
function DungeonGuardLayer:ctor(spriteID)
    DungeonGuardLayer.super.ctor(
        self, UIType.ES_GUARD_LAYER,
        COM_RES_LIST,
        winSize.width / 3,    -- 触摸关闭点暂时在宿主窗体上做
        winSize.height
    )
    self._KeyGrid = nil
    self._rootLayer = nil         --root节点
    self._spriteID = spriteID
    self._floorLevel = nil
    self._selectTag = SELECT_TAG.ONE_PLAY
    self:init()
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:registerListener()
end


--虚构函数, destroy时调用(必备)
function DungeonGuardLayer:dtor()
    DungeonGuardLayer.super.dtor(self)
    self:unRegisterListener()
    self._floorLevel = nil
    self._selectTag = SELECT_TAG.ONE_PLAY
    -- reload_script_file("app.ui.dungeon.DungeonGuardLayer")
end


-- 初始化(必备)
function DungeonGuardLayer:init()
    local GameDataManager = require("app.game.GameDataManager")
    local masterData = GameDataManager:getInstance():getMaster()
    local maxLevelData = masterData:getMaxLevelData(PublicDefine.CAVE_MODE.MODE_DUNGEON, 1)
    local floor = maxLevelData:getMaxLevel()
    local maxLv = (floor == nil or floor == 0) and 1 or floor
    local calcMaxLv = maxLv - 1
    self._floorLevel = calcMaxLv - calcMaxLv % 5 + 1

    DungeonGuardLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function DungeonGuardLayer:onInitView()
    -- 新手引导辅助板块. 丑陋地添加一个不随着屏幕宽高改变的版面来为新手引导圈圈的版面使用, 让它不会随屏幕设计尺寸改变而偏移.
    local ngHelper = UI.Component:create(UIType.ES_GUARD_LAYER)
    ngHelper:init()
    ngHelper:setSize(378.6666666667, 640)
    ngHelper:leftBottom(0, 0)
    self:addChild(ngHelper)

    -- 总板块
    self._rootLayer = UI.Component:create()
    self._rootLayer:init()
    self._rootLayer:setSize(winSize.width, winSize.height)
    self._rootLayer:leftBottom(0, 0)
    self:addChild(self._rootLayer)

    -- 左边板块
    self._leftLayout = UI.Component:create()
    self._leftLayout:init()
    self._leftLayout:setSize(winSize.width, winSize.height)
    self._leftLayout:leftBottom(0, 0)
    self._rootLayer:addChild(self._leftLayout, 1)

    -- 背景版面
    self._bg = UI.Animation:create()
    self._bg:init("effect_ui_town_dungeon_door.json", "effect_ui_town_dungeon_door.atlas")
    self._bg:setInnerOffset(0, -17)
    self._bg:setSize(390, 651)
    self._bg:centerLeft(0)
    self._bg:setAnimation("begin")
    self._leftLayout:addChild(self._bg, 10)

    -- 格子边框
    self._KeyGridBox = UI.Animation:create()
    self._KeyGridBox:init("effect_ui_town_dungeon_icon_fx.json", "effect_ui_town_dungeon_icon_fx.atlas")
    self._KeyGridBox:setSize(78, 78)
    self._KeyGridBox:leftBottom(156, 269.5)
    self._KeyGridBox:setAnimation("begin")
    self._bg:addChild(self._KeyGridBox)

    -- 钥匙的格子
    self._KeyGrid = UI.GoodsGrid:create()
    self._KeyGrid:init()
    self._KeyGrid:leftBottom(159.7, 405)
    self._KeyGrid:hideCountLabel()
    self._KeyGrid:hideNewIcon()
    self._KeyGrid:showInfoArea()
    self._bg:addChild(self._KeyGrid)

    -- 钥匙解释
    self._itemInfo = UI.Text:create()
    self._itemInfo:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    self._itemInfo:setFontColor(UI.FONT_COLOR_41_41_45)
    self._itemInfo:centerBottom(354)
    self._itemInfo:setTextVerticalCenterAndHLeft()
    self._itemInfo:autoAdapt()
    self._itemInfo:setLineSpacing(-3)
    self._bg:addChild(self._itemInfo)

    -- 购买猫饭快捷方式
    local catFoodBg = UI.Image:create()
    catFoodBg:init("ui_dungeon_banner_catfood_box.png")
    catFoodBg:leftBottom(307, 59)
    self._bg:addChild(catFoodBg, 100)

    local catFoodBtn = UI.Button:create()
    catFoodBtn:init("ui_btn_catfood_0.png", "ui_btn_catfood_1.png", "ui_btn_catfood_0.png")
    catFoodBtn:centerBottom(22)
    local parenLayer = self
    catFoodBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_CATFOOD, 0, parenLayer)
    end)
    catFoodBg:addChild(catFoodBtn, 10)

    -- 单人按钮
    self._onePlay = UI.Button:create()
    self._onePlay:init("ui_btn_single_0.png", "ui_btn_hero_single_1.png", "ui_btn_single_2.png")
    self._onePlay:leftBottom(116, 290)
    self._onePlay:addEventListener(UIEvent.BUTTON_CLICK, self, self.onBtnOnePlayClick)
    self._bg:addChild(self._onePlay)

    -- 组队按钮
    self._teamPlay = UI.Button:create()
    self._teamPlay:init("ui_btn_many_0.png", "ui_btn_hero_many_1.png", "ui_btn_many_2.png")
    self._teamPlay:leftBottom(221, 290)
    self._teamPlay:addEventListener(UIEvent.BUTTON_CLICK, self, self.onBtnTeamPlayClick)
    self._bg:addChild(self._teamPlay)

    -- 滚动介绍文字
    local functionDesc = UI.Text:create()
    functionDesc:init(UI.TEXT_1170203, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    functionDesc:setFontColor(UI.FONT_COLOR_41_41_45)
    functionDesc:leftUp(0, 0)
    functionDesc:autoAdapt()
    functionDesc:setDimensions(230, 0)

    -- 滚动文字框内部布局
    local upLayout = UI.Layout:create()
    upLayout:init()
    upLayout:setSize(235, functionDesc._height)
    upLayout:addChild(functionDesc)

    -- 滚动文字框
    local descScrollView = UI.ScrollView:create()
    descScrollView:setSize(255, 180)
    descScrollView:init(1, 1, 1, 1)
    descScrollView:leftBottom(80, 92)
    descScrollView:addInnerNode(upLayout)
    descScrollView:setScrollBarEnabled(true)
    descScrollView:setCircleVisible(false)
    descScrollView:setScrollBarColor(UI.SLIDER_COLOR_134_129_103)
    descScrollView:setScrollBarWidth(3)
    self._bg:addChild(descScrollView)

    -- 进入大秘境按钮
    self._btnBegin = UI.Button:create()
    self._btnBegin:init("ui_btn_stone3_0.png", "ui_btn_stone3_1.png", "ui_btn_stone3_2.png")
    self._btnBegin:centerBottom(28)
    self._btnBegin:addEventListener(UIEvent.BUTTON_CLICK, self, self.onBeginPlayClick)
    self._bg:addChild(self._btnBegin)
    AvalonUtil.addBracketsAnimationToButton(self._btnBegin)

    -- 进入大秘境文字
    local txtBtn = UI.Text:create()
    txtBtn:init(UI.TEXT_1170216, UI.FONT_BOLD, UI.FONT_SIZE_20PX)
    txtBtn:center()
    txtBtn:setFontColor(UI.FONT_COLOR_219_184_80)
    txtBtn:setTextCenter()
    self._btnBegin:addChild(txtBtn, 100)

    -- 地图的排版锚点 (需要上下居中后, 往下偏移一点点, 所以用了这种比较丑陋的方式)
    local mapAnchor = UI.Component:create()
    mapAnchor:init()
    mapAnchor:centerLeft(340)
    self._leftLayout:addChild(mapAnchor)

    -- 地图组件
    require "app.ui.dungeon.DungeonGuardMap"
    self._lvSelectionMap = UI.DungeonGuardMap:create()
    self._lvSelectionMap:init(self._floorLevel)
    self._lvSelectionMap:leftBottom(0, -15)
    self._lvSelectionMap:setSelectCallback(function(lv)
        self._floorLevel = lv
        self:updateView()
    end)
    mapAnchor:setSize(self._lvSelectionMap:getSize())
    mapAnchor:addChild(self._lvSelectionMap)

    -- 设置基类动画
    self:setDoorNode(self._leftLayout)
end




-- 模版函数：更新组建的视图(必备)
function DungeonGuardLayer:onUpdateView()
    -- 更新按钮状态
    self:refreshSelectTag()
    self:refreshTabState()
    self:refreshKeyGrid()
end

-- 注册监听事件(可选)
function DungeonGuardLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
end

-- 注销监听事件(可选)
function DungeonGuardLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
end

-- 打开动画
function DungeonGuardLayer:getOpenAnimation()
    local offX = 30
    local time1 = 0.15
    local time2 = 0.1
    local leftLayerPosOffset = 0
    local xPos = Avalon.issUtil:getLeftEdgeXForNode(self._leftLayout) + leftLayerPosOffset
    local yPos = winSize.height / 2
    self._leftLayout._enableAutoUpdatePos = false
    self._leftLayout:setIgnoreAnchorPointForPosition(false)
    self._leftLayout:setAnchorPoint(0, 0.5)
    self._leftLayout:setPosition(-self._leftLayout._width - xPos, winSize.height / 2)
    local move1 = cc.EaseOut:create(cc.MoveTo:create(time1 - time1 / 10, cc.p(xPos + offX, yPos)), 1)
    local move2 = cc.EaseInOut:create(cc.MoveTo:create(time2, cc.p(xPos, yPos)), 7)
    self._leftLayout:runAction(cc.Sequence:create(move1, move2))

    local oldPosX3 = self._lvSelectionMap:getPositionX()
    self._lvSelectionMap:setPositionX(-self._lvSelectionMap:getContentSize().width)
    local delatAct = cc.DelayTime:create(time1 / 10)
    local move1 = cc.EaseBackOut:create(cc.MoveTo:create(time1 * 2, cc.p(oldPosX3, self._lvSelectionMap:getPositionY())))
    self._lvSelectionMap:runAction(cc.Sequence:create(delatAct, move1))
end

-- 关门动画
function DungeonGuardLayer:getCloseAnimation()
    Avalon.AudioManager:playSound("1502")
    self:runAction(cc.MoveTo:create(0.1, cc.p(-winSize.width, self:getPositionY())))

    local delayAction = cc.DelayTime:create(0.15)
    return delayAction
end

-- 主界面对点击进入大秘境的表现
function DungeonGuardLayer:bgOnGo(callback)
    self._bg._spine:registerSpineEventHandler(function (event)
        if(event.animation == "trigger") then
            if (callback) then callback() end
        end
    end, sp.EventType.ANIMATION_COMPLETE)
    self._bg:setAnimation("trigger", false)
    self._bg:addAnimation("end", true)
    self._KeyGridBox:setAnimation("trigger", false)
    self._KeyGridBox:addAnimation("end", true)
    self._KeyGridBox:setZOrder(self._KeyGrid:getZOrder() + 1)
    self._lvSelectionMap:playEnterAni()
    Avalon.AudioManager:playSoundDelay("1534", 100)
end

-- 刷新单人组队模式按钮
function DungeonGuardLayer:refreshSelectTag()
    if self._selectTag == SELECT_TAG.ONE_PLAY then
        self._onePlay:setBtnStatus(ButtonState.ACTIVE)
        self._teamPlay:setBtnStatus(ButtonState.NORMAL)
    elseif self._selectTag == SELECT_TAG.TEAM_PLAY then
        self._onePlay:setBtnStatus(ButtonState.NORMAL)
        self._teamPlay:setBtnStatus(ButtonState.ACTIVE)
    end
end

-- 单人组队按钮点击
function DungeonGuardLayer:onBtnOnePlayClick()
    self._selectTag = SELECT_TAG.ONE_PLAY 
    self:refreshSelectTag()
end

-- 多人组队按钮点击
function DungeonGuardLayer:onBtnTeamPlayClick()
    self._selectTag = SELECT_TAG.TEAM_PLAY 
    self:refreshSelectTag()
    Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
end

-- 进入大秘境按钮点击
function DungeonGuardLayer:onBeginPlayClick()
    -- 检查答题限制,如果返回true 说明是属于小黑屋,不能进入战斗
    if not AnswerDataManager:canEnterCave() then
        local time = AnswerDataManager:getNextEnterCaveSecRemind()
        local h = math.floor( time / 3600 )
        local m = math.ceil((time - h * 3600) / 60)
        UI.ConfirmDialog.showConfrimOnly(string.format(LanguageManager:getInstance():getLocalString(1170210),h,m), nil, nil, nil, nil)
        return
    end

    local currentSeason = MasterDataManager:getCurrentSeasonData()
    if currentSeason == nil or not currentSeason.open then
        UI.ScrollBar:createByText(UI.TEXT_110043)
        return
    end

    local keyData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, DUNGEON_ITEM_KEY, false, 0)
    if keyData and keyData:getIsLock() then
        UI.ScrollBar:createByText(UI.TEXT_110030)
        return
    end

    function doEnterDungeon()
        if self._selectTag == SELECT_TAG.ONE_PLAY then
            if self._floorLevel ~= nil then
                if (RoleBehaviorManager:enterDungeonCheck()) then 
                    LevelSelectUtil:getInstance().mPattern = PublicDefine.GAME_MODE.MODE_SOLO
                    LevelSelectUtil:getInstance():setCaveMode(PublicDefine.CAVE_MODE.MODE_DUNGEON)
                    LevelSelectUtil:getInstance().mDifficulty:set(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)

                    Net.NetRoleSystem:heroEnterCaveSceneRequest(
                        PublicDefine.GAME_MODE.MODE_SOLO, 
                        PublicDefine.CAVE_MODE.MODE_DUNGEON,
                        PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
                        self._floorLevel, self._spriteID)
        
                    MasterDataManager:setRepeatHandleData(RepeatHandleType.DUNGEON_GUARD, true)

                    self._btnBegin:disable()
                end 
            end
        elseif self._selectTag == SELECT_TAG.TEAM_PLAY then
            if TeamDataManager:getPunishmentState() >= 2 then
                UI.ScrollBar:createByText(string.format(UI.TEXT_110072, ConfigManager:getPunishmentTime() / 60))
                return
            end
        
            if self._floorLevel ~= nil then
                LevelSelectUtil:getInstance().mPattern = PublicDefine.GAME_MODE.MODE_TEAM
                LevelSelectUtil:getInstance():setCaveMode(PublicDefine.CAVE_MODE.MODE_DUNGEON)
                LevelSelectUtil:getInstance().mDifficulty:set(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
                LevelSelectUtil:getInstance().mSelectLevel = self._floorLevel

                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM, 1)
                self:close() 
            end
        end
    end

    -- 如果 worldboss 已报名，提醒一次
    if mvc.worldBossModel:checkCanEnterOther() then
        -- if(mvc.expeditionModel:getExpeditionStatus()) then
        --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
        --         Net.NetNPCSystem:reqStopExpedition()
        --         self:bgOnGo(function() 
        --             doEnterDungeon()
        --         end)
        --     end)
        -- else 
            self:bgOnGo(function() 
                doEnterDungeon()
            end)
        -- end
    else
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1212663,
            function()
                Net.NetActivitySystem:requestWorldbossQuitRoom()
                -- if(mvc.expeditionModel:getExpeditionStatus()) then
                --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
                --         Net.NetNPCSystem:reqStopExpedition()
                --         self:bgOnGo(function() 
                --             doEnterDungeon()
                --         end)
                --     end)
                -- else 
                    self:bgOnGo(function() 
                        doEnterDungeon()
                    end)
                -- end
            end
        )
    end
end

-- 秘境奖励查询按钮点击
function DungeonGuardLayer:onBtnSearchClick()
    require("app.ui.dungeon.DungeonRankRewardLayer")
    local rankRewardLayer = UI.DungeonRankRewardLayer:create()
    rankRewardLayer:leftBottom(0, 0)
    self:getParent():addChild(rankRewardLayer, UI_ZORDER.ACTIVITY);
end

-- 刷新钥匙框和解释文字表现
function DungeonGuardLayer:refreshKeyGrid()
    local GameDataManager = require("app.game.GameDataManager")
    local haveKey = GameDataManager:getInstance():judgeHaveDungeonKey(1)
    self._haveKey = haveKey

    local keyData = GoodsDataManager:createLocalGoodsData(DUNGEON_ITEM_KEY)
    self._KeyGrid:setData(keyData)
    self._KeyGrid:updateView()
    self._KeyGrid:updateCanUseState(haveKey)
    self._KeyGrid:show()
    self._KeyGrid:hideCountLabel()
    self._KeyGrid:hideNewIcon()
    self._KeyGrid:hideBG()
    self:refreshBtnState()
    self:refreshLabel()
end

-- 刷新解释文字
function DungeonGuardLayer:refreshLabel()
    if (not self._floorLevel) then return end
    if (self._KeyGrid) then
        self._itemInfo:setText(string.format(UI.TEXT_1170205, self._floorLevel))
    else
        self._itemInfo:setText("")
    end
end

-- 刷新进洞按钮表现
function DungeonGuardLayer:refreshBtnState()
    local saveDate = MasterDataManager:getRepeatHandleData(RepeatHandleType.DUNGEON_GUARD)
    if saveDate then
        self._btnBegin:disable()
        return
    end
    if self._haveKey and self._floorLevel then
        self._btnBegin:enable()
    else
        self._btnBegin:disable()
    end
end

-- 刷新标签按钮, 是否灰调或点亮, 是否播放解锁动画, 是否播放new动画
function DungeonGuardLayer:refreshTabState()
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
        if Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
            ToolsUtil:playNewAction(self._teamPlay, 0.8)
        else
            ToolsUtil:removeNewAction(self._teamPlay)
        end
    else
        self._teamPlay:disable()
        self._teamPlay:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
                Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
            end
        end)
    end
end

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/06/07
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local CaveExploringView = class("CaveExploringView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local SceneManager = require("app.game.SceneManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_boxtreasure.plist",
    "ui_town_businessactivities.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 1024
local COM_HEIGHT = 560

function CaveExploringView:ctor()
    CaveExploringView.super.ctor(
    	self,
    	UI.Type.CAVE_EXPLORING,
        COM_RES_LIST,
        winSize.width,
        winSize.height
    )

    self.caveMode = PublicDefine.CAVE_MODE.MODE_TREATURE_HUNT
    self.curLevel = 1
    self.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(self.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint()) - 2000
    self.boxSpineList = {}
    self.boxDesList = {}
    self:bindModel()
end

function CaveExploringView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.caveexploring", "CaveExploring", false)
    CaveExploringView.super.init(self, ... )
end

function CaveExploringView:dtor()
    CaveExploringView.super.dtor(self)
    self.boxSpineList = {}
    self.boxDesList = {}
    self:unbindModel()
    reload_script_file_mvc("app.modules.caveexploring.CaveExploringView")
end


function CaveExploringView:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 0)
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- title
    local title = UI.Image:create()
    title:init("ui_bg_title.png")
    title:centerUp(-10)
    contentLayout:addChild(title, 999)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_224800, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170)
    titleText:center(10, 0)
    title:addChild(titleText, 100)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_businessactivities_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 背景图片
    local boxMap  = UI.Image:create()
    boxMap:init("ui_boxtreasure_map.png")
    boxMap:center(0, 15)
    contentLayout:addChild(boxMap)

    local leftImg  = UI.Image:create()
    leftImg:init("ui_boxtreasure_decorate.png")
    leftImg:leftBottom(-45, 10)
    contentLayout:addChild(leftImg)

    local rightImg  = UI.Image:create()
    rightImg:init("ui_bg_decoration.png")
    rightImg:rightBottom(-35, 10)
    contentLayout:addChild(rightImg)

    self.boxSpineList, self.boxDesList = self:getBoxSpine()
    self:initBoxMapView()
end

-- 模版函数：更新组建的视图
function CaveExploringView:onUpdateView()
    CaveExploringView.super.onUpdateView(self)
end

function CaveExploringView:initBoxMapView()
    -- 左侧内容面板
    local boxLayout = UI.Layout:create()
    boxLayout:init()
    boxLayout:setSize(884, 454)
    boxLayout:center(0, 15)
    self.contentLayout:addChild(boxLayout, 5)
    self.boxLayout = boxLayout


    -- local modeBgAnim = UI.Animation:create()
    -- modeBgAnim:init("effect_ui_town_selectfloor_foreverwinter.json", "effect_ui_town_selectfloor_foreverwinter.atlas", 1)
    -- modeBgAnim:center()
    -- boxLayout:addChild(modeBgAnim, 1)
    -- -- modeBgAnim:setAnimation("begin", false)
    -- self.modeBgAnim = modeBgAnim

    local refreshBtn = UI.Button:create()
    refreshBtn:init("ui_boxtreasure_refresh.png", "ui_boxtreasure_refresh.png", "ui_boxtreasure_refresh_grey.png")
    refreshBtn:rightUp(230, 75)
    refreshBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:onRefreshBoxMap()
    end)
    self.contentLayout:addChild(refreshBtn, 10)

    local refreshBg  = UI.Image:create()
    refreshBg:init("ui_boxtreasure_refresh_bg.png")
    refreshBg:rightUp(60, 100)
    self.contentLayout:addChild(refreshBg)

    local refeshTimes = UI.Text:create()
    refeshTimes:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_211_207_206)
    refeshTimes:center(-20, 0)
    refreshBg:addChild(refeshTimes, 100)
    self.refeshTimes = refeshTimes

    local refeshKeyLayout = UI.Layout:create()
    refeshKeyLayout:init()
    refeshKeyLayout:setSize(150, 30)
    refeshKeyLayout:rightUp(90, 110)
    self.contentLayout:addChild(refeshKeyLayout, 95)
    self.refeshKeyLayout = refeshKeyLayout

    local boxKeyLayout = UI.Layout:create()
    boxKeyLayout:init()
    boxKeyLayout:setSize(150, 30)
    boxKeyLayout:rightUp(90, 35)
    self.contentLayout:addChild(boxKeyLayout, 95)
    -- self.boxKeyLayout = boxKeyLayout

    local treasureHuntOpenBoxConsume = ConfigManager:getGeneralForKey("treasureHuntOpenBoxConsume")
    local treasureHuntOpenBoxConsumeList = string.split(treasureHuntOpenBoxConsume, ",")
    local goodsData = ConfigManager:getVirtualItemConfigByID(tonumber(treasureHuntOpenBoxConsumeList[1]))
    local miniIcon = goodsData.miniIcon
    local itemTotalNum = RoleDataManager:getMaster():getTreatureHuntOpenItem()

    local boxKeyIcon  = UI.Image:create()
    boxKeyIcon:init(miniIcon)
    boxKeyIcon:center(-20, 0)
    boxKeyLayout:addChild(boxKeyIcon)

    local boxKey = UI.Text:create()
    boxKey:init(itemTotalNum, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_188_188_188)
    boxKey:center(10, 0)
    boxKeyLayout:addChild(boxKey, 100)
    self.boxKey = boxKey

    local challengeBtn = UI.Button:create()
    challengeBtn:init("ui_boxtreasure_btn.png", "ui_boxtreasure_btn.png", "ui_boxtreasure_btn.png")
    challengeBtn:setText(UI.TEXT_224802)
    challengeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    challengeBtn:centerBottom(25)
    challengeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:onChallengeBtnClick()
    end)
    self.contentLayout:addChild(challengeBtn, 10)

    self:updateBoxMapView(false)
end

function CaveExploringView:updateBoxMapView(isRemove)
    if isRemove and self.boxLayout and not tolua.isnull(self.boxLayout) then
        self.boxLayout:removeAllChildren()
    end

    local mapConfig = ConfigManager:getCaveHuntDataByID(self.curLevel)
    local posList = string.split(mapConfig.boxPos, ";")
    local mapInfo = mvc.caveExploringModel:getBoxMapInfo()
    for k, v in pairs(mapInfo[self.curLevel]) do
        local boxPos = string.split(posList[k], ",")
        local box = self:createBoxCell(k, v, mapConfig)
        box:center(boxPos[1], boxPos[2])
        self.boxLayout:addChild(box)
    end

    local mapInfo = mvc.caveExploringModel:getBoxMapInfo()
    -- local curMapInfo = mapInfo[self.curLevel]
    local refreshTimes = mapInfo.refreshNum
    -- local treasureHuntBoxRefreshTimesMax = tonumber(ConfigManager:getGeneralForKey("treasureHuntBoxRefreshTimesMax"))
    local treasureHuntBoxRefreshTimes = tonumber(ConfigManager:getGeneralForKey("treasureHuntBoxRefreshTimes"))

    local showTimes = treasureHuntBoxRefreshTimes - refreshTimes > 0 and treasureHuntBoxRefreshTimes - refreshTimes or 0
    local timesStr = string.format( UI.TEXT_224801, showTimes)
    self.refeshTimes:setText(timesStr)

    self:updateRefeshKeyLayout()
    -- self.refeshKeyLayout:setVisible(treasureHuntBoxRefreshTimes - refreshTimes <= 0)
    self.refeshKeyLayout:setVisible(false)
end

function CaveExploringView:createBoxCell(index, data)
    local imgName = data.isOpen and self.boxSpineList[data.boxid].."_1.png" or self.boxSpineList[data.boxid]..".png"
    local boxImg = UI.Image:create()
    boxImg:init(imgName)
    boxImg:setTouchEnable(true)

    local des = languageManagerInstance:getLocalString(self.boxDesList[data.boxid])
    boxImg:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_PET_INFO_TIP, touchPosition.x, touchPosition.y, false, des)
    end)
    boxImg:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)
    boxImg:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_PET_INFO_TIP)
    end)

    return boxImg
end

function CaveExploringView:updateRefeshKeyLayout()
    if self.refeshKeyLayout and not tolua.isnull(self.refeshKeyLayout) then
        self.refeshKeyLayout:removeAllChildren()
    end

    local treasureHuntBoxRefreshMaterial = ConfigManager:getGeneralForKey("treasureHuntBoxRefreshMaterial")
    local treasureHuntBoxRefreshMaterialList = string.split(treasureHuntBoxRefreshMaterial, ",")
    local goodsData = ConfigManager:getMaterialConfigByID(tonumber(treasureHuntBoxRefreshMaterialList[1]))
    local miniIcon = goodsData.miniIcon

    local icon  = UI.Image:create()
    icon:init(miniIcon)
    icon:center(-15, 0)
    self.refeshKeyLayout:addChild(icon)

    local pk = RoleDataManager:getMasterPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, tonumber(treasureHuntBoxRefreshMaterialList[1]))
    local keyNum = UI.Text:create()
    keyNum:init(tostring(itemTotalNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_211_207_206)
    keyNum:center(10, 0)
    self.refeshKeyLayout:addChild(keyNum, 100)
end

function CaveExploringView:getBoxSpine()
    local boxSpineList = {}
    local mapConfig = ConfigManager:getCaveHuntDataByID(self.curLevel)
    local spineList = string.split(mapConfig.boxSpine, ";")
    for k, v in pairs(mapConfig.boxID) do
        boxSpineList[v] = spineList[k]
    end
    local boxDesList = {}
    -- local desList = string.split(mapConfig.boxDesId, ";")
    for k, v in pairs(mapConfig.boxID) do
        boxDesList[v] = mapConfig.boxDesId[k]
    end

    return boxSpineList, boxDesList
end

function CaveExploringView:onChallengeBtnClick()
    -- local totalTiems = ConfigManager:getGeneralForKey("everwinterRiftDailyChallenges")
    -- totalTiems = tonumber(totalTiems)
    -- local everWinterRiftData = mvc.everWinterRiftModel:getEverWinterRiftData()
    -- local extraFightNum = everWinterRiftData.extraFightNum or 0
    -- local fightNum = everWinterRiftData.fightNum or 0
    -- if totalTiems<=fightNum and extraFightNum <= 0 then
    --     UI.ScrollBar:createByText(UI.TEXT_1328010)
    --     return 
    -- end
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TREATURE_HUNT) == false then
        UI.ScrollBar:createByText(UI.TEXT_1170901)
        return 
    end
    if SceneManager:getInstance():isInFightScene() then
        UI.ScrollBar:createByText(UI.TEXT_224803)
        return 
    end 

    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if(freePacketNum <= 0) then
        UI.ScrollBar:createByTextD(1110793)
        return 
    end

    local mapInfo = mvc.caveExploringModel:getBoxMapInfo()
    local curMapInfo = mapInfo[self.curLevel]
    local refreshTimes = mapInfo.refreshNum
    local treasureHuntBoxRefreshTimesMax = tonumber(ConfigManager:getGeneralForKey("treasureHuntBoxRefreshTimesMax"))
    local treasureHuntBoxRefreshTimes = tonumber(ConfigManager:getGeneralForKey("treasureHuntBoxRefreshTimes"))

    -- if refreshTimes >= treasureHuntBoxRefreshTimes then
    --     UI.ScrollBar:createByText(UI.TEXT_224804)
    --     return 
    -- end

    if treasureHuntBoxRefreshTimes > refreshTimes and not mapInfo.isEnterCaved then
        local tips = UI.Tips:createTips(UI.TEXT_224806, UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
        tips:setContentFontName(UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
        -- 确定和取消事件监听
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            if (RoleBehaviorManager:enterCaveCheck()) then 
                local id = 1--LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(mvc.everWinterRiftModel:getCurLevel())--(self.selectedIcon:getTag())
                Net.NetRoleSystem:heroEnterCaveSceneRequest(
                        LevelSelectUtil:getInstance().mPattern,
                        self.caveMode,
                        self.curDiff,
                        id,
                        self.spriteID)
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            end 
        end)
    else
        if (RoleBehaviorManager:enterCaveCheck()) then 
            local id = 1--LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(mvc.everWinterRiftModel:getCurLevel())--(self.selectedIcon:getTag())
            Net.NetRoleSystem:heroEnterCaveSceneRequest(
                    LevelSelectUtil:getInstance().mPattern,
                    self.caveMode,
                    self.curDiff,
                    id,
                    self.spriteID)
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        end
    end
end


function CaveExploringView:onRefreshBoxMap()
    if SceneManager:getInstance():isInFightScene() then
        UI.ScrollBar:createByText(UI.TEXT_224803)
        return 
    end
    local mapInfo = mvc.caveExploringModel:getBoxMapInfo()
    local curMapInfo = mapInfo[self.curLevel]
    local refreshTimes = mapInfo.refreshNum
    local treasureHuntBoxRefreshMaterial = ConfigManager:getGeneralForKey("treasureHuntBoxRefreshMaterial")
    local treasureHuntBoxRefreshMaterialList = string.split(treasureHuntBoxRefreshMaterial, ",")
    local treasureHuntBoxRefreshTimesMax = tonumber(ConfigManager:getGeneralForKey("treasureHuntBoxRefreshTimesMax"))
    local treasureHuntBoxRefreshTimes = tonumber(ConfigManager:getGeneralForKey("treasureHuntBoxRefreshTimes"))

    if mapInfo.isEnterCaved then
        UI.ScrollBar:createByText(UI.TEXT_224804)
        return 
    end

    if refreshTimes >= treasureHuntBoxRefreshTimesMax then
        UI.ScrollBar:createByText(UI.TEXT_224804)
        return 
    end

    if refreshTimes < treasureHuntBoxRefreshTimesMax and treasureHuntBoxRefreshTimes <= refreshTimes then
        UI.ScrollBar:createByText(UI.TEXT_224805)
        return 
    end

    local pk = RoleDataManager:getMasterPK()
    local itemTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, tonumber(treasureHuntBoxRefreshMaterialList[1]))
    if treasureHuntBoxRefreshTimes <= refreshTimes and itemTotalNum < tonumber(treasureHuntBoxRefreshMaterialList[2]) then
        UI.ScrollBar:createByText(UI.TEXT_224808)
        return 
    end

    Net.NetPlaySystem:requestTreasureHuntRefreshBox(self.curLevel)
end

function CaveExploringView:showTip(x, y, isRevert, text)
    local pos = self:convertToNodeSpace(cc.p(x, y))

    -- 提示框
    local tipBG = self:getChildByName("TIP")
    if not tipBG then
        tipBG = UI.Image9:create()
        tipBG:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(0, 0))
        tipBG:setName("TIP")
        self:addChild(tipBG, 10000)
    end
    tipBG:leftBottom(pos.x, pos.y)
    tipBG:setVisible(true)

    local content = tipBG:getChildByName("tipContent")
    if not content then
        content = UI.Text:create()
        content:setName("tipContent")
        content:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_190_190_190)
        content:leftUp(10, 10)
        content:setTextLeft()
        tipBG:addChild(content)
    end
    content:setText(text)
    local textW = content:getContentSize().width
    local textH = content:getContentSize().height
    if textW > 210 then
        content:setWidth(210)
        content:autoAdapt()
        textH = content:getContentSize().height
        tipBG:setSize(220, textH+20)
    else
        tipBG:setSize(textW+20, textH+20)
    end

    local tipArrow  = tipBG:getChildByName("tipArrow")
    if not tipArrow then
        tipArrow = UI.Image:create();
        tipArrow:setName("tipArrow")
        tipArrow:init("ui_information_banner_background2.png")
        tipBG:addChild(tipArrow)
    end
    if isRevert then
        tipArrow:setScaleX(-1)
        tipArrow:centerLeft(-9)
    else
        tipArrow:centerRight(-9)
    end

    tipBG:updateView()
    local w = tipBG:getContentSize().width
    local h = tipBG:getContentSize().height
    if isRevert then
        tipBG:leftBottom(pos.x+60, pos.y-h/2)
    else
        tipBG:leftBottom(pos.x-w-60, pos.y-h/2)
    end
end

function CaveExploringView:hideTip()
    local tip = self:getChildByName("TIP")
    if tip then
        tip:setVisible(false)
        -- self:removeChildByName("TIP")
    end
end


function CaveExploringView:clickClose()
    mvc.closePanel("CaveExploring", "CaveExploring")
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
end

function CaveExploringView:bindModel()

end

function CaveExploringView:unbindModel()

end


function CaveExploringView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
end


function CaveExploringView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
end





return CaveExploringView













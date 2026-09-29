-- BossDirectPanel.lua
-- Author:djh
-- 2022年02月21日
-- Using:boss直达
UI = UI or {}
local BossDirectPanel = class("BossDirectPanel", UI.CenterWin)
UI.BossDirectPanel = BossDirectPanel

local LanguageManager = require("app.game.LanguageManager")
local languageManagerInstance = LanguageManager:getInstance()

local size = cc.size(567, 415)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_dream_common.plist",
    "ui_gaming_bossdirect.plist",
}

--构造函数(必备)
function BossDirectPanel:ctor(spriteID, npcID)
    --窗口大小
    BossDirectPanel.super.ctor(self,UIType.MC_BATTLE_BOSS_DIRECT, COM_RES_LIST, size.width, size.height)
    self.spriteID = spriteID
    self.bossConfig = ConfigManager:getTriggerNpcConfigByID(npcID)
    self.jumpConfig = ConfigManager:getBossPortalConfig()
    self.canJump = nil

    -- self.taskData = {}
    -- if MasterDataManager:isHaveDreamData() then
    --     self.netData = dreamData.bossInfos[dreamData.curBossIndex]
    --     self.taskData = ConfigManager:getDreamTaskById(self.netData.challengeID) or {}
    --     local dreamConfig = ConfigManager:getDreamConfigForLV(dreamData.lv)
    --     self.costCoin = dreamConfig.coinCost
        
    -- else
    --      Net.NetRoleSystem:requestGetDreamInfo()
    -- end

    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_BOSS_DIRECT_UNLOCK, self, self.warpFailed)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_BOSS_DIRECT_CLOSEWIN, self, self.closeWin)
end

--虚构函数,destroy时调用(必备)
function BossDirectPanel:dtor()
    self.canJump = nil
    self.spriteID = nil
    self.bossConfig = nil
    self.jumpConfig = nil
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_BOSS_DIRECT_UNLOCK, self, self.warpFailed)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_BOSS_DIRECT_CLOSEWIN, self, self.closeWin)
    BossDirectPanel.super.dtor(self)
    -- reload_script_file("app.ui.shoplayer.BossDirectPanel")
end

-- 初始化(必备)
function BossDirectPanel:init()
    BossDirectPanel.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function BossDirectPanel:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_dreamword_paper_3.png")
    bg:center()
    self:addChild(bg)
  
    --title
    local title = UI.Text:create()
    title:init(UI.TEXT_221500, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_246_197_79)
    title:centerUp(35)
    bg:addChild(title)
    
    --content
    local conditionTitle = UI.Text:create()
    conditionTitle:init(UI.TEXT_221501, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_55_54_55)
    conditionTitle:centerUp(105)
    bg:addChild(conditionTitle)

    -- 内容面板
    local headLayout = UI.Layout:create()
    headLayout:init()
    headLayout:setSize(122, 122)
    headLayout:centerUp(127)
    -- contentLayout:enableDebugDraw()
    bg:addChild(headLayout)
    -- self.headLayout = headLayout
   
    -- boss头像背景
    local headBg = UI.Image:create()
    headBg:init("ui_bossdirect_box.png")
    -- headBg:centerUp(135)
    headBg:centerUp(14)
    headLayout:addChild(headBg)

    -- boss头像
    local head = UI.Image:create()
    head:init("")
    head:centerUp(27)
    headLayout:addChild(head)
    self.head = head

    -- boss名字背景
    local bossNameBg = UI.Image:create()
    bossNameBg:init("ui_bossdirect_bg.png")
    bossNameBg:centerUp(265)
    bg:addChild(bossNameBg)

    local bossName = UI.Text:create()
    bossName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_55_54_55)
    bossName:centerUp(263)
    bg:addChild(bossName)
    self.bossName = bossName

    -- 剩余次数
    local haveTimes = UI.Text:create()
    haveTimes:init(UI.TEXT_1325406, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_55_54_55)
    haveTimes:leftUp(339, 294)
    bg:addChild(haveTimes)

    -- 次数
    local times = UI.Text:create()
    times:init(string.format(UI.TEXT_1170023, 0, 10), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_55_54_55)
    times:leftUp(404, 294)
    bg:addChild(times)
    self.times = times

    --leftBtn
    local cancelBtn = UI.Button:create()
    cancelBtn:init("ui_btn_no1_0.png", "ui_btn_no1_2.png", "ui_btn_no1_2.png")
    cancelBtn:leftUp(130, 320)
    bg:addChild(cancelBtn)
    cancelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:closeWin()
    end)

    local okButton = UI.Button:create()
    okButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_2.png")
    okButton:leftUp(330, 320)
    bg:addChild(okButton)
    okButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:pickUpClick()
    end)
end

-- 模版函数：更新组建的视图(必备)
function BossDirectPanel:onUpdateView()
    local GameDataManager = require("app.game.GameDataManager")
    local GameMapManager = require("app.game.GameMapManager")
    local mapData = GameMapManager:getInstance():getMapData()
    local caveMode = mapData.caveMode
    local bossPortalData = MasterDataManager:getBossPortalUsedData()
    local jumpTimesList = string.split(self.jumpConfig, ";")
    local jumpTimes = nil
    for k, v in pairs(jumpTimesList)do 
        local jumpTimes1 = string.split(v, ",")
        if tonumber(jumpTimes1[1]) == caveMode then
            jumpTimes = jumpTimes1[2]
        end
    end
    
    local usedCount = bossPortalData[caveMode] and bossPortalData[caveMode].usedCount or 0
    local canJump = jumpTimes-usedCount >= 0 and jumpTimes-usedCount or 0
    self.canJump = canJump
    self.times:setText(string.format(UI.TEXT_1170023, canJump, jumpTimes))
    local extendString = string.split(self.bossConfig.extendString, ",")
    local headName = "icon_monsterhead_bossdirect_"..extendString[1]..".png"
    self.head:setSpriteName(headName)
    self.bossName:setText(languageManagerInstance:getLocalString(tonumber(extendString[2])))

    -- local maxLevel = self:getMaxLevel(caveMode, mapData.difficulty)
    -- print("maxLevel11:", caveMode, mapData.difficulty, maxLevel)
end

function BossDirectPanel:openShow()
    self:open()
end

function BossDirectPanel:pickUpClick()
    if self.canJump <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1213271)
        return
    else
        GameManager:sendCaveBossPortalFunction(self.spriteID)
    end
    
end

function BossDirectPanel:bossLevelCoverToGameLevel(level, caveMode)
    local maxLevel
    if caveMode == PublicDefine.CAVE_MODE.MODE_HERO or caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO  then
        -- 英雄模式最大层数为0
        maxLevel = 0
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then
        maxLevel = level%1000*10
    else
        maxLevel = level%1000*30
    end
    return maxLevel
end

function BossDirectPanel:getMaxLevel(caveMode, difficulty)
    local maxLevelArr = RoleDataManager:getMaxLevelArr() 
    for _, maxLevelData in pairs(maxLevelArr) do
        if maxLevelData:getMode() == caveMode and maxLevelData:getDifficulty() == difficulty then
            -- if caveMode == 4 then
            --     -- 针对英雄模式 服务器数据特殊处理
            --     print("getMaxLevel1",maxLevelData._maxLevel)
            --     dump(maxLevelData, "getMaxLevel")
            --     return maxLevelData._maxLevel > 30 and maxLevelData._maxLevel%30 or maxLevelData._maxLevel
                
            -- else
            --     return maxLevelData._maxLevel
            -- end
            return maxLevelData._maxLevel
            
        end
    end
end

function BossDirectPanel:checkIsUnlock()
    local GameMapManager = require("app.game.GameMapManager")
    local mapData = GameMapManager:getInstance():getMapData()
    local extendString = string.split(self.bossConfig.extendString, ",")
    local bossLevel = self:bossLevelCoverToGameLevel(extendString[3], mapData.caveMode)
    local maxLevel = self:getMaxLevel(mapData.caveMode, mapData.difficulty)
    -- print("checkIsUnlock1:", bossLevel, maxLevel, bossLevel <= maxLevel)
    return bossLevel <= maxLevel, extendString[4]
end

function BossDirectPanel:warpFailed()
    local extendString = string.split(self.bossConfig.extendString, ",")
    UI.ScrollBar:createByTextID(languageManagerInstance:getLocalString(tonumber(extendString[4])))
end
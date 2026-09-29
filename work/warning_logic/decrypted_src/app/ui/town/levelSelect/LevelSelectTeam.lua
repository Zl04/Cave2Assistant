-- LevelSelectTeam.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:关卡准备界面 

--   -- 1 邀请阶段 2 匹配确认阶段  mTeamType
require("utils.ObserverVariable")
require("app.net.NetTeamSystem")
require("app.datas.TeamDataManager")
require("app.ui.town.levelSelect.LevelSelectEventBtn")
require("app.ui.town.levelSelect.SpecialEventInfo")
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local SceneManager = require("app.game.SceneManager")

UI = UI or {}

local LevelSelectTeam = class("LevelSelectTeam", UI.HWBtnComponent)
UI.LevelSelectTeam = LevelSelectTeam

local winSize = cc.Director:getInstance():getWinSize()

local _width = 588
local _height = 356

-- 关卡难度选择资源
local COM_RES_LIST = {
    "ui_town_teammate.plist",
    "ui_town_levelselect.plist",
    "ui_town_guild_icon.plist",
}


function LevelSelectTeam:ctor(teamType)
    LevelSelectTeam.super.ctor(
    self,UIType.LEVEL_SELECT_TEAM,
    COM_RES_LIST,
    winSize.width,
    winSize.height
    )
    print("LevelSelectTeam:ctor(teamType)",teamType)
    self:setTouchEnable(true)
    -- print(debug.traceback())
    self.rootLayer = nil;       --root节点
    self.headList = {};
    self.mTime = TeamDataManager:getMatchTime() or (os.time() + PublicDefine.CONST_DEFINITION.COUNTDOWN_CANCEL_MATCH/1000);
    self.mSchedulerID = 0;
    self._lastDtTime = 0
    self.memberEventIconList = {}
    --  add by zp 确认如果弹出确认


    local scheduler = cc.Director:getInstance():getScheduler()
    self.mSchedulerID = scheduler:scheduleScriptFunc(handler(self,self.schedulerTimeOut), 0 ,false)
    LevelSelectUtil:getInstance():initTeamData(teamType);
    self:init();
    self:registerListener();
end


function LevelSelectTeam:dtor()
    -- print(debug.traceback())
    self:unRegisterListener();
    LevelSelectTeam.super.dtor(self)

    local scheduler=cc.Director:getInstance():getScheduler()
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end

    if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
        TeamDataManager:setIsMatching(false)
    end
    reload_script_file("app.ui.town.levelSelect.LevelSelectTeam")
end

function LevelSelectTeam:close()
    LevelSelectTeam.super.close(self)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
end

-- public:
-- 初始化
function LevelSelectTeam:init()
    LevelSelectTeam.super.init(self)
end

--请求立即进洞
function LevelSelectTeam:immediatelyGo()
    if TeamDataManager:getPunishmentState() >= 2 then
        UI.ScrollBar:createByText(string.format(UI.TEXT_110072, ConfigManager:getPunishmentTime() / 60))
        return
    end
    if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
        -- if not GameDataManager:judgeHaveDungeonKey(LevelSelectUtil:getInstance().mSelectLevel) then
        if not GameDataManager:judgeHaveDungeonKey(1) then -- 现在只有1级钥匙
            UI.ScrollBar:createByText(UI.TEXT_120001)
            return
        end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then
            UI.ScrollBar:createByText(UI.TEXT_120001)
            return
        end

        if LevelSelectUtil:getInstance().mUseSpecialEvent then 
            if MasterDataManager:getHeroCaveSchemeExploreCount() <= 0 then
                UI.ScrollBar:createByText(UI.TEXT_1212058)
                return
            end
        end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
         if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) then
            UI.ScrollBar:createByText(UI.TEXT_120001)
            return
        end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
         if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace) then
            UI.ScrollBar:createByText(UI.TEXT_120001)
            return
        end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
         if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno) then
            UI.ScrollBar:createByText(UI.TEXT_120001)
            return
        end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) then
           UI.ScrollBar:createByText(UI.TEXT_120001)
           return
       end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking) then
           UI.ScrollBar:createByText(UI.TEXT_120001)
           return
       end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_EverWinterRift) then
           UI.ScrollBar:createByText(UI.TEXT_120001)
           return
       end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) then
           UI.ScrollBar:createByText(UI.TEXT_120001)
           return
       end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then
            UI.ScrollBar:createByText(UI.TEXT_120001)
            return
        end

        if LevelSelectUtil:getInstance().mUseSpecialEvent then 
            if MasterDataManager:getTitanHeroCaveSchemeExploreCount() <= 0 then
                UI.ScrollBar:createByText(UI.TEXT_1212058)
                return
            end
        end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) then
           UI.ScrollBar:createByText(UI.TEXT_120001)
           return
       end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS) then
           UI.ScrollBar:createByText(UI.TEXT_120001)
           return
       end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Wromhole) then
           UI.ScrollBar:createByText(UI.TEXT_120001)
           return
       end
    else
        local checkpointData = RoleDataManager:getCheckpointData(LevelSelectUtil:getInstance().mCaveMode,LevelSelectUtil:getInstance().mDifficulty:get())
        if checkpointData:getCheckpoint() == nil or  LevelSelectUtil:getInstance().mSelectLevel > checkpointData:getCheckpoint() then
            UI.ScrollBar:createByText(UI.TEXT_120001)
            return
        end
    end

    if LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_DUNGEON then
        if not TeamDataManager:hasTeam() then
            Net.NetTeamSystem:createTeam(
                LevelSelectUtil:getInstance().mCaveMode,
                LevelSelectUtil:getInstance().mDifficulty:get(),
                LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(LevelSelectUtil:getInstance().mSelectLevel))
        end
    else
        if not TeamDataManager:hasTeam() then
            Net.NetTeamSystem:createTeam(
                LevelSelectUtil:getInstance().mCaveMode,
                LevelSelectUtil:getInstance().mDifficulty:get(),
                LevelSelectUtil:getInstance().mSelectLevel)
        end
    end
    Net.NetTeamSystem:requestImmediatelyGo()
    self.mBtnOK:setVisible(false)
    self.mBtnOK:disable()
    self.mImmediatelyGo:setVisible(false)
    self.mImmediatelyGo:disable()
    self:_close()
end

function LevelSelectTeam:onOK()

    if TeamDataManager:getPunishmentState() >= 2 then
        UI.ScrollBar:createByText(string.format(UI.TEXT_110072, ConfigManager:getPunishmentTime() / 60))
        return
    end

    if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
        if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
            -- if not GameDataManager:judgeHaveDungeonKey(LevelSelectUtil:getInstance().mSelectLevel) then
            if not GameDataManager:judgeHaveDungeonKey(1) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_HERO then
             if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_EverWinterRift) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then
            if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Wromhole) then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        else
            local checkpointData = RoleDataManager:getCheckpointData(LevelSelectUtil:getInstance().mCaveMode,LevelSelectUtil:getInstance().mDifficulty:get())
            if checkpointData:getCheckpoint() == nil or  LevelSelectUtil:getInstance().mSelectLevel > checkpointData:getCheckpoint() then
                UI.ScrollBar:createByText(UI.TEXT_120001)
                return
            end
        end

        for k,v in pairs(TeamDataManager:getReadyTeamData()) do
            local teamData = v
            if teamData and teamData.onlineState ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
               UI.ScrollBar:createByText(string.format(UI.TEXT_111107,teamData.name))
               return
            end
        end

        if LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_DUNGEON then
            if not TeamDataManager:hasTeam() then
                Net.NetTeamSystem:createTeam(
                    LevelSelectUtil:getInstance().mCaveMode,
                    LevelSelectUtil:getInstance().mDifficulty:get(),
                    LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(LevelSelectUtil:getInstance().mSelectLevel))
            end
        else
            if not TeamDataManager:hasTeam() then
                Net.NetTeamSystem:createTeam(
                    LevelSelectUtil:getInstance().mCaveMode,
                    LevelSelectUtil:getInstance().mDifficulty:get(),
                    LevelSelectUtil:getInstance().mSelectLevel)
            end
        end
        Net.NetTeamSystem:requestMatch()
    else
        if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
            local keyData = GoodsDataManager:getGoodsData(PublicDefine.PACKET_TYPE.PACKET_BAG, DUNGEON_ITEM_KEY, false, 0)
            if keyData == nil or keyData:getIsLock() then
                UI.ScrollBar:createByTextID(1170265)
                return
            end
        end
        Net.NetTeamSystem:requestConfirmMatch(LevelSelectUtil:getInstance().mConfirmID)
    end
    self.mBtnOK:setVisible(false)
    self.mBtnOK:disable()
    self.mImmediatelyGo:setVisible(false)
    self.mImmediatelyGo:disable()
    for k,v in pairs(self.headList) do
        v:getChildByName("close"):setVisible(false)
    end
end

function LevelSelectTeam:onChanel(obj)
    print("LevelSelectTeam:onChanel",obj:getTag())
    local index = obj:getTag()
    local teamData = TeamDataManager:getReadyTeamData()[index]
    if teamData ~= nil then
        if teamData.pk == RoleDataManager:getMasterPK() then
            if TeamDataManager:hasTeam() then
                Net.NetTeamSystem:leaveTeam(RoleDataManager:getMasterPK(),TeamDataManager:getTeamID())
            end 

            self:_close()
        else
            --踢人
            Net.NetTeamSystem:kickTeam(teamData.pk)
        end
    end
end


-- function LevelSelectTeam:onAdd(obj)
--     print("LevelSelectTeam:onAdd")
--     print(obj:getTag())
-- end

--创建头像
function LevelSelectTeam:createHead(index)
    
    local headBG = UI.Layout:create()
    headBG:init()
    headBG:setSize(171, 196)
    headBG:setTag(index)
  
    local bg = UI.Image:create()
    bg:init("ui_team_banner_portrait_01.png")
    bg:center()
    headBG:addChild(bg, 10)
    bg:setName("BG")

    local picIconBG = UI.Image:create()
    picIconBG:init("ui_team_banner_mystery.png")
    picIconBG:centerUp(60)
    picIconBG:setName("icon")
    headBG:addChild(picIconBG,5)

    local btnClose = UI.Button:create()
    btnClose:init("ui_btn_team_close_0.png","ui_btn_team_close_1.png")
    btnClose:rightUp(8, 5)
    btnClose:setName("close")
    headBG:addChild(btnClose, 10)
    btnClose:setTag(index + 1)
    btnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.onChanel)

    local picReady = UI.Image:create()
    picReady:init("ui_btn_team_hook_1.png")
    picReady:rightUp(8, 5)
    picReady:setName("ready")
    headBG:addChild(picReady, 10)

    local laName = UI.Text:create()
    laName:init("name"..index, UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    laName:setName("name")
    laName:centerUp(152)
    headBG:addChild(laName, 10)

    if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
        picReady:setVisible(false)
    else
        btnClose:setVisible(false)
    end
    table.insert(self.headList,headBG)
    return headBG
end

--刷新队伍状态
function LevelSelectTeam:refreshTeamData(newData,oldData)
    print("LevelSelectTeam:refreshTeamData")
    -- dump(TeamDataManager:getTeamData(), "------------TeamDataManager:getTeamData()")
    if self.tips ~= nil then
        self.tips:hide()
    end
    local captainPK
    for i = 1,3 do
        local teamData = TeamDataManager:getReadyTeamData()[i]
        if teamData and teamData.captain == true then
            captainPK = teamData.pk
            break
        end
    end

    local isFull = true
    for i = 1,3 do
        local teamData = TeamDataManager:getReadyTeamData()[i]
        if teamData == nil then
            isFull = false
        end
    end

    if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
        if RoleDataManager:getMasterPK() == captainPK or (not TeamDataManager:hasTeam()) then
            if isFull then
                self.mBtnOK:disable()
                self.mBtnOK:hide()
                self.mBtnOK:leftBottom(winSize.width, 12)
                self.mImmediatelyGo:centerBottom(12)
                self.mImmediatelyGo:enable()
            else
                self.mBtnOK:leftBottom(60, 12)
                self.mImmediatelyGo:leftBottom(327, 12)
                self.mBtnOK:setVisible(true)
                self.mBtnOK:enable()
                self.mImmediatelyGo:setVisible(true)
                self.mImmediatelyGo:enable()
            end
        else
            self.mBtnOK:setVisible(false)
            self.mBtnOK:disable()
            self.mImmediatelyGo:setVisible(false)
            self.mImmediatelyGo:disable()
        end
    end

    -- dump(debug.traceback())
    -- dump(TeamDataManager:getReadyTeamData())
    -- dump(newData)
    -- dump(oldData)
    local change = false
    for i = 1,3 do
        local teamData = TeamDataManager:getReadyTeamData()[i]
        if newData ~= nil and oldData ~= nil and newData[i] ~= nil and oldData[i] ~= nil and newData[i].pk == oldData[i].pk and newData[i].captain ~= oldData[i].captain then

        else
            local headBG = self.headList[i]
            local laName = headBG:getChildByName("name")
            if headBG:getChildByName("specialIcon") ~= nil then
                headBG:removeChildByName("specialIcon")
            end
            if teamData then
                -- print("@@@@@@@@@",i)
                change = true
                laName:setVisible(true)
                if teamData.pk == RoleDataManager:getMasterPK() then
                    laName:setText(RoleDataManager:getMaster():getNickName())
                else
                    laName:setText(teamData.name)
                end
  
                
                local heorIcon = headBG:getChildByName("heorIcon")
                if heorIcon then
                    
                    if headBG.teamData and headBG.teamData.sex == teamData.sex and headBG.teamData.faceDecodeID == teamData.faceDecodeID then

                    else
                        headBG:removeChildByName("heorIcon", true)
                        local headID = {}
                        Avalon.WidgetUtil:getHeadByData(self,teamData.sex,teamData.faceDecodeID,headID,headBG,handler(headBG,function(headBG,pic)
                            if headBG and not tolua.isnull(headBG) then
                                headBG:removeChildByName("heorIcon", true)
                                pic:setPosition(85, 113)
                                pic:setName("heorIcon")

                                headBG:addChild(pic,5)
                                if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
                                    if teamData.onlineState ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                                        local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
                                        if (shader) then
                                            pic:getChildByName("pic"):setGLProgramState(shader)
                                        end
                                    end
                                end
                            end
                        end))
                    end
                else
                    local headID = {}
                    Avalon.WidgetUtil:getHeadByData(self,teamData.sex,teamData.faceDecodeID,headID,headBG,handler(headBG,function(headBG,pic)
                        if headBG and not tolua.isnull(headBG) then
                            headBG:removeChildByName("heorIcon", true)
                            pic:setPosition(85, 113)
                            pic:setName("heorIcon")

                            headBG:addChild(pic,5)
                            if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
                                if teamData.onlineState ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                                    local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
                                    if (shader) then
                                        pic:getChildByName("pic"):setGLProgramState(shader)
                                    end
                                end
                            end
                        end
                    end))
                end
                headBG.teamData = teamData
                -- end
                if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
                    if teamData.pk == RoleDataManager:getMasterPK() or captainPK == RoleDataManager:getMasterPK() then
                        headBG:getChildByName("close"):setVisible(true)
                    else
                        headBG:getChildByName("close"):setVisible(false)
                    end
                    -- headBG:getChildByName("close"):setVisible(true)
                else
                    if teamData.state == false then
                        headBG:getChildByName("ready"):setVisible(false)
                        if teamData.pk == RoleDataManager:getMasterPK() then
                            self.mBtnOK:setVisible(true)
                            self.mBtnOK:enable()
                            self.mImmediatelyGo:setVisible(true)
                            self.mImmediatelyGo:enable()
                        end
                    else
                        headBG:getChildByName("ready"):setVisible(true)
                        if teamData.pk == RoleDataManager:getMasterPK() then
                            self.mBtnOK:setVisible(false)
                            self.mBtnOK:disable()
                            self.mImmediatelyGo:setVisible(false)
                            self.mImmediatelyGo:disable()
                        end
                    end
                end
                headBG:getChildByName("icon"):setVisible(false)
                local eventIcon = self:refreshMemberSpecialEvent(headBG, teamData)
                self.memberEventIconList[teamData.pk] = eventIcon
            else
                laName:setVisible(false)
                headBG:removeChildByName("heorIcon", true)
                -- headBG:getChildByName("add"):setVisible(true)
                headBG:getChildByName("ready"):setVisible(false)
                headBG:getChildByName("close"):setVisible(false)
                headBG:getChildByName("icon"):setVisible(true)
                local bg = headBG:getChildByName("BG")
                bg:setSpriteName("ui_team_banner_portrait_01.png")
            end
        end
    end
    self:checkAndRefreshGuildBuf()
    if change then
        self:refreshBingoSpecialEvent()
    end
end

function LevelSelectTeam:checkAndRefreshGuildBuf()
    local guildData = MasterDataManager:getGuildData()
    local selfGuildId = 0
    if guildData ~= nil then
        selfGuildId = guildData:getID()
    end
    local CAVE_MODE = PublicDefine.CAVE_MODE
    local caveMode = LevelSelectUtil:getInstance().mCaveMode
    local sameGuildNum,sameGuildId, buffID = TeamDataManager:getSameGuildBuf()  
    if sameGuildNum <= 1 or selfGuildId ~= sameGuildId or (caveMode ~= CAVE_MODE.MODE_NORMAL and caveMode ~= CAVE_MODE.MODE_HERO
        and caveMode ~= CAVE_MODE.MODE_DESERT_EYES 
        and caveMode ~= CAVE_MODE.MODE_DISTORTED_SPACE
        and caveMode ~= CAVE_MODE.MODE_INFERNO
        and caveMode ~= CAVE_MODE.MODE_VOID_RIFT
        and caveMode ~= CAVE_MODE.MODE_VIKING
        and caveMode ~= CAVE_MODE.MODE_EVER_WINTER_RIFT
        and caveMode ~= CAVE_MODE.MODE_TITAN_ROAD
        and caveMode ~= CAVE_MODE.MODE_TITAN_ROAD_HERO
        and caveMode ~= CAVE_MODE.MODE_DRIED_SPRING 
        and caveMode ~= CAVE_MODE.MODE_CHAOS
        and caveMode ~= CAVE_MODE.MODE_WORMHOLE) then
        for k, v in ipairs(self.headList) do
            if v:getChildByName("BG") then
                v:getChildByName("BG"):setSpriteName("ui_team_banner_portrait_01.png")
            end
        end
        local guildLogo = self.rootLayer:getChildByName("GuildLogo")
        if guildLogo then
            guildLogo:hide()
        end
    else
        local teamDataList = TeamDataManager:getReadyTeamData()
        for k, v in ipairs(teamDataList) do
            local headBG = self.headList[k]
            local bg = headBG:getChildByName("BG")
            if bg then
                if sameGuildId == v.guildID then
                    bg:setSpriteName("ui_team_banner_portrait_guild_01.png")
                else
                    bg:setSpriteName("ui_team_banner_portrait_01.png")
                end
            end
        end
        local guildLogo = self.rootLayer:getChildByName("GuildLogo")
        if guildLogo then
            guildLogo:show()
        else
            guildLogo = UI.Animation:create()
            guildLogo:init("effect_ui_general_guild_zudui.json", "effect_ui_general_guild_zudui.atlas")
            guildLogo:centerUp(-9)
            guildLogo:setName("GuildLogo")
            self.rootLayer:addChild(guildLogo, 100)
        end
        guildLogo:setAnimation("begin", false)
        guildLogo:addAnimation("idle", true)

        local iconList = ConfigManager:getGuildIconList()
        if guildData then
            for k, v in pairs(iconList) do
                if(guildData:getIconID() == tonumber(v.iconID)) then
                    local logo = UI.Image:create()
                    logo:init(v.iconSpriteName)
                    logo:center(0,-14)
                    logo:setScale(0.60)
                    guildLogo:addComponent("ui-guild-zudui-dijie", logo, true)
                    logo:setTouchEnable(true)
                    logo:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
                        self:guildBufClick(buffID)
                    end)
                    logo:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
                        if (not tolua.isnull(self.bufPanel)) then
                            self.bufPanel:removeFromParent(true)
                            self.bufPanel = nil
                        end
                    end)
                end
            end
        end
    end
end

function LevelSelectTeam:guildBufClick(buffId)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(283, 154)
    layout:leftBottom(332, 247)
    self.rootLayer:addChild(layout, 200)
    self.bufPanel = layout

    local bg =  UI.Image9:create()
    bg:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(273, 154))
    bg:leftUp(10, 0)
    layout:addChild(bg)

    local arrow =  UI.Image:create()
    arrow:init("ui_information_banner_background2.png")
    arrow:leftUp(1, 10)
    layout:addChild(arrow)
    arrow:setScaleX(-1)

    local title = UI.Text:create()
    title:init(UI.TEXT_1170720, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_190_190_190)
    title:leftUp(28, 18)
    layout:addChild(title)

    local line = UI.Image9:create()
    line:init("ui_scale9image_banner_line_light3.png", CCRectMake(0,0,20,20), cc.size(238, 1))
    line:leftUp(28, 40)
    layout:addChild(line)
    local height = 20
    if buffId ~= 0 and buffId ~= nil then
        local bufferData = SkillDataManager:createBufferData(buffId)
        local desc = UI.Text:create()
        desc:init(bufferData.description, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_190_190_190)
        desc:setWidth(245)
        desc:autoAdapt()
        desc:leftUp(28, 55)
        layout:addChild(desc)
        height = height + desc:getContentSize().height
    end
    bg:setSize(273, 55 + height)
end
--找出积分最高的最小pk和最大pk，若最小pk为基数则用最小pk的事件，否则使用最大pk的事件
function LevelSelectTeam:getBingoSpecialEvent()
    local list = TeamDataManager:getReadyTeamData()
    local maxScore = 0
    for k, v in pairs(list) do
        if v.schemeScore == nil then
            v.schemeScore = ConfigManager:getScoreForEventList(v.schemeIDs)
        end
        if v.schemeScore > maxScore then
            maxScore = v.schemeScore
        end 
       
    end
    local bingoData = nil
    local bingoMaxList = {}
    local pkMinData = nil
    for k, v in pairs(list) do
        if v.schemeScore >= maxScore then
            table.insert(bingoMaxList, v)
            if pkMinData == nil then
                pkMinData = v
            else
                if pkMinData.pk > v.pk then
                    pkMinData = v
                end
            end
        end 
    end
    if #bingoMaxList == 1 then
        bingoData = bingoMaxList[1]
    end
    if pkMinData == nil then
        return
    end
    if pkMinData.pk % 2 == 1 then
        bingoData = pkMinData
    else
        local pkMaxData = pkMinData
        for k, v in ipairs(bingoMaxList) do
            if pkMaxData.pk < v.pk then
                pkMaxData = v
            end
        end
        bingoData = pkMaxData
    end
    return bingoData
end

function LevelSelectTeam:refreshBingoSpecialEvent()
    self.psTips:hide()
    if LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_HERO or 
        LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        return
    end
    local bingoData = self:getBingoSpecialEvent()

    local eventBtn, boxImgData = self:refreshMemberSpecialEvent(nil, bingoData, true)
    local memberEventIcon = self.memberEventIconList[bingoData.pk]
    if memberEventIcon then
        memberEventIcon:addBoxBg(boxImgData.normal, boxImgData.open, false, true)
    end
    
    local isRefreshInfo = false
    if self.specialEventInfo ~= nil and not tolua.isnull(self.specialEventInfo) then
        self.specialEventInfo:removeInfoArea()
        self.specialEventInfo:removeFromParent()
        self.specialEventInfo = nil
        isRefreshInfo = true
    end

    if eventBtn then
        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
            self.psTips:show()
        else
            self.psTips:hide()
        end
        local oldEventBtn = self.rootLayer:getChildByName("specialIcon")
        if oldEventBtn ~= nil then
            if self.upgradeAction == nil then
                local upgradeAction = UI.Animation:create()
                upgradeAction:init("effect_ui_town_selectfloor_special_event_grade.json", "effect_ui_town_selectfloor_special_event_grade.atlas")
                upgradeAction:leftUp(40, 16)
                self.rootLayer:addChild(upgradeAction, 100)
                self.upgradeAction = upgradeAction
                self.upgradeAction:setAnimation("up",true)
            end

            if eventBtn:getTag() > oldEventBtn:getTag() then
                self.upgradeAction:show()
                self.upgradeAction:setAnimation("up",true)
            elseif eventBtn:getTag() < oldEventBtn:getTag() then
                self.upgradeAction:show()
                self.upgradeAction:setAnimation("down",true)
            else
                self.upgradeAction:hide()
            end
            oldEventBtn:removeFromParent()
        end

        self.rootLayer:addChild(eventBtn)
        eventBtn:leftUp(-20, -20)
        if self.tips == nil then
            local tips = UI.Text:create()
            tips:init(UI.TEXT_1212225, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
            tips:leftUp(45, 15)
            self.rootLayer:addChild(tips)
            self.tips = tips
        else
            self.tips:show()
        end

        if isRefreshInfo then
            local gateConfig = LevelSelectUtil:getInstance():getLevelGateConfig()
            local schemeScore = ConfigManager:getScoreForEventList(bingoData.schemeIDs)
            local boxLevel = ConfigManager:getEventBoxLevelByScore(schemeScore)
            local goodsDataList = self:getRewardList(gateConfig, boxLevel)
            self:showRewardLayer(bingoData, goodsDataList)
        end
    end
end

--isUsed 是否显示 在左上角启用中的地方
function LevelSelectTeam:refreshMemberSpecialEvent(node, teamData, isUsed)
    if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_HERO or 
        LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        local gateConfig = LevelSelectUtil:getInstance():getLevelGateConfig()
        if gateConfig ~= nil and #teamData.schemeIDs > 0 then
            local schemeScore = ConfigManager:getScoreForEventList(teamData.schemeIDs)
            local boxLevel = ConfigManager:getEventBoxLevelByScore(schemeScore)
            local goodsDataList = self:getRewardList(gateConfig, boxLevel)
            local eventBtn = UI.LevelSelectEventBtn:create()
            eventBtn:setName("specialIcon")
            eventBtn:init()
            eventBtn:leftUp(-18, -20)
            eventBtn:setSize(90, 90)
            eventBtn:setScale(0.68)
            eventBtn:setClickCallback(function()
                self:showRewardLayer(teamData, goodsDataList)
            end)
            eventBtn:setTag(boxLevel)
            local boxImgData = Game.SpecialBoxImageName[boxLevel]
            if not isUsed then
                eventBtn:addBoxBg(boxImgData.normal, boxImgData.open)
                node:addChild(eventBtn, 10)
            else
                eventBtn:addBoxBg(boxImgData.normal, boxImgData.open, false, true)
            end
            return eventBtn, boxImgData
        end
    end
end
function LevelSelectTeam:getRewardList(gateConfig, boxLevel)
    local rewardData = nil
    if boxLevel == 1 then
        rewardData = gateConfig.BoxDrop1[1]
    elseif boxLevel == 2 then
        rewardData = gateConfig.BoxDrop2[1]
    elseif boxLevel == 3 then
        rewardData = gateConfig.BoxDrop3[1]
    end
    local goodsDataList = {}
    if rewardData then
        local idList = string.split(rewardData, ",")
        for k, v in pairs(idList) do
            table.insert(goodsDataList, tonumber(v))
        end
    end
    return goodsDataList
end

function LevelSelectTeam:showRewardLayer(teamData, goodsDataList)
    if self.specialEventInfo ~= nil and not tolua.isnull(self.specialEventInfo) then
        self.specialEventInfo:removeFromParent()
    end
    local specialEventInfo = UI.SpecialEventInfo:create()
    specialEventInfo:init(teamData, goodsDataList)
    specialEventInfo:centerLeft(-specialEventInfo:getContentSize().width)
    self.specialEventInfo = specialEventInfo
    self.rootLayer:addChild(specialEventInfo)
end

-- 模版函数：初始化组建的视图
function LevelSelectTeam:onInitView()
    -- self:addColorBG()

    self.rootLayer = UI.Layout:create();
    self.rootLayer:init()
    self.rootLayer:setSize(_width,_height)
    self.rootLayer:center()
    self:addChild(self.rootLayer, 5)
    self.rootLayer:showLucencyLight(_width, _height)

    if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
        require ("app.ui.social.friends.FriendsLayer")
        local pLevelSelectAddTeamRole = UI.FriendsLayer:create(0, UI.FRIEND_LAYER_SHOW_MODEL.TEAM)
        pLevelSelectAddTeamRole:centerRight(0)
        pLevelSelectAddTeamRole:setName("LevelSelectAddTeamRole")
        self:addChild(pLevelSelectAddTeamRole, 1);
        self.pLevelSelectAddTeamRole = pLevelSelectAddTeamRole;
        self.pLevelSelectAddTeamRole:showLayer()
        -- 获取装备和角色数据
    else 
        -- 组队成功提示
        print("LevelSelectTeam:onInitView() playsound 1527")
        Avalon.AudioManager:playSound("1527")
    end
end


function LevelSelectTeam:schedulerTimeOut()
    local cutTime = 0
    local currentTime = AvalonUtil.getCurrentTime()
    if self._lastDtTime == 0 then
        cutTime = 0
    else
        cutTime = currentTime - self._lastDtTime 
    end
    self._lastDtTime = currentTime

    self.mTime = self.mTime - cutTime / 1000;
    if self.mTxtPro then
        local showTime = math.floor(self.mTime)
        if showTime <= 0 then
            showTime = 0 
        end
        self.mTxtPro:setText(showTime.."s")
    end
    if(self.mTime <= 0) then
        local scheduler=cc.Director:getInstance():getScheduler()
        if self.mSchedulerID ~= 0 then
            scheduler:unscheduleScriptEntry(self.mSchedulerID)
        end
    end
end


function LevelSelectTeam:timeOutCallBack()
    print("time out");
end


-- 模版函数：更新组建的视图
function LevelSelectTeam:onUpdateView()
    
    -- 创建背景
    local picBg = UI.Image:create()
    picBg:init("ui_team_banner_board.png")
    picBg:center()
    self.rootLayer:addChild(picBg)
    
    --立即开始
    self.mImmediatelyGo = UI.Button:create()
    self.mImmediatelyGo:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    self.rootLayer:addChild(self.mImmediatelyGo)
    self.mImmediatelyGo:addEventListener(UIEvent.BUTTON_CLICK,self,self.immediatelyGo)
    self.mImmediatelyGo:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self.mImmediatelyGo:setText(UI.TEXT_1212050)

    self.psTips = UI.Text:create()
    self.psTips:init(UI.TEXT_1212226, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
    self.psTips:centerBottom(75)
    self.rootLayer:addChild(self.psTips)
    self.psTips:hide()
    --准备
    self.mBtnOK = UI.Button:create()
    self.mBtnOK:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    self.rootLayer:addChild(self.mBtnOK)
    self.mBtnOK:addEventListener(UIEvent.BUTTON_CLICK,self,self.onOK)
    self.mBtnOK:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self.mBtnOK:setText(UI.TEXT_110011)

    local tittle = ""
    if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
        tittle = string.format(UI.TEXT_110102,
                LevelSelectUtil:getInstance():getDifficultyText(LevelSelectUtil:getInstance().mDifficulty:get()),
                LevelSelectUtil:getInstance().mSelectLevel)
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        local level = LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(LevelSelectUtil:getInstance().mSelectLevel)
        if LevelSelectUtil:getInstance().mUseSpecialEvent then
            tittle = string.format("%s:%s",
                UI.TEXT_1212059,
                ConfigManager:getHeroCaveNameByLevel(level, PublicDefine.CAVE_MODE.MODE_HERO))
        else
            tittle = string.format("%s:%s",
                UI.TEXT_1212070,
                ConfigManager:getHeroCaveNameByLevel(level, PublicDefine.CAVE_MODE.MODE_HERO))
        end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
        tittle = string.format(UI.TEXT_1212802,
                        LevelSelectUtil:getInstance().mSelectLevel)
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
        tittle = string.format(UI.TEXT_1212804,
                        LevelSelectUtil:getInstance().mSelectLevel)
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
        tittle = string.format(UI.TEXT_1325501,
                        LevelSelectUtil:getInstance().mSelectLevel)
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
        tittle = string.format(UI.TEXT_222111,
                        LevelSelectUtil:getInstance().mSelectLevel)
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
        tittle = string.format(UI.TEXT_223811,
                        LevelSelectUtil:getInstance().mSelectLevel)  
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT then
        local level = math.ceil(LevelSelectUtil:getInstance().mSelectLevel % 10)
        tittle = string.format(UI.TEXT_224207, level)  
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
        tittle = string.format(UI.TEXT_224402,
                        LevelSelectUtil:getInstance().mSelectLevel)           
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        local level = LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(LevelSelectUtil:getInstance().mSelectLevel)
        if LevelSelectUtil:getInstance().mUseSpecialEvent then
            tittle = string.format("%s:%s",
                UI.TEXT_1212059,
                ConfigManager:getHeroCaveNameByLevel(level, PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO))
        else
            tittle = string.format("%s:%s",
                UI.TEXT_1212070,
                ConfigManager:getHeroCaveNameByLevel(level, PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO))
        end
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        tittle = string.format(UI.TEXT_225001,
                        LevelSelectUtil:getInstance().mSelectLevel)
        elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then

            local difficulty = LevelSelectUtil:getInstance().mDifficulty:get()
            if difficulty > 1 then
                local chooseLevel = 1
                local curOpenEliteLevel = LevelSelectUtil:getInstance().mSelectLevel
                local stageList = string.split(ConfigManager:getGeneralForKey("levelSegmentationClient2"), ";")
                for k,v in ipairs(stageList) do
                    local sLevel = tonumber(v)
                    if curOpenEliteLevel > sLevel and chooseLevel < k + 1 then
                        chooseLevel = k + 1
                    end
                end

                local selectExtraPara = mvc.chaosWormholeModel.selectExtraPara or 1
                if chooseLevel < mvc.chaosWormholeModel.selectExtraPara then
                    chooseLevel = selectExtraPara
                end

                tittle = string.format(UI.TEXT_226504, chooseLevel)

            else
                tittle = string.format(UI.TEXT_226501, LevelSelectUtil:getInstance().mSelectLevel) 
            end

    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_WORMHOLE then
        local level = math.ceil(LevelSelectUtil:getInstance().mSelectLevel % 10)
        tittle = string.format(UI.TEXT_227201, level)   
    else
        tittle = string.format(UI.TEXT_110071,
                        LevelSelectUtil:getInstance().mSelectLevel)
    end
    local txtTittle = UI.Text:create()
    txtTittle:init(tittle,  UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    txtTittle:centerUp(8)
    self.rootLayer:addChild(txtTittle,100)

    if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
        self.mBtnOK:setText(UI.TEXT_110103)
        self.mBtnOK:leftBottom(60, 12)
        self.mImmediatelyGo:leftBottom(327, 12)
        self.mImmediatelyGo:show()
        self.mImmediatelyGo:enable()
    else
        self.mBtnOK:setText(UI.TEXT_110011)
        self.mBtnOK:centerBottom(12)
        self.mImmediatelyGo:leftBottom(winSize.width, 12)
        self.mImmediatelyGo:hide()
        self.mImmediatelyGo:disable()
        
    end

    for i = 0,2 do
        local headBg = self:createHead(i)
        headBg:leftUp(27 + i  * 180, 58)
        self.rootLayer:addChild(headBg)
    end

    self:refreshTeamData()


    if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
        -- 进度条背景
        local proBG = cc.Sprite:createWithSpriteFrameName("ui_information_banner_countdown_box.png")
        proBG:setPosition(290, 86)
        self.rootLayer:addChild(proBG)

        self._pro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_information_banner_countdown.png"))
        self._pro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        self._pro:setMidpoint(cc.p(0,0))
        self._pro:setBarChangeRate(cc.p(1,0))
        self._pro:setPosition(cc.p(proBG:getContentSize().width/2, proBG:getContentSize().height/2))
        proBG:addChild(self._pro,20)
        local time = TeamDataManager:getMatchTime() / (PublicDefine.CONST_DEFINITION.COUNTDOWN_CANCEL_MATCH / 1000)
        self._pro:setPercentage(time * 100)
        local to1 = cc.ProgressTo:create(TeamDataManager:getMatchTime(),0)
        self._pro:runAction(to1)

        self.mTxtPro = UI.Text:create()
        self.mTxtPro:init((TeamDataManager:getMatchTime()).."s", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_247_202)
        proBG:addChild(self.mTxtPro,100)
        self.mTxtPro:center()
    end
end

function LevelSelectTeam:refreshTeam()
    print("LevelSelectTeam:refreshTeam")
    if TeamDataManager:hasTeam() then
        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
            LevelSelectUtil:getInstance():initTeamData(TEAM_STATE.MATCHING);
        end
    else
        self:_close()
    end
end

function LevelSelectTeam:_close()
    print("LevelSelectTeam:_close")
    if LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_DUNGEON then
        self:close()
    else
        GameManager:centerToMap()
        GameManager:hideNPCInfomation(self.spriteID)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER,function()
            print("LevelSelectTeam:_close,111")
            if self and (not tolua.isnull(self)) and self.close ~= nil then
                self:close()
            end
        end)
    end
end


function LevelSelectTeam:updateOnLineState(pk,online)
    if LevelSelectUtil:getInstance().mTeamType ~= TEAM_STATE.MATCHING then
        return
    end
    for i = 1,3 do
        local teamData = TeamDataManager:getReadyTeamData()[i]
        if teamData and teamData.pk == pk then
            local headBG = self.headList[i]
            local heorIcon = headBG:getChildByName("heorIcon")
            if heorIcon then
                if online ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                    local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
                    if (shader) then
                        heorIcon:getChildByName("pic"):setGLProgramState(shader)
                    end
                else
                    local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER)
                    if (shader) then
                        heorIcon:getChildByName("pic"):setGLProgramState(shader)
                    end
                end
                teamData.onlineState = online
            end
        end
    end
end

--队长改变
function LevelSelectTeam:updateCaptainChange(pk)
    if LevelSelectUtil:getInstance().mTeamType ~= TEAM_STATE.MATCHING then
        return
    end

    local captainPK = pk

    if RoleDataManager:getMasterPK() == captainPK or (not TeamDataManager:hasTeam()) then
        self.mBtnOK:setVisible(true)
        self.mBtnOK:enable()
        self.mImmediatelyGo:setVisible(true)
        self.mImmediatelyGo:enable()
    else
        self.mBtnOK:setVisible(false)
        self.mBtnOK:disable()
        self.mImmediatelyGo:setVisible(false)
        self.mImmediatelyGo:disable()
    end


    for i = 1,3 do
        local teamData = TeamDataManager:getReadyTeamData()[i]
        if teamData and teamData.pk == pk then
            local headBG = self.headList[i]
            if headBG then
                if teamData.pk == RoleDataManager:getMasterPK() or captainPK == RoleDataManager:getMasterPK() then
                    headBG:getChildByName("close"):setVisible(true)
                else
                    headBG:getChildByName("close"):setVisible(false)
                end
            end
        end
    end
end

-- 注册监听事件
function LevelSelectTeam:registerListener()
    ObserverVariable:addListener(TeamDataManager._readyTeamData,self,self.refreshTeamData)

    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_SEARCH_MATCH, self, self._close)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self._close)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_ALL_CONFIRM, self, self._close)

    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_JOIN, self, self.refreshTeam)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_LEAVE, self, self.refreshTeam)


    --更改队伍在线状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_UPDATE_ONLINE, self, self.updateOnLineState)

    --队长改变
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_CAPTAIN_CHANGE, self, self.updateCaptainChange)

    -- 需要重新点亮相关按钮  
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_REFRESH_TEAM_VIEW, self, self.refreshTeamData)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_GUILD_TEAM_BUF, self, self.checkAndRefreshGuildBuf)
end


-- 注销监听事件
function LevelSelectTeam:unRegisterListener()
    ObserverVariable:removeListenr(TeamDataManager._readyTeamData,self,self.refreshTeamData)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_SEARCH_MATCH, self, self._close)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self._close)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_ALL_CONFIRM, self, self._close)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_JOIN, self, self.refreshTeam)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_LEAVE, self, self.refreshTeam)


        --更改队伍在线状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_UPDATE_ONLINE, self, self.updateOnLineState)

            --更改队伍在线状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_CAPTAIN_CHANGE, self, self.updateCaptainChange)

    -- 需要重新点亮相关按钮  
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_REFRESH_TEAM_VIEW, self, self.refreshTeamData)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_GUILD_TEAM_BUF, self, self.checkAndRefreshGuildBuf)
end


function LevelSelectTeam:openShow()
     AvalonUtil.runTipsAppearShowAnimation(self.rootLayer)
     if self.pLevelSelectAddTeamRole == nil and LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.MATCHING then
        require ("app.ui.social.friends.FriendsLayer")
        local pLevelSelectAddTeamRole = UI.FriendsLayer:create(0, UI.FRIEND_LAYER_SHOW_MODEL.TEAM)
        pLevelSelectAddTeamRole:centerRight(0)
        pLevelSelectAddTeamRole:setName("LevelSelectAddTeamRole")
        self:addChild(pLevelSelectAddTeamRole, 1);
        self.pLevelSelectAddTeamRole = pLevelSelectAddTeamRole;
        self.pLevelSelectAddTeamRole:showLayer()
    end
end

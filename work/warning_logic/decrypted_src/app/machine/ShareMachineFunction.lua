-- ShareMachineFunction.lua
-- Author:zp
-- 2017年4月13日
-- 共享引擎方法
local AudioUtil = require "app.utils.AudioUtil"
local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")
local PlotManager = require("app.game.PlotManager")
local SdkManager = require"app.game.SdkManager"
local TRIGGER_TYPE = GameTriggerType
local TRACKS_INDEX = GameTracksIndex
local SPRITE_STATUS = PublicDefine.SPRITE_STATUS
local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE
local SCREEN_TYPE = GameScreenType
local DelusionType = PublicDefine.DelusionType
local TRANS_DOOR_TYPE = PublicDefine.TRANS_DOOR_TYPE
local FunctionFlag = PublicDefine.FunctionFlag

local Machine = Machine.ShareMachine
local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false

function Machine:_battleOpenNewSceneTriggerNpc(targetSpriteID)
    local target = self._model:getRoleBySpriteID(targetSpriteID)
    local isMiniMap = false
    if target then
        if(target:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            -- 根据功能NPC具有的功能，做相关的操作
            local npcData = target:getNpcData()
            if(npcData) then
                local functionTypeArr = npcData:getAllFunctionType()
                local GameInDungeonManager = require "app.game.GameInDungeonManager"
                local isShowDungeonSeasonBtn = false
                local isTriger = false
                functionTypeArr, isShowDungeonSeasonBtn, isTrigerDungeon = GameInDungeonManager:getInstance():checkAndRefreshNpcFuncArray(functionTypeArr)
                if isTrigerDungeon then
                    local lockType = Game.FunctionUnlockManager:npcTypeToLockType(PublicDefine.FUNCTION_TYPE.DUNGEON_SEASON_REWARD)
                    Game.FunctionUnlockManager:getInstance():removeNewFlag(lockType)
                end
                if isShowDungeonSeasonBtn then
                    local functionTypeArrTemp = {}
                    table.insert(functionTypeArrTemp,PublicDefine.FUNCTION_TYPE.DUNGEON_SEASON_REWARD)
                    self:_handleFunctionType(target, functionTypeArrTemp, isMiniMap)
                    return
                end

                -- 这里去掉一些不需要弹对话框的功能
                local endArr = {}
                for _,functionType in ipairs(functionTypeArr) do 
                    if(functionType ~= FUNCTION_TYPE.SELL_GOODS) then 
                        table.insert(endArr, functionType)
                    end
                end
                functionTypeArr = endArr
           
                if(#functionTypeArr >=2) then
                    -- 处理有多重功能的触发NPC 处理逻辑 
                    local mainFunction = npcData:getMainFunction()
                    if(mainFunction ~= 0) then
                        self:_battleHandleFuntionType(target, mainFunction, isMiniMap)
                    else
                        self:_handleFunctionType(target, functionTypeArr, isMiniMap)
                    end
                elseif(#functionTypeArr == 1) then
                    self:_battleHandleFuntionType(target, functionTypeArr[1], isMiniMap)
                else 
                    -- 没有功能的时候播放一个对话框
                    -- local chatStr = npcData:getChat()
                    -- if(chatStr and chatStr ~= "") then 
                    --     local dialogIDArr = string.split(chatStr,",")
                    --     if(dialogIDArr and #dialogIDArr > 0 ) then 
                    --         local chat = dialogIDArr[math.random(#dialogIDArr)]
                    --         if(chat) then
                    --             chat = checkint(chat)
                    --             Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, tonumber(chat))
                    --         end 
                    --     end
                    -- end
                    
                    local unlockNotice = npcData:getUnlockNotice()
                    if(unlockNotice) then
                        UI.ScrollBar:createByTextID(unlockNotice)
                    end
                end
            end
        end
    end
end

function Machine:_battleOpenTriggerNpc(targetSpriteID, isMiniMap)
    local target = self._model:getRoleBySpriteID(targetSpriteID)

    if target then
        -- 这里触发任务的触发处理
        if(target:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            -- 触发任务的处理逻辑
            local speak, taskData = target:getNpcData():getClickChat()
            local txt = nil 
            if(speak) then 
                txt = speak:getRandomText()
            end
            -- print("Machine:_battleOpenTriggerNpc show dialog 1", txt)
            if(txt and taskData and taskData:getIsFinish() == false and tonumber(txt) ~= 0) then 
                -- print("Machine:_battleOpenTriggerNpc show dialog 2", txt)
                speak:triggerShow() 
                -- 这里需要根据任务类型
                Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, tonumber(txt))
                return
            end

            local taskData = target:getNpcData():getClickTaskData()
            -- print("Machine:_battleOpenTriggerNpc click task 1")
            if(taskData) then 
                -- print("Machine:_battleOpenTriggerNpc click task 2", taskData:getId(), taskData:getName())
                if(taskData:getIsShowView()) then 
                    -- print("Machine:_battleOpenTriggerNpc click task 3", target:getSpriteID())
                    Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                    if(isMiniMap) then 
                        Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
                    end
                    -- 处理显示界面
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CYCLE_TASK, target:getSpriteID(), taskData)
                    return
                end
            end
        end

        -- 这里触发功能NPC
        if(target:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            -- GhostAbyss 
            if(SceneManager:getInstance():isGhostAbyss()) then
                if(target:getNpcData() and target:getNpcData():getFunctionTypeArr() and #target:getNpcData():getFunctionTypeArr()>0) then
                    local funType = target:getNpcData():getFunctionTypeArr()[1]
                    if(funType == PublicDefine.FUNCTION_TYPE.FUNCTION_GHOST_ABYSS_TOTEM) then
                        Net.NetNPCSystem:triggerFunctionType(funType, target:getSpriteID()) 

                        local ridingCMD = Command.RendererCommand:create(true)
                        ridingCMD:initForTypeAndData(CommandType.RENDERER_FUNCTION_NPC_TRIGGER, target:getId(), {})
                        SceneManager:getInstance():pushCommand(ridingCMD)
                    end
                end
            end

            --Avalon.AudioManager:playSound("1503")
            -- 根据功能NPC具有的功能，做相关的操作
            local npcData = target:getNpcData()
            if(npcData) then
                local functionTypeArr = npcData:getFunctionTypeArr()
                if(GameManager:getIsInNewScene()) then 
                    functionTypeArr = npcData:getAllFunctionType()
                end
                -- print("Machine:_battleOpenTriggerNpc  ")
                -- dump(functionTypeArr)
                --todo  if have dungeon function  判断是否满足领奖条件 如果不满足  移除按钮
                local GameInDungeonManager = require "app.game.GameInDungeonManager"
                local isShowDungeonSeasonBtn = false
                local isTriger = false
                functionTypeArr, isShowDungeonSeasonBtn, isTrigerDungeon = GameInDungeonManager:getInstance():checkAndRefreshNpcFuncArray(functionTypeArr)
                if isTrigerDungeon then
                    local lockType = Game.FunctionUnlockManager:npcTypeToLockType(PublicDefine.FUNCTION_TYPE.DUNGEON_SEASON_REWARD)
                    Game.FunctionUnlockManager:getInstance():removeNewFlag(lockType)
                end
                if isShowDungeonSeasonBtn then
                    local functionTypeArrTemp = {}
                    table.insert(functionTypeArrTemp,PublicDefine.FUNCTION_TYPE.DUNGEON_SEASON_REWARD)
                    self:_handleFunctionType(target, functionTypeArrTemp, isMiniMap)
                    return
                end

                -- 这里去掉一些不需要弹对话框的功能
                local endArr = {}
                for _,functionType in ipairs(functionTypeArr) do 
                    if(functionType ~= FUNCTION_TYPE.SELL_GOODS) then 
                        table.insert(endArr, functionType)
                    end
                end
                functionTypeArr = endArr
           
                if(#functionTypeArr >=2) then
                    -- 处理有多重功能的触发NPC 处理逻辑 
                    local mainFunction = npcData:getMainFunction()
                    if(mainFunction ~= 0) then
                        self:_battleHandleFuntionType(target, mainFunction, isMiniMap)
                    else
                        self:_handleFunctionType(target, functionTypeArr, isMiniMap)
                    end
                elseif(#functionTypeArr == 1) then
                    self:_battleHandleFuntionType(target, functionTypeArr[1], isMiniMap)
                else 
                    -- 没有功能的时候播放一个对话框
                    local chatStr = npcData:getChat()
                    if(chatStr and chatStr ~= "") then 
                        local dialogIDArr = string.split(chatStr,",")
                        if(dialogIDArr and #dialogIDArr > 0 ) then 
                            local chat = dialogIDArr[math.random(#dialogIDArr)]
                            if(chat) then
                                chat = checkint(chat)
                                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, tonumber(chat))
                            end 
                        end
                    end
                end
            end
        end

        if target:getIsOpen() == false then
            local npcData = target:getNpcData()
            local function trigger()
                
                if target:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR then 
                    
                    if(npcData:getTransdoorType() == TRANS_DOOR_TYPE.NEXT_LEVEL) then 
                        local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
                        if not firstAction or firstAction:getFSMState() == FSMState.IDLE then
                            if GameDataManager:getInstance():willOpenNewNormalCheckPoint() and GameMapManager:getInstance():getUpdateCheckPT() == false then 
                                if(TeamDataManager:hasTeam()) then
                                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112014))
                                else
                                    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)  -- 关闭控制面板
                                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CONTROL_END)
                                    UI.ConfirmDialog.show(LanguageManager:getInstance():getLocalString(1112015), function()
                                        -- 触发成功回城提示
                                        local master = self._model:getMaster()
                                        if master then
                                            self:_fsmWaiting(master,WaitingType.WAITING_NEXT_FLOOF, nil, master)
                                        end
                                        Avalon.MessageCenter:notice( AvalonMessage.MC_UI_OPEN_CONTROL_PAD)
                                        Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                                    end, function()
                                        Avalon.MessageCenter:notice( AvalonMessage.MC_UI_OPEN_CONTROL_PAD)
                                    end)
                                end
                            else
                                if(SceneManager:getInstance():isInHuLu() 
                                    and GameMapManager:getInstance():getLevel() == PublicDefine.CONST_DEFINITION.HULU_MAP_ID) then 
                                    mvc.openPanel("Festival", "FestivalWeaponSelect")
                                else 
                                    -- 判断是否添加对话框，并向服务器发送相关消息
                                    local okCallBack = function(needClose) 
                                        if RoleBehaviorManager:downstairsCheck() then 
                                            --下楼
                                            if TeamDataManager:hasTeam() then
                                                local teamData = TeamDataManager:getTeamData()
                                                for k,v in pairs(teamData) do
                                                    local roleData = RoleDataManager:getHeroDataForPK(v:getPK())
                                                    if roleData and roleData:getState() == FSMState.BATTLE then
                                                        --判断是否有队友在战斗中
                                                        Avalon.MessageCenter:notice( AvalonMessage.MC_UI_OPEN_CONTROL_PAD)
                                                        UI.ScrollBar:createByText(UI.TEXT_1110385)
                                                        return;
                                                    end
                                                end
                                            else
                                                local master = self._model:getMaster()
                                                if master then
                                                    self:_fsmWaiting(master,WaitingType.WAITING_NEXT_FLOOF, nil, master)
                                                end
                                            end
                                            if not needClose then
                                                Avalon.MessageCenter:notice( AvalonMessage.MC_UI_OPEN_CONTROL_PAD)
                                            end
                                            Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                                        end
                                    end
                                    local cancelCallBack = function()
                                        Avalon.MessageCenter:notice( AvalonMessage.MC_UI_OPEN_CONTROL_PAD)
                                    end
                                    --Avalon.AudioManager:playSound("1503")
                                    Avalon.MessageCenter:notice(AvalonMessage.MC_TIPS_SHOW_NEXT_FLOOR,okCallBack,cancelCallBack)
                                end
                            end
                        end 
                    elseif(npcData:getTransdoorType() == TRANS_DOOR_TYPE.BLACK_HOUSE_TO_TOWN) then 
                        local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
                        if not firstAction or firstAction:getFSMState() == FSMState.IDLE then
                            local goodsData = GameDataManager:getInstance():getEscapeScroll();
                            if(goodsData) then 
                                local tips = UI.Tips:createTips(UI.TEXT_DES_BACK_TOWN,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL,UI.TipsButtonType.NO_TEXT_BUTTON)
                                --  确定回城
                                local function onConfirmButtonHandler(self)
                                    GameManager:useTownScroll(goodsData)
                                    tips:close()
                                end

                                -- 点击取消
                                local function onCancelButtonHandler(self)
                                    tips:close()
                                    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)  -- 打开控制面板
                                end
                                -- 打击到tips外面
                                local function onTouchDialogOutsizeHandler(self)
                                    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)  --打开遥杆 
                                end        

                                -- 确定和取消事件监听
                                tips:addEventListener(UIEvent.DIALOG_CONFIRM, self,onConfirmButtonHandler)
                                tips:addEventListener(UIEvent.DIALOG_CANCEL, self,onCancelButtonHandler)
                                tips:addEventListener(UIEvent.DIALOG_OUT_SIDE, self, onTouchDialogOutsizeHandler)

                                Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)  -- 关闭控制面板
                            else 
                                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_BACK_TOWN_UI, BACK_TOWN_TYPE.BACK_TOWN_TYPE_BLACK_HOME)
                            end
                        end 
                    elseif(npcData:getTransdoorType() == TRANS_DOOR_TYPE.CAVE_TO_TOWN 
                        or npcData:getTransdoorType() == TRANS_DOOR_TYPE.ROOM_TO_ROOM 
                        or npcData:getTransdoorType() == TRANS_DOOR_TYPE.GUILD_TO_TOWN 
                        or npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_GUILD
                        or npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_MANOR
                        or npcData:getTransdoorType() == TRANS_DOOR_TYPE.MANOR_TO_TOWN
                        or npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWNCAVE_TO_TOWN
                        or npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_TOWNCAVE
                        or npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_BIGSAILPORT ) then 
                        -- 判断是否已经在当前格子了，如果没有就弹出提示框提示是否传送回城，  否则直接传送发送传送的消息
                        if(npcData:getTransdoorType() == TRANS_DOOR_TYPE.ROOM_TO_ROOM
                            or npcData:getTransdoorType() == TRANS_DOOR_TYPE.GUILD_TO_TOWN
                            or npcData:getTransdoorType() == TRANS_DOOR_TYPE.MANOR_TO_TOWN
                            or npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWNCAVE_TO_TOWN
                            or npcData:getTransdoorType() == TRANS_DOOR_TYPE.BIGSAILPORT_TO_TOWN ) then
                            -- 处理传送提示
                            -- 房间间的传送门
                            local nowCoord = target:getCoord()
                            if(isMiniMap and 
                                (npcData:getTransdoorType() == TRANS_DOOR_TYPE.GUILD_TO_TOWN
                                or npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWNCAVE_TO_TOWN 
                                or npcData:getTransdoorType() == TRANS_DOOR_TYPE.MANOR_TO_TOWN
                                or npcData:getTransdoorType() == TRANS_DOOR_TYPE.BIGSAILPORT_TO_TOWN)) then 
                                -- Net.NetGuildSystem:reqEnterGuildScene()
                                -- print("Net.NetNPCSystem:openTriggerNpcRequest  GUILD_TO_TOWN")
                                Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                            else 
                                -- 移动到目标位置
                                self:_triggerMasterMove(nowCoord.x, nowCoord.y, false) 
                            end
                            -- Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)

                        -- elseif (npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_MANOR) then
                        --     -- 庄园入口 @@@@@@@@ 
                        --     if true then
                        --         local callBack = function()
                        --             Net.NetManorSystem:reqEnterManorScene(RoleDataManager:getMasterPK())
                        --         end
                        --         if(GameManager:getIsInNewScene()) then
                        --             -- @@@@@@@@ 这里的提示文字得改
                        --             UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_1325005, callBack)
                        --         else
                        --             callBack() 
                        --         end
                        --     else
                        --         --@@@@@@@@ 这里的文字得替换
                        --         UI.ScrollBar:createByText(UI.TEXT_1110687)
                        --     end
                        elseif(npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_GUILD) then
                            local function clickFunc()
                                -- 判断是否有公会
                                if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Guild) then
                                    Game.FunctionUnlockManager:getInstance():showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Guild)
                                elseif (GameDataManager:getInstance():getIsJoinGuild()) then
                                    local nowCoord = target:getCoord()
                                    if(isMiniMap) then 
                                        Net.NetGuildSystem:reqEnterGuildScene()
                                    else 
                                        -- 移动到目标位置
                                        self:_triggerMasterMove(nowCoord.x, nowCoord.y, false) 
                                    end
                                else 
                                    Avalon.AudioManager:playSound("1503")
                                    UI.ScrollBar:createByText(UI.TEXT_110068)
                                end
                            end

                            if not mvc.festivalModel:checkCanEnterOther() then
                                UI.ScrollBar:createByText(UI.TEXT_1213021)
                                return
                            end

                            -- 如果 worldboss 已报名，提醒一次
                            if mvc.worldBossModel:checkCanEnterOther() then
                                clickFunc()
                            else
                                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                                    UI.TEXT_1212663,
                                    function()
                                        Net.NetActivitySystem:requestWorldbossQuitRoom()
                                        clickFunc()
                                    end
                                )
                            end
                        elseif (npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_MANOR) then
                            local function clickFunc()

                                if Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(FUNCTION_TYPE.FUNCTION_MANOR_PORTAL) then
                                    local nowCoord = target:getCoord()
                                    if(isMiniMap) then 
                                        Net.NetManorSystem:reqEnterManorScene(RoleDataManager:getMasterPK())
                                    else 
                                        -- 移动到目标位置
                                        self:_triggerMasterMove(nowCoord.x, nowCoord.y, false) 
                                    end
                                else
                                    UI.ScrollBar:createByText(UI.TEXT_221704)
                                end
                            end

                            -- 如果 worldboss 已报名，提醒一次
                            if mvc.worldBossModel:checkCanEnterOther() then
                                clickFunc()
                            else
                                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                                    UI.TEXT_1212663,
                                    function()
                                        Net.NetActivitySystem:requestWorldbossQuitRoom()
                                        clickFunc()
                                    end
                                )
                            end
                        elseif(npcData:getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_TOWNCAVE) then
                            local function clickFunc()
                                -- 判断是否有公会
                                -- if (GameDataManager:getInstance():getIsJoinGuild()) then
                                    local nowCoord = target:getCoord()
                                    if(isMiniMap) then 
                                        Net.NetRoleSystem:reqEnterHomeScene()
                                    else 
                                        -- 移动到目标位置
                                        self:_triggerMasterMove(nowCoord.x, nowCoord.y, false) 
                                    end
                                -- else 
                                --     Avalon.AudioManager:playSound("1503")
                                --     UI.ScrollBar:createByText(UI.TEXT_110068)
                                -- end
                            end

                            if not mvc.festivalModel:checkCanEnterOther() then
                                UI.ScrollBar:createByText(UI.TEXT_1213021)
                                return
                            end

                            -- 如果 worldboss 已报名，提醒一次
                            if mvc.worldBossModel:checkCanEnterOther() then
                                clickFunc()
                            else
                                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                                    UI.TEXT_1212663,
                                    function()
                                        Net.NetActivitySystem:requestWorldbossQuitRoom()
                                        clickFunc()
                                    end
                                )
                            end
                        else
                            local okCallBack = function(isNeedClose) 
                                -- 传送门
                                local nowCoord = target:getCoord()

                                -- 这里由于需要保证不能够移动，这里就应该禁止操作
                                self:disableRoleMoving()
                                if(SceneManager:getInstance():isInHuLu()) then
                                    Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                                else 
                                    -- 移动到目标位置
                                    self:_triggerMasterMove(nowCoord.x, nowCoord.y, false) 
                                end
                                if not isNeedClose then
                                    Avalon.MessageCenter:notice( AvalonMessage.MC_UI_OPEN_CONTROL_PAD)
                                end
                            end
                            local cancelCallBack = function()
                                -- print("BattleMachine _battleOpenTriggerNpc:   BATTLE_TRIGGER_TRANSDOOR  cancel.")
                            Avalon.MessageCenter:notice( AvalonMessage.MC_UI_OPEN_CONTROL_PAD)
                            end
                            --Avalon.AudioManager:playSound("1503")
                            Avalon.MessageCenter:notice(AvalonMessage.MC_TIPS_SHOW_TRANS_DOOR,okCallBack,cancelCallBack)
                        end
                    else
                        Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                    end
                elseif target:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOSS_SCENARIO_TRIGGER then 
                    -- 处理触发BOSS 触发器
                    local master = self._model:getMaster()
                    if master then
                        local masterCoord = master:getCoord()

                        local coord = {}
                        coord.x = Avalon.MathUtil:getInt(masterCoord.x)
                        coord.y = Avalon.MathUtil:getInt(masterCoord.y)

                        self:_fsmIdle(master, coord, true)

                        MachineManager:getInstance():pushIDLERendererCommand(master:getId())

                        --TODO 临时发送停止移动命令
                        Net.NetRoleSystem:heroStopMoveRequest(coord.x, coord.y)

                        self:_fsmWaiting(master,WaitingType.WAITING_BOSS_SCENARIO_TRIGGER, nil, master)
                    end

                    Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)

                elseif target:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP then 
                    local npcData = target:getNpcData()
                    -- 处理客户端表现逻辑
                    if(npcData and npcData:getIsDecoretionTrap()) then
                        -- 处理趣味陷阱表现
                        local battleCmd = Command.BattleCommand:create()
                        battleCmd:initForNpcOpen(target:getId())
                        SceneManager:getInstance():pushCommand(battleCmd)
                    else
                        -- 处理迷雾表现效果
                        local npcData = target:getNpcData()
                        if(npcData) then 
                            -- 临时处理表现，后续如果有新的效果还需要做表现逻辑
                            local effectType = npcData:getTrapEffectType()
                            if(effectType == 1) then
                                -- Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_MOVE_HALF)
                                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_BLIND_CHANGE_DENSE_FOG, true)
                            else
                                -- Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_BLIND_CHANGE_DENSE_FOG, false)
                            end

                            local trapType = npcData:getTrapType()
                            if(trapType == 1 or trapType == 2) then
                                AudioUtil:updateTrapEffectSound()
                            end
                        end

                        if (RoleBehaviorManager:triggerBoxTrapGoldBoxCheck()) then 
                            Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                        end
                    end 
                -- 
                elseif target:getType() == PublicDefine.TRIGGER_NPC_TYPE.DISAPPEAR_OBSTACLE then 
                    self:_pushNpcInfomationShow(target)
                else
                    -- if (target:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT then 
                    -- else 

                    if (target:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP
                    or target:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOX
                    or target:getType() == PublicDefine.TRIGGER_NPC_TYPE.GOLD_BAG
                    or target:getType() == PublicDefine.TRIGGER_NPC_TYPE.RUNE ) then 
                        if SceneManager:getInstance():isInCaveExploring() and target:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOX then
                            local treasureHuntOpenBoxConsume = ConfigManager:getGeneralForKey("treasureHuntOpenBoxConsume")
                            local treasureHuntOpenBoxConsumeList = string.split(treasureHuntOpenBoxConsume, ",")
                            -- local pk = RoleDataManager:getMasterPK()
                            local itemTotalNum = RoleDataManager:getMaster():getTreatureHuntOpenItem()--GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, tonumber(treasureHuntOpenBoxConsumeList[1]))
                            if itemTotalNum < tonumber(treasureHuntOpenBoxConsumeList[2]) then
                                UI.ScrollBar:createByText(UI.TEXT_224807)
                                return 
                            end
                        end

                        if (RoleBehaviorManager:triggerBoxTrapGoldBoxCheck()) then 
                            self:_addDropTrigger(target)
                            -- 发送打开触发类NPC
                            Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                        end
                    else 
                        self:_addDropTrigger(target)
                        -- 发送打开触发类NPC
                        Net.NetNPCSystem:openTriggerNpcRequest(targetSpriteID)
                    end
                end
            end
            local triggerDialog = true
            if npcData:wasCheckResuce() then
                if not mvc.festivalModel:getWasRescue() then
                    -- CO-14519 贪婪迷宫关底传送特殊处理移除  去掉了触发表现
                    -- -- 更新地图的渲染命令
                    mvc.festivalModel:setWasRescue(true)
                    -- local renderCommand = Command.RendererCommand:create(true)
                    -- renderCommand:initTriggerNpcUnlock(target:getId())
                    -- self:pushCommand(renderCommand)
                else
                    triggerDialog = false
                end
            end

            -- 触发类NPC有对话的 需要先播放对话
            local dialogueID = checkint(npcData:getDialogue()) 
            if dialogueID > 0  then
                -- print("有对话框")
                if triggerDialog then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, dialogueID,trigger)
                else
                    trigger()
                end
            else
                trigger()
            end
        else 
            if(target:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOX) then
                local endDialog = target:getEndDialogue()
                if(endDialog and tonumber(endDialog) ~= 0) then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, endDialog)
                end
            end
        end
    else
        assert(false, "[ERROR] BattleMachine _onExecuteBattleCommand: _battleOpenTriggerNpc.")
    end
end

function Machine:openUIByFunctionType(functionType)
    if not SceneManager:getInstance():checkFunctionCondition(functionType) then
        return false
    end
    if(GameManager:getIsInNewScene()) then 
        return self:_openUIByFunctionTypeForNewScene(functionType)
    else
        return self:_openUIByFunctionType(functionType)
    end
end

-- 自动打开页面
-- 返回true = 激活NPC成功, false = 激活NPC失败
function Machine:_openUIByFunctionType(functionType)
    if not SceneManager:getInstance():checkFunctionCondition(functionType) then
        return false
    end

    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    local isHaveNPC = false
    local triggerRole = nil
    if(machine) then 
        local entterNpc = machine._model:getNpcsForFuntionType(functionType)
        if(entterNpc[1] and entterNpc[1]:getNpcData()) then 
            local triggerData = entterNpc[1]:getNpcData()
            if(triggerData) then 
                triggerRole = machine._model:getRoleBySpriteID(triggerData:getSpriteID())
            end
        end

        isHaveNPC = true
        machine:_battleHandleFuntionType(triggerRole, functionType, true)
    end

    return isHaveNPC
end

function Machine:_openUIByFunctionTypeForNewScene(functionType)
    if not SceneManager:getInstance():checkFunctionCondition(functionType) then
        return false
    end
    local MachineManager = require("app.game.MachineManager", functionType)
    local machine = MachineManager:getInstance():getMachine()
    local isHaveNPC = false
    if(machine and machine._model) then 
        local npcArr = machine._model:getAllFunctionNpcArr()
        local foundModel = nil
        if(npcArr) then 
            for k, npcModel in ipairs(npcArr) do
                if(npcModel and npcModel:getData()) then
                    local allFunctionArr = npcModel:getData():getAllFunctionType()
                    if(allFunctionArr) then 
                        for i = 1, #allFunctionArr do
                            if(allFunctionArr[i] == functionType) then 
                                foundModel = npcModel
                                break
                            end
                        end
                    end
                end
                if(foundModel) then 
                    break
                end
            end
        end

        machine:_battleHandleFuntionType(foundModel, functionType, false)
        isHaveNPC = true
    end

    return isHaveNPC
end

function Machine:_battleNpcOpen(modelID)
    local npc = self._model:getModelByModelID(modelID)
    if npc then
        -- 处理
        if npc:getCategory() == Category.TRIGGER_NPC then
            if npc:getNpcData():getIsOpen() == false then
                npc:trigger()
                -- print("ddddddddd", npc:getNpcData():getIsOpen())
                -- self:_triggerNPCOpen(npc, false, nil)
                Avalon.AudioManager:playSoundByConfig("23",npc:getNpcData():getId(),nil,npc:getCoord())

                if(npc and npc:getCategory() == Category.TRIGGER_NPC and npc:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
                    -- 处理相关的延迟时间处理逻辑
                    local timeArr = string.split(npc:getNpcData():getDoEffectTiming(),",")
                    if(timeArr and #timeArr > 0 ) then
                        local modelID = npc:getId()
                        Avalon.Scheduler:scheduleUpdateOnce(self, function()
                            local renderCommand = Command.RendererCommand:create(true)
                            renderCommand:initNpcTrapEffect(modelID)
                            self:pushCommand(renderCommand)
                        end, tonumber(timeArr[1]) / TIME_UNIT)
                    end
                end
            end
        else 
            assert(false,"Machine:_controlNpcOpen category="..npc:getCategory())
        end
    end
end

function Machine:_triggerNPCOpen(target,recoverOpen, triggerSpriteID)
    if(target and target:getCategory() == Category.TRIGGER_NPC and target:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOX) then
        self:_removeDeformation(target, false)
    elseif(target and target:getCategory() == Category.TRIGGER_NPC and target:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
        if(RoleDataManager:getMasterSpriteID() == triggerSpriteID) then 
            Avalon.MessageCenter:notice(GameMessage.MC_NOVICE_GUIDE_TRIGGER_TRAP, target:getSpineName())
        end
    end
    
    local openAction = Action.TriggerNPCOpenAction:create(true)
    openAction:init(target,self,recoverOpen)
    self:addAction(openAction)
end

-- 
function Machine:_battleTransDoorTrigger(spriteID)
    local target = self._model:getRoleBySpriteID(spriteID)
    if(target) then
        -- 添加触发表现
        -- local data = {}
        -- data.spriteID = spriteID
        -- self:_controlNpcOpen(data)
        Avalon.AudioManager:playSound("1068")

        local openItCommand = Command.RendererCommand:create()
        openItCommand:initOpenItCommand(target:getId(), false)
        SceneManager:getInstance():pushCommand(openItCommand)

        local master = self._model:getMaster()
        self:_fsmWaiting(master, WaitingType.WAITING_TRANSDOOR, nil, target)
    else 
        -- 和点击确认传送回城的禁用相对
        self:enableRoleMoving()
    end
end

-- 
function Machine:_battleTransPointTrigger(spriteID, pk)
    local target = self._model:getRoleBySpriteID(spriteID)
    if(target) then
        -- 添加触发表现
        Avalon.AudioManager:playSound("1068")

        local openItCommand = Command.RendererCommand:create()
        openItCommand:initOpenItCommand(target:getId(), false, pk)
        SceneManager:getInstance():pushCommand(openItCommand)

        local master = self._model:getMaster()
        if(pk == master:getPK()) then
            self:_fsmWaiting(master, WaitingType.WAITING_TRANSPOINT, nil, target)
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                self:enableRoleMoving()
            end, 0.1)
        end
    else 
        -- 和点击确认传送回城的禁用相对
        self:enableRoleMoving()
    end
end

function Machine:_battleSettingHideHorcrux(hideHorcrux)
    -- print("Machine:_battleSettingHideHorcrux", hideHorcrux)
    local heroModeArr = self._model:getAllHero()
    if(heroModeArr) then
        for k, heroMode in pairs(heroModeArr) do 
            MachineManager:getInstance():pushHorcruxShowOrHideCommand(heroMode)
        end
    end
end

function Machine:_battleSettingHidePet(hidePet)
    if(hidePet) then 
        local allRoleMap = self._model:getAllPet()
        if(allRoleMap) then 
            for k, v in pairs(allRoleMap) do 
                if(v:getCategory() == Category.ROLE and v:getType() == RoleType.Pet) then
                    if v:getMaster() and not v:getMaster():isMaster() then 
                        -- 停止所有的效果
                        self._actionTrack:clearActionForEntryId(v:getId())
                        self._view:removeView(v, true)
                        self._model:removeModel(v)
                    end
                end
            end
        end
    else
        local screenPetArr = RoleDataManager:getAllScreenPetData()
        if(screenPetArr) then
            for k, petData in pairs(screenPetArr) do 
                if(petData and petData:getMasterSpriteID() and self._model:getRoleBySpriteID(petData:getMasterSpriteID())) then 
                    self:_addPet(SCREEN_TYPE.SCREEN, petData)
                end
            end
        end
    end
end

function Machine:_forceRefreshPetInScreen(spriteID)
    local pet = self._model:getRoleBySpriteID(spriteID)
    if pet then
        self._actionTrack:clearActionForEntryId(pet)
        self._view:removeView(pet, true)
        self._model:removeModel(pet)
    end

    local petData = RoleDataManager:getScreenFightPetData()
    if petData then
        SkillDataManager:clearDataForSpriteID(petData:getSpriteID())
        self:_addPet(SCREEN_TYPE.SCREEN, petData)
        -- 恢复所有buff 效果
        -- if petData.buff then
        --     self:_recoverBuff(petData.buff, petData)
        -- end
    end
end

function Machine:_battleSettingPersionCount()
    -- print("Machine:_battleSettingPersionCount")
    local heroModeArr = self._model:getAllHero()
    if(heroModeArr) then
        local num = GameManager:getPersonNum()
        -- print("Machine:_battleSettingPersionCount", num, self._model:getAllHeroExtMasterNum())
        if(num < self._model:getAllHeroExtMasterNum()) then 
            local master = self._model:getMaster()
            -- 这里人数大于玩家设定人数，需要移除部分人
            local distanceArr = {}
            for k, heroMode in pairs(heroModeArr) do 
                if(master:getSpriteID() ~= heroMode:getSpriteID()) then
                    local distance = Geome.computeDistance(master:getCoord(), heroMode:getCoord())
                    table.insert(distanceArr, {dis = distance , model = heroMode})
                end
            end
            table.sort(distanceArr, function(a, b)
                if(a.dis == b.dis) then 
                    if(a.model:getSpriteID() < b.model:getSpriteID()) then 
                        return true
                    else 
                        return false
                    end
                else
                    if(a.dis < b.dis) then 
                        return true
                    else 
                        return false
                    end
                end
            end)

            -- 移除多余的人
            for k, v in ipairs(distanceArr) do 
                -- print("distanceArr=", k, num)
                if(k-1 >= num) then 
                    self:_controlRemoveScreenRole(v.model:getData())
                end
            end
        end
    end
end

function Machine:_battleEnd(spriteID)
    -- print("+++++_battleEnd ", spriteID )
    local role = self._model:getRoleBySpriteID(spriteID)
    if role then
        local action = Action.IDLEStateAction:create(true)
        action:init(role, role:getCoord(), self)
        self:setAction(action)
    end
end

function Machine:_fsmWaiting(target, waitingType, data, npcTarget)
    local action = Action.WaitingStateAction:create(true)
    action:init(target, waitingType,data, npcTarget)
    self:setAction(action)
end

function Machine:_pushNpcInfomationShow(target)
    if(target and target:getNpcData()) then
        -- local renderCommand = Command.RendererCommand:create(true)
        -- renderCommand:initNPCInfomationShow(target:getId(), LanguageManager:getInstance():getLocalString(target:getNpcData():getLockFuncTip()), target:getNpcData():getLockFuncTipTime())
        -- SceneManager:getInstance():pushCommand(renderCommand)
        if(GameManager:getIsInNewScene()) then
            local unlockNotice = target:getNpcData():getUnlockNotice()
            if(unlockNotice) then
                UI.ScrollBar:createByTextID(unlockNotice)
            else
                UI.ScrollBar:createByTextID(1112432)
            end
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, target:getNpcData():getLockFuncTip())
        end
    end
end

function Machine:_handleFunctionType(target, functionTypeArr, isMiniMap) 
    --funtion array 筛选
    functionTypeArr = Game.FunctionUnlockManager:getInstance():checkNpcFunction(functionTypeArr)
    if #functionTypeArr == 0 then
        self:_pushNpcInfomationShow(target)
        return
    end
    GameManager:hideNPCInfomation(target:getSpriteID())
    local dataArr = {}

    for _,type in pairs(functionTypeArr) do
        local functionData = ConfigManager:getFunctionNPCButtonByFunctionType(type)
        if(functionData) then
            table.insert(dataArr, functionData)
        end
    end

    if(dataArr == nil or #dataArr == 0) then 
        return
    end
    
    local FunctionType = PublicDefine.FUNCTION_TYPE
    for k, data in ipairs(dataArr) do
        if data.ID == FunctionType.GUILD_AUCTION_STOCK or data.ID == FunctionType.GUILD_AUCTION_MAIN then
            local guildData = MasterDataManager:getGuildData()
            if guildData then
                local day = guildData:getCreateCdTime()
                if day > 0 then
                    UI.ScrollBar:createByText(string.format(UI.TEXT_1213915, day))
                    return
                end
            end
        end
    end
    
    -- 计算坐标
    local npcData = target:getNpcData()

    -- print("Machine:_handleFunctionType  ", pos.x, pos.y, sx, sy)
    -- dump(pos)
    
    if(GameManager:getIsInNewScene()) then 
        mvc.mainCityModel:setChoiceTriggerData(npcData)
        mvc.openPanel("MainCity", "MainCityFunctionChoice")
    else
        local size = npcData:getOccupySize()
        local coord = target:getCoord()

        local coordX = coord.x
        local coordY = coord.y
        local coordZ = self._view:getMapTileCoordZ(coordX, coordY)

        local sx, sy = self._view._map:getCenterPositionOfBoundingBox(coordX, coordY, coordZ, size[1], size[2])

        local pos = self._view._map:convertToWorldSpace(cc.p(sx,sy))

        if(isMiniMap) then 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_TOWN_CLICK_ICON, npcData, dataArr)
        else
            UI.UIManager:showFunctionButton(target:getSpriteID(), dataArr, pos.x, pos.y , target:getInformationLocation())
        end
    end
end

-- 计算NPC 显示坐标
function Machine:_calculationNpcShowPosition(target, offsetX, offsetY, npcCenter) 
    local targetCoord = target:getCoord()
    local size = target:getNpcData():getOccupySize()
    local masterCoord = RoleDataManager:getMaster():getCoord()
    if(npcCenter) then
        masterCoord = targetCoord
    end

    local leftCoord = {x = targetCoord.x, y = targetCoord.y +(size[2]-1)}
    local rightCoord = {x = targetCoord.x + size[1] - 1, y= targetCoord.y}

    local centerCoordX = masterCoord.x
    local centerCoordY = masterCoord.y
    -- 坐标点位小数
    local centerCoord = nil
    if(leftCoord.x - masterCoord.x <= leftCoord.y - masterCoord.y and rightCoord.x - masterCoord.x >= rightCoord.y - masterCoord.y) then
        -- 在NPC 范围内部
        centerCoord = {x=targetCoord.x + ((size[1]-1)/2), y=targetCoord.y +((size[2]-1)/2)}

    else 
        -- 在NPC 范围外部
        if leftCoord.x - masterCoord.x > leftCoord.y - masterCoord.y then
            centerCoord = {x= (masterCoord.x + rightCoord.x) /2, y = (masterCoord.y + rightCoord.y)/2}
        else 
            centerCoord = {x= (masterCoord.x + leftCoord.x) /2, y = (masterCoord.y + leftCoord.y)/2}
        end
    end

    centerCoord.x = centerCoord.x + offsetX
    centerCoord.y = centerCoord.y + offsetY

    centerCoordX = math.ceil(centerCoord.x)
    centerCoordY = math.ceil(centerCoord.y)

    -- 计算方向
    -- print(" endCoordX,endCoordY,centerCoordX,centerCoordY", endCoordX, endCoordY, centerCoordX, centerCoordY)
    local mapPosX, mapPosY = self._view._map:coordinateToPosition(centerCoordX, centerCoordY)

    mapPosX = mapPosX + (centerCoord.x - centerCoordX) * self._view._map.tileWidth * 0.5
    mapPosY = mapPosY + (centerCoord.y - centerCoordY) * self._view._map.tileHeight * 0.5

    return mapPosX, mapPosY
end

function Machine:_battleHandleFuntionType(target, functionType, isMiniMap)
    print("_battleHandleFuntionType11:", functionType, isMiniMap)
    --functionType 筛选
    local list = {}
    table.insert(list, functionType)
    list = Game.FunctionUnlockManager:getInstance():checkNpcFunction(list)
    if #list == 0 then
        -- local renderCommand = Command.RendererCommand:create(true)
        -- renderCommand:initNPCInfomationShow(target:getId(), LanguageManager:getInstance():getLocalString(target:getNpcData():getLockFuncTip()), target:getNpcData():getLockFuncTipTime())
        -- SceneManager:getInstance():pushCommand(renderCommand)
        if(target and target:getNpcData()) then
            if(GameManager:getIsInNewScene()) then
                local unlockNotice = target:getNpcData():getUnlockNotice()
                if(unlockNotice) then
                    UI.ScrollBar:createByTextID(unlockNotice)
                else
                    UI.ScrollBar:createByTextID(1112432)
                end
            else
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, target:getNpcData():getLockFuncTip())
            end
        else
            UI.ScrollBar:createByTextID(1112432)
        end
        return
    end

    functionType = list[1]
    local npcData = nil
    local spriteID = nil
    if(target) then 
        npcData = target:getNpcData()
        spriteID = target:getSpriteID()
    end
    local lockType = Game.FunctionUnlockManager:npcTypeToLockType(functionType)
    Game.FunctionUnlockManager:getInstance():removeNewFlag(lockType)

    -- 这里判断大概该功能是否符合当前的场景
    if SceneManager:getInstance():checkFunctionCondition(functionType) == false then 
        local sceneType = SceneManager:getInstance():getSceneType()
        if (type(sceneType) ~= "number") then 
            sceneType = -10
        end
        print("no handle or No condition handletype, functionType=%d, scenetType=%d", functionType, sceneType)
        printError(string.format("no handle or No condition handletype, functionType=%d, scenetType=%d", functionType, sceneType))
        -- TODO 这里可以打点，用于统计玩家出现错误的逻辑

        return 
    end

    -- 触发互动动画
    if(npcData and npcData:getIsOpen() == false) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initInteractionStart(target:getId(), functionType)
        SceneManager:getInstance():pushCommand(renderCommand)
    end

    local messageID = nil 
    local operationID = nil
    local param = nil
    if (functionType == FUNCTION_TYPE.GUILD_ENTRANCE) then
        if GameDataManager:getInstance():getIsJoinGuild() then
            local callBack = function()
                Net.NetGuildSystem:reqEnterGuildScene()
            end
            if(GameManager:getIsInNewScene()) then
                UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_1325005, callBack)
            else
                callBack() 
            end
        else
            if(GameManager:getIsInNewScene()) then 
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_GUILD_CREATE_OR_JOIN, spriteID)
                return
            end

            UI.ScrollBar:createByText(UI.TEXT_1110687)
        end
    elseif (functionType == FUNCTION_TYPE.FUNCTION_MANOR_PORTAL) then
        -- 庄园入口
        if Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(FUNCTION_TYPE.FUNCTION_MANOR_PORTAL) then
            local callBack = function()
                Net.NetManorSystem:reqEnterManorScene(RoleDataManager:getMasterPK())
            end
            if(GameManager:getIsInNewScene()) then
                UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_1325007, callBack)
            else
                callBack() 
            end
        else
            -- if(GameManager:getIsInNewScene()) then 
            --     --@@@@@@@@ 这里得弹出指定的提示 或者界面
            --     -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_GUILD_CREATE_OR_JOIN, spriteID)
            --     return
            -- end

            --@@@@@@@@ 这里的文字得替换
            UI.ScrollBar:createByText(UI.TEXT_221704)
        end

    elseif (functionType == FUNCTION_TYPE.SPECIFIC_ENTRANCE) then
        -- --是否解锁大秘境
        -- local unlockCaveData = RoleDataManager:getMaster():getUnlockCaveData(PublicDefine.CAVE_MODE.MODE_DUNGEON,PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        -- if unlockCaveData == nil or unlockCaveData:getIsUnlock() == false then
        --     UI.ScrollBar:createByText(UI.TEXT_110042)
        --     return
        -- end

        if TeamDataManager:getReadyState() then
            UI.ScrollBar:createByText(UI.TEXT_1212055)
            return
        end

        --是否在休赛期
        local seasonData = MasterDataManager:getCurrentSeasonData()
        if seasonData== nil or seasonData.open == false then
            UI.ScrollBar:createByText(UI.TEXT_110043)
            return
        end
        --是否关闭大秘境入口
        if not MasterDataManager:isDungeonEntranceOpen() then
            UI.ScrollBar:createByTextID(1110729)
            return
        end
        messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL_EXCHANGE_SHOP) then 
        if(MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_ExchangeShop)) then
            if(isMiniMap) then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
            end

            mvc.openPanel("Festival" ,"FestivalExchangeShop", spriteID)
        else
            if(target and target:getNpcData()) then
                local npcData = target:getNpcData()
                local functionArr = npcData:getFunctionTypeArr()
                local informationStr = npcData:getInformationFunction()
                local informationArr = string.split(informationStr, ";")
                local informationID = nil
                if(functionArr and informationArr) then 
                    for k,v in ipairs(functionArr) do 
                        if(v == functionType) then 
                            informationID = informationArr[k]
                        end
                    end
                end

                local str = nil
                if(informationID) then
                    str = LanguageManager:getInstance():getLocalString(tonumber(informationID))
                end
                if(str) then 
                    local renderCommand = Command.RendererCommand:create(true)
                    renderCommand:initNPCInfomationShow(
                        target:getId(), 
                        str, 
                        npcData:getTalkDuration())
                    SceneManager:getInstance():pushCommand(renderCommand)
                    npcData:setNPCInfomationTriggerTime()
                    if(isMiniMap) then 
                        UI.ScrollBar:createByText(str)
                    end
                end
            end
        end
        -- 公会任务
    elseif (functionType == FUNCTION_TYPE.GUILD_TASK) then
        if GameDataManager:getInstance():getIsJoinGuild() then
            messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
        else
            UI.ScrollBar:createByText(UI.TEXT_1110687)
        end
        -- 公会科技
    elseif (functionType == FUNCTION_TYPE.GUILD_TECH) then
        if GameDataManager:getInstance():getIsJoinGuild() then
            messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
        else
            UI.ScrollBar:createByText(UI.TEXT_1110687)
        end
    elseif (functionType == FUNCTION_TYPE.GUILD_MARKET) then
        if(not mvc.guildShopModel:getIsLockGuildShop()) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170285))
        else
            if(isMiniMap) then
            	Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        	end 
            mvc.send("Open_Panel","GuildShop", nil, spriteID)
        end
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_GUILDBOSS) then 
        local masterData = GameDataManager:getInstance():getMaster()
        
        local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_FriendShip)
        if(not isUnlock) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170233))
            return
        end

        local guildBossLimit = ConfigManager:getGuildConfigForKey("guildBossNewLimit")
        if(guildBossLimit == nil) then 
            guildBossLimit = SECONDS_ONE_DAY
        end
        local waitingTime = masterData:getJoinGuildTime() + guildBossLimit - GameManager:getNormalServerTime()
        if(waitingTime > 0) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170246))
        else 
            -- local curIndex = 0
            -- if(target:getData() and target:getData():getGuildBossData()) then 
            --     curIndex = target:getData():getGuildBossData():getBossIndex()
            -- end

            -- mvc.openPanel("Guild", "GuildSelectFloor", curIndex)
            mvc.openPanel("Guild", "GuildSelectFloor")
        end
    elseif functionType == FUNCTION_TYPE.DUNGEON_SEASON_REWARD then
        local GameInDungeonManager = require "app.game.GameInDungeonManager"
        local isReward = GameInDungeonManager:getInstance():isCanReciveSeasonReward()
        if isReward then
            if RoleBehaviorManager:dungeonRewardNpcCheck() then
                printWarn(" been blocked when using dungeon reward npc function !")
            else
                local pk = RoleDataManager:getMaster():getPK()
                Net.NetRankSystem:requestSpecifyRank(pk,  PublicDefine.RankType.RankType_Dungeon)
                Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_DUNGEON_SEASON_TO_REWARD, self, function()
                    self:judgeRewardBySeasonReward(target)
                end) 
            end
        else 
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, 100071)
        end
    elseif functionType == FUNCTION_TYPE.ACTIVITY then
        if not ServerConfigUtil:isInReview() then
            messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
        end
        
        -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_Activity,0,PublicDefine.WebLogType_Activity_Type.WebLogType_Activity_Open,0,0)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_DREAM) then
        if TeamDataManager:getReadyState() then
            UI.ScrollBar:createByText(UI.TEXT_1212055)
            return
        end
        messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
        -- 触发梦境NPC
        local battleMachine = MachineManager:getInstance():getMachine()
        if battleMachine ~= nil then
            local battleModel = battleMachine:getModel()
            if (battleModel) then
                local npcModels = battleModel:getDreamNpcModels()
                for k, model in ipairs(npcModels) do
                    local renderCommand = Command.RendererCommand:create()
                    renderCommand:playDreamNpcOpenAct(model:getId())
                    MachineManager:getInstance():getMachine():pushCommand(renderCommand)
                end
            end
        end
    elseif functionType == FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION then
        messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
    elseif functionType == FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL then
        local dataArr = MasterDataManager:getActivityDataArr()
        local found = false
        for k, v in pairs(dataArr) do
            if v:getType() == PublicDefine.ActivityType.ActivityType_Festival then
                found = true
                break
            end
        end

        if found then
            messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
        elseif(target) then
            local npcData = target:getNpcData()
            local functionArr = npcData:getFunctionTypeArr()
            local informationStr = npcData:getInformationFunction()
            local informationArr = string.split(informationStr, ";")
            local informationID = nil
            if(functionArr and informationArr) then 
                for k,v in ipairs(functionArr) do 
                    if(v == functionType) then 
                        informationID = informationArr[k]
                    end
                end
            end

            local str = nil
            if(informationID) then
                str = LanguageManager:getInstance():getLocalString(tonumber(informationID))
            end
            if(str) then 
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initNPCInfomationShow(
                    target:getId(), 
                    str, 
                    npcData:getTalkDuration())
                SceneManager:getInstance():pushCommand(renderCommand)
                npcData:setNPCInfomationTriggerTime()
                if(isMiniMap) then 
                    UI.ScrollBar:createByText(str)
                end
            end
        end
    elseif functionType == FUNCTION_TYPE.FUNCTION_TYPE_WISHPOOL then
        messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
    elseif functionType == FUNCTION_TYPE.FUNCTION_BOSS_PORTAL then
        messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
    elseif functionType == FUNCTION_TYPE.FUNCTION_BARTER then
        messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
    else
        messageID, operationID, param = self:_calculationTriggerNpc(target, functionType, isMiniMap)
    end
    RedPointManager:triggerNewRedPointFlag(functionType)
    
    Net.NetRoleSystem:reqOpenFuntionTypeUI(functionType)
    if(messageID) then 
        if(isMiniMap) then 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end
        mvc.panelMonitor:hideTopPanel()
        Avalon.MessageCenter:notice(messageID, spriteID, param)
    end 

    if(operationID) then
        SdkManager:getInstance():recordUIOperation(operationID)
    end
end

function Machine:_calculationTriggerNpc(target, functionType, isMiniMap)
    print("_calculationTriggerNpc---->: ", functionType)
    local messageID = nil
    local operationID = nil
    local param = nil
    local spriteID = nil
    if(target) then
        spriteID = target:getSpriteID()
    end

    -- 处理隐藏功能界面化逻辑
    if(isMiniMap) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
    end

    if(functionType == FUNCTION_TYPE.EXCHANGE_IN_CAVE) then
        self:_triggerMoveMap(target, 2, 1, true, isMiniMap)
        messageID = GameMessage.MC_BATTLE_IN_CAVE_SHOP
    elseif (functionType == FUNCTION_TYPE.ENCHANT) then
        self:_triggerMoveMap(target, 1.5, 1, true, isMiniMap)
        messageID = GameMessage.MC_BATTLE_IN_CAVE_ENCHANTMENT
        operationID = PublicDefine.FUNCTION_RECORD_TYPE.ENCHANT
    elseif (functionType == FUNCTION_TYPE.GOLD_TOUCH) then
        if(target) then
            local npcData = target:getNpcData()
            if(npcData:getIsOpen() == false) then
                self:_triggerMoveMap(target, 1.5, 1, true, isMiniMap)
                messageID = GameMessage.MC_BATTLE_IN_CAVE_GOLDPOINTING
                operationID = PublicDefine.FUNCTION_RECORD_TYPE.GOLD_TOUCH
            end
        end
    elseif (functionType == FUNCTION_TYPE.EXCHANGE_IN_TOWN) then

    elseif (functionType == FUNCTION_TYPE.BLACK_MARKET) then
        self:_triggerMoveMap(target, 2.5, 1.5, nil, isMiniMap)
        messageID = GameMessage.MC_ROLE_SHOW_BLACK_SHOP
    elseif (functionType == FUNCTION_TYPE.RANDOMSHOPUNLOCK) then
        self:_triggerMoveMap(target, 2.5, 1.5, nil, isMiniMap)
        messageID = GameMessage.MC_ROLE_SHOW_RANDOM_SHOP
    elseif (functionType == FUNCTION_TYPE.BLACKSMITH) then

    elseif (functionType == FUNCTION_TYPE.MAILBOX) then
        messageID = GameMessage.MC_TASK_SHOW_MAILLAYER
        if(isMiniMap) then 
            param = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_BigMap
        else 
            param = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_NPC
        end
    elseif (functionType == FUNCTION_TYPE.GENERAL_ENTRANCE) then
        messageID = GameMessage.MC_TOWN_SHOW_LEVEL_SELECT
        param = {}
        local lastLayerType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveLayerType..GameDataManager:getInstance():getMasterPK(), 0)
        local layerType = lastLayerType == 0 and Game.LevelSelectLayerType.Normal_Plot or lastLayerType
        if RoleDataManager:getIsReincarntion() and lastLayerType == 0 then
            local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
            layerType = Game.LevelSelectLayerType.Normal_Plot--Game.LevelSelectLayerType.Titan_Road
            LevelSelectUtil:getInstance():setSwitchCaveLayerType(layerType)
            param.isFirst = true
        end
        param.layerType = layerType
    elseif (functionType == FUNCTION_TYPE.TASK) then
        messageID = GameMessage.MC_TASK_SHOW_TASK
    elseif (functionType == FUNCTION_TYPE.ACHIEVEMENT) then

    -- 排行榜
    elseif (functionType == FUNCTION_TYPE.LEADERBOARD) then
        messageID = GameMessage.MC_UI_SHOW_RANKING
    --仓库
    elseif (functionType == FUNCTION_TYPE.WAREHOUSE) then
        self:_triggerMoveMap(target, 1.5, 1, nil, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_WAREHOUSE
    elseif (functionType == FUNCTION_TYPE.GUILD_ENTRANCE) then

    elseif (functionType == FUNCTION_TYPE.SPEAKER) then

    -- 装备强化
    elseif (functionType == FUNCTION_TYPE.EQUIPMENT_STRENGTHEN) then
        self:_triggerMoveMap(target, 2.5, 1.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_STRENGTHEN
        operationID = PublicDefine.FUNCTION_RECORD_TYPE.EQUIPMENT_STRENGTHEN
    -- 宠物装备强化
    elseif (functionType == FUNCTION_TYPE.PET_EQUIPMENT_STRENGTHEN) then
        self:_triggerMoveMap(target, 2.5, 1.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_PET_STRENGTHEN
        operationID = PublicDefine.FUNCTION_RECORD_TYPE.PET_EQUIPMENT_STRENGTHEN
    -- 装备改造
    elseif (functionType == FUNCTION_TYPE.EQUIPMENT_REMODEL) then
        self:_triggerMoveMap(target, 2.5, 1.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_REMOULD
        operationID = PublicDefine.FUNCTION_RECORD_TYPE.EQUIPMENT_REMODEL
    -- 猫饭
    elseif (functionType == FUNCTION_TYPE.CAT_FOOD) then
        messageID = GameMessage.MC_UI_SHOW_CATFOOD
        operationID = PublicDefine.FUNCTION_RECORD_TYPE.CAT_FOOD
    -- 装备分解
    elseif (functionType == FUNCTION_TYPE.EQUIPMENT_DECOMPOSE) then
        self:_triggerMoveMap(target, 2.5, 1.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_RESOLVE
        operationID = PublicDefine.FUNCTION_RECORD_TYPE.EQUIPMENT_DECOMPOSE
    -- 装备锻造
    elseif (functionType == FUNCTION_TYPE.EQUIPMENT_FORGE) then
        self:_triggerMoveMap(target, 2.5, 1.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_FORGE
        operationID = PublicDefine.FUNCTION_RECORD_TYPE.EQUIPMENT_FORGE
    -- 捏脸
    elseif (functionType == FUNCTION_TYPE.FACELIFT) then
        messageID = GameMessage.MC_UI_SHOW_BEAUTYSALON
    --转盘 
    elseif (functionType == FUNCTION_TYPE.LUCKYWHEEL_TURN) then
        self:_triggerMoveMap(target, 0, 2, nil, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_LUCKDROP
    elseif (functionType == FUNCTION_TYPE.SPECIFIC_ENTRANCE) then
        if(not GameManager:getIsInNewScene() and target) then
            local targetCoord = target:getCoord()
            local size = target:getNpcData():getOccupySize()
            local masterCoord = RoleDataManager:getMaster():getCoord()
            local centerCoordX = math.ceil((targetCoord.x + masterCoord.x + size[1] - 1) / 2) + 1
            local centerCoordY = math.ceil((targetCoord.y + masterCoord.y + size[2] - 1) / 2) 
            -- 计算方向
            local mapPosX, mapPosY = self._view._map:coordinateToPosition(centerCoordX, centerCoordY)

            if (not isMiniMap) then
                self._view._map:stopAllActions()
                self._view._map:runAction(cc.MoveTo:create(0.2,cc.p(-mapPosX*1.2 + winSize.width/2, -mapPosY*1.2 + winSize.height/2)))
                self._view._map:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2,1.2,1.2),cc.CallFunc:create(function()
                        self._view._map:setPosition(-mapPosX*1.2 + winSize.width/2, -mapPosY*1.2 + winSize.height/2)
                        self._view._map:setScale(1.2)
                    end)))
            end
        end
        messageID = GameMessage.MC_UI_SHOW_ENDLESS_SPACE
        -- 公会任务
    elseif (functionType == FUNCTION_TYPE.GUILD_TASK) then
        if GameDataManager:getInstance():getIsJoinGuild() then
            messageID = GameMessage.MC_UI_SHOW_GUILD_TASK
        end
        -- 公会科技
    elseif (functionType == FUNCTION_TYPE.GUILD_TECH) then
        if GameDataManager:getInstance():getIsJoinGuild() then
            -- messageID = GameMessage.MC_UI_SHOW_GUILD_TECH
            mvc.openPanel("Guild", "GuildTechOrSkill", spriteID)
        end
    -- 公会管理员
    elseif (functionType == FUNCTION_TYPE.GUILD_MANAGER) then
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            messageID = GameMessage.MC_UI_SHOW_GUILD_MANAGER
        else
            messageID = GameMessage.MC_UI_SHOW_GUILD_CREATE_OR_JOIN
        end
    -- 公会商人
    elseif (functionType == FUNCTION_TYPE.GUILD_MARKET) then
        -- if(isMiniMap) then
        --     Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        -- end 

        -- mvc.send("Open_Panel","GuildShop", nil, target:getSpriteID())
    elseif functionType == FUNCTION_TYPE.DUNGEON_SEASON_REWARD then

    elseif functionType == FUNCTION_TYPE.ACTIVITY then
        if not ServerConfigUtil:isInReview() then
            messageID = GameMessage.MC_UI_SHOW_ACTIVITY_PANEL
            if(isMiniMap) then 
                param = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_BigMap
            else 
                param = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_NPC
            end
        end
    -- 宝石镶嵌
    elseif (functionType == FUNCTION_TYPE.GEMSTONE_INLAID) then
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_GEM_INLAY
    -- 宝石合成
    elseif (functionType == FUNCTION_TYPE.GEMSTONE_COMPOSE) then
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_GEM_SYNTHESIS
    -- 宝石转化
    elseif (functionType == FUNCTION_TYPE.GEMSTONE_TRANSFORM) then
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_GEM_TRANSFORM
    -- 符文连接
    elseif (functionType == FUNCTION_TYPE.FUNCTION_GEMCONNECT) then
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_GEM_GEM_CONNECT
    -- 符文分解
    elseif (functionType == FUNCTION_TYPE.FUNCTION_GEMDECOMPOSE) then
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_GEM_GEM_DECOMPOSE
    -- 宝石购买
    elseif (functionType == FUNCTION_TYPE.GEMSTONE_BUY) then
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_GEM_BUY
    elseif (functionType == FUNCTION_TYPE.HOME_SYSTEM_MINE) then
    -- 金矿
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_HOME_GOLDEN_MINE_SHOW_UI
    elseif (functionType == FUNCTION_TYPE.HOME_SYSTEM_GEM) then
    -- 符文工坊
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_HOME_GEM_FACTORY_SHOW_UI
    elseif (functionType == FUNCTION_TYPE.SKILL_ADVANCED) then 

        messageID = GameMessage.MC_UI_UPGRADE_SKILL
    elseif (functionType == FUNCTION_TYPE.EQUIPMENT_ILLUSION) then 
    -- 幻化
        messageID = GameMessage.MC_UI_EQUIP_ILLUSION_SHOW
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_DREAM) then 
        -- 梦境试验
        messageID = GameMessage.MC_UI_SHOW_DREAM_CHALLENGE
        if(isMiniMap) then 
            param = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_BigMap
        else 
            param = PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_NPC
        end
    elseif (functionType == FUNCTION_TYPE.EQUIP_CONVERT) then 
        -- TODO 装备转换
        self:_triggerMoveMap(target, 2.5, 1.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_EQUIP_CONVERT
    elseif (functionType == FUNCTION_TYPE.FUNCITON_TYPE_DREAM_TASK) then
        -- 梦境阶段挑战无法接受任务
        if MasterDataManager:getDreamChallengeIsPhase() then
            UI.ScrollBar:createByText(UI.TEXT_1324305)
            return
        else
            messageID = GameMessage.MC_ROLE_SHOW_GET_DREAM_TASK
        end
    elseif (functionType == FUNCTION_TYPE.EQUIP_RECAST) then 
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        messageID = GameMessage.MC_UI_SHOW_EQUIP_RECAST
    
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_GET) then 
        -- self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end
        mvc.send("Open_Panel","StarPray", "StarPrayShop", spriteID)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_STARPRAY_EQUIP) then 
        -- self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end 
        mvc.send("Open_Panel","StarPray", nil, spriteID)

    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_PETTREASURE) then 
        -- self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end

        mvc.send("PetTreasure_Open_Main_view", spriteID, "PetTreasureGatherLayer")

    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_PETRECYCLINGSHOP) then 
        -- self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end

        mvc.send("PetTreasure_Open_RecyclingShop_view", spriteID, "RecyclingShopGoodsLayer")

    elseif (functionType == FUNCTION_TYPE.EQUIP_REFINE) then
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end
        if mvc.recastModel then
            mvc.recastModel:setNpc(spriteID)
        end
        mvc.openPanel("Recast", "RecastRefine", nil, spriteID)
    elseif (functionType == FUNCTION_TYPE.EQUIP_SET_CHANGE) then 
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end
        if mvc.recastModel then
            mvc.recastModel:setNpc(spriteID)
        end
        mvc.openPanel("Recast", "EquipSuitTransform", nil, spriteID)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION) then 
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end
        mvc.send("Open_Panel","Expedition", nil, spriteID)
    elseif (functionType == FUNCTION_TYPE.DESERT_EYE) then 
        messageID = GameMessage.MC_TOWN_SHOW_LEVEL_SELECT
        -- param = Game.LevelSelectLayerType.Desert_Eye

        local lastLayerType = cc.UserDefault:getInstance():getIntegerForKey(UserDefaultKeyWord.LastSelectDesertCaveLayerType..GameDataManager:getInstance():getMasterPK(), 0)
        local layerType = lastLayerType == 0 and Game.LevelSelectLayerType.Desert_Eye or lastLayerType
        param = layerType
        
    elseif (functionType == FUNCTION_TYPE.DISTORTED_SPACE) then
        messageID = GameMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT
        if(GameManager:getIsInNewScene()) then
            param = Game.LevelSelectLayerType.Distorted_Space
        end
    elseif (functionType == FUNCTION_TYPE.FUNCTION_INFERNO) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("Cave", "InfernoLevelSelect")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_VOID_RIFT) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("Cave", "VoidRiftLevelSelect")
    elseif (functionType == FUNCTION_TYPE.EQUIP_LEVEL_REMOVE) then 
        self:_triggerMoveMap(target, 1.5, 0.5, true, isMiniMap)
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end 
        if mvc.recastModel then
            mvc.recastModel:setNpc(spriteID)
        end
        mvc.openPanel("Recast", "RecastRemoveLevel", spriteID)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL) then 
        mvc.openPanel("Festival", "Festival", spriteID)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_WISHPOOL) then 
        mvc.openPanel("WishPool", "WishPool", spriteID)
    elseif (functionType == FUNCTION_TYPE.GUILD_WRIT) then 
        mvc.openPanel("Guild", "GuildWrit", spriteID)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_PETDEVELOP) then 
        -- local pet = RoleDataManager:getCaptain()
        local pet = MasterDataManager:getCaptainPet()
        if pet then
            mvc.openPanel("Pet", "PetMain")
        else
           UI.ScrollBar:createByText(UI.TEXT_1325004 )
        end
    elseif (functionType == FUNCTION_TYPE.GUILD_AUCTION_STOCK) then 
        local guildData = MasterDataManager:getGuildData()
        if guildData and guildData:isInJoinCdTime() then
            UI.ScrollBar:createByText(UI.TEXT_1213916)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE, true)
        else
            mvc.openPanel("Guild", "GuildAuctionStock", spriteID)
        end
    elseif (functionType == FUNCTION_TYPE.GUILD_AUCTION_MAIN) then 
        local guildData = MasterDataManager:getGuildData()
        if guildData and guildData:isInJoinCdTime() then
            UI.ScrollBar:createByText(UI.TEXT_1213914)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE, true)
        else
            mvc.openPanel("GuildAuction", "GuildAuction", spriteID)
        end
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TYPE_HOME) then 
        local callBack = function()
            Net.NetRoleSystem:reqEnterHomeScene()
        end
        if(GameManager:getIsInNewScene()) then
            UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_1325006, callBack)
        else
            callBack() 
        end
    elseif (functionType == FUNCTION_TYPE.FUNCTION_GHOST_LEVELSELECT) then
        mvc.openPanel("Cave", "GhostabyssLevelSelect")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_GHOST_SHOP) then 
        mvc.openPanel("Cave", "GhostabyssShop")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_GHOST_ABYSS_ACTIVATED_TOTEM) then
        local data = {}
        data.extendInt = 0
        data.spriteID = 0
        if(target and target:getData() and target:getData().getGhostType ~= nil) then
            data.extendInt = target:getData():getGhostType()
            data.spriteID = target:getData():getSpriteID()
        end
        print("FUNCTION_GHOST_ABYSS_ACTIVATED_TOTEM data=", data)
        local ProtobufUtil = require("utils.ProtobufUtil")
        if(mvc.caveModel:getStatusGhostAbyssSceneInfoData(data.extendInt) == ProtobufUtil:enum_id("RoleSystem.GhostAbyssTotemStatus","Depleted")) then
            UI.ScrollBar:createByText(UI.TEXT_1328016)
        else 
            GameManager:stopMoveHandler()
            mvc.openPanel("Cave", "GhostabyssSelect", data)
        end
    elseif (functionType == FUNCTION_TYPE.FUNCTION_GHOST_ABYSS_TOTEM) then 
        --TODO 处理激活
    elseif (functionType == FUNCTION_TYPE.FUNCTION_BOSS_PORTAL) then 
        messageID = GameMessage.MC_BATTLE_BOSS_DIRECT
        param = target:getNpcData()
    elseif (functionType == FUNCTION_TYPE.FUNCTION_FISH_SHOP) then 
        mvc.openPanel("FishGear", "FishGearShop")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TRAVELING_BUSINESSMAN) then
        -- 旅行商人
        local GameInManorManager = require "app.game.GameInManorManager"
        local haveNumber = GameInManorManager:getInstance():getSaleGoodsNumber()
        if haveNumber <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_221800)
            UI.UIManager:setShowMainUI(true)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
        else

            if(GameDataManager:getInstance():getFreePacketBoxNum() == 0) then 
                --背包已满，请先清理 
                UI.ScrollBar:createByText(UI.TEXT_1212011)
                UI.UIManager:setShowMainUI(true)
                Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
                return
            end

            --打开界面
            local pData = GameInManorManager:getInstance():getPeddlerShopData()
            if pData then
                UI.TipsLayer:onManorBuyPeddler(function(saleID, saleCount)   -- 确认回调
                    if saleCount > 0 then
                        Net.NetManorSystem:reqSellGoodsForPeddler(saleID,saleCount)
                    end
                    UI.UIManager:setShowMainUI(true)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
                end, function()
                    UI.UIManager:setShowMainUI(true)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
                end, pData.saleID, pData.giveID, pData.givePrice, haveNumber, true)
            end

        end
    elseif (functionType == FUNCTION_TYPE.FUNCTION_SUIT_TRANSFORMATION) then
        -- 套装改造
        mvc.openPanel("SuitTransformation", "SuitTransformation")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_MANOR_DESK) then
        -- 航海星图 (书桌)
        mvc.openPanel("ManorStarMap", "ManorStarMap")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_MANOR_DRESS_UP_SHELF) then
        -- 装备架
        -- print(" target ================ ", target:getNpcData():getId())
        -- dump(target)
        local GameInManorManager = require "app.game.GameInManorManager"
        local shelfIndex = GameInManorManager:getShelfNPCIDTransToIndex(target:getNpcData():getId())
        mvc.openPanel("ManorDressUpShelf", "ManorDressUpShelf",shelfIndex)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_BARTER) then 
        if(isMiniMap) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_HIDE)
        end 
        if mvc.barterTableModel then
            mvc.barterTableModel:setNpc(spriteID)
        end
        mvc.openPanel("BarterTable", "BarterTable", nil, spriteID)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_MANOR_BOAT) then 
        mvc.send("Dock_Open_Main_View")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_MANOR_HOUSEKEEPER) then 
        mvc.send("Manor_Appearance_Open_Main_View")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_MANOR_DININGTABLE) then 
        mvc.send("Table_Open_Main_View")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_VIKING) then
        if TeamDataManager:getReadyState() then
            UI.ScrollBar:createByText(UI.TEXT_1212055)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER, nil)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
            return
        end 
        -- 打开副本界面
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("ViKing", "ViKingLevelSelect")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_EVER_WINTER) then 
        if TeamDataManager:getReadyState() then
            UI.ScrollBar:createByText(UI.TEXT_1212055)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER, nil)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
            return
        end
        mvc.openPanel("EverWinterRift", "EverWinterRiftMain")
        local userKey = GameDataManager:getInstance():getSaveUserKey()
        local isFisrt = cc.UserDefault:getInstance():getBoolForKey(userKey..UserDefaultKeyWord.FirstOpenPannel..functionType, true)
        if isFisrt then
            require("app.game.BlackDialogManager")
            Game.BlackDialogManager:getInstance():addEevntSyncIfFree(BlackDialogEventType.FIRST_OPEN_PANNEL, 0, 0, 0, functionType, function()
                cc.UserDefault:getInstance():setBoolForKey(userKey..UserDefaultKeyWord.FirstOpenPannel..functionType, false)
            end)
        end
        
    elseif (functionType == FUNCTION_TYPE.FUNCTION_PET_STONE) then 
        -- 宠物宝石
        mvc.openPanel("PetGemStoneDevelopment", "PetGemStoneDevelopment")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_TREASURE_IDENTIFY) then 
        --宝藏鉴定
        mvc.openPanel("IdentifyTreasureItem", "IdentifyTreasureItem")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_REINCARNATION) then 
        --角色转生
        local masterData = RoleDataManager:getMaster()
        local advanceStat = masterData:getAdvanceStat()
        if advanceStat == 0 then
            UI.ScrollBar:createByText(UI.TEXT_224304)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
            return
        end
        mvc.openPanel("RoleReincarnation", "RoleReincarnation")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_MOLDFORING) then 
        --模具锻造
        mvc.openPanel("RuneMold", "RuneMold")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_MOLDUSE) then 
        --模具使用
        mvc.openPanel("UseMold", "UseMold")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_NAVIGATION_STORE) then 
        --大航海商人
        local initIndex = {typeIndex = FUNCTION_TYPE.FUNCTION_NAVIGATION_STORE}
        mvc.openPanel("BigSailPort", "BigSailPort", initIndex)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_NAVIGATION_TASK) then 
        --大航海任务
        local initIndex = {typeIndex = FUNCTION_TYPE.FUNCTION_NAVIGATION_TASK}
        mvc.openPanel("BigSailPort", "BigSailPort", initIndex)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_NAVIGATION_SUPPLY) then 
        --大航海码头
        local initIndex = {typeIndex = FUNCTION_TYPE.FUNCTION_NAVIGATION_SUPPLY}
        mvc.openPanel("BigSailPort", "BigSailPort", initIndex)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_CHAOS) then 
        --混沌虫洞
        if TeamDataManager:getReadyState() then
            UI.ScrollBar:createByText(UI.TEXT_1212055)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER, nil)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
            return
        end 
        -- 打开副本界面
        mvc.openPanel("ChaosWormhole", "ChaosWormholeLevelSelect")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_GLYPH) then 
        --雕纹
        mvc.send("Glyphs_Open_Main_View", 1)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_WORMHOLE) then 
        if TeamDataManager:getReadyState() then
            UI.ScrollBar:createByText(UI.TEXT_1212055)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER, nil)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
            return
        end
        mvc.openPanel("DeepInWormhole", "DeepInWormholeMain")
        local userKey = GameDataManager:getInstance():getSaveUserKey()
        local isFisrt = cc.UserDefault:getInstance():getBoolForKey(userKey..UserDefaultKeyWord.FirstOpenPannel..functionType, true)
        if isFisrt then
            require("app.game.BlackDialogManager")
            Game.BlackDialogManager:getInstance():addEevntSyncIfFree(BlackDialogEventType.FIRST_OPEN_PANNEL, 0, 0, 0, functionType, function()
                cc.UserDefault:getInstance():setBoolForKey(userKey..UserDefaultKeyWord.FirstOpenPannel..functionType, false)
            end)
        end
    elseif (functionType == FUNCTION_TYPE.FUNCTION_CHANGEPURPLE) then 
        -- 紫升红
        mvc.send("PurpleUpgrade_Open_Main_View", 1)
    elseif (functionType == FUNCTION_TYPE.FUNCTION_BET) then  
        -- 拉力赛
        mvc.openPanel("Bet", "BetMain")
        Net.NetBigSailSystem:reqBetBaseInfo(0)
        -- mvc.openPanel("Bet", "RallyGame")
    elseif (functionType == FUNCTION_TYPE.FUNCTION_RALLYGAME) then  
        Net.NetBigSailSystem:reqBetBaseInfo(0)
        -- if(mvc.betModel:getInGameTime() > 0) then 
            mvc.openPanel("Bet", "RallyGame")
            Net.NetRoleSystem:reqOpenFuntionTypeUI(functionType)
        -- else
        --     UI.ScrollBar:createByText(UI.TEXT_227638)
        --     Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER, nil)
        --     Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
        --     return
        -- end
    else
        assert(false,string.format("Machine:_battleOpenTriggerNpc functionType=%d not handle.",functionType))
    end

    return messageID, operationID, param
end

function Machine:_triggerMoveMap(target, offsetX, offsetY, npcCenter, isMiniMap)
    if(GameManager:getIsInNewScene()) then 
        return
    end

    if(isMiniMap) then 
        return 
    end
    if(target) then
        local mapPosX, mapPosY = self:_calculationNpcShowPosition(target, offsetX, offsetY, npcCenter)

        self._view._map:stopAllActions()
        self._view._map:runAction(cc.MoveTo:create(0.2,cc.p(-mapPosX*1.2 + winSize.width/2, -mapPosY*1.2 + winSize.height/2)))
        self._view._map:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2,1.2,1.2),cc.CallFunc:create(function()
                self._view._map:setPosition(-mapPosX*1.2 + winSize.width/2, -mapPosY*1.2 + winSize.height/2)
                self._view._map:setScale(1.2)
            end)))
    end
end

function Machine:judgeRewardBySeasonReward(target)
    -- print("----Machine:judgeRewardBySeasonReward")
    Avalon.MessageCenter:unbindForName(AvalonMessage.MC_RANK_DUNGEON_SEASON_TO_REWARD) 
    local curRank = MasterDataManager:getDungeonRanking()
    -- dump(curRank, "---curRank = ")
    local GameInDungeonManager = require "app.game.GameInDungeonManager"
    local rewards = GameInDungeonManager:getInstance():getSeasonRewardFromConfig(curRank)
     -- 判断背包是否满了
    local goodsArr = {}
    for k,v in ipairs(rewards) do
        local data = {}
        data.goodsID = v:getId()
        data.num = v:getNum()
        data.isGolden = v:getIsGolden()
        table.insert(goodsArr, data)
    end
    local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
    if not enough then
        UI.ScrollBar:createByTextID(1110793)
        return
    end
    local spriteID = nil
    if(target) then 
        spriteID = target:getSpriteID()
    end
    GameManager:reqDungeonSeasonReward(spriteID)
end

function Machine:_battleTriggerNpcForTemplateID(templateID)
    local npcModelArr = self._model:getNpcsForTemplateID(templateID)
    -- print("Machine:_battleTriggerNpcForTemplateID", templateID)
    if(npcModelArr) then 
        for k,model in pairs(npcModelArr) do 
            -- 这里直接触发NPC打开
            Net.NetNPCSystem:openTriggerNpcRequest(model:getSpriteID())
        end
    end
end

function Machine:_battleTriggerNpcActivityCrying()
    local npcModelArr = self._model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.ACTIVITY)
    if(npcModelArr) then 
        local activityArr = MasterDataManager:getActivityDataArr()

        local cryingFlag = false
        if(activityArr) then
            for k, activityData in ipairs(activityArr) do 
                if(activityData:getIsNew()) then
                    cryingFlag = true
                    break
                end
                if(activityData:getIsHaveAward()) then
                    cryingFlag = true
                    break
                end 
            end
        end

        -- print("Machine:_battleTriggerNpcActivityCrying", cryingFlag)

        for k,model in pairs(npcModelArr) do 
            local directionCommand = Command.RendererCommand:create(true)
            directionCommand:initActivityCrying(model:getId(), cryingFlag)
            self:pushCommand(directionCommand)
        end
    end
end

function Machine:_battleMasterStopMove(coordX,coordY)
    local master =  self._model:getMaster()
    local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
    if firstAction then
        if firstAction:getFSMState() ~= FSMState.BATTLE then
            Net.NetRoleSystem:heroStopMoveRequest(coordX, coordY)

            --判断脚下是否是钓鱼地点
            local mapData = GameMapManager:getInstance():getMapData()
            if mapData then
                local tileData = mapData:getTileDataAtCoord(coordX, coordY);
                -- local tileData2 = mapData:getTileDataAtCoord(4, 9);
                -- print("  caocaocaocaoo  ",coordX,coordY)
                -- dump(tileData)
                -- print("  caoca2222ocaocaoo  ")
                -- dump(tileData2)
                if tileData and tileData:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.FISH) then
                    -- 展示钓鱼界面
                    local GameInManorManager = require "app.game.GameInManorManager"
                    GameInManorManager:getInstance():openFishingView()
                -- else 
                --     --test
                --     -- 展示钓鱼界面
                --     local GameInManorManager = require "app.game.GameInManorManager"
                --     GameInManorManager:getInstance():openFishingView()
                   
                end
            end

        end
    else 
        Net.NetRoleSystem:heroStopMoveRequest(coordX, coordY)
    end
    
    if SceneManager:getInstance():isInBigCrack() then
        --触发采集的action
        for spriteId, collect in pairs(self._model._collectNpcMap) do
            local collectData = collect:getData()
            local coord = collect:getCoord()
            if coord.x == coordX and coord.y == coordY then
                mvc.send(mvc.events.COLLECT_START, collectData)
                break
            end
        end
    end
end

function Machine:_battleUseAssistSkill(spriteID, skillData, params)
    local master =  self._model:getRoleBySpriteID(spriteID)
    if master and skillData then
        if(skillData:getSkillID() == TRANSFER_SKILL_ID and master:isMaster()) then
            GameDataManager:getInstance():setDisableSituation(true)
        end

        -- 停止移动
        local moveStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if (moveStateAction and (moveStateAction:getFSMState() == FSMState.MOVE)) then
            if(master:isMaster()) then
                GameManager:disableMovingHandler()
            end
            moveStateAction:stop(handler(self,function ()
                Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                    if(skillData:getSkillID() == TRANSFER_SKILL_ID) then
                        GameManager:enableMovingHandler()
                    else 
                        GameManager:enableMovingHandler(true)
                    end
                    self:_handleUseAssistSkill(master, skillData, params)
                end, 0.01)
            end))
        else
            self:_handleUseAssistSkill(master, skillData, params)
        end
    end
end

function Machine:_handleUseAssistSkill(master, skillData, params)
    if(master and skillData) then
        -- GameManager:enableMovingHandler()

        self._actionTrack:_clearAction(TRACKS_INDEX.FSM, master:getId())

        local skill = Model.Skill:create(true)
        skill:init(skillData)

        if(skillData:getSkillID() == TRANSFER_SKILL_ID and master:isMaster())then
            -- print("Machine:_handleUseAssistSkill  run")
            GameManager:disableMovingHandler()
        end

        -- 渲染技能释放的动画
        if(master) then
            local command = Command.RendererCommand:create(true)
            command:initReleaseAssistSkillCommand(master:getId(), skill)
            SceneManager:getInstance():pushCommand(command)
        end

        local skillActTargetType,actAnimMount,actAnimName,actAnimTiming = skill:getReleaseActAnimation()

        -- print("SkillAction  releaseSkill wwwwwwwwwww", self._target:getSpriteID())
        if(skillActTargetType and actAnimMount and actAnimName and actAnimTiming) then 
            -- print("SkillAction  releaseSkill eeeeeeee", self._target:getSpriteID(), #skillActTargetType, #actAnimMount, #actAnimName,  #actAnimTiming)
            if(#skillActTargetType ==  #actAnimMount and #actAnimMount == #actAnimName and #actAnimName == #actAnimTiming) then
                for i=1,#skillActTargetType do 
                    local target = master

                    if(actAnimMount[i] == "mount_screen") then
                        -- 触发事件id
                        local PlotManager = require("app.game.PlotManager")
                        PlotManager:getInstance():runPlotByID(actAnimName[i])
                    else 
                        -- print("SkillAction  releaseSkill nnnnn", self._target:getSpriteID(), actAnimName[i], actAnimMount[i], actAnimTiming[i], 1)
                        if(target) then
                            local command = Command.RendererCommand:create(true)
                            command:initReleaseActAnimationCommand(master:getId(), master:getSpriteID(), actAnimName[i], actAnimMount[i], actAnimTiming[i], 1, master:getDirection())
                            SceneManager:getInstance():pushCommand(command)
                        end
                    end
                end
            end
        end

        if(master and master:isMaster()) then
            local targetSpriteID = nil
            local coordX = nil
            local coordY = nil

            if(params) then
                targetSpriteID = params.targetSpriteID
                coordX = params.coordX
                coordY = params.coordY
            end

            if (RoleBehaviorManager:useAssistSkillCheck()) then 
                Net.NetRoleSystem:heroUseSkillRequest(skillData:getSkillID(),targetSpriteID, coordX, coordY)
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SUCCECD_USE_SKILL)
            end 
        end
    end 
end

function Machine:_controlLoadScene(data)
    if(GameManager:getIsInNewScene()) then 
        self:_loadMapScene(Game.TOWN_MAP_TYPE.MAINCITY)
    else
        local mapData = GameMapManager:getInstance():getMapData()
        if (not mapData) then
            self._model:createMap(data)
            mapData = self._model:getMapData()
        else
            self._model:setMapData(mapData)
        end

        if (mapData) then
            self._view:showMap(mapData, self, Machine._onShowMapCompleteHandler)
            -- 处理英雄模式激活的事件
            mapData:handleSpecialEvent(data.heroCaveActionIDs)
            -- 处理英雄模式事件
            mapData:handleHeroCaveSchemeIDs(data.heroCaveSchemeIDs)
            -- mapData:handleTitanHeroCaveSchemeIDs(data.heroCaveSchemeIDs)

            Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_SPECIAL_EVENT)
        end
    end
end

function Machine:_loadMapScene(townMapID)
    -- 处理切换地图场景，用于在主城里面打开公会，家园场景
    local mapData = ConfigManager:getTownMapDataByID(townMapID)
    if (mapData) then
        self._model:createMap(mapData)
    end
    if (mapData) then
        self._view:showMap(mapData, self, Machine._onShowMapCompleteHandler)        
    end

    -- 这里处理添加NPC对象
    -- DecorationFrequency = {30},  NPCIDlist = {10406002,10405001},  NPCCoordinate = "-100,-100;100,100",  NPCLayer = "20,50", 
    if(mapData) then 
        local spriteID = 4294967295 + 10000

        local coordArr = string.split(mapData.NPCCoordinate, ";")
        local indexArr = string.split(mapData.NPCLayer, ",")
        if(#coordArr == #indexArr and #coordArr == #mapData.NPCIDlist) then 
            for key,npcID in ipairs(mapData.NPCIDlist) do 
                local coord = string.split(coordArr[key], ",")
                local triggerNpcData = Data.TriggerNpcData:create(npcID)
                triggerNpcData.spriteID = spriteID
                triggerNpcData.coordX = tonumber(coord[1])
                triggerNpcData.coordY = tonumber(coord[2])
                -- 传递相关参数
                triggerNpcData:setNewSceneData({index=tonumber(indexArr[key])})
                spriteID = spriteID + 1

                -- 初始化小红点的逻辑处理
                local allFunctionType = triggerNpcData:getAllFunctionType()
                for k, v in ipairs(allFunctionType) do
                    RedPointManager:registerRedPoint(v, function()
                        return Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(v)
                    end)
                end
                RedPointManager:registerCollectRedPoint(triggerNpcData:getId(), allFunctionType)

                -- triggerNpcData:setCoord(Geome.Coord:create(tonumber(coord[1]), tonumber(coord[2]), 0))
                local box,isUpdate = self._model:addOrUpdateRole(Category.TRIGGER_NPC, triggerNpcData:getType(),triggerNpcData)
                if(box) then 
                    if (CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT) then
                        self._view:drawRectInBg(triggerNpcData:getTouchRect())
                    end

                    self._view:addView(box)                     
                end
            end
        else
            printError("ShareMachineFunction ProfileClientTownMap.lua  NPCIDlist,NPCCoordinate,NPCLayer, number is not equal.") 
        end
    end
end

-- 进入场景
function Machine:_controlEnterScene()
    if SceneManager:getInstance():isInPetPVP() then
        local center = ConfigManager:getGeneralForKey("petPvPFocusPos")
        if SceneManager:getInstance():getSceneType() == PublicDefine.SCENE_TYPE.BIGSAILPORT then
            local level = GameMapManager:getInstance():getLevel()
            local centerList = string.split(ConfigManager:getNavigationGeneralConfigByID(1).petFightFocusPos, ";")
            local mapIDList = ConfigManager:getNavigationGeneralConfigByID(1).mapId
            local mapCenterPosMap = {}
            for k,v in pairs(mapIDList) do
                mapCenterPosMap[tonumber(v)] = centerList[k]
            end

            center = mapCenterPosMap[level]
        end
        
        local pos = string.split(center, ",")

        if Avalon.issUtil:isLikeIphoneX() then
            self._view._map:updateMapTileAround(checkint(pos[1]) + 0.5, checkint(pos[2]) - 0.5)
            self._view:setMapPositionByCoordinate({x = checkint(pos[1]) + 0.5, y = checkint(pos[2]) - 0.5}, false)
        else
            self._view._map:updateMapTileAround(checkint(pos[1]), checkint(pos[2]))
            self._view:setMapPositionByCoordinate({x = checkint(pos[1]), y = checkint(pos[2])}, false)
        end
        AudioUtil:playSceneMusic()
        return
    end

    if(SceneManager:getInstance():isInLostRealm()) then 
        -- 移动到地图中心点
        local lostRealmServerData = mvc.festivalModel:getLostRealmData()
        if lostRealmServerData then
            local currentStep = lostRealmServerData.currentStep
            local endStep = mvc.festivalModel:calculationLostRealmID(currentStep)
            local twoStep = mvc.festivalModel:calculationLostRealmID(currentStep + 1)
  
            -- print("_controlEnterScene _controlLostRealmRun=", lostRealmServerData, currentStep, endStep, twoStep)
            local lostRealmData = ConfigManager:getLostRealmByID(endStep)
            if(lostRealmData) then 
                local coordX = lostRealmData.Location[1]
                local coordY = lostRealmData.Location[2]

                local masterData = RoleDataManager:getMaster()
                if(masterData) then
                    masterData.coordX = coordX
                    masterData.coordY = coordY
                    masterData:setCoord({x=coordX, y= coordY, z = 0})

                    -- 切换方向
                    local twoRealmData = ConfigManager:getLostRealmByID(twoStep)
                    local direction = Geome.computeDirection({x=coordX, y= coordY, z = 0}, {x=twoRealmData.Location[1], y= twoRealmData.Location[2], z = 0})
                    masterData:setDirection(direction)
                    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                        if(self._model:getMaster()) then
                            MachineManager:getInstance():pushDirectionRendererCommand(self._model:getMaster(), direction)
                        end

                        self._view:triggerLostRealm(coordX, coordY, true)
                    end, 0.2)

                    -- print("_controlEnterScene _controlLostRealmRun 2=", {x=coordX, y= coordY, z = 0})
                end
            end
        end
        local centerCoord = {x = 4, y = 4}
        local str = ConfigManager:getGeneralForKey("LostRealmCenter")
        local strArr = string.split(str, ",")
        if(strArr and #strArr == 2)then
            centerCoord = {x = tonumber(strArr[1]), y = tonumber(strArr[2])}
        end
        self._view:setMapPositionByCoordinate(centerCoord, true)
        self._view:setMapScale(0.8)
        self:_initLostRealmAnimation()
    end

    GoodsDataManager:refreshShortcutBar()
    -- 记录开始之前是否已经解锁了扭曲空间，这里会影响后面对于沙之眼的引导
    self._preDistortedSpaceUnlockType = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace)

    --恢复本地保存的buff 数据
    local masterData = RoleDataManager:getMaster()

    if(masterData) then
        local bufferList = SkillDataManager:getBufferDataListForSpriteID(masterData:getSpriteID())    
        if bufferList then
            for _,buffData in pairs(bufferList) do
                buffData:setTargetSpriteID(masterData:getSpriteID())
                -- print("CONTROL_ADD_BUFFER  ROLE_ENTER_SCENE getBufferDataListForSpriteID", buffData.buffID, buffData.entityID, buffData.spriteID)
                local command = Command.ControlCommand:create(true)
                command:initForAddBuff(buffData, true)
                SceneManager:getInstance():pushCommand(command)
            end
        end
    end

    self:_addHero(SCREEN_TYPE.MASTER,masterData)
    -- 恢复玩家的buff 数据
    local saveBuff = SkillDataManager:getSaveRecoverBuffData()
    -- dump(saveBuff)
    if(saveBuff and masterData) then
        self:_recoverBuff(saveBuff, masterData)
    end
    SkillDataManager:saveRecoverBuffData(nil)

    local pet = RoleDataManager:getScreenFightPetData()
    if isFromChangeSceneUsedInEnterScence then
        isFromChangeSceneUsedInEnterScence = false
        if pet then
            for k, v in pairs(pet) do
                self:_addPet(SCREEN_TYPE.MASTER, v)
            end
        end
    end
    local saveBuff = SkillDataManager:getPetRecoverBuffData()
    if pet and saveBuff then
        self:_recoverBuff(pet, saveBuff)
    end
    SkillDataManager:savePetRecoverBuffData(nil)
    
    -- 根据楼层判断当前是否为BOSS层，以及是那个BOSS 
    local isBossScene = false
    local bossLevel = 0
    if(not GameManager:getIsInNewScene()) then 
        isBossScene = self._model:getMapData():isBossScene()
        bossLevel = self._model:getMapData().number
    end
    if not isBossScene then
        -- boss 过场动画的时候不播放音乐 CO-2178
        
        AudioUtil:playSceneMusic()
    end
    -- 触发进入场景的剧情事件
    if SceneManager:getInstance():isInDungeon() then
        if(isBossScene) then 
            local plotID = nil
            if(bossLevel == 1) then
                
            elseif (bossLevel == 2) then
                plotID = 2020010
            elseif (bossLevel == 3) then
                
            elseif (bossLevel == 4) then
                
            elseif (bossLevel == 5) then
                
            end
            
            if(plotID) then
                PlotManager:getInstance():runPlotByID(plotID)
            end
        end
    else 
        if(isBossScene) then 
            local plotID = nil
            if(bossLevel == 1) then
                
            elseif (bossLevel == 2) then
                
            elseif (bossLevel == 3) then
                
            elseif (bossLevel == 4) then
                
            elseif (bossLevel == 5) then
                plotID = 1050041
            end
            
            if(plotID) then
                -- print("Machine:_controlBossBeginScenario  plotID=", plotID)
                PlotManager:getInstance():runPlotByID(plotID)
            end

            if(bossLevel == 8) then
                local bossModel = self._model:getBoss()
                if(bossModel) then
                    ToolsUtil:triggerHandleMap8Moon(bossModel:getState() == FSMState.BATTLE, true)
                else 
                    ToolsUtil:triggerHandleMap8Moon(false, false)
                end
            elseif(bossLevel == 15) then
                local bossModel = self._model:getBoss()
                if(bossModel) then
                    ToolsUtil:triggerHandleMap15Moon(bossModel:getState() == FSMState.BATTLE, true)
                else 
                    ToolsUtil:triggerHandleMap15Moon(false, false)
                end
            end
        end
    end


    if MasterDataManager:isHaveNewMail() then
        Game.MailManager:getInstance():noticeNewFlag()
    end

    -- 触发提示深渊房间TIPS
    self:_handleTriggerDungeonRoomTips(masterData, true)

    -- 刷新角色表现
    local master = self._model:getMaster()
    if(master) then
        self:pushRefreshWearEquipmentCommand(master, GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)

        self:_triggerOpenMiniMap(master, master:getCoord())

        -- 触发相关效果
        -- print("Machine:_controlEnterScene ")
        if(master:getIsDead() == false) then
            self:handleMapTrigger(TRIGGER_TYPE.TRIGGER_ALL, master:getCoord(), master:isMaster(), false, true, GameTriggerTimeType.TRIGGER_TIME_NORMAL)
        end
        self:moveOneStepTrigger()
    end

    -- 在节日活动模式下,全部角色都会变身
    if( SceneManager:getInstance():isInMaze()) then 
        local mazeTransID = ConfigManager:getGeneralForKey("mazeTransformId")
        if(mazeTransID) then 
            local mazeArr = string.split(mazeTransID, ",")
            if(mazeArr and #mazeArr == 2) then 
                local heroArr = self._model:getAllHero()
                if(heroArr) then 
                    for k,v in pairs(heroArr) do 
                        if v:isMaster() then 
                            v:getRoleData():setLooks(tonumber(mazeArr[1]))
                        else 
                            v:getRoleData():setLooks(tonumber(mazeArr[2]))
                        end
                        v:getRoleData():handleLooks(0)
                    end 
                end
            end
        end

        if mvc.festivalModel:getFightRemindCD() > 0 then
            mvc.openPanel("Festival", "FestivalCD")
        end
    end

    if(SceneManager:getInstance():isInHero() 
        or SceneManager:getInstance():isInTitanHero()) then 
        -- 触发英雄模式时间导致的怪物变形表现
        local allMonster = self._model:getAllMonsterModel()
        for k,monsterModel in ipairs(allMonster) do 
            self:_handleSpecialEvent(monsterModel)
        end

        if(self._model) then 
            local mapData = self._model:getMapData()
            if(mapData) then 
                local eventDeformation = mapData:getHaveSpecialEventDeformation()
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FULL_SPECIAL_EVENT_DEFORMATION, eventDeformation)
            else 
                printError("Machine:_handleSpecialEvent no found mapData.")
            end
        end
    end 

    -- 处理蘑菇的变身处理逻辑
    if(masterData) then 
        -- print("_controlEnterScene  masterData:getDelusion() ", masterData:getDelusion())
        self:_battleItemDelusionInit(masterData:getSpriteID(), masterData:getDelusion())

        if SceneManager:getInstance():isInBigCrack() then
            --触发采集的action
            for spriteId, collect in pairs(self._model._collectNpcMap) do
                local collectData = collect:getData()
                local coord = collect:getCoord()
                if coord.x == coordX and coord.y == coordY then
                    mvc.send(mvc.events.COLLECT_START, collectData)
                    break
                end
            end
        end
    end

    if(not GameManager:getIsInNewScene()) then 
        -- 添加装饰类陷阱表现
        -- 这里采用最大的值防止ID 重复
        local spriteID = 4294967295 + 10
        local mapData = self._model:getMapData()
        if(mapData and mapData.decorationTrapConfig and #mapData.decorationTrapConfig >0) then
            for _,config in ipairs(mapData.decorationTrapConfig) do 
                if(config.num <= #config.coordArr) then
                    local coordArr = clone(config.coordArr)
                    for i=1,config.num,1 do 
                        local data = {}
                        data.templateID = config.trapID 
                        local index = math.random(#coordArr)
                        data.coordX = coordArr[index].x
                        data.coordY = coordArr[index].y
                        data.spriteID = spriteID
                        spriteID = spriteID + 1
                        local triggerNpcData = Data.TriggerNpcData:create(data.templateID)
                        triggerNpcData:changeInit(data)
                        self:_addTriggerNpc(SCREEN_TYPE.SCREEN, triggerNpcData)

                        table.remove(coordArr, index)
                    end
                end
            end
        end

        -- 添加巡逻NPC
        local setting = GameManager:getCustomHQ(CUSTOM_HQ_TYPE.DECORATE)
        if(setting and mapData and mapData.patrolNpcConfig and #mapData.patrolNpcConfig >0) then
            for _,config in ipairs(mapData.patrolNpcConfig) do 
                local coordArr = clone(config.coordArr)

                table.insert(coordArr, clone(coordArr[1]))
                -- 处理相关的路线问题
                local data = {}
                data.templateID = config.templateID 
                local index = math.random(#coordArr)
                data.coordX = coordArr[1].x
                data.coordY = coordArr[1].y
                data.spriteID = spriteID
                spriteID = spriteID + 1
                -- print("ddddddddddddddd  add one npc", index, data.coordX, data.coordY)
                local triggerNpcData = Data.TriggerNpcData:create(data.templateID)
                triggerNpcData:changeInit(data)
                self:_addTriggerNpc(SCREEN_TYPE.SCREEN, triggerNpcData)
                
                -- print("ddddddddddddddd  add one npc  npcType=", triggerNpcData:getType())
                local npcTarget = self._model:getRoleBySpriteID(data.spriteID)
                if(npcTarget) then
                    -- print("ddddddddddddddd  add one npc  npcType, target=", triggerNpcData:getType(), npcTarget:getType())
                    local moveStateAction = Action.MoveStateActionForNpc:create(true)
                    moveStateAction:init(npcTarget, self, self._model)

                    moveStateAction:setClickMove(coordArr)
                    self:setAction(moveStateAction)
                end
            end
        end
    end
    
    -- 后台触发活动多语言的获取
    if SceneManager:getInstance():isNotInFightScene() then
        MasterDataManager:backgroundRequestAllActivityWebLanguage()
    end 
    
    Avalon.MessageCenter:notice(AvalonMessage.MC_MAP_LOADED, self._model:getMapData())
    -- by CMonk
    -- 发送进入场景的消息
    Avalon.MessageCenter:notice(AvalonMessage.MC_ROBOT_CONTROL_ENTER_SCENE)
    -- eo CMonk

    -- 上报角色进入游戏
    local gameLoginManager = require("app.game.GameLoginManager")
    gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.EnterGameDone)
    
    if(SceneManager:getInstance():isInHuLu()) then 
        Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
            local level = GameMapManager:getInstance():getLevel()
            -- print("isInHuLu", level, PublicDefine.CONST_DEFINITION.HULU_MAP_ID)
            if(level == PublicDefine.CONST_DEFINITION.HULU_MAP_ID + 1) then
                -- print("isInHuLu  2 run")
                Avalon.MessageCenter:notice(AvalonMessage.MC_FEASTIVAL_SETTING_SKILL)
            end

            if(#mvc.festivalModel:getRandomLegacyArr() >0) then
                mvc.openPanel("Festival", "FestivalRelicsSelect")
            end
        end, 0.2)
    end

    if(SceneManager:getInstance():isInInferno() or SceneManager:getInstance():isInTrialLand()) then 
        Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
            if(#mvc.caveModel:getInfernoDiamondRandom() >0) then
                mvc.openPanel("Cave", "InfernoSelect")
            end
        end, 0.2)
    end

    if(SceneManager:getInstance():isInVoidRift()) then 
        Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
            if(#mvc.caveModel:getVoidRiftDiamondRandom() >0) then
                mvc.openPanel("Cave", "VoidRiftSelect")
            end
        end, 0.2)
    end

    if(SceneManager:getInstance():isInViKing()) then 
        Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
            if(#mvc.viKingModel:getViKingDiamondRandom() >0) then
                mvc.openPanel("ViKing", "ViKingSelect")
            end
        end, 0.2)
    end
    

    if(GameManager:getIsShowAutoBattle()) then 
        Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
            Avalon.MessageCenter:notice(AvalonMessage.MC_ENTER_AUTO_FIGHT_SCENE)
        end, 1)
    end

    if(SceneManager:getInstance():isGhostAbyss()) then 
        local _mapData = GameMapManager:getInstance():getMapData()
        if(_mapData) then
            local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
            local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(_mapData.level)
            Avalon.AudioManager:playMusicByConfig(_mapData.caveMode, level);
        end

        if(mvc.caveModel:getIsShowEnterSceneNotice()) then
            Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                UI.ScrollBar:createByText(UI.TEXT_1328019)
            end, 1)
        end
    end
end

function Machine:_refreshPatrolNpc()
    local setting = GameManager:getCustomHQ(CUSTOM_HQ_TYPE.DECORATE)    
    if not setting then
        return 
    end 
    local mapData = self._model:getMapData()
    local npcList = self._model:getModelByModelType(Category.TRIGGER_NPC, PublicDefine.TRIGGER_NPC_TYPE.PATROL_NPC) 
    if(mapData and mapData.patrolNpcConfig and #mapData.patrolNpcConfig >0) then
        for i, config in ipairs(mapData.patrolNpcConfig) do 
            local coordArr = clone(config.coordArr)
            table.insert(coordArr, clone(coordArr[1]))
            local npcTarget = npcList[i]
            if(npcTarget) then
                npcTarget:setCoord(coordArr[1].x, coordArr[1].y)
                local moveStateAction = Action.MoveStateActionForNpc:create(true)
                moveStateAction:init(npcTarget, self, self._model)

                moveStateAction:setClickMove(coordArr)
                self:setAction(moveStateAction)
            end
        end
    end
end

function Machine:_handleSpecialEvent(monsterModel)    
    if(monsterModel == nil ) then 
        return 
    end

    if(monsterModel:getIsHeroDeformation()) then 
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initItemDeformationShow(monsterModel:getId(), monsterModel:getDeformationData())
        self:pushCommand(renderCommand)
        return 
    end

    local defomationID = nil
    local defomationArr = {}

    if(self._model) then 
        local mapData = self._model:getMapData()
        if(mapData) then 
            defomationArr = mapData:getDeformationArr()
        else 
            printError("Machine:_handleSpecialEvent no found mapData.")
        end
    end

    -- TODO 这里是模拟获取的相关特殊事件数据
    -- local allSpecialEventArr = require("profiles/commonProfile/ProfileSpecialEventID")
    -- local specialEventData = allSpecialEventArr[5]
    -- if specialEventData.Type == PublicDefine.SPECIAL_EVENT_TYPE.SPECIAL_EVENT_TYPE_DEFORMATION then 
    --     if specialEventData.eventFloor ~= "" then 
    --         local typeArr = string.split(specialEventData.eventFloor,";")
            
    --     end

    --     if #specialEventData.value1 == #specialEventData.value2 then 
    --         for key,value in ipairs(specialEventData.value1) do 
    --             defomationArr[tonumber(value)] = tonumber(specialEventData.value2[key])
    --         end
    --     end
    -- end

    defomationID = defomationArr[monsterModel:getMonsterType()]

    if(defomationArr[monsterModel:getMonsterID()]) then 
        defomationID = defomationArr[monsterModel:getMonsterID()]
    end
    
    if(defomationID) then 
        monsterModel:setHeroDeformationID(defomationID)
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CHANGE_TYPE, monsterModel)

        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initItemDeformationShow(monsterModel:getId(), monsterModel:getDeformationData())
        self:pushCommand(renderCommand)
    end
end

function Machine:_controlScreenPet(data)
    if(GameManager:getIsInNewScene()) then return end
    local petData = RoleDataManager:handleScreenPetData(data)

    -- 清理掉所有buff
    SkillDataManager:clearDataForSpriteID(petData:getSpriteID())
    local pet = self:_addPet(SCREEN_TYPE.SCREEN, petData)

    if pet then
        local petData = pet:getRoleData()
        --判断是否是狐仙变身,如果是,则显示变身效果
        if petData.isTransform and petData.templateID == 1032 then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_SCREEN_PET_TRANSTORM, petData)
            SceneManager:getInstance():pushCommand(command)
        end
    end

    -- 恢复所有buff 效果
    if data.buff then
        self:_recoverBuff(data.buff, petData)
    end
end

function Machine:_controlScreenHero(data)
    -- if(GameManager:getIsInNewScene()) then return end
    -- 这里使用data 初始化数据会带来很多没有使用的数据
    local masterData = RoleDataManager:getMaster()
    -- 屏蔽玩家自己的相关数据
    if(masterData and (masterData:getPK() == data.pk or masterData:getSpriteID() == data.spriteID)) then 
        if(masterData:getSpriteID() == data.spriteID) then 
            if (device.platform == "ios" or device.platform == "android") then
                buglyReportLuaException("controlScreenHero screenHero sprite equil masterSpriteID", "masterPK="..tostring(masterData:getPK()).."screenPK="..tostring(data.pk))
            end
        end
        return
    end

    local heroData = RoleDataManager:handleScreenHeroData(data)

    if(heroData) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_HERO,heroData)
    end

    -- 清理掉所有buff
    SkillDataManager:clearDataForSpriteID(heroData:getSpriteID())

    -- 处理穿戴装备恢复
    local change = false
    for k,equiMes in ipairs(data.equipment) do
        local goodsData = GoodsDataManager:createEquipmentForEquipmentID(equiMes.templateID)
        if(goodsData) then 
            goodsData:setWearPosition(equiMes.index)
            goodsData:setIllusionID(equiMes.illusionID)
            goodsData:setPrimogemID(equiMes.primogemid)
            GoodsDataManager:addEquipEquipment(data.spriteID,goodsData)    
            change = true
        end
    end
    if change then
        -- 发送英雄装备变动
        local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(data.spriteID)
        Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)

        -- 渲染层指令
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_WEAR_EQUIPMENT_CHANEG, wearData)
        SceneManager:getInstance():pushCommand(command)
    end

    self:_addHero(SCREEN_TYPE.SCREEN, heroData)
    -- 恢复所有buff 效果
    if data.buff then
        self:_recoverBuff(data.buff, heroData)
    end
end

function Machine:_controlGlobalTriggerNPC(data)
    if(GameManager:getIsInNewScene()) then return end

    local triggerNpcData = RoleDataManager:handleTriggerNpcData(data)

    self:_addTriggerNpc(SCREEN_TYPE.GLOBAL, triggerNpcData)
end

function Machine:_controlScreenTriggerNPC(data)
    if(GameManager:getIsInNewScene()) then return end

    local triggerNpcData = RoleDataManager:handleTriggerNpcData(data)

    -- ghostabyss
    if(SceneManager:getInstance():isGhostAbyss()) then 
        
    end

    self:_addTriggerNpc(SCREEN_TYPE.SCREEN, triggerNpcData)
end

function Machine:_controlGlobalMonster(data)
    if(GameManager:getIsInNewScene()) then return end

    local monsterData = RoleDataManager:handleMonsterData(data, GameMapManager:getInstance():getModel(), GameMapManager:getInstance():getDifficulty())
    if(monsterData) then
        self:_addMonster(SCREEN_TYPE.GLOBAL, monsterData)
    end
end

function Machine:_controlScreenPetTransform(data)
    local modelID = nil
    local renderer = nil

    -- print("进来了  222 ")
    -- dump(data,nil,10)

    local role = self._model:getRoleBySpriteID(data.spriteID)
    if (role) then
        modelID = role:getId()
    end

    if (modelID) then
        renderer = self._view:getRenderer(modelID)
    end

    -- print("   modelID ====== ",modelID, renderer,renderer.createFoxSpiritTransformHero)

    if(renderer and renderer.createFoxSpiritTransformHero) then
        renderer:createFoxSpiritTransformHero(data)
    end
end

-- 在动画表现完成后才会触发
function Machine:_triggerDelayMonster()
    print("_triggerDelayMonster 1")
    if(self._delayMonsterData) then 
        for k,data in ipairs(self._delayMonsterData) do 
            print("_triggerDelayMonster 2")
            self:_controlScreenMonster(data, true)
        end

        self._delayMonsterData = {}
    end
end

function Machine:_controlScreenMonster(data, isDelay)
    if(GameManager:getIsInNewScene()) then return end
    local monsterData = RoleDataManager:handleMonsterData(data, GameMapManager:getInstance():getModel(), GameMapManager:getInstance():getDifficulty())
    -- ghostabyss
    if(SceneManager:getInstance():isGhostAbyss() and isDelay ~= true) then
        local coord = monsterData:getCoord()
        local modelArr = self._model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.FUNCTION_GHOST_ABYSS_TOTEM)
        if(modelArr) then 
            for k,model in ipairs(modelArr) do 
                local nowCoord = model:getCoord()
                -- print("_controlScreenMonster 1", nowCoord.x, nowCoord.y, monsterData.coordX, monsterData.coordY)
                if(nowCoord.x == monsterData.coordX and nowCoord.y == monsterData.coordY) then 
                    --添加缓存数据，等触发再切换过去
                    if(self._delayMonsterData == nil) then 
                        self._delayMonsterData = {}
                    end
                    table.insert(self._delayMonsterData, data)
                    return
                end
            end
        end
    end
    
    if(monsterData) then 
        self:_addMonster(SCREEN_TYPE.SCREEN, monsterData)

        -- 清理以前所有的BUFF
        SkillDataManager:clearDataForSpriteID(monsterData:getSpriteID())

        -- 恢复所有buff 效果
        if data.buff then
            self:_recoverBuff(data.buff, monsterData)
        end

        -- 初始化所有词缀
        if(data.affix) then
            monsterData:clearAllAffix()
            for _,affixID in ipairs(data.affix) do
                monsterData:addAffix(affixID)
            end
        end
    end
end

function Machine:_controlAddBuff(data, isRecover)
    local buffData = SkillDataManager:handleBufferData(data, isRecover)
    if(buffData) then
        self:_handleAddBuff(buffData, buffData.targetSpriteID, isRecover)
    end
    if SceneManager:getInstance():isInBigCrack()  then
        -- 发送添加buffer的消息
        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_ADD_BUFFER, {
            bufferData = buffData,
            bufferEntityID = data.entityID,
            bufferTargetID = data.targetSpriteID
        })
    end
end

function Machine:_controlSkillAdvanced(data)
    local hero = self._model:getMaster()
    if hero then
        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initSkillAdvanced(hero:getId())
        self:pushCommand(directionCommand)
    end
end

function Machine:_controlGuildBossRereshAll()
    local npcArr = self._model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_GUILDBOSS)
    if(npcArr) then 
        -- print("_controlGuildBossRereshAll  0", #npcArr)
        for k, npcModel in pairs(npcArr) do 
            -- self._model:removeRole(npcModel)
            local data = {}
            data.spriteID = npcModel:getSpriteID()
            local npcData = npcModel:getData()
            local bossData = npcData:getGuildBossData()
            -- print("_controlGuildBossRereshAll 1", npcData:getId())
            -- if(bossData) then
            --     print("_controlGuildBossRereshAll 1 2", npcData:getId(), bossData:getBossIndex(), bossData:getBossID(), bossData:getIsFighting())
            -- end
            for i=1,10,1 do 
                self:_controlRemoveScreenRole(data)
            end
            self._view:removeView(npcModel, true)
        end
    end

    local triggerNpcArr = RoleDataManager:getTriggerNpcArr()
    if(triggerNpcArr) then
        local npcArr = {}
        for k, triggerNpcData in pairs(triggerNpcArr) do 
            if(triggerNpcData and triggerNpcData:hasFunction(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_GUILDBOSS)) then 
                table.insert(npcArr, triggerNpcData)
            end
        end 
        
         table.sort(npcArr,function (a,b) 
            if(a:getSpriteID() == b:getSpriteID()) then
                if(a:getInstanceID() < b:getInstanceID()) then 
                    return true
                end
            elseif (a:getSpriteID() > b:getSpriteID()) then
                return true
            end

            return false
        end)

        local bossArr = mvc.guildModel:getBossDataArr()
        
        for k, npcData in pairs(npcArr) do 
            if(bossArr) then 
                local bossData = bossArr[k]
                -- print("_controlGuildBossRereshAll 2", npcData:getId(), bossData:getBossIndex(), bossData:getBossID(), bossData:getIsFighting())
                npcData:setGuildBossData(bossData)
            end
            self:_addTriggerNpc(SCREEN_TYPE.SCREEN, npcData)
        end
    end
end

function Machine:_controlGuildBossStatusChange()
    local npcArr = self._model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_GUILDBOSS)
    if(npcArr) then 
        for k, npcModel in ipairs(npcArr) do 
            local directionCommand = Command.RendererCommand:create(true)
            directionCommand:initGuildBossStatusUpdate(npcModel:getId(), npcModel:getData():getGuildBossData())
            self:pushCommand(directionCommand)
        end
    end
end

function Machine:_controlMazePoint(data)
    -- print("Machine:_controlMazePoint", data)
    if(data) then 
        if(data.type == "MazePointType_Trap") then
            local trapArr = self._model:getTrapPointArr()
            for k,trap in ipairs(trapArr) do 
                local trapCoord = trap:getCoord()
                if(trapCoord.x == data.x and trapCoord.y == data.y) then 
                    local directionCommand = Command.RendererCommand:create(true)
                    directionCommand:initMazePoint(trap:getId(), data)
                    self:pushCommand(directionCommand)
                end
            end
        else
            local directionCommand = Command.RendererCommand:create(true)
            directionCommand:initMazePoint(nil, data)
            self:pushCommand(directionCommand)
        end
    end
end

function Machine:_controlMazeFunExplore(itemData)
   -- print("Machine:_controlMazeFunExplore")
    local master = self._model:getMaster()
    if(master and itemData) then 
        local range = itemData.useRange
        -- print("Machine:_controlMazeFunExplore", range)
        self:_controlMazeTrapView(true, range)
        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initForTypeAndData(CommandType.RENDERER_MAZE_FUN_EXPLORE, master:getId(), true)
        self:pushCommand(directionCommand)

        -- Avalon.Scheduler:scheduleUpdateOnce(self, self._controlMazeFunExploreEnd, 3)
    end
end

function Machine:_controlQuickDown(data)
    -- print("Machine:_controlQuickDown", data)
    GameMapManager:getInstance():setCanQuickDown(data.canQuickDown)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_QUICK_DOWN_CHANGE, GameMapManager:getInstance():getCanQuickDown())
end

function Machine:_controlScenePauseOrResume(data)
    Avalon.Scheduler:unscheduleUpdateOnce(self, self._scenePauseResume)
    -- print("Machine:_controlScenePauseOrResume", AvalonUtil.getCurrentTime())
    self:pause()
    self._view:pause()
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, true)
    GameManager:closeCountDownSwitch()

    -- 采用倒计时恢复
    Avalon.Scheduler:scheduleUpdateOnce(self, self._scenePauseResume, data.freezeTime/TIME_UNIT)
    mvc.openPanel("FullScreeen", "FullScreeenEffect", {freezeTime = data.freezeTime, displayID = data.displayID})
end

function Machine:_scenePauseResume()
    -- print("Machine:_scenePauseResume", AvalonUtil.getCurrentTime())
    self:resume()
    self._view:resume()
    GameManager:openCountDownSwitch()
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCENE_PAUSEORRESUME, false)
    mvc.closePanel("FullScreeen", "FullScreeenEffect")
end

function Machine:_controlMazeFunExploreEnd()
    local master = self._model:getMaster()
    if self and master then
        self:_controlMazeTrapView(false)
        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initForTypeAndData(CommandType.RENDERER_MAZE_FUN_EXPLORE, master:getId(), false)
        self:pushCommand(directionCommand)
    end
end

function Machine:_controlMazeTrapView(isShow, range)
    local master = self._model:getMaster()
    if(master) then 
        local trapArr = self._model:getTrapPointArr()
        local haveArr = {}
        if(isShow) then 
            if(range == nil) then 
                return 
            end
        end
        -- 避免无效的指令生成
        if(isShow) then 
            self._controlMazeTrapViewFlag = true
        else 
            if(self._controlMazeTrapViewFlag == nil) then 
                return
            end
            self._controlMazeTrapViewFlag = nil
        end

        local coord = master:getCoord()
        for k,trap in ipairs(trapArr) do 
            local trapCoord = trap:getCoord()
            local add = false
            if(isShow)then
                if(math.abs(trapCoord.x - coord.x) + math.abs(trapCoord.y - coord.y) < range) then 
                    add = true
                end
            else 
                add = true
            end
            -- 判断是否为非玩家的陷阱
            if add and trap:getData() and trap:getData():getTransPointType() ~= PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_ROLE_END and not MasterDataManager:getIsHaveMasterTrapMazePointForCoord(trapCoord.x, trapCoord.y) then 
                table.insert(haveArr, trap)
            end
        end

        -- print("Machine:_controlMazeTrapView", #haveArr)
        for k, trap in ipairs(haveArr) do 
            local directionCommand = Command.RendererCommand:create(true)
            directionCommand:initForTypeAndData(CommandType.RENDERER_MAZE_TRAP_VIEW, trap:getId(), isShow)
            self:pushCommand(directionCommand)
        end
    end
end

function Machine:_controlShowTeamReady(data)
    require("app.ui.town.levelSelect.LevelSelectReady")
    local pLevelSelectReady = UI.LevelSelectReady:create(data)
    UI.UIManager:getRootNode():addChild(pLevelSelectReady,UI_ZORDER.LEVEL_SELECT_TEAM)
end

function Machine:_controlShowTeamConfire(data)
    require("app.ui.activity.ActivityTimeBarTips")
    local tips = UI.ActivityTimeBarTips:create(data.remainTime)
    tips:center()
    UI.UIManager:getRootNode():addChild(tips, UI_ZORDER.LEVEL_SELECT_TEAM)
end



function Machine:_controlRemoveAffixFromAllMonster(data)
    RoleDataManager:handleRemoveAffixForAllMonster(data)
end

function Machine:_controlNotifyHeroStartMove(data)
    local hero = self._model:getRoleBySpriteID(data.spriteID)
    --  print("Machine:onExecuteControlCommand  CONTROL_NOTIFY_HERO_START_MOVE 1 coord.X,coord.Y=",coord.x,coord.y)
    if hero then
        local coord = {}
        coord.x = data.coordX
        coord.y = data.coordY
        -- print("Machine:onExecuteControlCommand  CONTROL_NOTIFY_HERO_START_MOVE 2 coord.X,coord.Y=",coord.x,coord.y)

        self:_fsmDirectionMove(hero,data.direction,data.timeStamp,coord)
    end
end

function Machine:_controlNotifyHeroStopMove(data)
    local hero = self._model:getRoleBySpriteID(data.spriteID)
    if hero then
        local coord = {}
        if data.coordX == nil and data.coordY == nil then
            coord.x = hero:getCoord().x
            coord.y = hero:getCoord().y
        else
            coord.x = data.coordX
            coord.y = data.coordY
        end

        local direction = data.direction
        if direction == nil then
            direction = hero:getDirection()
        end


        if DEBUG then
            print("Machine:onExecuteControlCommand  CONTROL_NOTIFY_HERO_STOP_MOVE coord.X,coord.Y=",coord.x,coord.y)
        end

        -- 同步位置
        self:_fsmIdle(hero, coord, true)
        if(SceneManager:getInstance():isActCave()) then
            self:moveOneStepTrigger()
        end

        -- 同步方向
        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initUpdateDirectionCommand(hero:getId(), direction)
        self:pushCommand(directionCommand)
    end
end


function Machine:_controlRoleAttrChange(data)
    RoleDataManager:handleAttrChange(data)

    local ATTR_TYPE = PublicDefine.ATTR_TYPE
    local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
    -- 过滤金币以及钻石修改
    local attrChange = data.attrChange or {}
    for k,attrInfo in pairs(attrChange) do
        if DEBUG_ATTR then
            print("ShareMachine:_handleAttrChangeMes   sourceSpriteID,masterSpriteID,mesData.spriteID=",attrInfo.sourceSpriteID,masterSpriteID,mesData.spriteID)
        end
        
        local localdata = nil
        if attrInfo.changeType == ATTR_TYPE.curCoin  then
            localdata = {}
            localdata.costType = GOODS_COST_TYPE.GOLD
            localdata.value = attrInfo.changeValue
            
        elseif attrInfo.changeType == ATTR_TYPE.curDiamond then
            localdata = {}
            localdata.costType = GOODS_COST_TYPE.GEM
            localdata.value = attrInfo.changeValue
        elseif attrInfo.changeType == ATTR_TYPE.horcruxCoin then
            localdata = {}
            localdata.costType = GOODS_COST_TYPE.HORCRUX_COIN
            localdata.value = attrInfo.changeValue
        elseif attrInfo.changeType == ATTR_TYPE.MarblesFeverHoodle then
            localdata = {}
            localdata.costType = GOODS_COST_TYPE.HORCRUX_COIN
            localdata.value = attrInfo.changeValue
        elseif attrInfo.changeType == ATTR_TYPE.SailGold then
            localdata = {}
            localdata.costType = GOODS_COST_TYPE.SAIL_GOLD
            localdata.value = attrInfo.changeValue
        elseif attrInfo.changeType == ATTR_TYPE.SailDiamond then
            localdata = {}
            localdata.costType = GOODS_COST_TYPE.SAIL_DIAMOND
            localdata.value = attrInfo.changeValue
        elseif attrInfo.changeType == ATTR_TYPE.GemBoughtCredit then
            localdata = {}
            localdata.costType = GOODS_COST_TYPE.GEM_BUY
            localdata.value = attrInfo.changeValue
        elseif attrInfo.changeType == ATTR_TYPE.StarFire then
            localdata = {}
            localdata.costType = GOODS_COST_TYPE.STAR_FIRE
            localdata.value = attrInfo.changeValue
        end

        if(localdata) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, localdata)
        end
    end

    -- 判断是否是角色攻击对象血量减少
    if(SceneManager:getInstance():isInFightScene()) then
        local machine = MachineManager:getInstance():getMachine()
        if(machine) then
            local roleData = RoleDataManager:getRoleDataBySpriteID(data.spriteID)
            if roleData then
                if roleData:getType() == RoleType.Monster then
                    local sameBattle = machine:judgeInSameBattleField(RoleDataManager:getMaster():getSpriteID(), data.spriteID)
                    if(sameBattle) then
                        Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_ATTACK_MONSTER_HP_CHANGE, roleData.curHp, roleData.hp)
                    end
                end
            end
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UPDATE_BASIC_INFO)

    if(SceneManager:getInstance():isInFightScene()) then
        local role = self._model:getRoleBySpriteID(data.spriteID)
        if role then
            local battleMaster = false
            local battleField = self._model:getBattleFieldBySpriteID(data.spriteID,nil)
            if battleField then
                battleMaster = battleField:haveMaster()
            end

            local master = self._model:getMaster()
            local masterSpriteID
            local masterPetSpriteID = nil
            if master then
                masterSpriteID = master:getSpriteID()
                -- if master:getFightPet() then
                --     masterPetSpriteID = master:getFightPet():getSpriteID()
                -- end
                -- if master:getFightPet() then
                --     -- masterPetSpriteID = master:getCaptainPet():getSpriteID()
                --     masterPetSpriteID = RoleDataManager:getCaptain():getSpriteID()
                -- end
                local pets = master:getFightPet()
                if pets and next(pets) then 
                    for _, v in pairs(pets) do
                        if not v:getIsDead() then
                            masterPetSpriteID = v:getSpriteID()
                            -- table.insert(masterPetSpriteID, v:getSpriteID())
                            break
                        end
                        
                    end
                    
                end

                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initUpdateCommonAttrCommand(role:getId(), data)
                self:pushCommand(renderCommand)


                local isMonster = false 
                if(role:getCategory() == Category.ROLE and role:getType() == RoleType.Monster) then
                    isMonster = true
                end

                local mesData = self:_handleAttrChangeMes(data,battleMaster,masterSpriteID, isMonster, masterPetSpriteID)
                local direction = role:getDirection()
                if(role:getType() == RoleType.Monster) then
                    direction = Geome.computeDirection(role:getCoord(), master:getCoord())
                end
                if(role:getType() == RoleType.Hero) then
                    if(role:getIsEscape() == true) then
                        direction = Geome.reverseDirection(direction)
                    end
                end
                
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initUpdateAttrCommand(role:getId(), mesData, direction)
                self:pushCommand(renderCommand)
                -- 判断是否和主角同一场战斗
                if(role:getCategory() == Category.ROLE and role:getType() == RoleType.Monster) then
                    if self:judgeInSameBattleField(masterSpriteID, role:getSpriteID()) == false then
                        -- 更新怪物快捷血条
                        local roleData = role:getData()

                        local renderCommand = Command.RendererCommand:create(true)
                        renderCommand:initUpdateMonsterBlood(role:getId(), roleData:getCurHp(), roleData:getHp())
                        self:pushCommand(renderCommand)
                    end
                end

                
            else 
                local mesData = self:_handleNoFilterAttrChangeMes(data)
                
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initUpdateAttrCommand(role:getId(), mesData, role:getDirection())
                self:pushCommand(renderCommand)
                
                local roleData = role:getData()
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initUpdateMonsterBlood(role:getId(), roleData:getCurHp(), roleData:getHp())
                self:pushCommand(renderCommand)
               
            end
        end
    end 
end

function Machine:_controlHeroPositionSync(data)
    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_POSITION_SYNC)

    local hero = self._model:getMaster()
    if hero then
        -- 移除所有当前状态以及表现
        Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
        local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, hero:getId())
        if firstAction then
            if firstAction:getFSMState() == FSMState.BATTLE then
                firstAction:stopBattle()
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, "")
            end
        end

        local coord = {}
        coord.x = data.coordX
        coord.y = data.coordY

        self:_fsmIdle(hero,coord, false)

        MachineManager:getInstance():pushPositionRendererCommand(hero, coord, true)

        if GameManager:getIsCenterByMaster() then
            -- 移动到地图中心点
            self._view:setMapPositionByCoordinate(coord, true)
        end
        -- 设置中心点灯光效果
        -- self:setNewCenterCoordinate(coord,coord,coord)

        -- 关闭界面
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)

        -- 同步方向
        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initUpdateDirectionCommand(hero:getId(), data.direction)
        self:pushCommand(directionCommand)

        local enterCenterCoordCommand = Command.RendererCommand:create(true)
        enterCenterCoordCommand:initEnterCenterCoordCommand(hero:getId(), coord, true)
        self:pushCommand(enterCenterCoordCommand)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)
        
        if SceneManager:getInstance():isInBigCrack() then
            --触发采集的action
            for spriteId, collect in pairs(self._model._collectNpcMap) do
                local collectData = collect:getData()
                local coord = collect:getCoord()
                if coord.x == coordX and coord.y == coordY then
                    mvc.send(mvc.events.COLLECT_START, collectData)
                    break
                end
            end
        end

    end
end

function Machine:_controlRemoveBuffer(data)
    SkillDataManager:deleteBuff(data.targetSpriteID,data.entityID)

    local found = false
    local bufferActionList = self:getActionListByTrackIndex(TRACKS_INDEX.BUFFER)
    if (bufferActionList) then
        for i=1, #bufferActionList do
            local bufferAction = bufferActionList[i]
            if (bufferAction:hasBuffer(data.targetSpriteID, data.entityID)) then
                bufferAction:removeBuffer(data.entityID)

                found = true
                break;
            end
        end
    end
end

-- 处理刷新buffer 时间
function Machine:_controlRefreshBufferByKind(data)
    local changeArr = SkillDataManager:refreshBuffByBufferType(data.spriteID, data.buffType)

    if(changeArr) then
        for k,bufferData in ipairs(changeArr) do 
            self:_handleResetTimeBuff(bufferData)
        end
    end

    local role = self._model:getRoleBySpriteID(data.spriteID)
    if(role) then
        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REFRESH_BUFFER_KIND, role:getSpriteID())
    end
end

-- 处理刷新buffer 时间
function Machine:_controlRefreshBufferByEffect(data)
    local changeArr = SkillDataManager:refreshBuffByBufferEffectType(data.spriteID, data.effectType)

    if(changeArr) then
        for k,bufferData in ipairs(changeArr) do 
            self:_handleResetTimeBuff(bufferData)
        end
    end

    local role = self._model:getRoleBySpriteID(data.spriteID)
    if(role) then
        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REFRESH_BUFFER_KIND, role:getSpriteID())
    end
end
--
function Machine:_controlRefreshBufferByInstID(data)
    local changeArr = SkillDataManager:refreshBuffByEntityID(data.spriteID, data.instID)

    if(changeArr) then
        for k,bufferData in ipairs(changeArr) do 
            self:_handleResetTimeBuff(bufferData)
        end
    end
end

function Machine:_controlRemainBufferByInstID(data)
    local changeArr = SkillDataManager:handleBuffRemain(data)
    if(changeArr) then
        for k,bufferData in ipairs(changeArr) do 
            self:_handleResetTimeBuff(bufferData)
        end
    end
end

function Machine:_controlWearEquipmentChange(data)
    local hero = self._model:getRoleBySpriteID(data.spriteID)
    if hero and data then
        local command = Command.RendererCommand:create(true)
        command:initRefreshWearEquipmentCommand(hero:getId(),data.wearEquipmentArr)
        SceneManager:getInstance():pushCommand(command)
    end
end

function Machine:_controlSkinAndFaceChange(data)
    local master = self._model:getMaster()
    if master and data then
        local command = Command.RendererCommand:create(true)
        command:initRefreshSkinAndFaceCommand(master:getId(),data)
        SceneManager:getInstance():pushCommand(command)
    end
end

function Machine:_controlRoleLevelUp(data)
    local hero = self._model:getRoleBySpriteID(data.spriteID)

    if hero then
        local levelUpAction = Action.RoleLevelUpAction:create(true)
        levelUpAction:init(hero,data.startLevel,data.totalLevel)
        
        self:addAction(levelUpAction)

        local master = GameDataManager:getInstance():getMaster()
        if (master and master:getSpriteID() == data.spriteID) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_LEVEL_UP)
        end
    end
end

function Machine:_controlAddEffect(data)
    if(self._model) then
        local target = self._model:getRoleBySpriteID(data.targetSpriteID)
        if target then
            local effectAction = Action.EffectAction:create(true)
            effectAction:initByID(data.effectID,target)
            self:addAction(effectAction)
            if DEBUG then
                print("Machine:onExecuteControlCommand  CONTROL_ADD_EFFECT  end")
            end
        end
    end
end

function Machine:_controlTaskRefresh(taskData)
    -- 获取任务NPC 对象
    local taskNpcArr = self._model:getTaskArr()
    if(taskNpcArr) then
        -- 刷新NPC 表现
        for k,v in pairs(taskNpcArr) do 
            -- 发送任务npc 状态改变消息
            Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_STATUS_CHANGE, v:getNpcData())
        end
    end    

    -- 处理环线任务状态刷新
    local taskArr = TaskDataManager:getAllCycleTaskArr()
    if(taskArr) then 
        for k, taskData in ipairs(taskArr) do 
            local taskNpcArr = self._model:getNpcsForTemplateID(taskData:getCompleteNPCID())
            if(taskNpcArr) then
                -- 刷新NPC 表现
                for k,v in pairs(taskNpcArr) do 
                    -- 发送任务npc 状态改变消息
                    Avalon.MessageCenter:notice(AvalonMessage.MC_NPC_STATUS_CHANGE, v:getNpcData())
                end
            end    
        end
    end
end

-- 修改昵称
function Machine:_controlEditNickName(heroData)
    if(heroData) then
        local role = self._model:getRoleBySpriteID(heroData:getSpriteID())
        if(role) then
            local nameCommand = Command.RendererCommand:create(true)
            nameCommand:initRoleName(role:getId(), role:getName(), true, role:isMaster())
            self:pushCommand(nameCommand)
        end
    end
end

-- 设置引导箭头
function Machine:_controlSetGuidePointer(data)
    local heroData = data.heroData
    local isShow = data.isShow
    local guideTitle = data.guideTitle
    local x = data.x
    local y = data.y

    if(heroData and isShow ~= nil) then
        local role = self._model:getRoleBySpriteID(heroData:getSpriteID())
        if(role) then
            local guidePointerCommand = Command.RendererCommand:create(true)
            guidePointerCommand:initGuidePointer(role:getId(), isShow, guideTitle, x, y)
            self:pushCommand(guidePointerCommand)
        end
    end
end

function Machine:_controlNpcTrapEffect(data)
    local trapNpc = self._model:getRoleBySpriteID(data.spriteID)
    if(trapNpc) then
        -- 触发陷阱效果
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initNpcTrapEffect(trapNpc:getId())
        self:pushCommand(renderCommand)
    end    
end

function Machine:_controlScreenFaceChange(heroData)
    -- 处理同屏脸型改变
    local role = self._model:getRoleBySpriteID(heroData:getSpriteID())
    if(role) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initFaceChange(role:getId(), heroData:getFaceDecodeID())
        self:pushCommand(renderCommand)

        -- 刷新装备
        local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(role:getSpriteID())
        self:pushRefreshWearEquipmentCommand(role, wearData.wearEquipmentArr)
    end
end

function Machine:_controlMasterIdle()
    local master = self._model:getMaster()
    if(master) then
        self:_fsmIdle(master, master:getCoord(), true)
    end
end

-- 使用道具失败
function Machine:_controlUseItemFailed(data)
    -- 使用道具失败
    local goodsData = GoodsDataManager:createLocalGoodsData(data.templateID)
    if(goodsData) then
        if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM and goodsData:getItemType() == PublicDefine.ITEM_TYPE.EscapeScroll then
            local master = self._model:getMaster()
            if(master) then
                local waitingAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
                if (waitingAction and (waitingAction:getFSMState() == FSMState.WAITING)) then
                    -- 站立，移除回城效果
                    self:_fsmIdle(master, master:getCoord(), true)
                end

                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initRoleRemoveBackTown(master:getId())
                self:pushCommand(renderCommand)
            end
        else
            printError(string.format("Machine:_controlUseItemFailed templateID=%d not handle.",data.templateID))
        end
    end

    -- 处理提示语言
    GameErrorManager:showError(ProtobufUtil:enum_id("GoodsSystem.UseItemResult", data.result))
end

function Machine:_controlTrapRemove(data)
    local mapData = self._model:getMapData()
    local coords = data.coord
    if(coords) then
        for k, coord in pairs(coords) do 
            -- MapDataManager:transformTileToReachableAtCoord(mapData, coord.x, coord.y)
            local rendererCommand = Command.RendererCommand:create(true)
            rendererCommand:initMapTileChangeCommand(coord.coordX, coord.coordY)
            self:pushCommand(rendererCommand)
        end
    end
end

function Machine:_controlEndTransScene(data)
    local masterData = RoleDataManager:getMaster()
    if masterData then
        local oldSpriteID = masterData:getSpriteID()

        -- 处理主角的 spriteID 索引处理
        SkillDataManager:switchMasterSpriteID(oldSpriteID,data.spriteID)
        RoleDataManager:switchMasterSpriteID(oldSpriteID,data.spriteID)
        GoodsDataManager:switchMasterSpriteID(oldSpriteID,data.spriteID)
    end

    TaskDataManager:triggerAcceptTask()
end

function Machine:_battleIsHideHelmet(spriteID, isHideHelmet)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        -- print("Machine:_battleIsHideHelmet ", spriteID, isHideHelmet)
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initRoleIsHideHelmet(role:getId(), isHideHelmet)
        self:pushCommand(renderCommand)

        -- 刷新装备
        local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(role:getSpriteID())
        self:pushRefreshWearEquipmentCommand(role, wearData.wearEquipmentArr)
    end
end

-- 战斗状态改变
function Machine:_battleStatusChange(spriteID, attrType, value)
    if(self._model == nil) then 
        return 
    end
    local model = self._model:getRoleBySpriteID(spriteID)

    if(model) then
        local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, model:getId())
        -- print("Machine:_battleStatusChange 2.5=", spriteID, battleStateAction, battleStateAction:getFSMState())
        if (battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE) then
            battleStateAction:statusChange(attrType, value)
        end

        -- 这里如果死亡就不用处理状态变换了
        if(model:getCategory() == Category.ROLE and model:getIsDead() == true) then 
            return
        end

        -- 处理格挡
        if(attrType == FunctionFlag.FunctionFlag_Parrying) then

        -- 沉默标志
        elseif (attrType == FunctionFlag.FunctionFlag_Silence) then
            -- self:_roleStatusHandle(value, model, 4, 4, attrType)
        -- 封印标志
        elseif (attrType == FunctionFlag.FunctionFlag_Seal) then
            -- self:_roleStatusHandle(value, model, 5, 4, attrType)
        -- 眩晕标志
        elseif (attrType == FunctionFlag.FunctionFlag_Stun) then
            -- self:_roleStatusHandle(value, model, 5, 4, attrType)
        -- 无法添加buff 状态
        elseif (attrType == FunctionFlag.FunctionFlag_NoneDebuff) then
            -- self:_roleStatusHandle(value, model, 5, 4, attrType)
        -- 冻结
        elseif (attrType == FunctionFlag.FunctionFlag_Frozen) then
            if(value) then
                -- 添加冻结效果
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initRoleFrozen(model:getId())
                SceneManager:getInstance():pushCommand(animationCommand)
            else
                -- 取消冻结效果
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initRoleFrozenRecover(model:getId())
                SceneManager:getInstance():pushCommand(animationCommand)
            end
            self:_roleStatusHandle(value, model, 2, 4, attrType)
         -- 束缚
        elseif (attrType == FunctionFlag.FunctionFlag_Constraint) then
            if(value) then
                -- 添加冻结效果
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initRoleConstraint(model:getId())
                SceneManager:getInstance():pushCommand(animationCommand)
            else
                -- 取消冻结效果
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initRoleConstraintRecover(model:getId())
                SceneManager:getInstance():pushCommand(animationCommand)
            end
            self:_roleStatusHandle(value, model, 3, 0, attrType)
        -- 变身
        elseif (attrType == FunctionFlag.FunctionFlag_Transforming) then
            if(value) then

                print(" valuevaluevaluevalue=====    ",value)
                --
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initBossShowTransfor(model:getId())
                SceneManager:getInstance():pushCommand(animationCommand)
            else
                
            end
        -- 迷惑
        elseif (attrType == FunctionFlag.FunctionFlag_Reverse) then
            if(model:getData() and model:isMaster()) then
                GameManager:stopMoveHandler()
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REVERSE_CHANGE, model:getData():haveFunctionFlag(FunctionFlag.FunctionFlag_Reverse))
            end
        -- 魅惑
        elseif (attrType == FunctionFlag.FunctionFlag_Charm) then
            
        else

        end
    end
end

function Machine:_roleStatusHandle(value, target, statusType, roleType, attrType)
    if(value) then
        local statusConfig = ConfigManager:getRoleStatusForStatusTypeOrRoleType(statusType, roleType)
        if(statusConfig ) then
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initRoleStatusShow(target:getId(), attrType, statusConfig.fxAnimName, statusConfig.fxMountPoint)
            SceneManager:getInstance():pushCommand(renderCommand)
        end
    else 
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initRoleStatusEnd(target:getId(), attrType)
        SceneManager:getInstance():pushCommand(renderCommand)
    end 
end

function Machine:_battleNPCInfomationShow(spriteID, textStr)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local renderCommand = Command.RendererCommand:create(true)
        -- add by zp 这里假设了所有来自UI的都属于引导类对话框，对于UI直接不消失
        renderCommand:initNPCInfomationShow(role:getId(), textStr, 999999999)
        SceneManager:getInstance():pushCommand(renderCommand)
        local npcData = role:getNpcData()
        if(npcData) then
            npcData:setNpcGuideInfomationFlag(true)
        end
    end
end

function Machine:_battleNPCInfomationHide(spriteID)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initNPCInfomationHide(role:getId())
        SceneManager:getInstance():pushCommand(renderCommand)
        local npcData = role:getNpcData()
        if(npcData) then
            npcData:setNpcGuideInfomationFlag(false)
        end
    end
end

function Machine:_battleFuncBtnPauseNPCInfomation(spriteID)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local npcData = role:getNpcData()
        if(npcData) then
            npcData:setFunctionBtnInformationFlag(true)
        end
    end
end

function Machine:_battleFuncBtnResumeNPCInfomation(spriteID)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local npcData = role:getNpcData()
        if(npcData) then
            npcData:setFunctionBtnInformationFlag(false)
        end
    end
end

function Machine:_battleSelectHeroHide(spriteID)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initSelectHeroHide(role:getId())
        SceneManager:getInstance():pushCommand(renderCommand)
    end
end

function Machine:_battleNpcInteractionEnd(spriteID)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initInteractionEnd(role:getId())
        SceneManager:getInstance():pushCommand(renderCommand)
    end
end

function Machine:_battlePreRankChange(data, isAdd)
    if(self._model == nil) then 
        return 
    end
    if(data) then 
        for _,rankData in ipairs(data) do 
            local heroData = RoleDataManager:getHeroDataForPK(rankData.pk)
            if(heroData) then 
                local model = self._model:getRoleBySpriteID(heroData:getSpriteID())
                if(model) then 
                    local category = model:getCategory()
                    if(category == Category.ROLE and model:getType() == RoleType.Monster) then 
                        local renderCommand = Command.RendererCommand:create(true)
                        renderCommand:initDreamWinding(model:getId(), isAdd)
                        SceneManager:getInstance():pushCommand(renderCommand)
                    end 
                end
            end
        end
    end
end

function Machine:_battleHorcruxExterior(spriteID, horcruxExteriorID)
    if(self._model == nil) then 
        return 
    end
    local model = self._model:getRoleBySpriteID(spriteID)
    if(model) then 
        MachineManager:getInstance():pushHorcruxShowOrHideCommand(model)
        -- local category = model:getCategory()
        -- if(category == Category.ROLE and model:getType() == RoleType.Hero) then 
        --     local norHorcruxID = horcruxExteriorID
        --     if(GameManager:getCustomHQ(CUSTOM_HQ_TYPE.HORCRUX) and not model:isMaster()) then 
        --         norHorcruxID = 0
        --     end
        --     print("_battleHorcruxExterior", spriteID, horcruxExteriorID, norHorcruxID)
        --     local renderCommand = Command.RendererCommand:create(true)
        --     renderCommand:initHorcruxExterior(model:getId(), norHorcruxID)
        --     SceneManager:getInstance():pushCommand(renderCommand)
        -- end 
    end
end

function Machine:_battleHeroLooks(spriteID)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initHeroLooks(role:getId(), role:getData():getLooks())
        SceneManager:getInstance():pushCommand(renderCommand)
    end
end

function Machine:_battleHeroTitle(spriteID)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local mentorName = nil
        if (role:getHeroTitleID() and role:getHeroTitleID() ~= 0) then
            -- 获取导师名字
            if (role:getPK() == RoleDataManager:getMasterPK()) then
                local mentor = mvc.apprenticeshipModel:getMentor()
                if (mentor) then
                    mentorName = mentor.nickName
                end
            else
                mentorName = role:getMentorName()
            end
        end

        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initForRoleTitle(role:getId(), role:getHeroTitleID(), mentorName)
            SceneManager:getInstance():pushCommand(renderCommand)
        end, 1)
        -- local renderCommand = Command.RendererCommand:create(true)
        -- renderCommand:initForRoleTitle(role:getId(), role:getHeroTitleID(), mentorName)
        -- SceneManager:getInstance():pushCommand(renderCommand)
    end
end

function Machine:_battleHeroGuildName(spriteID)
    if(self._model == nil) then 
        return 
    end
    local role = self._model:getRoleBySpriteID(spriteID)
    if(role) then
        local heroData = role:getRoleData()
        if(heroData) then 
            local guildName = ""
            local isShow = false
            if(heroData:isMasterHero()) then 
                local guildData = MasterDataManager:getGuildData()
                if(guildData) then 
                    guildName = guildData:getName()
                    isShow = true
                end
            else 
                guildName = heroData:getGuildName()
                if(heroData:getGuildID() ~= 0 or guildName ~= "") then 
                    isShow = true
                end
            end 

            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initForRoleGuildName(role:getId(), guildName, isShow)
            SceneManager:getInstance():pushCommand(renderCommand)
        end
    end
end

function Machine:_battleStartMove(direction)
    if(self._model == nil) then 
        return 
    end
    local master = self._model:getMaster()
    if(master) then 
        if self:_judegeToMove(master) then
            self:_fsmDirectionMove(master, direction,0)
        else 
            local moveStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
            if (moveStateAction and moveStateAction:getFSMState() == FSMState.MOVE) then
                moveStateAction:stop()
            end
        end
    end
end

function Machine:_battleStopMove(sendStop)
    if(self._model == nil) then return end

    local master = self._model:getMaster()
     if master then
        local moveStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if (moveStateAction and (moveStateAction:getFSMState() == FSMState.MOVE)) then
            if(sendStop) then
                -- 发送停止移动
                local coord = master:getCoord()
                if(coord and coord.x ~= nil and coord.y ~= nil) then
                    -- print("Machine:_battleStopMove 1", coord.x, coord.y)
                    -- print("Machine:_battleStopMove  2", Avalon.MathUtil:getInt(coord.x), Avalon.MathUtil:getInt(coord.y))
                    Net.NetRoleSystem:heroStopMoveRequest(Avalon.MathUtil:getInt(coord.x), Avalon.MathUtil:getInt(coord.x))
                end
            end

            self:_fsmStopMove(master)
        end
    end 
end


function Machine:_fsmIdle(target, coord, checkBattleAction)
    if(checkBattleAction == nil) then 
        checkBattleAction = false
    end

    if(target == nil) then 
        return 
    end

    -- print("Machine:_fsmIdle  addIdleAction.", coord.x, coord.y)
    if(checkBattleAction and self._actionTrack) then
        local battleAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
        if (battleAction and (battleAction:getFSMState() == FSMState.BATTLE)) then
            return
        end 
    end

    if(coord) then
        target:setCoord(coord.x, coord.y)
    end

    local action = Action.IDLEStateAction:create(true)
    action:init(target, coord, self)

    -- -- 移动到地图中心点
    -- self._view:setMapPositionByCoordinate(coord, false)
    -- -- 设置中心点灯光效果
    -- self:setNewCenterCoordinate(coord,coord,coord)

    self:setAction(action)
end

function Machine:_fsmDirectionMove(target,direction,serverTime,coord)
    local moveStateAction = self:_getOrCreateMoveStateAction(target)
    if(moveStateAction) then
        moveStateAction:setDirectionMove(direction, serverTime,coord)
    end
end

function Machine:_fsmClickMove(target,moveCoordList,serverTime, moveStartTrigger, moveEndCallBack)
    local moveStateAction = self:_getOrCreateMoveStateAction(target)
    if(moveStateAction) then 
        moveStateAction:setClickMove(moveCoordList, serverTime, moveStartTrigger, moveEndCallBack)
    else 
        self:enableRoleMoving()
    end
end

function Machine:_fsmStopMove(target)
    if(self._actionTrack == nil) then return end
    local moveStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if (moveStateAction and (moveStateAction:getFSMState() == FSMState.MOVE)) then
        -- print(" Machine:_fsmStopMove")
        moveStateAction:stop()
    else
        --  处理站立
        -- if DEBUG then
            -- print("BattleMachine onExecuteFSMCommand: execute stop move command  not found moveAction .")
        -- end
    end
end

function Machine:_triggerOpenMiniMap(heroModel, coord)
    -- print("Machine:_triggerOpenMiniMap 1",heroModel:isMaster() ,SceneManager:getInstance():isInDungeon())
    if(heroModel and heroModel:isMaster()) then 
        if(SceneManager:getInstance():isInDungeon()) then
            -- print("Machine:_triggerOpenMiniMap 2", coord.x, coord.y)
            -- 处理大秘境房间是否触发打开处理逻辑
            if self._model._mapData:isDungeonRoomReachedAtCoordinate(coord.x, coord.y) == false then
                -- print("Machine:_triggerOpenMiniMap 3")
                self._model._mapData:setDungeonRoomReachedAtCoordinate(coord.x, coord.y, true)
                local coordArr = self._model._mapData:getCoordinatesReachableInRoomAtCoordinate(coord.x, coord.y)
                if(coordArr) then
                    -- dump(coordArr)
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_SHOW_ICON, true, coordArr)
                end
            end
        end
    end
end

function Machine:_getOrCreateMoveStateAction(target)
    local moveStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if ((moveStateAction) and (moveStateAction:getFSMState() == FSMState.BATTLE)) then
        return nil
    end

    if ((not moveStateAction) or (moveStateAction:getFSMState() ~= FSMState.MOVE)) then
        moveStateAction = Action.BattleMoveStateActionForMe:create(true)
        moveStateAction:init(target, self, self._model)

        self:setAction(moveStateAction)
        self:addIdleAction(target,nil)
    end

    return moveStateAction
end

function Machine:_battleRoleZorder(spriteID, endIdle, kickSpriteID)
    local target = self._model:getRoleBySpriteID(spriteID)

    if (target and target:getType() == RoleType.Hero) then
        local preCoord = nil
        if target:getPreOrderCoord() then
            preCoord = Geome.Coord:create()
            preCoord:setCoord(target:getPreOrderCoord())
        end

        local nowCoord = nil
        if endIdle then
            nowCoord = Geome.Coord:create()
            nowCoord:setCoord(target:getCoord())
        end

        local zorderAction = Action.RoleZorderAction:create()
        zorderAction:init(preCoord,nowCoord,kickSpriteID)
        self:addAction(zorderAction)

        if endIdle then
            target:setPreOrderCoord(nowCoord)
        else
            target:setPreOrderCoord(nil)
        end
    end

end


-- 处理获取物品
function Machine:_handleAchieveGoods(data)
    -- 处理获得物品表现
    local master = self._model:getMaster()
    if master and data then
        local sourceSpriteID = data.sourceSpriteID
        -- 抛出错误
        if sourceSpriteID == master:getSpriteID() then
            assert(false, "CONTROL_ACHIEVE_GOODS  sourceSpriteID == master.getSpriteID()")
        end

        -- 判断是否为暗金装备
        local isGoldenDark = false
        local goodsData = data.goodsData
        local iconName = nil
        if goodsData then 
            if goodsData:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4 then
                isGoldenDark = true
            end
            iconName = goodsData:getIconName()
            -- 发送获得消息
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_GET_GOODS, goodsData)
        end
        -- 获取来源对象
        local target = self._model:getRoleBySpriteID(sourceSpriteID)
        if target == nil then
            target = self:_getDropModel(sourceSpriteID)
        end
        
        local startCoord = nil
        if target == nil then
            startCoord = {}
            startCoord.x = data.coordX
            startCoord.y = data.coordY
            startCoord.z = 0
        end
        -- 判断是否为自己打开
        local openWithSelf = self:_judgeOpenWithSelf(sourceSpriteID)
        if openWithSelf == false then
            openWithSelf = self:_removeDropCoordTrigger(startCoord)
        end
        -- 移除掉落来源对象
        self:_removeDropTrigger(sourceSpriteID)
        --如果是藏宝图 碎片 要做展示界面， 玩家点击确认后 再飞向背包
        if goodsData and goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM and goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemTreasureMapDebris then 
            GameManager:stopMoveHandler()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_FRAGMENT_DROP, goodsData) 
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_SKILL_POINT_RED_POINT)
        elseif goodsData and goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM and goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemMoldMapDebris then 
            GameManager:stopMoveHandler()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_MOLD_FRAGMENT_DROP, goodsData) 
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_SKILL_POINT_RED_POINT)
        else
            local bullet = nil
            if goodsData then
                bullet = Model.GetGoods:create(true)
                -- 这里需要切换为真实图标
                bullet:init(iconName)
                self._model:addModel(bullet)
            end
            local bulletAction = Action.GetGoodsAction:create(true)
            bulletAction:init(target,isGoldenDark,openWithSelf, bullet, master,"mount_center",startCoord)
            MachineManager:getInstance():setAction(bulletAction)
        end
    end
end


function Machine:_addTransDoor(screenType,data)
    local transDoor,isUpdate = self._model:addOrUpdateRole(Category.NPC, PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR,data)
    if transDoor then
        if screenType == SCREEN_TYPE.GLOBAL then
            if (transDoor and (not isUpdate)) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, data)
            end
        elseif screenType == SCREEN_TYPE.SCREEN then
            self._view:addView(transDoor)

            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, data)
        end
    end
end

function Machine:_addGoldBag(screenType,data)
    local box,isUpdate = self._model:addOrUpdateRole(Category.NPC, PublicDefine.TRIGGER_NPC_TYPE.GOLD_BAG,data)
    if (box) then
        if screenType == SCREEN_TYPE.GLOBAL then

        elseif screenType == SCREEN_TYPE.SCREEN then
            self._view:addView(box)

            -- 同步宝箱状态
            if data.isOpened == true then
                -- 修改钱袋打开状态
                self:_goldBagOpen(box,true)
            end

            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, data)
        end
    end
end

function Machine:_addBox(screenType,data)
    local box,isUpdate = self._model:addOrUpdateRole(Category.NPC, PublicDefine.TRIGGER_NPC_TYPE.BOX,data)
    if box then
        if screenType == SCREEN_TYPE.GLOBAL then
            if (box and (not isUpdate)) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, data)
            end
        elseif screenType == SCREEN_TYPE.SCREEN then
            -- 这里注意相关的逻辑处理
            self._view:addView(box)

            -- 同步宝箱状态
            if data.isOpened == true then
                -- 修改宝箱打开状态
                self:_boxOpen(box,true)
            end

            -- 判断宝箱周围的环境
            local rightRoad = false
            local coord = box:getCoord()

            local leftTileData = self._model:getMapTileData(coord.x + 1, coord.y)
            if leftTileData == nil or (leftTileData and leftTileData:getTerrainType() ~= MapDefine.TerrainType.Wall) then rightRoad = true end

            if rightRoad == false then
                local rightTileData = self._model:getMapTileData(coord.x, coord.y - 1)
                if rightTileData == nil or (rightTileData and rightTileData:getTerrainType() ~= MapDefine.TerrainType.Wall) then rightRoad = true end
            end

            if rightRoad == true then
                local directionCommand = Command.RendererCommand:create(true)
                directionCommand:initUpdateDirectionCommand(box:getId(),DirectionType.EAST)
                self:pushCommand(directionCommand)
                if DEBUG then
                    print("CONTROL_SCREENBOX  updateDirectionCommand ")
                end
            end

            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, data)
        end

    end
end

function Machine:_addPet(screenType,data)
    if(ToolsUtil:getIsShieldPet()) then 
        return 
    end

    local pet = self._model:addOrUpdateRole(Category.ROLE, RoleType.Pet,data)
    if (pet and pet:getMaster() == nil) then
        local petRoleData = pet:getRoleData()
        local masterSpriteID = petRoleData.masterSpriteID
        local master = self._model._heroMap[masterSpriteID]    
        if (master == nil and data.coord == nil) then 
            return
        elseif (master == nil and data.coord) then 
            pet:setCoord(data.coord.x, data.coord.y, 1)
        else
            -- 根据设置判断是否需要隐藏宠物表现
            if(not master:isMaster() and not GameManager:getCustomHQ(CUSTOM_HQ_TYPE.PET)) then 
                for k, v in pairs(self._model._petMap) do
                    if v:getType() == RoleType.Pet and v:getMaster() ~= nil and v:getMaster():getSpriteID() == masterSpriteID and v ~= pet then
                        self._model:removeRole(v)
                        break
                    end
                end      
                return 
            end
            pet:setMaster(master)
            master:setFightPet(pet)
            local coord = master:getCoord()
            pet:setCoord(coord.x, coord.y, coord.z)

            -- for k, v in pairs(self._model._petMap) do
            --     if v:getType() == RoleType.Pet and v:getMaster() ~= nil and v:getMaster():getSpriteID() == masterSpriteID and v ~= pet then--not RoleDataManager:getScreenPetDataByID(v:getSpriteID()) then
            --         local coord = v:getCoord()
            --         pet:setCoord(coord.x, coord.y, coord.z)
            --         -- 停止所有的效果
            --         self._actionTrack:clearActionForEntryId(v:getId())
            --         -- 移除所有buffer
            --         self:_clearAllBufferForRole(v)
            --         self._view:removeView(v, true)
            --         self._model:removeRole(v)
            --         break
            --     end
            -- end        
        end
        if screenType == SCREEN_TYPE.MASTER then
            self._view:addView(pet)
        elseif screenType == SCREEN_TYPE.GLOBAL then

        elseif screenType == SCREEN_TYPE.SCREEN then
            -- 发送添加角色到view
            self._view:addView(pet)
        end
        -- 恢复状态
        if screenType == SCREEN_TYPE.MASTER or screenType == SCREEN_TYPE.SCREEN then
            -- 根据参数恢复相关状态
            local status = data.status
            if(screenType == SCREEN_TYPE.MASTER) then 
                status = pet:getRoleData().status
            end
            if status then
                local coord = pet:getCoord()

                if status == SPRITE_STATUS.IDLE then
                    self:_fsmIdle(pet, coord, true)
                elseif status == SPRITE_STATUS.MOVE then
                    self:_fsmDirectionMove(pet,data.direction,data.timeStamp)
                elseif status == SPRITE_STATUS.DEAD then

                elseif status == SPRITE_STATUS.FIGHT then
                    local attackTarget = nil
                    if data.targetSpriteID ~= nil then
                        attackTarget = self._model:getRoleBySpriteID(data.targetSpriteID)
                    end

                    if self._fsmEnterBattle then
                        self:_fsmEnterBattle(pet, attackTarget,data.targetSpriteID,data.skillID,data.skillState)
                    end

                    -- 处理逃跑逻辑
                    if(screenType == SCREEN_TYPE.MASTER) then
                        if data.residualEscapeTime ~= 0 then
                            local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, pet:getId())
                            if ((not battleStateAction) or (battleStateAction:getFSMState() == FSMState.BATTLE)) then
                                battleStateAction:recoverEscape()
                            end
                        end
                        if(attackTarget) then
                            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ENTER_BATTLE, attackTarget:getData())
                        end
                    else
                        if data.isEscape == true then
                            if (DEBUG) then
                                print("Machine:_addPet isEscape=",data.isEscape)
                            end
                            -- 处理逃跑的处理
                            -- self:_fsmBattleEscape(pet)
                            local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, pet:getId())
                            if ((not battleStateAction) or (battleStateAction:getFSMState() == FSMState.BATTLE)) then
                                battleStateAction:recoverEscape()
                            end
                        end
                    end
                end
            end

            if pet:getIsDead() then
                -- print("ShareMachineFunction  addpet isDead  spriteID=",data:getSpriteID())
                local showRevive = true

                if status == SPRITE_STATUS.FIGHT then
                    showRevive = false
                end

                if(self._fsmDie) then
                    self:_fsmDie(pet, false, showRevive)
                else 
                    
                end
            end
             if SceneManager:getInstance():isInPetPVP() then
                local nameCommand = Command.RendererCommand:create(true)
                nameCommand:initRoleName(pet:getId(), pet:getName(), false, false)
                SceneManager:getInstance():pushCommand(nameCommand)
            else
                local nameCommand = Command.RendererCommand:create(true)
                nameCommand:initRoleName(pet:getId(), pet:getName(), true, false)
                SceneManager:getInstance():pushCommand(nameCommand)
            end           
        end
    end
    return pet
end

function Machine:_addHero(screenType,data)
    if(GameManager:getIsInNewScene()) then return end

    local hero = self._model:addOrUpdateRole(Category.ROLE, RoleType.Hero,data)
    if (hero) then
        if(SceneManager:getInstance():isInMaze()) then 
            local mazeTransID = ConfigManager:getGeneralForKey("mazeTransformId")
            if(mazeTransID) then 
                local mazeArr = string.split(mazeTransID, ",")
                if(mazeArr and #mazeArr == 2) then 
                    if(hero:getRoleData():getLooks() == 0) then
                        if hero:isMaster() then 
                            hero:getRoleData():setLooks(tonumber(mazeArr[1]))
                        else 
                            hero:getRoleData():setLooks(tonumber(mazeArr[2]))
                        end
                        hero:getRoleData():handleLooks(0)
                    end
                end
            end
        end 

        if screenType == SCREEN_TYPE.MASTER then
            self._view:addView(hero)
            if GameManager:getIsCenterByMaster() then
                self._view:setMapPositionByCoordinate(hero:getCoord(), false)
            end
        elseif screenType == SCREEN_TYPE.GLOBAL then

        elseif screenType == SCREEN_TYPE.SCREEN then
            -- 发送添加角色到view
            self._view:addView(hero)
        end
        -- 恢复状态
        if screenType == SCREEN_TYPE.MASTER or screenType == SCREEN_TYPE.SCREEN then
            -- 根据参数恢复相关状态
            local status = data.status
            if(screenType == SCREEN_TYPE.MASTER) then 
                status = hero:getRoleData().status
            end 
            if status then
                local coord = {x = data.coordX,y = data.coordY}

                if status == SPRITE_STATUS.IDLE then
                    -- MachineManager:getInstance():pushIDLECommand(hero,coord,true)
                    self:_fsmIdle(hero, coord, true)
                elseif status == SPRITE_STATUS.MOVE then

                    self:_fsmDirectionMove(hero,data.direction,data.timeStamp)
                elseif status == SPRITE_STATUS.FIGHT then
                    -- print(string.format("Machine:_addHero restore the battle state of hero %d.", data.spriteID))
                    -- 恢复战斗
                    local attackTarget = nil
                    if data.targetSpriteID ~= nil then
                        attackTarget = self._model:getRoleBySpriteID(data.targetSpriteID)
                    end
                    if self._fsmEnterBattle then
                        self:_fsmEnterBattle(hero, attackTarget,data.targetSpriteID,data.skillID,data.skillState)
                    end

                    -- 处理逃跑逻辑
                    if(screenType == SCREEN_TYPE.MASTER) then
                        if data.residualEscapeTime ~= 0 then
                            -- self:_fsmBattleEscape(hero)
                            local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, hero:getId())
                            if ((not battleStateAction) or (battleStateAction:getFSMState() == FSMState.BATTLE)) then
                                battleStateAction:recoverEscape()
                            end
                        end
                        if(attackTarget) then
                            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ENTER_BATTLE, attackTarget:getData())
                        end
                    else
                        if data.isEscape == true then
                            if (DEBUG) then
                                print("Machine:_addHero isEscape=",data.isEscape)
                            end
                            -- 处理逃跑的处理
                            -- self:_fsmBattleEscape(hero)
                            local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, hero:getId())
                            if ((not battleStateAction) or (battleStateAction:getFSMState() == FSMState.BATTLE)) then
                                battleStateAction:recoverEscape()
                            end
                        end
                    end
                end
            end

            -- print("ShareMachineFunction  addHero isDead  spriteID,isDead=",data:getSpriteID(), hero:getIsDead())
            if hero:getIsDead() then
                -- print("ShareMachineFunction  addHero isDead  spriteID=",data:getSpriteID())
                local showRevive = true

                if status == SPRITE_STATUS.FIGHT then
                    showRevive = false
                end

                if(self._fsmDie) then
                    self:_fsmDie(hero, false, showRevive)
                else 
                    
                end
            end

            -- -- 添加队友ODEI
            -- if(TeamDataManager:judgeIsInTeam(hero:getData():getPK())) then
            --     print("############################","MC_BATTLE_ADD_TEAMMETA")
            --     Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_TEAMMETA, hero:getData())
            -- end
        end

        self:_battleHeroTitle(hero:getSpriteID())
        self:_battleHeroGuildName(hero:getSpriteID())
        if not hero:isMaster() then
            -- 清理掉所有buff
            local pets = RoleDataManager:getFollowPet(hero:getSpriteID())
            if pets then
                for k, petData in pairs(pets) do
                    SkillDataManager:clearDataForSpriteID(petData:getSpriteID())
                    self:_addPet(SCREEN_TYPE.SCREEN, petData)
                end
            end
        end

        if SceneManager:getInstance():isInPetPVP() then
            local nameCommand = Command.RendererCommand:create(true)
            nameCommand:initRoleName(hero:getId(), hero:getName(), false, false)
            SceneManager:getInstance():pushCommand(nameCommand)
        else
            -- 添加对于角色名字显示控制
            local nameCommand = Command.RendererCommand:create(true)
            nameCommand:initRoleName(hero:getId(),hero:getName(),true,hero:isMaster())
            SceneManager:getInstance():pushCommand(nameCommand)
        end
    end
end

function Machine:_addMonster(screenType,data)
    if(GameManager:getIsInNewScene()) then return end

    local monster, isUpdate = self._model:addOrUpdateRole(Category.ROLE, RoleType.Monster, data)
    if monster then
        if screenType == SCREEN_TYPE.GLOBAL then
            -- 触发特殊事件变形
            self:_handleSpecialEvent(monster)

            if (monster and (not isUpdate)) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, data)
            end
            -- self._view:addView(monster)
            self:_triggerDeformation(monster)
        elseif screenType == SCREEN_TYPE.SCREEN then
            -- 移除以前得数据，避免出现重叠效果出现，这里可能带来效果跳一下
            -- self._view:removeView(monster)
            -- 发送添加角色到view
            self._view:addView(monster)

            self:_triggerDeformation(monster)

            -- 触发特殊事件变形
            self:_handleSpecialEvent(monster)

            -- 恢复需要触发的怪物状态
            if(data:judgeNeedToTrigger() and data:getIsTrigger()) then
                local rendererCommand = Command.RendererCommand:create(true)
                rendererCommand:initUpdateAnimationCommand(monster:getId(), CommandAnimationType.IDLE, 1.0)
                SceneManager:getInstance():pushCommand(rendererCommand)
            
            -- 处理大秘境模式初始状态
            elseif data:isBigBoss() and SceneManager:getInstance():isInDungeon() then
                local rendererCommand = Command.RendererCommand:create(true)
                rendererCommand:initUpdateAnimationCommand(monster:getId(), CommandAnimationType.IDLE, 1.0)
                SceneManager:getInstance():pushCommand(rendererCommand)
            end

            -- 这里处理怪物的方向
            if(SceneManager:getInstance():isGhostAbyss()) then
                local coord = monster:getCoord()
                if(coord and coord.x <=4 and coord.y > 6) then 
                    monster:setDirection(DirectionType.EAST)
                    MachineManager:getInstance():pushDirectionRendererCommand(monster, monster:getDirection())
                end
            end

            -- 随机怪物方向
            if(data:isBigBoss() == false and SceneManager:getInstance():isGhostAbyss() == false) then
                if math.random(1,10) <= 5 then
                    monster:setDirection(monster:reverseDirection())
                    MachineManager:getInstance():pushDirectionRendererCommand(monster, monster:getDirection())
                end
            else 
                if(data:isBigBoss()) then
                    local bossLevel = self._model:getMapData().number
                    if(bossLevel == 8) then 
                        local bossModel = self._model:getBoss()
                        if(bossModel) then
                            ToolsUtil:triggerHandleMap8Moon(bossModel:getState() == FSMState.BATTLE, true)
                        else 
                            ToolsUtil:triggerHandleMap8Moon(false, false)
                        end
                    elseif(bossLevel == 15) then 
                        local bossModel = self._model:getBoss()
                        if(bossModel) then
                            ToolsUtil:triggerHandleMap15Moon(bossModel:getState() == FSMState.BATTLE, true)
                        else 
                            ToolsUtil:triggerHandleMap15Moon(false, false)
                        end
                    end
                end

                if(data:getIsTrigger()) then
                    -- 这里根据
                    local isBossScene = self._model:getMapData():isBossScene()
                    local bossLevel = self._model:getMapData().number
                    -- 触发进入场景的剧情事件
                    if SceneManager:getInstance():isInHero() then
                        if(isBossScene) then 
                            local plotID = nil
                            if(bossLevel == 4) then
                                local PlotEventManager = require("app.game.PlotEventManager")
                                PlotEventManager:getInstance():runEventByID(4000711)
                            end
                        end
                    end
                end 
            end 

            -- 根据参数恢复相关状态
            local status = data.status
            if status then
                if status == SPRITE_STATUS.IDLE then

                elseif status == SPRITE_STATUS.MOVE then

                elseif status == SPRITE_STATUS.FIGHT then
                    -- 恢复战斗
                    local monster = self._model:getRoleBySpriteID(data.spriteID)
                    local attackTarget = nil
                    if data.targetSpriteID ~= nil then
                        attackTarget = self._model:getRoleBySpriteID(data.targetSpriteID)
                    end
                    if self._fsmEnterBattle then
                        self:_fsmEnterBattle(monster, attackTarget,data.targetSpriteID,data.skillID,data.skillState)
                    end
                elseif status == SPRITE_STATUS.DEAD then
                end
            end

            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, monster:getData())
        end
    end
end

-- 处理道具幻境初始化
function Machine:_battleItemDelusionInit(spriteID, delusion)
    -- 遍历所有已经加载的数据，根据情况给添加相关表现
    local category = nil
    local type = nil
    if(delusion == DelusionType.DelusionType_Rich) then 
        -- 发财
        category = Category.ROLE
        type = RoleType.Monster
    elseif (delusion == DelusionType.DelusionType_Insane) then
        -- 疯狂
        category = Category.TRIGGER_NPC
        type = PublicDefine.TRIGGER_NPC_TYPE.BOX
    end

    local roleMap = self._model:getRoleMap()
    for k, role in pairs(roleMap) do
        if(role:getCategory() == category and role:getType() == type) then
            self:_addDeformation(role, delusion)
        end
    end
end

-- 处理道具幻境移除
function Machine:_battleItemDelusionRemove(spriteID, delusion)
    local category = nil
    local type = nil
    if(delusion == DelusionType.DelusionType_Rich) then 
        -- 发财
        category = Category.ROLE
        type = RoleType.Monster
    elseif (delusion == DelusionType.DelusionType_Insane) then
        -- 疯狂
        category = Category.TRIGGER_NPC
        type = PublicDefine.TRIGGER_NPC_TYPE.BOX
    end

    local roleMap = self._model:getRoleMap()
    for k, role in pairs(roleMap) do
        if(role:getCategory() == category and role:getType() == type) then
            self:_removeDeformation(role, false)
        end
    end
end

-- 触发一个幻觉
function Machine:_triggerDeformation(role)
    local category = nil
    local type = nil

    local master = self._model:getMaster()
    local delusion = DelusionType.DelusionType_None
    if(master) then
        delusion = master:getDelusion()
    end

    if(delusion == DelusionType.DelusionType_Rich) then 
        -- 发财
        category = Category.ROLE
        type = RoleType.Monster
    elseif (delusion == DelusionType.DelusionType_Insane) then
        -- 疯狂
        category = Category.TRIGGER_NPC
        type = PublicDefine.TRIGGER_NPC_TYPE.BOX
    end

    if(role:getCategory() == category and role:getType() == type) then
        self:_addDeformation(role, delusion)
    end
end

function Machine:_addDeformation(role, delusion)
    if(role and delusion) then
        -- 判断是否已经触发过了，如果触发过了就不做处理
        if(role:getIsNormalDeformation() == false) then
            local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, role:getId())
            if firstAction and firstAction:getFSMState() == FSMState.BATTLE then
                return 
            end

            -- 处理数据存储
            local gameInCaveData = MasterDataManager:getSaveGameInCaveData()

            local level = self._model._mapData.level 
            local caveMode = self._model._mapData.caveMode
            local difficulty = self._model._mapData.difficulty
            local coord = role:getCoord()

            if(self._defomationData == nil) then
                local level = self._model._mapData.level 
                local caveMode = self._model._mapData.caveMode
                local difficulty = self._model._mapData.difficulty
                local mapConfig = ConfigManager:getMapLevelConfig(level, caveMode, difficulty)

                local data = {}

                data.monsterIDArr = {}
                data.boxIDArr = {}

                if(mapConfig) then
                    -- 过滤宝箱
                    for k,boxID in ipairs(mapConfig.boxID) do
                        local treasureData = RoleDataManager:createLocalTriggerNpcData(boxID)
                        if(treasureData and treasureData:getIsChest()) then
                            table.insert(data.boxIDArr, boxID)
                        end
                    end

                    -- 处理怪物
                    for k,monsterID in ipairs(mapConfig.monsterID) do
                        local monsterData = RoleDataManager:createLocalMonsterData(monsterID)
                        if(monsterData and monsterData:judgeNeedToTrigger() == false) then
                            table.insert(data.monsterIDArr, monsterID)
                        end
                    end
                end
                
                self._defomationData = data
            end

            if(delusion == DelusionType.DelusionType_Rich) then
                -- 判断是否为触发怪
                if(role:judgeNeedToTrigger() ==  false) then
                    local oldDeformationID = nil
                    local boxID = nil

                    if(gameInCaveData) then
                        oldDeformationID = gameInCaveData:getDeformation(level, caveMode, difficulty, coord.x, coord.y)
                    end

                    local boxIDArr = self._defomationData.boxIDArr
                    if(oldDeformationID) then
                        for k, v in pairs(boxIDArr) do
                            if(v == oldDeformationID) then 
                                boxID = oldDeformationID
                                break
                            end
                        end
                    end
                    if(boxID == nil) then
                        boxID = boxIDArr[math.random(1, #boxIDArr)]
                    end
                    if(boxID) then
                        role:setDeformationID(boxID)
                    end
                end
            elseif (delusion == DelusionType.DelusionType_Insane) then
                -- 全部变成怪
                if (role and role:getIsChest() and role:getIsOpen() == false) then
                    local oldDeformationID = nil
                    local monsterID = nil

                    if(gameInCaveData) then
                        oldDeformationID = gameInCaveData:getDeformation(level, caveMode, difficulty, coord.x, coord.y)
                    end

                    local monsterIDArr = self._defomationData.monsterIDArr
                    if(oldDeformationID) then
                        for k, v in pairs(monsterIDArr) do
                            if(v == oldDeformationID) then 
                                monsterID = oldDeformationID
                                break
                            end
                        end
                    end
                    if(monsterID == nil) then
                        monsterID = monsterIDArr[math.random(1, #monsterIDArr)]
                    end

                    if(monsterID) then
                        role:setDeformationID(monsterID)
                    end
                end
            end

            if(role:isDeformation()) then
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initItemDeformationShow(role:getId(), role:getDeformationData())
                self:pushCommand(renderCommand)

                -- 处理数据存储
                if(gameInCaveData) then
                    gameInCaveData:addDeformation(level, caveMode, difficulty, coord.x, coord.y, role:getDeformationData():getId())
                end

                Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CHANGE_TYPE, role)
            end
        end
    end
end

function Machine:_removeDeformation(role, enterBattle)
    if (role) then
        if(enterBattle == nil) then 
            enterBattle = false
        end

        local oldHave = false 
        local oldHaveNormal = false
        if(role:getIsNormalDeformation()) then
            oldHaveNormal = true 
        end 
        if(role:isDeformation()) then
            oldHave = true
        end 

        role:setDeformationID(nil)

        if(role:isDeformation()) then
            -- 这里区别对待进入战斗，在战斗action 里面还会做相关的显示处理
            if oldHave then 
                if enterBattle == false then
                    local renderCommand = Command.RendererCommand:create(true)
                    renderCommand:initItemDeformationShow(role:getId(), role:getDeformationData())
                    self:pushCommand(renderCommand)
                else 
                    -- 这里对于怪物需要变换为非变身状态
                    if(role:getRoleData()) then 
                        role:getRoleData():disableDeformation()
                    end

                    local renderCommand = Command.RendererCommand:create(true)
                    renderCommand:initItemDeformationRemove(role:getId())
                    self:pushCommand(renderCommand)
                end
            end
        else 
            if oldHaveNormal then 
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initItemDeformationRemove(role:getId())
                self:pushCommand(renderCommand)
            end 
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CHANGE_TYPE, role)

        -- 清理存储数据
        local gameInCaveData = MasterDataManager:getSaveGameInCaveData()
        if(gameInCaveData) then
            local level = self._model._mapData.level 
            local caveMode = self._model._mapData.caveMode
            local difficulty = self._model._mapData.difficulty
            local coord = role:getCoord()

            gameInCaveData:removeDeformation(level, caveMode, difficulty, coord.x, coord.y)
        end
    end
end

function Machine:_addTriggerNpc(screenType,data)
    if(data and data:getType() == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_TREASURE_MAP) then 
        local fragmentID = data:getFragmentID()
        local isGet = MasterDataManager:fragmentIsGet(fragmentID)
        -- print("Machine:_addTriggerNpc  fragment ", fragmentID, isGet)
        if(isGet == false) then
            -- print(string.format("Machine:_addTriggerNpc  fragment hide fragmentID=%d", fragmentID))
            return
        end
    end

    if(data and data:getType() == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_MOLD) then 
        local fragmentID = data:getFragmentID()
        local isGet = mvc.runeMoldModel:checkFragmentIsGet(fragmentID)
        if isGet then
            return
        end
    end
    
    local box,isUpdate = self._model:addOrUpdateRole(Category.TRIGGER_NPC, data:getType(),data)
    -- print("Machine:onExecuteControlCommand  add  x,y=", box:getCoord().x,box:getCoord().y, screenType, SCREEN_TYPE.SCREEN)
    if box then
        -- 处理点金状态恢复
        if(data:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC and data:hasFunction(PublicDefine.FUNCTION_TYPE.GOLD_TOUCH)) then
            local goldTouched = RoleDataManager:getHeroGoldTouched()
            if(goldTouched > 0) then
                box:trigger()
            end
        end

        if screenType == SCREEN_TYPE.GLOBAL then
            if (box and (not isUpdate)) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, box)
            end

            -- self._view:addView(box)

            self:_triggerDeformation(box)
        elseif screenType == SCREEN_TYPE.SCREEN then
            -- 这里处理触发NPC的方向
            if(SceneManager:getInstance():isGhostAbyss()) then
                local npcData = box:getNpcData()
                if(npcData) then 
                    local coord = npcData:getCoord()
                    if(coord and coord.x <=4 and coord.y > 6) then 
                        box:setDirection(DirectionType.EAST)
                    end
                end
            end

            -- 这里注意相关的逻辑处理
            self._view:addView(box)

            self:_triggerDeformation(box)

            -- 增加一次添加
            box:increaseAddNum()

            -- 同步boss 大门状态
            if(data:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE) then
                if (data:getIsLock() == false) then
                    if(box:getState() == TriggerNPCState.OPEN) then
                        local openItCommand = Command.RendererCommand:create()
                        openItCommand:initOpenItCommand(box:getId(), true)
                        self:pushCommand(openItCommand)
                    else 
                        self:_triggerNPCOpen(box, true, nil)
                    end
                end
            end

            -- 同步邮箱 状态
            if data:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC and data:hasFunction(PublicDefine.FUNCTION_TYPE.MAILBOX) then
                if Game.MailManager:getInstance():isNewFlagOfAll() then
                   GameManager:refreshMailNewFlag(false)
                end
            end

            -- 添加传送门的触发
            if data:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR then
                self:_addTransDoorTrigger(box:getNpcData())
            end

            -- if(data:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT) then
            -- end

            -- 同步状态
            if data:getIsOpen() == true then
                if(box:getState() == TriggerNPCState.OPEN) then
                    local openItCommand = Command.RendererCommand:create()
                    openItCommand:initOpenItCommand(box:getId(), true)
                    self:pushCommand(openItCommand)
                else 
                    -- 修改状态
                    self:_triggerNPCOpen(box,true, nil)
                end
            end

            -- 判断宝箱周围的环境
            local rightRoad = false

            -- 根据NPC类型做相关逻辑
            local coord = box:getCoord()

            if data:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOX or data:getType() == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE then
                local leftTileData = self._model:getMapTileData(coord.x + 1, coord.y)
                if leftTileData == nil or (leftTileData and leftTileData:getTerrainType() ~= MapDefine.TerrainType.Wall) then rightRoad = true end

                if rightRoad == false then
                    local rightTileData = self._model:getMapTileData(coord.x, coord.y - 1)
                    if rightTileData == nil or (rightTileData and rightTileData:getTerrainType() ~= MapDefine.TerrainType.Wall) then rightRoad = true end
                end
            end

            if rightRoad == true then
                local directionCommand = Command.RendererCommand:create(true)
                directionCommand:initUpdateDirectionCommand(box:getId(),DirectionType.EAST)
                self:pushCommand(directionCommand)
                if DEBUG then
                    print("_addTriggerNpc  updateDirectionCommand ",box:getSpriteID(),coord.x,coord.y)
                end
            end

            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ADD_GAME_MODEL, box)
        end
    end
end

function Machine:_recoverBuff(buff, roleData)
    for k,v in pairs(buff) do
        -- 这里要先创建好buffData 然后传递过去
        local buffData = SkillDataManager:handleBufferDataReback(v, roleData:getSpriteID())
        if(buffData) then
            -- buffData:setTargetSpriteID(roleData:getSpriteID())
            -- print("NetRoleSystem:_recoverBuff  ", buffData.buffID, buffData.entityID, buffData.targetSpriteID, roleData:getSpriteID())

            -- 这里处理同步处理action 的处理。
            if(buffData) then
                self:_handleAddBuff(buffData, roleData:getSpriteID(), true)
            end

            -- local command = Command.ControlCommand:create(true)
            -- command:initForAddBuff(buffData, true)
            -- SceneManager:getInstance():pushCommand(command)
        end
    end
end

function Machine:_addTransDoorTrigger(triggerNpcData) 
    if(triggerNpcData) then 
        if(self._waitingLanguage and triggerNpcData:getIsLock()) then 
            local coord = triggerNpcData:getCoord()
            local dungeonRoomData = self._view._mapData:getDungeonRoomDataAtCoordinate(coord.x, coord.y)
            if(self._waitingDungenonRoomData == dungeonRoomData) then  
                self._waitingDungenonRoomData = nil 
                self._waitingLanguage = nil
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(self._waitingLanguage))
            end
        end
    end
end

-- 处理触发深渊房间提示语言
function Machine:_handleTriggerDungeonRoomTips(masterData, isEnterScene)
    self._waitingLanguage = nil
    self._waitingDungenonRoomData = nil

    -- 深渊提示房间玩法
    if SceneManager:getInstance():isInDungeon() then
        local coord = masterData:getCoord()
        if(coord) then
            local dungeonRoomData = self._view._mapData:getDungeonRoomDataAtCoordinate(coord.x, coord.y)
            if(dungeonRoomData and dungeonRoomData.roomConfig) then
                local type = dungeonRoomData.roomConfig.type 
                if(type == 1 or type == 2 or type == 3 or type == 8) then 
                    local languageID = dungeonRoomData.roomConfig.text
                    if(languageID and languageID ~= 0) then 
                        -- 需要判断是否解锁了，如果解锁了就不提示了
                        if(isEnterScene) then 
                            -- 检查是否为初始化
                            if(self._model) then 
                                local transDoorArr = self._model:getTransDoorArr()
                                for _,triggerMode in ipairs(transDoorArr) do 
                                    if(triggerMode:getIsLock()) then 
                                        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(languageID))
                                        break
                                    end
                                end
                            end
                        else 
                            local handle = true
                            if(self._model) then 
                                local transDoorArr = self._model:getTransDoorArr()
                                for _,triggerMode in ipairs(transDoorArr) do 
                                    if(triggerMode:getIsLock()) then 
                                        local triggerNpcData = triggerMode:getNpcData()
                                        if(triggerNpcData) then 
                                            local coord = triggerNpcData:getCoord()
                                            local nowData = self._view._mapData:getDungeonRoomDataAtCoordinate(coord.x, coord.y)
                                            if(nowData == dungeonRoomData) then  
                                                handle = false
                                                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(languageID))
                                                break
                                            end
                                        end 
                                    end
                                end
                            end

                            if(handle) then 
                                -- 等待添加下一个传送门的时候判断是否解锁来决定是否弹提示
                                self._waitingLanguage = languageID
                                self._waitingDungenonRoomData = dungeonRoomData
                            end
                        end
                    end 
                else 
                    -- 发送提示语言 
                    local languageID = dungeonRoomData.roomConfig.text
                    if(languageID and languageID ~= 0) then 
                        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(languageID))
                    end 
                end
            end
        end
    end
end

function Machine:_controlAddUnlockFuncEvent(data)
    Game.FunctionUnlockManager:getInstance():addEvent(data)
    
    -- 触发解锁的相关动画
    if(GameManager:getIsInNewScene()) then
        local funcitonTypeArr = Game.FunctionUnlockManager:getInstance():lockTypeToNPCFuncType(data)
        RedPointManager:refreshAllRedPoint()
        if(self._model and #funcitonTypeArr > 0) then 
            local functionArr = self._model:getAllFunctionNpcArr()
            if(functionArr) then
                for k, model in ipairs(functionArr) do 
                    local change = false
                    local functionTypeArr = model:getData():getAllFunctionType()
                    for i = 1, #functionTypeArr do
                        for k,v in ipairs(funcitonTypeArr) do 
                            if (functionTypeArr[i] == v) then
                                change = true
                                break
                            end
                        end
                        if(change == true) then 
                            break
                        end
                    end
                    if(change) then
                        local renderCommand = Command.RendererCommand:create(true)
                        renderCommand:initTriggerNpcUnlock(model:getId())
                        self:pushCommand(renderCommand)
                    end
                end
            end
        end

    end

    -- print("_controlAddUnlockFuncEvent", data, PublicDefine.FUNCTION_TYPE.SKILL_ADVANCED)
    -- add by zp  1.4.0 由于在完成任务后，需要直接弹出技能进阶界面
    if(Game.FunctionUnlockManager:getInstance():npcTypeToLockType(PublicDefine.FUNCTION_TYPE.SKILL_ADVANCED) == data
        and Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.SKILL_ADVANCED)) then 
        if(self._model) then 
            local npcModelArr = self._model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.SKILL_ADVANCED)
            if(npcModelArr) then 
                for k,model in pairs(npcModelArr) do 
                    Avalon.MessageCenter:notice(GameMessage.MC_UI_UPGRADE_SKILL, model:getSpriteID())
                    break
                end
            end
        end
    end 
    
    -- 完成转生任务解锁转生功能弹出指引窗口
    if(Game.FunctionUnlockManager:getInstance():npcTypeToLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_REINCARNATION) == data
        and Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_REINCARNATION)) then 
        if(self._model) then 
            local npcModelArr = self._model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.FUNCTION_REINCARNATION)
            if(npcModelArr) then 
                for k,model in pairs(npcModelArr) do 
                    local tips = UI.Tips:createTips(
                        UI.TEXT_224314,
                        UI.TipsType.CONFIRM_AND_CANCEL,
                        UI.TipsUiType.NORMAL
                    )

                    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_FUNCTION_PANEL)
                    end)
                    break
                end
            end
        end
    end
end

function Machine:_controlFinishAchEvent(data)
    Game.FunctionUnlockManager:getInstance():addAchevement(data.id, nil, data.text)
end

-- 根据spriteID获取物体做出相应动效
function Machine:_controlRoleRunAnimation(command)
    local modelID = nil
    local renderer = nil

    local role = self._model:getRoleBySpriteID(command.spriteID)
    if (role) then
        modelID = role:getId()
    end

    if (modelID) then
        renderer = self._view:getRenderer(modelID)
    end

    if(renderer and renderer.runRoleAnimations) then
        renderer:runRoleAnimations(command.animationNames)
    end
end

-- 摇色子的表现控制
function Machine:_controlLostRealmRun(data)
    local currentStep = data.data.currentStep
    local startStep = data.data.currentStep - data.moveStep
    local oneCricleNum = #ConfigManager:getAllLostRealm()
    local endStep = mvc.festivalModel:calculationLostRealmID(currentStep)
    print("_controlLostRealmRun=", data, currentStep, endStep, startStep)
    local lostRealmData = ConfigManager:getLostRealmByID(endStep)
    if(lostRealmData == nil) then 
        return nil
    end

    local moveCoordList = {}
    for i=startStep, currentStep, 1 do 
        local oneStep = mvc.festivalModel:calculationLostRealmID(i)
        local lostRealmData = ConfigManager:getLostRealmByID(oneStep)
        if(lostRealmData) then
            table.insert(moveCoordList, {x=lostRealmData.Location[1], y=lostRealmData.Location[2], z=0})
        end
    end
    print("moveCoordList=", moveCoordList)

    local coordX = lostRealmData.Location[1]
    local coordY = lostRealmData.Location[2]
    local triggerUI = false
    local delayTime = 1
    local step = data.moveStep
    local dis = PublicDefine.CONST_DEFINITION.MAP_COORD_COVERT_DISTANCE * step
    delayTime = dis / self._model:getMaster():getMoveSpeed() * 1.1

    self:_fsmClickMove(self._model:getMaster(), moveCoordList, 0, true, function()
        -- 移动结束，开始展示活动的奖励等物品，这里为了处理容错，会有一个倒计时来处理出现错误的情况。
        if(not triggerUI) then
            triggerUI = true
            self:_triggerLostRealm(coordX, coordY)
        end
    end)

    -- self:_triggerMove(self._model:getMaster(), coordX, coordY, true, function()
    --     -- 移动结束，开始展示活动的奖励等物品，这里为了处理容错，会有一个倒计时来处理出现错误的情况。
    --     if(not triggerUI) then
    --         triggerUI = true
    --         self:_triggerLostRealm(coordX, coordY)
    --     end
    -- end)

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        if(not triggerUI) then
            triggerUI = true
            self:_triggerLostRealm(coordX, coordY)
        end
    end, delayTime)

    -- 这里恢复前面打开的表现
    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        self:_resetLostRealm()
    end, delayTime/2)
end

-- 摇色子的表现控制
function Machine:_controlGhostAbyss(data)
    -- 处理流程数据
    mvc.caveModel:handleGhostAbyssSceneInfoData(data)
end

function Machine:_initLostRealmAnimation()
    local lostRealmArr = ConfigManager:getAllLostRealm()
    if(lostRealmArr and self._view) then 
        self._view:initLostRealmAnimation(lostRealmArr)
    end
end

function Machine:_triggerLostRealm(coordX, coordY)
    local worldX, worldY = self:convertCoordToTouchPosition({x=coordX, y=coordY})
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_LOSTREALM_ROLE_MOVE_END,{x= worldX, y= worldY})

    local data = {}
    data.isEnd = true
    data.step = 0
    -- print("Machine:_triggerLostRealm", coordX, coordY)
    local masterModel = self._model:getMaster()
    if(masterModel) then
        -- print("Machine:_triggerLostRealm 2", coordX, coordY)
        local rendererCommand = Command.RendererCommand:create()
        rendererCommand:initForTypeAndData(CommandType.RENDERER_LOSTREALM_CHANGE, masterModel:getId(), data)
        SceneManager:getInstance():pushCommand(rendererCommand)

        local oneData = mvc.festivalModel:getLostRealmDataByCoord(coordX, coordY)
        local oneCricleNum = #ConfigManager:getAllLostRealm()
        local endID = oneData.ID + 1
        if(endID > oneCricleNum) then 
            endID = endID - oneCricleNum
        end
        local twoRealmData = ConfigManager:getAllLostRealmByID(endID)
        local direction = Geome.computeDirection({x=coordX, y= coordY, z = 0}, {x=twoRealmData.Location[1], y= twoRealmData.Location[2], z = 0})
        masterModel:setDirection(direction)

        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initUpdateDirectionCommand(masterModel:getId(), direction)
        self:pushCommand(directionCommand)
    end

    if(self._view) then
        self._view:triggerLostRealm(coordX, coordY)
    end
end

function Machine:_resetLostRealm()
    if self._view then
        self._view:resetLostRealm()
    end
end
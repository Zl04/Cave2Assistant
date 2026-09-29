
local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local GameMapManager = require("app.game.GameMapManager")
local SceneManager = require("app.game.SceneManager")
local PlotManager = require("app.game.PlotManager")
local LanguageManager = require("app.game.LanguageManager")

local TRIGGER_TYPE = GameTriggerType
local TRACKS_INDEX = GameTracksIndex
local SCENE_TYPE = PublicDefine.SCENE_TYPE
local MonsterSubType = PublicDefine.MonsterSubType
local ITEM_TYPE = PublicDefine.ITEM_TYPE
local BOSS_SCENARIO_TYPE = PublicDefine.BOSS_SCENARIO_TYPE
local AUTO_RESET_TRANSFER_FLAG = false

local DEBUG = false

local Machine = Battle.Machine
local function checkSkillsIsConfig()
    local active = SkillDataManager:getMasterLearnActiveSkillList()
    if #active > 0 then
        local isSeted = false
        local configSkill = SkillDataManager:getUserFightSkill()
        if configSkill then
            for i = 1, 5 do
                if configSkill[i] ~= 0 then
                    local groupId = configSkill[i]
                    local skillGroupData = SkillDataManager:getSkillGroup(groupId)
                    if skillGroupData:getLevel() > 0 then
                        return true
                    end
                end
            end
        end
        return isSeted
    end
    return true
end
local isNeedShowConfigFightSkill = true
-- 处理开始战斗
function Machine:_handleStartBattle(roleData)
    if(self._model == nil) then return end
    if (roleData and roleData:getIsDead() == false) then
        -- 处理判断怪物没有被激活的情况
        if(not (roleData.getIsWake and roleData:getIsWake())) then
            return
        end 

        local master = self._model:getMaster()
        local target = self._model:getRoleBySpriteID(roleData:getSpriteID())
        if(master == nil or target == nil) then 
            if(master == nil) then 
                print("master data is nil.")
            end
            if(target == nil) then 
                print("target data is nil.")
            end

            printError("Machine:_handleStartBattle now data is error", roleData:getSpriteID())
            return 
        end

        -- 判断是否处于战斗中
        local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if (battleStateAction and battleStateAction:getFSMState() ~= FSMState.BATTLE) then
            -- 判断如果还处于移动中，就需要停止移动
            if(battleStateAction:getFSMState() == FSMState.MOVE) then
                local coord = roleData:getCoord()
                Net.NetRoleSystem:heroStopMoveRequest(Avalon.MathUtil:getInt(coord.x), Avalon.MathUtil:getInt(coord.y))
            end

            if SceneManager:getInstance():isInBigCrack() then
                local bossInfo = mvc.bigCrackModel:getbossInfos(mvc.bigCrackModel:getCampId())
                if bossInfo and bossInfo.spriteID ~= roleData:getSpriteID() then
                    UI.ScrollBar:createByText(UI.TEXT_1213441)
                    return
                end
            end

            if(battleStateAction:getFSMState() == FSMState.WAITING) then
                
            else
                local switch = tonumber(ConfigManager:getGeneralForKey("skillsShortcutKey"))
                local heroData = RoleDataManager:getMaster()
                local isCofingSkill =  heroData:getLevel() >= switch
                if isCofingSkill then
                    local isSeted = checkSkillsIsConfig()
                    if not isSeted then
                        -- local isNoticeConfigFightSkill = cc.UserDefault:getInstance():getBoolForKey(
                        --     UserDefaultKeyWord.isNoticeConfigFightSkill..GameDataManager:getInstance():getMasterPK(), true)  
                        if isNeedShowConfigFightSkill then
                            UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212249, 
                                function(isSelect)
                                    if isSelect then
                                    --     cc.UserDefault:getInstance():setBoolForKey(
                                    --         UserDefaultKeyWord.isNoticeConfigFightSkill..GameDataManager:getInstance():getMasterPK(), false)  
                                        isNeedShowConfigFightSkill = false 
                                    end
                                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG, UI.BagPanel.TAB_INDEX.SKILL)
                                end, 
                                function()
                                    -- 通知服务器
                                    Net.NetRoleSystem:heroStartBattleRequest(roleData:getSpriteID())
                                    -- 执行客户端开始战斗的命令
                                    self:_fsmEnterBattle(master,target)
                                    local pets = master.getFightPet ~= nil and master:getFightPet() or nil
                                    for k, pet in pairs(pets) do
                                        if pet and not pet:getRoleData():getIsDead() then
                                            self:_fsmEnterBattle(pet,target)
                                        end
                                    end
                                    
                                 end, nil,nil, true)
                            return
                        end
                    end
                end
                -- 通知服务器
                Net.NetRoleSystem:heroStartBattleRequest(roleData:getSpriteID())
                -- 执行客户端开始战斗的命令
                self:_fsmEnterBattle(master,target,nil,nil,nil,true)
                local pets = master.getFightPet ~= nil and master:getFightPet() or nil
                for _, pet in pairs(pets) do
                    if pet and pet.getRoleData and not pet:getRoleData():getIsDead() then
                        self:_fsmEnterBattle(pet,target,nil,nil,nil,true)
                    end
                end
                
            end
        else
            printError("Machine:_handleStartBattle  startBattle is in battle")
            if(DEBUG) then
                print("Machine:_handleStartBattle  startBattle is in battle")
                print(debug.traceback())
            end 
        end

        -- TODO 以下为测试多人战斗排位
        if false then
            local masterCoord = master:getCoord()
            local oldPk = master:getData().pk
            local oldSpriteID = master:getData().spriteID

            local num = 3

            for i=1,num do
                master:getData().pk = oldPk + i
                master:getData().spriteID = 1000+i
                local newHeroData = RoleDataManager:handleHeroData(master:getData())
                newHeroData.spriteID = 1000+i
                newHeroData.pk = oldPk + i

                newHeroData.isMaster = false

                local newMaster = self._model:getRoleBySpriteID(newHeroData.spriteID)
                if newMaster then
                    newMaster:setCoord(masterCoord.x,masterCoord.y)

                    -- 移除角色
                    self._model:removeBattleFieldRole(newMaster)
                end
            end

            for i=1,num do
                master:getData().pk = oldPk + i
                master:getData().spriteID = 1000+i
                local newHeroData = RoleDataManager:handleHeroData(master:getData())
                newHeroData.spriteID = 1000+i
                newHeroData.pk = oldPk + i

                newHeroData.isMaster = false

                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_SCREENHERO, newHeroData)
                self:executeCommand(command)

                local newMaster = self._model:getRoleBySpriteID(newHeroData.spriteID)
                newMaster:setCoord(masterCoord.x,masterCoord.y)

                -- 移除角色
                self._model:removeBattleFieldRole(newMaster)

                local positionCommand = Command.RendererCommand:create(true)
                positionCommand:initUpdatePositionCommand(newMaster:getId(), newMaster:getCoord(), false)
                self._view:executeCommand(positionCommand)

                self:_fsmEnterBattle(newMaster,target)

                -- newMaster:setBattleCoord({x=newMaster:getCoord().x,y=newMaster:getCoord().y,z=newMaster:getCoord().z})
            end

            master:getData().pk = oldPk
            master:getData().spriteID = oldSpriteID
        end
    end
end

function Machine:_battleUseSkill(data)
    if(self._model == nil) then return end
    local master = self._model:getMaster()
    if data.isPet then
        master = master:getCaptainPet()
    end
    if master and master:getState() == FSMState.BATTLE and 
        master:getRoleData() and 
        master:getRoleData():judgeToUseSkill() then
        local skillData = data.skillData

        if(skillData == nil) then
            return
        end

        -- add by zp 这里如果已经没有在战斗中或者战斗已经结束，就不需要做释放技能了
        local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if(battleStateAction and (battleStateAction:getFSMState() ~= FSMState.BATTLE or battleStateAction:isEndBattle())) then 
            return
        end


        local targetSpriteID = nil
        if data.targetSpriteID then
            targetSpriteID = data.targetSpriteID
        else
            -- 处理对于目标类型的判断
            if(skillData:getTargetType() == 1) then
                targetSpriteID = master:getSpriteID()
            else
                -- 获取攻击对象
                local battleField = self._model:getBattleFieldBySpriteID(self._model:getMaster():getSpriteID(),nil)
                if battleField then
                    local monster = battleField:getTargetMonster()
                    if monster then
                        targetSpriteID = monster:getSpriteID()
                    end
                end
            end
        end
        -- print("Machine:_battleUseSkill =", targetSpriteID, skillData:getSkillID())
        if skillData and targetSpriteID then
            local skillID = skillData.skillID
            local attackTarget = nil
            if targetSpriteID ~= nil then
                attackTarget = self._model:getRoleBySpriteID(targetSpriteID)
            end

            self:_fsmEnterBattle(master,attackTarget,targetSpriteID,skillID,skillState)

            -- 发送使用技能消息
            if data.isPet then
                Net.NetPetSystem:petUseSkillRequest(skillID, targetSpriteID)
            else
                if RoleBehaviorManager:useBattleSkillCheck() then 
                    Net.NetRoleSystem:heroUseSkillRequest(skillID, targetSpriteID, nil, nil, skillData:getGroupId())
                end
            end
        else
            print(" Machine:_onExecuteBattleCommand BATTLE_USE_SKILL  error",skillData,targetSpriteID,data.coordX,data.coordY)
        end
    else
        print(" Machine:_onExecuteBattleCommand BATTLE_USE_SKILL  master not in battle.")
    end
end

function Machine:_battleEscape()
    if(self._model == nil) then return end
    local master = self._model:getMaster()
    if master then
        self:_fsmBattleEscape(master)
    end
end

function Machine:_battleHandleStation(data)
    local target = data.role
    local attackTarget = data.attackTarget
    if DEBUG then
        if data.coord then
            print("Machine:_onExecuteBattleCommand spriteID,coord.x,coord.y=",target:getSpriteID(),data.coord.x,data.coord.y)
        else
            print("Machine:_onExecuteBattleCommand spriteID",target:getSpriteID())
        end
    end

    local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if (battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE) then
        if target:getType() == RoleType.Hero or target:getType() == RoleType.Pet then
            if DEBUG then
                print("Machine:_onExecuteBattleCommand hero spriteID,coord.x,coord.y=",target:getSpriteID(),data.coord.x,data.coord.y)
            end
            -- 设置位置
            battleStateAction:moveToCoord(data.coord)
        end

        if attackTarget then
            battleStateAction:setAttackTarget(attackTarget)
        end
    end
end

function Machine:_battleRemoveModel(modelID,cleanView)
    if(self._model == nil) then return end
    local model = self._model:getModelByModelID(modelID) 
    if (model) then
        -- 停止所有的效果
        self._actionTrack:clearActionForEntryId(model:getId())
        -- 移除所有buffer
        self:_clearAllBufferForRole(model)

        local category = model:getCategory()
        local type = model:getType()

        if (category == Category.ROLE) then
            self._model:removeBattleFieldRole(model)
        end

        -- 清理视图
        self._view:removeView(model, cleanView)

        local removeX,removeY = nil, nil
        if (category == Category.TRIGGER_NPC ) then
            if type == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or type == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE then
                removeCoord = model:getCoord()
                removeX = removeCoord.x
                removeY = removeCoord.y
            end
        end
        local roleData = model:getData()
        -- 清理模型
        if (category == Category.AIRCRAFT and type == AircraftType.BULLET) then
            self._model:removeModel(model)
        elseif (category == Category.AIRCRAFT and type == AircraftType.GETGOODS) then
            self._model:removeModel(model)
        else
            -- 这里用于移除所有死亡需要移除的东西
            self._model:removeRole(model)
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_GAME_MODEL, roleData) 

        if(removeX and removeY) then
            self:refreshTrapCover(removeX, removeY)
        end
    else
        printError("[ERROR] BattleMachine _onExecuteBattleCommand: no model to remove.")
    end
end

function Machine:_battleAddTriggerData(spriteID,coord)
    if(self._model == nil) then return end
    local model = self._model:getRoleBySpriteID(spriteID)
    if model then
        self:_addDropTrigger(model)
    end

    if coord then
        self:_addCoordTrigger(coord)
    end
end

function Machine:_battleReviveEnd(spriteID)
    if(self._model == nil) then return end
    local model = self._model:getRoleBySpriteID(spriteID)
    if model then
        -- 移动到目标位置
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            -- print("Machine:_battleReviveEnd  run")
            local reviveAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, model:getId())
            -- print("Machine:_battleReviveEnd  run", reviveAction)
            if (reviveAction and (reviveAction:getFSMState() == FSMState.REVIVE)) then
                reviveAction:moveEnd(function () 
                    -- print("Machine:_battleReviveEnd  callback")
                    if(model:isMaster()) then
                        self:handleMapTrigger(TRIGGER_TYPE.TRIGGER_ALL, model:getCoord(), model:isMaster(), false, true, GameTriggerTimeType.TRIGGER_TIME_NORMAL)
                        
                        -- 显示背包按钮表现
                        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_BAG_BUTTON)
                        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER)
                    end

                    -- 发送复活完成消息
                    -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE_END, model:getData())
                    self:_fsmIdle(model, model:getCoord(), true)

                    -- self:moveOneStepTrigger()
                    -- if (SceneManager:getInstance():getSceneType() == SCENE_TYPE.BLACK_HOUSE) then
                    --     UI.TipsLayer:onVoteSucceedTipsUI()
                    -- end
                end)
            else
                -- 发送复活完成消息
                -- model:setIsDead(false)
                -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE_END, model:getData())
                -- if(model:isMaster()) then

                --     Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER)
                -- end
                self:_fsmIdle(model, model:getCoord(), true)
            end

            if model:isMaster() then
                Avalon.AudioManager:resumeMusic()
            end
        end, 0.01)
    end
end

function Machine:_battleRoleBackTown(goodsData)
    if(self._model == nil) then return end
    local master = self._model:getMaster()
    if DEBUG then
        print("CommandType.BATTLE_ROLE_BACK_TOWN  ",master)
    end
    if master then
        local fistAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if (not fistAction or (fistAction:getFSMState() ~= FSMState.BATTLE)) then
            -- 发送开始使用道具的处理
            Net.NetGoodsSystem:beginUseItemRequest(goodsData:getGoodsID(),goodsData:getIsGolden(),master:getSpriteID())

            Avalon.AudioManager:playSound("548")

            self:_fsmWaiting(master,WaitingType.WAITING_BACK_TOWN,goodsData, master)
        end
    end
end

function Machine:_controlCheckPoint(data)
    -- 处理存档点检测
    local checkpoint = 0
    local mode = 0
    local difficulty = 0
    
    mode = data.caveMode
    difficulty = data.difficulty

    if(SceneManager:getInstance():isInDungeon()) then
        
    elseif(SceneManager:getInstance():isInCave()
        or SceneManager:getInstance():isDesertEyesCave()
        or SceneManager:getInstance():isTitanRoad()
        or SceneManager:getInstance():isDriedSpring()) then
        -- 处理计算对应的商店层ID
        checkpoint = GameDataManager:getInstance():levelTransformShopLevel(mode, data.level)

        if DEBUG then
            print("BattleMachineCommon:_controlCheckPoint  mode, difficulty, checkpoint, level=",mode,difficulty,checkpoint, data.level)
            print("BattleMachineCommon:_controlCheckPoint =", data.level, checkpoint, mode, difficulty)
        end
        
        -- 判断是不是存档点
        if (GameDataManager:getInstance():judgeIsShop(checkpoint)) then
            local heroData = RoleDataManager:getMaster()

            local checkpointData = nil
            local changeCheckPoint = RoleDataManager:getChangeCheckPoint()
            if(changeCheckPoint and changeCheckPoint:getMode() == mode and changeCheckPoint:getDifficulty() == difficulty) then 
                checkpointData = changeCheckPoint
            else
                checkpointData = heroData:getCheckpointData(mode,difficulty)
            end
            if(DEBUG) then
                print("BattleMachineCommon:_controlCheckPoint 1")
            end
            if (checkpointData) then 
                if(DEBUG) then
                    print("BattleMachineCommon:_controlCheckPoint 2", checkpointData:getCheckpoint())
                end
                if(checkpointData:getCheckpoint() < checkpoint 
                    and SceneManager:getInstance():isActivityCave() == false) then
                    checkpointData:setCheckpoint(checkpoint)
                    if DEBUG then
                        print("BattleMachineCommon:_controlCheckPoint  send MC_BATTLE_CHECKPIONT.")
                    end

                    Avalon.Scheduler:scheduleUpdateOnce(self, self._triggerCheckpoint, 0.5)
                end
            else
                printError(string.format("BattleMachineCommon _controlCheckPoint mode=%d,difficulty=%d no found.",mode,difficulty))
            end
        end
    end
end

function Machine:_triggerCheckpoint()
    if(DEBUG) then
        print("BattleMachineCommon:_triggerCheckpoint .")
    end
    -- 发送UI表现消息
    -- Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_CHECKPIONT)
    Game.FunctionUnlockManager:getInstance():addCheckPoint()
end

function Machine:_controlRemoveScreenRole(data)
    if(self._model == nil) then return end
    -- 根据情况清理掉相关的数据
    local heroData = RoleDataManager:getRoleDataBySpriteID(data.spriteID)
    if(heroData and heroData:getCategory() == Category.ROLE and heroData:getType() == RoleType.Hero) then
        if(DEBUG) then
            print("ROLE_REMOVE_SCREEN_ROLE pk=", heroData:getPK())
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_HERO, heroData)

        if not SceneManager:getInstance():isInBigCrack() then --组队移动出同屏后,不移出数据
            GameDataManager:getInstance():clearHeroDataForPK(heroData:getPK())
        end
    end 

    local role = self._model:getRoleBySpriteID(data.spriteID)
    
    if role then
        local roleData = role:getData()
        local category = role:getCategory()
        local type = role:getType()

        if(role:getAddNum() >= 1) then
            role:reduceAddNum()
        end

        if DEBUG then
            if category == Category.TRIGGER_NPC and type == PublicDefine.TRIGGER_NPC_TYPE.TRAP then
                print("Machine:onExecuteControlCommand  CONTROL_REMOVESCREENROLE  x,y=", role:getCoord().x, role:getCoord().y, role:getAddNum())
            end
        end 

        -- 由于陷阱等占地区域比较广，会被多次加载。还不能移除
        if role:getAddNum() > 1 then
            return
        end

        self._model:removeBattleFieldRole(role)

        if DEBUG then
            print("Machine:onExecuteControlCommand  CONTROL_REMOVESCREENROLE category,type=",category,type)
        end
        -- 这里需要更具不同的类型以及状态获取是否需要延迟移除表现
        -- 整理一下移除逻辑
        if category == Category.ROLE then
            -- 停止所有的效果
            self._actionTrack:clearActionForEntryId(role:getId())
            -- 移除所有buffer
            self:_clearAllBufferForRole(role)

            if type == RoleType.Hero then
                self._view:removeView(role)
                self._model:removeRole(role)
                local pets = role:getFightPet()
                for _, pet in pairs(pets) do
                    if pet then
                        -- 停止所有的效果
                        self._actionTrack:clearActionForEntryId(pet:getId())
                        -- 移除所有buffer
                        self:_clearAllBufferForRole(pet)
                        self._view:removeView(pet)
                        self._model:removeRole(pet)
                    end
                end 
            elseif type == RoleType.Monster then
                -- 这里如果死亡了就移除，等待死亡的移除
                if(not roleData:getIsDead()) then
                    -- self._view:removeView(role)
                    -- self._model:removeRole(role)
                end
                if self._view:getRenderer(role:getId()) == nil then
                    self._model:removeRole(role)
                end
            elseif type == RoleType.Pet then
                -- 移除自己的宠物
                self._actionTrack:clearActionForEntryId(role:getId())
                self:_clearAllBufferForRole(role)
                self._view:removeView(role)
                self._model:removeRole(role)

                Avalon.MessageCenter:notice(GameMessage.MC_COMMON_SHOW_PET)
            end
        elseif category == Category.TRIGGER_NPC then
            if type == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE or type == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE then
                if role:getIsOpen() == true then
                    self._view:removeView(role,false)
                    self._model:removeRole(role)
                else
                    -- self._view:removeView(role)
                    -- self._model:removeRole(role)
                end
            elseif type == PublicDefine.TRIGGER_NPC_TYPE.BOSS_SCENARIO_TRIGGER then
                self._view:removeView(role)
                self._model:removeRole(role)
            elseif type == PublicDefine.TRIGGER_NPC_TYPE.TRAP then
                if(DEBUG) then 
                    print("PublicDefine.TRIGGER_NPC_TYPE.TRAP ", role:getIsOpen())
                end
                if role:getIsOpen() == true then
                    self._view:removeView(role,false)
                    self._model:removeRole(role)
                else
                    self._view:removeView(role)
                    self._model:removeRole(role)
                end
            elseif type == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_TREASURE_MAP or 
                    type == PublicDefine.TRIGGER_NPC_TYPE.FRAGMENT_OF_MOLD then
                if role:getIsOpen() == true then
                    self._view:removeView(role,false)
                    self._model:removeRole(role)
                end
            elseif type == PublicDefine.TRIGGER_NPC_TYPE.QUICK_DOWN 
                or type == PublicDefine.TRIGGER_NPC_TYPE.COLLECT then
                self._view:removeView(role, true)
                self._model:removeRole(role)
            elseif type == PublicDefine.TRIGGER_NPC_TYPE.BOX then
                if SceneManager:getInstance():isInPuzzle() then
                    self._view:removeView(role, true)
                    self._model:removeRole(role)
                end
            else

                -- -- 停止所有的效果
                -- self._actionTrack:clearActionForEntryId(role:getId())

                -- -- 这里直接移除，可能会导致一些飞行道具，或者正在使用该对象作为计算对象，前面修改过一次所有对象都使用ID来获得，目前应该得到的解决
                -- self._view:removeView(role)
                -- -- self._model:removeRole(role)
            end
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_GAME_MODEL, roleData) 
    end
end

function Machine:_controlHeroStartBattleResult(data)
    if(self._model == nil) then return end
    local hero = self._model:getMaster()
    local targetList = {}
    if ProtobufUtil:checkFieldIsInit(data, "selfSpriteID") and data.selfSpriteID > 0 then
        hero =  self._model:getRoleBySpriteID(data.selfSpriteID)
    end
    if hero then
        if DEBUG then
            print("CommandType.CONTROL_HERO_START_BATTLE_RESULT  startBattleResult=",data.startBattleResult,data.enemySpriteID)
        end
        --  判断处理开始战斗的状态
        if (data.startBattleResult == ProtobufUtil:enum_id("RoleSystem.StartBattleResult","StartBattleResult_Success")) then
            -- 判断处理是否在战斗中，如果没有在战斗中就需要同步位置
            local target = nil
            if data.enemySpriteID ~= 0 then
                target = self._model:getRoleBySpriteID(data.enemySpriteID)
                if target then
                    self:_getAllSummonedMonsters()
                    if data.otherGroupMonsterSpriteIDs and table.nums(data.otherGroupMonsterSpriteIDs) > 0 then
                        table.insert(targetList, target)
                        
                        for k, v in pairs(data.otherGroupMonsterSpriteIDs) do
                            local groupTarget = self._model:getRoleBySpriteID(v)
                            if groupTarget then
                                table.insert(targetList, groupTarget)
                            end
                        end
                    elseif target:getData().bossCallMonsterFlag and target:getData().bossCallMonsterFlag > 0 then
                        local summonedMonsters = self:_getAllSummonedMonsters()
                        if summonedMonsters and table.nums(summonedMonsters) > 0 then 
                            -- table.insert(targetList, target)
                            -- for k, v in pairs(summonedMonsters) do
                            --     table.insert(targetList, v)
                            -- end
                            targetList = summonedMonsters
                        end
                    end
                    local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, hero:getId())
                    if (battleStateAction == nil or battleStateAction:getFSMState() ~= FSMState.BATTLE or battleStateAction:isAttackingTarget(target) == false) then
                        if DEBUG then
                            print("CommandType.CONTROL_HERO_START_BATTLE_RESULT  ---------1")
                            print("Machine:_controlHeroStartBattleResult", data.coordX, data.coordY)
                        end
                        
                        -- 同步位置,避免出现错误
                        if ProtobufUtil:checkFieldIsInit(data, "coordX") and ProtobufUtil:checkFieldIsInit(data, "coordY") then
                            local coord = {}
                            coord.x = data.coordX
                            coord.y = data.coordY
                            self:_fsmIdle(hero,coord, false)
                        end

                        if DEBUG then
                            print("CommandType.CONTROL_HERO_START_BATTLE_RESULT  --------2")
                        end
                        -- 进入战斗
                        self:_fsmEnterBattle(hero, target, nil, nil, nil, true)
                        local pets = hero.getFightPet ~= nil and hero:getFightPet() or nil
                        if pets then
                            for _, pet in pairs(pets) do
                                if pet and not pet:getRoleData():getIsDead() then
                                    self:_fsmEnterBattle(pet, target, nil, nil, nil, true)
                                end
                            end
                        end
                        
                    else 
                        -- 同步位置,避免出现错误
                        if ProtobufUtil:checkFieldIsInit(data, "coordX") and ProtobufUtil:checkFieldIsInit(data, "coordY") then
                            local coord = {}
                            coord.x = data.coordX
                            coord.y = data.coordY

                            local masterCoord = hero:getCoord()
                            if(masterCoord) then 
                                if(masterCoord.x ~= coord.x or masterCoord.y ~= coord.y) then 
                                    self:_fsmIdle(hero, coord, false)
                                    -- 进入战斗
                                    self:_fsmEnterBattle(hero, target, nil, nil, nil, true)
                                    local pets = hero.getFightPet ~= nil and hero:getFightPet() or nil
                                    for _, pet in pairs(pets) do
                                        if pet and not pet:getRoleData():getIsDead() then
                                            self:_fsmEnterBattle(pet, target, nil, nil, nil, true)
                                        end
                                    end
                                end
                            end
                        end
                    end

                    -- 客户端通知
                    if table.nums(targetList) > 0 then
                        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ENTER_BATTLE, target:getData(), hero:getSpriteID(), targetList)
                    else
                        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ENTER_BATTLE, target:getData(), hero:getSpriteID())
                    end
                    
                end
            end

            -- add by zp 2018-9-22 这里处理如果在发送请求进入战斗到请求进入战斗结果期间收到服务器通知客户端坐标异常的情况
            local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, hero:getId())
            if (target and (battleStateAction == nil or battleStateAction:getFSMState() ~= FSMState.BATTLE or battleStateAction:isEndBattle() == true)) then
                self:_fsmEnterBattle(hero, target)
                local pets = hero.getFightPet ~= nil and hero:getFightPet() or nil
                for _, pet in pairs(pets) do
                    if pet and not pet:getRoleData():getIsDead() then
                        self:_fsmEnterBattle(pet, target)
                    end
                end
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ENTER_BATTLE, target:getData())

                print("data =", data.enemySpriteID, data.coordX, data.coordY)
                printError("Machine:_controlHeroStartBattleResult  master was not in battle.")
            end
            
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        else
            -- 处理英雄战斗错误
            local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, hero:getId())
            if firstAction then
                if firstAction:getFSMState() == FSMState.BATTLE then
                    firstAction:stopBattle()
                end
            end
            local pets = hero:getFightPet()
            for _, pet in pairs(pets) do
                if pet then
                    local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, pet:getId())
                    if firstAction and firstAction:getFSMState() == FSMState.BATTLE then
                        firstAction:stopBattle()
                    end
                    self:_fsmIdle(pet, pet:getCoord(), false)
                end
            end
            local heroCoord = hero:getCoord()
            if(hero:getIsDead()) then
                -- 玩家死亡，这里不做相关处理
                local coord = Geome.Coord:create()
                coord:setValue(Avalon.MathUtil:getInt(heroCoord.x), Avalon.MathUtil:getInt(heroCoord.y), 0)
                hero:getCoord():setCoord(coord)
                
                -- 处理复活操作
                self:_fsmDeadAction(hero)

                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initStartShowRevive(hero:getId())
                self:pushCommand(renderCommand)
            else
                if(heroCoord and heroCoord.x ~= nil and heroCoord.y ~= nil) then
                    -- 处理回复位置
                    local coord = Geome.Coord:create()
                    coord:setValue(Avalon.MathUtil:getInt(heroCoord.x), Avalon.MathUtil:getInt(heroCoord.y), 0)
                    if GameManager:getIsCenterByMaster() then
                        -- 移动到地图中心点
                        self._view:setMapPositionByCoordinate(coord, false)
                    end
                    -- 设置中心点灯光效果
                    self:setNewCenterCoordinate(coord, coord, coord)

                    self:_fsmIdle(hero, coord, false)
                else
                    if(heroCoord and (heroCoord.x == nil or heroCoord.y == nil)) then
                        -- 处理异常逻辑
                        print("[ERROR] Machine:_controlHeroStartBattleResult ", heroCoord.x, heroCoord.y)
                    end
                end
            end 
        
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, "")
        end
    end
end

function Machine:_controlHeroSwitchBattleResult(data)
    local isSwitch = false
    if(self._model == nil) then return end
    local hero = self._model:getMaster()
    local targetList = {}
    if ProtobufUtil:checkFieldIsInit(data, "selfSpriteID") and data.selfSpriteID > 0 then
        hero =  self._model:getRoleBySpriteID(data.selfSpriteID)
    end
    if hero then
        if DEBUG then
            print("CommandType.CONTROL_HERO_START_BATTLE_RESULT  startBattleResult=",data.startBattleResult,data.enemySpriteID)
        end

        -- local roleData = hero:getRoleData()
        -- if (hero:getCategory() == Category.ROLE and hero:getType() == RoleType.Hero and roleData:isMasterHero()) then
        --     print("_fsmSwitchBattleremoveBattleFieldRole")
        --     self._model:removeBattleFieldRole(hero)
        -- end

        if (data.startBattleResult == ProtobufUtil:enum_id("RoleSystem.SwitchBattleResult","SwitchBattleResult_CD")) then
            UI.ScrollBar:createByText(UI.TEXT_223814)
            return 
        end

        --  判断处理开始战斗的状态
        if (data.startBattleResult == ProtobufUtil:enum_id("RoleSystem.SwitchBattleResult","SwitchBattleResult_Success")) then
            if data.lastSwitchTime and data.lastSwitchTime > 0 then
                Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_SWITCH_TIME, data.lastSwitchTime or 0)
            end

            -- 判断处理是否在战斗中，如果没有在战斗中就需要同步位置
            local target = nil
            if data.enemySpriteID ~= 0 then
                target = self._model:getRoleBySpriteID(data.enemySpriteID)
                if target then
                    self:_fsmSwitchBattle(hero, target, nil, nil, nil, true)
                    local pets = hero.getFightPet ~= nil and hero:getFightPet() or nil
                    for _, pet in pairs(pets) do
                        if pet and not pet:getRoleData():getIsDead() then
                            self:_fsmSwitchBattle(pet, target, nil, nil, nil, true)
                        end
                    end

                    -- 客户端通知
                    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_DATA, target:getData())
                    -- if table.nums(targetList) > 0 then
                    --     Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ENTER_BATTLE, target:getData(), hero:getSpriteID(), targetList)
                    -- else
                    --     Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ENTER_BATTLE, target:getData(), hero:getSpriteID())
                    -- end
                end
            end

            -- add by zp 2018-9-22 这里处理如果在发送请求进入战斗到请求进入战斗结果期间收到服务器通知客户端坐标异常的情况
            -- local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, hero:getId())
            -- if (target and (battleStateAction == nil or battleStateAction:getFSMState() ~= FSMState.BATTLE or battleStateAction:isEndBattle() == true)) then
            --     self:_fsmEnterBattle(hero, target)
            --     local pets = hero.getFightPet ~= nil and hero:getFightPet() or nil
            --     for _, pet in pairs(pets) do
            --         if pet and not pet:getRoleData():getIsDead() then
            --             self:_fsmEnterBattle(pet, target)
            --         end
            --     end
            --     Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_ENTER_BATTLE, target:getData())

            --     print("data =", data.enemySpriteID, data.coordX, data.coordY)
            --     printError("Machine:_controlHeroStartBattleResult  master was not in battle.")
            -- end
            
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        else
            -- 处理英雄战斗错误
            -- local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, hero:getId())
            -- if firstAction then
            --     if firstAction:getFSMState() == FSMState.BATTLE then
            --         firstAction:stopBattle()
            --     end
            -- end
            -- local pets = hero:getFightPet()
            -- for _, pet in pairs(pets) do
            --     if pet then
            --         local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, pet:getId())
            --         if firstAction and firstAction:getFSMState() == FSMState.BATTLE then
            --             firstAction:stopBattle()
            --         end
            --         self:_fsmIdle(pet, pet:getCoord(), false)
            --     end
            -- end
            -- local heroCoord = hero:getCoord()
            -- if(hero:getIsDead()) then
            --     -- 玩家死亡，这里不做相关处理
            --     local coord = Geome.Coord:create()
            --     coord:setValue(Avalon.MathUtil:getInt(heroCoord.x), Avalon.MathUtil:getInt(heroCoord.y), 0)
            --     hero:getCoord():setCoord(coord)
                
            --     -- 处理复活操作
            --     self:_fsmDeadAction(hero)

            --     local renderCommand = Command.RendererCommand:create(true)
            --     renderCommand:initStartShowRevive(hero:getId())
            --     self:pushCommand(renderCommand)
            -- else
            --     if(heroCoord and heroCoord.x ~= nil and heroCoord.y ~= nil) then
            --         -- 处理回复位置
            --         local coord = Geome.Coord:create()
            --         coord:setValue(Avalon.MathUtil:getInt(heroCoord.x), Avalon.MathUtil:getInt(heroCoord.y), 0)
            --         if GameManager:getIsCenterByMaster() then
            --             -- 移动到地图中心点
            --             self._view:setMapPositionByCoordinate(coord, false)
            --         end
            --         -- 设置中心点灯光效果
            --         self:setNewCenterCoordinate(coord, coord, coord)

            --         self:_fsmIdle(hero, coord, false)
            --     else
            --         if(heroCoord and (heroCoord.x == nil or heroCoord.y == nil)) then
            --             -- 处理异常逻辑
            --             print("[ERROR] Machine:_controlHeroStartBattleResult ", heroCoord.x, heroCoord.y)
            --         end
            --     end
            -- end 
        
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, "")
        end
    end
end

-- 同屏英雄开始战斗
function Machine:_controlScreenHeroStartBattle(data)
    if(self._model == nil) then return end
    local hero = self._model:getRoleBySpriteID(data.spriteID)
    local target = self._model:getRoleBySpriteID(data.targetSpriteID)
    if hero and target then
        -- 进入战斗
        self:_fsmEnterBattle(hero, target)
        local pet = hero.getFightPet ~= nil and hero:getFightPet() or nil

        if pet ~= nil then
            for _,fPet in pairs(pet) do
                if fPet and fPet:getRoleData() and not fPet:getRoleData():getIsDead() then
                    self:_fsmEnterBattle(fPet, target)
                end
            end
        end
        
    elseif hero then
        self:_fsmIdle(hero, hero:getCoord(), false)
    end
end

-- 服务器通知玩家开始使用技能，主要用于同步表现
function Machine:_controlNotifyStartUseSkill(data)
    if(self._model == nil) then return end
    -- 控制开始使用技能
    local master = self._model:getMaster()

    if(master) then 
        local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if (battleStateAction and  battleStateAction:getFSMState() == FSMState.BATTLE) then
            battleStateAction:serverNotifyStartSkill(data.skillID, data.timeStamp)
        else 
            -- add by zp  CO-5459【洞窟】显示已经脱战，持续被攻击至死
            local coord = master:getCoord()
            if(coord) then
                Net.NetRoleSystem:heroStartMoveRequest(coord.x, coord.y, master:getDirection())
            end
        end
    end 
end

function Machine:_controlRoleSkillMiss(data)
    if(self._model == nil) then return end
    local role = self._model:getRoleBySpriteID(data.targetSpriteID)
    if role then
        -- 处理发送伤害数值
        local mesData = {}
        mesData.attrChange = {}

        local oneData = {}
        oneData.value = 0
        oneData.type = 0
        oneData.reason = CLIENT_ATTR_CHANGE_REASON.DAMAGE_MISS

        table.insert(mesData.attrChange,oneData)

        if DEBUG then
            print("Machine:onExecuteControlCommand   CONTROL_ROLE_SKILL_MISS ",oneData.value,oneData.type,oneData.reason)
        end

        local direction = role:getDirection()
        if(role:getType() == RoleType.Hero or role:getType() == RoleType.Pet) then
            if(role:getIsEscape() == true) then
                direction = Geome.reverseDirection(direction)
            end
        end

        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initUpdateAttrCommand(role:getId(), mesData, direction)
        self:pushCommand(renderCommand)
    end
end

function Machine:_controlRefreshAllSkillCD(data)
    if(self._model == nil) then return end
    local master = self._model:getMaster()
    if(master) then
        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_SKILL_REFRESH_ALL_CD)
    end
end

function Machine:_controlNofifyRoleSkillStatus(data)
    if(self._model == nil) then 
        return
    end

    local hero = self._model:getRoleBySpriteID(data.spriteID)
    local attackTarget = nil
    if data.targetSpriteID ~= nil then
        attackTarget = self._model:getRoleBySpriteID(data.targetSpriteID)
    end

    if hero then
        local skillData = SkillDataManager:createSkillForSkillId(data.skillID)
        if(skillData and skillData:isHorcurx()) then
        elseif(skillData and skillData:isAssist()) then
            if(hero:isMaster() or (hero:getType() == RoleType.Pet and hero:getMaster():isMaster())) then
            else
                -- 触发传送相关的表现
                local battleCMD = Command.BattleCommand:create(true)
                battleCMD:initUseAssistSkil(hero:getSpriteID(), skillData, nil)
                SceneManager:getInstance():pushCommand(battleCMD)
            end
        else
            self:_fsmEnterBattle(hero, attackTarget,data.targetSpriteID,data.skillID,data.skillState)
            if(hero:isMaster()) then 
                local pk = 0
                if hero:getRoleData() and hero:getRoleData().getPK then 
                    pk = hero:getRoleData():getPK()
                end
                if (device.platform == "ios" or device.platform == "android") then
                    buglyReportLuaException("_controlNofifyRoleSkillStatus hero is Master state= "..SceneManager:getInstance():getState().."pk=".. pk)
                else
                    print("_controlNofifyRoleSkillStatus hero is Master state="..SceneManager:getInstance():getState().."pk=".. pk.." skillID = "..data.skillID)
                end
            end
        end
    end
end

function Machine:_controlNotifyRoleSkillBreak(data)
    if(self._model == nil) then return end
    local hero = self._model:getRoleBySpriteID(data.spriteID)
    if (hero) then
        local action = self:_getBattleAction(hero)
        if (action) then
            -- add by zp 这里玩家不应该自己打断自己的技能，如果是队友就正常处理 CO-14203
            local ignorForRelease = false
            if(hero.isMaster and hero:isMaster()) then 
                local skillData = SkillDataManager:createSkillForSkillId(data.skillID)
                -- add by zp 这里由于特殊技能会出现相关的情况，这里只有处于引导技能才做相关的处理 CO-14312【扭曲空间】旋风斩技能点击无效
                if(skillData and skillData.type ~= SkillType.NORMAL_ATTACK and skillData:hasGuide()) then
                    ignorForRelease = true
                end
            end

            action:breakSkill(data.skillID, ignorForRelease)
        else
            printError(string.format("Machine:_controlNotifyRoleSkillBreak: no skill %d to break.", data.skillID))
        end
    else
        printError("Machine:_controlNotifyRoleSkillBreak: no hero found when break skill.")
    end
end

function Machine:_controlNotifyRoleSkillResult(data)
    if(self._model == nil) then return end
    local hero = nil
    local spriteID = nil
    if ProtobufUtil:checkFieldIsInit(data, "spriteID") and data.spriteID and data.spriteID ~= 0 then
        hero = self._model:getRoleBySpriteID(data.spriteID) 
        spriteID = data.spriteID
    else
        hero = self._model:getMaster()
        if data.isPet then
            hero = hero:getCaptainPet()
        end
    end
    local skillData = SkillDataManager:getSkillDataForSkillID(data.skillID, hero:getType() == RoleType.Pet)
    if (hero) then
        -- 更新技能的状态
        -- if(skillData) and (not data.isOpening) then
        --     skillData:setIsOpening(data.isOpening)

        --     Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_SKILL_ISOPEN_STATUS, data.skillID)
        -- end

        local action = self:_getBattleAction(hero)
        if (action ) then
            if(data.result ~= "HeroUseSkillResult_Succeed") then
                action:breakSkill(data.skillID)

                -- local skillData = SkillDataManager:createSkillForSkillId(data.skillID)
                if(skillData and skillData:getSkillType() ~= SkillType.NORMAL_ATTACK) then
                    -- 这里必须这里处理，不然可能会出现逻辑问题
                    if(action:isEndBattle() == false) then
                        --add by zp CO-5795【技能】剑盾反击技能没有正常表现
                        if(data.result ~= "HeroUseSkillResult_SystemError") then 
                            GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.HeroUseSkillResult", data.result), true)
                        end
                    end
                end
            end
        else
            -- 非战斗状态下使用技能
            if(data.result ~= "HeroUseSkillResult_Succeed") then
                local animationCommand = Command.RendererCommand:create(true)
                animationCommand:initAssistUseFail(hero:getId())
                SceneManager:getInstance():pushCommand(animationCommand)

                -- 屏蔽错误提示
                if(skillData and skillData:getSkillType() ~= SkillType.NORMAL_ATTACK) then
                    -- add by zp CO-5795【技能】剑盾反击技能没有正常表现
                    if(data.result ~= "HeroUseSkillResult_SystemError") then 
                        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.HeroUseSkillResult", data.result))
                    end
                end 
            end
        end
    else
        printError("[ERROR] BattleMachine onExecuteControlCommand: no hero found when break skill.")
    end

    if(data.result ~= "HeroUseSkillResult_Succeed") then
        if(data.skillID == TRANSFER_SKILL_ID) then
            local animationCommand = Command.RendererCommand:create(true)
            animationCommand:initAssistUseFail(hero:getId())
            SceneManager:getInstance():pushCommand(animationCommand)

            GameManager:enableMovingHandler(true)
            GameDataManager:getInstance():setDisableSituation(false)
            
            if(hero) then 
                local action = Action.IDLEStateAction:create(true)
                action:init(hero, hero:getCoord(), self)
                self:setAction(action)
            end
        end
    else 
        if(data.skillID == TRANSFER_SKILL_ID) then
            -- 这里采用的零时方案处理
            AUTO_RESET_TRANSFER_FLAG = true
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                if(AUTO_RESET_TRANSFER_FLAG) then
                    AUTO_RESET_TRANSFER_FLAG = false
                    local directionCommand = Command.RendererCommand:create(true)
                    directionCommand:initAssistTransferEnd(hero:getId())
                    self:pushCommand(directionCommand)

                    if(hero and hero:isMaster()) then
                        GameManager:enableMovingHandler(true)
                        GameDataManager:getInstance():setDisableSituation(false)
                    end
                end
            end, 2)
        end
    end

    if(skillData and skillData:getSkillType() ~= SkillType.NORMAL_ATTACK) then
        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_USE_SKILL_RESULT, data.skillID, data.result, spriteID)
    end 
end

function Machine:_controlNotifyRoleSkillAccumulate(data)
    if(self._model == nil) then return end
    if (data) then
        if DEBUG then
            for k,v in pairs(data) do
                print("Machine:_controlNotifyRoleSkillAccumulate CONTROL_NOTIFY_ROLE_SKILL_ACCUMULATE k,v=",k,v)
            end
        end

        local skillID = data.skillID
        local duration = data.durationTime
        local timeStamp = data.timestamp

        local master = self._model:getMaster()
        local action = self:_getBattleAction(master)
        if (action) then
            action:tickPrepareSkill(skillID, duration, timeStamp)
        else
            print(string.format("BattleMachine:_controlNotifyRoleSkillAccumulate: no battle action found when cool down skill %d.", data.skillID))
        end
    end
end

function Machine:_controlRemoveAllFX(data)
    if(self._model == nil) then return end
    local target = self._model:getRoleBySpriteID(data.spriteID)
    if target then
        self:_clearAllBufferForRole(target)
    end
end

function Machine:_controlEscapeFailed(data)
    if(self._model == nil) then return end
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ESCAPE_FAILED, data)

    local master = self._model:getMaster()
    if(master) then
        -- 处理终止逃跑
        local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, master:getId())
        if (battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE) then
            battleStateAction:runAwayFailed()
        end
    end
end

function Machine:_controlNotifyHeroEscape(data)
    if(self._model == nil) then return end
    local role = self._model:getRoleBySpriteID(data.spriteID)
    if role then
        self:_fsmBattleEscape(role)
    end
end

function Machine:_controlNotifyHeroCancelEscape(data)
    if(self._model == nil) then return end
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ESCAPE_CANCEL, data)

    local role = self._model:getRoleBySpriteID(data.spriteID)
    if role then
        -- 处理取消逃跑
        self:_fsmBattleCancelEscape(role)
    end
end

function Machine:_controlRoleLeaveBattle(data)
    if(self._model == nil) then return end
    local role = self._model:getRoleBySpriteID(data.spriteID)
    if role then
        local pets = role.getFightPet ~= nil and role:getFightPet() or nil
        if pets then
            for _, pet in pairs(pets) do
                if pet then
                    local pData = clone(data)
                    pData.spriteID = pet:getSpriteID()
                    self:_controlRoleLeaveBattle(pData)
                end
            end
        end
        
        

        local roleData = role:getRoleData()
        -- 清理技能是否打开的状态
        if (role:getCategory() == Category.ROLE and role:getType() == RoleType.Hero and roleData:isMasterHero()) then
            SkillDataManager:clearIsOpenStatus()
            -- add by zp CO-14877【技能】宠物主动技能使用后第二场战斗会有前置CD
            -- if(RoleDataManager:getScreenFightPetData()) then
            --     RoleDataManager:getScreenFightPetData():clearSkillCd()
            -- end
            -- if(MasterDataManager:getCaptainPet()) then
            --     MasterDataManager:getCaptainPet():clearSkillCd()
            -- end
            if RoleDataManager:getCaptain() then
                RoleDataManager:getCaptain():clearSkillCd()
            end
        end
        
        -- 清理战斗状态
        roleData:clearBattleStatus()

        local action = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, role:getId())
        if (action and action:getFSMState() == FSMState.BATTLE) then
            if(data.leaveBattleReason == "LeaveBattleReason_victory") then
                if(role:getIsDead()) then
                    action:complete()
                   
                else
                    action:win()
                end
            elseif (data.leaveBattleReason == "LeaveBattleReason_escape") then
                if(role:getIsDead()) then
                    action:complete()
                else
                    action:lose()
                end
                if(role:getState() == FSMState.BATTLE) then
                    self:addIdleAction(role,nil)
                else 
                    if(role:getState() ~= FSMState.IDLE) then
                        self:_fsmIdle(role, role:getCoord(), false)
                    else 
                        local updateAnimationCommand = Command.RendererCommand:create(true)
                        updateAnimationCommand:initUpdateAnimationCommand(role:getId(), CommandAnimationType.IDLE)
                        self:pushCommand(updateAnimationCommand)
                    end
                end 
            elseif (data.leaveBattleReason == "LeaveBattleReason_leaveTeam") then
                if(role:getIsDead()) then
                    action:complete()
                else
                    action:lose()
                end
            elseif (data.leaveBattleReason == "LeaveBattleReason_dead") then
                action:complete()
            elseif (data.leaveBattleReason == "LeaveBattleReason_useSkill") then
                action:userSkillLose()
            elseif (data.leaveBattleReason == "LeaveBattleReason_settle") then
                if(role:getIsDead()) then
                    action:complete()
                else
                    action:lose()
                end
            else
                printError(string.format("Machine:_controlRoleLeaveBattle no handle leaveBattleReason=%s",data.leaveBattleReason))
            end
        else
            self:addIdleAction(role)
        end

        roleData.status = PublicDefine.SPRITE_STATUS.IDLE
        roleData.residualEscapeTime = 0
        roleData.targetSpriteID = 0

        -- 如果是怪物，清理身上的buff效果
        if (role:getCategory() == Category.ROLE and role:getType() == RoleType.Monster) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_UPDATE_DECORETION_PROGRESS, "BOSS6_ENERGY_KEY", 0)
            
            if(role:isBigBoss()) then
                local bossLevel = self._model:getMapData().number
                local plotID = nil
                if(bossLevel == 1) then
                    
                elseif (bossLevel == 2) then
                    plotID = 1020032
                elseif (bossLevel == 3) then
                    plotID = 1030032
                elseif (bossLevel == 4) then
                    plotID = 1040032
                elseif (bossLevel == 5) then
                    plotID = 1050032
                    -- 关闭
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initBossShowTransforRecover(role:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                elseif (bossLevel == 8) then
                    plotID = 1070005
                elseif (bossLevel == 10) then
                    plotID = 1100032 
                elseif (bossLevel == 11) then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initBossShowTransforRecover(role:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                elseif (bossLevel == 13) then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initBossShowTransforRecover(role:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                elseif (bossLevel == 20) then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initBossShowTransforRecover(role:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                elseif (bossLevel == 29) then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initBossShowTransforRecover(role:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                elseif (bossLevel == 34) then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initBossShowTransforRecover(role:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                end
               
                if role:getRoleData().isRecover and role:getRoleData().isRecover == 1 then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initBossShowTransforRecover(role:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                end
                
                if(plotID) then
                    PlotManager:getInstance():runPlotByID(plotID)
                end

                local bossLevel = self._model:getMapData().number
                if(bossLevel == 8) then 
                    if(role:getIsDead()) then
                        ToolsUtil:triggerHandleMap8Moon(false, false)
                    else 
                        ToolsUtil:triggerHandleMap8Moon(false, true)
                    end
                elseif (bossLevel == 15) then 
                    if(role:getIsDead()) then
                        ToolsUtil:triggerHandleMap15Moon(false, false)
                    else 
                        ToolsUtil:triggerHandleMap15Moon(false, true)
                    end
                end
            elseif(role:isSmallBoss()) then

            else 

            end

            -- 恢复原来的状态
            if(role:getIsDead() == false) then 
                -- 这里怪物需要恢复变身状态
                if(role:getRoleData()) then 
                    role:getRoleData():enableDeformation()
                end

                local deformationData = role:getDeformationData()
                if(deformationData) then 
                    local renderCommand = Command.RendererCommand:create(true)
                    renderCommand:initItemDeformationShow(role:getId(), role:getDeformationData())
                    self:pushCommand(renderCommand)

                    -- 如果为触发怪需要修改为未触发状态
                    if(deformationData:getCategory() == Category.ROLE and deformationData:getType() == RoleType.Monster) then 
                        if(deformationData:judgeNeedToTrigger()) then 
                            deformationData:setIsTrigger(false)
                        end 
                    end
                end

                if role:getRoleData():checkIsRandomChange() then
                    local animationCommand = Command.RendererCommand:create(true)
                    animationCommand:initBossShowTransforRecover(role:getId())
                    SceneManager:getInstance():pushCommand(animationCommand)
                end

                if role:getRoleData().BossAIFlag and role:getRoleData().BossAIFlag > 0 then
                    role:getRoleData().BossAIFlag = 0
                    role:getRoleData().evoParts = {}
                    local rendererCommand = Command.RendererCommand:create(true)
                    rendererCommand:initIDLEAnimationCommand(role:getId())
                    SceneManager:getInstance():pushCommand(rendererCommand)
                end

                Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CHANGE_TYPE, role)
            end
        end

        -- 当前未做完整的情况给处理逻辑
        self._model:removeBattleFieldRole(role)

        -- 这里判断是否死亡，如果死亡触发复活倒计时
        if (role:getCategory() == Category.ROLE ) then
            -- 清理战斗状态
            roleData:clearBattleStatus()

            if(role:getType() == RoleType.Hero) then
                if(roleData:getIsDead()) then
                    -- if(roleData:isMasterHero()) then
                        -- 添加死亡 ACTION
                        self:_fsmDeadAction(role)

                        local renderCommand = Command.RendererCommand:create(true)
                        renderCommand:initStartShowRevive(role:getId())
                        self:pushCommand(renderCommand)
                end 
            elseif(role:getType() == RoleType.Pet) then
            elseif(role:getType() == RoleType.Monster) then
                if(roleData:getIsDead() == false) then
                    self:_fsmIdle(role, role:getCoord(), false)
                end
            end
        end

        -- 判断是否为玩家
        if role:isMaster() then
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, "")
            SkillDataManager:clearAllShadowSkill()
            SkillDataManager:clearAllNtfMarkSkill()
        end
    else
        local master = RoleDataManager:getMaster()
        if(master and data.spriteID == master.spriteID) then
            master.status = PublicDefine.SPRITE_STATUS.IDLE
            master.residualEscapeTime = 0
            master.targetSpriteID = 0
        end
    end
end

function Machine:_controlRoleDie(data)
    RoleDataManager:handleRoleDie(data)
    if(self._model == nil) then return end
    
    local role = self._model:getRoleBySpriteID(data.spriteID)
    if role and role:getType() == RoleType.Pet then
       self:_fsmPetDie(role)
    else
        if role then
            if(role.setInfernoReviveNum) then
                role:setInfernoReviveNum(data.infernoReviveNum)
            end

            if(role.voidRiftReviveNum) then
                role:setVoidRiftReviveNum(data.voidRiftReviveNum)
            end

            if(role.viKingReviveNum) then
                role:setViKingReviveNum(data.viKingReviveNum)
            end

            self:_fsmDie(role,false, false, data.murdererSpriteID, data.groupMonsterId, data.isGroupMonsterDeadAll or false, data.everyGroupMonsterId)
        else 
            local master = RoleDataManager:getMaster()
            if(master and data.spriteID == master.spriteID) then
                if(SceneManager:getInstance():isGuildBoss()) then 
                    GameDataManager:getInstance():setGuildBossBackTownTimeOut(true)
                end
                master:setIsDead(true)
            end
        end 
    end
end

function Machine:_controlNpcOpen(data)
    local npc = self._model:getRoleBySpriteID(data.spriteID)
    if npc then
        -- 处理
        if npc:getCategory() == Category.TRIGGER_NPC then
            if(npc:getType() == PublicDefine.TRIGGER_NPC_TYPE.COLLECT) then
                return     
            end
            self:_triggerNPCOpen(npc,false, data.triggerSpriteID)
            Avalon.AudioManager:playSoundByConfig("23",npc:getNpcData():getId(),nil,npc:getCoord())
        else 
            printError("Machine:_controlNpcOpen category="..npc:getCategory())
        end
    end
end

function Machine:_controlTriggerNpcFailed(data)
    local npc = self._model:getRoleBySpriteID(data.spriteID)
    local master = self._model:getMaster()
    if npc and master and master:getState() == FSMState.WAITING then
        -- 这里如果为会阻塞玩家操作状态，需要去掉当前的状态
        local action = Action.IDLEStateAction:create(true)
        action:init(master, master:getCoord(), self)
        self:setAction(action)
    end
end

function Machine:_controlDigWall(data)
    local coord = data
    if (DEBUG) then
        print("BattleHandleControlCmdMachine onExecuteControlCommand: map changed coord:", coord.x, coord.y)
    end

    local mapData = self._model:getMapData()
    MapDataManager:transformTileToReachableAtCoord(mapData, coord.x, coord.y)

    local rendererCommand = Command.RendererCommand:create(true)
    rendererCommand:initMapTileChangeCommand(coord.x, coord.y)
    self:pushCommand(rendererCommand)

    self:refreshTrapCover(coord.x, coord.y)

    -- 发送地形改变的消息
    Avalon.MessageCenter:notice(GameMessage.MC_MAP_UPDATE_MAP_TILE, coord)
end

function Machine:_controlHeroTransfer(data)
    if DEBUG then   
        for k,v in pairs(data) do
            print("Machine:_controlHeroTransfer  CONTROL_HERO_TRANSFER k,v=",k,v)
        end
    end
    local hero = self._model:getRoleBySpriteID(data.spriteID)
    if hero then
        -- 移除所有当前状态以及表现
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
        self:_fsmIdle(hero, coord, true)

        MachineManager:getInstance():pushPositionRendererCommand(hero, coord, hero:isMaster())

        -- 同步方向
        local directionCommand = Command.RendererCommand:create(true)
        directionCommand:initUpdateDirectionCommand(hero:getId(), data.direction)
        self:pushCommand(directionCommand)
        self:moveOneStepTrigger()


        local pets = hero.getFightPet ~= nil and hero:getFightPet() or nil
        if pets then
            for k, pet in pairs(pets) do
                local firstAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, pet:getId())
                if firstAction then
                    if firstAction:getFSMState() == FSMState.BATTLE then
                        firstAction:stopBattle()
                        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, "")
                    end
                end

                self:_fsmIdle(pet, coord, true)
                MachineManager:getInstance():pushPositionRendererCommand(pet, coord, pet:isMaster())

                -- 同步方向
                local directionCommand = Command.RendererCommand:create(true)
                directionCommand:initUpdateDirectionCommand(pet:getId(), data.direction)
                self:pushCommand(directionCommand)
            end  
        end
        if(hero:isMaster()) then
            -- 触发提示深渊房间TIPS
            self:_handleTriggerDungeonRoomTips(hero:getData(), false)

            if GameManager:getIsCenterByMaster() then
                -- 移动到地图中心点
                self._view:setMapPositionByCoordinate(coord, true)
            end
            -- 设置中心点灯光效果
            -- self:setNewCenterCoordinate(coord,coord,coord)

            -- 触发相关事件
            self:handleMapTrigger(TRIGGER_TYPE.TRIGGER_ALL, coord, true, false, true, GameTriggerTimeType.TRIGGER_TIME_NORMAL)

            self:_triggerOpenMiniMap(hero, coord)

            -- if(SceneManager:getInstance():isInDungeon()) then
            --     -- TODO 处理大秘境房间是否触发打开处理逻辑
            --     if self._model._mapData:isDungeonRoomReachedAtCoordinate(coord.x, coord.y) == false then
            --         self._model._mapData:setDungeonRoomReachedAtCoordinate(coord.x, coord.y, true)
            --         local coordArr = self._model._mapData:getCoordinatesReachableInRoomAtCoordinate(coord.x, coord.y)
            --         if(coordArr) then
            --             Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_SHOW_ICON, true, coordArr)
            --         end
            --     end
            -- end

            local enterCenterCoordCommand = Command.RendererCommand:create(true)
            enterCenterCoordCommand:initEnterCenterCoordCommand(hero:getId(), coord, true)
            self:pushCommand(enterCenterCoordCommand)
        end

        -- 判断是否为辅助技能传送 
        if(data.reason == "TransferReason_SKILL") then 
            AUTO_RESET_TRANSFER_FLAG = false
            local directionCommand = Command.RendererCommand:create(true)
            directionCommand:initAssistTransferEnd(hero:getId())
            self:pushCommand(directionCommand)

            if(hero:isMaster()) then
                GameManager:enableMovingHandler(true)
                GameDataManager:getInstance():setDisableSituation(false)
            end
        end
    end
end

-- 处理复活
function Machine:_controlRevive(data)
    if self._model == nil then
        return
    end
    local role = self._model:getRoleBySpriteID(data.spriteID)
    if role then
        self:_fsmRevive(role)
    end
end

-- 处理群怪复活
function Machine:_controlGroupMonsterRevive(data)
    if self._model == nil then
        return
    end
    for _, spriteID in pairs(data.spriteID) do
        local role = self._model:getRoleBySpriteID(spriteID)
        if role then
            self:_fsmRevive(role)
        end
    end
end

-- 复活返回状态
function Machine:_controlReviveResponse(data)
    local masterData = GameDataManager:getInstance():getMaster()
    local selfRequest = false
    if (masterData:getSpriteID() == data.spriteID ) then
        selfRequest = true
    end

    if(data.reviveResult == "ReviveSuccess") then
        masterData:setIsInRevive(true)
        local role = self._model:getRoleBySpriteID(data.targetSpriteID)
        if role then
            self:_fsmRevive(role)
            Avalon.AudioManager:playSound("557")

            -- 发送复活成功的消息
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE_START,role:getRoleData())
        end
    elseif(data.reviveResult == "PlayerIsNotDead") then
        -- 处理已经复活的情况
        local role = self._model:getRoleBySpriteID(data.targetSpriteID)
        if role then
            self:_fsmIdle(role, role:getCoord(), false)

            -- 发送复活成功的消息
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE_START,role:getRoleData())
        end

        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.ReviveResult", data.reviveResult))
    else
        -- 处理是否由于数据不同步导致的复活失败的问题
        
        if(data.diamondMatching) then 
            local heroData = RoleDataManager:getHeroDataForSpriteID(data.targetSpriteID)
            local heroName = ""
            if(heroData and heroData:getIsDead()) then 
                heroName = heroData:getNickName()
                heroData:setReviveServerDiamond(data.serverDiamondNum)
            end 
            if(data.spriteID == data.targetSpriteID) then
                Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH)
            else 
                local targetSpriteID = data.targetSpriteID
                local serverDiamondNum = data.serverDiamondNum
                local str = string.format(UI.TEXT_1212359, heroName)
                local confirmDialog = UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(str, function(isSelect)
                    GameManager:battleReviveHelp(targetSpriteID, serverDiamondNum)
                    Avalon.AudioManager:playSound("1504")
                end, function(isSelect)
                    
                end, nil, nil, false, serverDiamondNum)
                if(confirmDialog) then 
                    confirmDialog:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_18PX)
                end
            end

            if(data.reviveResult == "ReviveError") then 
                
            else 
                GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.ReviveResult", data.reviveResult))
            end 
        else 
            GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.ReviveResult", data.reviveResult))
        end

        if(selfRequest) then
            -- 复活失败需要继续运行倒计时
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE_CONTINUE)
        end
    end
end

-- 复活完成
function Machine:_controlReviveComplete(data)
    local role = self._model:getRoleBySpriteID(data.spriteID)
    if(role) then
        role:setIsDead(false)

        local dieAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, role:getId())
        if((dieAction and (dieAction:getFSMState() == FSMState.DIE)) or role:getState() == FSMState.DIE) then
            role:switchState(FSMState.REVIVE)
            -- 同时通知移除死亡效果
        else 
            role:switchState(FSMState.REVIVE)
        end

        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initRoleEndRevive(role:getId())
        self:pushCommand(renderCommand)

        self:_fsmIdle(role, role:getCoord(), false)
        GameManager:notifyRoleFSMChange(role:getData())
        if(role:isMaster()) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_BAG_BUTTON)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE_END, role:getData())
        self:moveOneStepTrigger()
        if(role and role:isMaster()) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_MASTER_REVIVE)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER)

            self:handleMapTrigger(TRIGGER_TYPE.TRIGGER_ALL, role:getCoord(), role:isMaster(), false, true, GameTriggerTimeType.TRIGGER_TIME_NORMAL)
        end
    else 
        local master = RoleDataManager:getMaster()
        if(master and data.spriteID == master.spriteID) then
            master:setIsDead(false)
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE_END, master)
        end
    end
end

function Machine:_controlBackTown()
    local masterModel = self._model:getMaster()
    if masterModel then
        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initUpdateAnimationCommand(masterModel:getId(),CommandAnimationType.BACK_TOWN)
        self:pushCommand(renderCommand)
    end
end

function Machine:_controlChamberOpen(data)
    local entrance = {x=data.entranceX,y=data.entranceY}
    local connectPoint = {x=data.connectPointX,y=data.connectPointY}
    local rect = { x = data.boundingX, y = data.boundingY, width = data.boundingWidth, height = data.boundingHeight}
    if(DEBUG) then
        print("Machine:_controlChamberOpen entrance x,y=",entrance.x,entrance.y)
        print("Machine:_controlChamberOpen connectPoint x,y=",connectPoint.x,connectPoint.y)
    end
    MapDataManager:getInstance():generateChamber(self._model:getMapData(), data.chamberID, entrance, connectPoint, rect)

    -- 更新地图的渲染命令
    local renderCommand = Command.RendererCommand:create(true)
    renderCommand:initCommand(CommandType.RENDERER_MAP_TILE_UPDATE)
    self:pushCommand(renderCommand)

    -- 发送消息
    local dirtyMapTileDataList = self._model:getMapData():getDirtyTileDatas()
    Avalon.MessageCenter:notice(GameMessage.MC_MAP_UPDATE_MAP, dirtyMapTileDataList)

    -- 刷新陷阱
    self:refreshTrapCoverForChamber()
end

function Machine:_controlTriggerNpcUnlock(data)
    local role = self._model:getRoleBySpriteID(data.spriteID)
    if(role) then
        -- 解锁
        role:unlock()

        -- 对于boss 大门需要移除所有 placeholder 
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE) then
            local npcData = role:getNpcData()
            local coord = npcData:getCoord()
            -- print("Machine:_controlTriggerNpcUnlock  coord=", coord.x, coord.y)
            MapDataManager:getInstance():removePlaceholderData(self._model:getMapData(), coord.x, coord.y, npcData)

            self:_triggerNPCOpen(role, false, nil)
        else
            -- 更新地图的渲染命令
            local renderCommand = Command.RendererCommand:create(true)
            renderCommand:initTriggerNpcUnlock(role:getId())
            self:pushCommand(renderCommand)
        end
    else
        printError("Machine:_controlTriggerNpcUnlock  role is no found.")
    end
end

function Machine:_controlChamberEntranceUnlock(data)
    -- 触发机关密室门解锁震动
    Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, 4)
    -- 音效
    Avalon.AudioManager:playSound("1022")
end

-- 处理boss开始
function Machine:_controlBossBeginScenario(data)
    -- 处理开始boss 剧情
    if(data.scenarioType == BOSS_SCENARIO_TYPE.OPENING) then
        local bossLevel = self._model:getMapData().number
        print("_controlBossBeginScenario", bossLevel)
        local plotID = nil
        if(bossLevel == 1) then
            plotID = 1010011
        elseif (bossLevel == 2) then
            plotID = 1020011
        elseif (bossLevel == 3) then
            if(SceneManager:getInstance():isInDream()) then
                plotID = 1130011
            else 
                plotID = 1030011
            end
        elseif (bossLevel == 4) then
            if(SceneManager:getInstance():isInHero()) then
                plotID = 1040013
            else 
                plotID = 1040011
            end
        elseif (bossLevel == 5) then
            plotID = 1050011
        elseif (bossLevel == 7) then
            plotID = 1060011
        elseif (bossLevel == 8) then
            plotID = 1070001
        elseif (bossLevel == 10) then
            plotID = 1100011
        elseif (bossLevel == 11) then
            plotID = 1030011
        elseif (bossLevel == 12) then
            plotID = 1200011
        elseif (bossLevel == 13) then
            plotID = 1050011
        elseif (bossLevel == 14) then
            plotID = 1060011
        elseif (bossLevel == 15) then
            plotID = 1150003
        elseif (bossLevel == 16) then
            plotID = 1160001
        elseif (bossLevel == 17) then
            plotID = 1170001
        elseif (bossLevel == 18) then
            plotID = 1180001
        elseif (bossLevel == 19) then
            plotID = 1190001
        elseif (bossLevel == 20) then
            plotID = 1210001
        elseif (bossLevel == 21) then
            plotID = 1220001
        elseif (bossLevel == 22) then
            plotID = 1230001
        elseif (bossLevel == 23) then
            plotID = 1230004
        elseif (bossLevel == 24) then
            plotID = 1230007
        elseif (bossLevel == 25) then
            plotID = 1230010
        elseif (bossLevel == 26) then
            plotID = 1230013
        elseif (bossLevel == 27) then
            plotID = 1230016
        elseif (bossLevel == 28) then
            plotID = 1230019
        elseif (bossLevel == 29) then
            plotID = 1230022
        elseif (bossLevel == 30) then
            plotID = 1230025
        elseif (bossLevel == 31) then
            plotID = 1230028
        elseif (bossLevel == 32) then
            plotID = 1230031
        elseif (bossLevel == 33) then
            plotID = 1230034
        elseif (bossLevel == 34) then
            plotID = 1230037
        elseif (bossLevel == 35) then
            plotID = 1230040
        elseif (bossLevel == 36) then
            plotID = 1230043
        elseif (bossLevel == 37) then
            plotID = 1230046
        elseif (bossLevel == 38) then
            plotID = 1230049
        elseif (bossLevel == 39) then
            plotID = 1230052
        elseif (bossLevel == 40) then
            plotID = 1230055
        elseif (bossLevel == 41) then
            plotID = 1230058
        end
        
        if(plotID) then
            -- print("Machine:_controlBossBeginScenario  plotID=", plotID)
            PlotManager:getInstance():runPlotByID(plotID)
        end
    elseif (data.scenarioType == BOSS_SCENARIO_TYPE.ENDING) then

    end

    SceneManager:getInstance():setBossScenario(true)
    
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_BAG_PANEL)
    -- 停止角色移动
    self:_battleStopMove()
end

-- 处理BOSS结束剧
function Machine:_controlBossEndScenario(data)
    -- 处理结束剧情
    local _mapData = GameMapManager:getInstance():getMapData()
    local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
    local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(_mapData.level)
    Avalon.AudioManager:playMusicByConfig(_mapData.caveMode,level);
    
    if(data.scenarioType == BOSS_SCENARIO_TYPE.OPENING) then
        local bossLevel = self._model:getMapData().number
        local plotID = nil
        if(bossLevel == 1) then
            plotID = 1010012
        elseif (bossLevel == 2) then
            plotID = 1020012
        elseif (bossLevel == 3) then
            if(SceneManager:getInstance():isInDream()) then
                plotID = 1130012
            else 
                plotID = 1030012
            end
        elseif (bossLevel == 4) then
            plotID = 1040012
        elseif (bossLevel == 5) then
            plotID = 1050012
        elseif (bossLevel == 7) then
            plotID = 1060012
        elseif (bossLevel == 8) then
            plotID = 1070002
        elseif (bossLevel == 10) then
            plotID = 1100012
        elseif (bossLevel == 13) then
            plotID = 1050012
        elseif (bossLevel == 14) then
            plotID = 1060012
        elseif (bossLevel == 15) then
            plotID = 1150004
        elseif (bossLevel == 16) then
            -- body
            plotID = 1160002
        elseif (bossLevel == 19) then
            plotID = 1190002
        elseif (bossLevel == 20) then
            plotID = 1210002
        elseif (bossLevel == 21) then
            plotID = 1220002
        elseif (bossLevel == 22) then
            plotID = 1230002
        elseif (bossLevel == 23) then
            plotID = 1230005
        elseif (bossLevel == 24) then
            plotID = 1230008
        elseif (bossLevel == 25) then
            plotID = 1230011
        elseif (bossLevel == 26) then
            plotID = 1230014
        elseif (bossLevel == 27) then
            plotID = 1230017
        elseif (bossLevel == 28) then
            plotID = 1230020
        elseif (bossLevel == 29) then
            plotID = 1230023
        elseif (bossLevel == 30) then
            plotID = 1230026
        elseif (bossLevel == 31) then
            plotID = 1230029
        elseif (bossLevel == 32) then
            plotID = 1230032
        elseif (bossLevel == 33) then
            plotID = 1230035
        elseif (bossLevel == 34) then
            plotID = 1230038
        elseif (bossLevel == 35) then
            plotID = 1230041
        elseif (bossLevel == 36) then
            plotID = 1230044
        elseif (bossLevel == 37) then
            plotID = 1230047
        elseif (bossLevel == 38) then
            plotID = 1230050
        elseif (bossLevel == 39) then
            plotID = 1230053
        elseif (bossLevel == 40) then
            plotID = 1230056
        elseif (bossLevel == 41) then
            plotID = 1230059
        end
        if(plotID) then
            PlotManager:getInstance():runPlotByID(plotID)
        end
    elseif (data.scenarioType == BOSS_SCENARIO_TYPE.ENDING) then

    end

    SceneManager:getInstance():setBossScenario(false)

    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)

    local master = self._model:getMaster()
    if(master) then
        local masterCoord = master:getCoord()

        local coord = {}
        coord.x = Avalon.MathUtil:getInt(masterCoord.x)
        coord.y = Avalon.MathUtil:getInt(masterCoord.y)

        self:_fsmIdle(master, coord, true)
    end
end

function Machine:_controlGoldTouchedRefresh(data)
    local goldTouchedModel = self._model:getGoldTouched()
    if(goldTouchedModel) then
        goldTouchedModel:trigger()

        -- 触发逻辑
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_OPEN_NPC, goldTouchedModel:getData())

        -- 发送触发点金台
        local openItCommand = Command.RendererCommand:create()
        openItCommand:initOpenItCommand(goldTouchedModel:getId(), false)
        SceneManager:getInstance():pushCommand(openItCommand)
    else
        printError("Machine:_controlGoldTouchedRefresh")
    end
end

-- 开始使用道具
function Machine:_controlBeginUseItem(data)
    -- 开始使用道具
    local goodsData = GoodsDataManager:createLocalGoodsData(data.templateID)
    if(goodsData) then
        if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM and goodsData:getItemType() == ITEM_TYPE.EscapeScroll then
            -- 给目标玩家添加一个回城效果
            local targetRole = self._model:getRoleBySpriteID(data.targetSpriteID)
            if(targetRole) then
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initUpdateAnimationCommand(targetRole:getId(), CommandAnimationType.BACK_TOWN)
                SceneManager:getInstance():pushCommand(renderCommand)
            end
        else
            printError(string.format("Machine:_controlBeginUseItem templateID=%d not handle.",data.templateID))
        end
    end
end

function Machine:_controlDungeonUnlockTransdoor(data)
    -- 处理大秘境解锁提示
    if SceneManager:getInstance():isInDungeon() then
        -- 添加系统抖动
        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, 4)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(1230044))
    end
end

--[[
    plotRoleType:角色类型  详见  PlotRoleType 的定义
    plotAnimationType: 动画类型 详见  PlotAnimationType 定义
]]
function Machine:_plotRoleRunAnimation(plotRoleType, plotAnimationType)
    local roleArr = {}
    if(plotRoleType == PlotRoleType.BigBoss) then
        -- local bossMode = self._model:getBoss()
        local bossMode = self._model:getBossAll()

        for k,v in pairs(bossMode) do
            table.insert(roleArr, v)
        end
        -- if(bossMode) then
        --     table.insert(roleArr, bossMode)
        -- end
    else
        printError(string.format("[ERROR] have plotRoleType=%d plot no handle.", plotRoleType))
    end

    if(#roleArr) then
        for _, target in pairs(roleArr) do
            if (plotAnimationType  == PlotAnimationType.Birth ) then
                local rendererCommand = Command.RendererCommand:create(true)
                rendererCommand:initUpdateAnimationCommand(target:getId(), CommandAnimationType.APPEAR, 1.0)
                SceneManager:getInstance():pushCommand(rendererCommand)
            elseif (plotAnimationType  == PlotAnimationType.Idle ) then
                local rendererCommand = Command.RendererCommand:create(true)
                rendererCommand:initUpdateAnimationCommand(target:getId(), CommandAnimationType.IDLE, 1.0)
                SceneManager:getInstance():pushCommand(rendererCommand)
            else
                printError(string.format("[ERROR] have plotAnimationType=%s plot no handle.",plotAnimationType))
            end
        end
    end
end

function Machine:_fsmEnterBattle(target,attackTarget,targetSpriteID,skillID,skillState,isEnter)
    if(target == nil) then 
        return 
    end

    local isMe = target == self._model:getMaster()

    if SceneManager:getInstance():isDistortedSpaceCave()
        and (not MasterDataManager:isLittleBossInfoFull()) 
        and MasterDataManager._curCaveBossInfoCache and attackTarget 
        and MasterDataManager._curCaveBossInfoCache.spriteID == attackTarget._spriteID
    then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, 100321)
        return
    end

    if(target.getIsWake and target:getIsWake() == false) then 

        print("Machine:_fsmEnterBattle  must be iswake!")
        return 
    end

    local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if ((not battleStateAction) 
        or (battleStateAction:getFSMState() ~= FSMState.BATTLE)
        or (battleStateAction:getFSMState() == FSMState.BATTLE and battleStateAction:isEndBattle())) then
        
        -- 处理如果当前角色状态为战斗，后面在想执行战斗action 无法切换成功
        if(battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE and battleStateAction:isEndBattle()) then 
            if(target:getState() == FSMState.BATTLE) then 
                target:switchState(FSMState.IDLE)
            end
        end

        if (target:getType() == RoleType.Hero) then
            if (isMe) then
                battleStateAction = Action.BattleStateActionForHero:create(true, attackTarget)
                battleStateAction:init(target)
            else
                battleStateAction = Action.BattleStateActionForOtherHero:create(true, attackTarget)
                battleStateAction:init(target)
            end
        elseif ( target:getType() == RoleType.Pet) then
            battleStateAction = Action.BattleStateActionForHero:create(true, attackTarget)
            battleStateAction:init(target)
        elseif (target:getType() == RoleType.Monster) then
            battleStateAction = Action.BattleStateActionForMonster:create(true, attackTarget)
            battleStateAction:init(target)
            self:_removeDeformation(target, true)
            
            if(target:isBigBoss()) then
                local bossLevel = self._model:getMapData().number
                if(bossLevel == 8) then 
                    ToolsUtil:triggerHandleMap8Moon(true, true)
                elseif(bossLevel == 15) then 
                    ToolsUtil:triggerHandleMap15Moon(true, true)
                end
            end
        else
            printError("[ERROR] BattleMachine onExecuteFSMCommand: no battle type found.")
            return 
        end
        self:setAction(battleStateAction)
        self:addIdleAction(target,nil)
        if not targetSpriteID and attackTarget then
            targetSpriteID = attackTarget:getSpriteID()
        end
        self._model:addBattleFieldRole(target,targetSpriteID,isEnter)
        if attackTarget then
            self._model:addBattleFieldRole(attackTarget,target:getSpriteID(),isEnter)
        end
    end

    -- 使用技能
    if (skillID and skillID ~= 0) then
        battleStateAction:useSkill(skillID, attackTarget,skillState)
    -- 没有技能，进入普通攻击
    else
        if (isMe) then
            battleStateAction:attack(attackTarget)
        elseif ( target:getType() == RoleType.Pet) then
            battleStateAction:attack(attackTarget)
        end
    end
end

function Machine:_fsmSwitchBattle(target,attackTarget,targetSpriteID,skillID,skillState,isSwitch)
    if(target == nil) then 
        return 
    end

    local isMe = target == self._model:getMaster()

    -- if SceneManager:getInstance():isDistortedSpaceCave()
    --     and (not MasterDataManager:isLittleBossInfoFull()) 
    --     and MasterDataManager._curCaveBossInfoCache and attackTarget 
    --     and MasterDataManager._curCaveBossInfoCache.spriteID == attackTarget._spriteID
    -- then
    --     Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_NPC_DIALOG, 100321)
    --     return
    -- end

    if(target.getIsWake and target:getIsWake() == false) then 

        print("Machine:_fsmSwitchBattle  must be iswake!")
        return 
    end
    -- local roleData = target:getRoleData()
    -- if (target:getCategory() == Category.ROLE and target:getType() == RoleType.Hero and roleData:isMasterHero()) then
    --     print("_fsmSwitchBattleremoveBattleFieldRole")
    --     self._model:removeBattleFieldRole(target)
    -- end
    
    local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if ((not battleStateAction) 
        or (battleStateAction:getFSMState() ~= FSMState.BATTLE)
        or (battleStateAction:getFSMState() == FSMState.BATTLE and battleStateAction:isEndBattle())) then
        
        -- 处理如果当前角色状态为战斗，后面在想执行战斗action 无法切换成功
        if(battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE and battleStateAction:isEndBattle()) then 
            if(target:getState() == FSMState.BATTLE) then 
                target:switchState(FSMState.IDLE)
            end
        end

        if (target:getType() == RoleType.Hero) then
            if (isMe) then
                battleStateAction = Action.BattleStateActionForHero:create(true, attackTarget)
                battleStateAction:init(target)
            else
                battleStateAction = Action.BattleStateActionForOtherHero:create(true, attackTarget)
                battleStateAction:init(target)
            end
        elseif ( target:getType() == RoleType.Pet) then
            battleStateAction = Action.BattleStateActionForHero:create(true, attackTarget)
            battleStateAction:init(target)
        elseif (target:getType() == RoleType.Monster) then
            battleStateAction = Action.BattleStateActionForMonster:create(true, attackTarget)
            battleStateAction:init(target)
            self:_removeDeformation(target, true)
            
            if(target:isBigBoss()) then
                local bossLevel = self._model:getMapData().number
                if(bossLevel == 8) then 
                    ToolsUtil:triggerHandleMap8Moon(true, true)
                elseif(bossLevel == 15) then 
                    ToolsUtil:triggerHandleMap15Moon(true, true)
                end
            end
        else
            printError("[ERROR] BattleMachine onExecuteFSMCommand: no battle type found.")
            return 
        end
        self:setAction(battleStateAction)
        self:addIdleAction(target,nil)
        if not targetSpriteID and attackTarget then
            targetSpriteID = attackTarget:getSpriteID()
        end
        self._model:addBattleFieldRole(target,targetSpriteID,true)
        if attackTarget then
            self._model:addBattleFieldRole(attackTarget,target:getSpriteID(),true)
        end
    end

    if isSwitch then
        
        self:addIdleAction(target,nil)
        if not targetSpriteID and attackTarget then
            targetSpriteID = attackTarget:getSpriteID()
        end
        self._model:addBattleFieldRole(target,targetSpriteID,true, isSwitch)
        if attackTarget then
            self._model:addBattleFieldRole(attackTarget,target:getSpriteID(),true, isSwitch)
        end
    end

    -- 使用技能
    if (skillID and skillID ~= 0) then
        battleStateAction:useSkill(skillID, attackTarget,skillState)
    -- 没有技能，进入普通攻击
    else
        if (isMe) then
            battleStateAction:attack(attackTarget)
        elseif ( target:getType() == RoleType.Pet) then
            battleStateAction:attack(attackTarget)
        end
    end
end

function Machine:_fsmBattleEscape(target)
    local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if (battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE and target:getIsDead() == false) then
        battleStateAction:runAway()
        local pets = target.getFightPet ~= nil and target:getFightPet() or nil
        if pets then
            for _, pet in pairs(pets) do
                if pet then
                    local petbattleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, pet:getId())
                    if petbattleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE and target:getIsDead() == false and petbattleStateAction.runAway then
                        petbattleStateAction:runAway()
                    end
                end
            end
            
        end
        
    else
        local roleData = target:getRoleData()
        local pk = -1
        if(roleData) then 
            pk = roleData:getPK()
        end
        
        if(battleStateAction == nil) then
            print("battleStateAction is nil.  target pk=", pk)
        elseif (battleStateAction:getFSMState() ~= FSMState.BATTLE) then 
            print("FSMState is error.  target pk, fsmState=", pk, battleStateAction:getFSMState())
        elseif (target:getIsDead()) then 
            print("target is dead.  target pk, fsmState=", pk, battleStateAction:getFSMState())
        end

        printError("Machine:_fsmBattleEscape  no handle escape.")
    end
end

function Machine:_fsmBattleCancelEscape(target)
    local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if (battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE and target:getIsDead() == false) then
        battleStateAction:runAwayCancel()
        local pets = target.getFightPet ~= nil and target:getFightPet() or nil
        for _, pet in pairs(pets) do
            if pet then
                local petbattleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, pet:getId())
                if petbattleStateAction and petbattleStateAction.runAwayCancel then
                    petbattleStateAction:runAwayCancel()
                end
            end
        end
        
    else
        local pk = target:getPK()
        if(battleStateAction == nil) then
            print("battleStateAction is nil.  target pk=", pk)
        elseif (battleStateAction:getFSMState() ~= FSMState.BATTLE) then 
            print("FSMState is error.  target pk, fsmState=", pk, battleStateAction:getFSMState())
        elseif (target:getIsDead()) then 
            print("target is dead.  target pk, fsmState=", pk, battleStateAction:getFSMState())
        end

        printError("Machine:_fsmBattleCancelEscape  no handle CancelEscape.")
    end
end

--isCanRevive：是否可以复活
function Machine:_fsmPetDie(target)
    if target == nil then
        return
    end
    local showRevive = false
    local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if (battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE) then
        if (not battleStateAction:isEndBattle()) then
            showRevive = true
        end
    end

    self:_fsmDeadAction(target)
    target:setIsDead(true)
    GameManager:notifyRoleFSMChange(target:getData())
    
    local renderCommand = Command.RendererCommand:create(true)
    renderCommand:initDeadCommand(target:getId())
    self:pushCommand(renderCommand)

    Avalon.MessageCenter:notice(AvalonMessage.MC_PET_DEAD, target:getSpriteID())
end


function Machine:_fsmDie(target, recoverDead, showRevive, murdererSpriteID, groupMonsterId, isGroupMonsterDeadAll, everyGroupMonsterId)
    if(target) then
        target:setIsDead(true)
    end
    local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if (battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE) then
        if(battleStateAction:isEndBattle()) then
            showRevive = true
        end
        -- 停止战斗
        battleStateAction:die()
        if(target and target:isMaster()) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_MASTER_DIED_IN_BATTLE, battleStateAction:getAttackTarget())
        end
    else
        showRevive = true
        if(battleStateAction and battleStateAction:getFSMState() == FSMState.MOVE) then
            battleStateAction:stop()
        end
    end

    if(target) then
        if(showRevive) then
            -- 添加死亡 ACTION
            self:_fsmDeadAction(target)
        end

        local hitratMonsterRefresh = false
        if SceneManager:getInstance():isInHitRat() then
            if murdererSpriteID == RoleDataManager:getMasterSpriteID() then
                -- 处理发送伤害数值
                local mesData = {}
                mesData.attrChange = {}
                local oneData = {}
                local val = mvc.hitRatModel:getRatAddScore(target:getMonsterID())
                oneData.value = val
                oneData.type = val >0 and 1 or 2

                oneData.reason = CLIENT_ATTR_CHANGE_REASON.HIT_RAT_SCORE_CHANGED
                table.insert(mesData.attrChange,oneData)

                local direction = target:getDirection()
                local renderCommand = Command.RendererCommand:create(true)
                renderCommand:initUpdateAttrCommand(target:getId(), mesData, direction)
                self:pushCommand(renderCommand)
            end
            if murdererSpriteID == 0 then
                hitratMonsterRefresh = true
            end
        end

        local isRemoveSelf = false
        if groupMonsterId and groupMonsterId > 0 and not isGroupMonsterDeadAll then
            isRemoveSelf = true
        end

        local renderCommand = Command.RendererCommand:create(true)
        renderCommand:initDeadCommand(target:getId(), recoverDead, showRevive, hitratMonsterRefresh, isRemoveSelf)
        self:pushCommand(renderCommand)
        -- self._view:executeCommand(renderCommand)

        if(target:isMaster()) then
            if(SceneManager:getInstance():isGuildBoss()) then 
                GameDataManager:getInstance():setGuildBossBackTownTimeOut(true)
            end
            Avalon.AudioManager:pauseMusic()

            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_MASTER_DEAD)
        end

        target:setIsDead(true)

        GameManager:notifyRoleFSMChange(target:getData())

        local category = target:getCategory()
        local type = target:getType()
        if category == Category.ROLE then
            if type == RoleType.Hero then
                -- 判断是否是初始化死亡
                if(target:isMaster()) then
                    -- 死亡后关闭背包界面
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_BAG_PANEL)
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_BAG_BUTTON)
                end
            elseif type == RoleType.Monster then
                -- 判断是否为boss
                if(target:isBigBoss()) then
                    local SdkManager = require"app.game.SdkManager"
                    SdkManager:checkCommentEvent(COMMENT_TYPE.KILL_BOSS)
                    -- boss 死了停止背景音乐 CO-2178
                    Avalon.AudioManager:stopMusic()

                    local bossLevel = self._model:getMapData().number
                    if (bossLevel == 8) then
                        PlotManager:getInstance():runPlotByID(1070005)

                        if(target:getIsDead()) then
                            ToolsUtil:triggerHandleMap8Moon(false, false)
                        else 
                            ToolsUtil:triggerHandleMap8Moon(false, true)
                        end
                    elseif (bossLevel == 15) then
                        if(target:getIsDead()) then
                            ToolsUtil:triggerHandleMap15Moon(false, false)
                        else 
                            ToolsUtil:triggerHandleMap15Moon(false, true)
                        end
                    end
                end

                -- 判断是否和主角同一场战斗
                if(self._model:judgeInSameBattleField(target:getSpriteID(),  RoleDataManager:getMasterSpriteID())) then 
                    Avalon.MessageCenter:notice(GameMessage.MC_ROLE_KILL_MONSTER, target:getMonsterID())
                end

                
                if (target._fsm and target._fsm._dataModel and target._fsm._dataModel.bossCallMonsterFlag == 2) then
                    -- 这里特殊处理, 只要是召唤出来的怪物,死亡直接移除
                    self._model:removeBattleFieldRole(target)
                    MachineManager:getInstance():pushRemoveModelCommand(target:getId(), false)
                elseif groupMonsterId and groupMonsterId > 0 and isGroupMonsterDeadAll then
                    for k, v in pairs(everyGroupMonsterId) do
                        local role = self._model:getRoleBySpriteID(v)
                        if role then
                            local render = self._view:getRenderer(role:getId())
                            if render ~= nil and render._triggerRemoveSelf and v ~= target:getSpriteID() then
                                render:_triggerRemoveSelf()
                            end

                            self._model:removeBattleFieldRole(role)
                            MachineManager:getInstance():pushRemoveModelCommand(role:getId(), false)
                        end
                    end
                elseif groupMonsterId and groupMonsterId > 0 and not isGroupMonsterDeadAll then

                else
                    self._model:removeBattleFieldRole(target)
                    MachineManager:getInstance():pushRemoveModelCommand(target:getId(), false)

                    -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_GROUP_MONSTER_DEAD_AND_CLEAR_DATA, target:getSpriteID())
                end
                
            end
        else  --TODO  这里需要根据类型判定是否要移除
            MachineManager:getInstance():pushRemoveModelCommand(target:getId(), false)
        end
    end
    -- TODO 移除在逻辑上面保存的对象

    -- -- TODO 这里可以去掉该移除操作
    -- self._model:removeRoleFromMap(target)
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_GAME_MODEL, target:getData())
    -- self._model:removeBattleFieldRole(target)
end

function Machine:_fsmDeadAction(target)
    local deadStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
    if (not ((not deadStateAction) or (deadStateAction:getFSMState() ~= FSMState.DIE))) then
       
    else
        local action = Action.DeadStateAction:create(true)
        action:init(target)
        self:setAction(action)
    end
end

function Machine:_fsmRevive(target)
    if target:getType() == RoleType.Pet then
        local battleStateAction = self._actionTrack:getFisrtAction(TRACKS_INDEX.FSM, target:getId())
        if battleStateAction and battleStateAction:getFSMState() == FSMState.BATTLE then
            battleStateAction:stopBattle()
        end
    end
    local action = Action.ReviveStateAction:create(true)
    action:init(target)
    self:setAction(action)
end

--触发怪物
function Machine:_triggerMonster(data)
    local spriteID = data.spriteID
    local target = self._model:getRoleBySpriteID(spriteID)
    if target then
        target:setTriggerNum(data.triggerNum)
        -- print("Machine:_triggerMonster 1", target:getMonsterSubType(), target:getIsPet())
        if (target:getMonsterSubType() == MonsterSubType.Trigger 
            or target:getMonsterSubType() == MonsterSubType.Treasure
            or target:getIsPet()) then
            -- print("Machine:_triggerMonster 2", target:getMonsterSubType(), target:getIsPet())
            local rendererCmd = Command.RendererCommand:create(true)
            rendererCmd:initTriggerMonster(target:getId())
            self._view:executeCommand(rendererCmd)
        end
    end
end

function Machine:_showMiniMapIcon(data)
    local mapData = self._model:getMapData()
    if(mapData) then
        if(data.isShow) then
            for k,v in pairs(data.coords) do 
                mapData:addShowMiniMapIconCoord(v.x, v.y)
            end
        else
            for k,v in pairs(data.coords) do 
                mapData:removeShowMiniMapIconCoord(v.x, v.y)
            end
        end

        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_SHOW_ICON, data.isShow, data.coords)
    end
end

function Machine:_showISeeDeadPeople()
    local mapData = self._model:getMapData()
    if(mapData) then
        mapData.ISeeDeadPeople = true
    end
end

--移除除自己外的所有角色（人物和宠物）
function Machine:_controlRemoveAllOtherScreenRole()
    local list =  RoleDataManager:getAllOtherRole()
    for k, heroData in ipairs(list) do
        local spriteID = heroData:getSpriteID()
        GameDataManager:getInstance():clearHeroDataForPK(heroData:getPK())
        if(DEBUG) then
            print("ROLE_REMOVE_SCREEN_ROLE pk=", heroData:getPK())
        end
        local role = self._model:getRoleBySpriteID(spriteID)

        -- 这里过滤，只处理玩家和怪物
        if role then
            if(role:getAddNum() > 1) then
                role:reduceAddNum()
            end 
            --停止所有的效果
            self._actionTrack:clearActionForEntryId(role:getId())
            -- 移除所有buffer
            self:_clearAllBufferForRole(role)

            local category = role:getCategory()
            local type = role:getType()

            local roleData = role:getData()
            if category == Category.ROLE then
                if type == RoleType.Hero then
                    self._view:removeView(role)
                    self._model:removeRole(role)
                    local pet = role:getFightPet()
                    if pet then
                        self._actionTrack:clearActionForEntryId(pet:getId())
                        self:_clearAllBufferForRole(pet)
                        self._view:removeView(pet)
                        self._model:removeRole(pet)
                    end
                end
            end
        end
    end
end

function Machine:_controlChangeSummonedBossState(data)
    -- print("_controlChangeSummonedBossStatesss")
    -- dump(data, "_controlChangeSummonedBossStateaa")
    local targetSpriteID = nil
    local targetList = {}
    local hero = self._model:getMaster()
    -- 获取攻击对象
    local battleField = self._model:getBattleFieldBySpriteID(self._model:getMaster():getSpriteID(),nil)
    if battleField then
        local monster = battleField:getTargetMonster()
        if monster then
            targetSpriteID = monster:getSpriteID()
        end
    else
        return
    end

    local target = self._model:getRoleBySpriteID(targetSpriteID)
    if target then
        if data.monsterid and table.nums(data.monsterid) > 0 then
            if not data.isDisappear then
                table.insert(targetList, target)
            end
            
            for k, v in pairs(data.monsterid) do
                local groupTarget = self._model:getRoleBySpriteID(v)
                if groupTarget then
                    table.insert(targetList, groupTarget)
                end
            end
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_CHANGE_MONSTER_PANNEL, target:getData(), hero:getSpriteID(), targetList)
    end
    
end

function Machine:_getAllSummonedMonsters()
    local targetList = {}
    local allMonster = self._model:getAllMonsterModel()
    for k,monsterModel in ipairs(allMonster) do 
        if monsterModel and monsterModel:getData() and monsterModel:getData().bossCallMonsterFlag > 0 then
            table.insert(targetList, monsterModel)
        end
    end
    return targetList
end

function Machine:_triggerMonsterEvo(spriteID, evoParts)
    local monster = self._model:getRoleBySpriteID(spriteID)
    -- local target = self._model:getRoleBySpriteID(spriteID)
    local renderer = self._view:getRenderer(monster:getId())
    if renderer then
        renderer:showEvolution(evoParts)
    end
end
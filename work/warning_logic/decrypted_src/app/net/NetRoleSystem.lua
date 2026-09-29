--[[
    角色相关的网络消息处理
]]--

require "utils.MathUtil"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local MachineManager = require("app.game.MachineManager")
local LanguageManager = require("app.game.LanguageManager")
local WeatherManager = require("app.game.WeatherManager")
Net = Net or {}
local NetRoleSystem = {}
Net.NetRoleSystem = NetRoleSystem

local ProtobufUtil = require("utils.ProtobufUtil")

local PACKET_TYPE = PublicDefine.PACKET_TYPE
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
local PACKET_SUB_TYPE = PublicDefine.PACKET_SUB_TYPE

local Manager = Game.Manager
local DEBUG = false
-- 请求日常活跃度数据
function NetRoleSystem:requestActivityPointInfo(stat)
    if DEBUG then
        print ("[Net.NetRoleSystem] requestActivityPointInfo ", stat)
    end

    local messageData = {}
    messageData.stat = stat
    
    Net.Helper:sendMessage(NetMessageType.ROLE_DAILY_ACTION_REWARD_REQUEST, messageData)
end

-- 请求目标奖励
function NetRoleSystem:requestGoalReward(targetID, stage, sudId)
    if DEBUG then
        print ("[Net.NetRoleSystem] requestGoalReward ", targetID, stage, sudId)
    end

    local messageData = {}
    messageData.targetID = targetID
    messageData.stage = stage
    messageData.sudId = sudId
    
    Net.Helper:sendMessage(NetMessageType.ROLE_TARGET_GET_REWARD, messageData)
end

-- 请求签到
function NetRoleSystem:requestSignIn(targetID, stage, sudId)
    if DEBUG then
        print ("[Net.NetRoleSystem] requestSignIn ", targetID, stage, sudId)
    end

    local messageData = {}
    messageData.targetID = targetID
    messageData.stage = stage
    messageData.sudId = sudId
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_TARGET_SIGN_IN, messageData)
end

-- 请求礼物
-- giftID: 礼物ID
function NetRoleSystem:giftRequst(giftID)
    if DEBUG then
        print ("[Net.NetRoleSystem] giftRequst giftID=",giftID)
    end

    local messageData = {}
    messageData.giftID = giftID

    Net.Helper:sendMessage(NetMessageType.ROLE_REQUEST_GIFT, messageData)
end

-- 请求修改昵称
function NetRoleSystem:heroEditNickNameRequest(pk, nickName)
    if DEBUG then
        print ("[Net.NetRoleSystem] heroEditNickNameRequest pk,nickName=",pk, nickName)
    end

    local messageData = {}
    messageData.pk = pk
    messageData.nickName = nickName

    Net.Helper:sendMessage(NetMessageType.ROLE_EDIT_NICK_NAME, messageData)
end
-- 请求更新实名认证状态
function NetRoleSystem:reqUpdateAdultType(t)
    local messageData = {}
    messageData.adultType = t
    Net.Helper:sendMessage(NetMessageType.REQ_UPDATE_ADULT_TYPE, messageData)
end

function NetRoleSystem:reqHorcurxLvUp(type, count)
    local enum = {
        "HorcuxUpLvType_Normal",
        "HorcuxUpLvType_Senior",
        "HorcuxUpLvType_Upgrad",
    }

    local messageData = {}
    messageData.type = enum[type]

    if (type == 3) then
        messageData.count = count
    end
    print("reqHorcurxLvUp  messageData ========== ",messageData)
    Net.Helper:sendMessage(NetMessageType.ROLE_HORCURX_LV_UP_REQ, messageData)
end


function NetRoleSystem:reqHorcurxEvolutionUp()
    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.ROLE_HORCURX_EVOLUTION_REQ, messageData)
end

function NetRoleSystem:reqSetHorcurxIllusion(id)
    local messageData = {}
    messageData.exteriorID = id
    Net.Helper:sendMessage(NetMessageType.ROLE_HORCURX_SET_EXTERIOR_REQ, messageData)
end

function NetRoleSystem:reqCancleConstrait()
    Net.Helper:sendMessage(NetMessageType.ROLE_CANCLE_CONSTRAINT_REQUEST)
end

--[[
    请求玩家详情
    pk:
    fromType: 0, nil 普通  1 排行榜  
]]
function NetRoleSystem:heroDetailRequest(pk, fromType, userID, targetUserID, rankType, preWeekRank, isShowImmediately)
    local timeStamp = GameManager:getNowServerTimestamp()

    if DEBUG then
        print ("[Net.NetRoleSystem] heroDetailRequest pk,timeStamp=",pk, fromType, userID, targetUserID,AvalonUtil:getCurrentTime(), preWeekRank)
    end

    local messageData = {}
    messageData.pk = pk
    if(userID) then
        messageData.userID = userID
    end
    if(targetUserID) then
        messageData.targetUserID = targetUserID
    end
    messageData.subType = rankType

    if(preWeekRank) then 
        messageData.preWeekRank = preWeekRank
    end

    if (isShowImmediately ~= nil) then
        messageData.isShowImmediately = isShowImmediately
    end

    -- 过滤上周排行榜的玩家详情
    if(messageData.subType == PublicDefine.RankType.RankType_Dream and messageData.preWeekRank == true) then 
        local detailData = MasterDataManager:getPreDreamRankDetailDataForPK(messageData.pk)
        if(detailData) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_SHOW_ROLE_INFO, detailData)
            return
        end
    end
    
    if( fromType == nil or fromType == 0) then
        Net.Helper:sendMessage(NetMessageType.ROLE_REQUEST_HERO_DETAIL, messageData)
    elseif fromType == 1 then
        Net.Helper:sendMessage(NetMessageType.ROLE_REQUEST_HERO_DETAIL_FROM_RANK, messageData)
    end
end

-- 玩家移动
function NetRoleSystem:heroStartMoveRequest(coordX,coordY,direction)
    if(SceneManager:getInstance():isInLostRealm()) then 
        return 
    end
    if(not RoleBehaviorManager:moveCheck()) then 
        return false
    end

    local timeStamp = GameManager:getNowServerTimestamp()

    if DEBUG then
        print ("[Net.NetRoleSystem] heroStartMoveRequest coordX,coordY,direction,timeStamp",coordX,coordY,direction,timeStamp,AvalonUtil:getCurrentTime())
    end
    if coordX and coordX >= 0 and coordY and coordY >= 0 and direction then
        local messageData = {}

        messageData.timeStamp = timeStamp 
        messageData.coordX = Avalon.MathUtil:getInt(coordX)
        messageData.coordY = Avalon.MathUtil:getInt(coordY)
        messageData.direction = direction

        Net.Helper:sendMessage(NetMessageType.ROLE_HERO_START_MOVE, messageData)

        if SceneManager:getInstance():isInBigCrack() then
            mvc.send(mvc.events.COLLECT_START, nil, true)
        end

        --开始移动时  关闭钓鱼界面
        local GameInManorManager = require "app.game.GameInManorManager"
        GameInManorManager:getInstance():closeFishingView()
    end
end

-- 玩家停止移动
function NetRoleSystem:heroStopMoveRequest(coordX,coordY)
    if(SceneManager:getInstance():isInLostRealm()) then 
        return 
    end
    local timeStamp = GameManager:getNowServerTimestamp()
    if DEBUG then
        print ("[Net.NetRoleSystem] heroStopMoveRequest coordX,coordY,timeStamp",coordX,coordY,timeStamp,AvalonUtil:getCurrentTime())
    end

    if coordX and coordX >= 0 and coordY and coordY >= 0  then
        local messageData = {}
        messageData.timeStamp = timeStamp 
        messageData.coordX = coordX
        messageData.coordY = coordY

        Net.Helper:sendMessage(NetMessageType.ROLE_HERO_STOP_MOVE, messageData)
    end
end

-- CS 英雄进入战斗
function NetRoleSystem:heroStartBattleRequest(targetSpriteID)
    if DEBUG then
        -- Avalon.Log:debug(string.format("[Net.NetRoleSystem] heroStartBattleRequest targetSpriteID=%d  currentTime=%d", targetSpriteID, AvalonUtil:getCurrentTime()))
        print ("[Net.NetRoleSystem] heroStartBattleRequest targetSpriteID", targetSpriteID, AvalonUtil:getCurrentTime())
    end
    -- TODO 测试打击体感表现
    self._triggerBattleRequest = true
    self._triggerBattleTime = AvalonUtil:getCurrentTime()

    if targetSpriteID then
        local messageData = {}
        messageData.targetSpriteID = targetSpriteID

        Net.Helper:sendMessage(NetMessageType.ROLE_HERO_START_BATTLE, messageData)
    end
end

 -- CS 英雄使用技能（包括普通技能）,这里设计为在开始战斗使用普攻技能，技能，在次使用普攻技能，三种情况才触发。
function NetRoleSystem:heroUseSkillRequest(skillID,targetSpriteID,coordX,coordY, skillGroupID)
    if DEBUG then
        print ("[Net.NetRoleSystem] heroUseSkillRequest skillID,targetSpriteID,clientServerTime=",skillID,targetSpriteID,coordX,coordY,GameManager:getNowServerTimestamp())
    end
    if skillID then
        local messageData = {}
        messageData.skillID = skillID
        if targetSpriteID then
            messageData.targetSpriteID = targetSpriteID
        end
        if coordX then
            messageData.coordX = coordX
        end

        if coordY then
            messageData.coordY = coordY
        end

        -- if skillGroupID then
        --     messageData.skillGroup = skillGroupID
        -- end
        Net.Helper:sendMessage(NetMessageType.ROLE_HERO_USE_SKILL, messageData)
    end
end

-- CS 英雄逃跑
function NetRoleSystem:heroEscapeRequest()
    if DEBUG then
        print ("[Net.NetRoleSystem] heroEscapeRequest")
    end

    Net.Helper:sendMessage(NetMessageType.ROLE_HERO_ESCAPE, nil)
end

-- CS 英雄逃跑
function NetRoleSystem:heroSkillSelectReq(idx)
    local messageData = {}
    messageData.label = idx
    Net.Helper:sendMessage(NetMessageType.ROLE_SKILL_GROUNP_SELECT_REQ, messageData)
end
-- CS 进入洞穴
function NetRoleSystem:heroEnterCaveSceneRequest(mode,caveMode,difficulty,level,spriteID, useSchemeInHero, actID, dreamType,extraPara)
    if DEBUG then
        print ("[Net.NetRoleSystem] heroEnterCaveSceneRequest  mode,caveMode,difficulty,level=",mode,caveMode,difficulty,level)
    end
    local messageData = {}
    if difficulty then
        messageData.difficulty = difficulty
    else
        messageData.difficulty = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
    end
    if level then
        messageData.level = level
    else
        messageData.level = 1
    end
    messageData.useSchemeInHero = useSchemeInHero
    messageData.caveMode = caveMode or PublicDefine.CAVE_MODE.MODE_NORMAL
    messageData.mode = mode or PublicDefine.GAME_MODE.MODE_SOLO
    if(spriteID) then
        messageData.spriteID = spriteID
    else 
        messageData.spriteID = 0
    end
    if(actID) then 
        messageData.actID = actID
    else
        messageData.actID = 0
    end

    messageData.dreamType = dreamType

    messageData.extraPara = extraPara

    Net.Helper:sendMessage(NetMessageType.ROLE_ENTER_CAVE_SCENE, messageData)
end

-- 角色死亡取消复活
function NetRoleSystem:heroDeadSelectionRequest()
    if DEBUG then
        print ("[Net.NetRoleSystem] heroDeadSelectionRequest")
    end

    Net.Helper:sendMessage(NetMessageType.ROLE_DEAD_SELECTION)
end

-- 处理请求复活
function NetRoleSystem:heroReviveRequest(requestSpriteID, targetSpriteID, diamondNum)
    if DEBUG then
        print ("[Net.NetRoleSystem] heroReviveRequest  requestSpriteID, targetSpriteID=",requestSpriteID, targetSpriteID)
    end

    local messageData = {}
    messageData.spriteID = requestSpriteID
    messageData.targetSpriteID = targetSpriteID
    if(diamondNum) then 
        messageData.reviveDiamondNum = diamondNum
    end 

    Net.Helper:sendMessage(NetMessageType.ROLE_REQUEST_REVIVE_HERO, messageData)

    -- 新手引导复活
    if(SceneManager:getInstance():isInStory()) then 
        Avalon.MessageCenter:notice(AvalonMessage.MC_STORY_SHOW_HERO_REVIVE_DIALOG)
    end 
end

function NetRoleSystem:heroGiveUpSaveBackTown()
    if DEBUG then
        print ("[Net.NetRoleSystem] heroGiveUpSaveBackTown  ")
    end

    Net.Helper:sendMessage(NetMessageType.ROLE_GIVE_UP_SAVE_BACK_TOWN)
end

function NetRoleSystem:heroTestGoToLevel(level)
    if DEBUG then
        print ("[Net.NetRoleSystem] heroTestGoToLevel ")
    end
    local messageData = {}
    messageData.level = level 

    Net.Helper:sendMessage(NetMessageType.ROLE_TEST_GOTO_LEVEL, messageData)
end

function NetRoleSystem:heroUserFightSkillSet(weaponType, fightSkills)
    if DEBUG then
        print ("[Net.NetRoleSystem] HERO_FIGHT_SKILLS_REQ_SET_MESSAGE ")
    end
    local settings = SkillDataManager:getUserFightSkill(weaponType)
    local messageData = {}
    messageData.skillconf = {weaponType = weaponType, fightSkills = fightSkills} 
    Net.Helper:sendMessage(NetMessageType.HERO_FIGHT_SKILLS_REQ_SET_MESSAGE, messageData)
end

-- 发送对时请求
function NetRoleSystem:syncTimeRequest()
    local localTime = AvalonUtil.getCurrentTime()
    GameManager:setLocalRequestTimestamp(localTime)
    
    Net.Helper:sendMessage(NetMessageType.ROLE_SYNC_TIME_REQUEST, nil)
end


--发送学习技能请求
function NetRoleSystem:heroStudySkill(skillGroupID)
    local messageData = {}
    messageData.skillGroupID = skillGroupID 

    dump(messageData)

    Net.Helper:sendMessage(NetMessageType.ROLE_HERO_STUDY_SKILL, messageData)
end

--发送重置技能请求
function NetRoleSystem:heroResetStudySkill()

    Net.Helper:sendMessage(NetMessageType.ROLE_HERO_RESET_STUDY_SKILL, nil)
end

-- 发送位置信息
function NetRoleSystem:sendCoordSignal(spriteID)
    Net.Helper:sendMessage(NetMessageType.ROLE_SEND_COORD_SIGNAL, {
        spriteID = spriteID
    })
end

-- 处理跳过boss 剧情任务
function NetRoleSystem:skipScenarioRequest(scenarioType)
    -- print("NetRoleSystem:skipScenarioRequest")
    local messageData = {}
    messageData.scenarioType = scenarioType 
    
    Net.Helper:sendMessage(NetMessageType.ROLE_BOSS_SKIP_SCENARIO, scenarioType)
end


-- 触发怪物
function NetRoleSystem:triggerMonster(spriteID)
    -- print("NetRoleSystem:triggerMonster",spriteID)

    Net.Helper:sendMessage(NetMessageType.ROLE_TRIGGER_MONSTER,{
        spriteID = spriteID
    })
end

-- 快捷表情
function NetRoleSystem:sendExpression(expressionId)
    -- print("NetRoleSystem:sendExpression", expressionId)
    Net.Helper:sendMessage(NetMessageType.ROLE_SEND_EXPRESSION,{
        emoticonID = expressionId
    })
end


-- 设置请求隐藏头盔
function NetRoleSystem:requestHideHelmet(isHideHelmet)
    -- print("NetRoleSystem:requestHideHelmet", isHideHelmet)
    local messageData = {}
    messageData.pk = RoleDataManager:getMasterPK()
    messageData.isHideHelmet = isHideHelmet 
    Net.Helper:sendMessage(NetMessageType.ROLE_REQUEST_HIDE_HELMET,messageData)
end


-- 客户端分享消息
function NetRoleSystem:netShare(platform)
    -- print("NetRoleSystem:netShare")
    local messageData = {}
    messageData.type = platform
    Net.Helper:sendMessage(NetMessageType.ROLE_CLIENT_SHARE_MESSAGE,messageData)
    -- Net.Helper:sendMessage(NetMessageType.ROLE_CLIENT_SHARE_MESSAGE)
end

-- 客户端完成任务消息
function NetRoleSystem:finishTask(taskId)
    local messageData = {}
    messageData.taskId = taskId
    Net.Helper:sendMessage(NetMessageType.ROLE_CLIENT_FINISH_TASK_MESSAGE, messageData)
end


-- 客户端选择答题
function NetRoleSystem:requestFinishAnswers(questionID, answerId)
    local messageData = {}
    messageData.questionID = questionID
    messageData.answerId = answerId
    Net.Helper:sendMessage(NetMessageType.ROLE_CLIENT_REQUEST_ANSWER_MESSAGE, messageData)
end

-- CS 请求取消BUFF
function NetRoleSystem:requestRemoveBuff(buffID)
    local messageData = {}
    messageData.buffInstanceId = buffID
    Net.Helper:sendMessage(NetMessageType.ROLE_CLIENT_REQUEST_REMOVE_BUFF_MESSAGE, messageData)
end

-- 客户端分享消息
function NetRoleSystem:netStoryData(storyData)
    -- print("NetRoleSystem:netStoryData")
    local messageData = {}
    messageData.storyData = storyData
    Net.Helper:sendMessage(NetMessageType.ROLE_STORY_DATA_MESSAGE,messageData)
end

-- 触发怪物
function NetRoleSystem:recieveDungeonBatlleRewardRequest()
    -- print("NetRoleSystem:recieveDungeonBatlleRewardRequest")

    Net.Helper:sendMessage(NetMessageType.DUNGEON_REQUEST_BATTLE_REWARD)
end


-- 触发怪物
function NetRoleSystem:reqGetPayMoney()
    Net.Helper:sendMessage(NetMessageType.REQUEST_GET_PAY_MONEY_MESSAGE)
end


--获取大秘境赛季奖励
function NetRoleSystem:reqDungeonSeasonReward(npcId)
    -- print("NetRoleSystem:reqDungeonSeasonReward")
    Net.Helper:sendMessage(NetMessageType.RECIVE_DUNGEON_SEASON_REWARD_REQUEST, {NPCID = npcId})
end

-- 请求切换城镇渠道
function NetRoleSystem:requestChangeTownChannel(townChannelID)
    -- print("NetRoleSystem:requestChangeTownChannel", townChannelID)
    local requestData = {}
    requestData.townChannelID = townChannelID

    Net.Helper:sendMessage(NetMessageType.ROLE_REQUEST_CHANGE_TOWNCHANNEL, requestData)
end

-- 请求获取全量英雄模式  特殊事件
function NetRoleSystem:getAllHeroSpecialEventRequest()
    if DEBUG then
        print ("[Net.NetRoleSystem] getAllHeroSpecialEventRequest ")
    end
    Net.Helper:sendMessage(NetMessageType.ROLE_GETALL_HERO_SPECIAL_EVENT_REQUEST)
end


-- 请求刷新英雄模式  特殊事件
function NetRoleSystem:refreshHeroSpecialEventRequest(isAuto, caveMode)
    if DEBUG then
        print ("[Net.NetRoleSystem] refreshHeroSpecialEventRequest isAuto=", isAuto)
    end

    local messageData = {}
    if isAuto then
        messageData.refreshMode = PublicDefine.HeroCaveRefreshMode.HeroCaveRefreshMode_Automatic
    else
        messageData.refreshMode = PublicDefine.HeroCaveRefreshMode.HeroCaveRefreshMode_Manual
    end
    messageData.caveMode = caveMode

    Net.Helper:sendMessage(NetMessageType.ROLE_REFRESH_HERO_SPECIAL_EVENT_REQUEST, messageData)
end

-- 请求更改称号
function NetRoleSystem:requestChangeHeroTitle(titleID)
    if DEBUG then
        print("NetRoleSystem:requestChangeHeroTitle, 请求更改称号, ID为:", titleID)
    end

    local messageData = {
        titleID = titleID
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_HERO_CHANGE_TITLE_REQUEST, messageData)
end

-- 请求天赋加点
function NetRoleSystem:requestAddRoleTalent(talentId, addNum)
    if DEBUG then
        print("NetRoleSystem:requestAddRoleTalent, ID为:", talentId)
    end
    local messageData = {
        id = talentId,
        addNum = addNum
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_ADD_ROLE_TALENT_REQ, messageData)
end

-- 请求升级天赋
function NetRoleSystem:requestUpgradeRoleTalent(talentId)
    if DEBUG then
        print("NetRoleSystem:requestUpgradeRoleTalent, ID为:", talentId)
    end
    local messageData = {
        id = talentId
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_UPGRADE_ROLE_TALENT_REQ, messageData)
  
end

-- 发送拉取梦境数据
function NetRoleSystem:requestGetDreamInfo()
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_GET_DREAM_INFO, nil)
end

-- 发起刷新梦境当前关卡buf
function NetRoleSystem:requestRefreshDreamBuf(isFree, dreamType)  
    local messageData = {
        isFree = isFree,
        dreamType = dreamType,
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_REFRESH_DREAM_BUF, messageData)
end

-- 接取梦境任务
function NetRoleSystem:requestPickUpDreamTask(index)  
    local messageData = {
        index = index
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_PICKUP_DREAM_TASK, messageData)
end

-- 改变梦境等级
function NetRoleSystem:requestChangeDreamLv()  
    Net.Helper:sendMessage(NetMessageType.ROLE_CHANGE_DREAM_LV_REQUEST, nil)
end

-- 领取首通奖励
function NetRoleSystem:requestFirstPassReward(mode, diff, list)  
    local data = {}
    data.mode = mode
    data.diff = diff
    data.index = list
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_GET_FIRST_PASS_REWARD, data)
end

function NetRoleSystem:requestSwitchSkill(skillGroupId)  
    local skillGroupData = SkillDataManager:getSkillGroup(skillGroupId)
    local data = {}
    data.skillGID = skillGroupData.relatedSkills
    data.removeSkillGID = skillGroupId
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_SWITCH_SKILL, data)
end

function NetRoleSystem:reqUnlockShadowSkill(skillId) 
    local data = {}
    data.skillID = skillId
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_UNLOCK_SHADOW_SKILL, data)
end

function NetRoleSystem:reqViewADSResult(serPlace, transID) 
    local data = {}
    data.advertFuncType = serPlace
    data.transID = transID
    Net.Helper:sendMessage(NetMessageType.ROLE_VIEW_ADVERT_RESULT, data)
end

function NetRoleSystem:reqSynScreenRole() 
    print("----reqSynScreenRole---")
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_SYN_SCREEN_ROLE)
end

function NetRoleSystem:sendStoreBuyGoodsMessage(storeType, goodsIndex)
    local data = {}
    data.storeType = storeType
    data.goodsIndex = goodsIndex
    Net.Helper:sendMessage(NetMessageType.ROLE_NOTICE_STORE_BUY_GOODS, data)
end

function NetRoleSystem:sendSweepDungeonMessage(level, sweepCnt)
    local data = {}
    data.level = level
    data.sweepCnt = sweepCnt
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_SWEEP_DUNGEON, data)
end

function NetRoleSystem:sendClaimDeepLinkAward()

    Net.Helper:sendMessage(NetMessageType.ROLE_CLAIM_DEEPLINK_AWARD)
end

--[[
    optional uint32 level = 1;                   // 扫荡层数
    optional uint32 sweepCnt = 2;                // 扫荡次数
    optional bool  = 3;                   // 使用道具
    optional uint32 caveMode = 4          // caveMode
]]
function NetRoleSystem:sendRequestSweepDistortedSpace(level, sweepCnt, useItem, caveMode)
    local data = {}
    data.level = level
    data.sweepCnt = sweepCnt
    data.useItem = useItem
    data.caveMode = caveMode

    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_SWEEP_DISTORTEDSPACE, data)
end

-- 缤纷活动
-- 成长基金领取
function NetRoleSystem:sendRequestGrowFundGetAwards(claimLevel,id)
    local data = {}
    data.claimLevel = claimLevel
    if id then
        data.id = id
    end

    Net.Helper:sendMessage(NetMessageType.REQUIRE_ACTIVITY_GROW_FUND_GET_AWARDS, data)
end

-- 请求领取活动目标奖励
function NetRoleSystem:sendActivityTargetGetAwards(targetId, groupId)
    local data = {}
    data.groupId = groupId
    data.targetTemplateId = targetId

    Net.Helper:sendMessage(NetMessageType.REQUIRE_ACTIVITY_TARGET_GET_REWARD, data)
end

-- 请求(切换)进入家园场景(CO OS）
function NetRoleSystem:reqEnterHomeScene()
    if(DEBUG) then
        printInfo("NetRoleSystem:reqEnterHomeScene ")
    end

    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.ROLE_ENTER_HOME_SCENE, messageData)
end

function NetRoleSystem:reqEnterTownScene()
    if(DEBUG) then
        printInfo("NetRoleSystem:reqEnterTownScene ")
    end

    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.ROLE_ENTER_TOWN_SCENE, messageData)
end

-- 请求上报打开functionType的UI界面
function NetRoleSystem:reqOpenFuntionTypeUI(functionType)
    if(DEBUG) then
        printInfo("NetRoleSystem:reqOpenFuntionTypeUI ", functionType)
    end

    local messageData = {}
    messageData.functionType = functionType
    Net.Helper:sendMessage(NetMessageType.ROLE_OPEN_FUNCTIONTYPE_UI, messageData)
end

-- 请求神迹祈福
function NetRoleSystem:reqMiraclePrayer(usePrayGoods)
    local messageData = {}
    messageData.usePrayGoods = usePrayGoods

    Net.Helper:sendMessage(NetMessageType.ROLE_MIRACLE_REQ_PRAYER, messageData)
end

-- 请求选择深红炼狱宝石
function NetRoleSystem:reqSelectInfernoRune(selectedIndex)
    local messageData = {}
    messageData.selectedIndex = selectedIndex

    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_SELECT_INFERNO_RUNE, messageData)
end

-- 请求选择虚空秘境宝石
function NetRoleSystem:reqSelectVoidRiftRune(selectedIndex)
    local messageData = {}
    messageData.selectedIndex = selectedIndex

    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_SELECT_VOIDRIFT_RUNE, messageData)
end

-- 请求选择维京时代宝石
function NetRoleSystem:reqSelectViKingRune(selectedIndex)
    local messageData = {}
    messageData.selectedIndex = selectedIndex

    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_SELECT_VIKING_RUNE, messageData)
end

-- 请求雇佣列表
function NetRoleSystem:reqMercenaryList(timestamp)
    local messageData = {}
    messageData.timestamp = timestamp

    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_MERCENARY_LIST, messageData)
end

-- 
function NetRoleSystem:reqEnterMercenaryCave(messageData)
    print("reqEnterMercenaryCave=", messageData)

    Net.Helper:sendMessage(NetMessageType.ROLE_ENTER_CAVE_SCENE, messageData)
end

-- 幽灵深渊材料兑换
function NetRoleSystem:reqExchangeGhostAbyssGoods(exchangeGoodsID, useMaterialsGoodsArr)
    print("reqExchangeGhostAbyssGoods=", exchangeGoodsID, useMaterialsGoodsArr)
    local messageData = {}
    messageData.goodsId = exchangeGoodsID
    messageData.materials = useMaterialsGoodsArr

    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_ExchangeGhostAbyssGoods, messageData)
end

function NetRoleSystem:reqEquipPlayerDecorateMessage(decorateType, decorateValue)
    if DEBUG then
        print ("[Net.NetRoleSystem] reqEquipPlayerDecorateMessage ", decorateType, decorateValue)
    end

    local messageData = {}
    messageData.decorateType = decorateType
    messageData.decorateValue = decorateValue
    
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_ReqEquipPlayerDecorateMessage, messageData)
end

function NetRoleSystem:reqBuySkillLabel(label)
    if DEBUG then
        print ("[Net.NetRoleSystem] reqBuySkillLabel ", label)
    end

    local messageData = {}
    messageData.label = label
    
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_BUY_SKILL_LABEL, messageData)
end

function NetRoleSystem:reqGemShopBuyMessage(goodsID,storeId)
    local messageData = {
        goodsID = goodsID,
        storeId = storeId,
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_GEM_SHOP_BUY_MESSAGE, messageData)
end

-- CS 切换战斗目标消息
function NetRoleSystem:heroSwitchBattleRequest(targetSpriteID)
    if DEBUG then
        -- Avalon.Log:debug(string.format("[Net.NetRoleSystem] heroStartBattleRequest targetSpriteID=%d  currentTime=%d", targetSpriteID, AvalonUtil:getCurrentTime()))
        print ("[Net.NetRoleSystem] heroStartBattleRequest targetSpriteID", targetSpriteID, AvalonUtil:getCurrentTime())
    end
    -- TODO 测试打击体感表现
    self._triggerBattleRequest = true
    self._triggerBattleTime = AvalonUtil:getCurrentTime()

    if targetSpriteID then
        local messageData = {}
        messageData.targetSpriteID = targetSpriteID

        Net.Helper:sendMessage(NetMessageType.ROLE_HERO_START_BATTLE, messageData)
    end
end

function NetRoleSystem:reqGemShopBuyMessage(goodsID,storeId,purchaseNum)
    local messageData = {
        goodsID = goodsID,
        storeId = storeId,
        buynum = purchaseNum
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_GEM_SHOP_BUY_MESSAGE, messageData)
end

function NetRoleSystem:reqRoleSwitchBattleTartMessage(targetSpriteID)
    local messageData = {
        targetSpriteID = targetSpriteID,
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_HERO_SWITCH_BATTLE, messageData)
end

-- 永冬裂缝领取奖励
function NetRoleSystem:reqGetEverWinterRiftRewards(id)
    local messageData = {
        id = id,
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_GET_EVER_WINTER_RIFT_REWARDS, messageData)
end

-- 角色转生请求
function NetRoleSystem:reqRoleReincarnation(id)
    local messageData = {
        id = id,
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_HERO_REQ_REINCARNATION, messageData)
end

-- 请求模具锻造
function NetRoleSystem:reqMoldForging(configId)
    local messageData = {
        configId = configId,
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_MOLD_FORGING_MESSAGE, messageData)
end

-- 请求模具镶嵌
function NetRoleSystem:reqMoldGemInlaid(configId, gemData, opType)

    -- MoldOpType 
    -- {
    --     MoldOpType_Add = 1;
    --     MoldOpType_Remove = 2;
    -- }

    local messageData = {
        configId = configId,
        gem = gemData,
        opType = opType,
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_MOLD_GEM_INLAID_MESSAGE, messageData)
end

-- 请求模具使用
function NetRoleSystem:reqUseMold(configId, opType, pos)
    local messageData = {
        configId = configId,
        opType = opType,
        pos = pos,
    }
    Net.Helper:sendMessage(NetMessageType.ROLE_REQ_USE_MOLD_MESSAGE, messageData)
end

-- 解锁星盘
function NetRoleSystem:reqUnlockStarPlate(plateID)
    local messageData = {
        plateID = plateID,
    }
    Net.Helper:sendMessage(NetMessageType.REQUEST_UNLOCK_PLATE_MESSAGE, messageData)
end

-- 请求更换使用星盘
function NetRoleSystem:reqChangeStarPlate(plateID)
    local messageData = {
        plateID = plateID,
    }
    Net.Helper:sendMessage(NetMessageType.REQUEST_CHANGE_PLATE_MESSAGE, messageData)
end

-- 角色消息处理
function NetRoleSystem:onRoleMessageHandler(no, data)
    if DEBUG then
        print(string.format("[Net.NetRoleSystem] onRoleMessageHandler no:%d.", no))
    end
    -- print("NetRoleSystem:onRoleMessageHandler", no)
    -- if (DEBUG) then
    --     if data and type(data) == "table" then
    --         for k,v in pairs(data) do 
    --             if type(v) == "table" then
    --                 print("[Net.NetRoleSystem] onRoleMessageHandler  k="..k.."  v=")
    --             end
    --         end
    --     end
    -- end
    
        -- 角色系统错误
    if (no == NetMessageType.ROLE_RESPONSE_GIFT.NO) then
        if(DEBUG) then
            print("NetMessageType.ROLE_RESPONSE_GIFT.NO")
            dump(data)
        end
        if (ProtobufUtil:enum_id("RoleSystem.ResponseGiftMessageResult", "ResponseGiftMessageResult_Suc") == data.result) then
            -- 获取礼物成功, 不做任何处理
        elseif (ProtobufUtil:enum_id("RoleSystem.ResponseGiftMessageResult", "ResponseGiftMessageResult_SystemErr") == data.result) then
            -- 获取礼物失败
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111409))
        else
            -- 未知错误
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110382))
        end
    elseif (no == NetMessageType.ROLE_INIT_HERO_SYNC.NO) then
        if not SceneManager:getInstance():isInPetPVP() then
            RoleDataManager:initHero(data, true)
        end
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA,heroData)
        
    -- 初始化角色数据
    elseif (no == NetMessageType.ROLE_INIT_HERO.NO) then
        if DEBUG then
            for k,v in pairs(data.heroData) do
                print("ROLE_INIT_HERO k,v=",k,v)
            end
        end
        if(SHEILD_DREAM_FLAG ~= true) then 
            -- 请求排行数据
            Net.NetRankSystem:requestRankList(PublicDefine.RankType.RankType_Dream, true)
        end        
        -- print( " 同步 2 111111111 ")
        RoleDataManager:initHero(data)

        local heroData = RoleDataManager:getMaster()

        -- 这里来判断是否初始化了默认城镇模式
        if(heroData and heroData:getHeroCreateTime() ~= 0) then 
            local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME, AvalonUtil.getIdentifier())
            if(globalUserData) then
                if not globalUserData:getIsInitNewTownTypeFlag() then
                    local mainStageTime = ConfigManager:getGeneralForKey("mainStageTime")
                    local timeIntenel = GameManager:getUnixTimeByConfigTimeStr(mainStageTime)
                    -- print("timeInteneltimeInteneltimeInteneltimeIntenel", mainStageTime, timeIntenel, heroData:getHeroCreateTime() < timeIntenel)
                    globalUserData:setIsInitNewTownTypeFlag(true)
                    if heroData:getHeroCreateTime() < timeIntenel then 
                        GameManager:setIsNewTownType(false)
                    else
                        GameManager:setIsNewTownType(true)
                    end
                    -- print("timeInteneltimeInteneltimeInteneltimeIntenel 2=", GameManager:getIsNewTownType())
                end
            end
        end

        -- 处理客户端生成昵称
        if(heroData.nickName == "0") then
            Net.NetRoleSystem:heroEditNickNameRequest(heroData:getPK(), GameDataManager:getInstance():makeNickName())
        end
        
        if (device.platform == "ios" or device.platform == "android") then
            buglySetUserId(heroData:getPK().."")
        end

        -- -- 用于测试添加移除BUFF
        -- local targetSpriteID = heroData:getSpriteID()
        -- local entityID = 12323
        -- local addData = {
        --     buffID = 31020630,
        --     entityID = entityID,
        --     targetSpriteID = targetSpriteID,
        --     curDuration = 10000,
        --     overlayNum = 1,
        --     sourceSpriteID = targetSpriteID
        -- }

        -- local command = Command.ControlCommand:create(true)
        -- command:initForAddBuff(addData, false)
        -- SceneManager:getInstance():pushCommand(command)

        -- local removeData = {
        --     entityID = entityID,
        --     targetSpriteID = targetSpriteID,
        -- }

        -- local command = Command.ControlCommand:create(true)
        -- command:initForTypeAndData(CommandType.CONTROL_REMOVE_BUFFER, removeData)
        -- SceneManager:getInstance():pushCommand(command)
    -- 处理编辑昵称反馈
    elseif (no == NetMessageType.ROLE_RESPONSE_EDIT_NICK_NAME.NO) then  
        if(DEBUG) then
            print("ROLE_RESPONSE_EDIT_NICK_NAME  ")
            for k,v in pairs(data) do
                print("ROLE_RESPONSE_EDIT_NICK_NAME k,v=",k,v)
            end
        end

        local master = RoleDataManager:getMaster()
        local notice = false
        if(master) then
            if(master:getPK() == data.pk) then 
                notice = true
            end
        end

        if(notice) then
            MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.EDIT_NAME)
        end

        if(data.result =="EditNicknameResult_OK") then
            local heroData = RoleDataManager:handEditNickName(data)
            if(heroData) then
                local command = Command.ControlCommand:create(true)
                command:initForTypeAndData(CommandType.CONTROL_EDIT_NICK_NAME, heroData)
                SceneManager:getInstance():pushCommand(command)

                Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA,heroData)
            end
            if notice then
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110879))
            end
        else 
            if notice then
                GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.EditNicknameResult", data.result))
            end
        end
        
        if notice then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_BEAUTY_EDITE_NEAME_RESPONSE,data)
        end
    -- 处理编辑昵称完成
    elseif (no == NetMessageType.ROLE_EDIT_NICK_NAME.NO) then
        if(DEBUG) then
            print("ROLE_EDIT_NICK_NAME  ")
            for k,v in pairs(data) do
                print("ROLE_EDIT_NICK_NAME k,v=",k,v)
            end
        end
        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.EDIT_NAME)
        local heroData = RoleDataManager:handEditNickName(data)
        if(heroData) then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_EDIT_NICK_NAME, heroData)
            SceneManager:getInstance():pushCommand(command)

            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA,heroData)
        end
    -- 加载游戏场景
    elseif (no == NetMessageType.ROLE_LOAD_SCENE.NO) then

        if(DEBUG) then
            print("####NetRoleSystem:onRoleMessageHandler")
            dump(data)
        end
        SceneManager:getInstance():backupLastState()
        local gameLoginManager = require("app.game.GameLoginManager")
        -- 上报游戏服通知加载场景
        gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Loading_Server_LoadScene)
        
        SceneManager:setWeatherID(data.weatherID)
        if GameManager:getCustomHQ(CUSTOM_HQ_TYPE.WEATHER) then
            WeatherManager:getInstance():updateWeatherId(data.weatherID)
        end

        --标记是否有三选一
        mvc.greedySelectModel:setCanGreedySelect(data.canGreedy)
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_LOADSCENCE, data)
        SceneManager:getInstance():pushCommand(command)
    -- 已探索的视区数据
    elseif (no == NetMessageType.ROLE_EXPLORED_VIEWAREA.NO) then
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_EXPLOREDVIEWAREA, data)
        SceneManager:getInstance():pushCommand(command)
    -- 转变为可到达的地图块
    elseif (no == NetMessageType.ROLE_TRANSFORMED_GROUND.NO) then
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_TRANSFORMEDGROUND, data)
        SceneManager:getInstance():pushCommand(command)
    -- 进入场景
    elseif (no == NetMessageType.ROLE_ENTER_SCENE.NO) then
        ServerConfigUtil:saveAreaData()

        -- 上报游戏服通知进入场景
        NetHelper.setAnalysisEnable(false)
        local gameLoginManager = require("app.game.GameLoginManager")
        gameLoginManager:reportLoginStep(PublicDefine.LoginLogType.Loading_Server_IntoScene)
        gameLoginManager:getInstance():setAreaID(nil)

        GameManager:openCountDownSwitch()

        if(SceneManager:getInstance():isInDungeon()) then
            if(not SceneManager:getInstance():isInBlackHouse()) then 
                TaskDataManager:handleSaveMaxLevel() 
            end
        else
            TaskDataManager:handleSaveMaxLevel() 
        end 
        --城镇公告
        ImageDownLoadUtil:getTownNoticeFromWeb()

        -- 处理恢复本地的快捷栏数据
        if(SceneManager:getInstance():isUseLocalShortcutBar()) then 
            local saveGoodsData = GoodsDataManager:getSaveGoodsData()
            if(saveGoodsData) then 
                local dataArr = saveGoodsData:getShortcutBarData(SceneManager:getInstance():getLocalShortcutBarIndex())
                if(dataArr) then 
                    for k,v in pairs(dataArr) do
                        GoodsDataManager:updateLocalShortcutBar(v.index,v.templateID)
                    end
                end
            end
        end
        local areaList = mvc.settingModel:getAreaListData()
        if(areaList and #areaList <=0) then
            mvc.send(mvc.events.Setting_Area_Server_ReqAreaList)
        end
        isFromChangeSceneUsedInEnterScence = true
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ENTER_SCENE, nil)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.ROLE_END_LOGIN_SCENE.NO) then
        if(DEBUG) then
            dump(data)
        end
        RoleDataManager:handleEndLogin(data)

        -- 处理获取服务器资源以及代码版本
        GameDataManager:getInstance():handleServerVersion(data)

        TaskDataManager:triggerAcceptTask()

        -- 处理SDK收集信息
        local gameLoginManager = require("app.game.GameLoginManager")
        gameLoginManager:getInstance():sendSubmitExtraData()

        -- 数据统计
        gameLoginManager:getInstance():loginreport()
        
        Net.NetGuildSystem:reqActivityCount()
        if GameDataManager:getInstance():isOutForTurnTableData() then
            Net.NetNPCSystem:loadTurnTableInfo() 
        end
        --梦境数据
        if not MasterDataManager:isHaveDreamData() and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Dream) then
            self:requestGetDreamInfo()
        end
        -- 发起对时
        -- self:syncTimeRequest()
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_WAITING_BEGIN_SYNC, data)
        SceneManager:getInstance():pushCommand(command)
    -- 同屏英雄
    elseif (no == NetMessageType.ROLE_SCREEN_HERO.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_SCREEN_HERO k,v=",k,v)
            end
            -- dump(data)
        end
        -- if(GameManager:getIsInNewScene() and GameManager:getIsInitNewTownTypeFlag()) then 
        --     return 
        -- end
        -- print("+++++++++++NetMessageType.ROLE_SCREEN_HERO")
        if not SceneManager:getInstance():isInPetPVP() then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_SCREENHERO, data)
            SceneManager:getInstance():pushCommand(command)
        end
    -- 请求英雄详情返回
    elseif (no == NetMessageType.ROLE_RESPONSE_HERO_DETAIL.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_RESPONSE_HERO_DETAIL k,v=",k,v)
            end
        end
        -- print("ROLE_RESPONSE_HERO_DETAIL")
        -- dump(data)
        local isShowImmediately = true
        if (ProtobufUtil:checkFieldIsInit(data, "isShowImmediately")) then
            isShowImmediately = data.isShowImmediately
        end
        if(data.result == "HeroDetailResult_success") then
            local detailData =  MasterDataManager:handleHeroDetail(data)
            if(detailData) then
                if (isShowImmediately and not (data.subType == PublicDefine.RankType.RankType_Dream and data.preWeekRank == true)) then 
                    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_SHOW_ROLE_INFO, detailData)
                end
                if not isShowImmediately then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_DELAY_SHOW_HERO_DETAIL, detailData)
                end
                mvc.send(mvc.events.MENTOR_UPDATE_ROLE_INFO_MESSAGE, detailData)
            end
        else
            if(isShowImmediately and not (data.subType == PublicDefine.RankType.RankType_Dream and data.preWeekRank == true)) then 
                GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.HeroDetailResult", data.result))
            end 
        end
    --玩家趣味数据
    elseif (no == NetMessageType.REVICE_FUNNY_RECORD_DATA.NO) then
        -- dump(data, "-------NetMessageType.REVICE_FUNNY_RECORD_DATA")
        MasterDataManager:setFunnyRecord(data.records)
    elseif (no == NetMessageType.ROLE_GLOBAL_MONSTER.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_GLOBAL_MONSTER k,v=",k,v)
            end
        end
        -- local monsterData = RoleDataManager:handleMonsterData(data, PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_GLOBALMONSTER, data)
        SceneManager:getInstance():pushCommand(command)
    -- 同屏怪物
    elseif (no == NetMessageType.ROLE_SCREEN_MONSTER.NO) then
        -- if DEBUG then
        --     for k,v in pairs(data) do
        --         print("ROLE_SCREEN_MONSTER k,v=",k,v)
        --     end
        -- end
        -- local monsterData = RoleDataManager:handleMonsterData(data, PublicDefine.CAVE_MODE.MODE_NORMAL, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SCREENMONSTER, data)
        SceneManager:getInstance():pushCommand(command)
    -- -- 全屏宝箱
    -- elseif (no == NetMessageType.ROLE_GLOBAL_BOX.NO) then
    --     if DEBUG then
    --         for k,v in pairs(data) do
    --             print("ROLE_GLOBAL_BOX k,v=",k,v)
    --         end
    --     end

    --     local boxData = RoleDataManager:handleBoxData(data)
    --     local command = Command.ControlCommand:create(true)
    --     command:initForTypeAndData(CommandType.CONTROL_GLOBALBOX, boxData)
    --     SceneManager:getInstance():pushCommand(command)

    elseif (no == NetMessageType.ROLE_REMOVE_AFFIX_FOR_ALL_MONSTER.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_REMOVE_AFFIX_FOR_ALL_MONSTER k,v=",k,v)
            end
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REMOVE_AFFIX_FOR_ALL_MONSTER, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.ROLE_ROLE_LEVEL_UP.NO ) then
        -- 角色升级
        local oldLevel = RoleDataManager:handleLevelUp(data)

        if(oldLevel > 0) then
            local cmdData = {}
            cmdData.spriteID = data.spriteID
            cmdData.startLevel = oldLevel
            cmdData.totalLevel = data.totalLevel

            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_ROLE_LEVEL_UP, cmdData)
            SceneManager:getInstance():pushCommand(command)

            TaskDataManager:triggerAcceptTask()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)

            -- 自己升级时检测成长基金弹窗
            if RoleDataManager:getMaster():getSpriteID() == data.spriteID then
                mvc.send(mvc.events.TradeActivity_Handle_Role_Level_Up, oldLevel)
            end
        end

        -- 角色升级数据上传
        GameDataManager:getInstance():submitExtraData(Avalon.SubmitExtraDataType.SubmitExtraDataUpdateRole);
    --全屏触发类NPC
    elseif (no == NetMessageType.ROLE_GLOBAL_TRIGGER_NPC.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_GLOBAL_TRIGGER_NPC k,v=",k,v)
            end
        end
        if(GameManager:getIsInNewScene() and GameManager:getIsInitNewTownTypeFlag()) then 
            return 
        end

        -- 处理全屏触发类NPC
        -- local triggerNpcData = RoleDataManager:handleTriggerNpcData(data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_GLOBAL_TRIGGERNPC, data)
        SceneManager:getInstance():pushCommand(command)
    --同屏触发类NPC
    elseif (no == NetMessageType.ROLE_SCREEN_TRIGGER_NPC.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_SCREEN_TRIGGER_NPC k,v=",k,v)
            end
        end
        if(GameManager:getIsInNewScene() and GameManager:getIsInitNewTownTypeFlag()) then 
            return 
        end
        -- 处理同屏触发类NPC
        -- local triggerNpcData = RoleDataManager:handleTriggerNpcData(data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SCREEN_TRIGGERNPC, data)
        SceneManager:getInstance():pushCommand(command)
    -- 怪物详情
    elseif (no == NetMessageType.ROLE_DETAIL_MONSTER.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_DETAIL_MONSTER k,v=",k,v)
            end
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_MONSTER_DETAIL, data)
        SceneManager:getInstance():pushCommand(command)
    -- 移除同屏角色
    elseif (no == NetMessageType.ROLE_REMOVE_SCREEN_ROLE.NO) then
        -- if DEBUG then
        --     for k,v in pairs(data) do
        --         print("ROLE_REMOVE_SCREEN_ROLE k,v=",k,v)
        --     end
        -- end
        -- if(GameManager:getIsInNewScene() and GameManager:getIsInitNewTownTypeFlag()) then 
        --     return 
        -- end
        if not SceneManager:getInstance():isInPetPVP() then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_REMOVESCREENROLE, data)
            SceneManager:getInstance():pushCommand(command)
        end
    -- 英雄开始移动
    elseif (no == NetMessageType.ROLE_NOTIFY_HERO_START_MOVE.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_NOTIFY_HERO_START_MOVE k,v=",k,v)
            end
        end
        if(GameManager:getIsInNewScene() and GameManager:getIsInitNewTownTypeFlag()) then 
            return 
        end
        if not SceneManager:getInstance():isInPetPVP() then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_NOTIFY_HERO_START_MOVE,data)
            SceneManager:getInstance():pushCommand(command)
        end
    -- 英雄停止移动
    elseif (no == NetMessageType.ROLE_NOTIFY_HERO_STOP_MOVE.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_NOTIFY_HERO_STOP_MOVE k,v=",k,v)
            end
        end
        if(GameManager:getIsInNewScene() and GameManager:getIsInitNewTownTypeFlag()) then 
            return 
        end
        if not SceneManager:getInstance():isInPetPVP() then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_NOTIFY_HERO_STOP_MOVE,data)
            SceneManager:getInstance():pushCommand(command)
        end
    -- 同步英雄坐标
    elseif (no == NetMessageType.ROLE_HERO_POSITION_SYNC.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_HERO_POSITION_SYNC k,v=",k,v)
            end
        end
        if not SceneManager:getInstance():isInPetPVP() then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_HERO_POSITION_SYNC, data)
            SceneManager:getInstance():pushCommand(command)
        end
    -- 英雄开始战斗结果
    elseif (no == NetMessageType.ROLE_HERO_START_BATTLE_RESULT.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_HERO_START_BATTLE_RESULT k,v=",k,v)
            end
        end

        if (data.startBattleResult == ProtobufUtil:enum_id("RoleSystem.StartBattleResult","StartBattleResult_CampError")) then
            UI.ScrollBar:createByText(UI.TEXT_1213441)
        end


        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_HERO_START_BATTLE_RESULT, data)
        SceneManager:getInstance():pushCommand(command)
    -- 英雄切换目标战斗结果
    elseif (no == NetMessageType.ROLE_HERO_SWITCH_BATTLE_RESULT.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_HERO_SWITCH_BATTLE_RESULT k,v=",k,v)
            end
        end

        if (data.startBattleResult == ProtobufUtil:enum_id("RoleSystem.HeroSwitchBattleMessage","StartBattleResult_CampError")) then
            UI.ScrollBar:createByText(UI.TEXT_1213441)
        end


        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_HERO_SWITCH_BATTLE_RESULT, data)
        SceneManager:getInstance():pushCommand(command)
        if data.lastSwitchTime and data.lastSwitchTime > 0 then
            UI.ScrollBar:createByText(UI.TEXT_223815)
        end
    -- 同屏英雄开始战斗
    elseif (no == NetMessageType.ROLE_SCREEN_HERO_START_BATTLE.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_SCREEN_HERO_START_BATTLE k,v=",k,v)
            end
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SCREEN_HERO_START_BATTLE, data)
        SceneManager:getInstance():pushCommand(command)

    -- 服务器通知主角开始使用技能
    elseif (no == NetMessageType.ROLE_NOTIFY_MASTER_START_USE_SKILL.NO) then
        -- 处理服务器通知开始使用技能
        
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NOTIFY_START_USE_SKILL, data)
        SceneManager:getInstance():pushCommand(command)
    -- 角色技能MISS
    elseif (no == NetMessageType.ROLE_ROLE_SKILL_MISS.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_ROLE_SKILL_MISS k,v=",k,v)
            end
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ROLE_SKILL_MISS, data)
        SceneManager:getInstance():pushCommand(command)
    -- 角色使用技能
    elseif (no == NetMessageType.ROLE_NOTIFY_ROLE_SKILL_STATUS.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_NOTIFY_ROLE_SKILL_STATUS k,v=",k,v)
            end
        end
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NOTIFY_ROLE_SKILL_STATUS, data)
        SceneManager:getInstance():pushCommand(command)
    -- 玩家使用技能结果
    elseif (no == NetMessageType.ROLE_HERO_USE_SKILL_RESULT.NO) then
        if DEBUG then
            for k,v in pairs(data) do
                print("ROLE_HERO_USE_SKILL_RESULT k,v=",k,v)
            end
        end 
        
        -- 处理使用技能的结果
        data.isPet = false
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SKILL_USE_RESULT, data)
        SceneManager:getInstance():pushCommand(command)
    -- 通知玩家技能打断
    elseif (no == NetMessageType.ROLE_NOTIFY_ROLE_SKILL_BREAK.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NOTIFY_ROLE_SKILL_BREAK, data)
        SceneManager:getInstance():pushCommand(command)
        -- 通知玩家技能开始冷却
    elseif (no == NetMessageType.ROLE_NOTIFY_ROLE_SKILL_START_EFFECT.NO) then
        -- print("ROLE_NOTIFY_ROLE_SKILL_START_EFFECT", data)
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NOTIFY_ROLE_SKILL_START_EFFECT, data)
        SceneManager:getInstance():pushCommand(command)
    -- 通知玩家技能冷却
    elseif (no == NetMessageType.ROLE_NOTIFY_ROLE_SKILL_COOLDOWN.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NOTIFY_ROLE_SKILL_COOLDOWN, data)
        SceneManager:getInstance():pushCommand(command)
    -- 通知玩家技能呤唱
    elseif (no == NetMessageType.ROLE_NOTIFY_ROLE_SKILL_ACCUMULATE.NO) then
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NOTIFY_ROLE_SKILL_ACCUMULATE, data)
        SceneManager:getInstance():pushCommand(command)

    -- 通知角色添加buff
    elseif (no == NetMessageType.ROLE_ROLE_ADD_BUFF.NO) then
        -- print("通知角色添加buff",data.targetSpriteID, data.entityID, data.targetSpriteID, data.buffID)
        
        -- add by zp 处理buff的数据处理， 这里由于服务器在一些特殊情况没法保证不再 begin_trancse -> loadScene 消息之间发送该消息
        SkillDataManager:handleBufferData(data, false)

        local command = Command.ControlCommand:create(true)
        command:initForAddBuff(data, false)
        SceneManager:getInstance():pushCommand(command)

        -- if SceneManager:getInstance():isInBigCrack()  then
        --     Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function() 
        --             -- 发送添加buffer的消息
        --             Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_ADD_BUFFER, {
        --                 bufferData = SkillDataManager._buffMap[data.entityID],
        --                 bufferEntityID = data.entityID,
        --                 bufferTargetID = data.targetSpriteID
        --             })
        --     end, 1)
        -- end

    -- 通知角色移除buff
    elseif (no == NetMessageType.ROLE_ROLE_REMOVE_BUFF.NO) then
        -- print("通知角色移除buff",data.targetSpriteID,data.entityID)

        SkillDataManager:deleteBuff(data.targetSpriteID,data.entityID)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REMOVE_BUFFER, data)
        SceneManager:getInstance():pushCommand(command)

        if SceneManager:getInstance():isInBigCrack() and SkillDataManager._buffMap[data.entityID] then
            -- 发送buffer移除的消息
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REMOVE_BUFFER, {
                bufferData = SkillDataManager._buffMap[data.entityID],
                bufferEntityID = data.entityID,
                bufferTargetID = data.targetSpriteID
            })
        end
        
    -- 通知角色添加效果
    elseif (no == NetMessageType.ROLE_ROLE_ADD_EFFECT.NO) then
        -- print("NetMessageType.ROLE_ROLE_ADD_EFFECT",data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ADD_EFFECT, data)
        SceneManager:getInstance():pushCommand(command)

    -- 刷新所有技能的冷却时间
    elseif (no == NetMessageType.ROLE_REFRESH_ALL_SKILL_CD.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REFRESH_ALL_SKILL_CD, data)
        SceneManager:getInstance():pushCommand(command)
    -- 刷新某类buff消息
    elseif (no == NetMessageType.ROLE_REFRESH_BUFF_BY_KIND.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REFRESH_BUFFER_BY_KIND, data)
        SceneManager:getInstance():pushCommand(command)
    -- 刷新某类buff消息
    elseif (no == NetMessageType.ROLE_REFRESH_BUFF_BY_EFFECT_TYPE.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REFRESH_BUFFER_BY_EFFECT, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.ROLE_REFRESH_BUFF_INST_ID.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REFRESH_BUFF_FOR_INST_ID, data)
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.ROLE_HERO_ESCAPE_FAILED.NO) then
        if(DEBUG) then
            print("NetMessageType.ROLE_HERO_ESCAPE_FAILED")
            dump(data)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_HERO_ESCAPE_FAILED, data)
        SceneManager:getInstance():pushCommand(command)
    -- SC 通知同屏英雄逃跑
    elseif (no == NetMessageType.ROLE_NOTIFY_HERO_ESCAPE.NO) then
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NOTIFY_HERO_ESCAPE, data)
        SceneManager:getInstance():pushCommand(command)
        -- SC 通知(全屏)取消逃跑
    elseif (no == NetMessageType.ROLE_NOTIFY_HERO_CANCEL_ESCAPE.NO) then
        -- print("NetMessageType.ROLE_NOTIFY_HERO_CANCEL_ESCAPE", data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTORL_NOTIFY_HERO_CANCEL_ESCAPE, data)
        SceneManager:getInstance():pushCommand(command)
    -- 角色离开战斗
    elseif (no == NetMessageType.ROLE_LEAVE_BATTLE.NO) then
        Avalon.Log:writeInfoFile()

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ROLE_LEAVE_BATTLE, data)
        SceneManager:getInstance():pushCommand(command)
    -- 角色死亡
    elseif (no == NetMessageType.ROLE_DEAD.NO) then
        -- print("NetMessageType.ROLE_DEAD.NO ", data.spriteID, data.isReviveFree)
        dump(data, "ROLE_DEAD")

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ROLE_DIE, data)
        SceneManager:getInstance():pushCommand(command)

    -- 复活返回状态--队友都会收到
    elseif (no == NetMessageType.ROLE_RESPONSE_REVIVE_HERO.NO) then
        -- 复活返回状态--队友都会收到
        
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REVIVE_RESPONSE, data)
        SceneManager:getInstance():pushCommand(command)
        UI.WaitingLayer:hideWaiting()
        -- 复活完成
    elseif (no == NetMessageType.ROLE_REVIVE_HERO_COMPLETE.NO) then
        if(DEBUG) then 
            print("NetMessageType.ROLE_REVIVE_HERO_COMPLETE.NO", data.spriteID)
        end
        -- 复活完成，队友，同屏都会收到
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REVIVE_COMPLETE, data)
        SceneManager:getInstance():pushCommand(command)
    -- 更新角色数据
    elseif (no == NetMessageType.ROLE_ATTR_CHANGE.NO) then
        if DEBUG then
            -- TODO 测试打击感问题
            local testAttack = false
            if(testAttack) then
                if(self._triggerNum == nil) then
                    self._triggerNum = 0
                end
                if (self._fristTime == nil) then
                    self._fristTime = AvalonUtil:getCurrentTime()
                end
                if (self._triggerBattleTime == nil) then
                    self._triggerBattleTime = AvalonUtil:getCurrentTime()
                end
                self._triggerNum = self._triggerNum + 1

                if self._triggerBattleRequest then
                    self._triggerBattleRequest = false
                    self._fristTime = AvalonUtil:getCurrentTime()
                    self._triggerNum = 0
                    local chaTime = self._triggerBattleTime - AvalonUtil:getCurrentTime()
                    Avalon.Log:debug(string.format("ROLE_ATTR_CHANGE frist spriteID=%d  chaTime=%d",data.spriteID,chaTime))
                end

                self._lastTime = AvalonUtil:getCurrentTime()
                Avalon.Log:debug(string.format("total  chaTime=%d  _triggerNum=%d",(self._lastTime-self._fristTime),self._triggerNum))
                
                -- Avalon.Log:debug(string.format("eeeeeeeeeeeeeee  spriteID=%d  cureenttime=%d  cha=%d",data.spriteID,AvalonUtil:getCurrentTime(),AvalonUtil:getCurrentTime()-self._triggerBattleTime))
                self._triggerBattleTime = AvalonUtil:getCurrentTime()
            end

            print("ROLE_ATTR_CHANGE  spriteID=",data.spriteID)
            for k,v in pairs(data.attrChange) do
                print("ROLE_ATTR_CHANGE attrChange changeValue,changeType,changePercent,changeReason,resultValue,sourceSpriteID=",v.changeValue,v.changeType,v.changePercent,v.changeReason,v.resultValue,v.sourceSpriteID)
            end
        end
        -- 过滤金币以及钻石修改
        local attrChange = data.attrChange or {}
        for k,attrInfo in pairs(attrChange) do
            if DEBUG_ATTR then
                print("ShareMachine:_handleAttrChangeMes   sourceSpriteID,masterSpriteID,mesData.spriteID=",attrInfo.sourceSpriteID,masterSpriteID,mesData.spriteID)
            end
            
            local ATTR_TYPE = PublicDefine.ATTR_TYPE

            local localdata = nil
            if attrInfo.changeType == ATTR_TYPE.curCoin  then
                localdata = {}
                localdata.costType = GOODS_COST_TYPE.GOLD
                localdata.value = attrInfo.changeValue
                
            elseif attrInfo.changeType == ATTR_TYPE.curDiamond then
                localdata = {}
                localdata.costType = GOODS_COST_TYPE.GEM
                localdata.value = attrInfo.changeValue
            elseif(attrInfo.changeType == ATTR_TYPE.curLVExp) then 
                -- add by zp 这里如果没有经验增加就不应该有提示
                if(attrInfo.changeValue>0) then
                    localdata = {}
                    localdata.costType = -1
                    localdata.value = attrInfo.changeValue
                    localdata.changeType = attrInfo.changeType
                end
            elseif(attrInfo.changeType == ATTR_TYPE.horcruxCoin) then 
                if(attrInfo.changeValue>0) then
                    localdata = {}
                    localdata.costType = GOODS_COST_TYPE.HORCRUX_COIN
                    localdata.value = attrInfo.changeValue
                    localdata.changeType = attrInfo.changeType
                end
            elseif attrInfo.changeType == ATTR_TYPE.refreshDay then
                -- worldboss 恢复挑战次数
                mvc.worldBossModel:resetChallengeTime()
            end
            if(localdata) then
                if attrInfo.changeReason == PublicDefine.ATTR_CHANGE_REASON_TYPE.ACTIVITY_EXTRADROP then
                    -- 添加了掉落钻石展示
                    if localdata.costType == PublicDefine.GOODS_COST_TYPE.GEM then
                        local goodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.Diamond)
                        if(goodsData) then
                            goodsData:setNum(localdata.value)
                            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_GET_GOODS, goodsData)
                        end
                    end

                    localdata.changeReason = attrInfo.changeReason
                    Game.ChatManager:getInstance():sendSysMsgWithData(localdata) 
                elseif attrInfo.changeReason == PublicDefine.ATTR_CHANGE_REASON_TYPE.DIG then
                    localdata.changeReason = attrInfo.changeReason
                    Game.ChatManager:getInstance():sendSysMsgWithData(localdata) 
                    if localdata.costType == PublicDefine.GOODS_COST_TYPE.GOLD then
                       
                    elseif localdata.costType == PublicDefine.GOODS_COST_TYPE.GEM then
                        local goodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.Diamond)
                        if(goodsData) then
                            goodsData:setNum(localdata.value)
                            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_GET_GOODS, goodsData)
                        end
                    end
                elseif attrInfo.changeReason == PublicDefine.ATTR_CHANGE_REASON_TYPE.QUESTIONNAIRE then
                    if localdata.costType == PublicDefine.GOODS_COST_TYPE.GEM then
                        local goodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.Diamond)
                        if(goodsData) then
                            goodsData:setNum(localdata.value)
                            local rewardGoodsArr = {}
                            table.insert(rewardGoodsArr, goodsData)
                            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, nil, UI.TEXT_111030, nil)  
                        end
                    end
                    localdata.changeReason = attrInfo.changeReason
                    Game.ChatManager:getInstance():sendSysMsgWithData(localdata)
                else
                    localdata.changeReason = attrInfo.changeReason
                    Game.ChatManager:getInstance():sendSysMsgWithData(localdata)
                end
            end


            --使用星辰卡道具 当卡片激活时, 获得航海币(提示)
            -- print("  attrInfo.changeReason === ",attrInfo.changeReason , PublicDefine.ATTR_CHANGE_REASON_TYPE.ALTER_REASON_USE_STAR_CARD)
            if attrInfo.changeReason == PublicDefine.ATTR_CHANGE_REASON_TYPE.ALTER_REASON_USE_STAR_CARD then
                UI.ScrollBar:createByText(string.format(UI.TEXT_222639, attrInfo.changeValue))
            end
        end

        -- print("NetMessageType.ROLE_ATTR_CHANGE.NO  !!!!!!  ")
        -- dump(data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ROLE_ATTR_CHANGE, data)
        SceneManager:getInstance():pushCommand(command)

    -- 处理功能标志改变
    elseif (no == NetMessageType.ROLE_FUNCTION_FLAG_CHANGE.NO) then
        local isChange = true
        local roleData = RoleDataManager:getRoleDataBySpriteID(data.spriteID)
        if roleData then
            if roleData:getType() == RoleType.Monster and data.resultValue == PublicDefine.FunctionFlag.FunctionFlag_Transforming then
                if roleData:checkIsRandomChangeMonster() and (not data.monsterChangeID or data.monsterChangeID == 0) then
                    isChange = false
                end
                if(data.monsterChangeID and data.monsterChangeID ~= 0) then
                    roleData:setChangeID(data.monsterChangeID)
                end
            end
            
            if isChange then
                roleData:changeFunctionFlag(data.resultValue)
            end
            
            if(roleData:getType() == RoleType.Hero) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA,roleData)
            end
        end
    -- 技能状态改变
    elseif (no == NetMessageType.ROLE_SKILL_RELATED_FLAG_CHANGE.NO) then
        local roleData = RoleDataManager:getRoleDataBySpriteID(data.spriteID)
        if roleData then
            roleData:changeSkillRelatedFlag(data.resultValue)
            if(roleData:getType() == RoleType.Hero) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA,roleData)
            end
        end
    -- 改变地块为可到达
    elseif (no == NetMessageType.ROLE_TRANSFORM_TILE_TO_REACHABLE.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_DIG_WALL, {
            x = data.coordX,
            y = data.coordY
        })
        SceneManager:getInstance():pushCommand(command)
    -- 技能初始化
    elseif (no == NetMessageType.SKILL_INIT_SKILL.NO) then
        if DEBUG then
            print("NetMessageType.SKILL_INIT_SKILL.NO  start")
        end
        -- 处理技能初始化
        local pk = GameDataManager:getInstance():getMasterPK()

        for k,oneData in ipairs(data.skills) do
            if DEBUG then
                print("NetMessageType.SKILL_INIT_SKILL.NO  ",k,skillID)
            end
            local skillData = SkillDataManager:createSkillForSkillId(oneData.skillID)
            if(skillData) then
                skillData:setIsOpening(oneData.isOpen)
                SkillDataManager:addSkill(pk,skillData)
            end
        end

        -- for k,skillID in ipairs(data.skillID) do
        --     if DEBUG then
        --         print("NetMessageType.SKILL_INIT_SKILL.NO  ",k,skillID)
        --     end
        --     local skillData = SkillDataManager:createSkillForSkillId(skillID)
        --     SkillDataManager:addSkill(pk,skillData)
        -- end
    --  英雄添加技能
    elseif (no == NetMessageType.ROLE_HERO_ADD_SKILL.NO) then
        if DEBUG then
            print("NetMessageType.ROLE_HERO_ADD_SKILL.NO  ")
            for _,skillID in ipairs(data.skillID) do
                print("NetMessageType.ROLE_HERO_ADD_SKILL.NO  add  skillID=",skillID)
            end
        end
        local pk = GameDataManager:getInstance():getMasterPK()
        for _,skillID in ipairs(data.skillID) do
            local skillData = SkillDataManager:createSkillForSkillId(skillID)
            if(skillData) then 
                SkillDataManager:addSkill(pk,skillData)
                if(skillData:isAssist()) then
                    GoodsDataManager:insertShortcutBar(skillData:getSkillID())
                end
            end
        end
        -- 处理发送消息
        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAG_CHANGE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE)

    -- 英雄删除技能
    elseif (no == NetMessageType.ROLE_HERO_DELETE_SKILL.NO) then
        if DEBUG then
            print("NetMessageType.ROLE_HERO_DELETE_SKILL.NO  ")
            for _,skillID in ipairs(data.skillID) do
                print("NetMessageType.ROLE_HERO_DELETE_SKILL.NO  delete  skillID=",skillID)
            end
        end
        local pk = GameDataManager:getInstance():getMasterPK()
        for _,skillID in ipairs(data.skillID) do
            SkillDataManager:deleteSkill(pk,skillID)
        end

        GoodsDataManager:refreshShortcutBar()

        -- 处理发送消息
        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAG_CHANGE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE)
    -- 英雄技能组修改了
    elseif (no == NetMessageType.ROLE_HERO_SKILL_GROUP_CHANGE.NO) then
        if DEBUG then
            print("NetMessageType.ROLE_HERO_SKILL_GROUP_CHANGE.NO  ")
            for k,v in pairs(data) do
                print("NetMessageType.ROLE_HERO_SKILL_GROUP_CHANGE.NO =", k, v)
            end
        end

        RoleDataManager:setAdvanceStat(data.advancedStat)
        RoleDataManager:setRoleReincarnationLv(data.reincarnation)
        SkillDataManager:replaceSkillGroupID(data)

        -- local oldSkillID = nil 
        -- local skillID = nil
        -- local old,lvOld = SkillDataManager:getSkillIDBySkillGropuID(data.oldSkillGroupID)
    
        -- local lv = lvOld
        -- if(old == nil) then
        --     local new,lvNew = SkillDataManager:getSkillIDBySkillGropuID(data.skillGroupID)
        --     lv = lvNew
        --     skillID = new
        --     oldSkillID = SkillDataManager:getSkillIDBySkillGropuID(data.oldSkillGroupID, lvNew)
        -- else 
        --     oldSkillID = old
        --     skillID = SkillDataManager:getSkillIDBySkillGropuID(data.skillGroupID, lv)
        -- end

        -- if(oldSkillID and skillID) then
        --     local skillData = SkillDataManager:getSkillDataForSkillID(skillID)
        --     if(skillData) then
        --         Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SKILL_REPLACE_SKILL, oldSkillID, skillData)
        --     else 
        --         if(DEBUG) then
        --             print("NetMessageType.ROLE_HERO_SKILL_GROUP_CHANGE.NO no found skillID=", skillID)
        --         end
        --     end
        -- else  
        --     if(DEBUG) then
        --         print("NetMessageType.ROLE_HERO_SKILL_GROUP_CHANGE.NO oldSkillID , skillID", oldSkillID , skillID)
        --     end
        -- end
    -- 技能瞬移
    elseif (no == NetMessageType.ROLE_HERO_TRANSFER.NO) then
        -- 处理瞬间传送技能
        if DEBUG then
            print("NetMessageType.ROLE_HERO_TRANSFER.NO  coordX,coordY,direction=",data.coordX,data.coordY,data.direction)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_HERO_TRANSFER,data)
        SceneManager:getInstance():pushCommand(command)
    -- 处理恢复玩家buff 
    elseif (no == NetMessageType.ROLE_HERO_BUFF_LIST.NO) then
        if DEBUG then
            print("NetMessageType.ROLE_HERO_BUFF_LIST.NO  ")
            dump(data)
        end

        SkillDataManager:saveRecoverBuffData(data.buffInfo)
    -- 开始场景转换
    elseif (no == NetMessageType.ROLE_BEGIN_TRANS_SCENE.NO) then
        mvc.greedySelectModel:clearGreedySelectData()   
        mvc.greedySelectModel:clearAllGreedySelectInfo()   
        --  处理开始场景转换
        if DEBUG then
            print("NetMessageType.ROLE_BEGIN_TRANS_SCENE.NO  ")
            for k,v in pairs(data) do
                print("ROLE_BEGIN_TRANS_SCENE ",k,v)
            end
        end

        -- 如果为回档类型，处理清理回档数据
        if DEBUG then
            print("NetMessageType.ROLE_BEGIN_TRANS_SCENE.NO  transType,transReason=",data.transType,data.transResult,data.transReason)
        end

        GameDataManager:getInstance():setEscapeScrollBackTown(false)
        GameDataManager:getInstance():setIsGameComplete(false)
        GameDataManager:getInstance():setDisableSituation(false)
        GameManager:closeCountDownSwitch()

        local SdkManager = require"app.game.SdkManager"
        SdkManager:storePayCallBack()
        -- 清理场景数据
        RoleDataManager:clearFunctionData()
        
        if data.transType == "LeaveCave" then
            -- 修改最大层级    
            if(SceneManager:getInstance():isInDungeon() and 
                not SceneManager:getInstance():isInBlackHouse()) then
                TaskDataManager:handleSaveMaxLevel()
            end

            -- 活动模式处理逻辑
            if(SceneManager:getInstance():isInMaze()) then 
                if RoleDataManager:getMaster() then
                    RoleDataManager:getMaster():setLooks(0)
                end 
            end

            -- 葫芦娃活动清理数据
            if(SceneManager:getInstance():isInHuLu()) then 
                mvc.festivalModel:clearHuluData()
            end

            -- 如果为雇佣模式，离开就清理组队数据
            if(TeamDataManager:hasMercenaryTeam()) then
                TeamDataManager:restoreClear()
            end

            if(SceneManager:getInstance():isInStory()) then 
                -- print(" isInStory ", data.transReason)
                GameDataManager:getInstance():setIsShowReward(false)
                -- 这里处理新手引导的回城逻辑处理
                RoleDataManager:restoreClear()
                SkillDataManager:restoreClear()
                GoodsDataManager:restoreClear()
                TaskDataManager:restoreClear()
                TeamDataManager:restoreClear()
                MasterDataManager:restoreClear()

                -- 由于新手引导回城不会重新初始化任务，导致后面再也不会刷新任务  
                TaskDataManager:enableTaskTrigger()
                GameDataManager:getInstance():finishCaveGuildReport()
            else 
                if data.transResult == "Failure" then
                    -- dump(data)
                    -- print("RoleDataManager:getMaster():setIsDead" , data.transReason)
                    if data.transReason == "Death" then 
                        local bossID = nil
                        local machine = MachineManager:getInstance():getMachine()
                        if(machine) then
                            local allRole = machine._model:getRoleMap()
                            if(allRole) then 
                                for k,role in pairs(allRole) do 
                                    if role and role:getCategory() == Category.ROLE  and  role:getType() == RoleType.Monster then
                                        if role:getRoleData():isBigBoss() then
                                            bossID = role:getRoleData().monsterID
                                            print("NetRoleSystem ", bossID)
                                        end
                                    end
                                end
                            end
                        end

                        GameDataManager:getInstance():setTownBlackDialog(BlackDialogEventType.PLAYER_DIED, bossID)
                    elseif data.transReason == "GiveUp" then    
                        GameDataManager:getInstance():setTownBlackDialog(BlackDialogEventType.PLAYER_BACK_TOWN) 
                    end
                    -- 清理活动任务数据
                    MasterDataManager:clearAllCount()

                    -- printfmt("ROLE_BEGIN_TRANS_SCENE transType LeaveCave transResult Failure")
                    if(SceneManager:getInstance():isInDungeon()
                        or SceneManager:getInstance():isInDream()
                        or SceneManager:getInstance():isGuildBoss()
                        or SceneManager:getInstance():isActCave()) then
                        -- 根据情况处理相关数据的清理
                        RoleDataManager:clearOtherData()
                        TeamDataManager:restoreClear()
                    else
                        -- 恢复洞穴获取数据标志
                        RoleDataManager:restoreClear()
                        SkillDataManager:restoreClear()
                        GoodsDataManager:restoreClear()
                        TaskDataManager:restoreClear()
                        TeamDataManager:restoreClear()
                        MasterDataManager:restoreClear()
                    end
                    -- GameDataManager:getInstance():setTownBlackDialog(BlackDialogEventType.PLAYER_BACK_TOWN)
                elseif data.transResult == "Success" then
                    GameDataManager:getInstance():setIsFristSuccessBackTown()
                    if data.transReason == "GameComplete"then
                        if(SceneManager:getInstance():isInDungeon()
                            or SceneManager:getInstance():isInDream()
                            or SceneManager:getInstance():isGuildBoss()
                            or SceneManager:getInstance():isGhostAbyss()
                            or SceneManager:getInstance():isActCave() 
                            or SceneManager:getInstance():isInTrialLand()) then
                            -- 根据情况处理相关数据的清理
                            RoleDataManager:clearOtherData()
                            TeamDataManager:restoreClear()
                            GameDataManager:getInstance():setIsShowReward(false)
                        else
                            -- 修改最大层级
                            TaskDataManager:handleSaveMaxLevel()
                            GameDataManager:getInstance():setIsGameComplete(true)
                            GameDataManager:getInstance():setIsShowReward(true)
                            GoodsDataManager:clearNoGoldGoodsArr()
                        end
                        GameDataManager:getInstance():setTownBlackDialog(BlackDialogEventType.PORTAL_TO_TOWN)
                    elseif data.transReason == "ActivityBossSettleOK" then
                        GameDataManager:getInstance():setIsGameComplete(true)

                        -- 处理相关的逻辑
                        if GameDataManager:getInstance():getActivityRankData() == nil then 
                            local data = {}
                            data.rank = 0
                            data.bagFull = false
                            GameDataManager:getInstance():setActivityRankData(data)
                        end

                        GameDataManager:getInstance():setIsShowReward(true)
                    elseif data.transReason == "TownPortal" then
                        -- printfmt("ROLE_BEGIN_TRANS_SCENE transType LeaveCave transResult Success ransReason GameComplete")
                        if(SceneManager:getInstance():isInDungeon()
                            or SceneManager:getInstance():isInDream()
                            or SceneManager:getInstance():isGuildBoss()
                            or SceneManager:getInstance():isActCave()
                            or SceneManager:getInstance():isInTrialLand()) then
                            -- 根据情况处理相关数据的清理
                            RoleDataManager:clearOtherData()
                            TeamDataManager:restoreClear()
                            GameDataManager:getInstance():setIsShowReward(false)
                        else
                            -- 修改最大层级
                            TaskDataManager:handleSaveMaxLevel()
                            GameDataManager:getInstance():setEscapeScrollBackTown(true)
                            GameDataManager:getInstance():setIsShowReward(true, true)
                            GoodsDataManager:clearNoGoldGoodsArr()
                        end
                    else
                        -- printfmt("ROLE_BEGIN_TRANS_SCENE transType LeaveCave transResult Success ransReason GameComplete")
                        if(SceneManager:getInstance():isInDungeon()
                            or SceneManager:getInstance():isInDream()
                            or SceneManager:getInstance():isWorldBossCave()
                            or SceneManager:getInstance():isGuildBoss()
                            or SceneManager:getInstance():isGhostAbyss()
                            or SceneManager:getInstance():isActCave()
                            or SceneManager:getInstance():isInTrialLand()) then
                            -- 根据情况处理相关数据的清理
                            RoleDataManager:clearOtherData()
                            TeamDataManager:restoreClear()
                            GameDataManager:getInstance():setIsShowReward(false)
                        else
                            -- 修改最大层级
                            TaskDataManager:handleSaveMaxLevel()
                            GameDataManager:getInstance():setIsShowReward(true)
                            GoodsDataManager:clearNoGoldGoodsArr()
                        end
                        GameDataManager:getInstance():setTownBlackDialog(BlackDialogEventType.PORTAL_TO_TOWN)
                    end 
                end 
                
                -- 处理大秘境相关逻辑
                if(SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave()) then
                    GoodsDataManager:clearGoodsForPacketType(RoleDataManager:getMasterPK(),PACKET_TYPE.PACKET_BAG, PACKET_SUB_TYPE.PACKET_SUB_TYPE_2 )
                end
            end 

            --恢复状态
            RoleDataManager:getMaster():setIsDead(false)
            GoodsDataManager:resetAllInCaveNewGetFlag()
            MasterDataManager:returnToTown()
        elseif(data.transType == "EnterCave") then
            -- print("data.transType == EnterCave")
            -- 这里清理掉掉所有的物品为新获得的标志
            GoodsDataManager:resetAllInCaveNewGetFlag()
        else 
            if DEBUG then
                print("NetMessageType.ROLE_BEGIN_TRANS_SCENE.NO  no restore ")
            end
        end
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_BEGIN_TRANS_SCENE, data)
        SceneManager:getInstance():pushCommand(command)
    -- 结束场景转换
    elseif (no == NetMessageType.ROLE_END_TRANS_SCENE.NO) then
        --  处理结束场景转换
        if DEBUG then
            print("NetMessageType.ROLE_END_TRANS_SCENE.NO  ",data.spriteID,data.coordX,data.coordY)
        end

        -- 这里如果放到后面来赋值，可能引起移除BUFF等需要spriteID的功能异常
        local masterData = RoleDataManager:getMaster()
        if masterData then
            local oldSpriteID = masterData:getSpriteID()
            masterData:updateNormal(data.spriteID,data.coordX,data.coordY,data.townChannelID)

            -- 处理主角的 spriteID 索引处理
            SkillDataManager:switchMasterSpriteID(oldSpriteID,data.spriteID)
            RoleDataManager:switchMasterSpriteID(oldSpriteID,data.spriteID)
            GoodsDataManager:switchMasterSpriteID(oldSpriteID,data.spriteID)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTORL_END_TRANS_SCENE, data)
        SceneManager:getInstance():pushCommand(command)

        -- 发起对时
        -- self:syncTimeRequest()
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_WAITING_BEGIN_SYNC, data)
        SceneManager:getInstance():pushCommand(command)
    -- 密室门打开
    elseif (no == NetMessageType.ROLE_CHAMBER_OPEN.NO) then
        if DEBUG then
            print("NetMessageType.ROLE_CHAMBER_OPEN.NO  ")
            dump(data)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_CHAMBER_OPEN,data)
        SceneManager:getInstance():pushCommand(command)
    -- 密室门解锁
    elseif (no == NetMessageType.ROLE_CHAMBER_ENTRANCE_UNLOCK.NO) then
        if DEBUG then
            print("NetMessageType.ROLE_CHAMBER_ENTRANCE_UNLOCK.NO  ")
            dump(data)
        end

        -- 处理密室门解锁事件
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_CHAMBER_ENTRANCE_UNLOCK,data)
        SceneManager:getInstance():pushCommand(command)
    -- 开始BOSS剧情
    elseif (no == NetMessageType.ROLE_BOSS_BEGIN_SCENARIO.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_BOSS_BEGIN_SCENARIO,data)
        SceneManager:getInstance():pushCommand(command)
    -- 结束BOSS剧情
    elseif (no == NetMessageType.ROLE_BOSS_END_SCENARIO.NO) then

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_BOSS_END_SCENARIO,data)
        SceneManager:getInstance():pushCommand(command)
    -- 同屏捏脸
    elseif (no == NetMessageType.ROLE_SCREEN_FACE_CHANGE.NO) then
        -- print("NetMessageType.ROLE_SCREEN_FACE_CHANGE")
        -- if(GameManager:getIsInNewScene() and GameManager:getIsInitNewTownTypeFlag()) then 
        --     return 
        -- end
        -- 处理脸型改变处理
        local heroData = RoleDataManager:handleScreenFaceChange(data)
        if(heroData) then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_SCREEN_FACE_CHANGE, heroData)
            SceneManager:getInstance():pushCommand(command)
        end
    -- 解锁 mode 和难度（gm 工具请求返回）
    elseif (no == NetMessageType.ROLE_UNLOCK_CAVE_MODE_DIFFCULTY.NO) then
        -- TODO 处理解锁难度
        -- print("ROLE_UNLOCK_CAVE_MODE_DIFFCULTY")
        -- dump(data)
        
        RoleDataManager:handleUnlockCaveDiffculty(data)
    -- 通知 解锁 mode 和难度 (游戏过程中解锁)
    elseif (no == NetMessageType.ROLE_NOTIFY_UNLOCK_CAVE_MODE_DIFFCULTY.NO) then
        -- 处理解锁难度
        if(DEBUG) then
            print("ROLE_NOTIFY_UNLOCK_CAVE_MODE_DIFFCULTY")
            dump(data)
        end

        RoleDataManager:handleNoticeUnlockCaveDiffculty(data)
    -- 处理解锁存档点
    elseif (no == NetMessageType.ROLE_NOTIFY_UNLOCK_CHECKPOINT.NO) then
        if(DEBUG) then
            print("ROLE_NOTIFY_UNLOCK_CHECKPOINT")
            dump(data)
        end
        RoleDataManager:handleNoticeUnlockCheckPoint(data)
    -- 对时
    elseif (no == NetMessageType.ROLE_SYNC_TIME_ANSWER.NO) then
        GameManager:syncTimeAnswer(data)
    elseif (no == NetMessageType.ROLE_SYNC_TIME_END.NO) then
        GameManager:syncTimeEnd(data)
    elseif (no == NetMessageType.ROLE_HERO_SET_STUDY_SKILL.NO) then
        -- if(DEBUG) then
            print("----ROLE_HERO_SET_STUDY_SKILL", data)
            -- dump(data)
        -- end
        RoleDataManager:setAdvanceStat(data.advancedStat)
        RoleDataManager:setRoleReincarnationLv(data.reincarnation)
        if not data.isAdd then
            SkillDataManager._skillGroupList = {}
            SkillDataManager:clearReplaceSkill()
        end

        -- 技能数据
        if(data.studySkills) then
            for k,v in pairs(data.studySkills) do
                SkillDataManager:refreshSkillTree(v)
            end
        end

        -- 恢复相关数据
        if(data.skillLvChanges) then 
            SkillDataManager:initSkillTreeChangeLv(data.skillLvChanges)
        end
        if(data.skillReplace) then 
            SkillDataManager:initSkillGroupIDArr(data.skillReplace)
        end

        if not data.isAdd then
            -- SkillDataManager:restoreClear()
            SkillDataManager:setCurSkillSelectType(data.label)
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_SELECT_TYPE_CHANGED)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_SKILL_POINT_RED_POINT)
        -- 刷新快捷栏，由于这里消息比技能添加晚
        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAG_CHANGE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_SHORTCUT_BAR_CHANGE)
    -- 技能等级修改
    elseif (no == NetMessageType.ROLE_NOTIFY_SKILL_CHANGE_LV_LIST.NO) then
        -- print("ROLE_NOTIFY_SKILL_CHANGE_LV_LIST", data)
        if(data.skillLvChanges) then 
            SkillDataManager:refreshSkillTrees(data.skillLvChanges)
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_SELECT_TYPE_CHANGED)
    elseif (no == NetMessageType.ROLE_FINISH_HERO_RESET_STUDY_SKILL.NO) then
        if(DEBUG) then
            print("ROLE_FINISH_HERO_RESET_STUDY_SKILL")
            dump(data)
        end
        if(data.result == "HeroResetStudySkillResultType_Succeed") then 
            MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.BAG_SKILL_RESET)
            SkillDataManager:resetSkillTree()    
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_RESET_STUDY_SKILL, data)
    elseif (no == NetMessageType.ROLE_RESPONSE_CODE_HERO_STUDY_SKILL.NO) then
        if(DEBUG) then
            print("ROLE_RESPONSE_CODE_HERO_STUDY_SKILL")
            dump(data)
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_STUDY_RESULT, data)
    --通知技能等级变化消息
    elseif (no == NetMessageType.ROLE_NOTICE_SKILL_LV_VARIATION.NO) then

    -- 玩家发送位置信息
    elseif (no == NetMessageType.ROLE_SEND_COORD_SIGNAL.NO) then
        Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SEND_SIGNAL, data.spriteID)
    -- 地图全开
    elseif (no == NetMessageType.ROLE_I_SEE_DEAD_PEOPLE.NO) then
        if(DEBUG) then
            printfmt("NetMessageType.ROLE_I_SEE_DEAD_PEOPLE")
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_ROLE_I_SEE_DEAD_PEOPLE,data)
        SceneManager:getInstance():pushCommand(command)

        Avalon.MessageCenter:notice(GameMessage.MC_MAP_SEE_DEAD_PEOPLE)
    -- 地图显示某些格子
    elseif (no == NetMessageType.ROLE_SHOW_MINI_MAP_ICON.NO) then
        if(DEBUG) then
            printfmt("NetMessageType.ROLE_SHOW_MINI_MAP_ICON")
        end

        -- 处理显示地图某些格子
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SHOW_MINI_MAP_ICON,data)
        SceneManager:getInstance():pushCommand(command)
    --触发怪物
    elseif (no == NetMessageType.ROLE_TRIGGER_MONSTER.NO) then
        if(DEBUG) then
            print("[Net.NetRoleSystem]  ROLE_TRIGGER_MONSTER ")
            dump(data)
        end

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_TRIGGER_MONSTER,data)
        SceneManager:getInstance():pushCommand(command)
    --通知客户端图鉴解锁
    elseif (no == NetMessageType.ROLE_POKEDEX_UNLOCK.NO) then
        if(DEBUG) then
            print("[Net.NetRoleSystem]  ROLE_POKEDEX_UNLOCK ")
        end

        MasterDataManager:insertPokedex(data.unlockPokedex)
    --图鉴存档数据
    elseif (no == NetMessageType.ROLE_POKEDEX_ARCHIVE.NO) then
        if(DEBUG) then
            print("@@@@[Net.NetRoleSystem]  ROLE_POKEDEX_ARCHIVE ")
        end
        -- dump(data)

        MasterDataManager:initPokedexList(data.unlockPokedex)
    --快捷表情 
    elseif (no == NetMessageType.ROLE_RECIVIVE_EXPRESSION.NO) then
        if(DEBUG) then
            print("[Net.NetRoleSystem]  ROLE_RECIVIVE_EXPRESSION ")
            dump(data)
        end

        local list = ConfigManager:getAllExpressionData()
        for k, value in ipairs(list) do
            if data.emoticonID == value.ID then
                local framentbgSpine   = UI.Animation:create()
                framentbgSpine:init(value.spine..".json", value.spine..".atlas")
                framentbgSpine:setAnimation("idle",false)
                framentbgSpine:center()
                framentbgSpine:addEventListener(UIEvent.ANIMATION_END,self,function()
                    framentbgSpine:destroy()
                end)
                GameManager:addExpressionCommand(framentbgSpine, data.targetSpriteID)

                Avalon.AudioManager:playSoundByConfig("26", value.ID)
                break
            end
        end
    --技能参数修改
    elseif (no == NetMessageType.ROLE_NOTICE_SKILL_VARIATION.NO) then
        -- TODO 处理相关的逻辑
        if(DEBUG) then
            print("ROLE_NOTICE_SKILL_VARIATION")
            dump(data)
        end

        MasterDataManager:handleSkillVariation(data)
    --开始或继续一个秘境阶段
    elseif (no == NetMessageType.ROLE_START_OR_RESUME_DUNGEON_STAGE.NO) then
        if(DEBUG) then
            print("ROLE_START_OR_RESUME_DUNGEON_STAGE")
            dump(data)
        end

        GameManager:setDungeonCountDown(data.stageRemainingTime)
    --完成一个秘境阶段
    elseif (no == NetMessageType.ROLE_COMPLETE_DUNGEON_STAGE.NO) then
        if(DEBUG) then
            print("ROLE_COMPLETE_DUNGEON_STAGE")
            dump(data)
        end

        -- GameManager:setDungeonCountDown(-1)
    -- 大秘境闯关领奖
    elseif (no == NetMessageType.DUNGEON_REQUEST_BATTLE_REWARD.NO) then
        if(DEBUG) then
            print("DUNGEON_REQUEST_BATTLE_REWARD")
            dump(data)
        end
        local FightResultUtil = require("app.ui.cave.fightResult.FightResultUtil")
        FightResultUtil:getInstance():setDungeonBattleReward(data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_DUNGEON_END_REWARD_SHOW,data)

        -- 如果是扫荡,则需要主动加载奖励界面
        if ProtobufUtil:checkFieldIsInit(data, "sweepCnt") and data.sweepCnt ~= 0 then
            Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SHOW_DUNGEON_SWEEP_REWARD, data)
        end
    --大秘籍赛季领奖
    elseif (no == NetMessageType.RECIVE_DUNGEON_SEASON_REWARD_REPONSE.NO) then
        if(DEBUG) then
            print("RECIVE_DUNGEON_SEASON_REWARD_REPONSE")
        end
        -- dump(data)

        local GameInDungeonManager = require "app.game.GameInDungeonManager"
        GameInDungeonManager:getInstance():reciveSeasonReward(data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CAN_RECIVE_SEASON_REWARD)
    --大秘境全量数据
    elseif (no == NetMessageType.NOTIFY_DUNGEON_SEASON_ALL_DATA.NO) then
        if(DEBUG) then
            print("NOTIFY_DUNGEON_SEASON_ALL_DATA")
        end

        if ProtobufUtil:checkFieldIsInit(data, "sweepCnt") then
            MasterDataManager:setSweepDungeonCnt(data.sweepCnt)
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_UPDATE_DUNGEON_SWEEP_NUM)
        end
        
        -- 可能仅仅作为刷新扫荡次数，故而其它数据不处理
        if not ProtobufUtil:checkFieldIsInit(data, "dungeonOpen") then
            printInfo("NOTIFY_DUNGEON_SEASON_ALL_DATA not dungeonOpen")
            return
        end
        -- dump(data, "NOTIFY_DUNGEON_SEASON_ALL_DATA")
        MasterDataManager:initDungeonSeasonData(data)

        -- 处理判断大秘境是开启还是关闭
        -- local currentSeasonData = MasterDataManager:getCurrentSeasonData()
        -- if(currentSeasonData == nil or currentSeasonData.open == false) then
        --     local masterData = RoleDataManager:getMaster()
        --     if(masterData) then
        --         -- 清理最大楼层数据
        --         masterData:clearMaxLevelData(PublicDefine.CAVE_MODE.MODE_DUNGEON, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        --     end
        -- end
        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CAN_RECIVE_SEASON_REWARD)
    -- 大秘籍赛季开关
    elseif (no == NetMessageType.NOTIFY_DUNGEON_SEASON_ENTRANCE_STATUS_DATA.NO) then
        if(DEBUG) then
            print("NOTIFY_DUNGEON_SEASON_ENTRANCE_STATUS_DATA")
            dump(data)
        end
        MasterDataManager:setDungeonEntranceOpen(data.open)
    -- 成就
    elseif (no == NetMessageType.ROLE_ACHIEVEMENT_DATA_UPDATE.NO) then
        if(DEBUG) then
            print("ROLE_ACHIEVEMENT_DATA_UPDATE")
        end
        local isInit = MasterDataManager:isAchevementDataInited()
        MasterDataManager:refreshAchevementData(data)
        if isInit then
            for idx, serverData in ipairs( data.achivevements or {} ) do
                local localData = MasterDataManager:getAchevementData(serverData.achievementId)
                local datadb = ConfigManager:getAchievement(serverData.achievementId)
                if datadb then
                    local isDoneAlready = localData.doneAlready
                    local current = checkint(serverData.count);
                    local stage = checkint(serverData.rewardStage) ;
                    local targetNum = 0;
                    local maxStage = table.nums(datadb.goal) 
                    
                    -- dump(datadb)
                    if stage < maxStage then
                        -- 要计数
                        if datadb.countType == 1 then
                            targetNum = datadb.goal[stage + 1];
                        else
                            targetNum = datadb.goal[1 ];
                        end
                        -- 达成目标 targetNum 不应该为nil 如果为nil肯定是数据异常
                        if current >= checkint(targetNum) and not isDoneAlready then
                            localData.doneAlready = true;
                            -- table.insert(complete,serverData)
                            -- print("+++++++++成就完成  ",serverData.achievementId,datadb.name)
                            local command = Command.ControlCommand:create(true)
                            local data = {}
                            data.id = serverData.achievementId;
                            data.text = datadb.name
                            command:initForTypeAndData(CommandType.CONTORL_FINISH_ACHIEVEMENT,data)
                            SceneManager:getInstance():pushCommand(command)
                        end
                    end
                end
                
            end
        end
        -- 通知刷新任务表现面板
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_NPC_TASK_REFRESH)
        SceneManager:getInstance():pushCommand(command)
    -- -- 趣味数据
    -- elseif (no == NetMessageType.ROLE_FUNNY_RECORD.NO) then
    --     -- TODO 处理趣味数据


    elseif no == NetMessageType.ROLE_ENTER_CAVE_SCENE_RESPONSE.NO then
        if(DEBUG) then
            print("ROLE_ENTER_CAVE_SCENE_RESPONSE",data.result)
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_LEVEL_SELECT_ENTER_CAVE, data)

        MasterDataManager:clearRepeatHandleDataForType(RepeatHandleType.DUNGEON_GUARD)
    elseif no == NetMessageType.ROLE_NOTIFY_UNLOCK_FUNCTION.NO then
        if(DEBUG) then
            dump(data, "------ROLE_NOTIFY_UNLOCK_FUNCTION")
        end
        for k, v in ipairs(data.unlockFunctionId) do
            RoleDataManager:addFunctionUnlock(v)            
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTORL_UNLOCK_FUNCTION, v)
            SceneManager:getInstance():pushCommand(command)
        end
        
        -- 解锁可能达到某些技能的解锁条件
        TaskDataManager:triggerAcceptTask()
        --新手引导数据
    elseif no == NetMessageType.ROLE_STORY_DATA_MESSAGE.NO then
        if(DEBUG) then
            dump(data, "------ROLE_STORY_DATA_MESSAGE")
        end
		local StoryManager = require("app.story.StoryManager")
		StoryManager:getInstance():initData(data.storyData)
    -- 角色系统错误
    elseif no == NetMessageType.ROLE_RESPONSE_SYSTEM_ERROR.NO then
        if(DEBUG) then
            print("NetMessageType.ROLE_RESPONSE_SYSTEM_ERROR.NO")
            dump(data)
        end
        if (data.requestType == NetMessageType.ROLE_REQUEST_HIDE_HELMET.NO) then
            -- TODO 处理隐藏头盔的错误处理
        elseif (data.requestType == NetMessageType.ROLE_DEAD_SELECTION.NO) then
            -- TODO 选择放弃复活的错误处理
        elseif (data.requestType == NetMessageType.ROLE_SEND_COORD_SIGNAL.NO) then
            -- 不做任何 提示 
        end
    -- 天气系统同步
    elseif no == NetMessageType.WITHER_SYSTEM_SYNC.NO then
        -- dump(data,"WITHER_SYSTEM_SYNC")
        SceneManager:setWeatherID(data.weatherID)
        if GameManager:getCustomHQ(CUSTOM_HQ_TYPE.WEATHER) then
            WeatherManager:getInstance():updateWeatherId(data.weatherID)
        end

    elseif no == NetMessageType.ROLE_NOTICE_SYSTEM_MSG.NO then   
        if(DEBUG) then
            print(" NetMessageType.ROLE_NOTICE_SYSTEM_MSG", data)     
        end
        self:_handleSystemMsg(data)

    elseif no == NetMessageType.ROLE_RESPONSE_CHANGE_TOWNCHANNEL.NO then        
        -- SC 回复改变城镇频道消息
        if(DEBUG) then
            print("ROLE_RESPONSE_CHANGE_TOWNCHANNEL", data)
        end

        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_CHANGE_TOWNCHANNEL, data)
    elseif no == NetMessageType.ROLE_DUNGEON_UNLOCK_TRANSDOOR.NO then   
        -- SC 大秘境传送门解锁
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_DUNGEON_UNLOCK_TRANSDOOR, data)
        SceneManager:getInstance():pushCommand(command)
    elseif no == NetMessageType.ROLE_DUNGEON_SUPPLEMENT_DURATION.NO then 
        -- print("ROLE_DUNGEON_SUPPLEMENT_DURATION", data)
        if(GameManager:getDungeonCountDown() > 0) then 
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(1230045))
        else 
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, LanguageManager:getInstance():getLocalString(1111294))
        end
    --特殊事件数据下发
    elseif no == NetMessageType.ROLE_RESPONSE_HERO_CAVE_DATA.NO then
        if data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
            MasterDataManager:refreshHeroCaveData(data)
        elseif data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            MasterDataManager:refreshTitanHeroCaveData(data)
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_CAVE_HREO_DATA_REFRESH, data)
    --刷新特殊事件响应
    elseif no == NetMessageType.ROLE_REFRESH_HERO_SPECIAL_EVENT_RESPONSE.NO then 
        --todo refresh ui
        -- dump(data, "------NetMessageType.ROLE_REFRESH_HERO_SPECIAL_EVENT_RESPONSE-------") 
        if ProtobufUtil:enum_id("RoleSystem.HeroCaveSchemeResult", "HeroCaveSchemeResult_Ok") ~= data.result then
            if data.refreshMode == PublicDefine.HeroCaveRefreshMode.HeroCaveRefreshMode_Manual then
                GameErrorManager:showError(data.result)
            end
            UI.WaitingLayer:hideWaiting()
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_CAVE_HREO_DATA_REFRESH, data)
        end
    elseif no == NetMessageType.ROLE_GEMSTONE_SHOP_RECORD_RESPONSE.NO then
        --todo
        print("  ROLE_GEMSTONE_SHOP_RECORD_RESPONSE ====== ",data)
        MasterDataManager:refreshGemstoneShopRecord(data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_ADVERT_STATUS)
    elseif no == NetMessageType.ROLE_HERO_TITLE_LIST.NO then
        require("app.datas.TitleDataManager")
        TitleDataManager:initNet(data.titleLists, data.isLoad, data.timeLimitTitles)
    elseif no == NetMessageType.ROLE_HERO_SKILL_CLOSED_MESSAGE.NO  then
        local skillData = SkillDataManager:getSkillDataForSkillID(data.skillID)
        if(skillData) then
            skillData:setIsOpening(false)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_SKILL_ISOPEN_STATUS, data.skillID)
        end
    elseif no == NetMessageType.ROLE_HERO_CHANGE_TITLE_RESPONSE.NO then
        if ProtobufUtil:enum_id("RoleSystem.ChangeHeroEquipTitleResult", "ChangeHeroEquipTitleResult_Suc") == data.result then
            -- 替换称号成功
            printInfo("NetRoleSystem, NetMessageType.ROLE_HERO_CHANGE_TITLE_RESPONSE.NO 称号替换成功.")
        elseif ProtobufUtil:enum_id("RoleSystem.ChangeHeroEquipTitleResult", "ChangeHeroEquipTitleResult_NoTitle") == data.result then
            -- 替换称号失败, 未拥有申请更改的称号
            printWarn("NetRoleSystem, NetMessageType.ROLE_HERO_CHANGE_TITLE_RESPONSE.NO 未拥有申请更改的称号.")
        elseif ProtobufUtil:enum_id("RoleSystem.ChangeHeroEquipTitleResult", "ChangeHeroEquipTitleResult_SystemErr") == data.result then
            -- 替换称号失败, 系统错误
            printWarn("NetRoleSystem, NetMessageType.ROLE_HERO_CHANGE_TITLE_RESPONSE.NO 称号更改失败或是选择同样称号.")
        else
            printWarn("NetRoleSystem, NetMessageType.ROLE_HERO_CHANGE_TITLE_RESPONSE.NO 返回未知结果.", data)
        end
    elseif no == NetMessageType.ROLE_NOTIFY_ROLE_TALENT_LIST.NO then
        local list = data.talents or {}
        MasterDataManager:initRoleTalent(list)
    elseif no == NetMessageType.ROLE_ADD_ROLE_TALENT_REQ.NO then
        if data.result == ProtobufUtil:enum_id("RoleSystem.AddRoleTalentResult", "AddRoleTalentResult_Suc") then
            MasterDataManager:addRoleTalent(data.id, data.addNum)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_ROLE_TALENT, data.id, false)
        else
            GameErrorManager:showError(data.result)
        end
        UI.WaitingLayer:hideWaiting()
    elseif no == NetMessageType.ROLE_UPGRADE_ROLE_TALENT_REQ.NO then
        if data.result == ProtobufUtil:enum_id("RoleSystem.UpgradeRoleTalentResult", "UpgradeRoleTalentResult_Suc") then
            MasterDataManager:upgradeRoleTalent(data.id)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_ROLE_TALENT, data.id, true)
            UI.ScrollBar:createByText(UI.TEXT_1212214)
        else
            GameErrorManager:showError(data.result)
        end
        UI.WaitingLayer:hideWaiting()

    elseif no == NetMessageType.ROLE_CS_WORLD_BOSS_INFO.NO then
        if(ProtobufUtil:checkFieldIsInit(data, "damgeMsg")) then 
            local dataArr = GameDataManager:getInstance():handleDSPData(data.damgeMsg) 
            -- 发送消息刷新界面
            if(dataArr) then 
                Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_DSP, dataArr)
            end

            if mvc.worldBossModel then
                mvc.worldBossModel:handleFightMyRank(dataArr)
            end
        end

        if(ProtobufUtil:checkFieldIsInit(data, "settleMsg")) then
            local settleMsg = data.settleMsg
            local damageInfos = settleMsg.damageInfos
            local heroInfos = {}
            for i = 1, #damageInfos do
                local serverHeroInfo = damageInfos[i].heroInfo
                local heroData = Data.HeroData:create()
                heroData:changeInit(serverHeroInfo)
                heroData:setSex(serverHeroInfo.sex)

                local detailData = {}
                detailData.heroData = heroData

                -- 处理穿戴装备信息
                local equipmentsData = {}
                local equipments = serverHeroInfo.equipShow
    
                for _,v in ipairs(equipments) do
                    local goodsInfo = {
                        templateID = v.templateID,
                        index = v.index,
                        illusionID = v.illusionID,
                    }
                    local goodsData = Goods.EquipmentData:create(goodsInfo.templateID)
                    goodsData:initNetData(goodsInfo,1,nil,nil,goodsInfo.index)
                    table.insert(equipmentsData, goodsData)
                end
                detailData.wearEquipmentArr = equipmentsData

                table.insert(heroInfos,{heroData = detailData, name = damageInfos[i].name, damage = damageInfos[i].damage})
            end
            mvc.closePanel("WorldBoss", "WorldBossDieResult")
            mvc.openPanel("WorldBoss", "WorldBossWinResult",
                {iskilledBoss = settleMsg.iskilledBoss,finalKiller = settleMsg.finalKiller, infos = heroInfos})
        end

        if(ProtobufUtil:checkFieldIsInit(data, "startMsg")) then
            local startMsg = data.startMsg
            if mvc.worldBossModel then
                mvc.worldBossModel:setStartCDTime(startMsg.startTime)
            end
        end
        

    elseif no == NetMessageType.ROLE_NTF_ACTIVITY_BOSS_INFO.NO then
        -- print("ROLE_NTF_ACTIVITY_BOSS_INFO", data)
        -- 处理伤害值
        if(ProtobufUtil:checkFieldIsInit(data, "ntfDamageInfos")) then 
            local dataArr = GameDataManager:getInstance():handleDSPData(data.ntfDamageInfos) 
            -- 发送消息刷新界面
            if(dataArr) then 
                Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_DSP, dataArr)
            end
        end

        --处理结算数据信息
        if(ProtobufUtil:checkFieldIsInit(data, "ntfSettle")) then 
            GameDataManager:getInstance():setActivityRankData(data.ntfSettle)
        end

        -- 处理刷新怪物的时间
        if(ProtobufUtil:checkFieldIsInit(data, "ntfUpdateMonster")) then 
            GameDataManager:getInstance():handleUpdateMonsterData(data.ntfUpdateMonster)
        end
    elseif no == NetMessageType.ROLE_BUFF_REMAIN_TIME.NO then
        -- print("NetMessageType.ROLE_BUFF_REMAIN_TIME.NO", data)
        -- 处理BUFF的时间压缩处理
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_REMAIN_BUFF, data)
        SceneManager:getInstance():pushCommand(command)

    elseif no == NetMessageType.ROLE_CLIENT_HERO_ANSWERDATA_MESSAGE.NO then
        require "app.datas.AnswerDataManager"
        AnswerDataManager:initNetData(data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_JUMP_LAYER_ANSWER, data)
    elseif no == NetMessageType.ROLE_CLIENT_RESPONSE_ANSWER_MESSAGE.NO then
        require "app.datas.AnswerDataManager"
        AnswerDataManager:answerResponse(data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_JUMP_LAYER_ANSWER_REP, data)

    elseif no == NetMessageType.HERO_FIGHT_SKILLS_MESSAGE.NO then
        UI.WaitingLayer:hideWaiting()
        if data.isInit then
            SkillDataManager:initBattleSkillConfigFromServer(data)
        else
            SkillDataManager:addBattleSkillConfigFromServer(data)
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_SET_FIGHT_RESULT)
    elseif no == NetMessageType.HERO_FIGHT_SKILLS_RES_SET_MESSAGE.NO then
        
    elseif no == NetMessageType.NEED_USER_CONFIG_FIGHTING_SKILL.NO then

        Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_ACTIVE_STUDY_RESULT)
    elseif no == NetMessageType.LITTLE_BOSS_SEAL_INFO_MESSAGE.NO then
        if data.wakeScore <= 0 then
            return
        end
        local old = MasterDataManager:setLittleBossInfoCache(data)

        local isUpdated = false
        if old and old.curScore then
            if old.curScore < data.curScore and data.curScore >= data.wakeScore then
                isUpdated = true
            end
        else
            isUpdated = true
        end

        if isUpdated then
            local MachineManager = require("app.game.MachineManager")
            if not MachineManager:getInstance() then
                return
            end
            if not MachineManager:getInstance():getMachine() then
                return
            end
            local battleModel = MachineManager:getInstance():getMachine():getModel()
            local role = battleModel:getRoleBySpriteID(data.spriteID)
            if role then
                local command = Command.RendererCommand:create(true)
                command:initBossSealInfoUpdate(role:getId())
                SceneManager:getInstance():pushCommand(command)
            end
        end
        
        Avalon.MessageCenter:notice(AvalonMessage.MC_LITTLE_BOSS_SEAL_INFO,  isUpdated)
    elseif no == NetMessageType.ROLE_RSP_DREAM_INFO.NO then
        MasterDataManager:initDreamData(data.dbData)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_ALL_DREAM_INFO)
    elseif no == NetMessageType.ROLE_RSP_REFRESH_DREAM_BUF.NO then
        UI.WaitingLayer:hideWaiting()
        if data.errorNo == "DreamErroNo_OK" then
            -- print("----------NetMessageType.ROLE_RSP_REFRESH_DREAM_BUF.---------", data)
            MasterDataManager:refreshCurBossBuff(data.bufferIDs, data.dreamType == 1)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_SINGLE_DREAM_BUFF)
        else
            GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.DreamErroNo", data.errorNo))
        end
    elseif no == NetMessageType.ROLE_NTF_DREAM_SETTLE.NO then
        if (ProtobufUtil:checkFieldIsInit(data, "settle")) then
            local settleData = data.settle

            if settleData.dreamType == 1 then
                MasterDataManager:setJumpTempData(settleData)
            else
                MasterDataManager:setKilledBossIdx(MasterDataManager:getDreamProgress())
                MasterDataManager:setDreamProgress(settleData.dreamCurBossIndex)
                MasterDataManager:setDreamResultChip(settleData.dreamChip)
                MasterDataManager:setDreamResultLv(settleData.dreamLv)
            end
        end
    elseif no == NetMessageType.ROLE_CLEAR_LEVEL_POINT.NO then

        RoleDataManager:handleClearLevelOrPoint(data)
    elseif no == NetMessageType.ROLE_NOTICE_ALL_BUFF_ID.NO then
        -- print("ROLE_NOTICE_ALL_BUFF_ID", data)

        SkillDataManager:handleSyncAllBuffID(RoleDataManager:getMasterSpriteID(), data.buffEntityID)
    elseif no == NetMessageType.ROLE_NOTICE_FUNCTIONLOCK.NO then
        -- print("ROLE_NOTICE_FUNCTIONLOCK", data)
        for k, v in ipairs(data.lockFunctionId) do
            RoleDataManager:addFunctionLock(v)
        end
    elseif no == NetMessageType.ROLE_PICKUP_DREAM_TASK.NO then
        if ProtobufUtil:enum_id("RoleSystem.PickUpDreamAnswerResult", "PickUpDreamAnswerResult_OK") ~= data.result then
            GameErrorManager:showError(data.result)
        else
            MasterDataManager:setDreamTaskState(data.index + 1, PublicDefine.DreamTaskState.State_Recieved)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_DREAM_TASK_STATE)
            UI.ScrollBar:createByText(UI.TEXT_1212253)
        end
    elseif no == NetMessageType.ROLE_NOTIFY_DREAM_TASK_STAT.NO then
        -- print("----ROLE_NOTIFY_DREAM_TASK_STAT-----", data)
        MasterDataManager:setDreamTaskState(data.index + 1, data.stat)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_DREAM_TASK_STATE)

    elseif no == NetMessageType.ROLE_NOTICE_CAVE_INDEX.NO then
        local masterData = RoleDataManager:getMaster()
        -- print("NetMessageType.ROLE_NOTICE_CAVE_INDEX", data)
        if(masterData) then 
            masterData:updateCaveIndex(data.caveIndex)
        end
    elseif no == NetMessageType.RESPONSE_GET_PAY_MONEY_MESSAGE.NO then
        MasterDataManager:setPayMoneyCount(data.money)
        local masterData = RoleDataManager:getMaster()
        if(masterData) then 
            masterData:setLastPurchaseTime(data.lastPurchaseTime)
        end
    elseif no == NetMessageType.ROLE_HORCURX_GET_INFO_RES.NO then
        require "app.ui.baglayer.Horcurx.HorcurxDataManager"
        HorcurxDataManager:initHorcurxNet(data)
    elseif no == NetMessageType.ROLE_HORCURX_LV_UP_RES.NO then
        local isSucc = self:_handleHorcurxSystemMsg(data)
        if not isSucc then
            return
        end
        HorcurxDataManager:updateHorcurxLvUpNet(data)
    elseif no == NetMessageType.ROLE_HORCURX_EVOLUTION_RES.NO then
        local isSucc = self:_handleHorcurxSystemMsg(data)
        if not isSucc then
            return
        end
        HorcurxDataManager:updateHorcurxEvolutionUpNet(data)
    elseif no == NetMessageType.ROLE_HORCURX_SET_EXTERIOR_RES.NO then
        local isSucc = self:_handleHorcurxSystemMsg(data)
        if not isSucc then
            return
        end
        HorcurxDataManager:updateHorcurxSetEquipHorcurxNet(data)
    elseif no == NetMessageType.ROLE_NOTICE_SCREEN_HORCURX_SET_EXTERIOR_REQ.NO then
        RoleDataManager:handleScreenHorcrux(data)
    elseif no == NetMessageType.ROLE_TARGET_GET_REWARD_RESP.NO then
        -- print("NetMessageType.ROLE_TARGET_GET_REWARD_RESP", data)
        if (data.result == 1) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111430))
            mvc.sevenDaysModel:updateActivityFinish(data)
            mvc.festivalSignModel:updateActivityFinish(data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, data)
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_REFRESH_SEVEN_DAY, data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111118))
        end
    elseif no == NetMessageType.ROLE_RESP_TARGET_SIGN_IN.NO then
        -- print("NetMessageType.ROLE_RESP_TARGET_SIGN_IN", data)
        UI.WaitingLayer:hideWaiting()
        if (data.result == 1) then
            -- UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111430))
            mvc.sevenDaysModel:updateActivityFinish(data)
            mvc.festivalSignModel:updateActivityFinish(data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_SEVEN_DAY_GET_REWARD, data)
            -- Avalon.MessageCenter:notice(AvalonMessage.MC_REFRESH_SEVEN_DAY, data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111118))
        end
    elseif no == NetMessageType.ROLE_TARGET_HERO_TARGETS.NO then
        mvc.sevenDaysModel:initNet(data.totalTargets)
        mvc.festivalSignModel:initNet(data.totalTargets)
    elseif no == NetMessageType.ROLE_TARGET_CHANGE.NO then
        if data.changeTargets and data.changeTargets[1] and data.changeTargets[1].targetID == FALL_FESTIVAL_SIGN or data.changeTargets[1].targetID == FALL_FESTIVAL_TASK then
            mvc.festivalSignModel:updateActivityStats(data.changeTargets)
        else
            mvc.sevenDaysModel:updateActivityStats(data.changeTargets)
            
        end
        
        if data.changeTargets and data.changeTargets[1] and data.changeTargets[1].targetID ~= FALL_FESTIVAL_SIGN then
            Avalon.MessageCenter:notice(AvalonMessage.MC_SEVEN_DAY_TARGET_CHANGE, data.changeTargets)
        end
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_REFRESH_SEVEN_DAY)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)

    elseif no == NetMessageType.ROLE_PUSH_TREASURE_DATA_RESPONSE.NO then
        -- print("NetMessageType.ROLE_PUSH_TREASURE_DATA_RESPONSE", data)
        if mvc and mvc.limitTimePackageModel then
            mvc.limitTimePackageModel:setNetData(data)
        end
        -- 新的每日超值礼包数据添加在此处
        if ProtobufUtil:checkFieldIsInit(data, "data") then
            mvc.tradeActivityModel:setDailyGiftData(data.data)
        end
    elseif no == NetMessageType.RESPONSE_ACTIVITY_GROW_FUND_GET_AWARDS.NO then
        -- print("NetMessageType.RESPONSE_ACTIVITY_GROW_FUND_GET_AWARDS", data)
        UI.WaitingLayer:hideWaiting()

        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            UI.ScrollBar:createByText(UI.TEXT_1170002)
            return
        end

        mvc.tradeActivityModel:setGrowFundGotList(data.claimData,false,data.id)


    elseif no == NetMessageType.RESPONSE_ACTIVITY_TARGET_DATA.NO then
        -- print("NetMessageType.RESPONSE_ACTIVITY_TARGET_DATA", data)

        mvc.tradeActivityModel:initNetActivityTarget(data.data.groups)

    elseif no == NetMessageType.RESPONSE_ACTIVITY_TARGET_GET_REWARD.NO then
        -- print("NetMessageType.RESPONSE_ACTIVITY_TARGET_GET_REWARD", data)

        if ProtobufUtil:checkFieldIsInit(data, "result") and data.result ~= PublicDefine.ErrNo.ErrNo_Ok then
            -- UI.ScrollBar:createByText(UI.TEXT_1170002)
            GameErrorManager:showError(data.result)
            return
        end

        mvc.tradeActivityModel:setActivityTarget(data.targetData, data.groupId)

    elseif no == NetMessageType.RESPONSE_ACTIVITY_TARGET_UPDATE.NO then
        -- print("NetMessageType.RESPONSE_ACTIVITY_TARGET_UPDATE", data)

        mvc.tradeActivityModel:setActivityTarget(data.targetData, data.groupId)

    elseif no == NetMessageType.RESPONSE_ROLE_TRADE_ACTIVITY_DATA.NO then
        -- print("NetMessageType.RESPONSE_ROLE_TRADE_ACTIVITY_DATA", data)

        mvc.tradeActivityModel:setNetData(data)

    elseif no == NetMessageType.ROLE_ALL_ADVER_DATA.NO then
        GameDataManager:getInstance():setAdvertData(data)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_ADVERT_STATUS)

    elseif no == NetMessageType.ROLE_WORLDBOSS_BUY_BUFF_RESPONSE.NO then
        -- print("NetMessageType.ROLE_WORLDBOSS_BUY_BUFF_RESPONSE", data)
        if data.ret == "WorldBossResult_OK" then
            UI.ScrollBar:createByText(UI.TEXT_1212019)
        else
            local textStr = LanguageManager:getInstance():getLocalString(1111101)
            UI.ScrollBar:createByText(textStr)
        end

        UI.WaitingLayer:hideWaiting()
    
    elseif no == NetMessageType.ROLE_WORLDBOSS_DATA_INIT.NO then
        -- print(data)
        -- print(data)
        -- print(data)
        mvc.worldBossModel:initBossDataFromNet(data)

    elseif no == NetMessageType.ROLE_CHANGE_DREAM_LV_RESPONSE.NO then
        UI.WaitingLayer:hideWaiting()
        if "DreamErroNo_OK" ~= data.errorNo then
            GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.DreamErroNo", data.errorNo))
        else
            MasterDataManager:backCurDreamLv()
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_ALL_DREAM_INFO)
        end
    elseif no == NetMessageType.ROLE_DAILY_ACTION_INFO.NO then
        mvc.send(mvc.events.ActivityPoint_Role_Daily_Action_Info, data)
    elseif no == NetMessageType.ROLE_DAILY_ACTION_REWARD_RESPONSE.NO then
        mvc.send(mvc.events.ActivityPoint_Role_Daily_Action_Reward_Result_Message, data)
    elseif no == NetMessageType.ROLE_NOTIFY_DISTORTED_SPACE_INFO.NO then
        -- print("----NetMessageType.ROLE_NOTIFY_DISTORTED_SPACE_INFO----", data.levelData)
        MasterDataManager:refreshSpaceFightCount(data.levelData)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_SPACE_HERO_FIGHT_COUNT)
    elseif no == NetMessageType.ROLE_NOTIFY_MAZE_INFO.NO then
        -- print("----NetMessageType.ROLE_NOTIFY_MAZE_INFO----", data)
        if(ProtobufUtil:checkFieldIsInit(data, "startMsg")) then 
            local startMsg = data.startMsg
            if mvc.festivalModel then
                mvc.festivalModel:setStartCDTime(startMsg.sceneBornTime)

                mvc.festivalModel:handleHeroSimple(startMsg.hero)
            end
        elseif(ProtobufUtil:checkFieldIsInit(data, "settleMsg")) then 
            mvc.festivalModel:clearMazeName()

            -- 结算数据
            local settleMsg = data.settleMsg
            local heroInfo = settleMsg.hero
            local award = settleMsg.award
            local heroInfos = {}
            for i = 1, #heroInfo do
                local serverHeroInfo = heroInfo[i].hero
                local heroData = Data.HeroData:create()
                heroData:changeInit(serverHeroInfo)
                heroData:setSex(serverHeroInfo.sex)

                local detailData = {}
                detailData.heroData = heroData

                -- 处理穿戴装备信息
                local equipmentsData = {}
                local equipments = serverHeroInfo.equipShow
    
                for _,v in ipairs(equipments) do
                    local goodsInfo = {
                        templateID = v.templateID,
                        index = v.index,
                        illusionID = v.illusionID,
                    }
                    local goodsData = Goods.EquipmentData:create(goodsInfo.templateID)
                    goodsData:initNetData(goodsInfo,1,nil,nil,goodsInfo.index)
                    table.insert(equipmentsData, goodsData)
                end
                detailData.wearEquipmentArr = equipmentsData

                table.insert(heroInfos,{heroData = detailData, name = serverHeroInfo.nickName, damage = heroInfo[i].usedTime})
            end
            -- 同步相关数据
            local useTime = settleMsg.usedTime
            -- local useTime = 1000
            local sendData = {rank = settleMsg.rank, oldHighRank = settleMsg.oldHighRank, useTime = useTime, award = award, infos = heroInfos}
            -- print("sendData", sendData)
            if(not SceneManager:getInstance():getIsInLoading()) then
                mvc.festivalModel:setMazeRewardFlag(true)
                mvc.openPanel("Festival", "FestivalReward",
                    sendData)
            end
        elseif(ProtobufUtil:checkFieldIsInit(data, "pointMsg")) then 
            -- 进入场景后的额外断点信息
            MasterDataManager:handleMazePoint(data.pointMsg)
        elseif(ProtobufUtil:checkFieldIsInit(data, "announceMsg")) then 
            -- 信息通告
            local announceMsg = data.announceMsg
            -- UI.TEXT_1213007 = "%s历经千辛万苦，抵达终点"
            -- UI.TEXT_1213008 = "%s踩中了你的陷阱，被传送回出生点"
            -- UI.TEXT_1213009 = "你踩中了%s的陷阱，被传送回出生点"
            -- UI.TEXT_1213010 = "你获得了一个%s"
            -- UI.TEXT_1213011 = "道具拥有数量达到上限"
            -- UI.TEXT_1213012 = "你触发了传送阵，被传送至出生点"
            -- UI.TEXT_1213013 = "你触发了传送阵，被传送至随机位置"
            if(announceMsg.type == "MazeAnnounceType_ToEnd") then 
                UI.ScrollBar:createByText(string.format(UI.TEXT_1213007, announceMsg.nick))
            elseif (announceMsg.type == "MazeAnnounceType_OtherTriggerTrap") then
                UI.ScrollBar:createByText(string.format(UI.TEXT_1213008, announceMsg.nick))
            elseif (announceMsg.type == "MazeAnnounceType_SelfTriggerTrap") then
                UI.ScrollBar:createByText(string.format(UI.TEXT_1213009, announceMsg.nick))
            elseif (announceMsg.type == "MazeAnnounceType_SelfTriggerSysBirth") then
                UI.ScrollBar:createByText(UI.TEXT_1213012)
            elseif (announceMsg.type == "MazeAnnounceType_SelfTriggerSysRand") then
                UI.ScrollBar:createByText(UI.TEXT_1213013)
            elseif (announceMsg.type == "MazeAnnounceType_PacketFull") then
                UI.ScrollBar:createByText(UI.TEXT_1213011)
            end
        end
    elseif no == NetMessageType.ROLE_NOTIFY_FIRST_PASS_ALL_DATA.NO then--推送首通奖励 全量数据
        print("--NetMessageType.ROLE_NOTIFY_FIRST_PASS_ALL_DATA--data-----", data)  
        MasterDataManager:initFirstPassData(data.rewardList)
    elseif no == NetMessageType.ROLE_RSP_GET_FIRST_PASS_REWARD.NO then--首通奖励领奖响应    
        print("--NetMessageType.ROLE_RSP_GET_FIRST_PASS_REWARD--data-----", data)  
        UI.WaitingLayer:hideWaiting()
        if data.result == ProtobufUtil:enum_id("RoleSystem.CaveFirstPassRewardResult", "CaveFirstPassRewardResult_Succeed") then
            MasterDataManager:refreshFirstPassData(data.mode, data.diff, data.rewardData)
            local refreshData = {}
            refreshData.mode = data.mode
            refreshData.diff = data.diff
            refreshData.index = data.index
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FIRST_PASS, refreshData)
        else
            GameErrorManager:showError(data.result)
        end
    elseif no == NetMessageType.ROLE_NOTICE_QUICK_DOWN.NO then
        -- print("ROLE_NOTICE_QUICK_DOWN", data)
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_QUICK_DOWN, data)
        SceneManager:getInstance():pushCommand(command)
    elseif no == NetMessageType.ROLE_SKILL_GROUNP_SELECT_RES.NO then
        UI.WaitingLayer:hideWaiting()
        if data.result ~= 1 then
            UI.ScrollBar:createByText(UI.TEXT_1213217)
        end
    elseif no == NetMessageType.ROLE_GREEDY_SELECT_REP.NO then
        UI.WaitingLayer:hideWaiting()
        if data.err == "ErrNo_LevelIsLow" then
            local level, reinLv = RoleDataManager:getUIShowLvByItemData(data.extra)
            local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
            local errorText = string.format(UI.TEXT_224405, showLv)
            UI.ScrollBar:createByText(errorText)
        end
    elseif no == NetMessageType.ROLE_SYNC_HERO_CAVE_STAGE_MAX_LEVEL.NO then
        -- print("ROLE_SYNC_HERO_CAVE_STAGE_MAX_LEVEL", data)
        RoleDataManager:handleUpdateHeroStageMaxLevel(data.levels)
    elseif no == NetMessageType.ROLE_SYNC_SPECIAL_OFFER_PACK.NO then
        -- print("ROLE_SYNC_SPECIAL_OFFER_PACK", data)
        MasterDataManager:setSpecialOfferIndex(data.specialOfferIndex)
        Avalon.MessageCenter:notice(AvalonMessage.MC_SDK_PURCHASE_SUCC) 
    elseif no == NetMessageType.ROLE_RSP_SWITCH_SKILL.NO then
        UI.WaitingLayer:hideWaiting()
        if data.err == "ErrNo_Ok" then
            SkillDataManager:switchSkillGroup(data.skillGID, data.removeSkillGID)
            Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_SWITCH_GROUP, data.skillGID, data.removeSkillGID)
        else
            UI.ScrollBar:createByTextID(1170002)
        end
    elseif no == NetMessageType.ROLE_NTF_LOCK_SHADOW_SKILL.NO then
        print("--ROLE_NTF_LOCK_SHADOW_SKILL---", data)
        if table.nums(data.lockAllSkillIDs) > 0 then
            SkillDataManager:initShadowSkill(data.lockAllSkillIDs) --全量数据
        end
        if data.lockSkillID > 0 then
            SkillDataManager:addShadowSkill(data.lockSkillID)--增量数据
            Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REFRESH_SHADOW_LOCK, data.lockSkillID)
        end
    elseif no == NetMessageType.ROLE_NTF_MARK_LOCK_SKILL.NO then
        print("--ROLE_NTF_MARK_LOCK_SKILL---", data)
        if ProtobufUtil:checkFieldIsInit(data, "allIDs") and table.nums(data.allIDs) > 0 then
            SkillDataManager:initNtfMarkSkill(data.allIDs) --全量数据
        end
        if ProtobufUtil:checkFieldIsInit(data, "addID") and data.addID > 0 then
            SkillDataManager:addNtfMarkSkill(data.addID)--增量数据
        end
        if ProtobufUtil:checkFieldIsInit(data, "delID") and data.delID > 0 then
            SkillDataManager:clearNtfMarkSkill(data.delID)--减量数据
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REFRESH_SKILL_MARK_LOCK, data)

    elseif no == NetMessageType.ROLE_NOTICE_FIGHT_FREEZE.NO then
        print("ROLE_NOTICE_FIGHT_FREEZE", data)

        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SCENE_PAUSEORRESUME_STATUS, data)
        SceneManager:getInstance():pushCommand(command)

    elseif no == NetMessageType.ROLE_REQ_STORE_BUY_GOODS.NO then
        print("ROLE_REQ_STORE_BUY_GOODS", data)

        if data.result == PublicDefine.ErrNo.ErrNo_Ok and data.storeType and data.storeType == PublicDefine.StoreType.StoreType_Primoge then
            mvc.send("PrimogemShop_Exchange_Success", data)
        end

        mvc.send("PetTreasure_RecyclingShop_Handle_GoodsRecycle", data)

        Avalon.MessageCenter:notice(GameMessage.MC_FIGHT_BACK_SHOP,data)
    elseif no == NetMessageType.ROLE_CLAIM_DEEPLINK_AWARD.NO then
        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, nil, UI.RewardType.REWARD_DEEPLINK)
    elseif no == NetMessageType.ROLE_RSP_SWEEP_DISTORTEDSPACE.NO then
        --print("ROLE_RSP_SWEEP_DISTORTEDSPACE", data)
        -- 扭曲扫荡结果
        if(data.err == PublicDefine.ErrNo.ErrNo_Ok) then
            if(data.caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO) then 
                mvc.caveModel:setInfernoSweepNum(data.sweepCnt)
                Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SWEEP_INFERNO_RESPONSE)
            elseif(data.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT) then 
                mvc.caveModel:setVoidRiftSweepNum(data.sweepCnt)
                Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SWEEP_VOIDRIFT_RESPONSE)
            elseif(data.caveMode == PublicDefine.CAVE_MODE.MODE_VIKING) then 
                mvc.viKingModel:setViKingSweepNum(data.sweepCnt)
                Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SWEEP_VIKING_RESPONSE)
            elseif(data.caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS) then 
                mvc.ChaosWormholeModel:setChaosWormholeSweepNum(data.sweepCnt)
                Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SWEEP_CHAOS_RESPONSE)
            else
                MasterDataManager:setSweepDistortedSpaceNum(data.sweepCnt)
            end

            local FightResultUtil = require("app.ui.cave.fightResult.FightResultUtil")
            FightResultUtil:getInstance():setSweepReward(data)
            Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REWARD, nil, UI.RewardType.REWARD_SWEEP)

            Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SWEEP_DISTOREDSPACE_RESPONSE)
        else
            GameErrorManager:showError(data.err)
        end
        UI.WaitingLayer:hideWaiting()
    elseif no == NetMessageType.ROLE_NTF_SWEEP_DISTORTEDSPACE.NO then
        --print("ROLE_NTF_SWEEP_DISTORTEDSPACE", data)
        MasterDataManager:setSweepDistortedSpaceNum(data.sweepCnt)
        Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SWEEP_DISTOREDSPACE_RESPONSE)
    elseif no == NetMessageType.ROLE_MIRACLE_RESP_PRAYER.NO then
        print("ROLE_MIRACLE_RESP_PRAYER", data)
        -- SC 神迹祈祷返回
        mvc.send(mvc.events.Miracle_ResponsePrayer, data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_NEW_CITY_REDPOINT)
    elseif no == NetMessageType.ROLE_SYNC_MIRACLE_PRAYER.NO then
        print("ROLE_SYNC_MIRACLE_PRAYER",data)
        -- SC 神迹祈祷数据同步
        mvc.miracleModel:hanldePrayerData(data.data)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_REFRESH_NEW_CITY_REDPOINT)
    elseif no == NetMessageType.ROLE_SYNC_INFERNO_INFO.NO then
        print("ROLE_SYNC_INFERNO_INFO",data)
        mvc.caveModel:handleInfernoIfo(data)

        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_SWEEP_INFERNO_RESPONSE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_INFERNO_FIGHT_COUNT)
    elseif no == NetMessageType.ROLE_SYNC_INFERNO_RUNE.NO then
        -- SC 同步炼狱宝石数据
        print("ROLE_SYNC_INFERNO_RUNE", data)
        mvc.caveModel:handleInfernoRune(data.runeData)

        if(not SceneManager:getInstance():getIsInLoading()) then
            local waitingInfernoRune = mvc.caveModel:getInfernoDiamondRandom()
            if(waitingInfernoRune and #waitingInfernoRune > 0)then 
                mvc.openPanel("Cave", "InfernoSelect")
            end
        end
    elseif no == NetMessageType.ROLE_RESP_SELECT_INFERNO_RUNE.NO then
        print("ROLE_RESP_SELECT_INFERNO_RUNE", data)
        UI.WaitingLayer:hideWaiting()
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
            GameErrorManager:showError(data.result)
        else
            -- mvc.caveModel:clearRandomLegacyArr()
            mvc.closePanel("Cave", "InfernoSelect")
        end
    elseif no == NetMessageType.ROLE_SYNC_GhostAbyssSceneInfo.NO then
        -- 同步幽灵深渊信息
        if SceneManager:getInstance():getIsInLoading() then
            local command = Command.ControlCommand:create(true)
            command:initForTypeAndData(CommandType.CONTROL_GHOSTABYSS_NOTIFY, data)
            local SceneManager = require('app.game.SceneManager')
            SceneManager:getInstance():pushCommand(command)
        else
            mvc.caveModel:handleGhostAbyssSceneInfoData(data)
        end
    --         required uint32 status = 1;                             // 当前场景阶段（见GhostAbyssStatus）
    -- repeated GhostAbyssTotemData totems = 2;                // 图腾信息
    -- optional bool isDouble = 3;                             // 双倍挑战
    -- optional uint32 hpRatio = 4;                            // BOSS扣减血量比（刷怪阶段）
    elseif no == NetMessageType.ROLE_NOTIFY_GhostAbyssAwards.NO then
        -- 通知幽灵深渊奖励信息
        mvc.caveModel:handleGhostEndReward(data)
    elseif no == NetMessageType.ROLE_RESP_ExchangeGhostAbyssGoods.NO then
        -- 幽灵深渊材料兑换
        UI.WaitingLayer:hideWaiting()
        if(data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
        else
            mvc.send(mvc.events.GhostabyssShopExchangeResponse, data)
        end

        -- mvc.closePanel("Cave", "InfernoSelect")
        -- SC 选择炼狱宝石返回
        -- message RespSelectInfernoRuneMessage
        -- {
        --     required uint32 selectedIndex = 1;
        --     required uint32 result = 2;                             // PublicDefine.ErrNo
        --     optional uint32 runeId = 3;                             // 宝石ID
        -- }
    elseif no == NetMessageType.ROLE_RESP_MERCENARY_LIST.NO then
        -- print("ROLE_RESP_MERCENARY_LIST", data)
        -- OC 返回佣兵列表信息
        if(data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            mvc.mercenaryModel:handleMercenaryList(data)
        else
            GameErrorManager:showError(data.result)
        end
    -- elseif no == NetMessageType.ROLE_RESP_ENTER_MERCENARY_CAVE.NO then
    --     print("ROLE_RESP_ENTER_MERCENARY_CAVE", data)
    --     -- OS SC 带佣兵下洞返回
    --     if(data and data.result ~= ProtobufUtil:enum_id("RoleSystem.EnterCaveSceneResult","EnterCaveSceneResult_Succeed")) then 
    --         GameErrorManager:showError(data.result)
    --     end
    --     UI.WaitingLayer:hideWaiting()
    elseif no == NetMessageType.ROLE_RESP_SyncPlayerDecorateMessage.NO then
        local masterData = RoleDataManager:getMaster()
        -- print( " 同步 2222222222 ")
        -- print( "  caocaocaocaocoaoco   ")
        --     dump(data)
        if(masterData) then
            
            masterData:setGameUIDecorates(data.decorates or {})
            masterData:setGameUIEquippedDecorates(data.equippedDecorate or {})

            --通知UI更新
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT)
        end
    elseif no == NetMessageType.ROLE_RESP_RespEquipPlayerDecorateMessage.NO then
        local masterData = RoleDataManager:getMaster()
        if(masterData and data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            -- print( "  caocaocaocaocoaoco  222222   ")
            -- dump(data)
            masterData:setGameUISpecifyEquippedDecorates(data.decorateType, data.decorateValue)

            --通知UI更新
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT)
        end
    elseif no == NetMessageType.ROLE_SYNC_BossPortalDataMessage.NO then
        if data.data or data.reset then
            MasterDataManager:setBossPortalUsedData(data.data, data.reset)
        end
    elseif no == NetMessageType.ROLE_SYNC_VOIDRIFT_INFO.NO then
        print("ROLE_SYNC_INFERNO_INFO",data)
        mvc.caveModel:handleVoidRiftIfo(data)

        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_SWEEP_VOIDRIFT_RESPONSE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_VOIDRIFT_FIGHT_COUNT)
    elseif no == NetMessageType.ROLE_SYNC_VIKING_INFO.NO then
        print("ROLE_SYNC_VIKING_INFO",data)
        mvc.viKingModel:handleViKingIfo(data)

        Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_SWEEP_VIKING_RESPONSE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_VIKING_FIGHT_COUNT)
    elseif no == NetMessageType.ROLE_SYNC_VOIDRIFT_RUNE.NO then
        -- SC 同步炼狱宝石数据
        print("ROLE_SYNC_INFERNO_RUNE", data)
        mvc.caveModel:handleVoidRiftRune(data.runeData)

        if(not SceneManager:getInstance():getIsInLoading()) then
            local waitingInfernoRune = mvc.caveModel:getVoidRiftDiamondRandom()
            if(waitingInfernoRune and #waitingInfernoRune > 0)then 
                mvc.openPanel("Cave", "VoidRiftSelect")
            end
        end
    elseif no == NetMessageType.ROLE_SYNC_VIKING_RUNE.NO then
        -- SC 同步维京时代宝石数据
        print("ROLE_SYNC_VIKING_RUNE", data)
        mvc.viKingModel:handleViKingRune(data.runeData)

        if(not SceneManager:getInstance():getIsInLoading()) then
            local waitingInfernoRune = mvc.viKingModel:getViKingDiamondRandom()
            if(waitingInfernoRune and #waitingInfernoRune > 0)then 
                mvc.openPanel("ViKing", "ViKingSelect")
            end
        end
    elseif no == NetMessageType.ROLE_RESP_SELECT_VOIDRIFT_RUNE.NO then
        print("ROLE_RESP_SELECT_INFERNO_RUNE", data)
        UI.WaitingLayer:hideWaiting()
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
            GameErrorManager:showError(data.result)
        else
            -- mvc.caveModel:clearRandomLegacyArr()
            mvc.closePanel("Cave", "VoidRiftSelect")
        end
    elseif no == NetMessageType.ROLE_RESP_SELECT_VIKING_RUNE.NO then
        print("ROLE_RESP_SELECT_VIKING_RUNE", data)
        UI.WaitingLayer:hideWaiting()
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
            GameErrorManager:showError(data.result)
        else
            -- mvc.caveModel:clearRandomLegacyArr()
            mvc.closePanel("ViKing", "ViKingSelect")
        end
    elseif no == NetMessageType.ROLE_SYNC_SKILL_LABEL.NO then
        UI.WaitingLayer:hideWaiting()
        -- if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
        --     GameErrorManager:showError(data.result)
        -- end
        if data.boughtLabels then
            SkillDataManager:setboughtSkillLabelListList(data.boughtLabels)
            Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_BOUGHT_LABEL)
        end
    elseif no == NetMessageType.ROLE_RESP_BUY_SKILL_LABEL.NO then
        UI.WaitingLayer:hideWaiting()
        -- if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
        --     GameErrorManager:showError(data.result)
        -- end
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_BOUGHT_LABEL)
    elseif no == NetMessageType.ROLE_SYNC_GROUP_MONSTER_REVIVE.NO then
        -- 怪物复活
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_GROUP_MONSTER_REVIVE, data)
        local SceneManager = require("app.game.SceneManager")
        SceneManager:getInstance():pushCommand(command)
    elseif (no == NetMessageType.ROLE_RESP_GEM_SHOP_BUY_MESSAGE.NO) then
        -- 渔具商店购买回复
        if data.result == PublicDefine.ErrNo.ErrNo_Ok then
            MasterDataManager:refreshOneGemstoneShopRecord(nil,nil,data.buydata)
            mvc.send("Fishing_Shop_Buy_Result_Handler", data)
        else
            local textStr = LanguageManager:getInstance():getLocalString(1111101)
            UI.ScrollBar:createByText(textStr)
        end
    elseif no == NetMessageType.ROLE_NTF_EVER_WINTER_RIFT_INFO.NO then
        print("ROLE_NTF_EVER_WINTER_RIFT_INFO", data)
        mvc.everWinterRiftModel:setEverWinterRiftData(data)
        mvc.send("EverWinterRift_Rsp_Get_Reward")
    elseif no == NetMessageType.ROLE_RSP_GET_EVER_WINTER_RIFT_REWARDS.NO then
        print("ROLE_RSP_GET_EVER_WINTER_RIFT_REWARDS", data)
        UI.WaitingLayer:hideWaiting()
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
            GameErrorManager:showError(data.result)
        else
            -- mvc.send("EverWinterRift_Rsp_Get_Reward", data)
            UI.ScrollBar:createByText(UI.TEXT_1212026)
        end
    elseif no == NetMessageType.ROLE_HERO_RSP_REINCARNATION.NO then
        -- print("ROLE_HERO_RSP_REINCARNATION", data)
        UI.WaitingLayer:hideWaiting()
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
            GameErrorManager:showError(data.result)
        else
            RoleDataManager:handleRoleRecarnation(data)
            mvc.send("RoleReincarnation_Update_Role_Layout", true)
            local master = RoleDataManager:getMaster()
            if(master) then
                SkillDataManager:resetSkillTree()
                SkillDataManager:resetSkillTreeConfig()
            end
        end
    elseif no == NetMessageType.ROLE_NOTIFY_ROLE_REINCARNATION_DATA.NO then
        -- print("ROLE_NOTIFY_ROLE_REINCARNATION_DATA", data)
        UI.WaitingLayer:hideWaiting()
        RoleDataManager:setRoleReincarnationLv(data.roleLevel)
    elseif no == NetMessageType.ROLE_NTF_MOLD_INFO.NO then
        UI.WaitingLayer:hideWaiting()
        mvc.runeMoldModel:initMoldNetData(data)
    elseif no == NetMessageType.ROLE_RSP_MOLD_FORGING_MESSAGE.NO then
        UI.WaitingLayer:hideWaiting()
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
            GameErrorManager:showError(data.result)
        else
            mvc.send("Rune_Mold_On_Forging", data)
        end
    elseif no == NetMessageType.ROLE_RSP_MOLD_GEM_INLAID_MESSAGE.NO then
        UI.WaitingLayer:hideWaiting()
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
            -- GameErrorManager:showError(data.result)
            UI.ScrollBar:createByText(UI.TEXT_224703)
        else
            mvc.send("Rune_Mold_On_Inlaid", data)
        end
    elseif no == NetMessageType.ROLE_RSP_USE_MOLD_MESSAGE.NO then
        UI.WaitingLayer:hideWaiting()
        if data.result ~= PublicDefine.ErrNo.ErrNo_Ok then 
            GameErrorManager:showError(data.result)
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_USE_MOLD_DRAGE_USE, data)
            Avalon.MessageCenter:notice(AvalonMessage.MC_USE_MOLD_REFRSH_BAG)
        end
    elseif no == NetMessageType.ROLE_NTF_CALL_MONSTER_APPEAR.NO then
        UI.WaitingLayer:hideWaiting()
        local command = Command.ControlCommand:create(true)
        command:initForTypeAndData(CommandType.CONTROL_SUMMONED_BOSS_CHANGE_PANNEL, data)
        SceneManager:getInstance():pushCommand(command)

    elseif no == NetMessageType.ROLE_NTF_CALL_MONSTER_DISAPPEAR.NO then
        UI.WaitingLayer:hideWaiting()
    elseif no == NetMessageType.RESPONSE_CHANGE_PLATE_MESSAGE.NO then
        -- 请求更换使用星盘结果回复
        UI.WaitingLayer:hideWaiting()
        dump(data, "RESPONSE_CHANGE_PLATE_MESSAGEa")
    else
        -- assert(false, string.format("[Game Manager] onRoleMessageHandler no %d is invaild.", no))
    end
end

function NetRoleSystem:_handleHorcurxSystemMsg(data)
    if data.err == "HorcruxError_OK" then
        return true
    end
    if data.err == "HorcruxError_SysError" then
        UI.ScrollBar:createByText(UI.TEXT_1212409)
    elseif data.err == "HorcruxError_NotEnough" then
        UI.ScrollBar:createByText(UI.TEXT_1212410)
    end
    return false
end

function NetRoleSystem:_handleSystemMsg(data)
    if(data == nil) then return end

    if(data.type == "NoticeSystemMsgType_ExtraDropSendMail") then
        local extraDropSendMailData = ProtobufUtil:decode("RoleSystem.ExtraDropSendMailData", data.content)
        if(extraDropSendMailData) then
            -- print("function NetRoleSystem:_handleSystemMsg", extraDropSendMailData.itemID, extraDropSendMailData.num)
            local textStr = LanguageManager:getInstance():getLocalString(1111070)
            textStr = PlaceholderUtil:formatName(textStr, extraDropSendMailData.itemID)
            textStr = string.format(textStr, extraDropSendMailData.num)
            -- print("NetRoleSystem:_handleSystemMsg", textStr)
            Game.ChatManager:getInstance():formartAndSendSystemMsg(ChatMessageType.SYSTEM_MESSAGE, textStr)
        end
    end
end
--[[
    活动网络消息
]]
local SceneManager = require("app.game.SceneManager")

Net = Net or {}

local NetPlaySystem = {}
Net.NetPlaySystem = NetPlaySystem
local ProtobufUtil = require "utils.ProtobufUtil"
local DEBUG = false


local GameDataManager = require("app.game.GameDataManager")

function NetPlaySystem:petUseSkillRequest(skillID,targetSpriteID,coordX,coordY)

    -- Net.Helper:sendMessage(NetMessageType.PLAY_REQUEST_HULU_DATA, messageData)
end

function NetPlaySystem:huluSetEeaponRequest(weapon)

    -- Net.Helper:sendMessage(NetMessageType.PET_USE_SKILL_MESSAGE, messageData)
    local messageData = {}
    messageData.weapon = weapon
    messageData.exterior = math.floor(100000000 * math.random())

    Net.Helper:sendMessage(NetMessageType.PLAY_REQUEST_HULU_SELECT_WEAPON, messageData)
end

function NetPlaySystem:huluSetSkillRequest(weaponType, fightSkills)
    local messageData = {}
    messageData.skillConfs = {weaponType = weaponType, fightSkills = fightSkills} 

    Net.Helper:sendMessage(NetMessageType.PLAY_REQUEST_HULU_SET_SKILL, messageData)
end

function NetPlaySystem:huluSelectLegacy(legacy)
    local messageData = {}
    messageData.legacy = legacy

    Net.Helper:sendMessage(NetMessageType.PLAY_REQUEST_HULU_SELECT_LEGACY, messageData)
end

function NetPlaySystem:requestPuzzleResult(score)
    local messageData = {}
    messageData.score = score

    Net.Helper:sendMessage(NetMessageType.PLAY_REQUEST_PUZZLE_RESULT, messageData)
end

function NetPlaySystem:requestLostRealmData()

    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_LOSTREALM_DATA)
end

function NetPlaySystem:requestLostRealmOperate()

    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_LOSTREALM_OPERATE)
end

function NetPlaySystem:requestMarblesFeverDraw(tp)
    local messageData = {}
    if tp == 1 then --抽1次
        messageData.drawType = 1
    elseif tp == 2 then --抽10次 
        messageData.drawType = 2
    end
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_MARBLES_FEVER_DRAW,messageData)
end

function NetPlaySystem:requestLimitedMarblesFeverDraw(tp)
    local messageData = {}
    if tp == 1 then --抽1次
        messageData.drawType = 1
    elseif tp == 2 then --抽10次 
        messageData.drawType = 2
    end
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_LIMITED_MARBLES_FEVER_DRAW,messageData)
end

function NetPlaySystem:requestCrystalCaptureDraw(tp)
    local messageData = {}
    if tp == 1 then --抽1次
        messageData.drawType = 1
    elseif tp == 2 then --抽10次 
        messageData.drawType = 2
    end
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_Crystal_Capture_DRAW,messageData)
end

function NetPlaySystem:requestClaimBigShotGift(level)
    local messageData = {}
    messageData.level = level
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_GAME_HALL_MOGUL_GIFT,messageData)
end

function NetPlaySystem:requestClaimBigShotWeeklyGift(level)
    local messageData = {}
    messageData.level = level
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_GAME_HALL_MOGUL_WEEKLY_GIFT,messageData)
end

function NetPlaySystem:requestClaimGameHallNewbieGift()
    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_GAME_HALL_NEWBIE_GIFT,messageData)
end

function NetPlaySystem:requestClaimGameHallDailyGift()
    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_GAME_HALL_DAILY_GIFT,messageData)
end

function NetPlaySystem:requestClaimGameHallLevelGift(level)
    local messageData = {}
    messageData.level = level
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_GAME_HALL_LEVEL_GIFT,messageData)
end

function NetPlaySystem:requestMonthlySignIn(index)
    local messageData = {}
    messageData.whichDay = index
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_MONTHLY_SIGN_IN,messageData)
end

function NetPlaySystem:requestMonthlySignInClaimReward(cumulativeDay)
    local messageData = {}
    messageData.cumulativeDay = cumulativeDay
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_MONTHLY_SIGN_CLAIM_REWARD,messageData)
end

function NetPlaySystem:requestAnniversarySubscribeClaimReward(scheduleId)
    local messageData = {}
    messageData.scheduleId = scheduleId
    print("发送消息  ====== ",messageData)
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_ANNIVERSARY_SUBSCRIBE_CLAIM_AWARD,messageData)
end

-- 客户端请求活动副本数据
function NetPlaySystem:requestDungeonActivityData()
    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_DUNGEON_ACTIVITY_DATA,messageData)
end

-- 请求进入试练之地
function NetPlaySystem:requestEnterTrialLand(activityId, modeId, selectedEffects)
    local messageData = {}
    messageData.activityId = activityId
    messageData.modeId = modeId
    messageData.selectedEffects = selectedEffects
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_ENTER_TRIAL_LAND,messageData)
end

-- 领取试炼之地首通奖励
function NetPlaySystem:requestClaimTrialLandDailyReward(activityId, modeId)
    local messageData = {}
    messageData.activityId = activityId
    messageData.modeId = modeId
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_CLAIM_TRIAL_LAND_DAILY_REWARD,messageData)
end

-- CS 请求领取全服参与奖
function NetPlaySystem:requestClaimParticipateAward(pType, scheduleId)
    local messageData = {}
    messageData.type = pType
    messageData.scheduleId = scheduleId
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_CLAIM_PARTICIPATE_AWARD,messageData)
end

-- CS 请求开宝箱
function NetPlaySystem:requestTreasureHuntOpenBox(id)
    local messageData = {}
    messageData.id = id
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_TREASURE_HUNT,messageData)
end

-- CS 请求刷新宝箱
function NetPlaySystem:requestTreasureHuntRefreshBox(id)
    local messageData = {}
    messageData.id = id
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_REFRESH_TREASURE_HUNT,messageData)
end

-- CS 请求永冬裂缝扫荡
function NetPlaySystem:requestEverwinterRiftSweep(id)
    local messageData = {}
    messageData.id = id
    Net.Helper:sendMessage(NetMessageType.PLAY_REQ_EVERWINTER_RIFT_SWEEP,messageData)
end

-- CS 请求激活秘纹
function NetPlaySystem:requestStarPatternActiveMessage()
    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.REQUEST_STAR_PATTERN_ACTIVE_MESSAGE,messageData)
end

-- CS 请求升级星盘

function NetPlaySystem:requestStarPatternUpgradeMessage()
    local messageData = {}
    Net.Helper:sendMessage(NetMessageType.REQUEST_STAR_PATTERN_UPGRADE_MESSAGE,messageData)
end

--CS 请求取消激活
function NetPlaySystem:requestSouvenirCancelActiviteMessage(id)
    local messageData = {}
    messageData.id = id
    Net.Helper:sendMessage(NetMessageType.PLAY_REQUEST_SOUVENIR_CANCEL_ACTIVITE,messageData)
end

-- CS 请求激活纪念品
function NetPlaySystem:requestSouvenirActiviteMessage(id,activiteType)
    local messageData = {}
    messageData.id = id
    messageData.activiteType = activiteType
    Net.Helper:sendMessage(NetMessageType.PLAY_REQUEST_SOUVENIR_ACTIVITE,messageData)
end

--CS 请求纪念品升级
function NetPlaySystem:requestSouvenirLevelUpMessage(id)
    local messageData = {}
    messageData.id = id
    Net.Helper:sendMessage(NetMessageType.PLAY_REQUEST_SOUVENIR_LEVEL_UP,messageData)
end


-- 处理器
function NetPlaySystem:onPlayMessageHandler(no, data)
    if(DEBUG) then
        print("---------NetPlaySystem:onLogicMessageHandler ", no, data)
    end
    if (no == NetMessageType.PLAY_BIG_CRACK_INFO_DATA.NO) then
        if(ProtobufUtil:checkFieldIsInit(data, "heroMsg")) then 
            local sceneRunTime = data.heroMsg.sceneRunTime
            local campHero = data.heroMsg.campHero
            local campId = data.heroMsg.camp

            mvc.bigCrackModel:setSceneRunTime(sceneRunTime)
            mvc.bigCrackModel:setCampHero(campHero)
            mvc.bigCrackModel:setCampId(campId)
            mvc.bigCrackModel:setIsSettle(false)
        end

        if(ProtobufUtil:checkFieldIsInit(data, "settleMsg")) then 
            if(SceneManager:getInstance():getIsInLoading()) then
                return
            end
            mvc.bigCrackModel:setIsSettle(true)
            local curCamp = mvc.bigCrackModel:getCampId()
            local settleMsg = data.settleMsg
            local campId = ProtobufUtil:enum_id("PublicDefine.Camp", settleMsg.winCamp)
            local isWin = curCamp == campId
            local mvcPk = (curCamp == PublicDefine.Camp.Blue) and settleMsg.blueMvpPK or settleMsg.redMvpPK

            local winNum = 0
            local heroInfos = {}
            local heros = settleMsg.hero
            local masterPk = GameDataManager:getInstance():getMasterPK()
            for i = 1, #heros do
                local serverHeroInfo = heros[i].heroInfo
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
                if mvcPk == serverHeroInfo.pk then
                    table.insert(heroInfos, 1, {heroData = detailData, crossNum = heros[i].crossNum, damge = heros[i].damge})
                else
                    table.insert(heroInfos,{heroData = detailData, crossNum = heros[i].crossNum, damge = heros[i].damge})
                end
                if masterPk == serverHeroInfo.pk then
                    winNum = heros[i].winNum
                    if not heros[i].isAward then --只是为了超出最大可伶次数
                        winNum = winNum + 100
                    end
                end
            end
            mvc.openPanel("BigCrack", "BigCrackResult", {isWin = isWin,  heroInfos = heroInfos, winNum = winNum})
        end
        if(ProtobufUtil:checkFieldIsInit(data, "synCampHeroMsg")) then 
            local campHeroMsg = data.synCampHeroMsg
            local heroCamp = campHeroMsg.heroCamp
            mvc.bigCrackModel:setCampHero({heroCamp})
        end

        if(ProtobufUtil:checkFieldIsInit(data, "bossMsg")) then 
            local bossMsg = data.bossMsg
            mvc.bigCrackModel:setBossInfo(bossMsg.bosses)
        end
        if(ProtobufUtil:checkFieldIsInit(data, "punishMsg")) then 
            Game.ChatManager:getInstance():sendSystemMsg(UI.TEXT_1213448, ChatMessageType.SYSTEM_MESSAGE)
        end

        if(ProtobufUtil:checkFieldIsInit(data, "refreshCollect")) then 
            UI.ScrollBar:createByText(UIUtil:lang(1113133))
        end
    elseif (no == NetMessageType.PLAY_RESPONSE_HULU_DATA.NO) then
        if(DEBUG) then 
            print("PLAY_RESPONSE_HULU_DATA", data)
        end
        if(ProtobufUtil:checkFieldIsInit(data, "data")) then 
            local huluData = data.data
            mvc.festivalModel:setHuluChoiceWeaponType(huluData.weapon, huluData.exterior)
            mvc.festivalModel:handleInitLegacy(huluData.legacy)
            mvc.festivalModel:setRandomLegacy(huluData.randLegacy)
        end
    elseif (no == NetMessageType.PLAY_RESPONSE_HULU_SET_SKILL.NO) then
        if(DEBUG) then 
            print("PLAY_RESPONSE_HULU_SET_SKILL", data)
        end
        UI.WaitingLayer:hideWaiting()
        Avalon.MessageCenter:notice(AvalonMessage.MC_SKILL_SET_FIGHT_RESULT)
    elseif (no == NetMessageType.PLAY_REPONSE_HULU_SELECT_WEAPON.NO) then
        if(DEBUG) then 
            print("PLAY_REPONSE_HULU_SELECT_WEAPON", data)
        end

        if(data.err == 1) then 
            mvc.festivalModel:setHuluChoiceWeaponType(data.weapon, data.exterior)
            -- 刷新一下表现
            local wearData = GameDataManager:getInstance():getWearEquipmentData()
            Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)
        end

    elseif (no == NetMessageType.PLAY_NOICE_HULU_RAND_LEGACY.NO) then
        if(DEBUG) then 
            print("PLAY_NOICE_HULU_RAND_LEGACY", data)
        end
        mvc.festivalModel:setRandomLegacy(data.legacy)
        -- 直接弹出这个界面
        if(#mvc.festivalModel:getRandomLegacyArr() >0) then
            mvc.openPanel("Festival", "FestivalRelicsSelect")
        end
    elseif (no == NetMessageType.PLAY_RESPONSE_HULU_SELECT_LEGACY.NO) then
        if(DEBUG) then 
            print("PLAY_RESPONSE_HULU_SELECT_LEGACY", data)
        end
        UI.WaitingLayer:hideWaiting()
        if(data.err == 1) then
            mvc.festivalModel:clearRandomLegacyArr()
            mvc.festivalModel:handleAddOneLegacy(data.legacy)
            mvc.closePanel("Festival", "FestivalRelicsSelect")
        end
    elseif (no == NetMessageType.PLAY_RESPONSE_PUZZLE_RESULT.NO) then
        if(DEBUG) then 
            print("PLAY_RESPONSE_PUZZLE_RESULT", data)
        end

        mvc.send(mvc.events.Puzzle_Handle_Result_Message, data)
    elseif (no == NetMessageType.PLAY_RESPONSE_LOSTREALM_DATA.NO) then
        print("PLAY_RESPONSE_LOSTREALM_DATA", data)
        mvc.festivalModel:initLostRealmData(data.data)
    elseif (no == NetMessageType.PLAY_RESPONSE_LOSTREALM_OPERATE.NO) then
        print("PLAY_RESPONSE_LOSTREALM_OPERATE", data)
        mvc.festivalModel:initLostRealmData(data.data)
        GameErrorManager:showError(data.result)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_LOSTREALM_OPERATE_RESULT, data)
        if(data.operateType == ProtobufUtil:enum_id("PlaySystem.LostRealmOperateType", "LostRealmOperateType_ClaimReward")) then
            local str = UI.TEXT_111030
            if(data.rewardMethod == 1) then
                local LanguageManager = require "app.game.LanguageManager"
                str = LanguageManager:getInstance():getLocalString(1111068)
            end
            -- 生成相关的物品
            local rewardGoodsArr = {}
            for _,rewardData in pairs(data.rewards) do
                local goodsData = GoodsDataManager:createLocalGoodsData(rewardData.id)
                if (goodsData) then
                    goodsData:setNum(rewardData.num)
                    -- 这里默认给点金
                    goodsData:setIsGolden(true)
                    table.insert(rewardGoodsArr, goodsData)
                end
            end
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, nil, str, nil)
        end
    elseif (no == NetMessageType.PLAY_RESPONSE_MARBLES_FEVER_DRAW.NO or no == NetMessageType.PLAY_RESPONSE_LIMITED_MARBLES_FEVER_DRAW.NO) then
        print( "返回成功  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        Avalon.MessageCenter:notice(AvalonMessage.MC_ACTIVITY_FIGHT_BACK_RESULT, data)
        if data.result ~= ProtobufUtil:enum_id("PlaySystem.RespMarblesFeverDraw", "RespMarblesFeverDraw_Succeed") then
            GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.PLAY_SYNC_MONTHLY_SIGN.NO) then
        print( "PLAY_SYNC_MONTHLY_SIGN  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        mvc.send(mvc.events.Sync_MonthlySign_Data, data.data)
    elseif (no == NetMessageType.PLAY_RESP_MONTHLY_SIGN_IN.NO) then
        print( "PLAY_RESP_MONTHLY_SIGN_IN  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            -- 水晶补签次数用完,签到券不足
            if data.result == 102 and mvc.monthlySignModel:getUseDiamondCount() == mvc.monthlySignModel:getUseDiamondMaxCount() then
                UI.ScrollBar:createByText(UI.TEXT_222404)
                return
            end

            GameErrorManager:showError(data.result)
            return
        end
        mvc.send(mvc.events.MonthlySign_In_Resp)
    elseif (no == NetMessageType.PLAY_RESP_MONTHLY_SIGN_CLAIM_REWARD.NO) then
        print( "PLAY_RESP_MONTHLY_SIGN_CLAIM_REWARD  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
            return
        end
        mvc.send(mvc.events.MonthlySign_Cliam_Resp, data.cumulativeDay)
    elseif (no == NetMessageType.PLAY_SYNC_ANNIVERSARY_SUBSCRIBE_DATA.NO) then
        print( "PLAY_SYNC_ANNIVERSARY_SUBSCRIBE_DATA  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        mvc.anniversaryAppointmentModel:initServerRewardTarget(data)
    elseif (no == NetMessageType.PLAY_RESP_ANNIVERSARY_SUBSCRIBE_CLAIM_AWARD.NO) then
        print( "PLAY_RESP_ANNIVERSARY_SUBSCRIBE_CLAIM_AWARD  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
            return
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_ACTIVITY_REFRESH_SERVER_REWARD_BTN)
    elseif (no == NetMessageType.PLAY_RESP_DUNGEON_ACTIVITY_DATA.NO) then
        -- print( "PLAY_RESP_DUNGEON_ACTIVITY_DATA  ======== ",data)
        dump(data, "PLAY_RESP_DUNGEON_ACTIVITY_DATA12", 5)
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            UI.WaitingLayer:hideWaiting()
            GameErrorManager:showError(data.result)
            return
        end
        mvc.activityModeCaveModel:initModeCaveData(data.data)
        UI.WaitingLayer:hideWaiting()
        Avalon.MessageCenter:notice(AvalonMessage.MC_TRIAL_LAND_REFRESH_GET_BTN)
        -- mvc.send("ActivityModeCave_Open_Main_View")
    elseif (no == NetMessageType.PLAY_RESP_ENTER_TRIAL_LAND.NO) then
        UI.WaitingLayer:hideWaiting()
        print( "PLAY_RESP_ENTER_TRIAL_LAND  ======== ",data)
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
            return
        end
    elseif (no == NetMessageType.PLAY_RESP_CLAIM_TRIAL_LAND_DAILY_REWARD.NO) then
        UI.WaitingLayer:hideWaiting()
        print( "PLAY_RESP_CLAIM_TRIAL_LAND_DAILY_REWARD  ======== ",data)
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
            return
        end  
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TRIAL_LAND_REFRESH_GET_BTN)
        UI.ScrollBar:createByText(UI.TEXT_1212026)
        self:requestDungeonActivityData()
    elseif (no == NetMessageType.PLAY_NTF_TRIAL_LAND_SETTLE_DATA.NO) then
        UI.WaitingLayer:hideWaiting()
        print( "PLAY_NTF_TRIAL_LAND_SETTLE_DATA  ======== ",data)
        mvc.activityModeCaveModel:setTrialLandSettleData(data)
        if data.isSuccess then
            mvc.activityModeCaveModel:setIsShowTrialLandRewardLayer(true)
        end
    elseif (no == NetMessageType.PLAY_SYNC_PARTICIPATE_DATA.NO) then
        -- 同步客户端 活动副本 全服参与奖
        print( "PLAY_SYNC_PARTICIPATE_DATA  ======== ",data)
        mvc.activityModeCaveLeaderboardModel:updateParticipateData(data.data or {})
    elseif (no == NetMessageType.PLAY_RESPONSE_CLAIM_PARTICIPATE_AWARD.NO) then 
        -- 请求领取全服参与奖结果
        UI.WaitingLayer:hideWaiting()
        print( "PLAY_RESPONSE_CLAIM_PARTICIPATE_AWARD  ======== ",data)
        if (data.result == PublicDefine.ErrNo.ErrNo_Ok) then
            mvc.activityModeCaveLeaderboardController:updateAwardView()
            mvc.send("ActivityModeCave_Refresh_Rank_RedPoint")
        end 
    elseif (no == NetMessageType.PLAY_SYNC_TRIAL_LAND_CAVE_DATA.NO) then 
        -- 通知客户端试炼之地洞窟数据
        UI.WaitingLayer:hideWaiting()
        -- dump(data, "PLAY_SYNC_TRIAL_LAND_CAVE_DATA")
        mvc.activityModeCaveModel:setTrialLandCaveData(data)
    elseif (no == NetMessageType.PLAY_RESPONSE_Crystal_Capture_DRAW.NO) then
        print( "返回成功  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        Avalon.MessageCenter:notice(AvalonMessage.MC_ACTIVITY_CRYSTAL_CAPTURE_RESULT, data)
    elseif (no == NetMessageType.PLAY_REQ_Crystal_Capture_Notify_Info.NO) then
        print( "返回成功  ====PLAY_REQ_Crystal_Capture_Notify_Info==== ",data)
        -- 登录时同步水晶夺宝活动是否已经结束，来判断背包里是否还有多余的没有使用的兑换券，
        -- 需要替换成水晶奖励。
        -- 这个消息有问题，不能发送，因为这里的方法会去根据服务器时间来判断当前活动是否在开启时间内，
        -- 而这个消息发送过来时，服务器的时间的消息还没有同步过来，导致这里会一直判断活动不在开启时间内。
        -- if(not mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature) and SceneManager:getInstance():isNotInFightScene()) then
        --     -- CS 水晶夺宝请求重置
        --     print("发送消息--->: PLAY_REQ_Crystal_Capture_Notify_Info--: ", mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature))
        --     local messageData = {}
        --     messageData.version = data.version
        --     Net.Helper:sendMessage(NetMessageType.PLAY_RESPONSE_Crystal_Capture_HuntWhenEnd,messageData) 
        -- end
    elseif (no == NetMessageType.PLAY_SYNC_TREASURE_HUNT_INFO.NO) then
        print( "PLAY_SYNC_TREASURE_HUNT_INFO  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        mvc.caveExploringModel:initBoxMapInfo(data.info)
    elseif (no == NetMessageType.PLAY_RSP_REFRESH_TREASURE_HUNT.NO) then
        print( "PLAY_RSP_REFRESH_TREASURE_HUNT  ======== ",data)
        UI.WaitingLayer:hideWaiting()
        mvc.send("CaveExploring_Update_BoxMapView")
    elseif (no == NetMessageType.PLAY_RSP_EVERWINTER_RIFT_SWEEP.NO) then
        --永冬裂缝扫荡完成
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
            return
        end
        --更新界面
        mvc.send("EverWinterRift_Refresh_Info")

        local rewards = data.rewards or {}
        local rewardGoodsArr = {}

        for k,v in pairs(rewards) do
            local goodsData = GoodsDataManager:createLocalGoodsData(v.id)
            if (goodsData) then
                goodsData:setNum(v.num)
                table.insert(rewardGoodsArr, goodsData)
            end
        end

        if #rewardGoodsArr > 0 then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr)
        end
    elseif (no == NetMessageType.RESPONSE_STAR_PATTERN_DATA_MESSAGE.NO) then
        mvc.starPrayModel:setActiveStarPatternID(data.activeStarPatternID)
        mvc.starPrayModel:setStarPrayLevel(data.level)
    elseif (no == NetMessageType.RESPONSE_STAR_PATTERN_ACTIVE_MESSAGE.NO) then

        -- print("  RESPONSE_STAR_PATTERN_ACTIVE_MESSAGE ========  ",data.result ~= PublicDefine.ErrNo.ErrNo_Ok)
        -- dump(data,nil,10)
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
            return
        end

        mvc.starPrayModel:addActiveStarPatternID(data.starPatternID)

        mvc.send(mvc.events.StarPray_ActiveRune, data.starPatternID)
    elseif (no == NetMessageType.RESPONSE_STAR_PATTERN_UPGRADE_MESSAGE.NO) then
        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            GameErrorManager:showError(data.result)
            return
        end

        mvc.starPrayModel:setStarPrayLevel(data.level)

        mvc.send(mvc.events.StarPray_Upgrade)

    elseif (no == NetMessageType.PLAY_RESPONSE_SOUVENIR_DATA.NO) then
        -- print( "PLAY_RESPONSE_SOUVENIR_DATA   返回成功  ======== ")
        -- dump(data,nil,10)
        mvc.souvenirModel:initNetData(data.data)
    elseif (no == NetMessageType.PLAY_UPDATE_SOUVENIR_DATA.NO) then
        -- print( "PLAY_UPDATE_SOUVENIR_DATA   返回成功  ======== ")
        -- dump(data,nil,10)
        mvc.souvenirModel:updateNetData(data.data)
        mvc.send(mvc.events.Souvenir_Resource_Change,data.data)

    elseif (no == NetMessageType.PLAY_RESPONSE_SOUVENIR_CANCEL_ACTIVITE.NO or 
            no == NetMessageType.PLAY_RESPONSE_SOUVENIR_ACTIVITE.NO) then

        if (data.result ~= PublicDefine.ErrNo.ErrNo_Ok) then
            return
        end

        mvc.send(mvc.events.Souvenir_Close_Layer)
        if no == NetMessageType.PLAY_RESPONSE_SOUVENIR_ACTIVITE.NO then
            UI.ScrollBar:createByText(UI.TEXT_228417)
        end
    elseif (no == NetMessageType.PLAY_NOTIFY_GET_SOUVENIR.NO) then
        if data.isRepeat then
            mvc.souvenirModel:showRepeatGet(data.id)
        end
    else
        print(string.format("[WARNING] NetPlaySystem no handler for this message. [no:%d data:%s]", no, data))
    end
end
--[[
    活动网络消息
]]
local SceneManager = require("app.game.SceneManager")

Net = Net or {}

local NetLogicSystem = {}
Net.NetLogicSystem = NetLogicSystem
local ProtobufUtil = require "utils.ProtobufUtil"
local DEBUG = false

function NetLogicSystem:requestGetBpAward(level, awardType)
	if DEBUG then
	    print("---level, awardType---", level, awardType)
	end
    local data = {}
    data.lv = level 
    data.type = awardType
    Net.Helper:sendMessage(NetMessageType.LOGIC_REQ_GET_BP_AWARD, data)
end

function NetLogicSystem:requestBpShopBuy(buyID, number)
	if DEBUG then
		print("---buyID, number---", buyID, number)
	end
    local data = {}
    data.buyID = buyID 
    data.buyNum = number
    Net.Helper:sendMessage(NetMessageType.LOGIC_REQ_BUY_BP_SHOP, data)
end

function NetLogicSystem:requestSpringFestivalSign(type, id)
	if DEBUG then
		print("---type, id---", type, id)
    end

    local data = {}
    data.type = type 
    data.date = id
    Net.Helper:sendMessage(NetMessageType.LOGIC_REQ_FESTIVAL_SIGN, data)
end


-- 处理器
function NetLogicSystem:onLogicMessageHandler(no, data)
    if(DEBUG) then
        print("---------NetLogicSystem:onLogicMessageHandler ", no, data)
    end
    if (no == NetMessageType.LOGIC_BATTLE_PASS_ALL_DATA.NO) then
    	mvc.battlePassModel:refreshBattlePassData(data)
    elseif (no == NetMessageType.LOGIC_RSP_GET_BP_AWARD.NO) then
    	UI.WaitingLayer:hideWaiting() 
    	if data.err == "ErrNo_OK" then
    		UI.ScrollBar:createByTextID(1111430)
    	else
    		GameErrorManager:showError(ProtobufUtil:enum_id("LogicSystem.ErrNo", data.err))
    	end
    elseif (no == NetMessageType.LOGIC_RSP_BUY_BP_SHOP.NO) then
    	UI.WaitingLayer:hideWaiting() 
    	if data.result == ProtobufUtil:enum_id("LogicSystem.BuyBattlePassGoodsResultType", "BuyBattlePassGoodsResultType_Suc") then
    		UI.ScrollBar:createByTextID(1111430)
            mvc.battlePassModel:refreshBattlePassShopData(data.buyInfo)  
    	else
    		GameErrorManager:showError(data.result)
        end
    elseif (no == NetMessageType.LOGIC_RAT_USE_HAMMER_RES.NO) then
        -- ErrNo_Ok = 1;       // OK
        -- ErrNo_SysErr = 2;   // 系统错误
        -- ErrNo_ParaErr =3;   // 参数错误
        print(data)
        if data.err == "ErrNo_Ok" then
            mvc.hitRatModel:setHommerHotValue( data.hotValue)
            mvc.hitRatModel:setHommerIsHot( data.isActHot)
            
        end

    elseif (no == NetMessageType.LOGIC_RAT_INFO_NTF.NO) then
        -- print("==========LOGIC_RAT_INFO_NTF==========")
        -- print(data)
        if(ProtobufUtil:checkFieldIsInit(data, "heroMsg")) then
            if data.heroMsg.pk ~= RoleDataManager:getMasterPK() then
                return
            end

            local hammerID= ProtobufUtil:enum_id("LogicSystem.RatHammer", data.heroMsg.hammerID)
            mvc.hitRatModel:setHommerInfo(
                hammerID, data.heroMsg.isHotAct, data.heroMsg.sceneRunTime, 
                data.heroMsg.hotValue,data.heroMsg.hammerEndTime)

        elseif(ProtobufUtil:checkFieldIsInit(data, "stateMsg")) then
            local tmp = data.stateMsg
            mvc.hitRatModel:set("scoreScale", tmp.isDoubleScore and 2 or 1)
        elseif(ProtobufUtil:checkFieldIsInit(data, "settleMsg")) then
            -- print("==========settleMsg==========")
            -- print(data)

            local battleResult = {}
            local dataMsg = data.settleMsg
            battleResult.isWin = dataMsg.isWin

            -- 组装对手数据
            local serverHeroInfo = dataMsg.enemyDetail
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

            -- 对名字做一下容错
            if ProtobufUtil:checkFieldIsInit(serverHeroInfo, "nickName") then
                battleResult.enemyName = serverHeroInfo.nickName
            else
                battleResult.enemyName = ""
            end

            battleResult.enemyData = detailData

            -- 重新组织一下数据
            if ProtobufUtil:checkFieldIsInit(dataMsg, "myScore") then
                battleResult.myScore = dataMsg.myScore
            else
                battleResult.myScore = 0
            end

            if ProtobufUtil:checkFieldIsInit(dataMsg, "enemyScore") then
                battleResult.enemyScore = dataMsg.enemyScore
            else
                battleResult.enemyScore = 0
            end

            if ProtobufUtil:checkFieldIsInit(dataMsg, "rewardCount") then
                battleResult.rewardCount = dataMsg.rewardCount
            else
                battleResult.rewardCount = 0
            end

            if(not SceneManager:getInstance():getIsInLoading()) then
                mvc.hitRatModel:setBattleResult(battleResult)
                mvc.openPanel("HitRat", "HitRatResult")
            end
        elseif(ProtobufUtil:checkFieldIsInit(data, "scoreMsg")) then
            
            -- required uint64 pk = 1;         // pk
            -- required int32 deltaScore = 2;         // 积分增加
            -- required int32 totalScore = 3;         // 积分总量
            mvc.hitRatModel:setScoreInfo(data.scoreMsg.pk, data.scoreMsg.deltaScore,data.scoreMsg.totalScore)
        end

    elseif (no == NetMessageType.LOGIC_FESTIVAL_SIGN_DATA.NO) then
        -- 春节签到信息，登录时下发
        local signedDay = {}
        if(ProtobufUtil:checkFieldIsInit(data, "signedDates")) then
            signedDay = data.signedDates
        end
        mvc.sFSignModel:receiveSvrData(signedDay)
    elseif (no == NetMessageType.LOGIC_RSP_FESTIVAL_SIGN.NO) then
        -- 春节签到返回
        if data.err == "ErrNo_Ok" then
            mvc.sFSignModel:updateSignedDay(data.date)
        else
            print("NetMessageType.LOGIC_RSP_FESTIVAL_SIGN err")
        end
    else
        print(string.format("[WARNING] NetLogicSystem no handler for this message. [no:%d data:%s]", no, data))
    end
end
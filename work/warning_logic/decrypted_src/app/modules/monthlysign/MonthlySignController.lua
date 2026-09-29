--[[--
控制器MonthlySignController，view已经注入,可以通过mvc.monthlySignProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: junhao.deng
-- date	: 2022/06/17
-- desc	: 
------------------------------------------------------------------------------
local MonthlySignController = class("MonthlySignController", mvc.GameController)



-- mvc.events.Sync_MonthlySign_Data 处理函数
function MonthlySignController:noticeSyncMonthlySignData(notification, data)
    mvc.monthlySignModel:setMonthlySignData(data)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end



-- mvc.events.MonthlySign_In_Req 处理函数
function MonthlySignController:noticeMonthlySignInReq(notification, data, index, rewardID)
    local SceneManager = require("app.game.SceneManager")
    local GameDataManager = require("app.game.GameDataManager")
    local LanguageManager = require("app.game.LanguageManager")
    -- 场景检查
    if (SceneManager:getInstance():isInFightScene()) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112420) --[["此场景不可领奖"]])
        return
    end

    -- 背包检查
    if (GameDataManager:getFreePacketBoxNum() <= 0) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110396) --[["背包已满"]])
        return
    end 

    -- local goodsData = GoodsDataManager:createLocalGoodsData(rewardID)
    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(rewardID)
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then 
        if mvc.starPrayModel:getStarPrayPacketFreeBoxNum() <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_222407)
            return
        end
    end

    local dataList = string.split(data, ";")
    mvc.monthlySignModel:setSignRewardData(dataList)
    Net.NetPlaySystem:requestMonthlySignIn(index)
end



-- mvc.events.MonthlySign_Cliam_Req 处理函数
function MonthlySignController:noticeMonthlySignCliamReq(notification, cumulativeDay, data, goodsID)
    local SceneManager = require("app.game.SceneManager")
    local GameDataManager = require("app.game.GameDataManager")
    local LanguageManager = require("app.game.LanguageManager")
    -- 场景检查
    if (SceneManager:getInstance():isInFightScene()) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112420) --[["此场景不可领奖"]])
        return
    end

    -- 背包检查
    if (GameDataManager:getFreePacketBoxNum() <= 0) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110396) --[["背包已满"]])
        return
    end 

    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsID)
    if goodsType == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then 
        if mvc.starPrayModel:getStarPrayPacketFreeBoxNum() <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_222407)
            return
        end
    end

    local dataList = string.split(data, ";")
    mvc.monthlySignModel:setcumulativeRewardData(dataList)

    Net.NetPlaySystem:requestMonthlySignInClaimReward(cumulativeDay)
end



-- mvc.events.MonthlySign_In_Resp 处理函数
function MonthlySignController:noticeMonthlySignInResp(notification)
    if (self.monthlySignView) then
        self.monthlySignView:creatSignList()
    end
    -- mvc.monthlySignView:creatSignList()
    local signRewardData = mvc.monthlySignModel:getSignRewardData()
    -- 展现获得物品
    self:showItemByIndex(signRewardData, nil, UI.TEXT_1170211, false)
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CURRENCY_CHANGE)
    
    -- Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end



-- mvc.events.MonthlySign_Cliam_Resp 处理函数
function MonthlySignController:noticeMonthlySignCliamResp(notification, data)
    if (self.monthlySignView) then
        self.monthlySignView:initProgress()
    end
    local cumulativeRewardData = mvc.monthlySignModel:getcumulativeRewardData()
    -- 展现获得物品
    self:showItemByIndex(cumulativeRewardData, nil, UI.TEXT_1170211, true)
    -- Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end

-- 根据下标展现物品
function MonthlySignController:showItemByIndex(rewardData, title, btnStr, isCumulative)
    -- 展现获得物品
    if (rewardData and #rewardData > 0) then
        local dropDisplayDataArr = {}
        require "app.datas.GoodsDataManager"
        for i,v in ipairs(rewardData) do
            local goodsData = string.split(v, ",")
            local goodsID = not isCumulative and goodsData[1] or goodsData[2]
            local dummyItem = GoodsDataManager:createLocalGoodsData(tonumber(goodsID))
            if(dummyItem) then
                local goodsNum = not isCumulative and goodsData[2] or goodsData[3]
                dummyItem:setNum(tonumber(goodsNum))
                table.insert(dropDisplayDataArr, dummyItem)
            end
        end

        if (#dropDisplayDataArr > 0) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_COMMON_REWARD, dropDisplayDataArr, nil, title, nil, nil, nil, nil, btnStr)  
        end
    end
end


return MonthlySignController
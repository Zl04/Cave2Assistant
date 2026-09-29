--[[--
控制器ActivityPointController，view已经注入,可以通过mvc.activityPointProxy访问
只有控制器能够接收和处理消息,同时能够向其他控制器发送消息
--]] ------------------------------------------------------------------------------
-- author: CMonk
-- date	: 2019/06/26
-- desc	: 
------------------------------------------------------------------------------
local ActivityPointController = class("ActivityPointController", mvc.GameController)

local ProtobufUtil = require("utils.ProtobufUtil")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")

local isInitData = false

-- 请求领取奖励
function ActivityPointController:requestActivityPointReward(requestStage)
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

    local currentStage = mvc.activityPointModel:getStage()
    if (not currentStage or requestStage ~= currentStage + 1) then return end
    Net.NetRoleSystem:requestActivityPointInfo(requestStage - 1)
end

-- 请求移动
function ActivityPointController:autoMove(idx,luaIndex)
    local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE
    local functionType = mvc.activityPointModel:mapIdxToFunType(idx)

    -- 自动打开页面
    local MachineManager = require("app.game.MachineManager")
    local machine = MachineManager:getInstance():getMachine()
    local isActivateFuncSucc = machine:openUIByFunctionType(functionType)
    if (not isActivateFuncSucc) then
        if (functionType == FUNCTION_TYPE.GUILD_TASK or functionType == FUNCTION_TYPE.FUNCTION_TYPE_GUILDBOSS) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112421) --[[请到公会场景使用此功能"]])
        else
            local activePointData = mvc.activityPointModel:getActivityFromIdx(luaIndex)
            if(activePointData) then
                UI.ScrollBar:createByTextID(activePointData.notice)
            else
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1112422) --[["此场景不可使用此功能"]])
            end
        end
    end
end

-- 根据下标展现物品
function ActivityPointController:showItemByIndex(idx, title, btnStr)
    -- 展现获得物品
    local rewardInfoArr = mvc.activityPointModel:getRewardArrFromID(idx)
    if (rewardInfoArr and #rewardInfoArr > 0) then
        local dropDisplayDataArr = {}
        require "app.datas.GoodsDataManager"
        for i,v in ipairs(rewardInfoArr) do
            local dummyItem = GoodsDataManager:createLocalGoodsData(v.goodsID)
            if(dummyItem) then
                dummyItem:setNum(v.goodsNum)
                table.insert(dropDisplayDataArr, dummyItem)
            end
        end

        if (#dropDisplayDataArr > 0) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_COMMON_REWARD, dropDisplayDataArr, nil, title, nil, nil, nil, nil, btnStr)  
        end
    end
end

-- mvc.events.ActivityPoint_Role_Daily_Action_Reward_Result_Message 处理函数
function ActivityPointController:noticeActivityPointRoleDailyActionRewardResultMessage(notification)
    local data = notification.params[1]
    if (data.result == ProtobufUtil:enum_id("RoleSystem.RoleDailyActionRewardResult", "RoleDailyActionRewardResult_Suc")) then 
        mvc.activityPointModel:setStage(data.stat)
        if (self.activityPointView) then
            self.activityPointView:updateStageView()
        end

        -- 展现获得物品
        self:showItemByIndex(data.stat, nil, LanguageManager:getInstance():getLocalString(1112117) --[["领取"]])
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    else
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111118) --[["系统错误"]])
    end
end

-- mvc.events.ActivityPoint_Role_Daily_Action_Info 处理函数 - 初始数据
function ActivityPointController:noticeActivityPointRoleDailyActionInfo(notification)
    local data = notification.params[1]
    
    -- 初始化或者提示
    require "app.datas.RoleDataManager"
    if (not isInitData) then
        isInitData = true
        
    elseif (RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DailyAction)) then
        local nowPoints = mvc.activityPointModel:getTotalPoint()
        local deltaPoints = data.curActions - nowPoints
        if (deltaPoints > 0) then
            Game.ChatManager:getInstance():sendSystemMsg(string.format(LanguageManager:getInstance():getLocalString(1112423) --[["获得%s活跃度"]], deltaPoints), ChatMessageType.SYSTEM_MESSAGE)        
        end
    end

    -- 更新数据
    mvc.activityPointModel:initNet(data)

    -- 更新显示
    if (mvc.activityPointView) then
        mvc.activityPointView:updateView()
    end
    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN) 
end

-- mvc.events.ActivityPoint_Update_Stage_View 处理函数 - 活跃度更新
function ActivityPointController:noticeActivityPointUpdateStageView(notification)
    if (mvc.activityPointView) then
        mvc.activityPointView:updateStageView()
    end
end



return ActivityPointController
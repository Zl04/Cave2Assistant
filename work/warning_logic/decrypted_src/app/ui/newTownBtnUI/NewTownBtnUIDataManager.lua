-- NewTownBtnUIDataManager.lua
NewTownBtnUIDataManager = NewTownBtnUIDataManager or {}
require "app.datas.SkillDataManager"
require "app.config.ConfigManager"
local SdkManager = require "app.game.SdkManager"
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")

-- openType定义：代表某个功能的识别ID
local NewTownBtnOpenType = {
    NewTownBtnOpenType_Setting = 1;             -- 设置
    NewTownBtnOpenType_Active_Task = 2;         -- 活跃任务
    NewTownBtnOpenType_Normal_Activity = 3;     -- 普通任务
    NewTownBtnOpenType_Trade_Activity = 4;      -- 缤纷活动
    NewTownBtnOpenType_Shop = 5;                -- 商店
    NewTownBtnOpenType_First_Pay = 6;           -- 特惠礼包（首充）
    NewTownBtnOpenType_Role_Bag = 7;            -- 背包
    NewTownBtnOpenType_Social_Contact = 8;      -- 社交
    NewTownBtnOpenType_Task = 9;                -- 任务
    NewTownBtnOpenType_Log = 10;                -- 日志
    NewTownBtnOpenType_Seven_Login = 11;        -- 七日（新手签到）
    NewTownBtnOpenType_Luck_Drop = 12;          -- 转盘抽奖
    NewTownBtnOpenType_Battle_Pass = 13;        -- 通行证
    NewTownBtnOpenType_Festival = 14;           -- 节日特使
    NewTownBtnOpenType_Festival_Activity = 15;  -- 节日活动
    NewTownBtnOpenType_Festival_Shop = 16;      -- 节日商城
    NewTownBtnOpenType_Apprenticeship = 17;     -- 师徒
    NewTownBtnOpenType_Friends = 18;            -- 交友
    NewTownBtnOpenType_Guild = 19;              -- 公会
    NewTownBtnOpenType_DayGift = 20;            -- 每日超值礼包
    NewTownBtnOpenType_Expedition = 21;         -- 探险队
    NewTownBtnOpenType_Apprentice1 = 22;        -- 学徒按钮1
    NewTownBtnOpenType_Apprentice2 = 23;        -- 学徒按钮2
    NewTownBtnOpenType_Mentor = 24;             -- 导师按钮
    NewTownBtnOpenType_ScreenRecord = 25;       -- 录制按钮
    NewTownBtnOpenType_Miracle = 26;            -- 神迹祈福
    NewTownBtnOpenType_SFSign = 27;             -- 春节签到
    NewTownBtnOpenType_LostRealm = 28;          -- 
    NewTownBtnOpenType_FALL_SIGN = 29;          -- 双节签到
    NewTownBtnOpenType_Anniversary_Sign = 30;          -- 周年签到

    NewTownBtnOpenType_QQ_dawanka = 31;         -- qq大玩咖
    NewTownBtnOpenType_QQ_tequan = 32;          -- qq特权
    NewTownBtnOpenType_Comeback = 33;           -- 返场活动
    NewTownBtnOpenType_MonthlySign = 34;           -- 月度签到
    NewTownBtnOpenType_Anniversary_Appointment = 35;           -- 周年庆预约
    NewTownBtnOpenType_Trial_Land = 36;           -- 活动副本:试炼之地
    NewTownBtnOpenType_Anniversary_Lottery = 37;  -- 周年庆抽奖
    NewTownBtnOpenType_CrystalTreature_Activity = 38;  -- 水晶夺宝抽奖
    NewTownBtnOpenType_CAVE_EXPLORING = 39;  --洞窟探宝
    NewTownBtnOpenType_TAP_LINK = 40;  --taptap跳转按钮  
    NewTownBtnOpenType_GREAT_NAVIGATION = 41;  --大航海
    NewTownBtnOpenType_EXP = 42;  --经验副本
    NewTownBtnOpenType_GLYPH = 43;  --雕纹
    NewTownBtnOpenType_Souvenir = 45;  --纪念品
}

-- 按钮所属区域划分
local NewTownBtnPosType = {
    NewTownBtnPosType_RightUp = 1;              -- 右边上面的位置
    NewTownBtnPosType_Right = 2;                -- 右边位置
    NewTownBtnPosType_RightBottom = 3;          -- 右边下面的位置
    NewTownBtnPosType_Special = 5;              -- 特殊区域（代码设置）
}

function NewTownBtnUIDataManager:init()
	self:updateTownBtnList()
end

-- 获取opentype列表
function NewTownBtnUIDataManager:getOpenTypeList()
    return NewTownBtnOpenType
end

-- 获取拥有所属区域类型列表
function NewTownBtnUIDataManager:getPosTypeList()
    return NewTownBtnPosType
end

-- 获取要显示的对应btnPosType的按钮信息列表，排序即显示排序
function NewTownBtnUIDataManager:getTownBtnListByPosType(posType)
    if self.townBtnList[posType] then
        return self.townBtnList[posType]
    end

    return {}
end

-- 获取对应btnOpenType的按钮信息，包括不在self.townBtnList里面的
function NewTownBtnUIDataManager:getTownBtnDataByOpenType(openType)
    if not openType then
        printError("openType is nil")
        return nil
    end

    local btnInfo = ConfigManager:getTownBtnData()
    for k, v in pairs(btnInfo) do
        if v.btnOpenType == openType then
            return ConfigManager:getTownBtnDataByID(v.ID)
        end
    end

    return nil
end

-- 加载刷新self.townBtnList
function NewTownBtnUIDataManager:updateTownBtnList()
    self.townBtnList = {}

    local townBtnConfig = ConfigManager:getTownBtnData()
    for k, v in pairs(townBtnConfig) do
        -- openType为4是附属按钮，没有自己的所属区域
        if v.btnPosType ~= 4 then
            if not self.townBtnList[v.btnPosType] then
                self.townBtnList[v.btnPosType] = {}
            end

            if self:getTownBtnIsShow(v.btnOpenType) then
                table.insert(self.townBtnList[v.btnPosType], v)
            end
        end
    end

    for index = 1, #self.townBtnList do
        table.sort(self.townBtnList[index], function (a,b)
            return a.btnOrder < b.btnOrder
        end)
    end
end

-- 按钮红点逻辑，如果无，则默认不显示红点，拥有附属按钮的主按钮会自动搜索附属按钮，附属按钮有红点时主按钮有红点
function NewTownBtnUIDataManager:getTownBtnRedPointShow(btnOpenType)
    if btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Setting then

    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Active_Task then
        if (mvc.activityPointModel:isAnyLimitTimeActivityRunning() or mvc.activityPointModel:getRewardNum() > 0) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Normal_Activity then
        local number = GameDataManager:getInstance():getNewActivityNum() + GameDataManager:getInstance():getActivityReceiveNum()
        if number > 0 then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Trade_Activity then
        if (mvc.tradeActivityModel:getTradeActivityBtnRedPointIsShow()) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Shop then
        local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
        local hasNewIapBox = globalUserData:hasNewIapBox()
        local hasNewIapBox2 = SdkManager:getInstance():haveNewIapBox()
        local isInStory = SceneManager:getInstance():isInStory()
        if not isInStory and (hasNewIapBox or hasNewIapBox2) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_First_Pay then
        if (mvc.tradeActivityModel:getTabRedPointIsShow(PublicDefine.TradeActivityIDList.TradeActivityFirstPay)) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Role_Bag then
        if(SceneManager:getInstance():isInHuLu()) then 
            -- 这里根据是否装满五个技能来设置是否显示小红点
            if mvc.festivalModel and mvc.festivalModel:getHuluChoiceWeaponType() ~= PublicDefine.WEAPON_TYPE.NONE 
                and not SkillDataManager:getIsFullChoiceBattleSkill(mvc.festivalModel:getHuluChoiceWeaponType()) then 
                return true
            end
        else
            if SkillDataManager:getSkillStudyNum() > 0 then
                return true
            end
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Task then
        local achevementListNum = MasterDataManager:getAchevementAwardList()
        local taskListNum = TaskDataManager:getTaskHaveCompleteNum()
        local pRed = PictureAlbumManager:isRedDot()
        if taskListNum + achevementListNum > 0  or pRed then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Seven_Login then  
        local signFinStat = mvc.sevenDaysModel:getSignFinishStateForGoal(SEVEN_DAY_SIGN)
        local signFinal = mvc.sevenDaysModel:checkCanGetFinalReward(SEVEN_DAY_SIGN)
        local taskFinStat = mvc.sevenDaysModel:getFinishStat(SEVEN_DAY_TASK)
        local taskFinal = mvc.sevenDaysModel:checkCanGetFinalReward(SEVEN_DAY_TASK)
        local giftBagReward = mvc.sevenDaysModel:checkCanGetFinalReward(SEVEN_DAY_GIFT)
        if (signFinStat or signFinal or taskFinStat or taskFinal or giftBagReward) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_FALL_SIGN then  
        local signFinStat = mvc.festivalSignModel:getSignFinishStateForGoal(FALL_FESTIVAL_SIGN)
        local signFinal = mvc.festivalSignModel:checkCanGetFinalReward(FALL_FESTIVAL_SIGN)
        local taskFinStat = mvc.festivalSignModel:getFinishStat(FALL_FESTIVAL_TASK)
        if (signFinStat or signFinal or taskFinStat) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Sign then  
        local signFinStat = mvc.festivalSignModel:getSignFinishStateForGoal(ANNIVERSARY_SIGN)
        -- local signFinal = mvc.festivalSignModel:checkCanGetFinalReward(ANNIVERSARY_SIGN)
        if (signFinStat) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Battle_Pass then
        local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_BattlePass)
        if isUnlock and not SceneManager:getInstance():isInFightScene() and mvc.battlePassModel:isHaveRward() then
            return true
        end   
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprenticeship then
        if (mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist()) 
            or (mvc.apprenticeshipModel:isMentorReqMet()) and (mvc.apprenticeshipModel:mentorIsMainButtonShowRedpoint())
            or ((mvc.apprenticeshipModel:isApprenticeReqMet() or mvc.apprenticeshipModel:getMentor()) and mvc.apprenticeshipModel:apprenticeIsMainButtonShowRedpoint()) then
                return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Friends then
        if Game.FriendManager:getInstance():isNewFlagOfAll() then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Guild then
        local guildData = MasterDataManager:getGuildData()
        local guildNew = false
        if(guildData and GameDataManager:getInstance():getMasterIsManage()) then
            guildNew = guildData:getHasJoinReq()
        end

        require "app.datas.GuildBoxDataManager"
        if guildNew or GuildBoxDataManager:getNewBoxFlag() then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Expedition then
        local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
        if (FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION)
            and not SceneManager:getInstance():isActivityCave() ) then

            if(mvc.expeditionModel:getIsNotNullForPacketType(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) or 
                mvc.expeditionModel:getIsNotNullForPacketType(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK)) then 
                return true
            end
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprentice1 then
        if not mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist() 
        and mvc.apprenticeshipModel:isMentorReqMet() 
        and table.nums(mvc.apprenticeshipModel:getApprenticeArr()) > 0 
        and mvc.apprenticeshipModel:mentorIsApprenticeShowRedpointByIndex(1) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprentice2 then
        if not mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist() 
        and mvc.apprenticeshipModel:isMentorReqMet() 
        and table.nums(mvc.apprenticeshipModel:getApprenticeArr()) > 1 
        and mvc.apprenticeshipModel:mentorIsApprenticeShowRedpointByIndex(2) then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Mentor then
        if not mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist() 
        and not mvc.apprenticeshipModel:isMentorReqMet() 
        and (mvc.apprenticeshipModel:isApprenticeReqMet() or mvc.apprenticeshipModel:getMentor())
        and mvc.apprenticeshipModel:getMentor() 
        and mvc.apprenticeshipModel:apprenticeIsMentorShowRedpoint() then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Miracle then
        return mvc.miracleModel:getIsShowRedHot()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_SFSign then
        return mvc.sFSignModel:canSign()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_LostRealm then
        return mvc.festivalModel:getLostRealmResPointStatus()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_MonthlySign then  
        return mvc.monthlySignModel:isShowMonthlySignRedPoint()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Appointment then  
        return mvc.anniversaryAppointmentModel:isShowRedPoint()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Trial_Land then  
        return mvc.activityModeCaveModel:isShowRedPoint()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Lottery then  
        return mvc.activityAnnivesaryLotteryModel:isShowRedPoint()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_CAVE_EXPLORING then  
        -- return mvc.activityAnnivesaryLotteryModel:isShowRedPoint()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_TAP_LINK then  
        return false
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_CrystalTreature_Activity then  
        return not SceneManager:getInstance():isInStory() and mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_GREAT_NAVIGATION then  
        -- return mvc.activityAnnivesaryLotteryModel:isShowRedPoint()
        
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Souvenir then
        return mvc.souvenirModel:isShowRedPoint()
    end

    -- 拥有附属按钮的按钮红点显示跟随附属按钮
    local btnData = self:getTownBtnDataByOpenType(btnOpenType)
    if btnData and btnData.relateTo and table.nums(btnData.relateTo) > 0 then
        for _, v in pairs(btnData.relateTo) do
            if self:getTownBtnRedPointShow(v) then
                return true
            end
        end
    end

    return false
end

-- 配置表中的存在的btnOpenType默认按钮显示，这里添加特殊的显示逻辑
function NewTownBtnUIDataManager:getTownBtnIsShow(btnOpenType)
    if btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Trade_Activity then
        if (not SceneManager:getInstance():isInStory() and table.nums(mvc.tradeActivityModel:getOpenTradeActivityIdList()) > 0) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_First_Pay then
        if (SceneManager:getInstance():isNotInFightScene()) 
        and mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityFirstPay) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Seven_Login then 
        if (mvc.sevenDaysModel:isOpenGoal(SEVEN_DAY_TASK)) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_FALL_SIGN then 
        if (mvc.festivalSignModel:isOpenGoal(FALL_FESTIVAL_TASK)) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Sign then 
        if (mvc.festivalSignModel:isOpenGoal(ANNIVERSARY_SIGN)) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Battle_Pass then
        local isUnlock = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_BattlePass)
        if isUnlock and not SceneManager:getInstance():isInFightScene() then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Festival then
        local festivalActivity = self:getTownBtnIsShow(NewTownBtnOpenType.NewTownBtnOpenType_Festival_Activity)
        local festivalShop = self:getTownBtnIsShow(NewTownBtnOpenType.NewTownBtnOpenType_Festival_Shop)
        if not festivalActivity and not festivalShop then
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Festival_Activity then
        local isUnlock = self:checkFunctionTypeIsUnlock(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL)
        local dataArr = MasterDataManager:getActivityDataArr()
        self.festivalData = nil
        for k, v in pairs(dataArr) do
            if v:getType() == PublicDefine.ActivityType.ActivityType_Festival then
                self.festivalData = v
                break
            end
        end

        if not isUnlock or not self.festivalData then
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Festival_Shop then
        local isUnlock = self:checkFunctionTypeIsUnlock(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL_EXCHANGE_SHOP)
        local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_ExchangeShop)
        if not isUnlock or not activityData then
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprenticeship then
        if (mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist())
            or (mvc.apprenticeshipModel:isMentorReqMet() and table.nums(mvc.apprenticeshipModel:getApprenticeArr()) < 2)
            or (mvc.apprenticeshipModel:isApprenticeReqMet() or mvc.apprenticeshipModel:getMentor()) and not mvc.apprenticeshipModel:getMentor() then
                return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Friends then
        local unLockStateFriend = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_FriendShip)
        local isInActivityCave = SceneManager:getInstance():isActivityCave()
        if unLockStateFriend and not isInActivityCave then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Guild then
        local isInActivityCave = SceneManager:getInstance():isActivityCave()
        local unLockStateGuild = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Guild)
        if unLockStateGuild and not isInActivityCave then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_DayGift then
        if not mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityDailyGiftBag) then
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Expedition then
        local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
        if (FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION)
            and not SceneManager:getInstance():isActivityCave() ) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprentice1 then
        if not mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist() 
        and mvc.apprenticeshipModel:isMentorReqMet() 
        and table.nums(mvc.apprenticeshipModel:getApprenticeArr()) > 0 then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprentice2 then
        if not mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist() 
        and mvc.apprenticeshipModel:isMentorReqMet() 
        and table.nums(mvc.apprenticeshipModel:getApprenticeArr()) > 1 then
            return true
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Mentor then
        if not mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist() 
        and not mvc.apprenticeshipModel:isMentorReqMet() 
        and (mvc.apprenticeshipModel:isApprenticeReqMet() or mvc.apprenticeshipModel:getMentor())
        and mvc.apprenticeshipModel:getMentor() then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_ScreenRecord then
        -- if device.platform == "ios" and ScreenRecordUtil:getInstance():getRecorderOn() then
        --     return true
        -- else
        --     return false
        -- end
        -- 策划要求暂时屏蔽
        return false
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Normal_Activity then
        if(ServerConfigUtil:isInReview()) then 
            return false
        end
        return true
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Miracle then
        if (RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_MiraclePrayer)) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_SFSign then
        return mvc.sFSignModel:getOpenSFSign()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_LostRealm then
        return mvc.festivalModel:getLostRealmStatus()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_QQ_dawanka or btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_QQ_tequan then

        local SdkBox = require("utils.sdkbox.SdkBox")
        local versionTarget = SdkBox:getInstance():getVersionTarget()
        if versionTarget ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_QQ_HALL then
            return false
        else
            return true
        end

    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Comeback then
        if mvc.comebackPackageModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityComeback) then
            local iapDatas = mvc.comebackPackageModel:getPackageData()
            if table.nums(iapDatas) > 0 then
                return true
            else 
                return false
            end
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_MonthlySign then
        return mvc.monthlySignModel:isShowMonthlySignBtn()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Appointment then
        return mvc.anniversaryAppointmentModel:getActivityIsShow()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Trial_Land then
        return mvc.activityModeCaveModel:getActivityIsOpening()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Lottery then
        return mvc.activityAnnivesaryLotteryModel:getAnniversaryLotteryIsShowBtn()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_CAVE_EXPLORING then
        return true
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_TAP_LINK then
        return ImageDownLoadUtil:getTapTapBtnIsShow()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_CrystalTreature_Activity then
        if not SceneManager:getInstance():isInStory() 
        and mvc.tradeActivityModel:getActivityIsOpeningTimeByID(PublicDefine.TradeActivityIDList.TradeActivityCrystalTreature) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_GREAT_NAVIGATION then
        return mvc.bigSailPortModel:getPortBtnIsSHow()
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_EXP then
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Exp) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_GLYPH then
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Glyph) then
            return true
        else
            return false
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Souvenir then
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Souvenir) then
            return true
        else
            return false
        end
    end

    -- 配置表中不存在该按钮，则不显示
    local btnData = self:getTownBtnDataByOpenType(btnOpenType)
    if not btnData then
        return false
    end

    return true
end

-- 依据openType调用按钮点击逻辑
function NewTownBtnUIDataManager:callTownBtnClick(btnOpenType)
    local functionType = nil
    if btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Setting then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_SETTINGS)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Active_Task then
        mvc.openPanel("ActivityPoint", "ActivityPoint")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Normal_Activity then
        unctionType = PublicDefine.FUNCTION_TYPE.ACTIVITY
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_ACTIVITY_PANEL, 0, PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_MiniMap)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Trade_Activity then
        mvc.openPanel("TradeActivity", "TradeActivityMain")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Shop then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, true, 1, nil, 
            PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_MiniMap)
        local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
        globalUserData:markNewIapBox()
        Avalon.UserDataManager:saveDataToFile(globalUserData:getType())
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_First_Pay then
        mvc.openPanel("TradeActivity", "TradeActivityFirstPay")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Role_Bag then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Task then
        functionType = PublicDefine.FUNCTION_TYPE.TASK
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_FUNCTION_PANEL)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Log then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_FUNCTION_PANEL, 2)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Seven_Login then 
        mvc.openPanel("SevenDays", "SevenDays", {planType = SEVEN_DAY_TASK, signInType = SEVEN_DAY_SIGN})
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_FALL_SIGN then 
        mvc.openPanel("FestivalSign", "FestivalSign", {planType = FALL_FESTIVAL_TASK , signInType = FALL_FESTIVAL_SIGN})
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Sign then 
        mvc.openPanel("FestivalSign", "FestivalSign", {signInType = ANNIVERSARY_SIGN})
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Luck_Drop then
        functionType = PublicDefine.FUNCTION_TYPE.LUCKYWHEEL_TURN
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LUCKDROP)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Battle_Pass then
        mvc.openPanel("BattlePass", "BattlePass") 
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Festival_Activity then
        functionType = PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL
        mvc.openPanel("Festival", "Festival")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Festival_Shop then
        if(MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_ExchangeShop)) then
            functionType = PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_FESTIVAL_EXCHANGE_SHOP
            mvc.openPanel("Festival" ,"FestivalExchangeShop")
        else
            UI.ScrollBar:createByTextID(1112681)
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprenticeship then
        if (mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist()) then
            mvc.openPanel("Apprenticeship", "ApprenticeshipApprenticeGraduate")
        elseif (mvc.apprenticeshipModel:isMentorReqMet()) then
            mvc.openPanel("Apprenticeship", "ApprenticeshipReceive")
        elseif (mvc.apprenticeshipModel:isApprenticeReqMet()) then
            mvc.openPanel("Apprenticeship", "ApprenticeshipApply")
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Friends then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_FRIEND_MAIN)
        Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_FriendShip)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Guild then
        local guildData = MasterDataManager:getGuildData()
        if(guildData) then
            functionType = PublicDefine.FUNCTION_TYPE.GUILD_MANAGER
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_GUILD_MANAGER)
        else
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_GUILD_CREATE_OR_JOIN)
        end
        Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Guild)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_DayGift then
        mvc.openPanel("TradeActivity", "TradeActivityMain", PublicDefine.TradeActivityIDList.TradeActivityDailyGiftBag)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Expedition then
        local data = nil
        if(SceneManager:getInstance():isInFightScene()) then 
            data = {}
            
            data.mode = GameMapManager:getInstance():getModel()
            data.level = GameMapManager:getInstance():getLevel()
        end
        mvc.send("Open_Panel","Expedition", nil, data)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprentice1 then
        mvc.openPanel("Apprenticeship", "ApprenticeshipMentor", 1)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Apprentice2 then
        mvc.openPanel("Apprenticeship", "ApprenticeshipMentor", 2)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Mentor then
        mvc.openPanel("Apprenticeship", "ApprenticeshipApprentice")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Miracle then
        mvc.openPanel("Miracle", "Miracle")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_SFSign then
        if SceneManager:getInstance():isInFightScene() then
            UI.ScrollBar:createByText(UI.TEXT_1213854)
            return
        end

        mvc.openPanel("SFSign", "SFSign")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_LostRealm then
        -- if SceneManager:getInstance():isInFightScene() then
        --     UI.ScrollBar:createByText(UI.TEXT_1213854)
        --     return
        -- end
        local curTabActData = mvc.festivalModel:getLostRealmFestivalData()
        
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        local spriteID = 0
        if(machine) then
            local model = machine:getModel()
            if(model) then 
                local enterModelArr = model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
                if(enterModelArr and #enterModelArr > 0) then 
                    spriteID = enterModelArr[1]:getSpriteID()
                end
            end
        end

        Net.NetRoleSystem:heroEnterCaveSceneRequest(
        PublicDefine.GAME_MODE.MODE_SOLO,
        PublicDefine.CAVE_MODE.MODE_ACT,
        PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1,
        PublicDefine.CONST_DEFINITION.LOST_REALM_MAP_ID,
        spriteID, false, curTabActData.activityID)
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Comeback then
        mvc.openPanel("ComebackPackage", "ComebackPackage")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_MonthlySign then 
        mvc.openPanel("MonthlySign", "MonthlySign")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Appointment then 
        mvc.send("AnniversaryAppointment_Open_Main_View")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Trial_Land then 
        mvc.send("ActivityModeCave_Request_Cave_Data")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Anniversary_Lottery then 
        mvc.send("ActivityAnnivesary_Open_Main_View")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_CrystalTreature_Activity then
        mvc.openPanel("TradeActivity", "TradeActivityCrystalCapture")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_TAP_LINK then
        local tNoticeList = ImageDownLoadUtil:getTapTNoticeInfo()
        if next(tNoticeList) then
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_TOEWN_NOTICE, tNoticeList) 
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_CAVE_EXPLORING then
        mvc.openPanel("CaveExploring", "CaveExploring")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_GREAT_NAVIGATION then 
        -- 判断是否在公会中
        local GameDataManager = require("app.game.GameDataManager")

        if GameDataManager:getInstance():getIsJoinGuild() then
            if SceneManager:getInstance():isInTownRelated() then
                Net.NetBigSailSystem:reqEnterBigSailScene(RoleDataManager:getMasterPK())
            else
                -- UI.ScrollBar:createByText(UI.TEXT_228500)
            end
        else
            UI.ScrollBar:createByText(UI.TEXT_226173)
        end
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_EXP then
        mvc.openPanel("DungeonExpFight", "DungeonExpFight")
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_GLYPH then
    elseif btnOpenType == NewTownBtnOpenType.NewTownBtnOpenType_Souvenir then
        mvc.openPanel("Souvenir", "Souvenir")
    else
        printError("this btnOpenType is no openWay, btnOpenType : ".. btnOpenType)
    end

    if(functionType) then 
        RedPointManager:triggerNewRedPointFlag(functionType)
        Net.NetRoleSystem:reqOpenFuntionTypeUI(functionType)
    end
end

-- 调用原本的接口验证functionType的按钮是否解锁了
function NewTownBtnUIDataManager:checkFunctionTypeIsUnlock(functionType)
    local functionTypeArr = {functionType}
    functionTypeArr = Game.FunctionUnlockManager:getInstance():checkNpcFunction(functionTypeArr)
    if #functionTypeArr == 0 then
        return false
    else
        return true
    end
end

NewTownBtnUIDataManager:init()
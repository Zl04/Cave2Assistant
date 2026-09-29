--GlobalUserData.lua
--2017-04-27
--Author:zp
--记录全局的玩家数据

require "utils.userdata.UserData"

Avalon = Avalon or {}

local GlobalUserData = class("GlobalUserData", Avalon.UserData)
Avalon.GlobalUserData = GlobalUserData


-- private:
-- 构造函数
function GlobalUserData:ctor()
    GlobalUserData.super.ctor(self, USER_DATA_TYPE.GLOBAL)

    -- TODO 定义相关数据
    -- 是否需要显示结算页面
    self._isShowReward = false
    self._rewardData = nil

    -- 
    self._gameComplete = false
    self._useEscapeScrollBackTown = false
    -- 打开得存档点
    self._openCheckpointArr = {}

    -- 任务数据 table
    self._acceptTaskArr = {}
    -- 商城钻石
    self._iapProducts = {}
    self._iapBoxs = {}
    -- 上一次提示绑定账号时间
    self._lastBindToastTime = 0;
    -- 是否永久忽略提示绑定账号
    self._ignorelBindToast = false;

    -- 藏宝图只播放一次领取完成的动画的标记
    self._treasureCompleteAnimationMap = {}

    -- 那些活动被点击了
    self._activityClickMap = {}

    -- 绑定的邮箱
    self._bindEmail = ""

    self._hasNewIapBox = true

    -- 是否隐藏墙体
    self._isHideWall = false

    -- 是否屏蔽私聊
    self._isReceivePM = true
    -- 是否隐藏魂器
    self._settingIsHideHorcrux = false
    -- 是否隐藏宠物
    self._settingIsHidePet = false
    -- 是否第一次成功回城了
    self._isFristSuccessBackTown = false

    -- 任务快捷栏的展开或缩进状态
    self._quickSideBarUnfold = false

    -- 公会许愿池许愿时间戳
    self._guildWishPoolTimestamp = 0

    self._guildLogVersion = 0
    self._guildMinVersion = 0
    self._guildLogData = {}
    -- 自动战斗的定义,默认为 2
    self._autoBattleOrder = 2
    self._autoBattleStatus = false

    -- 画质自定义模式
    self.customHQMode = 2
    self.customWeather = true
    self.customNPC = true
    self.customFrame = true
    self.customDecorate = true
    self.customFloats = true
    self.customHorcrux = false
    self.customPet = false
    self.customPersonCount = 2

    self.customDefultSetting = false
    self.customDefultToast = false

    self.guildSortType = {1, 1, 1}

    -- 功能星
    self.newRedPointArr = {}

    -- 用于记录玩家抽奖测试以及对应的那天
    self.lotteryRefreshDay = 0
    self.lotteryRefreshNum = 0

    --画册红点数据记录
    self._pictureAlbumRedDotData = {}

    -- 纪念品红点数据记录
    self._souvenirRedDotData = {}

    self._rData = {}

    -- 虫洞深处铭文货币数量
    self._enterCaveInscription = 0
end

-- 藏宝图只播放一次领取完成的动画的标记
function GlobalUserData:setTreasureCompleteAnimationMap(treasureCompleteAnimationMap)
    self._treasureCompleteAnimationMap = treasureCompleteAnimationMap
end
function GlobalUserData:getTreasureCompleteAnimationMap()
    return self._treasureCompleteAnimationMap
end

function GlobalUserData:setIsShowReward(showReward)
    self._isShowReward = showReward
end

function GlobalUserData:getIsShowReward()
    return self._isShowReward
end

function GlobalUserData:getRewardData()
    return self._rewardData
end

function GlobalUserData:setRewardData(rewardData)
    self._rewardData = rewardData
end

function GlobalUserData:getGameComplete()
    return self._gameComplete
end

function GlobalUserData:setGameComplete(gameComplete)
    self._gameComplete = gameComplete
end

function GlobalUserData:getEscapeScrollBackTown()
    return self._useEscapeScrollBackTown
end

function GlobalUserData:setEscapeScrollBackTown(useScroll)
    self._useEscapeScrollBackTown = useScroll
end

function GlobalUserData:getBindEmail()
   return self._bindEmail
end

function GlobalUserData:setBindEmail(bindEmail)
   self._bindEmail = bindEmail
end

function GlobalUserData:getOpenCheckpointData(caveMode,caveDifficulty)
    caveMode = string.format("%s", caveMode)
    caveDifficulty = string.format("%s", caveDifficulty)
    if(self._openCheckpointArr[caveMode] == nil) then
        return nil
    end

    return self._openCheckpointArr[caveMode][caveDifficulty]
end

function GlobalUserData:setOpenCheckpointData(caveMode,caveDifficulty,checkpoint)
    caveMode = string.format("%s", caveMode)
    caveDifficulty = string.format("%s", caveDifficulty)
    if(self._openCheckpointArr[caveMode] == nil) then
        self._openCheckpointArr[caveMode] = {}
    end
    self._openCheckpointArr[caveMode][caveDifficulty] = checkpoint
end

-- 获取接受任务顺序列表
function GlobalUserData:getAcceptTaskArr()
    return self._acceptTaskArr
end

-- 添加任务保存
function GlobalUserData:addTask(taskData)
    if(taskData == nil) then
        return
    end

    table.insert(self._acceptTaskArr, taskData:getId())
end

-- 移除任务
function GlobalUserData:removeTask(taskData)
    if(taskData == nil) then
        return
    end

    local removeID = taskData:getId()
    for i=1, #self._acceptTaskArr do 
        if(self._acceptTaskArr[i] == removeID) then
            table.remove(self._acceptTaskArr, i)
            break
        end
    end
end
-- 是否永久忽略提示绑定账号
function GlobalUserData:isIgnoreBindToast()
    return self._ignorelBindToast
end
function GlobalUserData:ignoreBindToast()
    self._ignorelBindToast = true
end
-- 获取上次提示绑定账号时间
function GlobalUserData:getLastBindToastTime()
    return self._lastBindToastTime
end
-- 设置提示绑定账号时间
function GlobalUserData:markBindToastTime()
    self._lastBindToastTime = os.time()
end
function GlobalUserData:setIapBoxs(boxs)
    self._iapBoxs = boxs
end
function GlobalUserData:getIapBoxs()
    return self._iapBoxs;
end
-- 是否还未点击此项
function GlobalUserData:isNewDiamondIap(id)
    return self._iapProducts[tostring(id)] ~= true;
end
-- 是否还未点击此项
function GlobalUserData:markDiamondIap(id)
    self._iapProducts[tostring(id)] = true
end
-- 清理所有任务数据
function GlobalUserData:clearAllTaskData()
    self._acceptTaskArr = {}
end

-- 添加点击活动
function GlobalUserData:addClickActivity(id)
    self._activityClickMap[tostring(id)] = true
end

-- 判断是否点击过该活动
function GlobalUserData:isHaveClickActivityID(id)
    if(self._activityClickMap[tostring(id)]) then
        return true 
    end

    return false
end

function GlobalUserData:hasNewIapBox()
    return self._hasNewIapBox
end
function GlobalUserData:markNewIapBox()
    self._hasNewIapBox = false
end
function GlobalUserData:isHideWall()
   return self._isHideWall
end
function GlobalUserData:hideWall(visible)
    self._isHideWall = visible;
end
function GlobalUserData:print()
    dump(self)
end
function GlobalUserData:isReceivePM()
   return self._isReceivePM
end
function GlobalUserData:receivePM(pm)
    self._isReceivePM = pm
end

function GlobalUserData:fristSuccessBackTown()
    self._isFristSuccessBackTown = true
end

function GlobalUserData:getFristSuccessBackTown()
    return self._isFristSuccessBackTown
end

function GlobalUserData:setQuickSideBarUnfold(flag)
    self._quickSideBarUnfold = flag
end

function GlobalUserData:getQuickSideBarUnfold()
    return self._quickSideBarUnfold
end

function GlobalUserData:setGuildWishPoolTimestamp(timeStamp)
    self._guildWishPoolTimestamp = timeStamp
end

function GlobalUserData:getGuildWishPoolTimestamp()
    return self._guildWishPoolTimestamp
end

function GlobalUserData:setGuildLogVersion(version)
    self._guildLogVersion = version
end

function GlobalUserData:getGuildLogVersion()
    return self._guildLogVersion
end

function GlobalUserData:setGuildLogData(data)
    self._guildLogData = data
end

function GlobalUserData:getGuildLogData()
    return self._guildLogData
end

function GlobalUserData:setGuildMinVersion(version)
    self._guildMinVersion = version
end

function GlobalUserData:getGuildMinVersion()
    return self._guildMinVersion
end

function GlobalUserData:setSettingCustomHQMode(mode)
    self.customHQMode = mode
end

function GlobalUserData:getSettingCustomHQMode()
    return self.customHQMode
end

function GlobalUserData:setSettingShowWeather(data)
    self.customWeather = data
end

function GlobalUserData:getSettingShowWeather()
    return self.customWeather
end

function GlobalUserData:setSettingShowNPC(data)
    self.customNPC = data
end

function GlobalUserData:getSettingShowNPC()
    return self.customNPC
end

function GlobalUserData:setSettingShowFrame(data)
    self.customFrame = data
end

function GlobalUserData:getSettingShowFrame()
    return self.customFrame
end

function GlobalUserData:setSettingShowDecorate(data)
    self.customDecorate = data
end

function GlobalUserData:getSettingShowDecorate()
    return self.customDecorate
end

function GlobalUserData:setSettingShowFloats(data)
    self.customFloats = data
end

function GlobalUserData:getSettingShowFloats()
    return self.customFloats
end

function GlobalUserData:setSettingIsHideHorcrux(data)
    self.customHorcrux = data
end

function GlobalUserData:getSettingIsHideHorcrux()
    return self.customHorcrux
end

function GlobalUserData:setSettingIsHidePet(data)
    self.customPet = data
end

function GlobalUserData:getSettingIsHidePet()
    return self.customPet
end

function GlobalUserData:setSettingShowPersonCount(data)
    self.customPersonCount = data
end

function GlobalUserData:getSettingShowPersonCount()
    return self.customPersonCount
end

function GlobalUserData:setCustomDefultSetting()
    self.customDefultSetting = true
end

function GlobalUserData:getCustomDefultSetting()
    return self.customDefultSetting
end

function GlobalUserData:setCustomDefultToast()
    self.customDefultToast = true
end

function GlobalUserData:getCustomDefultToast()
    return self.customDefultToast
end

function GlobalUserData:setGuildSortType(data)
    self.guildSortType = data
end

function GlobalUserData:getGuildSortType()
    return self.guildSortType
end

function GlobalUserData:setLotteryRefreshDay(lotteryRefreshDay)
    self.lotteryRefreshDay = lotteryRefreshDay
end

function GlobalUserData:getLotteryRefreshDay()
    return self.lotteryRefreshDay
end

function GlobalUserData:setLotteryRefreshNum(lotteryRefreshNum)
    self.lotteryRefreshNum = lotteryRefreshNum
end

function GlobalUserData:getLotteryRefreshNum()
    return self.lotteryRefreshNum
end

function GlobalUserData:getAutoBattleID()
    return self._autoBattleOrder or 2
end

function GlobalUserData:setAutoBattleID(id)
    self._autoBattleOrder = id
end

function GlobalUserData:getAutoBattleStatus()
    return self._autoBattleStatus or false
end

function GlobalUserData:setAutoBattleStatus(status)
    self._autoBattleStatus = status
end

function GlobalUserData:getNewRedPointArr()
    return self.newRedPointArr
end

function GlobalUserData:setNewRedPointArr(newRedPointArr)
    self.newRedPointArr = newRedPointArr
end

function GlobalUserData:getPictureAlbumRedDotData()
    return self._pictureAlbumRedDotData
end

function GlobalUserData:setPictureAlbumRedDotData(pictureAlbumRedDotData)
    self._pictureAlbumRedDotData = pictureAlbumRedDotData
end

function GlobalUserData:getSouvenirRedDotData()
    return self._souvenirRedDotData
end

function GlobalUserData:setSouvenirRedDotData(souvenirRedDotData)
    self._souvenirRedDotData = souvenirRedDotData
end


function GlobalUserData:getPayRData()
    return self._rData
end

function GlobalUserData:setPayRData(rData)
    self._rData = rData
end

function GlobalUserData:getEnterCaveInscription()
    return self._enterCaveInscription
end

function GlobalUserData:setEnterCaveInscription(enterCaveInscription)
    self._enterCaveInscription = enterCaveInscription
end

--[[
    负责记录主角特有的数据
]]

require("app.datas.goods.BlackShopData")

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

require "app.config.ConfigManager"
require "app.datas.guild.GuildData"
require "app.datas.activity.ActivityData"
require "app.datas.battle.DspDamageData"
require "app.datas.common.WorldEventData"

local ProtobufUtil = require("utils.ProtobufUtil")

local bit = require "bit"
MasterDataManager = MasterDataManager or {}

local DEBUG = false


function MasterDataManager:init()
    self._maxEquipScore = 0         -- 最大装备分数

    self._treasureMapList = {}      --当前已经领取的藏宝图数据

    self._blackShopDataArr = {}      -- 保存黑商的数据信息
    self._blackMarketHour = 0       -- 黑商刷新小时

    self._randomShopDataArr = {}   -- 保存随机商店的数据
    self._randomShopHour = 0       -- 随机商店刷新消失

    self._pokedexList = {}          --怪物图鉴信息

    self._turnTableData = {}     --转盘数据 {dropListId = 0, hasBuyNum = 0, leftTurnNum = 0}
    self:clearTurnTableData()

    -- 公会申请界面的处理逻辑
    self._searchGuildList = {}
    -- 上次搜索的时间
    self._preSearchTime = 0

    self._dungeonSeasonData = {}
    -- 公会信息
    self._guildData = nil
    -- 申请列表
    self._guildJoinApply = {}

    -- 公会科技信息
    self._guildTechData = nil
    -- 公会技能信息(包含基础信息)
    self._guildSkillData = nil
    -- 处理修改头衔时间
    self._changeTitleTime = 0
    -- 玩家登陆时充值数
    self._payMoneyNum = 0
    -- 保存技能参数修改数据结构，里面还有相关的类型处理 {PublicDefine.EObjectType ={},PublicDefine.EObjectType={})
    self._skillVariationArr = {}
    self._dungeonRanking = nil --  -1表示未上榜
    self._achievementData = nil -- 玩家成就数据

    self._isHaveNewMail = false
    -- 保存重复操作处理的MAP数据  key:RepeatHandleType value:自定义结构
    self._repeatHandleMap = {}
    self._funnyRecord = {} -- 玩家趣味数据

    -- 活动数据
    self._activityData = {}
    --英雄模式数据（刷新 时间 和 特殊事件， 字段结构 参考 PB roleSystem.HeroCaveSchemeDataMessage）
    self._heroCaveData = {}

    self._titanHeroCaveData = {} -- 泰坦之路英雄模式数据（刷新 时间 和 特殊事件， 字段结构 参考 PB roleSystem.HeroCaveSchemeDataMessage）

    --禁言频道
    self._banChatList = {}
    --排行榜数据
    self:initRankData()
    --宝石抽卡数据
    self._gemstoneShopRecord = {}
    -- 梦境上周排行前10的玩家数据
    self._period = 0
    self._refreshRankData = false
    self._preDreamRankHeroDetailData = {}
    self._preDreamRankData = {}
    
    --人物天赋数据
    self._roleTalent = {}
    self._fullBagData = {}          --背包满数据

    -- 上次购买索引
    self.specialOfferIndex = 0

    --梦境数据
    self._dreamData = {}
    self._dreamTempData = {}
    self._bStopFullBagTimeOut = false;  --暂停倒计时
    self.mSchedulerID = 0;
    local scheduler=cc.Director:getInstance():getScheduler()
    self.mSchedulerID = scheduler:scheduleScriptFunc(handler(self,self.schedulerTimeOut),1,false)

    -- 超值礼包提示开关
    self.extraGiftClick = false

    -- 物品打开消息
    self._goodsUseInfo = {}

    --扭曲控件boss相关数据锁定
    self._curCaveBossInfoCache = {}

    -- 扭曲空间事件
    self._worldEventArr = {}
    self._worldEventRefreshDay = 0
    self.refreshDay = 0
    self._spaceFightCount = {} --扭曲空间精英模式挑战次数

    -- 洞窟迷阵数据列表 数据结构如下{x:{y:{}}}
    self._mazePointArr = {}

    --首通奖励数据
    self._battlePassData = {}

    --背包宠物 petRoledata
    self._petsList = {}

    --兽栏状态
    self._siteList = {}
    -- self._fightPet = nil
    self._fightPet = {}
    self.captainPet = nil
    self._ridePet = nil
    self._petParam ={}

    self._antiData = {} --防沉迷数据

    -- 背包解锁
    self.unlockBagTimes = 0
    self.unlockWarehouseTimes = 0   
    self.unlockBagTimesItem = 0
    self.unlockWarehouseTimesItem = 0  

    -- 雕纹背包
    self.unlockGlyphBagTimes = 0 -- 雕纹背包解锁次数
    self.unlockGlyphBagItem = 0 -- 雕纹总解锁的格子数
    self.glyphInitialBag = tonumber(ConfigManager:getGeneralForKey("glyphInitialBag")) 

    -- 处理状态唯一性
    -- 是否显示7日页面
    self.showSevenStatus = true
    -- 扭曲扫荡数据
    self.sweepDistortedSpaceNum = 0

    --宠物探险进度
    self.petAdvCurLevel = nil
    --宠物探险数据
    self.petAdvata = {}

    -- boss直达数据
    self.bossPortalData = {}

    --探索总经验
    self.exploreExp = 0
    --探索等级
    self.exploreLv = 1
    --当前剩余探索经验
    self.exploreLeftExp = 999
    --商店购买全量数据
    self.buydata = {}

    self.limitTimeLoginTaskOpenStat = false -- 限时登录活动任务开启标志
    self.limitTimeLoginTaskData = {}    --限时登录活动任务数据

    self.petUnlockSkinList = {}  -- 已拥有的宠物皮肤 

    --进入战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ENTER_BATTLE, self, self.stopFullBagTimeOut)
    --退出战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE, self, self.resumeFullBagTimeOut)
    --进入答题
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ANSWER_IS_SHOWING, self, self.stopFullBagTimeOut)
    --退出答题
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ANSWER_IS_CLOSED, self, self.resumeFullBagTimeOut)
    --显示复活界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE, self, self.stopFullBagTimeOut)
    --复活成功
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.resumeFullBagTimeOut)
end

function MasterDataManager:clear()
    self._maxEquipScore = 0
    self._treasureMapList = {}      --当前已经领取的藏宝图数据
    self._turnTableData = {}       --转盘数据
    self:clearTurnTableData()
    self._dungeonSeasonData = {}
    self._pokedexList = {}          --怪物图鉴信息
    self._fullBagData = {}          --背包满数据
    self._guildData = nil
    self.showSevenStatus = true
    -- 申请列表
    self._guildJoinApply = {}
    -- 公会科技信息
    self._guildTechData = nil
    -- 公会技能信息
    self._guildSkillData = nil
    -- 处理修改头衔时间
    self._changeTitleTime = 0
    self._payMoneyNum = 0
    -- 保存技能参数修改数据结构
    self._skillVariationArr = {}
    self._dungeonRanking = nil --  -1表示未上榜
    self._achievementData = nil -- 玩家成就数据
    self._repeatHandleMap = {}
    self._funnyRecord = {} -- 玩家趣味数据

    self._blackShopDataArr = {}
    self._blackMarketHour = 0       -- 黑商刷新小时

    self._randomShopDataArr = {}
    self._mazePointArr = {}

    self._period = 0
    self._refreshRankData = false
    self._preDreamRankHeroDetailData = {}
    self._preDreamRankData = {}

    -- 公会申请界面的处理逻辑
    self._searchGuildList = {}
    -- 上次搜索的时间
    self._preSearchTime = 0

    self._activityData = {}
    self._heroCaveData = {}  --英雄模式 数据结构
    self._titanHeroCaveData = {}

    self._banChatList = {}
    self:initRankData()
    --宝石抽卡数据
    self._gemstoneShopRecord = {}
    --人物天赋数据
    self._roleTalent = {}
    --梦境数据
    self._dreamData = {}
    self._dreamTempData = {}
    self._bStopFullBagTimeOut = false;
    self._isHaveNewMail = false

    self.extraGiftClick = false
    self._goodsUseInfo = {}
    self._worldEventArr = {}
    self._worldEventRefreshDay = 0
    self.refreshDay = 0
    self._spaceFightCount = {}
    --首通奖励数据
    self._battlePassData = {}
    --背包宠物 petRoledata
    self._petsList = {}
    --兽栏状态
    self._siteList = {}
    -- self._fightPet = nil
    self._fightPet = {}
    self.captainPet = nil
    self._petParam ={}
    self._antiData = {} --防沉迷数据
    --宠物探险进度
    self.petAdvCurLevel = nil
    --宠物探险数据
    self.petAdvata = {}
    -- boss直达数据
    self.bossPortalData = {}

    -- self.limitTimeLoginTaskOpenStat = false -- 限时登录活动任务开启标志

    self.petUnlockSkinList = {}  -- 已拥有的宠物皮肤 
    
    self.specialOfferIndex = 0

    if(EquipForgeDataManager) then
        EquipForgeDataManager:clear()
    end
end

-- 进入下一层清理数据
function MasterDataManager:nextFloorClear()
    local gameInCaveData = self:getSaveGameInCaveData()
    if(gameInCaveData) then
        gameInCaveData:clearAllDeformation()
    end

end

-- 回档（恢复）清理数据
function MasterDataManager:restoreClear()
    self._maxEquipScore = 0
    -- 回档（恢复）清理数据
    self._fullBagData = {}
    self._mazePointArr = {}

    self._bStopFullBagTimeOut = false;
    -- 成就回档
    self._achievementData = nil;
    --首通奖励数据
    self._battlePassData = {}
end

function MasterDataManager:initRankData()
    --排行榜数据
    self._rankingData = {
        [1] = {
            rankType = PublicDefine.RankType.RankType_EquipMent,
            name = UI.TEXT_110048,
            titleRank = UI.TEXT_110044,
            titleName = UI.TEXT_110045,
            titleData = UI.TEXT_110052,
            time = 0,
            des = UI.TEXT_110084
        },
        [2] = {
            rankType = PublicDefine.RankType.RankType_Achievement,
            name = UI.TEXT_110049,
            titleRank = UI.TEXT_110044,
            titleName = UI.TEXT_110045,
            titleData = UI.TEXT_110049,
            time = 0,
            des = UI.TEXT_110085
        },
        [3] = {
            rankType = PublicDefine.RankType.RankType_Guild,
            name = UI.TEXT_110050,
            titleRank =UI.TEXT_110044,
            titleName = UI.TEXT_110050,
            titleData = UI.TEXT_110053,
            time = 0,
            des = UI.TEXT_110087
        },
        [4] = {
            rankType = PublicDefine.RankType.RankType_Dungeon,
            name = UI.TEXT_110054,
            titleRank = UI.TEXT_110044,
            titleName = UI.TEXT_110045,
            titleData = UI.TEXT_110055,
            time = 0,
            des = {UI.TEXT_110082,UI.TEXT_110083}
        },
        [6] = {
            rankType = PublicDefine.RankType.RankType_Mentor,
            name = LanguageManager:getInstance():getLocalString(1112666) --[["导师"]],
            titleRank = UI.TEXT_110044,
            titleName = UI.TEXT_110045,
            titleData = LanguageManager:getInstance():getLocalString(1112667) --[["结业学员"]],
            time = 0,
            des = LanguageManager:getInstance():getLocalString(1112668) --[["排行榜解释"]]
        }
    }
end 

--返回城镇
function MasterDataManager:returnToTown()
    self._fullBagData = {}
end

-- 每层清理功能数据
function MasterDataManager:clearFunctionData()
    print("MasterDataManager:clearFunctionData()")

end

-- 设置重复处理数据 repeatHandleType:RepeatHandleType value:自定义结构
function MasterDataManager:setRepeatHandleData(repeatHandleType, value)
    if(repeatHandleType == nil or value == nil) then return end

    self._repeatHandleMap[repeatHandleType] = value    
end

-- 获取重复处理数据  repeatHandleType:RepeatHandleType
function MasterDataManager:getRepeatHandleData(repeatHandleType)
    return self._repeatHandleMap[repeatHandleType]
end

-- 添加指定某个类型的指定数据，如果有相同key 数据就直接覆盖
function MasterDataManager:insertRepeatHandleData(repeatHandleType, key, value)
    if(repeatHandleType == nil or key == nil or value == nil) then return end

    local data = self._repeatHandleMap[repeatHandleType]
    if(data == nil) then
        data = {}
        self._repeatHandleMap[repeatHandleType] = data
    end

    data[key] = value
end 

-- 移除某个类型的指定KEY数据
function MasterDataManager:removeRepeatHandleData(repeatHandleType, key)
    local data = self._repeatHandleMap[repeatHandleType]
    if(data and key) then
        data[key] = nil
    end
end

-- 根据类型清理重复操作数据  repeatHandleType:RepeatHandleType
function MasterDataManager:clearRepeatHandleDataForType(repeatHandleType)
    if(repeatHandleType == nil) then return end

    self._repeatHandleMap[repeatHandleType] = nil
end

function MasterDataManager:clearAllRepeatHandleData()
    self._repeatHandleMap = {}
end

function MasterDataManager:triggerNewDay(refreshDay) 
    if(refreshDay ~= 0) then 
        if(self.refreshDay < refreshDay) then 
            self.refreshDay = refreshDay
        end
    end
end

function MasterDataManager:triggerNewWeek()
    -- 清理上周的老数据
    self._refreshRankData = true
    -- 延迟请求最新的排行数据信息
    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        self:triggerRefreshPreRankData()
    end, math.random(1, 15))
end

function MasterDataManager:triggerRefreshPreRankData()

    local SceneManager = require("app.game.SceneManager")
    if(self._refreshRankData and SceneManager:getInstance():isInTown()) then
        Net.NetRankSystem:requestRankList(PublicDefine.RankType.RankType_Dream, true)
    end
end

-- 获取玩家最大装备分数
function MasterDataManager:getMaxEquipScore()

    return self._maxEquipScore
end

-- 刷新最大装备分数
function MasterDataManager:updateMaxEquipScore(equipScore)
    local SceneManager = require("app.game.SceneManager")
    if SceneManager:getInstance():isRefreshEquipScore() == true then
        if(equipScore and equipScore > self._maxEquipScore) then
            self._maxEquipScore = equipScore
        end
    end
end

-- 获取保存的游戏洞穴中的数据
function MasterDataManager:getSaveGameInCaveData()
    local GameDataManager = require("app.game.GameDataManager")
    return Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GAME_IN_CAVE, GameDataManager:getInstance():getSaveUserKey())
end

function MasterDataManager:clearAllDeformation()
    local gameInCaveData = self:getSaveGameInCaveData()

    if(gameInCaveData) then
        gameInCaveData:clearAllDeformation()
    end
end

-- 获取当前已经领取的藏宝图数据
function MasterDataManager:getTreasureMapList()
   return self._treasureMapList 
end

function MasterDataManager:handleInitRreasureData(data)
    local treasureMapList = {}
    if data.RewardedTreasureMaps then
        for i = 1,#data.RewardedTreasureMaps do
            table.insert(treasureMapList,data.RewardedTreasureMaps[i])
        end
    end
    self._treasureMapList = treasureMapList
end

function MasterDataManager:getBlackMarketRefreshHour()
    return self._blackMarketHour
end

function MasterDataManager:getBlackMarketData()
    local groupID = GameDataManager:getInstance():getBlackMarketGroupID()
    -- 刷新当前价格等数据
    local blackConfig = ConfigManager:getBlackMarketByGroupID(groupID)
    if DEBUG then
        print("MasterDataManager:getBlackMarketData ", groupID)
        dump(blackConfig)
    end
    if blackConfig then
        for k, blackShopData in pairs(self._blackShopDataArr) do
            for i,goodID in ipairs(blackConfig.equipType) do
                if(blackShopData:getGoodsID() == goodID) then
                    blackShopData:setPrice(blackConfig.cost[i])
                end
            end
        end

        return self._blackShopDataArr
    else 
        return {}
    end
end

function MasterDataManager:handleBlackMarketData(data)
    if DEBUG then
        print("MasterDataManager:handleBlackMarketData ")
        dump(data)
    end
    -- 处理刷新黑商数据
    self._blackMarketHour = data.blackMarketHour
    self:refreshBlackMarketData(data.blackMarketGoods)
end

function MasterDataManager:refreshBlackMarketData(blackMarketGoods)
    if(blackMarketGoods == nil) then
        return
    end
    table.clear(self._blackShopDataArr)

    local pos = 0
    for _,goodId in ipairs(blackMarketGoods) do 
        if(goodId ~= 0) then
            local blackShopData = Goods.BlackShopData:create(goodId)
            blackShopData:setPos(pos)
            blackShopData:setNum(1)
            
            table.insert(self._blackShopDataArr, blackShopData)
        end
        pos = pos + 1
    end

    -- 发送物品改变
    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_BLACK_SHOP_DATA_CHANGE, self:getBlackMarketData())
end

-- 处理黑商购买数据
function MasterDataManager:handleBlackMarketBuy(data)
    if DEBUG then
        print("MasterDataManager:handleBlackMarketBuy ")
        dump(data)
    end
    -- 处理黑商处理成功
    if(data) then
        for k, blackShopData in pairs(self._blackShopDataArr) do
            if(blackShopData:getPos() == data.pos) then
                table.remove(self._blackShopDataArr, k)
                break
            end
        end
    end
end

function MasterDataManager:getRandomShopRefreshHour()
    return self._randomShopHour
end

function MasterDataManager:getRandomShopData()
    return self._randomShopDataArr
end

function MasterDataManager:handleRandomShopData(data)
    if DEBUG then
        print("MasterDataManager:handleRandomShopData ")
        dump(data)
    end
    -- 处理刷新黑商数据
    self._randomShopHour = data.refreshHour
    
    table.clear(self._randomShopDataArr)

    if(data.list) then
        for _,value in ipairs(data.list) do 
            if(value.num >0) then 
                local goodsData = GoodsDataManager:createLocalGoodsData(value.itemID)
                if(goodsData) then 
                    goodsData:initInCaveShop( value.itemID, value.num, value.costType, value.price)
                    goodsData:setIsNew(false)

                    table.insert(self._randomShopDataArr, goodsData)
                end 
            end
        end
        
        -- 排序
        -- 根据最新的规则，采用随机乱序
        if(self._randomShopDataArr) then
            local tmp, index
            for i=1, #self._randomShopDataArr-1 do
                index = math.random(i, #self._randomShopDataArr)
                if i ~= index then
                    tmp = self._randomShopDataArr[index]
                    self._randomShopDataArr[index] = self._randomShopDataArr[i]
                    self._randomShopDataArr[i] = tmp
                end
            end
        end

        -- -- 按照品质从高到低>水晶>金币>出售价格>
        -- table.sort(self._randomShopDataArr, function(a, b)
        --     -- 判断人数是否够
        --     if a:getGoodsRare() ~= b:getGoodsRare() then
        --         if a:getGoodsRare() > b:getGoodsRare() then
        --             return true
        --         else 
        --             return false
        --         end
        --     end  

        --     if a:getCostType() ~= b:getCostType() then
        --         if (a:getCostType() == PublicDefine.GOODS_COST_TYPE.GEM) then 
        --             return true
        --         else 
        --             return false 
        --         end
        --     end

        --     if(a:getBuyPrice() ~= b:getBuyPrice()) then 
        --         if (a:getCostType() > b:getBuyPrice()) then 
        --             return true
        --         else 
        --             return false 
        --         end
        --     end 

        --     if(a:getId() > b:getId()) then
        --         return true
        --     else
        --         return false
        --     end
        -- end)
    end

    -- 发送物品改变
    Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_RANDOM_SHOP_DATA_CHANGE, self:getRandomShopData())
end

-- 处理随机商人购买数据
function MasterDataManager:handleRandomShopBuy(data)
    if DEBUG then
        print("MasterDataManager:handleRandomShopBuy ")
        dump(data)
    end
    -- 处理黑商处理成功
    if(data) then
        for k, randomShopData in pairs(self._randomShopDataArr) do
            if(randomShopData:getGoodsID() == data.itemID 
                and randomShopData:getCostType() == data.costType) then
                randomShopData:setNum(randomShopData:getNum() - data.num)

                if(randomShopData:getNum() <=0) then
                    table.remove(self._randomShopDataArr, k)
                end
                break
            end
        end
    end
end

-- 处理藏宝图领取奖励返回数据
function MasterDataManager:handleTreasureReceiveResultData(data)
    if(data) then
        if(data.result == "TreasureRewardResultType_Succeed") then
            -- 领取成功,添加列表ID
            if(data.treasureID ~= 0) then
                table.insert(self._treasureMapList, data.treasureID)
            end

            -- 生成相关的物品
            local rewardGoodsArr = {}
            for _,rewardData in pairs(data.goods) do
                local goodsData = GoodsDataManager:createLocalGoodsData(rewardData.goodsID)
                if (goodsData) then
                    goodsData:setNum(rewardData.num)
                    -- 这里默认给点金
                    goodsData:setIsGolden(true)

                    table.insert(rewardGoodsArr, goodsData)
                end
            end
            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, rewardGoodsArr, nil, UI.TEXT_111030, nil)  
        elseif (data.result == "TreasureRewardResultType_BagFull") then
            -- 背包满的需求
            UI.UIManager.mTipsLayer:onBagIsFull()
        elseif (data.result == "TreasureRewardResultType_NoComplete") then
            -- 没有完成
            UI.ScrollBar:createByText(UI.TEXT_1170020)
        elseif (data.result == "TreasureRewardResultType_SystemError") then
            -- 系统错误
            UI.ScrollBar:createByText(UI.TEXT_1170002)
        end
    end
end

-- 判断碎片是否可以获得
function MasterDataManager:fragmentIsGet(id)
    -- add by zp
    local haveList = GoodsDataManager:getVirtualGoodsDataList()
    for k,virtualData in pairs(haveList) do
        if(virtualData:getGoodsID() == id) then
            return false
        end
    end 

    -- 判断是否已经领取了
    for _,treasureID in pairs(self._treasureMapList) do
        local treasureConfig = ConfigManager:getTreasuremapConfigByID(treasureID)
        if(treasureConfig) then
            for k,fragmentID in pairs(treasureConfig.fragmentID) do 
                if(fragmentID == id) then
                    return false
                end
            end
        end
    end

    -- 判断是否有可以获得
    local configData = ConfigManager:getTreasuremapConfigList()
    for _, oneConfig in pairs(configData) do
        for k,virtualId in pairs(oneConfig.fragmentID) do 
            if(virtualId == id) then 
                if(oneConfig.generationType == 2) then
                    return true
                elseif (oneConfig.generationType == 1) then
                    local preID = oneConfig.fragmentID[k-1]
                    if(preID ~= nil) then
                        -- 判断前置碎片是否已经获得
                        for k,virtualData in pairs(haveList) do
                            if(virtualData:getGoodsID() == preID) then
                                -- 前置碎片已经获得
                                return true
                            end
                        end 

                        return false
                    else
                        return true
                    end
                else
                    printError(string.format("MasterDataManager:fragmentIsGet  error generationType.  generationType=%d", oneConfig.generationType))
                end
            end 
        end 
    end
    -- 默认返回不能
    print("MasterDataManager:fragmentIsGet  no handle", id)

    return false
end 

function MasterDataManager:calculationSkillMp(skillData, oldMp, EObjectType)
    if(skillData and oldMp and EObjectType) then
        local skillVariationArr = self._skillVariationArr[EObjectType]
        local percent = RATIO_NUMBER
        if(skillVariationArr) then
            for k, data in pairs(skillVariationArr) do 
                if(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_All) then
                    -- dump(data.arr)
                    percent = percent + data.arr[1].mpCostValue
                elseif(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_Search) then
                    for k,v in pairs(data.arr) do 
                        if(v.changeID == skillData:getSkillID()) then
                            percent = percent + v.mpCostValue
                            break
                        end
                    end
                elseif(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_Type) then
                    for k,v in pairs(data.arr) do 
                        if(v.changeID == skillData:getSkillType()) then
                            percent = percent + v.mpCostValue
                            break
                        end
                    end
                else
                    printError(string.format("have changeType=%s no handle", data.changeType))
                end
            end
            -- print("MasterDataManager:calculationSkillCooldown ", oldMp, percent, math.floor(oldMp * percent / RATIO_NUMBER))
        end

        return math.floor(oldMp * percent / RATIO_NUMBER)
    end

    return oldMp

end

function MasterDataManager:calculationSkillCooldown(skillData, oldTime, EObjectType)
    if(skillData and oldTime and EObjectType) then
        local skillVariationArr = self._skillVariationArr[EObjectType]
        local percent = RATIO_NUMBER
        if(skillVariationArr) then
            for k, data in pairs(skillVariationArr) do
                if(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_All) then
                    if EObjectType == PublicDefine.EObjectType.Pet then
                        if data.petSiteId and data.petSiteId == 0 then
                            percent = percent + data.arr[1].cdValue
                        end
                    else
                        percent = percent + data.arr[1].cdValue
                    end
                    
                elseif(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_Search) then
                    for k,v in pairs(data.arr) do 
                        if(v.changeID == skillData.searchID) then
                            percent = percent + v.cdValue
                            break
                        end
                    end
                elseif(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_Type) then
                    for k,v in pairs(data.arr) do 
                        if(v.changeID == skillData:getSkillType()) then
                            percent = percent + v.cdValue
                            break
                        end
                    end
                else
                    printError(string.format("have changeType=%s no handle", data.changeType))
                end
            end
            -- print("MasterDataManager:calculationSkillCooldown ", oldTime, percent, math.floor(oldTime * percent / RATIO_NUMBER))
        end
        return math.floor(oldTime * percent / RATIO_NUMBER)
    end

    return oldTime
end

function MasterDataManager:calculationSkillSing(skillData, oldTime, EObjectType) 
    if(skillData and oldTime and EObjectType) then
        local skillVariationArr = self._skillVariationArr[EObjectType]
        local percent = RATIO_NUMBER
        if(skillVariationArr) then
            for k, data in pairs(skillVariationArr) do 
                if(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_All) then
                    dump(data.arr[1])
                    percent = percent + data.arr[1].acValue
                elseif(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_Search) then
                    for k,v in pairs(data.arr) do 
                        if(v.changeID == skillData:getSkillID()) then
                            percent = percent + v.acValue
                            break
                        end
                    end
                elseif(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_Type) then
                    for k,v in pairs(data.arr) do 
                        if(v.changeID == skillData:getSkillType()) then
                            percent = percent + v.acValue
                            break
                        end
                    end
                else
                    printError(string.format("have changeType=%d no handle", data.changeType))
                end
            end
            -- print("MasterDataManager:calculationSkillSing ", oldTime, percent, math.floor(oldTime * percent / RATIO_NUMBER))
        end
        return math.floor(oldTime * percent / RATIO_NUMBER)
    end

    return 0
end

-- function MasterDataManager:getSkillVariation()
--     return self._skillVariationArr
-- end

function MasterDataManager:clearSkillVariation(objectType)
    self._skillVariationArr[objectType] = nil
end

function MasterDataManager:handleSkillVariation(data)
    if(data) then
        local update = false
        local skillVariationArr = self._skillVariationArr[data.spriteType]
        if(skillVariationArr == nil) then
            skillVariationArr = {}
            self._skillVariationArr[data.spriteType] = skillVariationArr
        end

        for k, oneData in pairs(skillVariationArr) do 
            if(oneData.changeType == data.changeType) then
                if(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_All) then
                    update = true
                    oneData.arr = {}
                    if data.petSiteId then
                        oneData.petSiteId = data.petSiteId
                    end
                    local mn = {changeID = data.changeID, cdValue = data.cdValue, acValue = data.acValue, mpCostValue = data.mpCostValue}
                    table.insert(oneData.arr, mn)
                else
                    for k,v in pairs(oneData.arr) do 
                        if(v.changeID == data.changeID) then
                            if data.petSiteId then
                                oneData.petSiteId = data.petSiteId
                            end
                            update = true
                            v.cdValue = data.cdValue
                            v.acValue = data.acValue
                            v.mpCostValue = data.mpCostValue
                            break
                        end
                    end
                end

                break
            end
        end

        if(update == false) then
            if(data.changeType == PublicDefine.SkillVariationAffectType.SkillVariationAffect_All) then
                local addData = {}
                addData.changeType = data.changeType
                if data.petSiteId then
                    addData.petSiteId = data.petSiteId
                end
                addData.arr = {}
                local mn = {changeID = data.changeID, cdValue = data.cdValue, acValue = data.acValue, mpCostValue = data.mpCostValue}
                if data.petSiteId then
                    mn.petSiteId = data.petSiteId
                end
                table.insert(addData.arr, mn)

                -- print("dddddddddddddddddddddddd")
                -- dump(addData)

                table.insert(skillVariationArr, addData)
            else 
                local addFlag = false
                for k, oneData in pairs(skillVariationArr) do 
                    if(oneData.changeType == data.changeType) then
                        if data.petSiteId then
                            oneData.petSiteId = data.petSiteId
                        end
                        addFlag = true
                        
                        local mn = {changeID = data.changeID, cdValue = data.cdValue, acValue = data.acValue, mpCostValue = data.mpCostValue}
                        table.insert(oneData.arr, mn)
                        break
                    end
                end
                if(addFlag == false) then
                    local addData = {}
                    addData.changeType = data.changeType
                    if data.petSiteId then
                        addData.petSiteId = data.petSiteId
                    end
                    addData.arr = {}
                    local mn = {changeID = data.changeID, cdValue = data.cdValue, acValue = data.acValue, mpCostValue = data.mpCostValue}
                    
                    table.insert(addData.arr, mn)

                    table.insert(skillVariationArr, addData)
                end
            end
        end
        -- print("dddfdfdfdfffffffff")
        -- dump(self._skillVariationArr)
        -- dump(self._skillVariationArr[1])
    end
end

-- 获取完成的藏宝图配置文件
function MasterDataManager:getCompleteTreasuremapByNPCID(npcID)
    local allTreasuremapConfig = ConfigManager:getTreasuremapConfigList()
    if(allTreasuremapConfig) then
        for k, treasureConfig in pairs(allTreasuremapConfig) do
            if(treasureConfig.getRewardsNPC == npcID) then
                local complete = true
                for _,fragmentID in pairs(treasureConfig.fragmentID) do
                    if GoodsDataManager:getVirtualGoodsDataByGoodsID(fragmentID) == nil then
                        complete = false
                        break
                    end
                end

                -- 判断是否已经领取过了
                for _,haveId in pairs(self._treasureMapList) do
                    if(treasureConfig.ID == haveId) then
                        complete = false
                    end
                end

                if(complete) then
                    return treasureConfig
                end
            end
        end
    end

    return nil
end

function MasterDataManager:getTurnTableData()
    return self._turnTableData
end

function MasterDataManager:setTurnTableData(dropListId, hasBuyNum, leftTurnNum, hasTurnNum, generateTime)
    self._turnTableData.dropListId = dropListId or 0
    self._turnTableData.hasBuyNum = hasBuyNum or 0
    self._turnTableData.leftTurnNum = leftTurnNum or 0
    self._turnTableData.generateTime = generateTime or 0
    self._turnTableData.hasTurnNum = hasTurnNum or 0
end

function MasterDataManager:clearTurnTableData()
    self._turnTableData.dropListId = 0
    self._turnTableData.hasBuyNum = 0
    self._turnTableData.leftTurnNum = 0
    self._turnTableData.generateTime = 0
    self._turnTableData.hasTurnNum = 0
end

function MasterDataManager:isHaveFreeCountInTurnTable()
    local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
    if (not FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.LUCKYWHEEL_TURN)) then 
        return false
    end
    local activityData = self:getActivityDataForType(PublicDefine.ActivityType.ActivityType_LuckyWheel)
    if(activityData and activityData:isInEffect()) then 
        return false
    end
    if self._turnTableData.hasTurnNum == nil then
        return false
    end
    if self._turnTableData.hasTurnNum == 0 and self._turnTableData.leftTurnNum > 0 then
        return true
    end
    return false
end

-- 获取公会数据
function MasterDataManager:getGuildData()
    return self._guildData
end

-- 清空公会数据
function MasterDataManager:clearGuildData()
    self._guildData = nil
    self._guildTechData = nil

    self:_handleGuildChange()
end

-- 获取所有加入申请
function MasterDataManager:getAllJoinApply()
    return self._guildJoinApply
end

-- 判断是否加入申请了
function MasterDataManager:judgeJoinApply(guildID)
    if(self._guildJoinApply[guildID]) then
        return true
    end

    return false
end

-- 清理加入申请
function MasterDataManager:clearJoinApply()
    self._guildJoinApply = {}
end

-- 移除申请列表
function MasterDataManager:removeJoinApply(guildID)
    if(guildID) then
        self._guildJoinApply[guildID] = nil
    end
end

-- 添加加入申请
function MasterDataManager:addJoinApply(guildID)
    if(guildID) then
        self._guildJoinApply[guildID] = guildID
    end
end

-- 初始化公会
function MasterDataManager:handleInitGuild(data)
    if(data) then
        self._guildData = Data.GuildData:create()
        self._guildData:initNet(data)

        self:_handleGuildChange()
    end
end

-- 设置自己是否已经投票罢免了
function MasterDataManager:setIsVotedOverthrow(b)
    if (self._guildData) then
        self._guildData:setIsVotedOverthrow(b)
    end
end

-- 发起罢免的时间点
function MasterDataManager:setOverthrowStartTime(b)
    if (self._guildData) then
        self._guildData:setOverthrowStartTime(b)
    end
end

-- 获取改变时间
function MasterDataManager:getChangeTitleTime()
    return self._changeTitleTime
end

-- 设置改变时间
function MasterDataManager:setChangeTitleTimeNow()
    self._changeTitleTime = GameManager:getNowServerTime()
end


-- 获取充值累计额度（分）
function MasterDataManager:getPayMoneyCount()
    return self._payMoneyNum or 0
end

-- 设置充值累计额度（分）
function MasterDataManager:setPayMoneyCount(money)
    self._payMoneyNum = money
end


--初始化图鉴数据
function MasterDataManager:initPokedexList(data)
    self._pokedexList = {}
    if(data) then
        for i = 1, #data do
            self._pokedexList[data[i].mode] = self._pokedexList[data[i].mode] or {}
            self._pokedexList[data[i].mode][data[i].difficulty] = {}
            for j = 1,#data[i].unlockData do
                local _b = tonumber(string.byte(data[i].unlockData,j))
                for k = 1,8 do
                    local t = bit.band(_b,1)
                    if t == 1 then
                        self._pokedexList[data[i].mode][data[i].difficulty][(j - 1) * 8 + k] = true
                    end
                    _b = bit.rshift(_b,1)
                end
            end
        end
    end
end

--解锁图鉴
function MasterDataManager:insertPokedex(data)
    for i = 1, #data do
        if self._pokedexList[data[i].mode] == nil then
            self._pokedexList[data[i].mode] = {}
        end
        if self._pokedexList[data[i].mode][data[i].difficulty] == nil then
            self._pokedexList[data[i].mode][data[i].difficulty] = {}
        end
        self._pokedexList[data[i].mode][data[i].difficulty][data[i].unlockPokedex] = true
    end
end

--获取图鉴数据
function MasterDataManager:getPokedexData()
    return self._pokedexList
end

--获取背包满数据
function MasterDataManager:getFullBagData()
    return self._fullBagData
end

--初始化背包满数据
function MasterDataManager:initFullBagData(data)
    self._fullBagData = {}

    for i = 1,#data do
        local fullBagData = {}
        fullBagData.templateID = data[i].templateID
        fullBagData.isGolden = data[i].isGolden
        fullBagData.entityID = data[i].entityID
        fullBagData.num = data[i].num
        fullBagData.serialID = data[i].serialID
        fullBagData.time = PublicDefine.CONST_DEFINITION.COUNTDOWN_BAG_FULL_MS/1000
        -- print("MasterDataManager:initFullBagData",i)
        table.insert(self._fullBagData,fullBagData)
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_FULLBAG_INIT)
end

--增加一条背包满的数据
function MasterDataManager:insertFullBagData(data)
    local fullBagData = {}
    fullBagData.templateID = data.templateID
    fullBagData.isGolden = data.isGolden
    fullBagData.entityID = data.entityID
    fullBagData.num = data.num
    fullBagData.serialID = data.serialID
    fullBagData.time = PublicDefine.CONST_DEFINITION.COUNTDOWN_BAG_FULL_MS/1000
    table.insert(self._fullBagData,fullBagData)

    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_FULLBAG_INSERT,fullBagData)
end

--删除背包满的list
function MasterDataManager:removeFullBagData(data)
    for i = 1,#self._fullBagData do
        if self._fullBagData[i].serialID == data.serialID then
            table.remove(self._fullBagData,i)
            break
        end
    end

    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_FULLBAG_REMOVE,data.serialID)
end


function MasterDataManager:schedulerTimeOut(dt)
    -- print("MasterDataManager:schedulerTimeOut")

    for k,v in pairs(self._rankingData) do
        if v.time > 0 then
            v.time = v.time - dt
        end
    end



    if self._bStopFullBagTimeOut then
        return
    end
    if type(self._fullBagData) == "table" and self._fullBagData[1] ~= nil then
        -- print("MasterDataManager:schedulerTimeOut",self._fullBagData[1].time)
        self._fullBagData[1].time = self._fullBagData[1].time - dt;
        if self._fullBagData[1].time <= 0 then
            self._fullBagData[1].time = 0
            
        end
    end
end

--停止背包满倒计时
function MasterDataManager:stopFullBagTimeOut()
    print("MasterDataManager:stopFullBagTimeOut")
    self._bStopFullBagTimeOut = true
end

--恢复背包满倒计时
function MasterDataManager:resumeFullBagTimeOut()
    print("MasterDataManager:resumeFullBagTimeOut")
    self._bStopFullBagTimeOut = false
end

--设置工会科技
function MasterDataManager:setGuildTech(var)
    if var == nil then
        return
    end
    if(self._guildTechData == nil) then
        self._guildTechData = {}
    end

    for k,v in pairs(var) do 
        local found = false

        for _,data in pairs(self._guildTechData) do 
            if(data.techID == v.techID) then
                data.curLv = v.curLv
                data.curExp = v.curExp
                if(data.curLv < 1) then 
                    data.curLv = 1
                end
                found = true
                break
            end
        end

        if(found == false) then
            local oneData = {}
            oneData.techID = v.techID
            oneData.curLv = v.curLv
            oneData.curExp = v.curExp
            if(oneData.curLv < 1) then 
                oneData.curLv = 1
            end
            table.insert(self._guildTechData, oneData)
        end
    end

    Avalon.MessageCenter:notice(GameMessage.MC_DATA_GUILD_TECH, self._guildTechData)
end

--获取公会科技
function MasterDataManager:getGuildTech()
    return self._guildTechData
end

--根据科技ID获取公会科技数据
function MasterDataManager:getGuildTechForTechID(techID)
    if(techID and self._guildTechData) then 
        for k,v in ipairs(self._guildTechData) do 
            if(v.techID == techID) then 
                return v
            end
        end
    end

    return nil
end

--设置工会科技
function MasterDataManager:setGuildSkill(var)
    self._guildSkillData = var
end

--获取公会科技
function MasterDataManager:getGuildSkill()
    return self._guildSkillData
end

--获取大秘境排行榜
function MasterDataManager:getDungeonRanking()
    return self._dungeonRanking
end

--设置大秘境排行榜
function MasterDataManager:setDungeonRanking(var)
    self._dungeonRanking = var
end

--获取排行榜数据
function MasterDataManager:getRankingData()
    return self._rankingData
end

--设置排行榜数据
function MasterDataManager:setRankingData(var)
    self._rankingData = var
end


--[[SeasonData = {seasonID, startTime, endTime, open} ]]
function MasterDataManager:initDungeonSeasonData(data)
    self._dungeonSeasonData.entranceOpen = data.dungeonOpen
    self._dungeonSeasonData.seasonList = self._dungeonSeasonData.seasonList or {}
    if data.currentSeasonData ~= nil then
        self._dungeonSeasonData.currentSeasonID = data.currentSeasonData.seasonID
        self._dungeonSeasonData.seasonList[data.currentSeasonData.seasonID] = data.currentSeasonData
    end
    if data.nextSeasonData ~= nil then
        self._dungeonSeasonData.nextSeasonID = data.nextSeasonData.seasonID
        self._dungeonSeasonData.seasonList[data.nextSeasonData.seasonID] = data.nextSeasonData
    end
    if data.currentSeasonData ~= nil and data.currentSeasonData.open then
        RoleDataManager:getMaster():setHasReceivedDungeonSeasonReward(false)
    end
end

-- 角色当日深渊扫荡次数
function MasterDataManager:setSweepDungeonCnt(value)
    self._dungeonSeasonData.sweepDungeonCnt = value
end

function MasterDataManager:getSweepDungeonCnt()
    if not self._dungeonSeasonData.sweepDungeonCnt then
        self._dungeonSeasonData.sweepDungeonCnt = 0
    end
    return self._dungeonSeasonData.sweepDungeonCnt
end

function MasterDataManager:setDungeonEntranceOpen(open)
    self._dungeonSeasonData.entranceOpen = open
end

function MasterDataManager:isDungeonEntranceOpen(open)
    return self._dungeonSeasonData.entranceOpen
end

function MasterDataManager:refreshDungeonSeasonStatus(seasonID, status)
    if self._dungeonSeasonData.seasonList == nil then
        -- print("----!!!!!seasonList is null!!!!!")
        return
    end
    local seasonData = self._dungeonSeasonData.seasonList[seasonID]
    if seasonData ~= nil then
         seasonData.open = status
    end
    if seasonID == self._dungeonSeasonData.nextSeasonID then
        self._dungeonSeasonData.currentSeasonID = self._dungeonSeasonData.nextSeasonID
        self._dungeonSeasonData.nextSeasonID = nil
    end 
end

function MasterDataManager:getCurrentSeasonData()
    if self._dungeonSeasonData.seasonList == nil or self._dungeonSeasonData.currentSeasonID == nil then
        -- print("----!!!!!seasonList is null!!!!!")
        return
    end
    return self._dungeonSeasonData.seasonList[self._dungeonSeasonData.currentSeasonID]
end

function MasterDataManager:getNextSeasonData()
    if self._dungeonSeasonData.seasonList == nil then
        -- print("----!!!!!seasonList is null!!!!!")
        return
    end
    return self._dungeonSeasonData.seasonList[self._dungeonSeasonData.nextSeasonID]
end

function MasterDataManager:makeNameLinkForGuildMemberData(memberData, chatMessageType) 
    if(memberData) then
        local speaker = {}
        speaker.pk = memberData.PK 
        speaker.userID = memberData.userID
        speaker.nickName = memberData.name

        return Game.ChatManager:getInstance():getNickNameLinkStr(chatMessageType, speaker.pk, speaker.userID, speaker.nickName)
    end

    return nil
end
-- 领取成就成功之后刷新成就阶段
function MasterDataManager:refreshAchevementDataByResult(data)
    -- dump(data)
    if not self._achievementData then return end
    for index, localData in ipairs( self._achievementData.achivevements or {}) do
        if localData.achievementId == data.achievementId then
            localData.rewardStage = data.awardStat
        end
    end
    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end
-- 是否已经初始化过成就数据
function MasterDataManager:isAchevementDataInited()
    return self._achievementData ~= nil
end
-- 刷新数据(初始化和某条成就数值变化使用)
function MasterDataManager:refreshAchevementData(data)
    -- local complete = {}
    local isInit = false
    if not self._achievementData then
        self._achievementData =  {};
        self._achievementData.achivevements = {}
        isInit = true
    end
    local newArray = {};
    for idx, serverData in ipairs(data.achivevements or {} ) do
        -- dump(serverData)
        local find = false
        for index, localData in ipairs( self._achievementData.achivevements or {}) do
            if localData.achievementId == serverData.achievementId then
                localData.count = serverData.count
                localData.rewardStage = serverData.rewardStage    
                localData.reachDateSec = serverData.reachDateSec
                find = true;
            end
        end
        -- print("是否找到了  ",find)
        if not find then
            serverData.doneAlready = false
            if isInit then--第一次下发的已完成的成就 处理为不弹框
                local datadb = ConfigManager:getAchievement(serverData.achievementId)
                if datadb then
                    local targetNum = 0
                    if datadb.countType == 1 then
                        targetNum = datadb.goal[serverData.rewardStage + 1];
                    else
                        targetNum = datadb.goal[1 ];
                    end
                    if serverData.count >= checkint(targetNum) then
                        serverData.doneAlready = true
                    end
                end
            end
            table.insert(newArray,serverData)
        end
    end
    for i, v in ipairs( newArray ) do
        table.insert(self._achievementData.achivevements,v)
    end

    Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
end



-- 是否有某一个成就完成了
function MasterDataManager:hasOneAchevementComplete()
    if(self._achievementData) then
        for i, data in ipairs( self._achievementData.achivevements ) do
            -- dump(data)
            local datadb =  ConfigManager:getAchievement(data.achievementId)
            if datadb then
                local current = checkint(data.count);
                local stage = checkint(data.rewardStage) ;
                local targetNum = 0;
                local maxStage = table.nums(datadb.goal)
                
                
                if stage < maxStage then
                    -- 要计数
                    if datadb.countType == 1 then
                        targetNum = datadb.goal[stage + 1];
                    else
                        targetNum = datadb.goal[1 ];
                    end
                    -- 达成目标 targetNum 不应该为nil 如果为nil肯定是数据异常
                    if current >= checkint(targetNum) then
                        return true
                    end
                end
            else
                print("---------------data.achievementId = "..data.achievementId)
            end
        end
    end
    return false
end

function MasterDataManager:isFinishAchevementData(achievementId)
    local data = self:getAchevementData(achievementId)
    if(data) then 
        local cfgData = ConfigManager:getAchievement(achievementId)
        local maxStage = table.nums(cfgData.goal)
        
        local current = data.count
        local stage = data.rewardStage 
        if stage >= maxStage then--已经领完奖励
            return true
        else
            local targetNum = 0
            if cfgData.countType == 1 then
                targetNum = cfgData.goal[stage + 1]
            else
                targetNum = cfgData.goal[1]
            end
            -- 达成目标
            if current >= targetNum then--已完成 未领奖
                return true
            else
                return false
            end
        end
    end
    
    return false
end

function MasterDataManager:getAchevementData(achievementId)
    if not self._achievementData then return nil;end
    if not self._achievementData.achivevements then return nil;end
    for i, v in ipairs( self._achievementData.achivevements ) do
        if v.achievementId == achievementId then
            return v
        end
    end
    return nil;
end

-- 获取 可领取的 成就列表
function MasterDataManager:getAchevementAwardList()
    local done = 0
    if(self._achievementData and self._achievementData.achivevements) then
        for i, data in ipairs( self._achievementData.achivevements ) do
            -- dump(data)
            local datadb =  ConfigManager:getAchievement(data.achievementId)
            if datadb then
                local current = checkint(data.count);
                local stage = checkint(data.rewardStage) ;
                local targetNum = 0;
                local maxStage = table.nums(datadb.goal)
                
                
                if stage < maxStage then
                    -- 要计数
                    if datadb.countType == 1 then
                        targetNum = datadb.goal[stage + 1];
                    else
                        targetNum = datadb.goal[1 ];
                    end
                    -- 达成目标 targetNum 不应该为nil 如果为nil肯定是数据异常
                    if current >= checkint(targetNum) then
                        done = done + 1
                    end
                end
            else
                print("---------------data.achievementId = "..data.achievementId)
            end
        end
    end
    return done 
end

function MasterDataManager:isHaveNewMail()
    return self._isHaveNewMail
end

function MasterDataManager:setHaveNewMail(isHaveNewMail)
    self._isHaveNewMail = isHaveNewMail
end

function MasterDataManager:getFunnyRecord()
    return self._funnyRecord
end

function MasterDataManager:setFunnyRecord(data)
    data = data or {}
    for k, v in pairs(data) do
        self._funnyRecord[v.key] = v.value
    end  
end

function MasterDataManager:addActivityData(data)
    local isChange = false
    if(data and data.actList) then
        for k,v in pairs(data.actList) do 
            if(v) then
                local found = false
                local handleData = nil
                for _,oldData in pairs(self._activityData) do 
                    if(oldData:getID() == v.id) then 
                        found = true
                        oldData:initNet(v)
                        handleData = oldData
                        print(string.format("MasterDataManager:addActivityData repeate id=%d", oldData:getID()))
                    end
                end

                if(found == false) then
                    local activityData = Data.ActivityData:create()
                    activityData:initNet(v)

                    table.insert(self._activityData, activityData)
                    
                    handleData = activityData
                    isChange = true
                end
            end 
        end

        -- 对活动排序
        table.sort(self._activityData, function(a, b)
            -- print("dddddddddddddd", a.techTotalLv, a.curMemberNum, a.joinEquipScoreLmt)
            -- 判断人数是否够
            if a:getSortID() == b:getSortID() then
                if(a:getID() > b:getID()) then
                    return true
                else
                    return false
                end
            elseif a:getSortID() > b:getSortID() then
                return true
            else 
                return false
            end
        end)
        if isChange then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        end
        -- self:requestAllActivityWebLanguage(handler(self, self.refreshActivityLanguageCallback))
    end
end

function MasterDataManager:delActivityData(data)
    local isChange = false
    if(data and data.delList) then
        local removeArr = {}
        for k,id in pairs(data.delList) do 
            if (id) then
                for _,oldData in pairs(self._activityData) do 
                    if(oldData:getID() == id) then 
                        self:_handleClearLuckDataTrigger(oldData)
                        table.remove(self._activityData, _)
                        isChange = true
                        break
                    end
                end
            end 
        end
    end
    if isChange then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    end
end

function MasterDataManager:updateActivityStatus(data) 
    if(data and data.updateList) then
        for k,statusData in pairs(data.updateList) do 
            if (statusData) then
                for _,oldData in pairs(self._activityData) do 
                    if(oldData:getID() == statusData.id) then 
                        self:_handleClearLuckDataTrigger(oldData)
                        oldData:updateStatus(statusData.stat, statusData.isEnabled)
                        break
                    end
                end
            end 
        end
    end
end

function MasterDataManager:updateActivityDes(data) 
    if(data and data.updateList) then
        for k,desData in pairs(data.updateList) do 
            if (desData) then
                for _,oldData in pairs(self._activityData) do 
                    if(oldData:getID() == desData.id) then 
                        oldData:updateDesData(desData)
                        break
                    end
                end
            end 
        end

        self:backgroundRequestAllActivityWebLanguage()
    end
end

-- 初始化活动统计数据
function MasterDataManager:initActivityCountData(data)
    -- print("MasterDataManager:initActivityCountData", data)
    for k, activityData in ipairs(data.list) do 
        for _,oldData in pairs(self._activityData) do 
            if(oldData:getID() == activityData.id) then 
                oldData:initCount(activityData)
                break
            end
        end
    end 
end 

function MasterDataManager:_handleClearLuckDataTrigger(oldData)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return nil
    end
    if(oldData:getType() == PublicDefine.ActivityType.ActivityType_LuckyWheel) then 
        self:clearTurnTableData()
    end
end

-- 更新活动的计数信息
function MasterDataManager:updateActivityCount(data)
    -- print("MasterDataManager:updateActivityCount", data)
    local update = false
    local updateActivityData = nil
    for _,oldData in pairs(self._activityData) do 
        if(oldData:getID() == data.id) then 
            -- print("MasterDataManager:updateActivityCount")
            oldData:updateCount(data)
            update = true
            updateActivityData = oldData
            break
        end
    end

    if(update) then 
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    end

    return updateActivityData
end

function MasterDataManager:handleReceiveReward(data)
    -- print("MasterDataManager:handleReceiveReward", data)
    local update = false
    for _,oldData in pairs(self._activityData) do 
        if(oldData:getID() == data.id) then 
            oldData:handleUpdateReward(data)
            update = true
            break
        end
    end

    if(update) then 
        Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
    end
end

-- 处理公会的数据
function MasterDataManager:handleActivityGuildCount(data)
    -- print("MasterDataManager:handleActivityGuildCount", data)
    local guildData = self:getGuildData()
    if(guildData == nil or guildData:getID() ~= data.guildID) then 
        return 
    end
    
    if(data.countList) then 
        local update = false
        for key,updateData in pairs(data.countList) do 
            for _,oldData in pairs(self._activityData) do 
                if(oldData:getID() == updateData.activityID) then 
                    oldData:handleGuildAccountInfo(updateData)
                    update = true
                    break
                end
            end
        end
        if(update) then 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        end
    end
end

function MasterDataManager:handleClearActivityGuildCount()
    if(self._activityData) then 
        local update = false
        for _,oldData in pairs(self._activityData) do 
            if(oldData:getType() == PublicDefine.ActivityType.ActivityType_QuestConditionGuild) then 
                oldData:handleClearGuildAccountInfo()
                update = true
                break
            end
        end
        
        if(update) then 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_INFO_BTN)
        end
    end
end

function MasterDataManager:addGoodsDataTrigger(goodsData)
    if(goodsData == nil) then 
        return 
    end
    if(self._activityData) then 
        local update = false
        for _,oldData in pairs(self._activityData) do 
            if(oldData:isInEffect() and oldData:getType() == PublicDefine.ActivityType.ActivityType_Exchange) then 
                oldData:addGoodsDataTriggerSystemMes(goodsData)
            end
        end
    end
end

function MasterDataManager:getDreamRankTopHeroData()
    local topRankData = nil 
    for _,rankData in ipairs(self._preDreamRankData) do 
        if(rankData.rank == 1) then 
            topRankData = rankData
            break
        end
    end

    if(topRankData) then 
        return self:getPreDreamRankDetailDataForPK(topRankData.pk)
    end

    return nil
end

-- 后台请求所有公会web的多语言
function MasterDataManager:backgroundRequestAllActivityWebLanguage()
    -- body
    self:requestAllActivityWebLanguage(handler(self, self.refreshActivityLanguageCallback))
end

-- 请求刷新
function MasterDataManager:requestAllActivityWebLanguage(callBack)
    local keyList = {}
    for _,oldData in pairs(self._activityData) do 
        local keys = oldData:getKeyList()
        if(keys) then
            for k,v in pairs(keys) do 
                table.insert(keyList,v)
            end
        end
    end

    LanguageManager:getInstance():getLanguageFromWebServer(keyList, handler(self, callBack))
end

function MasterDataManager:refreshActivityLanguageCallback()
    print("MasterDataManager:refreshActivityLanguageCallback")
    for _,oldData in pairs(self._activityData) do 
        oldData:updateLanguageKeyToStr()
    end
end

function MasterDataManager:getActivityDataArrWithFilter(filterArr)
    local activityArr = {}
    local allActivity = MasterDataManager:getActivityDataArr()
    for k, actData in ipairs(allActivity) do
        local found = false
        for _, filterType in ipairs(filterArr) do
            if actData:getType() == filterType then
                found = true
                break
            end
        end
        if(not found) then 
            table.insert(activityArr, actData)
        end
    end

    return activityArr
end

function MasterDataManager:getActivityDataArr()
    local activityArr = {}

    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return activityArr
    end

    local haveBindEmail = true
    if (CAVEOL_TARGET == CAVEOL_TARGET_CN or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_NOADS) then
        haveBindEmail = false
    end

    if(self._activityData) then
        for _, activityData in ipairs(self._activityData) do 
            if(activityData:getIsEnable() and 
                activityData:getStatus() >= PublicDefine.ActivityRunningStat.ActivityRunningStat_Showing and 
                activityData:getIsShow()) then
                if(haveBindEmail) then 
                    table.insert(activityArr, activityData)
                else 
                    -- 过滤掉绑定邮箱的活动
                    if activityData:getType() ~= PublicDefine.ActivityType.ActivityType_MailBind then
                        table.insert(activityArr, activityData)
                    end
                end
            end
        end
    end

    return activityArr
end

function MasterDataManager:getActivityDataForType(activityType)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return nil
    end

    if(self._activityData) then
        for _,activityData in pairs(self._activityData) do 
            if(activityData:getType() == activityType and activityData:isInEffect()) then 
                return activityData
            end
        end
    end

    return nil
end

function MasterDataManager:getActivityDataArrForType(activityType)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return nil
    end
    local arr = {}
    if(self._activityData) then
        for _,activityData in pairs(self._activityData) do 
            if(activityData:getType() == activityType and activityData:isInEffect()) then 
                -- return activityData
                table.insert(arr, activityData)
            end
        end
    end

    return arr
end

-- 清理所有活动的进度
function MasterDataManager:clearAllCount()
    for _,activityData in pairs(self._activityData) do 
        activityData:clearCount()
    end
end

function MasterDataManager:getDiscountData(discountType)
    local discountDatas = nil
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Activity) == false then 
        return discountDatas
    end

    for _,activityData in pairs(self._activityData) do 
        if( activityData:isInEffect() and activityData:getType() == PublicDefine.ActivityType.ActivityType_Discount) then 
            discountDatas = {}
            local discountDataArr = activityData:getDiscountData()
            if(discountDataArr) then
                for k,v in pairs(discountDataArr) do 
                    if(v:getType() == discountType) then
                        table.insert(discountDatas, v)
                    end
                end
            end
            break
        end
    end
    return discountDatas
end

function MasterDataManager:isInitHeroCaveData()
    if self._heroCaveData.schemeData == nil then
        return false
    end
    return true
end

function MasterDataManager:refreshHeroCaveData(data)
    -- body
    self._heroCaveData.nextRefreshTime = data.nextRefreshTime--刷新次数的重置时间
    self._heroCaveData.nextExamineTime = data.nextExamineTime--特殊事件的重置时间
    self._heroCaveData.refreshCount = data.refreshCount--特殊事件的每日手动刷新次数
    self._heroCaveData.schemeExploreCount = data.schemeExploreCount--带事件的英雄模式当天剩余可探索次数
    self._heroCaveData.schemeData = self._heroCaveData.schemeData or {}
    for k, eventData in ipairs(data.schemeData) do
        self._heroCaveData.schemeData[eventData.modeID] = eventData
        table.sort(eventData.schemeIDs, function(a, b)
            return a < b
        end)
        --v = HeroCaveSchemeData {required uint32 modeID = 1;         // 场景IDrepeated uint32 schemeIDs = 2;      // 事件组ID}
    end
end

--检查刷新手动刷新时间和手动刷新次数
function MasterDataManager:checkRefreshCountAndTime()
    self._heroCaveData.nextRefreshTime = self._heroCaveData.nextRefreshTime == nil and 0 or self._heroCaveData.nextRefreshTime
    -- if self._heroCaveData.nextRefreshTime == nil or self._heroCaveData.nextRefreshTime <= 0 then
    --     return false
    -- end
    local refreshTimeStrList = string.split(ConfigManager:getGeneralForKey("manualSpecialEventRefreshTime"), ";")
    local zeroTime = self._heroCaveData.nextRefreshTime
    local nowTime = GameManager:getNowServerTime() - GameManager:getEPOCHTime()
    if self._heroCaveData.nextRefreshTime == 0 then
        zeroTime = math.floor(nowTime / SECONDS_ONE_DAY) * SECONDS_ONE_DAY - SECONDS_ONE_DAY
    elseif self._heroCaveData.nextRefreshTime % SECONDS_ONE_DAY == 0 then
        zeroTime = self._heroCaveData.nextRefreshTime - SECONDS_ONE_DAY
    else
        zeroTime = math.floor(self._heroCaveData.nextRefreshTime / SECONDS_ONE_DAY) * SECONDS_ONE_DAY
    end
    -- print("zeroTime ,nowTime = ", zeroTime, nowTime)
    local refreshTimeList = {}
    for k, v in ipairs(refreshTimeStrList) do
        local addTime = tonumber(v)
        addTime = addTime == 0 and 24 or addTime
        table.insert(refreshTimeList, addTime)
    end
    table.sort(refreshTimeList, function(a, b)
        return a < b
    end)
    local targetTime = 0
    -- dump(refreshTimeList, "---refreshTimeList--")
    for k, addTime in ipairs(refreshTimeList) do
        local nextTime = refreshTimeList[k + 1] or nowTime + 1
        if nowTime >= zeroTime + addTime * SECONDS_ONE_MINUTES and  nowTime < zeroTime + nextTime * SECONDS_ONE_MINUTES then
            targetTime = zeroTime + addTime * SECONDS_ONE_MINUTES
            break
        end
    end
    -- print("--targetTime--- = ", targetTime, self._heroCaveData.nextRefreshTime)
    if self._heroCaveData.nextRefreshTime < targetTime then
        self._heroCaveData.refreshCount = 0
        self._heroCaveData.nextRefreshTime = targetTime
        -- print("--self._heroCaveData.nextRefreshTime--- = "..self._heroCaveData.nextRefreshTime)
        return true 
    end
    return false 
end

function MasterDataManager:getHeroCaveRefreshCountRemianTime()
    return self._heroCaveData.nextRefreshTime or 0
end

function MasterDataManager:getHeroCaveSpecialEnventRemianTime()
    return self._heroCaveData.nextExamineTime or 0
end

function MasterDataManager:getHeroCaveRefreshCountUsedCount()
    return self._heroCaveData.refreshCount or 0
end

function MasterDataManager:getHeroCaveSchemeExploreCount()
    return self._heroCaveData.schemeExploreCount or 0
end

--levelId: 关卡ID
function MasterDataManager:getHeroCaveSpecialEnventBySceneId(sceneId)
    if self._heroCaveData.schemeData then
        local data = self._heroCaveData.schemeData[sceneId]
        if data then
            local list = data.schemeIDs  
            return list, data.isUsed
        end
    end
    return {}, true
end

function MasterDataManager:isNullSpecialEnvent()
    if self._heroCaveData.schemeData then
        for k, data in pairs( self._heroCaveData.schemeData) do
            if table.nums(data.schemeIDs) > 0 and not data.isUsed then
                return false
            end
        end
    end
    return true
end

function MasterDataManager:refreshBanChatData(data)
    for k, v in pairs(data.banData) do
        local tempData = {}
        if v.channelType == PublicDefine.ChatChannelType.ChatChannelType_Near then
            tempData.channelType = ChatChannelType.NEAR
        elseif v.channelType == PublicDefine.ChatChannelType.ChatChannelType_Team then
            tempData.channelType = ChatChannelType.TEAM
        elseif v.channelType == PublicDefine.ChatChannelType.ChatChannelType_Guild then
            tempData.channelType = ChatChannelType.GUILD
        elseif v.channelType == PublicDefine.ChatChannelType.ChatChannelType_Private then
            tempData.channelType = ChatChannelType.PERSONAL
        elseif v.channelType == PublicDefine.ChatChannelType.ChatChannelType_WorldChat then
            tempData.channelType = ChatChannelType.WORLD
        else

        end 
        tempData.banTimeStamp = v.banSec
        tempData.banType = v.banType
        if tempData.channelType then
            self._banChatList[tempData.channelType] = tempData
        end
    end
end

function MasterDataManager:getBanChatData()
    return self._banChatList
end

--[[//宝石探索结构mode = 
    id = 1;    //
    reeSec = 2;    //下次免费刷新秒数
    count = 3;    //单抽计数]]
function MasterDataManager:refreshGemstoneShopRecord(data)
    self._gemstoneShopRecord = {}
    for k, v in ipairs(data.records) do
        local mode = {}
        mode.id = v.id
        mode.freeSec = v.freeSec
        mode.count = v.count
        mode.dailyCount = v.dailyCount
        self._gemstoneShopRecord[v.id] = mode
    end
    --探索总经验
    self.exploreExp = data.exploreExp
    --探索等级
    self.exploreLv = data.exploreLv
    --当前剩余探索经验
    self.exploreLeftExp = data.exploreLeftExp
    --商品购买全量数据
    self.buydata = data.buydata

    print("  refreshGemstoneShopRecord ======= ",data)
end

function MasterDataManager:getGemstoneExploreLv()
    return self.exploreLv
end

function MasterDataManager:getGemstoneExploreLeftExp()
    return self.exploreLeftExp
end

function MasterDataManager:getGemstoneBuyData()
    return self.buydata
end

function MasterDataManager:refreshOneGemstoneShopRecord(data,exp,buydata)
    if data then
        local mode = {}
        mode.id = data.id
        mode.freeSec = data.freeSec
        mode.count = data.count
        mode.dailyCount = data.dailyCount
        self._gemstoneShopRecord[data.id] = mode
    end

    if exp then
        --当前剩余探索经验
        self.exploreLeftExp = exp
    end

    if buydata then
        local haveItemId = false
        for k,v in pairs(self.buydata) do
            if v.item_id == buydata.item_id then
                v.num = buydata.num
                haveItemId = true
            end
        end

        if not haveItemId then
            table.insert(self.buydata,{item_id = buydata.item_id,num = buydata.num})
        end
    end

    print("refreshOneGemstoneShopRecord ===== ",data, buydata)
end

function MasterDataManager:getAllGemstoneShopRecord()
    return self._gemstoneShopRecord
end

function MasterDataManager:getOneGemstoneShopRecordById(id)
    local data = self._gemstoneShopRecord[id]
    if data == nil then
        data = {}
        data.id = id
        data.freeSec = 0 
        data.count = 0
        data.dailyCount = 0
    end
    return data
end

function MasterDataManager:isHaveFreeCountInGemstoneShop()
    local FunctionUnlockManager = require("app.datas.FunctionUnlockManager")
    if (not FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.GEMSTONE_BUY)) then 
        return false
    end
    local cfgList = ConfigManager:getAllGemStoneShopData()
    if table.nums(self._gemstoneShopRecord) < table.nums(cfgList) then
        return true
    end
    for k , v in ipairs(self._gemstoneShopRecord) do
        if v.freeSec <= GameManager:getNormalServerTime() then
            return true
        end
    end
    return false
end


function MasterDataManager:setPreSearchGuildList(guildList)
    self._searchGuildList = guildList
end

function MasterDataManager:setPreGuildSearchTime(time)
    
    self._preSearchTime = time
end

function MasterDataManager:getPreSearchGuildList()
    
    return self._searchGuildList
end

function MasterDataManager:getPreGuildSearchTime()
    
    return self._preSearchTime
end

function MasterDataManager:setPreGuildAccountSearchTime(time)
    
    self._preGuildAccountSearchTime = time
end

function MasterDataManager:getPreGuildAccountSearchTime()
    if(self._preGuildAccountSearchTime == nil) then 
        self._preGuildAccountSearchTime = 0
    end
    return self._preGuildAccountSearchTime
end

function MasterDataManager:_handleGuildChange()
    local masterData = RoleDataManager:getMaster()
    if(masterData) then
        local SceneManager = require("app.game.SceneManager")

        local battleCMD = Command.BattleCommand:create(true)
        battleCMD:initForRoleGuildName(masterData:getSpriteID())
        SceneManager:getInstance():pushCommand(battleCMD)
    end
end

--[[id = 1;    //子天赋ID 对应 profileTalent 的 ID
    curLv = 2;    //子天赋当前等级
    totalAdd = 3;
]]
function MasterDataManager:initRoleTalent(netTalentList)
    local talentList = {}
    local allSubTalenfCfg = ConfigManager:getAllSubRoleTalent()
    for k, v in pairs (allSubTalenfCfg) do
        local data = clone(v)
        data.curLv = 0
        data.curAdd = 0
        for k2, v2 in ipairs(netTalentList) do
            if v.ID == v2.id then
                data.curLv = v2.curLv
                data.curAdd = v2.totalAdd
                break
            end
        end
        self._roleTalent[data.ID] = data
    end
end

function MasterDataManager:addRoleTalent(talentId, addNum)
    local data = self._roleTalent[talentId]
    data.curAdd = data.curAdd + addNum
end

function MasterDataManager:upgradeRoleTalent(talentId)
    local talentData = self._roleTalent[talentId]
    local needNumber = talentData.itemNum[talentData.curLv + 1] or talentData.itemNum[#talentData.itemNum]
    talentData.curAdd = talentData.curAdd - needNumber
    talentData.curLv = talentData.curLv + 1
end

function MasterDataManager:getRoleTalents()
    if table.nums(self._roleTalent) == 0 then
        self:initRoleTalent({})
    end
    return self._roleTalent
end

--返回的值为策划表配置的值， 不作百分号 和 正负值处理
function MasterDataManager:getEffValueByEffType(effectType)
    for k, v in pairs(self._roleTalent) do
        for k2, v2 in ipairs(v.effectID) do
            if effectType == v2 then
                local valueList = string.split(v.effectValue, ";")
                local value = 0
                if v.curLv > 0 then
                    value = valueList[v.curLv] or valueList[#valueList]
                end
                if #v.effectID > 1 then  --特殊处理  有逗号二次分割
                    value = string.split(value, ",")[1]
                end
                return checkint(value)
            end
        end
    end
    return 0
end

function MasterDataManager:addPreDreamRankHeroData(detailHeroData)
    if(detailHeroData and detailHeroData.heroData) then 
        self._preDreamRankHeroDetailData[detailHeroData.heroData:getPK()] = detailHeroData
    end
end

function MasterDataManager:getPreDreamRankDetailDataForPK(pk)
    return self._preDreamRankHeroDetailData[pk]
end

function MasterDataManager:getPreDreamRankDataForPK(pk)
    if(pk) then 
        for _, data in ipairs(self._preDreamRankData) do 
            if(data.pk == pk) then 
                return data
            end
        end
    end

    return nil
end

function MasterDataManager:getRandomOnePreDreamRankDetailData()
    local rankPK = nil
    if(self._preDreamRankData) then 
        local rankData = self._preDreamRankData[math.random(1, #self._preDreamRankData)]
        if(rankData) then 
            rankPK = rankData.pk
        end 
    end 

    if(rankPK) then 
        return self:getPreDreamRankDetailDataForPK(rankPK) 
    end

    return nil
end

function MasterDataManager:getPreRankDataArr()
    return self._preDreamRankData
end

function MasterDataManager:handleLastRankData(data)
    if(data) then 
        if data.rankType == PublicDefine.RankType.RankType_Dream and data.preWeekRank then 
            if(self._period == data.period) then
                return
            end
            self._refreshRankData = false 
            self._period = data.period

            local SceneManager = require("app.game.SceneManager")
            local battleCMD = Command.BattleCommand:create(true)
            battleCMD:initPreRankChange(self._preDreamRankData, false)
            SceneManager:getInstance():pushCommand(battleCMD)

            self._preDreamRankData = {}
            self._preDreamRankHeroDetailData = {}

            for _, lastRankData in ipairs(data.rankList) do 
                table.insert(self._preDreamRankData, lastRankData)
                -- 请求相关的数据列表
                Net.NetRoleSystem:heroDetailRequest(lastRankData.pk, 1,nil,nil,PublicDefine.RankType.RankType_Dream, true)
            end

            -- 对字段排序
            table.sort(self._preDreamRankData, function(a,b) 
                if(a.rank == b.rank) then 
                    if(a.pk < b.pk) then 
                        return true
                    end

                    return false
                end

                if(a.rank < b.rank) then 
                    return true
                end

                return false
            end)

            -- 
            local battleCMD = Command.BattleCommand:create(true)
            battleCMD:initPreRankChange(self._preDreamRankData, true)
            SceneManager:getInstance():pushCommand(battleCMD)
        end
    end
end

function MasterDataManager:handleHeroDetail(data)
    print("data ====data ===== ",data)
    local heroData = Data.HeroData:create()
    heroData:changeInit(data)
    heroData:handleAttr(data.attr)
    -- 修改相关数据
    heroData.equipScore = data.equipScore
    heroData.attackPower = data.attackPower
    heroData.toughness = data.toughness
    heroData.magicEffect = data.magicEffect
    heroData.starPatternLevel = data.starPatternLevel
    heroData:setSex(data.sex)

    -- 处理穿戴装备信息
    local equipmentsData = {}
    for _,v in ipairs(data.equipment) do
        if v.templateID ~= 0 then
            local goodsData = Net.NetGoodsSystem:handlePackGoodsData(v)
            if(v.index ~= 0) then
                goodsData:setWearPosition(v.index)
                goodsData:setBytesData(v.goodsDataBytes)
                GoodsDataManager:addEquipEquipment(heroData:getSpriteID(),goodsData)
                table.insert(equipmentsData, goodsData)
            else
                assert(false,"NetRoleSystem  ROLE_RESPONSE_HERO_DETAIL not set equipment index value.")
            end
        end
    end

    local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(heroData.spriteID)
    Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE,wearData)
    local records = {}
    for k, v in ipairs(data.records) do
        records[v.key] = v.value
    end

    local detailData = {}
    detailData.heroData = heroData
    detailData.wearEquipmentArr = equipmentsData
    detailData.records = records

     -- 处理穿戴装备信息
    local starList = {}
    for _,v in ipairs(data.starPrays) do
        if v.templateID ~= 0 then
            local goodsData = Net.NetGoodsSystem:handlePackGoodsData(v)
            local bytesData =  ProtobufUtil:decode("GoodsSystem.StarPrayData", v.goodsDataBytes)   
            goodsData:setIndex(v.index)
            goodsData:setBelong(bytesData.belong)
            goodsData:setBytesData(v.goodsDataBytes)
            goodsData:setIsNew(false)
            table.insert(starList, goodsData)
        end
    end

    detailData.starData = starList
    if(data.subType == PublicDefine.RankType.RankType_Dream and data.preWeekRank == true) then 
        self:addPreDreamRankHeroData(detailData)
    end

    return detailData
end


function MasterDataManager:convertHeroDetail(data)
    local heroData = Data.HeroData:create()
    heroData:changeInit(data)
    heroData:handleAttr(data.attr)
    -- 修改相关数据
    heroData.equipScore = data.equipScore
    heroData.attackPower = data.attackPower
    heroData.toughness = data.toughness
    heroData.magicEffect = data.magicEffect
    heroData:setSex(data.sex)

    -- 处理穿戴装备信息
    local equipmentsData = {}
    for _,v in ipairs(data.equipment) do
        if v.templateID ~= 0 then
            local goodsData = Net.NetGoodsSystem:handlePackGoodsData(v)
            if(v.index ~= 0) then
                goodsData:setWearPosition(v.index)
                goodsData:setBytesData(v.goodsDataBytes)
                table.insert(equipmentsData, goodsData)
            else
                assert(false,"NetRoleSystem  ROLE_RESPONSE_HERO_DETAIL not set equipment index value.")
            end
        end
    end

    local records = {}
    for k, v in ipairs(data.records) do
        records[v.key] = v.value
    end

    local detailData = {}
    detailData.heroData = heroData
    detailData.wearEquipmentArr = equipmentsData
    -- detailData.records = records

     -- 处理穿戴装备信息
    local starList = {}
    for _,v in ipairs(data.starPrays) do
        if v.templateID ~= 0 then
            local goodsData = Net.NetGoodsSystem:handlePackGoodsData(v)
            goodsData:setIndex(v.index)
            local bytesData =  ProtobufUtil:decode("GoodsSystem.StarPrayData", v.goodsDataBytes)
            if bytesData.belong then
                goodsData:setBelong(bytesData.belong)
            end
            goodsData:setBytesData(v.goodsDataBytes)
            goodsData:setIsNew(false)
            table.insert(starList, goodsData)
        end
    end

    detailData.starData = starList
    return detailData
end

function MasterDataManager:setDreamChallengeIsPhase(value)
    if value then
        self._dreamData.dreamType = 1
    else
        self._dreamData.dreamType = 0
    end
end

function MasterDataManager:getDreamChallengeIsPhase()
    if self._dreamData.dreamType == 1 then
        return true
    else
        return false
    end
end

function MasterDataManager:isHaveDreamData()
    if self._dreamData.lv == nil and self._dreamData.curBossIndex == nil and self._dreamData.refreshNum == nil then
        return false
    end
    return true
end

function MasterDataManager:getDreamData()
    return self._dreamData
end

function MasterDataManager:initDreamData(netData)
    local GameDataManager = require("app.game.GameDataManager")
    self._dreamData = GameDataManager:getInstance():refreshAllDreamData(netData)
    self._dreamData.curBossIndex = (netData.curBossIndex or 0) + 1
    self._dreamData.jump.curBossIndex = (netData.jump.curBossIndex or 0) + 1
    self._dreamData.maxLv = netData.maxLv or 0
end

function MasterDataManager:refreshCurBossBuff(bufferIDs, isPhase)
    self._dreamData.refreshNum = self._dreamData.refreshNum + 1
    local data = isPhase and self._dreamData.jump.bossInfos[self._dreamData.jump.curBossIndex] or self._dreamData.bossInfos[self._dreamData.curBossIndex]
    if data then
        data.bufferIDs = bufferIDs
    end
end

function MasterDataManager:isMaxDreamLv()
    local isMax = false
    if self._dreamData.lv == nil then
        return isMax
    end
    local cfgData, size = ConfigManager:getDreamConfigForLV(self._dreamData.lv)
    if self._dreamData.lv > size or (self._dreamData.lv == size and self._dreamData.curBossIndex > #cfgData.bossScene) then
        isMax = true
    end
    return isMax
end

function MasterDataManager:backCurDreamLv()
end

--关卡进度刷新
function MasterDataManager:setDreamProgress(progres)
    self._dreamData.curBossIndex = progres + 1
end

-- 获取梦境boss进度
function MasterDataManager:getDreamProgress()
    if (not self._dreamData or not ProtobufUtil:checkFieldIsInit(self._dreamData, "curBossIndex")) then
        return
    end

    return self._dreamData.curBossIndex
end

--梦境任务状态刷新
function MasterDataManager:setDreamTaskState(index, state)
    if self._dreamData.bossInfos then
        local info = self._dreamData.bossInfos[index]
        if info then
            info.stat = state
        end
    end
end


--缓存获得的梦境碎片
function MasterDataManager:setDreamResultChip(chip)
    self._dreamResultChip = chip
end

--获取获得的梦境碎片
function MasterDataManager:getDreamResultChip()
    return self._dreamResultChip or 0
end

--缓存服务器推送用于展示的结果等级(只在打完BOSS后更新, 最好不要在其他地方使用)
function MasterDataManager:setDreamResultLv(lv)
    self._dreamTempData.dreamResultLv = lv    
end

--获取缓存服务器推送用于展示的结果等级(只在打完BOSS后更新, 最好不要在其他地方使用)
function MasterDataManager:getDreamResultLv()
    return self._dreamTempData.dreamResultLv or 0
end

--缓存服务器推送用于展示的上次打死的BOSS(只在打完BOSS后更新, 最好不要在其他地方使用)
function MasterDataManager:setKilledBossIdx(idx)
    self._dreamTempData.killedBossIdx = idx    
end

--获取缓存服务器推送用于展示的上次打死的BOSS(只在打完BOSS后更新, 最好不要在其他地方使用)
function MasterDataManager:getKilledBossIdx()
    return self._dreamTempData.killedBossIdx or 1
end

-- 缓存服务器推送用于展示阶段挑战结算
function MasterDataManager:setJumpTempData(data)
    self._dreamJumpTempData = data
    self._dreamJumpTempData.oldLv = self._dreamData.lv
    if data.dreamCurBossIndex == #self._dreamData.bossInfos then
        -- 请求最新的数据进行更新
        Net.NetRoleSystem:requestGetDreamInfo()
    else
        self._dreamData.jump.curBossIndex = data.dreamCurBossIndex + 1
    end
end

-- 获取缓存服务器推送用于展示的阶段挑战结算数据
function MasterDataManager:getJumpTempData()
    return self._dreamJumpTempData
end

-- 清理缓存服务器推送用于展示的阶段挑战结算数据
function MasterDataManager:clearJumpTempData()
    self._dreamJumpTempData = nil
end

function MasterDataManager:setAutoShowSelectFlag(flag)
    self._dreamTempData.isShowSelectLayer = flag
end

function MasterDataManager:getAutoShowSelectFlag()
    return self._dreamTempData.isShowSelectLayer
end

function MasterDataManager:setExtraGiftFlag()
    self.extraGiftClick = true
end

function MasterDataManager:getExtraGiftFlag()
    return self.extraGiftClick
end

function MasterDataManager:handleGoodsUseInfo(data)
    local changeFlag = true
    self._goodsUseInfo = {}
    if(data and data.boughtList) then 
        for k,v in ipairs(data.boughtList) do 
            local oneData = {}
            oneData.id = v.id 
            oneData.num = v.num
            table.insert(self._goodsUseInfo, oneData)
        end
    end

    return changeFlag
end

-- 获取物品使用次数，仅限有有特殊功能的道具
function MasterDataManager:getGoodsUseNum(goodID)
    for _,old in ipairs(self._goodsUseInfo) do 
        if(old.id == goodID) then
            return old.num
        end
    end

    return 0
end

-- 获取物品使用次数
function MasterDataManager:getGoodsUseInfo()
    return self._goodsUseInfo
end


function MasterDataManager:setLittleBossInfoCache(tab)
    local old = self._curCaveBossInfoCache
    self._curCaveBossInfoCache = tab
    return old
end

function MasterDataManager:isLittleBossInfoFull()
    if(self._curCaveBossInfoCache and self._curCaveBossInfoCache.wakeScore
        and self._curCaveBossInfoCache.curScore) then
        return 
            self._curCaveBossInfoCache.wakeScore > 0 
            and self._curCaveBossInfoCache.curScore >= self._curCaveBossInfoCache.wakeScore
    else 
        return false
    end
end

function MasterDataManager:handleWorldEventData(data) 
    for k, v in ipairs(data) do 
        local found = false 
        for _,oneData in ipairs(self._worldEventArr) do 
             if(oneData:getID() == v.eventID) then 
                found = true 
                oneData:initNet(v)
                break
             end
        end
        if(found == false) then 
            local worldEventData = Data.WorldEventData:create()
            worldEventData:initNet(v)
            table.insert(self._worldEventArr, worldEventData)
        end
    end
    self._worldEventRefreshDay = self.refreshDay
end 

function MasterDataManager:getWorldEventDataForID(ID) 
    for k, v in ipairs(self._worldEventArr) do 
        if(v:getID() == ID) then 
            return v 
        end
    end

    return nil
end 

--判断 前置任务 和 事件是否还有未完成的
function MasterDataManager:isHaveVildPreEventAndTask(level)
    for k, v in ipairs(self._worldEventArr) do 
        if (v:getID() < level) then 
            if v:isValid() then
                return true
            else
                local taskData = TaskDataManager:getDistortedSpaceTaskByLevel(v:getID())
                if (taskData and not taskData:getIsReceived()) then
                    return true
                end
            end
        end
    end
    return false
end


function MasterDataManager:getAllWorldEventData() 
    return self._worldEventArr
end 

-- 触发请求逻辑
function MasterDataManager:triggerRefreshData()
    if(self._worldEventRefreshDay ~= 0 and self._worldEventRefreshDay < self.refreshDay) then 
        self._worldEventRefreshDay = self.refreshDay
        Net.NetActivitySystem:requestDistortedSpaceGlobalEvent()
    else 
        Net.NetActivitySystem:requestDistortedSpaceGlobalEvent()
    end
end

function MasterDataManager:refreshSpaceFightCount(data) 
    data = data or {}
    self._spaceFightCount = {}
    for k, v in pairs(data) do
        self._spaceFightCount[v.level] = v.figntNum
    end
end 

--levelid: 2001
function MasterDataManager:getSpaceFightCount(levelId) 
    return self._spaceFightCount[levelId] or 0
end 

function MasterDataManager:handleMazePoint(data)
    if(data) then
        if(data.isAll) then 
            self._mazePointArr = {}
            self:_handleMazePointArr(data.points)
        else 
            self:_handleMazePointArr(data.points)
        end
    end
end

function MasterDataManager:getMarkMazePointForCoord(x, y)
    if(x and y) then
        if(self._mazePointArr[x] and self._mazePointArr[y]) then 
            local arr = self._mazePointArr[x][y]
            if(arr) then 
                for k, v in ipairs(arr) do 
                    if(v.type == "MazePointType_Mark") then 
                        return v
                    end
                end
            end
        end
    end

    return nil
end

function MasterDataManager:getIsHaveMasterTrapMazePointForCoord(x, y)
    local trapArr = self:getTrapMazePointForCoord(x, y)
    if(trapArr) then
        local masterPK = RoleDataManager:getMasterPK()
        for k,v in ipairs(trapArr) do 
            if(v.pk == masterPK) then 
                return true
            end
        end
    end


    return false
end

function MasterDataManager:getIsOnlyMasterTrapMazePointForCoord(x, y)
    local trapArr = self:getTrapMazePointForCoord(x, y)
    local have = false
    if(trapArr) then
        local masterPK = RoleDataManager:getMasterPK()
        for k,v in ipairs(trapArr) do 
            if(v.pk == masterPK) then 
                have = true
            else 
                return false
            end
        end
    end

    return have
end

function MasterDataManager:getTrapMazePointForCoord(x, y)
    local trapArr = {}
    if(x and y) then
        if(self._mazePointArr[x] and self._mazePointArr[x][y]) then 
            local arr = self._mazePointArr[x][y]
            if(arr) then 
                for k, v in ipairs(arr) do 
                    if(v.type == "MazePointType_Trap") then 
                        table.insert(trapArr, v)
                    end
                end
            end
        end
    end

    return trapArr
end

function MasterDataManager:_handleMazePointArr(data)
    if(data) then
        local SceneManager = require("app.game.SceneManager")
        for k,v in ipairs(data) do 
            if(self._mazePointArr[v.x] == nil) then 
                self._mazePointArr[v.x] = {}
            end
            if(self._mazePointArr[v.x][v.y] == nil) then 
                self._mazePointArr[v.x][v.y] = {}
            end
            if(v.isAdd) then
                table.insert(self._mazePointArr[v.x][v.y], v)
                -- 通知添加了某些效果
                if(v.type == "MazePointType_Mark") then 
                    --print("MasterDataManager:_handleMazePointArr Mark add", v)
                    local command = Command.ControlCommand:create(true)
                    command:initForTypeAndData(CommandType.CONTROL_MAZE_POINT, v)
                    SceneManager:getInstance():pushCommand(command)
                elseif (v.type == "MazePointType_Trap" and RoleDataManager:getMasterPK() == v.pk) then 
                    --print("MasterDataManager:_handleMazePointArr  Trap add", v)
                    local command = Command.ControlCommand:create(true)
                    command:initForTypeAndData(CommandType.CONTROL_MAZE_POINT, v)
                    SceneManager:getInstance():pushCommand(command)
                end
            else 
                local arr = self._mazePointArr[v.x][v.y]
                if(arr and #arr > 0) then 
                    local remove = false
                    for _,oneData in ipairs(arr) do 
                        if(oneData.type == v.type and oneData.pk == v.pk) then 
                            table.remove(arr, _)
                            remove = true
                            break
                        end
                    end

                    if(remove) then 
                        -- 通知移除了某些效果
                        if(v.type == "MazePointType_Mark") then 
                            --print("MasterDataManager:_handleMazePointArr Mark remove", v)
                            local command = Command.ControlCommand:create(true)
                            command:initForTypeAndData(CommandType.CONTROL_MAZE_POINT, v)
                            SceneManager:getInstance():pushCommand(command)
                        elseif (v.type == "MazePointType_Trap" and RoleDataManager:getMasterPK() == v.pk) then 
                            --print("MasterDataManager:_handleMazePointArr Trap remove", v)
                            local command = Command.ControlCommand:create(true)
                            command:initForTypeAndData(CommandType.CONTROL_MAZE_POINT, v)
                            SceneManager:getInstance():pushCommand(command)
                        end
                    end
                end
            end
        end
    end
end

function MasterDataManager:initFirstPassData(data)
    self._battlePassData = {}
    if(data) then
        for i = 1, #data do
            local netdata = data[i]
            self:refreshFirstPassData(netdata.mode, netdata.diff, netdata.rewardData)
        end
    end
end

function MasterDataManager:refreshFirstPassData(mode, diff, byteData)
    if self._battlePassData[mode] == nil then
        self._battlePassData[mode] = {}
    end
    self._battlePassData[mode][diff] = {}
    local cfgList = ConfigManager:getFirstPassageData(mode, diff)
    for j = 1, #byteData do
        local _b = tonumber(string.byte(byteData,j))
        for k = 1,8 do
            local t = bit.band(_b,1)
            local levelId = (j - 1) * 8 + k
            local data = {}
            for k3, v3 in ipairs(cfgList) do
                if levelId == v3.level then
                    data = v3
                    break
                end
            end
            if t == 1 then
                data.isRecived = true
            else
                data.isRecived = false
            end

            self._battlePassData[mode][diff][levelId] = data
            _b = bit.rshift(_b,1)
        end
    end
    -- print("--refreshFirstPassData--", self._battlePassData)
end

function MasterDataManager:getBattlePassData(mode, diff, endLevel, curLevel)
    local list = {}
    if self._battlePassData == nil or self._battlePassData[mode] == nil or self._battlePassData[mode][diff] == nil then
        list = {}
    else
        list = self._battlePassData[mode][diff]
    end
    local array = {}
    local cfgList = ConfigManager:getFirstPassageData(mode, diff)
    local interval = SHOP_INTERVAL
    if mode == PublicDefine.CAVE_MODE.MODE_HERO or mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        interval = HERO_INTERVAL
    end
    for i = endLevel - interval + 1, endLevel do
        local data = list[i]
        if data == nil then
            data = {}
            for k3, v3 in ipairs(cfgList) do
                if i == v3.level then
                    data = v3
                    break
                end
            end
            data.isRecived = false
        end
        if i > curLevel then
            data.isFinish = false
        else
            data.isFinish = true
        end
        table.insert(array, data)
    end
    return array
end

function MasterDataManager:getMasterHeadData()
        -- message HeadRoleData {
    --     required uint64 pk = 1;
    --     optional uint32 userID = 2;
    --     optional string nickName = 3;
    --     optional uint32 faceDecodeID = 4;//捏脸数据
    --     optional uint32 templateID = 5;//头盔 遗弃
    --     optional uint32 sex = 6; //性别
    --     optional uint32 roleLV = 7;// 等级
    --     repeated uint32 wearEquipId = 8;           //穿戴的装备ID（头盔肩膀胸甲）
    -- }
    local GameDataManager = require("app.game.GameDataManager")
    local master = RoleDataManager:getMaster()

    local headRoleData =  {}
    headRoleData.pk = master:getPK()
    headRoleData.userID = master:getUserID()
    headRoleData.nickName = master:getNickName()
    headRoleData.faceDecodeID = master:getFaceDecodeID()
    headRoleData.sex = master:getSex()
    headRoleData.roleLV = master:getLevel()
    headRoleData.wearEquipId = GameDataManager:getInstance():getWearTempId()
    headRoleData.reincarntionLv = master:getReincarntionLv()
    return headRoleData
end 

function MasterDataManager:initPetData(data)
    if data.offset == 0 then
        self._petsList = {}
        -- self._fightPet = nil
        self._fightPet = {}
    end
    for k, v in ipairs(data.petlist) do
        local petData = Data.PetRoleData:create()
        petData:init(v, true)
        table.insert(self._petsList, petData)
    end

    if data.sites and #data.sites>0 then
        self._siteList = clone(data.sites)
    end

    if data.skins and table.nums(data.skins) > 0 then
        self:setPetUnlockSkinList(data.skins)
    end
    
    self:setPetReviveTimes(data)
    self:setPetRidingState(data.isRiding)
end

function MasterDataManager:setPetReviveTimes(data)
    self._petParam.reviveCount = {}
    self._petParam.revivetimes = data.revivetimes
    if data.sites then
        for k, v in pairs(data.sites) do
            self._petParam.reviveCount[v.siteId] = v.reviveCount or 0
        end
    end
end

function MasterDataManager:setPetSiteReviveTimes(data)
    local captain = self:getCaptainPet()
    if captain and data.spriteID == captain.spriteID then
        self._petParam.revivetimes = data.revivetimes
        return
    end
    local pets = self:getFightPet()
    for k, pet in pairs(pets) do
        if data.spriteID == pet.spriteID then
            self._petParam.reviveCount[pet.siteId] = data.revivetimes
            break
        end
    end
end

function MasterDataManager:clearPetReviveTimes()
    self._petParam.revivetimes = 0
    for k, v in pairs(self._petParam.reviveCount) do
        self._petParam.reviveCount[k] = 0
    end
end

function MasterDataManager:setSiteList(list)
    self._siteList = list
end

function MasterDataManager:resetSiteData(data, upgrade)
    if upgrade then
        local petId = clone(self._siteList[data.siteId].petId)

        self._siteList[data.siteId] = data
        self._siteList[data.siteId].petId = petId
        return
    end
    if self._siteList[data.siteId] then
        self._siteList[data.siteId].petId = data.petId
    else
        self._siteList[data.siteId] = data
    end
    
    -- self._siteList[data.siteId] = data
end

function MasterDataManager:getPetReviveTimes()
    return self._petParam.revivetimes or 0
end

function MasterDataManager:getPetSiteReviveTimes()
    return self._petParam.reviveCount
end

function MasterDataManager:setPetRidingState(riding)
    self._petParam.isRiding = riding
end

function MasterDataManager:getPetRidingState()
    return self._petParam.isRiding or false
end

function MasterDataManager:getBagPets()
    local sortedList = {}
    for k, v in ipairs(self._petsList) do
        table.insert(sortedList, v)
    end

    table.sort(sortedList, function(a, b)
        if a:getLevel() == b:getLevel() then
            return a.templateID > b.templateID            
        end
        return a:getLevel() > b:getLevel()
    end)

    return sortedList
end

function MasterDataManager:getBagPetById(id)
    for k, v in ipairs(self._petsList) do
        if tonumber(v:getId()) == tonumber(id) then
            return v
        end
    end
end

function MasterDataManager:getSitesData()
    return self._siteList
end

function MasterDataManager:delBagPetById(id)
    for k, v in ipairs(self._petsList) do
        if v:getId() == id then
            table.remove(self._petsList, k)
            break
        end
    end
end

function MasterDataManager:isAllowPetChange(petID)
    -- 判断是否宠物正在大航海中，若在不能对这个宠物进行
    -- 合成、炼化、传承操作
    local inBigSail = false

    local baseInfo2 = mvc.bigSailPortModel:getBaseData()
    if not baseInfo2 then
        return false
    end
    for k,v in pairs(baseInfo2.useBoats) do
        for k2,v2 in pairs(v.pets) do
            if tonumber(v2) == tonumber(petID) then
                inBigSail = true
                return inBigSail
            end
        end
    end
    return false
end

function MasterDataManager:getAllWearPetEquipment()
    local allEquipmentArr = {}
    for k, v in pairs(self._petsList) do
        local arr = v:getWearEquipmentArr()
        for _,data in pairs(arr) do 
            table.insert(allEquipmentArr, data)
        end
    end

    GoodsDataManager:handleGoodsSort(allEquipmentArr)

    return allEquipmentArr
end

function MasterDataManager:getPetDataForWearEquipmentID(entityID)
    for k, v in pairs(self._petsList) do
        local arr = v:getWearEquipmentArr()
        for _,data in pairs(arr) do 
            if(data:getEntityID() == entityID) then
                return v
            end
        end
    end

    return nil
end

function MasterDataManager:getEquipmentPetDataorWearEquipmentID(entityID)
    for k, v in pairs(self._petsList) do
        local arr = v:getWearEquipmentArr()
        for _,data in pairs(arr) do 
            if(data:getEntityID() == entityID) then
                return data
            end
        end
    end

    return nil
end

function MasterDataManager:getFightPet()
    if self._fightPet and next(self._fightPet) then
        return self._fightPet
    end
    -- for k, v in ipairs(self._petsList) do
    --     if v:isFight() then
    --         -- self._fightPet = v
    --         table.insert(self._fightPet, v)
    --         -- return v
    --     end
    -- end
    -- printError("12312312312312312")
    -- local petsData = RoleDataManager:getScreenFightPetData()
    -- local master = RoleDataManager:getMaster()
    -- for k, v in pairs(petsData) do
    --     print("222222221L:", v.masterSpriteID, master:getSpriteID())
    --     if v.masterSpriteID == master:getSpriteID() then
    --         self:setFightPet(v)
    --     end
    -- end
    return self._fightPet
end

function MasterDataManager:getFightPetbyId(spriteID)
    if self._fightPet and next(self._fightPet) then
        for _, v in pairs(self._fightPet) do
            if tonumber(v.petInstId) == tonumber(spriteID) then
                return v
            end
        end
    end
    -- for _, v in ipairs(self._petsList) do
    --     if v:isFight() and v.spriteID == spriteID  then
    --         return v
    --     end
    -- end
    return nil
end

function MasterDataManager:getCaptainPet()
    if self._fightPet and next(self._fightPet) then
        for k, v in ipairs(self._fightPet) do
            if  v:isFight() and v.siteId == 0 then
                return v
            end
        end
    end

    -- for k, v in ipairs(self._petsList) do
    --     -- print("getCaptainPetisFight:", v:isFight())
    --     -- print("getCaptainPetspriteID:", v.spriteID)
    --     -- print("getCaptainPetgetCaptain:", RoleDataManager:getCaptain())
    --     -- print("getCaptainPetpetInstId:", RoleDataManager:getCaptain().petInstId)
    --     -- print("getCaptainPetisequal", v.spriteID == tostring(RoleDataManager:getCaptain().petInstId))
    --     if v:isFight() and v.spriteID == tostring(RoleDataManager:getCaptain().petInstId) then
    --         return v
    --     end
    -- end
    return RoleDataManager:getCaptain()
end

-- 获取兽栏ID 对应的宠物数据  siteId = 0,1,2  代表兽栏1-2-3
function MasterDataManager:getFightPetBySiteId(siteId)
    local petData = nil
    local fightPet = self._fightPet or {}
    
    if not fightPet or not next(fightPet) then
        local master = RoleDataManager:getMaster()
        local petsMap = RoleDataManager:getAllScreenPetData()
        if petsMap and master then
            for k, v in pairs(petsMap) do
                if v.siteId >= 0 and v.masterSpriteID == master:getSpriteID() then
                    table.insert(fightPet,v)
                end
            end
        end
    end
    
    if fightPet and next(fightPet) then
        for k, v in ipairs(fightPet) do
            if  v:isFight() and v.siteId == siteId then
                petData = v
                break
            end
        end
    end

    return petData
end

--兽栏下阵
function MasterDataManager:removeFightPet(data)
    for k, v in pairs(self._fightPet) do
        if v.petInstId == data:getPetInstId() then
            -- table.remove(self._fightPet, k)
            self._fightPet[k] = nil
            break
        end
    end
end

-- function MasterDataManager:setFightPetByLocal(petsData)
    
-- end

function MasterDataManager:setFightPet(fightPet)
    local oldPet = self:getOldPetData(fightPet, self._fightPet)
    -- fightPet:setReadyFight(true)
    -- local curPet = self:getBagPetById(fightPet.petInstId)
    -- dump(curPet, "curPetgetBagPetById")
    -- if curPet then
    --     curPet:setReadyFight(true)
    -- end
    if oldPet then
        local bagPetData = MasterDataManager:getBagPetById(oldPet.petInstId)
        if fightPet.petInstId ~= oldPet.petInstId then
            bagPetData:setReadyFight(false)
        end
        for k, v in pairs(self._fightPet) do
            if v.siteId == fightPet.siteId then
                self._fightPet[k] = fightPet
                return
            end
        end
    end
    
    table.insert(self._fightPet, fightPet)
end

function MasterDataManager:getOldPetData(data, map)

    for k, v in pairs(map) do
        if data:getSiteId() == v:getSiteId() then
            -- print("getOldPetData:",data.petInstId, v.petInstId, data.petInstId == v.petInstId)
            return v
        end
    end
    return nil
end

--获取骑乘宠物
function MasterDataManager:getRidePet()
    if self._ridePet then
        return self._ridePet
    end
    for k, v in ipairs(self._petsList) do
        if v:isRide() then
            self._ridePet = v
            return v
        end
    end
    return nil
end

--设置骑乘宠物
function MasterDataManager:setRidePet(ridePet,isRide)
    local oldPet = self:getRidePet()
    if oldPet then
        oldPet:setReadyRide(false)
    end

    if isRide then
        ridePet:setReadyRide(true)
        self._ridePet = ridePet
    else
        ridePet:setReadyRide(false)
        self._ridePet = nil
    end
end

function MasterDataManager:getFightWearEquipmentForEquipmentType(equipmentType)
    local fightPets = MasterDataManager:getFightPet()
    -- local fightPet = MasterDataManager:getCaptainPet()
    for _, fightPet in pairs(fightPets) do
        if(fightPet and equipmentType) then 
            return fightPet:getWearEquipmentForEquipType(equipmentType)
        end
    end
    

    return nil
end


function MasterDataManager:setAntiData(data)
    self._antiData.isHoliday = data.isHoliday     --是否节假日 1：节假日 2：非节假日
    self._antiData.limitTime = data.limitTime     --限制时长（单位：秒）
    self._antiData.onlineTime = data.onlineTime   --在线时长（单位：秒）
    self._antiData.timestamp = data.timestamp     --当前时间戳（单位：秒）
    self._antiData.usableTime = data.usableTime   --剩余可用时长（单位：秒）
end

function MasterDataManager:getAntiData()
    return self._antiData.limitTime or 0, self._antiData.usableTime or 0
end

-- 获取背包拥有最大格子
function MasterDataManager:getAllBoxCanBeUseNum()
    return self.boxCanBeUsedNum
end

-- 获取背包基本可以购买的格子
function MasterDataManager:getBoxCanBeUseNum()
    return self.boxCanBeUsedNum - self.boxCanBeUsedNumItem
end

function MasterDataManager:getUnlockBagTimes()
    return self.unlockBagTimes
end

function MasterDataManager:getUnlockBagTimesItem()
    return self.unlockBagTimesItem
end

function MasterDataManager:setTotalBoxCanBeUsedNum(num)
    self.boxCanBeUsedNum = num
end

function MasterDataManager:setUnlockBagTimes(times)
    self.unlockBagTimes = times
end

function MasterDataManager:setBoxCanBeUsedNumItem(num)
    self.boxCanBeUsedNumItem = num
end

function MasterDataManager:setUnlockBagTimesItem(times)
    self.unlockBagTimesItem = times
end

function MasterDataManager:getGlyphBoxCanBeUseNum()
    -- 获取雕纹背包当前能使用的最大格子数
    return  self.glyphInitialBag + self.unlockGlyphBagItem
end

function MasterDataManager:setGlyphBoxBagItem(times)
    self.unlockGlyphBagItem = times
end

function MasterDataManager:setGlyphBoxBagTimes(times)
    self.unlockGlyphBagTimes = times
end

function MasterDataManager:getSpecialOfferIndex()
    return self.specialOfferIndex + 1
end

function MasterDataManager:setSpecialOfferIndex(specialOfferIndex)
    self.specialOfferIndex = specialOfferIndex
end

function MasterDataManager:getShowSevenStatus()
    return self.showSevenStatus
end

function MasterDataManager:setShowSevenStatus(showSevenStatus)
    self.showSevenStatus = showSevenStatus
end

function MasterDataManager:setSweepDistortedSpaceNum(sweepDistortedSpaceNum)
    self.sweepDistortedSpaceNum = sweepDistortedSpaceNum
end

function MasterDataManager:getSweepDistortedSpaceNum()
    return self.sweepDistortedSpaceNum
end

function MasterDataManager:setBossPortalUsedData(data, isReset)
    if isReset then
        self.bossPortalData = {}
    end
    if data then
        for k, v in pairs(data) do
            if v then
                self.bossPortalData[v.caveMode] = v
            end
        end
    end
end

function MasterDataManager:getBossPortalUsedData()
    return self.bossPortalData
end


----------------------------- 泰坦之路英雄模式 ----------------------------------------
function MasterDataManager:isInitTitanHeroCaveData()
    if self._titanHeroCaveData.schemeData == nil then
        return false
    end
    return true
end

function MasterDataManager:refreshTitanHeroCaveData(data)
    -- body
    self._titanHeroCaveData.nextRefreshTime = data.nextRefreshTime--刷新次数的重置时间
    self._titanHeroCaveData.nextExamineTime = data.nextExamineTime--特殊事件的重置时间
    self._titanHeroCaveData.refreshCount = data.refreshCount--特殊事件的每日手动刷新次数
    self._titanHeroCaveData.schemeExploreCount = data.schemeExploreCount--带事件的英雄模式当天剩余可探索次数
    self._titanHeroCaveData.schemeData = self._titanHeroCaveData.schemeData or {}
    for k, eventData in ipairs(data.schemeData) do
        self._titanHeroCaveData.schemeData[eventData.modeID] = eventData
        table.sort(eventData.schemeIDs, function(a, b)
            return a < b
        end)
        --v = HeroCaveSchemeData {required uint32 modeID = 1;         // 场景IDrepeated uint32 schemeIDs = 2;      // 事件组ID}
    end
end

--检查刷新手动刷新时间和手动刷新次数
function MasterDataManager:checkRefreshTitanCountAndTime()
    self._titanHeroCaveData.nextRefreshTime = self._titanHeroCaveData.nextRefreshTime == nil and 0 or self._titanHeroCaveData.nextRefreshTime
    -- if self._titanHeroCaveData.nextRefreshTime == nil or self._titanHeroCaveData.nextRefreshTime <= 0 then
    --     return false
    -- end
    local refreshTimeStrList = string.split(ConfigManager:getGeneralForKey("manualSpecialEventRefreshTime"), ";")
    local zeroTime = self._titanHeroCaveData.nextRefreshTime
    local nowTime = GameManager:getNowServerTime() - GameManager:getEPOCHTime()
    if self._titanHeroCaveData.nextRefreshTime == 0 then
        zeroTime = math.floor(nowTime / SECONDS_ONE_DAY) * SECONDS_ONE_DAY - SECONDS_ONE_DAY
    elseif self._titanHeroCaveData.nextRefreshTime % SECONDS_ONE_DAY == 0 then
        zeroTime = self._titanHeroCaveData.nextRefreshTime - SECONDS_ONE_DAY
    else
        zeroTime = math.floor(self._titanHeroCaveData.nextRefreshTime / SECONDS_ONE_DAY) * SECONDS_ONE_DAY
    end
    -- print("zeroTime ,nowTime = ", zeroTime, nowTime)
    local refreshTimeList = {}
    for k, v in ipairs(refreshTimeStrList) do
        local addTime = tonumber(v)
        addTime = addTime == 0 and 24 or addTime
        table.insert(refreshTimeList, addTime)
    end
    table.sort(refreshTimeList, function(a, b)
        return a < b
    end)
    local targetTime = 0
    -- dump(refreshTimeList, "---refreshTimeList--")
    for k, addTime in ipairs(refreshTimeList) do
        local nextTime = refreshTimeList[k + 1] or nowTime + 1
        if nowTime >= zeroTime + addTime * SECONDS_ONE_MINUTES and  nowTime < zeroTime + nextTime * SECONDS_ONE_MINUTES then
            targetTime = zeroTime + addTime * SECONDS_ONE_MINUTES
            break
        end
    end
    -- print("--targetTime--- = ", targetTime, self._titanHeroCaveData.nextRefreshTime)
    if self._titanHeroCaveData.nextRefreshTime < targetTime then
        self._titanHeroCaveData.refreshCount = 0
        self._titanHeroCaveData.nextRefreshTime = targetTime
        -- print("--self._titanHeroCaveData.nextRefreshTime--- = "..self._titanHeroCaveData.nextRefreshTime)
        return true 
    end
    return false 
end

function MasterDataManager:getTitanHeroCaveRefreshCountRemianTime()
    return self._titanHeroCaveData.nextRefreshTime or 0
end

function MasterDataManager:getTitanHeroCaveSpecialEnventRemianTime()
    return self._titanHeroCaveData.nextExamineTime or 0
end

function MasterDataManager:getTitanHeroCaveRefreshCountUsedCount()
    return self._titanHeroCaveData.refreshCount or 0
end

function MasterDataManager:getTitanHeroCaveSchemeExploreCount()
    return self._titanHeroCaveData.schemeExploreCount or 0
end

--levelId: 关卡ID
function MasterDataManager:getTitanHeroCaveSpecialEnventBySceneId(sceneId)
    if self._titanHeroCaveData.schemeData then
        local data = self._titanHeroCaveData.schemeData[sceneId]
        if data then
            local list = data.schemeIDs  
            return list, data.isUsed
        end
    end
    return {}, true
end

function MasterDataManager:isTitanNullSpecialEnvent()
    if self._titanHeroCaveData.schemeData then
        for k, data in pairs( self._titanHeroCaveData.schemeData) do
            if table.nums(data.schemeIDs) > 0 and not data.isUsed then
                return false
            end
        end
    end
    return true
end
----------------------------- 泰坦之路英雄模式 end ----------------------------------------


----------------------------- 限时登录活动任务开启标志 ----------------------------------------
function MasterDataManager:setLimitTimeLoginTaskOpenStat(isOpen)
    self.limitTimeLoginTaskOpenStat = isOpen
end

function MasterDataManager:getLimitTimeLoginTaskOpenStat()
    return self.limitTimeLoginTaskOpenStat
end

function MasterDataManager:setLimitTimeLoginTaskData(data, activityId)    
    self.limitTimeLoginTaskData[activityId] = data
end

function MasterDataManager:getLimitTimeLoginTaskData()
    return self.limitTimeLoginTaskData
end
----------------------------- 限时登录活动任务开启标志 ----------------------------------------

function MasterDataManager:setPetUnlockSkinList(list)
    self.petUnlockSkinList = list
end

function MasterDataManager:getPetUnlockSkinList()
    return self.petUnlockSkinList
end

function MasterDataManager:updatePetUnlockSkinList(skinid)
    -- self.petUnlockSkinList
    table.insert(self.petUnlockSkinList, skinid)
end

function MasterDataManager:checkPetSkinIsUnlock(skinId)
    local unlock = false
    for k, v in pairs(self.petUnlockSkinList) do
        if v == skinId then
            unlock = true
            break
        end
    end
    return unlock
end

--默认初始化
MasterDataManager:init()










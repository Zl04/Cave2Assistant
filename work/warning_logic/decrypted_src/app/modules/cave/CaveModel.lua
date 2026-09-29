--[[--
数据模型CaveModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

local GameDataManager = require("app.game.GameDataManager")

local CaveModel = class("CaveModel",mvc.GameModel)

function CaveModel:initData()
	self.randomDiamondDataArr = {}
    
    self.voidRiftRandomDiamondDataArr = {}

    self.levelData = {}                         -- 精英挑战数据
    self.infernoSweepCount = 0                  -- 深红炼狱扫荡次数
    self.infernoNightmareFightNum = 0           -- 深红炼狱噩梦挑战次数
    self.infernoNightmareReviveNum = 0          -- 深红炼狱噩梦复活次数
    self.infernoNightmareExtraFightNum = 0
    self.infernoNightMareCostArr = nil
    self.runeData = nil
    self.infernoRuneDataArr = {}

    self.voidRiftLevelData = {}                          -- 虚空秘境副本数据
    self.voidRiftSweepCount = 0                  -- 虚空秘境炼狱扫荡次数
    self.voidRiftNightmareFightNum = 0           -- 虚空秘境炼狱噩梦挑战次数
    self.voidRiftNightmareReviveNum = 0          -- 虚空秘境炼狱噩梦复活次数
    self.voidRiftNightmareExtraFightNum = 0
    self.voidRiftNightMareCostArr = nil
    self.voidRiftRuneData = nil
    self.voidRiftRuneDataArr = {}
    self.curseBuffConfig = {}

    self.ghostabyssChoiceLevel = 0
    self.ghostabyssShopExchangeList = nil
    self.ghostabyssShopHaveList = nil

    -- 服务器来的数据
    self.ghostAbyssExchangeNum = 0    -- 剩余挑战次数
    self.ghostAbyssSceneInfoData = nil
    self.ghostAbyssRewardData = nil
end

function CaveModel:handleInfernoRune(runeData)
    self.runeData = runeData
    if(self.runeData and self.runeData.selectableRunes) then
        self:setInfernoDiamondRandom(self.runeData.selectableRunes)
        if(self.runeData.equippedRunes) then 
            self:setAllInfernoRune(self.runeData.equippedRunes)
        end
    end
    -- self:setInfernoDiamondRandom({23230003,23230004,23230005})
    -- self:setAllInfernoRune({23230003,23230004,23230005,23230006,23230007,23230008,23230009})
    
end

function CaveModel:getAllInfernoRune()
    if(self.runeData) then 
        return self.runeData.equippedRunes
    end

    return {}
end


function CaveModel:getInfernoEliteTotalNum()
    return tonumber(ConfigManager:getGeneralForKey("inferno2TranswarpFrequencylimit"))
end

-- 英雄模式挑战次数
function CaveModel:getInfernoEliteNum(level)
    if(self.levelData) then 
        for k, v in ipairs(self.levelData) do 
            if(v.level == level) then 
                return v
            end
        end
    end

    return nil
end
-- 英雄模式挑战剩余次数
function CaveModel:getInfernoEliteLostNum(level)
    local levelData = self:getInfernoEliteNum(level)
    if(levelData) then
        return self:getInfernoEliteTotalNum() - levelData.fightNum + levelData.extraFightNum
    end

    return self:getInfernoEliteTotalNum()
end

function CaveModel:getInfernoNightMareTotalNum()
    return tonumber(ConfigManager:getGeneralForKey("inferno3TranswarpFrequencylimit"))
end

-- 噩梦模式挑战次数
function CaveModel:getInfernoNightMareNum()
    return self.infernoNightmareFightNum 
end

-- 噩梦模式挑战剩余次数
function CaveModel:getInfernoNightMareLostNum()
	return self:getInfernoNightMareTotalNum() - self:getInfernoNightMareNum() + self.infernoNightmareExtraFightNum
end

-- 扫荡限制次数
function CaveModel:getInfernoSweepTotalNum()
	return tonumber(ConfigManager:getGeneralForKey("infernoSweepDistortedSpaceDailyLimit"))
end

function CaveModel:setInfernoSweepNum(infernoSweepCount)
	self.infernoSweepCount = infernoSweepCount
end


-- 已经扫荡次数
function CaveModel:getInfernoSweepNum()
	return self.infernoSweepCount
end

-- 扫荡剩余次数
function CaveModel:getInfernoSweepLostNum()
	return self:getInfernoSweepTotalNum() - self:getInfernoSweepNum()
end

function CaveModel:isInInfernoNightMare()
    local SceneManager = require("app.game.SceneManager")
    local GameMapManager = require("app.game.GameMapManager")
    if SceneManager:getInstance():isInInferno() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

-- 噩梦副本复活花费
function CaveModel:getInfernoNightMareCostNum()
    if self.infernoNightMareCostArr == nil then
        self.infernoNightMareCostArr = {}
        local userCost = ConfigManager:getGeneralForKey("inferno3reviveCostDiamond")
        if(userCost) then 
            local costArr = string.split(userCost, ";")
            if(costArr) then 
                for k, v in ipairs(costArr) do 
                    table.insert(self.infernoNightMareCostArr, tonumber(v))
                end
            end
        end
    end
    if(self.infernoNightMareCostArr[self.infernoNightmareReviveNum + 1]) then 
        return self.infernoNightMareCostArr[self.infernoNightmareReviveNum + 1]
    else
        return nil
    end
end

function CaveModel:setInfernoDiamondRandom(randomLegacy)
    self.randomDiamondDataArr = {}
    if(randomLegacy) then 
        for k, v in ipairs(randomLegacy) do 
            table.insert(self.randomDiamondDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function CaveModel:getInfernoDiamondRandom()

    return self.randomDiamondDataArr
end

function CaveModel:setAllInfernoRune(idArr)
    self.infernoRuneDataArr = {}
    if(idArr) then 
        for k, v in ipairs(idArr) do 
            table.insert(self.infernoRuneDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function CaveModel:getAllInfernoRune()

    return self.infernoRuneDataArr
end

function CaveModel:handleInfernoIfo(data)
    self.levelData = data.levelData;                          -- 精英挑战数据
    self.infernoSweepCount = data.infernoSweepCount;                  -- 深红炼狱扫荡次数
    self.infernoNightmareFightNum = data.infernoNightmareFightNum;           -- 深红炼狱噩梦挑战次数
    self.infernoNightmareReviveNum = data.infernoNightmareReviveNum;          -- 深红炼狱噩梦复活次数
    self.infernoNightmareExtraFightNum = data.infernoNightmareExtraFightNum   -- 炼狱噩梦额外挑战次数
end

function CaveModel:getGhostAbyssExchangeNum()
    local masterData = RoleDataManager:getMaster()
    local ghostAbyssTiems = ConfigManager:getGeneralForKey("ghostAbyssTimes")
    ghostAbyssTiems = tonumber(ghostAbyssTiems)
    if(masterData) then
        local useNum = masterData:getGhostAbyssUsedCount()
        if(useNum == nil) then 
            useNum = 0
        end
        self.ghostAbyssExchangeNum = ghostAbyssTiems - useNum
    else
        self.ghostAbyssExchangeNum = 0 
    end
    if(self.ghostAbyssExchangeNum <0) then
        self.ghostAbyssExchangeNum = 0
    end

    -- TODO test
    -- self.ghostAbyssExchangeNum = 4

    return self.ghostAbyssExchangeNum
end

function CaveModel:getCurrentGhostabyssData()
    local ghostabysssData = nil
    if(self.ghostabyssChoiceLevel == 0) then
        local groupID = GameDataManager:getInstance():getBlackMarketGroupID()
        local allGhostabyss = ConfigManager:getAllGhostAbyss()
        if(allGhostabyss) then 
            local maxID = 0
            for _,data in pairs(allGhostabyss) do
                if(data.ID > maxID and data.unlockProgress <= groupID) then
                    maxID = data.ID
                    ghostabysssData = data
                end
            end
        end
    else
        ghostabysssData = ConfigManager:getGhostAbyssByID(self.ghostabyssChoiceLevel)
        if(ghostabysssData == nil) then 
            self.ghostabyssChoiceLevel = 0
        end
    end    
    
    return ghostabysssData
end

function CaveModel:setGhostabyssChoiceLevel(level)
    self.ghostabyssChoiceLevel = level
end

function CaveModel:getGhostabyssShopExchangeDatas()
    if(self.ghostabyssShopExchangeList == nil) then
        self.ghostabyssShopExchangeList = {}
        local shopAll = ConfigManager:getAllGhostAbyssShop()
        for _,data in pairs(shopAll) do 
            if(data.needPoint >0) then
                local ghostGoodsData = GoodsDataManager:createLocalGoodsData(data.ID)
                ghostGoodsData.ID = data.ID
                ghostGoodsData.needPoint = data.needPoint
                ghostGoodsData.buyOrder = data.buyOrder
                ghostGoodsData:setIsNew(false)

                table.insert(self.ghostabyssShopExchangeList, ghostGoodsData)
            end
        end
    end

    table.sort(self.ghostabyssShopExchangeList,function(a,b) 
        if(a.buyOrder ~= b.buyOrder)then
            if a.buyOrder < b.buyOrder then
                return true
            else
                return false 
            end
        end

        if(a.ID > b.ID) then 
            return true
        end

        return false
    end)

    return self.ghostabyssShopExchangeList
end

function CaveModel:clearGhostabyssShopHaveDatasChoiceNum()
    if(self.ghostabyssShopHaveList) then
        for _,goodsData in pairs(self.ghostabyssShopHaveList) do 
            local haveNum = GameDataManager:getInstance():getGoodsDataNum(PublicDefine.PACKET_TYPE.PACKET_BAG, goodsData:getGoodsID(), true)
            goodsData.choiceNum = 0
        end
    end
end

function CaveModel:getGhostAbyssRewardData()
    return self.ghostAbyssRewardData
end

function CaveModel:handleGhostEndReward(data)
    self.ghostAbyssRewardData = data
end


function CaveModel:handleGhostAbyssSceneInfoData(data)
    local preData = self.ghostAbyssSceneInfoData
    self.ghostAbyssSceneInfoData = data
    local ProtobufUtil = require("utils.ProtobufUtil")
    local PlotManager = require("app.game.PlotManager")

    local activeOldNum = 0;
    if(preData) then
        for k,value in ipairs(preData.totems) do 
            if(value.status) then
                if(value.status >= ProtobufUtil:enum_id("RoleSystem.GhostAbyssTotemStatus","Activated")) then 
                    activeOldNum = activeOldNum + 1
                end
            end
        end
    end
    local activeNum = 0
    if(preData ~= nil and data ~= nil) then 
        for k,value in ipairs(self.ghostAbyssSceneInfoData.totems) do 
            if(value.status) then
                if(value.status >= ProtobufUtil:enum_id("RoleSystem.GhostAbyssTotemStatus","Activated")) then 
                    activeNum = activeNum + 1
                end
                local oneData = preData.totems[k]
                if(oneData) then 
                    if(value.status ~= oneData.status) then 
                        if(value.status == ProtobufUtil:enum_id("RoleSystem.GhostAbyssTotemStatus","Activated")) then 
                            local plotID = 0;
                            if(k == 1) then
                                plotID = 1200001
                            elseif (k == 2) then
                                plotID = 1200002
                            elseif k==3 then
                                plotID = 1200003
                            end
                            PlotManager:getInstance():runPlotByID(plotID)
                        end
                    end
                end
            end
        end
        if(activeNum == #self.ghostAbyssSceneInfoData.totems and activeOldNum ~= #self.ghostAbyssSceneInfoData.totems) then 
            PlotManager:getInstance():runPlotByID(1200004)
        end
    else
        if(self.ghostAbyssSceneInfoData) then 
            for k,value in ipairs(self.ghostAbyssSceneInfoData.totems) do 
                if(value.status) then
                    if(value.status >= ProtobufUtil:enum_id("RoleSystem.GhostAbyssTotemStatus","Activated")) then 
                        activeNum = activeNum + 1
                    end
                    if(value.status == ProtobufUtil:enum_id("RoleSystem.GhostAbyssTotemStatus","Activated")) then 
                        local plotID = 0;
                        if(k == 1) then
                            plotID = 1200001
                        elseif (k == 2) then
                            plotID = 1200002
                        elseif k==3 then
                            plotID = 1200003
                        end
                        PlotManager:getInstance():runPlotByID(plotID)
                    end
                end
            end
        end
    end

    local openTotem = ProtobufUtil:enum_id("RoleSystem.GhostAbyssStatus","OpenTotem")
    if((preData == nil 
        and self.ghostAbyssSceneInfoData.status == openTotem 
        and activeNum == #self.ghostAbyssSceneInfoData.totems) 
    
        or (preData ~= nil and preData.status == openTotem
        and preData.status ~= self.ghostAbyssSceneInfoData.status 
        and activeNum == #self.ghostAbyssSceneInfoData.totems 
        and activeOldNum ~= #self.ghostAbyssSceneInfoData.totems)) then 
        PlotManager:getInstance():runPlotByID(1200004)
    end

    -- 变身提示
    if(preData) then 
        local LanguageManager = require("app.game.LanguageManager")
        if(preData.status ~= self.ghostAbyssSceneInfoData.status 
            and self.ghostAbyssSceneInfoData.status == ProtobufUtil:enum_id("RoleSystem.GhostAbyssStatus","StoneRain")) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1114542))
        end
        if(preData.status ~= self.ghostAbyssSceneInfoData.status 
            and self.ghostAbyssSceneInfoData.status == ProtobufUtil:enum_id("RoleSystem.GhostAbyssStatus","MonsterBurst")) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1114543))
        end
    end
end

function CaveModel:getIsShowEnterSceneNotice()
    if(self.ghostAbyssSceneInfoData) then
        local ProtobufUtil = require("utils.ProtobufUtil")
        local openTotem = ProtobufUtil:enum_id("RoleSystem.GhostAbyssStatus","OpenTotem")
        if(self.ghostAbyssSceneInfoData.status == openTotem) then 
            return true
        end
    end

    return false
end

function CaveModel:getBufferIDGhostAbyssSceneInfoData(index)
    if(self.ghostAbyssSceneInfoData) then 
        for k,value in pairs(self.ghostAbyssSceneInfoData.totems) do 
            if(k == index) then 
                return value.buffId
            end
        end
    end

    return 0
end

-- 获取图腾列表
function CaveModel:getTotemsGhostAbyssSceneInfoData()
    if(self.ghostAbyssSceneInfoData) then 
        return self.ghostAbyssSceneInfoData.totems
    end

    return {}
end

-- 获取图腾状态
function CaveModel:getStatusGhostAbyssSceneInfoData(index)
    if(self.ghostAbyssSceneInfoData) then 
        for k,value in ipairs(self.ghostAbyssSceneInfoData.totems) do 
            if(k == index) then 
                return value.status
            end
        end
    end

    return 0
end

function CaveModel:getRefreshDiamondGhostAbyssSceneInfoData(index)
    if(self.ghostAbyssSceneInfoData) then 
        local costStr = ConfigManager:getGeneralForKey("ghostAbyssBuffCost")
        local costArr = {0}
        if(costStr) then 
            costArr = string.split(costStr,",")
            if(costArr == nil or #costArr == 0) then 
                costArr = {0}
            end
        end
        
        for k,value in ipairs(self.ghostAbyssSceneInfoData.totems) do 
            if(k == index) then
                if(#costArr < value.refreshCount +1) then 
                    return tonumber(costArr[#costArr])
                end
                return tonumber(costArr[value.refreshCount + 1])
            end
        end
    end

    return 100
end

function CaveModel:getGhostabyssShopHaveDatas()
    if(self.ghostabyssShopHaveList == nil) then
        self.ghostabyssShopHaveList = {}
        local shopAll = ConfigManager:getAllGhostAbyssShop()
        for _,data in pairs(shopAll) do 
            if(data.givePoint >0) then
                local ghostGoodsData = GoodsDataManager:createLocalGoodsData(data.ID)
                ghostGoodsData.ID = data.ID
                ghostGoodsData.givePoint = data.givePoint
                ghostGoodsData.SellOrder = data.SellOrder
                ghostGoodsData:setIsNew(false)
                ghostGoodsData.choiceNum = 0 -- 用于后续选择数量

                table.insert(self.ghostabyssShopHaveList, ghostGoodsData)
            end
        end
    end

    -- 刷新数据
    for _,goodsData in pairs(self.ghostabyssShopHaveList) do 
        local haveNum = GameDataManager:getInstance():getGoodsDataNum(PublicDefine.PACKET_TYPE.PACKET_BAG, goodsData:getGoodsID(), true)
        goodsData:setNum(haveNum)
    end

    table.sort(self.ghostabyssShopHaveList,function (a,b) 
        if(a:getNum() > 0 and b:getNum() > 0 ) then
            if(a.SellOrder ~= b.SellOrder)then
                if a.SellOrder < b.SellOrder then
                    return true
                else
                    return false 
                end
            end

            if(a.ID > b.ID) then 
                return true
            end
        else
            if(a:getNum() > 0) then
                return true
            end
            if(b:getNum() > 0 ) then
                return false
            end

            if(a.SellOrder ~= b.SellOrder)then
                if a.SellOrder < b.SellOrder then
                    return true
                else
                    return false 
                end
            end

            if(a.ID > b.ID) then 
                return true
            end
        end

        return false
    end)

    return self.ghostabyssShopHaveList
end

--------------------------- 虚空秘境 ---------------------------
function CaveModel:handleVoidRiftRune(runeData)
    self.voidRiftRuneData = runeData
    if(self.voidRiftRuneData and self.voidRiftRuneData.selectableRunes) then
        self:setVoidRiftDiamondRandom(self.voidRiftRuneData.selectableRunes)
        if(self.voidRiftRuneData.equippedRunes) then 
            self:setAllVoidRiftRune(self.voidRiftRuneData.equippedRunes)
        end
    end
end

function CaveModel:setVoidRiftDiamondRandom(randomLegacy)  
    self.voidRiftRandomDiamondDataArr = {}
    if(randomLegacy) then 
        for k, v in ipairs(randomLegacy) do 
            table.insert(self.voidRiftRandomDiamondDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function CaveModel:getVoidRiftDiamondRandom()
    return self.voidRiftRandomDiamondDataArr
end

function CaveModel:setAllVoidRiftRune(idArr)
    self.voidRiftRuneDataArr = {}
    if(idArr) then 
        for k, v in ipairs(idArr) do 
            table.insert(self.voidRiftRuneDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function CaveModel:getAllVoidRiftRune()

    return self.voidRiftRuneDataArr
end

function CaveModel:handleVoidRiftIfo(data)
    self.voidRiftLevelData = data.levelData;                          -- 副本数据
    self.voidRiftSweepCount = data.sweepCount;                  -- 炼狱扫荡次数
    self.voidRiftNightmareFightNum = data.nightmareFightNum;           -- 炼狱噩梦挑战次数
    self.voidRiftNightmareReviveNum = data.nightmareReviveNum;          -- 炼狱噩梦复活次数
    self.voidRiftNightmareExtraFightNum = data.nightmareExtraFightNum   -- 炼狱噩梦额外挑战次数
end


function CaveModel:getVoidRiftEliteTotalNum()
    return tonumber(ConfigManager:getGeneralForKey("inferno2TranswarpFrequencylimit"))
end

-- 英雄模式挑战次数
function CaveModel:getVoidRiftEliteNum(level)
    if(self.voidRiftLevelData) then 
        for k, v in ipairs(self.voidRiftLevelData) do 
            if(v.level == level) then 
                return v
            end
        end
    end

    return nil
end
-- 英雄模式挑战剩余次数
function CaveModel:getVoidRiftEliteLostNum(level)
    local voidRiftLevelData = self:getVoidRiftEliteNum(level)
    if(voidRiftLevelData) then
        return self:getVoidRiftEliteTotalNum() - voidRiftLevelData.fightNum + voidRiftLevelData.extraFightNum
    end

    return self:getVoidRiftEliteTotalNum()
end

function CaveModel:getVoidRiftNightMareTotalNum()
    return tonumber(ConfigManager:getGeneralForKey("inferno3TranswarpFrequencylimit"))
end

-- 噩梦模式挑战次数
function CaveModel:getVoidRiftNightMareNum()
    return self.voidRiftNightmareFightNum 
end

-- 噩梦模式挑战剩余次数
function CaveModel:getVoidRiftNightMareLostNum()
	return self:getVoidRiftNightMareTotalNum() - self:getVoidRiftNightMareNum() + self.voidRiftNightmareExtraFightNum
end

-- 扫荡限制次数
function CaveModel:getVoidRiftSweepTotalNum()
	return tonumber(ConfigManager:getGeneralForKey("infernoSweepDistortedSpaceDailyLimit"))
end

function CaveModel:setVoidRiftSweepNum(voidRiftSweepCount)
	self.voidRiftSweepCount = voidRiftSweepCount
end


-- 已经扫荡次数
function CaveModel:getVoidRiftSweepNum()
	return self.voidRiftSweepCount
end

-- 扫荡剩余次数
function CaveModel:getVoidRiftSweepLostNum()
	return self:getVoidRiftSweepTotalNum() - self:getVoidRiftSweepNum()
end

function CaveModel:isInVoidRiftNightMare()
    local SceneManager = require("app.game.SceneManager")
    local GameMapManager = require("app.game.GameMapManager")
    if SceneManager:getInstance():isInVoidRift() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

-- 噩梦副本复活花费
function CaveModel:getVoidRiftNightMareCostNum()
    if self.voidRiftNightMareCostArr == nil then
        self.voidRiftNightMareCostArr = {}
        local userCost = ConfigManager:getGeneralForKey("inferno3reviveCostDiamond")
        if(userCost) then 
            local costArr = string.split(userCost, ";")
            if(costArr) then 
                for k, v in ipairs(costArr) do 
                    table.insert(self.voidRiftNightMareCostArr, tonumber(v))
                end
            end
        end
    end
    if(self.voidRiftNightMareCostArr[self.voidRiftNightmareReviveNum + 1]) then 
        return self.voidRiftNightMareCostArr[self.voidRiftNightmareReviveNum + 1]
    else
        return nil
    end
end

function CaveModel:getAllNewCaveRuneByCaveMode(caveMode)
    if caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO or caveMode == PublicDefine.CAVE_MODE.MODE_TRIAL_LAND then
        return self:getAllInfernoRune()
    end

    if caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
        return self:getAllVoidRiftRune()
    end

    if caveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
        return mvc.viKingModel:getAllViKingRune()
    end

    return nil
end

function CaveModel:setCurseBuffConfig(cavemode)
    self.curseBuffConfig = {}
    local config  = ConfigManager:getAllCurseBuffData()
    local mode = cavemode*100
    for k, v in pairs(config) do
        -- local diffcult1 = math.mod(v.mode, mode)
        local diffcult = v.mode%mode
        self.curseBuffConfig[diffcult] = self.curseBuffConfig[diffcult] or {}
        table.insert(self.curseBuffConfig[diffcult], v)
    end
end

function CaveModel:getCurseBuffConfig()
    return self.curseBuffConfig
end

return CaveModel
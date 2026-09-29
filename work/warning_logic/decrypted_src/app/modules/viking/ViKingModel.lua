--[[--
数据模型ViKingModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/12/23
--desc	: ViKingModel
------------------------------------------------------------------------------

local ViKingModel = class("ViKingModel",mvc.GameModel)

function ViKingModel:initData()
	self.viKingRandomDiamondDataArr = {}
    
    self.viKingLevelData = {}                          -- 维京时代副本数据
    self.viKingSweepCount = 0                  -- 维京时代炼狱扫荡次数
    self.viKingNightmareFightNum = 0           -- 维京时代炼狱噩梦挑战次数
    self.viKingNightmareReviveNum = 0          -- 维京时代炼狱噩梦复活次数
    self.viKingNightmareExtraFightNum = 0
    self.viKingNightMareCostArr = nil
    self.viKingRuneData = nil
    self.viKingRuneDataArr = {}
    self.curseBuffConfig = {}
end

--------------------------- 维京时代 ---------------------------
function ViKingModel:handleViKingRune(runeData)
    self.viKingRuneData = runeData
    if(self.viKingRuneData and self.viKingRuneData.selectableRunes) then
        self:setViKingDiamondRandom(self.viKingRuneData.selectableRunes)
        if(self.viKingRuneData.equippedRunes) then 
            self:setAllViKingRune(self.viKingRuneData.equippedRunes)
        end
    end
end

function ViKingModel:setViKingDiamondRandom(randomLegacy)  
    self.viKingRandomDiamondDataArr = {}
    if(randomLegacy) then 
        for k, v in ipairs(randomLegacy) do 
            table.insert(self.viKingRandomDiamondDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function ViKingModel:getViKingDiamondRandom()
    return self.viKingRandomDiamondDataArr
end

function ViKingModel:setAllViKingRune(idArr)
    self.viKingRuneDataArr = {}
    if(idArr) then 
        for k, v in ipairs(idArr) do 
            table.insert(self.viKingRuneDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function ViKingModel:getAllViKingRune()

    return self.viKingRuneDataArr
end

function ViKingModel:handleViKingIfo(data)
    self.viKingLevelData = data.levelData;                          -- 副本数据
    self.viKingSweepCount = data.sweepCount;                  -- 炼狱扫荡次数
    self.viKingNightmareFightNum = data.nightmareFightNum;           -- 炼狱噩梦挑战次数
    self.viKingNightmareReviveNum = data.nightmareReviveNum;          -- 炼狱噩梦复活次数
    self.viKingNightmareExtraFightNum = data.nightmareExtraFightNum   -- 炼狱噩梦额外挑战次数
end


function ViKingModel:getViKingEliteTotalNum()
    return tonumber(ConfigManager:getGeneralForKey("inferno2TranswarpFrequencylimit"))
end

-- 英雄模式挑战次数
function ViKingModel:getViKingEliteNum(level)
    if(self.viKingLevelData) then 
        for k, v in ipairs(self.viKingLevelData) do 
            if(v.level == level) then 
                return v
            end
        end
    end

    return nil
end
-- 英雄模式挑战剩余次数
function ViKingModel:getViKingEliteLostNum(level)
    local viKingLevelData = self:getViKingEliteNum(level)
    if(viKingLevelData) then
        return self:getViKingEliteTotalNum() - viKingLevelData.fightNum + viKingLevelData.extraFightNum
    end

    return self:getViKingEliteTotalNum()
end

function ViKingModel:getViKingNightMareTotalNum()
    return tonumber(ConfigManager:getGeneralForKey("inferno3TranswarpFrequencylimit"))
end

-- 噩梦模式挑战次数
function ViKingModel:getViKingNightMareNum()
    return self.viKingNightmareFightNum 
end

-- 噩梦模式挑战剩余次数
function ViKingModel:getViKingNightMareLostNum()
	return self:getViKingNightMareTotalNum() - self:getViKingNightMareNum() + self.viKingNightmareExtraFightNum
end

-- 扫荡限制次数
function ViKingModel:getViKingSweepTotalNum()
	return tonumber(ConfigManager:getGeneralForKey("infernoSweepDistortedSpaceDailyLimit"))
end

function ViKingModel:setViKingSweepNum(viKingSweepCount)
	self.viKingSweepCount = viKingSweepCount
end


-- 已经扫荡次数
function ViKingModel:getViKingSweepNum()
	return self.viKingSweepCount
end

-- 扫荡剩余次数
function ViKingModel:getViKingSweepLostNum()
	return self:getViKingSweepTotalNum() - self:getViKingSweepNum()
end

function ViKingModel:isInViKingNightMare()
    local SceneManager = require("app.game.SceneManager")
    local GameMapManager = require("app.game.GameMapManager")
    if SceneManager:getInstance():isInViKing() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

-- 噩梦副本复活花费
function ViKingModel:getViKingNightMareCostNum()
    if self.viKingNightMareCostArr == nil then
        self.viKingNightMareCostArr = {}
        local userCost = ConfigManager:getGeneralForKey("inferno3reviveCostDiamond")
        if(userCost) then 
            local costArr = string.split(userCost, ";")
            if(costArr) then 
                for k, v in ipairs(costArr) do 
                    table.insert(self.viKingNightMareCostArr, tonumber(v))
                end
            end
        end
    end
    if(self.viKingNightMareCostArr[self.viKingNightmareReviveNum + 1]) then 
        return self.viKingNightMareCostArr[self.viKingNightmareReviveNum + 1]
    else
        return nil
    end
end

function ViKingModel:getAllNewCaveRuneByCaveMode(caveMode)
    if caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO or caveMode == PublicDefine.CAVE_MODE.MODE_TRIAL_LAND then
        return self:getAllInfernoRune()
    end

    if caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
        return self:getAllViKingRune()
    end

    return nil
end

function ViKingModel:setCurseBuffConfig(cavemode)
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

function ViKingModel:getCurseBuffConfig()
    return self.curseBuffConfig
end


return ViKingModel
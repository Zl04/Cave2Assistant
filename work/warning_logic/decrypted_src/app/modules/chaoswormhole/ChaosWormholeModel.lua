--[[--
数据模型ChaosWormholeModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/08/08
--desc	: ChaosWormholeModel
------------------------------------------------------------------------------

local ChaosWormholeModel = class("ChaosWormholeModel",mvc.GameModel)

function ChaosWormholeModel:initData()
	self.ChaosWormholeRandomDiamondDataArr = {}
    
    self.ChaosWormholeLevelData = {}                          -- 混沌虫洞副本数据
    self.ChaosWormholeSweepCount = 0                  -- 混沌虫洞炼狱扫荡次数
    self.ChaosWormholeNightmareFightNum = 0           -- 混沌虫洞炼狱噩梦挑战次数
    self.ChaosWormholeNightmareReviveNum = 0          -- 混沌虫洞炼狱噩梦复活次数
    self.ChaosWormholeNightmareExtraFightNum = 0
    self.ChaosWormholeNightMareCostArr = nil
    self.ChaosWormholeRuneData = nil
    self.ChaosWormholeRuneDataArr = {}
    self.curseBuffConfig = {}

    self.selectExtraPara = 1
end

--------------------------- 混沌虫洞 ---------------------------
function ChaosWormholeModel:handleChaosWormholeRune(runeData)
    self.ChaosWormholeRuneData = runeData
    if(self.ChaosWormholeRuneData and self.ChaosWormholeRuneData.selectableRunes) then
        self:setChaosWormholeDiamondRandom(self.ChaosWormholeRuneData.selectableRunes)
        if(self.ChaosWormholeRuneData.equippedRunes) then 
            self:setAllChaosWormholeRune(self.ChaosWormholeRuneData.equippedRunes)
        end
    end
end

function ChaosWormholeModel:setChaosWormholeDiamondRandom(randomLegacy)  
    self.ChaosWormholeRandomDiamondDataArr = {}
    if(randomLegacy) then 
        for k, v in ipairs(randomLegacy) do 
            table.insert(self.ChaosWormholeRandomDiamondDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function ChaosWormholeModel:getChaosWormholeDiamondRandom()
    return self.ChaosWormholeRandomDiamondDataArr
end

function ChaosWormholeModel:setAllChaosWormholeRune(idArr)
    self.ChaosWormholeRuneDataArr = {}
    if(idArr) then 
        for k, v in ipairs(idArr) do 
            table.insert(self.ChaosWormholeRuneDataArr, GoodsDataManager:createLocalGoodsData(v))
        end
    end
end

function ChaosWormholeModel:getAllChaosWormholeRune()

    return self.ChaosWormholeRuneDataArr
end

function ChaosWormholeModel:handleChaosWormholeIfo(data)
    self.ChaosWormholeLevelData = data.levelData;                          -- 副本数据
    self.ChaosWormholeSweepCount = data.sweepCount;                  -- 炼狱扫荡次数
    self.ChaosWormholeNightmareFightNum = data.nightmareFightNum;           -- 炼狱噩梦挑战次数
    self.ChaosWormholeNightmareReviveNum = data.nightmareReviveNum;          -- 炼狱噩梦复活次数
    self.ChaosWormholeNightmareExtraFightNum = data.nightmareExtraFightNum   -- 炼狱噩梦额外挑战次数
end


function ChaosWormholeModel:getChaosWormholeEliteTotalNum()
    return tonumber(ConfigManager:getGeneralForKey("inferno2TranswarpFrequencylimit"))
end

-- 英雄模式挑战次数
function ChaosWormholeModel:getChaosWormholeEliteNum(level)
    if(self.ChaosWormholeLevelData) then 
        for k, v in ipairs(self.ChaosWormholeLevelData) do 
            if(v.level == level) then 
                return v
            end
        end
    end

    return nil
end
-- 英雄模式挑战剩余次数
function ChaosWormholeModel:getChaosWormholeEliteLostNum(level)
    local ChaosWormholeLevelData = self:getChaosWormholeEliteNum(level)
    if(ChaosWormholeLevelData) then
        return self:getChaosWormholeEliteTotalNum() - ChaosWormholeLevelData.fightNum + ChaosWormholeLevelData.extraFightNum
    end

    return self:getChaosWormholeEliteTotalNum()
end

function ChaosWormholeModel:getChaosWormholeNightMareTotalNum()
    return tonumber(ConfigManager:getGeneralForKey("inferno3TranswarpFrequencylimit"))
end

-- 噩梦模式挑战次数
function ChaosWormholeModel:getChaosWormholeNightMareNum()
    return self.ChaosWormholeNightmareFightNum 
end

-- 噩梦模式挑战剩余次数
function ChaosWormholeModel:getChaosWormholeNightMareLostNum()
	return self:getChaosWormholeNightMareTotalNum() - self:getChaosWormholeNightMareNum() + self.ChaosWormholeNightmareExtraFightNum
end

-- 扫荡限制次数
function ChaosWormholeModel:getChaosWormholeSweepTotalNum()
	return tonumber(ConfigManager:getGeneralForKey("infernoSweepDistortedSpaceDailyLimit"))
end

function ChaosWormholeModel:setChaosWormholeSweepNum(ChaosWormholeSweepCount)
	self.ChaosWormholeSweepCount = ChaosWormholeSweepCount
end


-- 已经扫荡次数
function ChaosWormholeModel:getChaosWormholeSweepNum()
	return self.ChaosWormholeSweepCount
end

-- 扫荡剩余次数
function ChaosWormholeModel:getChaosWormholeSweepLostNum()
	return self:getChaosWormholeSweepTotalNum() - self:getChaosWormholeSweepNum()
end

function ChaosWormholeModel:isInChaosWormholeNightMare()
    local SceneManager = require("app.game.SceneManager")
    local GameMapManager = require("app.game.GameMapManager")
    if SceneManager:getInstance():isInChaosWormhole() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

-- 噩梦副本复活花费
function ChaosWormholeModel:getChaosWormholeNightMareCostNum()
    if self.ChaosWormholeNightMareCostArr == nil then
        self.ChaosWormholeNightMareCostArr = {}
        local userCost = ConfigManager:getGeneralForKey("inferno3reviveCostDiamond")
        if(userCost) then 
            local costArr = string.split(userCost, ";")
            if(costArr) then 
                for k, v in ipairs(costArr) do 
                    table.insert(self.ChaosWormholeNightMareCostArr, tonumber(v))
                end
            end
        end
    end
    if(self.ChaosWormholeNightMareCostArr[self.ChaosWormholeNightmareReviveNum + 1]) then 
        return self.ChaosWormholeNightMareCostArr[self.ChaosWormholeNightmareReviveNum + 1]
    else
        return nil
    end
end

function ChaosWormholeModel:getAllNewCaveRuneByCaveMode(caveMode)
    if caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO or caveMode == PublicDefine.CAVE_MODE.MODE_TRIAL_LAND then
        return self:getAllInfernoRune()
    end

    if caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
        return self:getAllChaosWormholeRune()
    end

    return nil
end

-- function ChaosWormholeModel:setCurseBuffConfig(cavemode)
--     self.curseBuffConfig = {}
--     local config  = ConfigManager:getAllCurseBuffData()
--     local mode = cavemode*100
--     for k, v in pairs(config) do
--         -- local diffcult1 = math.mod(v.mode, mode)
--         local diffcult = v.mode%mode
--         self.curseBuffConfig[diffcult] = self.curseBuffConfig[diffcult] or {}
--         table.insert(self.curseBuffConfig[diffcult], v)
--     end
-- end

-- function ChaosWormholeModel:getCurseBuffConfig()
--     return self.curseBuffConfig
-- end


return ChaosWormholeModel
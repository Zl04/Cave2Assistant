--[[--
数据模型HitRatModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/10
--desc	: HitRatModel
------------------------------------------------------------------------------

local HitRatModel = class("HitRatModel",mvc.GameModel)
local GameMapManager = require("app.game.GameMapManager")
local ratScoreAddMap

function HitRatModel:initData()
    self.hammerId = nil
    self.isHotAct = nil
    self.sceneRunTime = nil
    self.hotValue = nil
    self.battleResult = nil

    self.scoreInfo = {}

    self.targetHeroData = nil
    self.hammerEndTime = nil
    self.isScoreInit = false
    self.tmpScore ={}

    self.scoreScale = 1
end

function HitRatModel:getTargetHeroData()
    return self.targetHeroData
end


function HitRatModel:setHommerInfo(hammerID, isHotAct, sceneRunTime, hotValue, hammerEndTime)
    if self.isHotAct and not isHotAct then --只是把hot状态设置为false
        self:set("isHotAct", isHotAct)
        return
    end

    self.hammerEndTime = hammerEndTime
    self:set("hammerId", hammerID)
    self:set("isHotAct", isHotAct)
    self:set("sceneRunTime", sceneRunTime)
    self:set("hotValue", hotValue)
end

function HitRatModel:getHammerCountDownPer()
    return 1, self.hammerEndTime/1000 - GameManager:getNormalServerTime()
end

function HitRatModel:getFightRemindCD()
    local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    
    local lifeTime = 0
    local freezeTime = 0
    if(configData) then 
        lifeTime = configData.lifetime
        freezeTime = configData.freezetime
    end
    return self:getSceneTime() - (lifeTime - freezeTime)
end

function HitRatModel:isOverloadHot()
    return self.isHotAct
end

function HitRatModel:setHommerIsHot(isHotAct)
    self:set("isHotAct", isHotAct)
end

function HitRatModel:setHommerHotValue(hotValue)
    self:set("hotValue", hotValue)
end

function HitRatModel:getHammerId()
    return self.hammerId
end

function HitRatModel:getRatAddScore(monsterId)
    if not ratScoreAddMap then
        ratScoreAddMap = {}
        local str = ConfigManager:getGeneralForKey("hitratKillRatPoint")
        local info = str:split(";")
        for key, str in pairs(info) do
            local tmp = str:split(",")   
            ratScoreAddMap[tonumber(tmp[1])] = tonumber(tmp[2])     
        end
    end
    return ratScoreAddMap[monsterId] * self.scoreScale
end

function HitRatModel:getHotValuePer()
    local str = ConfigManager:getGeneralForKey("hitratHotPower")
    local info = str:split(",")
    return self.hotValue/tonumber(info[2]), self.hotValue/(tonumber(info[1])* 3)
end

function HitRatModel:getSceneTime()
    local nowTime = GameManager:getNormalServerTime()
    local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    local mazeFreezeTime = nil
    if(configData) then 
        mazeFreezeTime = configData.lifetime
    end
    local freezeTime = mazeFreezeTime or 600
    return self.sceneRunTime + freezeTime - nowTime
end

function HitRatModel:clearScoreInfo()
    self.hammerId = nil
    self.isHotAct = nil
    self.sceneRunTime = nil
    self.hotValue = nil
    self.battleResult = nil

    self.scoreInfo = {}

    self.targetHeroData = nil
    self.hammerEndTime = nil
    self.isScoreInit = false
    self.tmpScore ={}

    self.scoreScale = 1

end

function HitRatModel:setTargetHeroData(heroData)
    local masterPK = RoleDataManager:getMasterPK()
    local roleName = RoleDataManager:getMaster():getNickName()
    if #self.scoreInfo == 2 then
        return
    end
    local scoreInfos = {}
    scoreInfos={
        {name=roleName, score = self.tmpScore[masterPK] or 0, pk = masterPK},
        {name=heroData:getNickName(), score = self.tmpScore[heroData:getPK()] or 0, pk = heroData:getPK()},
    }
    self.scoreInfo = scoreInfos
    self.isScoreInit = true
    self:sortScoreRank()
    self:setForce("scoreInfo", false)
end

function HitRatModel:getScoreRank()
    if not self.isScoreInit then
        local masterPK = RoleDataManager:getMasterPK()
        local roleName = RoleDataManager:getMaster():getNickName()
        local scoreInfos = {}
        scoreInfos={
            {name=roleName, score = self.tmpScore[masterPK] or 0, pk = masterPK},
        }
        self.scoreInfo = scoreInfos
    end

    return self.scoreInfo
end

function HitRatModel:sortScoreRank()
    local isChangedRank = false
    local first = self.scoreInfo[1]
    if first.score < self.scoreInfo[2].score then
        local tmp = first
        self.scoreInfo[1] = self.scoreInfo[2]
        self.scoreInfo[2] = first
        isChangedRank = true
    end
    return isChangedRank
end
function HitRatModel:setScoreInfo(pk, deltaScore,totalScore)
    if not self.isScoreInit then
        self.tmpScore[pk] = totalScore
        self:setForce("scoreInfo", false)
        return
    end
    local first = self.scoreInfo[1]
    if first.pk == pk then
        first.score = totalScore
    else
        self.scoreInfo[2].score = totalScore
    end

    

    self:setForce("scoreInfo", self:sortScoreRank())
end

function HitRatModel:setBattleResult(data)
    self.battleResult = data
end

function HitRatModel:getBattleResult()
    return self.battleResult
end

local hammerNames = nil
function HitRatModel:getHammerName()
    if not hammerNames then
        local str = ConfigManager:getGeneralForKey("hitratHammerName")
        hammerNames = str:split(";")
    end
    return UIUtil:lang(tonumber(hammerNames[self.hammerId]))
end

return HitRatModel
--[[--
数据模型BigCrackModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/01
--desc	: BigCrackModel
------------------------------------------------------------------------------

local BigCrackModel = class("BigCrackModel",mvc.GameModel)
local GameMapManager = require("app.game.GameMapManager")
local ProtobufUtil = require "utils.ProtobufUtil"

function BigCrackModel:initData()
    self.bossInfos = {}

    self.sceneRunTime = 0
    self.camps = {}
    self.campId = 0

    self.isSettling = false
end

function BigCrackModel:clear()
    self.bossInfos = {}
    self.sceneRunTime = 0
    self.camps = {}
    self.campId = 0
    self.isSettling = false
end

function BigCrackModel:getBossBuffs(camp)
    if not self.bossInfos[camp] then
        return
    end
    local spritId = self.bossInfos[camp].spriteID

    local bufferDataList = SkillDataManager:getBufferDataListForSpriteID(spritId)
        -- local GameDataManager = require("app.game.GameDataManager")
        -- local master = GameDataManager:getInstance():getMaster()
    local buffs 
    if bufferDataList then
        buffs = {}
        for k, v in pairs(bufferDataList) do
            if (v:getICON()) then
                table.insert(buffs, v)
            end
        end
    end
    return buffs
end

function BigCrackModel:setBossInfo(bossInfos)
    for _, info in pairs(bossInfos) do
        local campId= ProtobufUtil:enum_id("PublicDefine.Camp", info.camp)
        local bossId = info.bossID
        local monsterData = RoleDataManager:createLocalMonsterDataForModeAndDiff(bossId, 
            PublicDefine.CAVE_MODE.MODE_ACT, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1) 
        self.bossInfos[campId] = {
            curHp = info.curHP,
            hp = info.hp,
            spriteID = info.spriteID,
            name = monsterData and monsterData:getName() or "",
            x = info.x,
            y = info.y
        }

        local buffs = info.buff
        for k,v in pairs(buffs) do
            if v.buffID and v.buffID > 0 then
                SkillDataManager:handleBufferDataReback(v, info.spriteID)
            end
        end
    end
    self:setForce("bossInfos", self.bossInfos)
end

function BigCrackModel:getbossInfos(camp)
    return self.bossInfos[camp]
end

function BigCrackModel:setSceneRunTime(sceneRunTime)
    self.sceneRunTime = sceneRunTime
end

function BigCrackModel:getFightRemindCD()
    local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    
    local lifeTime = 0
    local freezeTime = 0
    if(configData) then 
        lifeTime = configData.lifetime
        freezeTime = configData.freezetime
    end
    return self:getSceneTime() - (lifeTime - freezeTime)
end

function BigCrackModel:getSceneTime()
    local nowTime = GameManager:getNormalServerTime()
    local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    local mazeFreezeTime = nil
    if(configData) then 
        mazeFreezeTime = configData.lifetime
    end
    local freezeTime = mazeFreezeTime or 600
    return self.sceneRunTime + freezeTime - nowTime
end

function BigCrackModel:setCampId(camp)
    self.campId = ProtobufUtil:enum_id("PublicDefine.Camp", camp)
end

function BigCrackModel:getCampId()
    return self.campId
end
function BigCrackModel:setIsSettle(bool)
    self.isSettling = bool
end
function BigCrackModel:getIsSettle()
    return self.isSettling
end

function BigCrackModel:updateCamp(teamRoleData, campHero)
    if not teamRoleData then
        teamRoleData = Data.TeamRoleData:create()
    end
    teamRoleData:initNet({
        memberStatus = campHero.memberStatus,
        pk = campHero.pk,
        sex = campHero.sex,
        nickName = ToolsUtil:replaceShowNickNameStr(campHero.nickName),
        faceDecodeID = campHero.faceDecodeID,
    })
    return teamRoleData
end

function BigCrackModel:setCampHero(campHeros)
    for i = 1, #campHeros do
        local campHero = campHeros[i]
        self.camps[campHero.pk] = self:updateCamp(self.camps[campHero.pk], campHero)
    end
    self:setForce("camps", self.camps)
end

function BigCrackModel:getCamps()
    return self.camps
end


function BigCrackModel:getFestivalConfig()
    -- local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    local configData = ConfigManager:getFestivalDataForID(8103)
    return configData
end

return BigCrackModel
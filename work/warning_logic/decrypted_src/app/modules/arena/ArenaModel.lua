--[[--
数据模型ArenaModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/29
--desc	: ArenaModel
------------------------------------------------------------------------------

local ArenaModel = class("ArenaModel",mvc.GameModel)

function ArenaModel:initData()
    self.fightCnt = 0
    self.score = 0
    self.logs = nil
    self.enemyDatas = nil
    self.rankDataArr = nil
    self.selfRankData = nil

    self.enemyDatas = {}
    self.enemyDatas[1] = {}
    self.enemyDatas[2] = {}
    self.enemyDatas[3] = {}
    self.enemyDatas[4] = {}
    self.enemyDatas[5] = {}

    self.rankDataArr = {}
    self.selfRankData = nil
    -- for k=1,15,1 do 
    --     local data = {}
    --     data.rank = k
    --     data.nickName = "没催你"..k
    --     data.faceId = 0
    --     data.sex = 1

    --     if(k==6) then
    --         self.selfRankData = data
    --     end
    --     table.insert(self.rankDataArr, data)
    -- end

end

function ArenaModel:handleArenaData(data)
    self.fightCnt = data.fightCnt
    self.score = data.score

    self:initLogs(data.logs)
    self:initEnemyData(data.enemyDatas)
end

function ArenaModel:initLogs(logs)
    self.logs = {}

    for k, v in ipairs(logs) do 
        self:addOneLogs(v)
    end
end

function ArenaModel:addOneLogs(v)
    if(v) then
        local log = {}
        log.pk = v.pk
        log.name = v.name
        log.isWin = v.isWin
        log.isRevengeSuc = v.isRevengeSuc --是否复仇成功
        log.id = v.id

        table.insert(self.logs, log)
    end
end

function ArenaModel:getFightCnt()
    return self.fightCnt
end

function ArenaModel:getScore()
    return self.score
end

function ArenaModel:getLogs()
    return self.logs
end

function ArenaModel:initEnemyData(data)
    self.enemyDatas = {}
    self.enemyDatas = data

    -- repeated uint32 skills = 2;                     // 技能
    -- optional PetSystem.PetRoleData pet = 3;         // 宠物
    -- optional uint32 score = 4;                      // 积分
    -- optional uint32 refreshEnemyTime = 5;           // 刷新时间
    -- optional RoleSystem.HeroDetail hero = 6;        // 英雄简要数据 
    -- optional uint32 rank = 7;                       // 排名
    -- optional bool isRobot = 9;                      // 是否位机器人
end

function ArenaModel:getEnemyData()
    return self.enemyDatas
end

function ArenaModel:getRankData()
    return self.rankDataArr
end

function ArenaModel:getSelfRankData()
    return self.selfRankData
end

return ArenaModel
--[[--
数据模型PuzzleModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/08/03
--desc	: PuzzleModel
------------------------------------------------------------------------------

local PuzzleModel = class("PuzzleModel",mvc.GameModel)
local GameMapManager = require("app.game.GameMapManager")

function PuzzleModel:initData()
    -- 当前游戏分数
    self.curScoreNum = 0

    -- 当前游戏已经匹配对数
    self.overNum = nil

    -- 地块对应的数据
    self.mapInfo = nil

    -- 怪物templateID组
    self.templateList = nil

    -- 怪物templateID列表随机指标
    self.pointer = nil

    -- 选择出的怪物templateID列表
    self.monsterTemplateList = nil

    -- 等待协对的另外一个怪物数据
    self.otherMonsterInfo = nil

    -- 屏蔽点击
    self.isLockClick = false

    -- 进入时间点
    self.sceneRunTime = nil

    -- 生成地块格子模版
    self.mapTilePosList = {
        {coordX = 3, coordY = 5},{coordX = 3, coordY = 3},{coordX = 3, coordY = 1},{coordX = 4, coordY = 4},
        {coordX = 4, coordY = 2},{coordX = 5, coordY = 5},{coordX = 5, coordY = 3},{coordX = 5, coordY = 1},
        {coordX = 6, coordY = 4},{coordX = 6, coordY = 2},{coordX = 7, coordY = 5},{coordX = 7, coordY = 3},
        {coordX = 7, coordY = 1},{coordX = 8, coordY = 2}
    }

    -- 怪物模版
    self.monsterTemplate = {
        triggerNum = 0,
        monsterID = 10201101,
        hp = 1,
        isTransform = false,
        coordY = 3,
        rare = 0,
        functionFlag = 0,
        spriteID = 10000017,
        status = 1,
        coordX = 4,
        curHp = 1,
    }

    -- 宝箱模版
    self.boxTemplate = {
        coordY = 3,
        isLock = false,
        templateID = tonumber(ConfigManager:getGeneralForKey("puzzleNpcID")), -- 10301006,
        spriteID = 54559208,
        triggeredCount = 0,
        coordX = 4,
        isRandomTransfer = false,
    }
end

function PuzzleModel:clearSceneRunTime()
    self.sceneRunTime = nil
end

function PuzzleModel:addCurScoreNum()
    self.curScoreNum = self.curScoreNum + 4
end

function PuzzleModel:clearCurScoreNum()
    self.curScoreNum = 0
end

function PuzzleModel:addOverNum()
    self.overNum = self.overNum + 1
end

function PuzzleModel:clearOverNum()
    self.overNum = 0
end

function PuzzleModel:setLockClick(bool)
    self.isLockClick = bool
end

function PuzzleModel:setMapInfo(coordX, coordY, boxSpriteID, boxTemplateID, monsterSpriteID, monsterTemplateID, state)
    if not self.mapInfo then
        self.mapInfo = {}
    end

    if not self.mapInfo[coordX] then
        self.mapInfo[coordX] = {}
    end

    if not self.mapInfo[coordX][coordY] then
        self.mapInfo[coordX][coordY] = {}
    end

    self.mapInfo[coordX][coordY].boxSpriteID = boxSpriteID
    self.mapInfo[coordX][coordY].boxTemplateID = boxTemplateID
    self.mapInfo[coordX][coordY].monsterSpriteID = monsterSpriteID
    self.mapInfo[coordX][coordY].monsterTemplateID = monsterTemplateID
    self.mapInfo[coordX][coordY].state = state
end

function PuzzleModel:clearMapInfo()
    self.mapInfo = nil
end

function PuzzleModel:setMonsterTemplateList()
    -- 获取怪物templateID组
    if not self.templateList then
        local mapConfig = require("Resource/profiles/dataProfile/ProfileClientLevel_10_1")
        self.templateList = clone(mapConfig[tonumber(PublicDefine.CONST_DEFINITION.PUZZLE_MAP_ID)].monsterID)
    end
    -- 获取抓取的模版种类数量
    local totalNum = self:getBoxTotalNum() / 2

    -- 去重随机
    -- 重置选择出的怪物templateID列表
    self.monsterTemplateList = {}

    -- 初始化标记点
    if not self.pointer then
        self.pointer = #self.templateList
    end

    -- 每次随机结果的值与标记的位置的值替换位置，标记向前移动，则下次需要随机的范围就为1~标记位置，从而避免重复
    -- 如果单次需要随机选择数量大于剩余随机池数量，则替换至池尾，直到随机完池，标记到替换池尾位置之前再次随机
    local otherPointer = totalNum >= self.pointer and #self.templateList or nil
    for index = totalNum, 1, -1 do
        local randomIndex = math.random(1, self.pointer)
        table.insert(self.monsterTemplateList, self.templateList[randomIndex])
        if not otherPointer then
            self.templateList[randomIndex], self.templateList[self.pointer] = self.templateList[self.pointer], self.templateList[randomIndex]
        else
            self.templateList[randomIndex], self.templateList[otherPointer] = self.templateList[otherPointer], self.templateList[randomIndex]
            otherPointer = otherPointer - 1
        end
        self.pointer = self.pointer - 1

        -- 当随机完所有模版后，剔除当前轮已随机到的，重新继续随机
        if self.pointer == 0 then
            self.pointer = otherPointer
        end
    end

    -- 随机排序
    for index = 1, totalNum do
        table.insert(self.monsterTemplateList, self.monsterTemplateList[index])
    end

    for index = 1, totalNum * 2 do
        local randomIndex = math.random(index, totalNum * 2)
        self.monsterTemplateList[index], self.monsterTemplateList[randomIndex] = self.monsterTemplateList[randomIndex], self.monsterTemplateList[index]
    end
end

function PuzzleModel:setOtherMonsterInfo(data)
    self.otherMonsterInfo = data
end

function PuzzleModel:getCurScoreNum()
    return self.curScoreNum
end

function PuzzleModel:getOverNum()
    return self.overNum
end

function PuzzleModel:getLockClick()
    return self.isLockClick
end

function PuzzleModel:getMapInfo(coordX, coordY)
    if not self.mapInfo or not self.mapInfo[coordX] or not self.mapInfo[coordX][coordY] then
        return nil
    end

    return self.mapInfo[coordX][coordY]
end

function PuzzleModel:getFightRemindCD()
    local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    local lifeTime = 0
    local freezeTime = 0
    if(configData) then 
        lifeTime = configData.lifetime
        freezeTime = configData.freezetime
    end

    return self:getSceneTime() - (lifeTime - freezeTime)
end

function PuzzleModel:getSceneTime()
    local nowTime = GameManager:getNormalServerTime()
    local configData = ConfigManager:getFestivalDataForID(GameMapManager:getInstance():getLevel())
    local mazeFreezeTime = nil
    if(configData) then 
        mazeFreezeTime = configData.lifetime
    end
    local freezeTime = mazeFreezeTime or 600

    if not self.sceneRunTime then
        self.sceneRunTime = GameManager:getNormalServerTime()
    end

    return self.sceneRunTime + freezeTime - nowTime
end

function PuzzleModel:getMonsterTemplate()
    return self.monsterTemplate
end

function PuzzleModel:getBoxTemplate()
    return self.boxTemplate
end

function PuzzleModel:getMonsterTemplateList()
    return self.monsterTemplateList
end

function PuzzleModel:getMapTilePosList()
    return self.mapTilePosList
end

function PuzzleModel:getBoxTotalNum()
    return 14
end

function PuzzleModel:getOtherMonsterInfo()
    return self.otherMonsterInfo
end

return PuzzleModel
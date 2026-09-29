--[[
    战斗数据
]]--

local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameMapManager = require("app.game.GameMapManager")
require "utils.AvalonUtil"
require "bit"

Battle = Battle or {}

local BattleModel = class("BattleModel", Machine.ShareModel)
Battle.NewBattleModel = BattleModel

local DEBUG = false

-- private:

-- public:
-- 构造函数
function BattleModel:ctor()
    BattleModel.super.ctor(self)
end

-- 销毁
function BattleModel:destroy()
    BattleModel.super.destroy(self)
end

-- 初始化
function BattleModel:init()
    BattleModel.super.init(self)
end

-- 清理
function BattleModel:clear()
    BattleModel.super.clear()
end

-- 创建地图
function BattleModel:createMap(data)
    -- print("########BattleModel:createMap")
    self._mapData = GameMapManager:getInstance():loadMapDataForState(data)
end

local function createBitMask(startBit, endBit)
    local mask = 0
    for i = startBit + 1 , endBit + 1 do 
        mask = bit.bor(mask, bit.lshift(1, i - 1))
    end
    return mask;
end

function BattleModel:updateMapDataWithExploredViewAreaData(data)
    local bitMask = createBitMask(0, 15)
    for i, v in ipairs(data.viewAreaValue) do
        local viewAreaIndex = bit.band(v, bitMask)
        local viewAreaX = math.floor(viewAreaIndex % data.viewAreaSizeX)
        local viewAreaY = math.floor(viewAreaIndex / data.viewAreaSizeY)
        local viewAreaReached = bit.band(bit.rshift(v, 16), bitMask)
         -- printfmt("ExploredViewAreaData viewAreaIndex %d viewAreaX %d viewAreaY %d viewAreaReached %d", viewAreaIndex, viewAreaX, viewAreaY, viewAreaReached)
        for y = 1, data.viewAreaHeight do
            for x = 1, data.viewAreaWidth do
                local tileX = viewAreaX * data.viewAreaWidth + x - 1
                local tileY = viewAreaY * data.viewAreaHeight + y - 1
                local tile = self._mapData:getTileDataAtCoord(tileX, tileY)
                -- printfmt("ExploredViewAreaData tileX %d tileY %d reachedValue %d", tileX, tileY, viewAreaReached)
                if tile ~= nil then
                    local localTileIndex = (y - 1) * data.viewAreaWidth + x - 1
                    local bitMask = createBitMask(localTileIndex, localTileIndex)
                    local walkSign = bit.rshift(bit.band(viewAreaReached, bitMask), localTileIndex)
                    -- printfmt("ExploredViewAreaData localTileIndex %d bitMask %d walkSign %d", localTileIndex, bitMask, walkSign)
                    if walkSign == 1 then
                        tile:setReached(true)
                        -- printfmt("ExploredViewAreaData tile reached %d,%d", tileX, tileY)

                        -- set dungeon room reached
                        if not self._mapData:isDungeonRoomReachedAtCoordinate(tileX, tileY) then 
                            self._mapData:setDungeonRoomReachedAtCoordinate(tileX, tileY, true)
                        end
                    end
                end
            end
        end
    end
end

function BattleModel:updateMapDataWithTransformedGround(data)
    local bitMask = createBitMask(0, 15)
    for i, v in ipairs(data.viewAreaValue) do
        local viewAreaIndex = bit.band(v, bitMask)
        local viewAreaX = math.floor(viewAreaIndex % data.viewAreaSizeX)
        local viewAreaY = math.floor(viewAreaIndex / data.viewAreaSizeY)
        -- printfmt("TransformedGround viewAreaIndex %d viewAreaX %d viewAreaY %d", viewAreaIndex, viewAreaX, viewAreaY)
        local viewAreaTransformed = bit.band(bit.rshift(v, 16), bitMask)
        for y = 1, data.viewAreaHeight do
            for x = 1, data.viewAreaWidth do
                local localTileIndex = (y - 1) * data.viewAreaWidth + x - 1
                local bitMask = createBitMask(localTileIndex, localTileIndex)
                local transformed = bit.rshift(bit.band(viewAreaTransformed, bitMask), localTileIndex)
                if transformed == 1 then
                    local tileX = viewAreaX * data.viewAreaWidth + x - 1
                    local tileY = viewAreaY * data.viewAreaHeight + y - 1
                    MapDataManager:getInstance():transformTileToReachableAtCoord(self._mapData, tileX, tileY)
                    -- printfmt("TransformedGround tile at %d,%d", tileX, tileY)
                end
            end
        end
    end
end

-- 获取地块的z坐标
function BattleModel:getMapTileCoordZ(coordX, coordY)
    local x, y, z = math.floor(coordX + 0.5), math.floor(coordY + 0.5), 0
    local mapTile = self._mapData.tileDataMap[y + 1][x + 1]
    if (mapTile) then
        if (mapTile.z) then 
            z = mapTile.z
        else
            --assert(false, string.format("[ERROR] BattleModel getMapTileCoordZ: coord z is invalid at (%f,%f).", x, y))
        end
    end
    return z
end

-- 获取地块数据
function BattleModel:getMapTileData(coordX, coordY)
    -- local x, y = math.floor(coordX + 0.5), math.floor(coordY + 0.5)
    -- local mapTile = self._mapData.tileDataMap[y + 1][x + 1]
    -- if (mapTile == nil) then
    --     print(string.format("BattleModel getMapTileData: map tile data is nil at (%f,%f).", x + 1, y + 1))
    -- end
    -- return mapTile
    return self._mapData:getTileDataAtCoord(coordX, coordY)
    -- return MapDataManager:getInstance():getTileDataAtCoord(self._mapData, coordX, coordY)
end

-- -- 获取角色周围可以挖的墙的坐标
-- function BattleModel:getDiggableWallCoordList(coordX, coordY, radius, targetType)
--     return self._mapData:getCoordinatesForDestructibleInVisionRadius(coordX, coordY, radius)
-- end

-- 寻路
function BattleModel:findMapPath(startCoordX, startCoordY, endCoordX, endCoordY)
    return MapDataManager:getInstance():findPath(self._mapData, startCoordX, startCoordY, endCoordX, endCoordY, true)
end

function BattleModel:getBoss()
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.ROLE and role:getType() == RoleType.Monster) then
            local roleData = role:getRoleData()
            if(roleData and roleData:isBigBoss()) then
                return role
            end
        end
    end

    return nil
end

function BattleModel:getBossAll()
    local roleList = {}
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.ROLE and role:getType() == RoleType.Monster) then
            local roleData = role:getRoleData()
            if(roleData and roleData:isBigBoss()) then
                table.insert(roleList,role)
            end
        end
    end

    return roleList
end

-- 获取点金台模型
function BattleModel:getGoldTouched()
    for _,role in pairs(self._roleMap) do
        if(role:getCategory() == Category.TRIGGER_NPC and role:getType() == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
            local gameData = role:getNpcData()
            if(gameData and gameData:hasFunction(PublicDefine.FUNCTION_TYPE.GOLD_TOUCH)) then
                return role
            end
        end
    end

    return nil
end

-- 判断是否在同一场战斗
function BattleModel:judgeInSameBattleField(spriteID, targetSpriteID)
    local battleFieldMap = self._battleFieldMap
    for key, battleField in pairs(battleFieldMap) do
        if battleField:judgeSameBattleField(spriteID, targetSpriteID) then
            return true
        end
    end

    return false
end

-- 获取战场模型
function BattleModel:getBattleFieldBySpriteID(spriteID, targetSpriteID)
    local choiceField = nil

    local battleFieldMap = self._battleFieldMap
    for key, battleField in pairs(battleFieldMap) do
        if battleField:judgeInBattleField(spriteID, targetSpriteID) then
            choiceField = battleField
            return choiceField
        end
    end
    return choiceField
end

-- 加入一个角色到战场
function BattleModel:addBattleFieldRole(role,otherSpriteID,isEnter, isSwitch)
    if role then
        local battleField = self:getBattleFieldBySpriteID(role:getSpriteID(),otherSpriteID)
        if not battleField then
            battleField = Model.BattleField:create(true)
            self._battleFieldMap[battleField:getId()] = battleField
        end
        battleField:addRole(role,otherSpriteID,isEnter, isSwitch)
    end
end

-- 从战场移除一个角色
function BattleModel:removeBattleFieldRole(role)
    if role then
        local battleField = self:getBattleFieldBySpriteID(role:getSpriteID(),nil)
        if battleField then
            battleField:removeRole(role)
            
            if battleField:canRecover() then
                self._battleFieldMap[battleField:getId()] = nil
                battleField:destroy()
            end
        end
    end
end 
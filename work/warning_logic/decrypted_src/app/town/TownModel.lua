--[[
    引擎系统：数据模型
]]--

local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameMapManager = require("app.game.GameMapManager")
require "utils.AvalonUtil"
require "bit"

Town = Town or {}

local TownModel = class("TownModel", Machine.ShareModel)
Town.TownModel = TownModel

-- public:
-- 构造函数
function TownModel:ctor()
    TownModel.super.ctor(self)
end

-- 销毁
function TownModel:destroy()
    TownModel.super.destroy(self)
end

-- 初始化
function TownModel:init()
    TownModel.super.init(self)
end

-- 清理
function TownModel:clear()
    TownModel.super.clear(self)
end

-- 创建地图
function TownModel:createMap(data)
    print("########TownModel:createMap")
    self._mapData = GameMapManager:getInstance():loadMapDataForState(data)
end
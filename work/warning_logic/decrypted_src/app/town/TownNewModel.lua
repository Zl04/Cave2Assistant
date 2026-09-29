--[[
    引擎系统：数据模型
]]--

local MapDefine = require "app.mapkit.MapDefine"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local GameMapManager = require("app.game.GameMapManager")
require "utils.AvalonUtil"
require "bit"

Town = Town or {}

local TownNewModel = class("TownNewModel", Machine.ShareModel)
Town.TownNewModel = TownNewModel

-- public:
-- 构造函数
function TownNewModel:ctor()
    TownNewModel.super.ctor(self)
end

-- 销毁
function TownNewModel:destroy()
    TownNewModel.super.destroy(self)
end

-- 初始化
function TownNewModel:init()
    TownNewModel.super.init(self)
end

-- 清理
function TownNewModel:clear()
    TownNewModel.super.clear(self)
end

-- 创建地图
function TownNewModel:createMap(dataConfig)
    print("########TownNewModel:createMap")
    -- self._mapData = dataConfig
end
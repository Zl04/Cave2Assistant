local lume = require "thirdparty.lume"

local _M = {}

_M.DefaultMapAppearance = 1					-- 地图的默认样貌ID，当策划没配置时，用此值
	
_M.visionRadius = 5							-- 角色的视距半径
_M.wallShrinkCheckRadius = 4				-- 墙体收起逻辑的检测半径

_M.LayerCount = 5							-- 地图的层级数量
_M.LayerIndexUnderGround = 1				-- 地面之下层
_M.LayerIndexGround = 2						-- 地面层 (地面在此层)
_M.LayerIndexNodeOnGround = 3				-- 地面上节点层
_M.LayerIndexNodeOnMap = 4					-- 地图节点层 (墙体与角色在此层)
_M.LayerIndexNodeBeyondMap = 5				-- 地图之上层

_M.ZAxisPixelsPerNormalizedUnit = 100		-- Z轴上每个单位所代表的像素量 （tile的coord.z = 2时，代表在Z轴方向上有像素偏移ZAxisPixelsPerNormalizedUnit * 2）
_M.TileZAxisOffsetMax = 10					-- 地图每格在Z轴（实际cocos中的y轴）上的最大像素偏移量

_M.ZOrderMaxOffsetPerCoordinate = 10000		-- 每个单元格中可以表示的zOrder最大偏差

-- vision color level from 1 - 6, 0 means original tile color
_M.OriginalTileColorLevel = 0
_M.FarestTileColorLevel = 6

_M.AdjacentOffsets = {{x = 0, y = 1}, {x = 1, y = 0}, {x = 0, y =  -1}, {x = -1, y = 0}}
_M.CornerOffsets = {{x = 1, y = 1}, {x = 1, y = -1}, {x = -1, y = -1}, {x = -1, y = 1}}
_M.AroundOffsets = lume.concat(_M.AdjacentOffsets, _M.CornerOffsets)

_M.ElementRemoveDuration = 0.2

local DecorationAnimName = {
	Idle = "idle",
	Activate = "activate",
	Activated = "activated",
	ShakeDead = "shake_dead",
	IdleDead = "idle_dead",
}
_M.DecorationAnimName = DecorationAnimName

local BoundingPoint = {
	BottomLeft = "BottomLeft",
	BottomRight = "BottomRight",
	TopLeft = "TopLeft",
	TopRight = "TopRight",
	Center = "Center",
	Left = "Left",
	Right = "Right",
}
_M.BoundingPoint = BoundingPoint

local DirectionType = {
	None = -1,
	North = 0,
	East = 1,
	South = 2,
	West = 3
}
_M.DirectionType = DirectionType

_M.ElementBaseDirection = DirectionType.West

local TerrainType = {
	None = -1,
	Ground = 0,
	Wall = 1,
}
_M.TerrainType = TerrainType

local TerrainTypeStringMapping = {
	[TerrainType.None] = "None",
	[TerrainType.Ground] = "Ground",
	[TerrainType.Wall] = "Wall",
}
_M.TerrainTypeStringMapping = TerrainTypeStringMapping

function _M:getTerrainType()ForString(string)
	for type, typeStr in pairs(TerrainTypeStringMapping) do
		if string == typeStr then
			return type
		end
	end
	return TerrainType.None
end

function _M.decorationTypeForString(string)
	for type, typeStr in pairs(DecorationTypeStringMapping) do
		if string == typeStr then
			return type
		end
	end
	return DecorationType.None
end

local ObjectType = {
	None 		= 0,
	Hero 		= 10,
	Monster		= 11,
	Box 		= 12,
	Trap 		= 13,
	NPC 		= 14,	
	GoldBag 	= 15,

	FuncItem 	= 20,
	Equipment 	= 21,
	Material 	= 22,
}
_M.ObjectType = ObjectType

local ObjectTypeStringMapping = {
	[ObjectType.None] = "none",
	[ObjectType.Hero] = "hero",
	[ObjectType.Monster] = "monster",
	[ObjectType.Box] = "box",
	[ObjectType.Trap] = "trap",
	[ObjectType.NPC] = "NPC",
	[ObjectType.GoldBag] = "goldBag",

	[ObjectType.FuncItem] = "funcItem",
	[ObjectType.Equipment] = "equipment",
	[ObjectType.Material] = "material",
}
_M.ObjectTypeStringMapping = ObjectTypeStrngMapping

function _M.objectTypeForString(string)
	for type, typeStr in pairs(ObjectTypeStringMapping) do
		if string == typeStr then
			return type
		end
	end
	return ObjectType.None
end

function _M.objectTypeForID(ID)
	if ID >= 10100000 and ID < 10200000 then 
		return ObjectType.Monster
	elseif ID >= 10200000 and ID < 10300000 then
		return ObjectType.Box
	elseif ID >= 10300000 and ID < 10400000 then
		return ObjectType.Trap
	elseif ID >= 10400000 and ID < 10500000 then
		return ObjectType.NPC
	elseif ID >= 10400000 and ID < 10500000 then
		return ObjectType.GoldBag
	elseif ID >= 20000000 and ID < 21000000 then
		return ObjectType.FuncItem
	elseif ID >= 21000000 and ID < 22000000 then
		return ObjectType.Equipment
	elseif ID >= 22000000 and ID < 23000000 then
		return ObjectType.Material
	else 
		return ObjectType.None
	end
end

return _M
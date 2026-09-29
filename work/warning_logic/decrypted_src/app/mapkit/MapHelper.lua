local lume = require "thirdparty.lume"
local MapDefine = require "app.mapkit.MapDefine"

local _M = {}

-- -- 坐标显示
-- _M.showDebugCoordinates = false;
-- -- 显示ZOrders
-- _M.showDebugZOrders = false;		
-- -- 显示包围盒
-- _M.showDebugBoundingBox = false;	
_M.CAMERA_MOVE_CURVE = 4
-- by CMonk, 开发模式下用UserDefault暴露一个坐标开关
-- Win32上写入时Key不写死会出UserDefault文件崩坏的Bug, 故和上面写入行成对写死
_M.showDebugCoordinates = cc.UserDefault:getInstance():getBoolForKey(
	UserDefaultKeyWord.GMUtilShowCord, false);

_M.showDebugBoundingBox = cc.UserDefault:getInstance():getBoolForKey(
	UserDefaultKeyWord.GMUtilShowCord, false);

-- eo CMonk

if (CAVEOL_TARGET ~= CAVEOL_TARGET_DEVELOPMENT) then
	-- 坐标显示
	_M.showDebugCoordinates = false;	
	-- 显示ZOrders
	_M.showDebugZOrders = false;		
	-- 显示包围盒
	_M.showDebugBoundingBox = false;	
end

function _M.isColor(color)
    return type(color) == "table" and type(color.r) == "number" and type(color.g) == "number" and type(color.b) == "number"
end

function _M.printColor(color)
	print (("r:%f,g:%f,b:%f,a:%f"):format(color.r, color.g, color.b, color.a or 255))
end

function _M.c4b_to_c4f(c4b)	
	return {r = c4b.r / 255.0, g = c4b.g / 255.0, b = c4b.b / 255.0, a = c4b.a / 255.0}
end

function _M.c4f_to_c4b(c4f)	
	return {r = c4f.r * 255.0, g = c4f.g * 255.0, b = c4f.b * 255.0, a = c4f.a * 255.0}
end

function _M.c4b_to_vec4(c4b)
	local c4f = _M.c4b_to_c4f(c4b)
	return {x = c4f.r, y = c4f.g, z = c4f.b, w = c4f.a}
end

function _M.c4f_to_vec4(c4f)
	return {x = c4f.r, y = c4f.g, z = c4f.b, w = c4f.a}
end

function _M.c4f_to_string(c4f)
	return ("%.02f,%.02f,%.02f,%.02f"):format(c4f.r, c4f.g, c4f.b, c4f.a)
end

function _M.c4b_to_string(c4b)
	-- local a = c4b.a == nil and 255 or a
	return ("R%dG%dB%dA%d"):format(c4b.r, c4b.g, c4b.b, c4b.a)
end

function _M.c4b_equals(c4b1, c4b2)
	return c4b1.r == c4b2.r and c4b1.g == c4b2.g and c4b1.b == c4b2.b and c4b1.a == c4b2.a
end

function _M.getCoordOffsetsForRadius(radiationRadius)
	local radiationOffsets = {}
	local w, h = radiationRadius * 2 - 1, radiationRadius * 2 - 1
	local hr, vr = math.floor((w - 1) / 2), math.floor((h - 1) / 2)
	for y = -vr, vr do
		for x = -hr, hr do
			lume.push(radiationOffsets, {x = x, y = y})
		end
	end
	return radiationOffsets 
end

function _M.getOpacityForRadiationLevel(level, radius)
	local maxOpacity = 255
	local decreasePerLevel = 1.0 / radius
    if level == 0 then
        return maxOpacity * 0.98
    else 
        return maxOpacity * (1.0 - level * decreasePerLevel)
    end
end

function _M.getCenterPositionOfBoundingBox(cx, cy, cz, width, height, tileWidth, tileHeight, ZNormalizedHeight)
	local tileWidthHalf, tileHeightHalf = tileWidth * 0.5, tileHeight * 0.5
	local x, y, z = _M.coordinateToPosition(cx, cy, cz, tileWidth, tileHeight, ZNormalizedHeight)
    x = x - tileWidthHalf * height + (width + height) * tileWidthHalf * 0.5
    y = y + (width + height) * tileHeightHalf * 0.5    
    return x, y, z
end

function _M.positionToCoordinate(x, y, z, tileWidth, tileHeight, ZNormalizedHeight)
	local tileWidthHalf, tileHeightHalf = tileWidth * 0.5, tileHeight * 0.5
	local coordX = math.floor((x / tileWidthHalf + y / tileHeightHalf) / 2)
	local coordY = math.floor((y / tileHeightHalf - (x / tileWidthHalf)) / 2)
	local coordZ = z / ZNormalizedHeight
	return coordX, coordY, coordZ
end

function _M.coordinateToPosition(coordX, coordY, coordZ, tileWidth, tileHeight, ZNormalizedHeight)
	local x = (coordX - coordY) * tileWidth * 0.5
	local y = (coordX + coordY) * tileHeight * 0.5
	local z = coordZ * ZNormalizedHeight 
    return x, y, z
end

function _M.coordinateSizeToContentSize(sizeX, sizeY, tileWidth, tileHeight)
	local contentWidth = (sizeX + sizeY) * tileWidth * 0.5
	local contentHeight = (sizeX + sizeY) * tileHeight * 0.5
	return contentWidth, contentHeight
end

function _M.boundsContainPoint(bounds, point)
	return point.x >= bounds.x and point.x <= bounds.x + bounds.width - 1
		and point.y >= bounds.y and point.y <= bounds.y + bounds.height - 1
end


function _M.calculateZOrder(boundingPoint, x, y, width, height, zOffset, mapSizeX, mapSizeY)
    local zOrder = 0
    if width > 0 or height > 0 then
        if boundingPoint == MapDefine.BoundingPoint.BottomLeft  then
            zOrder = (mapSizeX + mapSizeY - x - y) * MapDefine.ZOrderMaxOffsetPerCoordinate + zOffset
        elseif boundingPoint == MapDefine.BoundingPoint.BottomRight or boundingPoint == MapDefine.BoundingPoint.Right then
            zOrder = (mapSizeX + mapSizeY - x - width + 1 - y) * MapDefine.ZOrderMaxOffsetPerCoordinate + zOffset
        elseif boundingPoint == MapDefine.BoundingPoint.TopLeft or boundingPoint == MapDefine.BoundingPoint.Left then
            zOrder = (mapSizeX + mapSizeY - x - y - height + 1) * MapDefine.ZOrderMaxOffsetPerCoordinate + zOffset
        elseif boundingPoint == MapDefine.BoundingPoint.TopRight  then
            zOrder = (mapSizeX + mapSizeY - x - width + 1 - y - height + 1) * MapDefine.ZOrderMaxOffsetPerCoordinate + zOffset
        elseif boundingPoint == MapDefine.BoundingPoint.Center then
            zOrder = (mapSizeX + mapSizeY - x - width / 2 - y - height / 2) * MapDefine.ZOrderMaxOffsetPerCoordinate + zOffset
        end
    end
    return zOrder
end

function _M.getMapTerrainTextureName(mapName, terrainName, category)
	local texName = ("%s_%s_%02d.png"):format(mapName, terrainName, category)
	return texName
end

function _M.getMapTerrainTexutreName(mapTerrainTextureName, color)
	return mapTerrainTextureName .. "_" .. _M.c4b_to_string(color)
end

function _M.getMapTileTerrainColoredTextureName(textureName, category, color, isUseSplit, terrainType)
	if category == nil or type(category) ~= "number" then 
		return string.format("%s_01.png", textureName)
	elseif isUseSplit then
		if color == nil or type(color) ~= "table" then
			if terrainType == 1 then
				return string.format("%s_%02d_split.png", textureName, category)
			else
				return string.format("%s_floor_split.png", textureName)
			end
			
		else
			if terrainType == 1 then
				return string.format("%s_%02d_split.png_%s", textureName, category, _M.c4b_to_string(color))
			else
				return string.format("%s_floor_split.png_%s", textureName, _M.c4b_to_string(color))
			end
			
		end
	else --if category ~= nil and type(category) == "number"
		if color == nil or type(color) ~= "table" then
			return string.format("%s_%02d.png", textureName, category)
		else
			return string.format("%s_%02d.png_%s", textureName, category, _M.c4b_to_string(color))
		end
	end
end
    
function _M.createSprite(fileName)
	local sprite = cc.Sprite:create()
	
	if not sprite:initWithFile(fileName) then
		local spriteFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame(fileName)
		if spriteFrame ~= nil then
			sprite:initWithSpriteFrame(spriteFrame)
		else
			printfmt("create sprite but sprite frame %s missed", fileName)
		end
	end
	
	return sprite
end

function _M.stringArrayEqual(sa1, sa2)
	local c1 = #sa1
	local c2 = #sa2 
	if c1 ~= c2 then
		return false
	end

	for i = 1, c1 do
		local str1 = sa1[i]
		local str2 = sa2[i]
		if str1 ~= str2 then
			return false
		end
	end
	return true
end

local schedulerKeyIDMap = {}
function _M.callFuncInDelay(func, delay, key)
    -- start a schudule to check save status of texture 
    local elapsed = 0
    if func and type(func) == "function" then
        schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function (dt)
            elapsed = elapsed + dt
            print(("scheduler %d elapsed %f"):format(schedulerID, elapsed))
            if elapsed >= delay then
            	func()
            	sID = schedulerKeyIDMap[key]
                cc.Director:getInstance():getScheduler():unscheduleScriptEntry(sID)
            end 
        end, 0.01, false)
       	schedulerKeyIDMap[key] = schedulerID
    end
end

function _M.getVisionRangeOffsets(visionRadius) 
	local offsets = {}
	for y = -visionRadius, visionRadius do
		local rowWidth = (visionRadius - math.abs(y)) * 2 + 1
		for x = math.floor(rowWidth / 2) * -1, math.floor(rowWidth / 2) do
			lume.push(offsets, {x = x, y = y})
		end
	end
	return offsets
end

function _M.getVisionRangeCoordinates(centerCoord, visonRadius)
	local coords = {}
	local offsets = _M.getVisionRangeOffsets(visionRadius)
	for offset in ipairs(offsets) do
		lume.push(coords, {x = centerCoord.x + offset.x, y = centerCoord.y + offset.y})
	end
	return coords
end

function _M.parseNumberGroupsString(numberGroupsStr)
	local numberGroups = {}
	local numberGroupStrs = numberGroupsStr:split(";")
	for _, numberGroupStr in ipairs(numberGroupStrs) do 
		if #numberGroupStrs > 0 then
			local numberStrs = numberGroupStr:split(",")
			local numberGroup = {}
			for _, numberStr in ipairs(numberStrs) do 
				lume.push(numberGroup, tonumber(numberStr))
			end
			if lume.count(numberGroup) > 0 then
				lume.push(numberGroups, numberGroup)
			end
		end
	end
	return numberGroups
end

return _M

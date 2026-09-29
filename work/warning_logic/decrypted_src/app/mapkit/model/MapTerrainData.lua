local MapTerrainData = class("MapTerrainData")
local MapDefine = require "app.mapkit.MapDefine"

function MapTerrainData:ctor(terrainType, terrainNames, category, colors)
	self.terrainType = terrainType
	self.terrainNames = terrainNames
	self.category = category
	self.colors = colors
	self.flippedX = false
end

function MapTerrainData:getSectionCategory(sectionIndex)
	if self.terrainType == MapDefine.TerrainType.Ground then
		return self.category
	else
		-- only the topest section of terrain Wall can have more categories
		if sectionIndex < 3 then
			return 1
		else 
			return self.category
		end
	end
end

function MapTerrainData:setTerrainType(terrainType)
	self.terrainType = terrainType
end

function MapTerrainData:getTerrainType()
	return self.terrainType
end

function MapTerrainData:setTerrainNames(terrainNames)
	self.terrainNames = terrainNames
end

function MapTerrainData:getTerrainNames()
	return self.terrainNames
end

function MapTerrainData:setCategory(category)
	self.category = category
end

function MapTerrainData:getCategory()
	return self.category
end

function MapTerrainData:setColors(colors)
	self.colors = colors
end

function MapTerrainData:getColors()
	return self.colors
end

function MapTerrainData:setFlippedX(flippedX)
	self.flippedX = flippedX
end

function MapTerrainData:getFilippedX()
	return self.flippedX
end

return MapTerrainData
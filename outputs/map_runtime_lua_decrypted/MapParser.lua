local gridsModule = require "app.mapkit.grids"
local printGrids = gridsModule.print

local _M = {}

--[[ 
 Random tiled resources mapping way

 ## NAME
 
 |---|---|---|
 | 4 | A | 1 |
 | D |   | B |
 | 3 | C | 2 |
 
 ## DIRECTION
 
 |---|---|---|
 | NW| N | NE|
 | W |   | E |
 | SW| S | SE|
 
 ## VALUE
 
 |:-:|:-:|:-:|
 | 8 | 16| 1 |
 |128|   | 32|
 | 4 | 64| 2 |
 
 ## BITMASK
 
 One map tile model can be present as a 8 bit integer
 
 0   |0   |0   |0   |0   |0   |0   |0
 ----|----|----|----|----|----|----|----
 W   |S   |E   |N   |NW  |SW  |SE  |NE
 
 Let's say we have a map tile like below, 0 stands for ground, 1 stands for obstacle

 | 1 | 0 | 0 |
 | 1 |   | 0 |
 | 1 | 1 | 1 |
 
 This tile should have a model value present as
 
 1   |1   |0   |0   |1   |1   |1   |0   |
 ----|----|----|----|----|----|----|----|
 W   |S   |E   |N   |NW  |SW  |SE  |NE  |
 
 = 0b11001110 = 206

 Actually, we just use integer for storage convenience. while evalute the model value, we should use the value of adjacent and oblique adjacent separately
 The tile above, have adjacent value as 12 and oblique adjacent value as 14,
 which make it has a Number as 26. should name the mapping resource with this Number
 
]]--

--[[
 
]]--

_M.mapType = "noCorner" -- noCorner or withCorner
_M.originType = "lb" -- lt or lb
_M.buildType = "inAir" -- inAir or onGround

local function printGrids(grids, width, height)
	for y = height, 1, -1 do
		for x = 1, width do
			io.write(string.format("%02d ", grids[y][x]))
		end
		io.write("\n")
	end
end

local function isUnused(grids, x, y, width, height)
	if x >= 1 and y >= 1 and x <= width and y <= height then
        return grids[y][x] == -1;
    else 
    	return true
	end
end

local function isObstacle(grids, x, y, width, height)
	if x >= 1 and y >= 1 and x <= width and y <= height then
        return grids[y][x] == 1;
    else 
    	return false
	end
end

local function isGround(grids, x, y, width, height)
	if x >= 1 and y >= 1 and x <= width and y <= height then
        return grids[y][x] == 0;
    else 
    	return false
	end
end

local function getTerrainNo(adjacentV, cornerV, adjacentUnusedV)
	if adjacentV == 0 then
	    return 0
	elseif adjacentV == 1 then
	    return 1
	elseif adjacentV == 2 then
	    return 2
	elseif adjacentV == 3 then
	    if cornerV == 1 then
	        return 17
	    elseif cornerV == 2 or cornerV == 4 or cornerV == 6 or cornerV == 8 or cornerV == 10 or cornerV == 12 or cornerV == 14 then
	        return 16
	    elseif cornerV == 0 then
	    	if adjacentUnusedV == 12 then
	    		return 16
	    	else 
	    		return 3
	    	end
	    else
	    	return 3
	    end
	elseif adjacentV == 4 then
	    return 4
	elseif adjacentV == 5 then
	    if cornerV == 1 or cornerV == 2 or cornerV == 3 then
	        return 19
	    elseif cornerV == 4 or cornerV == 8 or cornerV == 12 then
	        return 18
        elseif cornerV == 0 then
            if adjacentUnusedV == 8 then 
            	return 18
            elseif adjacentUnusedV == 2 then
            	return 19
            else 
            	return 5
            end
	    else
	        return 5
	    end
	elseif adjacentV == 6 then
	    if cornerV == 2 then
	        return 21
	    elseif cornerV == 1 or cornerV == 4 or cornerV == 5 or cornerV == 8 or cornerV == 9 or cornerV == 12 or cornerV == 13 then
	        return 20
	    elseif cornerV == 0 then
	    	if adjacentUnusedV == 9 then
	    		return 20
	    	else 
	    		return 6
	    	end
	    else
	        return 6
	    end
	elseif adjacentV == 7 then
	    if cornerV == 2 then
	        return 22
	    elseif cornerV == 1 then
	        return 23
	    elseif cornerV == 4 or cornerV == 8 or cornerV == 12 then
	        return 24
	    elseif cornerV == 0 then
	    	if adjacentUnusedV == 8 then
	    		return 24
	    	else 
	    		return 7
	    	end
	    else
	        return 7
	    end
	elseif adjacentV == 8 then
	    return 8
	elseif adjacentV == 9 then
	    if cornerV == 8 then
	        return 26
	    elseif cornerV >= 1 and cornerV <= 7 then
	        return 25
	    elseif cornerV == 0 then
	    	if adjacentUnusedV == 6 then
	    		return 25
	    	else 
	    		return 9
	    	end
	    else
	        return 9
	    end
	elseif adjacentV == 10 then
	    if cornerV == 1 or cornerV == 8 or cornerV == 9 then
	        return 28
	    elseif cornerV == 2 or cornerV == 4 or cornerV == 6 then
	        return 27
	    elseif cornerV == 0 then
            if adjacentUnusedV == 1 then
            	return 28
            elseif adjacentUnusedV == 4 then
            	return 27
            else
            	return 10
            end
	    else
	        return 10
	    end
	elseif adjacentV == 11 then
	    if cornerV == 8 then
	        return 29
	    elseif cornerV == 1 then
	        return 30
	    elseif cornerV == 2 or cornerV == 4 or cornerV == 6 then
	        return 31
	    elseif cornerV == 0 then
	    	if adjacentUnusedV == 4 then
	    		return 31
	    	else 
	    		return 11
	    	end
	    else
	        return 11
	    end
	elseif adjacentV == 12 then
	    if cornerV == 4 then
	        return 33
	    elseif cornerV == 1 or cornerV == 2 or cornerV == 3 or cornerV == 8 or cornerV == 9 or cornerV == 10 or cornerV == 11 then
	        return 32
	    elseif cornerV == 0 then
	    	if adjacentUnusedV == 3 then
	    		return 32
	    	else 
	    		return 12
	    	end
	    else
	        return 12
	    end
	elseif adjacentV == 13 then
	    if cornerV == 8 then
	        return 34
	    elseif cornerV == 4 then
	        return 35
	    elseif cornerV == 1 or cornerV == 2 or cornerV == 3 then
	        return 36
	    elseif cornerV == 0 then
	    	if adjacentUnusedV == 2 then
	    		return 36
	    	else
	    		return 13
	    	end
	    else
	        return 13
	    end
	elseif adjacentV == 14 then
	    if cornerV == 4 then
	        return 37
	    elseif cornerV == 2 then
	        return 38
	    elseif cornerV == 1 or cornerV == 8 or cornerV == 9 then
	        return 39
	    elseif cornerV == 0 then
	    	if adjacentUnusedV == 1 then
	    		return 39
	    	else 
	    		return 14
	    	end
	    else
	        return 14
	    end
	elseif adjacentV == 15 then
	    if cornerV == 7 then
	        return 40
	    elseif cornerV == 11 then
	        return 41
	    elseif cornerV == 13 then
	        return 42
	    elseif cornerV == 14 then
	        return 43
	    elseif cornerV == 5 then
	        return 44
	    elseif cornerV == 10 then
	        return 45
	    else
	        return 15
	    end
	else 
		return -1
	end
end

function _M.parse(grids, width, height, mapType, originType, buildType)
	_M.mapType = mapType and mapType or _M.mapType
	_M.originT = originType and originType or _M.originType
	_M.buildT = buildType and buildType or _M.buildType 

	local parsed = {}
	for y = 1, height do
		parsed[y] = {}
	end 

	local adjacentValues = {}
	for y = 1, height do
		adjacentValues[y] = {}
		for x = 1, width do
			adjacentValues[y][x] = -1
		end
	end

	local cornerValues = {}
	for y = 1, height do
		cornerValues[y] = {}
		for x = 1, width do
			cornerValues[y][x] = -1
		end
	end

	local adjacentUnusedValues = {}
	for y = 1, height do
		adjacentUnusedValues[y] = {}
		for x = 1, width do
			adjacentUnusedValues[y][x] = -1
		end
	end

	-- for y = 1, height do
	-- 	for x = 1, width do
	-- 		io.write(string.format("%02d ", grids[x][y]))
	-- 	end
	-- 	io.write("\n")
	-- end

	for y = 1, height do	
		for x = 1, width do
			local v = grids[y][x]
			local terrainNo = v
			if v == 0 then
				if _M.mapType == "noCorner" then
					terrainNo = 16
				else
					terrainNo = 46
				end
			elseif v == 1 then
				local adjacentV = 0
				local cornerV = 0
				local adjacentUnusedV = 0
				
				if isObstacle(grids, x, y - 1, width, height) then
					if _M.originT == "lt" then
						-- north
						adjacentV = adjacentV + 1
					else 
						-- sourth
						adjacentV = adjacentV + 4
					end
				end
				-- east
				if isObstacle(grids, x + 1, y, width, height) then
					adjacentV = adjacentV + 2
				end
				
				if isObstacle(grids, x, y + 1, width, height) then
					if _M.originT == "lt" then
						-- south
						adjacentV = adjacentV + 4
					else
						-- north
						adjacentV = adjacentV + 1
					end
				end
				-- west
				if isObstacle(grids, x - 1, y, width, height) then
					adjacentV = adjacentV + 8
				end
				
				if _M.buildT == "inAir" then
					-- collect the adjacent unused values to determine how the wall look like, eg wall with left unused should look not the same to wall with right unused
					if isUnused(grids, x, y - 1, width, height) then
						if _M.originT == "lt" then
							-- north
							adjacentUnusedV = adjacentUnusedV + 1
						else 
							-- sourth
							adjacentUnusedV = adjacentUnusedV + 4
						end
					end
					-- east
					if isUnused(grids, x + 1, y, width, height) then
						adjacentUnusedV = adjacentUnusedV + 2
					end
					
					if isUnused(grids, x, y + 1, width, height) then
						if _M.originT == "lt" then
							-- south
							adjacentUnusedV = adjacentUnusedV + 4
						else
							-- north
							adjacentUnusedV = adjacentUnusedV + 1
						end
					end
					-- west
					if isUnused(grids, x - 1, y, width, height) then
						adjacentUnusedV = adjacentUnusedV + 8
					end

					if isUnused(grids, x + 1, y - 1, width, height) then
						if _M.originT == "lt" then
							-- ne
							cornerV = cornerV + 1
						else 
							-- se
							cornerV = cornerV + 2
						end
					end
					if isUnused(grids, x + 1, y + 1, width, height) then
						if _M.originT == "lt" then
							-- se
							cornerV = cornerV + 2
						else 
							-- ne
							cornerV = cornerV + 1
						end
					end
					if isUnused(grids, x - 1, y + 1, width, height) then
						if _M.originT == "lt" then
							-- sw
							cornerV = cornerV + 4
						else 
							-- nw
							cornerV = cornerV + 8
						end
					end
					if isUnused(grids, x - 1, y - 1, width, height) then
						if _M.originT == "lt" then
							-- nw
							cornerV = cornerV + 8
						else 
							-- sw
							cornerV = cornerV + 4
						end
					end
				else
					if not isUnused(grids, x + 1, y - 1, width, height) then
						if _M.originT == "lt" then
							-- ne
							cornerV = cornerV + 1
						else 
							-- se
							cornerV = cornerV + 2
						end
						
					end
					if not isUnused(grids, x + 1, y + 1, width, height) then
						if _M.originT == "lt" then
							-- se
							cornerV = cornerV + 2
						else 
							-- ne
							cornerV = cornerV + 1
						end
					end
					if not isUnused(grids, x - 1, y + 1, width, height) then
						if _M.originT == "lt" then
							-- sw
							cornerV = cornerV + 4
						else 
							-- nw
							cornerV = cornerV + 8
						end
					end
					if not isUnused(grids, x - 1, y - 1, width, height) then
						if _M.originT == "lt" then
							-- nw
							cornerV = cornerV + 8
						else 
							-- sw
							cornerV = cornerV + 4
						end
					end
				end
				
				if _M.mapType == "noCorner" then
					terrainNo = adjacentV
				else 
					terrainNo = getTerrainNo(adjacentV, cornerV, adjacentUnusedV)
				end

				adjacentValues[y][x] = adjacentV
				cornerValues[y][x] = cornerV
				adjacentUnusedValues[y][x] = adjacentUnusedV
			end
			parsed[y][x] = terrainNo
		end
	end

	print("Adjacent Values:")
	printGrids(adjacentValues, width, height)
	print("Corner Values:")
	printGrids(cornerValues, width, height)
	print("Adjacent Unused Values:")
	printGrids(adjacentUnusedValues, width, height)
	return parsed
end

function _M.parseWarShadow(grids, width, height)
end

return _M
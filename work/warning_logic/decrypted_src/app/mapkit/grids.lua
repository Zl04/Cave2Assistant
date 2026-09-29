local lume = require "thirdparty.lume"

local _M = {}

-- function _M.getIndex(x, y, width)
-- 	return y * width + x
-- end

local l_shapes = {
	[-1] = "=",
	[0] = ".",
	[1] = "#"
}

local l_insets = {
	left = 0,
	top = 0,
	right = 0,
	bottom = 0,
}

local l_defaultValue = -1

-- local function numberToString(num, limitBits)
-- 	local numBits = 1
-- 	while num % 10 ~= 0 do
-- 		numBits = numBits + 1
-- 	end
-- 	local outStr = ""
-- 	for i = 1, numBits - 1 do
-- 		outStr = outStr .. " "
-- 	end
-- 	outStr = outStr + tostring(num)
-- 	return outStr
-- end

function _M.print(grids, width, height, withShape)
	local w = width or grids.width or #grids[1]
	local h = height or grids.height or #grids
	local shape = withShape or false
	assert(w > 0, "grids mush have width")
	assert(w > 0, "grids mush have height")
	for y = h, 1, -1 do
		for x = 1, w do
			if grids[y] == nil then
				io.write("m")
			else
				local v = grids[y][x]
				if v ~= nil then
					if shape then
						local s = l_shapes[v]
						io.write(s)
					else 
						io.write(v)
					end
				else
					io.write("n")
				end
			end
		end
		io.write("\n")
	end
end

function _M.make(width, height, default)
	assert(width > 0 and height > 0, "grids mush have width and height")
	local d = default or l_defaultValue

	local grids = {}
	for y = 1, height do
		grids[y] = {}
		for x = 1, width do 
			grids[y][x] = d
		end
	end
	return grids
end

function _M.isInBounds(x, y, width, height, innerInsets)
	local ii = {}
	if innerInsets ~= nil then 
		if type(innerInsets) == "table" then
			ii.left = innerInsets.left
			ii.right = innerInsets.right
			ii.top = innerInsets.top
			ii.bottom = innerInsets.bottom
		elseif type(innerInsets) == "number" then
 			ii.left = innerInsets
			ii.right = innerInsets
			ii.top = innerInsets
			ii.bottom = innerInsets
		end
	else 
		ii = l_insets
	end

	local ret = (x >= 1 + ii.left and x <= width - ii.right and
			y >= 1 + ii.bottom and y <= height - ii.top)
	-- if not ret then
	-- 	print(string.format("[grids] coordinate %d,%d is not in bounds {%d,%d,%d,%d}", x, y, 1 + ii.left, height - ii.top, width - ii.right, 1 + ii.bottom))
	-- end 
	return ret;
end

function _M.get(grids, x, y, width, height, default)
	local d = default or l_defaultValue
	local w = grids.width or width
	local h = grids.height or height
	if _M.isInBounds(x, y, w, h) then
		local v = grids[y][x]
		if v == nil then
			return d
		else 
			return v
		end
	end
	return d
end

function _M.set(grids, x, y, width, height, value)
	if _M.isInBounds(x, y, width, height) then
		grids[y][x] = value
		return true
	end
	return false
end

function _M.assign(g1, g2)
	for y = 1, #g2 do
		g1[y] = {}
		for x = 1, #g2[y] do
			g1[y][x] = g2[y][x]
		end
	end
end

function _M.copy(grids)
	local outGrids = {}
	for y = 1, #grids do
		outGrids[y] = {}
		for x = 1, #grids[y] do
			outGrids[y][x] = grids[y][x]
		end
	end
	return outGrids
end

function _M.swap(g1, g2)
	local temp = {}
	_M.assign(temp, g1)
	_M.assign(g1, g2)
	_M.assign(g2, temp)
end 

function _M.flipByX(grids)
	local outGrids = {}
	for y = 1, #grids do
		outGrids[y] = {}
		local height = #grids[y]
		for x = 1, height do
			outGrids[height - y + 1][x] = grids[y][x]
		end
	end
	return outGrids
end

return _M
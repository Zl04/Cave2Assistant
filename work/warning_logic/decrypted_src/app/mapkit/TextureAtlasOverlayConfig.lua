local lume = require "thirdparty.lume"

local function isColor(color)
    return type(color) == "table" and type(color.r) == "number" and type(color.g) == "number" and type(color.b) == "number"
end

local function isColorString(color)
	return type(color) == "string" and string.find(color, "r", 1, true) ~= nil and string.find(color, "g", 1, true) and string.find(color, "b", 1, true)
end

local function isColorArray(colorArray)
	assert(lume.isarray(colorArray))
	for _, color in ipairs(colorArray) do 
		if not isColor(color) and not isColorString(color) then 
			return false
		end
	end
	return true
end

local function parseColor3BString(colorStr)
	assert(type(colorStr) == "string")
	local color = {}
	local len = #colorStr
	local s = 1
	local sublen = 0
	for i = 1, len do
		local c = colorStr[i]
		if c == "g" or c == "b" or i == len then 
			sublen = i == len and i - s + 1 or i - s
			local v = tonumber(string.sub(colorStr, s, sublen))
			if c == "g" then 
				color["r"] = v
			elseif c == "b" then 
				color["g"] = v
			elseif i == len then 
				color["b"] = v
			end
			s = i
		end
	end
	return color
end

local function removeExt(fileName)
	local name = fileName:match("([^/]+)$")
	return name:sub(1, name:find("%.") - 1)
end

local TextureAtlasOverlayConfig = {}
TextureAtlasOverlayConfig.__index = TextureAtlasOverlayConfig

function TextureAtlasOverlayConfig:new(atlasPlist, atlasSaveName, completeCallback)
	assert(atlasPlist ~= nil and #atlasPlist > 0)
	assert(type(atlasSaveName) == "string")
	assert(completeCallback == nil or type(completeCallback) == "function")
	local newTextureAtlasOverlayConfig = {}
	setmetatable(newTextureAtlasOverlayConfig, TextureAtlasOverlayConfig)
	newTextureAtlasOverlayConfig:init(atlasPlist, atlasSaveName, completeCallback)
	return newTextureAtlasOverlayConfig
end

function TextureAtlasOverlayConfig:init(atlasPlist, atlasSaveName, completeCallback)
	self.atlasPlist = atlasPlist
	self.atlasSaveName = atlasSaveName
	self.completeCallback = completeCallback
	local spriteFrameInfos = cc.FileUtils:getInstance():getValueMapFromFile(atlasPlist)["frames"]
	if spriteFrameInfos == nil then 
		printError(string.format("overlaying texture atlas %s is not exist", atlasPlist))
	end
	self.spriteFrameInfos = spriteFrameInfos
	-- printfmt(string.format("spriteFrameInfos %s : %s", atlasPlist, tostring(spriteFrameInfos)))
	self.configEntries = {}
end

function TextureAtlasOverlayConfig:addEntry(spriteFrameName, colorArray)
	assert(self.spriteFrameInfos[spriteFrameName] ~= nil, string.format("add overlay config error, sprite frame %s is not in texture atlas %s", spriteFrameName, self.atlasPlist))
	if self.spriteFrameInfos[spriteFrameName] == nil then
		return
	end

	assert(isColorArray(colorArray))	
	lume.push(self.configEntries, {spriteFrameName = spriteFrameName, colorArray = colorArray})
end

function TextureAtlasOverlayConfig:getConfigEntries() 
	return self.configEntries
end

return TextureAtlasOverlayConfig
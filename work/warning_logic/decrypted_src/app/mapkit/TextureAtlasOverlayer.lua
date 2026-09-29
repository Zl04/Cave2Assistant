local _M = {}
local MapHelper = require "app.mapkit.MapHelper"
local lume = require "thirdparty.lume"
local persistence = require "thirdparty.persistence"
local TextureAtlasOverlayConfig = require "app.mapkit.TextureAtlasOverlayConfig"
require "utils.FileManager"

local PageMaxWidth, PageMaxHeight = 2048, 2048
-- local PageMaxWidth, PageMaxHeight = 2048 * 1.5, 2048 * 1.5
local CheckSaveSechedulerIDMap = {}
local FramePageInfosCache = {}

local Gaps = {
	Horizontal = 1,
	Vertical = 1,
}

local Margins = {
	Left = 1,
	Top = 1,
	Right = 1,
	Bottom = 1,
}

local SpriteFrameCache = cc.SpriteFrameCache:getInstance() 

local function isValidConfig(config)
	return type(config) == 'table' and getmetatable(config) == TextureAtlasOverlayConfig
end

local MapRelativePath = "map/"

local function createMapWritablePath()
	local path = Avalon.FileManager:getResDirection() .. MapRelativePath
	return Avalon.FileManager:createDirectory(path), path
end

local function getMapWritablePath()
	path = Avalon.FileManager:getResDirection() .. MapRelativePath
	return path
end
_M.getMapWritablePath = getMapWritablePath

function _M.setFramePageInfos(key, framePageInfos)
	FramePageInfosCache[key] = framePageInfos
	print ("cache framePageInfos for", key)
end

function _M.getFramePageInfos(key)
	print ("get framePageInfos", key)
	return FramePageInfosCache[key]
end

function _M.getOverlayShader()
	-- local glProgram = cc.GLProgramCache:getInstance():getGLProgram("OverlayShader")
	-- if glProgram == nil then
	--     glProgram = cc.GLProgram:createWithFilenames("shaders/TexturePositionColorShaderNoMVP.vert", "shaders/OverlayShader.frag")
	--     cc.GLProgramCache:getInstance():addGLProgram(glProgram, "OverlayShader")
	-- end 	
	-- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
	local glProgramState = AvalonUtil:getGLProgramState("shaders/TexturePositionColorShaderNoMVP.vert", "shaders/OverlayShader.frag")
    return glProgramState
end

function _M.removeSpriteFramesForFramePageInfos(framePageInfos)
	for _, framePageInfo in ipairs(framePageInfos) do
		if not _M.removeSpriteFramesForOverlayFramePageInfo(framePageInfo) then
			return false
		end
	end
end

function _M.removeSpriteFramesForOverlayFramePageInfo(framePageInfo)
	-- cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(framePageInfo.atlasPlist)
	local name = framePageInfo["name"]
	local frameInfos = framePageInfo["frameInfos"]
	return _M.removeSpriteFramesForTexture(name, frameInfos)
end

function _M.removeSpriteFramesForTexture(textureName, frameInfos)
	-- local writablePath = cc.FileUtils:getInstance():getWritablePath() 
	local writablePath = getMapWritablePath()
	local fileName = writablePath .. textureName
	cc.Director:getInstance():getTextureCache():removeTextureForKey(fileName)
	for frameKey, frameInfo in pairs(frameInfos) do
		local spriteFrame = SpriteFrameCache:getSpriteFrame(frameKey)
		if spriteFrame ~= nil then 
			spriteFrame:release()
			SpriteFrameCache:removeSpriteFrameByName(frameKey)
		end
	end
end

function _M.addSpriteFramesForOverlayFramePageInfos(framePageInfos)
	for _, framePageInfo in ipairs(framePageInfos) do
		if not _M.addSpriteFramesForOverlayFramePageInfo(framePageInfo) then
			return false
		end
	end
	return true
end

function _M.addSpriteFramesForOverlayFramePageInfo(framePageInfo)
    -- cc.SpriteFrameCache:getInstance():addSpriteFrames(framePageInfo.plistPath)
	local name = framePageInfo["name"]
	local frameInfos = framePageInfo["frameInfos"]
	return _M.addSpriteFramesForTexture(name, frameInfos)
end

function _M.addSpriteFramesForTexture(textureName, frameInfos)
	-- local writablePath = cc.FileUtils:getInstance():getWritablePath() 
	local writablePath = getMapWritablePath()
	local fileName = writablePath .. textureName
	printfmt("getTextureCache:addImage: %s", fileName)
	local texture = cc.Director:getInstance():getTextureCache():addImage(fileName)
	if texture == nil then
		return false
	else
		-- texture:setAliasTexParameters()
		for frameKey, frameInfo in pairs(frameInfos) do
			-- print("add sprite frame %s", frameName)
			local spriteFrame = SpriteFrameCache:getSpriteFrame(frameKey)
			if spriteFrame == nil then
				local frameRect = frameInfo["frameRect"]
				local spriteFrame = cc.SpriteFrame:createWithTexture(texture, frameRect)
				if spriteFrame ~= nil then
					spriteFrame:retain()
					-- printfmt (string.format("add sprite frame %s in texture %s succeeded", frameKey, fileName))
					SpriteFrameCache:addSpriteFrame(spriteFrame, frameKey)
				end
			end
		end
		-- printfmt (string.format("add sprite frames in texture %s succeeded", fileName))
		return true
	end
end

-- 根据层叠配置生成层叠资源
function _M.createColorOverlayedTexture(config)
	assert(isValidConfig(config), "use TextureAtlasOverlayConfig")

	local getTextureAtlasSaveName = function (page) 
		local saveName = nil
		if #config.atlasSaveName > 0 then
			saveName = ("%s_%d.png"):format(config.atlasSaveName, page)
		else
			local name = removeExt(config.atlasPlist)
			saveName = ("%s_%d.png"):format(name, page)
		end
		return saveName
	end

	local getLuaSaveName = function ()
		local saveName = nil
		if #config.atlasSaveName > 0 then
			saveName = ("%s.lua"):format(config.atlasSaveName)
		else
			local name = removeExt(config.atlasPlist)
			saveName = ("%s.lua"):format(name)
		end
		return saveName
	end

	local ret, p = createMapWritablePath()
	if ret then
		printfmt("create new map writable path %s", p)
	end
	--  add sprite frames from atlas plist for overlay 
	SpriteFrameCache:addSpriteFrames(config.atlasPlist)

	local test = cc.FileUtils:getInstance():getValueMapFromFile(config.atlasPlist)
	local tpFrameInfos = cc.FileUtils:getInstance():getValueMapFromFile(config.atlasPlist).frames

	local x, y = Margins.Left, Margins.Top
	local width, height = 0, 0
	local lineHeight, lastFrameHeight = 0, 0
	local page = 1
	local framePageInfos = {}
	framePageInfos[page] = {}
	framePageInfos[page]["frameInfos"] = {}

	for _, configEntry in ipairs(config:getConfigEntries()) do
		local spriteFrame = SpriteFrameCache:getSpriteFrame(configEntry.spriteFrameName)
		if spriteFrame ~= nil then 
			local spriteTpFrameInfo = tpFrameInfos[configEntry.spriteFrameName]
			if spriteTpFrameInfo ~= nil then 
				local sourceSizeString = spriteTpFrameInfo.spriteSourceSize
				sourceSizeString = sourceSizeString:sub(2, #sourceSizeString - 1)
				local sourceSizeArray = sourceSizeString:split(",")
				local spriteFrameSourceSize = {width = tonumber(sourceSizeArray[1]), height =  tonumber(sourceSizeArray[2])}
				-- printfmt("spriteFrameSourceSize:%s", tostring(spriteFrameSourceSize))
				for _, color in ipairs(configEntry.colorArray) do 
					local newSpriteFrameName = MapHelper.getMapTerrainTexutreName(configEntry.spriteFrameName, color)
					if framePageInfos[page]["frameInfos"][newSpriteFrameName] == nil then
						if x + spriteFrameSourceSize.width > PageMaxWidth then 
							width = math.max(x, width)
							x = Margins.Left
							if y + lineHeight > PageMaxHeight then
								height = y + lastFrameHeight
								framePageInfos[page]["width"] = width
								framePageInfos[page]["height"] = height
							 	framePageInfos[page]["name"] = getTextureAtlasSaveName(page)

								page = page + 1
								framePageInfos[page] = {}
								framePageInfos[page]["frameInfos"] = {}
								y = Margins.Top
							else
								y = y + lineHeight
							end
							lineHeight = 0
							lastFrameHeight = spriteFrameSourceSize.height
						end

						local frameRect = {x = x, y = y, width = spriteFrameSourceSize.width, height = spriteFrameSourceSize.height}
						local frameInfo = {frameRect = frameRect, overlayColor = color, spriteFrameName = configEntry.spriteFrameName}

						-- 添加顶点信息
						local function parseNumArrStr(str)
							local strArr = str:split(" ")
							local arr = {}
							for i,v in ipairs(strArr) do
								arr[i] = tonumber(v)
							end
							return arr
						end
						local indicesStr = spriteTpFrameInfo.triangles
						if (indicesStr and indicesStr ~= "") then
							frameInfo["indices"] = parseNumArrStr(indicesStr)
						end
						local verticesStr = spriteTpFrameInfo.vertices
						if (verticesStr and verticesStr ~= "") then
							frameInfo["vertices"] = parseNumArrStr(verticesStr)
						end
						local textureUV = spriteTpFrameInfo.verticesUV
						if (textureUV and textureUV ~= "") then
							local textureRectStr = spriteTpFrameInfo.textureRect
							local textureRect = loadstring("return " .. textureRectStr)()
							local texturePos = textureRect[1]
							local newTexturePos = {frameRect.x, frameRect.y}
							local uvArr = parseNumArrStr(textureUV)
							for i,v in ipairs(uvArr) do
								local posIdx = (i + 1) % 2 + 1
								uvArr[i] = v - texturePos[posIdx] + newTexturePos[posIdx]
							end
							frameInfo["textureUV"] = uvArr
						end
						framePageInfos[page]["frameInfos"][newSpriteFrameName] = frameInfo
						-- lume.push(framePageInfos[page]["frameInfos"], frameInfo)
						-- printfmt (("newSpriteFrameName %s rect x:%d y:%d w:%d h:%d"):format(newSpriteFrameName, frameRect.x, frameRect.y, frameRect.width, frameRect.height))
						x = x + spriteFrameSourceSize.width + Gaps.Horizontal
						lineHeight = math.max(lineHeight, spriteFrameSourceSize.height + Gaps.Vertical)
						lastFrameHeight = lineHeight
					end
				end
			end
		end
	end
	height = y + lastFrameHeight - Gaps.Vertical + Margins.Bottom
	width = math.max(x, width)
 	width = width + Margins.Right
 	framePageInfos[page]["width"] = width
 	framePageInfos[page]["height"] = height
 	framePageInfos[page]["name"] = getTextureAtlasSaveName(page)

 	-- create texture atlas to hold color overlayed texture
	for i, framePageInfo in ipairs(framePageInfos) do
 		local width = framePageInfo["width"]
 		local height = framePageInfo["height"]
	 	-- create render texture to draw overlay texture 
	 	local renderTexture = cc.RenderTexture:create(width, height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
		renderTexture:retain()
		renderTexture:begin()
                
		local frameInfos = framePageInfo["frameInfos"]
		for newSpriteFrameName, frameInfo in pairs(frameInfos) do
			local spriteFrameName = frameInfo["spriteFrameName"]
			local spriteFrame = SpriteFrameCache:getSpriteFrame(spriteFrameName)
			local sprite = cc.Sprite:createWithSpriteFrame(spriteFrame)
			if sprite ~= nil then
				local overlayColor = frameInfo["overlayColor"]
				local frameRect = frameInfo["frameRect"]
                local shader = _M.getOverlayShader()
                sprite:setColor(overlayColor)
                sprite:setGLProgramState(shader)
                sprite:setPosition(math.floor(frameRect.x), math.floor(height - frameRect.y - frameRect.height))
                -- printfmt(("render frame name %s x %f y %f width %f height %f"):format(spriteFrameName, frameRect.x, height - frameRect.y - frameRect.height, sprite:getContentSize().width, sprite:getContentSize().height))
                sprite:setAnchorPoint(0, 0)
                sprite:visit()
                -- should delete fields 'overlayColor', 'spriteFrameName' from frameInfo after overlaying color
                -- cuz later we will archive frameInfos, fields 'overlayColor', 'spriteFrameName' are absolutely no neccessary to archive
                frameInfo["overlayColor"] = nil
                frameInfo["spriteFrameName"] = nil
			end
		end
		renderTexture:endToLua()

		-- save overlay texture to disk as png
		local saveName = Avalon.FileManager.AVALON_DIRECTION_RES .. MapRelativePath .. framePageInfo["name"]
		renderTexture:saveToFile(saveName, cc.IMAGE_FORMAT_PNG)
		renderTexture:release()
		printfmt("save overlayed atlas %s", saveName)
	end
		
	-- remove sprite frames from atlas plist
	SpriteFrameCache:removeSpriteFramesFromFile(config.atlasPlist)

	-- 转换并保存plist
	_M.storePlist(getMapWritablePath(), framePageInfos)

	-- cache overlayed frame infos in memory cache
 	-- printfmt("framePageInfos :%s", tostring(framePageInfos))
 	_M.setFramePageInfos(config.atlasSaveName, framePageInfos)

	-- save sprite frame infos to disk as lua 
	local luaName = getLuaSaveName()
	-- local luaSavePath = cc.FileUtils:getInstance():getWritablePath() .. luaName
	local luaSavePath = getMapWritablePath() .. luaName
	persistence.store(luaSavePath, framePageInfos)

	-- start a schudule to check save status of texture 
	print ("start overlayed texture save check schedule")
	local checkSaveID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function (dt)
		local succeed = true
        for _, framePageInfo in ipairs(framePageInfos) do
        	local saveName = framePageInfo["name"]
        	-- local saveFullPath = cc.FileUtils:getInstance():getWritablePath() .. saveName
        	local saveFullPath = getMapWritablePath() .. saveName
        	printfmt ("check save full path %s", saveFullPath)
        	if not cc.FileUtils:getInstance():isFileExist(saveFullPath) then
        		succeed = false
			end
			local plistPath = framePageInfo.plistPath
			if not cc.FileUtils:getInstance():isFileExist(plistPath) then
        		succeed = false
			end
        end
        if succeed then
        	local schedulerID = CheckSaveSechedulerIDMap[config.atlasSaveName]
      		printfmt("save overlayed texture succeeded, stop overlayed texture save check schedule %d", schedulerID)
        	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(schedulerID)
        	_M.addSpriteFramesForOverlayFramePageInfos(framePageInfos)
        	if config.completeCallback then
        		config.completeCallback(framePageInfos)
			end
        end 
    end, 0.1, false)
    CheckSaveSechedulerIDMap[config.atlasSaveName] = checkSaveID
end

-- 保存plist
function _M.storePlist(pathBase, framePageInfo)
	for i,pageInfo in ipairs(framePageInfo) do
		-- 输出路径
		local plistName = pageInfo.name:gsub("png", "plist")
		local ouputPath = pathBase .. plistName
		pageInfo.plistPath = ouputPath
		pageInfo.plist = plistName
		
		-- plist信息内容
		local plist = {}
		plist.metadata = {
			format = 3, 
			size = "{" .. pageInfo.width .. ",".. pageInfo.height .. "}", 
			textureFileName = pageInfo.name, 
			realTextureFileName = pageInfo.name, 
			premultiplyAlpha = false, 
			pixelFormat = "RGBA8888"
		}

		-- plist图片内容
		plist.frames = {}
		for frameName,info in pairs(pageInfo.frameInfos) do
			local rect = info.frameRect
			local plistFrameInfo = {}
			plistFrameInfo.aliases = {"none"}
			plistFrameInfo.spriteOffset = "{0,0}"
			plistFrameInfo.spriteSize = "{" .. rect.width .. "," .. rect.height .. "}"
			plistFrameInfo.spriteSourceSize = "{" .. rect.width .. "," .. rect.height .. "}"
			plistFrameInfo.textureRect = "{{" .. rect.x .. "," .. rect.y .. "},{" .. rect.width .. "," .. rect.height .. "}}"
			plistFrameInfo.textureRotated = false
			if (info.indices) then
				plistFrameInfo.triangles = table.concat(info.indices, " ")
			end
			if (info.vertices) then
				plistFrameInfo.vertices = table.concat(info.vertices, " ")
			end
			if (info.textureUV) then
				plistFrameInfo.verticesUV = table.concat(info.textureUV, " ")
			end
			
			plist.frames[frameName] = plistFrameInfo
		end

		cc.FileUtils:getInstance():writeToFile(plist, ouputPath)
	end
end

-- 从地图配置获取叠加图片生成配置
function _M.createTextureAtlasOverlayConfigs(mapAppearanceConfig, isSplit)
    -- 原图纹理信息
    local atlasName = isSplit and mapAppearanceConfig.splitName or mapAppearanceConfig.name
    local atlasPlistName =  atlasName .. ".plist"

	-- 原图单个图片名字
	local MapDataManager = require("app.mapkit.model.MapDataManager")
	local MapDefine = require("app.mapkit.MapDefine")
    local groundTerrainNames = MapDataManager:getInstance():getTerrainNamesForTerrainType(MapDefine.TerrainType.Ground)
    local wallTerrainNames = MapDataManager:getInstance():getTerrainNamesForTerrainType(MapDefine.TerrainType.Wall)

    -- 叠加图片颜色
    local groundOverlayColors = MapDataManager:getInstance():parseColors(lume.concat(mapAppearanceConfig.effectColors, mapAppearanceConfig.groundColors))
    local wallOverlayColors = MapDataManager:getInstance():parseColors(lume.concat(mapAppearanceConfig.effectColors, mapAppearanceConfig.wallColors))

    -- 地图底板叠加图片生成配置
	-- 如果是切分合并地图(split == 1), _split图片的数量为groundCategoryCount 既map1_floor_<groundCategoryCount>_split.png
    -- for batch node purpose, try to render ground and bottom section of wall in one texture
    -- and other sections of wall in another texture
    local groundOverlayConfig = TextureAtlasOverlayConfig:new(atlasPlistName, atlasName .. "_ground")
    for category = 1, mapAppearanceConfig.groundCategoryCount do 
        local terrainTextureName = MapHelper.getMapTerrainTextureName(atlasName, groundTerrainNames[1], category)
        groundOverlayConfig:addEntry(terrainTextureName, groundOverlayColors)

		if mapAppearanceConfig.isSplit == 1 and not isSplit then
			local terrainTextureName = string.format("%s_%s_%02d_split.png", atlasName, groundTerrainNames[1], category)
			groundOverlayConfig:addEntry(terrainTextureName, groundOverlayColors)
		end
    end
    if(mapAppearanceConfig.wallCategoryCount > 0) then
        local terrainTextureName = MapHelper.getMapTerrainTextureName(atlasName, wallTerrainNames[1], 1)
        groundOverlayConfig:addEntry(terrainTextureName, wallOverlayColors)

		if mapAppearanceConfig.isSplit == 1 then
			local texName = ("%s_%s_%02d_split.png"):format(atlasName, wallTerrainNames[1], 1)
			groundOverlayConfig:addEntry(texName, wallOverlayColors)
		end 
    end 

    -- 墙面叠加图片生成配置
    local wallOverlayConfig = TextureAtlasOverlayConfig:new(atlasPlistName, atlasName .. "_wall")
    if #wallTerrainNames > 1 and mapAppearanceConfig.wallCategoryCount > 0 then 
        for i = 2, #wallTerrainNames do 
            local wallTerrainName = wallTerrainNames[i]
            if i == #wallTerrainNames then
                for category = 1, mapAppearanceConfig.wallCategoryCount do 
                    local terrainTextureName = MapHelper.getMapTerrainTextureName(atlasName, wallTerrainName, category)
                    wallOverlayConfig:addEntry(terrainTextureName, wallOverlayColors)

					if mapAppearanceConfig.isSplit == 1 then
						local texName = ("%s_%s_%02d_split.png"):format(atlasName, wallTerrainName, category)
        				wallOverlayConfig:addEntry(texName, wallOverlayColors)
					end 
                end
            else 
                local terrainTextureName = MapHelper.getMapTerrainTextureName(atlasName, wallTerrainName, 1)
                wallOverlayConfig:addEntry(terrainTextureName, wallOverlayColors)

				if mapAppearanceConfig.isSplit == 1 and not isSplit then
					local texName = ("%s_%s_%02d_split.png"):format(atlasName, wallTerrainName, 1)
					wallOverlayConfig:addEntry(texName, wallOverlayColors)
				end 
            end
        end
    end

	-- if mapAppearanceConfig.isSplit == 1 and not isSplit then
	-- 	local terrainTextureName = string.format("%s_floor_split.png", atlasName)
    --     groundOverlayConfig:addEntry(terrainTextureName, groundOverlayColors)
	-- end

    return {["ground"] = groundOverlayConfig, ["wall"] = wallOverlayConfig}
end

-- 根据地图配置创建叠加图片配置
function _M.createColorOverlayedTextureFromMapAppearance(overlayConfigs, callback)
	local callBackIdx = 0
	for i,config in pairs(overlayConfigs) do
		-- 添加回调配置
		config.completeCallback = function()
			callBackIdx = callBackIdx + 1
			if (callback and callBackIdx >= 2) then
				callback()
			end
		end
		
		-- 创建并加载重叠纹理
		_M.createColorOverlayedTexture(config)
	end
end

-- 尝试从文件加载
function _M.loadFromFile(atlasName, overlayConfig)
	-- 如果已经有配置文件, 尝试加载
	local inDisk = true
	for typeStr,_ in pairs(overlayConfig) do
		local filePath = _M.getMapWritablePath() .. atlasName .. "_" .. typeStr .. ".lua"
		if cc.FileUtils:getInstance():isFileExist(filePath) then 
			local framePageInfos = persistence.load(filePath)
			if framePageInfos == nil then
				-- assert(false, ("load archive of frame page infos at %s failed"):format(filePath))
				inDisk = false
				break
			else
				printfmt ("add sprite frames for overlay texture atlas name %s in disk", atlasName .. "_" .. typeStr)
				if (_M.addSpriteFramesForOverlayFramePageInfos(framePageInfos)) then
					_M.setFramePageInfos(atlasName, framePageInfos)
				else 
					inDisk = false
					break
				end
			end
		else 
			inDisk = false
			break
		end
	end
	return inDisk
end

-- 最外层入口, 从地图配置中加载或生成地图层叠资源
function _M.loadOverlaysFromMapAppearance(appearanceConfig, callback)
	local atlasName = appearanceConfig.name
	local atlasPlistName = string.format("%s.plist", atlasName)
	local atlasSplitName = appearanceConfig.splitName

	local overlayConfigs = _M.createTextureAtlasOverlayConfigs(appearanceConfig)
	
	-- 如果已经在缓存里, 尝试加载
	local framePageInfos = _M.getFramePageInfos(atlasName)
	if (framePageInfos and _M.addSpriteFramesForOverlayFramePageInfos(framePageInfos)) then
		printfmt ("add sprite frames for overlay texture atlas name %s in memory", atlasName)
		if (callback) then
			callback()
		end
		return
	end

	-- 如果已经有配置文件, 尝试加载
	-- local inDisk = true
	-- if (_M.loadFromFile(atlasName, overlayConfigs)) then
	-- 	if (callback) then
	-- 		callback()
	-- 	end
	-- 	return
	-- else
	-- 	inDisk = false
	-- end

	-- CO-21400 改为一直重新加载
	local inDisk = false

	-- 没有文件或者加载失败, 尝试重新创建
	if not inDisk then
		_M.createColorOverlayedTextureFromMapAppearance(overlayConfigs, function()
			if (callback) then
				callback()
			end
		end)
	end


	if appearanceConfig.isSplit == 1 then
		local overlayConfigs = _M.createTextureAtlasOverlayConfigs(appearanceConfig, true)
		-- 如果已经在缓存里, 尝试加载
		local framePageInfos = _M.getFramePageInfos(atlasSplitName)
		if (framePageInfos and _M.addSpriteFramesForOverlayFramePageInfos(framePageInfos)) then
			printfmt ("add sprite frames for overlay texture atlas name %s in memory", atlasSplitName)
			if (callback) then
				callback()
			end
			return
		end

		-- 如果已经有配置文件, 尝试加载
		-- local inDisk = true
		-- if (_M.loadFromFile(atlasSplitName, overlayConfigs)) then
		-- 	if (callback) then
		-- 		callback()
		-- 	end
		-- 	return
		-- else
		-- 	inDisk = false
		-- end
		local inDisk = false

		-- 没有文件或者加载失败, 尝试重新创建
		if not inDisk then
			_M.createColorOverlayedTextureFromMapAppearance(overlayConfigs, function()
				if (callback) then
					callback()
				end
			end)
		end
	end
end

return _M
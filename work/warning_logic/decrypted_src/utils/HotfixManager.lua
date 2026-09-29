require "utils.FileManager"
require "app.utils.ServerConfigUtil"

Avalon = Avalon or {}

local HotfixManager = {}
Avalon.HotfixManager = HotfixManager
local REPEAT_MAX_TIME = 3  -- 热更一次重复的次数







-- parem: cc.EventAssetsManagerEx
local function listenerCallback(self, event)
	-- print("============HotfixManager, callback", event:getEventCode(),event:getPercent(),event:getPercentByFile(),event:getCURLECode(),event:getMessage(),event:getAssetId())
	local CODE = cc.EventAssetsManagerEx.EventCode
	if 	   (event:getEventCode() == CODE.ERROR_NO_LOCAL_MANIFEST) then 	-- 0
		-- 没有本地版本文件
		local tips = UI.Tips:createTips(UI.TEXT_1201002,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
        -- 确定和取消事件监听
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            self._assetsManager:checkUpdate()
		end)
		tips:addEventListener(UIEvent.DIALOG_CANCEL, tips,function()
			-- cc.Director:getInstance():endToLua()
			-- os.exit()
			require "app.utils.ToolsUtil"
			ToolsUtil:exitApp()
		end)
		if (self._onError) then self._onError(CODE.ERROR_NO_LOCAL_MANIFEST) end
	elseif (event:getEventCode() == CODE.ERROR_DOWNLOAD_MANIFEST) then 	-- 1
		-- 下载远程版本文件失败
		self._isUpdating = false
		local tips = UI.Tips:createTips(UI.TEXT_1201003,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
        -- 重新下载,或者退出游戏
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            if (not self:isUpdateing()) then self:update() end
		end)
		tips:addEventListener(UIEvent.DIALOG_CANCEL, tips,function()
			-- cc.Director:getInstance():endToLua()
			-- os.exit()
			require "app.utils.ToolsUtil"
			ToolsUtil:exitApp()
		end)
		if (self._onError) then self._onError(CODE.ERROR_DOWNLOAD_MANIFEST) end
	elseif (event:getEventCode() == CODE.ERROR_PARSE_MANIFEST) then 	-- 2
		-- 解析下载的版本文件失败
		local tips = UI.Tips:createTips(UI.TEXT_1201004,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
        -- 重新下载,或者退出游戏
        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
            self._assetsManager:checkUpdate()
		end)
		tips:addEventListener(UIEvent.DIALOG_CANCEL, tips,function()
			-- cc.Director:getInstance():endToLua()
			-- os.exit()
			require "app.utils.ToolsUtil"
			ToolsUtil:exitApp()
		end)
		if (self._onError) then self._onError(CODE.ERROR_PARSE_MANIFEST) end
	elseif (event:getEventCode() == CODE.NEW_VERSION_FOUND) then 		-- 3
		self._repeatCount = 0
		-- print("需要更新 ",event:getMessage())
		local size = checkint(event:getMessage())
		self._maxSize = size;
		-- print("需要更新 byte ",)
		local sizemb = tonumber(string.format("%0.2f", size/1024/1024))
		
		if not sizemb or sizemb <= 0 then sizemb = 0.01 end
		
		self:setRemotePackageUrl(ServerConfigUtil:getHotFixPackageUrl())
		self:setTempPackageUrl(ServerConfigUtil:getHotFixPackageUrl())
		-- 如果有热更新,清理res缓存目录(地图纹理的缓存,如果被更新过,可能会报错)
		Avalon.FileManager:removeDirectory(Avalon.FileManager:getResDirection())
		Avalon.FileManager:createDirectory(Avalon.FileManager:getResDirection())
		-- 找到新版本, 如果没有在更新就更新
		local networkMode = AvalonUtil.getNetworkMode()
		if networkMode == PublicDefine.NetworkMode.WWAN then
		-- if networkMode == PublicDefine.NetworkMode.WIFI then
			local tips = UI.Tips:createTips(string.format(UI.TEXT_1201006,sizemb),UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
			-- 开始下载,或者退出游戏
			tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
				if (self._onComplete) then self._onComplete(CODE.NEW_VERSION_FOUND) end
				if (not self:isUpdateing()) then self:update() end
			end)
			tips:addEventListener(UIEvent.DIALOG_CANCEL, tips,function()
				-- cc.Director:getInstance():endToLua()
				-- os.exit()
				require "app.utils.ToolsUtil"
				ToolsUtil:exitApp()
			end)
		else
			if (self._onComplete) then self._onComplete(CODE.NEW_VERSION_FOUND) end
			if (not self:isUpdateing()) then self:update() end
		end
		
	elseif (event:getEventCode() == CODE.ALREADY_UP_TO_DATE) then		-- 4
		self._repeatCount = 0
		-- 已经是最新版本
		self._isUpdating = false
		if (self._onComplete) then self._onComplete(CODE.ALREADY_UP_TO_DATE) end
		
	elseif (event:getEventCode() == CODE.UPDATE_PROGRESSION) then		-- 5
		-- 更新中 (一般是成功更新了一个文件)
		self._progress = event:getPercent()
		self._progressByFile = event:getPercentByFile()
		local assetId = event:getAssetId()
		if assetId == "@manifest" or assetId == "@version"  then
			return;
		end
		if self._onProgress then
			self._onProgress(self._progress,self._progressByFile,event:getAssetId())
		end
	elseif (event:getEventCode() == CODE.ASSET_UPDATED) then			-- 6
		-- 更新一个文件成功
	elseif (event:getEventCode() == CODE.ERROR_UPDATING) then			-- 7
		-- if(string.find(event:getMessage(), "with status code (404)")) then
		-- 	print("ERROR_UPDATING", event:getAssetId(), "PERCENT."..event:getPercentByFile(), "message:"..event:getMessage())
		-- end
		-- 更新一个文件失败
		local assetId = event:getAssetId()
		local message = event:getMessage()
		self.errorFileCount = self.errorFileCount + 1;
        local data = {}
        data.assetId = assetId
        data.message = message
        data.percent = event:getPercent()
        data.percentFile = event:getPercentByFile()
		table.insert(self.errorFiles, data)
	elseif (event:getEventCode() == CODE.UPDATE_FINISHED) then			-- 8
		self._repeatCount = 0
		-- 更新成功
		self._isUpdating = false
		if (self._onComplete) then self._onComplete(CODE.UPDATE_FINISHED) end
	elseif (event:getEventCode() == CODE.UPDATE_FAILED) then			-- 9
		-- 更新失败
		self._isUpdating = false

		local tempList = {}
		for i = 1, 3 do
			local data = self.errorFiles[i]
			if data then
				table.insert(tempList, data)
			end
		end

		-- 先清理本地临时目录
		local removeFailPath = ""
		local removeFailNum = 0
		if device.platform == "android" or device.platform == "ios" then
			local direction = Avalon.FileManager:getHotfixTempDirection()
			for k, v in ipairs(self.errorFiles) do
				local result = Avalon.FileManager:removeFileByAbsPath(direction..v.assetId)
				if(not result) then 
					removeFailNum = removeFailNum + 1
					if(removeFailPath and removeFailPath~= "") then
						removeFailPath = direction..v.assetId
					end
				end
			end
		end

		self._repeatCount = self._repeatCount + 1
		-- add by zp 添加了一个自动重试操作, 如果失败的文件太多也直接弹提示
		if(self._repeatCount >= REPEAT_MAX_TIME or self.errorFileCount > 20) then
			-- print("self.errorFileCount=", self.errorFileCount)
			self._repeatCount = 0
			local errorCode = self:parseException(tempList)
			local tipsStr = string.format(UI.TEXT_1201009,self.errorFileCount)..string.format("\n(err:%s)", errorCode)
			if(errorCode == "1001") then
				local LanguageManager = require "app.game.LanguageManager"
				tipsStr = tipsStr .."\n".. LanguageManager:getInstance():getLocalString(1113085)
			end
			local tips = UI.Tips:createTips(tipsStr, UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
			-- 重新下载,或者退出游戏
			tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
				-- --先清理本地临时目录
				-- if device.platform == "android" or device.platform == "ios" then
				-- 	local direction = Avalon.FileManager:getHotfixTempDirection()
				-- 	for k, v in ipairs(self.errorFiles) do
				-- 		-- print("-------1-----", direction..v.assetId, cc.FileUtils:getInstance():isFileExist(direction..v.assetId))
				-- 		local result = Avalon.FileManager:removeFileByAbsPath(direction..v.assetId)
				-- 		-- print("-------2-----", result, cc.FileUtils:getInstance():isFileExist(direction..v.assetId))
				-- 	end
				-- end
				self.errorFiles = {}
				self.errorFileCount = 0
				self._assetsManager:downloadFailedAssets()
			end)
			tips:addEventListener(UIEvent.DIALOG_CANCEL, tips,function()
				self.errorFiles = {}
				self.errorFileCount = 0
				-- cc.Director:getInstance():endToLua()
				-- os.exit()
				require "app.utils.ToolsUtil"
				ToolsUtil:exitApp()
			end)
		else 
			-- print("self._repeatCount=", self._repeatCount)
			self.errorFiles = {}
			self.errorFileCount = 0
			self._assetsManager:downloadFailedAssets()
		end
		-- self.errorFiles
		local errorMessage = ""
		if(self.errorFiles and #self.errorFiles > 0)then 
			errorMessage = self.errorFiles[1].message
		end
		printError(string.format("(err:%s,errorMes=%s)", errorCode, errorMessage))
		if (self._onError) then self._onError(CODE.UPDATE_FAILED, "fileNum:"..tostring(self.errorFileCount)..",errorMes:"..json.encode(tempList)..",removeError:"..removeFailPath..",errNum=".. tostring(removeFailNum)) end
	elseif (event:getEventCode() == CODE.ERROR_DECOMPRESS) then			-- 10
		-- 解压失败
		if (self._onError) then self._onError(CODE.ERROR_DECOMPRESS) end
	end
end

--[[
http://aiki.avalongames.com/pages/viewpage.action?pageId=13959856
]]
function HotfixManager:parseException(errorFiles)
	if device.platform ~= "android" then
		return "0"
	end
	for k, param in ipairs(errorFiles) do
		local exception = param
		if type(param) == "table" then
			exception = json.encode(param)
		end
		local startPos = string.find(exception, "Requested Range Not Satisfiable")
		if startPos ~= nil then
			return  "1001"
		end

		local startPos = string.find(exception, "Asset file verification failed after downloaded")
		if startPos ~= nil then
			return  "1002"
		end

		local startPos = string.find(exception, "Timeout waiting for connection from pool")
		if startPos ~= nil then
			return  "1003"
		end

		local startPos = string.find(exception, "Read timed out")
		if startPos ~= nil then
			return  "1004"
		end

		local startPos = string.find(exception, " Connection has been shut down")
		if startPos ~= nil then
			return  "1005"
		end

		local startPos = string.find(exception, "Not Found")
		if startPos ~= nil then
			return  "1006"
		end

		local startPos = string.find(exception, "Gateway Time-out")
		if startPos ~= nil then
			return  "1008"
		end

		local startPos = string.find(exception, "Unable to resolve host")
		if startPos ~= nil then
			return  "1009"
		end

		local startPos = string.find(exception, "Software caused connection abort")
		if startPos ~= nil then
			return  "1010"
		end

		local startPos = string.find(exception, "ConnectTimeoutException: Connect to")
		if startPos ~= nil then
			return  "1011"
		end

		local startPos = string.find(exception, "请求超时")
		if startPos ~= nil then
			return  "1012"
		end

		local startPos = string.find(exception, "网络连接已中断")
		if startPos ~= nil then
			return  "1013"
		end

		local startPos = string.find(exception, "java.net.SocketTimeoutException")
		if startPos ~= nil then
			return  "1007"
		end
	end 
	return "unknow error"
end


function HotfixManager:setOnProgress(func)
	assert(type(func) == "function" or func == nil)
	self._onProgress = func

end

function HotfixManager:setOnProgressByFile(func)
end

function HotfixManager:setOnComplete(func)
	assert(type(func) == "function" or func == nil)
	self._onComplete = func
end

function HotfixManager:setOnError(func)
	assert(type(func) == "function" or func == nil)
	self._onError = func
end











function HotfixManager:init()
	self._assetsManager = cc.AssetsManagerEx:create("CaveOnline_project.manifest", Avalon.FileManager:getHotfixDirection())

	self._assetsManager:retain()
	local listener = cc.EventListenerAssetsManagerEx:create(self._assetsManager, function(event) 
		listenerCallback(self, event)
	end)
	local dispatcher = cc.Director:getInstance():getEventDispatcher()
	dispatcher:addEventListenerWithFixedPriority(listener, 1)

	self._repeatCount = 0
	self._isUpdating = false
	self._progress = 0
	self._progressByFile = 0
	self._onProgress = nil
	self._onProgressByFile = nil
	self._onComplete = nil
	self._onError = nil
	self.errorFileCount = 0;
	self.localVersion = nil;
	self.localBuild = nil;
	self.errorFiles = {};
	self._maxSize = 0;
end

function HotfixManager:uninit()
	self._assetsManager:release()
end

function HotfixManager:getMaxSize()
	return self._maxSize
end
function HotfixManager:checkUpdate(onProgress, onComplete, onError, overrideUrl, overrideVersion)
	self:setOnProgress(onProgress)
	self:setOnComplete(onComplete)
	self:setOnError(onError)
	self.errorFileCount = 0;
	self.errorFiles = {};
	self._assetsManager:checkUpdate()
end

function HotfixManager:update()
	self._isUpdating = true
	self.errorFileCount = 0;
	self.errorFiles = {};
	self._assetsManager:update()
end

function HotfixManager:isUpdateing()
	return self._isUpdating
end

function HotfixManager:getLocalManifest()
	return self._assetsManager:getLocalManifest()
end

function HotfixManager:getRemoteManifest()
	return self._assetsManager:getRemoteManifest()
end

function HotfixManager:getTempManifest()
	return self._assetsManager:getTempManifest()
end

function HotfixManager:setLocalVersionUrl(url)
	local localManifest = self:getLocalManifest()
	if (not localManifest) then
		print("HotfixManager:setLocalVersionUrl, 本地Manifest错误")
		return
	end
    localManifest:setVersionFileUrl(url)
end

function HotfixManager:setLocalManifestUrl(url)
	local localManifest = self:getLocalManifest()
	if (not localManifest) then
		print("HotfixManager:setLocalManifestUrl, 本地Manifest错误")
		return
	end
    localManifest:setManifestFileUrl(url)
end

function HotfixManager:setTempPackageUrl(url)
	local tempManifest = self:getTempManifest()
	if (not tempManifest) then
		print("HotfixManager:setTempPackageUrl, 临时Manifest错误")
		return
	end
	tempManifest:setPackageUrl(url)
end

function HotfixManager:setRemotePackageUrl(url)
	local remoteManifest = self:getRemoteManifest()
	if (not remoteManifest) then
		print("HotfixManager:setRemotePackageUrl, 远端Manifest错误")
		return
	end
	remoteManifest:setPackageUrl(url)
end

function HotfixManager:getLocalVersion()
	if self.localVersion then return self.localVersion end
	local localManifest = self:getLocalManifest()
	if (not localManifest) then
		print("HotfixManager:getLocalVersion, 本地Manifest错误")
		return "0"
	end
	self.localVersion = localManifest:getVersion()
    return self.localVersion
end

function HotfixManager:getLocalBuild()
	if self.localBuild then return self.localBuild end
	local localManifest = self:getLocalManifest()
	if (not localManifest) then
		print("HotfixManager:getLocalBuild, 本地Manifest错误")
		return 0
	end
	self.localBuild = localManifest:getBuild()
	return self.localBuild
end

HotfixManager:init()
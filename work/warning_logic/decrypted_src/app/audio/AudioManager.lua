-- 音效模块
-- CMonk
require "app.config.ConfigManager"

local AudioManager = {}
Avalon = Avalon or {}
Avalon.AudioManager = AudioManager







cc.SimpleAudioEngine:getInstance():getMusicVolume() --绕过一个初始化时播放音效慢半拍的问题, 这里用SimpleAudioEngine来提前初始化一下
local bgmId = nil
local bgmFileName = nil
local bgmVolume = 0
local bgmPaused = false
-- sfxInfo 结构
-- local sfxInfo = {
--	objId,
--	fileName,
-- 	volume,
--	locX,
-- 	locY
-- }
local sfxInfos = {}
local sfxMasterVolume = 0
local sfxMasterPaused = false
local sfxMaxDistance = 5.3 --收音地图格距离
local sfxMaxDistanceSqr = sfxMaxDistance * sfxMaxDistance








-- 在一个统一的位置拼接声音文件路径, 好维护
local function getSoundFilePath(fileName)
	return "sound/"..fileName..".mp3"
end

-- 返回显示音乐开关
function AudioManager:isMusicOnForDisplay()
	if (self:getMusicVolume() == 0) then
		return false
	end
	return true
end

-- 返回显示音乐音量
function AudioManager:getMusicVolumeForDisplay()
	return cc.UserDefault:getInstance():getFloatForKey(UserDefaultKeyWord.musicVolumeForDisplay, self:getMusicVolume())
end

-- 存储显示音乐音量
function AudioManager:saveMusicVolumeForDisplay(f)
	cc.UserDefault:getInstance():setFloatForKey(UserDefaultKeyWord.musicVolumeForDisplay, f)
end

-- 返回背景音乐音量
function AudioManager:getMusicVolume()
	self:loadMusicVolume()
	return bgmVolume
end

-- 设置背景音乐音量
function AudioManager:setMusicVolume(volume)
	if (not bgmId) then return end
	if (volume > 1) then volume = 1 end
	if (volume < 0) then volume = 0 end

	local effectHelper = require("app.audio.AudioEffectsHelper")
	if (effectHelper:getInstance():isEffectRunningForId(bgmId)) then
		-- 如果特效在运行, 设置特效的相关音效
		effectHelper:getInstance():setMasterVolumeForId(bgmId, bgmVolume)
	else
		-- 如果特效没有在运行, 直接设置相关音效
		ccexp.AudioEngine:setVolume(bgmId, volume)
	end
	bgmVolume = volume
end

-- 存储背景音量设置到文件
function AudioManager:saveMusicVolume()
	cc.UserDefault:getInstance():setFloatForKey(UserDefaultKeyWord.musicVolume, bgmVolume)
end

-- 从文件读取背景音量设置
function AudioManager:loadMusicVolume()
	bgmVolume = cc.UserDefault:getInstance():getFloatForKey(UserDefaultKeyWord.musicVolume,1.0)
	if (bgmVolume > 1.0) then bgmVolume = 1.0 end
	if (bgmVolume < 0) then bgmVolume = 0 end

	if (bgmId) then
		self:setMusicVolume(bgmVolume)
	end
end

-- 根据配置参数播放背景音乐
function AudioManager:playMusicByConfig(caveMode, level, isLoop, isTryToResume)
	if (isLoop == nil) then isLoop = true end
	if (isTryToResume == nil) then isTryToResume = false end

    local audioConfig = ConfigManager:getAudioConfig(string.format("%d%02d%d", 24, tonumber(caveMode), tonumber(level)))

    local fileName = "10002"
    if audioConfig then
    	fileName = audioConfig.path
    end

    -- 尝试恢复播放或者直接播放新背景音乐
    if (isTryToResume and bgmId and bgmPaused and fileName == bgmFileName) then
    	self:resumeMusic()
    else
    	self:playMusic(fileName, isLoop)
    end
end

-- 根据文件名播放背景音乐
function AudioManager:playMusic(fileName, isLoop)
	isLoop = isLoop and true or false

	if (bgmId) then
		local effectHelper = require("app.audio.AudioEffectsHelper")
		effectHelper:getInstance():clearEffectForId(bgmId, true)
		self:stopMusic()
	end

	bgmFileName = fileName
	bgmId = ccexp.AudioEngine:play2d(getSoundFilePath(bgmFileName), isLoop, bgmVolume)
end

-- 停止正在播放的背景音乐
function AudioManager:stopMusic(isReleaseResource)
	if (not bgmId) then return end

	ccexp.AudioEngine:stop(bgmId)

	if (isReleaseResource and bgmFileName) then
		ccexp.AudioEngine:uncache(getSoundFilePath(bgmFileName))
	end

	bgmId = nil
	bgmFileName = nil
end

-- 暂停背景音乐
function AudioManager:pauseMusic(isToFade)
	if (isToFade == nil) then isToFade = true end

	if (bgmId) then
		if (isToFade) then
			local effectHelper = require("app.audio.AudioEffectsHelper")
			effectHelper:getInstance():fadeOut(bgmId, 1.5, bgmVolume, function()
				if (bgmId) then ccexp.AudioEngine:pause(bgmId) end
			end)
		else
			ccexp.AudioEngine:pause(bgmId)
		end
		bgmPaused = true
	end
	
end

-- 恢复背景音乐
function AudioManager:resumeMusic(isToFade)
	if (isToFade == nil) then isToFade = true end

	if (bgmId) then
		local effectHelper = require("app.audio.AudioEffectsHelper")
		if (isToFade) then
			effectHelper:getInstance():fadeIn(bgmId, 1.5, bgmVolume)
		else
			effectHelper:getInstance():clearEffectForId(bgmId)
			ccexp.AudioEngine:setVolume(bgmId, bgmVolume)
		end
		ccexp.AudioEngine:resume(bgmId)
		bgmPaused = false
	end
end

-- 返回背景音乐播放状态
function AudioManager:isMusicPlaying()
	if (bgmId and not bgmPaused) then
		return true
	end
	return false
end










-- 返回显示音乐开关
function AudioManager:isSoundsOnForDisplay()
	if (self:getSoundsVolume() == 0) then
		return false
	end
	return true
end

-- 返回显示音乐音量
function AudioManager:getSoundsVolumeForDisplay()
	return cc.UserDefault:getInstance():getFloatForKey(UserDefaultKeyWord.soundsVolumeForDisplay, self:getSoundsVolume())
end

-- 存储显示音乐音量
function AudioManager:saveSoundsVolumeForDisplay(f)
	cc.UserDefault:getInstance():setFloatForKey(UserDefaultKeyWord.soundsVolumeForDisplay, f)
end

-- 返回音效总控音量
function AudioManager:getSoundsVolume()
	self:loadSoundsVolume()
	return sfxMasterVolume
end

-- 设置音效总控音量
function AudioManager:setSoundsVolume(volume)
	sfxMasterVolume = volume
	self:updateAllTrackedSFXVolume()
end

-- 根据总控音量更新所有音效音量
function AudioManager:updateAllTrackedSFXVolume()
	local effectHelper = require("app.audio.AudioEffectsHelper")

	for k,v in pairs(sfxInfos) do
		if (effectHelper:getInstance():isEffectRunningForId(k)) then
			-- 如果特效在运行, 设置特效的相关音效
			effectHelper:getInstance():setMasterVolumeForId(k, v.volume * sfxMasterVolume)
		else
			-- 如果特效没有在运行, 直接设置相关音效
			ccexp.AudioEngine:setVolume(k, v.volume * sfxMasterVolume)
		end
	end
end

-- 存储音效音量设置到文件
function AudioManager:saveSoundsVolume()
	cc.UserDefault:getInstance():setFloatForKey(UserDefaultKeyWord.soundsVolume, sfxMasterVolume)
end

-- 从文件读取音效音量设置
function AudioManager:loadSoundsVolume()
	sfxMasterVolume = cc.UserDefault:getInstance():getFloatForKey(UserDefaultKeyWord.soundsVolume,1.0)
	if (sfxMasterVolume > 1.0) then sfxMasterVolume = 1.0 end
	if (sfxMasterVolume < 0) then sfxMasterVolume = 0 end

	self:setSoundsVolume(sfxMasterVolume)
end

-- 根据配置ID播放音效
function AudioManager:playSoundByConfigID(id, isLoop, coord)
	coord = coord or {}
    local pAudioConfig = ConfigManager:getAudioConfig(id)

    if pAudioConfig then
        self:playSoundDelay(pAudioConfig.path, pAudioConfig.timing, isLoop, coord)
    end
end

-- 根据配置type和id播放音效
function AudioManager:playSoundByConfig(type, id, isLoop, coord)
	coord = coord or {}
    local pAudioConfig = ConfigManager:getAudioConfig(tostring(type)..tostring(id))

    if pAudioConfig then
        self:playSoundDelay(pAudioConfig.path, pAudioConfig.timing, isLoop, coord)
    end
end

-- 延迟播放音效(延迟绑定在场景上面, 会受场景切换影响)
function AudioManager:playSoundDelay(fileName, time, isLoop, coord)
	if type(isLoop) ~= "boolean" then isLoop = false end
	performWithDelay(cc.Director:getInstance():getRunningScene(), function()
        self:playDynamicSound(fileName, isLoop, coord)
    end, time/1000.0)
end

-- 根据坐标和最大收音范围获取音量
function AudioManager:getVolumeFromLocation(coord)
	if (coord == nil or coord.x == nil or coord.y == nil) then
		printInfo("AudioManager:getVolumeFromLocation, 坐标转换音量中未获得坐标", coord)
		printInfo(debug.traceback())
		return 1
	end

	local GameDataManager = require("app.game.GameDataManager")
	local master = GameDataManager:getInstance():getMaster()
	if (not master) then
		printWarn("AudioManager:getVolumeFromLocation, 主角不存在")
		printWarn(debug.traceback())
		return 1
	end

	local centerCoord = master:getCoord()
	if (not centerCoord) then
		printWarn("AudioManager:getVolumeFromLocation, 主角坐标不存在")
		printWarn(debug.traceback())
		return 1
	end

	local disX = centerCoord.x - coord.x
	local disY = centerCoord.y - coord.y
	local dis = math.sqrt(disX * disX + disY * disY)
	local volume = dis / sfxMaxDistance
	-- 非线性在接近边沿的地方音量太突然降低程度太大, 用线性下降
	-- local disSqr = disX * disX + disY * disY
	-- local volume = disSqr / sfxMaxDistanceSqr
	volume = 1 - volume -- 越远声音越小
	if (volume > 1) then volume = 1 end
	if (volume < 0) then volume = 0 end
	return volume
end

-- 根据坐标播放声音
function AudioManager:playDynamicSound(fileName, isLoop, coord, objId, cb)
	local volume = 1
	if (fileName:sub(-1) ~= "#") then
		volume = self:getVolumeFromLocation(coord)
	end
	local sfxId = self:playSound(fileName, isLoop, volume)
	-- 暂不使用跟踪器
	-- self:addTracker(sfxId, fileName, 1.0, objId, locX, locY, cb)
end

-- -- 辅助方法, 加入坐标追踪 ####暂时不使用
-- function AudioManager:addTracker(sfxId, fileName, volume, objId, locX, locY, cb)
-- 	local entry = {}
-- 	entry.fileName = getSoundFilePath(fileName)
-- 	entry.volume = volume
-- 	entry.locX = locX
-- 	entry.locY = locY
-- 	entry.objId = objId
-- 	if (sfxInfos[sfxId] ~= nil) then 
-- 		printWarn("AudioManager:playSoundWithTracker, 音效播放ID重叠, id" .. tostring(sfxId)) 
-- 	end
-- 	sfxInfos[sfxId] = entry
-- 	ccexp.AudioEngine:setFinishCallback(sfxId, function()
-- 		self:removeTracker(sfxId)
-- 		if (cb) then cb() end
-- 	end)
-- end

-- -- 根据ID取消一个追踪
-- function AudioManager:removeTracker(sfxId)
-- 	if (sfxInfos[sfxId] == nil) then return end

-- 	if (ccexp.AudioEngine:getState(sfxId) == -1) then
-- 		sfxInfos[sfxId] = nil
-- 	end
-- end

-- -- 取消所有追踪
-- function AudioManager:removeAllTrackers()
-- 	sfxInfos = {}
-- end

-- 根据文件名播放一个音效
function AudioManager:playSound(fileName, isLoop, volume)
	if (not fileName) then
		fileName = ""
		printWarn("AudioManager:playSound, 空声音文件名")
		printWarn(debug.traceback())
		return
	end

	isLoop = isLoop and true or false
	volume = volume or 1.0

	volume = volume * sfxMasterVolume
	fileName = getSoundFilePath(fileName)
	return ccexp.AudioEngine:play2d(fileName, isLoop, volume)
end

-- 根据一个ID停止一个音效
function AudioManager:stopSound(handle)
	if (not handle) then
		printWarn("AudioManager:stopSound 没有声音ID")
		return
	end
	ccexp.AudioEngine:stop(handle)
end

-- 根据一个ID暂停一个音效
function AudioManager:pauseSound(handle)
	if (not handle) then
		printWarn("AudioManager:pauseSound 没有声音ID")
		return
	end
	ccexp.AudioEngine:pause(handle)
end

-- 根据一个ID恢复一个音效
function AudioManager:resumeSound(handle)
	if (not handle) then
		printWarn("AudioManager:resumeSound 没有声音ID")
		return
	end
	ccexp.AudioEngine:resume(handle)
end

-- 停止所有音效
function AudioManager:stopAllSounds()
	ccexp.AudioEngine:stopAll()
end

-- 暂停所有音效
function AudioManager:pauseAllSounds()
	ccexp.AudioEngine:pauseAll()
end

-- 恢复所有音效
function AudioManager:resumeAllSounds()
	ccexp.AudioEngine:resumeAll()
end

AudioManager:loadMusicVolume()
AudioManager:loadSoundsVolume()

return AudioManager
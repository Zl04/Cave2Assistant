-- 音效效果辅助模块
-- CMonk

local AudioEffectHelper = class("SdkBox")
Avalon = Avalon or {}
Avalon.AudioEffectHelper = AudioEffectHelper

g_AudioEffectHelper = nil










-- 内部方法, 运行一个方法直到返回true, 包含有一些音效相关参数
local function runUtilReturnTrue(self, runFunc, cbFunc, id, masterVolume)
	local entry = {}
	entry.runFunc = runFunc
	entry.cbFunc = cbFunc
	entry.id = id
	entry.masterVolume = masterVolume or 1
	table.insert(self._runUntilList, entry)
end















--效果方法---------------------------------------------
-- 为一个音效做渐出
function AudioEffectHelper:fadeOut(id, length, fromVolume, cb)
	fromVolume = fromVolume or 1
	self:clearEffectForId(id)
	local progress = 0
	local dtSum = 0
	runUtilReturnTrue(self, function(dt, masterVolume)
		dtSum = dtSum + dt
		local rawProgress = dtSum / length
		progress = rawProgress > 1 and 1 or rawProgress

		ccexp.AudioEngine:setVolume(id, (1 - progress) * masterVolume)
		return progress >= 1
	end, function()
		if (cb) then cb() end
	end, id, fromVolume)
end

-- 为一个音效做渐入
function AudioEffectHelper:fadeIn(id, length, toVolume, cb)
	toVolume = toVolume or 1
	self:clearEffectForId(id)
	local progress = 0
	local dtSum = 0
	runUtilReturnTrue(self, function(dt, masterVolume)
		dtSum = dtSum + dt
		local rawProgress = dtSum / length
		progress = rawProgress > 1 and 1 or rawProgress

		ccexp.AudioEngine:setVolume(id, progress * masterVolume)
		return progress >= 1
	end, function()
		if (cb) then cb() end
	end, id, toVolume)
end
--eo效果方法---------------------------------------------





















--杂用方法---------------------------------------------
-- 单例方法
function AudioEffectHelper:getInstance()
	if g_AudioEffectHelper == nil then
		g_AudioEffectHelper = AudioEffectHelper.new()
		g_AudioEffectHelper:init()
	end
	return g_AudioEffectHelper;
end

-- Ctor
function AudioEffectHelper:ctor()
	self._runUntilList = {}
	self._volumeChanged = false
	Avalon.Scheduler:scheduleUpdate(self, self.update)
end

-- Dtor
function AudioEffectHelper:dtor()
	Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

-- 初始化方法
function AudioEffectHelper:init()
end

-- 每帧更新方法
function AudioEffectHelper:update(dt)
	for i = #self._runUntilList, 1, -1 do
		local v = self._runUntilList[i]
		if (v.runFunc) then
			if (v.runFunc(dt, v.masterVolume)) then
				v.cbFunc()
				table.remove(self._runUntilList, i)
			end
		else
			printWarn("AudioEffectHelper, 没有设置运行方法.")
			table.remove(self._runUntilList, i)
		end
	end
end

-- 返回一个音效ID是否有效果在播放
function AudioEffectHelper:isEffectRunningForId(id)
	for i,v in ipairs(self._runUntilList) do
		if (v.id == id) then
			return true
		end
	end
	return false
end

-- 为一个音效ID清除效果, 并且选择是否要调用其完成回调函数
function AudioEffectHelper:clearEffectForId(id, isToCallCB)
	if (isToCallCB == nil) then isToCallCB = true end
	for i = #self._runUntilList, 1, -1 do
		local entry = self._runUntilList[i]
		if (entry.id == id) then
			table.remove(self._runUntilList, i)
			if (isToCallCB and entry.cbFunc) then entry.cbFunc() end
		end
	end
end

-- 为一个音效ID设置其在特效中的音量总控(比如在渐入中的最终音量和渐出中的初始音量)
function AudioEffectHelper:setMasterVolumeForId(id, volume)
	for i,v in ipairs(self._runUntilList) do
		if (v.id == id) then
			v.masterVolume = volume
		end
	end
end
--eo杂用方法------------------------------------------------------






return AudioEffectHelper
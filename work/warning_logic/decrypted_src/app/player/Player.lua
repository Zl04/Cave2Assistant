--[[
    播放器
]]--

Player = Player or {}

local Base = class("PlayerBase")
Player.Base = Base

-- private:
-- 构造函数
function Base:ctor()
    self._audioIdCache = {}
end

-- 析构函数
function Base:dtor()
    self._audioIdCache = nil
end

-- public:
-- 销毁
function Base:destroy()
    self:dtor()
end

-- 执行音效命令
function Base:execute(command)
    self:onExecute(command)
end

-- 模版方法：执行音效命令
function Base:onExecute(command)
    assert(false, "[ERROR] Player onExecute: this method should be overrided by sub class.")
end

-- 播放音效
function Base:play(audioFile, loop, volume)
    local audioId = self._audioIdCache[audioFile]
    if (audioId) then
        self:stop(audioFile)
    end 

    audioId = ccexp.AudioEngine:play2d(audioFile, loop, volume)
    if (audioId) then
        ccexp.AudioEngine:setFinishCallback(audioId, function(audioId, audioFile)
            self._audioIdCache[audioFile] = nil
        end)
        self._audioIdCache[audioFile] = audioId
    else
        assert(false, string.format("[ERROR] Player play: could not play audio file %s.", audioFile))
    end
end

-- 暂停音效
function Base:pause(audioFile)
    local audioId = self._audioIdCache[audioFile]
    if (audioId) then
        ccexp.AudioEngine:pause(audioId)
    else
        print(string.format("[WARNING] AudioPlayer pause: could not pause audio file %s.", audioFile))
    end
end

-- 恢复音效
function Base:resume(audioFile)
    local audioId = self._audioIdCache[audioFile]
    if (audioId) then
        ccexp.AudioEngine:resume(audioId)
    else
        print(string.format("[WARNING] AudioPlayer resume: could not resume audio file %s.", audioFile))
    end
end

-- 停止音效
function Base:stop(audioFile)
    local audioId = self._audioIdCache[audioFile]
    if (audioId) then
        ccexp.AudioEngine:stop(audioId)
        self._audioIdCache[audioFile] = nil
    else
        print(string.format("[WARNING] AudioPlayer stop: could not stop audio file %s.", audioFile))
    end
end






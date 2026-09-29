-- --[[

-- Copyright (c) 2011-2014 chukong-inc.com

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

-- ]]

-- require "app.config.ConfigManager"

-- local audio = {}

-- local engine = cc.SimpleAudioEngine:getInstance()


-- --是否播放背景音乐
-- audio.mPlayMusic = cc.UserDefault:getInstance():getBoolForKey("playMusic",true)
-- --是否播放音效
-- audio.mPlaySounds = cc.UserDefault:getInstance():getBoolForKey("playSounds",true)


-- --背景音乐音量
-- audio.mMusicVolume = cc.UserDefault:getInstance():getFloatForKey("musicVolume",1.0)
-- --音效音量
-- audio.mSoundsVolume = cc.UserDefault:getInstance():getFloatForKey("soundsVolume",1.0)


-- print("audio.mPlayMusic",audio.mPlayMusic,"audio.mPlaySounds",audio.mPlaySounds,audio.mMusicVolume,audio.mSoundsVolume)

-- --当前音乐状态 (为了修复模拟器和真机 isMusicPlaying 获取的暂停状态不统一的BUG)
-- audio.mMusicPaused = false
-- --当前背景音乐
-- audio.mMusicPath = ""
-- --背景音乐列表
-- audio.mMusicList = {}
-- --音效列表
-- audio.mSoundList = {}

-- --播放背景音乐
-- function audio.setPlayMusic(value)
--     print("audio:setPlayMusic", audio.mPlayMusic, value)

--     -- 参数检查
--     if audio.mPlayMusic == value then return end
--     audio.mPlayMusic = value

    
--     if value then
--         -- 设置打开音乐
--         if (audio.mMusicPaused) then
--             -- 如果音乐是暂停了, 恢复音乐
--             audio.resumeMusic()
--         else
--             -- 如果音乐不是暂停了, 播放现在应该播放的音乐
--             audio.playMusic(audio.mMusicPath)
--         end
--     else
--         -- 设置关闭音乐用暂停实现
--         audio.pauseMusic()
--     end
    
--     -- 记录音乐设置
--     cc.UserDefault:getInstance():setBoolForKey("playMusic", audio.mPlayMusic)
--     cc.UserDefault:getInstance():flush()
-- end


-- --播放音效
-- function audio.setPlaySounds(value)
--     if audio.mPlaySounds == value then return end

--     audio.mPlaySounds = value
--     if not value then audio.stopAllSounds() end

--     cc.UserDefault:getInstance():setBoolForKey("playSounds", audio.mPlaySounds)
--     cc.UserDefault:getInstance():flush()
-- end


-- function audio.getMusicVolume()
--     -- local volume = engine:getMusicVolume()
--     -- if DEBUG > 1 then
--     --     printf("[audio] getMusicVolume() - volume: %0.2f", volume)
--     -- end

--     return audio.mMusicVolume 
-- end



-- function audio.setMusicVolume(volume)
--     -- 检查参数和减少精度
--     volume = checknumber(volume)
--     volume = tonumber(string.format("%.2f", volume))
--     if volume == audio.mMusicVolume then return end

    
--     if volume ~= 0 and audio.mMusicVolume == 0 then
--         audio.setPlayMusic(true)
--     end

--     if volume == 0 and audio.mMusicVolume ~= 0 then
--         audio.setPlayMusic(false)
--     end

--     engine:setMusicVolume(volume)
--     audio.mMusicVolume = volume

--     cc.UserDefault:getInstance():setFloatForKey("musicVolume", audio.mMusicVolume)
--     cc.UserDefault:getInstance():flush()
-- end




-- function audio.preloadMusic(filename)
--     assert(filename, "audio.preloadMusic() - invalid filename")
--     if DEBUG > 1 then
--         printf("[audio] preloadMusic() - filename: %s", tostring(filename))
--     end

--     if table.keyof(audio.mMusicList,filename) == nil then
--         table.insert(audio.mMusicList,filename)
--     end

--     filename = "sound/"..filename..".mp3"

--     engine:preloadMusic(filename)
-- end

-- function audio.playMusic(filename, isLoop)
--     -- 参数检查
--     filename = tostring(filename)
--     assert(filename, "audio.playMusic() - invalid filename")
--     if type(isLoop) ~= "boolean" then isLoop = true end

--     -- 设置新音乐文件名 (无论开关开启关闭都需要更新现在播放的音乐, 因为在打开总开关后会播放新的音乐)
--     local oldMusicPath = audio.mMusicPath
--     audio.mMusicPath = filename

--     -- 取消暂停 (在打开音乐播放的时候不恢复之前暂停的音乐而是重新播放音乐)
--     audio.mMusicPaused = false

--     -- 开关检查
--     if not audio.mPlayMusic or (audio.isMusicPlaying() and audio.mMusicPath == oldMusicPath) then return end    
    
--     -- 加入音乐列表
--     if table.keyof(audio.mMusicList,filename) == nil then table.insert(audio.mMusicList,filename) end

--     -- 播放音乐
--     filename = "sound/"..filename..".mp3"
--     audio.stopMusic()
--     audio.setMusicVolume(audio.mMusicVolume)
--     engine:playMusic(filename, isLoop)
-- end

-- function audio.playMusicByConfig(caveMode, level, isLoop)
--     if DEBUG > 1 then
--         print("audio.playMusicByConfig",caveMode,level, isLoop)
--     end

--     local pAudioConfig = ConfigManager:getAudioConfig(string.format("%d%02d%d",24,tonumber(caveMode),tonumber(level)))

--     if pAudioConfig then
--         audio.playMusic(pAudioConfig.path, isLoop)
--     else
--         audio.playMusic("10002", isLoop)
--     end
-- end

-- function audio.stopMusic(isReleaseResource)
--     isReleaseResource = checkbool(isReleaseResource)
--     engine:stopMusic(isReleaseResource)
--     -- audio.mMusicPath = "";
-- end

-- function audio.pauseMusic()
--     if DEBUG > 1 then
--         printf("[audio] pauseMusic()")
--     end
--     engine:pauseMusic()
--     audio.mMusicPaused = true
-- end

-- function audio.resumeMusic()
--     if DEBUG > 1 then
--         printf("[audio] resumeMusic()")
--     end
--     engine:resumeMusic()
--     audio.mMusicPaused = false
-- end

-- function audio.rewindMusic()
--     if DEBUG > 1 then
--         printf("[audio] rewindMusic()")
--     end
--     engine:rewindMusic()
-- end

-- function audio.isMusicPlaying()
--     local ret = engine:isMusicPlaying()
--     if DEBUG > 1 then
--         printf("[audio] isMusicPlaying() - ret: %s", tostring(ret))
--     end
--     return ret
-- end

-- function audio.getSoundsVolume()
--     return audio.mSoundsVolume
-- end

-- function audio.setSoundsVolume(volume)
--     volume = checknumber(volume)
--     volume = tonumber(string.format("%.2f", volume))
--     if volume == audio.mSoundVolume then return end
--     printf("[audio] setSoundsVolume() - volume: %f - mSoundsVolume: %f", volume, audio.mSoundsVolume)


--     if volume ~= 0 and audio.mSoundsVolume == 0 then
--         audio.setPlaySounds(true)
--     end

--     if volume == 0 and audio.mSoundsVolume ~= 0 then
--         audio.setPlaySounds(false)
--     end

--     engine:setEffectsVolume(volume)
--     audio.mSoundsVolume = volume
--     cc.UserDefault:getInstance():setFloatForKey("soundsVolume", audio.mSoundsVolume)
--     cc.UserDefault:getInstance():flush()
-- end

-- function audio.playSound(filename, isLoop)
--     -- 参数检查
--     filename = tostring(filename)
--     assert(filename)
--     if type(isLoop) ~= "boolean" then isLoop = false end

--     -- 开关检查
--     if not audio.mPlaySounds then return end
    
--     -- print("[audio] playSound() - filename: %s, isLoop: %s", tostring(filename), tostring(isLoop))

--     -- 添加到声音列表
--     if table.keyof(audio.mSoundList,filename) == nil then
--         table.insert(audio.mSoundList,filename)
--     end

--     -- 播放音效
--     filename = "sound/"..filename..".mp3"
--     -- audio.setSoundsVolume(audio.mSoundsVolume)
--     return engine:playEffect(filename, isLoop)
-- end

-- function audio.playSoundDelay(file,time, isLoop)
--     performWithDelay(cc.Director:getInstance():getRunningScene(), function()
--         audio.playSound(file, isLoop)
--     end, time/1000.0)
-- end


-- function audio.playSoundByConfigID(id, isLoop)
--     local pAudioConfig = ConfigManager:getAudioConfig(id)

--     if pAudioConfig then
--         audio.playSoundDelay(pAudioConfig.path,pAudioConfig.timing, isLoop)
--     end
-- end

-- function audio.playSoundByConfig(type, id, isLoop)
--     local pAudioConfig = ConfigManager:getAudioConfig(tostring(type)..tostring(id))

--     if pAudioConfig then
--         -- print("audio.playSoundByConfig11111",pAudioConfig.path)
--         -- performWithDelay(cc.Director:getInstance():getRunningScene(), function()
--         --     audio.playSound(pAudioConfig.path, isLoop)
--         -- end, pAudioConfig.timing/1000.0)

--         audio.playSoundDelay(pAudioConfig.path,pAudioConfig.timing, isLoop)
--     end
-- end

-- function audio.pauseSound(handle)
--     if not handle then
--         printError("audio.pauseSound() - invalid handle")
--         return
--     end
--     if DEBUG > 1 then
--         printf("[audio] pauseSound() - handle: %s", tostring(handle))
--     end
--     engine:pauseEffect(handle)
-- end

-- function audio.pauseAllSounds()
--     if DEBUG > 1 then
--         printf("[audio] pauseAllSounds()")
--     end
--     engine:pauseAllEffects()
-- end

-- function audio.resumeSound(handle)
--     if not handle then
--         printError("audio.resumeSound() - invalid handle")
--         return
--     end
--     if DEBUG > 1 then
--         printf("[audio] resumeSound() - handle: %s", tostring(handle))
--     end
--     engine:resumeEffect(handle)
-- end

-- function audio.resumeAllSounds()
--     if DEBUG > 1 then
--         printf("[audio] resumeAllSounds()")
--     end
--     engine:resumeAllEffects()
-- end

-- function audio.stopSound(handle)
--     if not handle then
--         printError("audio.stopSound() - invalid handle")
--         return
--     end
--     if DEBUG > 1 then
--         printf("[audio] stopSound() - handle: %s", tostring(handle))
--     end
--     engine:stopEffect(handle)
-- end

-- function audio.stopAllSounds()
--     if DEBUG > 1 then
--         printf("[audio] stopAllSounds()")
--     end
--     engine:stopAllEffects()
-- end
-- audio.stopAllEffects = audio.stopAllSounds

-- function audio.preloadSound(filename)
--     if not filename then
--         printError("audio.preloadSound() - invalid filename")
--         return
--     end
--     if DEBUG > 1 then
--         printf("[audio] preloadSound() - filename: %s", tostring(filename))
--     end

--     if table.keyof(audio.mSoundList,filename) == nil then
--         table.insert(audio.mSoundList,filename)
--     end

--     filename = "sound/"..filename..".mp3"

--     engine:preloadEffect(filename)
-- end

-- function audio.unloadSound(filename)
--     if not filename then
--         printError("audio.unloadSound() - invalid filename")
--         return
--     end
--     if DEBUG > 1 then
--         printf("[audio] unloadSound() - filename: %s", tostring(filename))
--     end
--     local key = table.keyof(audio.mSoundList,filename)
--     if key then
--         table.remove(audio.mSoundList,key)
--     end

--     engine:unloadEffect(filename)
-- end

-- audio.setMusicVolume(audio.mMusicVolume)
-- audio.setSoundsVolume(audio.mSoundsVolume)
-- print("engine:getMusicVolume()",engine:getMusicVolume())
-- print("engine:getEffectsVolume()",engine:getEffectsVolume())


-- return audio

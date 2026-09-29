-- 
-- 天气系统管理
-- yys
-- 

local WeatherManager = class("WeatherManager")
g_WeatherManager = nil;

local WEATHER_TYPE = {
    DEFAULT = 0,
    FOREVER = 1,
    ONCE = 2
}

function WeatherManager:getInstance()
    if g_WeatherManager == nil then
       g_WeatherManager = WeatherManager.new()
    end
    return g_WeatherManager;
end

function WeatherManager:ctor()
    self._view = cc.Layer:create();
    self._view:retain();

    self._weatherSoundHandle = nil;
    self._weatherID = 0;
    self._oldWeaterID = -1;
    self._schedulerID = nil
end
function WeatherManager:dtor()
    self._view:release()
    --
end
function WeatherManager:clear()
    -- body
end
-- 更新天气效果ID
function WeatherManager:updateWeatherId(id)
    
    
    self._oldWeaterID = self._weatherID
    
    self._weatherID = checkint(id)
    if self._schedulerID ~= nil then
         cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._schedulerID)
        self._schedulerID = nil
    end
    local weather = Config.Weather:getWeatherById(self._weatherID)
    if weather == nil then
        return
    end
    if weather.type == WEATHER_TYPE.FOREVER or weather.type == WEATHER_TYPE.ONCE then
        self:updateWeaterEffect()
        local time = math.random(weather.interval[1] or 0, weather.interval[2] or 0)
        if time ~= 0 then
            self._schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update), time, false)
        end
    else
        self:updateWeaterEffect()
    end
end

function WeatherManager:update()
    local weather = Config.Weather:getWeatherById(self._weatherID)
    if weather and (weather.type == WEATHER_TYPE.FOREVER or weather.type == WEATHER_TYPE.ONCE) then
        if self._schedulerID ~= nil then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._schedulerID)
            self._schedulerID = nil
        end
        local time = math.random(weather.interval[1] or 0, weather.interval[2] or 0)
        if time ~= 0 then
            self._schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update), time, false)
        end
    end
    self:updateWeaterEffect()
end
-- 更新天气效果
function WeatherManager:updateWeaterEffect()
    self._view:setVisible(GameManager:getCustomHQ(CUSTOM_HQ_TYPE.WEATHER))
    
    if self._weatherID <= 0 and self._oldWeaterID <= 0 then
        print("未设置天气特效ID")
        return 
    end
    local weather = Config.Weather:getWeatherById(self._weatherID)
    if weather == nil then
        return
    end
    -- if weather.type == WEATHER_TYPE.DEFAULT and self._oldWeaterID == self._weatherID then
    --     print("新设置天气特效ID与上一个相同",self._oldWeaterID , self._weatherID)
    --     return
    -- end
    self._view:removeAllChildren()
    self:stopSound()
    if self._weatherID <= 0 then
        print("未设置天气特效ID")
        return 
    end
    
    if weather.spine == "0" then
        print("该天气未配置效果")
        return
    end
    
    print("播放新的天气特效 ",self._weatherID)
    local winSize = cc.Director:getInstance():getWinSize()
    if weather.baseaction ~= "" and weather.baseaction ~= nil then
        local effect = Avalon.Animation:create(string.format("%s.json",weather.spine), string.format("%s.atlas",weather.spine), 1.0);
        effect:setAnimation(0, weather.baseaction, true)
        effect:setPosition(cc.p(winSize.width/2, winSize.height/2))
        self._view:addChild(effect)
        effect:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- 播放音效文件
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playSound(soundFilename, false)
                end

                local shakePos = string.find(event.eventData.name, "hitshake_")
                if(shakePos ~= nil) then
                    -- 播放抖动
                    local shake = string.sub(event.eventData.name,10,-1)
                    if(shake) then 
                        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                    end
                end
            end
        end, sp.EventType.ANIMATION_EVENT)
    end
    
    if weather.specialaction ~= "" and weather.specialaction ~= nil then
        if #weather.randomnum >= 2 then
            local list = string.split(weather.specialaction, ",")
            local showNumber = math.random(weather.randomnum[1], weather.randomnum[2])
            -- print("--------showNumber = ", showNumber)
            showNumber = showNumber < 0 and 0 or showNumber
            for i = 1, showNumber do
                local index =  math.random(1, #list)
                local actName = list[index]
                -- print("-----actName---", index, actName)
                if actName ~= nil and actName ~= "" then
                    local effect = Avalon.Animation:create(string.format("%s.json",weather.spine), string.format("%s.atlas",weather.spine), 1.0)
                    if weather.randomCoordinate == 1 then
                        math.randomseed(AvalonUtil.getCurrentTime() / i)
                        local percent = math.random(4, 6) / 10
                        effect:setPosition(cc.p(winSize.width * percent, winSize.height * percent))
                        Avalon.Scheduler:scheduleUpdateOnce(self, function()
                            if effect ~= nil and not tolua.isnull(effect) then
                                effect:setAnimation(0, actName, false)
                            end
                        end, (percent + 2.1) * (i - 1))  
                    else
                        effect:setPosition(cc.p(winSize.width/2, winSize.height/2))
                        if weather.type == WEATHER_TYPE.FOREVER then
                            effect:setAnimation(0, actName, true)
                        else
                            effect:setAnimation(0, actName, false)
                        end
                    end
                    


                    effect:registerSpineEventHandler(function (event)
                        if(event and event.eventData and event.eventData.name) then
                            local startPos = string.find(event.eventData.name, "sound_")
                            if(startPos ~= nil) then
                                -- 播放音效文件
                                local soundFilename = string.sub(event.eventData.name,7,-1)
                                Avalon.AudioManager:playSound(soundFilename, false)
                            end

                            local shakePos = string.find(event.eventData.name, "hitshake_")
                            if(shakePos ~= nil) then
                                -- 播放抖动
                                local shake = string.sub(event.eventData.name,10,-1)
                                if(shake) then 
                                    Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                                end
                            end
                        end
                    end, sp.EventType.ANIMATION_EVENT)
                    self._view:addChild(effect)
                end
                if weather.randomCoordinate ~= 1 then
                    table.remove(list, index)
                end
            end
        end

    end 
    self._weatherSoundHandle = Avalon.AudioManager:playSound(weather.sound, true)
end
-- 添加天气效果
function WeatherManager:loadWeaterSystem()
    self:update()
    return self._view;
end
-- 卸载天气效果
function WeatherManager:unloadWeaterSystem()
    self._view:removeFromParent(false)
    self:stopSound()
    if self._schedulerID ~= nil then
         cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._schedulerID)
        self._schedulerID = nil
    end
end

function WeatherManager:stopSound()
    if self._weatherSoundHandle then
        Avalon.AudioManager:stopSound(self._weatherSoundHandle)
        self._weatherSoundHandle = nil
    end
end

function WeatherManager:hideWeather()
    if self._view and not tolua.isnull(self._view) then
        self._view:setVisible(false)
    end
end

return WeatherManager
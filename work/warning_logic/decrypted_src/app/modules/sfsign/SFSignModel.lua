--[[--
数据模型SFSignModel
该类自动生成 通过set  get 获取数据 暂无安全检查,通过bind unbind 进行数据绑定
可以发送消息 
所有model中需要定义的属性，必须在initData中进行声明
]]

------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2020/01/08
--desc	: SFSignModel
------------------------------------------------------------------------------

local SFSignModel = class("SFSignModel",mvc.GameModel)

local LanguageManager = require("app.game.LanguageManager")

-- 这里控制是否打开春节签到
local OPEN_SFSIGN = false

function SFSignModel:initData()
    self.cfg = {}
    self.sortedCfg = nil
    self.signedDay = nil
end

function SFSignModel:receiveSvrData(data)
    if(OPEN_SFSIGN) then
        self.signedDay = data
        self:initConfig()
    end
end

function SFSignModel:updateSignedDay(day)
    if OPEN_SFSIGN then
        table.insert(self.signedDay, day)

        Avalon.MessageCenter:notice(GameMessage.MC_UI_SFSIGN_SIGN_OK, day)
    end
end

function SFSignModel:getOpenSFSign()
    if OPEN_SFSIGN then
        local nowStatus = true
        if CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE then
            nowStatus = false
            local todayDate = os.date("!*t", GameManager:getNowServerTime())
            if (tonumber(todayDate.year) == 2024 and tonumber(todayDate.month) > 1) or 
                (tonumber(todayDate.year) == 2024 and tonumber(todayDate.month) == 1 and tonumber(todayDate.day) >= 26) then
                nowStatus = true
            end
        end
        
        return nowStatus

        -- return true
    else
        return false 
    end
end

function SFSignModel:initConfig()
    if self.sortedCfg then
        return
    end

    local cfg = nil
    if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        self.cfg = require("profiles/commonProfile/ProfileFestivalSign_gl")
    else
        self.cfg = require("profiles/commonProfile/ProfileFestivalSign_cn")
    end

    self.sortedCfg = {}
    for k, v in pairs(self.cfg) do
        if k ~= "size" then
            table.insert(self.sortedCfg, v)
        end
    end

    table.sort(self.sortedCfg, function(a, b)
        return a.ID < b.ID
    end)
end

function SFSignModel:canSign()
    if not self.sortedCfg then
        self:initConfig()
    end

    for k, v in ipairs(self.sortedCfg) do
        if self:getSignState(v.ID) == 4 then
            return true
        end
    end

    return false
end

function SFSignModel:getAllDays()
    local allDays = {}
    for k, v in ipairs(self.sortedCfg) do
        local one = {}
        one.cfg = v
        one.date = self:getDate(tonumber(v.ID))
        one.signState = self:getSignState(v.ID)  -- 1:过去已签，2:过去未签，3:今日已签，4:今日未签，5:未来
        one.dayState = self:getDayState(one.date)
        one.idx = k

        local leftStr = ""
        for m, id in ipairs(v.advantage) do
            leftStr = leftStr .. LanguageManager:getInstance():getLocalString(id)

            if m ~= #v.advantage then
                leftStr = leftStr .. "\n"
            end
        end
        one.txtLeft = leftStr

        local rightStr = ""
        for m, id in ipairs(v.disadvantage) do
            rightStr = rightStr .. LanguageManager:getInstance():getLocalString(id)

            if m ~= #v.disadvantage then
                rightStr = rightStr .. "\n"
            end
        end
        one.txtRight = rightStr

        local upStr = ""
        if v.olddate > 0 then
            upStr = LanguageManager:getInstance():getLocalString(v.olddate)
        end
        one.txtUp = upStr

        local downStr = ""
        if #v.extraDesc > 0 then
            downStr = LanguageManager:getInstance():getLocalString(v.extraDesc[1]) .. "\n" .. 
                LanguageManager:getInstance():getLocalString(v.extraDesc[2])
        end
        one.txtDown = downStr

        table.insert(allDays, one)
    end

    return allDays
end

function SFSignModel:getDate(num)
    local date = {}
    date.year = math.floor(num/10000)
    date.month = math.floor(num%10000/100)
    date.day = num%100
    return date
end

-- 1:过去，2:今天，3:未来
function SFSignModel:getDayState(thisDate)
    local thisStamp = os.time{year = thisDate.year, month = thisDate.month, day = thisDate.day, hour = 1}

    local todayDate = os.date("!*t", GameManager:getNowServerTime())
    local todayStamp = os.time{year = todayDate.year, month = todayDate.month, day = todayDate.day, hour = 0}
    local tomorrowStamp = todayStamp + 24*60*60
    if thisStamp < todayStamp then
        return 1
    elseif thisStamp >= todayStamp and thisStamp < tomorrowStamp then
        return 2
    else
        return 3
    end
end

-- 1:过去已签，2:过去未签，3:今日已签，4:今日未签，5:未来
function SFSignModel:getSignState(id)
    local signed = false
    for k, v in ipairs(self.signedDay) do
        if v == id then
            signed = true
            break
        end
    end

    if self:getDayState(self:getDate(id)) == 1 then
        -- 过去
        return signed and 1 or 2
    elseif self:getDayState(self:getDate(id)) == 2 then
        -- 今日
        return signed and 3 or 4
    else
        -- 未来
        return 5
    end
end


return SFSignModel
-- EmailBindData.lua
-- Author:zp
-- 2017年12月18日
-- Using:邮箱绑定数据

require "app.datas.GameData"
local LanguageManager = require("app.game.LanguageManager")

local EmailBindData = class("EmailBindData")

Data = Data or {}
Data.EmailBindData = EmailBindData

function EmailBindData:ctor()
    self.isBind = false

    self._sendEmailTime = 0
end

function EmailBindData:init()

end

function EmailBindData:initNet(data)
    
end

function EmailBindData:clearCount()
    self.isBind = false
end

function EmailBindData:updateCount(data)
    print("EmailBindData:updateCount", data)
    self.isBind = data.isBind
    UI.WaitingLayer:hideWaiting() 
end

function EmailBindData:getKeyList()
    local keyList = {}

   return keyList
end

function EmailBindData:updateLanguageKeyToStr()
    
end

function EmailBindData:getIsBind()
    return self.isBind
end

function EmailBindData:getSendEmailTime()
    return self._sendEmailTime
end

function EmailBindData:setSendEmailTime(time)
    self._sendEmailTime = time
end




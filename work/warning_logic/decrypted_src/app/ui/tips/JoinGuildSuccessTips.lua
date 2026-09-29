-- JoinGuildSuccessTips.lua
-- Author:zp
-- 2017年9月20日
-- Using:加入公会成功界面

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local JoinGuildSuccessTips = class("JoinGuildSuccessTips",UI.HWBtnComponent)
UI.JoinGuildSuccessTips = JoinGuildSuccessTips
--  ui_tips_team
local VOTE_SUCCEED_TIPS_PLIST = {
}

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    self:close();
end

--  构造函数
function JoinGuildSuccessTips:ctor()
    JoinGuildSuccessTips.super.ctor(self,UIType.JOIN_GUILD_SUCCESS_TIPS,VOTE_SUCCEED_TIPS_PLIST,0,0)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
end

--  析构函数 调用父类的方法
function JoinGuildSuccessTips:dtor()
    JoinGuildSuccessTips.super.dtor(self)
end

--  初始化函数
function JoinGuildSuccessTips:init()
    JoinGuildSuccessTips.super.init(self)
    
end

--  初始化界面函数
function JoinGuildSuccessTips:onInitView()
    self:setTouchEnable(true)
    self:setInterceptTouches(true)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)

    local finishedAnimal  = UI.Animation:create()
    finishedAnimal:init("effect_ui_general_guild_initiation.json","effect_ui_general_guild_initiation.atlas")
    finishedAnimal:center()
    finishedAnimal:setAnimation("begin_1", false)
    finishedAnimal:addAnimation("end_1", false)
    self:addChild(finishedAnimal)

    finishedAnimal:addEventListener(UIEvent.ANIMATION_END,self,function(self, event)
        print("addEventListener(UIEvent.ANIMATION_END", event.animation)
        local startPos = string.find(event.animation, "end_1")
        if (startPos ~= nil) then
            finishedAnimal:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.RemoveSelf:create()))
        end
    end)

    finishedAnimal:addEventListener(UIEvent.ANIMATION_EVENT,self,function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "shock_screen")
            if(startPos ~= nil) then
                -- TODO 添加文字

            end
        end
    end)
    
end

-- 传递回调函数名字
function JoinGuildSuccessTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end

-- 更新视图
function JoinGuildSuccessTips:onUpdateView()

end
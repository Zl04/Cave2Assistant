-- GuildCreateOrJoinTips.lua
-- Author:zp
-- 2018年9月19日
-- Using:加入或创建公会成功的表现

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local GuildCreateOrJoinTips = class("GuildCreateOrJoinTips",UI.HWBtnComponent)
UI.GuildCreateOrJoinTips = GuildCreateOrJoinTips
--  ui_tips_team
local VOTE_SUCCEED_TIPS_PLIST = {
}

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    self:close();
end

--  构造函数
function GuildCreateOrJoinTips:ctor()
    GuildCreateOrJoinTips.super.ctor(self,UIType.JOIN_GUILD_SUCCESS_TIPS,VOTE_SUCCEED_TIPS_PLIST,0,0)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
end

--  析构函数 调用父类的方法
function GuildCreateOrJoinTips:dtor()
    GuildCreateOrJoinTips.super.dtor(self)
    -- print("GuildCreateOrJoinTips dtor", self._okCallFun)
    if(self._okCallFun) then
        self._okCallFun()
    end
end

--  初始化函数  type:1 创建公会成功， 2 加入公会成功
function GuildCreateOrJoinTips:init(type)
    self._type = type
    GuildCreateOrJoinTips.super.init(self)
end

--  初始化界面函数
function GuildCreateOrJoinTips:onInitView()
    Avalon.AudioManager:playSound("1536")

    self:setTouchEnable(true)
    self:setInterceptTouches(true)

    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)

    local finishedAnimal  = UI.Animation:create()
    finishedAnimal:init("effect_ui_general_guild_initiation.json","effect_ui_general_guild_initiation.atlas")
    finishedAnimal:center()
    finishedAnimal:setAnimation("begin_1", false)
    finishedAnimal:addAnimation("end_1", false)
    self:addChild(finishedAnimal)

    local nameStr = ""
    if(self._type == 1) then 
        nameStr = UI.TEXT_1172017
    else
        nameStr = LanguageManager:getInstance():getLocalString(1110524)
    end
    -- print("nameStr=", nameStr)
    local name = UI.Text:create()
    name:init(nameStr, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_194_194_194)
    name:center()
    finishedAnimal:addChild(name)
    name:setVisible(false)

    local this = self
    finishedAnimal:addEventListener(UIEvent.ANIMATION_END,self,function(self, event)
        -- print("addEventListener(UIEvent.ANIMATION_END", event.animation)
        local startPos = string.find(event.animation, "end_1")
        if (startPos ~= nil) then
            -- finishedAnimal:runAction(cc.RemoveSelf:create())
            finishedAnimal:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
                this:runAction(cc.RemoveSelf:create())
            end)))
        end
    end)

    finishedAnimal:addEventListener(UIEvent.ANIMATION_EVENT,self,function (self, event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "shock_screen")
            if(startPos ~= nil) then
                -- TODO 添加文字
                name:setVisible(true)
            end
        end
    end)
end

-- 传递回调函数名字
function GuildCreateOrJoinTips:callfunName(okCallFun,cancelCallFun)  
    print("GuildCreateOrJoinTips:callfunName", okCallFun)
    self._okCallFun = okCallFun
end

-- 更新视图
function GuildCreateOrJoinTips:onUpdateView()

end
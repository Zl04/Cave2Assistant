------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2020/05/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FullScreeenEffectView = class("FullScreeenEffectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_levelselect.plist",
    "ui_town_expedition.plist",
    "ui_town_guild_writ.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function FullScreeenEffectView:ctor(data)
    FullScreeenEffectView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._data = data
end

function FullScreeenEffectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.fullscreeen", "FullScreeen", false)
    FullScreeenEffectView.super.init(self, ... )
    self:setTouchEnable(false)
    self:setInterceptTouches(false)
end

function FullScreeenEffectView:dtor()
    FullScreeenEffectView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.fullscreeen.FullScreeenEffectView")
end


function FullScreeenEffectView:onInitView()
    if(self._data == nil) then 
        return
    end
    local pauseConfig = ConfigManager:getPauseSenceByID(self._data.displayID)
    if(pauseConfig == nil) then 
        return
    end

    local roleEffect = UI.Animation:create()
    roleEffect:init(pauseConfig.senceAnimName..".json", pauseConfig.senceAnimName..".atlas")
    -- roleEffect:centerLeft(168)
    roleEffect:center()
    roleEffect:setAnimation("idle", false)
    self:addChild(roleEffect, 11)

    roleEffect:addEventListener(UIEvent.ANIMATION_END, self,function(event)
        self:runAction(
            cc.RemoveSelf:create()
        )
    end, sp.EventType.ANIMATION_END)
end


function FullScreeenEffectView:bindModel()

end


function FullScreeenEffectView:unbindModel()

end





return FullScreeenEffectView













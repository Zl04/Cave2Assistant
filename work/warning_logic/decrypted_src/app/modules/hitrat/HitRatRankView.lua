------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/10
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local HitRatRankView = class("HitRatRankView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {}

local COM_WIDTH = 250
local COM_HEIGHT = 110

function HitRatRankView:ctor()
    HitRatRankView.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
    self:center()
end

function HitRatRankView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.hitrat", "HitRat", false)
    HitRatRankView.super.init(self, ...)
end

function HitRatRankView:dtor()
    HitRatRankView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.hitrat.HitRatRankView")
end

function HitRatRankView:changeName()
    local rankInfo = mvc.hitRatModel:getScoreRank()
    for i = 1, #rankInfo do
        self["name" ..i]:setText(rankInfo[i].name)
        self["score" ..i]:setText(rankInfo[i].score)
    end
end

function HitRatRankView:onInitView()
    local eff1 = UI.Animation:create()
    eff1:init("effect_ui_gaming_hitrat_paiming.json", "effect_ui_gaming_hitrat_paiming.atlas", 1)
    self:addChild(eff1)
    eff1:center()
    eff1:setAnimation("idle1", true)

    local text = UI.Text:create()
    text:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    text:center()
    eff1:addComponent("mingzi1", text,true)
    self.name1 = text

    local text = UI.Text:create()
    text:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    text:center()
    eff1:addComponent("mingzi2", text,true)
    self.name2 = text

    local text = UI.Text:create()
    text:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 235,  g = 230,  b = 201})
    text:center()
    eff1:addComponent("shuzi1", text,true)
    self.score1 = text

    local text = UI.Text:create()
    text:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 235,  g = 230,  b = 201})
    text:center()
    eff1:addComponent("shuzi2", text,true)
    self.score2 = text

    eff1:addEventListener(
        UIEvent.ANIMATION_EVENT,
        self,
        function(sender, event)
            if (event and event.eventData) then
                if event.eventData.name == "changename" then
                    self:changeName()
                end
            end
        end
    )

    eff1:addEventListener(UIEvent.ANIMATION_END, self, function() 
        self.playing = false
        self:changeName()
    end)


    self.effect = eff1
    self:changeName()
end

function HitRatRankView:scoreInfoChanged(isChangedRank)
    if self.playing then
        return
    end
    if isChangedRank then
        self.playing = true
        self.effect:setAnimation("idle2", false)
    else
        self:changeName()
    end
end

function HitRatRankView:bindModel()
    mvc.hitRatModel:bind("scoreInfo",self, self.scoreInfoChanged)
end

function HitRatRankView:unbindModel()
    mvc.hitRatModel:unbind("scoreInfo",self, self.scoreInfoChanged)
end

return HitRatRankView

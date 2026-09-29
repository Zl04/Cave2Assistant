------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local HitRatRewardView = class("HitRatRewardView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_world_boss.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function HitRatRewardView:ctor()
    HitRatRewardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function HitRatRewardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.hitrat", "HitRat", false)
    HitRatRewardView.super.init(self, ... )
end

function HitRatRewardView:dtor()
    HitRatRewardView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.hitrat.HitRatRewardView")
end


function HitRatRewardView:onInitView()
    local tab = {
        {"ui_boss_box_1_que.png", 0.9},
        {"ui_boss_box_2_que.png", 0.8},
        {"ui_boss_box_2_que.png", 0.8},
        {"ui_boss_box_common_que.png", 0.7},
        {"ui_boss_box_common_que.png", 0.7}
    }

    for i = 1, #self.heroInfos do
        -- local heroData = GameDataManager:getInstance():getMaster()
        local heroData = self.heroInfos[i].heroData
        Avalon.WidgetUtil:getHead(
            self,
            heroData.heroData,
            heroData.wearEquipmentArr,
            self,
            handler(
                self,
                function(self, pic)
                    if self and not tolua.isnull(headAnimation) then
                        headAnimation:addComponent("box" .. i, pic, true)
                    end
                end
            ),
            true,
            tab[i][1],
            tab[i][2]
        )

        local com = self:createNameAndScore(heroData.heroData.nickName, self.heroInfos[i].damage)
        headAnimation:addComponent("name" .. i, com, true)
    end

end


function HitRatRewardView:bindModel()

end


function HitRatRewardView:unbindModel()

end





return HitRatRewardView













------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/05/17
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local WorldBossComfirmView = class("WorldBossComfirmView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
require("utils.UIUtil")

-- 资源
local COM_RES_LIST = {
    "ui_town_activity.plist"
}

local COM_WIDTH = 530
local COM_HEIGHT = 390
local layoutUtil
function WorldBossComfirmView:ctor()
    WorldBossComfirmView.super.ctor(self, UI.Type.TIPS, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:bindModel()
    layoutUtil = UIUtil:createAutoUILayout("WorldBossComfirmView", "app.modules.worldboss.WorldBossPosConfig", __EDIT_)
end

function WorldBossComfirmView:dtor()
    WorldBossComfirmView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.worldboss.WorldBossComfirmView")
end

function WorldBossComfirmView:onInitView()
    -- local spr = cc.Sprite:create("xxxx.png")
    -- spr:setOpacity(150)
    -- spr:setPosition(cc.p(COM_WIDTH / 2, COM_HEIGHT / 2))
    -- self:addChild(spr)

    local img = UI.Image:create()
    img:init('ui_boss_progressbar_bg.png')
    addChildAuto(layoutUtil, self, img, "img2")

    local img = UI.Image:create()
    img:init('ui_boss_progressbar_down.png')
    addChildAuto(layoutUtil, self, img, "img3")

    local img = UI.Image:create()
    img:init("ui_activity_mack.png")
    addChildAuto(layoutUtil, self, img, "img6")

    local img = UI.Image:create()
    img:init('ui_boss_progressbar_up.png')
    addChildAuto(layoutUtil, self, img, "img4")

    local com = UI.Component:create()
    com:init("ui_activity_boss__headframe_box.png")
    addChildAuto(layoutUtil, self, com, "img","center")

    local wearEquipmentDataArr = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
    local _wearEquipmentDataArr = clone(wearEquipmentDataArr)
    local pk = RoleDataManager:getMaster():getPK()
    Avalon.WidgetUtil:getHead(
        self,
        RoleDataManager:getHeroDataForPK(pk),
        _wearEquipmentDataArr,
        self,
        handler(
            self,
            function(self, pic)
                if self and not tolua.isnull(self) then
                    com:removeChildByName("heorIcon", true)
                    pic:setName("heorIcon")
                    pic:setPosition(0,4)
                    com:addChild(pic)
                end
            end
        ),
        true
    )

    local img = UI.Image:create()
    img:init("ui_activity_boss__headframe_box.png")
    addChildAuto(layoutUtil, self, img, "img","center")

    local comp = UI.Component:create()
    comp:init()
    addChildAuto(layoutUtil, self, comp, "img5")

    local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_boss_progressbar.png"))
    timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
    timer:setPercentage(0)
    comp:addChild(timer)
    timer:setAnchorPoint(0.5, 0.5)
    timer:setPosition(timer:getContentSize().width / 2, timer:getContentSize().height / 2)
    timer:rotate(180)
    timer:setScaleX(-1)
    self.timer = timer


    self.time = 15

    local percent = 100
    self.timer:setPercentage(percent)
    local action = cc.ProgressTo:create(self.time, 0) 
    self.timer:runAction(cc.Sequence:create(action, cc.CallFunc:create(function()
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            mvc.closePanel("WorldBoss", "WorldBossComfirm")
        end, 0.1)
    end)))

    
    -- local text = UI.Text:create()
    -- text:init(UI.TEXT_110001, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    -- addChildAuto(layoutUtil, self, text, "nameText", "center")
  
    local btn = UI.Button:create()
    btn:init('ui_btn_yes4_0.png', 'ui_btn_yes4_1.png')
    addChildAuto(layoutUtil, self, btn, 'ConfirmBtn', 'leftBottom')
    btn:addEventListener(
        UIEvent.BUTTON_CLICK,
        self,
        function()
            mvc.send(mvc.events.WorldBoss_Battle_Confirm)
        end
    )
end

function WorldBossComfirmView:bindModel()
end

function WorldBossComfirmView:unbindModel()
end

return WorldBossComfirmView

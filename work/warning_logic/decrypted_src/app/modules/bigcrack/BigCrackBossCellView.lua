------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigCrackBossCellView = class("BigCrackBossCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 230
local COM_HEIGHT = 84

function BigCrackBossCellView:ctor(campId, bgName)
    BigCrackBossCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.campId = campId or 1
    self.bgName = bgName
end

function BigCrackBossCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigcrack", "BigCrack", false)
    BigCrackBossCellView.super.init(self, ... )
end

function BigCrackBossCellView:dtor()
    BigCrackBossCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigcrack.BigCrackBossCellView")
end


function BigCrackBossCellView:onInitView()
    local bg = UI.Image:create()
    bg:init(self.bgName)
    bg:center()
    self:addChild(bg)

    local com = UI.Component:create()
    com:init()
    com:setSize(160, 35)
    com:setTouchEnable(true)
    com:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        local buffs = mvc.bigCrackModel:getBossBuffs(self.campId)
        if buffs and #buffs > 0 then
            mvc.openPanel("Common", "BuffTip", mvc.bigCrackModel:getBossBuffs(self.campId))
        end
    end)
    com:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        mvc.closePanel("Common", "BuffTip")
    end)
    com:centerBottom(9)
    self:addChild(com)

    


    self._booldTimer = UI.ProgressTimer:create()
    self._booldTimer:init(
        "ui_playerstate_me_blood1_00.png",
        "ui_playerstate_me_blood1_02.png",
        "ui_playerstate_me_blood1_01.png"
    )
    self._booldTimer:centerBottom(40)
    self._booldTimer:setPercent(30)
    self:addChild(self._booldTimer)
    local info = mvc.bigCrackModel:getbossInfos(self.campId)

    self.nameText = UI.Text:create()
	self.nameText:init(info.name or "", UI.FONT_STANDARD, 14, UI.FONT_COLOR_RED)
    if self.campId == PublicDefine.Camp.Blue then
        self.nameText:setFontColor(UI.FONT_COLOR_BLUE)
    end
	self.nameText:centerBottom(55)
    self:addChild(self.nameText)


    -- 生命值
    self._hpLabel = UI.Text:create()
    self._hpLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
    self._hpLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(-1, -2))
    self._hpLabel:setTextCenter()
    self._hpLabel:centerBottom(38)
    self:addChild(self._hpLabel, 100)
 


    local buffLayout = UI.Layout:create()
    buffLayout:init()
    buffLayout:enableAutoHeight()
    buffLayout:enableAutoWidth()
    buffLayout:centerBottom(9)
    self:addChild(buffLayout)

    self.buffLayout = buffLayout
    self:bloodUpdate()
    self:scheduleUpdateBuff()
end

function BigCrackBossCellView:bloodUpdate()
    local info = mvc.bigCrackModel:getbossInfos(self.campId)
    if info then
        self._booldTimer:setPercent(info.curHp/info.hp)
        self._hpLabel:setText(math.floor(info.curHp/info.hp * 100 + 0.5).."%")
    end
end

function BigCrackBossCellView:scheduleUpdateBuff()
    if tolua.isnull(self) then
        return
    end

    self:buffsUpdate(mvc.bigCrackModel:getBossBuffs(self.campId))
    
    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleUpdateBuff, 1)
end


function BigCrackBossCellView:buffsUpdate(buffsTab)
    self.buffLayout:removeChildren()
    self.buffLayout:clearComponentList()

    if not buffsTab or #buffsTab == 0 then
        return
    end
    local buffs = buffsTab or {}

    for i = 1, #buffs do
        local buffer = buffs[i]
        if buffer:getICON() then
            local sp = UI.Image:create()
            sp:init(buffer:getICON())
            if buffer.duration ~= -1 then
                buffTimer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("effect_buff_0.png"))
                buffTimer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
                buffTimer:setPercentage(
                    1.0 * (buffer:getTotalDuration() - buffer:getDuration()) / buffer:getTotalDuration() * 100
                )

                -- 持续时间
                local action = cc.ProgressTo:create(buffer:getDuration(), 100)

                buffTimer:runAction(action)
                local w,h = sp:getSize()
                buffTimer:setPosition(cc.p(w/2,h/2))
                sp:addChild(buffTimer)
            end
            sp:floatLeft(2)
            self.buffLayout:addComponent(sp)
        end
    end
    self.buffLayout:updateView()
end

function BigCrackBossCellView:bindModel()
    mvc.bigCrackModel:bind("bossInfos", self, self.bloodUpdate)
end


function BigCrackBossCellView:unbindModel()
    if mvc and mvc.bigCrackModel then
        mvc.bigCrackModel:unbind("bossInfos", self, self.bloodUpdate)
    end
end



return BigCrackBossCellView













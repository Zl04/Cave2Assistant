-- LevelSelectEventBtn.lua
-- Author:ydli
-- 2018年12月27日
-- Using:关卡选择界面btn 


UI = UI or {}
require("app.ui.town.levelSelect.LevelSelectBtn")
local LevelSelectEventBtn = class("LevelSelectEventBtn", UI.LevelSelectBtn)
UI.LevelSelectEventBtn = LevelSelectEventBtn

function LevelSelectEventBtn:ctor()
    LevelSelectEventBtn.super.ctor(self)
    self.state = SpineIconStatus.haveUnLocked
    self.normalName = nil
    self.selectName = nil
    self.isGray = false

    self.boxIcon = nil
    self._boxGradeName = nil

    self._boxGradeName = nil
end

function LevelSelectEventBtn:dtor()
    LevelSelectEventBtn.super.dtor(self)
end

-- public:
-- 初始化
function LevelSelectEventBtn:init(imageName)
    LevelSelectEventBtn.super.init(self)
    local bgIcon = nil
    if imageName ~= nil then
        bgIcon = UI.Image:create()
        bgIcon:init(imageName)
        bgIcon:setScale(0.8)
    else
        bgIcon = UI.Layout:create()
        bgIcon:init()
        bgIcon:setSize(90, 90)
    end
    bgIcon:center()
    self:addChild(bgIcon)
    self.bgIcon = bgIcon


    self.spineIcon = UI.Animation:create()
    self.spineIcon:init("effect_ui_town_stageselect_hero_baoxiang_icon.json", "effect_ui_town_stageselect_hero_baoxiang_icon.atlas", 1)
    self.spineIcon:center()
    self.spineIcon:setAnimation("begin",false)
    bgIcon:setTouchEnable(true)
    bgIcon:setSwallowTouches(false)
    -- bgIcon:setClickAudioEnable(true)
    bgIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function(sender, _, _, touchPosition)
        if self.isEnable then
            self:playShakeAct(self.boxIcon)
            if self.clickCallback then
                self:clickCallback(touchPosition)
            end
            if self.isGray ~= nil then
                if self.isGray then
                    self.spineIcon:setAnimation("open2", false)
                else
                    self.spineIcon:setAnimation("open1", false)
                end
            end
        end
    end)

    self.spineIcon:addEventListener(UIEvent.ANIMATION_END,self, function(self, event, obj)
        if self.animationEndCallback then
            self:animationEndCallback(event, obj)
        end
    end)

    self.spineIcon:addEventListener(UIEvent.ANIMATION_COMPLETE, self,function(sender, event)
        if event.animation == "open2" then
            self.spineIcon:setAnimation("open2-idle", true)
        elseif event.animation == "open1" then
            self.spineIcon:setAnimation("open1-idle", true)
        end
    end)
    self:addChild(self.spineIcon)

    local boxIcon = UI.Image:create()
    boxIcon:init()
    boxIcon:center()
    self.spineIcon:addComponent("icon", boxIcon)
    self.boxIcon = boxIcon
end

-- 模版函数：初始化组建的视图
function LevelSelectEventBtn:onInitView()

end

-- 模版函数：更新组建的视图
function LevelSelectEventBtn:onUpdateView()
    LevelSelectEventBtn.super.onUpdateView(self)
end


function LevelSelectEventBtn:lock()
    -- self:setBtnState(SpineIconStatus.locked)
end

function LevelSelectEventBtn:waitUnLock()
    self:setBtnState(SpineIconStatus.waitUnLock)
end

function LevelSelectEventBtn:unLocked()
    self:setBtnState(SpineIconStatus.haveUnLocked)
    if self.boxIcon and self.normalName then
        self.boxIcon:setSpriteName(self.normalName)
    end
    if self.spineIcon then
        self.spineIcon:setAnimation("begin",false)
    end
end

function LevelSelectEventBtn:selected(isShowAct)
    self:setBtnState(SpineIconStatus.selected)
    if self.boxIcon and self.selectName then
        self.boxIcon:setSpriteName(self.selectName)
    end
    if isShowAct then
        if self.isGray then
            self.spineIcon:setAnimation("open2-idle", true)
        else
            self.spineIcon:setAnimation("open1-idle", true)
        end
    end
end

function LevelSelectEventBtn:showStartAnimation()
    self:playShakeAct(self.boxIcon, function()   
        if self.animationEndCallback then
            self:animationEndCallback({animation = "start2"}, nil)
        end
    end)
end

function LevelSelectEventBtn:showStepEndAnimation()

end

function LevelSelectEventBtn:addBoxBg(normalName, selectName, isGray, isDefaultOpen, boxLevel)
    local isChange = false
    if self.isGray ~= isGray then
        isChange = true
    end
    self.isGray = isGray
    if self.normalName == normalName and self.selectName == selectName and not isChange then
        return
    end
    self.normalName = normalName
    self.selectName = selectName
    self.boxIcon:setSpriteName(normalName)
    if SpineIconStatus.selected == self.state then
        self:selected(true)
    end

    if isDefaultOpen then
        if self.isGray ~= nil then
            if self.isGray then
                self.spineIcon:setAnimation("open2", false)
            else
                self.spineIcon:setAnimation("open1", false)
            end
        end
        self.boxIcon:setSpriteName(self.selectName)
    end

    local nameStr = ""
    if boxLevel == 1 then
        nameStr = UI.TEXT_221812
    elseif boxLevel == 2 then
        nameStr = UI.TEXT_221813
    elseif boxLevel == 3 then
        nameStr = UI.TEXT_221814
    end
    if not self._boxGradeName then
        
        local nameBg = UI.Image:create()
        nameBg:init("ui_selectfloor_color_gemstonebg.png")
        nameBg:center(0,33.5)
        self:addChild(nameBg,999999)

        self._boxGradeName = UI.Text:create()
        self._boxGradeName:init(nameStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
        self._boxGradeName:center()
        nameBg:addChild(self._boxGradeName)
    else
        self._boxGradeName:setText(nameStr)
    end
    
end

function LevelSelectEventBtn:playShakeAct(node, callback)
    node:stopAllActions()
    node:rotate(0)
    local rotateAct1 = cc.RotateBy:create(0.06, 20)
    local rotateAct2 = cc.RotateBy:create(0.11, -45)
    local rotateAct3 = cc.RotateBy:create(0.09, 40)
    local rotateAct4 = cc.RotateBy:create(0.09, -35)
    local rotateAct5 = cc.RotateBy:create(0.07, 30)
    local rotateAct6 = cc.RotateBy:create(0.07, -25)
    local rotateAct7 = cc.RotateBy:create(0.05, 20)
    local rotateAct8 = cc.RotateBy:create(0.05, -15)
    local rotateAct9 = cc.RotateBy:create(0.03, 10)
    local rotateAct10 = cc.RotateTo:create(0.01, 0)
    node:runAction(cc.Sequence:create(rotateAct1, rotateAct2, rotateAct3, rotateAct4, rotateAct5, rotateAct6, rotateAct7, rotateAct8, rotateAct9, rotateAct10, 
        cc.CallFunc:create(function() if callback then callback() end end) ))
end
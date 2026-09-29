------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/10/16
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local HitRatHammerView = class("HitRatHammerView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function HitRatHammerView:ctor()
    HitRatHammerView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function HitRatHammerView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.hitrat", "HitRat", false)
    HitRatHammerView.super.init(self, ... )
end

function HitRatHammerView:dtor()
    HitRatHammerView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.hitrat.HitRatHammerView")
end

function HitRatHammerView:createHammer()
    if self.hammerNode then
        self.hammerNode:removeFromParent()
    end
    self.hammerNode = UI.Component:create()
    self.hammerNode:init()
    self.hammerNode._enableAutoUpdatePos = false
    local rotationNode = UI.Component:create()
    rotationNode:init()
    rotationNode:setPosition(cc.p(-100,0))
    rotationNode._enableAutoUpdatePos = false
    self.hammerNode:addChild(rotationNode)

    self.hammer = UI.Animation:create()
    self.hammer:init("effect_ui_hitrat_hammer.json", "effect_ui_hitrat_hammer.atlas")
    self.hammer:setAnimation("idle1", true)
    self.hammer._enableAutoUpdatePos = false
    rotationNode:addChild(self.hammer)
    self:addChild(self.hammerNode, 100)
end

function HitRatHammerView:updateHammerOnTouchBegin(touchPosition)

    self:createHammer()
    local localPos = self:convertToNodeSpace(touchPosition)
    self.hammerNode:setPosition(localPos)
    self.lastPoint = touchPosition
end

function HitRatHammerView:updateHammerOnTouchMove(touchPosition)
    local mouseMoveDis = cc.pSub(touchPosition, self.lastPoint)
    local nodeCurrentX, nodeCurrentY = self.hammerNode:getPosition()
    local newLayoutPos = cc.pAdd(cc.p(nodeCurrentX, nodeCurrentY), cc.p(mouseMoveDis.x, mouseMoveDis.y))
    self.hammerNode:setPosition(newLayoutPos)
    self.lastPoint = touchPosition
end

function HitRatHammerView:updateHammerOnTouchEnd(touchPosition)
    local rotateBackAction = cc.RotateBy:create(0.2, 60)
    local rotateSequence = cc.Sequence:create(rotateBackAction)
        self.hammer:runAction(cc.Sequence:create(rotateSequence, 
            cc.CallFunc:create(function() 
                self.hammerNode:runAction(cc.RemoveSelf:create())
                self.hammerNode = nil 
            end)
        )
    )
end

function HitRatHammerView:updateHammerOnTouchClick(touchPosition)
    self:createHammer()
    local localPos = self:convertToNodeSpace(touchPosition)
    self.hammerNode:setPosition(localPos)
    local rotateBackAction = cc.RotateBy:create(0.2, 60)
    local rotateSequence = cc.Sequence:create(rotateBackAction)
        self.hammer:runAction(cc.Sequence:create(rotateSequence, 
            cc.CallFunc:create(function() 
                self.hammerNode:runAction(cc.RemoveSelf:create())
                self.hammerNode = nil 
            end)
        )
    )
end


function HitRatHammerView:onInitView()
end


function HitRatHammerView:bindModel()

end


function HitRatHammerView:unbindModel()

end





return HitRatHammerView













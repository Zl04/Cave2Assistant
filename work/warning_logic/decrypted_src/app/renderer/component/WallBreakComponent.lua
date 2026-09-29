--[[
    高亮显示地块    
]]

Component = Component or {}

local WallBreakComponent = class("WallBreakComponent", cc.Node)
Component.WallBreakComponent = WallBreakComponent

-- 构造函数
function WallBreakComponent:ctor()
    local spine = Avalon.Animation:create("effect_map_wallbreak.json", "effect_map_wallbreak.atlas", Game.MAP_GRID_EFFECT)
    spine:setAnimation(0, "fx_wallbreak", false)
    spine:registerSpineEventHandler(function (event)
        self:runAction(cc.RemoveSelf:create())
    end, sp.EventType.ANIMATION_END)
    self:addChild(spine)
end

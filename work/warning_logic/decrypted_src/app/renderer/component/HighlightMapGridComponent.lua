--[[
    高亮显示地块    
]]

Component = Component or {}

local HighlightMapGridComponent = class("HighlightMapGridComponent", cc.Node)
Component.HighlightMapGridComponent = HighlightMapGridComponent

-- 构造函数
function HighlightMapGridComponent:ctor()
    local highlightSprite = cc.Sprite:create()
    highlightSprite:setSpriteFrame("ui_bg_map_itemenable.png")
    self:addChild(highlightSprite)
end

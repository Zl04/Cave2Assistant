--[[
    UI - 图片按钮
]]--

require "app.ui.Component"

UI = UI or {}

local ImageButton = class("ImageButton", UI.HWBtnComponent)
UI.ImageButton = ImageButton

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0
-- 背包资源
local COM_RES_LIST = nil

local function onClickHandler(self, imageButton, touchPosition)
    local localPosition = imageButton:convertToNodeSpace(touchPosition)
    local localPosX = math.round(localPosition.x)
    local localPosY = math.round(localPosition.y)

    local opacity = self._imageObj:getPixelOpacity(localPosX, localPosY)
    if (opacity > 0) then
        if (DEBUG) then
            print("ImageButton onClickHandler ", localPosX, localPosY, opacity)
        end

        self:dispatchEvent(UIEvent.IMAGE_BUTTON_CLICK, self)
    else
        self:dispatchEvent(UIEvent.IMAGE_BUTTON_CLICK_OUTSIDE, self)
    end
end

-- 构造函数
function ImageButton:ctor(width, height)
    ImageButton.super.ctor(self, UIType.IMAGE_BUTTON, nil, width, height)

    self._sprite = nil
    self._imageObj = nil
    self._colorLayer = nil 
    self._colorLayernew = nil 
end

-- 析构函数
function ImageButton:dtor()
    ImageButton.super.dtor(self)

    self._sprite = nil
    if (self._imageObj) then
        self._imageObj:release()
        self._imageObj = nil
    end
end

-- public:
-- 初始化
function ImageButton:init(imageFile, weightX, weightY)
    ImageButton.super.init(self, imageFile)
    self.weightX = weightX
    self.weightY = weightY

    self:setTouchEnable(true)
    self:setClickAudioEnable(true)
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, onClickHandler)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
        self:dispatchEvent(UIEvent.IMAGE_BUTTON_CLICK_OUTSIDE, self)
    end)
end

-- 初始化视图
function ImageButton:onInitView(imageFile)
    self._sprite = cc.Sprite:create()
    self._sprite:initWithFile(imageFile)
    self._sprite:getTexture():setAntiAliasTexParameters();  
    self:addChild(self._sprite,1)

    local image = cc.Image:new()
    image:retain()
    image:initWithImageFile(imageFile)
    self._imageObj = image

    local size = self._sprite:getContentSize()
    ImageButton.super.setSize(self, size.width, size.height)
end

-- 尺寸改变
function ImageButton:onSizeChanged()
    self._sprite:setPosition(self._hw, self._hh)
end

-- 选中碎片的颜色
function ImageButton:addSelectFragmentColcor()
    if(self._colorLayer) then 
        self._colorLayer:setVisible(true)
        self._colorLayer:setAnimation("trigger", false)
        self._colorLayer:addAnimation("idle", true)
    else
        local size = self._sprite:getContentSize()
        local colorLayer = UI.Animation:create()
        colorLayer:init("effect_ui_package_treasure_map_click.json", "effect_ui_package_treasure_map_click.atlas")
        colorLayer:setAnimation("trigger", false)
        colorLayer:addAnimation("idle", true)
        colorLayer:leftBottom(self.weightX, self.weightY)
        self._colorLayer = colorLayer
        self:addChild(colorLayer,20) 
        colorLayer:enableDebugDraw()
    end 
end 
-- 移除选中的碎片的颜色
function ImageButton:removeSelectFragmentColcor()
    if(self._colorLayer) then 
        -- print("-----点击外部区域、另一个碎片后，点击的上一个的颜色设置为看不见")
        self._colorLayer:setVisible(false)
    end 
end 

-- 新碎片的默认颜色
function ImageButton:addNewFragmentColcor()
    if(self._colorLayernew) then 
        self._colorLayernew:setVisible(true)
    else
        local size = self._sprite:getContentSize()
        local colorLayer = cc.LayerColor:create(cc.c4b(240,230,140,77))
        colorLayer:setPosition(0,0)
        colorLayer:setContentSize(size.width,size.height)
        self._colorLayernew = colorLayer
        self:addChild(colorLayer,2) 
    end 

end 
-- 移除新碎片的默认颜色
function ImageButton:removeNewFragmentColcor()

    if(self._colorLayernew) then 
        -- print("-----新碎片的颜色设置为看不见")
        self._colorLayernew:setVisible(false)
    end 
end 

function ImageButton:setClippingNode(clippingNode)
    self.clippingNode = clippingNode
end

function ImageButton:showTriggerEffect()
    if self.clippingNode == nil then
        return 
    end
    local triggerEffect = UI.Animation:create()
    triggerEffect:init("effect_ui_package_treasure_map_click.json", "effect_ui_package_treasure_map_click.atlas")
    self.clippingNode:addChild(triggerEffect)
    triggerEffect:leftBottom(self.weightX, self.weightY)
    triggerEffect:setAnimation("trigger_effect", false)
    triggerEffect:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        sender:destroy()
    end)

end


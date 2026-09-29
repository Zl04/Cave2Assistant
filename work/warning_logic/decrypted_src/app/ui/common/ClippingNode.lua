--[[
    剪切节点
]]

require "app.ui.Component"

UI = UI or {}

local ClippingNode = class("ClippingNode", UI.HWBtnComponent)
UI.ClippingNode = ClippingNode

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 剪切方式
local CLIPPING_TYPE = {
    NONE = 0,
    RECT = 1,
    SPRITE = 2,
    SPRITE_NODE = 3,
    FILE = 4,
}
local STENCIL_IMAGE_PATH = "image/white_pixel.png"

-- 构造函数
function ClippingNode:ctor()
    ClippingNode.super.ctor(self, UIType.CLIPPING_NODE, nil, 0, 0)

    self._clippingType = CLIPPING_TYPE.NONE

    self._stencilWidth = 0
    self._stencilHeight = 0
    self._spriteFrameName = nil
    self._alphaThreshold = 0.0

    self._stencilNode = nil
    self._clippingNode = nil
    self._fileName = nil
end

-- 析构函数
function ClippingNode:dtor()
    self._spriteFrameName = nil
    self._stencilNode = nil
    self._clippingNode = nil
    self._fileName = nil

    ClippingNode.super.dtor(self)
    if (self._imageObj) then
        self._imageObj:release()
        self._imageObj = nil
    end
end

-- public:
-- 初始化矩形剪切区域
-- stencilWidth：模版测试尺寸宽度
-- stencilHeight：模版测试尺寸高度
-- alphaThreshold：是否开启alpha测试
function ClippingNode:initWithRect(stencilWidth, stencilHeight, alphaThreshold)
    assert(type(stencilWidth) == "number" and stencilWidth >= 0.0, "ClippingNode init: stencilWidth is invalid.")
    assert(type(stencilHeight) == "number" and stencilHeight >= 0.0, "ClippingNode init: stencilHeight is invalid.")
    if (alphaThreshold) then assert(type(alphaThreshold) == "number" and alphaThreshold >= 0.0, "ClippingNode init: alphaThreshold is invalid.") end

    self._clippingType = CLIPPING_TYPE.RECT

    self._stencilWidth = stencilWidth or 0
    self._stencilHeight = stencilHeight or 0
    self._alphaThreshold = alphaThreshold or 0

    ClippingNode.super.init(self)
end

-- 初始化图片剪切区域
function ClippingNode:initWithSprite(spriteFrameName, alphaThreshold)
    assert(type(spriteFrameName) == "string", "ClippingNode initWithSprite: sprite frame name is invalid.")
    if (alphaThreshold) then assert(type(alphaThreshold) == "number" and alphaThreshold >= 0.0, "ClippingNode init: alphaThreshold is invalid.") end

    self._clippingType = CLIPPING_TYPE.SPRITE

    self._spriteFrameName = spriteFrameName
    self._alphaThreshold = alphaThreshold or 0

    ClippingNode.super.init(self)
end

-- 初始化图片剪切区域
function ClippingNode:initWithFileName(fileName, alphaThreshold)
    assert(type(fileName) == "string", "ClippingNode initWithSprite: sprite frame name is invalid.")
    if (alphaThreshold) then assert(type(alphaThreshold) == "number" and alphaThreshold >= 0.0, "ClippingNode init: alphaThreshold is invalid.") end

    self._clippingType = CLIPPING_TYPE.FILE

    self._fileName = fileName
    self._alphaThreshold = alphaThreshold or 0

    ClippingNode.super.init(self)
end

-- 用节点初始化剪切区域
function ClippingNode:initWithNode(spriteNode, alphaThreshold)
    assert(type(spriteNode) == "userdata", "ClippingNode initWithNode: sprite node is invalid.")
    if (alphaThreshold) then assert(type(alphaThreshold) == "number" and alphaThreshold >= 0.0, "ClippingNode initWithNode: alphaThreshold is invalid.") end

    self._clippingType = CLIPPING_TYPE.SPRITE_NODE

    self._stencilNode = spriteNode
    self._alphaThreshold = alphaThreshold or 0

    ClippingNode.super.init(self)
end

-- 初始化视图
function ClippingNode:onInitView()
    self._clippingNode = cc.ClippingNode:create()
    self._clippingNode:setInverted(false)
    self:addChild(self._clippingNode, -1)

    if (self._clippingType == CLIPPING_TYPE.RECT) then
        local stencilTexture = cc.Director:getInstance():getTextureCache():addImage(STENCIL_IMAGE_PATH)
        local sprite = cc.Sprite:create()
        sprite:setTexture(stencilTexture)
        sprite:setTextureRect({
            x = 0, y = 0,
            width = 1, height = 1
        })
        sprite:setScale(self._stencilWidth, self._stencilHeight)

        self:setSize(self._stencilWidth, self._stencilHeight)
        self._stencilNode = sprite
    elseif (self._clippingType == CLIPPING_TYPE.SPRITE) then
        local sprite = cc.Sprite:create()
        sprite:setSpriteFrame(self._spriteFrameName)

        local size = sprite:getContentSize()
        self:setSize(size.width, size.height)
        self._stencilNode = sprite
    elseif (self._clippingType == CLIPPING_TYPE.SPRITE_NODE) then
        if (self._stencilNode) then
            local size = self._stencilNode:getContentSize()
            self:setSize(size.width, size.height)
        else
            assert(false)
        end
    elseif self._clippingType == CLIPPING_TYPE.FILE then
        local sprite = cc.Sprite:create(self._fileName)
sprite:getTexture():setAntiAliasTexParameters()  
        local size = sprite:getContentSize()
        self:setSize(size.width, size.height)
        self._stencilNode = sprite
    else 
        assert(false)
    end
    assert(self._stencilNode)
    self._stencilNode:setAnchorPoint(0, 0)
    
    self._clippingNode:setPosition(0, 0)
    self._clippingNode:setStencil(self._stencilNode)
    self._clippingNode:setAlphaThreshold(self._alphaThreshold)
end

-- 更新视图
function ClippingNode:onUpdateView()
    self._clippingNode:setContentSize(self._width, self._height)
end

-- 添加子节点
function ClippingNode:addInnerNode(node)
    if (node) then
        self._clippingNode:addChild(node)
    else
        assert(false)
    end
end

-- 设置是否显示剪切区域
function ClippingNode:setInverted(inverted)
    assert(type(inverted) == "boolean", "ClippingNode setInverted: inverted is invalid.")

    self._clippingNode:setInverted(inverted)
end

function ClippingNode:onSizeChanged()
    self._clippingNode:setContentSize(self._width, self._height)
end

-- 覆盖一张 同样的图片 根据像素吞噬触摸
function ClippingNode:setOpacityFilterTouch(isFilter)
    -- print("-------ClippingNode:setOpacityFilterTouch---------", self)
    if self.listener then
        self.listener:setSwallowTouches(isFilter)
        return
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(handler(self, self.onTouchBegan),cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(handler(self, self.onTouchMoved),cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(handler(self, self.onTouchEnded),cc.Handler.EVENT_TOUCH_ENDED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    listener:setSwallowTouches(isFilter)
    self.listener = listener

    local image = cc.Image:new()
    image:retain()
    image:initWithImageFile(self._fileName)
    self._imageObj = image
end

function ClippingNode:onTouchBegan(touch, event)
    local touchPosition = touch:getLocation()
    local localPosition = self:convertToNodeSpace(touchPosition)
    local localPosX = math.round(localPosition.x)
    local localPosY = math.round(localPosition.y)
    -- print("---touchPosition--localPosition- localPosX---localPosY---self._width----self._height----= ",touchPosition, localPosition, localPosX, localPosY, self._width, self._height)
    local padding = 10
    if localPosX < -padding or localPosY < -padding or localPosX > self._width + padding or localPosY > self._height + padding then
        return false
    end
    local opacity = self._imageObj:getPixelOpacity(localPosX, localPosY) or 0
    -- print("   opacity   ========== "..opacity)
    if (opacity > 0) then
        -- print("ImageButton onClickHandler ", localPosX, localPosY, opacity) 
        return false
    elseif (opacity == -1) then
        return false
    else
        return true
    end
    

    return false
end

function ClippingNode:onTouchMoved(touch, event)
end

function ClippingNode:onTouchEnded(touch, event)
end



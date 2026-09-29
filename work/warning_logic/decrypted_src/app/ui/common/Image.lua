--[[
    UI - 文本
]]--

require "app.ui.Component"

UI = UI or {}

local Image = class("Image", UI.HWBtnComponent)
UI.Image = Image

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0
-- 背包资源
local COM_RES_LIST = nil

-- 反射用，序列化编辑器中选择Image的路径与名称
-- reflectFrameName = {
--     plistFilePath = "",
--     frameName = "",
-- }

-- 构造函数
function Image:ctor(width, height, uiType)
    Image.super.ctor(self, uiType and uiType or UIType.IMAGE, nil, width, height)

    self._sprite = nil
    self._isFilled = false
    self._fixSize = false
    self.reflectFrameName = nil
end

-- 析构函数
function Image:dtor()
    Image.super.dtor(self)
end

-- public:
-- 初始化
function Image:init(spriteName)
    if (spriteName) then assert(type(spriteName) == "string", "Image constructor: sprite name is invalid.") end

    self._spriteName = spriteName

    Image.super.init(self, spriteName)
end
function Image:initWithSprite(sprite)
    self._sprite = sprite

    Image.super.init(self)
end

-- 设置图片名字
function Image:setSpriteName(spriteName)
    assert(type(spriteName) == "string", "Image constructor: sprite name is invalid.")
    if self._spriteName == spriteName then
        return
    end
    self._spriteName = spriteName
    if (self._sprite) then
        self._sprite:setSpriteFrame(spriteName)
        if (not self._fixSize) then
            local size = self._sprite:getContentSize()
            Image.super.setSize(self, size.width, size.height)
        end
    end
end

function Image:setTexture(texture)
    
    if (self._sprite) then
        self._sprite:setTexture(texture)

        if (not self._fixSize) then
            local size = self._sprite:getContentSize()
            Image.super.setSize(self, size.width, size.height)
        end
    end
end


-- 图片是否铺满整个控件
function Image:fill()
    self._isFilled =  true
end

-- 设置尺寸
function Image:setSize(width, height)
    assert(type(width) == "number" and width >= 0)
    assert(type(height) == "number" and height >= 0)

    Image.super.setSize(self, width, height)
    
    self._fixSize = true
end

function Image:updateSize(width, height)
    assert(type(width) == "number" and width >= 0)
    assert(type(height) == "number" and height >= 0)

    Image.super.setSize(self, width, height)
end


-- 初始化视图
function Image:onInitView(spriteName)
    if (not self._sprite) then
        self._sprite = cc.Sprite:create()
    end
    self:addChild(self._sprite)
    if (spriteName) then
        self._sprite:setSpriteFrame(spriteName)
    end

    -- 设置图片尺寸
    if (not self._fixSize) then
        local size = self._sprite:getContentSize()
        Image.super.setSize(self, size.width, size.height)
    end
end

-- 变灰
function Image:onUseShader(shader)
    self._sprite:setGLProgramState(shader)
end

-- 尺寸改变
function Image:onSizeChanged()
    self._sprite:setPosition(self._hw, self._hh)

     if (self._isFilled) then
        local spriteSize = self._sprite:getContentSize()
        local scaleX, scaleY = 0, 0
        if (self._width > 0) then 
            scaleX = self._width / spriteSize.width
        end
        if (self._height > 0) then 
            scaleY = self._height / spriteSize.height
        end
        self._sprite:setScale(scaleX, scaleY)
    end
end

-- 设置旋转角度
-- function Image:setRotation(rotation)
--     if(self._sprite) then
--         self._sprite:setRotation(rotation)
--     end
-- end

-- function Image:setScaleY(scaleY)
--     if(self._sprite) then
--         self._sprite:setScaleY(scaleY)
--     end
-- end

-- function Image:setScaleX(scaleX)
--     if(self._sprite) then
--         self._sprite:setScaleX(scaleX)
--     end
-- end

-- function Image:setAnchorPoint(anchorPoint)
--     if(self._sprite and anchorPoint) then
--         self._sprite:setAnchorPoint(anchorPoint)
--     end
    
-- end
-- function Image:setColor(color)
--     if(self._sprite) then
--         self._sprite:setColor(color)
--     end
-- end

function Image:setImageRotation(rotation)
    if(self._sprite) then
        self._sprite:setRotation(rotation)
    end
end

function Image:setImageScale(scale)
    if(self._sprite) then
        self._sprite:setScale(scale)
    end
end

function Image:setImageScaleY(scaleY)
    if(self._sprite) then
        self._sprite:setScaleY(scaleY)
    end
end

function Image:setImageScaleX(scaleX)
    if(self._sprite) then
        self._sprite:setScaleX(scaleX)
    end
end

function Image:setImageAnchorPoint(anchorPoint)
    if(self._sprite and anchorPoint) then
        self._sprite:setAnchorPoint(anchorPoint)
    end
    
end

function Image:setImageColor(color)
    if(self._sprite) then
        self._sprite:setColor(color)
    end
end

function Image:setGray(gray)
    if (self._sprite) then
        if gray then
            self:useShader(UI.COMPONENT_GRAY_SHADER)
        else
            self:useShader(UI.COMPONENT_NORMAL_SHADER)
        end
        
    end
end

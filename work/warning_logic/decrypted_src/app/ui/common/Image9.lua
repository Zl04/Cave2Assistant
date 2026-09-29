--[[
    UI - 文本
]]--

require "app.ui.Component"

UI = UI or {}

local Image9 = class("Image9", UI.HWBtnComponent)
UI.Image9 = Image9

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0
-- 背包资源
local COM_RES_LIST = nil

-- 反射用，序列化编辑器中选择Image9的路径与名称
-- reflectFrameName = {
--     plistFilePath = "",
--     frameName = "",
-- }

-- 构造函数
function Image9:ctor(width, height)
    Image9.super.ctor(self, UIType.IMAGE_9, nil, width, height)

    self._sprite = nil
    self.size = cc.size(0, 0)
    self.reflectFrameName = nil
    self.capInsets = cc.rect(0, 0, 0, 0)
end

-- 析构函数
function Image9:dtor()
    Image9.super.dtor(self)
end

-- public:
-- 初始化
function Image9:init(spriteName, capInsets, size)
    if (spriteName) then assert(type(spriteName) == "string", "Image9 constructor: sprite name is invalid.") end
    self._spriteName = spriteName
    self.capInsets = capInsets or cc.rect(0, 0, 0, 0);
    self.size = size or cc.size(0, 0)
    Image9.super.init(self, spriteName)
end

-- 设置图片名字
function Image9:setSpriteName(spriteName)
    assert(type(spriteName) == "string", "Image9 constructor: sprite name is invalid.")

    self._spriteName = spriteName
    self:onInitView();
    self:setSize(self._width, self._height)
end

function Image9:setCapInsets(capInsets)
    self.capInsets = capInsets
    if self._sprite then
        self._sprite:setCapInsets(capInsets)
    end
end

-- 设置尺寸
function Image9:setSize(width, height)
    assert(type(width) == "number" and width >= 0)
    assert(type(height) == "number" and height >= 0)

    Image9.super.setSize(self, width, height)  
    if self._sprite then
        self._sprite:setContentSize(cc.size(width, height))
    end  
end

-- 初始化视图
function Image9:onInitView()
    local createNode = false;
    if (not self._sprite) then
        if self._spriteName then
            self._sprite = cc.Scale9Sprite:createWithSpriteFrameName(self._spriteName, self.capInsets)
        else
            self._sprite = cc.Scale9Sprite:create()
        end
        if self._sprite then
            self._sprite:setAnchorPoint(0, 0)
            self:setSize(self.size.width, self.size.height)
            createNode = true
            self:addChild(self._sprite)
        end
    end
    if (self._sprite and self._spriteName and not createNode) then
        local frame = cc.SpriteFrameCache:getInstance():getSpriteFrameByName(self._spriteName);
        self._sprite:setSpriteFrame(frame, self.capInsets)
    end
end

function Image9:setImage9Color(color)
    if(self._sprite) then
        self._sprite:setColor(color)
    end
end

function Image9:onUseShader(shader)
    self._sprite:setGLProgramState(shader)
end

-- ImageOutLine.lua
-- Author:ydli
-- 2018年9月11日
-- Using:用shader闪烁光源 特效 ，    输入图片纹理，颜色，坐标 产生光源


EFFECT = EFFECT or {}
local ImageOutLine = class("ImageOutLine", UI.Image)
EFFECT.ImageOutLine = ImageOutLine

-- 构造函数
function ImageOutLine:ctor()
    ImageOutLine.super.ctor(self, 0, {}, 0, 0)
    self:init()
end

-- 析构函数
function ImageOutLine:dtor()
    ImageOutLine.super.dtor(self)
end

-- 初始化
function ImageOutLine:init()
    ImageOutLine.super.init(self)
end

-- 初始化视图
function ImageOutLine:onInitView()
    
end

-- 更新视图
function ImageOutLine:onUpdateView()
end

--png 散图资源名字
function ImageOutLine:initWithFileName(fileName)
	local ckipperSprite = cc.Sprite:create()
    ckipperSprite:initWithFile(fileName)

    local bottomSprite = cc.Sprite:create()
    bottomSprite:initWithFile(fileName)
    return self:generalOutline(ckipperSprite, bottomSprite)
end

--png 纹理资源名字
function ImageOutLine:initWithFramName(framName)
    local ckipperSprite = cc.Sprite:create()
    ckipperSprite:setSpriteFrame(framName)

    local bottomSprite = cc.Sprite:create()
    bottomSprite:setSpriteFrame(framName)
    return self:generalOutline(ckipperSprite, bottomSprite)
end


function ImageOutLine:generalOutline(modeSprite, bottomSprite, outLineColor)
    local node = cc.Node:create()
    node:setContentSize(bottomSprite:getContentSize().width, bottomSprite:getContentSize().height)
    modeSprite:setScale(0.970)
    node:addChild(modeSprite)

    local _clipper = cc.ClippingNode:create()
    _clipper:setStencil(node)
    _clipper:setPosition(0, 0)
    _clipper:setAlphaThreshold(0.5)
    _clipper:setInverted(true)
    self:addChild(_clipper, 1000)
    _clipper:addChild(bottomSprite)

    local color = outLineColor or cc.vec4(1.0, 0, 0, 1.0)
    -- local glProgram = cc.GLProgram:createWithFilenames("shaders/TextureLight.vert", "shaders/TextureLight.frag")
    -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    local glProgramState = AvalonUtil:getGLProgramState("shaders/TextureLight.vert", "shaders/TextureLight.frag")
    glProgramState:setUniformVec4("u_lightColor", color)
    _clipper:setGLProgramState(glProgramState)


    local _renderTexture = cc.RenderTexture:create(bottomSprite:getContentSize().width, bottomSprite:getContentSize().height, cc.TEXTURE2_D_PIXEL_FORMAT_RG_B565)
    if _renderTexture.ignoreAnchorPointForPosition then
        _renderTexture:ignoreAnchorPointForPosition(true);
    else
        _renderTexture:setIgnoreAnchorPointForPosition(true);
    end
                
    _renderTexture:begin()
    _clipper:visit()
    _renderTexture:endToLua()
    local _pic = cc.Sprite:createWithTexture(_renderTexture:getSprite():getTexture())
    return _pic
end
  

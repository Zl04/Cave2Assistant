--[[
    UI - 进度条
]]--

require "app.ui.Component"

UI = UI or {}
local ProgressTimer = class("ProgressTimer", UI.HWBtnComponent)
UI.ProgressTimer = ProgressTimer

-- 资源
local PROGRESS_TIMER_RES_LIST = nil 

UI.ProgressTimerType = {
    BAR = cc.PROGRESS_TIMER_TYPE_BAR,               
    RADIAL = cc.PROGRESS_TIMER_TYPE_RADIAL,                
}

local ProgressTimerType = UI.ProgressTimerType

-- private:
local DEBUG = false

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0

-- 层级
local ZORDER_BG = 1
local ZORDER_CHANGE = 2
local ZORDER_TRUE = 3

-- 标签
local PROGRESS_ACTION_TAG = 99

-- 构造函数
function ProgressTimer:ctor()

    ProgressTimer.super.ctor(self, UIType.PROGERSSTIMER, PROGRESS_TIMER_RES_LIST, COM_WIDTH, COM_WIDTH, COM_HEIGHT)
    self._bloodBg = nil 
    self._timer = nil 
    self._truetimer = nil
    self._sprite1 = nil
    self._sprite2 = nil
    self._sprite3 = nil
    self._type = 0

end

-- 析构函数
function ProgressTimer:dtor()

    self._bloodBg = nil 
    self._timer = nil 
    self._truetimer = nil
    self._sprite1 = nil
    self._sprite2 = nil
    self._sprite3 = nil

    ProgressTimer.super.dtor(self)

end

-- public:
-- 初始化
-- picturenamebg      血条黑色背景图片名字
-- picturenamechange  背景上面变化的血条图片的名字，若无传nil
-- picturename        真实血条图片的名字
function ProgressTimer:init( picturenamebg,picturenamechange, picturename, progressType)

    assert(type(picturenamebg) == "string" or picturenamebg == nil , "[ERROR] ProgressTimer init: ProgressTimer bg name sprite1 is invalid.")
    assert(type(picturenamechange) == "string" or picturenamechange == nil , "[ERROR] ProgressTimer init: ProgressTimer bg name sprite2 is invalid.")
    assert(type(picturename) == "string", "[ERROR] ProgressTimer init: ProgressTimer bg name sprite3 is invalid.")
    assert(type(progressType) == "number" or progressType == nil , "[ERROR] ProgressTimer init: ProgressTimer bg name sprite3 is invalid.")

    self._sprite1 = picturenamebg
    self._sprite2 = picturenamechange
    self._sprite3 = picturename
    self._type = progressType and progressType or ProgressTimerType.BAR 
    
    ProgressTimer.super.init(self)
end

-- 初始化视图
function ProgressTimer:onInitView()
     
    -- 背景 如血条，蓝条，经验
    if self._sprite1 ~= nil then
        self._bloodBg = UI.Image:create()
        self._bloodBg:init(self._sprite1)
        self._bloodBg:center()
        self:addChild(self._bloodBg, ZORDER_BG)
    end

    if self._sprite2 ~= nil then
        --进度条 变化的
        local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(self._sprite2))
        timer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        timer:setMidpoint(cc.p(0, 0))
        timer:setBarChangeRate(cc.p(1, 0))
        timer:setPercentage(0)
        -- timer:setPosition(self._hw,self._height)
        self:addChild(timer, ZORDER_CHANGE)
        self._timer = timer
    end

    --进度条图片 真实的
    local truetimer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(self._sprite3))

    if self._sprite1 ~= nil then
        self:setSize(self._bloodBg:getContentSize().width,self._bloodBg:getContentSize().height)
    else
        self:setSize(truetimer:getContentSize().width,truetimer:getContentSize().height)
    end
   
    truetimer:setType(self._type)
    if self._type == ProgressTimerType.BAR then 
        truetimer:setMidpoint(cc.p(0, 0))
        truetimer:setBarChangeRate(cc.p(1, 0))
    end

    truetimer:setPercentage(0)
    -- truetimer:setPosition(self._hw,self._height)
    self:addChild(truetimer, ZORDER_TRUE)
    self._truetimer = truetimer

end

function ProgressTimer:setMidpoint(point)
    if self._truetimer then
        self._truetimer:setMidpoint(point)
    end
    if self._timer then
        self._timer:setMidpoint(point)
    end
end

function ProgressTimer:setBarChangeRate(point)
    if self._truetimer then
        self._truetimer:setBarChangeRate(point)
    end
    if self._timer then
        self._timer:setBarChangeRate(point)
    end
end

function ProgressTimer:setReverseProgress(reverse)
    if self._truetimer then
        self._truetimer:setReverseProgress(reverse)
    end
end

-- 更改背景图片的名字
function ProgressTimer:setSpriteName(picturenamebg, picturenamechange, picturename)
    -- print("ProgressTimer:setSpriteName")
    assert(type(picturenamebg) == "string" or picturenamebg == nil , "[ERROR] ProgressTimer init: ProgressTimer bg name sprite1 is invalid.")
    assert(type(picturenamechange) == "string" or picturenamechange == nil , "[ERROR] ProgressTimer init: ProgressTimer bg name sprite2 is invalid.")
    assert(type(picturename) == "string", "[ERROR] ProgressTimer init: ProgressTimer bg name sprite3 is invalid.")

    self._sprite1 = picturenamebg
    self._sprite2 = picturenamechange
    self._sprite3 = picturename

    if self._sprite1 ~= nil then
        if not self._bloodBg then
            self._bloodBg = UI.Image:create()
            self._bloodBg:init(self._sprite1)
            self._bloodBg:center()
            self:addChild(self._bloodBg, ZORDER_BG)
        else
            self._bloodBg:setSpriteName(self._sprite1)
            
        end
    end

    if self._sprite2 ~= nil and self._timer then
        local sprite = cc.Sprite:createWithSpriteFrameName(self._sprite2)
        self._timer:setSprite(sprite)
    end

    if (self._truetimer) then
        local sprite = cc.Sprite:createWithSpriteFrameName(self._sprite3)
        self._truetimer:setSprite(sprite)
    end
    
    --更新size
    if self._sprite1 ~= nil then
        self:setSize(self._bloodBg:getContentSize().width,self._bloodBg:getContentSize().height)
    else
        self:setSize(self._truetimer:getContentSize().width,self._truetimer:getContentSize().height)
    end

    self:updateView()
end

function ProgressTimer:setSprite(name)
    print("progressTimer1",name)
    -- local percent = self._truetimer:getPercentage()
    -- self._truetimer:setPercentage(100)
    -- local sprite = self._truetimer:getSprite()
    -- sprite:setSpriteFrame(name)

    local sprite = cc.Sprite:createWithSpriteFrameName(name)
    self._truetimer:setSprite(sprite)

    -- self._truetimer:setPercentage(percent)
    -- self._truetimer:setSprite(sprite)

end

-- 更新视图
function ProgressTimer:onUpdateView()

    if self._bloodBg ~= nil then 
        self._bloodBg:center()
    end

    if self._timer ~= nil then 
        self._timer:setPosition(self._hw,self._hh)
    end

    self._truetimer:setPosition(self._hw,self._hh)
end

-- 整体缩放
function ProgressTimer:setScale(percent)
    
    assert(type(percent) == "number", "[ERROR] ProgressTimer setScale: parameter percent is invalid.")
    if self._bloodBg ~= nil then 
        self._bloodBg:setScale(percent)
    end
    self._truetimer:setScale(percent)
     
    if self._timer ~= nil then 
        -- 变化的效果
        self._timer:setScale(percent)
    end

end

-- 设置真实血量的进度，小数
function ProgressTimer:setPercent(percent)
    assert(type(percent) == "number", "[ERROR] ProgressTimer setPercent: parameter percent is invalid.")
    if self._truetimer ~= nil then 
        -- 变化的效果
        -- self._truetimer:setPercentage(percent)
        self._truetimer:stopActionByTag(PROGRESS_ACTION_TAG)
        self._truetimer:setPercentage(percent*100)
    end
end

function ProgressTimer:getPercent()
    if self._truetimer ~= nil then 
        return self._truetimer:getPercentage()
    end
end

-- 设置变化血条的进度
function ProgressTimer:setChangePercent(percent)

    assert(type(percent) == "number", "[ERROR] ProgressTimer setPercent: parameter percent is invalid.")
    if self._timer ~= nil then 
        -- 变化的效果
        self._timer:setPercentage(percent*100)
    end

end

--变化的血条从多少变化到多少
-- from  小数 开始变化时
-- to    小数 变化到
-- time  毫秒 从from到to的时间
function ProgressTimer:setBarChange(from,to,time)

    assert(type(from) == "number", "[ERROR] ProgressTimer setBarChange: parameter from is invalid.")
    assert(type(to)   == "number", "[ERROR] ProgressTimer setBarChange: parameter to is invalid.")
    assert(type(time) == "number", "[ERROR] ProgressTimer setBarChange: parameter time is invalid.")
    if self._timer ~= nil then 

        -- 变化的效果
        self._timer:setPercentage(from*100)
        local to1 = cc.ProgressTo:create(time/1000, to*100)
        self._timer:runAction(to1)
  
    end

end

-- 普通进度条的变化(背景+变化条)
function ProgressTimer:setBarChangeAction(from,to,time)

    assert(type(from) == "number", "[ERROR] ProgressTimer setBarChange: parameter from is invalid.")
    assert(type(to)   == "number", "[ERROR] ProgressTimer setBarChange: parameter to is invalid.")
    assert(type(time) == "number", "[ERROR] ProgressTimer setBarChange: parameter time is invalid.")

    if self._truetimer ~= nil then 
        -- 变化的效果
        self._truetimer:setPercentage(from*100)
        local to1 = cc.ProgressTo:create(time/1000, to*100)
        to1:setTag(PROGRESS_ACTION_TAG)
        self._truetimer:runAction(to1)
    end
end

function ProgressTimer:stopAllActions( ... )
   
    if(not tolua.isnull(self._truetimer)) then 
        self._truetimer:stopAllActions()
    end
    if(not tolua.isnull(self._timer)) then 
        self._timer:stopAllActions()
    end
end

function ProgressTimer:pause()
   
    if(not tolua.isnull(self._truetimer)) then 
        self._truetimer:pause()
    end
    if(not tolua.isnull(self._timer)) then 
        self._timer:pause()
    end
end

function ProgressTimer:resume()
   
    if(not tolua.isnull(self._truetimer)) then 
        self._truetimer:resume()
    end
    if(not tolua.isnull(self._timer)) then 
        self._timer:resume()
    end
end






--[[
    UI - 动画
]]--

require "app.ui.Component"
require "utils.Animation.AvalonAnimation"

UI = UI or {}

local Animation = class("Animation", UI.HWBtnComponent)
UI.Animation = Animation

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0
-- 背包资源
local COM_RES_LIST = nil

-- 构造函数
function Animation:ctor()
    Animation.super.ctor(self, UIType.ANIMATION)

    self._skeletonFile = nil
    self._atlasFile = nil
    self._scale = 1.0
    self._spine = nil
    self._innerOffsetX = 0
    self._innerOffsetY = 0

    self.isTransAct = false
    self.transTargetTime = 0
    self.transCurTime = 0
    self.isToGray = false
end

-- 析构函数
function Animation:dtor()
    if (not self._isAsync) then
        Avalon.ResHelper:unloadUIAnimationTexture(self._skeletonFile)
    end
    self._skeletonFile = nil
    self._binaryFile = nil
    self._atlasFile = nil
    self._spine = nil
    self:endTransFormGray()
    Animation.super.dtor(self)
end

-- public:
-- 初始化
function Animation:init(skeletonFile, atlasFile, scale, isAsync)
    if (skeletonFile) then assert(type(skeletonFile) == "string", "Animation init: skeleton file name is invalid.") end
    if (atlasFile) then assert(type(atlasFile) == "string", "Animation init: atlas file name is invalid.") end
    if (scale) then assert(type(scale) == "number", "Animation init: skeleton scale is invalid.") end

    self._skeletonFile = skeletonFile
    self._atlasFile = atlasFile
    self._scale = scale or 1.0
    self._isAsync = isAsync

    Animation.super.init(self)
end

function Animation:initWithBinaryFile(binaryFile, atlasFile, scale, isAsync)
    if (binaryFile) then assert(type(binaryFile) == "string", "Animation init: binaryFile file name is invalid.") end
    if (atlasFile) then assert(type(atlasFile) == "string", "Animation init: atlas file name is invalid.") end
    if (scale) then assert(type(scale) == "number", "Animation init: skeleton scale is invalid.") end

    self._binaryFile = binaryFile
    self._atlasFile = atlasFile
    self._scale = scale or 1.0
    self._isAsync = isAsync

    Animation.super.init(self)
end

-- 销毁
function Animation:destroy()
    self:runAction(
        cc.RemoveSelf:create()
    )
end

-- 设置图片名字
function Animation:setAnimationData(skeletonFile, atlasFile, scale)
    assert(type(skeletonFile) == "string", "Animation setAnimationData: skeleton file name is invalid.")
    assert(type(atlasFile) == "string", "Animation setAnimationData: atlas file name is invalid.")
    if (scale) then assert(type(scale) == "number", "Animation setAnimationData: skeleton scale is invalid.") end

    self._skeletonFile = skeletonFile
    self._atlasFile = atlasFile
    self._scale = scale or 1.0

    self._spine:initWithFile(skeletonFile, atlasFile, scale)
end

function Animation:setAnimationBinaryData(binaryFile, atlasFile, scale)
    assert(type(binaryFile) == "string", "Animation setAnimationData: binaryFile file name is invalid.")
    assert(type(atlasFile) == "string", "Animation setAnimationData: atlas file name is invalid.")
    if (scale) then assert(type(scale) == "number", "Animation setAnimationData: skeleton scale is invalid.") end

    self._binaryFile = binaryFile
    self._atlasFile = atlasFile
    self._scale = scale or 1.0

    self._spine:initWithBinaryFile(skeletonFile, atlasFile, scale)
end

function Animation:setVisible( visible )
    Animation.super.setVisible(self,visible)
    if self._spine then
        self._spine:setVisible(visible)
    end
    -- print("Animation.setVisible",visible)
end
-- 播放动画
function Animation:play(animationName, loop)
    assert(type(animationName) == "string", "Animation play: animation name is invalid.")
    if (loop) then assert(type(loop) == "boolean", "Animation play: loop is invalid.") end

    if (self._spine) then
        loop = (loop == nil) and true or loop
        self._spine:setAnimation(0, animationName, loop)
    else
        assert(false)
    end
end
function Animation:setAnimation(animationName, loop, trackIndex)
    assert(type(animationName) == "string", "Animation play: animation name is invalid.")
    if (loop) then assert(type(loop) == "boolean", "Animation play: loop is invalid.") end

    if (self._spine) then
        loop = (loop == nil) and true or loop
        return self._spine:setAnimation(trackIndex or 0, animationName, loop)
    else
        assert(false)
    end
end
function Animation:addAnimation(animationName, loop, trackIndex)
    assert(type(animationName) == "string", "Animation play: animation name is invalid.")
    if (loop) then assert(type(loop) == "boolean", "Animation play: loop is invalid.") end

    if (self._spine) then
        loop = (loop == nil) and true or loop
        self._spine:addAnimation(trackIndex or 0, animationName, loop)
    else
        assert(false)
    end
end


--[[
挂载特效
slotName:
component:挂在的点
isDefaultOrder：是否默认层级排序，如果默认层级就是根据挂载点设置层级，这里初始化后就不会变动了。
dynamicOrder: 是否根据挂载点动态变动层级，这里是在初始化后会根据动画变动
]]
function Animation:addComponent(slotName, component, isDefaultOrder, dynamicOrder)
    assert(type(slotName) == "string", "[ERROR] AvalonAnimation addComponent: slot name is invalid.")
    assert(component, "[ERROR] AvalonAnimation addComponent: component is nil.")

    if (self._spine) then
        local slotNode = nil
        if(dynamicOrder) then
            -- 这里需要判断版本号才能确定是否能传递这个参数
            if(ToolsUtil:getSupportDynamicOrder()) then
                slotNode = self._spine:getNodeForSlot(slotName, isDefaultOrder, dynamicOrder)
            else 
                slotNode = self._spine:getNodeForSlot(slotName, isDefaultOrder)
            end
        else
            slotNode = self._spine:getNodeForSlot(slotName, isDefaultOrder)
        end
        if (slotNode) then
            slotNode:addChild(component)
        else
           assert(false, string.format("[ERROR] Avalon Animation: no slot node found for %s.", slotName))
        end
    end
end

function Animation:hasSlot(slotName)
    local slotNode = self._spine:getNodeForSlot(slotName)
    if slotNode then
        return true
    else
        return true
    end
end


function Animation:getNodeForSlot(slotName)
    local slotNode = self._spine:getNodeForSlot(slotName)
    if slotNode then
        return slotNode
    else
        return nil
    end
end

-- 初始化视图
function Animation:onInitView()
    if ((self._skeletonFile or self._binaryFile) and self._atlasFile) then
        if self._skeletonFile then
            if (self._isAsync) then
                self._spine = Avalon.Animation:create(self._skeletonFile, self._atlasFile, self._scale, false)
            else
                self._spine = sp.AvalonAnimation:create(self._skeletonFile, self._atlasFile, self._scale, false)
            end
        else
            if (self._isAsync) then
                self._spine = Avalon.Animation:create(self._binaryFile, self._atlasFile, self._scale, false, nil, true)
            else
                self._spine = sp.AvalonAnimation:createWithBinaryFile(self._binaryFile, self._atlasFile, self._scale, false)
            end
        end
        self._spine:registerSpineEventHandler(function(event,obj)
            self:dispatchEvent(UIEvent.ANIMATION_START, event,self)
        end, sp.EventType.ANIMATION_START)
        self._spine:registerSpineEventHandler(function(event)
            self:dispatchEvent(UIEvent.ANIMATION_END, event,self)
        end, sp.EventType.ANIMATION_END)
        self._spine:registerSpineEventHandler(function(event)
            self:dispatchEvent(UIEvent.ANIMATION_COMPLETE, event,self)
        end, sp.EventType.ANIMATION_COMPLETE)
        self._spine:registerSpineEventHandler(function(event)
            self:dispatchEvent(UIEvent.ANIMATION_EVENT, event,self)
        end, sp.EventType.ANIMATION_EVENT)
        self:addChild(self._spine)
        -- self._spine:setVisible(false)
    end
end

-- 更新视图
function Animation:onUpdateView()
    if (self._spine) then
        self._spine:setPosition(self._hw + self._innerOffsetX, self._hh + self._innerOffsetY)
        self._spine:setVisible(self._visible)
    end
end

-- 恢复默认状态
function Animation:restore()
    if (self._spine) then
        self._spine:setToSetupPose()
        self:setScaleX(1.0)
        self:setScaleY(1.0)
        self:setRotation(0.0)
    end
end


-- 清理轨道
function Animation:clearTrack()
    if (self._spine) then
        self._spine:clearTrack(0)
    end
end

function Animation:setInnerOffset(x, y)
    self._innerOffsetX = x
    self._innerOffsetY = y
end

function Animation:setToSetupPose()
    if (self._spine) then
        self._spine:setToSetupPose()
    end
end

function Animation:setTimeScale(timeScale)
    if (self._spine) then
        self._spine:setTimeScale(timeScale)
    end
end

function Animation:updateTime(dt)
    if (self._spine) then
        self._spine:update(dt)
    end
end

function Animation:getBoundingBox()
    if (self._spine) then
        self._spine:update(0.001)
        return self._spine:getBoundingBox()
    end
end

-- 获取当前动画名字
function Animation:getAnimationName(trackIndex)
    if self._spine then
        trackIndex = trackIndex or 0
        return self._spine:getAnimationName(trackIndex)
    end

    return nil
end

-- 暂停动画
function Animation:pause()
    self._isPaused = true

    if(not tolua.isnull(self._spine)) then 
        self._spine:pause()
    end
end

-- 恢复动画
function Animation:resume()
    self._isPaused = false

    if(not tolua.isnull(self._spine)) then 
        self._spine:resume()
    end
end

function Animation:getDescription()
    return "<" .. self.__cname .. " | Tag = " .. self:getTag() .. ", FileName = " .. self._skeletonFile .. ">"
end

function Animation:setAttachment(name,attachment)
    if (self._spine) then
        self._spine:setAttachment(name,attachment)
    end
end

function Animation:update(dt)
    -- if self.isTransAct then
    --     local actEnd = false
    --     if self.transTargetTime <= 0 then
    --         actEnd = true
    --         if self.isToGray then
    --             self.glProgramState:setUniformFloat("v_transformFactor", 0)
    --         else
    --             self.glProgramState:setUniformFloat("v_transformFactor", 1)
    --         end
    --     elseif self._spine and self.glProgramState then
    --         if self.isToGray then
    --             self.transCurTime = self.transCurTime - dt
    --         else
    --             self.transCurTime = self.transCurTime + dt
    --         end
    --         local factor = self.transCurTime / self.transTargetTime
    --         if factor < 0 or factor > 1 then
    --             actEnd = true
    --         end
    --         factor = factor < 0 and 0 or factor
    --         factor = factor > 1 and 1 or factor
    --         self.glProgramState:setUniformFloat("v_transformFactor", factor)
    --     end
    --     if actEnd then
    --         self:endTransFormGray()
    --     end
    -- end
end

--[[
    动画是否变灰
    isToGray:动画是否变灰
]]
function Animation:setGray(isToGray)
    if (self._spine) then
        if(self._oldGlProgramState == nil) then 
            self._oldGlProgramState = self._spine:getGLProgramState()
        end
        local glProgramState = AvalonUtil:getAnimationGrayGLProgramState()
    
        self.glProgramState = glProgramState
        self.isToGray = isToGray
        if isToGray then
            if self.glProgramState then
                self._spine:setGLProgramState(self.glProgramState)
            end
        else
            if(self._oldGlProgramState) then
                self._spine:setGLProgramState(self._oldGlProgramState)
            end
        end
    end
end

--[[
    渐变灰动画 deprecated, 推荐使用 setGray 来设置动画是否变灰
    time :该参数已经没有用了
    isToGray: 是否变灰
]]
function Animation:playTransFormGray(time, isToGray)
    if (self._spine) then
        if(self._oldGlProgramState == nil) then 
            self._oldGlProgramState = self._spine:getGLProgramState()
        end

        local glProgramState = AvalonUtil:getAnimationGrayGLProgramState()
        
        -- Avalon.Scheduler:scheduleUpdate(self, self.update)
        self.glProgramState = glProgramState
        self.isTransAct = true
        self.isToGray = isToGray
        self.transTargetTime = time
        if isToGray then
            self.transCurTime = time
            if self.glProgramState then
                self._spine:setGLProgramState(self.glProgramState)
            end
            -- glProgramState:setUniformFloat("v_transformFactor", 1)
        else
            self.transCurTime = 0
            if(self._oldGlProgramState) then
                self._spine:setGLProgramState(self._oldGlProgramState)
            end
            -- glProgramState:setUniformFloat("v_transformFactor", 0)
        end
    end
end


function Animation:endTransFormGray()
    if self.isTransAct then
        self.isTransAct = false
        self.transTargetTime = 0
        Avalon.Scheduler:unscheduleUpdate(self, self.update)
    end

end

-- 设置播放速度
function Animation:setTimeScale(timeScale)
    if (self._spine) then
        self._spine:setTimeScale(timeScale)
    end
end

function Animation:getSpineVersion()
    if sp.AvalonAnimation.getSpineVersion == nil then
        return 0
    else
        return sp.AvalonAnimation:getSpineVersion()
    end
end

function Animation:findAnimation(name)
    if (self._spine) then
        return self._spine:findAnimation(name)
    end
end


-- function Animation:setTag(tag)
--     if (self._spine) then
--         self._spine:setTag(tag)
--     end
-- end

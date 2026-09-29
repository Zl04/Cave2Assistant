--[[
    动画对象
]]--

require "utils.res.ResHelper"

Avalon = Avalon or {}

local Animation = class("AvalonAnimation", cc.Node)
Avalon.Animation = Animation

local DEBUG = false

-- private:
-- 清理状态
function Animation:_clearState()
    local states = self._states
    if (states) then
        for i = 1, #states do
            states[i] = nil
        end
    end

    self._animationUpdatedTime = 0
end

-- 清理附件属性状态
function Animation:_clearAttachmentState()
    local states = self._attachmentStates
    if states then
        for i = 1, #states do
            states[i] = nil
        end
    end
end

-- 清理注册事件
function Animation:_clearEvent()
    local events = self._events
    if events then
        for i = 1, #events do
            events[i] = nil
        end
    end
end

-- 清理组件
function Animation:_clearComponents()
    local components = self._components
    if (components) then
        for slotName, component in pairs(components) do
            if (component) then
                component:release()
            end
            components[slotName] = nil
        end
    end
end

-- spine依赖资源加载完成
function Animation:_onLoadedSpineResHandler(skeletonFile, atlasFile, scale)
    if (DEBUG) then
        print(string.format("[Avalon Animation] loaded spine resouce %s %s %f. %s ", skeletonFile, atlasFile, scale, self))
    end

    if tolua.isnull(self) then
        return
    end

    self:_initSpine(skeletonFile, atlasFile, scale, self._useAvalonAnimation)

    local spine = self._spine
    if (spine) then
        -- 展示动画
        local states = self._states
        if (states) then
            for i = 1, #states do
                local state = states[i]
                local trackIndex = state[1]
                local animationName = state[2]
                local loop = state[3]

                if (i == 1) then
                    spine:setAnimation(trackIndex, animationName, loop)
                else
                    spine:addAnimation(trackIndex, animationName, loop)
                end
            end
            if (#states >= 1 and self._startAfterLoading == false) then
                spine:update(self._animationUpdatedTime)
            else
                spine:setToSetupPose()
            end
        end
        if (self._isPaused) then
            spine:pause()
        end
        self:_clearState()

        -- 注册事件
        local events = self._events
        if events then
            for i = 1, #events do
                local event = events[i]
                local callBack = event.callBack
                local eventType = event.eventType

                spine:registerSpineEventHandler(callBack,eventType)
            end
        end
        self:_clearEvent()

        -- 挂载组件
        local components = self._components
        if (components) then
            for slotName, component in pairs(components) do
                if (component) then
                    self:addComponent(slotName, component)
                end
            end
        end
        self:_clearComponents()

        -- 设置层级
        if self._spineZOrder then
            self._spine:setLocalZOrder(self._spineZOrder)
            self._spineZOrder = nil
        end

        -- 设置皮肤
        if self._skinName then
            self._spine:setSkin(self._skinName)
            self._skinName = nil
        end

        if self._setToSetupPose then
            self._spine:setToSetupPose()
            self._setToSetupPose = nil
        end

        -- 设置附件状态
        if (self._attachmentStates) then
            local states = self._attachmentStates
            for i = 1, #states do
                local state = states[i]
                local slotName = state[1]
                local attachmentName = state[2]

                spine:setAttachment(slotName, attachmentName)
            end
        end
        self:_clearAttachmentState()

        -- 设置action 
        if not tolua.isnull(self._action) then
            self._spine:runAction(self._action)
            self._action = nil
        end

        -- 设置加速度
        if self._timeScale then
            self._spine:setTimeScale(self._timeScale)
            self._timeScale = nil
        end

        if(self._glProgramState) then 
            self._spine:setGLProgramState(self._glProgramState)
            self._glProgramState = nil
        end

        -- 加载完成回调
        if self._loadedSpineSuccessCallBack then
            self._loadedSpineSuccessCallBack()
            self._loadedSpineSuccessCallBack = nil
        end

        self._spine:setVisible(self._visible)
    else
        assert(false, "[ERROR] AvalonAnimation _onLoadedSpineResHandler: fail to create spine.")
    end
end

-- 删除spine资源
function Animation:_removeSpineRes()
    if (DEBUG) then
        print(string.format("[Avalon Animation] unloading spine resouce %s %s %f. ", self._skeletonFile, self._atlasFile, self._scale))
    end

    Avalon.ResHelper:unloadSpine(self._skeletonFile, self._atlasFile, self._scale, self, Animation._onLoadedSpineResHandler)

    self._skeletonFile = nil
    self._atlasFile = nil
    self._scale = 0
end

-- 初始化spine
function Animation:_initSpine(skeletonFile, atlasFile, scale, useAvalonAnimation)
    if (not self._spine) then
        local useAvAniFilter = false
        if (useAvalonAnimation and (skeletonFile:find("role_npc_function") or skeletonFile:find("role_hero") or skeletonFile:find("role_monster"))) then
            useAvAniFilter = true
        end
        if self._isBinary then
            self._spine = sp.AvalonAnimation:createWithBinaryFile(skeletonFile, atlasFile, scale, useAvAniFilter)
        else
            self._spine = sp.AvalonAnimation:create(skeletonFile, atlasFile, scale, useAvAniFilter)
        end
        -- self._spine:setScale(scale)
        self:addChild(self._spine)
        self._spine:setTag(self:getTag())
    end
end


-- public:
-- 构造函数
function Animation:ctor(skeletonFile, atlasFile, scale, useAvalonAnimation, startAfterLoading, isBinary)
    self._isBinary = isBinary
    self._visible = true;
    self._skeletonFile = skeletonFile;
    self._atlasFile = atlasFile
    self._scale = scale
    self._useAvalonAnimation = useAvalonAnimation or false and true
    self._startAfterLoading = startAfterLoading or false and true
    
    if (DEBUG) then
        print(string.format("[Avalon Animation] loading spine resouce %s %s %f. %s ", skeletonFile, atlasFile, scale, self))
    end

    if(skeletonFile == ".json" or atlasFile == " .json") then
        assert(false, string.format("Animation:ctor skeletonFile=%s",skeletonFile))
    end
    if(atlasFile == ".atlas" or atlasFile == " .atlas") then
        assert(false, string.format("Animation:ctor atlasFile=%s",skeletonFile))
    end

    Avalon.ResHelper:loadSpine(skeletonFile, atlasFile, scale, self, Animation._onLoadedSpineResHandler)

    -- 动画没有创建之前，暂存状态
    self._states = {}
    -- 替换附件属性，暂存状态
    self._attachmentStates = {}
    -- 动画没有创建之前，缓存注册事件
    self._events = {}

    -- 动画没创建之前，暂存组件
    self._components = {}
    self._skinName = nil
    self._timeScale = nil
    self._loadedSpineSuccessCallBack = nil
    self._setToSetupPose = nil
    self._isPaused = false
    self._action = nil

    -- 动画已经更新的时间
    self._animationUpdatedTime = 0
    -- 在动画被移除的时候是否卸载资源
    self._unloadResFlag = true

    -- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
            self:onEnter()
        elseif (nodeEvent == "exit") then
            -- add by zp 把这里注释掉了，在最后移除的时候才回收，这里主要是由于我把一个对象给切换父节点需要
            -- self:onExit()
        elseif (nodeEvent == "cleanup") then
            self:destroy()
        else end
    end
    self:registerScriptHandler(onNodeEventHandler)
end

-- 销毁
function Animation:destroy()
    if (DEBUG) then
        print(string.format("[Avalon Animation] unloading spine resouce %s %s %f. %s", self._skeletonFile, self._atlasFile, self._scale, self))
    end
    
    self:_clearState()
    self._states = {}
    self._attachmentStates = {}
    self._events = {}
    self:_clearComponents()
    self._components = {}
    self._action = nil

    if (self._unloadResFlag) then
        self:_removeSpineRes()
    else 
        -- 把该效果给记录起来，在切换场景的时候统一释放
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        if(machine) then
            machine:addDelayUnloadRes(self._skeletonFile, self._atlasFile, self._scale)
        end
    end
    self._skeletonFile = nil
    self._atlasFile = nil
    self._scale = 0
    -- body
    self._setToSetupPose = nil
    self._timeScale = nil
    self._loadedSpineSuccessCallBack = nil

    Avalon.ResHelper:unregisterCallback(self, self._onLoadedSpineResHandler)

    self:unregisterScriptHandler()
end

-- 设置动画
function Animation:setAnimation(trackIndex, animationName, loop)
    if(self._testHero) then
        print("Animation:setAnimation", trackIndex, animationName, loop)
    end
    if (self._spine) then
        -- self._spine:setSlotsToSetupPose()
        return self._spine:setAnimation(trackIndex, animationName, loop)
    else
        self:_clearState()

        local animationState = {
            [1] = trackIndex,
            [2] = animationName,
            [3] = loop
        }
        table.insert(self._states, animationState)
    end
end

-- 追加动画
function Animation:addAnimation(trackIndex, animationName, loop)
    if(self._testHero) then
        print("Animation:addAnimation", trackIndex, animationName, loop)
    end
    if (self._spine) then
        self._spine:addAnimation(trackIndex, animationName, loop)
    else
        local animationState = {
            [1] = trackIndex,
            [2] = animationName,
            [3] = loop
        }
        table.insert(self._states, animationState)
    end
end

-- 设置附件属性
function Animation:setAttachment(slotName,attachmentName)
    if not slotName or not attachmentName then
        return
    end

    if (self._spine) then
        self._spine:setAttachment(slotName, attachmentName)
    else
        local attachmentState = {
            [1] = slotName,
            [2] = attachmentName
        }
        table.insert(self._attachmentStates, attachmentState)
    end
end

function Animation:registerSpineEventHandler(callBack,eventType)
    if self._spine then
        self._spine:registerSpineEventHandler(callBack, eventType)
    else
        local eventData = {}
        eventData.callBack = callBack
        eventData.eventType = eventType

        table.insert(self._events,eventData)
    end
end

function Animation:setLoadedSpineSuccessCallBack(callBack)
    if self._spine then
        callBack()
    else
        self._loadedSpineSuccessCallBack = callBack
    end
end

--[[
挂载特效
slotName:
component:挂在的点
isDefaultOrder：是否默认层级，如果默认层级就是根据挂载点设置层级，这里初始化后就不会变动了。
dynamicOrder: 是否根据挂载点动态变动层级
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
        -- local slotNode = self._spine:getNodeForSlot(slotName, isDefaultOrder, dynamicOrder)
        if (slotNode) then
            slotNode:addChild(component)
        else
            assert(false, string.format("[ERROR] Avalon Animation: no slot node found for %s.", slotName))
        end
    else
        self._components[slotName] = component;
        component:retain()
    end
end

-- 是否延迟卸载资源
function Animation:setUnloadResFlag(flag)
    -- add by zp 这里修改为强制释放，避免效果内存没有释放的问题。这里在变身的时候存在对动画的处理逻辑，这个修改需要注意该问题。
    -- self._unloadResFlag = true
    self._unloadResFlag = (flag == nil) and true or flag
end

function Animation:stopSpineAction()
    if (self._spine) then
        self._spine:stopAllActions()
    end
end

function Animation:runSpineAction(action)
    if (self._spine) then
        self._spine:runAction(action)
        self._action = nil
    else
        self._action = action
    end
end

-- 节点onEnter
function Animation:onEnter()

end

-- 节点onExit
function Animation:onExit()
    self:destroy()
end

-- 设置动画spine 层级
function Animation:setSpineZOrder(zOrder)
    if self._spine then
        self._spine:setLocalZOrder(zOrder)
    else
        self._spineZOrder = zOrder
    end
end

-- 设置皮肤
function Animation:setSkin(skinName)
    if (self._spine) then
        self._spine:setSkin(skinName)
    else
        self._skinName = skinName
    end
end

function Animation:setGLProgramState(glProgramState)
    if(self._spine) then 
        self._spine:setGLProgramState(glProgramState)
    else 
        self._glProgramState = glProgramState
    end
end

-- 设置播放速度
function Animation:setTimeScale(timeScale)
    if (self._spine) then
        self._spine:setTimeScale(timeScale)
    else
        self._timeScale = timeScale
    end
end

-- 
function Animation:setToSetupPose()
    -- 设置skin 后需要调用该函数来重置状态，否则显示有问题
    if (self._spine) then
        self._spine:setToSetupPose()
    else
        self._setToSetupPose = true
    end
end

-- 获取boundingbox
function Animation:getBoundingBox()
    if (self._spine) then
        return self._spine:getBoundingBox()
    else
        return {x = 0, y=0, width =0, height = 0}
    end
end

function Animation:setOffSlotVisible(off)
    if (self._spine and self._spine.setOffSlotVisible) then
        return self._spine:setOffSlotVisible(off)
    end
end

-- 获取挂载节点
function Animation:getNodeForSlot(slotName)
    if (self._spine) then
        local slotNode = self._spine:getNodeForSlot(slotName)
        return slotNode
    else
        return nil
    end
end

-- 获取挂载点的位置
function Animation:getPositionOfSlot(slotName)
    if (self._spine) then
        local boneX, boneY = self._spine:getPositionOfSlot(slotName)
        local posX, posY = self:getPosition()
        return posX + boneX, posY + boneY
    else
        return 0, 0
    end
end

function Animation:getBoudingBox(slotName, isParent)
    -- body 
    if(self._spine) then
        return self._spine:getBoudingBox(slotName, isParent)
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

-- 获取当前动画名字
function Animation:getAnimationName(trackIndex)
    if self._spine then

        return self._spine:getAnimationName(trackIndex)
    end

    return nil
end

-- 是否被暂停
function Animation:isPaused()
    return self._isPaused
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

-- -- 设置为标准姿势
-- function Animation:setToSetupPose()
--     if (self._spine) then
--         self._spine:setToSetupPose()
--     end
-- end

-- 设置为标准姿势
function Animation:setBonesToSetupPose()
    if (self._spine) then
        self._spine:setBonesToSetupPose()
    end
end

-- 设置为标准姿势
function Animation:setSlotsToSetupPose()
    if (self._spine) then
        self._spine:setSlotsToSetupPose()
    end
end

-- 清理轨道
function Animation:clearTrack(trackIndex)
    if (self._spine) then
        self._spine:clearTrack(trackIndex)
    end
end

-- 同步时间
function Animation:updateTime(dt)
    if (not self._spine) then
        self._animationUpdatedTime = self._animationUpdatedTime + dt
    else
        self._spine:update(dt)
    end
end

-- 更新
function Animation:update(dt)
    if (not self._spine) then
        self._animationUpdatedTime = self._animationUpdatedTime + dt
    end
end

-- 动画混合
function Animation:setMix(fromAnimation, toAnimation, duration)
    self._spine:setMix(fromAnimation, toAnimation, duration)
end
function Animation:setVisible( visible )
    self._visible = visible
    getmetatable(self).setVisible(self,visible)

    if self._spine then
        self._spine:setVisible(visible)
    end
    -- print("AvalonAnimation.setVisible",visible)
end

function Animation:setTag(tag)
    -- Animation.super.setTag(self, tag)
    cc.Node.setTag(self, tag)
    if (self._spine) then
        self._spine:setTag(tag)
    end
end

function Animation:initWithFile(skeletonFile, atlasFile, scale)
    self._skeletonFile = skeletonFile
    self._atlasFile = atlasFile
    self._scale = scale
    if (self._spine) then
        self._spine:initWithFile(skeletonFile, atlasFile, scale)
    end
end

function Animation:getDescription()
    return "<" .. self.__cname .. " | Tag = " .. self:getTag() .. ", FileName = " .. self._skeletonFile .. ">"
end

function Animation:getSpineVersion()
    if sp.AvalonAnimation.getSpineVersion == nil then
        return 0
    else
        return sp.AvalonAnimation:getSpineVersion()
    end
end
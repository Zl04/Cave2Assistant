--[[
    UI组件基类
]]--

UI = UI or {}

require "app.ui.UIDefine"
require "app.ui.UIShader"
-- 资源管理
require "utils.res.ResHelper"
require "utils.IrregularShapeScreenUtil"

local Component  = class("Component", cc.Layer)
UI.Component = Component

-- 用于生成每个UI实例的唯一id
UI.InstanceCount = 0
-- 上一次点击的组件
UI.LastClickComponent = nil

-- private:
local ResHelper = Avalon.ResHelper
local director = cc.Director:getInstance()
local view = director:getOpenGLView()
local winSize = director:getWinSize()
local safeRect = director:getSafeAreaRect()
local DEBUG = false
local DEBUG_TOUCH = false
local DEBUG_DRAW = false

-- 组件的布局模式
local COM_LAYOUT_TYPE = UI.LayoutDefaultType 
-- 坐标计算方式
local COM_POSITION_TYPE = {
    PX = 1,
    PERCENT = 2
}

COM_RES_LEVEL = {
    LOW = 1,
    HIGH = 2,
}

-- 拖拽触发的距离
COMPONENT_DRAG_DISTANCE = 15.0
-- 是否开启双击功能
CONFIG_DOUBLIE_CLICK = false

local MIN_TOUCH_SIZE = cc.size(60, 60)

-- 获取着色器
local function getShader(self, shaderDefine)
    assert(type(shaderDefine) == "table", "Component createShader: shader define is invalid.")

    if (shaderDefine) then
        local shaderKey = shaderDefine.KEY
        local vertShader = shaderDefine.VERT_SHADER
        local fragShader = shaderDefine.FRAG_SHADER

        -- local glProgram = cc.GLProgramCache:getInstance():getGLProgram(shaderKey)
        -- if (not glProgram) then
        --     glProgram = cc.GLProgram:createWithFilenames(vertShader, fragShader)
	    --     cc.GLProgramCache:getInstance():addGLProgram(glProgram, shaderKey)
        -- end
        -- if (glProgram) then
        --     return cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
        -- end

        return AvalonUtil:getGLProgramState(vertShader, fragShader, shaderKey)
    else
        assert(false)
    end
    assert(false)
    return nil
end

-- 绘制调试图形
local function drawDebugRect(self)
    if (self._drawNode) then
        self._drawNode:removeFromParent()
        self._drawNode = nil
    end
    if (self._enableDebugDraw) then
        if (not self._drawNode) then
            self._drawNode = cc.DrawNode:create()
            self:addChild(self._drawNode, 10000)
        end

        if (self._drawNode) then
            if (self._drawSolid) then
                self._drawNode:drawSolidRect(
                    {x = 0, y = 0}, 
                    {x = self._width, y = self._height}, 
                    self._drawColor
                )
            else
                self._drawNode:drawRect(
                    {x = 0, y = 0}, 
                    {x = self._width, y = self._height}, 
                    self._drawColor
                )
            end
        end
    end
end

-- 资源加载完成
local function onLoadedResList(self)
    if (DEBUG) then
        print(string.format("Component onLoadedResList: type:%d.", self._type))
    end

    if (not self._isResLoaded) then
        self._isResLoaded = true
        
        if (self._inited) then
            self:initView()
            self:updateView()
        end
    else
        if (DEBUG) then
            print(string.format("Component onEnter: res list has been loaded for Component, type:%d.", self._type))
        end
    end
end

-- 加载资源  如果是同步加载 只加载优先级为high的资源
local function loadResList(self, async)
    if (DEBUG) then
        print(string.format("Component loadResList: loading res list for Component, type:%d.", self._type))
    end

    async = async or false

    local resList = self._resList
    -- 异步方式
    if (async) then
        self._isResLoaded = false

        ResHelper:beginLoading(self, onLoadedResList)
        for i = 1, #resList do
            local resName = resList[i]
            if (DEBUG) then
                print(string.format("Component: load res (id:%d name:%s) async.", i, resName))
            end
            ResHelper:pushPlist(resName)
        end
        ResHelper:endLoading()
    -- 同步方式
    else
        --todo 分层加载
        for i = 1, #resList do
            local res = resList[i]
            -- if (DEBUG) then
            --     print(string.format("Component: load res (id:%d name:%s) sync.", i, resName))
            -- end
            if type(res) == "table" then
                if res.priority == COM_RES_LEVEL.HIGH then
                    ResHelper:loadPlistSync(res.name)
                    res.isLoaded = true
                end
            else
                ResHelper:loadPlistSync(res)
            end
        end

        self._isResLoaded = true
    end
end


-- 加载资源  加载优先级为Low的资源 默认是同步加载
local function loadExtraRes(self)
    local resList = self._resList or {}
    --todo 分层加载
    for i = 1, #resList do
        local res = resList[i]
        if type(res) == "table" then
            if res.priority == COM_RES_LEVEL.LOW then
                ResHelper:loadPlistSync(res.name)
                res.isLoaded = true
            end
        end
    end
end

-- 卸载资源
local function unloadResList(self)
    if (DEBUG) then
        print(string.format("Component unloadResList: unloading res list for Component, type:%d.", self._type))
    end

    local resList = self._resList
    if (resList) then
        for i = 1, #resList do
            local res = resList[i]
            -- if (DEBUG) then
            --     print(string.format("Component: unload res (id:%d name:%s).", i, resName))
            -- end
            if type(res) == "table" then
                if res.isLoaded == true then
                    ResHelper:unloadPlist(res.name)
                    res.isLoaded = false
                end
            else
                ResHelper:unloadPlist(res)
            end
        end
    else
        if (DEBUG) then
            print(string.format("Component: no res list to unload for Component, type:%d.", self._type))
        end
    end
end

-- 获取父容器的尺寸
local function getParentSize(self)
    local pWidth, pHeight = 0, 0

    local parent = self:getParent()
    if (parent) then
        if (UI.UIManager:isRootNode(parent)) then
            local winSize = cc.Director:getInstance():getWinSize()
            pWidth, pHeight = winSize.width, winSize.height
            if (DEBUG) then
                print(string.format("Component getParentSize: parent is root node, use win size (%f,%f).", pWidth, pHeight))
            end
        else
            local size = parent:getContentSize()
            pWidth, pHeight = size.width, size.height
        end
    end
    if (DEBUG) then
        print(string.format("Component getParentSize: parent size (%f,%f).", pWidth, pHeight))
    end
    return pWidth, pHeight
end

-- 计算相对于左上角的坐标
local function computePositionToLeftTop(self, posX, posY)
    local parent = self:getParent()
    if (parent) then
        local pWidth, pHeight = getParentSize(self)

        local posX, posY = self._posX, self._posY
        posY = pHeight - (self._height + posY)
        if (DEBUG) then
            print(string.format("Component computePositionToLeftTop: node position from (%f,%f) to (%f,%f).", self._posX, self._posY, posX, posY))
        end

        return posX, posY
    else
        return 0, 0
    end
end

-- 计算不同布局方式的坐标
local function computePositionForLayout(self)
    if not self._enableAutoUpdatePos then
        return self:getPosition()
    end
    local layoutType = self._layoutType
    local positionType = self._positionType

    local px, py = 0, 0
    if (self:getParent()) then
        local oriPw, oriPh = getParentSize(self)
        local pw, ph = oriPw, oriPh
        local issT, issR, issB, issL = 0, 0, 0, 0
        if (self._enableIrregularShapeScreenAdjustment) then
            pw, ph = pw - Avalon.issUtil:getWidthOffset(), ph - Avalon.issUtil:getHeightOffset()
            issT = Avalon.issUtil:getTopMargin()
            issR = Avalon.issUtil:getRightMargin()
            issB = Avalon.issUtil:getBottomMargin()
            issL = Avalon.issUtil:getLeftMargin()
        end

        -- 左上角（默认）
        if (layoutType == COM_LAYOUT_TYPE.DEFAULT) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = self._posX + issL, oriPh - (self._height + self._posY + issT)
            else
                px, py = self._posX * pw + issL, oriPh - (self._height + self._posY * ph + issT)
            end
        -- 居中
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER) then 
            px, py = issL + (pw - self._width) / 2, issB + (ph - self._height) / 2
            px = px + self._left
            py = py - self._up
        -- 左上
        elseif (layoutType == COM_LAYOUT_TYPE.LEFT_UP) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = self._left + issL, oriPh - (self._height + self._up + issT)
            else
                px, py = self._left * pw + issL, oriPh - (self._height + self._up * ph + issT)
            end
        -- 左下
        elseif (layoutType == COM_LAYOUT_TYPE.LEFT_BOTTOM) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = self._left + issL, self._bottom + issB
            else
                px, py = self._left * pw + issL, self._bottom * ph + issB
            end
        -- 右上
        elseif (layoutType == COM_LAYOUT_TYPE.RIGHT_UP) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = (oriPw - self._width - self._right - issR), (oriPh - self._height - self._up - issT)
            else
                px, py = (oriPw - self._width - self._right * pw - issR), (oriPh - self._height - self._up * ph - issT)
            end
        -- 右下
        elseif (layoutType == COM_LAYOUT_TYPE.RIGHT_BOTTOM) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = (oriPw - self._width - self._right - issR), self._bottom + issB
            else
                px, py = (oriPw - self._width - self._right * pw - issR), self._bottom * ph + issB
            end
        -- 中上
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER_UP) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = issL + (pw - self._width) / 2, (oriPh - self._height - self._up - issT)
            else
                px, py = issL + (pw - self._width) / 2, (oriPh - self._height - self._up * ph - issT)
            end
            px = px + self._left
        -- 中下
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER_BOTTOM) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = issL + (pw - self._width) / 2, self._bottom + issB
            else
                px, py = issL + (pw - self._width) / 2, self._bottom * ph + issB
            end
            px = px + self._left
        -- 中左
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER_LEFT) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = self._left + issL, issB + (ph - self._height) / 2 - self._up
            else
                px, py = self._left * pw + issL, issB + (ph - self._height) / 2 - self._up
            end
            py = py - self._up
        -- 中右
        elseif (layoutType == COM_LAYOUT_TYPE.CENTER_RIGHT) then
            if (positionType == COM_POSITION_TYPE.PX) then
                px, py = (oriPw - self._width - self._right - issR), issB + (ph - self._height) / 2
            else
                px, py = (oriPw - self._width - self._right * pw - issR), issB + (ph - self._height) / 2
            end
            py = py - self._up
        else
            assert(false)
        end
        self._posX, self._posY = px, (oriPh - py - self._height)

        if (DEBUG) then
            print(string.format("Component computePositionForLayout: layout type:%d, parent size:(%f,%f), component size:(%f,%f), offset:(%f,%f).", layoutType, pw, ph, self._width, self._height, px, py))
        end
    end
    return px, py
end

-- 注册节点事件
local function registerNodeEvent(self)
    -- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
            self:onEnter()
        -- elseif (nodeEvent == "enterTransitionFinish") then
        --     self:onEnter()
            self:dispatchEvent(UIEvent.EVENT_ONENTER, self)
        elseif (nodeEvent == "exit") then
            self:onExit()
            self:dispatchEvent(UIEvent.EVENT_ONEXIT, self)
        elseif (nodeEvent == "cleanup") then
            self:dtor()
        else end
    end
    self:registerScriptHandler(onNodeEventHandler)
end

-- 调整组建的位置
local function adjustComponentPosition(self)
    if not self._enableAutoUpdatePos then
        return
    end
    -- 如果有背景图片，居中显示
    if (self._backgroudImage) then
        self._backgroudImage:setPosition(self._hw, self._hh)
    end

    -- 更新坐标
    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
    local children = self:getChildren()
    if (children) then
        for i = 1, #children do
            local child = children[i]
            if (child.__isComponent__) then
                local posX, posY = computePositionForLayout(child)
                child:setPosition(posX, posY)
            end
        end
    end
end

-- 构造函数
function Component:ctor(comType, resList, width, height, asyncToLoadRes)
    if (DEBUG) then
        print("Component constructor:", comType)
    end

    if (comType) then assert(type(comType) == "number", "[ERROR] Component constructor: component type is invalid.") end
    if (resList) then assert(type(resList) == "table", "[ERROR] Component constructor: res list is invalid.") end
    if (width) then assert(type(width) == "number", "[ERROR] Component constructor: width is invalid.") end
    if (height) then assert(type(height) == "number", "[ERROR] Component constructor: height is invalid.") end

    UI.InstanceCount = UI.InstanceCount + 1
    self._id = UI.InstanceCount
    self._type = comType
    -- 资源列表
    if (resList) then self._resList = resList
    else self._resList = {}
    end
    -- 标记
    self._isResLoaded = false
    self._inited = false
    self._initView = false
    self._updateView = false

    -- 坐标
    self._enableAutoUpdatePos = true
    self._posX = 0
    self._posY = 0
    self._left = 0
    self._right = 0
    self._up = 0
    self._bottom = 0
    self._floatLeft = 0
    self._floatRight = 0
    self._floatUp = 0
    self._floatBottom = 0
    -- 尺寸
    self._width = width or 0
    self._height = height or 0
    self._hw = self._width / 2
    self._hh = self._height / 2
    -- 组件布局类型
    self._layoutType = COM_LAYOUT_TYPE.DEFAULT
    self._positionType = COM_POSITION_TYPE.PX
    self._floatType = LayoutFloatType.NONE
    -- 事件处理器
    self._eventHandlerMap = {}
    -- 点击事件
    self._enableMinTouchSize = true
    self._enableTouch = false       -- 是否启用点击，如果启用才会触发touch的所有事件
    self._swallowedTouch = true     -- 是否吞噬事件，表示事件不会被更上层的节点捕获
    self._interceptedTouch = false  -- 是否拦截事件，如果设置了拦截，即使在组件包围盒外的点击事件都会被处理并吞噬
    self._touchOutside = false
    self._listener = nil
    self._clickTime = 0
    self._touchBegan = false
    self._touchBeganPosition = nil
    self._closeDrag = false --是否关闭  拖拽功能
    self._enableDrag = false
    self._enableIrregularShapeScreenAdjustment = false
    -- 调试节点
    self._drawNode = nil
    self._drawColor = nil
    self._drawSolid = false
    self._enableDebugDraw = false

    -- 序列化
    self.reflectScale = cc.p(1.0, 1.0)
    self.reflectPos = cc.p(0, 0)
    self.reflectRotate = 0
    self.reflectSize = cc.size(self._width, self._height)
    self.name = ""

    self.clickAudioID = "1503"
    self.clickAudioEnable = false
    -- 适配分辨率的背景图片
    self._backgroudImage = nil
    -- 是否隐藏显示
    self._visible = true;
    
    -- 更新尺寸
    self:setContentSize(self._width, self._height)
    -- 注册节点事件
    registerNodeEvent(self)
    -- 加载资源
    asyncToLoadRes = asyncToLoadRes or false
    loadResList(self, asyncToLoadRes)

    -- 内部标示是否是lua组件
    self.__isComponent__ = true

    self:setCascadeOpacityEnabled(true)
end

-- 析构函数
function Component:dtor()
    if (DEBUG) then
        print("Component destructor:")
    end

    self:dispatchEvent(UIEvent.EVENT_CLEANUP)

    local StoryManager = require("app.story.StoryManager")
    StoryManager:getInstance():removeUICondition(self)

    -- 删除touch事件
    self:removeTouchEvents()
    -- 删除节点事件
    self:unregisterScriptHandler()
    -- 卸载资源
    unloadResList(self)

    self._resList = nil
    for eventName, handlerList in pairs(self._eventHandlerMap) do
        self._eventHandlerMap[eventName] = nil
    end
    self._eventHandlerMap = nil
    self._listener = nil
    self._touchBeganPosition = nil
    self._drawNode = nil
    self._drawColor = nil
    self._backgroudImage = nil
    self._visible = false
end

-- public:
-- 初始化
function Component:init(...)
    if (not self._inited) then
        self._inited = true
        
        self:initView(...)
    else
        error(string.format("Component init: the component %d is already inited.", self._type))
    end
end

-- 销毁
function Component:destroy()
    if (self:getParent()) then self:removeFromParent()
    else self:dtor()
    end
end

-- 获取组件id
function Component:getId()
    return self._id
end

-- 获取类型
function Component:getType()
    return self._type
end

function Component:setType(_type)
    self._type = _type
end

-- 设置是否启用异形屏幕适配
function Component:enableIrregularShapeScreenAdjustment(b)
    self._enableIrregularShapeScreenAdjustment = b
end

-- 获取布局类型
function Component:getLayoutType()
    return self._layoutType
end

-- 获取浮动类型
function Component:getFloatType()
    return self._floatType
end

-- 获取布局用的左间距
function Component:getLeft()
    if (self._floatType == LayoutFloatType.NONE) then
        return self._left
    else
        return self._floatLeft
    end
end

-- 获取布局用的右间距
function Component:getRight()
    if (self._floatType == LayoutFloatType.NONE) then
        return self._right
    else
        return self._floatRight
    end
end

-- 获取布局用的上间距
function Component:getUp()
    if (self._floatType == LayoutFloatType.NONE) then
        return self._up
    else
        return self._floatUp
    end
end

-- 获取布局用的下间距
function Component:getBottom()
    if (self._floatType == LayoutFloatType.NONE) then
        return self._bottom
    else
        return self._floatBottom
    end
end

-- 设置坐标计算方式
function Component:enablePercentPosition()
    if (self._positionType ~= COM_POSITION_TYPE.PERCENT) then
        self._positionType = COM_POSITION_TYPE.PERCENT
    end
end

-- 设置坐标（相对于左上角）
function Component:setPos(posX, posY)
    assert(type(posX) == "number", "[ERROR] Component setPos: position x is invalid.")
    assert(type(posY) == "number", "[ERROR] Component setPos: position y is invalid.")
    if (DEBUG) then
        print(string.format("Component setPos: set position (%f,%f).", posX, posY))
    end
    posX = posX or 0
    posY = posY or 0

    self._layoutType = COM_LAYOUT_TYPE.DEFAULT
    self._posX = posX
    self._posY = posY

    local _posX, _posY = computePositionForLayout(self)
    self:setPosition(_posX, _posY)
end

-- 获取坐标
function Component:getPos()
    if (DEBUG) then
        print(string.format("Component getPos: get position (%f,%f).", self._posX, self._posY))
    end

    return self._posX, self._posY
end

-- 获取中心点坐标
function Component:getCenterPos()
    local centerPosX = self._posX + self._hw
    local centerPosY = self._posY + self._hh
    if (DEBUG) then
        print(string.format("Component getCenterPos: get center position (%f,%f).", centerPosX, centerPosY))
    end

    return centerPosX, centerPosY
end

-- 设置尺寸
function Component:setSize(width, height, isForbidDispatch)
    assert(type(width) == "number" and width >= 0, "[ERROR] Component setSize: width is invalid.")
    assert(type(height) == "number" and height >= 0, "[ERROR] Component setSize: height is invalid.")
    if (DEBUG) then
        print(string.format("Component setSize: set size (%f,%f).", width, height))
    end

    local originalWidth = self._width
    local originalHeight = self._height

    self.reflectSize.width = width  
    self.reflectSize.height = height

    self._width = width
    self._height = height
    self._hw = width / 2
    self._hh = height / 2
    
    self:setContentSize(width, height)

    adjustComponentPosition(self)

    self:onSizeChanged(originalWidth, originalHeight)
    if isForbidDispatch then
    else
        self:dispatchEvent(UIEvent.COMPONENT_SIZE_CHANGED, self, width, height)
    end

    if self._enableDebugDraw then
        drawDebugRect(self)
    end
end

-- 获取尺寸
function Component:getSize()
    if (DEBUG) then
        print(string.format("Component getSize: get size (%f,%f).", self._width, self._height))
    end

    return self._width, self._height
end

-- 移除所有组件
function Component:removeChildren()
    if (DEBUG) then
        print(string.format("Component removeChildren: remove all the children."))
    end

    self:removeAllChildren()

    if (self._enableDebugDraw) then
        self._drawNode = nil
    end
end

-- 刷新坐标位置
function Component:refreshPosition()
    adjustComponentPosition(self)
end

-- 显示组件视图
function Component:show()
    self:setVisible(true)
end

-- 隐藏组件视图
function Component:hide()
    self:setVisible(false)
end
function Component:setVisible( visible )
    self._visible = visible
    getmetatable(self).setVisible(self,visible)
    
    local parent = self:getParent()
    if (parent and parent.getType and parent:getType() == UIType.LAYOUT and parent:isAutoSize()) then
        parent:onUpdateView()
    end
end
-- 关闭
function Component:close()
    self._visible = false;
    if (UI.UIManager) then
        UI.UIManager:removeComponent(self)
    else
        self:runAction(
            cc.RemoveSelf:create()
        )
    end


    local mActivityLayer = UI.UIManager.mActivityLayer
    if(not tolua.isnull(mActivityLayer)) then
        if(mActivityLayer:getChildrenNum() >= 1)then
            return 
        end
    end
    if mvc and mvc.panelMonitor then
        mvc.panelMonitor:showTopPanel()
    end
end

-- 是否已经初始化视图
function Component:isViewInited()
    return self._initView
end

-- 是否已经更新过视图
function Component:isViewUpdated()
    return self._updateView
end

-- 适配背景图片
function Component:setBackgroundImage(spriteFrameName)
    assert(type("spriteFrameName") == "string", "Component setBackgroundImage: sprite frame name is invalid.")

    if (not self._backgroudImage) then
        self._backgroudImage = cc.Sprite:createWithSpriteFrameName(spriteFrameName)
        --self._backgroudImage:initWithSpriteFrameName()

        local bgSpriteSize = self._backgroudImage:getContentSize()
        if (DEBUG) then
            print("Component setBackgroundImage: window size:(%f,%f), background size:(%f,%f).", winSize.width, winSize.height, bgSpriteSize.width, bgSpriteSize.height)
        end
        if (bgSpriteSize.width >= winSize.width and bgSpriteSize.height >= winSize.height) then
            self._backgroudImage:setScale(1.0)
        else
            local sx = winSize.width / bgSpriteSize.width
            local sy = winSize.height / bgSpriteSize.height
            if (sy >= sx) then
                self._backgroudImage:setScale(sy)
            else
                self._backgroudImage:setScaleX(sx)
                self._backgroudImage:setScaleY(sy)
            end
        end
        self:addChild(self._backgroudImage, 0)
    else
        self._backgroudImage:setSpriteFrame(spriteFrameName)
    end
    if (self._updateView) then
        self._backgroudImage:setPosition(self._hw, self._hh)
    end
end

-- 适配图片
function Component:getImage(spriteFrameName)
    assert(type("spriteFrameName") == "string", "Component getImage: sprite frame name is invalid.")

    if (not self._image) then
        self._image = cc.Sprite:create()
        self._image:initWithSpriteFrameName(spriteFrameName)

        local bgSpriteSize = self._image:getContentSize()
        if (DEBUG) then
            print("Component getImage: window size:(%f,%f), background size:(%f,%f).", winSize.width, winSize.height, bgSpriteSize.width, bgSpriteSize.height)
        end
        if (bgSpriteSize.width >= winSize.width and bgSpriteSize.height >= winSize.height) then
            self._backgroudImage:setScale(1.0)
        else
            local sx = winSize.width / bgSpriteSize.width
            local sy = winSize.height / bgSpriteSize.height
            if (sy >= sx) then
                self._image:setScale(sy)
            else
                self._image:setScaleX(sx)
                self._image:setScaleY(sy)
            end
        end
        -- self:addChild(self._backgroudImage, 0)
    else
        -- self._image:setSpriteFrame(spriteFrameName)
    end

    return self._image
end

-- 初始化组件视图
function Component:initView(...)
    if (self._isResLoaded) then
        if (DEBUG) then
            print(string.format("Component initView: init the view for component, type:%d.", self._type))
        end
        if (DEBUG_DRAW) then
            local r, g, b, a = math.random(), math.random(), math.random(), 1.0
            r = (r >= 0.5) and r or r + 0.2
            g = (r >= 0.5) and g or g + 0.2
            b = (r >= 0.5) and b or b + 0.2
            self:enableDebugDraw({
                r = r, g = g, b = b, a = a
            })
        end

        -- 调用子类的模版函数
        self:onInitView(...)

        self._initView = true
    else
        if (DEBUG) then
            print(string.format("Component initView: wait the res to be loaded, type:%d.", self._type))
        end
    end
end

-- 更新组件视图
function Component:updateView(...)
    if (self._isResLoaded) then
        if (DEBUG) then
            print(string.format("Component updateView: update the view for component, type:%d.", self._type))
        end
        --todo  低级资源
        -- 调用子类的模版函数
        self:onUpdateView(...)

        self._updateView = true
    else    
        if (DEBUG) then
            print(string.format("Component updateView: wait the res to be loaded, type:%d.", self._type))
        end
    end

    if (self._enableDebugDraw) then
        if (self._drawNode) then
            if (self._drawSolid) then
                self._drawNode:drawSolidRect(
                    {x = 0, y = 0}, 
                    {x = self._width, y = self._height}, 
                    self._drawColor
                )
            else
                self._drawNode:drawRect(
                    {x = 0, y = 0}, 
                    {x = self._width, y = self._height}, 
                    self._drawColor
                )
            end
        end
    end

    local StoryManager = require("app.story.StoryManager")
    StoryManager:getInstance():addUICondition(self)
end

-- 节点onEnter处理器
function Component:onEnter()
    if (DEBUG) then
        print("Component onEnter:", self._type, self._inited)
    end

    if (self._inited) then
        -- 调整组件的位置
        adjustComponentPosition(self)
        -- 更新视图
        if self:isHaveExtraRes() then
            -- local resList = clone(self._resList)
            Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
                loadExtraRes(self)
                if self.updateView ~= nil then
                    self:updateView()
                end
            end, 1)
        else
            self:updateView()
        end
        if (self._enableDebugDraw) then
            drawDebugRect(self)
        end
    else
        print(self.__cname)
        error("Component onEnter: component not inited before added to parent.%s")
    end

    self:dispatchEvent(UIEvent.EVENT_ONENTER)
end

function Component:isHaveExtraRes()
    local resList = self._resList
    for i = 1, #resList do 
        local res = resList[i]
        if type(res) == "table" then
            if res.priority == COM_RES_LEVEL.LOW then
                return true
            end
        end
    end
    return false
end

-- 节点onExit处理器
function Component:onExit()
    if (DEBUG) then
        print("Component onExit:")
    end
    -- 不需要在exit调用析构 onExit本来应该是退出这个节点,类似unity的OnDisable,节点完全释放的时候
    -- 调用oncleanup的时候才应该执行清理
    -- self:dtor()

    self:dispatchEvent(UIEvent.EVENT_ONEXIT)
end

--设定自定义的可点击区域，优先级最高
function Component:setCustomToucRect(rect)
    self.customToucRect = rect
end

--是否开启最小可点击区域
function Component:setEnableMinTouchSize(enable)
    if enable == nil then
        enable = true
    end
    self._enableMinTouchSize = enable
end
-- 检测点击是否在安全区域内
function Component:isTouchInSafeArea(touchPosition)
    local check = cc.rectContainsPoint(safeRect, touchPosition)
    return check
end

-- 触摸点是否在举行区域
function Component:checkTouch(touch)
    local touchPosition = touch:getLocation()
    return self:checkTouchPosition(touchPosition)
end

function Component:checkTouchPosition(touchPosition)
    local localPosition = self:convertToNodeSpace(touchPosition)
    if self.touchClipNode then
        local touchInClipPos = self.touchClipNode:convertToNodeSpace(touchPosition);
        local clipSize = self.touchClipNode:getContentSize();
        if self.touchClipNode.getViewSize then
            clipSize = self.touchClipNode:getViewSize()
        end
        local clipRect = cc.rect(0.0, 0.0, clipSize.width, clipSize.height)
        if not cc.rectContainsPoint(clipRect, touchInClipPos) then
            return false
        end
    end
   
    local rect = nil
    if self.customToucRect ~= nil then
        rect = self.customToucRect
    else
        local touchSize = cc.size(self._width, self._height)
        local startPos = cc.p(0, 0)
        if self._enableMinTouchSize then
            if touchSize.width < MIN_TOUCH_SIZE.width then
                startPos.x = (touchSize.width - MIN_TOUCH_SIZE.width) / 2
                touchSize.width = MIN_TOUCH_SIZE.width
            end

            if touchSize.height < MIN_TOUCH_SIZE.height then
                startPos.y = (touchSize.height - MIN_TOUCH_SIZE.height) / 2
                touchSize.height = MIN_TOUCH_SIZE.height
            end
        end
        rect = cc.rect(startPos.x, startPos.y, touchSize.width, touchSize.height)
    end

    if (DEBUG_TOUCH) then
        print(string.format("Component checkTouch: touch position:(%f,%f), local position:(%f,%f).", touchPosition.x, touchPosition.y, localPosition.x, localPosition.y))
        -- print(string.format("Component checkTouch: position:(%f,%f), constent size:(%f,%f), rect:(%f,%f,%f,%f).", posX, posY, size.width, size.height, rect.x, rect.y, rect.width, rect.height))
    end

    local check = cc.rectContainsPoint(rect, localPosition)
    -- if check then
    --     print("customToucRect : ", self.customToucRect)
    --     print("_enableMinTouchSize : ", self._width, self._height, touchSize.width, touchSize.height)
    -- end
    return check
end

-- 添加事件监听器
function Component:addEventListener(eventName, target, callback)
    assert(type(eventName) == "number", "Component addEventListener: event name is invalid.")
    assert(type(target) == "table" or type(target) == "userdata", "Component addEventListener: target is invalid.")
    assert(type(callback) == "function", "Component addEventListener: callback is invalid.")
    if (eventName == UIEvent.COMPONENT_TOUCH_BEGAN or
        eventName == UIEvent.COMPONENT_TOUCH_MOVED or
        eventName == UIEvent.COMPONENT_TOUCH_ENDED or
        eventName == UIEvent.COMPONENT_CLICK or
        eventName == UIEvent.COMPONENT_DOUBLE_CLICK or
        eventName == UIEvent.COMPONENT_DRAG or
        eventName == UIEvent.COMPONENT_DRAG_ENDED) then
        assert(self._enableTouch, "Component addEventListener: should enable the touch events before use component events.")
    end

    local handler = {
        [1] = target,
        [2] = callback
    }
    local handlerList = self._eventHandlerMap[eventName]
    if (not handlerList) then
        handlerList = {}
        self._eventHandlerMap[eventName] = handlerList
    end
    table.insert(handlerList, handler)
end

-- 移除事件监听器
function Component:removeEventListener(eventName, target, callback)
    print("---------Component:removeEventListener  "..eventName, target)
    assert(type(eventName) == "number", "Component removeEventListener: event name is invalid.")
    assert(type(target) == "table" or type(target) == "userdata", "Component removeEventListener: target is invalid.")
    assert(type(callback) == "function", "Component removeEventListener: callback is invalid.")

    local found = false
    local handlerList = self._eventHandlerMap[eventName]
    if (handlerList) then
        for i = 1, #handlerList do
            local handler = handlerList[i]
            if (handler) then
                if (handler[1] == target and handler[2] == callback) then
                    table.remove(handlerList, i)
                    found = true
                    break
                end
            else 
                assert(false) 
            end
        end
    else 
        -- assert(false) 
    end
    -- assert(found)
end

-- 移除事件监听器
function Component:removeEventListenerByName(eventName)
    self._eventHandlerMap[eventName] = nil
end

function Component:_isTouchVisible()
    local curNode = self
    while curNode do
        if not curNode:isVisible() then
            return false
        end
        curNode = curNode:getParent()
    end

    return true
end

-- 分发事件
function Component:dispatchEvent(eventName, ...)
    assert(type(eventName) == "number", "Component dispatchEvent: event name is invalid.")
    local rs = nil
    if self._eventHandlerMap then
        local handlerList = self._eventHandlerMap[eventName]
        if (handlerList) then
            for i = 1, #handlerList do
                local handler = handlerList[i]
                if (handler and handler[2] and handler[1]) then
                    rs = handler[2](handler[1], ...)
                else 
                    printError("dispatchEvent handler error eventName ", eventName, handler, handler[1], handler[2])
                    -- assert(false) 
                end
            end
        end
    end
    return rs;
end

function Component:isEventRegisterd(eventName)
    local handlerList = self._eventHandlerMap[eventName]
    return handlerList ~= nil
end

-- 移动到
function Component:MoveTo(dt, px, py)
   self:runAction(cc.MoveTo:create(dt,cc.p(px,py)))
end

-- 序列化系列函数 -----------------------start

function Component:setReflectSize(arg1, arg2)
    if type(arg1) == "table" then
        self.reflectSize.width = arg1.width
        self.reflectSize.height = arg1.height
    else
        arg1 = arg1 == nil and 0 or arg1
        arg2 = arg2 == nil and 0 or arg2
        self.reflectSize.width = arg1
        self.reflectSize.height = arg2
    end
    self:setSize(self.reflectSize.width, self.reflectSize.height)
end

function Component:setReflectPos(arg1, arg2)
    if type(arg1) == "table" then
        self.reflectPos.x = arg1.x
        self.reflectPos.y = arg1.y
    else
        arg1 = arg1 == nil and 0 or arg1
        arg2 = arg2 == nil and 0 or arg2
        self.reflectPos.x = arg1
        self.reflectPos.y = arg2
    end

    self._left = self.reflectPos.x
    self._right = self.reflectPos.x
    self._up = self.reflectPos.y
    self._bottom = self.reflectPos.y

    self._posX = self.reflectPos.x
    self._posY = self.reflectPos.y

end

function Component:setLayoutType(layoutType)
    self._layoutType = layoutType
end

function Component:computePosition()
    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end
-- 序列化系列函数 -----------------------end 

-- 居中
function Component:center(x, y)
    self._layoutType = COM_LAYOUT_TYPE.CENTER
    self._left = x or 0
    self._up = y or 0
    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end

-- 上下居中，对齐左端
function Component:centerLeft(left, up)
    assert(type(left) == "number", "Component centerLeft: left is invalid.")

    self._layoutType = COM_LAYOUT_TYPE.CENTER_LEFT
    self._left = left or 0
    self._up = up or 0

    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end

-- 上下居中，对齐右端
function Component:centerRight(right, up)
    assert(type(right) == "number", "Component centerRight: right is invalid.")

    self._layoutType = COM_LAYOUT_TYPE.CENTER_RIGHT
    self._right = right or 0
    self._up = up or 0

    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end

-- 水平居中，对齐上端
function Component:centerUp(up,left)
    assert(type(up) == "number", "Component centerUp: up is invalid.")

    self._layoutType = COM_LAYOUT_TYPE.CENTER_UP
    self._up = up or 0
    self._left = left or 0
    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end

-- 水平居中，对齐下端
function Component:centerBottom(bottom,left)
    assert(type(bottom) == "number", "Component centerBottom: bottom is invalid.")

    self._layoutType = COM_LAYOUT_TYPE.CENTER_BOTTOM
    self._bottom = bottom or 0
    self._left = left or 0
    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end

-- 左上角对齐
function Component:leftUp(left, up)
    assert(type(left) == "number", "Component leftUp: left is invalid.")
    assert(type(up) == "number", "Component leftUp: up is invalid.")

    self._layoutType = COM_LAYOUT_TYPE.LEFT_UP
    self._left = left or 0
    self._up = up or 0

    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY) 
end

-- 左下角对齐
function Component:leftBottom(left, bottom)
    assert(type(left) == "number", "Component leftBottom: left is invalid.")
    assert(type(bottom) == "number", "Component leftBottom: bottom is invalid.")

    self._layoutType = COM_LAYOUT_TYPE.LEFT_BOTTOM
    self._left = left or 0
    self._bottom = bottom or 0

    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end

-- 右上角对齐
function Component:rightUp(right, up)
    assert(type(right) == "number", "Component rightUp: right is invalid.")
    assert(type(up) == "number", "Component rightUp: up is invalid.")

    self._layoutType = COM_LAYOUT_TYPE.RIGHT_UP
    self._right = right or 0
    self._up = up or 0

    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end

-- 右下角对齐
function Component:rightBottom(right, bottom)
    assert(type(right) == "number", "Component rightBottom: right is invalid.")
    assert(type(bottom) == "number", "Component rightBottom: bottom is invalid.")

    self._layoutType = COM_LAYOUT_TYPE.RIGHT_BOTTOM
    self._right = right or 0
    self._bottom = bottom or 0

    local posX, posY = computePositionForLayout(self)
    self:setPosition(posX, posY)
end

-- 浮动向左布局
function Component:floatLeft(left)
    assert(type(left) == "number", "Component floatLeft: left is invalid.")

    local floatType = self._floatType
    if (floatType == LayoutFloatType.NONE) then
        floatType = LayoutFloatType.FLOAT_LEFT
    elseif (floatType == LayoutFloatType.FLOAT_RIGHT or
        floatType == LayoutFloatType.FLOAT_RIGHT_UP or
        floatType == LayoutFloatType.FLOAT_RIGHT_BOTTOM) then
        floatType = floatType - 1
    end
    self._floatType = LayoutFloatType.FLOAT_LEFT
    self._floatLeft = left or 0
end

-- 浮动向右布局
function Component:floatRight(right)
    assert(type(right) == "number", "Component floatRight: right is invalid.")

    local floatType = self._floatType
    if (floatType == LayoutFloatType.NONE) then
        floatType = LayoutFloatType.FLOAT_RIGHT
    elseif (floatType == LayoutFloatType.FLOAT_LEFT or
        floatType == LayoutFloatType.FLOAT_LEFT_UP or
        floatType == LayoutFloatType.FLOAT_LEFT_BOTTOM) then
        floatType = floatType + 1
    end
    self._floatType = floatType
    self._floatRight = right or 0
end

-- 向上浮动布局
function Component:floatUp(up)
    assert(type(up) == "number", "Component floatUp: up is invalid.")

    local floatType = self._floatType
    if (floatType == LayoutFloatType.NONE) then
        floatType = LayoutFloatType.FLOAT_UP
    elseif (floatType == LayoutFloatType.FLOAT_BOTTOM or
        floatType == LayoutFloatType.FLOAT_LEFT_BOTTOM or
        floatType == LayoutFloatType.FLOAT_RIGHT_BOTTOM) then
        floatType = floatType - 4
    end
    self._floatType = floatType
    self._floatUp = up or 0
end

-- 向下浮动布局
function Component:floatBottom(bottom)
    assert(type(bottom) == "number", "Component floatBottom: bottom is invalid.")

    local floatType = self._floatType
    if (floatType == LayoutFloatType.NONE) then
        floatType = LayoutFloatType.FLOAT_BOTTOM
    elseif (floatType == LayoutFloatType.FLOAT_UP or
        floatType == LayoutFloatType.FLOAT_LEFT_UP or
        floatType == LayoutFloatType.FLOAT_RIGHT_UP) then
        floatType = floatType + 4
    end
    self._floatType = floatType
    self._floatBottom = bottom or 0
end

-- 模版函数：初始化组建的视图
function Component:onInitView(...)
    -- error("[ERROR] Component onInitView: should be overrided.")
end

-- 模版函数：更新组建的视图
function Component:onUpdateView(...)
    -- error("[ERROR] Component onUpdateView: should be overrided.")
end

-- 模版函数：组件尺寸更新
function Component:onSizeChanged(originalWidth, originalHeight)
    -- print("[WARNING] Component onSizeChanged: should be overrided.")
end

-- 启用点击
function Component:setTouchEnable(enable, priority)
    assert(type(enable) == "boolean", "Component setTouchEnable: enable is invalid.")

    if (enable) then
        self:addTouchEvents(priority)
    end
    self._enableTouch = enable
end

-- 设置事件是否被吞噬
function Component:setSwallowTouches(swallowed)
    assert(type(swallowed) == "boolean", "Component setSwallowTouches: swallowed is invalid.")

    self._swallowedTouch = swallowed
    self._listener:setSwallowTouches(swallowed)
end

-- 设置事件是否被拦截
function Component:setInterceptTouches(intercepted)
    assert(type(intercepted) == "boolean", "Component setInterceptTouches: intercepted is invalid.")
        
    self._interceptedTouch = intercepted
end

-- 添加touch监听事件
function Component:addTouchEvents(priority)
    if (not self._listener) then
        -- 点击开始
        local function onTouchBegan(touch, event)
            if (not self._visible) then return false end
            if (not self:isVisible()) then return false end
            if (not self._enableTouch) then return false end
            if (not self:_isTouchVisible()) then return false end

            self.canDispatchClickEvent = true;

            local touchPosition = touch:getLocation()
            local touched = self:checkTouch(touch)
            if (touched) then
                self._touchBegan = true
                self._touchBeganPosition = touchPosition
                -- 发送触发点击开始的事件
                self:dispatchEvent(UIEvent.COMPONENT_TOUCH_BEGAN, self, touchPosition)

                return true
            else
                if self:isTouchInSafeArea(touchPosition) then
                    -- 发送点击组件外部区域的事件
                    self:dispatchEvent(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, touchPosition, touch)
                    if (self._interceptedTouch) then
                        self._touchOutside = true
                    end
                else
                    -- print("点击安全区域之外")
                end
                return self._interceptedTouch
                
            end
        end
        -- 点击移动
        local function onTouchMoved(touch, event)
            local touchPosition = touch:getLocation()

            if (self._touchBegan) then
                -- 发送触发点击移动的事件
                self:dispatchEvent(UIEvent.COMPONENT_TOUCH_MOVED, self, touchPosition)
                if self._closeDrag then
                    return
                end
                -- 发送拖拽事件
                if (self._enableDrag) then
                    self:dispatchEvent(UIEvent.COMPONENT_DRAG_MOVED, self, touchPosition, touch)
                else
                    if self._touchBeganPosition ~= nil then
                        local distance = cc.pGetDistance(
                            touchPosition,
                            self._touchBeganPosition
                        )
                        if (distance >= COMPONENT_DRAG_DISTANCE) then
                            self._enableDrag = true
                            if not self._listener:isSwallowTouches() then
                                self.canDispatchClickEvent = false
                            end
                            self:dispatchEvent(UIEvent.COMPONENT_DRAG_BEGAN, self, touchPosition, touch)
                        else
                            event:stopPropagation()
                        end
                    end
                end
            end
        end
        -- 点击结束
        local function onTouchEnded(touch, event)
            local touchPosition = touch:getLocation()
            -- 发送触发点击结束的事件
            self:dispatchEvent(UIEvent.COMPONENT_TOUCH_ENDED, self, touchPosition)
            -- 发送点击组件外侧的事件
            if (self._touchOutside) then
                self:dispatchEvent(UIEvent.COMPONENT_TOUCH_OUTSIDE_ENDED, self, touchPosition, touch)
                self._touchOutside = false
            end
            if (self._enableDrag and self:isEventRegisterd(UIEvent.COMPONENT_DRAG_ENDED)) then
                -- 发送拖拽结束事件
                self:dispatchEvent(UIEvent.COMPONENT_DRAG_ENDED, self, touchPosition, touch)
            else
                if self.canDispatchClickEvent then
                    local touchCheck = self:checkTouch(touch)
                    if (touchCheck) then
                        -- 发送点击组件的事件
                        self:dispatchEvent(UIEvent.COMPONENT_CLICK, self, touchPosition, touch)
                        if self.clickAudioEnable then
                            Avalon.AudioManager:playSound(self.clickAudioID)
                        end

                        -- 发送双击组件的事件
                        if (self._clickTime) then
                            local offsetTime = os.time() - self._clickTime
                            if (offsetTime <= 0.5) then
                                self:dispatchEvent(UIEvent.COMPONENT_DOUBLE_CLICK, self, touchPosition)
                            end
                        end

                        UI.LastClickComponent = self
                    end
                end
            end

            self._touchBegan = false
            self._enableDrag = false
            self._clickTime = os.time()
        end

        -- 注册点击监听事件
        local listener = cc.EventListenerTouchOneByOne:create()
        listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
        listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
        listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
        listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_CANCELLED)
        listener:setSwallowTouches(self._swallowedTouch)
        local eventDispatcher = self:getEventDispatcher()
        if (priority) then
            eventDispatcher:addEventListenerWithFixedPriority(listener, priority)
        else
            eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
        end

        self._listener = listener
    end
end

-- 删除touch监听事件
function Component:removeTouchEvents()
    if (self._listener) then
        local eventDispatcher = self:getEventDispatcher()
        eventDispatcher:removeEventListener(self._listener)

        self._listener = nil
    end
end

-- 设置调试颜色
function Component:enableDebugDraw(drawColor, isDrawSolid)
    self._drawColor = drawColor or UI.WHITE
    self._drawSolid = (isDrawSolid) and isDrawSolid or false
    self._enableDebugDraw = true

    drawDebugRect(self)
end

-- 禁用调试节点
function Component:disableDebugDraw()
    self._enableDebugDraw = false
end

-- 清理调试节点
function Component:clearDebugDraw()
    if (self._drawNode) then
        self._drawNode:removeFromParent()
        self._drawNode = nil
    end
end

-- 获取着色器
function Component:getShader(shaderDefine)
    assert(type(shaderDefine) == "table", "Component getShader: shader define is invalid.")

    return getShader(self, shaderDefine)
end

-- 使用着色器
function Component:useShader(shaderDefine)
    -- print("Component:useShader", shaderDefine)
    local shader = self:getShader(shaderDefine)
    if (shader) then
        self:onUseShader(shader, shaderDefine)
    end
end

-- 模版函数:设置着色器
function Component:onUseShader(shader)

end

function Component:addColorBG()
    -- local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,125))
    -- colorLayer:setAnchorPoint(cc.p(0.5,0.5))
    -- colorLayer:setPosition(self._hw-UI.size.width/2,self._hh - UI.size.height/2)
    -- colorLayer:setContentSize(UI.size.width,UI.size.height)
    -- self:addChild(colorLayer,-1)

    if (device.platform == "ios" and (device.model == "ipad" or device.model == "ipad retina" or device.model == "iphone 4" or device.model == "iphone 5") or (device.platform == "android")) then
        local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,125))
        colorLayer:setAnchorPoint(cc.p(0.5,0.5))
        colorLayer:setPosition(self._hw-UI.size.width/2,self._hh - UI.size.height/2)
        colorLayer:setContentSize(UI.size.width,UI.size.height)
        self:addChild(colorLayer,-1)
    else
        Avalon.WidgetUtil:clippingView(self,function(self,pic)
            -- local winSize = cc.Director:getInstance():getWinSize()
            local pos = self:convertToNodeSpace(cc.p(UI.size.width/2,UI.size.height/2))
            pic:setScaleX(UI.size.width/pic:getContentSize().width)
            pic:setScaleY(UI.size.height/pic:getContentSize().height)
            pic:setPosition(cc.p(pos.x,pos.y))
            self:addChild(pic,-10)

            performWithDelay(self, function()

                local _renderTexture = cc.RenderTexture:create(UI.size.width,UI.size.height, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)
                -- todo add by yueyingsong 兼容新老版本
                if _renderTexture.ignoreAnchorPointForPosition then
                    _renderTexture:ignoreAnchorPointForPosition(true);
                else
                    _renderTexture:setIgnoreAnchorPointForPosition(true);
                end
                

                _renderTexture:begin()
                pic:visit()
                _renderTexture:endToLua()

                local _pic = cc.Sprite:createWithTexture(_renderTexture:getSprite():getTexture())
                local pos = self:convertToNodeSpace(cc.p(UI.size.width/2,UI.size.height/2))
                
                _pic:setName("pic")
                -- _pic:setAnchorPoint(cc.p(0,0))
                _pic:setScaleY(-1)
                _pic:setPosition(cc.p(pos.x,pos.y))
                self:addChild(_pic,-1)

                pic:runAction(cc.Sequence:create(cc.DelayTime:create(0.05), cc.RemoveSelf:create()))

            end, 0.05)

        end)
    end
end

-- 移动行为
function Component:moveTo(posX, posY, duration, callback)
    local moveAction = cc.MoveTo:create(duration or 1.0, {
        x = posX,
        y = posY
    })
    self:runAction(cc.Sequence:create(moveAction, cc.CallFunc:create(function()
        if (callback) then
            callback()
        end
    end)))
end

-- 缩放行为
function Component:scaleTo(scale, duration)
    local originalScale = self:getScale()
    local scaleAction = cc.ScaleTo:create(duration or 1.0, scale)
    self:runAction(scaleAction)
end

-- 打印信息
function Component:print()
    print("-------------------------")
    print("Component info:")
    print(string.format("id:%d, type:%d, size:(%f,%f). pos:(%d,%d)", self._id, self._type, self._width, self._height, self:getPositionX(), self:getPositionY()))
    print("-------------------------")
end

function Component:loadResList(asyn)
    self._resList = self._resList or COM_RES_LIST
    loadResList(self, asyn)
end

function Component:setStatic(static)
end


function Component:addListenerOnCleanUp(callback)
    self:addEventListener(UIEvent.EVENT_CLEANUP, self, callback)
end

function Component:setCloseDrag(isClose)
    self._closeDrag = isClose
end

--用shader闪烁光源 特效 ，产生光源
--node:被处理的对象
--textureName：光源形状，纹理文件名字
--color：光源颜色
--posX, posY: 光源坐标 （世界坐标）
function Component:addBlinkLight(node, textureName, posX, posY, color)
    local laser = cc.Sprite:create()
    laser:setSpriteFrame(textureName)
    laser:setCascadeColorGLProgramEnable(false)
    local nodePos = node:convertToNodeSpace(cc.p(posX, posY))
    laser:setPosition(nodePos.x, nodePos.y)
    node:addChild(laser, 100000)
    local color = cc.vec4(1.0, 0, 0, 1.0)
    -- local glProgram = cc.GLProgram:createWithFilenames("shaders/TextureLight.vert", "shaders/TextureLight.frag")
    -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    local glProgramState = AvalonUtil:getGLProgramState("shaders/TextureLight.vert", "shaders/TextureLight.frag")
    glProgramState:setUniformVec4("u_lightColor", color)
    laser:setGLProgramState(glProgramState)

    -- local glProgram = cc.GLProgram:createWithFilenames("shaders/TextureLaser.vert", "shaders/TextureLaser.frag")
    -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
    local glProgramState = AvalonUtil:getGLProgramState("shaders/TextureLaser.vert", "shaders/TextureLaser.frag")
    glProgramState:setUniformFloat("u_lightRangeX", laser:getContentSize().width * 1.2 / 2.0) --椭圆 X 轴长
    glProgramState:setUniformFloat("u_lightRangeY", laser:getContentSize().width * 1.2 / 2.0) --椭圆 Y 轴长
    glProgramState:setUniformVec2("u_lightPosition", cc.vec2(posX, posY))
    glProgramState:setUniformVec4("u_lightColor", color)
    node:setGLProgramState(glProgramState)
end

-- 显示透明光效
function Component:showLucencyLight(width, height)
    if (width == nil or height == nil) then
        width, height = self:getSize()
    end
    -- print("HWBtnComponent:showLucencyLight =", width, height)
    local progressTimer = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_bg.png")
    progressTimer:setCapInsets(CCRectMake(120, 107, 162, 162))
    progressTimer:setContentSize(width + 100 * 2, height + 100 * 2)
    progressTimer:setAnchorPoint(cc.p(0.5, 0.5))
    progressTimer:setPosition(cc.p(width / 2, height / 2))

    self:addChild(progressTimer, -100)
end

function Component:setTouchClipNode(node)
    self.touchClipNode = node
end

function Component:getTouchClipNode()
    return self.touchClipNode
end

--重写 父类函数（父类tag 值是int32位 容易越界）
function Component:setTag(tag)
    self.sTag = tag
end

function Component:getTag()
    return self.sTag or 0
end

function Component:Local2Global()
    return self:convertToWorldSpace(self:getAnchorPointInPoints())
end

function Component:setClickAudioId(id)
    self.clickAudioID = tostring(id)
end

function Component:setClickAudioEnable(enable)
    self.clickAudioEnable = enable
end

function Component:getDescription()
    return "<" .. self.__cname .. " | Tag = " .. self:getTag() .. ">"
end


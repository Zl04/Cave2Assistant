-- RunningLamp.lua
-- Author:ydli
-- 2018年7月3日
-- Using:跑马灯


UI = UI or {}
local RunningLamp = class("RunningLamp", UI.Component)
UI.RunningLamp = RunningLamp
require"app.ui.notice.SuperLenText"

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(570, 26)
local moveSpeed = 60 --每秒移动距离
-- 背包资源
local COM_RES_LIST = {
}

g_runningLampData = nil
-- 构造函数
function RunningLamp:ctor(text, count, runCount)
    RunningLamp.super.ctor(self, 0, COM_RES_LIST, layerSize.width, layerSize.height)
    self.isRun = false
    self:init()
    self:changeText(text, count, runCount)
    self._schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update), 0, false)
end

-- 析构函数
function RunningLamp:dtor()
    RunningLamp.super.dtor(self)
    if self._schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._schedulerID)
        self._schedulerID = nil
    end
end

-- 初始化
function RunningLamp:init()
    RunningLamp.super.init(self)
end

-- 初始化视图
function RunningLamp:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_public_banner_black_image.png")
    bg:center()
    self:addChild(bg) 
    bg:setOpacity(180)

    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(layerSize.width - 40, layerSize.height)
    layout:center()
    self._layout = layout

    local labelLeft = UI.SuperLenText:create()
    labelLeft:init("", UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_171_136_78)
    labelLeft:center(0)
    layout:addChild(labelLeft)
    self._labelLeft = labelLeft

    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(layerSize.width - 40, layerSize.height)
    clipper:center()
    clipper:addInnerNode(layout)
    self:addChild(clipper)
    clipper:setOpacityFilterTouch(false)
end

-- 更新视图
function RunningLamp:onUpdateView()

end

function RunningLamp:update(dt)
    if not self.isRun then
        return
    end
    if self._labelLeft:getText() == "" then
        local success = self._labelLeft:setText(self.data.content)
        if not success then
            self:clear()
        end
        self._labelLeft:centerLeft(layerSize.width - 40)
        local curFps =  60
        if dt > 0 then
            curFps = 1 / dt
        end
        moveSpeed = (self._labelLeft:getTextWidth() + layerSize.width - 40) / PublicDefine.CONST_DEFINITION.LAMP_RUN_SINGLE_TIME
        print("----moveSpeed---", moveSpeed)
    end

    self._labelLeft:setPositionX(self._labelLeft:getPosition() - moveSpeed * dt)
    if self._labelLeft:getPositionX() + self._labelLeft:getContentSize().width < 0 then
        self._labelLeft:setText("")
        self.isRun = false
        self:hide()
        Game.ChatManager:getInstance():decreaseLampCount(self.data.id)
        -- add by zp 这里需要把这里的数值清空，否者下一条数据没法开始播放，这里通过这个这个数据判断该对象是否还在播放等
        self.data = nil
        Game.ChatManager:getInstance():beginLampRunning()
    end
end

function RunningLamp:changeText(data)
    self.data = data
    self:show()
    self.isRun = true
end

function RunningLamp:showLamp(data)
    if UI.UIManager:getRootNode() == nil then
        return
    end   
    
    local lamp =  UI.UIManager:getRootNode():getChildByName("LAMP")
    if lamp then
        if(data and lamp.data) then 
            if(data.id ~= lamp.data.id) then 
                return
            end
        end
        lamp:changeText(data)
    else
        lamp = UI.RunningLamp:create(data)
        lamp:setName("LAMP")
        lamp:centerUp(70)
        UI.UIManager:getRootNode():addChild(lamp,UI_ZORDER.RUNNING_LAMP)
    end 
    if RoleBehaviorManager:checkMasterIsInBattle() then
        lamp:hide()
    else
        lamp:show()
    end
end


function RunningLamp:clear()
    UI.UIManager:getRootNode():removeChildByName("LAMP")
end
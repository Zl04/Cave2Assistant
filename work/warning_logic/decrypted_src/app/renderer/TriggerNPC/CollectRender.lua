--[[
    陷阱npc的渲染器
]]

require "app.renderer.Renderer"

Renderer = Renderer or {}
local CollectRender = class("CollectRender", Renderer.Base)
Renderer.CollectRender = CollectRender

-- private:
local DEBUG = false


-- private:
-- 构造函数
function CollectRender:ctor()
    CollectRender.super.ctor(self)

    self._npcType = PublicDefine.TRIGGER_NPC_TYPE.COLLECT
    -- 是否锁定
    self._configData = nil

    self._playSound = false
end

-- 析构函数
function CollectRender:dtor()
    CollectRender.super.dtor(self)

    -- 移除所有表现
    self:removeTrigger()

end

function CollectRender:onDraw(dt)

end
-- public:
-- 初始化
-- @pgsImg 采集物进度条
function CollectRender:init(configData)
    self._configData = configData
    self:trigger()
end


-- public:
-- 初始化
function CollectRender:init(skeleton, atlas, scale)
    -- 添加宝箱动画
    -- print(" TriggerNPCRenderer:init ",skeleton, atlas, scale)
   self.animation = Avalon.Animation:create(skeleton, atlas, scale)

   if (self.animation) then
       self:addChild(self.animation,1)
   else
      assert(false, string.format("[ERROR] TriggerNPCRenderer init: create treasure animation (%s,%s,%f) failed.", skeleton, atlas, scale))
   end


   self:idle()
end

-- 设置待机视图
function CollectRender:idle()
    if (self.animation) then
        self.animation:setAnimation(0, "idle", true)
    end
end

function CollectRender:trigger()
    local per, countdown =0.8,14

    local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(self._configData.pgsImg))
    timer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    timer:setPercentage(per * 100)
    timer:setMidpoint(cc.p(0.5, 0.5))
    timer:setBarChangeRate(cc.p(1, 0))
    timer:setPosition(cc.p(0, -50))
    self:addChild(timer) 

    -- local action = cc.ProgressTo:create(countdown, 0) 
    -- timer:runAction(action)
    self.timmer = timmer
end

function CollectRender:removeTrigger()
    if self.timmer then
        self.timmer:removeFromParent()
        self.timmer = nil
    end
end

function CollectRender:pause()
    CollectRender.super.pause(self)
    if(not tolua.isnull(self.animation)) then 
        self.animation:pause()
    end
end

function CollectRender:resume()
    CollectRender.super.resume(self)
    if(not tolua.isnull(self.animation)) then 
        self.animation:resume()
    end
end
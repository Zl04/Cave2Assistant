--MazeFlagRenderer.lua
--2019-03-14
--Author:zp
--触发类NPC 渲染器

require "app.renderer.Renderer"

local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE

Renderer = Renderer or {}

local MazeFlagRenderer = class("MazeFlagRenderer", Renderer.Base)
Renderer.MazeFlagRenderer = MazeFlagRenderer

-- private:
local DEBUG = false
local SHOW_IDLE_NUM = 2

-- private:
-- 构造函数
function MazeFlagRenderer:ctor()
    MazeFlagRenderer.super.ctor(self)

    self._triggerNPC = nil

    self._showIndex = 0
end

-- 析构函数
function MazeFlagRenderer:dtor()
    MazeFlagRenderer.super.dtor(self)

    self._triggerNPC = nil
end

-- public:
-- 初始化
function MazeFlagRenderer:init(skeleton, atlas, scale, isTrigger, nickName,isMaster)
    -- print(" MazeFlagRenderer:init ",skeleton, atlas, scale)
    self._triggerNPC = Avalon.Animation:create(skeleton, atlas, scale)
    self._npcType = npcType

    if (self._triggerNPC) then
        self:addChild(self._triggerNPC, 1)
    end
    if(isTrigger) then 
        self:trigger()
    else 
        self:idle()
    end
    
    local str = nil
    if(nickName) then 
        str = string.format(UI.TEXT_1213015, nickName)
    else 
        str = string.format(UI.TEXT_1213015, UI.TEXT_1212707)
    end

    
    local nameColor = nil
    if(isMaster) then
        nameColor = UI.FONT_COLOR_MASTER_HERO_NAME
    else
        nameColor = UI.FONT_COLOR_OTHER_HERO_NAME
    end

    -- 标题
    local titleText = UI.Text:create()
    titleText:init(str, UI.SYS_FONT, UI.FONT_SIZE_18PX, nameColor)
    titleText:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
    titleText:centerUp(-140)
    self:addChild(titleText, 100)


    self:setVisible(true)
    self:registerSpineEventHandler()
end

function MazeFlagRenderer:triggerOneShow(detailHeroData) 
    self._detailHeroData = detailHeroData

    -- 处理播放一次显示效果
    self:setVisible(true)
end

-- 设置皮肤
function MazeFlagRenderer:setSkin(skinName)
    if (self._triggerNPC) then
        self._triggerNPC:setSkin(skinName)
    end
end

function MazeFlagRenderer:speedUp(timeScale)
    if(self._triggerNPC) then
        self._triggerNPC:setTimeScale(timeScale)
    end 
end

function MazeFlagRenderer:showMove()

end

-- 设置方向
function MazeFlagRenderer:setDirection(direction)

end

function MazeFlagRenderer:showIDLE()

end

-- 设置待机视图
function MazeFlagRenderer:trigger()
    self._triggerNPC:setAnimation(0, "trigger", false)
    self._triggerNPC:addAnimation(0, "idle", true)
end

-- 设置待机视图
function MazeFlagRenderer:idle()
    self._triggerNPC:setAnimation(0, "idle", true)
end

-- 触发移除自己
function MazeFlagRenderer:_triggerRemoveSelf()
    if (DEBUG) then
        print("MazeFlagRenderer:_triggerRemoveSelf ")
    end
end

function MazeFlagRenderer:getSpine()
    -- body
    return self._triggerNPC
end

-- 渲染
function MazeFlagRenderer:onDraw(dt)

end

function MazeFlagRenderer:registerSpineEventHandler()
end

function MazeFlagRenderer:oneShowEnd()

end

function MazeFlagRenderer:setVisible( visible )
    MazeFlagRenderer.super.setVisible(self,visible)

    if self._triggerNPC then
        self._triggerNPC:setVisible(visible)
    end
end

function MazeFlagRenderer:pause()
    MazeFlagRenderer.super.pause(self)
    if(not tolua.isnull(self._triggerNPC)) then 
        self._triggerNPC:pause()
    end
end

function MazeFlagRenderer:resume()
    MazeFlagRenderer.super.resume(self)
    if(not tolua.isnull(self._triggerNPC)) then 
        self._triggerNPC:resume()
    end
end
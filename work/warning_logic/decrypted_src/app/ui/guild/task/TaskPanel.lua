-- TaskPanel.lua
-- Author:zp
-- 2017年9月26日
-- Using:任务表现

require("app.ui.guild.task.TaskCell")
require "app.ui.CommonBgLayer"

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}

local TaskPanel = class("TaskPanel", UI.DownShowWin)
UI.TaskPanel = TaskPanel

local COM_WIDTH = 920
local COM_HEIGHT = 640
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_guild_task.plist",
    "ui_town_guild_general.plist",
}

--构造函数(必备)
function TaskPanel:ctor(spriteID)
	--窗口大小
    TaskPanel.super.ctor(
    self,UIType.TASK_PANEL,
    COM_RES_LIST,
    COM_WIDTH,	
    COM_HEIGHT
    )

    self.spriteID = spriteID 

    -- 获取任务数据
    self.guildArr = TaskDataManager:getAllGuildTaskArr()
    -- print("TaskPanel:ctor", self.guildArr)

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:registerListener()
    self:init()
end

--虚构函数,destroy时调用(必备)
function TaskPanel:dtor()
    TaskPanel.super.dtor(self)
end

-- 初始化(必备)
function TaskPanel:init()
    TaskPanel.super.init(self)
end

-- 注册监听事件(可选)
function TaskPanel:registerListener()
end


-- 模版函数：初始化组建的视图(必备)
function TaskPanel:onInitView()
    -- self:enableDebugDraw()
    -- 内容面板
    local bg = UI.CommonBgLayer:create(true, true)
    bg:center()
    self:addChild(bg)

    local bg2 = UI.Image:create()
    bg2:init("ui_guild_task_banner_reward.png")
    bg2:leftUp(136, 122)
    bg:addChild(bg2)

    local offsetY = 14
    local chaX = 283

    if(self.guildArr == nil or #self.guildArr == 0) then
        local notaskLabel = UI.Text:create()
        notaskLabel:init(LanguageManager:getInstance():getLocalString(1110946), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_250_209_122)
        notaskLabel:center()
        notaskLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
        self:addChild(notaskLabel, 10)
    else 
        local i = 1
        for _, taskData in pairs(self.guildArr) do 
            local taskCell = UI.TaskCell:create(taskData, i)
            taskCell:leftBottom(36 + chaX * (i - 1), offsetY)
            bg:addChild(taskCell)
            
            i = i + 1
        end
    end 

    -- bg:setTouchEnable(true)
    -- bg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
    --     print("TaskPanel:onInitView bg COMPONENT_TOUCH_OUTSIDE")
    --     Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER,function()
    --     end,0.2)
    --     self:close()
    -- end)

    -- 放大出现
    -- self:setScale(0.1)
    -- self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1)))



    -- local spine = sp.AvalonAnimation:create("role_hero_1.json", "role_hero.atlas", 0.65, false)
    -- self:addChild(spine,1000)
    -- spine:setAnimation(0, "idle_1", true)

    --     local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
    --     if (shader) then
    --         spine:setGLProgramState(shader)
    --     end

    -- spine:runAction(cc.Sequence:create(cc.DelayTime:create(0.05),cc.CallFunc:create(function()
    --     spine:update(0.2)
    --     spine:setTimeScale(0)
    --     -- TODO 处理截取图片
    --     local boundingBox = spine:getBoundingBox()
    --     local _RenderTexture = cc.RenderTexture:create(3000, 3000, cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)

    --     spine:setVisible(true)
    --     _RenderTexture:begin()
    --     spine:visit()
    --     _RenderTexture:endToLua()
    --     -- spine:setVisible(false)

    --     local _pic = cc.Sprite:createWithTexture(_RenderTexture:getSprite():getTexture())
    --     _pic:setPosition(cc.p(0,0))
    --     _pic:setName("pic")
    --     _pic:setScaleY(-1)
    --     _pic:setScaleX(-1)

    --     local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
    --     if (shader and _pic) then
    --         _pic:setGLProgramState(shader)
    --     end

    --     self:addChild(_pic,10000)
    -- end)))
end

-- 模版函数：更新组建的视图(必备)
function TaskPanel:onUpdateView()
    
end

function TaskPanel:openShow()
    self:open()
end
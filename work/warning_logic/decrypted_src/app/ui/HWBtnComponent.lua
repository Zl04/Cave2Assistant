-- Component的子类, 用来方便实现应对安卓硬件按钮事件
-- 目前采用模拟TouchOutside的方法来实现

UI = UI or {}

local LanguageManager = require("app.game.LanguageManager")
require "app.ui.UIDefine"
require "app.ui.Component"

local HWBtnComponent  = class("HWBtnComponent", UI.Component)
UI.HWBtnComponent = HWBtnComponent

HWBtnComponent._componentList = {}
HWBtnComponent._mainSwitchOn = true


--------------------------类方法--------------------------
-- 硬件按钮总控

function HWBtnComponent:mainSwitchOn()
    HWBtnComponent._mainSwitchOn = true
end

function HWBtnComponent:mainSwitchOff()
    HWBtnComponent._mainSwitchOn = false
end

-- 在UI管理器初始化时注册事件
function HWBtnComponent:registerHWKeyEvents()
    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(function(keycode, evt)
        if (cc.KeyCode.KEY_BACK == keycode and not HWBtnComponent:getBackUp()) then
            HWBtnComponent:keyBackUp()
            return true
        end
    end, cc.Handler.EVENT_KEYBOARD_PRESSED);
 
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher();
    eventDispatcher:addEventListenerWithFixedPriority(listener, 1);
end

function HWBtnComponent:setNoBackUp(backUp)
    self._noBackUp = backUp
end

function HWBtnComponent:getBackUp()
    return self._noBackUp
end



-- 默认的返回键处理器
function HWBtnComponent:keyBackUp()
    if (not HWBtnComponent._mainSwitchOn) then return end
    for i=#HWBtnComponent._componentList, 1, -1 do
        local component = HWBtnComponent._componentList[i]
        if (component.___backKeyMark) then
            -- 重载返回键处理方法返回false就不会终止传递
            component:retain() -- 防止组件在回调中被释放
            if (component.handleKeyBackUp and component:handleKeyBackUp()) then
                component:release()
                return
            else
                component:release()
            end
        end
    end

    local SdkBox = require("utils.sdkbox.SdkBox")
    local state = SdkBox:getInstance():getExitGameState()
    print("---keyBackUp---GameState = ", state)
    if state == 1 then --直接弹出自己的窗口
        -- 如果没有找到处理器, 弹窗提示退出
        local exitTips = UI.Tips:createTips(
            LanguageManager:getInstance():getLocalString(1111229), -- "确定要退出游戏吗?",
            UI.TipsType.CONFIRM_AND_CANCEL,
            UI.TipsUiType.NORMAL
        )
        exitTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            -- SdkBox:getInstance():exit()
            -- cc.Director:getInstance():endToLua()
            -- os.exit()

            require "app.utils.ToolsUtil"
            ToolsUtil:exitApp()
        end)
        exitTips:setModelDialog(false)
        -- add by zp 这里把层级设置到最高
        exitTips:setZOrder(UI_ZORDER.EXIT_GAME)
    else
        SdkBox:getInstance():exit()
    end
end

-- -- 显示透明光效
-- function HWBtnComponent:showLucencyLight(width, height)
--     if(width == nil or height == nil) then 
--         width, height = self:getSize()
--     end
--     -- print("HWBtnComponent:showLucencyLight =", width, height)
--     local progressTimer = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_bg.png")
--     progressTimer:setCapInsets(CCRectMake(120,107,162,162))
--     progressTimer:setContentSize(width + 100*2, height + 100*2)
--     progressTimer:setAnchorPoint(cc.p(0.5, 0.5))
--     progressTimer:setPosition(cc.p(width/2, height/2))
    
--     self:addChild(progressTimer)
-- end

--------------------------eo 类方法--------------------------








--------------------------实例逻辑--------------------------
function HWBtnComponent:setForceListenBackKey(bForce)
    self.___backKeyMark = bForce
end

function HWBtnComponent:setEatHWBackEvent(b)
    self.___eatHWBackEvent = b
end
--------------------------eo 实例逻辑------------------------





--------------------------生命周期--------------------------
function HWBtnComponent:ctor( ... )
    HWBtnComponent.super.ctor(self, ... )
    table.insert(HWBtnComponent._componentList, self)
    self.___eatHWBackEvent = true

    -- 处理触发逻辑
    local helpData = ConfigManager:getClientHelpForID(self._type)
    if(helpData) then 
        require "app.ui.common.GeneralHelpLayer"
        local generalHelp = UI.GeneralHelpLayer:create(helpData)
        generalHelp:init()
        generalHelp:center(helpData.position[1], helpData.position[2])
        generalHelp:setName("GeneralHelp")
        self:addChild(generalHelp, 100000)
    end
end

function HWBtnComponent:refreshHelpInfo(subType)
    local helpData = ConfigManager:getClientHelpForID(self._type, subType)
    if (helpData) then 
        local generalHelp = self:getChildByName("GeneralHelp")
        if generalHelp then
            generalHelp:show()
            generalHelp:center(helpData.position[1], helpData.position[2])
        else
            require "app.ui.common.GeneralHelpLayer"
            local generalHelp = UI.GeneralHelpLayer:create(helpData)
            generalHelp:init()
            generalHelp:center(helpData.position[1], helpData.position[2])
            generalHelp:setName("GeneralHelp")
            self:addChild(generalHelp, 100000)
        end
    else
        local generalHelp = self:getChildByName("GeneralHelp")
        if generalHelp then
            generalHelp:hide()
        end
    end
end

function HWBtnComponent:init( ... )
    HWBtnComponent.super.init(self, ... )
end

function HWBtnComponent:dtor()
    HWBtnComponent.super.dtor(self)
    for i=#HWBtnComponent._componentList,1,-1 do
        local component = HWBtnComponent._componentList[i]
        if (self == component) then
            table.remove(HWBtnComponent._componentList, i)
        end
    end
end
--------------------------eo 生命周期------------------------








--------------------------事件管理--------------------------
function HWBtnComponent:addEventListener(eventName, target, callback)
    -- 目前用模拟TouchOutside来实现检测需要接收硬件返回键关闭的层
    HWBtnComponent.super.addEventListener(self, eventName, target, callback)
    if (eventName == UIEvent.COMPONENT_TOUCH_OUTSIDE) then
        -- 默认设定为需要监听硬件返回按钮, 如果有强制设定值, 使用强制设定值
        self.___backKeyMark = true
    end
end

function HWBtnComponent:handleKeyBackUp()
    AvalonUtil.simulateTouchOutsideForNode(self)
    return self.___eatHWBackEvent
end
--------------------------eo 事件管理------------------------
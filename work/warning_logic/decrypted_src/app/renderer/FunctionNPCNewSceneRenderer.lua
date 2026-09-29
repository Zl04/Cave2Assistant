--FunctionNpcNewSceneRenderer.lua
--2020-10-13
--Author:zp
--功能类NPC 渲染器(新场景专用)

require "app.renderer.Renderer"

Renderer = Renderer or {}

local FunctionNpcNewSceneRenderer = class("FunctionNpcNewSceneRenderer", Renderer.Base)
Renderer.FunctionNpcNewSceneRenderer = FunctionNpcNewSceneRenderer

local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE

-- private:
local DEBUG = false
local plistName = "ui_common_staticnpc.plist"

-- private:
-- 构造函数
function FunctionNpcNewSceneRenderer:ctor()
    FunctionNpcNewSceneRenderer.super.ctor(self)

    self._functionNPCAnimation = nil
    self._functionNPCImage = nil
    self.loadedPlist = false

    self._infomationHide = false
    self._cryingFlag = false
    self._isLock = false
end

-- 析构函数
function FunctionNpcNewSceneRenderer:dtor()
    FunctionNpcNewSceneRenderer.super.dtor(self)

    self._functionNPCAnimation = nil
    self._functionNPCImage = nil
    self.loadedPlist = false
    self._isLock = false
    
    if(not tolua.isnull(self.fogWuAnimation)) then 
        if (self.fogWuAnimation:getParent()) then
            self.fogWuAnimation:runAction(cc.RemoveSelf:create())
        else 
            self.fogWuAnimation:destroy()
        end
        self.fogWuAnimation:release()

        self.fogWuAnimation = nil
    end

    if self.loadedPlist then
        Avalon.ResHelper:unloadPlist(plistName)
    end
end

function FunctionNpcNewSceneRenderer:getViewList()
    printError("FunctionNpcNewSceneRenderer:getViewList(")
end

-- public:
-- 初始化
function FunctionNpcNewSceneRenderer:init(skeleton, atlas, scale, type, isLock)
    -- print(" FunctionNpcNewSceneRenderer:init ",skeleton, atlas, scale)
    -- local setting = GameManager:getCustomHQ(CUSTOM_HQ_TYPE.NPC)

    self._functionNPCAnimation = Avalon.Animation:create(skeleton, atlas, scale)

    if (self._functionNPCAnimation) then
        self:addChild(self._functionNPCAnimation)
    else
        assert(false, string.format("[ERROR] FunctionNpcNewSceneRenderer init: create treasure animation (%s,%s,%f) failed.", skeleton, atlas, scale))
    end

    self._triggerCount = 0
    self._isLock = isLock
    self:_registerSpineEventHandle()

    self:addBottomLittle()
    
    self._stopBreath = false

    self:refreshNPCLockStatus()
end

function FunctionNpcNewSceneRenderer:setLockStatus(isLock)
    self._isLock = isLock

    self:refreshNPCLockStatus()
end

function FunctionNpcNewSceneRenderer:refreshNPCLockStatus()
    if(self._isLock) then 
        self:showLock()
    else
        self:idle()
    end

    if(not tolua.isnull(self.lockLayout)) then
        if(self._isLock) then  
            self.lockLayout:show() 
        else
            self.lockLayout:hide()
        end
    end
end

function FunctionNpcNewSceneRenderer:createNpcNameNode(functionName, redPointID)
    if(functionName and functionName ~= "") then
        local layout = UI.Layout:create()
        layout:init()

        local bottomBlackSide = cc.Scale9Sprite:createWithSpriteFrameName("ui_maincity_namebg_02.png", cc.rect(34,9,35,10))
        layout:addChild(bottomBlackSide)

        local functionText = UI.Text:create()
        functionText:init(functionName, UI.SYS_FONT, UI.FONT_SIZE_20PX, {r = 255,  g = 227,  b = 144})
        layout:addChild(functionText)
        functionText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -2))
        functionText:center()

        local height = 26
        local totalWidth = 142
        if(functionText:getContentSize().width > 121) then 
            totalWidth = totalWidth + functionText:getContentSize().width - 121
            bottomBlackSide:setContentSize(cc.size(totalWidth, height))  
        end

        -- 添加小红点
        ToolsUtil:playNewActionInRedPoint(layout, 1, -totalWidth/2, - height/2-10, 10, redPointID)

        -- 添加锁定的标志
        local lockBg = UI.Image:create()
        lockBg:init("ui_maincity_lockbg.png")
        lockBg:centerUp(15)
        layout:addChild(lockBg)
        self.lockLayout = lockBg

        local lockImage = UI.Image:create()
        lockImage:init("ui_information_big_lock.png")
        lockImage:center()
        lockBg:addChild(lockImage)
        
        if not self._isLock then 
            lockBg:hide()
        end
        layout:setScale(0.8)
        
        return layout
    end

    return nil
end

function FunctionNpcNewSceneRenderer:setCryingFlag(cryingFlag)
    self._cryingFlag = cryingFlag
end

-- 设置方向
function FunctionNpcNewSceneRenderer:setDirection(direction)
    if not self._functionNPCAnimation then
        return
    end

    if (direction == DirectionType.EAST or
        direction == DirectionType.SOUTH) then
        self._functionNPCAnimation:setScaleX(-1)
    else
        self._functionNPCAnimation:setScaleX(1)
    end

    if DEBUG then
        print(string.format("FunctionNpcNewSceneRenderer setDirection: set direction %d.", direction))
    end
end

-- 设置待机视图
function FunctionNpcNewSceneRenderer:showLock()
    if (self._functionNPCAnimation) then
        self._functionNPCAnimation:setToSetupPose()
        self._functionNPCAnimation:setAnimation(0, "lock", false)
    end    
end

-- 设置待机视图
function FunctionNpcNewSceneRenderer:idle()
    if (self._functionNPCAnimation) then
        self._functionNPCAnimation:setToSetupPose()
        self._functionNPCAnimation:setAnimation(0, "idle1", true)
    end    
end

function FunctionNpcNewSceneRenderer:getTopFog()
    local _triggerCount = 0
    local fogWuAnimation = Avalon.Animation:create("map_town_gate_wu.json", "map_town_gate_wu.atlas", 1)
    fogWuAnimation:setAnimation(0, "begin", false)
    fogWuAnimation:setAnimation(0, "idle1", true)
    fogWuAnimation:registerSpineEventHandler(function(event)
        if event.animation == "idle1" then
            _triggerCount = _triggerCount + 1
            if(_triggerCount >2) then
                if math.random(3) <= 1 then
                    _triggerCount = 0
                    fogWuAnimation:setToSetupPose()
                    fogWuAnimation:setAnimation(0, "idle2", false)
                    fogWuAnimation:addAnimation(0, "idle1", true)
                end
            end
        end
    end, sp.EventType.ANIMATION_COMPLETE)

    fogWuAnimation:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                local soundFilename = string.sub(event.eventData.name,7,-1)
                Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
            end

            local shakePos = string.find(event.eventData.name, "hitshake_")
            if(shakePos ~= nil) then
                -- 播放抖动
                local shake = string.sub(event.eventData.name,10,-1)
                if(shake) then 
                    Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                end
            end
        end
    end, sp.EventType.ANIMATION_EVENT)
    fogWuAnimation:retain()
    self.fogWuAnimation = fogWuAnimation

    return fogWuAnimation
end

function FunctionNpcNewSceneRenderer:addBottomLittle()
end

-- 触发一次呼吸效果
function FunctionNpcNewSceneRenderer:triggerBreath()
    -- print("FunctionNpcNewSceneRenderer:triggerBreath ")
    if (self._functionNPCAnimation) then
        -- print("FunctionNpcNewSceneRenderer:triggerBreath 2")
        if(self._cryingFlag) then 
            self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "crying", false)
            self._functionNPCAnimation:addAnimation(0, "idle1", true)
        else
            self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "idle2", false)
            self._functionNPCAnimation:addAnimation(0, "idle1", true)
        end
    end
end

function FunctionNpcNewSceneRenderer:createLightViewList(animation, rotate)
    printError("FunctionNpcNewSceneRenderer:createLightViewList(")
end

-- 设施打开显示
function FunctionNpcNewSceneRenderer:showOpenIt(recoverOpen)
    -- print("FunctionNpcNewSceneRenderer:showOpenIt ",recoverOpen)
    if (self._functionNPCAnimation) then
        -- print("FunctionNpcNewSceneRenderer:showOpenIt 123 ",recoverOpen)

        self._stopBreath = true
        if recoverOpen then
            self._functionNPCAnimation:setAnimation(0, "end", true)
        else
            self._functionNPCAnimation:setAnimation(0, "open1", false)
            self._functionNPCAnimation:addAnimation(0,"end",true)
        end
        

    end
end

function FunctionNpcNewSceneRenderer:startInteraction(functionType)
    self._functionType = functionType
    if(self._functionNPCAnimation) then
        if(self._functionType == FUNCTION_TYPE.BLACK_MARKET) then
            local randomNum = math.random(3)
            if(randomNum <= 1) then
                randomNum = 1
            end
            if(randomNum >=3) then
                randomNum = 3
            end

            randomNum = randomNum + 1
            self.blackMarketNum = randomNum
            self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "begin_01", false)
            self._functionNPCAnimation:addAnimation(0, string.format("begin_0%d", randomNum), false)
            self._functionNPCAnimation:addAnimation(0, string.format("idle_0%d", randomNum), true)
            -- self._functionNPCAnimation:addAnimation(0, "begin_idle", true)
        elseif (self._functionType == FUNCTION_TYPE.WAREHOUSE) then
            -- print("FunctionNpcNewSceneRenderer:startInteraction  FUNCTION_TYPE.WAREHOUSE")
            self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "begin_01", false)
            self._functionNPCAnimation:addAnimation(0, "begin_idle", true)

        elseif (self._functionType == FUNCTION_TYPE.GENERAL_ENTRANCE) then
            -- print("FunctionNpcNewSceneRenderer:startInteraction  FUNCTION_TYPE.GENERAL_ENTRANCE")
            -- self._functionNPCAnimation:setAnimation(0, "begin_01", false)
            -- self._functionNPCAnimation:addAnimation(0, "begin_idle", true)
        else
            self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "begin", false)
            self._functionNPCAnimation:addAnimation(0, "idle1", true)
        end 
    end
end

function FunctionNpcNewSceneRenderer:endInteration()
    self._functionType = nil
    if not self._functionNPCAnimation then
        return
    end

    if (self._functionType == FUNCTION_TYPE.WAREHOUSE) then
        -- self._functionNPCAnimation:setToSetupPose()
        self._functionNPCAnimation:setAnimation(0, "close", false)
        self._functionNPCAnimation:addAnimation(0, "idle1", true)
    elseif(self._functionType == FUNCTION_TYPE.BLACK_MARKET) then
        self._functionNPCAnimation:setToSetupPose()
        if(self.blackMarketNum) then
            self._functionNPCAnimation:setAnimation(0, string.format("end_0%d", self.blackMarketNum), false)
            self.blackMarketNum = nil
            self._functionNPCAnimation:addAnimation(0, "idle1", true)
        else
            self:idle()
        end
    else 
        self:idle()
    end
end

-- 渲染
function FunctionNpcNewSceneRenderer:onDraw(dt)

end

--
function FunctionNpcNewSceneRenderer:_registerSpineEventHandle()
    if(self._functionNPCAnimation) then
        self._functionNPCAnimation:registerSpineEventHandler(function(event)
            if(self._stopBreath == false) then
                if event.animation == "idle1" then
                    self._triggerCount = self._triggerCount + 1
                    if(self._triggerCount >2) then
                        if math.random(3) <= 1 then
                            self._triggerCount = 0
                            self:triggerBreath()
                        end
                    end
                end
            end
        end, sp.EventType.ANIMATION_COMPLETE)

        self._functionNPCAnimation:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- 播放音效文件
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil,self:getCoord())
                end

                local shakePos = string.find(event.eventData.name, "hitshake_")
                if(shakePos ~= nil) then
                    -- 播放抖动
                    local shake = string.sub(event.eventData.name,10,-1)
                    if(shake) then 
                        Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                    end
                end
            end
        end, sp.EventType.ANIMATION_EVENT)
    end
end

function FunctionNpcNewSceneRenderer:_randomInteractionAnimation()
    if(self._functionNPCAnimation) then
        local randomNum = math.random(3)
        if(randomNum <= 1) then
            randomNum = 1
        end
        if(randomNum >=3) then
            randomNum = 3
        end

        randomNum = randomNum + 1

        self._functionNPCAnimation:setToSetupPose()
        self._functionNPCAnimation:setAnimation(0, string.format("begin_0%d", randomNum), false)
    end
end

function FunctionNpcNewSceneRenderer:refreshMailNewFlag(isRemove)
    self:removeChildByName("NEW_MAIL_FLAG")
    if not isRemove then
        local newFlag = UI.Layout:create()
        newFlag:init()
        newFlag:centerBottom(170)
        local action = UI.Animation:create()
        action:init("role_npc_function_union_mailbox_new.json", "role_npc_function_union_mailbox_new.atlas")
        action:center()
        action:setAnimation("idle",true)
        newFlag:addChild(action, 1)
        newFlag:setName("NEW_MAIL_FLAG")
        self:addChild(newFlag)
    end
end

function FunctionNpcNewSceneRenderer:playDreamNpcOpenAct()
    Avalon.AudioManager:playSound("1541", false)
    UI.UIManager:getRootNode():removeChildByName("DREAM_OPEN_ACT")
    local action = UI.Animation:create()
    action:init("effect_ui_town_dreamword_trigger_bat.json", "effect_ui_town_dreamword_trigger_bat.atlas")
    action:setAnimation("trigger",false)
    action:setName("DREAM_OPEN_ACT")
    local point = self:getView():convertToWorldSpace(cc.p(0, 0))
    action:leftBottom(point.x , point.y + 30)
    UI.UIManager:addToRootNode(action, UI_ZORDER.FUNCTION_NPC)
    
    action:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        sender:destroy()
    end)
end

function FunctionNpcNewSceneRenderer:setVisible( visible )
    FunctionNpcNewSceneRenderer.super.setVisible(self,visible)

    if self._functionNPCAnimation then
        self._functionNPCAnimation:setVisible(visible)
    end
    
    -- print("FunctionNpcNewSceneRenderer.setVisible",visible)
end

function FunctionNpcNewSceneRenderer:setInitMapCoordOnAnimation(coord)
    if self._functionNPCAnimation then
        self._functionNPCAnimation._initCoord = coord
    end
end

function FunctionNpcNewSceneRenderer:pause()
    FunctionNpcNewSceneRenderer.super.pause(self)
    if(not tolua.isnull(self._functionNPCAnimation)) then 
        self._functionNPCAnimation:pause()
    end
end

function FunctionNpcNewSceneRenderer:resume()
    FunctionNpcNewSceneRenderer.super.resume(self)
    if(not tolua.isnull(self._functionNPCAnimation)) then
        self._functionNPCAnimation:resume()
    end
end
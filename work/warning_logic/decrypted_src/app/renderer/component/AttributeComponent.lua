
--[[
    处理伤害效果，增加经验等表现处理
]]

local LanguageManager = require("app.game.LanguageManager")

Component = {} or Component

-- 用于客户端显示属性改变
CLIENT_ATTR_CHANGE_REASON = {
    DAMAGE_TRUE = 1;
    DAMAGE_PHYSICAL = 2;
    DAMAGE_MAGIC = 3;
    DAMAGE_ELEMENTAL = 4;
    DAMAGE_TRUE_CRIT = 5;
    DAMAGE_PHYSICAL_CRIT = 6;
    DAMAGE_MAGIC_CRIT = 7;
    DAMAGE_BLOCK = 8;
    DAMAGE_ABSORB = 9;
    DAMAGE_MISS = 10;

    HP_RESTORE = 11;
    MAGIC_RESTORE = 12;
    ADD_COIN = 13;
    ADD_EXP = 14;
    HIT_RAT_SCORE_CHANGED = 15;
}

local Attribute = class("AttributeComponent",cc.Node)

Component.Attribute = Attribute

local DEBUG = false

local ATTRIBUTE_COMPONENT = {
}

local ATTR_CHANGE_TIME_ONE_MES = 0.1   --  每个消息包间隔时间
local ATTR_CHANGE_TIME_ONE_CHANGE = 0.12 -- 每一个伤害数值间隔时间
local ATTR_CHANGE_REBACK_MES = 0.2   --  每一个上升效果的间隔时间

local JUMP_WAITING_TYPE = 2   -- 1 标识每个包融合成一次跳出  2 每跳都间隔一点时间

function Attribute:ctor()
    print("Attribute:ctor")
    -- 创建属性组件
    self:setSize(nil)
    self._roleType = RoleType.Hero

    -- 上次触发的dt时间
    self._preTriggerDtTime = 0
    -- 上次触发的reback 上次触发时间
    self._preRebackTriggerDtTime = 0
    -- 当前DT 时间
    self._nowDtTime = 0

    -- 处理效果列表
    self._list = Avalon.List:create()
    -- 上升效果列表
    self._rebackList = Avalon.List:create()

    -- 处理加载资源完成标志
    self._loadResourceEnd = false

    self._size = {width=0,height=120}
    self:setPosition(cc.p(0, 90))

    -- 注册node事件
    function onNodeEventHandler(nodeEvent)
        if (nodeEvent == "enter") then
            -- Avalon.ResHelper:loadPlist(ATTRIBUTE_COMPONENT[1],self,self._onLoadedResList)
            self._loadResourceEnd = true
            print(" Attribute:ctor enter")
        elseif (nodeEvent == "exit") then   
            print(" Attribute:ctor exit")
            -- Avalon.ResHelper:unloadPlist(ATTRIBUTE_COMPONENT[1],self,self._onLoadedResList)
        else end
    end
    self:registerScriptHandler(onNodeEventHandler)
end

-- 设置拥有该组件的大小
function Attribute:setSize(size)
    if size then
        -- self._size = size
        -- self:setPosition(cc.p(0,size.height*2/3))
        -- CO-2850  这里修改为给定一个固定阀值
        if(size.height > 200) then
            self._size = {width=0, height=200}
            self:setPosition(cc.p(0, 132))
        else 
            self._size = size
            self:setPosition(cc.p(0,size.height*2/3))
        end
    else    
        self._size = {width=0,height=0}
    end
end

-- 获取显示该组件的对象大小
function Attribute:getSize()
    if self._size then
        return self._size
    else
        return {width=0,height=0}
    end
end

function Attribute:setRoleType(roleType)
    self._roleType = roleType
end

function Attribute:addAttr(data,size,scaleX)
    if not data then
        return
    end

    self._lastScaleX = scaleX

    -- print("Attribute:addAttr  1123")
    if DEBUG then
        for k,v in pairs(data.attrChange) do
            print("Attribute:addAttr  type,changeReason,changeValue=",v.changeType,v.changeReason,v.changeValue,scaleX)
        end
    end
    if self._size.width == 0 then 
        self:setSize(size)
    end

    -- 区分属性类型，把头部上升和跳伤害给分离出来
    local clientAttrChangeReason = CLIENT_ATTR_CHANGE_REASON
    if JUMP_WAITING_TYPE == 1 then
        -- 处理添加队列的处理
        data.scaleX = scaleX

        local newData = {}
        newData.scaleX = scaleX
        newData.attrChange = {}

        for k,v in pairs(data.attrChange) do
            v.scaleX = scaleX
            local reason = v.reason
            if  reason == clientAttrChangeReason.ADD_EXP or
                reason == clientAttrChangeReason.ADD_COIN or
                reason == clientAttrChangeReason.MAGIC_RESTORE or
                reason == clientAttrChangeReason.HP_RESTORE  then
                self._rebackList:push_back(v)
            else
                table.insert(newData.attrChange,v)
            end
        end

        self._list:push_back(newData)
    elseif JUMP_WAITING_TYPE == 2 then
        for k,v in pairs(data.attrChange) do
            v.scaleX = scaleX
            local reason = v.reason
            if  reason == clientAttrChangeReason.ADD_EXP or
                reason == clientAttrChangeReason.ADD_COIN or
                reason == clientAttrChangeReason.MAGIC_RESTORE or
                reason == clientAttrChangeReason.HP_RESTORE  then
                self._rebackList:push_back(v)
            else
                self._list:push_back(v)
            end
        end
    end

end

--[[
    添加一个属性变化
    reason:改变原因
    value: 属性值
    type: 属性类型
    scaleX: >0 向X正方向  <0 向X负方向
    wasMasterBattle:是否和当前玩家处于战斗
]]
function Attribute:_addAttr(reason,value,type,scaleX)
    -- print("Attribute:_addAttr  scaleX=",scaleX)
    if value <0 then
        value = -value
    end

    local scaleStart = 1
    local scaleEnd = 1
    local positionX = 70
    local positionY = 0
    local color = cc.c3b(255,255,255)

    local clientAttrChangeReason = CLIENT_ATTR_CHANGE_REASON

    local labelStr = string.format("%d",value)

    if reason == clientAttrChangeReason.DAMAGE_TRUE then
        scaleStart = 0.8
        scaleEnd = 1
        positionX = 70
        -- positionY = -self._size.height/6
        if self._roleType == RoleType.Monster then
            color = cc.c3b(255,255,255)
        elseif self._roleType == RoleType.Hero or self._roleType == RoleType.Pet then
            color = cc.c3b(187,62,65)
        end
    elseif reason == clientAttrChangeReason.DAMAGE_PHYSICAL then
        scaleStart = 0.8
        scaleEnd = 1
        positionX = 80
        -- positionY = -self._size.height/6
        if self._roleType == RoleType.Monster then
            color = cc.c3b(255,255,255)
        elseif self._roleType == RoleType.Hero or self._roleType == RoleType.Pet then
            color = cc.c3b(187,62,65)
        end
    elseif reason == clientAttrChangeReason.DAMAGE_MAGIC then
        scaleStart = 0.8
        scaleEnd = 1
        positionX = 90
        -- positionY = -self._size.height/6
        color = cc.c3b(109,105,197)
    elseif reason == clientAttrChangeReason.DAMAGE_ELEMENTAL then
        scaleStart = 0.8
        scaleEnd = 1
        positionX = 60
        -- positionY = -self._size.height/6
        color = cc.c3b(174,91,186)
    elseif reason == clientAttrChangeReason.DAMAGE_TRUE_CRIT then
        scaleStart = 0.8
        scaleEnd = 1.15
        positionX = 70
        -- positionY = -self._size.height/6
        color = cc.c3b(203,174,60)
    elseif reason == clientAttrChangeReason.DAMAGE_PHYSICAL_CRIT then
        scaleStart = 0.8
        scaleEnd = 1.15
        positionX = 80
        -- positionY = -self._size.height/6
        color = cc.c3b(229,174,60)
    elseif reason == clientAttrChangeReason.DAMAGE_MAGIC_CRIT then
        scaleStart = 0.8
        scaleEnd = 1.15
        positionX = 90
        -- positionY = -self._size.height/6
        color = cc.c3b(202,139,77)
    elseif reason == clientAttrChangeReason.DAMAGE_BLOCK then
        -- 多语言
        -- labelStr = "格挡"
        labelStr = LanguageManager:getInstance():getLocalString(1110364)

        scaleStart = 0.8
        scaleEnd = 1
        positionX = 100
        -- positionY = -self._size.height/6
        if self._roleType == RoleType.Monster then
            color = cc.c3b(176,173,204)
        elseif self._roleType == RoleType.Hero or self._roleType == RoleType.Pet then
            color = cc.c3b(255,255,255)
        end
        
    elseif reason == clientAttrChangeReason.HIT_RAT_SCORE_CHANGED then
        scaleStart = 0.8
        scaleEnd = 1.15
        positionX = 100
        if type == 1 then-- +
            color = cc.c3b(255,255,255)
            labelStr = "+" ..labelStr
        elseif type == 2 then 
            color = cc.c3b(109,105,197)
            labelStr = "-" ..labelStr
        end

    elseif reason == clientAttrChangeReason.DAMAGE_ABSORB then
        -- 多语言
        -- labelStr = "吸收"
        labelStr = LanguageManager:getInstance():getLocalString(1110365)

        scaleStart = 0.8
        scaleEnd = 1
        positionX = 100
        positionY = positionY
        if self._roleType == RoleType.Monster then
            color = cc.c3b(176,173,204)
        elseif self._roleType == RoleType.Hero or self._roleType == RoleType.Pet then
            color = cc.c3b(255,255,255)
        end
    elseif reason == clientAttrChangeReason.DAMAGE_MISS then
        -- 多语言
        -- labelStr = "MISS"
        labelStr = LanguageManager:getInstance():getLocalString(1110366)

        scaleStart = 0.8
        scaleEnd = 1
        positionX = 70
        positionY = -self._size.height/6
        if self._roleType == RoleType.Monster then
            color = cc.c3b(176,173,204)
        elseif self._roleType == RoleType.Hero or self._roleType == RoleType.Pet then
            color = cc.c3b(255,255,255)
        end
    elseif reason == clientAttrChangeReason.HP_RESTORE then
        scaleStart = 0.8
        scaleEnd = 1
        positionX = 70
        -- positionY = -self._size.height/6
        color = cc.c3b(128,230,46)
    elseif reason == clientAttrChangeReason.MAGIC_RESTORE then
        scaleStart = 0.8
        scaleEnd = 1
        positionX = 70
        -- positionY = -self._size.height/6
        color = cc.c3b(46,184,229)
    elseif reason == clientAttrChangeReason.ADD_COIN then
        labelStr = string.format("+%d",value)
        scaleStart = 1
        scaleEnd = 1
        positionX = 70
        -- positionY = -self._size.height/6
        color = cc.c3b(255,255,255)
    elseif reason == clientAttrChangeReason.ADD_EXP then
        labelStr = string.format("+%d",value)
        scaleStart = 1
        scaleEnd = 1
        positionX = 70
        -- positionY = -self._size.height/6
        color = cc.c3b(255,255,255)
    else
        return
    end

    scaleStart = 0.75
    scaleEnd = 0.75
    local offsetX = 20

    local action = nil
    if  reason == clientAttrChangeReason.ADD_EXP or
        reason == clientAttrChangeReason.ADD_COIN or
        reason == clientAttrChangeReason.MAGIC_RESTORE or
        reason == clientAttrChangeReason.HP_RESTORE  then
        
        action = self:_makeRebackAction(scaleStart,scaleEnd)
    else
        action = self:_makeDamageAction(scaleStart,scaleEnd,positionX+offsetX,positionY,scaleX)
    end

    if action then
        -- local attrLabel = cc.Label:createWithSystemFont(labelStr, "Arial", 25)
        local attrLabel = cc.LabelBMFont:create(labelStr, UI.FONT_HURT_FNT)
        attrLabel:setAnchorPoint(cc.p(0.5, 0.5))
        attrLabel:setColor(color)

        -- 处理一些文字
        if reason == clientAttrChangeReason.DAMAGE_MISS or
            reason == clientAttrChangeReason.DAMAGE_ABSORB or
            reason == clientAttrChangeReason.DAMAGE_BLOCK then
            -- attrLabel = cc.Label:createWithSystemFont(labelStr, "Arial", 25)    

            attrLabel = UI.Text:create()
            attrLabel:init(labelStr, UI.FONT_STANDARD, UI.FONT_SIZE_28PX, color)
            -- attrLabel:center()
            attrLabel:leftBottom(offsetX * scaleX, 0)
        else 
            attrLabel = cc.LabelBMFont:create(labelStr, UI.FONT_HURT_FNT)
            attrLabel:setAnchorPoint(cc.p(0.5, 0.5))
            attrLabel:setColor(color)

            attrLabel:setPosition(cc.p(offsetX * scaleX,0))
        end

        local attrIcon = nil

        if reason == clientAttrChangeReason.ADD_EXP or reason == clientAttrChangeReason.ADD_COIN then
            local iconName = "symbol_gaming_money.png"
            if reason == clientAttrChangeReason.ADD_EXP then
                -- 这里判断语言版本，区分中文和英文版(非中文版)
                if (LanguageManager:getInstance():isChineseLanguage()) then
                    iconName = "symbol_gaming_xp_cn2.png"
                else
                    iconName = "symbol_gaming_xp_en2.png"
                end
            end

            attrIcon = cc.Sprite:createWithSpriteFrameName(iconName)
        end

        local callFun = cc.CallFunc:create(function() 
        -- print("Attribute:_addAttr removeChild")
            self:removeChild(attrLabel)
        end)

        if attrIcon then
            local callFunIcon = cc.CallFunc:create(function() 
                self:removeChild(attrIcon)
            end)

            local iconAction = action:clone()
            attrIcon:runAction(cc.Sequence:create(iconAction,callFunIcon))
            -- 设置位置
            attrIcon:setPosition(cc.p(-attrLabel:getContentSize().width*scaleStart/2,10))
            attrLabel:setPosition(cc.p(attrIcon:getContentSize().width*scaleStart/2,10))
        end

        attrLabel:runAction(cc.Sequence:create(action,callFun))

        if attrIcon then
            self:addChild(attrIcon)
            attrIcon:setScale(scaleStart)
        end
        self:addChild(attrLabel)
        attrLabel:setScale(scaleStart)

    end
end

function Attribute:_makeRebackAction(scaleStart,scaleEnd)

    local startScale = cc.ScaleTo:create(0.001,scaleStart)

    local scleTo = cc.ScaleTo:create(0.35, scaleEnd)
    local moveTo = cc.MoveBy:create(0.35,cc.p(0, 30))
    -- local action = cc.Sequence:create()
    local spawnAction = cc.Spawn:create(scleTo,moveTo)

    local delayAction = cc.DelayTime:create(0.01)

    local fadeOut = cc.FadeOut:create(0.35)
    local fadeMove = cc.MoveBy:create(0.35,cc.p(0,15))

    -- float moveTime = 0.35;
    -- if(isAttr){
    --     moveTime = 0.5f;
    -- }
    --     ActionInterval* moveAction = Sequence::create(FadeTo::create(0.001, 255),MoveBy::create(moveTime, Vec2(0, 20)),DelayTime::create(1.0f),FadeOut::create(0.35f), NULL);
    -- if(isAttr){
    --     moveAction = Sequence::create(FadeTo::create(0.001, 255),MoveBy::create(moveTime, Vec2(0, 20)),DelayTime::create(1.0f),FadeOut::create(0.35f), NULL);
    -- }else{
    --     moveAction = Sequence::create(FadeTo::create(0.001, 255),MoveBy::create(moveTime, Vec2(0, 20)),Spawn::create(FadeOut::create(0.35f),MoveBy::create(0.35f, Vec2(0, 5)), NULL), NULL);
    -- }

    return cc.Sequence:create(startScale,spawnAction,delayAction,cc.Spawn:create(fadeOut,fadeMove))
end


function Attribute:_makeDamageAction(scaleStart,scaleEnd,positionX,positionY,scaleX)
    local scale = 1
    if scaleX <0 then
        scale = -1
    end

    local scaleStart = cc.ScaleTo:create(0.0001,scaleStart)

    -- local jumpToAct = cc.JumpTo:create(0.3+0.1, cc.p(scale*(positionX),positionY), 50, 1);
    local jumpToAct = cc.JumpTo:create(0.4, cc.p(scale*(positionX),positionY), 50, 1);
    local jumpToActScale = cc.ScaleTo:create(0.4,scaleEnd)

    local jumpToAct2 = cc.JumpTo:create(0.2, cc.p(scale*(positionX+20),positionY), 20, 1);
    local jumpToAct3 = cc.JumpTo:create(0.15, cc.p(scale*(positionX+21),positionY), 10, 1);

    local delayAction = cc.DelayTime:create(0.2)
    local fadeOut = cc.FadeOut:create(0.1)
    local waitingFadeOut = cc.Sequence:create(delayAction,fadeOut)

    local delayAct2 = cc.DelayTime:create(0.15)

    -- print("Attribute:_makeDamageAction positionX,positionY,scaleStart,scaleEnd=",positionX,positionY,scaleStart,scaleEnd)

    return cc.Sequence:create(scaleStart,cc.Spawn:create(jumpToAct,jumpToActScale),cc.Spawn:create(jumpToAct2),jumpToAct3,delayAct2)
    -- return cc.Sequence:create(scaleStart,cc.Spawn:create(jumpToAct,jumpToActScale),cc.Spawn:create(jumpToAct2,waitingFadeOut))
end

function  Attribute:onUpdate(dt)
    -- print("Attribute:onUpdate dt=",dt)
    -- TODO 触发弹出效果
    self._nowDtTime = self._nowDtTime + dt
    if not self._loadResourceEnd then
        return
    end

    if self._rebackList:size() >0 and self._nowDtTime - self._preRebackTriggerDtTime > ATTR_CHANGE_REBACK_MES then
        self._preRebackTriggerDtTime = self._nowDtTime
        local v = self._rebackList:pop_front()
        if v then
            if DEBUG then
                print("Attribute   onUpdate _rebackList changeReason,changeValue,changeType=",v.reason,v.value,v.type,self._preRebackTriggerDtTime)
            end
            self:_addAttr(v.reason,v.value,v.type,v.scaleX)
        end
    end

    if JUMP_WAITING_TYPE == 1 then
        if self._list:size() >0 and self._nowDtTime - self._preTriggerDtTime > ATTR_CHANGE_TIME_ONE_MES then
            self._preTriggerDtTime = self._nowDtTime
            local data = self._list:pop_front()
            if data then
                for k,v in pairs(data.attrChange) do
                    if DEBUG then
                        print("Attribute   onUpdate changeReason,changeValue,changeType=",v.reason,v.value,v.type)
                    end
                    self:_addAttr(v.reason,v.value,v.type,v.scaleX)
                end
            end
        end
    elseif JUMP_WAITING_TYPE == 2 then
        if self._list:size() >0 and self._nowDtTime - self._preTriggerDtTime > ATTR_CHANGE_TIME_ONE_CHANGE then
            self._preTriggerDtTime = self._nowDtTime
            local data = self._list:pop_front()
            if data then
                if DEBUG then
                    print("Attribute   onUpdate changeReason,changeValue,changeType=",data.reason,data.value,data.type)
                end
                self:_addAttr(data.reason,data.value,data.type,data.scaleX)
            end
        end
    end
end

function Attribute:_onLoadedResList()
    -- 加载资源完成
    self._loadResourceEnd = true
end

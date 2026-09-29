--FunctionNPCRenderer.lua
--2017-05-5
--Author:zp
--功能类NPC 渲染器

require "app.renderer.Renderer"

Renderer = Renderer or {}

local FunctionNPCRenderer = class("FunctionNPCRenderer", Renderer.Base)
Renderer.FunctionNPCRenderer = FunctionNPCRenderer

local FUNCTION_TYPE = PublicDefine.FUNCTION_TYPE
local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE

-- private:
local DEBUG = false
local plistName = "ui_common_staticnpc.plist"

-- private:
-- 构造函数
function FunctionNPCRenderer:ctor()
    FunctionNPCRenderer.super.ctor(self)

    self._functionNPCAnimation = nil
    self._functionNPCImage = nil
    self.loadedPlist = false
    self.ox = 0
    self.oy = 0

    -- 脚下光环 
    self._lightAnimationList = nil

    self._infomationHide = false
    self._cryingFlag = false
    self._equipmentArr = {}
end

-- 析构函数
function FunctionNPCRenderer:dtor()
    FunctionNPCRenderer.super.dtor(self)

    self._functionNPCAnimation = nil
    self._functionNPCImage = nil
    self.loadedPlist = false
    self.ox = 0
    self.oy = 0
    if(self._lightAnimationList) then
        for i = 1, #self._lightAnimationList do
            local npcAnimation = self._lightAnimationList[i]
            if (npcAnimation:getParent()) then
                npcAnimation:runAction(cc.RemoveSelf:create())
            else
                npcAnimation:destroy()
            end
            npcAnimation:release()
        end
        self._lightAnimationList = nil
    end 

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
    self._equipmentArr = {}
end

function FunctionNPCRenderer:getViewList()
    return self._lightAnimationList
end

-- public:
-- 初始化
function FunctionNPCRenderer:init(skeleton, atlas, scale, type, isLock, iconName, functionName, nickName, informationHeight, staticOffset)
    -- 添加宝箱动画
    -- print(" FunctionNPCRenderer:init ",skeleton, atlas, scale)
    if staticOffset then
        self.ox = staticOffset[1] or 0
        self.oy = staticOffset[2] or 0
    end

    local setting = GameManager:getCustomHQ(CUSTOM_HQ_TYPE.NPC)
    local SceneManager = require("app.game.SceneManager")
    if setting or SceneManager:getInstance():isGhostAbyss() then
        self._functionNPCAnimation = Avalon.Animation:create(skeleton, atlas, scale)

        if (self._functionNPCAnimation) then
            self:addChild(self._functionNPCAnimation)
        else
           assert(false, string.format("[ERROR] FunctionNPCRenderer init: create treasure animation (%s,%s,%f) failed.", skeleton, atlas, scale))
        end
    else
        local idx = string.find(skeleton, ".json")
        local imgName = string.sub(skeleton, 1, idx)
        local fileName = imgName .. "png"
        if self.loadedPlist then
            self._functionNPCImage = UI.Image:create();
            self._functionNPCImage:init(fileName)
            self._functionNPCImage:center(self.ox, -self.oy)
            self:addChild(self._functionNPCImage)
        else
            Avalon.ResHelper:loadPlistSync(plistName)
            self._functionNPCImage = UI.Image:create();
            self._functionNPCImage:init(fileName)
            self._functionNPCImage:center(self.ox, -self.oy)
            self:addChild(self._functionNPCImage)
        end
    end

    self:idle()

    self._triggerCount = 0
    self:_registerSpineEventHandle()

    self:addBottomLittle()

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        self:addName(iconName, functionName, nickName, informationHeight)
    end, 0.1)
    
    self._stopBreath = false
    self._skin = ""
end

function FunctionNPCRenderer:addName(iconName, functionName, nickName, informationHeight)
    if(iconName and functionName and functionName ~= "") then
        nickName = nickName or ""

        local layout = UI.Layout:create()
        layout:init()
        informationHeight = informationHeight or 120
        layout:centerBottom(informationHeight + 40)
        self._viewNode:addChild(layout, 100)

        local bottomBlackSide = cc.Scale9Sprite:createWithSpriteFrameName("ui_public_banner_black_image.png", cc.rect(70,1,400,25))
        layout:addChild(bottomBlackSide)
        bottomBlackSide:setOpacity(150)

        -- 
        local iconImage = UI.Image:create()
        iconImage:init(iconName)
        layout:addChild(iconImage)

        local functionText = UI.Text:create()
        functionText:init(functionName, UI.FONT_BLOD, UI.FONT_SIZE_18PX, {r = 255, g = 235, b = 52})
        layout:addChild(functionText)

        local totalWidth = (iconImage:getContentSize().width + functionText:getContentSize().width)
        local halfWidth = totalWidth/2
        local startX = -halfWidth - iconImage:getContentSize().width
        iconImage:centerLeft(-iconImage:getContentSize().width - functionText:getContentSize().width/2)
        functionText:center()

        local height = 23
        bottomBlackSide:setContentSize(cc.size(totalWidth, height))  
        -- bottomBlackSide:setPosition(cc.p(-totalWidth/2, 0))

        local nickText = UI.Text:create()
        nickText:init(nickName, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 255, g = 235, b = 52})
        layout:addChild(nickText)
        nickText:centerUp(height/2 + 4)
    end
end

function FunctionNPCRenderer:setCryingFlag(cryingFlag)
    self._cryingFlag = cryingFlag
end

-- 设置方向
function FunctionNPCRenderer:setDirection(direction)
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
        print(string.format("FunctionNPCRenderer setDirection: set direction %d.", direction))
    end
end

-- 设置待机视图
function FunctionNPCRenderer:idle()
    if (self._functionNPCAnimation) then
        self._functionNPCAnimation:setToSetupPose()
        self._functionNPCAnimation:setAnimation(0, "idle1", true)
    end    
end

function FunctionNPCRenderer:trigger(callBack)
    if (self._functionNPCAnimation and self._isTriggering == nil) then
        self._isTriggering = true
        local start = AvalonUtil.getLock()
        local delayTime = 52/31

        -- Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        --     if self._viewNode and (not tolua.isnull(self._viewNode)) then
        --         self._isTriggering = nil
        --         if(callBack) then 
        --             callBack()
        --         end
        --     end
        -- end, delayTime)

        -- print("FunctionNPCRenderer:trigger 1", start)
        self._functionNPCAnimation:registerSpineEventHandler(function(event)
            local startPos = string.find(event.animation, "trigger")
            if (startPos ~= nil) then
                self._isTriggering = nil
                if(callBack) then 
                    callBack()
                    callBack = nil
                end
            end
        end, sp.EventType.ANIMATION_END)
        self._functionNPCAnimation:setToSetupPose()
        self._functionNPCAnimation:setAnimation(0, "trigger", false)
    end    
end

function FunctionNPCRenderer:getTopFog()
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

function FunctionNPCRenderer:addBottomLittle()
    if(self._functionNPCAnimation) then
        
        -- local bottomLittle = Avalon.Animation:create("effect_role_npc_bottom_light.json", "effect_role_npc_bottom_light.atlas", 1)
        -- bottomLittle:setAnimation(0, "idle", true)
        -- self._functionNPCAnimation:addComponent("mount_bottomdown_npc", bottomLittle)
    end
end

-- 触发一次呼吸效果
function FunctionNPCRenderer:triggerBreath()
    -- print("FunctionNPCRenderer:triggerBreath ")
    if(self._isTriggering == true) then 
        return 
    end
    if (self._functionNPCAnimation) then
        -- print("FunctionNPCRenderer:triggerBreath 2")
        if(self._cryingFlag) then 
            -- self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "crying", false)
            self._functionNPCAnimation:addAnimation(0, "idle1", true)
        else
            -- self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "idle2", false)
            self._functionNPCAnimation:addAnimation(0, "idle1", true)
        end
    end
end

function FunctionNPCRenderer:createLightViewList(animation, rotate)
    if(self._lightAnimationList == nil) then
        self._lightAnimationList = {}
        
        local npcAnimation = Avalon.Animation:create("effect_role_npc_bottom_light.json", "effect_role_npc_bottom_light.atlas", 1.0)
        npcAnimation:retain()
        table.insert(self._lightAnimationList, npcAnimation)
        npcAnimation:setAnimation(0, animation, true)
        npcAnimation:rotate(rotate)
    end

    return self._lightAnimationList
end

-- 设施打开显示
function FunctionNPCRenderer:showOpenIt(recoverOpen)
    if(self._isTriggering == true) then 
        return 
    end
    -- print("FunctionNPCRenderer:showOpenIt ",recoverOpen)
    if (self._functionNPCAnimation) then
        -- print("FunctionNPCRenderer:showOpenIt 123 ",recoverOpen)

        self._stopBreath = true
        if recoverOpen then
            self._functionNPCAnimation:setAnimation(0, "end", true)
        else
            self._functionNPCAnimation:setAnimation(0, "open1", false)
            self._functionNPCAnimation:addAnimation(0,"end",true)
        end
        

    end
end

function FunctionNPCRenderer:startInteraction(functionType)
    if(self._isTriggering == true) then 
        return 
    end
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
            -- self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "begin_01", false)
            self._functionNPCAnimation:addAnimation(0, string.format("begin_0%d", randomNum), false)
            self._functionNPCAnimation:addAnimation(0, string.format("idle_0%d", randomNum), true)
            -- self._functionNPCAnimation:addAnimation(0, "begin_idle", true)
        elseif (self._functionType == FUNCTION_TYPE.WAREHOUSE) then
            -- print("FunctionNPCRenderer:startInteraction  FUNCTION_TYPE.WAREHOUSE")
            -- self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "begin_01", false)
            self._functionNPCAnimation:addAnimation(0, "begin_idle", true)

        elseif (self._functionType == FUNCTION_TYPE.GENERAL_ENTRANCE) then
            -- print("FunctionNPCRenderer:startInteraction  FUNCTION_TYPE.GENERAL_ENTRANCE")
            -- self._functionNPCAnimation:setAnimation(0, "begin_01", false)
            -- self._functionNPCAnimation:addAnimation(0, "begin_idle", true)
        else
            -- self._functionNPCAnimation:setToSetupPose()
            self._functionNPCAnimation:setAnimation(0, "begin", false)
            self._functionNPCAnimation:addAnimation(0, "idle1", true)
        end 
    end
end

function FunctionNPCRenderer:endInteration()
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
function FunctionNPCRenderer:onDraw(dt)

end

--
function FunctionNPCRenderer:_registerSpineEventHandle()
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
                    -- TODO 播放音效文件
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

function FunctionNPCRenderer:_randomInteractionAnimation()
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

function FunctionNPCRenderer:refreshMailNewFlag(isRemove)
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

function FunctionNPCRenderer:playDreamNpcOpenAct()
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

function FunctionNPCRenderer:setVisible( visible )
    FunctionNPCRenderer.super.setVisible(self,visible)

    if self._functionNPCAnimation then
        self._functionNPCAnimation:setVisible(visible)
    end
    
    -- print("FunctionNPCRenderer.setVisible",visible)
end

function FunctionNPCRenderer:setInitMapCoordOnAnimation(coord)
    if self._functionNPCAnimation then
        self._functionNPCAnimation._initCoord = coord
    end
end

function FunctionNPCRenderer:pause()
    FunctionNPCRenderer.super.pause(self)
    if(not tolua.isnull(self._functionNPCAnimation)) then 
        self._functionNPCAnimation:pause()
    end
end

function FunctionNPCRenderer:resume()
    FunctionNPCRenderer.super.resume(self)
    if(not tolua.isnull(self._functionNPCAnimation)) then
        self._functionNPCAnimation:resume()
    end
end


--装备架换装相关
function FunctionNPCRenderer:handleEquipmentChange(wearEquipArr)

    if wearEquipArr == nil then
        return
    end
    require "app.datas.EquipIllusionDataManager"

    local skin = "initial"
    for k,v in pairs(wearEquipArr) do
        -- 判断是否有盔甲
        local equipType = v:getEquipmentType()
        if equipType == EQUIPMENT_TYPE.Chest then
            local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
            if(illusionEquipData) then
                skin = illusionEquipData:getAttachmentID()
            end
            break
        end
    end
    -- 替换盔甲
    self:changeArmor(skin)

    local handleTypeArr = {}
    
    for k,v in pairs(wearEquipArr) do
        -- 替换装备,这里要求不能为盔甲
        local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
        local equipType = illusionEquipData:getEquipmentType()

        local animationArr = self._equipmentArr[equipType]
        if(animationArr) then 
            for k, animation in pairs(animationArr) do
                if(not tolua.isnull(animation)) then 
                    animation:removeFromParent()
                end
            end
        end
        animationArr = {}

        if equipType == EQUIPMENT_TYPE.Helmet then
            self:changeHelmet(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Shoulders then
            self:changeShoulder(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Gloves then
            self:changeGloves(illusionEquipData)
        -- elseif equipType == EQUIPMENT_TYPE.Boots then
        --     self:changeShoes(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Weapon then
            self:changeWeapon(illusionEquipData)
        end
        handleTypeArr[equipType] = true
        self:handleEquipmentAnimation(illusionEquipData)
    end

    for k, animationArr in pairs(self._equipmentArr) do 
        if(not handleTypeArr[k] and animationArr) then 
            for k, animation in pairs(animationArr) do 
                if(not tolua.isnull(animation)) then
                    animation:removeFromParent()
                end
            end
            animationArr = nil
        end
    end
end

function FunctionNPCRenderer:heroSelfAddComponent(mountName, animationNode)
    if(self._functionNPCAnimation and animationNode and mountName) then
        self._functionNPCAnimation:addComponent(mountName, animationNode)
        if(self.isPause) then
            Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function()
                if(not tolua.isnull(animationNode)) then
                    animationNode:pause()
                end
            end, 2)
        end
    end
end

function FunctionNPCRenderer:handleEquipmentAnimation(equipmentData)
    if(equipmentData) then 
        local equipType = equipmentData:getEquipmentType()
        local spineName,slotOrAnimationArr = equipmentData:getWeaponEffectCombination()
        
        if(spineName and slotOrAnimationArr and #slotOrAnimationArr > 0) then
            self._equipmentArr[equipType] = {}
            for k, v in ipairs(slotOrAnimationArr) do 
                local slotName = v
                local animationName = v
                local animation = UI.Animation:create()
                animation:init(spineName..".json", spineName..".atlas", 1)
                animation:setAnimation(animationName, true)
                self:heroSelfAddComponent(slotName, animation)

                if self._equipmentArr[equipType] == nil then 
                    self._equipmentArr[equipType] = {}
                end
                table.insert(self._equipmentArr[equipType], animation)
            end
        end
    end
    -- 
end


-- 换盔甲
function FunctionNPCRenderer:changeArmor(skin)
    if self._functionNPCAnimation and skin then
        if (self._skin ~= skin) then
            self._skin = skin
            self._functionNPCAnimation:setSkin(skin)
        end
        self._functionNPCAnimation:setToSetupPose()
    end
end

-- 换头盔
function FunctionNPCRenderer:changeHelmet(equipmentData)
    
    if self._functionNPCAnimation and equipmentData then
        local equipmentID = equipmentData.goodsID
        local remarksField = AvalonUtil:splitStr(equipmentData.remarksField[1], ",")
        -- 处理最前面一位
        local attachmentID = equipmentData:getAttachmentID()     
        -- 新增的头盔表现
        local attachmentName = string.format("101/0/%s/%s-0-",attachmentID,attachmentID)
        local mountName = 101
        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._functionNPCAnimation:setAttachment(name,attachment)
                end
            end
        end

    end
end

-- 换肩膀
function FunctionNPCRenderer:changeShoulder(equipmentData)
    if self._functionNPCAnimation and equipmentData then
        local equipmentID = equipmentData.goodsID
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("103/0/%s/%s-0-",attachmentID,attachmentID)
        local mountName = 103

        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._functionNPCAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end 

-- 换手套
function FunctionNPCRenderer:changeGloves(equipmentData)
    if self._functionNPCAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("104/0/%s/%s-0-",attachmentID,attachmentID)

        local mountName = 104
        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._functionNPCAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end

-- 武器
function FunctionNPCRenderer:changeWeapon(equipmentData)
    if self._functionNPCAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentNamePre = string.format("108/0/%s/%s-0-",attachmentID,attachmentID)
        local weaponStr = self:getWeaponStr(equipmentData:getWeaponType())
        local combination = equipmentData.componentCombination
        for k,value in ipairs(combination) do
            local mountName = "outside"
            local attachmentName = attachmentNamePre

            if value == "01" then
                mountName = "inside"
            elseif value == "02" then
                mountName = "outside"
            elseif value == "03" then
                mountName = "book"
            elseif value == "04" then
                mountName = "shield"
            elseif(tonumber(value) > 100 and tonumber(value) < 400) then 
                mountName = string.format("inside-%s-%s", weaponStr, value)
                attachmentName = string.format("%s01-", attachmentName)
            elseif (tonumber(value) > 400) then
                mountName = string.format("shield-%s-%s", weaponStr, value)
                attachmentName = string.format("%s04-", attachmentName)
            end

            attachmentName = attachmentName..value
            self._functionNPCAnimation:setAttachment(mountName,attachmentName)
        end
    end
end

function FunctionNPCRenderer:getWeaponStr(weaponType) 
    local weaponStr = nil
    if(weaponType == 1) then 
        weaponStr = "01"
    elseif (weaponType == 2) then 
        weaponStr = "02"
    elseif (weaponType == 3) then 
        weaponStr = "03"
    end

    return weaponStr
end

function FunctionNPCRenderer:calculationMountNameAndAttachmentName(mountBase, attachmentBaseName, combination)
    local totalLen = string.len(combination)
    local mountName = mountBase
    local attachment = ""
    if(totalLen <=2) then 
        mountName = mountName..combination
        attachment = attachmentBaseName..combination
    else
        local partStr = string.format("%02d", string.sub(combination, 1, totalLen- 2))
        mountName = mountName..partStr.."-"..combination
        attachment = attachmentBaseName..partStr.."-"..combination
    end

    return mountName, attachment
end
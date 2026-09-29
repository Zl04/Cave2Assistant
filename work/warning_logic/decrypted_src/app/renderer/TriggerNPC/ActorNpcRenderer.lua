--ActorNpcRenderer.lua
--2019-03-14
--Author:zp
--触发类NPC 渲染器

require "app.renderer.Renderer"

local TRIGGER_NPC_TYPE = PublicDefine.TRIGGER_NPC_TYPE

Renderer = Renderer or {}

local ActorNpcRenderer = class("ActorNpcRenderer", Renderer.Base)
Renderer.ActorNpcRenderer = ActorNpcRenderer

-- private:
local DEBUG = false
local SHOW_IDLE_NUM = 2

-- 这里记录了所有武器类型播放的动画
local ALL_ANIMATION_NAME = {
    {"idle_fun_1", "idle_fun_3", "skill_30100101", "skill_30101901"},
    {"idle_fun_1", "idle_fun_3", "skill_30100201", "skill_30101001", "skill_30101901"},
    {"idle_fun_2", "idle_fun_3", "skill_30200401", "skill_30200901", "skill_30201501"},
    {"idle_fun_1", "idle_fun_4", "skill_30300101", "skill_30301401", "skill_30301801"}}

-- private:
-- 构造函数
function ActorNpcRenderer:ctor()
    ActorNpcRenderer.super.ctor(self)

    self._triggerNPCDown = nil
    self._triggerNPCUp = nil
    self._heroRenderer = nil

    self._nowAnimationArr = {}
    self._showIndex = 0
end

-- 析构函数
function ActorNpcRenderer:dtor()
    ActorNpcRenderer.super.dtor(self)

    self._triggerNPCDown = nil
    self._triggerNPCUp = nil
    self._heroRenderer = nil
    self._nowAnimationArr = {}
end

-- public:
-- 初始化
function ActorNpcRenderer:init(skeleton, atlas, scale, npcType, isLock)
    -- print(" ActorNpcRenderer:init ",skeleton, atlas, scale)
    
    self._triggerNPCDown = Avalon.Animation:create("role_npc_function_dreamword_down.json", "role_npc_function_dreamword_down.atlas", scale)
    self._triggerNPCUp = Avalon.Animation:create("role_npc_function_dreamword_up.json", "role_npc_function_dreamword_up.atlas", scale)
    self._npcType = npcType

    if (self._triggerNPCDown) then
        self:addChild(self._triggerNPCDown, 1)
    end

    if (self._triggerNPCUp) then
        self:addChild(self._triggerNPCUp, 3)
    end

    self:idle()
    self:setVisible(false)
    self:registerSpineEventHandler()
end

function ActorNpcRenderer:triggerOneShow(detailHeroData) 
    -- print("ActorNpcRenderer:triggerOneShow", detailHeroData)
    self._detailHeroData = detailHeroData

    -- 处理播放一次显示效果
    self:setVisible(true)

    if(self._triggerNPCUp) then 
        if(detailHeroData == nil) then 
            self._triggerNPCUp:setAnimation(0, "begin", false)
            self._triggerNPCUp:addAnimation(0, "idle1", true)
        else
            self._triggerNPCUp:setAnimation(0, "begin", false)
            self._triggerNPCUp:addAnimation(0, "transfor", false)
            self._triggerNPCUp:addAnimation(0, "idle2", true)
        end
    end

end

-- 设置皮肤
function ActorNpcRenderer:setSkin(skinName)
    if (self._triggerNPCDown) then
        self._triggerNPCDown:setSkin(skinName)
    end
end

function ActorNpcRenderer:speedUp(timeScale)
    if(self._triggerNPCDown) then
        self._triggerNPCDown:setTimeScale(timeScale)
    end 
    if(self._triggerNPCUp) then
        self._triggerNPCUp:setTimeScale(timeScale)
    end 
end

function ActorNpcRenderer:showMove()

end

-- 设置方向
function ActorNpcRenderer:setDirection(direction)

end

function ActorNpcRenderer:showIDLE()

end

-- 设置待机视图
function ActorNpcRenderer:idle()

end

-- 触发移除自己
function ActorNpcRenderer:_triggerRemoveSelf()
    if (DEBUG) then
        print("ActorNpcRenderer:_triggerRemoveSelf ")
    end
end

function ActorNpcRenderer:getSpine()
    -- body
    return self._triggerNPCDown
end

-- 渲染
function ActorNpcRenderer:onDraw(dt)

end

function ActorNpcRenderer:registerSpineEventHandler()
    self._triggerNPCUp:registerSpineEventHandler(function (event)
        -- print("self._triggerNPCUp:registerSpineEventHandle", event.animation, self._showIndex)
        if(event.animation == "begin") then
            if(self._detailHeroData) then 
                if(self._triggerNPCDown) then
                    -- print("self._triggerNPCUp:registerSpineEventHandle", event.animation, self._showIndex) 
                    self._triggerNPCDown:setAnimation(0, "transfor", false)
                    self._triggerNPCDown:addAnimation(0, "idle2", true)
                end
            end
        end

        if(self._detailHeroData == nil) then 
            if(event.animation == "idle1") then
                self._showIndex = self._showIndex + 1
                if(self._showIndex > SHOW_IDLE_NUM) then 
                    self:oneShowEnd()
                end
            end

            if(event.animation == "transfor") then 
                self:setVisible(false)
            end
        else 
            if(event.animation == "end") then 
                self:setVisible(false)
            end
        end
    end, sp.EventType.ANIMATION_COMPLETE)

    self._triggerNPCUp:registerSpineEventHandler(function (event)
        if(self._detailHeroData) then 
            if(event and event.eventData and event.eventData.name and event.eventData.name == "trigger_hero") then
                -- 准备玩家表现显示
                if(self._heroRenderer) then 
                    local view = self._heroRenderer:getView()
                    if(view) then 
                        view:removeFromParent()
                    end
                    self._heroRenderer = nil
                end

                self._heroRenderer = self:createHeroAnimation()
                if(self._heroRenderer) then
                    local view = self._heroRenderer:getView()
                    if(view) then 
                        self:addChild(view, 2)
                    end

                    -- 随机生成一些动画表现，顺序播放就可以了
                    self._showIndex = 1
                    if(self._nowAnimationArr[self._showIndex]) then 
                        self._heroRenderer:showReleaseSkill(self._nowAnimationArr[self._showIndex])
                    else 
                        -- 消失掉
                        self:oneShowEnd()
                    end
                end
            end

            if(event and event.eventData and event.eventData.name and event.eventData.name == "end_hero") then
                if(self._heroRenderer) then 
                    local view = self._heroRenderer:getView()
                    if(view) then 
                        view:removeFromParent()
                    end
                    self._heroRenderer = nil
                end
            end
        end
    end, sp.EventType.ANIMATION_EVENT)
end

function ActorNpcRenderer:oneShowEnd()
    -- print("ActorNpcRenderer:oneShowEnd")
    -- print(debug.traceback())
    if(self._detailHeroData) then 
        if(self._triggerNPCDown) then 
            self._triggerNPCDown:setAnimation(0, "end", false)
        end

        if(self._triggerNPCUp) then 
            self._triggerNPCUp:setAnimation(0, "end", false)
        end
    else 
        if(self._triggerNPCUp) then 
            self._triggerNPCUp:setAnimation(0, "transfor", false)
        end
    end
end

function ActorNpcRenderer:setVisible( visible )
    ActorNpcRenderer.super.setVisible(self,visible)

    if self._triggerNPCDown then
        self._triggerNPCDown:setVisible(visible)
    end
    if self._triggerNPCUp then
        self._triggerNPCUp:setVisible(visible)
    end
    -- print("ActorNpcRenderer.setVisible",visible)
end

function ActorNpcRenderer:createHeroAnimation()
    local detailHero = self._detailHeroData
    if(detailHero) then
        local heroData = detailHero.heroData
        local equpmentArr = detailHero.wearEquipmentArr
        -- 这里采用排行的数据来处理

        local skeletonFile, atlasFile, scale = heroData.skeleton, heroData.atlas, heroData.scale
        local sex = heroData:getSex()
        local faceDecodeID = heroData:getFaceDecodeID()
        local looks = heroData:getLooks()
        local isHideHelmet = heroData:getIsHideHelmet()
        local pk = heroData:getPK()
        local isMaster = false
        renderer = Renderer.HeroRenderer:create()
        renderer:init(skeletonFile, atlasFile, scale, sex, isMaster, faceDecodeID, looks, isHideHelmet, true)

        -- 刷新装备
        renderer:refreshEquip(equpmentArr)
        local weaponType = 0
        for k,v in pairs(equpmentArr) do
            -- 替换装备,这里要求不能为盔甲
            local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
            local equipType = illusionEquipData:getEquipmentType()
            if equipType == PublicDefine.EQUIPMENT_TYPE.Weapon then
                weaponType = illusionEquipData:getWeaponType()
            end
        end
        
        self._nowAnimationArr = ALL_ANIMATION_NAME[weaponType + 1]
        renderer._heroSelfAnimation:registerSpineEventHandler(function (event)
            -- 切换表现列表
            self._showIndex = self._showIndex + 1
            if(self._nowAnimationArr[self._showIndex]) then 
                self._heroRenderer:showReleaseSkill(self._nowAnimationArr[self._showIndex])
            else 
                -- 消失掉
                self:oneShowEnd()
            end
        end, sp.EventType.ANIMATION_COMPLETE)

        local rankData = MasterDataManager:getPreDreamRankDataForPK(heroData:getPK())
        local guildName = ""
        if(rankData) then 
            guildName = rankData.guildName
        end
        renderer:showDreamStyleName(heroData:getNickName(), guildName)

        return renderer
    end

    return nil
end

function ActorNpcRenderer:pause()
    ActorNpcRenderer.super.pause(self)
    if(not tolua.isnull(self._heroRenderer)) then
        self._heroRenderer:pause()
    end
    if(not tolua.isnull(self._triggerNPCDown)) then
        self._triggerNPCDown:pause()
    end
    if(not tolua.isnull(self._triggerNPCUp)) then
        self._triggerNPCUp:pause()
    end

end

function ActorNpcRenderer:resume()
    ActorNpcRenderer.super.resume(self)
    if(not tolua.isnull(self._heroRenderer)) then
        self._heroRenderer:resume()
    end
    if(not tolua.isnull(self._triggerNPCDown)) then 
        self._triggerNPCDown:resume()
    end
    if(not tolua.isnull(self._triggerNPCUp)) then 
        self._triggerNPCUp:resume()
    end
end
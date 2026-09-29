-- HeroHandLayer.lua
-- Author:ODEI
-- 2017年5月23日
-- Using:头像管理 

require "app.ui.heroHandLayer.HeroPanel"
require("app.datas.TeamDataManager")
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local SceneManager = require("app.game.SceneManager")
UI = UI or {}
local winSize = cc.Director:getInstance():getWinSize()

local HeroHandLayer = class("HeroHandLayer", UI.HWBtnComponent)
UI.HeroHandLayer = HeroHandLayer

local heroPanelState = {
    normal = 1,         --正常状态
    waitMate = 2,       --等待匹配
    waitJoin = 3,       --等待加入
    offLine = 4,        --离线
    die = 5,            --死亡状态
}

-- 资源列表(必备)
local COM_RES_LIST = {
}


--构造函数(必备)
function HeroHandLayer:ctor()
    print("@@@@@","HeroHandLayer:ctor")
	--窗口大小
    HeroHandLayer.super.ctor(
        self,UIType.HERO_HAND_LAYER,
        COM_RES_LIST,
        UI.size.width,
        UI.size.height
    )

    -- self._monsterTarget = nil   -- 怪物攻击的对象spriteID

    self.rootLayer = nil;           --root节点

    self.mHeroHand = nil;           --主角头像
    self.mPetHand = nil;            --宠物头像
    self.mTeamHand = {};            --队友头像
    self.mTeamHandList = {};
    self.mNullTeamHand = nil;        --待匹配队友头像
    self.mWaitJoinTeamHand = {};    --等待加入列表
    self.mPetHandList = {}          --宠物头像列表

    self.skillSelectState = false;  --技能选择状态

    self:setTouchEnable(false);
    self:setInterceptTouches(false);
    self:registerListener();
    self:init();
end

--虚构函数,destroy时调用(必备)
function HeroHandLayer:dtor()
    
    HeroHandLayer.super.dtor(self)

    -- self._monsterTarget = nil   -- 怪物攻击的对象spriteID

    self.rootLayer = nil;           --root节点

    self.mHeroHand = nil;           --主角头像
    self.mPetHand = nil;            --宠物头像
    self.mTeamHand = {};            --队友头像
    self.mNullTeamHand = nil;        --待匹配队友头像
    self.mWaitJoinTeamHand = {};    --等待加入列表
    self.mPetHandList = {}          --宠物头像列表
    self:unRegisterListener();
end

-- 初始化(必备)
function HeroHandLayer:init()
    HeroHandLayer.super.init(self)
    -- self:setToCacheTexture(true)
end


-- 模版函数：初始化组建的视图(必备)
function HeroHandLayer:onInitView()
    --self:addColorBG()		--灰色遮罩层

	--root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(Avalon.issUtil:getLeftMargin(), 0)
    self.rootLayer:setContentSize(cc.size(UI.size.width + Avalon.issUtil:getWidthOffset(), UI.size.height))
    self:addChild(self.rootLayer)

    local heroData = RoleDataManager:getMaster()


    if not SceneManager:getInstance():isInFightScene() then
        local teamData = TeamDataManager:transformTeamData(heroData,GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)
        self:addHeroHand(teamData)
        self.mHeroHand:refreshView(heroData)
    else
    	--在这里填写界面
        if TeamDataManager:hasTeam() then
            local count = 0
            local teamData = TeamDataManager:getTeamData();
            for k , v in pairs(teamData) do
                if k == RoleDataManager:getMasterPK() then
                    self:addHeroHand(v)
                    self.mHeroHand:refreshView(heroData)
                else
                    -- self:addTeamHand(v)
                end
                count = count + 1
            end

            count = self:addTeamHandByReadyTeam() + count

            
            -- if count < PublicDefine.CONST_DEFINITION.MAX_TEAM_NUM then
            --     self:addTeamHand(nil)
            -- end
        else
            local teamData = TeamDataManager:transformTeamData(heroData,GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)
            self:addHeroHand(teamData)
            self.mHeroHand:refreshView(heroData)
        end
    end
    self:addPetHand()
    
    if (device.platform == "android") then
        -- 处理在安卓上一些特殊情况下(深度睡眠返回丢失GLContext)的RenderTexture渲染BUG
        local listener = cc.EventListenerCustom:create(EVENT_RENDERER_RECREATED, function(event)
            if (self.mHeroHand and not tolua.isnull(self.mHeroHand)) then
                local heroData = RoleDataManager:getMaster()
                if (heroData) then
                    self.mHeroHand:refreshView(heroData, true)
                end
            end
            if (self.mPetHandList and next(self.mPetHandList)) then
                local pets = RoleDataManager:getScreenFightPetData()
                -- local pets = MasterDataManager:getFightPet()
                -- if (pet) then
                --     self.mPetHand:refreshView(pet, true)
                -- end
                if pets then
                    for _, pet in pairs(pets) do
                        if pet and self.mPetHandList[pet:getSiteId()] then
                            self.mPetHandList[pet:getSiteId()]:refreshView(pet, true)
                        end 
                    end
                end
            end
        end)
        cc.Director:getInstance():getEventDispatcher():addEventListenerWithFixedPriority(listener, 1)
    end
end

--添加主角头像
function HeroHandLayer:addHeroHand(data)
    if self.mHeroHand == nil then
        self.mHeroHand = UI.HeroPanel:create(UIType.HEROSTATUS)
        -- 获取英雄数据
        self.mHeroHand:init(data) 
        -- self.mHeroHand:setPos(100, 5)
        self.mHeroHand:leftUp(8, 2)
        -- 记录主角英雄面板
        self.mHeroHand:setTag(data:getPK())
        self.mHeroHand:registerRoleHandler(self,self.onClickHandCallBack,self.mHeroHand)
        self.rootLayer:addChild(self.mHeroHand, 100)
    end
end

--添加主角头像
function HeroHandLayer:addPetHand()
    -- 在一些特殊场景不需要有宠物
    if(ToolsUtil:getIsShieldPet()) then 
        return 
    end

    -- local pet = RoleDataManager:getScreenFightPetData()
    local captainPet = RoleDataManager:getCaptain()--RoleDataManager:getCaptain()
    local sites = MasterDataManager:getSitesData()
    local petData = RoleDataManager:getScreenFightPetData()
    -- local petData = MasterDataManager:getFightPet()
    if not captainPet then
        return
    end
    if not petData or not next(petData) then
        return
    end
    if captainPet then
        if self.mPetHand == nil then
            self.mPetHand = UI.HeroPanel:create(UIType.PETSTATUS)
            self.mPetHand:init(captainPet) 
            self.mPetHand:leftUp(10, 58)
            -- 记录主角英雄面板
            self.mPetHand:setTag(captainPet:getPK())
            self.rootLayer:addChild(self.mPetHand, 100)
            
        end
        self.mPetHand:refreshView(captainPet, true)
        self.mPetHandList[0] = self.mPetHand
    end

    -- for k, v in pairs(sites) do
    -- end
    for i =2, 3 do
        -- if pet[i] and sites[i-1] and sites[i-1].siteId == pet[i].siteId and sites[pet[i].petId] ~= 0 then
        if sites[i-1] and sites[i-1].siteId and tonumber(sites[i-1].petId) ~= 0 then
            if self.rootLayer:getChildByName("hand"..i) then
                local hand = self.rootLayer:getChildByName("hand"..i)
                hand:removeFromParent()
                self.mPetHandList[i-1] = nil
            end
            local petData = RoleDataManager:getScreenPetDataByInsId(sites[i-1].petId)
            if  not self.mPetHandList[i-1] or tolua.isnull(self.mPetHandList[i-1]) then
                local petHand = UI.HeroPanel:create(UIType.PETSTATUS)
                petHand:init(petData)
                petHand:leftUp(10+(i-1)*70, 58)
                -- 记录主角英雄面板
                petHand:setName("hand"..i)
                self.rootLayer:addChild(petHand, 100)
                self.mPetHandList[i-1] = petHand
            end
            self.mPetHandList[i-1]:refreshView(petData, true)
        elseif sites[i-1] and sites[i-1].petId == 0 then
            if self.rootLayer:getChildByName("hand"..i) then
                local hand = self.rootLayer:getChildByName("hand"..i)
                hand:removeFromParent()
                self.mPetHandList[i-1] = nil 
            end
            local petHand = UI.HeroPanel:create(UIType.PET_NULL)
            petHand:init(nil)
            petHand:leftUp(10+(i-1)*70, 58)
            petHand:setPetNull()
            -- petHand:setTag(101+i)
            petHand:setName("hand"..i)
            self.rootLayer:addChild(petHand, 100)
        elseif not sites[i-1] then
            local petHand = UI.HeroPanel:create(UIType.PET_SITE_UNLOCK)
            petHand:init(nil)
            petHand:leftUp(10+(i-1)*70, 58)
            petHand:setPetUnlock()
            -- petHand:setTag(101+i)
            petHand:setName("hand"..i)
            self.rootLayer:addChild(petHand, 100)
        end
    end
end

--添加队友头像
function HeroHandLayer:addTeamHand(data,state)
    -- if not SceneManager:getInstance():isInFightScene() then
    --     return
    -- end

    -- if data == nil then
    --     -- add by zp CO-6405  所有的洞穴只要是踢人了就不能在组人
    --     -- if SceneManager:getInstance():isInDungeon() then
    --     if SceneManager:getInstance():isInFightScene() then
    --         self:updateRolePanel();
    --         return
    --     end

    --     if self.mNullTeamHand == nil then
    --         local comp = UI.HeroPanel:create(UIType.TEAMMATESTATUS)
    --         comp:init(data) 
    --         self.mNullTeamHand = comp
    --         self.rootLayer:addChild(comp)
    --         comp:waitMate()
    --         comp:setTeamUI()
    --         self:updateRolePanel()
    --         return comp
    --     else
    --         self:updateRolePanel();
    --         return self.mNullTeamHand
    --     end
    -- else
    --     if self.mTeamHand[data:getPK()] == nil then
    --         if self.mWaitJoinTeamHand[data:getPK()] ~= nil then
    --             self.mWaitJoinTeamHand[data:getPK()]:removeFromParent()
    --             self.mWaitJoinTeamHand[data:getPK()] = nil;
    --         else
    --             if self.mNullTeamHand ~= nil then
    --                 self.mNullTeamHand:removeFromParentAndCleanup(true)
    --                 self.mNullTeamHand = nil;
    --             end
    --         end
    --         -- print("HeroHandLayer:addTeamHand 添加角色=====id",data:getPK())
    --         local comp = UI.HeroPanel:create(UIType.TEAMMATESTATUS)
    --         comp:init(data)
    --         self.rootLayer:addChild(comp)
    --         comp:registerRoleHandler(self,self.onClickHandCallBack,comp)
            
    --         if state == nil then
    --             self.mTeamHand[data:getPK()] = comp
    --             table.insert(self.mTeamHandList,comp)
    --             local _data = RoleDataManager:getHeroDataForPK(data.pk)
    --             if _data then
    --                 comp:refreshView(_data)
    --             else
    --                 comp:setTeamUI()
    --             end
    --         elseif state == heroPanelState.waitJoin then
    --             self.mWaitJoinTeamHand[data:getPK()] = comp
    --             comp:waitJoin()
    --             comp:setTeamUI()
    --         end

    --         -- 更新英雄面板位置
    --         self:updateRolePanel()
    --         return comp
    --     end
    -- end

    -- return nil;
end

--根据队伍准备信息添加头像
function HeroHandLayer:addTeamHandByReadyTeam()
    local readyTeamData = TeamDataManager:getReadyTeamData()
    local count = 0;
    -- if readyTeamData ~= nil then
    --     for k,v in pairs(readyTeamData) do
    --         if v.pk ~= RoleDataManager:getMasterPK() then
    --             local teamRoleData = Data.TeamRoleData:create()
    --             local tab = {}
    --             tab.nickName = v.name
    --             tab.memberStatus = PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE
    --             tab.headID = v.headID
    --             tab.pk = v.pk
    --             teamRoleData:initNet(tab)
                
    --             self:addTeamHand(teamRoleData,heroPanelState.waitJoin)
    --             count = count + 1
    --         end
    --     end
    -- end

    return count
end


--添加头像
function HeroHandLayer:addHandPanel(data)
    -- print("HeroHandLayer:addHandPanel")
    if data:getPK() == RoleDataManager:getMasterPK() then
        self:addHeroHand(data)
    else
        -- self:addTeamHand(data)
    end
end

-- 移除队友信息查看
function HeroHandLayer:removeTeamHand(pk)
    -- print("HeroHandLayer:removeTeamHand")
    if pk and self.mTeamHand[pk] then

        for i = 1,#self.mTeamHandList do
            if self.mTeamHandList[i]:getPK() == pk then
                table.remove(self.mTeamHandList,i)
                break
            end
        end

        self.mTeamHand[pk]:removeFromParent()
        self.mTeamHand[pk] = nil 
        self:addTeamHand(nil)

    end
end




-- 更新队友位置
function HeroHandLayer:updateRolePanel()
    local roleCount = 1 
    for i = 1, #(self.mTeamHandList) do
        if self.mTeamHandList[i] ~= nil then
            -- 更新位置
            self.mTeamHandList[i]:setPos(8, 17 + roleCount * 77)
            roleCount = roleCount + 1 
            self.mTeamHandList[i]:setZOrder(100 - i)
        end
    end

    for pk,comp in pairs(self.mWaitJoinTeamHand) do 
        comp:setPos(8, 17 + roleCount * 77)
        roleCount = roleCount + 1 
    end

    if self.mNullTeamHand ~= nil then
        self.mNullTeamHand:setPos(8, 17 + roleCount * 77)
        roleCount = roleCount + 1 
    end
end


-- 技能选择好目标的回调
function HeroHandLayer:onClickHandCallBack(component)
    -- print("HeroHandLayer:onClickHandCallBack")
    if component then 
        -- 获取英雄的唯一标示 
        local pk = component:getPK()
        local spriteID = RoleDataManager:getHeroDataForPK(pk).spriteID

        Avalon.MessageCenter:notice(GameMessage.MC_HAND_CLICK,spriteID)
    end
end

--显示技能待选
function HeroHandLayer:showSkillSelect(targetType)
    -- print("HeroHandLayer:showSkillSelect",targetType)

    local bit = require "bit"
    local _targetType = bit.band(targetType,3)
    if bit.rshift(_targetType,1) == 1 then
        for id ,comp in pairs(self.mTeamHand) do
            if comp ~= nil then
                local heroData = RoleDataManager:getHeroDataForPK(id)
                if heroData and GameManager:judgeInSameBattleField(RoleDataManager:getMasterSpriteID(),heroData.spriteID) then
                    comp:ChoseRole()
                end
            end
        end
    end

    if _targetType%2 == 1 then
        if self.mHeroHand and (not tolua.isnull(self.mHeroHand)) then
            self.mHeroHand:ChoseRole()
        end
    end

    self.skillSelectState = true
end

--隐藏技能待选
function HeroHandLayer:hideSkillSelect()
    -- print("HeroHandLayer:hideSkillSelect")
    if self.mHeroHand and (not tolua.isnull(self.mHeroHand)) then
        self.mHeroHand:canelChoseRole()
    end

    for id, comp in pairs(self.mTeamHand) do
        if comp ~= nil and (not tolua.isnull(comp))  then
            comp:canelChoseRole()
        end
    end

    self.skillSelectState = false
end

--显示隐藏攻击目标特效
function HeroHandLayer:updateMonsterTargetEffect(spriteID)
    -- print("====monster attack Target",spriteID)
    if(tolua.isnull(self)) then
        return 
    end

    if self._monsterTarget ~= spriteID then 
        local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID)
        if roleData then
            local _pk = roleData:getPK()

            if self.mHeroHand:getTag() == self._monsterTarget then 
                self.mHeroHand:hideMonsterTarget()
            elseif self.mTeamHand[self._monsterTarget] then
                self.mTeamHand[self._monsterTarget]:hideMonsterTarget()
            end

            if self.mHeroHand:getTag() == _pk then 
                self.mHeroHand:showMonsterTarget()
            elseif self.mTeamHand[_pk] then
                self.mTeamHand[_pk]:showMonsterTarget()
            end
            self._monsterTarget = _pk
        end
    end
end


-- 英雄面板的更新
function HeroHandLayer:onUpdateHeroDataHandler(roleData)
    -- print("HeroHandLayer:onUpdateHeroDataHandler")
    if roleData:getType() == RoleType.Hero then
        local _pk = roleData:getPK()
        -- print("角色信息更新=====id",_pk)
        
        if roleData and self.mTeamHand[_pk] then
            self.mTeamHand[_pk]:refreshView(roleData)
            self.mTeamHand[_pk]:refreshRescure(roleData:getRescuedDungeonSurvivorCount())
        elseif self.mHeroHand and self.mHeroHand:getTag() == _pk then
            self.mHeroHand:refreshView(roleData)
            self.mHeroHand:refreshRescure(roleData:getRescuedDungeonSurvivorCount())
        end
    elseif roleData:getType() == RoleType.Pet then
        local pets = RoleDataManager:getScreenFightPetData()
        -- local pets = MasterDataManager:getFightPet()
        -- if self.mPetHand and pet and pet:getSpriteID() == roleData:getSpriteID() then
        --     self.mPetHand:refreshView(roleData)
        -- end
        for _, pet in pairs(pets) do
            if self.mPetHandList[pet:getSiteId()] and pet:getSiteId() == roleData:getSiteId() and pet and pet:getSpriteID() == roleData:getSpriteID() then
                self.mPetHandList[pet:getSiteId()]:refreshView(roleData)
            end
        end
    end
end


-- 角色状态改变
function HeroHandLayer:onUpdateRoleStateHandler(roleData)
    --  add by zp
    if roleData:getType() == RoleType.Hero then
        local _pk = roleData:getPK()
        if self.mHeroHand and self.mHeroHand:getTag() == _pk then
            self.mHeroHand:updateState(roleData)
        end

        -- 其他队友 
        if roleData and self.mTeamHand and self.mTeamHand[_pk] then
            self.mTeamHand[_pk]:updateState(roleData)

            local heroData = RoleDataManager:getHeroDataForPK(_pk)
            if self.skillSelectState == true then
                if heroData:getState() == FSMState.BATTLE then
                    if GameManager:judgeInSameBattleField(RoleDataManager:getMasterSpriteID(),heroData.spriteID) then
                        self.mTeamHand[_pk]:ChoseRole()
                    end
                end
            end
        end
    elseif roleData:getType() == RoleType.Pet then
        local pets = RoleDataManager:getScreenFightPetData()
        -- local pets = MasterDataManager:getFightPet()
        for _, pet in pairs(pets) do
            -- if self.mPetHand and v and v:getSpriteID() == roleData:getSpriteID() then
            --     self.mPetHand:updateState(roleData)
            -- end
            -- dump(pet, "onUpdateRoleStateHandler")
            -- print("onUpdateRoleStateHandler", self.mPetHandList[pet:getSiteId()] and pet:getSiteId() == roleData:getSiteId() and pet and pet:getSpriteID() == roleData:getSpriteID())
            if self.mPetHandList[pet:getSiteId()] and pet:getSiteId() == roleData:getSiteId() and pet and pet:getSpriteID() == roleData:getSpriteID() then
                self.mPetHandList[pet:getSiteId()]:updateState(roleData)
            end
        end
        
    end
end


-- 添加buff
function HeroHandLayer:onAddRoleBuffHandler(data)
    -- print("HeroHandLayer:onAddRoleBuffHandler",data.bufferTargetID,data.bufferTargetID,data.bufferEntityID)
    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            if data and self.mTeamHand[_pk] then
                self.mTeamHand[_pk]:addBuffView(data)
            elseif self.mHeroHand and (not tolua.isnull(self.mHeroHand)) and self.mHeroHand:getTag() == _pk then
                self.mHeroHand:addBuffView(data)
            end
        elseif roleData:getType() == RoleType.Pet then
            -- local pets = RoleDataManager:getScreenFightPetData()
            -- for _, pet in pairs(pets) do
            --     if data and pet and pet:getSpriteID() == spriteID and self.mPetHand then
            --         self.mPetHand:addBuffView(data)
            --     end
            -- end
        end
    end
end

-- 移除buff
function HeroHandLayer:onRemoveRoleBuffHandler(data)
    -- print("HeroHandLayer:onRemoveRoleBuffHandler",data.bufferTargetID)
    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()

            if data and self.mTeamHand[_pk] then
                self.mTeamHand[_pk]:removeBuffView(data)
            elseif self.mHeroHand and (not tolua.isnull(self.mHeroHand)) and self.mHeroHand:getTag() == _pk then
                self.mHeroHand:removeBuffView(data)
            end
        elseif roleData:getType() == RoleType.Pet then
            -- local pets = RoleDataManager:getScreenFightPetData()
            -- for _, pet in pairs(pets) do
            --     if data and pet and pet:getSpriteID() == spriteID and self.mPetHand then
            --         self.mPetHand:removeBuffView(data)
            --     end
            -- end
            
        end
    end
end

-- 角色buff页面的更新
function HeroHandLayer:onUpdateRoleBuffHandler(data)
    -- print("HeroHandLayer:onUpdateRoleBuffHandle", data.bufferTargetID)
    local spriteID = data.bufferTargetID
    local roleData = RoleDataManager:getRoleDataBySpriteID(spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()

            if data and self.mTeamHand[_pk] then
                self.mTeamHand[_pk]:updateBuffView(data)
            elseif self.mHeroHand and (not tolua.isnull(self.mHeroHand)) and self.mHeroHand:getTag() == _pk then
                self.mHeroHand:updateBuffView(data)
            end
        elseif roleData:getType() == RoleType.Pet then
            -- local pet = RoleDataManager:getScreenFightPetData()
            -- if data and pet and spriteID == pet:getSpriteID() and self.mPetHand then
            --     self.mPetHand:updateBuffView(data)
            -- end
        end
    end
end

--刷新队伍在线状态
function HeroHandLayer:updateOnLineState(pk,online)
    if self.mTeamHand[pk] then
        self.mTeamHand[pk]:updateOnLineState(online)
    elseif self.mHeroHand and (not tolua.isnull(self.mHeroHand)) and self.mHeroHand:getTag() == pk then
        self.mHeroHand:updateOnLineState(online)
    end
end

--刷新武器图标
function HeroHandLayer:updateEquipIcon(data)
    local roleData = RoleDataManager:getRoleDataBySpriteID(data.spriteID);
    if roleData then
        if roleData:getType() == RoleType.Hero then
            local _pk = roleData:getPK()
            -- print("HeroHandLayer:updateEquipIcon",spriteID)

            if data and self.mTeamHand[_pk] then
                self.mTeamHand[_pk]:updateEquipIcon()
            elseif self.mHeroHand and (not tolua.isnull(self.mHeroHand)) and self.mHeroHand:getTag() == _pk then
                self.mHeroHand:updateEquipIcon()
            end
        end
    end
end


-- 模版函数：更新组建的视图(必备)
function HeroHandLayer:onUpdateView()

end

-- --显示
-- function HeroHandLayer:showHeroHandLayer(time)
--     self.rootLayer:stopAllActions()
--     self.rootLayer:setPosition(-400, 0)
--     self.rootLayer:runAction(cc.MoveTo:create(time,cc.p(Avalon.issUtil:getLeftMargin(),0)))
-- end

-- --隐藏
-- function HeroHandLayer:hideHeroHandLayer(time)
--     self.rootLayer:stopAllActions()
--     self.rootLayer:runAction(cc.MoveTo:create(time,cc.p(-400,0)))
-- end

--创建headTips
function HeroHandLayer:addHeadTips(pk,data)
    if self.mTeamHand[pk] then
        local pHeadTips = UI.HeadTips:create(UIType.TEAMMATESTATUS)
        local _x,_y = self.mTeamHand[pk]:getPos()
        pHeadTips:setPos(_x + 115,_y + -210)
        pHeadTips:init(data)
        self:addChild(pHeadTips,99)

    elseif self.mHeroHand and (not tolua.isnull(self.mHeroHand)) and self.mHeroHand:getTag() == pk then
        local pHeadTips = UI.HeadTips:create(UIType.HEROSTATUS)
        local _x,_y = self.mHeroHand:getPos()
        pHeadTips:setPos(_x + 115,_y + -210)
        pHeadTips:init(data)
        self:addChild(pHeadTips,99)
    end
end

--显示复活按钮
function HeroHandLayer:showResurgenceState(PK, rType)
    if rType == RoleType.Pet then
        -- if self.mPetHand and (not tolua.isnull(self.mPetHand)) then
        --     self.mPetHand:showResurgence()
        -- end
        if self.mPetHandList and next(self.mPetHandList) then
            for k, hand in pairs(self.mPetHandList) do
                if hand:getPK() == PK then
                    self.mPetHandList[k]:showResurgence()
                end
            end
        end
    else
        if self.mTeamHand[PK] then
            self.mTeamHand[PK]:showResurgence()
        end
    end
end

--隐藏复活按钮
function HeroHandLayer:hideResurgenceState(roleData)
    if roleData and self.mTeamHand[roleData:getPK()] then
        self.mTeamHand[roleData:getPK()]:onResurgenceCallBack()
    elseif self.mHeroHand and (not tolua.isnull(self.mHeroHand)) and self.mHeroHand:getTag() == roleData:getPK() then
        self.mHeroHand:onResurgenceCallBack()
    end
    local pets = RoleDataManager:getScreenFightPetData()
    -- local pets = MasterDataManager:getFightPet()
    -- if pet and roleData:getSpriteID() == pet:getSpriteID() and self.mPetHand and (not tolua.isnull(self.mPetHand)) then
    --     self.mPetHand:onResurgenceCallBack()
    -- end
    for k, pet in pairs(pets) do
        if pet and roleData:getSpriteID() == pet:getSpriteID() and self.mPetHandList and next(self.mPetHandList) and self.mPetHandList[pet:getSiteId()] and pet:getSiteId() == roleData:getSiteId() then
            self.mPetHandList[pet:getSiteId()]:onResurgenceCallBack()
        end
    end
end

--匹配相应
function HeroHandLayer:responseMatch()
    self:addTeamHandByReadyTeam()
end

--取消匹配相应
function HeroHandLayer:responseCancelMatch()
    -- print("HeroHandLayer:responseCancelMatch")
    if self.mNullTeamHand then
        self.mNullTeamHand:cancelMatch()
    end
end

--取消匹配
function HeroHandLayer:cancelMatch(data)
    for k,v in pairs(self.mWaitJoinTeamHand) do
        v:removeFromParent()
    end

    self.mWaitJoinTeamHand = {}
    self:addTeamHand(nil)
end

function HeroHandLayer:notifySearchMatch()

    if self.mNullTeamHand then
        self.mNullTeamHand:notifySearchMatch()
    end
end

--刷新血量显示规则
function HeroHandLayer:refreshRoleInfoShowType()
    -- print("HeroHandLayer:refreshRoleInfoShowType")
    if self.mHeroHand and (not tolua.isnull(self.mHeroHand)) then
        self.mHeroHand:refreshRoleInfoShowType()
    end
    -- if self.mPetHand and (not tolua.isnull(self.mPetHand)) then
    --     self.mPetHand:refreshRoleInfoShowType()
    -- end
    if self.mPetHandList and next(self.mPetHandList) then
        for _, v in pairs(self.mPetHandList) do
            v:refreshRoleInfoShowType()
        end
    end
    for k,v in pairs(self.mTeamHand) do
        v:refreshRoleInfoShowType()
    end 
end

function HeroHandLayer:onAddHero(roleData)
    if roleData and self.mTeamHand[roleData:getPK()] and roleData:getIsDead() and roleData:getState() ~= FSMState.BATTLE then
        self.mTeamHand[roleData:getPK()]:showResurgence()
    end
end

function HeroHandLayer:onRemoveHero(roleData)
    if roleData and self.mTeamHand[roleData:getPK()] then
        self.mTeamHand[roleData:getPK()]:onResurgenceCallBack()
    end
end

function HeroHandLayer:onCurrencyChangeHandler()
    -- body
    for k, heroPanel in pairs(self.mTeamHand) do 
        heroPanel:refreshResurgence()
    end
end

function HeroHandLayer:showQuickChatTips(pk, text)
    if self.mHeroHand and self.mHeroHand:getTag() == pk then
        self.mHeroHand:showQuickChatTips(text)
    elseif self.mTeamHand[pk] then
        self.mTeamHand[pk]:showQuickChatTips(text) 
    end
end

function HeroHandLayer:refreshRescureCount(pk, count)
    if self.mHeroHand and self.mHeroHand:getTag() == pk then
        self.mHeroHand:refreshRescure(count)
    end

    if self.mTeamHand[pk] then
        self.mTeamHand[pk]:refreshRescure(count)
    end
end

function HeroHandLayer:refreshActivity()
    if self.mHeroHand and (not tolua.isnull(self.mHeroHand)) then
        self.mHeroHand:refreshResurgence()
    end

    for id, comp in pairs(self.mTeamHand) do
        if comp ~= nil and (not tolua.isnull(comp))  then
            comp:refreshResurgence()
        end
    end
end

function HeroHandLayer:refreshPetInfo(pet)
    -- if self.mPetHand and (not tolua.isnull(self.mPetHand)) then
    --     self.mPetHand:refreshPetInfo(pet)
    -- end
    if self.mPetHandList and next(self.mPetHandList) then
        -- self.mPetHand:refreshPetInfo(pet)
        for k, v in pairs(self.mPetHandList) do
            if v:getData():getSiteId() == pet:getSiteId() then
                self.mPetHandList[k]:refreshPetInfo(pet)
            end
        end
    end
end

-- 注册监听事件(可选)
function HeroHandLayer:registerListener()
    -- 怪物攻击目标
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_MONSTER_ATTACK, self, self.updateMonsterTargetEffect)

    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:bind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateHeroDataHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)

    -- 添加buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.onAddRoleBuffHandler)
    -- 更新buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.onUpdateRoleBuffHandler)
    -- 移除buff
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.onRemoveRoleBuffHandler)

    -- -- 添加一个队友
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ADD_TEAMMETA, self, self.addTeamHand)
    -- -- 移除一个队友
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REMOVE_TEAMMETA, self, self.removeTeamHand)
    --更改队伍在线状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_UPDATE_ONLINE, self, self.updateOnLineState)
    --有人加入队伍
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_JOIN, self, self.addHandPanel)

    Avalon.MessageCenter:bind(AvalonMessage.MC_COMMON_SHOW_PET, self, self.addPetHand)
    --有人退出队伍
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_LEAVE, self, self.removeTeamHand)

    --显示
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_MAINLAYER, self, self.showHeroHandLayer)
    --隐藏
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_MAINLAYER, self, self.hideHeroHandLayer)
    --切换装备
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, self.updateEquipIcon)

    --技能选择对象
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SHOW_SKILL_TARGE, self, self.showSkillSelect)
    --指向性技能中断或者取消
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_CANCEL_SKILL, self, self.hideSkillSelect)
    --复活
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SHOW_HELP_REVIVE, self, self.showResurgenceState)
    --取消复活
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.hideResurgenceState)
    --复活完成
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_END, self, self.hideResurgenceState)
    --匹配相应
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_RESPONSE_MATCH, self, self.responseMatch)
        --取消匹配相应
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.responseCancelMatch)
    --倒计时结算取消匹配
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self.cancelMatch)

    --开始匹配通知
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_SEARCH_MATCH, self, self.notifySearchMatch)

    --血量显示类型
    Avalon.MessageCenter:bind(AvalonMessage.MC_SETTING_BLOOD_SHOW_TYPE, self, self.refreshRoleInfoShowType)

    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ADD_HERO, self, self.onAddHero)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REMOVE_HERO, self, self.onRemoveHero)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_QUICK_CHAT_TIPS, self, self.showQuickChatTips)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ROLE_DUNGEON_SURVIVOR, self, self.refreshRescureCount)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshActivity)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SIDEBAR_SHOW_HEAD_TIPS, self, self.addHeadTips)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, self, self.refreshPetInfo)
end


-- 注销监听事件(可选)
function HeroHandLayer:unRegisterListener()
    -- 怪物攻击目标
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_MONSTER_ATTACK, self, self.updateMonsterTargetEffect)

    -- 英雄主角信息 显示英雄自己
    Avalon.MessageCenter:unbind(AvalonMessage.MC_COMMON_SHOW_MASTER, self, self.onUpdateHeroDataHandler)
    -- 角色信息更新，其他的英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_INIT_HERO_DATA, self, self.onUpdateHeroDataHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_UPDATE_HERO_DATA, self, self.onUpdateHeroDataHandler)
    -- 角色状态更新 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)

    -- 添加buff操作，添加更新移除
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ADD_BUFFER, self, self.onAddRoleBuffHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_UPDATE_BUFFER, self, self.onUpdateRoleBuffHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REMOVE_BUFFER, self, self.onRemoveRoleBuffHandler)

    -- -- 添加一个队友
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ADD_TEAMMETA, self, self.addTeamHand)
    -- -- 移除一个队友
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REMOVE_TEAMMETA, self, self.removeTeamHand)
    --更改队伍在线状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_UPDATE_ONLINE, self, self.updateOnLineState)

    --有人加入队伍
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_JOIN, self, self.addHandPanel)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_COMMON_SHOW_PET, self, self.addPetHand)
    --有人退出队伍
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_LEAVE, self, self.removeTeamHand)

    --显示
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_MAINLAYER, self, self.showHeroHandLayer)
    --隐藏
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_MAINLAYER, self, self.hideHeroHandLayer)
    --切换装备
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, self.updateEquipIcon)

    --技能选择对象
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SHOW_SKILL_TARGE, self, self.showSkillSelect)
    --指向性技能中断或者取消
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_CANCEL_SKILL, self, self.hideSkillSelect)
    --复活
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SHOW_HELP_REVIVE, self, self.showResurgenceState)
    --取消复活
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.hideResurgenceState)
    --复活完成
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_END, self, self.hideResurgenceState)
    --匹配相应
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_RESPONSE_MATCH, self, self.responseMatch)
    --取消匹配相应
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.responseCancelMatch)

        --倒计时结算取消匹配
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_COUNTDOWN_CANCEL_MATCH, self, self.cancelMatch)
        --开始匹配通知
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_SEARCH_MATCH, self, self.notifySearchMatch)

        --血量显示类型
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SETTING_BLOOD_SHOW_TYPE, self, self.refreshRoleInfoShowType)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ADD_HERO, self, self.onAddHero)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REMOVE_HERO, self, self.onRemoveHero)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_QUICK_CHAT_TIPS, self, self.showQuickChatTips)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ROLE_DUNGEON_SURVIVOR, self, self.refreshRescureCount)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshActivity)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SIDEBAR_SHOW_HEAD_TIPS, self, self.addHeadTips)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PET_REFRESH_HEAD_INFO, self, self.refreshPetInfo)
end



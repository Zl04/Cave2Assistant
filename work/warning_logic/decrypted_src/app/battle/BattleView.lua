--[[
    战斗视图：战斗中所有对象在场景上的显示
]]

local winSize = cc.Director:getInstance():getWinSize()

local MapLayer = require "app.mapkit.layers.MapLayer"
local lume = require "thirdparty.lume"
local MapHelper = require "app.mapkit.MapHelper"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local MapDefine = require "app.mapkit.MapDefine"
local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local MachineManager = require("app.game.MachineManager")
require "app.renderer.component.ClickFloorEffectComponent"
require "app.renderer.component.HighlightMapGridComponent"
require "app.renderer.component.WallBreakComponent"

local TRANS_DOOR_TYPE = PublicDefine.TRANS_DOOR_TYPE

Battle = Battle or {}
local BattleView = class("BattleView", Machine.ShareView)
Battle.NewBattleView = BattleView

-- private:
local DEBUG = false
local DEBUG_TOUCH = false
local DEBUG_POSITION = false

-- 显示视图的z序偏移量
local OBJECT_ZORDER_OFFSET = 5
local CLICK_FX_ZORDER_OFFSET = 10000

-- 战斗场景层级
local BATTLE_LAYER_BACKGROUND = 0
local BATTLE_LAYER_ZORDER_MAP = 1
local BATTLE_LAYER_ZORDER_TOUCH = 2
local BATTLE_LAYER_BACKGROUND_UP = 100

-- public:
-- 构造函数
function BattleView:ctor()
    BattleView.super.ctor(self)
    self._mechanismChamberModelId = nil
    self._chamberEntranceModelId = nil
    self.mazeFlagArr = {}
end

-- 销毁
function BattleView:destroy()
    self:clear()
    self._mechanismChamberModelId = nil
    self._chamberEntranceModelId = nil
    self.mazeFlagArr = {}
end

-- 初始化
function BattleView:init(model, viewNode)
    BattleView.super.init(self, model, viewNode)
    self._mechanismChamberModelId = nil
    self._chamberEntranceModelId = nil
end

-- 清理
function BattleView:clear()
    BattleView.super.clear(self)
    self._mechanismChamberModelId = nil
    self._chamberEntranceModelId = nil
end

-- 震动效果
function BattleView:shack(shackType,time)
    if (self._mapNode) then
        self._mapNode:shack(shackType, time)
    end
end

-- 创建视图节点
function BattleView:createRenderAndAddToMap(model)
    -- print("BattleView:createRenderAndAddToMap",model.__cname)
    local modelCategory = model:getCategory()
    local modelType = model:getType()
    local modelId = model:getId()
    local coord = model:getCoord()

    -- print(string.format("ShareView addView: add view for model, category:%d, type:%d, id:%d.", modelCategory, modelType, modelId))

    local renderer = nil
    local spriteID = 0
    -- 保存是否添加到地图顶层
    local addMapLevel = 0   -- 0 标识普通层 ,1 OnGround, 2 BeyondMap
    -- 是否需要被列入地图的隐藏和显示的管理列表中
    local isManagedByMap = true

    -- 角色类 --
    if (modelCategory == Category.ROLE) then
        spriteID = model:getSpriteID()

        -- 角色－英雄
        if (modelType == RoleType.Hero) then
            local skeletonFile, atlasFile, scale = model:getAnimationData()
            local sex = model:getSex()
            local faceDecodeID = model:getFaceDecodeID()
            local looks = model:getData():getLooks()
            local isHideHelmet = model:getData():getIsHideHelmet()
            local pk = model:getData():getPK()
            if(DEBUG) then 
                print("BattleView:createRenderAndAddToMap",faceDecodeID)
            end

            local isRide = nil
            if model.isRide then
                isRide = model:isRide()
            end

            renderer = Renderer.HeroRenderer:create()
            renderer:init(skeletonFile, atlasFile, scale, sex, model:isMaster(), faceDecodeID, looks, isHideHelmet, true, isRide,pk)
            renderer:setAttrAddNode(self._map)
            renderer:setHeroPK(pk)
            local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(model:getSpriteID())
            if(wearData) then
                renderer:refreshEquip(wearData.wearEquipmentArr)
            end
            if(MasterDataManager:getPreDreamRankDataForPK(pk)) then 
                renderer:showDreamWinding()
            end
            if(self:getIsShowHorcruxScene()) then
                -- 这里是在洞窟里面都不会隐藏宠物
                renderer:showHorcruxExterior(model:getData():getHorcruxExteriorId())
            end
            if SceneManager:getInstance():isInBigCrack() then
                local roomData = mvc.festivalModel:getCurJoinData()
                local members = roomData.members
                if members then
                    for _, member in pairs(members) do
                        if member.pk == pk then
                            renderer:showCamp(member.campID)
                            break
                        end
                    end
                end
            end
            if (model:isMaster()) then
                renderer:updateExpeditionStatus(mvc.expeditionModel:getExpeditionStatus())
                if SceneManager:getInstance():isInHitRat() 
                    or SceneManager:getInstance():isInPuzzle() then
                    model:setDirection(DirectionType.EAST)
                end

                -- local fPetData = RoleDataManager:getMaster():getFightPetData()
                -- local isRiding = MasterDataManager:getPetRidingState()
                -- renderer:setRideType(isRiding)
                -- if fPetData:canRide() then
                --     if isRiding then
                --         renderer:createHeroRidePetRunderer(model)
                --     end
                -- else
                --     renderer:removeHeroRidePetRunderer()
                -- end

            else 
                if SceneManager:getInstance():isInHitRat() then
                    coord = {x = 9,y = 3}
                    mvc.hitRatModel:setTargetHeroData(model:getData())
                end
                renderer:updateExpeditionStatus(model:getData():getExpeditionStatus())
            end

            --初始化骑乘相关
            local fPetData = model:getData():getCaptainPetData()
            if fPetData then
                local isRiding = fPetData:isRide()
                renderer:hidePet(isRiding,nil,fPetData)
                if fPetData:canRide() and fPetData:getSiteId() == 0 then
                    if isRiding then
                        renderer:createHeroRidePetRunderer(model)
                    end
                else
                    renderer:removeHeroRidePetRunderer()
                end
            end
            


            -- 测试代码 --
            -- 添加显示spriteID的测试
            renderer:addName(spriteID, model:getData().pk)
            ---------------
            if (DEBUG) then
                print(string.format("ShareView addView: add hero view %d.", spriteID))
            end

            -- 移动到屏幕中间
            if (model:isMaster()) then
                self._map:updateMapTileAround(coord.x, coord.y)
                self:setNewCenterCoordinate(coord, coord, coord)

                if (DEBUG) then
                    print(string.format("ShareView addView: move map to coord (%f,%f).", coord.x, coord.y))
                end
                self:updateAllMonsterNameVisibility(model)
                self:updateAllMonsterNameColor(model)
            end
            if (SceneManager:getInstance():isInPetPVP()) then
                if model:getRoleData():getIsEnemy() then
                    model:setDirection(DirectionType.WEAST)
                    renderer:setDirection(DirectionType.WEAST)
                else
                    model:setDirection(DirectionType.EAST)
                    renderer:setDirection(DirectionType.EAST)
                end                
                local zOrder = self._map:getZOrderByCoordinate(coord.x, coord.y)
                renderer:setZOrder(zOrder + OBJECT_ZORDER_OFFSET)
            end
        -- 角色－怪物
          -- 宠物
        elseif (modelType == RoleType.Pet) then
            local skeletonFile, atlasFile, scale, sceneScale = model:getAnimationData()
            local params = {
                coordX = coord.x,
                coordY = coord.y
            }
            renderer = Renderer.PetRenderer:create()
            renderer:init(skeletonFile, atlasFile, scale, params)
            renderer:setAttrAddNode(self._map)
            renderer:addName(spriteID)
            renderer:setAnimationScale(sceneScale)


            if (SceneManager:getInstance():isInPetPVP()) then
                renderer:showMiniBloodView(model:getRoleData():getCurHp(), model:getRoleData():getHp(), model:getRoleData():getIsEnemy())
                if model:getRoleData():getIsEnemy() then
                    renderer:setDirection(DirectionType.WEAST)
                else
                    renderer:setDirection(DirectionType.EAST)
                end
                local zOrder = self._map:getZOrderByCoordinate(coord.x, coord.y)
                renderer:setZOrder(zOrder + OBJECT_ZORDER_OFFSET)
            else

                -- local fPetData = RoleDataManager:getMaster():getFightPetData()
                -- local MachineManager = require("app.game.MachineManager")
                -- local model = MachineManager:getInstance():getMachine():getModel()
                -- local petRole = model:getRoleBySpriteID(fPetData:getId())
                -- local petModelId = petRole:getId()
                -- print("modelId ==123123==== ",modelId,petModelId)
                -- if modelId == petModelId then
                --     if fPetData:canRide() then
                --         renderer:setRideType(MasterDataManager:getPetRidingState())
                --     else
                --         renderer:setRideType(false)
                --     end
                -- end

                local petData = model:getRoleData()
                if petData then
                    local heroSpId = petData:getMasterSpriteID()
                    local heroData = RoleDataManager:getHeroDataForSpriteID(heroSpId)
                    if petData:isRide() and petData:canRide() then
                        renderer:hidePet(true,nil,petData)
                    else
                        renderer:hidePet(false,nil,petData)
                    end
                    petData:setLooks(heroData:getLooks())

                    local transData = petData
                    transData.petSpriteId = petData.spriteID
                    transData.heroSpriteId = petData.masterSpriteID
                    transData.isRiding = petData:isRide()
                    RoleDataManager:handlePetRidingState(transData)

                    -- --判断是否是狐仙变身,如果是,则显示变身效果
                    -- if petData.isTransform and petData.templateID == 1032 then
                    --     renderer:createFoxSpiritTransformHero(petData)
                    -- end
                end

            end
        elseif (modelType == RoleType.Monster) then
            local skeletonFile, atlasFile, scale, transSkeletonFile, transAtlasFile, transScale
            if model:getIsTransform() then
                local isChange, param1, param2, param3 = model:getData():refreshTransformData()
                if isChange then
                    skeletonFile, atlasFile, scale = param1, param2, param3
                    transSkeletonFile, transAtlasFile, transScale =  model:getAnimationData()
                else
                    skeletonFile, atlasFile, scale = model:getAnimationData()
                    transSkeletonFile, transAtlasFile, transScale = model:getData():getTransformAnimation()
                end
            else
                skeletonFile, atlasFile, scale = model:getAnimationData()
                transSkeletonFile, transAtlasFile, transScale = model:getData():getTransformAnimation()
            end
            local params = {
                decorationId = model:getDecorationId(),
                toRemoveDecoration = model:isToRemoveDecoration(),
                toRemoveSelf = model:isToRemoveSelf(),
                rare = model:getRare(),
                monsterType = model:getMonsterType(),
                monsterSubType = model:getMonsterSubType(),
                isTrigger = model:getIsTrigger(),
                isTransform = model:getIsTransform(),
                isTurnAround = model:isTurnAround(),
                isWaked = model:getIsWake(),
                coordX = coord.x,
                coordY = coord.y,
                name = model:getData():getName(),
                transSkeletonFile = transSkeletonFile,
                transAtlasFile = transAtlasFile,
                transScale = transScale,
                monsterData = model:getData()
            }

            if(model:isBigBoss()) then
                params.labelPos = self:_getMonsterLabelLocation(skeletonFile)
                
                -- 判断是否完成第三种boss
                if(SceneManager:getInstance():isGhostAbyss()) then
                    renderer = Renderer.BossNewsRenderer:create()
                else
                    renderer = Renderer.BossRenderer:create()
                end

                if model:getIsTransform() and transSkeletonFile then
                    renderer:init(transSkeletonFile, transAtlasFile, transScale, params)
                else
                    renderer:init(skeletonFile, atlasFile, scale, params)
                end
            else
                renderer = Renderer.MonsterRenderer:create()
                if model:getIsTransform() and transSkeletonFile then
                    renderer:init(transSkeletonFile, transAtlasFile, transScale, params)
                else
                    renderer:init(skeletonFile, atlasFile, scale, params)
                end
            end
            renderer:setAttrAddNode(self._map)

            local view = renderer:getView()
            if(view and model:isBigBoss() and self._map) then
                -- CO-6178【新春副本】部分站位boss不可见
                if(SceneManager:getInstance():isActivityCave()) then
                    self._map:setPermanentVisible(coord.x, coord.y, view)
                end
            end
            
            -- 刷新装饰物表现
            if(model:getDecorationId() ~= 0) then
                local tileData = self._mapData:getTileDataAtCoord(coord.x, coord.y)
                if tileData then
                    self._map:updateTile(tileData)
                end
            end

            -- 测试代码 --
            -- TODO 添加显示spriteID的测试
            renderer:addName(spriteID, model)
            ----------------
            -- print(string.format("ShareView addView: add monster view %d.", spriteID))
            self:updateOneMonsterNameVisibility(model, renderer)
            self:updateOneMonsterNameColor(model:getData(), renderer)

            --boss 锁定状态check
            self:updateOneMonsterSealInfo(model:getData(), renderer)
        else
            assert(false, string.format("[ERROR] ShareView addView: model category %d and type %d are invalid.", modelCategory, modelType))
        end

        local view = renderer:getView()
        self:addViewToMap(model, view, coord.x, coord.y)
        self._map:setMapObject(coord.x, coord.y, view)
    --------------------------------------------------------------  
    -- 触发器npc 
    elseif ((modelCategory == Category.TRIGGER_NPC)) then
        -- 触发器npc-剧情
        if(modelType == PublicDefine.TRIGGER_NPC_TYPE.BOSS_SCENARIO_TRIGGER) then
            -- boss 剧情触发器不用renderer
        -- 触发器npc-其他
        else
            -- function npc
            if (modelType == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
                if(MasterDataManager:getDreamRankTopHeroData() and model:getNpcData() and model:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.FUNCITON_TYPE_DREAM_TASK)) then
                    local detailHero = MasterDataManager:getDreamRankTopHeroData()

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
                    if(DEBUG) then 
                        print("BattleView:createRenderAndAddToMap",faceDecodeID)
                    end
                    renderer = Renderer.HeroRenderer:create()
                    renderer:init(skeletonFile, atlasFile, scale, sex, isMaster, faceDecodeID, looks, isHideHelmet, true)

                    local rankData = MasterDataManager:getPreDreamRankDataForPK(heroData:getPK())
                    local guildName = ""
                    if(rankData) then 
                        guildName = rankData.guildName
                    end
                    renderer:showDreamStyleName(heroData:getNickName(), guildName)
                    if(self:getIsShowHorcruxScene()) then
                        renderer:showHorcruxExterior(heroData:getHorcruxExteriorId())
                    end

                    -- 刷新装备
                    renderer:refreshEquip(equpmentArr)

                    local view = renderer:getView()
                    self:addViewToMap(model, view, coord.x, coord.y)
                    self._map:setMapObject(coord.x, coord.y, view)

                    -- 处理地底的光亮
                    self:showFunctionLight(model, renderer, model:getNpcData().occupySize)
                else
                    -- 这里洞内用的小的图标
                    local roleSpriteName,iconName = UI.MapGrid:getIconName(model:getData(), false)
                    local nameID = model:getData().name
                    local functionnameID = model:getData().functionname
                    local functionName = nil
                    local nickName = nil
                    local LanguageManager = require("app.game.LanguageManager")
                    if(nameID and nameID ~= 0) then 
                        nickName = LanguageManager:getInstance():getLocalString(nameID)
                    end
                    if(functionnameID and functionnameID ~= 0) then 
                        functionName = LanguageManager:getInstance():getLocalString(functionnameID)
                    end
                    local informationHeight = model:getInformationLocation()[2]

                    local skeleton, atlas, scale = model:getAnimationData()
                    renderer = Renderer.FunctionNPCRenderer:create()
                    renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock(), iconName, functionName, nickName, informationHeight, model:getData().staticOffset)
                    renderer:setInitMapCoordOnAnimation({x = coord.x, y = coord.y}) -- 为poco设置一个npc动画坐标标签
                    
                    local view = renderer:getView()
                    self:addViewToMap(model, view, coord.x, coord.y)
                    self._map:setMapObject(coord.x, coord.y, view)

                    -- 处理地底的光亮
                    self:showFunctionLight(model, renderer, model:getNpcData().occupySize)
                end
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.DISAPPEAR_OBSTACLE) then
                local skeleton, atlas, scale = model:getAnimationData()
                renderer = Renderer.TriggerNPCRenderer:create()
                renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y, nil)
                self._map:setMapObject(coord.x, coord.y, view)

                -- 处理地底的光亮
                self:showFunctionLight(model, renderer, model:getNpcData().occupySize)
            -- 陷阱
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.TRAP) then
                local trapData = model:getNpcData()

                local trapConfig = {
                    trapID = trapData:getId(),
                    skeleton = trapData.skeleton,
                    atlas = trapData.atlas,
                    size = trapData.trapSize,
                    -- size = {3,3},
                    effectSize = trapData.effectRange,
                    idleCount = trapData.idleAnimateNum,
                    triggerCount =  trapData.triggerAnimateNum,
                    effectCount = trapData.triggerEffectAnimateNum,
                    isDown = trapData.beforeTriggerHierarchy == 0 or false,
                    effectIsDown = trapData.afterTriggerHierarchy == 0 or false,
                    doEffectTiming = trapData.doEffectTiming,
                    hitFeedBack = trapData:getHitFeedBack(),
                    hitShake = trapData:getHitShake(),
                    hitFreeze = trapData:getHitFreeze()
                }
                renderer = Renderer.TrapNPCRenderer:create()
                renderer:init(trapConfig)

                -- TODO 临时写法，用于处理切换场景报错问题
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y)
                self._map:setMapObject(coord.x, coord.y, view)

                self:addTrapView(model, renderer, trapData.trapSize)
            -- 陷阱
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.COLLECT) then
                local collectData = model:getNpcData()

                -- local skeleton, atlas, scale = model:getAnimationData()
                -- renderer = Renderer.TriggerNPCRenderer:create()
                -- renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                
                local skeleton= collectData.skeleton
                local  atlas = collectData.atlas
                local  scale = collectData.scale
                -- local collectConfig = {
                --     pgsImg = "ui_btn_advertisement2_1.png",
                -- }
                renderer = Renderer.CollectRender:create()
                renderer:init(skeleton, atlas, scale)

                -- TODO 临时写法，用于处理切换场景报错问题
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y)
                self._map:setMapObject(coord.x, coord.y, view)

            -- boss大门
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.BOSS_FLOOR_GATE) then
                local npcData = model:getNpcData()
                local npcConfig = {
                    spine = npcData.spine
                }
                renderer = Renderer.GateNPCRenderer:create()
                renderer:init(npcConfig, scale, model:getType(), model:getIsLock())

                local viewList = renderer:getViewList()
                local leftGateAnimation, rightGateAnimation = viewList[1], viewList[2]
                local direction = renderer:getDirection()
                local coordX, coordY = coord.x, coord.y
                local zOrderOffsetLeft, zOrderOffsetRight = 2, -1

                self:addViewToMap(model, leftGateAnimation, coordX, coordY, nil, zOrderOffsetLeft)
                self._map:setMapObject(coordX, coordY, leftGateAnimation)
                -- print("BattleView  occupySize pre ", coordX, coordY)
                local occupySize = npcData:getOccupySize()
                -- print("BattleView  occupySize 1,2=", occupySize[1], occupySize[2])

                if (direction == DirectionType.WEAST or
                    direction == DirectionType.EAST) then
                    coordY = coordY + occupySize[2] - 1
                elseif (direction == DirectionType.SOUTH or
                        direction == DirectionType.NORTH) then
                    coordX = coordX + occupySize[1] - 1
                end
                -- print("BattleView  occupySize end ", coordX, coordY)
                self:addViewToMap(model, rightGateAnimation, coordX, coordY, nil, zOrderOffsetRight)
                self._map:setMapObject(coordX, coordY, rightGateAnimation)
            
            -- 密室触发器
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_TRIGGER or modelType == PublicDefine.TRIGGER_NPC_TYPE.DUNGEON_ROOM_TRIGGER) then
                local skeleton, atlas, scale = model:getAnimationData()
                renderer = Renderer.TriggerNPCRenderer:create()
                renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y, nil, -4999)
                self._map:setMapObject(coord.x, coord.y, view)

            -- 传送门
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
                local skeleton, atlas, scale = model:getAnimationData()
                if(model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.CAVE_TO_TOWN 
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.ROOM_TO_ROOM
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.GUILD_TO_TOWN 
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_GUILD
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_MANOR
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.MANOR_TO_TOWN
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.BLACK_HOUSE_TO_TOWN
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.TOWNCAVE_TO_TOWN
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_TOWNCAVE) then
                    renderer = Renderer.TransDoorNpcRendere:create()
                    skeleton = model:getSpineName()
                    local isLock = model:getIsLock()

                    if model:getNpcData():wasCheckResuce() then 
                        isLock = isLock or not mvc.festivalModel:getWasRescue()
                    end

                    renderer:init(skeleton, atlas, scale, model:getType(), isLock)
                else
                    renderer = Renderer.TriggerNPCRenderer:create()
                    renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                end
                
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y, nil, -4999)
                self._map:setMapObject(coord.x, coord.y, view)
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.PATROL_NPC) then
                local skeleton, atlas, scale = model:getAnimationData()
                renderer = Renderer.PatrolNPCRenderer:create()
                renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y)
                self._map:setMapObject(coord.x, coord.y, view)
                self._map:setPermanentVisible(coord.x, coord.y, view)

            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.NPC_TYPE_ACTOR) then
                local skeleton, atlas, scale = model:getAnimationData()
                renderer = Renderer.ActorNpcRenderer:create()
                renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y)
                self._map:setMapObject(coord.x, coord.y, view)
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT) then
                local skeleton, atlas, scale = model:getAnimationData()
                renderer = Renderer.TransPointNpcRender:create()
                skeleton = model:getSpineName()
                renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                if(model:getData() and model:getData():getTransPointType() == PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_ROLE_END) then 
                    renderer:setVisible(true)
                    renderer:setDefaultVisible(true)
                end

                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y, nil, -4999)
                self._map:setMapObject(coord.x, coord.y, view)
            -- trigger npc
            else
                local skeleton, atlas, scale = model:getAnimationData()
                renderer = Renderer.TriggerNPCRenderer:create()
                renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y, nil)
                self._map:setMapObject(coord.x, coord.y, view)
            end

            -- print("ddddddddddddddddTRIGGER_NPC  modelType=",modelType,PublicDefine.TRIGGER_NPC_TYPE.BOX)
            if modelType == PublicDefine.TRIGGER_NPC_TYPE.BOX or modelType == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC then
                -- print("ddddddddddddddddTRIGGER_NPC or FUNCTION_NPC ")
                self._map:updateMap()
            elseif modelType == PublicDefine.TRIGGER_NPC_TYPE.NORMAL_CHAMBER_ENTRANCE then
                self._chamberEntranceModelId = model:getId()
                self._chamberEntranceCoord = model:getCoord()
            elseif modelType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_ENTRANCE then
                self._mechanismChamberModelId = model:getId()
                self._mechanismChamberEntranceCoord = model:getCoord()
            end
        end
        -- 替换皮肤
        local npcData = model:getNpcData()
        -- 先简单判断如果没有填写或者为 "" 就认为没有
        if npcData then
            local skinName = npcData:getSkinName()
            if skinName and skinName ~= "" then
                print("skinName",skinName)
                if renderer then
                    renderer:setSkin(skinName)
                end
            end
        end
        if (DEBUG) then
            print(string.format("Battle addView: add TRIGGER_NPC view %d.", model:getId()))
        end
    --------------------------------------------------------------
    -- 飞行道具
    elseif ((modelCategory == Category.AIRCRAFT)) then
        -- 飞行道具－子弹
        if (modelType == AircraftType.BULLET) then
            local skeleton, atlas, scale = model:getAnimationData()
            renderer = Renderer.BulletRenderer:create()
            renderer:init(skeleton, atlas, scale)

            local view = renderer:getView()
            self:addViewToMap(model, view, coord.x, coord.y)

            if (DEBUG) then
                print(string.format("ShareView addView: add bullet view %d.", model:getId()))
            end
        -- 飞行道具-获取的物品
        elseif (modelType == AircraftType.GETGOODS) then
            renderer = Renderer.GoodsRenderer:create()
            renderer:init(model:getIconName())

            local view = renderer:getView()
            self:addViewToBeyondMap(model, view, coord.x, coord.y)

            if (DEBUG) then
                print(string.format("ShareView addView: add GETGOODS view %d.", model:getId()))
            end
        else
            assert(false, string.format("[ERROR] ShareView addView: model category %d and type %d are invalid.", modelCategory, modelType))
        end
    else
        assert(false, string.format("[ERROR] ShareView addView: model category %d and type %d are invalid.", modelCategory, modelType))
    end

    if(renderer and coord) then 
        renderer:setCoord(coord.x, coord.y)
    end
    if(model and renderer and renderer.setDirection) then
        renderer:setDirection(model:getDirection())
    end

    return renderer
end

function BattleView:addTrapView(model, renderer, size)
    local coord = model:getCoord()
    -- body
    local trapViewNodeList, isDown = renderer:getViewList()
    if (trapViewNodeList) then
        local zOrderOffset = 0
        -- print("add trapToView isDown=", isDown)
        if (not isDown) then
            zOrderOffset = 9995
        end
        
        -- local size = trapConfig.size
        local startCoordX, startCoordY = coord.x - (size[1] - 1) / 2, coord.y - (size[2] - 1) / 2
        for i = 0, #trapViewNodeList - 1 do
            local coordX = startCoordX + (i % size[1])
            local coordY = startCoordY + (math.floor(i / size[2]))

            local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)
            -- todo add by yys 这里为什么要判断可以行走才创建陷阱呢？如果是这样的话,如果墙上有迷雾或者毒气
            -- 就不会被创建,在墙被挖开之后不会显示出来
            -- if (mapTileData and mapTileData:isReachable() and self._mapData:isCoordInChamber(mapTileData.x, mapTileData.y) == false and not mapTileData:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR)) then
            if (mapTileData and mapTileData:isReachable() and not mapTileData:hasNPCType(PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR)) then
                local trapViewNode = trapViewNodeList[i + 1]
                if(not trapViewNode:getParent()) then
                    if (isDown) then
                        zOrderOffset = 0
                        -- 这里为了处理相关的逻辑
                        zOrderOffset = 99999

                        self:addViewToOnGroundMap(model, trapViewNode, coordX, coordY, nil, zOrderOffset)
                    else
                        self:addViewToMap(model, trapViewNode, coordX, coordY, nil, zOrderOffset)
                    end
                    self._map:setMapObject(coordX, coordY, trapViewNode)
                end
            end
        end
    end
end

function BattleView:removeView(model, cleanView)
    local modelId = model:getId()
    if(modelId == self._chamberEntranceModelId) then
        self._chamberEntranceModelId = nil
    end
    if(modelId == self._mechanismChamberModelId) then
        self._mechanismChamberModelId = nil
    end

    BattleView.super.removeView(self,model,cleanView)
end

function BattleView:setNewCenterCoordinate(startCoord,endCoord,nowCoord)
    BattleView.super.setNewCenterCoordinate(self, startCoord, endCoord, nowCoord)
    self:triggerEntrance(startCoord.x,startCoord.y)
end

--[[
    移动点击
    coord:
    moveType: 1 可以走动  2 不能走动，不是墙 3，4，5，6 墙的周围不同状态
    viewVisible: false 不可见  true 可见
]]
function BattleView:moveClick(coordX, coordY, moveType, viewVisible)
    -- 初始化点击特效
    if (not self._initClickEffect and self._map) then
        self._map:addNodeOnGround(self._clickFloorEffect)
        self._map:addNodeBeyondMap(self._clickFloorInvisbleEffect)
        self._map:addNodeOnMap(self._clickFloorVisbleEffect)

        self._initClickEffect = true
    end

    self._clickFloorEffect:removeEffect()
    self._clickFloorInvisbleEffect:removeEffect()
    self._clickFloorVisbleEffect:removeEffect()

    local choiceClickFloorEffect = nil
    local zOrderOffset = 0
    if viewVisible then
        if moveType >= 3 then
            choiceClickFloorEffect = self._clickFloorVisbleEffect
            zOrderOffset = CLICK_FX_ZORDER_OFFSET
        else
            choiceClickFloorEffect = self._clickFloorEffect
            zOrderOffset = 99999999
        end
    else
        choiceClickFloorEffect = self._clickFloorInvisbleEffect
    end
    if moveType == 1 then
        choiceClickFloorEffect:showHitEffect(viewVisible)
    elseif moveType == 2 then
        choiceClickFloorEffect:showInvalidEffect(viewVisible)
    elseif moveType == 3 then
        choiceClickFloorEffect:showInvalidEffect(false)
    elseif moveType == 4 then
        choiceClickFloorEffect:showClickWallLeftRightRoad()
    elseif moveType == 5 then
        choiceClickFloorEffect:showClickWallLeftRoad()
    elseif moveType == 6 then
        choiceClickFloorEffect:showClickWallRightRoad()
    else
        assert(false, string.format("[ERROR] BattleView moveClick: move type %d is invalid.", moveType))
    end

    -- 计算点击特效的显示位置和z序
    -- local coordX, coordY = coord.x, coord.y
    local coordZ = self:getMapTileCoordZ(coordX, coordY)
    local posX, posY = self:getMapTilePosition(coordX, coordY, coordZ)
    choiceClickFloorEffect:setPosition(posX, posY)
    local zOrder = 0
    if viewVisible == true then
        zOrder = self:getMapTileZOrder(coordX, coordY) + zOrderOffset
        choiceClickFloorEffect:setLocalZOrder(zOrder)
    end

    -- 当前使用的地面点击特效
    self._choiceClickFloorEffect = choiceClickFloorEffect

    if (DEBUG) then
        print(string.format("BattleView moveClick: coord:(%f,%f,%f) zOrder:%d viewVisible:%s moveType:%d", coordX, coordY, coordZ, zOrder, viewVisible, moveType))
    end
end

-- 移动点击效果运行
function BattleView:moveClickShow()
    if self._choiceClickFloorEffect then
        self._choiceClickFloorEffect:runEffect()
    end
end

-- 移除移动点击效果
function BattleView:moveClickRemove()
    if self._choiceClickFloorEffect then
        self._choiceClickFloorEffect:removeEffect()
    end
end

-- 执行command
function BattleView:executeCommand(command)
    local commandCategory = command.category
    local commandType = command.type

    if (commandCategory == CommandCategory.RENDERER) then
        local renderer = nil
        local model = self._model:getModelByModelID(command.modelID)  
        if (command.modelID) then
            renderer = self:getRenderer(command.modelID)
        end

        -- 更新坐标
        if (commandType == CommandType.RENDERER_POSITION) then
            if (renderer) then
                local coordX, coordY, coordZ = command.coordX, command.coordY, command.coordZ
                local oldX,oldY = renderer:getPosition()
                local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
                local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
                local isMoveOneTileOrMore = false

                renderer:setPosition(sx, sy + sz)
                local offsetZ = OBJECT_ZORDER_OFFSET
                if(model and model:getCategory() == Category.ROLE 
                    and model:getType() == RoleType.Hero 
                    and model:isMaster()) then 
                    offsetZ = offsetZ + 1
                    local offsetCoord = {x=0, y=0}
                    if(SceneManager:getInstance():isInLostRealm()) then
                        offsetCoord = GameManager:getLostRealmOffsetCoord()
                        -- print("RENDERER_POSITION offsetCoord=", offsetCoord)
                    end
                    renderer:setPosition(sx + offsetCoord.x, sy + sz+ offsetCoord.y)
                end
                renderer:setZOrder(zOrder + offsetZ)
                
                local rendererCoord = renderer:getCoord()
                if (math.abs(coordX - rendererCoord.x) >= 1 or math.abs(coordY - rendererCoord.y) >= 1) then
                    renderer:setCoord(math.floor(coordX), math.floor(coordY))
                    isMoveOneTileOrMore = true
                    if(renderer and self._map) then 
                        -- 设置显示对象的坐标引用
                        local view = renderer:getView()
                        self._map:setMapObject(math.floor(coordX), math.floor(coordY), view)
                    end
                end

                if (command.moveMap) then
                    if GameManager:getIsCenterByMaster() then
                        self._map:screenCenterToCoord(coordX, coordY)
                    end
                    
                    if (isMoveOneTileOrMore) then
                        self:updateAllMonsterNameVisibility(model)
                    end
                    if (not self._mapMoveDirty) then self._mapMoveDirty = true end
                    self._mapOldX = self._mapX
                    self._mapOldY = self._mapY
                    self._mapX, self._mapY = self._map:getPosition()
                end

                -- if(model and model:isMaster()) then
                --     if (self._backgroundDown) then
                --         -- 处理洞穴氛围效果
                --         local selfOldX ,selfOldY = self._backgroundDown:getPosition()
                --         self._backgroundDown:setPosition(selfOldX - (sx-oldX)*0.7,selfOldY - (sy+sz - oldY)*0.7)
                --     end
                -- end
                
                if DEBUG and DEBUG_POSITION then
                    print(string.format("BattleView executeCommand: update position, coord:(%f,%f), position:(%f,%f), zOrder:%f.", command.coordX, command.coordY, sy, sy, zOrder))
                end
            end
        -- 更新z序
        elseif (commandType == CommandType.RENDERER_ZORDER) then
            if(self._map and renderer) then
                local coordX, coordY, coordZ = command.coordX, command.coordY, command.coordZ
                local offset = command.offset
                local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
                renderer:setZOrder(zOrder + OBJECT_ZORDER_OFFSET + offset)
            end
        -- 转向
        elseif (commandType == CommandType.RENDERER_DIRECTION) then
            -- dump(model)
            if(renderer) then
                renderer:setDirection(command.direction)
            end
        elseif (commandType == CommandType.RENDERER_ROLE_HIT_SHACK) then
            -- print("RENDERER_ROLE_HIT_SHACK  ", renderer)
            if(renderer) then
                renderer:attackShack()
            end
        elseif (commandType == CommandType.RENDERER_NPC_CHANGE_COORD) then
            if(renderer and self._map) then
                local coordX, coordY, coordZ = command.coordX, command.coordY, command.coordZ

                local view = renderer:getView()
                self._map:setMapObject(coordX, coordY, view)
            end
        -- 进入中心点
        elseif (commandType == CommandType.RENDERER_ENTER_CENTER_COORD) then
            local coordX, coordY, coordZ = command.coordX, command.coordY, command.coordZ
            if (model and model:isMaster() and self._map) then
                -- 是否强制同步坐标
                if (command.syncPosition) then
                    self._map:updateMapTileAround(coordX, coordY)
                    self._map:updateTilesVisionAppearanceForCenterCoord(coordX, coordY, 1.0)
                    self._map:hideAllMapTileNotAround(coordX, coordY)
                else
                    self._map:updateMapTileWhenMoving(coordX, coordY)
                end
            end

            -- 触发机关密匙效果
            self:triggerEntrance(coordX,coordY)
            if(renderer and self._map) then 
                -- 设置显示对象的坐标引用
                local view = renderer:getView()
                self._map:setMapObject(coordX, coordY, view)
            end
        -- 播放动画
        elseif (commandType == CommandType.RENDERER_ANIMATION) then
            local animationType = command.animationType
            local timeScale = command.timeScale
            local animationName = command.animationName

            local judgeNeedToTrigger = nil
            local isTrigger = nil
            local isMaster = false
            local isDead = false
            if(model) then 
                if model:getCategory() == Category.ROLE and model:getType() == RoleType.Monster then 
                    local monsterData = model:getRoleData()
                    if(monsterData) then
                        judgeNeedToTrigger = monsterData:judgeNeedToTrigger()
                        isTrigger = monsterData:getIsTrigger()
                    end
                end

                if model:getCategory() == Category.ROLE then
                    isMaster = model:isMaster()
                    isDead = model:getIsDead()
                end
            end

            if(renderer) then
                -- 加速动画
                renderer:speedUp(timeScale)
                -- 播放动画
                -- print("animationType ====== ",animationType)
                if (animationType == AnimationType.IDLE)          then renderer:showIDLE(judgeNeedToTrigger, isTrigger)
                elseif (animationType == AnimationType.SLEEP)          then renderer:showSleep()
                elseif (animationType == AnimationType.APPEAR)          then renderer:showAppear()
                elseif (animationType == AnimationType.MOVE)          then renderer:showMove()
                elseif (animationType == AnimationType.ATTACK)        then renderer:showAttack()
                elseif (animationType == AnimationType.DIE)           then renderer:showDie()
                elseif (animationType == AnimationType.AIRCRAFT_FLY)  then renderer:showFly()
                elseif (animationType == AnimationType.AIRCRAFT_BOOM) then renderer:showBoom()
                -- elseif (animationType == AnimationType.REVIVE)        then renderer:showRevive()
                elseif (animationType == AnimationType.BACK_TOWN)     then renderer:showBackTown(isMaster)
                elseif (animationType == AnimationType.ATTACK_IDLE)   then renderer:showAttackIDLE()
                elseif (animationType == AnimationType.CUSTOM)        then 
                    if (animationName) then 
                        renderer:showAnimation(animationName)
                    end
                else 
                    printError(string.format("[ERROR] BattleView executeCommand: animation type %d is invalid.", animationType))
                end
            end
        elseif (commandType == CommandType.RENDERER_SPINE_TIME_SCALE) then
            if(renderer) then
                -- 加速动画
                renderer:speedUp(command.timeScale)
            end
        -- 显示待机动画
        elseif (commandType == CommandType.RENDERER_IDLE) then
            if(renderer) then
                local judgeNeedToTrigger = nil
                local isTrigger = nil
                if(model) then 
                    if model:getCategory() == Category.ROLE and model:getType() == RoleType.Monster then 
                        local monsterData = model:getRoleData()
                        if(monsterData) then
                            judgeNeedToTrigger = monsterData:judgeNeedToTrigger()
                            isTrigger = monsterData:getIsTrigger()
                        end
                    end
                end

                renderer:showIDLE(judgeNeedToTrigger, isTrigger)
            end 
        -- 处理脸型改变
        elseif (commandType == CommandType.RENDERER_FACE_CHANGE) then
            if(renderer) then
                renderer:refreshFace(command.faceDecodeID)
            end
        -- -- 功能按钮
        -- elseif (commandType == CommandType.RENDERER_FUNCITON_BUTTON) then
            -- if(renderer) then
            --     renderer:showFuntionBtn(command.target, command.data)
            -- end
        -- 修改是否显示头盔
        elseif (commandType == CommandType.RENDERER_ROLE_IS_HIDE_HELMET) then
            if(renderer) then
                renderer:changeIsHideHelmet(command.isHideHelmet)
            end
        -- 绘制角色的属性
        elseif (commandType == CommandType.RENDERER_ATTR) then
            if(renderer) then
                renderer:showAttribute(command.data, command.direction)
            end
        -- 绘制角色普通属性
        elseif (commandType == CommandType.RENDERER_ATTR_COMMON) then
            if(renderer) then
                renderer:handleCommonAttrChanged(command.data)
            end
        -- 显示buff的特效
        elseif (commandType == CommandType.RENDERER_ADD_BUFF) then
            if(renderer) then
                local bufferID = command.bufferID
                local loop = command.loop
                local animationName = command.animationName
                local mountNameList = command.mountNameList
                local mountAnimationPrefixList = command.mountAnimationPrefixList
                renderer:showBuff(bufferID, loop, animationName, mountNameList, mountAnimationPrefixList, command.fxFlip)
            end 
        -- 移除buff的特效
        elseif (commandType == CommandType.RENDERER_REMOVE_BUFF) then
            if(renderer) then
                local bufferID = command.bufferID
                local mountAnimationPrefixList = command.mountAnimationPrefixList
                renderer:hideBuff(bufferID, mountAnimationPrefixList)
            end
        -- 显示技能效果的特效
        elseif (commandType == CommandType.RENDERER_ADD_EFFECT) then
            if(renderer) then
                local effect = command.effect
                renderer:showEffect(effect:getFxAnimName(), effect:getFxMountName(), effect:getFxFlip())
            end
        -- 显示觉得蓄力或者呤唱技能的动画
        elseif (commandType == CommandType.RENDERER_PREPARE_SKILL) then
            if(renderer) then
                local skill = command.skill
                if(skill) then
                    renderer:speedUp(1.0)
                    -- 这里为了兼容处理ready loop 这类的表现需求
                    local prepareAnim = skill:getPrepareAnim()
                    if(prepareAnim) then 
                        local prepareAnimArr = {prepareAnim}
                        if(string.find(prepareAnim, ",")) then
                            prepareAnimArr = string.split(prepareAnim, ",")
                        end

                        renderer:showPrepareSkill(prepareAnimArr)
                    end 
                end
            end
        -- 处理普通攻击逻辑的处理
        elseif (commandType == CommandType.RENDERER_NORMAL_SKILL) then
            if(renderer) then
                local skill = command.skill
                if(skill) then 
                    local animationName, weaponAnimationName = skill:getNormalAnimation()
                    renderer:showNormalSkill(animationName, weaponAnimationName, command.speedUp)
                end
            end
        -- 显示角色释放技能的动画
        elseif (commandType == CommandType.RENDERER_RELEASE_SKILL) then
            local skill = command.skill
            if(renderer and skill) then
                renderer:speedUp(1.0)
                renderer:showReleaseSkill(skill:getReleaseAnim(), skill:getReleaseWeaponAnim())
                Avalon.AudioManager:playSoundByConfig("22",skill:getSkillID(),nil,model and model:getCoord() or nil)
            end
        elseif (commandType == CommandType.RENDERER_RELEASE_ASSIST_SKILL) then
            local skill = command.skill
            if(renderer and skill) then
                renderer:speedUp(1.0)
                renderer:showReleaseAssistSkill(skill:getReleaseAnim(), skill:getReleaseWeaponAnim(), skill:getSkillID())
                Avalon.AudioManager:playSoundByConfig("22",skill:getSkillID(),nil,model and model:getCoord() or nil)
            end
        elseif (commandType == CommandType.RENDERER_ASSIST_SKILL_USE_FAIL) then
            if(renderer) then
                renderer:assistSkillUseFail()
            end
        elseif (commandType == CommandType.RENDERER_ASSIST_SKILL_TRANSFER_END) then
            if(renderer) then
                renderer:assistSkillTranseferEnd()
            end
        elseif (commandType == CommandType.RENDERER_RELEASE_ACT_ANIMATION) then
            --  处理释放技能act 效果
            if(renderer) then
                renderer:showReleaseActAnimation(command.fromSpriteID, command.spineName, command.mountName, command.delayTime, command.timeScale, command.direction, command.isSelf)
            end
        elseif (commandType == CommandType.RENDERER_RELEASE_ACT_ANIMATION_REMOVE) then
            -- 移除 放技能act 效果
            if(renderer and model) then 
                renderer:clearAllReleaseActAnimation(model:getSpriteID(),command.fromSpriteID)
            end
        -- 显示角色完成技能的动画
        elseif (commandType == CommandType.RENDERER_FINISH_SKILL) then
            if(renderer) then
                local skill = command.skill
                renderer:showFinishSkill(skill:getFinishAnim())
            end
        -- 显示蓄力或者呤唱技能的特效
        elseif (commandType == CommandType.RENDERER_PREPARE_SKILL_FX) then
            if(renderer) then
                local skill = command.skill
                local fxAnimName, fxMount = skill:getPrepareFXAnimAndMount()
                renderer:showPrepareSkillFX(fxAnimName, fxMount)
            end
        -- 完成蓄力或者呤唱特效的
        elseif (commandType == CommandType.RENDERER_FINISH_PREPARE_SKILL_FX) then
            if(renderer) then
                renderer:finishPrepareSkillFX()
            end
        -- 显示释放技能的特效
        elseif (commandType == CommandType.RENDERER_RELEASE_SKILL_FX) then
            if(renderer) then
                local skill = command.skill
                local fxAnimName, fxMount = skill:getReleaseFXAnimAndMount()
                renderer:showReleaseSkillFX(fxAnimName, fxMount)
            end
        -- 显示技能被打断的特效
        elseif (commandType == CommandType.RENDERER_BREAK_SKILL_FX) then
            if(renderer) then
                local skill = command.skill
                local fxAnimName, fxMount = skill:getPrepareFXAnimAndMount()
                renderer:showBreakSkillFX(fxAnimName, fxMount)
            end
        --
        elseif (commandType == CommandType.RENDERER_BOSS_SEAL_INFO_UPDATE) then
            if(renderer) then
                if renderer.showBossSealInfoUpdate then
                    renderer:showBossSealInfoUpdate()
                end
            end    
        -- 清理技能特效
        elseif (commandType == CommandType.RENDERER_CLEAR_SKILL_FX) then
            if(renderer) then
                renderer:clearSkillFX()
            end            
        -- 设置飞行道具的状态
        elseif (commandType == CommandType.RENDERER_BULLET_STATE) then
            if(renderer) then
                local fromTarget = self._model:getModelByModelID(command.bulletFromTargetModelID)
                local toTarget = self._model:getModelByModelID(command.bulletToTargetModelID)
                if(toTarget and fromTarget) then
                    local fromMount = command.bulletFromMount
                    local toMount = command.bulletToMount
                    local flyTime = command.bulletFlyTime
                    
                    local fromRenderer = self:getRenderer(fromTarget:getId())
                    local toRenderer = self:getRenderer(toTarget:getId())
                    
                    renderer:setState(fromRenderer, fromMount, toRenderer, toMount, flyTime)
                end
            end
        -- 设置添加物品特效的状态
        elseif (commandType == CommandType.RENDERER_ADD_GOODS_FX) then
            if(DEBUG) then
                print("CommandType.RENDERER_ADD_GOODS_FX  ",command.startCoord.x, command.startCoord.y)
            end

            local sx, sy, sz = self._map:coordinateToPosition(command.startCoord.x, command.startCoord.y, command.startCoord.z)

            local openWithSelf = command.openWithSelf
            local startPosX = sx
            local startPosY = sy
            local toMount = command.toMount
            local fromMonster = command.fromMonster
            
            local toRenderer = self:getRenderer(command.toTargetModelID)
            if (renderer) then
                if(DEBUG) then
                    print("  CommandType.RENDERER_ADD_GOODS_FX   1")
                end 
                renderer:setFlyState(startPosX, startPosY, toRenderer, toMount, fromMonster)
            else
                --assert(false, "RENDERER_ADD_GOODS_FX  Process issues")
                if(model) then
                    if(DEBUG) then
                        print("  CommandType.RENDERER_ADD_GOODS_FX   2")
                    end
                    local renderer = Renderer.GoodsRenderer:create()
                    -- 处理参数传递
                    renderer:init(model:getIconName())
                    
                    local view = renderer:getView()
                    self:addViewToBeyondMap(model, view,command.startCoord.x,command.startCoord.y)
                    self:addDelayRenderer(model, renderer)

                    renderer:setFlyState(openWithSelf,startPosX, startPosY, toRenderer, toMount, fromMonster)
                end
            end
        elseif (commandType == CommandType.RENDERER_ROLE_DEAD) then
            if (renderer) then
                -- 由于梦境和深渊一样，死亡后直接复活
                local isDungeon = SceneManager:getInstance():isInDungeon() 
                    or SceneManager:getInstance():isInDream() 
                    or SceneManager:getInstance():isGuildBoss() 
                    or SceneManager:getInstance():isGhostAbyss()
                local reviveCallback = function()
                    -- 停止死亡到底倒计时
                    if(isDungeon) then
                        -- 修改为指令处理
                        MachineManager:getInstance():getMachine():_fsmRevive(model)
                    elseif (SceneManager:getInstance():isInStory()) then
                        local master = GameDataManager:getInstance():getMaster()
                        if(master) then
                            GameManager:battleReviveHelp(master:getSpriteID(), 0)
                        else
                            assert(false,"commandType == CommandType.RENDERER_ROLE_DEAD  master is nil")
                        end
                    else
                        Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE)
                    end
                end

                renderer:showDie(command.recoverDead, command.showRevive, reviveCallback, command.hitratMonsterRefresh,command.isRemoveSelf)
            else
                if(DEBUG) then 
                    print(" CommandType.RENDERER_ROLE_DEAD renderer is nil.")
                end
            end
        -- 设置触发宝箱，钱袋等npc 效果
        elseif (commandType == CommandType.RENDERER_OPEN_IT_NPC) then
            if (renderer and model) then
                if(model:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
                    renderer:showTransdoorTrigger()
                elseif(model:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_POINT) then
                    -- print("TRIGGER_NPC_TYPE.TRANS_POINT", model:getData():getTransPointType())
                    if(model:getData() and model:getData():getTransPointType() == PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_ROLE_END) then 
                        renderer:showOpenIt(false, function()
                            if(command.pk == RoleDataManager:getMasterPK()) then
                                Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                                    Net.NetNPCSystem:openTriggerNpcRequest(model:getSpriteID())
                                end, 0.5)
                            end
                        end)
                    else
                        renderer:showTransPointTrigger(function()
                            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                                local itemArr = GoodsDataManager:getGoodsArrForPK(RoleDataManager:getMasterPK(), PublicDefine.PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_ITEM, PublicDefine.PACKET_SUB_TYPE.PACKET_SUB_TYPE_2)
                                local goodsData = nil
                                if(itemArr) then 
                                    for k,v in ipairs(itemArr) do 
                                        if(v:isMazeMark()) then 
                                            goodsData = v
                                            break
                                        end
                                    end
                                end

                                if(goodsData and command.pk == RoleDataManager:getMasterPK()) then 
                                    UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1213014, function(isSelect)
                                        require "app.ui.itemuselayer.UseSpadeUI"
                                        local comp = UI.UseSpadeUI:create()
                                        comp:init(goodsData, false, function(isUse)
                                            renderer:showOpenIt(false, function()
                                                Net.NetNPCSystem:openTriggerNpcRequest(model:getSpriteID())
                                            end, true)
                                        end)
                                        UI.UIManager:showPopupComponent(comp)
                                    end, function(isSelect)
                                        renderer:showOpenIt(false, function()
                                            Net.NetNPCSystem:openTriggerNpcRequest(model:getSpriteID())
                                        end, true)
                                    end, nil, nil, false)
                                else
                                    if(command.pk == RoleDataManager:getMasterPK()) then 
                                        renderer:showOpenIt(false,  function()
                                            Net.NetNPCSystem:openTriggerNpcRequest(model:getSpriteID())
                                        end, true)
                                    else 
                                        renderer:showOpenIt(false, nil, false)
                                    end
                                end
                            end, 0.01)
                        end)
                    end
                else
                    renderer:showOpenIt(command.recoverOpen, model:getRemoveAfterTrigger())
                end
            end
        elseif (commandType == CommandType.RENDERER_NPC_HIDE_TRANSDOOR_TRIGGER) then
            if (renderer) then
                renderer:hideTransdoorTrigger()
            end 
        elseif ((commandType == CommandType.RENDERER_TRIGGER_NPC_UNLOCK)) then
            if(renderer) then
                renderer:unlock()
            end
        elseif ((commandType == CommandType.RENDERER_NPC_TRAP_EFFECT)) then
            if(renderer and model) then
                self:triggerTrap(model, renderer)
            end
        -- 获得物品效果
        elseif (commandType == CommandType.RENDERER_GET_DARKGOLDEN_EFFECT) then
            if (renderer) then 
                local callback = function()
                    if(DEBUG) then
                        print("RENDERER_GET_DARKGOLDEN_EFFECT  callback",command.flyTargetModelID, command.flyStartCoord, command.flyToTargetModelID, command.flyToMount, command.flyTime)
                    end
                    if command.flyTargetModelID and command.flyToTargetModelID then
                        local getGoodsCommand = Command.RendererCommand:create(true)
                        getGoodsCommand:initAddGoodsStateCommmand(command.flyTargetModelID,command.openWithSelf, command.flyStartCoord, command.flyToTargetModelID, command.flyToMount,false)
                        SceneManager:getInstance():pushCommand(getGoodsCommand)
                    end
                end
                print("initGetDarkGoldenCommand 1", command.isDarkGolden)
                renderer:showGetDarkGoldenGoods(command.isDarkGolden,callback)
            end 
        elseif (commandType == CommandType.RENDERER_SHOW_START_REVIVE) then
            if(renderer) then
                renderer:startShowReviveLayer()
            end
        -- 处理复活
        elseif (commandType == CommandType.RENDERER_ROLE_REVIVE) then
            if(renderer) then 
                local target = model
                local callback = function()
                    if(target) then
                        local battleCMD = Command.BattleCommand:create(true)
                        battleCMD:initForRoleReviveEnd(target:getSpriteID())
                        SceneManager:getInstance():pushCommand(battleCMD)
                    end
                end

                local coord = command.coord
                -- 计算相关逻辑
                local sx, sy, sz = self._map:coordinateToPosition(coord.x, coord.y, coord.z)
                -- renderer:setPosition(sx, sy + sz)

                renderer:showRevive(callback, sx, sy + sz)
            end
        -- 复活完成
        elseif (commandType == CommandType.RENDERER_END_REVIVE) then
            if(renderer) then 
                renderer:endRevive()
            end
        -- 处理回城
        elseif (commandType == CommandType.RENDERER_ROLE_REMOVE_BACK_TOWN) then
            if(renderer) then
                renderer:removeBackTown()
            end
        -- 角色称号处理
        elseif (commandType == CommandType.RENDERER_ROLE_TITLE) then
            -- 角色称号处理
            if (renderer) then
                renderer:updateTitle(command.titleID,command.param)
            end
        -- 角色公会名字
        elseif (commandType == CommandType.RENDERER_GUILD_NAME) then
            if (renderer) then
                renderer:updateGuildName(command.guildName,command.isShow)
            end
        -- 设置指引箭头
        elseif (commandType == CommandType.RENDERER_SET_GUIDE_POINTER) then
            -- 角色名字处理
            if (renderer) then
                renderer:setShowGuidePointer(command.isShow,command.title,command.x, command.y)
            end
        -- 角色名字处理
        elseif (commandType == CommandType.RENDERER_ROLE_NAME) then
            -- 角色名字处理
            if (renderer) then
                renderer:updateName(command.name,command.isShow,command.isMaster, command.color)
            end
        -- 角色升级表现
        elseif (commandType == CommandType.RENDERER_ROLE_LEVEL_UP) then
            if(renderer) then 
                renderer:showLevelUp()
            end
            self:updateAllMonsterNameColor()
        -- 角色升级属性表现
        elseif (commandType == CommandType.RENDERER_ROLE_LEVEL_UP_ATTR) then
            if renderer then 
                renderer:showLevelUpAttr(command.attrArr)
            end
        -- 刷新穿戴装备效果显示
        elseif (commandType == CommandType.RENDERER_REFRESH_WEAR_EQUPMENT) then
            if renderer then
                renderer:refreshEquip(command.wearEquipmentArr)
            end
        -- 刷新皮肤和面部
        elseif ( commandType == CommandType.RENDERER_REFRESH_SKINADNFACE) then
            -- TODO 皮肤和面部
            
        -- 高亮显示周围的格子
        elseif (commandType == CommandType.RENDERER_SHOW_MAP_GRID) then
            self:showHighlightMapGrid(command.coordList)
        -- 隐藏高亮显示的格子
        elseif (commandType == CommandType.RENDERER_HIDE_MAP_GRID) then
            self:removeHighlightMapGrid()
        -- 地图格子变成地面（爆炸效果）
        elseif (commandType == CommandType.RENDERER_MAP_TILE_CHANGE) then
            if(self._map) then 
                local coordX, coordY = command.coordX, command.coordY

                -- 地块爆炸效果
                local wallBreakComp = Component.WallBreakComponent:create()
                local coordZ = self:getMapTileCoordZ(coordX, coordY)
                local posX, posY = self:getMapTilePosition(coordX, coordY, coordZ)
                wallBreakComp:setPosition(posX, posY)
                self._map:addNodeBeyondMap(wallBreakComp)

                self._map:updateMap()
            end
        -- 地图更新（打开密室等）
        elseif (commandType == CommandType.RENDERER_MAP_TILE_UPDATE) then
            if(self._map) then 
                self._map:updateMap()
            end 
        -- 触发怪物处理
        elseif (commandType == CommandType.RENDERER_TRIGGER_MONSTER) then
            if(renderer) then 
                if(renderer.showTarget) then
                    renderer:showTarget()
                end
                if(model and model:getRoleData()) then
                    renderer:updateName(model:getRoleData():getName(), nil, false)
                end

                if(model and model:getRoleData() and model:getRoleData().getIsPetTrigger and model:getRoleData():getIsPetTrigger()) then 
                    UI.ScrollBar:createByText(string.format(UI.TEXT_1213506, model:getRoleData():getName()))
                end
            end
            Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_TRIGGER_MONSTER,model)
        -- 显示怪物血条
        elseif (commandType == CommandType.RENDERER_SHOW_MONSTER_BLOOD) then
            if(renderer) then
                renderer:showBloodView(command.curHp, command.hp)
            end
        -- 更新怪物血条
        elseif (commandType == CommandType.RENDERER_UPDATE_MONSTER_BLOOD) then
            if(renderer) then
                renderer:updateBloodView(command.curHp, command.hp)
            end
        -- 移除怪物血条
        elseif (commandType == CommandType.RENDERER_REMOVE_MONSTER_BLOOD) then
            if(renderer) then
                renderer:removeBloodView()
            end

        -- 处理状态动画
        elseif (commandType == CommandType.RENDERER_BATTLE_STATUS_ANIMATION) then
            if(renderer) then
                renderer:showStatusAnimation(command.animationName, command.loop)
            end

        -- 添加一个效果表现
        elseif (commandType == CommandType.RENDERER_ADD_EFFECT_VIEW) then
            if(renderer) then
                renderer:showEffect(command.fxAnimName, command.fxMountPoint, command.fxFlip)
            end

        -- 显示变身动画
        elseif (commandType == CommandType.RENDERER_BOSS_SHOW_TRANSFOR) then
            if(renderer) then
                renderer:showTransfor()
            end

        -- 显示变身恢复动画
        elseif (commandType == CommandType.RENDERER_BOSS_SHOW_TRANSFOR_RECOVER) then
            if(renderer) then
                renderer:showTransforRecover()
            end
        -- boss 状态切换
        elseif (commandType == CommandType.RENDERER_BOSS_STATUS_CHANGE) then
            print("RENDERER_BOSS_STATUS_CHANGE")
            if(renderer.statusChange) then
                local change = model:getIsChangeTemplateID()
                if(change) then 
                    model:setIsChangeTemplateID(false)
                end
                local transSkeletonFile, transAtlasFile, transScale =  model:getAnimationData()
                renderer:statusChange(change, transSkeletonFile, transAtlasFile, transScale, model:getIsWake())
            end
        -- 束缚
        elseif (commandType == CommandType.RENDERER_ROLE_CONSTRAINT) then
            if(renderer) then
                renderer:constraint()
            end
        -- 从束缚中恢复
        elseif (commandType == CommandType.RENDERER_ROLE_CONSTRAINT_RECOVER) then
            if(renderer) then
                renderer:constraintRecover()
            end
        -- 冻结
        elseif (commandType == CommandType.RENDERER_ROLE_FROZEN) then
            if(renderer) then
                renderer:frozen()
            end
        -- 从冻结中恢复
        elseif (commandType == CommandType.RENDERER_ROLE_FROZEN_RECOVER) then
            if(renderer) then
                renderer:frozenRecover()
            end

        elseif (commandType == CommandType.RENDERER_ROLE_STATUS_SHOW) then
            if(renderer) then
                renderer:showStatusEffect(command.statusID, command.mountName, command.animationName)
            end 
        elseif (commandType == CommandType.RENDERER_ROLE_STATUS_END) then
            if(renderer) then
                renderer:endStatusEffect(command.statusID)
            end
        -- 移除装饰物
        elseif (commandType == CommandType.RENDERER_REMOVE_DECORATIONS) then
            if(self._mapData) then
                local tile = self._mapData:getTileDataAtCoord(command.coordX, command.coordY)
                if(tile) then
                    tile:removeDecorationForID(command.decorationID)
                    self._map:updateTile(tile, true)
                end
            end 
        -- 显示NPC气泡
        elseif (commandType == CommandType.RENDERER_NPC_INFOMATION_SHOW) then
            if(renderer and model) then 
                renderer:showInfomation(command.textStr, command.talkDucation, model:getInformationLocation())
            end
        -- 隐藏NPC气泡
        elseif (commandType == CommandType.RENDERER_NPC_INFOMATION_HIDE) then
            if(renderer) then
                renderer:hideInfomation()
            end
        -- 处理变形
        elseif (commandType == CommandType.RENDERER_HERO_LOOKS) then
            if(renderer) then
                renderer:looksChange(command.looks,nil,nil,model)
            end
        elseif (commandType == CommandType.RENDERER_ITEM_DEFORMATION_SHOW) then
            if(renderer and model) then
                local deformationData = command.deformationData
                -- if(model:getCategory() == Category.ROLE and model:getType() == RoleType.Monster) then 
                --     deformationData = model:getData():getDeformationData()
                -- elseif (model:getCategory() == Category.TRIGGER_NPC and model:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOX) then 
                --     deformationData = model:getNpcData():getDeformationData()
                -- end
                if(deformationData) then
                    local deformationIsMonster = false
                    local ideleName = "idle"
                    if(deformationData:getCategory() == Category.ROLE and deformationData:getType() == RoleType.Monster) then 
                        ideleName = "idle1"
                        deformationIsMonster = true
                    elseif(deformationData:getCategory() == Category.TRIGGER_NPC) then 
                        ideleName = "idle"
                    end

                    renderer:showDeformation(deformationData.skeleton, deformationData.atlas, deformationData.scale, ideleName, deformationIsMonster)
                    
                    if(deformationData:getCategory() == Category.ROLE and deformationData:getType() == RoleType.Monster) then 
                        local masterData =  GameDataManager:getInstance():getMaster()
                        if(masterData) then 
                            local nameColor = self:getMonsterNameColor(deformationData, masterData) 
                            renderer:updateName(deformationData:getName(), true, false, nameColor)

                            self:updateOneMonsterNameVisibility(model, renderer)
                        end
                    else 
                        renderer:updateName(nil, false)
                    end
                end
            end
        
        elseif (commandType == CommandType.RENDERER_ITEM_DEFORMATION_REMOVE) then
            if(renderer) then
                renderer:removeDeformation()
                self:updateOneMonsterNameVisibility(model, renderer)
            end
        elseif commandType == CommandType.RENDERER_HERO_EXPRESSION then
            if(renderer) then
                renderer:showExpression(command.spineAction, command.direction)
            end
        elseif (commandType == CommandType.RENDERER_NPC_INTERACTION_START) then
             -- NPC交互动画开始
            if(renderer and renderer.startInteraction ) then
                renderer:startInteraction(command.functionType)
            end
        elseif (commandType == CommandType.RENDERER_NPC_INTERACTION_END) then
            -- NPC交互动画结束
            if(renderer and renderer.endInteration) then
                renderer:endInteration()
            end
        elseif (commandType == CommandType.RENDERER_ROLE_SCALE) then
            if(renderer) then
                renderer:scaleTo(command.scale)
            end
        elseif (commandType == CommandType.RENDERER_DREAM_WINDING) then
            if(renderer) then
                if(command.isAdd) then 
                    renderer:showDreamWinding()
                else 
                    renderer:hideDreamWinding()
                end
            end
        elseif (commandType == CommandType.RENDERER_HORCRUX_EXTERIOR) then
            if(renderer and renderer.showHorcruxExterior) then 
                if(self:getIsShowHorcruxScene()) then
                    renderer:showHorcruxExterior(command.horcruxExteriorID)
                end
            end
        elseif (commandType == CommandType.RENDERER_EXPEDITION_UPDATE) then
            if(renderer and renderer.updateExpeditionStatus) then 
                renderer:updateExpeditionStatus(command.expeditionStatus)
            end
        elseif (commandType == CommandType.RENDERER_GUILD_BOSS_STATUS_UPDATE) then
            if(renderer and renderer.npcDead and model and model:getData()) then 
                local guildBossData = model:getData():getGuildBossData()
                if(guildBossData) then 
                    if(guildBossData:getIsKilled()) then 
                        renderer.npcDead()
                    end
                end
            end
        elseif (commandType == CommandType.RENDERER_ROLE_RUN_ANIMATIONS) then
            if(renderer and renderer.runRoleAnimations) then 
                -- print("RENDERER_ROLE_RUN_ANIMATIONS 2", command.animationNames)
                renderer:runRoleAnimations(command.animationNames)
            end
        elseif (commandType == CommandType.RENDERER_ROLE_ANIMATIONS_BY_SPRITEID) then
            if(renderer and renderer.runRoleAnimations) then
                renderer:runRoleAnimations(command.animationNames)
            end
        elseif (commandType == CommandType.RENDERER_MAZE_POINT) then
            -- print("CommandType.RENDERER_MAZE_POINT", command.data)
            if(command.data) then 
                -- 处理显示隐藏表现
                local mazeData = command.data
                if(mazeData.type == "MazePointType_Mark") then 
                    if(self.mazeFlagArr[mazeData.x] == nil) then 
                        self.mazeFlagArr[mazeData.x] = {}
                    end
                    if(self.mazeFlagArr[mazeData.x][mazeData.y] == nil) then 
                        self.mazeFlagArr[mazeData.x][mazeData.y] = {}
                    end
                    if(mazeData.isAdd) then 
                        local nickName = mvc.festivalModel:getMazeName(mazeData.pk)
                        local isMaster = false 
                        if(mazeData.pk == RoleDataManager:getMasterPK()) then 
                            isMaster = true
                        end

                        local skeleton, atlas, scale = "role_npc_treasure_mazeflag.json", "role_npc_treasure_mazeflag.atlas", 1
                        local nowRenderer = Renderer.MazeFlagRenderer:create()
                        nowRenderer:init(skeleton, atlas, scale, true, nickName, isMaster)

                        -- self._map:addNodeBeyondMap(nowRenderer:getView())
                        self._map:addNodeOnMap(nowRenderer:getView())
                        self.mazeFlagArr[mazeData.x][mazeData.y][mazeData.pk] = nowRenderer

                        local coordZ = self:getMapTileCoordZ(mazeData.x, mazeData.y)
                        local posX, posY = self:getMapTilePosition(mazeData.x, mazeData.y, coordZ)
                        nowRenderer:getView():setPosition(posX, posY)
                        local zOrder = 0
                        -- if viewVisible == true then
                            zOrder = self:getMapTileZOrder(mazeData.x, mazeData.y) - 4999
                            nowRenderer:getView():setLocalZOrder(zOrder)
                        -- end

                    else 
                        local oldRenderer = self.mazeFlagArr[mazeData.x][mazeData.y][mazeData.pk]
                        -- if(oldRenderer and oldRenderer:getView()) then 
                        --     oldRenderer:getView():removeFromParent()
                        -- end
                        self.mazeFlagArr[mazeData.x][mazeData.y][mazeData.pk] = nil
                    end
                else
                    -- print("CommandType.RENDERER_MAZE_POINT  master", mazeData)
                    if(mazeData.isAdd) then 
                        if(mazeData.pk == RoleDataManager:getMasterPK()) then 
                            renderer:setDefaultVisible(true)
                        end
                        renderer:setVisible(true)
                        renderer:showEnter()
                    else 
                        if(mazeData.pk == RoleDataManager:getMasterPK()) then 
                            renderer:setDefaultVisible(false)
                        end
                        renderer:setVisible(false)
                    end
                end
            end
        elseif (commandType == CommandType.RENDERER_MAZE_FUN_EXPLORE) then
            if(renderer) then 
                if(self._funExploreAnimation == nil) then
                    self._funExploreAnimation = Avalon.Animation:create("effect_buff_maze_search.json", "effect_buff_maze_search.atlas", 1)
                    self._map:addNodeBeyondMap(self._funExploreAnimation)
                end

                if(command.data) then 
                    local coord = model:getCoord()
                    local coordZ = self:getMapTileCoordZ(coord.x, coord.y)
                    local posX, posY = self:getMapTilePosition(coord.x, coord.y, coordZ)
                    self._funExploreAnimation:setPosition(posX, posY)
                    local zOrder = 0
                    zOrder = self:getMapTileZOrder(coord.x, coord.y) - 4999
                    self._funExploreAnimation:setLocalZOrder(zOrder)
                    self._funExploreAnimation:setVisible(true)
                    self._funExploreAnimation:setAnimation(0, "trigger", false)
                    self._funExploreAnimation:addAnimation(0, "end", false)
                else 
                    self._funExploreAnimation:setVisible(false)
                end
            end
        elseif (commandType == CommandType.RENDERER_MAZE_TRAP_VIEW) then
            -- print("RENDERER_MAZE_TRAP_VIEW", command.data)
            if(renderer) then 
                -- 处理传送点的显示处理
                if(renderer.setVisible) then 
                    renderer:setVisible(command.data)
                end
            end
        elseif (commandType == CommandType.RENDERER_HIT_RAT_BUFF) then
            if(renderer) then 
                local isGood = command.data
                renderer:updateHitRatBuff(isGood)
            end
        elseif (commandType == CommandType.RENDERER_LOSTREALM_CHANGE) then
            if(renderer) then 
                local data = command.data

                if(data.isEnd) then
                    renderer:hideLostRealm()
                else
                    renderer:showLostRealm(data.step)
                end
            end
        elseif (commandType == CommandType.RENDERER_PET_RIDE) then
            --骑乘宠物(pet上或下的表现)
            -- print("CommandType.RENDERER_PET_RIDE  11111111111111 ",command.data)
            -- if renderer then
            --     renderer:setRideType(command.data)
            -- end
            if renderer then
                if model:getData():getSiteId() == 0 then
                    renderer:hidePet(command.data.isRiding,nil,command.data)
                else
                    renderer:hidePet(false,nil,command.data)
                end
            end
        elseif (commandType == CommandType.RENDERER_HERO_RIDE) then
            --骑乘宠物(pet上或下的表现)
            -- print("CommandType.RENDERER_HERO_RIDE  2222222222222222 ",command.data)
            -- if renderer then
            --     renderer:setRideType(command.data)
            --     if command.data.isRiding then
            --         renderer:createHeroRidePetRunderer(model)
            --     else
            --         renderer:removeHeroRidePetRunderer()
            --     end
            -- end
            if renderer then
                    if command.data.petSiteId == 0 then
                        renderer:hidePet(command.data.isRiding,nil,command.data)
                    else
                        renderer:hidePet(false)
                    end
                    if command.data.isRiding and command.data.petSiteId == 0 then
                        renderer:createHeroRidePetRunderer(model)
                    else
                        renderer:removeHeroRidePetRunderer()
                    end
            end
        elseif (commandType == CommandType.RENDERER_HERO_DOWN) then
            if renderer then
                renderer:removeHeroRidePetRunderer(true)
            end
        elseif (commandType == CommandType.RENDERER_PET_DOWN) then
            if renderer then
                renderer:hidePet(false,true)
            end
        elseif (commandType == CommandType.RENDERER_PET_FOLLOW) then
            if renderer then
                renderer:hidePet(false)
            end
        elseif (commandType == CommandType.RENDERER_HERO_TRANSFORM_INTO_BATTLE) then
            if renderer then
                renderer:transformToHeroAnimaiton()
            end
        elseif (commandType == CommandType.RENDERER_HERO_TRANSFORM_LEAVE_BATTLE) then
            if renderer then
                renderer:transformToLooksAnimaiton()
            end
        elseif (commandType == CommandType.RENDERER_FUNCTION_NPC_TRIGGER) then
            if renderer and renderer.trigger then
                renderer:trigger(function()
                    print("RENDERER_FUNCTION_NPC_TRIGGER  1")
                    -- 处理切换下一个动画

                    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                        print("RENDERER_FUNCTION_NPC_TRIGGER  2")
                        -- 触发下一个模型的显示
                        local entTime = AvalonUtil.getLock()
                        local machine = MachineManager:getInstance():getMachine()
                        if(machine) then 
                            machine:_triggerDelayMonster()
                        end
                        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                            self:removeView(model, true)
                            self._model:removeRole(model)
                        end, 0.1)
                    end, 0.01)
                end)
            else
                -- 出现异常直接删除
                self:removeView(model, true)
                self._model:removeRole(model) 
            end
        elseif (commandType == CommandType.RENDERER_PET_CHANGE_SKIN) then
            -- print("CommandType.RENDERER_PET_CHANGE_SKIN  11111111111111 ",command.data)       
            local pet = MasterDataManager:getBagPetById(command.data.petId)
            if pet then
                pet:setSkinId(command.data.skinId)
                pet:refreshCurInitData()
            end
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_CHANGE_SKIN_OK)
        else
            printError(string.format("[ERROR] BattleView executeCommand: command type %d is invalid.", commandType, command))
        end
    else
        printError(string.format("[ERROR] BattleView executeCommand: command category %d is invalid.", commandCategory))
    end
end


function BattleView:showMap(mapData, target, callback)
    if (mapData) then
        self._mapNode = MapLayer:create(mapData)
        if (self._mapNode) then
            self._map = self._mapNode.map
            self._mapData = mapData
            
            -- add by zp CO-11324 周年庆PVE玩法开发（客户端）
            local SceneManager = require("app.game.SceneManager")
            if(SceneManager:getInstance():isInBigCrack()) then
                local winSize = cc.Director:getInstance():getWinSize()
                local colorLayer = cc.LayerColor:create(cc.c4b(38,25,25,255))
                colorLayer:setPosition(0,0)
                colorLayer:setContentSize(winSize.width, winSize.height)
                self._viewNode:addChild(colorLayer, BATTLE_LAYER_ZORDER_MAP)    
            end

            self._viewNode:addChild(self._mapNode, BATTLE_LAYER_ZORDER_MAP)
            -- self._mapNode:setScale(0.5)
            
            -- add by zp CO-11324 周年庆PVE玩法开发（客户端）
            if(not SceneManager:getInstance():isInBigCrack()) then
                self:addBackGround()
            end
            if (target and type(callback) == "function") then
                callback(target)
            end
        end
    else
        assert(false, "[ERROR] BattleView showMap: map data is nil.")
    end
end

function BattleView:triggerEntrance(coordX,coordY)
    -- 触发高低机关密室门处理
    -- print("RENDERER_ENTER_CENTER_COORD  triggerEntrance  start")
    if(self._chamberEntranceModelId ~= nil and self._chamberEntranceCoord ~= nil) then
        -- local renderer = self._rendererMap[self._chamberEntranceModelId]
        local renderer = self:getRenderer(self._chamberEntranceModelId)
        if (renderer ) then
            -- print("RENDERER_ENTER_CENTER_COORD  triggerEntrance ",coordX, coordY, self._chamberEntranceCoord.x, self._chamberEntranceCoord.y)
            local isHeight = self._map:shouldWallShrinkAtCoord( coordX, coordY, self._chamberEntranceCoord.x, self._chamberEntranceCoord.y)
            -- print("RENDERER_ENTER_CENTER_COORD  triggerEntrance  ",isHeight)
            if(isHeight == false) then
                isHeight = true
            else
                isHeight = false
            end
            renderer:entranceShrink(isHeight)
        end
    end

    if(self._mechanismChamberModelId ~= nil and self._mechanismChamberEntranceCoord ~= nil) then
        -- local renderer = self._rendererMap[self._mechanismChamberModelId]
        local renderer = self:getRenderer(self._mechanismChamberModelId)
        if (renderer ) then
            -- print("RENDERER_ENTER_CENTER_COORD  triggerEntrance ",coordX, coordY, self._mechanismChamberEntranceCoord.x, self._mechanismChamberEntranceCoord.y)
            local isHeight = self._map:shouldWallShrinkAtCoord( coordX, coordY, self._mechanismChamberEntranceCoord.x, self._mechanismChamberEntranceCoord.y)
            -- print("RENDERER_ENTER_CENTER_COORD  triggerEntrance  ",isHeight)
            if(isHeight == false) then
                isHeight = true
            else
                isHeight = false
            end
            renderer:entranceShrink(isHeight)
        end
    end
end

-- 添加洞窟内背景效果
function BattleView:addBackGround()
    if(SceneManager:getInstance():isInLostRealm()) then 
        -- local fireWorkAnimation = Avalon.Animation:create("effect_ui_gaming_newyear_fireworks.json", "effect_ui_gaming_newyear_fireworks.atlas", 1);
        -- fireWorkAnimation:setAnimation(0, "idle", true)
        
        -- local centerCoord = {x = 4, y = 4}
        -- local str = ConfigManager:getGeneralForKey("LostRealmCenter")
        -- local strArr = string.split(str, ",")
        -- if(strArr and #strArr == 2)then
        --     centerCoord = {x = tonumber(strArr[1]), y = tonumber(strArr[2])}
        -- end
        -- local mapPosX, mapPosY = self._map:coordinateToPosition(centerCoord.x, centerCoord.y)
        -- fireWorkAnimation:setPosition(mapPosX, mapPosY)

        -- self._map:getLayer(MapDefine.LayerIndexUnderGround):addChild(fireWorkAnimation)
    else
        self:addStaticBackground()
        require "app.battle.CaveBackGround"
        self._bgfx = UI.CaveBackGround:create()
        self._bgfx:init(self._map)
        self._map:getLayer(MapDefine.LayerIndexUnderGround):addChild(self._bgfx)
        -- self._map:getLayer(MapDefine.LayerIndexNodeBeyondMap):addChild(bg)
    end
end

function BattleView:updateAllMonsterNameColor(masterModel)
    local masterData = masterModel and masterModel:getData() or GameDataManager:getInstance():getMaster()
    local monsterModels = MachineManager:getInstance():getMachine():getModel():getAllMonsterModel()
    for i,v in ipairs(monsterModels) do
        local renderer = self:getRenderer(v:getId())
        if (renderer) then
            local nameColor = self:getMonsterNameColor(v:getData(), masterData) 
            renderer:updateName(nil, nil, false, nameColor)
        end
    end
end

function BattleView:updateOneMonsterSealInfo(monsterData, monsterRenderer)
    if(monsterData and monsterRenderer) then
        if MasterDataManager._curCaveBossInfoCache 
            and monsterData.spriteID == MasterDataManager._curCaveBossInfoCache.spriteID 
        then
            monsterRenderer:showBossSealInfoUpdate()
        end
    end
end

function BattleView:updateOneMonsterNameColor(monsterData, monsterRenderer)
    if(monsterData and monsterRenderer) then
        local masterData = GameDataManager:getInstance():getMaster()
        if (not masterData) then return end

        local nameColor = self:getMonsterNameColor(monsterData, masterData)
        monsterRenderer:updateName(nil, nil, false, nameColor)
    end
end

function BattleView:updateAllMonsterNameVisibility(masterModel)
    local masterCoord = masterModel:getCoord()
    local monsterModels = MachineManager:getInstance():getMachine():getModel():getAllRoleModel()
    for i,roleModel in ipairs(monsterModels) do
        local roleData = roleModel:getData()
        if(roleData) then 
            local isShow = true
            local handle = false
            if (roleData:getCategory() == Category.ROLE and roleData:getType() == RoleType.Monster) then 
                local deformationData = roleData:getDeformationData()
                if(deformationData ) then 
                    if(deformationData:getCategory() == Category.TRIGGER_NPC) then 
                        isShow = false
                    end
                else 
                    -- 触发怪但是没有触发的时候不显示名字
                    if(roleData:judgeNeedToTrigger() and roleData:getIsTrigger() == false) then 
                        isShow = false
                    end
                end
                handle = true
            elseif (roleData:getCategory() == Category.TRIGGER_NPC 
                and roleData:getType() == PublicDefine.TRIGGER_NPC_TYPE.BOX) then 
                isShow = false
                local deformationData = roleData:getDeformationData()
                if(deformationData) then 
                    if(deformationData:getCategory() == Category.ROLE 
                        and deformationData:getType() == RoleType.Monster) then 
                        if(deformationData:judgeNeedToTrigger() and deformationData:getIsTrigger() == false) then 
                            isShow = false
                        else 
                            isShow = true
                        end
                    end 
                end
                handle = true
            end

            if(handle) then
                local renderer = self:getRenderer(roleModel:getId())
                if (renderer and renderer.updateName) then
                    if(isShow) then 
                        -- 更新可见
                        local monsterCoord = roleModel:getCoord()
                        local distance = math.abs(math.floor(masterCoord.x) - monsterCoord.x) + math.abs(math.floor(masterCoord.y) - monsterCoord.y)
                        if (distance <= 2) then
                            renderer:updateName(nil, true)
                        else
                            renderer:updateName(nil, false)
                        end
                    else
                        renderer:updateName(nil, false)
                    end
                end
            end
        end 
    end
end

function BattleView:updateOneMonsterNameVisibility(monsterModel, monsterRenderer)
    local master = GameDataManager:getInstance():getMaster()
    if(master and monsterModel and monsterRenderer) then 
        local masterCoord = master:getCoord()
        if (not masterCoord) then return end
        local roleData = monsterModel:getData()
        if(roleData) then 
            local deformationData = roleData:getDeformationData()
            if(deformationData and (deformationData:getCategory() == Category.TRIGGER_NPC 
                or (deformationData:judgeNeedToTrigger() 
                and deformationData:getIsTrigger() == false))) then 
                    
                monsterRenderer:updateName(nil, false)
            else 
                local monsterCoord = monsterModel:getCoord()
                local distance = math.abs(masterCoord.x - monsterCoord.x) + math.abs(masterCoord.y - monsterCoord.y)
                if (distance <= 2) 
                    and not SceneManager:getInstance():isInPuzzle() then
                    monsterRenderer:updateName(nil, true)
                else
                    monsterRenderer:updateName(nil, false)
                end
            end 
        end 
    end
end

function BattleView:getMonsterNameColor(monsterData, masterData)
    local masterData = GameDataManager:getInstance():getMaster()
    local lvSum = 0
    if(masterData) then 
        lvSum = masterData:getLevel()
    end
    -- 这里是计算每个部位的平均值
    local avgEquipLv = lvSum == 0 and 0 or lvSum
    local teamMemberNum = GameDataManager:getInstance():getGameRoleNum()
    local monsterRarity = monsterData:isEliteMonster() and 2 or 1
    local monsterLv = tonumber(string.split(string.split(monsterData:getLevel(),";")[teamMemberNum],",")[monsterRarity])
    if(monsterLv == nil) then 
        print("BattleView:getMonsterNameColor =", teamMemberNum, monsterRarity, monsterData:getTemplateID())
        printError("BattleView:getMonsterNameColor  monsterLv is nil.")
        -- add by zp 这里做了一个容错处理
        monsterLv = 1
    end
    
    local lvDiff = monsterLv - avgEquipLv
    local nameColor = UI.FONT_COLOR_GRAY
    -- add by zp 这里由于已经在整理所有的颜色值了，所以这里采用直接写死的方式来打包处理该问题
    if (lvDiff < -8) then
        nameColor = {r = 155, g = 155, b = 155}
    elseif (lvDiff < -4) then
        nameColor = {r = 83, g = 184, b = 58}
    elseif (lvDiff > 8) then
        nameColor = {r = 233, g = 31, b = 31}
    elseif (lvDiff > 4) then
        nameColor = {r = 255, g = 255, b = 58}
    else
        nameColor = {r = 255, g = 255, b = 255}
    end
    return nameColor
end

function BattleView:addStaticBackground()
    local levelBgFileName = "image/fx-map-background-map1-black%d.png"
    local mapSceneLevel = 6
    if (SceneManager:getInstance():isInCave() or SceneManager:getInstance():isInHero() or SceneManager:getInstance():isInTitanHero()) then
        mapSceneLevel = GameDataManager:getInstance():getSceneLevel()
    end
    levelBgFileName = string.format(levelBgFileName, mapSceneLevel)
    
    local bgHost = cc.Layer:create()
    self._viewNode:addChild(bgHost)
    local screen00 = bgHost:convertToNodeSpace(cc.p(0, 0))
    
    self._staticBg = cc.Layer:create()
    self._staticBg:setPosition(screen00)
    bgHost:addChild(self._staticBg)

    self._bg = cc.Sprite:create(levelBgFileName)
    self._bg:setScale(3)
    local box = self._bg:getBoundingBox()
    self._bg:setAnchorPoint(0, 0)
    self._bg:setPosition(winSize.width / 2 - box.width / 2, winSize.height / 2 - box.height / 2)
    self._staticBg:addChild(self._bg)
    self._bg:hide()
    self._staticBg:hide()
end

function BattleView:centerStaticBackground()
    if (self._bg and not self._bgCentering) then
        self._bgCentering = true
        self._bg:runAction(cc.Sequence:create(
            cc.FadeOut:create(3),
            cc.CallFunc:create(function() self._staticBg:setPosition(0, 0) end),
            cc.FadeIn:create(3),
            cc.CallFunc:create(function() self._bgCentering = false end)))
    end
end

function BattleView:_getMonsterLabelLocation(skeltonFileName)
    local pos = nil
    if (skeltonFileName == "role_monster_boss_troll.json") then
        pos = {x = -40, y = -85}
    elseif (skeltonFileName == "role_monster_boss_destroyer.json") then
        pos = {x = -40, y = -120}
    elseif (skeltonFileName == "role_monster_boss_parasite.json") then
        pos = {x = 0, y = -110}
    elseif (skeltonFileName == "role_monster_boss_shoggoth.json") then
        pos = {x = -46, y = -70}
    elseif (skeltonFileName == "role_monster_boss_gaia.json") then
        pos = {x = -110, y = -85}
    end
    return pos
end

function BattleView:update(dt)
    BattleView.super.update(self,dt);
    if (self._mapMoveDirty and self._bg) then
        self._mapMoveDirty = false
        local offsetX, offsetY = 0, 0
        if (self._mapX and self._mapOldX) then
           offsetX = self._mapX - self._mapOldX 
        end
        if (self._mapY and self._mapOldY) then
           offsetY = self._mapY - self._mapOldY 
        end

        local box = self._bg:getBoundingBox()
        local bgWorldPos = self._staticBg:convertToWorldSpace(cc.p(box.x, box.y))
        local bgPosX, bgPosY = self._staticBg:getPosition()
        if (bgWorldPos.x + box.width < winSize.width or 
            bgWorldPos.y + box.height < winSize.height or
            bgWorldPos.x > 0 or
            bgWorldPos.y > 0)
        then
            self:centerStaticBackground()
        else
            self._staticBg:setPosition(bgPosX + offsetX * 0.1, bgPosY + offsetY * 0.1)
            self._bgfx:updateMapMove(offsetX, offsetY)
        end
    end
end

function BattleView:getCenterCoord()
    return self._map:getCenterCoord()
end

function BattleView:getIsShowHorcruxScene()
    if(SceneManager:getInstance():isActCave() 
        or SceneManager:getInstance():isWorldBossCave()
        or SceneManager:getInstance():isGuildBoss()) then 
        return false
    end

    return true
end
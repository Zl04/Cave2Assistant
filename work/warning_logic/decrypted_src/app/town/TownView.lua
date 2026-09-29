--[[
    游戏引擎系统：视图
]]--


local MapLayer = require "app.mapkit.layers.MapLayer"
local lume = require "thirdparty.lume"
local MapHelper = require "app.mapkit.MapHelper"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local MapDefine = require "app.mapkit.MapDefine"
local GameDataManager = require("app.game.GameDataManager")
local TRANS_DOOR_TYPE = PublicDefine.TRANS_DOOR_TYPE

Town = Town or {}

local TownView = class("TownView", Machine.ShareView)
Town.TownView = TownView

-- 显示视图的z序偏移量
local OBJECT_ZORDER_OFFSET = 5
local CLICK_FX_ZORDER_OFFSET = 10000

-- 战斗场景层级
local BATTLE_LAYER_ZORDER_MAP = 1
local BATTLE_LAYER_ZORDER_TOUCH = 2

local DEBUG = false

-- public:
-- 构造函数
function TownView:ctor()
    TownView.super.ctor(self)
    
end

-- 销毁
function TownView:destroy()
    self:clear()
end

-- 初始化
function TownView:init(model, viewNode)
    TownView.super.init(self,model,viewNode)

end
-- 清理
function TownView:clear()
    TownView.super.clear(self)

    --TODO 清理资源
end

-- 执行命令
function TownView:executeCommand(command)
    -- TODO 根据情况清理相关指令
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
            if (renderer and self._map and not tolua.isnull(self._map)) then

                local coordX, coordY, coordZ = command.coordX, command.coordY, command.coordZ

                local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
                local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
                renderer:setPosition(sx, sy + sz)
                renderer:setZOrder(zOrder + OBJECT_ZORDER_OFFSET)
                renderer:setCoord(coordX, coordY)
                if (command.moveMap) then
                    if GameManager:getIsCenterByMaster() then
                        self._map:screenCenterToCoord(coordX, coordY)
                    end
                end
                
                if(model and model:getCategory() == Category.TRIGGER_NPC) then
                    renderer:setDirection(model:getDirection())
                end
                
                -- if(model and model:getCategory() == Category.ROLE and model:isMaster()) then
                --     if(self._guangSprite) then
                --         self._guangSprite:setPosition(sx, sy + sz)
                --     end
                -- end 
                
                if DEBUG and DEBUG_POSITION then
                    print(string.format("BattleView executeCommand: update position, coord:(%f,%f), position:(%f,%f), zOrder:%f.", command.coordX, command.coordY, sy, sy, zOrder))
                end
            end
        -- 更新z序
        elseif (commandType == CommandType.RENDERER_ZORDER) then
            if(self._map and renderer and not tolua.isnull(self._map)) then
                local coordX, coordY, coordZ = command.coordX, command.coordY, command.coordZ
                local offset = command.offset
                local zOrder = self._map:getZOrderByCoordinate(coordX, coordY)
                renderer:setZOrder(zOrder + OBJECT_ZORDER_OFFSET + offset)
            end 
        -- 转向
        elseif (commandType == CommandType.RENDERER_DIRECTION) then
            if(renderer) then
                renderer:setDirection(command.direction)
            end

        elseif (commandType == CommandType.RENDERER_NPC_CHANGE_COORD) then
            if(renderer and self._map and not tolua.isnull(self._map)) then 
                local coordX, coordY, coordZ = command.coordX, command.coordY, command.coordZ

                local view = renderer:getView()
                self._map:setMapObject(coordX, coordY, view)
            end
        -- 进入中心点
        elseif (commandType == CommandType.RENDERER_ENTER_CENTER_COORD) then
            local coordX, coordY, coordZ = command.coordX, command.coordY, command.coordZ
            if (model and model:isMaster() and self._map and not tolua.isnull(self._map)) then
                -- 是否强制同步坐标
                if (command.syncPosition) then
                    self._map:updateMapTileAround(coordX, coordY)
                    self._map:hideAllMapTileNotAround(coordX, coordY)
                else
                    self._map:updateMapTileWhenMoving(coordX, coordY)
                    Avalon.Scheduler:setDelayForUpdateOnce(self, self._delayUpdateTileWhenStopMoving, 2, coordX, coordY)
                end
            end

            if(self._map and renderer and not tolua.isnull(self._map)) then 
                local view = renderer:getView()
                self._map:setMapObject(coordX, coordY, view)
            end
        -- 播放动画
        elseif (commandType == CommandType.RENDERER_ANIMATION) then
            local animationType = command.animationType
            local timeScale = command.timeScale
            local animationName = command.animationName
            
            if(renderer) then 
                -- 加速动画
                renderer:speedUp(timeScale)
                -- 播放动画
                if     (animationType == AnimationType.IDLE)          then renderer:showIDLE()
                elseif (animationType == AnimationType.MOVE)          then renderer:showMove()
                elseif (animationType == AnimationType.ATTACK)        then renderer:showAttack()
                -- elseif (animationType == AnimationType.DIE)           then renderer:showDie()
                elseif (animationType == AnimationType.AIRCRAFT_FLY)  then renderer:showFly()
                elseif (animationType == AnimationType.AIRCRAFT_BOOM) then renderer:showBoom()
                -- elseif (animationType == AnimationType.REVIVE)        then renderer:showRevive()
                elseif (animationType == AnimationType.BACK_TOWN)     then renderer:showBackTown()
                elseif (animationType == AnimationType.ATTACK_IDLE)   then renderer:showAttackIDLE()
                elseif (animationType == AnimationType.CUSTOM)        then 
                    if (animationName) then 
                        renderer:showAnimation(animationName)
                    end
                else 
                    print(string.format("[ERROR] BattleView executeCommand: animation type %d is invalid.", animationType))
                end
            end
        -- 显示待机动画
        elseif (commandType == CommandType.RENDERER_IDLE) then
            if(renderer) then 
                renderer:showIDLE()
            end
        -- 绘制角色的属性
        elseif (commandType == CommandType.RENDERER_ATTR) then
            if(renderer) then 
                renderer:showAttribute(command.data, command.direction)
            end
        
        -- -- 功能按钮
        -- elseif (commandType == CommandType.RENDERER_FUNCITON_BUTTON) then
        --     if(renderer) then
        --         renderer:showFuntionBtn(command.target, command.data)
        --     end

        -- 修改是否显示头盔
        elseif (commandType == CommandType.RENDERER_ROLE_IS_HIDE_HELMET) then
            if(renderer) then
                renderer:changeIsHideHelmet(command.isHideHelmet)
            end
    
        -- 显示buff的特效
        elseif (commandType == CommandType.RENDERER_ADD_BUFF) then
            if(renderer) then
                local bufferID = command.bufferID
                local animationName = command.animationName
                local loop = command.loop
                local mountNameList = command.mountNameList
                local mountAnimationPrefixList = command.mountAnimationPrefixList
                renderer:showBuff(bufferID, loop, animationName, mountNameList, mountAnimationPrefixList, command.fxFlip)
            end
        -- 移除buff的特效
        elseif (commandType == CommandType.RENDERER_REMOVE_BUFF) then
            if renderer or tolua.isnull(renderer) then
                return
            end

            local bufferID = command.bufferID
            local mountAnimationPrefixList = command.mountAnimationPrefixList
            renderer:hideBuff(bufferID, mountAnimationPrefixList)
        -- 显示技能效果的特效
        elseif (commandType == CommandType.RENDERER_ADD_EFFECT) then
            local effect = command.effect
            if(renderer and effect) then
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
                    local prepareAnimArr = {prepareAnim}
                    if(string.find(prepareAnim, ",")) then
                        prepareAnimArr = string.split(prepareAnim, ",")
                    end

                    renderer:showPrepareSkill(prepareAnimArr)
                end
            end
        -- 显示角色释放技能的动画
        elseif (commandType == CommandType.RENDERER_RELEASE_SKILL) then
            if(renderer) then
                local skill = command.skill
                if(skill) then
                    renderer:speedUp(1.0)
                    renderer:showReleaseSkill(skill:getReleaseAnim())
                end
            end
        -- 显示角色完成技能的动画
        elseif (commandType == CommandType.RENDERER_FINISH_SKILL) then
            local skill = command.skill
            if(renderer and skill) then
                renderer:showFinishSkill(skill:getFinishAnim())
            end
        -- 显示蓄力或者呤唱技能的特效
        elseif (commandType == CommandType.RENDERER_PREPARE_SKILL_FX) then
            local skill = command.skill
            if(renderer and skill) then
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
            local skill = command.skill
            if(renderer and skill) then
                local fxAnimName, fxMount = skill:getReleaseFXAnimAndMount()
                renderer:showReleaseSkillFX(fxAnimName, fxMount)
            end
        -- 显示技能被打断的特效
        elseif (commandType == CommandType.RENDERER_BREAK_SKILL_FX) then
            local skill = command.skill
            if(renderer and skill) then
                local fxAnimName, fxMount = skill:getPrepareFXAnimAndMount()
                renderer:showBreakSkillFX(fxAnimName, fxMount)
            end
        -- 清理技能特效
        elseif (commandType == CommandType.RENDERER_CLEAR_SKILL_FX) then
            if(renderer) then
                renderer:clearSkillFX()
            end
        -- 设置飞行道具的状态
        elseif (commandType == CommandType.RENDERER_BULLET_STATE) then
            if(renderer and self._model) then
                local fromTarget = self._model:getModelByModelID(command.bulletFromTargetModelID)
                local toTarget = self._model:getModelByModelID(command.bulletToTargetModelID)
                local fromMount = command.bulletFromMount
                local toMount = command.bulletToMount
                local flyTime = command.bulletFlyTime
                
                local fromRenderer = self:getRenderer(fromTarget:getId())
                local toRenderer = self:getRenderer(toTarget:getId())
                
                renderer:setState(fromRenderer, fromMount, toRenderer, toMount, flyTime)
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
        -- elseif (commandType == CommandType.RENDERER_ROLE_DEAD) then
        --     if (renderer) then
        --         local reviveCallback = function()
        --             Avalon.MessageCenter:notice(GameMessage.MC_BATTLE_REVIVE)
        --         end
        --         renderer:showDie(command.recoverOpen, command.showRevive)
        --     end
        -- 设置触发宝箱，钱袋等npc 效果
        elseif (commandType == CommandType.RENDERER_OPEN_IT_NPC) then
            if (renderer and model) then
                if(model:getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR) then
                    renderer:showTransdoorTrigger()
                else
                    renderer:showOpenIt(command.recoverOpen, model:getRemoveAfterTrigger())
                end
            end
        -- 获得物品效果
        elseif (commandType == CommandType.RENDERER_GET_DARKGOLDEN_EFFECT) then
            if(renderer) then 
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

                renderer:showGetDarkGoldenGoods(command.isDarkGolden,callback)
            end
        -- 处理回城
        elseif (commandType == CommandType.RENDERER_ROLE_REMOVE_BACK_TOWN) then

        elseif ((commandType == CommandType.RENDERER_NPC_TRAP_EFFECT)) then
            if(renderer and model) then
                self:triggerTrap(model, renderer)
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
        -- 地图格子变成地面
        elseif (commandType == CommandType.RENDERER_MAP_TILE_CHANGE) then
            if(self._map and not tolua.isnull(self._map)) then 
                local coordX, coordY = command.coordX, command.coordY

                -- 地块爆炸效果
                local wallBreakComp = Component.WallBreakComponent:create()
                local coordZ = self:getMapTileCoordZ(coordX, coordY)
                local posX, posY = self:getMapTilePosition(coordX, coordY, coordZ)
                wallBreakComp:setPosition(posX, posY)
                self._map:addNodeBeyondMap(wallBreakComp)

                self._map:updateMap()
            end 
        -- 角色升级表现
        elseif (commandType == CommandType.RENDERER_ROLE_LEVEL_UP) then
            if(renderer) then 
                renderer:showLevelUp()
            end
        -- 角色升级属性表现
        elseif (commandType == CommandType.RENDERER_ROLE_LEVEL_UP_ATTR) then
            if(renderer) then 
                renderer:showLevelUpAttr(command.attrArr)
            end
        elseif (commandType == CommandType.RENDERER_SPINE_TIME_SCALE) then
            if(renderer) then
                -- 加速动画
                renderer:speedUp(command.timeScale)
            end
        elseif (commandType == CommandType.RENDERER_FACE_CHANGE) then
            if(renderer) then
                renderer:refreshFace(command.faceDecodeID)
            end
            
        -- 显示NPC气泡
        elseif (commandType == CommandType.RENDERER_NPC_INFOMATION_SHOW) then
            if(renderer and model) then 
                renderer:showInfomation(command.textStr, command.talkDucation, model:getInformationLocation())
            end
        -- 行商NPC气泡
        elseif (commandType == CommandType.RENDERER_PEDDLER_INFOMATION_SHOW) then
            if(renderer and model) then 
                renderer:showManorPeddlerInfomation(command.textStr, command.saleID, command.giveID, command.givePrice, model:getInformationLocation())
            end
        -- 隐藏NPC气泡
        elseif (commandType == CommandType.RENDERER_NPC_INFOMATION_HIDE) then
            if(renderer) then
                renderer:hideInfomation()
            end
        -- 显示选择英雄表现
        elseif (commandType == CommandType.RENDERER_TOWN_SELECT_HERO_SHOW) then
            if(renderer) then
                renderer:showSelect()
            end
        -- 隐藏选择英雄表现
        elseif (commandType == CommandType.RENDERER_TOWN_SELECT_HERO_HIDE) then
            if(renderer) then
                renderer:hideSelect()
            end
        elseif (commandType == CommandType.RENDERER_ROLE_STATUS_SHOW) then
            if(renderer) then
                renderer:showStatusEffect(command.statusID, command.mountName, command.animationName)
            end 
        elseif (commandType == CommandType.RENDERER_ROLE_STATUS_END) then
            if(renderer) then
                renderer:endStatusEffect(command.statusID)
            end
        -- NPC交互动画开始
        elseif (commandType == CommandType.RENDERER_NPC_INTERACTION_START) then
            if(renderer and renderer.startInteraction) then
                renderer:startInteraction(command.functionType)
            end
        -- NPC交互动画结束
        elseif (commandType == CommandType.RENDERER_NPC_INTERACTION_END) then
            if(renderer and renderer.endInteration) then
                renderer:endInteration()
            end
        -- 处理变形
        elseif (commandType == CommandType.RENDERER_HERO_LOOKS) then
            if(renderer) then
                renderer:looksChange(command.looks,nil,nil,model)
            end
        elseif commandType == CommandType.RENDERER_HERO_EXPRESSION then
            if (renderer) then
                renderer:showExpression(command.spineAction, command.direction)
            end
        elseif commandType == CommandType.RENDERER_NPC_NEW_MAIL then
            if (renderer) then
                renderer:refreshMailNewFlag(command.isRemove)
            end
        elseif (commandType == CommandType.RENDERER_NPC_HIDE_TRANSDOOR_TRIGGER) then
            if (renderer) then
                renderer:hideTransdoorTrigger()
            end 
        elseif (commandType == CommandType.RENDERER_NPC_ACTIVITY_CRYING) then
            if (renderer) then
                renderer:setCryingFlag(command.crying)
            end 
        elseif (commandType == CommandType.RENDERER_SKILL_ADVANCED) then
            if (renderer) then
                renderer:showSkilAdvanced()
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
        elseif (commandType == CommandType.RENDERER_DREAM_RANK_PROJECTION) then
            if(renderer) then
                local detailHero = MasterDataManager:getRandomOnePreDreamRankDetailData()

                renderer:triggerOneShow(detailHero)
            end
        elseif (commandType == CommandType.RENDERER_DREAM_NPC_OPEN) then
            if(renderer) then
                renderer:playDreamNpcOpenAct()
            end
        elseif (commandType == CommandType.RENDERER_HORCRUX_EXTERIOR) then
            if(renderer and renderer.showHorcruxExterior) then 
                renderer:showHorcruxExterior(command.horcruxExteriorID)
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
                        renderer:npcDead()
                    end
                end
            end
        elseif (commandType == CommandType.RENDERER_PET_RIDE) then
            --骑乘宠物(pet上或下的表现)
            -- print("CommandType.RENDERER_PET_RIDE  11111111111111 ",command.data)       
            if renderer then
                if model:getData():getSiteId() == 0 then
                    renderer:hidePet(command.data.isRiding)
                else
                    renderer:hidePet(false)
                end
            end
        elseif (commandType == CommandType.RENDERER_HERO_RIDE) then
            -- 骑乘宠物(pet上或下的表现)
            -- print("CommandType.RENDERER_HERO_RIDE  2222222222222222 ",command.data)
            if renderer then
                -- Avalon.Scheduler:setDelayForUpdateOnce(self, function()
                    if command.data.petSiteId == 0 then
                        renderer:hidePet(command.data.isRiding)
                    else
                        renderer:hidePet(false)
                    end
                    if command.data.isRiding and command.data.petSiteId == 0 then
                        renderer:createHeroRidePetRunderer(model)
                    else
                        renderer:removeHeroRidePetRunderer()
                    end
                -- end, 0.5)
            end

        elseif (commandType == CommandType.RENDERER_HERO_CHANGE_FISHING_WEAPON) then
            --通知玩家换装钓鱼装备
            if renderer then
                local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(model:getSpriteID())
                if(wearData) then

                    local weaponData = nil
                    local fishingWeaponData = nil
                    for k,v in pairs(wearData.wearEquipmentArr) do
                        -- 替换装备,这里要求不能为盔甲
                       
                        local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
                        local equipType = illusionEquipData:getEquipmentType()
                
                        if equipType == PublicDefine.EQUIPMENT_TYPE.Weapon then
                            weaponData = illusionEquipData
                        elseif equipType == PublicDefine.EQUIPMENT_TYPE.Fish then
                            fishingWeaponData = illusionEquipData
                        end

                    end

                    renderer:refreshEquip(wearData.wearEquipmentArr,command.data.isShowFishingWeapon)
                end
            end
        elseif (commandType == CommandType.RENDERER_HERO_SHOW_HARVEST_EFFECT) then
            if renderer then
                renderer:showHarvestEffect(command.data.fishResult)
            end
        elseif (commandType == CommandType.RENDERER_PET_CHANGE_SKIN) then
            -- print("CommandTypeRENDERER_PET_CHANGE_SKIN  11111111111111 ",command.data, command.data.petId, command.data.skinId)       
            local pet = MasterDataManager:getBagPetById(command.data.petId)
            if pet then
                pet:setSkinId(command.data.skinId)
                pet:refreshCurInitData()
            end
            Avalon.MessageCenter:notice(GameMessage.MC_UI_PET_CHANGE_SKIN_OK)
        else
            printError(string.format("[ERROR] BattleView executeCommand: command type %d is invalid.", commandType))
        end
    else
        printError(string.format("[ERROR] BattleView executeCommand: command category %d is invalid.", commandCategory))
    end
end


-- 初始化地图
function TownView:showMap(mapData, target, callback)
    if (mapData) then
        self._mapNode = MapLayer:create(mapData)
        if (self._mapNode) then
            self._map = self._mapNode.map
            self._mapData = mapData
            self._viewNode:addChild(self._mapNode, BATTLE_LAYER_ZORDER_MAP)
            -- self._mapNode:setScale(0.5)

            if (target and type(callback) == "function") then
                callback(target)
            end
        end
    else
        assert(false, "[ERROR] BattleView showMap: map data is nil.")
    end
end

function TownView:loadShader(shaderName, noMVP)
    local keyOfShader = shaderName
    if noMVP == true then
        keyOfShader = keyOfShader.."_noMVP"
    end
    local shader = cc.GLProgramCache:getInstance():getGLProgram(keyOfShader)
    if shader ~= nil then
        return  shader
    end
    local vshFile = "shaders/DefaultShader.vsh"
    local fshFile = "shaders/"..shaderName..".fsh"
    if noMVP == false then
        vshFile = "shader/DefaultMVPShader.vsh"
    end
    shader = AvalonUtil:getGLProgram(vshFile, fshFile)
    -- shader = cc.GLProgram:createWithFilenames(vshFile,fshFile)
    -- -- shader:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
    -- -- shader:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
    -- -- shader:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_TEX_COORD)
    -- -- shader:link()
    -- -- shader:updateUniforms()
    -- cc.GLProgramCache:getInstance():addGLProgram(shader, keyOfShader)
    return shader
end

function TownView:createRenderAndAddToMap(model)
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
            renderer:init(skeletonFile, atlasFile, scale, sex, model:isMaster(), faceDecodeID, looks, isHideHelmet, false, isRide)
            renderer:setAttrAddNode(self._map)
            renderer:setHeroPK(pk)

            -- -- @@@@ CO-18125 书桌&航海星图 (当前版本特殊处理, 下个版本修复hero大小)
            -- local SceneManager = require("app.game.SceneManager")
            -- if SceneManager:getInstance()._state == GameState.IN_MANOR then
            --     renderer:setScale(1.4)
            -- end

            local wearData = GameDataManager:getInstance():getWearEquipmentDataForSpriteID(model:getSpriteID())
            if(wearData) then
                renderer:refreshEquip(wearData.wearEquipmentArr)
            end
            if(MasterDataManager:getPreDreamRankDataForPK(pk)) then 
                renderer:showDreamWinding()
            end
			-- 在城镇里面会收到隐藏魂器的影响
            if(not GameManager:getCustomHQ(CUSTOM_HQ_TYPE.HORCRUX) and not model:isMaster()) then 
                renderer:showHorcruxExterior(0)
            else
                renderer:showHorcruxExterior(model:getData():getHorcruxExteriorId())
            end
            if (model:isMaster()) then
                renderer:updateExpeditionStatus(mvc.expeditionModel:getExpeditionStatus())
            else 
                renderer:updateExpeditionStatus(model:getData():getExpeditionStatus())
            end

            -- 测试代码 --
            -- 添加显示spriteID的测试
            renderer:addName(spriteID,model:getData().pk)
            ---------------
            if (DEBUG) then
                print(string.format("ShareView addView: add hero view %d.", spriteID))
            end

            -- 移动到屏幕中间
            if (model:isMaster()) then
                -- local sprite = cc.Sprite:createWithSpriteFrameName("town_guang_hero.png")
                -- if(sprite) then
                --     -- add by zp 添加高亮的光影效果
                --     sprite:setBlendFunc(cc.blendFunc(gl.DST_COLOR , gl.ONE))
                --     -- sprite:setOpacity(255*0.5)
                --     sprite:setScale(1.3)
                --     sprite:setGLProgram(self:loadShader("ColorDodge", true))
                --     -- self:addChild(sprite, ROLE_ANIMATION_BOTTOM_DOWN)
                --     self._map:addNodeOnMap(sprite, 0)
                --     -- self._map:addNodeOnGround(sprite, 0)

                --     local coordX = coord.x
                --     local coordY = coord.y
                --     local coordZ = self:getMapTileCoordZ(coordX, coordY)
                --     local sx, sy, sz = self._map:coordinateToPosition(coordX, coordY, coordZ)
                --     sprite:setPosition(sx, sy + sz)

                --     self._guangSprite = sprite
                -- else 
                --     printError("TownView createRenderAndAddToMap town_guang_hero create sprite is nil.")
                -- end

                self._map:updateMapTileAround(coord.x, coord.y)
                self:setNewCenterCoordinate(coord, coord, coord)

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

                if (DEBUG) then
                    print(string.format("ShareView addView: move map to coord (%f,%f).", coord.x, coord.y))
                end
            end

            --初始化骑乘相关
            local fPetData = model:getData():getCaptainPetData()
            if fPetData then
                local isRiding = fPetData:isRide()
                renderer:hidePet(isRiding)
                if fPetData:canRide() and fPetData:getSiteId() == 0 then
                    if isRiding then
                        renderer:createHeroRidePetRunderer(model)
                    end
                else
                    renderer:removeHeroRidePetRunderer()
                end
            end

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
                    renderer:hidePet(true)
                else
                    renderer:hidePet(false)
                end
                petData:setLooks(heroData:getLooks())

                local transData = petData
                transData.petSpriteId = petData.spriteID
                transData.heroSpriteId = petData.masterSpriteID
                transData.isRiding = petData:isRide()
                -- print(" transData.isRiding ==555555==== ",transData.isRiding)
                RoleDataManager:handlePetRidingState(transData)
            end

        -- 角色－怪物
        elseif (modelType == RoleType.Monster) then
            local skeletonFile, atlasFile, scale = model:getAnimationData()
            local params = {
                decorationId = model:getDecorationId(),
                toRemoveDecoration = model:isToRemoveDecoration(),
                toRemoveSelf = model:isToRemoveSelf(),
                rare = model:getRare(),
                monsterSubType = model:getMonsterSubType(),
                isTrigger = model:getIsTrigger(),
                isTransform = model:getIsTransform(),
                isTurnAround = model:isTurnAround(),
                coordX = coord.x,
                coordY = coord.y
            }

            if(model:isBigBoss()) then
                renderer = Renderer.BossRenderer:create()
                renderer:init(skeletonFile, atlasFile, scale, params)
            else
                renderer = Renderer.MonsterRenderer:create()
                renderer:init(skeletonFile, atlasFile, scale, params)
            end
            renderer:setAttrAddNode(self._map)

            -- 刷新装饰物表现
            if(model:getDecorationId() ~= 0) then
                local tileData = self._mapData:getTileDataAtCoord(coord.x, coord.y)
                if tileData then
                    self._map:updateTile(tileData)
                end
            end

            -- 测试代码 --
            -- TODO 添加显示spriteID的测试
            renderer:addName(spriteID)
            ----------------
            -- print(string.format("ShareView addView: add monster view %d.", spriteID))
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
                local skeleton, atlas, scale = model:getAnimationData()
                -- print("TRIGGER_NPC_TYPE=", model:isMonsterNpc(), model:getMonsterNpcData() == nil)
                if model:isMonsterNpc() and model:getMonsterNpcData() then
                    local params = {
                        decorationId = model:getMonsterNpcData():getDecorationId(),
                        toRemoveDecoration = model:getMonsterNpcData():isToRemoveDecoration(),
                        toRemoveSelf = model:getMonsterNpcData():isToRemoveSelf(),
                        rare = model:getMonsterNpcData():getMonsterRare(),
                        monsterSubType = model:getMonsterNpcData():getMonsterSubType(),
                        isTrigger = model:getMonsterNpcData():getIsTrigger(),
                        isTransform = model:getMonsterNpcData():getIsTransform(),
                        isTurnAround = model:getMonsterNpcData():isTurnAround(),
                        coordX = coord.x,
                        coordY = coord.y
                    }
                    -- print("TRIGGER_NPC_TYPE=", model:isMonsterNpc(), model:getMonsterNpcData() == nil)
                    renderer = Renderer.MonsterRenderer:create()
                    renderer:init(skeleton, atlas, scale, params)
                    renderer:setGuildBossName(model:getMonsterNpcData():getName(), model:getMonsterNpcData().weaknessType)
                    local guildBossData = model:getData():getGuildBossData()
                    if(guildBossData) then 
                        if(guildBossData:getIsKilled()) then 
                            -- print("TRIGGER_NPC_TYPE 2=", guildBossData:getIsKilled(), guildBossData:getBossID())
                            renderer:npcDead()
                        end
                    end
                else
                    local roleSpriteName,iconName = UI.MapGrid:getIconName(model:getData(), true)
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

                    local GameInManorManager = require "app.game.GameInManorManager"
                    local SceneManager = require("app.game.SceneManager")
                    local facadeSkeleton, facadeAtlas = skeleton, atlas
                    if SceneManager:getInstance():isManor() and model:getData().buildId ~= 0 then
                        local spineName =  GameInManorManager:getInstance():getManorBuildFacade(model)
                        if spineName then
                            facadeSkeleton, facadeAtlas = spineName..".json", spineName..".atlas"
                        end
                    end

                    renderer = Renderer.FunctionNPCRenderer:create()
                    renderer:init(facadeSkeleton, facadeAtlas, scale, model:getType(), model:getIsLock(), iconName, functionName, nickName, informationHeight, model:getData().staticOffset)
                    renderer:setInitMapCoordOnAnimation({x = coord.x, y = coord.y}) -- 为poco设置一个npc动画坐标标签

                    if model.getId and GameInManorManager:isShelfNPC(model:getData().templateID) and renderer.handleEquipmentChange then
                        local wearEquipArr = GameInManorManager:getShelfWearEquipArr(model:getData().templateID)
                        if wearEquipArr then
                            renderer:handleEquipmentChange(wearEquipArr)
                        end
                    end
                end
                
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y)
                self._map:setMapObject(coord.x, coord.y, view)

                -- 处理地底的光亮
                self:showFunctionLight(model, renderer, model:getNpcData().occupySize)
                -- 主城洞穴传送门 和 常驻显示的NPC
                if model:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE) 
                or model:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.CONST_DECORATION)
                then
                    self._map:setPermanentVisible(coord.x, coord.y, view)
                    -- print("主城传送门加入常驻显示")
                end

                -- 给洞穴入口添加迷雾效果
                if(model:getNpcData():hasFunction(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE) and 
                    skeleton ~= "role_npc_function_empty.json") then 
                    local fogView = renderer:getTopFog()
                    self:addViewToBeyondMap(model, fogView, coord.x, coord.y,0, 9999999999)
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

                -- 临时写法，用于处理切换场景报错问题
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y)
                self._map:setMapObject(coord.x, coord.y, view)

                local trapViewNodeList, isDown = renderer:getViewList()
                if (trapViewNodeList) then
                    local zOrderOffset = 0
                    -- print("add trapToView isDown=", isDown)
                    if (not isDown) then
                        zOrderOffset = 9995
                    end
                    
                    local size = trapConfig.size
                    local startCoordX, startCoordY = coord.x - (size[1] - 1) / 2, coord.y - (size[2] - 1) / 2
                    for i = 0, #trapViewNodeList - 1 do
                        local coordX = startCoordX + (i % size[1])
                        local coordY = startCoordY + (math.floor(i / size[2]))

                        local mapTileData = self._mapData:getTileDataAtCoord(coordX, coordY)
                        if (mapTileData and mapTileData:isReachable()) then
                            local trapViewNode = trapViewNodeList[i + 1]
                            if (isDown) then
                                self:addViewToOnGroundMap(model, trapViewNode, coordX, coordY, nil)
                            else
                                self:addViewToMap(model, trapViewNode, coordX, coordY, nil, zOrderOffset)
                            end
                            self._map:setMapObject(coordX, coordY, trapViewNode)
                        end
                    end
                end
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

                if (direction == DirectionType.WEAST or
                    direction == DirectionType.EAST) then
                    coordY = coordY + 1
                elseif (direction == DirectionType.SOUTH or
                        direction == DirectionType.NORTH) then
                    coordX = coordX + 1
                end
                self:addViewToMap(model, rightGateAnimation, coordX, coordY, nil, zOrderOffsetRight)
                self._map:setMapObject(coordX, coordY, rightGateAnimation)
            
            -- 密室触发器
            elseif (modelType == PublicDefine.TRIGGER_NPC_TYPE.MECHANISM_CHAMBER_TRIGGER) then
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
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_TOWNCAVE
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.TOWN_TO_BIGSAILPORT
                    or model:getNpcData():getTransdoorType() == TRANS_DOOR_TYPE.BIGSAILPORT_TO_TOWN) then
                    renderer = Renderer.TransDoorNpcRendere:create()
                    skeleton = model:getSpineName()
                    renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
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
                if(model:getState() == FSMState.MOVE) then 
                    renderer:showMove()
                end

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
            else
                -- print("PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR  eeee", modelType, PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR)
                local skeleton, atlas, scale = model:getAnimationData()
                renderer = Renderer.TriggerNPCRenderer:create()
                renderer:init(skeleton, atlas, scale, model:getType(), model:getIsLock())
                
                local view = renderer:getView()
                self:addViewToMap(model, view, coord.x, coord.y)
                self._map:setMapObject(coord.x, coord.y, view)
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

function TownView:getCenterCoord()
    return self._map:getCenterCoord()
end

function TownView:_delayUpdateTileWhenStopMoving(params)
    local coordX, coordY = table.unpack(params)
    if(not tolua.isnull(self) and not tolua.isnull(self._map)) then 
        self._map:updateMapTileAround(coordX, coordY)
    end
end
--[[
    游戏引擎系统：视图
]]--


local MapTownLayer = require "app.mapkit.layers.MapTownLayer"
local lume = require "thirdparty.lume"
local MapHelper = require "app.mapkit.MapHelper"
local MapDataManager = require "app.mapkit.model.MapDataManager"
local MapDefine = require "app.mapkit.MapDefine"
local GameDataManager = require("app.game.GameDataManager")
local TRANS_DOOR_TYPE = PublicDefine.TRANS_DOOR_TYPE

Town = Town or {}

local TownNewView = class("TownNewView", Machine.ShareView)
Town.TownNewView = TownNewView

-- 显示视图的z序偏移量
local OBJECT_ZORDER_OFFSET = 5
local CLICK_FX_ZORDER_OFFSET = 10000

-- 战斗场景层级
local BATTLE_LAYER_ZORDER_MAP = 1
local BATTLE_LAYER_ZORDER_TOUCH = 2

local DEBUG = false

-- public:
-- 构造函数
function TownNewView:ctor()
    TownNewView.super.ctor(self)
    
end

-- 销毁
function TownNewView:destroy()
    self:clear()
end

-- 初始化
function TownNewView:init(model, viewNode)
    TownNewView.super.init(self,model,viewNode)

end
-- 清理
function TownNewView:clear()
    TownNewView.super.clear(self)
end

-- 执行命令
function TownNewView:executeCommand(command)
    -- 根据情况清理相关指令
    local commandCategory = command.category
    local commandType = command.type

    if (commandCategory == CommandCategory.RENDERER) then
        local renderer = nil
        local model = self._model:getModelByModelID(command.modelID)
        if (command.modelID) then
            renderer = self:getRenderer(command.modelID)
        end
        -- 播放动画
        if (commandType == CommandType.RENDERER_ANIMATION) then
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

        -- 设置指引箭头
        elseif (commandType == CommandType.RENDERER_SET_GUIDE_POINTER) then
            -- 角色名字处理
            if (renderer) then
                renderer:setShowGuidePointer(command.isShow,command.title,command.x, command.y)
            end
        -- 高亮显示周围的格子
        elseif (commandType == CommandType.RENDERER_SHOW_MAP_GRID) then
            self:showHighlightMapGrid(command.coordList)
        -- 隐藏高亮显示的格子
        elseif (commandType == CommandType.RENDERER_HIDE_MAP_GRID) then
            self:removeHighlightMapGrid()
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
        -- 隐藏NPC气泡
        elseif (commandType == CommandType.RENDERER_NPC_INFOMATION_HIDE) then
            if(renderer) then
                renderer:hideInfomation()
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
        elseif ((commandType == CommandType.RENDERER_TRIGGER_NPC_UNLOCK)) then
            if(renderer) then
                local isLock = false
                local functionTypeArr = model:getData():getAllFunctionType()
                functionTypeArr = Game.FunctionUnlockManager:getInstance():checkNpcFunction(functionTypeArr)
                if #functionTypeArr == 0 then
                    isLock = true
                end
                renderer:setLockStatus(isLock)

                -- CO-17645 新解锁一个功能的建筑物的时候，建筑物名字不显示
                local functionnameID = model:getData().functionname
                local functionName = nil
                local LanguageManager = require("app.game.LanguageManager")
                if(functionnameID and functionnameID ~= 0) then 
                    functionName = LanguageManager:getInstance():getLocalString(functionnameID)
                end
                local npcNameNode = renderer:createNpcNameNode(functionName, model:getData():getId())
                if npcNameNode then
                    self._mapNode:addViewToMapForLayout(npcNameNode, model:getData().coordX, model:getData().coordY, 10000000)
                end
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
function TownNewView:showMap(mapData, target, callback)
    --TODO 根据配置文件处理相关的场景显示逻辑
    -- if (mapData) then
        self._mapNode = MapTownLayer:create(mapData)
        if (self._mapNode) then
            -- self._map = self._mapNode.map
            self._bg = self._mapNode.bg
            self._mapData = mapData
            self._viewNode:addChild(self._mapNode, BATTLE_LAYER_ZORDER_MAP)
            -- self._viewNode:setScale(5.5)

            if (target and type(callback) == "function") then
                callback(target)
            end
        end
    -- else
    --     assert(false, "[ERROR] BattleView showMap: map data is nil.")
    -- end
end

function TownNewView:loadShader(shaderName, noMVP)
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

function TownNewView:createRenderAndAddToMap(model)
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


    -- 触发器npc 
    if ((modelCategory == Category.TRIGGER_NPC)) then
        -- 触发器npc-剧情
        if(modelType == PublicDefine.TRIGGER_NPC_TYPE.BOSS_SCENARIO_TRIGGER) then
            -- boss 剧情触发器不用renderer
        -- 触发器npc-其他
        else
            -- function npc
            if (modelType == PublicDefine.TRIGGER_NPC_TYPE.FUNCTION_NPC) then
                local skeleton, atlas, scale = model:getAnimationData()
                -- print("TRIGGER_NPC_TYPE=", model:isMonsterNpc(), model:getMonsterNpcData() == nil)

                local roleSpriteName,iconName = UI.MapGrid:getIconName(model:getData(), true)
                local nameID = model:getData().name
                local functionnameID = model:getData().functionname
                local functionName = nil
                local nickName = nil
                local LanguageManager = require("app.game.LanguageManager")
                if(nameID) then 
                    nickName = LanguageManager:getInstance():getLocalString(nameID)
                end
                if(functionnameID) then 
                    functionName = LanguageManager:getInstance():getLocalString(functionnameID)
                end
                local informationHeight = model:getInformationLocation()[2]

                local isLock = false
                local functionTypeArr = model:getData():getAllFunctionType()
                functionTypeArr = Game.FunctionUnlockManager:getInstance():checkNpcFunction(functionTypeArr)
                if #functionTypeArr == 0 then
                    isLock = true
                end

                renderer = Renderer.FunctionNpcNewSceneRenderer:create()
                renderer:init(skeleton, atlas, scale, model:getType(), isLock)
                renderer:setInitMapCoordOnAnimation({x = coord.x, y = coord.y}) -- 为poco设置一个npc动画坐标标签
                
                local newSceneData =  model:getData():getNewSceneData()

                local view = renderer:getView()
                -- 这里由于美术直接按照中心点坐标对齐，所以直接采用 0,0 点来添加
                -- self:addViewToMap(model, view, coord.x, coord.y, newSceneData.index or 0)
                self:addViewToMap(model, view, 0, 0, newSceneData.index or 0)

                -- 添加显示建筑名字
                functionName = functionName or "type="..model:getType()
                -- print("functionNamefunctionName=", functionName, coord.x, coord.y, isLock)
                local npcNameNode = renderer:createNpcNameNode(functionName, model:getData():getId())
                if(npcNameNode and not isLock) then --功能需要开启后才能显示名字
                    -- if(self._addX == nil) then 
                    --     self._addX = 0
                    -- end
                    -- self._addX = self._addX + 30
                    -- print("fdddddddddddddddddddd=", model:getData().coordX + self._addX, model:getData().coordY)
                    self._mapNode:addViewToMapForLayout(npcNameNode, model:getData().coordX, model:getData().coordY, 10000000)
                end
            end
        end

        if (DEBUG) then
            print(string.format("Battle addView: add TRIGGER_NPC view %d.", model:getId()))
        end
        --------------------------------------------------------------
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



function TownNewView:getCenterCoord()
    -- return self._map:getCenterCoord()
end

function TownNewView:_delayUpdateTileWhenStopMoving(params)
    -- local coordX, coordY = table.unpack(params)
    -- if(not tolua.isnull(self) and not tolua.isnull(self._map)) then 
    --     self._map:updateMapTileAround(coordX, coordY)
    -- end
end

--------------------------------  以下为新的场景实现的函数  -------------------------------------

function TownNewView:triggerOneTouchEffect(screenPosition)
    if(self._mapNode) then
        self._mapNode:addTouchEffect(screenPosition)
    end
end

--------------------------------  以上为新的场景实现的函数  -------------------------------------


-- 处理以前老接口的屏蔽处理
-- 将屏幕坐标转换成地块坐标
function TownNewView:convertPositionToCoord(screenPosition)
    local mapPosition = self._bg:convertToNodeSpace(screenPosition)
    local coordX, coordY = self._bg:positionToCoordinate(mapPosition.x, mapPosition.y)
    return coordX, coordY
end

-- 将地块坐标转换成屏幕坐标
function TownNewView:convertCoordToPosition(mapCoord)
    printError("TownNewView:convertCoordToPosition")
    -- local nodeX, nodeY = self._map:coordinateToPosition(mapCoord.x, mapCoord.y)
    -- local screenPosition = self._map:convertToWorldSpace(cc.p(nodeX, nodeY))
    -- return screenPosition.x, screenPosition.y
end

-- 将视图添加到地图上
function TownNewView:addViewToMap(model, view, x, y, zOrder, zOrderOffset)
    if(model) then
        zOrder = zOrder or 0
        zOrderOffset = zOrderOffset or 0
        print("TownNewView:addViewToMap(", x, y)
        self._mapNode:addViewToMap(view, x, y, zOrder + zOrderOffset)
    end
end

-- 把视图添加地面上
function TownNewView:addViewToOnGroundMap(model, view, coordX, coordY, coordZ, zOrderOffset, isCenterPosition)
    -- printError("TownNewView:addViewToOnGroundMap")
end

-- 将视图添加到地图最顶层
function TownNewView:addViewToBeyondMap(model, view, coordX, coordY, coordZ, zOrderOffset)
    -- printError("TownNewView:addViewToBeyondMap")
end

-- 渲染矩阵在背景上
function TownNewView:drawRectInBg(rectPoint, drawColor)
    -- print("TownNewView:drawRectInBg", rectPoint, drawColor)
    if(self._mapNode) then 
        self._mapNode:drawRectInBg(rectPoint, drawColor)
    end
end
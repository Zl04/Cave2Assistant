-- SuperLevelSelect.lua
-- Author:ydli
-- 2019年4月10日
-- Using:关卡选择父类（存放公用方法）


UI = UI or {}
local SuperLevelSelect = class("SuperLevelSelect", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
UI.SuperLevelSelect = SuperLevelSelect
local NodeSize = cc.size(63, 70)
local ScrollViewSize = cc.size(700, 460)
local maxBoundValue = 190

function SuperLevelSelect:ctor(comType, resList, width, height, asyncToLoadRes, layerType)
    SuperLevelSelect.super.ctor(self, comType, resList, width, height, asyncToLoadRes)
    self.stepPoint = {}
    self.levelBtnList = {}
    self.cloudList = {}
    self.defaultNomalSelectIcon = nil
    self.layerType = layerType
end

function SuperLevelSelect:dtor()
    SuperLevelSelect.super.dtor(self)
    self.stepPoint = {}
    self.levelBtnList = {}
    self.defaultNomalSelectIcon = nil

    local textureCache = cc.Director:getInstance():getTextureCache()
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_2.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_3.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_2.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_3.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_desert.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_distortedSpace_map_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_distortedSpace_map_bg.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_inferno_map_bg.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_inferno_map_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_petsadventure_heromap_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_petsadventure_heromap_2.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_petsadventure_heromap_3.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_petsadventure_up_02.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_uncharted_map_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_Reincarnation_map_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_Reincarnation_map_2.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_Reincarnation_map_3.png")

    reload_script_file("app.ui.town.SuperLevelSelect")
end

-- 初始化
function SuperLevelSelect:init()
    SuperLevelSelect.super.init(self)
end

-- 模版函数：初始化组建的视图
function SuperLevelSelect:onInitView()
end

-- 模版函数：更新组建的视图
function SuperLevelSelect:onUpdateView()
    SuperLevelSelect.super.onUpdateView(self)
end

function SuperLevelSelect:addBouncePic(node, imagePath1, imagePath2)
    local left = cc.Sprite:create(imagePath1)
    left:setAnchorPoint(1, 0)
    node:addChild(left)

    local right = cc.Sprite:create(imagePath2)
    right:setAnchorPoint(0, 0)
    right:setPositionX(node:getContentSize().width)
    node:addChild(right)
end

function SuperLevelSelect:createGameMode(caveMode, clickCallback)
    local nodeLayout = UI.Layout:create()
    nodeLayout:init()
    nodeLayout:setSize(214, 0)

    local btnImageArr = self:getCaveModeImageArr(caveMode)
    self.singlePlayBtn = UI.Button:create()
    self.singlePlayBtn:init(btnImageArr[1][1], btnImageArr[1][2], btnImageArr[1][3])
    self.singlePlayBtn:leftBottom(0, 0)
    self.singlePlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if(clickCallback) then 
            clickCallback(PublicDefine.GAME_MODE.MODE_SOLO)
        end
        self:refreshGameModeBtnCheckState(PublicDefine.GAME_MODE.MODE_SOLO)
    end)
    nodeLayout:addChild(self.singlePlayBtn, 10)

    self.teamPlayBtn = UI.Button:create()
    self.teamPlayBtn:init(btnImageArr[2][1], btnImageArr[2][2], btnImageArr[2][3])
    self.teamPlayBtn:leftBottom(70, 0)
    self.teamPlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if(clickCallback) then 
            clickCallback(PublicDefine.GAME_MODE.MODE_TEAM)
        end
        self:refreshGameModeBtnCheckState(PublicDefine.GAME_MODE.MODE_TEAM)
        Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
    end)
    nodeLayout:addChild(self.teamPlayBtn, 10)
    self.teamPlayBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self, function()
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
            Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team, caveMode)
        end
    end)

    self.mercenaryPlayBtn = UI.Button:create()
    self.mercenaryPlayBtn:init(btnImageArr[3][1], btnImageArr[3][2], btnImageArr[3][3])
    self.mercenaryPlayBtn:leftBottom(160, 0)
    self.mercenaryPlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if(clickCallback) then 
            clickCallback(PublicDefine.GAME_MODE.MODE_MERCENARY)
        end
        self:refreshGameModeBtnCheckState(PublicDefine.GAME_MODE.MODE_MERCENARY)
        Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary)
    end)
    nodeLayout:addChild(self.mercenaryPlayBtn, 10)
    self.mercenaryPlayBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self, function()
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
            Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary)
            return
        end

        local masterData = GameDataManager:getInstance():getMaster()
        local guildBossLimit = ConfigManager:getGuildConfigForKey("guildMercenaryTimeLimit")
        if(guildBossLimit == nil) then 
            guildBossLimit = SECONDS_ONE_DAY
        end
        local waitingTime = masterData:getJoinGuildTime() + guildBossLimit - GameManager:getNormalServerTime()
        if not MasterDataManager:getGuildData() or waitingTime > 0 then 
            local LanguageManager = require("app.game.LanguageManager")
            if(not MasterDataManager:getGuildData()) then 
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110668))
                return
            end

            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170306))
            return
        end
    end)

    self:changeCaveMode(caveMode)

    return nodeLayout
end

function SuperLevelSelect:getCaveModeImageArr(caveMode)
    local btnImageArr = {
        {
            "ui_btn_single_0.png",
            "ui_btn_plot_single_1.png",
            "ui_btn_single_2.png"
        },
        {
            "ui_btn_many_0.png", 
            "ui_btn_plot_many_1.png", 
            "ui_btn_many_2.png"
        },
        {
            "ui_btn_mercenary_1.png",
            "ui_btn_mercenary_5.png",
            "ui_btn_mercenary_6.png"
        }
    }

    if(caveMode == PublicDefine.CAVE_MODE.MODE_HERO) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_hero_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_hero_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_2.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_desert_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_desert_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_3.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_distortedSpace_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_distortedSpace_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_4.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_hero_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_hero_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_2.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_uncharted_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_uncharted_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_7.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_VIKING) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_uncharted_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_uncharted_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_7.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_titan_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_titan_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_8.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif(caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_hero_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_hero_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_2.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_desert_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_desert_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_3.png",
                "ui_btn_mercenary_6.png"
            }
        }
    elseif (caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS) then
        btnImageArr = {
            {
                "ui_btn_single_0.png",
                "ui_btn_chaoswormhole_single_1.png",
                "ui_btn_single_2.png"
            },
            {
                "ui_btn_many_0.png", 
                "ui_btn_chaoswormhole_many_1.png", 
                "ui_btn_many_2.png"
            },
            {
                "ui_btn_mercenary_1.png",
                "ui_btn_mercenary_9.png",
                "ui_btn_mercenary_6.png"
            }
        }
    end

    return btnImageArr
end

--[[
    切换模式，会刷新游戏模式的图标
]]
function SuperLevelSelect:changeCaveMode(caveMode)
    local btnImageArr = self:getCaveModeImageArr(caveMode)

    self.singlePlayBtn:setNormal(btnImageArr[1][1])
    self.singlePlayBtn:setSelected(btnImageArr[1][2])
    self.singlePlayBtn:setDisabled(btnImageArr[1][3])
    self.teamPlayBtn:setNormal(btnImageArr[2][1])
    self.teamPlayBtn:setSelected(btnImageArr[2][2])
    self.teamPlayBtn:setDisabled(btnImageArr[2][3])
    self.mercenaryPlayBtn:setNormal(btnImageArr[3][1])
    self.mercenaryPlayBtn:setSelected(btnImageArr[3][2])
    self.mercenaryPlayBtn:setDisabled(btnImageArr[3][3])
end

function SuperLevelSelect:refreshGameModeBtnCheckState(gameMode)
    if not self.singlePlayBtn:isDisable() then
        self.singlePlayBtn:setBtnStatus(ButtonState.NORMAL)
    else
        if(gameMode == PublicDefine.GAME_MODE.MODE_SOLO) then 
            return
        end
    end

    if not self.teamPlayBtn:isDisable() then
        self.teamPlayBtn:setBtnStatus(ButtonState.NORMAL)
    else
        if(gameMode == PublicDefine.GAME_MODE.MODE_TEAM) then 
            return
        end
    end
    if not self.mercenaryPlayBtn:isDisable() then
        self.mercenaryPlayBtn:setBtnStatus(ButtonState.NORMAL)
    else
        if(gameMode == PublicDefine.GAME_MODE.MODE_MERCENARY) then 
            return
        end
    end
    -- print("refreshGameModeBtnCheckState", gameMode)
    -- print(debug.traceback())
    if gameMode == PublicDefine.GAME_MODE.MODE_SOLO then
        self.singlePlayBtn:setBtnStatus(ButtonState.ACTIVE)
    elseif gameMode == PublicDefine.GAME_MODE.MODE_TEAM then
        -- body
        self.teamPlayBtn:setBtnStatus(ButtonState.ACTIVE)
    elseif gameMode == PublicDefine.GAME_MODE.MODE_MERCENARY then
        self.mercenaryPlayBtn:setBtnStatus(ButtonState.ACTIVE)
    end
end

function SuperLevelSelect:refreshGameModeState()
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
        self.teamPlayBtn:enable()
        if Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
            ToolsUtil:playNewAction(self.teamPlayBtn, 0.8)
        else
            ToolsUtil:removeNewAction(self.teamPlayBtn)
        end
    else
        self.teamPlayBtn:disable()
    end

    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
        local masterData = GameDataManager:getInstance():getMaster()
        local guildBossLimit = ConfigManager:getGuildConfigForKey("guildMercenaryTimeLimit")
        if(guildBossLimit == nil) then 
            guildBossLimit = SECONDS_ONE_DAY
        end
        local waitingTime = masterData:getJoinGuildTime() + guildBossLimit - GameManager:getNormalServerTime()
        if MasterDataManager:getGuildData() and waitingTime <=0 then 
            self.mercenaryPlayBtn:enable()
            if Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
                ToolsUtil:playNewAction(self.mercenaryPlayBtn, 0.8)
            else
                ToolsUtil:removeNewAction(self.mercenaryPlayBtn)
            end
        else
            self.mercenaryPlayBtn:disable()
        end
    else
        self.mercenaryPlayBtn:disable()
    end
end
   
--创建关卡开放按钮
--@param #int index 关卡顺序
function SuperLevelSelect:createLevelBtn(class, parent, levelNum, x, y, spineName, oldLevel, curLevel, clickCallback, animEndCallback, animStartCallback)
    local spineIcon = class:create() 
    spineIcon:init(spineName)
    spineIcon:leftBottom(x - NodeSize.width / 2, y - NodeSize.height / 2)
    spineIcon:setTag(levelNum)
    parent:addChild(spineIcon, 12)
    spineIcon:setSize(NodeSize.width,NodeSize.height)
    if levelNum > oldLevel then
        if levelNum > curLevel then
            spineIcon:lock()
        else
            spineIcon:waitUnLock()
        end
    else
        spineIcon:unLocked()
    end
    
    spineIcon:setClickCallback(handler(spineIcon, clickCallback))

    spineIcon:setAnimationEndCallback(animEndCallback)
    spineIcon:setAnimationStartCallback(animStartCallback)
    return spineIcon
end

function SuperLevelSelect:createCloud(parent, plotData, posX, posY, oldLevel, curLevel)
    local spineName = nil
    local lastShopLevel = plotData.includeLevel[#plotData.includeLevel] or 99999999
    local firstShopLevel = plotData.includeLevel[1] or 99999999
    local isDelay = false
    local mistyId = plotData.mistyName[1]
    if firstShopLevel > curLevel then
        spineName = string.format("map%d_idle", mistyId)
    else
        if firstShopLevel > oldLevel then
            spineName = string.format("map%d_open", mistyId)
            isDelay = true
        else
            
        end
    end
    if spineName == nil then
        return
    end
    local cloud = UI.Animation:create()
    cloud:setName(string.format("map%d_open", mistyId))
    cloud:init("effect_ui_town_stageselect_cloud.json", "effect_ui_town_stageselect_cloud.atlas", 1)
    if isDelay then
        cloud:setAnimation(string.format("map%d_idle", mistyId), true)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            if cloud.setAnimation then
                cloud:setAnimation(spineName, true)
            end
        end, 0.5)
    else
        cloud:setAnimation(spineName, true)
    end
    local size = cloud:getBoundingBox()
    cloud:setSize(size.width, size.height)
    cloud:leftBottom(posX - cloud:getContentSize().width / 2, posY - cloud:getContentSize().height / 2)
    cloud:setTag(lastShopLevel)
    parent:addChild(cloud, 100)
    if UI.ShowCloud then
        cloud:enableDebugDraw()
        local number = UI.Text:create()
        number:init(plotData.ID.." / "..size.width..","..size.height, UI.FONT_STANDARD, UI.FONT_SIZE_30PX, UI.FONT_COLOR_RED)
        number:center()
        cloud:addChild(number)
    end
    cloud:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(sender, event)
        local startPos = string.find(event.animation, "_open")
        if(startPos ~= nil) then
            cloud:destroy()
        end
    end)
    return cloud
end


--paramStr = {"1,165,166|3,170,180|2,178,191",.....} 图片Id；X坐标；Y坐标
function SuperLevelSelect:createStepPoint(levelId, paramStr, stepName, parent, oldLevel)
    local isShowPoint = false
    if levelId < oldLevel then
       isShowPoint = true
    end
-- isShowPoint = true
    paramStr = string.split(paramStr, "|")
    for k, v in ipairs(paramStr) do
        local params = string.split(v, ",")
        if #params >= 3 then
            -- dump(params, "----params----")
            local fileName = string.format(stepName, tonumber(params[1]))
            local spriteFame = cc.SpriteFrameCache:getInstance():getSpriteFrame(fileName)
            if spriteFame then
                local stepPoint = UI.Image:create()
                stepPoint:init(fileName)
                stepPoint:leftBottom(tonumber(params[2]) - stepPoint:getContentSize().width / 2, tonumber(params[3]) - stepPoint:getContentSize().height / 2)
                stepPoint:setTag(levelId)
                parent:addChild(stepPoint, 11)
                if self.stepPoint[levelId] == nil then
                    self.stepPoint[levelId] = {}
                end
                stepPoint:setVisible(isShowPoint)

                table.insert(self.stepPoint[levelId], stepPoint)
            else
                print("----error not have ", fileName)
            end
        end
    end
end

--创建关卡数据
function SuperLevelSelect:createLevelBtns(oldLevel, curLevel, scrollview, parent, clickCallback, animEndCallback, animStartCallback, normalChoiceLevel, diff)
    -- print("----------createLevelBtns oldLevel, curLevel", oldLevel, curLevel)
    -- print(debug.traceback())
    oldLevel = curLevel
    local plotList = {}
    local iconName = ""
    local stepName = ""
    self.defaultNomalSelectIcon = nil
    if self.layerType == Game.LevelSelectLayerType.Normal_Plot then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_NORMAL)
        iconName = "effect_ui_town_stageselect_icon"
        stepName = "ui_selectfloor_plotmap_round%d.png"
    elseif self.layerType == Game.LevelSelectLayerType.Hero_Plot then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_HERO)
        iconName = "effect_ui_town_stageselect_hero_icon"
        stepName = nil
    elseif self.layerType == Game.LevelSelectLayerType.Expedition then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_NORMAL)
        iconName = "effect_ui_town_stageselect_icon"
        stepName = "ui_selectfloor_plotmap_round%d.png"
    elseif self.layerType == Game.LevelSelectLayerType.Desert_Eye then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_DESERT_EYES)
        iconName = "effect_ui_town_stageselect_desert_icon"
        stepName = "ui_selectfloor_plotmap_yellow_round%d.png"
     elseif self.layerType == Game.LevelSelectLayerType.Distorted_Space then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE)
        iconName = "effect_ui_town_stageselect_distortedspace_icon"
        stepName = "ui_distortedSpace_plotmap_round%d.png"
     elseif self.layerType == Game.LevelSelectLayerType.Inferno then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_INFERNO)
        iconName = "effect_ui_town_stageselect_icon"
        stepName = "ui_distortedSpace_plotmap_round%d.png"
    elseif self.layerType == Game.LevelSelectLayerType.Pet_Adventure then
        plotList = ConfigManager:getAllPetAdvLevleSelectData()
        iconName = "effect_ui_town_stageselect_distortedspace_icon"
        stepName = "ui_distortedSpace_plotmap_round%d.png"
    elseif self.layerType == Game.LevelSelectLayerType.VoidRift then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_VOID_RIFT)
        iconName = "effect_ui_town_stageselect_icon"
        stepName = "ui_distortedSpace_plotmap_round%d.png"
    elseif self.layerType == Game.LevelSelectLayerType.ViKing then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_VIKING)
        iconName = "effect_ui_town_stageselect_icon"
        stepName = "ui_distortedSpace_plotmap_round%d.png"
    elseif self.layerType == Game.LevelSelectLayerType.Titan_Road then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD)
        iconName = "effect_ui_town_stageselect_titans_icon"
        stepName = "ui_selectfloor_plotmap_green_round%d.png"
    elseif self.layerType == Game.LevelSelectLayerType.Titan_Road_Hero then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO)
        iconName = "effect_ui_town_stageselect_hero_icon"
        stepName = nil
    elseif self.layerType == Game.LevelSelectLayerType.Dried_Spring then
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_DRIED_SPRING)
        iconName = "effect_ui_town_stageselect_desert_icon"
        stepName = "ui_selectfloor_plotmap_yellow_round%d.png"
    elseif self.layerType == Game.LevelSelectLayerType.Chaos_WormHole then
        if diff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2 then
            plotList = ConfigManager:getAllLevelSelectDataByTypeSpecial(PublicDefine.CAVE_MODE.MODE_CHAOS)
            iconName = "effect_ui_town_stageselect_hundun_icon"
            stepName = "ui_distortedSpace_plotmap_round%d.png"
        else
            plotList = ConfigManager:getAllLevelSelectDataByTypeNormal(PublicDefine.CAVE_MODE.MODE_CHAOS)
            iconName = "effect_ui_town_stageselect_hundun_icon"
            stepName = "ui_distortedSpace_plotmap_round%d.png"
        end
        
    else
        plotList = ConfigManager:getAllLevelSelectDataByType(PublicDefine.CAVE_MODE.MODE_DESERT_EYES)
        iconName = "effect_ui_town_stageselect_desert_icon"
        stepName = "ui_selectfloor_plotmap_yellow_round%d.png"
    end
    local isLockedLastBtn = false
    local fixPos = {}
    local fixPosTarget = nil
    for  k, v in pairs(plotList) do
        if table.nums(v.includeLevel) > 0 then     
            for k2, v2 in ipairs(v.includeLevel) do
                local posStr = v.coordinate[k2]
                local posArray = string.split(posStr, ",")
                local node = self:createLevelBtn(UI.LevelSelectNormalBtn, parent, v2, tonumber(posArray[1]), tonumber(posArray[2]), iconName, oldLevel, curLevel, clickCallback, animEndCallback, animStartCallback)
                table.insert(self.levelBtnList, node)
                if isLockedLastBtn == false and normalChoiceLevel == nil then
                    if node.state == SpineIconStatus.locked then
                        fixPosTarget = clone(fixPos)
                    elseif  node.state == SpineIconStatus.haveUnLocked and normalChoiceLevel == nil then
                        self.defaultNomalSelectIcon = node
                    end
                end
                if(normalChoiceLevel == v2) then 
                    self.defaultNomalSelectIcon = node
                    fixPosTarget = clone(fixPos)
                end

                fixPos.x = tonumber(posArray[1])
                fixPos.y = tonumber(posArray[2])
                isLockedLastBtn = node.state == SpineIconStatus.locked and true or false
                if stepName and v.connectionLineCoordinate ~= nil and v.connectionLineCoordinate ~= "" then
                    self:createStepPoint(v2, v.connectionLineCoordinate[k2], stepName, parent, oldLevel)
                end
            end
            if fixPosTarget ~= nil then
                self:autoFixCurBtn(fixPosTarget.x, fixPosTarget.y, scrollview, parent)
            else
                self:autoFixCurBtn(fixPos.x, fixPos.y, scrollview, parent) --//如果 没有  就锁定到最后一个
            end
            if self.layerType ~= Game.LevelSelectLayerType.Pet_Adventure then
                local posArray = string.split(v.namecoordinate[1], ",")
                local plotName = UI.Text:create()
                plotName:init(v.name, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_243_230_213)
                plotName:leftBottom(tonumber(posArray[1]) - plotName:getContentSize().width / 2, tonumber(posArray[2]))
                plotName:setName("plotName"..k)
                parent:addChild(plotName)  
                local cloundArray = string.split(v.mistycoordinate[1], ",")  
                local cloud = self:createCloud(parent, v, tonumber(cloundArray[1]), tonumber(cloundArray[2]), oldLevel, curLevel)
                table.insert(self.cloudList, cloud)
            end
            
        else
            local cloundArray = string.split(v.mistycoordinate[1], ",")  
            local cloud = self:createCloud(parent, v, tonumber(cloundArray[1]), tonumber(cloundArray[2]), oldLevel, curLevel)
            table.insert(self.cloudList, cloud)
        end 
    end
    if self.defaultNomalSelectIcon == nil then 
        self.defaultNomalSelectIcon = self.levelBtnList[1]
    end
    if self.defaultNomalSelectIcon then
        self.defaultNomalSelectIcon:selected()
    end
end

function SuperLevelSelect:autoFixCurBtn(posX, posY, scrollView, innerLayer)
    if posX == nil or posY == nil then
        return
    end
    local halfViewWidth = scrollView:getContentSize().width / 2
    if posX < halfViewWidth then
        return
    end
    posX = posX - halfViewWidth
    scrollView:scrollToPercentHorizontal(posX / (innerLayer:getContentSize().width -scrollView:getContentSize().width) * 100)
end

function SuperLevelSelect:showOpenAnimation(oldOpenLevel, curOpenLevel)
    local toShopLevel = 0;
    oldOpenLevel = oldOpenLevel <= 0 and 1 or oldOpenLevel
    if oldOpenLevel + SHOP_INTERVAL <= curOpenLevel then
        toShopLevel = oldOpenLevel + SHOP_INTERVAL
    else
        return
    end
    local fromNode = nil
    local toNode = nil
    for k, v in ipairs(self.levelBtnList) do
        if v:getTag() == oldOpenLevel then
            fromNode = v
        end
        if v:getTag() == toShopLevel then
            toNode = v
        end
        if toNode ~= nil and fromNode ~= nil then
            break
        end
    end
    self:playStepAnimation(fromNode, toNode)
end

--[[
   根据配置播放解锁脚步
]]
function SuperLevelSelect:playStepAnimation(beginNode, endNode)
     -- print("--------LevelSelect:playStepAnimation")
    if beginNode == nil or endNode == nil then
        return
    end
    local stepPoint = self.stepPoint[beginNode:getTag()]
    for k, v in ipairs(stepPoint) do
        v:show()
        v:setOpacity(0)
    end
    local size = #stepPoint 
    for k, v in ipairs(stepPoint) do
        if k == size then
            v:runAction(cc.Sequence:create(cc.DelayTime:create((k - 1) * 0.35), cc.FadeIn:create(0.5), cc.CallFunc:create(function()
                -- endNode:showStepEndAnimation()
            end)))
        else
            v:runAction(cc.Sequence:create(cc.DelayTime:create((k - 1) * 0.35), cc.FadeIn:create(0.5)))
        end
    end
end


function SuperLevelSelect:createScrollView(layerType, width, height,isReplace)
    print("---createScrollView-layerType-----", layerType,width)
    if isReplace then
        self.layerType = layerType
    end
    local scrollView = UI.ScrollView:create()
    scrollView:init(0, 0, 0, 0)
    scrollView:setSize(width or ScrollViewSize.width, height or ScrollViewSize.height)
    scrollView:centerUp(10)
    scrollView:setScrollType(UI.ScrollType.HORIZONTAL)
    scrollView:setBounceEnabled(true)
    scrollView:setMaxBound(maxBoundValue)


    local layout = UI.TouchLayout:create()
    layout:init(0, 0, 0, 0)
    scrollView:addInnerNode(layout)

    local width  = 0
    local colorBgList = {}
    local fileName = "image/levelSelect/ui_selectfloor_plotmap_1.png"
    if layerType == Game.LevelSelectLayerType.Desert_Eye then
        fileName = "image/levelSelect/ui_selectfloor_plotmap_desert.png"
        scrollView:setSwallowTouches(false)
        scrollView:setScrollViewTouchEnabled(false)
    elseif layerType == Game.LevelSelectLayerType.Distorted_Space then
        fileName = "image/levelSelect/ui_distortedSpace_map_1.png"
    elseif layerType == Game.LevelSelectLayerType.Inferno then
        fileName = "image/levelSelect/ui_inferno_map_1.png"
    elseif layerType == Game.LevelSelectLayerType.Pet_Adventure then
        fileName = "image/levelSelect/ui_petsadventure_heromap_2.png"
    elseif layerType == Game.LevelSelectLayerType.VoidRift then
        fileName = "image/levelSelect/ui_uncharted_map_1.png"
    elseif layerType == Game.LevelSelectLayerType.ViKing then
        fileName = "image/levelSelect/ui_Reincarnation_map_1.png"
    elseif layerType == Game.LevelSelectLayerType.Titan_Road then
        fileName = "image/levelSelect/ui_selectfloor_plotmap_1.png"
    elseif layerType == Game.LevelSelectLayerType.Dried_Spring then
        fileName = "image/levelSelect/ui_selectfloor_plotmap_desert.png"
        scrollView:setSwallowTouches(false)
        scrollView:setScrollViewTouchEnabled(false)
    elseif layerType == Game.LevelSelectLayerType.Chaos_WormHole then
        fileName = "image/levelSelect/ui_chaoswormhole_bg_map_1.png"
    end
    local colorBg = cc.Sprite:create()
    colorBg:setAnchorPoint(0, 0)
    colorBg:initWithFile(fileName)
    colorBg:setPosition(width + colorBg:getContentSize().width / 2, colorBg:getContentSize().height / 2)
    colorBg:setName("colorBg")
    width = width + colorBg:getContentSize().width
    table.insert(colorBgList, colorBg)
    if layerType == Game.LevelSelectLayerType.Normal_Plot or layerType == Game.LevelSelectLayerType.Hero_Plot then
        self:addBouncePic(colorBg, "image/levelSelect/ui_selectfloor_plotmap_3.png", "image/levelSelect/ui_selectfloor_plotmap_2.png");
        layout:setSize(width + 250, height or ScrollViewSize.height)
    elseif layerType == Game.LevelSelectLayerType.Distorted_Space then
        self:addBouncePic(colorBg, "image/levelSelect/ui_distortedSpace_map_3.png", "image/levelSelect/ui_distortedSpace_map_2.png");
        layout:setSize(width + 160, height or ScrollViewSize.height)
    elseif layerType == Game.LevelSelectLayerType.Inferno then
        self:addBouncePic(colorBg, "image/levelSelect/ui_inferno_map_3.png", "image/levelSelect/ui_inferno_map_2.png");
        layout:setSize(width + 160, height or ScrollViewSize.height)
    elseif layerType == Game.LevelSelectLayerType.Pet_Adventure then
        self:addBouncePic(colorBg, "image/levelSelect/ui_petsadventure_heromap_1.png", "image/levelSelect/ui_petsadventure_heromap_3.png");
        layout:setSize(width + 360, height or ScrollViewSize.height)
    elseif layerType == Game.LevelSelectLayerType.VoidRift then
        self:addBouncePic(colorBg, "image/levelSelect/ui_uncharted_map_3.png", "image/levelSelect/ui_uncharted_map_2.png");
        layout:setSize(width + 160, height or ScrollViewSize.height)
    elseif layerType == Game.LevelSelectLayerType.ViKing then
        self:addBouncePic(colorBg, "image/levelSelect/ui_Reincarnation_map_3.png", "image/levelSelect/ui_Reincarnation_map_2.png");
        layout:setSize(width + 160, height or ScrollViewSize.height)
    elseif layerType == Game.LevelSelectLayerType.Titan_Road then
        self:addBouncePic(colorBg, "image/levelSelect/ui_selectfloor_plotmap_3.png", "image/levelSelect/ui_selectfloor_plotmap_2.png");
        layout:setSize(width + 250, height or ScrollViewSize.height)
    elseif layerType == Game.LevelSelectLayerType.Titan_Road_Hero then
        self:addBouncePic(colorBg, "image/levelSelect/ui_selectfloor_plotmap_3.png", "image/levelSelect/ui_selectfloor_plotmap_2.png");
        layout:setSize(width + 250, height or ScrollViewSize.height)
    elseif layerType == Game.LevelSelectLayerType.Chaos_WormHole then
        self:addBouncePic(colorBg, "image/levelSelect/ui_chaoswormhole_bg_map_3.png", "image/levelSelect/ui_chaoswormhole_bg_map_2.png");
        layout:setSize(width, height or ScrollViewSize.height)
    else
        layout:setSize(width, height or ScrollViewSize.height)
    end
   
    for k, v in ipairs(colorBgList) do
        layout:addChild(v)
    end
    return scrollView, layout
end

function SuperLevelSelect:addBouncePic(node, imagePath1, imagePath2)
    local left = cc.Sprite:create(imagePath1)
    left:setAnchorPoint(1, 0)
    --left:setPositionX(0.5)
    node:addChild(left)

    local right = cc.Sprite:create(imagePath2)
    right:setAnchorPoint(0, 0)
    right:setPositionX(node:getContentSize().width)
    node:addChild(right)

end


function SuperLevelSelect:createFisrtPassPanel()
    if not CONFIG_FIRST_PASS then
        return
    end
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(255, 60)

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    line:setContentSize(225, 2)
    line:setAnchorPoint(0, 0)
    line:setPosition(17, -7)
    panel:addChild(line)    

    local name = UI.Text:create()
    name:init(UI.TEXT_1212921, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    name:leftBottom(150 - name:getContentSize().width / 2, 26)
    panel:addChild(name, 10)

    local flag = UI.Image:create()
    flag:init("symbol_gaming_atk.png")
    flag:leftBottom(name:getLeft(), 2)
    panel:addChild(flag, 10)
    flag:setName("Flag")
 
    local progress = UI.Text:create()
    progress:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    progress:leftBottom(145, 2)
    panel:addChild(progress, 10)
    progress:setName("Progress")

    local icon = panel:getChildByName("ICON")
    if icon then
        icon:removeFromParent()
    end
    icon = UI.Image:create()
    icon:init("ui_selectfloor_firstclean_2_0.png")
    icon:leftBottom(40, -6)
    panel:addChild(icon)
    return panel
end

function SuperLevelSelect:refreshFisrtPassPanel(panel, mode, diff, selectLevel)
    print("----refreshFisrtPassPanel----")
    -- print(debug.traceback())
    if panel == nil then
        return
    end
    local maxLevelData = nil
    if mode == PublicDefine.CAVE_MODE.MODE_HERO or mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        maxLevelData = GameDataManager:getMaster():getMaxLevelData(mode, diff, selectLevel)
    else
        maxLevelData = GameDataManager:getMaster():getMaxLevelData(mode, diff)
    end
    local maxLevel = selectLevel + SHOP_INTERVAL - 1
    if mode == PublicDefine.CAVE_MODE.MODE_HERO or mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        maxLevel = selectLevel + HERO_INTERVAL - 1
    end

    local noBackMaxLevel = selectLevel
    if maxLevelData ~= nil then
        noBackMaxLevel = maxLevelData:getNoBackMaxLevel()
    end
    local curLevel = noBackMaxLevel > maxLevel and maxLevel or noBackMaxLevel
    curLevel = curLevel < selectLevel and selectLevel or curLevel
    local battlePassList = MasterDataManager:getBattlePassData(mode, diff, maxLevel, curLevel)
    local isReceive = false
    for k, v in ipairs(battlePassList) do
        if maxLevel == v.level then
             isReceive = v.isRecived
            break
        end
    end
    local icon = panel:getChildByName("ICON")
    if icon then
        icon:removeFromParent()
    end
    if curLevel < maxLevel then
        icon = UI.Image:create()
        icon:init("ui_selectfloor_firstclean_2_0.png")
        icon:leftBottom(40, -6)
        panel:addChild(icon)
    elseif isReceive then
        icon = UI.Image:create()
        icon:init("ui_selectfloor_firstclean_2_2.png")
        icon:leftBottom(40, -6)
        panel:addChild(icon)
    else
        icon = UI.Animation:create()
        icon:init("effect_ui_twon_shoutong.json", "effect_ui_twon_shoutong.atlas", 1);
        icon:leftBottom(40, -6)
        icon:setSize(66, 66)
        panel:addChild(icon)
        icon:setAnimation("idle", true)
    end
    icon:setName("ICON")
    icon:setTouchEnable(true)
    icon:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        require "app.ui.town.FirstPassPanel"
        local firstPassPanel = UI.FirstPassPanel:create()
        firstPassPanel:init(mode, diff, maxLevel, curLevel)
        firstPassPanel:center()
        self:addChild(firstPassPanel, 100)
    end)
    print("----curLevel < maxLevel--", curLevel, maxLevel, isReceive)
    local progress = panel:getChildByName("Progress")
    local flag = panel:getChildByName("Flag")
    flag:show()
    progress:leftBottom(145, 2)
    if curLevel < maxLevel then
        if mode == PublicDefine.CAVE_MODE.MODE_HERO or mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            progress:setText(string.format("%d/%d", curLevel % HERO_INTERVAL, HERO_INTERVAL))
        else
            progress:setText(string.format("%d/%d", curLevel, maxLevel))
        end

        progress:setFontColor(UI.FONT_COLOR_102_51_51)
    elseif isReceive then
        flag:hide()
        progress:leftBottom(115, 2)
        progress:setText(UI.TEXT_1110721)
        progress:setFontColor(UI.FONT_COLOR_51_51_51)
    else
        progress:setText("MAX")
        progress:setFontColor(UI.FONT_COLOR_80_168_107)
    end
end

function SuperLevelSelect:clearBtnList()
    self.levelBtnList = {}
    self.stepPoint = {}
end

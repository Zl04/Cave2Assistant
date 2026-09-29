-- QuickSideBarTaskCell.lua
-- Author:lzm
-- Using:侧边栏task cell

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
UI = UI or {}

local QuickSideBarTaskCell = class("QuickSideBarTaskCell", UI.HWBtnComponent)
UI.QuickSideBarTaskCell = QuickSideBarTaskCell

local COM_WIDTH = 232
local COM_HEIGHT = 70

--构造函数(必备)
function QuickSideBarTaskCell:ctor()
    QuickSideBarTaskCell.super.ctor(self)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SIDEBAR_CELL_CANCEL_CLICK, self, self.cellCancelClick)
end

--虚构函数,destroy时调用(必备)
function QuickSideBarTaskCell:dtor()
    QuickSideBarTaskCell.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SIDEBAR_CELL_CANCEL_CLICK, self, self.cellCancelClick)
end

-- 初始化(必备)
function QuickSideBarTaskCell:init(data)
    self.recordingMove = false
    self.cellFinalH = 0

    QuickSideBarTaskCell.super.init(self)
    self._data = data

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    -- cellLayout:enableDebugDraw()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    local taskType = self._data:getTaskType()
    local typeText,iconName, typeColor = self:getTextOrNameOrColor()

    -- 图标
    local icon = UI.Image:create()
    icon:init("symbol_gaming_xp.png")
    icon:leftUp(10, 0)
    self.cellLayout:addChild(icon, 2)
    self._icon = icon
    self._icon:setVisible(false)

    -- 类型
    local typeTxt = UI.Text:create()
    typeTxt:init(typeText, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    self.cellLayout:addChild(typeTxt, 1)
    typeTxt:setVisible(false)
    self._typeText = typeTxt
    self.typeTxtW, self.typeTxtH = typeTxt:getSize()

    local offsetX = 24
    self.tmpRichTextW = 0

    local cellBG = cc.Scale9Sprite:createWithSpriteFrameName("ui_tast_btn_0.png")
    cellBG:setContentSize(213, 125)
    cellBG:setCapInsets(CCRectMake(106,63,1,1))
    cellBG:setPosition(126, 0)
    cellBG:show()
    self.cellLayout:addChild(cellBG, 1)
    self.cellBG = cellBG

    local cellBGFinish = cc.Scale9Sprite:createWithSpriteFrameName("ui_tast_btn_1.png")
    cellBGFinish:setContentSize(213, 125)
    cellBGFinish:setCapInsets(CCRectMake(106,63,1,1))
    cellBGFinish:setPosition(126, 0)
    cellBGFinish:hide()
    self.cellLayout:addChild(cellBGFinish, 1)
    self.cellBGFinish = cellBGFinish

    self.finishTxt = UI.Text:create()
    self.finishTxt:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_35_127_63)
    self.finishTxt:hide()
    self.finishTxt:autoAdapt()
    self.cellLayout:addChild(self.finishTxt, 4)

    -- 分隔条
    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(180, 1)
    splitLine:setCapInsets(CCRectMake(1,0,1,1))
    self.cellLayout:addChild(splitLine, 5)
    self.splitLine = splitLine

    -- 任务描述
    local descTxt = UI.Text:create()
    descTxt:init(self._data:getDescription(), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_155_155_155)
    descTxt:setWidth(184-20)
    descTxt:leftUp(36, self.cellFinalH)
    descTxt:autoAdapt()
    self.cellLayout:addChild(descTxt, 6)
    self.descTxt = descTxt

    self.descTxtW, self.descTxtH = self.descTxt:getSize()

    local finalCellH = self:updateTaskProgress(self._data)
    return finalCellH
end

function QuickSideBarTaskCell:getIsReceive()
    if(self._data:isCycle() 
        or self._data:isDistortedSpace()
        or self._data:isInferno()
        or self._data:isVoidRift()
        or self._data:isViKing()) then 
        return false
    end

    return true
end

function QuickSideBarTaskCell:cellCancelClick()
    if self.recordingMove then
        self.cancelClick = true
    end
end

-- local TaskTargetType ={
--     Kill = 1;    --杀怪
--     Golden = 2;  --点金
--     Talk = 3;    --对话
--     Explore = 4; --探索
--     Share = 5;   --分享
--     Collect = 6; --收集
--     Achievement = 7; --成就
--     Follow = 8; --关注
--     Strengthen = 9; --强化
--     Enchant = 10; --附魔
--     Bind = 11; --绑定任务
-- }
function QuickSideBarTaskCell:clickHandler()
    local targetType = self._data:getTargetType()
    local targetID = self._data:getTargetID()
    if SceneManager:getInstance():isInFightScene() then
        -- add by zp CO-14439【正式服】战斗中可以打开分享按钮，能触发各种BUG
        if RoleBehaviorManager:checkMasterIsInBattle() then 
            UI.ScrollBar:createByText(UI.TEXT_1212708)
            return
        end

        -- 洞内
        if self._data:getIsFinish() then
            UI.ScrollBar:createByText(UI.TEXT_1213233)
        else
            if self._data.taskType == PublicDefine.TaskType.CaveHero or
                self._data.taskType == PublicDefine.TaskType.Plot or
                self._data.taskType == PublicDefine.TaskType.DistortedSpace or
                self._data.taskType == PublicDefine.TaskType.Inferno or
                self._data.taskType == PublicDefine.TaskType.Cycle or
                self._data.taskType == PublicDefine.TaskType.VoidRift or
                self._data.taskType == PublicDefine.TaskType.ViKing then
                -- 剧情任务、英雄模式任务、扭曲空间个人任务:提示描述
                UI.ScrollBar:createByText(self._data:getDescription())
                return
            end

            if targetType == PublicDefine.TaskTargetType.Kill then
                -- 击杀任务：该怪物属于本层，提示击败该怪物；如果不在本层，提示该怪物不在这里
                local mapData = GameMapManager:getInstance():getMapData()
                local caveMode = mapData.caveMode
                local difficult = mapData.difficulty
                local level = mapData.level
                local caveLevel = GameDataManager:_getCaveLevel(caveMode, level)
                local targetMonsterID = targetID%1000000000

                if caveMode == 2 then
                    -- 深渊不需要去读表
                    UI.ScrollBar:createByText(UI.TEXT_1213232)
                    return
                end

                local mapConfig = ConfigManager:getMapLevelConfig(caveLevel, caveMode, difficult)
                local found = false
                if mapConfig then
                    local monsterID = mapConfig.monsterID

                    for _, v in ipairs(mapConfig.monsterID) do
                        if v == targetMonsterID then
                            found = true
                            break
                        end
                    end
                end

                if found then
                    UI.ScrollBar:createByText(self._data:getName())
                else
                    UI.ScrollBar:createByText(UI.TEXT_1213232)
                end
            elseif targetType == PublicDefine.TaskTargetType.Golden then
                -- 点金任务：提示“请寻找点金神像点金”
                UI.ScrollBar:createByText(UI.TEXT_1213234)
            elseif targetType == PublicDefine.TaskTargetType.Enchant then
                -- 附魔任务：提示“请寻找附魔台附魔”
                UI.ScrollBar:createByText(UI.TEXT_1213235)
            elseif targetType == PublicDefine.TaskTargetType.Strengthen then
                -- 强化任务：提示“请回城镇后进行强化”
                UI.ScrollBar:createByText(UI.TEXT_1213236)
            elseif targetType == PublicDefine.TaskTargetType.Share then
                -- 分享任务：打开背包界面，展示分享条
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_BAG_PANEL_OPEN_SHARE)
            elseif targetType == PublicDefine.TaskTargetType.Achievement then
                -- 成就任务：提示“请达成成就XXX”
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Talk then
                -- 对话任务：提示任务描述
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Explore then
                -- 进度任务：提示“请前往XXX”
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Collect or targetType == PublicDefine.TaskTargetType.Follow then
                -- 其他任务：提示任务描述
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Bind then
                -- 绑定账号
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND)
            end
        end
    elseif SceneManager:getInstance():isNotInFightScene() then
        -- 城镇
        -- local CAVE_MODE = {
        --     MODE_NORMAL = 1;     -- 时光之门（普通模式）
        --     MODE_HERO = 4;       -- 时光之门（英雄模式）
        --     MODE_DESERT_EYES = 8;   --沙之眼 模式
        --     MODE_DISTORTED_SPACE = 9;   --扭曲空间
        -- }
        if self._data:getIsFinish() then
            -- 任务完成
            -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SIDEBAR_HIDE)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_FUNCTION_PANEL)
        else
            if self._data.taskType == PublicDefine.TaskType.CaveHero then
                if SceneManager:getInstance():isGuild() then
                    UI.ScrollBar:createByText(UI.TEXT_1213237)
                else
                    -- 通关任务：打开副本界面
                    self:openLevelSelect(PublicDefine.CAVE_MODE.MODE_HERO)
                end
                return
            end

            if targetType == PublicDefine.TaskTargetType.Kill then
                if self._data.taskType == PublicDefine.TaskType.Plot or
                    self._data.taskType == PublicDefine.TaskType.DistortedSpace or
                    self._data.taskType == PublicDefine.TaskType.Inferno or
                    self._data.taskType == PublicDefine.TaskType.Cycle or 
                    self._data.taskType == PublicDefine.TaskType.VoidRift or
                    self._data.taskType == PublicDefine.TaskType.ViKing then
                    -- 剧情任务、英雄模式任务、扭曲空间个人任务:提示描述
                    UI.ScrollBar:createByText(self._data:getDescription())
                    return
                end

                -- 击杀任务：打开副本界面
                if SceneManager:getInstance():isGuild() then
                    UI.ScrollBar:createByText(UI.TEXT_1213237)
                else
                    local config = ConfigManager:getTaskConfigForTaskID(self._data.taskID)
                    local caveMode = math.floor(config.taskGroupID/10000)
                    self:openLevelSelect(caveMode)
                end
            elseif targetType == PublicDefine.TaskTargetType.Golden then
                -- 点金任务：提示“请寻找点金神像点金”
                UI.ScrollBar:createByText(UI.TEXT_1213231)
            elseif targetType == PublicDefine.TaskTargetType.Enchant then
                -- 附魔任务：直接打开附魔台界面
                local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.ENCHANT)
                if spriteID then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_IN_CAVE_ENCHANTMENT, spriteID)
                else
                    UI.ScrollBar:createByText(UI.TEXT_1213237)
                end
            elseif targetType == PublicDefine.TaskTargetType.Strengthen then
                -- 强化任务：直接打开强化界面
                local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.EQUIPMENT_STRENGTHEN)
                if spriteID then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_STRENGTHEN, spriteID)
                else
                    UI.ScrollBar:createByText(UI.TEXT_1213236)
                end
            elseif targetType == PublicDefine.TaskTargetType.Share then
                -- 分享任务：打开背包界面，展示分享条
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_BAG_PANEL_OPEN_SHARE)
            elseif targetType == PublicDefine.TaskTargetType.Achievement then
                -- 成就任务：提示“请达成成就XXX”
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Talk then
                -- 对话任务：在小地图上添加提示标识
                local machine = MachineManager:getInstance():getMachine()
                local modelArr = {}
                if(machine and machine._model) then 
                    modelArr = machine._model:getNpcsForTemplateID(targetID)
                end
                if #modelArr > 0 then
                    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_OPEN_BIG_MAP, targetID)
                else
                    UI.ScrollBar:createByText(self._data:getDescription())
                end
            elseif targetType == PublicDefine.TaskTargetType.Explore then
                -- 进度任务：打开副本界面
                if SceneManager:getInstance():isGuild() then
                    UI.ScrollBar:createByText(UI.TEXT_1213237)
                else
                    local caveMode = math.floor(targetID/1000000)
                    self:openLevelSelect(caveMode)
                end
            elseif targetType == PublicDefine.TaskTargetType.Collect or targetType == PublicDefine.TaskTargetType.Follow then
                -- 其他任务：提示任务描述
                UI.ScrollBar:createByText(self._data:getDescription())
            elseif targetType == PublicDefine.TaskTargetType.Bind then
                -- 绑定账号
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SETTING_SHOW_ACCOUNT_BIND)
            elseif targetType == PublicDefine.TaskTargetType.OpenUI then
                --print("PublicDefine.TaskTargetType.OpenUI", targetID)
                -- 打开页面
                if Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(targetID) then
                    local MachineManager = require("app.game.MachineManager")
                    local machine = MachineManager:getInstance():getMachine()
                    local isActivateFuncSucc = machine:_openUIByFunctionType(targetID)
                    if(not isActivateFuncSucc 
                        and not SceneManager:getInstance():checkFunctionCondition(targetID)) then
                        UI.ScrollBar:createByText(self._data:getDescription())
                    end
                else
                    local cfgData = ConfigManager:getFunctionUnlockCfgData(Game.FunctionUnlockManager:getInstance():npcTypeToLockType(targetID))
                    if cfgData then
                        UI.ScrollBar:createByTextID(cfgData.unlockdes)
                        return 
                    end
                end
            end
        end
    end
end

function QuickSideBarTaskCell:getSpriteID(functionType)
    local machine = MachineManager:getInstance():getMachine()
    local modelArr = {}
    if(machine and machine._model) then 
        modelArr = machine._model:getAllFunctionNpcArr()
    end
    for _, v in ipairs(modelArr) do 
        local spriteID = v:getSpriteID()
        local typeArr = nil
        if(GameManager:getIsInNewScene()) then
            typeArr = v:getNpcData():getAllFunctionType()
        else
            typeArr = v:getNpcData():getFunctionTypeArr()
        end
        if typeArr then
            for _, funcType in ipairs(typeArr) do
                if funcType == functionType then
                    return spriteID
                end
            end
        end
    end

    if SceneManager:getInstance():checkFunctionCondition(functionType) then
        return 0
    end

    return nil
end

function QuickSideBarTaskCell:openLevelSelect(caveMode)
    if caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
        -- 普通模式
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Normal_Plot)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        -- 英雄模式
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Normal_Plot, PublicDefine.CAVE_MODE.MODE_HERO)    
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
        -- 沙之眼
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.DESERT_EYE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Desert_Eye)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
        -- 扭曲空间
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.DISTORTED_SPACE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
        -- 元素炼狱
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.MODE_INFERNO)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("Cave", "InfernoLevelSelect")
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
        -- 虚空秘境
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.MODE_VOID_RIFT)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("Cave", "VoidRiftLevelSelect")
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_VIKING then
        -- 维京时代
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.MODE_VIKING)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("ViKing", "ViKingLevelSelect")
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
        -- 泰坦之路
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Titan_Road)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        -- 英雄模式
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Titan_Road, PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        -- 干涸之泉
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.DESERT_EYE)
        Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Dried_Spring)
    elseif caveMode == PublicDefine.CAVE_MODE.MODE_CHAOS then
        -- 混沌虫洞
        local spriteID = self:getSpriteID(PublicDefine.FUNCTION_TYPE.FUNCTION_CHAOS)
        -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, spriteID, Game.LevelSelectLayerType.Distorted_Space)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
        mvc.openPanel("ChaosWormHole", "ChaosWormHoleLevelSelect")
    end
end

function QuickSideBarTaskCell:updateTaskProgress(data, onlyHeight)
    self._data = data
    if(self._data == nil) then  return end
    local offsetX = 24

    local typeText,iconName, typeColor = self:getTextOrNameOrColor()
    -- 图标
    if iconName then
        self._icon:setSpriteName(iconName)
        self._icon:setVisible(true) 
    else
        self._icon:setVisible(false) 
    end

    if(self._taskRichText) then 
        self._taskRichText:removeFromParent()
        self._taskRichText = nil
    end

    if(not onlyHeight) then
        local formatedTypeText = AvalonUtil:serializeText(typeText, typeColor, UI.FONT_SIZE_16PX, UI.FONT_STANDARD)
        local content = AvalonUtil:formartRichText(UI.FONT_COLOR_194_194_194, UI.FONT_SIZE_16PX, UI.FONT_STANDARD, 
            "%s"..self._data:getName(), formatedTypeText)
        local taskRichText = UI.RichText:create()
        taskRichText:init(content, 184, 20, false)
        taskRichText:leftUp(12+offsetX, 0)
        self._taskRichText = taskRichText
        self.cellLayout:addChild(taskRichText, 3)
    end

    if(self._typeText) then 
        local typeTextMaxWidth = 184
        self._typeText:setText(typeText..self._data:getName())
        self._typeText:autoAdapt()
        local typeTotalHeight = self._typeText:getContentSize().height
        self.tmpRichTextW = self._typeText:getContentSize().width
        
        if(self._typeText:getContentSize().width > typeTextMaxWidth) then 
            typeTotalHeight = (math.floor(self._typeText:getContentSize().width / typeTextMaxWidth) + 1) * self.typeTxtH
        end
        self.richTxtH = typeTotalHeight
    end

    self.cellFinalH = 0
    self.cellFinalH = self.cellFinalH + self.richTxtH
    self.diffH = self.richTxtH

    local needFinTxt = false
    self.finishTxt:hide()
    self.finishTxt:setText("")
    if self._data:getIsFinish() then
        -- 已完成
        self.finishTxt:setText(UI.TEXT_1213246)
        self.finishTxt:setFontColor(UI.FONT_COLOR_35_127_63)
        self.cellBG:hide()
        self.cellBGFinish:show()

        needFinTxt = true
    else
        if self._data:getTargetNum() > 1 then
            -- 进度显示
            local prgTxet = self._data:getReachNum() .. "/" .. self._data:getTargetNum()
            self.finishTxt:setText(prgTxet)
            self.finishTxt:setFontColor(UI.FONT_COLOR_194_194_194)

            needFinTxt = true
        end
        self.cellBG:show()
        self.cellBGFinish:hide()
    end

    if needFinTxt then
        local finishTxtW, finishTxtH = self.finishTxt:getSize()
        local firstLineTotalLen = offsetX + self.tmpRichTextW + finishTxtW
        local rightOffset = 16
        if firstLineTotalLen > 184 then
            if self.tmpRichTextW > 184 then
                local lineNum = math.floor(firstLineTotalLen/184)
                self.finishTxt:rightUp(rightOffset, lineNum*self.typeTxtH)
            else
                self.finishTxt:rightUp(rightOffset, self.typeTxtH)
                self.cellFinalH = self.cellFinalH + self.typeTxtH
                self.diffH = self.diffH + self.typeTxtH
            end
        else
            self.finishTxt:rightUp(rightOffset, 0)
        end
        self.finishTxt:setTextRight()
        self.finishTxt:autoAdapt()
        self.finishTxt:show()
    end

    -- 任务描述
    self.descTxt:setText(self._data:getDescription())
    self.descTxt:leftUp(36, self.cellFinalH)
    self.descTxt:autoAdapt()
    self.descTxtH = self.descTxt:getContentSize().height
    self.cellFinalH = self.cellFinalH + self.descTxtH + 4

    self.cellLayout:setSize(COM_WIDTH, self.cellFinalH)
    self:setSize(COM_WIDTH, self.cellFinalH+10)

    self.cellBG:setContentSize(213, self.cellFinalH+4)
    self.cellBG:setPosition(112, (self.cellFinalH+4)/2)
    self.cellBGFinish:setContentSize(213, self.cellFinalH+4)
    self.cellBGFinish:setPosition(112, (self.cellFinalH+4)/2)
    self.splitLine:setPosition(124, self.cellFinalH-self.diffH)

    return self.cellFinalH+10
end

function QuickSideBarTaskCell:getTextOrNameOrColor()
    local typeText = ""
    local iconName = nil
    local typeColor = nil
    if(self._data) then
        local taskType = self._data:getTaskType()

        if taskType == PublicDefine.TaskType.Plot then
            typeText = UI.TEXT_1213238
            typeColor = UI.FONT_COLOR_35_127_63
        elseif taskType == PublicDefine.TaskType.LimitDaily then
            typeText = UI.TEXT_1213239
            iconName = "symbol_gaming_money.png"
            typeColor = UI.FONT_COLOR_200_122_20
        elseif taskType == PublicDefine.TaskType.Guild then
            typeText = UI.TEXT_1213240
            iconName = "symbol_guild_tech_icon_medal.png"
            typeColor = UI.FONT_COLOR_50_120_150
        elseif taskType == PublicDefine.TaskType.Daily then
            if mvc.quickSideBarModel:checkIsExpTask(self._data) then
                typeText = UI.TEXT_1213241
                iconName = "symbol_gaming_xp.png"
                typeColor = UI.FONT_COLOR_22_123_120
            else
                typeText = UI.TEXT_1213242
                typeColor = UI.FONT_COLOR_244_219_46
            end
        elseif taskType == PublicDefine.TaskType.Cycle then
            typeText = UI.TEXT_1213243
            typeColor = UI.FONT_COLOR_29_167_172
        elseif taskType == PublicDefine.TaskType.DistortedSpace then
            typeText = UI.TEXT_1213244
            typeColor = UI.FONT_COLOR_143_73_185
        elseif taskType == PublicDefine.TaskType.Inferno then
            typeText = "["..UI.TEXT_1325502.."]"
            typeColor = UI.FONT_COLOR_143_73_185
        elseif taskType == PublicDefine.TaskType.CaveHero then
            typeText = UI.TEXT_1213245
            typeColor = UI.FONT_COLOR_186_54_28
        elseif taskType == PublicDefine.TaskType.VoidRift then
            typeText = "["..UI.TEXT_1325502.."]"
            typeColor = UI.FONT_COLOR_143_73_185
        elseif taskType == PublicDefine.TaskType.ViKing then
            typeText = "["..UI.TEXT_1325502.."]"
            typeColor = UI.FONT_COLOR_143_73_185
        end
    end

    return typeText, iconName, typeColor
end

-- 模版函数：初始化组建的视图(必备)
function QuickSideBarTaskCell:onInitView()
end

function QuickSideBarTaskCell:getData()
    return self._data;
end

function QuickSideBarTaskCell:getHeight()
    return self.cellFinalH+10
end

function QuickSideBarTaskCell:onUpdateView()

end

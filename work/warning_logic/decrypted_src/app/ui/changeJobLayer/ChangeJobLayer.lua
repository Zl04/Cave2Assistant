-- ChangeJobLayer.lua
-- Author:zp
-- 2018年12月28日
-- Using:转职页面
require "app.ui.shoplayer.BagGoodsPanel"
local ProtobufUtil = require "utils.ProtobufUtil"
require("app.config.ConfigManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local ChangeJobLayer = class("ChangeJobLayer", UI.DoorWin)
UI.ChangeJobLayer = ChangeJobLayer
local winSize = cc.Director:getInstance():getWinSize()
local leftSize = cc.size(373, 630)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_upgrade.plist",
}

--构造函数(必备)
function ChangeJobLayer:ctor(spriteID, taskData)
    --窗口大小
    ChangeJobLayer.super.ctor(
    self,UIType.TYPE_SKILL_ADVANCED,
    COM_RES_LIST,
    leftSize.width,    
    winSize.height
    )
    self.spriteID = spriteID
    self._taskData = taskData
    self.skillUpgradeArr = {}

    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function ChangeJobLayer:dtor()
    ChangeJobLayer.super.dtor(self)
    self.skillUpgradeArr = {}
    self:unRegisterListener()
end

-- 初始化(必备)
function ChangeJobLayer:init()
    ChangeJobLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function ChangeJobLayer:onInitView()
    self.leftLayer = UI.Layout:create();
    self.leftLayer:init()
    self.leftLayer:setSize(leftSize.width, leftSize.height)
    self.leftLayer:leftBottom(-winSize.width, (winSize.height - leftSize.height) / 2)
    self:addChild(self.leftLayer, 3)
    
    --背景
    local bg = UI.Image:create()
    bg:init("ui_upgrade_paper_02.png")
    bg:centerBottom(0)
    self.leftLayer:addChild(bg)
    self._bg = bg

    -- 根据是否转职来调用响应的页面
    if(RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then 
        self:initUpgrade(bg)
    else 
        self:initUpgradeInfo(bg)
    end
end

-- 初始化升级后的显示
function ChangeJobLayer:initUpgradeInfo(bg, change)
    -- 底部背景
    local upBg = UI.Image:create()
    upBg:init("ui_upgrade_paper_03.png")
    upBg:centerUp(0)
    bg:addChild(upBg)

    if(change == nil) then 
        change = false
    end
    if(change)then 
        upBg:setOpacity(0)
        upBg:runAction(cc.FadeIn:create(1))
    end

    -- 标题
    local titleBg = UI.Image:create()
    titleBg:init("ui_upgrade_title_02.png")
    titleBg:centerUp(36)
    upBg:addChild(titleBg)

    -- 根据类型初始化相关的界面
    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1212075, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    titleTxt:center()
    titleBg:addChild(titleTxt)

    -- 中间激活滑动属性
    local skillBlessingDataArr = SkillDataManager:getAllSkillBlessing()
    local scrollayout = UI.TouchLayout:create()
    scrollayout:init()
    scrollayout:setSize(293, 466)
    
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(314, 466)
    scrollView:init()
    scrollView:leftBottom(33, 77)
    scrollView:addInnerNode(scrollayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    upBg:addChild(scrollView, 10)

    local height = 5
    if(skillBlessingDataArr) then 
        
        for k, skillBlessingData in ipairs(skillBlessingDataArr) do 
            local layout = self:createOneSkillBlessing(skillBlessingData)
            if(layout) then 
                layout:centerUp(height)
                scrollayout:addChild(layout)
                height = height + layout:getContentSize().height
            end
        end

    end

    height = height + 20
    -- 添加说明文字
    local desText = UI.Text:create()
    desText:init(UI.TEXT_1212202, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    desText:centerUp(height)
    desText:setWidth(244)
    desText:autoAdapt()
    scrollayout:addChild(desText)
    height = height + desText:getContentSize().height + 10


    if(height > scrollayout:getContentSize().height) then 
        scrollayout:setSize(scrollayout:getContentSize().width, height)
    end

    --
    local mesh = UI.Image:create()
    mesh:init("ui_upgrade_gradually_04.png")
    mesh:centerBottom(76)
    upBg:addChild(mesh, 10)

    -- 详情按钮
    local detailButton = UI.Button:create() 
    detailButton:init()
    detailButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showDetailedInfo)
    detailButton:setSize(50,50)
    detailButton:leftBottom(28, 48)
    upBg:addChild(detailButton,20)

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:center()
    detailButton:addChild(detailAnimation, 10)
end

function ChangeJobLayer:createOneSkillBlessing(data)
    if(data) then
        local layout = UI.Layout:create()
        layout:init()
        local height = 0
        local paddingHeigh = 15
        local left = 0
        local CELL_WIDTH = 244

        local masterData = GameDataManager:getInstance():getMaster()
        if(masterData) then
            -- 计算属性
            local ID = data:getID()
            local upPercent = masterData[PublicDefine.ATTR_TYPE_ID_KEY[ID]]
            -- 这里由于改值是万分比表现需要除以100
            if(upPercent == nil) then 
                upPercent = 0
            end
            upPercent = upPercent /100
            local upPercentStr = ""
            if(upPercent == 0) then 
                upPercentStr = "0"
            else 
                upPercentStr = string.format("%0.2f", upPercent)
            end 
            local titleText = UI.Text:create()
            titleText:init(string.format(data:getDescription(), upPercentStr), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            titleText:leftUp(0, paddingHeigh)
            titleText:setWidth(CELL_WIDTH - 20)
            titleText:autoAdapt()
            -- titleText:enableDebugDraw()
            layout:addChild(titleText)

            local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
            splitLine:setContentSize(287, 1)
            splitLine:setCapInsets(CCRectMake(1,0,1,1))
            splitLine:setAnchorPoint(0, 0)
            splitLine:setPosition(-21.5, 1)
            layout:addChild(splitLine)

            height = height + titleText:getContentSize().height + paddingHeigh * 2
        end


        -- -- 标题
        -- local titleText = UI.Text:create()
        -- titleText:init(data:getName(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        -- titleText:centerUp(height)
        -- layout:addChild(titleText)

        -- local leftOne = UI.Image:create()
        -- leftOne:init("ui_information_banner_background3.png")
        -- leftOne:centerLeft(-(leftOne:getContentSize().width + 10))
        -- titleText:addChild(leftOne, 10)

        -- local leftTwo = UI.Image:create()
        -- leftTwo:init("ui_information_banner_background3.png")
        -- leftTwo:centerLeft(-(leftOne:getContentSize().width * 2 + 13))
        -- titleText:addChild(leftTwo, 10)

        -- local rightOne = UI.Image:create()
        -- rightOne:init("ui_information_banner_background3.png")
        -- rightOne:centerRight(-(rightOne:getContentSize().width + 10))
        -- titleText:addChild(rightOne, 10)

        -- local rightTwo = UI.Image:create()
        -- rightTwo:init("ui_information_banner_background3.png")
        -- rightTwo:centerRight(-(rightOne:getContentSize().width * 2 + 13))
        -- titleText:addChild(rightTwo, 10)

        -- height = height + titleText:getContentSize().height + paddingHeigh

        -- -- 
        -- local attrValue = data:getAttrValue()
        -- local skillBlessing = data:getSkillBlessing()
        -- local masterData = GameDataManager:getInstance():getMaster()
        -- if(masterData) then 
        --     if(attrValue and skillBlessing and #attrValue == #skillBlessing) then 
        --         for i=1,#attrValue do 
        --             local attrTypeArr = data:getAttrType()
        --             local heroAttrValue = 0
        --             for _, attrType in ipairs(attrTypeArr) do 
        --                 heroAttrValue = heroAttrValue + masterData[PublicDefine.ATTR_TYPE_ID_KEY[attrType]]
        --             end

        --             -- print("heroAttrValue= ", data:getDescription(), heroAttrValue, PublicDefine.ATTR_TYPE_ID_KEY[data:getAttrType()])
        --             local fontColor = UI.FONT_COLOR_41_41_45
        --             if((attrValue[i+1] == nil and attrValue[i] <= heroAttrValue) or (attrValue[i] <= heroAttrValue and attrValue[i+1] > heroAttrValue)) then 
        --                 fontColor = UI.FONT_COLOR_36_181_118
        --             end

        --             local percent = skillBlessing[1]
        --             percent = math.floor(percent * 100 / RATIO_NUMBER)

        --             local valueText = UI.Text:create()
        --             valueText:init(string.format(data:getDescription(), tostring(attrValue[i]), tostring(percent)), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, fontColor)
        --             valueText:leftUp(left, height)
        --             valueText:setTextLeft()
        --             valueText:setWidth(CELL_WIDTH)
        --             valueText:autoAdapt()
        --             layout:addChild(valueText)
        --             height = height + valueText:getContentSize().height + paddingHeigh
        --         end

        --         local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
        --         splitLine:setContentSize(287, 1)
        --         splitLine:setCapInsets(CCRectMake(1,0,1,1))
        --         splitLine:setAnchorPoint(0, 0)
        --         splitLine:setPosition(-21.5, 1)
        --         layout:addChild(splitLine)
        --     end
        -- end

        -- height = height + 10

        layout:setSize(CELL_WIDTH, height)

        return layout
    end

    return nil
end

function ChangeJobLayer:initUpgrade(bg)
    -- 底部背景
    local upBg = UI.Image:create()
    upBg:init("ui_upgrade_paper_01.png")
    upBg:centerUp(10)
    bg:addChild(upBg)

    -- 根据类型初始化相关的界面
    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1212080, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    titleTxt:centerUp(33 - titleTxt:getContentSize().height/2)
    upBg:addChild(titleTxt)

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(312, 2))
    splitLine:centerUp(57)
    upBg:addChild(splitLine)

    -- 处理中间的相关升级表现
    -- "ui_information_arrow_right.png"
    local left = 35
    local up = 62
    local yCha = 94
    self.skillUpgradeArr = {}
    self:createOneUpgrade(upBg, "icon-equip_metal_21080010_1.png", "effect_ui_skillprogress_icon_jiandun", left, up)
    up = up + yCha
    self:createOneUpgrade(upBg, "icon-equip_metal_21080010_2.png", "effect_ui_skillprogress_icon_dajian", left, up)
    up = up + yCha
    self:createOneUpgrade(upBg, "icon-equip_metal_21080010_3.png", "effect_ui_skillprogress_icon_fazhang", left, up)


    local scrollayout = UI.TouchLayout:create()
    scrollayout:init()
    -- scrollayout:addTouchEvents(self)
    
    -- 滑动信息展示区域
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(293, 110)
    scrollView:init()
    scrollView:leftBottom(33, 77)
    scrollView:addInnerNode(scrollayout)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    scrollView:setCircleVisible(false)
    scrollView:setScrollBarWidth(5)
    upBg:addChild(scrollView, 10)
    -- scrollView:enableDebugDraw()

    -- 显示下半部分的描述文字
    local textStr = UI.TEXT_1212074
    -- textStr = textStr .. "8示信息转职提示信息转职提示信9息转职提示信息转职提示信息转职提10示信息转职提示信息转职提示信息11转职提示信息转职提示信息转职提示信12息转职提示信息转职提示信息转职13提示信息转职提示信息转职提示信息转职提示信14息转职提示信息转职提示信息转职提示信息15转职提示信息"
    local desTxt = UI.Text:create()
    desTxt:init(textStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    desTxt:centerUp(0)
    desTxt:setWidth(265)
    desTxt:setTextHorizontalCenterAndBottom()
    desTxt:autoAdapt()
    scrollayout:addChild(desTxt)

    local height = desTxt:getContentSize().height + 10
    if(height > 110) then 
        scrollayout:setSize(280, height)
    else 
        scrollayout:setSize(280, 110)
    end 
    scrollayout:centerUp(0)
    desTxt:centerUp(0)

    --
    local mesh = UI.Image:create()
    mesh:init("ui_upgrade_gradually_01.png")
    mesh:leftBottom(33, 77 -1)
    upBg:addChild(mesh, 10)

    local leftUpImage = UI.Image:create()
    leftUpImage:init("ui_information_upgrade.png")
    leftUpImage:leftUp(11, -4)
    upBg:addChild(leftUpImage, 100)

    -- 详情按钮
    local detailButton = UI.Button:create() 
    detailButton:init()
    detailButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showDetailedInfo)
    detailButton:setSize(50,50)
    detailButton:leftBottom(25, 26)
    bg:addChild(detailButton)

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:center()
    detailButton:addChild(detailAnimation, 10)

    -- 添加转职按钮
    local handleButton = UI.Button:create()
    handleButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    handleButton:setText(UI.TEXT_1212077) --"激活"
    handleButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    handleButton:centerBottom(26)
    handleButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        local confirmDialog = UI.ConfirmDialog.show(UI.TEXT_1212076, function()
            handleButton:disable()
            -- 处理转职处理
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetNPCSystem:reqSkillAdvanced(self.spriteID)
            Avalon.AudioManager:playSound("1540", false)
        end)
    end)
    bg:addChild(handleButton)
end

function ChangeJobLayer:createOneUpgrade(upBg, prePicName, endPicName, left, up)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(280, 94)

    local pre = UI.Image:create()
    pre:init(prePicName)
    pre:setScale(0.9)
    pre:centerLeft(10)
    layout:addChild(pre, 10)

    local mesh = UI.Image:create()
    mesh:init("ui_information_arrow_right.png")
    mesh:center()
    layout:addChild(mesh, 10)

    local skillNowAnimation = UI.Animation:create()
    skillNowAnimation:init(endPicName..".json", endPicName..".atlas")
    skillNowAnimation:setAnimation("idle", true)
    skillNowAnimation:centerRight(10 + 51)
    layout:addChild(skillNowAnimation, 10)
    table.insert(self.skillUpgradeArr, skillNowAnimation)

    -- local endImage = UI.Image:create()
    -- endImage:init(endPicName)
    -- endImage:centerRight(10)
    -- layout:addChild(endImage, 10)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine:setContentSize(292, 1)
    splitLine:setCapInsets(CCRectMake(1,0,1,1))
    splitLine:setAnchorPoint(0, 0)
    splitLine:setPosition(0, 1)
    layout:addChild(splitLine)

    layout:leftUp(left, up)
    upBg:addChild(layout)
end

-- 模版函数：更新组建的视图(必备)
function ChangeJobLayer:onUpdateView()

   self:setDoorNode(self.leftLayer, nil)
end

function ChangeJobLayer:showDetailedInfo()
    -- 显示详情界面
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_UPGRADE_INFO, self.spriteID, false, self)
end

function ChangeJobLayer:advancedCallBack(data)
    -- print("ChangeJobLayer:advancedCallBack 0", data.result, ProtobufUtil:enum_id("NPCSystem.SkillAdvancedReuslt", "SkillAdvancedReuslt_Ok"))
    UI.WaitingLayer:hideWaiting()
    if data.result == ProtobufUtil:enum_id("NPCSystem.SkillAdvancedReuslt", "SkillAdvancedReuslt_Ok") then
        -- print("ChangeJobLayer:advancedCallBack 1")
        -- 处理表现特效，特效完成后就执行对比页面
        if(self.skillUpgradeArr) then 
            -- print("ChangeJobLayer:advancedCallBack 2")
            local callFunc = cc.CallFunc:create(function()
                if(RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_ADVANCED) then 
                    self:initUpgradeInfo(self._bg, true)
                else 
                    self:close()
                end
            end)

            local isFrist = true
            for k, node in ipairs(self.skillUpgradeArr) do 
                if(not tolua.isnull(node)) then
                    if(isFrist) then
                        isFrist = false
                        local action = cc.Sequence:create(cc.ScaleTo:create(0.2, 1.3), cc.ScaleTo:create(0.5, 1), cc.DelayTime:create(0.5), callFunc)
                        node:runAction(action)
                    else 
                        node:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.3), cc.ScaleTo:create(0.5, 1)))
                    end
                end
            end
        end
    end
end

-- 注册监听事件(可选)
function ChangeJobLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_SKILL_ADVANCED, self, self.advancedCallBack)
    
end

-- 注销监听事件(可选)
function ChangeJobLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_SKILL_ADVANCED, self, self.advancedCallBack)
end
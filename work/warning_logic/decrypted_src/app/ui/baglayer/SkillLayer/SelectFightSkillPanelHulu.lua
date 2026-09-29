-- NewSkillLayer.lua
-- Author:ydli
-- 2019年12月04日
-- Using:技能树(专门用于hulu活动处理逻辑)


local winSize = cc.Director:getInstance():getWinSize()

local SHARE_MODULE = PublicDefine.SHARE_MODULE
UI = UI or {}

local SelectFightSkillPanelHulu = class("SelectFightSkillPanelHulu", UI.HWBtnComponent)
UI.SelectFightSkillPanelHulu = SelectFightSkillPanelHulu

local COM_WIDTH = 480
local COM_HEIGHT = 548
-- 关卡选择资源
local COM_RES_LIST = {
}

local Btn_Pos = {{91, 75}, {13, 161}, {90, 247}, {14, 333}, {90, 447}}
function SelectFightSkillPanelHulu:ctor(equipType)
    SelectFightSkillPanelHulu.super.ctor(self, 0, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.mEquipType = equipType
    self.selectIndex = nil
    self.cellList = {}
    self.fightSkillBtnList = {}
    self.fightSkills = SkillDataManager:getUserFightSkill(self.mEquipType) or {}
    self:registerListener()
    self:init()
end

function SelectFightSkillPanelHulu:dtor()
    SelectFightSkillPanelHulu.super.dtor(self)
    self:unRegisterListener()
    reload_script_file("app.ui.baglayer.SkillLayer.SelectFightSkillPanelHulu")
    if self.closeCallback then
        self.closeCallback()
    end
end

-- public:
-- 初始化
function SelectFightSkillPanelHulu:init()
    SelectFightSkillPanelHulu.super.init(self)
end

--上一把武器
function SelectFightSkillPanelHulu:onLastEquip()
end

-- 模版函数：初始化组建的视图
function SelectFightSkillPanelHulu:onInitView()
    local bgAnimation = UI.Animation:create()
    bgAnimation:init("effect_ui_gaming_erjiejineng_diban.json", "effect_ui_gaming_erjiejineng_diban.atlas")
    bgAnimation:setAnimation("close", false)
    bgAnimation:center(-10, 12)
    self:addChild(bgAnimation)

    local leftPanel = self:createLeftPanel()
    leftPanel:rotate(180)
    leftPanel:leftBottom(-115, -292)
    local rightPanel = self:createRightPanel()
    rightPanel:leftBottom(-170, -255)
    bgAnimation:addComponent("icon-01", leftPanel, true)
    bgAnimation:addComponent("icon-02", rightPanel, true)
    self.bgAnimation = bgAnimation
    bgAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event, target)
        if event.animation == "open" then
            target:destroy()
            self:runAction(cc.RemoveSelf:create())
        end
    end)
end

-- 模版函数
function SelectFightSkillPanelHulu:onUpdateView()
end

--todo 实现左侧标签按钮
function SelectFightSkillPanelHulu:createLeftPanel()
    local leftBg = UI.Layout:create()
    leftBg:init()
    leftBg:centerLeft(0)
    leftBg:setSize(230, 549)

    local title2 = UI.Text:create()
    title2:init(UI.TEXT_1213803, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_201_159_95)
    title2:center(-15, -215)
    leftBg:addChild(title2)

    for k, v in ipairs(Btn_Pos) do
        local btn = UI.Image:create()
        btn:init("ui_skill_banner_point.png")
        btn:leftUp(v[1], v[2])
        leftBg:addChild(btn)
        btn:setTouchEnable(true)
        btn:setTag(k)
        if GameManager:getIsGooglePlay() then
            btn:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, btn, function()
                self:hightLight(k)
                Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                    if(not tolua.isnull(self)) then
                        self:unHightLight(k)
                    end
                end, 1)
            end)

            btn:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, btn, function(self_, button, touchPosition)
                if not btn:checkTouchPosition(touchPosition) then 
                    self:unHightLight(k)
                end
            end)

            btn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, btn, function()
                self:unHightLight(k)
            end)
        end

        btn:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            self:onSelect(k)
        end)

        if self.fightSkills[k] and self.fightSkills[k] > 0 then
            local skillGroupData = SkillDataManager:getSkillGroup(self.fightSkills[k])
            local skillIcon = UI.Image:create()
            skillIcon:init(skillGroupData.skillData:getIconName())
            skillIcon:setName("SkillIcon")
            skillIcon:center()
            btn:addChild(skillIcon)
        else
            local plus = UI.Image:create()
            plus:init("ui_btn_team_add_0.png")
            plus:center()
            plus:setName("Plus")
            btn:addChild(plus)
        end
        table.insert(self.fightSkillBtnList, btn)
    end
    return leftBg
end

--todo 实现右侧技能详情
function SelectFightSkillPanelHulu:createRightPanel()
    local rightBg = UI.Layout:create()
    rightBg:init()
    rightBg:setSize(301, 594)
    rightBg:centerRight(0)

    local scrollView = UI.ScrollView:create()
    scrollView:init(0, 0, 0, 0)
    scrollView:setSize(240, 480)
    scrollView:leftBottom(40, 28)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    rightBg:addChild(scrollView)

    local skillTreeDatas1 = mvc.festivalModel:getHuluConfigSkillIDArr(self.mEquipType)
    skillTreeDatas1 = skillTreeDatas1 or {}
    -- local skillTreeDatas2 = SkillDataManager:getUseGroupListByEquipType(self.mEquipType, Game.SkillAdvanceType.AdvanceTypeTwo)
    local cellHeight = 81
    local content = UI.Component:create()
    content:init()
    content:setSize(240, #skillTreeDatas1 * cellHeight + 110)
    content:leftBottom(0, 0)
    scrollView:addInnerNode(content)

    local title = UI.Text:create()
    title:init(UI.TEXT_1213805, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_201_159_95)
    title:center(10, -235)
    rightBg:addChild(title, 10)

    -- 上装饰条
    local splitterUp = UI.Image9:create()
    splitterUp:init("ui_scale9image_black.png", CCRectMake(2,0,1,1), cc.size(238, 1))
    splitterUp:leftUp(43, 82)
    rightBg:addChild(splitterUp, 100)
     
    local up = 0
    local fristShowSkillData = nil
    if table.nums(skillTreeDatas1) > 0 then
        -- up = up + 5
        -- local title1 = UI.Text:create()
        -- title1:init(UI.TEXT_1213801, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_201_159_95)
        -- title1:centerUp(up)
        -- content:addChild(title1)
        fristShowSkillData = skillTreeDatas1[1]
    end
    -- 用于打开界面的刷新,没有的时候默认刷一个，让表现不异常
    fristShowSkillData = fristShowSkillData or SkillDataManager:createTempSkillGroupData(100001, 1)
    if(fristShowSkillData) then 
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            if self.onselectCallback then
                self.onselectCallback(fristShowSkillData)
            end
        end, 0.1)
    end

    up = up + 32
    for k, skillGroupData in pairs(skillTreeDatas1) do
        local cell = self:createOneCell(skillGroupData)
        cell:leftUp(2, up)
        content:addChild(cell)
        up = cell:getUp() + cellHeight
        table.insert(self.cellList, cell)
    end 

    if table.nums(skillTreeDatas1) > 0 then
        up = up + 10
        local splitterUp = UI.Image9:create()
        splitterUp:init("ui_scale9image_black.png", CCRectMake(2,0,1,1), cc.size(238, 1))
        splitterUp:leftUp(1, up)
        content:addChild(splitterUp, 100)
    end

    return rightBg
end

function SelectFightSkillPanelHulu:createOneCell(skillGroupData)
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(234, 73)
    panel:setTag(skillGroupData.skillGroupID)

    local bg = UI.Image:create()
    bg:init("ui_skill_banner_install_box_0.png")
    bg:center()
    panel:addChild(bg)
    bg:setName("BG")

    local iconBg = UI.Image:create()
    iconBg:init("ui_skill_banner_skillbox_transfer_bg.png")
    iconBg:centerLeft(-12)
    panel:addChild(iconBg)
    iconBg:setScale(0.77)

    local skillIcon = UI.Image:create()
    skillIcon:init(skillGroupData.skillData:getIconName())
    skillIcon:center()
    iconBg:addChild(skillIcon)
    skillIcon:setTouchEnable(true)
    skillIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.onselectCallback then
            self.onselectCallback(skillGroupData)
        end
    end)

    local name = UI.Text:create()
    name:init(skillGroupData.skillData:getName(), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    name:center(24, -18)
    panel:addChild(name)

    local okButton = UI.Button:create()
    okButton:init("ui_btn_yes3_1.png", "ui_btn_yes3_1.png", "ui_btn_yes3_2.png")
    okButton:rightBottom(56, 11)
    okButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self, obj)
        self:onChangeClick(skillGroupData.skillGroupID)
    end)
    panel:addChild(okButton)
    okButton:hide()
    okButton:setName("OkButton")
    return panel
end

function SelectFightSkillPanelHulu:hightLight(index)
    for k, v in ipairs(self.fightSkillBtnList) do
        if index == k then
            v:addChild(self:createSelectEffect())
        end
    end
end

function SelectFightSkillPanelHulu:unHightLight(index)
    if self.selectIndex ~= index then
        for k, v in ipairs(self.fightSkillBtnList) do
            if index == k then
                v:removeChildByName("SelectEffect")
            end
        end
    end
end

function SelectFightSkillPanelHulu:onSelect(index)
    for k, v in ipairs(self.fightSkillBtnList) do
        v:removeChildByName("SelectEffect")
        if index == k then
            v:addChild(self:createSelectEffect())
        end
    end
    local skillGroupID = self.fightSkills[index]
    print("---onSelect---", index, skillGroupID)
    self.selectIndex = index
    for k, v in ipairs(self.cellList) do
        local bg = v:getChildByName("BG")
        local okButton = v:getChildByName("OkButton")
        okButton:show()
        local isHave = SkillDataManager:hasUserFightSkill(self.mEquipType, v:getTag())
        if isHave then
            bg:setSpriteName("ui_skill_banner_install_box_1.png")
        else
            bg:setSpriteName("ui_skill_banner_install_box_0.png")
        end
        if skillGroupID == v:getTag() then
            okButton:setNormal("ui_btn_no3_1.png")
            okButton:setSelected("ui_btn_no3_1.png")
            okButton:setDisabled("ui_btn_no3_2.png")
        else
            okButton:setNormal("ui_btn_yes3_1.png")
            okButton:setSelected("ui_btn_yes3_1.png")
            okButton:setDisabled("ui_btn_yes3_2.png")
        end
    end
    if self.onselectCallback and skillGroupID ~= 0 and skillGroupID ~= nil then
        self.onselectCallback(SkillDataManager:getSkillGroup(skillGroupID))
    end
end

function SelectFightSkillPanelHulu:onChangeClick(skillGroupID)
    local fightList = clone(SkillDataManager:getUserFightSkill(self.mEquipType)) or {}
    local selectSkillGroupID = self.fightSkills[self.selectIndex]
    if skillGroupID == selectSkillGroupID then
        for k, v in ipairs(fightList) do
            if k == self.selectIndex then
                fightList[k] = 0
            end
        end
    elseif SkillDataManager:hasUserFightSkill(self.mEquipType, skillGroupID) then
        for k, v in ipairs(fightList) do
            if v == skillGroupID then
                fightList[k] = 0
            end
        end
        for k, v in ipairs(fightList) do
            if k == self.selectIndex then
                fightList[k] = skillGroupID
            end
        end
    else
        for k, v in ipairs(fightList) do
            if k == self.selectIndex then
                fightList[k] = skillGroupID
            end
        end
    end

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    -- 这里需要处理新的接口
    Net.NetPlaySystem:huluSetSkillRequest(self.mEquipType, fightList)
end

function SelectFightSkillPanelHulu:createSelectEffect()
    local selectSpine = Avalon.Animation:create("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas", 1)
    selectSpine:setAnimation(0, "start_fillet2", false)
    selectSpine:addAnimation(0, "idle_fillet2", true)
    selectSpine:setName("SelectEffect")
    selectSpine:setPosition(50, 50)
    return selectSpine
end

function SelectFightSkillPanelHulu:refreshIcon()
    self.fightSkills = SkillDataManager:getUserFightSkill(self.mEquipType) or {}
    for k, btn in ipairs(self.fightSkillBtnList) do
        local skillIcon = btn:getChildByName("SkillIcon")
        local plus = btn:getChildByName("Plus")
        local skillGroupID = self.fightSkills[k]
        if skillGroupID == 0 or skillGroupID == nil then
            if skillIcon then
                skillIcon:removeFromParent()
            end
            if plus == nil then
                local plus = UI.Image:create()
                plus:init("ui_btn_team_add_0.png")
                plus:center()
                plus:setName("Plus")
                btn:addChild(plus)
            end
        else
            if plus then
                plus:removeFromParent()
            end
            local skillGroupData =SkillDataManager:getSkillGroup(skillGroupID)
            if skillIcon then
                skillIcon:setSpriteName(skillGroupData.skillData:getIconName())
            else
                local skillIcon = UI.Image:create()
                skillIcon:init(skillGroupData.skillData:getIconName())
                skillIcon:setName("SkillIcon")
                skillIcon:center()
                btn:addChild(skillIcon)
            end
        end
    end
    self:onSelect(self.selectIndex)
end

function SelectFightSkillPanelHulu:playClose()
    self.bgAnimation:setAnimation("open", false)
end

-- 注册监听事件
function SelectFightSkillPanelHulu:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_SKILL_SET_FIGHT_RESULT, self, self.refreshIcon)
end

-- 注销监听事件
function SelectFightSkillPanelHulu:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SKILL_SET_FIGHT_RESULT, self, self.refreshIcon)
end

function SelectFightSkillPanelHulu:setCloseCallback(callback)
    self.closeCallback = callback
end

function SelectFightSkillPanelHulu:setOnselectCallback(callback)
    self.onselectCallback = callback
end

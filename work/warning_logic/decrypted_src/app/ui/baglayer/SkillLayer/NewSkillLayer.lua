-- NewSkillLayer.lua
-- Author:ydli
-- 2019年12月04日
-- Using:技能树， 在节日活动hulu 模式的时候会做相关特殊处理


local winSize = cc.Director:getInstance():getWinSize()
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local LanguageManager = require "app.game.LanguageManager"
require("app.ui.baglayer.SkillLayer.SelectFightSkillPanel")
require("app.ui.baglayer.SkillLayer.SelectFightSkillPanelHulu")
local ProtobufUtil = require "utils.ProtobufUtil"

local SHARE_MODULE = PublicDefine.SHARE_MODULE
UI = UI or {}
local DEBUG = true
local NewSkillLayer = class("NewSkillLayer", UI.HWBtnComponent)
UI.NewSkillLayer = NewSkillLayer

local strList = {UI.TEXT_1213806, UI.TEXT_1213807, UI.TEXT_1213808}

local IconScale = 0.77

local COM_WIDTH = 978
local COM_HEIGHT = 555
-- 关卡选择资源
local COM_RES_LIST = {
    "ui_package_skill.plist",
    "ui_general_uishare.plist",
    "ui_package_horcurx.plist",
    "ui_town_upgrade.plist",
    "ui_common_btn.plist",
    "ui_package_roleTalent.plist",
}

function NewSkillLayer:ctor()
    NewSkillLayer.super.ctor(self, UIType.SKILL_LAYER, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.equipIcon = {
        "icon-equip_metal_21080010_1.png",
        "icon-equip_metal_21080010_2.png",
        "icon-equip_metal_21080010_3.png"
    }

    self.equipAnimationIcon = {
        "effect_ui_skillprogress_icon_jiandun",
        "effect_ui_skillprogress_icon_dajian",
        "effect_ui_skillprogress_icon_fazhang"
    }
    self.isInHulu = false

    self.selectSkillNode = nil
    if(SceneManager:getInstance():isInHuLu()) then 
        self.mEquipType = mvc.festivalModel:getHuluChoiceWeaponType()
        -- self.mEquipType = self.mEquipType == 0 and 1 or self.mEquipType
        self.mBChangeEquip = false --能否切换武器
        self.isInHulu = true
    else
        self.mEquipType = GameDataManager:getInstance():getWearWeaponType()
        self.mEquipType = self.mEquipType == 0 and 1 or self.mEquipType
        self.mBChangeEquip = true --能否切换武器
    end
    print("self.isInHulu=", self.isInHulu)
    self.mAdvanceType = Game.SkillAdvanceType.AdvanceTypeOne
    
    self:init()
    self:registerListener()
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
end

function NewSkillLayer:dtor()
    NewSkillLayer.super.dtor(self)
    self:unRegisterListener()

    reload_script_file("app.ui.baglayer.SkillLayer.NewSkillLayer")
    BagNotificationUtil:resetTimeStamp(BagNotificationUtil.REASON_SKILLPOINT)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_BAG_NOTI_STATUS)
end

-- public:
-- 初始化
function NewSkillLayer:init()
    NewSkillLayer.super.init(self)
end

--上一把武器
function NewSkillLayer:onLastEquip()
    if not self.mBChangeEquip then
        return
    end
    self.mBChangeEquip = false
    local oldEquip = self.mEquipType
    self.mEquipType = (self.mEquipType - 1 - 1) % #self.equipIcon + 1

    local node = self.clipperChildNode:getChildByTag(oldEquip)
    local lastNode = self.clipperChildNode:getChildByTag(self.mEquipType)
    lastNode:setPositionX(node:getPositionX() - 90)
    self.clipperChildNode:runAction(
        cc.Sequence:create(
            cc.MoveBy:create(0.1, cc.p(90, 0)),
            cc.CallFunc:create(
                function()
                    self.mBChangeEquip = true
                    self:createEquiopSkill()
                end
            )
        )
    )

    if (DEBUG) then
        print("SkillLayer:onLastEquip", self.mEquipType)
    end
    local panel = self.rootLayer:getChildByName("SelectFightSkillPanel")
    if panel then
        self.setAnimation:setAnimation("end", false)
        panel:playClose()
    end
end

--下一把武器
function NewSkillLayer:onNextEquip()
    if not self.mBChangeEquip then
        return
    end
    self.mBChangeEquip = false
    local oldEquip = self.mEquipType
    self.mEquipType = (self.mEquipType) % #self.equipIcon + 1

    local node = self.clipperChildNode:getChildByTag(oldEquip)
    local lastNode = self.clipperChildNode:getChildByTag(self.mEquipType)

    self.clipperChildNode:runAction(
        cc.Sequence:create(
            cc.MoveBy:create(0.1, cc.p(-90, 0)),
            cc.CallFunc:create(
                function()
                    node:setPositionX(node:getPositionX() + 90 * #self.equipIcon)
                    self.mBChangeEquip = true
                    self:createEquiopSkill()
                end
            )
        )
    )
    local panel = self.rootLayer:getChildByName("SelectFightSkillPanel")
    if panel then
        self.setAnimation:setAnimation("end", false)
        panel:playClose()
    end
end

-- 模版函数：初始化组建的视图
function NewSkillLayer:onInitView()

    self.rootLayer = cc.Layer:create()
    self.rootLayer:setPosition(cc.p(0, 0))
    self.rootLayer:setContentSize(cc.size(COM_WIDTH, COM_HEIGHT))
    self:addChild(self.rootLayer)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_character.png")
    bg:setCapInsets(CCRectMake(0, 0, 1, 1))
    bg:setContentSize(COM_WIDTH, COM_HEIGHT)
    bg:setAnchorPoint(0, 0)
    bg:setPosition(-2, -1)
    self.rootLayer:addChild(bg)

    local topBg = UI.Image:create()
    topBg:init("ui_skill_banner_topblack.png")
    topBg:leftUp(180, 0)
    self.rootLayer:addChild(topBg, 1)
    print("self.mEquipTypeself.mEquipTypeself.mEquipType", self.mEquipType)
    local title1 = UI.Text:create()
    title1:init(strList[self.mEquipType] or "", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155)
    title1:leftUp(200, 29 - title1:getContentSize().height / 2)
    title1:setWidth(190)
    title1:autoAdapt()
    
    title1:setLineSpacing(-8)
    title1:setTextLeftUp()
    self.rootLayer:addChild(title1, 100)
    self.cosumePoint = title1

    local tip = UI.Text:create()
    tip:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_130_5_5)
    tip:setWidth(220)
    tip:autoAdapt()
    tip:setLineSpacing(-8)
    tip:rightUp(80, 29 - tip:getContentSize().height / 2)
    tip:setTextLeftUp()
    topBg:addChild(tip)
    self.tip = tip

    self:createLeftPanel()
    self:createRightPanel()
    if(not self.isInHulu) then 
        self:createMidPanel()
    end
end

-- 模版函数
function NewSkillLayer:onUpdateView()
    if self.mSelectSkillNode and not tolua.isnull(self.mSelectSkillNode) then
        self:refreshSkillInfo(SkillDataManager:getSkillGroup(self.mSelectSkillNode:getTag()))
    end
end

--todo 实现左侧标签按钮
function NewSkillLayer:createLeftPanel()
    local curTabIdx = SkillDataManager:getCurSkillSelectType() + 1
    local picBg = UI.Image:create()
    picBg:init("ui_skill_banner_leftside_2.png")
    picBg:leftUp(-10, 5)
    self.rootLayer:addChild(picBg, 8)
    self.leftBg = picBg

    
    self:createSkillTabBtnView()

    -- local refreshBtn = UI.Image:create()
    -- refreshBtn:init("ui_btn_refresh_0.png")
    -- refreshBtn:leftUp(30, 25)
    -- tabBtn:addChild(refreshBtn)

    

    -- 一阶技能
    local levelBg1 = UI.Image:create()
    levelBg1:init("ui_setup_button_language_0.png")
    levelBg1:leftUp(20, 105)
    levelBg1:setTouchEnable(true)
    levelBg1:setSwallowTouches(true)
    self.leftBg:addChild(levelBg1)

    local levelBtn1 = UI.Image:create()
    levelBtn1:init("ui_setup_button_language_1.png")
    levelBtn1:center()
    levelBg1:addChild(levelBtn1, 1) 
    self.levelBtn1 = levelBtn1

    local levelTxt1 = UI.Text:create()
    levelTxt1:init(UI.TEXT_1213801, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    levelTxt1:center()
    levelTxt1:setTextCenter()
    levelTxt1:setWidth(173)
    levelTxt1:autoAdapt()
    levelTxt1:setLineSpacing(-10)
    levelBg1:addChild(levelTxt1, 2)
    self.levelTxt1 = levelTxt1
    levelBg1:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        self:updateLevelLayer(Game.SkillAdvanceType.AdvanceTypeOne)
    end)
    
    -- 二阶技能
    local levelBg2 = UI.Image:create()
    levelBg2:init("ui_setup_button_language_0.png")
    levelBg2:leftUp(20, 155)
    levelBg2:setTouchEnable(true)
    levelBg2:setSwallowTouches(true)
    self.leftBg:addChild(levelBg2)

    local lock = UI.Image:create()
    lock:init("ui_talent_btn_lock.png")
    lock:centerLeft(125)
    lock:setScale(0.7)
    lock:hide()
    levelBg2:addChild(lock, 10)
    self.lock = lock

    local levelBtn2 = UI.Image:create()
    levelBtn2:init("ui_setup_button_language_1.png")
    levelBtn2:center()
    levelBtn2:hide()
    levelBg2:addChild(levelBtn2, 1) 
    self.levelBtn2 = levelBtn2

    local levelTxt2 = UI.Text:create()
    levelTxt2:init(UI.TEXT_1213802, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_104_95_94)
    levelTxt2:center()
    levelTxt2:setTextCenter()
    levelTxt2:setWidth(173)
    levelTxt2:autoAdapt()
    levelTxt2:setLineSpacing(-10)
    levelBg2:addChild(levelTxt2, 2)
    self.levelTxt2 = levelTxt2
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_SecondSkill) then
        lock:show()
    end
    levelBg2:addEventListener(UIEvent.COMPONENT_CLICK, self, function() 
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_SecondSkill) then
             UI.ScrollBar:createByText(UI.TEXT_1170901)
            return
        end
        self:updateLevelLayer(Game.SkillAdvanceType.AdvanceTypeTwo)
        local panel = self.rootLayer:getChildByName("SelectFightSkillPanel")
        if panel then
            self.setAnimation:setAnimation("end", false)
            panel:playClose()
        end
    end)

    -- 三阶技能
    local levelBg3 = UI.Image:create()
    levelBg3:init("ui_setup_button_language_0.png")
    levelBg3:leftUp(20, 205)
    levelBg3:setTouchEnable(true)
    levelBg3:setSwallowTouches(true)
    self.leftBg:addChild(levelBg3)

    local lock3 = UI.Image:create()
    lock3:init("ui_talent_btn_lock.png")
    lock3:centerLeft(125)
    lock3:setScale(0.7)
    lock3:hide()
    levelBg3:addChild(lock3, 10)
    self.lock3 = lock3

    local levelBtn3 = UI.Image:create()
    levelBtn3:init("ui_setup_button_language_1.png")
    levelBtn3:center()
    levelBtn3:hide()
    levelBg3:addChild(levelBtn3, 1) 
    self.levelBtn3 = levelBtn3

    local levelTxt3 = UI.Text:create()
    levelTxt3:init(UI.TEXT_223100, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_104_95_94)
    levelTxt3:center()
    levelTxt3:setTextCenter()
    levelTxt3:setWidth(173)
    levelTxt3:autoAdapt()
    levelTxt3:setLineSpacing(-10)
    levelBg3:addChild(levelTxt3, 2)
    self.levelTxt3 = levelTxt3
    print("UnlockFunctionType_ThirdRankSkill23:", RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_ThirdRankSkill))
    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_ThirdRankSkill) then
        lock3:show()
    end
    levelBg3:addEventListener(UIEvent.COMPONENT_CLICK, self, function() 
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_ThirdRankSkill) then
             UI.ScrollBar:createByText(UI.TEXT_1170901)
            return
        end
        self:updateLevelLayer(Game.SkillAdvanceType.AdvanceTypeThree)
        local panel = self.rootLayer:getChildByName("SelectFightSkillPanel")
        if panel then
            self.setAnimation:setAnimation("end", false)
            panel:playClose()
        end
    end)

    --出战技能设置(动画未出)
    local txtSetting = UI.Text:create()
    txtSetting:init(UI.TEXT_1213819, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_192_167_128)
    txtSetting:leftBottom(23, 105)
    txtSetting:setTextCenter()
    txtSetting:setWidth(156)
    txtSetting:autoAdapt()
    self.leftBg:addChild(txtSetting, 10)

    --重置
    local tempPanel = UI.Layout:create()
    tempPanel:init()
    tempPanel:leftBottom(98, 48)
    self.leftBg:addChild(tempPanel, 10)
    tempPanel:setScale(IconScale)

    local btnReset = UI.Button:create()
    btnReset:init("ui_btn_mosaic2_0.png", "ui_btn_mosaic2_1.png", "ui_btn_mosaic2_2.png")
    btnReset:center()
    tempPanel:addChild(btnReset, 10)
    self.btnReset = btnReset
    self.btnReset:addEventListener(UIEvent.BUTTON_CLICK, self, self.onReset)

    -- CO-19062    36级前（不含36级），技能界面添加重置免费提示
    if self:getForgetSkillNeedMaterialNum() <= 0 then
        local freeResetText = UI.Text:create()
        freeResetText:init(UI.TEXT_223701, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=218,g=163,b=44})
        freeResetText:center(0,-37)
        tempPanel:addChild(freeResetText, 101)
    end

     --战斗技能设置
    local btnSetting = UI.Layout:create()
    btnSetting:init()
    btnSetting:setSize(90, 90)
    btnSetting:leftBottom(57, 149)
    btnSetting:setTouchEnable(true)
    self.leftBg:addChild(btnSetting, 10)
    
    if(GameManager:getIsGooglePlay()) then
        btnSetting:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, btnSetting, function()
            self:onSettingHightLight()
        end)

        btnSetting:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, btnSetting, function()
            self:onSettingUnHightLight()
        end)
    end

    btnSetting:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onSetting)

    local setAnimation = UI.Animation:create()
    setAnimation:init("effect_ui_gaming_erjiejineng_chuzhanshezhi.json", "effect_ui_gaming_erjiejineng_chuzhanshezhi.atlas")
    setAnimation:setAnimation("begin", false)
    setAnimation:center()
    btnSetting:addChild(setAnimation)
    self.setAnimation = setAnimation

    local txtReset = UI.Text:create()
    txtReset:init(UI.TEXT_111008, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    txtReset:centerLeft(60)
    self.btnReset:addChild(txtReset, 100)

    local switch = tonumber(ConfigManager:getGeneralForKey("skillsShortcutKey"))
    local heroData = RoleDataManager:getMaster()
    -- if heroData:getLevel() < switch then
    --     self.btnSetting:hide()
    -- end
    local forgetSkillNeedMateral = GameDataManager:getInstance():getForgetSkillNeedMateral()
    if (forgetSkillNeedMateral) then
        local picReset = cc.Sprite:createWithSpriteFrameName(forgetSkillNeedMateral:getIconName())
        picReset:setPosition(205, self.btnReset:getContentSize().height / 2 - 1)
        picReset:setScale(0.50)
        self.btnReset:addChild(picReset, 100)
    end
    local forgetSkillNeedMaterialNumForLevel = self:getForgetSkillNeedMaterialNum()
    local forgetSkillNeedMaterialNum = cc.Label:createWithTTF(
        forgetSkillNeedMaterialNumForLevel,
        UI.FONT_STANDARD,
        UI.FONT_SIZE_12PX
    )
    forgetSkillNeedMaterialNum:setPosition(221, self.btnReset:getContentSize().height / 2 - 10)
    forgetSkillNeedMaterialNum:setTextColor(UI.FONT_COLOR_247_245_232)
    forgetSkillNeedMaterialNum:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -2))
    self.btnReset:addChild(forgetSkillNeedMaterialNum, 100)
    self.forgetSkillNeedMaterialNum = forgetSkillNeedMaterialNum

    -- 处理hulu活动状态的变灰
    -- print("NewSkillLayer:createLeftPanel()", self.isInHulu)
    if(self.isInHulu)then
        -- self.tabBtn:setTouchEnable(false)
        -- self.tabBtn:setGray(true)
        for k, v in pairs(self.tabBtnList) do
            v:setTouchEnable(false)
            v:setGray(true)
        end
        -- refreshBtn:setGray(true)
        -- 一阶技能
        levelBg1:setGray(true)
        levelBtn1:setGray(true)
        -- 二阶技能
        self.lock:show()
        levelBg2:setTouchEnable(false)
        btnSetting:setTouchEnable(false)
        local glProgramState = AvalonUtil:getAnimationGrayGLProgramState()
        setAnimation._spine:setGLProgramState(glProgramState)
        setAnimation:setAnimation("idle1", true)
        setAnimation:updateTime(0)
        setAnimation:setTimeScale(0)
        self:onSetting()
        -- 三阶技能
        self.lock3:show()
        levelBg3:setGray(true)
        levelBtn3:setGray(true)

        btnReset:disable()
        tempPanel:setVisible(false)
    end

    self:updateResetButton()
end

function NewSkillLayer:createSkillTabBtnView()
    self.tabBtnList = {}
    self._taskTableView = UI.TableView.new({},180, 90)
    self._taskTableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    self._taskTableView:center(5, -225)
    self._taskTableView:setDelegate()
    self._taskTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._taskTableView:setBounceable(true)
    self._taskTableView:init()
    self._taskTableView:onUpdateCellSize(function (table,idx)
        return 68, 87
    end)

    self._taskTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createSkillTabBtnCell(index)
            end,
            function(e)
                printError("------------------------AnniversaryAppointmentCoinRewardView:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createSkillTabBtnCell(index)
        end

        return cell
    end)

    self._taskTableView:onTableCellTouched(function(table, cell)
        local index = cell:getIdx() + 1
        self:tabCellClick(cell, index)
    end)

    self._taskTableView:onUpdateCellNumbers(function ()
        return 3
    end)

    self.leftBg:addChild(self._taskTableView, 299)
    self._taskTableView:reloadData(true)
end

function NewSkillLayer:createSkillTabBtnCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(68, 87))

    local tabBtn = UI.Image:create()
    -- tabBtn:init(string.format("ui_skill_banner_page_1_1.png"))
    local curTabIdx = SkillDataManager:getCurSkillSelectType() + 1
    -- self.tabBtn:setSpriteName(string.format("ui_skill_banner_page_1_%d.png", curTabIdx))
    if index == curTabIdx then
        tabBtn:init("ui_skill_banner_page_1_1.png")
    -- elseif self:isSkillLabelNeedBuy(index) then

    else
        tabBtn:init("ui_skill_banner_page_1_2.png")
    end

    -- tabBtn:leftUp(5+(index-1)*60, 0)
    tabBtn:center()
    -- tabBtn:setTouchEnable(true)
    -- tabBtn:setSwallowTouches(true)
    -- self.tabBtn = tabBtn
    self.tabBtnList[index] = tabBtn
    local tabTxt = UI.Text:create()
    tabTxt:init(string.format(UI.TEXT_1213817, index), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    tabTxt:setWidth(50)
    tabTxt:autoAdapt()
    tabTxt:setLineSpacing(-8)
    tabTxt:setTextCenter()
    tabBtn:addChild(tabTxt)
    -- tabTxt:leftUp(55, 36 - tabTxt:getContentSize().height / 2)
    tabTxt:centerUp(10)
    -- self.tabTxt = tabTxt
    if self:isSkillLabelNeedBuy(index) then
        local boughtLabelList = SkillDataManager:getBoughtSkillLabelListList()
        -- local isShow = boughtLabelList[index] and true or false
        local lock = UI.Image:create()
        lock:init("ui_talent_btn_lock.png")
        lock:centerBottom(0)
        lock:setName("lock")
        lock:setScale(0.7)
        
        lock:setVisible(not boughtLabelList[index])
        tabBtn:addChild(lock)
    end
    
    -- tabBtn:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
    --     self:onChangeSkillTab(index)
    -- end)

    cell:addChild(tabBtn)

    return cell
end

function NewSkillLayer:tabCellClick(cell, index)
    self:onChangeSkillTab(index)
end

--todo 实现技能图标展现
function NewSkillLayer:createMidPanel()
    --创建技能表
    self.mScrollEquipSkill = ccui.ScrollView:create()
    self.mScrollEquipSkill:setBounceEnabled(true)
    self.mScrollEquipSkill:setDirection(ccui.ScrollViewDir.horizontal)
    self.mScrollEquipSkill:setContentSize(cc.size(460, 433))
    self.mScrollEquipSkill:setPosition(185, 120)
    self.rootLayer:addChild(self.mScrollEquipSkill, 1)
    self.mScrollEquipSkill:setInnerContainerSize(cc.size(1357, 433))
    self.mScrollEquipSkill:setScrollBarEnabled(false)
    self.mScrollEquipSkill:setSwallowTouches(false)

    local scrollTopCap = UI.Image:create()
    scrollTopCap:init("ui_skill_banner_slide_1.png")
    scrollTopCap:leftBottom(-1, 0)
    self.rootLayer:addChild(scrollTopCap, 100)

    self.mScrollEquipSkill:jumpToLeft()
    self.mEquipSkillNode = cc.Node:create()
    self.mScrollEquipSkill:addChild(self.mEquipSkillNode)

    local mode = RoleDataManager:getReincarntionSkillMode()
    local skillTreeDatas = ConfigManager:getSkillTreeByType(mode, 0)
    self.mScrollCommonSkill = ccui.ScrollView:create()
    self.mScrollCommonSkill:setPosition(185, 0)
    self.mScrollCommonSkill:setContentSize(cc.size(460, 115))
    if #skillTreeDatas <= 5 then
        self.mScrollCommonSkill:setInnerContainerSize(cc.size(515, 115))
    else
        self.mScrollCommonSkill:setInnerContainerSize(cc.size(110 * #skillTreeDatas, 115))
    end
    self.mScrollCommonSkill:setBounceEnabled(true)
    self.mScrollCommonSkill:setScrollBarEnabled(false)
    self.mScrollCommonSkill:setDirection(ccui.ScrollViewDir.horizontal)
    self.mScrollCommonSkill:setSwallowTouches(false)
    self.rootLayer:addChild(self.mScrollCommonSkill, 1)
    self.mCommonSkillNode = cc.Node:create()
    self.mScrollCommonSkill:addChild(self.mCommonSkillNode)
       -- 分割线
    local line = UI.Image9:create()
    line:init("ui_scale9image_banner_line_light.png", CCRectMake(2,0,1,1), cc.size(480, 1))
    line:leftBottom(180, 115)
    self.rootLayer:addChild(line)
    self.scrollLine = line

    self:createCommonSkill()
    self:createEquiopSkill()

    --剩余点数
    local txtTotalSkillPointText = UI.Text:create()
    txtTotalSkillPointText:init(
        LanguageManager:getInstance():getLocalString(1110231),
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_155_155_155
    )
    txtTotalSkillPointText:leftBottom(204, 10)
    self.rootLayer:addChild(txtTotalSkillPointText, 5)
    self.txtTotalSkillPointText = txtTotalSkillPointText

    self.txtTotalSkillPointNum = UI.Text:create()
    self.txtTotalSkillPointNum:init(tostring(SkillDataManager:getSkillStudyNum()),UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_250_211_124)
    self.txtTotalSkillPointNum:leftBottom(txtTotalSkillPointText:getLeft() + txtTotalSkillPointText:getContentSize().width + 1, txtTotalSkillPointText:getBottom())
    self.rootLayer:addChild(self.txtTotalSkillPointNum, 5)


    local nextLevel = GameDataManager:getInstance():getLevelToGetNextSkillPoint()
    local showLv = nextLevel
    local level, reinLv = nextLevel, 0
    if nextLevel then
        level, reinLv = RoleDataManager:getUIShowLvByItemData(nextLevel)
        showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
    end
    local strList = string.split(UI.TEXT_111100, "%d")
    txtLevelToGetNextSkillPointPro = UI.Text:create()
    txtLevelToGetNextSkillPointPro:init(strList[1] or "",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_155_155_155)
    txtLevelToGetNextSkillPointPro:leftBottom(20 + self.txtTotalSkillPointNum:getLeft() + self.txtTotalSkillPointNum:getContentSize().width, self.txtTotalSkillPointNum:getBottom())
    self.rootLayer:addChild(txtLevelToGetNextSkillPointPro, 5)
    self.txtLevelToGetNextSkillPointPro = txtLevelToGetNextSkillPointPro

    local txtLevelToGetNextSkillPointEnd = UI.Text:create()
    local endStr = reinLv > 0 and "" or strList[2]
    txtLevelToGetNextSkillPointEnd:init(endStr or "",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_155_155_155)
    txtLevelToGetNextSkillPointEnd:leftBottom(txtLevelToGetNextSkillPointPro:getLeft() + txtLevelToGetNextSkillPointPro:getContentSize().width + 90, txtLevelToGetNextSkillPointPro:getBottom())
    self.rootLayer:addChild(txtLevelToGetNextSkillPointEnd, 5)
    self.txtLevelToGetNextSkillPointEnd = txtLevelToGetNextSkillPointEnd

    --下次技能等级
    self.txtLevelToGetNextSkillPoint = UI.Text:create()
    self.txtLevelToGetNextSkillPoint:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_250_211_124)
    self.txtLevelToGetNextSkillPoint:leftBottom(txtLevelToGetNextSkillPointPro:getLeft() + txtLevelToGetNextSkillPointPro:getContentSize().width, txtLevelToGetNextSkillPointPro:getBottom())
    self.rootLayer:addChild(self.txtLevelToGetNextSkillPoint, 5)
    
    if nextLevel then
        self.txtLevelToGetNextSkillPointPro:show()
        self.txtLevelToGetNextSkillPointEnd:show()
        self.txtLevelToGetNextSkillPoint:show()
        self.txtLevelToGetNextSkillPoint:setText(tostring(showLv))
    else
        self.txtLevelToGetNextSkillPointPro:hide()
        self.txtLevelToGetNextSkillPointEnd:hide()
        self.txtLevelToGetNextSkillPoint:hide()
    end
end

--todo 实现右侧技能详情
function NewSkillLayer:createRightPanel()

    local picBg = UI.Image:create()
    picBg:init("ui_skill_banner_topside_down.png")
    picBg:rightBottom(0, 0)
    self.rootLayer:addChild(picBg, 8)
    self.rightBg = picBg

    local picBg2 = UI.Image:create()
    picBg2:init("ui_skill_banner_topside.png")
    picBg2:rightBottom(20, 18)
    picBg:addChild(picBg2, 1)
    self._picBg = picBg2

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark2.png")
    line:setContentSize(273, 1)
    line:setAnchorPoint(0.5, 0)
    line:setPosition(149, 391)
    self._picBg:addChild(line)

    local btnLeftArrow = UI.Button:create()
    btnLeftArrow:init("ui_activity_left_0.png", "ui_activity_left_1.png", "ui_activity_left_2.png")
    btnLeftArrow:leftUp(20, 35)
    btnLeftArrow:addEventListener(UIEvent.BUTTON_CLICK, self, self.onLastEquip)
    self._picBg:addChild(btnLeftArrow, 100)

    local btnRightArrow = UI.Button:create()
    btnRightArrow:init("ui_activity_right_0.png", "ui_activity_right_1.png", "ui_activity_right_2.png")
    btnRightArrow:rightUp(25, 35)
    btnRightArrow:addEventListener(UIEvent.BUTTON_CLICK, self, self.onNextEquip)
    self._picBg:addChild(btnRightArrow, 100)

    if (RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
        local picWeaponIconBG = cc.Sprite:createWithSpriteFrameName("ui_skill_banner_below.png")
        picWeaponIconBG:setPosition(148, 456)
        self._picBg:addChild(picWeaponIconBG, 10)

        self.clipper = cc.ClippingNode:create(cc.Sprite:createWithSpriteFrameName("ui_skill_banner_below.png"))
        self.clipper:setPosition(148, 456)
        self.clipper:setScale(0.97)
        self.clipper:setAlphaThreshold(0.05)
        self._picBg:addChild(self.clipper, 10)

        self.clipperChildNode = cc.Node:create()
        self.clipper:addChild(self.clipperChildNode)

        local skillCap = cc.Sprite:createWithSpriteFrameName("ui_skill_banner_below_up.png")
        skillCap:setPosition(148, 456)
        self._picBg:addChild(skillCap, 12)

        for i = 1, #self.equipIcon do
            local picWeaponIcon = cc.Sprite:createWithSpriteFrameName(self.equipIcon[i])

            picWeaponIcon:setPosition(90 * ((i - self.mEquipType + 3) % #self.equipIcon), 0)

            self.clipperChildNode:addChild(picWeaponIcon)
            picWeaponIcon:setTag(i)
        end
    else
        local picWeaponIconBG = cc.Sprite:createWithSpriteFrameName("ui_skill_banner_transfer_below.png")
        picWeaponIconBG:setPosition(148, 456)
        self._picBg:addChild(picWeaponIconBG)

        self.clipper = cc.ClippingNode:create(cc.Sprite:createWithSpriteFrameName("ui_skill_banner_transfer_below.png"))
        self.clipper:setPosition(50, 50)
        self.clipper:setScale(0.97)
        self.clipper:setAlphaThreshold(0.05)
        picWeaponIconBG:addChild(self.clipper, 10)

        -- 武器icon
        self.clipperChildNode = cc.Node:create()
        self.clipper:addChild(self.clipperChildNode)

        local skillCap = cc.Sprite:createWithSpriteFrameName("ui_skill_banner_transfer_below_up.png")
        skillCap:setPosition(50, 50)
        picWeaponIconBG:addChild(skillCap, 12)

        local up = UI.Image:create()
        up:init("ui_skill_banner_transfer_below_circle.png")
        up:center()
        picWeaponIconBG:addChild(up, 2)

        local up = UI.Image:create()
        up:init("ui_skill_banner_transfer_below__bg.png")
        up:centerUp(-24.5)
        picWeaponIconBG:addChild(up, 1)

        for i = 1, #self.equipAnimationIcon do
            local node = cc.Node:create()

            local skillNowAnimation = UI.Animation:create()
            skillNowAnimation:init(self.equipAnimationIcon[i] .. ".json", self.equipAnimationIcon[i] .. ".atlas")
            skillNowAnimation:setAnimation("idle", true)
            skillNowAnimation:center()
            node:addChild(skillNowAnimation)
            node:setPosition(90 * ((i - self.mEquipType + 3) % #self.equipAnimationIcon), 0)
            self.clipperChildNode:addChild(node)
            node:setTag(i)
        end
    end

    self:creataSkillInfo()

    if(self.isInHulu) then 
        btnLeftArrow:disable()
        btnRightArrow:disable()
    end
end

--todo 实现底部公共技能
function NewSkillLayer:createCommonSkill()
    if(self.isInHulu)then
        return 
    end

    local mode = RoleDataManager:getReincarntionSkillMode()
    local skillTreeDatas = ConfigManager:getSkillTreeByType(mode, 0)
    self.mCommonSkillNode:removeAllChildren()
    self.mScrollCommonSkill:jumpToLeft()
    for k, v in pairs(skillTreeDatas) do
        if v.hidden == 0 then
            local skillGroupData = SkillDataManager:getSkillGroup(v.skillGroupID)
            skillGroupData:refreshSkillState()
            local skillNode, skillIcon = self:createSkillIcon(skillGroupData)
            if (skillNode and skillIcon) then
                skillIcon:setTouchClipNode(self.mScrollCommonSkill)
                skillNode:setPositionY(70)
                self.mCommonSkillNode:addChild(skillNode, 1)
            end
        end
    end
end

--生成武器对应的技能
function NewSkillLayer:createEquiopSkill()
    if(self.isInHulu) then 
        return
    end

    if self:isHigherOrderSkill() then
        self.mScrollCommonSkill:hide()
        self.mScrollCommonSkill:setPosition(-winSize.width, 0)

        self.mScrollEquipSkill:setContentSize(cc.size(460, 450))
        self.mScrollEquipSkill:setPosition(185, 20)
        self.mScrollEquipSkill:setInnerContainerSize(cc.size(1357, 450))
        self.scrollLine:hide()
        self.tip:show()
    else
        self.mScrollCommonSkill:show()
        self.mScrollCommonSkill:setPosition(185, 0)

        self.mScrollEquipSkill:setContentSize(cc.size(460, 433))
        self.mScrollEquipSkill:setPosition(185, 120)
        self.mScrollEquipSkill:setInnerContainerSize(cc.size(1357, 433))
        self.scrollLine:show()
        self.tip:hide()
    end

    self.cosumePoint:setText((strList[self.mEquipType] or "").." "..SkillDataManager:getLearnPointByWeapType(self.mEquipType))
    if self.mSelectSkillNode then
        self.mSelectSkillNode:removeChildByName("selectEffect")
        self.mSelectSkillNode = nil
    end
    self.mEquipSkillNode:removeAllChildren()
    if  UI.ShowCloud then
        for i = 0, self.mScrollEquipSkill:getInnerContainerSize().width, 100 do
            local line = UI.Image9:create()
            line:init("ui_scale9image_black.png", CCRectMake(2,0,1,1), cc.size(2, self.mScrollEquipSkill:getInnerContainerSize().height))
            line:leftBottom(i, 0)
            self.mEquipSkillNode:addChild(line, 10000)

             local debugInfo = UI.Text:create()
            debugInfo:init(i.."", UI.FONT_STANDARD,UI.FONT_SIZE_14PX, UI.FONT_COLOR_GREEN)
            debugInfo:centerBottom(10)
            line:addChild(debugInfo)
        end

        for j = 0, self.mScrollEquipSkill:getInnerContainerSize().height, 100 do
            local line = UI.Image9:create()
            line:init("ui_scale9image_black.png", CCRectMake(2,0,1,1), cc.size(self.mScrollEquipSkill:getInnerContainerSize().width, 2))
            line:leftBottom(0, j)
            self.mEquipSkillNode:addChild(line, 10000)

             local debugInfo = UI.Text:create()
            debugInfo:init(j.."", UI.FONT_STANDARD,UI.FONT_SIZE_14PX, UI.FONT_COLOR_GREEN)
            debugInfo:centerLeft(10)
            line:addChild(debugInfo)
        end
    end

    self.mScrollEquipSkill:jumpToLeft()

    local mode = RoleDataManager:getReincarntionSkillMode()
    local skillTreeDatas = ConfigManager:getSkillTreeByType(mode, self.mEquipType, nil, self.mAdvanceType) or {}
    skillTreeDatas = SkillDataManager:checkReleateSkill(skillTreeDatas, self.mAdvanceType)

    table.sort(skillTreeDatas, function(a, b)
        return a.skillGroupID < b.skillGroupID
    end)

    -- 添加背景资源
    local maxStory = 1
    for k, v in pairs(skillTreeDatas) do
        if v.hidden == 0 then
            if v.storey > maxStory then
                maxStory = v.storey
            end
        end
    end
    if self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeThree then
        maxStory = 8
    end
    if RoleDataManager:getIsReincarntion() then
        -- maxStory = maxStory > 16 and maxStory or 16
        maxStory = maxStory + 1
    end
    print("maxStory:", maxStory, self.mAdvanceType, Game.SkillAdvanceType.AdvanceTypeThree)
    -- 刷新滑动块的大小
    local oneWidth = 90
    self.mScrollEquipSkill:setInnerContainerSize(cc.size(oneWidth * maxStory, 426))

    -- 添加图标
    local fixSkillNode = nil
    local defaultSelect = nil
    for k, v in pairs(skillTreeDatas) do
        if v.hidden == 0 then
            local skillGroupData = SkillDataManager:getSkillGroup(v.skillGroupID)
            skillGroupData:refreshSkillState()
            local skillNode, skillIcon = self:createSkillIcon(skillGroupData)
            if self.studySkillGroupID == v.skillGroupID then
                if (skillNode and skillIcon) then
                    skillIcon:setTouchClipNode(self.mScrollEquipSkill)
                    self.mEquipSkillNode:addChild(skillNode, 10)
                    fixSkillNode = skillNode
                    defaultSelect = skillNode
                end
                self.studySkillGroupID = nil
            else
                if (skillNode and skillIcon) then
                    skillIcon:setTouchClipNode(self.mScrollEquipSkill)
                    self.mEquipSkillNode:addChild(skillNode, 10)
                    if fixSkillNode == nil and skillGroupData:getState() == Game.SkillIconState.StateCanLearn then
                        fixSkillNode = skillNode
                    end
                end
                if defaultSelect == nil then
                    defaultSelect = skillNode
                end
            end
        end
    end
    if fixSkillNode then
        local percent = fixSkillNode:getPositionX() / (oneWidth * maxStory) * 100
        percent = percent < 10 and 0 or percent
        self.mScrollEquipSkill:jumpToPercentHorizontal(percent)
    end
    self:onSelectSkill(defaultSelect, false)
    if fixSkillNode ~= nil then
        self:showCanUpgradeAct(fixSkillNode)
    end
end

--创建技能Icon
function NewSkillLayer:createSkillIcon(skillGroupData)
    local skillData = skillGroupData.skillData
    if (skillData == nil) then
        return nil, nil
    end
    local skillNode = cc.Node:create()
    skillNode:setTag(skillGroupData.skillGroupID)
    skillNode:setPosition((skillGroupData.UILocation[1] or 0) + 35, (skillGroupData.UILocation[2] or 0) + 35)
    skillNode:setScale(IconScale)

    if UI.ShowCloud then
        local debugInfo = UI.Text:create()
        debugInfo:init(string.format("%d;(%d,%d)", skillGroupData.skillGroupID, skillGroupData.UILocation[1], skillGroupData.UILocation[2]), UI.FONT_STANDARD,UI.FONT_SIZE_14PX, UI.FONT_COLOR_RED)
        debugInfo:centerUp(-60)
        skillNode:addChild(debugInfo, 1000)
    end
    local equipChangeIcon = UI.Image:create()
    equipChangeIcon:init("ui_skill_icon_strengthening.png")
    equipChangeIcon:rightUp(-40, -45)
    skillNode:addChild(equipChangeIcon, 500)
    equipChangeIcon:hide()
    equipChangeIcon:setName("equipChangeIcon")

    if skillGroupData:getLevel() ~= 0 then
        if skillGroupData:getChangeLv() ~= 0 then
            equipChangeIcon:show()
        end
    end

    local skillCap = UI.Image:create()
    skillCap:init("ui_skill_banner_skillbox_transfer.png")
    skillCap:center(1, 1)
    skillCap:setName("skillCap")
    skillNode:addChild(skillCap, 400)
    if (RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
        skillCap:hide()
    else
        skillCap:show()
    end

    local skillBG = UI.Image:create()
    skillBG:init(self:getSkillBoxSpriteName())
    skillBG:center(1, 1)
    skillBG:setName("skillBG")
    skillNode:addChild(skillBG, 10)

    local skillIcon = UI.Image:create()
    skillIcon:init(skillData.iconID)
    skillIcon:setName("skillIcon")
    skillIcon:center()
    skillIcon:setCascadeOpacityEnabled(true)

    local layout = UI.Layout:create()
    layout:init()
    layout:setName("menu")
    layout:center()
    layout:addChild(skillIcon)
    skillNode:addChild(layout, 20)

    skillIcon:setTouchEnable(true)
    skillIcon:setSwallowTouches(false)
    if(GameManager:getIsGooglePlay()) then
        skillIcon:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, skillIcon, function()
            self:onSelectSkillHightLight(skillNode, true)
            Avalon.Scheduler:scheduleUpdateOnce(cc.Director:getInstance():getRunningScene(), function() 
                if(not tolua.isnull(self)) then
                    self:onSelectSkillUnHightLight(skillNode, true)
                end
            end, 1)
        end)

        skillIcon:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, skillIcon, function(self_, button, touchPosition)
            if not skillIcon:checkTouchPosition(touchPosition) then 
                self:onSelectSkillUnHightLight(skillNode, true)
            end
        end)
    end
    skillIcon:addEventListener(
        UIEvent.COMPONENT_CLICK,
        self,
        function(self)
            self:onSelectSkill(skillNode, true)
        end
    )

    if (skillGroupData.skillGroupConnectionLine ~= "" ) then
        self:handleLearnLine(skillNode, skillGroupData)
    end
    self:refreshIconState(skillGroupData:getState(), skillNode)

    if skillGroupData.skillAdvancement == Game.SkillAdvanceType.AdvanceTypeTwo then
    -- if self:isHigherOrderSkill() then
        skillCap:setSpriteName("ui_skill_banner_skillbox_order2.png")
        local lvBg = UI.Image:create()
        lvBg:init("ui_skill_banner_skillbox_order2_bg2.png")
        lvBg:centerBottom(-75)
        lvBg:setScale(1 / IconScale)
        lvBg:setName("LvBg")

        local lv = UI.Text:create()
        lv:init("",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_215_184_75)
        lv:center(0, 1)
        lvBg:addChild(lv)
        lv:setName("Level")

        lv:setText(string.format("%d/%d", skillGroupData:getLevel(), skillGroupData:getCanBeLearnedLevel()))
        if skillGroupData:getLevel() + skillGroupData:getChangeLv() <= 0 then
            lv:setFontColor(UI.FONT_COLOR_137_137_137)
        else
            lv:setFontColor(UI.FONT_COLOR_215_184_75)
        end
        skillNode:addChild(lvBg, 1)
    elseif skillGroupData.skillAdvancement == Game.SkillAdvanceType.AdvanceTypeThree then
        skillCap:setSpriteName("ui_skill_banner_skillbox_order3.png")
        local lvBg = UI.Image:create()
        lvBg:init("ui_skill_banner_skillbox_order2_bg2.png")
        lvBg:centerBottom(-75)
        lvBg:setScale(1 / IconScale)
        lvBg:setName("LvBg")

        local lv = UI.Text:create()
        lv:init("",UI.FONT_STANDARD,UI.FONT_SIZE_16PX,UI.FONT_COLOR_215_184_75)
        lv:center(0, 1)
        lvBg:addChild(lv)
        lv:setName("Level")

        lv:setText(string.format("%d/%d", skillGroupData:getLevel(), skillGroupData:getCanBeLearnedLevel()))
        if skillGroupData:getLevel() + skillGroupData:getChangeLv() <= 0 then
            lv:setFontColor(UI.FONT_COLOR_137_137_137)
        else
            lv:setFontColor(UI.FONT_COLOR_215_184_75)
        end
        skillNode:addChild(lvBg, 1)
    end

    if skillGroupData.relatedSkills ~= 0 and self:isHigherOrderSkill() then--skillGroupData.skillAdvancement == Game.SkillAdvanceType.AdvanceTypeTwo then
        local exchangeBg = UI.Image:create()
        exchangeBg:init("ui_skill_banner_refresh_box.png")
        exchangeBg:rightUp(-76, -75)
        skillNode:addChild(exchangeBg)
        exchangeBg:setScale(1 / IconScale)

        local btnRefresh = UI.Button:create()
        btnRefresh:init("ui_btn_refresh_0.png", "ui_btn_refresh_1.png", "ui_btn_refresh_2.png")
        btnRefresh:rightUp(10, 9)
        exchangeBg:addChild(btnRefresh)
        btnRefresh:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            if skillGroupData:getLevel() <= 0 then
                UI.ScrollBar:createByTextID(1170262)
                return
            end
            if SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave() then
                UI.ScrollBar:createByTextID(1170263)
                return
            end
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetRoleSystem:requestSwitchSkill(skillNode:getTag())  
        end)
    end
    return skillNode, skillIcon
end

function NewSkillLayer:refreshIconState(state, skillNode)
    -- print("---refreshIconState--", skillNode:getTag(), state)
    local back = skillNode:getChildByName("skillBlack")
    if back ~= nil then
        back:removeFromParent()
    end
    if state == Game.SkillIconState.StateLock then
        skillNode:getChildByName("menu"):getChildByName("skillIcon"):setGray(true)
        skillNode:getChildByName("skillBG"):setGray(true)
        skillNode:getChildByName("skillCap"):setGray(true)
    elseif state == Game.SkillIconState.StateCanLearn then
        local skillBlack = cc.Sprite:createWithSpriteFrameName("ui_skill_banner_black.png")
        skillBlack:setName("skillBlack")
        skillNode:addChild(skillBlack, 30)
    elseif state == Game.SkillIconState.StateLearned then
        skillNode:getChildByName("menu"):getChildByName("skillIcon"):setGray(false)
        skillNode:getChildByName("skillBG"):setGray(false)
        skillNode:getChildByName("skillCap"):setGray(false)
    else
        print("error!!!!!!!!, NewSkillLayer:refreshIconState state = ", state)
    end
end

function NewSkillLayer:onSelectSkillHightLight(selectNode, isAudioOn)
    if(selectNode and not tolua.isnull(selectNode)) then
        local skillGroupData = SkillDataManager:getSkillGroup(selectNode:getTag())
        selectNode:addChild(self:createSelectEffect(skillGroupData.skillAdvancement == Game.SkillAdvanceType.AdvanceTypeTwo), 600)
    end
end

function NewSkillLayer:onSelectSkillUnHightLight(selectNode, isAudioOn)
    if(selectNode and not tolua.isnull(selectNode)) then
        if self.mSelectSkillNode and self.mSelectSkillNode:getTag() ~= selectNode:getTag() then
            selectNode:removeChildByName("selectEffect")
        end
    end
end

--选中事件
function NewSkillLayer:onSelectSkill(selectNode, isAudioOn)
    if selectNode == nil then
        print("error !!!!!!!  selectNode is null")
        return
    end
    if DEBUG then
        print("onSelectSkill", selectNode:getTag(), self.mBChangeEquip)
    end
    if not self.mBChangeEquip then
        return
    end
    isAudioOn = isAudioOn == nil and true or isAudioOn 
    if isAudioOn then
        if self.rootLayer:getChildByName("SelectFightSkillPanel") then
            return
        end
        Avalon.AudioManager:playSound("1503")
    end

    local skillGroupData = SkillDataManager:getSkillGroup(selectNode:getTag())
    if skillGroupData:getState() == Game.SkillIconState.StateLock then
        if self.mSelectSkillNode and self.mSelectSkillNode:getTag() == selectNode:getTag() then --双击
            skillGroupData:isLock(isAudioOn)
        end
    elseif skillGroupData:getState() == Game.SkillIconState.StateCanLearn then
        if self.mSelectSkillNode and self.mSelectSkillNode:getTag() == selectNode:getTag() then --双击
            if SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave() then
                UI.ScrollBar:createByText(UI.TEXT_110041)
                return
            else
                self:onStudySkill()
            end
        end
    elseif skillGroupData:getState() == Game.SkillIconState.StateLearned then
        if self.mSelectSkillNode and self.mSelectSkillNode:getTag() == selectNode:getTag() and self:isHigherOrderSkill() then --双击
            if SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave() then
                UI.ScrollBar:createByText(UI.TEXT_110041)
                return
            else
                self:onStudySkill()
            end
        end
    else
         print("error!!!!!!!!, NewSkillLayer:onSelectSkill state = ", state)
    end

    if self.mSelectSkillNode and self.mSelectSkillNode:getTag() ~= selectNode:getTag() then
        self.mSelectSkillNode:removeChildByName("selectEffect")
        self.mSelectSkillNode = selectNode
        selectNode:addChild(self:createSelectEffect(skillGroupData.skillAdvancement == Game.SkillAdvanceType.AdvanceTypeTwo), 600)
    elseif self.mSelectSkillNode == nil then
        self.mSelectSkillNode = selectNode
        selectNode:addChild(self:createSelectEffect(skillGroupData.skillAdvancement == Game.SkillAdvanceType.AdvanceTypeTwo), 600)
    end
    self:refreshSkillInfo(SkillDataManager:getSkillGroup(self.mSelectSkillNode:getTag()))
end

--学习技能
function NewSkillLayer:onStudySkill(obj)
    if DEBUG then
        print("SkillLayer:onStudySkill")
    end

    if not self.mBChangeEquip then
        return
    end

    if RoleDataManager:getMaster():isHorcruxTransform() then
        UI.ScrollBar:createByText(UI.TEXT_1212473)
        return
    end

    local skillGroupData = SkillDataManager:getSkillGroup(self.mSelectSkillNode:getTag())
   
    if skillGroupData:isLock(true) then
        return
    end
    
    if skillGroupData.level >= skillGroupData:getCanBeLearnedLevel() then
        print("已经满级")
        UI.ScrollBar:createByText(UI.TEXT_1150005)
        return
    end

    if (RoleBehaviorManager:learnSkillCheck()) then
        Avalon.AudioManager:playSound("1519")
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        print("---skillGroupData.skillGroupID----", skillGroupData.skillGroupID)
        Net.NetRoleSystem:heroStudySkill(skillGroupData.skillGroupID)
        self.studySkillGroupID = skillGroupData.skillGroupID
    end
end

--创建选中特效
function NewSkillLayer:createSelectEffect(isSpecial)
    local selectSpine = Avalon.Animation:create("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas", 1)
    if (RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
        if isSpecial then
            selectSpine:setAnimation(0, "start_erjie", false)
            selectSpine:addAnimation(0, "idle_erjie", true)
        elseif self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeThree then
            selectSpine:setAnimation(0, "start_third_skill", false)
            selectSpine:addAnimation(0, "idle_third_skill", true)
        else
            selectSpine:setAnimation(0, "start_fillet", false)
            selectSpine:addAnimation(0, "idle_fillet", true)
        end
    else
        if isSpecial then
            selectSpine:setAnimation(0, "start_erjie", false)
            selectSpine:addAnimation(0, "idle_erjie", true)
        elseif self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeThree then
            selectSpine:setAnimation(0, "start_third_skill", false)
            selectSpine:addAnimation(0, "idle_third_skill", true)
        else
            selectSpine:setAnimation(0, "start_transfer", false)
            selectSpine:addAnimation(0, "idle_transfer", true)
        end
    end
    selectSpine:setName("selectEffect")
    return selectSpine
end

--todo 实现创建技能链接线
function NewSkillLayer:handleLearnLine(skillNode, skillGroupData)
    local nowGroupID = skillGroupData.skillGroupID
    local preGroupIDArr = skillGroupData:getLineReferPreSkillGroupID()
    if #preGroupIDArr <= 0 then
        return
    end
    local isTwoPre = false
    local posX, posY = skillNode:getPosition()
    local nowSkillTree = SkillDataManager:getSkillGroup(nowGroupID)
    if (#preGroupIDArr == 2) then
        isTwoPre = true
    end

    for _, v in ipairs(preGroupIDArr) do
        local groupID = v.gId
        local preSkilTree = SkillDataManager:getSkillGroup(groupID)
        -- 添加没有连成的处理，
        if DEBUG then
            print(nowSkillTree.skillGroupConnectionLine, nowSkillTree.level, nowSkillTree:getUnlockLevel())
        end

        local top = false
        if (nowSkillTree.UILocation[2] >= preSkilTree.UILocation[2]) then
            top = false
        else
            top = true
        end

        local lineName = string.format("%d:%d1", nowSkillTree.skillGroupID, preSkilTree.skillGroupID)
        if (self.mEquipSkillNode:getChildByName(lineName) == nil) then
            local grayName = string.format("%s-2.png", nowSkillTree.skillGroupConnectionLine)
            local lineNode = cc.Sprite:createWithSpriteFrameName(grayName)
            if(lineNode) then
                lineNode:setName(lineName)
                if (top == false) then
                    if isTwoPre then
                        lineNode:setScaleY(-1)
                    end
                end
                local offsetY = 10
                if (top) then
                    lineNode:setPosition(
                        posX - 29 - lineNode:getContentSize().width / 2,
                        posY + lineNode:getContentSize().height / 2 - offsetY
                    )
                else
                    lineNode:setPosition(
                        posX - 29 - lineNode:getContentSize().width / 2,
                        posY - lineNode:getContentSize().height / 2 + offsetY
                    )
                end

                self.mEquipSkillNode:addChild(lineNode)
            else 
                if(grayName == nil) then 
                    grayName = "";
                end

                printError(string.format("%s spriteFrame not found.", grayName))
                if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
                    if (device.platform == "ios" or device.platform == "android") then
                        buglyReportLuaException("skilllayer skillnode error: lineName=" .. tostring(lineName) .. ", grayName="..tostring(grayName))
                    end
                end
            end
        end

        local lightSpriteName = string.format("%d:%d2", nowSkillTree.skillGroupID, preSkilTree.skillGroupID)
        if (preSkilTree.level > 0 and nowSkillTree.level > 0) then
            if (self.mEquipSkillNode:getChildByName(lightSpriteName) == nil) then
                local lightName = string.format("%s-1.png", nowSkillTree.skillGroupConnectionLine)
                
                local lightNode = cc.Sprite:createWithSpriteFrameName(lightName)
                if lightNode then
                    offsetY = 7
                    if (top == false) then
                        if isTwoPre then
                            lightNode:setScaleY(-1)
                        end
                    end
                    if (top) then
                        lightNode:setPosition(
                            posX - 29 - 2 - lightNode:getContentSize().width / 2,
                            posY + lightNode:getContentSize().height / 2 - offsetY
                        )
                    else
                        lightNode:setPosition(
                            posX - 29 - 2 - lightNode:getContentSize().width / 2,
                            posY - lightNode:getContentSize().height / 2 + offsetY
                        )
                    end
                    self.mEquipSkillNode:addChild(lightNode)

                    lightNode:setName(lightSpriteName)
                else
                    if CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
                        if (device.platform == "ios" or device.platform == "android") then
                            buglyReportLuaException("skilllayer light error: lightSpriteName=" .. tostring(lightSpriteName) .. ", lightName="..tostring(lightName))
                        end
                    end
                end
            end
        else
            -- 移除表现
            skillNode:removeChildByName(lightSpriteName)
        end
    end
end

--todo 刷新右侧技能详情
function NewSkillLayer:refreshSkillInfo(skillGroupData)
    local showCondition = {}
    if(self.isInHulu) then 
        self.mTxtSkillName:setText(skillGroupData.skillData.name)
        self.mPicSkillIcon:setSpriteName(skillGroupData.skillData.iconID)
        self.videoImg:hide()
        self.videoTxt:hide()

        self.mTxtOpenLevel:hide()
        self.mTxtNeedAddition:hide()
        self.mTxtNeedSkillLv:hide()
    else
        self.mTxtSkillName:setText(skillGroupData.skillData.name)
        self.mPicSkillIcon:setSpriteName(skillGroupData.skillData.iconID)

        self.videoImg:setTag(skillGroupData.skillGroupID)
        if skillGroupData:isHasVideo() then
            self.videoImg:show()
            self.videoTxt:show()
            self.mTxtSkillType:leftUp(116, 44)
        else
            self.videoImg:hide()
            self.videoTxt:hide()
            self.mTxtSkillType:leftUp(116, 61)
        end

        local lv = skillGroupData:getLevel() + skillGroupData:getChangeLv()
        if lv > #skillGroupData.skillIDList then
            lv = #skillGroupData.skillIDList
        elseif lv == 0 then
            lv = 1
        end

        if (skillGroupData:getUnlockLevel() ~= 0) and skillGroupData:getUnlockLevel() > RoleDataManager:getMaster():getLevel() then
            self.mTxtOpenLevel:show()
            self.mTxtOpenLevel:setText(string.format(UI.TEXT_111002, skillGroupData:getUnlockLevel()))
            table.insert(showCondition, self.mTxtOpenLevel)
        else
            self.mTxtOpenLevel:hide()
        end
        local strlist = {UI.TEXT_1213809, UI.TEXT_1213810, UI.TEXT_1213811}
        local needPoint = skillGroupData:getNeedLearnPoint()
        if needPoint > SkillDataManager:getLearnPointByWeapType(self.mEquipType) then
            self.mTxtNeedAddition:show()
            self.mTxtNeedAddition:setText(string.format(strlist[self.mEquipType], needPoint))
            table.insert(showCondition, self.mTxtNeedAddition)
        else
            self.mTxtNeedAddition:hide()
        end

        local isHasLearn, list = skillGroupData:judgeLearnPreSkill()
        if isHasLearn then
            self.mTxtNeedSkillLv:hide()
        else
            self.mTxtNeedSkillLv:show()
            local str = ""
            for k, v in ipairs(list) do
                local preSkillGroupData = SkillDataManager:getSkillGroup(v.gId)
                if preSkillGroupData and preSkillGroupData.skillData then
                    str = str..string.format(UI.TEXT_1213812, preSkillGroupData.skillData.name, v.level)
                else
                    str = str..string.format(UI.TEXT_1213812, "**", v.level)
                end
                if k ~= #list then
                    local connectWord = UI.TEXT_1213814
                    if not v.isAnd and list[k+1] and list[k+1].isAnd then
                        connectWord = UI.TEXT_1213821
                    end
                    str = str.." "..connectWord.." \n"
                end
            end
            self.mTxtNeedSkillLv:setText(str)
            table.insert(showCondition, self.mTxtNeedSkillLv)
        end
    end

    local startX = 114
    local startY = 17
    startY = startY + self.mTxtSkillName:getContentSize().height
    self.mTxtSkillType:leftUp(startX ,startY)
    startY = startY + self.mTxtSkillType:getContentSize().height
    self.videoImg:leftUp(startX, startY)
    -- 17
    startY = startY + 5 + math.max(self.videoImg:getContentSize().height, self.videoTxt:getContentSize().height)

    local height = startY
    for k, v in ipairs(showCondition) do
        v:leftUp(25, height)
        height = height + v:getContentSize().height
    end

    local addHeight = 200 - height
    self.line:leftUp(6, height)
    self.skillInfoScrollView:setSize(290, 170 + addHeight)
    self.skillInfoScrollView:leftUp(2, self.line:getUp() + 6)

    local skillData = skillGroupData.skillData
    if skillData == nil then
        print("----skillGroupData---", skillGroupData)
    end

    local showCondition = {}
    table.insert(showCondition, self.mTxtSkillLv)
    if(lv) then
        self.mTxtSkillLv:setText(string.format("Lv：%d", lv))
    else
        self.mTxtSkillLv:setText("")
    end
    self.mTxtSkillDes1:setText(UI.TEXT_111007..skillData.description)
    if skillData.type == SkillType.PASSIVE then
        self.mTxtSkillType:setText(UI.TEXT_110038)
        self.mTxtSkillConsume:setVisible(false)
        self.mTxtSkillCD:setVisible(false)
        self.mTxtPrepareCD:setVisible(false)
    else
        self.mTxtSkillType:setText(UI.TEXT_110039)
        self.mTxtSkillConsume:setVisible(true)
        self.mTxtSkillCD:setVisible(true)
        self.mTxtPrepareCD:setVisible(true)
        table.insert(showCondition, self.mTxtSkillConsume)
        table.insert(showCondition, self.mTxtSkillCD)
        table.insert(showCondition, self.mTxtPrepareCD)

        if skillData.costType == 1 then
            self.mTxtSkillConsume:setText(UI.TEXT_111005 .. string.format("%d", skillData.cost))
        else
            self.mTxtSkillConsume:setText(UI.TEXT_111004 .. string.format("%d", skillData.cost))
        end
        self.mTxtSkillCD:setText(UI.TEXT_111006 .. string.format("%.1f", skillData:getCooldown() / 1000))

        local prepareCD = ""
        if skillData:isActive() then
            if (skillData:getSkillType() == SkillType.PHYSICAL) then
                if skillData:getPrepareTime() <= 0 then
                    prepareCD = LanguageManager:getInstance():getLocalString(1111371)..LanguageManager:getInstance():getLocalString(1111372)
                else
                    prepareCD = LanguageManager:getInstance():getLocalString(1111371)..string.format("%.1f", skillData:getPrepareTime())
                end
            elseif (skillData:getSkillType() == SkillType.MAGIC) then
                if skillData:getPrepareTime() <= 0 then
                    prepareCD = LanguageManager:getInstance():getLocalString(1111370)..LanguageManager:getInstance():getLocalString(1111372)
                else
                    prepareCD = LanguageManager:getInstance():getLocalString(1111370)..string.format("%.1f", skillData:getPrepareTime())
                end
            end
            self.mTxtPrepareCD:setText(prepareCD)
        elseif skillData:isAssist() then
            self.mTxtPrepareCD:setText(prepareCD)
        end
    end
    if(self.isInHulu) then
        self.mTxtSkillLimit:hide()
    else
        local list = skillGroupData:getLimitSkills()
        if #list > 0  then
            local name = ""
            for k, v in ipairs(list) do
                name = name .. v.skillData:getName()
                if k ~= #list then
                    name = name .. ", "
                end
            end
            self.mTxtSkillLimit:show()
            self.mTxtSkillLimit:setText(string.format(UI.TEXT_1213815, name))
            table.insert(showCondition, self.mTxtSkillLimit)
        else
            self.mTxtSkillLimit:hide()
        end
    end
    table.insert(showCondition, self.mTxtSkillDes1)

    local height = 0 
    for k, v in ipairs(showCondition) do
        height = height + v:getContentSize().height
    end
    -- 处理是否达到了文字限制高度
    local desScrollHeight = self.skillInfoScrollView:getContentSize().height
    if height < desScrollHeight then
        height = desScrollHeight
    end
    local panel = self:createNextLvInfo(skillGroupData)
    if panel then
        height = height + panel:getContentSize().height
        table.insert(showCondition, panel)
    end
    self.mScrollSkillInfo:setSize(290, height)

    -- 根据排版设计位置
    height = 0
    for k, v in ipairs(showCondition) do
        v:leftUp(0, height)
        height = height + v:getContentSize().height
    end

    self.skillInfoScrollView:refresh()
    self.skillInfoScrollView:scrollToTop()
end

function NewSkillLayer:playVideoClick(sender)
    local skillGroupId = sender:getTag()
    local skillGroupData = SkillDataManager:getSkillGroup(skillGroupId)
    if skillGroupData then
        local HorcurxPreVideoLayer = require ("app.ui.baglayer.Horcurx.HorcurxPreVideoLayer")
        local preView = HorcurxPreVideoLayer:create()
        if SdkBox:getInstance():getVersionTarget() == PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            preView:setURL(string.format("/video/skillglobal/%d.mp4", skillGroupData.skillGroupID))
        else
            preView:setURL(string.format("/video/skillcn/%d.mp4", skillGroupData.skillGroupID))
        end
        preView:init()
        preView:center()
        self:addChild(preView, 1001)
    end
end

-- 创建技能详情
function NewSkillLayer:creataSkillInfo()

    local skillInfoLayout = UI.Layout:create()
    skillInfoLayout:init()
    skillInfoLayout:setSize(290, 368)
    skillInfoLayout:centerBottom(24)
    self._picBg:addChild(skillInfoLayout)
    self._skillInfoLayout = skillInfoLayout

    local mTxtSkillName = UI.Text:create()
    mTxtSkillName:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillName:leftUp(114, 17)
    mTxtSkillName:setWidth(164)
    mTxtSkillName:setTextLeftUp()
    mTxtSkillName:setLineSpacing(-6)
    self._skillInfoLayout:addChild(mTxtSkillName)
    self.mTxtSkillName = mTxtSkillName

    local mPicSkillIconBG1 = UI.Image:create()
    mPicSkillIconBG1:init(self:getSkillBoxSpriteName())
    mPicSkillIconBG1:center(-86, -128)
    self._skillInfoLayout:addChild(mPicSkillIconBG1)
    self.mPicSkillIconBG1 = mPicSkillIconBG1

    local mPicSkillIcon = UI.Image:create()
    mPicSkillIcon:init()
    mPicSkillIcon:center()
    self.mPicSkillIconBG1:addChild(mPicSkillIcon)
    self.mPicSkillIcon = mPicSkillIcon

    local mTxtSkillType = UI.Text:create()
    mTxtSkillType:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillType:leftUp(116, 61)
    mTxtSkillType:setTextLeft()
    self._skillInfoLayout:addChild(mTxtSkillType)
    self.mTxtSkillType = mTxtSkillType

    local videoImg = UI.Button:create()
    videoImg:init("ui_horcrux_illusion_play_0.png", "ui_horcrux_illusion_play_1.png", "ui_horcrux_illusion_play_0.png")
    videoImg:leftUp(114, 70)
    videoImg:addEventListener(UIEvent.BUTTON_CLICK, self, function()
       self:playVideoClick(videoImg)
    end)
    self._skillInfoLayout:addChild(videoImg)
    self.videoImg = videoImg

    local videoTxt = UI.Text:create()
    videoTxt:init(UI.TEXT_1213205, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_45_45_45)
    videoTxt:setWidth(130)
    videoTxt:autoAdapt()
    videoTxt:setLineSpacing(-6)
    videoTxt:centerLeft(5 + videoImg:getContentSize().width)
    videoImg:addChild(videoTxt)
    self.videoTxt = videoTxt

    local mTxtOpenLevel = UI.Text:create()
    mTxtOpenLevel:init(string.format(UI.TEXT_111002, 20), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
    mTxtOpenLevel:setWidth(242)
    mTxtOpenLevel:setTextLeftUp()
    local size1 = mTxtOpenLevel:getContentSize()
    self._skillInfoLayout:addChild(mTxtOpenLevel)
    self.mTxtOpenLevel = mTxtOpenLevel

    local mTxtNeedAddition = UI.Text:create()
    -- 剑盾系、大剑系、法杖系
    mTxtNeedAddition:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
    mTxtNeedAddition:setWidth(242)
    mTxtNeedAddition:setTextLeftUp()
    mTxtNeedAddition:autoAdapt()
    local size2 = mTxtNeedAddition:getContentSize()
    self._skillInfoLayout:addChild(mTxtNeedAddition)
    self.mTxtNeedAddition = mTxtNeedAddition

    local mTxtNeedSkillLv = UI.Text:create()
    mTxtNeedSkillLv:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
    mTxtNeedSkillLv:setWidth(242)
    mTxtNeedSkillLv:setTextLeftUp()
    mTxtNeedSkillLv:autoAdapt()
    local size3 = mTxtNeedSkillLv:getContentSize()
    self._skillInfoLayout:addChild(mTxtNeedSkillLv)
    self.mTxtNeedSkillLv = mTxtNeedSkillLv

    local line = UI.Image9:create()
    line:init("ui_scale9image_black.png", CCRectMake(2,0,1,1), cc.size(273, 1))
    line:leftUp(43, 42)
    self._skillInfoLayout:addChild(line, 10)
    self.line = line

    -- 滚动视图
    local skillInfoScrollView = UI.ScrollView:create()
    skillInfoScrollView:init(25, -10, 0, 0)
    skillInfoScrollView:setSize(290, 200)
    skillInfoScrollView:setTouchEnable(true)
    skillInfoScrollView:setScrollBarEnabled(true)
    skillInfoScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    skillInfoScrollView:setScrollBarWidth(5)
    skillInfoScrollView:setCircleVisible(false)
    self._skillInfoLayout:addChild(skillInfoScrollView, 10)
    self.skillInfoScrollView = skillInfoScrollView

    local mScrollSkillInfo = UI.Layout:create()
    mScrollSkillInfo:init()
    mScrollSkillInfo:leftUp(0, 0)
    skillInfoScrollView:addInnerNode(mScrollSkillInfo)
    self.mScrollSkillInfo = mScrollSkillInfo

    -- 等级
    local mTxtSkillLv = UI.Text:create()
    mTxtSkillLv:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillLv:leftUp(0, 0)
    mTxtSkillLv:setWidth(242)
    mTxtSkillLv:autoAdapt()
    local size1 = mTxtSkillLv:getContentSize()
    self.mScrollSkillInfo:addChild(mTxtSkillLv)
    self.mTxtSkillLv = mTxtSkillLv

    -- HP/MP消耗
    local height1 = size1.height
    local mTxtSkillConsume = UI.Text:create()
    mTxtSkillConsume:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillConsume:leftUp(0, height1)
    mTxtSkillConsume:setWidth(242)
    mTxtSkillConsume:autoAdapt()
    local size2 = mTxtSkillConsume:getContentSize()
    self.mScrollSkillInfo:addChild(mTxtSkillConsume)
    self.mTxtSkillConsume = mTxtSkillConsume

    -- 技能CD
    local height2 = height1 + size2.height
    local mTxtSkillCD = UI.Text:create()
    mTxtSkillCD:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillCD:leftUp(0, height2)
    mTxtSkillCD:setWidth(242)
    mTxtSkillCD:autoAdapt()
    local size3 = mTxtSkillCD:getContentSize()
    self.mScrollSkillInfo:addChild(mTxtSkillCD)
    self.mTxtSkillCD = mTxtSkillCD

    local mTxtPrepareCD = UI.Text:create()
    mTxtPrepareCD:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtPrepareCD:leftUp(0, height2)
    self.mScrollSkillInfo:addChild(mTxtPrepareCD)
    self.mTxtPrepareCD = mTxtPrepareCD

    -- 限制
    local height3 = height2 + size3.height
    local mTxtSkillLimit = UI.Text:create()
    mTxtSkillLimit:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillLimit:leftUp(0, height3)
    mTxtSkillLimit:setWidth(242)
    mTxtSkillLimit:autoAdapt()
    local size4 = mTxtSkillLimit:getContentSize()
    self.mScrollSkillInfo:addChild(mTxtSkillLimit)
    self.mTxtSkillLimit = mTxtSkillLimit

    -- 描述
    local height4 = height3 + size4.height
    local mTxtSkillDes1 = UI.Text:create()
    mTxtSkillDes1:init(UI.TEXT_111007, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillDes1:leftUp(0, height4)
    mTxtSkillDes1:setWidth(242)
    mTxtSkillDes1:autoAdapt()
    local size5 = mTxtSkillDes1:getContentSize()
    self.mScrollSkillInfo:addChild(mTxtSkillDes1)
    self.mTxtSkillDes1 = mTxtSkillDes1

    self.desHeight = height4 + size5.height + 10
    self.mScrollSkillInfo:setSize(242, self.desHeight)
end

-- 创建下一等级info
function NewSkillLayer:createNextLvInfo(skillGroupData)
    if(self.isInHulu) then 
        return
    end
    local nextLvDesLayout = self.mScrollSkillInfo:getChildByName("nextLvDesLayout")
    if nextLvDesLayout then
        self.mScrollSkillInfo:removeChildByName("nextLvDesLayout")
    end

    local lv = skillGroupData:getLevel() + skillGroupData:getChangeLv()
    if lv > #skillGroupData.skillIDList then
        lv = #skillGroupData.skillIDList
    elseif lv == 0 then
        lv = 1
    end
    local nextLevel = lv + 1
    if nextLevel > #skillGroupData.skillIDList then
        return
    end
    local skillID = skillGroupData.skillIDList[nextLevel]
    local skillData = SkillDataManager:createSkillForSkillId(skillID)   
    if skillData == nil then
        return
    end
    local nextLvDesLayout = UI.Layout:create()
    nextLvDesLayout:init()
    nextLvDesLayout:setName("nextLvDesLayout")
    self.mScrollSkillInfo:addChild(nextLvDesLayout)

    local line = UI.Image:create()
    line:init("ui_upgrade_decorate_before.png")
    line:leftUp(-10, 10)
    nextLvDesLayout:addChild(line)

    local txtNextTitle = UI.Text:create()
    txtNextTitle:init(UI.TEXT_1213816, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_20_105_22)
    txtNextTitle:setWidth(100)
    txtNextTitle:setLineSpacing(-6)
    txtNextTitle:autoAdapt()
    txtNextTitle:setTextCenter()
    txtNextTitle:centerUp(6 - txtNextTitle:getContentSize().height / 2)
    line:addChild(txtNextTitle)

    -- 等级
    local mTxtSkillLv = UI.Text:create()
    mTxtSkillLv:init(string.format("Lv：%d", nextLevel), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillLv:leftUp(0, 15)
    mTxtSkillLv:setWidth(242)
    mTxtSkillLv:autoAdapt()

    -- HP/MP消耗
    local mTxtSkillConsume = UI.Text:create()
    mTxtSkillConsume:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillConsume:setWidth(242)
    mTxtSkillConsume:autoAdapt()

    -- 技能CD
    local mTxtSkillCD = UI.Text:create()
    mTxtSkillCD:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillCD:setWidth(242)
    mTxtSkillCD:autoAdapt()


    local mTxtPrepareCD = UI.Text:create()
    mTxtPrepareCD:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)

    -- 限制
    local mTxtSkillLimit = UI.Text:create()
    mTxtSkillLimit:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillLimit:setWidth(242)
    mTxtSkillLimit:autoAdapt()
    
    -- 描述
    local mTxtSkillDes2 = UI.Text:create()
    mTxtSkillDes2:init(UI.TEXT_111007..skillData.description, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    mTxtSkillDes2:setWidth(242)
    mTxtSkillDes2:autoAdapt()

    local showCondition = {}
    table.insert(showCondition, mTxtSkillLv)
    if skillData.type == SkillType.PASSIVE then
        mTxtSkillConsume:setVisible(false)
        mTxtSkillCD:setVisible(false)
        mTxtPrepareCD:setVisible(false)
    else
        mTxtSkillConsume:setVisible(true)
        mTxtSkillCD:setVisible(true)
        mTxtPrepareCD:setVisible(true)
        table.insert(showCondition, mTxtSkillConsume)
        table.insert(showCondition, mTxtSkillCD)
        table.insert(showCondition, mTxtPrepareCD)

        if skillData.costType == 1 then
            mTxtSkillConsume:setText(UI.TEXT_111005 .. string.format("%d", skillData.cost))
        else
            mTxtSkillConsume:setText(UI.TEXT_111004 .. string.format("%d", skillData.cost))
        end
        mTxtSkillCD:setText(UI.TEXT_111006 .. string.format("%.1f", skillData:getCooldown() / 1000))

        local prepareCD = ""
        if skillData:isActive() then
            if (skillData:getSkillType() == SkillType.PHYSICAL) then
                if skillData:getPrepareTime() <= 0 then
                    prepareCD = LanguageManager:getInstance():getLocalString(1111371)..LanguageManager:getInstance():getLocalString(1111372)
                else
                    prepareCD = LanguageManager:getInstance():getLocalString(1111371)..string.format("%.1f", skillData:getPrepareTime())
                end
            elseif (skillData:getSkillType() == SkillType.MAGIC) then
                if skillData:getPrepareTime() <= 0 then
                    prepareCD = LanguageManager:getInstance():getLocalString(1111370)..LanguageManager:getInstance():getLocalString(1111372)
                else
                    prepareCD = LanguageManager:getInstance():getLocalString(1111370)..string.format("%.1f", skillData:getPrepareTime())
                end
            end
            mTxtPrepareCD:setText(prepareCD)
        elseif skillData:isAssist() then
            mTxtPrepareCD:setText(prepareCD)
        end
    end

    local list = skillGroupData:getLimitSkills()
    if #list > 0  then
        local name = ""
        for k, v in ipairs(list) do
            name = name .. v.skillData:getName()
            if k ~= #list then
                name = name .. ", "
            end
        end
        mTxtSkillLimit:show()
        mTxtSkillLimit:setText(string.format(UI.TEXT_1213815, name))
        table.insert(showCondition, mTxtSkillLimit)
    else
        mTxtSkillLimit:hide()
    end
    table.insert(showCondition, mTxtSkillDes2)

    -- 根据排版设计位置
    local height = 0
    for k, v in ipairs(showCondition) do
        height = height + v:getContentSize().height
    end
    nextLvDesLayout:setSize(242, height + 50)

    height = 30
    for k, v in ipairs(showCondition) do
        v:leftUp(0, height)
        height = height + v:getContentSize().height
        nextLvDesLayout:addChild(v)
    end
    return nextLvDesLayout
end

--重置
function NewSkillLayer:onReset()
    if not self.mBChangeEquip then
        return
    end

    if SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave() then
        UI.ScrollBar:createByText(UI.TEXT_110056)
        return
    end
    if RoleDataManager:getMaster():isHorcruxTransform() then
        UI.ScrollBar:createByText(UI.TEXT_1212473)
        return
    end

    UI.ConfirmDialog.show(
        UI.TEXT_1212044,
        function()
            local studyNum, studyNum1 = SkillDataManager:getSkillStudyNum()
            if studyNum1 <= 0 then
                return
            end

            local forgetSkillNeedMateral = GameDataManager:getInstance():getForgetSkillNeedMateral()
            local forgetSkillNeedMaterialNumForLevel = self:getForgetSkillNeedMaterialNum()
            if
                forgetSkillNeedMateral and
                    tonumber(forgetSkillNeedMateral:getNum()) >= forgetSkillNeedMaterialNumForLevel 
             then
                if (RoleBehaviorManager:learnSkillCheck()) then
                    if not tolua.isnull(self) then
                        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                        self:updateResetButton()
                    end

                    Net.NetRoleSystem:heroResetStudySkill()
                end
            else
                UI.ScrollBar:createByText(UI.TEXT_1150006)
            end
        end
    )
end

function NewSkillLayer:onSettingHightLight()
    if(self._onSettingHightLight) then return end
    self.setAnimation:setAnimation("trigger", false)
    self.setAnimation:addAnimation("idle", true)
    self._onSettingHightLight = true
end

function NewSkillLayer:onSettingUnHightLight()
    if(not self._onSettingHightLight) then return end
    self._onSettingHightLight = false
    self.setAnimation:setAnimation("end", false)
end

--设置出战技能
function NewSkillLayer:onSetting()
    local panel = self.rootLayer:getChildByName("SelectFightSkillPanel")
    if panel then
        self.setAnimation:setAnimation("end", false)
        panel:playClose()
    else
        if(not self._onSettingHightLight) then
            if GameManager:getIsGooglePlay() then
                self._onSettingHightLight = true
            end
            self.setAnimation:setAnimation("trigger", false)
            self.setAnimation:addAnimation("idle", true)
        end

        if(self.isInHulu) then
            panel = UI.SelectFightSkillPanelHulu:create(self.mEquipType)
        else
            panel = UI.SelectFightSkillPanel:create(self.mEquipType)
        end
        panel:centerLeft(180)
        panel:setName("SelectFightSkillPanel")
        self.rootLayer:addChild(panel, 6)
        panel:setCloseCallback(handler(self, function()
            if self.mSelectSkillNode then
                self:refreshSkillInfo(SkillDataManager:getSkillGroup(self.mSelectSkillNode:getTag()))
            end
        end))
        panel:setOnselectCallback(handler(self, function(_, skillGroupData)
            if self.mSelectSkillNode then
                self.mSelectSkillNode:removeChildByName("selectEffect")
                self.mSelectSkillNode = nil
            end
            
            self:refreshSkillInfo(skillGroupData)
        end))
    end
end

--切换技能页
function NewSkillLayer:onChangeSkillTab(index)
    if(self.isInHulu) then 
        return 
    end
    
    local curTabIdx = SkillDataManager:getCurSkillSelectType() + 1
    if index == curTabIdx then
        return
    end
    local boughtLabelList = SkillDataManager:getBoughtSkillLabelListList()
    if self:isSkillLabelNeedBuy(index) and not boughtLabelList[index] then
        local config = ConfigManager:getGeneralForKey("skillPageUnlockCost")
        local costList = string.split(config, ";")
        local buySkillLabelTips = UI.Tips:createTips(string.format(UI.TEXT_223102, costList[index]),UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
        buySkillLabelTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            local curDiamond = RoleDataManager:getMaster():getDiamond()
            if (Avalon.MathUtil:checkDiamonEnough(tonumber(costList[index]), curDiamond)) then
                Net.NetRoleSystem:reqBuySkillLabel(index-1)
            else
                UI.TipsLayer:onDiamondNotEnough()
            end
        end)
        return
    end

    local isShow = cc.UserDefault:getInstance():getBoolForKey("skillchange" .. GameDataManager:getInstance():getMasterPK(), true)
    if isShow then
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1213218,
            function(isSelect)
                if isSelect then
                    cc.UserDefault:getInstance():setBoolForKey("skillchange" .. GameDataManager:getInstance():getMasterPK(), false)
                end
                self:sendToChangeSkillTree(index-1)
            end,
            function()
            end, nil, nil, true)
    else
        self:sendToChangeSkillTree(index-1)
    end
end


function NewSkillLayer:sendToChangeSkillTree(index)
    if RoleDataManager:getMaster():isHorcruxTransform() then
        UI.ScrollBar:createByText(UI.TEXT_1212473)
        return
    end
    if self.settingLayer then
        self:closeUserFightSkillView()
    end
    Avalon.AudioManager:playSound("1519")
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    -- local curTabIndex = SkillDataManager:getCurSkillSelectType()
    Net.NetRoleSystem:heroSkillSelectReq(index)
end

--移除选中技能的状态
function NewSkillLayer:showCanUpgradeAct()
    if(self.isInHulu) then 
        return 
    end

    if SkillDataManager:getSkillStudyNum() <= 0 then
        local mode = RoleDataManager:getReincarntionSkillMode()
        local skillTreeDatas = ConfigManager:getSkillTreeByType(mode, 0)
        for k, v in pairs(skillTreeDatas) do
            if v.hidden == 0 then
                local skillNode = self.mCommonSkillNode:getChildByTag(v.skillGroupID)
                local upgradeAct = skillNode:getChildByName("UpgradeAct")
                if upgradeAct then
                    upgradeAct:setAnimation("backgroungd_end", false)
                end
            end
        end

        local oldUpgradeAct = self.mEquipSkillNode:getChildByName("UpgradeAct")
        if oldUpgradeAct ~= nil then
            oldUpgradeAct:setAnimation("end", false)
        end
        return
    end

    --公共技能
    local skillMode = RoleDataManager:getReincarntionSkillMode()
    local skillTreeDatas = ConfigManager:getSkillTreeByType(skillMode, 0)
    for k, v in pairs(skillTreeDatas) do
        local skillNode = self.mCommonSkillNode:getChildByTag(v.skillGroupID)
        if v.hidden == 0 and skillNode then
            local skillGroupData = SkillDataManager:getSkillGroup(v.skillGroupID)

            if skillGroupData:getState() == Game.SkillIconState.StateLearned then
                local upgradeAct = skillNode:getChildByName("UpgradeAct")
                if upgradeAct == nil then
                    local upgradeAct = UI.Animation:create()
                    upgradeAct:init("effect_ui_package_title_skillprogress_open_down.json", "effect_ui_package_title_skillprogress_open_down.atlas")
                    upgradeAct:centerBottom(-95)
                    upgradeAct:setAnimation("backgroungd_begin", false)
                    upgradeAct:addAnimation("backgroungd_idle", true)
                    skillNode:addChild(upgradeAct, 5)
                    upgradeAct:setName("UpgradeAct")
                    upgradeAct:setScale(1 / IconScale)
                    upgradeAct:addEventListener(
                        UIEvent.ANIMATION_COMPLETE,
                        self,
                        function(sender, event, target)
                            if event.animation == "backgroungd_end" then
                                target:destroy()
                            end
                        end
                    )
                end
            else
                local upgradeAct = skillNode:getChildByName("UpgradeAct")
                if upgradeAct then
                    upgradeAct:setAnimation("backgroungd_end", false)
                end
            end
        end
    end

    if self:isHigherOrderSkill() then
        local oldUpgradeAct = self.mEquipSkillNode:getChildByName("UpgradeAct")
        if oldUpgradeAct then
            oldUpgradeAct:destroy()
        end
        return
    end
    --装备技能
    local skillMode = RoleDataManager:getReincarntionSkillMode()
    local skillTreeDatas = ConfigManager:getSkillTreeByType(skillMode, self.mEquipType, nil, self.mAdvanceType)
    local fixSkillNode = nil
    local fixSkillGroupData = nil
    local skillNodeList = {}
    for k, v in pairs(skillTreeDatas) do
        if v.hidden == 0 then
            local skillGroupData = SkillDataManager:getSkillGroup(v.skillGroupID)
            -------遗留问题，这样写会造成卡顿，原因不明--------------
            -- local skillNode, skillIcon = self:createSkillIcon(skillGroupData)
            -- if (skillNode and skillIcon) then
            --     if fixSkillNode == nil and skillGroupData:getState() == Game.SkillIconState.StateCanLearn then
            --         fixSkillNode = skillNode
            --         fixSkillGroupData = skillGroupData
            --     end
            -- end
            if fixSkillNode == nil and skillGroupData:getState() == Game.SkillIconState.StateCanLearn then
                local skillNode, skillIcon = self:createSkillIcon(skillGroupData)
                if (skillNode and skillIcon) then
                    fixSkillNode = skillNode
                    fixSkillGroupData = skillGroupData
                end
            end
        end
    end


    local isChangeEquipSkill = false
     --装备技能是否有改变
    if fixSkillNode ~= nil then
        local oldUpgradeAct = self.mEquipSkillNode:getChildByName("UpgradeAct")
        if oldUpgradeAct ~= nil and oldUpgradeAct:getTag() == fixSkillNode:getTag() then
            isChangeEquipSkill = false
        else
            isChangeEquipSkill = true
        end
    end

    for k, v in pairs(skillTreeDatas) do
        if v.hidden == 0 and isChangeEquipSkill then
            local skillNode = self.mEquipSkillNode:getChildByTag(v.skillGroupID)
            local skillGroupData = SkillDataManager:getSkillGroup(v.skillGroupID)
            local cap = skillNode:getChildByName("FORBIDCAP")
            if cap then
                cap:removeFromParent()
            end
            local disappearAct = skillNode:getChildByName("DISAPPEARACT")
            if disappearAct then
                if skillGroupData:getLevel() == 0 then
                    disappearAct:setAnimation("begin", false)
                else
                    disappearAct:removeFromParent()
                end
            end
        end
    end

    if fixSkillNode ~= nil then
        for k, v in pairs(skillTreeDatas) do
            if v.hidden == 0 then
                local skillNode = self.mEquipSkillNode:getChildByTag(v.skillGroupID)
                local skillGroupData = SkillDataManager:getSkillGroup(skillNode:getTag())
                if skillGroupData.storey == fixSkillGroupData.storey then
                    table.insert(skillNodeList, skillNode)
                end
            end
        end
    end

    if fixSkillNode ~= nil then
        local oldUpgradeAct = self.mEquipSkillNode:getChildByName("UpgradeAct")
        if oldUpgradeAct ~= nil and oldUpgradeAct:getTag() == fixSkillNode:getTag() then
            return
        end

        if oldUpgradeAct ~= nil then
            oldUpgradeAct:setAnimation("end", false)
        end

        local upgradeAct = UI.Animation:create()
        upgradeAct:init(
            "effect_ui_package_title_skillprogress_open.json",
            "effect_ui_package_title_skillprogress_open.atlas"
        )
        upgradeAct:setAnimation("begin", false)
        upgradeAct:addAnimation("idle", true)
        upgradeAct:leftBottom(fixSkillNode:getPositionX() + 1, 162)
        upgradeAct:setName("UpgradeAct")
        self.mEquipSkillNode:addChild(upgradeAct)
        upgradeAct:setTag(fixSkillNode:getTag())
        upgradeAct:addEventListener(
            UIEvent.ANIMATION_COMPLETE,
            self,
            function(sender, event, target)
                if event.animation == "end" then
                    target:destroy()
                end
            end
        )
        upgradeAct:setScaleX(IconScale)
    else
        local oldUpgradeAct = self.mEquipSkillNode:getChildByName("UpgradeAct")
        if oldUpgradeAct ~= nil then
            oldUpgradeAct:setAnimation("end", false)
        end
    end

    if isChangeEquipSkill then
        for k, skillNode in ipairs(skillNodeList) do
            local skillGroupData = SkillDataManager:getSkillGroup(skillNode:getTag())
            if skillGroupData:getState() ==  Game.SkillIconState.StateLock then
                local cap = UI.Image:create()
                cap:init("ui_skill_banner_transfer_no.png")
                cap:center()
                cap:setName("FORBIDCAP")
                skillNode:addChild(cap, 100)
            else
                local disappearAct = UI.Animation:create()
                disappearAct:init(
                    "effect_ui_package_title_skillprogress_lock.json",
                    "effect_ui_package_title_skillprogress_lock.atlas"
                )
                disappearAct:center()
                skillNode:addChild(disappearAct, 100)
                disappearAct:setName("DISAPPEARACT")
                disappearAct:addEventListener(
                    UIEvent.ANIMATION_COMPLETE,
                    self,
                    function(sender, event, target)
                        if event.animation == "begin" then
                            target:destroy()
                        end
                    end
                )
            end
        end
    end
end

function NewSkillLayer:switchSkillGroup(groupId, removeGroupId)
    print("--switchSkillGroup(groupId, removeGroupId)---", groupId, removeGroupId)
    local skillNode = self.mEquipSkillNode:getChildByTag(removeGroupId)
    skillNode:setTag(groupId)
    local skillGroupData = SkillDataManager:getSkillGroup(skillNode:getTag())
    local icon = skillNode:getChildByName("menu"):getChildByName("skillIcon")
    if icon then
        icon:setSpriteName(skillGroupData.skillData.iconID)
    end
    self:onSelectSkill(skillNode, false)
end

-- 注册监听事件
function NewSkillLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RESET_STUDY_SKILL, self, self.resetStudySkill)

    Avalon.MessageCenter:bind(AvalonMessage.MC_SKILL_STUDY_RESULT, self, self.studySkillResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SKILL_ACTIVE_STUDY_RESULT, self, self.studyActiveSkillResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SKILL_SELECT_TYPE_CHANGED, self, self.updateViewBySelectSkillTypeChanged)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SKILL_SWITCH_GROUP, self, self.switchSkillGroup)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SKILL_BOUGHT_LABEL, self, self.updateTabLayer)
end

-- 注销监听事件
function NewSkillLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RESET_STUDY_SKILL, self, self.resetStudySkill)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_SKILL_STUDY_RESULT, self, self.studySkillResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SKILL_ACTIVE_STUDY_RESULT, self, self.studyActiveSkillResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SKILL_SELECT_TYPE_CHANGED, self, self.updateViewBySelectSkillTypeChanged)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SKILL_SWITCH_GROUP, self, self.switchSkillGroup)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SKILL_BOUGHT_LABEL, self, self.updateTabLayer)
end

function NewSkillLayer:studySkillResult(data)
    UI.WaitingLayer:hideWaiting()
    self:showCanUpgradeAct()
    if (data == nil) then
        return
    end
    if (data.result ~= "ResponseCodeHeroStudySkillResultType_Succeed") then
        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.ResponseCodeHeroStudySkillResultType", data.result))
    end
end


function NewSkillLayer:resetStudySkill(data)
    UI.WaitingLayer:hideWaiting()
    if (data and data.result ~= "HeroResetStudySkillResultType_Succeed") then
        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.HeroResetStudySkillResultType", data.result))
        return
    end   
    UI.ScrollBar:createByText(UI.TEXT_1212024)
    self:refreshSkillList()
    local panel = self.rootLayer:getChildByName("SelectFightSkillPanel")
    if panel then
        self.setAnimation:setAnimation("end", false)
        panel:playClose()
    end
end

function NewSkillLayer:refreshSkillList()
    print("----refreshSkillList----")
    self:updateTabLayer()
    self:createEquiopSkill()
    self:createCommonSkill()
    self:showCanUpgradeAct()
    self:updateSkillStudyNum()
    self:updateResetButton()
end

function NewSkillLayer:updateSkillStudyNum()
    if(self.isInHulu) then 
        return 
    end
    self.txtTotalSkillPointNum:setText(tostring(SkillDataManager:getSkillStudyNum()))
end

--刷新消耗物品颜色
function NewSkillLayer:updateResetButton()
    local forgetSkillNeedMateral = GameDataManager:getInstance():getForgetSkillNeedMateral()
    local forgetSkillNeedMaterialNumForLevel = self:getForgetSkillNeedMaterialNum()
    if
        forgetSkillNeedMateral and
            tonumber(forgetSkillNeedMateral:getNum()) >= forgetSkillNeedMaterialNumForLevel
     then
        self.forgetSkillNeedMaterialNum:setTextColor(UI.FONT_COLOR_247_245_232)
        -- self.forgetSkillNeedMaterialNum:enableOutline(UI.FONT_COLOR_56_38_27,2)

        self.btnReset:enable()
    else
        self.forgetSkillNeedMaterialNum:setTextColor(UI.FONT_COLOR_244_18_12)
        -- self.forgetSkillNeedMaterialNum:enableOutline(UI.FONT_COLOR_OUTLINE_59_5_5,2)

        self.btnReset:enable()
    end

    local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_SKILL_RESET)
    if (repeatData) then
        self.btnReset:disable()
        return
    end

    local studyNum, studyNum1 = SkillDataManager:getSkillStudyNum()
    if studyNum1 <= 0 then
        self.btnReset:disable()
        return
    end

    --大秘境中不能重置技能
    if SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave() then
        self.btnReset:disable()
        return
    end
end

function NewSkillLayer:studyActiveSkillResult()
    UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(
        UI.TEXT_1212249,
        function()
            self:onSetting()
        end
    )
end

function NewSkillLayer:updateViewBySelectSkillTypeChanged()
    UI.WaitingLayer:hideWaiting()
    if(self.isInHulu) then 
        return
    end

    self:refreshSkillList()
    local panel = self.rootLayer:getChildByName("SelectFightSkillPanel")
    if panel then
        self.setAnimation:setAnimation("end", false)
        panel:playClose()
    end
end

function NewSkillLayer:showShareBtn(parentNode)
    --分享布局
    parentNode:showShareBtn(handler(self, self.createShareInfo), SHARE_MODULE.SHARE_MODULE_SKILL)
end

function NewSkillLayer:createShareInfo(platform)
    --print("SkillLayer:createShareInfo ==> platform", platform)
    local shareDatas = ConfigManager:getShareConfigByType(SHARE_MODULE.SHARE_MODULE_SKILL, platform)
    if shareDatas == nil then
        printWarn("----!!!! error !!!! SkillLayer shareDatas is nnil")
        return
    end

    local skillMode = RoleDataManager:getReincarntionSkillMode()
    local skillTreeDatas = ConfigManager:getSkillTreeByType(skillMode, self.mEquipType, nil, self.mAdvanceType)
    skillTreeDatas = SkillDataManager:checkReleateSkill(skillTreeDatas, self.mAdvanceType)
    local maxCount = 0
    for k, v in pairs(skillTreeDatas) do
        if v.hidden == 0 then
            local skillTreeData = v
            local userSkillTreeData = SkillDataManager:getSkillGroup(skillTreeData.skillGroupID)
            local lv = userSkillTreeData:getLevel()
            if lv > 0 and userSkillTreeData.level > 0 then
                maxCount = maxCount + 1
            end
        end
    end

    if maxCount == 0 then
        UI.ScrollBar:createByText(UI.TEXT_1150020)
        return
    end

    if not tolua.isnull(self._ShareNode) then
        self._ShareNode:removeFromParent(true)
    end

    local allList = {}
    local uiData = {
        size = nil, cellNumber = nil, rowNumber = nil, height = nil, width = nil,
    }

    if self:isHigherOrderSkill() then--self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeTwo then
        for k, v in pairs(skillTreeDatas) do
            if v.hidden == 0 then
                local skillGroupData = SkillDataManager:getSkillGroup(v.skillGroupID)
                skillGroupData:refreshSkillState()
                table.insert(allList, skillGroupData)
            end
        end

        table.sort(
            allList,
            function(a, b)
                return a.skillData.skillID < b.skillData.skillID
            end
        )

        uiData.size = #allList
        uiData.cellNumber = 2
        uiData.rowNumber = math.ceil(6 / uiData.cellNumber)
        uiData.height = uiData.rowNumber * 165 + (uiData.rowNumber - 1) * 80 + 165
        uiData.width = uiData.cellNumber * 157 + (uiData.cellNumber - 1) * 100
    else
        for k, v in pairs(skillTreeDatas) do
            if v.hidden == 0 then
                local skillTreeData = v
                local userSkillTreeData = SkillDataManager:getSkillGroup(skillTreeData.skillGroupID)
                local lv = userSkillTreeData:getLevel()
                if lv > 0 and userSkillTreeData.level > 0 then
                    local skillID = skillTreeData.skillIDList[lv]
                    local skillData = SkillDataManager:createSkillForSkillId(skillID)
                    if (skillData ~= nil) then
                        skillData.userSkillTreeData = userSkillTreeData
                        skillData.skillTreeData = skillTreeData
                        table.insert(allList, skillData)
                    end
                end
            end
        end
    
        table.sort(
            allList,
            function(a, b)
                return a.skillTreeData.storey < b.skillTreeData.storey
            end
        )

        uiData.size = #allList
        uiData.cellNumber = 3
        if uiData.size <= 2 then
            uiData.cellNumber = 1
        elseif uiData.size <= 4 then
            uiData.cellNumber = 2
        end
        uiData.rowNumber = math.ceil(uiData.size / uiData.cellNumber)
        uiData.height = uiData.rowNumber * 165 + (uiData.rowNumber - 1) * 80
        uiData.width = uiData.cellNumber * 157 + (uiData.cellNumber - 1) * 46
    end

    local _ShareNode = cc.Node:create()
    _ShareNode:setPosition(5000, 0)
    cc.Director:getInstance():getRunningScene():addChild(_ShareNode, -1)
    self._ShareNode = _ShareNode

    self.shareBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_share_banner_2.png")
    self.shareBg:setCapInsets(cc.rect(0, 587, 640, 2))
    self.shareBg:setContentSize(cc.size(640, 1136))
    self.shareBg:setPosition(self.shareBg:getContentSize().width / 2, self.shareBg:getContentSize().height / 2)
    self._ShareNode:addChild(self.shareBg)
    local targetHeight = 600 + uiData.height
    if targetHeight > 1136 then
        self.shareBg:setContentSize(cc.size(640, targetHeight))
    else
        self.shareBg:setContentSize(cc.size(640, 1136))
    end
    self.shareBg:setPosition(self.shareBg:getContentSize().width / 2, self.shareBg:getContentSize().height / 2)

    -- 公司LOGO1
    local logo = UI.Image:create()
    logo:init("ui_share_logo2.png")
    logo:rightUp(60, 30)
    self.shareBg:addChild(logo)

    -- 公司LOGO2
    local logo = UI.Image:create()
    logo:init("ui_share_logo.png")
    logo:rightBottom(20, 20)
    self.shareBg:addChild(logo)

    local text = ""
    local iconBgName = ""
    local skillIconCapName = ""

    if self:isHigherOrderSkill() then--self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeTwo then
        iconBgName = "ui_share_transfer_2.png"
        skillIconCapName = "ui_skill_banner_transfer_below_up_2.png"

        text = UI.TEXT_1213802
        self:createShareTypeTwoInfo(uiData, allList)
    else
        iconBgName = "ui_share_transfer.png"
        skillIconCapName = "ui_skill_banner_transfer_below_up.png"

        if self.mEquipType == 1 then
            text = UI.TEXT_1150015
        elseif self.mEquipType == 2 then
            text = UI.TEXT_1150016
        elseif self.mEquipType == 3 then
            text = UI.TEXT_1150017
        end
        self:createShareTypeOneInfo(uiData, allList)
    end

    if (RoleDataManager:getMasterSkillTreeModel() ~= Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
        local iconBg = UI.Image:create()
        iconBg:init(iconBgName)
        iconBg:centerUp(310)
        self.shareBg:addChild(iconBg)

        local skillIconBg = UI.Image:create()
        skillIconBg:init("ui_skill_banner_transfer_below.png")
        skillIconBg:centerUp(239)
        self.shareBg:addChild(skillIconBg)

        local skillIconCap = UI.Image:create()
        skillIconCap:init(skillIconCapName)
        skillIconCap:center()
        skillIconBg:addChild(skillIconCap, 12)

        local skillNowAnimation = UI.Animation:create()
        skillNowAnimation:init(
            self.equipAnimationIcon[self.mEquipType] .. ".json",
            self.equipAnimationIcon[self.mEquipType] .. ".atlas"
        )
        skillNowAnimation:setAnimation("idle", true)
        skillNowAnimation:center()
        skillIconBg:addChild(skillNowAnimation)
    end

    local titleText = UI.Text:create()
    if LanguageManager:getInstance():isCJKUnicode() then
        titleText:init(string.format(UI.TEXT_1150014, RoleDataManager:getMaster():getNickName()) .. text, UI.FONT_ARIAL)
    else
        titleText:init(string.format(UI.TEXT_1150014, RoleDataManager:getMaster():getNickName()) .. " " .. text, UI.FONT_ARIAL)
    end
    titleText:setFontSize(40)
    titleText:setFontColor(UI.FONT_COLOR_255_204_0)
    titleText:rightUp(22, 98)
    titleText:setSize(350, 120)
    titleText:setTextCenter()
    self.shareBg:addChild(titleText)

    local sprite = SdkBox:getInstance():createQRSprite(shareDatas.url)
    sprite:setPosition(47, 45)
    sprite:setScale(70 / sprite:getContentSize().width)
    self.shareBg:addChild(sprite)

    performWithDelay(
        _ShareNode,
        function()
            local SdkBox = require("utils.sdkbox.SdkBox")
            SdkBox:getInstance():createImage(
                self.shareBg,
                "share.png",
                function(path)
                    SdkBox:getInstance():share(
                        {
                            channel = platform,
                            link = shareDatas.url,
                            content = LanguageManager:getInstance():getLocalString(
                                shareDatas.content[math.random(1, table.nums(shareDatas.content))]
                            ),
                            type = PublicDefine.SHARE_CONTENT_TYPE.IMAGE,
                            -- stype = Avalon.WXScene.WXSceneTimeline
                            title = LanguageManager:getInstance():getLocalString(
                                shareDatas.title[math.random(1, table.nums(shareDatas.title))]
                            ),
                            thumb = AvalonUtil.getShareThumbPath(shareDatas),
                            image = path
                        }
                    )
                    if _ShareNode and not tolua.isnull(_ShareNode) then
                        _ShareNode:setVisible(false)
                        _ShareNode:runAction(cc.RemoveSelf:create())
                    end
                end
            )
        end,
        0.05
    )
end

-- 一阶技能分享
function NewSkillLayer:createShareTypeOneInfo(uiData, allList)
    -- print("SkillLayer:createShareTypeOneInfo", self.mAdvanceType, uiData.size)

    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(uiData.width, uiData.height)
    if uiData.size == 1 then
        layout:centerUp(500)
    else
        layout:centerUp(395)
    end
    self.shareBg:addChild(layout)

    --创建
    local function createOneSkillPanel(skillData)
        -- body
        local bg = UI.Image:create()
        bg:init("ui_share_box_2.png")

        local skillIcon = UI.Image:create()
        skillIcon:init(skillData.iconID)
        skillIcon:centerUp(30)
        bg:addChild(skillIcon, 100)
        local iconBg = UI.Image:create()
        if (RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
            iconBg:init("ui_share_skillbox.png")
            iconBg:center()
        else
            local skillCap = UI.Image:create()
            skillCap:init("ui_skill_banner_skillbox_transfer.png")
            skillCap:center()
            skillIcon:addChild(skillCap, 10)
            iconBg:init("ui_share_box_1.png")
            iconBg:center(0, 7)
        end
        skillIcon:addChild(iconBg, -1)
        local userSkillTreeData = skillData.userSkillTreeData

        local skillName = UI.Text:create()
        skillName:init(skillData.name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
        skillName:centerUp(-39)
        skillName:setSize(125, 42)
        skillName:setTextCenter()
        skillName:setLineSpacing(-5)
        bg:addChild(skillName, 100)

        if userSkillTreeData.level == 0 then
        else
            if userSkillTreeData:getChangeLv() ~= 0 then
                local strengthen = UI.Image:create()
                strengthen:init("ui_skill_icon_strengthening.png")
                strengthen:rightUp(1, 1)
                skillIcon:addChild(strengthen, 500)
            end
        end
        return bg
    end

    local function createOneRow(rowIndex, datalist)
        local rowPanel = UI.Layout:create()
        rowPanel:init()
        rowPanel:setSize(#datalist * 157 + (#datalist - 1) * 46, 165)
        for k, v in ipairs(datalist) do
            local skillPanel = createOneSkillPanel(v)
            local noArrowIndex = 1
            if rowIndex % 2 == 0 then
                skillPanel:centerRight((k - 1) * 205)
                noArrowIndex = #datalist
            else
                skillPanel:centerLeft((k - 1) * 205)
                noArrowIndex = 1
            end
            rowPanel:addChild(skillPanel)
            if k ~= noArrowIndex then
                local arrow = UI.Image:create()
                arrow:init("ui_share_arrow_1.png")
                if rowIndex % 2 == 0 then
                    arrow:setScaleX(-1)
                end
                skillPanel:addChild(arrow)
                arrow:leftUp(-45, 50)
            end
        end
        return rowPanel
    end

    local function createRowArrow(index, lastCount, curCount)
        if index ~= 1 then
            local arrow = UI.Image:create()
            if lastCount == curCount then
                arrow:init("ui_share_arrow_2.png")
                if index % 2 == 0 then
                    arrow:rightUp(70, -75)
                else
                    arrow:leftUp(70, -75)
                end
            elseif lastCount - curCount == 1 then
                arrow:init("ui_share_arrow_3.png")
                if index % 2 == 0 then
                    arrow:rightUp(-130, -188)
                else
                    arrow:setScaleX(-1)
                    arrow:leftUp(-130, -188)
                end
            elseif lastCount - curCount == 2 then
                arrow:init("ui_share_arrow_4.png")
                if index % 2 == 0 then
                    arrow:rightUp(-120, -70)
                else
                    arrow:setScaleX(-1)
                    arrow:leftUp(-120, -70)
                end
            end
            return arrow
        end
    end

    local lastRowCount = 0
    for i = 1, uiData.rowNumber do
        local subList = {}
        for j = 1, uiData.cellNumber do
            local index = (i - 1) * uiData.cellNumber + j
            if allList[index] ~= nil then
                table.insert(subList, allList[index])
            end
        end
        local rowPanel = createOneRow(i, subList)
        local arrow = createRowArrow(i, lastRowCount, #subList)
        if arrow then
            rowPanel:addChild(arrow)
        end

        rowPanel:centerUp((i - 1) * 245)
        layout:addChild(rowPanel)
        lastRowCount = #subList
    end

end

-- 二阶技能分享
function NewSkillLayer:createShareTypeTwoInfo(uiData, allList)
    -- print("SkillLayer:createShareTypeTwoInfo", self.mAdvanceType, uiData.size)

    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(uiData.width, uiData.height)
    layout:centerUp(480)
    self.shareBg:addChild(layout)

    local function createOneSkillPanel(skillGroupData)

        local skillData = skillGroupData.skillData
        local bg = UI.Image:create()
        bg:init("ui_share_box_3.png")

        local skillIcon = UI.Image:create()
        skillIcon:init(skillData.iconID)
        skillIcon:leftUp(23, 30)
        skillIcon:setName("skillIcon")
        bg:addChild(skillIcon, 100)

        local iconBg = UI.Image:create()
        iconBg:setName("iconBg")
        if (RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
            iconBg:init("ui_share_skillbox.png")
            iconBg:center()
        else
            local skillCap = UI.Image:create()
            skillCap:init("ui_skill_banner_skillbox_order2.png")
            skillCap:setName("skillCap")
            skillCap:center()
            skillIcon:addChild(skillCap, 10)
            iconBg:init("ui_share_box_1.png")
            iconBg:center(0, 7)
        end
        skillIcon:addChild(iconBg, -1)

        local skillName = UI.Text:create()
        skillName:init(skillData.name, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
        skillName:leftUp(8,-39)
        skillName:setSize(125, 42)
        skillName:setTextCenter()
        skillName:setLineSpacing(-5)
        bg:addChild(skillName, 100)

        local lvBg = UI.Image:create()
        lvBg:init("ui_share_lv_box.png")
        lvBg:setName("lvBg")
        lvBg:rightBottom(1, 1)
        bg:addChild(lvBg, 500)

        local lvTxt = UI.Text:create()
        lvTxt:init(tostring(skillGroupData:getLevel()), UI.FONT_BOLD, UI.FONT_SIZE_35PX, UI.FONT_COLOR_0_0_0)
        lvTxt:center()
        lvBg:addChild(lvTxt, 10)

        local progressBg = UI.Image:create()
        progressBg:init("ui_share_lv_bg.png")
        progressBg:rightBottom(0, 0)
        progressBg:setName("progressBg")
        bg:addChild(progressBg, 100)

        if skillGroupData:getState() ~= Game.SkillIconState.StateLearned then
            local skillIcon = bg:getChildByName("skillIcon")
            skillIcon:setGray(true)
            skillIcon:getChildByName("skillCap"):setGray(true)
            skillIcon:getChildByName("iconBg"):setGray(true)
            bg:getChildByName("lvBg"):setGray(true)
        end

        for i = 1, 5 do
            local progress = UI.Image:create()
            progress:init()
            progress:leftUp(9 + (i - 1) * 18, 4)
            progressBg:addChild(progress, 10)
            if i <= skillGroupData:getLevel() then
                progress:setSpriteName("ui_share_lv_progressbar_1.png")
            else
                progress:setSpriteName("ui_share_lv_progressbar_0.png")
            end
        end    
         
        return bg
    end

    local function createOneRow(rowIndex, datalist)
        local rowPanel = UI.Layout:create()
        rowPanel:init()
        rowPanel:setSize(414, 170)
        for k, v in ipairs(datalist) do
            local skillPanel = createOneSkillPanel(v)
            skillPanel:leftUp((k - 1) * 270, 0)
            rowPanel:addChild(skillPanel)
        end
        return rowPanel
    end

    local lastRowCount = 0
    for i = 1, uiData.rowNumber do
        local subList = {}
        for j = 1, uiData.cellNumber do
            local index = (i - 1) * uiData.cellNumber + j
            if allList[index] ~= nil then
                table.insert(subList, allList[index])
            end
        end
        local rowPanel = createOneRow(i, subList)
        rowPanel:centerUp((i - 1) * 245)
        layout:addChild(rowPanel)
        lastRowCount = #subList
    end

end

function NewSkillLayer:getSkillBoxSpriteName()
    if (RoleDataManager:getMasterSkillTreeModel() == Game.SkillTreeModel.SKILL_TREE_MODEL_NORMAL) then
        return "ui_skill_banner_skillbox.png"
    else
        return "ui_skill_banner_skillbox_transfer_bg.png"
    end
end

-- 切换技能页
function NewSkillLayer:updateTabLayer()
    local curTabIdx = SkillDataManager:getCurSkillSelectType() + 1
    -- self.tabBtn:setSpriteName(string.format("ui_skill_banner_page_1_%d.png", curTabIdx))
    local boughtLabelList = SkillDataManager:getBoughtSkillLabelListList()
    for k, v in pairs(self.tabBtnList) do
        if k == curTabIdx then
            v:setSpriteName("ui_skill_banner_page_1_1.png")
        else
            v:setSpriteName("ui_skill_banner_page_1_2.png")
        end
        -- print("updateTabLayer:", k, self:isSkillLabelNeedBuy(k), boughtLabelList[k])
        if self:isSkillLabelNeedBuy(k) then
            local lock = v:getChildByName("lock")
            lock:setVisible(not boughtLabelList[k])
        end
    end
    -- self.tabTxt:setText(string.format(UI.TEXT_1213817, curTabIdx))    
    -- self.tabTxt:leftUp(55, 36 - self.tabTxt:getContentSize().height / 2)

    if self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeTwo then
        self.tip:setText(UI.TEXT_1213813)
    elseif self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeThree then
        self.tip:setText(UI.TEXT_223101)
    end
end

function NewSkillLayer:updateLevelLayer(advanceType)
    if(self.isInHulu) then 
        return 
    end
    if self.mAdvanceType == advanceType then
        return
    end
    self.mAdvanceType = advanceType
    if self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeTwo then
        self.levelBtn2:show()
        self.levelTxt2:setFontColor(UI.FONT_COLOR_41_41_45)
        self.levelBtn1:hide()
        self.levelTxt1:setFontColor(UI.FONT_COLOR_104_95_94) 
        self.levelBtn3:hide()
        self.levelTxt3:setFontColor(UI.FONT_COLOR_104_95_94) 
    elseif self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeThree then
        self.levelBtn3:show()
        self.levelTxt3:setFontColor(UI.FONT_COLOR_41_41_45)
        self.levelBtn1:hide()
        self.levelTxt1:setFontColor(UI.FONT_COLOR_104_95_94) 
        self.levelBtn2:hide()
        self.levelTxt2:setFontColor(UI.FONT_COLOR_104_95_94) 
    else
        self.levelBtn1:show()
        self.levelTxt1:setFontColor(UI.FONT_COLOR_41_41_45)
        self.levelBtn2:hide()
        self.levelTxt2:setFontColor(UI.FONT_COLOR_104_95_94) 
        self.levelBtn3:hide()
        self.levelTxt3:setFontColor(UI.FONT_COLOR_104_95_94) 
    end
    self:refreshSkillList()
end

-- 切换技能页
function NewSkillLayer:isHigherOrderSkill()
    local isHigherOrder = false
    if self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeTwo 
    or self.mAdvanceType == Game.SkillAdvanceType.AdvanceTypeThree then
        isHigherOrder = true
    end
    return isHigherOrder
end

-- 是否是付费技能页
function NewSkillLayer:isSkillLabelNeedBuy(index)
    local isNeed = false
    if index == 3 then
        isNeed = true
    end
    return isNeed
end

function NewSkillLayer:getForgetSkillNeedMaterialNum()
    local num = 0
    local master = RoleDataManager:getMaster()
    local heroLevel = master:getLevel()
    local forgetSkillNeedMaterialLevelList = string.split(ConfigManager:getGeneralForKey("forgetSkillNeedMaterialNum"), ";")
    for k, v in pairs(forgetSkillNeedMaterialLevelList) do
        local list = string.split(v, ",")
        if heroLevel < tonumber(list[1]) then
            break
        end
        num = tonumber(list[2])
    end

    return num
end


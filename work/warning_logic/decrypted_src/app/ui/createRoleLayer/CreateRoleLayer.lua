-- CreateRoleLayer.lua
-- Author:ODEI
-- 2017年10月19日
-- Using:创建角色 
local ProtobufUtil = require "utils.ProtobufUtil"
require "utils.message.MessageCenter"
require "app.config.ConfigManager"
require "app.utils.ToolsUtil"
require "app.ui.baglayer.RoleShow.RoleAnimation"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local NICK_NAME_WIDTH = 145
local CreateRoleLayer = class("CreateRoleLayer", UI.HWBtnComponent)
UI.CreateRoleLayer = CreateRoleLayer


local winSize = cc.Director:getInstance():getWinSize()
local MAIN_PANEL_BG_FRAME_Z = 500
local SKELETON_Z = 520
local ROLE_GREY_BG_Z = 530
local VINE_Z = 540
local MAIN_PANEL_Z = 1000


-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_login_createRole.plist",
    "ui_common_btn.plist"
}


--构造函数(必备)
function CreateRoleLayer:ctor(spriteID, data)
    --窗口大小
    CreateRoleLayer.super.ctor(
    self, UIType.CREATE_ROLE_LAYER,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )
    self.spriteID = spriteID
    self.data = data
    self.rootLayer = nil;           --root节点

    self:initData()
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();
    self._hairSelectNum = 0;
    self._eyeSelectNum = 0;
    self._mouthSelectNum = 0;
    self._skinSelectNum = 0;
    self._sexSelectNum = -1; --因为默认就会选择一次
    self._tRandomNum = 0;
end

--虚构函数, destroy时调用(必备)
function CreateRoleLayer:dtor()
    CreateRoleLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化(必备)
function CreateRoleLayer:init()
    CreateRoleLayer.super.init(self)
    cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isFirstEnterTown, true)
end

function CreateRoleLayer:initData()

    self.faceBodyData = {UI.TEXT_110090, UI.TEXT_110091, UI.TEXT_110092}
    self.faceData = ConfigManager:serializeFaceConfig()

    for complexion, v in pairs(self.faceData) do
        for faceType, v1 in pairs(v) do
            for id, v2 in pairs(v1) do
                if v2.createRole == 0 then
                    self.faceData[complexion][faceType][id] = nil
                end
            end
        end
    end

    self.mSelectBodyID = math.random(1, table.nums(self.faceBodyData))
    self.mSelectHairID = math.random(1, table.nums(self.faceData[self.mSelectBodyID][1]))
    self.mSelectEyeID = math.random(1, table.nums(self.faceData[self.mSelectBodyID][2]))
    self.mSelectMouthID = math.random(1, table.nums(self.faceData[self.mSelectBodyID][4]))
    self.faceDecodeID = ToolsUtil:makeFaceDecodeID(self.mSelectBodyID, self.mSelectHairID, self.mSelectEyeID, self.mSelectMouthID)

    self.sex = math.random(1, 2)

end

-- 模版函数：初始化组建的视图(必备)
function CreateRoleLayer:onInitView()
    -- 灰色背景
    local colorLayer = UI.Image9:create()
    colorLayer:init("ui_scale9image_black.png", CCRectMake(0,0,1,1), cc.size(UI.size.width, UI.size.height))
    colorLayer:leftBottom(0, 0)
    colorLayer:setOpacity(120)
    self:addChild(colorLayer)

    -- root节点
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:setSize(winSize.width, winSize.height)
    self.rootLayer:leftBottom(0, 0)
    self:addChild(self.rootLayer)


    -- 主窗口框架
    self.picBgFrame = UI.Image:create()
    self.picBgFrame:init("ui_createrole_banner_frame.png")
    self.picBgFrame:center()
    self.rootLayer:addChild(self.picBgFrame, MAIN_PANEL_Z)

    -- 角色站点
    local standingGround = UI.Image:create()
    standingGround:init("ui_createrole_banner_table.png")
    standingGround:leftBottom(112, 37)
    self.picBgFrame:addChild(standingGround)


    -- 男性角色动画
    self._maleRoleAnimation = UI.RoleAnimation:create(false)
    local maleRData = Data.HeroData:create()
    maleRData:setSex(1)
    maleRData:setFaceDecodeID(self.faceDecodeID)
    self._maleRoleAnimation:hideHelmet()
    self._maleRoleAnimation:init(maleRData)
    self._maleRoleAnimation:setScaleX(-1)
    self._maleRoleAnimation:leftBottom(154, 135)
    self._maleRoleAnimation:showBlink(true)
    self.picBgFrame:addChild(self._maleRoleAnimation)


    -- 女性角色动画
    self._femaleRoleAnimation = UI.RoleAnimation:create(false)
    local femaleData = Data.HeroData:create()
    femaleData:setSex(2)
    femaleData:setFaceDecodeID(self.faceDecodeID)
    self._femaleRoleAnimation:hideHelmet()
    self._femaleRoleAnimation:init(femaleData)
    self._femaleRoleAnimation:setScaleX(-1)
    self._femaleRoleAnimation:leftBottom(154, 135)
    self._femaleRoleAnimation:showBlink(true)
    self.picBgFrame:addChild(self._femaleRoleAnimation)
    self._femaleRoleAnimation:hide()


    -- 男性标签按钮
    local btnMale = UI.Button:create()
    btnMale:init("ui_createrole_button_boy_1.png",
        "ui_createrole_button_boy_0.png")
    btnMale:leftBottom(491, 359)
    btnMale:addEventListener(UIEvent.BUTTON_CLICK, self, self.onMale)
    self.picBgFrame:addChild(btnMale, 100)
    self.btnMale = btnMale


    -- 女性标签按钮
    local btnFemale = UI.Button:create()
    btnFemale:init("ui_createrole_button_girl_0.png",
        "ui_createrole_button_girl_0.png")
    btnFemale:leftBottom(590, 359)
    btnFemale:addEventListener(UIEvent.BUTTON_CLICK, self, self.onFemale)
    self.picBgFrame:addChild(btnFemale, 100)
    self.btnFemale = btnFemale


    -- 外观部分选择按钮列表
    for i = 1, 4 do
        local selectFacebg = UI.Component:create()
        selectFacebg:init()
        selectFacebg:setSize(235, 50)
        selectFacebg:leftBottom(440, 358 - 50 * i)
        selectFacebg:setName("faceNode"..i)
        self.picBgFrame:addChild(selectFacebg, 100)

        local btnLeftArrow = UI.Button:create()
        btnLeftArrow:init("ui_createrole_thn_arrow_0.png",
            "ui_createrole_thn_arrow_1.png")
        btnLeftArrow:leftBottom(0, 0)
        btnLeftArrow:addEventListener(UIEvent.BUTTON_CLICK, self, self.onLast)
        btnLeftArrow:setTag(i)
        btnLeftArrow:setScaleX(-1)
        selectFacebg:addChild(btnLeftArrow, 100)

        local btnRightArrow = UI.Button:create()
        btnRightArrow:init("ui_createrole_thn_arrow_0.png",
            "ui_createrole_thn_arrow_1.png")
        btnRightArrow:leftBottom(222, 0)
        btnRightArrow:addEventListener(UIEvent.BUTTON_CLICK, self, self.onNext)
        btnRightArrow:setTag(i)
        selectFacebg:addChild(btnRightArrow, 100)

        local txtFaceName = UI.Text:create()
        txtFaceName:init("111", UI.FONT_STANDARD, UI.FONT_SIZE_18PX)
        txtFaceName:centerUp(20)
        txtFaceName:setFontColor(UI.FONT_COLOR_41_41_45)
        txtFaceName:setTextCenter()
        txtFaceName:setName("faceName")
        selectFacebg:addChild(txtFaceName, 100)
    end
    self:refreshPart(1)


    --随机按钮
    self.mBtnRandom = UI.Button:create()
    self.mBtnRandom:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    local btnWidth, _ = self.mBtnRandom:getSize()
    self.mBtnRandom:leftBottom(557 - (btnWidth / 2), 94)
    self.mBtnRandom:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRandom)
    self.picBgFrame:addChild(self.mBtnRandom)

    self.mTxtChangeFace = UI.Text:create()
    self.mTxtChangeFace:init(UI.TEXT_110094, UI.FONT_BOLD, UI.FONT_SIZE_20PX)
    self.mTxtChangeFace:center()
    self.mTxtChangeFace:setFontColor(UI.FONT_COLOR_50_50_44)
    self.mTxtChangeFace:setTextCenter()
    self.mBtnRandom:addChild(self.mTxtChangeFace, 100)


    -- 开始按钮
    local loginButton = UI.Button:create() 
    loginButton:init("ui_createrole_bth_enter_0.png", "ui_createrole_bth_enter_1.png", "ui_createrole_bth_enter_0.png")
    loginButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_36PX, UI.FONT_COLOR_ENTER_GAME_BUTTON_TEXT)
    loginButton:setTextShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -4))
    loginButton:setTextOffset(0, -4)
    loginButton:setText(UI.TEXT_110095)
    loginButton._text:setZOrder(11)
    loginButton:centerBottom(0)
    loginButton:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        if (not self.mGoBtnDisabled) then
            self:onGo()
        end
    end)
    self.picBgFrame:addChild(loginButton)

    -- 根据按钮文字适配按钮面板
    local btnWidth = loginButton._text._width + 100
    local btnHeight = loginButton._height
    if (btnWidth > loginButton._width) then
        local ButtonNormal = UI.Image9:create()
        ButtonNormal:init("ui_createrole_bth_enter_0.png", CCRectMake(163, 0, 2, 64), cc.size(btnWidth, btnHeight))
        ButtonNormal:center()
        loginButton:setNormalNode(ButtonNormal)

        local ButtonActive = UI.Image9:create()
        ButtonActive:init("ui_createrole_bth_enter_1.png", CCRectMake(163, 0, 2, 64), cc.size(btnWidth, btnHeight))
        ButtonActive:center()
        loginButton:setSelectedNode(ButtonActive)
        loginButton:setSize(btnWidth, btnHeight)
    end
    AvalonUtil.addBracketsAnimationToButton(loginButton, "effect_ui_login_createrole_button", 10, 5, true)


    -- 悬挂框上的提示文字
    local introText = UI.Text:create()
    introText:init(UI.TEXT_110096, UI.FONT_STANDARD, UI.FONT_SIZE_20PX)
    introText:leftBottom(-180, -40)
    introText:setSize(400, 100)
    introText:setFontColor(UI.FONT_COLOR_170_170_170)
    introText:setTextCenter()


    -- 悬挂随机名字按钮
    self.mBtnRandomName = UI.Button:create()
    self.mBtnRandomName:init("ui_createrole_thn_0.png", "ui_createrole_thn_1.png", "ui_createrole_thn_2.png")
    self.mBtnRandomName:leftBottom(-37, -18)
    self.mBtnRandomName:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRandomName)

    local iconRandomName = UI.Image:create()
    iconRandomName:init("ui_createrole_thn_dice01_0.png")
    iconRandomName:center()
    self.mBtnRandomName:setNormalNode(iconRandomName)

    local iconRandomName = UI.Image:create()
    iconRandomName:init("ui_createrole_thn_dice01_1.png")
    iconRandomName:center()
    self.mBtnRandomName:setSelectedNode(iconRandomName)


    -- 悬挂栏输入框
    local transparentInputBackground = cc.Scale9Sprite:createWithSpriteFrameName("ui_createrole_thn_0.png")
    transparentInputBackground:setOpacity(0)
    local libIDEdit = cc.EditBox:create({width = 190, height = 25}, transparentInputBackground, transparentInputBackground, transparentInputBackground)
    libIDEdit:setFontSize(18)
    libIDEdit:setPlaceholderFontSize(UI.FONT_SIZE_18PX)
    libIDEdit:setPlaceHolder(self:getInputPlaceStr())
    libIDEdit:setPlaceholderFontColor(UI.FONT_COLOR_170_170_170)
    libIDEdit:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
    libIDEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    libIDEdit:setPosition(0, 0)
    if(self:toShieldInputName()) then 
        libIDEdit:setEnabled(false)
    end
    libIDEdit:registerScriptEditBoxHandler(handler(self, self.editboxEventHandler))
    self.libIDEdit = libIDEdit


    -- 悬挂栏动画
    local upSpine = UI.Animation:create()
    upSpine:init("effect_ui_login_createrole_up.json", "effect_ui_login_createrole_up.atlas", 1);
    upSpine:leftBottom(370, 570)
    self.picBgFrame:addChild(upSpine)
    if device.platform == "mac" then
        upSpine:setAnimation("idle2", true)
    else
        upSpine:setAnimation("idle1", true)
    end
    upSpine:addComponent("jiedian01", introText)
    upSpine:addComponent("jiedian02", libIDEdit)
    upSpine:addComponent("jiedian03", self.mBtnRandomName)


    -- 乌鸦
    local karasuSpine = UI.Animation:create()
    karasuSpine:init("effect_ui_login_createrole_bird.json", "effect_ui_login_createrole_bird.atlas", 1);
    karasuSpine:leftBottom(692, 483)
    karasuSpine:setAnimation("idle1", false)
    karasuSpine._spine:registerSpineEventHandler(function (event)
        if (math.random(4) == 1) then
            karasuSpine:setAnimation("idle2", false)
        else
            karasuSpine:setAnimation("idle1", false)
        end
    end, sp.EventType.ANIMATION_COMPLETE)
    self.picBgFrame:addChild(karasuSpine)


    -- 主窗口框架背景宿主, 和主窗口一样大
    self.picBgFrameBg = UI.Layout:create()
    self.picBgFrameBg:init()
    self.picBgFrameBg:setSize(self.picBgFrame:getSize())
    self.picBgFrameBg:center()
    self.rootLayer:addChild(self.picBgFrameBg, MAIN_PANEL_BG_FRAME_Z)


    -- 灰色角色背景
    local greyBg = cc.DrawNode:create()
    greyBg:setContentSize(363, 447)
    greyBg:drawSolidRect(
        {x = 0, y = 0}, 
        {x = 363, y = 447}, 
        {r = 0.0862745098, g = 0.0862745098, b = 0.0862745098, a = 0.85}
    )
    -- greyBg:setOpacity(0.85)
    greyBg:setPosition(cc.p(43, 22))
    self.picBgFrameBg:addChild(greyBg, ROLE_GREY_BG_Z)


    -- 左下骷髅
    local skeletonSpine = UI.Animation:create()
    skeletonSpine:init("effect_ui_login_createrole_down.json", "effect_ui_login_createrole_down.atlas", 1);
    skeletonSpine:leftBottom(60, 34)
    skeletonSpine:setAnimation("idle", true)
    self.picBgFrameBg:addChild(skeletonSpine, SKELETON_Z)


    -- 背景藤蔓
    local vineSkeleton = UI.Animation:create()
    vineSkeleton:init("effect_ui_login_createrole_mid.json", "effect_ui_login_createrole_mid.atlas", 1);
    vineSkeleton:leftBottom(395, 295)
    vineSkeleton:setAnimation("idle", true)
    self.picBgFrameBg:addChild(vineSkeleton, VINE_Z)

    
    -- 出场动画完成后渐入显示角色选择页面
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.ENTER_CHARACTER_CREATION)
end

function CreateRoleLayer:editboxEventHandler(eventType)
    print("CreateRoleLayer:editboxEventHandler(eventType) .. "..eventType)
    if eventType == "began" then
    elseif eventType == "ended" then
    elseif eventType == "changed" then
        local message = self:judeInputTextLength()
    elseif eventType == "return" then
        local message = self.libIDEdit:getText() or ""
        -- message = string.trim(message)
        if AvalonUtil:isUpLimiteStr(message, NICK_NAME_WIDTH, 18) then
            -- message = string.sub(message, 1, 7)
            message = AvalonUtil:getSubNameStrByLabel(message, NICK_NAME_WIDTH, 18)
        end
        
        local gameWordDetectionManager = require"app.game.GameWordDetectionManager"
        gameWordDetectionManager:getInstance():nicknameDetection(message,function()
            if AvalonUtil:isEmoji(message) then
                UI.ScrollBar:createByText(UI.TEXT_1170936)
                return
            end
            message = ToolsUtil:replaceNameStr(message)
            local mark = false
            message = ToolsUtil:roleNameFilter(message)
            message, mark = ToolsUtil:checkMaskword(message)
            self.libIDEdit:setText(message)
            if mark then
                UI.ScrollBar:createByText(UI.TEXT_1170415)
            end
            self.libIDEdit:setPlaceHolder(self:getInputPlaceStr())

            self.libIDEdit:setText(message)
        end,function()
            self.libIDEdit:setText("***")
        end)


        -- if AvalonUtil:isEmoji(message) then
        --     UI.ScrollBar:createByText(UI.TEXT_1170936)
        --     return
        -- end
        -- message = ToolsUtil:replaceNameStr(message)
        -- local mark = false
        -- message, mark = ToolsUtil:checkMaskword(message)
        -- self.libIDEdit:setText(message)
        -- if mark then
        --     UI.ScrollBar:createByText(UI.TEXT_1170415)
        -- end
        -- self.libIDEdit:setPlaceHolder(self:getInputPlaceStr())

        -- self.libIDEdit:setText(message)
    end
end

function CreateRoleLayer:judeInputTextLength()
    local message = self.libIDEdit:getText() or ""
    -- message = string.gsub(message, " ", "")
    message = ToolsUtil:replaceNameStr(message)
    local isHave = string.find(message, "\n")
    
    if isHave ~= nil then
        message = string.gsub(message, "\n", "")
        self.libIDEdit:setText(message)
        AvalonUtil.closeKeyBoard(self.libIDEdit)
        return
    end

    if AvalonUtil:isUpLimiteStr(message, NICK_NAME_WIDTH, 18) then
        message = AvalonUtil:getSubNameStrByLabel(message, NICK_NAME_WIDTH, 18)
        self.libIDEdit:setText(message)
        UI.ScrollBar:createByText(UI.TEXT_1170311)
        AvalonUtil.closeKeyBoard(self.libIDEdit)
        return
    end

    return message
end


-- 模版函数：更新组建的视图(必备)
function CreateRoleLayer:onUpdateView()
    local _sex = math.random(1, 2)
    if _sex == 1 then
        self:onMale()
    else
        self:onFemale()
    end
end

-- 刷新状态
function CreateRoleLayer:refreshGoBtn()
    require("app.datas.MasterDataManager") 
    local repeatHandleData = MasterDataManager:getRepeatHandleData(RepeatHandleType.CREATE_ROLE)
    if(repeatHandleData) then
        self.mGoBtnDisabled = true
    else 
        self.mGoBtnDisabled = false
    end
end

--刷新部位
function CreateRoleLayer:refreshPart(part)
    local selectFacebg = self.picBgFrame:getChildByName("faceNode"..part)
    local txtFaceName = selectFacebg:getChildByName("faceName")
    local maleRoleRender = self._maleRoleAnimation:getRoleRender()
    local femaleRoleRender = self._femaleRoleAnimation:getRoleRender()

    if part == 1 then

        txtFaceName:setText(tostring(self.faceBodyData[self.mSelectBodyID]))
        if maleRoleRender then
            maleRoleRender:refreshFace(ToolsUtil:makeFaceDecodeID(self.mSelectBodyID, self.mSelectHairID, self.mSelectEyeID, self.mSelectMouthID))
        end

        if femaleRoleRender then
            femaleRoleRender:refreshFace(ToolsUtil:makeFaceDecodeID(self.mSelectBodyID, self.mSelectHairID, self.mSelectEyeID, self.mSelectMouthID))
        end

        local selectFacebg = self.picBgFrame:getChildByName("faceNode"..2)
        local txtFaceName = selectFacebg:getChildByName("faceName")
        txtFaceName:setText(tostring(self.faceData[self.mSelectBodyID][1][self.mSelectHairID].name[self.sex]))
        local selectFacebg = self.picBgFrame:getChildByName("faceNode"..3)
        local txtFaceName = selectFacebg:getChildByName("faceName")
        txtFaceName:setText(tostring(self.faceData[self.mSelectBodyID][2][self.mSelectEyeID].name[self.sex]))
        local selectFacebg = self.picBgFrame:getChildByName("faceNode"..4)
        local txtFaceName = selectFacebg:getChildByName("faceName")
        txtFaceName:setText(tostring(self.faceData[self.mSelectBodyID][4][self.mSelectMouthID].name[self.sex]))
    elseif part == 2 then

        txtFaceName:setText(tostring(self.faceData[self.mSelectBodyID][1][self.mSelectHairID].name[self.sex]))
        if maleRoleRender then
            maleRoleRender:changeModelHair(self.mSelectBodyID, self.mSelectHairID, self.sex)
        end
        if femaleRoleRender then
            femaleRoleRender:changeModelHair(self.mSelectBodyID, self.mSelectHairID, self.sex)
        end
    elseif part == 3 then
        txtFaceName:setText(tostring(self.faceData[self.mSelectBodyID][2][self.mSelectEyeID].name[self.sex]))
        if maleRoleRender then
            maleRoleRender:changeModelEye(self.mSelectBodyID, self.mSelectEyeID, self.sex)
        end
        if femaleRoleRender then
            femaleRoleRender:changeModelEye(self.mSelectBodyID, self.mSelectEyeID, self.sex)
        end 
    elseif part == 4 then
        txtFaceName:setText(tostring(self.faceData[self.mSelectBodyID][4][self.mSelectMouthID].name[self.sex]))
        if maleRoleRender then
            maleRoleRender:changeModelMouth(self.mSelectBodyID, self.mSelectMouthID, self.sex)
        end
        if femaleRoleRender then
            femaleRoleRender:changeModelMouth(self.mSelectBodyID, self.mSelectMouthID, self.sex)
        end
    end
end

--男性
function CreateRoleLayer:onMale()
    self.sex = PublicDefine.HERO_SEX.MALE
    self.btnMale:setNormal("ui_createrole_button_boy_1.png")
    -- self.selectMale:setVisible(true)
    self.btnFemale:setNormal("ui_createrole_button_girl_0.png")
    -- self.selectFemale:setVisible(false)

    self._maleRoleAnimation:setVisible(true)
    self._femaleRoleAnimation:setVisible(false)
    self.sex = 1
    self:refreshPart(1)
    self._sexSelectNum = self._sexSelectNum + 1
end

--女性
function CreateRoleLayer:onFemale()
    self.sex = PublicDefine.HERO_SEX.FEMALE

    self.btnMale:setNormal("ui_createrole_button_boy_0.png")
    -- self.selectMale:setVisible(false)
    self.btnFemale:setNormal("ui_createrole_button_girl_1.png")
    -- self.selectFemale:setVisible(true)

    self._maleRoleAnimation:setVisible(false)
    self._femaleRoleAnimation:setVisible(true)
    self.sex = 2
    self:refreshPart(1)
    self._sexSelectNum = self._sexSelectNum + 1
end

--onGo
function CreateRoleLayer:onGo()
    -- 处理创建角色
    local faceDecodeID = ToolsUtil:makeFaceDecodeID(self.mSelectBodyID, self.mSelectHairID, self.mSelectEyeID, self.mSelectMouthID)
    
    local nickName = self.libIDEdit:getText() or ""
    -- local  nickName = AvalonUtil.getIdentifier()
    if(nickName == nil or nickName == "") then
        UI.ScrollBar:createByText(self:getInputPlaceStr())
        return
    end
    if AvalonUtil:isEmoji(nickName) then
        UI.ScrollBar:createByText(UI.TEXT_1170936)
        return
    end
    nickName = ToolsUtil:replaceNameStr(nickName)
    local mark = false
    nickName = ToolsUtil:roleNameFilter(nickName)
    nickName, mark = ToolsUtil:checkMaskword(nickName)
    self.libIDEdit:setText(nickName)
    if mark then
        UI.ScrollBar:createByText(UI.TEXT_1170415)
        return
    end

    if AvalonUtil:isUpLimiteStr(nickName, NICK_NAME_WIDTH, 18) then
        nickName = AvalonUtil:getSubNameStrByLabel(nickName, NICK_NAME_WIDTH, 18)
        self.libIDEdit:setText(nickName)
        UI.ScrollBar:createByText(UI.TEXT_1170311)
        return
    end

    require("app.datas.MasterDataManager") 
    MasterDataManager:setRepeatHandleData(RepeatHandleType.CREATE_ROLE, true)
    self:refreshGoBtn()

    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_RUN_FOR_SCENARIO, UI.UITransitionScenarios.AFTER_CHARACTER_CREATION, self, function()
        GameManager:createHero(
            nickName, 
            self.sex, 
            faceDecodeID, 
            self._hairSelectNum ,
            self._eyeSelectNum ,
            self._mouthSelectNum ,
            self._skinSelectNum ,
            self._sexSelectNum ,
            self._tRandomNum, 
            self.data.areaId)
    end)
end


--随机
function CreateRoleLayer:onRandom()
    self.mSelectBodyID = math.random(1, table.nums(self.faceBodyData))
    self.mSelectHairID = math.random(1, table.nums(self.faceData[self.mSelectBodyID][1]))
    self.mSelectEyeID = math.random(1, table.nums(self.faceData[self.mSelectBodyID][2]))
    self.mSelectMouthID = math.random(1, table.nums(self.faceData[self.mSelectBodyID][4]))
    self:refreshPart(1)

    self._tRandomNum = self._tRandomNum + 1

end


--随机
function CreateRoleLayer:onRandomName()
    local randNameAreaData = ConfigManager:getGeneralForKey("randNameArea")
    local randNameAreaArray = string.split(randNameAreaData, ";")
    
    self._text = ""
    local nickName = ""
    local mark = true
    local count = 0
    while (mark and count < 10) do
        self._text = ""
        for i = 1, #randNameAreaArray do
            local randNameArea = string.split(randNameAreaArray[i], ",")
            self._text = self._text..languageManagerInstance:getLocalString(math.random(randNameArea[1], randNameArea[2]))
        end
        nickName, mark = ToolsUtil:checkMaskword(self._text)
        count = count + 1
    end
    -- add by zp
    if self:toShieldInputName() then
        self._text = self._text .. math.random(1,999) 
    end

    self._text = AvalonUtil:getSubNameStrByLabel(self._text, NICK_NAME_WIDTH, 18)
    self.libIDEdit:setText(self._text)
end


--上一个
function CreateRoleLayer:onLast(obj)
    local part = obj:getTag()

    if part == 1 then
        self.mSelectBodyID = self.mSelectBodyID - 1
        if self.mSelectBodyID == 0 then
            self.mSelectBodyID = table.nums(self.faceBodyData)
        end
        if self.mSelectHairID > table.nums(self.faceData[self.mSelectBodyID][1]) then
            self.mSelectHairID = table.nums(self.faceData[self.mSelectBodyID][1])
            -- self:refreshPart(2)
        end

        if self.mSelectEyeID > table.nums(self.faceData[self.mSelectBodyID][2]) then
            self.mSelectEyeID = table.nums(self.faceData[self.mSelectBodyID][2])
            -- self:refreshPart(3)
        end

        if self.mSelectMouthID > table.nums(self.faceData[self.mSelectBodyID][4]) then
            self.mSelectMouthID = table.nums(self.faceData[self.mSelectBodyID][4])
            -- self:refreshPart(4)
        end
    
        self._skinSelectNum = self._skinSelectNum + 1
    elseif part == 2 then
        self.mSelectHairID = self.mSelectHairID - 1
        if self.mSelectHairID == 0 then
            self.mSelectHairID = table.nums(self.faceData[self.mSelectBodyID][1])
        end
        self._hairSelectNum = self._hairSelectNum + 1
    elseif part == 3 then
        self.mSelectEyeID = self.mSelectEyeID - 1
        if self.mSelectEyeID == 0 then
            self.mSelectEyeID = table.nums(self.faceData[self.mSelectBodyID][2])
        end
        self._eyeSelectNum = self._eyeSelectNum + 1
    elseif part == 4 then
        self.mSelectMouthID = self.mSelectMouthID - 1
        if self.mSelectMouthID == 0 then
            self.mSelectMouthID = table.nums(self.faceData[self.mSelectBodyID][4])
        end
        self._mouthSelectNum = self._mouthSelectNum + 1
    end
    self:refreshPart(part)
end


--下一个
function CreateRoleLayer:onNext(obj)
    local part = obj:getTag()

    if part == 1 then
        self.mSelectBodyID = self.mSelectBodyID + 1
        if self.mSelectBodyID > table.nums(self.faceBodyData) then
            self.mSelectBodyID = 1
        end
        -- print(self.mSelectBodyID, self.faceData[self.mSelectBodyID])

        if self.mSelectHairID > table.nums(self.faceData[self.mSelectBodyID][1])  then
            self.mSelectHairID = 1
            -- self:refreshPart(2)
        end

        if self.mSelectEyeID > table.nums(self.faceData[self.mSelectBodyID][2]) then
            self.mSelectEyeID = 1
            -- self:refreshPart(3)
        end

        if self.mSelectMouthID > table.nums(self.faceData[self.mSelectBodyID][4]) then
            self.mSelectMouthID = 1
            -- self:refreshPart(4)
        end
        self._skinSelectNum = self._skinSelectNum + 1
    elseif part == 2 then
        self.mSelectHairID = self.mSelectHairID + 1
        if self.mSelectHairID > table.nums(self.faceData[self.mSelectBodyID][1]) then
            self.mSelectHairID = 1
        end
        self._hairSelectNum = self._hairSelectNum + 1
    elseif part == 3 then
        self.mSelectEyeID = self.mSelectEyeID + 1
        if self.mSelectEyeID > table.nums(self.faceData[self.mSelectBodyID][2]) then
            self.mSelectEyeID = 1
        end
        self._eyeSelectNum = self._eyeSelectNum + 1
    elseif part == 4 then
        self.mSelectMouthID = self.mSelectMouthID + 1
        if self.mSelectMouthID > table.nums(self.faceData[self.mSelectBodyID][4]) then
            self.mSelectMouthID = 1
        end
        self._mouthSelectNum = self._mouthSelectNum + 1
    end
    self:refreshPart(part)
end



--同步位置网络回调
function CreateRoleLayer:onBattlePositionSync()
    self:close()
end

function CreateRoleLayer:onCreateHeroResult(data)
    self:refreshGoBtn()

    if (data.result == 76) then -- 名字重复, 取消场景过渡
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_TRANSITION_CLEAR, AvalonMessage.MC_UI_TRANSITION_FADEIN, nil, 0.2)
    end
end

-- 注册监听事件(可选)
function CreateRoleLayer:registerListener()

    -- Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_POSITION_SYNC, self, self.onBattlePositionSync)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_CREATE_HERO_RESULT, self, self.onCreateHeroResult)
end


-- 注销监听事件(可选)
function CreateRoleLayer:unRegisterListener()

    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_POSITION_SYNC, self, self.onBattlePositionSync)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_CREATE_HERO_RESULT, self, self.onCreateHeroResult)
end

function CreateRoleLayer:getInputPlaceStr()
    if(self:toShieldInputName()) then
        return languageManagerInstance:getLocalString(1170320)
    else
       return UI.TEXT_111109 
    end
end

function CreateRoleLayer:toShieldInputName()
    -- -- add by zp CO-16497 新玩家起名只能起随机名
    local SdkManager = require"app.game.SdkManager"
    if SdkManager:responsePolicySwitch() then
        local SdkBox = require("utils.sdkbox.SdkBox")
        local target = SdkBox:getInstance():getVersionTarget()
        if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            return true
        end
    end

    return false
end





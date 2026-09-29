-- BeautySalonLayer.lua
-- Author:ODEI
-- 2017年6月7日
-- Using:捏脸 
local ProtobufUtil = require "utils.ProtobufUtil"
require "app.ui.baglayer.RoleShow.RoleAnimation"
require "app.config.ConfigManager"
require "app.ui.HWBtnComponent"
local SdkManager = require"app.game.SdkManager"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local BeautySalonLayer = class("BeautySalonLayer", UI.DownShowWin)
UI.BeautySalonLayer = BeautySalonLayer

local winSize = cc.Director:getInstance():getWinSize()

local MAIN_PANEL_BG_FRAME_Z = 500
local SKELETON_Z = 520
local ROLE_GREY_BG_Z = 530
local VINE_Z = 540
local MAIN_PANEL_Z = 1000
local SALON_LIGHT_Z = 1100

local NICK_NAME_WIDTH = 145


local viewWidth = 808
local viewHeight = 579
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_login_createRole.plist",
}


--构造函数(必备)
function BeautySalonLayer:ctor(spriteID)
    --窗口大小
    BeautySalonLayer.super.ctor(
        self,UIType.BEAUTY_SALON_LAYER,
        COM_RES_LIST,
        viewWidth,    
        viewHeight)
    self.faceBodyData = {UI.TEXT_110090, UI.TEXT_110091, UI.TEXT_110092}
    self.arrowBtns = {}
    self.spriteID = spriteID
    self.rootLayer = nil;           --root节点
    self.faceData = ConfigManager:serializeFaceConfig()
    self:initData()
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:init();
    self:registerListener()
end

--虚构函数,destroy时调用(必备)
function BeautySalonLayer:dtor()
    BeautySalonLayer.super.dtor(self)
    self:unRegisterListener();
    self.arrowBtns = {}
end

-- 初始化(必备)
function BeautySalonLayer:init()
    BeautySalonLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function BeautySalonLayer:onInitView()
    --root节点
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:setSize(viewWidth, viewHeight)
    self.rootLayer:leftBottom(20, 0)
    self:addChild(self.rootLayer)

    -- 主窗口框架
    self.picBgFrame = UI.Image:create()
    self.picBgFrame:init("ui_createrole_banner_frame.png")
    self.picBgFrame:center()
    self.rootLayer:addChild(self.picBgFrame, MAIN_PANEL_Z)

    -- 前景灯
    local salonLightSkeleton = UI.Animation:create()
    salonLightSkeleton:init("effect_ui_town_cosmetic_left.json", "effect_ui_town_cosmetic_left.atlas", 1);
    salonLightSkeleton:leftBottom(54, 421)
    salonLightSkeleton:setAnimation("idle", true)
    self.picBgFrame:addChild(salonLightSkeleton, SALON_LIGHT_Z)


    -- 角色站点
    local standingGround = UI.Image:create()
    standingGround:init("ui_createrole_banner_table.png")
    standingGround:leftBottom(112, 37)
    self.picBgFrame:addChild(standingGround)


    -- 角色动画
    self._roleAnimation = UI.RoleAnimation:create(false)
    local masterData = RoleDataManager:getMaster()
    self._roleAnimation:init(masterData)
    self._roleAnimation:setScaleX(-1 * self._roleAnimation:getScaleX())
    self._roleAnimation:leftBottom(150,130)
    self._roleAnimation:showBlink(true)
    self.picBgFrame:addChild(self._roleAnimation)
    performWithDelay(self, function()
        self._roleAnimation:hideHelmet()
    end, 0)

    -- 刷新了站立时候的武器类型，否者会出现只会出现拿剑盾的表现。
    local weaponEquipmentData = nil
    local wearEquipmentArr = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
    if (wearEquipmentArr) then
        for i = 1, #wearEquipmentArr do
            local equipmentData = wearEquipmentArr[i]
            local equipmentType = equipmentData:getEquipmentType()
            if (equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon) then weaponEquipmentData= equipmentData
            end
        end
    end
    if(weaponEquipmentData) then
        self._roleAnimation:updateView()
        self._roleAnimation:showIDLEAnimation(weaponEquipmentData)
    end


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


    -- 悬挂框上的提示文字
    local introText = UI.Text:create()
    introText:init(UI.TEXT_1150013, UI.FONT_STANDARD, UI.FONT_SIZE_20PX)
    introText:leftBottom(-180, -40)
    introText:setSize(400, 100)
    introText:setFontColor(UI.FONT_COLOR_170_170_170)
    introText:setTextCenter()


    -- 悬挂改名按钮
    self.mBtnUpdateName = UI.Button:create()
    self.mBtnUpdateName:init("ui_createrole_thn_0.png", "ui_createrole_thn_1.png", "ui_createrole_thn_2.png")
    self.mBtnUpdateName:leftBottom(-37, -18)
    self.mBtnUpdateName:disable()
    self.mBtnUpdateName:addEventListener(UIEvent.BUTTON_CLICK, self, self.onUpdateName)

    self.mUpdateDiamondIcon = UI.Image:create()
    self.mUpdateDiamondIcon:init("symbol_gaming_diamond.png")
    self.mUpdateDiamondIcon:centerLeft(5)
    self.mBtnUpdateName:addChild(self.mUpdateDiamondIcon, 100)

    local updateNameNeedDiamond = ConfigManager:getGeneralForKey("changeNameCostDiamond")
    self.mTxtUpdateDiamondNum = UI.Text:create()
    self.mTxtUpdateDiamondNum:init(updateNameNeedDiamond,UI.FONT_BOLD,UI.FONT_SIZE_20PX)
    self.mTxtUpdateDiamondNum:leftBottom(self.mUpdateDiamondIcon:getLeft() + self.mUpdateDiamondIcon:getContentSize().width + 3, 5)
    self.mTxtUpdateDiamondNum:setTextLeft()
    self.mBtnUpdateName:addChild(self.mTxtUpdateDiamondNum, 100)
    self:refreshChangeNameNeed()


    -- 悬挂栏输入框
    local transparentInputBackground = cc.Scale9Sprite:createWithSpriteFrameName("ui_createrole_thn_0.png")
    transparentInputBackground:setOpacity(0)
    local libIDEdit = cc.EditBox:create({width = 190, height = 25}, transparentInputBackground)
    libIDEdit:setFontSize(18)
    libIDEdit:setPlaceholderFontSize(UI.FONT_SIZE_14PX)
    libIDEdit:setPlaceHolder(UI.TEXT_1150013)
    libIDEdit:setPlaceholderFontColor(UI.FONT_COLOR_170_170_170)
    libIDEdit:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
    libIDEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    libIDEdit:setPosition(0, 0)
    libIDEdit:setText(RoleDataManager:getMaster():getNickName())
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
    upSpine:addComponent("jiedian03", self.mBtnUpdateName)

    -- TODOTODO 2012.6.02日 特殊屏蔽改名界面(国内)
    if SdkManager:responsePolicySwitch() then
        local SdkBox = require("utils.sdkbox.SdkBox")
        local target = SdkBox:getInstance():getVersionTarget()
        if target ~= PublicDefine.VERSION_TARGET.VERSION_TARGET_GLOBAL then
            upSpine:setVisible(false)
        end
    end



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
    greyBg:setPosition(cc.p(43, 22))
    self.picBgFrameBg:addChild(greyBg, ROLE_GREY_BG_Z)


    -- 左下骷髅
    local skeletonSpine = UI.Animation:create()
    skeletonSpine:init("effect_ui_login_createrole_down.json", "effect_ui_login_createrole_down.atlas", 1);
    skeletonSpine:leftBottom(34, 24)
    skeletonSpine:setAnimation("idle", true)
    self.picBgFrameBg:addChild(skeletonSpine, SKELETON_Z)


    -- 背景藤蔓
    local vineSkeleton = UI.Animation:create()
    vineSkeleton:init("effect_ui_town_cosmetic_mid.json", "effect_ui_town_cosmetic_mid.atlas", 1);
    vineSkeleton:leftBottom(395, 295)
    vineSkeleton:setAnimation("idle", true)
    self.picBgFrameBg:addChild(vineSkeleton, VINE_Z)
    self:open()
end

-- 模版函数：更新组建的视图(必备)
function BeautySalonLayer:onUpdateView()
    self:refreshDiscountData()
    self:resetChangeFaceBtn()
    self:refreshPart(1)

    local faceDecodeID = MasterDataManager:getRepeatHandleData(RepeatHandleType.BEAUTYSALON)
    if faceDecodeID then
        self:reductionInfo(faceDecodeID)
    end
end

-- 初始化数据
function BeautySalonLayer:initData()
    self.faceDecodeID = RoleDataManager:getMaster():getFaceDecodeID()
    self.sex = RoleDataManager:getMaster():getSex()
    self.mSelectBodyID,self.mSelectHairID, self.mSelectEyeID, self.mSelectMouthID = ToolsUtil:splitFaceDecodeID(self.faceDecodeID)
    self.mOldSelectBodyID = self.mSelectBodyID
    self.mOldSelectHairID = self.mSelectHairID
    self.mOldSelectEyeID = self.mSelectEyeID
    self.mOldSelectMouthID = self.mSelectMouthID

    self:refreshDiscountData()
end

-- 刷新打折数据
function BeautySalonLayer:refreshDiscountData()
    local discountDataArr = MasterDataManager:getDiscountData(PublicDefine.DiscountType.DiscountType_Facelift)
    local isDiscount = false
    local discount = RATIO_NUMBER
    if(discountDataArr and #discountDataArr > 0) then
        local discountData = discountDataArr[1]
        if(discountData and discountData:judgeToEffect()) then 
            isDiscount = true
            discount = discountData:getDiscount()
        end
    end
    self.isDiscount = isDiscount
    self.discount = discount 
end

-- 刷新主换脸按钮
function BeautySalonLayer:resetChangeFaceBtn()
    if(self.mBtnChangeFace) then
        self.mBtnChangeFace:removeFromParent()
        self.mBtnChangeFace = nil
    end

    self.mTxtChangeFace = nil
    self.mDiscountTxtDiamondNum = nil
    self.mDiamondIcon = nil
    self.mTxtDiamondNum = nil
    self.mDiscountLine = nil
    
    -- 换脸按钮
    self.mBtnChangeFace = UI.Button:create()
    if(self.isDiscount) then
        self.mBtnChangeFace:init("ui_btn_yellow4_0.png", "ui_btn_yellow4_1.png", "ui_btn_yellow4_2.png")
    else
        self.mBtnChangeFace:init("ui_btn_yellow4_0.png", "ui_btn_yellow4_1.png", "ui_btn_yellow4_2.png")
    end
    local btnWidth, _ = self.mBtnChangeFace:getSize()
    self.mBtnChangeFace:leftBottom(557 - (btnWidth / 2), 94)
    self.mBtnChangeFace:addEventListener(UIEvent.BUTTON_CLICK,self,self.onChangeFace)
    self.picBgFrame:addChild(self.mBtnChangeFace)

    -- 换脸按钮文字
    self.mTxtChangeFace = UI.Text:create()
    self.mTxtChangeFace:init(UI.TEXT_110029,UI.FONT_BOLD,UI.FONT_SIZE_20PX)
    self.mTxtChangeFace:centerLeft(45)
    self.mTxtChangeFace:setFontColor(UI.FONT_COLOR_50_50_44)
    self.mTxtChangeFace:setTextCenter()
    self.mBtnChangeFace:addChild(self.mTxtChangeFace, 100)

    -- 钻石图标
    self.mDiamondIcon = UI.Image:create()
    self.mDiamondIcon:init("symbol_gaming_diamond.png")
    self.mDiamondIcon:centerLeft(135)
    self.mBtnChangeFace:addChild(self.mDiamondIcon,100)

    -- 花费文字
    self.mTxtDiamondNum = UI.Text:create()
    self.mTxtDiamondNum:init("0",UI.FONT_BOLD,UI.FONT_SIZE_20PX)
    self.mTxtDiamondNum:leftBottom(160, 9)
    self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_50_50_44)
    self.mTxtDiamondNum:enableWrap(false)
    self.mTxtDiamondNum:setTextCenter()
    self.mBtnChangeFace:addChild(self.mTxtDiamondNum,100)

    local useItemId = tonumber(ConfigManager:getGeneralForKey("ChangeFaceID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    local useItemCost = 1
    if(self.isDiscount and goodNumber < useItemCost) then
        -- 价钱文字
        self.mDiscountTxtDiamondNum = UI.Text:create()
        self.mDiscountTxtDiamondNum:init("0",UI.FONT_STANDARD,UI.FONT_SIZE_14PX)
        self.mDiscountTxtDiamondNum:setFontColor(UI.FONT_COLOR_150_130_60)
        self.mDiscountTxtDiamondNum:setTextCenter()
        self.mDiscountTxtDiamondNum:enableWrap(false)
        self.mBtnChangeFace:addChild(self.mDiscountTxtDiamondNum, 100)

        -- 降价排版调整
        local half = 13
        self.mDiscountTxtDiamondNum:setSize(30, 15)
        self.mTxtDiamondNum:setSize(30, 20)
        self.mDiamondIcon:leftBottom(135, 24 - half)
        self.mDiscountTxtDiamondNum:leftBottom(160, 12 + half)
        self.mTxtDiamondNum:leftBottom(160, 14 - half)

        -- 划线
        self.mDiscountLine = UI.Image9:create()
        self.mDiscountLine:init("ui_scale9image_red.png", CCRectMake(0,0,1,1), cc.size(30, 2))
        self.mDiscountLine:center()
        self.mDiscountTxtDiamondNum:addChild(self.mDiscountLine, 101)
    end
end

-- 名字编辑框回调
function BeautySalonLayer:editboxEventHandler(eventType)
    print("BeautySalonLayer:editboxEventHandler(eventType) .. "..eventType)
    if eventType == "began" then
    elseif eventType == "ended" then
    elseif eventType == "changed" then
        local message = self:judeInputTextLength()
    elseif eventType == "return" then
        local message = self.libIDEdit:getText() or ""
        -- message = string.trim(message)
        message = ToolsUtil:replaceNameStr(message)
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
            local mark = false
            message = ToolsUtil:roleNameFilter(message)
            message,mark = ToolsUtil:checkMaskword(message)
            self.libIDEdit:setText(message)
            if mark then
                UI.ScrollBar:createByText(UI.TEXT_1170415)
            end
            
            self.libIDEdit:setPlaceHolder(UI.TEXT_111109)
    
            self.libIDEdit:setText(message)
    
            if message ~= RoleDataManager:getMaster():getNickName() and MasterDataManager:getRepeatHandleData(RepeatHandleType.EDIT_NAME) == nil then
                self.mBtnUpdateName:enable()
            else
                self.mBtnUpdateName:disable()
            end
        end,function()
            self.libIDEdit:setText("***")
            self.mBtnUpdateName:enable()
        end)

        -- if AvalonUtil:isEmoji(message) then
        --     UI.ScrollBar:createByText(UI.TEXT_1170936)
        --     return
        -- end
        -- local mark = false
        -- message,mark = ToolsUtil:checkMaskword(message)
        -- self.libIDEdit:setText(message)
        -- if mark then
        --     UI.ScrollBar:createByText(UI.TEXT_1170415)
        -- end
        
        -- self.libIDEdit:setPlaceHolder(UI.TEXT_111109)

        -- self.libIDEdit:setText(message)

        -- if message ~= RoleDataManager:getMaster():getNickName() and MasterDataManager:getRepeatHandleData(RepeatHandleType.EDIT_NAME) == nil then
        --     self.mBtnUpdateName:enable()
        -- else
        --     self.mBtnUpdateName:disable()
        -- end


    end
end

-- 判断字长超框
function BeautySalonLayer:judeInputTextLength()
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

-- 打折判断
function BeautySalonLayer:reductionInfo(faceDecodeID)
    self.mSelectBodyID,self.mSelectHairID, self.mSelectEyeID, self.mSelectMouthID = ToolsUtil:splitFaceDecodeID(faceDecodeID)
    for i = 1, 4 do 
        self:refreshPart(i)
    end
    self.mBtnChangeFace:disable()
    for k, v in ipairs(self.arrowBtns) do
        v:disable()
    end
end

-- 刷新部位
function BeautySalonLayer:refreshPart(part)
    local selectFacebg = self.picBgFrame:getChildByName("faceNode"..part)
    local txtFaceName = selectFacebg:getChildByName("faceName")
    local roleRender = self._roleAnimation:getRoleRender()
    if part == 1 then
        txtFaceName:setText(tostring(self.faceBodyData[self.mSelectBodyID]))
        if roleRender then
            roleRender:refreshFace(ToolsUtil:makeFaceDecodeID(self.mSelectBodyID,self.mSelectHairID,self.mSelectEyeID,self.mSelectMouthID))
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
        if roleRender then
            roleRender:changeModelHair(self.mSelectBodyID,self.mSelectHairID,self.sex)
        end
    elseif part == 3 then
        txtFaceName:setText(tostring(self.faceData[self.mSelectBodyID][2][self.mSelectEyeID].name[self.sex]))
        if roleRender then
            roleRender:changeModelEye(self.mSelectBodyID,self.mSelectEyeID,self.sex)
        end    
    elseif part == 4 then
        txtFaceName:setText(tostring(self.faceData[self.mSelectBodyID][4][self.mSelectMouthID].name[self.sex]))
        if roleRender then
            roleRender:changeModelMouth(self.mSelectBodyID,self.mSelectMouthID,self.sex)
        end
    end
    self:refreshChangeFaceBtn()
end

-- 点击上一个相貌
function BeautySalonLayer:onLast(obj)
    local part = obj:getTag()

    if part == 1 then
        self.mSelectBodyID = self.mSelectBodyID - 1
        if self.mSelectBodyID == 0 then
            self.mSelectBodyID = table.nums(self.faceBodyData)
        end
        if self.mSelectHairID > table.nums(self.faceData[self.mSelectBodyID][1]) then
            self.mSelectHairID = table.nums(self.faceData[self.mSelectBodyID][1])
        end

        if self.mSelectEyeID > table.nums(self.faceData[self.mSelectBodyID][2]) then
            self.mSelectEyeID = table.nums(self.faceData[self.mSelectBodyID][2])
        end

        if self.mSelectMouthID > table.nums(self.faceData[self.mSelectBodyID][4]) then
            self.mSelectMouthID = table.nums(self.faceData[self.mSelectBodyID][4])
        end
    elseif part == 2 then
        self.mSelectHairID = self.mSelectHairID - 1
        if self.mSelectHairID == 0 then
            self.mSelectHairID = table.nums(self.faceData[self.mSelectBodyID][1])
        end

    elseif part == 3 then
        self.mSelectEyeID = self.mSelectEyeID - 1
        if self.mSelectEyeID == 0 then
            self.mSelectEyeID = table.nums(self.faceData[self.mSelectBodyID][2])
        end
    elseif part == 4 then
        self.mSelectMouthID = self.mSelectMouthID - 1
        if self.mSelectMouthID == 0 then
            self.mSelectMouthID = table.nums(self.faceData[self.mSelectBodyID][4])
        end
    end
    self:refreshPart(part)
end


-- 点击下一个相貌
function BeautySalonLayer:onNext(obj)
    local part = obj:getTag()

    if part == 1 then
        self.mSelectBodyID = self.mSelectBodyID + 1
        if self.mSelectBodyID > table.nums(self.faceBodyData) then
            self.mSelectBodyID = 1
        end
        -- print(self.mSelectBodyID,self.faceData[self.mSelectBodyID])

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

    elseif part == 2 then
        self.mSelectHairID = self.mSelectHairID + 1
        if self.mSelectHairID > table.nums(self.faceData[self.mSelectBodyID][1]) then
            self.mSelectHairID = 1
        end

    elseif part == 3 then
        self.mSelectEyeID = self.mSelectEyeID + 1
        if self.mSelectEyeID > table.nums(self.faceData[self.mSelectBodyID][2]) then
            self.mSelectEyeID = 1
        end
    elseif part == 4 then
        self.mSelectMouthID = self.mSelectMouthID + 1
        if self.mSelectMouthID > table.nums(self.faceData[self.mSelectBodyID][4]) then
            self.mSelectMouthID = 1
        end
    end
    self:refreshPart(part)
end

-- 刷新换脸按钮
function BeautySalonLayer:refreshChangeFaceBtn()
    self.mBtnChangeFace:enable()
    local needDiamond = 0;
    if self.mOldSelectBodyID ~= self.mSelectBodyID then
        needDiamond = needDiamond + self.faceData[self.mSelectBodyID][1][self.mSelectHairID].cost
        needDiamond = needDiamond + self.faceData[self.mSelectBodyID][2][self.mSelectEyeID].cost
        needDiamond = needDiamond + self.faceData[self.mSelectBodyID][4][self.mSelectMouthID].cost
        
    else
        if self.mOldSelectHairID ~= self.mSelectHairID then
            needDiamond = needDiamond + self.faceData[self.mSelectBodyID][1][self.mSelectHairID].cost
        end

        if self.mOldSelectEyeID ~= self.mSelectEyeID then
            needDiamond = needDiamond + self.faceData[self.mSelectBodyID][2][self.mSelectEyeID].cost
        end

        if self.mOldSelectMouthID ~= self.mSelectMouthID then
            needDiamond = needDiamond + self.faceData[self.mSelectBodyID][4][self.mSelectMouthID].cost
        end
    end

    local needDiamondEnd = needDiamond
    if(self.isDiscount) then
        needDiamondEnd = math.floor(needDiamond * self.discount / RATIO_NUMBER)
    end 
    local useItemId = tonumber(ConfigManager:getGeneralForKey("ChangeFaceID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    local useItemCost = 1

    if goodNumber >= useItemCost then
        if needDiamond <= 0 then 
            self.mBtnChangeFace:disable()
        end
        self.mDiamondIcon:centerLeft(145)
        self.mTxtDiamondNum:leftBottom(175, 9)
        local icon = GoodsDataManager:createLocalGoodsData(useItemId):getSmallIconName()
        self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_50_50_44)
        self.mTxtDiamondNum:setText(useItemCost)
        self.mDiamondIcon:setSpriteName(icon)
        return
    else
        self.mDiamondIcon:centerLeft(135)
        self.mTxtDiamondNum:leftBottom(160, 9)
        self.mTxtDiamondNum:setText(useItemCost)
        self.mDiamondIcon:setSpriteName("symbol_gaming_diamond.png")
        if Avalon.MathUtil:checkDiamonEnough(needDiamondEnd, GameDataManager:getInstance():getDiamond()) then
            self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_50_50_44)
        else
            self.mTxtDiamondNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
    end


    if(self.isDiscount) then
        self.mTxtDiamondNum:setText(tostring(needDiamondEnd))
        if self.mDiscountTxtDiamondNum then
            self.mDiscountTxtDiamondNum:setText(tostring(needDiamond))
        end
    else 
        self.mTxtDiamondNum:setText(tostring(needDiamond))
    end
    if needDiamond <= 0 then 
        self.mBtnChangeFace:disable()

        self.mDiamondIcon:setVisible(false)
        self.mTxtDiamondNum:setVisible(false)

        if(self.isDiscount) then
            if self.mDiscountTxtDiamondNum then
                self.mDiscountTxtDiamondNum:setVisible(false)
            end
            if self.mDiscountLine then
                self.mDiscountLine:setVisible(false)
            end
        end 

        self.mTxtChangeFace:center()
    else
        self.mDiamondIcon:setVisible(true)
        self.mTxtDiamondNum:setVisible(true)

        if(self.isDiscount) then
            if self.mDiscountTxtDiamondNum then
                self.mDiscountTxtDiamondNum:setVisible(true)
            end
            if self.mDiscountLine then
                self.mDiscountLine:setVisible(true)
            end
        end

        self.mTxtChangeFace:centerLeft(45)
    end

end


-- 换脸
function BeautySalonLayer:onChangeFace()
    if RoleBehaviorManager:catFoodAndBeautySalonNpcCheck() then
        printWarn(" been blocking when using beautySalon npc function change face!")
        return
    end

    local useItemId = tonumber(ConfigManager:getGeneralForKey("ChangeFaceID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    local useItemCost = 1
    if goodNumber < useItemCost and not Avalon.MathUtil:checkDiamonEnough(tonumber(self.mTxtDiamondNum:getText()), GameDataManager:getInstance():getDiamond()) then
        UI.TipsLayer:onDiamondNotEnough()
        return
    end
    local faceDecodeID = ToolsUtil:makeFaceDecodeID(self.mSelectBodyID,self.mSelectHairID, self.mSelectEyeID, self.mSelectMouthID)
    MasterDataManager:setRepeatHandleData(RepeatHandleType.BEAUTYSALON, faceDecodeID)
    UI.WaitingLayer:showWaiting(true, self:getParent(), GAME_NET_DELAY_UI)
    Net.NetNPCSystem:sendFacelift(faceDecodeID, self.spriteID)
    self.mBtnChangeFace:disable()
    for k, v in ipairs(self.arrowBtns) do
        v:disable()
    end
end

-- 更改名字
function BeautySalonLayer:onUpdateName()

    local func = function(nickStr)

        -- -- 暂时屏蔽改名
        -- if (CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE or CAVEOL_TARGET == CAVEOL_TARGET_CN) then
        --     UI.ScrollBar:createByTextID(1113615)
        --     return
        -- end

        local nickName = nickStr or ""--self.libIDEdit:getText() or ""
        -- local  nickName = AvalonUtil.getIdentifier()
        if(nickName == nil or nickName == "") then
            UI.ScrollBar:createByText(UI.TEXT_111109)
            return
        end
        
        if AvalonUtil:isEmoji(nickName) then
            UI.ScrollBar:createByText(UI.TEXT_1170936)
            return
        end
        nickName = ToolsUtil:replaceNameStr(nickName)
        local mark = false
        nickName,mark = ToolsUtil:checkMaskword(nickName)
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

        local useItemId = tonumber(ConfigManager:getGeneralForKey("ChangeNameID"))
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
        local useItemCost = 1
        local updateNameNeedDiamond = ConfigManager:getGeneralForKey("changeNameCostDiamond")
        if goodNumber >= useItemCost or Avalon.MathUtil:checkDiamonEnough(tonumber(updateNameNeedDiamond), GameDataManager:getInstance():getDiamond()) then
            --更改名字接口
            if RoleBehaviorManager:catFoodAndBeautySalonNpcCheck() then
                printWarn(" been blocking when using beautySalon npc function change name!")
                return
            end
            MasterDataManager:setRepeatHandleData(RepeatHandleType.EDIT_NAME, true)
            Net.NetRoleSystem:heroEditNickNameRequest(GameDataManager:getInstance():getMasterPK(), nickName)
            self.mBtnUpdateName:disable()
        else
            UI.TipsLayer:onDiamondNotEnough()
        end
    end
    
    local gameWordDetectionManager = require"app.game.GameWordDetectionManager"
    local nickName = self.libIDEdit:getText() or ""
    self.mBtnUpdateName:disable()
    gameWordDetectionManager:getInstance():nicknameDetection(nickName,func,function()
        self.mBtnUpdateName:enable()
    end)
end

-- 美容网络回调
function BeautySalonLayer:changeFaceCallBack(data)
    UI.WaitingLayer:hideWaiting()
    self.mBtnChangeFace:enable()
    for k, v in ipairs(self.arrowBtns) do
        v:enable()
    end

    if data.result == "FaceliftResultType_Succeed" then
        self:initData()
        self:refreshPart(1)
    end
    self:updateView()
    self:refreshChangeFaceBtn()
    self:refreshChangeNameNeed()

    GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.FaceliftResultType",data.result))
end

-- 刷新界面
function BeautySalonLayer:refreshActivity()
    self:refreshDiscountData()
    self:updateView()
    self:refreshChangeFaceBtn()
end

-- 改名后网络回调
function BeautySalonLayer:editNameCallBack(data)
    if(data.result =="EditNicknameResult_OK") then
        self.mBtnUpdateName:disable()
        self:refreshChangeNameNeed()
        self:refreshChangeFaceBtn()
    else
        self.mBtnUpdateName:enable()
    end
end

-- 刷新更名花费
function BeautySalonLayer:refreshChangeNameNeed()
    local useItemId = tonumber(ConfigManager:getGeneralForKey("ChangeNameID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(useItemId, true)
    local useItemCost = 1
    if goodNumber >= useItemCost then
        local icon = GoodsDataManager:createLocalGoodsData(useItemId):getSmallIconName()
        self.mTxtUpdateDiamondNum:setFontColor(UI.FONT_COLOR_50_50_44)
        self.mTxtUpdateDiamondNum:setText(useItemCost)
        self.mUpdateDiamondIcon:setSpriteName(icon)
        self.mUpdateDiamondIcon:centerLeft(12)
    else
        local updateNameNeedDiamond = ConfigManager:getGeneralForKey("changeNameCostDiamond")
        self.mTxtUpdateDiamondNum:setText(updateNameNeedDiamond)
        self.mUpdateDiamondIcon:setSpriteName("symbol_gaming_diamond.png")
        if Avalon.MathUtil:checkDiamonEnough(tonumber(updateNameNeedDiamond), GameDataManager:getInstance():getDiamond()) then
            self.mTxtUpdateDiamondNum:setFontColor(UI.FONT_COLOR_50_50_44)
        else
            self.mTxtUpdateDiamondNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
        self.mUpdateDiamondIcon:centerLeft(5)
    end
    self.mTxtUpdateDiamondNum:leftBottom(self.mUpdateDiamondIcon:getLeft() + self.mUpdateDiamondIcon:getContentSize().width + 3, 5)
end

-- 货币改变回调
function BeautySalonLayer:onCurrencyChangeHandler()
    self:refreshChangeFaceBtn()
    self:refreshChangeNameNeed()
end

-- 注册监听事件(可选)
function BeautySalonLayer:registerListener()

    Avalon.MessageCenter:bind(AvalonMessage.MC_NPC_CHANGE_FACE, self, self.changeFaceCallBack)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_BEAUTY_EDITE_NEAME_RESPONSE, self, self.editNameCallBack)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshActivity)

    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

-- 注销监听事件(可选)
function BeautySalonLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NPC_CHANGE_FACE, self, self.changeFaceCallBack)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_BEAUTY_EDITE_NEAME_RESPONSE, self, self.editNameCallBack)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshActivity)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end





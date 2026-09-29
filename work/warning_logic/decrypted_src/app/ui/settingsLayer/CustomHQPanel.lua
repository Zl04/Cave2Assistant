--[[
    游戏设置子页面
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.HWBtnComponent"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")
local SdkManager = require("app.game.SdkManager")

UI = UI or {}

local CustomHQPanel = class("CustomHQPanel", UI.SettingPanelBase)
UI.CustomHQPanel = CustomHQPanel

local txts = {UI.TEXT_1213787, UI.TEXT_1213788, UI.TEXT_1213789,
                UI.TEXT_1213790, UI.TEXT_1213791,
                UI.TEXT_1213792, UI.TEXT_1213793, UI.TEXT_1213794}

local PersonCount = Game.PersonCount

function CustomHQPanel:ctor()
    CustomHQPanel.super.ctor(
        self, 
        UIType.SETTINGS_HQ_TAB,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0)
end

function CustomHQPanel:dtor(...)
    CustomHQPanel.super.dtor(self, ...)

    self:saveSelectToLocal()

    -- 关闭设置界面时发出操作方式更新消息
    Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)

    -- 清除UI恢复回调
    UI.UIManager:setUIRestoreButtonCallback(nil)

    reload_script_file("app.ui.settingsLayer.CustomHQPanel")
end

function CustomHQPanel:saveSelectToLocal()
    if not self.anythingChanged then
        return
    end
    print("CustomHQPanel:saveSelectToLocal")
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if not globalUserData then
        return
    end

    local mode = CUSTOM_HQ_SET_MAP[1]
    for k, _ in ipairs(mode) do
        GameManager:setCustomHQ(k, self.selectedMode[k])
    end

    globalUserData:setSettingCustomHQMode(self.curModeIdx)
    print("CustomHQPanel:saveSelectToLocal", self.curModeIdx)
    Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)

    -- 关闭界面才生效的一些设置在此统一处理
    if SceneManager:isInFightScene() then
        -- 漂浮物
        Avalon.MessageCenter:notice(GameMessage.MC_UI_CUSTOM_FLOAT_SWITCH, self.selectedMode[CUSTOM_HQ_TYPE.FLOATS])
    end
end

function CustomHQPanel:init(width, height)
	CustomHQPanel.super.init(self)
    self:setSize(width, height)
end

function CustomHQPanel:onInitView(...)
    CustomHQPanel.super.onInitView(self, ...)

    self.anythingChanged = false

    self.curModeIdx = 1 -- 默认高画质
    local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
    if globalUserData then
        self.curModeIdx = globalUserData:getSettingCustomHQMode()
    end
    print("CustomHQPanel:onInitView", self.curModeIdx)
    if not GameManager:getCustomDefultToast() then
        GameManager:setCustomDefultToast()

        local strings = {UI.TEXT_1213783, UI.TEXT_1213784, UI.TEXT_1213785}
        UI.ConfirmDialog.showConfrimOnlyShowRed(
            string.format(UI.TEXT_1213796, strings[self.curModeIdx])
        )
    end

    self.selectedMode = {}

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(833, 355)
    contentLayout:centerUp(90)
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self:initTop()
    self:initDetail()

    self:updateModeBtnShow()
end

function CustomHQPanel:initTop()
    -- 顶部分类
    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213782, UI.FONT_STANDARD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_50_50_44)
    titleTxt:leftUp(66, 36)
    local w = titleTxt:getContentSize().width
    if w > 90 then
        titleTxt:setWidth(90)
        titleTxt:setTextLeft()
        titleTxt:autoAdapt()
        titleTxt:setLineSpacing(-10)
        titleTxt:leftUp(66, 16)
    end
    self.contentLayout:addChild(titleTxt)

    local btnTxt = {UI.TEXT_1213783, UI.TEXT_1213784, UI.TEXT_1213785, UI.TEXT_1213786}
    local offsetX = {142, 308, 472, 640}

    for k, v in ipairs(btnTxt) do
        local funcBtn = UI.Button:create();
        funcBtn:init("ui_setup_button_language_0.png","ui_setup_button_language_1.png","ui_setup_button_language_0.png");
        funcBtn:leftUp(offsetX[k], 30);
        funcBtn:setScaleX(0.85)
        funcBtn:closeClickScale()
        funcBtn:setText(v)
        
        funcBtn:setName("FuncBtn"..k)
        funcBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_50_50_44)
        funcBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if k == self.curModeIdx or k == 4 then
                self:updateModeBtnShow()
                return
            end

            self.curModeIdx = k
            self:updateModeBtnShow()
            self:updateAllDetails()

            self.anythingChanged = true
        end)
        self.contentLayout:addChild(funcBtn)

        if k == 4 then
            performWithDelay(self, function()
                funcBtn:disable()
            end, 0)
        end
    end
end

function CustomHQPanel:updateModeBtnShow()
    for i = 1, 3 do
        local btn = self.contentLayout:getChildByName("FuncBtn"..i)
        if self.curModeIdx == i then
            btn:setBtnStatus(ButtonState.ACTIVE)
        else
            btn:setBtnStatus(ButtonState.NORMAL)
        end
    end

    if self.curModeIdx == 4 then
        performWithDelay(self, function()
            self.contentLayout:getChildByName("FuncBtn4"):setBtnStatus(ButtonState.ACTIVE)
        end, 0)
    else
        local btn4 = self.contentLayout:getChildByName("FuncBtn4")
        btn4:setBtnStatus(ButtonState.NORMAL)
        btn4:disable()
    end
end

function CustomHQPanel:initDetail()
    local scrollContent = UI.Layout:create()
    scrollContent:init()

    local scrollView = UI.ScrollView:create()
    scrollView:setSize(860, 270)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:init(0, 0, 0, 0)
    scrollView:leftUp(0, 87)
    scrollView:setScrollBarEnabled(true)
    scrollView:setScrollBarWidth(5)
    scrollView:setScrollBarColor(UI.BLACK)
    scrollView:setCircleVisible(false)
    -- scrollView:enableDebugDraw()

    scrollView:addInnerNode(scrollContent)
    self.contentLayout:addChild(scrollView)
    scrollView:scrollToTop()
    self.innerLayer = scrollContent

    local offsetX = {68, 314, 558, 68, 314, 68, 314, 558}
    local offsetY = {26, 26, 26, 104, 104, 180, 180, 124}
    for i = CUSTOM_HQ_TYPE.WEATHER, CUSTOM_HQ_TYPE.PERSON do
        self:insertOne(i, offsetX[i], offsetY[i])
    end
end

function CustomHQPanel:insertOne(idx, x, y)
    if idx == CUSTOM_HQ_TYPE.PERSON then
        self:insertBar(x, y)
    else
        local checkbox = self:createCheckBoxWithLabel(txts[idx], 
        function()
            local initVale
            if self.curModeIdx == 4 then
                initVale = GameManager:getCustomHQ(idx)
            else
                local curMode = CUSTOM_HQ_SET_MAP[self.curModeIdx]
                initVale = curMode[idx]
            end
            self.selectedMode[idx] = initVale

            return initVale
        end, 
        function(isChecked)
            if not self.switchingMode then
                self:updateOneDetail(idx, isChecked)
            end
        end)
        checkbox:leftUp(x, y)
        checkbox:setName("CheckBox"..idx)
        self.innerLayer:addChild(checkbox)
    end
end

function CustomHQPanel:insertBar(x, y)
    local displayStyleLabel = UI.Text:create()
    displayStyleLabel:init(UI.TEXT_1213794, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    displayStyleLabel:setWidth(280)
    displayStyleLabel:setTextLeft()
    displayStyleLabel:autoAdapt()
    displayStyleLabel:leftUp(x, y-20)
    self.innerLayer:addChild(displayStyleLabel)

    local maskSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_control_bar_bg_1.png")
    local thumbSprite = cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png")
    local textList = {}
    for i = 1, #PersonCount do
        local txtTitle = cc.Label:createWithTTF(tostring(PersonCount[i]), UI.FONT_STANDARD, 18)
        txtTitle:setTextColor(UI.FONT_COLOR_50_50_44)
        table.insert(textList, txtTitle)
    end

    local barValue
    if self.curModeIdx == 4 then
        barValue = GameManager:getCustomHQ(CUSTOM_HQ_TYPE.PERSON)
    else
        local curMode = CUSTOM_HQ_SET_MAP[self.curModeIdx]
        barValue = curMode[CUSTOM_HQ_TYPE.PERSON]
    end
    self.selectedMode[CUSTOM_HQ_TYPE.PERSON] = barValue

    local displayStyleSwitch = UI.ControlSwitchStyleTwo:create()
    displayStyleSwitch:init(maskSprite, thumbSprite, textList, maskSprite:getContentSize().width, thumbSprite:getContentSize().height)
    displayStyleSwitch:leftUp(x-54, y+40)
    displayStyleSwitch:setValue(barValue)
    displayStyleSwitch:setName("PersonCount")
    self.innerLayer:addChild(displayStyleSwitch)
    displayStyleSwitch:addEventListener(UIEvent.CONTROL_SWITCH_TOUCH, self, function(obj, num)
        self:updateOneDetail(CUSTOM_HQ_TYPE.PERSON, num)
    end)
end

function CustomHQPanel:updateAllDetails()
    self.switchingMode = true

    local curMode = CUSTOM_HQ_SET_MAP[self.curModeIdx]
    for i = CUSTOM_HQ_TYPE.WEATHER, CUSTOM_HQ_TYPE.PET do
        local checkbox = self.innerLayer:getChildByName("CheckBox"..i)
        checkbox:getChildByName("boxItself"):setValue(curMode[i])

        self:instantSetting(i, curMode[i])
    end

    local bar = self.innerLayer:getChildByName("PersonCount")
    bar:setValue(curMode[CUSTOM_HQ_TYPE.PERSON])

    self:instantSetting(CUSTOM_HQ_TYPE.PERSON, curMode[CUSTOM_HQ_TYPE.PERSON])

    self.switchingMode = false
end

function CustomHQPanel:updateOneDetail(idx, value)
    if self.curModeIdx ~= 4 then
        self.curModeIdx = 4
        self:updateModeBtnShow()
        self.contentLayout:getChildByName("FuncBtn4"):setBtnStatus(ButtonState.ACTIVE)
    end

    self.anythingChanged = true

    UI.ScrollBar:createByText(UI.TEXT_1213795)

    self:instantSetting(idx, value)
end

function CustomHQPanel:instantSetting(idx, value)
    self.selectedMode[idx] = value
    GameManager:setCustomHQ(idx, value)

    if idx == CUSTOM_HQ_TYPE.WEATHER then
        Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)

        local WeatherManager = require("app.game.WeatherManager")
        if value then
            WeatherManager:getInstance():updateWeatherId(SceneManager:getWeatherID())
        else
            WeatherManager:getInstance():hideWeather();
        end
    elseif idx == CUSTOM_HQ_TYPE.NPC then
    elseif idx == CUSTOM_HQ_TYPE.FRAME then
        if value then
            GameManager:setFps(60)
            Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 15, 60, nil)
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_FPS,
            --     30,
            --     60
            -- )
        else
            GameManager:setFps(30)
                        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 15, 30, nil)
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_FPS,
            --     60,
            --     30
            -- )
        end
    elseif idx == CUSTOM_HQ_TYPE.DECORATE then
    elseif idx == CUSTOM_HQ_TYPE.FLOATS then
    elseif idx == CUSTOM_HQ_TYPE.HORCRUX then
        GameManager:handleHideOrShowHorcrux(value)
    elseif idx == CUSTOM_HQ_TYPE.PET then
        GameManager:handleHideOrShowPet(value)
    elseif idx == CUSTOM_HQ_TYPE.PERSON then
        GameManager:handleHideOrShowPersonCount(value)
    end
end


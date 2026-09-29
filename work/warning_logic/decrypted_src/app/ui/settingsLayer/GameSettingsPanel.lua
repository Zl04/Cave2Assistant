--[[
    游戏设置子页面
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.HWBtnComponent"
require "app.utils.ScreenRecordUtil"
require "app.utils.ServerConfigUtil"
require "app.ui.guild.createOrJoin.LoadingPanel"
require "app.ui.baglayer.Setting.BindAccount"
require "app.ui.settingsLayer.SettingPanelBase"
require "app.ui.UIManager"
require "utils.VoiceChatManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local ProtobufUtil = require("utils.ProtobufUtil")
local SdkManager = require("app.game.SdkManager")
local bit = require("bit")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local GameSettingsPanel = class("GameSettingsPanel", UI.SettingPanelBase)
UI.GameSettingsPanel = GameSettingsPanel

---------------------------------------
-- eo 模块初始化 --






-- 资源统合 --
---------------------------------------
---------------------------------------
-- eo 资源统合 --



-- 生命周期 --
---------------------------------------
-- 构造函数
function GameSettingsPanel:ctor()
    GameSettingsPanel.super.ctor(
        self, 
        UIType.SETTINGS_BASIC_PANEL,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0)

    self:bindModel()
end

-- 析构函数
function GameSettingsPanel:dtor(...)
    Avalon.AudioManager:saveMusicVolume()
    Avalon.AudioManager:saveSoundsVolume()
    Avalon.AudioManager:saveMusicVolumeForDisplay(self._musicControlSlider:getValue())
    Avalon.AudioManager:saveSoundsVolumeForDisplay(self._soundsControlSlider:getValue())
    -- $$$$$$ 剥离声网sdk
    -- Avalon.VoiceChatManager:saveCurrentSettings()
    GameSettingsPanel.super.dtor(self, ...)

    -- 关闭设置界面时发出操作方式更新消息
    Avalon.MessageCenter:notice(AvalonMessage.MC_SETTING_CONTROL_CHANGE)

    -- 清除UI恢复回调
    UI.UIManager:setUIRestoreButtonCallback(nil)

    -- reload_script_file("app.ui.settingsLayer.GameSettingsPanel")
    self:unbindModel()
end

-- 初始化
function GameSettingsPanel:init(width, height)
	GameSettingsPanel.super.init(self)
	self:setSize(width, height)
end
-- 表现初始化
function GameSettingsPanel:onInitView(...)
	GameSettingsPanel.super.onInitView(self, ...)

    -- 音乐滑块
    local musicProgressSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_10.png")
    self._musicControlSlider = cc.ControlSlider:create(
        cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_00.png"),
        musicProgressSprite,
        cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"),
        cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"))
    self._musicControlSlider:setMinimumValue(0.0) 
    self._musicControlSlider:setMaximumValue(1.0) 
    self._musicControlSlider:setAnchorPoint(0, 0)
    self._musicControlSlider:setPosition(105, 418)
    self._musicControlSlider:setValue(Avalon.AudioManager:getMusicVolumeForDisplay())
    self:useShader(musicProgressSprite, Avalon.AudioManager:isMusicOnForDisplay() and UI.COMPONENT_NORMAL_SHADER or UI.COMPONENT_GRAY_SHADER)
    self:addChild(self._musicControlSlider)
    self._musicControlSlider:registerControlEventHandler(function()
    	-- 设置音量
    	local musicVolume = self._musicControlSlider:getValue()
    	Avalon.AudioManager:setMusicVolume(musicVolume)
        Avalon.AudioManager:saveMusicVolumeForDisplay(musicVolume)
    	-- 设置勾选框
    	local boxItself = self._musicCheckbox:getChildByName("boxItself")
        boxItself:setValue(musicVolume ~= 0)
    end, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)

    -- 音乐勾选
    self._musicCheckbox = self:createCheckBoxWithLabel(LanguageManager:getInstance():getLocalString(1110414)--[["音乐"]], function() return Avalon.AudioManager:isMusicOnForDisplay() end, function(isChecked)
        local flag = 0
        if (isChecked) then
            flag = 1
            self:useShader(musicProgressSprite, UI.COMPONENT_NORMAL_SHADER)
            Avalon.AudioManager:setMusicVolume(self._musicControlSlider:getValue())
        else
            self:useShader(musicProgressSprite, UI.COMPONENT_GRAY_SHADER)
            Avalon.AudioManager:setMusicVolume(0)
        end
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_Music, flag)
    end)
    self._musicCheckbox:leftBottom(105, 458)
    self:addChild(self._musicCheckbox)

    -- 音效滑块
    local soundsProgressSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_10.png")
    self._soundsControlSlider = cc.ControlSlider:create(
        cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_00.png"),
        soundsProgressSprite,
        cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"),
        cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"))
    self._soundsControlSlider:setMinimumValue(0.0)
    self._soundsControlSlider:setMaximumValue(1.0) 
    self._soundsControlSlider:setAnchorPoint(0, 0)
    self._soundsControlSlider:setPosition(547, 418)
    self._soundsControlSlider:setValue(Avalon.AudioManager:getSoundsVolumeForDisplay())
    self:useShader(soundsProgressSprite, Avalon.AudioManager:isSoundsOnForDisplay() and UI.COMPONENT_NORMAL_SHADER or UI.COMPONENT_GRAY_SHADER)
    self:addChild(self._soundsControlSlider)
    self._soundsControlSlider:registerControlEventHandler(function()
    	-- 设置音量
    	local soundsVolume = self._soundsControlSlider:getValue()
    	Avalon.AudioManager:setSoundsVolume(soundsVolume)
        Avalon.AudioManager:saveSoundsVolumeForDisplay(soundsVolume)
    	-- 设置勾选框
    	local boxItself = self._soundCheckbox:getChildByName("boxItself")
    	boxItself:setValue(soundsVolume ~= 0)
    end, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)

    -- 音效勾选
    self._soundCheckbox = self:createCheckBoxWithLabel(LanguageManager:getInstance():getLocalString(1110415)--[["音效"]], function() return Avalon.AudioManager:isSoundsOnForDisplay() end, function(isChecked)
        local flag = 0
        if (isChecked) then
            flag = 1
            self:useShader(soundsProgressSprite, UI.COMPONENT_NORMAL_SHADER)
            Avalon.AudioManager:setSoundsVolume(self._soundsControlSlider:getValue())
        else
            self:useShader(soundsProgressSprite, UI.COMPONENT_GRAY_SHADER)
            Avalon.AudioManager:setSoundsVolume(0)
        end
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_Sound, flag)
    end)
    self._soundCheckbox:leftBottom(547, 458)
    self:addChild(self._soundCheckbox)

    -- if device.platform ~= "windows" and device.platform ~= "mac" then
        -- 语音聊天播放滑块
        -- local spkProgressSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_10.png")
        -- self._spkControlSlider = cc.ControlSlider:create(
        --     cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_00.png"),
        --     spkProgressSprite,
        --     cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"),
        --     cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"))
        -- self._spkControlSlider:setMinimumValue(0.0) 
        -- self._spkControlSlider:setMaximumValue(1.0) 
        -- self._spkControlSlider:setAnchorPoint(0, 0)
        -- self._spkControlSlider:setPosition(105, 318)
        -- self._spkControlSlider:setValue(Avalon.VoiceChatManager:getSpkVolume())
        -- self:useShader(spkProgressSprite, Avalon.VoiceChatManager:isSpeakerMuted() and UI.COMPONENT_GRAY_SHADER or UI.COMPONENT_NORMAL_SHADER)
        -- self:addChild(self._spkControlSlider)
        -- self._spkControlSlider:registerControlEventHandler(function()
        --     -- 设置音量
        --     local voiceChatSpeakerVolume = self._spkControlSlider:getValue()
        --     Avalon.VoiceChatManager:setSpkVolume(voiceChatSpeakerVolume)

        --     -- 设置勾选框
        --     local boxItself = self._spkCheckbox:getChildByName("boxItself")
        --     boxItself:setValue(voiceChatSpeakerVolume ~= 0)
        -- end, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)
        -- -- 语音聊天播放勾选
        -- self._spkCheckbox = self:createCheckBoxWithLabel(LanguageManager:getInstance():getLocalString(1111735)--[["聊天队友音量"]], function() return not Avalon.VoiceChatManager:isSpeakerMuted() end, function(isChecked, layout, comp, isByTouch)
        -- local isMuted = Avalon.VoiceChatManager:setMuteSpeaker(not isChecked, isByTouch)
        --     -- 如果失败(没有权限), 设置回原值
        --     if (isMuted == isChecked) then
        --         comp:setValue(not isChecked)
        --         return
        --     end
        --     local flag = 0
        --     if (not isChecked) then
        --         self:useShader(spkProgressSprite, UI.COMPONENT_GRAY_SHADER)
        --     else
        --         flag = 1
        --         self:useShader(spkProgressSprite, UI.COMPONENT_NORMAL_SHADER)
        --     end
        --     Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_Friend, flag)
        -- end)
        -- self._spkCheckbox:leftBottom(105, 358)
        -- self:addChild(self._spkCheckbox)
        -- -- 语音聊天录音滑块
        -- local micProgressSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_10.png")
        -- self._micControlSlider = cc.ControlSlider:create(
        --     cc.Sprite:createWithSpriteFrameName("ui_setup_progressbar_00.png"),
        --     micProgressSprite,
        --     cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"),
        --     cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png"))
        -- self._micControlSlider:setMinimumValue(0.0) 
        -- self._micControlSlider:setMaximumValue(1.0) 
        -- self._micControlSlider:setAnchorPoint(0, 0)
        -- self._micControlSlider:setPosition(547, 318)
        -- self._micControlSlider:setValue(Avalon.VoiceChatManager:getMicVolume())
        -- self:useShader(micProgressSprite, Avalon.VoiceChatManager:isMicMuted() and UI.COMPONENT_GRAY_SHADER or UI.COMPONENT_NORMAL_SHADER)
        -- self:addChild(self._micControlSlider)
        -- self._micControlSlider:registerControlEventHandler(function()
        --     -- 设置音量
        --     local voiceChatMicVolume = self._micControlSlider:getValue()
        --     Avalon.VoiceChatManager:setMicVolume(voiceChatMicVolume)
        --     -- 设置勾选框
        --     local boxItself = self._micCheckbox:getChildByName("boxItself")
        --     boxItself:setValue(voiceChatMicVolume ~= 0)
        -- end, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)
        -- -- 语音聊天录音勾选
        -- self._micCheckbox = self:createCheckBoxWithLabel(LanguageManager:getInstance():getLocalString(1111736)--[["聊天麦克风音量"]], function() return not Avalon.VoiceChatManager:isMicMuted() end, function(isChecked, layout, comp, isByTouch)
        --     local isMuted = Avalon.VoiceChatManager:setMuteMic(not isChecked, isByTouch)
        --     -- 如果失败(没有权限), 设置回原值
        --     if (isMuted == isChecked) then
        --         comp:setValue(not isChecked)
        --         return
        --     end
        --     local flag = 0
        --     -- 改变拖动条颜色
        --     if (isMuted) then
        --         flag = 1
        --         self:useShader(micProgressSprite, UI.COMPONENT_GRAY_SHADER)
        --     else
        --         self:useShader(micProgressSprite, UI.COMPONENT_NORMAL_SHADER)
        --     end
        --     Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_Microphone, flag)
        -- end)
        -- self._micCheckbox:leftBottom(547, 358)
        -- self:addChild(self._micCheckbox)
    -- end

    --回城特效
    local displayBackLabel = UI.Text:create()
    displayBackLabel:init(LanguageManager:getInstance():getLocalString(1114640), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    displayBackLabel:leftBottom(105, 362)
    self:addChild(displayBackLabel)

    local backButton = UI.Button:create() 
    backButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    backButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- backButton:setText(backBtnNameType[1])
    backButton:leftBottom(105, 310)
    self:addChild(backButton)
    backButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        require("app.ui.baglayer.Setting.SelectBackEffectLayer")
        local pSelectBackEffectLayer = UI.SelectBackEffectLayer:create(PublicDefine.PlayerDecorateType.PlayerDecorateType_Portal)
        pSelectBackEffectLayer:center(0, -30)
        pSelectBackEffectLayer:setName("SelectBackEffectLayer")
        self:addChild(pSelectBackEffectLayer, UI_ZORDER.ACTIVITY)
    end)
    self.backButton = backButton

    --摇杆外形 rockerShape
    local displayRockerShapeLabel = UI.Text:create()
    displayRockerShapeLabel:init(LanguageManager:getInstance():getLocalString(1114641), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    displayRockerShapeLabel:leftBottom(547, 362)
    self:addChild(displayRockerShapeLabel)

    local brockerShapeButton = UI.Button:create() 
    brockerShapeButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    brockerShapeButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- brockerShapeButton:setText(backBtnNameType[1])
    brockerShapeButton:leftBottom(547, 310)
    self:addChild(brockerShapeButton)
    brockerShapeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        require("app.ui.baglayer.Setting.SelectBackEffectLayer")
        local pSelectBackEffectLayer = UI.SelectBackEffectLayer:create(PublicDefine.PlayerDecorateType.PlayerDecorateType_UI)
        pSelectBackEffectLayer:center(0, -30)
        pSelectBackEffectLayer:setName("SelectBackEffectLayer")
        self:addChild(pSelectBackEffectLayer, UI_ZORDER.ACTIVITY)
    end)
    self.brockerShapeButton = brockerShapeButton

    self:updateTigerEffect()
    

    -- 角色数值标签
    local displayStyleLabel = UI.Text:create()
    displayStyleLabel:init(LanguageManager:getInstance():getLocalString(1110773)--[["角色数值"]], UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    displayStyleLabel:leftBottom(105, 245)
    self:addChild(displayStyleLabel)

    -- 角色数值控件
    local maskSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_control_bar_bg_1.png")
    local thumbSprite = cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png")
    local strings = {UI.TEXT_111121, UI.TEXT_111122, UI.TEXT_111123}
    local textList = {}
    for i = 1, #strings do
        local txtTitle = cc.Label:createWithTTF(strings[i], UI.FONT_STANDARD, 18)
        txtTitle:setTextColor(UI.FONT_COLOR_50_50_44)
        table.insert(textList, txtTitle)
    end

    local displayStyleSwitch = UI.ControlSwitchStyleTwo:create()
    displayStyleSwitch:init(maskSprite, thumbSprite, textList, maskSprite:getContentSize().width, thumbSprite:getContentSize().height)
    displayStyleSwitch:leftBottom(68, 212)
    displayStyleSwitch:setValue(GameManager:getRoleInfoShowType())
    self:addChild(displayStyleSwitch)
    displayStyleSwitch:addEventListener(UIEvent.CONTROL_SWITCH_TOUCH, self, function(obj, num)
        if(num == 1) then
            Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 16, ShowType.NONE, nil)
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Value,
            --     GameManager:getRoleInfoShowType(),
            --     ShowType.NONE
            -- )
            GameManager:setRoleInfoShowType(ShowType.NONE)
            UI.ScrollBar:createByText(UI.TEXT_111135)
        elseif (num == 2) then
            Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 16, ShowType.PERCENT, nil)
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Value,
            --     GameManager:getRoleInfoShowType(),
            --     ShowType.PERCENT
            -- )
            GameManager:setRoleInfoShowType(ShowType.PERCENT)
            UI.ScrollBar:createByText(UI.TEXT_111136)
        elseif (num == 3) then
            Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 16, ShowType.VALUE, nil)
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Value,
            --     GameManager:getRoleInfoShowType(),
            --     ShowType.VALUE
            -- )
            GameManager:setRoleInfoShowType(ShowType.VALUE)
            UI.ScrollBar:createByText(UI.TEXT_111137)
        else
            Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 16, ShowType.NONE, nil)
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Value,
            --     GameManager:getRoleInfoShowType(),
            --     ShowType.NONE
            -- )
            GameManager:setRoleInfoShowType(ShowType.NONE)
        end
    end)

    -- 移动方式标签
    local moveStyleLabel = UI.Text:create()
    moveStyleLabel:init(UI.TEXT_111116, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    moveStyleLabel:leftBottom(500, 245)
    self:addChild(moveStyleLabel)

    -- 移动方式控件
    local maskSprite = cc.Sprite:createWithSpriteFrameName("ui_setup_control_bar_bg_2.png")
    local thumbSprite = cc.Sprite:createWithSpriteFrameName("ui_information_progressbar_01.png")
    local strings = {UI.TEXT_1212036, UI.TEXT_111118, UI.TEXT_111117, LanguageManager:getInstance():getLocalString(1111562)}
    local textList = {}
    for i = 1, #strings do
        local txtTitle = cc.Label:createWithTTF(strings[i], UI.FONT_STANDARD, 18)
        txtTitle:setTextColor(UI.FONT_COLOR_50_50_44)
        table.insert(textList, txtTitle)
    end

    local moveStyleSwitch = UI.ControlSwitchStyleTwo:create()
    moveStyleSwitch:init(maskSprite, thumbSprite, textList, maskSprite:getContentSize().width, thumbSprite:getContentSize().height)
    moveStyleSwitch:leftBottom(463, 212)
    moveStyleSwitch:setValue(GameManager:getMoveType())
    self:addChild(moveStyleSwitch)
    moveStyleSwitch:addEventListener(UIEvent.CONTROL_SWITCH_TOUCH, self, function(obj, num)
        if(num == 1) then
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
            --     GameManager:getMoveType(),
            --     MoveType.ALL
            -- )
            GameManager:setMoveType(MoveType.ALL)
            UI.UIManager:setHideScreenSaveControlType(MoveType.ALL)
            UI.ScrollBar:createByText(UI.TEXT_1212035)
        elseif (num == 2) then
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
            --     GameManager:getMoveType(),
            --     MoveType.CLICK
            -- )
            GameManager:setMoveType(MoveType.CLICK)
            UI.UIManager:setHideScreenSaveControlType(MoveType.CLICK)
            UI.ScrollBar:createByText(UI.TEXT_111132)
        elseif (num == 3) then
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
            --     GameManager:getMoveType(),
            --     MoveType.CONTROLLER
            -- )
            GameManager:setMoveType(MoveType.CONTROLLER)
            UI.UIManager:setHideScreenSaveControlType(MoveType.CONTROLLER)
            UI.ScrollBar:createByText(UI.TEXT_111131)
        elseif (num == 4) then
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
            --     GameManager:getMoveType(),
            --     MoveType.NORMAL
            -- )
            GameManager:setMoveType(MoveType.NORMAL)
            UI.UIManager:setHideScreenSaveControlType(MoveType.CONTROLLER)
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111563))
        else
            -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
            --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_MoveType,
            --     GameManager:getMoveType(),
            --     MoveType.ALL
            -- )
            GameManager:setMoveType(MoveType.ALL)
            UI.UIManager:setHideScreenSaveControlType(MoveType.ALL)
        end
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_Move, GameManager:getMoveType())
    end)
end

function GameSettingsPanel:updateTigerEffect()
    
    local masterData = RoleDataManager:getMaster()
    if not masterData then
        return 
    end

    

    if self.backButton then
        self.backButton:setText(UI.TEXT_222680)
    end
    if self.brockerShapeButton then
        self.brockerShapeButton:setText(UI.TEXT_222680)
    end

    local eData = masterData:getGameUIEquippedDecorates()

    for k,v in pairs(eData) do
        if v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_Portal then
            if v.value == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger and self.backButton then --虎年
                self.backButton:setText(UI.TEXT_222681)
            elseif v.value == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate and self.backButton then --海盗
                self.backButton:setText(UI.TEXT_222683)
            end
        elseif v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI then
            if v.value == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger and self.brockerShapeButton then --虎年
                self.brockerShapeButton:setText(UI.TEXT_222682)
            elseif v.value == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate and self.brockerShapeButton then --海盗
                self.brockerShapeButton:setText(UI.TEXT_222684)
            end
        end
    end
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
function GameSettingsPanel:useShader(targetComp, shaderDefine)
    local normalShader = self:getShader(shaderDefine)
    targetComp:setGLProgramState(normalShader)
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------
function GameSettingsPanel:bindModel()
    -- 刷新老逻辑处上面部分的按钮
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
end

function GameSettingsPanel:unbindModel()
    -- 刷新老逻辑处上面部分的按钮
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_MINI_LAYER_TIGER_EFFECT, self, self.updateTigerEffect)
end
---------------------------------------
-- eo 事件处理 --
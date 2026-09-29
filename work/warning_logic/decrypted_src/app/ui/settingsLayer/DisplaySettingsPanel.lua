--[[
    显示设置子页面
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
local DisplaySettingsPanel = class("DisplaySettingsPanel", UI.SettingPanelBase)
UI.DisplaySettingsPanel = DisplaySettingsPanel

---------------------------------------
-- eo 模块初始化 --






-- 数据结构 --
---------------------------------------
-- 勾选设置数据结构
    local checkBoxData = {
        [1] = {
            label = LanguageManager:getInstance():getLocalString(1110768), -- "显示头盔"
            isToDisplayFunc = function(thisData) return true end,
            initialStateFunc = function(thisData) return not RoleDataManager:getMaster():getIsHideHelmet() end,
            callback = function(thisData, isChecked)
                local flag = 0
                if not isChecked then
                    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
                    --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Helmet,
                    --     PublicDefine.Config_Helmet_Hidden.Show,
                    --     PublicDefine.Config_Helmet_Hidden.Hidden
                        
                    -- )
                    Net.NetRoleSystem:requestHideHelmet(true)
                    UI.ScrollBar:createByText(UI.TEXT_111129)
                else
                    flag = 1
                    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
                    --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Helmet,
                    --     PublicDefine.Config_Helmet_Hidden.Hidden,
                    --     PublicDefine.Config_Helmet_Hidden.Show
                    -- )

                    Net.NetRoleSystem:requestHideHelmet(false)
                    UI.ScrollBar:createByText(UI.TEXT_111130)
                end
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_Helmet, flag)
            end
        },
        [2] = {
            label = LanguageManager:getInstance():getLocalString(1110765), --"屏蔽聊天"
            isToDisplayFunc = function(thisData) return true end,
            initialStateFunc = function(thisData) return GameManager:getShieldChat() end,
            callback = function(thisData, isChecked)
                local flag = 0
                if (not isChecked) then
                    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
                    --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Chat,
                    --     PublicDefine.Config_Chat_Block.Open,
                    --     PublicDefine.Config_Chat_Block.Close
                    -- )
                    
                    GameManager:setShieldChat(false)
                    UI.ScrollBar:createByText(UI.TEXT_111134)
                else
                    flag = 1
                    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
                    --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Chat,
                    --     PublicDefine.Config_Chat_Block.Close,
                    --     PublicDefine.Config_Chat_Block.Open
                    -- )
                    GameManager:setShieldChat(true)
                    UI.ScrollBar:createByText(UI.TEXT_111133)
                end
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_ShieldingChat, flag)
            end
        },
        [3] = {
            label = LanguageManager:getInstance():getLocalString(1111246), --"屏幕录像"
            -- isToDisplayFunc = function(thisData) return device.platform == "ios" end,
            -- 策划要求暂时屏蔽录制按钮
            isToDisplayFunc = function(thisData) return false end,
            initialStateFunc = function(thisData) 
                thisData.oldState = ScreenRecordUtil:getInstance():getRecorderOn()
                return thisData.oldState
            end,
            callback = function(thisData, isChecked, thisComponent)
                ScreenRecordUtil:getInstance():setRecorderOn(isChecked, function(isSucc, errorCode) 
                    if (not isSucc) then
                        local boxItself = thisComponent:getChildByName("boxItself")
                        boxItself:setValue(thisData.oldState)
                        local errorString = ScreenRecordUtil:getInstance():getErrorString(errorCode)
                        UI.ScrollBar:createByText(errorString)
                    end
                end)
            end
        },
        [4] = {
            label = UI.TEXT_1212038, --"隐藏UI"
            isToDisplayFunc = function(thisData) return true end,
            initialStateFunc = function(thisData, thisComponent)
                -- 在设置界面还打开的时候恢复显示UI要把开关也设置回去. 用一个回调来实现. dtor里清除了回调.
                UI.UIManager:setUIRestoreButtonCallback(
                    function()
                        local boxItself = thisComponent:getChildByName("boxItself") 
                        boxItself:setValue(false)
                    end)
                return not UI.UIManager:checkIsShowMainUI() 
            end,
            callback = function(thisData, isChecked, thisComponent)
                if (isChecked) then
                    UI.ConfirmDialog.show(UI.TEXT_1212039, function()
                        UI.UIManager:setShowMainUI(false)
                        UI.UIManager:setHideScreenSaveControlType(GameManager:getMoveType())
                        GameManager:setMoveType(MoveType.CLICK, false)
                        UI.ScrollBar:createByText(UI.TEXT_1212041)
                    end, function()
                        local boxItself = thisComponent:getChildByName("boxItself")  
                        boxItself:setValue(false)
                    end)
                else
                    UI.UIManager:setShowMainUI(true)
                    UI.ScrollBar:createByText(UI.TEXT_1212042)
                end
            end
        },
        [5] = {
            label = LanguageManager:getInstance():getLocalString(1111485), --"隐藏墙壁"
            isToDisplayFunc = function(thisData) return true end,
            initialStateFunc = function(thisData)
                local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
                local isHide = false
                if globalUserData then
                    isHide = globalUserData:isHideWall()
                end
                return isHide
            end,
            callback = function(thisData, isChecked)
                local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, GameDataManager:getInstance():getSaveUserKey())
                local isHide = false
                if globalUserData then
                    isHide = globalUserData:isHideWall()
                end
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_HideWall, isHide == true and 1 or 0)
                if isHide then
                    if globalUserData then
                        globalUserData:hideWall(not isHide)
                        Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)
                    end
                    UI.ScrollBar:createByText(UI.TEXT_111164)
                    return false
                else
                    if globalUserData then
                        globalUserData:hideWall(not isHide)
                        Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)
                    end
                    UI.ScrollBar:createByText(UI.TEXT_111165)
                    
                    return true
                end
            end
        },
        -- [7] = {
        --     label = LanguageManager:getInstance():getLocalString(1111842), --"屏蔽私聊"
        --     isToDisplayFunc = function(thisData) return true end,
        --     initialStateFunc = function(thisData)
        --         local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, AvalonUtil.getIdentifier())
        --         local isDisable = false
        --         if globalUserData then
        --             isDisable = not globalUserData:isReceivePM()
        --         end
        --         return isDisable
        --     end,
        --     callback = function(thisData, isChecked)
        --         local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, AvalonUtil.getIdentifier())
        --         if globalUserData then
        --             globalUserData:receivePM(not isChecked)
        --             Avalon.UserDataManager:saveDataToFile(USER_DATA_TYPE.GLOBAL)
        --             if isChecked then
        --                 UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111843))
        --             else
        --                 UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111844))
        --             end
        --             Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_PrivateChat, isChecked == true and 1 or 0)
        --         else
        --             UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170002))
        --         end
        --     end
        -- },
        [6] = {
            label = LanguageManager:getInstance():getLocalString(1112629) --[["拒绝收徒"]],
            isToDisplayFunc = function(thisData) return mvc.apprenticeshipModel:isMentorReqMet() end,
            initialStateFunc = function(thisData) return mvc.apprenticeshipModel:mentorIsRejectMentoring() end,
            callback = function(thisData, isChecked)
                mvc.send(mvc.events.Mentor_Tutor_Setting_Message, isChecked)
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_RefusedApprentice, isChecked == true and 1 or 0)
            end
        },
    }


-- 按钮设置数据结构
local componentsData = {
    [1] = { -- 语言切换
        isToDisplayFunc = function(thisData) return true end,
        getLayoutFunc = function(self, thisData) 
            local content = UI.Layout:create()
            content:init()

            -- 语言选择标签
            local displayStyleLabel = UI.Text:create()
            displayStyleLabel:init(UI.TEXT_111119, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            displayStyleLabel:leftUp(0, 0)
            content:addChild(displayStyleLabel)

            -- 语言选择按钮
            local yellowButton = UI.Button:create() 
            yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
            yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            yellowButton:setText(LanguageManager:getInstance():getLocalString(1220000 + LanguageManager:getInstance():getLanguage()))
            yellowButton:leftUp(0, 35)
            content:addChild(yellowButton)
            yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                require("app.ui.baglayer.Setting.SelectLanguageLayer")
                local pSelectLanguageLayer = UI.SelectLanguageLayer:create(NPCSpriteID)
                pSelectLanguageLayer:center(0, -30)
                pSelectLanguageLayer:setName("SelectLanguageLayer")
                self:addChild(pSelectLanguageLayer, UI_ZORDER.ACTIVITY)
            end)

            return content
        end
    },
    [2] = { -- 服务器切换
        isToDisplayFunc = function(self, thisData) return true end,
        getLayoutFunc = function(self, thisData) 
            local content = UI.Layout:create()
            content:init()

            -- 服务器选择标签
            local displayStyleLabel = UI.Text:create()
            displayStyleLabel:init(UI.TEXT_111138, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            displayStyleLabel:leftUp(0, 0)
            content:addChild(displayStyleLabel)

            local isOpenChangeServer = GameManager:getIsOpenArea()

            local serverName = nil
            if(isOpenChangeServer) then
                local areaServerData = mvc.settingModel:getNowAreaData()
                if(areaServerData) then 
                    serverName = areaServerData:getAreaName()
                end
            else
                serverName = ServerConfigUtil:getName()
            end

            -- 服务器选择按钮
            local yellowButton = UI.Button:create() 
            yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
            if(isOpenChangeServer) then
                yellowButton:setTextFont(UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            else
                yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            end
            yellowButton:setText(serverName or UI.TEXT_111138)
            yellowButton:leftUp(0, 35)
            content:addChild(yellowButton)
            yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                if(isOpenChangeServer) then 
                    mvc.openPanel("Setting", "SettingAreaServerSelect")
                else    
                    -- 如果只有1个以下服务器 不能选择
                    local serverCfg = ServerConfigUtil:getServerList()
                    local serverCout = table.nums(serverCfg)
                    if serverCout <= 1 then
                        printWarn("DisplaySettingsPanel:onSelectServer serverCout = ", serverCout)
                        return
                    end
                    require("app.ui.baglayer.Setting.SelectServerLayer")
                    local pSelectServerLayer = UI.SelectServerLayer:create(NPCSpriteID)
                    pSelectServerLayer:center()
                    pSelectServerLayer:setName("SelectServerLayer")
                    self:addChild(pSelectServerLayer,UI_ZORDER.ACTIVITY)
                end
            end)

            return content
        end
    }, 
    [3] = { -- 频道切换
        isToDisplayFunc = function(self, thisData) return SceneManager:getInstance():isInTown() end,
        getLayoutFunc = function(self, thisData) 
            local content = UI.Layout:create()
            content:init()

            -- 换线标签
            local channelSwitchLabel = UI.Text:create()
            channelSwitchLabel:init(UI.TEXT_1170940, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            channelSwitchLabel:leftUp(0, 0)
            content:addChild(channelSwitchLabel)

            local cha = -38
            local size = {width = 213, height = 27}
            --  切换频道输入框 ui_setup_progressbar_01
            local node = UI.Component:create();
            node:init()
            node:setSize(size.width, size.height)
            node:leftUp(5, 45)
            content:addChild(node)

            local bgMask = UI.Image9:create()
            bgMask:init("ui_setup_button_switchbox.png", CCRectMake(0, 0, 50, 50))
            bgMask:setReflectSize(224, 44)
            bgMask:centerLeft(-5)
            node:addChild(bgMask)
            

            local changeTownChannelEdit = cc.EditBox:create(size, "ui_setup_control_bar_bg.png")
            local maskSprite = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_control_bar_bg.png")
            maskSprite:setCapInsets(cc.rect(8,9,4,1));

            -- changeTownChannelEdit:initWithSizeAndBackgroundSprite(size, maskSprite)
            changeTownChannelEdit:setFontSize(18)
            changeTownChannelEdit:setFontName(UI.FONT_STANDARD)
            -- changeTownChannelEdit:setPlaceHolder(UI.TEXT_1170939)
            changeTownChannelEdit:setInputMode(cc.EDITBOX_INPUT_MODE_DECIMAL)
            changeTownChannelEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
            changeTownChannelEdit:setPlaceholderFontSize(18)
            changeTownChannelEdit:setAnchorPoint(0, 0)
            changeTownChannelEdit:setFontColor(UI.FONT_COLOR_50_50_44)

            local masterData = GameDataManager:getInstance():getMaster()
            if(masterData) then
                changeTownChannelEdit:setText(tostring(self:splitChannel(masterData:getTownChannelID())))
            else 
                changeTownChannelEdit:setText("")
            end
            changeTownChannelEdit:setMaxLength(10)
            node:addChild(changeTownChannelEdit)

            -- 切换按钮
            local changeTownButton = UI.Button:create()
            changeTownButton:init("ui_setup_button_switch_0.png", "ui_setup_button_switch_1.png")
            changeTownButton:centerRight(0, -1)
            changeTownButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                -- body
                local function clickFunc()
                    -- 处理请求切换
                    local text = self:mergeChannel(changeTownChannelEdit:getText())
                    if(text) then
                        if text == "" then 
                            -- 输入格式不对
                            local tips = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1111284), UI.TipsType.CONFIRM, UI.TipsUiType.NORMAL) --AvalonUtil.getIdentifier()
                            tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                        
                            end)
                        else 
                            if(masterData) then
                                if(tonumber(text) == masterData:getTownChannelID()) then
                                    --  你已经在该频道了
                                    UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170145))
                                    return 
                                end
                            end

                            local currentTime = AvalonUtil:getCurrentTime()
                            if(currentTime - self._changeTownChannelTime  > 2000) then
                                self._changeTownChannelTime = currentTime

                                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                                Net.NetRoleSystem:requestChangeTownChannel(tonumber(text))
                            else
                                -- 切换太频繁，稍后再试
                                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111071))
                            end
                        end
                    else 
                        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111072))
                    end
                end

                local canChange = true
                canChange = mvc.worldBossModel:checkCanEnterOther()  -- 如果 worldboss 已报名，提醒一次
                canChange = mvc.festivalModel:checkCanEnterOther()  -- 节日活动已报名，提醒一次

                if canChange then
                    clickFunc()
                else
                    UI.ScrollBar:createByText(UI.TEXT_1212663)
                end
            end)
            node:addChild(changeTownButton)
            changeTownButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
            changeTownButton:setText(UI.TEXT_111162)

            changeTownChannelEdit:registerScriptEditBoxHandler(function(strEventName,sender) 
                if(strEventName == "began") then

                elseif (strEventName == "ended") then
            
                elseif (strEventName == "return") then
                    local message = changeTownChannelEdit:getText() or ""
                    -- print("CreateGuild:editboxHandle  0", message, type(message))
                    local isHave = string.find(message, "\n")
                    if isHave ~= nil then
                        message = string.gsub(message, "\n", "")
                    end
            
                    changeTownChannelEdit:setText(message)
                    changeTownChannelEdit:setPlaceHolder(UI.TEXT_1170939)
                elseif (strEventName == "changed") then
                    local message = changeTownChannelEdit:getText() or ""
                    local isHave = string.find(message, "\n")
                    if isHave ~= nil then
                        message = string.gsub(message, "\n", "")
                        changeTownChannelEdit:setText(message)
                        AvalonUtil.closeKeyBoard(changeTownChannelEdit)
                    end
                end
            end)

            return content
        end
    },
    [4] = { -- 场景切换
        isToDisplayFunc = function(self, thisData) return SceneManager:getInstance():isInTown() end,
        getLayoutFunc = function(self, thisData) 
            local content = UI.Layout:create()
            content:init()

            -- 场景类型选择标签
            local displayStyleLabel = UI.Text:create()
            displayStyleLabel:init(UI.TEXT_1325000, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            displayStyleLabel:leftUp(0, 0)
            content:addChild(displayStyleLabel)

            local serverName = UI.TEXT_1325001
            if(GameManager:getIsInNewScene()) then 
                serverName = UI.TEXT_1325002
            end

            -- 场景选择按钮选择按钮
            local yellowButton = UI.Button:create() 
            yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
            yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            yellowButton:setText(serverName or UI.TEXT_1325001)
            yellowButton:leftUp(0, 35)
            content:addChild(yellowButton)
            yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                -- mvc.openPanel("Setting", "SettingAreaServerSelect")
                local tip = UI.TipsLayer:onShowCommonTextHandler(string.format(UI.TEXT_1325003, serverName), function()
                    -- local nowAreaData = mvc.settingModel:getNowAreaData()
                    -- local areaID = -1
                    -- if(nowAreaData and nowAreaData:getAreaID()) then
                    --     areaID = nowAreaData:getAreaID()
                    -- end
                    GameManager:setIsNewTownType(not GameManager:getIsNewTownType())

                    local gameLoginManager = require("app.game.GameLoginManager")
                    -- gameLoginManager:getInstance():setAreaID(areaID)
                    gameLoginManager:getInstance():changeScene()
                end)
                tip:setContentFontName(UI.FONT_STANDARD, UI.FONT_SIZE_20PX)
            end)

            return content
        end
    }, 
}
---------------------------------------
-- eo 数据结构 --






-- 生命周期 --
---------------------------------------
-- 构造函数
function DisplaySettingsPanel:ctor()
    DisplaySettingsPanel.super.ctor(
        self, 
        UIType.SETTINGS_ADVANCED_PANEL,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0)
end

-- 析构函数
function DisplaySettingsPanel:dtor(...)
    DisplaySettingsPanel.super.dtor(self, ...)
    -- reload_script_file("app.ui.settingsLayer.DisplaySettingsPanel")

    self:unregisterListener()
end

-- 初始化
function DisplaySettingsPanel:init(width, height)
	DisplaySettingsPanel.super.init(self)

    self._changeTownChannelTime = AvalonUtil:getCurrentTime()

	self:setSize(width, height)

    self:registerListener()
end
-- 表现初始化
function DisplaySettingsPanel:onInitView(...)
	DisplaySettingsPanel.super.onInitView(self, ...)

    -- 计算要显示的按钮组件数量
    local btnCountPerRow  = 2
    local btnDisplayCount = 0
    for i,v in ipairs(componentsData) do
        if (v:isToDisplayFunc()) then
            btnDisplayCount = btnDisplayCount + 1
        end
    end
    local btnTotalRowCount = math.ceil(btnDisplayCount / btnCountPerRow)

    local scrollWidth, scrollHeight = 850, 350
    local scrollContent = UI.Layout:create()
    scrollContent:init()
    scrollContent:centerUp(0)

    local detailedScrollView = UI.ScrollView:create()
    detailedScrollView:setSize(scrollWidth, scrollHeight)
    detailedScrollView:init(0, 0, 0, 0)
    detailedScrollView:leftUp(105, 96)
    detailedScrollView:setScrollBarEnabled(true)
    detailedScrollView:setScrollBarWidth(5)
    detailedScrollView:setCircleVisible(false)
    detailedScrollView:addInnerNode(scrollContent)
    self:addChild(detailedScrollView)

    -- 创建设置区域布局
    local btnLayout = UI.Layout:create()
    btnLayout:init()
    btnLayout:setSize(0, btnTotalRowCount * 97)
    btnLayout:leftUp(0, 20)
    scrollContent:addChild(btnLayout)

    -- 添加行和设置组件
    local btnAddedCount = 0
    local btnRowList = {}
    for i,v in ipairs(componentsData) do
        -- 预先计算
        local rowCountBeforeAdding = math.ceil(btnAddedCount / btnCountPerRow)
        local countInRowBeforeAdding = btnAddedCount % btnCountPerRow
        local rowCountForAdding = math.ceil((btnAddedCount + 1) / btnCountPerRow)
        local countInRowForAdding = btnAddedCount % btnCountPerRow + 1

        -- 一行里没有位置的时候创建新行
        if (countInRowBeforeAdding == 0) then
            local rowLayout = UI.Layout:create()
            rowLayout:init()
            rowLayout:setSize(0, 97)
            rowLayout:leftUp(0, 97 * rowCountBeforeAdding)
            btnLayout:addChild(rowLayout)
            table.insert(btnRowList, rowLayout)
        end

        -- 添加按钮
        local rowLayoutForAdding = btnRowList[rowCountForAdding]
        if (v.isToDisplayFunc(self, v)) then
            -- 如果要显示按钮就添加进布局
            local contentLayout = v.getLayoutFunc(self, v)
            contentLayout:leftUp(547 * countInRowBeforeAdding, 0)
            rowLayoutForAdding:addChild(contentLayout)

            -- 更新计数器
            btnAddedCount = btnAddedCount + 1
        end
    end


    -- 计算要显示的勾选设置数量
    local checkboxDisplayCount = 0
    for i,v in ipairs(checkBoxData) do
        if (v:isToDisplayFunc()) then
            checkboxDisplayCount = checkboxDisplayCount + 1
        end
    end
    
    local checkboxTotalRowCount = math.ceil(checkboxDisplayCount / 3)

    -- 创建设置区域布局
    local checkBoxLayout = UI.Layout:create()
    checkBoxLayout:init()
    checkBoxLayout:setSize(0, checkboxTotalRowCount * 55)
    checkBoxLayout:leftUp(0, btnLayout._up + btnLayout._height + 5)
    scrollContent:addChild(checkBoxLayout)

    -- 添加行和设置组件
    local checkboxAddedCount = 0
    local rowList = {}
    for i,v in ipairs(checkBoxData) do
        -- 预先计算
        local rowCountBeforeAdding = math.ceil(checkboxAddedCount / 3)
        local countInRowBeforeAdding = checkboxAddedCount % 3
        local rowCountForAdding = math.ceil((checkboxAddedCount + 1) / 3)
        local countInRowForAdding = checkboxAddedCount % 3 + 1

        -- 一行里没有位置的时候创建新行
        if (countInRowBeforeAdding == 0) then
            local rowLayout = UI.Layout:create()
            rowLayout:init()
            rowLayout:setSize(0, 58)
            rowLayout:leftUp(0, 53 * rowCountBeforeAdding)
            checkBoxLayout:addChild(rowLayout)
            -- table.insert(rowList, rowLayout)
            rowList[rowCountForAdding] = rowLayout
            rowLayout.index = rowCountForAdding
        end

        -- 添加按钮
        local rowLayoutForAdding = rowList[rowCountForAdding]
        if (v:isToDisplayFunc()) then
            -- 如果要显示按钮就添加进布局
            local checkBoxWithLabel = self:createCheckBoxWithLabel(
                v.label, 
                function(boxLayout) 
                    if (v.initialStateFunc) then return v.initialStateFunc(v, boxLayout) end
                    return false
                end, 
                function(isChecked, boxLayout)
                    if (v.callback) then v.callback(v, isChecked, boxLayout) end
                end)
            checkBoxWithLabel:leftUp(285 * countInRowBeforeAdding, 0)
            rowLayoutForAdding:addChild(checkBoxWithLabel)

            -- 更新计数器
            checkboxAddedCount = checkboxAddedCount + 1
        end
    end

    -- 整体高度
    local contentLayoutHeight = checkBoxLayout._up + checkBoxLayout._height + 5
    scrollContent:setSize(scrollWidth, contentLayoutHeight)


    -- 底部遮罩
    local bottomMask = UI.Image:create()
    bottomMask:init("ui_setup_mask.png")
    bottomMask:leftBottom(13, 165)
    self:addChild(bottomMask)
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
-- 计算要显示的设置数量
function DisplaySettingsPanel:getShowComponentCount(countPerRow)
    -- 计算要显示的设置数量
    countPerRow = countPerRow or 2
    local displayCount = 0
    for i,v in ipairs(componentsData) do
        if (v:isToDisplayFunc()) then
            displayCount = displayCount + 1
        end
    end
    local totalRowCount = math.ceil(displayCount / countPerRow)
    return displayCount, totalRowCount
end

-- 根据服务器给的渠道，展现给玩家
function DisplaySettingsPanel:splitChannel(channel)
    local copyID = bit.band(channel,4194303)
    local ServerID = bit.rshift(channel,22)

    return string.format("%d.%d", ServerID, copyID)
end

-- 根据输入，返回一个给服务器的渠道
function DisplaySettingsPanel:mergeChannel(text)
    if(text and text ~= "") then
        local numberArr = string.split(text,".")
        if(numberArr and #numberArr == 2 and numberArr[1] ~= "" and numberArr[2] ~= "") then 
            local serverID = checkint(numberArr[1])
            local copyID = checkint(numberArr[2])

            return bit.lshift(serverID,22) + copyID
        else 
            -- 格式有误
            return ""
        end
    else 
        return nil
    end
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------
-- 选择服务器成功
function DisplaySettingsPanel:onSelectServerSuccess(curServerId)
    if self.destroy then
        self:destroy()
    end
    local gameLoginManager = require("app.game.GameLoginManager")
    gameLoginManager:getInstance():setServerId(curServerId)
    gameLoginManager:getInstance():loginOutGame();
end

-- 换线成功
function DisplaySettingsPanel:onChangeTownChannel(data)
    GameErrorManager:showError(data.result)
    UI.WaitingLayer:hideWaiting()
end

function DisplaySettingsPanel:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SELECT_SERVER_SUCCESS,self,self.onSelectServerSuccess)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SETTING_CHANGE_TOWNCHANNEL,self,self.onChangeTownChannel)
end

function DisplaySettingsPanel:unregisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SELECT_SERVER_SUCCESS,self,self.onSelectServerSuccess)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SETTING_CHANGE_TOWNCHANNEL,self,self.onChangeTownChannel)
end
---------------------------------------
-- eo 事件处理 --
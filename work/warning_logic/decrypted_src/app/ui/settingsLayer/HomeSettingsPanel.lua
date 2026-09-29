--[[
    家园设置子页面
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
local HomeSettingsPanel = class("HomeSettingsPanel", UI.SettingPanelBase)
UI.HomeSettingsPanel = HomeSettingsPanel

---------------------------------------
-- eo 模块初始化 --






-- 资源统合 --
---------------------------------------
local COM_RES_LIST = {
    "ui_login.plist",
}
---------------------------------------
-- eo 资源统合 --







-- 数据结构 --
---------------------------------------
 -- 勾选设置数据结构
local componentsData = {
    -- CO-14913 Global屏蔽论坛功能入口
    -- [1] = { -- 论坛
    --     isToDisplayFunc = function(thisData) return CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL or CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT end,
    --     getLayoutFunc = function(self, thisData) 
    --         local content = UI.Layout:create()
    --         content:init()

    --         -- 论坛按钮
    --         local yellowButton = UI.Button:create() 
    --         yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    --         yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    --         yellowButton:setText(LanguageManager:getInstance():getLocalString(1111613)) --"论坛"
    --         yellowButton:leftUp(0, 0)
    --         content:addChild(yellowButton)
    --         yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --             GameManager:openUrl(ServerConfigUtil:getSelfForumUrl())
    --             Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 
    --                 PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_ClickZone)
    --         end)

    --         -- 论坛图标
    --         local icon = UI.Image:create()
    --         icon:init("ui_login_btn_forum_loading.png")
    --         icon:centerLeft(-10)
    --         yellowButton:addChild(icon, 100)

    --         return content
    --     end
    -- },
    [1] = { -- FB
        isToDisplayFunc = function(self, thisData) return CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL or CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT end,
        getLayoutFunc = function(self, thisData) 
            local content = UI.Layout:create()
            content:init()

            -- 论坛按钮
            local yellowButton = UI.Button:create() 
            yellowButton:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
            yellowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
            yellowButton:setText(LanguageManager:getInstance():getLocalString(1111453))
            yellowButton:leftUp(0, 0)
            content:addChild(yellowButton)
            yellowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
                GameManager:openUrl(ServerConfigUtil:getFbForumUrl())
                Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 
                    PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_EnterFB)
            end)

            -- 论坛图标
            local icon = UI.Image:create()
            icon:init("ui_login_btn_facebook_loading.png")
            icon:centerLeft(-10)
            yellowButton:addChild(icon, 100)

            return content
        end
    },
}
---------------------------------------
-- eo 数据结构 --








-- 生命周期 --
---------------------------------------
-- 构造函数
function HomeSettingsPanel:ctor()
    HomeSettingsPanel.super.ctor(
        self, 
        UIType.SETTINGS_COMMUNITY_PANEL,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0)
end

-- 析构函数
function HomeSettingsPanel:dtor(...)
    HomeSettingsPanel.super.dtor(self, ...)
    -- reload_script_file("app.ui.settingsLayer.HomeSettingsPanel")
end

-- 初始化
function HomeSettingsPanel:init(width, height)
	HomeSettingsPanel.super.init(self)
	self:setSize(width, height)
end
-- 表现初始化
function HomeSettingsPanel:onInitView(...)
	HomeSettingsPanel.super.onInitView(self, ...)

    -- 计算要显示的设置数量
    local rowHeight = 85
    local columnDistance = 531
    local countPerRow  = 2
    local displayCount, totalRowCount = self:getShowComponentCount(countPerRow)

    -- 创建设置区域布局
    local checkBoxLayout = UI.Layout:create()
    checkBoxLayout:init()
    checkBoxLayout:setSize(0, totalRowCount * rowHeight)
    checkBoxLayout:leftUp(120, 129)
    self:addChild(checkBoxLayout)

    -- 添加行和设置组件
    local addedCount = 0
    local rowList = {}
    for i,v in ipairs(componentsData) do
        -- 预先计算
        local rowCountBeforeAdding = math.ceil(addedCount / countPerRow)
        local countInRowBeforeAdding = addedCount % countPerRow
        local rowCountForAdding = math.ceil((addedCount + 1) / countPerRow)
        local countInRowForAdding = addedCount % countPerRow + 1

        -- 一行里没有位置的时候创建新行
        if (countInRowBeforeAdding == 0) then
            local rowLayout = UI.Layout:create()
            rowLayout:init()
            rowLayout:setSize(0, rowHeight)
            rowLayout:leftUp(0, rowHeight * rowCountBeforeAdding)
            checkBoxLayout:addChild(rowLayout)
            table.insert(rowList, rowLayout)
        end

        -- 添加按钮
        local rowLayoutForAdding = rowList[rowCountForAdding]
        if (v.isToDisplayFunc(self, v)) then
            -- 如果要显示按钮就添加进布局
            local contentLayout = v.getLayoutFunc(self, v)
            contentLayout:leftUp(columnDistance * countInRowBeforeAdding, 0)
            rowLayoutForAdding:addChild(contentLayout)

            -- 更新计数器
            addedCount = addedCount + 1
        end
    end
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
-- 计算要显示的设置数量
function HomeSettingsPanel:getShowComponentCount(countPerRow)
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
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --
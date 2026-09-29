-- SelectLanguageLayer.lua
-- Author:zp
-- 2017年10月30日
-- Using:选择语言

local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local SdkManager = require"app.game.SdkManager"
local model = require("app.uiExport.languageSetting")
require("app.ui.common.Dialog.ConfirmDialog")
require("app.ui.common.ControlSwitch")
UI = UI or {}

local SelectLanguageLayer = class("SelectLanguageLayer", UI.HWBtnComponent)
UI.SelectLanguageLayer = SelectLanguageLayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()

-- 尺寸

-- 背包资源
local COM_RES_LIST = {
}


-- 构造函数
function SelectLanguageLayer:ctor()
    SelectLanguageLayer.super.ctor(self, UIType.SELECT_LANGUAGE_LAYER, COM_RES_LIST, 483, 290)

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init();
    self:registerListener();
end

-- 析构函数
function SelectLanguageLayer:dtor()
    SelectLanguageLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化
function SelectLanguageLayer:init(logData)
    self._logData = logData
    SelectLanguageLayer.super.init(self)
end


-- 初始化视图
function SelectLanguageLayer:onInitView()

    self:showLucencyLight(self._width, self._height);
    
    self.languageModel = model.create("bg")
    self.rootLayer = self.languageModel.root;
    self.rootLayer:center();
    self:addChild(self.rootLayer)

    local supportLanguages = SdkBox:getInstance():getSupportLanguages()
    -- supportLanguages = {0,1}
    -- dump(supportLanguages)
    table.sort(supportLanguages,function(a,b)
        if a == LanguageManager:getInstance():getLanguage() then
            return true
        end

        if b == LanguageManager:getInstance():getLanguage() then
            return false
        end 
        return a < b
    end)
    
    local scrollViewHeight = 220
    local contentHeight = scrollViewHeight
    local size =  math.ceil(#supportLanguages / 2)
    if size * 80 + 40 > contentHeight then
        contentHeight = size * 80 + 40
    end
    
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(480, contentHeight)

    for i = 1,#supportLanguages do
        local btnLanguage = UI.Button:create()
        if LanguageManager:getInstance():getLanguage() == supportLanguages[i] then
            btnLanguage:init("ui_setup_button_language_1.png",
                "ui_setup_button_language_1.png")
        else
            btnLanguage:init("ui_setup_button_language_0.png",
                "ui_setup_button_language_1.png")
        end
        local cellSize = 2
        local indexX = (i - 1) % cellSize
        local indexY = math.floor((i - 1) / cellSize)

        btnLanguage:leftUp(60 + indexX * 200, 20 + indexY * 80)
        btnLanguage:addEventListener(UIEvent.BUTTON_CLICK, self, self.onSelectLanguage)
        btnLanguage:setTag(supportLanguages[i])
        contentLayout:addChild(btnLanguage)

        local languageImage = UI.Image:create()
        languageImage:init(self:getLanguageNameByLanguageID(supportLanguages[i]))
        languageImage:center()
        btnLanguage:addChild(languageImage,100)

        -- local textLanguage = UI.Text:create()
        -- textLanguage:init(LanguageManager:getInstance():getLocalString(1220000 + supportLanguages[i]), UI.FONT_STANDARD)
        -- textLanguage:setFontSize(18)
        -- textLanguage:setFontColor(UI.FONT_COLOR_50_50_44)
        -- textLanguage:center(0, 0)
        -- btnLanguage:addChild(textLanguage,100)
    end
    
    local languageScrollView = UI.ScrollView:create()
    languageScrollView:setSize(490, scrollViewHeight)
    languageScrollView:init(0, 0, 0, 0)
    languageScrollView:centerUp(50 + 5)
    languageScrollView:addInnerNode(contentLayout)
    languageScrollView:setScrollBarEnabled(true);
    languageScrollView:setScrollBarWidth(4)
    languageScrollView:setCircleVisible(false);
    languageScrollView:setScrollBarPositionFromCornerForVertical(cc.p(35, 0))

    self.rootLayer:addChild(languageScrollView)
end



-- 更新视图
function SelectLanguageLayer:onUpdateView()
end

function SelectLanguageLayer:getLanguageNameByLanguageID(languageID)
    local languageStr = "ui_setup_font_en.png"
    if(languageID == cc.LANGUAGE_ENGLISH) then
        languageStr = "ui_setup_font_en.png"
    elseif(languageID == cc.LANGUAGE_CHINESE) then
        languageStr = "ui_setup_font_cn.png"
    elseif(languageID == cc.LANGUAGE_CHINESE_TRADITIONAL) then
        languageStr = "ui_setup_font_zh-hant.png"
    elseif(languageID == cc.LANGUAGE_KOREAN) then
        languageStr = "ui_setup_font_kr.png"
    elseif(languageID == cc.LANGUAGE_RUSSIAN) then
        languageStr = "ui_setup_font_ru.png"
    elseif(languageID == cc.LANGUAGE_THAI) then
        languageStr = "ui_setup_font_th.png"
    else 
        printError("SelectLanguageLayer:getLanguageNameByLanguageID have language no handle.")
    end

    return languageStr
end

-- 点击回到城镇
function SelectLanguageLayer:onSelectLanguage(obj)
    print(" SelectLanguageLayer:onSelectLanguage  ",obj:getTag())
    
    if obj:getTag() == LanguageManager:getInstance():getLanguage() then
        self:close()
        return
    end
    -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
    --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Lan,
    --     LanguageManager:getInstance():getLanguage(),
    --     obj:getTag()
    -- )

    -- local text = string.format(UI.TEXT_111128, LanguageManager:getInstance():getLocalString(1220000 + obj:getTag()))
    local text = UI.TEXT_111128
    UI.ConfirmDialog.show(text, function()
        UI.WaitingLayer:showWaiting(true, nil, 0)
        Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 
            PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_Language, 
            obj:getTag())
        LanguageManager:getInstance():setLanguage(obj:getTag())
        Avalon.Scheduler:scheduleUpdateOnce(self,function ()
            LANGUAGE_CHANGE = true
            LUA_VIRTUAL_RESTART = true
            SdkBox:getInstance():logout()
         end,0.5)
    end, nil, self)

end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self, tips, touchPosition)
    self:close()
end

-- 注册监听事件(可选)
function SelectLanguageLayer:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
end


-- 注销监听事件(可选)
function SelectLanguageLayer:unRegisterListener()
end



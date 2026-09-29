-- SelectBackEffectLayer.lua
-- Author:llf
-- Using:UI特效选择界面

local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
local SdkManager = require"app.game.SdkManager"
local model = require("app.uiExport.languageSetting")
local GameDataManager = require("app.game.GameDataManager")
require("app.ui.common.Dialog.ConfirmDialog")
require("app.ui.common.ControlSwitch")
UI = UI or {}

local SelectBackEffectLayer = class("SelectBackEffectLayer", UI.HWBtnComponent)
UI.SelectBackEffectLayer = SelectBackEffectLayer

-- private:
local winSize = cc.Director:getInstance():getWinSize()

-- 尺寸

-- 背包资源
local COM_RES_LIST = {
}


-- 构造函数
function SelectBackEffectLayer:ctor(playerDecorateType)
    SelectBackEffectLayer.super.ctor(self, UIType.SELECT_LANGUAGE_LAYER, COM_RES_LIST, 483, 290)

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:init(playerDecorateType);
    self:registerListener();
end

-- 析构函数
function SelectBackEffectLayer:dtor()
    SelectBackEffectLayer.super.dtor(self)
    self:unRegisterListener();
end

-- 初始化
function SelectBackEffectLayer:init(playerDecorateType)
    self._playerDecorateType = playerDecorateType
    SelectBackEffectLayer.super.init(self)
end


-- 初始化视图
function SelectBackEffectLayer:onInitView()

    self:showLucencyLight(self._width, self._height);

    local masterData = RoleDataManager:getMaster()

    if not masterData then
        return
    end

    local equippedDecorate = masterData:getGameUIEquippedDecorates()
    local feDecorate = nil

    for k,v in pairs(equippedDecorate) do 
        if v.type == self._playerDecorateType then
            feDecorate = v
            break
        end
    end
    
    if (self._playerDecorateType == PublicDefine.PlayerDecorateType.PlayerDecorateType_Portal) then
        self.languageModel = model.create("backEffectBg")
        self.effects = {
            [1] = {
                type = 1,
                value = 0,
                des = UI.TEXT_222680
            }, --默认
            --[2] = LanguageManager:getInstance():getLocalString(2222222222), --虎年特效
        }

        local decorates = masterData:getGameUIDecorates()
        -- print(" decorates ===== ")
        -- dump(decorates)
        for k,v in ipairs(decorates) do
            if (v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_Portal and v.value == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger) then
                table.insert(self.effects,{
                    type = v.type,
                    value = v.value,
                    des = UI.TEXT_222681
                })
            elseif (v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_Portal and v.value == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate) then
                table.insert(self.effects,{
                    type = v.type,
                    value = v.value,
                    des = UI.TEXT_222683
                })
            end
        end

    else
        self.languageModel = model.create("rockerShapeBg")
        self.effects = {
            [1] = {
                type = 2,
                value = 0,
                des = UI.TEXT_222680
            }, --默认
            --[2] = LanguageManager:getInstance():getLocalString(2222222222), --虎年特效
        }

        local decorates = masterData:getGameUIDecorates()
        for k,v in ipairs(decorates) do
            if (v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI and v.value == PublicDefine.UseUIDecorateValue.DecorateValue_Tiger) then
                table.insert(self.effects,{
                    type = v.type,
                    value = v.value,
                    des = UI.TEXT_222682
                })
            elseif (v.type == PublicDefine.PlayerDecorateType.PlayerDecorateType_UI and v.value == PublicDefine.UseUIDecorateValue.DecorateValue_Pirate) then
                table.insert(self.effects,{
                    type = v.type,
                    value = v.value,
                    des = UI.TEXT_222684
                })
            end
        end
    end
    self.rootLayer = self.languageModel.root;
    self.rootLayer:center();
    self:addChild(self.rootLayer)

    
    local scrollViewHeight = 220
    local contentHeight = scrollViewHeight
    local size =  math.ceil(#self.effects / 2)
    if size * 80 + 40 > contentHeight then
        contentHeight = size * 80 + 40
    end
    
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(480, contentHeight)

    for i = 1,#self.effects do
        local backButton = UI.Button:create()
        if (not feDecorate and i == 1) or (feDecorate and feDecorate.type == self.effects[i].type and feDecorate.value == self.effects[i].value) then
            backButton:init("ui_setup_button_language_1.png",
                "ui_setup_button_language_1.png")
        else
            backButton:init("ui_setup_button_language_0.png",
                "ui_setup_button_language_1.png")
        end
        local cellSize = 2
        local indexX = (i - 1) % cellSize
        local indexY = math.floor((i - 1) / cellSize)

        backButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        backButton:setText(self.effects[i].des)
        backButton:leftUp(60 + indexX * 200, 20 + indexY * 80)
        backButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            Net.NetRoleSystem:reqEquipPlayerDecorateMessage(self.effects[i].type, self.effects[i].value)
            self:close()
        end)
        contentLayout:addChild(backButton)
    end
    
    local scrollView = UI.ScrollView:create()
    scrollView:setSize(490, scrollViewHeight)
    scrollView:init(0, 0, 0, 0)
    scrollView:centerUp(50 + 5)
    scrollView:addInnerNode(contentLayout)
    scrollView:setScrollBarEnabled(true);
    scrollView:setScrollBarWidth(4)
    scrollView:setCircleVisible(false);
    scrollView:setScrollBarPositionFromCornerForVertical(cc.p(35, 0))

    self.rootLayer:addChild(scrollView)
end



-- 更新视图
function SelectBackEffectLayer:onUpdateView()
end

-- -- 点击回到城镇
-- function SelectBackEffectLayer:onSelectLanguage(obj)
--     print(" SelectBackEffectLayer:onSelectLanguage  ",obj:getTag())
    
--     if obj:getTag() == LanguageManager:getInstance():getLanguage() then
--         self:close()
--         return
--     end
--     -- SdkManager:getInstance():sendWebLog(PublicDefine.WebLogType.WebLogType_ConfigChange,0,
--     --     PublicDefine.WebLogConfigChangeType.WebLogConfigChangeType_Lan,
--     --     LanguageManager:getInstance():getLanguage(),
--     --     obj:getTag()
--     -- )

--     -- local text = string.format(UI.TEXT_111128, LanguageManager:getInstance():getLocalString(1220000 + obj:getTag()))
--     local text = UI.TEXT_111128
--     UI.ConfirmDialog.show(text, function()
--         UI.WaitingLayer:showWaiting(true, nil, 0)
--         Avalon.AWSLogUtil:sendAWSClickInfo(PublicDefine.WebLogS3Type.WebLogS3Type_Setting, 
--             PublicDefine.WebLogS3Type_Setting_Type.WebLogS3Type_Setting_Type_Language, 
--             obj:getTag())
--         LanguageManager:getInstance():setLanguage(obj:getTag())
--         Avalon.Scheduler:scheduleUpdateOnce(self,function ()
--             LANGUAGE_CHANGE = true
--             LUA_VIRTUAL_RESTART = true
--             SdkBox:getInstance():logout()
--          end,0.5)
--     end, nil, self)

-- end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self, tips, touchPosition)
    self:close()
end

-- 注册监听事件(可选)
function SelectBackEffectLayer:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
end


-- 注销监听事件(可选)
function SelectBackEffectLayer:unRegisterListener()
end



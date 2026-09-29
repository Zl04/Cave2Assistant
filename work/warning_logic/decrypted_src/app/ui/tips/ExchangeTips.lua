--[[
    AUTHOR:odei
    2017-11-21
    USING: 兑换码
]]

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
require("app.utils.ServerConfigUtil")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
UI = UI or {}
local layerSize = cc.size(430, 290)
local ExchangeTips = class("ExchangeTips",UI.HWBtnComponent)
UI.ExchangeTips = ExchangeTips
--  ui_tips_team
local VOTE_SUCCEED_TIPS_PLIST = {
}

--  点击确定按钮 
function ExchangeTips:onConfirmButton()
    
    local text = self.libIDEdit:getText()
    print("onConfirmHandler",text)
    if(text == nil or text == "") then
        UI.ScrollBar:createByText(UI.TEXT_1150012)
        return
    end

    local sdkbox = SdkBox:getInstance()
    local tableData = {}
    tableData.zone = checkint(ServerConfigUtil:getZoneId())
    tableData.channel = sdkbox:getVersionChannel()
    -- tableData.channel = 1
    tableData.pk = RoleDataManager:getMasterPK()
    -- tableData.pk = 12345
    tableData.account = sdkbox:getVersionAccount()
    tableData.code = text
    tableData.idfa = AvalonUtil.getIDFA()
    tableData.uuid = AvalonUtil.getOpenUUID()
    tableData.imei = AvalonUtil.getIMEI()   
    tableData.adid = AvalonUtil.getADID()
    tableData.mac = AvalonUtil.getMAC()


    -- tableData.zone = 2
    -- tableData.channel = 4
    -- tableData.pk = 400
    -- tableData.code = text

    Net.Helper:sendHttpMessage(Net.HttpSubDirection.Verification,tableData,function(response)
        print("onConfirmButton,callfuncSuccess")


        if (not response or response == "") then response = "error" end
        local resJson = json.decode(response)
        if (type(resJson) == "table") then
            if (resJson.success) then
                if not tolua.isnull(self) then
                    self:close()    --调用父类方法。关闭此弹窗。
                end
                UI.ScrollBar:createByText(UI.TEXT_1150009)
                Avalon.MessageCenter:notice(GameMessage.MC_TASK_CLOSE_MAILLAYER)
            else
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(resJson.error))
            end
        else
            UI.ScrollBar:createByText(UI.TEXT_1150010)
        end
    end,function(readyState,status)
        print("onConfirmButton,callfuncFail",readyState,status)
        if readyState ~= 4 or status == 502 or status == 404 then 
            UI.ScrollBar:createByText(UI.TEXT_1150008)
            if not tolua.isnull(self) and self.libIDEdit then
                self.libIDEdit:setText("")
            end
        else
            UI.ScrollBar:createByText(UI.TEXT_1150010)
        end
    end)
end

--  点击取消按钮
local function onCancleButton(self)
    print("onCancelHandler")
    self:close()    --调用父类方法。关闭此弹窗。
end



--  构造函数
function ExchangeTips:ctor()
    ExchangeTips.super.ctor(self,UIType.EXCHANGE_TIPS,VOTE_SUCCEED_TIPS_PLIST, layerSize.width, layerSize.height)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
    self.libIDEdit = nil
end

--  析构函数 调用父类的方法
function ExchangeTips:dtor()
    self.libIDEdit = nil
    ExchangeTips.super.dtor(self)
end

--  初始化函数
function ExchangeTips:init()
    ExchangeTips.super.init(self)
    self:registerListener()
end

--  初始化界面函数
function ExchangeTips:onInitView()
    self:setTouchEnable(true)
    self:setInterceptTouches(true);
    self:setSwallowTouches(true);
    local colorLayer = cc.LayerColor:create(cc.c4b(0,0,0,125))
    colorLayer:setAnchorPoint(cc.p(0.5,0.5))
    colorLayer:setPosition(self._hw-UI.size.width/2,self._hh - UI.size.height/2)
    colorLayer:setContentSize(UI.size.width,UI.size.height)
    self:addChild(colorLayer,-1)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box2.png")
    bg:setCapInsets(CCRectMake(190,96,5,5))
    bg:setContentSize(layerSize.width, layerSize.height)
    bg:setAnchorPoint(cc.p(0.5, 0.5))
    bg:setPosition(cc.p(layerSize.width / 2, layerSize.height / 2))
    self:addChild(bg)
    
    local titleText = UI.Text:create() 
    titleText:init(UI.TEXT_1150001,UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    self.titleText_Normal = titleText
    titleText:centerUp(25)
    bg:addChild(titleText)
    -- titleText:enableDebugDraw()

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light2.png")
    line:setContentSize(375, 2)
    line:setAnchorPoint(cc.p(0, 0.5))
    line:setPosition(cc.p(24, 217))
    bg:addChild(line)

    local titleText = UI.Text:create() 
    titleText:init(UI.TEXT_1150012,UI.FONT_STANDARD,UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(90)
    bg:addChild(titleText)

  -- 输入验证码
    local bindCodeEdit = UI.EditBox:create(320, 61)
    bindCodeEdit:init("", cc.EDITBOX_INPUT_MODE_SINGLELINE, "ui_activity_banner_mailbox.png", 21, 14)
    bindCodeEdit:leftUp(self:getContentSize().width / 2 - 164, 130)
    bg:addChild(bindCodeEdit)
    bindCodeEdit:setFontSize(20)
    bindCodeEdit:setFontColor(UI.FONT_COLOR_155_155_155)
    bindCodeEdit:setPlaceholderFontSize(20)
    bindCodeEdit:setPlaceholderFontColor(UI.FONT_COLOR_155_155_155)
    self.libIDEdit = bindCodeEdit


    local confirmButton = UI.Button:create()
    confirmButton:init("ui_btn_yellow4_0.png","ui_btn_yellow4_1.png","ui_btn_yellow4_2.png")
    confirmButton:centerBottom(30)
    confirmButton:setDelay(0.2, handler(self,self.onConfirmButton))
    bg:addChild(confirmButton)
    self._confirmButton = confirmButton

    local text  = UI.Text:create()
    text:init(UI.TEXT_1150011, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    text:center()
    text:setName("text")
    confirmButton:addChild(text,100)
end


-- 更新视图
function ExchangeTips:onUpdateView()

end

-- 注册监听事件(可选)
function ExchangeTips:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end

function ExchangeTips:onTouchDialogOutsizeHandler()
    -- print("-----------MailLayer:onTouchDialogOutsizeHandler()")
    self:close()
end


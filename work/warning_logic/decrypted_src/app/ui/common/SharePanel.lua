-- SharePanel.lua
-- Author:ydli
-- 2017年11月27日
-- Using:分享按钮 分享按钮总开关 和各个子分享按钮
UI = UI or {}
local SHARE_MODULE = PublicDefine.SHARE_MODULE
local SharePanel = class("SharePanel", UI.HWBtnComponent)
UI.SharePanel = SharePanel
local RES_LIST = {
    "ui_general_share.plist"
}

local SdkBox = require("utils.sdkbox.SdkBox")

local winSize = cc.Director:getInstance():getWinSize()
local layoutSize = cc.size(winSize.width, 100)

-- 构造函数
function SharePanel:ctor(callback, shareType, haveButton)
    SharePanel.super.ctor(self, 0, RES_LIST, layoutSize.width, layoutSize.height)
    self.shareBtns = {}
    self.isOpenBtn = false
    self.run = false

    self:init(callback, shareType, haveButton)

    -- 展开分享按钮
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_BAG_PANEL_OPEN_SHARE, self, self.openShareBtn)
end

-- 析构函数
function SharePanel:dtor()
    SharePanel.super.dtor(self)
    self.shareBtns = {}
    self.isOpenBtn = false
    self.run = false
    self.callback = nil
    -- 展开分享按钮
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_BAG_PANEL_OPEN_SHARE, self, self.openShareBtn)
end

-- public:
-- 初始化
function SharePanel:init(callback, shareType, haveButton)
    SharePanel.super.init(self, callback, shareType, haveButton)
end


function SharePanel:openShareBtn()
    if self.shareButton then
        self.shareButton:onActive()
        self:switchShareBtn()
    end
end

-- 初始化视图
function SharePanel:onInitView(callback, shareType, haveButton)
    if(CONFIG_SHARE == false) then 
        return
    end
    local shareButton = nil
    self.haveButton = haveButton or false
    local btnList = SdkBox:getInstance():getSupportShareSdks()
    if self.haveButton and #btnList > 0 then
        -- 创建关闭按钮
        shareButton = UI.SpineTabItem:create()
        shareButton:init(
            "effect_ui_package_skill_share_bg", 
            "effect_ui_package_skill_share_icon",
            nil,
            nil
        )
        shareButton:setSize(120, 53)
        shareButton:setSingle(true)
        shareButton:addEventListener(UIEvent.TAB_CLICK, self, function(self)
            -- UI.UIManager:removeComponent(self)
            print("utton:addEventListener(UIEvent.TAB_CLICK", self.run, self.bOpen)
            if self.run == false then
                if(self.bOpen) then 
                    print("utton:addEventListener(UIEvent.TAB_CLICK  onDisable")
                    shareButton:onDisable()
                else 
                    print("utton:addEventListener(UIEvent.TAB_CLICK  onActive")
                    shareButton:onActive()
                end
                self:switchShareBtn()
            end
        end)
        self:addChild(shareButton)
        shareButton:centerRight(8)
        shareButton:onActive()
        self.shareButton = shareButton
    end
    self:refreshParams(callback, shareType, haveButton)
end

function SharePanel:switchShareBtn()
    if self.run then
        return
    end
    local startOffsetX = 10
    local startX = 100
    local oneWidth = 70
    if self.haveButton then
        startOffsetX = 220
    end
    self.run = true
    if self.bOpen then
        for k, btn in ipairs(self.shareBtns) do
            btn:runAction(cc.Sequence:create(cc.EaseBackOut:create(cc.MoveTo:create(0.15, cc.p(layoutSize.width - startX, btn:getPositionY()))), cc.CallFunc:create(function()
                    btn:hide()
                    self.run = false
                end)))
        end
    else
        for k, btn in ipairs(self.shareBtns) do
            btn:show()
            btn:runAction(cc.Sequence:create(cc.EaseBackOut:create(cc.MoveTo:create(0.15, cc.p(layoutSize.width - startOffsetX - oneWidth * (k - 1), btn:getPositionY()))), cc.CallFunc:create(function()
                    self.run = false
                end)))
        end    
    end
    self.bOpen = not self.bOpen
end

function SharePanel:onShareClick(platform)
    if self.callback ~= nil then
        self.callback(platform) -- 参数回传
    end
end

function SharePanel:setAllBtnVisible(visible)
    if(self.shareBtns) then 
        for k, btn in ipairs(self.shareBtns) do
            btn:setVisible(visible)
        end
    end
end

function SharePanel:refreshParams(callback, shareType, haveButton)
    shareType = checkint(shareType)
    if self.shareType == shareType and not tolua.isnull(self.callback) then
        return
    end
    self.shareType = shareType
    self.haveButton = haveButton 
    self.callback = callback
    self.run = false
    self.bOpen = false
    self.haveButton = haveButton
    for k, v in ipairs(self.shareBtns) do
        v:removeFromParent(true)
    end 
    self.shareBtns = {}
    local btnList = SdkBox:getInstance():getSupportShareSdks()
    -- local deviceName = AvalonUtil.getDeviceName()
    -- if self.shareType == SHARE_MODULE.SHARE_MODULE_SKILL 
    -- or self.shareType == SHARE_MODULE.SHARE_MODULE_BATTLE_RESULT 
    -- or self.shareType == SHARE_MODULE.SHARE_MODULE_PLAYER_LOG 
    -- then
    --     if deviceName == "iPhone10,3" or deviceName == "iPhone10,6" then
    --         for i,v in ipairs(btnList) do
    --             if v == PublicDefine.SHARE_CHANNEL.SHARE_CHANNEL_TWITTER then
    --                 table.remove( btnList, i )
    --                 break;
    --             end
    --         end
    --     end
    -- end

    for i, platform in ipairs( btnList ) do
        local btnImage = ShareUtil:getImageNameByType(platform)
        local shareBtn = UI.Button:create() 
        shareBtn:init(btnImage,btnImage)

        table.insert(self.shareBtns,shareBtn)
        shareBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
            self:onShareClick(platform)
        end)
    end
    for k, btn in ipairs(self.shareBtns) do
        btn:centerRight(30)
        btn:hide()
        self:addChild(btn)
    end
    if #self.shareBtns == 0 then
        -- entranceBtn:hide()
        if(shareButton) then 
            shareButton:setVisible(false)
        end
    else
        if self.haveButton == false then
            self:switchShareBtn()
        end
    end
end
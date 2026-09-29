-- CreateGuildSuccessTips.lua
-- Author:zp
-- 2017年9月20日
-- Using:创建公会成功界面

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SdkBox = require("utils.sdkbox.SdkBox")
UI = UI or {}

local CreateGuildSuccessTips = class("CreateGuildSuccessTips",UI.HWBtnComponent)
UI.CreateGuildSuccessTips = CreateGuildSuccessTips
--  ui_tips_team
local VOTE_SUCCEED_TIPS_PLIST = {
    "ui_town_guild_icon.plist",
    "ui_town_guild_general.plist",
    "ui_general_share.plist",
}
local SHARE_MODULE = PublicDefine.SHARE_MODULE

local winSize = cc.Director:getInstance():getWinSize()

local function onOkHandler(self)
    -- 处理点击OK处理
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_ALL_CREATE_OR_JOIN_GUILD)
    self:close()
end


--  构造函数
function CreateGuildSuccessTips:ctor()
    CreateGuildSuccessTips.super.ctor(self,UIType.CREATE_GUILD_SUCCESS_TIPS,VOTE_SUCCEED_TIPS_PLIST,496,361)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
end

--  析构函数 调用父类的方法
function CreateGuildSuccessTips:dtor()
    CreateGuildSuccessTips.super.dtor(self)
end

--  初始化函数
function CreateGuildSuccessTips:init(data)
    self.data = data
    CreateGuildSuccessTips.super.init(self)
end

--  初始化界面函数
function CreateGuildSuccessTips:onInitView()
    self:setTouchEnable(true)
    self:setInterceptTouches(true)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local bg = UI.Image:create()
    self._bg = bg
    bg:init("ui_setup_banner_box2.png")
    bg:center()
    self:addChild(bg)
    self:setSize(bg._width,bg._height)

    local iconBg = UI.Image:create()
    -- icon:init("ui_guild_icon_guilgicon6.png")
    iconBg:init("ui_guild_headframe_big.png")
    iconBg:centerUp(32)
    bg:addChild(iconBg)
    
    -- 公会图标
    local icon = UI.Image:create()
    -- icon:init("ui_guild_icon_guilgicon6.png")
    icon:init(GameDataManager:getInstance():getGuildIconForIconID(self.data.iconID))
    icon:center()
    iconBg:addChild(icon)

    local name = UI.Text:create() 
    name:init(self.data.name, UI.FONT_ARIAL, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    name:centerUp(156 - name:getContentSize().height /2)
    bg:addChild(name)

    -- 描述语言
    local desBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_setup_banner_box_up.png", cc.rect(0,0,1,1))
    desBg:setContentSize(cc.size(434, 72))  
    desBg:setPosition(cc.p(52 + 434/2, 113 + 36))
    bg:addChild(desBg)

    local desc = UI.Text:create() 
    desc:init(LanguageManager:getInstance():getLocalString(1110583),UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    desc:setSize(410,70)
    desc:setTextCenter()
    desc:center()
    desBg:addChild(desc)

    -- 按钮
    local button = UI.Button:create()
    button:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onOkHandler)
    button:centerBottom(38)
    bg:addChild(button)

    local desc = UI.Text:create() 
    desc:init(LanguageManager:getInstance():getLocalString(1110584), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    desc:center()
    button:addChild(desc,10)
    ---------------------分享相关-------------------------
  
    --分享布局
    local sharePanel = UI.SharePanel:create(function(platform)
        local shareDatas = ConfigManager:getShareConfigByType(SHARE_MODULE.SHARE_MODULE_CREATE_GUILD,platform)
        if shareDatas == nil then
            printWarn("----!!!! error !!!! guild create success shareDatas is nnil")
            return
        end
            SdkBox:getInstance():share({
                channel = platform,
                link = shareDatas.url,
                content =  LanguageManager:getInstance():getLocalString(shareDatas.content[math.random(1,table.nums(shareDatas.content))]),
                type = PublicDefine.SHARE_CONTENT_TYPE.TEXT,
                -- stype = Avalon.WXScene.WXSceneTimeline
                title = LanguageManager:getInstance():getLocalString(shareDatas.title[math.random(1,table.nums(shareDatas.title))]),
                thumb = AvalonUtil.getShareThumbPath(shareDatas),
                image = "",
            })
    end, SHARE_MODULE.SHARE_MODULE_CREATE_GUILD, false)
    -- sharePanel:rightBottom(10,10)
    sharePanel:rightBottom(-winSize.width/2 + self:getContentSize().width/2 + 90, -winSize.height/2 + self:getContentSize().height/2 + 10)
    self:addChild(sharePanel,1000)
end

-- 传递回调函数名字
function CreateGuildSuccessTips:callfunName(okCallFun)  
    
end

-- 更新视图
function CreateGuildSuccessTips:onUpdateView()

end
-- GuildMemberCell.lua
-- Author:zp
-- 2017年9月19日
-- Using:公会列表 cell

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local GameInManorManager = require "app.game.GameInManorManager"

local GuildTitle = PublicDefine.GuildTitle
local winSize = cc.Director:getInstance():getWinSize()
UI = UI or {}
local GuildMemberCell = class("GuildMemberCell", UI.HWBtnComponent)
UI.GuildMemberCell = GuildMemberCell

local CHANGE_TITLE_TIME = 5
local titleTxt = {UI.TEXT_1213862, UI.TEXT_1213863, UI.TEXT_1213864, UI.TEXT_1213865}

local COM_RES_LIST = {
    --  
    "ui_town_guild_management.plist",
    "ui_common_information.plist",
    "ui_common_scale9image.plist",
    "ui_town_manor.plist",
}

function GuildMemberCell:ctor(data, idx, type, tableView)
    GuildMemberCell.super.ctor(
        self,UIType.GUILD_MEMBER_CELL,
        COM_RES_LIST,
        0,
        0
    )

    self.type = type
    if(type == UI.GUILD_MANGER_TYPE.MANAGER) then 
        self.width = 840
        self.height = 88
    else 
        self.width = 551
        self.height = 88
    end

    self._icon = nil
    self._userNameLabel = nil
    self._lvLabel = nil

    self.rootLayer = nil;           --root节点
    self.data = data;
    self.idx =idx
    self._tableView = tableView
    self:init();
end


local STATUS_LABEL = 65

-- public:
-- 初始化
function GuildMemberCell:init()
    GuildMemberCell.super.init(self)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_TICK_MEMBER_FAILS, self, self.tickMemberFails)
end

function GuildMemberCell:dtor()
    GuildMemberCell.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_TICK_MEMBER_FAILS, self, self.tickMemberFails)
end

-- 踢出成员失败的处理逻辑
function GuildMemberCell:tickMemberFails(targPK)
    if(self.data and self.data.PK == targPK) then
        self:reload(self.data, self.idx, self.type)
    end
end

-- 模版函数：初始化组建的视图
function GuildMemberCell:onInitView()
    local bg = UI.Layout:create()
    bg:init()
    bg:setSize(self.width, self.height)
    bg:center()
    self.bg = bg
    self:addChild(bg)
    -- bg:enableDebugDraw()

    -- 头像
    local iconButton = UI.Button:create()
    iconButton:init("ui_information_headframe_bottom.png", "ui_information_headframe_bottom.png")
    iconButton:centerLeft(12)
    iconButton:setTouchClipNode(self._tableView)
    iconButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if(RoleDataManager:getMasterPK() ~= self.data.PK ) then
            local data = {}
            data.PK = self.data.PK 
            data.loginStatus = self.data.loginStatus
            data.userID = self.data.userID
            local pos = iconButton:convertToWorldSpace(cc.p(0, 0))
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_HERO_HEAD_TIPS, data,  pos.x + iconButton:getContentSize().width +20, pos.y+ 150)
        else
            UI.ScrollBar:createByText(UI.TEXT_1110720)
        end
    end)

    bg:addChild(iconButton)
    self._iconButton = iconButton

    -- 添加蒙版效果
    local circleImage = UI.Image:create()
    circleImage:init("ui_information_headframe_box.png")
    circleImage:center()
    iconButton:addChild(circleImage, 3)
    self.circleImage = circleImage

    -- 角色等级
    -- 等级背景图  
    self._grade_BG = UI.Image:create()
    self._grade_BG:init("ui_information_headframe_grade.png")
    self._grade_BG:leftBottom(-10,-4)
    iconButton:addChild(self._grade_BG, 100) 

    
    -- 等级
    local roleLevel = RoleDataManager:getUIShowLvByOtherData(self.data.lv, self.data.reincarnationLevel)
    self._lvLabel = UI.Text:create()
    self._lvLabel:init(roleLevel.."",UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_189_167_136)
    self._lvLabel:setSize(100, 50)
    self._lvLabel:center()
    self._lvLabel:setTextCenter()
    self._grade_BG:addChild(self._lvLabel,101)

    -- 角色职业
    if self.data.weaponType ~= 0 then
        self._equipmentType = UI.Image:create()
        self._equipmentType:init(string.format("icon-equip_small1_21080010_%d.png",self.data.weaponType))
        self._equipmentType:rightUp(-2, -2)
        self._equipmentType:useShader(UI.COMPONENT_NORMAL_SHADER)
        iconButton:addChild(self._equipmentType, 100)
    else
        if self._equipmentType then
            self._equipmentType:removeFromParent()
        end
    end

    -- 公会名字
    local guildNameLabel = UI.Text:create()
    guildNameLabel:init(self:getNickName(), UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    guildNameLabel:leftBottom(94,48)
    guildNameLabel:setSize(181,0)
    guildNameLabel:setTextLeft()
    -- guildNameLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    bg:addChild(guildNameLabel, 10)
    self._userNameLabel = guildNameLabel

    -- 分割线
    local nameLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png", cc.rect(0,0,1,1))
    nameLine:setContentSize(cc.size(156, 1))  
    nameLine:setPosition(cc.p(105 + nameLine:getContentSize().width/2, bg:getContentSize().height/2))
    bg:addChild(nameLine,10)
    self._nameLine = nameLine

    -- 职位
    local titleLabel = UI.Text:create()
    titleLabel:init("", UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleLabel:leftBottom(94,20)
    -- titleLabel:setSize(181,0)
    titleLabel:setTextLeft()
    -- guildNameLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    bg:addChild(titleLabel, 10)
    self._titleNameLabel = titleLabel

    -- 登录情况 (放到职位后面)
    local loginLabel = UI.Text:create()
    loginLabel:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    loginLabel:leftBottom(150,20)
    loginLabel:setTextLeft()
    bg:addChild(loginLabel, 10)
    self._loginLabel = loginLabel


    -- 本周贡献图标
    local contributionImage  = UI.Image:create()
    contributionImage:init("symbol_guild_tech_icon_medal.png")
    contributionImage:centerLeft(358)
    bg:addChild(contributionImage, 10) 
    self._contributionImage = contributionImage

    -- 本周贡献值
    local contributionLabel = UI.NumberText:create(""..self.data.contib, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    contributionLabel:leftBottom(337, 48)
    contributionLabel:setTextHorizontalCenter()
    contributionLabel:setSize(0, 0)
    bg:addChild(contributionLabel, 10)
    self._contributionLabel = contributionLabel

    -- 贡献值分割线
    local contributionLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_50%black.png", cc.rect(0,0,1,1))
    contributionLine:setContentSize(cc.size(72, 1))  
    contributionLine:setPosition(cc.p(350 + contributionLine:getContentSize().width/2, bg:getContentSize().height/2))
    bg:addChild(contributionLine,10)
    self._contributionLine = contributionLine

    -- 总共贡献值
    local totalContribLabel = UI.NumberText:create(""..self.data.totalContrib, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    totalContribLabel:leftBottom(337, 20)
    totalContribLabel:setTextHorizontalCenter()
    totalContribLabel:setSize(0, 0)
    bg:addChild(totalContribLabel, 10)
    self._totalContribLabel = totalContribLabel

    -- 登录状况排版 (现在变成行商了)
    local loginStatusLayout = UI.Layout:create()
    loginStatusLayout:init()
    loginStatusLayout:enableAutoHeight()
    loginStatusLayout:enableAutoWidth()
    loginStatusLayout:center(214, 0)
    bg:addChild(loginStatusLayout)
    self._loginStatusLayout = loginStatusLayout


    --行商模块
    local peddlerBg = UI.Image:create()
    peddlerBg:init("ui_manor_peddler_bg_1.png")
    peddlerBg:center()
    loginStatusLayout:addComponent(peddlerBg)
    self._peddlerBg = peddlerBg

    -- local peddlerGoodsIcon = UI.Image:create()
    -- peddlerGoodsIcon:init("ui_manor_peddler_idle.png")
    -- peddlerGoodsIcon:center(-40)
    -- peddlerBg:addChild(peddlerGoodsIcon)
    -- self._peddlerGoodsIcon = peddlerGoodsIcon

    -- local currencyIcon = UI.Image:create()
    -- currencyIcon:init("ui_manor_peddler_idle.png")
    -- currencyIcon:center()
    -- peddlerBg:addChild(currencyIcon)
    -- self._currencyIcon = currencyIcon

    local currencyNumberText = UI.Text:create()
    currencyNumberText:init(AvalonUtil:getSimpleNumber(0, 4), UI.FONT_ARIAL, 16, {r=41,g=41,b=45})
    currencyNumberText:centerLeft(78.5 + 10)
    peddlerBg:addChild(currencyNumberText)
    self._currencyNumberText = currencyNumberText





    -- 罢免会长操作
    local overthrowButton = UI.Button:create()
    overthrowButton:init("ui_btn_chat_0.png", "ui_btn_chat_1.png", "ui_btn_chat_2.png")
    overthrowButton:setText(LanguageManager:getInstance():getLocalString(1111690))
    overthrowButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    overthrowButton:setVisible(false)
    overthrowButton:setInterval(1)
    overthrowButton:floatUp(0)
    loginStatusLayout:addComponent(overthrowButton, 12)
    overthrowButton:setTouchEnable(true)
    overthrowButton:setTouchClipNode(self._tableView)
    overthrowButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- 检查是否还能参与罢免
        local guildData = MasterDataManager:getGuildData()
        if (not guildData:isAbleToOverthrow()) then 
            UI.ScrollBar:createByTextID(1111692) -- 本次罢免行动已过期
            return
        end

        -- 询问是否参与竞选
        require "app.ui.tips.TipsLayer"
        UI.TipsLayer:onOverthrowLeader(function()
            Net.NetGuildSystem:reqOverthrowMaster(true)
        end, function()
            Net.NetGuildSystem:reqOverthrowMaster(false)
        end)
    end)
    self._overthrowButton = overthrowButton

    local btnLayout = UI.Layout:create()
    btnLayout:init()
    btnLayout:setSize(300, self.height)
    btnLayout:centerLeft(660)
    bg:addChild(btnLayout,10)

    -- 职位调整
    local titleUpButton = UI.Button:create()
    titleUpButton:init("ui_guild_mamagement_up_0.png", "ui_guild_mamagement_up_1.png", "ui_guild_mamagement_up_0.png")
    titleUpButton:floatLeft(50)
    btnLayout:addComponent(titleUpButton,10)
    titleUpButton:setTouchEnable(true)
    titleUpButton:setTouchClipNode(self._tableView)
    titleUpButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        -- 升等级
        local titleTimeServer = MasterDataManager:getChangeTitleTime()
        if(titleTimeServer + CHANGE_TITLE_TIME < GameManager:getNowServerTime()) then
            local targetTitle = nil
            if (self.data.title == GuildTitle.GuildTitle_Member) then
                targetTitle = GuildTitle.GuildTitle_CoLeader
            elseif (self.data.title == GuildTitle.GuildTitle_CoLeader) then
                targetTitle = GuildTitle.GuildTitle_ViceLeader
            elseif (self.data.title == GuildTitle.GuildTitle_ViceLeader) then
                targetTitle = GuildTitle.GuildTitle_Leader
            end

            -- 调整职级的人数检查
            local guildData = MasterDataManager:getGuildData()
            local ret, maxNum = guildData:checkCanChangeTitle(true, self.data.title)
            if not ret and maxNum > 0 then
                if targetTitle then
                    UI.ScrollBar:createByText(string.format(UI.TEXT_1213867, titleTxt[targetTitle], maxNum))
                end
                return
            end

            MasterDataManager:setChangeTitleTimeNow()

            local master = RoleDataManager:getMaster()
            if (self.data.title == GuildTitle.GuildTitle_Member) then
                Net.NetGuildSystem:modifyMemberTitle(master:getPK(), self.data.PK, GuildTitle.GuildTitle_CoLeader)
            elseif (self.data.title == GuildTitle.GuildTitle_CoLeader) then
                Net.NetGuildSystem:modifyMemberTitle(master:getPK(), self.data.PK, GuildTitle.GuildTitle_ViceLeader)
            elseif (self.data.title == GuildTitle.GuildTitle_ViceLeader) then
                -- 提示是否要把会长职务转让
                local tip = UI.TipsLayer:onShowCommonTextHandler(string.format(LanguageManager:getInstance():getLocalString(1110614),self.data.name), function()
                    if not tolua.isnull(self) then
                        MasterDataManager:setRepeatHandleData(RepeatHandleType.GUILD_LEADER_TILE_TRANSFER, true)
                        Net.NetGuildSystem:modifyMemberTitle(master:getPK(), self.data.PK, GuildTitle.GuildTitle_Leader)
                    end
                end, function()

                end)
                tip:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
            end
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110613))
        end
    end)
    self._titleUpButton = titleUpButton

    local titleReduceButton = UI.Button:create()
    titleReduceButton:init("ui_guild_mamagement_down_0.png", "ui_guild_mamagement_down_1.png", "ui_guild_mamagement_down_0.png")
    titleReduceButton:floatLeft(6)
    btnLayout:addComponent(titleReduceButton, 10)
    titleReduceButton:setTouchEnable(true)
    titleReduceButton:setTouchClipNode(self._tableView)
    titleReduceButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        -- 降等级
        local titleTimeServer = MasterDataManager:getChangeTitleTime()
        if(titleTimeServer + CHANGE_TITLE_TIME < GameManager:getNowServerTime()) then
            local targetTitle = nil
            if (self.data.title == GuildTitle.GuildTitle_CoLeader) then
                targetTitle = GuildTitle.GuildTitle_Member
            elseif (self.data.title == GuildTitle.GuildTitle_ViceLeader) then
                targetTitle = GuildTitle.GuildTitle_CoLeader
            end

            -- 调整职级的人数检查
            local guildData = MasterDataManager:getGuildData()
            local ret, maxNum = guildData:checkCanChangeTitle(false, self.data.title)
            if not ret and maxNum > 0 then
                if targetTitle then
                    UI.ScrollBar:createByText(UI.TEXT_1213867, titleTxt[targetTitle], maxNum)
                end
                return
            end

            MasterDataManager:setChangeTitleTimeNow()

            if (targetTitle) then
                local master = RoleDataManager:getMaster()
                Net.NetGuildSystem:modifyMemberTitle(master:getPK(), self.data.PK, targetTitle)
            end
        else
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110613))
        end
    end)
    self._titleReduceButton = titleReduceButton
    
    -- 踢人操作
    local statusButton = UI.Button:create()
    statusButton:init("ui_guild_mamagement_remove_0.png", "ui_guild_mamagement_remove_1.png", "ui_guild_mamagement_remove_0.png")
    statusButton:floatLeft(13)
    btnLayout:addComponent(statusButton, 12)
    statusButton:setTouchEnable(true)
    statusButton:setTouchClipNode(self._tableView)
    statusButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        -- 踢人操作
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if (masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader or 
            (masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader and (self.data.title == PublicDefine.GuildTitle.GuildTitle_CoLeader or self.data.title == PublicDefine.GuildTitle.GuildTitle_Member)) or
            (masterTitle == PublicDefine.GuildTitle.GuildTitle_CoLeader and self.data.title == PublicDefine.GuildTitle.GuildTitle_Member)
        ) then
            local tip = UI.TipsLayer:onShowCommonTextHandler(string.format(LanguageManager:getInstance():getLocalString(1110566),self.data.name), function()
                MasterDataManager:insertRepeatHandleData(RepeatHandleType.GUILD_TICK_MEMBER, self.data.PK, true)
                Net.NetGuildSystem:kickMember(RoleDataManager:getMasterPK(), self.data.PK)

                self:reload(self.data, self.idx, self.type)
            end, function()

            end)
            tip:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
        end
    end)
    self._statusButton = statusButton

    -- local statusLabel = UI.Text:create()
    -- statusLabel:init("0/0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- statusLabel:setTextHorizontalCenter()
    -- statusLabel:setSize(0, 0)
    -- statusLabel:center()
    -- statusLabel:centerRight(STATUS_LABEL)
    -- self._statusButton:addChild(statusLabel, 10)
    -- self._statusLabel = statusLabel

    -- 会长罢免状态图标
    local overthrowIcon = UI.Animation:create()
    overthrowIcon:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    overthrowIcon:setSize(30, 30)
    overthrowIcon:leftUp(76, 4)
    overthrowIcon:hide()
    overthrowIcon:setAnimation("idle",true)
    bg:addChild(overthrowIcon)
    self._overthrowIcon = overthrowIcon

    -- 点击罢免图标出现的提示框
    local overthrowNotificationLayout = UI.Layout:create()
    overthrowNotificationLayout:init()
    overthrowNotificationLayout:center()
    overthrowNotificationLayout:hide()
    bg:addChild(overthrowNotificationLayout, 1000)
    overthrowIcon:setTouchEnable(true)
    overthrowIcon:setTouchClipNode(self._tableView)
    overthrowIcon:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
        overthrowNotificationLayout:show()
    end)
    overthrowIcon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
        overthrowNotificationLayout:hide()
    end)

    -- 拼凑弹出框, 尖尖
    local overthrowNotiBg = UI.Image:create()
    overthrowNotiBg:init("ui_chat_paperbox.png")
    overthrowNotiBg:setScale(0.7)
    overthrowNotiBg:center()
    overthrowNotificationLayout:addChild(overthrowNotiBg)
    
    -- 提示框中的文字
    local overthrowLabel = UI.Text:create()
    overthrowLabel:init(LanguageManager:getInstance():getLocalString(1111691), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    overthrowLabel:center()
    overthrowNotificationLayout:addChild(overthrowLabel)

    local bottomLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_character.png", cc.rect(0,0,1,1))
    bottomLine:setContentSize(cc.size(156, 1))  
    bottomLine:setPosition(cc.p(105 + bottomLine:getContentSize().width/2, 1))
    bg:addChild(bottomLine,10)
    self._bottomLine = bottomLine

    self:reload(self.data, self.idx, self.type)
end

-- 模版函数：更新组建的视图
function GuildMemberCell:onUpdateView()
end

function GuildMemberCell:getNickName()
    if(self.data) then
        if(self.data.PK == RoleDataManager:getMasterPK()) then
            local master = RoleDataManager:getMaster()
            if(master) then
                return master:getNickName()
            end
        else 
            return self.data.name
        end
    end

    return ""
end

function GuildMemberCell:showClickHero()
    local pHeadTips = UI.HeadTips:create(UIType.CHOICE_HERO)

    pHeadTips:setPos(77 + 30, -175)
    pHeadTips:init(self._heroData)
    self:addChild(pHeadTips, 1000)
end

function GuildMemberCell:refreshFace(pic,faceDecodeID)
    if self._iconButton and not tolua.isnull(self._iconButton) then
        -- picName:setVisible(false)
        self._iconButton:removeChildByName("heorIcon", true)
        -- pic:setPosition(63, 68)
        pic:setPosition(38, 38)
        pic:setName("heorIcon")
        self._iconButton:addChild(pic,2)
    end
end


function GuildMemberCell:reload(data, idx, type)
    if(data) then
        self.data = data
    end
    self.type = type
    self.idx = idx

    if(self.data) then
        -- 处理头像的生成
        -- local  templateIDS = {}
        -- print("GuildMemberCell:reload", self:getNickName(), self.data.PK, self.data.sex, self.data.faceDecodeID)
        Avalon.WidgetUtil:getHeadByData(self, self.data.sex, self.data.faceDecodeID, self.data.headID, self,handler(self,function(obj, pic)
            -- print("GuildMemberCell:refreshFace ==> faceDecodeID",faceDecodeID,self.data.faceDecodeID)
            if self._iconButton and not tolua.isnull(self._iconButton) then
                -- picName:setVisible(false)
                self._iconButton:removeChildByName("heorIcon", true)
                -- pic:setPosition(63, 68)
                pic:setPosition(38, 38)
                pic:setName("heorIcon")
                self._iconButton:addChild(pic,2)

                if(self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE)then
                    local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
                    if (shader and pic) then
                        pic:getChildByName("pic"):setGLProgramState(shader)
                    end
                end
            end
        end))

        self._userNameLabel:setText(self:getNickName())
        -- 处理职位
        self._titleNameLabel:setText("["..GameDataManager:getInstance():getTitleStrForTitle(self.data.title).."]");
        -- 公会贡献
        self._contributionLabel:setText(""..self.data.contib)
        self._totalContribLabel:setText(""..self.data.totalContrib)
        -- self._contributionLabel:setText("1000")
        -- 踢人操作
        -- self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1110575));
        -- 公会等级
        local roleLevel = RoleDataManager:getUIShowLvByOtherData(self.data.lv, self.data.reincarnationLevel)
        self._lvLabel:setText(roleLevel.."")

        
        -- print("GuildMemberCell", type, self.idx)
        if(type == UI.GUILD_MANGER_TYPE.MAIN_INFO) then
            self._iconButton:centerLeft(23)
            self._userNameLabel:leftBottom(109,59)
            self._titleNameLabel:leftBottom(109,13)
            self._contributionImage:centerLeft(314 - self._contributionImage:getContentSize().width/2)
            self._contributionLabel:leftBottom(366, 58)
            self._contributionLine:setPosition(cc.p(332 + self._contributionLine:getContentSize().width/2, self.bg:getContentSize().height/2))
            self._totalContribLabel:leftBottom(366, 30)
            self._loginLabel:centerLeft(490)
            self._loginStatusLayout:center(214, 0)
            self._bottomLine:setContentSize(cc.size(432, 1))
            self._bottomLine:setPosition(cc.p(105 + self._bottomLine:getContentSize().width/2, 1))
        else
            self._iconButton:centerLeft(60- self._iconButton:getContentSize().width/2)
            self._userNameLabel:leftBottom(107,59)
            self._titleNameLabel:leftBottom(107,13)
            self._contributionImage:centerLeft(340 - self._contributionImage:getContentSize().width/2)
            self._contributionLabel:leftBottom(396, 58)
            self._contributionLine:setPosition(cc.p(360 + self._contributionLine:getContentSize().width/2, self.bg:getContentSize().height/2))
            self._totalContribLabel:leftBottom(396, 30)
            self._loginStatusLayout:center(138, 0)
            self._titleUpButton:centerLeft(603 - self._titleUpButton:getContentSize().width/2)
            self._titleReduceButton:centerLeft(640 - self._titleReduceButton:getContentSize().width/2)
            self._statusButton:centerLeft(752 - self._statusButton:getContentSize().width/2)

            self._bottomLine:setContentSize(cc.size(709, 1))
            self._bottomLine:setPosition(cc.p(105 + self._bottomLine:getContentSize().width/2, 1))
        end

        -- 在线状态
        if(self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE)then
            self._loginLabel:show()
            -- print("GuildMemberCell offline=", self.data.PK, self.data.name, self.data.offlineTime, GameManager:getNowServerTime())
            local guildData = MasterDataManager:getGuildData()
            if (not guildData:isInOverthrow() or self.data.title ~= PublicDefine.GuildTitle.GuildTitle_Leader) then
                self._loginLabel:setText(GameDataManager:getOffLineStrForTime(self.data.offlineTime))
            else
                local timeString = GameDataManager:getFormatedTimeString(guildData:getOverthrowTimeRemaining())
                local timeFormat = LanguageManager:getInstance():getLocalString(1111696)
                self._loginLabel:setText(string.format(timeFormat, timeString))
            end
            self._loginLabel:setFontColor(UI.FONT_COLOR_41_41_45)
        else
           self._loginLabel:setText(LanguageManager:getInstance():getLocalString(1110577)) 
           self._loginLabel:setFontColor(UI.FONT_COLOR_249_220_103); 
        end
        self._loginLabel:leftBottom(115 + self._titleNameLabel:getContentSize().width,10)

        --行商
        if self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE or 
        self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_LOGINING then 
            local purchaseItem = GameInManorManager:getInstance():getFriendPurchaseItemByPk(self.data.PK)
            if purchaseItem ~= nil then
                self._peddlerBg:show()
                
                -- local goodData = GoodsDataManager:createLocalGoodsData(purchaseItem.saleID)
                -- self._peddlerGoodsIcon:setSpriteName(goodData:getSmallIconName())

                -- local goodData2 = GoodsDataManager:createLocalGoodsData(purchaseItem.giveID)
                -- self._currencyIcon:setSpriteName(goodData2:getSmallIconName())

                if (self.peddlerGoodsIcon) then
                    self.peddlerGoodsIcon:removeFromParent()
                    self.peddlerGoodsIcon = nil
                end

                if (self.currencyIcon) then
                    self.currencyIcon:removeFromParent()
                    self.currencyIcon = nil
                end

                local peddlerGoodsIcon = UI.GoodsGrid:create()
                peddlerGoodsIcon:center(-40)
                self._peddlerBg:addChild(peddlerGoodsIcon)
                self.peddlerGoodsIcon = peddlerGoodsIcon

                local goodData = GoodsDataManager:createLocalGoodsData(purchaseItem.saleID)
                self.peddlerGoodsIcon:init(goodData)
                self.peddlerGoodsIcon:hideBG()
                self.peddlerGoodsIcon:hideRare()
                -- self.peddlerGoodsIcon:hideNewIcon()
                self.peddlerGoodsIcon:hideCountLabel()
                self.peddlerGoodsIcon:showInfoArea(false, false)
                self.peddlerGoodsIcon:setTouchEnable(true)
                self.peddlerGoodsIcon:setSwallowTouches(false)
                self.peddlerGoodsIcon:setScale(0.65)
                self.peddlerGoodsIcon:runAction(
                            cc.Sequence:create(cc.DelayTime:create(0.1),
                            cc.CallFunc:create(function() 
                                self.peddlerGoodsIcon:hideNewIcon()
                            end)))


                local currencyIcon = UI.GoodsGrid:create()
                currencyIcon:center()
                --self._peddlerBg:addChild(currencyIcon)
                self.currencyIcon = currencyIcon
                
                local goodData2 = GoodsDataManager:createLocalGoodsData(purchaseItem.giveID)
                self.currencyIcon:init(goodData2)
                self.currencyIcon:hideBG()
                self.currencyIcon:hideRare()
                self.currencyIcon:hideNewIcon()
                self.currencyIcon:hideCountLabel()
                self.currencyIcon:showInfoArea(false, false)
                self.currencyIcon:setTouchEnable(true)
                self.currencyIcon:setSwallowTouches(false)
                self.currencyIcon:setScale(0.65)
                self.currencyIcon:runAction(
                            cc.Sequence:create(cc.DelayTime:create(0.1),
                            cc.CallFunc:create(function() 
                                self.currencyIcon:hideNewIcon()
                            end)))


                self._peddlerBg:addChild(currencyIcon)





                self._currencyNumberText:setText(AvalonUtil:getSimpleNumber(purchaseItem.givePrice, 4))

            else
                self._peddlerBg:hide()
            end
        else
            self._peddlerBg:hide()
        end

        -- 处理其余显示
        local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
        if(type == UI.GUILD_MANGER_TYPE.MANAGER) then
            self._titleUpButton:setVisible(true)
            self._titleReduceButton:setVisible(true)
            self._statusButton:setVisible(true)
            -- self._statusLabel:setVisible(true)
            self._overthrowButton:setVisible(false)
            self._overthrowIcon:setVisible(false)

            local masterPK = GameDataManager:getInstance():getMasterPK()
            if(masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader) then
                if(self.data.PK == masterPK) then
                    self._titleUpButton:setVisible(false)
                    self._titleReduceButton:setVisible(false)
                    self._statusButton:setVisible(false)
                    -- self._statusLabel:setVisible(false)
                else
                    if(self.data.title == PublicDefine.GuildTitle.GuildTitle_Member) then
                        self._titleUpButton:setVisible(true)
                        self._titleReduceButton:setVisible(false)
                        self._statusButton:setVisible(true)
                        -- self._statusLabel:setVisible(true)
                    else
                        self._titleUpButton:setVisible(true)
                        self._titleReduceButton:setVisible(true)
                        self._statusButton:setVisible(true)
                        -- self._statusLabel:setVisible(true)
                    end
                end
            elseif(masterTitle == PublicDefine.GuildTitle.GuildTitle_ViceLeader) then
                if(self.data.PK == masterPK) then
                    self._titleUpButton:setVisible(false)
                    self._titleReduceButton:setVisible(false)
                    self._statusButton:setVisible(false)
                    -- self._statusLabel:setVisible(false)
                else
                    if(self.data.title == PublicDefine.GuildTitle.GuildTitle_Member) then
                        self._titleUpButton:setVisible(true)
                        self._titleReduceButton:setVisible(false)
                        self._statusButton:setVisible(true)
                        -- self._statusLabel:setVisible(true)
                    elseif(self.data.title == PublicDefine.GuildTitle.GuildTitle_ViceLeader or self.data.title == PublicDefine.GuildTitle.GuildTitle_Leader) then
                        self._titleUpButton:setVisible(false)
                        self._titleReduceButton:setVisible(false)
                        self._statusButton:setVisible(false)
                        -- self._statusLabel:setVisible(false)
                    else
                        self._titleUpButton:setVisible(true)
                        self._titleReduceButton:setVisible(true)
                        self._statusButton:setVisible(true)
                        -- self._statusLabel:setVisible(true)
                    end
                end
            elseif(masterTitle == PublicDefine.GuildTitle.GuildTitle_CoLeader) then
                if(self.data.title == PublicDefine.GuildTitle.GuildTitle_Member) then
                    self._titleUpButton:setVisible(false)
                    self._titleReduceButton:setVisible(false)
                    self._statusButton:setVisible(true)
                    -- self._statusLabel:setVisible(true)
                else
                    self._titleUpButton:setVisible(false)
                    self._titleReduceButton:setVisible(false)
                    self._statusButton:setVisible(false)
                    -- self._statusLabel:setVisible(false)
                end
            else 
                self._titleUpButton:setVisible(false)
                self._titleReduceButton:setVisible(false)
                self._statusButton:setVisible(false)
                -- self._statusLabel:setVisible(false)
            end
        else
            self._titleUpButton:setVisible(false)
            self._titleReduceButton:setVisible(false)
            self._statusButton:setVisible(false)
            -- self._statusLabel:setVisible(false)
            if (masterTitle == PublicDefine.GuildTitle.GuildTitle_Leader) then
                self._overthrowButton:setVisible(false)
                self._overthrowIcon:setVisible(false)
            else
                if (self.data.title ~= PublicDefine.GuildTitle.GuildTitle_Leader) then
                    self._overthrowButton:setVisible(false)
                    self._overthrowIcon:setVisible(false)
                else
                    local guildData = MasterDataManager:getGuildData()
                    if (guildData:isAbleToOverthrow()) then
                        self._overthrowButton:setVisible(true)
                    else
                        self._overthrowButton:setVisible(false)
                    end

                    if (guildData:isInOverthrow()) then
                        self._overthrowIcon:setVisible(true)
                    else
                        self._overthrowIcon:setVisible(false)
                    end
                end
            end
        end

        if self.data.reincarnationLevel > 0 then
            local headFrame, levelFrame = RoleDataManager:getHeadFrameByReinLv(self.data.reincarnationLevel)
            self.circleImage:setSpriteName(headFrame)
            self._grade_BG:setSpriteName(levelFrame)
        else
            self.circleImage:setSpriteName("ui_information_headframe_box.png")
            self._grade_BG:setSpriteName("ui_information_headframe_grade.png")
        end

        self:refreshPosition()
    end
end



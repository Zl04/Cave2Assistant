-- TalkTips.lua
-- Author:ydli
-- 2017年09月14日
-- Using:点击好友名字出现  以后其他地方会用

-- require "app.ui.baglayer.TaskLayer.TaskAwardGrid"
local LanguageManager = require "app.game.LanguageManager"
UI = UI or {}
local TalkTips = class("TalkTips", UI.HWBtnComponent)
UI.TalkTips = TalkTips
local winSize = cc.Director:getInstance():getWinSize()
local TIPS_RES_LIST = {
}
TalkTipsType = {
    FromChatLayer = 1;
    FromBlackListLayer = 2
}
local winSize = cc.Director:getInstance():getWinSize()
local size = cc.size(158, 178)
-- 构造函数
function TalkTips:ctor()
    TalkTips.super.ctor(self, UIType.TIPS, TIPS_RES_LIST, size.width, size.height)
    self.personalChatFunc = nil
    self.addFriendFunc = nil
    self.shieldFunc = nil
    self.playerData = nil
end

-- 析构函数
function TalkTips:dtor()
    TalkTips.super.dtor(self)
    
end

-- public:
-- 初始化
function TalkTips:init(type, playerData, function1, function2, function3)
    self:showLucencyLight()
    self.talkLayerType = type
    TalkTips.super.init(self)
    self.playerData = playerData
    self.personalChatFunc = function1
    self.addFriendFunc = function2
    self.shieldFunc = function3

    self:setTouchEnable(true)
    self:setInterceptTouches(false)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)

    self.rootLayer = UI.Layout:create()
    self.rootLayer:init(0,0,0,0)
    self.rootLayer:setContentSize(size.width, size.height)
    self.rootLayer:leftBottom(0,0)
    self:addChild(self.rootLayer)


    self.mPicBG = cc.Scale9Sprite:createWithSpriteFrameName("ui_tips_banner_box1.png")
    self.mPicBG:setCapInsets(CCRectMake(60,30,5,2))
    self.mPicBG:setContentSize(149, 178)
    self.mPicBG:setAnchorPoint(0.5, 0.5)
    self.rootLayer:addChild(self.mPicBG)
    self.mPicBG:setPosition(self.mPicBG:getContentSize().width / 2, self.mPicBG:getContentSize().height / 2)


   
    local beginHeight = 20
    local posX = 15
    if not ServerConfigUtil:isForbideChat() and self.talkLayerType == TalkTipsType.FromChatLayer then
        local talkBtn = UI.Button:create()
        talkBtn:init("ui_btn_team_0.png","ui_btn_team_1.png","ui_btn_team_0.png")
        talkBtn:leftUp(posX, beginHeight)
        talkBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onPersonalChatClick)
        self.mPicBG:addChild(talkBtn)
        talkBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        talkBtn:setText(UI.TEXT_1170308)
        beginHeight = beginHeight +  55
    end
    
    if self.talkLayerType == TalkTipsType.FromBlackListLayer or self.talkLayerType == TalkTipsType.FromChatLayer then
        local addFriend = UI.Button:create()
        addFriend:init("ui_btn_team_0.png","ui_btn_team_1.png","ui_btn_team_0.png")
        addFriend:leftUp(posX, beginHeight)
        beginHeight = beginHeight + 55
        addFriend:addEventListener(UIEvent.BUTTON_CLICK,self,self.onAddFriendClick)
        self.mPicBG:addChild(addFriend)
        addFriend:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44 )
        if Game.FriendManager:getInstance():isFriend(self.playerData.pk) then
            addFriend:setText(UI.TEXT_1170315)
        else
            addFriend:setText(UI.TEXT_1170314)
        end
    end

    if self.talkLayerType == TalkTipsType.FromChatLayer then
        local shieldBtn = UI.Button:create()
        shieldBtn:init("ui_btn_team_0.png","ui_btn_team_1.png","ui_btn_team_0.png")
        shieldBtn:leftUp(posX, beginHeight)
        beginHeight = beginHeight + 55
        shieldBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onShieldClick)
        self.mPicBG:addChild(shieldBtn)
        shieldBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        shieldBtn:setText(UI.TEXT_1170316)
        if Game.ChatManager:getInstance():isShieldPlayer(self.playerData.pk) then
            shieldBtn:setText(UI.TEXT_1170317)
        else
            shieldBtn:setText(UI.TEXT_1170316)
        end
    end

    if self.talkLayerType == TalkTipsType.FromBlackListLayer or self.talkLayerType == TalkTipsType.FromChatLayer then
        local viewBtn = UI.Button:create()
        viewBtn:init("ui_btn_team_0.png","ui_btn_team_1.png","ui_btn_team_0.png")
        viewBtn:leftUp(posX, beginHeight)
        beginHeight = beginHeight + 55
        viewBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onViewFriend)
        self.mPicBG:addChild(viewBtn)
        viewBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        viewBtn:setText(UI.TEXT_110015)
    end

    if (self.talkLayerType == TalkTipsType.FromChatLayer and
        mvc.apprenticeshipModel:isAbleToApprentice() and 
        not mvc.apprenticeshipModel:getMentor()) 
    then
        local mentorButton = UI.Button:create()
        mentorButton:init("ui_btn_team_0.png","ui_btn_team_1.png","ui_btn_team_0.png")
        mentorButton:leftUp(posX, beginHeight)
        beginHeight = beginHeight + 55
        mentorButton:addEventListener(UIEvent.BUTTON_CLICK,self,self.onAddMentor)
        self.mPicBG:addChild(mentorButton)
        mentorButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        mentorButton:setText(LanguageManager:getInstance():getLocalString(1112628) --[["申请指导"]])
    end


    if ServerConfigUtil:isInReview() then
        local reportBtn = UI.Button:create()
        reportBtn:init("ui_btn_team_0.png","ui_btn_team_1.png","ui_btn_team_0.png")
        reportBtn:leftUp(posX, beginHeight)
        beginHeight = beginHeight + 55
        reportBtn:addEventListener(UIEvent.BUTTON_CLICK,self, function()
            UI.ScrollBar:createByText(UI.TEXT_1170335)
        end)
        self.mPicBG:addChild(reportBtn)
        reportBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        reportBtn:setText(UI.TEXT_1170334)
    end



    local picArrow = cc.Sprite:createWithSpriteFrameName("ui_tips_banner_arrow.png")
    picArrow:setPosition(-10, 14)
    self.rootLayer:addChild(picArrow)
    -- self:enableDebugDraw()
    self.picArrow = picArrow


    self.mPicBG:setContentSize(158, beginHeight)
    self.mPicBG:setPosition(self.mPicBG:getContentSize().width / 2, self.mPicBG:getContentSize().height / 2)
end


-- 初始化视图
function TalkTips:onInitView()
    
end

-- 更新视图
function TalkTips:onUpdateView()

end

function TalkTips:onTouchDialogOutsizeHandler()
    self:close()
end
--创建tips 直接加载TipsLayer上
function TalkTips:createTips(type, playerData, posX, posY, function1, function2, function3)
    local talkTips = UI.TalkTips:create()
    talkTips:init(type, playerData, function1, function2, function3)
    talkTips:leftBottom(posX, posY)
    size.height = talkTips.mPicBG:getContentSize().height
    if posY + size.height > winSize.height then
        talkTips:leftBottom(posX, winSize.height - size.height)
        talkTips.picArrow:setPosition(-5, 14 + (posY + size.height - winSize.height))
    end
    return talkTips
end

function TalkTips:adjustPostion()
    local worldPos = self:convertToWorldSpace(cc.p(0, 0))
    local size = self.mPicBG:getContentSize()
    if worldPos.y + size.height > winSize.height then
        local add = worldPos.y + size.height - winSize.height
        self:leftBottom(self:getPositionX(), self:getPositionY() - add)
        self.picArrow:setPosition(-5, 14 + add)
    end
end

function TalkTips:onPersonalChatClick()
    if not Game.FriendManager:getInstance():isFriend(self.playerData.pk) then
        UI.ScrollBar:createByTextID(1112917)
        return
    end
    if self.personalChatFunc ~= nil then
        self.personalChatFunc(self.playerData)
    else
        self:close()
    end
end

function TalkTips:onAddFriendClick()
    if  self.addFriendFunc ~= nil then
        self.addFriendFunc(self.playerData)
    end  

    if Game.FriendManager:getInstance():isFriend(self.playerData.pk) then
        local pk = self.playerData.pk
        local tip = UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_1170405.."  "..self.playerData.nickName, function()
            local GameDataManager = require("app.game.GameDataManager")
            GameManager:deleteFriend(GameDataManager:getInstance():getMasterPK(), pk)
        end)
        tip:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
    else
        local isSuccess = Game.FriendManager:getInstance():inviteFriend(self.playerData.pk)
    end
    self:close() 
end

function TalkTips:onShieldClick()
    if  self.shieldFunc ~= nil then
        self.shieldFunc(self.playerData)
    end 
    if Game.ChatManager:getInstance():isShieldPlayer(self.playerData.pk) then
        Game.ChatManager:getInstance():removeShieldPlayer(self.playerData.pk)
        UI.ScrollBar:createByText(UI.TEXT_1170336)
    else
        Game.ChatManager:getInstance():insertShieldPlayer(self.playerData.pk, self.playerData)
        UI.ScrollBar:createByText(UI.TEXT_1170337)
    end
    self:close() 
end

function TalkTips:onViewFriend()
    local userID = self.playerData.userID or Game.ChatManager:getInstance():getuserIDByPk(self.playerData.pk)
    GameManager:heroDetailRequest(self.playerData.pk, userID)
    self:close() 
end

function TalkTips:onAddMentor()
    mvc.send(mvc.events.Mentor_Request_Invite_Tutor_Message, self.playerData.pk)
    self:close()
end

function TalkTips:refreshArrowPos(offsetX, offsetY)
    if self.picArrow then
        self.picArrow:setPosition(self.picArrow:getPositionX() + offsetX, self.picArrow:getPositionY() + offsetY)
    end
end
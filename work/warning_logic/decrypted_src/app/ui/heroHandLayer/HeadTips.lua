-- HeadTips.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:查看信息、添加好友、移除队伍、离开队伍 

require "app.ui.team.ViewFriendInfoLayer"
require("app.net.NetTeamSystem")
local LanguageManager = require "app.game.LanguageManager"
local SceneManager = require("app.game.SceneManager")
UI = UI or {}

local HeadTips = class("HeadTips", UI.HWBtnComponent)
UI.HeadTips = HeadTips

-- 资源列表(必备)
local COM_RES_LIST = {
}
local DEBUG = false
local DEBUG_DRAW = true
local GameDataManager = require("app.game.GameDataManager")
--构造函数(必备)
function HeadTips:ctor(type,onLineState)
	--窗口大小
    HeadTips.super.ctor(
    self,type,
    COM_RES_LIST,
    150,	
    160
    )

    self.mData = nil;
    self.rootLayer = nil;           --root节点

    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self:registerListener();
end

--虚构函数,destroy时调用(必备)
function HeadTips:dtor()
end

function HeadTips:setData(Data)
    if(Data) then
        self.mData = Data
    else
        assert(self.mData,"头像数据不存在")
    end

end
-- 初始化(必备)
function HeadTips:init(data)
    self.mData = data;
    HeadTips.super.init(self)
end

function HeadTips:onBtn(sender, touchPosition)--self, 
print("------ sender.txtName = "..sender:getName())
    Avalon.AudioManager:playSound("1503")
    if sender:getName() == UI.TEXT_1212219 then 
        self:close()
        -- 解散队伍
        if(self.mData) then
            local kickOrDismiss, tipsID = self:getIsSendDismissOrKick()
            if(kickOrDismiss == false) then 
                if(tipsID) then 
                    LanguageManager:getInstance():getLocalString(tipsID)
                end
                return 
            end
            print("dismissTime =", self.mData.dismissTime)
            if self.mData.dismissTime > 0 then
                local timeStr = AvalonUtil:_getFullFormatTime(math.floor(tonumber(ConfigManager:getGeneralForKey("kickTime")/1000)), false) 
                UI.ScrollBar:createByText(string.format(UI.TEXT_1212224, timeStr))
                return
            end

            if not TeamDataManager:hasTeam() then
                return
            end
            -- UI.TipsLayer:onVoteSucceedTipsUI(UI.TEXT_110026)
            local tips = UI.Tips:createTips(UI.TEXT_1212220, UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
            tips:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
            tips.mData = self.mData
            -- 确定和取消事件监听
            tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
                tips.mData.dismissTime = tonumber(ConfigManager:getGeneralForKey("kickTime")/1000);

                Net.NetTeamSystem:reqDismissTeam()
            end)
        end
    elseif sender:getName() == UI.TEXT_1212389 then
        self:close()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_FUNCTION_PANEL)
    elseif sender:getName() == UI.TEXT_110015 then
        if (self._type == UIType.CHOICE_HERO) then
            GameManager:heroDetailRequest(self.mData:getPK(), self.mData:getUserID())
            -- UI.UIManager:ViewRolePanel(self.mData)
            self:close()
        
        elseif (self._type == UIType.GUILD_CHOICE_HERO or self._type == UIType.CHOICE_FRIEND_HERO) then
            if self.mData and self.mData.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                GameManager:heroDetailRequest(self.mData.PK, self.mData.userID)
            else
                UI.ScrollBar:createByText(UI.TEXT_1170603)
            end
            -- UI.UIManager:ViewRolePanel(self.mData)
            self:close()
        else
            if self.mData and self.mData._onLineState == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                print("--查看玩家信息")
                self:close()
                GameManager:heroDetailRequest(self.mData:getPK(), self.mData:getUserID())
                -- UI.UIManager:ViewRolePanel(self.mData)
            end
        end
    elseif sender:getName() == UI.TEXT_110017 then
        print("--移出队伍")
        if self.mData then
            self:close()

            local kickOrDismiss, tipsID = self:getIsSendDismissOrKick()
            if(kickOrDismiss == false) then 
                if(tipsID) then 
                    LanguageManager:getInstance():getLocalString(tipsID)
                end
                return 
            end

            print(self.mData.kickTime)
            if self.mData.kickTime > 0 then
                local timeStr = AvalonUtil:_getFullFormatTime(math.floor(tonumber(ConfigManager:getGeneralForKey("kickTime")/1000)), false) 
                UI.ScrollBar:createByText(string.format(UI.TEXT_1110382, timeStr))
                return
            end

            if not TeamDataManager:hasTeam() then
                UI.ScrollBar:createByText(UI.TEXT_1110376)
                return
            end

            local onlineNum = 0;
            local teamData = TeamDataManager:getTeamData()
            for k,v in pairs(teamData) do
                if v:getState() == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                    onlineNum = onlineNum + 1
                    if onlineNum > 1 then
                        break
                    end
                end
            end

            if onlineNum <= 1 then --只有自己在线 可以踢人
                Net.NetTeamSystem:kickTeam(self.mData:getPK())
                return
            elseif table.nums(teamData) <= 2 then--如果队伍人数不足 （实际 有且只有两人在线 才会走该逻辑）
                UI.ScrollBar:createByText(UI.TEXT_1110377)
                return
            end
            
            --有人离线不能踢人（不含被投票人）
            if onlineNum > 1 then
                for k,v in pairs(teamData) do
                    if v:getState() ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE and v:getPK() ~= self.mData:getPK() then
                        UI.ScrollBar:createByText(UI.TEXT_1170606)
                        return
                    end
                end
            end

            local tips = UI.Tips:createTips(string.format(UI.TEXT_110020,self.mData:getNickName()),UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
            tips.mData = self.mData
            tips:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
            -- 确定和取消事件监听
            tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()

                if tips.mData.kickTime > 0 then
                    local timeStr = AvalonUtil:_getFullFormatTime(math.floor(tonumber(ConfigManager:getGeneralForKey("kickTime")/1000)), false) 
                    UI.ScrollBar:createByText(string.format(UI.TEXT_1110382, timeStr))
                    return
                end

                if not TeamDataManager:hasTeam() then
                    UI.ScrollBar:createByText(UI.TEXT_1110376)
                    return
                end

                local onlineNum = 0;
                local teamData = TeamDataManager:getTeamData()
                for k,v in pairs(teamData) do
                    if v:getState() == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                        onlineNum = onlineNum + 1
                        if onlineNum > 1 then
                            break
                        end
                    end
                end

                if onlineNum <= 1 then --只有自己在线 可以踢人
            
                elseif table.nums(teamData) <= 2 then--如果队伍人数不足 小于最大人数 （实际 只有两人在线 才会走该逻辑）
                    UI.ScrollBar:createByText(UI.TEXT_1110377)
                    return
                end

                --有人离线不能踢人（不含被投票人）
                if onlineNum > 1 then
                    for k,v in pairs(teamData) do
                        if v:getState() ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE and v:getPK() ~= tips.mData:getPK() then
                            UI.ScrollBar:createByText(UI.TEXT_1170606)
                            return
                        end
                    end
                end

                Net.NetTeamSystem:kickTeam(tips.mData:getPK())
            end)
        end
    elseif sender:getName() == UI.TEXT_110016 then
        print("--添加好友")
        if (self._type == UIType.CHOICE_HERO) then
            Game.FriendManager:getInstance():inviteFriend(self.mData:getPK())
        elseif (self._type == UIType.GUILD_CHOICE_HERO) then
            Game.FriendManager:getInstance():inviteFriend(self.mData.PK)
        else 
            Game.FriendManager:getInstance():inviteFriend(self.mData:getPK())
        end 
        
        self:close()
    elseif sender:getName() == LanguageManager:getInstance():getLocalString(1112628) --[["申请指导"]] then    
        mvc.send(mvc.events.Mentor_Request_Invite_Tutor_Message, self.mData:getPK())
        self:close()
    elseif sender:getName() == UI.TEXT_10000 then --[["邀请入会"]]
        local targetPK = self.mData:getPK()
        local master = RoleDataManager:getMaster()
        local masterPK = nil
        local guildID = nil
        if (master) then
            masterPK = master:getPK()
            guildID = master:getGuildID()
        end
        if (masterPK and targetPK and guildID) then
            require "app.datas.MasterDataManager"
            local roleHeadData = MasterDataManager:getMasterHeadData()
            Net.NetGuildSystem:inviteToJoinGuild(targetPK, guildID, roleHeadData)
        end
        self:close()
    elseif sender:getName() == UI.TEXT_221803 then
        if SceneManager:getInstance():canVisitManor() then
            local function clickFunc()
                local targetPK = self.mData.getPK and self.mData:getPK() or self.mData.PK
                Net.NetManorSystem:reqEnterManorScene(targetPK)
            end

            -- 如果 worldboss 已报名，提醒一次
            if mvc.worldBossModel:checkCanEnterOther() then
                clickFunc()
            else
                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                    UI.TEXT_1212663,
                    function()
                        Net.NetActivitySystem:requestWorldbossQuitRoom()
                        clickFunc()
                    end
                )
            end

        else
            --提示当前场景不能进入庄园
            UI.ScrollBar:createByText(UI.TEXT_221804)
        end
    elseif sender:getName() == UI.TEXT_221805 then
        local targetPk = self.mData.getPK and self.mData:getPK() or self.mData.PK
        local nickName = self.mData.getNickName and self.mData:getNickName() or self.mData.nickName
        if RoleBehaviorManager:friendSysCheck() then
            printWarn(" been blocked when delete friend !")
            return
        end
        local tip = UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1170405 .. "  " .. (nickName or ""), function()
            --锁住 按钮
            if sender.disable then
                sender:disable()
            end
            MasterDataManager:insertRepeatHandleData(RepeatHandleType.FRIEDN_DELETE, targetPk, 1)
            GameManager:deleteFriend(GameDataManager:getInstance():getMasterPK(), targetPk)
        end)
        tip:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
    end
end

-- 模版函数：初始化组建的视图(必备)
function HeadTips:onInitView()
	--root节点
    self.rootLayer  = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:setSize(140, 160)
    self.rootLayer:centerUp(200)
    self:addChild(self.rootLayer)

    local txtTab = {}

    -- 单人进洞点击玩家头像的操作
    if self._type == UIType.HEROSTATUS then 
        table.insert(txtTab, UI.TEXT_1212219)
        table.insert(txtTab, UI.TEXT_1212389)
    -- 处理组队状态点击玩家头像的操作
    elseif self._type == UIType.TEAMMATESTATUS then
        if self.mData._onLineState == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
            table.insert(txtTab,UI.TEXT_110015) --查看信息
        end
        table.insert(txtTab,UI.TEXT_110016) --添加好友
        table.insert(txtTab,UI.TEXT_110017) --移出队伍
        -- table.insert(txtTab,UI.TEXT_110018) --离开队伍
        require "app.datas.MasterDataManager"
        local myGuildData = MasterDataManager:getGuildData()
        local guildName = "default"
        if (self.mData._onLineState == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE) then
            local memberPk = self.mData.pk
            local memberHeroData = RoleDataManager:getHeroDataForPK(memberPk)
            if (memberHeroData) then
                guildName = memberHeroData:getGuildName()
            end
        end
        if (myGuildData and (not guildName or guildName == "")) then
            table.insert(txtTab,UI.TEXT_10000) -- 邀请入会
        end
    -- 处理城镇查看玩家信息
    elseif self._type == UIType.CHOICE_HERO then
        table.insert(txtTab,UI.TEXT_110015) --查看信息
        table.insert(txtTab,UI.TEXT_110016) --添加好友
        if (mvc.apprenticeshipModel:isAbleToApprentice() and 
            not mvc.apprenticeshipModel:getMentor() and
            mvc.apprenticeshipModel:isMentorReqMet(self.mData.roleLV or 0)) 
        then
            table.insert(txtTab,LanguageManager:getInstance():getLocalString(1112628) --[["申请指导"]])
        end
        require "app.datas.MasterDataManager"
        local myGuildData = MasterDataManager:getGuildData()
        local guildName = "default"
        local memberPk = self.mData.pk
        if (memberPk) then
            local memberHeroData = RoleDataManager:getHeroDataForPK(memberPk)
            if (memberHeroData) then
                guildName = memberHeroData:getGuildName()
            end
        end
        if (myGuildData and (not guildName or guildName == "")) then
            table.insert(txtTab,UI.TEXT_10000) -- 邀请入会
        end
    elseif self._type == UIType.GUILD_CHOICE_HERO then
        table.insert(txtTab,UI.TEXT_110015) --查看信息
        table.insert(txtTab,UI.TEXT_110016) --添加好友
    elseif self._type == UIType.CHOICE_FRIEND_HERO then
        table.insert(txtTab,UI.TEXT_110015) --查看信息
    end

    if SceneManager:getInstance():canVisitManor() and Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_MANOR_PORTAL) then
        table.insert(txtTab, UI.TEXT_221803) --拜访庄园
    end

    if self._type == UIType.CHOICE_FRIEND_HERO then
        table.insert(txtTab, UI.TEXT_221805) --查看信息
    end


    local index = #txtTab
    self.mPicBG = cc.Scale9Sprite:createWithSpriteFrameName("ui_tips_banner_box1.png")
    self.mPicBG:setCapInsets(CCRectMake(60,30,5,2))
    self.mPicBG:setContentSize(149, index * 55 + 20)
    self.mPicBG:setAnchorPoint(0.5, 0.5)
    self.rootLayer:addChild(self.mPicBG)
    self.mPicBG:setPosition(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2)
    self.rootLayer:showLucencyLight(149, index * 55 + 20)


    for n = 1, index do
        local btn = UI.Button:create()
        btn:init("ui_btn_team_0.png", "ui_btn_team_1.png", "ui_btn_team_0.png")
        btn:openClickScale()
        -- 处理公会查看根据玩家当前状态显示相关的标志
        if (self._type == UIType.GUILD_CHOICE_HERO) then
            if(n == 1) then
                -- print("HeadTips dddddd=", self.mData.loginStatus, PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE)
                if self.mData and (self.mData.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE) then
                    -- 处理公会查看角色属性按钮变灰
                    btn:disable()
                end
            end
        elseif self._type == UIType.TEAMMATESTATUS then
            if(n == index) then
                if(GameDataManager:getInstance():getMasterIsDead()) then
                    btn:disable()
                end
            end
        end

        btn:leftUp(10, 20 + 55 * (n - 1))
        btn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onBtn)
        btn:setName(txtTab[n])
        self.mPicBG:addChild(btn)

        local txtLevel = UI.Text:create()
        txtLevel:init(txtTab[n], UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        txtLevel:center()
        btn:addChild(txtLevel, 10)
    end

    local picArrow = cc.Sprite:createWithSpriteFrameName("ui_tips_banner_arrow.png")
    picArrow:setPosition(-16,90)
    self.rootLayer:addChild(picArrow)

end

-- 模版函数：更新组建的视图(必备)
function HeadTips:onUpdateView()

end

function HeadTips:masterDead()
    if self._type == UIType.TEAMMATESTATUS then
        local button = self.rootLayer:getChildByName(UI.TEXT_110017)
        if(button) then
            button:disable()
        end
    end
end

function HeadTips:masterRevive()
    if self._type == UIType.TEAMMATESTATUS then
        local button = self.rootLayer:getChildByName(UI.TEXT_110017)
        if(button) then
            button:enable()
        end
    end
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self, tips, touchPosition)
    self:close()
end

-- 注册监听事件(可选)
function HeadTips:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)

    -- 主角死亡，复活完成
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_DEAD, self, self.masterDead)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_REVIVE, self, self.masterRevive)
end


-- 注销监听事件(可选)
function HeadTips:unRegisterListener()

    -- 主角死亡，复活完成
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_DEAD, self, self.masterDead)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_REVIVE, self, self.masterRevive)
end

function HeadTips:getIsSendDismissOrKick()
    if UI.UIManager:getRootNode() then
        local tipLayer = UI.UIManager:getRootNode():getChildByName("tipLayer")
        if tipLayer ~= nil then
            local tips = tipLayer:getChildByName("dismissTeam");
            if tips then
                return false, 1170208
            end
        end
    end

    if UI.UIManager:getRootNode() then
        local tipLayer = UI.UIManager:getRootNode():getChildByName("tipLayer")
        if tipLayer ~= nil then
            local tips = tipLayer:getChildByName("kickHero");
            if tips then
                return false, 1170209
            end
        end
    end

    return true
end
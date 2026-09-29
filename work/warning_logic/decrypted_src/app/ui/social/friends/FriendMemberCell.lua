-- FriendMemberCell.lua
-- Author:ydli
-- 2017年9月26日
-- Using:好友列表 cell

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local SceneManager = require("app.game.SceneManager")
local GameInManorManager = require("app.game.GameInManorManager")

local winSize = cc.Director:getInstance():getWinSize()
UI = UI or {}
local FriendMemberCell = class("FriendMemberCell", UI.HWBtnComponent)
UI.FriendMemberCell = FriendMemberCell
local model = require("app.uiExport.Friend")


local COM_RES_LIST = {
    "ui_general_friends.plist",
    "ui_town_manor.plist",
}


function FriendMemberCell:ctor(data,idx, parent, status)
    FriendMemberCell.super.ctor(
        self,UIType.FRIEND_MEMBER_CELL,
        COM_RES_LIST,
        0,
        0
    )

    self.rootLayer = nil          --root节点
    self.data = data
    self.idx =idx
    self.parent = parent
    self.friendLayershowModel = parent.showModel
    self.clipNode = parent.friendModel.listViewLayer
    self.status = status or Game.CELL_STATE.NORMAL
    self:init()
end

function FriendMemberCell:dtor()
    FriendMemberCell.super.dtor(self)
    -- self:setInterceptTouches(false)
    self.rootLayer = nil          --root节点
    self.data = nil
    self.idx = nil
end
-- public:
-- 初始化
function FriendMemberCell:init()
    FriendMemberCell.super.init(self)
end

-- 模版函数：初始化组建的视图
function FriendMemberCell:onInitView()    
    -- 读取编辑器排版
    self.friendCellModel = model.create("friendItemModel")
    self.rootLayer = self.friendCellModel.root
    self.rootLayer:leftUp(0, 0)
    self:addChild(self.rootLayer)
    self:setSize(self.rootLayer._width, self.rootLayer._height)
    
    -- 头像
    self._iconButton = self.friendCellModel.friendHeadBtn
    self._iconButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE then
            UI.ScrollBar:createByTextID(1170034)
        else
            -- GameManager:heroDetailRequest(self.data.PK, self.data.userID)

            if SceneManager:getInstance():canVisitManor() and Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_MANOR_PORTAL) then

                local data = {}
                data.PK = self.data.PK 
                data.loginStatus = self.data.loginStatus
                data.userID = self.data.userID
                data.nickName = self.data.nickName
                local pos = self._iconButton:convertToWorldSpace(cc.p(0, 0))
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_HERO_HEAD_TIPS, data,  pos.x + self._iconButton:getContentSize().width +20, pos.y+ 150, UIType.CHOICE_FRIEND_HERO)

            else
                GameManager:heroDetailRequest(self.data.PK, self.data.userID)
            end
            

        end
        Game.FriendManager:getInstance():removeNewFlag(self.data.PK)
        self._iconButton:removeChildByName("REDPOINT")
    end)

    -- 黑名单模式头像遮罩
    self._blockCover = UI.Image:create()
    self._blockCover:init("ui_friends_shield.png")
    self._blockCover:center()
    self._blockCover:hide()
    self._iconButton:addChild(self._blockCover, 100)

    -- 等级
    self._lvLabel = self.friendCellModel.friendLevelLabel
    self._userNameLabel = self.friendCellModel.friendName
    self.positionLabel = self.friendCellModel.friendStatus
    self.friendHeadMask = self.friendCellModel.friendHeadMask
    self.friendLevelBg = self.friendCellModel.friendLevelBg

    self._deleteButton = self.friendCellModel.friendDeleteBtn
    self._deleteButton:setTouchClipNode(self.clipNode);
    self._deleteButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:deleteClick(self._deleteButton)
    end)

    -- 私聊按钮
    local chatButton = self.friendCellModel.friendMsgBtn
    chatButton:setTouchClipNode(self.clipNode)
    chatButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:chatClick(chatButton)
    end)
    self._chatButton = chatButton

    local blockDelBtn = self.friendCellModel.blockDelBtn
    blockDelBtn:setTouchClipNode(self.clipNode)
    blockDelBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if (not self.data or not (self.data.pk or self.data.PK)) then return end
        local targetPK = self.data.pk or self.data.PK
        Game.ChatManager:getInstance():removeShieldPlayer(targetPK)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_REFRESH_FRIENDLAYER)
    end)
    self._blockDeleteButton = blockDelBtn
    

    -- 邀请状态标签
    self.stateLabel = self.friendCellModel.friendInviteStatus
    self.stateLabel:setVisible(false)

    -- 邀请按钮
    self.inviteButton = self.friendCellModel.frendInviteTeamBtn
    self.inviteButton:setTouchClipNode(self.clipNode)
    self.inviteButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:intervalClick(self.inviteButton)
    end)

    -- 聊天禁用
    if ServerConfigUtil:isForbideChat() then
        chatButton:setVisible(false)
        AvalonUtil.pauseNode(chatButton)
    end

    -- 按钮
    if self.friendLayershowModel == UI.FRIEND_LAYER_SHOW_MODEL.INFO then
        self.inviteButton:setVisible(false)
        AvalonUtil.pauseNode(self.inviteButton)
    elseif self.friendLayershowModel == UI.FRIEND_LAYER_SHOW_MODEL.TEAM then
        chatButton:setVisible(false)
        AvalonUtil.pauseNode(chatButton)

        self._deleteButton:setVisible(false)
        AvalonUtil.pauseNode(self._deleteButton)

        self._blockDeleteButton:setVisible(false)
        AvalonUtil.pauseNode(self._blockDeleteButton)
    end

    -- 选中按钮
    self.choiceButton = self.friendCellModel.choiceButton
    self.choiceButton:hide()
    self.choiceButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:choiceClick() 
    end)

    --行商内容
    self.peddlerBg = self.friendCellModel.peddlerBg
    -- self.peddlerGoodsIcon = self.friendCellModel.peddlerGoodsIcon
    -- self.currencyIcon = self.friendCellModel.currencyIcon
    self.currencyNumberText = self.friendCellModel.currencyNumberText
    

    -- 选中标签
    self.choiceLogo = self.friendCellModel.choiceLogo
    self.choiceLogo:hide()
    self:reload(self.data, self.idx, self.status)



    

end

-- 模版函数：更新组建的视图
function FriendMemberCell:onUpdateView()
end

function FriendMemberCell:reload(data, idx, status)
    if(data) then
        self.data = data
    end
    print("---self.data.wearEquipId----", self.data.wearEquipId)
    self.status = status
    self.idx = idx
    if(self.data) then
        if (self.data.nickName) then 
            self._userNameLabel:show()
            self._userNameLabel:setText(self.data.nickName)
        else
            self._userNameLabel:hide()
        end

        if (self.data.roleLV) then 
            self._lvLabel:show()
            local showLv = RoleDataManager:getUIShowLvByOtherData(self.data.roleLV, self.data.reincarntionLv or self.data.reincarnationLevel)
            self._lvLabel:setText(showLv)
        else
            self._lvLabel:hide()
        end
        
        -- if (self.data.loginStatus and self.data.offlineTime) then
        --     self.positionLabel:show()
        --     if self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE then
        --         local leaveTime = GameManager:getNormalServerTime() - self.data.offlineTime
        --         if leaveTime > SECONDS_ONE_DAY * 7 then
        --             self.positionLabel:setText(string.format(UI.TEXT_1212356, 7))
        --         elseif leaveTime > SECONDS_ONE_DAY * 3 then
        --             self.positionLabel:setText(string.format(UI.TEXT_1212356, 3))
        --         else
        --             self.positionLabel:setText(UI.TEXT_1170402)
        --         end
        --     else
        --         if self.data.isInCave then
        --             self.positionLabel:setText(UI.TEXT_1170403)
        --         else
        --             self.positionLabel:setText(UI.TEXT_1170404)
        --         end
        --     end
        -- else
        --     self.positionLabel:hide()
        -- end

        if (self.data.loginStatus and self.data.offlineTime) then
            self.positionLabel:show()
            if self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE then
                self.positionLabel:hide()
            else
                if self.data.isInCave then
                    self.positionLabel:setSpriteName("ui_manor_peddler_busy.png")
                else
                    self.positionLabel:setSpriteName("ui_manor_peddler_idle.png")
                end
            end
        else
            self.positionLabel:hide()
        end

        --处理行商
        if self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE or 
        self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_LOGINING then 
            local purchaseItem = GameInManorManager:getInstance():getFriendPurchaseItemByPk(self.data.PK)
            if purchaseItem ~= nil then
                self.peddlerBg:show()

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
                self.peddlerBg:addChild(peddlerGoodsIcon)


                local currencyIcon = UI.GoodsGrid:create()
                currencyIcon:center()
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
                self.peddlerBg:addChild(currencyIcon)
                
                self.currencyNumberText:setText(AvalonUtil:getSimpleNumber(purchaseItem.givePrice, 4))

            else
                self.peddlerBg:hide()
            end
        else
            self.peddlerBg:hide()
        end


        -- 处理头像的生成
        if (self.data.sex and self.data.faceDecodeID) then
            self._iconButton:show()
            local  templateIDS = {}
            Avalon.WidgetUtil:getHeadByData(self, self.data.sex, self.data.faceDecodeID, self.data.wearEquipId or {}, self,handler(self, function(obj, pic)
                if self._iconButton and not tolua.isnull(self._iconButton) then
                    self._iconButton:removeChildByName("heorIcon", true)
                    pic:setPosition(38, 38)
                    pic:setName("heorIcon")
                    self._iconButton:addChild(pic,2)
                    if self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE then
                        local sprite = pic:getChildByName("pic") 
                        if sprite then
                            sprite:setColor(UI.FONT_COLOR_GRAY)
                        end
                    end
                end
            end))
        else
            self._iconButton:hide()
        end

        if Game.FriendManager:getInstance():isNewFlagByPk(self.data.PK) then
            self._iconButton:removeChildByName("REDPOINT")
            local redPoint = AvalonUtil.createRedPoint(self._iconButton, 0, 0, 20)
            redPoint:setName("REDPOINT")
        else
            self._iconButton:removeChildByName("REDPOINT")
        end

        local keyTables = MasterDataManager:getRepeatHandleData(RepeatHandleType.FRIEDN_DELETE)
        if keyTables ~= nil and keyTables[self.data.PK] then
            self._deleteButton:disable()
        else
            self._deleteButton:enable()
        end
        
        if self.friendLayershowModel == UI.FRIEND_LAYER_SHOW_MODEL.TEAM  then
            if self.data.teammate then
                self.inviteButton:hide()
                self.inviteButton:disable()
                self.stateLabel:setVisible(true)
                self.stateLabel:setText(UI.TEXT_110081)

            else
                self.stateLabel:setText(UI.TEXT_110080)
                if data.loginStatus ~= PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE then
                    self.inviteButton:hide()
                    self.inviteButton:disable()
                    self.stateLabel:setVisible(false)
                else
                    if data.isInCave then
                        self.stateLabel:setVisible(false)
                        self.inviteButton:hide()
                        self.inviteButton:disable()
                    else
                         
                        local time = GameDataManager:getInstance():getInvitationTime(self.data.PK)
                        if time ~= nil and time > 0 then
                            self.stateLabel:setVisible(true)
                            self.inviteButton:hide()
                            self.inviteButton:disable()
                        else
                            self.stateLabel:setVisible(false)
                            self.inviteButton:show()
                            self.inviteButton:enable()
                        end
                    end
                end
            end
        else
            self:refreshChoiceState()
        end   

        if self.data.reincarntionLv and self.data.reincarntionLv > 0 then
            local headFrame, levelFrame = RoleDataManager:getHeadFrameByReinLv(self.data.reincarntionLv)
            self.friendHeadMask:setSpriteName(headFrame)
            self.friendLevelBg:setSpriteName(levelFrame)
        else
            self.friendHeadMask:setSpriteName("ui_information_headframe_box.png")
            self.friendLevelBg:setSpriteName("ui_information_headframe_grade.png")
        end
    end
end

function FriendMemberCell:deleteClick(sender)
    if self.data == nil then
        return
    end 
    local targetPk = self.data.PK
    if RoleBehaviorManager:friendSysCheck() then
        printWarn(" been blocked when delete friend !")
        return
    end
    local tip = UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1170405.."  "..self.data.nickName, function()
        --锁住 按钮
        if sender.disable then
            sender:disable()
        end
        MasterDataManager:insertRepeatHandleData(RepeatHandleType.FRIEDN_DELETE, targetPk, 1)
        GameManager:deleteFriend(GameDataManager:getInstance():getMasterPK(), targetPk)
    end)
    tip:setContentFontName(UI.SYS_FONT, UI.FONT_SIZE_20PX)
end

function FriendMemberCell:chatClick(sender)
    local playerData = {}
    playerData.userID = self.data.userID
    playerData.pk = self.data.PK
    playerData.nickName = self.data.nickName
    playerData.faceDecodeID = self.data.faceDecodeID
    playerData.wearEquipId = self.data.wearEquipId
    playerData.sex = self.data.sex
    playerData.roleLV = self.data.roleLV
    Game.ChatManager:getInstance():OnPersonalChat(playerData, false)
end

function FriendMemberCell:intervalClick(sender)
    if TeamDataManager:hasTeam() then
        if table.nums(TeamDataManager:getTeamData()) >= PublicDefine.CONST_DEFINITION.MAX_TEAM_NUM then
            UI.ScrollBar:createByText(UI.TEXT_111106)
            return
        end
    end
    
    self.data.time = tonumber(ConfigManager:getGeneralForKey("repetitionInviteJoinTeamTime")) / 1000
    GameDataManager:getInstance():setInvitationTime(self.data.PK, tonumber(ConfigManager:getGeneralForKey("repetitionInviteJoinTeamTime")) / 1000)

    self:reload(self.data, self.idx)
    if LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_DUNGEON then
        if not TeamDataManager:hasTeam() then
            Net.NetTeamSystem:createTeam(
                LevelSelectUtil:getInstance().mCaveMode,
                LevelSelectUtil:getInstance().mDifficulty:get(),
                LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(LevelSelectUtil:getInstance().mSelectLevel))
        end
    else
        if not TeamDataManager:hasTeam() then
            Net.NetTeamSystem:createTeam(
                LevelSelectUtil:getInstance().mCaveMode,
                LevelSelectUtil:getInstance().mDifficulty:get(),
                LevelSelectUtil:getInstance().mSelectLevel)
        end
    end

    if LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_DUNGEON then
        Net.NetTeamSystem:requestInviteFriendJoinTeam(self.data.userID,
            self.data.PK,
            LevelSelectUtil:getInstance().mCaveMode,
            LevelSelectUtil:getInstance().mDifficulty:get(),
            LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(LevelSelectUtil:getInstance().mSelectLevel))
    else
        Net.NetTeamSystem:requestInviteFriendJoinTeam(self.data.userID,
            self.data.PK,
            LevelSelectUtil:getInstance().mCaveMode,
            LevelSelectUtil:getInstance().mDifficulty:get(),
            LevelSelectUtil:getInstance().mSelectLevel)
    end
end

function FriendMemberCell:changeMode(infoMode)
    self.infoMode = infoMode
    if self.infoMode == UI.FRIEND_INFO_MODE.DEL_MODE then
        self.status = Game.CELL_STATE.DEL_AND_NO_SELECT
    elseif self.infoMode == UI.FRIEND_INFO_MODE.BLOCK_LIST_MODE then
        self.status = Game.CELL_STATE.BLOCK
    else
        self.status = Game.CELL_STATE.NORMAL
    end
    self:refreshChoiceState()
end

function FriendMemberCell:choiceClick()
    if self.status == Game.CELL_STATE.DEL_AND_SELECTED then
        self.status = Game.CELL_STATE.DEL_AND_NO_SELECT
        self.parent:selectDelPlayer(self.data.PK, false)
    else
        self.status = Game.CELL_STATE.DEL_AND_SELECTED
        self.parent:selectDelPlayer(self.data.PK, true)
    end
    self:refreshChoiceState()
end

function FriendMemberCell:refreshChoiceState()
    local redPoint = self._iconButton:getChildByName("REDPOINT")
    if self.infoMode == UI.FRIEND_INFO_MODE.BLOCK_LIST_MODE then
        self.choiceButton:hide()
        self.choiceLogo:hide()
        self._chatButton:hide()
        self._deleteButton:hide()
        self._blockDeleteButton:show()
        self._blockCover:show()
        if (redPoint) then redPoint:hide() end
    elseif self.status == Game.CELL_STATE.NORMAL then
        self.choiceButton:hide()
        self.choiceLogo:hide()
        self._chatButton:show()
        self._deleteButton:hide()
        -- self._deleteButton:show()
        if self.data.loginStatus == PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_OFFLINE then
            self._deleteButton:show()
            self._chatButton:setReflectPos(57, 52)
        else
            self._chatButton:setReflectPos(20, 52)
        end
        self._blockDeleteButton:hide()
        self._blockCover:hide()
        if (redPoint) then redPoint:show() end
    elseif self.status == Game.CELL_STATE.DEL_AND_SELECTED then
        self.choiceButton:show()
        self.choiceLogo:show()
        self._chatButton:hide()
        self._deleteButton:hide()
        self._blockDeleteButton:hide()
        self._blockCover:hide()
        if (redPoint) then redPoint:show() end
    else 
        self.choiceButton:show()
        self.choiceLogo:hide()
        self._chatButton:hide()
        self._deleteButton:hide()
        self._blockDeleteButton:hide()
        self._blockCover:hide()
        if (redPoint) then redPoint:show() end
    end
end

------------------------------------------------------------------------------
--author: 
--date	: 2019/10/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GuildInfoView = class("GuildInfoView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_guild_general.plist",
    "ui_town_guild_information.plist",
    "ui_town_guild_icon.plist"
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

function GuildInfoView:ctor(guildID)
    self._guildID = guildID
    GuildInfoView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function GuildInfoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.guildinfo", "GuildInfo", false)
    GuildInfoView.super.init(self, ... )
    mvc.guildInfoController:requestInfo(self._guildID)
end

function GuildInfoView:dtor()
    GuildInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.guildinfo.GuildInfoView")
    mvc.guildInfoModel:resetData()
end


function GuildInfoView:onInitView()
------程序生成区块开始 node_1527591928_1570589181-------
    local node_1527591928_1570589181 = UI.Image:create()
    node_1527591928_1570589181:init('ui_guild_information_paper.png')
    node_1527591928_1570589181.__uiComposerID = "1527591928_1570589181"
    addChildAuto(self._layoutUU, self, node_1527591928_1570589181, "layout_1527591928_1570589181")
    self:setSize(node_1527591928_1570589181:getSize())
    self:center()
    mvc.guildInfoPanel.ui:setSize(self:getSize())
    mvc.guildInfoPanel.ui:center()
------程序生成区块结束 node_1527591928_1570589181-------
------程序生成区块开始 node_16971037_1570694046-------
    local node_16971037_1570694046 = UI.Text:create()
    node_16971037_1570694046:init(LanguageManager:getInstance():getLocalString(1112965) --[["公会名字"]], UI.FONT_BOLD, 20, {r = 50, g = 49, b = 53})
    node_16971037_1570694046:setWidth(200)
    node_16971037_1570694046:autoAdapt()
    node_16971037_1570694046.__uiComposerID = "16971037_1570694046"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_16971037_1570694046, "layout_16971037_1570694046")
    self._guildName = node_16971037_1570694046 -- 暴露名字至self
------程序生成区块结束 node_16971037_1570694046-------
------程序生成区块开始 node_814726531_1570850359-------
    local node_814726531_1570850359 = UI.Image:create()
    node_814726531_1570850359:init('ui_guild_headframe_big.png')
    node_814726531_1570850359.__uiComposerID = "814726531_1570850359"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_814726531_1570850359, "layout_814726531_1570850359")
------程序生成区块结束 node_814726531_1570850359-------
------程序生成区块开始 node_2115173577_1570850412-------
    local node_2115173577_1570850412 = UI.Image:create()
    node_2115173577_1570850412:init('ui_guild_icon_guilgicon1.png')
    node_2115173577_1570850412.__uiComposerID = "2115173577_1570850412"
    addChildAuto(self._layoutUU, node_814726531_1570850359, node_2115173577_1570850412, "layout_2115173577_1570850412")
    self._guildIcon = node_2115173577_1570850412 -- 暴露名字至self
------程序生成区块结束 node_2115173577_1570850412-------
------程序生成区块开始 node_1022351344_1570850655-------
    local node_1022351344_1570850655 = UI.Text:create()
    node_1022351344_1570850655:init("", UI.SYS_FONT, 18, {r = 50, g = 49, b = 53})
    node_1022351344_1570850655:autoAdapt()
    node_1022351344_1570850655.__uiComposerID = "1022351344_1570850655"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_1022351344_1570850655, "layout_1022351344_1570850655")
    self._guildMasterName = node_1022351344_1570850655 -- 暴露名字至self
------程序生成区块结束 node_1022351344_1570850655-------
------程序生成区块开始 node_71558962_1570850729-------
    local node_71558962_1570850729 = UI.Text:create()
    node_71558962_1570850729:init(LanguageManager:getInstance():getLocalString(1112966) --[["公会人数"]], UI.FONT_STANDARD, 18, {r = 42, g = 42, b = 46})
    node_71558962_1570850729:autoAdapt()
    node_71558962_1570850729.__uiComposerID = "71558962_1570850729"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_71558962_1570850729, "layout_71558962_1570850729")
------程序生成区块结束 node_71558962_1570850729-------
------程序生成区块开始 node_675268_1570850827-------
    local node_675268_1570850827 = UI.Text:create()
    node_675268_1570850827:init(LanguageManager:getInstance():getLocalString(1112967) --[["科技总等级"]], UI.FONT_STANDARD, 18, {r = 42, g = 42, b = 46})
    node_675268_1570850827:autoAdapt()
    node_675268_1570850827.__uiComposerID = "675268_1570850827"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_675268_1570850827, "layout_675268_1570850827")
------程序生成区块结束 node_675268_1570850827-------
------程序生成区块开始 node_130780616_1570850896-------
    local node_130780616_1570850896 = UI.Text:create()
    node_130780616_1570850896:init("0/0", UI.FONT_STANDARD, 18, {r = 209, g = 209, b = 209})
    node_130780616_1570850896:autoAdapt()
    node_130780616_1570850896.__uiComposerID = "130780616_1570850896"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_130780616_1570850896, "layout_130780616_1570850896")
    self._guildMemberNum = node_130780616_1570850896 -- 暴露名字至self
------程序生成区块结束 node_130780616_1570850896-------
------程序生成区块开始 node_1817535443_1570850963-------
    local node_1817535443_1570850963 = UI.Text:create()
    node_1817535443_1570850963:init("11", UI.FONT_STANDARD, 18, {r = 209, g = 209, b = 209})
    node_1817535443_1570850963:autoAdapt()
    node_1817535443_1570850963.__uiComposerID = "1817535443_1570850963"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_1817535443_1570850963, "layout_1817535443_1570850963")
    self._guildLv = node_1817535443_1570850963 -- 暴露名字至self
------程序生成区块结束 node_1817535443_1570850963-------
------程序生成区块开始 node_1323144930_1570851023-------
    local node_1323144930_1570851023 = UI.Text:create()
    node_1323144930_1570851023:init(LanguageManager:getInstance():getLocalString(1112968) --[["公告"]], UI.FONT_STANDARD, 18, {r = 194, g = 194, b = 194})
    node_1323144930_1570851023:autoAdapt()
    node_1323144930_1570851023.__uiComposerID = "1323144930_1570851023"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_1323144930_1570851023, "layout_1323144930_1570851023")
------程序生成区块结束 node_1323144930_1570851023-------
------程序生成区块开始 node_404557747_1571040927-------
    local node_404557747_1571040927 = UI.ScrollView:create()
    node_404557747_1571040927:setSize(255, 115)
    node_404557747_1571040927:init(0, 0, 0, 0)
    node_404557747_1571040927.__uiComposerID = "404557747_1571040927"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_404557747_1571040927, "layout_404557747_1571040927")
------程序生成区块结束 node_404557747_1571040927-------
------程序生成区块开始 node_1449089778_1571043679-------
    local node_1449089778_1571043679 = UI.Text:create()
    node_1449089778_1571043679:init("", UI.FONT_STANDARD, 16, {r = 50, g = 49, b = 53})
    node_1449089778_1571043679:setWidth(255)
    node_1449089778_1571043679:autoAdapt()
    node_1449089778_1571043679.__uiComposerID = "1449089778_1571043679"
    addChildAuto(self._layoutUU, node_404557747_1571040927, node_1449089778_1571043679, "layout_1449089778_1571043679", nil, nil, "addInnerNode")
    self._infoLabel = node_1449089778_1571043679 -- 暴露名字至self
------程序生成区块结束 node_1449089778_1571043679-------
------程序生成区块开始 node_490408010_1571046596-------
    local node_490408010_1571046596 = UI.Button:create()
    node_490408010_1571046596:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow5_2.png")
    node_490408010_1571046596:setText(LanguageManager:getInstance():getLocalString(1112969) --[["申请入会"]])
    node_490408010_1571046596:setTextFont(UI.FONT_STANDARD, 18, {r = 50, g = 49, b = 53})
    node_490408010_1571046596:setInterval(1)
    node_490408010_1571046596:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.guildInfoController:requestJoinGuild(self._guildID)
    end)
    node_490408010_1571046596.__uiComposerID = "490408010_1571046596"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_490408010_1571046596, "layout_490408010_1571046596")
    self._requestJoinBtn = node_490408010_1571046596 -- 暴露名字至self
------程序生成区块结束 node_490408010_1571046596-------
------程序生成区块开始 node_1625839772_1571711131-------
    local node_1625839772_1571711131 = UI.Text:create()
    node_1625839772_1571711131:init("", UI.FONT_STANDARD, 18, {r = 124, g = 25, b = 27})
    node_1625839772_1571711131:autoAdapt()
    node_1625839772_1571711131.__uiComposerID = "1625839772_1571711131"
    addChildAuto(self._layoutUU, node_1527591928_1570589181, node_1625839772_1571711131, "layout_1625839772_1571711131")
    self._statusLabel = node_1625839772_1571711131 -- 暴露名字至self
------程序生成区块结束 node_1625839772_1571711131-------
end

function GuildInfoView:onUpdateView()
    -- required uint64 id = 1;
    -- required string name = 2;
    -- required string leaderName = 3;
    -- required uint32 curMemberNum = 4;
    -- required uint32 lv = 5;
    -- optional string notice = 6;
    -- required GuildRelationship rs = 7;
    -- required uint32 iconID = 8;
    local data = mvc.guildInfoModel:getData()
    
    -- 图标
    if (data.iconID) then
        local GameDataManager = require("app.game.GameDataManager")
        local iconName = GameDataManager:getInstance():getGuildIconForIconID(data.iconID)
        if (iconName) then
            self._guildIcon:show()
            self._guildIcon:setSpriteName(iconName)
        else
            self._guildIcon:hide()
        end
    else
        self._guildIcon:hide()
    end

    -- 公会名字
    if (data.name) then
        self._guildName:show()
        self._guildName:setText(data.name)
    else
        self._guildName:hide()
    end

    -- 会长名字
    if (data.leaderName) then
        self._guildMasterName:show()
        self._guildMasterName:setText(LanguageManager:getInstance():getLocalString(1112970) --[["[会长]"]] .. data.leaderName)
    else
        self._guildMasterName:hide()
    end

    -- 公会等级
    if (data.lv) then
        self._guildLv:show()
        self._guildLv:setText(data.lv)
    else
        self._guildLv:hide()
    end

    -- 成员数量
    local isFull = false
    if (data.curMemberNum and data.lv) then
        local GameDataManager = require("app.game.GameDataManager")
        local memberCap = GameDataManager:getInstance():getGuildMemberConfigForLevel(data.lv)
        if (memberCap) then
            isFull = data.curMemberNum >= memberCap
            self._guildMemberNum:show()
            self._guildMemberNum:setText(tostring(data.curMemberNum) .. "/" .. memberCap)
        else
            self._guildMemberNum:hide()
        end
    else
        self._guildMemberNum:hide()
    end

    -- 公告
    if (data.notice) then
        self._infoLabel:show()
        self._infoLabel:setText(data.notice)
    else
        self._infoLabel:hide()
    end

    -- 申请加入按钮状态
    if (data.rs) then
        if (data.rs == "GuildRelationship_None") then
            -- 能够尝试加入
            require "app.datas.MasterDataManager"
            if (MasterDataManager:getGuildData()) then
                self._statusLabel:show()
                self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1113031) --[["已加入公会"]])
                self._requestJoinBtn:hide()
                self._requestJoinBtn:disable()
            elseif (not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Guild)) then
                self._statusLabel:show()
                self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1170189) --[["该功能未解锁"]])
                self._requestJoinBtn:hide()
                self._requestJoinBtn:disable()
            elseif (isFull) then
                self._statusLabel:show()
                self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1170048) --[["公会人数已满"]])
                self._requestJoinBtn:hide()
                self._requestJoinBtn:disable()
            else
                self._statusLabel:hide()
                self._requestJoinBtn:show()
                self._requestJoinBtn:enable()
                self._requestJoinBtn:setText(LanguageManager:getInstance():getLocalString(1112971) --[["加入公会"]])
            end
        elseif (data.rs == "GuildRelationship_In") then
            -- 已经在这个公会里头
            self._statusLabel:show()
            self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1112972) --[["已加入该公会"]])
            self._requestJoinBtn:hide()
            self._requestJoinBtn:disable()
        elseif (data.rs == "GuildRelationship_Apply") then
            -- 已经申请公会了
            self._statusLabel:show()
            self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1112973) --[["已申请加入该公会"]])
            self._requestJoinBtn:hide()
            self._requestJoinBtn:disable()
        else
            -- 出问题了, 隐藏
            self._requestJoinBtn:hide()
            self._statusLabel:hide()
        end
    end
end

function GuildInfoView:bindModel()

end


function GuildInfoView:unbindModel()

end





return GuildInfoView













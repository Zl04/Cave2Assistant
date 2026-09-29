-- GuildRenameLayer.lua
-- Author:luozhiming

require "app.ui.UIDefine"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local GuildRenameLayer = class("GuildRenameLayer", UI.DownShowWin)
UI.GuildRenameLayer = GuildRenameLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

local COM_WIDTH = 440;
local COM_HEIGHT = 618;
local ZOrder = 1

--资源列表(必备)
local COM_RES_LIST = {
    "ui_login_createRole.plist",
}

--构造函数(必备)
function GuildRenameLayer:ctor(npcSpriteID)
     GuildRenameLayer.super.ctor(
        self, 
        UIType.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.isNoticeShowMainUI = false
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self:open()
end

--虚构函数, destroy时调用(必备)
function GuildRenameLayer:dtor()
    GuildRenameLayer.super.dtor(self)
    self:unregisterListener()

    reload_script_file("app.ui.guild.manager.GuildRenameLayer")
end

-- 初始化(必备)
function GuildRenameLayer:init()
    GuildRenameLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function GuildRenameLayer:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0,0,0,0));
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    contentLayout:addChild(mask)

    local maskLayout = UI.Layout:create();
    maskLayout:init()
    maskLayout:setSize(COM_WIDTH, COM_HEIGHT)
    maskLayout:center()
    maskLayout:setTouchEnable(true)
    maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() end)
    contentLayout:addChild(maskLayout, 0)

    local line1  = UI.Image:create();
    line1:init("ui_guild_modify_banner_bg_2.png");
    line1:leftUp(0, -line1:getContentSize().height+26);
    contentLayout:addChild(line1, ZOrder);

    local line2  = UI.Image:create();
    line2:init("ui_guild_modify_banner_bg_2.png");
    line2:rightUp(0, -line2:getContentSize().height+26);
    contentLayout:addChild(line2, ZOrder);
    ZOrder = ZOrder + 1

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("ui_guild_modify_banner_bg.png");
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;
    self.bg = bg

    self:initUpLayout()
    self:initDownLayout()
end

function GuildRenameLayer:initUpLayout()
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(392, 118)
    contentLayout:leftUp(28, 20)
    self.bg:addChild(contentLayout)
    -- contentLayout:enableDebugDraw()

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213860, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_170_170_170)
    titleTxt:centerUp(10)
    contentLayout:addChild(titleTxt)

    local txtbg  = UI.Image:create();
    txtbg:init("ui_guild_modify_banner_1.png");
    txtbg:leftBottom(64, 10);
    contentLayout:addChild(txtbg);


    -- 文本输入框
    local guildNameEdit = UI.EditBox:create(228, 44)
    self.guildNameHolderTxt = MasterDataManager:getGuildData().name
    guildNameEdit:init(self.guildNameHolderTxt, cc.EDITBOX_INPUT_MODE_SINGLELINE, nil, 21, 14)
    guildNameEdit:leftUp(70, 55)
    contentLayout:addChild(guildNameEdit)
    guildNameEdit:setFontSize(18)
    guildNameEdit:setFontColor(UI.FONT_COLOR_255_255_255)
    guildNameEdit:setPlaceholderFontSize(18)
    guildNameEdit:setPlaceholderFontColor(UI.FONT_COLOR_255_255_255)
    guildNameEdit:setChangeCallback(function()
        local message = guildNameEdit:getText() or ""
        message = ToolsUtil:replaceNameStr(message)
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
            guildNameEdit:setText(message)
            guildNameEdit:closeKeyboard()
            return
        end

        if AvalonUtil:isUpLimiteStr(message, 160, 22) then
            message = AvalonUtil:getSubNameStrByLabel(message, 160, 22)
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110609))
            guildNameEdit:setText(message)
            guildNameEdit:closeKeyboard()
        end
    end)

    guildNameEdit:setReturnCallback(function()
        local message = guildNameEdit:getText() or ""
        if AvalonUtil:isUpLimiteStr(message, 160, 22) then
            message = AvalonUtil:getSubNameStrByLabel(message, 160, 22)
        end

        -- 表情
        if AvalonUtil:isEmoji(message) then
            UI.ScrollBar:createByText(UI.TEXT_1170936)
            self.finalName = nil
            self.renameBtn:disable()
            self.renameDiamondNum:setFontColor(UI.FONT_COLOR_41_41_45)
            return
        end
        message = ToolsUtil:replaceNameStr(message)
        
        -- 处理敏感字
        local mark = false
        message = ToolsUtil:roleNameFilter(message)
        message,mark = ToolsUtil:checkMaskword(message)
        if mark then
            UI.ScrollBar:createByText(UI.TEXT_1170415)
            guildNameEdit:setText(message)

            self.finalName = nil
            self.renameBtn:disable()
            self.renameDiamondNum:setFontColor(UI.FONT_COLOR_41_41_45)
            return
        end

        -- 回车
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
        end

        -- 设置表现
        guildNameEdit:setText(message)
        guildNameEdit:setPlaceHolder(LanguageManager:getInstance():getLocalString(1110516))

        -- 改名为空, 取消
        if (message == "") then
            UI.ScrollBar:createByTextID(1111721) -- "公会名称不能为空, 改名已取消"
            guildNameEdit:setPlaceHolder(self.guildNameHolderTxt)

            self.finalName = nil
            self.renameBtn:disable()
            self.renameDiamondNum:setFontColor(UI.FONT_COLOR_41_41_45)
            return
        end

        -- 名字和现有相同, 取消
        local guildData = MasterDataManager:getGuildData()
        if (guildData and message == guildData.name) then
            UI.ScrollBar:createByTextID(1111722) -- "公会名称不能与当前重复, 改名已取消"

            self.finalName = nil
            self.renameBtn:disable()
            self.renameDiamondNum:setFontColor(UI.FONT_COLOR_41_41_45)
            return
        end

        self.finalName = message
        self.renameBtn:enable()

        if not Avalon.MathUtil:checkDiamonEnough(tonumber(self.renameCost), GameDataManager:getInstance():getDiamond()) then
            self.renameDiamondNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
    end)
    self.guildNameEdit = guildNameEdit

    local renameBtn = UI.Button:create()
    renameBtn:init("ui_createrole_thn_0.png", "ui_createrole_thn_1.png", "ui_createrole_thn_2.png")
    renameBtn:rightBottom(25, 21)
    renameBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self.finalName == nil then
            return
        end

        local func = function(finalName)
            if not Avalon.MathUtil:checkDiamonEnough(tonumber(self.renameCost), GameDataManager:getInstance():getDiamond()) then
                -- 钻石不足
                local tips = UI.TipsLayer:onDiamondNotEnough()
                if(tips) then 
                    tips:setZOrder(UI_ZORDER.MAX)
                end
                tips:removeFromParent(false)
                UI.UIManager:getRootNode():addChild(tips)
                return
            end

            local cost = ConfigManager:getDiamondForRename()
            UI.TipsLayer:onRenamingGuild(finalName, cost, function()
                -- 提交改名
                local master = GameDataManager:getInstance():getMaster()
                if (master) then
                    Net.NetGuildSystem:renameGuild(master:getPK(), finalName)
                end
            end, nil)
        end

        local gameWordDetectionManager = require"app.game.GameWordDetectionManager"
        local nickName = self.finalName or ""
        renameBtn:disable()
        gameWordDetectionManager:getInstance():nicknameDetection(nickName,func,function()
            renameBtn:enable()
        end)
    end)
    contentLayout:addChild(renameBtn)
    renameBtn:disable()
    self.renameBtn = renameBtn

    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_gaming_diamond.png")
    diamondIcon:centerLeft(5)
    renameBtn:addChild(diamondIcon, 100)

    local cost = ConfigManager:getDiamondForRename()
    local diamondNum = UI.Text:create()
    diamondNum:init(tostring(cost), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    diamondNum:centerLeft(diamondIcon:getLeft() + diamondIcon:getContentSize().width + 3)
    diamondNum:setTextLeft()
    renameBtn:addChild(diamondNum, 100)
    self.renameCost = cost
    self.renameDiamondNum = diamondNum
end

function GuildRenameLayer:initDownLayout()
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(392, 392)
    contentLayout:leftUp(28, 196)
    self.bg:addChild(contentLayout)
    -- contentLayout:enableDebugDraw()

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213861, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_170_170_170)
    titleTxt:centerUp(4)
    contentLayout:addChild(titleTxt)

    self.titles = {PublicDefine.GuildTitle.GuildTitle_Leader, PublicDefine.GuildTitle.GuildTitle_ViceLeader,
                PublicDefine.GuildTitle.GuildTitle_CoLeader, PublicDefine.GuildTitle.GuildTitle_Member}
    self.finalTitleName = {}

    local txtPos = {{18, 60}, {18, 134}, {18, 208}, {18, 282}}
    local titleStr = {UI.TEXT_1213862, UI.TEXT_1213863, UI.TEXT_1213864, UI.TEXT_1213865}
    local editPos = {{12, 44}, {12, 118}, {12, 192}, {12, 266}}

    self.originTitleName = clone(titleStr)
    self.placeHolderTxt = clone(titleStr)

    -- 职级自定义名称替换
    local guildData = MasterDataManager:getGuildData()
    local customTitles = guildData:getCustomTitles()
    for _, v in ipairs(customTitles) do
        self.originTitleName[v.title] = v.titleName
        self.placeHolderTxt[v.title] = v.titleName
    end

    for i = 1, 4 do
        self:insertOneTitle(contentLayout, i, txtPos[i], titleStr[i], editPos[i], self.placeHolderTxt[i])
    end


    local changeTitleBtn = UI.Button:create()
    changeTitleBtn:init("ui_btn_yellow8_0.png", "ui_btn_yellow8_1.png", "ui_btn_yellow8_2.png")
    changeTitleBtn:centerBottom(10)
    changeTitleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if #self.finalTitleName == 0 then
            return
        end

        if not Avalon.MathUtil:checkDiamonEnough(tonumber(self.renameTitleCost), GameDataManager:getInstance():getDiamond()) then
            -- 钻石不足
            local tips = UI.TipsLayer:onDiamondNotEnough()
            if(tips) then 
                tips:setZOrder(UI_ZORDER.MAX)
            end
            tips:removeFromParent(false)
            UI.UIManager:getRootNode():addChild(tips)
            return
        end

        UI.TipsLayer:onGuildRenameTitle(ConfigManager:getDiamondForRenameTitle(), function()
            local guildData = MasterDataManager:getGuildData()
            Net.NetGuildSystem:reqGuildChangTitleName(RoleDataManager:getMasterPK(), guildData.ID, self.finalTitleName)
            self:closeWin()
        end, nil)
    end)
    changeTitleBtn:disable()
    contentLayout:addChild(changeTitleBtn)
    self.changeTitleBtn = changeTitleBtn

    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_gaming_diamond.png")
    diamondIcon:centerLeft(35)
    changeTitleBtn:addChild(diamondIcon, 100)

    local cost = ConfigManager:getDiamondForRenameTitle()
    local diamondNum = UI.Text:create()
    diamondNum:init(tostring(cost), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    diamondNum:centerLeft(diamondIcon:getLeft() + diamondIcon:getContentSize().width + 14)
    diamondNum:setTextLeft()
    changeTitleBtn:addChild(diamondNum, 100)
    self.renameTitleCost = cost
    self.renameTitleDiamondNum = diamondNum
end

function GuildRenameLayer:insertOneTitle(contentLayout, idx, pos1, titleTxt1, pos2, titleTxt2)
    local txt = UI.Text:create()
    txt:init(titleTxt1, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_170_170_170)
    txt:leftUp(pos1[1], pos1[2])
    contentLayout:addChild(txt)

    local edit = UI.EditBox:create(220, 62)
    edit.idx = idx
    edit:init(titleTxt2, cc.EDITBOX_INPUT_MODE_SINGLELINE, "ui_guild_modify_banner_2.png", 21, 14)
    edit:rightUp(pos2[1], pos2[2])
    contentLayout:addChild(edit)
    edit:setFontSize(18)
    edit:setFontColor(UI.FONT_COLOR_255_255_255)
    edit:setPlaceholderFontSize(18)
    edit:setPlaceholderFontColor(UI.FONT_COLOR_255_255_255)

    edit:setChangeCallback(function()
        local message = edit:getText() or ""
        message = ToolsUtil:replaceNameStr(message)
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
            edit:setText(message)
            edit:closeKeyboard()
            return
        end

        -- 8个字上限
        if AvalonUtil:isUpLimiteStr(message, 160, 18) then
            message = AvalonUtil:getSubNameStrByLabel(message, 160, 18)
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110609))
            edit:setText(message)
            edit:closeKeyboard()
        end
    end)

    edit:setReturnCallback(function()
        local message = edit:getText() or ""
        if AvalonUtil:isUpLimiteStr(message, 160, 18) then
            message = AvalonUtil:getSubNameStrByLabel(message, 160, 18)
        end

        -- 表情
        if AvalonUtil:isEmoji(message) then
            UI.ScrollBar:createByText(UI.TEXT_1170936)

            if #self.finalTitleName == 0 then
                self.changeTitleBtn:disable()
                self.renameTitleDiamondNum:setFontColor(UI.FONT_COLOR_41_41_45)
            end
            return
        end
        message = ToolsUtil:replaceNameStr(message)
        
        -- 处理敏感字
        local mark = false
        message = ToolsUtil:roleNameFilter(message)
        message,mark = ToolsUtil:checkMaskword(message)
        if mark then
            UI.ScrollBar:createByText(UI.TEXT_1170415)
            edit:setText(message)

            if #self.finalTitleName == 0 then
                self.changeTitleBtn:disable()
                self.renameTitleDiamondNum:setFontColor(UI.FONT_COLOR_41_41_45)
            end
            return
        end

        -- 回车
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
        end

        -- 设置表现
        edit:setText(message)
        edit:setPlaceHolder(self.placeHolderTxt[edit.idx])

        -- 改名为空, 取消
        if (message == "") then
            UI.ScrollBar:createByTextID(1111721) -- "公会名称不能为空, 改名已取消"
            edit:setPlaceHolder(self.placeHolderTxt[edit.idx])

            if #self.finalTitleName == 0 then
                self.changeTitleBtn:disable()
                self.renameTitleDiamondNum:setFontColor(UI.FONT_COLOR_41_41_45)
            end
            return
        end

        -- 名字和现有相同, 取消
        if message == self.originTitleName[edit.idx] then
            UI.ScrollBar:createByTextID(1111722) -- "公会名称不能与当前重复, 改名已取消"

            if #self.finalTitleName == 0 then
                self.changeTitleBtn:disable()
                self.renameTitleDiamondNum:setFontColor(UI.FONT_COLOR_41_41_45)
            end
            return
        end

        local title = self.titles[edit.idx]
        local found = false
        for k, v in ipairs(self.finalTitleName) do
            if title == v.title then
                v.titleName = message
                found = true
                break
            end
        end

        if not found then
            local changed = {}
            changed.title = self.titles[edit.idx]
            changed.titleName = message
            table.insert(self.finalTitleName, changed)
        end

        self.changeTitleBtn:enable()

        if not Avalon.MathUtil:checkDiamonEnough(tonumber(self.renameTitleCost), GameDataManager:getInstance():getDiamond()) then
            self.renameTitleDiamondNum:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
    end)
end

function GuildRenameLayer:renameOver()
    self:closeWin()
end

function GuildRenameLayer:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_REFRESH_NAME, self,self.renameOver)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, self,self.renameOver)
end

function GuildRenameLayer:unregisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_REFRESH_NAME, self,self.renameOver)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_GUILD_CHANGE_TITLE_NAME, self,self.renameOver)
end
---------------------------------------
-- eo 事件处理 --

------------------------------------------------------------------------------
--author: yudong.li
--date	: 2020/02/28
--desc	: 现在已知只有6个令状，且扩展可能性不大，暂时不用使用scrollview
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GuildWritView = class("GuildWritView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_guild_writ.plist",
    "ui_town_guild_management.plist",
}

local COM_WIDTH = 951
local COM_HEIGHT = 592

function GuildWritView:ctor()
    GuildWritView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function GuildWritView:init( ... )
    self._iconAnims = {}
    self._lockTouch = false
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.guild", "Guild", false)
    GuildWritView.super.init(self, ... )
end

function GuildWritView:dtor()
    GuildWritView.super.dtor(self)
    self:unbindModel()
    self._iconAnims = {}
    self._lockTouch = false
    reload_script_file_mvc("app.modules.guild.GuildWritView")
end


function GuildWritView:onInitView()
     -- 背景图片
    require "app.ui.CommonBgLayer"
    local bg = UI.CommonBgLayer:create(true, true)
    bg:center()
    self:addChild(bg)

    local icon = UI.Image:create()
    icon:init("symbol_guild_tech_icon_medal.png")
    icon:leftUp(745, 78)
    self:addChild(icon)

    local number =  UI.NumberText:create(MasterDataManager:getGuildData().guildTeamMedal, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_WHITE, 10)
    number:setTextLeft()
    number:leftUp(780, 81)
    self:addChild(number, 4)
    self.medalNumber = number

    -- 分割线
    local splitter = UI.Image9:create()
    splitter:init("ui_scale9image_banner_line_dark2.png", CCRectMake(2,0,1,1), cc.size(859, 2))
    splitter:leftBottom(49, 480)
    self:addChild(splitter)

    self:initLeftView()
    self:initRightView()
    self:onSelectWrit(1)
end

function GuildWritView:initLeftView()
    local leftPanel = UI.Layout:create()
    leftPanel:init()
    leftPanel:setSize(266, 475)
    leftPanel:leftBottom(60, 12)
    self:addChild(leftPanel)
    self._leftPanel = leftPanel

    local bg =  UI.Image:create()
    bg:init("ui_guild_writ_paper_1.png")
    bg:centerBottom(-12)
    leftPanel:addChild(bg)

    local animation = UI.Animation:create()
    animation:init("effect_ui_general_guild_lingzhuang_zuo.json", "effect_ui_general_guild_lingzhuang_zuo.atlas", 1);
    animation:centerBottom(315)
    self._leftPanel:addChild(animation)
    animation:setAnimation("idle", false)
    self.mainAnim = animation
    animation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function(sender, event, target)
        if event.animation == "jihuo" then
            self._lockTouch = false
            self:refreshWritInfo()
        end
    end)

     -- 公会名字背景
    local nameBG = UI.Image:create()
    nameBG:init("ui_guild_mamagement_banner_name.png")
    nameBG:leftUp(40, 30)
    leftPanel:addChild(nameBG)

    local title = UI.Text:create()
    title:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    title:center()
    nameBG:addChild(title)
    self.title = title

    local desc = UI.Text:create()
    desc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_190_190_190)
    desc:setSize(236, 78)
    desc:centerBottom(100)
    desc:setLineSpacing(-2)
    leftPanel:addChild(desc)
    self.desc = desc

    local icon = UI.Image:create()
    icon:init("symbol_guild_tech_icon_medal.png")
    icon:leftBottom(105, 60)
    leftPanel:addChild(icon)
    self.itemIcon = icon

    local number = UI.Text:create()
    number:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_WHITE)
    number:leftBottom(135, 60)
    leftPanel:addChild(number)
    self.itemNumber = number

    local buyBtn = UI.Button:create()
    buyBtn:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    buyBtn:centerBottom(13)
    leftPanel:addChild(buyBtn, 1)
    buyBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:onPublishWrit()
    end)
    buyBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        self:onDiableClick()
    end)
    buyBtn:setText(UI.TEXT_1213951)
    self.buyBtn = buyBtn
end

function GuildWritView:initRightView()
    local rightPanel = UI.Layout:create()
    rightPanel:init()
    rightPanel:setSize(583, 475)
    rightPanel:leftBottom(330, 12)
    self:addChild(rightPanel)
    self._rightPanel = rightPanel

    local bg =  UI.Image:create()
    bg:init("ui_guild_writ_paper_2.png")
    bg:centerBottom(-8)
    rightPanel:addChild(bg)

    local list = MasterDataManager:getGuildData():getWritList()
    for i = 1, #list do
        local data = list[i]
        local panel = UI.Layout:create()
        panel:init()
        panel:setSize(175, 195)
        panel:setTouchEnable(true)
        panel:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            self:onSelectWrit(i)
        end)

        local x = i % 3
        x = x == 0 and 3 or x
        local y = math.ceil(i / 3)
        panel:leftUp((x - 1) * 185 + 20, (y - 1) * 220 + 30)
        rightPanel:addChild(panel)
        
        local animation = UI.Animation:create()
        animation:init("effect_ui_general_guild_lingzhuang_you.json", "effect_ui_general_guild_lingzhuang_you.atlas", 1);
        animation:center()
        panel:addChild(animation)
        animation:setTag(data.ID)
        animation:setAnimation("disable", false)

        local icon = UI.Image:create()
        icon:init(string.format("ui_guild_writ_metal_%d_0.png", data.ID))
        icon:center()
        panel:addChild(icon)
        icon:setName("ICON")
        table.insert(self._iconAnims, animation)
    end
end

function GuildWritView:onSelectWrit(index)
    if self._lockTouch then
        print("onSelectWrit _lockTouch = ", _lockTouch)
        return
    end
    local list = MasterDataManager:getGuildData():getWritList()
    local data = list[index]
    if data == nil then
        print("onSelectWrit data is null and index = ", index)
        return
    end 
    self._selectIndex = index
    for k, animation in ipairs(self._iconAnims) do
        local tempData = list[k]
        local isActive = tempData.actTime + tempData.duration > GameManager:getNormalServerTime()
        if k ~= index then
           
            if isActive then
                animation:setAnimation("enbale_idle", true)
                animation:getParent():getChildByName("ICON"):setSpriteName(string.format("ui_guild_writ_metal_%d_1.png", tempData.ID))
            else
                animation:setAnimation("disable", false)
                animation:getParent():getChildByName("ICON"):setSpriteName(string.format("ui_guild_writ_metal_%d_0.png", tempData.ID))
            end
            animation:getParent():setZOrder(1)
        else
            if isActive then
                animation:setAnimation("begin", false)
                animation:addAnimation("disable_idle", true)
                animation:getParent():getChildByName("ICON"):setSpriteName(string.format("ui_guild_writ_metal_%d_1.png", tempData.ID))
            else
                animation:setAnimation("begin", false)
                animation:addAnimation("idle", true)
                animation:getParent():getChildByName("ICON"):setSpriteName(string.format("ui_guild_writ_metal_%d_0.png", tempData.ID))
            end
            animation:getParent():setZOrder(10)
        end
    end
    self:refreshWritInfo()
end

function GuildWritView:refreshWritInfo()
    local list = MasterDataManager:getGuildData():getWritList()
    local data = list[self._selectIndex]
    if data == nil then
        print("refreshWritInfo data isNull and selectIndex ", self._selectIndex)
        return
    end
    local isActive = data.actTime + data.duration > GameManager:getNormalServerTime()
    self.title:setText(data.name)
    self.desc:setText(data.description)
    if self.icon == nil then
        local icon = UI.Image:create()
        if isActive then
            icon:init(string.format("ui_guild_writ_metal_%d_1.png", data.ID))
        else
            icon:init(string.format("ui_guild_writ_metal_%d_0.png", data.ID))
        end
        icon:centerBottom(240)
        self._leftPanel:addChild(icon)
        self.icon = icon
    else
        if isActive then
            self.icon:setSpriteName(string.format("ui_guild_writ_metal_%d_1.png", data.ID))
        else
            self.icon:setSpriteName(string.format("ui_guild_writ_metal_%d_0.png", data.ID))
        end
    end
    if isActive then
        self.mainAnim:setAnimation("jihuo_idle", true)
    else
        self.mainAnim:setAnimation("idle", false)
    end
    local nowGuildMedal = MasterDataManager:getGuildData().guildTeamMedal
    self.itemNumber:setText(string.format("x%d", data.cost[2]))
    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if isActive then
        self.buyBtn:disable()
        self.buyBtn:setText(UI.TEXT_1213951)
        self.itemNumber:hide()
        self.itemIcon:hide()
    elseif masterTitle == PublicDefine.GuildTitle.GuildTitle_Member then
        self.buyBtn:disable()
        self.buyBtn:setText(LanguageManager:getInstance():getLocalString(1112994))
        self.itemNumber:hide()
        self.itemIcon:hide()
    elseif data.cost[2] > nowGuildMedal then
        self.buyBtn:enable()
        self.buyBtn:setText(LanguageManager:getInstance():getLocalString(1112994))
        self.itemNumber:show()
        self.itemIcon:show()
        self.itemNumber:setFontColor(UI.FONT_COLOR_RED)
    else
        self.buyBtn:enable()
        self.buyBtn:setText(LanguageManager:getInstance():getLocalString(1112994))
        self.itemNumber:show()
        self.itemIcon:show()
        self.itemNumber:setFontColor(UI.FONT_COLOR_WHITE)
    end
    local width = self.itemIcon:getContentSize().width + self.itemNumber:getContentSize().width + 10
    self.itemIcon:leftBottom((260 - width) / 2, self.itemIcon:getBottom())
    self.itemNumber:leftBottom(self.itemIcon:getLeft() + self.itemIcon:getContentSize().width + 5, self.itemIcon:getBottom())
end

function GuildWritView:onPublishWrit()
    local list = MasterDataManager:getGuildData():getWritList()
    local data = list[self._selectIndex]
    local isActive = data.actTime + data.duration > GameManager:getNormalServerTime()
    if isActive then
        UI.ScrollBar:createByText(UI.TEXT_1213951)
        return
    end

    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member then
        UI.ScrollBar:createByTextID(1170046)
        return
    end

    local nowGuildMedal = MasterDataManager:getGuildData().guildTeamMedal
    if data.cost[2] > nowGuildMedal then
        UI.ScrollBar:createByText(UI.TEXT_110067 )
        return
    end
    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetGuildSystem:reqBuyWrit(MasterDataManager:getGuildData():getID(), data.ID)
end

function GuildWritView:onDiableClick()
    local list = MasterDataManager:getGuildData():getWritList()
    local data = list[self._selectIndex]
    local isActive = data.actTime + data.duration > GameManager:getNormalServerTime()
    if isActive then
        UI.ScrollBar:createByText(UI.TEXT_1213951)
        return
    end

    local masterTitle = GameDataManager:getInstance():getMasterGuildTitle()
    if masterTitle == PublicDefine.GuildTitle.GuildTitle_Member then
        UI.ScrollBar:createByTextID(1170046)
        return
    end

    local nowGuildMedal = MasterDataManager:getGuildData().guildTeamMedal
    if data.cost[2] > nowGuildMedal then
        UI.ScrollBar:createByText(UI.TEXT_110067 )
        return
    end
end

function GuildWritView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_WRIT_CHANGE, self, self.refreshOneWriteView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self, self.refreshMedal)
end

function GuildWritView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_WRIT_CHANGE, self, self.refreshOneWriteView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_DATA_CHNAGE_GUILD_MEDAL, self, self.refreshMedal)
end

function GuildWritView:refreshMedal()
    self.medalNumber:setText(MasterDataManager:getGuildData().guildTeamMedal)
end

function GuildWritView:refreshOneWriteView(writId)
    local list = MasterDataManager:getGuildData():getWritList()
    local index = 0
    local data = nil
    for k, v in ipairs(list) do
        if writId == v.ID then
            index = k
            data = v
        end
    end
    if data == nil then
        print("---error----refreshOneWriteView data is nil and writId = ", writId)
        return 
    end
    local isActive = data.actTime + data.duration > GameManager:getNormalServerTime()
    for k, animation in ipairs(self._iconAnims) do
        if writId == animation:getTag() and isActive then
            if index == self._selectIndex then
                self._lockTouch = true
                animation:setAnimation("enbale", false)
                animation:addAnimation("disable_idle", true)
                self.mainAnim:setAnimation("jihuo", false)
                self.mainAnim:addAnimation("jihuo_idle", true)
                Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                    if not tolua.isnull(animation) then
                        animation:getParent():getChildByName("ICON"):setSpriteName(string.format("ui_guild_writ_metal_%d_1.png", data.ID))
                    end
                end, 0.9)
            else
                animation:setAnimation("enbale", false)
                animation:addAnimation("enbale_idle", true)
            end
            break
        end
    end
    self.medalNumber:setText(MasterDataManager:getGuildData().guildTeamMedal)
end

return GuildWritView













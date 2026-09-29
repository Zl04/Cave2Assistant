-- GuildCell.lua
-- Author:zp
-- 2017年9月13日
-- Using:公会列表 cell

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local GuildCell = class("GuildCell", UI.HWBtnComponent)
UI.GuildCell = GuildCell

local COM_RES_LIST = {
    
}

local _width = 748
local _height = 89

function GuildCell:ctor(data,idx)
    GuildCell.super.ctor(
        self,UIType.GUILD_CELL,
        COM_RES_LIST,
        0,
        0
    )

    self.equipScore =  string.split(ConfigManager:getGuildEquipScore(), ";")
    for k,v in pairs(self.equipScore) do 
        self.equipScore[k] = tonumber(v)
    end

    -- self._bg = nil
    self._icon = nil
    self._guildNameLabel = nil
    self._presidentNameLabel = nil
    self._guildLevelLabel = nil
    self._guildNumLabel = nil
    self._joinIcon = nil
    self._joinLabel = nil
    self._statusButton = nil
    self._statusIcon = nil
    self._statusLabel = nil

    -- self._iconList = ConfigManager:getGuildIconList()
    -- self._memberList = ConfigManager:getGuildMemberList()

    self.rootLayer = nil;           --root节点
    self.data = data;
    self.idx =idx
    self:init();
end


local STATUS_LABEL = 67

-- public:
-- 初始化
function GuildCell:init()
    GuildCell.super.init(self)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_APPLY_RESULT, self, self.appJoinResult)
    
end

function GuildCell:dtor()
    GuildCell.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_APPLY_RESULT, self, self.appJoinResult)
end


-- 模版函数：初始化组建的视图
function GuildCell:onInitView()
    local bg = UI.Layout:create()
    bg:init()
    bg:setSize(_width, _height)
    bg:center()
    self:addChild(bg)

    -- 图标
    local icon = UI.Image:create()
    icon:init("ui_guild_icon_guilgicon1.png")
    icon:centerLeft(0)
    bg:addChild(icon)
    self._icon = icon
    self._icon:setTouchEnable(true)
    self._icon:addEventListener(UIEvent.COMPONENT_CLICK, self, function() 
        mvc.openPanel("GuildInfo", "GuildInfo", self.data.ID)
    end)
    
    -- 公会名字
    local guildNameLabel = UI.Text:create()
    guildNameLabel:init(self.data.name, UI.FONT_ARIAL, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    guildNameLabel:leftBottom(81,48)
    -- guildNameLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    bg:addChild(guildNameLabel, 10)
    self._guildNameLabel = guildNameLabel

    -- 会长名字
    local presidentNameLabel = UI.Text:create()
    presidentNameLabel:init(self.data.leaderName, UI.FONT_ARIAL, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    presidentNameLabel:leftBottom(81,20)
    -- guildNameLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    bg:addChild(presidentNameLabel, 10)
    self._presidentNameLabel = presidentNameLabel


    -- 公会等级
    local guildLevelLabel = UI.Text:create()
    guildLevelLabel:init(""..self.data.techTotalLv, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    guildLevelLabel:setTextHorizontalCenter()
    guildLevelLabel:setWidth(62)
    guildLevelLabel:centerLeft(310 - 31)
    bg:addChild(guildLevelLabel, 10)
    self._guildLevelLabel = guildLevelLabel

    -- 公会人数
    local guildNumLabel = UI.Text:create()
    guildNumLabel:init("0/0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    guildNumLabel:setTextHorizontalCenter()
    guildNumLabel:setSize(100, 0)
    guildNumLabel:centerLeft(406 - 50)
    bg:addChild(guildNumLabel, 10)
    self._guildNumLabel = guildNumLabel

    -- 入会要求
    local joinIcon = UI.Image:create()
    joinIcon:init("symbol_character_hero_power.png")
    joinIcon:centerLeft(493 - joinIcon:getContentSize().width/2)
    bg:addChild(joinIcon)
    self._joinIcon = joinIcon

    local joinLabel = UI.Text:create()
    joinLabel:init(""..self.data.joinEquipScoreLmt, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    joinLabel:setTextHorizontalCenter()
    joinLabel:setSize(0,0)
    joinLabel:centerLeft(544)
    bg:addChild(joinLabel, 10)
    self._joinLabel = joinLabel

    -- 状态
    local statusButton = UI.Button:create()
    statusButton:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
    statusButton:centerLeft(606)
    bg:addChild(statusButton)
    statusButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        -- 处理相关的逻辑
        local master = RoleDataManager:getMaster()
        -- 保存申请了哪些人
        MasterDataManager:insertRepeatHandleData(RepeatHandleType.GUILD_APPLY_JOIN, self.data.ID, true)

        Net.NetGuildSystem:reqJoinGuild(master:getPK(), self.data.ID)

        self:reload(self.data, self.idx)
    end)
    self._statusButton = statusButton

    local statusBg = UI.Image:create()
    statusBg:init("ui_information_banner_receive.png")
    statusBg:centerLeft(606 + 6)
    statusBg:hide()
    bg:addChild(statusBg)
    self._statusBg = statusBg
    -- 已完成文字
    local statusText = UI.Text:create()  
    statusText:init(UI.TEXT_111036, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_80_5_5)
    statusText:center()
    statusText:setRotationSkewX(-9.0)
    statusText:setRotationSkewY(-9.0)
    statusBg:addChild(statusText)
    self._statusText = statusText

    STATUS_LABEL = 748 - 674
    local statusIcon = UI.Image:create()
    statusIcon:init("symbol_character_hero_power.png")
    statusIcon:centerRight(STATUS_LABEL)
    bg:addChild(statusIcon, 10)
    self._statusIcon = statusIcon

    local powerNoEngouh = UI.Text:create()
    powerNoEngouh:init(LanguageManager:getInstance():getLocalString(1110528), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
    powerNoEngouh:centerLeft(statusIcon:getContentSize().width + 4)
    statusIcon:addChild(powerNoEngouh)
    statusIcon:centerLeft(606 + 70 + ( - (statusIcon:getContentSize().width + powerNoEngouh:getContentSize().width + 4)/2))


    local statusLabel = UI.Text:create()
    statusLabel:init("0/0", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    statusLabel:setTextHorizontalCenter()
    statusLabel:setSize(0, 0)
    -- statusLabel:centerRight(STATUS_LABEL)
    statusLabel:center()
    statusButton:addChild(statusLabel, 10)
    self._statusLabel = statusLabel

    -- 添加下边界线
    local lineOffsetX = 0
    local lineOffsetY = 1
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_guild_create_line.png")
    lineUpImage:setContentSize(741, 1)
    lineUpImage:setCapInsets(CCRectMake(0,0,1,1))
    lineUpImage:setPosition(cc.p(lineOffsetX + lineUpImage:getContentSize().width/2, lineOffsetY))
    bg:addChild(lineUpImage, 4)

    self:reload(self.data, self.idx)
end

-- 模版函数：更新组建的视图
function GuildCell:onUpdateView()
end

function GuildCell:appJoinResult(guildID)
    if(self and self.data) then
        print("GuildCell:appJoinSuccess" , guildID, self.data.ID)
        if(self.data.ID == guildID) then
            print("GuildCell:appJoinSuccess" , guildID)
            self:reload(self.data, self.idx)
        end
    end
end

function GuildCell:reload(data,idx)
    if(data) then
        self.data = data
    end

    self.idx = idx

    if(self.data) then
        self._icon:setSpriteName(GameDataManager:getInstance():getGuildIconForIconID(self.data.iconID))

        self._guildNameLabel:setText(self.data.name)

        self._presidentNameLabel:setText(LanguageManager:getInstance():getLocalString(1110530)..self.data.leaderName);

        self._guildLevelLabel:setText(""..self.data.techTotalLv)

        -- 计算当前是否已经满员，修改颜色
        local curMemberNum = tonumber(self.data.curMemberNum)
        local totalNum = tonumber(GameDataManager:getInstance():getGuildMemberConfigForLevel(self.data.techTotalLv))
        self._guildNumLabel:setText(curMemberNum.."/"..totalNum)
        if(curMemberNum >= totalNum) then
            self._guildNumLabel:setFontColor(UI.FONT_COLOR_80_5_5)
        else
            self._guildNumLabel:setFontColor(UI.FONT_COLOR_41_41_45)
        end

        local scoreLmt = 0
        -- 判断加入条件逻辑处理
        if(self.data.joinEquipScoreLmt ~= 0) then
            self._joinIcon:setVisible(true)
            for k, v in pairs(self.equipScore) do 
                if(self.data.joinEquipScoreLmt == k-1) then
                    self._joinLabel:setText(v.."+")
                    scoreLmt = tonumber(v)
                end
            end
            self._joinLabel:centerLeft(544)
        else
            self._joinLabel:setText(LanguageManager:getInstance():getLocalString(1110608))
            self._joinIcon:setVisible(false)
            self._joinLabel:centerLeft(534)
        end
        -- -- 刷新位置信息
        -- self._joinIcon:centerRight(213 + self._guildNumLabel:getContentSize().width/2)
        -- self._joinLabel:centerRight(213 - self._joinIcon:getContentSize().width/2)

        local master = RoleDataManager:getMaster()
        local equipScore = master:getCombatScore()

        local wasJoin = MasterDataManager:judgeJoinApply(self.data.ID)

        local repeatDatas = MasterDataManager:getRepeatHandleData(RepeatHandleType.GUILD_APPLY_JOIN)

        self._statusButton:enable()
        self._statusText:setVisible(false)
        self._statusBg:setVisible(false)
        if(wasJoin) then
            -- 已申请
            self._statusButton:setVisible(false)
            self._statusIcon:setVisible(false)
            self._statusLabel:setVisible(false)

            self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1110527))
            self._statusLabel:setFontColor(UI.FONT_COLOR_41_41_45)

            -- 刷新位置
            self._statusLabel:centerRight(STATUS_LABEL)

            self._statusText:setVisible(true)
            self._statusBg:setVisible(true)
            self._statusBg:setSpriteName("ui_information_banner_receive.png")
            self._statusText:setFontColor(UI.FONT_COLOR_15_85_71)
            self._statusText:setText(LanguageManager:getInstance():getLocalString(1110527))
        else
            if(equipScore < scoreLmt) then
                -- 战力值不足
                self._statusButton:setVisible(false)
                self._statusIcon:setVisible(true)
            else
                -- 刷新对于公会的状态
                if(totalNum <= curMemberNum) then
                    -- 当前已经满员
                    self._statusButton:setVisible(false)
                    self._statusIcon:setVisible(false)
                    self._statusLabel:setVisible(false)

                    self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1110526))
                    self._statusLabel:setFontColor(UI.FONT_COLOR_80_5_5)
                    self._statusLabel:centerRight(STATUS_LABEL)

                    self._statusText:setVisible(true)
                    self._statusBg:setVisible(true)
                    self._statusBg:setSpriteName("ui_information_banner_unfinished1.png")
                    self._statusText:setFontColor(UI.FONT_COLOR_80_5_5)
                    self._statusText:setText(LanguageManager:getInstance():getLocalString(1110526))
                else 
                    if(repeatDatas and repeatDatas[self.data.ID]) then
                        -- 已经申请还没有返回
                        self._statusButton:setVisible(true)
                        self._statusButton:disable()
                        self._statusIcon:setVisible(false)
                        self._statusLabel:setVisible(true)

                        self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1110525))
                        self._statusLabel:setFontColor(UI.FONT_COLOR_41_41_45)
                        -- self._statusLabel:centerRight(STATUS_LABEL)
                    else 
                        -- 可以申请
                        self._statusButton:setVisible(true)
                        self._statusIcon:setVisible(false)
                        self._statusLabel:setVisible(true)

                        self._statusLabel:setText(LanguageManager:getInstance():getLocalString(1110525))
                        self._statusLabel:setFontColor(UI.FONT_COLOR_50_50_44)
                        -- self._statusLabel:centerRight(STATUS_LABEL)
                    end
                end
            end
        end
    end
end


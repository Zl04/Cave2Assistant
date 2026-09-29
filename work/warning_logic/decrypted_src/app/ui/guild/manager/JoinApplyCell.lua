-- JoinApplyCell.lua
-- Author:zp
-- 2017年9月21日
-- Using:申请 cell

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")

local GuildTitle = PublicDefine.GuildTitle

UI = UI or {}
local JoinApplyCell = class("JoinApplyCell", UI.HWBtnComponent)
UI.JoinApplyCell = JoinApplyCell

local COM_RES_LIST = {
    --  
    "ui_town_guild_management.plist",
    
}

local _width = 249
local _height = 106

function JoinApplyCell:ctor(data,idx)
    JoinApplyCell.super.ctor(
        self,UIType.JOIN_APPLY_CELL,
        COM_RES_LIST,
        0,
        0
    )

    self.data = data;
    self.idx =idx
    self:init();
end


local STATUS_LABEL = 65

-- public:
-- 初始化
function JoinApplyCell:init()
    JoinApplyCell.super.init(self)
end

-- 模版函数：初始化组建的视图
function JoinApplyCell:onInitView()

    -- 组件对象
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(_width, _height)
    contentLayout:center()
    self:addChild(contentLayout)


    local iconButton = UI.Button:create()
    iconButton:init("ui_playerstate_me_black_up.png", "ui_playerstate_me_black_up.png")
    iconButton:centerLeft(12)
    iconButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
         if(RoleDataManager:getMasterPK() ~= self.data.PK ) then
            local data = {}
            data.PK = self.data.PK 
            -- 这里没有状态，默认都在线
            data.loginStatus = PublicDefine.HERO_LOGIN_STATUS.HERO_LOGIN_STATUS_ONLINE

            local pos = iconButton:convertToWorldSpace(cc.p(0, 0))
            
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_HERO_HEAD_TIPS, data,  pos.x + iconButton:getContentSize().width +20, pos.y+70)
        end
    end)

    contentLayout:addChild(iconButton)
    self._iconButton = iconButton

    -- 添加蒙版效果
    local circleImage = UI.Image:create()
    circleImage:init("ui_playerstate_me_black_01.png")
    circleImage:center()
    iconButton:addChild(circleImage, 3)

    -- 角色等级
    -- 等级背景图  
    self._grade_BG = UI.Image:create()
    self._grade_BG:init("ui_information_headframe_grade.png")
    self._grade_BG:leftBottom(-10,-4)
    iconButton:addChild(self._grade_BG, 100) 

    if self.data.reincarntionLv > 0 then
        local headFrame, levelFrame = RoleDataManager:getHeadFrameByReinLv(self.data.reincarntionLv)
        circleImage:setSpriteName(headFrame)
        self._grade_BG:setSpriteName(levelFrame)
    end

    -- 等级
    local showLV = RoleDataManager:getUIShowLvByOtherData(self.data.lv, self.data.reincarntionLv)--self.data:getUIShowLv()--self.data.lv
    self._lvLabel = UI.Text:create()
    self._lvLabel:init(showLV.."",UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_189_167_136)
    self._lvLabel:setSize(100, 50)
    self._lvLabel:center()
    self._lvLabel:setTextCenter()
    self._grade_BG:addChild(self._lvLabel,101)
    
    -- 玩家名字
    local nameLabel = UI.Text:create()
    nameLabel:init(self.data.name, UI.FONT_ARIAL, UI.FONT_SIZE_16PX, UI.FONT_COLOR_77_77_84)
    nameLabel:leftBottom(90, 80)
    nameLabel:setSize(156,0)
    nameLabel:setTextLeft()
    -- guildNameLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    contentLayout:addChild(nameLabel, 10)
    self._userNameLabel = nameLabel

    -- 分割线
    local bottomBlackSide = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_character.png", cc.rect(0,0,1,1))
    bottomBlackSide:setContentSize(cc.size(159, 1))  
    bottomBlackSide:setPosition(cc.p(90 +bottomBlackSide:getContentSize().width/2, 68))
    contentLayout:addChild(bottomBlackSide)

    -- 玩家装备评分值
    local equipCoreIcon = UI.Image:create()
    equipCoreIcon:init("symbol_character_hero_power.png")
    equipCoreIcon:leftBottom(91, 54 - equipCoreIcon:getContentSize().height/2)
    contentLayout:addChild(equipCoreIcon)
    
    local scoreLabel = UI.Text:create()
    scoreLabel:init(self.data.equipScore.."", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_120_115_118)
    scoreLabel:centerLeft(equipCoreIcon:getContentSize().width + 5)
    -- guildNameLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
    equipCoreIcon:addChild(scoreLabel, 10)
    self._equipScore = scoreLabel

    -- 同意加入按钮
    local okButton = UI.Button:create()
    okButton:init("ui_btn_yes3_0.png", "ui_btn_yes3_1.png", "ui_btn_yes3_2.png")
    okButton:rightBottom(0,9)
    okButton:setTouchEnable(true)
    okButton:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        print("JoinApplyCell click ok")
        MasterDataManager:insertRepeatHandleData(RepeatHandleType.GUILD_DEAL_JOIN_REQ_OK, self.data.PK, true)
        Net.NetGuildSystem:dealJoinReq(self.data.PK, true)
        self:reload(self.data, self.idx)
    end)
    contentLayout:addChild(okButton)
    self._okButton = okButton

    -- 拒绝加入按钮
    local cancelButton = UI.Button:create()
    cancelButton:init("ui_btn_no3_0.png", "ui_btn_no3_1.png", "ui_btn_no3_2.png")
    cancelButton:leftBottom(90,9)
    cancelButton:setTouchEnable(true)
    cancelButton:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, obj)
        print("JoinApplyCell click cancel")
        Net.NetGuildSystem:dealJoinReq(self.data.PK, false)
    end)
    contentLayout:addChild(cancelButton)
    self._cancelButton = cancelButton

    -- 底部分割线
    local bottomBlackSide = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_character.png", cc.rect(0,0,1,1))
    bottomBlackSide:setContentSize(cc.size(249, 1))  
    bottomBlackSide:setPosition(cc.p(125, 1))
    contentLayout:addChild(bottomBlackSide)

    self:reload(self.data, self.idx)
end

-- 模版函数：更新组建的视图
function JoinApplyCell:onUpdateView()
end

function JoinApplyCell:reload(data,idx)
    if(data) then
        self.data = data
    end
    self.type = type
    self.idx = idx

    if(self.data) then
        -- 处理头像的生成
        local  templateIDS = {}
        Avalon.WidgetUtil:getHeadByData(self, self.data.sex, self.data.faceDecodeID, templateIDS, self,handler(self,function(obj, pic)
            if self._iconButton and not tolua.isnull(self._iconButton) then
                -- picName:setVisible(false)
                self._iconButton:removeChildByName("heorIcon", true)
                -- pic:setPosition(63, 68)
                pic:setPosition(38, 38)
                pic:setName("heorIcon")
                self._iconButton:addChild(pic,2)
            end
        end))

        local repeatHandleData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GUILD_DEAL_JOIN_REQ_OK)
        if(repeatHandleData and repeatHandleData[self.data.PK]) then
            self._cancelButton:disable()
            self._okButton:disable()
        else
            self._cancelButton:enable()
            self._okButton:enable()
        end

        self._userNameLabel:setText(self.data.name)
        self._equipScore:setText(self.data.equipScore)
        local showLV = RoleDataManager:getUIShowLvByOtherData(self.data.lv, self.data.reincarntionLv)
        self._lvLabel:setText(showLV)

        self:refreshPosition()
    end
end



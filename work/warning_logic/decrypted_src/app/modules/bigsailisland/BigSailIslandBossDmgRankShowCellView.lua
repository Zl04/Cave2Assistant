------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandBossDmgRankShowCellView = class("BigSailIslandBossDmgRankShowCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 361
local COM_HEIGHT = 90

local rankImgName = {"ui_rankinglist_gold.png", "ui_rankinglist_silver.png", "ui_rankinglist_copper.png"}

function BigSailIslandBossDmgRankShowCellView:ctor()
    BigSailIslandBossDmgRankShowCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function BigSailIslandBossDmgRankShowCellView:init( data, ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandBossDmgRankShowCellView.super.init(self, ... )

    if data then
        self._data = data
    end
end

function BigSailIslandBossDmgRankShowCellView:dtor()
    BigSailIslandBossDmgRankShowCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandBossDmgRankShowCellView")
end


function BigSailIslandBossDmgRankShowCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_greatnavigation_list_2.png")
    centerBg:center()
    contentLayout:addChild(centerBg)
end

function BigSailIslandBossDmgRankShowCellView:onUpdateView()
    if not self._data then
        return
    end


    self:addCellView(self._data)
end

function BigSailIslandBossDmgRankShowCellView:getData()
    return self._data
end

function BigSailIslandBossDmgRankShowCellView:addCellView(data)
    -- 排名
    if data.selfRank > #rankImgName then
        local rankNum = UI.Text:create();
        rankNum:init(tostring(data.selfRank), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:centerLeft(30, 0);
        self.contentLayout:addChild(rankNum);
    else
        local picRankNum = UI.Image:create()
        picRankNum:init(rankImgName[data.selfRank])
        picRankNum:centerLeft(0, 0);
        picRankNum:setName("picRankNum")
        self.contentLayout:addChild(picRankNum);
        picRankNum:setScale(0.7)
    end

    -- 头像
    local iconButton = UI.Button:create()
    iconButton:init("ui_information_headframe_bottom.png", "ui_information_headframe_bottom.png")
    iconButton:centerLeft(60, 0)
    iconButton:setScale(0.8)
    iconButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        self:showHeroDetail()
    end)
    self.contentLayout:addChild(iconButton)
    self._iconButton = iconButton

    local heroData = Data.HeroData:create()
    heroData:setNickName("")
    heroData:setLevel(0)
    heroData:setSex(data.sex or PublicDefine.HERO_SEX.MALE)
    heroData:setFaceDecodeID(data.faceId)

    Avalon.WidgetUtil:getHead(self, heroData, {},self,handler(self,function(self,pic)
        if self._iconButton and not tolua.isnull(self._iconButton) then
            pic:setPosition(42, 35)
            pic:setScale(0.9)
            self._iconButton:addChild(pic, 2) 
        end
    end))

    --  昵称
    local presidentName = UI.Text:create()
    presidentName:init(tostring(data.rolename), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    presidentName:center(25, -13)
    presidentName:setTextLeftUp()
    self.contentLayout:addChild(presidentName)



    -- 累计伤害
    local totalTxt = UI.Text:create()
    totalTxt:init(UI.TEXT_226203, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    totalTxt:center(20, 23)
    totalTxt:setTextLeftUp()
    self.contentLayout:addChild(totalTxt)

    local totalNum = UI.Text:create()
    totalNum:init(tostring(AvalonUtil:getSimpleNumber(data.totalOutput, 5)), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_209_171_68)
    totalNum:center(120, 23)
    totalNum:setTextLeftUp()
    self.contentLayout:addChild(totalNum)

end

function BigSailIslandBossDmgRankShowCellView:showHeroDetail()
    if self._data.pk ~= RoleDataManager:getMasterPK() then
        Net.NetRoleSystem:heroDetailRequest(self._data.pk, 1,nil,nil,PublicDefine.RankType.RANKTYPE_BIGSAIL_BOSS_DAMAGE)
    end
end

function BigSailIslandBossDmgRankShowCellView:bindModel()

end


function BigSailIslandBossDmgRankShowCellView:unbindModel()

end





return BigSailIslandBossDmgRankShowCellView













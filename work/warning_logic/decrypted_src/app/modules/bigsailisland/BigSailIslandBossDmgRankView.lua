------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandBossDmgRankView = class("BigSailIslandBossDmgRankView", UI.HWBtnComponent)

require "app.modules.bigsailisland.BigSailIslandBossDmgRankCell"
require "app.modules.bigsailisland.BigSailIslandBoatAwardCell"

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    -- "ui_bg_paper3.plist",
    -- "ui_common_btn.plist",
    -- "ui_town_navigation.plist",
    "ui_town_ranking.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local RANK_CELL_W = 695;
local RANK_CELL_H = 72;

local BTN_STATE = {
    AWARD_BTN = 1,
    RANK_BTN = 2
}

local rankImgName = {"ui_rankinglist_gold.png", "ui_rankinglist_silver.png", "ui_rankinglist_copper.png"}

function BigSailIslandBossDmgRankView:ctor()
    BigSailIslandBossDmgRankView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.btnState = BTN_STATE.RANK_BTN
    self.verticalNum = 1 
    self.horizontalNum = 3
    self.awardData = {}
    self.myRankData = {}
    self.data = nil
end

function BigSailIslandBossDmgRankView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandBossDmgRankView.super.init(self, ... )
end

function BigSailIslandBossDmgRankView:dtor()
    BigSailIslandBossDmgRankView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandBossDmgRankView")
end


function BigSailIslandBossDmgRankView:initData()
    local config = ConfigManager:getNavigationBossGroupByID(1)
    local rankInterval = config.rankInterval
    local itemId = config.itemId
    local itemNum = config.itemNum

    local rankList = string.split(rankInterval, ";") 
    local itemList = string.split(itemId, ";")
    local itemNumList = string.split(itemNum, ";")

    for k,v in pairs(rankList) do
        self.awardData[k] = {}
        self.awardData[k].limt = v
    end

    for k,v in pairs(itemList) do
        self.awardData[k].itemId = v
        self.awardData[k].itemNum = itemNumList[k]
    end

    -- local RankData = {selfRank = 1, rolename = "阿萨德55555", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000}
    -- self.myRankData = RankData
end


function BigSailIslandBossDmgRankView:onInitView()
    self:initData()
    -- self.data = {
    --     {selfRank = 1, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,   totalOutput = 10000000000},
    --     {selfRank = 2, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 3, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 4, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 5, rolename = "阿萨德55555", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 6, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 7, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 8, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 9, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 10, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    --     {selfRank = 11, rolename = "阿萨德", faceId = 1002, sex = PublicDefine.HERO_SEX.MALE,  totalOutput = 10000},
    -- }

    local bg1  = UI.Image:create()
    bg1:init("ui_bg_box1.png")
    bg1:center(50, 0)
    self:addChild(bg1)

    local bg2  = UI.Image:create()
    bg2:init("ui_bg_paper1.png")
    bg2:center(50, 0)
    self:addChild(bg2)

    local bgTitle  = UI.Image:create()
    bgTitle:init("ui_bg_title.png")
    bgTitle:center(50, -257)
    self:addChild(bgTitle)

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_110047, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_207_182_89)
    titleTxt:center(10, 0)
    bgTitle:addChild(titleTxt)

    self.rankTitleLayer = UI.Layout:create();
    self.rankTitleLayer:init()
    self.rankTitleLayer:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(self.rankTitleLayer)

    self.awardTitleLayer = UI.Layout:create();
    self.awardTitleLayer:init()
    self.awardTitleLayer:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(self.awardTitleLayer)

    local bgTree  = UI.Image:create()
    bgTree:init("ui_bg_tree.png")
    bgTree:center(-313, 53)
    self:addChild(bgTree)

    local trophyTree  = UI.Image:create()
    trophyTree:init("ui_bg_tree.png")
    trophyTree:center(0, 0)
    bgTree:addChild(trophyTree)

    local rattanTree  = UI.Image:create()
    rattanTree:init("ui_bg_rattan2.png")
    rattanTree:center(415, 180)
    self:addChild(rattanTree)

    -- 奖励
    local awardBtn = UI.Button:create()
    awardBtn:init("ui_btn_gray2_0.png", "ui_btn_gray2_0.png", "ui_btn_gray2_0.png")
    awardBtn:center(438, -196)
    awardBtn:closeClickScale()
    awardBtn:setText(UI.TEXT_1212901)
    awardBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    awardBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:choseBtn(BTN_STATE.AWARD_BTN)
    end)
    self:addChild(awardBtn)
    self.awardBtn = awardBtn

    -- 排行
    local rankBtn = UI.Button:create()
    rankBtn:init("ui_btn_gray2_0.png", "ui_btn_gray2_0.png", "ui_btn_gray2_0.png")
    rankBtn:center(438, -125)
    rankBtn:closeClickScale()
    rankBtn:setText(UI.TEXT_110044)
    rankBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    rankBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        self:choseBtn(BTN_STATE.RANK_BTN)
    end)
    self:addChild(rankBtn)
    self.rankBtn = rankBtn

    self._tableView = UI.TableView.new({}, 600, 300)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:center(55,-10);
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(true);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return 600, 90
    end);

    self._tableView:onUpdateCells(function (table, idx)
        -- if idx + 1 >= self.myRankData.selfRank then
        --     if self.myRankLayer then
        --         self.myRankLayer:hide()
        --     end
        -- elseif idx + 1 < self.myRankData.selfRank - 3 then
        --     if self.myRankLayer then
        --         self.myRankLayer:show()
        --     end
        -- end

        local cell = table:dequeueCell();
        xpcall(function()
            if self.btnState == BTN_STATE.RANK_BTN then
                cell = UI.BigSailIslandBossDmgRankCell.new();
                cell:init(self.data[idx + 1]);
                cell:onUpdateView()
            else
                cell = UI.BigSailIslandBoatAwardCell.new();
                cell:init(self.awardData[idx + 1]);
                cell:onUpdateView()
            end
        end,
        function(e) 
            printError("------------------------DreamRankLayer:tableCellAtIndex-----------------error")
        end, 1);
        
        return cell
    end);

    self._tableView:onUpdateCellNumbers(function ()
        if self.btnState == BTN_STATE.RANK_BTN then
            return table.nums(self.data);
        else
            return table.nums(self.awardData);
        end
        
    end);

    self._tableView:onTableCellTouched(function(table, cell)
        print("BigSailIslandBossDmgRankView:tableCellTouched",cell:getIdx());
    end);

    self:addChild(self._tableView)

    if self.data then
        self:choseBtn(BTN_STATE.RANK_BTN)
        self:freshMyRank()
    else
        local isPreWeek = mvc.bigSailIslandModel:getBossRankIsPreWeek()
        Net.NetRankSystem:requestRankList(PublicDefine.RankType.RANKTYPE_BIGSAIL_BOSS_DAMAGE, isPreWeek)
    end
    -- self:freshMyRank()
end

function BigSailIslandBossDmgRankView:freshMyRank()
    if self.myRankLayer then
        self.myRankLayer:removeAllChildren()
        self:removeChildByName("rankLayer")
    end
    local rankLayer = UI.Layout:create()
    rankLayer:init()
    rankLayer:setSize(576, 90)
    rankLayer:center(45, 200)
    rankLayer:setName("rankLayer")
    self.myRankLayer = rankLayer 

    local data = self.myRankData

    -- 排名
    if data.selfRank == 0 then
        local rankNum = UI.Text:create();
        rankNum:init(UI.TEXT_1212289, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:center(-240, -13);
        rankLayer:addChild(rankNum);
    elseif data.selfRank > #rankImgName then
        local rankNum = UI.Text:create();
        rankNum:init(tostring(data.selfRank), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45);
        rankNum:center(-240, -13);
        rankLayer:addChild(rankNum);
    else
        local picRankNum = UI.Image:create()
        picRankNum:init(rankImgName[data.selfRank])
        picRankNum:center(-240, -13);
        picRankNum:setName("picRankNum")
        rankLayer:addChild(picRankNum);
    end

    --头像    
    local iconButton = UI.Button:create()
    iconButton:init("ui_information_headframe_bottom.png", "ui_information_headframe_bottom.png")
    iconButton:center(-80, -13)
    iconButton:setScale(0.8)
    rankLayer:addChild(iconButton)
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

    -- 名字
    local presidentName = UI.Text:create()
    presidentName:init(tostring(data.rolename), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    presidentName:center(80, -13)
    presidentName:setTextLeftUp()
    rankLayer:addChild(presidentName)

    -- 总产量
    local totalNum = UI.Text:create()
    totalNum:init(tostring(data.totalOutput), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    totalNum:center(230, -13)
    totalNum:setTextLeftUp()
    rankLayer:addChild(totalNum)

    self:addChild(rankLayer)
end

function BigSailIslandBossDmgRankView:choseBtn(btnState)
    if btnState == BTN_STATE.RANK_BTN then
        self.btnState = BTN_STATE.RANK_BTN
        self.rankBtn:setNormal("ui_btn_gray2_1.png") 
        self.awardBtn:setNormal("ui_btn_gray2_0.png")

        self.rankBtn:setFontColor(UI.FONT_COLOR_207_182_89)
        self.awardBtn:setFontColor(UI.FONT_COLOR_50_50_44)

        self._tableView:reloadData(true, true)
        self:refreshRankTopTitile()
    else
        self.btnState = BTN_STATE.AWARD_BTN
        self.rankBtn:setNormal("ui_btn_gray2_0.png")
        self.awardBtn:setNormal("ui_btn_gray2_1.png")

        self.rankBtn:setFontColor(UI.FONT_COLOR_50_50_44)
        self.awardBtn:setFontColor(UI.FONT_COLOR_207_182_89)

        self._tableView:reloadData(true, true)
        self:refreshAwardTopTitile()
    end

end

function BigSailIslandBossDmgRankView:refreshRankTopTitile()
    self.rankTitleLayer:removeAllChildren()


    local rankingTxt = UI.Text:create()
    rankingTxt:init(UI.TEXT_1212293, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rankingTxt:center(-200, -190)
    self.rankTitleLayer:addChild(rankingTxt)

    local headTxt = UI.Text:create()
    headTxt:init(UI.TEXT_1212015, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    headTxt:center(-40, -190)
    self.rankTitleLayer:addChild(headTxt)

    local nameText = UI.Text:create()
    nameText:init(UI.TEXT_1212295, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    nameText:center(120, -190)
    self.rankTitleLayer:addChild(nameText)

    local outputTxt = UI.Text:create()
    outputTxt:init(UI.TEXT_226203, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    outputTxt:center(270, -190)
    self.rankTitleLayer:addChild(outputTxt)

    local lineTitle  = UI.Image:create()
    lineTitle:init("ui_greatnavigation_line_4.png")
    lineTitle:center(50, -170)
    self.rankTitleLayer:addChild(lineTitle)

    if self.myRankLayer then
        self.myRankLayer:show()
    end
end

function BigSailIslandBossDmgRankView:refreshAwardTopTitile()
    self.rankTitleLayer:removeAllChildren()
    local rankingTxt = UI.Text:create()
    rankingTxt:init(UI.TEXT_1212293, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rankingTxt:center(-200, -190)
    self.rankTitleLayer:addChild(rankingTxt)

    local headTxt = UI.Text:create()
    headTxt:init(UI.TEXT_1212901, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    headTxt:center(120, -190)
    self.rankTitleLayer:addChild(headTxt)

    local lineTitle  = UI.Image:create()
    lineTitle:init("ui_greatnavigation_line_4.png")
    lineTitle:center(50, -170)
    self.rankTitleLayer:addChild(lineTitle)

    if self.myRankLayer then
        self.myRankLayer:hide()
    end
end

function BigSailIslandBossDmgRankView:freshData(data)
    if data.rankType ~= PublicDefine.RankType.RANKTYPE_BIGSAIL_BOSS_DAMAGE then
        return 
    end
    self.data = {}
    for k,v in pairs(data.rankList) do
        self.data[k] = {}
        self.data[k].pk = v.pk
        self.data[k].selfRank = v.rank
        self.data[k].rolename = ToolsUtil:replaceShowNickNameStr(v.nickName)--v.nickName
        self.data[k].faceId = v.faceId
        self.data[k].sex = v.sex
        self.data[k].totalOutput = v.score
    end
    self:choseBtn(self.btnState)

    -- 自己的公会排名信息
    self.myRankData.selfRank = data.selfRank
    self.myRankData.rolename = ToolsUtil:replaceShowNickNameStr(RoleDataManager:getMaster():getNickName())
    self.myRankData.faceId = RoleDataManager:getMaster():getFaceDecodeID();
    self.myRankData.sex = RoleDataManager:getMaster():getSex();
    self.myRankData.totalOutput = data.selfScore

    self:freshMyRank()
end

function BigSailIslandBossDmgRankView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_LIST, self, self.freshData)
end

function BigSailIslandBossDmgRankView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RANK_LIST, self, self.freshData)
end





return BigSailIslandBossDmgRankView













------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")
local BigSailIslandRankView = class("BigSailIslandRankView", UI.HWBtnComponent)

require "app.modules.bigsailisland.BigSailIslandBoatRankCell"
require "app.modules.bigsailisland.BigSailIslandBoatAwardCell"

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_bg_paper3.plist",
    "ui_common_btn.plist",
    "ui_town_navigation.plist",
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

function BigSailIslandRankView:ctor()
    BigSailIslandRankView.super.ctor(
    	self,
    	UI.Type.BIGSAIL_OUTPUT_RANK,
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

function BigSailIslandRankView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandRankView.super.init(self, ... )
end

function BigSailIslandRankView:dtor()
    BigSailIslandRankView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandRankView")
end

function BigSailIslandRankView:initData()
    local config = ConfigManager:getAllNavigationGeneralConfigData()
    local rankInterval = config[1].rankInterval
    local itemId = config[1].itemId
    local itemNum = config[1].itemNum

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

    -- local RankData = {selfRank = 1, rolename = "阿萨德55555", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000}
    -- self.myRankData = RankData
end


function BigSailIslandRankView:onInitView()
    self:initData()
    -- self.data = {
    --     {selfRank = 1, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000000000},
    --     {selfRank = 2, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 3, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 4, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 5, rolename = "阿萨德55555", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 6, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 7, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 8, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 9, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 10, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
    --     {selfRank = 11, rolename = "阿萨德", iconID = 1002, techLevel = 5, personNum = 10,  totalOutput = 10000},
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
    titleTxt:init(UI.TEXT_110047, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 207, g = 182, b = 89})
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
                cell = UI.BigSailIslandBoatRankCell.new();
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
        print("BigSailIslandRankView:tableCellTouched",cell:getIdx());
    end);

    self:addChild(self._tableView)

    if self.data then
        self:choseBtn(BTN_STATE.RANK_BTN)
        self:freshMyRank()
    else
        Net.NetRankSystem:requestRankList(PublicDefine.RankType.RANKTYPE_BIGSAIL_OUTPUT, false)
    end
    -- self:freshMyRank()
end

function BigSailIslandRankView:freshMyRank()
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

    -- 公会图标
    local iconName = GameDataManager:getInstance():getGuildIconForIconID(data.iconID)
    local guildIcon = UI.Image:create()
    guildIcon:init(iconName)
    guildIcon:center(-80, -13)
    rankLayer:addChild(guildIcon)

    -- 公会名字
    local presidentName = UI.Text:create()
    presidentName:init(tostring(data.rolename), UI.SYS_FONT, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    presidentName:center(80, -13)
    presidentName:setTextLeftUp()
    rankLayer:addChild(presidentName)

    -- 总产量
    local totalNum = UI.Text:create()
    totalNum:init(tostring(data.totalOutput), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
    totalNum:center(230, -13)
    totalNum:setTextLeftUp()
    rankLayer:addChild(totalNum)

    self:addChild(rankLayer)
end

function BigSailIslandRankView:choseBtn(btnState)
    if btnState == BTN_STATE.RANK_BTN then
        self.btnState = BTN_STATE.RANK_BTN
        self.rankBtn:setNormal("ui_btn_gray2_1.png")
        self.awardBtn:setNormal("ui_btn_gray2_0.png")

        self.rankBtn:setFontColor({r = 207, g = 182, b = 89})
        self.awardBtn:setFontColor(UI.FONT_COLOR_50_50_44)

        self._tableView:reloadData(true, true)
        self:refreshRankTopTitile()
    else
        self.btnState = BTN_STATE.AWARD_BTN
        self.rankBtn:setNormal("ui_btn_gray2_0.png")
        self.awardBtn:setNormal("ui_btn_gray2_1.png")

        self.rankBtn:setFontColor(UI.FONT_COLOR_50_50_44)
        self.awardBtn:setFontColor({r = 207, g = 182, b = 89})

        self._tableView:reloadData(true, true)
        self:refreshAwardTopTitile()
    end

end

function BigSailIslandRankView:refreshRankTopTitile()
    self.rankTitleLayer:removeAllChildren()


    local rankingTxt = UI.Text:create()
    rankingTxt:init(UI.TEXT_1212293, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    rankingTxt:center(-200, -190)
    self.rankTitleLayer:addChild(rankingTxt)

    local headTxt = UI.Text:create()
    headTxt:init(UI.TEXT_226139, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    headTxt:center(-40, -190)
    self.rankTitleLayer:addChild(headTxt)

    local guildTxt = UI.Text:create()
    guildTxt:init(UI.TEXT_110050, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    guildTxt:center(120, -190)
    self.rankTitleLayer:addChild(guildTxt)

    local outputTxt = UI.Text:create()
    outputTxt:init(UI.TEXT_226140, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
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

function BigSailIslandRankView:refreshAwardTopTitile()
    self.rankTitleLayer:removeAllChildren()
    local rankingTxt = UI.Text:create()
    rankingTxt:init(UI.TEXT_1212293, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    rankingTxt:center(-200, -190)
    self.rankTitleLayer:addChild(rankingTxt)

    local headTxt = UI.Text:create()
    headTxt:init(UI.TEXT_1212901, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
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

function BigSailIslandRankView:freshData(data)
    print("freshData==>: ", data)
    self.data = {}
    for k,v in pairs(data.rankList) do
        self.data[k] = {}
        self.data[k].selfRank = v.rank
        self.data[k].rolename = v.nickName
        self.data[k].iconID = v.faceId
        self.data[k].techLevel = 5
        self.data[k].personNum = 10
        self.data[k].totalOutput = v.score
    end
    self:choseBtn(self.btnState)

    -- 自己的公会排名信息
    local myGuildData = MasterDataManager:getGuildData()
    self.myRankData.selfRank = data.selfRank
    self.myRankData.rolename = myGuildData:getName()
    self.myRankData.iconID = myGuildData:getIconID()
    self.myRankData.techLevel = 5
    self.myRankData.personNum = 10
    self.myRankData.totalOutput = data.selfScore

    self:freshMyRank()
end

function BigSailIslandRankView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_LIST, self, self.freshData)
end

function BigSailIslandRankView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RANK_LIST, self, self.freshData)
end

return BigSailIslandRankView




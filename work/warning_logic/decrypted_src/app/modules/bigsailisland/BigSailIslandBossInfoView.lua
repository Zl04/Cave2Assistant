------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/07/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandBossInfoView = class("BigSailIslandBossInfoView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_town_ranking.plist",
}

local COM_WIDTH = 1061
local COM_HEIGHT = 592

function BigSailIslandBossInfoView:ctor()
    BigSailIslandBossInfoView.super.ctor(
    	self,
    	UI.Type.SAIL_BOSS_INFO,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    local isPreWeek = mvc.bigSailIslandModel:getBossRankIsPreWeek()
    Net.NetRankSystem:requestRankList(PublicDefine.RankType.RANKTYPE_BIGSAIL_BOSS_DAMAGE, isPreWeek)
end

function BigSailIslandBossInfoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandBossInfoView.super.init(self, ... )
end

function BigSailIslandBossInfoView:dtor()
    BigSailIslandBossInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandBossInfoView")
end


function BigSailIslandBossInfoView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local centerBg  = UI.Image:create()
    centerBg:init("ui_bg_box2.png")
    centerBg:center()
    contentLayout:addChild(centerBg)

    -- title
    local title  = UI.Image:create()
    title:init("ui_bg_title.png")
    title:centerUp(-30)
    contentLayout:addChild(title)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226200, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_204_204_204)
    titleText:center()
    title:addChild(titleText)

    -- 背景图片
    local paperBg  = UI.Image:create()
    paperBg:init("ui_bg_paper3.png")
    paperBg:center()
    contentLayout:addChild(paperBg)

    -- 左侧内容面板
    local leftContentLayout = UI.Layout:create()
    leftContentLayout:init()
    leftContentLayout:setSize(450, 500)
    leftContentLayout:centerLeft(120, 0)
    contentLayout:addChild(leftContentLayout)
    self.leftContentLayout = leftContentLayout
    -- leftContentLayout:enableDebugDraw()

    local leftBg  = UI.Image:create()
    leftBg:init("ui_greatnavigation_paper_4.png")
    leftBg:center()
    leftContentLayout:addChild(leftBg)

    -- 右侧内容面板
    local rightContentLayout = UI.Layout:create()
    rightContentLayout:init()
    rightContentLayout:setSize(380, 500)
    rightContentLayout:centerRight(110, 0)
    contentLayout:addChild(rightContentLayout)
    self.rightContentLayout = rightContentLayout
    -- rightContentLayout:enableDebugDraw() 

    self:initBossInfoView()
    self:initRightView()
end

function BigSailIslandBossInfoView:initBossInfoView()
    local config = ConfigManager:getNavigationBossGroupByID(1)
    
    local bossBg  = UI.Image:create()
    bossBg:init("ui_greatnavigation_bossbg.png")
    bossBg:centerUp(10)
    self.leftContentLayout:addChild(bossBg)

    local spineName = config.showPicture
    local bossNodeSpine = UI.Animation:create()
    bossNodeSpine:init(spineName..".json", spineName..".atlas", 1);
    bossNodeSpine:centerUp(250)
    bossNodeSpine:setAnimation("idle4", true)
    bossNodeSpine:setScale(0.6)
    self.leftContentLayout:addChild(bossNodeSpine)

    local skillIconList = string.split(config.skillIcon, ";")
    local desList = string.split(config.skillDes, ";")
    local skillLayout = UI.Layout:create();
    skillLayout:init()
    skillLayout:setSize(64, #skillIconList*75)
    skillLayout:centerLeft(20, -80)
    -- skillLayout:enableDebugDraw()
    self.leftContentLayout:addChild(skillLayout)
    self.skillLayout = skillLayout
    for k, v in pairs(skillIconList) do
        self:createSkillIcon(k, v, desList[k])
    end

    local bossChallengeNum = mvc.bigSailPortModel:getBossFoughtNum()

    local foughtNum = bossChallengeNum or 0
    local fightNum = ConfigManager:getNavigationGeneralConfigByID(1).everydayFightTime 
    local showNum = fightNum - foughtNum 
    showNum = showNum > 0 and showNum or 0
    -- print("TEXT_226205:", foughtNum, fightNum, showNum)

    local showTxt = string.format(UI.TEXT_226205, showNum)
    local fightNumText = UI.Text:create()
    fightNumText:init(showTxt, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    fightNumText:centerBottom(55)
    self.leftContentLayout:addChild(fightNumText)

    local fightBtn = UI.Button:create()
    fightBtn:init("ui_greatnavigation_btn_6.png","ui_greatnavigation_btn_6.png","ui_greatnavigation_btn_6.png")
    fightBtn:centerBottom(10)
    fightBtn:closeClickScale()
    fightBtn:setText(UI.TEXT_226201)
    fightBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    fightBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local bossOpen = mvc.bigSailIslandModel:getBossIsOpen()
        if not bossOpen then
            local bossOpenTime = mvc.bigSailIslandModel:getBossOpenTime()
            local startDate = GameManager:getNowServerDate("%m.%d %H:%M", bossOpenTime + GameManager:getEPOCHTime())
            UI.ScrollBar:createByText(string.format(UI.TEXT_226209, startDate))
            return 
        end

        if showNum <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_226213)
            return 
        end
        local data = mvc.bigSailPortModel:isCanFightBoss()
        if data.boatId ~= 0 then
            mvc.openPanel("BigSailIsland", "BigSailIslandFightSelect")
        else
            UI.ScrollBar:createByText(UI.TEXT_226212)
        end
        -- mvc.openPanel("BigSailIsland", "BigSailIslandFightSelect")
    end)
    self.leftContentLayout:addChild(fightBtn)

    local rankBtn = UI.Button:create()
    rankBtn:init("ui_greatnavigation_ranking.png","ui_greatnavigation_ranking.png","ui_greatnavigation_ranking.png")
    rankBtn:centerBottom(7, 170)
    -- rankBtn:closeClickScale()
    rankBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        local isPreWeek = mvc.bigSailIslandModel:getBossRankIsPreWeek()
        Net.NetRankSystem:requestRankList(PublicDefine.RankType.RANKTYPE_BIGSAIL_BOSS_DAMAGE, isPreWeek)
        mvc.openPanel("BigSailIsland", "BigSailIslandBossDmgRank")
    end)
    self.leftContentLayout:addChild(rankBtn)

    self:addDesScrollView(config)
end

function BigSailIslandBossInfoView:createSkillIcon(index, icon, des)
    local skillBg = UI.Image:create()
    skillBg:init("ui_greatnavigation_skillbg.png")
    skillBg:centerUp((index*70)-70)
    self.skillLayout:addChild(skillBg)

    local iconNode = UI.Image:create()
    iconNode:init(icon)
    iconNode:centerUp((index*70)-70)
    self.skillLayout:addChild(iconNode)

    iconNode:setTouchEnable(true)
    iconNode:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        self:createDesTips(iconNode, des)
    end)
    iconNode:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self, com, touchPosition)
        local tipsBg = iconNode:getChildByName("tipsBg")
        if tipsBg then
            tipsBg:removeFromParent(true)
            tipsBg = nil
        end
    end)
end

function BigSailIslandBossInfoView:createDesTips(parent, des)
    
    local showStr = languageManagerInstance:getLocalString(tonumber(des))
    local tipsBg = UI.Image:create()
    tipsBg:init("ui_greatnavigation_bubble.png")
    tipsBg:centerLeft(60, 0)
    tipsBg:setName("tipsBg")
    parent:addChild(tipsBg)

    local des = UI.Text:create()
    des:init(showStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_204_204_204)
    -- des:centerLeft(30, -5)
    des:setWidth(260)
    des:setTextCenter()
    des:autoAdapt()
    tipsBg:addChild(des)
end

function BigSailIslandBossInfoView:addDesScrollView(config)
    local height = 80
    local width = 400
    local desStr = languageManagerInstance:getLocalString(config.bossDes)
    local desText = UI.Text:create()
    desText:init(desStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    desText:setWidth(width)
    desText:autoAdapt()

    if(desText:getContentSize().height <= height) then 
        desText:centerUp(342)
        self.leftContentLayout:addChild(desText)
    else
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(width, desText:getContentSize().height)
        desText:centerUp(3)
        layout:addChild(desText)

        local detailedScrollView = UI.ScrollView:create()
        detailedScrollView:init(0,0,0,0)
        detailedScrollView:setSize(width, height)
        detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
        detailedScrollView:addInnerNode(layout)
        detailedScrollView:setScrollBarEnabled(true)
        detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
        detailedScrollView:setCircleVisible(false)
        detailedScrollView:setScrollBarWidth(5)
        detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(2, 0))
        detailedScrollView:setName("Item")
        detailedScrollView:centerUp(342)
        -- detailedScrollView:enableDebugDraw()

        self.leftContentLayout:addChild(detailedScrollView, 99)
    end
end

function BigSailIslandBossInfoView:initRightView()
    local titleBg  = UI.Image:create()
    titleBg:init("ui_greatnavigation_title_3.png")
    titleBg:centerUp(-10)
    self.rightContentLayout:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_226202, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_204_204_204)
    titleText:center()
    titleBg:addChild(titleText)

    self:addShowRankCell()
end

function BigSailIslandBossInfoView:addShowRankCell()
    self._tableView = UI.TableView.new({}, 370, 419)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:centerUp(73, 10);
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return 361, 85
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = mvc.bigSailIslandBossDmgRankShowCellView.create();
            cell:init(self.showRankData[idx + 1]);
            cell:updateView()
        end,
        function(e) 
            printError("------------------------DreamRankLayer:tableCellAtIndex-----------------error")
        end, 1);
        
        return cell
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.showRankData);
    end);

    -- self._tableView:onTableCellTouched(function(table, cell)
    --     print("BigSailIslandBossDmgRankView:tableCellTouched",cell:getIdx());
    -- end);

    self.rightContentLayout:addChild(self._tableView)

    if self.showRankData then
        self._tableView:reloadData(true, true)
    else
        local isPreWeek = mvc.bigSailIslandModel:getBossRankIsPreWeek()
        Net.NetRankSystem:requestRankList(PublicDefine.RankType.RANKTYPE_BIGSAIL_BOSS_DAMAGE, isPreWeek)
    end

    -- if self.showRankData then
    --     self._tableView:reloadData(true, true)
    -- end
    
end

function BigSailIslandBossInfoView:freshRankData(data)
    if data.rankType ~= PublicDefine.RankType.RANKTYPE_BIGSAIL_BOSS_DAMAGE then
        return 
    end
    self.showRankData = {}
    for k,v in pairs(data.rankList) do
        self.showRankData[k] = {}
        self.showRankData[k].pk = v.pk
        self.showRankData[k].selfRank = v.rank
        self.showRankData[k].rolename = ToolsUtil:replaceShowNickNameStr(v.nickName)
        self.showRankData[k].faceId = v.faceId
        self.showRankData[k].sex = v.sex
        self.showRankData[k].totalOutput = v.score

        if k == 5 then
            break
        end
    end

    if self._tableView then
        self._tableView:reloadData(true, true)
    end
end

function BigSailIslandBossInfoView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_LIST, self, self.freshRankData)
end


function BigSailIslandBossInfoView:unbindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_LIST, self, self.freshRankData)
end





return BigSailIslandBossInfoView













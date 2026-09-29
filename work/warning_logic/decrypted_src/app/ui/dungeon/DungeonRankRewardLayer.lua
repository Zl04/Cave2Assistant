-- DungeonRankRewardLayer.lua
-- Author:ydli
-- 2017年09月05日
-- Using:大秘境 排行榜奖励

require "app.ui.dungeon.DungeonRankRewardCell"
require "app.ui.common.Image9"

UI = UI or {}
local DungeonRankRewardLayer = class("DungeonRankRewardLayer", UI.HWBtnComponent)
UI.DungeonRankRewardLayer = DungeonRankRewardLayer
local GameInDungeonManager = require "app.game.GameInDungeonManager"
local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_dungeon.plist",
}

local CELL_WIDTH = 720
local CELL_SIZE = {
    [1] = cc.size(CELL_WIDTH, 174),
    [2] = cc.size(CELL_WIDTH, 97),
}

local VIEW_SIZE = cc.size(765, 423)

DR_REWARD_CELL_TYPE = {
    HEIGH = 1,
    LOW = 2,
}

--构造函数(必备)
function DungeonRankRewardLayer:ctor(spriteID)
    DungeonRankRewardLayer.super.ctor(
        self, UIType.ES_RANKREWARD_LAYER,
        COM_RES_LIST,
        winSize.width,    
        winSize.height
    )
    self.rootLayer = nil
    self.spriteID = spriteID
    self.rankRewardList = {}
    self:init()
    self:setTouchEnable(true)
    self:registerListener()
end

--虚构函数, destroy时调用(必备)
function DungeonRankRewardLayer:dtor()
    self.rankRewardList = {}
    DungeonRankRewardLayer.super.dtor(self)
    self:unRegisterListener()
end

-- 初始化(必备)
function DungeonRankRewardLayer:init()
    DungeonRankRewardLayer.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function DungeonRankRewardLayer:onInitView()
    local colorLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    colorLayer:setContentSize(winSize.width, winSize.height)
    colorLayer:setPosition(cc.p(0, 0))
    self:addChild(colorLayer)

    self.rootLayer = UI.Component:create()
    self.rootLayer:init()
    self.rootLayer:setSize(winSize.width, winSize.height)
    self.rootLayer:leftBottom(0, winSize.height)
    self:addChild(self.rootLayer)
    
    -- 面板
    self.bg = UI.Image:create()
    self.bg:init("ui_dungeon_banner_query.png")
    self.bg:center()
    self.bg:setTouchEnable(true)
    self.rootLayer:addChild(self.bg)

    -- 标题
    self.title = UI.Text:create()
    self.title:init("", UI.FONT_BOLD, UI.FONT_SIZE_26PX)
    self.title:setFontColor(UI.FONT_COLOR_207_182_89)
    self.title:centerUp(27)
    self.title:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -3))
    self.bg:addChild(self.title)

    -- 季度时间
    self.seasonDate = UI.Text:create()
    self.seasonDate:init("--/--/--", UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    self.seasonDate:setFontColor(UI.FONT_COLOR_194_194_194)
    self.seasonDate:setTextHorizontalCenter()
    self.seasonDate:centerUp(64)
    self.seasonDate:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -2))
    self.bg:addChild(self.seasonDate)

    -- 滚动底纸
    local underPaper = UI.Image9:create()
    underPaper:init("ui_bg_paper2.png", CCRectMake(303,136,4,2), cc.size(750, 500))
    underPaper:leftBottom(97, 34)
    self.bg:addChild(underPaper)

    -- 滚动组件
    self.scrollView = UI.ScrollView:create()
    self.scrollView:init(0, 0, 0, 0)
    self.scrollView:setSize(VIEW_SIZE.width, VIEW_SIZE.height)
    self.scrollView:leftBottom(112, 100)
    self.scrollView:setScrollBarEnabled(true)
    self.scrollView:setCircleVisible(false)
    self.scrollView:setScrollBarColor(UI.SLIDER_COLOR_77_71_70)
    self.scrollView:setScrollBarWidth(4)
    self.bg:addChild(self.scrollView)

    -- 滚动内容宿主
    self.layout = UI.Layout:create()
    self.layout:init(0, 0, 0, 0)
    self.scrollView:addInnerNode(self.layout)

    -- 渐变隐藏条
    local botMask = UI.Image:create()
    botMask:init("ui_dungeon_banner_query_mask.png")
    botMask:leftBottom(97, 100)
    self.bg:addChild(botMask)

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(699, 2))
    splitLine:centerBottom(100)
    self.bg:addChild(splitLine)

    -- 自适应居中排版 (包含奖杯图标, 分数, 提示文字 和 小点点)
    local autoWidthLayout = UI.Layout:create()
    autoWidthLayout:init()
    autoWidthLayout:enableAutoWidth()
    autoWidthLayout:enableAutoHeight()
    autoWidthLayout:centerBottom(39)
    self.bg:addChild(autoWidthLayout)

    -- 奖杯图标
    local rankIcon = UI.Image:create()
    rankIcon:init("ui_dungeon_icon_trophy1.png")
    rankIcon:floatLeft(0)
    autoWidthLayout:addComponent(rankIcon, 1)

    -- 自己分数背景
    local scoreBg = UI.Image:create()
    scoreBg:init("ui_dungeon_medal_03.png")
    scoreBg:floatLeft(-16)
    autoWidthLayout:addComponent(scoreBg)

    -- 分数文字
    self.myRank = UI.Text:create()
    self.myRank:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    self.myRank:setFontColor(UI.FONT_COLOR_248_201_95)
    self.myRank:centerLeft(21)
    scoreBg:addChild(self.myRank)

    -- 提示文字
    self.seasonDesc = UI.Text:create()
    self.seasonDesc:init(UI.TEXT_1170209, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    self.seasonDesc:setFontColor(UI.FONT_COLOR_41_41_45)
    self.seasonDesc:floatLeft(15)
    autoWidthLayout:addComponent(self.seasonDesc)

    -- 文字右边的小点
    local rankIcon = UI.Image:create()
    rankIcon:init("ui_dungeon_point.png")
    rankIcon:floatLeft(15)
    autoWidthLayout:addComponent(rankIcon)

    self.rootLayer:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(0, 0)), cc.CallFunc:create(function()
        Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function() 
            if self.delayUpdateView then
                self:delayUpdateView()
            end
        end, 1)
    end)))

end

-- 模版函数：更新组建的视图(必备)
function DungeonRankRewardLayer:onUpdateView()
    self:generateRewardCfg() 
    for k, data in ipairs(self.rankRewardList) do
        if data.isFirstShow then
            local size = CELL_SIZE[data.type]
            local cell = UI.DungeonRankRewardCell:create(data, size.width, size.height, self.scrollView)
            self.curHeight = self.curHeight - size.height
            cell:leftBottom(0, self.curHeight)
            self.layout:addChild(cell)
        end
    end
     
    local startTime, endTime = GameInDungeonManager:getSeasonShowTime()
    if startTime ~= nil and endTime ~= nil then
        local startTimeStr = GameManager:getNowServerDate("%Y/%m/%d", startTime + GameManager:getEPOCHTime())
        local endTimeStr = GameManager:getNowServerDate("%Y/%m/%d", endTime + GameManager:getEPOCHTime())
        if endTime == 0 then
            endTimeStr = "??????"
        end
        self.seasonDate:setText(startTimeStr.."-"..endTimeStr)
    end
    local pk = RoleDataManager:getMaster():getPK()
    Net.NetRankSystem:requestSpecifyRank(pk,  PublicDefine.RankType.RankType_Dungeon)
    local seasonData = MasterDataManager:getCurrentSeasonData()
    if seasonData ~= nil then
        self.title:setText(string.format(UI.TEXT_1170206, seasonData.seasonID))
    end
end

--todo ydli 实现赛季奖励内容
function DungeonRankRewardLayer:generateRewardCfg()   
    local rewardCfg = nil
    local seasonData = MasterDataManager:getCurrentSeasonData()
    if seasonData ~= nil then
        rewardCfg = ConfigManager:getDungeonSeasonRewardById(seasonData.seasonID)
    end
    if rewardCfg == nil then
        return
    end
    local curHeight = 0
    local rankList = string.split(rewardCfg.rankRange, ";")
    for k, v in ipairs(rankList) do
        local data = {}
        local rankLimite = string.split(v, ",")
        data.rankDownLimit = tonumber(rankLimite[1])
        data.rankUpLimit = tonumber(rankLimite[2]) 

        local rewardGoodsList = string.split(rewardCfg.rewardGoods, ";")
        local goodsIds = string.split(rewardGoodsList[k], ",")

        local goodsNumberList = string.split(rewardCfg.rewardGoodsNum, ";")
        local goodsNumbers = string.split(goodsNumberList[k], ",")
        data.rewards = {}
        for index, id in ipairs(goodsIds) do 
            local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(id))
            if (goodsData) then
                goodsData:setNum(tonumber(goodsNumbers[index] or 0))
                goodsData:setIsGolden(true)
                goodsData:setIsNew(false)
                table.insert(data.rewards, goodsData)
            end
        end

             
        local bgImageIdList = string.split(rewardCfg.seasonBannerID, ";")
        data.bgImageId = tonumber(bgImageIdList[k])
        local rankIconIdList = string.split(rewardCfg.seasonRankIcon, ";")
        data.rankIconId = tonumber(rankIconIdList[k])
        if data.bgImageId > 0 then
            data.type = DR_REWARD_CELL_TYPE.HEIGH
        else
            data.type = DR_REWARD_CELL_TYPE.LOW
        end

        data.isFirstShow = true
        curHeight = curHeight + CELL_SIZE[data.type].height
        if curHeight > VIEW_SIZE.height then
            data.isFirstShow = false
        end
        table.insert(self.rankRewardList, data)
    end
    self.layout:setSize(CELL_WIDTH, curHeight)
    self.curHeight = curHeight
end

function DungeonRankRewardLayer:delayUpdateView()   
    for k, data in ipairs(self.rankRewardList) do
        if not data.isFirstShow then
            local size = CELL_SIZE[data.type]
            local cell = UI.DungeonRankRewardCell:create(data, size.width, size.height, self.scrollView)
            self.curHeight = self.curHeight - size.height
            cell:leftBottom(0, self.curHeight)
            self.layout:addChild(cell)
        end
    end
end


-- 注册监听事件(可选)
function DungeonRankRewardLayer:registerListener()
    self.bg:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_RANK_DUNGEON_SEASON_RANKING, self, self.refreshRankText)
end

function DungeonRankRewardLayer:onTouchDialogOutsizeHandler()
    self.rootLayer:runAction(cc.Sequence:create(
        cc.MoveTo:create(0.2, cc.p(0, winSize.height)),
        cc.CallFunc:create(function()
            self:close()
        end)))
end

-- 注销监听事件(可选)
function DungeonRankRewardLayer:unRegisterListener()
    -- 显示进入下一层TIPS
    Avalon.MessageCenter:unbind(AvalonMessage.MC_RANK_DUNGEON_SEASON_RANKING, self, self.refreshRankText)
end

function DungeonRankRewardLayer:refreshRankText()
    -- body
    local rank = MasterDataManager:getDungeonRanking()
    if rank ~= nil then
        if rank == -1 then
            self.myRank:setText(PublicDefine.RankAmbit.RankAmbit_Enter.."+")
        else
            self.myRank:setText(rank.."")
        end
    end
end




------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandRankResultView = class("BigSailIslandRankResultView", UI.HWBtnComponent)

require "app.modules.bigsailisland.BigSailIslandResultTableCellView"

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
    "ui_common_symbol.plist",
}

local COM_WIDTH = 500
local COM_HEIGHT = 534

local winSize = cc.Director:getInstance():getWinSize()

function BigSailIslandRankResultView:ctor()
    BigSailIslandRankResultView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.verticalNum = 1 
    self.horizontalNum = 3
end

function BigSailIslandRankResultView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandRankResultView.super.init(self, ... )
end

function BigSailIslandRankResultView:dtor()
    BigSailIslandRankResultView.super.dtor(self)
    mvc.bigSailIslandModel:clearExpel()
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandRankResultView")
end


function BigSailIslandRankResultView:onInitView()
    --self:enableDebugDraw()
    self:center(0,0)
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 0)
    self:addChild(contentLayout, 5)
    self.contentLayout = contentLayout

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local bg = UI.Image.create()
    bg:init("ui_greatnavigation_paper_2.png")
    bg:center(0,0)
    contentLayout:addChild(bg)

    local bg2 =  UI.Image9.create()
    bg2:init("ui_greatnavigation_bg_2.png", cc.rect(100,0,150,65), cc.size(428, 450))
    bg2:center(0, 30)
    bg:addChild(bg2)

    local titleLinePic =  UI.Image.create()
    titleLinePic:init("ui_greatnavigation_line_2.png")
    titleLinePic:center(0, -205)
    contentLayout:addChild(titleLinePic)

    local titlePic =  UI.Image.create()
    titlePic:init("ui_greatnavigation_title_2.png")
    titlePic:center(0, -30)
    titleLinePic:addChild(titlePic)

    local bgTitleTxt = UI.Text:create()
    bgTitleTxt:init(UI.TEXT_226138, UI.FONT_BOLD, UI.FONT_SIZE_22PX, {r = 181, g = 191, b = 212})
    bgTitleTxt:center(0,0)
    titlePic:addChild(bgTitleTxt, 10)

    self:initResultList()
end

function BigSailIslandRankResultView:initResultList()
    -- 占领船只列表
    local gridListWidth = 428
    local gridListHeight = 435
    local gridList = UI.GridList:create()
    gridList:init(UI.BigSailIslandResultTableCellView, self.verticalNum, self.horizontalNum, 410, 130, 0, 9, 0)
    gridList:setSize(gridListWidth, gridListHeight)
    gridList:center(-7, 33)
    gridList:disableToDragGrid()
    --gridList:setCallbackForGridClick(self, self.cellClickCallback)
    gridList:setScrollBarEnabled(true)
    gridList:setCircleVisible(false)
    self.bookList = gridList
    self.contentLayout:addChild(self.bookList)

    local expelBaseData = mvc.bigSailIslandModel:getExpelBaseData()
    local expelDataInfo = mvc.bigSailIslandModel:getExpelInfo()
    local expelEndNum = mvc.bigSailIslandModel:getExpelEndNum()

    -- local expelBaseData = {myPk = 17827082, num = 2, result = 1, othersuppy = 5, mysupply = 20}
    -- local expelDataInfo = {}
    -- local expelEndNum = 2
    -- for i=1,2 do
    --     local qwe = true
    --     if i == 2 then
    --         qwe = false
    --     end
    --     table.insert(expelDataInfo,{isWin = qwe, petStatistics = {{curHp = 0, petTempleteId = 4, isvariant = false, maxHp = 99, spriteid = 917719, attackHp = 0, recoverHp = 0}, {curHp = 0, petTempleteId = 4, isvariant = false, maxHp = 99, spriteid = 983259, attackHp = 0, recoverHp = 0}, {curHp = 0, petTempleteId = 4, isvariant = false, maxHp = 99, spriteid = 1048789, attackHp = 0, recoverHp = 0}, {curHp = 4154390, petTempleteId = 1003, isvariant = true, maxHp = 4154390, spriteid = 1114329, attackHp = 99, recoverHp = 0}, {curHp = 1985740, petTempleteId = 1010, isvariant = true, maxHp = 1985740, spriteid = 1179869, attackHp = 1000099, recoverHp = 0}, {curHp = 3114774, petTempleteId = 1013, isvariant = true, maxHp = 3114774, spriteid = 1245399, attackHp = 99, recoverHp = 0}}})
    -- end


    local config = ConfigManager:getAllNavigationGeneralConfigData()[1]
    local winExpend = config.victorySupplyConsume -- 胜利消耗补给
    local failExpend = config.defaultSupplyConsume -- 失败消耗补给
    local mySupply = expelBaseData.mysupply -- 战斗开始前我方的补给
    local otherSuppy = expelBaseData.othersuppy -- 战斗开始前敌人的补给
    local myPower = expelBaseData.myPower -- 战斗开始前我方的战斗力
    local otherPower = expelBaseData.otherPower -- 战斗开始前敌人的战斗力
    local data = {}

    local isRate,needNum,needNum2 = mvc.bigSailIslandModel:getConsumptionRate(otherPower,myPower)
    if isRate then
        failExpend = needNum
        winExpend = needNum2
    end

    --print("expelDataInfo--->: ", expelDataInfo)
    for i=1,expelEndNum do
        local showInfo = {}
        showInfo.isWin = expelDataInfo[i].isWin
        showInfo.petStatistics = expelDataInfo[i].petStatistics
        --print("showInfo.petStatistics-->: ", showInfo.petStatistics)

        -- 根据本次战斗结果，判断消耗后还剩的补给数量
        if showInfo.isWin then
            mySupply = mySupply - winExpend
            otherSuppy = otherSuppy - failExpend
        else
            mySupply = mySupply - failExpend
            otherSuppy = otherSuppy - winExpend
        end

        showInfo.mySupply = mySupply
        showInfo.otherSuppy = otherSuppy

        table.insert(data, showInfo)
    end
    self.bookList:setData(data)

    if otherSuppy <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_226178)
    elseif mySupply <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_226177)
    end
end


function BigSailIslandRankResultView:bindModel()

end


function BigSailIslandRankResultView:unbindModel()

end





return BigSailIslandRankResultView













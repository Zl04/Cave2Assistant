-- RankingTypeCell.lua
-- Author:ODEI
-- 2017年8月16日
-- Using:排行榜种类cell
UI = UI or {}
local RankingTypeCell = class("RankingTypeCell", UI.HWBtnComponent)
UI.RankingTypeCell = RankingTypeCell

local COM_RES_LIST = {
}

local _width = 97
local _height = 68

function RankingTypeCell:ctor(data,idx,rankingType,myRank)
    -- print("RankingTypeCell:ctor")
    RankingTypeCell.super.ctor(
        self,UIType.RANKING_TYPE_CELL,
        COM_RES_LIST,
        _width,
        _height
    )

    self.rootLayer = nil;           --root节点
    self:init();
end


-- public:
-- 初始化
function RankingTypeCell:init()
    RankingTypeCell.super.init(self)
end


-- 模版函数：初始化组建的视图
function RankingTypeCell:onInitView()
    local picBG = UI.Image:create()
    picBG:init("ui_btn_gray_0.png")
    picBG:center()
    picBG:setName("picBG")
    self:addChild(picBG)
    -- self:enableDebugDraw()

    --排名
    local txtRankNum = UI.Text:create()
    txtRankNum:init("", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    txtRankNum:setSize(_width, _height)
    -- txtRankNum:autoAdapt()
    txtRankNum:setTextCenter()
    txtRankNum:setTextHorizontalCenter()
    txtRankNum:setLineSpacing(-10)
    txtRankNum:center()
    txtRankNum:setName("txtRankNum")
    self:addChild(txtRankNum)    
end

-- 模版函数：更新组建的视图
function RankingTypeCell:onUpdateView()
end

function RankingTypeCell:hightLight()
    local txtRankNum = self:getChildByName("txtRankNum")
    self:getChildByName("picBG"):setSpriteName("ui_btn_gray_1.png")
    txtRankNum:setFontColor(UI.FONT_COLOR_220_211_147)
end

function RankingTypeCell:unHightLight()
    local txtRankNum = self:getChildByName("txtRankNum")
    self:getChildByName("picBG"):setSpriteName("ui_btn_gray_0.png")
    txtRankNum:setFontColor(UI.FONT_COLOR_47_50_55)
end

function RankingTypeCell:reload(data,myRankType)
    -- print("RankingTypeCell:reload")
    local txtRankNum = self:getChildByName("txtRankNum")
    if data.rankType == myRankType then
        self:getChildByName("picBG"):setSpriteName("ui_btn_gray_1.png")
        txtRankNum:setFontColor(UI.FONT_COLOR_220_211_147)
    else
        self:getChildByName("picBG"):setSpriteName("ui_btn_gray_0.png")
        txtRankNum:setFontColor(UI.FONT_COLOR_47_50_55)
    end
    txtRankNum:setText(data.name)
    -- txtRankNum:autoAdapt()
end


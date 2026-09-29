------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/08/03
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local winSize = cc.Director:getInstance():getWinSize()
local PuzzleMatchLayer = class("PuzzleMatchLayer", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_festival.plist"
}

local COM_WIDTH = 300
local COM_HEIGHT = 100

function PuzzleMatchLayer:ctor()
    PuzzleMatchLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PuzzleMatchLayer:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.puzzle", "Puzzle", false)
    PuzzleMatchLayer.super.init(self, ... )
end

function PuzzleMatchLayer:dtor()
    PuzzleMatchLayer.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.puzzle.PuzzleMatchLayer")
end


function PuzzleMatchLayer:onInitView()
    
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    -- contentLayout:enableDebugDraw()
    contentLayout:center()
    self:addChild(contentLayout)

    local scoreBannerImg = UI.Image:create()
    scoreBannerImg:init("ui_puzzle_score_banner.png")
    scoreBannerImg:center()
    contentLayout:addChild(scoreBannerImg)

    local scoreNum = UI.Text:create()
    scoreNum:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 235,g = 230, b = 201})
    scoreNum:centerBottom(8)
    scoreNum:setTextCenter()
    scoreBannerImg:addChild(scoreNum)
    self.scoreNum = scoreNum
end


function PuzzleMatchLayer:updateScoreNum()
    local score = mvc.puzzleModel:getCurScoreNum()
    self.scoreNum:setText(score)
end


function PuzzleMatchLayer:bindModel()

end


function PuzzleMatchLayer:unbindModel()

end


return PuzzleMatchLayer













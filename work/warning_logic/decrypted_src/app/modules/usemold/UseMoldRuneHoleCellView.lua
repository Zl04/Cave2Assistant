------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/26
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local UseMoldRuneHoleCellView = class("UseMoldRuneHoleCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 44
local COM_HEIGHT = 45

function UseMoldRuneHoleCellView:ctor(data)
    UseMoldRuneHoleCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self:bindModel()
end

function UseMoldRuneHoleCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.usemold", "UseMold", false)
    UseMoldRuneHoleCellView.super.init(self, ... )
end

function UseMoldRuneHoleCellView:dtor()
    UseMoldRuneHoleCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.usemold.UseMoldRuneHoleCellView")
end


function UseMoldRuneHoleCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bottomPic  = UI.Image:create()
    bottomPic:init("ui_iteminfo_btn_runestone_red_dwon.png")
    bottomPic:center()
    contentLayout:addChild(bottomPic)
    self.bottomPic = bottomPic

    local framePic  = UI.Image:create()
    framePic:init("ui_iteminfo_btn_runestone_red_up.png")
    framePic:center()
    contentLayout:addChild(framePic)
    self.framePic = framePic

    self:updateHoleView()
end

function UseMoldRuneHoleCellView:updateHoleView()
    -- local moldInfo = mvc.runeMoldModel:getMoldInfo()
    if self.data then
        local runeGrid = UI.GoodsGrid:create()
        runeGrid:init()
        runeGrid:center(1, 0)
        runeGrid:setScale(0.6)
        self.contentLayout:addChild(runeGrid)
        
        local goodsData = GoodsDataManager:createLocalGoodsData(self.data.gemId)
            
        runeGrid:setData(goodsData)
        runeGrid:hideCountLabel()
        runeGrid:updateView()
        
        performWithDelay(self, function() 
            runeGrid:hideRare()
            runeGrid:hideBG()
            runeGrid:hideFlagIcon()
            runeGrid:hideGemLevel()
        end, 0.001)
    end
end

function UseMoldRuneHoleCellView:bindModel()

end


function UseMoldRuneHoleCellView:unbindModel()

end





return UseMoldRuneHoleCellView













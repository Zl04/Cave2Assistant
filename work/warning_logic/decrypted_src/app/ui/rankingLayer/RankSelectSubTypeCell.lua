-- RankSelectSubTypeCell.lua
-- Author:yhj
-- Using:排行榜种类cell
local RankSelectSubTypeCell = class("RankSelectSubTypeCell",  UI.HWBtnComponent)
UI.RankSelectSubTypeCell = RankSelectSubTypeCell

local COM_RES_LIST = {
}

local _width = 210
local _height = 42

function RankSelectSubTypeCell:ctor()
    RankSelectSubTypeCell.super.ctor(
        self,UIType.RANKING_CELL,
        COM_RES_LIST,
        _width,
        _height
    )

    self:init()
end


-- public:
-- 初始化
function RankSelectSubTypeCell:init(data)
    RankSelectSubTypeCell.super.init(self)
    self.data = data
end


-- 模版函数：初始化组建的视图
function RankSelectSubTypeCell:onInitView()
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setPosition(cc.p(0,0))
    self.rootLayer:setContentSize(cc.size(_width,_height))
    self:addChild(self.rootLayer)
    

    local bG = UI.Image:create()
    bG:init("ui_btn_language_0.png")
    bG:center(0)
    self.rootLayer:addChild(bG)
    self.bG = bG

    local title = UI.Text:create()
    title:init("lang", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK )
    title:center()
    title:setTextCenter()
    self.rootLayer:addChild(title)
    self.title = title
end

function RankSelectSubTypeCell:getHeight()
    return 42;
end

-- 模版函数：更新组建的视图
function RankSelectSubTypeCell:onUpdateView()
end

-- data ={lang,isActive}
function RankSelectSubTypeCell:reload(data)
    if data.isActive  then
        self.bG:setSpriteName("ui_btn_language_1.png")
    else
        self.bG:setSpriteName("ui_btn_language_0.png")
    end
    if self.title then
        self.title:setText(data.lang)
    end

    if data.isSelf then
        if not self.selfSpr then
            self.selfSpr = UI.Image:create()
            self.selfSpr:init("ui_minimap_icon_me.png")
            self.selfSpr:centerLeft(10)
            self.rootLayer:addChild(self.selfSpr)
        end
    else
        if self.selfSpr then
            self.selfSpr:removeFromParent()
            self.selfSpr = nil
        end
    end
end


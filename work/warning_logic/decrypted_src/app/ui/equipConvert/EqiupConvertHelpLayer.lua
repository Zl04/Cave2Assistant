-- EqiupConvertHelpLayer.lua

local EqiupConvertHelpLayer = class("EqiupConvertHelpLayer", UI.Component)
local LanguageManager = require("app.game.LanguageManager")

function EqiupConvertHelpLayer:ctor(spriteID)
    --窗口大小
    EqiupConvertHelpLayer.super.ctor(
    self
    )
end

--虚构函数,destroy时调用(必备)
function EqiupConvertHelpLayer:dtor()
    EqiupConvertHelpLayer.super.dtor(self)
    reload_script_file("app.ui.equipConvert.EqiupConvertHelpLayer")
end
-- 初始化(必备)
function EqiupConvertHelpLayer:init()
    EqiupConvertHelpLayer.super.init(self)
end


function EqiupConvertHelpLayer:createOneSuitEquip(name, goodsIds)

	local bg = UI.Image:create()
	bg:init("ui_blacksmith_details_column.png")

   	local text = UI.Text:create()
    text:init(LanguageManager:getInstance():getLocalString(name), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    text:centerBottom(184)
	bg:addChild(text)

	local len = #goodsIds > 6 and 6 or #goodsIds
	for i = 1, len do
		local row = math.floor((i-1)/3)
		local colomn = i - row * 3 - 1

		print(row, colomn)
		local goodsId = goodsIds[i]
		local goodsData = GoodsDataManager:createLocalGoodsData(goodsId)
        local grid = UI.GoodsGrid:create()
    	grid:init()
    	grid:hideCountLabel()
    	grid:setTouchEnable(true)
        grid:setData(goodsData)
        grid:leftUp(colomn * 82 + 25, row * 82+30 )
        grid:showInfoArea();
        grid:hideNewIcon()
        bg:addChild(grid)
        grid:setInfoArea(true, false)
	end

	return bg
end


-- 模版函数：初始化组建的视图(必备)
function EqiupConvertHelpLayer:onInitView()
	
	local bg = UI.Image:create()
	bg:init("ui_blacksmith_details_paper.png")
	bg:leftBottom(0,0)
	self:addChild(bg)


	local text = UI.Text:create()
    text:init(UI.TEXT_1212270, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_WHITE)
    text:centerUp(40)
	bg:addChild(text)

    local scale = 230/text:getContentSize().width
    if scale < 1 then
        text:setScale(scale)
    end

    local text = UI.Text:create()
    text:init(UI.TEXT_1212271, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_80_5_5)
    text:centerBottom(105)
    text:setSize(290, 50)
    text:setTextCenter()
    bg:addChild(text)

    local groups = {}
    local names = {}
    local config = Config.Manager:getAllEquipConvert()
    for key, v in pairs(config) do
        if key ~= "size" then
            local idx = v.equipSet
            groups[idx] = groups[idx] or {}
            table.insert(groups[idx], v.ID)
            if v.equipSetName > 0 then
                names[idx]  = v.equipSetName
            end
        end
    end 

	local layout = UI.Layout:create()
	layout:init()
	layout:enableAutoHeight()
    layout:enableAutoWidth()
    for i = 1, #groups do
    	local node = self:createOneSuitEquip(names[i], groups[i])
    	node:floatUp(25)
    	layout:addComponent(node)
    end


    local scrollView = UI.ScrollView:create()
    scrollView:init(0, 0, 0, 0)
    scrollView:setSize(310, 380)
    scrollView:leftBottom(50, 165)
    scrollView:setScrollType(UI.ScrollType.VERTICAL)
    scrollView:setScrollBarEnabled(true)
    scrollView:setBounceEnabled(true)
    scrollView:setScrollBarWidth(5)
    scrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)


    scrollView:addInnerNode(layout)

    bg:addChild(scrollView)
    

    local paper = UI.Image:create()
    paper:init("ui_blacksmith_details_occlusion.png")
    paper:centerBottom(165)
    bg:addChild(paper, 1001)

  	local btn = UI.Button:create()
    btn:init("ui_btn_yellow4_0.png", "ui_btn_yellow4_1.png", "ui_btn_yellow4_2.png")
    btn:centerBottom(30)
    btn:setText(UI.TEXT_1212272)
    btn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_BLACK)
    btn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        self:removeFromParent()
    end)
    bg:addChild(btn)
end

return EqiupConvertHelpLayer














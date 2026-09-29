------------------------------------------------------------------------------
--author: zhiming.luo
--date	: 2019/11/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetLookMainView = class("PetLookMainView", UI.HWBtnComponent)

require "app.modules.pet.PetMainTabCell"
require "app.modules.pet.PetLookInfoLayer"
require "app.modules.pet.PetPacketLayer"

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_town_upgrade.plist",
    "ui_common_symbol.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local ZOrder = 1
local BTN_CELL_W = 109
local BTN_CELL_H = 68

function PetLookMainView:ctor(data)
    PetLookMainView.super.ctor(
    	self,
    	UI.Type.PET_MAIN,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.isShow = data.isShow or false
    self.curPet = data.pet

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
end

function PetLookMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pet", "Pet", false)
    PetLookMainView.super.init(self, ... )
end

function PetLookMainView:dtor()
    PetLookMainView.super.dtor(self)
    self:unbindModel()

    if self.isShow then
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PET_MAIN_VIEW_CENTER)
    end
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HIDE_PET_INFO_TIP, self, self.hideTip)
    reload_script_file_mvc("app.modules.pet.PetLookMainView")
end

function PetLookMainView:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create();
    bg:init("ui_bg_box2.png");
    bg:center();
    contentLayout:addChild(bg, ZOrder);
    ZOrder = ZOrder + 1;

    -- 标题背景图片
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_bg_title.png");
    bgTitle:centerUp(-14);
    contentLayout:addChild(bgTitle, ZOrder);
    ZOrder = ZOrder + 1;

    local titleTxtLayout = UI.Layout:create();
    titleTxtLayout:init()
    titleTxtLayout:setSize(235, 50)
    titleTxtLayout:leftUp(350, -10)
    contentLayout:addChild(titleTxtLayout, ZOrder)
    ZOrder = ZOrder + 1;

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213601, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_150_150_150)
    titleTxt:center()
    titleTxtLayout:addChild(titleTxt)

    -- 内部背景图片
    local innerBG  = UI.Image:create();
    innerBG:init("ui_pets_paper.png");
    innerBG:leftUp(30, 44);
    contentLayout:addChild(innerBG, ZOrder);
    ZOrder = ZOrder + 1;
    self.innerBG = innerBG
    
    self:makeTabList()
    self:initPetLookInfoLayer()

    local stoneEff = UI.Animation:create()
    stoneEff:init("effect_ui_town_pet_main_stone.json", "effect_ui_town_pet_main_stone.atlas", 1);
    stoneEff:leftBottom(-4, 6)
    stoneEff:setAnimation("idle", true)
    self.contentLayout:addChild(stoneEff, 100)
end

function PetLookMainView:makeTabList()
    self.btnData = {}

    local tab1 = {}
    tab1.idx = 1
    tab1.type = "attr"
    tab1.name = UI.TEXT_1213602
    tab1.ui = "PetLookAttr"
    tab1.select = true
    tab1.rootLayer = self
    tab1.look = true

    table.insert(self.btnData, tab1)

    self._tableView = UI.TableView.new({}, BTN_CELL_W+10, 70);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-92, 60)
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        if not cell then
            xpcall(function()
                cell = UI.PetMainTabCell.new();
                cell:init(self.btnData[idx+1], self.curPet, true);
            end,
            function(e) 
                printError("------------------------PetMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            cell:reloadData()
        end

        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end);

    self.contentLayout:addChild(self._tableView, ZOrder);
    ZOrder = ZOrder + 1
    self._tableView:reloadData(true);
end

function PetLookMainView:initPetLookInfoLayer()
    local infoLayer = UI.PetLookInfoLayer:create()
    infoLayer:init(self.contentLayout, self.curPet)
    infoLayer:leftUp(32, 50)
    infoLayer:setName("InfoLayer")
   
    self.contentLayout:addChild(infoLayer, ZOrder);
    ZOrder = ZOrder + 1
    self.infoLayer = infoLayer
end

function PetLookMainView:showTip(x, y, isRevert, text)
    local pos = self:convertToNodeSpace(cc.p(x, y))

    -- 提示框
    local tipBG = UI.Image9:create()
    tipBG:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(0, 0))
    tipBG:leftBottom(pos.x, pos.y)
    tipBG:setName("TIP")
    self:addChild(tipBG, 10000)

    local content = UI.Text:create()
    content:init(text, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_190_190_190)
    content:leftUp(10, 10)
    content:setTextLeft()
    local textW = content:getContentSize().width
    local textH = content:getContentSize().height
    if textW > 210 then
        content:setWidth(210)
        content:autoAdapt()
        textH = content:getContentSize().height
        tipBG:setSize(220, textH+20)
    else
        tipBG:setSize(textW+20, textH+20)
    end
    tipBG:addChild(content)

    local tipArrow  = UI.Image:create();
    tipArrow:init("ui_information_banner_background2.png");
    if isRevert then
        tipArrow:setScaleX(-1)
        tipArrow:centerLeft(-9)
    else
        tipArrow:centerRight(-9)
    end
    tipBG:addChild(tipArrow)

    tipBG:updateView()
    local w = tipBG:getContentSize().width
    local h = tipBG:getContentSize().height
    if isRevert then
        tipBG:leftBottom(pos.x+40, pos.y-h/2)
    else
        tipBG:leftBottom(pos.x-w-40, pos.y-h/2)
    end
end

function PetLookMainView:hideTip()
    local tip = self:getChildByName("TIP")
    if tip then
        self:removeChildByName("TIP")
    end
end

function PetLookMainView:bindModel()

end

function PetLookMainView:unbindModel()

end

return PetLookMainView

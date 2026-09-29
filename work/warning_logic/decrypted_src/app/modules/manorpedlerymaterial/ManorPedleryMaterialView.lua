------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2023/01/31
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorPedleryMaterialView = class("ManorPedleryMaterialView", UI.HWBtnComponent)
local GameInManorManager = require "app.game.GameInManorManager"

-- 资源
local COM_RES_LIST = {
    "ui_town_manor.plist",
}

local COM_WIDTH = 486
local COM_HEIGHT = 356

local director = cc.Director:getInstance()
local winSize = director:getWinSize()

function ManorPedleryMaterialView:ctor()
    ManorPedleryMaterialView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._mList = {}
end

function ManorPedleryMaterialView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorpedlerymaterial", "ManorPedleryMaterial", false)
    ManorPedleryMaterialView.super.init(self, ... )
end

function ManorPedleryMaterialView:dtor()
    ManorPedleryMaterialView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorpedlerymaterial.ManorPedleryMaterialView")
end


function ManorPedleryMaterialView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_manor_paper.png")
    bg:center()
    self:addChild(bg)
    self._bg = bg

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local lineImg = UI.Image:create()
    lineImg:init("ui_manor_line3.png")
    lineImg:centerUp(45)
    contentLayout:addChild(lineImg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_221808, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 39, g = 40, b = 44})
    titleText:centerUp(31)
    contentLayout:addChild(titleText)

    local lineImg2 = UI.Image:create()
    lineImg2:init("ui_manor_line2.png")
    lineImg2:centerUp(66)
    contentLayout:addChild(lineImg2)

    local lineImg3 = UI.Image:create()
    lineImg3:init("ui_manor_line2.png")
    lineImg3:centerBottom(80)
    contentLayout:addChild(lineImg3)

    local titleText2 = UI.Text:create()
    titleText2:init(UI.TEXT_221809, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 89, g = 21, b = 5})
    titleText2:centerBottom(40)
    contentLayout:addChild(titleText2)

    self._mList = {}

    local allConf = ConfigManager:getAllTravelShopData()
    local unlockMaterials = GameInManorManager:getInstance():getMateriaRouteList()
    for k,v in ipairs(allConf) do
        if GameInManorManager:getInstance():havaMateriaRoute(v.ID) then
            table.insert(self._mList,v.ID)
        end
    end


    local tableview = UI.TableView.new({}, 380, 196)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableview:centerBottom(90)
    tableview:setDelegate()
    -- tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init()
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 380, 46;
    end);
    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                local cData = ConfigManager:getAllTravelShopDataByID(self._mList[index])
                local boxName = LanguageManager:getInstance():getLocalString(cData.name)
                local normlState = GameInManorManager:getInstance():isSelectRaderMaterialId(cData.ID)
                cell = self:createCheckBoxWithLabel(boxName,normlState,cData.ID)
            end,
            function(e)
                printError("------------------------ActivityModeCaveMainView:tableCellAtIndex-----------------error")
            end, 1)
        else
            local desCell = cell:getChildByName("desCell")
            if desCell and tolua.isnull(desCell) then
                desCell:removeFromParent()
                desCell = nil
            end
            cell:removeFromParent()
            local cData = ConfigManager:getAllTravelShopDataByID(self._mList[index])
            local boxName = LanguageManager:getInstance():getLocalString(cData.name)
            local normlState = GameInManorManager:getInstance():isSelectRaderMaterialId(cData.ID)
            cell = self:createCheckBoxWithLabel(boxName,normlState,cData.ID)
        end

        return cell;
    end);

    tableview:onUpdateCellNumbers(function ()
        return table.nums(self._mList)
    end);

    -- tableview:onTableCellTouched(function(table, cell)
    --     if not cell then
    --         return
    --     end

    --     local clickIndex = cell:getIdx() + 1

    --     Net.NetRankSystem:requestCustomRankHeroDetailData(PublicDefine.CustomRankType.CustomRankType_TrialLand,
    --         self._trialModelID, self._ranklistData[clickIndex].pk)

    -- end)

    self.contentLayout:addChild(tableview, 100)
    tableview:reloadData(true)
    self.tableview = tableview


end

function ManorPedleryMaterialView:createCheckBoxWithLabel(text, normlState,materialId)
    local boxLayout = UI.Layout:create()
    boxLayout:init()
    boxLayout:enableAutoWidth()
    boxLayout:enableAutoHeight()

    local boxItself = UI.CheckBox:create() 
    boxItself:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_1.png")
    boxItself:floatLeft(0)
    boxItself:setValue(normlState and normlState or false)
    boxItself:setName("boxItself")
    boxLayout:addComponent(boxItself)
    boxItself:addEventListener(UI.Event.CHECKBOX_STATUS_CHANGED, self, function(self, comp, isChecked, isByTouch)
        if not normlState then
            Net.NetManorSystem:reqChoosePedleryMaterial(materialId)
        end
    end)

    if normlState then
        boxItself._state = ButtonState.DISABLE
    end

    local boxLabel = UI.Text:create()
    boxLabel:init(text, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    --boxLabel:setWidth(240)
    boxLabel:setTextLeft()
    -- boxLabel:autoAdapt()
    -- boxLabel:setLineSpacing(-6)
    boxLabel:floatLeft(9)
    boxLayout:addComponent(boxLabel)

    boxLayout:centerLeft(70,0)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(380, 46))
    cell:addChild(boxLayout)

    return cell
end

function ManorPedleryMaterialView:reloadChoosePedleryMaterial(materialId)
    self.tableview:reloadData()

    local cData = ConfigManager:getAllTravelShopDataByID(materialId)
    if cData then
        UI.ScrollBar:createByText(string.format(UI.TEXT_221811, LanguageManager:getInstance():getLocalString(cData.name)))
    end
end

function ManorPedleryMaterialView:bindModel()

end


function ManorPedleryMaterialView:unbindModel()

end





return ManorPedleryMaterialView













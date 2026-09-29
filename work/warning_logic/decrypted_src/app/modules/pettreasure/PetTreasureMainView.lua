------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/24
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasureMainView = class("PetTreasureMainView", UI.HWBtnComponent)

-- require "app.modules.pettreasure.PettreasureMainTabCell"


-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_general_big_number.plist",
    "ui_common_information.plist",
    "ui_common_btn.plist",
    "ui_town_upgrade.plist",
    "ui_common_symbol.plist",
    "ui_pet_treasure.plist",
}

local COM_WIDTH = 920
local COM_HEIGHT = 580
local INNER_WIDTH = 880
local INNER_HEIGHT = 560
local BTN_CELL_W = 109
local BTN_CELL_H = 70

function PetTreasureMainView:ctor()
    PetTreasureMainView.super.ctor(
    	self,
    	UI.Type.PET_TREASURE_MAIN,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)
end

function PetTreasureMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasureMainView.super.init(self, ... )
end

function PetTreasureMainView:dtor()
    PetTreasureMainView.super.dtor(self)
    self:unbindModel()

    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_PET_INFO_TIP, self, self.showTip)

    reload_script_file_mvc("app.modules.pettreasure.PetTreasureMainView")
end

function PetTreasureMainView:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_bg_box2.png")
    bg:center()
    contentLayout:addChild(bg)

    -- 内部背景图片
    local innerContentLayout = UI.Layout:create();
    innerContentLayout:init()
    innerContentLayout:setSize(INNER_WIDTH, INNER_HEIGHT)
    innerContentLayout:center()
    -- innerContentLayout:enableDebugDraw()
    self.innerContentLayout = innerContentLayout
    contentLayout:addChild(innerContentLayout)

    -- 标题背景图片
    local bgTitle  = UI.Image:create();
    bgTitle:init("ui_bg_title.png");
    bgTitle:centerUp(-14);
    contentLayout:addChild(bgTitle);

    local titleTxtLayout = UI.Layout:create();
    titleTxtLayout:init()
    titleTxtLayout:setSize(235, 50)
    titleTxtLayout:leftUp(350, -10)
    contentLayout:addChild(titleTxtLayout)

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1314100, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_150_150_150)
    titleTxt:center()
    titleTxtLayout:addChild(titleTxt)

    -- 左侧人像
    local leftManImg  = UI.Image:create()
    leftManImg:init("ui_pettreasure_statue_1.png")
    leftManImg:leftBottom(-80, -6)
    contentLayout:addChild(leftManImg)
    self.leftManImg = leftManImg

    local leftWaterEff = UI.Animation:create()
    leftWaterEff:init("effect_ui_town_pettreasure_statue.json", "effect_ui_town_pettreasure_statue.atlas", 1) -- effect_ui_town_pettreasure_clearup
    leftWaterEff:leftBottom(66, 0)
    leftWaterEff:setAnimation("idle", true)
    leftManImg:addChild(leftWaterEff)

    -- 右侧人像
    local rightManImg  = UI.Image:create()
    rightManImg:init("ui_pettreasure_statue_2.png")
    rightManImg:leftBottom(880, -6)
    contentLayout:addChild(rightManImg)
    self.rightManImg = rightManImg

    local rightWaterEff = UI.Animation:create()
    rightWaterEff:init("effect_ui_town_pettreasure_statue.json", "effect_ui_town_pettreasure_statue.atlas", 1)
    rightWaterEff:leftBottom(66, 0)
    rightWaterEff:setAnimation("idle", true)
    rightManImg:addChild(rightWaterEff)

    self:makeTabList()
    printInfo(RoleDataManager:getMaster():getPK())
end

function PetTreasureMainView:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_1314101
    tab1.event = "PetTreasure_Open_Gather_View"
    tab1.select = false
    tab1.rootLayer = self.innerContentLayout

    local tab2 = {}
    tab2.idx = 2
    tab2.name = UI.TEXT_1314111
    tab2.event = "PetTreasure_Open_Challenager_View"
    tab2.select = false
    tab2.rootLayer = self.innerContentLayout

    local tab3 = {}
    tab3.idx = 3
    tab3.name = UI.TEXT_1314112
    tab3.event = "PetTreasure_Open_Fragment_Compound_View"
    tab3.select = false
    tab3.rootLayer = self.innerContentLayout

    local tab4 = {}
    tab4.idx = 4
    tab4.name = UI.TEXT_221107
    tab4.event = "PetTreasure_Open_Pet_Adventure_View"
    tab4.select = false
    tab4.rootLayer = self.innerContentLayout

    table.insert(self.btnData, tab1)
    table.insert(self.btnData, tab2)
    table.insert(self.btnData, tab3)
    table.insert(self.btnData, tab4)

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 300);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-100, 60)
    -- self._tableView:enableDebugDraw()
    self._tableView:setDelegate();
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    self._tableView:setBounceable(false);
    self._tableView:init();
    self._tableView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:setContentSize(cc.size(109, 68))
                self.btnData[index].cell = cell

                local image = UI.Image.create()
                image:init("ui_btn_gray2_1.png")
                image:centerBottom(0)
                image:setName("image")
                cell:addChild(image)

                local text = UI.Text:create()
                text:init(self.btnData[index].name, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                text:centerBottom(20)
                text:setWidth(107)
                text:setTextCenter()
                text:setLineSpacing(-6)
                text:setName("cellText")
                cell:addChild(text)

                local redPoint = AvalonUtil.createRedPoint(cell, 2, 2, 100)
                redPoint:setName("redPoint")
                redPoint:hide()
                if index == 3 and self.btnData[3].select == false then
                    if #mvc.petTreasureModel:getFragmentsBag() == mvc.petTreasureModel:getFragmentsTotalNum() 
                    and GameManager:getNormalServerTime() > mvc.petTreasureModel:getFragmentCompoundTime() then
                        redPoint:show()
                    else
                        redPoint:hide()
                    end
                else
                    redPoint:hide()
                end
                if index == 4 then
                    local cfgData = ConfigManager:getFunctionUnlockCfgData(PublicDefine.UnlockFunctionType.UnlockFunctionType_PetAdventure)
                    if cfgData then
                        local heroData = RoleDataManager:getMaster()
                        if heroData:getLevel() < cfgData.value[1] or not MasterDataManager:getCaptainPet() then
                            if not cell:getChildByName("lock") then
                                local lock = UI.Image.create()
                                lock:init("ui_information_big_lock.png")
                                lock:rightUp(0, -5)
                                lock:setName("lock")
                                lock:setScale(0.5)
                                cell:addChild(lock)
                            end
                        else
                            local lock = cell:getChildByName("lock")
                            if lock then
                                lock:removeFromParent()
                                lock = nil
                            end
                        end
                    end
                end 
                if self.btnData[index].select then
                    text:setFontColor(UI.FONT_COLOR_218_211_154)
                    image:setSpriteName("ui_btn_gray2_1.png")
                else
                    text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_btn_gray2_0.png")
                end
            end,
            function(e) 
                printError("------------------------PetTreasureMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            if self.btnData[index].select then
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_218_211_154)
                cell:getChildByName("image"):setSpriteName("ui_btn_gray2_1.png")
            else
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_btn_gray2_0.png")
            end

            if self.btnData[3].select == false then
                if #mvc.petTreasureModel:getFragmentsBag() == mvc.petTreasureModel:getFragmentsTotalNum() 
                and GameManager:getNormalServerTime() > mvc.petTreasureModel:getFragmentCompoundTime() then
                    self.btnData[3].cell:getChildByName("redPoint"):show()
                else
                    self.btnData[3].cell:getChildByName("redPoint"):hide()
                end
            else
                self.btnData[3].cell:getChildByName("redPoint"):hide()
            end

            if self.btnData[4].select == false then
                local remainTime = mvc.petTreasureModel:getExploreRemainTime()
                if (mvc.petTreasureModel:getExploreState() and remainTime <= 0) then
                    self.btnData[4].cell:getChildByName("redPoint"):show()
                else
                    self.btnData[4].cell:getChildByName("redPoint"):hide()
                end
            else
                self.btnData[4].cell:getChildByName("redPoint"):hide()
            end
        end

        return cell;
    end);

    self._tableView:onUpdateCellNumbers(function ()
        return table.nums(self.btnData);
    end);

    self._tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        local clickIndex = cell:getIdx() + 1

        if self.curTabIndex == clickIndex then
            return
        end

        mvc.send("PetTreasure_Click_Tab", clickIndex)
    end)

    self.contentLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end

function PetTreasureMainView:bindModel()

end

function PetTreasureMainView:unbindModel()

end

return PetTreasureMainView

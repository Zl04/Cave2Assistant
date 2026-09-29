------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/06/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetRecyclingShopView = class("PetRecyclingShopView", UI.HWBtnComponent)

local SceneManager = require("app.game.SceneManager")

-- 资源
local COM_RES_LIST = {
    "ui_general_shop.plist",
    "ui_town_guild_create.plist",
    "ui_common_btn.plist",
    "ui_pet_treasure.plist",
    "ui_common_information.plist",
    "ui_town_dream_common.plist",
}

local COM_WIDTH = 980
local COM_HEIGHT = 600
local INNER_WIDTH = 705
local INNER_HEIGHT = 386
local BTN_CELL_W = 109
local BTN_CELL_H = 70
local DUST_ID = 22070570

function PetRecyclingShopView:ctor()
    PetRecyclingShopView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self:bindModel()
end

function PetRecyclingShopView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetRecyclingShopView.super.init(self, ... )
end

function PetRecyclingShopView:dtor()
    PetRecyclingShopView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.pettreasure.PetRecyclingShopView")
end

function PetRecyclingShopView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center(0, 30)
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_guild_create_banner_box.png")
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
    bgTitle:centerUp(-7);
    contentLayout:addChild(bgTitle);

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1324201, UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_150_150_150)
    titleTxt:center()
    bgTitle:addChild(titleTxt)

    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark2.png")
    splitLine:setContentSize(733, 2)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(100+733/2, 514)
    contentLayout:addChild(splitLine)

    -- 左侧蛋图
    local leftManImg  = UI.Image:create()
    leftManImg:init("ui_recovery_foreground_left.png")
    leftManImg:leftBottom(-46, 4)
    contentLayout:addChild(leftManImg)
    self.leftManImg = leftManImg

    -- 右侧老鼠
    local rightWaterEff = UI.Animation:create()
    rightWaterEff:init("effect_ui_recovery_rat.json", "effect_ui_recovery_rat.atlas", 1)
    rightWaterEff:leftBottom(934, 4)
    rightWaterEff:setAnimation("idle1", true)
    contentLayout:addChild(rightWaterEff)
    self.rightWaterEff = rightWaterEff
    rightWaterEff._spine:registerSpineEventHandler(function (event)
        if(event and event.eventData and event.eventData.name) then
            local startPos = string.find(event.eventData.name, "sound_")
            if(startPos ~= nil) then
                -- TODO 播放音效文件
                local soundFilename = string.sub(event.eventData.name,7,-1)
                Avalon.AudioManager:playDynamicSound(soundFilename, false, RoleDataManager:getMaster():getCoord())
            end

            local shakePos = string.find(event.eventData.name, "hitshake_")
            if(shakePos ~= nil) then
                -- 播放抖动
                local shake = string.sub(event.eventData.name,10,-1)
                if(shake) then 
                    Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, shake)
                end
            end
        end
    end, sp.EventType.ANIMATION_EVENT)

    -- 设置下一个动作
    local nextActionName = "idle" .. math.random(2, 3)
    rightWaterEff:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function()
        if not nextActionName then
            nextActionName = "idle1"
            rightWaterEff:setAnimation(nextActionName, true)
            nextActionName = "idle" .. math.random(2, 3)
        elseif nextActionName and nextActionName ~= "idle1" then
            rightWaterEff:setAnimation(nextActionName, false)
            nextActionName = nil
        end
    end)

    -- 粉尘图标
    local dustIcon = UI.Image:create()
    dustIcon:init("symbol_gaming_souldust.png")
    dustIcon:rightUp(226, 52)
    contentLayout:addChild(dustIcon)

    -- 碎片数量
    local dustNum  = UI.Text:create()
    dustNum:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_190_190_190)
    dustNum:setTextLeft()
    dustNum:centerLeft(26)
    dustIcon:addChild(dustNum)
    self.dustNum = dustNum
    self:updateDustNum()

    -- 前往宠物炼化按钮
    local refineBtn =  UI.Button:create()
    refineBtn:init("ui_recovery_skip_btn_0.png","ui_recovery_skip_btn_1.png","ui_recovery_skip_btn_1.png")
    refineBtn:leftUp(84, 38)
    refineBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if not (SceneManager:getInstance():isNotInFightScene()) then
            UI.ScrollBar:createByText(UI.TEXT_1213665)
            return
        end

        if not RoleDataManager:getScreenFightPetData() then
            UI.ScrollBar:createByText(UI.TEXT_1324202)
            return
        end

        -- 跳转界面
        mvc.openPanel("Pet", "PetMain", {tabIdx=4})
    end)
    contentLayout:addChild(refineBtn)

    -- 目前仅一个物资兑换不涉及页签，暂时屏蔽
    -- self:makeTabList()
end

function PetRecyclingShopView:makeTabList()
    self.btnData = {}
    self.curTabIndex = 0
    self.lastTabIndex = 0

    local tab1 = {}
    tab1.idx = 1
    tab1.name = UI.TEXT_1314101
    tab1.event = "PetTreasure_Open_Gather_View"
    tab1.select = false
    tab1.rootLayer = self.innerContentLayout

    table.insert(self.btnData, tab1)

    self._tableView = UI.TableView.new({}, BTN_CELL_W + 10, 300);
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    self._tableView:rightUp(-46, 90)
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
                image:init("ui_dreamword_rankinglist_btn_0.png")
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

                if self.btnData[index].select then
                    text:setFontColor(UI.FONT_COLOR_218_211_154)
                    image:setSpriteName("ui_dreamword_rankinglist_btn_1.png")
                else
                    text:setFontColor(UI.FONT_COLOR_41_41_45)
                    image:setSpriteName("ui_dreamword_rankinglist_btn_0.png")
                end
            end,
            function(e) 
                printError("------------------------PetTreasureMainView:tableCellAtIndex-----------------error")
            end, 1);
        else
            if self.btnData[index].select then
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_218_211_154)
                cell:getChildByName("image"):setSpriteName("ui_dreamword_rankinglist_btn_1.png")
            else
                cell:getChildByName("cellText"):setFontColor(UI.FONT_COLOR_41_41_45)
                cell:getChildByName("image"):setSpriteName("ui_dreamword_rankinglist_btn_0.png")
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

        mvc.send("PetTreasure_RecyclingShop_Click_Tab", clickIndex)
    end)

    self.contentLayout:addChild(self._tableView, 100)
    self._tableView:reloadData(true)
end


function PetRecyclingShopView:updateDustNum()
    local pk = RoleDataManager:getMaster():getPK()
    local dustTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, DUST_ID)
    self.dustNum:setText(self.dustNum:numformat(string.format("%s", dustTotalNum)))
    self.dustNum:updateView()
end


function PetRecyclingShopView:bindModel()

end


function PetRecyclingShopView:unbindModel()

end





return PetRecyclingShopView













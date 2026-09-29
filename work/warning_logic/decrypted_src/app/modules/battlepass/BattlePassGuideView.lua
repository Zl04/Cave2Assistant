------------------------------------------------------------------------------
--author: 
--date	: 2019/08/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BattlePassGuideView = class("BattlePassGuideView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local cfgList = {{icon = "ui_unlock_function_icon_14.png", title = UI.TEXT_1212910, content = UI.TEXT_1212912, jumpLayerId = GameMessage.MC_UI_JUMP_IAP_GOLD_BOX}, 
                 {icon = "ui_unlock_function_icon_46.png", title = UI.TEXT_1212911, content = UI.TEXT_1212913, jumpLayerId = GameMessage.MC_UI_JUMP_ACTIVITY_POINT}}


local COM_WIDTH = 330
local COM_HEIGHT = 465
local layoutUU
function BattlePassGuideView:ctor()
    BattlePassGuideView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    layoutUU = UIUtil:createAutoUILayout("BattlePassGuideView","app.modules.battlepass.BattlePassPosConfig", false)
end

function BattlePassGuideView:dtor()
    BattlePassGuideView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.battlepass.BattlePassGuideView")
end


function BattlePassGuideView:onInitView()
    self:showLucencyLight()
    
    local bg = UI.Image:create()
    bg:init("ui_passcheck_banner_box.png")
    bg:centerUp(0)
    self:addChild(bg)

    local title = UI.Text:create()
    title:init(UI.TEXT_1212909, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_51_51_51)
    title:centerUp(11)
    bg:addChild(title)

      --tableview
    local tableview = UI.TableView.new({}, 315, 382)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableview:leftBottom(10, 15)
    tableview:setDelegate()
    tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init(0)
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return 311, 175;
    end);

    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.BattlePassGuideCell.new();
            cell:init(cfgList[idx + 1]);
        end,
        function(e) 
            printError("------------------------BattlePassGuideView:tableCellAtIndex-----------------error")
        end, 1);

        return cell;
    end);

    tableview:onUpdateCellNumbers(function ()
        return #cfgList
    end);

    self:addChild(tableview)
    tableview:reloadData(true)
end


function BattlePassGuideView:bindModel()

end


function BattlePassGuideView:unbindModel()

end



---tablecell--begin----------
local BattlePassGuideCell = class("BattlePassGuideCell", UI.TableViewCell)
UI.BattlePassGuideCell = BattlePassGuideCell


function BattlePassGuideCell:ctor()

end

function BattlePassGuideCell:onEnter()
    BattlePassGuideCell.super.onEnter(self);
end

function BattlePassGuideCell:onExit()
    BattlePassGuideCell.super.onExit(self);
end

function BattlePassGuideCell:init(data)
    self.data = data or {};
    self:onInitView();
end

function BattlePassGuideCell:onInitView()
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(296, 162)
    layout:leftBottom(5, 0)
    self:addChild(layout, 1000)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_setup_banner_box_up.png", cc.rect(0,0,1,1))
    bg:setContentSize(cc.size(296, 162))  
    bg:setPosition(cc.p(bg:getContentSize().width / 2 + 8, bg:getContentSize().height / 2))
    self:addChild(bg)

    local icon = UI.Image:create()
    icon:init(self.data.icon)
    icon:leftUp(-20, 20)
    bg:addChild(icon, 10)

    local splitLine2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    splitLine2:setContentSize(170, 1.1)
    splitLine2:setCapInsets(CCRectMake(1,0,1,1))
    splitLine2:setPosition(180, 120)
    bg:addChild(splitLine2, 10)

    local title = UI.Text:create()
    title:init(self.data.title, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
    title:leftUp(95, 10)
    bg:addChild(title, 10)

    local content = UI.Text:create()
    content:init(self.data.content, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    content:leftUp(95, 45)
    content:setSize(160, 100)
    content:setTextVerticalCenter()
    bg:addChild(content, 10)
    -- content:enableDebugDraw()

    --button
    local starButton = UI.Button:create() 
    starButton:init()
    starButton:setSize(50,50)
    starButton:centerRight(0)
    bg:addChild(starButton, 10)

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_general_minimap_tishi.json", "effect_ui_general_minimap_tishi.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:center()
    starButton:addChild(detailAnimation, 10)    

    layout:setTouchEnable(true)
    layout:addEventListener(UI.Event.COMPONENT_CLICK, self, self.jumpLayer)
end

function BattlePassGuideCell:jumpLayer()
    local layerId = self.data.jumpLayerId
    GameManager:openUrl("jumpLayer://"..layerId, function()
        mvc.closePanel("BattlePass", "BattlePassGuide")
    end)
end
----tablecell--end----------


return BattlePassGuideView













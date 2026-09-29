------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/21
--desc	: 
------------------------------------------------------------------------------

local SettingAreaServerSelectCellView = require("app.modules.setting.SettingAreaServerSelectCellView")

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SettingAreaServerSelectView = class("SettingAreaServerSelectView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_package_setup.plist",
    "ui_town_upgrade.plist",
    "ui_common_btn.plist",
}

local COM_WIDTH = 700
local COM_HEIGHT = 485

function SettingAreaServerSelectView:ctor(areaType)
    SettingAreaServerSelectView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.areaType = areaType
    -- 1 表示所有服务器，2 表示有角色的服务器
    self._fliterType = 1
    self._areaServerList = {}
    self:refreshGetAreaList()
end

function SettingAreaServerSelectView:init( ... )

    SettingAreaServerSelectView.super.init(self, ... )
end

function SettingAreaServerSelectView:dtor()
    SettingAreaServerSelectView.super.dtor(self)
    self:unbindModel()
    self.areaType = nil
    -- reload_script_file_mvc("app.modules.setting.SettingAreaServerSelectView")
end


function SettingAreaServerSelectView:onInitView()
    self:showLucencyLight(COM_WIDTH, COM_HEIGHT)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_setup_banner_box6.png")
    bg:setCapInsets(CCRectMake(126, 114, 2, 2))
    bg:setAnchorPoint(0, 0)
    bg:setContentSize(cc.size(COM_WIDTH, COM_HEIGHT))
    self:addChild(bg)

    -- 
    local changeBg = UI.Image:create()
    changeBg:init("ui_setup_server_role_btn_box.png")
    changeBg:rightUp(41, 20)
    bg:addChild(changeBg)

    -- 标题
    local titleBg = UI.Image:create()
    titleBg:init("ui_upgrade_title_02.png")
    titleBg:centerUp(20)
    bg:addChild(titleBg)

    -- 根据类型初始化相关的界面
    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1324360, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    titleTxt:center()
    titleBg:addChild(titleTxt)
    self.titleTxt = titleTxt
    
    local fliterBtn = UI.Button:create()
    fliterBtn:init(
        "ui_setup_server_role_btn_0.png",
        "ui_setup_server_role_btn_1.png",
        "ui_setup_server_role_btn_2.png"
    )
    self.fliterBtn = fliterBtn
    self:refreshFliterBtnImage()
    fliterBtn:center()
    fliterBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onFliterAreaServer)
    changeBg:addChild(fliterBtn, 100)

    -- 上边的分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    lineUpImage:setContentSize(650, 2)
    lineUpImage:setCapInsets(CCRectMake(1, 0, 1, 1))
    lineUpImage:setPosition(cc.p(350, COM_HEIGHT - 75))
    bg:addChild(lineUpImage, 4)
    

    local tableWidth = 650
    local tableHeight = 383
    local tableview = UI.TableView.new({}, tableWidth, tableHeight)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableview:centerBottom(20)
    tableview:setDelegate()
    tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init(0)
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return tableWidth, 71;
    end);

    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        -- cell = nil
        if(cell == nil) then 
            xpcall(function()
                cell = UI.TableViewCell:create()
                cell:init()

                local listCell = SettingAreaServerSelectCellView:create()
                listCell:init(self.areaType)
                listCell:setData(self._areaServerList, idx)
                listCell:setName("cell")
                listCell:leftBottom(0, 0)
                cell:addChild(listCell)
            end,
            function(e) 
                printError("------------------------BattlePassRewardView:tableCellAtIndex-----------------error")
            end, 1);
        else
            local listCell = cell:getChildByName("cell")
            if(listCell) then 
                listCell:setData(self._areaServerList, idx)
            end
        end

        return cell;
    end);

    tableview:onUpdateCellNumbers(function ()
        return self:getCellNum()
    end);

    self.tableview = tableview
    bg:addChild(tableview)
    self.tableview:reloadData()
end

function SettingAreaServerSelectView:getCellNum()
    -- print("SettingAreaServerSelectView:getCellNum", #self._areaServerList)
    if(self._areaServerList) then 
        local cell,cellYu = math.modf(#self._areaServerList /3)
        if(cellYu ~= 0) then 
            cell = cell + 1
        end
        -- print("SettingAreaServerSelectView:getCellNum 11", cell)
        return cell
    end

    return 0
end

function SettingAreaServerSelectView:onFliterAreaServer()
    if(self._fliterType == 1) then 
        self._fliterType = 2
        self.titleTxt:setText(UI.TEXT_1324361)
    else 
        self._fliterType = 1
        self.titleTxt:setText(UI.TEXT_1324360)
    end

    self:refreshGetAreaList()

    if(self.tableview) then 
        self.tableview:reloadData()
    end

    self:refreshFliterBtnImage()
end

function SettingAreaServerSelectView:refreshGetAreaList()
    if(self.areaType == Game.AREA_TYPE.AREA_TYPE_MAINLAYER) then
        if(self._fliterType == 1) then 
            self._areaServerList = ServerConfigUtil:getAreaListData()
        else 
            self._areaServerList = ServerConfigUtil:getAreaListDataForHaveRole()
        end
    else
        if(self._fliterType == 1) then 
            self._areaServerList = mvc.settingModel:getAreaListData()
        else 
            self._areaServerList = mvc.settingModel:getAreaListDataForHaveRole()
        end
    end
end

function SettingAreaServerSelectView:refreshFliterBtnImage()
    if self.fliterBtn then
        local fliterBtn = self.fliterBtn
        if(self._fliterType == 1) then 
            fliterBtn:setNormal("ui_setup_server_role_btn_0.png")
            fliterBtn:setSelected("ui_setup_server_role_btn_1.png")
            fliterBtn:setDisabled("ui_setup_server_role_btn_2.png")
        elseif(self._fliterType == 2) then 
            fliterBtn:setNormal("ui_setup_server_role_btn_1.png")
            fliterBtn:setSelected("ui_setup_server_role_btn_0.png")
            fliterBtn:setDisabled("ui_setup_server_role_btn_2.png")
        end
    end
end

function SettingAreaServerSelectView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_LOGIN_REFRESH_AREAINFO,self,self.responseAreaList)
end

function SettingAreaServerSelectView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LOGIN_REFRESH_AREAINFO,self,self.responseAreaList)
end

function SettingAreaServerSelectView:responseAreaList()
    print("SettingAreaServerSelectView:responseAreaList")
    self:refreshGetAreaList()
    if(self.tableview) then 
        self.tableview:reloadData()
    end
end

return SettingAreaServerSelectView













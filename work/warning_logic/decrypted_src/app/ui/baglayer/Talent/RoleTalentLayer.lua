--[[
-- RoleTalentLayer.lua
-- Author:ydli
-- 2018年1月2日
-- Using:人物天赋界面
]]

local GameDataManager = require("app.game.GameDataManager")
require("app.ui.baglayer.Talent.RoleTalentCell")

UI = UI or {}
local RoleTalentLayer = class("RoleTalentLayer", UI.HWBtnComponent)
UI.RoleTalentLayer = RoleTalentLayer

local winSize = cc.Director:getInstance():getWinSize()
-- local LAYER_SIZE = cc.size(942, 534)
local LAYER_SIZE = cc.size(973, 545)

local CELL_WIDTH = 200
local CELL_HEIGHT = 95

local COM_RES_LIST = {
    "ui_package_roleTalent.plist",
    "ui_package_skill.plist",
    "ui_general_big_number.plist"
}

--id  表示profileMainTalent.lua 的 ID
local qualityImage = {
    [1] = "ui_talent_circle_red_up.png",
    [2] = "ui_talent_circle_yellow_up.png",
    [3] = "ui_talent_circle_green_up.png",
    [4] = "ui_talent_circle_purple_up.png",
    [5] = "ui_talent_circle_blue_up.png",
    [6] = "ui_talent_circle_blue_up.png"
}
-- 构造函数
function RoleTalentLayer:ctor()
    RoleTalentLayer.super.ctor(self, UIType.ROLE_TALENT_LAYER, COM_RES_LIST, LAYER_SIZE.width, LAYER_SIZE.height)
    self.iconPanels = {}
    self.selectKey = nil
    self._tableCellArr = {}
    self.dataList = GameDataManager:getAllRoleTalents()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_ROLE_TALENT, self, self.refreshTalentById) 
end

--析构函数
function RoleTalentLayer:dtor()
    RoleTalentLayer.super.dtor(self)
    self._tableCellArr = {}
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_ROLE_TALENT, self, self.refreshTalentById) 
    reload_script_file("app.ui.baglayer.Talent.RoleTalentLayer")
end

-- 初始化
function RoleTalentLayer:init()
    RoleTalentLayer.super.init(self)
end

-- 初始化视图
function RoleTalentLayer:onInitView()
    local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    centerBg:setContentSize(942, 534)
    centerBg:setCapInsets(CCRectMake(304,141,1,1))
    centerBg:setPosition(cc.p(LAYER_SIZE.width / 2 + 5, LAYER_SIZE.height / 2))
    self:addChild(centerBg)
    self.centerBg = centerBg
    
    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine:setContentSize(902, 2)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(471, 487)
    centerBg:addChild(splitLine)

    local name = UI.Text:create()
    name:init(UI.TEXT_1212095, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    local left = 90 - name:getContentSize().width / 2
    left = left < 1 and 1 or left
    name:leftUp(left, 12)
    centerBg:addChild(name, 10)

    local talentName = UI.Text:create()
    talentName:init(UI.TEXT_1212096..":", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    talentName:rightUp(35, 12)
    centerBg:addChild(talentName, 10)
    self.talentName = talentName

    local goodsData = GoodsDataManager:createLocalGoodsData(ROLE_TALENT_STONE_GOODSID)
    local talentIcon = UI.Image:create()
    talentIcon:init(goodsData:getSmallIconName())
    talentIcon:rightBottom(23, 494)
    centerBg:addChild(talentIcon, 115)
    self.talentIcon = talentIcon

    local talentNumber = UI.Text:create()
    talentNumber:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    talentNumber:rightUp(35, 12)
    centerBg:addChild(talentNumber, 10)
    self.talentNumber = talentNumber

    local bg2 = UI.Image:create()
    bg2:init("ui_talent_paper.png")
    bg2:rightBottom(23, 9)
    centerBg:addChild(bg2, 5)
    
    --技能大类型 展现
    local bg3 = cc.Scale9Sprite:createWithSpriteFrameName("ui_tips_box_02.png")
    bg3:setContentSize(657, 90)
    bg3:setPosition(370, 404)
    bg2:addChild(bg3)
 
    local bigIcon = UI.Image:create()
    bigIcon:init("ui_unlock_function_icon_3.png")
    bigIcon:centerLeft(12)
    bg3:addChild(bigIcon)
    bigIcon:setScale(0.8)
    self.bigIcon = bigIcon

    local bigIconName = UI.Text:create()
    bigIconName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    bigIconName:leftUp(101, 15)
    bg3:addChild(bigIconName)
    self.bigIconName = bigIconName

    local bigIconLevel = UI.Text:create()
    bigIconLevel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    bigIconLevel:leftUp(101, 51)
    bg3:addChild(bigIconLevel)
    self.bigIconLevel = bigIconLevel

    local externSkillIconBg =  UI.Image:create()
    externSkillIconBg:init("ui_talent_skill_bg.png")
    externSkillIconBg:centerLeft(332)
    bg3:addChild(externSkillIconBg)
    externSkillIconBg:setTouchEnable(true)
    externSkillIconBg:addEventListener(UI.Event.COMPONENT_CLICK, self,function ()
        self:externSkillClick()           
    end)

    local externSkillIcon =  UI.Image:create()
    externSkillIcon:init("ui_talent_skill_bg.png")
    externSkillIcon:center()
    externSkillIconBg:addChild(externSkillIcon)
    self.externSkillIcon = externSkillIcon

    local iconCap = UI.Image:create()
    iconCap:init("ui_talent_btn_2.png")
    iconCap:center()
    externSkillIconBg:addChild(iconCap)  
    self.iconCap = iconCap

    local lock = UI.Image:create()
    lock:init("ui_talent_btn_lock.png")
    lock:center()
    iconCap:addChild(lock)  
    lock:setName("LOCK")

    local externSkillName = UI.Text:create()
    externSkillName:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    externSkillName:leftUp(419, 15)
    bg3:addChild(externSkillName)
    self.externSkillName = externSkillName

    local externSkillDesc = UI.Text:create()
    externSkillDesc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_13PX, UI.FONT_COLOR_80_5_5)
    externSkillDesc:leftUp(419, 43)
    externSkillDesc:setDimensions(235, 45)
    externSkillDesc:setLineSpacing(-2)
    externSkillDesc:setTextVerticalCenterAndHLeft()
    bg3:addChild(externSkillDesc)
    self.externSkillDesc = externSkillDesc

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(675, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(368, 345))
    bg2:addChild(lineUpImage)
    --技能大类型 展现

    local cap =  UI.Image:create()
    cap:init("ui_talent_paper_mack.png")
    cap:leftBottom(6, 5)
    bg2:addChild(cap, 30)

    local height = 55
    local i = 1
    local firstKey = nil
    for k, v in pairs(self.dataList) do
        -- local cell = self:createOneClickIcon(k)
        -- cell:setScale(0.8)
        -- cell:leftUp(18, height + (i - 1) * 90)
        -- centerBg:addChild(cell) 
        self.iconPanels[k] = cell
        if firstKey == nil then
            firstKey = k
        end
        i = i + 1
    end

    self:makeTabList()

    self.tableView = cc.TableView:create(cc.size(672, 329))
    self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.tableView:setPosition(cc.p(35, 11))
    self.tableView:setDelegate()
    self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    bg2:addChild(self.tableView, 20)
    self.tableView:initScrollBar()
    self.tableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)

    self.tableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.tableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.tableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    self.tableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.tableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.tableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    self.tableView:registerScriptHandler(handler(self,self.tableCellWillRecycle),cc.TABLECELL_WILL_RECYCLE)
    self:refreshIconPanel(firstKey)
end

function RoleTalentLayer:makeTabList()
    self.mainTalentTableView = UI.TableView.new({}, CELL_WIDTH, 430)
    self.mainTalentTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.mainTalentTableView:leftUp(-18, 70)
    -- self.mainTalentTableView:enableDebugDraw()
    self.mainTalentTableView:setDelegate()
    self.mainTalentTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.mainTalentTableView:setBounceable(true)
    self.mainTalentTableView:init()
    self.mainTalentTableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT
    end)

    self.mainTalentTableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createTabCell(index)
            end,
            function(e)
                printError("------------------------RoleTalentLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            local mainTalentCell = cell:getChildByName("mainTalentCell")
            if mainTalentCell then
                mainTalentCell:removeFromParent(true)
                mainTalentCell = nil
            end
            cell:removeFromParent(true)
            cell = self:createTabCell(index)
        end

        return cell
    end)

    self.mainTalentTableView:onUpdateCellNumbers(function ()
        return table.nums(self.dataList);
    end)

    self.mainTalentTableView:onTableCellTouched(function(table, cell)
        self:tabCellClick(cell)
    end)

    self.centerBg:addChild(self.mainTalentTableView, 100)
    self.mainTalentTableView:reloadData(true)

    local fadeOutBg =  UI.Image:create()
    fadeOutBg:init("ui_talent_circle_up.png")
    fadeOutBg:leftBottom(20, 3)
    self.centerBg:addChild(fadeOutBg, 101)
end

function RoleTalentLayer:createTabCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

    local mainTalentCell = self:createOneClickIcon(index)
    mainTalentCell:center()
    mainTalentCell:setName("mainTalentCell")
    cell:addChild(mainTalentCell)

    self.iconPanels[index] = mainTalentCell
    -- self:refreshIconPanel(mainTalentCell:getTag())
    self:updateMainTalentCell(mainTalentCell, index)
    return cell
end

function RoleTalentLayer:tabCellClick(cell)
    local mainTalentCell = cell:getChildByName("mainTalentCell")
    if mainTalentCell then
        self:iconClick(mainTalentCell)
    end
end

-- 更新视图
function RoleTalentLayer:onUpdateView()   
    self.talentNumber:setText(GameDataManager:getInstance():getRoleTalentPoint())
    self.talentIcon:rightBottom(self.talentNumber:getRight() + self.talentNumber:getContentSize().width + 2, self.talentIcon:getBottom())
    self.talentName:rightUp(self.talentIcon:getRight() + self.talentIcon:getContentSize().width + 2, self.talentName:getUp())
end

-- 更新视图
function RoleTalentLayer:createOneClickIcon(key)  
    local data = self.dataList[key]
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(131, 131)
    panel:setTag(key)
    -- panel:enableDebugDraw()

    local shadow = UI.Image:create() 
    shadow:init("ui_talent_blackbg.png")
    shadow:centerLeft(26)
    panel:addChild(shadow)
    shadow:setName("SHADOW")

    local shadowSelect = UI.Image:create() 
    shadowSelect:init("ui_talent_arrow_bg.png")
    shadowSelect:centerLeft(40)
    panel:addChild(shadowSelect)
    shadowSelect:setName("SHADOWSELECT")

    local icon = UI.Image:create() 
    icon:init(data.icon)
    icon:centerUp(62 - icon:getContentSize().height / 2)
    

    panel:addChild(icon, 10)
    -- icon:setTouchEnable(true)
    -- icon:addEventListener(UIEvent.COMPONENT_CLICK, panel, function()
    --     self:iconClick(panel)
    -- end)
    icon:setName("ICON")

    local bg = UI.Image:create() 
    bg:init("ui_talent_circle_bg.png")
    bg:centerUp(22)
    panel:addChild(bg) 
    bg:setName("BG")
    -- if GameManager:getIsGooglePlay() then
    --     icon:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, panel, function()
    --         local cell = panel
    --         local visible = true
    --         self:hightLight(cell, visible)
    --     end)

    --     icon:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, panel, function(self_, button, touchPosition)
    --         if not panel:checkTouchPosition(touchPosition) then 
    --             local cell = panel
    --             local visible = false
    --             self:hightLight(cell, visible)
    --         end
    --     end)

    --     icon:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, panel, function()
    --         local cell = panel
    --         local visible = false
    --         self:hightLight(cell, visible)
    --     end)
    -- end

    local qualityCap = UI.Image:create() 
    qualityCap:init(qualityImage[data.ID] or qualityImage[1])
    qualityCap:centerBottom(30)
    panel:addChild(qualityCap, 15) 
    qualityCap:setName("QUALITYCAP")

    local selectAnim = UI.Animation:create()
    selectAnim:init("effect_ui_package_talent_icon_kuang.json", "effect_ui_package_talent_icon_kuang.atlas")
    selectAnim:centerBottom(70)
    panel:addChild(selectAnim, 15)
    selectAnim:setName("SELECTANIM")
    
    local numberBg = UI.Image:create() 
    numberBg:init("ui_talent_blackpaper.png")
    numberBg:centerUp(83 + numberBg:getContentSize().height / 2)
    panel:addChild(numberBg, 20) 
    numberBg:setName("NUMBERBG")

    -- bg:setName("CAP2")
    local lv = UI.Image:create() 
    lv:init("ui_home_banner_lv.png")
    lv:leftBottom(10, numberBg:getContentSize().height / 3)
    numberBg:addChild(lv) 
    lv:setName("LV")

    local number = AvalonUtil:getStyledNumberNode(data.totalLv)
    number:leftBottom(10, numberBg:getContentSize().height / 3)
    numberBg:addChild(number)
    number:setName("NUMBER")
    
    local left = (numberBg:getContentSize().width - lv:getContentSize().width - number:getContentSize().width) / 2
    lv:leftBottom(left, lv:getBottom())
    number:leftBottom(left + lv:getContentSize().width + 2, number:getBottom())

    local arrow = UI.Image:create() 
    arrow:init("ui_talent_arrow.png")
    arrow:centerRight(-28)
    panel:addChild(arrow, 20) 
    arrow:setName("ARROW")

    panel:setScale(0.8)
    return panel
end

function RoleTalentLayer:updateMainTalentCell(cell, key)
    local visible = (self.selectKey == key)
    cell:getChildByName("ARROW"):setVisible(visible)
    cell:getChildByName("QUALITYCAP"):setVisible(not visible)
    cell:getChildByName("SHADOWSELECT"):setVisible(visible)
    cell:getChildByName("SHADOW"):setVisible(not visible)

    local selectAnim = cell:getChildByName("SELECTANIM")
    selectAnim:setVisible(visible)
    local numberBg = cell:getChildByName("NUMBERBG")
    local lv = numberBg:getChildByName("LV")
    local number = numberBg:getChildByName("NUMBER")
    if self.selectKey == key then
        cell:getChildByName("ICON"):setScale(1)
        cell:getChildByName("BG"):setScale(1.2)
        selectAnim:setAnimation("trigger", false)
        selectAnim:addAnimation("idle", true)
        numberBg:setSpriteName("ui_talent_click_black_paper.png")
    else
        cell:getChildByName("ICON"):setScale(0.8)
        cell:getChildByName("BG"):setScale(1)
        selectAnim:clearTrack()
        numberBg:setSpriteName("ui_talent_blackpaper.png")
    end
    numberBg:centerUp(83 + numberBg:getContentSize().height / 2)
    local left = (numberBg:getContentSize().width - lv:getContentSize().width - number:getContentSize().width) / 2
    lv:leftBottom(left, numberBg:getContentSize().height / 3)
    number:leftBottom(left + lv:getContentSize().width + 2, numberBg:getContentSize().height / 3)
end

function RoleTalentLayer:hightLight(cell, visible)
    cell:getChildByName("ARROW"):setVisible(false)
    cell:getChildByName("QUALITYCAP"):setVisible(not visible)
    cell:getChildByName("SHADOWSELECT"):setVisible(false)
    cell:getChildByName("SHADOW"):setVisible(not visible)

    local selectAnim = cell:getChildByName("SELECTANIM")
    selectAnim:setVisible(visible)
    if visible then
        cell:getChildByName("ICON"):setScale(1)
        cell:getChildByName("BG"):setScale(1.2)
        selectAnim:setAnimation("trigger", false)
        selectAnim:addAnimation("idle", true)
    else
        cell:getChildByName("ICON"):setScale(0.8)
        cell:getChildByName("BG"):setScale(1)
        selectAnim:clearTrack()
    end
end

function RoleTalentLayer:iconClick(sender)
    self:refreshIconPanel(sender:getTag())
end

function RoleTalentLayer:refreshIconPanel(key)
    if key == nil then
        print("---------refreshIconPanel---- key is null")
        return
    end
    local data = self.dataList[key]
    if data == nil then
        print("---------refreshIconPanel---- data is null and key = ", key)
        return
    end
    if self.selectKey == key then
        return
    end
    self.selectKey = key
    for k, cell in pairs(self.iconPanels) do
        local visible = (key == k)
        if cell and not tolua.isnull(cell) then
            cell:getChildByName("ARROW"):setVisible(visible)
            cell:getChildByName("QUALITYCAP"):setVisible(not visible)   
            cell:getChildByName("SHADOWSELECT"):setVisible(visible)
            cell:getChildByName("SHADOW"):setVisible(not visible)

            local selectAnim = cell:getChildByName("SELECTANIM")
            selectAnim:setVisible(visible)
            local numberBg = cell:getChildByName("NUMBERBG")
            local lv = numberBg:getChildByName("LV")
            local number = numberBg:getChildByName("NUMBER")
            if key == k then
                cell:getChildByName("ICON"):setScale(1)
                cell:getChildByName("BG"):setScale(1.2)
                selectAnim:setAnimation("trigger", false)
                selectAnim:addAnimation("idle", true)
                numberBg:setSpriteName("ui_talent_click_black_paper.png")
            else
                cell:getChildByName("ICON"):setScale(0.8)
                cell:getChildByName("BG"):setScale(1)
                selectAnim:clearTrack()
                numberBg:setSpriteName("ui_talent_blackpaper.png")
            end
            numberBg:centerUp(83 + numberBg:getContentSize().height / 2)
            local left = (numberBg:getContentSize().width - lv:getContentSize().width - number:getContentSize().width) / 2
            lv:leftBottom(left, numberBg:getContentSize().height / 3)
            number:leftBottom(left + lv:getContentSize().width + 2, numberBg:getContentSize().height / 3)
        end
    end
    if data.totalLv >= data.skillActiveLV then
        self.iconCap:setSpriteName("ui_talent_btn_1.png")
        self.iconCap:getChildByName("LOCK"):hide()
    else
        self.iconCap:setSpriteName("ui_talent_btn_2.png")
        self.iconCap:getChildByName("LOCK"):show()
    end
    self.bigIcon:setSpriteName(data.icon)
    self.bigIcon:centerLeft(45 - self.bigIcon:getContentSize().width / 2)
    self.bigIconName:setText(data.name)
    self.bigIconLevel:setText(string.format(UI.TEXT_1212097, data.totalLv))
    self.externSkillName:setText(data.skillName)
    self.externSkillDesc:setText(data.skillDesc)
    self.externSkillIcon:setSpriteName(data.skillIcon)
    self.tableView:reloadData()
end

--tableview 相关
function RoleTalentLayer:numberOfCellsInTableView(table)
    local size = 0
    if self.selectKey ~= nil then
        local mainTalentData = self.dataList[self.selectKey]
        if mainTalentData then
            size = #mainTalentData.list
        end
    end
    return size
end

function RoleTalentLayer:scrollViewDidScroll(view)
end

function RoleTalentLayer:scrollViewDidZoom(view)
    
end

function RoleTalentLayer:tableCellTouched(tableView,cell)

end

function RoleTalentLayer:tableCellWillRecycle(tableView,cell)
    if cell ~= nil then
        cell:removeChildByName("cell")
    end
end

function RoleTalentLayer:cellSizeForTable(table,idx)
    return 652, 75
end

function RoleTalentLayer:tableCellAtIndex(tableView,idx)
    -- print("MailLayer:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    if cell == nil then
        cell = cc.TableViewCell:new()
    else
        cell:removeChildByName("cell")
    end
    xpcall(function()
        local talentCell = UI.RoleTalentCell:create(self.tableView)
        local data = self.dataList[self.selectKey].list[idx + 1]
        talentCell:init(data)
        talentCell:setName("cell")
        talentCell:leftBottom(0, 0)
        cell:addChild(talentCell)
        -- talentCell:enableDebugDraw()
    end, 
    function(e) 
        printError("------------------RoleTalentLayer:tableCellAtIndex-----------------------error", e)
    end, 1)  
    self._tableCellArr[idx + 1] = cell
    return cell
end

--isUpgrade: 是否是升级请求的回调， 否则是加点请求的回调
function RoleTalentLayer:refreshTalentById(talentId, isUpgrade)
    UI.WaitingLayer:hideWaiting()
    self.dataList = GameDataManager:getAllRoleTalents()
    local mainTalentData = self.dataList[self.selectKey]
    if isUpgrade then
        self.bigIconLevel:setText(string.format(UI.TEXT_1212097, mainTalentData.totalLv))
        for k, cell in pairs(self.iconPanels) do
            if self.selectKey == k then
                local numberBg = cell:getChildByName("NUMBERBG")
                numberBg:removeChildByName("LV")
                numberBg:removeChildByName("NUMBER")

                local lv = UI.Image:create() 
                lv:init("ui_home_banner_lv.png")
                lv:leftBottom(10, numberBg:getContentSize().height / 3)
                numberBg:addChild(lv, 20) 
                lv:setName("LV")

                local number = AvalonUtil:getStyledNumberNode(mainTalentData.totalLv)
                number:leftBottom(10, numberBg:getContentSize().height / 3)
                numberBg:addChild(number, 30)
                number:setName("NUMBER")

                local left = (numberBg:getContentSize().width - lv:getContentSize().width - number:getContentSize().width) / 2
                lv:leftBottom(left, lv:getBottom())
                number:leftBottom(left + lv:getContentSize().width + 2, number:getBottom())

                if mainTalentData.totalLv >= mainTalentData.skillActiveLV then
                    self.iconCap:setSpriteName("ui_talent_btn_1.png")
                    self.iconCap:getChildByName("LOCK"):hide()
                else
                    self.iconCap:setSpriteName("ui_talent_btn_2.png")
                    self.iconCap:getChildByName("LOCK"):show()
                end
                break
            end
        end
    else
        self.talentNumber:setText(GameDataManager:getInstance():getRoleTalentPoint())
        self.talentIcon:rightBottom(self.talentNumber:getRight() + self.talentNumber:getContentSize().width + 2, self.talentIcon:getBottom())
        self.talentName:rightUp(self.talentIcon:getRight() + self.talentIcon:getContentSize().width + 2, self.talentName:getUp())
    end
    local index = 1
    for k, v in ipairs(mainTalentData.list) do
        if talentId == v.ID then
            index = k
            break
        end
    end

    self.tableView:updateCellAtIndex(index - 1)
end  

function RoleTalentLayer:externSkillClick()
    local mainTalentData = self.dataList[self.selectKey]
    if mainTalentData == nil then
        return
    end
    if mainTalentData.totalLv < mainTalentData.skillActiveLV then
        UI.ScrollBar:createByText(string.format(UI.TEXT_1212101, mainTalentData.name, mainTalentData.skillActiveLV))
    end
end

function RoleTalentLayer:showShareBtn(parentNode)
    --todo 分享界面 逻辑 参考skilllayer.lua
end
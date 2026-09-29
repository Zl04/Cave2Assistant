------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/06
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SuitTransformationSelectRetrofitView = class("SuitTransformationSelectRetrofitView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_home.plist",
    "ui_common_btn.plist"
}

local winSize = cc.Director:getInstance():getWinSize()

local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height



function SuitTransformationSelectRetrofitView:ctor(data)
    SuitTransformationSelectRetrofitView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    -- required uint32 equipSetId = 1;                         // 套装ID
    -- required uint32 equipCount = 2;                         // 套装件数
    -- required bool isAdvanced = 3;                           // 是否高级改造
    -- repeated uint32 skillIds = 4;                           // 随机到的属性
    self._equipSetId = data.equipSetId
    self._equipCount = data.equipCount
    self._isAdvanced = data.isAdvanced
    self._skillIds = data.skillIds

    self._selectSkillId = 0

end

function SuitTransformationSelectRetrofitView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.suittransformation", "SuitTransformation", false)
    SuitTransformationSelectRetrofitView.super.init(self, ... )
end

function SuitTransformationSelectRetrofitView:dtor()
    SuitTransformationSelectRetrofitView.super:setNoBackUp(false)
    SuitTransformationSelectRetrofitView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.suittransformation.SuitTransformationSelectRetrofitView")
end


function SuitTransformationSelectRetrofitView:onInitView()
    self:center()
    SuitTransformationSelectRetrofitView.super:setNoBackUp(true)

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)


    local setSkillArr = {}
    local index = 1
    for k,skillID in ipairs(self._skillIds) do
        local skillData = SkillDataManager:createSkillForSkillId(skillID)
        if(skillData) then
            setSkillArr[index] = skillData

            index = index + 1
        end
    end

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_home_retrofit_paper_bg.png")
    bg:center()
    contentLayout:addChild(bg)
    self._bg = bg

    -- 标题
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222204, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    titleText:centerUp(21, 0)
    bg:addChild(titleText)

    self._skillDesList = {}

    for k,v in ipairs(setSkillArr) do
        local skillLayout = self:createAttriNode(v)
        skillLayout:centerUp(62 + (k - 1) * 99)
        self._bg:addChild(skillLayout)
        table.insert(self._skillDesList,skillLayout)
    end

    --关闭
    local closeBtn = UI.Button:create()
    closeBtn:init('ui_btn_no1_0.png', 'ui_btn_no1_0.png', 'ui_btn_no1_0.png')
    closeBtn:centerBottom(32,-94)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        local tips = UI.Tips:createTips(UI.TEXT_222205,
            UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)

        tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            if tolua.isnull(self) then
                return
            end
            mvc.suitTransformationController:closeSelectLayer()
        end)
    end)
    bg:addChild(closeBtn)

    --确认
    local okbtn = UI.Button:create()
    okbtn:init('ui_btn_yes1_1.png', 'ui_btn_yes1_1.png', 'ui_btn_yes1_1.png')
    okbtn:centerBottom(32,94)
    okbtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if self._selectSkillId ~= 0 then
            Net.NetGoodsSystem:requesEquipSetConfirmRetrofit(self._equipSetId, self._equipCount, self._selectSkillId)

        else
            UI.ScrollBar:createByText(UI.TEXT_222206)
        end
    end)
    bg:addChild(okbtn)

end

function SuitTransformationSelectRetrofitView:createAttriNode(skillData)
    local skillLayout = UI.Layout:create()
    skillLayout:init()
    skillLayout:setSize(314,85)

    skillLayout._skillData = skillData

    -- local btn = UI.Button:create()
    -- btn:init('ui_home_retrofit_list_normal.png', 'ui_home_retrofit_list_normal.png', 'ui_home_retrofit_list_checked.png')
    -- btn:center()
    -- btn:setSwallowTouches(false)
    -- btn:closeClickScale()
    -- btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
    --     self._selectSkillId = skillData.skillID

    --     for k,v in ipairs(self._skillDesList) do
    --         if v._skillData == skillData then
    --             v._btn:disable()
    --         else
    --             v._btn:enable()
    --         end
    --     end

    -- end)
    -- skillLayout:addChild(btn)
    -- skillLayout._btn = btn

    local bgImg = UI.Image:create()
    bgImg:init("ui_home_retrofit_list_normal.png")
    bgImg:center()
    skillLayout:addChild(bgImg)
    skillLayout._bgImg = bgImg


    local tableView = UI.TableView:create({}, 276, 72)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(20, 5)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        -- 描述
        local baseText = UI.Text:create()
        baseText:init(
            string.format("%s", skillData:getDescription()),
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX,
            {r = 60, g = 60, b = 65}
        )

        baseText:leftUp(1,1)
        baseText:setTextLeftUp()

        if (baseText._width >  238) then
            baseText:setWidth(238)
            baseText:setSize(238, baseText:getContentSize().height)
        end

        if baseText:getContentSize().height > 70 then
            return 274,baseText:getContentSize().height
        else
            return 274, 70
        end
        
    end) 
    tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()

                local desLayout = UI.Layout:create()
                desLayout:init()
                -- desLayout:setSize(314,85)

                -- print("skillData ===== ",skillData:getDescription())
                -- dump(skillData:getDescription())

                -- 描述
                local baseText = UI.Text:create()
                baseText:init(
                    string.format("%s", skillData:getDescription()),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    {r = 60, g = 60, b = 65}
                )

                
                baseText:setTextLeftUp()
                desLayout:addChild(baseText)

                baseText:leftBottom(1,1)
                if (baseText._width >  238) then
                    baseText:setWidth(238)
                    baseText:setSize(238, baseText:getContentSize().height)
                --     baseText:leftBottom(1,1)
                -- else
                --     baseText:leftUp(1,1)
                end

                desLayout:setSize(baseText:getContentSize().width,baseText:getContentSize().height)

                -- 数值
                local baseValue = UI.Text:create()
                baseValue:init(
                    string.format("[%s]", self._equipCount),
                    UI.FONT_STANDARD,
                    UI.FONT_SIZE_16PX,
                    {r = 60, g = 60, b = 65}
                )
                baseValue:setSize(30, 20)
                -- baseValue:rightUp(10, 1)
                baseValue:leftBottom(250, desLayout:getContentSize().height - 18)
                desLayout:addChild(baseValue)
                if desLayout:getContentSize().height < 70 then
                    desLayout:leftBottom(0,70 - desLayout:getContentSize().height)
                else
                    desLayout:leftBottom(0,0)
                end
                desLayout:setSize(274, 70)

                cell:addChild(desLayout)
            end, 
            function(e) 
                printError("------------------------updateRightLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onUpdateCellNumbers(function()
        return 1
    end)

    tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        if self._selectSkillId == skillData.skillID then
            return
        end

        self._selectSkillId = skillData.skillID

        for k,v in ipairs(self._skillDesList) do
            if v._skillData == skillData then
                v._bgImg:setSpriteName('ui_home_retrofit_list_checked.png')
            else
                v._bgImg:setSpriteName('ui_home_retrofit_list_normal.png')
            end
        end
        
    end);

    skillLayout:addChild(tableView)
    tableView:reloadData()


    return skillLayout
end


function SuitTransformationSelectRetrofitView:bindModel()

end


function SuitTransformationSelectRetrofitView:unbindModel()

end





return SuitTransformationSelectRetrofitView













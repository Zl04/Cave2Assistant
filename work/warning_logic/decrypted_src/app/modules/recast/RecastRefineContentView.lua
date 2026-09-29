------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/08/12
--desc	:
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RecastRefineContentView = class("RecastRefineContentView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_recasting.plist",
    "ui_common_information.plist"
}

local COM_WIDTH = 352
local COM_HEIGHT = 595

function RecastRefineContentView:ctor()
    RecastRefineContentView.super.ctor(self, UI.Type.EQUIP_REFINE, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:bindModel()
end

function RecastRefineContentView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.recast", "Recast", false)
    RecastRefineContentView.super.init(self, ...)
end

function RecastRefineContentView:dtor()
    RecastRefineContentView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.recast.RecastRefineContentView")
end
function RecastRefineContentView:createattrComItem()
    local attrComItem = UI.Layout:create()
    attrComItem:init()
    attrComItem:setSize(250, 538)
    attrComItem:enableAutoHeight()
    -- attrComItem:enableDebugDraw()

    local attNameLabel = UI.Text:create()
    attNameLabel:init("", UI.FONT_STANDARD, 16, {r = 41, g = 41, b = 45})
    attNameLabel:floatLeft(0)
    attrComItem:addComponent(attNameLabel)
    attNameLabel:setName("attNameLabel")
    attrComItem.attNameLabel = attNameLabel
    
    local attNumberLabel = UI.Text:create()
    attNumberLabel:init("1800", UI.FONT_STANDARD, 16, {r = 41, g = 41, b = 45})
    attNumberLabel:floatLeft(8)
    attrComItem:addComponent(attNumberLabel)
    attNumberLabel:setName("attNumberLabel")
    attrComItem.attNumberLabel = attNumberLabel

    local alreadyAddLabel = UI.Text:create()
    alreadyAddLabel:init("", UI.FONT_STANDARD, 14, {r = 36, g = 181, b = 118})
    alreadyAddLabel:floatLeft(3)
    attrComItem:addComponent(alreadyAddLabel)
    alreadyAddLabel:setName("alreadyAddLabel")
    attrComItem.alreadyAddLabelAdd = alreadyAddLabel

    local attUpIcon = UI.Image:create()
    attUpIcon:init("ui_information_arrow_up.png")
    attUpIcon:floatRight(0)
    attrComItem:addComponent(attUpIcon)
    attUpIcon:setName("attUpIcon")
    attrComItem.attUpIcon = attUpIcon

    local attChangeNumber = UI.Text:create()
    attChangeNumber:init("x", UI.FONT_STANDARD, 16, {r = 36, g = 181, b = 118})
    attChangeNumber:setLayoutType(UI.LayoutDefaultType.CENTER_RIGHT)
    attChangeNumber:floatRight(4)
    attrComItem:addComponent(attChangeNumber)
    attChangeNumber:setName("attChangeNumber")
    attrComItem.attChangeNumber = attChangeNumber

    return attrComItem
end

function RecastRefineContentView:createOneCell(content, isRich)
    local success = false
    local _richText = nil
    local cell = nil
    if isRich then
        _richText = UI.RichText:create()
        success = _richText:init(content, 240, UI.FONT_SIZE_16PX)
    elseif content ~= "" then
        success = true
        _richText = UI.Text:create()
        _richText:init(content, UI.FONT_STANDARD, UI.FONT_SIZE_16PX,UI.FONT_COLOR_41_41_45)
        _richText:setLineSpacing(3)
        _richText:setTextLeft()
        _richText:setWidth(280)
        _richText:autoAdapt()
    end
    if success then
        cell = UI.Layout:create()
        cell:init()
        _richText:centerLeft(0)
        cell:setSize(260, _richText:getContentSize().height)
        cell:addChild(_richText)
        -- local picDes = UI.Image:create()
        -- picDes:init("ui_checkpoint_banner_diamond.png")
        -- picDes:leftUp(12, 4)
        -- cell:addChild(picDes, 10)
    end
    return cell
end

function RecastRefineContentView:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_recasting_bg.png")
    bg:center()
    self:addChild(bg)

    local titleBg = UI.Image:create()
    titleBg:init("ui_recasting_title.png")
    titleBg:centerUp(-30)
    self:addChild(titleBg, 10)

    local titleStr = UI.Text:create()
    titleStr:init(UI.TEXT_1212308, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    titleStr:centerBottom(11)
    titleBg:addChild(titleStr)
    self.titleStr = titleStr

    local scale =
        225 / cc.Label:CalculateStringSize(self.titleStr:getText(), UI.FONT_ARIAL, self.titleStr:getFontSize()).width
    scale = scale > 1 and 1 or scale
    self.titleStr:setScale(scale)

    -- 提示文字
    local centerBgImage = UI.Image:create()
    centerBgImage:init("ui_recasting_decorate_01.png")
    centerBgImage:centerBottom(113)
    self:addChild(centerBgImage)

    local centerTitleStr = UI.Text:create()
    centerTitleStr:init(UI.TEXT_1213034, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_153_153_153)
    centerTitleStr:centerUp(25 - centerTitleStr:getContentSize().height / 2)
    centerBgImage:addChild(centerTitleStr)

    -- 中间展示区域
    -- local centerBg = UI.Image:create()
    -- centerBg:init("ui_recasting_decorate_03.png")
    -- centerBg:centerBottom(123)
    -- self:addChild(centerBg)

    -- local centeLayout = UI.Layout:create()
    -- centeLayout:init()
    -- centeLayout:setSize(centerBg:getContentSize().width, centerBg:getContentSize().height)
    -- centeLayout:center()
    -- centerBg:addChild(centeLayout)
    -- self.centeLayout = centeLayout

    -- --spine
    self.recastAnimation = UI.Animation:create()
    self.recastAnimation:init("effect_ui_twon_recast_top02.json", "effect_ui_twon_recast_top02.atlas", 1)
    self.recastAnimation:centerUp(102)
    self:addChild(self.recastAnimation)
    self.recastAnimation:setAnimation("idle", true)

    self.iconAnimation = UI.Animation:create()
    self.iconAnimation:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1)
    self:addChild(self.iconAnimation, 102)
    self.iconAnimation:leftUp(120, 92)

    self.iconMaterialAnimation = UI.Animation:create()
    self.iconMaterialAnimation:init("effect_ui_town_blacksmith_icon.json", "effect_ui_town_blacksmith_icon.atlas", 1)
    self:addChild(self.iconMaterialAnimation, 102)
    self.iconMaterialAnimation:leftUp(235, 92)

    self.lightAnimation = UI.Animation:create()
    self.lightAnimation:init("effect_ui_twon_recast_top02_light.json", "effect_ui_twon_recast_top02_light.atlas", 1)
    self.lightAnimation:centerUp(100)
    self:addChild(self.lightAnimation, 200)

    self.downAnimation = UI.Animation:create()
    self.downAnimation:init("effect_ui_twon_recast_down.json", "effect_ui_twon_recast_down.atlas", 1)
    self.downAnimation:centerBottom(39)
    self:addChild(self.downAnimation)
    self.downAnimation:setAnimation("idle", true)
    --spine end

    self.mGoodsGrid = UI.GoodsGrid:create()
    self.mGoodsGrid:init()
    self.mGoodsGrid:leftUp(86, 58)
    self.mGoodsGrid:hide()
    self.mGoodsGrid:showInfoArea()
    self.mGoodsGrid:hideCountLabel()
    self.mGoodsGrid:hideNewIcon()
    self.mGoodsGrid:setDragOutAreaJudgeNode(self)
    self.mGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self:addChild(self.mGoodsGrid, 100)
    -- self.mGoodsGrid:enableDebugDraw()

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:leftUp(285, 38)
    self:addChild(detailAnimation, 100)
    detailAnimation:setTouchEnable(true)

    detailAnimation:addEventListener(UIEvent.COMPONENT_CLICK, self, function(_,sender)
        if self.infoPanel == nil or tolua.isnull(self.infoPanel) then
            local panel = UI.Image:create()
            panel:init("ui_information_banner_details.png")
            panel:leftUp(287,-38)
            self:addChild(panel, 1001)
            self.infoPanel= panel
            local xAdd = 65
            local yAdd = 80
            local title = UI.Text:create()
            title:init(LanguageManager:getInstance():getLocalString(1112818), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
            panel:addChild(title) 
            title:centerUp(25 + yAdd)
    
            local line  = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
            line:setContentSize(282, 2)
            line:setCapInsets(CCRectMake(20,1,1,1))
            line:setPosition(160+xAdd, 382+yAdd)
            panel:addChild(line)
            
            local layout = UI.Layout:create()
            layout:init()
            local textArr = {1112819, 1112820}
            local height = 3
            local cellSpace = 5
            for k, v in ipairs(textArr) do
                local cell = self:createOneCell(UIUtil:lang(v))
                if cell then
                    cell:leftUp(0, height)
                    layout:addChild(cell)
                    height = height + cell:getContentSize().height + cellSpace
                end
            end
    
            height = height < 320 and 320 or height
            layout:setSize(280, height)
            if height > 320 then
                local scrollView = UI.ScrollView:create()
                scrollView:setSize(290, 320)
                scrollView:init()
                scrollView:leftUp(25+xAdd, 67+yAdd)
                scrollView:addInnerNode(layout)
                scrollView:useDefaultScrollBar()
                panel:addChild(scrollView,1)    
            else
                layout:leftUp(25+xAdd, 67+yAdd)
                panel:addChild(layout)
            end
    
            local touch = UI.Component:create()
            touch:init()
            touch:setSize(310,410)
            touch:center()
            panel:addChild(touch)
        
            touch:setTouchEnable(true)
            touch:setInterceptTouches(true)
            touch:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, panel, function()
                panel:removeFromParent()
                self.infoPanel = nil
            end)
        else
            self.infoPanel:show()
        end
    end)

    self.mMaterialGoodsGrid = UI.GoodsGrid:create()
    self.mMaterialGoodsGrid:init()
    self.mMaterialGoodsGrid:leftUp(201, 58)
    self.mMaterialGoodsGrid:hide()
    self.mMaterialGoodsGrid:showInfoArea()
    self.mMaterialGoodsGrid:hideCountLabel()
    self.mMaterialGoodsGrid:hideNewIcon()
    self.mMaterialGoodsGrid:setDragOutAreaJudgeNode(self)
    self.mMaterialGoodsGrid:setDragBeginCallback(handler(self, self.onTouchBeganByGoodsGrid))
    self.mMaterialGoodsGrid.tag = "material"
    self.mMaterialGoodsGrid:setDragEndCallback(handler(self, self.onTouchEndedByGoodsGrid))
    self:addChild(self.mMaterialGoodsGrid, 100)
    -- self.mMaterialGoodsGrid:enableDebugDraw()
    self.mPropertyList = {}
    for i = 1, 7 do
        local attrCom = self:createattrComItem()
        attrCom:centerUp(240 + 26 * i)
        self:addChild(attrCom, 100)
        attrCom:setVisible(false)
        table.insert(self.mPropertyList, attrCom)
    end

    -- 下面的操作区域
    local executeButton = UI.Button:create()
    executeButton:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_2.png")
    executeButton:centerBottom(6)
    self:addChild(executeButton, 10)
    -- executeButton:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    executeButton:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRecastRefineClick)
    executeButton:disable()
    self.executeButton = executeButton
    local com = UI.Layout:create()
    com:init()
    com:center(0, 0)
    local executeButtonIcon = UI.Image:create()
    executeButtonIcon:init("symbol_gaming_money.png")
    executeButtonIcon:centerLeft(90)
    executeButtonIcon:floatLeft(0)
    com:addComponent(executeButtonIcon)
    self.executeButtonIcon = executeButtonIcon

    local executeButtonPrice = UI.GoodsCostText:create(tostring(0), 
        Game.ConstGoods.Coin, 0, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    executeButtonPrice:setShowSize(10)

    -- local executeButtonPrice = UI.NumberText:create("0", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51, 10)
    executeButtonPrice:floatLeft(5)
    com:addComponent(executeButtonPrice)
    self.executeButtonPrice = executeButtonPrice
    com:enableAutoWidth()
    com:enableAutoHeight()
    self.priceLayout = com
    executeButton:addChild(com, 10)
end
function RecastRefineContentView:doRewardAnimation(isSucc, goodsData)
    if isSucc then
        self.lightAnimation:setAnimation("success", false)
        self.recastAnimation:setAnimation("success", false)
        self.downAnimation:setAnimation("success", false)
    else
        self.lightAnimation:setAnimation("fail", false)
        self.recastAnimation:setAnimation("fail", false)
        self.downAnimation:setAnimation("fail", false)
    end
    self.lightAnimation:addEventListener(
        UIEvent.ANIMATION_COMPLETE,
        self,
        function(sender, event)
            if event.animation == "success" then
            end
        end
    )
end

function RecastRefineContentView:updateAttrInfo(goodsData)
    for _, v in pairs(self.mPropertyList) do
        v:setVisible(false)
    end
    if not goodsData then
        return
    end
    local _baseArr = goodsData._baseArr
    local _randomArr = goodsData._randomArr
    local basicAttribute = goodsData.basicAttribute
    local equipRefineAttr = goodsData.equipRefineAttr
    local tmp = string.split(goodsData.equipRefineValue, ";")
    local curequipRefineValue = string.split(tmp[goodsData.refineNum] or "", ",")
    local equipRefineValue = string.split(tmp[goodsData.refineNum+1] or "", ",")
    local createLevel = goodsData.createLevel

    local index = 1
    --刷新属性
    for i = 1, #_baseArr do
        local item = self.mPropertyList[index]
        if item then
            local picStrengthenMark = item.attUpIcon
            local txtAddProperty = item.attChangeNumber
            local txtAddPropertyAdd = item.alreadyAddLabelAdd
            

            item:setVisible(true)
            local _DetailDescription = _baseArr[i]:getDetailDescription()
            local detailNum = _DetailDescription[2]
            item.attNameLabel:setText(_DetailDescription[1])
            
            local toNumberDetailNum = tonumber(detailNum)
            if toNumberDetailNum ~= nil then
                detailNum = AvalonUtil:getSimpleNumber(toNumberDetailNum,3)
            end

            item.attNumberLabel:setText(detailNum)

            local isAdd = false
            --修改主属性
            for j = 1, #equipRefineAttr do
                if equipRefineAttr[j] == _baseArr[i]:getAttrType() then
                    if createLevel and createLevel > 0 then
                        local attrType = _baseArr[i]:getAttrType()
                        local config = ConfigManager:getEquipRefineValueByID(attrType)

                        local refineCreateLevel = clone(createLevel)
                        local levelLimiteList = string.split(goodsData.equipRequireLvIntervals, ";")
                        local randLevelLimite = string.split(levelLimiteList[8], ",")
                        local lowerLimite = tonumber(randLevelLimite[1])
                        local upperLimite = tonumber(randLevelLimite[2])
                        refineCreateLevel = math.max(refineCreateLevel, lowerLimite + goodsData.qualityGrade)
                        refineCreateLevel = math.min(refineCreateLevel, upperLimite + goodsData.qualityGrade)

                        local alreadyAddNum = 0
                        local equipRefineValueNew = config.firstequipRefineValueByLV[refineCreateLevel]
                        if goodsData.refineNum == 1 then
                            alreadyAddNum = config.firstequipRefineValueByLV[refineCreateLevel]
                            equipRefineValueNew = config.secondequipRefineValueByLV[refineCreateLevel]
                        -- elseif goodsData.refineNum == 2 then
                            -- alreadyAddNum = config.secondequipRefineValueByLV[createLevel]
                            
                        end
                        
                        local add = equipRefineValueNew - (alreadyAddNum or 0)
                        local str = ToolsUtil:calculationAttrShowValue(attrType, add)

                        local toNumberStr = tonumber(str)
                        if toNumberStr ~= nil then
                            str = AvalonUtil:getSimpleNumber(toNumberStr,3)
                        end

                        txtAddProperty:setText(str)
        
                        if alreadyAddNum then
                            local str = ToolsUtil:calculationAttrShowValue(attrType, alreadyAddNum)

                            local toNumberStr = tonumber(str)
                            if toNumberStr ~= nil then
                                str = AvalonUtil:getSimpleNumber(toNumberStr,3)
                            end

                            txtAddPropertyAdd:setText("(+" .. str ..")")
                        else
                            txtAddPropertyAdd:setText("")
                        end
                    else

                        local alreadyAddNum = tonumber(curequipRefineValue[j])
                        local add = tonumber(equipRefineValue[j])- (alreadyAddNum or 0)
                        local str = ToolsUtil:calculationAttrShowValue(equipRefineAttr[j], add)

                        local toNumberStr = tonumber(str)
                        if toNumberStr ~= nil then
                            str = AvalonUtil:getSimpleNumber(toNumberStr,3)
                        end

                        txtAddProperty:setText(str)

                        if alreadyAddNum then
                            local str = ToolsUtil:calculationAttrShowValue(equipRefineAttr[j], alreadyAddNum)

                            local toNumberStr = tonumber(str)
                            if toNumberStr ~= nil then
                                str = AvalonUtil:getSimpleNumber(toNumberStr,3)
                            end

                            txtAddPropertyAdd:setText("(+" .. str ..")")
                        else
                            txtAddPropertyAdd:setText("")
                        end
                    end
                    
                    isAdd = true
                end
            end
            txtAddProperty:setVisible(isAdd)
            picStrengthenMark:setVisible(isAdd)
            txtAddPropertyAdd:setVisible(isAdd)
            index = index + 1
            item:updateView()
        end
    end

    -- for i = 1, #_randomArr do
    --     local item = self.mPropertyList[index]
    --     if item then
    --         item:setVisible(true)
    --         local picStrengthenMark = item.attUpIcon
    --         local txtAddProperty = item.attChangeNumber

    --         local _DetailDescription = _randomArr[i]:getDetailDescription()
    --         item.attNameLabel:setText(_DetailDescription[1])
    --         item.attNumberLabel:setText(_DetailDescription[2])
    --         item.attNumberLabel:leftBottom(item.attNameLabel._width + 8, 0)
    --         item.attUpIcon:setVisible(false)
    --         item.attChangeNumber:setVisible(false)
    --         item:setVisible(true)
    --         item:updateView()

    --         index = index + 1
    --     end
    -- end
end
function RecastRefineContentView:onTouchBeganByGoodsGrid(grid)
    -- local isMaterial = grid.tag == "material"
    -- mvc.send(mvc.events.Recast_Grid_Drag_Began, isMaterial, grid)
end

function RecastRefineContentView:onTouchEndedByGoodsGrid(grid, isInSide, touchPosition)
    local isMaterial = grid.tag == "material"
    if not self:checkTouchPosition(touchPosition) then
        mvc.send(mvc.events.Recast_Refine_Grid_Drag_Out, isMaterial, grid)
    end
end

function RecastRefineContentView:onRecastRefineClick()
    -- self:doRewardAnimation(true)
    mvc.send(mvc.events.Recast_Do_Refine, self.mGoodsGrid:getData(), self.mMaterialGoodsGrid:getData())
end

function RecastRefineContentView:bindModel()
end

function RecastRefineContentView:unbindModel()
end

function RecastRefineContentView:checkTouchInGrid(touchPosition)
    if self.mGoodsGrid:checkTouchPosition(touchPosition) then
        return 1
    end
    if self.mMaterialGoodsGrid:checkTouchPosition(touchPosition) then
        return 2
    end
    return -1
end

function RecastRefineContentView:getTargetGridData()
    return self.mGoodsGrid:getData()
end

function RecastRefineContentView:getMaterialGridData()
    return self.mMaterialGoodsGrid:getData()
end

function RecastRefineContentView:setTargetGridData(goodsData)
    if not goodsData then
        self.mGoodsGrid:reset()
        self.mGoodsGrid:hide()
        self.executeButtonPrice:updateCost(0, "0")
        self.executeButton:disable()
    else
        self.mGoodsGrid:setData(goodsData)
        self.mGoodsGrid:show()
        local cost = goodsData.equipRefineCost[goodsData.refineNum + 1]
        if goodsData.createLevel and goodsData.createLevel > 0 then 
            local refineCreateLevel = clone(goodsData.createLevel)
            local levelLimiteList = string.split(goodsData.equipRequireLvIntervals, ";")
            local randcostLimite = string.split(levelLimiteList[9], ",")
            local lowerLimite = tonumber(randcostLimite[1])
            local upperLimite = tonumber(randcostLimite[2])
            refineCreateLevel = math.max(refineCreateLevel, lowerLimite)
            refineCreateLevel = math.min(refineCreateLevel, upperLimite)
            
            local costConfig = ConfigManager:getEquipRefineCostByID(refineCreateLevel)

            cost = costConfig.equipRefineCostLv and costConfig.equipRefineCostLv[goodsData.refineNum + 1] or 0
        end
        self.executeButtonPrice:updateCost(cost, tostring(cost))
    end
    self.priceLayout:updateView()
    self.mGoodsGrid:updateView()
    self:updateAttrInfo(goodsData)
end

function RecastRefineContentView:setMatrialGridData(goodsData)
    if not goodsData then
        self.mMaterialGoodsGrid:reset()
        self.mMaterialGoodsGrid:hide()
        self.executeButton:disable()
    else
        self.mMaterialGoodsGrid:setData(goodsData)
        self.mMaterialGoodsGrid:show()
        self.executeButton:enable()
    end
    self.mMaterialGoodsGrid:updateView()
end

function RecastRefineContentView:updateGridAnimation(tag)
    if tag == "ToTarget" then
        self.iconAnimation:setAnimation("ready1", false)
        self.iconAnimation:addAnimation("ready2", true)
    elseif tag == "ToMaterial" then
        self.iconMaterialAnimation:setAnimation("ready1", false)
        self.iconMaterialAnimation:addAnimation("ready2", true)
    elseif tag == "ToMaterialEnd" then
        self.iconMaterialAnimation:setAnimation("put1", false)
        self.iconMaterialAnimation:addAnimation("put2", true)
    elseif tag == "ToTargetEnd" then
        self.iconAnimation:setAnimation("put1", false)
        self.iconAnimation:addAnimation("put2", true)
    elseif tag == "ToTargetCancel" then
        self.iconAnimation:setAnimation("ready3", false)
    elseif tag == "ToMaterialCancel" then
        self.iconMaterialAnimation:setAnimation("ready3", false)
    elseif tag == "MoveOutMaterialEnd" then
        self.iconMaterialAnimation:setAnimation("ready3", false)
    elseif tag == "MoveOutTargetEnd" then
        self.iconAnimation:setAnimation("ready3", false)
    end
end

return RecastRefineContentView

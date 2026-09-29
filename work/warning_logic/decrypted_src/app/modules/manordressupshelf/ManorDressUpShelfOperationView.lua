------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/08/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorDressUpShelfOperationView = class("ManorDressUpShelfOperationView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 1111
local COM_HEIGHT = 564
local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE

function ManorDressUpShelfOperationView:ctor(shelfIndex)
    ManorDressUpShelfOperationView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._shelfIndex = shelfIndex or 1
    self._clickIndex = 1
    self._leftBtnGroup = {}
    self._functionNPCAnimation = nil
    self._equipmentArr = {}
end

function ManorDressUpShelfOperationView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manordressupshelf", "ManorDressUpShelf", false)
    ManorDressUpShelfOperationView.super.init(self, ... )
end

function ManorDressUpShelfOperationView:dtor()
    ManorDressUpShelfOperationView.super.dtor(self)
    self._leftBtnGroup = nil
    self._functionNPCAnimation = nil
    self._equipmentArr = {}
    self:unbindModel()
    reload_script_file_mvc("app.modules.manordressupshelf.ManorDressUpShelfOperationView")
end


function ManorDressUpShelfOperationView:onInitView()
    self:center()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout


    self._leftLayout = UI.Layout:create()
    self._leftLayout:init()
    self._leftLayout:setSize(150 + 15 + 6, 466)
    self._leftLayout:leftBottom(125 - 15,47)
    contentLayout:addChild(self._leftLayout)
    -- self._leftLayout:enableDebugDraw()

    self._middleLayout = UI.Layout:create()
    self._middleLayout:init()
    self._middleLayout:setSize(350, 466)
    self._middleLayout:leftBottom(295,47)
    contentLayout:addChild(self._middleLayout)
    self._middleLayout:enableDebugDraw()

    self._rightLayout = UI.Layout:create()
    self._rightLayout:init()
    self._rightLayout:setSize(347, 475)
    self._rightLayout:leftBottom(660,47)
    contentLayout:addChild(self._rightLayout)
    self._rightLayout:enableDebugDraw()


    -- self:refreshLeftLayout()
    -- self:refreshMiddleLayout()
    -- self:refreshRightLayout()

    -- 数据获取
    -- performWithDelay(self, function() 
        Net.NetGoodsSystem:requestEquipIllusionInfo()
    -- end, 0.3)

end

function ManorDressUpShelfOperationView:updateAllView()
    self:refreshLeftLayout()
    self:refreshMiddleLayout()
    self:refreshRightLayout()
end

function ManorDressUpShelfOperationView:refreshLeftLayout()
    self._leftLayout:removeAllChildren()
    local allTemplateData = ConfigManager:getAllIllusionRackData()

    local tvWidth, tvHeight = 171, 466
    local tableView = UI.TableView:create({}, tvWidth, tvHeight)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(0,0)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 148,62
    end) 
    tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()

                local view = mvc.manorSuitListCellView:create(luaIdx)
                view:init()
                view:leftBottom(15,9)
                cell:addChild(view)

                if self._clickIndex == luaIdx then
                    view:setSelect(true)
                end

                self._leftBtnGroup[luaIdx] = view

            end, 
            function(e) 
                printError("------------------------refreshLeftLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        local clickIndex = cell:getIdx() + 1

        if self._clickIndex == clickIndex then
            return
        end
        self:suitListClicked(clickIndex)
    end)

    tableView:onUpdateCellNumbers(function()
        return table.nums(allTemplateData)
    end)
    self._leftLayout:addChild(tableView)
    tableView:reloadData()

end

function ManorDressUpShelfOperationView:suitListClicked(clickIndex)
    self._clickIndex = clickIndex

    for k,v in pairs(self._leftBtnGroup) do
        if(not tolua.isnull(v) and k ==  self._clickIndex) then
            v:setSelect(true)
            self:refreshMiddleLayout()
            self:refreshRightLayout()
        elseif (not tolua.isnull(v)) then
            v:setSelect(false)
        end
    end

end

function ManorDressUpShelfOperationView:refreshMiddleLayout()
    self._middleLayout:removeAllChildren()

    local pData = ConfigManager:getAllIllusionRackDataByID(self._clickIndex)

    if not pData then
        return
    end

    -- local isActivate = mvc.manorDressUpShelfModel:checkActivateById(self._clickIndex)
    local _, activateNum,isActivate =  mvc.manorDressUpShelfModel:suitListShowRedPointById(self._clickIndex)
    
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222805, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=168,g=168,b=168})
    titleText:centerUp(5)
    self._middleLayout:addChild(titleText)

    if isActivate then 
        titleText:setText(UI.TEXT_222804)
        -- titleText:setFontColor({r=214,g=177,b=110}))
        titleText:setFontColor({r=4,g=86,b=0})
    end

    local desText = UI.Text:create()
    desText:init(UI.TEXT_222803 .. LanguageManager:getInstance():getLocalString(pData.desc), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=172,g=165,b=159})
    desText:centerUp(28)
    self._middleLayout:addChild(desText)


    local stoneImg = UI.Image:create()
    stoneImg:init("ui_illusionstand_base.png")
    stoneImg:centerBottom(-23,0)
    self._middleLayout:addChild(stoneImg)


    self._functionNPCAnimation = Avalon.Animation:create("manor_study_hanger.json", "manor_study_hanger.atlas", 1.0)
    self._functionNPCAnimation:setPosition(175,185)
    self._functionNPCAnimation:setScale(1.6)
    self._middleLayout:addChild(self._functionNPCAnimation)
    self:idle()

    self._skin = ""

    local wearEquipArr = mvc.manorDressUpShelfModel:getActivateDataById(self._clickIndex)
    self:handleEquipmentChange(wearEquipArr)


    --展示按钮 

    local showBtn = UI.Button:create()
    showBtn:init("ui_illusionstand_btn.png", "ui_illusionstand_btn.png", "ui_illusionstand_btn.png")
    showBtn:centerBottom(30, 0)
    showBtn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=40,g=40,b=42})
    showBtn:setText(UI.TEXT_222806)
    self._middleLayout:addChild(showBtn)
    showBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if activateNum <= 0 then
            UI.ScrollBar:createByText(UI.TEXT_222809)
            return
        end

        Net.NetManorSystem:reqIllusionShow(self._shelfIndex,self._clickIndex)
    end)

    local btnDesText = UI.Text:create()
    btnDesText:init(UI.TEXT_222807 .. self._shelfIndex, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=172,g=165,b=159})
    btnDesText:centerBottom(0)
    self._middleLayout:addChild(btnDesText)

end

function ManorDressUpShelfOperationView:idle()
    if (self._functionNPCAnimation) then
        self._functionNPCAnimation:setAnimation(0, "idle1", true)
    end    
end

--装备架换装相关
function ManorDressUpShelfOperationView:handleEquipmentChange(wearEquipArr)

    if wearEquipArr == nil then
        return
    end
    self._equipmentArr = {}
    require "app.datas.EquipIllusionDataManager"

    local skin = "initial"
    for k,v in pairs(wearEquipArr) do
        -- 判断是否有盔甲
        local equipType = v:getEquipmentType()
        if equipType == EQUIPMENT_TYPE.Chest then
            local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
            if(illusionEquipData) then
                skin = illusionEquipData:getAttachmentID()
            end
            break
        end
    end
    -- 替换盔甲
    self:changeArmor(skin)

    local handleTypeArr = {}
    
    for k,v in pairs(wearEquipArr) do
        -- 替换装备,这里要求不能为盔甲
        local illusionEquipData = EquipIllusionDataManager:getIllusionEquipDataFromEquipData(v)
        local equipType = illusionEquipData:getEquipmentType()

        local animationArr = self._equipmentArr[equipType]
        if(animationArr) then 
            for k, animation in pairs(animationArr) do
                if(not tolua.isnull(animation)) then 
                    animation:removeFromParent()
                end
            end
        end
        animationArr = {}

        if equipType == EQUIPMENT_TYPE.Helmet then
            self:changeHelmet(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Shoulders then
            self:changeShoulder(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Gloves then
            self:changeGloves(illusionEquipData)
        -- elseif equipType == EQUIPMENT_TYPE.Boots then
        --     self:changeShoes(illusionEquipData)
        elseif equipType == EQUIPMENT_TYPE.Weapon then
            self:changeWeapon(illusionEquipData)
        end
        handleTypeArr[equipType] = true
        self:handleEquipmentAnimation(illusionEquipData)
    end

    for k, animationArr in pairs(self._equipmentArr) do 
        if(not handleTypeArr[k] and animationArr) then 
            for k, animation in pairs(animationArr) do 
                if(not tolua.isnull(animation)) then
                    animation:removeFromParent()
                end
            end
            animationArr = nil
        end
    end
end

function ManorDressUpShelfOperationView:heroSelfAddComponent(mountName, animationNode)
    if(self._functionNPCAnimation and animationNode and mountName) then
        self._functionNPCAnimation:addComponent(mountName, animationNode)
        if(self.isPause) then
            Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(self, function()
                if(not tolua.isnull(animationNode)) then
                    animationNode:pause()
                end
            end, 2)
        end
    end
end

function ManorDressUpShelfOperationView:handleEquipmentAnimation(equipmentData)
    if(equipmentData) then 
        local equipType = equipmentData:getEquipmentType()
        local spineName,slotOrAnimationArr = equipmentData:getWeaponEffectCombination()
        
        if(spineName and slotOrAnimationArr and #slotOrAnimationArr > 0) then
            self._equipmentArr[equipType] = {}
            for k, v in ipairs(slotOrAnimationArr) do 
                local slotName = v
                local animationName = v
                local animation = UI.Animation:create()
                animation:init(spineName..".json", spineName..".atlas", 1)
                animation:setAnimation(animationName, true)
                self:heroSelfAddComponent(slotName, animation)

                if self._equipmentArr[equipType] == nil then 
                    self._equipmentArr[equipType] = {}
                end
                table.insert(self._equipmentArr[equipType], animation)
            end
        end
    end
    -- 
end


-- 换盔甲
function ManorDressUpShelfOperationView:changeArmor(skin)
    if self._functionNPCAnimation and skin then
        if (self._skin ~= skin) then
            self._skin = skin
            self._functionNPCAnimation:setSkin(skin)
        end
        self._functionNPCAnimation:setToSetupPose()
    end
end

-- 换头盔
function ManorDressUpShelfOperationView:changeHelmet(equipmentData)
    
    if self._functionNPCAnimation and equipmentData then
        local equipmentID = equipmentData.goodsID
        local remarksField = AvalonUtil:splitStr(equipmentData.remarksField[1], ",")
        -- 处理最前面一位
        local attachmentID = equipmentData:getAttachmentID()     
        -- 新增的头盔表现
        local attachmentName = string.format("101/0/%s/%s-0-",attachmentID,attachmentID)
        local mountName = 101
        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._functionNPCAnimation:setAttachment(name,attachment)
                end
            end
        end

    end
end

-- 换肩膀
function ManorDressUpShelfOperationView:changeShoulder(equipmentData)
    if self._functionNPCAnimation and equipmentData then
        local equipmentID = equipmentData.goodsID
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("103/0/%s/%s-0-",attachmentID,attachmentID)
        local mountName = 103

        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._functionNPCAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end 

-- 换手套
function ManorDressUpShelfOperationView:changeGloves(equipmentData)
    if self._functionNPCAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentName = string.format("104/0/%s/%s-0-",attachmentID,attachmentID)

        local mountName = 104
        local combinationArr = equipmentData.componentCombination
        if combinationArr then
            for k,v in pairs(combinationArr) do
                if v ~= "" then
                    local name, attachment = self:calculationMountNameAndAttachmentName(mountName, attachmentName, v)
                    self._functionNPCAnimation:setAttachment(name,attachment)
                end
            end
        end
    end
end

-- 武器
function ManorDressUpShelfOperationView:changeWeapon(equipmentData)
    if self._functionNPCAnimation and equipmentData then
        local remarksField = equipmentData.remarksField

        local attachmentID = equipmentData:getAttachmentID()
        local attachmentNamePre = string.format("108/0/%s/%s-0-",attachmentID,attachmentID)
        local weaponStr = self:getWeaponStr(equipmentData:getWeaponType())
        local combination = equipmentData.componentCombination
        for k,value in ipairs(combination) do
            local mountName = "outside"
            local attachmentName = attachmentNamePre

            if value == "01" then
                mountName = "inside"
            elseif value == "02" then
                mountName = "outside"
            elseif value == "03" then
                mountName = "book"
            elseif value == "04" then
                mountName = "shield"
            elseif(tonumber(value) > 100 and tonumber(value) < 400) then 
                mountName = string.format("inside-%s-%s", weaponStr, value)
                attachmentName = string.format("%s01-", attachmentName)
            elseif (tonumber(value) > 400) then
                mountName = string.format("shield-%s-%s", weaponStr, value)
                attachmentName = string.format("%s04-", attachmentName)
            end

            attachmentName = attachmentName..value
            self._functionNPCAnimation:setAttachment(mountName,attachmentName)
        end
    end
end

function ManorDressUpShelfOperationView:getWeaponStr(weaponType) 
    local weaponStr = nil
    if(weaponType == 1) then 
        weaponStr = "01"
    elseif (weaponType == 2) then 
        weaponStr = "02"
    elseif (weaponType == 3) then 
        weaponStr = "03"
    end

    return weaponStr
end

function ManorDressUpShelfOperationView:calculationMountNameAndAttachmentName(mountBase, attachmentBaseName, combination)
    local totalLen = string.len(combination)
    local mountName = mountBase
    local attachment = ""
    if(totalLen <=2) then 
        mountName = mountName..combination
        attachment = attachmentBaseName..combination
    else
        local partStr = string.format("%02d", string.sub(combination, 1, totalLen- 2))
        mountName = mountName..partStr.."-"..combination
        attachment = attachmentBaseName..partStr.."-"..combination
    end

    return mountName, attachment
end

















function ManorDressUpShelfOperationView:refreshRightLayout()
    self._rightLayout:removeAllChildren()

    local bg = UI.Image:create()
    bg:init("ui_illusionstand_paper_2.png")
    bg:center()
    self._rightLayout:addChild(bg)

    local templateData = ConfigManager:getAllIllusionRackDataByID(self._clickIndex)
    self._templateData = templateData
    if templateData then
        local suitNameStr = LanguageManager:getInstance():getLocalString(templateData.groupName)

        local nameText = UI.Text:create()
        nameText:init(suitNameStr, UI.FONT_BOLD, UI.FONT_SIZE_26PX, {r=37,g=37,b=40})
        nameText:centerUp(12)
        bg:addChild(nameText)
    end

    local splitLine = UI.Image9:create()
    splitLine:init(
        "ui_scale9image_banner_line_long.png",
        CCRectMake(20, 1, 1, 1),
        cc.size(347 - 20, 2)
    )
    splitLine:leftUp(10, 55)
    bg:addChild(splitLine)

    local a,b,c, contentList = mvc.manorDressUpShelfModel:suitListShowRedPointById(self._clickIndex)


    local tvWidth, tvHeight = 321, 395
    local tableView = UI.TableView:create({}, tvWidth, tvHeight)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(14,22)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 297,74 + 6
    end) 
    tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()

                local view = mvc.manorEquipListCellView:create(contentList[luaIdx])
                view:init()
                view:leftBottom(10,0)
                cell:addChild(view)

            end, 
            function(e) 
                printError("------------------------refreshRightLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        local clickIndex = cell:getIdx() + 1
        local state = contentList[clickIndex].state

        if state == 2 then
            Net.NetManorSystem:reqIllusionActivateEquip(self._clickIndex,contentList[clickIndex].goodsID)
        end

    end)

    tableView:onUpdateCellNumbers(function()
        return table.nums(contentList)
    end)
    self._rightLayout:addChild(tableView)
    tableView:reloadData()

end



function ManorDressUpShelfOperationView:bindModel()

end


function ManorDressUpShelfOperationView:unbindModel()

end





return ManorDressUpShelfOperationView













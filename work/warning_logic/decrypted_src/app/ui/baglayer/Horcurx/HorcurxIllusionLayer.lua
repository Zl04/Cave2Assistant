-- HorcurxIllusionLayer.lua
-- HorcurxLevel.lua
-- Using:魂器 
require("utils.ObserverVariable")
require("app.config.ConfigManager")
local LanguageManager = require "app.game.LanguageManager"

require("utils.UIUtil")
local LanguageManager = require "app.game.LanguageManager"
require "app.ui.baglayer.Horcurx.HorcurxDataManager"
require "app.ui.baglayer.RoleShow.RoleAnimation"

local winSize = cc.Director:getInstance():getWinSize()
local languageManagerInstance = LanguageManager:getInstance()
local LayoutUtil = require "app.ui.UILayoutUtils"

UI = UI or {}

local HorcurxIllusionLayer = class("HorcurxIllusionLayer", UI.HWBtnComponent)
UI.HorcurxIllusionLayer = HorcurxIllusionLayer
-- 关卡选择资源
local COM_RES_LIST = {
    "ui_bg_paper3.plist",
    "ui_package_task.plist",
    "ui_package_skill.plist",
}

local evolutionConfig = ConfigManager.getHorcurxConfig().getEvolutionConfig()

local layoutUU 
local COM_WIDTH = 852
local COM_HEIGHT = 534
function HorcurxIllusionLayer:ctor()
    HorcurxIllusionLayer.super.ctor(
    self,UIType.HORCURX_LAYER,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
    )
    self.rootLayer = nil;           --root节点

   
    self:registerListener();

    -- self:enableDebugDraw()
    layoutUU = LayoutUtil.new("illusion", "app.scene.mainscene.LayoutPosConfig", false)
end

function HorcurxIllusionLayer:dtor()
    HorcurxIllusionLayer.super.dtor(self)
    self:unRegisterListener();

    reload_script_file("app.ui.baglayer.Horcurx.HorcurxIllusionLayer")
end

function HorcurxIllusionLayer:onIllusionResult(data)
    if data.isIllusion then
        UI.ScrollBar:createByText(UI.TEXT_1212417)
        --animation
        self.curIllusionIdx = HorcurxDataManager:getHorcurxIllusionId()
        self:onUpdateView()
    elseif data.isEvolution then
        UI.ScrollBar:createByText(UI.TEXT_1212416)
        -- animation
        require "app.ui.baglayer.Horcurx.HorcurxEvolutionResultLayer" 
        local view = UI.HorcurxEvolutionResultLayer:create()
        view:init()
        UI.UIManager:getRootNode():addChild(view, UI_ZORDER.TIPS)
        self:updateLeftView()
        self:onClickBtnHandler(self.bg[self.selectIdx])
    end

end

-- 注册监听事件(可选)
function HorcurxIllusionLayer:registerListener()
    -- 角色状态更新 
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onIllusionResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end


-- 注销监听事件(可选)
function HorcurxIllusionLayer:unRegisterListener()
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onIllusionResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end

-- 初始化视图
function HorcurxIllusionLayer:onInitView()
    
    local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    centerBg:setContentSize(COM_WIDTH, COM_HEIGHT)
    centerBg:setCapInsets(CCRectMake(304,141,1,1))
    centerBg:setPosition(cc.p( COM_WIDTH/2,   COM_HEIGHT/2))
    self:addChild(centerBg)

    -- local spr = cc.Sprite:create("xxxx2.png")
    -- spr:setOpacity(150)
    -- spr:setPosition(cc.p(472, 288))
    -- self:addChild(spr)
   
    local img = UI.Image:create()
    img:init("ui_horcrux_illusion_bg.png")
    addChildAuto(layoutUU, self, img, "ui_horcrux_illusion_bg")

    local title = UI.Text:create()
    title:init(UI.TEXT_1212405, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194 )
    title:centerUp(10)
    img:addChild(title)

    local img = UI.Image:create()
    img:init("ui_horcrux_illusion_mask.png")
    self:addChild(img)
    
    local animation2 = UI.Animation:create()
    animation2:init("effect_ui_horcruxes_down.json", "effect_ui_horcruxes_down.atlas", 1);
    -- animation2:setAnimation("unlock", false)
    animation2:setAnimation("idle1", true)
    addChildAuto(layoutUU, self, animation2, "animation2")
    animation2:setSize(100,50)
    -- animation2:enableDebugDraw()

    

    self:updateLeftView()
end

function HorcurxIllusionLayer:updateLeftView()
    if self.rootLayer then
        self.rootLayer:removeFromParent()
    end
    local com = UI.Component:create()
    com:init()
    com:setSize(COM_WIDTH, COM_HEIGHT)
    self:addChild(com)
    self.rootLayer = com

    local lv = HorcurxDataManager:getCurLevel()
    self.curEvolutionLv = HorcurxDataManager:getHorcurxEvolutionLv(lv)
    self.curIllusionIdx = HorcurxDataManager:getHorcurxIllusionId()
    

    -- local leftBtnScrollView = UI.ScrollView:create()
    -- leftBtnScrollView:init(0, 0, 0, 0)
    -- leftBtnScrollView:setSize(140, 530)
    -- leftBtnScrollView:setTouchEnable(true)
    -- addChildAuto(layoutUU, self.rootLayer, leftBtnScrollView, "leftBtnScrollView")
    -- leftBtnScrollView:setScrollBarEnabled(true)
    -- leftBtnScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    -- leftBtnScrollView:setScrollBarWidth(5)
    -- leftBtnScrollView:setCircleVisible(false)
    
    -- local leftLayout = UI.Layout:create()
    -- leftLayout:init()
    -- leftLayout:leftBottom(0, 0)
    -- leftBtnScrollView:addInnerNode(leftLayout)

    -- local beginPosY = 66 * evolutionConfig.size
    -- if(beginPosY > leftLayout:getContentSize().height) then 
    --     leftLayout:setSize(leftLayout:getContentSize().width, beginPosY)
    -- end

    


    self.bg = {}
    for i = 1, evolutionConfig.size do
        self.bg[i] = {}
        -- local configInfo = evolutionConfig[i]

        -- local   bg = UI.Image:create()
        -- bg:init("ui_horcrux_illusion_box.png")
        -- bg:setScale(0.9);
        -- addChildAuto(layoutUU, leftLayout, bg, "bg" .. i)
        

        -- if i <= self.curEvolutionLv + 1 then
        --     local img = UI.Image:create()
        --     img:init("ui_horcux_icon_Small_"..i..".png")
        --     img:center()
        --     bg:addChild(img)
        --     bg:setTouchEnable(true)
        --     bg:addEventListener(UIEvent.COMPONENT_CLICK, self,self.onClickBtnHandler)
        -- else
        --      local img = UI.Image:create()
        --     img:init("ui_task_banner_reward_up.png")
        --     img:center()
        --     bg:addChild(img)
        -- end

        -- local img = UI.Image:create()
        -- img:init("ui_horcrux_illusion_box_click.png")
        -- img:centerLeft(-65)
        -- bg:addChild(img)
        -- bg.selectBg = img
        -- img:hide()
               
        -- if i <= self.curEvolutionLv then
        --     local img = UI.Image:create()
        --     img:init("ui_horcrux_illusion_box_click_up.png")
        --     img:leftUp(3, 0)
        --     bg:addChild(img)
        --     bg.horcurxImgBg = img
        --     bg.horcurxImgBg:hide()

        --     local img = UI.Image:create()
        --     img:init("ui_information_horcrux.png")
        --     img:leftUp(8, -3)
        --     bg:addChild(img)
        --     bg.horcurxImg = img
        --     bg.horcurxImg:hide()
        -- else
        --     if i == self.curEvolutionLv + 1 then
        --         local lockEff = UI.Animation:create()
        --         lockEff:init("effect_ui_common_unlock.json", "effect_ui_common_unlock.atlas", 1);
        --         lockEff:leftUp(20, 18)
        --         -- lockEff:setAnimation("unlock", false)
        --         lockEff:setAnimation("idle", true)
        --         bg:addChild(lockEff, 10)
        --     end
        -- end
        -- bg.idx = i
        -- bg.posX,bg.posY = bg:getPosition()
        -- bg.posY = -bg.posY
        -- self.bg[i] = bg
    end


    self._leftTableView = cc.TableView:create(cc.size(140, 530))
    self._leftTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._leftTableView:setPosition(cc.p(0,0))
    self._leftTableView:setDelegate()
    self._leftTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self.rootLayer:addChild(self._leftTableView)
    --registerScriptHandler functions must be before the reloadData funtion
    self._leftTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self._leftTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self._leftTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    self._leftTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self._leftTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self._leftTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    self._leftTableView:setScrollBarEnabled(false)

    self._leftTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    print("  @@@@@@@@ ")
    -- local beginPosY = 66 * evolutionConfig.size
    -- if(beginPosY > self._leftTableView:getContentSize().height) then 
    --     self._leftTableView:setSize(self._leftTableView:getContentSize().width, beginPosY)
    -- end

end

function HorcurxIllusionLayer:numberOfCellsInTableView(table)    
    return #self.bg
end

function HorcurxIllusionLayer:scrollViewDidScroll(view)
    
end

function HorcurxIllusionLayer:scrollViewDidZoom(view)

end

function HorcurxIllusionLayer:cellSizeForTable(table,idx)
    return 0,66
end

function HorcurxIllusionLayer:tableCellTouched(table,cell)
    Avalon.AudioManager:playSound(self.clickAudioID)
    local index = cell:getIdx()
    self:onClickBtnHandler(self.bg[index + 1])
end

function HorcurxIllusionLayer:tableCellAtIndex(tableView,idx)
    
    local cell = tableView:dequeueCell()
    xpcall(function()      
        local i = idx + 1

        if cell then
            cell:removeFromParent()
            cell = nil
        end

        if nil == cell then
            cell = cc.TableViewCell:new()
            if self.bg[i] then

                local leftLayout = UI.Layout:create()
                leftLayout:init()
                leftLayout:leftBottom(0, 0)
                leftLayout:setContentSize(cc.size(140,66))

                local bg = UI.Image:create()
                bg:init("ui_horcrux_illusion_box.png")
                bg:setScale(0.9);
                bg:centerLeft(30, 0)
                leftLayout:addChild(bg)

                if i <= self.curEvolutionLv + 1 then
                    local img = UI.Image:create()
                    img:init("ui_horcux_icon_Small_"..i..".png")
                    img:center()
                    img:setScaleY(0.9)
                    bg:addChild(img)
                    -- bg:setTouchEnable(true)
                    -- bg:addEventListener(UIEvent.COMPONENT_CLICK, self,self.onClickBtnHandler)
                else
                    local img = UI.Image:create()
                    img:init("ui_task_banner_reward_up.png")
                    img:center()
                    img:setScaleY(0.9)
                    bg:addChild(img)
                end
                

                local img = UI.Image:create()
                img:init("ui_horcrux_illusion_box_click.png")
                img:centerLeft(-35)
                bg:addChild(img)
                bg.selectBg = img
                img:hide()
                    
                if i <= self.curEvolutionLv then

                    local img = UI.Image:create()
                    img:init("ui_horcrux_illusion_box_click_up.png")
                    img:leftUp(3, 0)
                    bg:addChild(img)
                    bg.horcurxImgBg = img
                    bg.horcurxImgBg:hide()

                    local img = UI.Image:create()
                    img:init("ui_information_horcrux.png")
                    img:leftUp(8, -3)
                    bg:addChild(img)
                    bg.horcurxImg = img
                    bg.horcurxImg:hide()
                else
                    if i == self.curEvolutionLv + 1 then
                        local lockEff = UI.Animation:create()
                        lockEff:init("effect_ui_common_unlock.json", "effect_ui_common_unlock.atlas", 1);
                        lockEff:leftUp(20, 18)
                        lockEff:setAnimation("idle", true)
                        bg:addChild(lockEff, 10)
                    end
                end

                bg.idx = i
                -- bg.posX,bg.posY = bg:getPosition()
                -- bg.posY = -bg.posY
                self.bg[i] = bg
                leftLayout:setName("cell")
                cell:addChild(leftLayout)
                self:onUpdateView(true)
            end

            -- local pArchiveCell = UI.JoinApplyCell:create(self.guildData.applyJoinList[idx + 1],idx)
            -- pArchiveCell:setName("cell")
            -- pArchiveCell:leftUp(125, -53)
            -- cell:addChild(pArchiveCell)
        -- else
        --     local obj = cell:getChildByName("cell");
        --     obj:refreshPosition()
        end
    end, 
    function(e) 
        printError("--------------------HorcurxIllusionLayer:tableCellAtIndex---------------------error")
    end, 1) 
    return cell;
end

function HorcurxIllusionLayer:onUpdateView( onlyLeft)
    -- self._leftTableView:reloadData(true, 0, Game.TableCellInitTime, Game.TableCellAddTime)
    local id = self.selectIdx or HorcurxDataManager:getHorcurxIllusionDefaultId()

    self:onClickBtnHandler(self.bg[id], onlyLeft)
end

function HorcurxIllusionLayer:onClickBtnHandler(bg, onlyLeft)
    if bg.selectBg then
        local curIdx = bg.idx

        if self.selectIdx then
            local bg = self.bg[self.selectIdx]
            if not tolua.isnull(bg.selectBg) then
                bg.selectBg:hide()
            end
            
            
            -- bg:setPosition(cc.p(bg.posX, -bg.posY))
        end

        self.selectIdx = curIdx

        -- if self.selectIdx <= self.curEvolutionLv then
            bg.selectBg:show()
            -- bg:setPosition(cc.p(bg.posX + 18, -bg.posY))
        -- end

        for i = 1, #self.bg do
            local bg = self.bg[i]
            if bg and bg.horcurxImgBg and bg.horcurxImg then
                bg.horcurxImg:hide()
                bg.horcurxImgBg:hide()
            end
        end
        
        local bg2 = self.bg[HorcurxDataManager:getHorcurxIllusionId()]
        if not tolua.isnull(bg2.horcurxImg) and not tolua.isnull(bg2.horcurxImgBg) then
            bg2.horcurxImg:show()
            bg2.horcurxImgBg:show()
        end
        



        if not onlyLeft then
            self:updateRightView()
        end
    end
end


local function createOneDes(isShowBackground, desc, text)
    --202,21
    local com = UI.Component:create()
    com:init()
    com:setSize(135,21)

    if isShowBackground then
        local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_bg4.png")
        centerBg:setContentSize(135,22)
        centerBg:setCapInsets(CCRectMake(1,1,1,1))
        centerBg:setPosition(cc.p( 135/2,   22/2))
        com:addChild(centerBg)
    end


    local title = UI.Text:create()
    title:init(desc, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45 )
    title:setTextLeft()
    title:centerLeft(6)
    com:addChild(title)

    local title = UI.Text:create()
    title:init(tostring(text), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45 )
    title:setTextLeft()
    title:centerRight(4)
    com:addChild(title)


    return com
end



function HorcurxIllusionLayer:showUpdate()
    self._roleAnimation:onUpdateView()
    if not RoleDataManager:getMaster():isHorcruxTransform() then
        self._roleAnimation:getRoleRender():showHorcruxExterior(self.selectIdx)
    end
end

function HorcurxIllusionLayer:onGoToEvolution()
    local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.selectIdx)
    local costMoney = config.money
    local goodNumber = 0
    if costMoney[1] == 23020001 then
        goodNumber = RoleDataManager:getMaster():getCurCoin()
    else
        goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(costMoney[1], true)
    end
    print("goodNumber", goodNumber, costMoney[1])
    if goodNumber < costMoney[2] then
        UI.ScrollBar:createByText(UI.TEXT_110210)
        return
    end

    if RoleDataManager:getMaster():isHorcruxTransform() then
        UI.ScrollBar:createByText(UI.TEXT_1213204)
        return
    end

    Net.NetRoleSystem:reqHorcurxEvolutionUp()
end
function HorcurxIllusionLayer:updateRightView()
    if self.rightContent then
        self.rightContent:removeFromParent()
    end
    local com = UI.Component:create()
    com:init()
    self:addChild(com)

    self.rightContent = com
    --属性
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(100, 20)
    layout:enableAutoWidth()

    -- local str = UI.TEXT_1212398 --
    -- if self.selectIdx <= self.curEvolutionLv then
    --     str = UI.TEXT_1212422 --魂器纸质
    -- end
    -- local basicDesc = UI.Text:create()
    -- basicDesc:init(str, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45 )
    -- addChildAuto(layoutUU, self.rightContent, basicDesc, "basicDesc")

    -- local idx = self.selectIdx <= self.curEvolutionLv and self.curEvolutionLv or self.selectIdx
    -- local evolutionConfig = HorcurxDataManager:getHorcurxEvolutionConfig(idx)

    -- local attrTags = {"atkMin",  "atkMax", "magic","hp","physicDef","magicDef"}
    -- for i = 1, 3 do
    --     local attrName = attrTags[i] .. "Qualifications"
    --     local attrStr = ToolsUtil:attrNameToLanguageString(attrTags[i])
    --     local val = evolutionConfig[attrName]
    --     local title = createOneDes((i%2)~=0, attrStr, val)
    --     title:floatUp(4)
    --     layout:addComponent(title)
    -- end
    -- addChildAuto(layoutUU, self.rightContent, layout, "layout")
        --属性
    -- local layout = UI.Layout:create()
    -- layout:init()
    -- layout:setSize(100, 20)
    -- layout:enableAutoWidth()
    -- for i = 4, #attrTags do
    --     local attrName = attrTags[i] .. "Qualifications"
    --     local attrStr = ToolsUtil:attrNameToLanguageString(attrTags[i])
    --     local val = evolutionConfig[attrName]
    --     local title = createOneDes((i%2)==0, attrStr, val)
    --     title:floatUp(4)
    --     layout:addComponent(title)
    -- end
    -- addChildAuto(layoutUU, self.rightContent, layout, "layout2")


        -- 滚动视图

    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()

    if self.selectIdx == HorcurxDataManager:getHorcurxIllusionId() then
        local img = UI.Image:create()
        img:init("ui_information_horcrux.png")
        img:floatLeft(5)
        layout:addComponent(img)
       
    end
    -- for i = 1, #self.bg do
    --     local bg = self.bg[i]
    --     if bg and bg.horcurxImgBg and bg.horcurxImg then
    --         bg.horcurxImg:hide()
    --         bg.horcurxImgBg:hide()
    --     end
    -- end

    -- local bg = self.bg[HorcurxDataManager:getHorcurxIllusionId()]
    -- bg.horcurxImg:show()
    -- bg.horcurxImgBg:show()


    local com = UI.Component:create()
    com:init()
    com:setSize(5,5)
    -- com:enableDebugDraw()
    addChildAuto(layoutUU, self.rightContent, com, "horcurxName")

    local name = HorcurxDataManager:getHorcurxName(self.selectIdx)
    local descText1 = UI.Text:create()
    descText1:init(languageManagerInstance:getLocalString(name), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    descText1:floatLeft(5)
    layout:addComponent(descText1)
    layout:center()
    com:addChild(layout)

    local text = UI.Text:create()
    text:init(
        UIUtil:lang(1112829),
        UI.FONT_STANDARD,
        UI.FONT_SIZE_20PX,
        UI.FONT_COLOR_41_41_45
    )
    addChildAuto(layoutUU, self.rightContent, text, "skillDesc11","leftBottom")




        -- 角色动画
    self._roleAnimation = UI.RoleAnimation:create(false)
    local heroData = clone(RoleDataManager:getMaster())
    heroData:setLooks(0)
    heroData:setextraLooks(0)
    self._roleAnimation:init(heroData)
    -- self._roleAnimation:init(RoleDataManager:getMaster())
    self._roleAnimation:showHelmet(true)
    self._roleAnimation:setRoleData(heroData)
    -- self._roleAnimation:setRoleData(RoleDataManager:getMaster())
    addChildAuto(layoutUU, self.rightContent, self._roleAnimation, "roleAnimation")

    if not RoleDataManager:getMaster():isHorcruxTransform() then
        self._roleAnimation:getRoleRender():showHorcruxExterior(self.selectIdx)
    end

    self:updateSkillIconArea()

    self:updateTransSkillInfoView()
    self.numberText = nil

    if self.selectIdx == self.curIllusionIdx then
        return
    end

    if self.selectIdx > self.curEvolutionLv then
        if HorcurxDataManager:isCanEvolutionTo(self.selectIdx) then

            local illusionBtn = UI.Button:create()
            illusionBtn:init("ui_btn_yellow5_0.png", "ui_btn_yellow5_1.png", "ui_btn_yellow_5.png")
            illusionBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onGoToEvolution)
            illusionBtn:setText(UI.TEXT_1212408)
            illusionBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
            addChildAuto(layoutUU, self.rightContent, illusionBtn, "illusionBtn","center")

            -- 金币背景
            local bg = UI.Image:create()
            bg:init("ui_information_hero_box_up.png")
            addChildAuto(layoutUU, self.rightContent, bg, "ui_information_hero_box_up")

            local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.selectIdx)
            local costMoney = config.money
            local goodsData = GoodsDataManager:createLocalGoodsData(costMoney[1])
            -- 黄金图标
            local glodIcon = UI.Image:create()
            -- glodIcon:init("symbol_gaming_money.png")
            glodIcon:init(goodsData:getIconName())
            glodIcon:centerLeft(50)
            glodIcon:setScale(0.5)
            bg:addChild(glodIcon)
            local costNum = costMoney[2]
            -- 金币数字
            local number = UI.Text:create()
            number:init(costNum.."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
            number:centerLeft(glodIcon:getContentSize().width + 4)
            number:setTextCenter()
            bg:addChild(number)
            glodIcon:centerLeft(bg:getContentSize().width /2 - (glodIcon:getContentSize().width + number:getContentSize().width + 4)/2)

            local goodNumber
            if costMoney[1] == 23020001 then
                goodNumber = RoleDataManager:getMaster():getCurCoin()
            else
                goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(costMoney[1], true)
            end
            if goodNumber < costNum then
                number:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            end
            self.numberText = number
        else
            local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.selectIdx)
            local desStr = UI.TEXT_1212406
            if config then
                desStr = LanguageManager:getInstance():getLocalString(config.UnlockDes)
            end

            local bg = UI.Image:create()
            bg:init("ui_information_reminder.png")
            addChildAuto(layoutUU, self.rightContent, bg, "ui_information_reminder")
            local text = UI.Text:create()
            text:init(desStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_NOT_ENOUGH_FOR_FORGE )
            addChildAuto(layoutUU, self.rightContent, text, "notenoughtext")
        end
    else
        local illusionBtn = UI.Button:create()
        illusionBtn:init("ui_btn_yellow_0.png", "ui_btn_yellow_1.png", "ui_btn_yellow_2.png")
        illusionBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()

        if RoleDataManager:getMaster():isHorcruxTransform() then
            UI.ScrollBar:createByText(UI.TEXT_1213204)
            return
        end
            Net.NetRoleSystem:reqSetHorcurxIllusion(self.selectIdx)
        end)
        illusionBtn:setText(UI.TEXT_1212391)
        illusionBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        addChildAuto(layoutUU, self.rightContent, illusionBtn, "illusionBtn","center")
    end

end
function HorcurxIllusionLayer:onCurrencyChangeHandler()
    if not self.numberText then
        return
    end
    local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.selectIdx)
    local costMoney = config.money
    local costNum = costMoney[2]
    local goodNumber = 0
    if costMoney[1] == 23020001 then
        goodNumber = RoleDataManager:getMaster():getCurCoin()
    else
        goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(costMoney[1], true)
    end
    if goodNumber < costNum then
        self.numberText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    else
        self.numberText:setFontColor(UI.FONT_COLOR_250_211_124)
    end
end

function HorcurxIllusionLayer:updateTransSkillInfoView()
    local config = HorcurxDataManager:getHorcurxEvolutionConfig(self.selectIdx)
    local skillStr = config.changeSkill
    local skillIds = string.split(skillStr, ";")
    if self.skillInfoLayer then
        self.skillInfoLayer:removeFromParent()
    end
    local skillInfoLayer = UI.Layout:create()
    skillInfoLayer:init()
    skillInfoLayer:setSize(300, 70)
    self.skillInfoLayer = skillInfoLayer
    addChildAuto(layoutUU, self, skillInfoLayer, "skillChange","leftBottom")

    
    self.skillClickedIdx = nil
    local clickSkill
    self.skillInfoLayer.skillItemBg = {}
    for i = 1, #skillIds do
        local skillID = tonumber(skillIds[i])
        local skillConfig = ConfigManager:getSkillConfigById(skillID)
        local com = UI.Component:create()
        com:init()

        local itemSelect = UI.Image:create()
        itemSelect:init("ui_horcux_click.png")
        itemSelect:center()
        com:addChild(itemSelect,10)
        itemSelect:hide()
        table.insert(self.skillInfoLayer.skillItemBg, itemSelect)
        local width, height = itemSelect:getSize()
        com:setSize(width, height)
        -- 技能背景
        local itemBG = UI.Image:create()
        itemBG:init("ui_skill_banner_skillbox.png")
        itemBG:center()
        com:addChild(itemBG)
        com:floatLeft(-7)
        skillInfoLayer:addComponent(com)
        itemBG:setScale(0.8)
        
        -- 技能图标
        if skillConfig.iconID ~= "" then
            local itemSp = UI.Image:create()
            itemSp:init(skillConfig.iconID)
            itemSp:center()
            itemBG:addChild(itemSp, 2)
        end
        com:setTouchEnable(true)
        com:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, button, touchPosition)
            clickSkill(i)
        end)
    end

    local skillInfoScrollView = UI.ScrollView:create()
    skillInfoScrollView:init(0, 0, 0, 0)
    skillInfoScrollView:setSize(280, 181)
    skillInfoScrollView:setTouchEnable(true)
    addChildAuto(layoutUU, self.rightContent, skillInfoScrollView, "skillInfoScrollView")
    skillInfoScrollView:setScrollBarEnabled(true)
    skillInfoScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    skillInfoScrollView:setScrollBarWidth(5)
    skillInfoScrollView:setCircleVisible(false)
    
    local descLayout = UI.Layout:create()
    descLayout:init()
    descLayout:leftUp(0, 0)
    skillInfoScrollView:addInnerNode(descLayout)
    -- 技能冷却
    local mSkillName = cc.Label:createWithTTF(UI.TEXT_111006, UI.FONT_STANDARD, UI.FONT_SIZE_18PX)
    mSkillName:setPosition(810,240)
    mSkillName:setTextColor(UI.FONT_COLOR_41_41_45)
    descLayout:addChild(mSkillName)
    mSkillName:setAnchorPoint(0,1)

     -- 技能冷却
     local mTextCd = cc.Label:createWithTTF(UI.TEXT_111006, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
     mTextCd:setPosition(810,240)
     mTextCd:setTextColor(UI.FONT_COLOR_41_41_45)
     descLayout:addChild(mTextCd)
     mTextCd:setAnchorPoint(0,1)
 
     -- 吟唱时间/蓄力时间，瞬发
     local prepareCd = cc.Label:createWithTTF("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
     prepareCd:setPosition(810,240)
     prepareCd:setTextColor(UI.FONT_COLOR_41_41_45)
     descLayout:addChild(prepareCd)
     prepareCd:setAnchorPoint(0,1)
 
 
     local mTxtSkillDes = cc.Label:createWithTTF("SkillDes", UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
     mTxtSkillDes:setPosition(0,0)
     mTxtSkillDes:setTextColor(UI.FONT_COLOR_41_41_45)
     descLayout:addChild(mTxtSkillDes)
     mTxtSkillDes:setAnchorPoint(0,1)
     mTxtSkillDes:setWidth(235)
    -- 技能冷却
    local mTextSkillCD = cc.Label:createWithTTF(UI.TEXT_111006, UI.FONT_STANDARD, UI.FONT_SIZE_16PX)
    mTextSkillCD:setPosition(810,240)
    mTextSkillCD:setTextColor(UI.FONT_COLOR_41_41_45)
    descLayout:addChild(mTextSkillCD)
    mTextSkillCD:setAnchorPoint(0,1)
     
          

    function clickSkill(idx)
        local skillData =  SkillDataManager:createSkillForSkillId(skillIds[idx])
        if self.skillClickedIdx then
            self.skillInfoLayer.skillItemBg[self.skillClickedIdx]:hide()
        end
        if self.skillInfoLayer.skillItemBg[idx] then
            self.skillInfoLayer.skillItemBg[idx]:show()
        end
        self.skillClickedIdx = idx

        mSkillName:setString(skillData.name)
        mTextSkillCD:setString(UI.TEXT_111006 .. string.format("%.1f",skillData:getCooldown()/1000))
        mTxtSkillDes:setString(skillData.description)
        if skillData.type == SkillType.PASSIVE then
            -- self.mTxtSkillConsume:setVisible(false)
            mTextSkillCD:setVisible(false)
            prepareCd:setVisible(false)
    
            mTxtSkillDes:setPosition(0,0)
        else
            mTextSkillCD:setVisible(true)
            prepareCd:setVisible(true)
            mTextSkillCD:setString(UI.TEXT_111006 .. string.format("%.1f",skillData:getCooldown()/1000))

            local prepareCD = ""
            if(skillData:getSkillType() == SkillType.PHYSICAL) then 
                if skillData:getPrepareTime() <= 0 then
                    prepareCD = LanguageManager:getInstance():getLocalString(1111371)..LanguageManager:getInstance():getLocalString(1111372)
                else
                    prepareCD = LanguageManager:getInstance():getLocalString(1111371)..string.format("%.1f", skillData:getPrepareTime())
                end
            elseif(skillData:getSkillType() == SkillType.HORCURX) then 
                if skillData:getPrepareTime() <= 0 then
                    prepareCD = LanguageManager:getInstance():getLocalString(1111370)..LanguageManager:getInstance():getLocalString(1111372)
                else
                    prepareCD = LanguageManager:getInstance():getLocalString(1111370)..string.format("%.1f", skillData:getPrepareTime())
                end
            end
            
            prepareCd:setString(prepareCD)
        end
        local prepareCD = ""
        if(skillData:getSkillType() == SkillType.PHYSICAL) then 
            if skillData:getPrepareTime() <= 0 then
                prepareCD = LanguageManager:getInstance():getLocalString(1111371)..LanguageManager:getInstance():getLocalString(1111372)
            else
                prepareCD = LanguageManager:getInstance():getLocalString(1111371)..string.format("%.1f", skillData:getPrepareTime())
            end
        elseif(skillData:getSkillType() == SkillType.MAGIC) then 
            if skillData:getPrepareTime() <= 0 then
                prepareCD = LanguageManager:getInstance():getLocalString(1111370)..LanguageManager:getInstance():getLocalString(1111372)
            else
                prepareCD = LanguageManager:getInstance():getLocalString(1111370)..string.format("%.1f", skillData:getPrepareTime())
            end
        end
        
        prepareCd:setString(prepareCD)
            

        -- 计算当前拥有总高度
        local height = 0
        height = height + mSkillName:getContentSize().height + 7
            
        height = height + mTxtSkillDes:getContentSize().height

        if(prepareCd:isVisible()) then 
            height = height + prepareCd:getContentSize().height
        end

        if(mTextSkillCD:isVisible()) then 
            height = height + mTextSkillCD:getContentSize().height
        end

        -- 处理是否达到了文字限制高度
        local desScrollHeight = skillInfoScrollView:getContentSize().height
        if height < desScrollHeight then
            height = desScrollHeight;
        end
        
        descLayout:setSize(290, height)

        -- 根据排版设计位置
        height = height

        if mSkillName:isVisible() then
            mSkillName:setPosition(0, height)
            height = height - mSkillName:getContentSize().height
        end

        if mTextSkillCD:isVisible() then
            mTextSkillCD:setPosition(0, height)
            height = height - mTextSkillCD:getContentSize().height
        end

        if(prepareCd:isVisible()) then 
            prepareCd:setPosition(0, height)
            height = height - prepareCd:getContentSize().height
        end

        if mTxtSkillDes:isVisible() then
            mTxtSkillDes:setPositionY(height)
        end
        skillInfoScrollView:refresh()
        skillInfoScrollView:scrollToTop()
    end
    clickSkill(1)
end

function HorcurxIllusionLayer:updateSkillIconArea()
    local nextSkillInfos = HorcurxDataManager:getSkillInfosByEvolutionLv(self.selectIdx)
    local skillId, lv = nextSkillInfos[1][1], nextSkillInfos[1][2]
    local skillData = HorcurxDataManager:getSkillData(skillId)
    if self.baseInfo then
        self.baseInfo:removeFromParent()
    end
    local icon = self:createSkillBtn(skillData, lv)
    icon:leftBottom(191, 411)
    self:addChild(icon)
    self.baseInfo = icon
end

function HorcurxIllusionLayer:createSkillBtn(skillData, lv)

    local com = UI.Component:create()
    com:init()
    -- 技能背景
    local itemBG = UI.Image:create()
    itemBG:init("ui_skill_banner_skillbox.png")
    itemBG:center()
    local size = itemBG:getContentSize()
    com:setSize(size.width, size.height)
    com:addChild(itemBG)
    -- 技能图标
    if skillData:getIconName() ~= "" then
        local itemSp = UI.Image:create()
        itemSp:init(skillData:getIconName())
        itemSp:center()
        itemBG:addChild(itemSp, 2)
    end

    local text = UI.Text:create()
    text:init(
        skillData:getName(),
        UI.FONT_STANDARD,
        UI.FONT_SIZE_18PX,
        UI.FONT_COLOR_41_41_45
    )
    text:setTextHorizontalCenterAndBottom()
    -- text:setSize(size.width, 40)
    addChildAuto(layoutUU, com, text, "skillName","leftBottom")

    -- local text = UI.Text:create()
    -- text:init(
    --     "Lv." .. lv,
    --     UI.FONT_BOLD,
    --     UI.FONT_SIZE_14PX,
    --     UI.FONT_COLOR_41_41_45
    -- )
    -- addChildAuto(layoutUU, com, text, "skillLv","leftBottom")

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(275, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    addChildAuto(layoutUU, com, lineUpImage, "lineUpImage2")

    local text = UI.Text:create()
    text:init(
        UI.TEXT_1213205,
        UI.FONT_STANDARD,
        UI.FONT_SIZE_14PX,
        UI.FONT_COLOR_41_41_45
    )
    addChildAuto(layoutUU, com, text, "skillVideoText","leftBottom")
    
    -- 技能图标
    local skillVideoSp = UI.Image:create()
    skillVideoSp:init("ui_horcrux_illusion_play_0.png")
    addChildAuto(layoutUU, com, skillVideoSp, "skillVideoSp","centerLeft")
    
    local btn = UI.Component:create()
    btn:init()
    btn:setSize(130,50)
    btn:setTouchEnable(true)
    -- btn:enableDebugDraw()
    btn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self, button, touchPosition)
        -- self:onIllusionResult({isEvolution= true})
        local HorcurxPreVideoLayer = require ("app.ui.baglayer.Horcurx.HorcurxPreVideoLayer")
        local preView = HorcurxPreVideoLayer:create()
        preView:setURL("/video/horcrux_"..self.selectIdx..".mp4")
        preView:init()
        preView:center()
        self:addChild(preView, 1001)
    end)
    addChildAuto(layoutUU, com, btn, "skillVideoSp","centerLeft")

    return com
end













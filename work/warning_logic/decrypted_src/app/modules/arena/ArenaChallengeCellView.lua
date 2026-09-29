------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/29
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ArenaChallengeCellView = class("ArenaChallengeCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 169
local COM_HEIGHT = 411

function ArenaChallengeCellView:ctor()
    ArenaChallengeCellView.super.ctor(
    	self,
    	UI.Type.NORMAL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.data = nil
end

function ArenaChallengeCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.arena", "Arena", false)
    ArenaChallengeCellView.super.init(self, ... )
end

function ArenaChallengeCellView:dtor()
    ArenaChallengeCellView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.arena.ArenaChallengeCellView")
end

function ArenaChallengeCellView:setData(data)
    self.data = data
    self:updateView()
end

function ArenaChallengeCellView:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_arena_challenge_flag_1.png")
    bg:center()
    self:addChild(bg)
    -- bg:enableDebugDraw()
    self.bg = bg

    -- 
    local honorIcon = UI.Image:create()
    honorIcon:init("ui_rankinglist_gold.png")
    honorIcon:leftUp(-12, -16)
    bg:addChild(honorIcon, 10)
    honorIcon:hide()
    self.honorIcon = honorIcon

    local nickName = UI.Text:create()
    nickName:init(
        "",
        UI.FONT_STANDARD,
        UI.FONT_SIZE_18PX,
        UI.FONT_COLOR_41_41_45
    )
    nickName:centerUp(33)
    bg:addChild(nickName)
    self.nickName = nickName

    local guildName = UI.Text:create()
    guildName:init(
        "",
        UI.FONT_STANDARD,
        UI.FONT_SIZE_14PX,
        UI.FONT_COLOR_36_181_118
    )
    guildName:centerUp(58)
    bg:addChild(guildName)
    self.guildName = guildName

    -- 添加头像
    local node = self:createHeroIcon()
    node:centerUp(104)
    bg:addChild(node)

    local node,text = self:createInfo("symbol_character_hero_power.png")
    node:centerUp(210)
    bg:addChild(node)
    self.combatScore = text

    local node,text = self:createInfo("symbol_character_hero_integral.png")
    node:centerUp(240)
    bg:addChild(node)
    self.integralText = text

    local node,text = self:createInfo("symbol_character_hero_rank.png")
    node:centerUp(270)
    bg:addChild(node)
    self.rankingText = text

    -- 按钮功能
    local okBtn = UI.Button:create()
    okBtn:init("ui_btn_yellow8_0.png","ui_btn_yellow8_1.png","ui_btn_yellow8_0.png");
    okBtn:centerBottom(59);
    okBtn:closeClickScale()
    okBtn:setText(UI.TEXT_1172013)
    okBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if(self.data) then
            Net.NetPlaySystem:requestArenaFight()
        end
    end)
    bg:addChild(okBtn)
    self.okBtn = okBtn

    local useLayout = UI.Layout:create()
    useLayout:init()
    useLayout:center()
    okBtn:addChild(useLayout,10)

    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_gaming_diamond.png")
    diamondIcon:centerLeft(25)
    useLayout:addChild(diamondIcon, 10)
    self.diamondIcon = diamondIcon
    diamondIcon:hide()

    -- 花费的水晶数量
    local diamondCost  = UI.Text:create()
    diamondCost:init("X1", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)    
    diamondCost:centerLeft(55)
    useLayout:addChild(diamondCost, 10) 
    self.diamondCost = diamondCost
    diamondCost:hide()
end

function ArenaChallengeCellView:createHeroIcon()
    local bg = UI.Image:create()
    bg:init("ui_playerstate_me_black_down01.png")
    -- bg:enableDebugDraw()

    local iconImage = UI.Image:create()
    iconImage:init("ui_arena_challenge_pattern.png")
    iconImage:center()
    bg:addChild(iconImage)

    local iconNormal = UI.Image:create()
    iconNormal:init("ui_playerstate_teammate_wait.png")
    iconNormal:center()
    bg:addChild(iconNormal)
    self.heroIcon = iconNormal

    local black = UI.Image:create()
    black:init("ui_playerstate_teammate_black.png")
    black:center()
    bg:addChild(black)

    -- 武器类型
    local weaponIcon = UI.Image:create()
    weaponIcon:init("icon-equip_small1_21080010_1.png")
    weaponIcon:leftUp(61, 8)
    bg:addChild(weaponIcon)
    self.weaponIcon = weaponIcon

    -- 等级背景图
    local lvBg = UI.Image:create()
    lvBg:init("ui_playerstate_me_grade.png")
    lvBg:leftBottom(0, 6)
    bg:addChild(lvBg)
    -- 等级
    local lvLabel = UI.Text:create()
    lvLabel:init("1", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_187_167_136)
    lvLabel:setSize(100, 50)
    lvLabel:centerLeft(-36)
    lvLabel:setTextCenter()
    lvBg:addChild(lvLabel, 10)
    self.lvText = lvLabel

    return bg
end

function ArenaChallengeCellView:createInfo(iconName)
    local bg = UI.Image:create()
    bg:init("ui_arena_challenge_banner_2.png")

    local icon = UI.Image:create()
    icon:init(iconName)
    icon:centerLeft(-1)
    bg:addChild(icon, 2)

    local infoValue = UI.Text:create()
    infoValue:init(
        ""..tostring(num),
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_190_190_190
    )
    infoValue:setWidth(81)
    infoValue:centerLeft(22)
    infoValue:setTextCenter()
    bg:addChild(infoValue, 2)

    return bg,infoValue
end

function ArenaChallengeCellView:onUpdateView()
    if(self.data) then
        local rank = 1
        local nickName = "nickName"
        local guildName = "guild"
        local combatScore = 112
        local integralNum = 121112
        local rankScore = 3232
        local lv = 232
        local equipType = 1
        local fresh = false

        local rankName = nil
        if(rank == 1) then 
            rankName = "ui_rankinglist_gold.png"
        elseif(rank == 2) then 
            rankName = "ui_rankinglist_silver.png"
        elseif(rank == 3) then 
            rankName = "ui_rankinglist_copper.png"
        end
        if(rankName) then 
            self.honorIcon:show()
            self.honorIcon:setSpriteName(rankName)
            self.bg:setSpriteName("ui_arena_challenge_flag_2.png")
        else
            self.bg:setSpriteName("ui_arena_challenge_flag_1.png")
            self.honorIcon:hide()
        end

        self.nickName:setText(nickName)
        self.guildName:setText("<"..guildName..">")

        self.combatScore:setText(tostring(combatScore))
        self.integralText:setText(tostring(integralNum))
        self.rankingText:setText(tostring(rankScore))

        self.lvText:setText(tostring(lv))

        if equipType == 0 then
            self.weaponIcon:hide()
        else
            self.weaponIcon:show()
            self.weaponIcon:setSpriteName("icon-equip_small1_21080010_" .. equipType .. ".png")
        end

        self:updateHeadView()

        -- 刷新挑战按钮
        if(fresh) then
            self.okBtn:setText(UI.TEXT_1172013)
            self.diamondIcon:hide()
            self.diamondCost:hide()
        else
            self.okBtn:setText("")
            local offset = 10
            local startX = - ( self.diamondIcon:getContentSize().width + self.diamondCost:getContentSize().width + offset)/2
            self.diamondIcon:centerLeft(startX)
            self.diamondCost:centerLeft(startX + self.diamondIcon:getContentSize().width + offset)
            self.diamondIcon:show()
            self.diamondCost:show()
        end
    end
end

function ArenaChallengeCellView:updateHeadView()
    -- Avalon.WidgetUtil:getHead(
    --     self,
    --     RoleDataManager:getHeroDataForPK(self._data:getPK()),
    --     _wearEquipmentDataArr,
    --     self,
    --     handler(
    --         self,
    --         function(self, pic)
    --             if self and not tolua.isnull(self) then
    --                 self._avatar_SP:setVisible(false)
    --                 self.rootLayer:removeChildByName("heorIcon", true)
    --                 pic:setPosition(42, 34)
    --                 pic:setName("heorIcon")
    --                 self.rootLayer:addChild(pic, -1)
    --                 self._heroIcon = pic

    --                 if self.viewState == 2 then
    --                     local shader = Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER)
    --                     if (shader) then
    --                         self._heroIcon:getChildByName("pic"):setGLProgramState(shader)
    --                     end
    --                 end
    --                 self._heroIcon:setScale(0.8)
    --             end
    --         end
    --     ),
    --     true
    -- )
end

function ArenaChallengeCellView:bindModel()

end


function ArenaChallengeCellView:unbindModel()

end


return ArenaChallengeCellView













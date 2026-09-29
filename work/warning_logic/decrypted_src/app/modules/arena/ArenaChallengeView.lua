------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/07/29
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ArenaChallengeView = class("ArenaChallengeView", UI.HWBtnComponent)

local ArenaChallengeCellView = require "app.modules.arena.ArenaChallengeCellView"

-- 资源
local COM_RES_LIST = {
    "ui_town_ranking.plist"
}

local COM_WIDTH = 978
local COM_HEIGHT = 555

function ArenaChallengeView:ctor()
    ArenaChallengeView.super.ctor(
    	self,
    	UI.Type.ARENA_CHALLENGE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    Net.NetPlaySystem:requestArenaData()
    self.enemyArr = {}
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

function ArenaChallengeView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.arena", "Arena", false)
    ArenaChallengeView.super.init(self, ... )
end

function ArenaChallengeView:dtor()
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    ArenaChallengeView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.arena.ArenaChallengeView")
end

function ArenaChallengeView:onInitView()
    -- self:enableDebugDraw()
    local bg2 = cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png")
    bg2:setContentSize(939, 531)
    bg2:setCapInsets(CCRectMake(304, 141, 1, 1))
    bg2:setPosition(cc.p(939 / 2 + 18, 531 / 2 + 11))
    self:addChild(bg2)
    self.contentLayout = bg2

    -- 上面标题区域
    self:createTitleContent()

    local splitLine = UI.Image9:create()
    splitLine:init(
        "ui_scale9image_banner_line_long.png",
        CCRectMake(20, 1, 1, 1),
        cc.size(909, 2)
    )
    splitLine:leftUp(19, 61)
    bg2:addChild(splitLine)

    -- 中间的数据
    self:createAllEnemy()

    -- 刷新按钮
    local btnBg = UI.Image:create()
    btnBg:init("ui_arena_challenge_refresh_box.png")
    btnBg:rightBottom(8, 12)
    bg2:addChild(btnBg)

    local btnRefresh = UI.Button:create()
    btnRefresh:init("ui_btn_refresh_0.png", "ui_btn_refresh_1.png", "ui_btn_refresh_2.png")
    btnRefresh:center()
    btnBg:addChild(btnRefresh)
    btnRefresh:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:refreshClick()
    end)
end

function ArenaChallengeView:updateView()
    self.integralText:setText(tostring(mvc.arenaModel:getScore()))
    -- self.arenaValue
    -- self.rankingText

    self:refreshEnemy()
end

function ArenaChallengeView:refreshEnemy()
    local enemyDataArr = mvc.arenaModel:getEnemyData()
    if(enemyDataArr) then
        for k,v in ipairs(self.enemyArr) do 
            if(enemyDataArr[k]) then 
                v:show()
                v:setData(enemyDataArr[k])
            else
                v:hide()
            end
        end
    end
end

function ArenaChallengeView:createAllEnemy()
    self.enemyArr = {}
    local spaceWidth = 175
    local startX = 41
    local startY = 40
    for i=1,5,1 do 
        local arenaChallengeCellView = ArenaChallengeCellView:create()
        arenaChallengeCellView:init()
        arenaChallengeCellView:leftBottom(startX + (i-1)*spaceWidth, startY)
        self.contentLayout:addChild(arenaChallengeCellView)
        table.insert(self.enemyArr, arenaChallengeCellView)
    end
end

function ArenaChallengeView:createTitleContent()
    -- 赛季剩余时间
    local text = UI.Text:create()
    text:init(
        UI.TEXT_1324404,
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        {r = 92, g = 13, b = 13}
    )
    text:centerUp(11)
    self.contentLayout:addChild(text)
    self.coolText = text

    -- 战绩信息
    local selfInfoLayout = UI.Layout:create()
    selfInfoLayout:init()
    selfInfoLayout:leftUp(32, 0)
    selfInfoLayout:setSize(279, 60)
    self.contentLayout:addChild(selfInfoLayout)
    -- selfInfoLayout:enableDebugDraw()

    local text = UI.Text:create()
    text:init(
        UI.TEXT_1324405,
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_41_41_45
    )
    text:leftBottom(12, 26)
    selfInfoLayout:addChild(text)

    local bg,text = self:createOneInfo("symbol_character_hero_integral.png", 123)
    bg:leftBottom(0, 0)
    selfInfoLayout:addChild(bg, 2)
    self.integralText = text

    local bg,text = self:createOneInfo("symbol_character_hero_rank.png", 456)
    bg:leftBottom(138, 0)
    selfInfoLayout:addChild(bg,2)
    self.rankingText = text

    -- 竞技场信息
    local icon = UI.Image:create()
    icon:init("symbol_gaming_arena.png")
    icon:rightUp(154, 18)
    self.contentLayout:addChild(icon, 2)

    local arenaValue = UI.Text:create()
    arenaValue:init(
        "",
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_227_214_172
    )
    arenaValue:centerLeft(33)
    icon:addChild(arenaValue, 2)
    self.arenaValue = arenaValue
end

function ArenaChallengeView:createOneInfo(iconName, num)
    num = num or 0
    local bg = UI.Image:create()
    bg:init("ui_arena_challenge_banner_1.png")
    -- bg:enableDebugDraw()
    
    --
    local icon = UI.Image:create()
    icon:init(iconName)
    icon:centerLeft(13)
    bg:addChild(icon, 2)

    local infoValue = UI.Text:create()
    infoValue:init(
        ""..tostring(num),
        UI.FONT_STANDARD,
        UI.FONT_SIZE_16PX,
        UI.FONT_COLOR_227_214_172
    )
    infoValue:center()
    infoValue:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
    bg:addChild(infoValue, 2)

    return bg,infoValue
end

function ArenaChallengeView:update(dt)
	if(self._totalTime == nil) then 
		self._totalTime = 0
	end
	if(self._totalTime > 60) then 
		self._totalTime = self._totalTime - 60
        -- TODO 处理时间处理
        self.coolText:setText(UI.TEXT_1324404.."dddd")
	end
end

function ArenaChallengeView:bindModel()

end

function ArenaChallengeView:unbindModel()

end

function ArenaChallengeView:refreshArenaData()
    self:updateView()
end

function ArenaChallengeView:refreshArenaEnemyData()
    
end

function ArenaChallengeView:refreshClick()

end


return ArenaChallengeView













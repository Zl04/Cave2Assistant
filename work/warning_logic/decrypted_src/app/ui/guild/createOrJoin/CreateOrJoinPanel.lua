-- CreateOrJoinPanel.lua
-- Author:zp
-- 2017年9月14日
-- Using:创建或加入公会

require("app.ui.guild.createOrJoin.GuildCell")
require("app.ui.guild.createOrJoin.CreateGuild")
require("app.ui.guild.createOrJoin.LoadingPanel")

require("app.ui.shieldingLayer.WaitingLayer")

local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}

local CreateOrJoinPanel = class("CreateOrJoinPanel", UI.DownShowWin)
UI.CreateOrJoinPanel = CreateOrJoinPanel

local winSize = cc.Director:getInstance():getWinSize()

local LAYOUT_DESIGN_WIDTH = 852   --974
local LAYOUT_DESIGN_HEIGHT = 591  --
-- 滑动阀值
local SCROLL_THRSHOLD = 10

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_guild_create.plist",
    "ui_town_guild_icon.plist",
    "ui_town_guild_general.plist",
}

--构造函数(必备)
function CreateOrJoinPanel:ctor()
	--窗口大小
    CreateOrJoinPanel.super.ctor(
    self,UIType.GUILD_CREATE_OR_JOIN,
    COM_RES_LIST,
    winSize.width,	
    winSize.height
    )
    
    self._isFirstReload = true
    self._preNum = 0
    self.guildListTableView = nil

    self.searchGuildList = MasterDataManager:getPreSearchGuildList()
    self.lastMaxGuildID =0
    self.bucketIdx = nil
    self.bucketDis = nil
    self._preNum = 0

    self._clickSearch = false

    self._searchEdit = nil
    self._scrollTime = -1
    self.requestTime = 0
    self:setInterceptTouches(true);
    self:setTouchEnable(true);    
    self:init();
    self:registerListener();
    Avalon.Scheduler:scheduleUpdate(self, self.refreshTime)
end

--虚构函数,destroy时调用(必备)
function CreateOrJoinPanel:dtor()
    CreateOrJoinPanel.super.dtor(self)
    self:unRegisterListener();
    Avalon.Scheduler:unscheduleUpdate(self, self.refreshTime)
    Avalon.Scheduler:unscheduleUpdateOnce(self, self.searchGuildTimeOut)
    self._isFirstReload = false
    self.loadingPanel = nil
end

-- 刷新时间
function CreateOrJoinPanel:refreshTime(dt)
    self._scrollTime = self._scrollTime - dt 
    if(self._scrollTime < 0) then 
        self._startOffsetY = nil
    end
end

-- 初始化(必备)
function CreateOrJoinPanel:init()
    if(GameManager:getNowServerTime() - MasterDataManager:getPreGuildSearchTime() >= REQUEST_CD_TIME) then
        self.searchGuildList = nil
    end

    CreateOrJoinPanel.super.init(self)

    self:searchGuild(true)
end


-- 模版函数：初始化组建的视图(必备)
function CreateOrJoinPanel:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_DESIGN_HEIGHT)
    contentLayout:center()
    -- contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 添加背景
    local bg = UI.Image:create()
    bg:init("ui_guild_create_banner_box.png")
    bg:center()
    self._contentLayout:addChild(bg)

    -- 标题头
    local bgTitle = UI.Image:create()
    bgTitle:init("ui_bg_banner_box_up.png")
    bgTitle:leftUp(974/2 - bgTitle:getContentSize().width/2 - 20,-45)
    bg:addChild(bgTitle,100)

    -- 搜索框输入框
    local searcheBG = UI.Image:create()
    searcheBG:init("ui_guild_create_banner_search.png")
    searcheBG:leftUp(95 + 23,47)
    bg:addChild(searcheBG)

    -- 输入文字框
    local searchEdit = cc.EditBox:create({width = 342, height = 19}, "placeholder.png")
    searchEdit:setFontSize(16)
    searchEdit:setPlaceHolder(LanguageManager:getInstance():getLocalString(1111478))
    -- searchEdit:setPlaceholderFontColor(UI.FONT_COLOR_255_247_225)
    searchEdit:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
    searchEdit:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)
    searchEdit:setFontColor(UI.FONT_COLOR_155_155_155)
    searchEdit:setPlaceholderFontSize(18)
    searchEdit:setPlaceholderFontColor(UI.FONT_COLOR_155_155_155)
    searchEdit:setPosition(17 + 342/2, 31)
    searchEdit:setMaxLength(9)
    searcheBG:addChild(searchEdit)

    searchEdit:registerScriptEditBoxHandler(function(eventname,sender) 
        self:editboxHandle(eventname,sender)
    end)

    self._searchEdit = searchEdit

    -- 搜索按钮
    local searchBtn  = UI.ButtonExt:create()
    searchBtn:extInit("ui_guild_icon_search_0.png", "ui_guild_icon_search_1.png")
    searchBtn:init("ui_guild_button_box_0.png",  "ui_guild_button_box_1.png")
    -- searchBtn:centerRight(76)
    searchBtn:centerRight(16)
    searcheBG:addChild(searchBtn)
    searchBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        -- 处理点击搜索按钮的相关逻辑处理
        self:searchGuild(nil, true)
    end)

    -- 创建按钮
    local createButton = UI.Button:create()
    createButton:init("ui_guild_button_start_0.png","ui_guild_button_start_1.png","ui_guild_button_start_2.png")
    createButton:centerLeft(530)
    createButton:addEventListener(UIEvent.BUTTON_CLICK,self,function(self)
        -- 处理点击创建公会
        self:createGuild()
    end)
    -- self._contentLayout:addChild(createButton)
    searcheBG:addChild(createButton)

    local createLabel = UI.Text:create()
    createLabel:init(LanguageManager:getInstance():getLocalString(1110517), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    -- createLabel:centerUp(6)
    createLabel:center()
    createButton:addChild(createLabel, 10)

    local master = GameDataManager:getInstance():getMaster()
    if(master and master:getLevel() < ConfigManager:getCreateGuildMinLevel()) then 
        createLabel:centerUp(6)

        -- 解锁提示
        local unlockLabel = UI.Text:create()
        unlockLabel:init(string.format(UI.TEXT_1172016, ConfigManager:getCreateGuildMinLevel()), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_80_5_5)
        unlockLabel:centerBottom(5)
        createButton:addChild(unlockLabel, 10)
    end

    -- 下面部分背景
    local bottomBg = UI.Image:create()
    bottomBg:init("ui_guild_create_paper1.png")
    bottomBg:leftBottom(89,25)
    bg:addChild(bottomBg)

    -- 公会列表标题栏
    local listTitleImage = UI.Layout:create()
    listTitleImage:init()
    listTitleImage:setSize(771, 43)
    listTitleImage:centerUp(0)
    bottomBg:addChild(listTitleImage)

    -- -- 图标名
    -- local iconName = UI.Text:create()
    -- iconName:init(LanguageManager:getInstance():getLocalString(1110518), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    -- iconName:setTextHorizontalCenter()
    -- iconName:setSize(0, 0)
    -- iconName:centerLeft(56)
    -- listTitleImage:addChild(iconName, 10)

    -- 公会，会长名字
    local guildName = UI.Text:create()
    guildName:init(LanguageManager:getInstance():getLocalString(1110519), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    guildName:setTextHorizontalCenter()
    guildName:setSize(0, 0)
    guildName:centerLeft(174)
    listTitleImage:addChild(guildName, 10)

    -- 公会等级
    local levelText = UI.Text:create()
    levelText:init(LanguageManager:getInstance():getLocalString(1110520), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    levelText:setTextHorizontalCenter()
    levelText:setSize(0, 0)
    levelText:centerLeft(324)
    listTitleImage:addChild(levelText, 10)

    -- 公会人数
    local curNumText = UI.Text:create()
    curNumText:init(LanguageManager:getInstance():getLocalString(1110521), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    curNumText:setTextHorizontalCenter()
    curNumText:setSize(0, 0)
    curNumText:centerLeft(421)
    listTitleImage:addChild(curNumText, 10)


    -- 入会要求
    local joinLimitText = UI.Text:create()
    joinLimitText:init(LanguageManager:getInstance():getLocalString(1110522), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    joinLimitText:setTextHorizontalCenter()
    joinLimitText:setSize(0, 0)
    joinLimitText:centerLeft(548)
    listTitleImage:addChild(joinLimitText, 10)

    -- 状态
    local statusText = UI.Text:create()
    statusText:init(LanguageManager:getInstance():getLocalString(1110523), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    statusText:setTextHorizontalCenter()
    statusText:setSize(0, 0)
    statusText:centerLeft(688)
    listTitleImage:addChild(statusText, 10)

    -- 上面分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    lineUpImage:setContentSize(753, 1)
    lineUpImage:setCapInsets(CCRectMake(19,0,1,1))
    lineUpImage:setPosition(cc.p(387,  444 - 45))
    bottomBg:addChild(lineUpImage, 4)


    -- 公会列表
    -- self.guildListTableView = cc.TableView:create(cc.size(750,394))
    self.guildListTableView = cc.TableView:create(cc.size(748 + 10,394 - 4))
    self.guildListTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.guildListTableView:setPosition(cc.p(16, 5 +2))
    self.guildListTableView:setDelegate()
    self.guildListTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    bottomBg:addChild(self.guildListTableView)
    self.guildListTableView:registerScriptHandler(handler(self,self.numberOfCellsInTableView),cc.NUMBER_OF_CELLS_IN_TABLEVIEW)  
    self.guildListTableView:registerScriptHandler(handler(self,self.scrollViewDidScroll),cc.SCROLLVIEW_SCRIPT_SCROLL)
    self.guildListTableView:registerScriptHandler(handler(self,self.scrollViewDidZoom),cc.SCROLLVIEW_SCRIPT_ZOOM)
    self.guildListTableView:registerScriptHandler(handler(self,self.tableCellTouched),cc.TABLECELL_TOUCHED)
    self.guildListTableView:registerScriptHandler(handler(self,self.cellSizeForTable),cc.TABLECELL_SIZE_FOR_INDEX)
    self.guildListTableView:registerScriptHandler(handler(self,self.tableCellAtIndex),cc.TABLECELL_SIZE_AT_INDEX)
    self.guildListTableView:initScrollBar()
    self.guildListTableView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    self.guildListTableView:reloadData(true, 0.18, Game.TableCellInitTime, Game.TableCellAddTime)

    -- 公会列表为nill 的表现文字
    local noGuildText = UI.Text:create()
    noGuildText:init(LanguageManager:getInstance():getLocalString(1110529), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- noGuildText:centerBottom(220)
    noGuildText:center()
    noGuildText:setTextHorizontalCenter()
    -- noGuildText:setSize(0, 0)
    bottomBg:addChild(noGuildText,1000)
    self._noGuildLabel = noGuildText
    self._noGuildLabel:setVisible(false)

    self._contentLayout:setInterceptTouches(true)
    self._contentLayout:setTouchEnable(true)
    self._contentLayout:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        -- print("CreateOrJoinPanel:onInitView self._contentLayout COMPONENT_TOUCH_OUTSIDE")

        self:exitCreatePanel()
    end)

    -- 下面的遮罩
    local mashImage = UI.Image:create()
    mashImage:init("ui_guild_create_banner_box_mask.png")
    mashImage:centerBottom(0)
    bottomBg:addChild(mashImage, 4)

    -- 加载动画效果
    local loadingPanel = UI.WaitingLayer:createLittleWaitingWithSize(cc.size(780,345), self._contentLayout)
    loadingPanel:centerBottom(50)

    -- local loadingPanel = UI.LoadingPanel:create()
    -- loadingPanel:centerBottom(187+60)
    -- self._contentLayout:addChild(loadingPanel, 100)
    self._loading = loadingPanel
    self._loading:setVisible(false)

    -- 放大出现
    -- self:setScale(0.1)
    -- self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1)))
end

-- 模版函数：更新组建的视图(必备)
function CreateOrJoinPanel:onUpdateView()
    
end

function CreateOrJoinPanel:exitCreatePanel()
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER,function()
    end)
    Avalon.Scheduler:unscheduleUpdateOnce(self, self.searchGuildTimeOut)
    -- self:close()
    self:closeWin()
    -- self.guildListTableView:setVisible(false)
    -- self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
end

function CreateOrJoinPanel:editboxHandle(strEventName, sender)
    -- print("CreateOrJoinPanel:editboxHandle", strEventName, sender)
    local guildNameMaxNum = 7

    if(strEventName == "began") then

    elseif (strEventName == "ended") then

    elseif (strEventName == "return") then
        local message = self._searchEdit:getText() or ""
        message = string.trim(message)
        -- print("CreateGuild:editboxHandle  0", message, type(message))
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
        end

        -- print("CreateGuild:editboxHandle  1", message, AvalonUtil.utf8len(message))
        if AvalonUtil:isUpLimiteStr(message, 160, 22) then
            -- message = string.sub(message, 1, 7)
            message = AvalonUtil:getSubNameStrByLabel(message, 160, 22)
        end

        if(message ~= "") then 
            local guildNum = tonumber(message)
            if(guildNum == nil or guildNum <= 0 or guildNum%1 ~= 0) then 
                message = ""
                UI.ScrollBar:createByText(UI.TEXT_1170415)
            else 
                message = tostring(tonumber(message))
            end
        end

        self._searchEdit:setText(message)
        self._searchEdit:setPlaceHolder(LanguageManager:getInstance():getLocalString(1111478))
    elseif (strEventName == "changed") then
        local message = self._searchEdit:getText() or ""
        message = string.gsub(message, " ", "")
        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
            self._searchEdit:setText(message)
            AvalonUtil.closeKeyBoard(self._searchEdit)
            return
        end

        local isHave = string.find(message, "\n")
        if isHave ~= nil then
            message = string.gsub(message, "\n", "")
            self._searchEdit:setText(message)
            AvalonUtil.closeKeyBoard(self._searchEdit)
            return
        end

        if AvalonUtil:isUpLimiteStr(message, 160, 22) then
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110609))
            AvalonUtil.closeKeyBoard(self._searchEdit)
        end
        
    end
end

function CreateOrJoinPanel:searchGuild(isInitLoad, isClickButton)
    if(isInitLoad == nil or isInitLoad == false) then
        self._clickSearch = true
    end

    if(GameManager:getNowServerTime() - MasterDataManager:getPreGuildSearchTime() >= REQUEST_CD_TIME) then
        MasterDataManager:setPreGuildSearchTime(GameManager:getNowServerTime())

        local master = RoleDataManager:getMaster()
        local equipScore = master:getCombatScore()

        local keyWord = self._searchEdit:getText()
        if(self._inSearch and isClickButton ~= true) then 
            return 
        end
        local searchGuildID = 0

        if(isClickButton) then
            if(keyWord ~= "") then 
                searchGuildID = tonumber(keyWord)
            end
            if(searchGuildID <= 0) then 
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111478))
                return 
            end

            if(keyWord ~= "") then 
                self._inSearch = true
            else 
                self._inSearch = false
            end
        end
        
        self._loading:delayShow(GAME_NET_DELAY_LIST)
        Avalon.Scheduler:scheduleUpdateOnce(self, self.searchGuildTimeOut, 10)

        -- 请求默认推荐公会
        self.requestTime = AvalonUtil.getCurrentTime()                  
        Net.NetGuildSystem:reqGuildList(searchGuildID, equipScore, nil, self.lastMaxGuildID, self.bucketIdx, self.bucketDis)
    else
        if(self._inSearch and isClickButton ~= true) then 
            return 
        end

        if(isInitLoad ~= true) then 
            -- "搜索太频繁了，请稍后再试"
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110685))
        end
    end
end

function CreateOrJoinPanel:searchGuildTimeOut()
    -- 处理间隔时间
    if(self and self._loading) then
        self._loading:setVisible(false)
        Avalon.Scheduler:unscheduleUpdateOnce(self, self.searchGuildTimeOut)
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110701))
    end
end

function CreateOrJoinPanel:guildResponseError()
    if(self._loading) then
        self._loading:setVisible(false)
    end
end

function CreateOrJoinPanel:guildResponse(data)
    -- print("CreateOrJoinPanel:guildResponse")
    local guildList = data.guilds

    self._loading:setVisible(false)
    Avalon.Scheduler:unscheduleUpdateOnce(self, self.searchGuildTimeOut)

    self.bucketIdx = data.bucketIdx
    self.bucketDis = data.bucketDis

    if(self._clickSearch) then
        if(self._inSearch) then 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111479))
        else 
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111013))
            self._clickSearch = false
        end 
    end

    -- dump(guildList)

    -- TODO 处理公会的排序以及刷新显示
    if(guildList == nil or #guildList == 0) then
        self.searchGuildList = {}

        self._noGuildLabel:setVisible(true)
    else
        self.searchGuildList = guildList
        MasterDataManager:setPreSearchGuildList(self.searchGuildList)
        self.lastMaxGuildID = self.searchGuildList[#self.searchGuildList].ID
        local heroEquipScore = GameDataManager:getInstance():getMaster():getCombatScore()
        -- 排序
        table.sort(self.searchGuildList, function(a, b)
            -- print("dddddddddddddd", a.techTotalLv, a.curMemberNum, a.joinEquipScoreLmt)
            -- 判断人数是否够
            local aNum = tonumber(GameDataManager:getInstance():getGuildMemberConfigForLevel(a.techTotalLv))
            local bNum = tonumber(GameDataManager:getInstance():getGuildMemberConfigForLevel(b.techTotalLv))
            

            local aEnough = 0
            local bEnough = 0
            if(aNum > a.curMemberNum) then
                aEnough = 1
            end
            if(bNum >= b.curMemberNum) then
                bEnough = 1
            end
            if(aEnough ~= bEnough) then
                if(aEnough > bEnough) then
                    return true
                else
                    return false
                end
            end

            -- 判断积分是否够
            local aEqui = 0
            local bEqui = 0
            if(GameDataManager:getInstance():getGuildEquipScoreForLmt(a.joinEquipScoreLmt) <= heroEquipScore) then
                aEqui = 1
            end
            if(GameDataManager:getInstance():getGuildEquipScoreForLmt(b.joinEquipScoreLmt) <= heroEquipScore) then
                bEqui = 1
            end

            if(aEqui ~= bEqui) then
                if(aEqui > bEqui) then
                    return true
                else
                    return false
                end
            end

            -- print("dddddddddddddd", aEnough, bEnough, aEqui, bEqui)

            if(a.ID > b.ID) then
                return true
            end
            
            return false
        end)

        self._noGuildLabel:setVisible(false)

        local guildEquipScoreConfig =  string.split(ConfigManager:getGuildEquipScore(), ";")
        for k,v in pairs(guildEquipScoreConfig) do 
            guildEquipScoreConfig[k] = tonumber(v)
        end
    end
    if self._isFirstReload then
        local actTime = (AvalonUtil.getCurrentTime() - self.requestTime) / 1000
        actTime = 0.18 - actTime
        actTime = actTime < 0 and 0 or actTime
        print("------actTime------"..actTime)
        self.guildListTableView:reloadData(true, actTime, Game.TableCellInitTime, Game.TableCellAddTime)
        self._isFirstReload = false
    else
        self.guildListTableView:reloadData(false)
    end
end

function CreateOrJoinPanel:joinSuccess()
    self:exitCreatePanel()
    -- 弹出入会成功的表现
    UI.TipsLayer:joinGuildSuccess()
end

function CreateOrJoinPanel:closeAllCreateOrJoinGuild()
    self:exitCreatePanel()
end

function CreateOrJoinPanel:refreshGuildCell()
    self.guildListTableView:reloadData()
end

-- 注册监听事件(可选)
function CreateOrJoinPanel:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_GUILD_LIST, self, self.guildResponse)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_GUILD_LIST_ERROR, self, self.guildResponseError)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_JOIN_SUCCESS, self, self.joinSuccess)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CLOSE_ALL_CREATE_OR_JOIN_GUILD, self, self.closeAllCreateOrJoinGuild)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_GUILD_APPLY_RESUME, self, self.refreshGuildCell)
    
end

-- 注销监听事件(可选)
function CreateOrJoinPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_GUILD_LIST, self, self.guildResponse)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_GUILD_LIST_ERROR, self, self.guildResponseError)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_JOIN_SUCCESS, self, self.joinSuccess)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CLOSE_ALL_CREATE_OR_JOIN_GUILD, self, self.closeAllCreateOrJoinGuild)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_GUILD_APPLY_RESUME, self, self.refreshGuildCell)
end

function CreateOrJoinPanel:createGuild()
    local master = GameDataManager:getInstance():getMaster()
    if(master:getLevel() >= ConfigManager:getCreateGuildMinLevel()) then 
        local createGuid = UI.CreateGuild:create()
        createGuid:center()
        self:addChild(createGuid, 10000)
    else 
        -- 
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170179))
        -- UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1170179) ,UI.TipsType.CONFIRM,UI.TipsUiType.NORMAL)
    end
end

function CreateOrJoinPanel:numberOfCellsInTableView(table)
    if(self.searchGuildList) then
        return #self.searchGuildList
    else
        return 0
    end
end


function CreateOrJoinPanel:scrollViewDidScroll(view)
    local offsetY = view:getContentOffset().y
    -- if offsetY > 0 then
    --     offsetY = 0;
    -- end

    if(self._startOffsetY == nil) then
        self._startOffsetY = offsetY
        self._searchDown = false
        self._searchUp = false
    end

    self._scrollTime = 0.5

    local viewHeight = view:getViewSize().height;
    local height = view:getContentSize().height;

    if(height < viewHeight) then
        -- 列表数据消息显示框
        if(offsetY + height > viewHeight +50) then
            self._searchUp = true
        end

        if( offsetY < viewHeight - height -50) then
            self._searchDown = true
        end
    else
        if(offsetY >50) then
            self._searchUp = true
        end

        if(offsetY < viewHeight - height - 50) then 
            self._searchDown = true
        end 
    end

    if(self._searchUp and (offsetY == 0 or offsetY == viewHeight-height)) then
        if(self._startOffsetY and self._startOffsetY + SCROLL_THRSHOLD  >= 0) then
            self._searchUp = false
            -- print("CreateOrJoinPanel:scrollViewDidScroll _searchUp",self._searchUp, offsetY, viewHeight, height)
            self:searchGuild()
        end
        self._startOffsetY = nil
    end

    if(self._searchDown and ((offsetY + height == viewHeight) or (offsetY + viewHeight == height))) then
        if(self._startOffsetY and self._startOffsetY <= viewHeight - height + SCROLL_THRSHOLD) then
            self._searchDown = false
            -- print("CreateOrJoinPanel:scrollViewDidScroll _searchDown",self._searchDown, offsetY, viewHeight, height)
            self:searchGuild()
        end
        self._startOffsetY = nil
    end


    -- print("CreateOrJoinPanel:scrollViewDidScroll",self._searchNew, offsetY, viewHeight, height)
    -- if(self._searchNew and (offsetY == 0 or offsetY == height - viewHeight ) ) then
    --     self._searchNew = false
    --     self:searchGuild()
    -- end

    

    -- local t = (offsetY - viewHeight)/(height)
    -- if(t < -1) then
    --     t = -1;
    -- elseif t > 0 then
    --     t = 0
    -- end
    -- t = 1 + t
    -- local _t1 = t * #self.monsterList
    -- local _h = 0

    -- for i = 1,#self.data1 do
    --     if _t1 < self.data1[i] + 1 then
    --         if i == #self.data1 then
    --             _h = _h + (1+offsetY/((self.data1[i] + 1)*height/#self.monsterList - viewHeight)) * self._barHeight/#self.data1
    --         else
    --             _h = _h + 1.0 * _t1/(self.data1[i] + 1)*(1.0 * self._barHeight / #self.data1)
    --         end
    --         break
    --     else
    --         _t1 = _t1 - self.data1[i] - 1
    --         _h = _h + 1.0 * self._barHeight/#self.data1
    --     end
    -- end
    -- self.pArchiveProBar:updateNowBar(self._barHeight - _h)
end

function CreateOrJoinPanel:scrollViewDidZoom(view)
    -- print("CreateOrJoinPanel:scrollViewDidZoom")
end

function CreateOrJoinPanel:tableCellTouched(table,cell)
    -- print("CreateOrJoinPanel:tableCellTouched",cell:getIdx())
    -- local index = cell:getIdx()
    -- if self.monsterList[index + 1] then
    --     if self.monsterList[index + 1].type == 2 then
    --         if self.monsterList[index + 1].state == 1 then
    --             if self._selectMonster ~= index then
    --                 if self._selectMonster ~= -1 then
    --                     self.monsterList[self._selectMonster + 1].select = false
    --                     table:updateCellAtIndex(self._selectMonster)
    --                 end
    --                 self.monsterList[index + 1].select = true
    --                 table:updateCellAtIndex(index)
    --                 self._selectMonster = index
    --                 self:updataDifficultyBtn(1)
    --             end
    --         end
    --     end
    -- end
end

function CreateOrJoinPanel:cellSizeForTable(table,idx)
    return 748,89
end

function CreateOrJoinPanel:tableCellAtIndex(tableView,idx)
    -- print("CreateOrJoinPanel:tableCellAtIndex",idx)
    local cell = tableView:dequeueCell()
    xpcall(function()
        if nil == cell then
            cell = cc.TableViewCell:new()
            local pArchiveCell = UI.GuildCell:create(self.searchGuildList[idx + 1],idx)
            pArchiveCell:setName("cell")
            -- pArchiveCell:leftUp(374, -45)
            pArchiveCell:leftUp(374, -45)
            -- pArchiveCell:leftUp(0, 0)
            cell:addChild(pArchiveCell)
        else
            local obj = cell:getChildByName("cell");
            obj:reload(self.searchGuildList[idx + 1],idx)
        end
    end, 
    function(e) 
        printError("--------------------CreateOrJoinPanel:tableCellAtIndex---------------------error")
    end, 1) 
    return cell;
end

function CreateOrJoinPanel:openShow()
    self:open()
end
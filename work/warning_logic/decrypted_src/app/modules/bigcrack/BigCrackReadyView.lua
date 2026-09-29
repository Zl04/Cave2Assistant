------------------------------------------------------------------------------
--author: hongjian.yang
--date	: 2019/11/01
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigCrackReadyView = class("BigCrackReadyView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_bigcrack.plist",
}

local COM_WIDTH = 852
local COM_HEIGHT = 534
local List = Avalon.List

function BigCrackReadyView:ctor()
    BigCrackReadyView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self:center()
    self.renderQueue = List:create();
    Avalon.Scheduler:scheduleUpdate(self, self.update)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.canelMatch)
end

function BigCrackReadyView:canelMatch()
    mvc.closePanel("BigCrack", "BigCrackReady")
end

function BigCrackReadyView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigcrack", "BigCrack", false)
    BigCrackReadyView.super.init(self, ... )
end

function BigCrackReadyView:dtor()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TEAM_NOTIFY_CANCEL_MATCH, self, self.canelMatch)
    BigCrackReadyView.super.dtor(self)
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
    self.renderQueue:destroy()
    self:unbindModel()
    reload_script_file_mvc("app.modules.bigcrack.BigCrackReadyView")
end


function BigCrackReadyView:onInitView()
    
    local eff = UI.Animation:create()
    eff:init("effect_ui_town_bigcrack_login.json", "effect_ui_town_bigcrack_login.atlas", 1);
    eff:center()
    eff:setName("GiftEff")
    self:addChild(eff)
    eff:setAnimation("begin", false)
    eff:addAnimation("idle", true)

    self.eff = eff
    self:createHeads()

    local title = UI.Text:create()
    title:init(UI.TEXT_1213434, UI.FONT_STANDARD, UI.FONT_SIZE_28PX, {r = 249, g = 226, b = 151})
    title:center()
    title:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(2, -2))
    self.eff:addComponent("box-login", title)


    -- local img = UI.Image:create()
    -- img:init("")
    
    -- self.eff:addComponent("box-center", img)

    local okBtn = UI.Button:create()
    okBtn:init("ui_btn_yellow12_0.png", "ui_btn_yellow12_1.png", "ui_btn_yellow12_2.png")
    okBtn:centerBottom(0)
    okBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onOk)
    okBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    okBtn:setText(UI.TEXT_1213433)
    self:addChild(okBtn)
    self.prepareBtn = okBtn
    local cdText = UI.Text:create()
    cdText:init("", UI.SYS_FONT, UI.FONT_SIZE_16PX, UI.FONT_COLOR_208_50_60)
    cdText:centerBottom(55)
    self:addChild(cdText)
    self.remind = 25
    self.cdText = cdText
    self:scheduleUpdateTime()
end


-- 每帧截屏3个
function BigCrackReadyView:update(dt)
    if self.renderQueue == nil then
        return
    end

    local limite = 3
    local size = self.renderQueue:size()
    size = size > limite and limite or size
    if size > 0 then
        for i = 1, size do
            local renderCMD = self.renderQueue:pop_front();
            if renderCMD then 
                renderCMD.execute()
            end
        end
    end
end


--获取头像
function BigCrackReadyView:getHead(sex, faceDecodeID, callfunc, clipImgName)
    local heroData = Data.HeroData:create()
    heroData:setNickName("")
    heroData:setLevel(0)
    heroData:setSex(sex or PublicDefine.HERO_SEX.MALE)
    heroData:setFaceDecodeID(faceDecodeID)

    local command = {
        execute = function ( ... )
            self:exportHead(heroData, callfunc, clipImgName);
        end,
        isExecute = false,
    }
    self.renderQueue:push_back(command)
end

function BigCrackReadyView:exportHead(headData, callfunc, clipImgName)
    Avalon.WidgetUtil:getHead(self, headData ,{}, self, handler(self,function(self,pic)
        if self and not tolua.isnull(self) then
            callfunc(pic, headData.faceDecodeID)
        end
    end),true,clipImgName)
end


function BigCrackReadyView:scheduleUpdateTime()
    if tolua.isnull(self) or tolua.isnull(self.cdText) then
        return
    end

    if self.remind > 0 then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleUpdateTime, 1)
        local showText = AvalonUtil:_getFullFormatTime(self.remind, true, true, false)
        self.cdText:setText(string.format(UI.TEXT_1212635, showText))
    else
        self.cdText:setText("")
        self:onCancel()
        return
    end
    self.remind = self.remind - 1
end

function BigCrackReadyView:onCancel()

end

function BigCrackReadyView:onOk()
    -- for pk, _ in pairs(self.headNodes) do
    --     self:confirm(pk)
    -- end

    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
    Net.NetActivitySystem:requestSureMacth()
end

function BigCrackReadyView:createOneHead(isLeft, sex, faceDecodeId, isConfirm)
    local bg = UI.Image:create()
    local zhe = UI.Image:create()
    local clipImgName = "ui_bigcrack_red2.png"
    if isLeft then
        bg:init("ui_bigcrack_red1.png")
        zhe:init("ui_bigcrack_red1.png")
        clipImgName = "ui_bigcrack_red2.png"
    else
        bg:init("ui_bigcrack_blue1.png")
        zhe:init("ui_bigcrack_blue1.png")
        clipImgName = "ui_bigcrack_blue2.png"
    end
    if sex and faceDecodeId then
        self:getHead(sex, faceDecodeId, function (pic) 
            pic:setPosition(cc.p(42, 41))
            bg:addChild(pic,1)
        end, clipImgName)
    end
    bg:addChild(zhe, 100)
    return bg, zhe
end

function BigCrackReadyView:confirm(pk)
    local head = self.headNodes[pk]

    if head then
        local camp = head.camp
        local animationName = head.camp == 1 and "blue" or "red"
        if head.effect then
            head.effect:removeFromParent()
        end
        if head.zheImg then
            head.zheImg:removeFromParent()
            head.zheImg = nil
        end
        

        local eff = UI.Animation:create()
        eff:init("effect_ui_town_bigcrack_login_light.json", "effect_ui_town_bigcrack_login_light.atlas", 1);
        eff:center()
        eff:setAnimation(animationName, true)
        head:addChild(eff,100)
        head.effect = eff
    end

end

function BigCrackReadyView:createHeads()
    local roomData = mvc.festivalModel:getCurJoinData()
    local members = roomData.members or {}
    local camp = {}
    local myCamp
    local selfPk = RoleDataManager:getMasterPK()
    for i = 1, #members do
        local campId = members[i].campID
        local pk = members[i].pk
        camp[campId] = camp[campId] or {}
        camp[campId][pk] = {sex = members[i].sex, faceDecodeID=  members[i].faceDecodeID, isConfirm = false}
        if pk == selfPk then
            myCamp = campId
        end
    end

    if myCamp then
        local img = UI.Image:create()
        img:init("monster"..myCamp..".png")
        img:center()
        self.eff:addComponent("box-center", img)
    end

    self.headNodes = {}

    local idx = 1
    for pk, info in pairs(camp[PublicDefine.Camp.Blue] or {}) do
        local com = UI.Component:create()
        com:init()
        com:setSize(10,10)
        com.camp = PublicDefine.Camp.Blue
        self.headNodes[pk] = com
        local head,zheImg = self:createOneHead(false, info.sex, info.faceDecodeID, info.isConfirm)
        com.zheImg = zheImg
        head:center()
        com:addChild(head)
        self.eff:addComponent("box-blue-0"..idx, com)
        idx = idx + 1
    end
    idx = 1
    for pk, info in pairs(camp[PublicDefine.Camp.Red] or {}) do
        local com = UI.Component:create()
        com:init()
        com.camp = PublicDefine.Camp.Red
        com:setSize(10,10)
        self.headNodes[pk] = com

        local head, zheImg = self:createOneHead(true, info.sex, info.faceDecodeID, info.isConfirm)
        com.zheImg = zheImg
        head:center()
        com:addChild(head)
        self.eff:addComponent("box-red-0"..idx, com)
        idx = idx + 1
    end
end

function BigCrackReadyView:onSureMatchResp(result, pk)
    local selfPk = RoleDataManager:getMasterPK()
    if selfPk == pk then
        self.prepareBtn:setText(UI.TEXT_1213024)
        self.prepareBtn:disable()
    end

    self:confirm(pk)
end


function BigCrackReadyView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, self, self.onSureMatchResp)
end


function BigCrackReadyView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE, self, self.onSureMatchResp)
end





return BigCrackReadyView













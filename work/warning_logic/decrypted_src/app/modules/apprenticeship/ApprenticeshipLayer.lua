--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-07-30 16:07:46
]]
-- 师徒按钮栏

UI = UI or {}
local ApprenticeshipLayer = class("ApprenticeshipLayer", UI.HWBtnComponent)
UI.ApprenticeshipLayer = ApprenticeshipLayer

local COM_RES_LIST = {
    "ui_mentor.plist",
}

local COMPONENT_WIDTH = 0
local COMPONENT_HEIGHT = 0
local unlockType = PublicDefine.UnlockFunctionType 

function ApprenticeshipLayer:update()
    self:updateInteractButton()
end

function ApprenticeshipLayer:ctor()
    print("ApprenticeshipLayer:ctor")
    ApprenticeshipLayer.super.ctor(
        self, nil,
        COM_RES_LIST,
        COMPONENT_WIDTH,
        COMPONENT_HEIGHT
    )

    self.schedulerID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.update), 1, false)
end

-- 析构
function ApprenticeshipLayer:dtor()
    ApprenticeshipLayer.super.dtor(self)
    self:unRegisterListener()

    if self.schedulerID ~= nil then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

-- 初始化
function ApprenticeshipLayer:init()
    -- self:enableDebugDraw()
    ApprenticeshipLayer.super.init(self)
    self:registerListener()
end

-- 模版函数：初始化组建的视图
function ApprenticeshipLayer:onInitView()
    -- 师徒按钮布局
    self._buttonLayout = UI.Layout:create()
    self._buttonLayout:init(0, 0, 0, 0) --leftPadding, rightPaddind, upPadding, bottomPadding
    self._buttonLayout:centerBottom(-4)
    self._buttonLayout:enableAutoWidth()
    self._buttonLayout:enableAutoHeight()
    self:addChild(self._buttonLayout)

    -- 学徒1头像锚点
    self._appAnchor1 = UI.Component:create()
    self._appAnchor1:init()
    self._appAnchor1:setSize(50, 50)
    self._appAnchor1:floatBottom(10)
    self._buttonLayout:addComponent(self._appAnchor1)
    self._appAnchor1:setTouchEnable(true)
    self._appAnchor1:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        mvc.openPanel("Apprenticeship", "ApprenticeshipMentor", 1)
    end)
    -- 学徒1红点
    self._app1Redpoint = AvalonUtil.createRedPoint(self._appAnchor1, 2.5, 1.5)

    -- 导师学徒2获得赞奖励按钮
    self._app1KarmaBtn = UI.Button:create()
    self._app1KarmaBtn:init("ui_mentor_icon_good_0.png", "ui_mentor_icon_good_1.png", "ui_mentor_icon_good_0.png")
    self._app1KarmaBtn:leftUp(-6, -10)
    self._app1KarmaBtn:hide()
    self._app1KarmaBtn:setEnableMinTouchSize(false)
    self._appAnchor1:addChild(self._app1KarmaBtn, 10)
    self._app1KarmaBtn:setInterval(1)
    self._app1KarmaBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.send(mvc.events.Mentor_Tutor_Interact_Message, 1)
    end)

    -- 学徒2头像锚点
    self._appAnchor2 = UI.Component:create()
    self._appAnchor2:init()
    self._appAnchor2:setSize(50, 50)
    self._appAnchor2:floatBottom(10)
    self._buttonLayout:addComponent(self._appAnchor2)
    self._appAnchor2:setTouchEnable(true)
    self._appAnchor2:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        mvc.openPanel("Apprenticeship", "ApprenticeshipMentor", 2)
    end)
    -- 学徒2红点
    self._app2Redpoint = AvalonUtil.createRedPoint(self._appAnchor2, 2.5, 1.5)

    -- 导师学徒2获得赞奖励按钮
    self._app2KarmaBtn = UI.Button:create()
    self._app2KarmaBtn:init("ui_mentor_icon_good_0.png", "ui_mentor_icon_good_1.png", "ui_mentor_icon_good_0.png")
    self._app2KarmaBtn:leftUp(-6, -10)
    self._app2KarmaBtn:hide()
    self._app2KarmaBtn:setEnableMinTouchSize(false)
    self._appAnchor2:addChild(self._app2KarmaBtn, 10)
    self._app2KarmaBtn:setInterval(1)
    self._app2KarmaBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        mvc.send(mvc.events.Mentor_Tutor_Interact_Message, 2)
    end)

    -- 导师头像锚点
    self._mentorAnchor = UI.Component:create()
    self._mentorAnchor:init()
    self._mentorAnchor:setSize(50, 50)
    self._mentorAnchor:floatBottom(10)
    self._buttonLayout:addComponent(self._mentorAnchor)
    self._mentorAnchor:setTouchEnable(true)
    self._mentorAnchor:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        mvc.openPanel("Apprenticeship", "ApprenticeshipApprentice")
    end)

    -- 导师头像红点
    self._mentorRedpoint = AvalonUtil.createRedPoint(self._mentorAnchor, 2.5, 1.5)

    -- 入口按钮
    self._mainButton = UI.Button:create()
    self._mainButton:init("ui_main_button_mentor_0.png", "ui_main_button_mentor_1.png", "ui_main_button_mentor_0.png")
    self._mainButton:floatBottom(4)
    self._mainButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if (mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist()) then
            mvc.openPanel("Apprenticeship", "ApprenticeshipApprenticeGraduate")
        elseif (mvc.apprenticeshipModel:isMentorReqMet()) then
            mvc.openPanel("Apprenticeship", "ApprenticeshipReceive")
        elseif (mvc.apprenticeshipModel:isApprenticeReqMet()) then
            mvc.openPanel("Apprenticeship", "ApprenticeshipApply")
        end
    end)
    self._buttonLayout:addComponent(self._mainButton)
    -- 入口按钮红点
    self._mainRedpoint = AvalonUtil.createRedPoint(self._mainButton, 2.5, 1.5)
end

-- 模版函数：更新组建的视图
function ApprenticeshipLayer:onUpdateView()
    if(tolua.isnull(self)) then
        return
    end
    self:updateShowView()
    self:updateHeads()

    -- 更新宿主
    self._buttonLayout:updateView()
    local w, h = self._buttonLayout:getSize()
    self:setSize(64, h)
end

-- 更新头像显示
function ApprenticeshipLayer:updateHeads()
    -- 准备数据和界面锚点
    local viewArr = {}
    local dataArr = {}
    local mentor = mvc.apprenticeshipModel:getMentor()
    if (mentor) then 
        table.insert(viewArr, self._mentorAnchor)
        table.insert(dataArr, mentor) 
    end
    local apprenticeViewArr = {self._appAnchor1, self._appAnchor2}
    local appArr = mvc.apprenticeshipModel:getApprenticeArr() or {}
    for i,v in ipairs(appArr) do
        table.insert(dataArr, v)
        table.insert(viewArr, apprenticeViewArr[i])
    end

    -- 通过数据生成头像, 放入锚点
    for i,data in ipairs(dataArr) do
        local view = viewArr[i]
        if (not view) then break end

        if (data.sex and data.faceDecodeID) then
            view:removeChildByName("headWrapper")
        
            -- 用一个包裹节点来确保快速刷新时不会错位
            local headWrapper = UI.Component:create()
            headWrapper:init()
            headWrapper:setName("headWrapper")
            headWrapper:setScale(0.6)
            headWrapper:center()
            view:addChild(headWrapper)

            local bg = UI.Image:create()
            bg:init("ui_information_headframe_bottom.png")
            bg:center()
            headWrapper:addChild(bg, 1)

            -- 放入遮罩
            local frame = UI.Image:create()
            frame:init("ui_information_headframe_box2.png")
            frame:center()
            headWrapper:addChild(frame, 5)
    
            -- 异步生成头像
            Avalon.WidgetUtil:getHeadByData(self, data.sex, data.faceDecodeID, {}, self, handler(self, function(self, pic, a)
                if (not tolua.isnull(headWrapper)) then
                    -- 判断是否使用黑白
                    local rawPic = pic:getChildByName("pic")
                    if (not data.userID  or data.userID == 0) then
                        rawPic:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
                    else
                        rawPic:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
                    end
                    view.__rawPic = rawPic
                    headWrapper:addChild(pic, 2)
                end
            end))
        end
    end
end

-- 更新按钮显示
function ApprenticeshipLayer:updateShowView()
    -- 毕业了但是还没领奖
    if (mvc.apprenticeshipModel:apprenticeIsGraduationRewardExist()) then
        self._mainButton:show()
        self._mainRedpoint:show()
        self._mentorAnchor:hide()
        self._appAnchor1:hide()
        self._appAnchor2:hide()
    -- 可以当导师了
    elseif (mvc.apprenticeshipModel:isMentorReqMet()) then
        -- 导师按钮
        self._mentorAnchor:hide()

        -- 主按钮
        local apprentriceArr = mvc.apprenticeshipModel:getApprenticeArr()
        if (#apprentriceArr < 2) then
            self._mainButton:show()
        else
            self._mainButton:hide()
        end

        -- 主按钮红点
        if (mvc.apprenticeshipModel:mentorIsMainButtonShowRedpoint()) then
            self._mainRedpoint:show()
        else
            self._mainRedpoint:hide()
        end
        
        -- 学徒按钮
        if (#apprentriceArr >= 2) then
            self._appAnchor1:show()
            self._appAnchor2:show()
        elseif (#apprentriceArr == 1) then
            self._appAnchor1:show()
            self._appAnchor2:hide()
        else
            self._appAnchor1:hide()
            self._appAnchor2:hide()
        end

        -- 更新交互按钮
        self:updateInteractButton()

        -- 学徒头像红点显示
        if (#apprentriceArr > 0 and mvc.apprenticeshipModel:mentorIsApprenticeShowRedpointByIndex(1)) then
            self._app1Redpoint:show()
        else
            self._app1Redpoint:hide()
        end
        if (#apprentriceArr > 1 and mvc.apprenticeshipModel:mentorIsApprenticeShowRedpointByIndex(2)) then
            self._app2Redpoint:show()
        else
            self._app2Redpoint:hide()
        end
    -- 可以当学徒了
    elseif (mvc.apprenticeshipModel:isApprenticeReqMet() or mvc.apprenticeshipModel:getMentor()) then
        -- 学徒按钮
        self._appAnchor1:hide()
        self._appAnchor2:hide()

        -- 主按钮, 导师按钮
        local mentor = mvc.apprenticeshipModel:getMentor()
        if (mentor) then
            self._mentorAnchor:show()
            self._mainButton:hide()

            -- 更新交互按钮
            self:updateInteractButton()

            -- 更新导师红点
            if (mvc.apprenticeshipModel:apprenticeIsMentorShowRedpoint()) then
                self._mentorRedpoint:show()
            else
                self._mentorRedpoint:hide()
            end
        else
            self._mentorAnchor:hide()
            self._mainButton:show()

            -- 更新学徒主按钮红点
            if (mvc.apprenticeshipModel:apprenticeIsMainButtonShowRedpoint()) then
                self._mainRedpoint:show()
            else
                self._mainRedpoint:hide()
            end
        end
    else
        -- 所有按钮
        self._mainButton:hide()
        self._mentorAnchor:hide()
        self._appAnchor1:hide()
        self._appAnchor2:hide()
    end
end

-- 刷新点赞按钮
function ApprenticeshipLayer:updateInteractButton()
    -- 显示导师方学徒1头上的交互领奖按钮
    local app1InteractReward, app1LastInteract = mvc.apprenticeshipModel:mentorIsAbleToGetInteractRewardByIndex(1)
    if (self._appAnchor1:isVisible() and app1InteractReward) then
        if (app1LastInteract == nil or app1LastInteract == mvc.apprenticeshipModel.INTERACT_TYPE.PRAISE) then
            self._app1KarmaBtn:setNormal("ui_mentor_icon_good_0.png")
            self._app1KarmaBtn:setSelected("ui_mentor_icon_good_1.png")
            self._app1KarmaBtn:setDisabled("ui_mentor_icon_good_0.png")
        else
            self._app1KarmaBtn:setNormal("ui_mentor_icon_lose_0.png")
            self._app1KarmaBtn:setSelected("ui_mentor_icon_lose_1.png")
            self._app1KarmaBtn:setDisabled("ui_mentor_icon_lose_0.png")
        end
        self._app1KarmaBtn:show()
    else
        self._app1KarmaBtn:hide()
    end

    -- 显示导师方学徒2头上的交互领奖按钮
    local app2InteractReward, app2LastInteract = mvc.apprenticeshipModel:mentorIsAbleToGetInteractRewardByIndex(2)
    if (self._appAnchor2:isVisible() and app2InteractReward) then
        if (app2LastInteract == nil or app2LastInteract == mvc.apprenticeshipModel.INTERACT_TYPE.PRAISE) then
            self._app2KarmaBtn:setNormal("ui_mentor_icon_good_0.png")
            self._app2KarmaBtn:setSelected("ui_mentor_icon_good_1.png")
            self._app2KarmaBtn:setDisabled("ui_mentor_icon_good_0.png")
        else
            self._app2KarmaBtn:setNormal("ui_mentor_icon_lose_0.png")
            self._app2KarmaBtn:setSelected("ui_mentor_icon_lose_1.png")
            self._app2KarmaBtn:setDisabled("ui_mentor_icon_lose_0.png")
        end
        self._app2KarmaBtn:show()
    else
        self._app2KarmaBtn:hide()
    end
end

-- 禁用所有按钮
function ApprenticeshipLayer:disableAllBtns()
    self._app1KarmaBtn:disable()
    self._app2KarmaBtn:disable()
    self._appAnchor1:setTouchEnable(false)
    self._appAnchor2:setTouchEnable(false)
    self._mentorAnchor:setTouchEnable(false)
    self._mainButton:disable()
end

-- 启用所有按钮
function ApprenticeshipLayer:enableAllBtns()
    self._app1KarmaBtn:enable()
    self._app2KarmaBtn:enable()
    self._appAnchor1:setTouchEnable(true)
    self._appAnchor2:setTouchEnable(true)
    self._mentorAnchor:setTouchEnable(true)
    self._mainButton:enable()
end

-- 注册监听事件
function ApprenticeshipLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_LEVEL_UP, self, self.onUpdateView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS, self, self.onUpdateView)
    Avalon.MessageCenter:bind(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_REDPOINTS, self, self.updateShowView) 
end

-- 注销监听事件
function ApprenticeshipLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_LEVEL_UP, self, self.onUpdateView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_BUTTONS, self, self.onUpdateView)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MENTOR_MESSAGE_UPDATE_REDPOINTS, self, self.updateShowView)
end

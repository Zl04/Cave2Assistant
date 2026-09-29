-- AnswerQuestionLayer.lua
-- Author:yhj
-- 2019年2月20日

local LanguageManager = require("app.game.LanguageManager")
local languageManagerIns = LanguageManager:getInstance()

UI = UI or {}
local AnswerQuestionLayer = class("AnswerQuestionLayer", UI.Component)
UI.AnswerQuestionLayer = AnswerQuestionLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

--资源列表(必备)
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_general_tips.plist",
    "ui_common_icon_item.plist",
}

local config = require "Resource.profiles.commonProfile.ProfileVac"
require "app.datas.AnswerDataManager"  
--构造函数(必备)
function AnswerQuestionLayer:ctor(answerData)
    AnswerQuestionLayer.super.ctor(
        self, 
        UIType.ANSWER_LAYER_UI,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0
    )
    self.answerData = answerData
--self.answerData = {qusetion={question = 1, answers={"MC_UI_JUMP_LAYER_ANSWER_REP",2,3}, target=3},wrongCount = 1,answerRemainMsec=GameManager:getNormalServerTime() + 1000}
  --  AnswerDataManager:initNetData(self.answerData )

    self:setTouchEnable(true)
    self:init()
    self:registerListener()

    --封锁移动
    GameManager:disableMovingHandler()
end

-- 注册监听事件
function AnswerQuestionLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_JUMP_LAYER_ANSWER_REP, self, self.doAnswerResponseHandler)
end


-- 注销监听事件
function AnswerQuestionLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_JUMP_LAYER_ANSWER_REP, self, self.doAnswerResponseHandler)
end


--虚构函数, destroy时调用(必备)
function AnswerQuestionLayer:dtor()
    AnswerQuestionLayer.super.dtor(self)
    self:unRegisterListener()
    Avalon.Scheduler:unscheduleUpdateOnce(self, self.scheduleUpdateTime)
    -- reload_script_file("app.ui.answerQuestion.AnswerQuestionLayer")

    --打开移动
    GameManager:enableMovingHandler() 
end
-- 初始化(必备)
function AnswerQuestionLayer:init()
    AnswerQuestionLayer.super.init(self)
end
function AnswerQuestionLayer:sendAnswerRequest(idx)
    Net.NetRoleSystem:requestFinishAnswers(self.answerData.qusetion.question, idx)
end
-- 模版函数：初始化组建的视图(必备)
function AnswerQuestionLayer:onInitView()
    -- 总板块
    self._rootLayer = UI.Component:create()
    self._rootLayer:init()
    self._rootLayer:setSize(482, 418)
    self._rootLayer:center()
    self:addChild(self._rootLayer)

    local questionData = self.answerData.qusetion
    self.sec = (self.answerData.answerRemainMsec - GameManager:getNormalServerTime())

    -- 背景
    self._bg = UI.Image:create()
    self._bg:init("ui_tips_banner_box2.png")
    self._bg:center()
    self:addChild(self._bg)
    self:setSize(self._bg:getSize())

    -- 答案
    local pos = {
        {32,132},
        {247,132},
        {32,77},
        {247,77},
        {32,22},
        {247,22}
    }

    local answers = questionData.answers
    local loopIdx = #answers >#pos and #pos or #answers
    for i = 1, loopIdx do
        local answerOption = UI.Button:create() 
        answerOption:init("ui_btn_language_0.png", "ui_btn_language_1.png", "ui_btn_yellow5_0.png")
        answerOption:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        local str = answers[i]
        local itemId = answers[i]
        if PublicDefine.QuestionType.QuestionType_Equipe == questionData.question then
            if itemId ~= 0  then
                local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
                if (goodsData) then
                    str = goodsData.name.. "(".. string.format(languageManagerIns:getLocalString(1111914)--[[%d级]], goodsData:getWearLV()).. ")"
                end
            else
                str = languageManagerIns:getLocalString(1111705)
            end
        end
        answerOption:setText(str.."")
        answerOption:leftBottom(pos[i][1],pos[i][2])
        self._bg:addChild(answerOption)
        local size = answerOption._text:getContentSize()
        if size.width > 200 then
            local scale = 198/size.width
            answerOption._text:setScale(scale)
        end
        answerOption:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:sendAnswerRequest(i)
        end)
    end
    

    local progress = UI.ProgressTimer:create()
    progress:init("ui_tips_banner_countdown_box.png",nil,"ui_tips_banner_countdown.png")
    progress:centerBottom(187)
    progress:setBarChangeAction(0,1, self.sec * 1000)
    self._bg:addChild(progress)


    local loadingText = UI.Text:create()
    loadingText:init(" ", UI.FONT_STANDARD, UI.FONT_SIZE_18X, UI.FONT_COLOR_255_247_202)
    loadingText:centerBottom(182)
    loadingText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(0, -2))
    self._bg:addChild(loadingText)
    self.loadingText = loadingText
    --{pk = 17827073, answerRemainMsec = 20000, nextAnswerMsec = 0, nextEnterCaveSec = 0, qusetion = {answers = {89, 189, 160, 49, 0}, question = 5}}
    -- QuestionType_Attr = 1; //属性(对应target为ATTR_TYPE)
    -- QuestionType_Equipe = 2; //装备(对应target为EQUIPMENT_TYPE)
    -- QuestionType_CaveLevel = 3; //洞窟层数
    -- QuestionType_AchievementPoint = 4; //成就点数
    -- QuestionType_Item = 5; //道具(对应target为道具ID)
    -- QuestionType_Firend = 6; //好友数量
    -- QuestionType_GuildMember = 7; //公会成员数量
    -- QuestionType_Resource = 8; //货币数量(对应target为货币ID)
    local subStr
    if questionData.target ~= 0 then
        if PublicDefine.QuestionType.QuestionType_Attr == questionData.question then
            subStr = ToolsUtil:attrNameToLanguageString(PublicDefine.ATTR_TYPE_ID_KEY[questionData.target])
        elseif PublicDefine.QuestionType.QuestionType_Equipe == questionData.question then
            subStr = AvalonUtil.getEquipmentTypeText(questionData.target)
        elseif PublicDefine.QuestionType.QuestionType_Item == questionData.question then
            local itemId = questionData.target
            local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
            subStr = goodsData.name
        elseif PublicDefine.QuestionType.QuestionType_Resource == questionData.question then
            local itemId = questionData.target
            local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
            subStr = goodsData.name
        end
    end
    local titleStrId = config[questionData.question].description
    local titleStr = languageManagerIns:getLocalString(titleStrId)
    if subStr then
        titleStr = string.format(titleStr, subStr)
    end

    local titleText = UI.Text:create()
    titleText:init(titleStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    titleText:setSize(366,122)
    titleText:centerBottom(287)
    titleText:setTextCenter()
    self._bg:addChild(titleText)

    local failureStr = languageManagerIns:getLocalString(1111700)
    if AnswerDataManager:isNextWrongToBlackRoom() then
        failureStr = languageManagerIns:getLocalString(1111701)
    end
    local answerStrDes1 = UI.Text:create()
    answerStrDes1:init(languageManagerIns:getLocalString(1111699) .. failureStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    answerStrDes1:setSize(366,40)
    answerStrDes1:centerBottom(224)
    answerStrDes1:setTextCenter()
    self._bg:addChild(answerStrDes1)



    local layout = UI.Layout:create()
    layout:init()
    layout:enableAutoWidth()
    layout:enableAutoHeight()
    layout:centerBottom(231)
    self._bg:addChild(layout)


    local answerStrDes = UI.Text:create()
    answerStrDes:init(languageManagerIns:getLocalString(1111698), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
    answerStrDes:floatLeft(0)
    layout:addComponent(answerStrDes)

    local isHaveReward = AnswerDataManager:hasAward()
    if isHaveReward then
        local iconName = UI.Image:create()
        iconName:init("icon_gold.png" )
        iconName:setScale(0.5)
        iconName:floatLeft(-35)
        layout:addComponent(iconName)

        local valDes = UI.Text:create()
        valDes:init(config[questionData.question].goodsRewardsNum .. "", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
        valDes:floatLeft(-27)
        layout:addComponent(valDes)
    else
        local valDes = UI.Text:create()
        valDes:init(languageManagerIns:getLocalString(1111835), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_80_5_5)
        valDes:floatLeft(5)
        layout:addComponent(valDes)
        layout:centerBottom(263)
    end

    self:scheduleUpdateTime()

    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function()
        if tolua.isnull(self) then
            return
        end
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ANSWER_IS_SHOWING, "")
     end, 0.5)
end

function AnswerQuestionLayer:scheduleUpdateTime()
    if self.sec > 0 then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.scheduleUpdateTime, 1)
        self.loadingText:setText(self.sec .. languageManagerIns:getLocalString(1111475))
    else
        self.loadingText:setText(" ")
    end
    self.sec = self.sec - 1
end


function AnswerQuestionLayer:doAnswerResponseHandler(data)
--     enum ResponseAnswerResult
-- {
--     ResponseAnswerResult_True = 1;//正确
--     ResponseAnswerResult_False = 2;//失败
--     ResponseAnswerResult_OutTime = 3;//超时
--     ResponseAnswerResult_Systemerr = 4;//系统错误
-- }


    self:removeFromParent(true)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_ANSWER_IS_CLOSED, "")
end


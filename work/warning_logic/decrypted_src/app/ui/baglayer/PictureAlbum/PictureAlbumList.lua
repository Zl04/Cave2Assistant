--[[
    --画册属性列表UI控件
]]

require "app.ui.Component"
UI = UI or {}
local LanguageManager = require("app.game.LanguageManager")
local PictureAlbumList = class("PictureAlbumList", UI.HWBtnComponent)
UI.PictureAlbumList = PictureAlbumList

local winSize = cc.Director:getInstance():getWinSize()
local DEBUG = false
local resList = {
}


function PictureAlbumList:ctor(width, height, cellId)
    PictureAlbumList.super.ctor(self, UIType.TASK_BAG_SINGLE_LIST, resList, width, height)
    -- self:enableDebugDraw()
    
end

function PictureAlbumList:dtor()
    PictureAlbumList.super.dtor(self)  
    self:unRegisterListener()
end

function PictureAlbumList:init(paID, paData, index)
    self._paID = paID
    self._paData = paData
    self._textList = {}
    self._attributeText = nil
    self._index = index or 1
    PictureAlbumList.super.init(self)
    

    self:registerListener()
end

function PictureAlbumList:onInitView()
    if self._index%2 == 1 then
        local atBg = UI.Image:create() 
        atBg:init("ui_picturealbum_bg.png")
        atBg:center()
        self:addChild(atBg)
    end

    local smaller = UI.Image:create()
    smaller:init("ui_picturealbum_point.png")
    smaller:setAnchorPoint(0, 0.5)
    smaller:centerLeft(16)
    self:addChild(smaller)

    local desText = UI.Text:create()
    desText:init(LanguageManager:getInstance():getLocalString(self._paData.name), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_40_40_45)
    desText:centerLeft(18 + 15)
    desText:setFixLineWidth(350)
    
    self:addChild(desText)


    local taskDescribe = self._paData.taskDescribe
    local attributeText = UI.Text:create()
    local textColor = UI.FONT_COLOR_40_40_45
    attributeText:init(LanguageManager:getInstance():getLocalString(taskDescribe), UI.FONT_BOLD, UI.FONT_SIZE_18PX, textColor)
    attributeText:centerLeft(385 + 15)
    self:addChild(attributeText)

    -- self._textList[self._paData.ID] = {}
    -- self._textList[self._paData.ID].text = attributeText
    self._attributeText = attributeText

end

function PictureAlbumList:onUpdateView()

    --新属性特效表现(略)
    if PictureAlbumManager:canPlayAttriAnimation(self._paID,self._paData.ID) then
        local delayAction = cc.DelayTime:create(0.8)
        self:runAction(cc.Sequence:create(delayAction, cc.CallFunc:create(function()
            --播放特效
            local upSpine = UI.Animation:create()
            upSpine:init("effect_ui_picturealbum_noteunlock.json", "effect_ui_picturealbum_noteunlock.atlas", 1);
            upSpine:centerLeft(385 + 140 * 0.8)
            upSpine:setScaleX(0.8)
            self:addChild(upSpine)
            upSpine:setAnimation("noteunlock", false)

            upSpine:addEventListener(UIEvent.ANIMATION_EVENT,self,function(_, event, sender)
                if(event and event.eventData and event.eventData.name) then
                    local startPos = string.find(event.eventData.name, "sound_")
                    if(startPos ~= nil) then
                        -- 播放音效文件
                        local soundFilename = string.sub(event.eventData.name,7,-1)
                        Avalon.AudioManager:playSound(soundFilename, false)
                    end
                end
            end)

            self._attributeText:setFontColor(UI.FONT_COLOR_219_184_121)
        end)))

    elseif PictureAlbumManager:pictureEntryActivation(self._paID,self._paData.ID) then
        self._attributeText:setFontColor(UI.FONT_COLOR_219_184_121)
    end


    --直接删除红点信息
    PictureAlbumManager:removePictureAttriRedData(self._paID, self._paData.ID)
    
    -- for k,v in pairs(self._textList) do
    --     --这里应该剔除需要表现的
    --     if PictureAlbumManager:pictureEntryActivation(self._paID,k) then
    --         v.text:setFontColor(UI.FONT_COLOR_219_184_121)
    --     end
    -- end
end



-- 注册监听事件(可选)
function PictureAlbumList:registerListener()
    --更新图册界面视图
    Avalon.MessageCenter:bind(AvalonMessage.MC_PICTURE_ALBUM, self, self.onUpdateView)
end


-- 注销监听事件(可选)
function PictureAlbumList:unRegisterListener()
    --更新图册界面视图
    Avalon.MessageCenter:unbind(AvalonMessage.MC_PICTURE_ALBUM, self, self.onUpdateView)
end